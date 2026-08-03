// WebGpuRenderer.cpp -- milestone 1: canvas, clear, UI. No simulation, no raymarching.

#include "GfxBackend.hpp"

#ifdef SAND_BACKEND_WEBGPU

#include "WebGpuRenderer.hpp"
#include "UiBackend.hpp"
#include "AssetPaths.hpp"
#include "Storage.hpp"
#include "FrameLoop.hpp"

#include <GLFW/glfw3.h>

#include <chrono>
#include <cstdio>
#include <stdexcept>
#include <string>

namespace {

// WGPUStringView is {pointer, length} rather than a NUL-terminated pointer, and WGPU_STRLEN is the
// sentinel meaning "call strlen for me". Wrapping it keeps the call sites readable.
WGPUStringView sv(const char* s) {
    WGPUStringView v = WGPU_STRING_VIEW_INIT;
    v.data = s;
    v.length = WGPU_STRLEN;
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

void WebGpuRenderer::onDeviceReady(WGPUDevice newDevice) {
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
    configureSurface(uint32_t(fbWidth), uint32_t(fbHeight));

    window->setWorldExtents((float)config.tuning.gridWidth,
                            (float)config.tuning.gridHeight,
                            (float)config.tuning.gridDepth);

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
    std::printf("WebGPU ready: %ux%u, surface format %d\n", configuredWidth, configuredHeight,
                (int)surfaceFormat);
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
    if (fbWidth > 0 && fbHeight > 0 &&
        (uint32_t(fbWidth) != configuredWidth || uint32_t(fbHeight) != configuredHeight)) {
        configureSurface(uint32_t(fbWidth), uint32_t(fbHeight));
    }

    uiManager.buildUI();
    window->processInput(uiManager.wantsCaptureMouse(), uiManager.wantsCaptureKeyboard());

    drawFrame();

    const double wallMs = std::chrono::duration<double, std::milli>(
        std::chrono::high_resolution_clock::now() - frameStart).count();

    // gpuValid = false: WebGPU timestamp queries are behind an origin trial and quantised when
    // present, so the compute and raymarch rows have no honest number to show. The profiler
    // already takes this flag and says so rather than drawing a zero.
    uiManager.setFrameTimings(float(wallMs), 0.0f, 0.0f, false);
}

void WebGpuRenderer::drawFrame() {
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
    WGPURenderPassEncoder renderPass = wgpuCommandEncoderBeginRenderPass(encoder, &pass);

    // Milestone 2 puts the raymarch draw here, before the UI.
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
