#pragma once

// Which graphics backend this binary is built against.
//
// Exactly one is ever defined, and the choice is made at compile time rather than at runtime: a
// desktop build has no WebGPU implementation linked into it and a web build has no Vulkan, so
// there is nothing to select between once the binary exists. That also keeps the cost at zero --
// no vtable, no indirection, and the Vulkan path compiles to exactly what it did before this
// header existed.
//
// Emscripten implies WebGPU because it is the only compute-capable API a browser offers. WebGL2
// has no compute shaders at all, so there is no fallback to detect for.

#if defined(SAND_BACKEND_VULKAN) && defined(SAND_BACKEND_WEBGPU)
#error "SAND_BACKEND_VULKAN and SAND_BACKEND_WEBGPU are mutually exclusive."
#endif

#if !defined(SAND_BACKEND_VULKAN) && !defined(SAND_BACKEND_WEBGPU)
#  if defined(__EMSCRIPTEN__)
#    define SAND_BACKEND_WEBGPU 1
#  else
#    define SAND_BACKEND_VULKAN 1
#  endif
#endif

// True when the frame loop cannot own the thread. A browser tab has a single thread that also runs
// the event loop and the compositor, so a `while (!shouldClose())` loop there never yields and the
// page hangs before the first frame is presented. Emscripten's answer is to hand one frame's worth
// of work to the runtime and return; see the driver in main.cpp.
#if defined(__EMSCRIPTEN__)
#  define SAND_LOOP_IS_DRIVEN 1
#else
#  define SAND_LOOP_IS_DRIVEN 0
#endif

// True when writing a file persists it. Under Emscripten std::ofstream succeeds and writes into an
// in-memory filesystem that is discarded when the tab closes, which is the worst shape a failure
// can take: the options screen reports success and the settings are gone on reload. Storage.hpp
// routes the config write somewhere that survives instead.
#if defined(__EMSCRIPTEN__)
#  define SAND_FILESYSTEM_IS_PERSISTENT 0
#else
#  define SAND_FILESYSTEM_IS_PERSISTENT 1
#endif
