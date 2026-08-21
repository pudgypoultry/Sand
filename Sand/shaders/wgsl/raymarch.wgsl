// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 2c5e3ab0df799bbe329219f3b08179ceda622b91d79f57f9f9923e11322bd2fe

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
    cloudSmoothRate: f32,
    treeMinHeight: u32,
    fireAshChance: f32,
    ashDriftChance: f32,
    ashAbsorbTicks: u32,
    ashEnrichAmount: u32,
    ashSettleTicks: u32,
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
    cloudMinYAcc: u32,
    cloudMaxYAcc: u32,
    cloudMinY: u32,
    cloudMaxY: u32,
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
    let _e268 = (*p);
    return fract((sin(dot(_e268, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x: ptr<function, i32>, z: ptr<function, i32>) -> u32 {
    let _e269 = (*x);
    let _e270 = (*z);
    let _e272 = tuning.gridWidth;
    return (bitcast<u32>((_e269 + (_e270 * bitcast<i32>(_e272)))) * 4u);
}

fn sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b(x_1: ptr<function, i32>, z_1: ptr<function, i32>, count: ptr<function, f32>, topY: ptr<function, f32>) {
    var b: u32;
    var param: i32;
    var param_1: i32;
    var d: f32;
    var fx: f32;
    var fz: f32;
    var phi_2406_: bool;
    var phi_2418_: bool;

    let _e277 = (*x_1);
    let _e278 = (_e277 < 0i);
    phi_2406_ = _e278;
    if !(_e278) {
        let _e280 = (*x_1);
        let _e282 = tuning.gridWidth;
        phi_2406_ = (_e280 >= bitcast<i32>(_e282));
    }
    let _e286 = phi_2406_;
    let _e287 = (*z_1);
    let _e289 = (_e286 || (_e287 < 0i));
    phi_2418_ = _e289;
    if !(_e289) {
        let _e291 = (*z_1);
        let _e293 = tuning.gridDepth;
        phi_2418_ = (_e291 >= bitcast<i32>(_e293));
    }
    let _e297 = phi_2418_;
    if _e297 {
        (*count) = 0f;
        (*topY) = 0f;
        return;
    }
    let _e298 = (*x_1);
    param = _e298;
    let _e299 = (*z_1);
    param_1 = _e299;
    let _e300 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param), (&param_1));
    b = _e300;
    let _e301 = b;
    let _e305 = unnamed.cloudColumn[(_e301 + 2u)];
    (*count) = (f32(_e305) * 0.0625f);
    let _e308 = b;
    let _e312 = unnamed.cloudColumn[(_e308 + 3u)];
    (*topY) = (f32(_e312) * 0.0625f);
    let _e316 = tuning.cloudEdgeFadeDist;
    d = max(_e316, 0.001f);
    let _e318 = d;
    let _e319 = (*x_1);
    let _e322 = d;
    let _e324 = tuning.gridWidth;
    let _e327 = (*x_1);
    fx = (smoothstep(0f, _e318, f32(_e319)) * smoothstep(0f, _e322, f32(((bitcast<i32>(_e324) - 1i) - _e327))));
    let _e332 = d;
    let _e333 = (*z_1);
    let _e336 = d;
    let _e338 = tuning.gridDepth;
    let _e341 = (*z_1);
    fz = (smoothstep(0f, _e332, f32(_e333)) * smoothstep(0f, _e336, f32(((bitcast<i32>(_e338) - 1i) - _e341))));
    let _e346 = fx;
    let _e347 = fz;
    let _e349 = (*count);
    (*count) = (_e349 * (_e346 * _e347));
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

    let _e302 = (*x_2);
    param_2 = _e302;
    let _e303 = (*z_2);
    param_3 = _e303;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_2), (&param_3), (&param_4), (&param_5));
    let _e304 = param_4;
    c0_ = _e304;
    let _e305 = param_5;
    y0_ = _e305;
    let _e306 = (*x_2);
    let _e307 = (*spread);
    param_6 = (_e306 - _e307);
    let _e309 = (*z_2);
    param_7 = _e309;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_6), (&param_7), (&param_8), (&param_9));
    let _e310 = param_8;
    c1_ = _e310;
    let _e311 = param_9;
    y1_ = _e311;
    let _e312 = (*x_2);
    let _e313 = (*spread);
    param_10 = (_e312 + _e313);
    let _e315 = (*z_2);
    param_11 = _e315;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_10), (&param_11), (&param_12), (&param_13));
    let _e316 = param_12;
    c2_ = _e316;
    let _e317 = param_13;
    y2_ = _e317;
    let _e318 = (*z_2);
    let _e319 = (*spread);
    let _e321 = (*x_2);
    param_14 = _e321;
    param_15 = (_e318 - _e319);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_14), (&param_15), (&param_16), (&param_17));
    let _e322 = param_16;
    c3_ = _e322;
    let _e323 = param_17;
    y3_ = _e323;
    let _e324 = (*z_2);
    let _e325 = (*spread);
    let _e327 = (*x_2);
    param_18 = _e327;
    param_19 = (_e324 + _e325);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_18), (&param_19), (&param_20), (&param_21));
    let _e328 = param_20;
    c4_ = _e328;
    let _e329 = param_21;
    y4_ = _e329;
    let _e330 = c0_;
    let _e332 = c1_;
    let _e334 = c2_;
    let _e336 = c3_;
    let _e338 = c4_;
    (*count_1) = ((((((_e330 * 2f) + _e332) + _e334) + _e336) + _e338) / 6f);
    let _e341 = y0_;
    let _e342 = y1_;
    let _e344 = y2_;
    let _e345 = y3_;
    let _e348 = y4_;
    (*topY_1) = max(max(max(_e341, _e342), max(_e344, _e345)), _e348);
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
    var cell: f32;
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
    var phi_2760_: bool;
    var phi_2771_: bool;
    var phi_2828_: bool;

    let _e316 = (*tEnter);
    (*tEnter) = max(_e316, 0f);
    let _e318 = (*tEnter);
    let _e319 = (*tExit);
    if (_e318 >= _e319) {
        return false;
    }
    let _e321 = (*rayOrigin);
    let _e322 = (*rayDir);
    let _e323 = (*tEnter);
    startPos = (_e321 + (_e322 * _e323));
    let _e326 = startPos;
    let _e328 = tuning.cloudVoxelSize;
    cellPos = vec3<i32>(floor((_e326 / vec3(_e328))));
    let _e333 = (*rayDir);
    stepDir = vec3<i32>(sign(_e333));
    let _e337 = (*rayDir)[0u];
    if (_e337 == 0f) {
        local = 100000000f;
    } else {
        let _e340 = tuning.cloudVoxelSize;
        let _e342 = (*rayDir)[0u];
        local = abs((_e340 / _e342));
    }
    let _e345 = local;
    let _e347 = (*rayDir)[1u];
    if (_e347 == 0f) {
        local_1 = 100000000f;
    } else {
        let _e350 = tuning.cloudVoxelSize;
        let _e352 = (*rayDir)[1u];
        local_1 = abs((_e350 / _e352));
    }
    let _e355 = local_1;
    let _e357 = (*rayDir)[2u];
    if (_e357 == 0f) {
        local_2 = 100000000f;
    } else {
        let _e360 = tuning.cloudVoxelSize;
        let _e362 = (*rayDir)[2u];
        local_2 = abs((_e360 / _e362));
    }
    let _e365 = local_2;
    tDelta = vec3<f32>(_e345, _e355, _e365);
    let _e367 = startPos;
    let _e369 = tuning.cloudVoxelSize;
    let _e372 = cellPos;
    fracPos = ((_e367 / vec3(_e369)) - vec3<f32>(_e372));
    let _e375 = (*tEnter);
    let _e377 = stepDir[0u];
    if (_e377 > 0i) {
        let _e380 = fracPos[0u];
        let _e383 = tDelta[0u];
        local_3 = ((1f - _e380) * _e383);
    } else {
        let _e386 = fracPos[0u];
        let _e388 = tDelta[0u];
        local_3 = (_e386 * _e388);
    }
    let _e390 = local_3;
    let _e392 = stepDir[1u];
    if (_e392 > 0i) {
        let _e395 = fracPos[1u];
        let _e398 = tDelta[1u];
        local_4 = ((1f - _e395) * _e398);
    } else {
        let _e401 = fracPos[1u];
        let _e403 = tDelta[1u];
        local_4 = (_e401 * _e403);
    }
    let _e405 = local_4;
    let _e407 = stepDir[2u];
    if (_e407 > 0i) {
        let _e410 = fracPos[2u];
        let _e413 = tDelta[2u];
        local_5 = ((1f - _e410) * _e413);
    } else {
        let _e416 = fracPos[2u];
        let _e418 = tDelta[2u];
        local_5 = (_e416 * _e418);
    }
    let _e420 = local_5;
    tMax = (vec3(_e375) + vec3<f32>(_e390, _e405, _e420));
    normal = vec3<f32>(0f, 1f, 0f);
    let _e424 = (*tEnter);
    t = _e424;
    let _e426 = tuning.cloudVoxelSize;
    spread_1 = max(1i, i32(_e426));
    i = 0i;
    loop {
        let _e429 = i;
        let _e431 = tuning.maxCloudSteps;
        if (_e429 < bitcast<i32>(_e431)) {
            let _e434 = t;
            let _e435 = (*tExit);
            if (_e434 > _e435) {
                break;
            }
            let _e437 = cellPos;
            let _e442 = tuning.cloudVoxelSize;
            cellCenter = ((vec3<f32>(_e437) + vec3(0.5f)) * _e442);
            let _e445 = cellCenter[0u];
            cx = i32(floor(_e445));
            let _e449 = cellCenter[2u];
            cz = i32(floor(_e449));
            let _e452 = cx;
            let _e453 = (_e452 >= 0i);
            phi_2760_ = _e453;
            if _e453 {
                let _e454 = cx;
                let _e456 = tuning.gridWidth;
                phi_2760_ = (_e454 < bitcast<i32>(_e456));
            }
            let _e460 = phi_2760_;
            let _e461 = cz;
            let _e463 = (_e460 && (_e461 >= 0i));
            phi_2771_ = _e463;
            if _e463 {
                let _e464 = cz;
                let _e466 = tuning.gridDepth;
                phi_2771_ = (_e464 < bitcast<i32>(_e466));
            }
            let _e470 = phi_2771_;
            if _e470 {
                let _e471 = cx;
                param_22 = _e471;
                let _e472 = cz;
                param_23 = _e472;
                let _e473 = spread_1;
                param_24 = _e473;
                smoothedCloudColumn_u0028_i1_u003b_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_22), (&param_23), (&param_24), (&param_25), (&param_26));
                let _e474 = param_25;
                count_2 = _e474;
                let _e475 = param_26;
                baseY = _e475;
                let _e476 = count_2;
                if (_e476 > 0f) {
                    let _e479 = tuning.cloudVoxelSize;
                    cell = max(_e479, 0.5f);
                    let _e481 = count_2;
                    let _e483 = tuning.cloudThicknessPerBlock;
                    thickness = (_e481 * max(_e483, 0.01f));
                    let _e486 = baseY;
                    let _e487 = cell;
                    let _e490 = cell;
                    baseY = (floor((_e486 / _e487)) * _e490);
                    let _e492 = baseY;
                    let _e493 = thickness;
                    let _e494 = cell;
                    let _e498 = cell;
                    capY = (_e492 + (max(floor((_e493 / _e494)), 1f) * _e498));
                    let _e502 = cellCenter[1u];
                    let _e503 = baseY;
                    let _e504 = (_e502 >= _e503);
                    phi_2828_ = _e504;
                    if _e504 {
                        let _e506 = cellCenter[1u];
                        let _e507 = capY;
                        phi_2828_ = (_e506 <= _e507);
                    }
                    let _e510 = phi_2828_;
                    if _e510 {
                        let _e511 = count_2;
                        let _e513 = tuning.cloudColumnFullCount;
                        density = clamp((_e511 / max(_e513, 1f)), 0f, 1f);
                        let _e517 = baseY;
                        let _e518 = capY;
                        mid = ((_e517 + _e518) * 0.5f);
                        let _e522 = cellCenter[1u];
                        let _e523 = mid;
                        let _e526 = thickness;
                        edgeFactor = clamp((abs((_e522 - _e523)) / max((_e526 * 0.5f), 0.001f)), 0f, 1f);
                        let _e532 = tuning.cloudEdgeThresholdMin;
                        let _e534 = tuning.cloudEdgeThresholdMax;
                        let _e535 = edgeFactor;
                        threshold = mix(_e532, _e534, _e535);
                        let _e537 = cellPos;
                        param_27 = vec3<f32>(_e537);
                        let _e539 = hash_u0028_vf3_u003b((&param_27));
                        fillHash = _e539;
                        let _e540 = fillHash;
                        let _e541 = threshold;
                        if (_e540 > _e541) {
                            let _e543 = t;
                            (*tHit) = _e543;
                            let _e544 = density;
                            (*hitDensity) = _e544;
                            let _e545 = cellPos;
                            param_28 = ((vec3<f32>(_e545) * 3.71f) + vec3<f32>(91f, 5f, 7f));
                            let _e549 = hash_u0028_vf3_u003b((&param_28));
                            shadeHash = _e549;
                            let _e550 = shadeHash;
                            baseColor = mix(vec3<f32>(0.9f, 0.91f, 0.94f), vec3<f32>(1f, 1f, 1f), vec3(_e550));
                            stormColor = vec3<f32>(0.32f, 0.33f, 0.36f);
                            let _e553 = baseColor;
                            let _e554 = stormColor;
                            let _e555 = (*greyness);
                            baseColor = mix(_e553, _e554, vec3(_e555));
                            let _e558 = normal;
                            let _e559 = (*sunDir);
                            diffuse = (0.6f + (0.4f * max(dot(_e558, _e559), 0f)));
                            let _e564 = baseColor;
                            let _e565 = diffuse;
                            (*hitColor) = (_e564 * _e565);
                            return true;
                        }
                    }
                }
            }
            let _e568 = tMax[0u];
            let _e570 = tMax[1u];
            if (_e568 < _e570) {
                let _e573 = tMax[0u];
                let _e575 = tMax[2u];
                if (_e573 < _e575) {
                    let _e578 = stepDir[0u];
                    let _e580 = cellPos[0u];
                    cellPos[0u] = (_e580 + _e578);
                    let _e584 = tMax[0u];
                    t = _e584;
                    let _e586 = tDelta[0u];
                    let _e588 = tMax[0u];
                    tMax[0u] = (_e588 + _e586);
                    let _e592 = stepDir[0u];
                    normal = vec3<f32>(f32(-(_e592)), 0f, 0f);
                } else {
                    let _e597 = stepDir[2u];
                    let _e599 = cellPos[2u];
                    cellPos[2u] = (_e599 + _e597);
                    let _e603 = tMax[2u];
                    t = _e603;
                    let _e605 = tDelta[2u];
                    let _e607 = tMax[2u];
                    tMax[2u] = (_e607 + _e605);
                    let _e611 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e611)));
                }
            } else {
                let _e616 = tMax[1u];
                let _e618 = tMax[2u];
                if (_e616 < _e618) {
                    let _e621 = stepDir[1u];
                    let _e623 = cellPos[1u];
                    cellPos[1u] = (_e623 + _e621);
                    let _e627 = tMax[1u];
                    t = _e627;
                    let _e629 = tDelta[1u];
                    let _e631 = tMax[1u];
                    tMax[1u] = (_e631 + _e629);
                    let _e635 = stepDir[1u];
                    normal = vec3<f32>(0f, f32(-(_e635)), 0f);
                } else {
                    let _e640 = stepDir[2u];
                    let _e642 = cellPos[2u];
                    cellPos[2u] = (_e642 + _e640);
                    let _e646 = tMax[2u];
                    t = _e646;
                    let _e648 = tDelta[2u];
                    let _e650 = tMax[2u];
                    tMax[2u] = (_e650 + _e648);
                    let _e654 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e654)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e658 = i;
            i = (_e658 + 1i);
        }
    }
    return false;
}

fn renderBlackHole_u0028_vf3_u003b_vf3_u003b(normal_1: ptr<function, vec3<f32>>, rayDir_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var rim: f32;
    var glow: f32;

    let _e271 = (*normal_1);
    let _e272 = (*rayDir_1);
    rim = (1f - abs(dot(_e271, _e272)));
    let _e276 = rim;
    glow = pow(clamp(_e276, 0f, 1f), 4f);
    let _e279 = glow;
    return mix(vec3<f32>(0.01f, 0.01f, 0.02f), vec3<f32>(0.85f, 0.45f, 1f), vec3((_e279 * 0.7f)));
}

fn bhDecode_u0028_u1_u003b(code: ptr<function, u32>) -> vec3<i32> {
    var i_1: u32;

    let _e269 = (*code);
    i_1 = (_e269 & 1073741823u);
    let _e271 = i_1;
    let _e273 = tuning.gridWidth;
    let _e278 = i_1;
    let _e280 = tuning.gridWidth;
    let _e285 = tuning.gridHeight;
    let _e290 = i_1;
    let _e292 = tuning.gridWidth;
    let _e295 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e271 % bitcast<u32>(bitcast<i32>(_e273)))), bitcast<i32>(((_e278 / bitcast<u32>(bitcast<i32>(_e280))) % bitcast<u32>(bitcast<i32>(_e285)))), bitcast<i32>((_e290 / bitcast<u32>((bitcast<i32>(_e292) * bitcast<i32>(_e295))))));
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e268 = (*level);
    return (f32(_e268) + 0.5f);
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
        let _e273 = l;
        let _e275 = tuning.blackHoleMaxLevel;
        if (_e273 <= min(_e275, 16u)) {
            let _e278 = l;
            param_29 = _e278;
            let _e279 = bhBodyRadius_u0028_u1_u003b((&param_29));
            r = _e279;
            let _e280 = r;
            let _e282 = r;
            let _e284 = r;
            volume = (((4.18879f * _e280) * _e282) * _e284);
            let _e286 = (*mass);
            let _e289 = tuning.blackHoleGrowthCost;
            let _e290 = volume;
            if (f32(_e286) < (_e289 * _e290)) {
                break;
            }
            let _e293 = l;
            level_1 = _e293;
            continue;
        } else {
            break;
        }
        continuing {
            let _e294 = l;
            l = (_e294 + bitcast<u32>(1i));
        }
    }
    let _e297 = level_1;
    return _e297;
}

fn accretionGlow_u0028_vf3_u003b_vi3_u003b(color: ptr<function, vec3<f32>>, voxelPos: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radius: f32;
    var closestSq: f32;
    var seen: u32;
    var i_2: i32;
    var code_1: u32;
    var d_1: vec3<f32>;
    var param_30: u32;
    var closest: f32;
    var heat: f32;
    var hot: vec3<f32>;
    var phi_2291_: bool;
    var phi_2320_: bool;

    let _e280 = unnamed.blackHoleCount;
    let _e281 = (_e280 == 0u);
    phi_2291_ = _e281;
    if !(_e281) {
        let _e284 = tuning.blackHoleGlow;
        phi_2291_ = (_e284 <= 0f);
    }
    let _e287 = phi_2291_;
    if _e287 {
        let _e288 = (*color);
        return _e288;
    }
    let _e290 = tuning.blackHoleRadius;
    radius = f32(_e290);
    let _e292 = radius;
    let _e293 = radius;
    closestSq = (_e292 * _e293);
    seen = 0u;
    i_2 = 0i;
    loop {
        let _e295 = i_2;
        let _e296 = (_e295 < 8i);
        phi_2320_ = _e296;
        if _e296 {
            let _e297 = seen;
            let _e299 = unnamed.blackHoleCount;
            phi_2320_ = (_e297 < _e299);
        }
        let _e302 = phi_2320_;
        if _e302 {
            let _e303 = i_2;
            let _e306 = unnamed.blackHoles[_e303];
            code_1 = _e306;
            let _e307 = code_1;
            if (_e307 == 0u) {
                continue;
            }
            let _e309 = seen;
            seen = (_e309 + bitcast<u32>(1i));
            let _e312 = code_1;
            param_30 = _e312;
            let _e313 = bhDecode_u0028_u1_u003b((&param_30));
            let _e314 = (*voxelPos);
            d_1 = vec3<f32>((_e313 - _e314));
            let _e317 = closestSq;
            let _e318 = d_1;
            let _e319 = d_1;
            closestSq = min(_e317, dot(_e318, _e319));
            continue;
        } else {
            break;
        }
        continuing {
            let _e322 = i_2;
            i_2 = (_e322 + 1i);
        }
    }
    let _e324 = closestSq;
    let _e325 = radius;
    let _e326 = radius;
    if (_e324 >= (_e325 * _e326)) {
        let _e329 = (*color);
        return _e329;
    }
    let _e330 = closestSq;
    closest = sqrt(_e330);
    let _e332 = closest;
    let _e333 = radius;
    let _e338 = tuning.blackHoleGlow;
    heat = (pow((1f - (_e332 / _e333)), 3f) * _e338);
    let _e340 = heat;
    hot = mix(vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(1f, 0.95f, 0.85f), vec3(clamp(_e340, 0f, 1f)));
    let _e344 = (*color);
    let _e345 = hot;
    let _e346 = heat;
    return mix(_e344, _e345, vec3(clamp(_e346, 0f, 1f)));
}

fn renderAsh_u0028_vi3_u003b_vf3_u003b(voxelPos_1: ptr<function, vec3<i32>>, baseLighting: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n: f32;
    var param_31: vec3<f32>;
    var c: vec3<f32>;

    let _e272 = (*voxelPos_1);
    param_31 = vec3<f32>(_e272);
    let _e274 = hash_u0028_vf3_u003b((&param_31));
    n = _e274;
    let _e275 = n;
    c = mix(vec3<f32>(0.2f, 0.19f, 0.18f), vec3<f32>(0.47f, 0.45f, 0.42f), vec3(_e275));
    let _e278 = c;
    let _e279 = (*baseLighting);
    return (_e278 * _e279);
}

fn renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b(rawVoxel: ptr<function, u32>, voxelPos_2: ptr<function, vec3<i32>>, baseLighting_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_1: f32;
    var param_32: vec3<f32>;
    var dist: u32;
    var depth: f32;
    var inner: vec3<f32>;
    var outer: vec3<f32>;
    var leaf: vec3<f32>;

    let _e277 = (*voxelPos_2);
    param_32 = vec3<f32>(_e277);
    let _e279 = hash_u0028_vf3_u003b((&param_32));
    n_1 = _e279;
    let _e280 = (*rawVoxel);
    dist = ((_e280 >> bitcast<u32>(24i)) & 255u);
    let _e284 = dist;
    if (_e284 == 255u) {
        let _e286 = n_1;
        let _e289 = (*baseLighting_1);
        return (mix(vec3<f32>(0.34f, 0.22f, 0.07f), vec3<f32>(0.52f, 0.38f, 0.12f), vec3(_e286)) * _e289);
    }
    let _e291 = dist;
    let _e294 = tuning.treeLeafReach;
    depth = clamp((f32(_e291) / max(f32(_e294), 1f)), 0f, 1f);
    inner = vec3<f32>(0.1f, 0.3f, 0.09f);
    outer = vec3<f32>(0.28f, 0.52f, 0.16f);
    let _e299 = inner;
    let _e300 = outer;
    let _e301 = depth;
    let _e303 = n_1;
    leaf = mix(_e299, _e300, vec3(((_e301 * 0.7f) + (_e303 * 0.3f))));
    let _e308 = leaf;
    let _e309 = (*baseLighting_1);
    return (_e308 * _e309);
}

fn renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_3: ptr<function, vec3<i32>>, subCell: ptr<function, vec3<f32>>, baseLighting_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var grain: f32;
    var param_33: vec3<f32>;
    var bark: vec3<f32>;

    let _e274 = (*voxelPos_3)[0u];
    let _e277 = (*voxelPos_3)[1u];
    let _e281 = (*subCell)[1u];
    let _e285 = (*voxelPos_3)[2u];
    param_33 = vec3<f32>(f32(_e274), ((f32(_e277) * 0.35f) + (_e281 * 0.2f)), f32(_e285));
    let _e288 = hash_u0028_vf3_u003b((&param_33));
    grain = _e288;
    let _e289 = grain;
    bark = mix(vec3<f32>(0.2f, 0.13f, 0.07f), vec3<f32>(0.38f, 0.25f, 0.13f), vec3(_e289));
    let _e292 = bark;
    let _e293 = (*baseLighting_2);
    return (_e292 * _e293);
}

fn renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_4: ptr<function, vec3<i32>>, subCell_1: ptr<function, vec3<f32>>, baseLighting_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_2: f32;
    var param_34: vec3<f32>;
    var shell: vec3<f32>;

    let _e273 = (*subCell_1);
    let _e275 = (*voxelPos_4);
    param_34 = ((_e273 * 1.37f) + (vec3<f32>(_e275) * 0.11f));
    let _e279 = hash_u0028_vf3_u003b((&param_34));
    n_2 = _e279;
    let _e280 = n_2;
    shell = mix(vec3<f32>(0.15f, 0.1f, 0.035f), vec3<f32>(0.55f, 0.4f, 0.11f), vec3(_e280));
    let _e283 = shell;
    let _e284 = (*baseLighting_3);
    return (_e283 * _e284);
}

fn renderDarkStone_u0028_vi3_u003b_vf3_u003b(voxelPos_5: ptr<function, vec3<i32>>, baseLighting_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise: f32;
    var param_35: vec3<f32>;
    var val: f32;

    let _e272 = (*voxelPos_5);
    param_35 = vec3<f32>(_e272);
    let _e274 = hash_u0028_vf3_u003b((&param_35));
    noise = _e274;
    let _e275 = noise;
    val = (0.1f + (_e275 * 0.06f));
    let _e278 = val;
    let _e280 = val;
    let _e282 = val;
    let _e285 = (*baseLighting_4);
    return (vec3<f32>((_e278 * 1.08f), (_e280 * 0.94f), (_e282 * 0.92f)) * _e285);
}

fn lavaStageColor_u0028_i1_u003b(stage: ptr<function, i32>) -> vec3<f32> {
    var indexable: array<vec3<f32>, 6>;

    let _e269 = (*stage);
    indexable = array<vec3<f32>, 6>(vec3<f32>(1f, 0.62f, 0.22f), vec3<f32>(1f, 0.4f, 0.07f), vec3<f32>(0.96f, 0.29f, 0.05f), vec3<f32>(0.86f, 0.2f, 0.04f), vec3<f32>(0.7f, 0.13f, 0.03f), vec3<f32>(0.44f, 0.07f, 0.02f));
    let _e273 = indexable[clamp((_e269 + 1i), 0i, 5i)];
    return _e273;
}

fn renderLava_u0028_u1_u003b_vi3_u003b(rawVoxel_1: ptr<function, u32>, voxelPos_6: ptr<function, vec3<i32>>) -> vec3<f32> {
    var stage_1: i32;
    var phase: f32;
    var param_36: vec3<f32>;
    var from_: vec3<f32>;
    var param_37: i32;
    var to: vec3<f32>;
    var param_38: i32;
    var leg: f32;
    var param_39: i32;
    var param_40: i32;
    var param_41: i32;
    var param_42: i32;
    var molten: vec3<f32>;
    var param_43: vec3<f32>;

    let _e283 = (*rawVoxel_1);
    stage_1 = clamp((bitcast<i32>((_e283 & 255u)) - 8i), 0i, 3i);
    let _e289 = pc.time;
    let _e291 = tuning.lavaChurnRate;
    let _e293 = (*voxelPos_6);
    param_36 = vec3<f32>(_e293);
    let _e295 = hash_u0028_vf3_u003b((&param_36));
    phase = fract(((_e289 * _e291) + _e295));
    let _e298 = phase;
    if (_e298 < 0.33333334f) {
        let _e300 = stage_1;
        param_37 = (_e300 - 1i);
        let _e302 = lavaStageColor_u0028_i1_u003b((&param_37));
        from_ = _e302;
        let _e303 = stage_1;
        param_38 = _e303;
        let _e304 = lavaStageColor_u0028_i1_u003b((&param_38));
        to = _e304;
        let _e305 = phase;
        leg = (_e305 * 3f);
    } else {
        let _e307 = phase;
        if (_e307 < 0.6666667f) {
            let _e309 = stage_1;
            param_39 = _e309;
            let _e310 = lavaStageColor_u0028_i1_u003b((&param_39));
            from_ = _e310;
            let _e311 = stage_1;
            param_40 = (_e311 + 1i);
            let _e313 = lavaStageColor_u0028_i1_u003b((&param_40));
            to = _e313;
            let _e314 = phase;
            leg = ((_e314 * 3f) - 1f);
        } else {
            let _e317 = stage_1;
            param_41 = (_e317 + 1i);
            let _e319 = lavaStageColor_u0028_i1_u003b((&param_41));
            from_ = _e319;
            let _e320 = stage_1;
            param_42 = (_e320 - 1i);
            let _e322 = lavaStageColor_u0028_i1_u003b((&param_42));
            to = _e322;
            let _e323 = phase;
            leg = ((_e323 * 3f) - 2f);
        }
    }
    let _e326 = from_;
    let _e327 = to;
    let _e328 = leg;
    molten = mix(_e326, _e327, vec3(smoothstep(0f, 1f, _e328)));
    let _e332 = molten;
    let _e333 = (*voxelPos_6);
    param_43 = (vec3<f32>(_e333) * 1.7f);
    let _e336 = hash_u0028_vf3_u003b((&param_43));
    return (_e332 * (0.9f + (_e336 * 0.1f)));
}

fn renderSteam_u0028_vi3_u003b_vf3_u003b(voxelPos_7: ptr<function, vec3<i32>>, baseLighting_5: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_1: f32;
    var param_44: vec3<f32>;
    var val_1: f32;
    var baseColor_1: vec3<f32>;

    let _e273 = (*voxelPos_7);
    let _e276 = pc.time;
    param_44 = (vec3<f32>(_e273) + vec3(_e276));
    let _e279 = hash_u0028_vf3_u003b((&param_44));
    noise_1 = _e279;
    let _e280 = noise_1;
    val_1 = (0.85f + (_e280 * 0.15f));
    let _e283 = val_1;
    baseColor_1 = vec3(_e283);
    let _e285 = baseColor_1;
    let _e286 = (*baseLighting_5);
    return ((_e285 * _e286) * 0.9f);
}

fn renderFire_u0028_u1_u003b_vi3_u003b(rawVoxel_2: ptr<function, u32>, voxelPos_8: ptr<function, vec3<i32>>) -> vec3<f32> {
    var noise_2: f32;
    var param_45: vec3<f32>;
    var age: u32;
    var life: f32;
    var coreColor: vec3<f32>;
    var edgeColor: vec3<f32>;
    var fireColor: vec3<f32>;

    let _e276 = (*voxelPos_8);
    let _e279 = pc.time;
    param_45 = (vec3<f32>(_e276) + vec3((_e279 * 10f)));
    let _e283 = hash_u0028_vf3_u003b((&param_45));
    noise_2 = _e283;
    let _e284 = (*rawVoxel_2);
    age = ((_e284 >> bitcast<u32>(24i)) & 255u);
    let _e288 = age;
    life = clamp((f32(_e288) / 30f), 0f, 1f);
    coreColor = vec3<f32>(1f, 0.9f, 0.2f);
    edgeColor = vec3<f32>(1f, 0.3f, 0f);
    let _e292 = coreColor;
    let _e293 = edgeColor;
    let _e294 = life;
    let _e295 = noise_2;
    fireColor = mix(_e292, _e293, vec3((_e294 + (_e295 * 0.3f))));
    let _e300 = fireColor;
    return (_e300 * 1.5f);
}

fn renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b(rawVoxel_3: ptr<function, u32>, voxelPos_9: ptr<function, vec3<i32>>, ddaNormal: ptr<function, vec3<f32>>, baseLighting_6: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_3: f32;
    var param_46: vec3<f32>;
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
    var phi_1273_: bool;

    let _e283 = (*voxelPos_9);
    param_46 = vec3<f32>(_e283);
    let _e285 = hash_u0028_vf3_u003b((&param_46));
    noise_3 = _e285;
    let _e286 = noise_3;
    val_2 = (0.8f + (_e286 * 0.2f));
    let _e289 = (*rawVoxel_3);
    moisture = ((_e289 >> bitcast<u32>(24i)) & 255u);
    let _e293 = moisture;
    wetness = clamp((f32(_e293) / 30f), 0f, 1f);
    let _e297 = val_2;
    let _e299 = val_2;
    let _e301 = val_2;
    dryColor = vec3<f32>((0.4f * _e297), (0.25f * _e299), (0.1f * _e301));
    let _e304 = val_2;
    let _e306 = val_2;
    let _e308 = val_2;
    wetColor = vec3<f32>((0.15f * _e304), (0.08f * _e306), (0.03f * _e308));
    let _e311 = dryColor;
    let _e312 = wetColor;
    let _e313 = wetness;
    baseColor_2 = mix(_e311, _e312, vec3(_e313));
    let _e316 = (*rawVoxel_3);
    floraState = ((_e316 >> bitcast<u32>(8i)) & 255u);
    let _e320 = floraState;
    let _e321 = (_e320 > 10u);
    phi_1273_ = _e321;
    if _e321 {
        let _e323 = (*ddaNormal)[1u];
        phi_1273_ = (_e323 > 0.5f);
    }
    let _e326 = phi_1273_;
    if _e326 {
        let _e327 = floraState;
        grassGrow = clamp((f32((_e327 - 10u)) / 90f), 0f, 1f);
        let _e332 = noise_3;
        let _e335 = noise_3;
        grassColor = vec3<f32>((0.15f + (_e332 * 0.1f)), (0.45f + (_e335 * 0.15f)), 0.15f);
        let _e339 = floraState;
        if (_e339 > 100u) {
            let _e341 = floraState;
            drown = clamp((f32((_e341 - 100u)) / 100f), 0f, 1f);
            let _e346 = grassColor;
            let _e347 = drown;
            grassColor = mix(_e346, vec3<f32>(0.35f, 0.35f, 0.15f), vec3(_e347));
        }
        let _e350 = baseColor_2;
        let _e351 = grassColor;
        let _e352 = grassGrow;
        baseColor_2 = mix(_e350, _e351, vec3(_e352));
    }
    let _e355 = baseColor_2;
    let _e356 = (*baseLighting_6);
    return (_e355 * _e356);
}

fn renderStone_u0028_vi3_u003b_vf3_u003b(voxelPos_10: ptr<function, vec3<i32>>, baseLighting_7: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_4: f32;
    var param_47: vec3<f32>;
    var val_3: f32;
    var baseColor_3: vec3<f32>;

    let _e273 = (*voxelPos_10);
    param_47 = vec3<f32>(_e273);
    let _e275 = hash_u0028_vf3_u003b((&param_47));
    noise_4 = _e275;
    let _e276 = noise_4;
    val_3 = (0.4f + (_e276 * 0.3f));
    let _e279 = val_3;
    baseColor_3 = vec3(_e279);
    let _e281 = baseColor_3;
    let _e282 = (*baseLighting_7);
    return (_e281 * _e282);
}

fn renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b(voxelPos_11: ptr<function, vec3<i32>>, normal_2: ptr<function, vec3<f32>>, rayOrigin_1: ptr<function, vec3<f32>>, sunDir_1: ptr<function, vec3<f32>>, sunColor: ptr<function, vec3<f32>>, shadow: ptr<function, f32>, baseLighting_8: ptr<function, vec3<f32>>) -> vec3<f32> {
    var baseColor_4: vec3<f32>;
    var viewDir: vec3<f32>;
    var reflectDir: vec3<f32>;
    var spec: f32;
    var finalLighting: vec3<f32>;

    baseColor_4 = vec3<f32>(0.1f, 0.4f, 0.9f);
    let _e279 = (*rayOrigin_1);
    let _e280 = (*voxelPos_11);
    viewDir = normalize((_e279 - vec3<f32>(_e280)));
    let _e284 = (*sunDir_1);
    let _e286 = (*normal_2);
    reflectDir = reflect(-(_e284), _e286);
    let _e288 = viewDir;
    let _e289 = reflectDir;
    spec = pow(max(dot(_e288, _e289), 0f), 32f);
    let _e293 = (*baseLighting_8);
    let _e294 = (*sunColor);
    let _e295 = spec;
    let _e298 = (*shadow);
    finalLighting = (_e293 + (((_e294 * _e295) * 0.5f) * _e298));
    let _e301 = baseColor_4;
    let _e302 = finalLighting;
    return (_e301 * _e302);
}

fn renderSand_u0028_u1_u003b_vf3_u003b(rawVoxel_4: ptr<function, u32>, baseLighting_9: ptr<function, vec3<f32>>) -> vec3<f32> {
    var moisture_1: u32;
    var wetness_1: f32;
    var dryColor_1: vec3<f32>;
    var wetColor_1: vec3<f32>;
    var baseColor_5: vec3<f32>;

    let _e274 = (*rawVoxel_4);
    moisture_1 = ((_e274 >> bitcast<u32>(24i)) & 255u);
    let _e278 = moisture_1;
    wetness_1 = clamp((f32(_e278) / 10f), 0f, 1f);
    dryColor_1 = vec3<f32>(0.9f, 0.8f, 0.2f);
    wetColor_1 = vec3<f32>(0.65f, 0.55f, 0.15f);
    let _e282 = dryColor_1;
    let _e283 = wetColor_1;
    let _e284 = wetness_1;
    baseColor_5 = mix(_e282, _e283, vec3(_e284));
    let _e287 = baseColor_5;
    let _e288 = (*baseLighting_9);
    return (_e287 * _e288);
}

fn getVoxel_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    var index: u32;
    var phi_288_: bool;
    var phi_296_: bool;
    var phi_306_: bool;
    var phi_314_: bool;
    var phi_324_: bool;

    let _e270 = (*pos)[0u];
    let _e271 = (_e270 < 0i);
    phi_288_ = _e271;
    if !(_e271) {
        let _e274 = (*pos)[0u];
        let _e276 = tuning.gridWidth;
        phi_288_ = (_e274 >= bitcast<i32>(_e276));
    }
    let _e280 = phi_288_;
    phi_296_ = _e280;
    if !(_e280) {
        let _e283 = (*pos)[1u];
        phi_296_ = (_e283 < 0i);
    }
    let _e286 = phi_296_;
    phi_306_ = _e286;
    if !(_e286) {
        let _e289 = (*pos)[1u];
        let _e291 = tuning.gridHeight;
        phi_306_ = (_e289 >= bitcast<i32>(_e291));
    }
    let _e295 = phi_306_;
    phi_314_ = _e295;
    if !(_e295) {
        let _e298 = (*pos)[2u];
        phi_314_ = (_e298 < 0i);
    }
    let _e301 = phi_314_;
    phi_324_ = _e301;
    if !(_e301) {
        let _e304 = (*pos)[2u];
        let _e306 = tuning.gridDepth;
        phi_324_ = (_e304 >= bitcast<i32>(_e306));
    }
    let _e310 = phi_324_;
    if _e310 {
        return 0u;
    }
    let _e312 = (*pos)[0u];
    let _e314 = (*pos)[1u];
    let _e316 = tuning.gridWidth;
    let _e321 = (*pos)[2u];
    let _e323 = tuning.gridWidth;
    let _e327 = tuning.gridHeight;
    index = bitcast<u32>(((_e312 + (_e314 * bitcast<i32>(_e316))) + ((_e321 * bitcast<i32>(_e323)) * bitcast<i32>(_e327))));
    let _e332 = index;
    let _e335 = unnamed_1.grid[_e332];
    return _e335;
}

fn calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b(hitVoxelPos: ptr<function, vec3<i32>>, hitNormal: ptr<function, vec3<f32>>, lightDir: ptr<function, vec3<f32>>, ceilingY: ptr<function, i32>) -> f32 {
    var voxelPos_12: vec3<i32>;
    var stepDir_1: vec3<i32>;
    var tDelta_1: vec3<f32>;
    var local_6: f32;
    var local_7: f32;
    var local_8: f32;
    var tMax_1: vec3<f32>;
    var transmittance: f32;
    var i_3: i32;
    var blockerType: u32;
    var param_48: vec3<i32>;
    var phi_605_: bool;
    var phi_612_: bool;
    var phi_620_: bool;
    var phi_627_: bool;
    var phi_637_: bool;

    let _e282 = (*hitVoxelPos);
    let _e283 = (*hitNormal);
    voxelPos_12 = (_e282 + vec3<i32>(round(_e283)));
    let _e287 = (*lightDir);
    stepDir_1 = vec3<i32>(sign(_e287));
    let _e291 = (*lightDir)[0u];
    if (_e291 == 0f) {
        local_6 = 100000000f;
    } else {
        let _e294 = (*lightDir)[0u];
        local_6 = abs((1f / _e294));
    }
    let _e297 = local_6;
    let _e299 = (*lightDir)[1u];
    if (_e299 == 0f) {
        local_7 = 100000000f;
    } else {
        let _e302 = (*lightDir)[1u];
        local_7 = abs((1f / _e302));
    }
    let _e305 = local_7;
    let _e307 = (*lightDir)[2u];
    if (_e307 == 0f) {
        local_8 = 100000000f;
    } else {
        let _e310 = (*lightDir)[2u];
        local_8 = abs((1f / _e310));
    }
    let _e313 = local_8;
    tDelta_1 = vec3<f32>(_e297, _e305, _e313);
    let _e315 = tDelta_1;
    tMax_1 = (_e315 * 0.5f);
    transmittance = 1f;
    i_3 = 0i;
    loop {
        let _e317 = i_3;
        let _e319 = tuning.shadowMaxSteps;
        if (_e317 < bitcast<i32>(_e319)) {
            let _e323 = voxelPos_12[0u];
            let _e324 = (_e323 < 0i);
            phi_605_ = _e324;
            if !(_e324) {
                let _e327 = voxelPos_12[0u];
                let _e329 = tuning.gridWidth;
                phi_605_ = (_e327 >= bitcast<i32>(_e329));
            }
            let _e333 = phi_605_;
            phi_612_ = _e333;
            if !(_e333) {
                let _e336 = voxelPos_12[1u];
                phi_612_ = (_e336 < 0i);
            }
            let _e339 = phi_612_;
            phi_620_ = _e339;
            if !(_e339) {
                let _e342 = voxelPos_12[1u];
                let _e343 = (*ceilingY);
                phi_620_ = (_e342 >= _e343);
            }
            let _e346 = phi_620_;
            phi_627_ = _e346;
            if !(_e346) {
                let _e349 = voxelPos_12[2u];
                phi_627_ = (_e349 < 0i);
            }
            let _e352 = phi_627_;
            phi_637_ = _e352;
            if !(_e352) {
                let _e355 = voxelPos_12[2u];
                let _e357 = tuning.gridDepth;
                phi_637_ = (_e355 >= bitcast<i32>(_e357));
            }
            let _e361 = phi_637_;
            if _e361 {
                let _e362 = transmittance;
                return _e362;
            }
            let _e363 = voxelPos_12;
            param_48 = _e363;
            let _e364 = getVoxel_u0028_vi3_u003b((&param_48));
            blockerType = (_e364 & 255u);
            let _e366 = blockerType;
            if (_e366 == 2u) {
                let _e369 = tuning.waterShadowTransmit;
                let _e370 = transmittance;
                transmittance = (_e370 * _e369);
                let _e372 = transmittance;
                if (_e372 < 0.02f) {
                    return 0f;
                }
            } else {
                let _e374 = blockerType;
                if (_e374 != 0u) {
                    return 0f;
                }
            }
            let _e377 = tMax_1[0u];
            let _e379 = tMax_1[1u];
            if (_e377 < _e379) {
                let _e382 = tMax_1[0u];
                let _e384 = tMax_1[2u];
                if (_e382 < _e384) {
                    let _e387 = stepDir_1[0u];
                    let _e389 = voxelPos_12[0u];
                    voxelPos_12[0u] = (_e389 + _e387);
                    let _e393 = tDelta_1[0u];
                    let _e395 = tMax_1[0u];
                    tMax_1[0u] = (_e395 + _e393);
                } else {
                    let _e399 = stepDir_1[2u];
                    let _e401 = voxelPos_12[2u];
                    voxelPos_12[2u] = (_e401 + _e399);
                    let _e405 = tDelta_1[2u];
                    let _e407 = tMax_1[2u];
                    tMax_1[2u] = (_e407 + _e405);
                }
            } else {
                let _e411 = tMax_1[1u];
                let _e413 = tMax_1[2u];
                if (_e411 < _e413) {
                    let _e416 = stepDir_1[1u];
                    let _e418 = voxelPos_12[1u];
                    voxelPos_12[1u] = (_e418 + _e416);
                    let _e422 = tDelta_1[1u];
                    let _e424 = tMax_1[1u];
                    tMax_1[1u] = (_e424 + _e422);
                } else {
                    let _e428 = stepDir_1[2u];
                    let _e430 = voxelPos_12[2u];
                    voxelPos_12[2u] = (_e430 + _e428);
                    let _e434 = tDelta_1[2u];
                    let _e436 = tMax_1[2u];
                    tMax_1[2u] = (_e436 + _e434);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e439 = i_3;
            i_3 = (_e439 + 1i);
        }
    }
    let _e441 = transmittance;
    return _e441;
}

fn getSmoothNormal_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> vec3<f32> {
    var n_3: vec3<f32>;
    var x_3: i32;
    var y: i32;
    var z_3: i32;
    var param_49: vec3<i32>;
    var offset: vec3<f32>;

    n_3 = vec3<f32>(0f, 0f, 0f);
    x_3 = -1i;
    loop {
        let _e274 = x_3;
        if (_e274 <= 1i) {
            y = -1i;
            loop {
                let _e276 = y;
                if (_e276 <= 1i) {
                    z_3 = -1i;
                    loop {
                        let _e278 = z_3;
                        if (_e278 <= 1i) {
                            let _e280 = x_3;
                            let _e282 = y;
                            let _e285 = z_3;
                            if (((_e280 == 0i) && (_e282 == 0i)) && (_e285 == 0i)) {
                                continue;
                            }
                            let _e288 = (*p_1);
                            let _e289 = x_3;
                            let _e290 = y;
                            let _e291 = z_3;
                            param_49 = (_e288 + vec3<i32>(_e289, _e290, _e291));
                            let _e294 = getVoxel_u0028_vi3_u003b((&param_49));
                            if ((_e294 & 255u) == 0u) {
                                continue;
                            }
                            let _e297 = x_3;
                            let _e299 = y;
                            let _e301 = z_3;
                            offset = vec3<f32>(f32(_e297), f32(_e299), f32(_e301));
                            let _e304 = offset;
                            let _e305 = x_3;
                            let _e306 = x_3;
                            let _e308 = y;
                            let _e309 = y;
                            let _e312 = z_3;
                            let _e313 = z_3;
                            let _e319 = n_3;
                            n_3 = (_e319 - (_e304 * inverseSqrt(f32((((_e305 * _e306) + (_e308 * _e309)) + (_e312 * _e313))))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e321 = z_3;
                            z_3 = (_e321 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e323 = y;
                    y = (_e323 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e325 = x_3;
            x_3 = (_e325 + 1i);
        }
    }
    let _e327 = n_3;
    if (length(_e327) < 0.1f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e330 = n_3;
    return normalize(_e330);
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

    let _e283 = tuning.waterWaveScale;
    scale = max(_e283, 0.001f);
    let _e285 = (*t_1);
    let _e287 = tuning.waterWaveSpeed;
    wt = ((_e285 * _e287) * 0.35f);
    let _e290 = (*p_2);
    let _e292 = (*p_2)[1u];
    let _e294 = wt;
    let _e298 = (*p_2)[0u];
    let _e300 = wt;
    q = (_e290 + (vec2<f32>(sin(((_e292 * 0.043f) + _e294)), sin(((_e298 * 0.037f) - (_e300 * 0.8f)))) * 6f));
    grad = vec2<f32>(0f, 0f);
    i_4 = 0i;
    loop {
        let _e307 = i_4;
        if (_e307 < 5i) {
            let _e309 = i_4;
            indexable_1 = array<f32, 5>(0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
            let _e311 = indexable_1[_e309];
            let _e312 = scale;
            f = (_e311 * _e312);
            let _e314 = i_4;
            indexable_2 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e316 = indexable_2[_e314];
            let _e317 = q;
            let _e319 = f;
            let _e321 = (*t_1);
            let _e322 = i_4;
            indexable_3 = array<f32, 5>(1f, 1.37f, 0.83f, 1.71f, 0.61f);
            let _e324 = indexable_3[_e322];
            let _e327 = tuning.waterWaveSpeed;
            phase_1 = ((dot(_e316, _e317) * _e319) + ((_e321 * _e324) * _e327));
            let _e330 = i_4;
            indexable_4 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e332 = indexable_4[_e330];
            let _e333 = i_4;
            indexable_5 = array<f32, 5>(1f, 0.62f, 0.38f, 0.24f, 0.15f);
            let _e335 = indexable_5[_e333];
            let _e336 = f;
            let _e338 = phase_1;
            let _e342 = grad;
            grad = (_e342 + (_e332 * ((_e335 * _e336) * cos(_e338))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e344 = i_4;
            i_4 = (_e344 + 1i);
        }
    }
    let _e347 = (*p_2)[0u];
    let _e350 = (*p_2)[1u];
    let _e353 = (*t_1);
    envelope = (0.45f + (0.55f * sin((((_e347 * 0.021f) + (_e350 * 0.017f)) + (_e353 * 0.11f)))));
    let _e359 = grad;
    let _e360 = envelope;
    return (_e359 * _e360);
}

fn applyWaterWaves_u0028_vf3_u003b_vi3_u003b(normal_3: ptr<function, vec3<f32>>, voxelPos_13: ptr<function, vec3<i32>>) -> vec3<f32> {
    var upness: f32;
    var grad_1: vec2<f32>;
    var param_50: vec2<f32>;
    var param_51: f32;

    let _e274 = tuning.waterWaveStrength;
    if (_e274 <= 0f) {
        let _e276 = (*normal_3);
        return _e276;
    }
    let _e278 = (*normal_3)[1u];
    upness = clamp(_e278, 0f, 1f);
    let _e280 = upness;
    if (_e280 <= 0f) {
        let _e282 = (*normal_3);
        return _e282;
    }
    let _e283 = (*voxelPos_13);
    param_50 = (vec2<f32>(_e283.xz) + vec2<f32>(0.5f, 0.5f));
    let _e288 = pc.time;
    param_51 = _e288;
    let _e289 = waterWaveGradient_u0028_vf2_u003b_f1_u003b((&param_50), (&param_51));
    grad_1 = _e289;
    let _e290 = (*normal_3);
    let _e292 = grad_1[0u];
    let _e295 = grad_1[1u];
    let _e299 = tuning.waterWaveStrength;
    let _e301 = upness;
    return normalize((_e290 + ((vec3<f32>(-(_e292), 0f, -(_e295)) * _e299) * _e301)));
}

fn getWaterNormal_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> vec3<f32> {
    var n_4: vec3<f32>;
    var x_4: i32;
    var y_1: i32;
    var z_4: i32;
    var d2_: i32;
    var param_52: vec3<i32>;

    n_4 = vec3<f32>(0f, 0f, 0f);
    x_4 = -2i;
    loop {
        let _e274 = x_4;
        if (_e274 <= 2i) {
            y_1 = -2i;
            loop {
                let _e276 = y_1;
                if (_e276 <= 2i) {
                    z_4 = -2i;
                    loop {
                        let _e278 = z_4;
                        if (_e278 <= 2i) {
                            let _e280 = x_4;
                            let _e282 = y_1;
                            let _e285 = z_4;
                            if (((_e280 == 0i) && (_e282 == 0i)) && (_e285 == 0i)) {
                                continue;
                            }
                            let _e288 = x_4;
                            let _e289 = x_4;
                            let _e291 = y_1;
                            let _e292 = y_1;
                            let _e295 = z_4;
                            let _e296 = z_4;
                            d2_ = (((_e288 * _e289) + (_e291 * _e292)) + (_e295 * _e296));
                            let _e299 = d2_;
                            if (_e299 > 6i) {
                                continue;
                            }
                            let _e301 = (*p_3);
                            let _e302 = x_4;
                            let _e303 = y_1;
                            let _e304 = z_4;
                            param_52 = (_e301 + vec3<i32>(_e302, _e303, _e304));
                            let _e307 = getVoxel_u0028_vi3_u003b((&param_52));
                            if ((_e307 & 255u) == 0u) {
                                continue;
                            }
                            let _e310 = x_4;
                            let _e312 = y_1;
                            let _e314 = z_4;
                            let _e317 = d2_;
                            let _e321 = n_4;
                            n_4 = (_e321 - (vec3<f32>(f32(_e310), f32(_e312), f32(_e314)) / vec3(f32(_e317))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e323 = z_4;
                            z_4 = (_e323 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e325 = y_1;
                    y_1 = (_e325 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e327 = x_4;
            x_4 = (_e327 + 1i);
        }
    }
    let _e329 = n_4;
    if (length(_e329) < 0.001f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e332 = n_4;
    return normalize(_e332);
}

fn locustDensity_u0028_u1_u003b(type_38: ptr<function, u32>) -> f32 {
    var stage_2: f32;

    let _e269 = (*type_38);
    stage_2 = (f32((_e269 - 13u)) / 4f);
    let _e274 = tuning.locustDensityMin;
    let _e276 = tuning.locustDensityMax;
    let _e277 = stage_2;
    return clamp(mix(_e274, _e276, _e277), 0.02f, 0.98f);
}

fn trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b(voxelPos_14: ptr<function, vec3<i32>>, a: ptr<function, vec2<f32>>, b_1: ptr<function, vec2<f32>>, count_3: ptr<function, i32>) {
    var h0_: f32;
    var param_53: vec3<f32>;
    var h1_: f32;
    var param_54: vec3<f32>;
    var h2_: f32;
    var param_55: vec3<f32>;

    let _e278 = (*voxelPos_14)[0u];
    let _e281 = (*voxelPos_14)[2u];
    param_53 = vec3<f32>(f32(_e278), 7f, f32(_e281));
    let _e284 = hash_u0028_vf3_u003b((&param_53));
    h0_ = _e284;
    let _e286 = (*voxelPos_14)[0u];
    let _e289 = (*voxelPos_14)[2u];
    param_54 = vec3<f32>(f32(_e286), 19f, f32(_e289));
    let _e292 = hash_u0028_vf3_u003b((&param_54));
    h1_ = _e292;
    let _e294 = (*voxelPos_14)[0u];
    let _e297 = (*voxelPos_14)[2u];
    param_55 = vec3<f32>(f32(_e294), 53f, f32(_e297));
    let _e300 = hash_u0028_vf3_u003b((&param_55));
    h2_ = _e300;
    let _e301 = h2_;
    let _e303 = tuning.treeTrunkColumns;
    (*count_3) = (1i + i32((_e301 * f32(max(bitcast<i32>(_e303), 1i)))));
    let _e310 = (*count_3);
    (*count_3) = clamp(_e310, 1i, 2i);
    let _e312 = h0_;
    let _e315 = h1_;
    (*a) = vec2<f32>((0.3f + (_e312 * 0.4f)), (0.3f + (_e315 * 0.4f)));
    let _e319 = h1_;
    let _e322 = h0_;
    (*b_1) = vec2<f32>((0.3f + (_e319 * 0.4f)), (0.3f + (_e322 * 0.4f)));
    return;
}

fn subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b(kind: ptr<function, u32>, type_39: ptr<function, u32>, voxelPos_15: ptr<function, vec3<i32>>, cell_1: ptr<function, vec3<i32>>, sub: ptr<function, i32>, jitter: ptr<function, vec3<f32>>) -> bool {
    var p_4: vec2<f32>;
    var a_1: vec2<f32>;
    var b_2: vec2<f32>;
    var count_4: i32;
    var param_56: vec3<i32>;
    var param_57: vec2<f32>;
    var param_58: vec2<f32>;
    var param_59: i32;
    var r_1: f32;
    var param_60: vec3<f32>;
    var param_61: u32;
    var phi_1639_: bool;

    let _e284 = (*kind);
    if (_e284 == 1u) {
        let _e286 = (*cell_1);
        let _e291 = (*sub);
        p_4 = ((vec2<f32>(_e286.xz) + vec2(0.5f)) / vec2(f32(_e291)));
        let _e295 = (*voxelPos_15);
        param_56 = _e295;
        trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b((&param_56), (&param_57), (&param_58), (&param_59));
        let _e296 = param_57;
        a_1 = _e296;
        let _e297 = param_58;
        b_2 = _e297;
        let _e298 = param_59;
        count_4 = _e298;
        let _e300 = tuning.treeTrunkRadius;
        r_1 = max(_e300, 0.02f);
        let _e302 = p_4;
        let _e303 = a_1;
        let _e305 = p_4;
        let _e306 = a_1;
        let _e309 = r_1;
        let _e310 = r_1;
        if (dot((_e302 - _e303), (_e305 - _e306)) <= (_e309 * _e310)) {
            return true;
        }
        let _e313 = count_4;
        let _e314 = (_e313 > 1i);
        phi_1639_ = _e314;
        if _e314 {
            let _e315 = p_4;
            let _e316 = b_2;
            let _e318 = p_4;
            let _e319 = b_2;
            let _e322 = r_1;
            let _e323 = r_1;
            phi_1639_ = (dot((_e315 - _e316), (_e318 - _e319)) <= (_e322 * _e323));
        }
        let _e327 = phi_1639_;
        if _e327 {
            return true;
        }
        return false;
    }
    let _e328 = (*voxelPos_15);
    let _e329 = (*sub);
    let _e332 = (*cell_1);
    let _e335 = (*jitter);
    param_60 = (vec3<f32>(((_e328 * vec3(_e329)) + _e332)) + _e335);
    let _e337 = hash_u0028_vf3_u003b((&param_60));
    let _e338 = (*type_39);
    param_61 = _e338;
    let _e339 = locustDensity_u0028_u1_u003b((&param_61));
    return (_e337 < _e339);
}

fn intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b(ro: ptr<function, vec3<f32>>, rd: ptr<function, vec3<f32>>, boxMin: ptr<function, vec3<f32>>, boxMax: ptr<function, vec3<f32>>) -> vec2<f32> {
    var tMin: vec3<f32>;
    var tMax_2: vec3<f32>;
    var t1_: vec3<f32>;
    var t2_: vec3<f32>;
    var tNear: f32;
    var tFar: f32;

    let _e277 = (*boxMin);
    let _e278 = (*ro);
    let _e280 = (*rd);
    tMin = ((_e277 - _e278) / _e280);
    let _e282 = (*boxMax);
    let _e283 = (*ro);
    let _e285 = (*rd);
    tMax_2 = ((_e282 - _e283) / _e285);
    let _e287 = tMin;
    let _e288 = tMax_2;
    t1_ = min(_e287, _e288);
    let _e290 = tMin;
    let _e291 = tMax_2;
    t2_ = max(_e290, _e291);
    let _e294 = t1_[0u];
    let _e296 = t1_[1u];
    let _e299 = t1_[2u];
    tNear = max(max(_e294, _e296), _e299);
    let _e302 = t2_[0u];
    let _e304 = t2_[1u];
    let _e307 = t2_[2u];
    tFar = min(min(_e302, _e304), _e307);
    let _e309 = tNear;
    let _e310 = tFar;
    return vec2<f32>(_e309, _e310);
}

fn subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b(voxelPos_16: ptr<function, vec3<i32>>, rayOrigin_2: ptr<function, vec3<f32>>, rayDir_2: ptr<function, vec3<f32>>, kind_1: ptr<function, u32>, type_40: ptr<function, u32>, entryNormal: ptr<function, vec3<f32>>, tHit_1: ptr<function, f32>, subNormal: ptr<function, vec3<f32>>, subCell_2: ptr<function, vec3<f32>>) -> bool {
    var sub_1: i32;
    var cellSize: f32;
    var boxMin_1: vec3<f32>;
    var span: vec2<f32>;
    var param_62: vec3<f32>;
    var param_63: vec3<f32>;
    var param_64: vec3<f32>;
    var param_65: vec3<f32>;
    var t_2: f32;
    var local_9: vec3<f32>;
    var c_1: vec3<i32>;
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
    var param_66: u32;
    var param_67: u32;
    var param_68: vec3<i32>;
    var param_69: vec3<i32>;
    var param_70: i32;
    var param_71: vec3<f32>;
    var phi_1871_: bool;
    var phi_1878_: bool;
    var phi_1886_: bool;
    var phi_1893_: bool;
    var phi_1901_: bool;

    (*tHit_1) = 0f;
    let _e306 = (*entryNormal);
    (*subNormal) = _e306;
    (*subCell_2) = vec3<f32>(0f, 0f, 0f);
    let _e308 = tuning.locustSubdivision;
    sub_1 = clamp(bitcast<i32>(_e308), 1i, 8i);
    let _e311 = sub_1;
    cellSize = (1f / f32(_e311));
    let _e314 = (*voxelPos_16);
    boxMin_1 = vec3<f32>(_e314);
    let _e316 = boxMin_1;
    let _e318 = (*rayOrigin_2);
    param_62 = _e318;
    let _e319 = (*rayDir_2);
    param_63 = _e319;
    let _e320 = boxMin_1;
    param_64 = _e320;
    param_65 = (_e316 + vec3<f32>(1f, 1f, 1f));
    let _e321 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_62), (&param_63), (&param_64), (&param_65));
    span = _e321;
    let _e323 = span[0u];
    t_2 = max(_e323, 0f);
    let _e325 = t_2;
    let _e327 = span[1u];
    if (_e325 > _e327) {
        return false;
    }
    let _e329 = (*rayOrigin_2);
    let _e330 = (*rayDir_2);
    let _e331 = t_2;
    let _e335 = boxMin_1;
    let _e337 = sub_1;
    local_9 = (((_e329 + (_e330 * (_e331 + 0.0001f))) - _e335) * f32(_e337));
    let _e340 = local_9;
    let _e343 = sub_1;
    c_1 = clamp(vec3<i32>(floor(_e340)), vec3<i32>(0i, 0i, 0i), vec3((_e343 - 1i)));
    let _e347 = (*rayDir_2);
    stepDir_2 = vec3<i32>(sign(_e347));
    let _e351 = (*rayDir_2)[0u];
    if (_e351 == 0f) {
        local_10 = 1000000f;
    } else {
        let _e353 = cellSize;
        let _e355 = (*rayDir_2)[0u];
        local_10 = abs((_e353 / _e355));
    }
    let _e358 = local_10;
    let _e360 = (*rayDir_2)[1u];
    if (_e360 == 0f) {
        local_11 = 1000000f;
    } else {
        let _e362 = cellSize;
        let _e364 = (*rayDir_2)[1u];
        local_11 = abs((_e362 / _e364));
    }
    let _e367 = local_11;
    let _e369 = (*rayDir_2)[2u];
    if (_e369 == 0f) {
        local_12 = 1000000f;
    } else {
        let _e371 = cellSize;
        let _e373 = (*rayDir_2)[2u];
        local_12 = abs((_e371 / _e373));
    }
    let _e376 = local_12;
    tDelta_2 = vec3<f32>(_e358, _e367, _e376);
    let _e378 = local_9;
    let _e379 = c_1;
    fracPos_1 = (_e378 - vec3<f32>(_e379));
    let _e382 = t_2;
    let _e384 = stepDir_2[0u];
    if (_e384 > 0i) {
        let _e387 = fracPos_1[0u];
        let _e390 = tDelta_2[0u];
        local_13 = ((1f - _e387) * _e390);
    } else {
        let _e393 = fracPos_1[0u];
        let _e395 = tDelta_2[0u];
        local_13 = (_e393 * _e395);
    }
    let _e397 = local_13;
    let _e399 = stepDir_2[1u];
    if (_e399 > 0i) {
        let _e402 = fracPos_1[1u];
        let _e405 = tDelta_2[1u];
        local_14 = ((1f - _e402) * _e405);
    } else {
        let _e408 = fracPos_1[1u];
        let _e410 = tDelta_2[1u];
        local_14 = (_e408 * _e410);
    }
    let _e412 = local_14;
    let _e414 = stepDir_2[2u];
    if (_e414 > 0i) {
        let _e417 = fracPos_1[2u];
        let _e420 = tDelta_2[2u];
        local_15 = ((1f - _e417) * _e420);
    } else {
        let _e423 = fracPos_1[2u];
        let _e425 = tDelta_2[2u];
        local_15 = (_e423 * _e425);
    }
    let _e427 = local_15;
    tMax_3 = (vec3(_e382) + vec3<f32>(_e397, _e412, _e427));
    let _e431 = (*kind_1);
    if (_e431 == 0u) {
        let _e434 = pc.time;
        let _e436 = tuning.locustCrawlRate;
        local_16 = vec3((floor((_e434 * _e436)) * 1.7f));
    } else {
        local_16 = vec3<f32>(0f, 0f, 0f);
    }
    let _e441 = local_16;
    jitter_1 = _e441;
    i_5 = 0i;
    loop {
        let _e442 = i_5;
        let _e443 = sub_1;
        if (_e442 < (3i * _e443)) {
            let _e447 = c_1[0u];
            let _e448 = (_e447 < 0i);
            phi_1871_ = _e448;
            if !(_e448) {
                let _e451 = c_1[0u];
                let _e452 = sub_1;
                phi_1871_ = (_e451 >= _e452);
            }
            let _e455 = phi_1871_;
            phi_1878_ = _e455;
            if !(_e455) {
                let _e458 = c_1[1u];
                phi_1878_ = (_e458 < 0i);
            }
            let _e461 = phi_1878_;
            phi_1886_ = _e461;
            if !(_e461) {
                let _e464 = c_1[1u];
                let _e465 = sub_1;
                phi_1886_ = (_e464 >= _e465);
            }
            let _e468 = phi_1886_;
            phi_1893_ = _e468;
            if !(_e468) {
                let _e471 = c_1[2u];
                phi_1893_ = (_e471 < 0i);
            }
            let _e474 = phi_1893_;
            phi_1901_ = _e474;
            if !(_e474) {
                let _e477 = c_1[2u];
                let _e478 = sub_1;
                phi_1901_ = (_e477 >= _e478);
            }
            let _e481 = phi_1901_;
            if _e481 {
                return false;
            }
            let _e482 = (*kind_1);
            param_66 = _e482;
            let _e483 = (*type_40);
            param_67 = _e483;
            let _e484 = (*voxelPos_16);
            param_68 = _e484;
            let _e485 = c_1;
            param_69 = _e485;
            let _e486 = sub_1;
            param_70 = _e486;
            let _e487 = jitter_1;
            param_71 = _e487;
            let _e488 = subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b((&param_66), (&param_67), (&param_68), (&param_69), (&param_70), (&param_71));
            if _e488 {
                let _e489 = t_2;
                (*tHit_1) = _e489;
                let _e490 = c_1;
                (*subCell_2) = vec3<f32>(_e490);
                return true;
            }
            let _e493 = tMax_3[0u];
            let _e495 = tMax_3[1u];
            if (_e493 < _e495) {
                let _e498 = tMax_3[0u];
                let _e500 = tMax_3[2u];
                if (_e498 < _e500) {
                    let _e503 = stepDir_2[0u];
                    let _e505 = c_1[0u];
                    c_1[0u] = (_e505 + _e503);
                    let _e509 = tMax_3[0u];
                    t_2 = _e509;
                    let _e511 = tDelta_2[0u];
                    let _e513 = tMax_3[0u];
                    tMax_3[0u] = (_e513 + _e511);
                    let _e517 = stepDir_2[0u];
                    (*subNormal) = vec3<f32>(f32(-(_e517)), 0f, 0f);
                } else {
                    let _e522 = stepDir_2[2u];
                    let _e524 = c_1[2u];
                    c_1[2u] = (_e524 + _e522);
                    let _e528 = tMax_3[2u];
                    t_2 = _e528;
                    let _e530 = tDelta_2[2u];
                    let _e532 = tMax_3[2u];
                    tMax_3[2u] = (_e532 + _e530);
                    let _e536 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e536)));
                }
            } else {
                let _e541 = tMax_3[1u];
                let _e543 = tMax_3[2u];
                if (_e541 < _e543) {
                    let _e546 = stepDir_2[1u];
                    let _e548 = c_1[1u];
                    c_1[1u] = (_e548 + _e546);
                    let _e552 = tMax_3[1u];
                    t_2 = _e552;
                    let _e554 = tDelta_2[1u];
                    let _e556 = tMax_3[1u];
                    tMax_3[1u] = (_e556 + _e554);
                    let _e560 = stepDir_2[1u];
                    (*subNormal) = vec3<f32>(0f, f32(-(_e560)), 0f);
                } else {
                    let _e565 = stepDir_2[2u];
                    let _e567 = c_1[2u];
                    c_1[2u] = (_e567 + _e565);
                    let _e571 = tMax_3[2u];
                    t_2 = _e571;
                    let _e573 = tDelta_2[2u];
                    let _e575 = tMax_3[2u];
                    tMax_3[2u] = (_e575 + _e573);
                    let _e579 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e579)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e583 = i_5;
            i_5 = (_e583 + 1i);
        }
    }
    return false;
}

fn isLocustType_u0028_u1_u003b(type_41: ptr<function, u32>) -> bool {
    let _e268 = (*type_41);
    let _e270 = (*type_41);
    return ((_e268 >= 13u) && (_e270 <= 17u));
}

fn marchCeiling_u0028_() -> i32 {
    let _e268 = tuning.gridHeight;
    let _e271 = unnamed.maxOccupiedY;
    return min(bitcast<i32>(_e268), (bitcast<i32>(_e271) + 2i));
}

fn worldExtent_u0028_() -> vec3<f32> {
    let _e268 = tuning.gridWidth;
    let _e272 = tuning.gridHeight;
    let _e276 = tuning.gridDepth;
    return vec3<f32>(f32(bitcast<i32>(_e268)), f32(bitcast<i32>(_e272)), f32(bitcast<i32>(_e276)));
}

fn isEdge_u0028_vf3_u003b(p_5: ptr<function, vec3<f32>>) -> bool {
    var thickness_1: f32;
    var boundCount: i32;
    var extent: vec3<f32>;
    var phi_480_: bool;
    var phi_499_: bool;
    var phi_518_: bool;

    thickness_1 = 0.3f;
    boundCount = 0i;
    let _e271 = worldExtent_u0028_();
    extent = _e271;
    let _e273 = (*p_5)[0u];
    let _e274 = thickness_1;
    let _e275 = (_e273 < _e274);
    phi_480_ = _e275;
    if !(_e275) {
        let _e278 = (*p_5)[0u];
        let _e280 = extent[0u];
        let _e281 = thickness_1;
        phi_480_ = (_e278 > (_e280 - _e281));
    }
    let _e285 = phi_480_;
    if _e285 {
        let _e286 = boundCount;
        boundCount = (_e286 + 1i);
    }
    let _e289 = (*p_5)[1u];
    let _e290 = thickness_1;
    let _e291 = (_e289 < _e290);
    phi_499_ = _e291;
    if !(_e291) {
        let _e294 = (*p_5)[1u];
        let _e296 = extent[1u];
        let _e297 = thickness_1;
        phi_499_ = (_e294 > (_e296 - _e297));
    }
    let _e301 = phi_499_;
    if _e301 {
        let _e302 = boundCount;
        boundCount = (_e302 + 1i);
    }
    let _e305 = (*p_5)[2u];
    let _e306 = thickness_1;
    let _e307 = (_e305 < _e306);
    phi_518_ = _e307;
    if !(_e307) {
        let _e310 = (*p_5)[2u];
        let _e312 = extent[2u];
        let _e313 = thickness_1;
        phi_518_ = (_e310 > (_e312 - _e313));
    }
    let _e317 = phi_518_;
    if _e317 {
        let _e318 = boundCount;
        boundCount = (_e318 + 1i);
    }
    let _e320 = boundCount;
    return (_e320 >= 2i);
}

fn rot_u0028_f1_u003b(a_2: ptr<function, f32>) -> mat2x2<f32> {
    var s: f32;
    var c_2: f32;

    let _e270 = (*a_2);
    s = sin(_e270);
    let _e272 = (*a_2);
    c_2 = cos(_e272);
    let _e274 = c_2;
    let _e275 = s;
    let _e277 = s;
    let _e278 = c_2;
    return mat2x2<f32>(vec2<f32>(_e274, -(_e275)), vec2<f32>(_e277, _e278));
}

fn applyCameraRotation_u0028_vf3_u003b(v: ptr<function, vec3<f32>>) -> vec3<f32> {
    var param_72: f32;
    var param_73: f32;

    let _e271 = pc.pitch;
    param_72 = _e271;
    let _e272 = rot_u0028_f1_u003b((&param_72));
    let _e273 = (*v);
    let _e275 = (_e273.yz * _e272);
    (*v)[1u] = _e275.x;
    (*v)[2u] = _e275.y;
    let _e281 = pc.yaw;
    param_73 = _e281;
    let _e282 = rot_u0028_f1_u003b((&param_73));
    let _e283 = (*v);
    let _e285 = (_e283.xz * _e282);
    (*v)[0u] = _e285.x;
    (*v)[2u] = _e285.y;
    let _e290 = (*v);
    return _e290;
}

fn main_1() {
    var screenSpace: vec2<f32>;
    var baseOrigin: vec3<f32>;
    var forward: vec3<f32>;
    var param_74: vec3<f32>;
    var right: vec3<f32>;
    var param_75: vec3<f32>;
    var up: vec3<f32>;
    var param_76: vec3<f32>;
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
    var param_77: vec3<f32>;
    var param_78: vec3<f32>;
    var param_79: vec3<f32>;
    var param_80: vec3<f32>;
    var hitFrontBox: bool;
    var hitBackBox: bool;
    var param_81: vec3<f32>;
    var param_82: vec3<f32>;
    var ceilingY_1: i32;
    var local_17: i32;
    var marchHit: vec2<f32>;
    var param_83: vec3<f32>;
    var param_84: vec3<f32>;
    var param_85: vec3<f32>;
    var param_86: vec3<f32>;
    var currentPos: vec3<f32>;
    var voxelPos_17: vec3<i32>;
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
    var param_87: vec3<i32>;
    var c_3: u32;
    var age_1: u32;
    var targetAlpha: f32;
    var dither: f32;
    var param_88: u32;
    var kind_2: u32;
    var param_89: vec3<i32>;
    var param_90: vec3<f32>;
    var param_91: vec3<f32>;
    var param_92: u32;
    var param_93: u32;
    var param_94: vec3<f32>;
    var param_95: f32;
    var param_96: vec3<f32>;
    var param_97: vec3<f32>;
    var ddaNormal_1: vec3<f32>;
    var param_98: vec3<i32>;
    var param_99: vec3<f32>;
    var param_100: vec3<i32>;
    var param_101: u32;
    var param_102: vec3<i32>;
    var sunDir_2: vec3<f32>;
    var sunColor_1: vec3<f32>;
    var ambientColor: vec3<f32>;
    var diffuse_1: f32;
    var shadow_1: f32;
    var param_103: vec3<i32>;
    var param_104: vec3<f32>;
    var param_105: vec3<f32>;
    var param_106: i32;
    var baseLighting_10: vec3<f32>;
    var finalVoxelColor: vec3<f32>;
    var calm: vec3<f32>;
    var rain: vec3<f32>;
    var param_107: u32;
    var param_108: vec3<f32>;
    var param_109: vec3<i32>;
    var param_110: vec3<f32>;
    var param_111: vec3<f32>;
    var param_112: vec3<f32>;
    var param_113: vec3<f32>;
    var param_114: f32;
    var param_115: vec3<f32>;
    var param_116: vec3<i32>;
    var param_117: vec3<f32>;
    var param_118: u32;
    var param_119: vec3<i32>;
    var param_120: vec3<f32>;
    var param_121: vec3<f32>;
    var param_122: u32;
    var param_123: vec3<i32>;
    var param_124: vec3<i32>;
    var param_125: vec3<f32>;
    var param_126: u32;
    var param_127: vec3<i32>;
    var param_128: vec3<i32>;
    var param_129: vec3<f32>;
    var param_130: vec3<i32>;
    var param_131: vec3<f32>;
    var param_132: vec3<f32>;
    var param_133: vec3<i32>;
    var param_134: vec3<f32>;
    var param_135: vec3<f32>;
    var param_136: u32;
    var param_137: vec3<i32>;
    var param_138: vec3<f32>;
    var param_139: vec3<i32>;
    var param_140: vec3<f32>;
    var param_141: vec3<f32>;
    var param_142: vec3<i32>;
    var distanceTraveled: f32;
    var param_143: u32;
    var local_24: f32;
    var seenHoles: u32;
    var i_7: i32;
    var code_2: u32;
    var bodyLevel: u32;
    var local_25: u32;
    var param_144: u32;
    var bodyRadius: f32;
    var param_145: u32;
    var center: vec3<f32>;
    var param_146: u32;
    var oc: vec3<f32>;
    var b_3: f32;
    var c_4: f32;
    var disc: f32;
    var sq: f32;
    var tNear_1: f32;
    var tFar_1: f32;
    var bodyDist: f32;
    var surfaceNormal: vec3<f32>;
    var bodyColor: vec3<f32>;
    var param_147: vec3<f32>;
    var param_148: vec3<f32>;
    var charge: f32;
    var cloudGreyness: f32;
    var crossedTime: f32;
    var slabMax: f32;
    var bandHi: f32;
    var bandLo: f32;
    var cloudClip: vec2<f32>;
    var local_26: vec2<f32>;
    var param_149: vec3<f32>;
    var param_150: vec3<f32>;
    var param_151: vec3<f32>;
    var param_152: vec3<f32>;
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
    var param_153: vec3<f32>;
    var param_154: vec3<f32>;
    var param_155: f32;
    var param_156: f32;
    var param_157: vec3<f32>;
    var param_158: f32;
    var param_159: f32;
    var param_160: vec3<f32>;
    var param_161: f32;
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
    var c_5: f32;
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
    var param_162: vec3<f32>;
    var param_163: vec3<f32>;
    var param_164: vec3<f32>;
    var param_165: vec3<f32>;
    var distFront: f32;
    var distBack: f32;
    var hitPosFront: vec3<f32>;
    var hitPosBack: vec3<f32>;
    var e: f32;
    var onFrontEdge: bool;
    var edgesFront: i32;
    var onBackEdge: bool;
    var edgesBack: i32;
    var phi_3155_: bool;
    var phi_3171_: bool;
    var phi_3399_: bool;
    var phi_3406_: bool;
    var phi_3414_: bool;
    var phi_3421_: bool;
    var phi_3431_: bool;
    var phi_3926_: bool;
    var phi_4245_: bool;
    var phi_4252_: bool;
    var phi_4261_: bool;
    var phi_4267_: bool;
    var phi_4276_: bool;
    var phi_4485_: bool;
    var phi_4527_: bool;
    var phi_4549_: bool;
    var phi_4571_: bool;
    var phi_4599_: bool;
    var phi_4621_: bool;
    var phi_4643_: bool;

    let _e483 = inUV_1;
    screenSpace = ((_e483 * 2f) - vec2(1f));
    let _e488 = screenSpace[1u];
    screenSpace[1u] = -(_e488);
    let _e492 = pc.aspectScaleX;
    let _e494 = screenSpace[0u];
    screenSpace[0u] = (_e494 * _e492);
    let _e498 = pc.aspectScaleY;
    let _e500 = screenSpace[1u];
    screenSpace[1u] = (_e500 * _e498);
    let _e504 = pc.camX;
    let _e506 = pc.camY;
    let _e508 = pc.camZ;
    baseOrigin = vec3<f32>(_e504, _e506, _e508);
    param_74 = vec3<f32>(0f, 0f, 1f);
    let _e510 = applyCameraRotation_u0028_vf3_u003b((&param_74));
    forward = _e510;
    param_75 = vec3<f32>(1f, 0f, 0f);
    let _e511 = applyCameraRotation_u0028_vf3_u003b((&param_75));
    right = _e511;
    param_76 = vec3<f32>(0f, 1f, 0f);
    let _e512 = applyCameraRotation_u0028_vf3_u003b((&param_76));
    up = _e512;
    let _e514 = pc.perspectiveBlend;
    t_3 = clamp(_e514, 0f, 1f);
    let _e516 = worldExtent_u0028_();
    cubeCenter = (_e516 * 0.5f);
    let _e518 = cubeCenter;
    let _e519 = baseOrigin;
    let _e521 = forward;
    viewDistance = max(1f, dot((_e518 - _e519), _e521));
    let _e524 = viewDistance;
    let _e526 = pc.fovDistance;
    orthoHalfSize = (_e524 / _e526);
    let _e529 = screenSpace[0u];
    let _e531 = screenSpace[1u];
    let _e533 = pc.fovDistance;
    let _e535 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e529, _e531, _e533), vec3(_e535));
    let _e538 = right;
    let _e540 = localDir[0u];
    let _e542 = up;
    let _e544 = localDir[1u];
    let _e547 = forward;
    let _e549 = localDir[2u];
    rayDir_3 = normalize((((_e538 * _e540) + (_e542 * _e544)) + (_e547 * _e549)));
    let _e553 = right;
    let _e555 = screenSpace[0u];
    let _e557 = up;
    let _e559 = screenSpace[1u];
    let _e562 = orthoHalfSize;
    let _e564 = t_3;
    originOffset = ((((_e553 * _e555) + (_e557 * _e559)) * _e562) * (1f - _e564));
    let _e567 = baseOrigin;
    let _e568 = originOffset;
    rayOrigin_3 = (_e567 + _e568);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e570 = worldExtent_u0028_();
    let _e571 = rayOrigin_3;
    param_77 = _e571;
    let _e572 = rayDir_3;
    param_78 = _e572;
    param_79 = vec3<f32>(0f, 0f, 0f);
    param_80 = _e570;
    let _e573 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_77), (&param_78), (&param_79), (&param_80));
    aabbHit = _e573;
    hitFrontBox = false;
    hitBackBox = false;
    let _e575 = aabbHit[0u];
    let _e577 = aabbHit[1u];
    let _e578 = (_e575 < _e577);
    phi_3155_ = _e578;
    if _e578 {
        let _e580 = aabbHit[1u];
        phi_3155_ = (_e580 > 0f);
    }
    let _e583 = phi_3155_;
    if _e583 {
        let _e585 = aabbHit[0u];
        let _e586 = (_e585 > 0f);
        phi_3171_ = _e586;
        if _e586 {
            let _e587 = rayOrigin_3;
            let _e588 = rayDir_3;
            let _e590 = aabbHit[0u];
            param_81 = (_e587 + (_e588 * _e590));
            let _e593 = isEdge_u0028_vf3_u003b((&param_81));
            phi_3171_ = _e593;
        }
        let _e595 = phi_3171_;
        if _e595 {
            hitFrontBox = true;
        }
        let _e596 = rayOrigin_3;
        let _e597 = rayDir_3;
        let _e599 = aabbHit[1u];
        param_82 = (_e596 + (_e597 * _e599));
        let _e602 = isEdge_u0028_vf3_u003b((&param_82));
        if _e602 {
            hitBackBox = true;
        }
    }
    let _e604 = pc.showCloudBlocks;
    if (_e604 != 0i) {
        let _e607 = tuning.gridHeight;
        local_17 = bitcast<i32>(_e607);
    } else {
        let _e609 = marchCeiling_u0028_();
        local_17 = _e609;
    }
    let _e610 = local_17;
    ceilingY_1 = _e610;
    let _e612 = tuning.gridWidth;
    let _e615 = ceilingY_1;
    let _e618 = tuning.gridDepth;
    let _e622 = rayOrigin_3;
    param_83 = _e622;
    let _e623 = rayDir_3;
    param_84 = _e623;
    param_85 = vec3<f32>(0f, 0f, 0f);
    param_86 = vec3<f32>(f32(bitcast<i32>(_e612)), f32(_e615), f32(bitcast<i32>(_e618)));
    let _e624 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_83), (&param_84), (&param_85), (&param_86));
    marchHit = _e624;
    let _e625 = rayOrigin_3;
    let _e626 = rayDir_3;
    let _e628 = marchHit[0u];
    currentPos = (_e625 + (_e626 * max(0f, _e628)));
    let _e633 = marchHit[0u];
    if (_e633 > 0f) {
        let _e635 = rayDir_3;
        let _e637 = currentPos;
        currentPos = (_e637 + (_e635 * 0.001f));
    }
    let _e639 = currentPos;
    voxelPos_17 = vec3<i32>(floor(_e639));
    let _e642 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e642));
    let _e646 = rayDir_3[0u];
    if (_e646 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e649 = rayDir_3[0u];
        local_18 = abs((1f / _e649));
    }
    let _e652 = local_18;
    let _e654 = rayDir_3[1u];
    if (_e654 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e657 = rayDir_3[1u];
        local_19 = abs((1f / _e657));
    }
    let _e660 = local_19;
    let _e662 = rayDir_3[2u];
    if (_e662 == 0f) {
        local_20 = 100000000f;
    } else {
        let _e665 = rayDir_3[2u];
        local_20 = abs((1f / _e665));
    }
    let _e668 = local_20;
    tDelta_3 = vec3<f32>(_e652, _e660, _e668);
    let _e671 = stepDir_3[0u];
    if (_e671 > 0i) {
        let _e674 = currentPos[0u];
        let _e678 = currentPos[0u];
        let _e681 = tDelta_3[0u];
        local_21 = (((floor(_e674) + 1f) - _e678) * _e681);
    } else {
        let _e684 = currentPos[0u];
        let _e686 = currentPos[0u];
        let _e690 = tDelta_3[0u];
        local_21 = ((_e684 - floor(_e686)) * _e690);
    }
    let _e692 = local_21;
    let _e694 = stepDir_3[1u];
    if (_e694 > 0i) {
        let _e697 = currentPos[1u];
        let _e701 = currentPos[1u];
        let _e704 = tDelta_3[1u];
        local_22 = (((floor(_e697) + 1f) - _e701) * _e704);
    } else {
        let _e707 = currentPos[1u];
        let _e709 = currentPos[1u];
        let _e713 = tDelta_3[1u];
        local_22 = ((_e707 - floor(_e709)) * _e713);
    }
    let _e715 = local_22;
    let _e717 = stepDir_3[2u];
    if (_e717 > 0i) {
        let _e720 = currentPos[2u];
        let _e724 = currentPos[2u];
        let _e727 = tDelta_3[2u];
        local_23 = (((floor(_e720) + 1f) - _e724) * _e727);
    } else {
        let _e730 = currentPos[2u];
        let _e732 = currentPos[2u];
        let _e736 = tDelta_3[2u];
        local_23 = ((_e730 - floor(_e732)) * _e736);
    }
    let _e738 = local_23;
    tMax_4 = vec3<f32>(_e692, _e715, _e738);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e741 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e741 * 1.5f));
    i_6 = 0i;
    loop {
        let _e744 = i_6;
        let _e746 = tuning.marchMaxSteps;
        if (_e744 < bitcast<i32>(_e746)) {
            let _e750 = voxelPos_17[0u];
            let _e751 = (_e750 < 0i);
            phi_3399_ = _e751;
            if !(_e751) {
                let _e754 = voxelPos_17[0u];
                let _e756 = tuning.gridWidth;
                phi_3399_ = (_e754 >= bitcast<i32>(_e756));
            }
            let _e760 = phi_3399_;
            phi_3406_ = _e760;
            if !(_e760) {
                let _e763 = voxelPos_17[1u];
                phi_3406_ = (_e763 < 0i);
            }
            let _e766 = phi_3406_;
            phi_3414_ = _e766;
            if !(_e766) {
                let _e769 = voxelPos_17[1u];
                let _e770 = ceilingY_1;
                phi_3414_ = (_e769 >= _e770);
            }
            let _e773 = phi_3414_;
            phi_3421_ = _e773;
            if !(_e773) {
                let _e776 = voxelPos_17[2u];
                phi_3421_ = (_e776 < 0i);
            }
            let _e779 = phi_3421_;
            phi_3431_ = _e779;
            if !(_e779) {
                let _e782 = voxelPos_17[2u];
                let _e784 = tuning.gridDepth;
                phi_3431_ = (_e782 >= bitcast<i32>(_e784));
            }
            let _e788 = phi_3431_;
            if _e788 {
                break;
            }
            let _e789 = voxelPos_17;
            param_87 = _e789;
            let _e790 = getVoxel_u0028_vi3_u003b((&param_87));
            rawVoxel_5 = _e790;
            let _e791 = rawVoxel_5;
            hitType = (_e791 & 255u);
            let _e794 = pc.showCloudBlocks;
            let _e796 = hitType;
            if ((_e794 != 0i) && (_e796 == 0u)) {
                let _e800 = voxelPos_17[0u];
                let _e802 = voxelPos_17[1u];
                let _e804 = tuning.gridWidth;
                let _e809 = voxelPos_17[2u];
                let _e811 = tuning.gridWidth;
                let _e815 = tuning.gridHeight;
                let _e822 = unnamed_2.cloudCells[bitcast<u32>(((_e800 + (_e802 * bitcast<i32>(_e804))) + ((_e809 * bitcast<i32>(_e811)) * bitcast<i32>(_e815))))];
                c_3 = _e822;
                let _e823 = c_3;
                if ((_e823 & 3u) != 0u) {
                    hitType = 200u;
                    let _e826 = c_3;
                    hitRawVoxel = _e826;
                    hit = true;
                    break;
                }
            }
            let _e827 = hitType;
            if (_e827 == 7u) {
                hitType = 0u;
            }
            let _e829 = hitType;
            if (_e829 != 0u) {
                let _e831 = hitType;
                if (_e831 == 6u) {
                    let _e833 = rawVoxel_5;
                    age_1 = ((_e833 >> bitcast<u32>(24i)) & 255u);
                    let _e837 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e837) / 100f), 0f, 1f));
                    let _e842 = inUV_1;
                    let _e844 = pc.time;
                    dither = fract((sin(dot((_e842 + vec2((_e844 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e852 = dither;
                    let _e853 = targetAlpha;
                    if (_e852 > _e853) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e855 = rawVoxel_5;
                        hitRawVoxel = _e855;
                        break;
                    }
                } else {
                    let _e856 = hitType;
                    param_88 = _e856;
                    let _e857 = isLocustType_u0028_u1_u003b((&param_88));
                    let _e858 = hitType;
                    if (_e857 || (_e858 == 18u)) {
                        let _e861 = hitType;
                        kind_2 = select(0u, 1u, (_e861 == 18u));
                        let _e864 = voxelPos_17;
                        param_89 = _e864;
                        let _e865 = rayOrigin_3;
                        param_90 = _e865;
                        let _e866 = rayDir_3;
                        param_91 = _e866;
                        let _e867 = kind_2;
                        param_92 = _e867;
                        let _e868 = hitType;
                        param_93 = _e868;
                        let _e869 = normal_4;
                        param_94 = _e869;
                        let _e870 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_89), (&param_90), (&param_91), (&param_92), (&param_93), (&param_94), (&param_95), (&param_96), (&param_97));
                        let _e871 = param_95;
                        subT = _e871;
                        let _e872 = param_96;
                        subNormal_1 = _e872;
                        let _e873 = param_97;
                        subCell_3 = _e873;
                        if _e870 {
                            hit = true;
                            let _e874 = rawVoxel_5;
                            hitRawVoxel = _e874;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e875 = rawVoxel_5;
                        hitRawVoxel = _e875;
                        break;
                    }
                }
            }
            let _e877 = tMax_4[0u];
            let _e879 = tMax_4[1u];
            if (_e877 < _e879) {
                let _e882 = tMax_4[0u];
                let _e884 = tMax_4[2u];
                if (_e882 < _e884) {
                    let _e887 = stepDir_3[0u];
                    let _e889 = voxelPos_17[0u];
                    voxelPos_17[0u] = (_e889 + _e887);
                    let _e893 = tDelta_3[0u];
                    let _e895 = tMax_4[0u];
                    tMax_4[0u] = (_e895 + _e893);
                    let _e899 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e899)), 0f, 0f);
                } else {
                    let _e904 = stepDir_3[2u];
                    let _e906 = voxelPos_17[2u];
                    voxelPos_17[2u] = (_e906 + _e904);
                    let _e910 = tDelta_3[2u];
                    let _e912 = tMax_4[2u];
                    tMax_4[2u] = (_e912 + _e910);
                    let _e916 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e916)));
                }
            } else {
                let _e921 = tMax_4[1u];
                let _e923 = tMax_4[2u];
                if (_e921 < _e923) {
                    let _e926 = stepDir_3[1u];
                    let _e928 = voxelPos_17[1u];
                    voxelPos_17[1u] = (_e928 + _e926);
                    let _e932 = tDelta_3[1u];
                    let _e934 = tMax_4[1u];
                    tMax_4[1u] = (_e934 + _e932);
                    let _e938 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e938)), 0f);
                } else {
                    let _e943 = stepDir_3[2u];
                    let _e945 = voxelPos_17[2u];
                    voxelPos_17[2u] = (_e945 + _e943);
                    let _e949 = tDelta_3[2u];
                    let _e951 = tMax_4[2u];
                    tMax_4[2u] = (_e951 + _e949);
                    let _e955 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e955)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e959 = i_6;
            i_6 = (_e959 + 1i);
        }
    }
    let _e961 = hit;
    if _e961 {
        let _e962 = normal_4;
        if (length(_e962) < 0.1f) {
            let _e965 = rayDir_3;
            normal_4 = -(_e965);
        }
        let _e967 = normal_4;
        ddaNormal_1 = _e967;
        let _e968 = hitType;
        if (_e968 == 2u) {
            let _e970 = voxelPos_17;
            param_98 = _e970;
            let _e971 = getWaterNormal_u0028_vi3_u003b((&param_98));
            param_99 = _e971;
            let _e972 = voxelPos_17;
            param_100 = _e972;
            let _e973 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_99), (&param_100));
            normal_4 = _e973;
        } else {
            let _e974 = hitType;
            param_101 = _e974;
            let _e975 = isLocustType_u0028_u1_u003b((&param_101));
            let _e976 = hitType;
            if (_e975 || (_e976 == 18u)) {
                let _e979 = subNormal_1;
                normal_4 = _e979;
            } else {
                let _e980 = voxelPos_17;
                param_102 = _e980;
                let _e981 = getSmoothNormal_u0028_vi3_u003b((&param_102));
                normal_4 = _e981;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e982 = normal_4;
        let _e983 = sunDir_2;
        diffuse_1 = max(dot(_e982, _e983), 0f);
        let _e986 = voxelPos_17;
        param_103 = _e986;
        let _e987 = ddaNormal_1;
        param_104 = _e987;
        let _e988 = sunDir_2;
        param_105 = _e988;
        let _e989 = ceilingY_1;
        param_106 = _e989;
        let _e990 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_103), (&param_104), (&param_105), (&param_106));
        shadow_1 = _e990;
        let _e991 = ambientColor;
        let _e992 = sunColor_1;
        let _e993 = diffuse_1;
        let _e995 = shadow_1;
        baseLighting_10 = (_e991 + ((_e992 * _e993) * _e995));
        let _e998 = baseLighting_10;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e998);
        let _e1000 = hitType;
        if (_e1000 == 200u) {
            calm = vec3<f32>(0.35f, 0.65f, 1f);
            rain = vec3<f32>(1f, 0.55f, 0.25f);
            let _e1002 = calm;
            let _e1003 = rain;
            let _e1004 = hitRawVoxel;
            let _e1010 = baseLighting_10;
            finalVoxelColor = (mix(_e1002, _e1003, vec3(select(0f, 1f, ((_e1004 & 3u) == 2u)))) * _e1010);
        }
        let _e1012 = hitType;
        switch bitcast<i32>(_e1012) {
            case 1: {
                let _e1014 = hitRawVoxel;
                param_107 = _e1014;
                let _e1015 = baseLighting_10;
                param_108 = _e1015;
                let _e1016 = renderSand_u0028_u1_u003b_vf3_u003b((&param_107), (&param_108));
                finalVoxelColor = _e1016;
                break;
            }
            case 2: {
                let _e1017 = voxelPos_17;
                param_109 = _e1017;
                let _e1018 = normal_4;
                param_110 = _e1018;
                let _e1019 = rayOrigin_3;
                param_111 = _e1019;
                let _e1020 = sunDir_2;
                param_112 = _e1020;
                let _e1021 = sunColor_1;
                param_113 = _e1021;
                let _e1022 = shadow_1;
                param_114 = _e1022;
                let _e1023 = baseLighting_10;
                param_115 = _e1023;
                let _e1024 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_109), (&param_110), (&param_111), (&param_112), (&param_113), (&param_114), (&param_115));
                finalVoxelColor = _e1024;
                break;
            }
            case 3: {
                let _e1025 = voxelPos_17;
                param_116 = _e1025;
                let _e1026 = baseLighting_10;
                param_117 = _e1026;
                let _e1027 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_116), (&param_117));
                finalVoxelColor = _e1027;
                break;
            }
            case 4: {
                let _e1028 = hitRawVoxel;
                param_118 = _e1028;
                let _e1029 = voxelPos_17;
                param_119 = _e1029;
                let _e1030 = ddaNormal_1;
                param_120 = _e1030;
                let _e1031 = baseLighting_10;
                param_121 = _e1031;
                let _e1032 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_118), (&param_119), (&param_120), (&param_121));
                finalVoxelColor = _e1032;
                break;
            }
            case 5: {
                let _e1033 = hitRawVoxel;
                param_122 = _e1033;
                let _e1034 = voxelPos_17;
                param_123 = _e1034;
                let _e1035 = renderFire_u0028_u1_u003b_vi3_u003b((&param_122), (&param_123));
                finalVoxelColor = _e1035;
                break;
            }
            case 6: {
                let _e1036 = voxelPos_17;
                param_124 = _e1036;
                let _e1037 = baseLighting_10;
                param_125 = _e1037;
                let _e1038 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_124), (&param_125));
                finalVoxelColor = _e1038;
                break;
            }
            case 9, 10, 11, 8: {
                let _e1039 = hitRawVoxel;
                param_126 = _e1039;
                let _e1040 = voxelPos_17;
                param_127 = _e1040;
                let _e1041 = renderLava_u0028_u1_u003b_vi3_u003b((&param_126), (&param_127));
                finalVoxelColor = _e1041;
                break;
            }
            case 12: {
                let _e1042 = voxelPos_17;
                param_128 = _e1042;
                let _e1043 = baseLighting_10;
                param_129 = _e1043;
                let _e1044 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_128), (&param_129));
                finalVoxelColor = _e1044;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e1045 = voxelPos_17;
                param_130 = _e1045;
                let _e1046 = subCell_3;
                param_131 = _e1046;
                let _e1047 = baseLighting_10;
                param_132 = _e1047;
                let _e1048 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_130), (&param_131), (&param_132));
                finalVoxelColor = _e1048;
                break;
            }
            case 18: {
                let _e1049 = voxelPos_17;
                param_133 = _e1049;
                let _e1050 = subCell_3;
                param_134 = _e1050;
                let _e1051 = baseLighting_10;
                param_135 = _e1051;
                let _e1052 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_133), (&param_134), (&param_135));
                finalVoxelColor = _e1052;
                break;
            }
            case 19: {
                let _e1053 = hitRawVoxel;
                param_136 = _e1053;
                let _e1054 = voxelPos_17;
                param_137 = _e1054;
                let _e1055 = baseLighting_10;
                param_138 = _e1055;
                let _e1056 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_136), (&param_137), (&param_138));
                finalVoxelColor = _e1056;
                break;
            }
            case 20: {
                let _e1057 = voxelPos_17;
                param_139 = _e1057;
                let _e1058 = baseLighting_10;
                param_140 = _e1058;
                let _e1059 = renderAsh_u0028_vi3_u003b_vf3_u003b((&param_139), (&param_140));
                finalVoxelColor = _e1059;
                break;
            }
            default: {
                break;
            }
        }
        let _e1060 = finalVoxelColor;
        param_141 = _e1060;
        let _e1061 = voxelPos_17;
        param_142 = _e1061;
        let _e1062 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_141), (&param_142));
        finalVoxelColor = _e1062;
        let _e1063 = hitType;
        param_143 = _e1063;
        let _e1064 = isLocustType_u0028_u1_u003b((&param_143));
        let _e1065 = hitType;
        if (_e1064 || (_e1065 == 18u)) {
            let _e1068 = subT;
            local_24 = _e1068;
        } else {
            let _e1069 = voxelPos_17;
            let _e1072 = rayOrigin_3;
            local_24 = length(((vec3<f32>(_e1069) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e1072));
        }
        let _e1075 = local_24;
        distanceTraveled = _e1075;
        let _e1076 = distanceTraveled;
        let _e1077 = MAX_VISIBILITY;
        let _e1081 = finalVoxelColor;
        finalVoxelColor = (_e1081 * mix(1f, 0f, clamp((_e1076 / _e1077), 0f, 1f)));
        let _e1083 = distanceTraveled;
        finalDist = _e1083;
        let _e1084 = finalVoxelColor;
        finalColor = vec4<f32>(_e1084.x, _e1084.y, _e1084.z, 1f);
    } else {
        let _e1089 = hitBackBox;
        if _e1089 {
            let _e1091 = aabbHit[1u];
            finalDist = _e1091;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1093 = unnamed.blackHoleCount;
    if (_e1093 > 0u) {
        seenHoles = 0u;
        i_7 = 0i;
        loop {
            let _e1095 = i_7;
            let _e1096 = (_e1095 < 8i);
            phi_3926_ = _e1096;
            if _e1096 {
                let _e1097 = seenHoles;
                let _e1099 = unnamed.blackHoleCount;
                phi_3926_ = (_e1097 < _e1099);
            }
            let _e1102 = phi_3926_;
            if _e1102 {
                let _e1103 = i_7;
                let _e1106 = unnamed.blackHoles[_e1103];
                code_2 = _e1106;
                let _e1107 = code_2;
                if (_e1107 == 0u) {
                    continue;
                }
                let _e1109 = seenHoles;
                seenHoles = (_e1109 + bitcast<u32>(1i));
                let _e1112 = code_2;
                if ((_e1112 & 1073741824u) != 0u) {
                    let _e1116 = tuning.purgeLevel;
                    let _e1118 = i_7;
                    let _e1121 = unnamed.blackHoleMass[_e1118];
                    let _e1124 = tuning.purgeMass;
                    local_25 = u32((f32(_e1116) * clamp((f32(_e1121) / f32(max(_e1124, 1u))), 0f, 1f)));
                } else {
                    let _e1131 = i_7;
                    let _e1134 = unnamed.blackHoleMass[_e1131];
                    param_144 = _e1134;
                    let _e1135 = bhLevel_u0028_u1_u003b((&param_144));
                    local_25 = _e1135;
                }
                let _e1136 = local_25;
                bodyLevel = _e1136;
                let _e1137 = bodyLevel;
                param_145 = _e1137;
                let _e1138 = bhBodyRadius_u0028_u1_u003b((&param_145));
                bodyRadius = _e1138;
                let _e1139 = code_2;
                param_146 = _e1139;
                let _e1140 = bhDecode_u0028_u1_u003b((&param_146));
                center = (vec3<f32>(_e1140) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1143 = rayOrigin_3;
                let _e1144 = center;
                oc = (_e1143 - _e1144);
                let _e1146 = oc;
                let _e1147 = rayDir_3;
                b_3 = dot(_e1146, _e1147);
                let _e1149 = oc;
                let _e1150 = oc;
                let _e1152 = bodyRadius;
                let _e1153 = bodyRadius;
                c_4 = (dot(_e1149, _e1150) - (_e1152 * _e1153));
                let _e1156 = b_3;
                let _e1157 = b_3;
                let _e1159 = c_4;
                disc = ((_e1156 * _e1157) - _e1159);
                let _e1161 = disc;
                if (_e1161 <= 0f) {
                    continue;
                }
                let _e1163 = disc;
                sq = sqrt(_e1163);
                let _e1165 = b_3;
                let _e1167 = sq;
                tNear_1 = (-(_e1165) - _e1167);
                let _e1169 = b_3;
                let _e1171 = sq;
                tFar_1 = (-(_e1169) + _e1171);
                let _e1173 = tFar_1;
                if (_e1173 <= 0f) {
                    continue;
                }
                let _e1175 = tNear_1;
                bodyDist = max(0f, _e1175);
                let _e1177 = bodyDist;
                let _e1178 = finalDist;
                if (_e1177 < _e1178) {
                    let _e1180 = rayOrigin_3;
                    let _e1181 = rayDir_3;
                    let _e1182 = bodyDist;
                    let _e1185 = center;
                    surfaceNormal = normalize(((_e1180 + (_e1181 * _e1182)) - _e1185));
                    let _e1188 = surfaceNormal;
                    param_147 = _e1188;
                    let _e1189 = rayDir_3;
                    param_148 = _e1189;
                    let _e1190 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_147), (&param_148));
                    bodyColor = _e1190;
                    let _e1191 = bodyDist;
                    let _e1192 = MAX_VISIBILITY;
                    let _e1196 = bodyColor;
                    bodyColor = (_e1196 * mix(1f, 0f, clamp((_e1191 / _e1192), 0f, 1f)));
                    let _e1198 = bodyColor;
                    finalColor = vec4<f32>(_e1198.x, _e1198.y, _e1198.z, 1f);
                    let _e1203 = bodyDist;
                    finalDist = _e1203;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1204 = i_7;
                i_7 = (_e1204 + 1i);
            }
        }
    }
    let _e1207 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1207), 0f, 1f);
    let _e1210 = charge;
    cloudGreyness = _e1210;
    let _e1212 = unnamed.rainPhase;
    if (_e1212 == 1u) {
        let _e1215 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1215);
        let _e1217 = charge;
        let _e1219 = pc.time;
        let _e1220 = crossedTime;
        let _e1223 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1217, clamp(((_e1219 - _e1220) / _e1223), 0f, 1f));
    } else {
        let _e1228 = unnamed.rainPhase;
        if (_e1228 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1231 = tuning.cloudMaxAlpha;
    if (_e1231 > 0.002f) {
        let _e1234 = tuning.cloudColumnFullCount;
        let _e1237 = tuning.cloudThicknessPerBlock;
        slabMax = (max(_e1234, 1f) * max(_e1237, 0.01f));
        let _e1241 = unnamed.cloudMaxY;
        let _e1243 = slabMax;
        bandHi = (f32(_e1241) + _e1243);
        let _e1246 = unnamed.cloudMinY;
        let _e1249 = unnamed.cloudMaxY;
        let _e1251 = slabMax;
        let _e1255 = tuning.cloudVoxelSize;
        bandLo = (max(f32(_e1246), (f32(_e1249) - _e1251)) - max(_e1255, 1f));
        let _e1259 = unnamed.cloudMinY;
        let _e1261 = unnamed.cloudMaxY;
        if (_e1259 > _e1261) {
            local_26 = vec2<f32>(1f, -1f);
        } else {
            let _e1263 = bandLo;
            let _e1265 = worldExtent_u0028_();
            let _e1267 = bandHi;
            let _e1268 = worldExtent_u0028_();
            let _e1271 = rayOrigin_3;
            param_149 = _e1271;
            let _e1272 = rayDir_3;
            param_150 = _e1272;
            param_151 = vec3<f32>(0f, _e1263, 0f);
            param_152 = vec3<f32>(_e1265.x, _e1267, _e1268.z);
            let _e1273 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_149), (&param_150), (&param_151), (&param_152));
            local_26 = _e1273;
        }
        let _e1274 = local_26;
        cloudClip = _e1274;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1276 = cloudClip[0u];
        nearT = max(_e1276, 0f);
        let _e1279 = cloudClip[1u];
        let _e1280 = finalDist;
        farT = min(_e1279, _e1280);
        let _e1282 = nearT;
        let _e1283 = farT;
        if (_e1282 < _e1283) {
            let _e1285 = rayOrigin_3;
            param_153 = _e1285;
            let _e1286 = rayDir_3;
            param_154 = _e1286;
            let _e1287 = nearT;
            param_155 = _e1287;
            let _e1288 = farT;
            param_156 = _e1288;
            let _e1289 = cloudSunDir;
            param_157 = _e1289;
            let _e1290 = cloudGreyness;
            param_158 = _e1290;
            let _e1291 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b((&param_153), (&param_154), (&param_155), (&param_156), (&param_157), (&param_158), (&param_159), (&param_160), (&param_161));
            let _e1292 = param_159;
            cloudTHit = _e1292;
            let _e1293 = param_160;
            cloudColor = _e1293;
            let _e1294 = param_161;
            cloudDensity = _e1294;
            if _e1291 {
                let _e1295 = cloudTHit;
                if (_e1295 > 0f) {
                    let _e1297 = cloudTHit;
                    bestT = _e1297;
                    let _e1298 = cloudColor;
                    bestColor = _e1298;
                    let _e1300 = tuning.cloudMinAlpha;
                    let _e1302 = tuning.cloudMaxAlpha;
                    let _e1303 = cloudDensity;
                    bestAlpha = clamp(mix(_e1300, _e1302, _e1303), 0f, 0.95f);
                    foundCloud = true;
                }
            }
        }
        let _e1306 = foundCloud;
        let _e1307 = bestT;
        let _e1308 = finalDist;
        if (_e1306 && (_e1307 < _e1308)) {
            let _e1311 = finalColor;
            let _e1313 = bestColor;
            let _e1314 = bestAlpha;
            let _e1316 = mix(_e1311.xyz, _e1313, vec3(_e1314));
            finalColor[0u] = _e1316.x;
            finalColor[1u] = _e1316.y;
            finalColor[2u] = _e1316.z;
        }
    }
    let _e1324 = pc.spawnX;
    let _e1325 = (_e1324 >= 0i);
    phi_4245_ = _e1325;
    if _e1325 {
        let _e1327 = pc.spawnX;
        let _e1329 = tuning.gridWidth;
        phi_4245_ = (_e1327 < bitcast<i32>(_e1329));
    }
    let _e1333 = phi_4245_;
    phi_4252_ = _e1333;
    if _e1333 {
        let _e1335 = pc.spawnY;
        phi_4252_ = (_e1335 >= 0i);
    }
    let _e1338 = phi_4252_;
    phi_4261_ = _e1338;
    if _e1338 {
        let _e1340 = pc.spawnY;
        let _e1342 = tuning.gridHeight;
        phi_4261_ = (_e1340 < bitcast<i32>(_e1342));
    }
    let _e1346 = phi_4261_;
    phi_4267_ = _e1346;
    if _e1346 {
        let _e1348 = pc.spawnZ;
        phi_4267_ = (_e1348 >= 0i);
    }
    let _e1351 = phi_4267_;
    phi_4276_ = _e1351;
    if _e1351 {
        let _e1353 = pc.spawnZ;
        let _e1355 = tuning.gridDepth;
        phi_4276_ = (_e1353 < bitcast<i32>(_e1355));
    }
    let _e1359 = phi_4276_;
    if _e1359 {
        let _e1361 = pc.spawnSize;
        halfDistMin = (_e1361 / 2i);
        let _e1364 = pc.spawnSize;
        halfDistMax = ((_e1364 - 1i) / 2i);
        let _e1368 = pc.spawnX;
        let _e1369 = halfDistMin;
        let _e1373 = pc.spawnY;
        let _e1374 = halfDistMin;
        let _e1378 = pc.spawnZ;
        let _e1379 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1368 - _e1369)), f32((_e1373 - _e1374)), f32((_e1378 - _e1379)));
        let _e1384 = pc.spawnX;
        let _e1385 = halfDistMax;
        let _e1390 = pc.spawnY;
        let _e1391 = halfDistMax;
        let _e1396 = pc.spawnZ;
        let _e1397 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1384 + _e1385) + 1i)), f32(((_e1390 + _e1391) + 1i)), f32(((_e1396 + _e1397) + 1i)));
        let _e1403 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1406 = indexable_6[clamp(_e1403, 0i, 19i)];
        cursorColor = _e1406;
        let _e1408 = pc.spawnShape;
        if (_e1408 == 1i) {
            let _e1410 = boxMin_2;
            let _e1411 = boxMax_1;
            sphereCenter = ((_e1410 + _e1411) * 0.5f);
            let _e1415 = pc.spawnSize;
            sphereRadius = (f32(_e1415) * 0.5f);
            let _e1418 = rayOrigin_3;
            let _e1419 = sphereCenter;
            oc_1 = (_e1418 - _e1419);
            let _e1421 = oc_1;
            let _e1422 = rayDir_3;
            b_4 = dot(_e1421, _e1422);
            let _e1424 = oc_1;
            let _e1425 = oc_1;
            let _e1427 = sphereRadius;
            let _e1428 = sphereRadius;
            c_5 = (dot(_e1424, _e1425) - (_e1427 * _e1428));
            let _e1431 = b_4;
            let _e1432 = b_4;
            let _e1434 = c_5;
            disc_1 = ((_e1431 * _e1432) - _e1434);
            let _e1436 = disc_1;
            if (_e1436 > 0f) {
                let _e1438 = disc_1;
                sq_1 = sqrt(_e1438);
                let _e1440 = b_4;
                let _e1442 = sq_1;
                tNear_2 = (-(_e1440) - _e1442);
                let _e1444 = b_4;
                let _e1446 = sq_1;
                tFar_2 = (-(_e1444) + _e1446);
                let _e1448 = tFar_2;
                if (_e1448 > 0f) {
                    let _e1450 = tNear_2;
                    inside = (_e1450 <= 0f);
                    let _e1452 = inside;
                    let _e1453 = tFar_2;
                    let _e1454 = tNear_2;
                    cursorDist = select(_e1454, _e1453, _e1452);
                    let _e1456 = rayOrigin_3;
                    let _e1457 = rayDir_3;
                    let _e1458 = cursorDist;
                    let _e1461 = sphereCenter;
                    shellNormal = normalize(((_e1456 + (_e1457 * _e1458)) - _e1461));
                    let _e1464 = shellNormal;
                    let _e1465 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1464, _e1465)));
                    let _e1469 = rim_1;
                    let _e1472 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1469)) * select(1f, 0.35f, _e1472));
                    let _e1475 = cursorDist;
                    let _e1476 = finalDist;
                    if (_e1475 < _e1476) {
                        let _e1478 = finalColor;
                        let _e1480 = cursorColor;
                        let _e1481 = alpha;
                        let _e1483 = mix(_e1478.xyz, _e1480, vec3(_e1481));
                        finalColor[0u] = _e1483.x;
                        finalColor[1u] = _e1483.y;
                        finalColor[2u] = _e1483.z;
                    }
                }
            }
        } else {
            let _e1490 = rayOrigin_3;
            param_162 = _e1490;
            let _e1491 = rayDir_3;
            param_163 = _e1491;
            let _e1492 = boxMin_2;
            param_164 = _e1492;
            let _e1493 = boxMax_1;
            param_165 = _e1493;
            let _e1494 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_162), (&param_163), (&param_164), (&param_165));
            cursorHit = _e1494;
            let _e1496 = cursorHit[0u];
            let _e1498 = cursorHit[1u];
            let _e1499 = (_e1496 < _e1498);
            phi_4485_ = _e1499;
            if _e1499 {
                let _e1501 = cursorHit[1u];
                phi_4485_ = (_e1501 > 0f);
            }
            let _e1504 = phi_4485_;
            if _e1504 {
                let _e1506 = cursorHit[0u];
                distFront = max(0f, _e1506);
                let _e1509 = cursorHit[1u];
                distBack = _e1509;
                let _e1510 = rayOrigin_3;
                let _e1511 = rayDir_3;
                let _e1512 = distFront;
                hitPosFront = (_e1510 + (_e1511 * _e1512));
                let _e1515 = rayOrigin_3;
                let _e1516 = rayDir_3;
                let _e1517 = distBack;
                hitPosBack = (_e1515 + (_e1516 * _e1517));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1521 = hitPosFront[0u];
                let _e1523 = boxMin_2[0u];
                let _e1524 = e;
                let _e1526 = (_e1521 < (_e1523 + _e1524));
                phi_4527_ = _e1526;
                if !(_e1526) {
                    let _e1529 = hitPosFront[0u];
                    let _e1531 = boxMax_1[0u];
                    let _e1532 = e;
                    phi_4527_ = (_e1529 > (_e1531 - _e1532));
                }
                let _e1536 = phi_4527_;
                if _e1536 {
                    let _e1537 = edgesFront;
                    edgesFront = (_e1537 + 1i);
                }
                let _e1540 = hitPosFront[1u];
                let _e1542 = boxMin_2[1u];
                let _e1543 = e;
                let _e1545 = (_e1540 < (_e1542 + _e1543));
                phi_4549_ = _e1545;
                if !(_e1545) {
                    let _e1548 = hitPosFront[1u];
                    let _e1550 = boxMax_1[1u];
                    let _e1551 = e;
                    phi_4549_ = (_e1548 > (_e1550 - _e1551));
                }
                let _e1555 = phi_4549_;
                if _e1555 {
                    let _e1556 = edgesFront;
                    edgesFront = (_e1556 + 1i);
                }
                let _e1559 = hitPosFront[2u];
                let _e1561 = boxMin_2[2u];
                let _e1562 = e;
                let _e1564 = (_e1559 < (_e1561 + _e1562));
                phi_4571_ = _e1564;
                if !(_e1564) {
                    let _e1567 = hitPosFront[2u];
                    let _e1569 = boxMax_1[2u];
                    let _e1570 = e;
                    phi_4571_ = (_e1567 > (_e1569 - _e1570));
                }
                let _e1574 = phi_4571_;
                if _e1574 {
                    let _e1575 = edgesFront;
                    edgesFront = (_e1575 + 1i);
                }
                let _e1577 = edgesFront;
                if (_e1577 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1580 = hitPosBack[0u];
                let _e1582 = boxMin_2[0u];
                let _e1583 = e;
                let _e1585 = (_e1580 < (_e1582 + _e1583));
                phi_4599_ = _e1585;
                if !(_e1585) {
                    let _e1588 = hitPosBack[0u];
                    let _e1590 = boxMax_1[0u];
                    let _e1591 = e;
                    phi_4599_ = (_e1588 > (_e1590 - _e1591));
                }
                let _e1595 = phi_4599_;
                if _e1595 {
                    let _e1596 = edgesBack;
                    edgesBack = (_e1596 + 1i);
                }
                let _e1599 = hitPosBack[1u];
                let _e1601 = boxMin_2[1u];
                let _e1602 = e;
                let _e1604 = (_e1599 < (_e1601 + _e1602));
                phi_4621_ = _e1604;
                if !(_e1604) {
                    let _e1607 = hitPosBack[1u];
                    let _e1609 = boxMax_1[1u];
                    let _e1610 = e;
                    phi_4621_ = (_e1607 > (_e1609 - _e1610));
                }
                let _e1614 = phi_4621_;
                if _e1614 {
                    let _e1615 = edgesBack;
                    edgesBack = (_e1615 + 1i);
                }
                let _e1618 = hitPosBack[2u];
                let _e1620 = boxMin_2[2u];
                let _e1621 = e;
                let _e1623 = (_e1618 < (_e1620 + _e1621));
                phi_4643_ = _e1623;
                if !(_e1623) {
                    let _e1626 = hitPosBack[2u];
                    let _e1628 = boxMax_1[2u];
                    let _e1629 = e;
                    phi_4643_ = (_e1626 > (_e1628 - _e1629));
                }
                let _e1633 = phi_4643_;
                if _e1633 {
                    let _e1634 = edgesBack;
                    edgesBack = (_e1634 + 1i);
                }
                let _e1636 = edgesBack;
                if (_e1636 >= 2i) {
                    onBackEdge = true;
                }
                let _e1638 = onFrontEdge;
                let _e1639 = distFront;
                let _e1640 = finalDist;
                if (_e1638 && (_e1639 < _e1640)) {
                    let _e1643 = finalColor;
                    let _e1645 = cursorColor;
                    let _e1647 = mix(_e1643.xyz, _e1645, vec3(0.9f));
                    finalColor[0u] = _e1647.x;
                    finalColor[1u] = _e1647.y;
                    finalColor[2u] = _e1647.z;
                } else {
                    let _e1654 = onBackEdge;
                    let _e1655 = distBack;
                    let _e1656 = finalDist;
                    if (_e1654 && (_e1655 < _e1656)) {
                        let _e1659 = finalColor;
                        let _e1661 = cursorColor;
                        let _e1663 = mix(_e1659.xyz, _e1661, vec3(0.2f));
                        finalColor[0u] = _e1663.x;
                        finalColor[1u] = _e1663.y;
                        finalColor[2u] = _e1663.z;
                    } else {
                        let _e1670 = distFront;
                        let _e1671 = finalDist;
                        if (_e1670 < _e1671) {
                            let _e1673 = finalColor;
                            let _e1675 = cursorColor;
                            let _e1677 = mix(_e1673.xyz, _e1675, vec3(0.15f));
                            finalColor[0u] = _e1677.x;
                            finalColor[1u] = _e1677.y;
                            finalColor[2u] = _e1677.z;
                        }
                    }
                }
            }
        }
    }
    let _e1684 = hitFrontBox;
    if _e1684 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1685 = finalColor;
    outColor = _e1685;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
