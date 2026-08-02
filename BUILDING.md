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

### Where it looks for shaders and config.txt

The working directory first, then the directory holding the executable. Visual Studio sets the
working directory to the project folder, so F5 uses the project's own shaders and `config.txt` and
an edit to either takes effect without copying anything.

A post-build step also copies the compiled shaders and `config.txt` next to the built executable, so
`x64\Release\Sand.exe` runs on its own. It did not, once: the paths were resolved against the
working directory only, which for a double-clicked exe is the output folder, so it threw on the
first missing shader and the console it printed to was destroyed with the process. What that looked
like from outside was a window opening and closing for no reason.

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

Recovering from a build already in that state needs a **Rebuild**, not a Build, and this is the part
that catches people out: fixing the project file does not touch `Config.cpp`, so `Config.cpp` is
still older than the bad `Config.obj`, so MSBuild still skips it. The build fails identically after
the bug is fixed. Deleting `Sand/x64` has the same effect as a Rebuild.

`tools/package.ps1` therefore runs `/t:Rebuild` rather than `Build` — correct for a release artifact
in any case, since an incrementally-linked package has uncertain provenance. Pass `-Incremental`
while iterating if you want the faster path.

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

### If Windows flags it as a trojan

Expect this, and expect it to be a false positive. The build is unsigned, freshly compiled, and has
never been downloaded by anyone, which is most of what a heuristic scanner has to go on. Detections
with `!ml`, `Wacatac`, `Zusy`, `Sabsik` or `Bearfoos` in the name are the generic machine-learning
buckets and fire constantly on small unsigned C++ programs.

Check rather than assume, since "it's probably fine" is how people ship real malware. What a clean
build of this looks like, verified with `pefile` on a package that had been flagged:

- **No network or crypto imports at all** — no `ws2_32`, `wininet`, `winhttp`, `urlmon`, `crypt32`,
  not even `advapi32`. It cannot talk to anything or touch the registry.
- **Nothing weighted for injection or persistence.** Of 385 imported functions, the only three a
  scanner cares about are `LoadLibraryA`, `GetProcAddress` and `ShellExecuteW` — the first two are
  how the Vulkan loader and GLFW resolve entry points, the third is GLFW's.
- **Normal entropy.** `.text` at 6.50; a packed or encrypted payload sits above 7.5.
- **Release CRT** — `MSVCP140.dll` and `VCRUNTIME140.dll`, not the `d`-suffixed debug versions.

What actually fixes it, in order of effort:

1. **Submit it to Microsoft** as a false positive, at
   https://www.microsoft.com/en-us/wdsi/filesubmission — free, usually turned around in a day or
   two, and it fixes the detection for everyone rather than just for you.
2. **Upload to VirusTotal** and send testers the link. One or two engines flagging it out of seventy
   is the signature of a false positive, and it lets a tester decide for themselves rather than
   taking your word for it.
3. **Distribute through GitHub Releases** rather than as an email attachment. A URL that Defender
   has seen before accrues reputation; a zip that arrives from nowhere never does.
4. **Sign the executable.** This is the only real fix. An OV certificate is roughly $200-400 a year
   and still needs to build SmartScreen reputation; an EV certificate is more and gets it
   immediately. Only worth it if this stops being a thing you hand to a few people.

`Sand.rc` adds a version resource, which is the one thing in this list that was actually missing
from the binary rather than from its reputation. It is what fills in Properties > Details, and an
executable with none at all is unusual enough for real software that scanners notice.

Two things not to do. Do not password-protect the zip to get it past a scanner — it defeats
scanning, which is the point of the scanner, and it makes the file look considerably worse to
anyone paying attention. Do not tell testers to switch Defender off; an exclusion for one folder is
the most anyone should be asked for, and only after they have seen a VirusTotal result.

### What the tester needs

Nothing to build, but two runtime pieces:

1. A Vulkan-capable GPU driver — `vulkan-1.dll` comes from the driver, not from Windows.
2. The [Microsoft Visual C++ 2015–2022 Redistributable (x64)](https://aka.ms/vs/17/release/vc_redist.x64.exe).

The application is a console subsystem build, so it opens a terminal alongside the window and prints
diagnostics there. That is useful for a tester — if it fails to start, the reason is on screen —
but worth mentioning to them so the console does not look like a bug.
