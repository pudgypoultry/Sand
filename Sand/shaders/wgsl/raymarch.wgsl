// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 3de19a2d2a11f17d40a09011bdb092e1a0e1640c8b04444cce6d31ae0d92d3b7

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
    let _e263 = (*p);
    return fract((sin(dot(_e263, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x: ptr<function, i32>, z: ptr<function, i32>) -> u32 {
    let _e264 = (*x);
    let _e265 = (*z);
    let _e267 = tuning.gridWidth;
    return (bitcast<u32>((_e264 + (_e265 * bitcast<i32>(_e267)))) * 4u);
}

fn sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b(x_1: ptr<function, i32>, z_1: ptr<function, i32>, count: ptr<function, f32>, topY: ptr<function, f32>) {
    var b: u32;
    var param: i32;
    var param_1: i32;
    var phi_2383_: bool;
    var phi_2395_: bool;

    let _e269 = (*x_1);
    let _e270 = (_e269 < 0i);
    phi_2383_ = _e270;
    if !(_e270) {
        let _e272 = (*x_1);
        let _e274 = tuning.gridWidth;
        phi_2383_ = (_e272 >= bitcast<i32>(_e274));
    }
    let _e278 = phi_2383_;
    let _e279 = (*z_1);
    let _e281 = (_e278 || (_e279 < 0i));
    phi_2395_ = _e281;
    if !(_e281) {
        let _e283 = (*z_1);
        let _e285 = tuning.gridDepth;
        phi_2395_ = (_e283 >= bitcast<i32>(_e285));
    }
    let _e289 = phi_2395_;
    if _e289 {
        (*count) = 0f;
        (*topY) = 0f;
        return;
    }
    let _e290 = (*x_1);
    param = _e290;
    let _e291 = (*z_1);
    param_1 = _e291;
    let _e292 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param), (&param_1));
    b = _e292;
    let _e293 = b;
    let _e297 = unnamed.cloudColumn[(_e293 + 2u)];
    (*count) = f32(_e297);
    let _e299 = b;
    let _e303 = unnamed.cloudColumn[(_e299 + 3u)];
    (*topY) = f32(_e303);
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

    let _e297 = (*x_2);
    param_2 = _e297;
    let _e298 = (*z_2);
    param_3 = _e298;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_2), (&param_3), (&param_4), (&param_5));
    let _e299 = param_4;
    c0_ = _e299;
    let _e300 = param_5;
    y0_ = _e300;
    let _e301 = (*x_2);
    let _e302 = (*spread);
    param_6 = (_e301 - _e302);
    let _e304 = (*z_2);
    param_7 = _e304;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_6), (&param_7), (&param_8), (&param_9));
    let _e305 = param_8;
    c1_ = _e305;
    let _e306 = param_9;
    y1_ = _e306;
    let _e307 = (*x_2);
    let _e308 = (*spread);
    param_10 = (_e307 + _e308);
    let _e310 = (*z_2);
    param_11 = _e310;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_10), (&param_11), (&param_12), (&param_13));
    let _e311 = param_12;
    c2_ = _e311;
    let _e312 = param_13;
    y2_ = _e312;
    let _e313 = (*z_2);
    let _e314 = (*spread);
    let _e316 = (*x_2);
    param_14 = _e316;
    param_15 = (_e313 - _e314);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_14), (&param_15), (&param_16), (&param_17));
    let _e317 = param_16;
    c3_ = _e317;
    let _e318 = param_17;
    y3_ = _e318;
    let _e319 = (*z_2);
    let _e320 = (*spread);
    let _e322 = (*x_2);
    param_18 = _e322;
    param_19 = (_e319 + _e320);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_18), (&param_19), (&param_20), (&param_21));
    let _e323 = param_20;
    c4_ = _e323;
    let _e324 = param_21;
    y4_ = _e324;
    let _e325 = c0_;
    let _e327 = c1_;
    let _e329 = c2_;
    let _e331 = c3_;
    let _e333 = c4_;
    (*count_1) = ((((((_e325 * 2f) + _e327) + _e329) + _e331) + _e333) / 6f);
    let _e336 = y0_;
    let _e337 = y1_;
    let _e339 = y2_;
    let _e340 = y3_;
    let _e343 = y4_;
    (*topY_1) = max(max(max(_e336, _e337), max(_e339, _e340)), _e343);
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
    var phi_2694_: bool;
    var phi_2705_: bool;
    var phi_2762_: bool;

    let _e311 = (*tEnter);
    (*tEnter) = max(_e311, 0f);
    let _e313 = (*tEnter);
    let _e314 = (*tExit);
    if (_e313 >= _e314) {
        return false;
    }
    let _e316 = (*rayOrigin);
    let _e317 = (*rayDir);
    let _e318 = (*tEnter);
    startPos = (_e316 + (_e317 * _e318));
    let _e321 = startPos;
    let _e323 = tuning.cloudVoxelSize;
    cellPos = vec3<i32>(floor((_e321 / vec3(_e323))));
    let _e328 = (*rayDir);
    stepDir = vec3<i32>(sign(_e328));
    let _e332 = (*rayDir)[0u];
    if (_e332 == 0f) {
        local = 100000000f;
    } else {
        let _e335 = tuning.cloudVoxelSize;
        let _e337 = (*rayDir)[0u];
        local = abs((_e335 / _e337));
    }
    let _e340 = local;
    let _e342 = (*rayDir)[1u];
    if (_e342 == 0f) {
        local_1 = 100000000f;
    } else {
        let _e345 = tuning.cloudVoxelSize;
        let _e347 = (*rayDir)[1u];
        local_1 = abs((_e345 / _e347));
    }
    let _e350 = local_1;
    let _e352 = (*rayDir)[2u];
    if (_e352 == 0f) {
        local_2 = 100000000f;
    } else {
        let _e355 = tuning.cloudVoxelSize;
        let _e357 = (*rayDir)[2u];
        local_2 = abs((_e355 / _e357));
    }
    let _e360 = local_2;
    tDelta = vec3<f32>(_e340, _e350, _e360);
    let _e362 = startPos;
    let _e364 = tuning.cloudVoxelSize;
    let _e367 = cellPos;
    fracPos = ((_e362 / vec3(_e364)) - vec3<f32>(_e367));
    let _e370 = (*tEnter);
    let _e372 = stepDir[0u];
    if (_e372 > 0i) {
        let _e375 = fracPos[0u];
        let _e378 = tDelta[0u];
        local_3 = ((1f - _e375) * _e378);
    } else {
        let _e381 = fracPos[0u];
        let _e383 = tDelta[0u];
        local_3 = (_e381 * _e383);
    }
    let _e385 = local_3;
    let _e387 = stepDir[1u];
    if (_e387 > 0i) {
        let _e390 = fracPos[1u];
        let _e393 = tDelta[1u];
        local_4 = ((1f - _e390) * _e393);
    } else {
        let _e396 = fracPos[1u];
        let _e398 = tDelta[1u];
        local_4 = (_e396 * _e398);
    }
    let _e400 = local_4;
    let _e402 = stepDir[2u];
    if (_e402 > 0i) {
        let _e405 = fracPos[2u];
        let _e408 = tDelta[2u];
        local_5 = ((1f - _e405) * _e408);
    } else {
        let _e411 = fracPos[2u];
        let _e413 = tDelta[2u];
        local_5 = (_e411 * _e413);
    }
    let _e415 = local_5;
    tMax = (vec3(_e370) + vec3<f32>(_e385, _e400, _e415));
    normal = vec3<f32>(0f, 1f, 0f);
    let _e419 = (*tEnter);
    t = _e419;
    let _e421 = tuning.cloudVoxelSize;
    spread_1 = max(1i, i32(_e421));
    i = 0i;
    loop {
        let _e424 = i;
        let _e426 = tuning.maxCloudSteps;
        if (_e424 < bitcast<i32>(_e426)) {
            let _e429 = t;
            let _e430 = (*tExit);
            if (_e429 > _e430) {
                break;
            }
            let _e432 = cellPos;
            let _e437 = tuning.cloudVoxelSize;
            cellCenter = ((vec3<f32>(_e432) + vec3(0.5f)) * _e437);
            let _e440 = cellCenter[0u];
            cx = i32(floor(_e440));
            let _e444 = cellCenter[2u];
            cz = i32(floor(_e444));
            let _e447 = cx;
            let _e448 = (_e447 >= 0i);
            phi_2694_ = _e448;
            if _e448 {
                let _e449 = cx;
                let _e451 = tuning.gridWidth;
                phi_2694_ = (_e449 < bitcast<i32>(_e451));
            }
            let _e455 = phi_2694_;
            let _e456 = cz;
            let _e458 = (_e455 && (_e456 >= 0i));
            phi_2705_ = _e458;
            if _e458 {
                let _e459 = cz;
                let _e461 = tuning.gridDepth;
                phi_2705_ = (_e459 < bitcast<i32>(_e461));
            }
            let _e465 = phi_2705_;
            if _e465 {
                let _e466 = cx;
                param_22 = _e466;
                let _e467 = cz;
                param_23 = _e467;
                let _e468 = spread_1;
                param_24 = _e468;
                smoothedCloudColumn_u0028_i1_u003b_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_22), (&param_23), (&param_24), (&param_25), (&param_26));
                let _e469 = param_25;
                count_2 = _e469;
                let _e470 = param_26;
                baseY = _e470;
                let _e471 = count_2;
                if (_e471 > 0f) {
                    let _e474 = tuning.cloudVoxelSize;
                    cell = max(_e474, 0.5f);
                    let _e476 = count_2;
                    let _e478 = tuning.cloudThicknessPerBlock;
                    thickness = (_e476 * max(_e478, 0.01f));
                    let _e481 = baseY;
                    let _e482 = cell;
                    let _e485 = cell;
                    baseY = (floor((_e481 / _e482)) * _e485);
                    let _e487 = baseY;
                    let _e488 = thickness;
                    let _e489 = cell;
                    let _e493 = cell;
                    capY = (_e487 + (max(floor((_e488 / _e489)), 1f) * _e493));
                    let _e497 = cellCenter[1u];
                    let _e498 = baseY;
                    let _e499 = (_e497 >= _e498);
                    phi_2762_ = _e499;
                    if _e499 {
                        let _e501 = cellCenter[1u];
                        let _e502 = capY;
                        phi_2762_ = (_e501 <= _e502);
                    }
                    let _e505 = phi_2762_;
                    if _e505 {
                        let _e506 = count_2;
                        let _e508 = tuning.cloudColumnFullCount;
                        density = clamp((_e506 / max(_e508, 1f)), 0f, 1f);
                        let _e512 = baseY;
                        let _e513 = capY;
                        mid = ((_e512 + _e513) * 0.5f);
                        let _e517 = cellCenter[1u];
                        let _e518 = mid;
                        let _e521 = thickness;
                        edgeFactor = clamp((abs((_e517 - _e518)) / max((_e521 * 0.5f), 0.001f)), 0f, 1f);
                        let _e527 = tuning.cloudEdgeThresholdMin;
                        let _e529 = tuning.cloudEdgeThresholdMax;
                        let _e530 = edgeFactor;
                        threshold = mix(_e527, _e529, _e530);
                        let _e532 = cellPos;
                        param_27 = vec3<f32>(_e532);
                        let _e534 = hash_u0028_vf3_u003b((&param_27));
                        fillHash = _e534;
                        let _e535 = fillHash;
                        let _e536 = threshold;
                        if (_e535 > _e536) {
                            let _e538 = t;
                            (*tHit) = _e538;
                            let _e539 = density;
                            (*hitDensity) = _e539;
                            let _e540 = cellPos;
                            param_28 = ((vec3<f32>(_e540) * 3.71f) + vec3<f32>(91f, 5f, 7f));
                            let _e544 = hash_u0028_vf3_u003b((&param_28));
                            shadeHash = _e544;
                            let _e545 = shadeHash;
                            baseColor = mix(vec3<f32>(0.9f, 0.91f, 0.94f), vec3<f32>(1f, 1f, 1f), vec3(_e545));
                            stormColor = vec3<f32>(0.32f, 0.33f, 0.36f);
                            let _e548 = baseColor;
                            let _e549 = stormColor;
                            let _e550 = (*greyness);
                            baseColor = mix(_e548, _e549, vec3(_e550));
                            let _e553 = normal;
                            let _e554 = (*sunDir);
                            diffuse = (0.6f + (0.4f * max(dot(_e553, _e554), 0f)));
                            let _e559 = baseColor;
                            let _e560 = diffuse;
                            (*hitColor) = (_e559 * _e560);
                            return true;
                        }
                    }
                }
            }
            let _e563 = tMax[0u];
            let _e565 = tMax[1u];
            if (_e563 < _e565) {
                let _e568 = tMax[0u];
                let _e570 = tMax[2u];
                if (_e568 < _e570) {
                    let _e573 = stepDir[0u];
                    let _e575 = cellPos[0u];
                    cellPos[0u] = (_e575 + _e573);
                    let _e579 = tMax[0u];
                    t = _e579;
                    let _e581 = tDelta[0u];
                    let _e583 = tMax[0u];
                    tMax[0u] = (_e583 + _e581);
                    let _e587 = stepDir[0u];
                    normal = vec3<f32>(f32(-(_e587)), 0f, 0f);
                } else {
                    let _e592 = stepDir[2u];
                    let _e594 = cellPos[2u];
                    cellPos[2u] = (_e594 + _e592);
                    let _e598 = tMax[2u];
                    t = _e598;
                    let _e600 = tDelta[2u];
                    let _e602 = tMax[2u];
                    tMax[2u] = (_e602 + _e600);
                    let _e606 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e606)));
                }
            } else {
                let _e611 = tMax[1u];
                let _e613 = tMax[2u];
                if (_e611 < _e613) {
                    let _e616 = stepDir[1u];
                    let _e618 = cellPos[1u];
                    cellPos[1u] = (_e618 + _e616);
                    let _e622 = tMax[1u];
                    t = _e622;
                    let _e624 = tDelta[1u];
                    let _e626 = tMax[1u];
                    tMax[1u] = (_e626 + _e624);
                    let _e630 = stepDir[1u];
                    normal = vec3<f32>(0f, f32(-(_e630)), 0f);
                } else {
                    let _e635 = stepDir[2u];
                    let _e637 = cellPos[2u];
                    cellPos[2u] = (_e637 + _e635);
                    let _e641 = tMax[2u];
                    t = _e641;
                    let _e643 = tDelta[2u];
                    let _e645 = tMax[2u];
                    tMax[2u] = (_e645 + _e643);
                    let _e649 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e649)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e653 = i;
            i = (_e653 + 1i);
        }
    }
    return false;
}

fn renderBlackHole_u0028_vf3_u003b_vf3_u003b(normal_1: ptr<function, vec3<f32>>, rayDir_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var rim: f32;
    var glow: f32;

    let _e266 = (*normal_1);
    let _e267 = (*rayDir_1);
    rim = (1f - abs(dot(_e266, _e267)));
    let _e271 = rim;
    glow = pow(clamp(_e271, 0f, 1f), 4f);
    let _e274 = glow;
    return mix(vec3<f32>(0.01f, 0.01f, 0.02f), vec3<f32>(0.85f, 0.45f, 1f), vec3((_e274 * 0.7f)));
}

fn bhDecode_u0028_u1_u003b(code: ptr<function, u32>) -> vec3<i32> {
    var i_1: u32;

    let _e264 = (*code);
    i_1 = (_e264 & 1073741823u);
    let _e266 = i_1;
    let _e268 = tuning.gridWidth;
    let _e273 = i_1;
    let _e275 = tuning.gridWidth;
    let _e280 = tuning.gridHeight;
    let _e285 = i_1;
    let _e287 = tuning.gridWidth;
    let _e290 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e266 % bitcast<u32>(bitcast<i32>(_e268)))), bitcast<i32>(((_e273 / bitcast<u32>(bitcast<i32>(_e275))) % bitcast<u32>(bitcast<i32>(_e280)))), bitcast<i32>((_e285 / bitcast<u32>((bitcast<i32>(_e287) * bitcast<i32>(_e290))))));
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e263 = (*level);
    return (f32(_e263) + 0.5f);
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
        let _e268 = l;
        let _e270 = tuning.blackHoleMaxLevel;
        if (_e268 <= min(_e270, 16u)) {
            let _e273 = l;
            param_29 = _e273;
            let _e274 = bhBodyRadius_u0028_u1_u003b((&param_29));
            r = _e274;
            let _e275 = r;
            let _e277 = r;
            let _e279 = r;
            volume = (((4.18879f * _e275) * _e277) * _e279);
            let _e281 = (*mass);
            let _e284 = tuning.blackHoleGrowthCost;
            let _e285 = volume;
            if (f32(_e281) < (_e284 * _e285)) {
                break;
            }
            let _e288 = l;
            level_1 = _e288;
            continue;
        } else {
            break;
        }
        continuing {
            let _e289 = l;
            l = (_e289 + bitcast<u32>(1i));
        }
    }
    let _e292 = level_1;
    return _e292;
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

    let _e275 = unnamed.blackHoleCount;
    let _e276 = (_e275 == 0u);
    phi_2268_ = _e276;
    if !(_e276) {
        let _e279 = tuning.blackHoleGlow;
        phi_2268_ = (_e279 <= 0f);
    }
    let _e282 = phi_2268_;
    if _e282 {
        let _e283 = (*color);
        return _e283;
    }
    let _e285 = tuning.blackHoleRadius;
    radius = f32(_e285);
    let _e287 = radius;
    let _e288 = radius;
    closestSq = (_e287 * _e288);
    seen = 0u;
    i_2 = 0i;
    loop {
        let _e290 = i_2;
        let _e291 = (_e290 < 8i);
        phi_2297_ = _e291;
        if _e291 {
            let _e292 = seen;
            let _e294 = unnamed.blackHoleCount;
            phi_2297_ = (_e292 < _e294);
        }
        let _e297 = phi_2297_;
        if _e297 {
            let _e298 = i_2;
            let _e301 = unnamed.blackHoles[_e298];
            code_1 = _e301;
            let _e302 = code_1;
            if (_e302 == 0u) {
                continue;
            }
            let _e304 = seen;
            seen = (_e304 + bitcast<u32>(1i));
            let _e307 = code_1;
            param_30 = _e307;
            let _e308 = bhDecode_u0028_u1_u003b((&param_30));
            let _e309 = (*voxelPos);
            d = vec3<f32>((_e308 - _e309));
            let _e312 = closestSq;
            let _e313 = d;
            let _e314 = d;
            closestSq = min(_e312, dot(_e313, _e314));
            continue;
        } else {
            break;
        }
        continuing {
            let _e317 = i_2;
            i_2 = (_e317 + 1i);
        }
    }
    let _e319 = closestSq;
    let _e320 = radius;
    let _e321 = radius;
    if (_e319 >= (_e320 * _e321)) {
        let _e324 = (*color);
        return _e324;
    }
    let _e325 = closestSq;
    closest = sqrt(_e325);
    let _e327 = closest;
    let _e328 = radius;
    let _e333 = tuning.blackHoleGlow;
    heat = (pow((1f - (_e327 / _e328)), 3f) * _e333);
    let _e335 = heat;
    hot = mix(vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(1f, 0.95f, 0.85f), vec3(clamp(_e335, 0f, 1f)));
    let _e339 = (*color);
    let _e340 = hot;
    let _e341 = heat;
    return mix(_e339, _e340, vec3(clamp(_e341, 0f, 1f)));
}

fn renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b(rawVoxel: ptr<function, u32>, voxelPos_1: ptr<function, vec3<i32>>, baseLighting: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n: f32;
    var param_31: vec3<f32>;
    var dist: u32;
    var depth: f32;
    var inner: vec3<f32>;
    var outer: vec3<f32>;
    var leaf: vec3<f32>;

    let _e272 = (*voxelPos_1);
    param_31 = vec3<f32>(_e272);
    let _e274 = hash_u0028_vf3_u003b((&param_31));
    n = _e274;
    let _e275 = (*rawVoxel);
    dist = ((_e275 >> bitcast<u32>(24i)) & 255u);
    let _e279 = dist;
    if (_e279 == 255u) {
        let _e281 = n;
        let _e284 = (*baseLighting);
        return (mix(vec3<f32>(0.34f, 0.22f, 0.07f), vec3<f32>(0.52f, 0.38f, 0.12f), vec3(_e281)) * _e284);
    }
    let _e286 = dist;
    let _e289 = tuning.treeLeafReach;
    depth = clamp((f32(_e286) / max(f32(_e289), 1f)), 0f, 1f);
    inner = vec3<f32>(0.1f, 0.3f, 0.09f);
    outer = vec3<f32>(0.28f, 0.52f, 0.16f);
    let _e294 = inner;
    let _e295 = outer;
    let _e296 = depth;
    let _e298 = n;
    leaf = mix(_e294, _e295, vec3(((_e296 * 0.7f) + (_e298 * 0.3f))));
    let _e303 = leaf;
    let _e304 = (*baseLighting);
    return (_e303 * _e304);
}

fn renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_2: ptr<function, vec3<i32>>, subCell: ptr<function, vec3<f32>>, baseLighting_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var grain: f32;
    var param_32: vec3<f32>;
    var bark: vec3<f32>;

    let _e269 = (*voxelPos_2)[0u];
    let _e272 = (*voxelPos_2)[1u];
    let _e276 = (*subCell)[1u];
    let _e280 = (*voxelPos_2)[2u];
    param_32 = vec3<f32>(f32(_e269), ((f32(_e272) * 0.35f) + (_e276 * 0.2f)), f32(_e280));
    let _e283 = hash_u0028_vf3_u003b((&param_32));
    grain = _e283;
    let _e284 = grain;
    bark = mix(vec3<f32>(0.2f, 0.13f, 0.07f), vec3<f32>(0.38f, 0.25f, 0.13f), vec3(_e284));
    let _e287 = bark;
    let _e288 = (*baseLighting_1);
    return (_e287 * _e288);
}

fn renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_3: ptr<function, vec3<i32>>, subCell_1: ptr<function, vec3<f32>>, baseLighting_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_1: f32;
    var param_33: vec3<f32>;
    var shell: vec3<f32>;

    let _e268 = (*subCell_1);
    let _e270 = (*voxelPos_3);
    param_33 = ((_e268 * 1.37f) + (vec3<f32>(_e270) * 0.11f));
    let _e274 = hash_u0028_vf3_u003b((&param_33));
    n_1 = _e274;
    let _e275 = n_1;
    shell = mix(vec3<f32>(0.15f, 0.1f, 0.035f), vec3<f32>(0.55f, 0.4f, 0.11f), vec3(_e275));
    let _e278 = shell;
    let _e279 = (*baseLighting_2);
    return (_e278 * _e279);
}

fn renderDarkStone_u0028_vi3_u003b_vf3_u003b(voxelPos_4: ptr<function, vec3<i32>>, baseLighting_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise: f32;
    var param_34: vec3<f32>;
    var val: f32;

    let _e267 = (*voxelPos_4);
    param_34 = vec3<f32>(_e267);
    let _e269 = hash_u0028_vf3_u003b((&param_34));
    noise = _e269;
    let _e270 = noise;
    val = (0.1f + (_e270 * 0.06f));
    let _e273 = val;
    let _e275 = val;
    let _e277 = val;
    let _e280 = (*baseLighting_3);
    return (vec3<f32>((_e273 * 1.08f), (_e275 * 0.94f), (_e277 * 0.92f)) * _e280);
}

fn lavaStageColor_u0028_i1_u003b(stage: ptr<function, i32>) -> vec3<f32> {
    var indexable: array<vec3<f32>, 6>;

    let _e264 = (*stage);
    indexable = array<vec3<f32>, 6>(vec3<f32>(1f, 0.62f, 0.22f), vec3<f32>(1f, 0.4f, 0.07f), vec3<f32>(0.96f, 0.29f, 0.05f), vec3<f32>(0.86f, 0.2f, 0.04f), vec3<f32>(0.7f, 0.13f, 0.03f), vec3<f32>(0.44f, 0.07f, 0.02f));
    let _e268 = indexable[clamp((_e264 + 1i), 0i, 5i)];
    return _e268;
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

    let _e278 = (*rawVoxel_1);
    stage_1 = clamp((bitcast<i32>((_e278 & 255u)) - 8i), 0i, 3i);
    let _e284 = pc.time;
    let _e286 = tuning.lavaChurnRate;
    let _e288 = (*voxelPos_5);
    param_35 = vec3<f32>(_e288);
    let _e290 = hash_u0028_vf3_u003b((&param_35));
    phase = fract(((_e284 * _e286) + _e290));
    let _e293 = phase;
    if (_e293 < 0.33333334f) {
        let _e295 = stage_1;
        param_36 = (_e295 - 1i);
        let _e297 = lavaStageColor_u0028_i1_u003b((&param_36));
        from_ = _e297;
        let _e298 = stage_1;
        param_37 = _e298;
        let _e299 = lavaStageColor_u0028_i1_u003b((&param_37));
        to = _e299;
        let _e300 = phase;
        leg = (_e300 * 3f);
    } else {
        let _e302 = phase;
        if (_e302 < 0.6666667f) {
            let _e304 = stage_1;
            param_38 = _e304;
            let _e305 = lavaStageColor_u0028_i1_u003b((&param_38));
            from_ = _e305;
            let _e306 = stage_1;
            param_39 = (_e306 + 1i);
            let _e308 = lavaStageColor_u0028_i1_u003b((&param_39));
            to = _e308;
            let _e309 = phase;
            leg = ((_e309 * 3f) - 1f);
        } else {
            let _e312 = stage_1;
            param_40 = (_e312 + 1i);
            let _e314 = lavaStageColor_u0028_i1_u003b((&param_40));
            from_ = _e314;
            let _e315 = stage_1;
            param_41 = (_e315 - 1i);
            let _e317 = lavaStageColor_u0028_i1_u003b((&param_41));
            to = _e317;
            let _e318 = phase;
            leg = ((_e318 * 3f) - 2f);
        }
    }
    let _e321 = from_;
    let _e322 = to;
    let _e323 = leg;
    molten = mix(_e321, _e322, vec3(smoothstep(0f, 1f, _e323)));
    let _e327 = molten;
    let _e328 = (*voxelPos_5);
    param_42 = (vec3<f32>(_e328) * 1.7f);
    let _e331 = hash_u0028_vf3_u003b((&param_42));
    return (_e327 * (0.9f + (_e331 * 0.1f)));
}

fn renderSteam_u0028_vi3_u003b_vf3_u003b(voxelPos_6: ptr<function, vec3<i32>>, baseLighting_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_1: f32;
    var param_43: vec3<f32>;
    var val_1: f32;
    var baseColor_1: vec3<f32>;

    let _e268 = (*voxelPos_6);
    let _e271 = pc.time;
    param_43 = (vec3<f32>(_e268) + vec3(_e271));
    let _e274 = hash_u0028_vf3_u003b((&param_43));
    noise_1 = _e274;
    let _e275 = noise_1;
    val_1 = (0.85f + (_e275 * 0.15f));
    let _e278 = val_1;
    baseColor_1 = vec3(_e278);
    let _e280 = baseColor_1;
    let _e281 = (*baseLighting_4);
    return ((_e280 * _e281) * 0.9f);
}

fn renderFire_u0028_u1_u003b_vi3_u003b(rawVoxel_2: ptr<function, u32>, voxelPos_7: ptr<function, vec3<i32>>) -> vec3<f32> {
    var noise_2: f32;
    var param_44: vec3<f32>;
    var age: u32;
    var life: f32;
    var coreColor: vec3<f32>;
    var edgeColor: vec3<f32>;
    var fireColor: vec3<f32>;

    let _e271 = (*voxelPos_7);
    let _e274 = pc.time;
    param_44 = (vec3<f32>(_e271) + vec3((_e274 * 10f)));
    let _e278 = hash_u0028_vf3_u003b((&param_44));
    noise_2 = _e278;
    let _e279 = (*rawVoxel_2);
    age = ((_e279 >> bitcast<u32>(24i)) & 255u);
    let _e283 = age;
    life = clamp((f32(_e283) / 30f), 0f, 1f);
    coreColor = vec3<f32>(1f, 0.9f, 0.2f);
    edgeColor = vec3<f32>(1f, 0.3f, 0f);
    let _e287 = coreColor;
    let _e288 = edgeColor;
    let _e289 = life;
    let _e290 = noise_2;
    fireColor = mix(_e287, _e288, vec3((_e289 + (_e290 * 0.3f))));
    let _e295 = fireColor;
    return (_e295 * 1.5f);
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

    let _e278 = (*voxelPos_8);
    param_45 = vec3<f32>(_e278);
    let _e280 = hash_u0028_vf3_u003b((&param_45));
    noise_3 = _e280;
    let _e281 = noise_3;
    val_2 = (0.8f + (_e281 * 0.2f));
    let _e284 = (*rawVoxel_3);
    moisture = ((_e284 >> bitcast<u32>(24i)) & 255u);
    let _e288 = moisture;
    wetness = clamp((f32(_e288) / 30f), 0f, 1f);
    let _e292 = val_2;
    let _e294 = val_2;
    let _e296 = val_2;
    dryColor = vec3<f32>((0.4f * _e292), (0.25f * _e294), (0.1f * _e296));
    let _e299 = val_2;
    let _e301 = val_2;
    let _e303 = val_2;
    wetColor = vec3<f32>((0.15f * _e299), (0.08f * _e301), (0.03f * _e303));
    let _e306 = dryColor;
    let _e307 = wetColor;
    let _e308 = wetness;
    baseColor_2 = mix(_e306, _e307, vec3(_e308));
    let _e311 = (*rawVoxel_3);
    floraState = ((_e311 >> bitcast<u32>(8i)) & 255u);
    let _e315 = floraState;
    let _e316 = (_e315 > 10u);
    phi_1269_ = _e316;
    if _e316 {
        let _e318 = (*ddaNormal)[1u];
        phi_1269_ = (_e318 > 0.5f);
    }
    let _e321 = phi_1269_;
    if _e321 {
        let _e322 = floraState;
        grassGrow = clamp((f32((_e322 - 10u)) / 90f), 0f, 1f);
        let _e327 = noise_3;
        let _e330 = noise_3;
        grassColor = vec3<f32>((0.15f + (_e327 * 0.1f)), (0.45f + (_e330 * 0.15f)), 0.15f);
        let _e334 = floraState;
        if (_e334 > 100u) {
            let _e336 = floraState;
            drown = clamp((f32((_e336 - 100u)) / 100f), 0f, 1f);
            let _e341 = grassColor;
            let _e342 = drown;
            grassColor = mix(_e341, vec3<f32>(0.35f, 0.35f, 0.15f), vec3(_e342));
        }
        let _e345 = baseColor_2;
        let _e346 = grassColor;
        let _e347 = grassGrow;
        baseColor_2 = mix(_e345, _e346, vec3(_e347));
    }
    let _e350 = baseColor_2;
    let _e351 = (*baseLighting_5);
    return (_e350 * _e351);
}

fn renderStone_u0028_vi3_u003b_vf3_u003b(voxelPos_9: ptr<function, vec3<i32>>, baseLighting_6: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_4: f32;
    var param_46: vec3<f32>;
    var val_3: f32;
    var baseColor_3: vec3<f32>;

    let _e268 = (*voxelPos_9);
    param_46 = vec3<f32>(_e268);
    let _e270 = hash_u0028_vf3_u003b((&param_46));
    noise_4 = _e270;
    let _e271 = noise_4;
    val_3 = (0.4f + (_e271 * 0.3f));
    let _e274 = val_3;
    baseColor_3 = vec3(_e274);
    let _e276 = baseColor_3;
    let _e277 = (*baseLighting_6);
    return (_e276 * _e277);
}

fn renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b(voxelPos_10: ptr<function, vec3<i32>>, normal_2: ptr<function, vec3<f32>>, rayOrigin_1: ptr<function, vec3<f32>>, sunDir_1: ptr<function, vec3<f32>>, sunColor: ptr<function, vec3<f32>>, shadow: ptr<function, f32>, baseLighting_7: ptr<function, vec3<f32>>) -> vec3<f32> {
    var baseColor_4: vec3<f32>;
    var viewDir: vec3<f32>;
    var reflectDir: vec3<f32>;
    var spec: f32;
    var finalLighting: vec3<f32>;

    baseColor_4 = vec3<f32>(0.1f, 0.4f, 0.9f);
    let _e274 = (*rayOrigin_1);
    let _e275 = (*voxelPos_10);
    viewDir = normalize((_e274 - vec3<f32>(_e275)));
    let _e279 = (*sunDir_1);
    let _e281 = (*normal_2);
    reflectDir = reflect(-(_e279), _e281);
    let _e283 = viewDir;
    let _e284 = reflectDir;
    spec = pow(max(dot(_e283, _e284), 0f), 32f);
    let _e288 = (*baseLighting_7);
    let _e289 = (*sunColor);
    let _e290 = spec;
    let _e293 = (*shadow);
    finalLighting = (_e288 + (((_e289 * _e290) * 0.5f) * _e293));
    let _e296 = baseColor_4;
    let _e297 = finalLighting;
    return (_e296 * _e297);
}

fn renderSand_u0028_u1_u003b_vf3_u003b(rawVoxel_4: ptr<function, u32>, baseLighting_8: ptr<function, vec3<f32>>) -> vec3<f32> {
    var moisture_1: u32;
    var wetness_1: f32;
    var dryColor_1: vec3<f32>;
    var wetColor_1: vec3<f32>;
    var baseColor_5: vec3<f32>;

    let _e269 = (*rawVoxel_4);
    moisture_1 = ((_e269 >> bitcast<u32>(24i)) & 255u);
    let _e273 = moisture_1;
    wetness_1 = clamp((f32(_e273) / 10f), 0f, 1f);
    dryColor_1 = vec3<f32>(0.9f, 0.8f, 0.2f);
    wetColor_1 = vec3<f32>(0.65f, 0.55f, 0.15f);
    let _e277 = dryColor_1;
    let _e278 = wetColor_1;
    let _e279 = wetness_1;
    baseColor_5 = mix(_e277, _e278, vec3(_e279));
    let _e282 = baseColor_5;
    let _e283 = (*baseLighting_8);
    return (_e282 * _e283);
}

fn getVoxel_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    var index: u32;
    var phi_284_: bool;
    var phi_292_: bool;
    var phi_302_: bool;
    var phi_310_: bool;
    var phi_320_: bool;

    let _e265 = (*pos)[0u];
    let _e266 = (_e265 < 0i);
    phi_284_ = _e266;
    if !(_e266) {
        let _e269 = (*pos)[0u];
        let _e271 = tuning.gridWidth;
        phi_284_ = (_e269 >= bitcast<i32>(_e271));
    }
    let _e275 = phi_284_;
    phi_292_ = _e275;
    if !(_e275) {
        let _e278 = (*pos)[1u];
        phi_292_ = (_e278 < 0i);
    }
    let _e281 = phi_292_;
    phi_302_ = _e281;
    if !(_e281) {
        let _e284 = (*pos)[1u];
        let _e286 = tuning.gridHeight;
        phi_302_ = (_e284 >= bitcast<i32>(_e286));
    }
    let _e290 = phi_302_;
    phi_310_ = _e290;
    if !(_e290) {
        let _e293 = (*pos)[2u];
        phi_310_ = (_e293 < 0i);
    }
    let _e296 = phi_310_;
    phi_320_ = _e296;
    if !(_e296) {
        let _e299 = (*pos)[2u];
        let _e301 = tuning.gridDepth;
        phi_320_ = (_e299 >= bitcast<i32>(_e301));
    }
    let _e305 = phi_320_;
    if _e305 {
        return 0u;
    }
    let _e307 = (*pos)[0u];
    let _e309 = (*pos)[1u];
    let _e311 = tuning.gridWidth;
    let _e316 = (*pos)[2u];
    let _e318 = tuning.gridWidth;
    let _e322 = tuning.gridHeight;
    index = bitcast<u32>(((_e307 + (_e309 * bitcast<i32>(_e311))) + ((_e316 * bitcast<i32>(_e318)) * bitcast<i32>(_e322))));
    let _e327 = index;
    let _e330 = unnamed_1.grid[_e327];
    return _e330;
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

    let _e277 = (*hitVoxelPos);
    let _e278 = (*hitNormal);
    voxelPos_11 = (_e277 + vec3<i32>(round(_e278)));
    let _e282 = (*lightDir);
    stepDir_1 = vec3<i32>(sign(_e282));
    let _e286 = (*lightDir)[0u];
    if (_e286 == 0f) {
        local_6 = 100000000f;
    } else {
        let _e289 = (*lightDir)[0u];
        local_6 = abs((1f / _e289));
    }
    let _e292 = local_6;
    let _e294 = (*lightDir)[1u];
    if (_e294 == 0f) {
        local_7 = 100000000f;
    } else {
        let _e297 = (*lightDir)[1u];
        local_7 = abs((1f / _e297));
    }
    let _e300 = local_7;
    let _e302 = (*lightDir)[2u];
    if (_e302 == 0f) {
        local_8 = 100000000f;
    } else {
        let _e305 = (*lightDir)[2u];
        local_8 = abs((1f / _e305));
    }
    let _e308 = local_8;
    tDelta_1 = vec3<f32>(_e292, _e300, _e308);
    let _e310 = tDelta_1;
    tMax_1 = (_e310 * 0.5f);
    transmittance = 1f;
    i_3 = 0i;
    loop {
        let _e312 = i_3;
        let _e314 = tuning.shadowMaxSteps;
        if (_e312 < bitcast<i32>(_e314)) {
            let _e318 = voxelPos_11[0u];
            let _e319 = (_e318 < 0i);
            phi_601_ = _e319;
            if !(_e319) {
                let _e322 = voxelPos_11[0u];
                let _e324 = tuning.gridWidth;
                phi_601_ = (_e322 >= bitcast<i32>(_e324));
            }
            let _e328 = phi_601_;
            phi_608_ = _e328;
            if !(_e328) {
                let _e331 = voxelPos_11[1u];
                phi_608_ = (_e331 < 0i);
            }
            let _e334 = phi_608_;
            phi_616_ = _e334;
            if !(_e334) {
                let _e337 = voxelPos_11[1u];
                let _e338 = (*ceilingY);
                phi_616_ = (_e337 >= _e338);
            }
            let _e341 = phi_616_;
            phi_623_ = _e341;
            if !(_e341) {
                let _e344 = voxelPos_11[2u];
                phi_623_ = (_e344 < 0i);
            }
            let _e347 = phi_623_;
            phi_633_ = _e347;
            if !(_e347) {
                let _e350 = voxelPos_11[2u];
                let _e352 = tuning.gridDepth;
                phi_633_ = (_e350 >= bitcast<i32>(_e352));
            }
            let _e356 = phi_633_;
            if _e356 {
                let _e357 = transmittance;
                return _e357;
            }
            let _e358 = voxelPos_11;
            param_47 = _e358;
            let _e359 = getVoxel_u0028_vi3_u003b((&param_47));
            blockerType = (_e359 & 255u);
            let _e361 = blockerType;
            if (_e361 == 2u) {
                let _e364 = tuning.waterShadowTransmit;
                let _e365 = transmittance;
                transmittance = (_e365 * _e364);
                let _e367 = transmittance;
                if (_e367 < 0.02f) {
                    return 0f;
                }
            } else {
                let _e369 = blockerType;
                if (_e369 != 0u) {
                    return 0f;
                }
            }
            let _e372 = tMax_1[0u];
            let _e374 = tMax_1[1u];
            if (_e372 < _e374) {
                let _e377 = tMax_1[0u];
                let _e379 = tMax_1[2u];
                if (_e377 < _e379) {
                    let _e382 = stepDir_1[0u];
                    let _e384 = voxelPos_11[0u];
                    voxelPos_11[0u] = (_e384 + _e382);
                    let _e388 = tDelta_1[0u];
                    let _e390 = tMax_1[0u];
                    tMax_1[0u] = (_e390 + _e388);
                } else {
                    let _e394 = stepDir_1[2u];
                    let _e396 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e396 + _e394);
                    let _e400 = tDelta_1[2u];
                    let _e402 = tMax_1[2u];
                    tMax_1[2u] = (_e402 + _e400);
                }
            } else {
                let _e406 = tMax_1[1u];
                let _e408 = tMax_1[2u];
                if (_e406 < _e408) {
                    let _e411 = stepDir_1[1u];
                    let _e413 = voxelPos_11[1u];
                    voxelPos_11[1u] = (_e413 + _e411);
                    let _e417 = tDelta_1[1u];
                    let _e419 = tMax_1[1u];
                    tMax_1[1u] = (_e419 + _e417);
                } else {
                    let _e423 = stepDir_1[2u];
                    let _e425 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e425 + _e423);
                    let _e429 = tDelta_1[2u];
                    let _e431 = tMax_1[2u];
                    tMax_1[2u] = (_e431 + _e429);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e434 = i_3;
            i_3 = (_e434 + 1i);
        }
    }
    let _e436 = transmittance;
    return _e436;
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
        let _e269 = x_3;
        if (_e269 <= 1i) {
            y = -1i;
            loop {
                let _e271 = y;
                if (_e271 <= 1i) {
                    z_3 = -1i;
                    loop {
                        let _e273 = z_3;
                        if (_e273 <= 1i) {
                            let _e275 = x_3;
                            let _e277 = y;
                            let _e280 = z_3;
                            if (((_e275 == 0i) && (_e277 == 0i)) && (_e280 == 0i)) {
                                continue;
                            }
                            let _e283 = (*p_1);
                            let _e284 = x_3;
                            let _e285 = y;
                            let _e286 = z_3;
                            param_48 = (_e283 + vec3<i32>(_e284, _e285, _e286));
                            let _e289 = getVoxel_u0028_vi3_u003b((&param_48));
                            if ((_e289 & 255u) == 0u) {
                                continue;
                            }
                            let _e292 = x_3;
                            let _e294 = y;
                            let _e296 = z_3;
                            offset = vec3<f32>(f32(_e292), f32(_e294), f32(_e296));
                            let _e299 = offset;
                            let _e300 = x_3;
                            let _e301 = x_3;
                            let _e303 = y;
                            let _e304 = y;
                            let _e307 = z_3;
                            let _e308 = z_3;
                            let _e314 = n_2;
                            n_2 = (_e314 - (_e299 * inverseSqrt(f32((((_e300 * _e301) + (_e303 * _e304)) + (_e307 * _e308))))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e316 = z_3;
                            z_3 = (_e316 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e318 = y;
                    y = (_e318 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e320 = x_3;
            x_3 = (_e320 + 1i);
        }
    }
    let _e322 = n_2;
    if (length(_e322) < 0.1f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e325 = n_2;
    return normalize(_e325);
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

    let _e278 = tuning.waterWaveScale;
    scale = max(_e278, 0.001f);
    let _e280 = (*t_1);
    let _e282 = tuning.waterWaveSpeed;
    wt = ((_e280 * _e282) * 0.35f);
    let _e285 = (*p_2);
    let _e287 = (*p_2)[1u];
    let _e289 = wt;
    let _e293 = (*p_2)[0u];
    let _e295 = wt;
    q = (_e285 + (vec2<f32>(sin(((_e287 * 0.043f) + _e289)), sin(((_e293 * 0.037f) - (_e295 * 0.8f)))) * 6f));
    grad = vec2<f32>(0f, 0f);
    i_4 = 0i;
    loop {
        let _e302 = i_4;
        if (_e302 < 5i) {
            let _e304 = i_4;
            indexable_1 = array<f32, 5>(0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
            let _e306 = indexable_1[_e304];
            let _e307 = scale;
            f = (_e306 * _e307);
            let _e309 = i_4;
            indexable_2 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e311 = indexable_2[_e309];
            let _e312 = q;
            let _e314 = f;
            let _e316 = (*t_1);
            let _e317 = i_4;
            indexable_3 = array<f32, 5>(1f, 1.37f, 0.83f, 1.71f, 0.61f);
            let _e319 = indexable_3[_e317];
            let _e322 = tuning.waterWaveSpeed;
            phase_1 = ((dot(_e311, _e312) * _e314) + ((_e316 * _e319) * _e322));
            let _e325 = i_4;
            indexable_4 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e327 = indexable_4[_e325];
            let _e328 = i_4;
            indexable_5 = array<f32, 5>(1f, 0.62f, 0.38f, 0.24f, 0.15f);
            let _e330 = indexable_5[_e328];
            let _e331 = f;
            let _e333 = phase_1;
            let _e337 = grad;
            grad = (_e337 + (_e327 * ((_e330 * _e331) * cos(_e333))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e339 = i_4;
            i_4 = (_e339 + 1i);
        }
    }
    let _e342 = (*p_2)[0u];
    let _e345 = (*p_2)[1u];
    let _e348 = (*t_1);
    envelope = (0.45f + (0.55f * sin((((_e342 * 0.021f) + (_e345 * 0.017f)) + (_e348 * 0.11f)))));
    let _e354 = grad;
    let _e355 = envelope;
    return (_e354 * _e355);
}

fn applyWaterWaves_u0028_vf3_u003b_vi3_u003b(normal_3: ptr<function, vec3<f32>>, voxelPos_12: ptr<function, vec3<i32>>) -> vec3<f32> {
    var upness: f32;
    var grad_1: vec2<f32>;
    var param_49: vec2<f32>;
    var param_50: f32;

    let _e269 = tuning.waterWaveStrength;
    if (_e269 <= 0f) {
        let _e271 = (*normal_3);
        return _e271;
    }
    let _e273 = (*normal_3)[1u];
    upness = clamp(_e273, 0f, 1f);
    let _e275 = upness;
    if (_e275 <= 0f) {
        let _e277 = (*normal_3);
        return _e277;
    }
    let _e278 = (*voxelPos_12);
    param_49 = (vec2<f32>(_e278.xz) + vec2<f32>(0.5f, 0.5f));
    let _e283 = pc.time;
    param_50 = _e283;
    let _e284 = waterWaveGradient_u0028_vf2_u003b_f1_u003b((&param_49), (&param_50));
    grad_1 = _e284;
    let _e285 = (*normal_3);
    let _e287 = grad_1[0u];
    let _e290 = grad_1[1u];
    let _e294 = tuning.waterWaveStrength;
    let _e296 = upness;
    return normalize((_e285 + ((vec3<f32>(-(_e287), 0f, -(_e290)) * _e294) * _e296)));
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
        let _e269 = x_4;
        if (_e269 <= 2i) {
            y_1 = -2i;
            loop {
                let _e271 = y_1;
                if (_e271 <= 2i) {
                    z_4 = -2i;
                    loop {
                        let _e273 = z_4;
                        if (_e273 <= 2i) {
                            let _e275 = x_4;
                            let _e277 = y_1;
                            let _e280 = z_4;
                            if (((_e275 == 0i) && (_e277 == 0i)) && (_e280 == 0i)) {
                                continue;
                            }
                            let _e283 = x_4;
                            let _e284 = x_4;
                            let _e286 = y_1;
                            let _e287 = y_1;
                            let _e290 = z_4;
                            let _e291 = z_4;
                            d2_ = (((_e283 * _e284) + (_e286 * _e287)) + (_e290 * _e291));
                            let _e294 = d2_;
                            if (_e294 > 6i) {
                                continue;
                            }
                            let _e296 = (*p_3);
                            let _e297 = x_4;
                            let _e298 = y_1;
                            let _e299 = z_4;
                            param_51 = (_e296 + vec3<i32>(_e297, _e298, _e299));
                            let _e302 = getVoxel_u0028_vi3_u003b((&param_51));
                            if ((_e302 & 255u) == 0u) {
                                continue;
                            }
                            let _e305 = x_4;
                            let _e307 = y_1;
                            let _e309 = z_4;
                            let _e312 = d2_;
                            let _e316 = n_3;
                            n_3 = (_e316 - (vec3<f32>(f32(_e305), f32(_e307), f32(_e309)) / vec3(f32(_e312))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e318 = z_4;
                            z_4 = (_e318 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e320 = y_1;
                    y_1 = (_e320 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e322 = x_4;
            x_4 = (_e322 + 1i);
        }
    }
    let _e324 = n_3;
    if (length(_e324) < 0.001f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e327 = n_3;
    return normalize(_e327);
}

fn locustDensity_u0028_u1_u003b(type_38: ptr<function, u32>) -> f32 {
    var stage_2: f32;

    let _e264 = (*type_38);
    stage_2 = (f32((_e264 - 13u)) / 4f);
    let _e269 = tuning.locustDensityMin;
    let _e271 = tuning.locustDensityMax;
    let _e272 = stage_2;
    return clamp(mix(_e269, _e271, _e272), 0.02f, 0.98f);
}

fn trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b(voxelPos_13: ptr<function, vec3<i32>>, a: ptr<function, vec2<f32>>, b_1: ptr<function, vec2<f32>>, count_3: ptr<function, i32>) {
    var h0_: f32;
    var param_52: vec3<f32>;
    var h1_: f32;
    var param_53: vec3<f32>;
    var h2_: f32;
    var param_54: vec3<f32>;

    let _e273 = (*voxelPos_13)[0u];
    let _e276 = (*voxelPos_13)[2u];
    param_52 = vec3<f32>(f32(_e273), 7f, f32(_e276));
    let _e279 = hash_u0028_vf3_u003b((&param_52));
    h0_ = _e279;
    let _e281 = (*voxelPos_13)[0u];
    let _e284 = (*voxelPos_13)[2u];
    param_53 = vec3<f32>(f32(_e281), 19f, f32(_e284));
    let _e287 = hash_u0028_vf3_u003b((&param_53));
    h1_ = _e287;
    let _e289 = (*voxelPos_13)[0u];
    let _e292 = (*voxelPos_13)[2u];
    param_54 = vec3<f32>(f32(_e289), 53f, f32(_e292));
    let _e295 = hash_u0028_vf3_u003b((&param_54));
    h2_ = _e295;
    let _e296 = h2_;
    let _e298 = tuning.treeTrunkColumns;
    (*count_3) = (1i + i32((_e296 * f32(max(bitcast<i32>(_e298), 1i)))));
    let _e305 = (*count_3);
    (*count_3) = clamp(_e305, 1i, 2i);
    let _e307 = h0_;
    let _e310 = h1_;
    (*a) = vec2<f32>((0.3f + (_e307 * 0.4f)), (0.3f + (_e310 * 0.4f)));
    let _e314 = h1_;
    let _e317 = h0_;
    (*b_1) = vec2<f32>((0.3f + (_e314 * 0.4f)), (0.3f + (_e317 * 0.4f)));
    return;
}

fn subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b(kind: ptr<function, u32>, type_39: ptr<function, u32>, voxelPos_14: ptr<function, vec3<i32>>, cell_1: ptr<function, vec3<i32>>, sub: ptr<function, i32>, jitter: ptr<function, vec3<f32>>) -> bool {
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

    let _e279 = (*kind);
    if (_e279 == 1u) {
        let _e281 = (*cell_1);
        let _e286 = (*sub);
        p_4 = ((vec2<f32>(_e281.xz) + vec2(0.5f)) / vec2(f32(_e286)));
        let _e290 = (*voxelPos_14);
        param_55 = _e290;
        trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b((&param_55), (&param_56), (&param_57), (&param_58));
        let _e291 = param_56;
        a_1 = _e291;
        let _e292 = param_57;
        b_2 = _e292;
        let _e293 = param_58;
        count_4 = _e293;
        let _e295 = tuning.treeTrunkRadius;
        r_1 = max(_e295, 0.02f);
        let _e297 = p_4;
        let _e298 = a_1;
        let _e300 = p_4;
        let _e301 = a_1;
        let _e304 = r_1;
        let _e305 = r_1;
        if (dot((_e297 - _e298), (_e300 - _e301)) <= (_e304 * _e305)) {
            return true;
        }
        let _e308 = count_4;
        let _e309 = (_e308 > 1i);
        phi_1635_ = _e309;
        if _e309 {
            let _e310 = p_4;
            let _e311 = b_2;
            let _e313 = p_4;
            let _e314 = b_2;
            let _e317 = r_1;
            let _e318 = r_1;
            phi_1635_ = (dot((_e310 - _e311), (_e313 - _e314)) <= (_e317 * _e318));
        }
        let _e322 = phi_1635_;
        if _e322 {
            return true;
        }
        return false;
    }
    let _e323 = (*voxelPos_14);
    let _e324 = (*sub);
    let _e327 = (*cell_1);
    let _e330 = (*jitter);
    param_59 = (vec3<f32>(((_e323 * vec3(_e324)) + _e327)) + _e330);
    let _e332 = hash_u0028_vf3_u003b((&param_59));
    let _e333 = (*type_39);
    param_60 = _e333;
    let _e334 = locustDensity_u0028_u1_u003b((&param_60));
    return (_e332 < _e334);
}

fn intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b(ro: ptr<function, vec3<f32>>, rd: ptr<function, vec3<f32>>, boxMin: ptr<function, vec3<f32>>, boxMax: ptr<function, vec3<f32>>) -> vec2<f32> {
    var tMin: vec3<f32>;
    var tMax_2: vec3<f32>;
    var t1_: vec3<f32>;
    var t2_: vec3<f32>;
    var tNear: f32;
    var tFar: f32;

    let _e272 = (*boxMin);
    let _e273 = (*ro);
    let _e275 = (*rd);
    tMin = ((_e272 - _e273) / _e275);
    let _e277 = (*boxMax);
    let _e278 = (*ro);
    let _e280 = (*rd);
    tMax_2 = ((_e277 - _e278) / _e280);
    let _e282 = tMin;
    let _e283 = tMax_2;
    t1_ = min(_e282, _e283);
    let _e285 = tMin;
    let _e286 = tMax_2;
    t2_ = max(_e285, _e286);
    let _e289 = t1_[0u];
    let _e291 = t1_[1u];
    let _e294 = t1_[2u];
    tNear = max(max(_e289, _e291), _e294);
    let _e297 = t2_[0u];
    let _e299 = t2_[1u];
    let _e302 = t2_[2u];
    tFar = min(min(_e297, _e299), _e302);
    let _e304 = tNear;
    let _e305 = tFar;
    return vec2<f32>(_e304, _e305);
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
    let _e301 = (*entryNormal);
    (*subNormal) = _e301;
    (*subCell_2) = vec3<f32>(0f, 0f, 0f);
    let _e303 = tuning.locustSubdivision;
    sub_1 = clamp(bitcast<i32>(_e303), 1i, 8i);
    let _e306 = sub_1;
    cellSize = (1f / f32(_e306));
    let _e309 = (*voxelPos_15);
    boxMin_1 = vec3<f32>(_e309);
    let _e311 = boxMin_1;
    let _e313 = (*rayOrigin_2);
    param_61 = _e313;
    let _e314 = (*rayDir_2);
    param_62 = _e314;
    let _e315 = boxMin_1;
    param_63 = _e315;
    param_64 = (_e311 + vec3<f32>(1f, 1f, 1f));
    let _e316 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_61), (&param_62), (&param_63), (&param_64));
    span = _e316;
    let _e318 = span[0u];
    t_2 = max(_e318, 0f);
    let _e320 = t_2;
    let _e322 = span[1u];
    if (_e320 > _e322) {
        return false;
    }
    let _e324 = (*rayOrigin_2);
    let _e325 = (*rayDir_2);
    let _e326 = t_2;
    let _e330 = boxMin_1;
    let _e332 = sub_1;
    local_9 = (((_e324 + (_e325 * (_e326 + 0.0001f))) - _e330) * f32(_e332));
    let _e335 = local_9;
    let _e338 = sub_1;
    c = clamp(vec3<i32>(floor(_e335)), vec3<i32>(0i, 0i, 0i), vec3((_e338 - 1i)));
    let _e342 = (*rayDir_2);
    stepDir_2 = vec3<i32>(sign(_e342));
    let _e346 = (*rayDir_2)[0u];
    if (_e346 == 0f) {
        local_10 = 1000000f;
    } else {
        let _e348 = cellSize;
        let _e350 = (*rayDir_2)[0u];
        local_10 = abs((_e348 / _e350));
    }
    let _e353 = local_10;
    let _e355 = (*rayDir_2)[1u];
    if (_e355 == 0f) {
        local_11 = 1000000f;
    } else {
        let _e357 = cellSize;
        let _e359 = (*rayDir_2)[1u];
        local_11 = abs((_e357 / _e359));
    }
    let _e362 = local_11;
    let _e364 = (*rayDir_2)[2u];
    if (_e364 == 0f) {
        local_12 = 1000000f;
    } else {
        let _e366 = cellSize;
        let _e368 = (*rayDir_2)[2u];
        local_12 = abs((_e366 / _e368));
    }
    let _e371 = local_12;
    tDelta_2 = vec3<f32>(_e353, _e362, _e371);
    let _e373 = local_9;
    let _e374 = c;
    fracPos_1 = (_e373 - vec3<f32>(_e374));
    let _e377 = t_2;
    let _e379 = stepDir_2[0u];
    if (_e379 > 0i) {
        let _e382 = fracPos_1[0u];
        let _e385 = tDelta_2[0u];
        local_13 = ((1f - _e382) * _e385);
    } else {
        let _e388 = fracPos_1[0u];
        let _e390 = tDelta_2[0u];
        local_13 = (_e388 * _e390);
    }
    let _e392 = local_13;
    let _e394 = stepDir_2[1u];
    if (_e394 > 0i) {
        let _e397 = fracPos_1[1u];
        let _e400 = tDelta_2[1u];
        local_14 = ((1f - _e397) * _e400);
    } else {
        let _e403 = fracPos_1[1u];
        let _e405 = tDelta_2[1u];
        local_14 = (_e403 * _e405);
    }
    let _e407 = local_14;
    let _e409 = stepDir_2[2u];
    if (_e409 > 0i) {
        let _e412 = fracPos_1[2u];
        let _e415 = tDelta_2[2u];
        local_15 = ((1f - _e412) * _e415);
    } else {
        let _e418 = fracPos_1[2u];
        let _e420 = tDelta_2[2u];
        local_15 = (_e418 * _e420);
    }
    let _e422 = local_15;
    tMax_3 = (vec3(_e377) + vec3<f32>(_e392, _e407, _e422));
    let _e426 = (*kind_1);
    if (_e426 == 0u) {
        let _e429 = pc.time;
        let _e431 = tuning.locustCrawlRate;
        local_16 = vec3((floor((_e429 * _e431)) * 1.7f));
    } else {
        local_16 = vec3<f32>(0f, 0f, 0f);
    }
    let _e436 = local_16;
    jitter_1 = _e436;
    i_5 = 0i;
    loop {
        let _e437 = i_5;
        let _e438 = sub_1;
        if (_e437 < (3i * _e438)) {
            let _e442 = c[0u];
            let _e443 = (_e442 < 0i);
            phi_1867_ = _e443;
            if !(_e443) {
                let _e446 = c[0u];
                let _e447 = sub_1;
                phi_1867_ = (_e446 >= _e447);
            }
            let _e450 = phi_1867_;
            phi_1874_ = _e450;
            if !(_e450) {
                let _e453 = c[1u];
                phi_1874_ = (_e453 < 0i);
            }
            let _e456 = phi_1874_;
            phi_1882_ = _e456;
            if !(_e456) {
                let _e459 = c[1u];
                let _e460 = sub_1;
                phi_1882_ = (_e459 >= _e460);
            }
            let _e463 = phi_1882_;
            phi_1889_ = _e463;
            if !(_e463) {
                let _e466 = c[2u];
                phi_1889_ = (_e466 < 0i);
            }
            let _e469 = phi_1889_;
            phi_1897_ = _e469;
            if !(_e469) {
                let _e472 = c[2u];
                let _e473 = sub_1;
                phi_1897_ = (_e472 >= _e473);
            }
            let _e476 = phi_1897_;
            if _e476 {
                return false;
            }
            let _e477 = (*kind_1);
            param_65 = _e477;
            let _e478 = (*type_40);
            param_66 = _e478;
            let _e479 = (*voxelPos_15);
            param_67 = _e479;
            let _e480 = c;
            param_68 = _e480;
            let _e481 = sub_1;
            param_69 = _e481;
            let _e482 = jitter_1;
            param_70 = _e482;
            let _e483 = subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b((&param_65), (&param_66), (&param_67), (&param_68), (&param_69), (&param_70));
            if _e483 {
                let _e484 = t_2;
                (*tHit_1) = _e484;
                let _e485 = c;
                (*subCell_2) = vec3<f32>(_e485);
                return true;
            }
            let _e488 = tMax_3[0u];
            let _e490 = tMax_3[1u];
            if (_e488 < _e490) {
                let _e493 = tMax_3[0u];
                let _e495 = tMax_3[2u];
                if (_e493 < _e495) {
                    let _e498 = stepDir_2[0u];
                    let _e500 = c[0u];
                    c[0u] = (_e500 + _e498);
                    let _e504 = tMax_3[0u];
                    t_2 = _e504;
                    let _e506 = tDelta_2[0u];
                    let _e508 = tMax_3[0u];
                    tMax_3[0u] = (_e508 + _e506);
                    let _e512 = stepDir_2[0u];
                    (*subNormal) = vec3<f32>(f32(-(_e512)), 0f, 0f);
                } else {
                    let _e517 = stepDir_2[2u];
                    let _e519 = c[2u];
                    c[2u] = (_e519 + _e517);
                    let _e523 = tMax_3[2u];
                    t_2 = _e523;
                    let _e525 = tDelta_2[2u];
                    let _e527 = tMax_3[2u];
                    tMax_3[2u] = (_e527 + _e525);
                    let _e531 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e531)));
                }
            } else {
                let _e536 = tMax_3[1u];
                let _e538 = tMax_3[2u];
                if (_e536 < _e538) {
                    let _e541 = stepDir_2[1u];
                    let _e543 = c[1u];
                    c[1u] = (_e543 + _e541);
                    let _e547 = tMax_3[1u];
                    t_2 = _e547;
                    let _e549 = tDelta_2[1u];
                    let _e551 = tMax_3[1u];
                    tMax_3[1u] = (_e551 + _e549);
                    let _e555 = stepDir_2[1u];
                    (*subNormal) = vec3<f32>(0f, f32(-(_e555)), 0f);
                } else {
                    let _e560 = stepDir_2[2u];
                    let _e562 = c[2u];
                    c[2u] = (_e562 + _e560);
                    let _e566 = tMax_3[2u];
                    t_2 = _e566;
                    let _e568 = tDelta_2[2u];
                    let _e570 = tMax_3[2u];
                    tMax_3[2u] = (_e570 + _e568);
                    let _e574 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e574)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e578 = i_5;
            i_5 = (_e578 + 1i);
        }
    }
    return false;
}

fn isLocustType_u0028_u1_u003b(type_41: ptr<function, u32>) -> bool {
    let _e263 = (*type_41);
    let _e265 = (*type_41);
    return ((_e263 >= 13u) && (_e265 <= 17u));
}

fn marchCeiling_u0028_() -> i32 {
    let _e263 = tuning.gridHeight;
    let _e266 = unnamed.maxOccupiedY;
    return min(bitcast<i32>(_e263), (bitcast<i32>(_e266) + 2i));
}

fn worldExtent_u0028_() -> vec3<f32> {
    let _e263 = tuning.gridWidth;
    let _e267 = tuning.gridHeight;
    let _e271 = tuning.gridDepth;
    return vec3<f32>(f32(bitcast<i32>(_e263)), f32(bitcast<i32>(_e267)), f32(bitcast<i32>(_e271)));
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
    let _e266 = worldExtent_u0028_();
    extent = _e266;
    let _e268 = (*p_5)[0u];
    let _e269 = thickness_1;
    let _e270 = (_e268 < _e269);
    phi_476_ = _e270;
    if !(_e270) {
        let _e273 = (*p_5)[0u];
        let _e275 = extent[0u];
        let _e276 = thickness_1;
        phi_476_ = (_e273 > (_e275 - _e276));
    }
    let _e280 = phi_476_;
    if _e280 {
        let _e281 = boundCount;
        boundCount = (_e281 + 1i);
    }
    let _e284 = (*p_5)[1u];
    let _e285 = thickness_1;
    let _e286 = (_e284 < _e285);
    phi_495_ = _e286;
    if !(_e286) {
        let _e289 = (*p_5)[1u];
        let _e291 = extent[1u];
        let _e292 = thickness_1;
        phi_495_ = (_e289 > (_e291 - _e292));
    }
    let _e296 = phi_495_;
    if _e296 {
        let _e297 = boundCount;
        boundCount = (_e297 + 1i);
    }
    let _e300 = (*p_5)[2u];
    let _e301 = thickness_1;
    let _e302 = (_e300 < _e301);
    phi_514_ = _e302;
    if !(_e302) {
        let _e305 = (*p_5)[2u];
        let _e307 = extent[2u];
        let _e308 = thickness_1;
        phi_514_ = (_e305 > (_e307 - _e308));
    }
    let _e312 = phi_514_;
    if _e312 {
        let _e313 = boundCount;
        boundCount = (_e313 + 1i);
    }
    let _e315 = boundCount;
    return (_e315 >= 2i);
}

fn rot_u0028_f1_u003b(a_2: ptr<function, f32>) -> mat2x2<f32> {
    var s: f32;
    var c_1: f32;

    let _e265 = (*a_2);
    s = sin(_e265);
    let _e267 = (*a_2);
    c_1 = cos(_e267);
    let _e269 = c_1;
    let _e270 = s;
    let _e272 = s;
    let _e273 = c_1;
    return mat2x2<f32>(vec2<f32>(_e269, -(_e270)), vec2<f32>(_e272, _e273));
}

fn applyCameraRotation_u0028_vf3_u003b(v: ptr<function, vec3<f32>>) -> vec3<f32> {
    var param_71: f32;
    var param_72: f32;

    let _e266 = pc.pitch;
    param_71 = _e266;
    let _e267 = rot_u0028_f1_u003b((&param_71));
    let _e268 = (*v);
    let _e270 = (_e268.yz * _e267);
    (*v)[1u] = _e270.x;
    (*v)[2u] = _e270.y;
    let _e276 = pc.yaw;
    param_72 = _e276;
    let _e277 = rot_u0028_f1_u003b((&param_72));
    let _e278 = (*v);
    let _e280 = (_e278.xz * _e277);
    (*v)[0u] = _e280.x;
    (*v)[2u] = _e280.y;
    let _e285 = (*v);
    return _e285;
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
    var slabMax: f32;
    var bandHi: f32;
    var bandLo: f32;
    var cloudClip: vec2<f32>;
    var local_26: vec2<f32>;
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
    var phi_3089_: bool;
    var phi_3105_: bool;
    var phi_3333_: bool;
    var phi_3340_: bool;
    var phi_3348_: bool;
    var phi_3355_: bool;
    var phi_3365_: bool;
    var phi_3853_: bool;
    var phi_4172_: bool;
    var phi_4179_: bool;
    var phi_4188_: bool;
    var phi_4194_: bool;
    var phi_4203_: bool;
    var phi_4414_: bool;
    var phi_4456_: bool;
    var phi_4478_: bool;
    var phi_4500_: bool;
    var phi_4528_: bool;
    var phi_4550_: bool;
    var phi_4572_: bool;

    let _e476 = inUV_1;
    screenSpace = ((_e476 * 2f) - vec2(1f));
    let _e481 = screenSpace[1u];
    screenSpace[1u] = -(_e481);
    let _e485 = pc.aspectScaleX;
    let _e487 = screenSpace[0u];
    screenSpace[0u] = (_e487 * _e485);
    let _e491 = pc.aspectScaleY;
    let _e493 = screenSpace[1u];
    screenSpace[1u] = (_e493 * _e491);
    let _e497 = pc.camX;
    let _e499 = pc.camY;
    let _e501 = pc.camZ;
    baseOrigin = vec3<f32>(_e497, _e499, _e501);
    param_73 = vec3<f32>(0f, 0f, 1f);
    let _e503 = applyCameraRotation_u0028_vf3_u003b((&param_73));
    forward = _e503;
    param_74 = vec3<f32>(1f, 0f, 0f);
    let _e504 = applyCameraRotation_u0028_vf3_u003b((&param_74));
    right = _e504;
    param_75 = vec3<f32>(0f, 1f, 0f);
    let _e505 = applyCameraRotation_u0028_vf3_u003b((&param_75));
    up = _e505;
    let _e507 = pc.perspectiveBlend;
    t_3 = clamp(_e507, 0f, 1f);
    let _e509 = worldExtent_u0028_();
    cubeCenter = (_e509 * 0.5f);
    let _e511 = cubeCenter;
    let _e512 = baseOrigin;
    let _e514 = forward;
    viewDistance = max(1f, dot((_e511 - _e512), _e514));
    let _e517 = viewDistance;
    let _e519 = pc.fovDistance;
    orthoHalfSize = (_e517 / _e519);
    let _e522 = screenSpace[0u];
    let _e524 = screenSpace[1u];
    let _e526 = pc.fovDistance;
    let _e528 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e522, _e524, _e526), vec3(_e528));
    let _e531 = right;
    let _e533 = localDir[0u];
    let _e535 = up;
    let _e537 = localDir[1u];
    let _e540 = forward;
    let _e542 = localDir[2u];
    rayDir_3 = normalize((((_e531 * _e533) + (_e535 * _e537)) + (_e540 * _e542)));
    let _e546 = right;
    let _e548 = screenSpace[0u];
    let _e550 = up;
    let _e552 = screenSpace[1u];
    let _e555 = orthoHalfSize;
    let _e557 = t_3;
    originOffset = ((((_e546 * _e548) + (_e550 * _e552)) * _e555) * (1f - _e557));
    let _e560 = baseOrigin;
    let _e561 = originOffset;
    rayOrigin_3 = (_e560 + _e561);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e563 = worldExtent_u0028_();
    let _e564 = rayOrigin_3;
    param_76 = _e564;
    let _e565 = rayDir_3;
    param_77 = _e565;
    param_78 = vec3<f32>(0f, 0f, 0f);
    param_79 = _e563;
    let _e566 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_76), (&param_77), (&param_78), (&param_79));
    aabbHit = _e566;
    hitFrontBox = false;
    hitBackBox = false;
    let _e568 = aabbHit[0u];
    let _e570 = aabbHit[1u];
    let _e571 = (_e568 < _e570);
    phi_3089_ = _e571;
    if _e571 {
        let _e573 = aabbHit[1u];
        phi_3089_ = (_e573 > 0f);
    }
    let _e576 = phi_3089_;
    if _e576 {
        let _e578 = aabbHit[0u];
        let _e579 = (_e578 > 0f);
        phi_3105_ = _e579;
        if _e579 {
            let _e580 = rayOrigin_3;
            let _e581 = rayDir_3;
            let _e583 = aabbHit[0u];
            param_80 = (_e580 + (_e581 * _e583));
            let _e586 = isEdge_u0028_vf3_u003b((&param_80));
            phi_3105_ = _e586;
        }
        let _e588 = phi_3105_;
        if _e588 {
            hitFrontBox = true;
        }
        let _e589 = rayOrigin_3;
        let _e590 = rayDir_3;
        let _e592 = aabbHit[1u];
        param_81 = (_e589 + (_e590 * _e592));
        let _e595 = isEdge_u0028_vf3_u003b((&param_81));
        if _e595 {
            hitBackBox = true;
        }
    }
    let _e597 = pc.showCloudBlocks;
    if (_e597 != 0i) {
        let _e600 = tuning.gridHeight;
        local_17 = bitcast<i32>(_e600);
    } else {
        let _e602 = marchCeiling_u0028_();
        local_17 = _e602;
    }
    let _e603 = local_17;
    ceilingY_1 = _e603;
    let _e605 = tuning.gridWidth;
    let _e608 = ceilingY_1;
    let _e611 = tuning.gridDepth;
    let _e615 = rayOrigin_3;
    param_82 = _e615;
    let _e616 = rayDir_3;
    param_83 = _e616;
    param_84 = vec3<f32>(0f, 0f, 0f);
    param_85 = vec3<f32>(f32(bitcast<i32>(_e605)), f32(_e608), f32(bitcast<i32>(_e611)));
    let _e617 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_82), (&param_83), (&param_84), (&param_85));
    marchHit = _e617;
    let _e618 = rayOrigin_3;
    let _e619 = rayDir_3;
    let _e621 = marchHit[0u];
    currentPos = (_e618 + (_e619 * max(0f, _e621)));
    let _e626 = marchHit[0u];
    if (_e626 > 0f) {
        let _e628 = rayDir_3;
        let _e630 = currentPos;
        currentPos = (_e630 + (_e628 * 0.001f));
    }
    let _e632 = currentPos;
    voxelPos_16 = vec3<i32>(floor(_e632));
    let _e635 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e635));
    let _e639 = rayDir_3[0u];
    if (_e639 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e642 = rayDir_3[0u];
        local_18 = abs((1f / _e642));
    }
    let _e645 = local_18;
    let _e647 = rayDir_3[1u];
    if (_e647 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e650 = rayDir_3[1u];
        local_19 = abs((1f / _e650));
    }
    let _e653 = local_19;
    let _e655 = rayDir_3[2u];
    if (_e655 == 0f) {
        local_20 = 100000000f;
    } else {
        let _e658 = rayDir_3[2u];
        local_20 = abs((1f / _e658));
    }
    let _e661 = local_20;
    tDelta_3 = vec3<f32>(_e645, _e653, _e661);
    let _e664 = stepDir_3[0u];
    if (_e664 > 0i) {
        let _e667 = currentPos[0u];
        let _e671 = currentPos[0u];
        let _e674 = tDelta_3[0u];
        local_21 = (((floor(_e667) + 1f) - _e671) * _e674);
    } else {
        let _e677 = currentPos[0u];
        let _e679 = currentPos[0u];
        let _e683 = tDelta_3[0u];
        local_21 = ((_e677 - floor(_e679)) * _e683);
    }
    let _e685 = local_21;
    let _e687 = stepDir_3[1u];
    if (_e687 > 0i) {
        let _e690 = currentPos[1u];
        let _e694 = currentPos[1u];
        let _e697 = tDelta_3[1u];
        local_22 = (((floor(_e690) + 1f) - _e694) * _e697);
    } else {
        let _e700 = currentPos[1u];
        let _e702 = currentPos[1u];
        let _e706 = tDelta_3[1u];
        local_22 = ((_e700 - floor(_e702)) * _e706);
    }
    let _e708 = local_22;
    let _e710 = stepDir_3[2u];
    if (_e710 > 0i) {
        let _e713 = currentPos[2u];
        let _e717 = currentPos[2u];
        let _e720 = tDelta_3[2u];
        local_23 = (((floor(_e713) + 1f) - _e717) * _e720);
    } else {
        let _e723 = currentPos[2u];
        let _e725 = currentPos[2u];
        let _e729 = tDelta_3[2u];
        local_23 = ((_e723 - floor(_e725)) * _e729);
    }
    let _e731 = local_23;
    tMax_4 = vec3<f32>(_e685, _e708, _e731);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e734 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e734 * 1.5f));
    i_6 = 0i;
    loop {
        let _e737 = i_6;
        let _e739 = tuning.marchMaxSteps;
        if (_e737 < bitcast<i32>(_e739)) {
            let _e743 = voxelPos_16[0u];
            let _e744 = (_e743 < 0i);
            phi_3333_ = _e744;
            if !(_e744) {
                let _e747 = voxelPos_16[0u];
                let _e749 = tuning.gridWidth;
                phi_3333_ = (_e747 >= bitcast<i32>(_e749));
            }
            let _e753 = phi_3333_;
            phi_3340_ = _e753;
            if !(_e753) {
                let _e756 = voxelPos_16[1u];
                phi_3340_ = (_e756 < 0i);
            }
            let _e759 = phi_3340_;
            phi_3348_ = _e759;
            if !(_e759) {
                let _e762 = voxelPos_16[1u];
                let _e763 = ceilingY_1;
                phi_3348_ = (_e762 >= _e763);
            }
            let _e766 = phi_3348_;
            phi_3355_ = _e766;
            if !(_e766) {
                let _e769 = voxelPos_16[2u];
                phi_3355_ = (_e769 < 0i);
            }
            let _e772 = phi_3355_;
            phi_3365_ = _e772;
            if !(_e772) {
                let _e775 = voxelPos_16[2u];
                let _e777 = tuning.gridDepth;
                phi_3365_ = (_e775 >= bitcast<i32>(_e777));
            }
            let _e781 = phi_3365_;
            if _e781 {
                break;
            }
            let _e782 = voxelPos_16;
            param_86 = _e782;
            let _e783 = getVoxel_u0028_vi3_u003b((&param_86));
            rawVoxel_5 = _e783;
            let _e784 = rawVoxel_5;
            hitType = (_e784 & 255u);
            let _e787 = pc.showCloudBlocks;
            let _e789 = hitType;
            if ((_e787 != 0i) && (_e789 == 0u)) {
                let _e793 = voxelPos_16[0u];
                let _e795 = voxelPos_16[1u];
                let _e797 = tuning.gridWidth;
                let _e802 = voxelPos_16[2u];
                let _e804 = tuning.gridWidth;
                let _e808 = tuning.gridHeight;
                let _e815 = unnamed_2.cloudCells[bitcast<u32>(((_e793 + (_e795 * bitcast<i32>(_e797))) + ((_e802 * bitcast<i32>(_e804)) * bitcast<i32>(_e808))))];
                c_2 = _e815;
                let _e816 = c_2;
                if ((_e816 & 3u) != 0u) {
                    hitType = 200u;
                    let _e819 = c_2;
                    hitRawVoxel = _e819;
                    hit = true;
                    break;
                }
            }
            let _e820 = hitType;
            if (_e820 == 7u) {
                hitType = 0u;
            }
            let _e822 = hitType;
            if (_e822 != 0u) {
                let _e824 = hitType;
                if (_e824 == 6u) {
                    let _e826 = rawVoxel_5;
                    age_1 = ((_e826 >> bitcast<u32>(24i)) & 255u);
                    let _e830 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e830) / 100f), 0f, 1f));
                    let _e835 = inUV_1;
                    let _e837 = pc.time;
                    dither = fract((sin(dot((_e835 + vec2((_e837 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e845 = dither;
                    let _e846 = targetAlpha;
                    if (_e845 > _e846) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e848 = rawVoxel_5;
                        hitRawVoxel = _e848;
                        break;
                    }
                } else {
                    let _e849 = hitType;
                    param_87 = _e849;
                    let _e850 = isLocustType_u0028_u1_u003b((&param_87));
                    let _e851 = hitType;
                    if (_e850 || (_e851 == 18u)) {
                        let _e854 = hitType;
                        kind_2 = select(0u, 1u, (_e854 == 18u));
                        let _e857 = voxelPos_16;
                        param_88 = _e857;
                        let _e858 = rayOrigin_3;
                        param_89 = _e858;
                        let _e859 = rayDir_3;
                        param_90 = _e859;
                        let _e860 = kind_2;
                        param_91 = _e860;
                        let _e861 = hitType;
                        param_92 = _e861;
                        let _e862 = normal_4;
                        param_93 = _e862;
                        let _e863 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_88), (&param_89), (&param_90), (&param_91), (&param_92), (&param_93), (&param_94), (&param_95), (&param_96));
                        let _e864 = param_94;
                        subT = _e864;
                        let _e865 = param_95;
                        subNormal_1 = _e865;
                        let _e866 = param_96;
                        subCell_3 = _e866;
                        if _e863 {
                            hit = true;
                            let _e867 = rawVoxel_5;
                            hitRawVoxel = _e867;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e868 = rawVoxel_5;
                        hitRawVoxel = _e868;
                        break;
                    }
                }
            }
            let _e870 = tMax_4[0u];
            let _e872 = tMax_4[1u];
            if (_e870 < _e872) {
                let _e875 = tMax_4[0u];
                let _e877 = tMax_4[2u];
                if (_e875 < _e877) {
                    let _e880 = stepDir_3[0u];
                    let _e882 = voxelPos_16[0u];
                    voxelPos_16[0u] = (_e882 + _e880);
                    let _e886 = tDelta_3[0u];
                    let _e888 = tMax_4[0u];
                    tMax_4[0u] = (_e888 + _e886);
                    let _e892 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e892)), 0f, 0f);
                } else {
                    let _e897 = stepDir_3[2u];
                    let _e899 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e899 + _e897);
                    let _e903 = tDelta_3[2u];
                    let _e905 = tMax_4[2u];
                    tMax_4[2u] = (_e905 + _e903);
                    let _e909 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e909)));
                }
            } else {
                let _e914 = tMax_4[1u];
                let _e916 = tMax_4[2u];
                if (_e914 < _e916) {
                    let _e919 = stepDir_3[1u];
                    let _e921 = voxelPos_16[1u];
                    voxelPos_16[1u] = (_e921 + _e919);
                    let _e925 = tDelta_3[1u];
                    let _e927 = tMax_4[1u];
                    tMax_4[1u] = (_e927 + _e925);
                    let _e931 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e931)), 0f);
                } else {
                    let _e936 = stepDir_3[2u];
                    let _e938 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e938 + _e936);
                    let _e942 = tDelta_3[2u];
                    let _e944 = tMax_4[2u];
                    tMax_4[2u] = (_e944 + _e942);
                    let _e948 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e948)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e952 = i_6;
            i_6 = (_e952 + 1i);
        }
    }
    let _e954 = hit;
    if _e954 {
        let _e955 = normal_4;
        if (length(_e955) < 0.1f) {
            let _e958 = rayDir_3;
            normal_4 = -(_e958);
        }
        let _e960 = normal_4;
        ddaNormal_1 = _e960;
        let _e961 = hitType;
        if (_e961 == 2u) {
            let _e963 = voxelPos_16;
            param_97 = _e963;
            let _e964 = getWaterNormal_u0028_vi3_u003b((&param_97));
            param_98 = _e964;
            let _e965 = voxelPos_16;
            param_99 = _e965;
            let _e966 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_98), (&param_99));
            normal_4 = _e966;
        } else {
            let _e967 = hitType;
            param_100 = _e967;
            let _e968 = isLocustType_u0028_u1_u003b((&param_100));
            let _e969 = hitType;
            if (_e968 || (_e969 == 18u)) {
                let _e972 = subNormal_1;
                normal_4 = _e972;
            } else {
                let _e973 = voxelPos_16;
                param_101 = _e973;
                let _e974 = getSmoothNormal_u0028_vi3_u003b((&param_101));
                normal_4 = _e974;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e975 = normal_4;
        let _e976 = sunDir_2;
        diffuse_1 = max(dot(_e975, _e976), 0f);
        let _e979 = voxelPos_16;
        param_102 = _e979;
        let _e980 = ddaNormal_1;
        param_103 = _e980;
        let _e981 = sunDir_2;
        param_104 = _e981;
        let _e982 = ceilingY_1;
        param_105 = _e982;
        let _e983 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_102), (&param_103), (&param_104), (&param_105));
        shadow_1 = _e983;
        let _e984 = ambientColor;
        let _e985 = sunColor_1;
        let _e986 = diffuse_1;
        let _e988 = shadow_1;
        baseLighting_9 = (_e984 + ((_e985 * _e986) * _e988));
        let _e991 = baseLighting_9;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e991);
        let _e993 = hitType;
        if (_e993 == 200u) {
            calm = vec3<f32>(0.35f, 0.65f, 1f);
            rain = vec3<f32>(1f, 0.55f, 0.25f);
            let _e995 = calm;
            let _e996 = rain;
            let _e997 = hitRawVoxel;
            let _e1003 = baseLighting_9;
            finalVoxelColor = (mix(_e995, _e996, vec3(select(0f, 1f, ((_e997 & 3u) == 2u)))) * _e1003);
        }
        let _e1005 = hitType;
        switch bitcast<i32>(_e1005) {
            case 1: {
                let _e1007 = hitRawVoxel;
                param_106 = _e1007;
                let _e1008 = baseLighting_9;
                param_107 = _e1008;
                let _e1009 = renderSand_u0028_u1_u003b_vf3_u003b((&param_106), (&param_107));
                finalVoxelColor = _e1009;
                break;
            }
            case 2: {
                let _e1010 = voxelPos_16;
                param_108 = _e1010;
                let _e1011 = normal_4;
                param_109 = _e1011;
                let _e1012 = rayOrigin_3;
                param_110 = _e1012;
                let _e1013 = sunDir_2;
                param_111 = _e1013;
                let _e1014 = sunColor_1;
                param_112 = _e1014;
                let _e1015 = shadow_1;
                param_113 = _e1015;
                let _e1016 = baseLighting_9;
                param_114 = _e1016;
                let _e1017 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_108), (&param_109), (&param_110), (&param_111), (&param_112), (&param_113), (&param_114));
                finalVoxelColor = _e1017;
                break;
            }
            case 3: {
                let _e1018 = voxelPos_16;
                param_115 = _e1018;
                let _e1019 = baseLighting_9;
                param_116 = _e1019;
                let _e1020 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_115), (&param_116));
                finalVoxelColor = _e1020;
                break;
            }
            case 4: {
                let _e1021 = hitRawVoxel;
                param_117 = _e1021;
                let _e1022 = voxelPos_16;
                param_118 = _e1022;
                let _e1023 = ddaNormal_1;
                param_119 = _e1023;
                let _e1024 = baseLighting_9;
                param_120 = _e1024;
                let _e1025 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_117), (&param_118), (&param_119), (&param_120));
                finalVoxelColor = _e1025;
                break;
            }
            case 5: {
                let _e1026 = hitRawVoxel;
                param_121 = _e1026;
                let _e1027 = voxelPos_16;
                param_122 = _e1027;
                let _e1028 = renderFire_u0028_u1_u003b_vi3_u003b((&param_121), (&param_122));
                finalVoxelColor = _e1028;
                break;
            }
            case 6: {
                let _e1029 = voxelPos_16;
                param_123 = _e1029;
                let _e1030 = baseLighting_9;
                param_124 = _e1030;
                let _e1031 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_123), (&param_124));
                finalVoxelColor = _e1031;
                break;
            }
            case 9, 10, 11, 8: {
                let _e1032 = hitRawVoxel;
                param_125 = _e1032;
                let _e1033 = voxelPos_16;
                param_126 = _e1033;
                let _e1034 = renderLava_u0028_u1_u003b_vi3_u003b((&param_125), (&param_126));
                finalVoxelColor = _e1034;
                break;
            }
            case 12: {
                let _e1035 = voxelPos_16;
                param_127 = _e1035;
                let _e1036 = baseLighting_9;
                param_128 = _e1036;
                let _e1037 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_127), (&param_128));
                finalVoxelColor = _e1037;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e1038 = voxelPos_16;
                param_129 = _e1038;
                let _e1039 = subCell_3;
                param_130 = _e1039;
                let _e1040 = baseLighting_9;
                param_131 = _e1040;
                let _e1041 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_129), (&param_130), (&param_131));
                finalVoxelColor = _e1041;
                break;
            }
            case 18: {
                let _e1042 = voxelPos_16;
                param_132 = _e1042;
                let _e1043 = subCell_3;
                param_133 = _e1043;
                let _e1044 = baseLighting_9;
                param_134 = _e1044;
                let _e1045 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_132), (&param_133), (&param_134));
                finalVoxelColor = _e1045;
                break;
            }
            case 19: {
                let _e1046 = hitRawVoxel;
                param_135 = _e1046;
                let _e1047 = voxelPos_16;
                param_136 = _e1047;
                let _e1048 = baseLighting_9;
                param_137 = _e1048;
                let _e1049 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_135), (&param_136), (&param_137));
                finalVoxelColor = _e1049;
                break;
            }
            default: {
                break;
            }
        }
        let _e1050 = finalVoxelColor;
        param_138 = _e1050;
        let _e1051 = voxelPos_16;
        param_139 = _e1051;
        let _e1052 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_138), (&param_139));
        finalVoxelColor = _e1052;
        let _e1053 = hitType;
        param_140 = _e1053;
        let _e1054 = isLocustType_u0028_u1_u003b((&param_140));
        let _e1055 = hitType;
        if (_e1054 || (_e1055 == 18u)) {
            let _e1058 = subT;
            local_24 = _e1058;
        } else {
            let _e1059 = voxelPos_16;
            let _e1062 = rayOrigin_3;
            local_24 = length(((vec3<f32>(_e1059) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e1062));
        }
        let _e1065 = local_24;
        distanceTraveled = _e1065;
        let _e1066 = distanceTraveled;
        let _e1067 = MAX_VISIBILITY;
        let _e1071 = finalVoxelColor;
        finalVoxelColor = (_e1071 * mix(1f, 0f, clamp((_e1066 / _e1067), 0f, 1f)));
        let _e1073 = distanceTraveled;
        finalDist = _e1073;
        let _e1074 = finalVoxelColor;
        finalColor = vec4<f32>(_e1074.x, _e1074.y, _e1074.z, 1f);
    } else {
        let _e1079 = hitBackBox;
        if _e1079 {
            let _e1081 = aabbHit[1u];
            finalDist = _e1081;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1083 = unnamed.blackHoleCount;
    if (_e1083 > 0u) {
        seenHoles = 0u;
        i_7 = 0i;
        loop {
            let _e1085 = i_7;
            let _e1086 = (_e1085 < 8i);
            phi_3853_ = _e1086;
            if _e1086 {
                let _e1087 = seenHoles;
                let _e1089 = unnamed.blackHoleCount;
                phi_3853_ = (_e1087 < _e1089);
            }
            let _e1092 = phi_3853_;
            if _e1092 {
                let _e1093 = i_7;
                let _e1096 = unnamed.blackHoles[_e1093];
                code_2 = _e1096;
                let _e1097 = code_2;
                if (_e1097 == 0u) {
                    continue;
                }
                let _e1099 = seenHoles;
                seenHoles = (_e1099 + bitcast<u32>(1i));
                let _e1102 = code_2;
                if ((_e1102 & 1073741824u) != 0u) {
                    let _e1106 = tuning.purgeLevel;
                    let _e1108 = i_7;
                    let _e1111 = unnamed.blackHoleMass[_e1108];
                    let _e1114 = tuning.purgeMass;
                    local_25 = u32((f32(_e1106) * clamp((f32(_e1111) / f32(max(_e1114, 1u))), 0f, 1f)));
                } else {
                    let _e1121 = i_7;
                    let _e1124 = unnamed.blackHoleMass[_e1121];
                    param_141 = _e1124;
                    let _e1125 = bhLevel_u0028_u1_u003b((&param_141));
                    local_25 = _e1125;
                }
                let _e1126 = local_25;
                bodyLevel = _e1126;
                let _e1127 = bodyLevel;
                param_142 = _e1127;
                let _e1128 = bhBodyRadius_u0028_u1_u003b((&param_142));
                bodyRadius = _e1128;
                let _e1129 = code_2;
                param_143 = _e1129;
                let _e1130 = bhDecode_u0028_u1_u003b((&param_143));
                center = (vec3<f32>(_e1130) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1133 = rayOrigin_3;
                let _e1134 = center;
                oc = (_e1133 - _e1134);
                let _e1136 = oc;
                let _e1137 = rayDir_3;
                b_3 = dot(_e1136, _e1137);
                let _e1139 = oc;
                let _e1140 = oc;
                let _e1142 = bodyRadius;
                let _e1143 = bodyRadius;
                c_3 = (dot(_e1139, _e1140) - (_e1142 * _e1143));
                let _e1146 = b_3;
                let _e1147 = b_3;
                let _e1149 = c_3;
                disc = ((_e1146 * _e1147) - _e1149);
                let _e1151 = disc;
                if (_e1151 <= 0f) {
                    continue;
                }
                let _e1153 = disc;
                sq = sqrt(_e1153);
                let _e1155 = b_3;
                let _e1157 = sq;
                tNear_1 = (-(_e1155) - _e1157);
                let _e1159 = b_3;
                let _e1161 = sq;
                tFar_1 = (-(_e1159) + _e1161);
                let _e1163 = tFar_1;
                if (_e1163 <= 0f) {
                    continue;
                }
                let _e1165 = tNear_1;
                bodyDist = max(0f, _e1165);
                let _e1167 = bodyDist;
                let _e1168 = finalDist;
                if (_e1167 < _e1168) {
                    let _e1170 = rayOrigin_3;
                    let _e1171 = rayDir_3;
                    let _e1172 = bodyDist;
                    let _e1175 = center;
                    surfaceNormal = normalize(((_e1170 + (_e1171 * _e1172)) - _e1175));
                    let _e1178 = surfaceNormal;
                    param_144 = _e1178;
                    let _e1179 = rayDir_3;
                    param_145 = _e1179;
                    let _e1180 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_144), (&param_145));
                    bodyColor = _e1180;
                    let _e1181 = bodyDist;
                    let _e1182 = MAX_VISIBILITY;
                    let _e1186 = bodyColor;
                    bodyColor = (_e1186 * mix(1f, 0f, clamp((_e1181 / _e1182), 0f, 1f)));
                    let _e1188 = bodyColor;
                    finalColor = vec4<f32>(_e1188.x, _e1188.y, _e1188.z, 1f);
                    let _e1193 = bodyDist;
                    finalDist = _e1193;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1194 = i_7;
                i_7 = (_e1194 + 1i);
            }
        }
    }
    let _e1197 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1197), 0f, 1f);
    let _e1200 = charge;
    cloudGreyness = _e1200;
    let _e1202 = unnamed.rainPhase;
    if (_e1202 == 1u) {
        let _e1205 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1205);
        let _e1207 = charge;
        let _e1209 = pc.time;
        let _e1210 = crossedTime;
        let _e1213 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1207, clamp(((_e1209 - _e1210) / _e1213), 0f, 1f));
    } else {
        let _e1218 = unnamed.rainPhase;
        if (_e1218 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1221 = tuning.cloudMaxAlpha;
    if (_e1221 > 0.002f) {
        let _e1224 = tuning.cloudColumnFullCount;
        let _e1227 = tuning.cloudThicknessPerBlock;
        slabMax = (max(_e1224, 1f) * max(_e1227, 0.01f));
        let _e1231 = unnamed.cloudMaxY;
        let _e1233 = slabMax;
        bandHi = (f32(_e1231) + _e1233);
        let _e1236 = unnamed.cloudMinY;
        let _e1239 = unnamed.cloudMaxY;
        let _e1241 = slabMax;
        let _e1245 = tuning.cloudVoxelSize;
        bandLo = (max(f32(_e1236), (f32(_e1239) - _e1241)) - max(_e1245, 1f));
        let _e1249 = unnamed.cloudMinY;
        let _e1251 = unnamed.cloudMaxY;
        if (_e1249 > _e1251) {
            local_26 = vec2<f32>(1f, -1f);
        } else {
            let _e1253 = bandLo;
            let _e1255 = worldExtent_u0028_();
            let _e1257 = bandHi;
            let _e1258 = worldExtent_u0028_();
            let _e1261 = rayOrigin_3;
            param_146 = _e1261;
            let _e1262 = rayDir_3;
            param_147 = _e1262;
            param_148 = vec3<f32>(0f, _e1253, 0f);
            param_149 = vec3<f32>(_e1255.x, _e1257, _e1258.z);
            let _e1263 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_146), (&param_147), (&param_148), (&param_149));
            local_26 = _e1263;
        }
        let _e1264 = local_26;
        cloudClip = _e1264;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1266 = cloudClip[0u];
        nearT = max(_e1266, 0f);
        let _e1269 = cloudClip[1u];
        let _e1270 = finalDist;
        farT = min(_e1269, _e1270);
        let _e1272 = nearT;
        let _e1273 = farT;
        if (_e1272 < _e1273) {
            let _e1275 = rayOrigin_3;
            param_150 = _e1275;
            let _e1276 = rayDir_3;
            param_151 = _e1276;
            let _e1277 = nearT;
            param_152 = _e1277;
            let _e1278 = farT;
            param_153 = _e1278;
            let _e1279 = cloudSunDir;
            param_154 = _e1279;
            let _e1280 = cloudGreyness;
            param_155 = _e1280;
            let _e1281 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b((&param_150), (&param_151), (&param_152), (&param_153), (&param_154), (&param_155), (&param_156), (&param_157), (&param_158));
            let _e1282 = param_156;
            cloudTHit = _e1282;
            let _e1283 = param_157;
            cloudColor = _e1283;
            let _e1284 = param_158;
            cloudDensity = _e1284;
            if _e1281 {
                let _e1285 = cloudTHit;
                if (_e1285 > 0f) {
                    let _e1287 = cloudTHit;
                    bestT = _e1287;
                    let _e1288 = cloudColor;
                    bestColor = _e1288;
                    let _e1290 = tuning.cloudMinAlpha;
                    let _e1292 = tuning.cloudMaxAlpha;
                    let _e1293 = cloudDensity;
                    bestAlpha = clamp(mix(_e1290, _e1292, _e1293), 0f, 0.95f);
                    foundCloud = true;
                }
            }
        }
        let _e1296 = foundCloud;
        let _e1297 = bestT;
        let _e1298 = finalDist;
        if (_e1296 && (_e1297 < _e1298)) {
            let _e1301 = finalColor;
            let _e1303 = bestColor;
            let _e1304 = bestAlpha;
            let _e1306 = mix(_e1301.xyz, _e1303, vec3(_e1304));
            finalColor[0u] = _e1306.x;
            finalColor[1u] = _e1306.y;
            finalColor[2u] = _e1306.z;
        }
    }
    let _e1314 = pc.spawnX;
    let _e1315 = (_e1314 >= 0i);
    phi_4172_ = _e1315;
    if _e1315 {
        let _e1317 = pc.spawnX;
        let _e1319 = tuning.gridWidth;
        phi_4172_ = (_e1317 < bitcast<i32>(_e1319));
    }
    let _e1323 = phi_4172_;
    phi_4179_ = _e1323;
    if _e1323 {
        let _e1325 = pc.spawnY;
        phi_4179_ = (_e1325 >= 0i);
    }
    let _e1328 = phi_4179_;
    phi_4188_ = _e1328;
    if _e1328 {
        let _e1330 = pc.spawnY;
        let _e1332 = tuning.gridHeight;
        phi_4188_ = (_e1330 < bitcast<i32>(_e1332));
    }
    let _e1336 = phi_4188_;
    phi_4194_ = _e1336;
    if _e1336 {
        let _e1338 = pc.spawnZ;
        phi_4194_ = (_e1338 >= 0i);
    }
    let _e1341 = phi_4194_;
    phi_4203_ = _e1341;
    if _e1341 {
        let _e1343 = pc.spawnZ;
        let _e1345 = tuning.gridDepth;
        phi_4203_ = (_e1343 < bitcast<i32>(_e1345));
    }
    let _e1349 = phi_4203_;
    if _e1349 {
        let _e1351 = pc.spawnSize;
        halfDistMin = (_e1351 / 2i);
        let _e1354 = pc.spawnSize;
        halfDistMax = ((_e1354 - 1i) / 2i);
        let _e1358 = pc.spawnX;
        let _e1359 = halfDistMin;
        let _e1363 = pc.spawnY;
        let _e1364 = halfDistMin;
        let _e1368 = pc.spawnZ;
        let _e1369 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1358 - _e1359)), f32((_e1363 - _e1364)), f32((_e1368 - _e1369)));
        let _e1374 = pc.spawnX;
        let _e1375 = halfDistMax;
        let _e1380 = pc.spawnY;
        let _e1381 = halfDistMax;
        let _e1386 = pc.spawnZ;
        let _e1387 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1374 + _e1375) + 1i)), f32(((_e1380 + _e1381) + 1i)), f32(((_e1386 + _e1387) + 1i)));
        let _e1393 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1396 = indexable_6[clamp(_e1393, 0i, 19i)];
        cursorColor = _e1396;
        let _e1398 = pc.spawnShape;
        if (_e1398 == 1i) {
            let _e1400 = boxMin_2;
            let _e1401 = boxMax_1;
            sphereCenter = ((_e1400 + _e1401) * 0.5f);
            let _e1405 = pc.spawnSize;
            sphereRadius = (f32(_e1405) * 0.5f);
            let _e1408 = rayOrigin_3;
            let _e1409 = sphereCenter;
            oc_1 = (_e1408 - _e1409);
            let _e1411 = oc_1;
            let _e1412 = rayDir_3;
            b_4 = dot(_e1411, _e1412);
            let _e1414 = oc_1;
            let _e1415 = oc_1;
            let _e1417 = sphereRadius;
            let _e1418 = sphereRadius;
            c_4 = (dot(_e1414, _e1415) - (_e1417 * _e1418));
            let _e1421 = b_4;
            let _e1422 = b_4;
            let _e1424 = c_4;
            disc_1 = ((_e1421 * _e1422) - _e1424);
            let _e1426 = disc_1;
            if (_e1426 > 0f) {
                let _e1428 = disc_1;
                sq_1 = sqrt(_e1428);
                let _e1430 = b_4;
                let _e1432 = sq_1;
                tNear_2 = (-(_e1430) - _e1432);
                let _e1434 = b_4;
                let _e1436 = sq_1;
                tFar_2 = (-(_e1434) + _e1436);
                let _e1438 = tFar_2;
                if (_e1438 > 0f) {
                    let _e1440 = tNear_2;
                    inside = (_e1440 <= 0f);
                    let _e1442 = inside;
                    let _e1443 = tFar_2;
                    let _e1444 = tNear_2;
                    cursorDist = select(_e1444, _e1443, _e1442);
                    let _e1446 = rayOrigin_3;
                    let _e1447 = rayDir_3;
                    let _e1448 = cursorDist;
                    let _e1451 = sphereCenter;
                    shellNormal = normalize(((_e1446 + (_e1447 * _e1448)) - _e1451));
                    let _e1454 = shellNormal;
                    let _e1455 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1454, _e1455)));
                    let _e1459 = rim_1;
                    let _e1462 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1459)) * select(1f, 0.35f, _e1462));
                    let _e1465 = cursorDist;
                    let _e1466 = finalDist;
                    if (_e1465 < _e1466) {
                        let _e1468 = finalColor;
                        let _e1470 = cursorColor;
                        let _e1471 = alpha;
                        let _e1473 = mix(_e1468.xyz, _e1470, vec3(_e1471));
                        finalColor[0u] = _e1473.x;
                        finalColor[1u] = _e1473.y;
                        finalColor[2u] = _e1473.z;
                    }
                }
            }
        } else {
            let _e1480 = rayOrigin_3;
            param_159 = _e1480;
            let _e1481 = rayDir_3;
            param_160 = _e1481;
            let _e1482 = boxMin_2;
            param_161 = _e1482;
            let _e1483 = boxMax_1;
            param_162 = _e1483;
            let _e1484 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_159), (&param_160), (&param_161), (&param_162));
            cursorHit = _e1484;
            let _e1486 = cursorHit[0u];
            let _e1488 = cursorHit[1u];
            let _e1489 = (_e1486 < _e1488);
            phi_4414_ = _e1489;
            if _e1489 {
                let _e1491 = cursorHit[1u];
                phi_4414_ = (_e1491 > 0f);
            }
            let _e1494 = phi_4414_;
            if _e1494 {
                let _e1496 = cursorHit[0u];
                distFront = max(0f, _e1496);
                let _e1499 = cursorHit[1u];
                distBack = _e1499;
                let _e1500 = rayOrigin_3;
                let _e1501 = rayDir_3;
                let _e1502 = distFront;
                hitPosFront = (_e1500 + (_e1501 * _e1502));
                let _e1505 = rayOrigin_3;
                let _e1506 = rayDir_3;
                let _e1507 = distBack;
                hitPosBack = (_e1505 + (_e1506 * _e1507));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1511 = hitPosFront[0u];
                let _e1513 = boxMin_2[0u];
                let _e1514 = e;
                let _e1516 = (_e1511 < (_e1513 + _e1514));
                phi_4456_ = _e1516;
                if !(_e1516) {
                    let _e1519 = hitPosFront[0u];
                    let _e1521 = boxMax_1[0u];
                    let _e1522 = e;
                    phi_4456_ = (_e1519 > (_e1521 - _e1522));
                }
                let _e1526 = phi_4456_;
                if _e1526 {
                    let _e1527 = edgesFront;
                    edgesFront = (_e1527 + 1i);
                }
                let _e1530 = hitPosFront[1u];
                let _e1532 = boxMin_2[1u];
                let _e1533 = e;
                let _e1535 = (_e1530 < (_e1532 + _e1533));
                phi_4478_ = _e1535;
                if !(_e1535) {
                    let _e1538 = hitPosFront[1u];
                    let _e1540 = boxMax_1[1u];
                    let _e1541 = e;
                    phi_4478_ = (_e1538 > (_e1540 - _e1541));
                }
                let _e1545 = phi_4478_;
                if _e1545 {
                    let _e1546 = edgesFront;
                    edgesFront = (_e1546 + 1i);
                }
                let _e1549 = hitPosFront[2u];
                let _e1551 = boxMin_2[2u];
                let _e1552 = e;
                let _e1554 = (_e1549 < (_e1551 + _e1552));
                phi_4500_ = _e1554;
                if !(_e1554) {
                    let _e1557 = hitPosFront[2u];
                    let _e1559 = boxMax_1[2u];
                    let _e1560 = e;
                    phi_4500_ = (_e1557 > (_e1559 - _e1560));
                }
                let _e1564 = phi_4500_;
                if _e1564 {
                    let _e1565 = edgesFront;
                    edgesFront = (_e1565 + 1i);
                }
                let _e1567 = edgesFront;
                if (_e1567 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1570 = hitPosBack[0u];
                let _e1572 = boxMin_2[0u];
                let _e1573 = e;
                let _e1575 = (_e1570 < (_e1572 + _e1573));
                phi_4528_ = _e1575;
                if !(_e1575) {
                    let _e1578 = hitPosBack[0u];
                    let _e1580 = boxMax_1[0u];
                    let _e1581 = e;
                    phi_4528_ = (_e1578 > (_e1580 - _e1581));
                }
                let _e1585 = phi_4528_;
                if _e1585 {
                    let _e1586 = edgesBack;
                    edgesBack = (_e1586 + 1i);
                }
                let _e1589 = hitPosBack[1u];
                let _e1591 = boxMin_2[1u];
                let _e1592 = e;
                let _e1594 = (_e1589 < (_e1591 + _e1592));
                phi_4550_ = _e1594;
                if !(_e1594) {
                    let _e1597 = hitPosBack[1u];
                    let _e1599 = boxMax_1[1u];
                    let _e1600 = e;
                    phi_4550_ = (_e1597 > (_e1599 - _e1600));
                }
                let _e1604 = phi_4550_;
                if _e1604 {
                    let _e1605 = edgesBack;
                    edgesBack = (_e1605 + 1i);
                }
                let _e1608 = hitPosBack[2u];
                let _e1610 = boxMin_2[2u];
                let _e1611 = e;
                let _e1613 = (_e1608 < (_e1610 + _e1611));
                phi_4572_ = _e1613;
                if !(_e1613) {
                    let _e1616 = hitPosBack[2u];
                    let _e1618 = boxMax_1[2u];
                    let _e1619 = e;
                    phi_4572_ = (_e1616 > (_e1618 - _e1619));
                }
                let _e1623 = phi_4572_;
                if _e1623 {
                    let _e1624 = edgesBack;
                    edgesBack = (_e1624 + 1i);
                }
                let _e1626 = edgesBack;
                if (_e1626 >= 2i) {
                    onBackEdge = true;
                }
                let _e1628 = onFrontEdge;
                let _e1629 = distFront;
                let _e1630 = finalDist;
                if (_e1628 && (_e1629 < _e1630)) {
                    let _e1633 = finalColor;
                    let _e1635 = cursorColor;
                    let _e1637 = mix(_e1633.xyz, _e1635, vec3(0.9f));
                    finalColor[0u] = _e1637.x;
                    finalColor[1u] = _e1637.y;
                    finalColor[2u] = _e1637.z;
                } else {
                    let _e1644 = onBackEdge;
                    let _e1645 = distBack;
                    let _e1646 = finalDist;
                    if (_e1644 && (_e1645 < _e1646)) {
                        let _e1649 = finalColor;
                        let _e1651 = cursorColor;
                        let _e1653 = mix(_e1649.xyz, _e1651, vec3(0.2f));
                        finalColor[0u] = _e1653.x;
                        finalColor[1u] = _e1653.y;
                        finalColor[2u] = _e1653.z;
                    } else {
                        let _e1660 = distFront;
                        let _e1661 = finalDist;
                        if (_e1660 < _e1661) {
                            let _e1663 = finalColor;
                            let _e1665 = cursorColor;
                            let _e1667 = mix(_e1663.xyz, _e1665, vec3(0.15f));
                            finalColor[0u] = _e1667.x;
                            finalColor[1u] = _e1667.y;
                            finalColor[2u] = _e1667.z;
                        }
                    }
                }
            }
        }
    }
    let _e1674 = hitFrontBox;
    if _e1674 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1675 = finalColor;
    outColor = _e1675;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
