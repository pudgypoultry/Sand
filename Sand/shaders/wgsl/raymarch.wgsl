// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 02568915f28ac2b861499c6886de91e0259a61a4d0b34173ddd16239212f396d

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
    waterSpecPower: f32,
    waterSpecStrength: f32,
    waterNormalFlatten: f32,
    waterDiffuseFlatten: f32,
    waterShadowFloor: f32,
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
    cloudBlocksPerLevel: f32,
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
    cloudHeightLevels: f32,
    cloudUpdateInterval: f32,
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
    cloudPeakColumnAcc: u32,
    cloudPeakColumn: u32,
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
    let _e273 = (*p);
    return fract((sin(dot(_e273, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn cloudDeckBaseY_u0028_() -> f32 {
    let _e273 = tuning.gridHeight;
    return f32(bitcast<i32>(_e273));
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x: ptr<function, i32>, z: ptr<function, i32>) -> u32 {
    let _e274 = (*x);
    let _e275 = (*z);
    let _e277 = tuning.gridWidth;
    return (bitcast<u32>((_e274 + (_e275 * bitcast<i32>(_e277)))) * 4u);
}

fn sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b(x_1: ptr<function, i32>, z_1: ptr<function, i32>, count: ptr<function, f32>) {
    var b: u32;
    var param: i32;
    var param_1: i32;
    var d: f32;
    var fx: f32;
    var fz: f32;
    var phi_2439_: bool;
    var phi_2451_: bool;

    let _e281 = (*x_1);
    let _e282 = (_e281 < 0i);
    phi_2439_ = _e282;
    if !(_e282) {
        let _e284 = (*x_1);
        let _e286 = tuning.gridWidth;
        phi_2439_ = (_e284 >= bitcast<i32>(_e286));
    }
    let _e290 = phi_2439_;
    let _e291 = (*z_1);
    let _e293 = (_e290 || (_e291 < 0i));
    phi_2451_ = _e293;
    if !(_e293) {
        let _e295 = (*z_1);
        let _e297 = tuning.gridDepth;
        phi_2451_ = (_e295 >= bitcast<i32>(_e297));
    }
    let _e301 = phi_2451_;
    if _e301 {
        (*count) = 0f;
        return;
    }
    let _e302 = (*x_1);
    param = _e302;
    let _e303 = (*z_1);
    param_1 = _e303;
    let _e304 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param), (&param_1));
    b = _e304;
    let _e305 = b;
    let _e309 = unnamed.cloudColumn[(_e305 + 2u)];
    (*count) = (f32(_e309) * 0.0625f);
    let _e313 = tuning.cloudEdgeFadeDist;
    d = max(_e313, 0.001f);
    let _e315 = d;
    let _e316 = (*x_1);
    let _e319 = d;
    let _e321 = tuning.gridWidth;
    let _e324 = (*x_1);
    fx = (smoothstep(0f, _e315, f32(_e316)) * smoothstep(0f, _e319, f32(((bitcast<i32>(_e321) - 1i) - _e324))));
    let _e329 = d;
    let _e330 = (*z_1);
    let _e333 = d;
    let _e335 = tuning.gridDepth;
    let _e338 = (*z_1);
    fz = (smoothstep(0f, _e329, f32(_e330)) * smoothstep(0f, _e333, f32(((bitcast<i32>(_e335) - 1i) - _e338))));
    let _e343 = fx;
    let _e344 = fz;
    let _e346 = (*count);
    (*count) = (_e346 * (_e343 * _e344));
    return;
}

fn smoothedCloudColumn_u0028_i1_u003b_i1_u003b_i1_u003b(x_2: ptr<function, i32>, z_2: ptr<function, i32>, spread: ptr<function, i32>) -> f32 {
    var c0_: f32;
    var param_2: i32;
    var param_3: i32;
    var param_4: f32;
    var c1_: f32;
    var param_5: i32;
    var param_6: i32;
    var param_7: f32;
    var c2_: f32;
    var param_8: i32;
    var param_9: i32;
    var param_10: f32;
    var c3_: f32;
    var param_11: i32;
    var param_12: i32;
    var param_13: f32;
    var c4_: f32;
    var param_14: i32;
    var param_15: i32;
    var param_16: f32;

    let _e295 = (*x_2);
    param_2 = _e295;
    let _e296 = (*z_2);
    param_3 = _e296;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b((&param_2), (&param_3), (&param_4));
    let _e297 = param_4;
    c0_ = _e297;
    let _e298 = (*x_2);
    let _e299 = (*spread);
    param_5 = (_e298 - _e299);
    let _e301 = (*z_2);
    param_6 = _e301;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b((&param_5), (&param_6), (&param_7));
    let _e302 = param_7;
    c1_ = _e302;
    let _e303 = (*x_2);
    let _e304 = (*spread);
    param_8 = (_e303 + _e304);
    let _e306 = (*z_2);
    param_9 = _e306;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b((&param_8), (&param_9), (&param_10));
    let _e307 = param_10;
    c2_ = _e307;
    let _e308 = (*z_2);
    let _e309 = (*spread);
    let _e311 = (*x_2);
    param_11 = _e311;
    param_12 = (_e308 - _e309);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b((&param_11), (&param_12), (&param_13));
    let _e312 = param_13;
    c3_ = _e312;
    let _e313 = (*z_2);
    let _e314 = (*spread);
    let _e316 = (*x_2);
    param_14 = _e316;
    param_15 = (_e313 + _e314);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b((&param_14), (&param_15), (&param_16));
    let _e317 = param_16;
    c4_ = _e317;
    let _e318 = c0_;
    let _e320 = c1_;
    let _e322 = c2_;
    let _e324 = c3_;
    let _e326 = c4_;
    return ((((((_e318 * 2f) + _e320) + _e322) + _e324) + _e326) / 6f);
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
    var count_1: f32;
    var param_17: i32;
    var param_18: i32;
    var param_19: i32;
    var cell: f32;
    var cells: f32;
    var baseY: f32;
    var thickness: f32;
    var capY: f32;
    var density: f32;
    var mid: f32;
    var edgeFactor: f32;
    var threshold: f32;
    var fillHash: f32;
    var param_20: vec3<f32>;
    var shadeHash: f32;
    var param_21: vec3<f32>;
    var baseColor: vec3<f32>;
    var stormColor: vec3<f32>;
    var diffuse: f32;
    var phi_2771_: bool;
    var phi_2782_: bool;
    var phi_2828_: bool;

    let _e320 = (*tEnter);
    (*tEnter) = max(_e320, 0f);
    let _e322 = (*tEnter);
    let _e323 = (*tExit);
    if (_e322 >= _e323) {
        return false;
    }
    let _e325 = (*rayOrigin);
    let _e326 = (*rayDir);
    let _e327 = (*tEnter);
    startPos = (_e325 + (_e326 * _e327));
    let _e330 = startPos;
    let _e332 = tuning.cloudVoxelSize;
    cellPos = vec3<i32>(floor((_e330 / vec3(_e332))));
    let _e337 = (*rayDir);
    stepDir = vec3<i32>(sign(_e337));
    let _e341 = (*rayDir)[0u];
    if (_e341 == 0f) {
        local = 100000000f;
    } else {
        let _e344 = tuning.cloudVoxelSize;
        let _e346 = (*rayDir)[0u];
        local = abs((_e344 / _e346));
    }
    let _e349 = local;
    let _e351 = (*rayDir)[1u];
    if (_e351 == 0f) {
        local_1 = 100000000f;
    } else {
        let _e354 = tuning.cloudVoxelSize;
        let _e356 = (*rayDir)[1u];
        local_1 = abs((_e354 / _e356));
    }
    let _e359 = local_1;
    let _e361 = (*rayDir)[2u];
    if (_e361 == 0f) {
        local_2 = 100000000f;
    } else {
        let _e364 = tuning.cloudVoxelSize;
        let _e366 = (*rayDir)[2u];
        local_2 = abs((_e364 / _e366));
    }
    let _e369 = local_2;
    tDelta = vec3<f32>(_e349, _e359, _e369);
    let _e371 = startPos;
    let _e373 = tuning.cloudVoxelSize;
    let _e376 = cellPos;
    fracPos = ((_e371 / vec3(_e373)) - vec3<f32>(_e376));
    let _e379 = (*tEnter);
    let _e381 = stepDir[0u];
    if (_e381 > 0i) {
        let _e384 = fracPos[0u];
        let _e387 = tDelta[0u];
        local_3 = ((1f - _e384) * _e387);
    } else {
        let _e390 = fracPos[0u];
        let _e392 = tDelta[0u];
        local_3 = (_e390 * _e392);
    }
    let _e394 = local_3;
    let _e396 = stepDir[1u];
    if (_e396 > 0i) {
        let _e399 = fracPos[1u];
        let _e402 = tDelta[1u];
        local_4 = ((1f - _e399) * _e402);
    } else {
        let _e405 = fracPos[1u];
        let _e407 = tDelta[1u];
        local_4 = (_e405 * _e407);
    }
    let _e409 = local_4;
    let _e411 = stepDir[2u];
    if (_e411 > 0i) {
        let _e414 = fracPos[2u];
        let _e417 = tDelta[2u];
        local_5 = ((1f - _e414) * _e417);
    } else {
        let _e420 = fracPos[2u];
        let _e422 = tDelta[2u];
        local_5 = (_e420 * _e422);
    }
    let _e424 = local_5;
    tMax = (vec3(_e379) + vec3<f32>(_e394, _e409, _e424));
    normal = vec3<f32>(0f, 1f, 0f);
    let _e428 = (*tEnter);
    t = _e428;
    let _e430 = tuning.cloudVoxelSize;
    spread_1 = max(1i, i32(_e430));
    i = 0i;
    loop {
        let _e433 = i;
        let _e435 = tuning.maxCloudSteps;
        if (_e433 < bitcast<i32>(_e435)) {
            let _e438 = t;
            let _e439 = (*tExit);
            if (_e438 > _e439) {
                break;
            }
            let _e441 = cellPos;
            let _e446 = tuning.cloudVoxelSize;
            cellCenter = ((vec3<f32>(_e441) + vec3(0.5f)) * _e446);
            let _e449 = cellCenter[0u];
            cx = i32(floor(_e449));
            let _e453 = cellCenter[2u];
            cz = i32(floor(_e453));
            let _e456 = cx;
            let _e457 = (_e456 >= 0i);
            phi_2771_ = _e457;
            if _e457 {
                let _e458 = cx;
                let _e460 = tuning.gridWidth;
                phi_2771_ = (_e458 < bitcast<i32>(_e460));
            }
            let _e464 = phi_2771_;
            let _e465 = cz;
            let _e467 = (_e464 && (_e465 >= 0i));
            phi_2782_ = _e467;
            if _e467 {
                let _e468 = cz;
                let _e470 = tuning.gridDepth;
                phi_2782_ = (_e468 < bitcast<i32>(_e470));
            }
            let _e474 = phi_2782_;
            if _e474 {
                let _e475 = cx;
                param_17 = _e475;
                let _e476 = cz;
                param_18 = _e476;
                let _e477 = spread_1;
                param_19 = _e477;
                let _e478 = smoothedCloudColumn_u0028_i1_u003b_i1_u003b_i1_u003b((&param_17), (&param_18), (&param_19));
                count_1 = _e478;
                let _e479 = count_1;
                if (_e479 > 0f) {
                    let _e482 = tuning.cloudVoxelSize;
                    cell = max(_e482, 0.5f);
                    let _e484 = count_1;
                    let _e485 = cell;
                    cells = max(1f, floor(((_e484 / _e485) + 0.5f)));
                    let _e490 = cloudDeckBaseY_u0028_();
                    baseY = _e490;
                    let _e491 = cells;
                    let _e492 = cell;
                    thickness = (_e491 * _e492);
                    let _e494 = baseY;
                    let _e495 = thickness;
                    capY = (_e494 + _e495);
                    let _e498 = cellCenter[1u];
                    let _e499 = baseY;
                    let _e500 = (_e498 >= _e499);
                    phi_2828_ = _e500;
                    if _e500 {
                        let _e502 = cellCenter[1u];
                        let _e503 = capY;
                        phi_2828_ = (_e502 <= _e503);
                    }
                    let _e506 = phi_2828_;
                    if _e506 {
                        let _e507 = count_1;
                        let _e509 = tuning.cloudColumnFullCount;
                        density = clamp((_e507 / max(_e509, 1f)), 0f, 1f);
                        let _e513 = baseY;
                        let _e514 = capY;
                        mid = ((_e513 + _e514) * 0.5f);
                        let _e518 = cellCenter[1u];
                        let _e519 = mid;
                        let _e522 = thickness;
                        edgeFactor = clamp((abs((_e518 - _e519)) / max((_e522 * 0.5f), 0.001f)), 0f, 1f);
                        let _e528 = tuning.cloudEdgeThresholdMin;
                        let _e530 = tuning.cloudEdgeThresholdMax;
                        let _e531 = edgeFactor;
                        threshold = mix(_e528, _e530, _e531);
                        let _e533 = cellPos;
                        param_20 = vec3<f32>(_e533);
                        let _e535 = hash_u0028_vf3_u003b((&param_20));
                        fillHash = _e535;
                        let _e536 = fillHash;
                        let _e537 = threshold;
                        if (_e536 > _e537) {
                            let _e539 = t;
                            (*tHit) = _e539;
                            let _e540 = density;
                            (*hitDensity) = _e540;
                            let _e541 = cellPos;
                            param_21 = ((vec3<f32>(_e541) * 3.71f) + vec3<f32>(91f, 5f, 7f));
                            let _e545 = hash_u0028_vf3_u003b((&param_21));
                            shadeHash = _e545;
                            let _e546 = shadeHash;
                            baseColor = mix(vec3<f32>(0.9f, 0.91f, 0.94f), vec3<f32>(1f, 1f, 1f), vec3(_e546));
                            stormColor = vec3<f32>(0.32f, 0.33f, 0.36f);
                            let _e549 = baseColor;
                            let _e550 = stormColor;
                            let _e551 = (*greyness);
                            baseColor = mix(_e549, _e550, vec3(_e551));
                            let _e554 = normal;
                            let _e555 = (*sunDir);
                            diffuse = (0.6f + (0.4f * max(dot(_e554, _e555), 0f)));
                            let _e560 = baseColor;
                            let _e561 = diffuse;
                            (*hitColor) = (_e560 * _e561);
                            return true;
                        }
                    }
                }
            }
            let _e564 = tMax[0u];
            let _e566 = tMax[1u];
            if (_e564 < _e566) {
                let _e569 = tMax[0u];
                let _e571 = tMax[2u];
                if (_e569 < _e571) {
                    let _e574 = stepDir[0u];
                    let _e576 = cellPos[0u];
                    cellPos[0u] = (_e576 + _e574);
                    let _e580 = tMax[0u];
                    t = _e580;
                    let _e582 = tDelta[0u];
                    let _e584 = tMax[0u];
                    tMax[0u] = (_e584 + _e582);
                    let _e588 = stepDir[0u];
                    normal = vec3<f32>(f32(-(_e588)), 0f, 0f);
                } else {
                    let _e593 = stepDir[2u];
                    let _e595 = cellPos[2u];
                    cellPos[2u] = (_e595 + _e593);
                    let _e599 = tMax[2u];
                    t = _e599;
                    let _e601 = tDelta[2u];
                    let _e603 = tMax[2u];
                    tMax[2u] = (_e603 + _e601);
                    let _e607 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e607)));
                }
            } else {
                let _e612 = tMax[1u];
                let _e614 = tMax[2u];
                if (_e612 < _e614) {
                    let _e617 = stepDir[1u];
                    let _e619 = cellPos[1u];
                    cellPos[1u] = (_e619 + _e617);
                    let _e623 = tMax[1u];
                    t = _e623;
                    let _e625 = tDelta[1u];
                    let _e627 = tMax[1u];
                    tMax[1u] = (_e627 + _e625);
                    let _e631 = stepDir[1u];
                    normal = vec3<f32>(0f, f32(-(_e631)), 0f);
                } else {
                    let _e636 = stepDir[2u];
                    let _e638 = cellPos[2u];
                    cellPos[2u] = (_e638 + _e636);
                    let _e642 = tMax[2u];
                    t = _e642;
                    let _e644 = tDelta[2u];
                    let _e646 = tMax[2u];
                    tMax[2u] = (_e646 + _e644);
                    let _e650 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e650)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e654 = i;
            i = (_e654 + 1i);
        }
    }
    return false;
}

fn renderBlackHole_u0028_vf3_u003b_vf3_u003b(normal_1: ptr<function, vec3<f32>>, rayDir_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var rim: f32;
    var glow: f32;

    let _e276 = (*normal_1);
    let _e277 = (*rayDir_1);
    rim = (1f - abs(dot(_e276, _e277)));
    let _e281 = rim;
    glow = pow(clamp(_e281, 0f, 1f), 4f);
    let _e284 = glow;
    return mix(vec3<f32>(0.01f, 0.01f, 0.02f), vec3<f32>(0.85f, 0.45f, 1f), vec3((_e284 * 0.7f)));
}

fn bhDecode_u0028_u1_u003b(code: ptr<function, u32>) -> vec3<i32> {
    var i_1: u32;

    let _e274 = (*code);
    i_1 = (_e274 & 1073741823u);
    let _e276 = i_1;
    let _e278 = tuning.gridWidth;
    let _e283 = i_1;
    let _e285 = tuning.gridWidth;
    let _e290 = tuning.gridHeight;
    let _e295 = i_1;
    let _e297 = tuning.gridWidth;
    let _e300 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e276 % bitcast<u32>(bitcast<i32>(_e278)))), bitcast<i32>(((_e283 / bitcast<u32>(bitcast<i32>(_e285))) % bitcast<u32>(bitcast<i32>(_e290)))), bitcast<i32>((_e295 / bitcast<u32>((bitcast<i32>(_e297) * bitcast<i32>(_e300))))));
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e273 = (*level);
    return (f32(_e273) + 0.5f);
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_1: u32;
    var l: u32;
    var r: f32;
    var param_22: u32;
    var volume: f32;

    level_1 = 0u;
    l = 1u;
    loop {
        let _e278 = l;
        let _e280 = tuning.blackHoleMaxLevel;
        if (_e278 <= min(_e280, 16u)) {
            let _e283 = l;
            param_22 = _e283;
            let _e284 = bhBodyRadius_u0028_u1_u003b((&param_22));
            r = _e284;
            let _e285 = r;
            let _e287 = r;
            let _e289 = r;
            volume = (((4.18879f * _e285) * _e287) * _e289);
            let _e291 = (*mass);
            let _e294 = tuning.blackHoleGrowthCost;
            let _e295 = volume;
            if (f32(_e291) < (_e294 * _e295)) {
                break;
            }
            let _e298 = l;
            level_1 = _e298;
            continue;
        } else {
            break;
        }
        continuing {
            let _e299 = l;
            l = (_e299 + bitcast<u32>(1i));
        }
    }
    let _e302 = level_1;
    return _e302;
}

fn accretionGlow_u0028_vf3_u003b_vi3_u003b(color: ptr<function, vec3<f32>>, voxelPos: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radius: f32;
    var closestSq: f32;
    var seen: u32;
    var i_2: i32;
    var code_1: u32;
    var d_1: vec3<f32>;
    var param_23: u32;
    var closest: f32;
    var heat: f32;
    var hot: vec3<f32>;
    var phi_2324_: bool;
    var phi_2353_: bool;

    let _e285 = unnamed.blackHoleCount;
    let _e286 = (_e285 == 0u);
    phi_2324_ = _e286;
    if !(_e286) {
        let _e289 = tuning.blackHoleGlow;
        phi_2324_ = (_e289 <= 0f);
    }
    let _e292 = phi_2324_;
    if _e292 {
        let _e293 = (*color);
        return _e293;
    }
    let _e295 = tuning.blackHoleRadius;
    radius = f32(_e295);
    let _e297 = radius;
    let _e298 = radius;
    closestSq = (_e297 * _e298);
    seen = 0u;
    i_2 = 0i;
    loop {
        let _e300 = i_2;
        let _e301 = (_e300 < 8i);
        phi_2353_ = _e301;
        if _e301 {
            let _e302 = seen;
            let _e304 = unnamed.blackHoleCount;
            phi_2353_ = (_e302 < _e304);
        }
        let _e307 = phi_2353_;
        if _e307 {
            let _e308 = i_2;
            let _e311 = unnamed.blackHoles[_e308];
            code_1 = _e311;
            let _e312 = code_1;
            if (_e312 == 0u) {
                continue;
            }
            let _e314 = seen;
            seen = (_e314 + bitcast<u32>(1i));
            let _e317 = code_1;
            param_23 = _e317;
            let _e318 = bhDecode_u0028_u1_u003b((&param_23));
            let _e319 = (*voxelPos);
            d_1 = vec3<f32>((_e318 - _e319));
            let _e322 = closestSq;
            let _e323 = d_1;
            let _e324 = d_1;
            closestSq = min(_e322, dot(_e323, _e324));
            continue;
        } else {
            break;
        }
        continuing {
            let _e327 = i_2;
            i_2 = (_e327 + 1i);
        }
    }
    let _e329 = closestSq;
    let _e330 = radius;
    let _e331 = radius;
    if (_e329 >= (_e330 * _e331)) {
        let _e334 = (*color);
        return _e334;
    }
    let _e335 = closestSq;
    closest = sqrt(_e335);
    let _e337 = closest;
    let _e338 = radius;
    let _e343 = tuning.blackHoleGlow;
    heat = (pow((1f - (_e337 / _e338)), 3f) * _e343);
    let _e345 = heat;
    hot = mix(vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(1f, 0.95f, 0.85f), vec3(clamp(_e345, 0f, 1f)));
    let _e349 = (*color);
    let _e350 = hot;
    let _e351 = heat;
    return mix(_e349, _e350, vec3(clamp(_e351, 0f, 1f)));
}

fn renderAsh_u0028_vi3_u003b_vf3_u003b(voxelPos_1: ptr<function, vec3<i32>>, baseLighting: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n: f32;
    var param_24: vec3<f32>;
    var c: vec3<f32>;

    let _e277 = (*voxelPos_1);
    param_24 = vec3<f32>(_e277);
    let _e279 = hash_u0028_vf3_u003b((&param_24));
    n = _e279;
    let _e280 = n;
    c = mix(vec3<f32>(0.2f, 0.19f, 0.18f), vec3<f32>(0.47f, 0.45f, 0.42f), vec3(_e280));
    let _e283 = c;
    let _e284 = (*baseLighting);
    return (_e283 * _e284);
}

fn renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b(rawVoxel: ptr<function, u32>, voxelPos_2: ptr<function, vec3<i32>>, baseLighting_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_1: f32;
    var param_25: vec3<f32>;
    var dist: u32;
    var depth: f32;
    var inner: vec3<f32>;
    var outer: vec3<f32>;
    var leaf: vec3<f32>;

    let _e282 = (*voxelPos_2);
    param_25 = vec3<f32>(_e282);
    let _e284 = hash_u0028_vf3_u003b((&param_25));
    n_1 = _e284;
    let _e285 = (*rawVoxel);
    dist = ((_e285 >> bitcast<u32>(24i)) & 255u);
    let _e289 = dist;
    if (_e289 == 255u) {
        let _e291 = n_1;
        let _e294 = (*baseLighting_1);
        return (mix(vec3<f32>(0.34f, 0.22f, 0.07f), vec3<f32>(0.52f, 0.38f, 0.12f), vec3(_e291)) * _e294);
    }
    let _e296 = dist;
    let _e299 = tuning.treeLeafReach;
    depth = clamp((f32(_e296) / max(f32(_e299), 1f)), 0f, 1f);
    inner = vec3<f32>(0.1f, 0.3f, 0.09f);
    outer = vec3<f32>(0.28f, 0.52f, 0.16f);
    let _e304 = inner;
    let _e305 = outer;
    let _e306 = depth;
    let _e308 = n_1;
    leaf = mix(_e304, _e305, vec3(((_e306 * 0.7f) + (_e308 * 0.3f))));
    let _e313 = leaf;
    let _e314 = (*baseLighting_1);
    return (_e313 * _e314);
}

fn renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_3: ptr<function, vec3<i32>>, subCell: ptr<function, vec3<f32>>, baseLighting_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var grain: f32;
    var param_26: vec3<f32>;
    var bark: vec3<f32>;

    let _e279 = (*voxelPos_3)[0u];
    let _e282 = (*voxelPos_3)[1u];
    let _e286 = (*subCell)[1u];
    let _e290 = (*voxelPos_3)[2u];
    param_26 = vec3<f32>(f32(_e279), ((f32(_e282) * 0.35f) + (_e286 * 0.2f)), f32(_e290));
    let _e293 = hash_u0028_vf3_u003b((&param_26));
    grain = _e293;
    let _e294 = grain;
    bark = mix(vec3<f32>(0.2f, 0.13f, 0.07f), vec3<f32>(0.38f, 0.25f, 0.13f), vec3(_e294));
    let _e297 = bark;
    let _e298 = (*baseLighting_2);
    return (_e297 * _e298);
}

fn renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_4: ptr<function, vec3<i32>>, subCell_1: ptr<function, vec3<f32>>, baseLighting_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_2: f32;
    var param_27: vec3<f32>;
    var shell: vec3<f32>;

    let _e278 = (*subCell_1);
    let _e280 = (*voxelPos_4);
    param_27 = ((_e278 * 1.37f) + (vec3<f32>(_e280) * 0.11f));
    let _e284 = hash_u0028_vf3_u003b((&param_27));
    n_2 = _e284;
    let _e285 = n_2;
    shell = mix(vec3<f32>(0.15f, 0.1f, 0.035f), vec3<f32>(0.55f, 0.4f, 0.11f), vec3(_e285));
    let _e288 = shell;
    let _e289 = (*baseLighting_3);
    return (_e288 * _e289);
}

fn renderDarkStone_u0028_vi3_u003b_vf3_u003b(voxelPos_5: ptr<function, vec3<i32>>, baseLighting_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise: f32;
    var param_28: vec3<f32>;
    var val: f32;

    let _e277 = (*voxelPos_5);
    param_28 = vec3<f32>(_e277);
    let _e279 = hash_u0028_vf3_u003b((&param_28));
    noise = _e279;
    let _e280 = noise;
    val = (0.1f + (_e280 * 0.06f));
    let _e283 = val;
    let _e285 = val;
    let _e287 = val;
    let _e290 = (*baseLighting_4);
    return (vec3<f32>((_e283 * 1.08f), (_e285 * 0.94f), (_e287 * 0.92f)) * _e290);
}

fn lavaStageColor_u0028_i1_u003b(stage: ptr<function, i32>) -> vec3<f32> {
    var indexable: array<vec3<f32>, 6>;

    let _e274 = (*stage);
    indexable = array<vec3<f32>, 6>(vec3<f32>(1f, 0.62f, 0.22f), vec3<f32>(1f, 0.4f, 0.07f), vec3<f32>(0.96f, 0.29f, 0.05f), vec3<f32>(0.86f, 0.2f, 0.04f), vec3<f32>(0.7f, 0.13f, 0.03f), vec3<f32>(0.44f, 0.07f, 0.02f));
    let _e278 = indexable[clamp((_e274 + 1i), 0i, 5i)];
    return _e278;
}

fn renderLava_u0028_u1_u003b_vi3_u003b(rawVoxel_1: ptr<function, u32>, voxelPos_6: ptr<function, vec3<i32>>) -> vec3<f32> {
    var stage_1: i32;
    var phase: f32;
    var param_29: vec3<f32>;
    var from_: vec3<f32>;
    var param_30: i32;
    var to: vec3<f32>;
    var param_31: i32;
    var leg: f32;
    var param_32: i32;
    var param_33: i32;
    var param_34: i32;
    var param_35: i32;
    var molten: vec3<f32>;
    var param_36: vec3<f32>;

    let _e288 = (*rawVoxel_1);
    stage_1 = clamp((bitcast<i32>((_e288 & 255u)) - 8i), 0i, 3i);
    let _e294 = pc.time;
    let _e296 = tuning.lavaChurnRate;
    let _e298 = (*voxelPos_6);
    param_29 = vec3<f32>(_e298);
    let _e300 = hash_u0028_vf3_u003b((&param_29));
    phase = fract(((_e294 * _e296) + _e300));
    let _e303 = phase;
    if (_e303 < 0.33333334f) {
        let _e305 = stage_1;
        param_30 = (_e305 - 1i);
        let _e307 = lavaStageColor_u0028_i1_u003b((&param_30));
        from_ = _e307;
        let _e308 = stage_1;
        param_31 = _e308;
        let _e309 = lavaStageColor_u0028_i1_u003b((&param_31));
        to = _e309;
        let _e310 = phase;
        leg = (_e310 * 3f);
    } else {
        let _e312 = phase;
        if (_e312 < 0.6666667f) {
            let _e314 = stage_1;
            param_32 = _e314;
            let _e315 = lavaStageColor_u0028_i1_u003b((&param_32));
            from_ = _e315;
            let _e316 = stage_1;
            param_33 = (_e316 + 1i);
            let _e318 = lavaStageColor_u0028_i1_u003b((&param_33));
            to = _e318;
            let _e319 = phase;
            leg = ((_e319 * 3f) - 1f);
        } else {
            let _e322 = stage_1;
            param_34 = (_e322 + 1i);
            let _e324 = lavaStageColor_u0028_i1_u003b((&param_34));
            from_ = _e324;
            let _e325 = stage_1;
            param_35 = (_e325 - 1i);
            let _e327 = lavaStageColor_u0028_i1_u003b((&param_35));
            to = _e327;
            let _e328 = phase;
            leg = ((_e328 * 3f) - 2f);
        }
    }
    let _e331 = from_;
    let _e332 = to;
    let _e333 = leg;
    molten = mix(_e331, _e332, vec3(smoothstep(0f, 1f, _e333)));
    let _e337 = molten;
    let _e338 = (*voxelPos_6);
    param_36 = (vec3<f32>(_e338) * 1.7f);
    let _e341 = hash_u0028_vf3_u003b((&param_36));
    return (_e337 * (0.9f + (_e341 * 0.1f)));
}

fn renderSteam_u0028_vi3_u003b_vf3_u003b(voxelPos_7: ptr<function, vec3<i32>>, baseLighting_5: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_1: f32;
    var param_37: vec3<f32>;
    var val_1: f32;
    var baseColor_1: vec3<f32>;

    let _e278 = (*voxelPos_7);
    let _e281 = pc.time;
    param_37 = (vec3<f32>(_e278) + vec3(_e281));
    let _e284 = hash_u0028_vf3_u003b((&param_37));
    noise_1 = _e284;
    let _e285 = noise_1;
    val_1 = (0.85f + (_e285 * 0.15f));
    let _e288 = val_1;
    baseColor_1 = vec3(_e288);
    let _e290 = baseColor_1;
    let _e291 = (*baseLighting_5);
    return ((_e290 * _e291) * 0.9f);
}

fn renderFire_u0028_u1_u003b_vi3_u003b(rawVoxel_2: ptr<function, u32>, voxelPos_8: ptr<function, vec3<i32>>) -> vec3<f32> {
    var noise_2: f32;
    var param_38: vec3<f32>;
    var age: u32;
    var life: f32;
    var coreColor: vec3<f32>;
    var edgeColor: vec3<f32>;
    var fireColor: vec3<f32>;

    let _e281 = (*voxelPos_8);
    let _e284 = pc.time;
    param_38 = (vec3<f32>(_e281) + vec3((_e284 * 10f)));
    let _e288 = hash_u0028_vf3_u003b((&param_38));
    noise_2 = _e288;
    let _e289 = (*rawVoxel_2);
    age = ((_e289 >> bitcast<u32>(24i)) & 255u);
    let _e293 = age;
    life = clamp((f32(_e293) / 30f), 0f, 1f);
    coreColor = vec3<f32>(1f, 0.9f, 0.2f);
    edgeColor = vec3<f32>(1f, 0.3f, 0f);
    let _e297 = coreColor;
    let _e298 = edgeColor;
    let _e299 = life;
    let _e300 = noise_2;
    fireColor = mix(_e297, _e298, vec3((_e299 + (_e300 * 0.3f))));
    let _e305 = fireColor;
    return (_e305 * 1.5f);
}

fn renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b(rawVoxel_3: ptr<function, u32>, voxelPos_9: ptr<function, vec3<i32>>, ddaNormal: ptr<function, vec3<f32>>, baseLighting_6: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_3: f32;
    var param_39: vec3<f32>;
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
    var phi_1306_: bool;

    let _e288 = (*voxelPos_9);
    param_39 = vec3<f32>(_e288);
    let _e290 = hash_u0028_vf3_u003b((&param_39));
    noise_3 = _e290;
    let _e291 = noise_3;
    val_2 = (0.8f + (_e291 * 0.2f));
    let _e294 = (*rawVoxel_3);
    moisture = ((_e294 >> bitcast<u32>(24i)) & 255u);
    let _e298 = moisture;
    wetness = clamp((f32(_e298) / 30f), 0f, 1f);
    let _e302 = val_2;
    let _e304 = val_2;
    let _e306 = val_2;
    dryColor = vec3<f32>((0.4f * _e302), (0.25f * _e304), (0.1f * _e306));
    let _e309 = val_2;
    let _e311 = val_2;
    let _e313 = val_2;
    wetColor = vec3<f32>((0.15f * _e309), (0.08f * _e311), (0.03f * _e313));
    let _e316 = dryColor;
    let _e317 = wetColor;
    let _e318 = wetness;
    baseColor_2 = mix(_e316, _e317, vec3(_e318));
    let _e321 = (*rawVoxel_3);
    floraState = ((_e321 >> bitcast<u32>(8i)) & 255u);
    let _e325 = floraState;
    let _e326 = (_e325 > 10u);
    phi_1306_ = _e326;
    if _e326 {
        let _e328 = (*ddaNormal)[1u];
        phi_1306_ = (_e328 > 0.5f);
    }
    let _e331 = phi_1306_;
    if _e331 {
        let _e332 = floraState;
        grassGrow = clamp((f32((_e332 - 10u)) / 90f), 0f, 1f);
        let _e337 = noise_3;
        let _e340 = noise_3;
        grassColor = vec3<f32>((0.15f + (_e337 * 0.1f)), (0.45f + (_e340 * 0.15f)), 0.15f);
        let _e344 = floraState;
        if (_e344 > 100u) {
            let _e346 = floraState;
            drown = clamp((f32((_e346 - 100u)) / 100f), 0f, 1f);
            let _e351 = grassColor;
            let _e352 = drown;
            grassColor = mix(_e351, vec3<f32>(0.35f, 0.35f, 0.15f), vec3(_e352));
        }
        let _e355 = baseColor_2;
        let _e356 = grassColor;
        let _e357 = grassGrow;
        baseColor_2 = mix(_e355, _e356, vec3(_e357));
    }
    let _e360 = baseColor_2;
    let _e361 = (*baseLighting_6);
    return (_e360 * _e361);
}

fn renderStone_u0028_vi3_u003b_vf3_u003b(voxelPos_10: ptr<function, vec3<i32>>, baseLighting_7: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_4: f32;
    var param_40: vec3<f32>;
    var val_3: f32;
    var baseColor_3: vec3<f32>;

    let _e278 = (*voxelPos_10);
    param_40 = vec3<f32>(_e278);
    let _e280 = hash_u0028_vf3_u003b((&param_40));
    noise_4 = _e280;
    let _e281 = noise_4;
    val_3 = (0.4f + (_e281 * 0.3f));
    let _e284 = val_3;
    baseColor_3 = vec3(_e284);
    let _e286 = baseColor_3;
    let _e287 = (*baseLighting_7);
    return (_e286 * _e287);
}

fn renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b(voxelPos_11: ptr<function, vec3<i32>>, normal_2: ptr<function, vec3<f32>>, rayOrigin_1: ptr<function, vec3<f32>>, sunDir_1: ptr<function, vec3<f32>>, sunColor: ptr<function, vec3<f32>>, shadow: ptr<function, f32>, baseLighting_8: ptr<function, vec3<f32>>) -> vec3<f32> {
    var baseColor_4: vec3<f32>;
    var viewDir: vec3<f32>;
    var reflectDir: vec3<f32>;
    var spec: f32;
    var finalLighting: vec3<f32>;

    baseColor_4 = vec3<f32>(0.1f, 0.4f, 0.9f);
    let _e284 = (*rayOrigin_1);
    let _e285 = (*voxelPos_11);
    viewDir = normalize((_e284 - vec3<f32>(_e285)));
    let _e289 = (*sunDir_1);
    let _e291 = (*normal_2);
    reflectDir = reflect(-(_e289), _e291);
    let _e293 = viewDir;
    let _e294 = reflectDir;
    let _e298 = tuning.waterSpecPower;
    spec = pow(max(dot(_e293, _e294), 0f), max(_e298, 1f));
    let _e301 = (*baseLighting_8);
    let _e302 = (*sunColor);
    let _e303 = spec;
    let _e306 = tuning.waterSpecStrength;
    let _e308 = (*shadow);
    finalLighting = (_e301 + (((_e302 * _e303) * _e306) * _e308));
    let _e311 = baseColor_4;
    let _e312 = finalLighting;
    return (_e311 * _e312);
}

fn renderSand_u0028_u1_u003b_vf3_u003b(rawVoxel_4: ptr<function, u32>, baseLighting_9: ptr<function, vec3<f32>>) -> vec3<f32> {
    var moisture_1: u32;
    var wetness_1: f32;
    var dryColor_1: vec3<f32>;
    var wetColor_1: vec3<f32>;
    var baseColor_5: vec3<f32>;

    let _e279 = (*rawVoxel_4);
    moisture_1 = ((_e279 >> bitcast<u32>(24i)) & 255u);
    let _e283 = moisture_1;
    wetness_1 = clamp((f32(_e283) / 10f), 0f, 1f);
    dryColor_1 = vec3<f32>(0.9f, 0.8f, 0.2f);
    wetColor_1 = vec3<f32>(0.65f, 0.55f, 0.15f);
    let _e287 = dryColor_1;
    let _e288 = wetColor_1;
    let _e289 = wetness_1;
    baseColor_5 = mix(_e287, _e288, vec3(_e289));
    let _e292 = baseColor_5;
    let _e293 = (*baseLighting_9);
    return (_e292 * _e293);
}

fn getVoxel_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    var index: u32;
    var phi_293_: bool;
    var phi_301_: bool;
    var phi_311_: bool;
    var phi_319_: bool;
    var phi_329_: bool;

    let _e275 = (*pos)[0u];
    let _e276 = (_e275 < 0i);
    phi_293_ = _e276;
    if !(_e276) {
        let _e279 = (*pos)[0u];
        let _e281 = tuning.gridWidth;
        phi_293_ = (_e279 >= bitcast<i32>(_e281));
    }
    let _e285 = phi_293_;
    phi_301_ = _e285;
    if !(_e285) {
        let _e288 = (*pos)[1u];
        phi_301_ = (_e288 < 0i);
    }
    let _e291 = phi_301_;
    phi_311_ = _e291;
    if !(_e291) {
        let _e294 = (*pos)[1u];
        let _e296 = tuning.gridHeight;
        phi_311_ = (_e294 >= bitcast<i32>(_e296));
    }
    let _e300 = phi_311_;
    phi_319_ = _e300;
    if !(_e300) {
        let _e303 = (*pos)[2u];
        phi_319_ = (_e303 < 0i);
    }
    let _e306 = phi_319_;
    phi_329_ = _e306;
    if !(_e306) {
        let _e309 = (*pos)[2u];
        let _e311 = tuning.gridDepth;
        phi_329_ = (_e309 >= bitcast<i32>(_e311));
    }
    let _e315 = phi_329_;
    if _e315 {
        return 0u;
    }
    let _e317 = (*pos)[0u];
    let _e319 = (*pos)[1u];
    let _e321 = tuning.gridWidth;
    let _e326 = (*pos)[2u];
    let _e328 = tuning.gridWidth;
    let _e332 = tuning.gridHeight;
    index = bitcast<u32>(((_e317 + (_e319 * bitcast<i32>(_e321))) + ((_e326 * bitcast<i32>(_e328)) * bitcast<i32>(_e332))));
    let _e337 = index;
    let _e340 = unnamed_1.grid[_e337];
    return _e340;
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
    var param_41: vec3<i32>;
    var phi_610_: bool;
    var phi_617_: bool;
    var phi_625_: bool;
    var phi_632_: bool;
    var phi_642_: bool;

    let _e287 = (*hitVoxelPos);
    let _e288 = (*hitNormal);
    voxelPos_12 = (_e287 + vec3<i32>(round(_e288)));
    let _e292 = (*lightDir);
    stepDir_1 = vec3<i32>(sign(_e292));
    let _e296 = (*lightDir)[0u];
    if (_e296 == 0f) {
        local_6 = 100000000f;
    } else {
        let _e299 = (*lightDir)[0u];
        local_6 = abs((1f / _e299));
    }
    let _e302 = local_6;
    let _e304 = (*lightDir)[1u];
    if (_e304 == 0f) {
        local_7 = 100000000f;
    } else {
        let _e307 = (*lightDir)[1u];
        local_7 = abs((1f / _e307));
    }
    let _e310 = local_7;
    let _e312 = (*lightDir)[2u];
    if (_e312 == 0f) {
        local_8 = 100000000f;
    } else {
        let _e315 = (*lightDir)[2u];
        local_8 = abs((1f / _e315));
    }
    let _e318 = local_8;
    tDelta_1 = vec3<f32>(_e302, _e310, _e318);
    let _e320 = tDelta_1;
    tMax_1 = (_e320 * 0.5f);
    transmittance = 1f;
    i_3 = 0i;
    loop {
        let _e322 = i_3;
        let _e324 = tuning.shadowMaxSteps;
        if (_e322 < bitcast<i32>(_e324)) {
            let _e328 = voxelPos_12[0u];
            let _e329 = (_e328 < 0i);
            phi_610_ = _e329;
            if !(_e329) {
                let _e332 = voxelPos_12[0u];
                let _e334 = tuning.gridWidth;
                phi_610_ = (_e332 >= bitcast<i32>(_e334));
            }
            let _e338 = phi_610_;
            phi_617_ = _e338;
            if !(_e338) {
                let _e341 = voxelPos_12[1u];
                phi_617_ = (_e341 < 0i);
            }
            let _e344 = phi_617_;
            phi_625_ = _e344;
            if !(_e344) {
                let _e347 = voxelPos_12[1u];
                let _e348 = (*ceilingY);
                phi_625_ = (_e347 >= _e348);
            }
            let _e351 = phi_625_;
            phi_632_ = _e351;
            if !(_e351) {
                let _e354 = voxelPos_12[2u];
                phi_632_ = (_e354 < 0i);
            }
            let _e357 = phi_632_;
            phi_642_ = _e357;
            if !(_e357) {
                let _e360 = voxelPos_12[2u];
                let _e362 = tuning.gridDepth;
                phi_642_ = (_e360 >= bitcast<i32>(_e362));
            }
            let _e366 = phi_642_;
            if _e366 {
                let _e367 = transmittance;
                return _e367;
            }
            let _e368 = voxelPos_12;
            param_41 = _e368;
            let _e369 = getVoxel_u0028_vi3_u003b((&param_41));
            blockerType = (_e369 & 255u);
            let _e371 = blockerType;
            if (_e371 == 2u) {
                let _e374 = tuning.waterShadowTransmit;
                let _e375 = transmittance;
                transmittance = (_e375 * _e374);
                let _e377 = transmittance;
                if (_e377 < 0.02f) {
                    return 0f;
                }
            } else {
                let _e379 = blockerType;
                if (_e379 != 0u) {
                    return 0f;
                }
            }
            let _e382 = tMax_1[0u];
            let _e384 = tMax_1[1u];
            if (_e382 < _e384) {
                let _e387 = tMax_1[0u];
                let _e389 = tMax_1[2u];
                if (_e387 < _e389) {
                    let _e392 = stepDir_1[0u];
                    let _e394 = voxelPos_12[0u];
                    voxelPos_12[0u] = (_e394 + _e392);
                    let _e398 = tDelta_1[0u];
                    let _e400 = tMax_1[0u];
                    tMax_1[0u] = (_e400 + _e398);
                } else {
                    let _e404 = stepDir_1[2u];
                    let _e406 = voxelPos_12[2u];
                    voxelPos_12[2u] = (_e406 + _e404);
                    let _e410 = tDelta_1[2u];
                    let _e412 = tMax_1[2u];
                    tMax_1[2u] = (_e412 + _e410);
                }
            } else {
                let _e416 = tMax_1[1u];
                let _e418 = tMax_1[2u];
                if (_e416 < _e418) {
                    let _e421 = stepDir_1[1u];
                    let _e423 = voxelPos_12[1u];
                    voxelPos_12[1u] = (_e423 + _e421);
                    let _e427 = tDelta_1[1u];
                    let _e429 = tMax_1[1u];
                    tMax_1[1u] = (_e429 + _e427);
                } else {
                    let _e433 = stepDir_1[2u];
                    let _e435 = voxelPos_12[2u];
                    voxelPos_12[2u] = (_e435 + _e433);
                    let _e439 = tDelta_1[2u];
                    let _e441 = tMax_1[2u];
                    tMax_1[2u] = (_e441 + _e439);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e444 = i_3;
            i_3 = (_e444 + 1i);
        }
    }
    let _e446 = transmittance;
    return _e446;
}

fn getSmoothNormal_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> vec3<f32> {
    var n_3: vec3<f32>;
    var x_3: i32;
    var y: i32;
    var z_3: i32;
    var param_42: vec3<i32>;
    var offset: vec3<f32>;

    n_3 = vec3<f32>(0f, 0f, 0f);
    x_3 = -1i;
    loop {
        let _e279 = x_3;
        if (_e279 <= 1i) {
            y = -1i;
            loop {
                let _e281 = y;
                if (_e281 <= 1i) {
                    z_3 = -1i;
                    loop {
                        let _e283 = z_3;
                        if (_e283 <= 1i) {
                            let _e285 = x_3;
                            let _e287 = y;
                            let _e290 = z_3;
                            if (((_e285 == 0i) && (_e287 == 0i)) && (_e290 == 0i)) {
                                continue;
                            }
                            let _e293 = (*p_1);
                            let _e294 = x_3;
                            let _e295 = y;
                            let _e296 = z_3;
                            param_42 = (_e293 + vec3<i32>(_e294, _e295, _e296));
                            let _e299 = getVoxel_u0028_vi3_u003b((&param_42));
                            if ((_e299 & 255u) == 0u) {
                                continue;
                            }
                            let _e302 = x_3;
                            let _e304 = y;
                            let _e306 = z_3;
                            offset = vec3<f32>(f32(_e302), f32(_e304), f32(_e306));
                            let _e309 = offset;
                            let _e310 = x_3;
                            let _e311 = x_3;
                            let _e313 = y;
                            let _e314 = y;
                            let _e317 = z_3;
                            let _e318 = z_3;
                            let _e324 = n_3;
                            n_3 = (_e324 - (_e309 * inverseSqrt(f32((((_e310 * _e311) + (_e313 * _e314)) + (_e317 * _e318))))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e326 = z_3;
                            z_3 = (_e326 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e328 = y;
                    y = (_e328 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e330 = x_3;
            x_3 = (_e330 + 1i);
        }
    }
    let _e332 = n_3;
    if (length(_e332) < 0.1f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e335 = n_3;
    return normalize(_e335);
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

    let _e288 = tuning.waterWaveScale;
    scale = max(_e288, 0.001f);
    let _e290 = (*t_1);
    let _e292 = tuning.waterWaveSpeed;
    wt = ((_e290 * _e292) * 0.35f);
    let _e295 = (*p_2);
    let _e297 = (*p_2)[1u];
    let _e299 = wt;
    let _e303 = (*p_2)[0u];
    let _e305 = wt;
    q = (_e295 + (vec2<f32>(sin(((_e297 * 0.043f) + _e299)), sin(((_e303 * 0.037f) - (_e305 * 0.8f)))) * 6f));
    grad = vec2<f32>(0f, 0f);
    i_4 = 0i;
    loop {
        let _e312 = i_4;
        if (_e312 < 5i) {
            let _e314 = i_4;
            indexable_1 = array<f32, 5>(0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
            let _e316 = indexable_1[_e314];
            let _e317 = scale;
            f = (_e316 * _e317);
            let _e319 = i_4;
            indexable_2 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e321 = indexable_2[_e319];
            let _e322 = q;
            let _e324 = f;
            let _e326 = (*t_1);
            let _e327 = i_4;
            indexable_3 = array<f32, 5>(1f, 1.37f, 0.83f, 1.71f, 0.61f);
            let _e329 = indexable_3[_e327];
            let _e332 = tuning.waterWaveSpeed;
            phase_1 = ((dot(_e321, _e322) * _e324) + ((_e326 * _e329) * _e332));
            let _e335 = i_4;
            indexable_4 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e337 = indexable_4[_e335];
            let _e338 = i_4;
            indexable_5 = array<f32, 5>(1f, 0.62f, 0.38f, 0.24f, 0.15f);
            let _e340 = indexable_5[_e338];
            let _e341 = f;
            let _e343 = phase_1;
            let _e347 = grad;
            grad = (_e347 + (_e337 * ((_e340 * _e341) * cos(_e343))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e349 = i_4;
            i_4 = (_e349 + 1i);
        }
    }
    let _e352 = (*p_2)[0u];
    let _e355 = (*p_2)[1u];
    let _e358 = (*t_1);
    envelope = (0.45f + (0.55f * sin((((_e352 * 0.021f) + (_e355 * 0.017f)) + (_e358 * 0.11f)))));
    let _e364 = grad;
    let _e365 = envelope;
    return (_e364 * _e365);
}

fn applyWaterWaves_u0028_vf3_u003b_vi3_u003b(normal_3: ptr<function, vec3<f32>>, voxelPos_13: ptr<function, vec3<i32>>) -> vec3<f32> {
    var upness: f32;
    var grad_1: vec2<f32>;
    var param_43: vec2<f32>;
    var param_44: f32;

    let _e279 = tuning.waterWaveStrength;
    if (_e279 <= 0f) {
        let _e281 = (*normal_3);
        return _e281;
    }
    let _e283 = (*normal_3)[1u];
    upness = clamp(_e283, 0f, 1f);
    let _e285 = upness;
    if (_e285 <= 0f) {
        let _e287 = (*normal_3);
        return _e287;
    }
    let _e288 = (*voxelPos_13);
    param_43 = (vec2<f32>(_e288.xz) + vec2<f32>(0.5f, 0.5f));
    let _e293 = pc.time;
    param_44 = _e293;
    let _e294 = waterWaveGradient_u0028_vf2_u003b_f1_u003b((&param_43), (&param_44));
    grad_1 = _e294;
    let _e295 = (*normal_3);
    let _e297 = grad_1[0u];
    let _e300 = grad_1[1u];
    let _e304 = tuning.waterWaveStrength;
    let _e306 = upness;
    return normalize((_e295 + ((vec3<f32>(-(_e297), 0f, -(_e300)) * _e304) * _e306)));
}

fn flattenWaterNormal_u0028_vf3_u003b_f1_u003b(n_4: ptr<function, vec3<f32>>, amount: ptr<function, f32>) -> vec3<f32> {
    var upness_1: f32;
    var a: f32;

    let _e277 = (*n_4)[1u];
    upness_1 = clamp(_e277, 0f, 1f);
    let _e279 = (*amount);
    let _e281 = upness_1;
    a = (clamp(_e279, 0f, 1f) * _e281);
    let _e283 = a;
    if (_e283 <= 0f) {
        let _e285 = (*n_4);
        return _e285;
    }
    let _e286 = (*n_4);
    let _e287 = a;
    return normalize(mix(_e286, vec3<f32>(0f, 1f, 0f), vec3(_e287)));
}

fn getWaterNormal_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> vec3<f32> {
    var n_5: vec3<f32>;
    var x_4: i32;
    var y_1: i32;
    var z_4: i32;
    var d2_: i32;
    var param_45: vec3<i32>;

    n_5 = vec3<f32>(0f, 0f, 0f);
    x_4 = -2i;
    loop {
        let _e279 = x_4;
        if (_e279 <= 2i) {
            y_1 = -2i;
            loop {
                let _e281 = y_1;
                if (_e281 <= 2i) {
                    z_4 = -2i;
                    loop {
                        let _e283 = z_4;
                        if (_e283 <= 2i) {
                            let _e285 = x_4;
                            let _e287 = y_1;
                            let _e290 = z_4;
                            if (((_e285 == 0i) && (_e287 == 0i)) && (_e290 == 0i)) {
                                continue;
                            }
                            let _e293 = x_4;
                            let _e294 = x_4;
                            let _e296 = y_1;
                            let _e297 = y_1;
                            let _e300 = z_4;
                            let _e301 = z_4;
                            d2_ = (((_e293 * _e294) + (_e296 * _e297)) + (_e300 * _e301));
                            let _e304 = d2_;
                            if (_e304 > 6i) {
                                continue;
                            }
                            let _e306 = (*p_3);
                            let _e307 = x_4;
                            let _e308 = y_1;
                            let _e309 = z_4;
                            param_45 = (_e306 + vec3<i32>(_e307, _e308, _e309));
                            let _e312 = getVoxel_u0028_vi3_u003b((&param_45));
                            if ((_e312 & 255u) == 0u) {
                                continue;
                            }
                            let _e315 = x_4;
                            let _e317 = y_1;
                            let _e319 = z_4;
                            let _e322 = d2_;
                            let _e326 = n_5;
                            n_5 = (_e326 - (vec3<f32>(f32(_e315), f32(_e317), f32(_e319)) / vec3(f32(_e322))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e328 = z_4;
                            z_4 = (_e328 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e330 = y_1;
                    y_1 = (_e330 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e332 = x_4;
            x_4 = (_e332 + 1i);
        }
    }
    let _e334 = n_5;
    if (length(_e334) < 0.001f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e337 = n_5;
    return normalize(_e337);
}

fn locustDensity_u0028_u1_u003b(type_38: ptr<function, u32>) -> f32 {
    var stage_2: f32;

    let _e274 = (*type_38);
    stage_2 = (f32((_e274 - 13u)) / 4f);
    let _e279 = tuning.locustDensityMin;
    let _e281 = tuning.locustDensityMax;
    let _e282 = stage_2;
    return clamp(mix(_e279, _e281, _e282), 0.02f, 0.98f);
}

fn trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b(voxelPos_14: ptr<function, vec3<i32>>, a_1: ptr<function, vec2<f32>>, b_1: ptr<function, vec2<f32>>, count_2: ptr<function, i32>) {
    var h0_: f32;
    var param_46: vec3<f32>;
    var h1_: f32;
    var param_47: vec3<f32>;
    var h2_: f32;
    var param_48: vec3<f32>;

    let _e283 = (*voxelPos_14)[0u];
    let _e286 = (*voxelPos_14)[2u];
    param_46 = vec3<f32>(f32(_e283), 7f, f32(_e286));
    let _e289 = hash_u0028_vf3_u003b((&param_46));
    h0_ = _e289;
    let _e291 = (*voxelPos_14)[0u];
    let _e294 = (*voxelPos_14)[2u];
    param_47 = vec3<f32>(f32(_e291), 19f, f32(_e294));
    let _e297 = hash_u0028_vf3_u003b((&param_47));
    h1_ = _e297;
    let _e299 = (*voxelPos_14)[0u];
    let _e302 = (*voxelPos_14)[2u];
    param_48 = vec3<f32>(f32(_e299), 53f, f32(_e302));
    let _e305 = hash_u0028_vf3_u003b((&param_48));
    h2_ = _e305;
    let _e306 = h2_;
    let _e308 = tuning.treeTrunkColumns;
    (*count_2) = (1i + i32((_e306 * f32(max(bitcast<i32>(_e308), 1i)))));
    let _e315 = (*count_2);
    (*count_2) = clamp(_e315, 1i, 2i);
    let _e317 = h0_;
    let _e320 = h1_;
    (*a_1) = vec2<f32>((0.3f + (_e317 * 0.4f)), (0.3f + (_e320 * 0.4f)));
    let _e324 = h1_;
    let _e327 = h0_;
    (*b_1) = vec2<f32>((0.3f + (_e324 * 0.4f)), (0.3f + (_e327 * 0.4f)));
    return;
}

fn subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b(kind: ptr<function, u32>, type_39: ptr<function, u32>, voxelPos_15: ptr<function, vec3<i32>>, cell_1: ptr<function, vec3<i32>>, sub: ptr<function, i32>, jitter: ptr<function, vec3<f32>>) -> bool {
    var p_4: vec2<f32>;
    var a_2: vec2<f32>;
    var b_2: vec2<f32>;
    var count_3: i32;
    var param_49: vec3<i32>;
    var param_50: vec2<f32>;
    var param_51: vec2<f32>;
    var param_52: i32;
    var r_1: f32;
    var param_53: vec3<f32>;
    var param_54: u32;
    var phi_1672_: bool;

    let _e289 = (*kind);
    if (_e289 == 1u) {
        let _e291 = (*cell_1);
        let _e296 = (*sub);
        p_4 = ((vec2<f32>(_e291.xz) + vec2(0.5f)) / vec2(f32(_e296)));
        let _e300 = (*voxelPos_15);
        param_49 = _e300;
        trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b((&param_49), (&param_50), (&param_51), (&param_52));
        let _e301 = param_50;
        a_2 = _e301;
        let _e302 = param_51;
        b_2 = _e302;
        let _e303 = param_52;
        count_3 = _e303;
        let _e305 = tuning.treeTrunkRadius;
        r_1 = max(_e305, 0.02f);
        let _e307 = p_4;
        let _e308 = a_2;
        let _e310 = p_4;
        let _e311 = a_2;
        let _e314 = r_1;
        let _e315 = r_1;
        if (dot((_e307 - _e308), (_e310 - _e311)) <= (_e314 * _e315)) {
            return true;
        }
        let _e318 = count_3;
        let _e319 = (_e318 > 1i);
        phi_1672_ = _e319;
        if _e319 {
            let _e320 = p_4;
            let _e321 = b_2;
            let _e323 = p_4;
            let _e324 = b_2;
            let _e327 = r_1;
            let _e328 = r_1;
            phi_1672_ = (dot((_e320 - _e321), (_e323 - _e324)) <= (_e327 * _e328));
        }
        let _e332 = phi_1672_;
        if _e332 {
            return true;
        }
        return false;
    }
    let _e333 = (*voxelPos_15);
    let _e334 = (*sub);
    let _e337 = (*cell_1);
    let _e340 = (*jitter);
    param_53 = (vec3<f32>(((_e333 * vec3(_e334)) + _e337)) + _e340);
    let _e342 = hash_u0028_vf3_u003b((&param_53));
    let _e343 = (*type_39);
    param_54 = _e343;
    let _e344 = locustDensity_u0028_u1_u003b((&param_54));
    return (_e342 < _e344);
}

fn intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b(ro: ptr<function, vec3<f32>>, rd: ptr<function, vec3<f32>>, boxMin: ptr<function, vec3<f32>>, boxMax: ptr<function, vec3<f32>>) -> vec2<f32> {
    var tMin: vec3<f32>;
    var tMax_2: vec3<f32>;
    var t1_: vec3<f32>;
    var t2_: vec3<f32>;
    var tNear: f32;
    var tFar: f32;

    let _e282 = (*boxMin);
    let _e283 = (*ro);
    let _e285 = (*rd);
    tMin = ((_e282 - _e283) / _e285);
    let _e287 = (*boxMax);
    let _e288 = (*ro);
    let _e290 = (*rd);
    tMax_2 = ((_e287 - _e288) / _e290);
    let _e292 = tMin;
    let _e293 = tMax_2;
    t1_ = min(_e292, _e293);
    let _e295 = tMin;
    let _e296 = tMax_2;
    t2_ = max(_e295, _e296);
    let _e299 = t1_[0u];
    let _e301 = t1_[1u];
    let _e304 = t1_[2u];
    tNear = max(max(_e299, _e301), _e304);
    let _e307 = t2_[0u];
    let _e309 = t2_[1u];
    let _e312 = t2_[2u];
    tFar = min(min(_e307, _e309), _e312);
    let _e314 = tNear;
    let _e315 = tFar;
    return vec2<f32>(_e314, _e315);
}

fn subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b(voxelPos_16: ptr<function, vec3<i32>>, rayOrigin_2: ptr<function, vec3<f32>>, rayDir_2: ptr<function, vec3<f32>>, kind_1: ptr<function, u32>, type_40: ptr<function, u32>, entryNormal: ptr<function, vec3<f32>>, tHit_1: ptr<function, f32>, subNormal: ptr<function, vec3<f32>>, subCell_2: ptr<function, vec3<f32>>) -> bool {
    var sub_1: i32;
    var cellSize: f32;
    var boxMin_1: vec3<f32>;
    var span: vec2<f32>;
    var param_55: vec3<f32>;
    var param_56: vec3<f32>;
    var param_57: vec3<f32>;
    var param_58: vec3<f32>;
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
    var param_59: u32;
    var param_60: u32;
    var param_61: vec3<i32>;
    var param_62: vec3<i32>;
    var param_63: i32;
    var param_64: vec3<f32>;
    var phi_1904_: bool;
    var phi_1911_: bool;
    var phi_1919_: bool;
    var phi_1926_: bool;
    var phi_1934_: bool;

    (*tHit_1) = 0f;
    let _e311 = (*entryNormal);
    (*subNormal) = _e311;
    (*subCell_2) = vec3<f32>(0f, 0f, 0f);
    let _e313 = tuning.locustSubdivision;
    sub_1 = clamp(bitcast<i32>(_e313), 1i, 8i);
    let _e316 = sub_1;
    cellSize = (1f / f32(_e316));
    let _e319 = (*voxelPos_16);
    boxMin_1 = vec3<f32>(_e319);
    let _e321 = boxMin_1;
    let _e323 = (*rayOrigin_2);
    param_55 = _e323;
    let _e324 = (*rayDir_2);
    param_56 = _e324;
    let _e325 = boxMin_1;
    param_57 = _e325;
    param_58 = (_e321 + vec3<f32>(1f, 1f, 1f));
    let _e326 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_55), (&param_56), (&param_57), (&param_58));
    span = _e326;
    let _e328 = span[0u];
    t_2 = max(_e328, 0f);
    let _e330 = t_2;
    let _e332 = span[1u];
    if (_e330 > _e332) {
        return false;
    }
    let _e334 = (*rayOrigin_2);
    let _e335 = (*rayDir_2);
    let _e336 = t_2;
    let _e340 = boxMin_1;
    let _e342 = sub_1;
    local_9 = (((_e334 + (_e335 * (_e336 + 0.0001f))) - _e340) * f32(_e342));
    let _e345 = local_9;
    let _e348 = sub_1;
    c_1 = clamp(vec3<i32>(floor(_e345)), vec3<i32>(0i, 0i, 0i), vec3((_e348 - 1i)));
    let _e352 = (*rayDir_2);
    stepDir_2 = vec3<i32>(sign(_e352));
    let _e356 = (*rayDir_2)[0u];
    if (_e356 == 0f) {
        local_10 = 1000000f;
    } else {
        let _e358 = cellSize;
        let _e360 = (*rayDir_2)[0u];
        local_10 = abs((_e358 / _e360));
    }
    let _e363 = local_10;
    let _e365 = (*rayDir_2)[1u];
    if (_e365 == 0f) {
        local_11 = 1000000f;
    } else {
        let _e367 = cellSize;
        let _e369 = (*rayDir_2)[1u];
        local_11 = abs((_e367 / _e369));
    }
    let _e372 = local_11;
    let _e374 = (*rayDir_2)[2u];
    if (_e374 == 0f) {
        local_12 = 1000000f;
    } else {
        let _e376 = cellSize;
        let _e378 = (*rayDir_2)[2u];
        local_12 = abs((_e376 / _e378));
    }
    let _e381 = local_12;
    tDelta_2 = vec3<f32>(_e363, _e372, _e381);
    let _e383 = local_9;
    let _e384 = c_1;
    fracPos_1 = (_e383 - vec3<f32>(_e384));
    let _e387 = t_2;
    let _e389 = stepDir_2[0u];
    if (_e389 > 0i) {
        let _e392 = fracPos_1[0u];
        let _e395 = tDelta_2[0u];
        local_13 = ((1f - _e392) * _e395);
    } else {
        let _e398 = fracPos_1[0u];
        let _e400 = tDelta_2[0u];
        local_13 = (_e398 * _e400);
    }
    let _e402 = local_13;
    let _e404 = stepDir_2[1u];
    if (_e404 > 0i) {
        let _e407 = fracPos_1[1u];
        let _e410 = tDelta_2[1u];
        local_14 = ((1f - _e407) * _e410);
    } else {
        let _e413 = fracPos_1[1u];
        let _e415 = tDelta_2[1u];
        local_14 = (_e413 * _e415);
    }
    let _e417 = local_14;
    let _e419 = stepDir_2[2u];
    if (_e419 > 0i) {
        let _e422 = fracPos_1[2u];
        let _e425 = tDelta_2[2u];
        local_15 = ((1f - _e422) * _e425);
    } else {
        let _e428 = fracPos_1[2u];
        let _e430 = tDelta_2[2u];
        local_15 = (_e428 * _e430);
    }
    let _e432 = local_15;
    tMax_3 = (vec3(_e387) + vec3<f32>(_e402, _e417, _e432));
    let _e436 = (*kind_1);
    if (_e436 == 0u) {
        let _e439 = pc.time;
        let _e441 = tuning.locustCrawlRate;
        local_16 = vec3((floor((_e439 * _e441)) * 1.7f));
    } else {
        local_16 = vec3<f32>(0f, 0f, 0f);
    }
    let _e446 = local_16;
    jitter_1 = _e446;
    i_5 = 0i;
    loop {
        let _e447 = i_5;
        let _e448 = sub_1;
        if (_e447 < (3i * _e448)) {
            let _e452 = c_1[0u];
            let _e453 = (_e452 < 0i);
            phi_1904_ = _e453;
            if !(_e453) {
                let _e456 = c_1[0u];
                let _e457 = sub_1;
                phi_1904_ = (_e456 >= _e457);
            }
            let _e460 = phi_1904_;
            phi_1911_ = _e460;
            if !(_e460) {
                let _e463 = c_1[1u];
                phi_1911_ = (_e463 < 0i);
            }
            let _e466 = phi_1911_;
            phi_1919_ = _e466;
            if !(_e466) {
                let _e469 = c_1[1u];
                let _e470 = sub_1;
                phi_1919_ = (_e469 >= _e470);
            }
            let _e473 = phi_1919_;
            phi_1926_ = _e473;
            if !(_e473) {
                let _e476 = c_1[2u];
                phi_1926_ = (_e476 < 0i);
            }
            let _e479 = phi_1926_;
            phi_1934_ = _e479;
            if !(_e479) {
                let _e482 = c_1[2u];
                let _e483 = sub_1;
                phi_1934_ = (_e482 >= _e483);
            }
            let _e486 = phi_1934_;
            if _e486 {
                return false;
            }
            let _e487 = (*kind_1);
            param_59 = _e487;
            let _e488 = (*type_40);
            param_60 = _e488;
            let _e489 = (*voxelPos_16);
            param_61 = _e489;
            let _e490 = c_1;
            param_62 = _e490;
            let _e491 = sub_1;
            param_63 = _e491;
            let _e492 = jitter_1;
            param_64 = _e492;
            let _e493 = subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b((&param_59), (&param_60), (&param_61), (&param_62), (&param_63), (&param_64));
            if _e493 {
                let _e494 = t_2;
                (*tHit_1) = _e494;
                let _e495 = c_1;
                (*subCell_2) = vec3<f32>(_e495);
                return true;
            }
            let _e498 = tMax_3[0u];
            let _e500 = tMax_3[1u];
            if (_e498 < _e500) {
                let _e503 = tMax_3[0u];
                let _e505 = tMax_3[2u];
                if (_e503 < _e505) {
                    let _e508 = stepDir_2[0u];
                    let _e510 = c_1[0u];
                    c_1[0u] = (_e510 + _e508);
                    let _e514 = tMax_3[0u];
                    t_2 = _e514;
                    let _e516 = tDelta_2[0u];
                    let _e518 = tMax_3[0u];
                    tMax_3[0u] = (_e518 + _e516);
                    let _e522 = stepDir_2[0u];
                    (*subNormal) = vec3<f32>(f32(-(_e522)), 0f, 0f);
                } else {
                    let _e527 = stepDir_2[2u];
                    let _e529 = c_1[2u];
                    c_1[2u] = (_e529 + _e527);
                    let _e533 = tMax_3[2u];
                    t_2 = _e533;
                    let _e535 = tDelta_2[2u];
                    let _e537 = tMax_3[2u];
                    tMax_3[2u] = (_e537 + _e535);
                    let _e541 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e541)));
                }
            } else {
                let _e546 = tMax_3[1u];
                let _e548 = tMax_3[2u];
                if (_e546 < _e548) {
                    let _e551 = stepDir_2[1u];
                    let _e553 = c_1[1u];
                    c_1[1u] = (_e553 + _e551);
                    let _e557 = tMax_3[1u];
                    t_2 = _e557;
                    let _e559 = tDelta_2[1u];
                    let _e561 = tMax_3[1u];
                    tMax_3[1u] = (_e561 + _e559);
                    let _e565 = stepDir_2[1u];
                    (*subNormal) = vec3<f32>(0f, f32(-(_e565)), 0f);
                } else {
                    let _e570 = stepDir_2[2u];
                    let _e572 = c_1[2u];
                    c_1[2u] = (_e572 + _e570);
                    let _e576 = tMax_3[2u];
                    t_2 = _e576;
                    let _e578 = tDelta_2[2u];
                    let _e580 = tMax_3[2u];
                    tMax_3[2u] = (_e580 + _e578);
                    let _e584 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e584)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e588 = i_5;
            i_5 = (_e588 + 1i);
        }
    }
    return false;
}

fn isLocustType_u0028_u1_u003b(type_41: ptr<function, u32>) -> bool {
    let _e273 = (*type_41);
    let _e275 = (*type_41);
    return ((_e273 >= 13u) && (_e275 <= 17u));
}

fn marchCeiling_u0028_() -> i32 {
    let _e273 = tuning.gridHeight;
    let _e276 = unnamed.maxOccupiedY;
    return min(bitcast<i32>(_e273), (bitcast<i32>(_e276) + 2i));
}

fn worldExtent_u0028_() -> vec3<f32> {
    let _e273 = tuning.gridWidth;
    let _e277 = tuning.gridHeight;
    let _e281 = tuning.gridDepth;
    return vec3<f32>(f32(bitcast<i32>(_e273)), f32(bitcast<i32>(_e277)), f32(bitcast<i32>(_e281)));
}

fn isEdge_u0028_vf3_u003b(p_5: ptr<function, vec3<f32>>) -> bool {
    var thickness_1: f32;
    var boundCount: i32;
    var extent: vec3<f32>;
    var phi_485_: bool;
    var phi_504_: bool;
    var phi_523_: bool;

    thickness_1 = 0.3f;
    boundCount = 0i;
    let _e276 = worldExtent_u0028_();
    extent = _e276;
    let _e278 = (*p_5)[0u];
    let _e279 = thickness_1;
    let _e280 = (_e278 < _e279);
    phi_485_ = _e280;
    if !(_e280) {
        let _e283 = (*p_5)[0u];
        let _e285 = extent[0u];
        let _e286 = thickness_1;
        phi_485_ = (_e283 > (_e285 - _e286));
    }
    let _e290 = phi_485_;
    if _e290 {
        let _e291 = boundCount;
        boundCount = (_e291 + 1i);
    }
    let _e294 = (*p_5)[1u];
    let _e295 = thickness_1;
    let _e296 = (_e294 < _e295);
    phi_504_ = _e296;
    if !(_e296) {
        let _e299 = (*p_5)[1u];
        let _e301 = extent[1u];
        let _e302 = thickness_1;
        phi_504_ = (_e299 > (_e301 - _e302));
    }
    let _e306 = phi_504_;
    if _e306 {
        let _e307 = boundCount;
        boundCount = (_e307 + 1i);
    }
    let _e310 = (*p_5)[2u];
    let _e311 = thickness_1;
    let _e312 = (_e310 < _e311);
    phi_523_ = _e312;
    if !(_e312) {
        let _e315 = (*p_5)[2u];
        let _e317 = extent[2u];
        let _e318 = thickness_1;
        phi_523_ = (_e315 > (_e317 - _e318));
    }
    let _e322 = phi_523_;
    if _e322 {
        let _e323 = boundCount;
        boundCount = (_e323 + 1i);
    }
    let _e325 = boundCount;
    return (_e325 >= 2i);
}

fn rot_u0028_f1_u003b(a_3: ptr<function, f32>) -> mat2x2<f32> {
    var s: f32;
    var c_2: f32;

    let _e275 = (*a_3);
    s = sin(_e275);
    let _e277 = (*a_3);
    c_2 = cos(_e277);
    let _e279 = c_2;
    let _e280 = s;
    let _e282 = s;
    let _e283 = c_2;
    return mat2x2<f32>(vec2<f32>(_e279, -(_e280)), vec2<f32>(_e282, _e283));
}

fn applyCameraRotation_u0028_vf3_u003b(v: ptr<function, vec3<f32>>) -> vec3<f32> {
    var param_65: f32;
    var param_66: f32;

    let _e276 = pc.pitch;
    param_65 = _e276;
    let _e277 = rot_u0028_f1_u003b((&param_65));
    let _e278 = (*v);
    let _e280 = (_e278.yz * _e277);
    (*v)[1u] = _e280.x;
    (*v)[2u] = _e280.y;
    let _e286 = pc.yaw;
    param_66 = _e286;
    let _e287 = rot_u0028_f1_u003b((&param_66));
    let _e288 = (*v);
    let _e290 = (_e288.xz * _e287);
    (*v)[0u] = _e290.x;
    (*v)[2u] = _e290.y;
    let _e295 = (*v);
    return _e295;
}

fn main_1() {
    var screenSpace: vec2<f32>;
    var baseOrigin: vec3<f32>;
    var forward: vec3<f32>;
    var param_67: vec3<f32>;
    var right: vec3<f32>;
    var param_68: vec3<f32>;
    var up: vec3<f32>;
    var param_69: vec3<f32>;
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
    var param_70: vec3<f32>;
    var param_71: vec3<f32>;
    var param_72: vec3<f32>;
    var param_73: vec3<f32>;
    var hitFrontBox: bool;
    var hitBackBox: bool;
    var param_74: vec3<f32>;
    var param_75: vec3<f32>;
    var ceilingY_1: i32;
    var local_17: i32;
    var marchHit: vec2<f32>;
    var param_76: vec3<f32>;
    var param_77: vec3<f32>;
    var param_78: vec3<f32>;
    var param_79: vec3<f32>;
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
    var param_80: vec3<i32>;
    var c_3: u32;
    var age_1: u32;
    var targetAlpha: f32;
    var dither: f32;
    var param_81: u32;
    var kind_2: u32;
    var param_82: vec3<i32>;
    var param_83: vec3<f32>;
    var param_84: vec3<f32>;
    var param_85: u32;
    var param_86: u32;
    var param_87: vec3<f32>;
    var param_88: f32;
    var param_89: vec3<f32>;
    var param_90: vec3<f32>;
    var ddaNormal_1: vec3<f32>;
    var param_91: vec3<i32>;
    var param_92: vec3<f32>;
    var param_93: f32;
    var param_94: vec3<f32>;
    var param_95: vec3<i32>;
    var param_96: u32;
    var param_97: vec3<i32>;
    var sunDir_2: vec3<f32>;
    var sunColor_1: vec3<f32>;
    var ambientColor: vec3<f32>;
    var diffuseNormal: vec3<f32>;
    var local_24: vec3<f32>;
    var param_98: vec3<f32>;
    var param_99: f32;
    var diffuse_1: f32;
    var shadow_1: f32;
    var param_100: vec3<i32>;
    var param_101: vec3<f32>;
    var param_102: vec3<f32>;
    var param_103: i32;
    var baseLighting_10: vec3<f32>;
    var finalVoxelColor: vec3<f32>;
    var calm: vec3<f32>;
    var rain: vec3<f32>;
    var param_104: u32;
    var param_105: vec3<f32>;
    var param_106: vec3<i32>;
    var param_107: vec3<f32>;
    var param_108: vec3<f32>;
    var param_109: vec3<f32>;
    var param_110: vec3<f32>;
    var param_111: f32;
    var param_112: vec3<f32>;
    var param_113: vec3<i32>;
    var param_114: vec3<f32>;
    var param_115: u32;
    var param_116: vec3<i32>;
    var param_117: vec3<f32>;
    var param_118: vec3<f32>;
    var param_119: u32;
    var param_120: vec3<i32>;
    var param_121: vec3<i32>;
    var param_122: vec3<f32>;
    var param_123: u32;
    var param_124: vec3<i32>;
    var param_125: vec3<i32>;
    var param_126: vec3<f32>;
    var param_127: vec3<i32>;
    var param_128: vec3<f32>;
    var param_129: vec3<f32>;
    var param_130: vec3<i32>;
    var param_131: vec3<f32>;
    var param_132: vec3<f32>;
    var param_133: u32;
    var param_134: vec3<i32>;
    var param_135: vec3<f32>;
    var param_136: vec3<i32>;
    var param_137: vec3<f32>;
    var param_138: vec3<f32>;
    var param_139: vec3<i32>;
    var distanceTraveled: f32;
    var param_140: u32;
    var local_25: f32;
    var seenHoles: u32;
    var i_7: i32;
    var code_2: u32;
    var bodyLevel: u32;
    var local_26: u32;
    var param_141: u32;
    var bodyRadius: f32;
    var param_142: u32;
    var center: vec3<f32>;
    var param_143: u32;
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
    var param_144: vec3<f32>;
    var param_145: vec3<f32>;
    var charge: f32;
    var cloudGreyness: f32;
    var crossedTime: f32;
    var cloudCell: f32;
    var peakCount: f32;
    var slabMax: f32;
    var bandHi: f32;
    var bandLo: f32;
    var cloudClip: vec2<f32>;
    var local_27: vec2<f32>;
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
    var phi_3156_: bool;
    var phi_3172_: bool;
    var phi_3400_: bool;
    var phi_3407_: bool;
    var phi_3415_: bool;
    var phi_3422_: bool;
    var phi_3432_: bool;
    var phi_3960_: bool;
    var phi_4281_: bool;
    var phi_4288_: bool;
    var phi_4297_: bool;
    var phi_4303_: bool;
    var phi_4312_: bool;
    var phi_4521_: bool;
    var phi_4563_: bool;
    var phi_4585_: bool;
    var phi_4607_: bool;
    var phi_4635_: bool;
    var phi_4657_: bool;
    var phi_4679_: bool;

    let _e496 = inUV_1;
    screenSpace = ((_e496 * 2f) - vec2(1f));
    let _e501 = screenSpace[1u];
    screenSpace[1u] = -(_e501);
    let _e505 = pc.aspectScaleX;
    let _e507 = screenSpace[0u];
    screenSpace[0u] = (_e507 * _e505);
    let _e511 = pc.aspectScaleY;
    let _e513 = screenSpace[1u];
    screenSpace[1u] = (_e513 * _e511);
    let _e517 = pc.camX;
    let _e519 = pc.camY;
    let _e521 = pc.camZ;
    baseOrigin = vec3<f32>(_e517, _e519, _e521);
    param_67 = vec3<f32>(0f, 0f, 1f);
    let _e523 = applyCameraRotation_u0028_vf3_u003b((&param_67));
    forward = _e523;
    param_68 = vec3<f32>(1f, 0f, 0f);
    let _e524 = applyCameraRotation_u0028_vf3_u003b((&param_68));
    right = _e524;
    param_69 = vec3<f32>(0f, 1f, 0f);
    let _e525 = applyCameraRotation_u0028_vf3_u003b((&param_69));
    up = _e525;
    let _e527 = pc.perspectiveBlend;
    t_3 = clamp(_e527, 0f, 1f);
    let _e529 = worldExtent_u0028_();
    cubeCenter = (_e529 * 0.5f);
    let _e531 = cubeCenter;
    let _e532 = baseOrigin;
    let _e534 = forward;
    viewDistance = max(1f, dot((_e531 - _e532), _e534));
    let _e537 = viewDistance;
    let _e539 = pc.fovDistance;
    orthoHalfSize = (_e537 / _e539);
    let _e542 = screenSpace[0u];
    let _e544 = screenSpace[1u];
    let _e546 = pc.fovDistance;
    let _e548 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e542, _e544, _e546), vec3(_e548));
    let _e551 = right;
    let _e553 = localDir[0u];
    let _e555 = up;
    let _e557 = localDir[1u];
    let _e560 = forward;
    let _e562 = localDir[2u];
    rayDir_3 = normalize((((_e551 * _e553) + (_e555 * _e557)) + (_e560 * _e562)));
    let _e566 = right;
    let _e568 = screenSpace[0u];
    let _e570 = up;
    let _e572 = screenSpace[1u];
    let _e575 = orthoHalfSize;
    let _e577 = t_3;
    originOffset = ((((_e566 * _e568) + (_e570 * _e572)) * _e575) * (1f - _e577));
    let _e580 = baseOrigin;
    let _e581 = originOffset;
    rayOrigin_3 = (_e580 + _e581);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e583 = worldExtent_u0028_();
    let _e584 = rayOrigin_3;
    param_70 = _e584;
    let _e585 = rayDir_3;
    param_71 = _e585;
    param_72 = vec3<f32>(0f, 0f, 0f);
    param_73 = _e583;
    let _e586 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_70), (&param_71), (&param_72), (&param_73));
    aabbHit = _e586;
    hitFrontBox = false;
    hitBackBox = false;
    let _e588 = aabbHit[0u];
    let _e590 = aabbHit[1u];
    let _e591 = (_e588 < _e590);
    phi_3156_ = _e591;
    if _e591 {
        let _e593 = aabbHit[1u];
        phi_3156_ = (_e593 > 0f);
    }
    let _e596 = phi_3156_;
    if _e596 {
        let _e598 = aabbHit[0u];
        let _e599 = (_e598 > 0f);
        phi_3172_ = _e599;
        if _e599 {
            let _e600 = rayOrigin_3;
            let _e601 = rayDir_3;
            let _e603 = aabbHit[0u];
            param_74 = (_e600 + (_e601 * _e603));
            let _e606 = isEdge_u0028_vf3_u003b((&param_74));
            phi_3172_ = _e606;
        }
        let _e608 = phi_3172_;
        if _e608 {
            hitFrontBox = true;
        }
        let _e609 = rayOrigin_3;
        let _e610 = rayDir_3;
        let _e612 = aabbHit[1u];
        param_75 = (_e609 + (_e610 * _e612));
        let _e615 = isEdge_u0028_vf3_u003b((&param_75));
        if _e615 {
            hitBackBox = true;
        }
    }
    let _e617 = pc.showCloudBlocks;
    if (_e617 != 0i) {
        let _e620 = tuning.gridHeight;
        local_17 = bitcast<i32>(_e620);
    } else {
        let _e622 = marchCeiling_u0028_();
        local_17 = _e622;
    }
    let _e623 = local_17;
    ceilingY_1 = _e623;
    let _e625 = tuning.gridWidth;
    let _e628 = ceilingY_1;
    let _e631 = tuning.gridDepth;
    let _e635 = rayOrigin_3;
    param_76 = _e635;
    let _e636 = rayDir_3;
    param_77 = _e636;
    param_78 = vec3<f32>(0f, 0f, 0f);
    param_79 = vec3<f32>(f32(bitcast<i32>(_e625)), f32(_e628), f32(bitcast<i32>(_e631)));
    let _e637 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_76), (&param_77), (&param_78), (&param_79));
    marchHit = _e637;
    let _e638 = rayOrigin_3;
    let _e639 = rayDir_3;
    let _e641 = marchHit[0u];
    currentPos = (_e638 + (_e639 * max(0f, _e641)));
    let _e646 = marchHit[0u];
    if (_e646 > 0f) {
        let _e648 = rayDir_3;
        let _e650 = currentPos;
        currentPos = (_e650 + (_e648 * 0.001f));
    }
    let _e652 = currentPos;
    voxelPos_17 = vec3<i32>(floor(_e652));
    let _e655 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e655));
    let _e659 = rayDir_3[0u];
    if (_e659 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e662 = rayDir_3[0u];
        local_18 = abs((1f / _e662));
    }
    let _e665 = local_18;
    let _e667 = rayDir_3[1u];
    if (_e667 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e670 = rayDir_3[1u];
        local_19 = abs((1f / _e670));
    }
    let _e673 = local_19;
    let _e675 = rayDir_3[2u];
    if (_e675 == 0f) {
        local_20 = 100000000f;
    } else {
        let _e678 = rayDir_3[2u];
        local_20 = abs((1f / _e678));
    }
    let _e681 = local_20;
    tDelta_3 = vec3<f32>(_e665, _e673, _e681);
    let _e684 = stepDir_3[0u];
    if (_e684 > 0i) {
        let _e687 = currentPos[0u];
        let _e691 = currentPos[0u];
        let _e694 = tDelta_3[0u];
        local_21 = (((floor(_e687) + 1f) - _e691) * _e694);
    } else {
        let _e697 = currentPos[0u];
        let _e699 = currentPos[0u];
        let _e703 = tDelta_3[0u];
        local_21 = ((_e697 - floor(_e699)) * _e703);
    }
    let _e705 = local_21;
    let _e707 = stepDir_3[1u];
    if (_e707 > 0i) {
        let _e710 = currentPos[1u];
        let _e714 = currentPos[1u];
        let _e717 = tDelta_3[1u];
        local_22 = (((floor(_e710) + 1f) - _e714) * _e717);
    } else {
        let _e720 = currentPos[1u];
        let _e722 = currentPos[1u];
        let _e726 = tDelta_3[1u];
        local_22 = ((_e720 - floor(_e722)) * _e726);
    }
    let _e728 = local_22;
    let _e730 = stepDir_3[2u];
    if (_e730 > 0i) {
        let _e733 = currentPos[2u];
        let _e737 = currentPos[2u];
        let _e740 = tDelta_3[2u];
        local_23 = (((floor(_e733) + 1f) - _e737) * _e740);
    } else {
        let _e743 = currentPos[2u];
        let _e745 = currentPos[2u];
        let _e749 = tDelta_3[2u];
        local_23 = ((_e743 - floor(_e745)) * _e749);
    }
    let _e751 = local_23;
    tMax_4 = vec3<f32>(_e705, _e728, _e751);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e754 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e754 * 1.5f));
    i_6 = 0i;
    loop {
        let _e757 = i_6;
        let _e759 = tuning.marchMaxSteps;
        if (_e757 < bitcast<i32>(_e759)) {
            let _e763 = voxelPos_17[0u];
            let _e764 = (_e763 < 0i);
            phi_3400_ = _e764;
            if !(_e764) {
                let _e767 = voxelPos_17[0u];
                let _e769 = tuning.gridWidth;
                phi_3400_ = (_e767 >= bitcast<i32>(_e769));
            }
            let _e773 = phi_3400_;
            phi_3407_ = _e773;
            if !(_e773) {
                let _e776 = voxelPos_17[1u];
                phi_3407_ = (_e776 < 0i);
            }
            let _e779 = phi_3407_;
            phi_3415_ = _e779;
            if !(_e779) {
                let _e782 = voxelPos_17[1u];
                let _e783 = ceilingY_1;
                phi_3415_ = (_e782 >= _e783);
            }
            let _e786 = phi_3415_;
            phi_3422_ = _e786;
            if !(_e786) {
                let _e789 = voxelPos_17[2u];
                phi_3422_ = (_e789 < 0i);
            }
            let _e792 = phi_3422_;
            phi_3432_ = _e792;
            if !(_e792) {
                let _e795 = voxelPos_17[2u];
                let _e797 = tuning.gridDepth;
                phi_3432_ = (_e795 >= bitcast<i32>(_e797));
            }
            let _e801 = phi_3432_;
            if _e801 {
                break;
            }
            let _e802 = voxelPos_17;
            param_80 = _e802;
            let _e803 = getVoxel_u0028_vi3_u003b((&param_80));
            rawVoxel_5 = _e803;
            let _e804 = rawVoxel_5;
            hitType = (_e804 & 255u);
            let _e807 = pc.showCloudBlocks;
            let _e809 = hitType;
            if ((_e807 != 0i) && (_e809 == 0u)) {
                let _e813 = voxelPos_17[0u];
                let _e815 = voxelPos_17[1u];
                let _e817 = tuning.gridWidth;
                let _e822 = voxelPos_17[2u];
                let _e824 = tuning.gridWidth;
                let _e828 = tuning.gridHeight;
                let _e835 = unnamed_2.cloudCells[bitcast<u32>(((_e813 + (_e815 * bitcast<i32>(_e817))) + ((_e822 * bitcast<i32>(_e824)) * bitcast<i32>(_e828))))];
                c_3 = _e835;
                let _e836 = c_3;
                if ((_e836 & 3u) != 0u) {
                    hitType = 200u;
                    let _e839 = c_3;
                    hitRawVoxel = _e839;
                    hit = true;
                    break;
                }
            }
            let _e840 = hitType;
            if (_e840 == 7u) {
                hitType = 0u;
            }
            let _e842 = hitType;
            if (_e842 != 0u) {
                let _e844 = hitType;
                if (_e844 == 6u) {
                    let _e846 = rawVoxel_5;
                    age_1 = ((_e846 >> bitcast<u32>(24i)) & 255u);
                    let _e850 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e850) / 100f), 0f, 1f));
                    let _e855 = inUV_1;
                    let _e857 = pc.time;
                    dither = fract((sin(dot((_e855 + vec2((_e857 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e865 = dither;
                    let _e866 = targetAlpha;
                    if (_e865 > _e866) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e868 = rawVoxel_5;
                        hitRawVoxel = _e868;
                        break;
                    }
                } else {
                    let _e869 = hitType;
                    param_81 = _e869;
                    let _e870 = isLocustType_u0028_u1_u003b((&param_81));
                    let _e871 = hitType;
                    if (_e870 || (_e871 == 18u)) {
                        let _e874 = hitType;
                        kind_2 = select(0u, 1u, (_e874 == 18u));
                        let _e877 = voxelPos_17;
                        param_82 = _e877;
                        let _e878 = rayOrigin_3;
                        param_83 = _e878;
                        let _e879 = rayDir_3;
                        param_84 = _e879;
                        let _e880 = kind_2;
                        param_85 = _e880;
                        let _e881 = hitType;
                        param_86 = _e881;
                        let _e882 = normal_4;
                        param_87 = _e882;
                        let _e883 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_82), (&param_83), (&param_84), (&param_85), (&param_86), (&param_87), (&param_88), (&param_89), (&param_90));
                        let _e884 = param_88;
                        subT = _e884;
                        let _e885 = param_89;
                        subNormal_1 = _e885;
                        let _e886 = param_90;
                        subCell_3 = _e886;
                        if _e883 {
                            hit = true;
                            let _e887 = rawVoxel_5;
                            hitRawVoxel = _e887;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e888 = rawVoxel_5;
                        hitRawVoxel = _e888;
                        break;
                    }
                }
            }
            let _e890 = tMax_4[0u];
            let _e892 = tMax_4[1u];
            if (_e890 < _e892) {
                let _e895 = tMax_4[0u];
                let _e897 = tMax_4[2u];
                if (_e895 < _e897) {
                    let _e900 = stepDir_3[0u];
                    let _e902 = voxelPos_17[0u];
                    voxelPos_17[0u] = (_e902 + _e900);
                    let _e906 = tDelta_3[0u];
                    let _e908 = tMax_4[0u];
                    tMax_4[0u] = (_e908 + _e906);
                    let _e912 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e912)), 0f, 0f);
                } else {
                    let _e917 = stepDir_3[2u];
                    let _e919 = voxelPos_17[2u];
                    voxelPos_17[2u] = (_e919 + _e917);
                    let _e923 = tDelta_3[2u];
                    let _e925 = tMax_4[2u];
                    tMax_4[2u] = (_e925 + _e923);
                    let _e929 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e929)));
                }
            } else {
                let _e934 = tMax_4[1u];
                let _e936 = tMax_4[2u];
                if (_e934 < _e936) {
                    let _e939 = stepDir_3[1u];
                    let _e941 = voxelPos_17[1u];
                    voxelPos_17[1u] = (_e941 + _e939);
                    let _e945 = tDelta_3[1u];
                    let _e947 = tMax_4[1u];
                    tMax_4[1u] = (_e947 + _e945);
                    let _e951 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e951)), 0f);
                } else {
                    let _e956 = stepDir_3[2u];
                    let _e958 = voxelPos_17[2u];
                    voxelPos_17[2u] = (_e958 + _e956);
                    let _e962 = tDelta_3[2u];
                    let _e964 = tMax_4[2u];
                    tMax_4[2u] = (_e964 + _e962);
                    let _e968 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e968)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e972 = i_6;
            i_6 = (_e972 + 1i);
        }
    }
    let _e974 = hit;
    if _e974 {
        let _e975 = normal_4;
        if (length(_e975) < 0.1f) {
            let _e978 = rayDir_3;
            normal_4 = -(_e978);
        }
        let _e980 = normal_4;
        ddaNormal_1 = _e980;
        let _e981 = hitType;
        if (_e981 == 2u) {
            let _e983 = voxelPos_17;
            param_91 = _e983;
            let _e984 = getWaterNormal_u0028_vi3_u003b((&param_91));
            param_92 = _e984;
            let _e986 = tuning.waterNormalFlatten;
            param_93 = _e986;
            let _e987 = flattenWaterNormal_u0028_vf3_u003b_f1_u003b((&param_92), (&param_93));
            param_94 = _e987;
            let _e988 = voxelPos_17;
            param_95 = _e988;
            let _e989 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_94), (&param_95));
            normal_4 = _e989;
        } else {
            let _e990 = hitType;
            param_96 = _e990;
            let _e991 = isLocustType_u0028_u1_u003b((&param_96));
            let _e992 = hitType;
            if (_e991 || (_e992 == 18u)) {
                let _e995 = subNormal_1;
                normal_4 = _e995;
            } else {
                let _e996 = voxelPos_17;
                param_97 = _e996;
                let _e997 = getSmoothNormal_u0028_vi3_u003b((&param_97));
                normal_4 = _e997;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e998 = hitType;
        if (_e998 == 2u) {
            let _e1000 = normal_4;
            param_98 = _e1000;
            let _e1002 = tuning.waterDiffuseFlatten;
            param_99 = _e1002;
            let _e1003 = flattenWaterNormal_u0028_vf3_u003b_f1_u003b((&param_98), (&param_99));
            local_24 = _e1003;
        } else {
            let _e1004 = normal_4;
            local_24 = _e1004;
        }
        let _e1005 = local_24;
        diffuseNormal = _e1005;
        let _e1006 = diffuseNormal;
        let _e1007 = sunDir_2;
        diffuse_1 = max(dot(_e1006, _e1007), 0f);
        let _e1010 = voxelPos_17;
        param_100 = _e1010;
        let _e1011 = ddaNormal_1;
        param_101 = _e1011;
        let _e1012 = sunDir_2;
        param_102 = _e1012;
        let _e1013 = ceilingY_1;
        param_103 = _e1013;
        let _e1014 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_100), (&param_101), (&param_102), (&param_103));
        shadow_1 = _e1014;
        let _e1015 = hitType;
        if (_e1015 == 2u) {
            let _e1018 = tuning.waterShadowFloor;
            let _e1020 = shadow_1;
            shadow_1 = mix(clamp(_e1018, 0f, 1f), 1f, _e1020);
        }
        let _e1022 = ambientColor;
        let _e1023 = sunColor_1;
        let _e1024 = diffuse_1;
        let _e1026 = shadow_1;
        baseLighting_10 = (_e1022 + ((_e1023 * _e1024) * _e1026));
        let _e1029 = baseLighting_10;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e1029);
        let _e1031 = hitType;
        if (_e1031 == 200u) {
            calm = vec3<f32>(0.35f, 0.65f, 1f);
            rain = vec3<f32>(1f, 0.55f, 0.25f);
            let _e1033 = calm;
            let _e1034 = rain;
            let _e1035 = hitRawVoxel;
            let _e1041 = baseLighting_10;
            finalVoxelColor = (mix(_e1033, _e1034, vec3(select(0f, 1f, ((_e1035 & 3u) == 2u)))) * _e1041);
        }
        let _e1043 = hitType;
        switch bitcast<i32>(_e1043) {
            case 1: {
                let _e1045 = hitRawVoxel;
                param_104 = _e1045;
                let _e1046 = baseLighting_10;
                param_105 = _e1046;
                let _e1047 = renderSand_u0028_u1_u003b_vf3_u003b((&param_104), (&param_105));
                finalVoxelColor = _e1047;
                break;
            }
            case 2: {
                let _e1048 = voxelPos_17;
                param_106 = _e1048;
                let _e1049 = normal_4;
                param_107 = _e1049;
                let _e1050 = rayOrigin_3;
                param_108 = _e1050;
                let _e1051 = sunDir_2;
                param_109 = _e1051;
                let _e1052 = sunColor_1;
                param_110 = _e1052;
                let _e1053 = shadow_1;
                param_111 = _e1053;
                let _e1054 = baseLighting_10;
                param_112 = _e1054;
                let _e1055 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_106), (&param_107), (&param_108), (&param_109), (&param_110), (&param_111), (&param_112));
                finalVoxelColor = _e1055;
                break;
            }
            case 3: {
                let _e1056 = voxelPos_17;
                param_113 = _e1056;
                let _e1057 = baseLighting_10;
                param_114 = _e1057;
                let _e1058 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_113), (&param_114));
                finalVoxelColor = _e1058;
                break;
            }
            case 4: {
                let _e1059 = hitRawVoxel;
                param_115 = _e1059;
                let _e1060 = voxelPos_17;
                param_116 = _e1060;
                let _e1061 = ddaNormal_1;
                param_117 = _e1061;
                let _e1062 = baseLighting_10;
                param_118 = _e1062;
                let _e1063 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_115), (&param_116), (&param_117), (&param_118));
                finalVoxelColor = _e1063;
                break;
            }
            case 5: {
                let _e1064 = hitRawVoxel;
                param_119 = _e1064;
                let _e1065 = voxelPos_17;
                param_120 = _e1065;
                let _e1066 = renderFire_u0028_u1_u003b_vi3_u003b((&param_119), (&param_120));
                finalVoxelColor = _e1066;
                break;
            }
            case 6: {
                let _e1067 = voxelPos_17;
                param_121 = _e1067;
                let _e1068 = baseLighting_10;
                param_122 = _e1068;
                let _e1069 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_121), (&param_122));
                finalVoxelColor = _e1069;
                break;
            }
            case 9, 10, 11, 8: {
                let _e1070 = hitRawVoxel;
                param_123 = _e1070;
                let _e1071 = voxelPos_17;
                param_124 = _e1071;
                let _e1072 = renderLava_u0028_u1_u003b_vi3_u003b((&param_123), (&param_124));
                finalVoxelColor = _e1072;
                break;
            }
            case 12: {
                let _e1073 = voxelPos_17;
                param_125 = _e1073;
                let _e1074 = baseLighting_10;
                param_126 = _e1074;
                let _e1075 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_125), (&param_126));
                finalVoxelColor = _e1075;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e1076 = voxelPos_17;
                param_127 = _e1076;
                let _e1077 = subCell_3;
                param_128 = _e1077;
                let _e1078 = baseLighting_10;
                param_129 = _e1078;
                let _e1079 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_127), (&param_128), (&param_129));
                finalVoxelColor = _e1079;
                break;
            }
            case 18: {
                let _e1080 = voxelPos_17;
                param_130 = _e1080;
                let _e1081 = subCell_3;
                param_131 = _e1081;
                let _e1082 = baseLighting_10;
                param_132 = _e1082;
                let _e1083 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_130), (&param_131), (&param_132));
                finalVoxelColor = _e1083;
                break;
            }
            case 19: {
                let _e1084 = hitRawVoxel;
                param_133 = _e1084;
                let _e1085 = voxelPos_17;
                param_134 = _e1085;
                let _e1086 = baseLighting_10;
                param_135 = _e1086;
                let _e1087 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_133), (&param_134), (&param_135));
                finalVoxelColor = _e1087;
                break;
            }
            case 20: {
                let _e1088 = voxelPos_17;
                param_136 = _e1088;
                let _e1089 = baseLighting_10;
                param_137 = _e1089;
                let _e1090 = renderAsh_u0028_vi3_u003b_vf3_u003b((&param_136), (&param_137));
                finalVoxelColor = _e1090;
                break;
            }
            default: {
                break;
            }
        }
        let _e1091 = finalVoxelColor;
        param_138 = _e1091;
        let _e1092 = voxelPos_17;
        param_139 = _e1092;
        let _e1093 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_138), (&param_139));
        finalVoxelColor = _e1093;
        let _e1094 = hitType;
        param_140 = _e1094;
        let _e1095 = isLocustType_u0028_u1_u003b((&param_140));
        let _e1096 = hitType;
        if (_e1095 || (_e1096 == 18u)) {
            let _e1099 = subT;
            local_25 = _e1099;
        } else {
            let _e1100 = voxelPos_17;
            let _e1103 = rayOrigin_3;
            local_25 = length(((vec3<f32>(_e1100) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e1103));
        }
        let _e1106 = local_25;
        distanceTraveled = _e1106;
        let _e1107 = distanceTraveled;
        let _e1108 = MAX_VISIBILITY;
        let _e1112 = finalVoxelColor;
        finalVoxelColor = (_e1112 * mix(1f, 0f, clamp((_e1107 / _e1108), 0f, 1f)));
        let _e1114 = distanceTraveled;
        finalDist = _e1114;
        let _e1115 = finalVoxelColor;
        finalColor = vec4<f32>(_e1115.x, _e1115.y, _e1115.z, 1f);
    } else {
        let _e1120 = hitBackBox;
        if _e1120 {
            let _e1122 = aabbHit[1u];
            finalDist = _e1122;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1124 = unnamed.blackHoleCount;
    if (_e1124 > 0u) {
        seenHoles = 0u;
        i_7 = 0i;
        loop {
            let _e1126 = i_7;
            let _e1127 = (_e1126 < 8i);
            phi_3960_ = _e1127;
            if _e1127 {
                let _e1128 = seenHoles;
                let _e1130 = unnamed.blackHoleCount;
                phi_3960_ = (_e1128 < _e1130);
            }
            let _e1133 = phi_3960_;
            if _e1133 {
                let _e1134 = i_7;
                let _e1137 = unnamed.blackHoles[_e1134];
                code_2 = _e1137;
                let _e1138 = code_2;
                if (_e1138 == 0u) {
                    continue;
                }
                let _e1140 = seenHoles;
                seenHoles = (_e1140 + bitcast<u32>(1i));
                let _e1143 = code_2;
                if ((_e1143 & 1073741824u) != 0u) {
                    let _e1147 = tuning.purgeLevel;
                    let _e1149 = i_7;
                    let _e1152 = unnamed.blackHoleMass[_e1149];
                    let _e1155 = tuning.purgeMass;
                    local_26 = u32((f32(_e1147) * clamp((f32(_e1152) / f32(max(_e1155, 1u))), 0f, 1f)));
                } else {
                    let _e1162 = i_7;
                    let _e1165 = unnamed.blackHoleMass[_e1162];
                    param_141 = _e1165;
                    let _e1166 = bhLevel_u0028_u1_u003b((&param_141));
                    local_26 = _e1166;
                }
                let _e1167 = local_26;
                bodyLevel = _e1167;
                let _e1168 = bodyLevel;
                param_142 = _e1168;
                let _e1169 = bhBodyRadius_u0028_u1_u003b((&param_142));
                bodyRadius = _e1169;
                let _e1170 = code_2;
                param_143 = _e1170;
                let _e1171 = bhDecode_u0028_u1_u003b((&param_143));
                center = (vec3<f32>(_e1171) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1174 = rayOrigin_3;
                let _e1175 = center;
                oc = (_e1174 - _e1175);
                let _e1177 = oc;
                let _e1178 = rayDir_3;
                b_3 = dot(_e1177, _e1178);
                let _e1180 = oc;
                let _e1181 = oc;
                let _e1183 = bodyRadius;
                let _e1184 = bodyRadius;
                c_4 = (dot(_e1180, _e1181) - (_e1183 * _e1184));
                let _e1187 = b_3;
                let _e1188 = b_3;
                let _e1190 = c_4;
                disc = ((_e1187 * _e1188) - _e1190);
                let _e1192 = disc;
                if (_e1192 <= 0f) {
                    continue;
                }
                let _e1194 = disc;
                sq = sqrt(_e1194);
                let _e1196 = b_3;
                let _e1198 = sq;
                tNear_1 = (-(_e1196) - _e1198);
                let _e1200 = b_3;
                let _e1202 = sq;
                tFar_1 = (-(_e1200) + _e1202);
                let _e1204 = tFar_1;
                if (_e1204 <= 0f) {
                    continue;
                }
                let _e1206 = tNear_1;
                bodyDist = max(0f, _e1206);
                let _e1208 = bodyDist;
                let _e1209 = finalDist;
                if (_e1208 < _e1209) {
                    let _e1211 = rayOrigin_3;
                    let _e1212 = rayDir_3;
                    let _e1213 = bodyDist;
                    let _e1216 = center;
                    surfaceNormal = normalize(((_e1211 + (_e1212 * _e1213)) - _e1216));
                    let _e1219 = surfaceNormal;
                    param_144 = _e1219;
                    let _e1220 = rayDir_3;
                    param_145 = _e1220;
                    let _e1221 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_144), (&param_145));
                    bodyColor = _e1221;
                    let _e1222 = bodyDist;
                    let _e1223 = MAX_VISIBILITY;
                    let _e1227 = bodyColor;
                    bodyColor = (_e1227 * mix(1f, 0f, clamp((_e1222 / _e1223), 0f, 1f)));
                    let _e1229 = bodyColor;
                    finalColor = vec4<f32>(_e1229.x, _e1229.y, _e1229.z, 1f);
                    let _e1234 = bodyDist;
                    finalDist = _e1234;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1235 = i_7;
                i_7 = (_e1235 + 1i);
            }
        }
    }
    let _e1238 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1238), 0f, 1f);
    let _e1241 = charge;
    cloudGreyness = _e1241;
    let _e1243 = unnamed.rainPhase;
    if (_e1243 == 1u) {
        let _e1246 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1246);
        let _e1248 = charge;
        let _e1250 = pc.time;
        let _e1251 = crossedTime;
        let _e1254 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1248, clamp(((_e1250 - _e1251) / _e1254), 0f, 1f));
    } else {
        let _e1259 = unnamed.rainPhase;
        if (_e1259 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1262 = tuning.cloudMaxAlpha;
    if (_e1262 > 0.002f) {
        let _e1265 = tuning.cloudVoxelSize;
        cloudCell = max(_e1265, 0.5f);
        let _e1268 = unnamed.cloudPeakColumn;
        peakCount = (f32(_e1268) * 0.0625f);
        let _e1271 = peakCount;
        let _e1272 = cloudCell;
        let _e1277 = cloudCell;
        slabMax = (max(1f, floor(((_e1271 / _e1272) + 0.5f))) * _e1277);
        let _e1279 = cloudDeckBaseY_u0028_();
        let _e1280 = slabMax;
        let _e1282 = cloudCell;
        bandHi = ((_e1279 + _e1280) + _e1282);
        let _e1284 = cloudDeckBaseY_u0028_();
        let _e1286 = tuning.cloudVoxelSize;
        bandLo = (_e1284 - max(_e1286, 1f));
        let _e1290 = unnamed.cloudMinY;
        let _e1292 = unnamed.cloudMaxY;
        if (_e1290 > _e1292) {
            local_27 = vec2<f32>(1f, -1f);
        } else {
            let _e1294 = bandLo;
            let _e1296 = worldExtent_u0028_();
            let _e1298 = bandHi;
            let _e1299 = worldExtent_u0028_();
            let _e1302 = rayOrigin_3;
            param_146 = _e1302;
            let _e1303 = rayDir_3;
            param_147 = _e1303;
            param_148 = vec3<f32>(0f, _e1294, 0f);
            param_149 = vec3<f32>(_e1296.x, _e1298, _e1299.z);
            let _e1304 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_146), (&param_147), (&param_148), (&param_149));
            local_27 = _e1304;
        }
        let _e1305 = local_27;
        cloudClip = _e1305;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1307 = cloudClip[0u];
        nearT = max(_e1307, 0f);
        let _e1310 = cloudClip[1u];
        let _e1311 = finalDist;
        farT = min(_e1310, _e1311);
        let _e1313 = nearT;
        let _e1314 = farT;
        if (_e1313 < _e1314) {
            let _e1316 = rayOrigin_3;
            param_150 = _e1316;
            let _e1317 = rayDir_3;
            param_151 = _e1317;
            let _e1318 = nearT;
            param_152 = _e1318;
            let _e1319 = farT;
            param_153 = _e1319;
            let _e1320 = cloudSunDir;
            param_154 = _e1320;
            let _e1321 = cloudGreyness;
            param_155 = _e1321;
            let _e1322 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b((&param_150), (&param_151), (&param_152), (&param_153), (&param_154), (&param_155), (&param_156), (&param_157), (&param_158));
            let _e1323 = param_156;
            cloudTHit = _e1323;
            let _e1324 = param_157;
            cloudColor = _e1324;
            let _e1325 = param_158;
            cloudDensity = _e1325;
            if _e1322 {
                let _e1326 = cloudTHit;
                if (_e1326 > 0f) {
                    let _e1328 = cloudTHit;
                    bestT = _e1328;
                    let _e1329 = cloudColor;
                    bestColor = _e1329;
                    let _e1331 = tuning.cloudMinAlpha;
                    let _e1333 = tuning.cloudMaxAlpha;
                    let _e1334 = cloudDensity;
                    bestAlpha = clamp(mix(_e1331, _e1333, _e1334), 0f, 0.95f);
                    foundCloud = true;
                }
            }
        }
        let _e1337 = foundCloud;
        let _e1338 = bestT;
        let _e1339 = finalDist;
        if (_e1337 && (_e1338 < _e1339)) {
            let _e1342 = finalColor;
            let _e1344 = bestColor;
            let _e1345 = bestAlpha;
            let _e1347 = mix(_e1342.xyz, _e1344, vec3(_e1345));
            finalColor[0u] = _e1347.x;
            finalColor[1u] = _e1347.y;
            finalColor[2u] = _e1347.z;
        }
    }
    let _e1355 = pc.spawnX;
    let _e1356 = (_e1355 >= 0i);
    phi_4281_ = _e1356;
    if _e1356 {
        let _e1358 = pc.spawnX;
        let _e1360 = tuning.gridWidth;
        phi_4281_ = (_e1358 < bitcast<i32>(_e1360));
    }
    let _e1364 = phi_4281_;
    phi_4288_ = _e1364;
    if _e1364 {
        let _e1366 = pc.spawnY;
        phi_4288_ = (_e1366 >= 0i);
    }
    let _e1369 = phi_4288_;
    phi_4297_ = _e1369;
    if _e1369 {
        let _e1371 = pc.spawnY;
        let _e1373 = tuning.gridHeight;
        phi_4297_ = (_e1371 < bitcast<i32>(_e1373));
    }
    let _e1377 = phi_4297_;
    phi_4303_ = _e1377;
    if _e1377 {
        let _e1379 = pc.spawnZ;
        phi_4303_ = (_e1379 >= 0i);
    }
    let _e1382 = phi_4303_;
    phi_4312_ = _e1382;
    if _e1382 {
        let _e1384 = pc.spawnZ;
        let _e1386 = tuning.gridDepth;
        phi_4312_ = (_e1384 < bitcast<i32>(_e1386));
    }
    let _e1390 = phi_4312_;
    if _e1390 {
        let _e1392 = pc.spawnSize;
        halfDistMin = (_e1392 / 2i);
        let _e1395 = pc.spawnSize;
        halfDistMax = ((_e1395 - 1i) / 2i);
        let _e1399 = pc.spawnX;
        let _e1400 = halfDistMin;
        let _e1404 = pc.spawnY;
        let _e1405 = halfDistMin;
        let _e1409 = pc.spawnZ;
        let _e1410 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1399 - _e1400)), f32((_e1404 - _e1405)), f32((_e1409 - _e1410)));
        let _e1415 = pc.spawnX;
        let _e1416 = halfDistMax;
        let _e1421 = pc.spawnY;
        let _e1422 = halfDistMax;
        let _e1427 = pc.spawnZ;
        let _e1428 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1415 + _e1416) + 1i)), f32(((_e1421 + _e1422) + 1i)), f32(((_e1427 + _e1428) + 1i)));
        let _e1434 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1437 = indexable_6[clamp(_e1434, 0i, 19i)];
        cursorColor = _e1437;
        let _e1439 = pc.spawnShape;
        if (_e1439 == 1i) {
            let _e1441 = boxMin_2;
            let _e1442 = boxMax_1;
            sphereCenter = ((_e1441 + _e1442) * 0.5f);
            let _e1446 = pc.spawnSize;
            sphereRadius = (f32(_e1446) * 0.5f);
            let _e1449 = rayOrigin_3;
            let _e1450 = sphereCenter;
            oc_1 = (_e1449 - _e1450);
            let _e1452 = oc_1;
            let _e1453 = rayDir_3;
            b_4 = dot(_e1452, _e1453);
            let _e1455 = oc_1;
            let _e1456 = oc_1;
            let _e1458 = sphereRadius;
            let _e1459 = sphereRadius;
            c_5 = (dot(_e1455, _e1456) - (_e1458 * _e1459));
            let _e1462 = b_4;
            let _e1463 = b_4;
            let _e1465 = c_5;
            disc_1 = ((_e1462 * _e1463) - _e1465);
            let _e1467 = disc_1;
            if (_e1467 > 0f) {
                let _e1469 = disc_1;
                sq_1 = sqrt(_e1469);
                let _e1471 = b_4;
                let _e1473 = sq_1;
                tNear_2 = (-(_e1471) - _e1473);
                let _e1475 = b_4;
                let _e1477 = sq_1;
                tFar_2 = (-(_e1475) + _e1477);
                let _e1479 = tFar_2;
                if (_e1479 > 0f) {
                    let _e1481 = tNear_2;
                    inside = (_e1481 <= 0f);
                    let _e1483 = inside;
                    let _e1484 = tFar_2;
                    let _e1485 = tNear_2;
                    cursorDist = select(_e1485, _e1484, _e1483);
                    let _e1487 = rayOrigin_3;
                    let _e1488 = rayDir_3;
                    let _e1489 = cursorDist;
                    let _e1492 = sphereCenter;
                    shellNormal = normalize(((_e1487 + (_e1488 * _e1489)) - _e1492));
                    let _e1495 = shellNormal;
                    let _e1496 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1495, _e1496)));
                    let _e1500 = rim_1;
                    let _e1503 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1500)) * select(1f, 0.35f, _e1503));
                    let _e1506 = cursorDist;
                    let _e1507 = finalDist;
                    if (_e1506 < _e1507) {
                        let _e1509 = finalColor;
                        let _e1511 = cursorColor;
                        let _e1512 = alpha;
                        let _e1514 = mix(_e1509.xyz, _e1511, vec3(_e1512));
                        finalColor[0u] = _e1514.x;
                        finalColor[1u] = _e1514.y;
                        finalColor[2u] = _e1514.z;
                    }
                }
            }
        } else {
            let _e1521 = rayOrigin_3;
            param_159 = _e1521;
            let _e1522 = rayDir_3;
            param_160 = _e1522;
            let _e1523 = boxMin_2;
            param_161 = _e1523;
            let _e1524 = boxMax_1;
            param_162 = _e1524;
            let _e1525 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_159), (&param_160), (&param_161), (&param_162));
            cursorHit = _e1525;
            let _e1527 = cursorHit[0u];
            let _e1529 = cursorHit[1u];
            let _e1530 = (_e1527 < _e1529);
            phi_4521_ = _e1530;
            if _e1530 {
                let _e1532 = cursorHit[1u];
                phi_4521_ = (_e1532 > 0f);
            }
            let _e1535 = phi_4521_;
            if _e1535 {
                let _e1537 = cursorHit[0u];
                distFront = max(0f, _e1537);
                let _e1540 = cursorHit[1u];
                distBack = _e1540;
                let _e1541 = rayOrigin_3;
                let _e1542 = rayDir_3;
                let _e1543 = distFront;
                hitPosFront = (_e1541 + (_e1542 * _e1543));
                let _e1546 = rayOrigin_3;
                let _e1547 = rayDir_3;
                let _e1548 = distBack;
                hitPosBack = (_e1546 + (_e1547 * _e1548));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1552 = hitPosFront[0u];
                let _e1554 = boxMin_2[0u];
                let _e1555 = e;
                let _e1557 = (_e1552 < (_e1554 + _e1555));
                phi_4563_ = _e1557;
                if !(_e1557) {
                    let _e1560 = hitPosFront[0u];
                    let _e1562 = boxMax_1[0u];
                    let _e1563 = e;
                    phi_4563_ = (_e1560 > (_e1562 - _e1563));
                }
                let _e1567 = phi_4563_;
                if _e1567 {
                    let _e1568 = edgesFront;
                    edgesFront = (_e1568 + 1i);
                }
                let _e1571 = hitPosFront[1u];
                let _e1573 = boxMin_2[1u];
                let _e1574 = e;
                let _e1576 = (_e1571 < (_e1573 + _e1574));
                phi_4585_ = _e1576;
                if !(_e1576) {
                    let _e1579 = hitPosFront[1u];
                    let _e1581 = boxMax_1[1u];
                    let _e1582 = e;
                    phi_4585_ = (_e1579 > (_e1581 - _e1582));
                }
                let _e1586 = phi_4585_;
                if _e1586 {
                    let _e1587 = edgesFront;
                    edgesFront = (_e1587 + 1i);
                }
                let _e1590 = hitPosFront[2u];
                let _e1592 = boxMin_2[2u];
                let _e1593 = e;
                let _e1595 = (_e1590 < (_e1592 + _e1593));
                phi_4607_ = _e1595;
                if !(_e1595) {
                    let _e1598 = hitPosFront[2u];
                    let _e1600 = boxMax_1[2u];
                    let _e1601 = e;
                    phi_4607_ = (_e1598 > (_e1600 - _e1601));
                }
                let _e1605 = phi_4607_;
                if _e1605 {
                    let _e1606 = edgesFront;
                    edgesFront = (_e1606 + 1i);
                }
                let _e1608 = edgesFront;
                if (_e1608 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1611 = hitPosBack[0u];
                let _e1613 = boxMin_2[0u];
                let _e1614 = e;
                let _e1616 = (_e1611 < (_e1613 + _e1614));
                phi_4635_ = _e1616;
                if !(_e1616) {
                    let _e1619 = hitPosBack[0u];
                    let _e1621 = boxMax_1[0u];
                    let _e1622 = e;
                    phi_4635_ = (_e1619 > (_e1621 - _e1622));
                }
                let _e1626 = phi_4635_;
                if _e1626 {
                    let _e1627 = edgesBack;
                    edgesBack = (_e1627 + 1i);
                }
                let _e1630 = hitPosBack[1u];
                let _e1632 = boxMin_2[1u];
                let _e1633 = e;
                let _e1635 = (_e1630 < (_e1632 + _e1633));
                phi_4657_ = _e1635;
                if !(_e1635) {
                    let _e1638 = hitPosBack[1u];
                    let _e1640 = boxMax_1[1u];
                    let _e1641 = e;
                    phi_4657_ = (_e1638 > (_e1640 - _e1641));
                }
                let _e1645 = phi_4657_;
                if _e1645 {
                    let _e1646 = edgesBack;
                    edgesBack = (_e1646 + 1i);
                }
                let _e1649 = hitPosBack[2u];
                let _e1651 = boxMin_2[2u];
                let _e1652 = e;
                let _e1654 = (_e1649 < (_e1651 + _e1652));
                phi_4679_ = _e1654;
                if !(_e1654) {
                    let _e1657 = hitPosBack[2u];
                    let _e1659 = boxMax_1[2u];
                    let _e1660 = e;
                    phi_4679_ = (_e1657 > (_e1659 - _e1660));
                }
                let _e1664 = phi_4679_;
                if _e1664 {
                    let _e1665 = edgesBack;
                    edgesBack = (_e1665 + 1i);
                }
                let _e1667 = edgesBack;
                if (_e1667 >= 2i) {
                    onBackEdge = true;
                }
                let _e1669 = onFrontEdge;
                let _e1670 = distFront;
                let _e1671 = finalDist;
                if (_e1669 && (_e1670 < _e1671)) {
                    let _e1674 = finalColor;
                    let _e1676 = cursorColor;
                    let _e1678 = mix(_e1674.xyz, _e1676, vec3(0.9f));
                    finalColor[0u] = _e1678.x;
                    finalColor[1u] = _e1678.y;
                    finalColor[2u] = _e1678.z;
                } else {
                    let _e1685 = onBackEdge;
                    let _e1686 = distBack;
                    let _e1687 = finalDist;
                    if (_e1685 && (_e1686 < _e1687)) {
                        let _e1690 = finalColor;
                        let _e1692 = cursorColor;
                        let _e1694 = mix(_e1690.xyz, _e1692, vec3(0.2f));
                        finalColor[0u] = _e1694.x;
                        finalColor[1u] = _e1694.y;
                        finalColor[2u] = _e1694.z;
                    } else {
                        let _e1701 = distFront;
                        let _e1702 = finalDist;
                        if (_e1701 < _e1702) {
                            let _e1704 = finalColor;
                            let _e1706 = cursorColor;
                            let _e1708 = mix(_e1704.xyz, _e1706, vec3(0.15f));
                            finalColor[0u] = _e1708.x;
                            finalColor[1u] = _e1708.y;
                            finalColor[2u] = _e1708.z;
                        }
                    }
                }
            }
        }
    }
    let _e1715 = hitFrontBox;
    if _e1715 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1716 = finalColor;
    outColor = _e1716;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
