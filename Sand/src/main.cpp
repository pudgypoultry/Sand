#include "Renderer.hpp"
#include "GfxBackend.hpp"
#include <iostream>
#include <stdexcept>
#include <cstdlib>

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

// FUNCTION: launchedFromExplorer
// True when this process owns the console it is writing to, which is what happens when the
// executable is double-clicked rather than run from a terminal.
//
// It matters because a console created for a process is destroyed the instant that process exits.
// Every fatal error this program can report -- a missing shader, no Vulkan driver, an unreadable
// config -- was being printed correctly and then wiped off the screen a few milliseconds later, so
// the whole thing looked like a window that opened and closed for no reason.
//
// GetConsoleProcessList reports how many processes are attached to the console. One is us and
// nobody else, so the console came with us and goes with us; two or more means a shell is attached
// and the text will still be on screen afterwards.
static bool launchedFromExplorer() {
#ifdef _WIN32
    // Exactly one, not "one or fewer". A zero means the call failed, and treating that as "we own
    // it" would leave the process sitting on a prompt nobody can see or answer.
    DWORD pids[2];
    return GetConsoleProcessList(pids, 2) == 1;
#else
    return false;
#endif
}

// FUNCTION: holdConsole
// Keeps a self-owned console open long enough to read the error above it. Deliberately silent when
// a shell is attached: pausing there would hang scripts and CI on a prompt nobody is watching.
static void holdConsole() {
    if (!launchedFromExplorer()) return;
    std::cerr << "\nPress Enter to close." << std::endl;
    std::cin.get();
}

int main() {
    // The renderer is constructed INSIDE the try. Its constructor loads the config and opens both
    // the window and the Vulkan context, all of which can throw, and none of that was covered while
    // it was declared above the block -- so the failures most likely to hit an unfamiliar machine
    // were the ones that produced no message at all.
    try {
#if SAND_LOOP_IS_DRIVEN
        // Deliberately leaked, and it has to be.
        //
        // On a driven platform run() REGISTERS the frame loop and returns; the frames happen
        // afterwards, and so does the asynchronous device callback that finishes initialisation. A
        // local here is destroyed the moment run() returns, which is before any of that -- so every
        // callback then reads a destroyed object. That is not theoretical: it showed up as a grid
        // sized 6568 MiB, because gridWidth was being read out of freed memory, and as a canvas
        // reporting 0x0 because the Window had been deleted underneath it.
        //
        // The renderer must outlive main, and on a page the tab closing is the only teardown there
        // is, so leaking it is exactly right rather than a shortcut.
        auto* app = new Renderer();
        app->run();
#else
        Renderer app;
        app.run();
#endif
    }
    catch (const std::exception& e) {
        std::cerr << "\nFatal error: " << e.what() << "\n";
        holdConsole();
        return EXIT_FAILURE;
    }
    catch (...) {
        std::cerr << "\nFatal error: unrecognised exception.\n";
        holdConsole();
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
