// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 6bd8528a7bb518b9b99519cd10469467e7f2e3e179e5273a9377b07897745983

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
    cloudCheckIntervalTicks: u32,
    rainWaitMaxTicks: u32,
    cloudColumnFullCount: f32,
    cloudThicknessPerBlock: f32,
    cloudClumpThreshold: u32,
    rainWaitMinTicks: u32,
    steamCondenseTicks: u32,
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
    simTick: u32,
    lastRainTick: u32,
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
    let _e259 = (*p);
    return fract((sin(dot(_e259, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x: ptr<function, i32>, z: ptr<function, i32>) -> u32 {
    let _e260 = (*x);
    let _e261 = (*z);
    let _e263 = tuning.gridWidth;
    return (bitcast<u32>((_e260 + (_e261 * bitcast<i32>(_e263)))) * 4u);
}

fn sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b(x_1: ptr<function, i32>, z_1: ptr<function, i32>, count: ptr<function, f32>, topY: ptr<function, f32>) {
    var b: u32;
    var param: i32;
    var param_1: i32;
    var phi_2383_: bool;
    var phi_2395_: bool;

    let _e265 = (*x_1);
    let _e266 = (_e265 < 0i);
    phi_2383_ = _e266;
    if !(_e266) {
        let _e268 = (*x_1);
        let _e270 = tuning.gridWidth;
        phi_2383_ = (_e268 >= bitcast<i32>(_e270));
    }
    let _e274 = phi_2383_;
    let _e275 = (*z_1);
    let _e277 = (_e274 || (_e275 < 0i));
    phi_2395_ = _e277;
    if !(_e277) {
        let _e279 = (*z_1);
        let _e281 = tuning.gridDepth;
        phi_2395_ = (_e279 >= bitcast<i32>(_e281));
    }
    let _e285 = phi_2395_;
    if _e285 {
        (*count) = 0f;
        (*topY) = 0f;
        return;
    }
    let _e286 = (*x_1);
    param = _e286;
    let _e287 = (*z_1);
    param_1 = _e287;
    let _e288 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param), (&param_1));
    b = _e288;
    let _e289 = b;
    let _e293 = unnamed.cloudColumn[(_e289 + 2u)];
    (*count) = f32(_e293);
    let _e295 = b;
    let _e299 = unnamed.cloudColumn[(_e295 + 3u)];
    (*topY) = f32(_e299);
    return;
}

fn smoothedCloudColumn_u0028_i1_u003b_i1_u003b_i1_u003b_f1_u003b_f1_u003b(x_2: ptr<function, i32>, z_2: ptr<function, i32>, spread: ptr<function, i32>, count_1: ptr<function, f32>, topY_1: ptr<function, f32>) {
    var c0_: f32;
    var y0_: f32;
    var param_2: i32;
    var param_3: i32;
    var param_4: f32;
    var param_5: f32;
    var c1_: f32;
    var y1_: f32;
    var param_6: i32;
    var param_7: i32;
    var param_8: f32;
    var param_9: f32;
    var c2_: f32;
    var y2_: f32;
    var param_10: i32;
    var param_11: i32;
    var param_12: f32;
    var param_13: f32;
    var c3_: f32;
    var y3_: f32;
    var param_14: i32;
    var param_15: i32;
    var param_16: f32;
    var param_17: f32;
    var c4_: f32;
    var y4_: f32;
    var param_18: i32;
    var param_19: i32;
    var param_20: f32;
    var param_21: f32;

    let _e293 = (*x_2);
    param_2 = _e293;
    let _e294 = (*z_2);
    param_3 = _e294;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_2), (&param_3), (&param_4), (&param_5));
    let _e295 = param_4;
    c0_ = _e295;
    let _e296 = param_5;
    y0_ = _e296;
    let _e297 = (*x_2);
    let _e298 = (*spread);
    param_6 = (_e297 - _e298);
    let _e300 = (*z_2);
    param_7 = _e300;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_6), (&param_7), (&param_8), (&param_9));
    let _e301 = param_8;
    c1_ = _e301;
    let _e302 = param_9;
    y1_ = _e302;
    let _e303 = (*x_2);
    let _e304 = (*spread);
    param_10 = (_e303 + _e304);
    let _e306 = (*z_2);
    param_11 = _e306;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_10), (&param_11), (&param_12), (&param_13));
    let _e307 = param_12;
    c2_ = _e307;
    let _e308 = param_13;
    y2_ = _e308;
    let _e309 = (*z_2);
    let _e310 = (*spread);
    let _e312 = (*x_2);
    param_14 = _e312;
    param_15 = (_e309 - _e310);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_14), (&param_15), (&param_16), (&param_17));
    let _e313 = param_16;
    c3_ = _e313;
    let _e314 = param_17;
    y3_ = _e314;
    let _e315 = (*z_2);
    let _e316 = (*spread);
    let _e318 = (*x_2);
    param_18 = _e318;
    param_19 = (_e315 + _e316);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_18), (&param_19), (&param_20), (&param_21));
    let _e319 = param_20;
    c4_ = _e319;
    let _e320 = param_21;
    y4_ = _e320;
    let _e321 = c0_;
    let _e323 = c1_;
    let _e325 = c2_;
    let _e327 = c3_;
    let _e329 = c4_;
    (*count_1) = ((((((_e321 * 2f) + _e323) + _e325) + _e327) + _e329) / 6f);
    let _e332 = y0_;
    let _e333 = y1_;
    let _e335 = y2_;
    let _e336 = y3_;
    let _e339 = y4_;
    (*topY_1) = max(max(max(_e332, _e333), max(_e335, _e336)), _e339);
    return;
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
    var spread_1: i32;
    var i: i32;
    var cellCenter: vec3<f32>;
    var cx: i32;
    var cz: i32;
    var count_2: f32;
    var baseY: f32;
    var param_22: i32;
    var param_23: i32;
    var param_24: i32;
    var param_25: f32;
    var param_26: f32;
    var thickness: f32;
    var capY: f32;
    var density: f32;
    var mid: f32;
    var edgeFactor: f32;
    var threshold: f32;
    var fillHash: f32;
    var param_27: vec3<f32>;
    var shadeHash: f32;
    var param_28: vec3<f32>;
    var baseColor: vec3<f32>;
    var stormColor: vec3<f32>;
    var diffuse: f32;
    var phi_2693_: bool;
    var phi_2704_: bool;
    var phi_2745_: bool;

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
    normal = vec3<f32>(0f, 1f, 0f);
    let _e414 = (*tEnter);
    t = _e414;
    let _e416 = tuning.cloudVoxelSize;
    spread_1 = max(1i, i32(_e416));
    i = 0i;
    loop {
        let _e419 = i;
        let _e421 = tuning.maxCloudSteps;
        if (_e419 < bitcast<i32>(_e421)) {
            let _e424 = t;
            let _e425 = (*tExit);
            if (_e424 > _e425) {
                break;
            }
            let _e427 = cellPos;
            let _e432 = tuning.cloudVoxelSize;
            cellCenter = ((vec3<f32>(_e427) + vec3(0.5f)) * _e432);
            let _e435 = cellCenter[0u];
            cx = i32(floor(_e435));
            let _e439 = cellCenter[2u];
            cz = i32(floor(_e439));
            let _e442 = cx;
            let _e443 = (_e442 >= 0i);
            phi_2693_ = _e443;
            if _e443 {
                let _e444 = cx;
                let _e446 = tuning.gridWidth;
                phi_2693_ = (_e444 < bitcast<i32>(_e446));
            }
            let _e450 = phi_2693_;
            let _e451 = cz;
            let _e453 = (_e450 && (_e451 >= 0i));
            phi_2704_ = _e453;
            if _e453 {
                let _e454 = cz;
                let _e456 = tuning.gridDepth;
                phi_2704_ = (_e454 < bitcast<i32>(_e456));
            }
            let _e460 = phi_2704_;
            if _e460 {
                let _e461 = cx;
                param_22 = _e461;
                let _e462 = cz;
                param_23 = _e462;
                let _e463 = spread_1;
                param_24 = _e463;
                smoothedCloudColumn_u0028_i1_u003b_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_22), (&param_23), (&param_24), (&param_25), (&param_26));
                let _e464 = param_25;
                count_2 = _e464;
                let _e465 = param_26;
                baseY = _e465;
                let _e466 = count_2;
                if (_e466 > 0f) {
                    let _e468 = count_2;
                    let _e470 = tuning.cloudThicknessPerBlock;
                    thickness = (_e468 * max(_e470, 0.01f));
                    let _e473 = baseY;
                    let _e474 = thickness;
                    capY = (_e473 + _e474);
                    let _e477 = cellCenter[1u];
                    let _e478 = baseY;
                    let _e479 = (_e477 >= _e478);
                    phi_2745_ = _e479;
                    if _e479 {
                        let _e481 = cellCenter[1u];
                        let _e482 = capY;
                        phi_2745_ = (_e481 <= _e482);
                    }
                    let _e485 = phi_2745_;
                    if _e485 {
                        let _e486 = count_2;
                        let _e488 = tuning.cloudColumnFullCount;
                        density = clamp((_e486 / max(_e488, 1f)), 0f, 1f);
                        let _e492 = baseY;
                        let _e493 = capY;
                        mid = ((_e492 + _e493) * 0.5f);
                        let _e497 = cellCenter[1u];
                        let _e498 = mid;
                        let _e501 = thickness;
                        edgeFactor = clamp((abs((_e497 - _e498)) / max((_e501 * 0.5f), 0.001f)), 0f, 1f);
                        let _e507 = tuning.cloudEdgeThresholdMin;
                        let _e509 = tuning.cloudEdgeThresholdMax;
                        let _e510 = edgeFactor;
                        threshold = mix(_e507, _e509, _e510);
                        let _e512 = threshold;
                        let _e513 = density;
                        threshold = mix(1f, _e512, _e513);
                        let _e515 = cellPos;
                        param_27 = vec3<f32>(_e515);
                        let _e517 = hash_u0028_vf3_u003b((&param_27));
                        fillHash = _e517;
                        let _e518 = fillHash;
                        let _e519 = threshold;
                        if (_e518 > _e519) {
                            let _e521 = t;
                            (*tHit) = _e521;
                            let _e522 = density;
                            (*hitDensity) = _e522;
                            let _e523 = cellPos;
                            param_28 = ((vec3<f32>(_e523) * 3.71f) + vec3<f32>(91f, 5f, 7f));
                            let _e527 = hash_u0028_vf3_u003b((&param_28));
                            shadeHash = _e527;
                            let _e528 = shadeHash;
                            baseColor = mix(vec3<f32>(0.9f, 0.91f, 0.94f), vec3<f32>(1f, 1f, 1f), vec3(_e528));
                            stormColor = vec3<f32>(0.32f, 0.33f, 0.36f);
                            let _e531 = baseColor;
                            let _e532 = stormColor;
                            let _e533 = (*greyness);
                            baseColor = mix(_e531, _e532, vec3(_e533));
                            let _e536 = normal;
                            let _e537 = (*sunDir);
                            diffuse = (0.6f + (0.4f * max(dot(_e536, _e537), 0f)));
                            let _e542 = baseColor;
                            let _e543 = diffuse;
                            (*hitColor) = (_e542 * _e543);
                            return true;
                        }
                    }
                }
            }
            let _e546 = tMax[0u];
            let _e548 = tMax[1u];
            if (_e546 < _e548) {
                let _e551 = tMax[0u];
                let _e553 = tMax[2u];
                if (_e551 < _e553) {
                    let _e556 = stepDir[0u];
                    let _e558 = cellPos[0u];
                    cellPos[0u] = (_e558 + _e556);
                    let _e562 = tMax[0u];
                    t = _e562;
                    let _e564 = tDelta[0u];
                    let _e566 = tMax[0u];
                    tMax[0u] = (_e566 + _e564);
                    let _e570 = stepDir[0u];
                    normal = vec3<f32>(f32(-(_e570)), 0f, 0f);
                } else {
                    let _e575 = stepDir[2u];
                    let _e577 = cellPos[2u];
                    cellPos[2u] = (_e577 + _e575);
                    let _e581 = tMax[2u];
                    t = _e581;
                    let _e583 = tDelta[2u];
                    let _e585 = tMax[2u];
                    tMax[2u] = (_e585 + _e583);
                    let _e589 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e589)));
                }
            } else {
                let _e594 = tMax[1u];
                let _e596 = tMax[2u];
                if (_e594 < _e596) {
                    let _e599 = stepDir[1u];
                    let _e601 = cellPos[1u];
                    cellPos[1u] = (_e601 + _e599);
                    let _e605 = tMax[1u];
                    t = _e605;
                    let _e607 = tDelta[1u];
                    let _e609 = tMax[1u];
                    tMax[1u] = (_e609 + _e607);
                    let _e613 = stepDir[1u];
                    normal = vec3<f32>(0f, f32(-(_e613)), 0f);
                } else {
                    let _e618 = stepDir[2u];
                    let _e620 = cellPos[2u];
                    cellPos[2u] = (_e620 + _e618);
                    let _e624 = tMax[2u];
                    t = _e624;
                    let _e626 = tDelta[2u];
                    let _e628 = tMax[2u];
                    tMax[2u] = (_e628 + _e626);
                    let _e632 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e632)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e636 = i;
            i = (_e636 + 1i);
        }
    }
    return false;
}

fn renderBlackHole_u0028_vf3_u003b_vf3_u003b(normal_1: ptr<function, vec3<f32>>, rayDir_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var rim: f32;
    var glow: f32;

    let _e262 = (*normal_1);
    let _e263 = (*rayDir_1);
    rim = (1f - abs(dot(_e262, _e263)));
    let _e267 = rim;
    glow = pow(clamp(_e267, 0f, 1f), 4f);
    let _e270 = glow;
    return mix(vec3<f32>(0.01f, 0.01f, 0.02f), vec3<f32>(0.85f, 0.45f, 1f), vec3((_e270 * 0.7f)));
}

fn bhDecode_u0028_u1_u003b(code: ptr<function, u32>) -> vec3<i32> {
    var i_1: u32;

    let _e260 = (*code);
    i_1 = (_e260 & 1073741823u);
    let _e262 = i_1;
    let _e264 = tuning.gridWidth;
    let _e269 = i_1;
    let _e271 = tuning.gridWidth;
    let _e276 = tuning.gridHeight;
    let _e281 = i_1;
    let _e283 = tuning.gridWidth;
    let _e286 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e262 % bitcast<u32>(bitcast<i32>(_e264)))), bitcast<i32>(((_e269 / bitcast<u32>(bitcast<i32>(_e271))) % bitcast<u32>(bitcast<i32>(_e276)))), bitcast<i32>((_e281 / bitcast<u32>((bitcast<i32>(_e283) * bitcast<i32>(_e286))))));
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e259 = (*level);
    return (f32(_e259) + 0.5f);
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_1: u32;
    var l: u32;
    var r: f32;
    var param_29: u32;
    var volume: f32;

    level_1 = 0u;
    l = 1u;
    loop {
        let _e264 = l;
        let _e266 = tuning.blackHoleMaxLevel;
        if (_e264 <= min(_e266, 16u)) {
            let _e269 = l;
            param_29 = _e269;
            let _e270 = bhBodyRadius_u0028_u1_u003b((&param_29));
            r = _e270;
            let _e271 = r;
            let _e273 = r;
            let _e275 = r;
            volume = (((4.18879f * _e271) * _e273) * _e275);
            let _e277 = (*mass);
            let _e280 = tuning.blackHoleGrowthCost;
            let _e281 = volume;
            if (f32(_e277) < (_e280 * _e281)) {
                break;
            }
            let _e284 = l;
            level_1 = _e284;
            continue;
        } else {
            break;
        }
        continuing {
            let _e285 = l;
            l = (_e285 + bitcast<u32>(1i));
        }
    }
    let _e288 = level_1;
    return _e288;
}

fn accretionGlow_u0028_vf3_u003b_vi3_u003b(color: ptr<function, vec3<f32>>, voxelPos: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radius: f32;
    var closestSq: f32;
    var seen: u32;
    var i_2: i32;
    var code_1: u32;
    var d: vec3<f32>;
    var param_30: u32;
    var closest: f32;
    var heat: f32;
    var hot: vec3<f32>;
    var phi_2268_: bool;
    var phi_2297_: bool;

    let _e271 = unnamed.blackHoleCount;
    let _e272 = (_e271 == 0u);
    phi_2268_ = _e272;
    if !(_e272) {
        let _e275 = tuning.blackHoleGlow;
        phi_2268_ = (_e275 <= 0f);
    }
    let _e278 = phi_2268_;
    if _e278 {
        let _e279 = (*color);
        return _e279;
    }
    let _e281 = tuning.blackHoleRadius;
    radius = f32(_e281);
    let _e283 = radius;
    let _e284 = radius;
    closestSq = (_e283 * _e284);
    seen = 0u;
    i_2 = 0i;
    loop {
        let _e286 = i_2;
        let _e287 = (_e286 < 8i);
        phi_2297_ = _e287;
        if _e287 {
            let _e288 = seen;
            let _e290 = unnamed.blackHoleCount;
            phi_2297_ = (_e288 < _e290);
        }
        let _e293 = phi_2297_;
        if _e293 {
            let _e294 = i_2;
            let _e297 = unnamed.blackHoles[_e294];
            code_1 = _e297;
            let _e298 = code_1;
            if (_e298 == 0u) {
                continue;
            }
            let _e300 = seen;
            seen = (_e300 + bitcast<u32>(1i));
            let _e303 = code_1;
            param_30 = _e303;
            let _e304 = bhDecode_u0028_u1_u003b((&param_30));
            let _e305 = (*voxelPos);
            d = vec3<f32>((_e304 - _e305));
            let _e308 = closestSq;
            let _e309 = d;
            let _e310 = d;
            closestSq = min(_e308, dot(_e309, _e310));
            continue;
        } else {
            break;
        }
        continuing {
            let _e313 = i_2;
            i_2 = (_e313 + 1i);
        }
    }
    let _e315 = closestSq;
    let _e316 = radius;
    let _e317 = radius;
    if (_e315 >= (_e316 * _e317)) {
        let _e320 = (*color);
        return _e320;
    }
    let _e321 = closestSq;
    closest = sqrt(_e321);
    let _e323 = closest;
    let _e324 = radius;
    let _e329 = tuning.blackHoleGlow;
    heat = (pow((1f - (_e323 / _e324)), 3f) * _e329);
    let _e331 = heat;
    hot = mix(vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(1f, 0.95f, 0.85f), vec3(clamp(_e331, 0f, 1f)));
    let _e335 = (*color);
    let _e336 = hot;
    let _e337 = heat;
    return mix(_e335, _e336, vec3(clamp(_e337, 0f, 1f)));
}

fn renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b(rawVoxel: ptr<function, u32>, voxelPos_1: ptr<function, vec3<i32>>, baseLighting: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n: f32;
    var param_31: vec3<f32>;
    var dist: u32;
    var depth: f32;
    var inner: vec3<f32>;
    var outer: vec3<f32>;
    var leaf: vec3<f32>;

    let _e268 = (*voxelPos_1);
    param_31 = vec3<f32>(_e268);
    let _e270 = hash_u0028_vf3_u003b((&param_31));
    n = _e270;
    let _e271 = (*rawVoxel);
    dist = ((_e271 >> bitcast<u32>(24i)) & 255u);
    let _e275 = dist;
    if (_e275 == 255u) {
        let _e277 = n;
        let _e280 = (*baseLighting);
        return (mix(vec3<f32>(0.34f, 0.22f, 0.07f), vec3<f32>(0.52f, 0.38f, 0.12f), vec3(_e277)) * _e280);
    }
    let _e282 = dist;
    let _e285 = tuning.treeLeafReach;
    depth = clamp((f32(_e282) / max(f32(_e285), 1f)), 0f, 1f);
    inner = vec3<f32>(0.1f, 0.3f, 0.09f);
    outer = vec3<f32>(0.28f, 0.52f, 0.16f);
    let _e290 = inner;
    let _e291 = outer;
    let _e292 = depth;
    let _e294 = n;
    leaf = mix(_e290, _e291, vec3(((_e292 * 0.7f) + (_e294 * 0.3f))));
    let _e299 = leaf;
    let _e300 = (*baseLighting);
    return (_e299 * _e300);
}

fn renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_2: ptr<function, vec3<i32>>, subCell: ptr<function, vec3<f32>>, baseLighting_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var grain: f32;
    var param_32: vec3<f32>;
    var bark: vec3<f32>;

    let _e265 = (*voxelPos_2)[0u];
    let _e268 = (*voxelPos_2)[1u];
    let _e272 = (*subCell)[1u];
    let _e276 = (*voxelPos_2)[2u];
    param_32 = vec3<f32>(f32(_e265), ((f32(_e268) * 0.35f) + (_e272 * 0.2f)), f32(_e276));
    let _e279 = hash_u0028_vf3_u003b((&param_32));
    grain = _e279;
    let _e280 = grain;
    bark = mix(vec3<f32>(0.2f, 0.13f, 0.07f), vec3<f32>(0.38f, 0.25f, 0.13f), vec3(_e280));
    let _e283 = bark;
    let _e284 = (*baseLighting_1);
    return (_e283 * _e284);
}

fn renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_3: ptr<function, vec3<i32>>, subCell_1: ptr<function, vec3<f32>>, baseLighting_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_1: f32;
    var param_33: vec3<f32>;
    var shell: vec3<f32>;

    let _e264 = (*subCell_1);
    let _e266 = (*voxelPos_3);
    param_33 = ((_e264 * 1.37f) + (vec3<f32>(_e266) * 0.11f));
    let _e270 = hash_u0028_vf3_u003b((&param_33));
    n_1 = _e270;
    let _e271 = n_1;
    shell = mix(vec3<f32>(0.15f, 0.1f, 0.035f), vec3<f32>(0.55f, 0.4f, 0.11f), vec3(_e271));
    let _e274 = shell;
    let _e275 = (*baseLighting_2);
    return (_e274 * _e275);
}

fn renderDarkStone_u0028_vi3_u003b_vf3_u003b(voxelPos_4: ptr<function, vec3<i32>>, baseLighting_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise: f32;
    var param_34: vec3<f32>;
    var val: f32;

    let _e263 = (*voxelPos_4);
    param_34 = vec3<f32>(_e263);
    let _e265 = hash_u0028_vf3_u003b((&param_34));
    noise = _e265;
    let _e266 = noise;
    val = (0.1f + (_e266 * 0.06f));
    let _e269 = val;
    let _e271 = val;
    let _e273 = val;
    let _e276 = (*baseLighting_3);
    return (vec3<f32>((_e269 * 1.08f), (_e271 * 0.94f), (_e273 * 0.92f)) * _e276);
}

fn lavaStageColor_u0028_i1_u003b(stage: ptr<function, i32>) -> vec3<f32> {
    var indexable: array<vec3<f32>, 6>;

    let _e260 = (*stage);
    indexable = array<vec3<f32>, 6>(vec3<f32>(1f, 0.62f, 0.22f), vec3<f32>(1f, 0.4f, 0.07f), vec3<f32>(0.96f, 0.29f, 0.05f), vec3<f32>(0.86f, 0.2f, 0.04f), vec3<f32>(0.7f, 0.13f, 0.03f), vec3<f32>(0.44f, 0.07f, 0.02f));
    let _e264 = indexable[clamp((_e260 + 1i), 0i, 5i)];
    return _e264;
}

fn renderLava_u0028_u1_u003b_vi3_u003b(rawVoxel_1: ptr<function, u32>, voxelPos_5: ptr<function, vec3<i32>>) -> vec3<f32> {
    var stage_1: i32;
    var phase: f32;
    var param_35: vec3<f32>;
    var from_: vec3<f32>;
    var param_36: i32;
    var to: vec3<f32>;
    var param_37: i32;
    var leg: f32;
    var param_38: i32;
    var param_39: i32;
    var param_40: i32;
    var param_41: i32;
    var molten: vec3<f32>;
    var param_42: vec3<f32>;

    let _e274 = (*rawVoxel_1);
    stage_1 = clamp((bitcast<i32>((_e274 & 255u)) - 8i), 0i, 3i);
    let _e280 = pc.time;
    let _e282 = tuning.lavaChurnRate;
    let _e284 = (*voxelPos_5);
    param_35 = vec3<f32>(_e284);
    let _e286 = hash_u0028_vf3_u003b((&param_35));
    phase = fract(((_e280 * _e282) + _e286));
    let _e289 = phase;
    if (_e289 < 0.33333334f) {
        let _e291 = stage_1;
        param_36 = (_e291 - 1i);
        let _e293 = lavaStageColor_u0028_i1_u003b((&param_36));
        from_ = _e293;
        let _e294 = stage_1;
        param_37 = _e294;
        let _e295 = lavaStageColor_u0028_i1_u003b((&param_37));
        to = _e295;
        let _e296 = phase;
        leg = (_e296 * 3f);
    } else {
        let _e298 = phase;
        if (_e298 < 0.6666667f) {
            let _e300 = stage_1;
            param_38 = _e300;
            let _e301 = lavaStageColor_u0028_i1_u003b((&param_38));
            from_ = _e301;
            let _e302 = stage_1;
            param_39 = (_e302 + 1i);
            let _e304 = lavaStageColor_u0028_i1_u003b((&param_39));
            to = _e304;
            let _e305 = phase;
            leg = ((_e305 * 3f) - 1f);
        } else {
            let _e308 = stage_1;
            param_40 = (_e308 + 1i);
            let _e310 = lavaStageColor_u0028_i1_u003b((&param_40));
            from_ = _e310;
            let _e311 = stage_1;
            param_41 = (_e311 - 1i);
            let _e313 = lavaStageColor_u0028_i1_u003b((&param_41));
            to = _e313;
            let _e314 = phase;
            leg = ((_e314 * 3f) - 2f);
        }
    }
    let _e317 = from_;
    let _e318 = to;
    let _e319 = leg;
    molten = mix(_e317, _e318, vec3(smoothstep(0f, 1f, _e319)));
    let _e323 = molten;
    let _e324 = (*voxelPos_5);
    param_42 = (vec3<f32>(_e324) * 1.7f);
    let _e327 = hash_u0028_vf3_u003b((&param_42));
    return (_e323 * (0.9f + (_e327 * 0.1f)));
}

fn renderSteam_u0028_vi3_u003b_vf3_u003b(voxelPos_6: ptr<function, vec3<i32>>, baseLighting_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_1: f32;
    var param_43: vec3<f32>;
    var val_1: f32;
    var baseColor_1: vec3<f32>;

    let _e264 = (*voxelPos_6);
    let _e267 = pc.time;
    param_43 = (vec3<f32>(_e264) + vec3(_e267));
    let _e270 = hash_u0028_vf3_u003b((&param_43));
    noise_1 = _e270;
    let _e271 = noise_1;
    val_1 = (0.85f + (_e271 * 0.15f));
    let _e274 = val_1;
    baseColor_1 = vec3(_e274);
    let _e276 = baseColor_1;
    let _e277 = (*baseLighting_4);
    return ((_e276 * _e277) * 0.9f);
}

fn renderFire_u0028_u1_u003b_vi3_u003b(rawVoxel_2: ptr<function, u32>, voxelPos_7: ptr<function, vec3<i32>>) -> vec3<f32> {
    var noise_2: f32;
    var param_44: vec3<f32>;
    var age: u32;
    var life: f32;
    var coreColor: vec3<f32>;
    var edgeColor: vec3<f32>;
    var fireColor: vec3<f32>;

    let _e267 = (*voxelPos_7);
    let _e270 = pc.time;
    param_44 = (vec3<f32>(_e267) + vec3((_e270 * 10f)));
    let _e274 = hash_u0028_vf3_u003b((&param_44));
    noise_2 = _e274;
    let _e275 = (*rawVoxel_2);
    age = ((_e275 >> bitcast<u32>(24i)) & 255u);
    let _e279 = age;
    life = clamp((f32(_e279) / 30f), 0f, 1f);
    coreColor = vec3<f32>(1f, 0.9f, 0.2f);
    edgeColor = vec3<f32>(1f, 0.3f, 0f);
    let _e283 = coreColor;
    let _e284 = edgeColor;
    let _e285 = life;
    let _e286 = noise_2;
    fireColor = mix(_e283, _e284, vec3((_e285 + (_e286 * 0.3f))));
    let _e291 = fireColor;
    return (_e291 * 1.5f);
}

fn renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b(rawVoxel_3: ptr<function, u32>, voxelPos_8: ptr<function, vec3<i32>>, ddaNormal: ptr<function, vec3<f32>>, baseLighting_5: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_3: f32;
    var param_45: vec3<f32>;
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
    var phi_1269_: bool;

    let _e274 = (*voxelPos_8);
    param_45 = vec3<f32>(_e274);
    let _e276 = hash_u0028_vf3_u003b((&param_45));
    noise_3 = _e276;
    let _e277 = noise_3;
    val_2 = (0.8f + (_e277 * 0.2f));
    let _e280 = (*rawVoxel_3);
    moisture = ((_e280 >> bitcast<u32>(24i)) & 255u);
    let _e284 = moisture;
    wetness = clamp((f32(_e284) / 30f), 0f, 1f);
    let _e288 = val_2;
    let _e290 = val_2;
    let _e292 = val_2;
    dryColor = vec3<f32>((0.4f * _e288), (0.25f * _e290), (0.1f * _e292));
    let _e295 = val_2;
    let _e297 = val_2;
    let _e299 = val_2;
    wetColor = vec3<f32>((0.15f * _e295), (0.08f * _e297), (0.03f * _e299));
    let _e302 = dryColor;
    let _e303 = wetColor;
    let _e304 = wetness;
    baseColor_2 = mix(_e302, _e303, vec3(_e304));
    let _e307 = (*rawVoxel_3);
    floraState = ((_e307 >> bitcast<u32>(8i)) & 255u);
    let _e311 = floraState;
    let _e312 = (_e311 > 10u);
    phi_1269_ = _e312;
    if _e312 {
        let _e314 = (*ddaNormal)[1u];
        phi_1269_ = (_e314 > 0.5f);
    }
    let _e317 = phi_1269_;
    if _e317 {
        let _e318 = floraState;
        grassGrow = clamp((f32((_e318 - 10u)) / 90f), 0f, 1f);
        let _e323 = noise_3;
        let _e326 = noise_3;
        grassColor = vec3<f32>((0.15f + (_e323 * 0.1f)), (0.45f + (_e326 * 0.15f)), 0.15f);
        let _e330 = floraState;
        if (_e330 > 100u) {
            let _e332 = floraState;
            drown = clamp((f32((_e332 - 100u)) / 100f), 0f, 1f);
            let _e337 = grassColor;
            let _e338 = drown;
            grassColor = mix(_e337, vec3<f32>(0.35f, 0.35f, 0.15f), vec3(_e338));
        }
        let _e341 = baseColor_2;
        let _e342 = grassColor;
        let _e343 = grassGrow;
        baseColor_2 = mix(_e341, _e342, vec3(_e343));
    }
    let _e346 = baseColor_2;
    let _e347 = (*baseLighting_5);
    return (_e346 * _e347);
}

fn renderStone_u0028_vi3_u003b_vf3_u003b(voxelPos_9: ptr<function, vec3<i32>>, baseLighting_6: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_4: f32;
    var param_46: vec3<f32>;
    var val_3: f32;
    var baseColor_3: vec3<f32>;

    let _e264 = (*voxelPos_9);
    param_46 = vec3<f32>(_e264);
    let _e266 = hash_u0028_vf3_u003b((&param_46));
    noise_4 = _e266;
    let _e267 = noise_4;
    val_3 = (0.4f + (_e267 * 0.3f));
    let _e270 = val_3;
    baseColor_3 = vec3(_e270);
    let _e272 = baseColor_3;
    let _e273 = (*baseLighting_6);
    return (_e272 * _e273);
}

fn renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b(voxelPos_10: ptr<function, vec3<i32>>, normal_2: ptr<function, vec3<f32>>, rayOrigin_1: ptr<function, vec3<f32>>, sunDir_1: ptr<function, vec3<f32>>, sunColor: ptr<function, vec3<f32>>, shadow: ptr<function, f32>, baseLighting_7: ptr<function, vec3<f32>>) -> vec3<f32> {
    var baseColor_4: vec3<f32>;
    var viewDir: vec3<f32>;
    var reflectDir: vec3<f32>;
    var spec: f32;
    var finalLighting: vec3<f32>;

    baseColor_4 = vec3<f32>(0.1f, 0.4f, 0.9f);
    let _e270 = (*rayOrigin_1);
    let _e271 = (*voxelPos_10);
    viewDir = normalize((_e270 - vec3<f32>(_e271)));
    let _e275 = (*sunDir_1);
    let _e277 = (*normal_2);
    reflectDir = reflect(-(_e275), _e277);
    let _e279 = viewDir;
    let _e280 = reflectDir;
    spec = pow(max(dot(_e279, _e280), 0f), 32f);
    let _e284 = (*baseLighting_7);
    let _e285 = (*sunColor);
    let _e286 = spec;
    let _e289 = (*shadow);
    finalLighting = (_e284 + (((_e285 * _e286) * 0.5f) * _e289));
    let _e292 = baseColor_4;
    let _e293 = finalLighting;
    return (_e292 * _e293);
}

fn renderSand_u0028_u1_u003b_vf3_u003b(rawVoxel_4: ptr<function, u32>, baseLighting_8: ptr<function, vec3<f32>>) -> vec3<f32> {
    var moisture_1: u32;
    var wetness_1: f32;
    var dryColor_1: vec3<f32>;
    var wetColor_1: vec3<f32>;
    var baseColor_5: vec3<f32>;

    let _e265 = (*rawVoxel_4);
    moisture_1 = ((_e265 >> bitcast<u32>(24i)) & 255u);
    let _e269 = moisture_1;
    wetness_1 = clamp((f32(_e269) / 10f), 0f, 1f);
    dryColor_1 = vec3<f32>(0.9f, 0.8f, 0.2f);
    wetColor_1 = vec3<f32>(0.65f, 0.55f, 0.15f);
    let _e273 = dryColor_1;
    let _e274 = wetColor_1;
    let _e275 = wetness_1;
    baseColor_5 = mix(_e273, _e274, vec3(_e275));
    let _e278 = baseColor_5;
    let _e279 = (*baseLighting_8);
    return (_e278 * _e279);
}

fn getVoxel_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    var index: u32;
    var phi_284_: bool;
    var phi_292_: bool;
    var phi_302_: bool;
    var phi_310_: bool;
    var phi_320_: bool;

    let _e261 = (*pos)[0u];
    let _e262 = (_e261 < 0i);
    phi_284_ = _e262;
    if !(_e262) {
        let _e265 = (*pos)[0u];
        let _e267 = tuning.gridWidth;
        phi_284_ = (_e265 >= bitcast<i32>(_e267));
    }
    let _e271 = phi_284_;
    phi_292_ = _e271;
    if !(_e271) {
        let _e274 = (*pos)[1u];
        phi_292_ = (_e274 < 0i);
    }
    let _e277 = phi_292_;
    phi_302_ = _e277;
    if !(_e277) {
        let _e280 = (*pos)[1u];
        let _e282 = tuning.gridHeight;
        phi_302_ = (_e280 >= bitcast<i32>(_e282));
    }
    let _e286 = phi_302_;
    phi_310_ = _e286;
    if !(_e286) {
        let _e289 = (*pos)[2u];
        phi_310_ = (_e289 < 0i);
    }
    let _e292 = phi_310_;
    phi_320_ = _e292;
    if !(_e292) {
        let _e295 = (*pos)[2u];
        let _e297 = tuning.gridDepth;
        phi_320_ = (_e295 >= bitcast<i32>(_e297));
    }
    let _e301 = phi_320_;
    if _e301 {
        return 0u;
    }
    let _e303 = (*pos)[0u];
    let _e305 = (*pos)[1u];
    let _e307 = tuning.gridWidth;
    let _e312 = (*pos)[2u];
    let _e314 = tuning.gridWidth;
    let _e318 = tuning.gridHeight;
    index = bitcast<u32>(((_e303 + (_e305 * bitcast<i32>(_e307))) + ((_e312 * bitcast<i32>(_e314)) * bitcast<i32>(_e318))));
    let _e323 = index;
    let _e326 = unnamed_1.grid[_e323];
    return _e326;
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
    var param_47: vec3<i32>;
    var phi_601_: bool;
    var phi_608_: bool;
    var phi_616_: bool;
    var phi_623_: bool;
    var phi_633_: bool;

    let _e273 = (*hitVoxelPos);
    let _e274 = (*hitNormal);
    voxelPos_11 = (_e273 + vec3<i32>(round(_e274)));
    let _e278 = (*lightDir);
    stepDir_1 = vec3<i32>(sign(_e278));
    let _e282 = (*lightDir)[0u];
    if (_e282 == 0f) {
        local_6 = 100000000f;
    } else {
        let _e285 = (*lightDir)[0u];
        local_6 = abs((1f / _e285));
    }
    let _e288 = local_6;
    let _e290 = (*lightDir)[1u];
    if (_e290 == 0f) {
        local_7 = 100000000f;
    } else {
        let _e293 = (*lightDir)[1u];
        local_7 = abs((1f / _e293));
    }
    let _e296 = local_7;
    let _e298 = (*lightDir)[2u];
    if (_e298 == 0f) {
        local_8 = 100000000f;
    } else {
        let _e301 = (*lightDir)[2u];
        local_8 = abs((1f / _e301));
    }
    let _e304 = local_8;
    tDelta_1 = vec3<f32>(_e288, _e296, _e304);
    let _e306 = tDelta_1;
    tMax_1 = (_e306 * 0.5f);
    transmittance = 1f;
    i_3 = 0i;
    loop {
        let _e308 = i_3;
        let _e310 = tuning.shadowMaxSteps;
        if (_e308 < bitcast<i32>(_e310)) {
            let _e314 = voxelPos_11[0u];
            let _e315 = (_e314 < 0i);
            phi_601_ = _e315;
            if !(_e315) {
                let _e318 = voxelPos_11[0u];
                let _e320 = tuning.gridWidth;
                phi_601_ = (_e318 >= bitcast<i32>(_e320));
            }
            let _e324 = phi_601_;
            phi_608_ = _e324;
            if !(_e324) {
                let _e327 = voxelPos_11[1u];
                phi_608_ = (_e327 < 0i);
            }
            let _e330 = phi_608_;
            phi_616_ = _e330;
            if !(_e330) {
                let _e333 = voxelPos_11[1u];
                let _e334 = (*ceilingY);
                phi_616_ = (_e333 >= _e334);
            }
            let _e337 = phi_616_;
            phi_623_ = _e337;
            if !(_e337) {
                let _e340 = voxelPos_11[2u];
                phi_623_ = (_e340 < 0i);
            }
            let _e343 = phi_623_;
            phi_633_ = _e343;
            if !(_e343) {
                let _e346 = voxelPos_11[2u];
                let _e348 = tuning.gridDepth;
                phi_633_ = (_e346 >= bitcast<i32>(_e348));
            }
            let _e352 = phi_633_;
            if _e352 {
                let _e353 = transmittance;
                return _e353;
            }
            let _e354 = voxelPos_11;
            param_47 = _e354;
            let _e355 = getVoxel_u0028_vi3_u003b((&param_47));
            blockerType = (_e355 & 255u);
            let _e357 = blockerType;
            if (_e357 == 2u) {
                let _e360 = tuning.waterShadowTransmit;
                let _e361 = transmittance;
                transmittance = (_e361 * _e360);
                let _e363 = transmittance;
                if (_e363 < 0.02f) {
                    return 0f;
                }
            } else {
                let _e365 = blockerType;
                if (_e365 != 0u) {
                    return 0f;
                }
            }
            let _e368 = tMax_1[0u];
            let _e370 = tMax_1[1u];
            if (_e368 < _e370) {
                let _e373 = tMax_1[0u];
                let _e375 = tMax_1[2u];
                if (_e373 < _e375) {
                    let _e378 = stepDir_1[0u];
                    let _e380 = voxelPos_11[0u];
                    voxelPos_11[0u] = (_e380 + _e378);
                    let _e384 = tDelta_1[0u];
                    let _e386 = tMax_1[0u];
                    tMax_1[0u] = (_e386 + _e384);
                } else {
                    let _e390 = stepDir_1[2u];
                    let _e392 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e392 + _e390);
                    let _e396 = tDelta_1[2u];
                    let _e398 = tMax_1[2u];
                    tMax_1[2u] = (_e398 + _e396);
                }
            } else {
                let _e402 = tMax_1[1u];
                let _e404 = tMax_1[2u];
                if (_e402 < _e404) {
                    let _e407 = stepDir_1[1u];
                    let _e409 = voxelPos_11[1u];
                    voxelPos_11[1u] = (_e409 + _e407);
                    let _e413 = tDelta_1[1u];
                    let _e415 = tMax_1[1u];
                    tMax_1[1u] = (_e415 + _e413);
                } else {
                    let _e419 = stepDir_1[2u];
                    let _e421 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e421 + _e419);
                    let _e425 = tDelta_1[2u];
                    let _e427 = tMax_1[2u];
                    tMax_1[2u] = (_e427 + _e425);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e430 = i_3;
            i_3 = (_e430 + 1i);
        }
    }
    let _e432 = transmittance;
    return _e432;
}

fn getSmoothNormal_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> vec3<f32> {
    var n_2: vec3<f32>;
    var x_3: i32;
    var y: i32;
    var z_3: i32;
    var param_48: vec3<i32>;
    var offset: vec3<f32>;

    n_2 = vec3<f32>(0f, 0f, 0f);
    x_3 = -1i;
    loop {
        let _e265 = x_3;
        if (_e265 <= 1i) {
            y = -1i;
            loop {
                let _e267 = y;
                if (_e267 <= 1i) {
                    z_3 = -1i;
                    loop {
                        let _e269 = z_3;
                        if (_e269 <= 1i) {
                            let _e271 = x_3;
                            let _e273 = y;
                            let _e276 = z_3;
                            if (((_e271 == 0i) && (_e273 == 0i)) && (_e276 == 0i)) {
                                continue;
                            }
                            let _e279 = (*p_1);
                            let _e280 = x_3;
                            let _e281 = y;
                            let _e282 = z_3;
                            param_48 = (_e279 + vec3<i32>(_e280, _e281, _e282));
                            let _e285 = getVoxel_u0028_vi3_u003b((&param_48));
                            if ((_e285 & 255u) == 0u) {
                                continue;
                            }
                            let _e288 = x_3;
                            let _e290 = y;
                            let _e292 = z_3;
                            offset = vec3<f32>(f32(_e288), f32(_e290), f32(_e292));
                            let _e295 = offset;
                            let _e296 = x_3;
                            let _e297 = x_3;
                            let _e299 = y;
                            let _e300 = y;
                            let _e303 = z_3;
                            let _e304 = z_3;
                            let _e310 = n_2;
                            n_2 = (_e310 - (_e295 * inverseSqrt(f32((((_e296 * _e297) + (_e299 * _e300)) + (_e303 * _e304))))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e312 = z_3;
                            z_3 = (_e312 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e314 = y;
                    y = (_e314 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e316 = x_3;
            x_3 = (_e316 + 1i);
        }
    }
    let _e318 = n_2;
    if (length(_e318) < 0.1f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e321 = n_2;
    return normalize(_e321);
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

    let _e274 = tuning.waterWaveScale;
    scale = max(_e274, 0.001f);
    let _e276 = (*t_1);
    let _e278 = tuning.waterWaveSpeed;
    wt = ((_e276 * _e278) * 0.35f);
    let _e281 = (*p_2);
    let _e283 = (*p_2)[1u];
    let _e285 = wt;
    let _e289 = (*p_2)[0u];
    let _e291 = wt;
    q = (_e281 + (vec2<f32>(sin(((_e283 * 0.043f) + _e285)), sin(((_e289 * 0.037f) - (_e291 * 0.8f)))) * 6f));
    grad = vec2<f32>(0f, 0f);
    i_4 = 0i;
    loop {
        let _e298 = i_4;
        if (_e298 < 5i) {
            let _e300 = i_4;
            indexable_1 = array<f32, 5>(0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
            let _e302 = indexable_1[_e300];
            let _e303 = scale;
            f = (_e302 * _e303);
            let _e305 = i_4;
            indexable_2 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e307 = indexable_2[_e305];
            let _e308 = q;
            let _e310 = f;
            let _e312 = (*t_1);
            let _e313 = i_4;
            indexable_3 = array<f32, 5>(1f, 1.37f, 0.83f, 1.71f, 0.61f);
            let _e315 = indexable_3[_e313];
            let _e318 = tuning.waterWaveSpeed;
            phase_1 = ((dot(_e307, _e308) * _e310) + ((_e312 * _e315) * _e318));
            let _e321 = i_4;
            indexable_4 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e323 = indexable_4[_e321];
            let _e324 = i_4;
            indexable_5 = array<f32, 5>(1f, 0.62f, 0.38f, 0.24f, 0.15f);
            let _e326 = indexable_5[_e324];
            let _e327 = f;
            let _e329 = phase_1;
            let _e333 = grad;
            grad = (_e333 + (_e323 * ((_e326 * _e327) * cos(_e329))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e335 = i_4;
            i_4 = (_e335 + 1i);
        }
    }
    let _e338 = (*p_2)[0u];
    let _e341 = (*p_2)[1u];
    let _e344 = (*t_1);
    envelope = (0.45f + (0.55f * sin((((_e338 * 0.021f) + (_e341 * 0.017f)) + (_e344 * 0.11f)))));
    let _e350 = grad;
    let _e351 = envelope;
    return (_e350 * _e351);
}

fn applyWaterWaves_u0028_vf3_u003b_vi3_u003b(normal_3: ptr<function, vec3<f32>>, voxelPos_12: ptr<function, vec3<i32>>) -> vec3<f32> {
    var upness: f32;
    var grad_1: vec2<f32>;
    var param_49: vec2<f32>;
    var param_50: f32;

    let _e265 = tuning.waterWaveStrength;
    if (_e265 <= 0f) {
        let _e267 = (*normal_3);
        return _e267;
    }
    let _e269 = (*normal_3)[1u];
    upness = clamp(_e269, 0f, 1f);
    let _e271 = upness;
    if (_e271 <= 0f) {
        let _e273 = (*normal_3);
        return _e273;
    }
    let _e274 = (*voxelPos_12);
    param_49 = (vec2<f32>(_e274.xz) + vec2<f32>(0.5f, 0.5f));
    let _e279 = pc.time;
    param_50 = _e279;
    let _e280 = waterWaveGradient_u0028_vf2_u003b_f1_u003b((&param_49), (&param_50));
    grad_1 = _e280;
    let _e281 = (*normal_3);
    let _e283 = grad_1[0u];
    let _e286 = grad_1[1u];
    let _e290 = tuning.waterWaveStrength;
    let _e292 = upness;
    return normalize((_e281 + ((vec3<f32>(-(_e283), 0f, -(_e286)) * _e290) * _e292)));
}

fn getWaterNormal_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> vec3<f32> {
    var n_3: vec3<f32>;
    var x_4: i32;
    var y_1: i32;
    var z_4: i32;
    var d2_: i32;
    var param_51: vec3<i32>;

    n_3 = vec3<f32>(0f, 0f, 0f);
    x_4 = -2i;
    loop {
        let _e265 = x_4;
        if (_e265 <= 2i) {
            y_1 = -2i;
            loop {
                let _e267 = y_1;
                if (_e267 <= 2i) {
                    z_4 = -2i;
                    loop {
                        let _e269 = z_4;
                        if (_e269 <= 2i) {
                            let _e271 = x_4;
                            let _e273 = y_1;
                            let _e276 = z_4;
                            if (((_e271 == 0i) && (_e273 == 0i)) && (_e276 == 0i)) {
                                continue;
                            }
                            let _e279 = x_4;
                            let _e280 = x_4;
                            let _e282 = y_1;
                            let _e283 = y_1;
                            let _e286 = z_4;
                            let _e287 = z_4;
                            d2_ = (((_e279 * _e280) + (_e282 * _e283)) + (_e286 * _e287));
                            let _e290 = d2_;
                            if (_e290 > 6i) {
                                continue;
                            }
                            let _e292 = (*p_3);
                            let _e293 = x_4;
                            let _e294 = y_1;
                            let _e295 = z_4;
                            param_51 = (_e292 + vec3<i32>(_e293, _e294, _e295));
                            let _e298 = getVoxel_u0028_vi3_u003b((&param_51));
                            if ((_e298 & 255u) == 0u) {
                                continue;
                            }
                            let _e301 = x_4;
                            let _e303 = y_1;
                            let _e305 = z_4;
                            let _e308 = d2_;
                            let _e312 = n_3;
                            n_3 = (_e312 - (vec3<f32>(f32(_e301), f32(_e303), f32(_e305)) / vec3(f32(_e308))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e314 = z_4;
                            z_4 = (_e314 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e316 = y_1;
                    y_1 = (_e316 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e318 = x_4;
            x_4 = (_e318 + 1i);
        }
    }
    let _e320 = n_3;
    if (length(_e320) < 0.001f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e323 = n_3;
    return normalize(_e323);
}

fn locustDensity_u0028_u1_u003b(type_38: ptr<function, u32>) -> f32 {
    var stage_2: f32;

    let _e260 = (*type_38);
    stage_2 = (f32((_e260 - 13u)) / 4f);
    let _e265 = tuning.locustDensityMin;
    let _e267 = tuning.locustDensityMax;
    let _e268 = stage_2;
    return clamp(mix(_e265, _e267, _e268), 0.02f, 0.98f);
}

fn trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b(voxelPos_13: ptr<function, vec3<i32>>, a: ptr<function, vec2<f32>>, b_1: ptr<function, vec2<f32>>, count_3: ptr<function, i32>) {
    var h0_: f32;
    var param_52: vec3<f32>;
    var h1_: f32;
    var param_53: vec3<f32>;
    var h2_: f32;
    var param_54: vec3<f32>;

    let _e269 = (*voxelPos_13)[0u];
    let _e272 = (*voxelPos_13)[2u];
    param_52 = vec3<f32>(f32(_e269), 7f, f32(_e272));
    let _e275 = hash_u0028_vf3_u003b((&param_52));
    h0_ = _e275;
    let _e277 = (*voxelPos_13)[0u];
    let _e280 = (*voxelPos_13)[2u];
    param_53 = vec3<f32>(f32(_e277), 19f, f32(_e280));
    let _e283 = hash_u0028_vf3_u003b((&param_53));
    h1_ = _e283;
    let _e285 = (*voxelPos_13)[0u];
    let _e288 = (*voxelPos_13)[2u];
    param_54 = vec3<f32>(f32(_e285), 53f, f32(_e288));
    let _e291 = hash_u0028_vf3_u003b((&param_54));
    h2_ = _e291;
    let _e292 = h2_;
    let _e294 = tuning.treeTrunkColumns;
    (*count_3) = (1i + i32((_e292 * f32(max(bitcast<i32>(_e294), 1i)))));
    let _e301 = (*count_3);
    (*count_3) = clamp(_e301, 1i, 2i);
    let _e303 = h0_;
    let _e306 = h1_;
    (*a) = vec2<f32>((0.3f + (_e303 * 0.4f)), (0.3f + (_e306 * 0.4f)));
    let _e310 = h1_;
    let _e313 = h0_;
    (*b_1) = vec2<f32>((0.3f + (_e310 * 0.4f)), (0.3f + (_e313 * 0.4f)));
    return;
}

fn subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b(kind: ptr<function, u32>, type_39: ptr<function, u32>, voxelPos_14: ptr<function, vec3<i32>>, cell: ptr<function, vec3<i32>>, sub: ptr<function, i32>, jitter: ptr<function, vec3<f32>>) -> bool {
    var p_4: vec2<f32>;
    var a_1: vec2<f32>;
    var b_2: vec2<f32>;
    var count_4: i32;
    var param_55: vec3<i32>;
    var param_56: vec2<f32>;
    var param_57: vec2<f32>;
    var param_58: i32;
    var r_1: f32;
    var param_59: vec3<f32>;
    var param_60: u32;
    var phi_1635_: bool;

    let _e275 = (*kind);
    if (_e275 == 1u) {
        let _e277 = (*cell);
        let _e282 = (*sub);
        p_4 = ((vec2<f32>(_e277.xz) + vec2(0.5f)) / vec2(f32(_e282)));
        let _e286 = (*voxelPos_14);
        param_55 = _e286;
        trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b((&param_55), (&param_56), (&param_57), (&param_58));
        let _e287 = param_56;
        a_1 = _e287;
        let _e288 = param_57;
        b_2 = _e288;
        let _e289 = param_58;
        count_4 = _e289;
        let _e291 = tuning.treeTrunkRadius;
        r_1 = max(_e291, 0.02f);
        let _e293 = p_4;
        let _e294 = a_1;
        let _e296 = p_4;
        let _e297 = a_1;
        let _e300 = r_1;
        let _e301 = r_1;
        if (dot((_e293 - _e294), (_e296 - _e297)) <= (_e300 * _e301)) {
            return true;
        }
        let _e304 = count_4;
        let _e305 = (_e304 > 1i);
        phi_1635_ = _e305;
        if _e305 {
            let _e306 = p_4;
            let _e307 = b_2;
            let _e309 = p_4;
            let _e310 = b_2;
            let _e313 = r_1;
            let _e314 = r_1;
            phi_1635_ = (dot((_e306 - _e307), (_e309 - _e310)) <= (_e313 * _e314));
        }
        let _e318 = phi_1635_;
        if _e318 {
            return true;
        }
        return false;
    }
    let _e319 = (*voxelPos_14);
    let _e320 = (*sub);
    let _e323 = (*cell);
    let _e326 = (*jitter);
    param_59 = (vec3<f32>(((_e319 * vec3(_e320)) + _e323)) + _e326);
    let _e328 = hash_u0028_vf3_u003b((&param_59));
    let _e329 = (*type_39);
    param_60 = _e329;
    let _e330 = locustDensity_u0028_u1_u003b((&param_60));
    return (_e328 < _e330);
}

fn intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b(ro: ptr<function, vec3<f32>>, rd: ptr<function, vec3<f32>>, boxMin: ptr<function, vec3<f32>>, boxMax: ptr<function, vec3<f32>>) -> vec2<f32> {
    var tMin: vec3<f32>;
    var tMax_2: vec3<f32>;
    var t1_: vec3<f32>;
    var t2_: vec3<f32>;
    var tNear: f32;
    var tFar: f32;

    let _e268 = (*boxMin);
    let _e269 = (*ro);
    let _e271 = (*rd);
    tMin = ((_e268 - _e269) / _e271);
    let _e273 = (*boxMax);
    let _e274 = (*ro);
    let _e276 = (*rd);
    tMax_2 = ((_e273 - _e274) / _e276);
    let _e278 = tMin;
    let _e279 = tMax_2;
    t1_ = min(_e278, _e279);
    let _e281 = tMin;
    let _e282 = tMax_2;
    t2_ = max(_e281, _e282);
    let _e285 = t1_[0u];
    let _e287 = t1_[1u];
    let _e290 = t1_[2u];
    tNear = max(max(_e285, _e287), _e290);
    let _e293 = t2_[0u];
    let _e295 = t2_[1u];
    let _e298 = t2_[2u];
    tFar = min(min(_e293, _e295), _e298);
    let _e300 = tNear;
    let _e301 = tFar;
    return vec2<f32>(_e300, _e301);
}

fn subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b(voxelPos_15: ptr<function, vec3<i32>>, rayOrigin_2: ptr<function, vec3<f32>>, rayDir_2: ptr<function, vec3<f32>>, kind_1: ptr<function, u32>, type_40: ptr<function, u32>, entryNormal: ptr<function, vec3<f32>>, tHit_1: ptr<function, f32>, subNormal: ptr<function, vec3<f32>>, subCell_2: ptr<function, vec3<f32>>) -> bool {
    var sub_1: i32;
    var cellSize: f32;
    var boxMin_1: vec3<f32>;
    var span: vec2<f32>;
    var param_61: vec3<f32>;
    var param_62: vec3<f32>;
    var param_63: vec3<f32>;
    var param_64: vec3<f32>;
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
    var param_65: u32;
    var param_66: u32;
    var param_67: vec3<i32>;
    var param_68: vec3<i32>;
    var param_69: i32;
    var param_70: vec3<f32>;
    var phi_1867_: bool;
    var phi_1874_: bool;
    var phi_1882_: bool;
    var phi_1889_: bool;
    var phi_1897_: bool;

    (*tHit_1) = 0f;
    let _e297 = (*entryNormal);
    (*subNormal) = _e297;
    (*subCell_2) = vec3<f32>(0f, 0f, 0f);
    let _e299 = tuning.locustSubdivision;
    sub_1 = clamp(bitcast<i32>(_e299), 1i, 8i);
    let _e302 = sub_1;
    cellSize = (1f / f32(_e302));
    let _e305 = (*voxelPos_15);
    boxMin_1 = vec3<f32>(_e305);
    let _e307 = boxMin_1;
    let _e309 = (*rayOrigin_2);
    param_61 = _e309;
    let _e310 = (*rayDir_2);
    param_62 = _e310;
    let _e311 = boxMin_1;
    param_63 = _e311;
    param_64 = (_e307 + vec3<f32>(1f, 1f, 1f));
    let _e312 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_61), (&param_62), (&param_63), (&param_64));
    span = _e312;
    let _e314 = span[0u];
    t_2 = max(_e314, 0f);
    let _e316 = t_2;
    let _e318 = span[1u];
    if (_e316 > _e318) {
        return false;
    }
    let _e320 = (*rayOrigin_2);
    let _e321 = (*rayDir_2);
    let _e322 = t_2;
    let _e326 = boxMin_1;
    let _e328 = sub_1;
    local_9 = (((_e320 + (_e321 * (_e322 + 0.0001f))) - _e326) * f32(_e328));
    let _e331 = local_9;
    let _e334 = sub_1;
    c = clamp(vec3<i32>(floor(_e331)), vec3<i32>(0i, 0i, 0i), vec3((_e334 - 1i)));
    let _e338 = (*rayDir_2);
    stepDir_2 = vec3<i32>(sign(_e338));
    let _e342 = (*rayDir_2)[0u];
    if (_e342 == 0f) {
        local_10 = 1000000f;
    } else {
        let _e344 = cellSize;
        let _e346 = (*rayDir_2)[0u];
        local_10 = abs((_e344 / _e346));
    }
    let _e349 = local_10;
    let _e351 = (*rayDir_2)[1u];
    if (_e351 == 0f) {
        local_11 = 1000000f;
    } else {
        let _e353 = cellSize;
        let _e355 = (*rayDir_2)[1u];
        local_11 = abs((_e353 / _e355));
    }
    let _e358 = local_11;
    let _e360 = (*rayDir_2)[2u];
    if (_e360 == 0f) {
        local_12 = 1000000f;
    } else {
        let _e362 = cellSize;
        let _e364 = (*rayDir_2)[2u];
        local_12 = abs((_e362 / _e364));
    }
    let _e367 = local_12;
    tDelta_2 = vec3<f32>(_e349, _e358, _e367);
    let _e369 = local_9;
    let _e370 = c;
    fracPos_1 = (_e369 - vec3<f32>(_e370));
    let _e373 = t_2;
    let _e375 = stepDir_2[0u];
    if (_e375 > 0i) {
        let _e378 = fracPos_1[0u];
        let _e381 = tDelta_2[0u];
        local_13 = ((1f - _e378) * _e381);
    } else {
        let _e384 = fracPos_1[0u];
        let _e386 = tDelta_2[0u];
        local_13 = (_e384 * _e386);
    }
    let _e388 = local_13;
    let _e390 = stepDir_2[1u];
    if (_e390 > 0i) {
        let _e393 = fracPos_1[1u];
        let _e396 = tDelta_2[1u];
        local_14 = ((1f - _e393) * _e396);
    } else {
        let _e399 = fracPos_1[1u];
        let _e401 = tDelta_2[1u];
        local_14 = (_e399 * _e401);
    }
    let _e403 = local_14;
    let _e405 = stepDir_2[2u];
    if (_e405 > 0i) {
        let _e408 = fracPos_1[2u];
        let _e411 = tDelta_2[2u];
        local_15 = ((1f - _e408) * _e411);
    } else {
        let _e414 = fracPos_1[2u];
        let _e416 = tDelta_2[2u];
        local_15 = (_e414 * _e416);
    }
    let _e418 = local_15;
    tMax_3 = (vec3(_e373) + vec3<f32>(_e388, _e403, _e418));
    let _e422 = (*kind_1);
    if (_e422 == 0u) {
        let _e425 = pc.time;
        let _e427 = tuning.locustCrawlRate;
        local_16 = vec3((floor((_e425 * _e427)) * 1.7f));
    } else {
        local_16 = vec3<f32>(0f, 0f, 0f);
    }
    let _e432 = local_16;
    jitter_1 = _e432;
    i_5 = 0i;
    loop {
        let _e433 = i_5;
        let _e434 = sub_1;
        if (_e433 < (3i * _e434)) {
            let _e438 = c[0u];
            let _e439 = (_e438 < 0i);
            phi_1867_ = _e439;
            if !(_e439) {
                let _e442 = c[0u];
                let _e443 = sub_1;
                phi_1867_ = (_e442 >= _e443);
            }
            let _e446 = phi_1867_;
            phi_1874_ = _e446;
            if !(_e446) {
                let _e449 = c[1u];
                phi_1874_ = (_e449 < 0i);
            }
            let _e452 = phi_1874_;
            phi_1882_ = _e452;
            if !(_e452) {
                let _e455 = c[1u];
                let _e456 = sub_1;
                phi_1882_ = (_e455 >= _e456);
            }
            let _e459 = phi_1882_;
            phi_1889_ = _e459;
            if !(_e459) {
                let _e462 = c[2u];
                phi_1889_ = (_e462 < 0i);
            }
            let _e465 = phi_1889_;
            phi_1897_ = _e465;
            if !(_e465) {
                let _e468 = c[2u];
                let _e469 = sub_1;
                phi_1897_ = (_e468 >= _e469);
            }
            let _e472 = phi_1897_;
            if _e472 {
                return false;
            }
            let _e473 = (*kind_1);
            param_65 = _e473;
            let _e474 = (*type_40);
            param_66 = _e474;
            let _e475 = (*voxelPos_15);
            param_67 = _e475;
            let _e476 = c;
            param_68 = _e476;
            let _e477 = sub_1;
            param_69 = _e477;
            let _e478 = jitter_1;
            param_70 = _e478;
            let _e479 = subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b((&param_65), (&param_66), (&param_67), (&param_68), (&param_69), (&param_70));
            if _e479 {
                let _e480 = t_2;
                (*tHit_1) = _e480;
                let _e481 = c;
                (*subCell_2) = vec3<f32>(_e481);
                return true;
            }
            let _e484 = tMax_3[0u];
            let _e486 = tMax_3[1u];
            if (_e484 < _e486) {
                let _e489 = tMax_3[0u];
                let _e491 = tMax_3[2u];
                if (_e489 < _e491) {
                    let _e494 = stepDir_2[0u];
                    let _e496 = c[0u];
                    c[0u] = (_e496 + _e494);
                    let _e500 = tMax_3[0u];
                    t_2 = _e500;
                    let _e502 = tDelta_2[0u];
                    let _e504 = tMax_3[0u];
                    tMax_3[0u] = (_e504 + _e502);
                    let _e508 = stepDir_2[0u];
                    (*subNormal) = vec3<f32>(f32(-(_e508)), 0f, 0f);
                } else {
                    let _e513 = stepDir_2[2u];
                    let _e515 = c[2u];
                    c[2u] = (_e515 + _e513);
                    let _e519 = tMax_3[2u];
                    t_2 = _e519;
                    let _e521 = tDelta_2[2u];
                    let _e523 = tMax_3[2u];
                    tMax_3[2u] = (_e523 + _e521);
                    let _e527 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e527)));
                }
            } else {
                let _e532 = tMax_3[1u];
                let _e534 = tMax_3[2u];
                if (_e532 < _e534) {
                    let _e537 = stepDir_2[1u];
                    let _e539 = c[1u];
                    c[1u] = (_e539 + _e537);
                    let _e543 = tMax_3[1u];
                    t_2 = _e543;
                    let _e545 = tDelta_2[1u];
                    let _e547 = tMax_3[1u];
                    tMax_3[1u] = (_e547 + _e545);
                    let _e551 = stepDir_2[1u];
                    (*subNormal) = vec3<f32>(0f, f32(-(_e551)), 0f);
                } else {
                    let _e556 = stepDir_2[2u];
                    let _e558 = c[2u];
                    c[2u] = (_e558 + _e556);
                    let _e562 = tMax_3[2u];
                    t_2 = _e562;
                    let _e564 = tDelta_2[2u];
                    let _e566 = tMax_3[2u];
                    tMax_3[2u] = (_e566 + _e564);
                    let _e570 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e570)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e574 = i_5;
            i_5 = (_e574 + 1i);
        }
    }
    return false;
}

fn isLocustType_u0028_u1_u003b(type_41: ptr<function, u32>) -> bool {
    let _e259 = (*type_41);
    let _e261 = (*type_41);
    return ((_e259 >= 13u) && (_e261 <= 17u));
}

fn marchCeiling_u0028_() -> i32 {
    let _e259 = tuning.gridHeight;
    let _e262 = unnamed.maxOccupiedY;
    return min(bitcast<i32>(_e259), (bitcast<i32>(_e262) + 2i));
}

fn worldExtent_u0028_() -> vec3<f32> {
    let _e259 = tuning.gridWidth;
    let _e263 = tuning.gridHeight;
    let _e267 = tuning.gridDepth;
    return vec3<f32>(f32(bitcast<i32>(_e259)), f32(bitcast<i32>(_e263)), f32(bitcast<i32>(_e267)));
}

fn isEdge_u0028_vf3_u003b(p_5: ptr<function, vec3<f32>>) -> bool {
    var thickness_1: f32;
    var boundCount: i32;
    var extent: vec3<f32>;
    var phi_476_: bool;
    var phi_495_: bool;
    var phi_514_: bool;

    thickness_1 = 0.3f;
    boundCount = 0i;
    let _e262 = worldExtent_u0028_();
    extent = _e262;
    let _e264 = (*p_5)[0u];
    let _e265 = thickness_1;
    let _e266 = (_e264 < _e265);
    phi_476_ = _e266;
    if !(_e266) {
        let _e269 = (*p_5)[0u];
        let _e271 = extent[0u];
        let _e272 = thickness_1;
        phi_476_ = (_e269 > (_e271 - _e272));
    }
    let _e276 = phi_476_;
    if _e276 {
        let _e277 = boundCount;
        boundCount = (_e277 + 1i);
    }
    let _e280 = (*p_5)[1u];
    let _e281 = thickness_1;
    let _e282 = (_e280 < _e281);
    phi_495_ = _e282;
    if !(_e282) {
        let _e285 = (*p_5)[1u];
        let _e287 = extent[1u];
        let _e288 = thickness_1;
        phi_495_ = (_e285 > (_e287 - _e288));
    }
    let _e292 = phi_495_;
    if _e292 {
        let _e293 = boundCount;
        boundCount = (_e293 + 1i);
    }
    let _e296 = (*p_5)[2u];
    let _e297 = thickness_1;
    let _e298 = (_e296 < _e297);
    phi_514_ = _e298;
    if !(_e298) {
        let _e301 = (*p_5)[2u];
        let _e303 = extent[2u];
        let _e304 = thickness_1;
        phi_514_ = (_e301 > (_e303 - _e304));
    }
    let _e308 = phi_514_;
    if _e308 {
        let _e309 = boundCount;
        boundCount = (_e309 + 1i);
    }
    let _e311 = boundCount;
    return (_e311 >= 2i);
}

fn rot_u0028_f1_u003b(a_2: ptr<function, f32>) -> mat2x2<f32> {
    var s: f32;
    var c_1: f32;

    let _e261 = (*a_2);
    s = sin(_e261);
    let _e263 = (*a_2);
    c_1 = cos(_e263);
    let _e265 = c_1;
    let _e266 = s;
    let _e268 = s;
    let _e269 = c_1;
    return mat2x2<f32>(vec2<f32>(_e265, -(_e266)), vec2<f32>(_e268, _e269));
}

fn applyCameraRotation_u0028_vf3_u003b(v: ptr<function, vec3<f32>>) -> vec3<f32> {
    var param_71: f32;
    var param_72: f32;

    let _e262 = pc.pitch;
    param_71 = _e262;
    let _e263 = rot_u0028_f1_u003b((&param_71));
    let _e264 = (*v);
    let _e266 = (_e264.yz * _e263);
    (*v)[1u] = _e266.x;
    (*v)[2u] = _e266.y;
    let _e272 = pc.yaw;
    param_72 = _e272;
    let _e273 = rot_u0028_f1_u003b((&param_72));
    let _e274 = (*v);
    let _e276 = (_e274.xz * _e273);
    (*v)[0u] = _e276.x;
    (*v)[2u] = _e276.y;
    let _e281 = (*v);
    return _e281;
}

fn main_1() {
    var screenSpace: vec2<f32>;
    var baseOrigin: vec3<f32>;
    var forward: vec3<f32>;
    var param_73: vec3<f32>;
    var right: vec3<f32>;
    var param_74: vec3<f32>;
    var up: vec3<f32>;
    var param_75: vec3<f32>;
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
    var param_76: vec3<f32>;
    var param_77: vec3<f32>;
    var param_78: vec3<f32>;
    var param_79: vec3<f32>;
    var hitFrontBox: bool;
    var hitBackBox: bool;
    var param_80: vec3<f32>;
    var param_81: vec3<f32>;
    var ceilingY_1: i32;
    var local_17: i32;
    var marchHit: vec2<f32>;
    var param_82: vec3<f32>;
    var param_83: vec3<f32>;
    var param_84: vec3<f32>;
    var param_85: vec3<f32>;
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
    var i_6: i32;
    var rawVoxel_5: u32;
    var param_86: vec3<i32>;
    var c_2: u32;
    var age_1: u32;
    var targetAlpha: f32;
    var dither: f32;
    var param_87: u32;
    var kind_2: u32;
    var param_88: vec3<i32>;
    var param_89: vec3<f32>;
    var param_90: vec3<f32>;
    var param_91: u32;
    var param_92: u32;
    var param_93: vec3<f32>;
    var param_94: f32;
    var param_95: vec3<f32>;
    var param_96: vec3<f32>;
    var ddaNormal_1: vec3<f32>;
    var param_97: vec3<i32>;
    var param_98: vec3<f32>;
    var param_99: vec3<i32>;
    var param_100: u32;
    var param_101: vec3<i32>;
    var sunDir_2: vec3<f32>;
    var sunColor_1: vec3<f32>;
    var ambientColor: vec3<f32>;
    var diffuse_1: f32;
    var shadow_1: f32;
    var param_102: vec3<i32>;
    var param_103: vec3<f32>;
    var param_104: vec3<f32>;
    var param_105: i32;
    var baseLighting_9: vec3<f32>;
    var finalVoxelColor: vec3<f32>;
    var calm: vec3<f32>;
    var rain: vec3<f32>;
    var param_106: u32;
    var param_107: vec3<f32>;
    var param_108: vec3<i32>;
    var param_109: vec3<f32>;
    var param_110: vec3<f32>;
    var param_111: vec3<f32>;
    var param_112: vec3<f32>;
    var param_113: f32;
    var param_114: vec3<f32>;
    var param_115: vec3<i32>;
    var param_116: vec3<f32>;
    var param_117: u32;
    var param_118: vec3<i32>;
    var param_119: vec3<f32>;
    var param_120: vec3<f32>;
    var param_121: u32;
    var param_122: vec3<i32>;
    var param_123: vec3<i32>;
    var param_124: vec3<f32>;
    var param_125: u32;
    var param_126: vec3<i32>;
    var param_127: vec3<i32>;
    var param_128: vec3<f32>;
    var param_129: vec3<i32>;
    var param_130: vec3<f32>;
    var param_131: vec3<f32>;
    var param_132: vec3<i32>;
    var param_133: vec3<f32>;
    var param_134: vec3<f32>;
    var param_135: u32;
    var param_136: vec3<i32>;
    var param_137: vec3<f32>;
    var param_138: vec3<f32>;
    var param_139: vec3<i32>;
    var distanceTraveled: f32;
    var param_140: u32;
    var local_24: f32;
    var seenHoles: u32;
    var i_7: i32;
    var code_2: u32;
    var bodyLevel: u32;
    var local_25: u32;
    var param_141: u32;
    var bodyRadius: f32;
    var param_142: u32;
    var center: vec3<f32>;
    var param_143: u32;
    var oc: vec3<f32>;
    var b_3: f32;
    var c_3: f32;
    var disc: f32;
    var sq: f32;
    var tNear_1: f32;
    var tFar_1: f32;
    var bodyDist: f32;
    var surfaceNormal: vec3<f32>;
    var bodyColor: vec3<f32>;
    var param_144: vec3<f32>;
    var param_145: vec3<f32>;
    var charge: f32;
    var cloudGreyness: f32;
    var crossedTime: f32;
    var cloudCeiling: f32;
    var cloudClip: vec2<f32>;
    var param_146: vec3<f32>;
    var param_147: vec3<f32>;
    var param_148: vec3<f32>;
    var param_149: vec3<f32>;
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
    var param_150: vec3<f32>;
    var param_151: vec3<f32>;
    var param_152: f32;
    var param_153: f32;
    var param_154: vec3<f32>;
    var param_155: f32;
    var param_156: f32;
    var param_157: vec3<f32>;
    var param_158: f32;
    var halfDistMin: i32;
    var halfDistMax: i32;
    var boxMin_2: vec3<f32>;
    var boxMax_1: vec3<f32>;
    var cursorColor: vec3<f32>;
    var indexable_6: array<vec3<f32>, 20>;
    var sphereCenter: vec3<f32>;
    var sphereRadius: f32;
    var oc_1: vec3<f32>;
    var b_4: f32;
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
    var param_159: vec3<f32>;
    var param_160: vec3<f32>;
    var param_161: vec3<f32>;
    var param_162: vec3<f32>;
    var distFront: f32;
    var distBack: f32;
    var hitPosFront: vec3<f32>;
    var hitPosBack: vec3<f32>;
    var e: f32;
    var onFrontEdge: bool;
    var edgesFront: i32;
    var onBackEdge: bool;
    var edgesBack: i32;
    var phi_3075_: bool;
    var phi_3091_: bool;
    var phi_3319_: bool;
    var phi_3326_: bool;
    var phi_3334_: bool;
    var phi_3341_: bool;
    var phi_3351_: bool;
    var phi_3839_: bool;
    var phi_4127_: bool;
    var phi_4134_: bool;
    var phi_4143_: bool;
    var phi_4149_: bool;
    var phi_4158_: bool;
    var phi_4369_: bool;
    var phi_4411_: bool;
    var phi_4433_: bool;
    var phi_4455_: bool;
    var phi_4483_: bool;
    var phi_4505_: bool;
    var phi_4527_: bool;

    let _e469 = inUV_1;
    screenSpace = ((_e469 * 2f) - vec2(1f));
    let _e474 = screenSpace[1u];
    screenSpace[1u] = -(_e474);
    let _e478 = pc.aspectScaleX;
    let _e480 = screenSpace[0u];
    screenSpace[0u] = (_e480 * _e478);
    let _e484 = pc.aspectScaleY;
    let _e486 = screenSpace[1u];
    screenSpace[1u] = (_e486 * _e484);
    let _e490 = pc.camX;
    let _e492 = pc.camY;
    let _e494 = pc.camZ;
    baseOrigin = vec3<f32>(_e490, _e492, _e494);
    param_73 = vec3<f32>(0f, 0f, 1f);
    let _e496 = applyCameraRotation_u0028_vf3_u003b((&param_73));
    forward = _e496;
    param_74 = vec3<f32>(1f, 0f, 0f);
    let _e497 = applyCameraRotation_u0028_vf3_u003b((&param_74));
    right = _e497;
    param_75 = vec3<f32>(0f, 1f, 0f);
    let _e498 = applyCameraRotation_u0028_vf3_u003b((&param_75));
    up = _e498;
    let _e500 = pc.perspectiveBlend;
    t_3 = clamp(_e500, 0f, 1f);
    let _e502 = worldExtent_u0028_();
    cubeCenter = (_e502 * 0.5f);
    let _e504 = cubeCenter;
    let _e505 = baseOrigin;
    let _e507 = forward;
    viewDistance = max(1f, dot((_e504 - _e505), _e507));
    let _e510 = viewDistance;
    let _e512 = pc.fovDistance;
    orthoHalfSize = (_e510 / _e512);
    let _e515 = screenSpace[0u];
    let _e517 = screenSpace[1u];
    let _e519 = pc.fovDistance;
    let _e521 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e515, _e517, _e519), vec3(_e521));
    let _e524 = right;
    let _e526 = localDir[0u];
    let _e528 = up;
    let _e530 = localDir[1u];
    let _e533 = forward;
    let _e535 = localDir[2u];
    rayDir_3 = normalize((((_e524 * _e526) + (_e528 * _e530)) + (_e533 * _e535)));
    let _e539 = right;
    let _e541 = screenSpace[0u];
    let _e543 = up;
    let _e545 = screenSpace[1u];
    let _e548 = orthoHalfSize;
    let _e550 = t_3;
    originOffset = ((((_e539 * _e541) + (_e543 * _e545)) * _e548) * (1f - _e550));
    let _e553 = baseOrigin;
    let _e554 = originOffset;
    rayOrigin_3 = (_e553 + _e554);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e556 = worldExtent_u0028_();
    let _e557 = rayOrigin_3;
    param_76 = _e557;
    let _e558 = rayDir_3;
    param_77 = _e558;
    param_78 = vec3<f32>(0f, 0f, 0f);
    param_79 = _e556;
    let _e559 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_76), (&param_77), (&param_78), (&param_79));
    aabbHit = _e559;
    hitFrontBox = false;
    hitBackBox = false;
    let _e561 = aabbHit[0u];
    let _e563 = aabbHit[1u];
    let _e564 = (_e561 < _e563);
    phi_3075_ = _e564;
    if _e564 {
        let _e566 = aabbHit[1u];
        phi_3075_ = (_e566 > 0f);
    }
    let _e569 = phi_3075_;
    if _e569 {
        let _e571 = aabbHit[0u];
        let _e572 = (_e571 > 0f);
        phi_3091_ = _e572;
        if _e572 {
            let _e573 = rayOrigin_3;
            let _e574 = rayDir_3;
            let _e576 = aabbHit[0u];
            param_80 = (_e573 + (_e574 * _e576));
            let _e579 = isEdge_u0028_vf3_u003b((&param_80));
            phi_3091_ = _e579;
        }
        let _e581 = phi_3091_;
        if _e581 {
            hitFrontBox = true;
        }
        let _e582 = rayOrigin_3;
        let _e583 = rayDir_3;
        let _e585 = aabbHit[1u];
        param_81 = (_e582 + (_e583 * _e585));
        let _e588 = isEdge_u0028_vf3_u003b((&param_81));
        if _e588 {
            hitBackBox = true;
        }
    }
    let _e590 = pc.showCloudBlocks;
    if (_e590 != 0i) {
        let _e593 = tuning.gridHeight;
        local_17 = bitcast<i32>(_e593);
    } else {
        let _e595 = marchCeiling_u0028_();
        local_17 = _e595;
    }
    let _e596 = local_17;
    ceilingY_1 = _e596;
    let _e598 = tuning.gridWidth;
    let _e601 = ceilingY_1;
    let _e604 = tuning.gridDepth;
    let _e608 = rayOrigin_3;
    param_82 = _e608;
    let _e609 = rayDir_3;
    param_83 = _e609;
    param_84 = vec3<f32>(0f, 0f, 0f);
    param_85 = vec3<f32>(f32(bitcast<i32>(_e598)), f32(_e601), f32(bitcast<i32>(_e604)));
    let _e610 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_82), (&param_83), (&param_84), (&param_85));
    marchHit = _e610;
    let _e611 = rayOrigin_3;
    let _e612 = rayDir_3;
    let _e614 = marchHit[0u];
    currentPos = (_e611 + (_e612 * max(0f, _e614)));
    let _e619 = marchHit[0u];
    if (_e619 > 0f) {
        let _e621 = rayDir_3;
        let _e623 = currentPos;
        currentPos = (_e623 + (_e621 * 0.001f));
    }
    let _e625 = currentPos;
    voxelPos_16 = vec3<i32>(floor(_e625));
    let _e628 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e628));
    let _e632 = rayDir_3[0u];
    if (_e632 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e635 = rayDir_3[0u];
        local_18 = abs((1f / _e635));
    }
    let _e638 = local_18;
    let _e640 = rayDir_3[1u];
    if (_e640 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e643 = rayDir_3[1u];
        local_19 = abs((1f / _e643));
    }
    let _e646 = local_19;
    let _e648 = rayDir_3[2u];
    if (_e648 == 0f) {
        local_20 = 100000000f;
    } else {
        let _e651 = rayDir_3[2u];
        local_20 = abs((1f / _e651));
    }
    let _e654 = local_20;
    tDelta_3 = vec3<f32>(_e638, _e646, _e654);
    let _e657 = stepDir_3[0u];
    if (_e657 > 0i) {
        let _e660 = currentPos[0u];
        let _e664 = currentPos[0u];
        let _e667 = tDelta_3[0u];
        local_21 = (((floor(_e660) + 1f) - _e664) * _e667);
    } else {
        let _e670 = currentPos[0u];
        let _e672 = currentPos[0u];
        let _e676 = tDelta_3[0u];
        local_21 = ((_e670 - floor(_e672)) * _e676);
    }
    let _e678 = local_21;
    let _e680 = stepDir_3[1u];
    if (_e680 > 0i) {
        let _e683 = currentPos[1u];
        let _e687 = currentPos[1u];
        let _e690 = tDelta_3[1u];
        local_22 = (((floor(_e683) + 1f) - _e687) * _e690);
    } else {
        let _e693 = currentPos[1u];
        let _e695 = currentPos[1u];
        let _e699 = tDelta_3[1u];
        local_22 = ((_e693 - floor(_e695)) * _e699);
    }
    let _e701 = local_22;
    let _e703 = stepDir_3[2u];
    if (_e703 > 0i) {
        let _e706 = currentPos[2u];
        let _e710 = currentPos[2u];
        let _e713 = tDelta_3[2u];
        local_23 = (((floor(_e706) + 1f) - _e710) * _e713);
    } else {
        let _e716 = currentPos[2u];
        let _e718 = currentPos[2u];
        let _e722 = tDelta_3[2u];
        local_23 = ((_e716 - floor(_e718)) * _e722);
    }
    let _e724 = local_23;
    tMax_4 = vec3<f32>(_e678, _e701, _e724);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e727 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e727 * 1.5f));
    i_6 = 0i;
    loop {
        let _e730 = i_6;
        let _e732 = tuning.marchMaxSteps;
        if (_e730 < bitcast<i32>(_e732)) {
            let _e736 = voxelPos_16[0u];
            let _e737 = (_e736 < 0i);
            phi_3319_ = _e737;
            if !(_e737) {
                let _e740 = voxelPos_16[0u];
                let _e742 = tuning.gridWidth;
                phi_3319_ = (_e740 >= bitcast<i32>(_e742));
            }
            let _e746 = phi_3319_;
            phi_3326_ = _e746;
            if !(_e746) {
                let _e749 = voxelPos_16[1u];
                phi_3326_ = (_e749 < 0i);
            }
            let _e752 = phi_3326_;
            phi_3334_ = _e752;
            if !(_e752) {
                let _e755 = voxelPos_16[1u];
                let _e756 = ceilingY_1;
                phi_3334_ = (_e755 >= _e756);
            }
            let _e759 = phi_3334_;
            phi_3341_ = _e759;
            if !(_e759) {
                let _e762 = voxelPos_16[2u];
                phi_3341_ = (_e762 < 0i);
            }
            let _e765 = phi_3341_;
            phi_3351_ = _e765;
            if !(_e765) {
                let _e768 = voxelPos_16[2u];
                let _e770 = tuning.gridDepth;
                phi_3351_ = (_e768 >= bitcast<i32>(_e770));
            }
            let _e774 = phi_3351_;
            if _e774 {
                break;
            }
            let _e775 = voxelPos_16;
            param_86 = _e775;
            let _e776 = getVoxel_u0028_vi3_u003b((&param_86));
            rawVoxel_5 = _e776;
            let _e777 = rawVoxel_5;
            hitType = (_e777 & 255u);
            let _e780 = pc.showCloudBlocks;
            let _e782 = hitType;
            if ((_e780 != 0i) && (_e782 == 0u)) {
                let _e786 = voxelPos_16[0u];
                let _e788 = voxelPos_16[1u];
                let _e790 = tuning.gridWidth;
                let _e795 = voxelPos_16[2u];
                let _e797 = tuning.gridWidth;
                let _e801 = tuning.gridHeight;
                let _e808 = unnamed_2.cloudCells[bitcast<u32>(((_e786 + (_e788 * bitcast<i32>(_e790))) + ((_e795 * bitcast<i32>(_e797)) * bitcast<i32>(_e801))))];
                c_2 = _e808;
                let _e809 = c_2;
                if ((_e809 & 3u) != 0u) {
                    hitType = 200u;
                    let _e812 = c_2;
                    hitRawVoxel = _e812;
                    hit = true;
                    break;
                }
            }
            let _e813 = hitType;
            if (_e813 == 7u) {
                hitType = 0u;
            }
            let _e815 = hitType;
            if (_e815 != 0u) {
                let _e817 = hitType;
                if (_e817 == 6u) {
                    let _e819 = rawVoxel_5;
                    age_1 = ((_e819 >> bitcast<u32>(24i)) & 255u);
                    let _e823 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e823) / 100f), 0f, 1f));
                    let _e828 = inUV_1;
                    let _e830 = pc.time;
                    dither = fract((sin(dot((_e828 + vec2((_e830 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e838 = dither;
                    let _e839 = targetAlpha;
                    if (_e838 > _e839) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e841 = rawVoxel_5;
                        hitRawVoxel = _e841;
                        break;
                    }
                } else {
                    let _e842 = hitType;
                    param_87 = _e842;
                    let _e843 = isLocustType_u0028_u1_u003b((&param_87));
                    let _e844 = hitType;
                    if (_e843 || (_e844 == 18u)) {
                        let _e847 = hitType;
                        kind_2 = select(0u, 1u, (_e847 == 18u));
                        let _e850 = voxelPos_16;
                        param_88 = _e850;
                        let _e851 = rayOrigin_3;
                        param_89 = _e851;
                        let _e852 = rayDir_3;
                        param_90 = _e852;
                        let _e853 = kind_2;
                        param_91 = _e853;
                        let _e854 = hitType;
                        param_92 = _e854;
                        let _e855 = normal_4;
                        param_93 = _e855;
                        let _e856 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_88), (&param_89), (&param_90), (&param_91), (&param_92), (&param_93), (&param_94), (&param_95), (&param_96));
                        let _e857 = param_94;
                        subT = _e857;
                        let _e858 = param_95;
                        subNormal_1 = _e858;
                        let _e859 = param_96;
                        subCell_3 = _e859;
                        if _e856 {
                            hit = true;
                            let _e860 = rawVoxel_5;
                            hitRawVoxel = _e860;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e861 = rawVoxel_5;
                        hitRawVoxel = _e861;
                        break;
                    }
                }
            }
            let _e863 = tMax_4[0u];
            let _e865 = tMax_4[1u];
            if (_e863 < _e865) {
                let _e868 = tMax_4[0u];
                let _e870 = tMax_4[2u];
                if (_e868 < _e870) {
                    let _e873 = stepDir_3[0u];
                    let _e875 = voxelPos_16[0u];
                    voxelPos_16[0u] = (_e875 + _e873);
                    let _e879 = tDelta_3[0u];
                    let _e881 = tMax_4[0u];
                    tMax_4[0u] = (_e881 + _e879);
                    let _e885 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e885)), 0f, 0f);
                } else {
                    let _e890 = stepDir_3[2u];
                    let _e892 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e892 + _e890);
                    let _e896 = tDelta_3[2u];
                    let _e898 = tMax_4[2u];
                    tMax_4[2u] = (_e898 + _e896);
                    let _e902 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e902)));
                }
            } else {
                let _e907 = tMax_4[1u];
                let _e909 = tMax_4[2u];
                if (_e907 < _e909) {
                    let _e912 = stepDir_3[1u];
                    let _e914 = voxelPos_16[1u];
                    voxelPos_16[1u] = (_e914 + _e912);
                    let _e918 = tDelta_3[1u];
                    let _e920 = tMax_4[1u];
                    tMax_4[1u] = (_e920 + _e918);
                    let _e924 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e924)), 0f);
                } else {
                    let _e929 = stepDir_3[2u];
                    let _e931 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e931 + _e929);
                    let _e935 = tDelta_3[2u];
                    let _e937 = tMax_4[2u];
                    tMax_4[2u] = (_e937 + _e935);
                    let _e941 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e941)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e945 = i_6;
            i_6 = (_e945 + 1i);
        }
    }
    let _e947 = hit;
    if _e947 {
        let _e948 = normal_4;
        if (length(_e948) < 0.1f) {
            let _e951 = rayDir_3;
            normal_4 = -(_e951);
        }
        let _e953 = normal_4;
        ddaNormal_1 = _e953;
        let _e954 = hitType;
        if (_e954 == 2u) {
            let _e956 = voxelPos_16;
            param_97 = _e956;
            let _e957 = getWaterNormal_u0028_vi3_u003b((&param_97));
            param_98 = _e957;
            let _e958 = voxelPos_16;
            param_99 = _e958;
            let _e959 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_98), (&param_99));
            normal_4 = _e959;
        } else {
            let _e960 = hitType;
            param_100 = _e960;
            let _e961 = isLocustType_u0028_u1_u003b((&param_100));
            let _e962 = hitType;
            if (_e961 || (_e962 == 18u)) {
                let _e965 = subNormal_1;
                normal_4 = _e965;
            } else {
                let _e966 = voxelPos_16;
                param_101 = _e966;
                let _e967 = getSmoothNormal_u0028_vi3_u003b((&param_101));
                normal_4 = _e967;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e968 = normal_4;
        let _e969 = sunDir_2;
        diffuse_1 = max(dot(_e968, _e969), 0f);
        let _e972 = voxelPos_16;
        param_102 = _e972;
        let _e973 = ddaNormal_1;
        param_103 = _e973;
        let _e974 = sunDir_2;
        param_104 = _e974;
        let _e975 = ceilingY_1;
        param_105 = _e975;
        let _e976 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_102), (&param_103), (&param_104), (&param_105));
        shadow_1 = _e976;
        let _e977 = ambientColor;
        let _e978 = sunColor_1;
        let _e979 = diffuse_1;
        let _e981 = shadow_1;
        baseLighting_9 = (_e977 + ((_e978 * _e979) * _e981));
        let _e984 = baseLighting_9;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e984);
        let _e986 = hitType;
        if (_e986 == 200u) {
            calm = vec3<f32>(0.35f, 0.65f, 1f);
            rain = vec3<f32>(1f, 0.55f, 0.25f);
            let _e988 = calm;
            let _e989 = rain;
            let _e990 = hitRawVoxel;
            let _e996 = baseLighting_9;
            finalVoxelColor = (mix(_e988, _e989, vec3(select(0f, 1f, ((_e990 & 3u) == 2u)))) * _e996);
        }
        let _e998 = hitType;
        switch bitcast<i32>(_e998) {
            case 1: {
                let _e1000 = hitRawVoxel;
                param_106 = _e1000;
                let _e1001 = baseLighting_9;
                param_107 = _e1001;
                let _e1002 = renderSand_u0028_u1_u003b_vf3_u003b((&param_106), (&param_107));
                finalVoxelColor = _e1002;
                break;
            }
            case 2: {
                let _e1003 = voxelPos_16;
                param_108 = _e1003;
                let _e1004 = normal_4;
                param_109 = _e1004;
                let _e1005 = rayOrigin_3;
                param_110 = _e1005;
                let _e1006 = sunDir_2;
                param_111 = _e1006;
                let _e1007 = sunColor_1;
                param_112 = _e1007;
                let _e1008 = shadow_1;
                param_113 = _e1008;
                let _e1009 = baseLighting_9;
                param_114 = _e1009;
                let _e1010 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_108), (&param_109), (&param_110), (&param_111), (&param_112), (&param_113), (&param_114));
                finalVoxelColor = _e1010;
                break;
            }
            case 3: {
                let _e1011 = voxelPos_16;
                param_115 = _e1011;
                let _e1012 = baseLighting_9;
                param_116 = _e1012;
                let _e1013 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_115), (&param_116));
                finalVoxelColor = _e1013;
                break;
            }
            case 4: {
                let _e1014 = hitRawVoxel;
                param_117 = _e1014;
                let _e1015 = voxelPos_16;
                param_118 = _e1015;
                let _e1016 = ddaNormal_1;
                param_119 = _e1016;
                let _e1017 = baseLighting_9;
                param_120 = _e1017;
                let _e1018 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_117), (&param_118), (&param_119), (&param_120));
                finalVoxelColor = _e1018;
                break;
            }
            case 5: {
                let _e1019 = hitRawVoxel;
                param_121 = _e1019;
                let _e1020 = voxelPos_16;
                param_122 = _e1020;
                let _e1021 = renderFire_u0028_u1_u003b_vi3_u003b((&param_121), (&param_122));
                finalVoxelColor = _e1021;
                break;
            }
            case 6: {
                let _e1022 = voxelPos_16;
                param_123 = _e1022;
                let _e1023 = baseLighting_9;
                param_124 = _e1023;
                let _e1024 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_123), (&param_124));
                finalVoxelColor = _e1024;
                break;
            }
            case 9, 10, 11, 8: {
                let _e1025 = hitRawVoxel;
                param_125 = _e1025;
                let _e1026 = voxelPos_16;
                param_126 = _e1026;
                let _e1027 = renderLava_u0028_u1_u003b_vi3_u003b((&param_125), (&param_126));
                finalVoxelColor = _e1027;
                break;
            }
            case 12: {
                let _e1028 = voxelPos_16;
                param_127 = _e1028;
                let _e1029 = baseLighting_9;
                param_128 = _e1029;
                let _e1030 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_127), (&param_128));
                finalVoxelColor = _e1030;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e1031 = voxelPos_16;
                param_129 = _e1031;
                let _e1032 = subCell_3;
                param_130 = _e1032;
                let _e1033 = baseLighting_9;
                param_131 = _e1033;
                let _e1034 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_129), (&param_130), (&param_131));
                finalVoxelColor = _e1034;
                break;
            }
            case 18: {
                let _e1035 = voxelPos_16;
                param_132 = _e1035;
                let _e1036 = subCell_3;
                param_133 = _e1036;
                let _e1037 = baseLighting_9;
                param_134 = _e1037;
                let _e1038 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_132), (&param_133), (&param_134));
                finalVoxelColor = _e1038;
                break;
            }
            case 19: {
                let _e1039 = hitRawVoxel;
                param_135 = _e1039;
                let _e1040 = voxelPos_16;
                param_136 = _e1040;
                let _e1041 = baseLighting_9;
                param_137 = _e1041;
                let _e1042 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_135), (&param_136), (&param_137));
                finalVoxelColor = _e1042;
                break;
            }
            default: {
                break;
            }
        }
        let _e1043 = finalVoxelColor;
        param_138 = _e1043;
        let _e1044 = voxelPos_16;
        param_139 = _e1044;
        let _e1045 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_138), (&param_139));
        finalVoxelColor = _e1045;
        let _e1046 = hitType;
        param_140 = _e1046;
        let _e1047 = isLocustType_u0028_u1_u003b((&param_140));
        let _e1048 = hitType;
        if (_e1047 || (_e1048 == 18u)) {
            let _e1051 = subT;
            local_24 = _e1051;
        } else {
            let _e1052 = voxelPos_16;
            let _e1055 = rayOrigin_3;
            local_24 = length(((vec3<f32>(_e1052) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e1055));
        }
        let _e1058 = local_24;
        distanceTraveled = _e1058;
        let _e1059 = distanceTraveled;
        let _e1060 = MAX_VISIBILITY;
        let _e1064 = finalVoxelColor;
        finalVoxelColor = (_e1064 * mix(1f, 0f, clamp((_e1059 / _e1060), 0f, 1f)));
        let _e1066 = distanceTraveled;
        finalDist = _e1066;
        let _e1067 = finalVoxelColor;
        finalColor = vec4<f32>(_e1067.x, _e1067.y, _e1067.z, 1f);
    } else {
        let _e1072 = hitBackBox;
        if _e1072 {
            let _e1074 = aabbHit[1u];
            finalDist = _e1074;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1076 = unnamed.blackHoleCount;
    if (_e1076 > 0u) {
        seenHoles = 0u;
        i_7 = 0i;
        loop {
            let _e1078 = i_7;
            let _e1079 = (_e1078 < 8i);
            phi_3839_ = _e1079;
            if _e1079 {
                let _e1080 = seenHoles;
                let _e1082 = unnamed.blackHoleCount;
                phi_3839_ = (_e1080 < _e1082);
            }
            let _e1085 = phi_3839_;
            if _e1085 {
                let _e1086 = i_7;
                let _e1089 = unnamed.blackHoles[_e1086];
                code_2 = _e1089;
                let _e1090 = code_2;
                if (_e1090 == 0u) {
                    continue;
                }
                let _e1092 = seenHoles;
                seenHoles = (_e1092 + bitcast<u32>(1i));
                let _e1095 = code_2;
                if ((_e1095 & 1073741824u) != 0u) {
                    let _e1099 = tuning.purgeLevel;
                    let _e1101 = i_7;
                    let _e1104 = unnamed.blackHoleMass[_e1101];
                    let _e1107 = tuning.purgeMass;
                    local_25 = u32((f32(_e1099) * clamp((f32(_e1104) / f32(max(_e1107, 1u))), 0f, 1f)));
                } else {
                    let _e1114 = i_7;
                    let _e1117 = unnamed.blackHoleMass[_e1114];
                    param_141 = _e1117;
                    let _e1118 = bhLevel_u0028_u1_u003b((&param_141));
                    local_25 = _e1118;
                }
                let _e1119 = local_25;
                bodyLevel = _e1119;
                let _e1120 = bodyLevel;
                param_142 = _e1120;
                let _e1121 = bhBodyRadius_u0028_u1_u003b((&param_142));
                bodyRadius = _e1121;
                let _e1122 = code_2;
                param_143 = _e1122;
                let _e1123 = bhDecode_u0028_u1_u003b((&param_143));
                center = (vec3<f32>(_e1123) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1126 = rayOrigin_3;
                let _e1127 = center;
                oc = (_e1126 - _e1127);
                let _e1129 = oc;
                let _e1130 = rayDir_3;
                b_3 = dot(_e1129, _e1130);
                let _e1132 = oc;
                let _e1133 = oc;
                let _e1135 = bodyRadius;
                let _e1136 = bodyRadius;
                c_3 = (dot(_e1132, _e1133) - (_e1135 * _e1136));
                let _e1139 = b_3;
                let _e1140 = b_3;
                let _e1142 = c_3;
                disc = ((_e1139 * _e1140) - _e1142);
                let _e1144 = disc;
                if (_e1144 <= 0f) {
                    continue;
                }
                let _e1146 = disc;
                sq = sqrt(_e1146);
                let _e1148 = b_3;
                let _e1150 = sq;
                tNear_1 = (-(_e1148) - _e1150);
                let _e1152 = b_3;
                let _e1154 = sq;
                tFar_1 = (-(_e1152) + _e1154);
                let _e1156 = tFar_1;
                if (_e1156 <= 0f) {
                    continue;
                }
                let _e1158 = tNear_1;
                bodyDist = max(0f, _e1158);
                let _e1160 = bodyDist;
                let _e1161 = finalDist;
                if (_e1160 < _e1161) {
                    let _e1163 = rayOrigin_3;
                    let _e1164 = rayDir_3;
                    let _e1165 = bodyDist;
                    let _e1168 = center;
                    surfaceNormal = normalize(((_e1163 + (_e1164 * _e1165)) - _e1168));
                    let _e1171 = surfaceNormal;
                    param_144 = _e1171;
                    let _e1172 = rayDir_3;
                    param_145 = _e1172;
                    let _e1173 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_144), (&param_145));
                    bodyColor = _e1173;
                    let _e1174 = bodyDist;
                    let _e1175 = MAX_VISIBILITY;
                    let _e1179 = bodyColor;
                    bodyColor = (_e1179 * mix(1f, 0f, clamp((_e1174 / _e1175), 0f, 1f)));
                    let _e1181 = bodyColor;
                    finalColor = vec4<f32>(_e1181.x, _e1181.y, _e1181.z, 1f);
                    let _e1186 = bodyDist;
                    finalDist = _e1186;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1187 = i_7;
                i_7 = (_e1187 + 1i);
            }
        }
    }
    let _e1190 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1190), 0f, 1f);
    let _e1193 = charge;
    cloudGreyness = _e1193;
    let _e1195 = unnamed.rainPhase;
    if (_e1195 == 1u) {
        let _e1198 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1198);
        let _e1200 = charge;
        let _e1202 = pc.time;
        let _e1203 = crossedTime;
        let _e1206 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1200, clamp(((_e1202 - _e1203) / _e1206), 0f, 1f));
    } else {
        let _e1211 = unnamed.rainPhase;
        if (_e1211 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1214 = tuning.cloudMaxAlpha;
    if (_e1214 > 0.002f) {
        let _e1217 = tuning.gridHeight;
        let _e1221 = tuning.cloudColumnFullCount;
        let _e1224 = tuning.cloudThicknessPerBlock;
        cloudCeiling = (f32(bitcast<i32>(_e1217)) + (max(_e1221, 1f) * max(_e1224, 0.01f)));
        let _e1228 = worldExtent_u0028_();
        let _e1230 = cloudCeiling;
        let _e1231 = worldExtent_u0028_();
        let _e1234 = rayOrigin_3;
        param_146 = _e1234;
        let _e1235 = rayDir_3;
        param_147 = _e1235;
        param_148 = vec3<f32>(0f, 0f, 0f);
        param_149 = vec3<f32>(_e1228.x, _e1230, _e1231.z);
        let _e1236 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_146), (&param_147), (&param_148), (&param_149));
        cloudClip = _e1236;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1238 = cloudClip[0u];
        nearT = max(_e1238, 0f);
        let _e1241 = cloudClip[1u];
        let _e1242 = finalDist;
        farT = min(_e1241, _e1242);
        let _e1244 = nearT;
        let _e1245 = farT;
        if (_e1244 < _e1245) {
            let _e1247 = rayOrigin_3;
            param_150 = _e1247;
            let _e1248 = rayDir_3;
            param_151 = _e1248;
            let _e1249 = nearT;
            param_152 = _e1249;
            let _e1250 = farT;
            param_153 = _e1250;
            let _e1251 = cloudSunDir;
            param_154 = _e1251;
            let _e1252 = cloudGreyness;
            param_155 = _e1252;
            let _e1253 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b((&param_150), (&param_151), (&param_152), (&param_153), (&param_154), (&param_155), (&param_156), (&param_157), (&param_158));
            let _e1254 = param_156;
            cloudTHit = _e1254;
            let _e1255 = param_157;
            cloudColor = _e1255;
            let _e1256 = param_158;
            cloudDensity = _e1256;
            if _e1253 {
                let _e1257 = cloudTHit;
                if (_e1257 > 0f) {
                    let _e1259 = cloudTHit;
                    bestT = _e1259;
                    let _e1260 = cloudColor;
                    bestColor = _e1260;
                    let _e1262 = tuning.cloudMinAlpha;
                    let _e1264 = tuning.cloudMaxAlpha;
                    let _e1265 = cloudDensity;
                    bestAlpha = clamp(mix(_e1262, _e1264, _e1265), 0f, 0.95f);
                    foundCloud = true;
                }
            }
        }
        let _e1268 = foundCloud;
        let _e1269 = bestT;
        let _e1270 = finalDist;
        if (_e1268 && (_e1269 < _e1270)) {
            let _e1273 = finalColor;
            let _e1275 = bestColor;
            let _e1276 = bestAlpha;
            let _e1278 = mix(_e1273.xyz, _e1275, vec3(_e1276));
            finalColor[0u] = _e1278.x;
            finalColor[1u] = _e1278.y;
            finalColor[2u] = _e1278.z;
        }
    }
    let _e1286 = pc.spawnX;
    let _e1287 = (_e1286 >= 0i);
    phi_4127_ = _e1287;
    if _e1287 {
        let _e1289 = pc.spawnX;
        let _e1291 = tuning.gridWidth;
        phi_4127_ = (_e1289 < bitcast<i32>(_e1291));
    }
    let _e1295 = phi_4127_;
    phi_4134_ = _e1295;
    if _e1295 {
        let _e1297 = pc.spawnY;
        phi_4134_ = (_e1297 >= 0i);
    }
    let _e1300 = phi_4134_;
    phi_4143_ = _e1300;
    if _e1300 {
        let _e1302 = pc.spawnY;
        let _e1304 = tuning.gridHeight;
        phi_4143_ = (_e1302 < bitcast<i32>(_e1304));
    }
    let _e1308 = phi_4143_;
    phi_4149_ = _e1308;
    if _e1308 {
        let _e1310 = pc.spawnZ;
        phi_4149_ = (_e1310 >= 0i);
    }
    let _e1313 = phi_4149_;
    phi_4158_ = _e1313;
    if _e1313 {
        let _e1315 = pc.spawnZ;
        let _e1317 = tuning.gridDepth;
        phi_4158_ = (_e1315 < bitcast<i32>(_e1317));
    }
    let _e1321 = phi_4158_;
    if _e1321 {
        let _e1323 = pc.spawnSize;
        halfDistMin = (_e1323 / 2i);
        let _e1326 = pc.spawnSize;
        halfDistMax = ((_e1326 - 1i) / 2i);
        let _e1330 = pc.spawnX;
        let _e1331 = halfDistMin;
        let _e1335 = pc.spawnY;
        let _e1336 = halfDistMin;
        let _e1340 = pc.spawnZ;
        let _e1341 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1330 - _e1331)), f32((_e1335 - _e1336)), f32((_e1340 - _e1341)));
        let _e1346 = pc.spawnX;
        let _e1347 = halfDistMax;
        let _e1352 = pc.spawnY;
        let _e1353 = halfDistMax;
        let _e1358 = pc.spawnZ;
        let _e1359 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1346 + _e1347) + 1i)), f32(((_e1352 + _e1353) + 1i)), f32(((_e1358 + _e1359) + 1i)));
        let _e1365 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1368 = indexable_6[clamp(_e1365, 0i, 19i)];
        cursorColor = _e1368;
        let _e1370 = pc.spawnShape;
        if (_e1370 == 1i) {
            let _e1372 = boxMin_2;
            let _e1373 = boxMax_1;
            sphereCenter = ((_e1372 + _e1373) * 0.5f);
            let _e1377 = pc.spawnSize;
            sphereRadius = (f32(_e1377) * 0.5f);
            let _e1380 = rayOrigin_3;
            let _e1381 = sphereCenter;
            oc_1 = (_e1380 - _e1381);
            let _e1383 = oc_1;
            let _e1384 = rayDir_3;
            b_4 = dot(_e1383, _e1384);
            let _e1386 = oc_1;
            let _e1387 = oc_1;
            let _e1389 = sphereRadius;
            let _e1390 = sphereRadius;
            c_4 = (dot(_e1386, _e1387) - (_e1389 * _e1390));
            let _e1393 = b_4;
            let _e1394 = b_4;
            let _e1396 = c_4;
            disc_1 = ((_e1393 * _e1394) - _e1396);
            let _e1398 = disc_1;
            if (_e1398 > 0f) {
                let _e1400 = disc_1;
                sq_1 = sqrt(_e1400);
                let _e1402 = b_4;
                let _e1404 = sq_1;
                tNear_2 = (-(_e1402) - _e1404);
                let _e1406 = b_4;
                let _e1408 = sq_1;
                tFar_2 = (-(_e1406) + _e1408);
                let _e1410 = tFar_2;
                if (_e1410 > 0f) {
                    let _e1412 = tNear_2;
                    inside = (_e1412 <= 0f);
                    let _e1414 = inside;
                    let _e1415 = tFar_2;
                    let _e1416 = tNear_2;
                    cursorDist = select(_e1416, _e1415, _e1414);
                    let _e1418 = rayOrigin_3;
                    let _e1419 = rayDir_3;
                    let _e1420 = cursorDist;
                    let _e1423 = sphereCenter;
                    shellNormal = normalize(((_e1418 + (_e1419 * _e1420)) - _e1423));
                    let _e1426 = shellNormal;
                    let _e1427 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1426, _e1427)));
                    let _e1431 = rim_1;
                    let _e1434 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1431)) * select(1f, 0.35f, _e1434));
                    let _e1437 = cursorDist;
                    let _e1438 = finalDist;
                    if (_e1437 < _e1438) {
                        let _e1440 = finalColor;
                        let _e1442 = cursorColor;
                        let _e1443 = alpha;
                        let _e1445 = mix(_e1440.xyz, _e1442, vec3(_e1443));
                        finalColor[0u] = _e1445.x;
                        finalColor[1u] = _e1445.y;
                        finalColor[2u] = _e1445.z;
                    }
                }
            }
        } else {
            let _e1452 = rayOrigin_3;
            param_159 = _e1452;
            let _e1453 = rayDir_3;
            param_160 = _e1453;
            let _e1454 = boxMin_2;
            param_161 = _e1454;
            let _e1455 = boxMax_1;
            param_162 = _e1455;
            let _e1456 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_159), (&param_160), (&param_161), (&param_162));
            cursorHit = _e1456;
            let _e1458 = cursorHit[0u];
            let _e1460 = cursorHit[1u];
            let _e1461 = (_e1458 < _e1460);
            phi_4369_ = _e1461;
            if _e1461 {
                let _e1463 = cursorHit[1u];
                phi_4369_ = (_e1463 > 0f);
            }
            let _e1466 = phi_4369_;
            if _e1466 {
                let _e1468 = cursorHit[0u];
                distFront = max(0f, _e1468);
                let _e1471 = cursorHit[1u];
                distBack = _e1471;
                let _e1472 = rayOrigin_3;
                let _e1473 = rayDir_3;
                let _e1474 = distFront;
                hitPosFront = (_e1472 + (_e1473 * _e1474));
                let _e1477 = rayOrigin_3;
                let _e1478 = rayDir_3;
                let _e1479 = distBack;
                hitPosBack = (_e1477 + (_e1478 * _e1479));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1483 = hitPosFront[0u];
                let _e1485 = boxMin_2[0u];
                let _e1486 = e;
                let _e1488 = (_e1483 < (_e1485 + _e1486));
                phi_4411_ = _e1488;
                if !(_e1488) {
                    let _e1491 = hitPosFront[0u];
                    let _e1493 = boxMax_1[0u];
                    let _e1494 = e;
                    phi_4411_ = (_e1491 > (_e1493 - _e1494));
                }
                let _e1498 = phi_4411_;
                if _e1498 {
                    let _e1499 = edgesFront;
                    edgesFront = (_e1499 + 1i);
                }
                let _e1502 = hitPosFront[1u];
                let _e1504 = boxMin_2[1u];
                let _e1505 = e;
                let _e1507 = (_e1502 < (_e1504 + _e1505));
                phi_4433_ = _e1507;
                if !(_e1507) {
                    let _e1510 = hitPosFront[1u];
                    let _e1512 = boxMax_1[1u];
                    let _e1513 = e;
                    phi_4433_ = (_e1510 > (_e1512 - _e1513));
                }
                let _e1517 = phi_4433_;
                if _e1517 {
                    let _e1518 = edgesFront;
                    edgesFront = (_e1518 + 1i);
                }
                let _e1521 = hitPosFront[2u];
                let _e1523 = boxMin_2[2u];
                let _e1524 = e;
                let _e1526 = (_e1521 < (_e1523 + _e1524));
                phi_4455_ = _e1526;
                if !(_e1526) {
                    let _e1529 = hitPosFront[2u];
                    let _e1531 = boxMax_1[2u];
                    let _e1532 = e;
                    phi_4455_ = (_e1529 > (_e1531 - _e1532));
                }
                let _e1536 = phi_4455_;
                if _e1536 {
                    let _e1537 = edgesFront;
                    edgesFront = (_e1537 + 1i);
                }
                let _e1539 = edgesFront;
                if (_e1539 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1542 = hitPosBack[0u];
                let _e1544 = boxMin_2[0u];
                let _e1545 = e;
                let _e1547 = (_e1542 < (_e1544 + _e1545));
                phi_4483_ = _e1547;
                if !(_e1547) {
                    let _e1550 = hitPosBack[0u];
                    let _e1552 = boxMax_1[0u];
                    let _e1553 = e;
                    phi_4483_ = (_e1550 > (_e1552 - _e1553));
                }
                let _e1557 = phi_4483_;
                if _e1557 {
                    let _e1558 = edgesBack;
                    edgesBack = (_e1558 + 1i);
                }
                let _e1561 = hitPosBack[1u];
                let _e1563 = boxMin_2[1u];
                let _e1564 = e;
                let _e1566 = (_e1561 < (_e1563 + _e1564));
                phi_4505_ = _e1566;
                if !(_e1566) {
                    let _e1569 = hitPosBack[1u];
                    let _e1571 = boxMax_1[1u];
                    let _e1572 = e;
                    phi_4505_ = (_e1569 > (_e1571 - _e1572));
                }
                let _e1576 = phi_4505_;
                if _e1576 {
                    let _e1577 = edgesBack;
                    edgesBack = (_e1577 + 1i);
                }
                let _e1580 = hitPosBack[2u];
                let _e1582 = boxMin_2[2u];
                let _e1583 = e;
                let _e1585 = (_e1580 < (_e1582 + _e1583));
                phi_4527_ = _e1585;
                if !(_e1585) {
                    let _e1588 = hitPosBack[2u];
                    let _e1590 = boxMax_1[2u];
                    let _e1591 = e;
                    phi_4527_ = (_e1588 > (_e1590 - _e1591));
                }
                let _e1595 = phi_4527_;
                if _e1595 {
                    let _e1596 = edgesBack;
                    edgesBack = (_e1596 + 1i);
                }
                let _e1598 = edgesBack;
                if (_e1598 >= 2i) {
                    onBackEdge = true;
                }
                let _e1600 = onFrontEdge;
                let _e1601 = distFront;
                let _e1602 = finalDist;
                if (_e1600 && (_e1601 < _e1602)) {
                    let _e1605 = finalColor;
                    let _e1607 = cursorColor;
                    let _e1609 = mix(_e1605.xyz, _e1607, vec3(0.9f));
                    finalColor[0u] = _e1609.x;
                    finalColor[1u] = _e1609.y;
                    finalColor[2u] = _e1609.z;
                } else {
                    let _e1616 = onBackEdge;
                    let _e1617 = distBack;
                    let _e1618 = finalDist;
                    if (_e1616 && (_e1617 < _e1618)) {
                        let _e1621 = finalColor;
                        let _e1623 = cursorColor;
                        let _e1625 = mix(_e1621.xyz, _e1623, vec3(0.2f));
                        finalColor[0u] = _e1625.x;
                        finalColor[1u] = _e1625.y;
                        finalColor[2u] = _e1625.z;
                    } else {
                        let _e1632 = distFront;
                        let _e1633 = finalDist;
                        if (_e1632 < _e1633) {
                            let _e1635 = finalColor;
                            let _e1637 = cursorColor;
                            let _e1639 = mix(_e1635.xyz, _e1637, vec3(0.15f));
                            finalColor[0u] = _e1639.x;
                            finalColor[1u] = _e1639.y;
                            finalColor[2u] = _e1639.z;
                        }
                    }
                }
            }
        }
    }
    let _e1646 = hitFrontBox;
    if _e1646 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1647 = finalColor;
    outColor = _e1647;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
