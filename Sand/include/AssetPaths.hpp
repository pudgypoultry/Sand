// AssetPaths.hpp
#pragma once

#include <string>

// Where the program looks for the files it cannot run without: the shaders and config.txt.
//
// These were opened by bare relative paths, which resolve against the WORKING directory rather than
// against the executable. Visual Studio sets the working directory to the project folder, where the
// assets live, so F5 worked and nothing looked wrong -- but double-clicking the built exe runs it
// with x64\Release as the working directory, which contains the executable and nothing else. It
// threw, printed to a console that was destroyed with the process, and looked to the user like the
// program opening and closing for no reason.
//
// Checking beside the executable as well as in the working directory fixes that for every way of
// launching it: a shortcut, a file manager, a drag-and-drop, another program.
std::string executableDir();

// Working directory first, then beside the executable, then the original string so a failure still
// reports the name that was asked for rather than a mangled one.
//
// The working directory wins deliberately. Running from the project folder should keep using the
// project's own shaders and config, so editing one takes effect without having to copy it anywhere.
std::string resolveAssetPath(const std::string& relative);
