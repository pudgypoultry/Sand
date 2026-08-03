// UiBackendWebGpu.cpp -- Dear ImGui's WebGPU + GLFW backends.

#include "GfxBackend.hpp"

#ifdef SAND_BACKEND_WEBGPU

#include "UiBackendWebGpu.hpp"
#include "UiBackend.hpp"

#include <imgui.h>
#include <imgui_impl_glfw.h>
#include <imgui_impl_wgpu.h>

namespace UiBackendWebGpu {

void init(const InitInfo& info) {
    // InitForOther, not InitForVulkan: the GLFW backend's job here is only input and window
    // metrics. Under Emscripten the "window" is a canvas element and there is no surface for GLFW
    // to create, so asking it for a Vulkan-flavoured init would be asking for something that does
    // not exist on this platform.
    ImGui_ImplGlfw_InitForOther(info.window, true);

    ImGui_ImplWGPU_InitInfo init_info;
    init_info.Device             = info.device;
    init_info.NumFramesInFlight  = info.framesInFlight;
    init_info.RenderTargetFormat = info.renderTargetFormat;
    init_info.DepthStencilFormat = info.depthStencilFormat;

    ImGui_ImplWGPU_Init(&init_info);
}

void render(WGPURenderPassEncoder pass) {
    ImDrawData* drawData = ImGui::GetDrawData();
    if (drawData) {
        ImGui_ImplWGPU_RenderDrawData(drawData, pass);
    }
}

} // namespace UiBackendWebGpu

namespace UiBackend {

void newFrame() {
    ImGui_ImplWGPU_NewFrame();
    ImGui_ImplGlfw_NewFrame();
}

void shutdown() {
    ImGui_ImplWGPU_Shutdown();
    ImGui_ImplGlfw_Shutdown();
}

} // namespace UiBackend

#endif // SAND_BACKEND_WEBGPU
