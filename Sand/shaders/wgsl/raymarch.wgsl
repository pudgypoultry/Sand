// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 0d0054241018f22b7cd4c20db6e41bf6490162186ad43a32ec796a875e590be3

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
    renderScale: f32,
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
    aspectScaleX: f32,
    aspectScaleY: f32,
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
    var phi_2908_: bool;
    var phi_2924_: bool;
    var phi_3140_: bool;
    var phi_3147_: bool;
    var phi_3155_: bool;
    var phi_3162_: bool;
    var phi_3172_: bool;
    var phi_3598_: bool;
    var phi_3988_: bool;
    var phi_3994_: bool;
    var phi_4003_: bool;
    var phi_4009_: bool;
    var phi_4018_: bool;
    var phi_4227_: bool;
    var phi_4269_: bool;
    var phi_4291_: bool;
    var phi_4313_: bool;
    var phi_4341_: bool;
    var phi_4363_: bool;
    var phi_4385_: bool;

    let _e482 = inUV_1;
    screenSpace = ((_e482 * 2f) - vec2(1f));
    let _e487 = screenSpace[1u];
    screenSpace[1u] = -(_e487);
    let _e491 = pc.aspectScaleX;
    let _e493 = screenSpace[0u];
    screenSpace[0u] = (_e493 * _e491);
    let _e497 = pc.aspectScaleY;
    let _e499 = screenSpace[1u];
    screenSpace[1u] = (_e499 * _e497);
    let _e503 = pc.camX;
    let _e505 = pc.camY;
    let _e507 = pc.camZ;
    baseOrigin = vec3<f32>(_e503, _e505, _e507);
    param_46 = vec3<f32>(0f, 0f, 1f);
    let _e509 = applyCameraRotation_u0028_vf3_u003b((&param_46));
    forward = _e509;
    param_47 = vec3<f32>(1f, 0f, 0f);
    let _e510 = applyCameraRotation_u0028_vf3_u003b((&param_47));
    right = _e510;
    param_48 = vec3<f32>(0f, 1f, 0f);
    let _e511 = applyCameraRotation_u0028_vf3_u003b((&param_48));
    up = _e511;
    let _e513 = pc.perspectiveBlend;
    t_3 = clamp(_e513, 0f, 1f);
    let _e515 = worldExtent_u0028_();
    cubeCenter = (_e515 * 0.5f);
    let _e517 = cubeCenter;
    let _e518 = baseOrigin;
    let _e520 = forward;
    viewDistance = max(1f, dot((_e517 - _e518), _e520));
    let _e523 = viewDistance;
    let _e525 = pc.fovDistance;
    orthoHalfSize = (_e523 / _e525);
    let _e528 = screenSpace[0u];
    let _e530 = screenSpace[1u];
    let _e532 = pc.fovDistance;
    let _e534 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e528, _e530, _e532), vec3(_e534));
    let _e537 = right;
    let _e539 = localDir[0u];
    let _e541 = up;
    let _e543 = localDir[1u];
    let _e546 = forward;
    let _e548 = localDir[2u];
    rayDir_3 = normalize((((_e537 * _e539) + (_e541 * _e543)) + (_e546 * _e548)));
    let _e552 = right;
    let _e554 = screenSpace[0u];
    let _e556 = up;
    let _e558 = screenSpace[1u];
    let _e561 = orthoHalfSize;
    let _e563 = t_3;
    originOffset = ((((_e552 * _e554) + (_e556 * _e558)) * _e561) * (1f - _e563));
    let _e566 = baseOrigin;
    let _e567 = originOffset;
    rayOrigin_3 = (_e566 + _e567);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e569 = worldExtent_u0028_();
    let _e570 = rayOrigin_3;
    param_49 = _e570;
    let _e571 = rayDir_3;
    param_50 = _e571;
    param_51 = vec3<f32>(0f, 0f, 0f);
    param_52 = _e569;
    let _e572 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_49), (&param_50), (&param_51), (&param_52));
    aabbHit = _e572;
    hitFrontBox = false;
    hitBackBox = false;
    let _e574 = aabbHit[0u];
    let _e576 = aabbHit[1u];
    let _e577 = (_e574 < _e576);
    phi_2908_ = _e577;
    if _e577 {
        let _e579 = aabbHit[1u];
        phi_2908_ = (_e579 > 0f);
    }
    let _e582 = phi_2908_;
    if _e582 {
        let _e584 = aabbHit[0u];
        let _e585 = (_e584 > 0f);
        phi_2924_ = _e585;
        if _e585 {
            let _e586 = rayOrigin_3;
            let _e587 = rayDir_3;
            let _e589 = aabbHit[0u];
            param_53 = (_e586 + (_e587 * _e589));
            let _e592 = isEdge_u0028_vf3_u003b((&param_53));
            phi_2924_ = _e592;
        }
        let _e594 = phi_2924_;
        if _e594 {
            hitFrontBox = true;
        }
        let _e595 = rayOrigin_3;
        let _e596 = rayDir_3;
        let _e598 = aabbHit[1u];
        param_54 = (_e595 + (_e596 * _e598));
        let _e601 = isEdge_u0028_vf3_u003b((&param_54));
        if _e601 {
            hitBackBox = true;
        }
    }
    let _e602 = marchCeiling_u0028_();
    ceilingY_1 = _e602;
    let _e604 = tuning.gridWidth;
    let _e607 = ceilingY_1;
    let _e610 = tuning.gridDepth;
    let _e614 = rayOrigin_3;
    param_55 = _e614;
    let _e615 = rayDir_3;
    param_56 = _e615;
    param_57 = vec3<f32>(0f, 0f, 0f);
    param_58 = vec3<f32>(f32(bitcast<i32>(_e604)), f32(_e607), f32(bitcast<i32>(_e610)));
    let _e616 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_55), (&param_56), (&param_57), (&param_58));
    marchHit = _e616;
    let _e617 = rayOrigin_3;
    let _e618 = rayDir_3;
    let _e620 = marchHit[0u];
    currentPos = (_e617 + (_e618 * max(0f, _e620)));
    let _e625 = marchHit[0u];
    if (_e625 > 0f) {
        let _e627 = rayDir_3;
        let _e629 = currentPos;
        currentPos = (_e629 + (_e627 * 0.001f));
    }
    let _e631 = currentPos;
    voxelPos_16 = vec3<i32>(floor(_e631));
    let _e634 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e634));
    let _e638 = rayDir_3[0u];
    if (_e638 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e641 = rayDir_3[0u];
        local_18 = abs((1f / _e641));
    }
    let _e644 = local_18;
    let _e646 = rayDir_3[1u];
    if (_e646 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e649 = rayDir_3[1u];
        local_19 = abs((1f / _e649));
    }
    let _e652 = local_19;
    let _e654 = rayDir_3[2u];
    if (_e654 == 0f) {
        local_20 = 100000000f;
    } else {
        let _e657 = rayDir_3[2u];
        local_20 = abs((1f / _e657));
    }
    let _e660 = local_20;
    tDelta_3 = vec3<f32>(_e644, _e652, _e660);
    let _e663 = stepDir_3[0u];
    if (_e663 > 0i) {
        let _e666 = currentPos[0u];
        let _e670 = currentPos[0u];
        let _e673 = tDelta_3[0u];
        local_21 = (((floor(_e666) + 1f) - _e670) * _e673);
    } else {
        let _e676 = currentPos[0u];
        let _e678 = currentPos[0u];
        let _e682 = tDelta_3[0u];
        local_21 = ((_e676 - floor(_e678)) * _e682);
    }
    let _e684 = local_21;
    let _e686 = stepDir_3[1u];
    if (_e686 > 0i) {
        let _e689 = currentPos[1u];
        let _e693 = currentPos[1u];
        let _e696 = tDelta_3[1u];
        local_22 = (((floor(_e689) + 1f) - _e693) * _e696);
    } else {
        let _e699 = currentPos[1u];
        let _e701 = currentPos[1u];
        let _e705 = tDelta_3[1u];
        local_22 = ((_e699 - floor(_e701)) * _e705);
    }
    let _e707 = local_22;
    let _e709 = stepDir_3[2u];
    if (_e709 > 0i) {
        let _e712 = currentPos[2u];
        let _e716 = currentPos[2u];
        let _e719 = tDelta_3[2u];
        local_23 = (((floor(_e712) + 1f) - _e716) * _e719);
    } else {
        let _e722 = currentPos[2u];
        let _e724 = currentPos[2u];
        let _e728 = tDelta_3[2u];
        local_23 = ((_e722 - floor(_e724)) * _e728);
    }
    let _e730 = local_23;
    tMax_4 = vec3<f32>(_e684, _e707, _e730);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e733 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e733 * 1.5f));
    i_9 = 0i;
    loop {
        let _e736 = i_9;
        let _e738 = tuning.marchMaxSteps;
        if (_e736 < bitcast<i32>(_e738)) {
            let _e742 = voxelPos_16[0u];
            let _e743 = (_e742 < 0i);
            phi_3140_ = _e743;
            if !(_e743) {
                let _e746 = voxelPos_16[0u];
                let _e748 = tuning.gridWidth;
                phi_3140_ = (_e746 >= bitcast<i32>(_e748));
            }
            let _e752 = phi_3140_;
            phi_3147_ = _e752;
            if !(_e752) {
                let _e755 = voxelPos_16[1u];
                phi_3147_ = (_e755 < 0i);
            }
            let _e758 = phi_3147_;
            phi_3155_ = _e758;
            if !(_e758) {
                let _e761 = voxelPos_16[1u];
                let _e762 = ceilingY_1;
                phi_3155_ = (_e761 >= _e762);
            }
            let _e765 = phi_3155_;
            phi_3162_ = _e765;
            if !(_e765) {
                let _e768 = voxelPos_16[2u];
                phi_3162_ = (_e768 < 0i);
            }
            let _e771 = phi_3162_;
            phi_3172_ = _e771;
            if !(_e771) {
                let _e774 = voxelPos_16[2u];
                let _e776 = tuning.gridDepth;
                phi_3172_ = (_e774 >= bitcast<i32>(_e776));
            }
            let _e780 = phi_3172_;
            if _e780 {
                break;
            }
            let _e781 = voxelPos_16;
            param_59 = _e781;
            let _e782 = getVoxel_u0028_vi3_u003b((&param_59));
            rawVoxel_5 = _e782;
            let _e783 = rawVoxel_5;
            hitType = (_e783 & 255u);
            let _e785 = hitType;
            if (_e785 == 7u) {
                hitType = 0u;
            }
            let _e787 = hitType;
            if (_e787 != 0u) {
                let _e789 = hitType;
                if (_e789 == 6u) {
                    let _e791 = rawVoxel_5;
                    age_1 = ((_e791 >> bitcast<u32>(24i)) & 255u);
                    let _e795 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e795) / 100f), 0f, 1f));
                    let _e800 = inUV_1;
                    let _e802 = pc.time;
                    dither = fract((sin(dot((_e800 + vec2((_e802 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e810 = dither;
                    let _e811 = targetAlpha;
                    if (_e810 > _e811) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e813 = rawVoxel_5;
                        hitRawVoxel = _e813;
                        break;
                    }
                } else {
                    let _e814 = hitType;
                    param_60 = _e814;
                    let _e815 = isLocustType_u0028_u1_u003b((&param_60));
                    let _e816 = hitType;
                    if (_e815 || (_e816 == 18u)) {
                        let _e819 = hitType;
                        kind_2 = select(0u, 1u, (_e819 == 18u));
                        let _e822 = voxelPos_16;
                        param_61 = _e822;
                        let _e823 = rayOrigin_3;
                        param_62 = _e823;
                        let _e824 = rayDir_3;
                        param_63 = _e824;
                        let _e825 = kind_2;
                        param_64 = _e825;
                        let _e826 = hitType;
                        param_65 = _e826;
                        let _e827 = normal_4;
                        param_66 = _e827;
                        let _e828 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_61), (&param_62), (&param_63), (&param_64), (&param_65), (&param_66), (&param_67), (&param_68), (&param_69));
                        let _e829 = param_67;
                        subT = _e829;
                        let _e830 = param_68;
                        subNormal_1 = _e830;
                        let _e831 = param_69;
                        subCell_3 = _e831;
                        if _e828 {
                            hit = true;
                            let _e832 = rawVoxel_5;
                            hitRawVoxel = _e832;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e833 = rawVoxel_5;
                        hitRawVoxel = _e833;
                        break;
                    }
                }
            }
            let _e835 = tMax_4[0u];
            let _e837 = tMax_4[1u];
            if (_e835 < _e837) {
                let _e840 = tMax_4[0u];
                let _e842 = tMax_4[2u];
                if (_e840 < _e842) {
                    let _e845 = stepDir_3[0u];
                    let _e847 = voxelPos_16[0u];
                    voxelPos_16[0u] = (_e847 + _e845);
                    let _e851 = tDelta_3[0u];
                    let _e853 = tMax_4[0u];
                    tMax_4[0u] = (_e853 + _e851);
                    let _e857 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e857)), 0f, 0f);
                } else {
                    let _e862 = stepDir_3[2u];
                    let _e864 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e864 + _e862);
                    let _e868 = tDelta_3[2u];
                    let _e870 = tMax_4[2u];
                    tMax_4[2u] = (_e870 + _e868);
                    let _e874 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e874)));
                }
            } else {
                let _e879 = tMax_4[1u];
                let _e881 = tMax_4[2u];
                if (_e879 < _e881) {
                    let _e884 = stepDir_3[1u];
                    let _e886 = voxelPos_16[1u];
                    voxelPos_16[1u] = (_e886 + _e884);
                    let _e890 = tDelta_3[1u];
                    let _e892 = tMax_4[1u];
                    tMax_4[1u] = (_e892 + _e890);
                    let _e896 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e896)), 0f);
                } else {
                    let _e901 = stepDir_3[2u];
                    let _e903 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e903 + _e901);
                    let _e907 = tDelta_3[2u];
                    let _e909 = tMax_4[2u];
                    tMax_4[2u] = (_e909 + _e907);
                    let _e913 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e913)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e917 = i_9;
            i_9 = (_e917 + 1i);
        }
    }
    let _e919 = hit;
    if _e919 {
        let _e920 = normal_4;
        if (length(_e920) < 0.1f) {
            let _e923 = rayDir_3;
            normal_4 = -(_e923);
        }
        let _e925 = normal_4;
        ddaNormal_1 = _e925;
        let _e926 = hitType;
        if (_e926 == 2u) {
            let _e928 = voxelPos_16;
            param_70 = _e928;
            let _e929 = getWaterNormal_u0028_vi3_u003b((&param_70));
            param_71 = _e929;
            let _e930 = voxelPos_16;
            param_72 = _e930;
            let _e931 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_71), (&param_72));
            normal_4 = _e931;
        } else {
            let _e932 = hitType;
            param_73 = _e932;
            let _e933 = isLocustType_u0028_u1_u003b((&param_73));
            let _e934 = hitType;
            if (_e933 || (_e934 == 18u)) {
                let _e937 = subNormal_1;
                normal_4 = _e937;
            } else {
                let _e938 = voxelPos_16;
                param_74 = _e938;
                let _e939 = getSmoothNormal_u0028_vi3_u003b((&param_74));
                normal_4 = _e939;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e940 = normal_4;
        let _e941 = sunDir_2;
        diffuse_1 = max(dot(_e940, _e941), 0f);
        let _e944 = voxelPos_16;
        param_75 = _e944;
        let _e945 = ddaNormal_1;
        param_76 = _e945;
        let _e946 = sunDir_2;
        param_77 = _e946;
        let _e947 = ceilingY_1;
        param_78 = _e947;
        let _e948 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_75), (&param_76), (&param_77), (&param_78));
        shadow_1 = _e948;
        let _e949 = ambientColor;
        let _e950 = sunColor_1;
        let _e951 = diffuse_1;
        let _e953 = shadow_1;
        baseLighting_9 = (_e949 + ((_e950 * _e951) * _e953));
        let _e956 = baseLighting_9;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e956);
        let _e958 = hitType;
        switch bitcast<i32>(_e958) {
            case 1: {
                let _e960 = hitRawVoxel;
                param_79 = _e960;
                let _e961 = baseLighting_9;
                param_80 = _e961;
                let _e962 = renderSand_u0028_u1_u003b_vf3_u003b((&param_79), (&param_80));
                finalVoxelColor = _e962;
                break;
            }
            case 2: {
                let _e963 = voxelPos_16;
                param_81 = _e963;
                let _e964 = normal_4;
                param_82 = _e964;
                let _e965 = rayOrigin_3;
                param_83 = _e965;
                let _e966 = sunDir_2;
                param_84 = _e966;
                let _e967 = sunColor_1;
                param_85 = _e967;
                let _e968 = shadow_1;
                param_86 = _e968;
                let _e969 = baseLighting_9;
                param_87 = _e969;
                let _e970 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_81), (&param_82), (&param_83), (&param_84), (&param_85), (&param_86), (&param_87));
                finalVoxelColor = _e970;
                break;
            }
            case 3: {
                let _e971 = voxelPos_16;
                param_88 = _e971;
                let _e972 = baseLighting_9;
                param_89 = _e972;
                let _e973 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_88), (&param_89));
                finalVoxelColor = _e973;
                break;
            }
            case 4: {
                let _e974 = hitRawVoxel;
                param_90 = _e974;
                let _e975 = voxelPos_16;
                param_91 = _e975;
                let _e976 = ddaNormal_1;
                param_92 = _e976;
                let _e977 = baseLighting_9;
                param_93 = _e977;
                let _e978 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_90), (&param_91), (&param_92), (&param_93));
                finalVoxelColor = _e978;
                break;
            }
            case 5: {
                let _e979 = hitRawVoxel;
                param_94 = _e979;
                let _e980 = voxelPos_16;
                param_95 = _e980;
                let _e981 = renderFire_u0028_u1_u003b_vi3_u003b((&param_94), (&param_95));
                finalVoxelColor = _e981;
                break;
            }
            case 6: {
                let _e982 = voxelPos_16;
                param_96 = _e982;
                let _e983 = baseLighting_9;
                param_97 = _e983;
                let _e984 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_96), (&param_97));
                finalVoxelColor = _e984;
                break;
            }
            case 9, 10, 11, 8: {
                let _e985 = hitRawVoxel;
                param_98 = _e985;
                let _e986 = voxelPos_16;
                param_99 = _e986;
                let _e987 = renderLava_u0028_u1_u003b_vi3_u003b((&param_98), (&param_99));
                finalVoxelColor = _e987;
                break;
            }
            case 12: {
                let _e988 = voxelPos_16;
                param_100 = _e988;
                let _e989 = baseLighting_9;
                param_101 = _e989;
                let _e990 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_100), (&param_101));
                finalVoxelColor = _e990;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e991 = voxelPos_16;
                param_102 = _e991;
                let _e992 = subCell_3;
                param_103 = _e992;
                let _e993 = baseLighting_9;
                param_104 = _e993;
                let _e994 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_102), (&param_103), (&param_104));
                finalVoxelColor = _e994;
                break;
            }
            case 18: {
                let _e995 = voxelPos_16;
                param_105 = _e995;
                let _e996 = subCell_3;
                param_106 = _e996;
                let _e997 = baseLighting_9;
                param_107 = _e997;
                let _e998 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_105), (&param_106), (&param_107));
                finalVoxelColor = _e998;
                break;
            }
            case 19: {
                let _e999 = hitRawVoxel;
                param_108 = _e999;
                let _e1000 = voxelPos_16;
                param_109 = _e1000;
                let _e1001 = baseLighting_9;
                param_110 = _e1001;
                let _e1002 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_108), (&param_109), (&param_110));
                finalVoxelColor = _e1002;
                break;
            }
            default: {
                break;
            }
        }
        let _e1003 = finalVoxelColor;
        param_111 = _e1003;
        let _e1004 = voxelPos_16;
        param_112 = _e1004;
        let _e1005 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_111), (&param_112));
        finalVoxelColor = _e1005;
        let _e1006 = hitType;
        param_113 = _e1006;
        let _e1007 = isLocustType_u0028_u1_u003b((&param_113));
        let _e1008 = hitType;
        if (_e1007 || (_e1008 == 18u)) {
            let _e1011 = subT;
            local_24 = _e1011;
        } else {
            let _e1012 = voxelPos_16;
            let _e1015 = rayOrigin_3;
            local_24 = length(((vec3<f32>(_e1012) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e1015));
        }
        let _e1018 = local_24;
        distanceTraveled = _e1018;
        let _e1019 = distanceTraveled;
        let _e1020 = MAX_VISIBILITY;
        let _e1024 = finalVoxelColor;
        finalVoxelColor = (_e1024 * mix(1f, 0f, clamp((_e1019 / _e1020), 0f, 1f)));
        let _e1026 = distanceTraveled;
        finalDist = _e1026;
        let _e1027 = finalVoxelColor;
        finalColor = vec4<f32>(_e1027.x, _e1027.y, _e1027.z, 1f);
    } else {
        let _e1032 = hitBackBox;
        if _e1032 {
            let _e1034 = aabbHit[1u];
            finalDist = _e1034;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1036 = unnamed.blackHoleCount;
    if (_e1036 > 0u) {
        seenHoles = 0u;
        i_10 = 0i;
        loop {
            let _e1038 = i_10;
            let _e1039 = (_e1038 < 8i);
            phi_3598_ = _e1039;
            if _e1039 {
                let _e1040 = seenHoles;
                let _e1042 = unnamed.blackHoleCount;
                phi_3598_ = (_e1040 < _e1042);
            }
            let _e1045 = phi_3598_;
            if _e1045 {
                let _e1046 = i_10;
                let _e1049 = unnamed.blackHoles[_e1046];
                code_2 = _e1049;
                let _e1050 = code_2;
                if (_e1050 == 0u) {
                    continue;
                }
                let _e1052 = seenHoles;
                seenHoles = (_e1052 + bitcast<u32>(1i));
                let _e1055 = code_2;
                if ((_e1055 & 1073741824u) != 0u) {
                    let _e1059 = tuning.purgeLevel;
                    let _e1061 = i_10;
                    let _e1064 = unnamed.blackHoleMass[_e1061];
                    let _e1067 = tuning.purgeMass;
                    local_25 = u32((f32(_e1059) * clamp((f32(_e1064) / f32(max(_e1067, 1u))), 0f, 1f)));
                } else {
                    let _e1074 = i_10;
                    let _e1077 = unnamed.blackHoleMass[_e1074];
                    param_114 = _e1077;
                    let _e1078 = bhLevel_u0028_u1_u003b((&param_114));
                    local_25 = _e1078;
                }
                let _e1079 = local_25;
                bodyLevel = _e1079;
                let _e1080 = bodyLevel;
                param_115 = _e1080;
                let _e1081 = bhBodyRadius_u0028_u1_u003b((&param_115));
                bodyRadius = _e1081;
                let _e1082 = code_2;
                param_116 = _e1082;
                let _e1083 = bhDecode_u0028_u1_u003b((&param_116));
                center_1 = (vec3<f32>(_e1083) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1086 = rayOrigin_3;
                let _e1087 = center_1;
                oc = (_e1086 - _e1087);
                let _e1089 = oc;
                let _e1090 = rayDir_3;
                b_2 = dot(_e1089, _e1090);
                let _e1092 = oc;
                let _e1093 = oc;
                let _e1095 = bodyRadius;
                let _e1096 = bodyRadius;
                c_2 = (dot(_e1092, _e1093) - (_e1095 * _e1096));
                let _e1099 = b_2;
                let _e1100 = b_2;
                let _e1102 = c_2;
                disc = ((_e1099 * _e1100) - _e1102);
                let _e1104 = disc;
                if (_e1104 <= 0f) {
                    continue;
                }
                let _e1106 = disc;
                sq = sqrt(_e1106);
                let _e1108 = b_2;
                let _e1110 = sq;
                tNear_1 = (-(_e1108) - _e1110);
                let _e1112 = b_2;
                let _e1114 = sq;
                tFar_1 = (-(_e1112) + _e1114);
                let _e1116 = tFar_1;
                if (_e1116 <= 0f) {
                    continue;
                }
                let _e1118 = tNear_1;
                bodyDist = max(0f, _e1118);
                let _e1120 = bodyDist;
                let _e1121 = finalDist;
                if (_e1120 < _e1121) {
                    let _e1123 = rayOrigin_3;
                    let _e1124 = rayDir_3;
                    let _e1125 = bodyDist;
                    let _e1128 = center_1;
                    surfaceNormal = normalize(((_e1123 + (_e1124 * _e1125)) - _e1128));
                    let _e1131 = surfaceNormal;
                    param_117 = _e1131;
                    let _e1132 = rayDir_3;
                    param_118 = _e1132;
                    let _e1133 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_117), (&param_118));
                    bodyColor = _e1133;
                    let _e1134 = bodyDist;
                    let _e1135 = MAX_VISIBILITY;
                    let _e1139 = bodyColor;
                    bodyColor = (_e1139 * mix(1f, 0f, clamp((_e1134 / _e1135), 0f, 1f)));
                    let _e1141 = bodyColor;
                    finalColor = vec4<f32>(_e1141.x, _e1141.y, _e1141.z, 1f);
                    let _e1146 = bodyDist;
                    finalDist = _e1146;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1147 = i_10;
                i_10 = (_e1147 + 1i);
            }
        }
    }
    let _e1150 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1150), 0f, 1f);
    let _e1154 = tuning.cloudMinAlpha;
    let _e1156 = tuning.cloudMaxAlpha;
    let _e1157 = charge;
    groupAlpha = mix(_e1154, _e1156, _e1157);
    let _e1159 = charge;
    cloudGreyness = _e1159;
    let _e1161 = unnamed.rainPhase;
    if (_e1161 == 1u) {
        let _e1164 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1164);
        let _e1166 = charge;
        let _e1168 = pc.time;
        let _e1169 = crossedTime;
        let _e1172 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1166, clamp(((_e1168 - _e1169) / _e1172), 0f, 1f));
    } else {
        let _e1177 = unnamed.rainPhase;
        if (_e1177 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1179 = groupAlpha;
    if (_e1179 > 0.002f) {
        let _e1182 = tuning.gridWidth;
        let _e1186 = tuning.gridDepth;
        let _e1190 = rayOrigin_3;
        param_119 = _e1190;
        let _e1191 = rayDir_3;
        param_120 = _e1191;
        param_121 = vec3<f32>(0f, -1000000f, 0f);
        param_122 = vec3<f32>(f32(bitcast<i32>(_e1182)), 1000000f, f32(bitcast<i32>(_e1186)));
        let _e1192 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_119), (&param_120), (&param_121), (&param_122));
        footprintClip = _e1192;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1194 = tuning.cloudCount;
        cloudN = bitcast<i32>(min(_e1194, 64u));
        i_11 = 0i;
        loop {
            let _e1197 = i_11;
            let _e1198 = cloudN;
            if (_e1197 < _e1198) {
                let _e1200 = i_11;
                param_123 = _e1200;
                let _e1201 = cloudFade_u0028_i1_u003b((&param_123));
                edgeFade = _e1201;
                let _e1202 = edgeFade;
                if (_e1202 <= 0.01f) {
                    continue;
                }
                let _e1204 = i_11;
                param_124 = _e1204;
                let _e1205 = cloudCenter_u0028_i1_u003b((&param_124));
                center_2 = _e1205;
                let _e1206 = i_11;
                param_125 = _e1206;
                let _e1207 = cloudRadii_u0028_i1_u003b((&param_125));
                radii_1 = _e1207;
                let _e1208 = rayOrigin_3;
                let _e1209 = center_2;
                let _e1211 = radii_1;
                oc_1 = ((_e1208 - _e1209) / _e1211);
                let _e1213 = rayDir_3;
                let _e1214 = radii_1;
                rdn = (_e1213 / _e1214);
                let _e1216 = rdn;
                let _e1217 = rdn;
                a_3 = dot(_e1216, _e1217);
                let _e1219 = oc_1;
                let _e1220 = rdn;
                b_3 = dot(_e1219, _e1220);
                let _e1222 = oc_1;
                let _e1223 = oc_1;
                c_3 = (dot(_e1222, _e1223) - 1f);
                let _e1226 = b_3;
                let _e1227 = b_3;
                let _e1229 = a_3;
                let _e1230 = c_3;
                disc_1 = ((_e1226 * _e1227) - (_e1229 * _e1230));
                let _e1233 = disc_1;
                if (_e1233 > 0f) {
                    let _e1235 = disc_1;
                    sq_1 = sqrt(_e1235);
                    let _e1237 = b_3;
                    let _e1239 = sq_1;
                    let _e1241 = a_3;
                    t0_ = ((-(_e1237) - _e1239) / _e1241);
                    let _e1243 = b_3;
                    let _e1245 = sq_1;
                    let _e1247 = a_3;
                    t1_1 = ((-(_e1243) + _e1245) / _e1247);
                    let _e1249 = t0_;
                    let _e1251 = footprintClip[0u];
                    clippedNear = max(_e1249, _e1251);
                    let _e1253 = t1_1;
                    let _e1255 = footprintClip[1u];
                    clippedFar = min(_e1253, _e1255);
                    let _e1257 = clippedNear;
                    let _e1258 = bestT;
                    let _e1259 = finalDist;
                    if (_e1257 >= min(_e1258, _e1259)) {
                        continue;
                    }
                    let _e1262 = clippedNear;
                    let _e1263 = clippedFar;
                    let _e1265 = clippedFar;
                    if ((_e1262 < _e1263) && (_e1265 > 0f)) {
                        let _e1268 = i_11;
                        let _e1270 = rayOrigin_3;
                        param_126 = _e1270;
                        let _e1271 = rayDir_3;
                        param_127 = _e1271;
                        let _e1272 = center_2;
                        param_128 = _e1272;
                        let _e1273 = radii_1;
                        param_129 = _e1273;
                        param_130 = f32(_e1268);
                        let _e1274 = clippedNear;
                        param_131 = _e1274;
                        let _e1275 = clippedFar;
                        param_132 = _e1275;
                        let _e1276 = cloudSunDir;
                        param_133 = _e1276;
                        let _e1277 = cloudGreyness;
                        param_134 = _e1277;
                        let _e1278 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b((&param_126), (&param_127), (&param_128), (&param_129), (&param_130), (&param_131), (&param_132), (&param_133), (&param_134), (&param_135), (&param_136));
                        let _e1279 = param_135;
                        cloudTHit = _e1279;
                        let _e1280 = param_136;
                        cloudColor = _e1280;
                        if _e1278 {
                            let _e1281 = cloudTHit;
                            let _e1283 = cloudTHit;
                            let _e1284 = bestT;
                            if ((_e1281 > 0f) && (_e1283 < _e1284)) {
                                let _e1287 = cloudTHit;
                                bestT = _e1287;
                                let _e1288 = cloudColor;
                                bestColor = _e1288;
                                let _e1289 = groupAlpha;
                                let _e1290 = edgeFade;
                                bestAlpha = clamp((_e1289 * _e1290), 0f, 0.95f);
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
                let _e1293 = i_11;
                i_11 = (_e1293 + 1i);
            }
        }
        let _e1295 = foundCloud;
        let _e1296 = bestT;
        let _e1297 = finalDist;
        if (_e1295 && (_e1296 < _e1297)) {
            let _e1300 = finalColor;
            let _e1302 = bestColor;
            let _e1303 = bestAlpha;
            let _e1305 = mix(_e1300.xyz, _e1302, vec3(_e1303));
            finalColor[0u] = _e1305.x;
            finalColor[1u] = _e1305.y;
            finalColor[2u] = _e1305.z;
        }
    }
    let _e1313 = pc.spawnX;
    let _e1314 = (_e1313 >= 0i);
    phi_3988_ = _e1314;
    if _e1314 {
        let _e1316 = pc.spawnX;
        let _e1318 = tuning.gridWidth;
        phi_3988_ = (_e1316 < bitcast<i32>(_e1318));
    }
    let _e1322 = phi_3988_;
    phi_3994_ = _e1322;
    if _e1322 {
        let _e1324 = pc.spawnY;
        phi_3994_ = (_e1324 >= 0i);
    }
    let _e1327 = phi_3994_;
    phi_4003_ = _e1327;
    if _e1327 {
        let _e1329 = pc.spawnY;
        let _e1331 = tuning.gridHeight;
        phi_4003_ = (_e1329 < bitcast<i32>(_e1331));
    }
    let _e1335 = phi_4003_;
    phi_4009_ = _e1335;
    if _e1335 {
        let _e1337 = pc.spawnZ;
        phi_4009_ = (_e1337 >= 0i);
    }
    let _e1340 = phi_4009_;
    phi_4018_ = _e1340;
    if _e1340 {
        let _e1342 = pc.spawnZ;
        let _e1344 = tuning.gridDepth;
        phi_4018_ = (_e1342 < bitcast<i32>(_e1344));
    }
    let _e1348 = phi_4018_;
    if _e1348 {
        let _e1350 = pc.spawnSize;
        halfDistMin = (_e1350 / 2i);
        let _e1353 = pc.spawnSize;
        halfDistMax = ((_e1353 - 1i) / 2i);
        let _e1357 = pc.spawnX;
        let _e1358 = halfDistMin;
        let _e1362 = pc.spawnY;
        let _e1363 = halfDistMin;
        let _e1367 = pc.spawnZ;
        let _e1368 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1357 - _e1358)), f32((_e1362 - _e1363)), f32((_e1367 - _e1368)));
        let _e1373 = pc.spawnX;
        let _e1374 = halfDistMax;
        let _e1379 = pc.spawnY;
        let _e1380 = halfDistMax;
        let _e1385 = pc.spawnZ;
        let _e1386 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1373 + _e1374) + 1i)), f32(((_e1379 + _e1380) + 1i)), f32(((_e1385 + _e1386) + 1i)));
        let _e1392 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1395 = indexable_6[clamp(_e1392, 0i, 19i)];
        cursorColor = _e1395;
        let _e1397 = pc.spawnShape;
        if (_e1397 == 1i) {
            let _e1399 = boxMin_2;
            let _e1400 = boxMax_1;
            sphereCenter = ((_e1399 + _e1400) * 0.5f);
            let _e1404 = pc.spawnSize;
            sphereRadius = (f32(_e1404) * 0.5f);
            let _e1407 = rayOrigin_3;
            let _e1408 = sphereCenter;
            oc_2 = (_e1407 - _e1408);
            let _e1410 = oc_2;
            let _e1411 = rayDir_3;
            b_4 = dot(_e1410, _e1411);
            let _e1413 = oc_2;
            let _e1414 = oc_2;
            let _e1416 = sphereRadius;
            let _e1417 = sphereRadius;
            c_4 = (dot(_e1413, _e1414) - (_e1416 * _e1417));
            let _e1420 = b_4;
            let _e1421 = b_4;
            let _e1423 = c_4;
            disc_2 = ((_e1420 * _e1421) - _e1423);
            let _e1425 = disc_2;
            if (_e1425 > 0f) {
                let _e1427 = disc_2;
                sq_2 = sqrt(_e1427);
                let _e1429 = b_4;
                let _e1431 = sq_2;
                tNear_2 = (-(_e1429) - _e1431);
                let _e1433 = b_4;
                let _e1435 = sq_2;
                tFar_2 = (-(_e1433) + _e1435);
                let _e1437 = tFar_2;
                if (_e1437 > 0f) {
                    let _e1439 = tNear_2;
                    inside = (_e1439 <= 0f);
                    let _e1441 = inside;
                    let _e1442 = tFar_2;
                    let _e1443 = tNear_2;
                    cursorDist = select(_e1443, _e1442, _e1441);
                    let _e1445 = rayOrigin_3;
                    let _e1446 = rayDir_3;
                    let _e1447 = cursorDist;
                    let _e1450 = sphereCenter;
                    shellNormal = normalize(((_e1445 + (_e1446 * _e1447)) - _e1450));
                    let _e1453 = shellNormal;
                    let _e1454 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1453, _e1454)));
                    let _e1458 = rim_1;
                    let _e1461 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1458)) * select(1f, 0.35f, _e1461));
                    let _e1464 = cursorDist;
                    let _e1465 = finalDist;
                    if (_e1464 < _e1465) {
                        let _e1467 = finalColor;
                        let _e1469 = cursorColor;
                        let _e1470 = alpha;
                        let _e1472 = mix(_e1467.xyz, _e1469, vec3(_e1470));
                        finalColor[0u] = _e1472.x;
                        finalColor[1u] = _e1472.y;
                        finalColor[2u] = _e1472.z;
                    }
                }
            }
        } else {
            let _e1479 = rayOrigin_3;
            param_137 = _e1479;
            let _e1480 = rayDir_3;
            param_138 = _e1480;
            let _e1481 = boxMin_2;
            param_139 = _e1481;
            let _e1482 = boxMax_1;
            param_140 = _e1482;
            let _e1483 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_137), (&param_138), (&param_139), (&param_140));
            cursorHit = _e1483;
            let _e1485 = cursorHit[0u];
            let _e1487 = cursorHit[1u];
            let _e1488 = (_e1485 < _e1487);
            phi_4227_ = _e1488;
            if _e1488 {
                let _e1490 = cursorHit[1u];
                phi_4227_ = (_e1490 > 0f);
            }
            let _e1493 = phi_4227_;
            if _e1493 {
                let _e1495 = cursorHit[0u];
                distFront = max(0f, _e1495);
                let _e1498 = cursorHit[1u];
                distBack = _e1498;
                let _e1499 = rayOrigin_3;
                let _e1500 = rayDir_3;
                let _e1501 = distFront;
                hitPosFront = (_e1499 + (_e1500 * _e1501));
                let _e1504 = rayOrigin_3;
                let _e1505 = rayDir_3;
                let _e1506 = distBack;
                hitPosBack = (_e1504 + (_e1505 * _e1506));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1510 = hitPosFront[0u];
                let _e1512 = boxMin_2[0u];
                let _e1513 = e;
                let _e1515 = (_e1510 < (_e1512 + _e1513));
                phi_4269_ = _e1515;
                if !(_e1515) {
                    let _e1518 = hitPosFront[0u];
                    let _e1520 = boxMax_1[0u];
                    let _e1521 = e;
                    phi_4269_ = (_e1518 > (_e1520 - _e1521));
                }
                let _e1525 = phi_4269_;
                if _e1525 {
                    let _e1526 = edgesFront;
                    edgesFront = (_e1526 + 1i);
                }
                let _e1529 = hitPosFront[1u];
                let _e1531 = boxMin_2[1u];
                let _e1532 = e;
                let _e1534 = (_e1529 < (_e1531 + _e1532));
                phi_4291_ = _e1534;
                if !(_e1534) {
                    let _e1537 = hitPosFront[1u];
                    let _e1539 = boxMax_1[1u];
                    let _e1540 = e;
                    phi_4291_ = (_e1537 > (_e1539 - _e1540));
                }
                let _e1544 = phi_4291_;
                if _e1544 {
                    let _e1545 = edgesFront;
                    edgesFront = (_e1545 + 1i);
                }
                let _e1548 = hitPosFront[2u];
                let _e1550 = boxMin_2[2u];
                let _e1551 = e;
                let _e1553 = (_e1548 < (_e1550 + _e1551));
                phi_4313_ = _e1553;
                if !(_e1553) {
                    let _e1556 = hitPosFront[2u];
                    let _e1558 = boxMax_1[2u];
                    let _e1559 = e;
                    phi_4313_ = (_e1556 > (_e1558 - _e1559));
                }
                let _e1563 = phi_4313_;
                if _e1563 {
                    let _e1564 = edgesFront;
                    edgesFront = (_e1564 + 1i);
                }
                let _e1566 = edgesFront;
                if (_e1566 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1569 = hitPosBack[0u];
                let _e1571 = boxMin_2[0u];
                let _e1572 = e;
                let _e1574 = (_e1569 < (_e1571 + _e1572));
                phi_4341_ = _e1574;
                if !(_e1574) {
                    let _e1577 = hitPosBack[0u];
                    let _e1579 = boxMax_1[0u];
                    let _e1580 = e;
                    phi_4341_ = (_e1577 > (_e1579 - _e1580));
                }
                let _e1584 = phi_4341_;
                if _e1584 {
                    let _e1585 = edgesBack;
                    edgesBack = (_e1585 + 1i);
                }
                let _e1588 = hitPosBack[1u];
                let _e1590 = boxMin_2[1u];
                let _e1591 = e;
                let _e1593 = (_e1588 < (_e1590 + _e1591));
                phi_4363_ = _e1593;
                if !(_e1593) {
                    let _e1596 = hitPosBack[1u];
                    let _e1598 = boxMax_1[1u];
                    let _e1599 = e;
                    phi_4363_ = (_e1596 > (_e1598 - _e1599));
                }
                let _e1603 = phi_4363_;
                if _e1603 {
                    let _e1604 = edgesBack;
                    edgesBack = (_e1604 + 1i);
                }
                let _e1607 = hitPosBack[2u];
                let _e1609 = boxMin_2[2u];
                let _e1610 = e;
                let _e1612 = (_e1607 < (_e1609 + _e1610));
                phi_4385_ = _e1612;
                if !(_e1612) {
                    let _e1615 = hitPosBack[2u];
                    let _e1617 = boxMax_1[2u];
                    let _e1618 = e;
                    phi_4385_ = (_e1615 > (_e1617 - _e1618));
                }
                let _e1622 = phi_4385_;
                if _e1622 {
                    let _e1623 = edgesBack;
                    edgesBack = (_e1623 + 1i);
                }
                let _e1625 = edgesBack;
                if (_e1625 >= 2i) {
                    onBackEdge = true;
                }
                let _e1627 = onFrontEdge;
                let _e1628 = distFront;
                let _e1629 = finalDist;
                if (_e1627 && (_e1628 < _e1629)) {
                    let _e1632 = finalColor;
                    let _e1634 = cursorColor;
                    let _e1636 = mix(_e1632.xyz, _e1634, vec3(0.9f));
                    finalColor[0u] = _e1636.x;
                    finalColor[1u] = _e1636.y;
                    finalColor[2u] = _e1636.z;
                } else {
                    let _e1643 = onBackEdge;
                    let _e1644 = distBack;
                    let _e1645 = finalDist;
                    if (_e1643 && (_e1644 < _e1645)) {
                        let _e1648 = finalColor;
                        let _e1650 = cursorColor;
                        let _e1652 = mix(_e1648.xyz, _e1650, vec3(0.2f));
                        finalColor[0u] = _e1652.x;
                        finalColor[1u] = _e1652.y;
                        finalColor[2u] = _e1652.z;
                    } else {
                        let _e1659 = distFront;
                        let _e1660 = finalDist;
                        if (_e1659 < _e1660) {
                            let _e1662 = finalColor;
                            let _e1664 = cursorColor;
                            let _e1666 = mix(_e1662.xyz, _e1664, vec3(0.15f));
                            finalColor[0u] = _e1666.x;
                            finalColor[1u] = _e1666.y;
                            finalColor[2u] = _e1666.z;
                        }
                    }
                }
            }
        }
    }
    let _e1673 = hitFrontBox;
    if _e1673 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1674 = finalColor;
    outColor = _e1674;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
