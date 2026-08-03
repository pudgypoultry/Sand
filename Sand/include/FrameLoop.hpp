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
// This does not return in either configuration, which is deliberate -- so a caller cannot be
// written that only happens to work on one platform. On the desktop it returns after the loop
// ends, exactly as the while loop it replaces did. On a driven platform it does not return at all:
// the callback is registered and the stack is unwound out from under the caller, so anything
// written after the call would silently never run.
//
// The consequence worth knowing: on a driven platform, destructors between here and main() do not
// run and no cleanup path executes. Nothing is leaked that matters, because the process is a tab
// and the tab is being closed, but a shutdown that has to happen must be attached to the page's
// unload rather than placed after this call.
void run(std::function<bool()> keepGoing, std::function<void()> frame);

} // namespace FrameLoop
