Sand -- a 3D falling-sand simulation
====================================

Unzip anywhere and run Sand.exe. Keep the files together: the program looks for shaders\ and
config.txt next to itself, so moving the exe out on its own will not start.


BEFORE IT WILL RUN
------------------
Two things, both free, both one-time:

1. A Vulkan-capable graphics driver. Almost any GPU from 2016 onward has one, but it comes with the
   DRIVER rather than with Windows -- so if you have never updated yours, do that first. NVIDIA,
   AMD and Intel all ship Vulkan in their standard driver packages.

2. The Microsoft Visual C++ 2015-2022 Redistributable (x64), from
   https://aka.ms/vs/17/release/vc_redist.x64.exe
   You very likely already have it; if the program exits immediately with a message about a missing
   DLL, this is why.

If something goes wrong at startup, the console says what and waits for you to press Enter before
closing, so there is time to read it.


IF WINDOWS CALLS IT A TROJAN
----------------------------
It is a false positive, and you should not simply take my word for that.

The executable is unsigned and was compiled days ago, so no scanner has ever seen it before. That
alone is most of what a heuristic detector has to go on, and small unsigned C++ programs trip it
routinely -- detections with "!ml", "Wacatac", "Zusy", "Sabsik" or "Bearfoos" in the name are the
generic machine-learning buckets rather than a match against anything real.

What the binary actually contains, if you want to check rather than trust: it imports nothing for
networking or cryptography -- no ws2_32, wininet, winhttp, urlmon or crypt32, and not even advapi32,
so it cannot reach the network or touch the registry. Of its 385 imported functions the only ones a
scanner weights are LoadLibrary, GetProcAddress and ShellExecute, which are how the Vulkan loader
and the windowing library find their entry points.

Ask me for the SHA-256 of the file I sent and check it matches, then paste it into virustotal.com.
A couple of engines out of seventy is what a false positive looks like; a dozen is not, and if you
see that, tell me and do not run it.

If you are satisfied and want to run it anyway, add an exclusion for the folder you unzipped it to.
Please do not turn Defender off.


CONTROLS
--------
Right-drag           look around
WASD                 move; Space and Left Shift fly up and down
Mouse wheel          move toward or away from what you are looking at
Left click           place the selected material
Tab                  toggle the cursor between a cube and a sphere
[ and ]  (or Q / E)  brush size
- and =              simulation speed
R                    Clear Grid
C                    reset the camera

Material keys:
  1 erase      2 sand     3 water    4 stone       5 dirt
  6 fire       7 steam    8 black hole            9 lava
  0 locusts (a swarm of 30)

The lava and locust stages, dark stone, and tree parts are on the Material dropdown rather than a
key -- they are states a material reaches on its own, exposed for poking at rather than for building
with.

Everything is also on the Simulation Controls panel.


WHAT TO POKE AT
---------------
- Sand, water and dirt are the basics. Water finds its level, dirt grows grass when it is damp.
- Fire burns grass and boils water into steam. Steam rises, feeds the clouds, and eventually rains
  back down -- the water in the world is conserved, so a storm is repaying a debt.
- Lava flows, cools through four stages into dark stone, and scorches what it touches.
- Black holes capture nearby matter into orbit rather than pulling it straight in, and grow as they
  eat. Clear Grid drops an enormous one that swallows the world and then evaporates.
- Locusts walk on surfaces, eat grass and leaves, and multiply. They will strip a field bare and
  then starve. Key 0 places a swarm of 30.
- Trees bloom out of grass on their own, roughly one block in a thousand. They drink from the soil,
  grow, put out leaves and seed the grass beside them, so a meadow slowly becomes a forest. Fire
  spreads through a canopy; lava pours straight through one.

Options... on the controls panel exposes every tunable in the simulation. Apply reloads with the new
values, which clears the world -- that is deliberate, so what you are looking at is the result of
the settings rather than a mixture of the old and new ones. Applying also writes config.txt, so your
changes survive a restart. Load Defaults puts everything back.

The profiler (top right) breaks the frame into CPU, compute shader and fragment shader time. The
three do not add up to the frame time and are not meant to -- they are three measured durations.


REPORTING SOMETHING
-------------------
Useful to include:
- What you were doing, and what you expected instead.
- Your GPU and driver version.
- The console text, if it printed anything.
- Your config.txt if you had changed any options -- the behaviour depends heavily on it.
