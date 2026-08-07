#pragma once

// The per-frame block both shaders read: camera pose, cursor position, brush.
//
// It lives in a header of its own, naming no graphics API, because both backends need it and they
// deliver it by different means. Vulkan pushes it into the command buffer as push constants -- 60
// bytes inline, no buffer, nothing to synchronise. WebGPU has no such thing, so the web build binds
// the identical bytes as a uniform buffer at binding 3; see the `#ifdef SAND_WEB` at the top of
// both shaders.
//
// The layouts really are identical rather than merely similar: every field is a scalar, and std140
// gives scalars 4-byte size and alignment packed consecutively, which is exactly the push-constant
// layout. That is why one struct can be the payload for both without a second definition to keep in
// step -- and keeping it to one definition is the point, because a divergence here is a wrong camera
// rather than a compile error.
struct FrameConstants {
    float time;
    float pitch;
    float yaw;
    float camX;
    float camY;
    float camZ;
    int spawnX;
    int spawnY;
    int spawnZ;
    int spawnActive;
    int spawnType;
    int spawnSize;
    float fovDistance;
    float perspectiveBlend;
    int spawnShape; // 0 = cube, 1 = sphere

    // How far the view reaches sideways and vertically, as a multiple of the 4:3 framing the
    // camera was built around. Both are 1.0 at 4:3; a wider window raises the first and a taller
    // one raises the second, so the extra room shows more world instead of stretching what was
    // already there.
    //
    // Computed once in buildFrameConstants and consumed in two places that MUST agree -- the
    // raymarcher and the CPU cursor raycast. Sending the two scale factors rather than the aspect
    // ratio is deliberate: the branch that derives them runs once on the CPU, so there is no second
    // copy of it in GLSL to drift out of step and put the cursor somewhere the picture is not.
    float aspectScaleX;
    float aspectScaleY;
};

static_assert(sizeof(FrameConstants) == 68,
              "FrameConstants must stay 17 tightly-packed 4-byte scalars: the shaders' Constants "
              "block assumes that layout, and padding here would silently shift every field the "
              "GPU reads after it.");
