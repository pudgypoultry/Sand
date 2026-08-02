# Building and packaging Sand

## What you need

| | |
|---|---|
| Visual Studio 2022 (or newer) | with the **Desktop development with C++** workload |
| [Vulkan SDK](https://vulkan.lunarg.com/sdk/home#windows) | provides the headers, `vulkan-1.lib`, and `glslc.exe`, which the build shells out to in order to compile the shaders. The installer sets `VULKAN_SDK`; reopen your shell afterwards so it is picked up. |
| A Vulkan-capable GPU driver | ships with the driver rather than with Windows |

Only **x64** is configured. The Win32 configurations exist in the project file but have never had
their include paths or libraries set, so they will not build — pick x64 in the toolbar.

## Third-party dependencies are not in the repository

`Sand/vendor/` is gitignored, so a fresh clone will not build until you put the dependencies back.
Three are needed, in exactly these locations:

```
Sand/vendor/glfw/include/GLFW/...      GLFW headers
Sand/vendor/glfw/lib-vc2022/glfw3.lib  GLFW, the static library (not glfw3dll.lib)
Sand/vendor/glm/glm/...                GLM headers, header-only
Sand/vendor/imgui/*.cpp,*.h            Dear ImGui core
Sand/vendor/imgui/backends/            imgui_impl_glfw.* and imgui_impl_vulkan.*
```

GLFW's Windows binary release already has the `include/` and `lib-vc2022/` layout above, so it can
be unpacked as-is. GLM and Dear ImGui are source drops from their repositories.

If you want a clone to build without this step, the options are to commit `vendor/` (simple, adds a
few MB, needs the licences attributing in `Sand/Credits.txt`) or to add the three as git submodules
(keeps the repo small, but GLFW would then need building from source rather than using its prebuilt
`.lib`). Both are a deliberate choice rather than something to drift into, which is why the
dependencies are currently just absent.

## Building

Open `Sand.slnx`, pick **Release | x64**, and build. Or from a developer prompt:

```
msbuild Sand\Sand.vcxproj /p:Configuration=Release /p:Platform=x64
```

A pre-build step compiles `shaders/*.comp|vert|frag` into `shaders/*.spv`. The compiled `.spv` files
are committed, so a build failure at that step leaves you running *last commit's* shaders rather
than none — if a shader edit appears to do nothing, check that step actually ran.

### Running from Visual Studio

The program opens `shaders/falling_sand.spv` and `config.txt` by paths relative to the working
directory, and Visual Studio defaults that to the project directory, where both live. That is why
F5 works and why double-clicking `Sand.exe` in `x64\Release` does not — the executable is not next
to its assets there.

## If the link fails with missing Config symbols

If a build ever fails with `unresolved external symbol` for `loadConfig`, `saveConfig`,
`sanitizeTuning`, `applyWorldShape` and `autoMarchSteps` — all of them, and only them — the cause is
an object file collision rather than anything wrong with the code.

MSBuild names each object after its source file's **base** name, discarding the directory, so two
`ClCompile` items sharing a base name write the same `.obj` and overwrite each other. With `/m` they
compile in parallel and which one survives is a race, so the build works, then the identical build
fails to link. `Sand/x64/*/Config.obj` is left holding whichever version won.

The instance that actually happened was `include\Config.hpp` listed as `ClCompile` instead of
`ClInclude`. It compiled to `Config.obj`, the same object `src\Config.cpp` produces, and a header's
object has none of the definitions in it. It is fixed, and `tools/package.ps1` now refuses to build
if either shape reappears — a non-source file under `ClCompile`, or two sources sharing a base name.

Recovering from a build already in that state needs a **Rebuild**, not a Build; the bad `Config.obj`
is newer than its source, so an incremental build leaves it alone. Deleting `Sand/x64` does the same
thing.

## Packaging for someone else

```
powershell -ExecutionPolicy Bypass -File tools\package.ps1
```

This builds Release x64 and writes `dist\Sand-<date>-x64.zip` containing the executable, the three
compiled shaders, `config.txt`, and a README for the tester. Unzipping and running `Sand.exe` is
the whole of it at their end.

Two things the script enforces rather than assumes:

- **Release, not Debug.** A Debug build links the debug CRT, which Microsoft does not license for
  redistribution and which simply will not start on a machine without Visual Studio. Handing over
  the Debug exe is the usual way this goes wrong.
- **Shaders newer than their sources.** A stale `.spv` is the worst failure here because nothing
  looks broken — it loads, it runs, and the behaviour is quietly out of date. The script refuses to
  package one.

`imgui.ini` is deliberately left out. It records window positions, and the UI's one-shot startup
layout only applies when that file is absent, so shipping one would give every tester whatever
layout your machine happened to have.

### What the tester needs

Nothing to build, but two runtime pieces:

1. A Vulkan-capable GPU driver — `vulkan-1.dll` comes from the driver, not from Windows.
2. The [Microsoft Visual C++ 2015–2022 Redistributable (x64)](https://aka.ms/vs/17/release/vc_redist.x64.exe).

The application is a console subsystem build, so it opens a terminal alongside the window and prints
diagnostics there. That is useful for a tester — if it fails to start, the reason is on screen —
but worth mentioning to them so the console does not look like a bug.
