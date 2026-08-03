// FrameLoop.cpp -- the frame loop, per platform.

#include "FrameLoop.hpp"
#include "GfxBackend.hpp"

#if SAND_LOOP_IS_DRIVEN
#include <emscripten.h>
#endif

namespace FrameLoop {

#if !SAND_LOOP_IS_DRIVEN

void run(std::function<bool()> keepGoing, std::function<void()> frame) {
    while (keepGoing()) {
        frame();
    }
}

#else

namespace {

struct Driver {
    std::function<bool()> keepGoing;
    std::function<void()> frame;
};

// Deliberately leaked, because the alternative is worse. emscripten_set_main_loop keeps calling
// this after run() has unwound, so the state has to outlive the frame that created it; a local, a
// member, or anything owned by a smart pointer up the stack is a dangling read on the first tick.
Driver* g_driver = nullptr;

void tick() {
    if (!g_driver->keepGoing()) {
        emscripten_cancel_main_loop();
        return;
    }
    g_driver->frame();
}

} // namespace

void run(std::function<bool()> keepGoing, std::function<void()> frame) {
    g_driver = new Driver{ std::move(keepGoing), std::move(frame) };

    // fps 0 means requestAnimationFrame, which is the only correct answer for anything that draws:
    // it paces to the display's refresh rate and, crucially, stops entirely while the tab is in
    // the background. A fixed rate here would keep simulating a world nobody is looking at and
    // drain a laptop battery to do it.
    //
    // simulate_infinite_loop 1 makes this call not return, matching the desktop shape. It does so
    // by throwing to unwind the stack, so nothing after it runs -- see the note in the header.
    emscripten_set_main_loop(tick, 0, 1);
}

#endif // SAND_LOOP_IS_DRIVEN

} // namespace FrameLoop
