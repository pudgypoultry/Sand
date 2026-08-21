// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: d228fb6fda69d2c91fa6e3d556b84c75d76f68ee4dd0c7eac4fc03d7ba2d7b88

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
    let _e264 = (*p);
    return fract((sin(dot(_e264, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x: ptr<function, i32>, z: ptr<function, i32>) -> u32 {
    let _e265 = (*x);
    let _e266 = (*z);
    let _e268 = tuning.gridWidth;
    return (bitcast<u32>((_e265 + (_e266 * bitcast<i32>(_e268)))) * 4u);
}

fn sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b(x_1: ptr<function, i32>, z_1: ptr<function, i32>, count: ptr<function, f32>, topY: ptr<function, f32>) {
    var b: u32;
    var param: i32;
    var param_1: i32;
    var d: f32;
    var fx: f32;
    var fz: f32;
    var phi_2383_: bool;
    var phi_2395_: bool;

    let _e273 = (*x_1);
    let _e274 = (_e273 < 0i);
    phi_2383_ = _e274;
    if !(_e274) {
        let _e276 = (*x_1);
        let _e278 = tuning.gridWidth;
        phi_2383_ = (_e276 >= bitcast<i32>(_e278));
    }
    let _e282 = phi_2383_;
    let _e283 = (*z_1);
    let _e285 = (_e282 || (_e283 < 0i));
    phi_2395_ = _e285;
    if !(_e285) {
        let _e287 = (*z_1);
        let _e289 = tuning.gridDepth;
        phi_2395_ = (_e287 >= bitcast<i32>(_e289));
    }
    let _e293 = phi_2395_;
    if _e293 {
        (*count) = 0f;
        (*topY) = 0f;
        return;
    }
    let _e294 = (*x_1);
    param = _e294;
    let _e295 = (*z_1);
    param_1 = _e295;
    let _e296 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param), (&param_1));
    b = _e296;
    let _e297 = b;
    let _e301 = unnamed.cloudColumn[(_e297 + 2u)];
    (*count) = (f32(_e301) * 0.0625f);
    let _e304 = b;
    let _e308 = unnamed.cloudColumn[(_e304 + 3u)];
    (*topY) = (f32(_e308) * 0.0625f);
    let _e312 = tuning.cloudEdgeFadeDist;
    d = max(_e312, 0.001f);
    let _e314 = d;
    let _e315 = (*x_1);
    let _e318 = d;
    let _e320 = tuning.gridWidth;
    let _e323 = (*x_1);
    fx = (smoothstep(0f, _e314, f32(_e315)) * smoothstep(0f, _e318, f32(((bitcast<i32>(_e320) - 1i) - _e323))));
    let _e328 = d;
    let _e329 = (*z_1);
    let _e332 = d;
    let _e334 = tuning.gridDepth;
    let _e337 = (*z_1);
    fz = (smoothstep(0f, _e328, f32(_e329)) * smoothstep(0f, _e332, f32(((bitcast<i32>(_e334) - 1i) - _e337))));
    let _e342 = fx;
    let _e343 = fz;
    let _e345 = (*count);
    (*count) = (_e345 * (_e342 * _e343));
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

    let _e298 = (*x_2);
    param_2 = _e298;
    let _e299 = (*z_2);
    param_3 = _e299;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_2), (&param_3), (&param_4), (&param_5));
    let _e300 = param_4;
    c0_ = _e300;
    let _e301 = param_5;
    y0_ = _e301;
    let _e302 = (*x_2);
    let _e303 = (*spread);
    param_6 = (_e302 - _e303);
    let _e305 = (*z_2);
    param_7 = _e305;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_6), (&param_7), (&param_8), (&param_9));
    let _e306 = param_8;
    c1_ = _e306;
    let _e307 = param_9;
    y1_ = _e307;
    let _e308 = (*x_2);
    let _e309 = (*spread);
    param_10 = (_e308 + _e309);
    let _e311 = (*z_2);
    param_11 = _e311;
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_10), (&param_11), (&param_12), (&param_13));
    let _e312 = param_12;
    c2_ = _e312;
    let _e313 = param_13;
    y2_ = _e313;
    let _e314 = (*z_2);
    let _e315 = (*spread);
    let _e317 = (*x_2);
    param_14 = _e317;
    param_15 = (_e314 - _e315);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_14), (&param_15), (&param_16), (&param_17));
    let _e318 = param_16;
    c3_ = _e318;
    let _e319 = param_17;
    y3_ = _e319;
    let _e320 = (*z_2);
    let _e321 = (*spread);
    let _e323 = (*x_2);
    param_18 = _e323;
    param_19 = (_e320 + _e321);
    sampleCloudColumn_u0028_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_18), (&param_19), (&param_20), (&param_21));
    let _e324 = param_20;
    c4_ = _e324;
    let _e325 = param_21;
    y4_ = _e325;
    let _e326 = c0_;
    let _e328 = c1_;
    let _e330 = c2_;
    let _e332 = c3_;
    let _e334 = c4_;
    (*count_1) = ((((((_e326 * 2f) + _e328) + _e330) + _e332) + _e334) / 6f);
    let _e337 = y0_;
    let _e338 = y1_;
    let _e340 = y2_;
    let _e341 = y3_;
    let _e344 = y4_;
    (*topY_1) = max(max(max(_e337, _e338), max(_e340, _e341)), _e344);
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
    var phi_2737_: bool;
    var phi_2748_: bool;
    var phi_2805_: bool;

    let _e312 = (*tEnter);
    (*tEnter) = max(_e312, 0f);
    let _e314 = (*tEnter);
    let _e315 = (*tExit);
    if (_e314 >= _e315) {
        return false;
    }
    let _e317 = (*rayOrigin);
    let _e318 = (*rayDir);
    let _e319 = (*tEnter);
    startPos = (_e317 + (_e318 * _e319));
    let _e322 = startPos;
    let _e324 = tuning.cloudVoxelSize;
    cellPos = vec3<i32>(floor((_e322 / vec3(_e324))));
    let _e329 = (*rayDir);
    stepDir = vec3<i32>(sign(_e329));
    let _e333 = (*rayDir)[0u];
    if (_e333 == 0f) {
        local = 100000000f;
    } else {
        let _e336 = tuning.cloudVoxelSize;
        let _e338 = (*rayDir)[0u];
        local = abs((_e336 / _e338));
    }
    let _e341 = local;
    let _e343 = (*rayDir)[1u];
    if (_e343 == 0f) {
        local_1 = 100000000f;
    } else {
        let _e346 = tuning.cloudVoxelSize;
        let _e348 = (*rayDir)[1u];
        local_1 = abs((_e346 / _e348));
    }
    let _e351 = local_1;
    let _e353 = (*rayDir)[2u];
    if (_e353 == 0f) {
        local_2 = 100000000f;
    } else {
        let _e356 = tuning.cloudVoxelSize;
        let _e358 = (*rayDir)[2u];
        local_2 = abs((_e356 / _e358));
    }
    let _e361 = local_2;
    tDelta = vec3<f32>(_e341, _e351, _e361);
    let _e363 = startPos;
    let _e365 = tuning.cloudVoxelSize;
    let _e368 = cellPos;
    fracPos = ((_e363 / vec3(_e365)) - vec3<f32>(_e368));
    let _e371 = (*tEnter);
    let _e373 = stepDir[0u];
    if (_e373 > 0i) {
        let _e376 = fracPos[0u];
        let _e379 = tDelta[0u];
        local_3 = ((1f - _e376) * _e379);
    } else {
        let _e382 = fracPos[0u];
        let _e384 = tDelta[0u];
        local_3 = (_e382 * _e384);
    }
    let _e386 = local_3;
    let _e388 = stepDir[1u];
    if (_e388 > 0i) {
        let _e391 = fracPos[1u];
        let _e394 = tDelta[1u];
        local_4 = ((1f - _e391) * _e394);
    } else {
        let _e397 = fracPos[1u];
        let _e399 = tDelta[1u];
        local_4 = (_e397 * _e399);
    }
    let _e401 = local_4;
    let _e403 = stepDir[2u];
    if (_e403 > 0i) {
        let _e406 = fracPos[2u];
        let _e409 = tDelta[2u];
        local_5 = ((1f - _e406) * _e409);
    } else {
        let _e412 = fracPos[2u];
        let _e414 = tDelta[2u];
        local_5 = (_e412 * _e414);
    }
    let _e416 = local_5;
    tMax = (vec3(_e371) + vec3<f32>(_e386, _e401, _e416));
    normal = vec3<f32>(0f, 1f, 0f);
    let _e420 = (*tEnter);
    t = _e420;
    let _e422 = tuning.cloudVoxelSize;
    spread_1 = max(1i, i32(_e422));
    i = 0i;
    loop {
        let _e425 = i;
        let _e427 = tuning.maxCloudSteps;
        if (_e425 < bitcast<i32>(_e427)) {
            let _e430 = t;
            let _e431 = (*tExit);
            if (_e430 > _e431) {
                break;
            }
            let _e433 = cellPos;
            let _e438 = tuning.cloudVoxelSize;
            cellCenter = ((vec3<f32>(_e433) + vec3(0.5f)) * _e438);
            let _e441 = cellCenter[0u];
            cx = i32(floor(_e441));
            let _e445 = cellCenter[2u];
            cz = i32(floor(_e445));
            let _e448 = cx;
            let _e449 = (_e448 >= 0i);
            phi_2737_ = _e449;
            if _e449 {
                let _e450 = cx;
                let _e452 = tuning.gridWidth;
                phi_2737_ = (_e450 < bitcast<i32>(_e452));
            }
            let _e456 = phi_2737_;
            let _e457 = cz;
            let _e459 = (_e456 && (_e457 >= 0i));
            phi_2748_ = _e459;
            if _e459 {
                let _e460 = cz;
                let _e462 = tuning.gridDepth;
                phi_2748_ = (_e460 < bitcast<i32>(_e462));
            }
            let _e466 = phi_2748_;
            if _e466 {
                let _e467 = cx;
                param_22 = _e467;
                let _e468 = cz;
                param_23 = _e468;
                let _e469 = spread_1;
                param_24 = _e469;
                smoothedCloudColumn_u0028_i1_u003b_i1_u003b_i1_u003b_f1_u003b_f1_u003b((&param_22), (&param_23), (&param_24), (&param_25), (&param_26));
                let _e470 = param_25;
                count_2 = _e470;
                let _e471 = param_26;
                baseY = _e471;
                let _e472 = count_2;
                if (_e472 > 0f) {
                    let _e475 = tuning.cloudVoxelSize;
                    cell = max(_e475, 0.5f);
                    let _e477 = count_2;
                    let _e479 = tuning.cloudThicknessPerBlock;
                    thickness = (_e477 * max(_e479, 0.01f));
                    let _e482 = baseY;
                    let _e483 = cell;
                    let _e486 = cell;
                    baseY = (floor((_e482 / _e483)) * _e486);
                    let _e488 = baseY;
                    let _e489 = thickness;
                    let _e490 = cell;
                    let _e494 = cell;
                    capY = (_e488 + (max(floor((_e489 / _e490)), 1f) * _e494));
                    let _e498 = cellCenter[1u];
                    let _e499 = baseY;
                    let _e500 = (_e498 >= _e499);
                    phi_2805_ = _e500;
                    if _e500 {
                        let _e502 = cellCenter[1u];
                        let _e503 = capY;
                        phi_2805_ = (_e502 <= _e503);
                    }
                    let _e506 = phi_2805_;
                    if _e506 {
                        let _e507 = count_2;
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
                        param_27 = vec3<f32>(_e533);
                        let _e535 = hash_u0028_vf3_u003b((&param_27));
                        fillHash = _e535;
                        let _e536 = fillHash;
                        let _e537 = threshold;
                        if (_e536 > _e537) {
                            let _e539 = t;
                            (*tHit) = _e539;
                            let _e540 = density;
                            (*hitDensity) = _e540;
                            let _e541 = cellPos;
                            param_28 = ((vec3<f32>(_e541) * 3.71f) + vec3<f32>(91f, 5f, 7f));
                            let _e545 = hash_u0028_vf3_u003b((&param_28));
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

    let _e267 = (*normal_1);
    let _e268 = (*rayDir_1);
    rim = (1f - abs(dot(_e267, _e268)));
    let _e272 = rim;
    glow = pow(clamp(_e272, 0f, 1f), 4f);
    let _e275 = glow;
    return mix(vec3<f32>(0.01f, 0.01f, 0.02f), vec3<f32>(0.85f, 0.45f, 1f), vec3((_e275 * 0.7f)));
}

fn bhDecode_u0028_u1_u003b(code: ptr<function, u32>) -> vec3<i32> {
    var i_1: u32;

    let _e265 = (*code);
    i_1 = (_e265 & 1073741823u);
    let _e267 = i_1;
    let _e269 = tuning.gridWidth;
    let _e274 = i_1;
    let _e276 = tuning.gridWidth;
    let _e281 = tuning.gridHeight;
    let _e286 = i_1;
    let _e288 = tuning.gridWidth;
    let _e291 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e267 % bitcast<u32>(bitcast<i32>(_e269)))), bitcast<i32>(((_e274 / bitcast<u32>(bitcast<i32>(_e276))) % bitcast<u32>(bitcast<i32>(_e281)))), bitcast<i32>((_e286 / bitcast<u32>((bitcast<i32>(_e288) * bitcast<i32>(_e291))))));
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e264 = (*level);
    return (f32(_e264) + 0.5f);
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
        let _e269 = l;
        let _e271 = tuning.blackHoleMaxLevel;
        if (_e269 <= min(_e271, 16u)) {
            let _e274 = l;
            param_29 = _e274;
            let _e275 = bhBodyRadius_u0028_u1_u003b((&param_29));
            r = _e275;
            let _e276 = r;
            let _e278 = r;
            let _e280 = r;
            volume = (((4.18879f * _e276) * _e278) * _e280);
            let _e282 = (*mass);
            let _e285 = tuning.blackHoleGrowthCost;
            let _e286 = volume;
            if (f32(_e282) < (_e285 * _e286)) {
                break;
            }
            let _e289 = l;
            level_1 = _e289;
            continue;
        } else {
            break;
        }
        continuing {
            let _e290 = l;
            l = (_e290 + bitcast<u32>(1i));
        }
    }
    let _e293 = level_1;
    return _e293;
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
    var phi_2268_: bool;
    var phi_2297_: bool;

    let _e276 = unnamed.blackHoleCount;
    let _e277 = (_e276 == 0u);
    phi_2268_ = _e277;
    if !(_e277) {
        let _e280 = tuning.blackHoleGlow;
        phi_2268_ = (_e280 <= 0f);
    }
    let _e283 = phi_2268_;
    if _e283 {
        let _e284 = (*color);
        return _e284;
    }
    let _e286 = tuning.blackHoleRadius;
    radius = f32(_e286);
    let _e288 = radius;
    let _e289 = radius;
    closestSq = (_e288 * _e289);
    seen = 0u;
    i_2 = 0i;
    loop {
        let _e291 = i_2;
        let _e292 = (_e291 < 8i);
        phi_2297_ = _e292;
        if _e292 {
            let _e293 = seen;
            let _e295 = unnamed.blackHoleCount;
            phi_2297_ = (_e293 < _e295);
        }
        let _e298 = phi_2297_;
        if _e298 {
            let _e299 = i_2;
            let _e302 = unnamed.blackHoles[_e299];
            code_1 = _e302;
            let _e303 = code_1;
            if (_e303 == 0u) {
                continue;
            }
            let _e305 = seen;
            seen = (_e305 + bitcast<u32>(1i));
            let _e308 = code_1;
            param_30 = _e308;
            let _e309 = bhDecode_u0028_u1_u003b((&param_30));
            let _e310 = (*voxelPos);
            d_1 = vec3<f32>((_e309 - _e310));
            let _e313 = closestSq;
            let _e314 = d_1;
            let _e315 = d_1;
            closestSq = min(_e313, dot(_e314, _e315));
            continue;
        } else {
            break;
        }
        continuing {
            let _e318 = i_2;
            i_2 = (_e318 + 1i);
        }
    }
    let _e320 = closestSq;
    let _e321 = radius;
    let _e322 = radius;
    if (_e320 >= (_e321 * _e322)) {
        let _e325 = (*color);
        return _e325;
    }
    let _e326 = closestSq;
    closest = sqrt(_e326);
    let _e328 = closest;
    let _e329 = radius;
    let _e334 = tuning.blackHoleGlow;
    heat = (pow((1f - (_e328 / _e329)), 3f) * _e334);
    let _e336 = heat;
    hot = mix(vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(1f, 0.95f, 0.85f), vec3(clamp(_e336, 0f, 1f)));
    let _e340 = (*color);
    let _e341 = hot;
    let _e342 = heat;
    return mix(_e340, _e341, vec3(clamp(_e342, 0f, 1f)));
}

fn renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b(rawVoxel: ptr<function, u32>, voxelPos_1: ptr<function, vec3<i32>>, baseLighting: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n: f32;
    var param_31: vec3<f32>;
    var dist: u32;
    var depth: f32;
    var inner: vec3<f32>;
    var outer: vec3<f32>;
    var leaf: vec3<f32>;

    let _e273 = (*voxelPos_1);
    param_31 = vec3<f32>(_e273);
    let _e275 = hash_u0028_vf3_u003b((&param_31));
    n = _e275;
    let _e276 = (*rawVoxel);
    dist = ((_e276 >> bitcast<u32>(24i)) & 255u);
    let _e280 = dist;
    if (_e280 == 255u) {
        let _e282 = n;
        let _e285 = (*baseLighting);
        return (mix(vec3<f32>(0.34f, 0.22f, 0.07f), vec3<f32>(0.52f, 0.38f, 0.12f), vec3(_e282)) * _e285);
    }
    let _e287 = dist;
    let _e290 = tuning.treeLeafReach;
    depth = clamp((f32(_e287) / max(f32(_e290), 1f)), 0f, 1f);
    inner = vec3<f32>(0.1f, 0.3f, 0.09f);
    outer = vec3<f32>(0.28f, 0.52f, 0.16f);
    let _e295 = inner;
    let _e296 = outer;
    let _e297 = depth;
    let _e299 = n;
    leaf = mix(_e295, _e296, vec3(((_e297 * 0.7f) + (_e299 * 0.3f))));
    let _e304 = leaf;
    let _e305 = (*baseLighting);
    return (_e304 * _e305);
}

fn renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_2: ptr<function, vec3<i32>>, subCell: ptr<function, vec3<f32>>, baseLighting_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var grain: f32;
    var param_32: vec3<f32>;
    var bark: vec3<f32>;

    let _e270 = (*voxelPos_2)[0u];
    let _e273 = (*voxelPos_2)[1u];
    let _e277 = (*subCell)[1u];
    let _e281 = (*voxelPos_2)[2u];
    param_32 = vec3<f32>(f32(_e270), ((f32(_e273) * 0.35f) + (_e277 * 0.2f)), f32(_e281));
    let _e284 = hash_u0028_vf3_u003b((&param_32));
    grain = _e284;
    let _e285 = grain;
    bark = mix(vec3<f32>(0.2f, 0.13f, 0.07f), vec3<f32>(0.38f, 0.25f, 0.13f), vec3(_e285));
    let _e288 = bark;
    let _e289 = (*baseLighting_1);
    return (_e288 * _e289);
}

fn renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_3: ptr<function, vec3<i32>>, subCell_1: ptr<function, vec3<f32>>, baseLighting_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_1: f32;
    var param_33: vec3<f32>;
    var shell: vec3<f32>;

    let _e269 = (*subCell_1);
    let _e271 = (*voxelPos_3);
    param_33 = ((_e269 * 1.37f) + (vec3<f32>(_e271) * 0.11f));
    let _e275 = hash_u0028_vf3_u003b((&param_33));
    n_1 = _e275;
    let _e276 = n_1;
    shell = mix(vec3<f32>(0.15f, 0.1f, 0.035f), vec3<f32>(0.55f, 0.4f, 0.11f), vec3(_e276));
    let _e279 = shell;
    let _e280 = (*baseLighting_2);
    return (_e279 * _e280);
}

fn renderDarkStone_u0028_vi3_u003b_vf3_u003b(voxelPos_4: ptr<function, vec3<i32>>, baseLighting_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise: f32;
    var param_34: vec3<f32>;
    var val: f32;

    let _e268 = (*voxelPos_4);
    param_34 = vec3<f32>(_e268);
    let _e270 = hash_u0028_vf3_u003b((&param_34));
    noise = _e270;
    let _e271 = noise;
    val = (0.1f + (_e271 * 0.06f));
    let _e274 = val;
    let _e276 = val;
    let _e278 = val;
    let _e281 = (*baseLighting_3);
    return (vec3<f32>((_e274 * 1.08f), (_e276 * 0.94f), (_e278 * 0.92f)) * _e281);
}

fn lavaStageColor_u0028_i1_u003b(stage: ptr<function, i32>) -> vec3<f32> {
    var indexable: array<vec3<f32>, 6>;

    let _e265 = (*stage);
    indexable = array<vec3<f32>, 6>(vec3<f32>(1f, 0.62f, 0.22f), vec3<f32>(1f, 0.4f, 0.07f), vec3<f32>(0.96f, 0.29f, 0.05f), vec3<f32>(0.86f, 0.2f, 0.04f), vec3<f32>(0.7f, 0.13f, 0.03f), vec3<f32>(0.44f, 0.07f, 0.02f));
    let _e269 = indexable[clamp((_e265 + 1i), 0i, 5i)];
    return _e269;
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

    let _e279 = (*rawVoxel_1);
    stage_1 = clamp((bitcast<i32>((_e279 & 255u)) - 8i), 0i, 3i);
    let _e285 = pc.time;
    let _e287 = tuning.lavaChurnRate;
    let _e289 = (*voxelPos_5);
    param_35 = vec3<f32>(_e289);
    let _e291 = hash_u0028_vf3_u003b((&param_35));
    phase = fract(((_e285 * _e287) + _e291));
    let _e294 = phase;
    if (_e294 < 0.33333334f) {
        let _e296 = stage_1;
        param_36 = (_e296 - 1i);
        let _e298 = lavaStageColor_u0028_i1_u003b((&param_36));
        from_ = _e298;
        let _e299 = stage_1;
        param_37 = _e299;
        let _e300 = lavaStageColor_u0028_i1_u003b((&param_37));
        to = _e300;
        let _e301 = phase;
        leg = (_e301 * 3f);
    } else {
        let _e303 = phase;
        if (_e303 < 0.6666667f) {
            let _e305 = stage_1;
            param_38 = _e305;
            let _e306 = lavaStageColor_u0028_i1_u003b((&param_38));
            from_ = _e306;
            let _e307 = stage_1;
            param_39 = (_e307 + 1i);
            let _e309 = lavaStageColor_u0028_i1_u003b((&param_39));
            to = _e309;
            let _e310 = phase;
            leg = ((_e310 * 3f) - 1f);
        } else {
            let _e313 = stage_1;
            param_40 = (_e313 + 1i);
            let _e315 = lavaStageColor_u0028_i1_u003b((&param_40));
            from_ = _e315;
            let _e316 = stage_1;
            param_41 = (_e316 - 1i);
            let _e318 = lavaStageColor_u0028_i1_u003b((&param_41));
            to = _e318;
            let _e319 = phase;
            leg = ((_e319 * 3f) - 2f);
        }
    }
    let _e322 = from_;
    let _e323 = to;
    let _e324 = leg;
    molten = mix(_e322, _e323, vec3(smoothstep(0f, 1f, _e324)));
    let _e328 = molten;
    let _e329 = (*voxelPos_5);
    param_42 = (vec3<f32>(_e329) * 1.7f);
    let _e332 = hash_u0028_vf3_u003b((&param_42));
    return (_e328 * (0.9f + (_e332 * 0.1f)));
}

fn renderSteam_u0028_vi3_u003b_vf3_u003b(voxelPos_6: ptr<function, vec3<i32>>, baseLighting_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_1: f32;
    var param_43: vec3<f32>;
    var val_1: f32;
    var baseColor_1: vec3<f32>;

    let _e269 = (*voxelPos_6);
    let _e272 = pc.time;
    param_43 = (vec3<f32>(_e269) + vec3(_e272));
    let _e275 = hash_u0028_vf3_u003b((&param_43));
    noise_1 = _e275;
    let _e276 = noise_1;
    val_1 = (0.85f + (_e276 * 0.15f));
    let _e279 = val_1;
    baseColor_1 = vec3(_e279);
    let _e281 = baseColor_1;
    let _e282 = (*baseLighting_4);
    return ((_e281 * _e282) * 0.9f);
}

fn renderFire_u0028_u1_u003b_vi3_u003b(rawVoxel_2: ptr<function, u32>, voxelPos_7: ptr<function, vec3<i32>>) -> vec3<f32> {
    var noise_2: f32;
    var param_44: vec3<f32>;
    var age: u32;
    var life: f32;
    var coreColor: vec3<f32>;
    var edgeColor: vec3<f32>;
    var fireColor: vec3<f32>;

    let _e272 = (*voxelPos_7);
    let _e275 = pc.time;
    param_44 = (vec3<f32>(_e272) + vec3((_e275 * 10f)));
    let _e279 = hash_u0028_vf3_u003b((&param_44));
    noise_2 = _e279;
    let _e280 = (*rawVoxel_2);
    age = ((_e280 >> bitcast<u32>(24i)) & 255u);
    let _e284 = age;
    life = clamp((f32(_e284) / 30f), 0f, 1f);
    coreColor = vec3<f32>(1f, 0.9f, 0.2f);
    edgeColor = vec3<f32>(1f, 0.3f, 0f);
    let _e288 = coreColor;
    let _e289 = edgeColor;
    let _e290 = life;
    let _e291 = noise_2;
    fireColor = mix(_e288, _e289, vec3((_e290 + (_e291 * 0.3f))));
    let _e296 = fireColor;
    return (_e296 * 1.5f);
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

    let _e279 = (*voxelPos_8);
    param_45 = vec3<f32>(_e279);
    let _e281 = hash_u0028_vf3_u003b((&param_45));
    noise_3 = _e281;
    let _e282 = noise_3;
    val_2 = (0.8f + (_e282 * 0.2f));
    let _e285 = (*rawVoxel_3);
    moisture = ((_e285 >> bitcast<u32>(24i)) & 255u);
    let _e289 = moisture;
    wetness = clamp((f32(_e289) / 30f), 0f, 1f);
    let _e293 = val_2;
    let _e295 = val_2;
    let _e297 = val_2;
    dryColor = vec3<f32>((0.4f * _e293), (0.25f * _e295), (0.1f * _e297));
    let _e300 = val_2;
    let _e302 = val_2;
    let _e304 = val_2;
    wetColor = vec3<f32>((0.15f * _e300), (0.08f * _e302), (0.03f * _e304));
    let _e307 = dryColor;
    let _e308 = wetColor;
    let _e309 = wetness;
    baseColor_2 = mix(_e307, _e308, vec3(_e309));
    let _e312 = (*rawVoxel_3);
    floraState = ((_e312 >> bitcast<u32>(8i)) & 255u);
    let _e316 = floraState;
    let _e317 = (_e316 > 10u);
    phi_1269_ = _e317;
    if _e317 {
        let _e319 = (*ddaNormal)[1u];
        phi_1269_ = (_e319 > 0.5f);
    }
    let _e322 = phi_1269_;
    if _e322 {
        let _e323 = floraState;
        grassGrow = clamp((f32((_e323 - 10u)) / 90f), 0f, 1f);
        let _e328 = noise_3;
        let _e331 = noise_3;
        grassColor = vec3<f32>((0.15f + (_e328 * 0.1f)), (0.45f + (_e331 * 0.15f)), 0.15f);
        let _e335 = floraState;
        if (_e335 > 100u) {
            let _e337 = floraState;
            drown = clamp((f32((_e337 - 100u)) / 100f), 0f, 1f);
            let _e342 = grassColor;
            let _e343 = drown;
            grassColor = mix(_e342, vec3<f32>(0.35f, 0.35f, 0.15f), vec3(_e343));
        }
        let _e346 = baseColor_2;
        let _e347 = grassColor;
        let _e348 = grassGrow;
        baseColor_2 = mix(_e346, _e347, vec3(_e348));
    }
    let _e351 = baseColor_2;
    let _e352 = (*baseLighting_5);
    return (_e351 * _e352);
}

fn renderStone_u0028_vi3_u003b_vf3_u003b(voxelPos_9: ptr<function, vec3<i32>>, baseLighting_6: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_4: f32;
    var param_46: vec3<f32>;
    var val_3: f32;
    var baseColor_3: vec3<f32>;

    let _e269 = (*voxelPos_9);
    param_46 = vec3<f32>(_e269);
    let _e271 = hash_u0028_vf3_u003b((&param_46));
    noise_4 = _e271;
    let _e272 = noise_4;
    val_3 = (0.4f + (_e272 * 0.3f));
    let _e275 = val_3;
    baseColor_3 = vec3(_e275);
    let _e277 = baseColor_3;
    let _e278 = (*baseLighting_6);
    return (_e277 * _e278);
}

fn renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b(voxelPos_10: ptr<function, vec3<i32>>, normal_2: ptr<function, vec3<f32>>, rayOrigin_1: ptr<function, vec3<f32>>, sunDir_1: ptr<function, vec3<f32>>, sunColor: ptr<function, vec3<f32>>, shadow: ptr<function, f32>, baseLighting_7: ptr<function, vec3<f32>>) -> vec3<f32> {
    var baseColor_4: vec3<f32>;
    var viewDir: vec3<f32>;
    var reflectDir: vec3<f32>;
    var spec: f32;
    var finalLighting: vec3<f32>;

    baseColor_4 = vec3<f32>(0.1f, 0.4f, 0.9f);
    let _e275 = (*rayOrigin_1);
    let _e276 = (*voxelPos_10);
    viewDir = normalize((_e275 - vec3<f32>(_e276)));
    let _e280 = (*sunDir_1);
    let _e282 = (*normal_2);
    reflectDir = reflect(-(_e280), _e282);
    let _e284 = viewDir;
    let _e285 = reflectDir;
    spec = pow(max(dot(_e284, _e285), 0f), 32f);
    let _e289 = (*baseLighting_7);
    let _e290 = (*sunColor);
    let _e291 = spec;
    let _e294 = (*shadow);
    finalLighting = (_e289 + (((_e290 * _e291) * 0.5f) * _e294));
    let _e297 = baseColor_4;
    let _e298 = finalLighting;
    return (_e297 * _e298);
}

fn renderSand_u0028_u1_u003b_vf3_u003b(rawVoxel_4: ptr<function, u32>, baseLighting_8: ptr<function, vec3<f32>>) -> vec3<f32> {
    var moisture_1: u32;
    var wetness_1: f32;
    var dryColor_1: vec3<f32>;
    var wetColor_1: vec3<f32>;
    var baseColor_5: vec3<f32>;

    let _e270 = (*rawVoxel_4);
    moisture_1 = ((_e270 >> bitcast<u32>(24i)) & 255u);
    let _e274 = moisture_1;
    wetness_1 = clamp((f32(_e274) / 10f), 0f, 1f);
    dryColor_1 = vec3<f32>(0.9f, 0.8f, 0.2f);
    wetColor_1 = vec3<f32>(0.65f, 0.55f, 0.15f);
    let _e278 = dryColor_1;
    let _e279 = wetColor_1;
    let _e280 = wetness_1;
    baseColor_5 = mix(_e278, _e279, vec3(_e280));
    let _e283 = baseColor_5;
    let _e284 = (*baseLighting_8);
    return (_e283 * _e284);
}

fn getVoxel_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    var index: u32;
    var phi_284_: bool;
    var phi_292_: bool;
    var phi_302_: bool;
    var phi_310_: bool;
    var phi_320_: bool;

    let _e266 = (*pos)[0u];
    let _e267 = (_e266 < 0i);
    phi_284_ = _e267;
    if !(_e267) {
        let _e270 = (*pos)[0u];
        let _e272 = tuning.gridWidth;
        phi_284_ = (_e270 >= bitcast<i32>(_e272));
    }
    let _e276 = phi_284_;
    phi_292_ = _e276;
    if !(_e276) {
        let _e279 = (*pos)[1u];
        phi_292_ = (_e279 < 0i);
    }
    let _e282 = phi_292_;
    phi_302_ = _e282;
    if !(_e282) {
        let _e285 = (*pos)[1u];
        let _e287 = tuning.gridHeight;
        phi_302_ = (_e285 >= bitcast<i32>(_e287));
    }
    let _e291 = phi_302_;
    phi_310_ = _e291;
    if !(_e291) {
        let _e294 = (*pos)[2u];
        phi_310_ = (_e294 < 0i);
    }
    let _e297 = phi_310_;
    phi_320_ = _e297;
    if !(_e297) {
        let _e300 = (*pos)[2u];
        let _e302 = tuning.gridDepth;
        phi_320_ = (_e300 >= bitcast<i32>(_e302));
    }
    let _e306 = phi_320_;
    if _e306 {
        return 0u;
    }
    let _e308 = (*pos)[0u];
    let _e310 = (*pos)[1u];
    let _e312 = tuning.gridWidth;
    let _e317 = (*pos)[2u];
    let _e319 = tuning.gridWidth;
    let _e323 = tuning.gridHeight;
    index = bitcast<u32>(((_e308 + (_e310 * bitcast<i32>(_e312))) + ((_e317 * bitcast<i32>(_e319)) * bitcast<i32>(_e323))));
    let _e328 = index;
    let _e331 = unnamed_1.grid[_e328];
    return _e331;
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

    let _e278 = (*hitVoxelPos);
    let _e279 = (*hitNormal);
    voxelPos_11 = (_e278 + vec3<i32>(round(_e279)));
    let _e283 = (*lightDir);
    stepDir_1 = vec3<i32>(sign(_e283));
    let _e287 = (*lightDir)[0u];
    if (_e287 == 0f) {
        local_6 = 100000000f;
    } else {
        let _e290 = (*lightDir)[0u];
        local_6 = abs((1f / _e290));
    }
    let _e293 = local_6;
    let _e295 = (*lightDir)[1u];
    if (_e295 == 0f) {
        local_7 = 100000000f;
    } else {
        let _e298 = (*lightDir)[1u];
        local_7 = abs((1f / _e298));
    }
    let _e301 = local_7;
    let _e303 = (*lightDir)[2u];
    if (_e303 == 0f) {
        local_8 = 100000000f;
    } else {
        let _e306 = (*lightDir)[2u];
        local_8 = abs((1f / _e306));
    }
    let _e309 = local_8;
    tDelta_1 = vec3<f32>(_e293, _e301, _e309);
    let _e311 = tDelta_1;
    tMax_1 = (_e311 * 0.5f);
    transmittance = 1f;
    i_3 = 0i;
    loop {
        let _e313 = i_3;
        let _e315 = tuning.shadowMaxSteps;
        if (_e313 < bitcast<i32>(_e315)) {
            let _e319 = voxelPos_11[0u];
            let _e320 = (_e319 < 0i);
            phi_601_ = _e320;
            if !(_e320) {
                let _e323 = voxelPos_11[0u];
                let _e325 = tuning.gridWidth;
                phi_601_ = (_e323 >= bitcast<i32>(_e325));
            }
            let _e329 = phi_601_;
            phi_608_ = _e329;
            if !(_e329) {
                let _e332 = voxelPos_11[1u];
                phi_608_ = (_e332 < 0i);
            }
            let _e335 = phi_608_;
            phi_616_ = _e335;
            if !(_e335) {
                let _e338 = voxelPos_11[1u];
                let _e339 = (*ceilingY);
                phi_616_ = (_e338 >= _e339);
            }
            let _e342 = phi_616_;
            phi_623_ = _e342;
            if !(_e342) {
                let _e345 = voxelPos_11[2u];
                phi_623_ = (_e345 < 0i);
            }
            let _e348 = phi_623_;
            phi_633_ = _e348;
            if !(_e348) {
                let _e351 = voxelPos_11[2u];
                let _e353 = tuning.gridDepth;
                phi_633_ = (_e351 >= bitcast<i32>(_e353));
            }
            let _e357 = phi_633_;
            if _e357 {
                let _e358 = transmittance;
                return _e358;
            }
            let _e359 = voxelPos_11;
            param_47 = _e359;
            let _e360 = getVoxel_u0028_vi3_u003b((&param_47));
            blockerType = (_e360 & 255u);
            let _e362 = blockerType;
            if (_e362 == 2u) {
                let _e365 = tuning.waterShadowTransmit;
                let _e366 = transmittance;
                transmittance = (_e366 * _e365);
                let _e368 = transmittance;
                if (_e368 < 0.02f) {
                    return 0f;
                }
            } else {
                let _e370 = blockerType;
                if (_e370 != 0u) {
                    return 0f;
                }
            }
            let _e373 = tMax_1[0u];
            let _e375 = tMax_1[1u];
            if (_e373 < _e375) {
                let _e378 = tMax_1[0u];
                let _e380 = tMax_1[2u];
                if (_e378 < _e380) {
                    let _e383 = stepDir_1[0u];
                    let _e385 = voxelPos_11[0u];
                    voxelPos_11[0u] = (_e385 + _e383);
                    let _e389 = tDelta_1[0u];
                    let _e391 = tMax_1[0u];
                    tMax_1[0u] = (_e391 + _e389);
                } else {
                    let _e395 = stepDir_1[2u];
                    let _e397 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e397 + _e395);
                    let _e401 = tDelta_1[2u];
                    let _e403 = tMax_1[2u];
                    tMax_1[2u] = (_e403 + _e401);
                }
            } else {
                let _e407 = tMax_1[1u];
                let _e409 = tMax_1[2u];
                if (_e407 < _e409) {
                    let _e412 = stepDir_1[1u];
                    let _e414 = voxelPos_11[1u];
                    voxelPos_11[1u] = (_e414 + _e412);
                    let _e418 = tDelta_1[1u];
                    let _e420 = tMax_1[1u];
                    tMax_1[1u] = (_e420 + _e418);
                } else {
                    let _e424 = stepDir_1[2u];
                    let _e426 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e426 + _e424);
                    let _e430 = tDelta_1[2u];
                    let _e432 = tMax_1[2u];
                    tMax_1[2u] = (_e432 + _e430);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e435 = i_3;
            i_3 = (_e435 + 1i);
        }
    }
    let _e437 = transmittance;
    return _e437;
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
        let _e270 = x_3;
        if (_e270 <= 1i) {
            y = -1i;
            loop {
                let _e272 = y;
                if (_e272 <= 1i) {
                    z_3 = -1i;
                    loop {
                        let _e274 = z_3;
                        if (_e274 <= 1i) {
                            let _e276 = x_3;
                            let _e278 = y;
                            let _e281 = z_3;
                            if (((_e276 == 0i) && (_e278 == 0i)) && (_e281 == 0i)) {
                                continue;
                            }
                            let _e284 = (*p_1);
                            let _e285 = x_3;
                            let _e286 = y;
                            let _e287 = z_3;
                            param_48 = (_e284 + vec3<i32>(_e285, _e286, _e287));
                            let _e290 = getVoxel_u0028_vi3_u003b((&param_48));
                            if ((_e290 & 255u) == 0u) {
                                continue;
                            }
                            let _e293 = x_3;
                            let _e295 = y;
                            let _e297 = z_3;
                            offset = vec3<f32>(f32(_e293), f32(_e295), f32(_e297));
                            let _e300 = offset;
                            let _e301 = x_3;
                            let _e302 = x_3;
                            let _e304 = y;
                            let _e305 = y;
                            let _e308 = z_3;
                            let _e309 = z_3;
                            let _e315 = n_2;
                            n_2 = (_e315 - (_e300 * inverseSqrt(f32((((_e301 * _e302) + (_e304 * _e305)) + (_e308 * _e309))))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e317 = z_3;
                            z_3 = (_e317 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e319 = y;
                    y = (_e319 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e321 = x_3;
            x_3 = (_e321 + 1i);
        }
    }
    let _e323 = n_2;
    if (length(_e323) < 0.1f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e326 = n_2;
    return normalize(_e326);
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

    let _e279 = tuning.waterWaveScale;
    scale = max(_e279, 0.001f);
    let _e281 = (*t_1);
    let _e283 = tuning.waterWaveSpeed;
    wt = ((_e281 * _e283) * 0.35f);
    let _e286 = (*p_2);
    let _e288 = (*p_2)[1u];
    let _e290 = wt;
    let _e294 = (*p_2)[0u];
    let _e296 = wt;
    q = (_e286 + (vec2<f32>(sin(((_e288 * 0.043f) + _e290)), sin(((_e294 * 0.037f) - (_e296 * 0.8f)))) * 6f));
    grad = vec2<f32>(0f, 0f);
    i_4 = 0i;
    loop {
        let _e303 = i_4;
        if (_e303 < 5i) {
            let _e305 = i_4;
            indexable_1 = array<f32, 5>(0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
            let _e307 = indexable_1[_e305];
            let _e308 = scale;
            f = (_e307 * _e308);
            let _e310 = i_4;
            indexable_2 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e312 = indexable_2[_e310];
            let _e313 = q;
            let _e315 = f;
            let _e317 = (*t_1);
            let _e318 = i_4;
            indexable_3 = array<f32, 5>(1f, 1.37f, 0.83f, 1.71f, 0.61f);
            let _e320 = indexable_3[_e318];
            let _e323 = tuning.waterWaveSpeed;
            phase_1 = ((dot(_e312, _e313) * _e315) + ((_e317 * _e320) * _e323));
            let _e326 = i_4;
            indexable_4 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e328 = indexable_4[_e326];
            let _e329 = i_4;
            indexable_5 = array<f32, 5>(1f, 0.62f, 0.38f, 0.24f, 0.15f);
            let _e331 = indexable_5[_e329];
            let _e332 = f;
            let _e334 = phase_1;
            let _e338 = grad;
            grad = (_e338 + (_e328 * ((_e331 * _e332) * cos(_e334))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e340 = i_4;
            i_4 = (_e340 + 1i);
        }
    }
    let _e343 = (*p_2)[0u];
    let _e346 = (*p_2)[1u];
    let _e349 = (*t_1);
    envelope = (0.45f + (0.55f * sin((((_e343 * 0.021f) + (_e346 * 0.017f)) + (_e349 * 0.11f)))));
    let _e355 = grad;
    let _e356 = envelope;
    return (_e355 * _e356);
}

fn applyWaterWaves_u0028_vf3_u003b_vi3_u003b(normal_3: ptr<function, vec3<f32>>, voxelPos_12: ptr<function, vec3<i32>>) -> vec3<f32> {
    var upness: f32;
    var grad_1: vec2<f32>;
    var param_49: vec2<f32>;
    var param_50: f32;

    let _e270 = tuning.waterWaveStrength;
    if (_e270 <= 0f) {
        let _e272 = (*normal_3);
        return _e272;
    }
    let _e274 = (*normal_3)[1u];
    upness = clamp(_e274, 0f, 1f);
    let _e276 = upness;
    if (_e276 <= 0f) {
        let _e278 = (*normal_3);
        return _e278;
    }
    let _e279 = (*voxelPos_12);
    param_49 = (vec2<f32>(_e279.xz) + vec2<f32>(0.5f, 0.5f));
    let _e284 = pc.time;
    param_50 = _e284;
    let _e285 = waterWaveGradient_u0028_vf2_u003b_f1_u003b((&param_49), (&param_50));
    grad_1 = _e285;
    let _e286 = (*normal_3);
    let _e288 = grad_1[0u];
    let _e291 = grad_1[1u];
    let _e295 = tuning.waterWaveStrength;
    let _e297 = upness;
    return normalize((_e286 + ((vec3<f32>(-(_e288), 0f, -(_e291)) * _e295) * _e297)));
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
        let _e270 = x_4;
        if (_e270 <= 2i) {
            y_1 = -2i;
            loop {
                let _e272 = y_1;
                if (_e272 <= 2i) {
                    z_4 = -2i;
                    loop {
                        let _e274 = z_4;
                        if (_e274 <= 2i) {
                            let _e276 = x_4;
                            let _e278 = y_1;
                            let _e281 = z_4;
                            if (((_e276 == 0i) && (_e278 == 0i)) && (_e281 == 0i)) {
                                continue;
                            }
                            let _e284 = x_4;
                            let _e285 = x_4;
                            let _e287 = y_1;
                            let _e288 = y_1;
                            let _e291 = z_4;
                            let _e292 = z_4;
                            d2_ = (((_e284 * _e285) + (_e287 * _e288)) + (_e291 * _e292));
                            let _e295 = d2_;
                            if (_e295 > 6i) {
                                continue;
                            }
                            let _e297 = (*p_3);
                            let _e298 = x_4;
                            let _e299 = y_1;
                            let _e300 = z_4;
                            param_51 = (_e297 + vec3<i32>(_e298, _e299, _e300));
                            let _e303 = getVoxel_u0028_vi3_u003b((&param_51));
                            if ((_e303 & 255u) == 0u) {
                                continue;
                            }
                            let _e306 = x_4;
                            let _e308 = y_1;
                            let _e310 = z_4;
                            let _e313 = d2_;
                            let _e317 = n_3;
                            n_3 = (_e317 - (vec3<f32>(f32(_e306), f32(_e308), f32(_e310)) / vec3(f32(_e313))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e319 = z_4;
                            z_4 = (_e319 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e321 = y_1;
                    y_1 = (_e321 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e323 = x_4;
            x_4 = (_e323 + 1i);
        }
    }
    let _e325 = n_3;
    if (length(_e325) < 0.001f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e328 = n_3;
    return normalize(_e328);
}

fn locustDensity_u0028_u1_u003b(type_38: ptr<function, u32>) -> f32 {
    var stage_2: f32;

    let _e265 = (*type_38);
    stage_2 = (f32((_e265 - 13u)) / 4f);
    let _e270 = tuning.locustDensityMin;
    let _e272 = tuning.locustDensityMax;
    let _e273 = stage_2;
    return clamp(mix(_e270, _e272, _e273), 0.02f, 0.98f);
}

fn trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b(voxelPos_13: ptr<function, vec3<i32>>, a: ptr<function, vec2<f32>>, b_1: ptr<function, vec2<f32>>, count_3: ptr<function, i32>) {
    var h0_: f32;
    var param_52: vec3<f32>;
    var h1_: f32;
    var param_53: vec3<f32>;
    var h2_: f32;
    var param_54: vec3<f32>;

    let _e274 = (*voxelPos_13)[0u];
    let _e277 = (*voxelPos_13)[2u];
    param_52 = vec3<f32>(f32(_e274), 7f, f32(_e277));
    let _e280 = hash_u0028_vf3_u003b((&param_52));
    h0_ = _e280;
    let _e282 = (*voxelPos_13)[0u];
    let _e285 = (*voxelPos_13)[2u];
    param_53 = vec3<f32>(f32(_e282), 19f, f32(_e285));
    let _e288 = hash_u0028_vf3_u003b((&param_53));
    h1_ = _e288;
    let _e290 = (*voxelPos_13)[0u];
    let _e293 = (*voxelPos_13)[2u];
    param_54 = vec3<f32>(f32(_e290), 53f, f32(_e293));
    let _e296 = hash_u0028_vf3_u003b((&param_54));
    h2_ = _e296;
    let _e297 = h2_;
    let _e299 = tuning.treeTrunkColumns;
    (*count_3) = (1i + i32((_e297 * f32(max(bitcast<i32>(_e299), 1i)))));
    let _e306 = (*count_3);
    (*count_3) = clamp(_e306, 1i, 2i);
    let _e308 = h0_;
    let _e311 = h1_;
    (*a) = vec2<f32>((0.3f + (_e308 * 0.4f)), (0.3f + (_e311 * 0.4f)));
    let _e315 = h1_;
    let _e318 = h0_;
    (*b_1) = vec2<f32>((0.3f + (_e315 * 0.4f)), (0.3f + (_e318 * 0.4f)));
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

    let _e280 = (*kind);
    if (_e280 == 1u) {
        let _e282 = (*cell_1);
        let _e287 = (*sub);
        p_4 = ((vec2<f32>(_e282.xz) + vec2(0.5f)) / vec2(f32(_e287)));
        let _e291 = (*voxelPos_14);
        param_55 = _e291;
        trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b((&param_55), (&param_56), (&param_57), (&param_58));
        let _e292 = param_56;
        a_1 = _e292;
        let _e293 = param_57;
        b_2 = _e293;
        let _e294 = param_58;
        count_4 = _e294;
        let _e296 = tuning.treeTrunkRadius;
        r_1 = max(_e296, 0.02f);
        let _e298 = p_4;
        let _e299 = a_1;
        let _e301 = p_4;
        let _e302 = a_1;
        let _e305 = r_1;
        let _e306 = r_1;
        if (dot((_e298 - _e299), (_e301 - _e302)) <= (_e305 * _e306)) {
            return true;
        }
        let _e309 = count_4;
        let _e310 = (_e309 > 1i);
        phi_1635_ = _e310;
        if _e310 {
            let _e311 = p_4;
            let _e312 = b_2;
            let _e314 = p_4;
            let _e315 = b_2;
            let _e318 = r_1;
            let _e319 = r_1;
            phi_1635_ = (dot((_e311 - _e312), (_e314 - _e315)) <= (_e318 * _e319));
        }
        let _e323 = phi_1635_;
        if _e323 {
            return true;
        }
        return false;
    }
    let _e324 = (*voxelPos_14);
    let _e325 = (*sub);
    let _e328 = (*cell_1);
    let _e331 = (*jitter);
    param_59 = (vec3<f32>(((_e324 * vec3(_e325)) + _e328)) + _e331);
    let _e333 = hash_u0028_vf3_u003b((&param_59));
    let _e334 = (*type_39);
    param_60 = _e334;
    let _e335 = locustDensity_u0028_u1_u003b((&param_60));
    return (_e333 < _e335);
}

fn intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b(ro: ptr<function, vec3<f32>>, rd: ptr<function, vec3<f32>>, boxMin: ptr<function, vec3<f32>>, boxMax: ptr<function, vec3<f32>>) -> vec2<f32> {
    var tMin: vec3<f32>;
    var tMax_2: vec3<f32>;
    var t1_: vec3<f32>;
    var t2_: vec3<f32>;
    var tNear: f32;
    var tFar: f32;

    let _e273 = (*boxMin);
    let _e274 = (*ro);
    let _e276 = (*rd);
    tMin = ((_e273 - _e274) / _e276);
    let _e278 = (*boxMax);
    let _e279 = (*ro);
    let _e281 = (*rd);
    tMax_2 = ((_e278 - _e279) / _e281);
    let _e283 = tMin;
    let _e284 = tMax_2;
    t1_ = min(_e283, _e284);
    let _e286 = tMin;
    let _e287 = tMax_2;
    t2_ = max(_e286, _e287);
    let _e290 = t1_[0u];
    let _e292 = t1_[1u];
    let _e295 = t1_[2u];
    tNear = max(max(_e290, _e292), _e295);
    let _e298 = t2_[0u];
    let _e300 = t2_[1u];
    let _e303 = t2_[2u];
    tFar = min(min(_e298, _e300), _e303);
    let _e305 = tNear;
    let _e306 = tFar;
    return vec2<f32>(_e305, _e306);
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
    let _e302 = (*entryNormal);
    (*subNormal) = _e302;
    (*subCell_2) = vec3<f32>(0f, 0f, 0f);
    let _e304 = tuning.locustSubdivision;
    sub_1 = clamp(bitcast<i32>(_e304), 1i, 8i);
    let _e307 = sub_1;
    cellSize = (1f / f32(_e307));
    let _e310 = (*voxelPos_15);
    boxMin_1 = vec3<f32>(_e310);
    let _e312 = boxMin_1;
    let _e314 = (*rayOrigin_2);
    param_61 = _e314;
    let _e315 = (*rayDir_2);
    param_62 = _e315;
    let _e316 = boxMin_1;
    param_63 = _e316;
    param_64 = (_e312 + vec3<f32>(1f, 1f, 1f));
    let _e317 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_61), (&param_62), (&param_63), (&param_64));
    span = _e317;
    let _e319 = span[0u];
    t_2 = max(_e319, 0f);
    let _e321 = t_2;
    let _e323 = span[1u];
    if (_e321 > _e323) {
        return false;
    }
    let _e325 = (*rayOrigin_2);
    let _e326 = (*rayDir_2);
    let _e327 = t_2;
    let _e331 = boxMin_1;
    let _e333 = sub_1;
    local_9 = (((_e325 + (_e326 * (_e327 + 0.0001f))) - _e331) * f32(_e333));
    let _e336 = local_9;
    let _e339 = sub_1;
    c = clamp(vec3<i32>(floor(_e336)), vec3<i32>(0i, 0i, 0i), vec3((_e339 - 1i)));
    let _e343 = (*rayDir_2);
    stepDir_2 = vec3<i32>(sign(_e343));
    let _e347 = (*rayDir_2)[0u];
    if (_e347 == 0f) {
        local_10 = 1000000f;
    } else {
        let _e349 = cellSize;
        let _e351 = (*rayDir_2)[0u];
        local_10 = abs((_e349 / _e351));
    }
    let _e354 = local_10;
    let _e356 = (*rayDir_2)[1u];
    if (_e356 == 0f) {
        local_11 = 1000000f;
    } else {
        let _e358 = cellSize;
        let _e360 = (*rayDir_2)[1u];
        local_11 = abs((_e358 / _e360));
    }
    let _e363 = local_11;
    let _e365 = (*rayDir_2)[2u];
    if (_e365 == 0f) {
        local_12 = 1000000f;
    } else {
        let _e367 = cellSize;
        let _e369 = (*rayDir_2)[2u];
        local_12 = abs((_e367 / _e369));
    }
    let _e372 = local_12;
    tDelta_2 = vec3<f32>(_e354, _e363, _e372);
    let _e374 = local_9;
    let _e375 = c;
    fracPos_1 = (_e374 - vec3<f32>(_e375));
    let _e378 = t_2;
    let _e380 = stepDir_2[0u];
    if (_e380 > 0i) {
        let _e383 = fracPos_1[0u];
        let _e386 = tDelta_2[0u];
        local_13 = ((1f - _e383) * _e386);
    } else {
        let _e389 = fracPos_1[0u];
        let _e391 = tDelta_2[0u];
        local_13 = (_e389 * _e391);
    }
    let _e393 = local_13;
    let _e395 = stepDir_2[1u];
    if (_e395 > 0i) {
        let _e398 = fracPos_1[1u];
        let _e401 = tDelta_2[1u];
        local_14 = ((1f - _e398) * _e401);
    } else {
        let _e404 = fracPos_1[1u];
        let _e406 = tDelta_2[1u];
        local_14 = (_e404 * _e406);
    }
    let _e408 = local_14;
    let _e410 = stepDir_2[2u];
    if (_e410 > 0i) {
        let _e413 = fracPos_1[2u];
        let _e416 = tDelta_2[2u];
        local_15 = ((1f - _e413) * _e416);
    } else {
        let _e419 = fracPos_1[2u];
        let _e421 = tDelta_2[2u];
        local_15 = (_e419 * _e421);
    }
    let _e423 = local_15;
    tMax_3 = (vec3(_e378) + vec3<f32>(_e393, _e408, _e423));
    let _e427 = (*kind_1);
    if (_e427 == 0u) {
        let _e430 = pc.time;
        let _e432 = tuning.locustCrawlRate;
        local_16 = vec3((floor((_e430 * _e432)) * 1.7f));
    } else {
        local_16 = vec3<f32>(0f, 0f, 0f);
    }
    let _e437 = local_16;
    jitter_1 = _e437;
    i_5 = 0i;
    loop {
        let _e438 = i_5;
        let _e439 = sub_1;
        if (_e438 < (3i * _e439)) {
            let _e443 = c[0u];
            let _e444 = (_e443 < 0i);
            phi_1867_ = _e444;
            if !(_e444) {
                let _e447 = c[0u];
                let _e448 = sub_1;
                phi_1867_ = (_e447 >= _e448);
            }
            let _e451 = phi_1867_;
            phi_1874_ = _e451;
            if !(_e451) {
                let _e454 = c[1u];
                phi_1874_ = (_e454 < 0i);
            }
            let _e457 = phi_1874_;
            phi_1882_ = _e457;
            if !(_e457) {
                let _e460 = c[1u];
                let _e461 = sub_1;
                phi_1882_ = (_e460 >= _e461);
            }
            let _e464 = phi_1882_;
            phi_1889_ = _e464;
            if !(_e464) {
                let _e467 = c[2u];
                phi_1889_ = (_e467 < 0i);
            }
            let _e470 = phi_1889_;
            phi_1897_ = _e470;
            if !(_e470) {
                let _e473 = c[2u];
                let _e474 = sub_1;
                phi_1897_ = (_e473 >= _e474);
            }
            let _e477 = phi_1897_;
            if _e477 {
                return false;
            }
            let _e478 = (*kind_1);
            param_65 = _e478;
            let _e479 = (*type_40);
            param_66 = _e479;
            let _e480 = (*voxelPos_15);
            param_67 = _e480;
            let _e481 = c;
            param_68 = _e481;
            let _e482 = sub_1;
            param_69 = _e482;
            let _e483 = jitter_1;
            param_70 = _e483;
            let _e484 = subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b((&param_65), (&param_66), (&param_67), (&param_68), (&param_69), (&param_70));
            if _e484 {
                let _e485 = t_2;
                (*tHit_1) = _e485;
                let _e486 = c;
                (*subCell_2) = vec3<f32>(_e486);
                return true;
            }
            let _e489 = tMax_3[0u];
            let _e491 = tMax_3[1u];
            if (_e489 < _e491) {
                let _e494 = tMax_3[0u];
                let _e496 = tMax_3[2u];
                if (_e494 < _e496) {
                    let _e499 = stepDir_2[0u];
                    let _e501 = c[0u];
                    c[0u] = (_e501 + _e499);
                    let _e505 = tMax_3[0u];
                    t_2 = _e505;
                    let _e507 = tDelta_2[0u];
                    let _e509 = tMax_3[0u];
                    tMax_3[0u] = (_e509 + _e507);
                    let _e513 = stepDir_2[0u];
                    (*subNormal) = vec3<f32>(f32(-(_e513)), 0f, 0f);
                } else {
                    let _e518 = stepDir_2[2u];
                    let _e520 = c[2u];
                    c[2u] = (_e520 + _e518);
                    let _e524 = tMax_3[2u];
                    t_2 = _e524;
                    let _e526 = tDelta_2[2u];
                    let _e528 = tMax_3[2u];
                    tMax_3[2u] = (_e528 + _e526);
                    let _e532 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e532)));
                }
            } else {
                let _e537 = tMax_3[1u];
                let _e539 = tMax_3[2u];
                if (_e537 < _e539) {
                    let _e542 = stepDir_2[1u];
                    let _e544 = c[1u];
                    c[1u] = (_e544 + _e542);
                    let _e548 = tMax_3[1u];
                    t_2 = _e548;
                    let _e550 = tDelta_2[1u];
                    let _e552 = tMax_3[1u];
                    tMax_3[1u] = (_e552 + _e550);
                    let _e556 = stepDir_2[1u];
                    (*subNormal) = vec3<f32>(0f, f32(-(_e556)), 0f);
                } else {
                    let _e561 = stepDir_2[2u];
                    let _e563 = c[2u];
                    c[2u] = (_e563 + _e561);
                    let _e567 = tMax_3[2u];
                    t_2 = _e567;
                    let _e569 = tDelta_2[2u];
                    let _e571 = tMax_3[2u];
                    tMax_3[2u] = (_e571 + _e569);
                    let _e575 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e575)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e579 = i_5;
            i_5 = (_e579 + 1i);
        }
    }
    return false;
}

fn isLocustType_u0028_u1_u003b(type_41: ptr<function, u32>) -> bool {
    let _e264 = (*type_41);
    let _e266 = (*type_41);
    return ((_e264 >= 13u) && (_e266 <= 17u));
}

fn marchCeiling_u0028_() -> i32 {
    let _e264 = tuning.gridHeight;
    let _e267 = unnamed.maxOccupiedY;
    return min(bitcast<i32>(_e264), (bitcast<i32>(_e267) + 2i));
}

fn worldExtent_u0028_() -> vec3<f32> {
    let _e264 = tuning.gridWidth;
    let _e268 = tuning.gridHeight;
    let _e272 = tuning.gridDepth;
    return vec3<f32>(f32(bitcast<i32>(_e264)), f32(bitcast<i32>(_e268)), f32(bitcast<i32>(_e272)));
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
    let _e267 = worldExtent_u0028_();
    extent = _e267;
    let _e269 = (*p_5)[0u];
    let _e270 = thickness_1;
    let _e271 = (_e269 < _e270);
    phi_476_ = _e271;
    if !(_e271) {
        let _e274 = (*p_5)[0u];
        let _e276 = extent[0u];
        let _e277 = thickness_1;
        phi_476_ = (_e274 > (_e276 - _e277));
    }
    let _e281 = phi_476_;
    if _e281 {
        let _e282 = boundCount;
        boundCount = (_e282 + 1i);
    }
    let _e285 = (*p_5)[1u];
    let _e286 = thickness_1;
    let _e287 = (_e285 < _e286);
    phi_495_ = _e287;
    if !(_e287) {
        let _e290 = (*p_5)[1u];
        let _e292 = extent[1u];
        let _e293 = thickness_1;
        phi_495_ = (_e290 > (_e292 - _e293));
    }
    let _e297 = phi_495_;
    if _e297 {
        let _e298 = boundCount;
        boundCount = (_e298 + 1i);
    }
    let _e301 = (*p_5)[2u];
    let _e302 = thickness_1;
    let _e303 = (_e301 < _e302);
    phi_514_ = _e303;
    if !(_e303) {
        let _e306 = (*p_5)[2u];
        let _e308 = extent[2u];
        let _e309 = thickness_1;
        phi_514_ = (_e306 > (_e308 - _e309));
    }
    let _e313 = phi_514_;
    if _e313 {
        let _e314 = boundCount;
        boundCount = (_e314 + 1i);
    }
    let _e316 = boundCount;
    return (_e316 >= 2i);
}

fn rot_u0028_f1_u003b(a_2: ptr<function, f32>) -> mat2x2<f32> {
    var s: f32;
    var c_1: f32;

    let _e266 = (*a_2);
    s = sin(_e266);
    let _e268 = (*a_2);
    c_1 = cos(_e268);
    let _e270 = c_1;
    let _e271 = s;
    let _e273 = s;
    let _e274 = c_1;
    return mat2x2<f32>(vec2<f32>(_e270, -(_e271)), vec2<f32>(_e273, _e274));
}

fn applyCameraRotation_u0028_vf3_u003b(v: ptr<function, vec3<f32>>) -> vec3<f32> {
    var param_71: f32;
    var param_72: f32;

    let _e267 = pc.pitch;
    param_71 = _e267;
    let _e268 = rot_u0028_f1_u003b((&param_71));
    let _e269 = (*v);
    let _e271 = (_e269.yz * _e268);
    (*v)[1u] = _e271.x;
    (*v)[2u] = _e271.y;
    let _e277 = pc.yaw;
    param_72 = _e277;
    let _e278 = rot_u0028_f1_u003b((&param_72));
    let _e279 = (*v);
    let _e281 = (_e279.xz * _e278);
    (*v)[0u] = _e281.x;
    (*v)[2u] = _e281.y;
    let _e286 = (*v);
    return _e286;
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
    var phi_3132_: bool;
    var phi_3148_: bool;
    var phi_3376_: bool;
    var phi_3383_: bool;
    var phi_3391_: bool;
    var phi_3398_: bool;
    var phi_3408_: bool;
    var phi_3896_: bool;
    var phi_4215_: bool;
    var phi_4222_: bool;
    var phi_4231_: bool;
    var phi_4237_: bool;
    var phi_4246_: bool;
    var phi_4456_: bool;
    var phi_4498_: bool;
    var phi_4520_: bool;
    var phi_4542_: bool;
    var phi_4570_: bool;
    var phi_4592_: bool;
    var phi_4614_: bool;

    let _e477 = inUV_1;
    screenSpace = ((_e477 * 2f) - vec2(1f));
    let _e482 = screenSpace[1u];
    screenSpace[1u] = -(_e482);
    let _e486 = pc.aspectScaleX;
    let _e488 = screenSpace[0u];
    screenSpace[0u] = (_e488 * _e486);
    let _e492 = pc.aspectScaleY;
    let _e494 = screenSpace[1u];
    screenSpace[1u] = (_e494 * _e492);
    let _e498 = pc.camX;
    let _e500 = pc.camY;
    let _e502 = pc.camZ;
    baseOrigin = vec3<f32>(_e498, _e500, _e502);
    param_73 = vec3<f32>(0f, 0f, 1f);
    let _e504 = applyCameraRotation_u0028_vf3_u003b((&param_73));
    forward = _e504;
    param_74 = vec3<f32>(1f, 0f, 0f);
    let _e505 = applyCameraRotation_u0028_vf3_u003b((&param_74));
    right = _e505;
    param_75 = vec3<f32>(0f, 1f, 0f);
    let _e506 = applyCameraRotation_u0028_vf3_u003b((&param_75));
    up = _e506;
    let _e508 = pc.perspectiveBlend;
    t_3 = clamp(_e508, 0f, 1f);
    let _e510 = worldExtent_u0028_();
    cubeCenter = (_e510 * 0.5f);
    let _e512 = cubeCenter;
    let _e513 = baseOrigin;
    let _e515 = forward;
    viewDistance = max(1f, dot((_e512 - _e513), _e515));
    let _e518 = viewDistance;
    let _e520 = pc.fovDistance;
    orthoHalfSize = (_e518 / _e520);
    let _e523 = screenSpace[0u];
    let _e525 = screenSpace[1u];
    let _e527 = pc.fovDistance;
    let _e529 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e523, _e525, _e527), vec3(_e529));
    let _e532 = right;
    let _e534 = localDir[0u];
    let _e536 = up;
    let _e538 = localDir[1u];
    let _e541 = forward;
    let _e543 = localDir[2u];
    rayDir_3 = normalize((((_e532 * _e534) + (_e536 * _e538)) + (_e541 * _e543)));
    let _e547 = right;
    let _e549 = screenSpace[0u];
    let _e551 = up;
    let _e553 = screenSpace[1u];
    let _e556 = orthoHalfSize;
    let _e558 = t_3;
    originOffset = ((((_e547 * _e549) + (_e551 * _e553)) * _e556) * (1f - _e558));
    let _e561 = baseOrigin;
    let _e562 = originOffset;
    rayOrigin_3 = (_e561 + _e562);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e564 = worldExtent_u0028_();
    let _e565 = rayOrigin_3;
    param_76 = _e565;
    let _e566 = rayDir_3;
    param_77 = _e566;
    param_78 = vec3<f32>(0f, 0f, 0f);
    param_79 = _e564;
    let _e567 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_76), (&param_77), (&param_78), (&param_79));
    aabbHit = _e567;
    hitFrontBox = false;
    hitBackBox = false;
    let _e569 = aabbHit[0u];
    let _e571 = aabbHit[1u];
    let _e572 = (_e569 < _e571);
    phi_3132_ = _e572;
    if _e572 {
        let _e574 = aabbHit[1u];
        phi_3132_ = (_e574 > 0f);
    }
    let _e577 = phi_3132_;
    if _e577 {
        let _e579 = aabbHit[0u];
        let _e580 = (_e579 > 0f);
        phi_3148_ = _e580;
        if _e580 {
            let _e581 = rayOrigin_3;
            let _e582 = rayDir_3;
            let _e584 = aabbHit[0u];
            param_80 = (_e581 + (_e582 * _e584));
            let _e587 = isEdge_u0028_vf3_u003b((&param_80));
            phi_3148_ = _e587;
        }
        let _e589 = phi_3148_;
        if _e589 {
            hitFrontBox = true;
        }
        let _e590 = rayOrigin_3;
        let _e591 = rayDir_3;
        let _e593 = aabbHit[1u];
        param_81 = (_e590 + (_e591 * _e593));
        let _e596 = isEdge_u0028_vf3_u003b((&param_81));
        if _e596 {
            hitBackBox = true;
        }
    }
    let _e598 = pc.showCloudBlocks;
    if (_e598 != 0i) {
        let _e601 = tuning.gridHeight;
        local_17 = bitcast<i32>(_e601);
    } else {
        let _e603 = marchCeiling_u0028_();
        local_17 = _e603;
    }
    let _e604 = local_17;
    ceilingY_1 = _e604;
    let _e606 = tuning.gridWidth;
    let _e609 = ceilingY_1;
    let _e612 = tuning.gridDepth;
    let _e616 = rayOrigin_3;
    param_82 = _e616;
    let _e617 = rayDir_3;
    param_83 = _e617;
    param_84 = vec3<f32>(0f, 0f, 0f);
    param_85 = vec3<f32>(f32(bitcast<i32>(_e606)), f32(_e609), f32(bitcast<i32>(_e612)));
    let _e618 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_82), (&param_83), (&param_84), (&param_85));
    marchHit = _e618;
    let _e619 = rayOrigin_3;
    let _e620 = rayDir_3;
    let _e622 = marchHit[0u];
    currentPos = (_e619 + (_e620 * max(0f, _e622)));
    let _e627 = marchHit[0u];
    if (_e627 > 0f) {
        let _e629 = rayDir_3;
        let _e631 = currentPos;
        currentPos = (_e631 + (_e629 * 0.001f));
    }
    let _e633 = currentPos;
    voxelPos_16 = vec3<i32>(floor(_e633));
    let _e636 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e636));
    let _e640 = rayDir_3[0u];
    if (_e640 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e643 = rayDir_3[0u];
        local_18 = abs((1f / _e643));
    }
    let _e646 = local_18;
    let _e648 = rayDir_3[1u];
    if (_e648 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e651 = rayDir_3[1u];
        local_19 = abs((1f / _e651));
    }
    let _e654 = local_19;
    let _e656 = rayDir_3[2u];
    if (_e656 == 0f) {
        local_20 = 100000000f;
    } else {
        let _e659 = rayDir_3[2u];
        local_20 = abs((1f / _e659));
    }
    let _e662 = local_20;
    tDelta_3 = vec3<f32>(_e646, _e654, _e662);
    let _e665 = stepDir_3[0u];
    if (_e665 > 0i) {
        let _e668 = currentPos[0u];
        let _e672 = currentPos[0u];
        let _e675 = tDelta_3[0u];
        local_21 = (((floor(_e668) + 1f) - _e672) * _e675);
    } else {
        let _e678 = currentPos[0u];
        let _e680 = currentPos[0u];
        let _e684 = tDelta_3[0u];
        local_21 = ((_e678 - floor(_e680)) * _e684);
    }
    let _e686 = local_21;
    let _e688 = stepDir_3[1u];
    if (_e688 > 0i) {
        let _e691 = currentPos[1u];
        let _e695 = currentPos[1u];
        let _e698 = tDelta_3[1u];
        local_22 = (((floor(_e691) + 1f) - _e695) * _e698);
    } else {
        let _e701 = currentPos[1u];
        let _e703 = currentPos[1u];
        let _e707 = tDelta_3[1u];
        local_22 = ((_e701 - floor(_e703)) * _e707);
    }
    let _e709 = local_22;
    let _e711 = stepDir_3[2u];
    if (_e711 > 0i) {
        let _e714 = currentPos[2u];
        let _e718 = currentPos[2u];
        let _e721 = tDelta_3[2u];
        local_23 = (((floor(_e714) + 1f) - _e718) * _e721);
    } else {
        let _e724 = currentPos[2u];
        let _e726 = currentPos[2u];
        let _e730 = tDelta_3[2u];
        local_23 = ((_e724 - floor(_e726)) * _e730);
    }
    let _e732 = local_23;
    tMax_4 = vec3<f32>(_e686, _e709, _e732);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e735 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e735 * 1.5f));
    i_6 = 0i;
    loop {
        let _e738 = i_6;
        let _e740 = tuning.marchMaxSteps;
        if (_e738 < bitcast<i32>(_e740)) {
            let _e744 = voxelPos_16[0u];
            let _e745 = (_e744 < 0i);
            phi_3376_ = _e745;
            if !(_e745) {
                let _e748 = voxelPos_16[0u];
                let _e750 = tuning.gridWidth;
                phi_3376_ = (_e748 >= bitcast<i32>(_e750));
            }
            let _e754 = phi_3376_;
            phi_3383_ = _e754;
            if !(_e754) {
                let _e757 = voxelPos_16[1u];
                phi_3383_ = (_e757 < 0i);
            }
            let _e760 = phi_3383_;
            phi_3391_ = _e760;
            if !(_e760) {
                let _e763 = voxelPos_16[1u];
                let _e764 = ceilingY_1;
                phi_3391_ = (_e763 >= _e764);
            }
            let _e767 = phi_3391_;
            phi_3398_ = _e767;
            if !(_e767) {
                let _e770 = voxelPos_16[2u];
                phi_3398_ = (_e770 < 0i);
            }
            let _e773 = phi_3398_;
            phi_3408_ = _e773;
            if !(_e773) {
                let _e776 = voxelPos_16[2u];
                let _e778 = tuning.gridDepth;
                phi_3408_ = (_e776 >= bitcast<i32>(_e778));
            }
            let _e782 = phi_3408_;
            if _e782 {
                break;
            }
            let _e783 = voxelPos_16;
            param_86 = _e783;
            let _e784 = getVoxel_u0028_vi3_u003b((&param_86));
            rawVoxel_5 = _e784;
            let _e785 = rawVoxel_5;
            hitType = (_e785 & 255u);
            let _e788 = pc.showCloudBlocks;
            let _e790 = hitType;
            if ((_e788 != 0i) && (_e790 == 0u)) {
                let _e794 = voxelPos_16[0u];
                let _e796 = voxelPos_16[1u];
                let _e798 = tuning.gridWidth;
                let _e803 = voxelPos_16[2u];
                let _e805 = tuning.gridWidth;
                let _e809 = tuning.gridHeight;
                let _e816 = unnamed_2.cloudCells[bitcast<u32>(((_e794 + (_e796 * bitcast<i32>(_e798))) + ((_e803 * bitcast<i32>(_e805)) * bitcast<i32>(_e809))))];
                c_2 = _e816;
                let _e817 = c_2;
                if ((_e817 & 3u) != 0u) {
                    hitType = 200u;
                    let _e820 = c_2;
                    hitRawVoxel = _e820;
                    hit = true;
                    break;
                }
            }
            let _e821 = hitType;
            if (_e821 == 7u) {
                hitType = 0u;
            }
            let _e823 = hitType;
            if (_e823 != 0u) {
                let _e825 = hitType;
                if (_e825 == 6u) {
                    let _e827 = rawVoxel_5;
                    age_1 = ((_e827 >> bitcast<u32>(24i)) & 255u);
                    let _e831 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e831) / 100f), 0f, 1f));
                    let _e836 = inUV_1;
                    let _e838 = pc.time;
                    dither = fract((sin(dot((_e836 + vec2((_e838 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e846 = dither;
                    let _e847 = targetAlpha;
                    if (_e846 > _e847) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e849 = rawVoxel_5;
                        hitRawVoxel = _e849;
                        break;
                    }
                } else {
                    let _e850 = hitType;
                    param_87 = _e850;
                    let _e851 = isLocustType_u0028_u1_u003b((&param_87));
                    let _e852 = hitType;
                    if (_e851 || (_e852 == 18u)) {
                        let _e855 = hitType;
                        kind_2 = select(0u, 1u, (_e855 == 18u));
                        let _e858 = voxelPos_16;
                        param_88 = _e858;
                        let _e859 = rayOrigin_3;
                        param_89 = _e859;
                        let _e860 = rayDir_3;
                        param_90 = _e860;
                        let _e861 = kind_2;
                        param_91 = _e861;
                        let _e862 = hitType;
                        param_92 = _e862;
                        let _e863 = normal_4;
                        param_93 = _e863;
                        let _e864 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_88), (&param_89), (&param_90), (&param_91), (&param_92), (&param_93), (&param_94), (&param_95), (&param_96));
                        let _e865 = param_94;
                        subT = _e865;
                        let _e866 = param_95;
                        subNormal_1 = _e866;
                        let _e867 = param_96;
                        subCell_3 = _e867;
                        if _e864 {
                            hit = true;
                            let _e868 = rawVoxel_5;
                            hitRawVoxel = _e868;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e869 = rawVoxel_5;
                        hitRawVoxel = _e869;
                        break;
                    }
                }
            }
            let _e871 = tMax_4[0u];
            let _e873 = tMax_4[1u];
            if (_e871 < _e873) {
                let _e876 = tMax_4[0u];
                let _e878 = tMax_4[2u];
                if (_e876 < _e878) {
                    let _e881 = stepDir_3[0u];
                    let _e883 = voxelPos_16[0u];
                    voxelPos_16[0u] = (_e883 + _e881);
                    let _e887 = tDelta_3[0u];
                    let _e889 = tMax_4[0u];
                    tMax_4[0u] = (_e889 + _e887);
                    let _e893 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e893)), 0f, 0f);
                } else {
                    let _e898 = stepDir_3[2u];
                    let _e900 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e900 + _e898);
                    let _e904 = tDelta_3[2u];
                    let _e906 = tMax_4[2u];
                    tMax_4[2u] = (_e906 + _e904);
                    let _e910 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e910)));
                }
            } else {
                let _e915 = tMax_4[1u];
                let _e917 = tMax_4[2u];
                if (_e915 < _e917) {
                    let _e920 = stepDir_3[1u];
                    let _e922 = voxelPos_16[1u];
                    voxelPos_16[1u] = (_e922 + _e920);
                    let _e926 = tDelta_3[1u];
                    let _e928 = tMax_4[1u];
                    tMax_4[1u] = (_e928 + _e926);
                    let _e932 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e932)), 0f);
                } else {
                    let _e937 = stepDir_3[2u];
                    let _e939 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e939 + _e937);
                    let _e943 = tDelta_3[2u];
                    let _e945 = tMax_4[2u];
                    tMax_4[2u] = (_e945 + _e943);
                    let _e949 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e949)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e953 = i_6;
            i_6 = (_e953 + 1i);
        }
    }
    let _e955 = hit;
    if _e955 {
        let _e956 = normal_4;
        if (length(_e956) < 0.1f) {
            let _e959 = rayDir_3;
            normal_4 = -(_e959);
        }
        let _e961 = normal_4;
        ddaNormal_1 = _e961;
        let _e962 = hitType;
        if (_e962 == 2u) {
            let _e964 = voxelPos_16;
            param_97 = _e964;
            let _e965 = getWaterNormal_u0028_vi3_u003b((&param_97));
            param_98 = _e965;
            let _e966 = voxelPos_16;
            param_99 = _e966;
            let _e967 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_98), (&param_99));
            normal_4 = _e967;
        } else {
            let _e968 = hitType;
            param_100 = _e968;
            let _e969 = isLocustType_u0028_u1_u003b((&param_100));
            let _e970 = hitType;
            if (_e969 || (_e970 == 18u)) {
                let _e973 = subNormal_1;
                normal_4 = _e973;
            } else {
                let _e974 = voxelPos_16;
                param_101 = _e974;
                let _e975 = getSmoothNormal_u0028_vi3_u003b((&param_101));
                normal_4 = _e975;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e976 = normal_4;
        let _e977 = sunDir_2;
        diffuse_1 = max(dot(_e976, _e977), 0f);
        let _e980 = voxelPos_16;
        param_102 = _e980;
        let _e981 = ddaNormal_1;
        param_103 = _e981;
        let _e982 = sunDir_2;
        param_104 = _e982;
        let _e983 = ceilingY_1;
        param_105 = _e983;
        let _e984 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_102), (&param_103), (&param_104), (&param_105));
        shadow_1 = _e984;
        let _e985 = ambientColor;
        let _e986 = sunColor_1;
        let _e987 = diffuse_1;
        let _e989 = shadow_1;
        baseLighting_9 = (_e985 + ((_e986 * _e987) * _e989));
        let _e992 = baseLighting_9;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e992);
        let _e994 = hitType;
        if (_e994 == 200u) {
            calm = vec3<f32>(0.35f, 0.65f, 1f);
            rain = vec3<f32>(1f, 0.55f, 0.25f);
            let _e996 = calm;
            let _e997 = rain;
            let _e998 = hitRawVoxel;
            let _e1004 = baseLighting_9;
            finalVoxelColor = (mix(_e996, _e997, vec3(select(0f, 1f, ((_e998 & 3u) == 2u)))) * _e1004);
        }
        let _e1006 = hitType;
        switch bitcast<i32>(_e1006) {
            case 1: {
                let _e1008 = hitRawVoxel;
                param_106 = _e1008;
                let _e1009 = baseLighting_9;
                param_107 = _e1009;
                let _e1010 = renderSand_u0028_u1_u003b_vf3_u003b((&param_106), (&param_107));
                finalVoxelColor = _e1010;
                break;
            }
            case 2: {
                let _e1011 = voxelPos_16;
                param_108 = _e1011;
                let _e1012 = normal_4;
                param_109 = _e1012;
                let _e1013 = rayOrigin_3;
                param_110 = _e1013;
                let _e1014 = sunDir_2;
                param_111 = _e1014;
                let _e1015 = sunColor_1;
                param_112 = _e1015;
                let _e1016 = shadow_1;
                param_113 = _e1016;
                let _e1017 = baseLighting_9;
                param_114 = _e1017;
                let _e1018 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_108), (&param_109), (&param_110), (&param_111), (&param_112), (&param_113), (&param_114));
                finalVoxelColor = _e1018;
                break;
            }
            case 3: {
                let _e1019 = voxelPos_16;
                param_115 = _e1019;
                let _e1020 = baseLighting_9;
                param_116 = _e1020;
                let _e1021 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_115), (&param_116));
                finalVoxelColor = _e1021;
                break;
            }
            case 4: {
                let _e1022 = hitRawVoxel;
                param_117 = _e1022;
                let _e1023 = voxelPos_16;
                param_118 = _e1023;
                let _e1024 = ddaNormal_1;
                param_119 = _e1024;
                let _e1025 = baseLighting_9;
                param_120 = _e1025;
                let _e1026 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_117), (&param_118), (&param_119), (&param_120));
                finalVoxelColor = _e1026;
                break;
            }
            case 5: {
                let _e1027 = hitRawVoxel;
                param_121 = _e1027;
                let _e1028 = voxelPos_16;
                param_122 = _e1028;
                let _e1029 = renderFire_u0028_u1_u003b_vi3_u003b((&param_121), (&param_122));
                finalVoxelColor = _e1029;
                break;
            }
            case 6: {
                let _e1030 = voxelPos_16;
                param_123 = _e1030;
                let _e1031 = baseLighting_9;
                param_124 = _e1031;
                let _e1032 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_123), (&param_124));
                finalVoxelColor = _e1032;
                break;
            }
            case 9, 10, 11, 8: {
                let _e1033 = hitRawVoxel;
                param_125 = _e1033;
                let _e1034 = voxelPos_16;
                param_126 = _e1034;
                let _e1035 = renderLava_u0028_u1_u003b_vi3_u003b((&param_125), (&param_126));
                finalVoxelColor = _e1035;
                break;
            }
            case 12: {
                let _e1036 = voxelPos_16;
                param_127 = _e1036;
                let _e1037 = baseLighting_9;
                param_128 = _e1037;
                let _e1038 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_127), (&param_128));
                finalVoxelColor = _e1038;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e1039 = voxelPos_16;
                param_129 = _e1039;
                let _e1040 = subCell_3;
                param_130 = _e1040;
                let _e1041 = baseLighting_9;
                param_131 = _e1041;
                let _e1042 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_129), (&param_130), (&param_131));
                finalVoxelColor = _e1042;
                break;
            }
            case 18: {
                let _e1043 = voxelPos_16;
                param_132 = _e1043;
                let _e1044 = subCell_3;
                param_133 = _e1044;
                let _e1045 = baseLighting_9;
                param_134 = _e1045;
                let _e1046 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_132), (&param_133), (&param_134));
                finalVoxelColor = _e1046;
                break;
            }
            case 19: {
                let _e1047 = hitRawVoxel;
                param_135 = _e1047;
                let _e1048 = voxelPos_16;
                param_136 = _e1048;
                let _e1049 = baseLighting_9;
                param_137 = _e1049;
                let _e1050 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_135), (&param_136), (&param_137));
                finalVoxelColor = _e1050;
                break;
            }
            default: {
                break;
            }
        }
        let _e1051 = finalVoxelColor;
        param_138 = _e1051;
        let _e1052 = voxelPos_16;
        param_139 = _e1052;
        let _e1053 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_138), (&param_139));
        finalVoxelColor = _e1053;
        let _e1054 = hitType;
        param_140 = _e1054;
        let _e1055 = isLocustType_u0028_u1_u003b((&param_140));
        let _e1056 = hitType;
        if (_e1055 || (_e1056 == 18u)) {
            let _e1059 = subT;
            local_24 = _e1059;
        } else {
            let _e1060 = voxelPos_16;
            let _e1063 = rayOrigin_3;
            local_24 = length(((vec3<f32>(_e1060) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e1063));
        }
        let _e1066 = local_24;
        distanceTraveled = _e1066;
        let _e1067 = distanceTraveled;
        let _e1068 = MAX_VISIBILITY;
        let _e1072 = finalVoxelColor;
        finalVoxelColor = (_e1072 * mix(1f, 0f, clamp((_e1067 / _e1068), 0f, 1f)));
        let _e1074 = distanceTraveled;
        finalDist = _e1074;
        let _e1075 = finalVoxelColor;
        finalColor = vec4<f32>(_e1075.x, _e1075.y, _e1075.z, 1f);
    } else {
        let _e1080 = hitBackBox;
        if _e1080 {
            let _e1082 = aabbHit[1u];
            finalDist = _e1082;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1084 = unnamed.blackHoleCount;
    if (_e1084 > 0u) {
        seenHoles = 0u;
        i_7 = 0i;
        loop {
            let _e1086 = i_7;
            let _e1087 = (_e1086 < 8i);
            phi_3896_ = _e1087;
            if _e1087 {
                let _e1088 = seenHoles;
                let _e1090 = unnamed.blackHoleCount;
                phi_3896_ = (_e1088 < _e1090);
            }
            let _e1093 = phi_3896_;
            if _e1093 {
                let _e1094 = i_7;
                let _e1097 = unnamed.blackHoles[_e1094];
                code_2 = _e1097;
                let _e1098 = code_2;
                if (_e1098 == 0u) {
                    continue;
                }
                let _e1100 = seenHoles;
                seenHoles = (_e1100 + bitcast<u32>(1i));
                let _e1103 = code_2;
                if ((_e1103 & 1073741824u) != 0u) {
                    let _e1107 = tuning.purgeLevel;
                    let _e1109 = i_7;
                    let _e1112 = unnamed.blackHoleMass[_e1109];
                    let _e1115 = tuning.purgeMass;
                    local_25 = u32((f32(_e1107) * clamp((f32(_e1112) / f32(max(_e1115, 1u))), 0f, 1f)));
                } else {
                    let _e1122 = i_7;
                    let _e1125 = unnamed.blackHoleMass[_e1122];
                    param_141 = _e1125;
                    let _e1126 = bhLevel_u0028_u1_u003b((&param_141));
                    local_25 = _e1126;
                }
                let _e1127 = local_25;
                bodyLevel = _e1127;
                let _e1128 = bodyLevel;
                param_142 = _e1128;
                let _e1129 = bhBodyRadius_u0028_u1_u003b((&param_142));
                bodyRadius = _e1129;
                let _e1130 = code_2;
                param_143 = _e1130;
                let _e1131 = bhDecode_u0028_u1_u003b((&param_143));
                center = (vec3<f32>(_e1131) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1134 = rayOrigin_3;
                let _e1135 = center;
                oc = (_e1134 - _e1135);
                let _e1137 = oc;
                let _e1138 = rayDir_3;
                b_3 = dot(_e1137, _e1138);
                let _e1140 = oc;
                let _e1141 = oc;
                let _e1143 = bodyRadius;
                let _e1144 = bodyRadius;
                c_3 = (dot(_e1140, _e1141) - (_e1143 * _e1144));
                let _e1147 = b_3;
                let _e1148 = b_3;
                let _e1150 = c_3;
                disc = ((_e1147 * _e1148) - _e1150);
                let _e1152 = disc;
                if (_e1152 <= 0f) {
                    continue;
                }
                let _e1154 = disc;
                sq = sqrt(_e1154);
                let _e1156 = b_3;
                let _e1158 = sq;
                tNear_1 = (-(_e1156) - _e1158);
                let _e1160 = b_3;
                let _e1162 = sq;
                tFar_1 = (-(_e1160) + _e1162);
                let _e1164 = tFar_1;
                if (_e1164 <= 0f) {
                    continue;
                }
                let _e1166 = tNear_1;
                bodyDist = max(0f, _e1166);
                let _e1168 = bodyDist;
                let _e1169 = finalDist;
                if (_e1168 < _e1169) {
                    let _e1171 = rayOrigin_3;
                    let _e1172 = rayDir_3;
                    let _e1173 = bodyDist;
                    let _e1176 = center;
                    surfaceNormal = normalize(((_e1171 + (_e1172 * _e1173)) - _e1176));
                    let _e1179 = surfaceNormal;
                    param_144 = _e1179;
                    let _e1180 = rayDir_3;
                    param_145 = _e1180;
                    let _e1181 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_144), (&param_145));
                    bodyColor = _e1181;
                    let _e1182 = bodyDist;
                    let _e1183 = MAX_VISIBILITY;
                    let _e1187 = bodyColor;
                    bodyColor = (_e1187 * mix(1f, 0f, clamp((_e1182 / _e1183), 0f, 1f)));
                    let _e1189 = bodyColor;
                    finalColor = vec4<f32>(_e1189.x, _e1189.y, _e1189.z, 1f);
                    let _e1194 = bodyDist;
                    finalDist = _e1194;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1195 = i_7;
                i_7 = (_e1195 + 1i);
            }
        }
    }
    let _e1198 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1198), 0f, 1f);
    let _e1201 = charge;
    cloudGreyness = _e1201;
    let _e1203 = unnamed.rainPhase;
    if (_e1203 == 1u) {
        let _e1206 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1206);
        let _e1208 = charge;
        let _e1210 = pc.time;
        let _e1211 = crossedTime;
        let _e1214 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1208, clamp(((_e1210 - _e1211) / _e1214), 0f, 1f));
    } else {
        let _e1219 = unnamed.rainPhase;
        if (_e1219 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1222 = tuning.cloudMaxAlpha;
    if (_e1222 > 0.002f) {
        let _e1225 = tuning.cloudColumnFullCount;
        let _e1228 = tuning.cloudThicknessPerBlock;
        slabMax = (max(_e1225, 1f) * max(_e1228, 0.01f));
        let _e1232 = unnamed.cloudMaxY;
        let _e1234 = slabMax;
        bandHi = (f32(_e1232) + _e1234);
        let _e1237 = unnamed.cloudMinY;
        let _e1240 = unnamed.cloudMaxY;
        let _e1242 = slabMax;
        let _e1246 = tuning.cloudVoxelSize;
        bandLo = (max(f32(_e1237), (f32(_e1240) - _e1242)) - max(_e1246, 1f));
        let _e1250 = unnamed.cloudMinY;
        let _e1252 = unnamed.cloudMaxY;
        if (_e1250 > _e1252) {
            local_26 = vec2<f32>(1f, -1f);
        } else {
            let _e1254 = bandLo;
            let _e1256 = worldExtent_u0028_();
            let _e1258 = bandHi;
            let _e1259 = worldExtent_u0028_();
            let _e1262 = rayOrigin_3;
            param_146 = _e1262;
            let _e1263 = rayDir_3;
            param_147 = _e1263;
            param_148 = vec3<f32>(0f, _e1254, 0f);
            param_149 = vec3<f32>(_e1256.x, _e1258, _e1259.z);
            let _e1264 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_146), (&param_147), (&param_148), (&param_149));
            local_26 = _e1264;
        }
        let _e1265 = local_26;
        cloudClip = _e1265;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1267 = cloudClip[0u];
        nearT = max(_e1267, 0f);
        let _e1270 = cloudClip[1u];
        let _e1271 = finalDist;
        farT = min(_e1270, _e1271);
        let _e1273 = nearT;
        let _e1274 = farT;
        if (_e1273 < _e1274) {
            let _e1276 = rayOrigin_3;
            param_150 = _e1276;
            let _e1277 = rayDir_3;
            param_151 = _e1277;
            let _e1278 = nearT;
            param_152 = _e1278;
            let _e1279 = farT;
            param_153 = _e1279;
            let _e1280 = cloudSunDir;
            param_154 = _e1280;
            let _e1281 = cloudGreyness;
            param_155 = _e1281;
            let _e1282 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b((&param_150), (&param_151), (&param_152), (&param_153), (&param_154), (&param_155), (&param_156), (&param_157), (&param_158));
            let _e1283 = param_156;
            cloudTHit = _e1283;
            let _e1284 = param_157;
            cloudColor = _e1284;
            let _e1285 = param_158;
            cloudDensity = _e1285;
            if _e1282 {
                let _e1286 = cloudTHit;
                if (_e1286 > 0f) {
                    let _e1288 = cloudTHit;
                    bestT = _e1288;
                    let _e1289 = cloudColor;
                    bestColor = _e1289;
                    let _e1291 = tuning.cloudMinAlpha;
                    let _e1293 = tuning.cloudMaxAlpha;
                    let _e1294 = cloudDensity;
                    bestAlpha = clamp(mix(_e1291, _e1293, _e1294), 0f, 0.95f);
                    foundCloud = true;
                }
            }
        }
        let _e1297 = foundCloud;
        let _e1298 = bestT;
        let _e1299 = finalDist;
        if (_e1297 && (_e1298 < _e1299)) {
            let _e1302 = finalColor;
            let _e1304 = bestColor;
            let _e1305 = bestAlpha;
            let _e1307 = mix(_e1302.xyz, _e1304, vec3(_e1305));
            finalColor[0u] = _e1307.x;
            finalColor[1u] = _e1307.y;
            finalColor[2u] = _e1307.z;
        }
    }
    let _e1315 = pc.spawnX;
    let _e1316 = (_e1315 >= 0i);
    phi_4215_ = _e1316;
    if _e1316 {
        let _e1318 = pc.spawnX;
        let _e1320 = tuning.gridWidth;
        phi_4215_ = (_e1318 < bitcast<i32>(_e1320));
    }
    let _e1324 = phi_4215_;
    phi_4222_ = _e1324;
    if _e1324 {
        let _e1326 = pc.spawnY;
        phi_4222_ = (_e1326 >= 0i);
    }
    let _e1329 = phi_4222_;
    phi_4231_ = _e1329;
    if _e1329 {
        let _e1331 = pc.spawnY;
        let _e1333 = tuning.gridHeight;
        phi_4231_ = (_e1331 < bitcast<i32>(_e1333));
    }
    let _e1337 = phi_4231_;
    phi_4237_ = _e1337;
    if _e1337 {
        let _e1339 = pc.spawnZ;
        phi_4237_ = (_e1339 >= 0i);
    }
    let _e1342 = phi_4237_;
    phi_4246_ = _e1342;
    if _e1342 {
        let _e1344 = pc.spawnZ;
        let _e1346 = tuning.gridDepth;
        phi_4246_ = (_e1344 < bitcast<i32>(_e1346));
    }
    let _e1350 = phi_4246_;
    if _e1350 {
        let _e1352 = pc.spawnSize;
        halfDistMin = (_e1352 / 2i);
        let _e1355 = pc.spawnSize;
        halfDistMax = ((_e1355 - 1i) / 2i);
        let _e1359 = pc.spawnX;
        let _e1360 = halfDistMin;
        let _e1364 = pc.spawnY;
        let _e1365 = halfDistMin;
        let _e1369 = pc.spawnZ;
        let _e1370 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1359 - _e1360)), f32((_e1364 - _e1365)), f32((_e1369 - _e1370)));
        let _e1375 = pc.spawnX;
        let _e1376 = halfDistMax;
        let _e1381 = pc.spawnY;
        let _e1382 = halfDistMax;
        let _e1387 = pc.spawnZ;
        let _e1388 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1375 + _e1376) + 1i)), f32(((_e1381 + _e1382) + 1i)), f32(((_e1387 + _e1388) + 1i)));
        let _e1394 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1397 = indexable_6[clamp(_e1394, 0i, 19i)];
        cursorColor = _e1397;
        let _e1399 = pc.spawnShape;
        if (_e1399 == 1i) {
            let _e1401 = boxMin_2;
            let _e1402 = boxMax_1;
            sphereCenter = ((_e1401 + _e1402) * 0.5f);
            let _e1406 = pc.spawnSize;
            sphereRadius = (f32(_e1406) * 0.5f);
            let _e1409 = rayOrigin_3;
            let _e1410 = sphereCenter;
            oc_1 = (_e1409 - _e1410);
            let _e1412 = oc_1;
            let _e1413 = rayDir_3;
            b_4 = dot(_e1412, _e1413);
            let _e1415 = oc_1;
            let _e1416 = oc_1;
            let _e1418 = sphereRadius;
            let _e1419 = sphereRadius;
            c_4 = (dot(_e1415, _e1416) - (_e1418 * _e1419));
            let _e1422 = b_4;
            let _e1423 = b_4;
            let _e1425 = c_4;
            disc_1 = ((_e1422 * _e1423) - _e1425);
            let _e1427 = disc_1;
            if (_e1427 > 0f) {
                let _e1429 = disc_1;
                sq_1 = sqrt(_e1429);
                let _e1431 = b_4;
                let _e1433 = sq_1;
                tNear_2 = (-(_e1431) - _e1433);
                let _e1435 = b_4;
                let _e1437 = sq_1;
                tFar_2 = (-(_e1435) + _e1437);
                let _e1439 = tFar_2;
                if (_e1439 > 0f) {
                    let _e1441 = tNear_2;
                    inside = (_e1441 <= 0f);
                    let _e1443 = inside;
                    let _e1444 = tFar_2;
                    let _e1445 = tNear_2;
                    cursorDist = select(_e1445, _e1444, _e1443);
                    let _e1447 = rayOrigin_3;
                    let _e1448 = rayDir_3;
                    let _e1449 = cursorDist;
                    let _e1452 = sphereCenter;
                    shellNormal = normalize(((_e1447 + (_e1448 * _e1449)) - _e1452));
                    let _e1455 = shellNormal;
                    let _e1456 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1455, _e1456)));
                    let _e1460 = rim_1;
                    let _e1463 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1460)) * select(1f, 0.35f, _e1463));
                    let _e1466 = cursorDist;
                    let _e1467 = finalDist;
                    if (_e1466 < _e1467) {
                        let _e1469 = finalColor;
                        let _e1471 = cursorColor;
                        let _e1472 = alpha;
                        let _e1474 = mix(_e1469.xyz, _e1471, vec3(_e1472));
                        finalColor[0u] = _e1474.x;
                        finalColor[1u] = _e1474.y;
                        finalColor[2u] = _e1474.z;
                    }
                }
            }
        } else {
            let _e1481 = rayOrigin_3;
            param_159 = _e1481;
            let _e1482 = rayDir_3;
            param_160 = _e1482;
            let _e1483 = boxMin_2;
            param_161 = _e1483;
            let _e1484 = boxMax_1;
            param_162 = _e1484;
            let _e1485 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_159), (&param_160), (&param_161), (&param_162));
            cursorHit = _e1485;
            let _e1487 = cursorHit[0u];
            let _e1489 = cursorHit[1u];
            let _e1490 = (_e1487 < _e1489);
            phi_4456_ = _e1490;
            if _e1490 {
                let _e1492 = cursorHit[1u];
                phi_4456_ = (_e1492 > 0f);
            }
            let _e1495 = phi_4456_;
            if _e1495 {
                let _e1497 = cursorHit[0u];
                distFront = max(0f, _e1497);
                let _e1500 = cursorHit[1u];
                distBack = _e1500;
                let _e1501 = rayOrigin_3;
                let _e1502 = rayDir_3;
                let _e1503 = distFront;
                hitPosFront = (_e1501 + (_e1502 * _e1503));
                let _e1506 = rayOrigin_3;
                let _e1507 = rayDir_3;
                let _e1508 = distBack;
                hitPosBack = (_e1506 + (_e1507 * _e1508));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1512 = hitPosFront[0u];
                let _e1514 = boxMin_2[0u];
                let _e1515 = e;
                let _e1517 = (_e1512 < (_e1514 + _e1515));
                phi_4498_ = _e1517;
                if !(_e1517) {
                    let _e1520 = hitPosFront[0u];
                    let _e1522 = boxMax_1[0u];
                    let _e1523 = e;
                    phi_4498_ = (_e1520 > (_e1522 - _e1523));
                }
                let _e1527 = phi_4498_;
                if _e1527 {
                    let _e1528 = edgesFront;
                    edgesFront = (_e1528 + 1i);
                }
                let _e1531 = hitPosFront[1u];
                let _e1533 = boxMin_2[1u];
                let _e1534 = e;
                let _e1536 = (_e1531 < (_e1533 + _e1534));
                phi_4520_ = _e1536;
                if !(_e1536) {
                    let _e1539 = hitPosFront[1u];
                    let _e1541 = boxMax_1[1u];
                    let _e1542 = e;
                    phi_4520_ = (_e1539 > (_e1541 - _e1542));
                }
                let _e1546 = phi_4520_;
                if _e1546 {
                    let _e1547 = edgesFront;
                    edgesFront = (_e1547 + 1i);
                }
                let _e1550 = hitPosFront[2u];
                let _e1552 = boxMin_2[2u];
                let _e1553 = e;
                let _e1555 = (_e1550 < (_e1552 + _e1553));
                phi_4542_ = _e1555;
                if !(_e1555) {
                    let _e1558 = hitPosFront[2u];
                    let _e1560 = boxMax_1[2u];
                    let _e1561 = e;
                    phi_4542_ = (_e1558 > (_e1560 - _e1561));
                }
                let _e1565 = phi_4542_;
                if _e1565 {
                    let _e1566 = edgesFront;
                    edgesFront = (_e1566 + 1i);
                }
                let _e1568 = edgesFront;
                if (_e1568 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1571 = hitPosBack[0u];
                let _e1573 = boxMin_2[0u];
                let _e1574 = e;
                let _e1576 = (_e1571 < (_e1573 + _e1574));
                phi_4570_ = _e1576;
                if !(_e1576) {
                    let _e1579 = hitPosBack[0u];
                    let _e1581 = boxMax_1[0u];
                    let _e1582 = e;
                    phi_4570_ = (_e1579 > (_e1581 - _e1582));
                }
                let _e1586 = phi_4570_;
                if _e1586 {
                    let _e1587 = edgesBack;
                    edgesBack = (_e1587 + 1i);
                }
                let _e1590 = hitPosBack[1u];
                let _e1592 = boxMin_2[1u];
                let _e1593 = e;
                let _e1595 = (_e1590 < (_e1592 + _e1593));
                phi_4592_ = _e1595;
                if !(_e1595) {
                    let _e1598 = hitPosBack[1u];
                    let _e1600 = boxMax_1[1u];
                    let _e1601 = e;
                    phi_4592_ = (_e1598 > (_e1600 - _e1601));
                }
                let _e1605 = phi_4592_;
                if _e1605 {
                    let _e1606 = edgesBack;
                    edgesBack = (_e1606 + 1i);
                }
                let _e1609 = hitPosBack[2u];
                let _e1611 = boxMin_2[2u];
                let _e1612 = e;
                let _e1614 = (_e1609 < (_e1611 + _e1612));
                phi_4614_ = _e1614;
                if !(_e1614) {
                    let _e1617 = hitPosBack[2u];
                    let _e1619 = boxMax_1[2u];
                    let _e1620 = e;
                    phi_4614_ = (_e1617 > (_e1619 - _e1620));
                }
                let _e1624 = phi_4614_;
                if _e1624 {
                    let _e1625 = edgesBack;
                    edgesBack = (_e1625 + 1i);
                }
                let _e1627 = edgesBack;
                if (_e1627 >= 2i) {
                    onBackEdge = true;
                }
                let _e1629 = onFrontEdge;
                let _e1630 = distFront;
                let _e1631 = finalDist;
                if (_e1629 && (_e1630 < _e1631)) {
                    let _e1634 = finalColor;
                    let _e1636 = cursorColor;
                    let _e1638 = mix(_e1634.xyz, _e1636, vec3(0.9f));
                    finalColor[0u] = _e1638.x;
                    finalColor[1u] = _e1638.y;
                    finalColor[2u] = _e1638.z;
                } else {
                    let _e1645 = onBackEdge;
                    let _e1646 = distBack;
                    let _e1647 = finalDist;
                    if (_e1645 && (_e1646 < _e1647)) {
                        let _e1650 = finalColor;
                        let _e1652 = cursorColor;
                        let _e1654 = mix(_e1650.xyz, _e1652, vec3(0.2f));
                        finalColor[0u] = _e1654.x;
                        finalColor[1u] = _e1654.y;
                        finalColor[2u] = _e1654.z;
                    } else {
                        let _e1661 = distFront;
                        let _e1662 = finalDist;
                        if (_e1661 < _e1662) {
                            let _e1664 = finalColor;
                            let _e1666 = cursorColor;
                            let _e1668 = mix(_e1664.xyz, _e1666, vec3(0.15f));
                            finalColor[0u] = _e1668.x;
                            finalColor[1u] = _e1668.y;
                            finalColor[2u] = _e1668.z;
                        }
                    }
                }
            }
        }
    }
    let _e1675 = hitFrontBox;
    if _e1675 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1676 = finalColor;
    outColor = _e1676;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
