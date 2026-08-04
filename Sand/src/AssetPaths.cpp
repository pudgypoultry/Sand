// AssetPaths.cpp
#include "AssetPaths.hpp"

#include <fstream>

#ifdef _WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

// FUNCTION: executableDir
// Path of the directory holding the running executable, with a trailing separator. Empty if it
// cannot be determined, which callers treat as "only the working directory is available".
std::string executableDir() {
#if defined(__EMSCRIPTEN__)
    // There is no executable and no directory containing one. What there is instead is a virtual
    // filesystem the assets were packaged into, mounted at the root, so that is the answer to the
    // question this function is actually being asked: where do the files live if not beside me.
    return "/";
#elif defined(_WIN32)
    char buffer[MAX_PATH];
    DWORD length = GetModuleFileNameA(nullptr, buffer, MAX_PATH);
    // A return of MAX_PATH means the buffer was too small and the result was truncated, so it is a
    // failure rather than a long answer.
    if (length == 0 || length >= MAX_PATH) return std::string();

    std::string path(buffer, length);
    size_t slash = path.find_last_of("\\/");
    if (slash == std::string::npos) return std::string();
    return path.substr(0, slash + 1);
#else
    return std::string();
#endif
}

// FUNCTION: resolveAssetPath
std::string resolveAssetPath(const std::string& relative) {
    {
        std::ifstream inWorkingDir(relative);
        if (inWorkingDir.is_open()) return relative;
    }

    const std::string dir = executableDir();
    if (!dir.empty()) {
        const std::string beside = dir + relative;
        std::ifstream nextToExe(beside);
        if (nextToExe.is_open()) return beside;
    }

    // Neither exists. Hand back what was asked for so the error names the file the caller wanted
    // rather than a path it never heard of.
    return relative;
}
