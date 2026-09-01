#pragma once

#include "GfxBackend.hpp"

#ifdef SAND_BACKEND_WEBGPU

#include <webgpu/webgpu.h>

#include "Window.hpp"
#include "UIManager.hpp"
#include "UiBackendWebGpu.hpp"
#include "Config.hpp"
#include "WorldFile.hpp"
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
    void pollSimState();   // copy SimStats out and map it, for the profiler
    void frame();
    void drawFrame();

    void createWorldBuffers();
    void createRaymarchPipeline();
    void createSimulatePipeline();
    void createBindGroups();
    void resetWorld();
    void beginPurge();
    void applyOptions(const TuningParams& requested);
    void saveWorld();
    void loadWorld();
    void loadTextAsWorld();
    void finishWorldSave();   // the far end of saveWorld's buffer map
    // The tail shared by loadWorld and loadTextAsWorld: assume `world` is decoded/built and upload it.
    void applyLoadedWorld(WorldFile::World& world);
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
    // A host-readable copy of the SimStats scalars, for the profiler's weather line. Not bound to
    // anything -- the GPU never sees it; the frame's encoder copies into it and the CPU maps it.
    //
    // The desktop reads those numbers straight off mapped memory. WebGPU has no host-visible storage
    // buffer, so the same three values cost a staging buffer, a copy and an asynchronous map.
    WGPUBuffer statsReadback = nullptr;
    bool       readbackPending = false;   // a map is in flight; do not copy into or re-map it

    // --- Saving the world -------------------------------------------------------------------
    // One staging buffer holding all three sources end to end -- grid, then cloud, then the whole
    // stats block -- rather than three buffers with three maps to sequence. A map is asynchronous,
    // so three of them would have to be chained through each other's callbacks; one copy pass into
    // one buffer needs a single callback and cannot half-succeed.
    //
    // Allocated per save and released in the callback. It is twice the grid plus the census, which
    // is 17 MB on a 128-cube, and holding that permanently for a button pressed occasionally is not
    // a reasonable trade.
    WGPUBuffer worldReadback = nullptr;
    bool       worldSavePending = false;
    // Captured when the save is requested. The name in the UI could be edited while the map is in
    // flight, and the file that arrives should be the one that was asked for.
    std::string pendingSaveName;

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
