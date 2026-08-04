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
};

static_assert(sizeof(FrameConstants) == 60,
              "FrameConstants must stay 15 tightly-packed 4-byte scalars: the shaders' Constants "
              "block assumes that layout, and padding here would silently shift every field the "
              "GPU reads after it.");
