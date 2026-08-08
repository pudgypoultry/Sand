# Running Sand in a browser

A plan for the web target, what it shares with the desktop build, and where the two genuinely
differ. All three shaders are translated and running: the page brings up a WebGPU device, simulates,
raymarches and draws the whole UI over it. Section 6 tracks what is done and what is left.

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

The backend follows the toolchain; `-DSAND_BACKEND=` overrides it. Both need `Sand/vendor/glfw` and
`Sand/vendor/imgui`, which are tracked in the repository — GLFW's prebuilt `.lib` via Git LFS, so
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
shader input over driver bugs reachable from a web page.

`raymarch.frag` and `screen.vert` are translated by `tools/gen_wgsl.sh` (glslangValidator to
SPIR-V, then `naga` from the wgpu project) and the **output is committed** under
`Sand/shaders/wgsl/`, so an ordinary clone builds the web target with no shader translator
installed. Each generated file carries the SHA-256 of the GLSL it came from, and
`cmake/Shaders.cmake` re-computes that and refuses to build a stale one — timestamps cannot do that
job, because a fresh clone gives every file the same mtime. The failure it prevents is otherwise
silent and nasty: edit `raymarch.frag`, forget to regenerate, and the page renders last week's
shader while the desktop renders this week's.

Two things had to change in the GLSL before it would translate at all:

**Push constants do not exist in WGSL.** Both shaders now carry an `#ifdef SAND_WEB` that swaps the
`layout(push_constant)` block for a `std140` uniform at binding 3. Every field is a scalar, so the
two layouts are byte-identical and the same C++ `PushConstants` struct is the payload either way.
One `#ifdef` rather than two shader files is what stops them drifting — and the desktop SPIR-V is
byte-identical before and after, checked.

**A fragment shader may not bind a read-write storage buffer.** WebGPU permits those in compute
only, so `SimStats` in `raymarch.frag` is now `readonly`. It never wrote to it, so this is simply
the more accurate declaration; the SPIR-V gains 15 `NonWritable` decorations and *loses* three
loads, the optimiser doing slightly better for knowing.

`falling_sand.comp` was expected to be the exception, and it was not. **WGSL forbids a storage
buffer being both atomic and non-atomic**: a binding is `array<atomic<u32>>` or `array<u32>`, never
both, with no reinterpreting between them. This shader reads the grid plainly in 76 places and
atomically in 72, so there is no *direct* translation of what it says.

I concluded from that it would need hand-writing — that resolving the conflict was a decision rather
than a transformation. **That was wrong.** naga resolves it the way a person would have: it declares
the binding `array<atomic<u32>>` and routes every plain read through `atomicLoad` and every plain
write through `atomicStore`. The output validates. The rule is real; the inference that no tool could
satisfy it was not, and it went unchecked for several commits because it sounded right.

The `readCell`/`writeCell` accessors added earlier were justified on the same mistaken grounds:

```glsl
uint readCell(uint index) { return grid[index]; }
void writeCell(uint index, uint value) { grid[index] = value; }
```

They were not necessary. They are still mildly worth having — the generated WGSL routes through two
translated functions rather than scattering atomics through 76 inline sites, and in the GLSL they
name what is a plain read and what is a claim — but that is a readability argument, not the
correctness one originally given for them. Verified at the time that they changed nothing:
`glslangValidator -Os` before and after gave 13,306 identical function-body instructions.

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

### 4.4b Bindings, and the memory the cloud field costs

The shaders declare five bindings, and the numbering is shared rather than per-backend:

| Binding | Buffer | Stages | Notes |
|---|---|---|---|
| 0 | grid | compute + fragment | one `uint` per voxel |
| 1 | SimStats | compute + fragment | scalars, black-hole table, then a **runtime-sized** per-column cloud census |
| 2 | TuningParams | compute + fragment | uniform |
| 3 | FrameConstants | compute + fragment | **web only** — the desktop uses push constants and leaves the number unused |
| 4 | cloud field | compute + fragment | one `uint` per voxel, parallel to the grid; the fragment stage reads it read-only, and only for the "show cloud blocks" debug view |

Binding 3 being web-only is why the cloud field is 4 and not 3: one set of numbers then serves both
backends without an `#ifdef` on every declaration.

Two consequences worth planning around. **The cloud field doubles per-voxel memory** — it is a second
buffer the same size as the grid, so a 320³ world now asks the device for ~250 MiB rather than
~125 MiB. Each buffer stays under the 128 MiB `maxStorageBufferBindingSize` on its own, which is what
`createWorldBuffers` checks, but the practical ceiling on modest hardware is lower than that check
implies. **The stats buffer is no longer a fixed size**: it is `SimStats::kFieldCount` plus four words
per column, so it grows with the world and must be recreated when the world is resized.

### 4.5 Colour space and canvas size

Two differences that produce no error anywhere — not a validation message, not a console line — and
show up only as the image looking wrong. Both cost real debugging time, so they are written down.

**The canvas is not an sRGB target by default.** The desktop swapchain is
`VK_FORMAT_B8G8R8A8_SRGB` (`VulkanSwapchain.cpp:39`), so the hardware encodes linear → sRGB on
every write. `wgpuSurfaceGetCapabilities` reports `BGRA8Unorm`, which encodes nothing, and the
shader writes linear values into it verbatim. The result is a correct render that is markedly too
dark — dark enough to read as a lighting bug, which is where the time goes.

The fix is not to configure the surface as sRGB; WebGPU does not permit that. Instead list the sRGB
variant in the surface configuration's `viewFormats`, then take an explicit
`WGPUTextureViewDescriptor` with `format` set to it. The encode comes from the *view*. Everything
that names a colour format has to name the view's: both pipelines' colour targets and the
`renderTargetFormat` ImGui is initialised with — a mismatch there is rejected at draw time.

**The canvas has two sizes and they are unrelated.** The CSS box is what the page lays out; the
drawing buffer is what is actually rendered. GLFW sets the drawing buffer from `glfwCreateWindow`'s
arguments — 1600×1200 — while `shell.html` stretches the element to `100vw`/`100vh`. Every frame
was being rendered at 4:3 and stretched by the browser to fill a 16:9 window.

`syncCanvasSize()` reads the CSS size with `emscripten_get_element_css_size`, multiplies by
`render.resolution_scale`, and calls `emscripten_set_canvas_element_size` plus a surface
reconfigure when it differs from what is configured. Doing this per frame rather than on a resize
event is deliberate: the CSS size changes for reasons no GLFW callback fires for, including the
window being zoomed and the device pixel ratio changing when a window moves between monitors.

That multiply is also the resolution control. A raymarcher's cost is very nearly linear in pixels,
so `render.resolution_scale` at 0.5 quarters the most expensive thing the frame does — by far the
most effective quality knob on a low-end machine. It is web-only for now: the desktop renders
directly into the swapchain image and would need an offscreen target to honour it.

**Matching the canvas to the window exposed a third problem: the projection had no aspect term.**
`raymarch.frag` mapped its ±1 screen-space square across the target whatever shape it was, so a
wide window squashed the world horizontally instead of revealing more of it. On the desktop this
never showed — that window is a fixed 4:3 and `GLFW_RESIZABLE` is false — and while the canvas was
stretched from a 4:3 backing store it was hidden behind the coarser stretching described above.

`FrameConstants` now carries `aspectScaleX`/`aspectScaleY`, both 1.0 at 4:3 (so the desktop image is
bit-for-bit what it was) and rising on whichever axis the window has spare room in. Expanding the
roomy axis rather than shrinking the tight one means the 4:3 framing is always fully visible and the
surplus buys more world — narrowing a window must not crop away what it used to show.

They are computed once, on the CPU, in `buildFrameConstants`, because two things have to agree
about the projection: the raymarcher and the CPU cursor raycast. Sending two ready-made scale
factors instead of the aspect ratio keeps the branch that derives them in one place; a second copy
in GLSL would be free to drift, and the symptom of drift is a cursor that no longer sits under the
pointer.

**ImGui has to be told the size too, and told it every frame.** Resizing the canvas through the
HTML5 API goes behind GLFW's back — `glfwGetWindowSize` still reports what `glfwCreateWindow` was
asked for. ImGui's GLFW backend rewrites `io.DisplaySize` and `io.DisplayFramebufferScale` from
those stale numbers at the top of every frame, and its WebGPU backend scales its viewport and every
scissor rect from their product. The result was a scissor of 1600×1200 against a 1567×983 target,
which WebGPU rejects — invalidating the whole command buffer, so nothing drew at all and an
uncaptured error arrived every frame.

`UiBackendWebGpu::setDisplayMetrics` overrides both, after `ImGui_ImplGlfw_NewFrame` and before
`ImGui::NewFrame`, which is the only window where the correction survives. `DisplaySize` is the CSS
size, because that is the space GLFW reports mouse positions in and ImGui hit-tests in;
`DisplayFramebufferScale` carries `render.resolution_scale`, since ImGui multiplies the two to get
pixels. The rounding was checked exhaustively rather than reasoned about — across every canvas size
to 3840×2160 and nine scale factors, the derived framebuffer size is never larger than the target
(which is the direction that throws) and at worst one pixel smaller. There is no Vulkan counterpart:
that window is fixed, so GLFW's numbers are true.

One consequence worth knowing: below 1.0 the UI is drawn into the reduced target and upscaled with
everything else, so it softens along with the scene. Keeping it sharp means rendering the raymarch
to an offscreen texture and compositing the UI at native size — a second render target and a blit,
which is more than this knob is worth today.

### 4.6 The cursor: GLFW's window is not the canvas

The one that took three attempts, because the obvious correction is the wrong one.

`Window::getMouseNdcX/Y` divide the cursor position by the window's dimensions. The tempting fix,
once the canvas and the window were known to differ, is to point that divisor at the canvas. **That
is backwards.** Emscripten's GLFW scales pointer coordinates into the size that was passed to
`glfwCreateWindow` — 1600×1200 — and keeps doing so no matter how large the canvas gets, because
nothing ever tells it otherwise. Dividing GLFW's number by the canvas mixes two coordinate systems
and the error grows with the difference between them.

Measured rather than reasoned, on a 2048×983 canvas:

| | x | y |
|---|---|---|
| GLFW's cursor | 807.8 | 529.7 |
| The DOM's, relative to the canvas | 1034.0 | 434.0 |
| `glfw / 1600`, `glfw / 1200` | 0.5049 | 0.4414 |
| `dom / 2048`, `dom / 983.2` | 0.5049 | 0.4414 |

The same fraction to four decimals on both axes, and again after resizing the window to 554×944.
GLFW's coordinates are perfectly good — they are simply expressed in GLFW's window, so that is what
they must be divided by. Which is also why the desktop was never affected: there the two are the
same number, and `GLFW_RESIZABLE` is `GLFW_FALSE` so they stay that way.

The symptom was a cursor down and to the left of the pointer, worsening with window size: 2048 > 1600
pushes it left, 983 < 1200 pushes it down. `Window` now keeps both sizes and is explicit about which
is which — `width/height` is GLFW's space and normalises the cursor, `viewportWidth/Height` is the
canvas and supplies the projection's aspect ratio.

ImGui needs the same correction for the opposite reason. It takes its mouse position from GLFW, in
GLFW's space, but hit-tests against `io.DisplaySize`, which is the canvas so that panels are laid out
at the right size and undistorted. `UiBackendWebGpu` therefore rescales `io.MousePos` between the
two — guarded on ImGui's `-FLT_MAX` "no mouse" sentinel, which must be left alone rather than
multiplied into a real position.

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
2. **~~`raymarch.frag` and `screen.vert`.~~ DONE.** Both translated and committed, with bindings
   where they should be (grid and stats read-only storage at 0 and 1, tuning uniform at 2,
   ex-push-constants uniform at 3, all group 0). The renderer creates the four buffers, one
   explicit bind group layout, and a render pipeline, and seeds a diagnostic world on the CPU: a
   stone floor plus one pillar per material in id order. If the palette, the lighting and above all
   the `std140` → WGSL uniform layout are right, that reads as a neat row of correctly coloured
   columns; if `TuningParams` is misaligned by one field the world extents are wrong and it does
   not.

   That seed has since been **removed**, and is worth recording as a cautionary tale. It outlived
   milestone 3 and turned into a simulation bug: the counters in `SimStats` are maintained by the
   shader as voxels are created and destroyed, so writing voxels in from the CPU puts matter in the
   world that those counters never saw. The pillar row included one of every material, so it seeded
   water that `waterVoxelCount` did not know about and black holes with no entry in the table. When
   the uncounted water later evaporated, `decWater` ran on a count of zero — and it is deliberately
   not saturating, because `atomicAdd` has no signed form and it subtracts by wrapping. The count
   became about four billion, `waterHighMark` followed, and the sky spent the rest of the session
   raining against a deficit that never existed. `decWaterHighMark` in `falling_sand.comp` carries a
   comment describing exactly this failure for the sibling counter; the seed walked into it from the
   other side. The world now starts empty, which is byte-for-byte what `VulkanRenderer`'s `memset`
   leaves.
3. **~~`falling_sand.comp`.~~ DONE — it simulates.** Expected to be the bulk of the work and was
   not: naga handles the atomic split, the workgroup was already fixed, and the uniform layout was
   proved by milestone 2. The renderer runs a compute pass before the render pass, dispatching once
   per step of the speed slider.

   One thing WGSL genuinely cannot express turned up here. `memoryBarrierBuffer()` orders the
   calling invocation's memory operations and synchronises nothing, so GLSL allows it inside a
   branch; WGSL's nearest spelling, `storageBarrier()`, is a workgroup execution barrier every
   invocation must reach, and Tint rejects it in divergent control flow. There is no memory fence
   without the rendezvous, so the web build goes without — see the `#ifndef SAND_WEB` in the black
   hole spawn path for what that costs.
4. **~~Interaction.~~ DONE.** The cursor raycast moved to `CursorRay`, shared verbatim by both
   renderers, so clicking places blocks. Clear Grid, Reset Camera and the options screen's Apply all
   work; `beginPurge` differs in one documented way, because WebGPU cannot map a storage buffer for
   the read-modify-write the desktop does.
5. **Storage and limits.** Confirm `localStorage` round-trips the config across a reload; clamp
   `sim.grid_size` to what the device's `maxStorageBufferBindingSize` actually allows rather than
   warning after the fact.

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

`.github/workflows/deploy-pages.yml` builds this target and publishes it to GitHub Pages on every
push to `main`. It installs the Vulkan SDK (for `glslc`, which `cmake/Shaders.cmake` shells out to
at configure time even on the web target -- see the comment there) and `emsdk`, runs the `emcmake`
build above, renames `Sand.html` to `index.html`, and deploys the result. The one step it cannot do
from a workflow file: Settings -> Pages -> Source must be set to "GitHub Actions" once, by hand.

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
