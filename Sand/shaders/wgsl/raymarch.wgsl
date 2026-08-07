// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 40fc011c492f0c7579013f6d99801aceb434dfd0c2e53b22289e5c6cb4e78b81

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
    var phi_2746_: bool;

    let _e310 = (*tEnter);
    (*tEnter) = max(_e310, 0f);
    let _e312 = (*tEnter);
    let _e313 = (*tExit);
    if (_e312 >= _e313) {
        return false;
    }
    let _e315 = (*rayOrigin);
    let _e316 = (*rayDir);
    let _e317 = (*tEnter);
    startPos = (_e315 + (_e316 * _e317));
    let _e320 = startPos;
    let _e322 = tuning.cloudVoxelSize;
    cellPos = vec3<i32>(floor((_e320 / vec3(_e322))));
    let _e327 = (*rayDir);
    stepDir = vec3<i32>(sign(_e327));
    let _e331 = (*rayDir)[0u];
    if (_e331 == 0f) {
        local = 100000000f;
    } else {
        let _e334 = tuning.cloudVoxelSize;
        let _e336 = (*rayDir)[0u];
        local = abs((_e334 / _e336));
    }
    let _e339 = local;
    let _e341 = (*rayDir)[1u];
    if (_e341 == 0f) {
        local_1 = 100000000f;
    } else {
        let _e344 = tuning.cloudVoxelSize;
        let _e346 = (*rayDir)[1u];
        local_1 = abs((_e344 / _e346));
    }
    let _e349 = local_1;
    let _e351 = (*rayDir)[2u];
    if (_e351 == 0f) {
        local_2 = 100000000f;
    } else {
        let _e354 = tuning.cloudVoxelSize;
        let _e356 = (*rayDir)[2u];
        local_2 = abs((_e354 / _e356));
    }
    let _e359 = local_2;
    tDelta = vec3<f32>(_e339, _e349, _e359);
    let _e361 = startPos;
    let _e363 = tuning.cloudVoxelSize;
    let _e366 = cellPos;
    fracPos = ((_e361 / vec3(_e363)) - vec3<f32>(_e366));
    let _e369 = (*tEnter);
    let _e371 = stepDir[0u];
    if (_e371 > 0i) {
        let _e374 = fracPos[0u];
        let _e377 = tDelta[0u];
        local_3 = ((1f - _e374) * _e377);
    } else {
        let _e380 = fracPos[0u];
        let _e382 = tDelta[0u];
        local_3 = (_e380 * _e382);
    }
    let _e384 = local_3;
    let _e386 = stepDir[1u];
    if (_e386 > 0i) {
        let _e389 = fracPos[1u];
        let _e392 = tDelta[1u];
        local_4 = ((1f - _e389) * _e392);
    } else {
        let _e395 = fracPos[1u];
        let _e397 = tDelta[1u];
        local_4 = (_e395 * _e397);
    }
    let _e399 = local_4;
    let _e401 = stepDir[2u];
    if (_e401 > 0i) {
        let _e404 = fracPos[2u];
        let _e407 = tDelta[2u];
        local_5 = ((1f - _e404) * _e407);
    } else {
        let _e410 = fracPos[2u];
        let _e412 = tDelta[2u];
        local_5 = (_e410 * _e412);
    }
    let _e414 = local_5;
    tMax = (vec3(_e369) + vec3<f32>(_e384, _e399, _e414));
    normal = vec3<f32>(0f, 1f, 0f);
    let _e418 = (*tEnter);
    t = _e418;
    let _e420 = tuning.cloudVoxelSize;
    spread_1 = max(1i, i32(_e420));
    i = 0i;
    loop {
        let _e423 = i;
        let _e425 = tuning.maxCloudSteps;
        if (_e423 < bitcast<i32>(_e425)) {
            let _e428 = t;
            let _e429 = (*tExit);
            if (_e428 > _e429) {
                break;
            }
            let _e431 = cellPos;
            let _e436 = tuning.cloudVoxelSize;
            cellCenter = ((vec3<f32>(_e431) + vec3(0.5f)) * _e436);
            let _e439 = cellCenter[0u];
            cx = i32(floor(_e439));
            let _e443 = cellCenter[2u];
            cz = i32(floor(_e443));
            let _e446 = cx;
            let _e447 = (_e446 >= 0i);
            phi_2694_ = _e447;
            if _e447 {
                let _e448 = cx;
                let _e450 = tuning.gridWidth;
                phi_2694_ = (_e448 < bitcast<i32>(_e450));
            }
            let _e454 = phi_2694_;
            let _e455 = cz;
            let _e457 = (_e454 && (_e455 >= 0i));
            phi_2705_ = _e457;
            if _e457 {
                let _e458 = cz;
                let _e460 = tuning.gridDepth;
                phi_2705_ = (_e458 < bitcast<i32>(_e460));
            }
            let _e464 = phi_2705_;
            if _e464 {
                let _e465 = cx;
                param_22 = _e465;
                let _e466 = cz;
                param_23 = _e466;
                let _e467 = spread_1;
                param_24 = _e467;
                smoothedCloudColumn_u0028_i1_u003b_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_22), (&param_23), (&param_24), (&param_25), (&param_26));
                let _e468 = param_25;
                count_2 = _e468;
                let _e469 = param_26;
                baseY = _e469;
                let _e470 = count_2;
                if (_e470 > 0f) {
                    let _e472 = count_2;
                    let _e474 = tuning.cloudThicknessPerBlock;
                    thickness = (_e472 * max(_e474, 0.01f));
                    let _e477 = baseY;
                    let _e478 = thickness;
                    capY = (_e477 + _e478);
                    let _e481 = cellCenter[1u];
                    let _e482 = baseY;
                    let _e483 = (_e481 >= _e482);
                    phi_2746_ = _e483;
                    if _e483 {
                        let _e485 = cellCenter[1u];
                        let _e486 = capY;
                        phi_2746_ = (_e485 <= _e486);
                    }
                    let _e489 = phi_2746_;
                    if _e489 {
                        let _e490 = count_2;
                        let _e492 = tuning.cloudColumnFullCount;
                        density = clamp((_e490 / max(_e492, 1f)), 0f, 1f);
                        let _e496 = baseY;
                        let _e497 = capY;
                        mid = ((_e496 + _e497) * 0.5f);
                        let _e501 = cellCenter[1u];
                        let _e502 = mid;
                        let _e505 = thickness;
                        edgeFactor = clamp((abs((_e501 - _e502)) / max((_e505 * 0.5f), 0.001f)), 0f, 1f);
                        let _e511 = tuning.cloudEdgeThresholdMin;
                        let _e513 = tuning.cloudEdgeThresholdMax;
                        let _e514 = edgeFactor;
                        threshold = mix(_e511, _e513, _e514);
                        let _e516 = cellPos;
                        param_27 = vec3<f32>(_e516);
                        let _e518 = hash_u0028_vf3_u003b((&param_27));
                        fillHash = _e518;
                        let _e519 = fillHash;
                        let _e520 = threshold;
                        if (_e519 > _e520) {
                            let _e522 = t;
                            (*tHit) = _e522;
                            let _e523 = density;
                            (*hitDensity) = _e523;
                            let _e524 = cellPos;
                            param_28 = ((vec3<f32>(_e524) * 3.71f) + vec3<f32>(91f, 5f, 7f));
                            let _e528 = hash_u0028_vf3_u003b((&param_28));
                            shadeHash = _e528;
                            let _e529 = shadeHash;
                            baseColor = mix(vec3<f32>(0.9f, 0.91f, 0.94f), vec3<f32>(1f, 1f, 1f), vec3(_e529));
                            stormColor = vec3<f32>(0.32f, 0.33f, 0.36f);
                            let _e532 = baseColor;
                            let _e533 = stormColor;
                            let _e534 = (*greyness);
                            baseColor = mix(_e532, _e533, vec3(_e534));
                            let _e537 = normal;
                            let _e538 = (*sunDir);
                            diffuse = (0.6f + (0.4f * max(dot(_e537, _e538), 0f)));
                            let _e543 = baseColor;
                            let _e544 = diffuse;
                            (*hitColor) = (_e543 * _e544);
                            return true;
                        }
                    }
                }
            }
            let _e547 = tMax[0u];
            let _e549 = tMax[1u];
            if (_e547 < _e549) {
                let _e552 = tMax[0u];
                let _e554 = tMax[2u];
                if (_e552 < _e554) {
                    let _e557 = stepDir[0u];
                    let _e559 = cellPos[0u];
                    cellPos[0u] = (_e559 + _e557);
                    let _e563 = tMax[0u];
                    t = _e563;
                    let _e565 = tDelta[0u];
                    let _e567 = tMax[0u];
                    tMax[0u] = (_e567 + _e565);
                    let _e571 = stepDir[0u];
                    normal = vec3<f32>(f32(-(_e571)), 0f, 0f);
                } else {
                    let _e576 = stepDir[2u];
                    let _e578 = cellPos[2u];
                    cellPos[2u] = (_e578 + _e576);
                    let _e582 = tMax[2u];
                    t = _e582;
                    let _e584 = tDelta[2u];
                    let _e586 = tMax[2u];
                    tMax[2u] = (_e586 + _e584);
                    let _e590 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e590)));
                }
            } else {
                let _e595 = tMax[1u];
                let _e597 = tMax[2u];
                if (_e595 < _e597) {
                    let _e600 = stepDir[1u];
                    let _e602 = cellPos[1u];
                    cellPos[1u] = (_e602 + _e600);
                    let _e606 = tMax[1u];
                    t = _e606;
                    let _e608 = tDelta[1u];
                    let _e610 = tMax[1u];
                    tMax[1u] = (_e610 + _e608);
                    let _e614 = stepDir[1u];
                    normal = vec3<f32>(0f, f32(-(_e614)), 0f);
                } else {
                    let _e619 = stepDir[2u];
                    let _e621 = cellPos[2u];
                    cellPos[2u] = (_e621 + _e619);
                    let _e625 = tMax[2u];
                    t = _e625;
                    let _e627 = tDelta[2u];
                    let _e629 = tMax[2u];
                    tMax[2u] = (_e629 + _e627);
                    let _e633 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e633)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e637 = i;
            i = (_e637 + 1i);
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

    let _e279 = (*kind);
    if (_e279 == 1u) {
        let _e281 = (*cell);
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
    let _e327 = (*cell);
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
    var bandLo: f32;
    var bandHi: f32;
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
    var phi_3073_: bool;
    var phi_3089_: bool;
    var phi_3317_: bool;
    var phi_3324_: bool;
    var phi_3332_: bool;
    var phi_3339_: bool;
    var phi_3349_: bool;
    var phi_3837_: bool;
    var phi_4148_: bool;
    var phi_4155_: bool;
    var phi_4164_: bool;
    var phi_4170_: bool;
    var phi_4179_: bool;
    var phi_4390_: bool;
    var phi_4432_: bool;
    var phi_4454_: bool;
    var phi_4476_: bool;
    var phi_4504_: bool;
    var phi_4526_: bool;
    var phi_4548_: bool;

    let _e475 = inUV_1;
    screenSpace = ((_e475 * 2f) - vec2(1f));
    let _e480 = screenSpace[1u];
    screenSpace[1u] = -(_e480);
    let _e484 = pc.aspectScaleX;
    let _e486 = screenSpace[0u];
    screenSpace[0u] = (_e486 * _e484);
    let _e490 = pc.aspectScaleY;
    let _e492 = screenSpace[1u];
    screenSpace[1u] = (_e492 * _e490);
    let _e496 = pc.camX;
    let _e498 = pc.camY;
    let _e500 = pc.camZ;
    baseOrigin = vec3<f32>(_e496, _e498, _e500);
    param_73 = vec3<f32>(0f, 0f, 1f);
    let _e502 = applyCameraRotation_u0028_vf3_u003b((&param_73));
    forward = _e502;
    param_74 = vec3<f32>(1f, 0f, 0f);
    let _e503 = applyCameraRotation_u0028_vf3_u003b((&param_74));
    right = _e503;
    param_75 = vec3<f32>(0f, 1f, 0f);
    let _e504 = applyCameraRotation_u0028_vf3_u003b((&param_75));
    up = _e504;
    let _e506 = pc.perspectiveBlend;
    t_3 = clamp(_e506, 0f, 1f);
    let _e508 = worldExtent_u0028_();
    cubeCenter = (_e508 * 0.5f);
    let _e510 = cubeCenter;
    let _e511 = baseOrigin;
    let _e513 = forward;
    viewDistance = max(1f, dot((_e510 - _e511), _e513));
    let _e516 = viewDistance;
    let _e518 = pc.fovDistance;
    orthoHalfSize = (_e516 / _e518);
    let _e521 = screenSpace[0u];
    let _e523 = screenSpace[1u];
    let _e525 = pc.fovDistance;
    let _e527 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e521, _e523, _e525), vec3(_e527));
    let _e530 = right;
    let _e532 = localDir[0u];
    let _e534 = up;
    let _e536 = localDir[1u];
    let _e539 = forward;
    let _e541 = localDir[2u];
    rayDir_3 = normalize((((_e530 * _e532) + (_e534 * _e536)) + (_e539 * _e541)));
    let _e545 = right;
    let _e547 = screenSpace[0u];
    let _e549 = up;
    let _e551 = screenSpace[1u];
    let _e554 = orthoHalfSize;
    let _e556 = t_3;
    originOffset = ((((_e545 * _e547) + (_e549 * _e551)) * _e554) * (1f - _e556));
    let _e559 = baseOrigin;
    let _e560 = originOffset;
    rayOrigin_3 = (_e559 + _e560);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e562 = worldExtent_u0028_();
    let _e563 = rayOrigin_3;
    param_76 = _e563;
    let _e564 = rayDir_3;
    param_77 = _e564;
    param_78 = vec3<f32>(0f, 0f, 0f);
    param_79 = _e562;
    let _e565 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_76), (&param_77), (&param_78), (&param_79));
    aabbHit = _e565;
    hitFrontBox = false;
    hitBackBox = false;
    let _e567 = aabbHit[0u];
    let _e569 = aabbHit[1u];
    let _e570 = (_e567 < _e569);
    phi_3073_ = _e570;
    if _e570 {
        let _e572 = aabbHit[1u];
        phi_3073_ = (_e572 > 0f);
    }
    let _e575 = phi_3073_;
    if _e575 {
        let _e577 = aabbHit[0u];
        let _e578 = (_e577 > 0f);
        phi_3089_ = _e578;
        if _e578 {
            let _e579 = rayOrigin_3;
            let _e580 = rayDir_3;
            let _e582 = aabbHit[0u];
            param_80 = (_e579 + (_e580 * _e582));
            let _e585 = isEdge_u0028_vf3_u003b((&param_80));
            phi_3089_ = _e585;
        }
        let _e587 = phi_3089_;
        if _e587 {
            hitFrontBox = true;
        }
        let _e588 = rayOrigin_3;
        let _e589 = rayDir_3;
        let _e591 = aabbHit[1u];
        param_81 = (_e588 + (_e589 * _e591));
        let _e594 = isEdge_u0028_vf3_u003b((&param_81));
        if _e594 {
            hitBackBox = true;
        }
    }
    let _e596 = pc.showCloudBlocks;
    if (_e596 != 0i) {
        let _e599 = tuning.gridHeight;
        local_17 = bitcast<i32>(_e599);
    } else {
        let _e601 = marchCeiling_u0028_();
        local_17 = _e601;
    }
    let _e602 = local_17;
    ceilingY_1 = _e602;
    let _e604 = tuning.gridWidth;
    let _e607 = ceilingY_1;
    let _e610 = tuning.gridDepth;
    let _e614 = rayOrigin_3;
    param_82 = _e614;
    let _e615 = rayDir_3;
    param_83 = _e615;
    param_84 = vec3<f32>(0f, 0f, 0f);
    param_85 = vec3<f32>(f32(bitcast<i32>(_e604)), f32(_e607), f32(bitcast<i32>(_e610)));
    let _e616 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_82), (&param_83), (&param_84), (&param_85));
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
    i_6 = 0i;
    loop {
        let _e736 = i_6;
        let _e738 = tuning.marchMaxSteps;
        if (_e736 < bitcast<i32>(_e738)) {
            let _e742 = voxelPos_16[0u];
            let _e743 = (_e742 < 0i);
            phi_3317_ = _e743;
            if !(_e743) {
                let _e746 = voxelPos_16[0u];
                let _e748 = tuning.gridWidth;
                phi_3317_ = (_e746 >= bitcast<i32>(_e748));
            }
            let _e752 = phi_3317_;
            phi_3324_ = _e752;
            if !(_e752) {
                let _e755 = voxelPos_16[1u];
                phi_3324_ = (_e755 < 0i);
            }
            let _e758 = phi_3324_;
            phi_3332_ = _e758;
            if !(_e758) {
                let _e761 = voxelPos_16[1u];
                let _e762 = ceilingY_1;
                phi_3332_ = (_e761 >= _e762);
            }
            let _e765 = phi_3332_;
            phi_3339_ = _e765;
            if !(_e765) {
                let _e768 = voxelPos_16[2u];
                phi_3339_ = (_e768 < 0i);
            }
            let _e771 = phi_3339_;
            phi_3349_ = _e771;
            if !(_e771) {
                let _e774 = voxelPos_16[2u];
                let _e776 = tuning.gridDepth;
                phi_3349_ = (_e774 >= bitcast<i32>(_e776));
            }
            let _e780 = phi_3349_;
            if _e780 {
                break;
            }
            let _e781 = voxelPos_16;
            param_86 = _e781;
            let _e782 = getVoxel_u0028_vi3_u003b((&param_86));
            rawVoxel_5 = _e782;
            let _e783 = rawVoxel_5;
            hitType = (_e783 & 255u);
            let _e786 = pc.showCloudBlocks;
            let _e788 = hitType;
            if ((_e786 != 0i) && (_e788 == 0u)) {
                let _e792 = voxelPos_16[0u];
                let _e794 = voxelPos_16[1u];
                let _e796 = tuning.gridWidth;
                let _e801 = voxelPos_16[2u];
                let _e803 = tuning.gridWidth;
                let _e807 = tuning.gridHeight;
                let _e814 = unnamed_2.cloudCells[bitcast<u32>(((_e792 + (_e794 * bitcast<i32>(_e796))) + ((_e801 * bitcast<i32>(_e803)) * bitcast<i32>(_e807))))];
                c_2 = _e814;
                let _e815 = c_2;
                if ((_e815 & 3u) != 0u) {
                    hitType = 200u;
                    let _e818 = c_2;
                    hitRawVoxel = _e818;
                    hit = true;
                    break;
                }
            }
            let _e819 = hitType;
            if (_e819 == 7u) {
                hitType = 0u;
            }
            let _e821 = hitType;
            if (_e821 != 0u) {
                let _e823 = hitType;
                if (_e823 == 6u) {
                    let _e825 = rawVoxel_5;
                    age_1 = ((_e825 >> bitcast<u32>(24i)) & 255u);
                    let _e829 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e829) / 100f), 0f, 1f));
                    let _e834 = inUV_1;
                    let _e836 = pc.time;
                    dither = fract((sin(dot((_e834 + vec2((_e836 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e844 = dither;
                    let _e845 = targetAlpha;
                    if (_e844 > _e845) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e847 = rawVoxel_5;
                        hitRawVoxel = _e847;
                        break;
                    }
                } else {
                    let _e848 = hitType;
                    param_87 = _e848;
                    let _e849 = isLocustType_u0028_u1_u003b((&param_87));
                    let _e850 = hitType;
                    if (_e849 || (_e850 == 18u)) {
                        let _e853 = hitType;
                        kind_2 = select(0u, 1u, (_e853 == 18u));
                        let _e856 = voxelPos_16;
                        param_88 = _e856;
                        let _e857 = rayOrigin_3;
                        param_89 = _e857;
                        let _e858 = rayDir_3;
                        param_90 = _e858;
                        let _e859 = kind_2;
                        param_91 = _e859;
                        let _e860 = hitType;
                        param_92 = _e860;
                        let _e861 = normal_4;
                        param_93 = _e861;
                        let _e862 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_88), (&param_89), (&param_90), (&param_91), (&param_92), (&param_93), (&param_94), (&param_95), (&param_96));
                        let _e863 = param_94;
                        subT = _e863;
                        let _e864 = param_95;
                        subNormal_1 = _e864;
                        let _e865 = param_96;
                        subCell_3 = _e865;
                        if _e862 {
                            hit = true;
                            let _e866 = rawVoxel_5;
                            hitRawVoxel = _e866;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e867 = rawVoxel_5;
                        hitRawVoxel = _e867;
                        break;
                    }
                }
            }
            let _e869 = tMax_4[0u];
            let _e871 = tMax_4[1u];
            if (_e869 < _e871) {
                let _e874 = tMax_4[0u];
                let _e876 = tMax_4[2u];
                if (_e874 < _e876) {
                    let _e879 = stepDir_3[0u];
                    let _e881 = voxelPos_16[0u];
                    voxelPos_16[0u] = (_e881 + _e879);
                    let _e885 = tDelta_3[0u];
                    let _e887 = tMax_4[0u];
                    tMax_4[0u] = (_e887 + _e885);
                    let _e891 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e891)), 0f, 0f);
                } else {
                    let _e896 = stepDir_3[2u];
                    let _e898 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e898 + _e896);
                    let _e902 = tDelta_3[2u];
                    let _e904 = tMax_4[2u];
                    tMax_4[2u] = (_e904 + _e902);
                    let _e908 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e908)));
                }
            } else {
                let _e913 = tMax_4[1u];
                let _e915 = tMax_4[2u];
                if (_e913 < _e915) {
                    let _e918 = stepDir_3[1u];
                    let _e920 = voxelPos_16[1u];
                    voxelPos_16[1u] = (_e920 + _e918);
                    let _e924 = tDelta_3[1u];
                    let _e926 = tMax_4[1u];
                    tMax_4[1u] = (_e926 + _e924);
                    let _e930 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e930)), 0f);
                } else {
                    let _e935 = stepDir_3[2u];
                    let _e937 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e937 + _e935);
                    let _e941 = tDelta_3[2u];
                    let _e943 = tMax_4[2u];
                    tMax_4[2u] = (_e943 + _e941);
                    let _e947 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e947)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e951 = i_6;
            i_6 = (_e951 + 1i);
        }
    }
    let _e953 = hit;
    if _e953 {
        let _e954 = normal_4;
        if (length(_e954) < 0.1f) {
            let _e957 = rayDir_3;
            normal_4 = -(_e957);
        }
        let _e959 = normal_4;
        ddaNormal_1 = _e959;
        let _e960 = hitType;
        if (_e960 == 2u) {
            let _e962 = voxelPos_16;
            param_97 = _e962;
            let _e963 = getWaterNormal_u0028_vi3_u003b((&param_97));
            param_98 = _e963;
            let _e964 = voxelPos_16;
            param_99 = _e964;
            let _e965 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_98), (&param_99));
            normal_4 = _e965;
        } else {
            let _e966 = hitType;
            param_100 = _e966;
            let _e967 = isLocustType_u0028_u1_u003b((&param_100));
            let _e968 = hitType;
            if (_e967 || (_e968 == 18u)) {
                let _e971 = subNormal_1;
                normal_4 = _e971;
            } else {
                let _e972 = voxelPos_16;
                param_101 = _e972;
                let _e973 = getSmoothNormal_u0028_vi3_u003b((&param_101));
                normal_4 = _e973;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e974 = normal_4;
        let _e975 = sunDir_2;
        diffuse_1 = max(dot(_e974, _e975), 0f);
        let _e978 = voxelPos_16;
        param_102 = _e978;
        let _e979 = ddaNormal_1;
        param_103 = _e979;
        let _e980 = sunDir_2;
        param_104 = _e980;
        let _e981 = ceilingY_1;
        param_105 = _e981;
        let _e982 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_102), (&param_103), (&param_104), (&param_105));
        shadow_1 = _e982;
        let _e983 = ambientColor;
        let _e984 = sunColor_1;
        let _e985 = diffuse_1;
        let _e987 = shadow_1;
        baseLighting_9 = (_e983 + ((_e984 * _e985) * _e987));
        let _e990 = baseLighting_9;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e990);
        let _e992 = hitType;
        if (_e992 == 200u) {
            calm = vec3<f32>(0.35f, 0.65f, 1f);
            rain = vec3<f32>(1f, 0.55f, 0.25f);
            let _e994 = calm;
            let _e995 = rain;
            let _e996 = hitRawVoxel;
            let _e1002 = baseLighting_9;
            finalVoxelColor = (mix(_e994, _e995, vec3(select(0f, 1f, ((_e996 & 3u) == 2u)))) * _e1002);
        }
        let _e1004 = hitType;
        switch bitcast<i32>(_e1004) {
            case 1: {
                let _e1006 = hitRawVoxel;
                param_106 = _e1006;
                let _e1007 = baseLighting_9;
                param_107 = _e1007;
                let _e1008 = renderSand_u0028_u1_u003b_vf3_u003b((&param_106), (&param_107));
                finalVoxelColor = _e1008;
                break;
            }
            case 2: {
                let _e1009 = voxelPos_16;
                param_108 = _e1009;
                let _e1010 = normal_4;
                param_109 = _e1010;
                let _e1011 = rayOrigin_3;
                param_110 = _e1011;
                let _e1012 = sunDir_2;
                param_111 = _e1012;
                let _e1013 = sunColor_1;
                param_112 = _e1013;
                let _e1014 = shadow_1;
                param_113 = _e1014;
                let _e1015 = baseLighting_9;
                param_114 = _e1015;
                let _e1016 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_108), (&param_109), (&param_110), (&param_111), (&param_112), (&param_113), (&param_114));
                finalVoxelColor = _e1016;
                break;
            }
            case 3: {
                let _e1017 = voxelPos_16;
                param_115 = _e1017;
                let _e1018 = baseLighting_9;
                param_116 = _e1018;
                let _e1019 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_115), (&param_116));
                finalVoxelColor = _e1019;
                break;
            }
            case 4: {
                let _e1020 = hitRawVoxel;
                param_117 = _e1020;
                let _e1021 = voxelPos_16;
                param_118 = _e1021;
                let _e1022 = ddaNormal_1;
                param_119 = _e1022;
                let _e1023 = baseLighting_9;
                param_120 = _e1023;
                let _e1024 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_117), (&param_118), (&param_119), (&param_120));
                finalVoxelColor = _e1024;
                break;
            }
            case 5: {
                let _e1025 = hitRawVoxel;
                param_121 = _e1025;
                let _e1026 = voxelPos_16;
                param_122 = _e1026;
                let _e1027 = renderFire_u0028_u1_u003b_vi3_u003b((&param_121), (&param_122));
                finalVoxelColor = _e1027;
                break;
            }
            case 6: {
                let _e1028 = voxelPos_16;
                param_123 = _e1028;
                let _e1029 = baseLighting_9;
                param_124 = _e1029;
                let _e1030 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_123), (&param_124));
                finalVoxelColor = _e1030;
                break;
            }
            case 9, 10, 11, 8: {
                let _e1031 = hitRawVoxel;
                param_125 = _e1031;
                let _e1032 = voxelPos_16;
                param_126 = _e1032;
                let _e1033 = renderLava_u0028_u1_u003b_vi3_u003b((&param_125), (&param_126));
                finalVoxelColor = _e1033;
                break;
            }
            case 12: {
                let _e1034 = voxelPos_16;
                param_127 = _e1034;
                let _e1035 = baseLighting_9;
                param_128 = _e1035;
                let _e1036 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_127), (&param_128));
                finalVoxelColor = _e1036;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e1037 = voxelPos_16;
                param_129 = _e1037;
                let _e1038 = subCell_3;
                param_130 = _e1038;
                let _e1039 = baseLighting_9;
                param_131 = _e1039;
                let _e1040 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_129), (&param_130), (&param_131));
                finalVoxelColor = _e1040;
                break;
            }
            case 18: {
                let _e1041 = voxelPos_16;
                param_132 = _e1041;
                let _e1042 = subCell_3;
                param_133 = _e1042;
                let _e1043 = baseLighting_9;
                param_134 = _e1043;
                let _e1044 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_132), (&param_133), (&param_134));
                finalVoxelColor = _e1044;
                break;
            }
            case 19: {
                let _e1045 = hitRawVoxel;
                param_135 = _e1045;
                let _e1046 = voxelPos_16;
                param_136 = _e1046;
                let _e1047 = baseLighting_9;
                param_137 = _e1047;
                let _e1048 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_135), (&param_136), (&param_137));
                finalVoxelColor = _e1048;
                break;
            }
            default: {
                break;
            }
        }
        let _e1049 = finalVoxelColor;
        param_138 = _e1049;
        let _e1050 = voxelPos_16;
        param_139 = _e1050;
        let _e1051 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_138), (&param_139));
        finalVoxelColor = _e1051;
        let _e1052 = hitType;
        param_140 = _e1052;
        let _e1053 = isLocustType_u0028_u1_u003b((&param_140));
        let _e1054 = hitType;
        if (_e1053 || (_e1054 == 18u)) {
            let _e1057 = subT;
            local_24 = _e1057;
        } else {
            let _e1058 = voxelPos_16;
            let _e1061 = rayOrigin_3;
            local_24 = length(((vec3<f32>(_e1058) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e1061));
        }
        let _e1064 = local_24;
        distanceTraveled = _e1064;
        let _e1065 = distanceTraveled;
        let _e1066 = MAX_VISIBILITY;
        let _e1070 = finalVoxelColor;
        finalVoxelColor = (_e1070 * mix(1f, 0f, clamp((_e1065 / _e1066), 0f, 1f)));
        let _e1072 = distanceTraveled;
        finalDist = _e1072;
        let _e1073 = finalVoxelColor;
        finalColor = vec4<f32>(_e1073.x, _e1073.y, _e1073.z, 1f);
    } else {
        let _e1078 = hitBackBox;
        if _e1078 {
            let _e1080 = aabbHit[1u];
            finalDist = _e1080;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1082 = unnamed.blackHoleCount;
    if (_e1082 > 0u) {
        seenHoles = 0u;
        i_7 = 0i;
        loop {
            let _e1084 = i_7;
            let _e1085 = (_e1084 < 8i);
            phi_3837_ = _e1085;
            if _e1085 {
                let _e1086 = seenHoles;
                let _e1088 = unnamed.blackHoleCount;
                phi_3837_ = (_e1086 < _e1088);
            }
            let _e1091 = phi_3837_;
            if _e1091 {
                let _e1092 = i_7;
                let _e1095 = unnamed.blackHoles[_e1092];
                code_2 = _e1095;
                let _e1096 = code_2;
                if (_e1096 == 0u) {
                    continue;
                }
                let _e1098 = seenHoles;
                seenHoles = (_e1098 + bitcast<u32>(1i));
                let _e1101 = code_2;
                if ((_e1101 & 1073741824u) != 0u) {
                    let _e1105 = tuning.purgeLevel;
                    let _e1107 = i_7;
                    let _e1110 = unnamed.blackHoleMass[_e1107];
                    let _e1113 = tuning.purgeMass;
                    local_25 = u32((f32(_e1105) * clamp((f32(_e1110) / f32(max(_e1113, 1u))), 0f, 1f)));
                } else {
                    let _e1120 = i_7;
                    let _e1123 = unnamed.blackHoleMass[_e1120];
                    param_141 = _e1123;
                    let _e1124 = bhLevel_u0028_u1_u003b((&param_141));
                    local_25 = _e1124;
                }
                let _e1125 = local_25;
                bodyLevel = _e1125;
                let _e1126 = bodyLevel;
                param_142 = _e1126;
                let _e1127 = bhBodyRadius_u0028_u1_u003b((&param_142));
                bodyRadius = _e1127;
                let _e1128 = code_2;
                param_143 = _e1128;
                let _e1129 = bhDecode_u0028_u1_u003b((&param_143));
                center = (vec3<f32>(_e1129) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1132 = rayOrigin_3;
                let _e1133 = center;
                oc = (_e1132 - _e1133);
                let _e1135 = oc;
                let _e1136 = rayDir_3;
                b_3 = dot(_e1135, _e1136);
                let _e1138 = oc;
                let _e1139 = oc;
                let _e1141 = bodyRadius;
                let _e1142 = bodyRadius;
                c_3 = (dot(_e1138, _e1139) - (_e1141 * _e1142));
                let _e1145 = b_3;
                let _e1146 = b_3;
                let _e1148 = c_3;
                disc = ((_e1145 * _e1146) - _e1148);
                let _e1150 = disc;
                if (_e1150 <= 0f) {
                    continue;
                }
                let _e1152 = disc;
                sq = sqrt(_e1152);
                let _e1154 = b_3;
                let _e1156 = sq;
                tNear_1 = (-(_e1154) - _e1156);
                let _e1158 = b_3;
                let _e1160 = sq;
                tFar_1 = (-(_e1158) + _e1160);
                let _e1162 = tFar_1;
                if (_e1162 <= 0f) {
                    continue;
                }
                let _e1164 = tNear_1;
                bodyDist = max(0f, _e1164);
                let _e1166 = bodyDist;
                let _e1167 = finalDist;
                if (_e1166 < _e1167) {
                    let _e1169 = rayOrigin_3;
                    let _e1170 = rayDir_3;
                    let _e1171 = bodyDist;
                    let _e1174 = center;
                    surfaceNormal = normalize(((_e1169 + (_e1170 * _e1171)) - _e1174));
                    let _e1177 = surfaceNormal;
                    param_144 = _e1177;
                    let _e1178 = rayDir_3;
                    param_145 = _e1178;
                    let _e1179 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_144), (&param_145));
                    bodyColor = _e1179;
                    let _e1180 = bodyDist;
                    let _e1181 = MAX_VISIBILITY;
                    let _e1185 = bodyColor;
                    bodyColor = (_e1185 * mix(1f, 0f, clamp((_e1180 / _e1181), 0f, 1f)));
                    let _e1187 = bodyColor;
                    finalColor = vec4<f32>(_e1187.x, _e1187.y, _e1187.z, 1f);
                    let _e1192 = bodyDist;
                    finalDist = _e1192;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1193 = i_7;
                i_7 = (_e1193 + 1i);
            }
        }
    }
    let _e1196 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1196), 0f, 1f);
    let _e1199 = charge;
    cloudGreyness = _e1199;
    let _e1201 = unnamed.rainPhase;
    if (_e1201 == 1u) {
        let _e1204 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1204);
        let _e1206 = charge;
        let _e1208 = pc.time;
        let _e1209 = crossedTime;
        let _e1212 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1206, clamp(((_e1208 - _e1209) / _e1212), 0f, 1f));
    } else {
        let _e1217 = unnamed.rainPhase;
        if (_e1217 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1220 = tuning.cloudMaxAlpha;
    if (_e1220 > 0.002f) {
        let _e1223 = unnamed.cloudMinY;
        let _e1226 = tuning.cloudVoxelSize;
        bandLo = (f32(_e1223) - max(_e1226, 1f));
        let _e1230 = unnamed.cloudMaxY;
        let _e1233 = tuning.cloudColumnFullCount;
        let _e1236 = tuning.cloudThicknessPerBlock;
        bandHi = (f32(_e1230) + (max(_e1233, 1f) * max(_e1236, 0.01f)));
        let _e1241 = unnamed.cloudMinY;
        let _e1243 = unnamed.cloudMaxY;
        if (_e1241 > _e1243) {
            local_26 = vec2<f32>(1f, -1f);
        } else {
            let _e1245 = bandLo;
            let _e1247 = worldExtent_u0028_();
            let _e1249 = bandHi;
            let _e1250 = worldExtent_u0028_();
            let _e1253 = rayOrigin_3;
            param_146 = _e1253;
            let _e1254 = rayDir_3;
            param_147 = _e1254;
            param_148 = vec3<f32>(0f, _e1245, 0f);
            param_149 = vec3<f32>(_e1247.x, _e1249, _e1250.z);
            let _e1255 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_146), (&param_147), (&param_148), (&param_149));
            local_26 = _e1255;
        }
        let _e1256 = local_26;
        cloudClip = _e1256;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1258 = cloudClip[0u];
        nearT = max(_e1258, 0f);
        let _e1261 = cloudClip[1u];
        let _e1262 = finalDist;
        farT = min(_e1261, _e1262);
        let _e1264 = nearT;
        let _e1265 = farT;
        if (_e1264 < _e1265) {
            let _e1267 = rayOrigin_3;
            param_150 = _e1267;
            let _e1268 = rayDir_3;
            param_151 = _e1268;
            let _e1269 = nearT;
            param_152 = _e1269;
            let _e1270 = farT;
            param_153 = _e1270;
            let _e1271 = cloudSunDir;
            param_154 = _e1271;
            let _e1272 = cloudGreyness;
            param_155 = _e1272;
            let _e1273 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b((&param_150), (&param_151), (&param_152), (&param_153), (&param_154), (&param_155), (&param_156), (&param_157), (&param_158));
            let _e1274 = param_156;
            cloudTHit = _e1274;
            let _e1275 = param_157;
            cloudColor = _e1275;
            let _e1276 = param_158;
            cloudDensity = _e1276;
            if _e1273 {
                let _e1277 = cloudTHit;
                if (_e1277 > 0f) {
                    let _e1279 = cloudTHit;
                    bestT = _e1279;
                    let _e1280 = cloudColor;
                    bestColor = _e1280;
                    let _e1282 = tuning.cloudMinAlpha;
                    let _e1284 = tuning.cloudMaxAlpha;
                    let _e1285 = cloudDensity;
                    bestAlpha = clamp(mix(_e1282, _e1284, _e1285), 0f, 0.95f);
                    foundCloud = true;
                }
            }
        }
        let _e1288 = foundCloud;
        let _e1289 = bestT;
        let _e1290 = finalDist;
        if (_e1288 && (_e1289 < _e1290)) {
            let _e1293 = finalColor;
            let _e1295 = bestColor;
            let _e1296 = bestAlpha;
            let _e1298 = mix(_e1293.xyz, _e1295, vec3(_e1296));
            finalColor[0u] = _e1298.x;
            finalColor[1u] = _e1298.y;
            finalColor[2u] = _e1298.z;
        }
    }
    let _e1306 = pc.spawnX;
    let _e1307 = (_e1306 >= 0i);
    phi_4148_ = _e1307;
    if _e1307 {
        let _e1309 = pc.spawnX;
        let _e1311 = tuning.gridWidth;
        phi_4148_ = (_e1309 < bitcast<i32>(_e1311));
    }
    let _e1315 = phi_4148_;
    phi_4155_ = _e1315;
    if _e1315 {
        let _e1317 = pc.spawnY;
        phi_4155_ = (_e1317 >= 0i);
    }
    let _e1320 = phi_4155_;
    phi_4164_ = _e1320;
    if _e1320 {
        let _e1322 = pc.spawnY;
        let _e1324 = tuning.gridHeight;
        phi_4164_ = (_e1322 < bitcast<i32>(_e1324));
    }
    let _e1328 = phi_4164_;
    phi_4170_ = _e1328;
    if _e1328 {
        let _e1330 = pc.spawnZ;
        phi_4170_ = (_e1330 >= 0i);
    }
    let _e1333 = phi_4170_;
    phi_4179_ = _e1333;
    if _e1333 {
        let _e1335 = pc.spawnZ;
        let _e1337 = tuning.gridDepth;
        phi_4179_ = (_e1335 < bitcast<i32>(_e1337));
    }
    let _e1341 = phi_4179_;
    if _e1341 {
        let _e1343 = pc.spawnSize;
        halfDistMin = (_e1343 / 2i);
        let _e1346 = pc.spawnSize;
        halfDistMax = ((_e1346 - 1i) / 2i);
        let _e1350 = pc.spawnX;
        let _e1351 = halfDistMin;
        let _e1355 = pc.spawnY;
        let _e1356 = halfDistMin;
        let _e1360 = pc.spawnZ;
        let _e1361 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1350 - _e1351)), f32((_e1355 - _e1356)), f32((_e1360 - _e1361)));
        let _e1366 = pc.spawnX;
        let _e1367 = halfDistMax;
        let _e1372 = pc.spawnY;
        let _e1373 = halfDistMax;
        let _e1378 = pc.spawnZ;
        let _e1379 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1366 + _e1367) + 1i)), f32(((_e1372 + _e1373) + 1i)), f32(((_e1378 + _e1379) + 1i)));
        let _e1385 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1388 = indexable_6[clamp(_e1385, 0i, 19i)];
        cursorColor = _e1388;
        let _e1390 = pc.spawnShape;
        if (_e1390 == 1i) {
            let _e1392 = boxMin_2;
            let _e1393 = boxMax_1;
            sphereCenter = ((_e1392 + _e1393) * 0.5f);
            let _e1397 = pc.spawnSize;
            sphereRadius = (f32(_e1397) * 0.5f);
            let _e1400 = rayOrigin_3;
            let _e1401 = sphereCenter;
            oc_1 = (_e1400 - _e1401);
            let _e1403 = oc_1;
            let _e1404 = rayDir_3;
            b_4 = dot(_e1403, _e1404);
            let _e1406 = oc_1;
            let _e1407 = oc_1;
            let _e1409 = sphereRadius;
            let _e1410 = sphereRadius;
            c_4 = (dot(_e1406, _e1407) - (_e1409 * _e1410));
            let _e1413 = b_4;
            let _e1414 = b_4;
            let _e1416 = c_4;
            disc_1 = ((_e1413 * _e1414) - _e1416);
            let _e1418 = disc_1;
            if (_e1418 > 0f) {
                let _e1420 = disc_1;
                sq_1 = sqrt(_e1420);
                let _e1422 = b_4;
                let _e1424 = sq_1;
                tNear_2 = (-(_e1422) - _e1424);
                let _e1426 = b_4;
                let _e1428 = sq_1;
                tFar_2 = (-(_e1426) + _e1428);
                let _e1430 = tFar_2;
                if (_e1430 > 0f) {
                    let _e1432 = tNear_2;
                    inside = (_e1432 <= 0f);
                    let _e1434 = inside;
                    let _e1435 = tFar_2;
                    let _e1436 = tNear_2;
                    cursorDist = select(_e1436, _e1435, _e1434);
                    let _e1438 = rayOrigin_3;
                    let _e1439 = rayDir_3;
                    let _e1440 = cursorDist;
                    let _e1443 = sphereCenter;
                    shellNormal = normalize(((_e1438 + (_e1439 * _e1440)) - _e1443));
                    let _e1446 = shellNormal;
                    let _e1447 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1446, _e1447)));
                    let _e1451 = rim_1;
                    let _e1454 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1451)) * select(1f, 0.35f, _e1454));
                    let _e1457 = cursorDist;
                    let _e1458 = finalDist;
                    if (_e1457 < _e1458) {
                        let _e1460 = finalColor;
                        let _e1462 = cursorColor;
                        let _e1463 = alpha;
                        let _e1465 = mix(_e1460.xyz, _e1462, vec3(_e1463));
                        finalColor[0u] = _e1465.x;
                        finalColor[1u] = _e1465.y;
                        finalColor[2u] = _e1465.z;
                    }
                }
            }
        } else {
            let _e1472 = rayOrigin_3;
            param_159 = _e1472;
            let _e1473 = rayDir_3;
            param_160 = _e1473;
            let _e1474 = boxMin_2;
            param_161 = _e1474;
            let _e1475 = boxMax_1;
            param_162 = _e1475;
            let _e1476 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_159), (&param_160), (&param_161), (&param_162));
            cursorHit = _e1476;
            let _e1478 = cursorHit[0u];
            let _e1480 = cursorHit[1u];
            let _e1481 = (_e1478 < _e1480);
            phi_4390_ = _e1481;
            if _e1481 {
                let _e1483 = cursorHit[1u];
                phi_4390_ = (_e1483 > 0f);
            }
            let _e1486 = phi_4390_;
            if _e1486 {
                let _e1488 = cursorHit[0u];
                distFront = max(0f, _e1488);
                let _e1491 = cursorHit[1u];
                distBack = _e1491;
                let _e1492 = rayOrigin_3;
                let _e1493 = rayDir_3;
                let _e1494 = distFront;
                hitPosFront = (_e1492 + (_e1493 * _e1494));
                let _e1497 = rayOrigin_3;
                let _e1498 = rayDir_3;
                let _e1499 = distBack;
                hitPosBack = (_e1497 + (_e1498 * _e1499));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1503 = hitPosFront[0u];
                let _e1505 = boxMin_2[0u];
                let _e1506 = e;
                let _e1508 = (_e1503 < (_e1505 + _e1506));
                phi_4432_ = _e1508;
                if !(_e1508) {
                    let _e1511 = hitPosFront[0u];
                    let _e1513 = boxMax_1[0u];
                    let _e1514 = e;
                    phi_4432_ = (_e1511 > (_e1513 - _e1514));
                }
                let _e1518 = phi_4432_;
                if _e1518 {
                    let _e1519 = edgesFront;
                    edgesFront = (_e1519 + 1i);
                }
                let _e1522 = hitPosFront[1u];
                let _e1524 = boxMin_2[1u];
                let _e1525 = e;
                let _e1527 = (_e1522 < (_e1524 + _e1525));
                phi_4454_ = _e1527;
                if !(_e1527) {
                    let _e1530 = hitPosFront[1u];
                    let _e1532 = boxMax_1[1u];
                    let _e1533 = e;
                    phi_4454_ = (_e1530 > (_e1532 - _e1533));
                }
                let _e1537 = phi_4454_;
                if _e1537 {
                    let _e1538 = edgesFront;
                    edgesFront = (_e1538 + 1i);
                }
                let _e1541 = hitPosFront[2u];
                let _e1543 = boxMin_2[2u];
                let _e1544 = e;
                let _e1546 = (_e1541 < (_e1543 + _e1544));
                phi_4476_ = _e1546;
                if !(_e1546) {
                    let _e1549 = hitPosFront[2u];
                    let _e1551 = boxMax_1[2u];
                    let _e1552 = e;
                    phi_4476_ = (_e1549 > (_e1551 - _e1552));
                }
                let _e1556 = phi_4476_;
                if _e1556 {
                    let _e1557 = edgesFront;
                    edgesFront = (_e1557 + 1i);
                }
                let _e1559 = edgesFront;
                if (_e1559 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1562 = hitPosBack[0u];
                let _e1564 = boxMin_2[0u];
                let _e1565 = e;
                let _e1567 = (_e1562 < (_e1564 + _e1565));
                phi_4504_ = _e1567;
                if !(_e1567) {
                    let _e1570 = hitPosBack[0u];
                    let _e1572 = boxMax_1[0u];
                    let _e1573 = e;
                    phi_4504_ = (_e1570 > (_e1572 - _e1573));
                }
                let _e1577 = phi_4504_;
                if _e1577 {
                    let _e1578 = edgesBack;
                    edgesBack = (_e1578 + 1i);
                }
                let _e1581 = hitPosBack[1u];
                let _e1583 = boxMin_2[1u];
                let _e1584 = e;
                let _e1586 = (_e1581 < (_e1583 + _e1584));
                phi_4526_ = _e1586;
                if !(_e1586) {
                    let _e1589 = hitPosBack[1u];
                    let _e1591 = boxMax_1[1u];
                    let _e1592 = e;
                    phi_4526_ = (_e1589 > (_e1591 - _e1592));
                }
                let _e1596 = phi_4526_;
                if _e1596 {
                    let _e1597 = edgesBack;
                    edgesBack = (_e1597 + 1i);
                }
                let _e1600 = hitPosBack[2u];
                let _e1602 = boxMin_2[2u];
                let _e1603 = e;
                let _e1605 = (_e1600 < (_e1602 + _e1603));
                phi_4548_ = _e1605;
                if !(_e1605) {
                    let _e1608 = hitPosBack[2u];
                    let _e1610 = boxMax_1[2u];
                    let _e1611 = e;
                    phi_4548_ = (_e1608 > (_e1610 - _e1611));
                }
                let _e1615 = phi_4548_;
                if _e1615 {
                    let _e1616 = edgesBack;
                    edgesBack = (_e1616 + 1i);
                }
                let _e1618 = edgesBack;
                if (_e1618 >= 2i) {
                    onBackEdge = true;
                }
                let _e1620 = onFrontEdge;
                let _e1621 = distFront;
                let _e1622 = finalDist;
                if (_e1620 && (_e1621 < _e1622)) {
                    let _e1625 = finalColor;
                    let _e1627 = cursorColor;
                    let _e1629 = mix(_e1625.xyz, _e1627, vec3(0.9f));
                    finalColor[0u] = _e1629.x;
                    finalColor[1u] = _e1629.y;
                    finalColor[2u] = _e1629.z;
                } else {
                    let _e1636 = onBackEdge;
                    let _e1637 = distBack;
                    let _e1638 = finalDist;
                    if (_e1636 && (_e1637 < _e1638)) {
                        let _e1641 = finalColor;
                        let _e1643 = cursorColor;
                        let _e1645 = mix(_e1641.xyz, _e1643, vec3(0.2f));
                        finalColor[0u] = _e1645.x;
                        finalColor[1u] = _e1645.y;
                        finalColor[2u] = _e1645.z;
                    } else {
                        let _e1652 = distFront;
                        let _e1653 = finalDist;
                        if (_e1652 < _e1653) {
                            let _e1655 = finalColor;
                            let _e1657 = cursorColor;
                            let _e1659 = mix(_e1655.xyz, _e1657, vec3(0.15f));
                            finalColor[0u] = _e1659.x;
                            finalColor[1u] = _e1659.y;
                            finalColor[2u] = _e1659.z;
                        }
                    }
                }
            }
        }
    }
    let _e1666 = hitFrontBox;
    if _e1666 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1667 = finalColor;
    outColor = _e1667;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
