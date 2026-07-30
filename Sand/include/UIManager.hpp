#pragma once

#include <imgui.h>
#include <imgui_impl_glfw.h>
#include <imgui_impl_vulkan.h>
#include <vulkan/vulkan.h>
#include <stdexcept>
#include <vector>
#include <string>
#include <cfloat>
#include <algorithm>

struct GLFWwindow;

enum class MaterialType {
    Void = 0,
    Sand = 1,
    Water = 2,
    Stone = 3,
    Dirt = 4,
    Fire = 5,
    Steam = 6,
    BlackHole = 7
};

enum class CursorShape {
    Cube = 0,
    Sphere = 1
};

class UIManager {
public:
    UIManager() = default;
    ~UIManager() = default;

    UIManager(const UIManager&) = delete;
    UIManager& operator=(const UIManager&) = delete;

    void init(GLFWwindow* window,
        VkInstance instance,
        VkPhysicalDevice physicalDevice,
        VkDevice device,
        VkQueue graphicsQueue,
        uint32_t queueFamily,
        VkDescriptorPool descriptorPool,
        VkRenderPass renderPass,
        uint32_t minImageCount,
        uint32_t imageCount)
    {
        IMGUI_CHECKVERSION();
        ImGui::CreateContext();
        ImGuiIO& io = ImGui::GetIO();

        // Tab belongs to the cursor-shape toggle, so ImGui must not also read it as "focus the next
        // widget". With keyboard nav on, tabbing lands on a slider and activates it, which is how
        // pressing Tab turned controls into editable text fields you could type a bad value into.
        io.ConfigFlags &= ~ImGuiConfigFlags_NavEnableKeyboard;
        io.ConfigFlags &= ~ImGuiConfigFlags_NavEnableGamepad;

        ImGui::StyleColorsDark();
        setupCustomTheme();

        ImGui_ImplGlfw_InitForVulkan(window, true);

        ImGui_ImplVulkan_InitInfo init_info = {};
        init_info.Instance = instance;
        init_info.PhysicalDevice = physicalDevice;
        init_info.Device = device;
        init_info.QueueFamily = queueFamily;
        init_info.Queue = graphicsQueue;
        init_info.PipelineCache = VK_NULL_HANDLE;
        init_info.DescriptorPool = descriptorPool;

        init_info.PipelineInfoMain.RenderPass = renderPass;
        init_info.PipelineInfoMain.Subpass = 0;

        init_info.MinImageCount = minImageCount;
        init_info.ImageCount = imageCount;
        init_info.Allocator = nullptr;
        init_info.CheckVkResultFn = checkVulkanResult;

        ImGui_ImplVulkan_Init(&init_info);
    }

    void uploadFonts(VkDevice device, VkCommandPool commandPool, VkQueue graphicsQueue) {
        // Automatic in Dear ImGui 1.90+
    }

    void buildUI() {
        ImGui_ImplVulkan_NewFrame();
        ImGui_ImplGlfw_NewFrame();
        ImGui::NewFrame();

        handleShortcuts();

        // Startup layout: controls pinned to the top-left corner, profiler to the top-right.
        //
        // Forced with Always on the first frame rather than set with FirstUseEver, because a saved
        // imgui.ini takes precedence over FirstUseEver and the windows would simply reappear wherever
        // they were last dragged. Applying it for one frame only means the layout is deterministic at
        // launch while the windows stay freely movable for the rest of the session.
        if (m_firstFrame) {
            ImGui::SetNextWindowPos(ImVec2(0.0f, 0.0f), ImGuiCond_Always, ImVec2(0.0f, 0.0f));
            // A zero component means auto-fit that axis. The stored imgui.ini size predates rows
            // added to this window since, so honouring it would open the panel already clipped;
            // fitting once at launch keeps the startup state correct as controls come and go.
            ImGui::SetNextWindowSize(ImVec2(0.0f, 0.0f), ImGuiCond_Always);
        }

        ImGui::Begin("Simulation Controls");

        const char* items[] = { "Void", "Sand", "Water", "Stone", "Dirt", "Fire", "Steam", "Black Hole" };
        int currentMat = static_cast<int>(m_currentMaterial);
        if (ImGui::Combo("Material", &currentMat, items, IM_ARRAYSIZE(items))) {
            m_currentMaterial = static_cast<MaterialType>(currentMat);
        }

        const char* shapes[] = { "Cube", "Sphere" };
        int currentShape = static_cast<int>(m_cursorShape);
        if (ImGui::Combo("Cursor Shape (Tab)", &currentShape, shapes, IM_ARRAYSIZE(shapes))) {
            m_cursorShape = static_cast<CursorShape>(currentShape);
        }

        if (m_currentMaterial == MaterialType::BlackHole) {
            ImGui::TextDisabled("Black holes place one voxel (max 8).");
        }

        // NoInput on every slider: belt and braces alongside disabling keyboard nav. It stops a
        // slider becoming an editable text field by any route at all -- ctrl+click included -- so
        // there is no way to end up typing an out-of-range value into one by accident.
        ImGui::SliderInt("Brush Size", &m_brushSize, 1, 32, "%d", ImGuiSliderFlags_NoInput);
        ImGui::SliderInt("Simulation Speed", &m_simulationSpeed, 1, 10, "%d", ImGuiSliderFlags_NoInput);
        ImGui::SliderFloat("FOV / Zoom", &m_fovDistance, 0.3f, 5.0f, "%.2f", ImGuiSliderFlags_NoInput);
        ImGui::SliderFloat("Ortho <-> Perspective", &m_perspectiveBlend, 0.0f, 1.0f, "%.2f", ImGuiSliderFlags_NoInput);

        if (ImGui::Button("Reset Camera")) {
            m_cameraResetRequested = true;
        }

        if (ImGui::Button("Clear Grid")) {
            m_resetRequested = true;
        }

        ImGui::Separator();
        ImGui::Checkbox("Show Profiler", &m_showProfiler);
        ImGui::End();

        if (m_showProfiler) {
            float currentFrameTime = 1000.0f / ImGui::GetIO().Framerate;
            m_frameTimeHistory[m_frameTimeHistoryIdx] = currentFrameTime;
            m_frameTimeHistoryIdx = (m_frameTimeHistoryIdx + 1) % 3600;

            if (m_firstFrame) {
                // Pivot (1,0) anchors the window's own top-RIGHT corner to the point given, so it
                // sits flush against the screen edge without needing to know its own width first.
                ImGui::SetNextWindowPos(ImVec2(ImGui::GetIO().DisplaySize.x, 0.0f), ImGuiCond_Always, ImVec2(1.0f, 0.0f));
            }

            ImGui::Begin("Profiler & Performance", &m_showProfiler);
            ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", currentFrameTime, ImGui::GetIO().Framerate);
            ImGui::Separator();

            ImGui::Text("Last Minute Frame Times:");
            ImGui::PlotLines(
                "##FrameTimes",
                m_frameTimeHistory,
                3600,
                m_frameTimeHistoryIdx,
                "ms / frame",
                0.0f, FLT_MAX,
                ImVec2(ImGui::GetContentRegionAvail().x, 80.0f)
            );
            ImGui::End();
        }

        m_firstFrame = false;

        ImGui::Render();
    }

    void recordDrawCommands(VkCommandBuffer commandBuffer) {
        ImDrawData* draw_data = ImGui::GetDrawData();
        if (draw_data) {
            ImGui_ImplVulkan_RenderDrawData(draw_data, commandBuffer);
        }
    }

    void cleanup(VkDevice device) {
        vkDeviceWaitIdle(device);
        ImGui_ImplVulkan_Shutdown();
        ImGui_ImplGlfw_Shutdown();
        ImGui::DestroyContext();
    }

    int getBrushSize() const { return m_brushSize; }
    CursorShape getCursorShape() const { return m_cursorShape; }
    float getPerspectiveBlend() const { return m_perspectiveBlend; }
    MaterialType getCurrentMaterial() const { return m_currentMaterial; }
    int getSimulationSpeed() const { return m_simulationSpeed; }
    float getFovDistance() const { return m_fovDistance; }

    bool consumeResetRequest() {
        bool requested = m_resetRequested;
        m_resetRequested = false;
        return requested;
    }

    bool consumeCameraResetRequest() {
        bool requested = m_cameraResetRequested;
        m_cameraResetRequested = false;
        return requested;
    }

    bool wantsCaptureMouse() const { return ImGui::GetIO().WantCaptureMouse; }
    bool wantsCaptureKeyboard() const { return ImGui::GetIO().WantCaptureKeyboard; }

    void setBrushSize(int size) { m_brushSize = std::clamp(size, 1, 32); }
    void setSimulationSpeed(int speed) { m_simulationSpeed = std::clamp(speed, 1, 10); }
    void setCurrentMaterial(MaterialType type) { m_currentMaterial = type; }
    void setCursorShape(CursorShape shape) { m_cursorShape = shape; }

private:
    int m_brushSize = 5;
    CursorShape m_cursorShape = CursorShape::Sphere;
    int m_simulationSpeed = 1;
    MaterialType m_currentMaterial = MaterialType::Sand;
    bool m_resetRequested = false;
    bool m_cameraResetRequested = false;
    float m_fovDistance = 1.2f; // matches the original hardcoded raymarch FOV distance
    float m_perspectiveBlend = 1.0f; // 1.0 = perspective (original behavior), 0.0 = orthographic
    bool m_showProfiler = true;
    bool m_firstFrame = true; // drives the one-shot startup window placement in buildUI
    float m_frameTimeHistory[3600] = { 0.0f };
    int m_frameTimeHistoryIdx = 0;

    void handleShortcuts() {
        if (ImGui::GetIO().WantTextInput) return;

        if (ImGui::IsKeyPressed(ImGuiKey_1)) m_currentMaterial = MaterialType::Void;
        if (ImGui::IsKeyPressed(ImGuiKey_2)) m_currentMaterial = MaterialType::Sand;
        if (ImGui::IsKeyPressed(ImGuiKey_3)) m_currentMaterial = MaterialType::Water;
        if (ImGui::IsKeyPressed(ImGuiKey_4)) m_currentMaterial = MaterialType::Stone;
        if (ImGui::IsKeyPressed(ImGuiKey_5)) m_currentMaterial = MaterialType::Dirt;
        if (ImGui::IsKeyPressed(ImGuiKey_6)) m_currentMaterial = MaterialType::Fire;
        if (ImGui::IsKeyPressed(ImGuiKey_7)) m_currentMaterial = MaterialType::Steam;
        if (ImGui::IsKeyPressed(ImGuiKey_8)) m_currentMaterial = MaterialType::BlackHole;

        if (ImGui::IsKeyPressed(ImGuiKey_Tab)) {
            m_cursorShape = (m_cursorShape == CursorShape::Cube) ? CursorShape::Sphere : CursorShape::Cube;
        }

        if (ImGui::IsKeyPressed(ImGuiKey_LeftBracket) || ImGui::IsKeyPressed(ImGuiKey_Q))
            m_brushSize = std::max(1, m_brushSize - 1);

        if (ImGui::IsKeyPressed(ImGuiKey_RightBracket) || ImGui::IsKeyPressed(ImGuiKey_E))
            m_brushSize = std::min(32, m_brushSize + 1);

        //if (!wantsCaptureMouse()) {
        //    float wheel = ImGui::GetIO().MouseWheel;
        //    if (wheel > 0.0f) m_brushSize = std::min(32, m_brushSize + 1);
        //    if (wheel < 0.0f) m_brushSize = std::max(1, m_brushSize - 1);
        //}

        if (ImGui::IsKeyPressed(ImGuiKey_R)) m_resetRequested = true;
        if (ImGui::IsKeyPressed(ImGuiKey_C)) m_cameraResetRequested = true;

        if (ImGui::IsKeyPressed(ImGuiKey_Minus) || ImGui::IsKeyPressed(ImGuiKey_KeypadSubtract)) {
            m_simulationSpeed = std::max(1, m_simulationSpeed - 1);
        }
        if (ImGui::IsKeyPressed(ImGuiKey_Equal) || ImGui::IsKeyPressed(ImGuiKey_KeypadAdd)) {
            m_simulationSpeed = std::min(10, m_simulationSpeed + 1);
        }
    }

    static void checkVulkanResult(VkResult err) {
        if (err == 0) return;
        throw std::runtime_error("ImGui Vulkan Error: VkResult = " + std::to_string(err));
    }

    void setupCustomTheme() {
        ImGuiStyle& style = ImGui::GetStyle();
        style.WindowRounding = 8.0f;
        style.FrameRounding = 6.0f;
        style.PopupRounding = 6.0f;
        style.ScrollbarRounding = 6.0f;
        style.GrabRounding = 6.0f;
        style.Colors[ImGuiCol_WindowBg] = ImVec4(0.1f, 0.105f, 0.11f, 1.0f);
        style.Colors[ImGuiCol_TitleBgActive] = ImVec4(0.2f, 0.205f, 0.21f, 1.0f);
        style.Colors[ImGuiCol_Button] = ImVec4(0.3f, 0.305f, 0.31f, 1.0f);
        style.Colors[ImGuiCol_ButtonHovered] = ImVec4(0.4f, 0.405f, 0.41f, 1.0f);
        style.Colors[ImGuiCol_ButtonActive] = ImVec4(0.5f, 0.505f, 0.51f, 1.0f);
    }
};