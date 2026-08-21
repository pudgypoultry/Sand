#version 450

layout(location = 0) in vec2 inUV;
layout(location = 0) out vec4 outColor;

layout(std430, binding = 0) readonly buffer VoxelGrid {
    uint grid[];
};

// Must stay byte-identical to the SimStats block in falling_sand.comp, and BH_INDEX_MASK must match
// the slot encoding used there.
const int BLACK_HOLE_MAX = 8;
const uint BH_INDEX_MASK = 0x3FFFFFFFu;
const uint BH_PURGE = 0x40000000u;

// readonly, and it has to be: WebGPU allows a read-write storage buffer in compute shaders only,
// so a fragment shader binding this without it is rejected. Nothing here ever writes to it.
layout(std430, binding = 1) readonly buffer SimStats {
    uint waterVoxelCount;
    uint waterHighMark;
    uint cloudWaterCount;
    uint rainPhase;
    uint rainPhaseTimeBits;
    uint rainTargetLevel;
    uint rainCandidateCount;
    uint rainCandidateEstimate;
    uint cloudChargeBits;
    uint cloudBlockCount;
    uint cloudChangedCount;
    uint cloudStillTicks;        // UNUSED: the storm check samples rather than accumulating
    uint simTick;                // dispatches since startup; the clock the checks run on
    uint lastRainTick;           // simTick at the last rain event, for the profiler
    // The global Y range of the cloud field, so the renderer can start its march at the band
    // instead of at the edge of the world. Accumulator pair and published pair, rotated once
    // per dispatch like every other census here. Published min > max means no cloud at all.
    uint cloudMinYAcc;
    uint cloudMaxYAcc;
    uint cloudMinY;
    uint cloudMaxY;
    uint blackHoleCount;
    uint maxOccupiedY;
    uint blackHoles[BLACK_HOLE_MAX];
    uint blackHoleMass[BLACK_HOLE_MAX];
    uint blackHoleStarve[BLACK_HOLE_MAX];
    // Four words per column at (x + z * WIDTH) * 4; slots 2 and 3 are the published count and top Y
    // this shader reads. Must match falling_sand.comp exactly -- see the comment there. Runtime-sized
    // and therefore necessarily last.
    uint cloudColumn[];
};

// The cloud field, read-only. Bound purely for the "show cloud blocks" debug view -- the clouds
// actually drawn come from the per-column census in SimStats, which is one number per column rather
// than one per voxel, so normal rendering never touches this.
layout(std430, binding = 4) readonly buffer CloudGrid {
    uint cloudCells[];
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
    float lavaChurnRate;
    uint locustTickDispatches;
    uint locustStageSize;
    uint locustSpawnSize;
    uint locustMaxSize;
    uint locustBudSize;
    uint locustEatGain;
    uint locustEatTicksMin;
    uint locustEatTicksMax;
    uint locustRunLength;
    float locustClimbChance;
    float locustDensityMin;
    float locustDensityMax;
    uint locustSubdivision;
    float locustCrawlRate;
    float treeBloomChance;
    uint treeMaxHeight;
    uint treeSoilReserve;
    uint treeWaterMax;
    float treeDrinkChance;
    float treeFlowChance;
    uint treeGrowCost;
    uint treeLeafCost;
    uint treeSpreadCost;
    float treeSpreadChance;
    float treeLeafChance;
    uint treeLeafReach;
    float treeLeafSpreadChance;
    float treeLeafTickChance;
    float treeLeafFallChance;
    float treeTrunkBurnChance;
    float treeLeafBurnChance;
    uint treeTrunkColumns;
    float treeTrunkRadius;
    float renderScale;
    uint cloudCheckIntervalTicks; // dispatches between storm checks
    uint rainWaitMaxTicks;        // ceiling of a raincloud's wait, 0..2047
    float cloudColumnFullCount;   // cloud blocks in a column that read as fully dense
    float cloudThicknessPerBlock; // world units of cloud drawn per block in the column
    uint cloudClumpThreshold;     // UNUSED: cloud spreads like sand, no cohesion
    uint rainWaitMinTicks;        // floor of a raincloud's wait at the ceiling
    uint steamCondenseTicks;      // dispatches of stillness before steam condenses in place
    float cloudSmoothRate;        // how fast the drawn cloud surface follows the block field
    uint treeMinHeight;           // shortest a tree may top out at; treeMaxHeight is the tallest
    float fireAshChance;          // chance a fire that burns out leaves ash behind
    float ashDriftChance;         // chance settling ash slumps sideways instead of holding still
    float ashEnrichChance;        // chance per dispatch that ash resting on soil works into it
    uint ashEnrichAmount;         // flora a worked-in grain of ash is worth
    uint ashSettleTicks;          // dispatches a grain slumps for after landing, then sets
} tuning;

// Per-frame state the CPU writes: camera pose, cursor position, brush.
//
// Vulkan takes this as push constants -- 60 bytes written straight into the command buffer, with
// no buffer to allocate and nothing to synchronise. WebGPU has no equivalent at all; the web build
// binds the same fields as an ordinary uniform buffer instead.
//
// Only the declaration differs. The fields are all scalars, so std140 packs them at exactly the
// offsets a push-constant block uses, and the same C++ PushConstants struct is the payload either
// way. Keeping it as one #ifdef rather than two shader files is what stops the two from drifting.
#ifdef SAND_WEB
layout(std140, binding = 3) uniform Constants {
#else
layout(push_constant) uniform Constants {
#endif
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
    // The view's reach sideways and vertically, relative to the 4:3 framing the camera was built
    // around. Applied to screenSpace in main. See FrameConstants.hpp.
    float aspectScaleX;
    float aspectScaleY;
    int showCloudBlocks; // debug view: draw the invisible cloud blocks as solid voxels
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
// The debug view's stand-in material. Far above every real id, so it can never collide with one.
const uint CLOUD_DEBUG_TYPE = 200u;

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
const int MATERIAL_COUNT = 20;
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
    vec3(0.22f, 0.19f, 0.18f), // 12 dark stone
    vec3(0.38f, 0.30f, 0.12f), // 13 locusts, sparsest -- the five darken as the swarm thickens
    vec3(0.46f, 0.35f, 0.13f), // 14 locusts
    vec3(0.54f, 0.40f, 0.14f), // 15 locusts, the placeable stage
    vec3(0.62f, 0.45f, 0.15f), // 16 locusts
    vec3(0.70f, 0.51f, 0.16f), // 17 locusts, densest
    vec3(0.36f, 0.24f, 0.12f), // 18 tree trunk
    vec3(0.22f, 0.46f, 0.15f)  // 19 tree leaves
);

const uint LAVA_HOTTEST = 8u;

// LAVA COLOUR RAMP
// Four stage colours with one reach past each end, indexed by stage + 1 so the two out-of-range
// entries sit where stage -1 and stage 4 would be. Those two are the point of the table rather than
// padding on it: the hottest stage has no hotter neighbour to cycle toward and the coldest has no
// colder one, so each is given a step further out -- brighter than molten at the top, dimmer than
// crust at the bottom -- and the ends of the range get the same three-colour churn as the middle
// instead of flattening out.
//
// Every entry is deliberately at or under 1.0 in its brightest channel. Lava is emissive, so what is
// written here is what reaches the screen with no lighting term to scale it, and anything over 1.0
// is not "brighter" -- it clips, and clipping red first is exactly how molten orange turns white.
const vec3 LAVA_RAMP[6] = vec3[6](
    vec3(1.00f, 0.62f, 0.22f), // beyond hottest -- the reach above stage 0
    vec3(1.00f, 0.40f, 0.07f), // stage 0, hottest
    vec3(0.96f, 0.29f, 0.05f), // stage 1
    vec3(0.86f, 0.20f, 0.04f), // stage 2
    vec3(0.70f, 0.13f, 0.03f), // stage 3, coldest before it turns to dark stone
    vec3(0.44f, 0.07f, 0.02f)  // beyond coldest -- the reach below stage 3
);

// FUNCTION: lavaStageColor
vec3 lavaStageColor(int stage) {
    return LAVA_RAMP[clamp(stage + 1, 0, 5)];
}

// FUNCTION: renderLava
// Emissive, like fire and unlike every lit material: molten rock is a light source, and running it
// through baseLighting would leave the shaded side of a flow looking like wet clay.
//
// A voxel does not hold still at its stage's colour. It cycles: one third of the phase running from
// the stage below it up to its own, one third from its own up to the stage above, and the last third
// falling back to where it started. Stage 2 therefore walks 1 -> 2 -> 3 -> 1 forever. The mean over
// a cycle is still the stage's own colour, so the cooling gradient across a flow reads exactly as it
// did, but the surface is never flat.
//
// The phase is offset per voxel, which is what makes this churn rather than pulse. Without the
// offset every lava voxel in the world would brighten and dim in unison -- one enormous throbbing
// mass. With it, neighbours sit at different points in the same cycle, so the motion reads as
// something moving THROUGH the flow.
vec3 renderLava(uint rawVoxel, ivec3 voxelPos) {
    int stage = clamp(int(rawVoxel & 0xFFu) - int(LAVA_HOTTEST), 0, 3);

    float phase = fract(pc.time * tuning.lavaChurnRate + hash(vec3(voxelPos)));

    // Three equal legs around the cycle. The third one closes it, which is what keeps the animation
    // seamless -- ending on the stage above and snapping back to the stage below would put a visible
    // jump in every voxel once per cycle.
    vec3 from, to;
    float leg;
    if (phase < 1.0f / 3.0f) {
        from = lavaStageColor(stage - 1); to = lavaStageColor(stage);     leg = phase * 3.0f;
    } else if (phase < 2.0f / 3.0f) {
        from = lavaStageColor(stage);     to = lavaStageColor(stage + 1); leg = phase * 3.0f - 1.0f;
    } else {
        from = lavaStageColor(stage + 1); to = lavaStageColor(stage - 1); leg = phase * 3.0f - 2.0f;
    }

    // Eased rather than linear, so the colour settles at each corner of the cycle instead of sliding
    // through it at constant speed. Linear legs make the turns read as three discrete sweeps.
    vec3 molten = mix(from, to, smoothstep(0.0f, 1.0f, leg));

    // A static per-voxel darkening, so two voxels that happen to share a phase are still not
    // identical. It only ever darkens: the ramp above is already at 1.0 in red at the hot end, and
    // a grain that could brighten would clip precisely the voxels meant to look hottest.
    return molten * (0.90f + hash(vec3(voxelPos) * 1.7f) * 0.10f);
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

// =================================================================================================
// LOCUSTS
//
// A swarm is drawn as what it is -- a cloud of separate bodies -- rather than as a block tinted to
// suggest one. When the primary march reaches a locust voxel it does not stop there; it hands off to
// a second DDA that runs INSIDE that single voxel over a locustSubdivision^3 lattice of sub-cubes,
// each present or absent by a hash test. A ray that threads all the way through the gaps is not a
// hit at all and carries on to whatever is behind, exactly the way steam's dither already works.
//
// The cost is bounded and small: crossing a cube of N cells on a side takes at most 3N sub-steps, so
// 12 at the default subdivision, and only for pixels that actually land on a swarm. Nothing else in
// the frame pays for it.
//
// Fill comes from the stage, which is the head count -- so a swarm visibly thins as it starves and
// thickens as it eats, and the five types are legible at a glance without a legend.
// =================================================================================================
const uint LOCUST_SPARSEST = 13u;
const uint LOCUST_DENSEST = 17u;

// FUNCTION: isLocustType
bool isLocustType(uint type) { return type >= LOCUST_SPARSEST && type <= LOCUST_DENSEST; }

// FUNCTION: locustDensity
float locustDensity(uint type) {
    float stage = float(type - LOCUST_SPARSEST) / 4.0f;
    return clamp(mix(tuning.locustDensityMin, tuning.locustDensityMax, stage), 0.02f, 0.98f);
}

// =================================================================================================
// TREES
//
// A trunk does not fill its voxel -- it is one or two slender stems standing inside it, with air
// around them, which is what makes a trunk read as a trunk rather than as a brown cube. That is the
// same sub-voxel geometry locusts use, so it goes through the same sub-march below; only the test
// for "is this little cube solid" differs, which is why that test is a switch on kind rather than
// baked into the march.
//
// Leaves deliberately do NOT take part. They are far and away the most numerous voxel in a forest,
// a canopy fills a lot of screen, and a sub-march for each of them would be the most expensive
// thing in the frame -- for a shape that is meant to read as a dense mass anyway. They are ordinary
// solid voxels with per-voxel colour variation.
// =================================================================================================
const uint TREE_TRUNK = 18u;
const uint TREE_LEAF = 19u;
// Must match falling_sand.comp: the distance value a leaf carries once it has let go of its tree.
const uint LEAF_DETACHED = 255u;

const uint SUB_LOCUST = 0u;
const uint SUB_TRUNK = 1u;

// FUNCTION: trunkStems
// Where this column's stems sit, in voxel-local XZ. Seeded from the voxel's X and Z only, with Y
// left out on purpose: every trunk voxel stacked above the same ground must produce the same
// answer, or the stems would jump sideways from one voxel to the next and the tree would zigzag.
void trunkStems(ivec3 voxelPos, out vec2 a, out vec2 b, out int count) {
    float h0 = hash(vec3(float(voxelPos.x), 7.0f, float(voxelPos.z)));
    float h1 = hash(vec3(float(voxelPos.x), 19.0f, float(voxelPos.z)));
    float h2 = hash(vec3(float(voxelPos.x), 53.0f, float(voxelPos.z)));

    count = 1 + int(h2 * float(max(int(tuning.treeTrunkColumns), 1)));
    count = clamp(count, 1, 2);

    // Kept off the voxel's edges so a stem is never sliced in half by the boundary between two
    // trunk voxels of the same tree.
    a = vec2(0.30f + h0 * 0.40f, 0.30f + h1 * 0.40f);
    b = vec2(0.30f + h1 * 0.40f, 0.30f + h0 * 0.40f);
}

// FUNCTION: subOccupied
// The per-sub-cube solidity test, shared by everything the sub-march draws.
bool subOccupied(uint kind, uint type, ivec3 voxelPos, ivec3 cell, int sub, vec3 jitter) {
    if (kind == SUB_TRUNK) {
        // A disc test in XZ, extruded the full height of the voxel -- so the stems are continuous
        // columns rather than a stack of separate blobs.
        vec2 p = (vec2(cell.xz) + 0.5f) / float(sub);
        vec2 a, b;
        int count;
        trunkStems(voxelPos, a, b, count);

        float r = max(tuning.treeTrunkRadius, 0.02f);
        if (dot(p - a, p - a) <= r * r) return true;
        if (count > 1 && dot(p - b, p - b) <= r * r) return true;
        return false;
    }

    return hash(vec3(voxelPos * sub + cell) + jitter) < locustDensity(type);
}

// FUNCTION: subMarch
// Walks the sub-lattice of one voxel and reports the first occupied sub-cube.
//
// entryNormal is the face the primary DDA came through, and it is the answer for the very first
// sub-cell -- that cell has taken no step of its own yet, so there is nothing else to derive a
// normal from. Every later cell gets the face its own step crossed.
bool subMarch(ivec3 voxelPos, vec3 rayOrigin, vec3 rayDir, uint kind, uint type, vec3 entryNormal,
              out float tHit, out vec3 subNormal, out vec3 subCell) {
    tHit = 0.0f; subNormal = entryNormal; subCell = vec3(0.0f);

    int sub = clamp(int(tuning.locustSubdivision), 1, 8);
    float cellSize = 1.0f / float(sub);

    vec3 boxMin = vec3(voxelPos);
    vec2 span = intersectAABB(rayOrigin, rayDir, boxMin, boxMin + vec3(1.0f));
    float t = max(span.x, 0.0f);
    if (t > span.y) return false;

    // Nudged inward so a ray entering exactly on the face lands in the first cell rather than on
    // the boundary between it and the one outside.
    vec3 local = (rayOrigin + rayDir * (t + 1e-4f) - boxMin) * float(sub);
    ivec3 c = clamp(ivec3(floor(local)), ivec3(0), ivec3(sub - 1));
    ivec3 stepDir = ivec3(sign(rayDir));

    vec3 tDelta = vec3(
        (rayDir.x == 0.0f) ? 1000000.0f : abs(cellSize / rayDir.x),
        (rayDir.y == 0.0f) ? 1000000.0f : abs(cellSize / rayDir.y),
        (rayDir.z == 0.0f) ? 1000000.0f : abs(cellSize / rayDir.z)
    );
    vec3 fracPos = local - vec3(c);
    vec3 tMax = t + vec3(
        (stepDir.x > 0) ? (1.0f - fracPos.x) * tDelta.x : fracPos.x * tDelta.x,
        (stepDir.y > 0) ? (1.0f - fracPos.y) * tDelta.y : fracPos.y * tDelta.y,
        (stepDir.z > 0) ? (1.0f - fracPos.z) * tDelta.z : fracPos.z * tDelta.z
    );

    // Quantised time, so a swarm re-scatters in discrete jumps rather than boiling continuously. A
    // smooth term here would put exactly the high-frequency shimmer back into the frame that the
    // water normals were widened to take out -- and insects crawling read better as steps anyway.
    // Trunks ignore it: a tree that shimmered would be absurd.
    vec3 jitter = (kind == SUB_LOCUST)
        ? vec3(floor(pc.time * tuning.locustCrawlRate) * 1.7f)
        : vec3(0.0f);

    for (int i = 0; i < 3 * sub; i++) {
        if (c.x < 0 || c.x >= sub || c.y < 0 || c.y >= sub || c.z < 0 || c.z >= sub) return false;

        if (subOccupied(kind, type, voxelPos, c, sub, jitter)) {
            tHit = t;
            subCell = vec3(c);
            return true;
        }

        if (tMax.x < tMax.y) {
            if (tMax.x < tMax.z) {
                c.x += stepDir.x; t = tMax.x; tMax.x += tDelta.x; subNormal = vec3(float(-stepDir.x), 0.0f, 0.0f);
            } else {
                c.z += stepDir.z; t = tMax.z; tMax.z += tDelta.z; subNormal = vec3(0.0f, 0.0f, float(-stepDir.z));
            }
        } else {
            if (tMax.y < tMax.z) {
                c.y += stepDir.y; t = tMax.y; tMax.y += tDelta.y; subNormal = vec3(0.0f, float(-stepDir.y), 0.0f);
            } else {
                c.z += stepDir.z; t = tMax.z; tMax.z += tDelta.z; subNormal = vec3(0.0f, 0.0f, float(-stepDir.z));
            }
        }
    }

    return false;
}

// FUNCTION: renderLocust
// Brown-amber bodies, shaded per sub-cube so the swarm reads as many individuals rather than one
// carved mass. The variation is seeded off the sub-cell rather than the voxel for that reason.
vec3 renderLocust(ivec3 voxelPos, vec3 subCell, vec3 baseLighting) {
    float n = hash(subCell * 1.37f + vec3(voxelPos) * 0.11f);
    vec3 shell = mix(vec3(0.15f, 0.10f, 0.035f), vec3(0.55f, 0.40f, 0.11f), n);
    return shell * baseLighting;
}

// FUNCTION: renderTrunk
// Bark. Varied along the column's height rather than per sub-cube, so a stem reads as one continuous
// piece of wood with grain running up it instead of a stack of separate flecks.
vec3 renderTrunk(ivec3 voxelPos, vec3 subCell, vec3 baseLighting) {
    float grain = hash(vec3(float(voxelPos.x), float(voxelPos.y) * 0.35f + subCell.y * 0.2f, float(voxelPos.z)));
    vec3 bark = mix(vec3(0.20f, 0.13f, 0.07f), vec3(0.38f, 0.25f, 0.13f), grain);
    return bark * baseLighting;
}

// FUNCTION: renderAsh
// Flat, dusty grey with a faint warm cast, and a wide per-voxel spread so a drift reads as loose
// powder rather than as a poured slab. Deliberately duller than stone: the two are both grey, and
// the thing that has to separate them at a glance is that ash does not catch the light.
vec3 renderAsh(ivec3 voxelPos, vec3 baseLighting) {
    float n = hash(vec3(voxelPos));
    vec3 c = mix(vec3(0.20f, 0.19f, 0.18f), vec3(0.47f, 0.45f, 0.42f), n);
    return c * baseLighting;
}

// FUNCTION: renderLeaf
// Canopy. The colour is pushed around by the leaf's distance from its trunk as well as by noise:
// the outer ring of a canopy is lighter and yellower, which gives the mass some depth and quietly
// shows where one tree's crown ends and the next begins.
vec3 renderLeaf(uint rawVoxel, ivec3 voxelPos, vec3 baseLighting) {
    float n = hash(vec3(voxelPos));
    uint dist = (rawVoxel >> 24) & 0xFFu;

    // A leaf that has let go is dead, and looks it: browned off rather than green, so a canopy
    // coming apart is legible as it happens instead of looking like the tree is simply shedding
    // healthy foliage. The marker is already in the byte -- this just reads it.
    if (dist == LEAF_DETACHED) {
        return mix(vec3(0.34f, 0.22f, 0.07f), vec3(0.52f, 0.38f, 0.12f), n) * baseLighting;
    }

    float depth = clamp(float(dist) / max(float(tuning.treeLeafReach), 1.0f), 0.0f, 1.0f);
    vec3 inner = vec3(0.10f, 0.30f, 0.09f);
    vec3 outer = vec3(0.28f, 0.52f, 0.16f);
    vec3 leaf = mix(inner, outer, depth * 0.7f + n * 0.3f);
    return leaf * baseLighting;
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
// CLOUD FIELD -- read only.
//
// Clouds are no longer a drifting population of ellipsoids derived from (index, time). They are the
// shadow of an actual voxel field: falling_sand.comp simulates cloud blocks that rise and pile
// against the ceiling, and publishes, per column, how many are stacked there and how high they
// reach. This stage draws a slab over each column sized from those two numbers.
//
// That retires the duplication hazard for good. The old placement maths existed in both stages and
// had to stay byte-identical or rain fell from a clear sky; there is nothing left to keep in step,
// because the compute stage no longer decides where clouds *look* like they are -- it decides where
// they *are*, and this stage reads it.
// =================================================================================================

// FUNCTION: cloudColumnBase
// Four words per column; slots 2 and 3 are the published count and top Y. Must match the identical
// function in falling_sand.comp.
uint cloudColumnBase(int x, int z) { return uint(x + z * WIDTH) * 4u; }

// FUNCTION: sampleCloudColumn
// One column's published depth and the height of its topmost block, or zeroes off the edge.
void sampleCloudColumn(int x, int z, out float count, out float topY) {
    if (x < 0 || x >= WIDTH || z < 0 || z >= DEPTH) { count = 0.0f; topY = 0.0f; return; }
    uint b = cloudColumnBase(x, z);
    // Sixteenths -- see the easing in falling_sand.comp's column rotation.
    count = float(cloudColumn[b + 2u]) * (1.0f / 16.0f);
    topY  = float(cloudColumn[b + 3u]) * (1.0f / 16.0f);

    // Taper toward the world's edges. Without it the deck ends in a straight vertical wall exactly
    // on the boundary, because a column off the edge reads as empty -- which is correct and looks
    // like the sky was cut with a knife. cloudEdgeFadeDist was the old drifting-cloud field's border
    // fade and was left dead when that went; this is the same idea doing the same job.
    float d = max(tuning.cloudEdgeFadeDist, 0.001f);
    float fx = smoothstep(0.0f, d, float(x)) * smoothstep(0.0f, d, float(WIDTH - 1 - x));
    float fz = smoothstep(0.0f, d, float(z)) * smoothstep(0.0f, d, float(DEPTH - 1 - z));
    count *= fx * fz;
}

// FUNCTION: smoothedCloudColumn
// The same, blurred across the four neighbouring columns a cloud-cell away.
//
// This is what rounds the silhouette. Reading one column gives a slab with a hard vertical wall
// wherever the block count steps, which is why the sky looked like a stack of boxes rather than
// cloud; averaging the neighbours makes the depth fall off gradually at a bank's edge, so the
// hash-filled shell tapers instead of ending. Still blocky -- the fill is per cloud-cell and that is
// the point -- but blocky in a rounded envelope.
//
// The top is a max rather than an average, so a smoothed edge hangs below its neighbours rather than
// sinking the whole bank toward the lowest one.
void smoothedCloudColumn(int x, int z, int spread, out float count, out float topY) {
    float c0, y0, c1, y1, c2, y2, c3, y3, c4, y4;
    sampleCloudColumn(x, z, c0, y0);
    sampleCloudColumn(x - spread, z, c1, y1);
    sampleCloudColumn(x + spread, z, c2, y2);
    sampleCloudColumn(x, z - spread, c3, y3);
    sampleCloudColumn(x, z + spread, c4, y4);
    count = (c0 * 2.0f + c1 + c2 + c3 + c4) / 6.0f;
    topY  = max(max(max(y0, y1), max(y2, y3)), y4);
}

// FUNCTION: marchBlockyCloud
// Walks a coarse voxel grid (the same DDA stepping pattern as the primary raymarch loop) and draws
// the cloud slab standing over each column.
//
// A cell is solid when three things hold: its column has cloud blocks in it, the cell falls inside
// that column's slab, and a per-cell hash beats a density threshold. The hash is what makes the
// silhouette blocky and ragged rather than a flat-topped box, and it is keyed on the cell's own
// integer coordinates -- clouds no longer drift, so a world-anchored pattern is stationary and will
// not boil.
//
// The slab sits ABOVE the pile: its underside rests on the highest cloud block in the column and it
// rises cloudThicknessPerBlock world units for every block beneath it. Cloud blocks are invisible
// and pile against the ceiling, so this puts the visible cloud just over the roof of the world --
// which is where clouds were drawn before any of this, and what makes a deep pile read as a tall
// bank of cloud rather than a thicker lid. Its density -- how much of the slab is filled rather than
// holes -- scales with the count against cloudColumnFullCount, so a thin column is wispy and a deep
// one is solid.
//
// One march for the whole sky, where this used to be one march per cloud inside a loop over up to
// 64 of them. Colour blends from white/light-grey toward storm-grey as `greyness` rises.
bool marchBlockyCloud(vec3 rayOrigin, vec3 rayDir, float tEnter, float tExit, vec3 sunDir,
                      float greyness, out float tHit, out vec3 hitColor, out float hitDensity) {

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

    // Up, not zero. A DDA that starts inside the volume has no entry face, and a zero normal makes
    // the diffuse term collapse to its ambient floor -- so whether the first cell was the hit one
    // changed the shading, and the sky flickered as the camera turned and that changed. Cloud lit
    // from above is the right answer for the one cell that has no face of its own.
    vec3 normal = vec3(0.0f, 1.0f, 0.0f);
    float t = tEnter;

    int spread = max(1, int(tuning.cloudVoxelSize));

    for (int i = 0; i < int(tuning.maxCloudSteps); i++) {
        if (t > tExit) break;

        vec3 cellCenter = (vec3(cellPos) + 0.5f) * tuning.cloudVoxelSize;
        int cx = int(floor(cellCenter.x));
        int cz = int(floor(cellCenter.z));

        if (cx >= 0 && cx < WIDTH && cz >= 0 && cz < DEPTH) {
            float count, baseY;
            smoothedCloudColumn(cx, cz, spread, count, baseY);

            if (count > 0.0f) {
                // Bottom on the pile's top block, growing upward with the pile's depth -- and both
                // faces snapped to the cloud-cell lattice.
                //
                // Snapping is what stops the edges shimmering. The slab's extent still follows the
                // block count, which changes every dispatch, and an unsnapped face lands part way
                // through a cell: that cell's edgeFactor then wobbles either side of its threshold
                // and it blinks. Aligned to the lattice, a cell is wholly inside the slab or wholly
                // outside, so the boundary only changes when the count moves a whole cell's worth
                // -- rarely, and by a whole cell when it does.
                float cell = max(tuning.cloudVoxelSize, 0.5f);
                float thickness = count * max(tuning.cloudThicknessPerBlock, 0.01f);
                baseY = floor(baseY / cell) * cell;
                float capY = baseY + max(floor(thickness / cell), 1.0f) * cell;

                if (cellCenter.y >= baseY && cellCenter.y <= capY) {
                    float density = clamp(count / max(tuning.cloudColumnFullCount, 1.0f),
                                          0.0f, 1.0f);

                    // Distance from the slab's mid-height, 0 in the middle and 1 at either face --
                    // the same role the ellipsoid's localLen played, so the existing edge threshold
                    // tuning keeps its meaning: sparser at the boundary, denser through the core.
                    float mid = (baseY + capY) * 0.5f;
                    float edgeFactor = clamp(abs(cellCenter.y - mid) / max(thickness * 0.5f, 0.001f),
                                             0.0f, 1.0f);
                    // Density deliberately does NOT enter here. It used to -- the threshold was
                    // pushed toward 1 for a thin column -- and that was wrong twice over.
                    //
                    // It made cloud sparse: a column a tenth of the way to full put the threshold at
                    // 0.94, against a hash that is uniform on 0..1, so about one cell in sixteen
                    // survived and the sky was a scatter of isolated cubes rather than cloud.
                    //
                    // And it made cloud unstable, which is the worse half. The count changes every
                    // dispatch as blocks rise and rainclouds fall, so the threshold moved every
                    // frame -- and up at 0.94 a small move flips a large share of the cells at once,
                    // because that is where the tail of a uniform distribution is steepest. The
                    // whole silhouette rearranged between consecutive frames.
                    //
                    // Shape now comes from geometry alone, which is stable frame to frame, and
                    // density drives opacity instead, where a change is a smooth fade rather than a
                    // rearrangement.
                    float threshold = mix(tuning.cloudEdgeThresholdMin,
                                          tuning.cloudEdgeThresholdMax, edgeFactor);

                    float fillHash = hash(vec3(cellPos));
                    if (fillHash > threshold) {
                        tHit = t;
                        hitDensity = density;
                        float shadeHash = hash(vec3(cellPos) * 3.71f + vec3(91.0f, 5.0f, 7.0f));
                        // Near white with only a hint of shading between cells. The old range bottomed
                        // out at 0.76, which read as grey even with no storm anywhere near.
                        vec3 baseColor = mix(vec3(0.90f, 0.91f, 0.94f), vec3(1.0f), shadeHash);
                        vec3 stormColor = vec3(0.32f, 0.33f, 0.36f);
                        baseColor = mix(baseColor, stormColor, greyness);

                        float diffuse = 0.6f + 0.4f * max(dot(normal, sunDir), 0.0f);
                        hitColor = baseColor * diffuse;
                        return true;
                    }
                }
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

    // Without this the +/-1 square is stretched onto whatever shape the window is, so a wide window
    // squashes the world horizontally rather than revealing more of it. Both factors are 1.0 at the
    // 4:3 the camera was framed for, which is why the desktop image is unchanged.
    screenSpace.x *= pc.aspectScaleX;
    screenSpace.y *= pc.aspectScaleY;

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
    // marchCeiling tracks MATTER, and cloud blocks are not matter -- they live in a parallel field
    // and never raise maxOccupiedY. With the debug view on, the ceiling would therefore clip the
    // very blocks it is meant to show, and because the mark decays by one per dispatch and is
    // re-asserted by whatever is highest, they would blink in and out as it drifted. The debug view
    // pays for the whole column instead; normal rendering keeps the optimisation untouched.
    int ceilingY = (pc.showCloudBlocks != 0) ? HEIGHT : marchCeiling();
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

    // Filled in only when the ray stops inside a voxel's sub-lattice; see subMarch. Shared by the
    // two materials that do not fill their voxel -- locust swarms and tree trunks.
    float subT = 0.0f;
    vec3 subNormal = vec3(0.0f, 1.0f, 0.0f);
    vec3 subCell = vec3(0.0f);

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

        // Debug view. Tested before the ordinary hit so a cloud block sharing a cell with matter is
        // hidden by it rather than replacing it -- the two fields genuinely coexist, and drawing the
        // cloud over the stone would misrepresent that.
        if (pc.showCloudBlocks != 0 && hitType == 0u) {
            uint c = cloudCells[uint(voxelPos.x + voxelPos.y * WIDTH + voxelPos.z * WIDTH * HEIGHT)];
            if ((c & 3u) != 0u) {
                hitType = CLOUD_DEBUG_TYPE;
                hitRawVoxel = c;
                hit = true;
                break;
            }
        }

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
            } else if (isLocustType(hitType) || hitType == TREE_TRUNK) {
                // Neither of these fills its voxel. A swarm is bodies and gaps; a trunk is a stem or
                // two with air around it. The ray drops into the voxel's own sub-lattice, and if it
                // threads all the way through without meeting anything then this was never a hit and
                // it carries on to whatever is behind -- the same "keep traveling" the steam dither
                // above does, just resolved geometrically rather than by a coin flip.
                uint kind = (hitType == TREE_TRUNK) ? SUB_TRUNK : SUB_LOCUST;
                if (subMarch(voxelPos, rayOrigin, rayDir, kind, hitType, normal,
                             subT, subNormal, subCell)) {
                    hit = true;
                    hitRawVoxel = rawVoxel;
                    break;
                }
                hitType = 0u;
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
        } else if (isLocustType(hitType) || hitType == TREE_TRUNK) {
            // The sub-cube's own face. Smoothing across the voxel's neighbours would be actively
            // wrong here: the surface the ray met is a small cube inside this voxel, and it has
            // nothing to do with which voxels happen to sit next to this one.
            normal = subNormal;
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
        
        if (hitType == CLOUD_DEBUG_TYPE) {
            // Storm blocks read warm, calm blocks cool, so a storm sweeping the field is visible as
            // it happens rather than only in the rain that follows.
            vec3 calm = vec3(0.35f, 0.65f, 1.00f);
            vec3 rain = vec3(1.00f, 0.55f, 0.25f);
            finalVoxelColor = mix(calm, rain, ((hitRawVoxel & 3u) == 2u) ? 1.0f : 0.0f) * baseLighting;
        }

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
            case 13u:
            case 14u:
            case 15u:
            case 16u:
            case 17u:
                finalVoxelColor = renderLocust(voxelPos, subCell, baseLighting);
                break;
            case 18u:
                finalVoxelColor = renderTrunk(voxelPos, subCell, baseLighting);
                break;
            case 19u:
                finalVoxelColor = renderLeaf(hitRawVoxel, voxelPos, baseLighting);
                break;
            case 20u:
                finalVoxelColor = renderAsh(voxelPos, baseLighting);
                break;
            // No case for type 7: the march above never reports a black hole voxel as a hit, because
            // the body is drawn as a ball further down rather than as the voxel it is anchored to.
            default:
                break;
        }

        finalVoxelColor = accretionGlow(finalVoxelColor, voxelPos);

        // rayDir is normalised, so the sub-march's ray parameter is already a distance -- and it is
        // the exact one, where the voxel-centre estimate every other material uses would put a
        // swarm's bodies up to half a voxel out against the clouds and the cursor.
        float distanceTraveled = (isLocustType(hitType) || hitType == TREE_TRUNK)
            ? subT
            : length(vec3(voxelPos) + vec3(0.5f) - rayOrigin);
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
        // Charge drives COLOUR only. It used to drive opacity as well, and since it only rises once
        // a storm is committed, the sky was invisible until it rained -- cloud blocks could be piled
        // against the roof with nothing drawn over them. Opacity now comes from how much cloud is
        // actually in the column, so a bank appears as soon as it exists.
        float charge = clamp(uintBitsToFloat(cloudChargeBits), 0.0f, 1.0f);

        // Colour tracks charge as well, so a lightly-charged sky is pale and a heavy one is grey
        // before the storm even breaks; the rain phases then force it the rest of the way.
        float cloudGreyness = charge;
        if (rainPhase == 1u) {
            float crossedTime = uintBitsToFloat(rainPhaseTimeBits);
            cloudGreyness = max(charge, clamp((pc.time - crossedTime) / tuning.rainDarkenDelay, 0.0f, 1.0f));
        } else if (rainPhase == 2u) {
            cloudGreyness = 1.0f;
        }

        if (tuning.cloudMaxAlpha > 0.002f) {
            // One march, not a loop over a cloud population. The interval is the cube's XZ
            // footprint with Y left open, because the cloud blocks are inside the world but the
            // cloud drawn from them stands above it -- clipping to the cube would cut off every
            // slab at the roof.
            // Clipped to the band the cloud field actually occupies, which the compute stage
            // publishes each dispatch. This is what makes a fixed step budget sufficient.
            //
            // Bounding the box to the world was not enough: a ray entering low still had to cross
            // the whole cube before reaching cloud that sits against the roof, so at some angles it
            // ran out of steps and the sky flickered -- worse the further away the camera was,
            // because distance is what makes a ray enter low and travel far. Starting at the band
            // makes the march a few cells regardless of where the camera is.
            //
            // Published min above max is the shader's way of saying there is no cloud at all, in
            // which case there is nothing to march.
            // Backed off by one cloud cell. The band's floor is the lowest cloud block anywhere, so
            // it moves as blocks come and go -- and starting the march exactly on it risks beginning
            // inside the first fillable cell rather than before it, which would change the first hit
            // as the floor drifted. Starting a cell early is always safe; starting late is not.
            float slabMax = max(tuning.cloudColumnFullCount, 1.0f)
                          * max(tuning.cloudThicknessPerBlock, 0.01f);
            float bandHi = float(cloudMaxY) + slabMax;

            // Floored, not just taken from the lowest block in the world. cloudMinY is a true
            // minimum, so ONE stray block far below the deck -- a steam voxel that condensed in
            // mid-air and has not finished rising -- stretched the band across the whole world. A
            // shallow ray then crossed a tall band for its entire width, which is many cells, and
            // ran out of budget: cloud went missing at a distance, because distance is what makes a
            // ray shallow. Capping the depth bounds that traversal.
            //
            // The cost is that cloud more than slabMax below the top of the field is not drawn. That
            // is the transient risers, which is the better answer anyway -- they were showing up as
            // isolated grey cubes down at water level.
            float bandLo = max(float(cloudMinY), float(cloudMaxY) - slabMax)
                         - max(tuning.cloudVoxelSize, 1.0f);
            vec2 cloudClip = (cloudMinY > cloudMaxY)
                ? vec2(1.0f, -1.0f)   // empty interval: the tests below reject it
                : intersectAABB(rayOrigin, rayDir,
                                vec3(0.0f, bandLo, 0.0f),
                                vec3(worldExtent().x, bandHi, worldExtent().z));
            vec3 cloudSunDir = normalize(vec3(0.8f, 1.0f, 0.5f));

            float bestT = 1000000.0f;
            vec3 bestColor = vec3(0.0f);
            float bestAlpha = 0.0f;
            bool foundCloud = false;

            float nearT = max(cloudClip.x, 0.0f);
            float farT  = min(cloudClip.y, finalDist);
            if (nearT < farT) {
                float cloudTHit;
                vec3 cloudColor;
                float cloudDensity;
                if (marchBlockyCloud(rayOrigin, rayDir, nearT, farT, cloudSunDir, cloudGreyness,
                                     cloudTHit, cloudColor, cloudDensity)) {
                    if (cloudTHit > 0.0f) {
                        bestT = cloudTHit;
                        bestColor = cloudColor;
                        // Thin cloud is see-through as well as sparse: a single stray block must not
                        // draw at the same opacity as a full bank.
                        bestAlpha = clamp(mix(tuning.cloudMinAlpha, tuning.cloudMaxAlpha, cloudDensity),
                                          0.0f, 0.95f);
                        foundCloud = true;
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
