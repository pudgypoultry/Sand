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
    // simulate_infinite_loop 0, so this RETURNS and the callback runs afterwards. The 1 form does
    // not return -- it unwinds by throwing -- which was harmless only while Emscripten's default
    // disabled exception catching. Now that this build enables it so error messages survive, that
    // throw would travel up into main()'s catch(...) and be reported as a fatal error moments
    // before the first frame. Returning avoids the interaction rather than relying on the two
    // settings staying compatible.
    //
    // Nothing tears down when main() returns: EXIT_RUNTIME defaults to 0, so the runtime stays
    // alive for exactly this pattern and the loop keeps being called.
    emscripten_set_main_loop(tick, 0, 0);
}

#endif // SAND_LOOP_IS_DRIVEN

} // namespace FrameLoop
