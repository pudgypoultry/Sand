#pragma once

#include <functional>

// Who owns the thread.
//
// A desktop frame loop is a while loop: the program holds the thread and gives it up when the
// window closes. A browser tab cannot work that way -- the same thread runs the event loop, the
// compositor and the garbage collector, so a loop that never returns is a page that never paints
// and a tab that has to be killed. The runtime wants one frame's work and control back.
//
// Both shapes are the same two pieces, a predicate and a frame, so this takes those and applies
// whichever shape the platform needs.
namespace FrameLoop {

// Runs `frame` repeatedly while `keepGoing` returns true.
//
// On the desktop this returns when the loop ends, exactly as the while loop it replaces did.
//
// On a driven platform it returns IMMEDIATELY, having registered the callback -- the frames happen
// afterwards, driven by the browser. So anything written after the call runs before the first
// frame, not after the last one, and a cleanup path placed there would tear down a renderer that
// is about to be used. There is no teardown here for that reason; the tab closing is the teardown,
// and anything that genuinely must happen at the end belongs on the page's unload event.
void run(std::function<bool()> keepGoing, std::function<void()> frame);

} // namespace FrameLoop
