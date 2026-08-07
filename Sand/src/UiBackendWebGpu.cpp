// UiBackendWebGpu.cpp -- Dear ImGui's WebGPU + GLFW backends.

#include "GfxBackend.hpp"

#ifdef SAND_BACKEND_WEBGPU

#include "UiBackendWebGpu.hpp"
#include "UiBackend.hpp"

#include <imgui.h>

#include <cfloat>   // FLT_MAX, for ImGui's "no mouse" sentinel
#include <imgui_impl_glfw.h>
#include <imgui_impl_wgpu.h>

namespace {

// What the renderer last reported, applied in newFrame. Held rather than applied immediately
// because ImGui_ImplGlfw_NewFrame overwrites both values from GLFW every frame, so the correction
// only survives if it happens after it and before ImGui::NewFrame. Written by UiBackendWebGpu and
// read by UiBackend, which is why it sits above both rather than inside either.
ImVec2 g_displaySize{};
ImVec2 g_framebufferScale{};
ImVec2 g_mouseScale{1.0f, 1.0f};
bool   g_haveMetrics = false;

} // namespace

namespace UiBackendWebGpu {

void setDisplayMetrics(float cssWidth, float cssHeight, float fbWidth, float fbHeight,
                       float glfwWidth, float glfwHeight) {
    if (cssWidth <= 0.0f || cssHeight <= 0.0f || fbWidth <= 0.0f || fbHeight <= 0.0f
        || glfwWidth <= 0.0f || glfwHeight <= 0.0f) return;
    g_displaySize = ImVec2(cssWidth, cssHeight);
    g_framebufferScale = ImVec2(fbWidth / cssWidth, fbHeight / cssHeight);
    g_mouseScale = ImVec2(cssWidth / glfwWidth, cssHeight / glfwHeight);
    g_haveMetrics = true;
}

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
    // Set explicitly, because ImGui hands this straight to the render pipeline descriptor without
    // touching it. Its own default member initialiser is {}, which zeroes count -- and a
    // multisample state with count 0 is invalid, so the pipeline is rejected and the UI silently
    // does not draw. WGPU_MULTISAMPLE_STATE_INIT is the spec's own default: count 1, full mask.
    init_info.PipelineMultisampleState = WGPU_MULTISAMPLE_STATE_INIT;

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

    // After the GLFW backend, deliberately: it has just written both of these from a window size
    // that is not the canvas's. See UiBackendWebGpu::setDisplayMetrics.
    if (g_haveMetrics) {
        ImGuiIO& io = ImGui::GetIO();
        io.DisplaySize = g_displaySize;
        io.DisplayFramebufferScale = g_framebufferScale;

        // The GLFW backend has just set MousePos from glfwGetCursorPos, which on this platform is
        // scaled to the window size GLFW believes in rather than the canvas. Rescale it into the
        // space DisplaySize is now expressed in.
        //
        // Guarded on the sentinel: ImGui uses -FLT_MAX for "the mouse is not available", and
        // multiplying that produces a position rather than preserving the absence of one.
        if (io.MousePos.x > -FLT_MAX && io.MousePos.y > -FLT_MAX) {
            io.MousePos.x *= g_mouseScale.x;
            io.MousePos.y *= g_mouseScale.y;
        }
    }
}

void shutdown() {
    ImGui_ImplWGPU_Shutdown();
    ImGui_ImplGlfw_Shutdown();
}

} // namespace UiBackend

#endif // SAND_BACKEND_WEBGPU
