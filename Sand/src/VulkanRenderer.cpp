#include "VulkanRenderer.hpp"
#include <iostream>
#include <fstream>
#include <stdexcept>
#include <algorithm>
#include <cstring>
#include <cfloat>

// Constructor: Initializes the managed architecture instances
VulkanRenderer::VulkanRenderer() {
    config = loadConfig("config.txt");
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

    // Create SSBO Buffer via the new VulkanBuffer wrapper
    // NOTE: sized as a flat array of uint32_t, matching the packed voxel representation
    // actually read/written by falling_sand.comp and raymarch.frag (see pack()/getType()/etc).
    VkDeviceSize bufferSize = sizeof(uint32_t) * GRID_SIZE * GRID_SIZE * GRID_SIZE;
    ssboBuffer = std::make_unique<VulkanBuffer>(
        context.get(),
        bufferSize,
        VK_BUFFER_USAGE_STORAGE_BUFFER_BIT,
        VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT
    );

    // Cloud/water tracking stats buffer: steamTopCount, revealedCount, lastRevealTimeBits,
    // waterVoxelCount, + 64 per-slot cloud reveal timestamps. Bound at descriptor binding 1,
    // shared between the compute and fragment stages.
    steamCounterBuffer = std::make_unique<VulkanBuffer>(
        context.get(),
        sizeof(uint32_t) * (9 + 64*4),   // was (4 + 64) — CloudStats now has 7 scalar fields, not 4
        VK_BUFFER_USAGE_STORAGE_BUFFER_BIT,
        VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT
    );

    tuningBuffer = std::make_unique<VulkanBuffer>(
        context.get(),
        sizeof(TuningParams),
        VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT,
        VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT
    );

    // Written exactly once -- config doesn't change at runtime given the edit-then-relaunch model
    void* tuningData = tuningBuffer->mapMemory();
    memcpy(tuningData, &config.tuning, sizeof(TuningParams));
    tuningBuffer->unmapMemory();

    seedParticles();

    // Initialize Pipeline after swapchain and buffer definitions
    pipeline = std::make_unique<VulkanPipeline>(context.get(), swapchain.get());

    createFramebuffers();

    createDescriptorSet();
    createCommandPoolAndBuffer();
    createSyncObjects();

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

    uiManager.init(
        window->getGLFWwindow(),
        context->getInstance(),
        context->getPhysicalDevice(),
        context->getDevice(),
        context->getComputeQueue(),
        context->getComputeQueueFamily(),
        imguiDescriptorPool,
        pipeline->getRenderPass(),
        2,
        static_cast<uint32_t>(swapchain->getImageViews().size())
    );
}

// mainLoop: Continues rendering frames until the window is closed
void VulkanRenderer::mainLoop() {
    while (!window->shouldClose()) {
        window->pollEvents();

        uiManager.buildUI();

        bool captureMouse = uiManager.wantsCaptureMouse();
        bool captureKeyboard = uiManager.wantsCaptureKeyboard();

        window->processInput(captureMouse, captureKeyboard);

        drawFrame();
    }
    vkDeviceWaitIdle(context->getDevice());
}

// cleanup: Destroys Vulkan resources in reverse order of creation
void VulkanRenderer::cleanup() {
    vkDeviceWaitIdle(context->getDevice());

    uiManager.cleanup(context->getDevice());
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
    size_t totalVoxels = (size_t)GRID_SIZE * GRID_SIZE * GRID_SIZE;
    void* data = ssboBuffer->mapMemory();
    memset(data, 0, sizeof(uint32_t) * totalVoxels);
    ssboBuffer->unmapMemory();

    // steamTopCount = 0, revealedCount = 0, lastRevealTimeBits = 0, waterVoxelCount = 0,
    // all 64 cloudRevealTime entries = 0 (unused/unread until revealedCount advances past them)
    std::vector<uint32_t> statsInit(9 + 64*4, 0u);
    statsInit[8] = 0xFFFFFFFFu;
    void* counterData = steamCounterBuffer->mapMemory();
    memcpy(counterData, statsInit.data(), sizeof(uint32_t) * statsInit.size());
    steamCounterBuffer->unmapMemory();

    std::cout << "Seeded initial empty grid to GPU!\n";
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

// drawFrame: Synchronizes execution, records the command buffer, triggers physics compute, and renders
void VulkanRenderer::drawFrame() {
    vkWaitForFences(context->getDevice(), 1, &inFlightFence, VK_TRUE, UINT64_MAX);
    vkResetFences(context->getDevice(), 1, &inFlightFence);

    // Intercept a UI reset command. Since the Fence confirms the GPU is done reading the SSBO,
    // we can safely execute a memory wipe from the CPU before passing the SSBO back to the compute shader.
    if (uiManager.consumeResetRequest()) {
        seedParticles();
    }

    if (uiManager.consumeCameraResetRequest()) {
        window->resetCamera();
    }

    uint32_t imageIndex;
    vkAcquireNextImageKHR(context->getDevice(), swapchain->getSwapchain(), UINT64_MAX, imageAvailableSemaphore, VK_NULL_HANDLE, &imageIndex);

    vkResetCommandBuffer(commandBuffer, 0);

    VkCommandBufferBeginInfo beginInfo{};
    beginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
    vkBeginCommandBuffer(commandBuffer, &beginInfo);

    // Bind pipeline and descriptor sets once for the compute loop
    vkCmdBindPipeline(commandBuffer, VK_PIPELINE_BIND_POINT_COMPUTE, pipeline->getComputePipeline());
    vkCmdBindDescriptorSets(commandBuffer, VK_PIPELINE_BIND_POINT_COMPUTE, pipeline->getComputePipelineLayout(), 0, 1, &descriptorSet, 0, nullptr);

    PushConstants pc{};
    pc.time = (float)glfwGetTime();
    pc.pitch = window->getPitch();
    pc.yaw = window->getYaw();
    pc.camX = window->getCamX();
    pc.camY = window->getCamY();
    pc.camZ = window->getCamZ();
    pc.spawnActive = 0;

    pc.spawnSize = uiManager.getBrushSize();
    pc.fovDistance = uiManager.getFovDistance();
    pc.perspectiveBlend = uiManager.getPerspectiveBlend();

    // Set default out-of-bounds so the cursor hides if looking into the void
    pc.spawnX = -1; pc.spawnY = -1; pc.spawnZ = -1;

    // Read the selected material from the UI Manager
    pc.spawnType = static_cast<int>(uiManager.getCurrentMaterial());

    // --- CPU RAYCAST FOR MOUSE CURSOR AND CLICK ---
    float ndcX = window->getMouseNdcX();
    float ndcY = -window->getMouseNdcY();

    // Builds the same forward/right/up camera basis as raymarch.frag, then blends between
    // perspective (shared origin, per-pixel direction) and orthographic (shared direction,
    // per-pixel origin) using the same t = perspectiveBlend factor, so the cursor stays
    // accurate across the whole slider range instead of only matching at t = 1.
    struct RayVec3 { float x, y, z; };

    auto rotateByCamera = [](RayVec3 v, float pitch, float yaw) -> RayVec3 {
        float cp = std::cos(pitch), sp = std::sin(pitch);
        float ny = v.y * cp - v.z * sp;
        float nz = v.y * sp + v.z * cp;
        v.y = ny; v.z = nz;

        float cy = std::cos(yaw), sy = std::sin(yaw);
        float nx = v.x * cy - v.z * sy;
        float nz2 = v.x * sy + v.z * cy;
        v.x = nx; v.z = nz2;
        return v;
        };

    RayVec3 forward = rotateByCamera({ 0.0f, 0.0f, 1.0f }, pc.pitch, pc.yaw);
    RayVec3 right = rotateByCamera({ 1.0f, 0.0f, 0.0f }, pc.pitch, pc.yaw);
    RayVec3 up = rotateByCamera({ 0.0f, 1.0f, 0.0f }, pc.pitch, pc.yaw);

    float t = std::clamp(pc.perspectiveBlend, 0.0f, 1.0f);

    float viewDistance = std::max(1.0f,
        (64.0f - pc.camX) * forward.x + (64.0f - pc.camY) * forward.y + (64.0f - pc.camZ) * forward.z);
    float orthoHalfSize = viewDistance / pc.fovDistance;

    float localDirX = (1.0f - t) * 0.0f + t * ndcX;
    float localDirY = (1.0f - t) * 0.0f + t * ndcY;
    float localDirZ = (1.0f - t) * 1.0f + t * pc.fovDistance;

    float rx = right.x * localDirX + up.x * localDirY + forward.x * localDirZ;
    float ry = right.y * localDirX + up.y * localDirY + forward.y * localDirZ;
    float rz = right.z * localDirX + up.z * localDirY + forward.z * localDirZ;
    float len = std::sqrt(rx * rx + ry * ry + rz * rz);
    rx /= len; ry /= len; rz /= len;

    float originOffsetX = (right.x * ndcX + up.x * ndcY) * orthoHalfSize * (1.0f - t);
    float originOffsetY = (right.y * ndcX + up.y * ndcY) * orthoHalfSize * (1.0f - t);
    float originOffsetZ = (right.z * ndcX + up.z * ndcY) * orthoHalfSize * (1.0f - t);

    float ox = pc.camX + originOffsetX;
    float oy = pc.camY + originOffsetY;
    float oz = pc.camZ + originOffsetZ;

    bool isInside = (ox > 0.0f && ox < 128.0f && oy > 0.0f && oy < 128.0f && oz > 0.0f && oz < 128.0f);

    int brushSize = uiManager.getBrushSize();
    int halfDistMin = brushSize / 2;
    int halfDistMax = (brushSize - 1) / 2;
    int minBound = 1 + halfDistMin;
    int maxBound = 126 - halfDistMax;

    if (isInside) {
        float spawnDist = 30.0f;
        float hitX = ox + rx * spawnDist;
        float hitY = oy + ry * spawnDist;
        float hitZ = oz + rz * spawnDist;

        if (hitX >= minBound && hitX <= maxBound && hitY >= minBound && hitY <= maxBound && hitZ >= minBound && hitZ <= maxBound) {
            pc.spawnX = (int)hitX;
            pc.spawnY = (int)hitY;
            pc.spawnZ = (int)hitZ;
            if (window->isLeftClicking()) pc.spawnActive = 1;
        }
    }
    else {
        float t1 = (0.0f - ox) / rx;  float t2 = (128.0f - ox) / rx;
        float t3 = (0.0f - oy) / ry;  float t4 = (128.0f - oy) / ry;
        float t5 = (0.0f - oz) / rz;  float t6 = (128.0f - oz) / rz;

        float tmin = std::max({ std::min(t1, t2), std::min(t3, t4), std::min(t5, t6) });
        float tmax = std::min({ std::max(t1, t2), std::max(t3, t4), std::max(t5, t6) });

        if (tmax >= 0 && tmin > 0 && tmin <= tmax) {
            float hitX = ox + rx * tmin + rx * 0.01f;
            float hitY = oy + ry * tmin + ry * 0.01f;
            float hitZ = oz + rz * tmin + rz * 0.01f;

            pc.spawnX = std::clamp((int)hitX, minBound, maxBound);
            pc.spawnY = std::clamp((int)hitY, minBound, maxBound);
            pc.spawnZ = std::clamp((int)hitZ, minBound, maxBound);
            if (window->isLeftClicking()) pc.spawnActive = 1;
        }
    }

    // --- MULTI-STEP PHYSICS DISPATCH ---
    int simSteps = uiManager.getSimulationSpeed();
    for (int step = 0; step < simSteps; step++) {
        // We dispatch the compute shader multiple times, allowing it to run physics multiple times per visual frame
        vkCmdPushConstants(commandBuffer, pipeline->getComputePipelineLayout(), VK_SHADER_STAGE_COMPUTE_BIT | VK_SHADER_STAGE_FRAGMENT_BIT, 0, sizeof(PushConstants), &pc);
        vkCmdDispatch(commandBuffer, GRID_SIZE / 8, GRID_SIZE / 8, GRID_SIZE / 8);

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

    // Inject the compiled UI mesh directly into the command buffer after rendering the primary world geometry
    uiManager.recordDrawCommands(commandBuffer);

    vkCmdEndRenderPass(commandBuffer);

    vkEndCommandBuffer(commandBuffer);

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