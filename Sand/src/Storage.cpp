// Storage.cpp -- persistence for written files, per platform.

#include "Storage.hpp"
#include "GfxBackend.hpp"

#include <fstream>
#include <sstream>

#if !SAND_FILESYSTEM_IS_PERSISTENT
#include <emscripten.h>
#include <cstdlib>
#endif

namespace Storage {

#if SAND_FILESYSTEM_IS_PERSISTENT

bool isPersistent() { return true; }
void prime(const std::string&) {}
bool persist(const std::string&) { return true; }

bool writeUserFile(const std::string& path, const std::string& contents, std::string& error) {
    std::ofstream out(path, std::ios::binary | std::ios::trunc);
    if (!out) {
        error = "could not open " + path + " for writing";
        return false;
    }
    out.write(contents.data(), static_cast<std::streamsize>(contents.size()));
    if (!out) {
        error = "write to " + path + " failed part way through";
        return false;
    }
    return true;
}

void readUserFile(const std::string& path, ReadCallback cb) {
    std::ifstream in(path, std::ios::binary);
    if (!in) {
        cb(false, std::string(), "could not open " + path);
        return;
    }
    std::ostringstream ss;
    ss << in.rdbuf();
    // Inline, before returning. The browser's version cannot do this and the callers are written
    // for the browser's shape; this one just happens to finish immediately.
    cb(true, ss.str(), std::string());
}

#else

bool isPersistent() { return false; }

namespace {

// localStorage rather than IDBFS. IDBFS is the more capable option -- a real filesystem, mounted
// and synced -- but syncing it is asynchronous, and the two moments this project cares about are
// both places where waiting is awkward: reading the config happens before the first frame, and
// writing it happens inside the options screen's Apply. localStorage is synchronous and holds a
// few megabytes; config.txt is four kilobytes. If the world ever needs saving too, that is the
// point to move to IDBFS and take the asynchrony on.
//
// The key is namespaced because a page may host more than this one program.
std::string keyFor(const std::string& path) { return "sand:file:" + path; }

std::string readWholeFile(const std::string& path) {
    std::ifstream in(path, std::ios::binary);
    if (!in) return std::string();
    std::ostringstream ss;
    ss << in.rdbuf();
    return ss.str();
}

} // namespace

void prime(const std::string& path) {
    const std::string key = keyFor(path);

    // Returns a malloc'd copy that this side owns, or 0 when the key is absent. Absent is the
    // ordinary first-visit case and must leave the packaged file alone.
    char* stored = static_cast<char*>(EM_ASM_PTR({
        var v = null;
        try { v = window.localStorage.getItem(UTF8ToString($0)); } catch (e) { v = null; }
        if (v === null) return 0;
        var len = lengthBytesUTF8(v) + 1;
        var buf = _malloc(len);
        stringToUTF8(v, buf, len);
        return buf;
    }, key.c_str()));

    if (!stored) return;

    {
        std::ofstream out(path, std::ios::binary | std::ios::trunc);
        if (out) out << stored;
    }
    free(stored);
}

bool persist(const std::string& path) {
    const std::string contents = readWholeFile(path);
    if (contents.empty()) return false;

    const std::string key = keyFor(path);

    // Quota is the realistic failure -- a full or disabled store throws rather than returning
    // anything -- so the result is reported instead of assumed.
    return EM_ASM_INT({
        try {
            window.localStorage.setItem(UTF8ToString($0), UTF8ToString($1));
            return 1;
        } catch (e) {
            return 0;
        }
    }, key.c_str(), contents.c_str()) != 0;
}

// --- user files: download out, picker in ---------------------------------------------------------
//
// Not localStorage. The two above use it because config.txt is four kilobytes and has to be read
// back by the program itself; a saved world is the user's file, belongs wherever they keep files,
// and at tens of kilobytes and up would be an unkind thing to put in a store measured in single
// megabytes.

namespace {

// The pending picker's callback. A single slot rather than a queue: one file dialog can be open at
// a time in any sane UI, and the caller already gates on that. Held at namespace scope because it
// has to outlive readUserFile's return -- the browser calls back on a later turn of the event loop.
ReadCallback g_pendingRead;

} // namespace

// Called from the JS in readUserFile below. extern "C" and KEEPALIVE because it has no C++ caller
// and the linker would otherwise strip it -- the same trap the EXPORTED_FUNCTIONS list in
// CMakeLists.txt exists for, and the reason this name is on that list.
extern "C" EMSCRIPTEN_KEEPALIVE void sandUserFileRead(const char* data, int failed) {
    if (!g_pendingRead) return;
    // Moved out before it is called, so a callback that starts another read -- which is not
    // expected, but is cheap to be safe about -- does not have its own slot cleared underneath it.
    ReadCallback cb;
    cb.swap(g_pendingRead);
    if (failed || !data) cb(false, std::string(), "the file could not be read");
    else cb(true, std::string(data), std::string());
}

bool writeUserFile(const std::string& path, const std::string& contents, std::string& error) {
    // The name only: a browser download has no directory to go to, and a path with slashes in it
    // would be sanitised by the browser into something the user did not expect.
    const size_t slash = path.find_last_of("/\\");
    const std::string name = (slash == std::string::npos) ? path : path.substr(slash + 1);

    const int ok = EM_ASM_INT({
        try {
            var name = UTF8ToString($0);
            var text = UTF8ToString($1);
            var blob = new Blob([text], { type: 'text/plain' });
            var url = URL.createObjectURL(blob);
            var a = document.createElement('a');
            a.href = url;
            a.download = name;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            // Revoked on a later tick rather than immediately: some browsers have not finished
            // reading the blob when click() returns, and revoking under them cancels the download.
            setTimeout(function() { URL.revokeObjectURL(url); }, 10000);
            return 1;
        } catch (e) {
            return 0;
        }
    }, name.c_str(), contents.c_str());

    if (!ok) {
        error = "the browser refused the download";
        return false;
    }
    return true;
}

void readUserFile(const std::string&, ReadCallback cb) {
    g_pendingRead = std::move(cb);

    EM_ASM({
        var input = document.createElement('input');
        input.type = 'file';
        input.accept = '.txt,.sand,text/plain';
        input.style.display = 'none';
        input.onchange = function() {
            var file = input.files && input.files[0];
            document.body.removeChild(input);
            if (!file) { Module._sandUserFileRead(0, 1); return; }
            var reader = new FileReader();
            reader.onload = function() {
                var text = reader.result;
                var len = lengthBytesUTF8(text) + 1;
                var buf = _malloc(len);
                stringToUTF8(text, buf, len);
                Module._sandUserFileRead(buf, 0);
                _free(buf);
            };
            reader.onerror = function() { Module._sandUserFileRead(0, 1); };
            reader.readAsText(file);
        };
        document.body.appendChild(input);
        // A cancelled picker fires no event at all in most browsers, so the pending callback is
        // simply left standing until the next read replaces it. That is precisely why loading must
        // NOT take a busy flag: there is no signal to clear one on, and the buttons would be dead
        // for the rest of the session the first time someone pressed Escape. Nothing is leaked by
        // the wait -- one std::function sits in the slot until the next attempt overwrites it.
        input.click();
    });
}

#endif // SAND_FILESYSTEM_IS_PERSISTENT

} // namespace Storage
