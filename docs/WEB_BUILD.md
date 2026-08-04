# Running Sand in a browser

A plan for the web target, what it shares with the desktop build, and where the two genuinely
differ. Milestone 1 is done: the page builds, opens a canvas, brings up a WebGPU device and draws
the whole UI. The simulation and the raymarcher are not ported yet, and section 6 is the order that
work goes in.

---

## 1. The target has to be WebGPU

WebGL2 has no compute shaders. Not a restricted form of them — none. `falling_sand.comp` *is* the
simulation, so there is no reduced version of Sand that runs on WebGL2; it would be a rewrite into
fragment-shader ping-pong with no atomics, which is a different program with different behaviour.

That leaves WebGPU, which costs us Firefox on some platforms and anything older than Chrome 113 or
Safari 26. `web/shell.html` checks `navigator.gpu` before the module loads and says so plainly,
because the alternative is a black canvas and an adapter-request rejection in the console.

---

## 2. Architecture

The split is by *what needs a graphics API*, not by subsystem. Three layers:

```
                      ┌──────────────────────────────────────────┐
   portable core      │ Config  ConfigSchema  UIManager  Window   │   2,250 lines
   (no graphics API)  │ AssetPaths  Storage  FrameLoop  main      │   compiled by both targets
                      └──────────────────────────────────────────┘
                                  │                    │
                      ┌───────────┴──────┐   ┌─────────┴────────┐
   backend            │ VulkanRenderer   │   │ WebGpuRenderer   │   1,850 (Vulkan)
                      │ VulkanContext    │   │                  │
                      │ VulkanPipeline   │   │                  │
                      │ VulkanSwapchain  │   │                  │
                      │ VulkanBuffer     │   │                  │
                      │ UiBackendVulkan  │   │ UiBackendWebGpu  │
                      └──────────────────┘   └──────────────────┘
                                  │                    │
                      ┌───────────┴──────┐   ┌─────────┴────────┐
   shaders            │ SPIR-V           │   │ WGSL             │
                      └──────────────────┘   └──────────────────┘
```

Selection is at **compile time**, in `GfxBackend.hpp`. There is no `IRenderer` base class and no
virtual dispatch: a binary contains exactly one backend, so runtime substitutability would buy
nothing and cost a vtable on the hottest object in the program. `main.cpp` names `Renderer`, which
`Renderer.hpp` typedefs to whichever one is built.

### What is already portable

These compile for both targets today, unchanged:

| | lines |
|---|---:|
| `UIManager.hpp` — every panel, the options screen, the profiler | 572 |
| `ConfigSchema.cpp/.hpp` — the 97-entry tunable table, reader, writer, UI walker | 393 |
| `Config.cpp/.hpp` | 525 |
| `Window.cpp/.hpp` — GLFW, which Emscripten ports | 332 |
| `AssetPaths`, `Storage`, `FrameLoop`, `main` | 355 |

That is the majority of the project's C++ by line count, and it is the argument for the split: the
options screen and the config format are not ported, they are shared.

`UIManager` was the piece that had to move. It was 620 lines of panels with about fifty lines of
Vulkan in the middle — an `init` taking ten Vulkan handles, a `recordDrawCommands` taking a command
buffer, and the two backend `NewFrame` calls. Those are now behind `UiBackend.hpp`, which declares
two functions with no API types in them, and the renderer — which already owns every handle — does
the rest.

### The three seams the web target needed

**`FrameLoop`.** A desktop frame loop owns the thread. A browser tab has one thread that also runs
the event loop and the compositor, so `while (!shouldClose())` is a page that never paints. The
loop is now `FrameLoop::run(predicate, frame)`, which is a `while` on the desktop and
`emscripten_set_main_loop` in a browser. `VulkanRenderer::mainLoop` was split into `mainLoop` and
`frame` to feed it; nothing in the body changed.

**`Storage`.** Under Emscripten `std::ofstream` succeeds and writes into an in-memory filesystem
that dies with the tab. That is worse than an error: the options screen would report the settings
saved and mean it. Rather than replace the file I/O — which reads `config.txt` back so it can
rewrite values in place and keep every comment — `Storage::prime` and `Storage::persist` bracket
it. The file code stays exactly as it is; the web build copies the file in before it is read and
out to `localStorage` after it is written.

**`AssetPaths`.** `executableDir()` returns `/` under Emscripten, which is where `--preload-file`
mounts the packaged assets. `resolveAssetPath` needed no other change.

---

## 3. Build targets

`Sand.vcxproj` stays the canonical Windows build and is untouched by any of this. CMake is
additive, and exists because the web target cannot be expressed in MSBuild — Emscripten builds
through `emcmake`, and MSBuild has no notion of a compiler that emits WebAssembly.

```sh
# desktop (Vulkan)
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build

# web (WebGPU)
emcmake cmake -B build-web -DCMAKE_BUILD_TYPE=Release
cmake --build build-web
python3 -m http.server -d build-web      # then open Sand.html
```

The backend follows the toolchain; `-DSAND_BACKEND=` overrides it. Both need `vendor/glfw` and
`vendor/imgui`, which are tracked in the repository — GLFW's prebuilt `.lib` via Git LFS, so
`git lfs install` has to happen before the clone. See BUILDING.md.

The web target builds `Sand.html`, which needs serving over HTTP rather than opening off disk --
`file://` blocks the `.wasm` and `.data` fetches. `python -m http.server -d build-web 8000` is
enough.

Should `WebGpuRenderer.cpp` ever go missing, CMake says so at configure time and falls back to
building the shared core alone as `sand_core`, so the portable layer stays compiled and
type-checked for the web either way.

---

## 4. Vulkan → WebGPU, concretely

### 4.1 The shading language, and the one real obstacle

**WGSL only.** WebGPU does not accept SPIR-V, deliberately — the specification rejected binary
shader input over driver bugs reachable from a web page. Tint (from Dawn) translates SPIR-V to
WGSL, and `cmake/Shaders.cmake` wires it up for the two shaders that can be translated
automatically.

`falling_sand.comp` cannot be one of them. **WGSL forbids a storage buffer being both atomic and
non-atomic**: a binding is `array<atomic<u32>>` or `array<u32>`, never both, with no reinterpreting
between them. The shader reads the grid plainly in 76 places and atomically in 72, so there is no
legal WGSL a translator can emit — the resolution is a decision (route the plain reads through
`atomicLoad`) rather than a transformation.

That decision is now **two function bodies**. Every plain access goes through `readCell`/`writeCell`:

```glsl
uint readCell(uint index) { return grid[index]; }
void writeCell(uint index, uint value) { grid[index] = value; }
```

which become `atomicLoad(&grid[index])` and `atomicStore(&grid[index], value)` in WGSL. Verified
that this changed nothing: compiled before and after with `glslangValidator -Os`, and all 13,306
instructions of the function bodies are identical, with the preamble differing only as a
permutation from id renumbering.

The fragment shader needs no such treatment. It binds the grid `readonly` and touches it in one
place, and a WGSL module's view of a buffer is per-module — so the compute module can declare
`array<atomic<u32>>` while the render module declares `array<u32>` over the same buffer.

### 4.2 The workgroup size had to change — done

`falling_sand.comp` was `8 × 8 × 8`, which is 512 invocations. WebGPU's default
`maxComputeInvocationsPerWorkgroup` is **256**, so the pipeline would have been rejected outright.
Desktop Vulkan drivers report 1024, which is why it had never been a problem.

It is now `8 × 8 × 4`, with the Z dispatch divisor moved from 8 to 4 to match. Those two numbers
are a pair: change one without the other and the top of the world silently stops being simulated.

Safe to reshape because nothing depended on the shape — the shader reads only
`gl_GlobalInvocationID`, declares no `shared` variables and calls no `barrier()`, which are the
only three ways a compute shader can notice. Not bit-identical, and never could be: the order
invocations reach a contested cell changes, so which `atomicCompSwap` wins a race shifts. That
order is already nondeterministic frame to frame.

### 4.3 World size is capped

Default `maxStorageBufferBindingSize` is 128 MiB. At 4 bytes per voxel:

| grid | voxels | grid buffer | |
|---|---:|---:|---|
| 128³ | 2.1 M | 8 MiB | fine |
| 256³ | 16.8 M | 64 MiB | fine |
| 320³ | 32.8 M | 125 MiB | just fits |
| 384³ | 56.6 M | 216 MiB | **over the limit** |

Desktop adapters usually report far more than the default, but higher limits must be *requested* at
device creation or you get the default. The options screen should clamp `sim.grid_size` on the web
target accordingly.

(Unrelated, but noticed while working this out: the comment in `config.txt` says 256 is 128 MB. It
is 64 MiB — the comment is out by a factor of two.)

### 4.4 Everything else, in decreasing order of nuisance

| | Vulkan | WebGPU |
|---|---|---|
| **Device creation** | synchronous | `requestAdapter` / `requestDevice` are **asynchronous**. The renderer cannot finish constructing in its constructor; the frame loop starts in the device callback. This is the one structural difference with no local workaround. |
| **Push constants** | 16 fields, shared by compute and fragment | do not exist. Becomes a second small uniform buffer written per frame with `wgpuQueueWriteBuffer`. |
| **Descriptor sets** | mutable; rewritten on resize | bind groups are **immutable**. A resized world makes a new one rather than updating one. |
| **Memory** | pick a memory type, allocate, bind | none of it. `createBuffer` with usage flags; the browser decides. Deletes `VulkanBuffer.cpp` outright. |
| **Swapchain** | acquire/present semaphores, recreation on resize, framebuffers | `getCurrentTexture` and return. Deletes `VulkanSwapchain.cpp` outright. |
| **Barriers** | explicit between compute and render | inserted by the implementation between passes. |
| **Timestamp queries** | 3 queries, `BOTTOM_OF_PIPE` | behind an origin trial, and quantised when present. **The profiler's compute and fragment rows are lost**; the CPU row survives, and `setFrameTimings` already takes a flag for saying the GPU figures are unavailable. |
| **Validation** | layers, opt-in | always on, reported to the console. |

Net: the backend gets *smaller*. `VulkanBuffer.cpp` and `VulkanSwapchain.cpp` (149 lines, plus their headers) have no
counterpart at all, and `VulkanContext.cpp`'s physical-device enumeration and queue-family search
collapse into two async calls.

---

## 5. What it costs and what it buys

**Lost:** the GPU half of the profiler; worlds above ~320³; Firefox and pre-2023 browsers.

**Gained:** the distribution problem disappears. No unsigned binary, no `Trojan detected`, no VC++
redistributable, no Vulkan driver prerequisite, no "ask me for the SHA-256 and check it on
VirusTotal". A URL. Given how much of the packaging work exists to manage exactly that, this is the
real argument for the port rather than a side benefit.

---

## 6. Order of work

Sequenced so the boring parts are proven before the hard part is started.

1. **~~Empty canvas.~~ DONE.** `emcmake cmake`, GLFW window, WebGPU device, clear to a colour,
   ImGui drawing through `UiBackendWebGpu`. Proved the toolchain, the shell, the asset packaging
   and the frame loop; the UI panels came up working, because they were already portable. Runs in
   Chrome and Edge.
2. **`raymarch.frag` and `screen.vert`.** No atomics, two `grid[]` reads between them; Tint
   translates them. Render a world seeded on the CPU. Proves the buffers, the bind groups and the
   uniform layout.
3. **`falling_sand.comp`.** The atomic split, the workgroup size, and the `std140` → WGSL uniform
   layout re-verification. All the difficulty is here.
4. **Storage and limits.** Confirm `localStorage` round-trips the config; clamp `grid_size`.

Step 1 took an afternoon. Step 3 is the bulk. Two to four weeks overall for someone doing it
attentively, and the estimate is dominated by step 3 not being mechanical.

---

## 7. Hosting

Static files: `Sand.html`, `Sand.js`, `Sand.wasm`, `Sand.data`. No server logic, so GitHub Pages,
Netlify or any static host works.

- `.wasm` must be served as `application/wasm` or streaming compilation falls back to a slower path
  (most hosts do this correctly now).
- **No** COOP/COEP headers needed, because nothing here uses `SharedArrayBuffer` or threads. Worth
  saying because it is the usual reason an Emscripten build cannot go on a simple static host, and
  it does not apply.
- Expect 3–6 MB total, dominated by the wasm. `-Os` and `--closure 1` are worth having.
- The `.data` file is the packaged `shaders/` and `config.txt`.

---

## 8. Files added for this

| | |
|---|---|
| `CMakeLists.txt`, `cmake/Shaders.cmake` | both build targets |
| `web/shell.html` | the page, with the WebGPU capability check |
| `Sand/include/GfxBackend.hpp` | backend selection and the two platform predicates |
| `Sand/include/Renderer.hpp` | the typedef `main.cpp` uses |
| `Sand/include/UiBackend.hpp` | the API-neutral half of the ImGui backend |
| `Sand/{include,src}/UiBackendVulkan.*` | extracted from `UIManager.hpp` |
| `Sand/{include,src}/UiBackendWebGpu.*` | its counterpart |
| `Sand/{include,src}/Storage.*` | config persistence |
| `Sand/{include,src}/FrameLoop.*` | who owns the thread |
| `Sand/{include,src}/WebGpuRenderer.*` | the WebGPU renderer — milestone 1 |
