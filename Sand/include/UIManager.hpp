#pragma once

#include <imgui.h>
#include <stdexcept>
#include <vector>
#include <string>
#include <cfloat>
#include <cstdint>
#include <algorithm>
#include <cstdio>
#include <cstring>
#include "ConfigSchema.hpp"
#include "UiBackend.hpp"

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
    DarkStone = 12,
    // Five views of one head count, exactly as the lava stages are five views of one coolness --
    // see the LOCUSTS block in falling_sand.comp. LocustSwarm is the only one meant to be placed in
    // normal play and is the one on the shortcut; the others are in the dropdown so a swarm can be
    // dropped in partway through its life.
    LocustSparse = 13,
    LocustSmall = 14,
    LocustSwarm = 15,
    LocustLarge = 16,
    LocustPlague = 17,
    // Trees: a trunk that drinks from the soil and grows, and the leaves its crown puts out. Both
    // are placeable so a forest can be started by hand, but neither is on a shortcut -- trees are
    // meant to arrive by blooming out of grass, not by being painted.
    TreeTrunk = 18,
    TreeLeaf = 19,
    // What a fire leaves behind. Placeable so a drift can be laid down by hand, but not on a
    // shortcut -- the whole point of ash is that it arrives by burning something.
    Ash = 20
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

    // Creates the ImGui context and applies the theme. Deliberately takes nothing: the graphics
    // backend is initialised separately by whichever renderer owns the device handles, so this
    // class -- and the six hundred lines of panels below it -- compiles unchanged against Vulkan
    // and WebGPU alike. Call this BEFORE the backend's own init, which needs the context to exist.
    void init() {
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
    }

    // Tears down the ImGui context. The graphics backend must already have been shut down --
    // UiBackend::shutdown holds references into the context and has to go first.
    void shutdownUi() {
        ImGui::DestroyContext();
    }

    void buildUI() {
        UiBackend::newFrame();
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
                                "Lava", "Lava (Hot)", "Lava (Warm)", "Lava (Cooling)", "Dark Stone",
                                "Locusts (10)", "Locusts (20)", "Locusts (30)", "Locusts (40)",
                                "Locusts (50)", "Tree Trunk", "Tree Leaves", "Ash" };
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
        if (ImGui::Button("Options...")) m_showOptions = true;
        ImGui::End();

        if (m_showOptions) buildOptions();

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

            ImGui::Separator();
            ImGui::Text("Tick %u / %u", m_tickCount, kTickWrap);
            if (ImGui::IsItemHovered()) {
                ImGui::SetTooltip(
                    "Simulation dispatches, not frames. The speed slider issues several per frame,\n"
                    "so this runs ahead of the frame counter by exactly that multiple.\n\n"
                    "It is the unit the cloud field's timers are counted in -- notably\n"
                    "cloud.still_ticks_to_storm -- so it is the clock to watch weather against.\n"
                    "Wraps at %u.", kTickWrap);
            }

            // Weather, read back from the simulation's own counters rather than inferred here --
            // whether the sky has settled is a fact only the compute shader knows.
            if (!m_simStateValid) {
                ImGui::TextDisabled("Rain: waiting for the first readback");
            } else if (m_rainPhase != 0u) {
                ImGui::TextColored(ImVec4(0.45f, 0.70f, 1.0f, 1.0f),
                                   "Rain: FALLING (began at tick %u)", m_lastRainTick);
            } else if (m_lastRainTick > 0u) {
                ImGui::Text("Rain: last at tick %u, %u ticks ago",
                            m_lastRainTick, m_simTick - m_lastRainTick);
            } else {
                ImGui::Text("Rain: none yet this world");
            }
            if (ImGui::IsItemHovered()) {
                ImGui::SetTooltip(
                    "A rain event begins when a storm check finds that no cloud block moved on the\n"
                    "previous tick. Checks happen every cloud.check_interval_ticks ticks, so the\n"
                    "gap between events is a multiple of that interval plus however long the last\n"
                    "storm took to fall.\n\n"
                    "These ticks are the simulation's own counter, not the one above -- that one is\n"
                    "the CPU's and wraps, this one does not.");
            }

            ImGui::Separator();
            ImGui::Checkbox("Show cloud blocks", &m_showCloudBlocks);
            if (ImGui::IsItemHovered()) {
                ImGui::SetTooltip(
                    "Draws the cloud field's blocks as solid voxels.\n\n"
                    "They are invisible in normal play -- what you see is the cloud drawn above\n"
                    "each column, sized from how many are stacked there. This shows the blocks\n"
                    "themselves, which is the only way to tell an empty sky from one whose cloud\n"
                    "is simply too thin to draw.");
            }
            ImGui::End();
        }

        m_firstFrame = false;

        ImGui::Render();
    }

    int getBrushSize() const { return m_brushSize; }
    CursorShape getCursorShape() const { return m_cursorShape; }

    // Debug view toggle, off by default -- cloud blocks are meant to be invisible.
    bool showCloudBlocks() const { return m_showCloudBlocks; }

    // FUNCTION: advanceTicks
    // Counts simulation dispatches, which is what the shader's own timers count in.
    //
    // Kept on the CPU rather than read back from SimStats deliberately: the renderer already knows
    // exactly how many dispatches it issued, and the alternative is a GPU-to-CPU readback -- which
    // on the web means an asynchronous buffer map, for a number that is already sitting in a local.
    void advanceTicks(int steps) {
        if (steps > 0) m_tickCount = (m_tickCount + uint32_t(steps)) % kTickWrap;
    }
    uint32_t tickCount() const { return m_tickCount; }

    // FUNCTION: resetTicks
    // Puts the CPU's tick counter back to zero when the world does, so it keeps step with the
    // simulation's own simTick rather than drifting apart from it over a session.
    void resetTicks() { m_tickCount = 0; }

    // FUNCTION: setSimState
    // The simulation's weather counters, read back from SimStats. `valid` is false until the first
    // readback lands, which on the web is several frames in -- the map is asynchronous.
    void setSimState(uint32_t rainPhase, uint32_t simTick, uint32_t lastRainTick, bool valid) {
        m_rainPhase = rainPhase;
        m_simTick = simTick;
        m_lastRainTick = lastRainTick;
        m_simStateValid = valid;
    }
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

    // Called once at startup and again after every apply, so the screen always opens showing what
    // the simulation is actually running rather than what it was running when the process started.
    void setTuning(const TuningParams& t) { m_pendingTuning = t; m_liveTuning = t; }
    const TuningParams& pendingTuning() const { return m_pendingTuning; }

    bool consumeApplyOptions() {
        bool requested = m_applyOptions;
        m_applyOptions = false;
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
    bool m_showCloudBlocks = false;

    // Wraps rather than saturating, so the display stays a fixed width and a long session cannot
    // run it into a number nobody can read at a glance.
    static constexpr uint32_t kTickWrap = 100000u;
    uint32_t m_tickCount = 0;

    uint32_t m_rainPhase = 0;
    uint32_t m_simTick = 0;
    uint32_t m_lastRainTick = 0;
    bool     m_simStateValid = false;
    bool m_showOptions = false;
    bool m_firstFrame = true; // drives the one-shot startup window placement in buildUI

    // The options screen edits a COPY and hands it over only when Apply is pressed. Editing the live
    // values would mean every intermediate position of every slider was a config the simulation
    // briefly ran on -- dragging the grid size from 128 to 256 would rebuild the world at every
    // width in between.
    TuningParams m_pendingTuning{};
    TuningParams m_liveTuning{};
    bool m_applyOptions = false;

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

    // FUNCTION: drawOptionField
    // One tunable, rendered from its schema entry. Nothing here knows what the field MEANS -- the
    // label, the bounds and the tooltip all come out of the table -- which is what keeps adding a
    // tunable to one line in one file instead of a widget here as well.
    void drawOptionField(const ConfigField& f) {
        // "label##key" so the visible text stays readable while the widget's identity is the key.
        // Several sections have a field called "Spread chance"; without a unique id ImGui would
        // treat them as the same widget and dragging one would move the other.
        char id[160];
        std::snprintf(id, sizeof(id), "%s##%s", f.label, f.key);

        // Input IS allowed here, unlike the main panel's sliders. There it is suppressed because
        // Tab used to land on a slider and turn it into a text box by accident; here typing an exact
        // number is the entire point of the screen, and anything typed is clamped to the field's
        // bounds by ImGui and again by sanitizeTuning before it reaches the simulation.
        //
        // Probability fields get a logarithmic scale. Their interesting values live near zero --
        // grass grows at 0.001 -- and on a linear 0..1 bar every one of them is the same pixel.
        if (f.kind == FieldKind::UInt) {
            int v = static_cast<int>(fieldUInt(m_pendingTuning, f));
            if (ImGui::SliderInt(id, &v, static_cast<int>(f.lo), static_cast<int>(f.hi))) {
                fieldUInt(m_pendingTuning, f) = static_cast<uint32_t>(std::max(0, v));
            }
        } else {
            float v = fieldFloat(m_pendingTuning, f);
            const bool fine = (f.hi <= 1.0);
            ImGuiSliderFlags flags = fine ? ImGuiSliderFlags_Logarithmic : 0;
            if (ImGui::SliderFloat(id, &v, static_cast<float>(f.lo), static_cast<float>(f.hi),
                                   fine ? "%.4f" : "%.3f", flags)) {
                fieldFloat(m_pendingTuning, f) = v;
            }
        }

        if (f.help && ImGui::IsItemHovered()) ImGui::SetTooltip("%s", f.help);
    }

    // FUNCTION: buildOptions
    // The options screen: every tunable the config file has, grouped the way the file groups them.
    //
    // The tabs are not a hand-written list. The schema is ordered by section and each section is one
    // contiguous run, so walking the array and starting a tab whenever the section name changes
    // reproduces the file's own structure for free -- and a new section appears here the moment one
    // appears in the table, with nothing to keep in step.
    void buildOptions() {
        ImGui::SetNextWindowSize(ImVec2(ImGui::GetFontSize() * 34.0f, ImGui::GetFontSize() * 30.0f),
                                 ImGuiCond_FirstUseEver);
        if (!ImGui::Begin("Options", &m_showOptions)) { ImGui::End(); return; }

        const float footer = ImGui::GetFrameHeightWithSpacing() * 2.4f;
        ImGui::BeginChild("##optionScroll", ImVec2(0.0f, -footer));
        ImGui::PushItemWidth(ImGui::GetFontSize() * 9.0f);

        if (ImGui::BeginTabBar("##optionTabs")) {
            size_t i = 0;
            while (i < kConfigFieldCount) {
                const char* section = kConfigFields[i].section;
                size_t end = i;
                while (end < kConfigFieldCount && std::strcmp(kConfigFields[end].section, section) == 0) end++;

                if (ImGui::BeginTabItem(section)) {
                    for (size_t j = i; j < end; j++) drawOptionField(kConfigFields[j]);
                    ImGui::EndTabItem();
                }
                i = end;
            }
            ImGui::EndTabBar();
        }

        ImGui::PopItemWidth();
        ImGui::EndChild();

        ImGui::Separator();

        // Pinned below the scroll region, so Apply is reachable without scrolling to the end of
        // whichever tab happens to be open.
        // Both buttons reload, and a reload is a reload: the world is wiped and the camera goes
        // back to its framing pose either way. Revert differs only in WHICH values it reloads --
        // it throws the pending edits away and reloads what is already live -- so it doubles as the
        // plain "start over" this screen would otherwise not have.
        if (ImGui::Button("Apply and Reload")) m_applyOptions = true;
        ImGui::SameLine();
        if (ImGui::Button("Revert and Reload")) {
            m_pendingTuning = m_liveTuning;
            m_applyOptions = true;
        }
        ImGui::SameLine();
        // Loads the built-in values into the sliders WITHOUT applying them, so they can be looked at
        // and adjusted before anything is committed. Apply is still the only thing that acts.
        if (ImGui::Button("Load Defaults")) m_pendingTuning = TuningParams{};

        if (m_pendingTuning.gridWidth != m_liveTuning.gridWidth) {
            ImGui::TextColored(ImVec4(1.0f, 0.75f, 0.35f, 1.0f),
                               "Grid size changed: the world will be rebuilt at %u^3.",
                               m_pendingTuning.gridWidth);
        } else {
            ImGui::TextDisabled("Either button clears the world and writes config.txt.");
        }

        ImGui::End();
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
        // Dark stone is dropdown-only for the same reason.
        if (ImGui::IsKeyPressed(ImGuiKey_9)) m_currentMaterial = MaterialType::LavaHottest;
        // Same rule for the swarm stages: one key, and it places the 30-strong swarm. The other four
        // are dropdown-only, since a swarm's size is meant to be something it earns or loses.
        if (ImGui::IsKeyPressed(ImGuiKey_0)) m_currentMaterial = MaterialType::LocustSwarm;

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