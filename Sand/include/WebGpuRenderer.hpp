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
// DECLARATION ONLY -- WebGpuRenderer.cpp is not written yet, and CMake says so at configure time
// rather than letting it surface as a link error. This header is here because it is the useful
// half: it fixes the shape of the thing to be written, and it lets main.cpp, and everything else
// that only needs the type to exist, compile for the web target today.
//
// The private method names deliberately mirror VulkanRenderer's, because the port is largely a
// transcription and matching names make the two readable side by side. What each one becomes:
//
//   initGpu               requestAdapter then requestDevice, both asynchronous. This is the one
//                         structural difference from Vulkan with no local workaround: there is no
//                         blocking form, so construction cannot finish inside the constructor. The
//                         frame loop has to start in the device callback.
//   createWorldBuffers    createBuffer with Storage | CopyDst. No memory type to select and no
//                         allocation to bind -- WebGPU has no equivalent of
//                         vkGetPhysicalDeviceMemoryProperties, because the browser owns that
//                         decision.
//   writeBindGroup        the WebGPU counterpart of writing a descriptor set. Bind groups are
//                         immutable, so a resized world does not update one -- it makes a new one.
//   uploadTuning          wgpuQueueWriteBuffer. Simpler than the Vulkan path: no staging buffer
//                         and no manual barrier.
//   drawFrame             getCurrentTexture on the surface, one compute pass, one render pass,
//                         submit. There is no swapchain to recreate and no acquire/present
//                         semaphores to own; the browser presents when the callback returns.
//
// Two things from the Vulkan renderer have no counterpart and are gone rather than ported:
//
//   push constants        WebGPU has none. The sixteen fields the shaders take per frame become a
//                         second small uniform buffer written with wgpuQueueWriteBuffer.
//   timestamp queries     gated behind an origin trial, and quantised when present. The profiler's
//                         compute and raymarch rows are unavailable in a browser; the CPU row is
//                         not, and setFrameTimings already takes a flag for saying so.
class WebGpuRenderer {
public:
    WebGpuRenderer();
    void run();

    WebGpuRenderer(const WebGpuRenderer&) = delete;
    WebGpuRenderer& operator=(const WebGpuRenderer&) = delete;

private:
    void initGpu();
    void mainLoop();
    void frame();
    void cleanup();

    void seedParticles();
    void beginPurge();
    size_t voxelCount() const;
    void createWorldBuffers();
    void writeBindGroup();
    void applyOptions(const TuningParams& requested);
    void uploadTuning();
    void drawFrame();

    std::unique_ptr<Window> window;

    WGPUInstance instance = nullptr;
    WGPUAdapter  adapter  = nullptr;
    WGPUDevice   device   = nullptr;
    WGPUQueue    queue    = nullptr;
    WGPUSurface  surface  = nullptr;

    WGPUBuffer gridBuffer   = nullptr;
    WGPUBuffer statsBuffer  = nullptr;
    WGPUBuffer tuningBuffer = nullptr;
    // Stands in for Vulkan's push constants; written once per frame.
    WGPUBuffer frameBuffer  = nullptr;

    WGPUComputePipeline simulatePipeline = nullptr;
    WGPURenderPipeline  raymarchPipeline = nullptr;
    // Two, not one: the grid is bound read_write to the compute pass and read-only to the render
    // pass, and a bind group carries the usage as well as the buffer.
    WGPUBindGroup simulateBindGroup = nullptr;
    WGPUBindGroup raymarchBindGroup = nullptr;

    UIManager uiManager;

    Config config;
    std::string configPath;
};

#endif // SAND_BACKEND_WEBGPU
