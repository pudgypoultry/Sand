#version 450

layout(location = 0) in vec2 inUV;
layout(location = 0) out vec4 outColor;

layout(std430, binding = 0) readonly buffer VoxelGrid {
    uint grid[];
};

// Must stay byte-identical to the SimStats block in falling_sand.comp, and BH_INDEX_MASK must match
// the slot encoding used there.
const int BLACK_HOLE_MAX = 8;
const int CLOUD_MAX = 64;
const uint BH_INDEX_MASK = 0x3FFFFFFFu;
const uint BH_PURGE = 0x40000000u;

layout(std430, binding = 1) buffer SimStats {
    uint waterVoxelCount;
    uint waterHighMark;
    uint cloudWaterCount;
    uint rainPhase;
    uint rainPhaseTimeBits;
    uint rainTargetLevel;
    uint rainCandidateCount;
    uint rainCandidateEstimate;
    uint cloudChargeBits;
    uint blackHoleCount;
    uint maxOccupiedY;
    uint blackHoles[BLACK_HOLE_MAX];
    uint blackHoleMass[BLACK_HOLE_MAX];
    uint blackHoleStarve[BLACK_HOLE_MAX];
    float cloudCache[CLOUD_MAX * 7];
};

layout(std140, binding = 2) uniform TuningParams {
    uint gridWidth;
    uint gridHeight;
    uint gridDepth;
    uint marchMaxSteps;
    uint shadowMaxSteps;
    uint rainStartLayers;
    uint rainDropsPerTick;
    float rainOvershoot;
    float rainDarkenDelay;
    uint cloudCount;
    float cloudDriftSpeed;
    float cloudEdgeFadeDist;
    float cloudChargeSaturation;
    float cloudChargeEaseRate;
    float cloudMinAlpha;
    float cloudMaxAlpha;
    float cloudVoxelSize;
    float cloudEdgeThresholdMin;
    float cloudEdgeThresholdMax;
    uint maxCloudSteps;
    uint sandMoistureCapacity;
    uint dirtMoistureCapacity;
    uint sandWaterAbsorbUnit;
    uint sandClumpThreshold;
    uint dirtClumpThreshold;
    uint wakeSleepThreshold;
    uint emptyBelowWakeCount;
    uint waterSpreadRadius;
    uint fireLifetime;
    uint fireDryRate;
    float grassGrowChance;
    float grassSubmergedDecayChance;
    float fireBurnGrassChance;
    float fireSpreadChance;
    float steamScatterChance;
    uint blackHoleHorizon;
    uint blackHoleRadius;
    float blackHoleOrbitSpeed;
    float blackHoleInfall;
    float blackHolePlaneGrip;
    float blackHoleGlow;
    uint blackHoleOrbitPlanes;
    float blackHoleGrowthCost;
    uint blackHoleMaxLevel;
    uint blackHoleStarveGrace;
    uint blackHoleDecayRate;
    uint purgeLevel;
    uint purgeMass;
    uint purgeStarveGrace;
    uint purgeDecayRate;
    float purgeOrbitSpeed;
    float purgeInfall;
    float waterShadowTransmit;
    float waterWaveStrength;
    float waterWaveScale;
    float waterWaveSpeed;
    uint lavaStageSize;
    float lavaViscosity;
    uint lavaSpreadRadius;
    uint lavaWaterCool;
    uint lavaMoistureCool;
    float lavaRestCoolChance;
    float lavaConsumeChance;
    float lavaIgniteChance;
    float darkStoneDryChance;
} tuning;

layout(push_constant) uniform Constants {
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
} pc;

// World extents, from the UBO. Must agree with falling_sand.comp.
#define WIDTH  int(tuning.gridWidth)
#define HEIGHT int(tuning.gridHeight)
#define DEPTH  int(tuning.gridDepth)

// FUNCTION: worldExtent
vec3 worldExtent() { return vec3(float(WIDTH), float(HEIGHT), float(DEPTH)); }

// FUNCTION: marchCeiling
// The lowest Y that is guaranteed to have nothing at or above it, so both the primary march and the
// shadow march can stop there instead of walking to the roof of the world.
//
// This is the single biggest saving in this stage, and it is a saving on the common case rather than
// a corner: a world is mostly empty sky, and a DDA has no way to know that -- it reads every cell it
// crosses whether or not anything is there. At 256^3 with terrain filling the bottom quarter and the
// default camera, the primary march averages 37 grid reads per pixel and the shadow march 11; clipped
// to the occupied height those become 5 and 4. The rays that never touch the terrain are the ones
// that benefit most, and they are most of the screen.
//
// The +2 is not slack, it is the exact margin the publisher needs. maxOccupiedY can sit one below the
// truth (the decay in updateSimState may land after a voxel's atomicMax), and a voxel may rise one
// cell in the dispatch that published it. Adding 2 therefore leaves at least one guaranteed-empty
// cell above the highest matter -- which is also what keeps the DDA's face normal correct, since a
// ray entering the clipped box always takes a step before it can hit anything.
int marchCeiling() {
    return min(HEIGHT, int(maxOccupiedY) + 2);
}

// FUNCTION: getVoxel
uint getVoxel(ivec3 pos) {
    if (pos.x < 0 || pos.x >= WIDTH || pos.y < 0 || pos.y >= HEIGHT || pos.z < 0 || pos.z >= DEPTH) return 0u; 
    uint index = uint(pos.x + (pos.y * WIDTH) + (pos.z * WIDTH * HEIGHT));
    return grid[index];
}

// FUNCTION: rot
mat2 rot(float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}

// FUNCTION: applyCameraRotation
// Rotates a direction/offset vector by the camera's pitch and yaw — the same transform
// previously applied directly to rayDir. Used to build a forward/right/up basis so both
// the perspective ray direction and the orthographic origin-offset stay consistently oriented.
vec3 applyCameraRotation(vec3 v) {
    v.yz *= rot(pc.pitch);
    v.xz *= rot(pc.yaw);
    return v;
}

// FUNCTION: hash
float hash(vec3 p) {
    return fract(sin(dot(p, vec3(12.9898f, 78.233f, 45.164f))) * 43758.5453f);
}

// FUNCTION: intersectAABB
vec2 intersectAABB(vec3 ro, vec3 rd, vec3 boxMin, vec3 boxMax) {
    vec3 tMin = (boxMin - ro) / rd;
    vec3 tMax = (boxMax - ro) / rd;
    vec3 t1 = min(tMin, tMax);
    vec3 t2 = max(tMin, tMax);
    float tNear = max(max(t1.x, t1.y), t1.z);
    float tFar = min(min(t2.x, t2.y), t2.z);
    return vec2(tNear, tFar);
}

// FUNCTION: isEdge
bool isEdge(vec3 p) {
    float thickness = 0.3f; 
    int boundCount = 0;
    vec3 extent = worldExtent();
    if (p.x < thickness || p.x > extent.x - thickness) boundCount++;
    if (p.y < thickness || p.y > extent.y - thickness) boundCount++;
    if (p.z < thickness || p.z > extent.z - thickness) boundCount++;
    return boundCount >= 2;
}

// FUNCTION: calculateShadow
// Returns how much light reaches the point: 1 lit, 0 fully shadowed. Opaque materials block
// outright; water instead attenuates by waterShadowTransmit per voxel crossed.
//
// That exception is the single largest fix for water's surface jitter, and it is not the one it
// looks like. Water's surface voxels constantly shuffle by a cell, and when this test was a hard
// binary block, one of those hops flipped a neighbouring shadow ray between blocked and clear --
// swinging that pixel by the WHOLE sun term. Measured against a single one-voxel hop, the rendered
// change is 0.253 with a hard block against 0.012 with water fully transmissive, and 0.012 is the
// floor set by the surface normal on its own. The shadow was 21x the normal, which is why widening
// the normal kernel alone barely helped.
//
// Attenuating per voxel rather than simply skipping water keeps it physical, and for free: a single
// voxel of spray dims almost nothing, while a deep pool puts many voxels in the path and still
// darkens its own bed. Beer-Lambert falls out of the DDA without a second pass.
float calculateShadow(ivec3 hitVoxelPos, vec3 hitNormal, vec3 lightDir, int ceilingY) {
    ivec3 voxelPos = hitVoxelPos + ivec3(round(hitNormal));
    ivec3 stepDir = ivec3(sign(lightDir));

    vec3 tDelta = vec3(
        (lightDir.x == 0.0f) ? 100000000.0f : abs(1.0f / lightDir.x),
        (lightDir.y == 0.0f) ? 100000000.0f : abs(1.0f / lightDir.y),
        (lightDir.z == 0.0f) ? 100000000.0f : abs(1.0f / lightDir.z)
    );

    vec3 tMax = 0.5f * tDelta;
    float transmittance = 1.0f;

    for (int i = 0; i < int(tuning.shadowMaxSteps); i++) {
        // ceilingY rather than HEIGHT: the sun is overhead, so a shadow ray only ever climbs, and
        // once it is above the world's contents nothing further along it can block. That turns the
        // march's length into a function of how much matter there is rather than how tall the
        // world is -- which is what stops shadowMaxSteps from silently truncating at 256^3.
        if (voxelPos.x < 0 || voxelPos.x >= WIDTH ||
            voxelPos.y < 0 || voxelPos.y >= ceilingY ||
            voxelPos.z < 0 || voxelPos.z >= DEPTH) {
            return transmittance;
        }

        uint blockerType = getVoxel(voxelPos) & 0xFFu;
        if (blockerType == 2u) {
            transmittance *= tuning.waterShadowTransmit;
            // Deep water reaches effectively opaque quickly; bailing here keeps the march from
            // walking the full 256 steps through a large body for a result already at zero.
            if (transmittance < 0.02f) return 0.0f;
        } else if (blockerType != 0u) {
            return 0.0f;
        }

        if (tMax.x < tMax.y) {
            if (tMax.x < tMax.z) {
                voxelPos.x += stepDir.x;
                tMax.x += tDelta.x;
            } else {
                voxelPos.z += stepDir.z;
                tMax.z += tDelta.z;
            }
        } else {
            if (tMax.y < tMax.z) {
                voxelPos.y += stepDir.y;
                tMax.y += tDelta.y;
            } else {
                voxelPos.z += stepDir.z;
                tMax.z += tDelta.z;
            }
        }
    }
    return transmittance;
}

// FUNCTION: getSmoothNormal
// The offsets are lattice points, so their lengths are square roots of small integers rather than
// anything that needs measuring: inversesqrt of an exact int replaces 26 length() calls and 26
// divides with 26 reciprocal square roots, which is the same arithmetic at a fraction of the cost.
vec3 getSmoothNormal(ivec3 p) {
    vec3 n = vec3(0.0f);
    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            for (int z = -1; z <= 1; z++) {
                if (x == 0 && y == 0 && z == 0) continue;

                if ((getVoxel(p + ivec3(x, y, z)) & 0xFFu) == 0u) continue;

                vec3 offset = vec3(float(x), float(y), float(z));
                n -= offset * inversesqrt(float(x * x + y * y + z * z));
            }
        }
    }

    if (length(n) < 0.1f) return vec3(0.0f, 1.0f, 0.0f);
    return normalize(n);
}

// FUNCTION: getWaterNormal
// Water's shading normal, taken as a distance-weighted density gradient over a radius-2
// neighbourhood rather than the binary occupancy getSmoothNormal uses for everything else.
//
// This is the fix for surface jitter rather than a cover for it. In the binary version, one surface
// voxel shuffling one cell flips a whole unit vector inside a sum whose magnitude is only 3-5, and
// the normal swings ~13 degrees -- almost exactly the half-angle of the exponent-32 specular lobe,
// so a highlight switches fully on or off and a 3%-of-cells motion reads as violent sparkle.
// Spreading the same question across 80 weighted neighbours drops one cell's share to ~3 degrees,
// comfortably inside the lobe, so the highlight slides instead of snapping.
//
// Radius 2 is where the curve flattens: radius 3 only reaches ~2.4 degrees for 178 taps. 80 taps at
// a single shading point is modest against the marches that reach the same pixel.
vec3 getWaterNormal(ivec3 p) {
    vec3 n = vec3(0.0f);

    for (int x = -2; x <= 2; x++) {
        for (int y = -2; y <= 2; y++) {
            for (int z = -2; z <= 2; z++) {
                if (x == 0 && y == 0 && z == 0) continue;

                // Squared, so the radius test and the weight are both exact integer arithmetic.
                // The weight wanted (offset/d) * (1/d), which is just offset/d2 -- the two divides
                // and the 124 length() calls this used to make were computing a square root only to
                // square it again.
                int d2 = x * x + y * y + z * z;
                if (d2 > 6) continue; // round the cube off, so the kernel has no corner bias

                // Any solid counts as "inside", matching getSmoothNormal: water lying against sand
                // should not bend its normal at the contact, only at the boundary with air.
                if ((getVoxel(p + ivec3(x, y, z)) & 0xFFu) == 0u) continue;

                n -= vec3(float(x), float(y), float(z)) / float(d2);
            }
        }
    }

    if (length(n) < 0.001f) return vec3(0.0f, 1.0f, 0.0f);
    return normalize(n);
}

// FUNCTION: renderSand
vec3 renderSand(uint rawVoxel, vec3 baseLighting) {
    uint moisture = (rawVoxel >> 24) & 0xFFu;
    float wetness = clamp(float(moisture) / 10.0f, 0.0f, 1.0f); 
    
    vec3 dryColor = vec3(0.9f, 0.8f, 0.2f);
    vec3 wetColor = vec3(0.65f, 0.55f, 0.15f); 
    vec3 baseColor = mix(dryColor, wetColor, wetness);
    
    return baseColor * baseLighting;
}

// FUNCTION: waterWaveGradient
// Slope of a small sum of scrolling sine ridges, evaluated analytically.
//
// Purely decorative. It used to be load-bearing -- a moving highlight to bury the surface's popping
// under -- but the pop is fixed at source now (see calculateShadow and getWaterNormal), so this is
// free to be tuned for looks alone, and is deliberately quiet: at the default the tilt peaks around
// 12 degrees, just inside the specular lobe's half-angle, so crests MODULATE the highlight rather
// than switching it on and off. That ceiling is what keeps it reading as calm water.
//
// Analytic rather than sampled, and sine rather than hash noise, because the surface has to stay
// smooth: a finite-difference or per-voxel-hash normal would put high-frequency discontinuity back
// into a surface that just had it taken out.
vec2 waterWaveGradient(vec2 p, float t) {
    float scale = max(tuning.waterWaveScale, 0.001f);

    // Domain warp: displace the sample position by a large, slow wave before the detail octaves are
    // evaluated. This is what stops the result reading as a few straight sine directions -- crests
    // bend and braid along the warp instead of running parallel across the whole pool.
    //
    // The warp's own contribution to the derivative is deliberately dropped. What is needed here is
    // a smooth vector field to tilt a normal with, not a mathematically exact gradient, and carrying
    // the Jacobian through five octaves costs more than the difference is worth on screen.
    float wt = t * tuning.waterWaveSpeed * 0.35f;
    vec2 q = p + vec2(sin(p.y * 0.043f + wt), sin(p.x * 0.037f - wt * 0.8f)) * 6.0f;

    const vec2 dirs[5] = vec2[5](vec2(0.860f, 0.510f), vec2(-0.421f, 0.907f), vec2(0.707f, -0.707f),
                                 vec2(-0.966f, -0.259f), vec2(0.259f, 0.966f));
    const float freq[5] = float[5](0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
    const float amp[5]  = float[5](1.00f, 0.62f, 0.38f, 0.24f, 0.15f);
    const float spd[5]  = float[5](1.00f, 1.37f, 0.83f, 1.71f, 0.61f);

    vec2 grad = vec2(0.0f);
    for (int i = 0; i < 5; i++) {
        float f = freq[i] * scale;
        float phase = dot(dirs[i], q) * f + t * spd[i] * tuning.waterWaveSpeed;
        // d/dp of amp*sin(dot(dir,p)*f + ...) is amp*f*dir*cos(...)
        grad += dirs[i] * (amp[i] * f * cos(phase));
    }

    // Low-frequency envelope, evaluated on the UNWARPED position so it drifts independently of the
    // crests. Without it every part of the surface is equally agitated at every moment, which is the
    // single biggest reason a sum of sines reads as machine-made rather than as water. It matters
    // more at low amplitudes, not less: a quiet surface with uniform ripple reads as a texture.
    float envelope = 0.45f + 0.55f * sin(p.x * 0.021f + p.y * 0.017f + t * 0.11f);
    return grad * envelope;
}

// FUNCTION: applyWaterWaves
// Tilts the shading normal by the wave slope. Geometry is untouched -- the voxel silhouette is
// exactly as blocky as before; only what the surface reflects changes.
//
// Weighted by how upward-facing the surface already is, because a height field only describes a
// roughly horizontal surface. Applying it to the vertical face of a waterfall or a pool wall would
// tilt normals in a direction the wave says nothing about, and those faces would shimmer for no
// reason -- the opposite of the point.
vec3 applyWaterWaves(vec3 normal, ivec3 voxelPos) {
    if (tuning.waterWaveStrength <= 0.0f) return normal;

    float upness = clamp(normal.y, 0.0f, 1.0f);
    if (upness <= 0.0f) return normal;

    // World XZ, so the pattern is anchored to the world and slides across it. Anchoring per voxel
    // instead would make the wave jump with the voxel it is drawn on.
    vec2 grad = waterWaveGradient(vec2(voxelPos.xz) + vec2(0.5f), pc.time);

    // For a height field h, the surface normal is normalize(-dh/dx, 1, -dh/dz); adding the negated
    // gradient to an up-facing normal is that same tilt, expressed so it composes with any base.
    return normalize(normal + vec3(-grad.x, 0.0f, -grad.y) * tuning.waterWaveStrength * upness);
}

// FUNCTION: renderWater
vec3 renderWater(ivec3 voxelPos, vec3 normal, vec3 rayOrigin, vec3 sunDir, vec3 sunColor, float shadow, vec3 baseLighting) {
    vec3 baseColor = vec3(0.1f, 0.4f, 0.9f); 
    
    vec3 viewDir = normalize(rayOrigin - vec3(voxelPos));
    vec3 reflectDir = reflect(-sunDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0f), 32.0f);
    
    vec3 finalLighting = baseLighting + (sunColor * spec * 0.5f * shadow);
    return baseColor * finalLighting;
}

// FUNCTION: renderStone
vec3 renderStone(ivec3 voxelPos, vec3 baseLighting) {
    float noise = hash(vec3(voxelPos)); 
    float val = 0.4f + (noise * 0.3f);
    vec3 baseColor = vec3(val, val, val); 
    
    return baseColor * baseLighting;
}

// FUNCTION: renderDirt
vec3 renderDirt(uint rawVoxel, ivec3 voxelPos, vec3 ddaNormal, vec3 baseLighting) {
    float noise = hash(vec3(voxelPos));
    float val = 0.8f + (noise * 0.2f);
    
    uint moisture = (rawVoxel >> 24) & 0xFFu;
    float wetness = clamp(float(moisture) / 30.0f, 0.0f, 1.0f); 
    
    vec3 dryColor = vec3(0.4f * val, 0.25f * val, 0.1f * val);
    vec3 wetColor = vec3(0.15f * val, 0.08f * val, 0.03f * val); 
    vec3 baseColor = mix(dryColor, wetColor, wetness); 
    
    uint floraState = (rawVoxel >> 8) & 0xFFu;
    
    if (floraState > 10u && ddaNormal.y > 0.5f) {
        float grassGrow = clamp(float(floraState - 10u) / 90.0f, 0.0f, 1.0f);
        vec3 grassColor = vec3(0.15f + (noise * 0.1f), 0.45f + (noise * 0.15f), 0.15f);
        
        if (floraState > 100u) {
            float drown = clamp(float(floraState - 100u) / 100.0f, 0.0f, 1.0f);
            grassColor = mix(grassColor, vec3(0.35f, 0.35f, 0.15f), drown);
        }
        
        baseColor = mix(baseColor, grassColor, grassGrow);
    }
    
    return baseColor * baseLighting;
}

// FUNCTION: renderFire
vec3 renderFire(uint rawVoxel, ivec3 voxelPos) {
    float noise = hash(vec3(voxelPos) + vec3(pc.time * 10.0f));
    uint age = (rawVoxel >> 24) & 0xFFu;
    float life = clamp(float(age) / 30.0f, 0.0f, 1.0f);
    
    vec3 coreColor = vec3(1.0f, 0.9f, 0.2f);
    vec3 edgeColor = vec3(1.0f, 0.3f, 0.0f);
    
    vec3 fireColor = mix(coreColor, edgeColor, life + noise * 0.3f);
    return fireColor * 1.5f; 
}

// MATERIAL CURSOR PALETTE
// One colour per material type, indexed directly.
//
// A table rather than a switch, deliberately. What was wrong with the if-chain this replaces was
// never its shape -- a switch would read no better and compile to much the same thing -- it was that
// the chain was a THIRD parallel list of per-material data, sitting alongside the MaterialType enum
// and the UI's label array with nothing tying any of the three together. A table does not fix that
// completely, but it makes adding a material one line in one obvious place, and an out-of-range
// type now yields a defined colour instead of falling through to whatever the final else happened
// to be (which was sand's yellow, so an unknown block previewed as sand).
//
// This is the CURSOR's palette specifically. The blocks themselves are shaded procedurally from
// noise, moisture, coolness and lighting, so they cannot be reduced to one colour each -- which is
// why the render dispatch downstream stays a switch. That one dispatches behaviour, not data.
const int MATERIAL_COUNT = 13;
const vec3 MATERIAL_CURSOR_COLOR[MATERIAL_COUNT] = vec3[MATERIAL_COUNT](
    vec3(0.10f, 0.10f, 0.10f), // 0  void
    vec3(1.00f, 0.90f, 0.20f), // 1  sand
    vec3(0.20f, 0.60f, 1.00f), // 2  water
    vec3(0.60f, 0.60f, 0.60f), // 3  stone
    vec3(0.50f, 0.35f, 0.15f), // 4  dirt
    vec3(1.00f, 0.50f, 0.00f), // 5  fire
    vec3(0.90f, 0.90f, 0.90f), // 6  steam
    vec3(0.80f, 0.40f, 1.00f), // 7  black hole
    vec3(1.00f, 0.45f, 0.10f), // 8  lava, hottest -- the four walk the same ramp the blocks do
    vec3(0.85f, 0.30f, 0.07f), // 9  lava
    vec3(0.65f, 0.20f, 0.06f), // 10 lava
    vec3(0.45f, 0.14f, 0.06f), // 11 lava, coldest
    vec3(0.22f, 0.19f, 0.18f)  // 12 dark stone
);

// FUNCTION: renderLava
// Emissive, like fire and unlike every lit material: molten rock is a light source, and running it
// through baseLighting would leave the shaded side of a lava flow looking like wet clay.
//
// Colour and brightness both come off the same coolness byte the simulation uses, so the four stage
// types never have to agree with a separate palette -- a voxel's look and its remaining life are
// literally the same number. Brightness falls much faster than hue, which is what sells cooling:
// the crust goes dull well before it stops being red.
vec3 renderLava(uint rawVoxel, ivec3 voxelPos) {
    float solidify = max(float(tuning.lavaStageSize) * 4.0f, 1.0f);
    float t = clamp(float((rawVoxel >> 24) & 0xFFu) / solidify, 0.0f, 1.0f);

    // Scaled so the hottest stage lands at roughly (1.0, 0.43, 0.10) AFTER the emissive gain below.
    // The old values were pale to begin with and then multiplied by 2, which drove red and green
    // both past 1.0 and clipped the hot end to white -- the brightness was eating the hue.
    vec3 hot  = vec3(0.80f, 0.34f, 0.08f);
    vec3 mid  = vec3(0.72f, 0.16f, 0.035f);
    vec3 cold = vec3(0.30f, 0.075f, 0.05f);
    vec3 baseColor = (t < 0.5f) ? mix(hot, mid, t * 2.0f) : mix(mid, cold, (t - 0.5f) * 2.0f);

    // A slow crust flicker, seeded per voxel so neighbours are not in lockstep. Scaled down as it
    // cools, so nearly-solid lava stops shimmering rather than twinkling until the instant it turns.
    float flicker = hash(vec3(voxelPos) + vec3(floor(pc.time * 3.0f))) * 0.16f * (1.0f - t);
    return baseColor * (mix(1.25f, 0.5f, t) + flicker);
}

// FUNCTION: renderDarkStone
// Cooled lava. Lit like ordinary stone but much darker and faintly warm-tinted, so a solidified flow
// still reads as having come from somewhere rather than looking like ordinary rock that was always
// there.
vec3 renderDarkStone(ivec3 voxelPos, vec3 baseLighting) {
    float noise = hash(vec3(voxelPos));
    float val = 0.10f + noise * 0.06f;
    return vec3(val * 1.08f, val * 0.94f, val * 0.92f) * baseLighting;
}

// FUNCTION: renderSteam
vec3 renderSteam(ivec3 voxelPos, vec3 baseLighting) {
    float noise = hash(vec3(voxelPos) + vec3(pc.time));
    float val = 0.85f + (noise * 0.15f);
    vec3 baseColor = vec3(val, val, val); 
    
    return baseColor * baseLighting * 0.9f;
}

// FUNCTION: renderBlackHole
// Deliberately unlit: a surface that took the scene's diffuse term would read as a dark grey cube
// sitting in the light, which is the one thing it must not look like. Only a thin grazing-angle rim
// survives, so the voxel reads as a hole punched in the world with a lensed edge.
vec3 renderBlackHole(vec3 normal, vec3 rayDir) {
    float rim = 1.0f - abs(dot(normal, rayDir));
    float glow = pow(clamp(rim, 0.0f, 1.0f), 4.0f);
    return mix(vec3(0.01f, 0.01f, 0.02f), vec3(0.85f, 0.45f, 1.0f), glow * 0.7f);
}

// FUNCTION: bhDecode
ivec3 bhDecode(uint code) {
    uint i = code & BH_INDEX_MASK;
    return ivec3(int(i % uint(WIDTH)), int((i / uint(WIDTH)) % uint(HEIGHT)), int(i / uint(WIDTH * HEIGHT)));
}

// FUNCTION: bhBodyRadius / bhLevel
// DUPLICATED VERBATIM FROM falling_sand.comp. Both stages read the same swallowed-voxel count from
// the same buffer, so they derive the same body size with nothing to synchronise. If you change the
// growth curve in one you MUST change it in the other, or the body that gets drawn will stop
// matching the body that eats.
float bhBodyRadius(uint level) { return float(level) + 0.5f; }

uint bhLevel(uint mass) {
    uint level = 0u;
    for (uint l = 1u; l <= min(tuning.blackHoleMaxLevel, 16u); l++) {
        float r = bhBodyRadius(l);
        float volume = 4.18879f * r * r * r; // 4/3 pi r^3
        if (float(mass) < tuning.blackHoleGrowthCost * volume) break;
        level = l;
    }
    return level;
}

// FUNCTION: accretionGlow
// Tints whatever the ray hit by how deep inside a black hole's influence it sits. Purely cosmetic,
// but it is what makes the disk legible: without it a captured stream of sand is the same yellow as
// a dune and the orbit reads as a glitch rather than as matter being whipped around something.
// Cheap enough to run at the single hit point -- at most BLACK_HOLE_MAX distance tests.
vec3 accretionGlow(vec3 color, ivec3 voxelPos) {
    if (blackHoleCount == 0u || tuning.blackHoleGlow <= 0.0f) return color;

    float radius = float(tuning.blackHoleRadius);
    // Compared squared, so the loop costs one sqrt at the end rather than one per slot -- and it
    // stops as soon as it has seen every live hole, since the table is sparse and usually holds one.
    float closestSq = radius * radius;
    uint seen = 0u;

    for (int i = 0; i < BLACK_HOLE_MAX && seen < blackHoleCount; i++) {
        uint code = blackHoles[i];
        if (code == 0u) continue;
        seen++;
        vec3 d = vec3(bhDecode(code) - voxelPos);
        closestSq = min(closestSq, dot(d, d));
    }

    if (closestSq >= radius * radius) return color;
    float closest = sqrt(closestSq);

    // Ramps hard rather than linearly so only the inner disk actually glows -- a linear falloff
    // washed the entire influence sphere in orange and lost the shape of the spiral.
    float heat = pow(1.0f - closest / radius, 3.0f) * tuning.blackHoleGlow;
    vec3 hot = mix(vec3(1.0f, 0.45f, 0.1f), vec3(1.0f, 0.95f, 0.85f), clamp(heat, 0.0f, 1.0f));
    return mix(color, hot, clamp(heat, 0.0f, 1.0f));
}

// =================================================================================================
// CLOUD FIELD -- read only. The placement maths lives in falling_sand.comp, which evaluates it once
// per dispatch into cloudCache; this stage just reads the answer.
//
// It used to be duplicated here verbatim, with a warning that editing one copy without the other
// would make rain fall from a clear sky. Sharing the cache removes that hazard outright, and removes
// the cost that made it worth duplicating in the first place: six sin() calls per cloud, re-derived
// by every pixel, is ~369 M transcendentals a frame at 32 clouds and 1600x1200.
//
// The vertical centre and the edge fade are cached too. Both were still being re-derived here per
// pixel after the first pass -- the centre carried a hash() of its own and the fade is four
// smoothsteps -- and both are constant for the whole frame, so a pixel has nothing to contribute to
// either answer.
// =================================================================================================
vec3  cloudCenter(int i) { return vec3(cloudCache[i * 7 + 0], cloudCache[i * 7 + 1], cloudCache[i * 7 + 2]); }
vec3  cloudRadii(int i)  { return vec3(cloudCache[i * 7 + 3], cloudCache[i * 7 + 4], cloudCache[i * 7 + 5]); }
float cloudFade(int i)   { return cloudCache[i * 7 + 6]; }

// FUNCTION: marchBlockyCloud
// Walks a per-cloud voxel grid (same DDA stepping pattern as the primary raymarch loop) bounded
// to the ray's intersection interval with the cloud's ellipsoid. A cell counts as solid only if
// it's inside the ellipsoid AND passes a per-cell hash test biased toward emptiness near the
// edge — giving a blocky, cube-faceted surface whose overall silhouette still reads as an
// ellipsoid, with a ragged/fluffy boundary rather than a hard edge. Color blends from white/
// light-grey (fresh) toward storm-grey as `greyness` (driven by the rain state machine) rises.
bool marchBlockyCloud(vec3 rayOrigin, vec3 rayDir, vec3 center, vec3 radii, float cloudSeed,
                       float tEnter, float tExit, vec3 sunDir, float greyness, out float tHit, out vec3 hitColor) {

    tEnter = max(tEnter, 0.0f);
    if (tEnter >= tExit) return false;

    vec3 startPos = rayOrigin + rayDir * tEnter;
    ivec3 cellPos = ivec3(floor(startPos / tuning.cloudVoxelSize));
    ivec3 stepDir = ivec3(sign(rayDir));

    vec3 tDelta = vec3(
        (rayDir.x == 0.0f) ? 100000000.0f : abs(tuning.cloudVoxelSize / rayDir.x),
        (rayDir.y == 0.0f) ? 100000000.0f : abs(tuning.cloudVoxelSize / rayDir.y),
        (rayDir.z == 0.0f) ? 100000000.0f : abs(tuning.cloudVoxelSize / rayDir.z)
    );
    vec3 fracPos = startPos / tuning.cloudVoxelSize - vec3(cellPos);
    vec3 tMax = tEnter + vec3(
        (stepDir.x > 0) ? (1.0f - fracPos.x) * tDelta.x : fracPos.x * tDelta.x,
        (stepDir.y > 0) ? (1.0f - fracPos.y) * tDelta.y : fracPos.y * tDelta.y,
        (stepDir.z > 0) ? (1.0f - fracPos.z) * tDelta.z : fracPos.z * tDelta.z
    );

    vec3 normal = vec3(0.0f);
    float t = tEnter;

    // Hash the blocky fill in the cloud's OWN cell space, not world space. Now that clouds drift,
    // a world-anchored pattern would boil and shimmer as cells slid through a stationary noise
    // field. Subtracting the cloud's (rounded) cell origin pins the pattern to the cloud, so it
    // holds its shape and simply translates -- the motion quantises to whole voxel steps, which
    // reads correctly for a deliberately cube-faceted look.
    ivec3 cloudOrigin = ivec3(round(center / tuning.cloudVoxelSize));

    for (int i = 0; i < int(tuning.maxCloudSteps); i++) {
        if (t > tExit) break;

        vec3 cellCenter = (vec3(cellPos) + 0.5f) * tuning.cloudVoxelSize;
        vec3 local = (cellCenter - center) / radii;
        float localLen = length(local);

        if (localLen <= 1.0f) {
            vec3 localCell = vec3(cellPos - cloudOrigin);
            float fillHash = hash(localCell + vec3(cloudSeed * 13.0f, cloudSeed * 7.0f, cloudSeed * 29.0f));
            float edgeFactor = clamp(localLen, 0.0f, 1.0f);
            float threshold = mix(tuning.cloudEdgeThresholdMin, tuning.cloudEdgeThresholdMax, edgeFactor); // sparser near the edge, denser near the center

            if (fillHash > threshold) {
                tHit = t;
                float shadeHash = hash(localCell * 3.71f + vec3(91.0f, cloudSeed, 7.0f));
                vec3 baseColor = mix(vec3(0.76f, 0.76f, 0.78f), vec3(1.0f), shadeHash); // white -> light grey
                vec3 stormColor = vec3(0.32f, 0.33f, 0.36f);
                baseColor = mix(baseColor, stormColor, greyness);

                float diffuse = 0.6f + 0.4f * max(dot(normal, sunDir), 0.0f);
                hitColor = baseColor * diffuse;
                return true;
            }
        }

        if (tMax.x < tMax.y) {
            if (tMax.x < tMax.z) {
                cellPos.x += stepDir.x; t = tMax.x; tMax.x += tDelta.x; normal = vec3(float(-stepDir.x), 0.0f, 0.0f);
            } else {
                cellPos.z += stepDir.z; t = tMax.z; tMax.z += tDelta.z; normal = vec3(0.0f, 0.0f, float(-stepDir.z));
            }
        } else {
            if (tMax.y < tMax.z) {
                cellPos.y += stepDir.y; t = tMax.y; tMax.y += tDelta.y; normal = vec3(0.0f, float(-stepDir.y), 0.0f);
            } else {
                cellPos.z += stepDir.z; t = tMax.z; tMax.z += tDelta.z; normal = vec3(0.0f, 0.0f, float(-stepDir.z));
            }
        }
    }

    return false;
}

// FUNCTION: main
void main() {
    vec2 screenSpace = inUV * 2.0f - 1.0f; 
    screenSpace.y = -screenSpace.y; 

    vec3 baseOrigin = vec3(pc.camX, pc.camY, pc.camZ);

    vec3 forward = applyCameraRotation(vec3(0.0f, 0.0f, 1.0f));
    vec3 right   = applyCameraRotation(vec3(1.0f, 0.0f, 0.0f));
    vec3 up      = applyCameraRotation(vec3(0.0f, 1.0f, 0.0f));

    float t = clamp(pc.perspectiveBlend, 0.0f, 1.0f);

    // Orthographic half-width/height auto-derived from distance to the cube's center along
    // the view direction, so scrubbing the blend slider doesn't cause a visible "pop" in scale.
    vec3 cubeCenter = worldExtent() * 0.5f;
    float viewDistance = max(1.0f, dot(cubeCenter - baseOrigin, forward));
    float orthoHalfSize = viewDistance / pc.fovDistance;

    vec3 localDir = mix(vec3(0.0f, 0.0f, 1.0f), vec3(screenSpace.x, screenSpace.y, pc.fovDistance), t);
    vec3 rayDir = normalize(right * localDir.x + up * localDir.y + forward * localDir.z);

    vec3 originOffset = (right * screenSpace.x + up * screenSpace.y) * orthoHalfSize * (1.0f - t);
    vec3 rayOrigin = baseOrigin + originOffset;
    
    vec4 finalColor = vec4(0.05f, 0.05f, 0.1f, 1.0f);
    float finalDist = 1000000.0f;
    
    vec2 aabbHit = intersectAABB(rayOrigin, rayDir, vec3(0.0f), worldExtent());
    bool hitFrontBox = false;
    bool hitBackBox = false;

    if (aabbHit.x < aabbHit.y && aabbHit.y > 0.0f) {
        if (aabbHit.x > 0.0f && isEdge(rayOrigin + rayDir * aabbHit.x)) hitFrontBox = true;
        if (isEdge(rayOrigin + rayDir * aabbHit.y)) hitBackBox = true;
    }

    // The march runs against the world clipped to its occupied height, not the full cube. The full
    // extent is still what the wireframe edges above and the distance fade below are measured
    // against -- only where the DDA starts and stops changes.
    int ceilingY = marchCeiling();
    vec2 marchHit = intersectAABB(rayOrigin, rayDir, vec3(0.0f), vec3(float(WIDTH), float(ceilingY), float(DEPTH)));

    vec3 currentPos = rayOrigin + rayDir * max(0.0f, marchHit.x);
    if (marchHit.x > 0.0f) currentPos += rayDir * 0.001f;

    ivec3 voxelPos = ivec3(floor(currentPos));
    ivec3 stepDir = ivec3(sign(rayDir));
    
    vec3 tDelta = vec3(
        (rayDir.x == 0.0f) ? 100000000.0f : abs(1.0f / rayDir.x),
        (rayDir.y == 0.0f) ? 100000000.0f : abs(1.0f / rayDir.y),
        (rayDir.z == 0.0f) ? 100000000.0f : abs(1.0f / rayDir.z)
    );
    
    vec3 tMax = vec3(
        (stepDir.x > 0) ? (floor(currentPos.x) + 1.0f - currentPos.x) * tDelta.x : (currentPos.x - floor(currentPos.x)) * tDelta.x,
        (stepDir.y > 0) ? (floor(currentPos.y) + 1.0f - currentPos.y) * tDelta.y : (currentPos.y - floor(currentPos.y)) * tDelta.y,
        (stepDir.z > 0) ? (floor(currentPos.z) + 1.0f - currentPos.z) * tDelta.z : (currentPos.z - floor(currentPos.z)) * tDelta.z
    );

    vec3 normal = vec3(0.0f);
    bool hit = false;
    uint hitType = 0u;
    uint hitRawVoxel = 0u;

    // Measured against the full cube, not the clipped march box, so the fade does not change as the
    // world fills up or empties.
    float MAX_VISIBILITY = max(300.0f, aabbHit.y * 1.5f);


    for (int i = 0; i < int(tuning.marchMaxSteps); i++) {
        if (voxelPos.x < 0 || voxelPos.x >= WIDTH ||
            voxelPos.y < 0 || voxelPos.y >= ceilingY ||
            voxelPos.z < 0 || voxelPos.z >= DEPTH) {
            break;
        }
        
        uint rawVoxel = getVoxel(voxelPos);
        hitType = rawVoxel & 0xFFu;

        // A black hole's centre voxel must not register as a solid cube: the body is drawn as a
        // smooth ball after this loop, and at level 0 the voxel cube is strictly larger than the
        // radius-0.5 ball inside it, so letting it hit here would draw a cube over the sphere and
        // undo the shape entirely. The ray passes through instead -- the physics keeps the body's
        // interior swept clear, so there is nothing else in there to occlude.
        if (hitType == 7u) hitType = 0u;

        if (hitType != 0u) {
            // Implementation of Dithered Transparency for Steam (Type 6)
            if (hitType == 6u) {
                uint age = (rawVoxel >> 24) & 0xFFu;
                // Alpha scales from 1.0 (Age 0) down to 0.3 (Age 100+)
                float targetAlpha = mix(1.0f, 0.3f, clamp(float(age) / 100.0f, 0.0f, 1.0f));
                
                // Screen-space noise hash
                float dither = fract(sin(dot(inUV + vec2(pc.time * 0.1f), vec2(12.9898f, 78.233f))) * 43758.5453f);
                
                if (dither > targetAlpha) {
                    hitType = 0u; // Skip this hit, let the ray keep traveling
                } else {
                    hit = true;
                    hitRawVoxel = rawVoxel; 
                    break;
                }
            } else {
                hit = true;
                hitRawVoxel = rawVoxel; 
                break;
            }
        }
        
        if (tMax.x < tMax.y) {
            if (tMax.x < tMax.z) {
                voxelPos.x += stepDir.x;
                tMax.x += tDelta.x;
                normal = vec3(float(-stepDir.x), 0.0f, 0.0f);
            } else {
                voxelPos.z += stepDir.z;
                tMax.z += tDelta.z;
                normal = vec3(0.0f, 0.0f, float(-stepDir.z));
            }
        } else {
            if (tMax.y < tMax.z) {
                voxelPos.y += stepDir.y;
                tMax.y += tDelta.y;
                normal = vec3(0.0f, float(-stepDir.y), 0.0f);
            } else {
                voxelPos.z += stepDir.z;
                tMax.z += tDelta.z;
                normal = vec3(0.0f, 0.0f, float(-stepDir.z));
            }
        }
    }
    
    if (hit) {
        if (length(normal) < 0.1f) normal = -rayDir;
        
        vec3 ddaNormal = normal;

        // Water gets the wider density-gradient normal; everything else keeps the cheap binary one,
        // which is fine for materials that are not in constant motion at their surface.
        if (hitType == 2u) {
            normal = applyWaterWaves(getWaterNormal(voxelPos), voxelPos);
        } else {
            normal = getSmoothNormal(voxelPos);
        }

        // Waves are applied above rather than inside renderWater so they drive the diffuse term too,
        // not just the highlight. Perturbing further down would light the surface flat and then gloss
        // a wave pattern over it, which reads as a moving texture instead of moving water.
        // ddaNormal is deliberately left alone -- it is the face the ray actually entered, and
        // calculateShadow steps from it, so bending it would make the shadow ray start off-surface.


        vec3 sunDir = normalize(vec3(0.8f, 1.0f, 0.5f)); 
        vec3 sunColor = vec3(1.0f, 0.95f, 0.85f); 
        vec3 ambientColor = vec3(0.15f, 0.2f, 0.3f); 
        
        float diffuse = max(dot(normal, sunDir), 0.0f);
        float shadow = calculateShadow(voxelPos, ddaNormal, sunDir, ceilingY);
        vec3 baseLighting = ambientColor + (sunColor * diffuse * shadow);
        
        vec3 finalVoxelColor = vec3(1.0f, 0.0f, 1.0f) * baseLighting; 
        
        switch (hitType) {
            case 1u:
                finalVoxelColor = renderSand(hitRawVoxel, baseLighting);
                break;
            case 2u:
                finalVoxelColor = renderWater(voxelPos, normal, rayOrigin, sunDir, sunColor, shadow, baseLighting);
                break;
            case 3u:
                finalVoxelColor = renderStone(voxelPos, baseLighting);
                break;
            case 4u:
                finalVoxelColor = renderDirt(hitRawVoxel, voxelPos, ddaNormal, baseLighting);
                break;
            case 5u:
                finalVoxelColor = renderFire(hitRawVoxel, voxelPos);
                break;
            case 6u:
                finalVoxelColor = renderSteam(voxelPos, baseLighting);
                break;
            case 8u:
            case 9u:
            case 10u:
            case 11u:
                finalVoxelColor = renderLava(hitRawVoxel, voxelPos);
                break;
            case 12u:
                finalVoxelColor = renderDarkStone(voxelPos, baseLighting);
                break;
            // No case for type 7: the march above never reports a black hole voxel as a hit, because
            // the body is drawn as a ball further down rather than as the voxel it is anchored to.
            default:
                break;
        }

        finalVoxelColor = accretionGlow(finalVoxelColor, voxelPos);

        float distanceTraveled = length(vec3(voxelPos) + vec3(0.5f) - rayOrigin);
        finalVoxelColor *= mix(1.0f, 0.0f, clamp(distanceTraveled / MAX_VISIBILITY, 0.0f, 1.0f));
        
        finalDist = distanceTraveled;
        finalColor = vec4(finalVoxelColor, 1.0f);
        
    } else if (hitBackBox) {
        finalDist = aabbHit.y;
        finalColor = vec4(1.0f, 0.2f, 0.2f, 1.0f);
    }

    // --- BLACK HOLE BODIES: a hole's body is a ball of radius level+0.5, but only its CENTRE voxel
    // is stored in the grid -- the rest is empty space the physics keeps swept clear. So the body is
    // intersected analytically here, the way the cloud layer is, instead of being marched. Testing 8
    // table slots at each of the DDA loop's 400 steps would cost thousands of reads per pixel to
    // draw a shape one ray/sphere test resolves exactly, and it would come out voxel-stepped besides,
    // where the point of a sphere is that it is smooth. ---
    if (blackHoleCount > 0u) {
        uint seenHoles = 0u;
        for (int i = 0; i < BLACK_HOLE_MAX && seenHoles < blackHoleCount; i++) {
            uint code = blackHoles[i];
            if (code == 0u) continue;
            seenHoles++;

            // Purge holes size straight off their remaining mass rather than the growth curve, so
            // they shrink as a smooth ramp. Must match bhLevelFor in falling_sand.comp.
            uint bodyLevel = ((code & BH_PURGE) != 0u)
                ? uint(float(tuning.purgeLevel) * clamp(float(blackHoleMass[i]) / float(max(tuning.purgeMass, 1u)), 0.0f, 1.0f))
                : bhLevel(blackHoleMass[i]);
            float bodyRadius = bhBodyRadius(bodyLevel);
            // +0.5 puts the centre at the middle of its voxel rather than its min corner, so the
            // ball is concentric with the region the physics clears.
            vec3 center = vec3(bhDecode(code)) + vec3(0.5f);

            vec3 oc = rayOrigin - center;
            float b = dot(oc, rayDir);
            float c = dot(oc, oc) - bodyRadius * bodyRadius;
            float disc = b * b - c;
            if (disc <= 0.0f) continue;

            float sq = sqrt(disc);
            float tNear = -b - sq;
            float tFar = -b + sq;
            if (tFar <= 0.0f) continue;

            float bodyDist = max(0.0f, tNear);
            if (bodyDist < finalDist) {
                vec3 surfaceNormal = normalize(rayOrigin + rayDir * bodyDist - center);

                vec3 bodyColor = renderBlackHole(surfaceNormal, rayDir);
                bodyColor *= mix(1.0f, 0.0f, clamp(bodyDist / MAX_VISIBILITY, 0.0f, 1.0f));

                finalColor = vec4(bodyColor, 1.0f);
                finalDist = bodyDist;
            }
        }
    }

    // --- CLOUD LAYER: a fixed population of clouds constantly drifting along +X and wrapping,
    // clipped to the cube's footprint and rendered as blocky/voxelized cubes bounded within a
    // smooth ellipsoid envelope. The whole field shares ONE charge value, so the sky thickens
    // from near-transparent to opaque storm-grey as a body rather than individual clouds
    // popping in and out; each cloud additionally dissolves as it drifts into a border. ---
    {
        // Group charge, eased on the compute side. Drives opacity and colour together, which is
        // what makes the sky read as a single mass reacting to the water cycle.
        float charge = clamp(uintBitsToFloat(cloudChargeBits), 0.0f, 1.0f);
        float groupAlpha = mix(tuning.cloudMinAlpha, tuning.cloudMaxAlpha, charge);

        // Colour tracks charge as well, so a lightly-charged sky is pale and a heavy one is grey
        // before the storm even breaks; the rain phases then force it the rest of the way.
        float cloudGreyness = charge;
        if (rainPhase == 1u) {
            float crossedTime = uintBitsToFloat(rainPhaseTimeBits);
            cloudGreyness = max(charge, clamp((pc.time - crossedTime) / tuning.rainDarkenDelay, 0.0f, 1.0f));
        } else if (rainPhase == 2u) {
            cloudGreyness = 1.0f;
        }

        if (groupAlpha > 0.002f) {
            vec2 footprintClip = intersectAABB(rayOrigin, rayDir, vec3(0.0f, -1000000.0f, 0.0f), vec3(float(WIDTH), 1000000.0f, float(DEPTH)));
            vec3 cloudSunDir = normalize(vec3(0.8f, 1.0f, 0.5f));

            float bestT = 1000000.0f;
            vec3 bestColor = vec3(0.0f);
            float bestAlpha = 0.0f;
            bool foundCloud = false;

            int cloudN = int(min(tuning.cloudCount, uint(CLOUD_MAX)));
            for (int i = 0; i < cloudN; i++) {
                float edgeFade = cloudFade(i);
                if (edgeFade <= 0.01f) continue;

                vec3 center = cloudCenter(i);
                vec3 radii = cloudRadii(i);

                vec3 oc = (rayOrigin - center) / radii;
                vec3 rdn = rayDir / radii;
                float a = dot(rdn, rdn);
                float b = dot(oc, rdn);
                float c = dot(oc, oc) - 1.0f;
                float disc = b * b - a * c;

                if (disc > 0.0f) {
                    float sq = sqrt(disc);
                    float t0 = (-b - sq) / a;
                    float t1 = (-b + sq) / a;

                    float clippedNear = max(t0, footprintClip.x);
                    float clippedFar = min(t1, footprintClip.y);

                    // Only the nearest cloud is ever drawn, and only if it is in front of the
                    // geometry, so a cloud whose whole interval starts behind either cannot change
                    // the result -- and marching it is up to maxCloudSteps of DDA for an answer
                    // already known. Exact rather than approximate: clippedNear is a lower bound on
                    // anything this cloud could produce, and both tests below it are strict.
                    if (clippedNear >= min(bestT, finalDist)) continue;

                    if (clippedNear < clippedFar && clippedFar > 0.0f) {
                        float cloudTHit;
                        vec3 cloudColor;
                        if (marchBlockyCloud(rayOrigin, rayDir, center, radii, float(i), clippedNear, clippedFar, cloudSunDir, cloudGreyness, cloudTHit, cloudColor)) {
                            if (cloudTHit > 0.0f && cloudTHit < bestT) {
                                bestT = cloudTHit;
                                bestColor = cloudColor;
                                bestAlpha = clamp(groupAlpha * edgeFade, 0.0f, 0.95f);
                                foundCloud = true;
                            }
                        }
                    }
                }
            }

            if (foundCloud && bestT < finalDist) {
                finalColor.rgb = mix(finalColor.rgb, bestColor, bestAlpha);
            }
        }
    }
    
    if (pc.spawnX >= 0 && pc.spawnX < WIDTH && pc.spawnY >= 0 && pc.spawnY < HEIGHT && pc.spawnZ >= 0 && pc.spawnZ < DEPTH) {
        
        int halfDistMin = pc.spawnSize / 2;
        int halfDistMax = (pc.spawnSize - 1) / 2;
        
        vec3 boxMin = vec3(float(pc.spawnX - halfDistMin), float(pc.spawnY - halfDistMin), float(pc.spawnZ - halfDistMin));
        vec3 boxMax = vec3(float(pc.spawnX + halfDistMax + 1), float(pc.spawnY + halfDistMax + 1), float(pc.spawnZ + halfDistMax + 1));

        vec3 cursorColor = MATERIAL_CURSOR_COLOR[clamp(pc.spawnType, 0, MATERIAL_COUNT - 1)];

        if (pc.spawnShape == 1) {
            // Matched to inBrush() in falling_sand.comp: same centre, same radius, so the outline
            // encloses exactly the voxels a click would write.
            vec3 sphereCenter = (boxMin + boxMax) * 0.5f;
            float sphereRadius = float(pc.spawnSize) * 0.5f;

            vec3 oc = rayOrigin - sphereCenter;
            float b = dot(oc, rayDir);
            float c = dot(oc, oc) - sphereRadius * sphereRadius;
            float disc = b * b - c;

            if (disc > 0.0f) {
                float sq = sqrt(disc);
                float tNear = -b - sq;
                float tFar = -b + sq;

                if (tFar > 0.0f) {
                    // Inside the brush the near hit is behind the camera, so shade from the far
                    // side and dim it -- the same read as the box cursor's back edges.
                    bool inside = tNear <= 0.0f;
                    float cursorDist = inside ? tFar : tNear;
                    vec3 shellNormal = normalize((rayOrigin + rayDir * cursorDist) - sphereCenter);

                    // 1 where the ray grazes the shell, which is exactly the silhouette. Shading
                    // the rim rather than filling the sphere keeps the world visible through it.
                    float rim = 1.0f - abs(dot(shellNormal, rayDir));
                    float alpha = mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, rim)) * (inside ? 0.35f : 1.0f);

                    if (cursorDist < finalDist) {
                        finalColor.rgb = mix(finalColor.rgb, cursorColor, alpha);
                    }
                }
            }
        } else {
            vec2 cursorHit = intersectAABB(rayOrigin, rayDir, boxMin, boxMax);

            if (cursorHit.x < cursorHit.y && cursorHit.y > 0.0f) {
                float distFront = max(0.0f, cursorHit.x);
                float distBack = cursorHit.y;

                vec3 hitPosFront = rayOrigin + rayDir * distFront;
                vec3 hitPosBack = rayOrigin + rayDir * distBack;

                float e = 0.15f;

                bool onFrontEdge = false;
                int edgesFront = 0;
                if (hitPosFront.x < boxMin.x + e || hitPosFront.x > boxMax.x - e) edgesFront++;
                if (hitPosFront.y < boxMin.y + e || hitPosFront.y > boxMax.y - e) edgesFront++;
                if (hitPosFront.z < boxMin.z + e || hitPosFront.z > boxMax.z - e) edgesFront++;
                if (edgesFront >= 2) onFrontEdge = true;

                bool onBackEdge = false;
                int edgesBack = 0;
                if (hitPosBack.x < boxMin.x + e || hitPosBack.x > boxMax.x - e) edgesBack++;
                if (hitPosBack.y < boxMin.y + e || hitPosBack.y > boxMax.y - e) edgesBack++;
                if (hitPosBack.z < boxMin.z + e || hitPosBack.z > boxMax.z - e) edgesBack++;
                if (edgesBack >= 2) onBackEdge = true;

                if (onFrontEdge && distFront < finalDist) {
                    finalColor.rgb = mix(finalColor.rgb, cursorColor, 0.9f);
                } else if (onBackEdge && distBack < finalDist) {
                    finalColor.rgb = mix(finalColor.rgb, cursorColor, 0.2f);
                } else if (distFront < finalDist) {
                    finalColor.rgb = mix(finalColor.rgb, cursorColor, 0.15f);
                }
            }
        }
    }


    if (hitFrontBox) {
        finalColor = vec4(1.0f, 0.2f, 0.2f, 1.0f);
    }
    
    outColor = finalColor;
}
