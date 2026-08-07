#pragma once

#include "GfxBackend.hpp"

#ifdef SAND_BACKEND_WEBGPU

#include <webgpu/webgpu.h>

#include "Window.hpp"
#include "UIManager.hpp"
#include "UiBackendWebGpu.hpp"
#include "Config.hpp"
#include "FrameConstants.hpp"
#include "CursorRay.hpp"

#include <memory>
#include <string>

// The WebGPU renderer.
//
// The web counterpart of VulkanRenderer: it runs the same simulation compute shader, raymarches
// the same grid and draws the same UI over it. The thing most likely to be subtly wrong is not any
// of that but the std140-to-WGSL uniform layout -- TuningParams is a 100-field binary contract
// between C++ and both shaders, and a single misplaced field shifts every one after it.
//
// The one structural difference from VulkanRenderer, and it shapes everything else: WebGPU has no
// synchronous way to get a device. requestAdapter and requestDevice are both asynchronous with no
// blocking form, so construction cannot finish in the constructor and initGpu cannot finish before
// the first frame. The frame loop therefore starts immediately and frame() returns early until the
// device callback has landed; `ready` is that flag. Doing it the other way round -- waiting for the
// device and then starting the loop -- would mean run() returning to main() with work outstanding,
// which is exactly the shape that makes a browser tab appear to hang.
class WebGpuRenderer {
public:
    WebGpuRenderer();
    void run();

    WebGpuRenderer(const WebGpuRenderer&) = delete;
    WebGpuRenderer& operator=(const WebGpuRenderer&) = delete;

private:
    void initGpu();      // starts the async adapter -> device chain, then returns
    void onDeviceReady(WGPUDevice device);  // the far end of that chain; finishes setup
    void configureSurface(uint32_t width, uint32_t height);
    void syncCanvasSize();
    void frame();
    void drawFrame();

    void createWorldBuffers();
    void createRaymarchPipeline();
    void createSimulatePipeline();
    void createBindGroups();
    void resetWorld();
    void beginPurge();
    void applyOptions(const TuningParams& requested);
    void releaseWorldBuffers();
    void uploadTuning();
    void uploadFrameConstants();
    size_t voxelCount() const;

    std::unique_ptr<Window> window;

    WGPUInstance instance = nullptr;
    WGPUAdapter  adapter  = nullptr;
    WGPUDevice   device   = nullptr;
    WGPUQueue    queue    = nullptr;
    WGPUSurface  surface  = nullptr;

    // Whatever the surface says it prefers rather than an assumption. A format mismatch between
    // the configured surface and the pipeline ImGui builds is rejected at draw time, and the
    // symptom is a blank canvas with one console line -- worth ten lines of querying to avoid.
    WGPUTextureFormat surfaceFormat = WGPUTextureFormat_Undefined;

    // The sRGB view of it that everything actually renders through. A canvas may only be configured
    // with a non-sRGB format, so the encode Vulkan gets from its VK_FORMAT_B8G8R8A8_SRGB swapchain
    // has to come from the view instead -- without it the whole image is markedly darker.
    WGPUTextureFormat viewFormat = WGPUTextureFormat_Undefined;

    // Set once the device callback has landed. Until then frame() does nothing: there is no device
    // to encode against and no ImGui backend initialised.
    bool ready = false;

    // What the surface is currently configured for. The canvas can be resized by the page at any
    // time, and drawing to a surface configured for a different size gives a stretched, blurry
    // image that reads as a rendering bug rather than a configuration one.
    uint32_t configuredWidth = 0;
    uint32_t configuredHeight = 0;

    // The four bindings the shaders declare, in the order the WGSL numbers them.
    WGPUBuffer gridBuffer   = nullptr;  // binding 0, storage: one uint per voxel
    WGPUBuffer cloudBuffer  = nullptr;  // binding 4, storage: the cloud field, parallel to the grid
    WGPUBuffer statsBuffer  = nullptr;  // binding 1, storage: the SimStats block
    WGPUBuffer tuningBuffer = nullptr;  // binding 2, uniform: TuningParams
    WGPUBuffer frameBuffer  = nullptr;  // binding 3, uniform: FrameConstants

    // Two of each, because the grid's usage differs by stage and a bind group is only valid with
    // the layout it was created against. The render pass binds it read-only -- WebGPU permits
    // nothing else in a fragment shader -- while the compute pass needs read_write.
    WGPUBindGroupLayout renderBindGroupLayout = nullptr;
    WGPUBindGroup       renderBindGroup       = nullptr;
    WGPURenderPipeline  raymarchPipeline      = nullptr;

    WGPUBindGroupLayout computeBindGroupLayout = nullptr;
    WGPUBindGroup       computeBindGroup       = nullptr;
    WGPUComputePipeline simulatePipeline       = nullptr;

    // Written every frame from the camera and cursor, then uploaded to frameBuffer. Kept as a
    // member rather than a local so the upload and the values are obviously the same object.
    FrameConstants frameConstants{};

    UIManager uiManager;

    Config config;
    std::string configPath;
};

#endif // SAND_BACKEND_WEBGPU
