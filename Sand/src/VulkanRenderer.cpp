#include "VulkanRenderer.hpp"
#include "ConfigSchema.hpp"
#include "AssetPaths.hpp"
#include "Storage.hpp"
#include "FrameLoop.hpp"
#include "CursorRay.hpp"
#include "SimStats.hpp"
#include <iostream>
#include <fstream>
#include <stdexcept>
#include <algorithm>
#include <cstring>
#include <cfloat>
// std::sin/cos/sqrt in the camera basis and the mouse ray. This arrived transitively before --
// UIManager.hpp used to include vulkan.h, and MSVC's headers pull <cmath> in behind it -- so the
// omission only surfaced once the UI stopped naming a graphics API. libc++, which is what a web
// build compiles against, does not forward it either.
#include <cmath>


// Constructor: Initializes the managed architecture instances
VulkanRenderer::VulkanRenderer() {
    // Resolved once and kept, so a later save cannot pick a different file from the one that was
    // loaded -- reading the copy beside the executable and writing one into the working directory
    // would look exactly like settings silently failing to stick.
    configPath = resolveAssetPath("config.txt");
    // No-op on the desktop. On a platform whose filesystem does not outlive the session, this puts
    // the previously saved copy back before it is read -- so it has to happen between resolving
    // the path and loading it, and nowhere else.
    Storage::prime(configPath);
    config = loadConfig(configPath);
    window = std::make_unique<Window>(1600, 1200, "3D Falling Sand Compute");
    context = std::make_unique<VulkanContext>(window.get());
}

// run: Coordinates initialization, the main loop, and cleanup
void VulkanRenderer::run() {
    initVulkan();
    mainLoop();
    cleanup();
}

// initVulkan: Defines the strict initialization order for the graphics API
void VulkanRenderer::initVulkan() {
    swapchain = std::make_unique<VulkanSwapchain>(context.get());

    createWorldBuffers();

    // std140 rounds a uniform block up to a multiple of 16 bytes, so the bound range has to cover
    // that padded size even though only sizeof(TuningParams) bytes are ever written.
    tuningBuffer = std::make_unique<VulkanBuffer>(
        context.get(),
        (sizeof(TuningParams) + 15) & ~static_cast<VkDeviceSize>(15),
        VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT,
        VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT
    );

    uploadTuning();

    window->setWorldExtents((float)config.tuning.gridWidth,
                            (float)config.tuning.gridHeight,
                            (float)config.tuning.gridDepth);

    seedParticles();

    // Initialize Pipeline after swapchain and buffer definitions
    pipeline = std::make_unique<VulkanPipeline>(context.get(), swapchain.get());

    createFramebuffers();

    createDescriptorSet();
    createCommandPoolAndBuffer();
    createSyncObjects();
    createTimestampPool();

    VkDescriptorPoolSize pool_sizes[] = {
        { VK_DESCRIPTOR_TYPE_SAMPLER, 1000 },
        { VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER, 1000 },
        { VK_DESCRIPTOR_TYPE_SAMPLED_IMAGE, 1000 },
        { VK_DESCRIPTOR_TYPE_STORAGE_IMAGE, 1000 },
        { VK_DESCRIPTOR_TYPE_UNIFORM_TEXEL_BUFFER, 1000 },
        { VK_DESCRIPTOR_TYPE_STORAGE_TEXEL_BUFFER, 1000 },
        { VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER, 1000 },
        { VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, 1000 },
        { VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC, 1000 },
        { VK_DESCRIPTOR_TYPE_STORAGE_BUFFER_DYNAMIC, 1000 },
        { VK_DESCRIPTOR_TYPE_INPUT_ATTACHMENT, 1000 }
    };

    VkDescriptorPoolCreateInfo pool_info = {};
    pool_info.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
    pool_info.flags = VK_DESCRIPTOR_POOL_CREATE_FREE_DESCRIPTOR_SET_BIT;
    pool_info.maxSets = 1000;
    pool_info.poolSizeCount = (uint32_t)std::size(pool_sizes);
    pool_info.pPoolSizes = pool_sizes;

    if (vkCreateDescriptorPool(context->getDevice(), &pool_info, nullptr, &imguiDescriptorPool) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create ImGui descriptor pool!");
    }

    // Context first, then the backend: ImGui_ImplVulkan_Init writes into the context, so the order
    // is load-bearing rather than stylistic.
    uiManager.init();

    UiBackendVulkan::InitInfo uiInit;
    uiInit.window         = window->getGLFWwindow();
    uiInit.instance       = context->getInstance();
    uiInit.physicalDevice = context->getPhysicalDevice();
    uiInit.device         = context->getDevice();
    uiInit.graphicsQueue  = context->getComputeQueue();
    uiInit.queueFamily    = context->getComputeQueueFamily();
    uiInit.descriptorPool = imguiDescriptorPool;
    uiInit.renderPass     = pipeline->getRenderPass();
    uiInit.minImageCount  = 2;
    uiInit.imageCount     = static_cast<uint32_t>(swapchain->getImageViews().size());
    UiBackendVulkan::init(uiInit);

    // So the options screen opens showing what is actually running.
    uiManager.setTuning(config.tuning);
}

// uploadTuning: pushes the current config into the UBO both shaders read.
//
// This used to be a one-off at startup, on the reasoning that config never changed at runtime. The
// options screen is exactly that changing, and for all but one of the tunables it is the entire
// cost of applying them -- the shaders read every value out of this buffer on the tick after it is
// written, with nothing to rebuild.
void VulkanRenderer::uploadTuning() {
    void* tuningData = tuningBuffer->mapMemory();
    memcpy(tuningData, &config.tuning, sizeof(TuningParams));
    tuningBuffer->unmapMemory();
}

// applyOptions: takes the options screen's edited copy and makes it the config the simulation runs on.
//
// This is a reload, not a live patch, and it always ends with an empty world and the camera back at
// its framing pose. Most tunables would not strictly need that -- the shaders read them out of a
// uniform buffer every tick, so rewriting it is the whole of the change -- but a world that is
// halfway through running under the OLD numbers is not a fair test of the new ones. Soil that was
// wet because rain used to be heavier, or a forest grown at a spread rate you have just halved, both
// keep answering the old question. Clearing makes the change mean what it says.
//
// The wipe is the direct one seedParticles does, not the purge black hole the Clear Grid button
// drops. The purge is a spectacle that takes seconds to swallow the world; applying settings should
// simply have applied them by the time the button comes back up.
//
// Grid size is still the one change that goes further, because it sizes the two storage buffers --
// and resizing those means new VkBuffer handles and a descriptor set still pointing at the old ones.
void VulkanRenderer::applyOptions(const TuningParams& requested) {
    // Everything below either destroys a buffer the GPU may still be reading or rewrites a
    // descriptor pointing at one. Neither is safe while work is in flight.
    vkDeviceWaitIdle(context->getDevice());

    TuningParams next = requested;

    // "Derive the march budget from the world size" is stored as a resolved number rather than as a
    // flag, so a world that grows has to have it re-derived or the extra distance goes unrendered --
    // the exact failure that used to crop the far half of a large world. If it still matches what
    // the old size derived, the intent was auto, so re-derive it for the new one.
    const bool wasAuto = (requested.marchMaxSteps == autoMarchSteps(config.tuning));
    applyWorldShape(next, next.gridWidth);
    if (wasAuto) next.marchMaxSteps = autoMarchSteps(next);

    // The same bars a value read from the file has to clear. A slider cannot produce most of these
    // violations, but Defaults-then-edit and a hand-edited file that was loaded earlier both can.
    sanitizeTuning(next);

    const bool shapeChanged = (next.gridWidth != config.tuning.gridWidth);
    config.tuning = next;

    if (shapeChanged) {
        createWorldBuffers();   // the old buffers are freed by the unique_ptr assignment
        writeDescriptorSet();   // ...which is exactly why the descriptors must be rewritten

        // Tells the camera how big the world is now. It reframes as a side effect, which the
        // unconditional reset below would do anyway -- but the extents themselves have to be set
        // here or the default pose would still be framed against the old size.
        window->setWorldExtents((float)config.tuning.gridWidth,
                                (float)config.tuning.gridHeight,
                                (float)config.tuning.gridDepth);
    }

    // The hard reset, on every apply rather than only on a resize. seedParticles zeroes the grid and
    // the whole stats block with it, so the water level, the rain state machine, the cloud charge and
    // the black hole table all start from nothing too -- none of which would be true of a world that
    // had merely had its tunables swapped underneath it.
    seedParticles();
    window->resetCamera();

    uploadTuning();
    if (saveConfig(configPath, config)) {
        // Second half of the same act on a platform where writing a file is not the end of it.
        // Reported rather than ignored: "applied but will not survive a reload" is a different
        // thing to tell someone than "applied".
        if (!Storage::persist(configPath)) {
            std::cout << "  (settings applied, but could not be stored for next launch)\n";
        }
    }
    uiManager.setTuning(config.tuning);

    std::cout << "Options applied; world cleared at " << config.tuning.gridWidth << "^3"
              << (shapeChanged ? " (buffers reallocated).\n" : ".\n");
}

// createWorldBuffers: allocates the two buffers whose size depends on the world's dimensions.
//
// Split out of initVulkan because changing the grid size from the options screen has to redo exactly
// this and nothing else. Anything that reproduced it by hand would be a second copy of the sizing
// rules, and the two would drift.
void VulkanRenderer::createWorldBuffers() {
    // Grid: a flat array of uint32_t, matching the packed voxel representation.
    // NOTE: sized as a flat array of uint32_t, matching the packed voxel representation
    // actually read/written by falling_sand.comp and raymarch.frag (see pack()/getType()/etc).
    VkDeviceSize bufferSize = sizeof(uint32_t) * voxelCount();
    ssboBuffer = std::make_unique<VulkanBuffer>(
        context.get(),
        bufferSize,
        VK_BUFFER_USAGE_STORAGE_BUFFER_BIT,
        VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT
    );

    // Shared simulation stats: 9 cloud/water scalars (waterVoxelCount, waterHighMark,
    // cloudWaterCount, rainPhase, rainPhaseTimeBits, rainTargetLevel, rainCandidateCount,
    // rainCandidateEstimate, cloudChargeBits), then maxOccupiedY and the black hole table
    // (blackHoleCount plus SimStats::kBlackHoleMax slots), then the per-cloud placement cache. Must stay in
    // sync with the SimStats block in falling_sand.comp and raymarch.frag.
    // Bound at binding 1, shared by compute and fragment.
    steamCounterBuffer = std::make_unique<VulkanBuffer>(
        context.get(),
        sizeof(uint32_t) * SimStats::kFieldCount,
        VK_BUFFER_USAGE_STORAGE_BUFFER_BIT,
        VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT
    );

}

// frame: one frame's work, start to finish.
//
// Split out of the loop that used to hold it so the loop itself can be owned by the platform --
// see FrameLoop. Nothing here changed in the move; it is the same body between the same braces.
void VulkanRenderer::frame() {
    // Everything between here and the end of drawFrame is one frame's CPU work: event polling,
    // building the UI, the mouse raycast, and recording the command buffer. drawFrame reports
    // back how much of that span it spent blocked on the GPU, which is subtracted below.
    const auto frameStart = std::chrono::high_resolution_clock::now();

    window->pollEvents();

    uiManager.buildUI();

    bool captureMouse = uiManager.wantsCaptureMouse();
    bool captureKeyboard = uiManager.wantsCaptureKeyboard();

    window->processInput(captureMouse, captureKeyboard);

    drawFrame();

    const double wallMs = std::chrono::duration<double, std::milli>(
        std::chrono::high_resolution_clock::now() - frameStart).count();

    // buildUI runs at the TOP of the frame, so the figures it draws are the previous frame's.
    // That is one frame of lag on a graph of the last minute, and the alternative -- reordering
    // the frame so the UI is built after the work it describes -- would push the UI's own vertex
    // upload a frame out of step with the command buffer that draws it.
    uiManager.setFrameTimings(float(std::max(0.0, wallMs - gpuBlockedMs)),
                              lastComputeMs, lastRaymarchMs, timestampsSupported);
}

// mainLoop: Continues rendering frames until the window is closed
void VulkanRenderer::mainLoop() {
    FrameLoop::run([this] { return !window->shouldClose(); },
                   [this] { frame(); });
    vkDeviceWaitIdle(context->getDevice());
}

// cleanup: Destroys Vulkan resources in reverse order of creation
void VulkanRenderer::cleanup() {
    vkDeviceWaitIdle(context->getDevice());

    // The device is already idle -- vkDeviceWaitIdle above -- which is what makes it safe to pull
    // the backend's buffers out from under it here.
    UiBackend::shutdown();
    uiManager.shutdownUi();
    vkDestroyDescriptorPool(context->getDevice(), imguiDescriptorPool, nullptr);

    vkDestroySemaphore(context->getDevice(), renderFinishedSemaphore, nullptr);
    vkDestroySemaphore(context->getDevice(), imageAvailableSemaphore, nullptr);
    vkDestroyFence(context->getDevice(), inFlightFence, nullptr);

    for (auto framebuffer : swapchainFramebuffers) {
        vkDestroyFramebuffer(context->getDevice(), framebuffer, nullptr);
    }

    // Explicitly destroy the wrapped objects before the context is destroyed automatically
    pipeline.reset();
    swapchain.reset();

    if (timestampPool != VK_NULL_HANDLE) vkDestroyQueryPool(context->getDevice(), timestampPool, nullptr);

    vkDestroyCommandPool(context->getDevice(), commandPool, nullptr);
    vkDestroyDescriptorPool(context->getDevice(), descriptorPool, nullptr);

    // Frees VRAM automatically via the VulkanBuffer destructor
    ssboBuffer.reset();
    steamCounterBuffer.reset();
    tuningBuffer.reset();
}

// seedParticles: Initializes the voxel grid with empty space via a CPU-mapped pointer,
// and resets the cloud/water tracking stats buffer alongside it.
void VulkanRenderer::seedParticles() {
    size_t totalVoxels = voxelCount();
    void* data = ssboBuffer->mapMemory();
    memset(data, 0, sizeof(uint32_t) * totalVoxels);
    ssboBuffer->unmapMemory();

    // Every SimStats field starts at 0, including cloudChargeBits -- a zero bit pattern is
    // +0.0f as a float, so the sky correctly starts completely uncharged with no sentinel needed.
    // Zero is also the "free slot" marker for the black hole table, so clearing the grid correctly
    // forgets every hole that was in it.
    std::vector<uint32_t> statsInit(SimStats::kFieldCount, 0u);

    // maxOccupiedY is the exception: it starts at the roof rather than at zero. Over-reporting it is
    // always safe (the renderer just marches sky that turns out to be empty) while under-reporting
    // hides matter, and the compute shader only walks it down one voxel per dispatch. Starting high
    // means the very first frame is drawn unclipped instead of being cropped to the floor until the
    // first dispatch has had a chance to publish.
    statsInit[SimStats::kMaxY] = config.tuning.gridHeight;

    void* counterData = steamCounterBuffer->mapMemory();
    memcpy(counterData, statsInit.data(), sizeof(uint32_t) * statsInit.size());
    steamCounterBuffer->unmapMemory();

    std::cout << "Seeded initial empty grid to GPU!\n";
}

// voxelCount: total cells in the configured world. Everything that sizes against the grid goes
// through here rather than recomputing the product, so a 2D world allocates one layer and not a cube.
size_t VulkanRenderer::voxelCount() const {
    return (size_t)config.tuning.gridWidth * config.tuning.gridHeight * config.tuning.gridDepth;
}

// beginPurge: What "Clear Grid" does now. Resets the sky immediately, then drops one enormous black
// hole at the centre of the grid and lets it eat everything.
//
// Safe to touch the buffers directly from here: the caller has already waited on the frame fence, so
// the GPU is idle, which is the same guarantee seedParticles relies on.
//
// Nothing here schedules the ending. The hole is flagged SimStats::kPurge and the simulation's existing
// starvation path does the rest -- a hole that catches nothing shrinks and deletes itself, which is
// already exactly the behaviour wanted, just with a shorter fuse and a faster burn.
void VulkanRenderer::beginPurge() {
    uint32_t* stats = static_cast<uint32_t*>(steamCounterBuffer->mapMemory());
    uint32_t* grid = static_cast<uint32_t*>(ssboBuffer->mapMemory());

    // Any hole already in the table is removed first, voxel as well as slot. Black holes are the one
    // thing the purge hole cannot eat -- capture skips type 7 so they would otherwise sit untouched
    // through a Clear Grid and be the only survivors.
    for (uint32_t i = 0; i < SimStats::kBlackHoleMax; i++) {
        uint32_t code = stats[SimStats::kHoles + i];
        if (code != 0u) grid[code & SimStats::kIndexMask] = 0u;
        stats[SimStats::kHoles + i] = 0u;
        stats[SimStats::kMass + i] = 0u;
        stats[SimStats::kStarve + i] = 0u;
    }

    // Sky back to base. Zeroing waterHighMark here matters beyond tidiness: the purge is about to
    // destroy every water voxel in the world, and a high mark left standing would read as an
    // enormous permanent deficit afterwards and open a storm over an empty grid.
    for (uint32_t i = 0; i < SimStats::kCloudScalarCount; i++) stats[i] = 0u;

    const uint32_t w = config.tuning.gridWidth, h = config.tuning.gridHeight, d = config.tuning.gridDepth;
    const uint32_t centre = (w / 2) + (h / 2) * w + (d / 2) * w * h;
    grid[centre] = 7u; // pack(BlackHole, 0, 0, 0)

    stats[SimStats::kHoles] = SimStats::kActive | SimStats::kPurge | centre;
    stats[SimStats::kMass] = config.tuning.purgeMass;
    stats[SimStats::kStarve] = 0u;
    stats[SimStats::kCount] = 1u;

    // The purge hole is written straight into the grid from here, so it never passes through the
    // dispatch that would normally publish its height. Raising the ceiling to match means its body
    // is not clipped away on the frame it appears.
    stats[SimStats::kMaxY] = std::max(stats[SimStats::kMaxY], h / 2);

    ssboBuffer->unmapMemory();
    steamCounterBuffer->unmapMemory();

    std::cout << "Purge started: one black hole at the centre, eating the world.\n";
}

// createFramebuffers: Connects swapchain image views to the render pass format
void VulkanRenderer::createFramebuffers() {
    const auto& imageViews = swapchain->getImageViews();
    swapchainFramebuffers.resize(imageViews.size());

    for (size_t i = 0; i < imageViews.size(); i++) {
        VkImageView attachments[] = { imageViews[i] };

        VkFramebufferCreateInfo framebufferInfo{};
        framebufferInfo.sType = VK_STRUCTURE_TYPE_FRAMEBUFFER_CREATE_INFO;
        framebufferInfo.renderPass = pipeline->getRenderPass();
        framebufferInfo.attachmentCount = 1;
        framebufferInfo.pAttachments = attachments;
        framebufferInfo.width = swapchain->getExtent().width;
        framebufferInfo.height = swapchain->getExtent().height;
        framebufferInfo.layers = 1;

        if (vkCreateFramebuffer(context->getDevice(), &framebufferInfo, nullptr, &swapchainFramebuffers[i]) != VK_SUCCESS) {
            throw std::runtime_error("Failed to create framebuffer!");
        }
    }
}

// createDescriptorSet: Allocates the descriptor pool and binds the SSBO buffer and the
// cloud/water stats buffer to the layout
void VulkanRenderer::createDescriptorSet() {
    VkDescriptorPoolSize poolSizes[2]{};
    poolSizes[0].type = VK_DESCRIPTOR_TYPE_STORAGE_BUFFER;
    poolSizes[0].descriptorCount = 2; // grid + cloud/water stats
    poolSizes[1].type = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;
    poolSizes[1].descriptorCount = 1; // tuning params

    VkDescriptorPoolCreateInfo poolInfo{};
    poolInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_POOL_CREATE_INFO;
    poolInfo.poolSizeCount = 2;
    poolInfo.pPoolSizes = poolSizes;
    poolInfo.maxSets = 1;

    if (vkCreateDescriptorPool(context->getDevice(), &poolInfo, nullptr, &descriptorPool) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create descriptor pool!");
    }

    VkDescriptorSetAllocateInfo allocInfo{};
    allocInfo.sType = VK_STRUCTURE_TYPE_DESCRIPTOR_SET_ALLOCATE_INFO;
    allocInfo.descriptorPool = descriptorPool;
    allocInfo.descriptorSetCount = 1;

    VkDescriptorSetLayout layout = pipeline->getDescriptorSetLayout();
    allocInfo.pSetLayouts = &layout;

    if (vkAllocateDescriptorSets(context->getDevice(), &allocInfo, &descriptorSet) != VK_SUCCESS) {
        throw std::runtime_error("Failed to allocate descriptor set!");
    }

    writeDescriptorSet();
}

// writeDescriptorSet: points the set at the buffers as they are right now.
//
// Separate from allocation because recreating a buffer gives it a new VkBuffer handle, and a
// descriptor still holding the old one is a dangling reference the validation layers will not catch
// until the shader reads garbage.
void VulkanRenderer::writeDescriptorSet() {
    VkDescriptorBufferInfo bufferInfo{};
    bufferInfo.buffer = ssboBuffer->getBuffer();
    bufferInfo.offset = 0;
    bufferInfo.range = VK_WHOLE_SIZE;

    VkDescriptorBufferInfo counterBufferInfo{};
    counterBufferInfo.buffer = steamCounterBuffer->getBuffer();
    counterBufferInfo.offset = 0;
    counterBufferInfo.range = VK_WHOLE_SIZE;

    VkDescriptorBufferInfo tuningBufferInfo{};
    tuningBufferInfo.buffer = tuningBuffer->getBuffer();
    tuningBufferInfo.offset = 0;
    tuningBufferInfo.range = VK_WHOLE_SIZE;

    VkWriteDescriptorSet writes[3]{};
    writes[0].sType = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
    writes[0].dstSet = descriptorSet;
    writes[0].dstBinding = 0;
    writes[0].descriptorType = VK_DESCRIPTOR_TYPE_STORAGE_BUFFER;
    writes[0].descriptorCount = 1;
    writes[0].pBufferInfo = &bufferInfo;

    writes[1].sType = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
    writes[1].dstSet = descriptorSet;
    writes[1].dstBinding = 1;
    writes[1].descriptorType = VK_DESCRIPTOR_TYPE_STORAGE_BUFFER;
    writes[1].descriptorCount = 1;
    writes[1].pBufferInfo = &counterBufferInfo;

    writes[2].sType = VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
    writes[2].dstSet = descriptorSet;
    writes[2].dstBinding = 2;
    writes[2].descriptorType = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER;
    writes[2].descriptorCount = 1;
    writes[2].pBufferInfo = &tuningBufferInfo;

    vkUpdateDescriptorSets(context->getDevice(), 3, writes, 0, nullptr);
}

// createCommandPoolAndBuffer: Prepares the command buffer for recording rendering and compute commands
void VulkanRenderer::createCommandPoolAndBuffer() {
    VkCommandPoolCreateInfo poolInfo{};
    poolInfo.sType = VK_STRUCTURE_TYPE_COMMAND_POOL_CREATE_INFO;
    poolInfo.flags = VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT;
    poolInfo.queueFamilyIndex = context->getComputeQueueFamily();

    if (vkCreateCommandPool(context->getDevice(), &poolInfo, nullptr, &commandPool) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create command pool!");
    }

    VkCommandBufferAllocateInfo allocInfo{};
    allocInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_ALLOCATE_INFO;
    allocInfo.commandPool = commandPool;
    allocInfo.level = VK_COMMAND_BUFFER_LEVEL_PRIMARY;
    allocInfo.commandBufferCount = 1;

    if (vkAllocateCommandBuffers(context->getDevice(), &allocInfo, &commandBuffer) != VK_SUCCESS) {
        throw std::runtime_error("Failed to allocate command buffer!");
    }
}

// createSyncObjects: Initializes the semaphores and fences used for CPU/GPU synchronization
void VulkanRenderer::createSyncObjects() {
    VkSemaphoreCreateInfo semaphoreInfo{};
    semaphoreInfo.sType = VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO;

    VkFenceCreateInfo fenceInfo{};
    fenceInfo.sType = VK_STRUCTURE_TYPE_FENCE_CREATE_INFO;
    fenceInfo.flags = VK_FENCE_CREATE_SIGNALED_BIT;

    if (vkCreateSemaphore(context->getDevice(), &semaphoreInfo, nullptr, &imageAvailableSemaphore) != VK_SUCCESS ||
        vkCreateSemaphore(context->getDevice(), &semaphoreInfo, nullptr, &renderFinishedSemaphore) != VK_SUCCESS ||
        vkCreateFence(context->getDevice(), &fenceInfo, nullptr, &inFlightFence) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create synchronization objects!");
    }
}

// createTimestampPool: Allocates the query pool the frame breakdown is measured with.
//
// Timestamps are an optional capability twice over: the device reports how many bits of a timestamp
// are meaningful, and it reports that PER QUEUE FAMILY. A family with 0 valid bits accepts the write
// commands and returns garbage, so the check has to happen here rather than being assumed -- if it
// fails, the GPU rows are simply not reported and the CPU row still works.
void VulkanRenderer::createTimestampPool() {
    VkPhysicalDeviceProperties props{};
    vkGetPhysicalDeviceProperties(context->getPhysicalDevice(), &props);
    timestampPeriodNs = props.limits.timestampPeriod;

    uint32_t familyCount = 0;
    vkGetPhysicalDeviceQueueFamilyProperties(context->getPhysicalDevice(), &familyCount, nullptr);
    std::vector<VkQueueFamilyProperties> families(familyCount);
    vkGetPhysicalDeviceQueueFamilyProperties(context->getPhysicalDevice(), &familyCount, families.data());

    const uint32_t family = context->getComputeQueueFamily();
    const bool familyCanTimestamp = family < familyCount && families[family].timestampValidBits > 0;

    if (timestampPeriodNs <= 0.0f || !familyCanTimestamp) {
        std::cout << "GPU timestamps unavailable on this queue; the profiler will show CPU time only.\n";
        return;
    }

    VkQueryPoolCreateInfo info{};
    info.sType = VK_STRUCTURE_TYPE_QUERY_POOL_CREATE_INFO;
    info.queryType = VK_QUERY_TYPE_TIMESTAMP;
    info.queryCount = kTimestampCount;

    if (vkCreateQueryPool(context->getDevice(), &info, nullptr, &timestampPool) != VK_SUCCESS) {
        std::cout << "Failed to create the timestamp query pool; the profiler will show CPU time only.\n";
        return;
    }

    timestampsSupported = true;
}

// readGpuTimestamps: Turns the previous frame's three ticks into two millisecond figures.
//
// Called straight after the fence wait, which is the point at which the queries are guaranteed
// complete -- so this never blocks and never needs WITH_AVAILABILITY polling. WAIT_BIT is still
// passed as a correctness backstop rather than as the mechanism.
void VulkanRenderer::readGpuTimestamps() {
    if (!timestampsSupported || !timestampsPending) return;
    timestampsPending = false;

    uint64_t ticks[kTimestampCount] = {};
    VkResult result = vkGetQueryPoolResults(
        context->getDevice(), timestampPool, 0, kTimestampCount,
        sizeof(ticks), ticks, sizeof(uint64_t),
        VK_QUERY_RESULT_64_BIT | VK_QUERY_RESULT_WAIT_BIT);

    if (result != VK_SUCCESS) return;

    // Guarded rather than assumed: a timestamp counter can wrap, and an unsigned wrap would turn a
    // sub-millisecond phase into a several-thousand-year one and wreck the graph's scale.
    const float toMs = timestampPeriodNs * 1e-6f;
    if (ticks[1] >= ticks[0]) lastComputeMs = float(ticks[1] - ticks[0]) * toMs;
    if (ticks[2] >= ticks[1]) lastRaymarchMs = float(ticks[2] - ticks[1]) * toMs;
}

// drawFrame: Synchronizes execution, records the command buffer, triggers physics compute, and renders
void VulkanRenderer::drawFrame() {
    // The fence wait and the image acquire are the two places the CPU parks waiting on something
    // else. Both are timed and subtracted from the frame's wall clock below, so what is left is the
    // CPU's own work.
    const auto waitStart = std::chrono::high_resolution_clock::now();
    vkWaitForFences(context->getDevice(), 1, &inFlightFence, VK_TRUE, UINT64_MAX);
    gpuBlockedMs = std::chrono::duration<double, std::milli>(
        std::chrono::high_resolution_clock::now() - waitStart).count();

    readGpuTimestamps();

    vkResetFences(context->getDevice(), 1, &inFlightFence);

    // Intercept a UI reset command. Since the Fence confirms the GPU is done reading the SSBO,
    // we can safely execute a memory wipe from the CPU before passing the SSBO back to the compute shader.
    if (uiManager.consumeResetRequest()) {
        beginPurge();
    }

    // Same point as the purge above, and for the same reason: the fence has confirmed the GPU is
    // finished with the buffers, which is what makes it safe to touch them from here.
    if (uiManager.consumeApplyOptions()) {
        applyOptions(uiManager.pendingTuning());
    }

    if (uiManager.consumeCameraResetRequest()) {
        window->resetCamera();
    }

    uint32_t imageIndex;
    const auto acquireStart = std::chrono::high_resolution_clock::now();
    vkAcquireNextImageKHR(context->getDevice(), swapchain->getSwapchain(), UINT64_MAX, imageAvailableSemaphore, VK_NULL_HANDLE, &imageIndex);
    gpuBlockedMs += std::chrono::duration<double, std::milli>(
        std::chrono::high_resolution_clock::now() - acquireStart).count();

    vkResetCommandBuffer(commandBuffer, 0);

    VkCommandBufferBeginInfo beginInfo{};
    beginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
    vkBeginCommandBuffer(commandBuffer, &beginInfo);

    // Queries must be reset outside a render pass, and one of the three is written inside one, so
    // the reset goes here at the top of the buffer rather than next to its writes.
    if (timestampsSupported) {
        vkCmdResetQueryPool(commandBuffer, timestampPool, 0, kTimestampCount);
        // BOTTOM_OF_PIPE throughout: the tick is recorded once everything submitted ahead of it has
        // finished, which is what makes a pair of them an elapsed time rather than a queue position.
        vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT, timestampPool, 0);
    }

    // Bind pipeline and descriptor sets once for the compute loop
    vkCmdBindPipeline(commandBuffer, VK_PIPELINE_BIND_POINT_COMPUTE, pipeline->getComputePipeline());
    vkCmdBindDescriptorSets(commandBuffer, VK_PIPELINE_BIND_POINT_COMPUTE, pipeline->getComputePipelineLayout(), 0, 1, &descriptorSet, 0, nullptr);

    // The camera basis, the cursor raycast and the brush bounds all live in CursorRay now: they
    // are pure maths that the web renderer needs identically, and a second copy would be a second
    // thing to keep in step with raymarch.frag -- which neither copy can see.
    PushConstants pc{};
    buildFrameConstants(*window, uiManager, config.tuning, (float)glfwGetTime(), pc);

    // --- MULTI-STEP PHYSICS DISPATCH ---
    int simSteps = uiManager.getSimulationSpeed();
    for (int step = 0; step < simSteps; step++) {
        // We dispatch the compute shader multiple times, allowing it to run physics multiple times per visual frame
        vkCmdPushConstants(commandBuffer, pipeline->getComputePipelineLayout(), VK_SHADER_STAGE_COMPUTE_BIT | VK_SHADER_STAGE_FRAGMENT_BIT, 0, sizeof(PushConstants), &pc);
        // Rounded up, so a grid size that is not a multiple of the workgroup still covers its last
        // partial workgroup. main() drops the overshoot before it touches the grid.
        //
        // Z divides by 4 rather than 8: the workgroup is 8x8x4 so that it stays within WebGPU's
        // 256-invocation limit. These two numbers are a pair -- change local_size_z in
        // falling_sand.comp without changing this and the top of the world stops being simulated,
        // silently and only on tall grids.
        vkCmdDispatch(commandBuffer,
            (config.tuning.gridWidth + 7) / 8,
            (config.tuning.gridHeight + 7) / 8,
            (config.tuning.gridDepth + 3) / 4);

        // Phase 2: Execution Barrier
        VkMemoryBarrier memoryBarrier{};
        memoryBarrier.sType = VK_STRUCTURE_TYPE_MEMORY_BARRIER;
        memoryBarrier.srcAccessMask = VK_ACCESS_SHADER_WRITE_BIT;
        memoryBarrier.dstAccessMask = VK_ACCESS_SHADER_READ_BIT;

        // We must ensure the barrier blocks both the next Compute iteration AND the upcoming Graphics pass
        vkCmdPipelineBarrier(
            commandBuffer,
            VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT,
            VK_PIPELINE_STAGE_COMPUTE_SHADER_BIT | VK_PIPELINE_STAGE_FRAGMENT_SHADER_BIT,
            0, 1, &memoryBarrier, 0, nullptr, 0, nullptr
        );

        // Turn off spawning after the first step so we don't spawn 10x as many blocks per frame
        pc.spawnActive = 0;
    }

    // Closes the compute phase. Sits after the whole simulation-speed loop, so the figure is what
    // the simulation actually costs this frame at the current speed rather than the cost of one tick.
    if (timestampsSupported) {
        vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT, timestampPool, 1);
    }

    // Phase 3: Graphics Raymarching
    VkRenderPassBeginInfo renderPassInfo{};
    renderPassInfo.sType = VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
    renderPassInfo.renderPass = pipeline->getRenderPass();
    renderPassInfo.framebuffer = swapchainFramebuffers[imageIndex];
    renderPassInfo.renderArea.offset = { 0, 0 };
    renderPassInfo.renderArea.extent = swapchain->getExtent();

    VkClearValue clearColor = { {{0.0f, 0.0f, 0.0f, 1.0f}} };
    renderPassInfo.clearValueCount = 1;
    renderPassInfo.pClearValues = &clearColor;

    vkCmdBeginRenderPass(commandBuffer, &renderPassInfo, VK_SUBPASS_CONTENTS_INLINE);
    vkCmdBindPipeline(commandBuffer, VK_PIPELINE_BIND_POINT_GRAPHICS, pipeline->getGraphicsPipeline());
    vkCmdBindDescriptorSets(commandBuffer, VK_PIPELINE_BIND_POINT_GRAPHICS, pipeline->getGraphicsPipelineLayout(), 0, 1, &descriptorSet, 0, nullptr);
    vkCmdDraw(commandBuffer, 6, 1, 0, 0);

    // Closes the raymarch phase, BEFORE the UI is recorded. The profiler is a few hundred triangles
    // of its own, and a profiler that counted itself as scene cost would be reporting on the wrong
    // thing -- worse, its cost would rise with the very graph it was drawing.
    if (timestampsSupported) {
        vkCmdWriteTimestamp(commandBuffer, VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT, timestampPool, 2);
    }

    // Inject the compiled UI mesh directly into the command buffer after rendering the primary world geometry
    UiBackendVulkan::render(commandBuffer);

    vkCmdEndRenderPass(commandBuffer);

    vkEndCommandBuffer(commandBuffer);

    timestampsPending = timestampsSupported;

    // Phase 4: Submit and Present
    VkSubmitInfo submitInfo{};
    submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;

    VkSemaphore waitSemaphores[] = { imageAvailableSemaphore };
    VkPipelineStageFlags waitStages[] = { VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT };
    submitInfo.waitSemaphoreCount = 1;
    submitInfo.pWaitSemaphores = waitSemaphores;
    submitInfo.pWaitDstStageMask = waitStages;
    submitInfo.commandBufferCount = 1;
    submitInfo.pCommandBuffers = &commandBuffer;

    VkSemaphore signalSemaphores[] = { renderFinishedSemaphore };
    submitInfo.signalSemaphoreCount = 1;
    submitInfo.pSignalSemaphores = signalSemaphores;

    vkQueueSubmit(context->getComputeQueue(), 1, &submitInfo, inFlightFence);

    VkPresentInfoKHR presentInfo{};
    presentInfo.sType = VK_STRUCTURE_TYPE_PRESENT_INFO_KHR;
    presentInfo.waitSemaphoreCount = 1;
    presentInfo.pWaitSemaphores = signalSemaphores;
    VkSwapchainKHR swapchains[] = { swapchain->getSwapchain() };
    presentInfo.swapchainCount = 1;
    presentInfo.pSwapchains = swapchains;
    presentInfo.pImageIndices = &imageIndex;

    vkQueuePresentKHR(context->getComputeQueue(), &presentInfo);
}