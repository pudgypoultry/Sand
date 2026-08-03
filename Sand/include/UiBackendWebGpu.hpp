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

// Appends the UI's vertex data to a render pass. The Vulkan version takes a command buffer; here
// it is the pass encoder, because WebGPU has no way to record draws outside a pass.
void render(WGPURenderPassEncoder pass);

} // namespace UiBackendWebGpu

#endif // SAND_BACKEND_WEBGPU
