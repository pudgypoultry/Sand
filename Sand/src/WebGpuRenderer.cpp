// WebGpuRenderer.cpp -- the WebGPU backend: simulate, raymarch, draw the UI.

#include "GfxBackend.hpp"

#ifdef SAND_BACKEND_WEBGPU

#include "WebGpuRenderer.hpp"
#include "UiBackend.hpp"
#include "AssetPaths.hpp"
#include "Storage.hpp"
#include "FrameLoop.hpp"
#include "SimStats.hpp"

#include <GLFW/glfw3.h>

#include <chrono>
#include <cmath>
#include <cstdio>
#include <cstring>
#include <fstream>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>


namespace {

// WGPUStringView is {pointer, length} rather than a NUL-terminated pointer, and WGPU_STRLEN is the
// sentinel meaning "call strlen for me". Wrapping it keeps the call sites readable.
WGPUStringView sv(const char* s) {
    WGPUStringView v = WGPU_STRING_VIEW_INIT;
    v.data = s;
    v.length = WGPU_STRLEN;
    return v;
}

// The same, but with the length given rather than left to the WGPU_STRLEN sentinel. Used for
// shader source: it is a third of a megabyte, the length is already known, and passing it avoids
// asking the other side of the boundary to go and find the terminator.
WGPUStringView svn(const std::string& s) {
    WGPUStringView v = WGPU_STRING_VIEW_INIT;
    v.data = s.data();
    v.length = s.size();
    return v;
}

// Messages come back as a view too, and it is NOT guaranteed to be NUL-terminated -- printing it
// with %s would run off the end. The length has to be honoured.
std::string toString(WGPUStringView v) {
    if (!v.data) return std::string();
    return (v.length == WGPU_STRLEN) ? std::string(v.data) : std::string(v.data, v.length);
}

// Validation is always on in a browser and reports here. This is the single most useful thing to
// have wired up before writing any pipeline code: without it a rejected pipeline or a bad bind
// group is a blank canvas and nothing else.
void onUncapturedError(WGPUDevice const*, WGPUErrorType type, WGPUStringView message, void*, void*) {
    std::fprintf(stderr, "[webgpu] error %d: %s\n", (int)type, toString(message).c_str());
}

void onDeviceLost(WGPUDevice const*, WGPUDeviceLostReason reason, WGPUStringView message, void*, void*) {
    std::fprintf(stderr, "[webgpu] device lost (%d): %s\n", (int)reason, toString(message).c_str());
}

// Reads a WGSL file out of the packaged filesystem. Throws with the path in the message: a missing
// shader here means the preload did not include it, and knowing which one says whether that is a
// build problem or a naming one.
std::string readTextFile(const std::string& path) {
    std::ifstream in(path, std::ios::binary);
    if (!in) throw std::runtime_error("Could not open shader '" + path + "'.");
    std::ostringstream ss;
    ss << in.rdbuf();
    return ss.str();
}

// Asks a shader module for its compilation log and prints it.
//
// Worth doing explicitly rather than relying on the uncaptured-error callback: that one fires when
// something USES the bad module, so the message arrives attached to a pipeline failure and only if
// a pipeline is attempted. This asks the module itself, which reports warnings as well as errors
// and does so whether or not anything downstream ever runs.
void dumpCompilationInfo(WGPUShaderModule module, const char* label) {
    WGPUCompilationInfoCallbackInfo info = WGPU_COMPILATION_INFO_CALLBACK_INFO_INIT;
    info.mode = WGPUCallbackMode_AllowSpontaneous;
    info.userdata1 = const_cast<char*>(label);
    info.callback = [](WGPUCompilationInfoRequestStatus status,
                       WGPUCompilationInfo const* compilationInfo, void* userdata1, void*) {
        const char* who = static_cast<const char*>(userdata1);
        if (status != WGPUCompilationInfoRequestStatus_Success || !compilationInfo) {
            std::fprintf(stderr, "[shader] %s: no compilation info (status %d)\n", who, (int)status);
            return;
        }
        if (compilationInfo->messageCount == 0) {
            std::printf("[shader] %s: compiled clean\n", who);
            return;
        }
        for (size_t i = 0; i < compilationInfo->messageCount; i++) {
            const WGPUCompilationMessage& m = compilationInfo->messages[i];
            std::fprintf(stderr, "[shader] %s %s:%llu:%llu: %s\n", who,
                         m.type == WGPUCompilationMessageType_Error ? "error" : "warning",
                         (unsigned long long)m.lineNum, (unsigned long long)m.linePos,
                         toString(m.message).c_str());
        }
    };
    wgpuShaderModuleGetCompilationInfo(module, info);
}

} // namespace

WebGpuRenderer::WebGpuRenderer() {
    configPath = resolveAssetPath("config.txt");
    // Restores a config saved on a previous visit before it is read. On the desktop this is a
    // no-op; here it is the whole of why the options screen's settings survive a reload.
    Storage::prime(configPath);
    config = loadConfig(configPath);

    // Under Emscripten this attaches to the canvas rather than opening anything, and the size is
    // the canvas backing store. GLFW_NO_API is already set in Window::initWindow and is right for
    // WebGPU as well as Vulkan -- there is no GL context to create either way.
    window = std::make_unique<Window>(1600, 1200, "3D Falling Sand Compute");
}

void WebGpuRenderer::run() {
    initGpu();

    // Started BEFORE the device exists, deliberately. See the note in the header: the request
    // chain is asynchronous with no blocking form, so the alternative is returning to main() with
    // work outstanding. frame() no-ops until `ready`.
    FrameLoop::run([this] { return !window->shouldClose(); },
                   [this] { frame(); });
}

void WebGpuRenderer::initGpu() {
    instance = wgpuCreateInstance(nullptr);
    if (!instance) throw std::runtime_error("wgpuCreateInstance failed.");

    // The surface comes from the canvas element by CSS selector. "#canvas" is the id in
    // web/shell.html; if the two ever disagree the surface is created against nothing and the page
    // stays blank, so they are a pair.
    WGPUEmscriptenSurfaceSourceCanvasHTMLSelector canvasSource =
        WGPU_EMSCRIPTEN_SURFACE_SOURCE_CANVAS_HTML_SELECTOR_INIT;
    canvasSource.selector = sv("#canvas");

    WGPUSurfaceDescriptor surfaceDesc = WGPU_SURFACE_DESCRIPTOR_INIT;
    surfaceDesc.nextInChain = &canvasSource.chain;
    surfaceDesc.label = sv("sand canvas");

    surface = wgpuInstanceCreateSurface(instance, &surfaceDesc);
    if (!surface) throw std::runtime_error("Could not create a WebGPU surface for #canvas.");

    WGPURequestAdapterOptions options = WGPU_REQUEST_ADAPTER_OPTIONS_INIT;
    // Passing the surface means the adapter is chosen knowing what it has to present to, which is
    // what makes the format query below meaningful.
    options.compatibleSurface = surface;
    options.powerPreference = WGPUPowerPreference_HighPerformance;

    WGPURequestAdapterCallbackInfo adapterCb = WGPU_REQUEST_ADAPTER_CALLBACK_INFO_INIT;
    // AllowSpontaneous, because nothing here ever calls wgpuInstanceWaitAny or ProcessEvents --
    // the browser's event loop is what drives us, and this is the mode that lets the callback fire
    // from it. WaitAnyOnly would leave the callback queued forever and the page permanently blank.
    adapterCb.mode = WGPUCallbackMode_AllowSpontaneous;
    adapterCb.userdata1 = this;
    adapterCb.callback = [](WGPURequestAdapterStatus status, WGPUAdapter adapter,
                            WGPUStringView message, void* userdata1, void*) {
        auto* self = static_cast<WebGpuRenderer*>(userdata1);
        if (status != WGPURequestAdapterStatus_Success || !adapter) {
            std::fprintf(stderr, "[webgpu] no adapter: %s\n", toString(message).c_str());
            return;
        }
        self->adapter = adapter;

        WGPUDeviceDescriptor deviceDesc = WGPU_DEVICE_DESCRIPTOR_INIT;
        deviceDesc.label = sv("sand device");
        deviceDesc.uncapturedErrorCallbackInfo.callback = onUncapturedError;
        deviceDesc.deviceLostCallbackInfo.mode = WGPUCallbackMode_AllowSpontaneous;
        deviceDesc.deviceLostCallbackInfo.callback = onDeviceLost;

        WGPURequestDeviceCallbackInfo deviceCb = WGPU_REQUEST_DEVICE_CALLBACK_INFO_INIT;
        deviceCb.mode = WGPUCallbackMode_AllowSpontaneous;
        deviceCb.userdata1 = self;
        deviceCb.callback = [](WGPURequestDeviceStatus status, WGPUDevice device,
                               WGPUStringView message, void* userdata1, void*) {
            auto* self = static_cast<WebGpuRenderer*>(userdata1);
            if (status != WGPURequestDeviceStatus_Success || !device) {
                std::fprintf(stderr, "[webgpu] no device: %s\n", toString(message).c_str());
                return;
            }
            self->onDeviceReady(device);
        };

        wgpuAdapterRequestDevice(adapter, &deviceDesc, deviceCb);
    };

    wgpuInstanceRequestAdapter(instance, &options, adapterCb);
}

void WebGpuRenderer::onDeviceReady(WGPUDevice newDevice) try {
    device = newDevice;
    queue = wgpuDeviceGetQueue(device);

    // Ask the surface what it can present rather than assuming BGRA8Unorm. The first entry is the
    // preferred one by specification, and using anything else costs an implicit conversion at
    // best and a rejected pipeline at worst.
    WGPUSurfaceCapabilities caps = WGPU_SURFACE_CAPABILITIES_INIT;
    if (wgpuSurfaceGetCapabilities(surface, adapter, &caps) == WGPUStatus_Success && caps.formatCount > 0) {
        surfaceFormat = caps.formats[0];
    } else {
        surfaceFormat = WGPUTextureFormat_BGRA8Unorm;
    }

    int fbWidth = 0, fbHeight = 0;
    glfwGetFramebufferSize(window->getGLFWwindow(), &fbWidth, &fbHeight);
    // A canvas that has not been laid out yet reports 0x0, and configureSurface refuses that -- so
    // taking it at face value leaves the surface unconfigured and every getCurrentTexture failing
    // forever. Fall back to what the window was asked for; the per-frame check corrects it as soon
    // as the real size is known.
    if (fbWidth <= 0 || fbHeight <= 0) {
        glfwGetWindowSize(window->getGLFWwindow(), &fbWidth, &fbHeight);
    }
    if (fbWidth <= 0 || fbHeight <= 0) { fbWidth = 1600; fbHeight = 1200; }
    configureSurface(uint32_t(fbWidth), uint32_t(fbHeight));

    window->setWorldExtents((float)config.tuning.gridWidth,
                            (float)config.tuning.gridHeight,
                            (float)config.tuning.gridDepth);

    // Order matters: the buffers have to exist before the bind group names them, and the surface
    // format has to be known before the pipeline declares its colour target.
    //
    // Each step announces itself, which is worth the noise. Everything here happens inside an
    // asynchronous callback before the first frame, so a failure shows up as a page that stays
    // blank -- indistinguishable, without these, from the device never arriving at all.
    std::printf("[sand] creating buffers\n");        createWorldBuffers();
    std::printf("[sand] uploading tuning\n");        uploadTuning();
    std::printf("[sand] seeding world\n");           seedWorld();
    std::printf("[sand] raymarch pipeline\n");       createRaymarchPipeline();
    std::printf("[sand] simulate pipeline\n");       createSimulatePipeline();
    std::printf("[sand] bind groups\n");             createBindGroups();

    // Context before backend, same ordering rule as the Vulkan path: ImGui_ImplWGPU_Init writes
    // into the context and needs it to exist.
    uiManager.init();

    UiBackendWebGpu::InitInfo uiInit;
    uiInit.window = window->getGLFWwindow();
    uiInit.device = device;
    uiInit.renderTargetFormat = surfaceFormat;
    UiBackendWebGpu::init(uiInit);

    uiManager.setTuning(config.tuning);

    ready = true;
    std::printf("[sand] ready: %ux%u, surface format %d\n", configuredWidth, configuredHeight,
                (int)surfaceFormat);
}
// Everything above runs inside a C callback invoked from the runtime's JS glue. Letting an
// exception cross that boundary is undefined behaviour, and in practice it takes the whole module
// down with no message worth reading -- so it is caught here, at the last frame that is still C++,
// and reported. `ready` stays false, so frame() keeps returning early and the page stays up to
// show the console rather than dying.
catch (const std::exception& e) {
    std::fprintf(stderr, "[sand] initialisation failed: %s\n", e.what());
}
catch (...) {
    std::fprintf(stderr, "[sand] initialisation failed: unrecognised exception\n");
}

size_t WebGpuRenderer::voxelCount() const {
    return (size_t)config.tuning.gridWidth * config.tuning.gridHeight * config.tuning.gridDepth;
}

void WebGpuRenderer::createWorldBuffers() {
    const uint64_t gridBytes = (uint64_t)voxelCount() * sizeof(uint32_t);

    // The default maxStorageBufferBindingSize is 128 MiB, and asking for more than the device
    // advertises fails at creation with a validation message rather than anywhere useful. Said out
    // loud here because the sizes involved are ordinary for this program -- 320^3 is 125 MiB and
    // fits, 384^3 is 216 MiB and does not.
    if (gridBytes > 134217728ull) {
        std::fprintf(stderr,
            "[sand] grid is %llu MiB, over WebGPU's default 128 MiB storage-binding limit. "
            "Reduce sim.grid_size (320 cubed is the practical ceiling).\n",
            (unsigned long long)(gridBytes >> 20));
    }

    WGPUBufferDescriptor desc = WGPU_BUFFER_DESCRIPTOR_INIT;
    desc.label = sv("grid");
    desc.usage = WGPUBufferUsage_Storage | WGPUBufferUsage_CopyDst;
    desc.size = gridBytes;
    gridBuffer = wgpuDeviceCreateBuffer(device, &desc);

    desc.label = sv("stats");
    desc.size = (uint64_t)SimStats::kFieldCount * sizeof(uint32_t);
    statsBuffer = wgpuDeviceCreateBuffer(device, &desc);

    // Uniform buffer sizes are rounded up to 16: WebGPU requires the binding size to be a multiple
    // of it, and TuningParams (99 scalars, 396 bytes) is not.
    desc.label = sv("tuning");
    desc.usage = WGPUBufferUsage_Uniform | WGPUBufferUsage_CopyDst;
    desc.size = (sizeof(TuningParams) + 15) & ~(uint64_t)15;
    tuningBuffer = wgpuDeviceCreateBuffer(device, &desc);

    desc.label = sv("frame");
    desc.size = (sizeof(FrameConstants) + 15) & ~(uint64_t)15;
    frameBuffer = wgpuDeviceCreateBuffer(device, &desc);
}

void WebGpuRenderer::uploadTuning() {
    wgpuQueueWriteBuffer(queue, tuningBuffer, 0, &config.tuning, sizeof(TuningParams));
}

void WebGpuRenderer::uploadFrameConstants() {
    wgpuQueueWriteBuffer(queue, frameBuffer, 0, &frameConstants, sizeof(FrameConstants));
}

// seedWorld: fills the grid on the CPU, because there is no simulation yet to fill it.
//
// Milestone 3 replaces this with the compute shader and the world goes back to starting empty. Until
// then an empty grid would render as empty sky, which proves nothing -- so this lays down something
// deliberately diagnostic: a floor, and one pillar per material in id order. If the raymarcher, the
// palette, the lighting and the uniform layout are all right, that reads as a neat row of correctly
// coloured columns. If TuningParams is misaligned by even one field, the world extents are wrong and
// it does not.
void WebGpuRenderer::seedWorld() {
    const uint32_t W = config.tuning.gridWidth;
    const uint32_t H = config.tuning.gridHeight;
    const uint32_t D = config.tuning.gridDepth;

    std::vector<uint32_t> voxels(voxelCount(), 0u);
    auto at = [&](uint32_t x, uint32_t y, uint32_t z) -> uint32_t& {
        return voxels[x + (size_t)y * W + (size_t)z * W * H];
    };
    // Matches pack() in falling_sand.comp: type in the low byte, age in the high one.
    auto pack = [](uint32_t type, uint32_t age) { return type | (age << 24); };

    const uint32_t STONE = 3u, FLOOR_TOP = 4u;
    for (uint32_t y = 0; y < FLOOR_TOP && y < H; y++)
        for (uint32_t z = 0; z < D; z++)
            for (uint32_t x = 0; x < W; x++)
                at(x, y, z) = pack(STONE, 0u);

    // One pillar per material, id 1 upward, spaced so they do not touch. The lava and locust stages
    // and dark stone all read an age byte, so each is seeded with a plausible one -- otherwise a
    // stage-3 lava would render as stage 0 and the test would quietly not be testing anything.
    const uint32_t MATERIAL_COUNT = 20u;
    const uint32_t spacing = 4u;
    const uint32_t pillarHeight = 6u;
    for (uint32_t m = 1; m < MATERIAL_COUNT; m++) {
        const uint32_t x = spacing * m;
        const uint32_t z = D / 2;
        if (x + 1 >= W) break;

        uint32_t age = 0u;
        if (m >= 8u && m <= 11u) age = (m - 8u) * 60u;   // lava coolness, one per stage
        else if (m == 12u)       age = 255u;             // dark stone
        else if (m >= 13u && m <= 17u) age = 10u * (m - 12u); // locust head count, 10..50

        for (uint32_t y = FLOOR_TOP; y < FLOOR_TOP + pillarHeight && y < H; y++)
            for (uint32_t dz = 0; dz < 2; dz++)
                for (uint32_t dx = 0; dx < 2; dx++)
                    if (x + dx < W && z + dz < D) at(x + dx, y, z + dz) = pack(m, age);
    }

    wgpuQueueWriteBuffer(queue, gridBuffer, 0, voxels.data(), voxels.size() * sizeof(uint32_t));

    std::vector<uint32_t> stats(SimStats::kFieldCount, 0u);
    // maxOccupiedY starts at the roof, as it does on the desktop: over-reporting only costs the
    // renderer some empty sky, while under-reporting hides matter. Nothing walks it down here --
    // that is the compute shader's job and there isn't one yet -- so it simply stays open.
    stats[SimStats::kMaxY] = H;
    wgpuQueueWriteBuffer(queue, statsBuffer, 0, stats.data(), stats.size() * sizeof(uint32_t));
}

void WebGpuRenderer::createRaymarchPipeline() {
    // Two modules from two files, both entry points named "main" -- which is what naga emits from
    // GLSL, where main is the only name a stage can have.
    const std::string vertPath = resolveAssetPath("shaders/screen.wgsl");
    const std::string fragPath = resolveAssetPath("shaders/raymarch.wgsl");
    const std::string vertSrc = readTextFile(vertPath);
    const std::string fragSrc = readTextFile(fragPath);
    std::printf("[sand]   read %s: %zu bytes\n", vertPath.c_str(), vertSrc.size());
    std::printf("[sand]   read %s: %zu bytes\n", fragPath.c_str(), fragSrc.size());

    auto makeModule = [&](const std::string& code, const char* label) {
        WGPUShaderSourceWGSL wgsl = WGPU_SHADER_SOURCE_WGSL_INIT;
        wgsl.code = svn(code);
        WGPUShaderModuleDescriptor desc = WGPU_SHADER_MODULE_DESCRIPTOR_INIT;
        desc.nextInChain = &wgsl.chain;
        desc.label = sv(label);
        return wgpuDeviceCreateShaderModule(device, &desc);
    };
    WGPUShaderModule vertModule = makeModule(vertSrc, "screen.wgsl");
    WGPUShaderModule fragModule = makeModule(fragSrc, "raymarch.wgsl");

    // The layout is written out rather than inferred from the shader. Automatic layout would work
    // for this pass and then quietly disagree with the compute pass in milestone 3, which binds the
    // same grid read_write -- and a bind group is only usable with the layout it was made for.
    WGPUBindGroupLayoutEntry entries[4] = {};
    for (auto& e : entries) e = WGPU_BIND_GROUP_LAYOUT_ENTRY_INIT;

    entries[0].binding = 0;
    entries[0].visibility = WGPUShaderStage_Fragment;
    entries[0].buffer.type = WGPUBufferBindingType_ReadOnlyStorage;

    entries[1].binding = 1;
    entries[1].visibility = WGPUShaderStage_Fragment;
    entries[1].buffer.type = WGPUBufferBindingType_ReadOnlyStorage;

    entries[2].binding = 2;
    entries[2].visibility = WGPUShaderStage_Fragment;
    entries[2].buffer.type = WGPUBufferBindingType_Uniform;

    entries[3].binding = 3;
    entries[3].visibility = WGPUShaderStage_Fragment;
    entries[3].buffer.type = WGPUBufferBindingType_Uniform;

    WGPUBindGroupLayoutDescriptor layoutDesc = WGPU_BIND_GROUP_LAYOUT_DESCRIPTOR_INIT;
    layoutDesc.label = sv("raymarch bindings");
    layoutDesc.entryCount = 4;
    layoutDesc.entries = entries;
    renderBindGroupLayout = wgpuDeviceCreateBindGroupLayout(device, &layoutDesc);

    WGPUPipelineLayoutDescriptor plDesc = WGPU_PIPELINE_LAYOUT_DESCRIPTOR_INIT;
    plDesc.bindGroupLayoutCount = 1;
    plDesc.bindGroupLayouts = &renderBindGroupLayout;
    WGPUPipelineLayout pipelineLayout = wgpuDeviceCreatePipelineLayout(device, &plDesc);

    WGPUColorTargetState colorTarget = WGPU_COLOR_TARGET_STATE_INIT;
    colorTarget.format = surfaceFormat;
    colorTarget.writeMask = WGPUColorWriteMask_All;

    WGPUFragmentState fragment = WGPU_FRAGMENT_STATE_INIT;
    fragment.module = fragModule;
    fragment.entryPoint = sv("main");
    fragment.targetCount = 1;
    fragment.targets = &colorTarget;

    WGPURenderPipelineDescriptor pipeDesc = WGPU_RENDER_PIPELINE_DESCRIPTOR_INIT;
    pipeDesc.label = sv("raymarch");
    pipeDesc.layout = pipelineLayout;
    pipeDesc.vertex.module = vertModule;
    pipeDesc.vertex.entryPoint = sv("main");
    // No vertex buffers: screen.vert indexes a hardcoded array of six positions by vertex index, so
    // the draw is six vertices and no attributes at all.
    pipeDesc.vertex.bufferCount = 0;
    pipeDesc.primitive.topology = WGPUPrimitiveTopology_TriangleList;
    pipeDesc.fragment = &fragment;

    raymarchPipeline = wgpuDeviceCreateRenderPipeline(device, &pipeDesc);
    if (!raymarchPipeline) throw std::runtime_error("Render pipeline creation returned null.");

    // The pipeline holds its own references to all three; nothing here needs them again.
    wgpuPipelineLayoutRelease(pipelineLayout);
    wgpuShaderModuleRelease(vertModule);
    wgpuShaderModuleRelease(fragModule);
}

void WebGpuRenderer::createSimulatePipeline() {
    const std::string path = resolveAssetPath("shaders/falling_sand.wgsl");
    const std::string src = readTextFile(path);
    // Printed BEFORE anything else can fail, so "the file is missing" and "the file is there but
    // the module was rejected" are distinguishable. The first version printed this after module
    // creation and the two looked identical from the console.
    std::printf("[sand]   read %s: %zu bytes\n", path.c_str(), src.size());

    WGPUShaderSourceWGSL wgsl = WGPU_SHADER_SOURCE_WGSL_INIT;
    wgsl.code = svn(src);
    WGPUShaderModuleDescriptor modDesc = WGPU_SHADER_MODULE_DESCRIPTOR_INIT;
    modDesc.nextInChain = &wgsl.chain;
    modDesc.label = sv("falling_sand.wgsl");
    WGPUShaderModule module = wgpuDeviceCreateShaderModule(device, &modDesc);
    if (!module) throw std::runtime_error("falling_sand.wgsl did not compile.");
    std::printf("[sand]   module created\n");
    dumpCompilationInfo(module, "falling_sand.wgsl");

    // The same four buffers as the render pass, but the grid and the stats are read_write here.
    // That is the whole reason for a second layout: a fragment shader may not bind a read-write
    // storage buffer at all, so the two stages cannot share one.
    WGPUBindGroupLayoutEntry entries[4] = {};
    for (auto& e : entries) e = WGPU_BIND_GROUP_LAYOUT_ENTRY_INIT;

    entries[0].binding = 0;
    entries[0].visibility = WGPUShaderStage_Compute;
    entries[0].buffer.type = WGPUBufferBindingType_Storage;

    entries[1].binding = 1;
    entries[1].visibility = WGPUShaderStage_Compute;
    entries[1].buffer.type = WGPUBufferBindingType_Storage;

    entries[2].binding = 2;
    entries[2].visibility = WGPUShaderStage_Compute;
    entries[2].buffer.type = WGPUBufferBindingType_Uniform;

    entries[3].binding = 3;
    entries[3].visibility = WGPUShaderStage_Compute;
    entries[3].buffer.type = WGPUBufferBindingType_Uniform;

    WGPUBindGroupLayoutDescriptor layoutDesc = WGPU_BIND_GROUP_LAYOUT_DESCRIPTOR_INIT;
    layoutDesc.label = sv("simulate bindings");
    layoutDesc.entryCount = 4;
    layoutDesc.entries = entries;
    computeBindGroupLayout = wgpuDeviceCreateBindGroupLayout(device, &layoutDesc);
    std::printf("[sand]   compute bind group layout\n");

    WGPUPipelineLayoutDescriptor plDesc = WGPU_PIPELINE_LAYOUT_DESCRIPTOR_INIT;
    plDesc.bindGroupLayoutCount = 1;
    plDesc.bindGroupLayouts = &computeBindGroupLayout;
    WGPUPipelineLayout pipelineLayout = wgpuDeviceCreatePipelineLayout(device, &plDesc);

    WGPUComputePipelineDescriptor pipeDesc = WGPU_COMPUTE_PIPELINE_DESCRIPTOR_INIT;
    pipeDesc.label = sv("simulate");
    pipeDesc.layout = pipelineLayout;
    pipeDesc.compute.module = module;
    pipeDesc.compute.entryPoint = sv("main");
    std::printf("[sand]   creating compute pipeline (Tint compiles the shader here)\n");
    simulatePipeline = wgpuDeviceCreateComputePipeline(device, &pipeDesc);
    if (!simulatePipeline) throw std::runtime_error("Compute pipeline creation returned null.");
    std::printf("[sand]   compute pipeline ok\n");

    wgpuPipelineLayoutRelease(pipelineLayout);
    wgpuShaderModuleRelease(module);
}

// createBindGroups: names the four buffers to both layouts.
//
// Separate from pipeline creation because a bind group is immutable -- WebGPU has no equivalent of
// rewriting a descriptor set in place. Resizing the world makes new buffers, and new buffers mean
// new bind groups even though the layouts and the pipelines are untouched.
void WebGpuRenderer::createBindGroups() {
    WGPUBindGroupEntry bound[4] = {};
    for (auto& b : bound) b = WGPU_BIND_GROUP_ENTRY_INIT;
    bound[0].binding = 0; bound[0].buffer = gridBuffer;   bound[0].size = wgpuBufferGetSize(gridBuffer);
    bound[1].binding = 1; bound[1].buffer = statsBuffer;  bound[1].size = wgpuBufferGetSize(statsBuffer);
    bound[2].binding = 2; bound[2].buffer = tuningBuffer; bound[2].size = wgpuBufferGetSize(tuningBuffer);
    bound[3].binding = 3; bound[3].buffer = frameBuffer;  bound[3].size = wgpuBufferGetSize(frameBuffer);

    WGPUBindGroupDescriptor bgDesc = WGPU_BIND_GROUP_DESCRIPTOR_INIT;
    bgDesc.entryCount = 4;
    bgDesc.entries = bound;

    if (renderBindGroup)  { wgpuBindGroupRelease(renderBindGroup);  renderBindGroup = nullptr; }
    if (computeBindGroup) { wgpuBindGroupRelease(computeBindGroup); computeBindGroup = nullptr; }

    bgDesc.label = sv("raymarch bind group");
    bgDesc.layout = renderBindGroupLayout;
    renderBindGroup = wgpuDeviceCreateBindGroup(device, &bgDesc);

    bgDesc.label = sv("simulate bind group");
    bgDesc.layout = computeBindGroupLayout;
    computeBindGroup = wgpuDeviceCreateBindGroup(device, &bgDesc);
}

void WebGpuRenderer::releaseWorldBuffers() {
    if (gridBuffer)  { wgpuBufferDestroy(gridBuffer);  wgpuBufferRelease(gridBuffer);  gridBuffer = nullptr; }
    if (statsBuffer) { wgpuBufferDestroy(statsBuffer); wgpuBufferRelease(statsBuffer); statsBuffer = nullptr; }
}

// beginPurge: what Clear Grid does -- one enormous black hole at the centre, eating the world.
//
// The desktop version reads the black hole table back, clears the voxel of every hole already in
// it, and leaves the rest of the world standing for the purge hole to eat. That read-modify-write
// needs mapped memory, which WebGPU does not offer for a storage buffer without an asynchronous
// staging copy, so this writes a fresh stats block instead.
//
// What that costs: a black hole PLACED BY HAND before Clear Grid keeps its voxel, as an inert
// type-7 cube with no table entry, because clearing it would mean knowing where it was. Capture
// skips type 7, so it survives the purge either way; the desktop removes it first. Narrow, only
// visible if you placed one, and written down rather than left to be found.
void WebGpuRenderer::beginPurge() {
    const uint32_t w = config.tuning.gridWidth, h = config.tuning.gridHeight, d = config.tuning.gridDepth;
    const uint32_t centre = (w / 2) + (h / 2) * w + (d / 2) * w * h;

    std::vector<uint32_t> stats(SimStats::kFieldCount, 0u);
    stats[SimStats::kHoles]  = SimStats::kActive | SimStats::kPurge | centre;
    stats[SimStats::kMass]   = config.tuning.purgeMass;
    stats[SimStats::kStarve] = 0u;
    stats[SimStats::kCount]  = 1u;
    // The purge hole is written straight into the grid, so it never passes through the dispatch
    // that would publish its height. Opening the ceiling stops its body being clipped away on the
    // frame it appears.
    stats[SimStats::kMaxY]  = h;
    wgpuQueueWriteBuffer(queue, statsBuffer, 0, stats.data(), stats.size() * sizeof(uint32_t));

    const uint32_t hole = 7u; // pack(BlackHole, 0, 0, 0)
    wgpuQueueWriteBuffer(queue, gridBuffer, (uint64_t)centre * sizeof(uint32_t), &hole, sizeof(hole));

    std::printf("[sand] purge started: one black hole at the centre, eating the world.\n");
}

// applyOptions: makes the options screen's edited copy the config the simulation runs on.
//
// A reload rather than a live patch, exactly as on the desktop: it ends with an empty world and the
// camera back at its framing pose, because a world halfway through running under the old numbers is
// not a fair test of the new ones.
void WebGpuRenderer::applyOptions(const TuningParams& requested) {
    TuningParams next = requested;
    applyWorldShape(next, next.gridWidth);
    sanitizeTuning(next);

    const bool shapeChanged = next.gridWidth  != config.tuning.gridWidth ||
                              next.gridHeight != config.tuning.gridHeight ||
                              next.gridDepth  != config.tuning.gridDepth;
    config.tuning = next;

    if (shapeChanged) {
        // No vkDeviceWaitIdle equivalent is needed or offered: WebGPU tracks the buffers' use by
        // already-submitted work itself, and a destroy takes effect once that work retires.
        releaseWorldBuffers();
        createWorldBuffers();
        createBindGroups();
        window->setWorldExtents((float)config.tuning.gridWidth,
                                (float)config.tuning.gridHeight,
                                (float)config.tuning.gridDepth);
    }

    uploadTuning();
    seedWorld();
    window->resetCamera();

    if (saveConfig(configPath, config)) {
        if (!Storage::persist(configPath)) {
            std::printf("[sand] settings applied, but could not be stored for next launch.\n");
        }
    }
    uiManager.setTuning(config.tuning);

    std::printf("[sand] options applied; world cleared at %u^3%s\n", config.tuning.gridWidth,
                shapeChanged ? " (buffers reallocated)." : ".");
}

void WebGpuRenderer::configureSurface(uint32_t width, uint32_t height) {
    // A zero-sized configuration is invalid and a hidden or not-yet-laid-out canvas reports zero,
    // so this is a real case rather than defensive noise.
    if (width == 0 || height == 0) return;

    WGPUSurfaceConfiguration surfaceConfig = WGPU_SURFACE_CONFIGURATION_INIT;
    surfaceConfig.device = device;
    surfaceConfig.format = surfaceFormat;
    surfaceConfig.usage = WGPUTextureUsage_RenderAttachment;
    surfaceConfig.width = width;
    surfaceConfig.height = height;
    surfaceConfig.presentMode = WGPUPresentMode_Fifo;

    wgpuSurfaceConfigure(surface, &surfaceConfig);
    configuredWidth = width;
    configuredHeight = height;
}

void WebGpuRenderer::frame() {
    // Every frame between the first and the device callback lands here. The browser is painting an
    // empty canvas over the shell's loading panel during that window, which is what it should be
    // doing -- there is nothing to draw yet.
    if (!ready) return;

    const auto frameStart = std::chrono::high_resolution_clock::now();

    window->pollEvents();

    // The page can resize the canvas at any point, and a surface configured for the old size draws
    // a stretched image. Cheap to check, and the failure it prevents looks like a rendering bug.
    int fbWidth = 0, fbHeight = 0;
    glfwGetFramebufferSize(window->getGLFWwindow(), &fbWidth, &fbHeight);
    if (fbWidth <= 0 || fbHeight <= 0) {
        glfwGetWindowSize(window->getGLFWwindow(), &fbWidth, &fbHeight);
    }
    if (fbWidth > 0 && fbHeight > 0 &&
        (uint32_t(fbWidth) != configuredWidth || uint32_t(fbHeight) != configuredHeight)) {
        configureSurface(uint32_t(fbWidth), uint32_t(fbHeight));
    }

    uiManager.buildUI();
    window->processInput(uiManager.wantsCaptureMouse(), uiManager.wantsCaptureKeyboard());

    // The same raycast the desktop runs, from the same file. Placing blocks works now: spawnActive
    // is set by a click and the compute shader does the rest.
    buildFrameConstants(*window, uiManager, config.tuning, (float)glfwGetTime(), frameConstants);

    // The three UI actions. Safe to do here between frames: everything below touches buffers only
    // through the queue, which orders them against work already submitted.
    if (uiManager.consumeResetRequest())        beginPurge();
    if (uiManager.consumeApplyOptions())        applyOptions(uiManager.pendingTuning());
    if (uiManager.consumeCameraResetRequest())  window->resetCamera();

    uploadFrameConstants();

    drawFrame();

    const double wallMs = std::chrono::duration<double, std::milli>(
        std::chrono::high_resolution_clock::now() - frameStart).count();

    // gpuValid = false: WebGPU timestamp queries are behind an origin trial and quantised when
    // present, so the compute and raymarch rows have no honest number to show. The profiler
    // already takes this flag and says so rather than drawing a zero.
    uiManager.setFrameTimings(float(wallMs), 0.0f, 0.0f, false);
}

void WebGpuRenderer::drawFrame() {
    // Asking an unconfigured surface for a texture fails, and the failure is per-frame -- sixty
    // identical lines a second, which buries whatever actually went wrong. If it is not configured
    // there is nothing to draw into, so say so once and stop.
    if (!computeBindGroup || !renderBindGroup) {
        static bool complained = false;
        if (!complained) {
            std::fprintf(stderr, "[sand] bind groups were never created; not drawing.\n");
            complained = true;
        }
        return;
    }

    if (configuredWidth == 0 || configuredHeight == 0) {
        static bool complained = false;
        if (!complained) {
            std::fprintf(stderr, "[sand] surface has no size; not drawing. The canvas is 0x0.\n");
            complained = true;
        }
        return;
    }

    WGPUSurfaceTexture surfaceTexture = WGPU_SURFACE_TEXTURE_INIT;
    wgpuSurfaceGetCurrentTexture(surface, &surfaceTexture);

    // Suboptimal is still drawable and happens routinely mid-resize; only the outright failures
    // are worth skipping a frame for. Reconfiguring here would fight the resize check above.
    if (surfaceTexture.status != WGPUSurfaceGetCurrentTextureStatus_SuccessOptimal &&
        surfaceTexture.status != WGPUSurfaceGetCurrentTextureStatus_SuccessSuboptimal) {
        if (surfaceTexture.texture) wgpuTextureRelease(surfaceTexture.texture);
        return;
    }

    WGPUTextureView view = wgpuTextureCreateView(surfaceTexture.texture, nullptr);

    WGPURenderPassColorAttachment colour = WGPU_RENDER_PASS_COLOR_ATTACHMENT_INIT;
    colour.view = view;
    colour.loadOp = WGPULoadOp_Clear;
    colour.storeOp = WGPUStoreOp_Store;
    // The shell page's background, so the canvas does not flash a different colour against it.
    colour.clearValue = WGPUColor{ 0.071, 0.078, 0.102, 1.0 };

    WGPURenderPassDescriptor pass = WGPU_RENDER_PASS_DESCRIPTOR_INIT;
    pass.label = sv("clear + ui");
    pass.colorAttachmentCount = 1;
    pass.colorAttachments = &colour;

    WGPUCommandEncoder encoder = wgpuDeviceCreateCommandEncoder(device, nullptr);

    // Simulation first, then the render pass reads what it produced. No barrier between them:
    // WebGPU inserts the dependency itself at pass boundaries, which is one of the few places it
    // asks for less than Vulkan rather than more.
    {
        WGPUComputePassDescriptor computePass = WGPU_COMPUTE_PASS_DESCRIPTOR_INIT;
        computePass.label = sv("simulate");
        WGPUComputePassEncoder sim = wgpuCommandEncoderBeginComputePass(encoder, &computePass);
        wgpuComputePassEncoderSetPipeline(sim, simulatePipeline);
        wgpuComputePassEncoderSetBindGroup(sim, 0, computeBindGroup, 0, nullptr);

        // Rounded up so a grid size that is not a multiple of the workgroup still covers its last
        // partial group; main() drops the overshoot. Z divides by 4 rather than 8 because the
        // workgroup is 8x8x4 -- these two numbers are a pair with the layout in the shader, and
        // getting them out of step silently stops simulating the top of the world.
        const uint32_t gx = (config.tuning.gridWidth  + 7) / 8;
        const uint32_t gy = (config.tuning.gridHeight + 7) / 8;
        const uint32_t gz = (config.tuning.gridDepth  + 3) / 4;

        // Several dispatches per frame is how the speed slider works, exactly as on the desktop:
        // the simulation is one step per dispatch, so more dispatches is a faster world rather than
        // a larger one.
        const int steps = uiManager.getSimulationSpeed();
        for (int i = 0; i < steps; i++) {
            wgpuComputePassEncoderDispatchWorkgroups(sim, gx, gy, gz);
        }

        wgpuComputePassEncoderEnd(sim);
        wgpuComputePassEncoderRelease(sim);
    }

    WGPURenderPassEncoder renderPass = wgpuCommandEncoderBeginRenderPass(encoder, &pass);

    // The world, then the UI over it. Six vertices and no vertex buffer: screen.wgsl indexes a
    // hardcoded array of positions by vertex index.
    wgpuRenderPassEncoderSetPipeline(renderPass, raymarchPipeline);
    wgpuRenderPassEncoderSetBindGroup(renderPass, 0, renderBindGroup, 0, nullptr);
    wgpuRenderPassEncoderDraw(renderPass, 6, 1, 0, 0);

    UiBackendWebGpu::render(renderPass);

    wgpuRenderPassEncoderEnd(renderPass);

    WGPUCommandBuffer commands = wgpuCommandEncoderFinish(encoder, nullptr);
    wgpuQueueSubmit(queue, 1, &commands);

    // Every one of these is a reference this frame took out. WebGPU has no pool to reset, so a
    // missed release is a leak that grows once per frame -- at sixty frames a second that is
    // visible in a minute.
    wgpuCommandBufferRelease(commands);
    wgpuRenderPassEncoderRelease(renderPass);
    wgpuCommandEncoderRelease(encoder);
    wgpuTextureViewRelease(view);
    wgpuTextureRelease(surfaceTexture.texture);

    // No present call: the browser composites the canvas when the frame callback returns.
    // wgpuSurfacePresent exists for native targets and is a no-op here.
}

#endif // SAND_BACKEND_WEBGPU
