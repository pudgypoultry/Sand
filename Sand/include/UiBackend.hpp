#pragma once

#include "GfxBackend.hpp"

// The two points in a frame where Dear ImGui has to talk to the graphics API, reduced to calls
// with no API types in them.
//
// UIManager builds about six hundred lines of panels and knows nothing about how they are drawn;
// keeping these two out of it is what makes that true. Everything else the backend needs -- the
// device, the queue, the render pass, the command buffer -- is already owned by the renderer, so
// initialisation and draw submission live with the backend rather than being threaded through the
// UI class as ten constructor parameters.
//
// Implemented once per backend: UiBackendVulkan.cpp, UiBackendWebGpu.cpp.
namespace UiBackend {

// Platform and renderer NewFrame, in that order. Called at the top of UIManager::buildUI, before
// ImGui::NewFrame.
void newFrame();

// Renderer and platform Shutdown. The ImGui context itself is destroyed by UIManager afterwards --
// the backends must go first, because they hold references into it.
void shutdown();

} // namespace UiBackend
