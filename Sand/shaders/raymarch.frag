#version 450

layout(location = 0) in vec2 inUV;
layout(location = 0) out vec4 outColor;

layout(std430, binding = 0) readonly buffer VoxelGrid {
    uint grid[];
};

layout(std430, binding = 1) buffer CloudStats {
    uint steamTopCount;
    uint revealedCount;
    uint lastRevealTimeBits;
    uint waterVoxelCount;
    uint cloudWaterCount;
    uint totalWaterEvaporated;
    uint rainPhase;
    uint rainPhaseTimeBits;
    uint rainFinishedTimeBits;
    uint cloudRevealTime[64];
    uint cloudFootprintX[64];
    uint cloudFootprintZ[64];
    uint cloudFootprintRadius[64];
};

layout(std140, binding = 2) uniform TuningParams {
    float rainChanceStart;
    float rainChanceMax;
    float rainRampDuration;
    float cloudRevealCooldown;
    uint cloudRevealTargetSlots;
    uint rainStartLayers;
    uint rainMinWaterInCubeLayers;
    float rainDarkenDelay;
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

    for (int i = 0; i < int(tuning.maxCloudSteps); i++) {
        if (t > tExit) break;

        vec3 cellCenter = (vec3(cellPos) + 0.5f) * tuning.cloudVoxelSize;
        vec3 local = (cellCenter - center) / radii;
        float localLen = length(local);

        if (localLen <= 1.0f) {
            float fillHash = hash(vec3(cellPos) + vec3(cloudSeed * 13.0f, cloudSeed * 7.0f, cloudSeed * 29.0f));
            float edgeFactor = clamp(localLen, 0.0f, 1.0f);
            float threshold = mix(tuning.cloudEdgeThresholdMin, tuning.cloudEdgeThresholdMax, edgeFactor); // sparser near the edge, denser near the center

            if (fillHash > threshold) {
                tHit = t;
                float shadeHash = hash(vec3(cellPos) * 3.71f + vec3(91.0f, cloudSeed, 7.0f));
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
            default:
                break;
        }
        
        float distanceTraveled = length(vec3(voxelPos) + vec3(0.5f) - rayOrigin);
        float MAX_VISIBILITY = max(300.0f, aabbHit.y * 1.5f);
        finalVoxelColor *= mix(1.0f, 0.0f, clamp(distanceTraveled / MAX_VISIBILITY, 0.0f, 1.0f)); 
        
        finalDist = distanceTraveled;
        finalColor = vec4(finalVoxelColor, 1.0f);
        
    } else if (hitBackBox) {
        finalDist = aabbHit.y;
        finalColor = vec4(1.0f, 0.2f, 0.2f, 1.0f);
    }

    // --- CLOUD LAYER: reveals one at a time with a fade-in, clipped to the cube's footprint,
    // rendered as blocky/voxelized cubes bounded within a smooth ellipsoid envelope, greying
    // toward storm-grey as the rain reservoir darkens and eventually starts to drain ---
    {
        const int CLOUD_MAX_SLOTS = 64;

        float densityFactor = 1.0f - exp(-float(steamTopCount) / tuning.cloudDensitySaturation);

        float cloudGreyness = 0.0f;
	const float CLOUD_DISAPPEAR_DURATION = 5.0f;

	float cloudDisappearFactor = 1.0f;
    float cloudDisappearFactor = 1.0f;
    if (rainPhase == 0u && rainFinishedTimeBits != 0xFFFFFFFFu) {
        float finishedTime = uintBitsToFloat(rainFinishedTimeBits);
        float sinceFinished = pc.time - finishedTime;
        cloudDisappearFactor = 1.0f - clamp(sinceFinished / tuning.cloudDisappearDuration, 0.0f, 1.0f);
    }
    if (rainPhase == 1u) {
        float crossedTime = uintBitsToFloat(rainPhaseTimeBits);
        cloudGreyness = clamp((pc.time - crossedTime) / tuning.rainDarkenDelay, 0.0f, 1.0f);
    } else if (rainPhase == 2u) {
        cloudGreyness = 1.0f;
    }

        vec2 footprintClip = intersectAABB(rayOrigin, rayDir, vec3(0.0f, -1000000.0f, 0.0f), vec3(128.0f, 1000000.0f, 128.0f));
        vec3 cloudSunDir = normalize(vec3(0.8f, 1.0f, 0.5f));

        float bestT = 1000000.0f;
        vec3 bestColor = vec3(0.0f);
        float bestAlpha = 0.0f;
        bool foundCloud = false;

        for (int i = 0; i < int(revealedCount); i++) {
            float revealTime = uintBitsToFloat(cloudRevealTime[i]);
            float fadeIn = smoothstep(0.0f, 1.0f, clamp((pc.time - revealTime) / tuning.cloudFadeDuration, 0.0f, 1.0f));
            if (fadeIn <= 0.0f) continue;

            float h1 = hash(vec3(float(i), 11.0f, 3.0f));
            float h2 = hash(vec3(float(i), 47.0f, 91.0f));
            float h3 = hash(vec3(float(i), 133.0f, 7.0f));
            float h4 = hash(vec3(float(i), 211.0f, 5.0f));
            float h5 = hash(vec3(float(i), 71.0f, 61.0f));
            float h6 = hash(vec3(float(i), 19.0f, 173.0f));
            float phase = hash(vec3(float(i), 91.0f, 250.0f)) * 6.28318f;

	    float rxz = 10.0f + h4 * 18.0f;
	    vec3 radii = vec3(rxz, 4.0f + h5 * 6.0f, rxz * (0.7f + h6 * 0.6f));

	    float angle = h1 * 6.28318f;
	    float orbitRadius = h2 * 55.0f;
	    vec3 center = vec3(
	        64.0f + cos(angle) * orbitRadius + sin(pc.time * 0.15f + phase) * 3.0f,
	        128.0f + radii.y + h3 * 4.0f,   // bottom edge sits right at the cube's top, 0-4 units of gap
	        64.0f + sin(angle) * orbitRadius + cos(pc.time * 0.12f + phase) * 3.0f
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
                            bestAlpha = clamp(0.35f + densityFactor * 0.55f, 0.0f, 0.95f) * fadeIn * cloudDisappearFactor;
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
    
    if (pc.spawnX >= 0 && pc.spawnX < WIDTH && pc.spawnY >= 0 && pc.spawnY < HEIGHT && pc.spawnZ >= 0 && pc.spawnZ < DEPTH) {
        
        int halfDistMin = pc.spawnSize / 2;
        int halfDistMax = (pc.spawnSize - 1) / 2;
        
        vec3 boxMin = vec3(float(pc.spawnX - halfDistMin), float(pc.spawnY - halfDistMin), float(pc.spawnZ - halfDistMin));
        vec3 boxMax = vec3(float(pc.spawnX + halfDistMax + 1), float(pc.spawnY + halfDistMax + 1), float(pc.spawnZ + halfDistMax + 1));
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
            } else {
                cursorColor = vec3(1.0f, 0.9f, 0.2f);
            }
            
            if (onFrontEdge && distFront < finalDist) {
                finalColor.rgb = mix(finalColor.rgb, cursorColor, 0.9f);
            } else if (onBackEdge && distBack < finalDist) {
                finalColor.rgb = mix(finalColor.rgb, cursorColor, 0.2f);
            } else if (distFront < finalDist) {
                finalColor.rgb = mix(finalColor.rgb, cursorColor, 0.15f);
            }
        }
    }
    
    if (hitFrontBox) {
        finalColor = vec4(1.0f, 0.2f, 0.2f, 1.0f);
    }
    
    outColor = finalColor;
}
