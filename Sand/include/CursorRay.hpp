#pragma once

#include "Config.hpp"
#include "FrameConstants.hpp"
#include "Window.hpp"
#include "UIManager.hpp"

// Where the mouse is pointing in the world, and what a click there would place.
//
// This is the CPU half of the cursor: it rebuilds the same camera basis `raymarch.frag` uses, casts
// one ray through the mouse position, and writes the answer into the frame constants both shaders
// read. It names no graphics API, and it lived inside VulkanRenderer::drawFrame until the web
// renderer needed exactly the same sixty lines -- which is the argument for it being here instead.
//
// Sharing it is not only about the duplication. The maths has to agree with the fragment shader's
// or the outlined cursor sits somewhere other than where the click lands, and a second copy is a
// second thing to keep in step with a shader that neither copy can see.
void buildFrameConstants(const Window& window,
                         const UIManager& ui,
                         const TuningParams& tuning,
                         float time,
                         FrameConstants& fc);
