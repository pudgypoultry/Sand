#version 450

layout(location = 0) in vec2 inUV;
layout(location = 0) out vec4 outColor;

layout(std430, binding = 0) readonly buffer VoxelGrid {
    uint grid[];
};

// Must stay byte-identical to the SimStats block in falling_sand.comp, and BH_INDEX_MASK must match
// the slot encoding used there.
const int BLACK_HOLE_MAX = 8;
const uint BH_INDEX_MASK = 0x7FFFFFFFu;

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
    uint blackHoles[BLACK_HOLE_MAX];
    uint blackHoleMass[BLACK_HOLE_MAX];
    uint blackHoleStarve[BLACK_HOLE_MAX];
};

layout(std140, binding = 2) uniform TuningParams {
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

const int WIDTH = 128;
const int HEIGHT = 128;
const int DEPTH = 128;

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
    if (p.x < thickness || p.x > 128.0f - thickness) boundCount++;
    if (p.y < thickness || p.y > 128.0f - thickness) boundCount++;
    if (p.z < thickness || p.z > 128.0f - thickness) boundCount++;
    return boundCount >= 2;
}

// FUNCTION: calculateShadow
float calculateShadow(ivec3 hitVoxelPos, vec3 hitNormal, vec3 lightDir) {
    ivec3 voxelPos = hitVoxelPos + ivec3(round(hitNormal));
    ivec3 stepDir = ivec3(sign(lightDir));
    
    vec3 tDelta = vec3(
        (lightDir.x == 0.0f) ? 100000000.0f : abs(1.0f / lightDir.x),
        (lightDir.y == 0.0f) ? 100000000.0f : abs(1.0f / lightDir.y),
        (lightDir.z == 0.0f) ? 100000000.0f : abs(1.0f / lightDir.z)
    );
    
    vec3 tMax = 0.5f * tDelta;
    
    for (int i = 0; i < 256; i++) {
        if (voxelPos.x < 0 || voxelPos.x >= WIDTH || 
            voxelPos.y < 0 || voxelPos.y >= HEIGHT || 
            voxelPos.z < 0 || voxelPos.z >= DEPTH) {
            return 1.0f; 
        }
        
        if ((getVoxel(voxelPos) & 0xFFu) != 0u) {
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
    return 1.0f;
}

// FUNCTION: getSmoothNormal
vec3 getSmoothNormal(ivec3 p, uint matchType) {
    vec3 n = vec3(0.0f);
    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++) {
            for (int z = -1; z <= 1; z++) {
                if (x == 0 && y == 0 && z == 0) continue;
                
                uint neighborType = getVoxel(p + ivec3(x, y, z)) & 0xFFu;
                float isSolid = (neighborType != 0u) ? 1.0f : 0.0f;
                vec3 offset = vec3(float(x), float(y), float(z));
                
                n -= (offset / length(offset)) * isSolid;
            }
        }
    }
    
    if (length(n) < 0.1f) return vec3(0.0f, 1.0f, 0.0f);
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
    float closest = radius;

    for (int i = 0; i < BLACK_HOLE_MAX; i++) {
        uint code = blackHoles[i];
        if (code == 0u) continue;
        closest = min(closest, length(vec3(bhDecode(code) - voxelPos)));
    }

    if (closest >= radius) return color;

    // Ramps hard rather than linearly so only the inner disk actually glows -- a linear falloff
    // washed the entire influence sphere in orange and lost the shape of the spiral.
    float heat = pow(1.0f - closest / radius, 3.0f) * tuning.blackHoleGlow;
    vec3 hot = mix(vec3(1.0f, 0.45f, 0.1f), vec3(1.0f, 0.95f, 0.85f), clamp(heat, 0.0f, 1.0f));
    return mix(color, hot, clamp(heat, 0.0f, 1.0f));
}

// =================================================================================================
// CLOUD FIELD -- shared placement math. THIS BLOCK IS DUPLICATED VERBATIM IN falling_sand.comp.
//
// Cloud layout is a pure function of (index, time) and is stored nowhere. Both stages receive the
// same pc.time in a single vkCmdPushConstants call, so the compute stage (deciding which columns
// sit under a cloud and may rain) and the fragment stage (drawing them) derive byte-identical
// positions with no synchronisation and no per-slot buffer. If you edit one copy you MUST edit
// the other, or rain will fall out of a clear sky.
//
// The population is fixed: clouds scroll along +X and wrap, so one drifts out of the far border
// exactly as another drifts in at the near one. Nothing is ever "revealed" or "retired".
// =================================================================================================
const int CLOUD_MAX = 64;

// FUNCTION: cloudRadii
vec3 cloudRadii(int i) {
    float h4 = hash(vec3(float(i), 211.0f, 5.0f));
    float h5 = hash(vec3(float(i), 71.0f, 61.0f));
    float h6 = hash(vec3(float(i), 19.0f, 173.0f));
    float rxz = 10.0f + h4 * 18.0f;
    return vec3(rxz, 4.0f + h5 * 6.0f, rxz * (0.7f + h6 * 0.6f));
}

// FUNCTION: cloudCenterXZ
vec2 cloudCenterXZ(int i, float t) {
    float h1 = hash(vec3(float(i), 11.0f, 3.0f));
    float h2 = hash(vec3(float(i), 47.0f, 91.0f));
    float phase = hash(vec3(float(i), 91.0f, 250.0f)) * 6.28318f;

    float x = mod(h1 * 128.0f + t * tuning.cloudDriftSpeed, 128.0f);
    float z = mod(h2 * 128.0f + sin(t * 0.12f + phase) * 3.0f, 128.0f);
    return vec2(x, z);
}

// FUNCTION: cloudEdgeFade
// 1 over the middle of the cube, falling to 0 at each border. The fade has to happen INSIDE the
// footprint because clouds are already hard-clipped to the cube's XZ column -- fading outside it
// would be invisible and clouds would still pop at the boundary. This is what makes a cloud
// dissolve as it reaches the border and re-emerge on the opposite side.
float cloudEdgeFade(vec2 c) {
    float d = max(tuning.cloudEdgeFadeDist, 0.001f);
    float fx = smoothstep(0.0f, d, c.x) * smoothstep(0.0f, d, 128.0f - c.x);
    float fz = smoothstep(0.0f, d, c.y) * smoothstep(0.0f, d, 128.0f - c.y);
    return fx * fz;
}

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
    vec3 cubeCenter = vec3(64.0f, 64.0f, 64.0f);
    float viewDistance = max(1.0f, dot(cubeCenter - baseOrigin, forward));
    float orthoHalfSize = viewDistance / pc.fovDistance;

    vec3 localDir = mix(vec3(0.0f, 0.0f, 1.0f), vec3(screenSpace.x, screenSpace.y, pc.fovDistance), t);
    vec3 rayDir = normalize(right * localDir.x + up * localDir.y + forward * localDir.z);

    vec3 originOffset = (right * screenSpace.x + up * screenSpace.y) * orthoHalfSize * (1.0f - t);
    vec3 rayOrigin = baseOrigin + originOffset;
    
    vec4 finalColor = vec4(0.05f, 0.05f, 0.1f, 1.0f);
    float finalDist = 1000000.0f;
    
    vec2 aabbHit = intersectAABB(rayOrigin, rayDir, vec3(0.0f), vec3(128.0f));
    bool hitFrontBox = false;
    bool hitBackBox = false;

    if (aabbHit.x < aabbHit.y && aabbHit.y > 0.0f) {
        if (aabbHit.x > 0.0f && isEdge(rayOrigin + rayDir * aabbHit.x)) hitFrontBox = true;
        if (isEdge(rayOrigin + rayDir * aabbHit.y)) hitBackBox = true;
    }

    vec3 currentPos = rayOrigin + rayDir * max(0.0f, aabbHit.x); 
    if (aabbHit.x > 0.0f) currentPos += rayDir * 0.001f; 
    
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
    
    for (int i = 0; i < 400; i++) {
        if (voxelPos.x < 0 || voxelPos.x >= WIDTH || 
            voxelPos.y < 0 || voxelPos.y >= HEIGHT || 
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
        normal = getSmoothNormal(voxelPos, hitType);
        
        vec3 sunDir = normalize(vec3(0.8f, 1.0f, 0.5f)); 
        vec3 sunColor = vec3(1.0f, 0.95f, 0.85f); 
        vec3 ambientColor = vec3(0.15f, 0.2f, 0.3f); 
        
        float diffuse = max(dot(normal, sunDir), 0.0f);
        float shadow = calculateShadow(voxelPos, ddaNormal, sunDir);
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
            // No case for type 7: the march above never reports a black hole voxel as a hit, because
            // the body is drawn as a ball further down rather than as the voxel it is anchored to.
            default:
                break;
        }

        finalVoxelColor = accretionGlow(finalVoxelColor, voxelPos);

        float distanceTraveled = length(vec3(voxelPos) + vec3(0.5f) - rayOrigin);
        float MAX_VISIBILITY = max(300.0f, aabbHit.y * 1.5f);
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
        for (int i = 0; i < BLACK_HOLE_MAX; i++) {
            uint code = blackHoles[i];
            if (code == 0u) continue;

            float bodyRadius = bhBodyRadius(bhLevel(blackHoleMass[i]));
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
                float MAX_VISIBILITY = max(300.0f, aabbHit.y * 1.5f);
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
            vec2 footprintClip = intersectAABB(rayOrigin, rayDir, vec3(0.0f, -1000000.0f, 0.0f), vec3(128.0f, 1000000.0f, 128.0f));
            vec3 cloudSunDir = normalize(vec3(0.8f, 1.0f, 0.5f));

            float bestT = 1000000.0f;
            vec3 bestColor = vec3(0.0f);
            float bestAlpha = 0.0f;
            bool foundCloud = false;

            int cloudN = int(min(tuning.cloudCount, uint(CLOUD_MAX)));
            for (int i = 0; i < cloudN; i++) {
                vec2 centerXZ = cloudCenterXZ(i, pc.time);
                float edgeFade = cloudEdgeFade(centerXZ);
                if (edgeFade <= 0.01f) continue;

                float h3 = hash(vec3(float(i), 133.0f, 7.0f));
                vec3 radii = cloudRadii(i);
                vec3 center = vec3(
                    centerXZ.x,
                    128.0f + radii.y + h3 * 4.0f,   // bottom edge sits right at the cube's top, 0-4 units of gap
                    centerXZ.y
                );

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

        vec3 cursorColor;
        if (pc.spawnType == 0) {
            cursorColor = vec3(0.1f, 0.1f, 0.1f);
        } else if (pc.spawnType == 2) {
            cursorColor = vec3(0.2f, 0.6f, 1.0f);
        } else if (pc.spawnType == 3) {
            cursorColor = vec3(0.6f, 0.6f, 0.6f);
        } else if (pc.spawnType == 4) {
            cursorColor = vec3(0.5f, 0.35f, 0.15f);
        } else if (pc.spawnType == 5) {
            cursorColor = vec3(1.0f, 0.5f, 0.0f);
        } else if (pc.spawnType == 6) {
            cursorColor = vec3(0.9f, 0.9f, 0.9f);
        } else if (pc.spawnType == 7) {
            cursorColor = vec3(0.8f, 0.4f, 1.0f);
        } else {
            cursorColor = vec3(1.0f, 0.9f, 0.2f);
        }

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
