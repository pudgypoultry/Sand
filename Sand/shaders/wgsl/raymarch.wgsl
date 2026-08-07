// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: a5f212b7866d2075b347ec3b9039b3867586768af576633eb02d3f2e2f3ee556

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
    cloudStillTicksToStorm: u32,
    stormWaitMaxTicks: u32,
    cloudColumnFullCount: f32,
    cloudThicknessPerBlock: f32,
    cloudClumpThreshold: u32,
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
    cloudBlockCount: u32,
    cloudChangedCount: u32,
    cloudStillTicks: u32,
    blackHoleCount: u32,
    maxOccupiedY: u32,
    blackHoles: array<u32, 8>,
    blackHoleMass: array<u32, 8>,
    blackHoleStarve: array<u32, 8>,
    cloudColumn: array<u32>,
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
    showCloudBlocks: i32,
}

struct CloudGrid {
    cloudCells: array<u32>,
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
@group(0) @binding(4) 
var<storage> unnamed_2: CloudGrid;
var<private> outColor: vec4<f32>;

fn hash_u0028_vf3_u003b(p: ptr<function, vec3<f32>>) -> f32 {
    let _e262 = (*p);
    return fract((sin(dot(_e262, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x: ptr<function, i32>, z: ptr<function, i32>) -> u32 {
    let _e263 = (*x);
    let _e264 = (*z);
    let _e266 = tuning.gridWidth;
    return (bitcast<u32>((_e263 + (_e264 * bitcast<i32>(_e266)))) * 4u);
}

fn marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b(rayOrigin: ptr<function, vec3<f32>>, rayDir: ptr<function, vec3<f32>>, tEnter: ptr<function, f32>, tExit: ptr<function, f32>, sunDir: ptr<function, vec3<f32>>, greyness: ptr<function, f32>, tHit: ptr<function, f32>, hitColor: ptr<function, vec3<f32>>, hitDensity: ptr<function, f32>) -> bool {
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
    var i: i32;
    var cellCenter: vec3<f32>;
    var cx: i32;
    var cz: i32;
    var base: u32;
    var param: i32;
    var param_1: i32;
    var count: u32;
    var baseY: f32;
    var thickness: f32;
    var capY: f32;
    var density: f32;
    var mid: f32;
    var edgeFactor: f32;
    var threshold: f32;
    var fillHash: f32;
    var param_2: vec3<f32>;
    var shadeHash: f32;
    var param_3: vec3<f32>;
    var baseColor: vec3<f32>;
    var stormColor: vec3<f32>;
    var diffuse: f32;
    var phi_2548_: bool;
    var phi_2559_: bool;
    var phi_2607_: bool;

    let _e306 = (*tEnter);
    (*tEnter) = max(_e306, 0f);
    let _e308 = (*tEnter);
    let _e309 = (*tExit);
    if (_e308 >= _e309) {
        return false;
    }
    let _e311 = (*rayOrigin);
    let _e312 = (*rayDir);
    let _e313 = (*tEnter);
    startPos = (_e311 + (_e312 * _e313));
    let _e316 = startPos;
    let _e318 = tuning.cloudVoxelSize;
    cellPos = vec3<i32>(floor((_e316 / vec3(_e318))));
    let _e323 = (*rayDir);
    stepDir = vec3<i32>(sign(_e323));
    let _e327 = (*rayDir)[0u];
    if (_e327 == 0f) {
        local = 100000000f;
    } else {
        let _e330 = tuning.cloudVoxelSize;
        let _e332 = (*rayDir)[0u];
        local = abs((_e330 / _e332));
    }
    let _e335 = local;
    let _e337 = (*rayDir)[1u];
    if (_e337 == 0f) {
        local_1 = 100000000f;
    } else {
        let _e340 = tuning.cloudVoxelSize;
        let _e342 = (*rayDir)[1u];
        local_1 = abs((_e340 / _e342));
    }
    let _e345 = local_1;
    let _e347 = (*rayDir)[2u];
    if (_e347 == 0f) {
        local_2 = 100000000f;
    } else {
        let _e350 = tuning.cloudVoxelSize;
        let _e352 = (*rayDir)[2u];
        local_2 = abs((_e350 / _e352));
    }
    let _e355 = local_2;
    tDelta = vec3<f32>(_e335, _e345, _e355);
    let _e357 = startPos;
    let _e359 = tuning.cloudVoxelSize;
    let _e362 = cellPos;
    fracPos = ((_e357 / vec3(_e359)) - vec3<f32>(_e362));
    let _e365 = (*tEnter);
    let _e367 = stepDir[0u];
    if (_e367 > 0i) {
        let _e370 = fracPos[0u];
        let _e373 = tDelta[0u];
        local_3 = ((1f - _e370) * _e373);
    } else {
        let _e376 = fracPos[0u];
        let _e378 = tDelta[0u];
        local_3 = (_e376 * _e378);
    }
    let _e380 = local_3;
    let _e382 = stepDir[1u];
    if (_e382 > 0i) {
        let _e385 = fracPos[1u];
        let _e388 = tDelta[1u];
        local_4 = ((1f - _e385) * _e388);
    } else {
        let _e391 = fracPos[1u];
        let _e393 = tDelta[1u];
        local_4 = (_e391 * _e393);
    }
    let _e395 = local_4;
    let _e397 = stepDir[2u];
    if (_e397 > 0i) {
        let _e400 = fracPos[2u];
        let _e403 = tDelta[2u];
        local_5 = ((1f - _e400) * _e403);
    } else {
        let _e406 = fracPos[2u];
        let _e408 = tDelta[2u];
        local_5 = (_e406 * _e408);
    }
    let _e410 = local_5;
    tMax = (vec3(_e365) + vec3<f32>(_e380, _e395, _e410));
    normal = vec3<f32>(0f, 0f, 0f);
    let _e414 = (*tEnter);
    t = _e414;
    i = 0i;
    loop {
        let _e415 = i;
        let _e417 = tuning.maxCloudSteps;
        if (_e415 < bitcast<i32>(_e417)) {
            let _e420 = t;
            let _e421 = (*tExit);
            if (_e420 > _e421) {
                break;
            }
            let _e423 = cellPos;
            let _e428 = tuning.cloudVoxelSize;
            cellCenter = ((vec3<f32>(_e423) + vec3(0.5f)) * _e428);
            let _e431 = cellCenter[0u];
            cx = i32(floor(_e431));
            let _e435 = cellCenter[2u];
            cz = i32(floor(_e435));
            let _e438 = cx;
            let _e439 = (_e438 >= 0i);
            phi_2548_ = _e439;
            if _e439 {
                let _e440 = cx;
                let _e442 = tuning.gridWidth;
                phi_2548_ = (_e440 < bitcast<i32>(_e442));
            }
            let _e446 = phi_2548_;
            let _e447 = cz;
            let _e449 = (_e446 && (_e447 >= 0i));
            phi_2559_ = _e449;
            if _e449 {
                let _e450 = cz;
                let _e452 = tuning.gridDepth;
                phi_2559_ = (_e450 < bitcast<i32>(_e452));
            }
            let _e456 = phi_2559_;
            if _e456 {
                let _e457 = cx;
                param = _e457;
                let _e458 = cz;
                param_1 = _e458;
                let _e459 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param), (&param_1));
                base = _e459;
                let _e460 = base;
                let _e464 = unnamed.cloudColumn[(_e460 + 2u)];
                count = _e464;
                let _e465 = count;
                if (_e465 > 0u) {
                    let _e467 = base;
                    let _e471 = unnamed.cloudColumn[(_e467 + 3u)];
                    baseY = f32(_e471);
                    let _e473 = count;
                    let _e476 = tuning.cloudThicknessPerBlock;
                    thickness = (f32(_e473) * max(_e476, 0.01f));
                    let _e479 = baseY;
                    let _e480 = thickness;
                    capY = (_e479 + _e480);
                    let _e483 = cellCenter[1u];
                    let _e484 = baseY;
                    let _e485 = (_e483 >= _e484);
                    phi_2607_ = _e485;
                    if _e485 {
                        let _e487 = cellCenter[1u];
                        let _e488 = capY;
                        phi_2607_ = (_e487 <= _e488);
                    }
                    let _e491 = phi_2607_;
                    if _e491 {
                        let _e492 = count;
                        let _e495 = tuning.cloudColumnFullCount;
                        density = clamp((f32(_e492) / max(_e495, 1f)), 0f, 1f);
                        let _e499 = baseY;
                        let _e500 = capY;
                        mid = ((_e499 + _e500) * 0.5f);
                        let _e504 = cellCenter[1u];
                        let _e505 = mid;
                        let _e508 = thickness;
                        edgeFactor = clamp((abs((_e504 - _e505)) / max((_e508 * 0.5f), 0.001f)), 0f, 1f);
                        let _e514 = tuning.cloudEdgeThresholdMin;
                        let _e516 = tuning.cloudEdgeThresholdMax;
                        let _e517 = edgeFactor;
                        threshold = mix(_e514, _e516, _e517);
                        let _e519 = threshold;
                        let _e520 = density;
                        threshold = mix(1f, _e519, _e520);
                        let _e522 = cellPos;
                        param_2 = vec3<f32>(_e522);
                        let _e524 = hash_u0028_vf3_u003b((&param_2));
                        fillHash = _e524;
                        let _e525 = fillHash;
                        let _e526 = threshold;
                        if (_e525 > _e526) {
                            let _e528 = t;
                            (*tHit) = _e528;
                            let _e529 = density;
                            (*hitDensity) = _e529;
                            let _e530 = cellPos;
                            param_3 = ((vec3<f32>(_e530) * 3.71f) + vec3<f32>(91f, 5f, 7f));
                            let _e534 = hash_u0028_vf3_u003b((&param_3));
                            shadeHash = _e534;
                            let _e535 = shadeHash;
                            baseColor = mix(vec3<f32>(0.76f, 0.76f, 0.78f), vec3<f32>(1f, 1f, 1f), vec3(_e535));
                            stormColor = vec3<f32>(0.32f, 0.33f, 0.36f);
                            let _e538 = baseColor;
                            let _e539 = stormColor;
                            let _e540 = (*greyness);
                            baseColor = mix(_e538, _e539, vec3(_e540));
                            let _e543 = normal;
                            let _e544 = (*sunDir);
                            diffuse = (0.6f + (0.4f * max(dot(_e543, _e544), 0f)));
                            let _e549 = baseColor;
                            let _e550 = diffuse;
                            (*hitColor) = (_e549 * _e550);
                            return true;
                        }
                    }
                }
            }
            let _e553 = tMax[0u];
            let _e555 = tMax[1u];
            if (_e553 < _e555) {
                let _e558 = tMax[0u];
                let _e560 = tMax[2u];
                if (_e558 < _e560) {
                    let _e563 = stepDir[0u];
                    let _e565 = cellPos[0u];
                    cellPos[0u] = (_e565 + _e563);
                    let _e569 = tMax[0u];
                    t = _e569;
                    let _e571 = tDelta[0u];
                    let _e573 = tMax[0u];
                    tMax[0u] = (_e573 + _e571);
                    let _e577 = stepDir[0u];
                    normal = vec3<f32>(f32(-(_e577)), 0f, 0f);
                } else {
                    let _e582 = stepDir[2u];
                    let _e584 = cellPos[2u];
                    cellPos[2u] = (_e584 + _e582);
                    let _e588 = tMax[2u];
                    t = _e588;
                    let _e590 = tDelta[2u];
                    let _e592 = tMax[2u];
                    tMax[2u] = (_e592 + _e590);
                    let _e596 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e596)));
                }
            } else {
                let _e601 = tMax[1u];
                let _e603 = tMax[2u];
                if (_e601 < _e603) {
                    let _e606 = stepDir[1u];
                    let _e608 = cellPos[1u];
                    cellPos[1u] = (_e608 + _e606);
                    let _e612 = tMax[1u];
                    t = _e612;
                    let _e614 = tDelta[1u];
                    let _e616 = tMax[1u];
                    tMax[1u] = (_e616 + _e614);
                    let _e620 = stepDir[1u];
                    normal = vec3<f32>(0f, f32(-(_e620)), 0f);
                } else {
                    let _e625 = stepDir[2u];
                    let _e627 = cellPos[2u];
                    cellPos[2u] = (_e627 + _e625);
                    let _e631 = tMax[2u];
                    t = _e631;
                    let _e633 = tDelta[2u];
                    let _e635 = tMax[2u];
                    tMax[2u] = (_e635 + _e633);
                    let _e639 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e639)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e643 = i;
            i = (_e643 + 1i);
        }
    }
    return false;
}

fn renderBlackHole_u0028_vf3_u003b_vf3_u003b(normal_1: ptr<function, vec3<f32>>, rayDir_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var rim: f32;
    var glow: f32;

    let _e265 = (*normal_1);
    let _e266 = (*rayDir_1);
    rim = (1f - abs(dot(_e265, _e266)));
    let _e270 = rim;
    glow = pow(clamp(_e270, 0f, 1f), 4f);
    let _e273 = glow;
    return mix(vec3<f32>(0.01f, 0.01f, 0.02f), vec3<f32>(0.85f, 0.45f, 1f), vec3((_e273 * 0.7f)));
}

fn bhDecode_u0028_u1_u003b(code: ptr<function, u32>) -> vec3<i32> {
    var i_1: u32;

    let _e263 = (*code);
    i_1 = (_e263 & 1073741823u);
    let _e265 = i_1;
    let _e267 = tuning.gridWidth;
    let _e272 = i_1;
    let _e274 = tuning.gridWidth;
    let _e279 = tuning.gridHeight;
    let _e284 = i_1;
    let _e286 = tuning.gridWidth;
    let _e289 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e265 % bitcast<u32>(bitcast<i32>(_e267)))), bitcast<i32>(((_e272 / bitcast<u32>(bitcast<i32>(_e274))) % bitcast<u32>(bitcast<i32>(_e279)))), bitcast<i32>((_e284 / bitcast<u32>((bitcast<i32>(_e286) * bitcast<i32>(_e289))))));
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e262 = (*level);
    return (f32(_e262) + 0.5f);
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_1: u32;
    var l: u32;
    var r: f32;
    var param_4: u32;
    var volume: f32;

    level_1 = 0u;
    l = 1u;
    loop {
        let _e267 = l;
        let _e269 = tuning.blackHoleMaxLevel;
        if (_e267 <= min(_e269, 16u)) {
            let _e272 = l;
            param_4 = _e272;
            let _e273 = bhBodyRadius_u0028_u1_u003b((&param_4));
            r = _e273;
            let _e274 = r;
            let _e276 = r;
            let _e278 = r;
            volume = (((4.18879f * _e274) * _e276) * _e278);
            let _e280 = (*mass);
            let _e283 = tuning.blackHoleGrowthCost;
            let _e284 = volume;
            if (f32(_e280) < (_e283 * _e284)) {
                break;
            }
            let _e287 = l;
            level_1 = _e287;
            continue;
        } else {
            break;
        }
        continuing {
            let _e288 = l;
            l = (_e288 + bitcast<u32>(1i));
        }
    }
    let _e291 = level_1;
    return _e291;
}

fn accretionGlow_u0028_vf3_u003b_vi3_u003b(color: ptr<function, vec3<f32>>, voxelPos: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radius: f32;
    var closestSq: f32;
    var seen: u32;
    var i_2: i32;
    var code_1: u32;
    var d: vec3<f32>;
    var param_5: u32;
    var closest: f32;
    var heat: f32;
    var hot: vec3<f32>;
    var phi_2253_: bool;
    var phi_2282_: bool;

    let _e274 = unnamed.blackHoleCount;
    let _e275 = (_e274 == 0u);
    phi_2253_ = _e275;
    if !(_e275) {
        let _e278 = tuning.blackHoleGlow;
        phi_2253_ = (_e278 <= 0f);
    }
    let _e281 = phi_2253_;
    if _e281 {
        let _e282 = (*color);
        return _e282;
    }
    let _e284 = tuning.blackHoleRadius;
    radius = f32(_e284);
    let _e286 = radius;
    let _e287 = radius;
    closestSq = (_e286 * _e287);
    seen = 0u;
    i_2 = 0i;
    loop {
        let _e289 = i_2;
        let _e290 = (_e289 < 8i);
        phi_2282_ = _e290;
        if _e290 {
            let _e291 = seen;
            let _e293 = unnamed.blackHoleCount;
            phi_2282_ = (_e291 < _e293);
        }
        let _e296 = phi_2282_;
        if _e296 {
            let _e297 = i_2;
            let _e300 = unnamed.blackHoles[_e297];
            code_1 = _e300;
            let _e301 = code_1;
            if (_e301 == 0u) {
                continue;
            }
            let _e303 = seen;
            seen = (_e303 + bitcast<u32>(1i));
            let _e306 = code_1;
            param_5 = _e306;
            let _e307 = bhDecode_u0028_u1_u003b((&param_5));
            let _e308 = (*voxelPos);
            d = vec3<f32>((_e307 - _e308));
            let _e311 = closestSq;
            let _e312 = d;
            let _e313 = d;
            closestSq = min(_e311, dot(_e312, _e313));
            continue;
        } else {
            break;
        }
        continuing {
            let _e316 = i_2;
            i_2 = (_e316 + 1i);
        }
    }
    let _e318 = closestSq;
    let _e319 = radius;
    let _e320 = radius;
    if (_e318 >= (_e319 * _e320)) {
        let _e323 = (*color);
        return _e323;
    }
    let _e324 = closestSq;
    closest = sqrt(_e324);
    let _e326 = closest;
    let _e327 = radius;
    let _e332 = tuning.blackHoleGlow;
    heat = (pow((1f - (_e326 / _e327)), 3f) * _e332);
    let _e334 = heat;
    hot = mix(vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(1f, 0.95f, 0.85f), vec3(clamp(_e334, 0f, 1f)));
    let _e338 = (*color);
    let _e339 = hot;
    let _e340 = heat;
    return mix(_e338, _e339, vec3(clamp(_e340, 0f, 1f)));
}

fn renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b(rawVoxel: ptr<function, u32>, voxelPos_1: ptr<function, vec3<i32>>, baseLighting: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n: f32;
    var param_6: vec3<f32>;
    var dist: u32;
    var depth: f32;
    var inner: vec3<f32>;
    var outer: vec3<f32>;
    var leaf: vec3<f32>;

    let _e271 = (*voxelPos_1);
    param_6 = vec3<f32>(_e271);
    let _e273 = hash_u0028_vf3_u003b((&param_6));
    n = _e273;
    let _e274 = (*rawVoxel);
    dist = ((_e274 >> bitcast<u32>(24i)) & 255u);
    let _e278 = dist;
    if (_e278 == 255u) {
        let _e280 = n;
        let _e283 = (*baseLighting);
        return (mix(vec3<f32>(0.34f, 0.22f, 0.07f), vec3<f32>(0.52f, 0.38f, 0.12f), vec3(_e280)) * _e283);
    }
    let _e285 = dist;
    let _e288 = tuning.treeLeafReach;
    depth = clamp((f32(_e285) / max(f32(_e288), 1f)), 0f, 1f);
    inner = vec3<f32>(0.1f, 0.3f, 0.09f);
    outer = vec3<f32>(0.28f, 0.52f, 0.16f);
    let _e293 = inner;
    let _e294 = outer;
    let _e295 = depth;
    let _e297 = n;
    leaf = mix(_e293, _e294, vec3(((_e295 * 0.7f) + (_e297 * 0.3f))));
    let _e302 = leaf;
    let _e303 = (*baseLighting);
    return (_e302 * _e303);
}

fn renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_2: ptr<function, vec3<i32>>, subCell: ptr<function, vec3<f32>>, baseLighting_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var grain: f32;
    var param_7: vec3<f32>;
    var bark: vec3<f32>;

    let _e268 = (*voxelPos_2)[0u];
    let _e271 = (*voxelPos_2)[1u];
    let _e275 = (*subCell)[1u];
    let _e279 = (*voxelPos_2)[2u];
    param_7 = vec3<f32>(f32(_e268), ((f32(_e271) * 0.35f) + (_e275 * 0.2f)), f32(_e279));
    let _e282 = hash_u0028_vf3_u003b((&param_7));
    grain = _e282;
    let _e283 = grain;
    bark = mix(vec3<f32>(0.2f, 0.13f, 0.07f), vec3<f32>(0.38f, 0.25f, 0.13f), vec3(_e283));
    let _e286 = bark;
    let _e287 = (*baseLighting_1);
    return (_e286 * _e287);
}

fn renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_3: ptr<function, vec3<i32>>, subCell_1: ptr<function, vec3<f32>>, baseLighting_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_1: f32;
    var param_8: vec3<f32>;
    var shell: vec3<f32>;

    let _e267 = (*subCell_1);
    let _e269 = (*voxelPos_3);
    param_8 = ((_e267 * 1.37f) + (vec3<f32>(_e269) * 0.11f));
    let _e273 = hash_u0028_vf3_u003b((&param_8));
    n_1 = _e273;
    let _e274 = n_1;
    shell = mix(vec3<f32>(0.15f, 0.1f, 0.035f), vec3<f32>(0.55f, 0.4f, 0.11f), vec3(_e274));
    let _e277 = shell;
    let _e278 = (*baseLighting_2);
    return (_e277 * _e278);
}

fn renderDarkStone_u0028_vi3_u003b_vf3_u003b(voxelPos_4: ptr<function, vec3<i32>>, baseLighting_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise: f32;
    var param_9: vec3<f32>;
    var val: f32;

    let _e266 = (*voxelPos_4);
    param_9 = vec3<f32>(_e266);
    let _e268 = hash_u0028_vf3_u003b((&param_9));
    noise = _e268;
    let _e269 = noise;
    val = (0.1f + (_e269 * 0.06f));
    let _e272 = val;
    let _e274 = val;
    let _e276 = val;
    let _e279 = (*baseLighting_3);
    return (vec3<f32>((_e272 * 1.08f), (_e274 * 0.94f), (_e276 * 0.92f)) * _e279);
}

fn lavaStageColor_u0028_i1_u003b(stage: ptr<function, i32>) -> vec3<f32> {
    var indexable: array<vec3<f32>, 6>;

    let _e263 = (*stage);
    indexable = array<vec3<f32>, 6>(vec3<f32>(1f, 0.62f, 0.22f), vec3<f32>(1f, 0.4f, 0.07f), vec3<f32>(0.96f, 0.29f, 0.05f), vec3<f32>(0.86f, 0.2f, 0.04f), vec3<f32>(0.7f, 0.13f, 0.03f), vec3<f32>(0.44f, 0.07f, 0.02f));
    let _e267 = indexable[clamp((_e263 + 1i), 0i, 5i)];
    return _e267;
}

fn renderLava_u0028_u1_u003b_vi3_u003b(rawVoxel_1: ptr<function, u32>, voxelPos_5: ptr<function, vec3<i32>>) -> vec3<f32> {
    var stage_1: i32;
    var phase: f32;
    var param_10: vec3<f32>;
    var from_: vec3<f32>;
    var param_11: i32;
    var to: vec3<f32>;
    var param_12: i32;
    var leg: f32;
    var param_13: i32;
    var param_14: i32;
    var param_15: i32;
    var param_16: i32;
    var molten: vec3<f32>;
    var param_17: vec3<f32>;

    let _e277 = (*rawVoxel_1);
    stage_1 = clamp((bitcast<i32>((_e277 & 255u)) - 8i), 0i, 3i);
    let _e283 = pc.time;
    let _e285 = tuning.lavaChurnRate;
    let _e287 = (*voxelPos_5);
    param_10 = vec3<f32>(_e287);
    let _e289 = hash_u0028_vf3_u003b((&param_10));
    phase = fract(((_e283 * _e285) + _e289));
    let _e292 = phase;
    if (_e292 < 0.33333334f) {
        let _e294 = stage_1;
        param_11 = (_e294 - 1i);
        let _e296 = lavaStageColor_u0028_i1_u003b((&param_11));
        from_ = _e296;
        let _e297 = stage_1;
        param_12 = _e297;
        let _e298 = lavaStageColor_u0028_i1_u003b((&param_12));
        to = _e298;
        let _e299 = phase;
        leg = (_e299 * 3f);
    } else {
        let _e301 = phase;
        if (_e301 < 0.6666667f) {
            let _e303 = stage_1;
            param_13 = _e303;
            let _e304 = lavaStageColor_u0028_i1_u003b((&param_13));
            from_ = _e304;
            let _e305 = stage_1;
            param_14 = (_e305 + 1i);
            let _e307 = lavaStageColor_u0028_i1_u003b((&param_14));
            to = _e307;
            let _e308 = phase;
            leg = ((_e308 * 3f) - 1f);
        } else {
            let _e311 = stage_1;
            param_15 = (_e311 + 1i);
            let _e313 = lavaStageColor_u0028_i1_u003b((&param_15));
            from_ = _e313;
            let _e314 = stage_1;
            param_16 = (_e314 - 1i);
            let _e316 = lavaStageColor_u0028_i1_u003b((&param_16));
            to = _e316;
            let _e317 = phase;
            leg = ((_e317 * 3f) - 2f);
        }
    }
    let _e320 = from_;
    let _e321 = to;
    let _e322 = leg;
    molten = mix(_e320, _e321, vec3(smoothstep(0f, 1f, _e322)));
    let _e326 = molten;
    let _e327 = (*voxelPos_5);
    param_17 = (vec3<f32>(_e327) * 1.7f);
    let _e330 = hash_u0028_vf3_u003b((&param_17));
    return (_e326 * (0.9f + (_e330 * 0.1f)));
}

fn renderSteam_u0028_vi3_u003b_vf3_u003b(voxelPos_6: ptr<function, vec3<i32>>, baseLighting_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_1: f32;
    var param_18: vec3<f32>;
    var val_1: f32;
    var baseColor_1: vec3<f32>;

    let _e267 = (*voxelPos_6);
    let _e270 = pc.time;
    param_18 = (vec3<f32>(_e267) + vec3(_e270));
    let _e273 = hash_u0028_vf3_u003b((&param_18));
    noise_1 = _e273;
    let _e274 = noise_1;
    val_1 = (0.85f + (_e274 * 0.15f));
    let _e277 = val_1;
    baseColor_1 = vec3(_e277);
    let _e279 = baseColor_1;
    let _e280 = (*baseLighting_4);
    return ((_e279 * _e280) * 0.9f);
}

fn renderFire_u0028_u1_u003b_vi3_u003b(rawVoxel_2: ptr<function, u32>, voxelPos_7: ptr<function, vec3<i32>>) -> vec3<f32> {
    var noise_2: f32;
    var param_19: vec3<f32>;
    var age: u32;
    var life: f32;
    var coreColor: vec3<f32>;
    var edgeColor: vec3<f32>;
    var fireColor: vec3<f32>;

    let _e270 = (*voxelPos_7);
    let _e273 = pc.time;
    param_19 = (vec3<f32>(_e270) + vec3((_e273 * 10f)));
    let _e277 = hash_u0028_vf3_u003b((&param_19));
    noise_2 = _e277;
    let _e278 = (*rawVoxel_2);
    age = ((_e278 >> bitcast<u32>(24i)) & 255u);
    let _e282 = age;
    life = clamp((f32(_e282) / 30f), 0f, 1f);
    coreColor = vec3<f32>(1f, 0.9f, 0.2f);
    edgeColor = vec3<f32>(1f, 0.3f, 0f);
    let _e286 = coreColor;
    let _e287 = edgeColor;
    let _e288 = life;
    let _e289 = noise_2;
    fireColor = mix(_e286, _e287, vec3((_e288 + (_e289 * 0.3f))));
    let _e294 = fireColor;
    return (_e294 * 1.5f);
}

fn renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b(rawVoxel_3: ptr<function, u32>, voxelPos_8: ptr<function, vec3<i32>>, ddaNormal: ptr<function, vec3<f32>>, baseLighting_5: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_3: f32;
    var param_20: vec3<f32>;
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
    var phi_1254_: bool;

    let _e277 = (*voxelPos_8);
    param_20 = vec3<f32>(_e277);
    let _e279 = hash_u0028_vf3_u003b((&param_20));
    noise_3 = _e279;
    let _e280 = noise_3;
    val_2 = (0.8f + (_e280 * 0.2f));
    let _e283 = (*rawVoxel_3);
    moisture = ((_e283 >> bitcast<u32>(24i)) & 255u);
    let _e287 = moisture;
    wetness = clamp((f32(_e287) / 30f), 0f, 1f);
    let _e291 = val_2;
    let _e293 = val_2;
    let _e295 = val_2;
    dryColor = vec3<f32>((0.4f * _e291), (0.25f * _e293), (0.1f * _e295));
    let _e298 = val_2;
    let _e300 = val_2;
    let _e302 = val_2;
    wetColor = vec3<f32>((0.15f * _e298), (0.08f * _e300), (0.03f * _e302));
    let _e305 = dryColor;
    let _e306 = wetColor;
    let _e307 = wetness;
    baseColor_2 = mix(_e305, _e306, vec3(_e307));
    let _e310 = (*rawVoxel_3);
    floraState = ((_e310 >> bitcast<u32>(8i)) & 255u);
    let _e314 = floraState;
    let _e315 = (_e314 > 10u);
    phi_1254_ = _e315;
    if _e315 {
        let _e317 = (*ddaNormal)[1u];
        phi_1254_ = (_e317 > 0.5f);
    }
    let _e320 = phi_1254_;
    if _e320 {
        let _e321 = floraState;
        grassGrow = clamp((f32((_e321 - 10u)) / 90f), 0f, 1f);
        let _e326 = noise_3;
        let _e329 = noise_3;
        grassColor = vec3<f32>((0.15f + (_e326 * 0.1f)), (0.45f + (_e329 * 0.15f)), 0.15f);
        let _e333 = floraState;
        if (_e333 > 100u) {
            let _e335 = floraState;
            drown = clamp((f32((_e335 - 100u)) / 100f), 0f, 1f);
            let _e340 = grassColor;
            let _e341 = drown;
            grassColor = mix(_e340, vec3<f32>(0.35f, 0.35f, 0.15f), vec3(_e341));
        }
        let _e344 = baseColor_2;
        let _e345 = grassColor;
        let _e346 = grassGrow;
        baseColor_2 = mix(_e344, _e345, vec3(_e346));
    }
    let _e349 = baseColor_2;
    let _e350 = (*baseLighting_5);
    return (_e349 * _e350);
}

fn renderStone_u0028_vi3_u003b_vf3_u003b(voxelPos_9: ptr<function, vec3<i32>>, baseLighting_6: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_4: f32;
    var param_21: vec3<f32>;
    var val_3: f32;
    var baseColor_3: vec3<f32>;

    let _e267 = (*voxelPos_9);
    param_21 = vec3<f32>(_e267);
    let _e269 = hash_u0028_vf3_u003b((&param_21));
    noise_4 = _e269;
    let _e270 = noise_4;
    val_3 = (0.4f + (_e270 * 0.3f));
    let _e273 = val_3;
    baseColor_3 = vec3(_e273);
    let _e275 = baseColor_3;
    let _e276 = (*baseLighting_6);
    return (_e275 * _e276);
}

fn renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b(voxelPos_10: ptr<function, vec3<i32>>, normal_2: ptr<function, vec3<f32>>, rayOrigin_1: ptr<function, vec3<f32>>, sunDir_1: ptr<function, vec3<f32>>, sunColor: ptr<function, vec3<f32>>, shadow: ptr<function, f32>, baseLighting_7: ptr<function, vec3<f32>>) -> vec3<f32> {
    var baseColor_4: vec3<f32>;
    var viewDir: vec3<f32>;
    var reflectDir: vec3<f32>;
    var spec: f32;
    var finalLighting: vec3<f32>;

    baseColor_4 = vec3<f32>(0.1f, 0.4f, 0.9f);
    let _e273 = (*rayOrigin_1);
    let _e274 = (*voxelPos_10);
    viewDir = normalize((_e273 - vec3<f32>(_e274)));
    let _e278 = (*sunDir_1);
    let _e280 = (*normal_2);
    reflectDir = reflect(-(_e278), _e280);
    let _e282 = viewDir;
    let _e283 = reflectDir;
    spec = pow(max(dot(_e282, _e283), 0f), 32f);
    let _e287 = (*baseLighting_7);
    let _e288 = (*sunColor);
    let _e289 = spec;
    let _e292 = (*shadow);
    finalLighting = (_e287 + (((_e288 * _e289) * 0.5f) * _e292));
    let _e295 = baseColor_4;
    let _e296 = finalLighting;
    return (_e295 * _e296);
}

fn renderSand_u0028_u1_u003b_vf3_u003b(rawVoxel_4: ptr<function, u32>, baseLighting_8: ptr<function, vec3<f32>>) -> vec3<f32> {
    var moisture_1: u32;
    var wetness_1: f32;
    var dryColor_1: vec3<f32>;
    var wetColor_1: vec3<f32>;
    var baseColor_5: vec3<f32>;

    let _e268 = (*rawVoxel_4);
    moisture_1 = ((_e268 >> bitcast<u32>(24i)) & 255u);
    let _e272 = moisture_1;
    wetness_1 = clamp((f32(_e272) / 10f), 0f, 1f);
    dryColor_1 = vec3<f32>(0.9f, 0.8f, 0.2f);
    wetColor_1 = vec3<f32>(0.65f, 0.55f, 0.15f);
    let _e276 = dryColor_1;
    let _e277 = wetColor_1;
    let _e278 = wetness_1;
    baseColor_5 = mix(_e276, _e277, vec3(_e278));
    let _e281 = baseColor_5;
    let _e282 = (*baseLighting_8);
    return (_e281 * _e282);
}

fn getVoxel_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    var index: u32;
    var phi_269_: bool;
    var phi_277_: bool;
    var phi_287_: bool;
    var phi_295_: bool;
    var phi_305_: bool;

    let _e264 = (*pos)[0u];
    let _e265 = (_e264 < 0i);
    phi_269_ = _e265;
    if !(_e265) {
        let _e268 = (*pos)[0u];
        let _e270 = tuning.gridWidth;
        phi_269_ = (_e268 >= bitcast<i32>(_e270));
    }
    let _e274 = phi_269_;
    phi_277_ = _e274;
    if !(_e274) {
        let _e277 = (*pos)[1u];
        phi_277_ = (_e277 < 0i);
    }
    let _e280 = phi_277_;
    phi_287_ = _e280;
    if !(_e280) {
        let _e283 = (*pos)[1u];
        let _e285 = tuning.gridHeight;
        phi_287_ = (_e283 >= bitcast<i32>(_e285));
    }
    let _e289 = phi_287_;
    phi_295_ = _e289;
    if !(_e289) {
        let _e292 = (*pos)[2u];
        phi_295_ = (_e292 < 0i);
    }
    let _e295 = phi_295_;
    phi_305_ = _e295;
    if !(_e295) {
        let _e298 = (*pos)[2u];
        let _e300 = tuning.gridDepth;
        phi_305_ = (_e298 >= bitcast<i32>(_e300));
    }
    let _e304 = phi_305_;
    if _e304 {
        return 0u;
    }
    let _e306 = (*pos)[0u];
    let _e308 = (*pos)[1u];
    let _e310 = tuning.gridWidth;
    let _e315 = (*pos)[2u];
    let _e317 = tuning.gridWidth;
    let _e321 = tuning.gridHeight;
    index = bitcast<u32>(((_e306 + (_e308 * bitcast<i32>(_e310))) + ((_e315 * bitcast<i32>(_e317)) * bitcast<i32>(_e321))));
    let _e326 = index;
    let _e329 = unnamed_1.grid[_e326];
    return _e329;
}

fn calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b(hitVoxelPos: ptr<function, vec3<i32>>, hitNormal: ptr<function, vec3<f32>>, lightDir: ptr<function, vec3<f32>>, ceilingY: ptr<function, i32>) -> f32 {
    var voxelPos_11: vec3<i32>;
    var stepDir_1: vec3<i32>;
    var tDelta_1: vec3<f32>;
    var local_6: f32;
    var local_7: f32;
    var local_8: f32;
    var tMax_1: vec3<f32>;
    var transmittance: f32;
    var i_3: i32;
    var blockerType: u32;
    var param_22: vec3<i32>;
    var phi_586_: bool;
    var phi_593_: bool;
    var phi_601_: bool;
    var phi_608_: bool;
    var phi_618_: bool;

    let _e276 = (*hitVoxelPos);
    let _e277 = (*hitNormal);
    voxelPos_11 = (_e276 + vec3<i32>(round(_e277)));
    let _e281 = (*lightDir);
    stepDir_1 = vec3<i32>(sign(_e281));
    let _e285 = (*lightDir)[0u];
    if (_e285 == 0f) {
        local_6 = 100000000f;
    } else {
        let _e288 = (*lightDir)[0u];
        local_6 = abs((1f / _e288));
    }
    let _e291 = local_6;
    let _e293 = (*lightDir)[1u];
    if (_e293 == 0f) {
        local_7 = 100000000f;
    } else {
        let _e296 = (*lightDir)[1u];
        local_7 = abs((1f / _e296));
    }
    let _e299 = local_7;
    let _e301 = (*lightDir)[2u];
    if (_e301 == 0f) {
        local_8 = 100000000f;
    } else {
        let _e304 = (*lightDir)[2u];
        local_8 = abs((1f / _e304));
    }
    let _e307 = local_8;
    tDelta_1 = vec3<f32>(_e291, _e299, _e307);
    let _e309 = tDelta_1;
    tMax_1 = (_e309 * 0.5f);
    transmittance = 1f;
    i_3 = 0i;
    loop {
        let _e311 = i_3;
        let _e313 = tuning.shadowMaxSteps;
        if (_e311 < bitcast<i32>(_e313)) {
            let _e317 = voxelPos_11[0u];
            let _e318 = (_e317 < 0i);
            phi_586_ = _e318;
            if !(_e318) {
                let _e321 = voxelPos_11[0u];
                let _e323 = tuning.gridWidth;
                phi_586_ = (_e321 >= bitcast<i32>(_e323));
            }
            let _e327 = phi_586_;
            phi_593_ = _e327;
            if !(_e327) {
                let _e330 = voxelPos_11[1u];
                phi_593_ = (_e330 < 0i);
            }
            let _e333 = phi_593_;
            phi_601_ = _e333;
            if !(_e333) {
                let _e336 = voxelPos_11[1u];
                let _e337 = (*ceilingY);
                phi_601_ = (_e336 >= _e337);
            }
            let _e340 = phi_601_;
            phi_608_ = _e340;
            if !(_e340) {
                let _e343 = voxelPos_11[2u];
                phi_608_ = (_e343 < 0i);
            }
            let _e346 = phi_608_;
            phi_618_ = _e346;
            if !(_e346) {
                let _e349 = voxelPos_11[2u];
                let _e351 = tuning.gridDepth;
                phi_618_ = (_e349 >= bitcast<i32>(_e351));
            }
            let _e355 = phi_618_;
            if _e355 {
                let _e356 = transmittance;
                return _e356;
            }
            let _e357 = voxelPos_11;
            param_22 = _e357;
            let _e358 = getVoxel_u0028_vi3_u003b((&param_22));
            blockerType = (_e358 & 255u);
            let _e360 = blockerType;
            if (_e360 == 2u) {
                let _e363 = tuning.waterShadowTransmit;
                let _e364 = transmittance;
                transmittance = (_e364 * _e363);
                let _e366 = transmittance;
                if (_e366 < 0.02f) {
                    return 0f;
                }
            } else {
                let _e368 = blockerType;
                if (_e368 != 0u) {
                    return 0f;
                }
            }
            let _e371 = tMax_1[0u];
            let _e373 = tMax_1[1u];
            if (_e371 < _e373) {
                let _e376 = tMax_1[0u];
                let _e378 = tMax_1[2u];
                if (_e376 < _e378) {
                    let _e381 = stepDir_1[0u];
                    let _e383 = voxelPos_11[0u];
                    voxelPos_11[0u] = (_e383 + _e381);
                    let _e387 = tDelta_1[0u];
                    let _e389 = tMax_1[0u];
                    tMax_1[0u] = (_e389 + _e387);
                } else {
                    let _e393 = stepDir_1[2u];
                    let _e395 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e395 + _e393);
                    let _e399 = tDelta_1[2u];
                    let _e401 = tMax_1[2u];
                    tMax_1[2u] = (_e401 + _e399);
                }
            } else {
                let _e405 = tMax_1[1u];
                let _e407 = tMax_1[2u];
                if (_e405 < _e407) {
                    let _e410 = stepDir_1[1u];
                    let _e412 = voxelPos_11[1u];
                    voxelPos_11[1u] = (_e412 + _e410);
                    let _e416 = tDelta_1[1u];
                    let _e418 = tMax_1[1u];
                    tMax_1[1u] = (_e418 + _e416);
                } else {
                    let _e422 = stepDir_1[2u];
                    let _e424 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e424 + _e422);
                    let _e428 = tDelta_1[2u];
                    let _e430 = tMax_1[2u];
                    tMax_1[2u] = (_e430 + _e428);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e433 = i_3;
            i_3 = (_e433 + 1i);
        }
    }
    let _e435 = transmittance;
    return _e435;
}

fn getSmoothNormal_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> vec3<f32> {
    var n_2: vec3<f32>;
    var x_1: i32;
    var y: i32;
    var z_1: i32;
    var param_23: vec3<i32>;
    var offset: vec3<f32>;

    n_2 = vec3<f32>(0f, 0f, 0f);
    x_1 = -1i;
    loop {
        let _e268 = x_1;
        if (_e268 <= 1i) {
            y = -1i;
            loop {
                let _e270 = y;
                if (_e270 <= 1i) {
                    z_1 = -1i;
                    loop {
                        let _e272 = z_1;
                        if (_e272 <= 1i) {
                            let _e274 = x_1;
                            let _e276 = y;
                            let _e279 = z_1;
                            if (((_e274 == 0i) && (_e276 == 0i)) && (_e279 == 0i)) {
                                continue;
                            }
                            let _e282 = (*p_1);
                            let _e283 = x_1;
                            let _e284 = y;
                            let _e285 = z_1;
                            param_23 = (_e282 + vec3<i32>(_e283, _e284, _e285));
                            let _e288 = getVoxel_u0028_vi3_u003b((&param_23));
                            if ((_e288 & 255u) == 0u) {
                                continue;
                            }
                            let _e291 = x_1;
                            let _e293 = y;
                            let _e295 = z_1;
                            offset = vec3<f32>(f32(_e291), f32(_e293), f32(_e295));
                            let _e298 = offset;
                            let _e299 = x_1;
                            let _e300 = x_1;
                            let _e302 = y;
                            let _e303 = y;
                            let _e306 = z_1;
                            let _e307 = z_1;
                            let _e313 = n_2;
                            n_2 = (_e313 - (_e298 * inverseSqrt(f32((((_e299 * _e300) + (_e302 * _e303)) + (_e306 * _e307))))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e315 = z_1;
                            z_1 = (_e315 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e317 = y;
                    y = (_e317 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e319 = x_1;
            x_1 = (_e319 + 1i);
        }
    }
    let _e321 = n_2;
    if (length(_e321) < 0.1f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e324 = n_2;
    return normalize(_e324);
}

fn waterWaveGradient_u0028_vf2_u003b_f1_u003b(p_2: ptr<function, vec2<f32>>, t_1: ptr<function, f32>) -> vec2<f32> {
    var scale: f32;
    var wt: f32;
    var q: vec2<f32>;
    var grad: vec2<f32>;
    var i_4: i32;
    var f: f32;
    var indexable_1: array<f32, 5>;
    var phase_1: f32;
    var indexable_2: array<vec2<f32>, 5>;
    var indexable_3: array<f32, 5>;
    var indexable_4: array<vec2<f32>, 5>;
    var indexable_5: array<f32, 5>;
    var envelope: f32;

    let _e277 = tuning.waterWaveScale;
    scale = max(_e277, 0.001f);
    let _e279 = (*t_1);
    let _e281 = tuning.waterWaveSpeed;
    wt = ((_e279 * _e281) * 0.35f);
    let _e284 = (*p_2);
    let _e286 = (*p_2)[1u];
    let _e288 = wt;
    let _e292 = (*p_2)[0u];
    let _e294 = wt;
    q = (_e284 + (vec2<f32>(sin(((_e286 * 0.043f) + _e288)), sin(((_e292 * 0.037f) - (_e294 * 0.8f)))) * 6f));
    grad = vec2<f32>(0f, 0f);
    i_4 = 0i;
    loop {
        let _e301 = i_4;
        if (_e301 < 5i) {
            let _e303 = i_4;
            indexable_1 = array<f32, 5>(0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
            let _e305 = indexable_1[_e303];
            let _e306 = scale;
            f = (_e305 * _e306);
            let _e308 = i_4;
            indexable_2 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e310 = indexable_2[_e308];
            let _e311 = q;
            let _e313 = f;
            let _e315 = (*t_1);
            let _e316 = i_4;
            indexable_3 = array<f32, 5>(1f, 1.37f, 0.83f, 1.71f, 0.61f);
            let _e318 = indexable_3[_e316];
            let _e321 = tuning.waterWaveSpeed;
            phase_1 = ((dot(_e310, _e311) * _e313) + ((_e315 * _e318) * _e321));
            let _e324 = i_4;
            indexable_4 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e326 = indexable_4[_e324];
            let _e327 = i_4;
            indexable_5 = array<f32, 5>(1f, 0.62f, 0.38f, 0.24f, 0.15f);
            let _e329 = indexable_5[_e327];
            let _e330 = f;
            let _e332 = phase_1;
            let _e336 = grad;
            grad = (_e336 + (_e326 * ((_e329 * _e330) * cos(_e332))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e338 = i_4;
            i_4 = (_e338 + 1i);
        }
    }
    let _e341 = (*p_2)[0u];
    let _e344 = (*p_2)[1u];
    let _e347 = (*t_1);
    envelope = (0.45f + (0.55f * sin((((_e341 * 0.021f) + (_e344 * 0.017f)) + (_e347 * 0.11f)))));
    let _e353 = grad;
    let _e354 = envelope;
    return (_e353 * _e354);
}

fn applyWaterWaves_u0028_vf3_u003b_vi3_u003b(normal_3: ptr<function, vec3<f32>>, voxelPos_12: ptr<function, vec3<i32>>) -> vec3<f32> {
    var upness: f32;
    var grad_1: vec2<f32>;
    var param_24: vec2<f32>;
    var param_25: f32;

    let _e268 = tuning.waterWaveStrength;
    if (_e268 <= 0f) {
        let _e270 = (*normal_3);
        return _e270;
    }
    let _e272 = (*normal_3)[1u];
    upness = clamp(_e272, 0f, 1f);
    let _e274 = upness;
    if (_e274 <= 0f) {
        let _e276 = (*normal_3);
        return _e276;
    }
    let _e277 = (*voxelPos_12);
    param_24 = (vec2<f32>(_e277.xz) + vec2<f32>(0.5f, 0.5f));
    let _e282 = pc.time;
    param_25 = _e282;
    let _e283 = waterWaveGradient_u0028_vf2_u003b_f1_u003b((&param_24), (&param_25));
    grad_1 = _e283;
    let _e284 = (*normal_3);
    let _e286 = grad_1[0u];
    let _e289 = grad_1[1u];
    let _e293 = tuning.waterWaveStrength;
    let _e295 = upness;
    return normalize((_e284 + ((vec3<f32>(-(_e286), 0f, -(_e289)) * _e293) * _e295)));
}

fn getWaterNormal_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> vec3<f32> {
    var n_3: vec3<f32>;
    var x_2: i32;
    var y_1: i32;
    var z_2: i32;
    var d2_: i32;
    var param_26: vec3<i32>;

    n_3 = vec3<f32>(0f, 0f, 0f);
    x_2 = -2i;
    loop {
        let _e268 = x_2;
        if (_e268 <= 2i) {
            y_1 = -2i;
            loop {
                let _e270 = y_1;
                if (_e270 <= 2i) {
                    z_2 = -2i;
                    loop {
                        let _e272 = z_2;
                        if (_e272 <= 2i) {
                            let _e274 = x_2;
                            let _e276 = y_1;
                            let _e279 = z_2;
                            if (((_e274 == 0i) && (_e276 == 0i)) && (_e279 == 0i)) {
                                continue;
                            }
                            let _e282 = x_2;
                            let _e283 = x_2;
                            let _e285 = y_1;
                            let _e286 = y_1;
                            let _e289 = z_2;
                            let _e290 = z_2;
                            d2_ = (((_e282 * _e283) + (_e285 * _e286)) + (_e289 * _e290));
                            let _e293 = d2_;
                            if (_e293 > 6i) {
                                continue;
                            }
                            let _e295 = (*p_3);
                            let _e296 = x_2;
                            let _e297 = y_1;
                            let _e298 = z_2;
                            param_26 = (_e295 + vec3<i32>(_e296, _e297, _e298));
                            let _e301 = getVoxel_u0028_vi3_u003b((&param_26));
                            if ((_e301 & 255u) == 0u) {
                                continue;
                            }
                            let _e304 = x_2;
                            let _e306 = y_1;
                            let _e308 = z_2;
                            let _e311 = d2_;
                            let _e315 = n_3;
                            n_3 = (_e315 - (vec3<f32>(f32(_e304), f32(_e306), f32(_e308)) / vec3(f32(_e311))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e317 = z_2;
                            z_2 = (_e317 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e319 = y_1;
                    y_1 = (_e319 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e321 = x_2;
            x_2 = (_e321 + 1i);
        }
    }
    let _e323 = n_3;
    if (length(_e323) < 0.001f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e326 = n_3;
    return normalize(_e326);
}

fn locustDensity_u0028_u1_u003b(type_38: ptr<function, u32>) -> f32 {
    var stage_2: f32;

    let _e263 = (*type_38);
    stage_2 = (f32((_e263 - 13u)) / 4f);
    let _e268 = tuning.locustDensityMin;
    let _e270 = tuning.locustDensityMax;
    let _e271 = stage_2;
    return clamp(mix(_e268, _e270, _e271), 0.02f, 0.98f);
}

fn trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b(voxelPos_13: ptr<function, vec3<i32>>, a: ptr<function, vec2<f32>>, b: ptr<function, vec2<f32>>, count_1: ptr<function, i32>) {
    var h0_: f32;
    var param_27: vec3<f32>;
    var h1_: f32;
    var param_28: vec3<f32>;
    var h2_: f32;
    var param_29: vec3<f32>;

    let _e272 = (*voxelPos_13)[0u];
    let _e275 = (*voxelPos_13)[2u];
    param_27 = vec3<f32>(f32(_e272), 7f, f32(_e275));
    let _e278 = hash_u0028_vf3_u003b((&param_27));
    h0_ = _e278;
    let _e280 = (*voxelPos_13)[0u];
    let _e283 = (*voxelPos_13)[2u];
    param_28 = vec3<f32>(f32(_e280), 19f, f32(_e283));
    let _e286 = hash_u0028_vf3_u003b((&param_28));
    h1_ = _e286;
    let _e288 = (*voxelPos_13)[0u];
    let _e291 = (*voxelPos_13)[2u];
    param_29 = vec3<f32>(f32(_e288), 53f, f32(_e291));
    let _e294 = hash_u0028_vf3_u003b((&param_29));
    h2_ = _e294;
    let _e295 = h2_;
    let _e297 = tuning.treeTrunkColumns;
    (*count_1) = (1i + i32((_e295 * f32(max(bitcast<i32>(_e297), 1i)))));
    let _e304 = (*count_1);
    (*count_1) = clamp(_e304, 1i, 2i);
    let _e306 = h0_;
    let _e309 = h1_;
    (*a) = vec2<f32>((0.3f + (_e306 * 0.4f)), (0.3f + (_e309 * 0.4f)));
    let _e313 = h1_;
    let _e316 = h0_;
    (*b) = vec2<f32>((0.3f + (_e313 * 0.4f)), (0.3f + (_e316 * 0.4f)));
    return;
}

fn subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b(kind: ptr<function, u32>, type_39: ptr<function, u32>, voxelPos_14: ptr<function, vec3<i32>>, cell: ptr<function, vec3<i32>>, sub: ptr<function, i32>, jitter: ptr<function, vec3<f32>>) -> bool {
    var p_4: vec2<f32>;
    var a_1: vec2<f32>;
    var b_1: vec2<f32>;
    var count_2: i32;
    var param_30: vec3<i32>;
    var param_31: vec2<f32>;
    var param_32: vec2<f32>;
    var param_33: i32;
    var r_1: f32;
    var param_34: vec3<f32>;
    var param_35: u32;
    var phi_1620_: bool;

    let _e278 = (*kind);
    if (_e278 == 1u) {
        let _e280 = (*cell);
        let _e285 = (*sub);
        p_4 = ((vec2<f32>(_e280.xz) + vec2(0.5f)) / vec2(f32(_e285)));
        let _e289 = (*voxelPos_14);
        param_30 = _e289;
        trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b((&param_30), (&param_31), (&param_32), (&param_33));
        let _e290 = param_31;
        a_1 = _e290;
        let _e291 = param_32;
        b_1 = _e291;
        let _e292 = param_33;
        count_2 = _e292;
        let _e294 = tuning.treeTrunkRadius;
        r_1 = max(_e294, 0.02f);
        let _e296 = p_4;
        let _e297 = a_1;
        let _e299 = p_4;
        let _e300 = a_1;
        let _e303 = r_1;
        let _e304 = r_1;
        if (dot((_e296 - _e297), (_e299 - _e300)) <= (_e303 * _e304)) {
            return true;
        }
        let _e307 = count_2;
        let _e308 = (_e307 > 1i);
        phi_1620_ = _e308;
        if _e308 {
            let _e309 = p_4;
            let _e310 = b_1;
            let _e312 = p_4;
            let _e313 = b_1;
            let _e316 = r_1;
            let _e317 = r_1;
            phi_1620_ = (dot((_e309 - _e310), (_e312 - _e313)) <= (_e316 * _e317));
        }
        let _e321 = phi_1620_;
        if _e321 {
            return true;
        }
        return false;
    }
    let _e322 = (*voxelPos_14);
    let _e323 = (*sub);
    let _e326 = (*cell);
    let _e329 = (*jitter);
    param_34 = (vec3<f32>(((_e322 * vec3(_e323)) + _e326)) + _e329);
    let _e331 = hash_u0028_vf3_u003b((&param_34));
    let _e332 = (*type_39);
    param_35 = _e332;
    let _e333 = locustDensity_u0028_u1_u003b((&param_35));
    return (_e331 < _e333);
}

fn intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b(ro: ptr<function, vec3<f32>>, rd: ptr<function, vec3<f32>>, boxMin: ptr<function, vec3<f32>>, boxMax: ptr<function, vec3<f32>>) -> vec2<f32> {
    var tMin: vec3<f32>;
    var tMax_2: vec3<f32>;
    var t1_: vec3<f32>;
    var t2_: vec3<f32>;
    var tNear: f32;
    var tFar: f32;

    let _e271 = (*boxMin);
    let _e272 = (*ro);
    let _e274 = (*rd);
    tMin = ((_e271 - _e272) / _e274);
    let _e276 = (*boxMax);
    let _e277 = (*ro);
    let _e279 = (*rd);
    tMax_2 = ((_e276 - _e277) / _e279);
    let _e281 = tMin;
    let _e282 = tMax_2;
    t1_ = min(_e281, _e282);
    let _e284 = tMin;
    let _e285 = tMax_2;
    t2_ = max(_e284, _e285);
    let _e288 = t1_[0u];
    let _e290 = t1_[1u];
    let _e293 = t1_[2u];
    tNear = max(max(_e288, _e290), _e293);
    let _e296 = t2_[0u];
    let _e298 = t2_[1u];
    let _e301 = t2_[2u];
    tFar = min(min(_e296, _e298), _e301);
    let _e303 = tNear;
    let _e304 = tFar;
    return vec2<f32>(_e303, _e304);
}

fn subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b(voxelPos_15: ptr<function, vec3<i32>>, rayOrigin_2: ptr<function, vec3<f32>>, rayDir_2: ptr<function, vec3<f32>>, kind_1: ptr<function, u32>, type_40: ptr<function, u32>, entryNormal: ptr<function, vec3<f32>>, tHit_1: ptr<function, f32>, subNormal: ptr<function, vec3<f32>>, subCell_2: ptr<function, vec3<f32>>) -> bool {
    var sub_1: i32;
    var cellSize: f32;
    var boxMin_1: vec3<f32>;
    var span: vec2<f32>;
    var param_36: vec3<f32>;
    var param_37: vec3<f32>;
    var param_38: vec3<f32>;
    var param_39: vec3<f32>;
    var t_2: f32;
    var local_9: vec3<f32>;
    var c: vec3<i32>;
    var stepDir_2: vec3<i32>;
    var tDelta_2: vec3<f32>;
    var local_10: f32;
    var local_11: f32;
    var local_12: f32;
    var fracPos_1: vec3<f32>;
    var tMax_3: vec3<f32>;
    var local_13: f32;
    var local_14: f32;
    var local_15: f32;
    var jitter_1: vec3<f32>;
    var local_16: vec3<f32>;
    var i_5: i32;
    var param_40: u32;
    var param_41: u32;
    var param_42: vec3<i32>;
    var param_43: vec3<i32>;
    var param_44: i32;
    var param_45: vec3<f32>;
    var phi_1852_: bool;
    var phi_1859_: bool;
    var phi_1867_: bool;
    var phi_1874_: bool;
    var phi_1882_: bool;

    (*tHit_1) = 0f;
    let _e300 = (*entryNormal);
    (*subNormal) = _e300;
    (*subCell_2) = vec3<f32>(0f, 0f, 0f);
    let _e302 = tuning.locustSubdivision;
    sub_1 = clamp(bitcast<i32>(_e302), 1i, 8i);
    let _e305 = sub_1;
    cellSize = (1f / f32(_e305));
    let _e308 = (*voxelPos_15);
    boxMin_1 = vec3<f32>(_e308);
    let _e310 = boxMin_1;
    let _e312 = (*rayOrigin_2);
    param_36 = _e312;
    let _e313 = (*rayDir_2);
    param_37 = _e313;
    let _e314 = boxMin_1;
    param_38 = _e314;
    param_39 = (_e310 + vec3<f32>(1f, 1f, 1f));
    let _e315 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_36), (&param_37), (&param_38), (&param_39));
    span = _e315;
    let _e317 = span[0u];
    t_2 = max(_e317, 0f);
    let _e319 = t_2;
    let _e321 = span[1u];
    if (_e319 > _e321) {
        return false;
    }
    let _e323 = (*rayOrigin_2);
    let _e324 = (*rayDir_2);
    let _e325 = t_2;
    let _e329 = boxMin_1;
    let _e331 = sub_1;
    local_9 = (((_e323 + (_e324 * (_e325 + 0.0001f))) - _e329) * f32(_e331));
    let _e334 = local_9;
    let _e337 = sub_1;
    c = clamp(vec3<i32>(floor(_e334)), vec3<i32>(0i, 0i, 0i), vec3((_e337 - 1i)));
    let _e341 = (*rayDir_2);
    stepDir_2 = vec3<i32>(sign(_e341));
    let _e345 = (*rayDir_2)[0u];
    if (_e345 == 0f) {
        local_10 = 1000000f;
    } else {
        let _e347 = cellSize;
        let _e349 = (*rayDir_2)[0u];
        local_10 = abs((_e347 / _e349));
    }
    let _e352 = local_10;
    let _e354 = (*rayDir_2)[1u];
    if (_e354 == 0f) {
        local_11 = 1000000f;
    } else {
        let _e356 = cellSize;
        let _e358 = (*rayDir_2)[1u];
        local_11 = abs((_e356 / _e358));
    }
    let _e361 = local_11;
    let _e363 = (*rayDir_2)[2u];
    if (_e363 == 0f) {
        local_12 = 1000000f;
    } else {
        let _e365 = cellSize;
        let _e367 = (*rayDir_2)[2u];
        local_12 = abs((_e365 / _e367));
    }
    let _e370 = local_12;
    tDelta_2 = vec3<f32>(_e352, _e361, _e370);
    let _e372 = local_9;
    let _e373 = c;
    fracPos_1 = (_e372 - vec3<f32>(_e373));
    let _e376 = t_2;
    let _e378 = stepDir_2[0u];
    if (_e378 > 0i) {
        let _e381 = fracPos_1[0u];
        let _e384 = tDelta_2[0u];
        local_13 = ((1f - _e381) * _e384);
    } else {
        let _e387 = fracPos_1[0u];
        let _e389 = tDelta_2[0u];
        local_13 = (_e387 * _e389);
    }
    let _e391 = local_13;
    let _e393 = stepDir_2[1u];
    if (_e393 > 0i) {
        let _e396 = fracPos_1[1u];
        let _e399 = tDelta_2[1u];
        local_14 = ((1f - _e396) * _e399);
    } else {
        let _e402 = fracPos_1[1u];
        let _e404 = tDelta_2[1u];
        local_14 = (_e402 * _e404);
    }
    let _e406 = local_14;
    let _e408 = stepDir_2[2u];
    if (_e408 > 0i) {
        let _e411 = fracPos_1[2u];
        let _e414 = tDelta_2[2u];
        local_15 = ((1f - _e411) * _e414);
    } else {
        let _e417 = fracPos_1[2u];
        let _e419 = tDelta_2[2u];
        local_15 = (_e417 * _e419);
    }
    let _e421 = local_15;
    tMax_3 = (vec3(_e376) + vec3<f32>(_e391, _e406, _e421));
    let _e425 = (*kind_1);
    if (_e425 == 0u) {
        let _e428 = pc.time;
        let _e430 = tuning.locustCrawlRate;
        local_16 = vec3((floor((_e428 * _e430)) * 1.7f));
    } else {
        local_16 = vec3<f32>(0f, 0f, 0f);
    }
    let _e435 = local_16;
    jitter_1 = _e435;
    i_5 = 0i;
    loop {
        let _e436 = i_5;
        let _e437 = sub_1;
        if (_e436 < (3i * _e437)) {
            let _e441 = c[0u];
            let _e442 = (_e441 < 0i);
            phi_1852_ = _e442;
            if !(_e442) {
                let _e445 = c[0u];
                let _e446 = sub_1;
                phi_1852_ = (_e445 >= _e446);
            }
            let _e449 = phi_1852_;
            phi_1859_ = _e449;
            if !(_e449) {
                let _e452 = c[1u];
                phi_1859_ = (_e452 < 0i);
            }
            let _e455 = phi_1859_;
            phi_1867_ = _e455;
            if !(_e455) {
                let _e458 = c[1u];
                let _e459 = sub_1;
                phi_1867_ = (_e458 >= _e459);
            }
            let _e462 = phi_1867_;
            phi_1874_ = _e462;
            if !(_e462) {
                let _e465 = c[2u];
                phi_1874_ = (_e465 < 0i);
            }
            let _e468 = phi_1874_;
            phi_1882_ = _e468;
            if !(_e468) {
                let _e471 = c[2u];
                let _e472 = sub_1;
                phi_1882_ = (_e471 >= _e472);
            }
            let _e475 = phi_1882_;
            if _e475 {
                return false;
            }
            let _e476 = (*kind_1);
            param_40 = _e476;
            let _e477 = (*type_40);
            param_41 = _e477;
            let _e478 = (*voxelPos_15);
            param_42 = _e478;
            let _e479 = c;
            param_43 = _e479;
            let _e480 = sub_1;
            param_44 = _e480;
            let _e481 = jitter_1;
            param_45 = _e481;
            let _e482 = subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b((&param_40), (&param_41), (&param_42), (&param_43), (&param_44), (&param_45));
            if _e482 {
                let _e483 = t_2;
                (*tHit_1) = _e483;
                let _e484 = c;
                (*subCell_2) = vec3<f32>(_e484);
                return true;
            }
            let _e487 = tMax_3[0u];
            let _e489 = tMax_3[1u];
            if (_e487 < _e489) {
                let _e492 = tMax_3[0u];
                let _e494 = tMax_3[2u];
                if (_e492 < _e494) {
                    let _e497 = stepDir_2[0u];
                    let _e499 = c[0u];
                    c[0u] = (_e499 + _e497);
                    let _e503 = tMax_3[0u];
                    t_2 = _e503;
                    let _e505 = tDelta_2[0u];
                    let _e507 = tMax_3[0u];
                    tMax_3[0u] = (_e507 + _e505);
                    let _e511 = stepDir_2[0u];
                    (*subNormal) = vec3<f32>(f32(-(_e511)), 0f, 0f);
                } else {
                    let _e516 = stepDir_2[2u];
                    let _e518 = c[2u];
                    c[2u] = (_e518 + _e516);
                    let _e522 = tMax_3[2u];
                    t_2 = _e522;
                    let _e524 = tDelta_2[2u];
                    let _e526 = tMax_3[2u];
                    tMax_3[2u] = (_e526 + _e524);
                    let _e530 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e530)));
                }
            } else {
                let _e535 = tMax_3[1u];
                let _e537 = tMax_3[2u];
                if (_e535 < _e537) {
                    let _e540 = stepDir_2[1u];
                    let _e542 = c[1u];
                    c[1u] = (_e542 + _e540);
                    let _e546 = tMax_3[1u];
                    t_2 = _e546;
                    let _e548 = tDelta_2[1u];
                    let _e550 = tMax_3[1u];
                    tMax_3[1u] = (_e550 + _e548);
                    let _e554 = stepDir_2[1u];
                    (*subNormal) = vec3<f32>(0f, f32(-(_e554)), 0f);
                } else {
                    let _e559 = stepDir_2[2u];
                    let _e561 = c[2u];
                    c[2u] = (_e561 + _e559);
                    let _e565 = tMax_3[2u];
                    t_2 = _e565;
                    let _e567 = tDelta_2[2u];
                    let _e569 = tMax_3[2u];
                    tMax_3[2u] = (_e569 + _e567);
                    let _e573 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e573)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e577 = i_5;
            i_5 = (_e577 + 1i);
        }
    }
    return false;
}

fn isLocustType_u0028_u1_u003b(type_41: ptr<function, u32>) -> bool {
    let _e262 = (*type_41);
    let _e264 = (*type_41);
    return ((_e262 >= 13u) && (_e264 <= 17u));
}

fn marchCeiling_u0028_() -> i32 {
    let _e262 = tuning.gridHeight;
    let _e265 = unnamed.maxOccupiedY;
    return min(bitcast<i32>(_e262), (bitcast<i32>(_e265) + 2i));
}

fn worldExtent_u0028_() -> vec3<f32> {
    let _e262 = tuning.gridWidth;
    let _e266 = tuning.gridHeight;
    let _e270 = tuning.gridDepth;
    return vec3<f32>(f32(bitcast<i32>(_e262)), f32(bitcast<i32>(_e266)), f32(bitcast<i32>(_e270)));
}

fn isEdge_u0028_vf3_u003b(p_5: ptr<function, vec3<f32>>) -> bool {
    var thickness_1: f32;
    var boundCount: i32;
    var extent: vec3<f32>;
    var phi_461_: bool;
    var phi_480_: bool;
    var phi_499_: bool;

    thickness_1 = 0.3f;
    boundCount = 0i;
    let _e265 = worldExtent_u0028_();
    extent = _e265;
    let _e267 = (*p_5)[0u];
    let _e268 = thickness_1;
    let _e269 = (_e267 < _e268);
    phi_461_ = _e269;
    if !(_e269) {
        let _e272 = (*p_5)[0u];
        let _e274 = extent[0u];
        let _e275 = thickness_1;
        phi_461_ = (_e272 > (_e274 - _e275));
    }
    let _e279 = phi_461_;
    if _e279 {
        let _e280 = boundCount;
        boundCount = (_e280 + 1i);
    }
    let _e283 = (*p_5)[1u];
    let _e284 = thickness_1;
    let _e285 = (_e283 < _e284);
    phi_480_ = _e285;
    if !(_e285) {
        let _e288 = (*p_5)[1u];
        let _e290 = extent[1u];
        let _e291 = thickness_1;
        phi_480_ = (_e288 > (_e290 - _e291));
    }
    let _e295 = phi_480_;
    if _e295 {
        let _e296 = boundCount;
        boundCount = (_e296 + 1i);
    }
    let _e299 = (*p_5)[2u];
    let _e300 = thickness_1;
    let _e301 = (_e299 < _e300);
    phi_499_ = _e301;
    if !(_e301) {
        let _e304 = (*p_5)[2u];
        let _e306 = extent[2u];
        let _e307 = thickness_1;
        phi_499_ = (_e304 > (_e306 - _e307));
    }
    let _e311 = phi_499_;
    if _e311 {
        let _e312 = boundCount;
        boundCount = (_e312 + 1i);
    }
    let _e314 = boundCount;
    return (_e314 >= 2i);
}

fn rot_u0028_f1_u003b(a_2: ptr<function, f32>) -> mat2x2<f32> {
    var s: f32;
    var c_1: f32;

    let _e264 = (*a_2);
    s = sin(_e264);
    let _e266 = (*a_2);
    c_1 = cos(_e266);
    let _e268 = c_1;
    let _e269 = s;
    let _e271 = s;
    let _e272 = c_1;
    return mat2x2<f32>(vec2<f32>(_e268, -(_e269)), vec2<f32>(_e271, _e272));
}

fn applyCameraRotation_u0028_vf3_u003b(v: ptr<function, vec3<f32>>) -> vec3<f32> {
    var param_46: f32;
    var param_47: f32;

    let _e265 = pc.pitch;
    param_46 = _e265;
    let _e266 = rot_u0028_f1_u003b((&param_46));
    let _e267 = (*v);
    let _e269 = (_e267.yz * _e266);
    (*v)[1u] = _e269.x;
    (*v)[2u] = _e269.y;
    let _e275 = pc.yaw;
    param_47 = _e275;
    let _e276 = rot_u0028_f1_u003b((&param_47));
    let _e277 = (*v);
    let _e279 = (_e277.xz * _e276);
    (*v)[0u] = _e279.x;
    (*v)[2u] = _e279.y;
    let _e284 = (*v);
    return _e284;
}

fn main_1() {
    var screenSpace: vec2<f32>;
    var baseOrigin: vec3<f32>;
    var forward: vec3<f32>;
    var param_48: vec3<f32>;
    var right: vec3<f32>;
    var param_49: vec3<f32>;
    var up: vec3<f32>;
    var param_50: vec3<f32>;
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
    var param_51: vec3<f32>;
    var param_52: vec3<f32>;
    var param_53: vec3<f32>;
    var param_54: vec3<f32>;
    var hitFrontBox: bool;
    var hitBackBox: bool;
    var param_55: vec3<f32>;
    var param_56: vec3<f32>;
    var ceilingY_1: i32;
    var marchHit: vec2<f32>;
    var param_57: vec3<f32>;
    var param_58: vec3<f32>;
    var param_59: vec3<f32>;
    var param_60: vec3<f32>;
    var currentPos: vec3<f32>;
    var voxelPos_16: vec3<i32>;
    var stepDir_3: vec3<i32>;
    var tDelta_3: vec3<f32>;
    var local_17: f32;
    var local_18: f32;
    var local_19: f32;
    var tMax_4: vec3<f32>;
    var local_20: f32;
    var local_21: f32;
    var local_22: f32;
    var normal_4: vec3<f32>;
    var hit: bool;
    var hitType: u32;
    var hitRawVoxel: u32;
    var subT: f32;
    var subNormal_1: vec3<f32>;
    var subCell_3: vec3<f32>;
    var MAX_VISIBILITY: f32;
    var i_6: i32;
    var rawVoxel_5: u32;
    var param_61: vec3<i32>;
    var c_2: u32;
    var age_1: u32;
    var targetAlpha: f32;
    var dither: f32;
    var param_62: u32;
    var kind_2: u32;
    var param_63: vec3<i32>;
    var param_64: vec3<f32>;
    var param_65: vec3<f32>;
    var param_66: u32;
    var param_67: u32;
    var param_68: vec3<f32>;
    var param_69: f32;
    var param_70: vec3<f32>;
    var param_71: vec3<f32>;
    var ddaNormal_1: vec3<f32>;
    var param_72: vec3<i32>;
    var param_73: vec3<f32>;
    var param_74: vec3<i32>;
    var param_75: u32;
    var param_76: vec3<i32>;
    var sunDir_2: vec3<f32>;
    var sunColor_1: vec3<f32>;
    var ambientColor: vec3<f32>;
    var diffuse_1: f32;
    var shadow_1: f32;
    var param_77: vec3<i32>;
    var param_78: vec3<f32>;
    var param_79: vec3<f32>;
    var param_80: i32;
    var baseLighting_9: vec3<f32>;
    var finalVoxelColor: vec3<f32>;
    var calm: vec3<f32>;
    var storm: vec3<f32>;
    var param_81: u32;
    var param_82: vec3<f32>;
    var param_83: vec3<i32>;
    var param_84: vec3<f32>;
    var param_85: vec3<f32>;
    var param_86: vec3<f32>;
    var param_87: vec3<f32>;
    var param_88: f32;
    var param_89: vec3<f32>;
    var param_90: vec3<i32>;
    var param_91: vec3<f32>;
    var param_92: u32;
    var param_93: vec3<i32>;
    var param_94: vec3<f32>;
    var param_95: vec3<f32>;
    var param_96: u32;
    var param_97: vec3<i32>;
    var param_98: vec3<i32>;
    var param_99: vec3<f32>;
    var param_100: u32;
    var param_101: vec3<i32>;
    var param_102: vec3<i32>;
    var param_103: vec3<f32>;
    var param_104: vec3<i32>;
    var param_105: vec3<f32>;
    var param_106: vec3<f32>;
    var param_107: vec3<i32>;
    var param_108: vec3<f32>;
    var param_109: vec3<f32>;
    var param_110: u32;
    var param_111: vec3<i32>;
    var param_112: vec3<f32>;
    var param_113: vec3<f32>;
    var param_114: vec3<i32>;
    var distanceTraveled: f32;
    var param_115: u32;
    var local_23: f32;
    var seenHoles: u32;
    var i_7: i32;
    var code_2: u32;
    var bodyLevel: u32;
    var local_24: u32;
    var param_116: u32;
    var bodyRadius: f32;
    var param_117: u32;
    var center: vec3<f32>;
    var param_118: u32;
    var oc: vec3<f32>;
    var b_2: f32;
    var c_3: f32;
    var disc: f32;
    var sq: f32;
    var tNear_1: f32;
    var tFar_1: f32;
    var bodyDist: f32;
    var surfaceNormal: vec3<f32>;
    var bodyColor: vec3<f32>;
    var param_119: vec3<f32>;
    var param_120: vec3<f32>;
    var charge: f32;
    var groupAlpha: f32;
    var cloudGreyness: f32;
    var crossedTime: f32;
    var cloudClip: vec2<f32>;
    var param_121: vec3<f32>;
    var param_122: vec3<f32>;
    var param_123: vec3<f32>;
    var param_124: vec3<f32>;
    var cloudSunDir: vec3<f32>;
    var bestT: f32;
    var bestColor: vec3<f32>;
    var bestAlpha: f32;
    var foundCloud: bool;
    var nearT: f32;
    var farT: f32;
    var cloudTHit: f32;
    var cloudColor: vec3<f32>;
    var cloudDensity: f32;
    var param_125: vec3<f32>;
    var param_126: vec3<f32>;
    var param_127: f32;
    var param_128: f32;
    var param_129: vec3<f32>;
    var param_130: f32;
    var param_131: f32;
    var param_132: vec3<f32>;
    var param_133: f32;
    var halfDistMin: i32;
    var halfDistMax: i32;
    var boxMin_2: vec3<f32>;
    var boxMax_1: vec3<f32>;
    var cursorColor: vec3<f32>;
    var indexable_6: array<vec3<f32>, 20>;
    var sphereCenter: vec3<f32>;
    var sphereRadius: f32;
    var oc_1: vec3<f32>;
    var b_3: f32;
    var c_4: f32;
    var disc_1: f32;
    var sq_1: f32;
    var tNear_2: f32;
    var tFar_2: f32;
    var inside: bool;
    var cursorDist: f32;
    var shellNormal: vec3<f32>;
    var rim_1: f32;
    var alpha: f32;
    var cursorHit: vec2<f32>;
    var param_134: vec3<f32>;
    var param_135: vec3<f32>;
    var param_136: vec3<f32>;
    var param_137: vec3<f32>;
    var distFront: f32;
    var distBack: f32;
    var hitPosFront: vec3<f32>;
    var hitPosBack: vec3<f32>;
    var e: f32;
    var onFrontEdge: bool;
    var edgesFront: i32;
    var onBackEdge: bool;
    var edgesBack: i32;
    var phi_2937_: bool;
    var phi_2953_: bool;
    var phi_3169_: bool;
    var phi_3176_: bool;
    var phi_3184_: bool;
    var phi_3191_: bool;
    var phi_3201_: bool;
    var phi_3690_: bool;
    var phi_3970_: bool;
    var phi_3977_: bool;
    var phi_3986_: bool;
    var phi_3992_: bool;
    var phi_4001_: bool;
    var phi_4212_: bool;
    var phi_4254_: bool;
    var phi_4276_: bool;
    var phi_4298_: bool;
    var phi_4326_: bool;
    var phi_4348_: bool;
    var phi_4370_: bool;

    let _e471 = inUV_1;
    screenSpace = ((_e471 * 2f) - vec2(1f));
    let _e476 = screenSpace[1u];
    screenSpace[1u] = -(_e476);
    let _e480 = pc.aspectScaleX;
    let _e482 = screenSpace[0u];
    screenSpace[0u] = (_e482 * _e480);
    let _e486 = pc.aspectScaleY;
    let _e488 = screenSpace[1u];
    screenSpace[1u] = (_e488 * _e486);
    let _e492 = pc.camX;
    let _e494 = pc.camY;
    let _e496 = pc.camZ;
    baseOrigin = vec3<f32>(_e492, _e494, _e496);
    param_48 = vec3<f32>(0f, 0f, 1f);
    let _e498 = applyCameraRotation_u0028_vf3_u003b((&param_48));
    forward = _e498;
    param_49 = vec3<f32>(1f, 0f, 0f);
    let _e499 = applyCameraRotation_u0028_vf3_u003b((&param_49));
    right = _e499;
    param_50 = vec3<f32>(0f, 1f, 0f);
    let _e500 = applyCameraRotation_u0028_vf3_u003b((&param_50));
    up = _e500;
    let _e502 = pc.perspectiveBlend;
    t_3 = clamp(_e502, 0f, 1f);
    let _e504 = worldExtent_u0028_();
    cubeCenter = (_e504 * 0.5f);
    let _e506 = cubeCenter;
    let _e507 = baseOrigin;
    let _e509 = forward;
    viewDistance = max(1f, dot((_e506 - _e507), _e509));
    let _e512 = viewDistance;
    let _e514 = pc.fovDistance;
    orthoHalfSize = (_e512 / _e514);
    let _e517 = screenSpace[0u];
    let _e519 = screenSpace[1u];
    let _e521 = pc.fovDistance;
    let _e523 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e517, _e519, _e521), vec3(_e523));
    let _e526 = right;
    let _e528 = localDir[0u];
    let _e530 = up;
    let _e532 = localDir[1u];
    let _e535 = forward;
    let _e537 = localDir[2u];
    rayDir_3 = normalize((((_e526 * _e528) + (_e530 * _e532)) + (_e535 * _e537)));
    let _e541 = right;
    let _e543 = screenSpace[0u];
    let _e545 = up;
    let _e547 = screenSpace[1u];
    let _e550 = orthoHalfSize;
    let _e552 = t_3;
    originOffset = ((((_e541 * _e543) + (_e545 * _e547)) * _e550) * (1f - _e552));
    let _e555 = baseOrigin;
    let _e556 = originOffset;
    rayOrigin_3 = (_e555 + _e556);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e558 = worldExtent_u0028_();
    let _e559 = rayOrigin_3;
    param_51 = _e559;
    let _e560 = rayDir_3;
    param_52 = _e560;
    param_53 = vec3<f32>(0f, 0f, 0f);
    param_54 = _e558;
    let _e561 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_51), (&param_52), (&param_53), (&param_54));
    aabbHit = _e561;
    hitFrontBox = false;
    hitBackBox = false;
    let _e563 = aabbHit[0u];
    let _e565 = aabbHit[1u];
    let _e566 = (_e563 < _e565);
    phi_2937_ = _e566;
    if _e566 {
        let _e568 = aabbHit[1u];
        phi_2937_ = (_e568 > 0f);
    }
    let _e571 = phi_2937_;
    if _e571 {
        let _e573 = aabbHit[0u];
        let _e574 = (_e573 > 0f);
        phi_2953_ = _e574;
        if _e574 {
            let _e575 = rayOrigin_3;
            let _e576 = rayDir_3;
            let _e578 = aabbHit[0u];
            param_55 = (_e575 + (_e576 * _e578));
            let _e581 = isEdge_u0028_vf3_u003b((&param_55));
            phi_2953_ = _e581;
        }
        let _e583 = phi_2953_;
        if _e583 {
            hitFrontBox = true;
        }
        let _e584 = rayOrigin_3;
        let _e585 = rayDir_3;
        let _e587 = aabbHit[1u];
        param_56 = (_e584 + (_e585 * _e587));
        let _e590 = isEdge_u0028_vf3_u003b((&param_56));
        if _e590 {
            hitBackBox = true;
        }
    }
    let _e591 = marchCeiling_u0028_();
    ceilingY_1 = _e591;
    let _e593 = tuning.gridWidth;
    let _e596 = ceilingY_1;
    let _e599 = tuning.gridDepth;
    let _e603 = rayOrigin_3;
    param_57 = _e603;
    let _e604 = rayDir_3;
    param_58 = _e604;
    param_59 = vec3<f32>(0f, 0f, 0f);
    param_60 = vec3<f32>(f32(bitcast<i32>(_e593)), f32(_e596), f32(bitcast<i32>(_e599)));
    let _e605 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_57), (&param_58), (&param_59), (&param_60));
    marchHit = _e605;
    let _e606 = rayOrigin_3;
    let _e607 = rayDir_3;
    let _e609 = marchHit[0u];
    currentPos = (_e606 + (_e607 * max(0f, _e609)));
    let _e614 = marchHit[0u];
    if (_e614 > 0f) {
        let _e616 = rayDir_3;
        let _e618 = currentPos;
        currentPos = (_e618 + (_e616 * 0.001f));
    }
    let _e620 = currentPos;
    voxelPos_16 = vec3<i32>(floor(_e620));
    let _e623 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e623));
    let _e627 = rayDir_3[0u];
    if (_e627 == 0f) {
        local_17 = 100000000f;
    } else {
        let _e630 = rayDir_3[0u];
        local_17 = abs((1f / _e630));
    }
    let _e633 = local_17;
    let _e635 = rayDir_3[1u];
    if (_e635 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e638 = rayDir_3[1u];
        local_18 = abs((1f / _e638));
    }
    let _e641 = local_18;
    let _e643 = rayDir_3[2u];
    if (_e643 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e646 = rayDir_3[2u];
        local_19 = abs((1f / _e646));
    }
    let _e649 = local_19;
    tDelta_3 = vec3<f32>(_e633, _e641, _e649);
    let _e652 = stepDir_3[0u];
    if (_e652 > 0i) {
        let _e655 = currentPos[0u];
        let _e659 = currentPos[0u];
        let _e662 = tDelta_3[0u];
        local_20 = (((floor(_e655) + 1f) - _e659) * _e662);
    } else {
        let _e665 = currentPos[0u];
        let _e667 = currentPos[0u];
        let _e671 = tDelta_3[0u];
        local_20 = ((_e665 - floor(_e667)) * _e671);
    }
    let _e673 = local_20;
    let _e675 = stepDir_3[1u];
    if (_e675 > 0i) {
        let _e678 = currentPos[1u];
        let _e682 = currentPos[1u];
        let _e685 = tDelta_3[1u];
        local_21 = (((floor(_e678) + 1f) - _e682) * _e685);
    } else {
        let _e688 = currentPos[1u];
        let _e690 = currentPos[1u];
        let _e694 = tDelta_3[1u];
        local_21 = ((_e688 - floor(_e690)) * _e694);
    }
    let _e696 = local_21;
    let _e698 = stepDir_3[2u];
    if (_e698 > 0i) {
        let _e701 = currentPos[2u];
        let _e705 = currentPos[2u];
        let _e708 = tDelta_3[2u];
        local_22 = (((floor(_e701) + 1f) - _e705) * _e708);
    } else {
        let _e711 = currentPos[2u];
        let _e713 = currentPos[2u];
        let _e717 = tDelta_3[2u];
        local_22 = ((_e711 - floor(_e713)) * _e717);
    }
    let _e719 = local_22;
    tMax_4 = vec3<f32>(_e673, _e696, _e719);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e722 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e722 * 1.5f));
    i_6 = 0i;
    loop {
        let _e725 = i_6;
        let _e727 = tuning.marchMaxSteps;
        if (_e725 < bitcast<i32>(_e727)) {
            let _e731 = voxelPos_16[0u];
            let _e732 = (_e731 < 0i);
            phi_3169_ = _e732;
            if !(_e732) {
                let _e735 = voxelPos_16[0u];
                let _e737 = tuning.gridWidth;
                phi_3169_ = (_e735 >= bitcast<i32>(_e737));
            }
            let _e741 = phi_3169_;
            phi_3176_ = _e741;
            if !(_e741) {
                let _e744 = voxelPos_16[1u];
                phi_3176_ = (_e744 < 0i);
            }
            let _e747 = phi_3176_;
            phi_3184_ = _e747;
            if !(_e747) {
                let _e750 = voxelPos_16[1u];
                let _e751 = ceilingY_1;
                phi_3184_ = (_e750 >= _e751);
            }
            let _e754 = phi_3184_;
            phi_3191_ = _e754;
            if !(_e754) {
                let _e757 = voxelPos_16[2u];
                phi_3191_ = (_e757 < 0i);
            }
            let _e760 = phi_3191_;
            phi_3201_ = _e760;
            if !(_e760) {
                let _e763 = voxelPos_16[2u];
                let _e765 = tuning.gridDepth;
                phi_3201_ = (_e763 >= bitcast<i32>(_e765));
            }
            let _e769 = phi_3201_;
            if _e769 {
                break;
            }
            let _e770 = voxelPos_16;
            param_61 = _e770;
            let _e771 = getVoxel_u0028_vi3_u003b((&param_61));
            rawVoxel_5 = _e771;
            let _e772 = rawVoxel_5;
            hitType = (_e772 & 255u);
            let _e775 = pc.showCloudBlocks;
            let _e777 = hitType;
            if ((_e775 != 0i) && (_e777 == 0u)) {
                let _e781 = voxelPos_16[0u];
                let _e783 = voxelPos_16[1u];
                let _e785 = tuning.gridWidth;
                let _e790 = voxelPos_16[2u];
                let _e792 = tuning.gridWidth;
                let _e796 = tuning.gridHeight;
                let _e803 = unnamed_2.cloudCells[bitcast<u32>(((_e781 + (_e783 * bitcast<i32>(_e785))) + ((_e790 * bitcast<i32>(_e792)) * bitcast<i32>(_e796))))];
                c_2 = _e803;
                let _e804 = c_2;
                if ((_e804 & 3u) != 0u) {
                    hitType = 200u;
                    let _e807 = c_2;
                    hitRawVoxel = _e807;
                    hit = true;
                    break;
                }
            }
            let _e808 = hitType;
            if (_e808 == 7u) {
                hitType = 0u;
            }
            let _e810 = hitType;
            if (_e810 != 0u) {
                let _e812 = hitType;
                if (_e812 == 6u) {
                    let _e814 = rawVoxel_5;
                    age_1 = ((_e814 >> bitcast<u32>(24i)) & 255u);
                    let _e818 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e818) / 100f), 0f, 1f));
                    let _e823 = inUV_1;
                    let _e825 = pc.time;
                    dither = fract((sin(dot((_e823 + vec2((_e825 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e833 = dither;
                    let _e834 = targetAlpha;
                    if (_e833 > _e834) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e836 = rawVoxel_5;
                        hitRawVoxel = _e836;
                        break;
                    }
                } else {
                    let _e837 = hitType;
                    param_62 = _e837;
                    let _e838 = isLocustType_u0028_u1_u003b((&param_62));
                    let _e839 = hitType;
                    if (_e838 || (_e839 == 18u)) {
                        let _e842 = hitType;
                        kind_2 = select(0u, 1u, (_e842 == 18u));
                        let _e845 = voxelPos_16;
                        param_63 = _e845;
                        let _e846 = rayOrigin_3;
                        param_64 = _e846;
                        let _e847 = rayDir_3;
                        param_65 = _e847;
                        let _e848 = kind_2;
                        param_66 = _e848;
                        let _e849 = hitType;
                        param_67 = _e849;
                        let _e850 = normal_4;
                        param_68 = _e850;
                        let _e851 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_63), (&param_64), (&param_65), (&param_66), (&param_67), (&param_68), (&param_69), (&param_70), (&param_71));
                        let _e852 = param_69;
                        subT = _e852;
                        let _e853 = param_70;
                        subNormal_1 = _e853;
                        let _e854 = param_71;
                        subCell_3 = _e854;
                        if _e851 {
                            hit = true;
                            let _e855 = rawVoxel_5;
                            hitRawVoxel = _e855;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e856 = rawVoxel_5;
                        hitRawVoxel = _e856;
                        break;
                    }
                }
            }
            let _e858 = tMax_4[0u];
            let _e860 = tMax_4[1u];
            if (_e858 < _e860) {
                let _e863 = tMax_4[0u];
                let _e865 = tMax_4[2u];
                if (_e863 < _e865) {
                    let _e868 = stepDir_3[0u];
                    let _e870 = voxelPos_16[0u];
                    voxelPos_16[0u] = (_e870 + _e868);
                    let _e874 = tDelta_3[0u];
                    let _e876 = tMax_4[0u];
                    tMax_4[0u] = (_e876 + _e874);
                    let _e880 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e880)), 0f, 0f);
                } else {
                    let _e885 = stepDir_3[2u];
                    let _e887 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e887 + _e885);
                    let _e891 = tDelta_3[2u];
                    let _e893 = tMax_4[2u];
                    tMax_4[2u] = (_e893 + _e891);
                    let _e897 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e897)));
                }
            } else {
                let _e902 = tMax_4[1u];
                let _e904 = tMax_4[2u];
                if (_e902 < _e904) {
                    let _e907 = stepDir_3[1u];
                    let _e909 = voxelPos_16[1u];
                    voxelPos_16[1u] = (_e909 + _e907);
                    let _e913 = tDelta_3[1u];
                    let _e915 = tMax_4[1u];
                    tMax_4[1u] = (_e915 + _e913);
                    let _e919 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e919)), 0f);
                } else {
                    let _e924 = stepDir_3[2u];
                    let _e926 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e926 + _e924);
                    let _e930 = tDelta_3[2u];
                    let _e932 = tMax_4[2u];
                    tMax_4[2u] = (_e932 + _e930);
                    let _e936 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e936)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e940 = i_6;
            i_6 = (_e940 + 1i);
        }
    }
    let _e942 = hit;
    if _e942 {
        let _e943 = normal_4;
        if (length(_e943) < 0.1f) {
            let _e946 = rayDir_3;
            normal_4 = -(_e946);
        }
        let _e948 = normal_4;
        ddaNormal_1 = _e948;
        let _e949 = hitType;
        if (_e949 == 2u) {
            let _e951 = voxelPos_16;
            param_72 = _e951;
            let _e952 = getWaterNormal_u0028_vi3_u003b((&param_72));
            param_73 = _e952;
            let _e953 = voxelPos_16;
            param_74 = _e953;
            let _e954 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_73), (&param_74));
            normal_4 = _e954;
        } else {
            let _e955 = hitType;
            param_75 = _e955;
            let _e956 = isLocustType_u0028_u1_u003b((&param_75));
            let _e957 = hitType;
            if (_e956 || (_e957 == 18u)) {
                let _e960 = subNormal_1;
                normal_4 = _e960;
            } else {
                let _e961 = voxelPos_16;
                param_76 = _e961;
                let _e962 = getSmoothNormal_u0028_vi3_u003b((&param_76));
                normal_4 = _e962;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e963 = normal_4;
        let _e964 = sunDir_2;
        diffuse_1 = max(dot(_e963, _e964), 0f);
        let _e967 = voxelPos_16;
        param_77 = _e967;
        let _e968 = ddaNormal_1;
        param_78 = _e968;
        let _e969 = sunDir_2;
        param_79 = _e969;
        let _e970 = ceilingY_1;
        param_80 = _e970;
        let _e971 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_77), (&param_78), (&param_79), (&param_80));
        shadow_1 = _e971;
        let _e972 = ambientColor;
        let _e973 = sunColor_1;
        let _e974 = diffuse_1;
        let _e976 = shadow_1;
        baseLighting_9 = (_e972 + ((_e973 * _e974) * _e976));
        let _e979 = baseLighting_9;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e979);
        let _e981 = hitType;
        if (_e981 == 200u) {
            calm = vec3<f32>(0.35f, 0.65f, 1f);
            storm = vec3<f32>(1f, 0.55f, 0.25f);
            let _e983 = calm;
            let _e984 = storm;
            let _e985 = hitRawVoxel;
            let _e991 = baseLighting_9;
            finalVoxelColor = (mix(_e983, _e984, vec3(select(0f, 1f, ((_e985 & 3u) == 2u)))) * _e991);
        }
        let _e993 = hitType;
        switch bitcast<i32>(_e993) {
            case 1: {
                let _e995 = hitRawVoxel;
                param_81 = _e995;
                let _e996 = baseLighting_9;
                param_82 = _e996;
                let _e997 = renderSand_u0028_u1_u003b_vf3_u003b((&param_81), (&param_82));
                finalVoxelColor = _e997;
                break;
            }
            case 2: {
                let _e998 = voxelPos_16;
                param_83 = _e998;
                let _e999 = normal_4;
                param_84 = _e999;
                let _e1000 = rayOrigin_3;
                param_85 = _e1000;
                let _e1001 = sunDir_2;
                param_86 = _e1001;
                let _e1002 = sunColor_1;
                param_87 = _e1002;
                let _e1003 = shadow_1;
                param_88 = _e1003;
                let _e1004 = baseLighting_9;
                param_89 = _e1004;
                let _e1005 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_83), (&param_84), (&param_85), (&param_86), (&param_87), (&param_88), (&param_89));
                finalVoxelColor = _e1005;
                break;
            }
            case 3: {
                let _e1006 = voxelPos_16;
                param_90 = _e1006;
                let _e1007 = baseLighting_9;
                param_91 = _e1007;
                let _e1008 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_90), (&param_91));
                finalVoxelColor = _e1008;
                break;
            }
            case 4: {
                let _e1009 = hitRawVoxel;
                param_92 = _e1009;
                let _e1010 = voxelPos_16;
                param_93 = _e1010;
                let _e1011 = ddaNormal_1;
                param_94 = _e1011;
                let _e1012 = baseLighting_9;
                param_95 = _e1012;
                let _e1013 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_92), (&param_93), (&param_94), (&param_95));
                finalVoxelColor = _e1013;
                break;
            }
            case 5: {
                let _e1014 = hitRawVoxel;
                param_96 = _e1014;
                let _e1015 = voxelPos_16;
                param_97 = _e1015;
                let _e1016 = renderFire_u0028_u1_u003b_vi3_u003b((&param_96), (&param_97));
                finalVoxelColor = _e1016;
                break;
            }
            case 6: {
                let _e1017 = voxelPos_16;
                param_98 = _e1017;
                let _e1018 = baseLighting_9;
                param_99 = _e1018;
                let _e1019 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_98), (&param_99));
                finalVoxelColor = _e1019;
                break;
            }
            case 9, 10, 11, 8: {
                let _e1020 = hitRawVoxel;
                param_100 = _e1020;
                let _e1021 = voxelPos_16;
                param_101 = _e1021;
                let _e1022 = renderLava_u0028_u1_u003b_vi3_u003b((&param_100), (&param_101));
                finalVoxelColor = _e1022;
                break;
            }
            case 12: {
                let _e1023 = voxelPos_16;
                param_102 = _e1023;
                let _e1024 = baseLighting_9;
                param_103 = _e1024;
                let _e1025 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_102), (&param_103));
                finalVoxelColor = _e1025;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e1026 = voxelPos_16;
                param_104 = _e1026;
                let _e1027 = subCell_3;
                param_105 = _e1027;
                let _e1028 = baseLighting_9;
                param_106 = _e1028;
                let _e1029 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_104), (&param_105), (&param_106));
                finalVoxelColor = _e1029;
                break;
            }
            case 18: {
                let _e1030 = voxelPos_16;
                param_107 = _e1030;
                let _e1031 = subCell_3;
                param_108 = _e1031;
                let _e1032 = baseLighting_9;
                param_109 = _e1032;
                let _e1033 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_107), (&param_108), (&param_109));
                finalVoxelColor = _e1033;
                break;
            }
            case 19: {
                let _e1034 = hitRawVoxel;
                param_110 = _e1034;
                let _e1035 = voxelPos_16;
                param_111 = _e1035;
                let _e1036 = baseLighting_9;
                param_112 = _e1036;
                let _e1037 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_110), (&param_111), (&param_112));
                finalVoxelColor = _e1037;
                break;
            }
            default: {
                break;
            }
        }
        let _e1038 = finalVoxelColor;
        param_113 = _e1038;
        let _e1039 = voxelPos_16;
        param_114 = _e1039;
        let _e1040 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_113), (&param_114));
        finalVoxelColor = _e1040;
        let _e1041 = hitType;
        param_115 = _e1041;
        let _e1042 = isLocustType_u0028_u1_u003b((&param_115));
        let _e1043 = hitType;
        if (_e1042 || (_e1043 == 18u)) {
            let _e1046 = subT;
            local_23 = _e1046;
        } else {
            let _e1047 = voxelPos_16;
            let _e1050 = rayOrigin_3;
            local_23 = length(((vec3<f32>(_e1047) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e1050));
        }
        let _e1053 = local_23;
        distanceTraveled = _e1053;
        let _e1054 = distanceTraveled;
        let _e1055 = MAX_VISIBILITY;
        let _e1059 = finalVoxelColor;
        finalVoxelColor = (_e1059 * mix(1f, 0f, clamp((_e1054 / _e1055), 0f, 1f)));
        let _e1061 = distanceTraveled;
        finalDist = _e1061;
        let _e1062 = finalVoxelColor;
        finalColor = vec4<f32>(_e1062.x, _e1062.y, _e1062.z, 1f);
    } else {
        let _e1067 = hitBackBox;
        if _e1067 {
            let _e1069 = aabbHit[1u];
            finalDist = _e1069;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1071 = unnamed.blackHoleCount;
    if (_e1071 > 0u) {
        seenHoles = 0u;
        i_7 = 0i;
        loop {
            let _e1073 = i_7;
            let _e1074 = (_e1073 < 8i);
            phi_3690_ = _e1074;
            if _e1074 {
                let _e1075 = seenHoles;
                let _e1077 = unnamed.blackHoleCount;
                phi_3690_ = (_e1075 < _e1077);
            }
            let _e1080 = phi_3690_;
            if _e1080 {
                let _e1081 = i_7;
                let _e1084 = unnamed.blackHoles[_e1081];
                code_2 = _e1084;
                let _e1085 = code_2;
                if (_e1085 == 0u) {
                    continue;
                }
                let _e1087 = seenHoles;
                seenHoles = (_e1087 + bitcast<u32>(1i));
                let _e1090 = code_2;
                if ((_e1090 & 1073741824u) != 0u) {
                    let _e1094 = tuning.purgeLevel;
                    let _e1096 = i_7;
                    let _e1099 = unnamed.blackHoleMass[_e1096];
                    let _e1102 = tuning.purgeMass;
                    local_24 = u32((f32(_e1094) * clamp((f32(_e1099) / f32(max(_e1102, 1u))), 0f, 1f)));
                } else {
                    let _e1109 = i_7;
                    let _e1112 = unnamed.blackHoleMass[_e1109];
                    param_116 = _e1112;
                    let _e1113 = bhLevel_u0028_u1_u003b((&param_116));
                    local_24 = _e1113;
                }
                let _e1114 = local_24;
                bodyLevel = _e1114;
                let _e1115 = bodyLevel;
                param_117 = _e1115;
                let _e1116 = bhBodyRadius_u0028_u1_u003b((&param_117));
                bodyRadius = _e1116;
                let _e1117 = code_2;
                param_118 = _e1117;
                let _e1118 = bhDecode_u0028_u1_u003b((&param_118));
                center = (vec3<f32>(_e1118) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1121 = rayOrigin_3;
                let _e1122 = center;
                oc = (_e1121 - _e1122);
                let _e1124 = oc;
                let _e1125 = rayDir_3;
                b_2 = dot(_e1124, _e1125);
                let _e1127 = oc;
                let _e1128 = oc;
                let _e1130 = bodyRadius;
                let _e1131 = bodyRadius;
                c_3 = (dot(_e1127, _e1128) - (_e1130 * _e1131));
                let _e1134 = b_2;
                let _e1135 = b_2;
                let _e1137 = c_3;
                disc = ((_e1134 * _e1135) - _e1137);
                let _e1139 = disc;
                if (_e1139 <= 0f) {
                    continue;
                }
                let _e1141 = disc;
                sq = sqrt(_e1141);
                let _e1143 = b_2;
                let _e1145 = sq;
                tNear_1 = (-(_e1143) - _e1145);
                let _e1147 = b_2;
                let _e1149 = sq;
                tFar_1 = (-(_e1147) + _e1149);
                let _e1151 = tFar_1;
                if (_e1151 <= 0f) {
                    continue;
                }
                let _e1153 = tNear_1;
                bodyDist = max(0f, _e1153);
                let _e1155 = bodyDist;
                let _e1156 = finalDist;
                if (_e1155 < _e1156) {
                    let _e1158 = rayOrigin_3;
                    let _e1159 = rayDir_3;
                    let _e1160 = bodyDist;
                    let _e1163 = center;
                    surfaceNormal = normalize(((_e1158 + (_e1159 * _e1160)) - _e1163));
                    let _e1166 = surfaceNormal;
                    param_119 = _e1166;
                    let _e1167 = rayDir_3;
                    param_120 = _e1167;
                    let _e1168 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_119), (&param_120));
                    bodyColor = _e1168;
                    let _e1169 = bodyDist;
                    let _e1170 = MAX_VISIBILITY;
                    let _e1174 = bodyColor;
                    bodyColor = (_e1174 * mix(1f, 0f, clamp((_e1169 / _e1170), 0f, 1f)));
                    let _e1176 = bodyColor;
                    finalColor = vec4<f32>(_e1176.x, _e1176.y, _e1176.z, 1f);
                    let _e1181 = bodyDist;
                    finalDist = _e1181;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1182 = i_7;
                i_7 = (_e1182 + 1i);
            }
        }
    }
    let _e1185 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1185), 0f, 1f);
    let _e1189 = tuning.cloudMinAlpha;
    let _e1191 = tuning.cloudMaxAlpha;
    let _e1192 = charge;
    groupAlpha = mix(_e1189, _e1191, _e1192);
    let _e1194 = charge;
    cloudGreyness = _e1194;
    let _e1196 = unnamed.rainPhase;
    if (_e1196 == 1u) {
        let _e1199 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1199);
        let _e1201 = charge;
        let _e1203 = pc.time;
        let _e1204 = crossedTime;
        let _e1207 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1201, clamp(((_e1203 - _e1204) / _e1207), 0f, 1f));
    } else {
        let _e1212 = unnamed.rainPhase;
        if (_e1212 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1214 = groupAlpha;
    if (_e1214 > 0.002f) {
        let _e1216 = worldExtent_u0028_();
        let _e1218 = worldExtent_u0028_();
        let _e1221 = rayOrigin_3;
        param_121 = _e1221;
        let _e1222 = rayDir_3;
        param_122 = _e1222;
        param_123 = vec3<f32>(0f, -1000000f, 0f);
        param_124 = vec3<f32>(_e1216.x, 1000000f, _e1218.z);
        let _e1223 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_121), (&param_122), (&param_123), (&param_124));
        cloudClip = _e1223;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1225 = cloudClip[0u];
        nearT = max(_e1225, 0f);
        let _e1228 = cloudClip[1u];
        let _e1229 = finalDist;
        farT = min(_e1228, _e1229);
        let _e1231 = nearT;
        let _e1232 = farT;
        if (_e1231 < _e1232) {
            let _e1234 = rayOrigin_3;
            param_125 = _e1234;
            let _e1235 = rayDir_3;
            param_126 = _e1235;
            let _e1236 = nearT;
            param_127 = _e1236;
            let _e1237 = farT;
            param_128 = _e1237;
            let _e1238 = cloudSunDir;
            param_129 = _e1238;
            let _e1239 = cloudGreyness;
            param_130 = _e1239;
            let _e1240 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b((&param_125), (&param_126), (&param_127), (&param_128), (&param_129), (&param_130), (&param_131), (&param_132), (&param_133));
            let _e1241 = param_131;
            cloudTHit = _e1241;
            let _e1242 = param_132;
            cloudColor = _e1242;
            let _e1243 = param_133;
            cloudDensity = _e1243;
            if _e1240 {
                let _e1244 = cloudTHit;
                if (_e1244 > 0f) {
                    let _e1246 = cloudTHit;
                    bestT = _e1246;
                    let _e1247 = cloudColor;
                    bestColor = _e1247;
                    let _e1248 = groupAlpha;
                    let _e1249 = cloudDensity;
                    bestAlpha = clamp((_e1248 * mix(0.35f, 1f, _e1249)), 0f, 0.95f);
                    foundCloud = true;
                }
            }
        }
        let _e1253 = foundCloud;
        let _e1254 = bestT;
        let _e1255 = finalDist;
        if (_e1253 && (_e1254 < _e1255)) {
            let _e1258 = finalColor;
            let _e1260 = bestColor;
            let _e1261 = bestAlpha;
            let _e1263 = mix(_e1258.xyz, _e1260, vec3(_e1261));
            finalColor[0u] = _e1263.x;
            finalColor[1u] = _e1263.y;
            finalColor[2u] = _e1263.z;
        }
    }
    let _e1271 = pc.spawnX;
    let _e1272 = (_e1271 >= 0i);
    phi_3970_ = _e1272;
    if _e1272 {
        let _e1274 = pc.spawnX;
        let _e1276 = tuning.gridWidth;
        phi_3970_ = (_e1274 < bitcast<i32>(_e1276));
    }
    let _e1280 = phi_3970_;
    phi_3977_ = _e1280;
    if _e1280 {
        let _e1282 = pc.spawnY;
        phi_3977_ = (_e1282 >= 0i);
    }
    let _e1285 = phi_3977_;
    phi_3986_ = _e1285;
    if _e1285 {
        let _e1287 = pc.spawnY;
        let _e1289 = tuning.gridHeight;
        phi_3986_ = (_e1287 < bitcast<i32>(_e1289));
    }
    let _e1293 = phi_3986_;
    phi_3992_ = _e1293;
    if _e1293 {
        let _e1295 = pc.spawnZ;
        phi_3992_ = (_e1295 >= 0i);
    }
    let _e1298 = phi_3992_;
    phi_4001_ = _e1298;
    if _e1298 {
        let _e1300 = pc.spawnZ;
        let _e1302 = tuning.gridDepth;
        phi_4001_ = (_e1300 < bitcast<i32>(_e1302));
    }
    let _e1306 = phi_4001_;
    if _e1306 {
        let _e1308 = pc.spawnSize;
        halfDistMin = (_e1308 / 2i);
        let _e1311 = pc.spawnSize;
        halfDistMax = ((_e1311 - 1i) / 2i);
        let _e1315 = pc.spawnX;
        let _e1316 = halfDistMin;
        let _e1320 = pc.spawnY;
        let _e1321 = halfDistMin;
        let _e1325 = pc.spawnZ;
        let _e1326 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1315 - _e1316)), f32((_e1320 - _e1321)), f32((_e1325 - _e1326)));
        let _e1331 = pc.spawnX;
        let _e1332 = halfDistMax;
        let _e1337 = pc.spawnY;
        let _e1338 = halfDistMax;
        let _e1343 = pc.spawnZ;
        let _e1344 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1331 + _e1332) + 1i)), f32(((_e1337 + _e1338) + 1i)), f32(((_e1343 + _e1344) + 1i)));
        let _e1350 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1353 = indexable_6[clamp(_e1350, 0i, 19i)];
        cursorColor = _e1353;
        let _e1355 = pc.spawnShape;
        if (_e1355 == 1i) {
            let _e1357 = boxMin_2;
            let _e1358 = boxMax_1;
            sphereCenter = ((_e1357 + _e1358) * 0.5f);
            let _e1362 = pc.spawnSize;
            sphereRadius = (f32(_e1362) * 0.5f);
            let _e1365 = rayOrigin_3;
            let _e1366 = sphereCenter;
            oc_1 = (_e1365 - _e1366);
            let _e1368 = oc_1;
            let _e1369 = rayDir_3;
            b_3 = dot(_e1368, _e1369);
            let _e1371 = oc_1;
            let _e1372 = oc_1;
            let _e1374 = sphereRadius;
            let _e1375 = sphereRadius;
            c_4 = (dot(_e1371, _e1372) - (_e1374 * _e1375));
            let _e1378 = b_3;
            let _e1379 = b_3;
            let _e1381 = c_4;
            disc_1 = ((_e1378 * _e1379) - _e1381);
            let _e1383 = disc_1;
            if (_e1383 > 0f) {
                let _e1385 = disc_1;
                sq_1 = sqrt(_e1385);
                let _e1387 = b_3;
                let _e1389 = sq_1;
                tNear_2 = (-(_e1387) - _e1389);
                let _e1391 = b_3;
                let _e1393 = sq_1;
                tFar_2 = (-(_e1391) + _e1393);
                let _e1395 = tFar_2;
                if (_e1395 > 0f) {
                    let _e1397 = tNear_2;
                    inside = (_e1397 <= 0f);
                    let _e1399 = inside;
                    let _e1400 = tFar_2;
                    let _e1401 = tNear_2;
                    cursorDist = select(_e1401, _e1400, _e1399);
                    let _e1403 = rayOrigin_3;
                    let _e1404 = rayDir_3;
                    let _e1405 = cursorDist;
                    let _e1408 = sphereCenter;
                    shellNormal = normalize(((_e1403 + (_e1404 * _e1405)) - _e1408));
                    let _e1411 = shellNormal;
                    let _e1412 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1411, _e1412)));
                    let _e1416 = rim_1;
                    let _e1419 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1416)) * select(1f, 0.35f, _e1419));
                    let _e1422 = cursorDist;
                    let _e1423 = finalDist;
                    if (_e1422 < _e1423) {
                        let _e1425 = finalColor;
                        let _e1427 = cursorColor;
                        let _e1428 = alpha;
                        let _e1430 = mix(_e1425.xyz, _e1427, vec3(_e1428));
                        finalColor[0u] = _e1430.x;
                        finalColor[1u] = _e1430.y;
                        finalColor[2u] = _e1430.z;
                    }
                }
            }
        } else {
            let _e1437 = rayOrigin_3;
            param_134 = _e1437;
            let _e1438 = rayDir_3;
            param_135 = _e1438;
            let _e1439 = boxMin_2;
            param_136 = _e1439;
            let _e1440 = boxMax_1;
            param_137 = _e1440;
            let _e1441 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_134), (&param_135), (&param_136), (&param_137));
            cursorHit = _e1441;
            let _e1443 = cursorHit[0u];
            let _e1445 = cursorHit[1u];
            let _e1446 = (_e1443 < _e1445);
            phi_4212_ = _e1446;
            if _e1446 {
                let _e1448 = cursorHit[1u];
                phi_4212_ = (_e1448 > 0f);
            }
            let _e1451 = phi_4212_;
            if _e1451 {
                let _e1453 = cursorHit[0u];
                distFront = max(0f, _e1453);
                let _e1456 = cursorHit[1u];
                distBack = _e1456;
                let _e1457 = rayOrigin_3;
                let _e1458 = rayDir_3;
                let _e1459 = distFront;
                hitPosFront = (_e1457 + (_e1458 * _e1459));
                let _e1462 = rayOrigin_3;
                let _e1463 = rayDir_3;
                let _e1464 = distBack;
                hitPosBack = (_e1462 + (_e1463 * _e1464));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1468 = hitPosFront[0u];
                let _e1470 = boxMin_2[0u];
                let _e1471 = e;
                let _e1473 = (_e1468 < (_e1470 + _e1471));
                phi_4254_ = _e1473;
                if !(_e1473) {
                    let _e1476 = hitPosFront[0u];
                    let _e1478 = boxMax_1[0u];
                    let _e1479 = e;
                    phi_4254_ = (_e1476 > (_e1478 - _e1479));
                }
                let _e1483 = phi_4254_;
                if _e1483 {
                    let _e1484 = edgesFront;
                    edgesFront = (_e1484 + 1i);
                }
                let _e1487 = hitPosFront[1u];
                let _e1489 = boxMin_2[1u];
                let _e1490 = e;
                let _e1492 = (_e1487 < (_e1489 + _e1490));
                phi_4276_ = _e1492;
                if !(_e1492) {
                    let _e1495 = hitPosFront[1u];
                    let _e1497 = boxMax_1[1u];
                    let _e1498 = e;
                    phi_4276_ = (_e1495 > (_e1497 - _e1498));
                }
                let _e1502 = phi_4276_;
                if _e1502 {
                    let _e1503 = edgesFront;
                    edgesFront = (_e1503 + 1i);
                }
                let _e1506 = hitPosFront[2u];
                let _e1508 = boxMin_2[2u];
                let _e1509 = e;
                let _e1511 = (_e1506 < (_e1508 + _e1509));
                phi_4298_ = _e1511;
                if !(_e1511) {
                    let _e1514 = hitPosFront[2u];
                    let _e1516 = boxMax_1[2u];
                    let _e1517 = e;
                    phi_4298_ = (_e1514 > (_e1516 - _e1517));
                }
                let _e1521 = phi_4298_;
                if _e1521 {
                    let _e1522 = edgesFront;
                    edgesFront = (_e1522 + 1i);
                }
                let _e1524 = edgesFront;
                if (_e1524 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1527 = hitPosBack[0u];
                let _e1529 = boxMin_2[0u];
                let _e1530 = e;
                let _e1532 = (_e1527 < (_e1529 + _e1530));
                phi_4326_ = _e1532;
                if !(_e1532) {
                    let _e1535 = hitPosBack[0u];
                    let _e1537 = boxMax_1[0u];
                    let _e1538 = e;
                    phi_4326_ = (_e1535 > (_e1537 - _e1538));
                }
                let _e1542 = phi_4326_;
                if _e1542 {
                    let _e1543 = edgesBack;
                    edgesBack = (_e1543 + 1i);
                }
                let _e1546 = hitPosBack[1u];
                let _e1548 = boxMin_2[1u];
                let _e1549 = e;
                let _e1551 = (_e1546 < (_e1548 + _e1549));
                phi_4348_ = _e1551;
                if !(_e1551) {
                    let _e1554 = hitPosBack[1u];
                    let _e1556 = boxMax_1[1u];
                    let _e1557 = e;
                    phi_4348_ = (_e1554 > (_e1556 - _e1557));
                }
                let _e1561 = phi_4348_;
                if _e1561 {
                    let _e1562 = edgesBack;
                    edgesBack = (_e1562 + 1i);
                }
                let _e1565 = hitPosBack[2u];
                let _e1567 = boxMin_2[2u];
                let _e1568 = e;
                let _e1570 = (_e1565 < (_e1567 + _e1568));
                phi_4370_ = _e1570;
                if !(_e1570) {
                    let _e1573 = hitPosBack[2u];
                    let _e1575 = boxMax_1[2u];
                    let _e1576 = e;
                    phi_4370_ = (_e1573 > (_e1575 - _e1576));
                }
                let _e1580 = phi_4370_;
                if _e1580 {
                    let _e1581 = edgesBack;
                    edgesBack = (_e1581 + 1i);
                }
                let _e1583 = edgesBack;
                if (_e1583 >= 2i) {
                    onBackEdge = true;
                }
                let _e1585 = onFrontEdge;
                let _e1586 = distFront;
                let _e1587 = finalDist;
                if (_e1585 && (_e1586 < _e1587)) {
                    let _e1590 = finalColor;
                    let _e1592 = cursorColor;
                    let _e1594 = mix(_e1590.xyz, _e1592, vec3(0.9f));
                    finalColor[0u] = _e1594.x;
                    finalColor[1u] = _e1594.y;
                    finalColor[2u] = _e1594.z;
                } else {
                    let _e1601 = onBackEdge;
                    let _e1602 = distBack;
                    let _e1603 = finalDist;
                    if (_e1601 && (_e1602 < _e1603)) {
                        let _e1606 = finalColor;
                        let _e1608 = cursorColor;
                        let _e1610 = mix(_e1606.xyz, _e1608, vec3(0.2f));
                        finalColor[0u] = _e1610.x;
                        finalColor[1u] = _e1610.y;
                        finalColor[2u] = _e1610.z;
                    } else {
                        let _e1617 = distFront;
                        let _e1618 = finalDist;
                        if (_e1617 < _e1618) {
                            let _e1620 = finalColor;
                            let _e1622 = cursorColor;
                            let _e1624 = mix(_e1620.xyz, _e1622, vec3(0.15f));
                            finalColor[0u] = _e1624.x;
                            finalColor[1u] = _e1624.y;
                            finalColor[2u] = _e1624.z;
                        }
                    }
                }
            }
        }
    }
    let _e1631 = hitFrontBox;
    if _e1631 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1632 = finalColor;
    outColor = _e1632;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
