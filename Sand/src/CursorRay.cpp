// CursorRay.cpp -- the CPU cursor raycast, shared by both renderers.

#include "CursorRay.hpp"

#include <algorithm>
#include <cmath>

namespace {

struct RayVec3 { float x, y, z; };

RayVec3 rotateByCamera(RayVec3 v, float pitch, float yaw) {
    float cp = std::cos(pitch), sp = std::sin(pitch);
    float ny = v.y * cp - v.z * sp;
    float nz = v.y * sp + v.z * cp;
    v.y = ny; v.z = nz;

    float cy = std::cos(yaw), sy = std::sin(yaw);
    float nx = v.x * cy - v.z * sy;
    float nz2 = v.x * sy + v.z * cy;
    v.x = nx; v.z = nz2;
    return v;
}

} // namespace

void buildFrameConstants(const Window& window,
                         const UIManager& ui,
                         const TuningParams& tuning,
                         float time,
                         FrameConstants& fc) {
    fc.time = time;
    fc.pitch = window.getPitch();
    fc.yaw = window.getYaw();
    fc.camX = window.getCamX();
    fc.camY = window.getCamY();
    fc.camZ = window.getCamZ();
    fc.spawnActive = 0;

    fc.spawnType = static_cast<int>(ui.getCurrentMaterial());

    // A black hole is a single tracked object rather than paint, and the compute shader will only
    // ever place the one at the brush's centre. Pinning the brush to 1 voxel here keeps the cursor
    // honest about that instead of outlining a volume that a click won't fill.
    const int brushSize = (ui.getCurrentMaterial() == MaterialType::BlackHole)
        ? 1
        : ui.getBrushSize();

    fc.spawnSize = brushSize;
    fc.spawnShape = static_cast<int>(ui.getCursorShape());
    fc.fovDistance = ui.getFovDistance();
    fc.perspectiveBlend = ui.getPerspectiveBlend();

    // Out of bounds by default, which is how "draw no cursor" is expressed: the shader gates the
    // cursor on the coordinates being inside the world, and never looks at spawnActive -- that only
    // governs whether a click places anything.
    fc.spawnX = -1; fc.spawnY = -1; fc.spawnZ = -1;

    // The camera was framed on a 4:3 window and every FOV default was chosen against it, so 4:3 is
    // the reference rather than "correct" being some absolute. At that shape both factors are 1 and
    // nothing about the picture changes.
    //
    // Whichever axis the window has spare room in is the one that grows. Scaling only the wide axis
    // would mean a tall window seeing LESS to the sides than the reference did -- content vanishing
    // off the edges because the window was made narrower, which is the complaint this is meant to
    // fix rather than a different form of it. Expanding instead guarantees the 4:3 view is always
    // fully visible, with the surplus spent on more world.
    constexpr float kReferenceAspect = 4.0f / 3.0f;
    const int px = window.getWidth();
    const int py = window.getHeight();
    const float aspect = (px > 0 && py > 0) ? (float)px / (float)py : kReferenceAspect;
    if (aspect >= kReferenceAspect) {
        fc.aspectScaleX = aspect / kReferenceAspect;
        fc.aspectScaleY = 1.0f;
    } else {
        fc.aspectScaleX = 1.0f;
        fc.aspectScaleY = kReferenceAspect / aspect;
    }

    // The same scaling raymarch.frag applies to screenSpace. It has to happen here too, and with
    // the identical numbers, or the cursor tracks a projection the picture is not using and blocks
    // land off the pointer -- worse the further from the centre of the screen.
    const float ndcX = window.getMouseNdcX() * fc.aspectScaleX;
    const float ndcY = -window.getMouseNdcY() * fc.aspectScaleY;

    // Builds the same forward/right/up camera basis as raymarch.frag, then blends between
    // perspective (shared origin, per-pixel direction) and orthographic (shared direction,
    // per-pixel origin) using the same t = perspectiveBlend factor, so the cursor stays
    // accurate across the whole slider range instead of only matching at t = 1.
    const RayVec3 forward = rotateByCamera({ 0.0f, 0.0f, 1.0f }, fc.pitch, fc.yaw);
    const RayVec3 right   = rotateByCamera({ 1.0f, 0.0f, 0.0f }, fc.pitch, fc.yaw);
    const RayVec3 up      = rotateByCamera({ 0.0f, 1.0f, 0.0f }, fc.pitch, fc.yaw);

    const float t = std::clamp(fc.perspectiveBlend, 0.0f, 1.0f);

    const float extentX = (float)tuning.gridWidth;
    const float extentY = (float)tuning.gridHeight;
    const float extentZ = (float)tuning.gridDepth;

    const float viewDistance = std::max(1.0f,
        (extentX * 0.5f - fc.camX) * forward.x +
        (extentY * 0.5f - fc.camY) * forward.y +
        (extentZ * 0.5f - fc.camZ) * forward.z);
    const float orthoHalfSize = viewDistance / fc.fovDistance;

    const float localDirX = (1.0f - t) * 0.0f + t * ndcX;
    const float localDirY = (1.0f - t) * 0.0f + t * ndcY;
    const float localDirZ = (1.0f - t) * 1.0f + t * fc.fovDistance;

    float rx = right.x * localDirX + up.x * localDirY + forward.x * localDirZ;
    float ry = right.y * localDirX + up.y * localDirY + forward.y * localDirZ;
    float rz = right.z * localDirX + up.z * localDirY + forward.z * localDirZ;
    const float len = std::sqrt(rx * rx + ry * ry + rz * rz);
    rx /= len; ry /= len; rz /= len;

    const float originOffsetX = (right.x * ndcX + up.x * ndcY) * orthoHalfSize * (1.0f - t);
    const float originOffsetY = (right.y * ndcX + up.y * ndcY) * orthoHalfSize * (1.0f - t);
    const float originOffsetZ = (right.z * ndcX + up.z * ndcY) * orthoHalfSize * (1.0f - t);

    const float ox = fc.camX + originOffsetX;
    const float oy = fc.camY + originOffsetY;
    const float oz = fc.camZ + originOffsetZ;

    const bool isInside = (ox > 0.0f && ox < extentX && oy > 0.0f && oy < extentY &&
                           oz > 0.0f && oz < extentZ);

    const int halfDistMin = brushSize / 2;
    const int halfDistMax = (brushSize - 1) / 2;
    const int minBound = 1 + halfDistMin;
    const int maxBoundX = (int)tuning.gridWidth - 2 - halfDistMax;
    const int maxBoundY = (int)tuning.gridHeight - 2 - halfDistMax;
    const int maxBoundZ = (int)tuning.gridDepth - 2 - halfDistMax;

    if (isInside) {
        // Standing inside the world, so there is no surface to enter through: place at a fixed
        // reach ahead of the camera instead.
        const float spawnDist = 30.0f;
        const float hitX = ox + rx * spawnDist;
        const float hitY = oy + ry * spawnDist;
        const float hitZ = oz + rz * spawnDist;

        if (hitX >= minBound && hitX <= maxBoundX && hitY >= minBound && hitY <= maxBoundY &&
            hitZ >= minBound && hitZ <= maxBoundZ) {
            fc.spawnX = (int)hitX;
            fc.spawnY = (int)hitY;
            fc.spawnZ = (int)hitZ;
            if (window.isLeftClicking()) fc.spawnActive = 1;
        }
    }
    else {
        // Outside looking in: the cursor goes where the ray first crosses the world's box.
        const float t1 = (0.0f - ox) / rx;  const float t2 = (extentX - ox) / rx;
        const float t3 = (0.0f - oy) / ry;  const float t4 = (extentY - oy) / ry;
        const float t5 = (0.0f - oz) / rz;  const float t6 = (extentZ - oz) / rz;

        const float tmin = std::max({ std::min(t1, t2), std::min(t3, t4), std::min(t5, t6) });
        const float tmax = std::min({ std::max(t1, t2), std::max(t3, t4), std::max(t5, t6) });

        if (tmax >= 0 && tmin > 0 && tmin <= tmax) {
            const float hitX = ox + rx * tmin + rx * 0.01f;
            const float hitY = oy + ry * tmin + ry * 0.01f;
            const float hitZ = oz + rz * tmin + rz * 0.01f;

            fc.spawnX = std::clamp((int)hitX, minBound, maxBoundX);
            fc.spawnY = std::clamp((int)hitY, minBound, maxBoundY);
            fc.spawnZ = std::clamp((int)hitZ, minBound, maxBoundZ);
            if (window.isLeftClicking()) fc.spawnActive = 1;
        }
    }
}
