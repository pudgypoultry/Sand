#pragma once

#include "GfxBackend.hpp"

#ifdef SAND_BACKEND_WEBGPU

#include <webgpu/webgpu.h>

struct GLFWwindow;

// Dear ImGui's WebGPU backend -- the counterpart to UiBackendVulkan, and the only place in the
// project that includes imgui_impl_wgpu.h.
//
// The shape is deliberately the same as the Vulkan one, because everything on the other side of
// UiBackend.hpp is identical between them: UIManager calls newFrame and shutdown and knows nothing
// about either.
namespace UiBackendWebGpu {

struct InitInfo {
    GLFWwindow*     window             = nullptr;
    WGPUDevice      device             = nullptr;
    // Must match the format the swapchain texture view was configured with, or every UI draw is
    // rejected by the pipeline as an attachment mismatch.
    WGPUTextureFormat renderTargetFormat = WGPUTextureFormat_BGRA8Unorm;
    WGPUTextureFormat depthStencilFormat = WGPUTextureFormat_Undefined;
    // There is no swapchain image count to read back in WebGPU -- the browser owns presentation --
    // so this is how many frames of UI vertex buffers to keep rather than a queried property.
    int             framesInFlight     = 3;
};

void init(const InitInfo& info);

// FUNCTION: setDisplayMetrics
// Tells ImGui how big the thing being drawn into actually is.
//
// It would not need telling if GLFW knew. ImGui's GLFW backend sets io.DisplaySize and
// io.DisplayFramebufferScale from glfwGetWindowSize and glfwGetFramebufferSize every frame, and
// under Emscripten those still report whatever glfwCreateWindow was asked for -- the canvas is
// resized through the HTML5 API, which GLFW has no idea about. Everything ImGui's WebGPU backend
// does is scaled from those two values, so a stale pair means a viewport and scissor sized for a
// render target that does not exist, and WebGPU rejects the whole command buffer: no UI, and an
// uncaptured error every frame.
//
// cssWidth/cssHeight are the canvas in CSS pixels -- what the UI is laid out in, so it comes out
// the right size and undistorted. fbWidth/fbHeight are the real backing store; ImGui multiplies the
// two, which is exactly where render.resolution_scale lives.
//
// glfwWidth/glfwHeight are the size GLFW believes the window is, which is NOT either of the above
// on this platform. It matters because ImGui takes its mouse position from GLFW, in that space,
// while it hit-tests against DisplaySize -- so the position has to be rescaled between the two or
// every panel is clickable somewhere other than where it is drawn.
//
// No Vulkan counterpart: there all three are the same number.
void setDisplayMetrics(float cssWidth, float cssHeight, float fbWidth, float fbHeight,
                       float glfwWidth, float glfwHeight);

// Appends the UI's vertex data to a render pass. The Vulkan version takes a command buffer; here
// it is the pass encoder, because WebGPU has no way to record draws outside a pass.
void render(WGPURenderPassEncoder pass);

} // namespace UiBackendWebGpu

#endif // SAND_BACKEND_WEBGPU
