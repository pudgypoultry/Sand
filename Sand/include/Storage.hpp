#pragma once

#include <functional>
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

// --- Files the USER names, as opposed to files the program owns -----------------------------------
//
// The two above exist so config.txt survives a reload; these two are a different problem. A saved
// world is the user's document: on the desktop it is a path they typed, and in a browser it is a
// download going to wherever their downloads go and an upload coming back from a picker. Neither
// side can be expressed as "write a file and hope" the way the config can.
//
// Both are given a callback shape even though the desktop could return directly, because the
// browser's read genuinely cannot: a file picker resolves whenever the user gets round to choosing,
// which may be never. Handing the desktop the same shape -- where the callback simply fires before
// the call returns -- means the renderers have one path rather than an #if around each call site.

// Writes `contents` somewhere the user gets it. Desktop: `path`, verbatim. Web: a download named by
// the file part of `path`, ignoring any directory. Returns false and sets `error` on failure.
bool writeUserFile(const std::string& path, const std::string& contents, std::string& error);

// ok=true delivers `contents`; ok=false leaves it empty and puts the reason in `error`.
using ReadCallback = std::function<void(bool ok, std::string contents, std::string error)>;

// Asks for a file's contents. Desktop: reads `path` and invokes `cb` before returning. Web: opens
// the browser's file picker, ignores `path`, and invokes `cb` when the user chooses -- which is
// after this returns, on a later turn of the event loop, and never at all if they cancel.
//
// One read may be outstanding at a time; asking again while a picker is open replaces the pending
// callback and the earlier one is dropped without being called. Callers gate on that themselves
// (see UIManager::setWorldBusy) rather than this queueing, because a queue of file pickers is not
// a thing anyone wants.
void readUserFile(const std::string& path, ReadCallback cb);

} // namespace Storage
