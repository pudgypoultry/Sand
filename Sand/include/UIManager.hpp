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
    BlackHole = 7,
    // Four views of one coolness value rather than four independent materials -- see the LAVA block
    // in falling_sand.comp. Only LavaHottest is meant to be placed in normal play; the cooler stages
    // are exposed in the dropdown for testing a flow partway through its life.
    LavaHottest = 8,
    LavaHot = 9,
    LavaWarm = 10,
    LavaCooling = 11,
    DarkStone = 12
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
        }

        // AlwaysAutoResize rather than a stored size: the window is sized by its contents every
        // frame, so the whole panel is visible at launch regardless of what imgui.ini remembers, and
        // it cannot be dragged to a size that clips or stretches anything. It stays movable.
        ImGui::Begin("Simulation Controls", nullptr, ImGuiWindowFlags_AlwaysAutoResize);

        // Fixed control width. Left to itself ImGui stretches widgets to fill the content region, so
        // the sliders resized with the window; pinning the width is what makes the bars static and
        // what gives the auto-resize above a fixed target to size the window around. Expressed in
        // font sizes so it holds up if the font or DPI scale changes.
        ImGui::PushItemWidth(ImGui::GetFontSize() * 10.0f);

        // Index must line up with MaterialType -- these are parallel lists with nothing tying them
        // together at compile time, so a gap here silently places the wrong block.
        const char* items[] = { "Void", "Sand", "Water", "Stone", "Dirt", "Fire", "Steam", "Black Hole",
                                "Lava", "Lava (Hot)", "Lava (Warm)", "Lava (Cooling)", "Dark Stone" };
        int currentMat = static_cast<int>(m_currentMaterial);
        if (ImGui::Combo("Material", &currentMat, items, IM_ARRAYSIZE(items))) {
            m_currentMaterial = static_cast<MaterialType>(currentMat);
        }

        const char* shapes[] = { "Cube", "Sphere" };
        int currentShape = static_cast<int>(m_cursorShape);
        if (ImGui::Combo("Cursor Shape (Tab)", &currentShape, shapes, IM_ARRAYSIZE(shapes))) {
            m_cursorShape = static_cast<CursorShape>(currentShape);
        }

        // The row is emitted either way, and the text is kept short enough that a slider row is
        // always the widest thing in the panel. Both matter now that the window sizes itself to its
        // contents: a hint that appeared and vanished would change the height on every material
        // change, and one wider than the sliders would change the width -- which is exactly the
        // resizing this layout exists to stop.
        if (m_currentMaterial == MaterialType::BlackHole) {
            ImGui::TextDisabled("One voxel per hole (max 8).");
        } else {
            ImGui::TextDisabled(" ");
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

        ImGui::PopItemWidth();

        ImGui::Separator();
        ImGui::Checkbox("Show Profiler", &m_showProfiler);
        ImGui::End();

        // Advanced whether or not the panel is open. The cursor is shared with the breakdown series
        // the renderer writes into, so freezing it while the profiler is hidden would leave those
        // three piling into one slot and the graph would show a minute of nothing on reopening.
        const float currentFrameTime = 1000.0f / ImGui::GetIO().Framerate;
        m_frameTimeHistory[m_historyIdx] = currentFrameTime;
        m_historyIdx = (m_historyIdx + 1) % kHistoryLength;

        if (m_showProfiler) {
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
                kHistoryLength,
                m_historyIdx,
                "ms / frame",
                0.0f, FLT_MAX,
                ImVec2(ImGui::GetContentRegionAvail().x, 80.0f)
            );

            ImGui::Separator();
            buildFrameBreakdown();
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

    // FUNCTION: setFrameTimings
    // One frame's breakdown, pushed in by the renderer at the end of its loop. Written into the same
    // ring the frame-time graph uses and sharing its cursor, so the four series line up on one time
    // axis and one sample column means one frame in all of them.
    //
    // The two GPU figures trail the CPU one by a single frame, and there is no way around that: a
    // frame's timestamps cannot be read until that frame's GPU work has finished, which is after the
    // point where they would have to be recorded. On a graph where one pixel column already covers a
    // dozen frames it is far below anything visible, and the averages are unaffected entirely.
    //
    // gpuValid is false when the device cannot write timestamps on this queue, in which case the two
    // GPU series are left flat and the panel says so rather than drawing a pair of convincing zeroes.
    void setFrameTimings(float cpuMs, float computeMs, float raymarchMs, bool gpuValid) {
        // The renderer's index is one behind: buildUI advanced the cursor before this frame's work
        // was measured, so these belong to the slot it just wrote.
        const int slot = (m_historyIdx + kHistoryLength - 1) % kHistoryLength;
        m_cpuHistory[slot] = cpuMs;
        m_computeHistory[slot] = gpuValid ? computeMs : 0.0f;
        m_raymarchHistory[slot] = gpuValid ? raymarchMs : 0.0f;
        m_gpuTimingValid = gpuValid;
    }

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

    // One minute of history at 60fps. All four series share m_historyIdx so a given index refers to
    // the same frame in each -- which is what lets them be drawn on one set of axes.
    static constexpr int kHistoryLength = 3600;
    float m_frameTimeHistory[kHistoryLength] = { 0.0f };
    float m_cpuHistory[kHistoryLength] = { 0.0f };
    float m_computeHistory[kHistoryLength] = { 0.0f };
    float m_raymarchHistory[kHistoryLength] = { 0.0f };
    int m_historyIdx = 0;
    bool m_gpuTimingValid = false;

    // Red CPU, green compute, blue raymarch. Lifted off pure primaries because a pure blue line on
    // ImGui's dark frame background is genuinely hard to follow -- the hues are still unmistakably
    // red/green/blue, just raised to where all three read at one pixel wide.
    static ImU32 cpuColor()      { return IM_COL32(240,  80,  80, 255); }
    static ImU32 computeColor()  { return IM_COL32( 90, 215,  95, 255); }
    static ImU32 raymarchColor() { return IM_COL32( 95, 160, 255, 255); }

    // FUNCTION: seriesAverage
    // Mean over the whole ring. Averaged rather than sampled because the per-frame figures are noisy
    // enough that a live readout of the latest value is unreadable -- it flickers through a range
    // wider than the differences the panel exists to show.
    static float seriesAverage(const float* series) {
        float sum = 0.0f;
        for (int i = 0; i < kHistoryLength; i++) sum += series[i];
        return sum / float(kHistoryLength);
    }

    // FUNCTION: plotSeries
    // Draws one series into an already-reserved rect, downsampled to one point per pixel column.
    //
    // The reducer is max, not mean: this is a profiler, and a stall that lasts three frames out of
    // sixty is exactly what someone reads this graph to find. Averaging into the bucket would smooth
    // that spike into the noise floor and hide the thing worth seeing.
    void plotSeries(ImDrawList* drawList, const float* series, ImU32 color,
                    ImVec2 topLeft, ImVec2 size, float scaleMax) const {
        const int columns = std::max(1, std::min(int(size.x), kHistoryLength));
        std::vector<ImVec2> points;
        points.reserve(columns);

        for (int c = 0; c < columns; c++) {
            const int from = (c * kHistoryLength) / columns;
            const int to = std::max(from + 1, ((c + 1) * kHistoryLength) / columns);

            float peak = 0.0f;
            for (int i = from; i < to; i++) {
                // Oldest sample sits at the write cursor, so the ring unrolls from there.
                peak = std::max(peak, series[(m_historyIdx + i) % kHistoryLength]);
            }

            const float x = topLeft.x + (size.x * float(c)) / float(columns - 1 > 0 ? columns - 1 : 1);
            const float y = topLeft.y + size.y * (1.0f - std::clamp(peak / scaleMax, 0.0f, 1.0f));
            points.push_back(ImVec2(x, y));
        }

        drawList->AddPolyline(points.data(), int(points.size()), color, 0, 1.5f);
    }

    // FUNCTION: buildFrameBreakdown
    // The three-line graph: where a frame's work actually goes.
    //
    // Drawn by hand rather than with PlotLines because PlotLines takes one series per widget and
    // stacks them vertically -- three separate graphs with three independent vertical scales, which
    // is precisely the comparison this is meant to make possible. One shared scale is the point.
    //
    // The three do NOT sum to the frame time, and the panel says so. CPU work overlaps the GPU work
    // of the previous frame, and under vsync the rest of the frame is spent waiting on the presenter;
    // treating these as slices of a pie would be wrong. They are three measured durations.
    void buildFrameBreakdown() {
        ImGui::Text("Frame Breakdown:");

        const float cpuAvg = seriesAverage(m_cpuHistory);
        const float computeAvg = seriesAverage(m_computeHistory);
        const float raymarchAvg = seriesAverage(m_raymarchHistory);

        ImGui::TextColored(ImColor(cpuColor()), "CPU              %6.3f ms", cpuAvg);
        if (m_gpuTimingValid) {
            ImGui::TextColored(ImColor(computeColor()),  "Compute shader   %6.3f ms", computeAvg);
            ImGui::TextColored(ImColor(raymarchColor()), "Fragment shader  %6.3f ms", raymarchAvg);
        } else {
            ImGui::TextDisabled("Compute shader      n/a");
            ImGui::TextDisabled("Fragment shader     n/a");
            ImGui::TextDisabled("(GPU timestamps unsupported on this queue)");
        }

        // Scale to the tallest peak anywhere in the window so all three share one axis. The 0.1 ms
        // floor stops an idle frame from magnifying rounding noise into a full-height sawtooth.
        float scaleMax = 0.1f;
        for (int i = 0; i < kHistoryLength; i++) {
            scaleMax = std::max(scaleMax, m_cpuHistory[i]);
            scaleMax = std::max(scaleMax, m_computeHistory[i]);
            scaleMax = std::max(scaleMax, m_raymarchHistory[i]);
        }

        const ImVec2 size(ImGui::GetContentRegionAvail().x, 80.0f);
        const ImVec2 topLeft = ImGui::GetCursorScreenPos();
        // Reserves the rect and consumes the input over it, so the graph occupies real layout space
        // and the window's auto-sizing accounts for it.
        ImGui::InvisibleButton("##breakdown", size);
        const ImVec2 bottomRight(topLeft.x + size.x, topLeft.y + size.y);

        ImDrawList* drawList = ImGui::GetWindowDrawList();
        drawList->AddRectFilled(topLeft, bottomRight, ImGui::GetColorU32(ImGuiCol_FrameBg));
        drawList->PushClipRect(topLeft, bottomRight, true);

        plotSeries(drawList, m_cpuHistory, cpuColor(), topLeft, size, scaleMax);
        if (m_gpuTimingValid) {
            plotSeries(drawList, m_computeHistory, computeColor(), topLeft, size, scaleMax);
            plotSeries(drawList, m_raymarchHistory, raymarchColor(), topLeft, size, scaleMax);
        }

        drawList->PopClipRect();

        ImGui::Text("scale 0 - %.2f ms", scaleMax);
        ImGui::SameLine();
        ImGui::TextDisabled("(?)");
        if (ImGui::IsItemHovered()) {
            ImGui::SetTooltip(
                "Three measured durations, not a division of the frame.\n\n"
                "CPU excludes time parked waiting on the GPU or the presenter,\n"
                "so it means work done rather than time elapsed. The two GPU\n"
                "figures come from timestamps around the dispatch loop and the\n"
                "raymarch draw; the UI itself is recorded after the last one and\n"
                "is not counted. They do not sum to the frame time -- CPU work\n"
                "overlaps the previous frame's GPU work, and under vsync the\n"
                "remainder is spent waiting on the display.");
        }
    }

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
        // Only the hottest stage gets a key. The cooler ones exist to be inspected, not poured --
        // placing a half-cooled flow by hand is a debugging affordance, not a building material.
        // Dark stone is dropdown-only for the same reason; key 0 is deliberately left free.
        if (ImGui::IsKeyPressed(ImGuiKey_9)) m_currentMaterial = MaterialType::LavaHottest;

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