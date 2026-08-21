// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: c3d1b23f6ab8a1f1e85a259a4d6442008c0375e335a2d6132bff979671bcd601

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
    let _e269 = (*p);
    return fract((sin(dot(_e269, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x: ptr<function, i32>, z: ptr<function, i32>) -> u32 {
    let _e270 = (*x);
    let _e271 = (*z);
    let _e273 = tuning.gridWidth;
    return (bitcast<u32>((_e270 + (_e271 * bitcast<i32>(_e273)))) * 4u);
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

    let _e278 = (*x_1);
    let _e279 = (_e278 < 0i);
    phi_2406_ = _e279;
    if !(_e279) {
        let _e281 = (*x_1);
        let _e283 = tuning.gridWidth;
        phi_2406_ = (_e281 >= bitcast<i32>(_e283));
    }
    let _e287 = phi_2406_;
    let _e288 = (*z_1);
    let _e290 = (_e287 || (_e288 < 0i));
    phi_2418_ = _e290;
    if !(_e290) {
        let _e292 = (*z_1);
        let _e294 = tuning.gridDepth;
        phi_2418_ = (_e292 >= bitcast<i32>(_e294));
    }
    let _e298 = phi_2418_;
    if _e298 {
        (*count) = 0f;
        (*topY) = 0f;
        return;
    }
    let _e299 = (*x_1);
    param = _e299;
    let _e300 = (*z_1);
    param_1 = _e300;
    let _e301 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param), (&param_1));
    b = _e301;
    let _e302 = b;
    let _e306 = unnamed.cloudColumn[(_e302 + 2u)];
    (*count) = (f32(_e306) * 0.0625f);
    let _e309 = b;
    let _e313 = unnamed.cloudColumn[(_e309 + 3u)];
    (*topY) = (f32(_e313) * 0.0625f);
    let _e317 = tuning.cloudEdgeFadeDist;
    d = max(_e317, 0.001f);
    let _e319 = d;
    let _e320 = (*x_1);
    let _e323 = d;
    let _e325 = tuning.gridWidth;
    let _e328 = (*x_1);
    fx = (smoothstep(0f, _e319, f32(_e320)) * smoothstep(0f, _e323, f32(((bitcast<i32>(_e325) - 1i) - _e328))));
    let _e333 = d;
    let _e334 = (*z_1);
    let _e337 = d;
    let _e339 = tuning.gridDepth;
    let _e342 = (*z_1);
    fz = (smoothstep(0f, _e333, f32(_e334)) * smoothstep(0f, _e337, f32(((bitcast<i32>(_e339) - 1i) - _e342))));
    let _e347 = fx;
    let _e348 = fz;
    let _e350 = (*count);
    (*count) = (_e350 * (_e347 * _e348));
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

    let _e303 = (*x_2);
    param_2 = _e303;
    let _e304 = (*z_2);
    param_3 = _e304;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_2), (&param_3), (&param_4), (&param_5));
    let _e305 = param_4;
    c0_ = _e305;
    let _e306 = param_5;
    y0_ = _e306;
    let _e307 = (*x_2);
    let _e308 = (*spread);
    param_6 = (_e307 - _e308);
    let _e310 = (*z_2);
    param_7 = _e310;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_6), (&param_7), (&param_8), (&param_9));
    let _e311 = param_8;
    c1_ = _e311;
    let _e312 = param_9;
    y1_ = _e312;
    let _e313 = (*x_2);
    let _e314 = (*spread);
    param_10 = (_e313 + _e314);
    let _e316 = (*z_2);
    param_11 = _e316;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_10), (&param_11), (&param_12), (&param_13));
    let _e317 = param_12;
    c2_ = _e317;
    let _e318 = param_13;
    y2_ = _e318;
    let _e319 = (*z_2);
    let _e320 = (*spread);
    let _e322 = (*x_2);
    param_14 = _e322;
    param_15 = (_e319 - _e320);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_14), (&param_15), (&param_16), (&param_17));
    let _e323 = param_16;
    c3_ = _e323;
    let _e324 = param_17;
    y3_ = _e324;
    let _e325 = (*z_2);
    let _e326 = (*spread);
    let _e328 = (*x_2);
    param_18 = _e328;
    param_19 = (_e325 + _e326);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_18), (&param_19), (&param_20), (&param_21));
    let _e329 = param_20;
    c4_ = _e329;
    let _e330 = param_21;
    y4_ = _e330;
    let _e331 = c0_;
    let _e333 = c1_;
    let _e335 = c2_;
    let _e337 = c3_;
    let _e339 = c4_;
    (*count_1) = ((((((_e331 * 2f) + _e333) + _e335) + _e337) + _e339) / 6f);
    let _e342 = y0_;
    let _e343 = y1_;
    let _e345 = y2_;
    let _e346 = y3_;
    let _e349 = y4_;
    (*topY_1) = max(max(max(_e342, _e343), max(_e345, _e346)), _e349);
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
    var levels: f32;
    var perLevel: f32;
    var cells: f32;
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
    var phi_2837_: bool;

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
            phi_2760_ = _e457;
            if _e457 {
                let _e458 = cx;
                let _e460 = tuning.gridWidth;
                phi_2760_ = (_e458 < bitcast<i32>(_e460));
            }
            let _e464 = phi_2760_;
            let _e465 = cz;
            let _e467 = (_e464 && (_e465 >= 0i));
            phi_2771_ = _e467;
            if _e467 {
                let _e468 = cz;
                let _e470 = tuning.gridDepth;
                phi_2771_ = (_e468 < bitcast<i32>(_e470));
            }
            let _e474 = phi_2771_;
            if _e474 {
                let _e475 = cx;
                param_22 = _e475;
                let _e476 = cz;
                param_23 = _e476;
                let _e477 = spread_1;
                param_24 = _e477;
                smoothedCloudColumn_u0028_i1_u003b_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_22), (&param_23), (&param_24), (&param_25), (&param_26));
                let _e478 = param_25;
                count_2 = _e478;
                let _e479 = param_26;
                baseY = _e479;
                let _e480 = count_2;
                if (_e480 > 0f) {
                    let _e483 = tuning.cloudVoxelSize;
                    cell = max(_e483, 0.5f);
                    let _e486 = tuning.cloudHeightLevels;
                    levels = max(_e486, 1f);
                    let _e489 = tuning.cloudBlocksPerLevel;
                    perLevel = max(_e489, 0.01f);
                    let _e491 = count_2;
                    let _e492 = perLevel;
                    let _e496 = levels;
                    cells = clamp((1f + floor((_e491 / _e492))), 1f, _e496);
                    let _e498 = baseY;
                    let _e499 = cell;
                    let _e502 = cell;
                    baseY = (floor((_e498 / _e499)) * _e502);
                    let _e504 = cells;
                    let _e505 = cell;
                    thickness = (_e504 * _e505);
                    let _e507 = baseY;
                    let _e508 = thickness;
                    capY = (_e507 + _e508);
                    let _e511 = cellCenter[1u];
                    let _e512 = baseY;
                    let _e513 = (_e511 >= _e512);
                    phi_2837_ = _e513;
                    if _e513 {
                        let _e515 = cellCenter[1u];
                        let _e516 = capY;
                        phi_2837_ = (_e515 <= _e516);
                    }
                    let _e519 = phi_2837_;
                    if _e519 {
                        let _e520 = count_2;
                        let _e522 = tuning.cloudColumnFullCount;
                        density = clamp((_e520 / max(_e522, 1f)), 0f, 1f);
                        let _e526 = baseY;
                        let _e527 = capY;
                        mid = ((_e526 + _e527) * 0.5f);
                        let _e531 = cellCenter[1u];
                        let _e532 = mid;
                        let _e535 = thickness;
                        edgeFactor = clamp((abs((_e531 - _e532)) / max((_e535 * 0.5f), 0.001f)), 0f, 1f);
                        let _e541 = tuning.cloudEdgeThresholdMin;
                        let _e543 = tuning.cloudEdgeThresholdMax;
                        let _e544 = edgeFactor;
                        threshold = mix(_e541, _e543, _e544);
                        let _e546 = cellPos;
                        param_27 = vec3<f32>(_e546);
                        let _e548 = hash_u0028_vf3_u003b((&param_27));
                        fillHash = _e548;
                        let _e549 = fillHash;
                        let _e550 = threshold;
                        if (_e549 > _e550) {
                            let _e552 = t;
                            (*tHit) = _e552;
                            let _e553 = density;
                            (*hitDensity) = _e553;
                            let _e554 = cellPos;
                            param_28 = ((vec3<f32>(_e554) * 3.71f) + vec3<f32>(91f, 5f, 7f));
                            let _e558 = hash_u0028_vf3_u003b((&param_28));
                            shadeHash = _e558;
                            let _e559 = shadeHash;
                            baseColor = mix(vec3<f32>(0.9f, 0.91f, 0.94f), vec3<f32>(1f, 1f, 1f), vec3(_e559));
                            stormColor = vec3<f32>(0.32f, 0.33f, 0.36f);
                            let _e562 = baseColor;
                            let _e563 = stormColor;
                            let _e564 = (*greyness);
                            baseColor = mix(_e562, _e563, vec3(_e564));
                            let _e567 = normal;
                            let _e568 = (*sunDir);
                            diffuse = (0.6f + (0.4f * max(dot(_e567, _e568), 0f)));
                            let _e573 = baseColor;
                            let _e574 = diffuse;
                            (*hitColor) = (_e573 * _e574);
                            return true;
                        }
                    }
                }
            }
            let _e577 = tMax[0u];
            let _e579 = tMax[1u];
            if (_e577 < _e579) {
                let _e582 = tMax[0u];
                let _e584 = tMax[2u];
                if (_e582 < _e584) {
                    let _e587 = stepDir[0u];
                    let _e589 = cellPos[0u];
                    cellPos[0u] = (_e589 + _e587);
                    let _e593 = tMax[0u];
                    t = _e593;
                    let _e595 = tDelta[0u];
                    let _e597 = tMax[0u];
                    tMax[0u] = (_e597 + _e595);
                    let _e601 = stepDir[0u];
                    normal = vec3<f32>(f32(-(_e601)), 0f, 0f);
                } else {
                    let _e606 = stepDir[2u];
                    let _e608 = cellPos[2u];
                    cellPos[2u] = (_e608 + _e606);
                    let _e612 = tMax[2u];
                    t = _e612;
                    let _e614 = tDelta[2u];
                    let _e616 = tMax[2u];
                    tMax[2u] = (_e616 + _e614);
                    let _e620 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e620)));
                }
            } else {
                let _e625 = tMax[1u];
                let _e627 = tMax[2u];
                if (_e625 < _e627) {
                    let _e630 = stepDir[1u];
                    let _e632 = cellPos[1u];
                    cellPos[1u] = (_e632 + _e630);
                    let _e636 = tMax[1u];
                    t = _e636;
                    let _e638 = tDelta[1u];
                    let _e640 = tMax[1u];
                    tMax[1u] = (_e640 + _e638);
                    let _e644 = stepDir[1u];
                    normal = vec3<f32>(0f, f32(-(_e644)), 0f);
                } else {
                    let _e649 = stepDir[2u];
                    let _e651 = cellPos[2u];
                    cellPos[2u] = (_e651 + _e649);
                    let _e655 = tMax[2u];
                    t = _e655;
                    let _e657 = tDelta[2u];
                    let _e659 = tMax[2u];
                    tMax[2u] = (_e659 + _e657);
                    let _e663 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e663)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e667 = i;
            i = (_e667 + 1i);
        }
    }
    return false;
}

fn renderBlackHole_u0028_vf3_u003b_vf3_u003b(normal_1: ptr<function, vec3<f32>>, rayDir_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var rim: f32;
    var glow: f32;

    let _e272 = (*normal_1);
    let _e273 = (*rayDir_1);
    rim = (1f - abs(dot(_e272, _e273)));
    let _e277 = rim;
    glow = pow(clamp(_e277, 0f, 1f), 4f);
    let _e280 = glow;
    return mix(vec3<f32>(0.01f, 0.01f, 0.02f), vec3<f32>(0.85f, 0.45f, 1f), vec3((_e280 * 0.7f)));
}

fn bhDecode_u0028_u1_u003b(code: ptr<function, u32>) -> vec3<i32> {
    var i_1: u32;

    let _e270 = (*code);
    i_1 = (_e270 & 1073741823u);
    let _e272 = i_1;
    let _e274 = tuning.gridWidth;
    let _e279 = i_1;
    let _e281 = tuning.gridWidth;
    let _e286 = tuning.gridHeight;
    let _e291 = i_1;
    let _e293 = tuning.gridWidth;
    let _e296 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e272 % bitcast<u32>(bitcast<i32>(_e274)))), bitcast<i32>(((_e279 / bitcast<u32>(bitcast<i32>(_e281))) % bitcast<u32>(bitcast<i32>(_e286)))), bitcast<i32>((_e291 / bitcast<u32>((bitcast<i32>(_e293) * bitcast<i32>(_e296))))));
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e269 = (*level);
    return (f32(_e269) + 0.5f);
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
        let _e274 = l;
        let _e276 = tuning.blackHoleMaxLevel;
        if (_e274 <= min(_e276, 16u)) {
            let _e279 = l;
            param_29 = _e279;
            let _e280 = bhBodyRadius_u0028_u1_u003b((&param_29));
            r = _e280;
            let _e281 = r;
            let _e283 = r;
            let _e285 = r;
            volume = (((4.18879f * _e281) * _e283) * _e285);
            let _e287 = (*mass);
            let _e290 = tuning.blackHoleGrowthCost;
            let _e291 = volume;
            if (f32(_e287) < (_e290 * _e291)) {
                break;
            }
            let _e294 = l;
            level_1 = _e294;
            continue;
        } else {
            break;
        }
        continuing {
            let _e295 = l;
            l = (_e295 + bitcast<u32>(1i));
        }
    }
    let _e298 = level_1;
    return _e298;
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

    let _e281 = unnamed.blackHoleCount;
    let _e282 = (_e281 == 0u);
    phi_2291_ = _e282;
    if !(_e282) {
        let _e285 = tuning.blackHoleGlow;
        phi_2291_ = (_e285 <= 0f);
    }
    let _e288 = phi_2291_;
    if _e288 {
        let _e289 = (*color);
        return _e289;
    }
    let _e291 = tuning.blackHoleRadius;
    radius = f32(_e291);
    let _e293 = radius;
    let _e294 = radius;
    closestSq = (_e293 * _e294);
    seen = 0u;
    i_2 = 0i;
    loop {
        let _e296 = i_2;
        let _e297 = (_e296 < 8i);
        phi_2320_ = _e297;
        if _e297 {
            let _e298 = seen;
            let _e300 = unnamed.blackHoleCount;
            phi_2320_ = (_e298 < _e300);
        }
        let _e303 = phi_2320_;
        if _e303 {
            let _e304 = i_2;
            let _e307 = unnamed.blackHoles[_e304];
            code_1 = _e307;
            let _e308 = code_1;
            if (_e308 == 0u) {
                continue;
            }
            let _e310 = seen;
            seen = (_e310 + bitcast<u32>(1i));
            let _e313 = code_1;
            param_30 = _e313;
            let _e314 = bhDecode_u0028_u1_u003b((&param_30));
            let _e315 = (*voxelPos);
            d_1 = vec3<f32>((_e314 - _e315));
            let _e318 = closestSq;
            let _e319 = d_1;
            let _e320 = d_1;
            closestSq = min(_e318, dot(_e319, _e320));
            continue;
        } else {
            break;
        }
        continuing {
            let _e323 = i_2;
            i_2 = (_e323 + 1i);
        }
    }
    let _e325 = closestSq;
    let _e326 = radius;
    let _e327 = radius;
    if (_e325 >= (_e326 * _e327)) {
        let _e330 = (*color);
        return _e330;
    }
    let _e331 = closestSq;
    closest = sqrt(_e331);
    let _e333 = closest;
    let _e334 = radius;
    let _e339 = tuning.blackHoleGlow;
    heat = (pow((1f - (_e333 / _e334)), 3f) * _e339);
    let _e341 = heat;
    hot = mix(vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(1f, 0.95f, 0.85f), vec3(clamp(_e341, 0f, 1f)));
    let _e345 = (*color);
    let _e346 = hot;
    let _e347 = heat;
    return mix(_e345, _e346, vec3(clamp(_e347, 0f, 1f)));
}

fn renderAsh_u0028_vi3_u003b_vf3_u003b(voxelPos_1: ptr<function, vec3<i32>>, baseLighting: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n: f32;
    var param_31: vec3<f32>;
    var c: vec3<f32>;

    let _e273 = (*voxelPos_1);
    param_31 = vec3<f32>(_e273);
    let _e275 = hash_u0028_vf3_u003b((&param_31));
    n = _e275;
    let _e276 = n;
    c = mix(vec3<f32>(0.2f, 0.19f, 0.18f), vec3<f32>(0.47f, 0.45f, 0.42f), vec3(_e276));
    let _e279 = c;
    let _e280 = (*baseLighting);
    return (_e279 * _e280);
}

fn renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b(rawVoxel: ptr<function, u32>, voxelPos_2: ptr<function, vec3<i32>>, baseLighting_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_1: f32;
    var param_32: vec3<f32>;
    var dist: u32;
    var depth: f32;
    var inner: vec3<f32>;
    var outer: vec3<f32>;
    var leaf: vec3<f32>;

    let _e278 = (*voxelPos_2);
    param_32 = vec3<f32>(_e278);
    let _e280 = hash_u0028_vf3_u003b((&param_32));
    n_1 = _e280;
    let _e281 = (*rawVoxel);
    dist = ((_e281 >> bitcast<u32>(24i)) & 255u);
    let _e285 = dist;
    if (_e285 == 255u) {
        let _e287 = n_1;
        let _e290 = (*baseLighting_1);
        return (mix(vec3<f32>(0.34f, 0.22f, 0.07f), vec3<f32>(0.52f, 0.38f, 0.12f), vec3(_e287)) * _e290);
    }
    let _e292 = dist;
    let _e295 = tuning.treeLeafReach;
    depth = clamp((f32(_e292) / max(f32(_e295), 1f)), 0f, 1f);
    inner = vec3<f32>(0.1f, 0.3f, 0.09f);
    outer = vec3<f32>(0.28f, 0.52f, 0.16f);
    let _e300 = inner;
    let _e301 = outer;
    let _e302 = depth;
    let _e304 = n_1;
    leaf = mix(_e300, _e301, vec3(((_e302 * 0.7f) + (_e304 * 0.3f))));
    let _e309 = leaf;
    let _e310 = (*baseLighting_1);
    return (_e309 * _e310);
}

fn renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_3: ptr<function, vec3<i32>>, subCell: ptr<function, vec3<f32>>, baseLighting_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var grain: f32;
    var param_33: vec3<f32>;
    var bark: vec3<f32>;

    let _e275 = (*voxelPos_3)[0u];
    let _e278 = (*voxelPos_3)[1u];
    let _e282 = (*subCell)[1u];
    let _e286 = (*voxelPos_3)[2u];
    param_33 = vec3<f32>(f32(_e275), ((f32(_e278) * 0.35f) + (_e282 * 0.2f)), f32(_e286));
    let _e289 = hash_u0028_vf3_u003b((&param_33));
    grain = _e289;
    let _e290 = grain;
    bark = mix(vec3<f32>(0.2f, 0.13f, 0.07f), vec3<f32>(0.38f, 0.25f, 0.13f), vec3(_e290));
    let _e293 = bark;
    let _e294 = (*baseLighting_2);
    return (_e293 * _e294);
}

fn renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_4: ptr<function, vec3<i32>>, subCell_1: ptr<function, vec3<f32>>, baseLighting_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_2: f32;
    var param_34: vec3<f32>;
    var shell: vec3<f32>;

    let _e274 = (*subCell_1);
    let _e276 = (*voxelPos_4);
    param_34 = ((_e274 * 1.37f) + (vec3<f32>(_e276) * 0.11f));
    let _e280 = hash_u0028_vf3_u003b((&param_34));
    n_2 = _e280;
    let _e281 = n_2;
    shell = mix(vec3<f32>(0.15f, 0.1f, 0.035f), vec3<f32>(0.55f, 0.4f, 0.11f), vec3(_e281));
    let _e284 = shell;
    let _e285 = (*baseLighting_3);
    return (_e284 * _e285);
}

fn renderDarkStone_u0028_vi3_u003b_vf3_u003b(voxelPos_5: ptr<function, vec3<i32>>, baseLighting_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise: f32;
    var param_35: vec3<f32>;
    var val: f32;

    let _e273 = (*voxelPos_5);
    param_35 = vec3<f32>(_e273);
    let _e275 = hash_u0028_vf3_u003b((&param_35));
    noise = _e275;
    let _e276 = noise;
    val = (0.1f + (_e276 * 0.06f));
    let _e279 = val;
    let _e281 = val;
    let _e283 = val;
    let _e286 = (*baseLighting_4);
    return (vec3<f32>((_e279 * 1.08f), (_e281 * 0.94f), (_e283 * 0.92f)) * _e286);
}

fn lavaStageColor_u0028_i1_u003b(stage: ptr<function, i32>) -> vec3<f32> {
    var indexable: array<vec3<f32>, 6>;

    let _e270 = (*stage);
    indexable = array<vec3<f32>, 6>(vec3<f32>(1f, 0.62f, 0.22f), vec3<f32>(1f, 0.4f, 0.07f), vec3<f32>(0.96f, 0.29f, 0.05f), vec3<f32>(0.86f, 0.2f, 0.04f), vec3<f32>(0.7f, 0.13f, 0.03f), vec3<f32>(0.44f, 0.07f, 0.02f));
    let _e274 = indexable[clamp((_e270 + 1i), 0i, 5i)];
    return _e274;
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

    let _e284 = (*rawVoxel_1);
    stage_1 = clamp((bitcast<i32>((_e284 & 255u)) - 8i), 0i, 3i);
    let _e290 = pc.time;
    let _e292 = tuning.lavaChurnRate;
    let _e294 = (*voxelPos_6);
    param_36 = vec3<f32>(_e294);
    let _e296 = hash_u0028_vf3_u003b((&param_36));
    phase = fract(((_e290 * _e292) + _e296));
    let _e299 = phase;
    if (_e299 < 0.33333334f) {
        let _e301 = stage_1;
        param_37 = (_e301 - 1i);
        let _e303 = lavaStageColor_u0028_i1_u003b((&param_37));
        from_ = _e303;
        let _e304 = stage_1;
        param_38 = _e304;
        let _e305 = lavaStageColor_u0028_i1_u003b((&param_38));
        to = _e305;
        let _e306 = phase;
        leg = (_e306 * 3f);
    } else {
        let _e308 = phase;
        if (_e308 < 0.6666667f) {
            let _e310 = stage_1;
            param_39 = _e310;
            let _e311 = lavaStageColor_u0028_i1_u003b((&param_39));
            from_ = _e311;
            let _e312 = stage_1;
            param_40 = (_e312 + 1i);
            let _e314 = lavaStageColor_u0028_i1_u003b((&param_40));
            to = _e314;
            let _e315 = phase;
            leg = ((_e315 * 3f) - 1f);
        } else {
            let _e318 = stage_1;
            param_41 = (_e318 + 1i);
            let _e320 = lavaStageColor_u0028_i1_u003b((&param_41));
            from_ = _e320;
            let _e321 = stage_1;
            param_42 = (_e321 - 1i);
            let _e323 = lavaStageColor_u0028_i1_u003b((&param_42));
            to = _e323;
            let _e324 = phase;
            leg = ((_e324 * 3f) - 2f);
        }
    }
    let _e327 = from_;
    let _e328 = to;
    let _e329 = leg;
    molten = mix(_e327, _e328, vec3(smoothstep(0f, 1f, _e329)));
    let _e333 = molten;
    let _e334 = (*voxelPos_6);
    param_43 = (vec3<f32>(_e334) * 1.7f);
    let _e337 = hash_u0028_vf3_u003b((&param_43));
    return (_e333 * (0.9f + (_e337 * 0.1f)));
}

fn renderSteam_u0028_vi3_u003b_vf3_u003b(voxelPos_7: ptr<function, vec3<i32>>, baseLighting_5: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_1: f32;
    var param_44: vec3<f32>;
    var val_1: f32;
    var baseColor_1: vec3<f32>;

    let _e274 = (*voxelPos_7);
    let _e277 = pc.time;
    param_44 = (vec3<f32>(_e274) + vec3(_e277));
    let _e280 = hash_u0028_vf3_u003b((&param_44));
    noise_1 = _e280;
    let _e281 = noise_1;
    val_1 = (0.85f + (_e281 * 0.15f));
    let _e284 = val_1;
    baseColor_1 = vec3(_e284);
    let _e286 = baseColor_1;
    let _e287 = (*baseLighting_5);
    return ((_e286 * _e287) * 0.9f);
}

fn renderFire_u0028_u1_u003b_vi3_u003b(rawVoxel_2: ptr<function, u32>, voxelPos_8: ptr<function, vec3<i32>>) -> vec3<f32> {
    var noise_2: f32;
    var param_45: vec3<f32>;
    var age: u32;
    var life: f32;
    var coreColor: vec3<f32>;
    var edgeColor: vec3<f32>;
    var fireColor: vec3<f32>;

    let _e277 = (*voxelPos_8);
    let _e280 = pc.time;
    param_45 = (vec3<f32>(_e277) + vec3((_e280 * 10f)));
    let _e284 = hash_u0028_vf3_u003b((&param_45));
    noise_2 = _e284;
    let _e285 = (*rawVoxel_2);
    age = ((_e285 >> bitcast<u32>(24i)) & 255u);
    let _e289 = age;
    life = clamp((f32(_e289) / 30f), 0f, 1f);
    coreColor = vec3<f32>(1f, 0.9f, 0.2f);
    edgeColor = vec3<f32>(1f, 0.3f, 0f);
    let _e293 = coreColor;
    let _e294 = edgeColor;
    let _e295 = life;
    let _e296 = noise_2;
    fireColor = mix(_e293, _e294, vec3((_e295 + (_e296 * 0.3f))));
    let _e301 = fireColor;
    return (_e301 * 1.5f);
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

    let _e284 = (*voxelPos_9);
    param_46 = vec3<f32>(_e284);
    let _e286 = hash_u0028_vf3_u003b((&param_46));
    noise_3 = _e286;
    let _e287 = noise_3;
    val_2 = (0.8f + (_e287 * 0.2f));
    let _e290 = (*rawVoxel_3);
    moisture = ((_e290 >> bitcast<u32>(24i)) & 255u);
    let _e294 = moisture;
    wetness = clamp((f32(_e294) / 30f), 0f, 1f);
    let _e298 = val_2;
    let _e300 = val_2;
    let _e302 = val_2;
    dryColor = vec3<f32>((0.4f * _e298), (0.25f * _e300), (0.1f * _e302));
    let _e305 = val_2;
    let _e307 = val_2;
    let _e309 = val_2;
    wetColor = vec3<f32>((0.15f * _e305), (0.08f * _e307), (0.03f * _e309));
    let _e312 = dryColor;
    let _e313 = wetColor;
    let _e314 = wetness;
    baseColor_2 = mix(_e312, _e313, vec3(_e314));
    let _e317 = (*rawVoxel_3);
    floraState = ((_e317 >> bitcast<u32>(8i)) & 255u);
    let _e321 = floraState;
    let _e322 = (_e321 > 10u);
    phi_1273_ = _e322;
    if _e322 {
        let _e324 = (*ddaNormal)[1u];
        phi_1273_ = (_e324 > 0.5f);
    }
    let _e327 = phi_1273_;
    if _e327 {
        let _e328 = floraState;
        grassGrow = clamp((f32((_e328 - 10u)) / 90f), 0f, 1f);
        let _e333 = noise_3;
        let _e336 = noise_3;
        grassColor = vec3<f32>((0.15f + (_e333 * 0.1f)), (0.45f + (_e336 * 0.15f)), 0.15f);
        let _e340 = floraState;
        if (_e340 > 100u) {
            let _e342 = floraState;
            drown = clamp((f32((_e342 - 100u)) / 100f), 0f, 1f);
            let _e347 = grassColor;
            let _e348 = drown;
            grassColor = mix(_e347, vec3<f32>(0.35f, 0.35f, 0.15f), vec3(_e348));
        }
        let _e351 = baseColor_2;
        let _e352 = grassColor;
        let _e353 = grassGrow;
        baseColor_2 = mix(_e351, _e352, vec3(_e353));
    }
    let _e356 = baseColor_2;
    let _e357 = (*baseLighting_6);
    return (_e356 * _e357);
}

fn renderStone_u0028_vi3_u003b_vf3_u003b(voxelPos_10: ptr<function, vec3<i32>>, baseLighting_7: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_4: f32;
    var param_47: vec3<f32>;
    var val_3: f32;
    var baseColor_3: vec3<f32>;

    let _e274 = (*voxelPos_10);
    param_47 = vec3<f32>(_e274);
    let _e276 = hash_u0028_vf3_u003b((&param_47));
    noise_4 = _e276;
    let _e277 = noise_4;
    val_3 = (0.4f + (_e277 * 0.3f));
    let _e280 = val_3;
    baseColor_3 = vec3(_e280);
    let _e282 = baseColor_3;
    let _e283 = (*baseLighting_7);
    return (_e282 * _e283);
}

fn renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b(voxelPos_11: ptr<function, vec3<i32>>, normal_2: ptr<function, vec3<f32>>, rayOrigin_1: ptr<function, vec3<f32>>, sunDir_1: ptr<function, vec3<f32>>, sunColor: ptr<function, vec3<f32>>, shadow: ptr<function, f32>, baseLighting_8: ptr<function, vec3<f32>>) -> vec3<f32> {
    var baseColor_4: vec3<f32>;
    var viewDir: vec3<f32>;
    var reflectDir: vec3<f32>;
    var spec: f32;
    var finalLighting: vec3<f32>;

    baseColor_4 = vec3<f32>(0.1f, 0.4f, 0.9f);
    let _e280 = (*rayOrigin_1);
    let _e281 = (*voxelPos_11);
    viewDir = normalize((_e280 - vec3<f32>(_e281)));
    let _e285 = (*sunDir_1);
    let _e287 = (*normal_2);
    reflectDir = reflect(-(_e285), _e287);
    let _e289 = viewDir;
    let _e290 = reflectDir;
    spec = pow(max(dot(_e289, _e290), 0f), 32f);
    let _e294 = (*baseLighting_8);
    let _e295 = (*sunColor);
    let _e296 = spec;
    let _e299 = (*shadow);
    finalLighting = (_e294 + (((_e295 * _e296) * 0.5f) * _e299));
    let _e302 = baseColor_4;
    let _e303 = finalLighting;
    return (_e302 * _e303);
}

fn renderSand_u0028_u1_u003b_vf3_u003b(rawVoxel_4: ptr<function, u32>, baseLighting_9: ptr<function, vec3<f32>>) -> vec3<f32> {
    var moisture_1: u32;
    var wetness_1: f32;
    var dryColor_1: vec3<f32>;
    var wetColor_1: vec3<f32>;
    var baseColor_5: vec3<f32>;

    let _e275 = (*rawVoxel_4);
    moisture_1 = ((_e275 >> bitcast<u32>(24i)) & 255u);
    let _e279 = moisture_1;
    wetness_1 = clamp((f32(_e279) / 10f), 0f, 1f);
    dryColor_1 = vec3<f32>(0.9f, 0.8f, 0.2f);
    wetColor_1 = vec3<f32>(0.65f, 0.55f, 0.15f);
    let _e283 = dryColor_1;
    let _e284 = wetColor_1;
    let _e285 = wetness_1;
    baseColor_5 = mix(_e283, _e284, vec3(_e285));
    let _e288 = baseColor_5;
    let _e289 = (*baseLighting_9);
    return (_e288 * _e289);
}

fn getVoxel_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    var index: u32;
    var phi_288_: bool;
    var phi_296_: bool;
    var phi_306_: bool;
    var phi_314_: bool;
    var phi_324_: bool;

    let _e271 = (*pos)[0u];
    let _e272 = (_e271 < 0i);
    phi_288_ = _e272;
    if !(_e272) {
        let _e275 = (*pos)[0u];
        let _e277 = tuning.gridWidth;
        phi_288_ = (_e275 >= bitcast<i32>(_e277));
    }
    let _e281 = phi_288_;
    phi_296_ = _e281;
    if !(_e281) {
        let _e284 = (*pos)[1u];
        phi_296_ = (_e284 < 0i);
    }
    let _e287 = phi_296_;
    phi_306_ = _e287;
    if !(_e287) {
        let _e290 = (*pos)[1u];
        let _e292 = tuning.gridHeight;
        phi_306_ = (_e290 >= bitcast<i32>(_e292));
    }
    let _e296 = phi_306_;
    phi_314_ = _e296;
    if !(_e296) {
        let _e299 = (*pos)[2u];
        phi_314_ = (_e299 < 0i);
    }
    let _e302 = phi_314_;
    phi_324_ = _e302;
    if !(_e302) {
        let _e305 = (*pos)[2u];
        let _e307 = tuning.gridDepth;
        phi_324_ = (_e305 >= bitcast<i32>(_e307));
    }
    let _e311 = phi_324_;
    if _e311 {
        return 0u;
    }
    let _e313 = (*pos)[0u];
    let _e315 = (*pos)[1u];
    let _e317 = tuning.gridWidth;
    let _e322 = (*pos)[2u];
    let _e324 = tuning.gridWidth;
    let _e328 = tuning.gridHeight;
    index = bitcast<u32>(((_e313 + (_e315 * bitcast<i32>(_e317))) + ((_e322 * bitcast<i32>(_e324)) * bitcast<i32>(_e328))));
    let _e333 = index;
    let _e336 = unnamed_1.grid[_e333];
    return _e336;
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

    let _e283 = (*hitVoxelPos);
    let _e284 = (*hitNormal);
    voxelPos_12 = (_e283 + vec3<i32>(round(_e284)));
    let _e288 = (*lightDir);
    stepDir_1 = vec3<i32>(sign(_e288));
    let _e292 = (*lightDir)[0u];
    if (_e292 == 0f) {
        local_6 = 100000000f;
    } else {
        let _e295 = (*lightDir)[0u];
        local_6 = abs((1f / _e295));
    }
    let _e298 = local_6;
    let _e300 = (*lightDir)[1u];
    if (_e300 == 0f) {
        local_7 = 100000000f;
    } else {
        let _e303 = (*lightDir)[1u];
        local_7 = abs((1f / _e303));
    }
    let _e306 = local_7;
    let _e308 = (*lightDir)[2u];
    if (_e308 == 0f) {
        local_8 = 100000000f;
    } else {
        let _e311 = (*lightDir)[2u];
        local_8 = abs((1f / _e311));
    }
    let _e314 = local_8;
    tDelta_1 = vec3<f32>(_e298, _e306, _e314);
    let _e316 = tDelta_1;
    tMax_1 = (_e316 * 0.5f);
    transmittance = 1f;
    i_3 = 0i;
    loop {
        let _e318 = i_3;
        let _e320 = tuning.shadowMaxSteps;
        if (_e318 < bitcast<i32>(_e320)) {
            let _e324 = voxelPos_12[0u];
            let _e325 = (_e324 < 0i);
            phi_605_ = _e325;
            if !(_e325) {
                let _e328 = voxelPos_12[0u];
                let _e330 = tuning.gridWidth;
                phi_605_ = (_e328 >= bitcast<i32>(_e330));
            }
            let _e334 = phi_605_;
            phi_612_ = _e334;
            if !(_e334) {
                let _e337 = voxelPos_12[1u];
                phi_612_ = (_e337 < 0i);
            }
            let _e340 = phi_612_;
            phi_620_ = _e340;
            if !(_e340) {
                let _e343 = voxelPos_12[1u];
                let _e344 = (*ceilingY);
                phi_620_ = (_e343 >= _e344);
            }
            let _e347 = phi_620_;
            phi_627_ = _e347;
            if !(_e347) {
                let _e350 = voxelPos_12[2u];
                phi_627_ = (_e350 < 0i);
            }
            let _e353 = phi_627_;
            phi_637_ = _e353;
            if !(_e353) {
                let _e356 = voxelPos_12[2u];
                let _e358 = tuning.gridDepth;
                phi_637_ = (_e356 >= bitcast<i32>(_e358));
            }
            let _e362 = phi_637_;
            if _e362 {
                let _e363 = transmittance;
                return _e363;
            }
            let _e364 = voxelPos_12;
            param_48 = _e364;
            let _e365 = getVoxel_u0028_vi3_u003b((&param_48));
            blockerType = (_e365 & 255u);
            let _e367 = blockerType;
            if (_e367 == 2u) {
                let _e370 = tuning.waterShadowTransmit;
                let _e371 = transmittance;
                transmittance = (_e371 * _e370);
                let _e373 = transmittance;
                if (_e373 < 0.02f) {
                    return 0f;
                }
            } else {
                let _e375 = blockerType;
                if (_e375 != 0u) {
                    return 0f;
                }
            }
            let _e378 = tMax_1[0u];
            let _e380 = tMax_1[1u];
            if (_e378 < _e380) {
                let _e383 = tMax_1[0u];
                let _e385 = tMax_1[2u];
                if (_e383 < _e385) {
                    let _e388 = stepDir_1[0u];
                    let _e390 = voxelPos_12[0u];
                    voxelPos_12[0u] = (_e390 + _e388);
                    let _e394 = tDelta_1[0u];
                    let _e396 = tMax_1[0u];
                    tMax_1[0u] = (_e396 + _e394);
                } else {
                    let _e400 = stepDir_1[2u];
                    let _e402 = voxelPos_12[2u];
                    voxelPos_12[2u] = (_e402 + _e400);
                    let _e406 = tDelta_1[2u];
                    let _e408 = tMax_1[2u];
                    tMax_1[2u] = (_e408 + _e406);
                }
            } else {
                let _e412 = tMax_1[1u];
                let _e414 = tMax_1[2u];
                if (_e412 < _e414) {
                    let _e417 = stepDir_1[1u];
                    let _e419 = voxelPos_12[1u];
                    voxelPos_12[1u] = (_e419 + _e417);
                    let _e423 = tDelta_1[1u];
                    let _e425 = tMax_1[1u];
                    tMax_1[1u] = (_e425 + _e423);
                } else {
                    let _e429 = stepDir_1[2u];
                    let _e431 = voxelPos_12[2u];
                    voxelPos_12[2u] = (_e431 + _e429);
                    let _e435 = tDelta_1[2u];
                    let _e437 = tMax_1[2u];
                    tMax_1[2u] = (_e437 + _e435);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e440 = i_3;
            i_3 = (_e440 + 1i);
        }
    }
    let _e442 = transmittance;
    return _e442;
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
        let _e275 = x_3;
        if (_e275 <= 1i) {
            y = -1i;
            loop {
                let _e277 = y;
                if (_e277 <= 1i) {
                    z_3 = -1i;
                    loop {
                        let _e279 = z_3;
                        if (_e279 <= 1i) {
                            let _e281 = x_3;
                            let _e283 = y;
                            let _e286 = z_3;
                            if (((_e281 == 0i) && (_e283 == 0i)) && (_e286 == 0i)) {
                                continue;
                            }
                            let _e289 = (*p_1);
                            let _e290 = x_3;
                            let _e291 = y;
                            let _e292 = z_3;
                            param_49 = (_e289 + vec3<i32>(_e290, _e291, _e292));
                            let _e295 = getVoxel_u0028_vi3_u003b((&param_49));
                            if ((_e295 & 255u) == 0u) {
                                continue;
                            }
                            let _e298 = x_3;
                            let _e300 = y;
                            let _e302 = z_3;
                            offset = vec3<f32>(f32(_e298), f32(_e300), f32(_e302));
                            let _e305 = offset;
                            let _e306 = x_3;
                            let _e307 = x_3;
                            let _e309 = y;
                            let _e310 = y;
                            let _e313 = z_3;
                            let _e314 = z_3;
                            let _e320 = n_3;
                            n_3 = (_e320 - (_e305 * inverseSqrt(f32((((_e306 * _e307) + (_e309 * _e310)) + (_e313 * _e314))))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e322 = z_3;
                            z_3 = (_e322 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e324 = y;
                    y = (_e324 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e326 = x_3;
            x_3 = (_e326 + 1i);
        }
    }
    let _e328 = n_3;
    if (length(_e328) < 0.1f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e331 = n_3;
    return normalize(_e331);
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

    let _e284 = tuning.waterWaveScale;
    scale = max(_e284, 0.001f);
    let _e286 = (*t_1);
    let _e288 = tuning.waterWaveSpeed;
    wt = ((_e286 * _e288) * 0.35f);
    let _e291 = (*p_2);
    let _e293 = (*p_2)[1u];
    let _e295 = wt;
    let _e299 = (*p_2)[0u];
    let _e301 = wt;
    q = (_e291 + (vec2<f32>(sin(((_e293 * 0.043f) + _e295)), sin(((_e299 * 0.037f) - (_e301 * 0.8f)))) * 6f));
    grad = vec2<f32>(0f, 0f);
    i_4 = 0i;
    loop {
        let _e308 = i_4;
        if (_e308 < 5i) {
            let _e310 = i_4;
            indexable_1 = array<f32, 5>(0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
            let _e312 = indexable_1[_e310];
            let _e313 = scale;
            f = (_e312 * _e313);
            let _e315 = i_4;
            indexable_2 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e317 = indexable_2[_e315];
            let _e318 = q;
            let _e320 = f;
            let _e322 = (*t_1);
            let _e323 = i_4;
            indexable_3 = array<f32, 5>(1f, 1.37f, 0.83f, 1.71f, 0.61f);
            let _e325 = indexable_3[_e323];
            let _e328 = tuning.waterWaveSpeed;
            phase_1 = ((dot(_e317, _e318) * _e320) + ((_e322 * _e325) * _e328));
            let _e331 = i_4;
            indexable_4 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e333 = indexable_4[_e331];
            let _e334 = i_4;
            indexable_5 = array<f32, 5>(1f, 0.62f, 0.38f, 0.24f, 0.15f);
            let _e336 = indexable_5[_e334];
            let _e337 = f;
            let _e339 = phase_1;
            let _e343 = grad;
            grad = (_e343 + (_e333 * ((_e336 * _e337) * cos(_e339))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e345 = i_4;
            i_4 = (_e345 + 1i);
        }
    }
    let _e348 = (*p_2)[0u];
    let _e351 = (*p_2)[1u];
    let _e354 = (*t_1);
    envelope = (0.45f + (0.55f * sin((((_e348 * 0.021f) + (_e351 * 0.017f)) + (_e354 * 0.11f)))));
    let _e360 = grad;
    let _e361 = envelope;
    return (_e360 * _e361);
}

fn applyWaterWaves_u0028_vf3_u003b_vi3_u003b(normal_3: ptr<function, vec3<f32>>, voxelPos_13: ptr<function, vec3<i32>>) -> vec3<f32> {
    var upness: f32;
    var grad_1: vec2<f32>;
    var param_50: vec2<f32>;
    var param_51: f32;

    let _e275 = tuning.waterWaveStrength;
    if (_e275 <= 0f) {
        let _e277 = (*normal_3);
        return _e277;
    }
    let _e279 = (*normal_3)[1u];
    upness = clamp(_e279, 0f, 1f);
    let _e281 = upness;
    if (_e281 <= 0f) {
        let _e283 = (*normal_3);
        return _e283;
    }
    let _e284 = (*voxelPos_13);
    param_50 = (vec2<f32>(_e284.xz) + vec2<f32>(0.5f, 0.5f));
    let _e289 = pc.time;
    param_51 = _e289;
    let _e290 = waterWaveGradient_u0028_vf2_u003b_f1_u003b((&param_50), (&param_51));
    grad_1 = _e290;
    let _e291 = (*normal_3);
    let _e293 = grad_1[0u];
    let _e296 = grad_1[1u];
    let _e300 = tuning.waterWaveStrength;
    let _e302 = upness;
    return normalize((_e291 + ((vec3<f32>(-(_e293), 0f, -(_e296)) * _e300) * _e302)));
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
        let _e275 = x_4;
        if (_e275 <= 2i) {
            y_1 = -2i;
            loop {
                let _e277 = y_1;
                if (_e277 <= 2i) {
                    z_4 = -2i;
                    loop {
                        let _e279 = z_4;
                        if (_e279 <= 2i) {
                            let _e281 = x_4;
                            let _e283 = y_1;
                            let _e286 = z_4;
                            if (((_e281 == 0i) && (_e283 == 0i)) && (_e286 == 0i)) {
                                continue;
                            }
                            let _e289 = x_4;
                            let _e290 = x_4;
                            let _e292 = y_1;
                            let _e293 = y_1;
                            let _e296 = z_4;
                            let _e297 = z_4;
                            d2_ = (((_e289 * _e290) + (_e292 * _e293)) + (_e296 * _e297));
                            let _e300 = d2_;
                            if (_e300 > 6i) {
                                continue;
                            }
                            let _e302 = (*p_3);
                            let _e303 = x_4;
                            let _e304 = y_1;
                            let _e305 = z_4;
                            param_52 = (_e302 + vec3<i32>(_e303, _e304, _e305));
                            let _e308 = getVoxel_u0028_vi3_u003b((&param_52));
                            if ((_e308 & 255u) == 0u) {
                                continue;
                            }
                            let _e311 = x_4;
                            let _e313 = y_1;
                            let _e315 = z_4;
                            let _e318 = d2_;
                            let _e322 = n_4;
                            n_4 = (_e322 - (vec3<f32>(f32(_e311), f32(_e313), f32(_e315)) / vec3(f32(_e318))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e324 = z_4;
                            z_4 = (_e324 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e326 = y_1;
                    y_1 = (_e326 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e328 = x_4;
            x_4 = (_e328 + 1i);
        }
    }
    let _e330 = n_4;
    if (length(_e330) < 0.001f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e333 = n_4;
    return normalize(_e333);
}

fn locustDensity_u0028_u1_u003b(type_38: ptr<function, u32>) -> f32 {
    var stage_2: f32;

    let _e270 = (*type_38);
    stage_2 = (f32((_e270 - 13u)) / 4f);
    let _e275 = tuning.locustDensityMin;
    let _e277 = tuning.locustDensityMax;
    let _e278 = stage_2;
    return clamp(mix(_e275, _e277, _e278), 0.02f, 0.98f);
}

fn trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b(voxelPos_14: ptr<function, vec3<i32>>, a: ptr<function, vec2<f32>>, b_1: ptr<function, vec2<f32>>, count_3: ptr<function, i32>) {
    var h0_: f32;
    var param_53: vec3<f32>;
    var h1_: f32;
    var param_54: vec3<f32>;
    var h2_: f32;
    var param_55: vec3<f32>;

    let _e279 = (*voxelPos_14)[0u];
    let _e282 = (*voxelPos_14)[2u];
    param_53 = vec3<f32>(f32(_e279), 7f, f32(_e282));
    let _e285 = hash_u0028_vf3_u003b((&param_53));
    h0_ = _e285;
    let _e287 = (*voxelPos_14)[0u];
    let _e290 = (*voxelPos_14)[2u];
    param_54 = vec3<f32>(f32(_e287), 19f, f32(_e290));
    let _e293 = hash_u0028_vf3_u003b((&param_54));
    h1_ = _e293;
    let _e295 = (*voxelPos_14)[0u];
    let _e298 = (*voxelPos_14)[2u];
    param_55 = vec3<f32>(f32(_e295), 53f, f32(_e298));
    let _e301 = hash_u0028_vf3_u003b((&param_55));
    h2_ = _e301;
    let _e302 = h2_;
    let _e304 = tuning.treeTrunkColumns;
    (*count_3) = (1i + i32((_e302 * f32(max(bitcast<i32>(_e304), 1i)))));
    let _e311 = (*count_3);
    (*count_3) = clamp(_e311, 1i, 2i);
    let _e313 = h0_;
    let _e316 = h1_;
    (*a) = vec2<f32>((0.3f + (_e313 * 0.4f)), (0.3f + (_e316 * 0.4f)));
    let _e320 = h1_;
    let _e323 = h0_;
    (*b_1) = vec2<f32>((0.3f + (_e320 * 0.4f)), (0.3f + (_e323 * 0.4f)));
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

    let _e285 = (*kind);
    if (_e285 == 1u) {
        let _e287 = (*cell_1);
        let _e292 = (*sub);
        p_4 = ((vec2<f32>(_e287.xz) + vec2(0.5f)) / vec2(f32(_e292)));
        let _e296 = (*voxelPos_15);
        param_56 = _e296;
        trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b((&param_56), (&param_57), (&param_58), (&param_59));
        let _e297 = param_57;
        a_1 = _e297;
        let _e298 = param_58;
        b_2 = _e298;
        let _e299 = param_59;
        count_4 = _e299;
        let _e301 = tuning.treeTrunkRadius;
        r_1 = max(_e301, 0.02f);
        let _e303 = p_4;
        let _e304 = a_1;
        let _e306 = p_4;
        let _e307 = a_1;
        let _e310 = r_1;
        let _e311 = r_1;
        if (dot((_e303 - _e304), (_e306 - _e307)) <= (_e310 * _e311)) {
            return true;
        }
        let _e314 = count_4;
        let _e315 = (_e314 > 1i);
        phi_1639_ = _e315;
        if _e315 {
            let _e316 = p_4;
            let _e317 = b_2;
            let _e319 = p_4;
            let _e320 = b_2;
            let _e323 = r_1;
            let _e324 = r_1;
            phi_1639_ = (dot((_e316 - _e317), (_e319 - _e320)) <= (_e323 * _e324));
        }
        let _e328 = phi_1639_;
        if _e328 {
            return true;
        }
        return false;
    }
    let _e329 = (*voxelPos_15);
    let _e330 = (*sub);
    let _e333 = (*cell_1);
    let _e336 = (*jitter);
    param_60 = (vec3<f32>(((_e329 * vec3(_e330)) + _e333)) + _e336);
    let _e338 = hash_u0028_vf3_u003b((&param_60));
    let _e339 = (*type_39);
    param_61 = _e339;
    let _e340 = locustDensity_u0028_u1_u003b((&param_61));
    return (_e338 < _e340);
}

fn intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b(ro: ptr<function, vec3<f32>>, rd: ptr<function, vec3<f32>>, boxMin: ptr<function, vec3<f32>>, boxMax: ptr<function, vec3<f32>>) -> vec2<f32> {
    var tMin: vec3<f32>;
    var tMax_2: vec3<f32>;
    var t1_: vec3<f32>;
    var t2_: vec3<f32>;
    var tNear: f32;
    var tFar: f32;

    let _e278 = (*boxMin);
    let _e279 = (*ro);
    let _e281 = (*rd);
    tMin = ((_e278 - _e279) / _e281);
    let _e283 = (*boxMax);
    let _e284 = (*ro);
    let _e286 = (*rd);
    tMax_2 = ((_e283 - _e284) / _e286);
    let _e288 = tMin;
    let _e289 = tMax_2;
    t1_ = min(_e288, _e289);
    let _e291 = tMin;
    let _e292 = tMax_2;
    t2_ = max(_e291, _e292);
    let _e295 = t1_[0u];
    let _e297 = t1_[1u];
    let _e300 = t1_[2u];
    tNear = max(max(_e295, _e297), _e300);
    let _e303 = t2_[0u];
    let _e305 = t2_[1u];
    let _e308 = t2_[2u];
    tFar = min(min(_e303, _e305), _e308);
    let _e310 = tNear;
    let _e311 = tFar;
    return vec2<f32>(_e310, _e311);
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
    let _e307 = (*entryNormal);
    (*subNormal) = _e307;
    (*subCell_2) = vec3<f32>(0f, 0f, 0f);
    let _e309 = tuning.locustSubdivision;
    sub_1 = clamp(bitcast<i32>(_e309), 1i, 8i);
    let _e312 = sub_1;
    cellSize = (1f / f32(_e312));
    let _e315 = (*voxelPos_16);
    boxMin_1 = vec3<f32>(_e315);
    let _e317 = boxMin_1;
    let _e319 = (*rayOrigin_2);
    param_62 = _e319;
    let _e320 = (*rayDir_2);
    param_63 = _e320;
    let _e321 = boxMin_1;
    param_64 = _e321;
    param_65 = (_e317 + vec3<f32>(1f, 1f, 1f));
    let _e322 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_62), (&param_63), (&param_64), (&param_65));
    span = _e322;
    let _e324 = span[0u];
    t_2 = max(_e324, 0f);
    let _e326 = t_2;
    let _e328 = span[1u];
    if (_e326 > _e328) {
        return false;
    }
    let _e330 = (*rayOrigin_2);
    let _e331 = (*rayDir_2);
    let _e332 = t_2;
    let _e336 = boxMin_1;
    let _e338 = sub_1;
    local_9 = (((_e330 + (_e331 * (_e332 + 0.0001f))) - _e336) * f32(_e338));
    let _e341 = local_9;
    let _e344 = sub_1;
    c_1 = clamp(vec3<i32>(floor(_e341)), vec3<i32>(0i, 0i, 0i), vec3((_e344 - 1i)));
    let _e348 = (*rayDir_2);
    stepDir_2 = vec3<i32>(sign(_e348));
    let _e352 = (*rayDir_2)[0u];
    if (_e352 == 0f) {
        local_10 = 1000000f;
    } else {
        let _e354 = cellSize;
        let _e356 = (*rayDir_2)[0u];
        local_10 = abs((_e354 / _e356));
    }
    let _e359 = local_10;
    let _e361 = (*rayDir_2)[1u];
    if (_e361 == 0f) {
        local_11 = 1000000f;
    } else {
        let _e363 = cellSize;
        let _e365 = (*rayDir_2)[1u];
        local_11 = abs((_e363 / _e365));
    }
    let _e368 = local_11;
    let _e370 = (*rayDir_2)[2u];
    if (_e370 == 0f) {
        local_12 = 1000000f;
    } else {
        let _e372 = cellSize;
        let _e374 = (*rayDir_2)[2u];
        local_12 = abs((_e372 / _e374));
    }
    let _e377 = local_12;
    tDelta_2 = vec3<f32>(_e359, _e368, _e377);
    let _e379 = local_9;
    let _e380 = c_1;
    fracPos_1 = (_e379 - vec3<f32>(_e380));
    let _e383 = t_2;
    let _e385 = stepDir_2[0u];
    if (_e385 > 0i) {
        let _e388 = fracPos_1[0u];
        let _e391 = tDelta_2[0u];
        local_13 = ((1f - _e388) * _e391);
    } else {
        let _e394 = fracPos_1[0u];
        let _e396 = tDelta_2[0u];
        local_13 = (_e394 * _e396);
    }
    let _e398 = local_13;
    let _e400 = stepDir_2[1u];
    if (_e400 > 0i) {
        let _e403 = fracPos_1[1u];
        let _e406 = tDelta_2[1u];
        local_14 = ((1f - _e403) * _e406);
    } else {
        let _e409 = fracPos_1[1u];
        let _e411 = tDelta_2[1u];
        local_14 = (_e409 * _e411);
    }
    let _e413 = local_14;
    let _e415 = stepDir_2[2u];
    if (_e415 > 0i) {
        let _e418 = fracPos_1[2u];
        let _e421 = tDelta_2[2u];
        local_15 = ((1f - _e418) * _e421);
    } else {
        let _e424 = fracPos_1[2u];
        let _e426 = tDelta_2[2u];
        local_15 = (_e424 * _e426);
    }
    let _e428 = local_15;
    tMax_3 = (vec3(_e383) + vec3<f32>(_e398, _e413, _e428));
    let _e432 = (*kind_1);
    if (_e432 == 0u) {
        let _e435 = pc.time;
        let _e437 = tuning.locustCrawlRate;
        local_16 = vec3((floor((_e435 * _e437)) * 1.7f));
    } else {
        local_16 = vec3<f32>(0f, 0f, 0f);
    }
    let _e442 = local_16;
    jitter_1 = _e442;
    i_5 = 0i;
    loop {
        let _e443 = i_5;
        let _e444 = sub_1;
        if (_e443 < (3i * _e444)) {
            let _e448 = c_1[0u];
            let _e449 = (_e448 < 0i);
            phi_1871_ = _e449;
            if !(_e449) {
                let _e452 = c_1[0u];
                let _e453 = sub_1;
                phi_1871_ = (_e452 >= _e453);
            }
            let _e456 = phi_1871_;
            phi_1878_ = _e456;
            if !(_e456) {
                let _e459 = c_1[1u];
                phi_1878_ = (_e459 < 0i);
            }
            let _e462 = phi_1878_;
            phi_1886_ = _e462;
            if !(_e462) {
                let _e465 = c_1[1u];
                let _e466 = sub_1;
                phi_1886_ = (_e465 >= _e466);
            }
            let _e469 = phi_1886_;
            phi_1893_ = _e469;
            if !(_e469) {
                let _e472 = c_1[2u];
                phi_1893_ = (_e472 < 0i);
            }
            let _e475 = phi_1893_;
            phi_1901_ = _e475;
            if !(_e475) {
                let _e478 = c_1[2u];
                let _e479 = sub_1;
                phi_1901_ = (_e478 >= _e479);
            }
            let _e482 = phi_1901_;
            if _e482 {
                return false;
            }
            let _e483 = (*kind_1);
            param_66 = _e483;
            let _e484 = (*type_40);
            param_67 = _e484;
            let _e485 = (*voxelPos_16);
            param_68 = _e485;
            let _e486 = c_1;
            param_69 = _e486;
            let _e487 = sub_1;
            param_70 = _e487;
            let _e488 = jitter_1;
            param_71 = _e488;
            let _e489 = subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b((&param_66), (&param_67), (&param_68), (&param_69), (&param_70), (&param_71));
            if _e489 {
                let _e490 = t_2;
                (*tHit_1) = _e490;
                let _e491 = c_1;
                (*subCell_2) = vec3<f32>(_e491);
                return true;
            }
            let _e494 = tMax_3[0u];
            let _e496 = tMax_3[1u];
            if (_e494 < _e496) {
                let _e499 = tMax_3[0u];
                let _e501 = tMax_3[2u];
                if (_e499 < _e501) {
                    let _e504 = stepDir_2[0u];
                    let _e506 = c_1[0u];
                    c_1[0u] = (_e506 + _e504);
                    let _e510 = tMax_3[0u];
                    t_2 = _e510;
                    let _e512 = tDelta_2[0u];
                    let _e514 = tMax_3[0u];
                    tMax_3[0u] = (_e514 + _e512);
                    let _e518 = stepDir_2[0u];
                    (*subNormal) = vec3<f32>(f32(-(_e518)), 0f, 0f);
                } else {
                    let _e523 = stepDir_2[2u];
                    let _e525 = c_1[2u];
                    c_1[2u] = (_e525 + _e523);
                    let _e529 = tMax_3[2u];
                    t_2 = _e529;
                    let _e531 = tDelta_2[2u];
                    let _e533 = tMax_3[2u];
                    tMax_3[2u] = (_e533 + _e531);
                    let _e537 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e537)));
                }
            } else {
                let _e542 = tMax_3[1u];
                let _e544 = tMax_3[2u];
                if (_e542 < _e544) {
                    let _e547 = stepDir_2[1u];
                    let _e549 = c_1[1u];
                    c_1[1u] = (_e549 + _e547);
                    let _e553 = tMax_3[1u];
                    t_2 = _e553;
                    let _e555 = tDelta_2[1u];
                    let _e557 = tMax_3[1u];
                    tMax_3[1u] = (_e557 + _e555);
                    let _e561 = stepDir_2[1u];
                    (*subNormal) = vec3<f32>(0f, f32(-(_e561)), 0f);
                } else {
                    let _e566 = stepDir_2[2u];
                    let _e568 = c_1[2u];
                    c_1[2u] = (_e568 + _e566);
                    let _e572 = tMax_3[2u];
                    t_2 = _e572;
                    let _e574 = tDelta_2[2u];
                    let _e576 = tMax_3[2u];
                    tMax_3[2u] = (_e576 + _e574);
                    let _e580 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e580)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e584 = i_5;
            i_5 = (_e584 + 1i);
        }
    }
    return false;
}

fn isLocustType_u0028_u1_u003b(type_41: ptr<function, u32>) -> bool {
    let _e269 = (*type_41);
    let _e271 = (*type_41);
    return ((_e269 >= 13u) && (_e271 <= 17u));
}

fn marchCeiling_u0028_() -> i32 {
    let _e269 = tuning.gridHeight;
    let _e272 = unnamed.maxOccupiedY;
    return min(bitcast<i32>(_e269), (bitcast<i32>(_e272) + 2i));
}

fn worldExtent_u0028_() -> vec3<f32> {
    let _e269 = tuning.gridWidth;
    let _e273 = tuning.gridHeight;
    let _e277 = tuning.gridDepth;
    return vec3<f32>(f32(bitcast<i32>(_e269)), f32(bitcast<i32>(_e273)), f32(bitcast<i32>(_e277)));
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
    let _e272 = worldExtent_u0028_();
    extent = _e272;
    let _e274 = (*p_5)[0u];
    let _e275 = thickness_1;
    let _e276 = (_e274 < _e275);
    phi_480_ = _e276;
    if !(_e276) {
        let _e279 = (*p_5)[0u];
        let _e281 = extent[0u];
        let _e282 = thickness_1;
        phi_480_ = (_e279 > (_e281 - _e282));
    }
    let _e286 = phi_480_;
    if _e286 {
        let _e287 = boundCount;
        boundCount = (_e287 + 1i);
    }
    let _e290 = (*p_5)[1u];
    let _e291 = thickness_1;
    let _e292 = (_e290 < _e291);
    phi_499_ = _e292;
    if !(_e292) {
        let _e295 = (*p_5)[1u];
        let _e297 = extent[1u];
        let _e298 = thickness_1;
        phi_499_ = (_e295 > (_e297 - _e298));
    }
    let _e302 = phi_499_;
    if _e302 {
        let _e303 = boundCount;
        boundCount = (_e303 + 1i);
    }
    let _e306 = (*p_5)[2u];
    let _e307 = thickness_1;
    let _e308 = (_e306 < _e307);
    phi_518_ = _e308;
    if !(_e308) {
        let _e311 = (*p_5)[2u];
        let _e313 = extent[2u];
        let _e314 = thickness_1;
        phi_518_ = (_e311 > (_e313 - _e314));
    }
    let _e318 = phi_518_;
    if _e318 {
        let _e319 = boundCount;
        boundCount = (_e319 + 1i);
    }
    let _e321 = boundCount;
    return (_e321 >= 2i);
}

fn rot_u0028_f1_u003b(a_2: ptr<function, f32>) -> mat2x2<f32> {
    var s: f32;
    var c_2: f32;

    let _e271 = (*a_2);
    s = sin(_e271);
    let _e273 = (*a_2);
    c_2 = cos(_e273);
    let _e275 = c_2;
    let _e276 = s;
    let _e278 = s;
    let _e279 = c_2;
    return mat2x2<f32>(vec2<f32>(_e275, -(_e276)), vec2<f32>(_e278, _e279));
}

fn applyCameraRotation_u0028_vf3_u003b(v: ptr<function, vec3<f32>>) -> vec3<f32> {
    var param_72: f32;
    var param_73: f32;

    let _e272 = pc.pitch;
    param_72 = _e272;
    let _e273 = rot_u0028_f1_u003b((&param_72));
    let _e274 = (*v);
    let _e276 = (_e274.yz * _e273);
    (*v)[1u] = _e276.x;
    (*v)[2u] = _e276.y;
    let _e282 = pc.yaw;
    param_73 = _e282;
    let _e283 = rot_u0028_f1_u003b((&param_73));
    let _e284 = (*v);
    let _e286 = (_e284.xz * _e283);
    (*v)[0u] = _e286.x;
    (*v)[2u] = _e286.y;
    let _e291 = (*v);
    return _e291;
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
    var phi_3164_: bool;
    var phi_3180_: bool;
    var phi_3408_: bool;
    var phi_3415_: bool;
    var phi_3423_: bool;
    var phi_3430_: bool;
    var phi_3440_: bool;
    var phi_3935_: bool;
    var phi_4254_: bool;
    var phi_4261_: bool;
    var phi_4270_: bool;
    var phi_4276_: bool;
    var phi_4285_: bool;
    var phi_4494_: bool;
    var phi_4536_: bool;
    var phi_4558_: bool;
    var phi_4580_: bool;
    var phi_4608_: bool;
    var phi_4630_: bool;
    var phi_4652_: bool;

    let _e484 = inUV_1;
    screenSpace = ((_e484 * 2f) - vec2(1f));
    let _e489 = screenSpace[1u];
    screenSpace[1u] = -(_e489);
    let _e493 = pc.aspectScaleX;
    let _e495 = screenSpace[0u];
    screenSpace[0u] = (_e495 * _e493);
    let _e499 = pc.aspectScaleY;
    let _e501 = screenSpace[1u];
    screenSpace[1u] = (_e501 * _e499);
    let _e505 = pc.camX;
    let _e507 = pc.camY;
    let _e509 = pc.camZ;
    baseOrigin = vec3<f32>(_e505, _e507, _e509);
    param_74 = vec3<f32>(0f, 0f, 1f);
    let _e511 = applyCameraRotation_u0028_vf3_u003b((&param_74));
    forward = _e511;
    param_75 = vec3<f32>(1f, 0f, 0f);
    let _e512 = applyCameraRotation_u0028_vf3_u003b((&param_75));
    right = _e512;
    param_76 = vec3<f32>(0f, 1f, 0f);
    let _e513 = applyCameraRotation_u0028_vf3_u003b((&param_76));
    up = _e513;
    let _e515 = pc.perspectiveBlend;
    t_3 = clamp(_e515, 0f, 1f);
    let _e517 = worldExtent_u0028_();
    cubeCenter = (_e517 * 0.5f);
    let _e519 = cubeCenter;
    let _e520 = baseOrigin;
    let _e522 = forward;
    viewDistance = max(1f, dot((_e519 - _e520), _e522));
    let _e525 = viewDistance;
    let _e527 = pc.fovDistance;
    orthoHalfSize = (_e525 / _e527);
    let _e530 = screenSpace[0u];
    let _e532 = screenSpace[1u];
    let _e534 = pc.fovDistance;
    let _e536 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e530, _e532, _e534), vec3(_e536));
    let _e539 = right;
    let _e541 = localDir[0u];
    let _e543 = up;
    let _e545 = localDir[1u];
    let _e548 = forward;
    let _e550 = localDir[2u];
    rayDir_3 = normalize((((_e539 * _e541) + (_e543 * _e545)) + (_e548 * _e550)));
    let _e554 = right;
    let _e556 = screenSpace[0u];
    let _e558 = up;
    let _e560 = screenSpace[1u];
    let _e563 = orthoHalfSize;
    let _e565 = t_3;
    originOffset = ((((_e554 * _e556) + (_e558 * _e560)) * _e563) * (1f - _e565));
    let _e568 = baseOrigin;
    let _e569 = originOffset;
    rayOrigin_3 = (_e568 + _e569);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e571 = worldExtent_u0028_();
    let _e572 = rayOrigin_3;
    param_77 = _e572;
    let _e573 = rayDir_3;
    param_78 = _e573;
    param_79 = vec3<f32>(0f, 0f, 0f);
    param_80 = _e571;
    let _e574 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_77), (&param_78), (&param_79), (&param_80));
    aabbHit = _e574;
    hitFrontBox = false;
    hitBackBox = false;
    let _e576 = aabbHit[0u];
    let _e578 = aabbHit[1u];
    let _e579 = (_e576 < _e578);
    phi_3164_ = _e579;
    if _e579 {
        let _e581 = aabbHit[1u];
        phi_3164_ = (_e581 > 0f);
    }
    let _e584 = phi_3164_;
    if _e584 {
        let _e586 = aabbHit[0u];
        let _e587 = (_e586 > 0f);
        phi_3180_ = _e587;
        if _e587 {
            let _e588 = rayOrigin_3;
            let _e589 = rayDir_3;
            let _e591 = aabbHit[0u];
            param_81 = (_e588 + (_e589 * _e591));
            let _e594 = isEdge_u0028_vf3_u003b((&param_81));
            phi_3180_ = _e594;
        }
        let _e596 = phi_3180_;
        if _e596 {
            hitFrontBox = true;
        }
        let _e597 = rayOrigin_3;
        let _e598 = rayDir_3;
        let _e600 = aabbHit[1u];
        param_82 = (_e597 + (_e598 * _e600));
        let _e603 = isEdge_u0028_vf3_u003b((&param_82));
        if _e603 {
            hitBackBox = true;
        }
    }
    let _e605 = pc.showCloudBlocks;
    if (_e605 != 0i) {
        let _e608 = tuning.gridHeight;
        local_17 = bitcast<i32>(_e608);
    } else {
        let _e610 = marchCeiling_u0028_();
        local_17 = _e610;
    }
    let _e611 = local_17;
    ceilingY_1 = _e611;
    let _e613 = tuning.gridWidth;
    let _e616 = ceilingY_1;
    let _e619 = tuning.gridDepth;
    let _e623 = rayOrigin_3;
    param_83 = _e623;
    let _e624 = rayDir_3;
    param_84 = _e624;
    param_85 = vec3<f32>(0f, 0f, 0f);
    param_86 = vec3<f32>(f32(bitcast<i32>(_e613)), f32(_e616), f32(bitcast<i32>(_e619)));
    let _e625 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_83), (&param_84), (&param_85), (&param_86));
    marchHit = _e625;
    let _e626 = rayOrigin_3;
    let _e627 = rayDir_3;
    let _e629 = marchHit[0u];
    currentPos = (_e626 + (_e627 * max(0f, _e629)));
    let _e634 = marchHit[0u];
    if (_e634 > 0f) {
        let _e636 = rayDir_3;
        let _e638 = currentPos;
        currentPos = (_e638 + (_e636 * 0.001f));
    }
    let _e640 = currentPos;
    voxelPos_17 = vec3<i32>(floor(_e640));
    let _e643 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e643));
    let _e647 = rayDir_3[0u];
    if (_e647 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e650 = rayDir_3[0u];
        local_18 = abs((1f / _e650));
    }
    let _e653 = local_18;
    let _e655 = rayDir_3[1u];
    if (_e655 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e658 = rayDir_3[1u];
        local_19 = abs((1f / _e658));
    }
    let _e661 = local_19;
    let _e663 = rayDir_3[2u];
    if (_e663 == 0f) {
        local_20 = 100000000f;
    } else {
        let _e666 = rayDir_3[2u];
        local_20 = abs((1f / _e666));
    }
    let _e669 = local_20;
    tDelta_3 = vec3<f32>(_e653, _e661, _e669);
    let _e672 = stepDir_3[0u];
    if (_e672 > 0i) {
        let _e675 = currentPos[0u];
        let _e679 = currentPos[0u];
        let _e682 = tDelta_3[0u];
        local_21 = (((floor(_e675) + 1f) - _e679) * _e682);
    } else {
        let _e685 = currentPos[0u];
        let _e687 = currentPos[0u];
        let _e691 = tDelta_3[0u];
        local_21 = ((_e685 - floor(_e687)) * _e691);
    }
    let _e693 = local_21;
    let _e695 = stepDir_3[1u];
    if (_e695 > 0i) {
        let _e698 = currentPos[1u];
        let _e702 = currentPos[1u];
        let _e705 = tDelta_3[1u];
        local_22 = (((floor(_e698) + 1f) - _e702) * _e705);
    } else {
        let _e708 = currentPos[1u];
        let _e710 = currentPos[1u];
        let _e714 = tDelta_3[1u];
        local_22 = ((_e708 - floor(_e710)) * _e714);
    }
    let _e716 = local_22;
    let _e718 = stepDir_3[2u];
    if (_e718 > 0i) {
        let _e721 = currentPos[2u];
        let _e725 = currentPos[2u];
        let _e728 = tDelta_3[2u];
        local_23 = (((floor(_e721) + 1f) - _e725) * _e728);
    } else {
        let _e731 = currentPos[2u];
        let _e733 = currentPos[2u];
        let _e737 = tDelta_3[2u];
        local_23 = ((_e731 - floor(_e733)) * _e737);
    }
    let _e739 = local_23;
    tMax_4 = vec3<f32>(_e693, _e716, _e739);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e742 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e742 * 1.5f));
    i_6 = 0i;
    loop {
        let _e745 = i_6;
        let _e747 = tuning.marchMaxSteps;
        if (_e745 < bitcast<i32>(_e747)) {
            let _e751 = voxelPos_17[0u];
            let _e752 = (_e751 < 0i);
            phi_3408_ = _e752;
            if !(_e752) {
                let _e755 = voxelPos_17[0u];
                let _e757 = tuning.gridWidth;
                phi_3408_ = (_e755 >= bitcast<i32>(_e757));
            }
            let _e761 = phi_3408_;
            phi_3415_ = _e761;
            if !(_e761) {
                let _e764 = voxelPos_17[1u];
                phi_3415_ = (_e764 < 0i);
            }
            let _e767 = phi_3415_;
            phi_3423_ = _e767;
            if !(_e767) {
                let _e770 = voxelPos_17[1u];
                let _e771 = ceilingY_1;
                phi_3423_ = (_e770 >= _e771);
            }
            let _e774 = phi_3423_;
            phi_3430_ = _e774;
            if !(_e774) {
                let _e777 = voxelPos_17[2u];
                phi_3430_ = (_e777 < 0i);
            }
            let _e780 = phi_3430_;
            phi_3440_ = _e780;
            if !(_e780) {
                let _e783 = voxelPos_17[2u];
                let _e785 = tuning.gridDepth;
                phi_3440_ = (_e783 >= bitcast<i32>(_e785));
            }
            let _e789 = phi_3440_;
            if _e789 {
                break;
            }
            let _e790 = voxelPos_17;
            param_87 = _e790;
            let _e791 = getVoxel_u0028_vi3_u003b((&param_87));
            rawVoxel_5 = _e791;
            let _e792 = rawVoxel_5;
            hitType = (_e792 & 255u);
            let _e795 = pc.showCloudBlocks;
            let _e797 = hitType;
            if ((_e795 != 0i) && (_e797 == 0u)) {
                let _e801 = voxelPos_17[0u];
                let _e803 = voxelPos_17[1u];
                let _e805 = tuning.gridWidth;
                let _e810 = voxelPos_17[2u];
                let _e812 = tuning.gridWidth;
                let _e816 = tuning.gridHeight;
                let _e823 = unnamed_2.cloudCells[bitcast<u32>(((_e801 + (_e803 * bitcast<i32>(_e805))) + ((_e810 * bitcast<i32>(_e812)) * bitcast<i32>(_e816))))];
                c_3 = _e823;
                let _e824 = c_3;
                if ((_e824 & 3u) != 0u) {
                    hitType = 200u;
                    let _e827 = c_3;
                    hitRawVoxel = _e827;
                    hit = true;
                    break;
                }
            }
            let _e828 = hitType;
            if (_e828 == 7u) {
                hitType = 0u;
            }
            let _e830 = hitType;
            if (_e830 != 0u) {
                let _e832 = hitType;
                if (_e832 == 6u) {
                    let _e834 = rawVoxel_5;
                    age_1 = ((_e834 >> bitcast<u32>(24i)) & 255u);
                    let _e838 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e838) / 100f), 0f, 1f));
                    let _e843 = inUV_1;
                    let _e845 = pc.time;
                    dither = fract((sin(dot((_e843 + vec2((_e845 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e853 = dither;
                    let _e854 = targetAlpha;
                    if (_e853 > _e854) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e856 = rawVoxel_5;
                        hitRawVoxel = _e856;
                        break;
                    }
                } else {
                    let _e857 = hitType;
                    param_88 = _e857;
                    let _e858 = isLocustType_u0028_u1_u003b((&param_88));
                    let _e859 = hitType;
                    if (_e858 || (_e859 == 18u)) {
                        let _e862 = hitType;
                        kind_2 = select(0u, 1u, (_e862 == 18u));
                        let _e865 = voxelPos_17;
                        param_89 = _e865;
                        let _e866 = rayOrigin_3;
                        param_90 = _e866;
                        let _e867 = rayDir_3;
                        param_91 = _e867;
                        let _e868 = kind_2;
                        param_92 = _e868;
                        let _e869 = hitType;
                        param_93 = _e869;
                        let _e870 = normal_4;
                        param_94 = _e870;
                        let _e871 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_89), (&param_90), (&param_91), (&param_92), (&param_93), (&param_94), (&param_95), (&param_96), (&param_97));
                        let _e872 = param_95;
                        subT = _e872;
                        let _e873 = param_96;
                        subNormal_1 = _e873;
                        let _e874 = param_97;
                        subCell_3 = _e874;
                        if _e871 {
                            hit = true;
                            let _e875 = rawVoxel_5;
                            hitRawVoxel = _e875;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e876 = rawVoxel_5;
                        hitRawVoxel = _e876;
                        break;
                    }
                }
            }
            let _e878 = tMax_4[0u];
            let _e880 = tMax_4[1u];
            if (_e878 < _e880) {
                let _e883 = tMax_4[0u];
                let _e885 = tMax_4[2u];
                if (_e883 < _e885) {
                    let _e888 = stepDir_3[0u];
                    let _e890 = voxelPos_17[0u];
                    voxelPos_17[0u] = (_e890 + _e888);
                    let _e894 = tDelta_3[0u];
                    let _e896 = tMax_4[0u];
                    tMax_4[0u] = (_e896 + _e894);
                    let _e900 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e900)), 0f, 0f);
                } else {
                    let _e905 = stepDir_3[2u];
                    let _e907 = voxelPos_17[2u];
                    voxelPos_17[2u] = (_e907 + _e905);
                    let _e911 = tDelta_3[2u];
                    let _e913 = tMax_4[2u];
                    tMax_4[2u] = (_e913 + _e911);
                    let _e917 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e917)));
                }
            } else {
                let _e922 = tMax_4[1u];
                let _e924 = tMax_4[2u];
                if (_e922 < _e924) {
                    let _e927 = stepDir_3[1u];
                    let _e929 = voxelPos_17[1u];
                    voxelPos_17[1u] = (_e929 + _e927);
                    let _e933 = tDelta_3[1u];
                    let _e935 = tMax_4[1u];
                    tMax_4[1u] = (_e935 + _e933);
                    let _e939 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e939)), 0f);
                } else {
                    let _e944 = stepDir_3[2u];
                    let _e946 = voxelPos_17[2u];
                    voxelPos_17[2u] = (_e946 + _e944);
                    let _e950 = tDelta_3[2u];
                    let _e952 = tMax_4[2u];
                    tMax_4[2u] = (_e952 + _e950);
                    let _e956 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e956)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e960 = i_6;
            i_6 = (_e960 + 1i);
        }
    }
    let _e962 = hit;
    if _e962 {
        let _e963 = normal_4;
        if (length(_e963) < 0.1f) {
            let _e966 = rayDir_3;
            normal_4 = -(_e966);
        }
        let _e968 = normal_4;
        ddaNormal_1 = _e968;
        let _e969 = hitType;
        if (_e969 == 2u) {
            let _e971 = voxelPos_17;
            param_98 = _e971;
            let _e972 = getWaterNormal_u0028_vi3_u003b((&param_98));
            param_99 = _e972;
            let _e973 = voxelPos_17;
            param_100 = _e973;
            let _e974 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_99), (&param_100));
            normal_4 = _e974;
        } else {
            let _e975 = hitType;
            param_101 = _e975;
            let _e976 = isLocustType_u0028_u1_u003b((&param_101));
            let _e977 = hitType;
            if (_e976 || (_e977 == 18u)) {
                let _e980 = subNormal_1;
                normal_4 = _e980;
            } else {
                let _e981 = voxelPos_17;
                param_102 = _e981;
                let _e982 = getSmoothNormal_u0028_vi3_u003b((&param_102));
                normal_4 = _e982;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e983 = normal_4;
        let _e984 = sunDir_2;
        diffuse_1 = max(dot(_e983, _e984), 0f);
        let _e987 = voxelPos_17;
        param_103 = _e987;
        let _e988 = ddaNormal_1;
        param_104 = _e988;
        let _e989 = sunDir_2;
        param_105 = _e989;
        let _e990 = ceilingY_1;
        param_106 = _e990;
        let _e991 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_103), (&param_104), (&param_105), (&param_106));
        shadow_1 = _e991;
        let _e992 = ambientColor;
        let _e993 = sunColor_1;
        let _e994 = diffuse_1;
        let _e996 = shadow_1;
        baseLighting_10 = (_e992 + ((_e993 * _e994) * _e996));
        let _e999 = baseLighting_10;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e999);
        let _e1001 = hitType;
        if (_e1001 == 200u) {
            calm = vec3<f32>(0.35f, 0.65f, 1f);
            rain = vec3<f32>(1f, 0.55f, 0.25f);
            let _e1003 = calm;
            let _e1004 = rain;
            let _e1005 = hitRawVoxel;
            let _e1011 = baseLighting_10;
            finalVoxelColor = (mix(_e1003, _e1004, vec3(select(0f, 1f, ((_e1005 & 3u) == 2u)))) * _e1011);
        }
        let _e1013 = hitType;
        switch bitcast<i32>(_e1013) {
            case 1: {
                let _e1015 = hitRawVoxel;
                param_107 = _e1015;
                let _e1016 = baseLighting_10;
                param_108 = _e1016;
                let _e1017 = renderSand_u0028_u1_u003b_vf3_u003b((&param_107), (&param_108));
                finalVoxelColor = _e1017;
                break;
            }
            case 2: {
                let _e1018 = voxelPos_17;
                param_109 = _e1018;
                let _e1019 = normal_4;
                param_110 = _e1019;
                let _e1020 = rayOrigin_3;
                param_111 = _e1020;
                let _e1021 = sunDir_2;
                param_112 = _e1021;
                let _e1022 = sunColor_1;
                param_113 = _e1022;
                let _e1023 = shadow_1;
                param_114 = _e1023;
                let _e1024 = baseLighting_10;
                param_115 = _e1024;
                let _e1025 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_109), (&param_110), (&param_111), (&param_112), (&param_113), (&param_114), (&param_115));
                finalVoxelColor = _e1025;
                break;
            }
            case 3: {
                let _e1026 = voxelPos_17;
                param_116 = _e1026;
                let _e1027 = baseLighting_10;
                param_117 = _e1027;
                let _e1028 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_116), (&param_117));
                finalVoxelColor = _e1028;
                break;
            }
            case 4: {
                let _e1029 = hitRawVoxel;
                param_118 = _e1029;
                let _e1030 = voxelPos_17;
                param_119 = _e1030;
                let _e1031 = ddaNormal_1;
                param_120 = _e1031;
                let _e1032 = baseLighting_10;
                param_121 = _e1032;
                let _e1033 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_118), (&param_119), (&param_120), (&param_121));
                finalVoxelColor = _e1033;
                break;
            }
            case 5: {
                let _e1034 = hitRawVoxel;
                param_122 = _e1034;
                let _e1035 = voxelPos_17;
                param_123 = _e1035;
                let _e1036 = renderFire_u0028_u1_u003b_vi3_u003b((&param_122), (&param_123));
                finalVoxelColor = _e1036;
                break;
            }
            case 6: {
                let _e1037 = voxelPos_17;
                param_124 = _e1037;
                let _e1038 = baseLighting_10;
                param_125 = _e1038;
                let _e1039 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_124), (&param_125));
                finalVoxelColor = _e1039;
                break;
            }
            case 9, 10, 11, 8: {
                let _e1040 = hitRawVoxel;
                param_126 = _e1040;
                let _e1041 = voxelPos_17;
                param_127 = _e1041;
                let _e1042 = renderLava_u0028_u1_u003b_vi3_u003b((&param_126), (&param_127));
                finalVoxelColor = _e1042;
                break;
            }
            case 12: {
                let _e1043 = voxelPos_17;
                param_128 = _e1043;
                let _e1044 = baseLighting_10;
                param_129 = _e1044;
                let _e1045 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_128), (&param_129));
                finalVoxelColor = _e1045;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e1046 = voxelPos_17;
                param_130 = _e1046;
                let _e1047 = subCell_3;
                param_131 = _e1047;
                let _e1048 = baseLighting_10;
                param_132 = _e1048;
                let _e1049 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_130), (&param_131), (&param_132));
                finalVoxelColor = _e1049;
                break;
            }
            case 18: {
                let _e1050 = voxelPos_17;
                param_133 = _e1050;
                let _e1051 = subCell_3;
                param_134 = _e1051;
                let _e1052 = baseLighting_10;
                param_135 = _e1052;
                let _e1053 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_133), (&param_134), (&param_135));
                finalVoxelColor = _e1053;
                break;
            }
            case 19: {
                let _e1054 = hitRawVoxel;
                param_136 = _e1054;
                let _e1055 = voxelPos_17;
                param_137 = _e1055;
                let _e1056 = baseLighting_10;
                param_138 = _e1056;
                let _e1057 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_136), (&param_137), (&param_138));
                finalVoxelColor = _e1057;
                break;
            }
            case 20: {
                let _e1058 = voxelPos_17;
                param_139 = _e1058;
                let _e1059 = baseLighting_10;
                param_140 = _e1059;
                let _e1060 = renderAsh_u0028_vi3_u003b_vf3_u003b((&param_139), (&param_140));
                finalVoxelColor = _e1060;
                break;
            }
            default: {
                break;
            }
        }
        let _e1061 = finalVoxelColor;
        param_141 = _e1061;
        let _e1062 = voxelPos_17;
        param_142 = _e1062;
        let _e1063 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_141), (&param_142));
        finalVoxelColor = _e1063;
        let _e1064 = hitType;
        param_143 = _e1064;
        let _e1065 = isLocustType_u0028_u1_u003b((&param_143));
        let _e1066 = hitType;
        if (_e1065 || (_e1066 == 18u)) {
            let _e1069 = subT;
            local_24 = _e1069;
        } else {
            let _e1070 = voxelPos_17;
            let _e1073 = rayOrigin_3;
            local_24 = length(((vec3<f32>(_e1070) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e1073));
        }
        let _e1076 = local_24;
        distanceTraveled = _e1076;
        let _e1077 = distanceTraveled;
        let _e1078 = MAX_VISIBILITY;
        let _e1082 = finalVoxelColor;
        finalVoxelColor = (_e1082 * mix(1f, 0f, clamp((_e1077 / _e1078), 0f, 1f)));
        let _e1084 = distanceTraveled;
        finalDist = _e1084;
        let _e1085 = finalVoxelColor;
        finalColor = vec4<f32>(_e1085.x, _e1085.y, _e1085.z, 1f);
    } else {
        let _e1090 = hitBackBox;
        if _e1090 {
            let _e1092 = aabbHit[1u];
            finalDist = _e1092;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1094 = unnamed.blackHoleCount;
    if (_e1094 > 0u) {
        seenHoles = 0u;
        i_7 = 0i;
        loop {
            let _e1096 = i_7;
            let _e1097 = (_e1096 < 8i);
            phi_3935_ = _e1097;
            if _e1097 {
                let _e1098 = seenHoles;
                let _e1100 = unnamed.blackHoleCount;
                phi_3935_ = (_e1098 < _e1100);
            }
            let _e1103 = phi_3935_;
            if _e1103 {
                let _e1104 = i_7;
                let _e1107 = unnamed.blackHoles[_e1104];
                code_2 = _e1107;
                let _e1108 = code_2;
                if (_e1108 == 0u) {
                    continue;
                }
                let _e1110 = seenHoles;
                seenHoles = (_e1110 + bitcast<u32>(1i));
                let _e1113 = code_2;
                if ((_e1113 & 1073741824u) != 0u) {
                    let _e1117 = tuning.purgeLevel;
                    let _e1119 = i_7;
                    let _e1122 = unnamed.blackHoleMass[_e1119];
                    let _e1125 = tuning.purgeMass;
                    local_25 = u32((f32(_e1117) * clamp((f32(_e1122) / f32(max(_e1125, 1u))), 0f, 1f)));
                } else {
                    let _e1132 = i_7;
                    let _e1135 = unnamed.blackHoleMass[_e1132];
                    param_144 = _e1135;
                    let _e1136 = bhLevel_u0028_u1_u003b((&param_144));
                    local_25 = _e1136;
                }
                let _e1137 = local_25;
                bodyLevel = _e1137;
                let _e1138 = bodyLevel;
                param_145 = _e1138;
                let _e1139 = bhBodyRadius_u0028_u1_u003b((&param_145));
                bodyRadius = _e1139;
                let _e1140 = code_2;
                param_146 = _e1140;
                let _e1141 = bhDecode_u0028_u1_u003b((&param_146));
                center = (vec3<f32>(_e1141) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1144 = rayOrigin_3;
                let _e1145 = center;
                oc = (_e1144 - _e1145);
                let _e1147 = oc;
                let _e1148 = rayDir_3;
                b_3 = dot(_e1147, _e1148);
                let _e1150 = oc;
                let _e1151 = oc;
                let _e1153 = bodyRadius;
                let _e1154 = bodyRadius;
                c_4 = (dot(_e1150, _e1151) - (_e1153 * _e1154));
                let _e1157 = b_3;
                let _e1158 = b_3;
                let _e1160 = c_4;
                disc = ((_e1157 * _e1158) - _e1160);
                let _e1162 = disc;
                if (_e1162 <= 0f) {
                    continue;
                }
                let _e1164 = disc;
                sq = sqrt(_e1164);
                let _e1166 = b_3;
                let _e1168 = sq;
                tNear_1 = (-(_e1166) - _e1168);
                let _e1170 = b_3;
                let _e1172 = sq;
                tFar_1 = (-(_e1170) + _e1172);
                let _e1174 = tFar_1;
                if (_e1174 <= 0f) {
                    continue;
                }
                let _e1176 = tNear_1;
                bodyDist = max(0f, _e1176);
                let _e1178 = bodyDist;
                let _e1179 = finalDist;
                if (_e1178 < _e1179) {
                    let _e1181 = rayOrigin_3;
                    let _e1182 = rayDir_3;
                    let _e1183 = bodyDist;
                    let _e1186 = center;
                    surfaceNormal = normalize(((_e1181 + (_e1182 * _e1183)) - _e1186));
                    let _e1189 = surfaceNormal;
                    param_147 = _e1189;
                    let _e1190 = rayDir_3;
                    param_148 = _e1190;
                    let _e1191 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_147), (&param_148));
                    bodyColor = _e1191;
                    let _e1192 = bodyDist;
                    let _e1193 = MAX_VISIBILITY;
                    let _e1197 = bodyColor;
                    bodyColor = (_e1197 * mix(1f, 0f, clamp((_e1192 / _e1193), 0f, 1f)));
                    let _e1199 = bodyColor;
                    finalColor = vec4<f32>(_e1199.x, _e1199.y, _e1199.z, 1f);
                    let _e1204 = bodyDist;
                    finalDist = _e1204;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1205 = i_7;
                i_7 = (_e1205 + 1i);
            }
        }
    }
    let _e1208 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1208), 0f, 1f);
    let _e1211 = charge;
    cloudGreyness = _e1211;
    let _e1213 = unnamed.rainPhase;
    if (_e1213 == 1u) {
        let _e1216 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1216);
        let _e1218 = charge;
        let _e1220 = pc.time;
        let _e1221 = crossedTime;
        let _e1224 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1218, clamp(((_e1220 - _e1221) / _e1224), 0f, 1f));
    } else {
        let _e1229 = unnamed.rainPhase;
        if (_e1229 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1232 = tuning.cloudMaxAlpha;
    if (_e1232 > 0.002f) {
        let _e1235 = tuning.cloudHeightLevels;
        let _e1238 = tuning.cloudVoxelSize;
        slabMax = (max(_e1235, 1f) * max(_e1238, 0.5f));
        let _e1242 = unnamed.cloudMaxY;
        let _e1244 = slabMax;
        bandHi = (f32(_e1242) + _e1244);
        let _e1247 = unnamed.cloudMinY;
        let _e1250 = unnamed.cloudMaxY;
        let _e1252 = slabMax;
        let _e1256 = tuning.cloudVoxelSize;
        bandLo = (max(f32(_e1247), (f32(_e1250) - _e1252)) - max(_e1256, 1f));
        let _e1260 = unnamed.cloudMinY;
        let _e1262 = unnamed.cloudMaxY;
        if (_e1260 > _e1262) {
            local_26 = vec2<f32>(1f, -1f);
        } else {
            let _e1264 = bandLo;
            let _e1266 = worldExtent_u0028_();
            let _e1268 = bandHi;
            let _e1269 = worldExtent_u0028_();
            let _e1272 = rayOrigin_3;
            param_149 = _e1272;
            let _e1273 = rayDir_3;
            param_150 = _e1273;
            param_151 = vec3<f32>(0f, _e1264, 0f);
            param_152 = vec3<f32>(_e1266.x, _e1268, _e1269.z);
            let _e1274 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_149), (&param_150), (&param_151), (&param_152));
            local_26 = _e1274;
        }
        let _e1275 = local_26;
        cloudClip = _e1275;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1277 = cloudClip[0u];
        nearT = max(_e1277, 0f);
        let _e1280 = cloudClip[1u];
        let _e1281 = finalDist;
        farT = min(_e1280, _e1281);
        let _e1283 = nearT;
        let _e1284 = farT;
        if (_e1283 < _e1284) {
            let _e1286 = rayOrigin_3;
            param_153 = _e1286;
            let _e1287 = rayDir_3;
            param_154 = _e1287;
            let _e1288 = nearT;
            param_155 = _e1288;
            let _e1289 = farT;
            param_156 = _e1289;
            let _e1290 = cloudSunDir;
            param_157 = _e1290;
            let _e1291 = cloudGreyness;
            param_158 = _e1291;
            let _e1292 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b((&param_153), (&param_154), (&param_155), (&param_156), (&param_157), (&param_158), (&param_159), (&param_160), (&param_161));
            let _e1293 = param_159;
            cloudTHit = _e1293;
            let _e1294 = param_160;
            cloudColor = _e1294;
            let _e1295 = param_161;
            cloudDensity = _e1295;
            if _e1292 {
                let _e1296 = cloudTHit;
                if (_e1296 > 0f) {
                    let _e1298 = cloudTHit;
                    bestT = _e1298;
                    let _e1299 = cloudColor;
                    bestColor = _e1299;
                    let _e1301 = tuning.cloudMinAlpha;
                    let _e1303 = tuning.cloudMaxAlpha;
                    let _e1304 = cloudDensity;
                    bestAlpha = clamp(mix(_e1301, _e1303, _e1304), 0f, 0.95f);
                    foundCloud = true;
                }
            }
        }
        let _e1307 = foundCloud;
        let _e1308 = bestT;
        let _e1309 = finalDist;
        if (_e1307 && (_e1308 < _e1309)) {
            let _e1312 = finalColor;
            let _e1314 = bestColor;
            let _e1315 = bestAlpha;
            let _e1317 = mix(_e1312.xyz, _e1314, vec3(_e1315));
            finalColor[0u] = _e1317.x;
            finalColor[1u] = _e1317.y;
            finalColor[2u] = _e1317.z;
        }
    }
    let _e1325 = pc.spawnX;
    let _e1326 = (_e1325 >= 0i);
    phi_4254_ = _e1326;
    if _e1326 {
        let _e1328 = pc.spawnX;
        let _e1330 = tuning.gridWidth;
        phi_4254_ = (_e1328 < bitcast<i32>(_e1330));
    }
    let _e1334 = phi_4254_;
    phi_4261_ = _e1334;
    if _e1334 {
        let _e1336 = pc.spawnY;
        phi_4261_ = (_e1336 >= 0i);
    }
    let _e1339 = phi_4261_;
    phi_4270_ = _e1339;
    if _e1339 {
        let _e1341 = pc.spawnY;
        let _e1343 = tuning.gridHeight;
        phi_4270_ = (_e1341 < bitcast<i32>(_e1343));
    }
    let _e1347 = phi_4270_;
    phi_4276_ = _e1347;
    if _e1347 {
        let _e1349 = pc.spawnZ;
        phi_4276_ = (_e1349 >= 0i);
    }
    let _e1352 = phi_4276_;
    phi_4285_ = _e1352;
    if _e1352 {
        let _e1354 = pc.spawnZ;
        let _e1356 = tuning.gridDepth;
        phi_4285_ = (_e1354 < bitcast<i32>(_e1356));
    }
    let _e1360 = phi_4285_;
    if _e1360 {
        let _e1362 = pc.spawnSize;
        halfDistMin = (_e1362 / 2i);
        let _e1365 = pc.spawnSize;
        halfDistMax = ((_e1365 - 1i) / 2i);
        let _e1369 = pc.spawnX;
        let _e1370 = halfDistMin;
        let _e1374 = pc.spawnY;
        let _e1375 = halfDistMin;
        let _e1379 = pc.spawnZ;
        let _e1380 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1369 - _e1370)), f32((_e1374 - _e1375)), f32((_e1379 - _e1380)));
        let _e1385 = pc.spawnX;
        let _e1386 = halfDistMax;
        let _e1391 = pc.spawnY;
        let _e1392 = halfDistMax;
        let _e1397 = pc.spawnZ;
        let _e1398 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1385 + _e1386) + 1i)), f32(((_e1391 + _e1392) + 1i)), f32(((_e1397 + _e1398) + 1i)));
        let _e1404 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1407 = indexable_6[clamp(_e1404, 0i, 19i)];
        cursorColor = _e1407;
        let _e1409 = pc.spawnShape;
        if (_e1409 == 1i) {
            let _e1411 = boxMin_2;
            let _e1412 = boxMax_1;
            sphereCenter = ((_e1411 + _e1412) * 0.5f);
            let _e1416 = pc.spawnSize;
            sphereRadius = (f32(_e1416) * 0.5f);
            let _e1419 = rayOrigin_3;
            let _e1420 = sphereCenter;
            oc_1 = (_e1419 - _e1420);
            let _e1422 = oc_1;
            let _e1423 = rayDir_3;
            b_4 = dot(_e1422, _e1423);
            let _e1425 = oc_1;
            let _e1426 = oc_1;
            let _e1428 = sphereRadius;
            let _e1429 = sphereRadius;
            c_5 = (dot(_e1425, _e1426) - (_e1428 * _e1429));
            let _e1432 = b_4;
            let _e1433 = b_4;
            let _e1435 = c_5;
            disc_1 = ((_e1432 * _e1433) - _e1435);
            let _e1437 = disc_1;
            if (_e1437 > 0f) {
                let _e1439 = disc_1;
                sq_1 = sqrt(_e1439);
                let _e1441 = b_4;
                let _e1443 = sq_1;
                tNear_2 = (-(_e1441) - _e1443);
                let _e1445 = b_4;
                let _e1447 = sq_1;
                tFar_2 = (-(_e1445) + _e1447);
                let _e1449 = tFar_2;
                if (_e1449 > 0f) {
                    let _e1451 = tNear_2;
                    inside = (_e1451 <= 0f);
                    let _e1453 = inside;
                    let _e1454 = tFar_2;
                    let _e1455 = tNear_2;
                    cursorDist = select(_e1455, _e1454, _e1453);
                    let _e1457 = rayOrigin_3;
                    let _e1458 = rayDir_3;
                    let _e1459 = cursorDist;
                    let _e1462 = sphereCenter;
                    shellNormal = normalize(((_e1457 + (_e1458 * _e1459)) - _e1462));
                    let _e1465 = shellNormal;
                    let _e1466 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1465, _e1466)));
                    let _e1470 = rim_1;
                    let _e1473 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1470)) * select(1f, 0.35f, _e1473));
                    let _e1476 = cursorDist;
                    let _e1477 = finalDist;
                    if (_e1476 < _e1477) {
                        let _e1479 = finalColor;
                        let _e1481 = cursorColor;
                        let _e1482 = alpha;
                        let _e1484 = mix(_e1479.xyz, _e1481, vec3(_e1482));
                        finalColor[0u] = _e1484.x;
                        finalColor[1u] = _e1484.y;
                        finalColor[2u] = _e1484.z;
                    }
                }
            }
        } else {
            let _e1491 = rayOrigin_3;
            param_162 = _e1491;
            let _e1492 = rayDir_3;
            param_163 = _e1492;
            let _e1493 = boxMin_2;
            param_164 = _e1493;
            let _e1494 = boxMax_1;
            param_165 = _e1494;
            let _e1495 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_162), (&param_163), (&param_164), (&param_165));
            cursorHit = _e1495;
            let _e1497 = cursorHit[0u];
            let _e1499 = cursorHit[1u];
            let _e1500 = (_e1497 < _e1499);
            phi_4494_ = _e1500;
            if _e1500 {
                let _e1502 = cursorHit[1u];
                phi_4494_ = (_e1502 > 0f);
            }
            let _e1505 = phi_4494_;
            if _e1505 {
                let _e1507 = cursorHit[0u];
                distFront = max(0f, _e1507);
                let _e1510 = cursorHit[1u];
                distBack = _e1510;
                let _e1511 = rayOrigin_3;
                let _e1512 = rayDir_3;
                let _e1513 = distFront;
                hitPosFront = (_e1511 + (_e1512 * _e1513));
                let _e1516 = rayOrigin_3;
                let _e1517 = rayDir_3;
                let _e1518 = distBack;
                hitPosBack = (_e1516 + (_e1517 * _e1518));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1522 = hitPosFront[0u];
                let _e1524 = boxMin_2[0u];
                let _e1525 = e;
                let _e1527 = (_e1522 < (_e1524 + _e1525));
                phi_4536_ = _e1527;
                if !(_e1527) {
                    let _e1530 = hitPosFront[0u];
                    let _e1532 = boxMax_1[0u];
                    let _e1533 = e;
                    phi_4536_ = (_e1530 > (_e1532 - _e1533));
                }
                let _e1537 = phi_4536_;
                if _e1537 {
                    let _e1538 = edgesFront;
                    edgesFront = (_e1538 + 1i);
                }
                let _e1541 = hitPosFront[1u];
                let _e1543 = boxMin_2[1u];
                let _e1544 = e;
                let _e1546 = (_e1541 < (_e1543 + _e1544));
                phi_4558_ = _e1546;
                if !(_e1546) {
                    let _e1549 = hitPosFront[1u];
                    let _e1551 = boxMax_1[1u];
                    let _e1552 = e;
                    phi_4558_ = (_e1549 > (_e1551 - _e1552));
                }
                let _e1556 = phi_4558_;
                if _e1556 {
                    let _e1557 = edgesFront;
                    edgesFront = (_e1557 + 1i);
                }
                let _e1560 = hitPosFront[2u];
                let _e1562 = boxMin_2[2u];
                let _e1563 = e;
                let _e1565 = (_e1560 < (_e1562 + _e1563));
                phi_4580_ = _e1565;
                if !(_e1565) {
                    let _e1568 = hitPosFront[2u];
                    let _e1570 = boxMax_1[2u];
                    let _e1571 = e;
                    phi_4580_ = (_e1568 > (_e1570 - _e1571));
                }
                let _e1575 = phi_4580_;
                if _e1575 {
                    let _e1576 = edgesFront;
                    edgesFront = (_e1576 + 1i);
                }
                let _e1578 = edgesFront;
                if (_e1578 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1581 = hitPosBack[0u];
                let _e1583 = boxMin_2[0u];
                let _e1584 = e;
                let _e1586 = (_e1581 < (_e1583 + _e1584));
                phi_4608_ = _e1586;
                if !(_e1586) {
                    let _e1589 = hitPosBack[0u];
                    let _e1591 = boxMax_1[0u];
                    let _e1592 = e;
                    phi_4608_ = (_e1589 > (_e1591 - _e1592));
                }
                let _e1596 = phi_4608_;
                if _e1596 {
                    let _e1597 = edgesBack;
                    edgesBack = (_e1597 + 1i);
                }
                let _e1600 = hitPosBack[1u];
                let _e1602 = boxMin_2[1u];
                let _e1603 = e;
                let _e1605 = (_e1600 < (_e1602 + _e1603));
                phi_4630_ = _e1605;
                if !(_e1605) {
                    let _e1608 = hitPosBack[1u];
                    let _e1610 = boxMax_1[1u];
                    let _e1611 = e;
                    phi_4630_ = (_e1608 > (_e1610 - _e1611));
                }
                let _e1615 = phi_4630_;
                if _e1615 {
                    let _e1616 = edgesBack;
                    edgesBack = (_e1616 + 1i);
                }
                let _e1619 = hitPosBack[2u];
                let _e1621 = boxMin_2[2u];
                let _e1622 = e;
                let _e1624 = (_e1619 < (_e1621 + _e1622));
                phi_4652_ = _e1624;
                if !(_e1624) {
                    let _e1627 = hitPosBack[2u];
                    let _e1629 = boxMax_1[2u];
                    let _e1630 = e;
                    phi_4652_ = (_e1627 > (_e1629 - _e1630));
                }
                let _e1634 = phi_4652_;
                if _e1634 {
                    let _e1635 = edgesBack;
                    edgesBack = (_e1635 + 1i);
                }
                let _e1637 = edgesBack;
                if (_e1637 >= 2i) {
                    onBackEdge = true;
                }
                let _e1639 = onFrontEdge;
                let _e1640 = distFront;
                let _e1641 = finalDist;
                if (_e1639 && (_e1640 < _e1641)) {
                    let _e1644 = finalColor;
                    let _e1646 = cursorColor;
                    let _e1648 = mix(_e1644.xyz, _e1646, vec3(0.9f));
                    finalColor[0u] = _e1648.x;
                    finalColor[1u] = _e1648.y;
                    finalColor[2u] = _e1648.z;
                } else {
                    let _e1655 = onBackEdge;
                    let _e1656 = distBack;
                    let _e1657 = finalDist;
                    if (_e1655 && (_e1656 < _e1657)) {
                        let _e1660 = finalColor;
                        let _e1662 = cursorColor;
                        let _e1664 = mix(_e1660.xyz, _e1662, vec3(0.2f));
                        finalColor[0u] = _e1664.x;
                        finalColor[1u] = _e1664.y;
                        finalColor[2u] = _e1664.z;
                    } else {
                        let _e1671 = distFront;
                        let _e1672 = finalDist;
                        if (_e1671 < _e1672) {
                            let _e1674 = finalColor;
                            let _e1676 = cursorColor;
                            let _e1678 = mix(_e1674.xyz, _e1676, vec3(0.15f));
                            finalColor[0u] = _e1678.x;
                            finalColor[1u] = _e1678.y;
                            finalColor[2u] = _e1678.z;
                        }
                    }
                }
            }
        }
    }
    let _e1685 = hitFrontBox;
    if _e1685 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1686 = finalColor;
    outColor = _e1686;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
