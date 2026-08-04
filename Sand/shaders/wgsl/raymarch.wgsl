// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: c1c38d0dd0db0a8fcb893d023615d7c7fa1496b175890d5c9f415947927c59f6

struct TuningParams {
    gridWidth: u32,
    gridHeight: u32,
    gridDepth: u32,
    marchMaxSteps: u32,
    shadowMaxSteps: u32,
    rainStartLayers: u32,
    rainDropsPerTick: u32,
    rainOvershoot: f32,
    rainDarkenDelay: f32,
    cloudCount: u32,
    cloudDriftSpeed: f32,
    cloudEdgeFadeDist: f32,
    cloudChargeSaturation: f32,
    cloudChargeEaseRate: f32,
    cloudMinAlpha: f32,
    cloudMaxAlpha: f32,
    cloudVoxelSize: f32,
    cloudEdgeThresholdMin: f32,
    cloudEdgeThresholdMax: f32,
    maxCloudSteps: u32,
    sandMoistureCapacity: u32,
    dirtMoistureCapacity: u32,
    sandWaterAbsorbUnit: u32,
    sandClumpThreshold: u32,
    dirtClumpThreshold: u32,
    wakeSleepThreshold: u32,
    emptyBelowWakeCount: u32,
    waterSpreadRadius: u32,
    fireLifetime: u32,
    fireDryRate: u32,
    grassGrowChance: f32,
    grassSubmergedDecayChance: f32,
    fireBurnGrassChance: f32,
    fireSpreadChance: f32,
    steamScatterChance: f32,
    blackHoleHorizon: u32,
    blackHoleRadius: u32,
    blackHoleOrbitSpeed: f32,
    blackHoleInfall: f32,
    blackHolePlaneGrip: f32,
    blackHoleGlow: f32,
    blackHoleOrbitPlanes: u32,
    blackHoleGrowthCost: f32,
    blackHoleMaxLevel: u32,
    blackHoleStarveGrace: u32,
    blackHoleDecayRate: u32,
    purgeLevel: u32,
    purgeMass: u32,
    purgeStarveGrace: u32,
    purgeDecayRate: u32,
    purgeOrbitSpeed: f32,
    purgeInfall: f32,
    waterShadowTransmit: f32,
    waterWaveStrength: f32,
    waterWaveScale: f32,
    waterWaveSpeed: f32,
    lavaStageSize: u32,
    lavaViscosity: f32,
    lavaSpreadRadius: u32,
    lavaWaterCool: u32,
    lavaMoistureCool: u32,
    lavaRestCoolChance: f32,
    lavaConsumeChance: f32,
    lavaIgniteChance: f32,
    darkStoneDryChance: f32,
    lavaChurnRate: f32,
    locustTickDispatches: u32,
    locustStageSize: u32,
    locustSpawnSize: u32,
    locustMaxSize: u32,
    locustBudSize: u32,
    locustEatGain: u32,
    locustEatTicksMin: u32,
    locustEatTicksMax: u32,
    locustRunLength: u32,
    locustClimbChance: f32,
    locustDensityMin: f32,
    locustDensityMax: f32,
    locustSubdivision: u32,
    locustCrawlRate: f32,
    treeBloomChance: f32,
    treeMaxHeight: u32,
    treeSoilReserve: u32,
    treeWaterMax: u32,
    treeDrinkChance: f32,
    treeFlowChance: f32,
    treeGrowCost: u32,
    treeLeafCost: u32,
    treeSpreadCost: u32,
    treeSpreadChance: f32,
    treeLeafChance: f32,
    treeLeafReach: u32,
    treeLeafSpreadChance: f32,
    treeLeafTickChance: f32,
    treeLeafFallChance: f32,
    treeTrunkBurnChance: f32,
    treeLeafBurnChance: f32,
    treeTrunkColumns: u32,
    treeTrunkRadius: f32,
}

struct SimStats {
    waterVoxelCount: u32,
    waterHighMark: u32,
    cloudWaterCount: u32,
    rainPhase: u32,
    rainPhaseTimeBits: u32,
    rainTargetLevel: u32,
    rainCandidateCount: u32,
    rainCandidateEstimate: u32,
    cloudChargeBits: u32,
    blackHoleCount: u32,
    maxOccupiedY: u32,
    blackHoles: array<u32, 8>,
    blackHoleMass: array<u32, 8>,
    blackHoleStarve: array<u32, 8>,
    cloudCache: array<f32, 448>,
}

struct VoxelGrid {
    grid: array<u32>,
}

struct Constants {
    time: f32,
    pitch: f32,
    yaw: f32,
    camX: f32,
    camY: f32,
    camZ: f32,
    spawnX: i32,
    spawnY: i32,
    spawnZ: i32,
    spawnActive: i32,
    spawnType: i32,
    spawnSize: i32,
    fovDistance: f32,
    perspectiveBlend: f32,
    spawnShape: i32,
}

@group(0) @binding(2) 
var<uniform> tuning: TuningParams;
@group(0) @binding(1) 
var<storage> unnamed: SimStats;
@group(0) @binding(0) 
var<storage> unnamed_1: VoxelGrid;
@group(0) @binding(3) 
var<uniform> pc: Constants;
var<private> inUV_1: vec2<f32>;
var<private> outColor: vec4<f32>;

fn hash_u0028_vf3_u003b(p: ptr<function, vec3<f32>>) -> f32 {
    let _e258 = (*p);
    return fract((sin(dot(_e258, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b(rayOrigin: ptr<function, vec3<f32>>, rayDir: ptr<function, vec3<f32>>, center: ptr<function, vec3<f32>>, radii: ptr<function, vec3<f32>>, cloudSeed: ptr<function, f32>, tEnter: ptr<function, f32>, tExit: ptr<function, f32>, sunDir: ptr<function, vec3<f32>>, greyness: ptr<function, f32>, tHit: ptr<function, f32>, hitColor: ptr<function, vec3<f32>>) -> bool {
    var startPos: vec3<f32>;
    var cellPos: vec3<i32>;
    var stepDir: vec3<i32>;
    var tDelta: vec3<f32>;
    var local: f32;
    var local_1: f32;
    var local_2: f32;
    var fracPos: vec3<f32>;
    var tMax: vec3<f32>;
    var local_3: f32;
    var local_4: f32;
    var local_5: f32;
    var normal: vec3<f32>;
    var t: f32;
    var cloudOrigin: vec3<i32>;
    var i: i32;
    var cellCenter: vec3<f32>;
    var local_6: vec3<f32>;
    var localLen: f32;
    var localCell: vec3<f32>;
    var fillHash: f32;
    var param: vec3<f32>;
    var edgeFactor: f32;
    var threshold: f32;
    var shadeHash: f32;
    var param_1: vec3<f32>;
    var baseColor: vec3<f32>;
    var stormColor: vec3<f32>;
    var diffuse: f32;

    let _e297 = (*tEnter);
    (*tEnter) = max(_e297, 0f);
    let _e299 = (*tEnter);
    let _e300 = (*tExit);
    if (_e299 >= _e300) {
        return false;
    }
    let _e302 = (*rayOrigin);
    let _e303 = (*rayDir);
    let _e304 = (*tEnter);
    startPos = (_e302 + (_e303 * _e304));
    let _e307 = startPos;
    let _e309 = tuning.cloudVoxelSize;
    cellPos = vec3<i32>(floor((_e307 / vec3(_e309))));
    let _e314 = (*rayDir);
    stepDir = vec3<i32>(sign(_e314));
    let _e318 = (*rayDir)[0u];
    if (_e318 == 0f) {
        local = 100000000f;
    } else {
        let _e321 = tuning.cloudVoxelSize;
        let _e323 = (*rayDir)[0u];
        local = abs((_e321 / _e323));
    }
    let _e326 = local;
    let _e328 = (*rayDir)[1u];
    if (_e328 == 0f) {
        local_1 = 100000000f;
    } else {
        let _e331 = tuning.cloudVoxelSize;
        let _e333 = (*rayDir)[1u];
        local_1 = abs((_e331 / _e333));
    }
    let _e336 = local_1;
    let _e338 = (*rayDir)[2u];
    if (_e338 == 0f) {
        local_2 = 100000000f;
    } else {
        let _e341 = tuning.cloudVoxelSize;
        let _e343 = (*rayDir)[2u];
        local_2 = abs((_e341 / _e343));
    }
    let _e346 = local_2;
    tDelta = vec3<f32>(_e326, _e336, _e346);
    let _e348 = startPos;
    let _e350 = tuning.cloudVoxelSize;
    let _e353 = cellPos;
    fracPos = ((_e348 / vec3(_e350)) - vec3<f32>(_e353));
    let _e356 = (*tEnter);
    let _e358 = stepDir[0u];
    if (_e358 > 0i) {
        let _e361 = fracPos[0u];
        let _e364 = tDelta[0u];
        local_3 = ((1f - _e361) * _e364);
    } else {
        let _e367 = fracPos[0u];
        let _e369 = tDelta[0u];
        local_3 = (_e367 * _e369);
    }
    let _e371 = local_3;
    let _e373 = stepDir[1u];
    if (_e373 > 0i) {
        let _e376 = fracPos[1u];
        let _e379 = tDelta[1u];
        local_4 = ((1f - _e376) * _e379);
    } else {
        let _e382 = fracPos[1u];
        let _e384 = tDelta[1u];
        local_4 = (_e382 * _e384);
    }
    let _e386 = local_4;
    let _e388 = stepDir[2u];
    if (_e388 > 0i) {
        let _e391 = fracPos[2u];
        let _e394 = tDelta[2u];
        local_5 = ((1f - _e391) * _e394);
    } else {
        let _e397 = fracPos[2u];
        let _e399 = tDelta[2u];
        local_5 = (_e397 * _e399);
    }
    let _e401 = local_5;
    tMax = (vec3(_e356) + vec3<f32>(_e371, _e386, _e401));
    normal = vec3<f32>(0f, 0f, 0f);
    let _e405 = (*tEnter);
    t = _e405;
    let _e406 = (*center);
    let _e408 = tuning.cloudVoxelSize;
    cloudOrigin = vec3<i32>(round((_e406 / vec3(_e408))));
    i = 0i;
    loop {
        let _e413 = i;
        let _e415 = tuning.maxCloudSteps;
        if (_e413 < bitcast<i32>(_e415)) {
            let _e418 = t;
            let _e419 = (*tExit);
            if (_e418 > _e419) {
                break;
            }
            let _e421 = cellPos;
            let _e426 = tuning.cloudVoxelSize;
            cellCenter = ((vec3<f32>(_e421) + vec3(0.5f)) * _e426);
            let _e428 = cellCenter;
            let _e429 = (*center);
            let _e431 = (*radii);
            local_6 = ((_e428 - _e429) / _e431);
            let _e433 = local_6;
            localLen = length(_e433);
            let _e435 = localLen;
            if (_e435 <= 1f) {
                let _e437 = cellPos;
                let _e438 = cloudOrigin;
                localCell = vec3<f32>((_e437 - _e438));
                let _e441 = localCell;
                let _e442 = (*cloudSeed);
                let _e444 = (*cloudSeed);
                let _e446 = (*cloudSeed);
                param = (_e441 + vec3<f32>((_e442 * 13f), (_e444 * 7f), (_e446 * 29f)));
                let _e450 = hash_u0028_vf3_u003b((&param));
                fillHash = _e450;
                let _e451 = localLen;
                edgeFactor = clamp(_e451, 0f, 1f);
                let _e454 = tuning.cloudEdgeThresholdMin;
                let _e456 = tuning.cloudEdgeThresholdMax;
                let _e457 = edgeFactor;
                threshold = mix(_e454, _e456, _e457);
                let _e459 = fillHash;
                let _e460 = threshold;
                if (_e459 > _e460) {
                    let _e462 = t;
                    (*tHit) = _e462;
                    let _e463 = localCell;
                    let _e465 = (*cloudSeed);
                    param_1 = ((_e463 * 3.71f) + vec3<f32>(91f, _e465, 7f));
                    let _e468 = hash_u0028_vf3_u003b((&param_1));
                    shadeHash = _e468;
                    let _e469 = shadeHash;
                    baseColor = mix(vec3<f32>(0.76f, 0.76f, 0.78f), vec3<f32>(1f, 1f, 1f), vec3(_e469));
                    stormColor = vec3<f32>(0.32f, 0.33f, 0.36f);
                    let _e472 = baseColor;
                    let _e473 = stormColor;
                    let _e474 = (*greyness);
                    baseColor = mix(_e472, _e473, vec3(_e474));
                    let _e477 = normal;
                    let _e478 = (*sunDir);
                    diffuse = (0.6f + (0.4f * max(dot(_e477, _e478), 0f)));
                    let _e483 = baseColor;
                    let _e484 = diffuse;
                    (*hitColor) = (_e483 * _e484);
                    return true;
                }
            }
            let _e487 = tMax[0u];
            let _e489 = tMax[1u];
            if (_e487 < _e489) {
                let _e492 = tMax[0u];
                let _e494 = tMax[2u];
                if (_e492 < _e494) {
                    let _e497 = stepDir[0u];
                    let _e499 = cellPos[0u];
                    cellPos[0u] = (_e499 + _e497);
                    let _e503 = tMax[0u];
                    t = _e503;
                    let _e505 = tDelta[0u];
                    let _e507 = tMax[0u];
                    tMax[0u] = (_e507 + _e505);
                    let _e511 = stepDir[0u];
                    normal = vec3<f32>(f32(-(_e511)), 0f, 0f);
                } else {
                    let _e516 = stepDir[2u];
                    let _e518 = cellPos[2u];
                    cellPos[2u] = (_e518 + _e516);
                    let _e522 = tMax[2u];
                    t = _e522;
                    let _e524 = tDelta[2u];
                    let _e526 = tMax[2u];
                    tMax[2u] = (_e526 + _e524);
                    let _e530 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e530)));
                }
            } else {
                let _e535 = tMax[1u];
                let _e537 = tMax[2u];
                if (_e535 < _e537) {
                    let _e540 = stepDir[1u];
                    let _e542 = cellPos[1u];
                    cellPos[1u] = (_e542 + _e540);
                    let _e546 = tMax[1u];
                    t = _e546;
                    let _e548 = tDelta[1u];
                    let _e550 = tMax[1u];
                    tMax[1u] = (_e550 + _e548);
                    let _e554 = stepDir[1u];
                    normal = vec3<f32>(0f, f32(-(_e554)), 0f);
                } else {
                    let _e559 = stepDir[2u];
                    let _e561 = cellPos[2u];
                    cellPos[2u] = (_e561 + _e559);
                    let _e565 = tMax[2u];
                    t = _e565;
                    let _e567 = tDelta[2u];
                    let _e569 = tMax[2u];
                    tMax[2u] = (_e569 + _e567);
                    let _e573 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e573)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e577 = i;
            i = (_e577 + 1i);
        }
    }
    return false;
}

fn cloudRadii_u0028_i1_u003b(i_1: ptr<function, i32>) -> vec3<f32> {
    let _e258 = (*i_1);
    let _e263 = unnamed.cloudCache[((_e258 * 7i) + 3i)];
    let _e264 = (*i_1);
    let _e269 = unnamed.cloudCache[((_e264 * 7i) + 4i)];
    let _e270 = (*i_1);
    let _e275 = unnamed.cloudCache[((_e270 * 7i) + 5i)];
    return vec3<f32>(_e263, _e269, _e275);
}

fn cloudCenter_u0028_i1_u003b(i_2: ptr<function, i32>) -> vec3<f32> {
    let _e258 = (*i_2);
    let _e263 = unnamed.cloudCache[((_e258 * 7i) + 0i)];
    let _e264 = (*i_2);
    let _e269 = unnamed.cloudCache[((_e264 * 7i) + 1i)];
    let _e270 = (*i_2);
    let _e275 = unnamed.cloudCache[((_e270 * 7i) + 2i)];
    return vec3<f32>(_e263, _e269, _e275);
}

fn cloudFade_u0028_i1_u003b(i_3: ptr<function, i32>) -> f32 {
    let _e258 = (*i_3);
    let _e263 = unnamed.cloudCache[((_e258 * 7i) + 6i)];
    return _e263;
}

fn renderBlackHole_u0028_vf3_u003b_vf3_u003b(normal_1: ptr<function, vec3<f32>>, rayDir_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var rim: f32;
    var glow: f32;

    let _e261 = (*normal_1);
    let _e262 = (*rayDir_1);
    rim = (1f - abs(dot(_e261, _e262)));
    let _e266 = rim;
    glow = pow(clamp(_e266, 0f, 1f), 4f);
    let _e269 = glow;
    return mix(vec3<f32>(0.01f, 0.01f, 0.02f), vec3<f32>(0.85f, 0.45f, 1f), vec3((_e269 * 0.7f)));
}

fn bhDecode_u0028_u1_u003b(code: ptr<function, u32>) -> vec3<i32> {
    var i_4: u32;

    let _e259 = (*code);
    i_4 = (_e259 & 1073741823u);
    let _e261 = i_4;
    let _e263 = tuning.gridWidth;
    let _e268 = i_4;
    let _e270 = tuning.gridWidth;
    let _e275 = tuning.gridHeight;
    let _e280 = i_4;
    let _e282 = tuning.gridWidth;
    let _e285 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e261 % bitcast<u32>(bitcast<i32>(_e263)))), bitcast<i32>(((_e268 / bitcast<u32>(bitcast<i32>(_e270))) % bitcast<u32>(bitcast<i32>(_e275)))), bitcast<i32>((_e280 / bitcast<u32>((bitcast<i32>(_e282) * bitcast<i32>(_e285))))));
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e258 = (*level);
    return (f32(_e258) + 0.5f);
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_1: u32;
    var l: u32;
    var r: f32;
    var param_2: u32;
    var volume: f32;

    level_1 = 0u;
    l = 1u;
    loop {
        let _e263 = l;
        let _e265 = tuning.blackHoleMaxLevel;
        if (_e263 <= min(_e265, 16u)) {
            let _e268 = l;
            param_2 = _e268;
            let _e269 = bhBodyRadius_u0028_u1_u003b((&param_2));
            r = _e269;
            let _e270 = r;
            let _e272 = r;
            let _e274 = r;
            volume = (((4.18879f * _e270) * _e272) * _e274);
            let _e276 = (*mass);
            let _e279 = tuning.blackHoleGrowthCost;
            let _e280 = volume;
            if (f32(_e276) < (_e279 * _e280)) {
                break;
            }
            let _e283 = l;
            level_1 = _e283;
            continue;
        } else {
            break;
        }
        continuing {
            let _e284 = l;
            l = (_e284 + bitcast<u32>(1i));
        }
    }
    let _e287 = level_1;
    return _e287;
}

fn accretionGlow_u0028_vf3_u003b_vi3_u003b(color: ptr<function, vec3<f32>>, voxelPos: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radius: f32;
    var closestSq: f32;
    var seen: u32;
    var i_5: i32;
    var code_1: u32;
    var d: vec3<f32>;
    var param_3: u32;
    var closest: f32;
    var heat: f32;
    var hot: vec3<f32>;
    var phi_2261_: bool;
    var phi_2290_: bool;

    let _e270 = unnamed.blackHoleCount;
    let _e271 = (_e270 == 0u);
    phi_2261_ = _e271;
    if !(_e271) {
        let _e274 = tuning.blackHoleGlow;
        phi_2261_ = (_e274 <= 0f);
    }
    let _e277 = phi_2261_;
    if _e277 {
        let _e278 = (*color);
        return _e278;
    }
    let _e280 = tuning.blackHoleRadius;
    radius = f32(_e280);
    let _e282 = radius;
    let _e283 = radius;
    closestSq = (_e282 * _e283);
    seen = 0u;
    i_5 = 0i;
    loop {
        let _e285 = i_5;
        let _e286 = (_e285 < 8i);
        phi_2290_ = _e286;
        if _e286 {
            let _e287 = seen;
            let _e289 = unnamed.blackHoleCount;
            phi_2290_ = (_e287 < _e289);
        }
        let _e292 = phi_2290_;
        if _e292 {
            let _e293 = i_5;
            let _e296 = unnamed.blackHoles[_e293];
            code_1 = _e296;
            let _e297 = code_1;
            if (_e297 == 0u) {
                continue;
            }
            let _e299 = seen;
            seen = (_e299 + bitcast<u32>(1i));
            let _e302 = code_1;
            param_3 = _e302;
            let _e303 = bhDecode_u0028_u1_u003b((&param_3));
            let _e304 = (*voxelPos);
            d = vec3<f32>((_e303 - _e304));
            let _e307 = closestSq;
            let _e308 = d;
            let _e309 = d;
            closestSq = min(_e307, dot(_e308, _e309));
            continue;
        } else {
            break;
        }
        continuing {
            let _e312 = i_5;
            i_5 = (_e312 + 1i);
        }
    }
    let _e314 = closestSq;
    let _e315 = radius;
    let _e316 = radius;
    if (_e314 >= (_e315 * _e316)) {
        let _e319 = (*color);
        return _e319;
    }
    let _e320 = closestSq;
    closest = sqrt(_e320);
    let _e322 = closest;
    let _e323 = radius;
    let _e328 = tuning.blackHoleGlow;
    heat = (pow((1f - (_e322 / _e323)), 3f) * _e328);
    let _e330 = heat;
    hot = mix(vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(1f, 0.95f, 0.85f), vec3(clamp(_e330, 0f, 1f)));
    let _e334 = (*color);
    let _e335 = hot;
    let _e336 = heat;
    return mix(_e334, _e335, vec3(clamp(_e336, 0f, 1f)));
}

fn renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b(rawVoxel: ptr<function, u32>, voxelPos_1: ptr<function, vec3<i32>>, baseLighting: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n: f32;
    var param_4: vec3<f32>;
    var dist: u32;
    var depth: f32;
    var inner: vec3<f32>;
    var outer: vec3<f32>;
    var leaf: vec3<f32>;

    let _e267 = (*voxelPos_1);
    param_4 = vec3<f32>(_e267);
    let _e269 = hash_u0028_vf3_u003b((&param_4));
    n = _e269;
    let _e270 = (*rawVoxel);
    dist = ((_e270 >> bitcast<u32>(24i)) & 255u);
    let _e274 = dist;
    if (_e274 == 255u) {
        let _e276 = n;
        let _e279 = (*baseLighting);
        return (mix(vec3<f32>(0.34f, 0.22f, 0.07f), vec3<f32>(0.52f, 0.38f, 0.12f), vec3(_e276)) * _e279);
    }
    let _e281 = dist;
    let _e284 = tuning.treeLeafReach;
    depth = clamp((f32(_e281) / max(f32(_e284), 1f)), 0f, 1f);
    inner = vec3<f32>(0.1f, 0.3f, 0.09f);
    outer = vec3<f32>(0.28f, 0.52f, 0.16f);
    let _e289 = inner;
    let _e290 = outer;
    let _e291 = depth;
    let _e293 = n;
    leaf = mix(_e289, _e290, vec3(((_e291 * 0.7f) + (_e293 * 0.3f))));
    let _e298 = leaf;
    let _e299 = (*baseLighting);
    return (_e298 * _e299);
}

fn renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_2: ptr<function, vec3<i32>>, subCell: ptr<function, vec3<f32>>, baseLighting_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var grain: f32;
    var param_5: vec3<f32>;
    var bark: vec3<f32>;

    let _e264 = (*voxelPos_2)[0u];
    let _e267 = (*voxelPos_2)[1u];
    let _e271 = (*subCell)[1u];
    let _e275 = (*voxelPos_2)[2u];
    param_5 = vec3<f32>(f32(_e264), ((f32(_e267) * 0.35f) + (_e271 * 0.2f)), f32(_e275));
    let _e278 = hash_u0028_vf3_u003b((&param_5));
    grain = _e278;
    let _e279 = grain;
    bark = mix(vec3<f32>(0.2f, 0.13f, 0.07f), vec3<f32>(0.38f, 0.25f, 0.13f), vec3(_e279));
    let _e282 = bark;
    let _e283 = (*baseLighting_1);
    return (_e282 * _e283);
}

fn renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_3: ptr<function, vec3<i32>>, subCell_1: ptr<function, vec3<f32>>, baseLighting_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_1: f32;
    var param_6: vec3<f32>;
    var shell: vec3<f32>;

    let _e263 = (*subCell_1);
    let _e265 = (*voxelPos_3);
    param_6 = ((_e263 * 1.37f) + (vec3<f32>(_e265) * 0.11f));
    let _e269 = hash_u0028_vf3_u003b((&param_6));
    n_1 = _e269;
    let _e270 = n_1;
    shell = mix(vec3<f32>(0.15f, 0.1f, 0.035f), vec3<f32>(0.55f, 0.4f, 0.11f), vec3(_e270));
    let _e273 = shell;
    let _e274 = (*baseLighting_2);
    return (_e273 * _e274);
}

fn renderDarkStone_u0028_vi3_u003b_vf3_u003b(voxelPos_4: ptr<function, vec3<i32>>, baseLighting_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise: f32;
    var param_7: vec3<f32>;
    var val: f32;

    let _e262 = (*voxelPos_4);
    param_7 = vec3<f32>(_e262);
    let _e264 = hash_u0028_vf3_u003b((&param_7));
    noise = _e264;
    let _e265 = noise;
    val = (0.1f + (_e265 * 0.06f));
    let _e268 = val;
    let _e270 = val;
    let _e272 = val;
    let _e275 = (*baseLighting_3);
    return (vec3<f32>((_e268 * 1.08f), (_e270 * 0.94f), (_e272 * 0.92f)) * _e275);
}

fn lavaStageColor_u0028_i1_u003b(stage: ptr<function, i32>) -> vec3<f32> {
    var indexable: array<vec3<f32>, 6>;

    let _e259 = (*stage);
    indexable = array<vec3<f32>, 6>(vec3<f32>(1f, 0.62f, 0.22f), vec3<f32>(1f, 0.4f, 0.07f), vec3<f32>(0.96f, 0.29f, 0.05f), vec3<f32>(0.86f, 0.2f, 0.04f), vec3<f32>(0.7f, 0.13f, 0.03f), vec3<f32>(0.44f, 0.07f, 0.02f));
    let _e263 = indexable[clamp((_e259 + 1i), 0i, 5i)];
    return _e263;
}

fn renderLava_u0028_u1_u003b_vi3_u003b(rawVoxel_1: ptr<function, u32>, voxelPos_5: ptr<function, vec3<i32>>) -> vec3<f32> {
    var stage_1: i32;
    var phase: f32;
    var param_8: vec3<f32>;
    var from_: vec3<f32>;
    var param_9: i32;
    var to: vec3<f32>;
    var param_10: i32;
    var leg: f32;
    var param_11: i32;
    var param_12: i32;
    var param_13: i32;
    var param_14: i32;
    var molten: vec3<f32>;
    var param_15: vec3<f32>;

    let _e273 = (*rawVoxel_1);
    stage_1 = clamp((bitcast<i32>((_e273 & 255u)) - 8i), 0i, 3i);
    let _e279 = pc.time;
    let _e281 = tuning.lavaChurnRate;
    let _e283 = (*voxelPos_5);
    param_8 = vec3<f32>(_e283);
    let _e285 = hash_u0028_vf3_u003b((&param_8));
    phase = fract(((_e279 * _e281) + _e285));
    let _e288 = phase;
    if (_e288 < 0.33333334f) {
        let _e290 = stage_1;
        param_9 = (_e290 - 1i);
        let _e292 = lavaStageColor_u0028_i1_u003b((&param_9));
        from_ = _e292;
        let _e293 = stage_1;
        param_10 = _e293;
        let _e294 = lavaStageColor_u0028_i1_u003b((&param_10));
        to = _e294;
        let _e295 = phase;
        leg = (_e295 * 3f);
    } else {
        let _e297 = phase;
        if (_e297 < 0.6666667f) {
            let _e299 = stage_1;
            param_11 = _e299;
            let _e300 = lavaStageColor_u0028_i1_u003b((&param_11));
            from_ = _e300;
            let _e301 = stage_1;
            param_12 = (_e301 + 1i);
            let _e303 = lavaStageColor_u0028_i1_u003b((&param_12));
            to = _e303;
            let _e304 = phase;
            leg = ((_e304 * 3f) - 1f);
        } else {
            let _e307 = stage_1;
            param_13 = (_e307 + 1i);
            let _e309 = lavaStageColor_u0028_i1_u003b((&param_13));
            from_ = _e309;
            let _e310 = stage_1;
            param_14 = (_e310 - 1i);
            let _e312 = lavaStageColor_u0028_i1_u003b((&param_14));
            to = _e312;
            let _e313 = phase;
            leg = ((_e313 * 3f) - 2f);
        }
    }
    let _e316 = from_;
    let _e317 = to;
    let _e318 = leg;
    molten = mix(_e316, _e317, vec3(smoothstep(0f, 1f, _e318)));
    let _e322 = molten;
    let _e323 = (*voxelPos_5);
    param_15 = (vec3<f32>(_e323) * 1.7f);
    let _e326 = hash_u0028_vf3_u003b((&param_15));
    return (_e322 * (0.9f + (_e326 * 0.1f)));
}

fn renderSteam_u0028_vi3_u003b_vf3_u003b(voxelPos_6: ptr<function, vec3<i32>>, baseLighting_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_1: f32;
    var param_16: vec3<f32>;
    var val_1: f32;
    var baseColor_1: vec3<f32>;

    let _e263 = (*voxelPos_6);
    let _e266 = pc.time;
    param_16 = (vec3<f32>(_e263) + vec3(_e266));
    let _e269 = hash_u0028_vf3_u003b((&param_16));
    noise_1 = _e269;
    let _e270 = noise_1;
    val_1 = (0.85f + (_e270 * 0.15f));
    let _e273 = val_1;
    baseColor_1 = vec3(_e273);
    let _e275 = baseColor_1;
    let _e276 = (*baseLighting_4);
    return ((_e275 * _e276) * 0.9f);
}

fn renderFire_u0028_u1_u003b_vi3_u003b(rawVoxel_2: ptr<function, u32>, voxelPos_7: ptr<function, vec3<i32>>) -> vec3<f32> {
    var noise_2: f32;
    var param_17: vec3<f32>;
    var age: u32;
    var life: f32;
    var coreColor: vec3<f32>;
    var edgeColor: vec3<f32>;
    var fireColor: vec3<f32>;

    let _e266 = (*voxelPos_7);
    let _e269 = pc.time;
    param_17 = (vec3<f32>(_e266) + vec3((_e269 * 10f)));
    let _e273 = hash_u0028_vf3_u003b((&param_17));
    noise_2 = _e273;
    let _e274 = (*rawVoxel_2);
    age = ((_e274 >> bitcast<u32>(24i)) & 255u);
    let _e278 = age;
    life = clamp((f32(_e278) / 30f), 0f, 1f);
    coreColor = vec3<f32>(1f, 0.9f, 0.2f);
    edgeColor = vec3<f32>(1f, 0.3f, 0f);
    let _e282 = coreColor;
    let _e283 = edgeColor;
    let _e284 = life;
    let _e285 = noise_2;
    fireColor = mix(_e282, _e283, vec3((_e284 + (_e285 * 0.3f))));
    let _e290 = fireColor;
    return (_e290 * 1.5f);
}

fn renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b(rawVoxel_3: ptr<function, u32>, voxelPos_8: ptr<function, vec3<i32>>, ddaNormal: ptr<function, vec3<f32>>, baseLighting_5: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_3: f32;
    var param_18: vec3<f32>;
    var val_2: f32;
    var moisture: u32;
    var wetness: f32;
    var dryColor: vec3<f32>;
    var wetColor: vec3<f32>;
    var baseColor_2: vec3<f32>;
    var floraState: u32;
    var grassGrow: f32;
    var grassColor: vec3<f32>;
    var drown: f32;
    var phi_1262_: bool;

    let _e273 = (*voxelPos_8);
    param_18 = vec3<f32>(_e273);
    let _e275 = hash_u0028_vf3_u003b((&param_18));
    noise_3 = _e275;
    let _e276 = noise_3;
    val_2 = (0.8f + (_e276 * 0.2f));
    let _e279 = (*rawVoxel_3);
    moisture = ((_e279 >> bitcast<u32>(24i)) & 255u);
    let _e283 = moisture;
    wetness = clamp((f32(_e283) / 30f), 0f, 1f);
    let _e287 = val_2;
    let _e289 = val_2;
    let _e291 = val_2;
    dryColor = vec3<f32>((0.4f * _e287), (0.25f * _e289), (0.1f * _e291));
    let _e294 = val_2;
    let _e296 = val_2;
    let _e298 = val_2;
    wetColor = vec3<f32>((0.15f * _e294), (0.08f * _e296), (0.03f * _e298));
    let _e301 = dryColor;
    let _e302 = wetColor;
    let _e303 = wetness;
    baseColor_2 = mix(_e301, _e302, vec3(_e303));
    let _e306 = (*rawVoxel_3);
    floraState = ((_e306 >> bitcast<u32>(8i)) & 255u);
    let _e310 = floraState;
    let _e311 = (_e310 > 10u);
    phi_1262_ = _e311;
    if _e311 {
        let _e313 = (*ddaNormal)[1u];
        phi_1262_ = (_e313 > 0.5f);
    }
    let _e316 = phi_1262_;
    if _e316 {
        let _e317 = floraState;
        grassGrow = clamp((f32((_e317 - 10u)) / 90f), 0f, 1f);
        let _e322 = noise_3;
        let _e325 = noise_3;
        grassColor = vec3<f32>((0.15f + (_e322 * 0.1f)), (0.45f + (_e325 * 0.15f)), 0.15f);
        let _e329 = floraState;
        if (_e329 > 100u) {
            let _e331 = floraState;
            drown = clamp((f32((_e331 - 100u)) / 100f), 0f, 1f);
            let _e336 = grassColor;
            let _e337 = drown;
            grassColor = mix(_e336, vec3<f32>(0.35f, 0.35f, 0.15f), vec3(_e337));
        }
        let _e340 = baseColor_2;
        let _e341 = grassColor;
        let _e342 = grassGrow;
        baseColor_2 = mix(_e340, _e341, vec3(_e342));
    }
    let _e345 = baseColor_2;
    let _e346 = (*baseLighting_5);
    return (_e345 * _e346);
}

fn renderStone_u0028_vi3_u003b_vf3_u003b(voxelPos_9: ptr<function, vec3<i32>>, baseLighting_6: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_4: f32;
    var param_19: vec3<f32>;
    var val_3: f32;
    var baseColor_3: vec3<f32>;

    let _e263 = (*voxelPos_9);
    param_19 = vec3<f32>(_e263);
    let _e265 = hash_u0028_vf3_u003b((&param_19));
    noise_4 = _e265;
    let _e266 = noise_4;
    val_3 = (0.4f + (_e266 * 0.3f));
    let _e269 = val_3;
    baseColor_3 = vec3(_e269);
    let _e271 = baseColor_3;
    let _e272 = (*baseLighting_6);
    return (_e271 * _e272);
}

fn renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b(voxelPos_10: ptr<function, vec3<i32>>, normal_2: ptr<function, vec3<f32>>, rayOrigin_1: ptr<function, vec3<f32>>, sunDir_1: ptr<function, vec3<f32>>, sunColor: ptr<function, vec3<f32>>, shadow: ptr<function, f32>, baseLighting_7: ptr<function, vec3<f32>>) -> vec3<f32> {
    var baseColor_4: vec3<f32>;
    var viewDir: vec3<f32>;
    var reflectDir: vec3<f32>;
    var spec: f32;
    var finalLighting: vec3<f32>;

    baseColor_4 = vec3<f32>(0.1f, 0.4f, 0.9f);
    let _e269 = (*rayOrigin_1);
    let _e270 = (*voxelPos_10);
    viewDir = normalize((_e269 - vec3<f32>(_e270)));
    let _e274 = (*sunDir_1);
    let _e276 = (*normal_2);
    reflectDir = reflect(-(_e274), _e276);
    let _e278 = viewDir;
    let _e279 = reflectDir;
    spec = pow(max(dot(_e278, _e279), 0f), 32f);
    let _e283 = (*baseLighting_7);
    let _e284 = (*sunColor);
    let _e285 = spec;
    let _e288 = (*shadow);
    finalLighting = (_e283 + (((_e284 * _e285) * 0.5f) * _e288));
    let _e291 = baseColor_4;
    let _e292 = finalLighting;
    return (_e291 * _e292);
}

fn renderSand_u0028_u1_u003b_vf3_u003b(rawVoxel_4: ptr<function, u32>, baseLighting_8: ptr<function, vec3<f32>>) -> vec3<f32> {
    var moisture_1: u32;
    var wetness_1: f32;
    var dryColor_1: vec3<f32>;
    var wetColor_1: vec3<f32>;
    var baseColor_5: vec3<f32>;

    let _e264 = (*rawVoxel_4);
    moisture_1 = ((_e264 >> bitcast<u32>(24i)) & 255u);
    let _e268 = moisture_1;
    wetness_1 = clamp((f32(_e268) / 10f), 0f, 1f);
    dryColor_1 = vec3<f32>(0.9f, 0.8f, 0.2f);
    wetColor_1 = vec3<f32>(0.65f, 0.55f, 0.15f);
    let _e272 = dryColor_1;
    let _e273 = wetColor_1;
    let _e274 = wetness_1;
    baseColor_5 = mix(_e272, _e273, vec3(_e274));
    let _e277 = baseColor_5;
    let _e278 = (*baseLighting_8);
    return (_e277 * _e278);
}

fn getVoxel_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    var index: u32;
    var phi_277_: bool;
    var phi_285_: bool;
    var phi_295_: bool;
    var phi_303_: bool;
    var phi_313_: bool;

    let _e260 = (*pos)[0u];
    let _e261 = (_e260 < 0i);
    phi_277_ = _e261;
    if !(_e261) {
        let _e264 = (*pos)[0u];
        let _e266 = tuning.gridWidth;
        phi_277_ = (_e264 >= bitcast<i32>(_e266));
    }
    let _e270 = phi_277_;
    phi_285_ = _e270;
    if !(_e270) {
        let _e273 = (*pos)[1u];
        phi_285_ = (_e273 < 0i);
    }
    let _e276 = phi_285_;
    phi_295_ = _e276;
    if !(_e276) {
        let _e279 = (*pos)[1u];
        let _e281 = tuning.gridHeight;
        phi_295_ = (_e279 >= bitcast<i32>(_e281));
    }
    let _e285 = phi_295_;
    phi_303_ = _e285;
    if !(_e285) {
        let _e288 = (*pos)[2u];
        phi_303_ = (_e288 < 0i);
    }
    let _e291 = phi_303_;
    phi_313_ = _e291;
    if !(_e291) {
        let _e294 = (*pos)[2u];
        let _e296 = tuning.gridDepth;
        phi_313_ = (_e294 >= bitcast<i32>(_e296));
    }
    let _e300 = phi_313_;
    if _e300 {
        return 0u;
    }
    let _e302 = (*pos)[0u];
    let _e304 = (*pos)[1u];
    let _e306 = tuning.gridWidth;
    let _e311 = (*pos)[2u];
    let _e313 = tuning.gridWidth;
    let _e317 = tuning.gridHeight;
    index = bitcast<u32>(((_e302 + (_e304 * bitcast<i32>(_e306))) + ((_e311 * bitcast<i32>(_e313)) * bitcast<i32>(_e317))));
    let _e322 = index;
    let _e325 = unnamed_1.grid[_e322];
    return _e325;
}

fn calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b(hitVoxelPos: ptr<function, vec3<i32>>, hitNormal: ptr<function, vec3<f32>>, lightDir: ptr<function, vec3<f32>>, ceilingY: ptr<function, i32>) -> f32 {
    var voxelPos_11: vec3<i32>;
    var stepDir_1: vec3<i32>;
    var tDelta_1: vec3<f32>;
    var local_7: f32;
    var local_8: f32;
    var local_9: f32;
    var tMax_1: vec3<f32>;
    var transmittance: f32;
    var i_6: i32;
    var blockerType: u32;
    var param_20: vec3<i32>;
    var phi_594_: bool;
    var phi_601_: bool;
    var phi_609_: bool;
    var phi_616_: bool;
    var phi_626_: bool;

    let _e272 = (*hitVoxelPos);
    let _e273 = (*hitNormal);
    voxelPos_11 = (_e272 + vec3<i32>(round(_e273)));
    let _e277 = (*lightDir);
    stepDir_1 = vec3<i32>(sign(_e277));
    let _e281 = (*lightDir)[0u];
    if (_e281 == 0f) {
        local_7 = 100000000f;
    } else {
        let _e284 = (*lightDir)[0u];
        local_7 = abs((1f / _e284));
    }
    let _e287 = local_7;
    let _e289 = (*lightDir)[1u];
    if (_e289 == 0f) {
        local_8 = 100000000f;
    } else {
        let _e292 = (*lightDir)[1u];
        local_8 = abs((1f / _e292));
    }
    let _e295 = local_8;
    let _e297 = (*lightDir)[2u];
    if (_e297 == 0f) {
        local_9 = 100000000f;
    } else {
        let _e300 = (*lightDir)[2u];
        local_9 = abs((1f / _e300));
    }
    let _e303 = local_9;
    tDelta_1 = vec3<f32>(_e287, _e295, _e303);
    let _e305 = tDelta_1;
    tMax_1 = (_e305 * 0.5f);
    transmittance = 1f;
    i_6 = 0i;
    loop {
        let _e307 = i_6;
        let _e309 = tuning.shadowMaxSteps;
        if (_e307 < bitcast<i32>(_e309)) {
            let _e313 = voxelPos_11[0u];
            let _e314 = (_e313 < 0i);
            phi_594_ = _e314;
            if !(_e314) {
                let _e317 = voxelPos_11[0u];
                let _e319 = tuning.gridWidth;
                phi_594_ = (_e317 >= bitcast<i32>(_e319));
            }
            let _e323 = phi_594_;
            phi_601_ = _e323;
            if !(_e323) {
                let _e326 = voxelPos_11[1u];
                phi_601_ = (_e326 < 0i);
            }
            let _e329 = phi_601_;
            phi_609_ = _e329;
            if !(_e329) {
                let _e332 = voxelPos_11[1u];
                let _e333 = (*ceilingY);
                phi_609_ = (_e332 >= _e333);
            }
            let _e336 = phi_609_;
            phi_616_ = _e336;
            if !(_e336) {
                let _e339 = voxelPos_11[2u];
                phi_616_ = (_e339 < 0i);
            }
            let _e342 = phi_616_;
            phi_626_ = _e342;
            if !(_e342) {
                let _e345 = voxelPos_11[2u];
                let _e347 = tuning.gridDepth;
                phi_626_ = (_e345 >= bitcast<i32>(_e347));
            }
            let _e351 = phi_626_;
            if _e351 {
                let _e352 = transmittance;
                return _e352;
            }
            let _e353 = voxelPos_11;
            param_20 = _e353;
            let _e354 = getVoxel_u0028_vi3_u003b((&param_20));
            blockerType = (_e354 & 255u);
            let _e356 = blockerType;
            if (_e356 == 2u) {
                let _e359 = tuning.waterShadowTransmit;
                let _e360 = transmittance;
                transmittance = (_e360 * _e359);
                let _e362 = transmittance;
                if (_e362 < 0.02f) {
                    return 0f;
                }
            } else {
                let _e364 = blockerType;
                if (_e364 != 0u) {
                    return 0f;
                }
            }
            let _e367 = tMax_1[0u];
            let _e369 = tMax_1[1u];
            if (_e367 < _e369) {
                let _e372 = tMax_1[0u];
                let _e374 = tMax_1[2u];
                if (_e372 < _e374) {
                    let _e377 = stepDir_1[0u];
                    let _e379 = voxelPos_11[0u];
                    voxelPos_11[0u] = (_e379 + _e377);
                    let _e383 = tDelta_1[0u];
                    let _e385 = tMax_1[0u];
                    tMax_1[0u] = (_e385 + _e383);
                } else {
                    let _e389 = stepDir_1[2u];
                    let _e391 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e391 + _e389);
                    let _e395 = tDelta_1[2u];
                    let _e397 = tMax_1[2u];
                    tMax_1[2u] = (_e397 + _e395);
                }
            } else {
                let _e401 = tMax_1[1u];
                let _e403 = tMax_1[2u];
                if (_e401 < _e403) {
                    let _e406 = stepDir_1[1u];
                    let _e408 = voxelPos_11[1u];
                    voxelPos_11[1u] = (_e408 + _e406);
                    let _e412 = tDelta_1[1u];
                    let _e414 = tMax_1[1u];
                    tMax_1[1u] = (_e414 + _e412);
                } else {
                    let _e418 = stepDir_1[2u];
                    let _e420 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e420 + _e418);
                    let _e424 = tDelta_1[2u];
                    let _e426 = tMax_1[2u];
                    tMax_1[2u] = (_e426 + _e424);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e429 = i_6;
            i_6 = (_e429 + 1i);
        }
    }
    let _e431 = transmittance;
    return _e431;
}

fn getSmoothNormal_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> vec3<f32> {
    var n_2: vec3<f32>;
    var x: i32;
    var y: i32;
    var z: i32;
    var param_21: vec3<i32>;
    var offset: vec3<f32>;

    n_2 = vec3<f32>(0f, 0f, 0f);
    x = -1i;
    loop {
        let _e264 = x;
        if (_e264 <= 1i) {
            y = -1i;
            loop {
                let _e266 = y;
                if (_e266 <= 1i) {
                    z = -1i;
                    loop {
                        let _e268 = z;
                        if (_e268 <= 1i) {
                            let _e270 = x;
                            let _e272 = y;
                            let _e275 = z;
                            if (((_e270 == 0i) && (_e272 == 0i)) && (_e275 == 0i)) {
                                continue;
                            }
                            let _e278 = (*p_1);
                            let _e279 = x;
                            let _e280 = y;
                            let _e281 = z;
                            param_21 = (_e278 + vec3<i32>(_e279, _e280, _e281));
                            let _e284 = getVoxel_u0028_vi3_u003b((&param_21));
                            if ((_e284 & 255u) == 0u) {
                                continue;
                            }
                            let _e287 = x;
                            let _e289 = y;
                            let _e291 = z;
                            offset = vec3<f32>(f32(_e287), f32(_e289), f32(_e291));
                            let _e294 = offset;
                            let _e295 = x;
                            let _e296 = x;
                            let _e298 = y;
                            let _e299 = y;
                            let _e302 = z;
                            let _e303 = z;
                            let _e309 = n_2;
                            n_2 = (_e309 - (_e294 * inverseSqrt(f32((((_e295 * _e296) + (_e298 * _e299)) + (_e302 * _e303))))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e311 = z;
                            z = (_e311 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e313 = y;
                    y = (_e313 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e315 = x;
            x = (_e315 + 1i);
        }
    }
    let _e317 = n_2;
    if (length(_e317) < 0.1f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e320 = n_2;
    return normalize(_e320);
}

fn waterWaveGradient_u0028_vf2_u003b_f1_u003b(p_2: ptr<function, vec2<f32>>, t_1: ptr<function, f32>) -> vec2<f32> {
    var scale: f32;
    var wt: f32;
    var q: vec2<f32>;
    var grad: vec2<f32>;
    var i_7: i32;
    var f: f32;
    var indexable_1: array<f32, 5>;
    var phase_1: f32;
    var indexable_2: array<vec2<f32>, 5>;
    var indexable_3: array<f32, 5>;
    var indexable_4: array<vec2<f32>, 5>;
    var indexable_5: array<f32, 5>;
    var envelope: f32;

    let _e273 = tuning.waterWaveScale;
    scale = max(_e273, 0.001f);
    let _e275 = (*t_1);
    let _e277 = tuning.waterWaveSpeed;
    wt = ((_e275 * _e277) * 0.35f);
    let _e280 = (*p_2);
    let _e282 = (*p_2)[1u];
    let _e284 = wt;
    let _e288 = (*p_2)[0u];
    let _e290 = wt;
    q = (_e280 + (vec2<f32>(sin(((_e282 * 0.043f) + _e284)), sin(((_e288 * 0.037f) - (_e290 * 0.8f)))) * 6f));
    grad = vec2<f32>(0f, 0f);
    i_7 = 0i;
    loop {
        let _e297 = i_7;
        if (_e297 < 5i) {
            let _e299 = i_7;
            indexable_1 = array<f32, 5>(0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
            let _e301 = indexable_1[_e299];
            let _e302 = scale;
            f = (_e301 * _e302);
            let _e304 = i_7;
            indexable_2 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e306 = indexable_2[_e304];
            let _e307 = q;
            let _e309 = f;
            let _e311 = (*t_1);
            let _e312 = i_7;
            indexable_3 = array<f32, 5>(1f, 1.37f, 0.83f, 1.71f, 0.61f);
            let _e314 = indexable_3[_e312];
            let _e317 = tuning.waterWaveSpeed;
            phase_1 = ((dot(_e306, _e307) * _e309) + ((_e311 * _e314) * _e317));
            let _e320 = i_7;
            indexable_4 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e322 = indexable_4[_e320];
            let _e323 = i_7;
            indexable_5 = array<f32, 5>(1f, 0.62f, 0.38f, 0.24f, 0.15f);
            let _e325 = indexable_5[_e323];
            let _e326 = f;
            let _e328 = phase_1;
            let _e332 = grad;
            grad = (_e332 + (_e322 * ((_e325 * _e326) * cos(_e328))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e334 = i_7;
            i_7 = (_e334 + 1i);
        }
    }
    let _e337 = (*p_2)[0u];
    let _e340 = (*p_2)[1u];
    let _e343 = (*t_1);
    envelope = (0.45f + (0.55f * sin((((_e337 * 0.021f) + (_e340 * 0.017f)) + (_e343 * 0.11f)))));
    let _e349 = grad;
    let _e350 = envelope;
    return (_e349 * _e350);
}

fn applyWaterWaves_u0028_vf3_u003b_vi3_u003b(normal_3: ptr<function, vec3<f32>>, voxelPos_12: ptr<function, vec3<i32>>) -> vec3<f32> {
    var upness: f32;
    var grad_1: vec2<f32>;
    var param_22: vec2<f32>;
    var param_23: f32;

    let _e264 = tuning.waterWaveStrength;
    if (_e264 <= 0f) {
        let _e266 = (*normal_3);
        return _e266;
    }
    let _e268 = (*normal_3)[1u];
    upness = clamp(_e268, 0f, 1f);
    let _e270 = upness;
    if (_e270 <= 0f) {
        let _e272 = (*normal_3);
        return _e272;
    }
    let _e273 = (*voxelPos_12);
    param_22 = (vec2<f32>(_e273.xz) + vec2<f32>(0.5f, 0.5f));
    let _e278 = pc.time;
    param_23 = _e278;
    let _e279 = waterWaveGradient_u0028_vf2_u003b_f1_u003b((&param_22), (&param_23));
    grad_1 = _e279;
    let _e280 = (*normal_3);
    let _e282 = grad_1[0u];
    let _e285 = grad_1[1u];
    let _e289 = tuning.waterWaveStrength;
    let _e291 = upness;
    return normalize((_e280 + ((vec3<f32>(-(_e282), 0f, -(_e285)) * _e289) * _e291)));
}

fn getWaterNormal_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> vec3<f32> {
    var n_3: vec3<f32>;
    var x_1: i32;
    var y_1: i32;
    var z_1: i32;
    var d2_: i32;
    var param_24: vec3<i32>;

    n_3 = vec3<f32>(0f, 0f, 0f);
    x_1 = -2i;
    loop {
        let _e264 = x_1;
        if (_e264 <= 2i) {
            y_1 = -2i;
            loop {
                let _e266 = y_1;
                if (_e266 <= 2i) {
                    z_1 = -2i;
                    loop {
                        let _e268 = z_1;
                        if (_e268 <= 2i) {
                            let _e270 = x_1;
                            let _e272 = y_1;
                            let _e275 = z_1;
                            if (((_e270 == 0i) && (_e272 == 0i)) && (_e275 == 0i)) {
                                continue;
                            }
                            let _e278 = x_1;
                            let _e279 = x_1;
                            let _e281 = y_1;
                            let _e282 = y_1;
                            let _e285 = z_1;
                            let _e286 = z_1;
                            d2_ = (((_e278 * _e279) + (_e281 * _e282)) + (_e285 * _e286));
                            let _e289 = d2_;
                            if (_e289 > 6i) {
                                continue;
                            }
                            let _e291 = (*p_3);
                            let _e292 = x_1;
                            let _e293 = y_1;
                            let _e294 = z_1;
                            param_24 = (_e291 + vec3<i32>(_e292, _e293, _e294));
                            let _e297 = getVoxel_u0028_vi3_u003b((&param_24));
                            if ((_e297 & 255u) == 0u) {
                                continue;
                            }
                            let _e300 = x_1;
                            let _e302 = y_1;
                            let _e304 = z_1;
                            let _e307 = d2_;
                            let _e311 = n_3;
                            n_3 = (_e311 - (vec3<f32>(f32(_e300), f32(_e302), f32(_e304)) / vec3(f32(_e307))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e313 = z_1;
                            z_1 = (_e313 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e315 = y_1;
                    y_1 = (_e315 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e317 = x_1;
            x_1 = (_e317 + 1i);
        }
    }
    let _e319 = n_3;
    if (length(_e319) < 0.001f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e322 = n_3;
    return normalize(_e322);
}

fn locustDensity_u0028_u1_u003b(type_38: ptr<function, u32>) -> f32 {
    var stage_2: f32;

    let _e259 = (*type_38);
    stage_2 = (f32((_e259 - 13u)) / 4f);
    let _e264 = tuning.locustDensityMin;
    let _e266 = tuning.locustDensityMax;
    let _e267 = stage_2;
    return clamp(mix(_e264, _e266, _e267), 0.02f, 0.98f);
}

fn trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b(voxelPos_13: ptr<function, vec3<i32>>, a: ptr<function, vec2<f32>>, b: ptr<function, vec2<f32>>, count: ptr<function, i32>) {
    var h0_: f32;
    var param_25: vec3<f32>;
    var h1_: f32;
    var param_26: vec3<f32>;
    var h2_: f32;
    var param_27: vec3<f32>;

    let _e268 = (*voxelPos_13)[0u];
    let _e271 = (*voxelPos_13)[2u];
    param_25 = vec3<f32>(f32(_e268), 7f, f32(_e271));
    let _e274 = hash_u0028_vf3_u003b((&param_25));
    h0_ = _e274;
    let _e276 = (*voxelPos_13)[0u];
    let _e279 = (*voxelPos_13)[2u];
    param_26 = vec3<f32>(f32(_e276), 19f, f32(_e279));
    let _e282 = hash_u0028_vf3_u003b((&param_26));
    h1_ = _e282;
    let _e284 = (*voxelPos_13)[0u];
    let _e287 = (*voxelPos_13)[2u];
    param_27 = vec3<f32>(f32(_e284), 53f, f32(_e287));
    let _e290 = hash_u0028_vf3_u003b((&param_27));
    h2_ = _e290;
    let _e291 = h2_;
    let _e293 = tuning.treeTrunkColumns;
    (*count) = (1i + i32((_e291 * f32(max(bitcast<i32>(_e293), 1i)))));
    let _e300 = (*count);
    (*count) = clamp(_e300, 1i, 2i);
    let _e302 = h0_;
    let _e305 = h1_;
    (*a) = vec2<f32>((0.3f + (_e302 * 0.4f)), (0.3f + (_e305 * 0.4f)));
    let _e309 = h1_;
    let _e312 = h0_;
    (*b) = vec2<f32>((0.3f + (_e309 * 0.4f)), (0.3f + (_e312 * 0.4f)));
    return;
}

fn subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b(kind: ptr<function, u32>, type_39: ptr<function, u32>, voxelPos_14: ptr<function, vec3<i32>>, cell: ptr<function, vec3<i32>>, sub: ptr<function, i32>, jitter: ptr<function, vec3<f32>>) -> bool {
    var p_4: vec2<f32>;
    var a_1: vec2<f32>;
    var b_1: vec2<f32>;
    var count_1: i32;
    var param_28: vec3<i32>;
    var param_29: vec2<f32>;
    var param_30: vec2<f32>;
    var param_31: i32;
    var r_1: f32;
    var param_32: vec3<f32>;
    var param_33: u32;
    var phi_1628_: bool;

    let _e274 = (*kind);
    if (_e274 == 1u) {
        let _e276 = (*cell);
        let _e281 = (*sub);
        p_4 = ((vec2<f32>(_e276.xz) + vec2(0.5f)) / vec2(f32(_e281)));
        let _e285 = (*voxelPos_14);
        param_28 = _e285;
        trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b((&param_28), (&param_29), (&param_30), (&param_31));
        let _e286 = param_29;
        a_1 = _e286;
        let _e287 = param_30;
        b_1 = _e287;
        let _e288 = param_31;
        count_1 = _e288;
        let _e290 = tuning.treeTrunkRadius;
        r_1 = max(_e290, 0.02f);
        let _e292 = p_4;
        let _e293 = a_1;
        let _e295 = p_4;
        let _e296 = a_1;
        let _e299 = r_1;
        let _e300 = r_1;
        if (dot((_e292 - _e293), (_e295 - _e296)) <= (_e299 * _e300)) {
            return true;
        }
        let _e303 = count_1;
        let _e304 = (_e303 > 1i);
        phi_1628_ = _e304;
        if _e304 {
            let _e305 = p_4;
            let _e306 = b_1;
            let _e308 = p_4;
            let _e309 = b_1;
            let _e312 = r_1;
            let _e313 = r_1;
            phi_1628_ = (dot((_e305 - _e306), (_e308 - _e309)) <= (_e312 * _e313));
        }
        let _e317 = phi_1628_;
        if _e317 {
            return true;
        }
        return false;
    }
    let _e318 = (*voxelPos_14);
    let _e319 = (*sub);
    let _e322 = (*cell);
    let _e325 = (*jitter);
    param_32 = (vec3<f32>(((_e318 * vec3(_e319)) + _e322)) + _e325);
    let _e327 = hash_u0028_vf3_u003b((&param_32));
    let _e328 = (*type_39);
    param_33 = _e328;
    let _e329 = locustDensity_u0028_u1_u003b((&param_33));
    return (_e327 < _e329);
}

fn intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b(ro: ptr<function, vec3<f32>>, rd: ptr<function, vec3<f32>>, boxMin: ptr<function, vec3<f32>>, boxMax: ptr<function, vec3<f32>>) -> vec2<f32> {
    var tMin: vec3<f32>;
    var tMax_2: vec3<f32>;
    var t1_: vec3<f32>;
    var t2_: vec3<f32>;
    var tNear: f32;
    var tFar: f32;

    let _e267 = (*boxMin);
    let _e268 = (*ro);
    let _e270 = (*rd);
    tMin = ((_e267 - _e268) / _e270);
    let _e272 = (*boxMax);
    let _e273 = (*ro);
    let _e275 = (*rd);
    tMax_2 = ((_e272 - _e273) / _e275);
    let _e277 = tMin;
    let _e278 = tMax_2;
    t1_ = min(_e277, _e278);
    let _e280 = tMin;
    let _e281 = tMax_2;
    t2_ = max(_e280, _e281);
    let _e284 = t1_[0u];
    let _e286 = t1_[1u];
    let _e289 = t1_[2u];
    tNear = max(max(_e284, _e286), _e289);
    let _e292 = t2_[0u];
    let _e294 = t2_[1u];
    let _e297 = t2_[2u];
    tFar = min(min(_e292, _e294), _e297);
    let _e299 = tNear;
    let _e300 = tFar;
    return vec2<f32>(_e299, _e300);
}

fn subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b(voxelPos_15: ptr<function, vec3<i32>>, rayOrigin_2: ptr<function, vec3<f32>>, rayDir_2: ptr<function, vec3<f32>>, kind_1: ptr<function, u32>, type_40: ptr<function, u32>, entryNormal: ptr<function, vec3<f32>>, tHit_1: ptr<function, f32>, subNormal: ptr<function, vec3<f32>>, subCell_2: ptr<function, vec3<f32>>) -> bool {
    var sub_1: i32;
    var cellSize: f32;
    var boxMin_1: vec3<f32>;
    var span: vec2<f32>;
    var param_34: vec3<f32>;
    var param_35: vec3<f32>;
    var param_36: vec3<f32>;
    var param_37: vec3<f32>;
    var t_2: f32;
    var local_10: vec3<f32>;
    var c: vec3<i32>;
    var stepDir_2: vec3<i32>;
    var tDelta_2: vec3<f32>;
    var local_11: f32;
    var local_12: f32;
    var local_13: f32;
    var fracPos_1: vec3<f32>;
    var tMax_3: vec3<f32>;
    var local_14: f32;
    var local_15: f32;
    var local_16: f32;
    var jitter_1: vec3<f32>;
    var local_17: vec3<f32>;
    var i_8: i32;
    var param_38: u32;
    var param_39: u32;
    var param_40: vec3<i32>;
    var param_41: vec3<i32>;
    var param_42: i32;
    var param_43: vec3<f32>;
    var phi_1860_: bool;
    var phi_1867_: bool;
    var phi_1875_: bool;
    var phi_1882_: bool;
    var phi_1890_: bool;

    (*tHit_1) = 0f;
    let _e296 = (*entryNormal);
    (*subNormal) = _e296;
    (*subCell_2) = vec3<f32>(0f, 0f, 0f);
    let _e298 = tuning.locustSubdivision;
    sub_1 = clamp(bitcast<i32>(_e298), 1i, 8i);
    let _e301 = sub_1;
    cellSize = (1f / f32(_e301));
    let _e304 = (*voxelPos_15);
    boxMin_1 = vec3<f32>(_e304);
    let _e306 = boxMin_1;
    let _e308 = (*rayOrigin_2);
    param_34 = _e308;
    let _e309 = (*rayDir_2);
    param_35 = _e309;
    let _e310 = boxMin_1;
    param_36 = _e310;
    param_37 = (_e306 + vec3<f32>(1f, 1f, 1f));
    let _e311 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_34), (&param_35), (&param_36), (&param_37));
    span = _e311;
    let _e313 = span[0u];
    t_2 = max(_e313, 0f);
    let _e315 = t_2;
    let _e317 = span[1u];
    if (_e315 > _e317) {
        return false;
    }
    let _e319 = (*rayOrigin_2);
    let _e320 = (*rayDir_2);
    let _e321 = t_2;
    let _e325 = boxMin_1;
    let _e327 = sub_1;
    local_10 = (((_e319 + (_e320 * (_e321 + 0.0001f))) - _e325) * f32(_e327));
    let _e330 = local_10;
    let _e333 = sub_1;
    c = clamp(vec3<i32>(floor(_e330)), vec3<i32>(0i, 0i, 0i), vec3((_e333 - 1i)));
    let _e337 = (*rayDir_2);
    stepDir_2 = vec3<i32>(sign(_e337));
    let _e341 = (*rayDir_2)[0u];
    if (_e341 == 0f) {
        local_11 = 1000000f;
    } else {
        let _e343 = cellSize;
        let _e345 = (*rayDir_2)[0u];
        local_11 = abs((_e343 / _e345));
    }
    let _e348 = local_11;
    let _e350 = (*rayDir_2)[1u];
    if (_e350 == 0f) {
        local_12 = 1000000f;
    } else {
        let _e352 = cellSize;
        let _e354 = (*rayDir_2)[1u];
        local_12 = abs((_e352 / _e354));
    }
    let _e357 = local_12;
    let _e359 = (*rayDir_2)[2u];
    if (_e359 == 0f) {
        local_13 = 1000000f;
    } else {
        let _e361 = cellSize;
        let _e363 = (*rayDir_2)[2u];
        local_13 = abs((_e361 / _e363));
    }
    let _e366 = local_13;
    tDelta_2 = vec3<f32>(_e348, _e357, _e366);
    let _e368 = local_10;
    let _e369 = c;
    fracPos_1 = (_e368 - vec3<f32>(_e369));
    let _e372 = t_2;
    let _e374 = stepDir_2[0u];
    if (_e374 > 0i) {
        let _e377 = fracPos_1[0u];
        let _e380 = tDelta_2[0u];
        local_14 = ((1f - _e377) * _e380);
    } else {
        let _e383 = fracPos_1[0u];
        let _e385 = tDelta_2[0u];
        local_14 = (_e383 * _e385);
    }
    let _e387 = local_14;
    let _e389 = stepDir_2[1u];
    if (_e389 > 0i) {
        let _e392 = fracPos_1[1u];
        let _e395 = tDelta_2[1u];
        local_15 = ((1f - _e392) * _e395);
    } else {
        let _e398 = fracPos_1[1u];
        let _e400 = tDelta_2[1u];
        local_15 = (_e398 * _e400);
    }
    let _e402 = local_15;
    let _e404 = stepDir_2[2u];
    if (_e404 > 0i) {
        let _e407 = fracPos_1[2u];
        let _e410 = tDelta_2[2u];
        local_16 = ((1f - _e407) * _e410);
    } else {
        let _e413 = fracPos_1[2u];
        let _e415 = tDelta_2[2u];
        local_16 = (_e413 * _e415);
    }
    let _e417 = local_16;
    tMax_3 = (vec3(_e372) + vec3<f32>(_e387, _e402, _e417));
    let _e421 = (*kind_1);
    if (_e421 == 0u) {
        let _e424 = pc.time;
        let _e426 = tuning.locustCrawlRate;
        local_17 = vec3((floor((_e424 * _e426)) * 1.7f));
    } else {
        local_17 = vec3<f32>(0f, 0f, 0f);
    }
    let _e431 = local_17;
    jitter_1 = _e431;
    i_8 = 0i;
    loop {
        let _e432 = i_8;
        let _e433 = sub_1;
        if (_e432 < (3i * _e433)) {
            let _e437 = c[0u];
            let _e438 = (_e437 < 0i);
            phi_1860_ = _e438;
            if !(_e438) {
                let _e441 = c[0u];
                let _e442 = sub_1;
                phi_1860_ = (_e441 >= _e442);
            }
            let _e445 = phi_1860_;
            phi_1867_ = _e445;
            if !(_e445) {
                let _e448 = c[1u];
                phi_1867_ = (_e448 < 0i);
            }
            let _e451 = phi_1867_;
            phi_1875_ = _e451;
            if !(_e451) {
                let _e454 = c[1u];
                let _e455 = sub_1;
                phi_1875_ = (_e454 >= _e455);
            }
            let _e458 = phi_1875_;
            phi_1882_ = _e458;
            if !(_e458) {
                let _e461 = c[2u];
                phi_1882_ = (_e461 < 0i);
            }
            let _e464 = phi_1882_;
            phi_1890_ = _e464;
            if !(_e464) {
                let _e467 = c[2u];
                let _e468 = sub_1;
                phi_1890_ = (_e467 >= _e468);
            }
            let _e471 = phi_1890_;
            if _e471 {
                return false;
            }
            let _e472 = (*kind_1);
            param_38 = _e472;
            let _e473 = (*type_40);
            param_39 = _e473;
            let _e474 = (*voxelPos_15);
            param_40 = _e474;
            let _e475 = c;
            param_41 = _e475;
            let _e476 = sub_1;
            param_42 = _e476;
            let _e477 = jitter_1;
            param_43 = _e477;
            let _e478 = subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b((&param_38), (&param_39), (&param_40), (&param_41), (&param_42), (&param_43));
            if _e478 {
                let _e479 = t_2;
                (*tHit_1) = _e479;
                let _e480 = c;
                (*subCell_2) = vec3<f32>(_e480);
                return true;
            }
            let _e483 = tMax_3[0u];
            let _e485 = tMax_3[1u];
            if (_e483 < _e485) {
                let _e488 = tMax_3[0u];
                let _e490 = tMax_3[2u];
                if (_e488 < _e490) {
                    let _e493 = stepDir_2[0u];
                    let _e495 = c[0u];
                    c[0u] = (_e495 + _e493);
                    let _e499 = tMax_3[0u];
                    t_2 = _e499;
                    let _e501 = tDelta_2[0u];
                    let _e503 = tMax_3[0u];
                    tMax_3[0u] = (_e503 + _e501);
                    let _e507 = stepDir_2[0u];
                    (*subNormal) = vec3<f32>(f32(-(_e507)), 0f, 0f);
                } else {
                    let _e512 = stepDir_2[2u];
                    let _e514 = c[2u];
                    c[2u] = (_e514 + _e512);
                    let _e518 = tMax_3[2u];
                    t_2 = _e518;
                    let _e520 = tDelta_2[2u];
                    let _e522 = tMax_3[2u];
                    tMax_3[2u] = (_e522 + _e520);
                    let _e526 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e526)));
                }
            } else {
                let _e531 = tMax_3[1u];
                let _e533 = tMax_3[2u];
                if (_e531 < _e533) {
                    let _e536 = stepDir_2[1u];
                    let _e538 = c[1u];
                    c[1u] = (_e538 + _e536);
                    let _e542 = tMax_3[1u];
                    t_2 = _e542;
                    let _e544 = tDelta_2[1u];
                    let _e546 = tMax_3[1u];
                    tMax_3[1u] = (_e546 + _e544);
                    let _e550 = stepDir_2[1u];
                    (*subNormal) = vec3<f32>(0f, f32(-(_e550)), 0f);
                } else {
                    let _e555 = stepDir_2[2u];
                    let _e557 = c[2u];
                    c[2u] = (_e557 + _e555);
                    let _e561 = tMax_3[2u];
                    t_2 = _e561;
                    let _e563 = tDelta_2[2u];
                    let _e565 = tMax_3[2u];
                    tMax_3[2u] = (_e565 + _e563);
                    let _e569 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e569)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e573 = i_8;
            i_8 = (_e573 + 1i);
        }
    }
    return false;
}

fn isLocustType_u0028_u1_u003b(type_41: ptr<function, u32>) -> bool {
    let _e258 = (*type_41);
    let _e260 = (*type_41);
    return ((_e258 >= 13u) && (_e260 <= 17u));
}

fn marchCeiling_u0028_() -> i32 {
    let _e258 = tuning.gridHeight;
    let _e261 = unnamed.maxOccupiedY;
    return min(bitcast<i32>(_e258), (bitcast<i32>(_e261) + 2i));
}

fn worldExtent_u0028_() -> vec3<f32> {
    let _e258 = tuning.gridWidth;
    let _e262 = tuning.gridHeight;
    let _e266 = tuning.gridDepth;
    return vec3<f32>(f32(bitcast<i32>(_e258)), f32(bitcast<i32>(_e262)), f32(bitcast<i32>(_e266)));
}

fn isEdge_u0028_vf3_u003b(p_5: ptr<function, vec3<f32>>) -> bool {
    var thickness: f32;
    var boundCount: i32;
    var extent: vec3<f32>;
    var phi_469_: bool;
    var phi_488_: bool;
    var phi_507_: bool;

    thickness = 0.3f;
    boundCount = 0i;
    let _e261 = worldExtent_u0028_();
    extent = _e261;
    let _e263 = (*p_5)[0u];
    let _e264 = thickness;
    let _e265 = (_e263 < _e264);
    phi_469_ = _e265;
    if !(_e265) {
        let _e268 = (*p_5)[0u];
        let _e270 = extent[0u];
        let _e271 = thickness;
        phi_469_ = (_e268 > (_e270 - _e271));
    }
    let _e275 = phi_469_;
    if _e275 {
        let _e276 = boundCount;
        boundCount = (_e276 + 1i);
    }
    let _e279 = (*p_5)[1u];
    let _e280 = thickness;
    let _e281 = (_e279 < _e280);
    phi_488_ = _e281;
    if !(_e281) {
        let _e284 = (*p_5)[1u];
        let _e286 = extent[1u];
        let _e287 = thickness;
        phi_488_ = (_e284 > (_e286 - _e287));
    }
    let _e291 = phi_488_;
    if _e291 {
        let _e292 = boundCount;
        boundCount = (_e292 + 1i);
    }
    let _e295 = (*p_5)[2u];
    let _e296 = thickness;
    let _e297 = (_e295 < _e296);
    phi_507_ = _e297;
    if !(_e297) {
        let _e300 = (*p_5)[2u];
        let _e302 = extent[2u];
        let _e303 = thickness;
        phi_507_ = (_e300 > (_e302 - _e303));
    }
    let _e307 = phi_507_;
    if _e307 {
        let _e308 = boundCount;
        boundCount = (_e308 + 1i);
    }
    let _e310 = boundCount;
    return (_e310 >= 2i);
}

fn rot_u0028_f1_u003b(a_2: ptr<function, f32>) -> mat2x2<f32> {
    var s: f32;
    var c_1: f32;

    let _e260 = (*a_2);
    s = sin(_e260);
    let _e262 = (*a_2);
    c_1 = cos(_e262);
    let _e264 = c_1;
    let _e265 = s;
    let _e267 = s;
    let _e268 = c_1;
    return mat2x2<f32>(vec2<f32>(_e264, -(_e265)), vec2<f32>(_e267, _e268));
}

fn applyCameraRotation_u0028_vf3_u003b(v: ptr<function, vec3<f32>>) -> vec3<f32> {
    var param_44: f32;
    var param_45: f32;

    let _e261 = pc.pitch;
    param_44 = _e261;
    let _e262 = rot_u0028_f1_u003b((&param_44));
    let _e263 = (*v);
    let _e265 = (_e263.yz * _e262);
    (*v)[1u] = _e265.x;
    (*v)[2u] = _e265.y;
    let _e271 = pc.yaw;
    param_45 = _e271;
    let _e272 = rot_u0028_f1_u003b((&param_45));
    let _e273 = (*v);
    let _e275 = (_e273.xz * _e272);
    (*v)[0u] = _e275.x;
    (*v)[2u] = _e275.y;
    let _e280 = (*v);
    return _e280;
}

fn main_1() {
    var screenSpace: vec2<f32>;
    var baseOrigin: vec3<f32>;
    var forward: vec3<f32>;
    var param_46: vec3<f32>;
    var right: vec3<f32>;
    var param_47: vec3<f32>;
    var up: vec3<f32>;
    var param_48: vec3<f32>;
    var t_3: f32;
    var cubeCenter: vec3<f32>;
    var viewDistance: f32;
    var orthoHalfSize: f32;
    var localDir: vec3<f32>;
    var rayDir_3: vec3<f32>;
    var originOffset: vec3<f32>;
    var rayOrigin_3: vec3<f32>;
    var finalColor: vec4<f32>;
    var finalDist: f32;
    var aabbHit: vec2<f32>;
    var param_49: vec3<f32>;
    var param_50: vec3<f32>;
    var param_51: vec3<f32>;
    var param_52: vec3<f32>;
    var hitFrontBox: bool;
    var hitBackBox: bool;
    var param_53: vec3<f32>;
    var param_54: vec3<f32>;
    var ceilingY_1: i32;
    var marchHit: vec2<f32>;
    var param_55: vec3<f32>;
    var param_56: vec3<f32>;
    var param_57: vec3<f32>;
    var param_58: vec3<f32>;
    var currentPos: vec3<f32>;
    var voxelPos_16: vec3<i32>;
    var stepDir_3: vec3<i32>;
    var tDelta_3: vec3<f32>;
    var local_18: f32;
    var local_19: f32;
    var local_20: f32;
    var tMax_4: vec3<f32>;
    var local_21: f32;
    var local_22: f32;
    var local_23: f32;
    var normal_4: vec3<f32>;
    var hit: bool;
    var hitType: u32;
    var hitRawVoxel: u32;
    var subT: f32;
    var subNormal_1: vec3<f32>;
    var subCell_3: vec3<f32>;
    var MAX_VISIBILITY: f32;
    var i_9: i32;
    var rawVoxel_5: u32;
    var param_59: vec3<i32>;
    var age_1: u32;
    var targetAlpha: f32;
    var dither: f32;
    var param_60: u32;
    var kind_2: u32;
    var param_61: vec3<i32>;
    var param_62: vec3<f32>;
    var param_63: vec3<f32>;
    var param_64: u32;
    var param_65: u32;
    var param_66: vec3<f32>;
    var param_67: f32;
    var param_68: vec3<f32>;
    var param_69: vec3<f32>;
    var ddaNormal_1: vec3<f32>;
    var param_70: vec3<i32>;
    var param_71: vec3<f32>;
    var param_72: vec3<i32>;
    var param_73: u32;
    var param_74: vec3<i32>;
    var sunDir_2: vec3<f32>;
    var sunColor_1: vec3<f32>;
    var ambientColor: vec3<f32>;
    var diffuse_1: f32;
    var shadow_1: f32;
    var param_75: vec3<i32>;
    var param_76: vec3<f32>;
    var param_77: vec3<f32>;
    var param_78: i32;
    var baseLighting_9: vec3<f32>;
    var finalVoxelColor: vec3<f32>;
    var param_79: u32;
    var param_80: vec3<f32>;
    var param_81: vec3<i32>;
    var param_82: vec3<f32>;
    var param_83: vec3<f32>;
    var param_84: vec3<f32>;
    var param_85: vec3<f32>;
    var param_86: f32;
    var param_87: vec3<f32>;
    var param_88: vec3<i32>;
    var param_89: vec3<f32>;
    var param_90: u32;
    var param_91: vec3<i32>;
    var param_92: vec3<f32>;
    var param_93: vec3<f32>;
    var param_94: u32;
    var param_95: vec3<i32>;
    var param_96: vec3<i32>;
    var param_97: vec3<f32>;
    var param_98: u32;
    var param_99: vec3<i32>;
    var param_100: vec3<i32>;
    var param_101: vec3<f32>;
    var param_102: vec3<i32>;
    var param_103: vec3<f32>;
    var param_104: vec3<f32>;
    var param_105: vec3<i32>;
    var param_106: vec3<f32>;
    var param_107: vec3<f32>;
    var param_108: u32;
    var param_109: vec3<i32>;
    var param_110: vec3<f32>;
    var param_111: vec3<f32>;
    var param_112: vec3<i32>;
    var distanceTraveled: f32;
    var param_113: u32;
    var local_24: f32;
    var seenHoles: u32;
    var i_10: i32;
    var code_2: u32;
    var bodyLevel: u32;
    var local_25: u32;
    var param_114: u32;
    var bodyRadius: f32;
    var param_115: u32;
    var center_1: vec3<f32>;
    var param_116: u32;
    var oc: vec3<f32>;
    var b_2: f32;
    var c_2: f32;
    var disc: f32;
    var sq: f32;
    var tNear_1: f32;
    var tFar_1: f32;
    var bodyDist: f32;
    var surfaceNormal: vec3<f32>;
    var bodyColor: vec3<f32>;
    var param_117: vec3<f32>;
    var param_118: vec3<f32>;
    var charge: f32;
    var groupAlpha: f32;
    var cloudGreyness: f32;
    var crossedTime: f32;
    var footprintClip: vec2<f32>;
    var param_119: vec3<f32>;
    var param_120: vec3<f32>;
    var param_121: vec3<f32>;
    var param_122: vec3<f32>;
    var cloudSunDir: vec3<f32>;
    var bestT: f32;
    var bestColor: vec3<f32>;
    var bestAlpha: f32;
    var foundCloud: bool;
    var cloudN: i32;
    var i_11: i32;
    var edgeFade: f32;
    var param_123: i32;
    var center_2: vec3<f32>;
    var param_124: i32;
    var radii_1: vec3<f32>;
    var param_125: i32;
    var oc_1: vec3<f32>;
    var rdn: vec3<f32>;
    var a_3: f32;
    var b_3: f32;
    var c_3: f32;
    var disc_1: f32;
    var sq_1: f32;
    var t0_: f32;
    var t1_1: f32;
    var clippedNear: f32;
    var clippedFar: f32;
    var cloudTHit: f32;
    var cloudColor: vec3<f32>;
    var param_126: vec3<f32>;
    var param_127: vec3<f32>;
    var param_128: vec3<f32>;
    var param_129: vec3<f32>;
    var param_130: f32;
    var param_131: f32;
    var param_132: f32;
    var param_133: vec3<f32>;
    var param_134: f32;
    var param_135: f32;
    var param_136: vec3<f32>;
    var halfDistMin: i32;
    var halfDistMax: i32;
    var boxMin_2: vec3<f32>;
    var boxMax_1: vec3<f32>;
    var cursorColor: vec3<f32>;
    var indexable_6: array<vec3<f32>, 20>;
    var sphereCenter: vec3<f32>;
    var sphereRadius: f32;
    var oc_2: vec3<f32>;
    var b_4: f32;
    var c_4: f32;
    var disc_2: f32;
    var sq_2: f32;
    var tNear_2: f32;
    var tFar_2: f32;
    var inside: bool;
    var cursorDist: f32;
    var shellNormal: vec3<f32>;
    var rim_1: f32;
    var alpha: f32;
    var cursorHit: vec2<f32>;
    var param_137: vec3<f32>;
    var param_138: vec3<f32>;
    var param_139: vec3<f32>;
    var param_140: vec3<f32>;
    var distFront: f32;
    var distBack: f32;
    var hitPosFront: vec3<f32>;
    var hitPosBack: vec3<f32>;
    var e: f32;
    var onFrontEdge: bool;
    var edgesFront: i32;
    var onBackEdge: bool;
    var edgesBack: i32;
    var phi_2895_: bool;
    var phi_2911_: bool;
    var phi_3127_: bool;
    var phi_3134_: bool;
    var phi_3142_: bool;
    var phi_3149_: bool;
    var phi_3159_: bool;
    var phi_3585_: bool;
    var phi_3976_: bool;
    var phi_3982_: bool;
    var phi_3991_: bool;
    var phi_3997_: bool;
    var phi_4006_: bool;
    var phi_4215_: bool;
    var phi_4257_: bool;
    var phi_4279_: bool;
    var phi_4301_: bool;
    var phi_4329_: bool;
    var phi_4351_: bool;
    var phi_4373_: bool;

    let _e482 = inUV_1;
    screenSpace = ((_e482 * 2f) - vec2(1f));
    let _e487 = screenSpace[1u];
    screenSpace[1u] = -(_e487);
    let _e491 = pc.camX;
    let _e493 = pc.camY;
    let _e495 = pc.camZ;
    baseOrigin = vec3<f32>(_e491, _e493, _e495);
    param_46 = vec3<f32>(0f, 0f, 1f);
    let _e497 = applyCameraRotation_u0028_vf3_u003b((&param_46));
    forward = _e497;
    param_47 = vec3<f32>(1f, 0f, 0f);
    let _e498 = applyCameraRotation_u0028_vf3_u003b((&param_47));
    right = _e498;
    param_48 = vec3<f32>(0f, 1f, 0f);
    let _e499 = applyCameraRotation_u0028_vf3_u003b((&param_48));
    up = _e499;
    let _e501 = pc.perspectiveBlend;
    t_3 = clamp(_e501, 0f, 1f);
    let _e503 = worldExtent_u0028_();
    cubeCenter = (_e503 * 0.5f);
    let _e505 = cubeCenter;
    let _e506 = baseOrigin;
    let _e508 = forward;
    viewDistance = max(1f, dot((_e505 - _e506), _e508));
    let _e511 = viewDistance;
    let _e513 = pc.fovDistance;
    orthoHalfSize = (_e511 / _e513);
    let _e516 = screenSpace[0u];
    let _e518 = screenSpace[1u];
    let _e520 = pc.fovDistance;
    let _e522 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e516, _e518, _e520), vec3(_e522));
    let _e525 = right;
    let _e527 = localDir[0u];
    let _e529 = up;
    let _e531 = localDir[1u];
    let _e534 = forward;
    let _e536 = localDir[2u];
    rayDir_3 = normalize((((_e525 * _e527) + (_e529 * _e531)) + (_e534 * _e536)));
    let _e540 = right;
    let _e542 = screenSpace[0u];
    let _e544 = up;
    let _e546 = screenSpace[1u];
    let _e549 = orthoHalfSize;
    let _e551 = t_3;
    originOffset = ((((_e540 * _e542) + (_e544 * _e546)) * _e549) * (1f - _e551));
    let _e554 = baseOrigin;
    let _e555 = originOffset;
    rayOrigin_3 = (_e554 + _e555);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e557 = worldExtent_u0028_();
    let _e558 = rayOrigin_3;
    param_49 = _e558;
    let _e559 = rayDir_3;
    param_50 = _e559;
    param_51 = vec3<f32>(0f, 0f, 0f);
    param_52 = _e557;
    let _e560 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_49), (&param_50), (&param_51), (&param_52));
    aabbHit = _e560;
    hitFrontBox = false;
    hitBackBox = false;
    let _e562 = aabbHit[0u];
    let _e564 = aabbHit[1u];
    let _e565 = (_e562 < _e564);
    phi_2895_ = _e565;
    if _e565 {
        let _e567 = aabbHit[1u];
        phi_2895_ = (_e567 > 0f);
    }
    let _e570 = phi_2895_;
    if _e570 {
        let _e572 = aabbHit[0u];
        let _e573 = (_e572 > 0f);
        phi_2911_ = _e573;
        if _e573 {
            let _e574 = rayOrigin_3;
            let _e575 = rayDir_3;
            let _e577 = aabbHit[0u];
            param_53 = (_e574 + (_e575 * _e577));
            let _e580 = isEdge_u0028_vf3_u003b((&param_53));
            phi_2911_ = _e580;
        }
        let _e582 = phi_2911_;
        if _e582 {
            hitFrontBox = true;
        }
        let _e583 = rayOrigin_3;
        let _e584 = rayDir_3;
        let _e586 = aabbHit[1u];
        param_54 = (_e583 + (_e584 * _e586));
        let _e589 = isEdge_u0028_vf3_u003b((&param_54));
        if _e589 {
            hitBackBox = true;
        }
    }
    let _e590 = marchCeiling_u0028_();
    ceilingY_1 = _e590;
    let _e592 = tuning.gridWidth;
    let _e595 = ceilingY_1;
    let _e598 = tuning.gridDepth;
    let _e602 = rayOrigin_3;
    param_55 = _e602;
    let _e603 = rayDir_3;
    param_56 = _e603;
    param_57 = vec3<f32>(0f, 0f, 0f);
    param_58 = vec3<f32>(f32(bitcast<i32>(_e592)), f32(_e595), f32(bitcast<i32>(_e598)));
    let _e604 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_55), (&param_56), (&param_57), (&param_58));
    marchHit = _e604;
    let _e605 = rayOrigin_3;
    let _e606 = rayDir_3;
    let _e608 = marchHit[0u];
    currentPos = (_e605 + (_e606 * max(0f, _e608)));
    let _e613 = marchHit[0u];
    if (_e613 > 0f) {
        let _e615 = rayDir_3;
        let _e617 = currentPos;
        currentPos = (_e617 + (_e615 * 0.001f));
    }
    let _e619 = currentPos;
    voxelPos_16 = vec3<i32>(floor(_e619));
    let _e622 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e622));
    let _e626 = rayDir_3[0u];
    if (_e626 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e629 = rayDir_3[0u];
        local_18 = abs((1f / _e629));
    }
    let _e632 = local_18;
    let _e634 = rayDir_3[1u];
    if (_e634 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e637 = rayDir_3[1u];
        local_19 = abs((1f / _e637));
    }
    let _e640 = local_19;
    let _e642 = rayDir_3[2u];
    if (_e642 == 0f) {
        local_20 = 100000000f;
    } else {
        let _e645 = rayDir_3[2u];
        local_20 = abs((1f / _e645));
    }
    let _e648 = local_20;
    tDelta_3 = vec3<f32>(_e632, _e640, _e648);
    let _e651 = stepDir_3[0u];
    if (_e651 > 0i) {
        let _e654 = currentPos[0u];
        let _e658 = currentPos[0u];
        let _e661 = tDelta_3[0u];
        local_21 = (((floor(_e654) + 1f) - _e658) * _e661);
    } else {
        let _e664 = currentPos[0u];
        let _e666 = currentPos[0u];
        let _e670 = tDelta_3[0u];
        local_21 = ((_e664 - floor(_e666)) * _e670);
    }
    let _e672 = local_21;
    let _e674 = stepDir_3[1u];
    if (_e674 > 0i) {
        let _e677 = currentPos[1u];
        let _e681 = currentPos[1u];
        let _e684 = tDelta_3[1u];
        local_22 = (((floor(_e677) + 1f) - _e681) * _e684);
    } else {
        let _e687 = currentPos[1u];
        let _e689 = currentPos[1u];
        let _e693 = tDelta_3[1u];
        local_22 = ((_e687 - floor(_e689)) * _e693);
    }
    let _e695 = local_22;
    let _e697 = stepDir_3[2u];
    if (_e697 > 0i) {
        let _e700 = currentPos[2u];
        let _e704 = currentPos[2u];
        let _e707 = tDelta_3[2u];
        local_23 = (((floor(_e700) + 1f) - _e704) * _e707);
    } else {
        let _e710 = currentPos[2u];
        let _e712 = currentPos[2u];
        let _e716 = tDelta_3[2u];
        local_23 = ((_e710 - floor(_e712)) * _e716);
    }
    let _e718 = local_23;
    tMax_4 = vec3<f32>(_e672, _e695, _e718);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e721 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e721 * 1.5f));
    i_9 = 0i;
    loop {
        let _e724 = i_9;
        let _e726 = tuning.marchMaxSteps;
        if (_e724 < bitcast<i32>(_e726)) {
            let _e730 = voxelPos_16[0u];
            let _e731 = (_e730 < 0i);
            phi_3127_ = _e731;
            if !(_e731) {
                let _e734 = voxelPos_16[0u];
                let _e736 = tuning.gridWidth;
                phi_3127_ = (_e734 >= bitcast<i32>(_e736));
            }
            let _e740 = phi_3127_;
            phi_3134_ = _e740;
            if !(_e740) {
                let _e743 = voxelPos_16[1u];
                phi_3134_ = (_e743 < 0i);
            }
            let _e746 = phi_3134_;
            phi_3142_ = _e746;
            if !(_e746) {
                let _e749 = voxelPos_16[1u];
                let _e750 = ceilingY_1;
                phi_3142_ = (_e749 >= _e750);
            }
            let _e753 = phi_3142_;
            phi_3149_ = _e753;
            if !(_e753) {
                let _e756 = voxelPos_16[2u];
                phi_3149_ = (_e756 < 0i);
            }
            let _e759 = phi_3149_;
            phi_3159_ = _e759;
            if !(_e759) {
                let _e762 = voxelPos_16[2u];
                let _e764 = tuning.gridDepth;
                phi_3159_ = (_e762 >= bitcast<i32>(_e764));
            }
            let _e768 = phi_3159_;
            if _e768 {
                break;
            }
            let _e769 = voxelPos_16;
            param_59 = _e769;
            let _e770 = getVoxel_u0028_vi3_u003b((&param_59));
            rawVoxel_5 = _e770;
            let _e771 = rawVoxel_5;
            hitType = (_e771 & 255u);
            let _e773 = hitType;
            if (_e773 == 7u) {
                hitType = 0u;
            }
            let _e775 = hitType;
            if (_e775 != 0u) {
                let _e777 = hitType;
                if (_e777 == 6u) {
                    let _e779 = rawVoxel_5;
                    age_1 = ((_e779 >> bitcast<u32>(24i)) & 255u);
                    let _e783 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e783) / 100f), 0f, 1f));
                    let _e788 = inUV_1;
                    let _e790 = pc.time;
                    dither = fract((sin(dot((_e788 + vec2((_e790 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e798 = dither;
                    let _e799 = targetAlpha;
                    if (_e798 > _e799) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e801 = rawVoxel_5;
                        hitRawVoxel = _e801;
                        break;
                    }
                } else {
                    let _e802 = hitType;
                    param_60 = _e802;
                    let _e803 = isLocustType_u0028_u1_u003b((&param_60));
                    let _e804 = hitType;
                    if (_e803 || (_e804 == 18u)) {
                        let _e807 = hitType;
                        kind_2 = select(0u, 1u, (_e807 == 18u));
                        let _e810 = voxelPos_16;
                        param_61 = _e810;
                        let _e811 = rayOrigin_3;
                        param_62 = _e811;
                        let _e812 = rayDir_3;
                        param_63 = _e812;
                        let _e813 = kind_2;
                        param_64 = _e813;
                        let _e814 = hitType;
                        param_65 = _e814;
                        let _e815 = normal_4;
                        param_66 = _e815;
                        let _e816 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_61), (&param_62), (&param_63), (&param_64), (&param_65), (&param_66), (&param_67), (&param_68), (&param_69));
                        let _e817 = param_67;
                        subT = _e817;
                        let _e818 = param_68;
                        subNormal_1 = _e818;
                        let _e819 = param_69;
                        subCell_3 = _e819;
                        if _e816 {
                            hit = true;
                            let _e820 = rawVoxel_5;
                            hitRawVoxel = _e820;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e821 = rawVoxel_5;
                        hitRawVoxel = _e821;
                        break;
                    }
                }
            }
            let _e823 = tMax_4[0u];
            let _e825 = tMax_4[1u];
            if (_e823 < _e825) {
                let _e828 = tMax_4[0u];
                let _e830 = tMax_4[2u];
                if (_e828 < _e830) {
                    let _e833 = stepDir_3[0u];
                    let _e835 = voxelPos_16[0u];
                    voxelPos_16[0u] = (_e835 + _e833);
                    let _e839 = tDelta_3[0u];
                    let _e841 = tMax_4[0u];
                    tMax_4[0u] = (_e841 + _e839);
                    let _e845 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e845)), 0f, 0f);
                } else {
                    let _e850 = stepDir_3[2u];
                    let _e852 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e852 + _e850);
                    let _e856 = tDelta_3[2u];
                    let _e858 = tMax_4[2u];
                    tMax_4[2u] = (_e858 + _e856);
                    let _e862 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e862)));
                }
            } else {
                let _e867 = tMax_4[1u];
                let _e869 = tMax_4[2u];
                if (_e867 < _e869) {
                    let _e872 = stepDir_3[1u];
                    let _e874 = voxelPos_16[1u];
                    voxelPos_16[1u] = (_e874 + _e872);
                    let _e878 = tDelta_3[1u];
                    let _e880 = tMax_4[1u];
                    tMax_4[1u] = (_e880 + _e878);
                    let _e884 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e884)), 0f);
                } else {
                    let _e889 = stepDir_3[2u];
                    let _e891 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e891 + _e889);
                    let _e895 = tDelta_3[2u];
                    let _e897 = tMax_4[2u];
                    tMax_4[2u] = (_e897 + _e895);
                    let _e901 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e901)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e905 = i_9;
            i_9 = (_e905 + 1i);
        }
    }
    let _e907 = hit;
    if _e907 {
        let _e908 = normal_4;
        if (length(_e908) < 0.1f) {
            let _e911 = rayDir_3;
            normal_4 = -(_e911);
        }
        let _e913 = normal_4;
        ddaNormal_1 = _e913;
        let _e914 = hitType;
        if (_e914 == 2u) {
            let _e916 = voxelPos_16;
            param_70 = _e916;
            let _e917 = getWaterNormal_u0028_vi3_u003b((&param_70));
            param_71 = _e917;
            let _e918 = voxelPos_16;
            param_72 = _e918;
            let _e919 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_71), (&param_72));
            normal_4 = _e919;
        } else {
            let _e920 = hitType;
            param_73 = _e920;
            let _e921 = isLocustType_u0028_u1_u003b((&param_73));
            let _e922 = hitType;
            if (_e921 || (_e922 == 18u)) {
                let _e925 = subNormal_1;
                normal_4 = _e925;
            } else {
                let _e926 = voxelPos_16;
                param_74 = _e926;
                let _e927 = getSmoothNormal_u0028_vi3_u003b((&param_74));
                normal_4 = _e927;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e928 = normal_4;
        let _e929 = sunDir_2;
        diffuse_1 = max(dot(_e928, _e929), 0f);
        let _e932 = voxelPos_16;
        param_75 = _e932;
        let _e933 = ddaNormal_1;
        param_76 = _e933;
        let _e934 = sunDir_2;
        param_77 = _e934;
        let _e935 = ceilingY_1;
        param_78 = _e935;
        let _e936 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_75), (&param_76), (&param_77), (&param_78));
        shadow_1 = _e936;
        let _e937 = ambientColor;
        let _e938 = sunColor_1;
        let _e939 = diffuse_1;
        let _e941 = shadow_1;
        baseLighting_9 = (_e937 + ((_e938 * _e939) * _e941));
        let _e944 = baseLighting_9;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e944);
        let _e946 = hitType;
        switch bitcast<i32>(_e946) {
            case 1: {
                let _e948 = hitRawVoxel;
                param_79 = _e948;
                let _e949 = baseLighting_9;
                param_80 = _e949;
                let _e950 = renderSand_u0028_u1_u003b_vf3_u003b((&param_79), (&param_80));
                finalVoxelColor = _e950;
                break;
            }
            case 2: {
                let _e951 = voxelPos_16;
                param_81 = _e951;
                let _e952 = normal_4;
                param_82 = _e952;
                let _e953 = rayOrigin_3;
                param_83 = _e953;
                let _e954 = sunDir_2;
                param_84 = _e954;
                let _e955 = sunColor_1;
                param_85 = _e955;
                let _e956 = shadow_1;
                param_86 = _e956;
                let _e957 = baseLighting_9;
                param_87 = _e957;
                let _e958 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_81), (&param_82), (&param_83), (&param_84), (&param_85), (&param_86), (&param_87));
                finalVoxelColor = _e958;
                break;
            }
            case 3: {
                let _e959 = voxelPos_16;
                param_88 = _e959;
                let _e960 = baseLighting_9;
                param_89 = _e960;
                let _e961 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_88), (&param_89));
                finalVoxelColor = _e961;
                break;
            }
            case 4: {
                let _e962 = hitRawVoxel;
                param_90 = _e962;
                let _e963 = voxelPos_16;
                param_91 = _e963;
                let _e964 = ddaNormal_1;
                param_92 = _e964;
                let _e965 = baseLighting_9;
                param_93 = _e965;
                let _e966 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_90), (&param_91), (&param_92), (&param_93));
                finalVoxelColor = _e966;
                break;
            }
            case 5: {
                let _e967 = hitRawVoxel;
                param_94 = _e967;
                let _e968 = voxelPos_16;
                param_95 = _e968;
                let _e969 = renderFire_u0028_u1_u003b_vi3_u003b((&param_94), (&param_95));
                finalVoxelColor = _e969;
                break;
            }
            case 6: {
                let _e970 = voxelPos_16;
                param_96 = _e970;
                let _e971 = baseLighting_9;
                param_97 = _e971;
                let _e972 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_96), (&param_97));
                finalVoxelColor = _e972;
                break;
            }
            case 9, 10, 11, 8: {
                let _e973 = hitRawVoxel;
                param_98 = _e973;
                let _e974 = voxelPos_16;
                param_99 = _e974;
                let _e975 = renderLava_u0028_u1_u003b_vi3_u003b((&param_98), (&param_99));
                finalVoxelColor = _e975;
                break;
            }
            case 12: {
                let _e976 = voxelPos_16;
                param_100 = _e976;
                let _e977 = baseLighting_9;
                param_101 = _e977;
                let _e978 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_100), (&param_101));
                finalVoxelColor = _e978;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e979 = voxelPos_16;
                param_102 = _e979;
                let _e980 = subCell_3;
                param_103 = _e980;
                let _e981 = baseLighting_9;
                param_104 = _e981;
                let _e982 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_102), (&param_103), (&param_104));
                finalVoxelColor = _e982;
                break;
            }
            case 18: {
                let _e983 = voxelPos_16;
                param_105 = _e983;
                let _e984 = subCell_3;
                param_106 = _e984;
                let _e985 = baseLighting_9;
                param_107 = _e985;
                let _e986 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_105), (&param_106), (&param_107));
                finalVoxelColor = _e986;
                break;
            }
            case 19: {
                let _e987 = hitRawVoxel;
                param_108 = _e987;
                let _e988 = voxelPos_16;
                param_109 = _e988;
                let _e989 = baseLighting_9;
                param_110 = _e989;
                let _e990 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_108), (&param_109), (&param_110));
                finalVoxelColor = _e990;
                break;
            }
            default: {
                break;
            }
        }
        let _e991 = finalVoxelColor;
        param_111 = _e991;
        let _e992 = voxelPos_16;
        param_112 = _e992;
        let _e993 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_111), (&param_112));
        finalVoxelColor = _e993;
        let _e994 = hitType;
        param_113 = _e994;
        let _e995 = isLocustType_u0028_u1_u003b((&param_113));
        let _e996 = hitType;
        if (_e995 || (_e996 == 18u)) {
            let _e999 = subT;
            local_24 = _e999;
        } else {
            let _e1000 = voxelPos_16;
            let _e1003 = rayOrigin_3;
            local_24 = length(((vec3<f32>(_e1000) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e1003));
        }
        let _e1006 = local_24;
        distanceTraveled = _e1006;
        let _e1007 = distanceTraveled;
        let _e1008 = MAX_VISIBILITY;
        let _e1012 = finalVoxelColor;
        finalVoxelColor = (_e1012 * mix(1f, 0f, clamp((_e1007 / _e1008), 0f, 1f)));
        let _e1014 = distanceTraveled;
        finalDist = _e1014;
        let _e1015 = finalVoxelColor;
        finalColor = vec4<f32>(_e1015.x, _e1015.y, _e1015.z, 1f);
    } else {
        let _e1020 = hitBackBox;
        if _e1020 {
            let _e1022 = aabbHit[1u];
            finalDist = _e1022;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1024 = unnamed.blackHoleCount;
    if (_e1024 > 0u) {
        seenHoles = 0u;
        i_10 = 0i;
        loop {
            let _e1026 = i_10;
            let _e1027 = (_e1026 < 8i);
            phi_3585_ = _e1027;
            if _e1027 {
                let _e1028 = seenHoles;
                let _e1030 = unnamed.blackHoleCount;
                phi_3585_ = (_e1028 < _e1030);
            }
            let _e1033 = phi_3585_;
            if _e1033 {
                let _e1034 = i_10;
                let _e1037 = unnamed.blackHoles[_e1034];
                code_2 = _e1037;
                let _e1038 = code_2;
                if (_e1038 == 0u) {
                    continue;
                }
                let _e1040 = seenHoles;
                seenHoles = (_e1040 + bitcast<u32>(1i));
                let _e1043 = code_2;
                if ((_e1043 & 1073741824u) != 0u) {
                    let _e1047 = tuning.purgeLevel;
                    let _e1049 = i_10;
                    let _e1052 = unnamed.blackHoleMass[_e1049];
                    let _e1055 = tuning.purgeMass;
                    local_25 = u32((f32(_e1047) * clamp((f32(_e1052) / f32(max(_e1055, 1u))), 0f, 1f)));
                } else {
                    let _e1062 = i_10;
                    let _e1065 = unnamed.blackHoleMass[_e1062];
                    param_114 = _e1065;
                    let _e1066 = bhLevel_u0028_u1_u003b((&param_114));
                    local_25 = _e1066;
                }
                let _e1067 = local_25;
                bodyLevel = _e1067;
                let _e1068 = bodyLevel;
                param_115 = _e1068;
                let _e1069 = bhBodyRadius_u0028_u1_u003b((&param_115));
                bodyRadius = _e1069;
                let _e1070 = code_2;
                param_116 = _e1070;
                let _e1071 = bhDecode_u0028_u1_u003b((&param_116));
                center_1 = (vec3<f32>(_e1071) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1074 = rayOrigin_3;
                let _e1075 = center_1;
                oc = (_e1074 - _e1075);
                let _e1077 = oc;
                let _e1078 = rayDir_3;
                b_2 = dot(_e1077, _e1078);
                let _e1080 = oc;
                let _e1081 = oc;
                let _e1083 = bodyRadius;
                let _e1084 = bodyRadius;
                c_2 = (dot(_e1080, _e1081) - (_e1083 * _e1084));
                let _e1087 = b_2;
                let _e1088 = b_2;
                let _e1090 = c_2;
                disc = ((_e1087 * _e1088) - _e1090);
                let _e1092 = disc;
                if (_e1092 <= 0f) {
                    continue;
                }
                let _e1094 = disc;
                sq = sqrt(_e1094);
                let _e1096 = b_2;
                let _e1098 = sq;
                tNear_1 = (-(_e1096) - _e1098);
                let _e1100 = b_2;
                let _e1102 = sq;
                tFar_1 = (-(_e1100) + _e1102);
                let _e1104 = tFar_1;
                if (_e1104 <= 0f) {
                    continue;
                }
                let _e1106 = tNear_1;
                bodyDist = max(0f, _e1106);
                let _e1108 = bodyDist;
                let _e1109 = finalDist;
                if (_e1108 < _e1109) {
                    let _e1111 = rayOrigin_3;
                    let _e1112 = rayDir_3;
                    let _e1113 = bodyDist;
                    let _e1116 = center_1;
                    surfaceNormal = normalize(((_e1111 + (_e1112 * _e1113)) - _e1116));
                    let _e1119 = surfaceNormal;
                    param_117 = _e1119;
                    let _e1120 = rayDir_3;
                    param_118 = _e1120;
                    let _e1121 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_117), (&param_118));
                    bodyColor = _e1121;
                    let _e1122 = bodyDist;
                    let _e1123 = MAX_VISIBILITY;
                    let _e1127 = bodyColor;
                    bodyColor = (_e1127 * mix(1f, 0f, clamp((_e1122 / _e1123), 0f, 1f)));
                    let _e1129 = bodyColor;
                    finalColor = vec4<f32>(_e1129.x, _e1129.y, _e1129.z, 1f);
                    let _e1134 = bodyDist;
                    finalDist = _e1134;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1135 = i_10;
                i_10 = (_e1135 + 1i);
            }
        }
    }
    let _e1138 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1138), 0f, 1f);
    let _e1142 = tuning.cloudMinAlpha;
    let _e1144 = tuning.cloudMaxAlpha;
    let _e1145 = charge;
    groupAlpha = mix(_e1142, _e1144, _e1145);
    let _e1147 = charge;
    cloudGreyness = _e1147;
    let _e1149 = unnamed.rainPhase;
    if (_e1149 == 1u) {
        let _e1152 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1152);
        let _e1154 = charge;
        let _e1156 = pc.time;
        let _e1157 = crossedTime;
        let _e1160 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1154, clamp(((_e1156 - _e1157) / _e1160), 0f, 1f));
    } else {
        let _e1165 = unnamed.rainPhase;
        if (_e1165 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1167 = groupAlpha;
    if (_e1167 > 0.002f) {
        let _e1170 = tuning.gridWidth;
        let _e1174 = tuning.gridDepth;
        let _e1178 = rayOrigin_3;
        param_119 = _e1178;
        let _e1179 = rayDir_3;
        param_120 = _e1179;
        param_121 = vec3<f32>(0f, -1000000f, 0f);
        param_122 = vec3<f32>(f32(bitcast<i32>(_e1170)), 1000000f, f32(bitcast<i32>(_e1174)));
        let _e1180 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_119), (&param_120), (&param_121), (&param_122));
        footprintClip = _e1180;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1182 = tuning.cloudCount;
        cloudN = bitcast<i32>(min(_e1182, 64u));
        i_11 = 0i;
        loop {
            let _e1185 = i_11;
            let _e1186 = cloudN;
            if (_e1185 < _e1186) {
                let _e1188 = i_11;
                param_123 = _e1188;
                let _e1189 = cloudFade_u0028_i1_u003b((&param_123));
                edgeFade = _e1189;
                let _e1190 = edgeFade;
                if (_e1190 <= 0.01f) {
                    continue;
                }
                let _e1192 = i_11;
                param_124 = _e1192;
                let _e1193 = cloudCenter_u0028_i1_u003b((&param_124));
                center_2 = _e1193;
                let _e1194 = i_11;
                param_125 = _e1194;
                let _e1195 = cloudRadii_u0028_i1_u003b((&param_125));
                radii_1 = _e1195;
                let _e1196 = rayOrigin_3;
                let _e1197 = center_2;
                let _e1199 = radii_1;
                oc_1 = ((_e1196 - _e1197) / _e1199);
                let _e1201 = rayDir_3;
                let _e1202 = radii_1;
                rdn = (_e1201 / _e1202);
                let _e1204 = rdn;
                let _e1205 = rdn;
                a_3 = dot(_e1204, _e1205);
                let _e1207 = oc_1;
                let _e1208 = rdn;
                b_3 = dot(_e1207, _e1208);
                let _e1210 = oc_1;
                let _e1211 = oc_1;
                c_3 = (dot(_e1210, _e1211) - 1f);
                let _e1214 = b_3;
                let _e1215 = b_3;
                let _e1217 = a_3;
                let _e1218 = c_3;
                disc_1 = ((_e1214 * _e1215) - (_e1217 * _e1218));
                let _e1221 = disc_1;
                if (_e1221 > 0f) {
                    let _e1223 = disc_1;
                    sq_1 = sqrt(_e1223);
                    let _e1225 = b_3;
                    let _e1227 = sq_1;
                    let _e1229 = a_3;
                    t0_ = ((-(_e1225) - _e1227) / _e1229);
                    let _e1231 = b_3;
                    let _e1233 = sq_1;
                    let _e1235 = a_3;
                    t1_1 = ((-(_e1231) + _e1233) / _e1235);
                    let _e1237 = t0_;
                    let _e1239 = footprintClip[0u];
                    clippedNear = max(_e1237, _e1239);
                    let _e1241 = t1_1;
                    let _e1243 = footprintClip[1u];
                    clippedFar = min(_e1241, _e1243);
                    let _e1245 = clippedNear;
                    let _e1246 = bestT;
                    let _e1247 = finalDist;
                    if (_e1245 >= min(_e1246, _e1247)) {
                        continue;
                    }
                    let _e1250 = clippedNear;
                    let _e1251 = clippedFar;
                    let _e1253 = clippedFar;
                    if ((_e1250 < _e1251) && (_e1253 > 0f)) {
                        let _e1256 = i_11;
                        let _e1258 = rayOrigin_3;
                        param_126 = _e1258;
                        let _e1259 = rayDir_3;
                        param_127 = _e1259;
                        let _e1260 = center_2;
                        param_128 = _e1260;
                        let _e1261 = radii_1;
                        param_129 = _e1261;
                        param_130 = f32(_e1256);
                        let _e1262 = clippedNear;
                        param_131 = _e1262;
                        let _e1263 = clippedFar;
                        param_132 = _e1263;
                        let _e1264 = cloudSunDir;
                        param_133 = _e1264;
                        let _e1265 = cloudGreyness;
                        param_134 = _e1265;
                        let _e1266 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b((&param_126), (&param_127), (&param_128), (&param_129), (&param_130), (&param_131), (&param_132), (&param_133), (&param_134), (&param_135), (&param_136));
                        let _e1267 = param_135;
                        cloudTHit = _e1267;
                        let _e1268 = param_136;
                        cloudColor = _e1268;
                        if _e1266 {
                            let _e1269 = cloudTHit;
                            let _e1271 = cloudTHit;
                            let _e1272 = bestT;
                            if ((_e1269 > 0f) && (_e1271 < _e1272)) {
                                let _e1275 = cloudTHit;
                                bestT = _e1275;
                                let _e1276 = cloudColor;
                                bestColor = _e1276;
                                let _e1277 = groupAlpha;
                                let _e1278 = edgeFade;
                                bestAlpha = clamp((_e1277 * _e1278), 0f, 0.95f);
                                foundCloud = true;
                            }
                        }
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1281 = i_11;
                i_11 = (_e1281 + 1i);
            }
        }
        let _e1283 = foundCloud;
        let _e1284 = bestT;
        let _e1285 = finalDist;
        if (_e1283 && (_e1284 < _e1285)) {
            let _e1288 = finalColor;
            let _e1290 = bestColor;
            let _e1291 = bestAlpha;
            let _e1293 = mix(_e1288.xyz, _e1290, vec3(_e1291));
            finalColor[0u] = _e1293.x;
            finalColor[1u] = _e1293.y;
            finalColor[2u] = _e1293.z;
        }
    }
    let _e1301 = pc.spawnX;
    let _e1302 = (_e1301 >= 0i);
    phi_3976_ = _e1302;
    if _e1302 {
        let _e1304 = pc.spawnX;
        let _e1306 = tuning.gridWidth;
        phi_3976_ = (_e1304 < bitcast<i32>(_e1306));
    }
    let _e1310 = phi_3976_;
    phi_3982_ = _e1310;
    if _e1310 {
        let _e1312 = pc.spawnY;
        phi_3982_ = (_e1312 >= 0i);
    }
    let _e1315 = phi_3982_;
    phi_3991_ = _e1315;
    if _e1315 {
        let _e1317 = pc.spawnY;
        let _e1319 = tuning.gridHeight;
        phi_3991_ = (_e1317 < bitcast<i32>(_e1319));
    }
    let _e1323 = phi_3991_;
    phi_3997_ = _e1323;
    if _e1323 {
        let _e1325 = pc.spawnZ;
        phi_3997_ = (_e1325 >= 0i);
    }
    let _e1328 = phi_3997_;
    phi_4006_ = _e1328;
    if _e1328 {
        let _e1330 = pc.spawnZ;
        let _e1332 = tuning.gridDepth;
        phi_4006_ = (_e1330 < bitcast<i32>(_e1332));
    }
    let _e1336 = phi_4006_;
    if _e1336 {
        let _e1338 = pc.spawnSize;
        halfDistMin = (_e1338 / 2i);
        let _e1341 = pc.spawnSize;
        halfDistMax = ((_e1341 - 1i) / 2i);
        let _e1345 = pc.spawnX;
        let _e1346 = halfDistMin;
        let _e1350 = pc.spawnY;
        let _e1351 = halfDistMin;
        let _e1355 = pc.spawnZ;
        let _e1356 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1345 - _e1346)), f32((_e1350 - _e1351)), f32((_e1355 - _e1356)));
        let _e1361 = pc.spawnX;
        let _e1362 = halfDistMax;
        let _e1367 = pc.spawnY;
        let _e1368 = halfDistMax;
        let _e1373 = pc.spawnZ;
        let _e1374 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1361 + _e1362) + 1i)), f32(((_e1367 + _e1368) + 1i)), f32(((_e1373 + _e1374) + 1i)));
        let _e1380 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1383 = indexable_6[clamp(_e1380, 0i, 19i)];
        cursorColor = _e1383;
        let _e1385 = pc.spawnShape;
        if (_e1385 == 1i) {
            let _e1387 = boxMin_2;
            let _e1388 = boxMax_1;
            sphereCenter = ((_e1387 + _e1388) * 0.5f);
            let _e1392 = pc.spawnSize;
            sphereRadius = (f32(_e1392) * 0.5f);
            let _e1395 = rayOrigin_3;
            let _e1396 = sphereCenter;
            oc_2 = (_e1395 - _e1396);
            let _e1398 = oc_2;
            let _e1399 = rayDir_3;
            b_4 = dot(_e1398, _e1399);
            let _e1401 = oc_2;
            let _e1402 = oc_2;
            let _e1404 = sphereRadius;
            let _e1405 = sphereRadius;
            c_4 = (dot(_e1401, _e1402) - (_e1404 * _e1405));
            let _e1408 = b_4;
            let _e1409 = b_4;
            let _e1411 = c_4;
            disc_2 = ((_e1408 * _e1409) - _e1411);
            let _e1413 = disc_2;
            if (_e1413 > 0f) {
                let _e1415 = disc_2;
                sq_2 = sqrt(_e1415);
                let _e1417 = b_4;
                let _e1419 = sq_2;
                tNear_2 = (-(_e1417) - _e1419);
                let _e1421 = b_4;
                let _e1423 = sq_2;
                tFar_2 = (-(_e1421) + _e1423);
                let _e1425 = tFar_2;
                if (_e1425 > 0f) {
                    let _e1427 = tNear_2;
                    inside = (_e1427 <= 0f);
                    let _e1429 = inside;
                    let _e1430 = tFar_2;
                    let _e1431 = tNear_2;
                    cursorDist = select(_e1431, _e1430, _e1429);
                    let _e1433 = rayOrigin_3;
                    let _e1434 = rayDir_3;
                    let _e1435 = cursorDist;
                    let _e1438 = sphereCenter;
                    shellNormal = normalize(((_e1433 + (_e1434 * _e1435)) - _e1438));
                    let _e1441 = shellNormal;
                    let _e1442 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1441, _e1442)));
                    let _e1446 = rim_1;
                    let _e1449 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1446)) * select(1f, 0.35f, _e1449));
                    let _e1452 = cursorDist;
                    let _e1453 = finalDist;
                    if (_e1452 < _e1453) {
                        let _e1455 = finalColor;
                        let _e1457 = cursorColor;
                        let _e1458 = alpha;
                        let _e1460 = mix(_e1455.xyz, _e1457, vec3(_e1458));
                        finalColor[0u] = _e1460.x;
                        finalColor[1u] = _e1460.y;
                        finalColor[2u] = _e1460.z;
                    }
                }
            }
        } else {
            let _e1467 = rayOrigin_3;
            param_137 = _e1467;
            let _e1468 = rayDir_3;
            param_138 = _e1468;
            let _e1469 = boxMin_2;
            param_139 = _e1469;
            let _e1470 = boxMax_1;
            param_140 = _e1470;
            let _e1471 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_137), (&param_138), (&param_139), (&param_140));
            cursorHit = _e1471;
            let _e1473 = cursorHit[0u];
            let _e1475 = cursorHit[1u];
            let _e1476 = (_e1473 < _e1475);
            phi_4215_ = _e1476;
            if _e1476 {
                let _e1478 = cursorHit[1u];
                phi_4215_ = (_e1478 > 0f);
            }
            let _e1481 = phi_4215_;
            if _e1481 {
                let _e1483 = cursorHit[0u];
                distFront = max(0f, _e1483);
                let _e1486 = cursorHit[1u];
                distBack = _e1486;
                let _e1487 = rayOrigin_3;
                let _e1488 = rayDir_3;
                let _e1489 = distFront;
                hitPosFront = (_e1487 + (_e1488 * _e1489));
                let _e1492 = rayOrigin_3;
                let _e1493 = rayDir_3;
                let _e1494 = distBack;
                hitPosBack = (_e1492 + (_e1493 * _e1494));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1498 = hitPosFront[0u];
                let _e1500 = boxMin_2[0u];
                let _e1501 = e;
                let _e1503 = (_e1498 < (_e1500 + _e1501));
                phi_4257_ = _e1503;
                if !(_e1503) {
                    let _e1506 = hitPosFront[0u];
                    let _e1508 = boxMax_1[0u];
                    let _e1509 = e;
                    phi_4257_ = (_e1506 > (_e1508 - _e1509));
                }
                let _e1513 = phi_4257_;
                if _e1513 {
                    let _e1514 = edgesFront;
                    edgesFront = (_e1514 + 1i);
                }
                let _e1517 = hitPosFront[1u];
                let _e1519 = boxMin_2[1u];
                let _e1520 = e;
                let _e1522 = (_e1517 < (_e1519 + _e1520));
                phi_4279_ = _e1522;
                if !(_e1522) {
                    let _e1525 = hitPosFront[1u];
                    let _e1527 = boxMax_1[1u];
                    let _e1528 = e;
                    phi_4279_ = (_e1525 > (_e1527 - _e1528));
                }
                let _e1532 = phi_4279_;
                if _e1532 {
                    let _e1533 = edgesFront;
                    edgesFront = (_e1533 + 1i);
                }
                let _e1536 = hitPosFront[2u];
                let _e1538 = boxMin_2[2u];
                let _e1539 = e;
                let _e1541 = (_e1536 < (_e1538 + _e1539));
                phi_4301_ = _e1541;
                if !(_e1541) {
                    let _e1544 = hitPosFront[2u];
                    let _e1546 = boxMax_1[2u];
                    let _e1547 = e;
                    phi_4301_ = (_e1544 > (_e1546 - _e1547));
                }
                let _e1551 = phi_4301_;
                if _e1551 {
                    let _e1552 = edgesFront;
                    edgesFront = (_e1552 + 1i);
                }
                let _e1554 = edgesFront;
                if (_e1554 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1557 = hitPosBack[0u];
                let _e1559 = boxMin_2[0u];
                let _e1560 = e;
                let _e1562 = (_e1557 < (_e1559 + _e1560));
                phi_4329_ = _e1562;
                if !(_e1562) {
                    let _e1565 = hitPosBack[0u];
                    let _e1567 = boxMax_1[0u];
                    let _e1568 = e;
                    phi_4329_ = (_e1565 > (_e1567 - _e1568));
                }
                let _e1572 = phi_4329_;
                if _e1572 {
                    let _e1573 = edgesBack;
                    edgesBack = (_e1573 + 1i);
                }
                let _e1576 = hitPosBack[1u];
                let _e1578 = boxMin_2[1u];
                let _e1579 = e;
                let _e1581 = (_e1576 < (_e1578 + _e1579));
                phi_4351_ = _e1581;
                if !(_e1581) {
                    let _e1584 = hitPosBack[1u];
                    let _e1586 = boxMax_1[1u];
                    let _e1587 = e;
                    phi_4351_ = (_e1584 > (_e1586 - _e1587));
                }
                let _e1591 = phi_4351_;
                if _e1591 {
                    let _e1592 = edgesBack;
                    edgesBack = (_e1592 + 1i);
                }
                let _e1595 = hitPosBack[2u];
                let _e1597 = boxMin_2[2u];
                let _e1598 = e;
                let _e1600 = (_e1595 < (_e1597 + _e1598));
                phi_4373_ = _e1600;
                if !(_e1600) {
                    let _e1603 = hitPosBack[2u];
                    let _e1605 = boxMax_1[2u];
                    let _e1606 = e;
                    phi_4373_ = (_e1603 > (_e1605 - _e1606));
                }
                let _e1610 = phi_4373_;
                if _e1610 {
                    let _e1611 = edgesBack;
                    edgesBack = (_e1611 + 1i);
                }
                let _e1613 = edgesBack;
                if (_e1613 >= 2i) {
                    onBackEdge = true;
                }
                let _e1615 = onFrontEdge;
                let _e1616 = distFront;
                let _e1617 = finalDist;
                if (_e1615 && (_e1616 < _e1617)) {
                    let _e1620 = finalColor;
                    let _e1622 = cursorColor;
                    let _e1624 = mix(_e1620.xyz, _e1622, vec3(0.9f));
                    finalColor[0u] = _e1624.x;
                    finalColor[1u] = _e1624.y;
                    finalColor[2u] = _e1624.z;
                } else {
                    let _e1631 = onBackEdge;
                    let _e1632 = distBack;
                    let _e1633 = finalDist;
                    if (_e1631 && (_e1632 < _e1633)) {
                        let _e1636 = finalColor;
                        let _e1638 = cursorColor;
                        let _e1640 = mix(_e1636.xyz, _e1638, vec3(0.2f));
                        finalColor[0u] = _e1640.x;
                        finalColor[1u] = _e1640.y;
                        finalColor[2u] = _e1640.z;
                    } else {
                        let _e1647 = distFront;
                        let _e1648 = finalDist;
                        if (_e1647 < _e1648) {
                            let _e1650 = finalColor;
                            let _e1652 = cursorColor;
                            let _e1654 = mix(_e1650.xyz, _e1652, vec3(0.15f));
                            finalColor[0u] = _e1654.x;
                            finalColor[1u] = _e1654.y;
                            finalColor[2u] = _e1654.z;
                        }
                    }
                }
            }
        }
    }
    let _e1661 = hitFrontBox;
    if _e1661 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1662 = finalColor;
    outColor = _e1662;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
