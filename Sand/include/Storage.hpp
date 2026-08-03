#pragma once

#include <string>

// Making a written file survive the next launch.
//
// On the desktop this is nothing at all: std::ofstream writes to the disk and the disk is still
// there tomorrow. In a browser it is not -- Emscripten gives the program an in-memory filesystem,
// so the config write succeeds, reports success, and evaporates when the tab closes. That is a
// nastier failure than an outright error, because the options screen would say the settings were
// saved and mean it.
//
// Rather than replace the file I/O -- which reads the existing config.txt back so it can rewrite
// values in place and keep every comment -- these two bracket it. The file code stays exactly as
// it is and stays the thing being tested; the web build copies the file in before it is read and
// out after it is written.
namespace Storage {

// True when the ordinary filesystem already persists. False means prime/persist are doing real
// work, which the UI can say out loud rather than leaving the user to find out.
bool isPersistent();

// Restores a previously persisted copy of `path` into the filesystem, if there is one. Call once
// at startup BEFORE reading the file. Does nothing when a copy has never been saved, which leaves
// the shipped default in place -- so a first visit gets the packaged config rather than an empty
// one.
void prime(const std::string& path);

// Copies `path` out to wherever it survives. Call after a successful write. Returns false if the
// copy could not be made; the file itself is already written either way, so a false here means
// "this will not outlive the session" and not "the save failed".
bool persist(const std::string& path);

} // namespace Storage
