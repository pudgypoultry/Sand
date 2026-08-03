#pragma once

#include "GfxBackend.hpp"

#ifdef SAND_BACKEND_WEBGPU

#include <webgpu/webgpu.h>

#include "Window.hpp"
#include "UIManager.hpp"
#include "UiBackendWebGpu.hpp"
#include "Config.hpp"

#include <memory>
#include <string>

// The WebGPU renderer.
//
// MILESTONE 1 of the port (see docs/WEB_BUILD.md section 6): this clears the canvas and draws the
// UI, and does no simulation and no raymarching. That is the deliberate scope -- it proves the
// toolchain, the shell page, the asset packaging, the frame loop and the ImGui backend all work
// together before any of the difficult shader work starts. The options screen and profiler are
// already portable, so they should come up fully functional on top of a blank background.
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
    void frame();
    void drawFrame();

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

    // Set once the device callback has landed. Until then frame() does nothing: there is no device
    // to encode against and no ImGui backend initialised.
    bool ready = false;

    // What the surface is currently configured for. The canvas can be resized by the page at any
    // time, and drawing to a surface configured for a different size gives a stretched, blurry
    // image that reads as a rendering bug rather than a configuration one.
    uint32_t configuredWidth = 0;
    uint32_t configuredHeight = 0;

    UIManager uiManager;

    Config config;
    std::string configPath;
};

#endif // SAND_BACKEND_WEBGPU
