// Storage.cpp -- persistence for written files, per platform.

#include "Storage.hpp"
#include "GfxBackend.hpp"

#if !SAND_FILESYSTEM_IS_PERSISTENT
#include <emscripten.h>
#include <cstdlib>
#include <fstream>
#include <sstream>
#endif

namespace Storage {

#if SAND_FILESYSTEM_IS_PERSISTENT

bool isPersistent() { return true; }
void prime(const std::string&) {}
bool persist(const std::string&) { return true; }

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

#endif // SAND_FILESYSTEM_IS_PERSISTENT

} // namespace Storage
