#pragma once

#include "GfxBackend.hpp"

// The one name main.cpp needs to know.
//
// Both renderers present the same two-line surface -- construct, then run() -- so the entry point
// is identical for either backend and the choice is a typedef rather than a branch. There is no
// base class on purpose: a virtual interface would buy runtime substitutability that nothing wants
// (a binary contains exactly one backend) at the price of a vtable on the hottest object in the
// program.

#ifdef SAND_BACKEND_VULKAN
#include "VulkanRenderer.hpp"
using Renderer = VulkanRenderer;
#else
#include "WebGpuRenderer.hpp"
using Renderer = WebGpuRenderer;
#endif
