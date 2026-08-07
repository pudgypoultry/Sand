// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: c60c9b624f71a560fc695074981043eb94ef31383c9b67ea0218fc4b83ee9b2f

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
    cloudMovedCount: u32,
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
    let _e256 = (*p);
    return fract((sin(dot(_e256, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x: ptr<function, i32>, z: ptr<function, i32>) -> u32 {
    let _e257 = (*x);
    let _e258 = (*z);
    let _e260 = tuning.gridWidth;
    return (bitcast<u32>((_e257 + (_e258 * bitcast<i32>(_e260)))) * 4u);
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
    var topY: f32;
    var thickness: f32;
    var bottomY: f32;
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

    let _e300 = (*tEnter);
    (*tEnter) = max(_e300, 0f);
    let _e302 = (*tEnter);
    let _e303 = (*tExit);
    if (_e302 >= _e303) {
        return false;
    }
    let _e305 = (*rayOrigin);
    let _e306 = (*rayDir);
    let _e307 = (*tEnter);
    startPos = (_e305 + (_e306 * _e307));
    let _e310 = startPos;
    let _e312 = tuning.cloudVoxelSize;
    cellPos = vec3<i32>(floor((_e310 / vec3(_e312))));
    let _e317 = (*rayDir);
    stepDir = vec3<i32>(sign(_e317));
    let _e321 = (*rayDir)[0u];
    if (_e321 == 0f) {
        local = 100000000f;
    } else {
        let _e324 = tuning.cloudVoxelSize;
        let _e326 = (*rayDir)[0u];
        local = abs((_e324 / _e326));
    }
    let _e329 = local;
    let _e331 = (*rayDir)[1u];
    if (_e331 == 0f) {
        local_1 = 100000000f;
    } else {
        let _e334 = tuning.cloudVoxelSize;
        let _e336 = (*rayDir)[1u];
        local_1 = abs((_e334 / _e336));
    }
    let _e339 = local_1;
    let _e341 = (*rayDir)[2u];
    if (_e341 == 0f) {
        local_2 = 100000000f;
    } else {
        let _e344 = tuning.cloudVoxelSize;
        let _e346 = (*rayDir)[2u];
        local_2 = abs((_e344 / _e346));
    }
    let _e349 = local_2;
    tDelta = vec3<f32>(_e329, _e339, _e349);
    let _e351 = startPos;
    let _e353 = tuning.cloudVoxelSize;
    let _e356 = cellPos;
    fracPos = ((_e351 / vec3(_e353)) - vec3<f32>(_e356));
    let _e359 = (*tEnter);
    let _e361 = stepDir[0u];
    if (_e361 > 0i) {
        let _e364 = fracPos[0u];
        let _e367 = tDelta[0u];
        local_3 = ((1f - _e364) * _e367);
    } else {
        let _e370 = fracPos[0u];
        let _e372 = tDelta[0u];
        local_3 = (_e370 * _e372);
    }
    let _e374 = local_3;
    let _e376 = stepDir[1u];
    if (_e376 > 0i) {
        let _e379 = fracPos[1u];
        let _e382 = tDelta[1u];
        local_4 = ((1f - _e379) * _e382);
    } else {
        let _e385 = fracPos[1u];
        let _e387 = tDelta[1u];
        local_4 = (_e385 * _e387);
    }
    let _e389 = local_4;
    let _e391 = stepDir[2u];
    if (_e391 > 0i) {
        let _e394 = fracPos[2u];
        let _e397 = tDelta[2u];
        local_5 = ((1f - _e394) * _e397);
    } else {
        let _e400 = fracPos[2u];
        let _e402 = tDelta[2u];
        local_5 = (_e400 * _e402);
    }
    let _e404 = local_5;
    tMax = (vec3(_e359) + vec3<f32>(_e374, _e389, _e404));
    normal = vec3<f32>(0f, 0f, 0f);
    let _e408 = (*tEnter);
    t = _e408;
    i = 0i;
    loop {
        let _e409 = i;
        let _e411 = tuning.maxCloudSteps;
        if (_e409 < bitcast<i32>(_e411)) {
            let _e414 = t;
            let _e415 = (*tExit);
            if (_e414 > _e415) {
                break;
            }
            let _e417 = cellPos;
            let _e422 = tuning.cloudVoxelSize;
            cellCenter = ((vec3<f32>(_e417) + vec3(0.5f)) * _e422);
            let _e425 = cellCenter[0u];
            cx = i32(floor(_e425));
            let _e429 = cellCenter[2u];
            cz = i32(floor(_e429));
            let _e432 = cx;
            let _e433 = (_e432 >= 0i);
            phi_2548_ = _e433;
            if _e433 {
                let _e434 = cx;
                let _e436 = tuning.gridWidth;
                phi_2548_ = (_e434 < bitcast<i32>(_e436));
            }
            let _e440 = phi_2548_;
            let _e441 = cz;
            let _e443 = (_e440 && (_e441 >= 0i));
            phi_2559_ = _e443;
            if _e443 {
                let _e444 = cz;
                let _e446 = tuning.gridDepth;
                phi_2559_ = (_e444 < bitcast<i32>(_e446));
            }
            let _e450 = phi_2559_;
            if _e450 {
                let _e451 = cx;
                param = _e451;
                let _e452 = cz;
                param_1 = _e452;
                let _e453 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param), (&param_1));
                base = _e453;
                let _e454 = base;
                let _e458 = unnamed.cloudColumn[(_e454 + 2u)];
                count = _e458;
                let _e459 = count;
                if (_e459 > 0u) {
                    let _e461 = base;
                    let _e465 = unnamed.cloudColumn[(_e461 + 3u)];
                    topY = f32(_e465);
                    let _e467 = count;
                    let _e470 = tuning.cloudThicknessPerBlock;
                    thickness = (f32(_e467) * max(_e470, 0.01f));
                    let _e473 = topY;
                    let _e474 = thickness;
                    bottomY = (_e473 - _e474);
                    let _e477 = cellCenter[1u];
                    let _e478 = topY;
                    let _e479 = (_e477 <= _e478);
                    phi_2607_ = _e479;
                    if _e479 {
                        let _e481 = cellCenter[1u];
                        let _e482 = bottomY;
                        phi_2607_ = (_e481 >= _e482);
                    }
                    let _e485 = phi_2607_;
                    if _e485 {
                        let _e486 = count;
                        let _e489 = tuning.cloudColumnFullCount;
                        density = clamp((f32(_e486) / max(_e489, 1f)), 0f, 1f);
                        let _e493 = topY;
                        let _e494 = bottomY;
                        mid = ((_e493 + _e494) * 0.5f);
                        let _e498 = cellCenter[1u];
                        let _e499 = mid;
                        let _e502 = thickness;
                        edgeFactor = clamp((abs((_e498 - _e499)) / max((_e502 * 0.5f), 0.001f)), 0f, 1f);
                        let _e508 = tuning.cloudEdgeThresholdMin;
                        let _e510 = tuning.cloudEdgeThresholdMax;
                        let _e511 = edgeFactor;
                        threshold = mix(_e508, _e510, _e511);
                        let _e513 = threshold;
                        let _e514 = density;
                        threshold = mix(1f, _e513, _e514);
                        let _e516 = cellPos;
                        param_2 = vec3<f32>(_e516);
                        let _e518 = hash_u0028_vf3_u003b((&param_2));
                        fillHash = _e518;
                        let _e519 = fillHash;
                        let _e520 = threshold;
                        if (_e519 > _e520) {
                            let _e522 = t;
                            (*tHit) = _e522;
                            let _e523 = density;
                            (*hitDensity) = _e523;
                            let _e524 = cellPos;
                            param_3 = ((vec3<f32>(_e524) * 3.71f) + vec3<f32>(91f, 5f, 7f));
                            let _e528 = hash_u0028_vf3_u003b((&param_3));
                            shadeHash = _e528;
                            let _e529 = shadeHash;
                            baseColor = mix(vec3<f32>(0.76f, 0.76f, 0.78f), vec3<f32>(1f, 1f, 1f), vec3(_e529));
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

    let _e259 = (*normal_1);
    let _e260 = (*rayDir_1);
    rim = (1f - abs(dot(_e259, _e260)));
    let _e264 = rim;
    glow = pow(clamp(_e264, 0f, 1f), 4f);
    let _e267 = glow;
    return mix(vec3<f32>(0.01f, 0.01f, 0.02f), vec3<f32>(0.85f, 0.45f, 1f), vec3((_e267 * 0.7f)));
}

fn bhDecode_u0028_u1_u003b(code: ptr<function, u32>) -> vec3<i32> {
    var i_1: u32;

    let _e257 = (*code);
    i_1 = (_e257 & 1073741823u);
    let _e259 = i_1;
    let _e261 = tuning.gridWidth;
    let _e266 = i_1;
    let _e268 = tuning.gridWidth;
    let _e273 = tuning.gridHeight;
    let _e278 = i_1;
    let _e280 = tuning.gridWidth;
    let _e283 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e259 % bitcast<u32>(bitcast<i32>(_e261)))), bitcast<i32>(((_e266 / bitcast<u32>(bitcast<i32>(_e268))) % bitcast<u32>(bitcast<i32>(_e273)))), bitcast<i32>((_e278 / bitcast<u32>((bitcast<i32>(_e280) * bitcast<i32>(_e283))))));
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e256 = (*level);
    return (f32(_e256) + 0.5f);
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
        let _e261 = l;
        let _e263 = tuning.blackHoleMaxLevel;
        if (_e261 <= min(_e263, 16u)) {
            let _e266 = l;
            param_4 = _e266;
            let _e267 = bhBodyRadius_u0028_u1_u003b((&param_4));
            r = _e267;
            let _e268 = r;
            let _e270 = r;
            let _e272 = r;
            volume = (((4.18879f * _e268) * _e270) * _e272);
            let _e274 = (*mass);
            let _e277 = tuning.blackHoleGrowthCost;
            let _e278 = volume;
            if (f32(_e274) < (_e277 * _e278)) {
                break;
            }
            let _e281 = l;
            level_1 = _e281;
            continue;
        } else {
            break;
        }
        continuing {
            let _e282 = l;
            l = (_e282 + bitcast<u32>(1i));
        }
    }
    let _e285 = level_1;
    return _e285;
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

    let _e268 = unnamed.blackHoleCount;
    let _e269 = (_e268 == 0u);
    phi_2253_ = _e269;
    if !(_e269) {
        let _e272 = tuning.blackHoleGlow;
        phi_2253_ = (_e272 <= 0f);
    }
    let _e275 = phi_2253_;
    if _e275 {
        let _e276 = (*color);
        return _e276;
    }
    let _e278 = tuning.blackHoleRadius;
    radius = f32(_e278);
    let _e280 = radius;
    let _e281 = radius;
    closestSq = (_e280 * _e281);
    seen = 0u;
    i_2 = 0i;
    loop {
        let _e283 = i_2;
        let _e284 = (_e283 < 8i);
        phi_2282_ = _e284;
        if _e284 {
            let _e285 = seen;
            let _e287 = unnamed.blackHoleCount;
            phi_2282_ = (_e285 < _e287);
        }
        let _e290 = phi_2282_;
        if _e290 {
            let _e291 = i_2;
            let _e294 = unnamed.blackHoles[_e291];
            code_1 = _e294;
            let _e295 = code_1;
            if (_e295 == 0u) {
                continue;
            }
            let _e297 = seen;
            seen = (_e297 + bitcast<u32>(1i));
            let _e300 = code_1;
            param_5 = _e300;
            let _e301 = bhDecode_u0028_u1_u003b((&param_5));
            let _e302 = (*voxelPos);
            d = vec3<f32>((_e301 - _e302));
            let _e305 = closestSq;
            let _e306 = d;
            let _e307 = d;
            closestSq = min(_e305, dot(_e306, _e307));
            continue;
        } else {
            break;
        }
        continuing {
            let _e310 = i_2;
            i_2 = (_e310 + 1i);
        }
    }
    let _e312 = closestSq;
    let _e313 = radius;
    let _e314 = radius;
    if (_e312 >= (_e313 * _e314)) {
        let _e317 = (*color);
        return _e317;
    }
    let _e318 = closestSq;
    closest = sqrt(_e318);
    let _e320 = closest;
    let _e321 = radius;
    let _e326 = tuning.blackHoleGlow;
    heat = (pow((1f - (_e320 / _e321)), 3f) * _e326);
    let _e328 = heat;
    hot = mix(vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(1f, 0.95f, 0.85f), vec3(clamp(_e328, 0f, 1f)));
    let _e332 = (*color);
    let _e333 = hot;
    let _e334 = heat;
    return mix(_e332, _e333, vec3(clamp(_e334, 0f, 1f)));
}

fn renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b(rawVoxel: ptr<function, u32>, voxelPos_1: ptr<function, vec3<i32>>, baseLighting: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n: f32;
    var param_6: vec3<f32>;
    var dist: u32;
    var depth: f32;
    var inner: vec3<f32>;
    var outer: vec3<f32>;
    var leaf: vec3<f32>;

    let _e265 = (*voxelPos_1);
    param_6 = vec3<f32>(_e265);
    let _e267 = hash_u0028_vf3_u003b((&param_6));
    n = _e267;
    let _e268 = (*rawVoxel);
    dist = ((_e268 >> bitcast<u32>(24i)) & 255u);
    let _e272 = dist;
    if (_e272 == 255u) {
        let _e274 = n;
        let _e277 = (*baseLighting);
        return (mix(vec3<f32>(0.34f, 0.22f, 0.07f), vec3<f32>(0.52f, 0.38f, 0.12f), vec3(_e274)) * _e277);
    }
    let _e279 = dist;
    let _e282 = tuning.treeLeafReach;
    depth = clamp((f32(_e279) / max(f32(_e282), 1f)), 0f, 1f);
    inner = vec3<f32>(0.1f, 0.3f, 0.09f);
    outer = vec3<f32>(0.28f, 0.52f, 0.16f);
    let _e287 = inner;
    let _e288 = outer;
    let _e289 = depth;
    let _e291 = n;
    leaf = mix(_e287, _e288, vec3(((_e289 * 0.7f) + (_e291 * 0.3f))));
    let _e296 = leaf;
    let _e297 = (*baseLighting);
    return (_e296 * _e297);
}

fn renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_2: ptr<function, vec3<i32>>, subCell: ptr<function, vec3<f32>>, baseLighting_1: ptr<function, vec3<f32>>) -> vec3<f32> {
    var grain: f32;
    var param_7: vec3<f32>;
    var bark: vec3<f32>;

    let _e262 = (*voxelPos_2)[0u];
    let _e265 = (*voxelPos_2)[1u];
    let _e269 = (*subCell)[1u];
    let _e273 = (*voxelPos_2)[2u];
    param_7 = vec3<f32>(f32(_e262), ((f32(_e265) * 0.35f) + (_e269 * 0.2f)), f32(_e273));
    let _e276 = hash_u0028_vf3_u003b((&param_7));
    grain = _e276;
    let _e277 = grain;
    bark = mix(vec3<f32>(0.2f, 0.13f, 0.07f), vec3<f32>(0.38f, 0.25f, 0.13f), vec3(_e277));
    let _e280 = bark;
    let _e281 = (*baseLighting_1);
    return (_e280 * _e281);
}

fn renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_3: ptr<function, vec3<i32>>, subCell_1: ptr<function, vec3<f32>>, baseLighting_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_1: f32;
    var param_8: vec3<f32>;
    var shell: vec3<f32>;

    let _e261 = (*subCell_1);
    let _e263 = (*voxelPos_3);
    param_8 = ((_e261 * 1.37f) + (vec3<f32>(_e263) * 0.11f));
    let _e267 = hash_u0028_vf3_u003b((&param_8));
    n_1 = _e267;
    let _e268 = n_1;
    shell = mix(vec3<f32>(0.15f, 0.1f, 0.035f), vec3<f32>(0.55f, 0.4f, 0.11f), vec3(_e268));
    let _e271 = shell;
    let _e272 = (*baseLighting_2);
    return (_e271 * _e272);
}

fn renderDarkStone_u0028_vi3_u003b_vf3_u003b(voxelPos_4: ptr<function, vec3<i32>>, baseLighting_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise: f32;
    var param_9: vec3<f32>;
    var val: f32;

    let _e260 = (*voxelPos_4);
    param_9 = vec3<f32>(_e260);
    let _e262 = hash_u0028_vf3_u003b((&param_9));
    noise = _e262;
    let _e263 = noise;
    val = (0.1f + (_e263 * 0.06f));
    let _e266 = val;
    let _e268 = val;
    let _e270 = val;
    let _e273 = (*baseLighting_3);
    return (vec3<f32>((_e266 * 1.08f), (_e268 * 0.94f), (_e270 * 0.92f)) * _e273);
}

fn lavaStageColor_u0028_i1_u003b(stage: ptr<function, i32>) -> vec3<f32> {
    var indexable: array<vec3<f32>, 6>;

    let _e257 = (*stage);
    indexable = array<vec3<f32>, 6>(vec3<f32>(1f, 0.62f, 0.22f), vec3<f32>(1f, 0.4f, 0.07f), vec3<f32>(0.96f, 0.29f, 0.05f), vec3<f32>(0.86f, 0.2f, 0.04f), vec3<f32>(0.7f, 0.13f, 0.03f), vec3<f32>(0.44f, 0.07f, 0.02f));
    let _e261 = indexable[clamp((_e257 + 1i), 0i, 5i)];
    return _e261;
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

    let _e271 = (*rawVoxel_1);
    stage_1 = clamp((bitcast<i32>((_e271 & 255u)) - 8i), 0i, 3i);
    let _e277 = pc.time;
    let _e279 = tuning.lavaChurnRate;
    let _e281 = (*voxelPos_5);
    param_10 = vec3<f32>(_e281);
    let _e283 = hash_u0028_vf3_u003b((&param_10));
    phase = fract(((_e277 * _e279) + _e283));
    let _e286 = phase;
    if (_e286 < 0.33333334f) {
        let _e288 = stage_1;
        param_11 = (_e288 - 1i);
        let _e290 = lavaStageColor_u0028_i1_u003b((&param_11));
        from_ = _e290;
        let _e291 = stage_1;
        param_12 = _e291;
        let _e292 = lavaStageColor_u0028_i1_u003b((&param_12));
        to = _e292;
        let _e293 = phase;
        leg = (_e293 * 3f);
    } else {
        let _e295 = phase;
        if (_e295 < 0.6666667f) {
            let _e297 = stage_1;
            param_13 = _e297;
            let _e298 = lavaStageColor_u0028_i1_u003b((&param_13));
            from_ = _e298;
            let _e299 = stage_1;
            param_14 = (_e299 + 1i);
            let _e301 = lavaStageColor_u0028_i1_u003b((&param_14));
            to = _e301;
            let _e302 = phase;
            leg = ((_e302 * 3f) - 1f);
        } else {
            let _e305 = stage_1;
            param_15 = (_e305 + 1i);
            let _e307 = lavaStageColor_u0028_i1_u003b((&param_15));
            from_ = _e307;
            let _e308 = stage_1;
            param_16 = (_e308 - 1i);
            let _e310 = lavaStageColor_u0028_i1_u003b((&param_16));
            to = _e310;
            let _e311 = phase;
            leg = ((_e311 * 3f) - 2f);
        }
    }
    let _e314 = from_;
    let _e315 = to;
    let _e316 = leg;
    molten = mix(_e314, _e315, vec3(smoothstep(0f, 1f, _e316)));
    let _e320 = molten;
    let _e321 = (*voxelPos_5);
    param_17 = (vec3<f32>(_e321) * 1.7f);
    let _e324 = hash_u0028_vf3_u003b((&param_17));
    return (_e320 * (0.9f + (_e324 * 0.1f)));
}

fn renderSteam_u0028_vi3_u003b_vf3_u003b(voxelPos_6: ptr<function, vec3<i32>>, baseLighting_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_1: f32;
    var param_18: vec3<f32>;
    var val_1: f32;
    var baseColor_1: vec3<f32>;

    let _e261 = (*voxelPos_6);
    let _e264 = pc.time;
    param_18 = (vec3<f32>(_e261) + vec3(_e264));
    let _e267 = hash_u0028_vf3_u003b((&param_18));
    noise_1 = _e267;
    let _e268 = noise_1;
    val_1 = (0.85f + (_e268 * 0.15f));
    let _e271 = val_1;
    baseColor_1 = vec3(_e271);
    let _e273 = baseColor_1;
    let _e274 = (*baseLighting_4);
    return ((_e273 * _e274) * 0.9f);
}

fn renderFire_u0028_u1_u003b_vi3_u003b(rawVoxel_2: ptr<function, u32>, voxelPos_7: ptr<function, vec3<i32>>) -> vec3<f32> {
    var noise_2: f32;
    var param_19: vec3<f32>;
    var age: u32;
    var life: f32;
    var coreColor: vec3<f32>;
    var edgeColor: vec3<f32>;
    var fireColor: vec3<f32>;

    let _e264 = (*voxelPos_7);
    let _e267 = pc.time;
    param_19 = (vec3<f32>(_e264) + vec3((_e267 * 10f)));
    let _e271 = hash_u0028_vf3_u003b((&param_19));
    noise_2 = _e271;
    let _e272 = (*rawVoxel_2);
    age = ((_e272 >> bitcast<u32>(24i)) & 255u);
    let _e276 = age;
    life = clamp((f32(_e276) / 30f), 0f, 1f);
    coreColor = vec3<f32>(1f, 0.9f, 0.2f);
    edgeColor = vec3<f32>(1f, 0.3f, 0f);
    let _e280 = coreColor;
    let _e281 = edgeColor;
    let _e282 = life;
    let _e283 = noise_2;
    fireColor = mix(_e280, _e281, vec3((_e282 + (_e283 * 0.3f))));
    let _e288 = fireColor;
    return (_e288 * 1.5f);
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

    let _e271 = (*voxelPos_8);
    param_20 = vec3<f32>(_e271);
    let _e273 = hash_u0028_vf3_u003b((&param_20));
    noise_3 = _e273;
    let _e274 = noise_3;
    val_2 = (0.8f + (_e274 * 0.2f));
    let _e277 = (*rawVoxel_3);
    moisture = ((_e277 >> bitcast<u32>(24i)) & 255u);
    let _e281 = moisture;
    wetness = clamp((f32(_e281) / 30f), 0f, 1f);
    let _e285 = val_2;
    let _e287 = val_2;
    let _e289 = val_2;
    dryColor = vec3<f32>((0.4f * _e285), (0.25f * _e287), (0.1f * _e289));
    let _e292 = val_2;
    let _e294 = val_2;
    let _e296 = val_2;
    wetColor = vec3<f32>((0.15f * _e292), (0.08f * _e294), (0.03f * _e296));
    let _e299 = dryColor;
    let _e300 = wetColor;
    let _e301 = wetness;
    baseColor_2 = mix(_e299, _e300, vec3(_e301));
    let _e304 = (*rawVoxel_3);
    floraState = ((_e304 >> bitcast<u32>(8i)) & 255u);
    let _e308 = floraState;
    let _e309 = (_e308 > 10u);
    phi_1254_ = _e309;
    if _e309 {
        let _e311 = (*ddaNormal)[1u];
        phi_1254_ = (_e311 > 0.5f);
    }
    let _e314 = phi_1254_;
    if _e314 {
        let _e315 = floraState;
        grassGrow = clamp((f32((_e315 - 10u)) / 90f), 0f, 1f);
        let _e320 = noise_3;
        let _e323 = noise_3;
        grassColor = vec3<f32>((0.15f + (_e320 * 0.1f)), (0.45f + (_e323 * 0.15f)), 0.15f);
        let _e327 = floraState;
        if (_e327 > 100u) {
            let _e329 = floraState;
            drown = clamp((f32((_e329 - 100u)) / 100f), 0f, 1f);
            let _e334 = grassColor;
            let _e335 = drown;
            grassColor = mix(_e334, vec3<f32>(0.35f, 0.35f, 0.15f), vec3(_e335));
        }
        let _e338 = baseColor_2;
        let _e339 = grassColor;
        let _e340 = grassGrow;
        baseColor_2 = mix(_e338, _e339, vec3(_e340));
    }
    let _e343 = baseColor_2;
    let _e344 = (*baseLighting_5);
    return (_e343 * _e344);
}

fn renderStone_u0028_vi3_u003b_vf3_u003b(voxelPos_9: ptr<function, vec3<i32>>, baseLighting_6: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_4: f32;
    var param_21: vec3<f32>;
    var val_3: f32;
    var baseColor_3: vec3<f32>;

    let _e261 = (*voxelPos_9);
    param_21 = vec3<f32>(_e261);
    let _e263 = hash_u0028_vf3_u003b((&param_21));
    noise_4 = _e263;
    let _e264 = noise_4;
    val_3 = (0.4f + (_e264 * 0.3f));
    let _e267 = val_3;
    baseColor_3 = vec3(_e267);
    let _e269 = baseColor_3;
    let _e270 = (*baseLighting_6);
    return (_e269 * _e270);
}

fn renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b(voxelPos_10: ptr<function, vec3<i32>>, normal_2: ptr<function, vec3<f32>>, rayOrigin_1: ptr<function, vec3<f32>>, sunDir_1: ptr<function, vec3<f32>>, sunColor: ptr<function, vec3<f32>>, shadow: ptr<function, f32>, baseLighting_7: ptr<function, vec3<f32>>) -> vec3<f32> {
    var baseColor_4: vec3<f32>;
    var viewDir: vec3<f32>;
    var reflectDir: vec3<f32>;
    var spec: f32;
    var finalLighting: vec3<f32>;

    baseColor_4 = vec3<f32>(0.1f, 0.4f, 0.9f);
    let _e267 = (*rayOrigin_1);
    let _e268 = (*voxelPos_10);
    viewDir = normalize((_e267 - vec3<f32>(_e268)));
    let _e272 = (*sunDir_1);
    let _e274 = (*normal_2);
    reflectDir = reflect(-(_e272), _e274);
    let _e276 = viewDir;
    let _e277 = reflectDir;
    spec = pow(max(dot(_e276, _e277), 0f), 32f);
    let _e281 = (*baseLighting_7);
    let _e282 = (*sunColor);
    let _e283 = spec;
    let _e286 = (*shadow);
    finalLighting = (_e281 + (((_e282 * _e283) * 0.5f) * _e286));
    let _e289 = baseColor_4;
    let _e290 = finalLighting;
    return (_e289 * _e290);
}

fn renderSand_u0028_u1_u003b_vf3_u003b(rawVoxel_4: ptr<function, u32>, baseLighting_8: ptr<function, vec3<f32>>) -> vec3<f32> {
    var moisture_1: u32;
    var wetness_1: f32;
    var dryColor_1: vec3<f32>;
    var wetColor_1: vec3<f32>;
    var baseColor_5: vec3<f32>;

    let _e262 = (*rawVoxel_4);
    moisture_1 = ((_e262 >> bitcast<u32>(24i)) & 255u);
    let _e266 = moisture_1;
    wetness_1 = clamp((f32(_e266) / 10f), 0f, 1f);
    dryColor_1 = vec3<f32>(0.9f, 0.8f, 0.2f);
    wetColor_1 = vec3<f32>(0.65f, 0.55f, 0.15f);
    let _e270 = dryColor_1;
    let _e271 = wetColor_1;
    let _e272 = wetness_1;
    baseColor_5 = mix(_e270, _e271, vec3(_e272));
    let _e275 = baseColor_5;
    let _e276 = (*baseLighting_8);
    return (_e275 * _e276);
}

fn getVoxel_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    var index: u32;
    var phi_269_: bool;
    var phi_277_: bool;
    var phi_287_: bool;
    var phi_295_: bool;
    var phi_305_: bool;

    let _e258 = (*pos)[0u];
    let _e259 = (_e258 < 0i);
    phi_269_ = _e259;
    if !(_e259) {
        let _e262 = (*pos)[0u];
        let _e264 = tuning.gridWidth;
        phi_269_ = (_e262 >= bitcast<i32>(_e264));
    }
    let _e268 = phi_269_;
    phi_277_ = _e268;
    if !(_e268) {
        let _e271 = (*pos)[1u];
        phi_277_ = (_e271 < 0i);
    }
    let _e274 = phi_277_;
    phi_287_ = _e274;
    if !(_e274) {
        let _e277 = (*pos)[1u];
        let _e279 = tuning.gridHeight;
        phi_287_ = (_e277 >= bitcast<i32>(_e279));
    }
    let _e283 = phi_287_;
    phi_295_ = _e283;
    if !(_e283) {
        let _e286 = (*pos)[2u];
        phi_295_ = (_e286 < 0i);
    }
    let _e289 = phi_295_;
    phi_305_ = _e289;
    if !(_e289) {
        let _e292 = (*pos)[2u];
        let _e294 = tuning.gridDepth;
        phi_305_ = (_e292 >= bitcast<i32>(_e294));
    }
    let _e298 = phi_305_;
    if _e298 {
        return 0u;
    }
    let _e300 = (*pos)[0u];
    let _e302 = (*pos)[1u];
    let _e304 = tuning.gridWidth;
    let _e309 = (*pos)[2u];
    let _e311 = tuning.gridWidth;
    let _e315 = tuning.gridHeight;
    index = bitcast<u32>(((_e300 + (_e302 * bitcast<i32>(_e304))) + ((_e309 * bitcast<i32>(_e311)) * bitcast<i32>(_e315))));
    let _e320 = index;
    let _e323 = unnamed_1.grid[_e320];
    return _e323;
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

    let _e270 = (*hitVoxelPos);
    let _e271 = (*hitNormal);
    voxelPos_11 = (_e270 + vec3<i32>(round(_e271)));
    let _e275 = (*lightDir);
    stepDir_1 = vec3<i32>(sign(_e275));
    let _e279 = (*lightDir)[0u];
    if (_e279 == 0f) {
        local_6 = 100000000f;
    } else {
        let _e282 = (*lightDir)[0u];
        local_6 = abs((1f / _e282));
    }
    let _e285 = local_6;
    let _e287 = (*lightDir)[1u];
    if (_e287 == 0f) {
        local_7 = 100000000f;
    } else {
        let _e290 = (*lightDir)[1u];
        local_7 = abs((1f / _e290));
    }
    let _e293 = local_7;
    let _e295 = (*lightDir)[2u];
    if (_e295 == 0f) {
        local_8 = 100000000f;
    } else {
        let _e298 = (*lightDir)[2u];
        local_8 = abs((1f / _e298));
    }
    let _e301 = local_8;
    tDelta_1 = vec3<f32>(_e285, _e293, _e301);
    let _e303 = tDelta_1;
    tMax_1 = (_e303 * 0.5f);
    transmittance = 1f;
    i_3 = 0i;
    loop {
        let _e305 = i_3;
        let _e307 = tuning.shadowMaxSteps;
        if (_e305 < bitcast<i32>(_e307)) {
            let _e311 = voxelPos_11[0u];
            let _e312 = (_e311 < 0i);
            phi_586_ = _e312;
            if !(_e312) {
                let _e315 = voxelPos_11[0u];
                let _e317 = tuning.gridWidth;
                phi_586_ = (_e315 >= bitcast<i32>(_e317));
            }
            let _e321 = phi_586_;
            phi_593_ = _e321;
            if !(_e321) {
                let _e324 = voxelPos_11[1u];
                phi_593_ = (_e324 < 0i);
            }
            let _e327 = phi_593_;
            phi_601_ = _e327;
            if !(_e327) {
                let _e330 = voxelPos_11[1u];
                let _e331 = (*ceilingY);
                phi_601_ = (_e330 >= _e331);
            }
            let _e334 = phi_601_;
            phi_608_ = _e334;
            if !(_e334) {
                let _e337 = voxelPos_11[2u];
                phi_608_ = (_e337 < 0i);
            }
            let _e340 = phi_608_;
            phi_618_ = _e340;
            if !(_e340) {
                let _e343 = voxelPos_11[2u];
                let _e345 = tuning.gridDepth;
                phi_618_ = (_e343 >= bitcast<i32>(_e345));
            }
            let _e349 = phi_618_;
            if _e349 {
                let _e350 = transmittance;
                return _e350;
            }
            let _e351 = voxelPos_11;
            param_22 = _e351;
            let _e352 = getVoxel_u0028_vi3_u003b((&param_22));
            blockerType = (_e352 & 255u);
            let _e354 = blockerType;
            if (_e354 == 2u) {
                let _e357 = tuning.waterShadowTransmit;
                let _e358 = transmittance;
                transmittance = (_e358 * _e357);
                let _e360 = transmittance;
                if (_e360 < 0.02f) {
                    return 0f;
                }
            } else {
                let _e362 = blockerType;
                if (_e362 != 0u) {
                    return 0f;
                }
            }
            let _e365 = tMax_1[0u];
            let _e367 = tMax_1[1u];
            if (_e365 < _e367) {
                let _e370 = tMax_1[0u];
                let _e372 = tMax_1[2u];
                if (_e370 < _e372) {
                    let _e375 = stepDir_1[0u];
                    let _e377 = voxelPos_11[0u];
                    voxelPos_11[0u] = (_e377 + _e375);
                    let _e381 = tDelta_1[0u];
                    let _e383 = tMax_1[0u];
                    tMax_1[0u] = (_e383 + _e381);
                } else {
                    let _e387 = stepDir_1[2u];
                    let _e389 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e389 + _e387);
                    let _e393 = tDelta_1[2u];
                    let _e395 = tMax_1[2u];
                    tMax_1[2u] = (_e395 + _e393);
                }
            } else {
                let _e399 = tMax_1[1u];
                let _e401 = tMax_1[2u];
                if (_e399 < _e401) {
                    let _e404 = stepDir_1[1u];
                    let _e406 = voxelPos_11[1u];
                    voxelPos_11[1u] = (_e406 + _e404);
                    let _e410 = tDelta_1[1u];
                    let _e412 = tMax_1[1u];
                    tMax_1[1u] = (_e412 + _e410);
                } else {
                    let _e416 = stepDir_1[2u];
                    let _e418 = voxelPos_11[2u];
                    voxelPos_11[2u] = (_e418 + _e416);
                    let _e422 = tDelta_1[2u];
                    let _e424 = tMax_1[2u];
                    tMax_1[2u] = (_e424 + _e422);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e427 = i_3;
            i_3 = (_e427 + 1i);
        }
    }
    let _e429 = transmittance;
    return _e429;
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
        let _e262 = x_1;
        if (_e262 <= 1i) {
            y = -1i;
            loop {
                let _e264 = y;
                if (_e264 <= 1i) {
                    z_1 = -1i;
                    loop {
                        let _e266 = z_1;
                        if (_e266 <= 1i) {
                            let _e268 = x_1;
                            let _e270 = y;
                            let _e273 = z_1;
                            if (((_e268 == 0i) && (_e270 == 0i)) && (_e273 == 0i)) {
                                continue;
                            }
                            let _e276 = (*p_1);
                            let _e277 = x_1;
                            let _e278 = y;
                            let _e279 = z_1;
                            param_23 = (_e276 + vec3<i32>(_e277, _e278, _e279));
                            let _e282 = getVoxel_u0028_vi3_u003b((&param_23));
                            if ((_e282 & 255u) == 0u) {
                                continue;
                            }
                            let _e285 = x_1;
                            let _e287 = y;
                            let _e289 = z_1;
                            offset = vec3<f32>(f32(_e285), f32(_e287), f32(_e289));
                            let _e292 = offset;
                            let _e293 = x_1;
                            let _e294 = x_1;
                            let _e296 = y;
                            let _e297 = y;
                            let _e300 = z_1;
                            let _e301 = z_1;
                            let _e307 = n_2;
                            n_2 = (_e307 - (_e292 * inverseSqrt(f32((((_e293 * _e294) + (_e296 * _e297)) + (_e300 * _e301))))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e309 = z_1;
                            z_1 = (_e309 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e311 = y;
                    y = (_e311 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e313 = x_1;
            x_1 = (_e313 + 1i);
        }
    }
    let _e315 = n_2;
    if (length(_e315) < 0.1f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e318 = n_2;
    return normalize(_e318);
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

    let _e271 = tuning.waterWaveScale;
    scale = max(_e271, 0.001f);
    let _e273 = (*t_1);
    let _e275 = tuning.waterWaveSpeed;
    wt = ((_e273 * _e275) * 0.35f);
    let _e278 = (*p_2);
    let _e280 = (*p_2)[1u];
    let _e282 = wt;
    let _e286 = (*p_2)[0u];
    let _e288 = wt;
    q = (_e278 + (vec2<f32>(sin(((_e280 * 0.043f) + _e282)), sin(((_e286 * 0.037f) - (_e288 * 0.8f)))) * 6f));
    grad = vec2<f32>(0f, 0f);
    i_4 = 0i;
    loop {
        let _e295 = i_4;
        if (_e295 < 5i) {
            let _e297 = i_4;
            indexable_1 = array<f32, 5>(0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
            let _e299 = indexable_1[_e297];
            let _e300 = scale;
            f = (_e299 * _e300);
            let _e302 = i_4;
            indexable_2 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e304 = indexable_2[_e302];
            let _e305 = q;
            let _e307 = f;
            let _e309 = (*t_1);
            let _e310 = i_4;
            indexable_3 = array<f32, 5>(1f, 1.37f, 0.83f, 1.71f, 0.61f);
            let _e312 = indexable_3[_e310];
            let _e315 = tuning.waterWaveSpeed;
            phase_1 = ((dot(_e304, _e305) * _e307) + ((_e309 * _e312) * _e315));
            let _e318 = i_4;
            indexable_4 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e320 = indexable_4[_e318];
            let _e321 = i_4;
            indexable_5 = array<f32, 5>(1f, 0.62f, 0.38f, 0.24f, 0.15f);
            let _e323 = indexable_5[_e321];
            let _e324 = f;
            let _e326 = phase_1;
            let _e330 = grad;
            grad = (_e330 + (_e320 * ((_e323 * _e324) * cos(_e326))));
            continue;
        } else {
            break;
        }
        continuing {
            let _e332 = i_4;
            i_4 = (_e332 + 1i);
        }
    }
    let _e335 = (*p_2)[0u];
    let _e338 = (*p_2)[1u];
    let _e341 = (*t_1);
    envelope = (0.45f + (0.55f * sin((((_e335 * 0.021f) + (_e338 * 0.017f)) + (_e341 * 0.11f)))));
    let _e347 = grad;
    let _e348 = envelope;
    return (_e347 * _e348);
}

fn applyWaterWaves_u0028_vf3_u003b_vi3_u003b(normal_3: ptr<function, vec3<f32>>, voxelPos_12: ptr<function, vec3<i32>>) -> vec3<f32> {
    var upness: f32;
    var grad_1: vec2<f32>;
    var param_24: vec2<f32>;
    var param_25: f32;

    let _e262 = tuning.waterWaveStrength;
    if (_e262 <= 0f) {
        let _e264 = (*normal_3);
        return _e264;
    }
    let _e266 = (*normal_3)[1u];
    upness = clamp(_e266, 0f, 1f);
    let _e268 = upness;
    if (_e268 <= 0f) {
        let _e270 = (*normal_3);
        return _e270;
    }
    let _e271 = (*voxelPos_12);
    param_24 = (vec2<f32>(_e271.xz) + vec2<f32>(0.5f, 0.5f));
    let _e276 = pc.time;
    param_25 = _e276;
    let _e277 = waterWaveGradient_u0028_vf2_u003b_f1_u003b((&param_24), (&param_25));
    grad_1 = _e277;
    let _e278 = (*normal_3);
    let _e280 = grad_1[0u];
    let _e283 = grad_1[1u];
    let _e287 = tuning.waterWaveStrength;
    let _e289 = upness;
    return normalize((_e278 + ((vec3<f32>(-(_e280), 0f, -(_e283)) * _e287) * _e289)));
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
        let _e262 = x_2;
        if (_e262 <= 2i) {
            y_1 = -2i;
            loop {
                let _e264 = y_1;
                if (_e264 <= 2i) {
                    z_2 = -2i;
                    loop {
                        let _e266 = z_2;
                        if (_e266 <= 2i) {
                            let _e268 = x_2;
                            let _e270 = y_1;
                            let _e273 = z_2;
                            if (((_e268 == 0i) && (_e270 == 0i)) && (_e273 == 0i)) {
                                continue;
                            }
                            let _e276 = x_2;
                            let _e277 = x_2;
                            let _e279 = y_1;
                            let _e280 = y_1;
                            let _e283 = z_2;
                            let _e284 = z_2;
                            d2_ = (((_e276 * _e277) + (_e279 * _e280)) + (_e283 * _e284));
                            let _e287 = d2_;
                            if (_e287 > 6i) {
                                continue;
                            }
                            let _e289 = (*p_3);
                            let _e290 = x_2;
                            let _e291 = y_1;
                            let _e292 = z_2;
                            param_26 = (_e289 + vec3<i32>(_e290, _e291, _e292));
                            let _e295 = getVoxel_u0028_vi3_u003b((&param_26));
                            if ((_e295 & 255u) == 0u) {
                                continue;
                            }
                            let _e298 = x_2;
                            let _e300 = y_1;
                            let _e302 = z_2;
                            let _e305 = d2_;
                            let _e309 = n_3;
                            n_3 = (_e309 - (vec3<f32>(f32(_e298), f32(_e300), f32(_e302)) / vec3(f32(_e305))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e311 = z_2;
                            z_2 = (_e311 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e313 = y_1;
                    y_1 = (_e313 + 1i);
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e315 = x_2;
            x_2 = (_e315 + 1i);
        }
    }
    let _e317 = n_3;
    if (length(_e317) < 0.001f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e320 = n_3;
    return normalize(_e320);
}

fn locustDensity_u0028_u1_u003b(type_37: ptr<function, u32>) -> f32 {
    var stage_2: f32;

    let _e257 = (*type_37);
    stage_2 = (f32((_e257 - 13u)) / 4f);
    let _e262 = tuning.locustDensityMin;
    let _e264 = tuning.locustDensityMax;
    let _e265 = stage_2;
    return clamp(mix(_e262, _e264, _e265), 0.02f, 0.98f);
}

fn trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b(voxelPos_13: ptr<function, vec3<i32>>, a: ptr<function, vec2<f32>>, b: ptr<function, vec2<f32>>, count_1: ptr<function, i32>) {
    var h0_: f32;
    var param_27: vec3<f32>;
    var h1_: f32;
    var param_28: vec3<f32>;
    var h2_: f32;
    var param_29: vec3<f32>;

    let _e266 = (*voxelPos_13)[0u];
    let _e269 = (*voxelPos_13)[2u];
    param_27 = vec3<f32>(f32(_e266), 7f, f32(_e269));
    let _e272 = hash_u0028_vf3_u003b((&param_27));
    h0_ = _e272;
    let _e274 = (*voxelPos_13)[0u];
    let _e277 = (*voxelPos_13)[2u];
    param_28 = vec3<f32>(f32(_e274), 19f, f32(_e277));
    let _e280 = hash_u0028_vf3_u003b((&param_28));
    h1_ = _e280;
    let _e282 = (*voxelPos_13)[0u];
    let _e285 = (*voxelPos_13)[2u];
    param_29 = vec3<f32>(f32(_e282), 53f, f32(_e285));
    let _e288 = hash_u0028_vf3_u003b((&param_29));
    h2_ = _e288;
    let _e289 = h2_;
    let _e291 = tuning.treeTrunkColumns;
    (*count_1) = (1i + i32((_e289 * f32(max(bitcast<i32>(_e291), 1i)))));
    let _e298 = (*count_1);
    (*count_1) = clamp(_e298, 1i, 2i);
    let _e300 = h0_;
    let _e303 = h1_;
    (*a) = vec2<f32>((0.3f + (_e300 * 0.4f)), (0.3f + (_e303 * 0.4f)));
    let _e307 = h1_;
    let _e310 = h0_;
    (*b) = vec2<f32>((0.3f + (_e307 * 0.4f)), (0.3f + (_e310 * 0.4f)));
    return;
}

fn subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b(kind: ptr<function, u32>, type_38: ptr<function, u32>, voxelPos_14: ptr<function, vec3<i32>>, cell: ptr<function, vec3<i32>>, sub: ptr<function, i32>, jitter: ptr<function, vec3<f32>>) -> bool {
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

    let _e272 = (*kind);
    if (_e272 == 1u) {
        let _e274 = (*cell);
        let _e279 = (*sub);
        p_4 = ((vec2<f32>(_e274.xz) + vec2(0.5f)) / vec2(f32(_e279)));
        let _e283 = (*voxelPos_14);
        param_30 = _e283;
        trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b((&param_30), (&param_31), (&param_32), (&param_33));
        let _e284 = param_31;
        a_1 = _e284;
        let _e285 = param_32;
        b_1 = _e285;
        let _e286 = param_33;
        count_2 = _e286;
        let _e288 = tuning.treeTrunkRadius;
        r_1 = max(_e288, 0.02f);
        let _e290 = p_4;
        let _e291 = a_1;
        let _e293 = p_4;
        let _e294 = a_1;
        let _e297 = r_1;
        let _e298 = r_1;
        if (dot((_e290 - _e291), (_e293 - _e294)) <= (_e297 * _e298)) {
            return true;
        }
        let _e301 = count_2;
        let _e302 = (_e301 > 1i);
        phi_1620_ = _e302;
        if _e302 {
            let _e303 = p_4;
            let _e304 = b_1;
            let _e306 = p_4;
            let _e307 = b_1;
            let _e310 = r_1;
            let _e311 = r_1;
            phi_1620_ = (dot((_e303 - _e304), (_e306 - _e307)) <= (_e310 * _e311));
        }
        let _e315 = phi_1620_;
        if _e315 {
            return true;
        }
        return false;
    }
    let _e316 = (*voxelPos_14);
    let _e317 = (*sub);
    let _e320 = (*cell);
    let _e323 = (*jitter);
    param_34 = (vec3<f32>(((_e316 * vec3(_e317)) + _e320)) + _e323);
    let _e325 = hash_u0028_vf3_u003b((&param_34));
    let _e326 = (*type_38);
    param_35 = _e326;
    let _e327 = locustDensity_u0028_u1_u003b((&param_35));
    return (_e325 < _e327);
}

fn intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b(ro: ptr<function, vec3<f32>>, rd: ptr<function, vec3<f32>>, boxMin: ptr<function, vec3<f32>>, boxMax: ptr<function, vec3<f32>>) -> vec2<f32> {
    var tMin: vec3<f32>;
    var tMax_2: vec3<f32>;
    var t1_: vec3<f32>;
    var t2_: vec3<f32>;
    var tNear: f32;
    var tFar: f32;

    let _e265 = (*boxMin);
    let _e266 = (*ro);
    let _e268 = (*rd);
    tMin = ((_e265 - _e266) / _e268);
    let _e270 = (*boxMax);
    let _e271 = (*ro);
    let _e273 = (*rd);
    tMax_2 = ((_e270 - _e271) / _e273);
    let _e275 = tMin;
    let _e276 = tMax_2;
    t1_ = min(_e275, _e276);
    let _e278 = tMin;
    let _e279 = tMax_2;
    t2_ = max(_e278, _e279);
    let _e282 = t1_[0u];
    let _e284 = t1_[1u];
    let _e287 = t1_[2u];
    tNear = max(max(_e282, _e284), _e287);
    let _e290 = t2_[0u];
    let _e292 = t2_[1u];
    let _e295 = t2_[2u];
    tFar = min(min(_e290, _e292), _e295);
    let _e297 = tNear;
    let _e298 = tFar;
    return vec2<f32>(_e297, _e298);
}

fn subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b(voxelPos_15: ptr<function, vec3<i32>>, rayOrigin_2: ptr<function, vec3<f32>>, rayDir_2: ptr<function, vec3<f32>>, kind_1: ptr<function, u32>, type_39: ptr<function, u32>, entryNormal: ptr<function, vec3<f32>>, tHit_1: ptr<function, f32>, subNormal: ptr<function, vec3<f32>>, subCell_2: ptr<function, vec3<f32>>) -> bool {
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
    let _e294 = (*entryNormal);
    (*subNormal) = _e294;
    (*subCell_2) = vec3<f32>(0f, 0f, 0f);
    let _e296 = tuning.locustSubdivision;
    sub_1 = clamp(bitcast<i32>(_e296), 1i, 8i);
    let _e299 = sub_1;
    cellSize = (1f / f32(_e299));
    let _e302 = (*voxelPos_15);
    boxMin_1 = vec3<f32>(_e302);
    let _e304 = boxMin_1;
    let _e306 = (*rayOrigin_2);
    param_36 = _e306;
    let _e307 = (*rayDir_2);
    param_37 = _e307;
    let _e308 = boxMin_1;
    param_38 = _e308;
    param_39 = (_e304 + vec3<f32>(1f, 1f, 1f));
    let _e309 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_36), (&param_37), (&param_38), (&param_39));
    span = _e309;
    let _e311 = span[0u];
    t_2 = max(_e311, 0f);
    let _e313 = t_2;
    let _e315 = span[1u];
    if (_e313 > _e315) {
        return false;
    }
    let _e317 = (*rayOrigin_2);
    let _e318 = (*rayDir_2);
    let _e319 = t_2;
    let _e323 = boxMin_1;
    let _e325 = sub_1;
    local_9 = (((_e317 + (_e318 * (_e319 + 0.0001f))) - _e323) * f32(_e325));
    let _e328 = local_9;
    let _e331 = sub_1;
    c = clamp(vec3<i32>(floor(_e328)), vec3<i32>(0i, 0i, 0i), vec3((_e331 - 1i)));
    let _e335 = (*rayDir_2);
    stepDir_2 = vec3<i32>(sign(_e335));
    let _e339 = (*rayDir_2)[0u];
    if (_e339 == 0f) {
        local_10 = 1000000f;
    } else {
        let _e341 = cellSize;
        let _e343 = (*rayDir_2)[0u];
        local_10 = abs((_e341 / _e343));
    }
    let _e346 = local_10;
    let _e348 = (*rayDir_2)[1u];
    if (_e348 == 0f) {
        local_11 = 1000000f;
    } else {
        let _e350 = cellSize;
        let _e352 = (*rayDir_2)[1u];
        local_11 = abs((_e350 / _e352));
    }
    let _e355 = local_11;
    let _e357 = (*rayDir_2)[2u];
    if (_e357 == 0f) {
        local_12 = 1000000f;
    } else {
        let _e359 = cellSize;
        let _e361 = (*rayDir_2)[2u];
        local_12 = abs((_e359 / _e361));
    }
    let _e364 = local_12;
    tDelta_2 = vec3<f32>(_e346, _e355, _e364);
    let _e366 = local_9;
    let _e367 = c;
    fracPos_1 = (_e366 - vec3<f32>(_e367));
    let _e370 = t_2;
    let _e372 = stepDir_2[0u];
    if (_e372 > 0i) {
        let _e375 = fracPos_1[0u];
        let _e378 = tDelta_2[0u];
        local_13 = ((1f - _e375) * _e378);
    } else {
        let _e381 = fracPos_1[0u];
        let _e383 = tDelta_2[0u];
        local_13 = (_e381 * _e383);
    }
    let _e385 = local_13;
    let _e387 = stepDir_2[1u];
    if (_e387 > 0i) {
        let _e390 = fracPos_1[1u];
        let _e393 = tDelta_2[1u];
        local_14 = ((1f - _e390) * _e393);
    } else {
        let _e396 = fracPos_1[1u];
        let _e398 = tDelta_2[1u];
        local_14 = (_e396 * _e398);
    }
    let _e400 = local_14;
    let _e402 = stepDir_2[2u];
    if (_e402 > 0i) {
        let _e405 = fracPos_1[2u];
        let _e408 = tDelta_2[2u];
        local_15 = ((1f - _e405) * _e408);
    } else {
        let _e411 = fracPos_1[2u];
        let _e413 = tDelta_2[2u];
        local_15 = (_e411 * _e413);
    }
    let _e415 = local_15;
    tMax_3 = (vec3(_e370) + vec3<f32>(_e385, _e400, _e415));
    let _e419 = (*kind_1);
    if (_e419 == 0u) {
        let _e422 = pc.time;
        let _e424 = tuning.locustCrawlRate;
        local_16 = vec3((floor((_e422 * _e424)) * 1.7f));
    } else {
        local_16 = vec3<f32>(0f, 0f, 0f);
    }
    let _e429 = local_16;
    jitter_1 = _e429;
    i_5 = 0i;
    loop {
        let _e430 = i_5;
        let _e431 = sub_1;
        if (_e430 < (3i * _e431)) {
            let _e435 = c[0u];
            let _e436 = (_e435 < 0i);
            phi_1852_ = _e436;
            if !(_e436) {
                let _e439 = c[0u];
                let _e440 = sub_1;
                phi_1852_ = (_e439 >= _e440);
            }
            let _e443 = phi_1852_;
            phi_1859_ = _e443;
            if !(_e443) {
                let _e446 = c[1u];
                phi_1859_ = (_e446 < 0i);
            }
            let _e449 = phi_1859_;
            phi_1867_ = _e449;
            if !(_e449) {
                let _e452 = c[1u];
                let _e453 = sub_1;
                phi_1867_ = (_e452 >= _e453);
            }
            let _e456 = phi_1867_;
            phi_1874_ = _e456;
            if !(_e456) {
                let _e459 = c[2u];
                phi_1874_ = (_e459 < 0i);
            }
            let _e462 = phi_1874_;
            phi_1882_ = _e462;
            if !(_e462) {
                let _e465 = c[2u];
                let _e466 = sub_1;
                phi_1882_ = (_e465 >= _e466);
            }
            let _e469 = phi_1882_;
            if _e469 {
                return false;
            }
            let _e470 = (*kind_1);
            param_40 = _e470;
            let _e471 = (*type_39);
            param_41 = _e471;
            let _e472 = (*voxelPos_15);
            param_42 = _e472;
            let _e473 = c;
            param_43 = _e473;
            let _e474 = sub_1;
            param_44 = _e474;
            let _e475 = jitter_1;
            param_45 = _e475;
            let _e476 = subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b((&param_40), (&param_41), (&param_42), (&param_43), (&param_44), (&param_45));
            if _e476 {
                let _e477 = t_2;
                (*tHit_1) = _e477;
                let _e478 = c;
                (*subCell_2) = vec3<f32>(_e478);
                return true;
            }
            let _e481 = tMax_3[0u];
            let _e483 = tMax_3[1u];
            if (_e481 < _e483) {
                let _e486 = tMax_3[0u];
                let _e488 = tMax_3[2u];
                if (_e486 < _e488) {
                    let _e491 = stepDir_2[0u];
                    let _e493 = c[0u];
                    c[0u] = (_e493 + _e491);
                    let _e497 = tMax_3[0u];
                    t_2 = _e497;
                    let _e499 = tDelta_2[0u];
                    let _e501 = tMax_3[0u];
                    tMax_3[0u] = (_e501 + _e499);
                    let _e505 = stepDir_2[0u];
                    (*subNormal) = vec3<f32>(f32(-(_e505)), 0f, 0f);
                } else {
                    let _e510 = stepDir_2[2u];
                    let _e512 = c[2u];
                    c[2u] = (_e512 + _e510);
                    let _e516 = tMax_3[2u];
                    t_2 = _e516;
                    let _e518 = tDelta_2[2u];
                    let _e520 = tMax_3[2u];
                    tMax_3[2u] = (_e520 + _e518);
                    let _e524 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e524)));
                }
            } else {
                let _e529 = tMax_3[1u];
                let _e531 = tMax_3[2u];
                if (_e529 < _e531) {
                    let _e534 = stepDir_2[1u];
                    let _e536 = c[1u];
                    c[1u] = (_e536 + _e534);
                    let _e540 = tMax_3[1u];
                    t_2 = _e540;
                    let _e542 = tDelta_2[1u];
                    let _e544 = tMax_3[1u];
                    tMax_3[1u] = (_e544 + _e542);
                    let _e548 = stepDir_2[1u];
                    (*subNormal) = vec3<f32>(0f, f32(-(_e548)), 0f);
                } else {
                    let _e553 = stepDir_2[2u];
                    let _e555 = c[2u];
                    c[2u] = (_e555 + _e553);
                    let _e559 = tMax_3[2u];
                    t_2 = _e559;
                    let _e561 = tDelta_2[2u];
                    let _e563 = tMax_3[2u];
                    tMax_3[2u] = (_e563 + _e561);
                    let _e567 = stepDir_2[2u];
                    (*subNormal) = vec3<f32>(0f, 0f, f32(-(_e567)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e571 = i_5;
            i_5 = (_e571 + 1i);
        }
    }
    return false;
}

fn isLocustType_u0028_u1_u003b(type_40: ptr<function, u32>) -> bool {
    let _e256 = (*type_40);
    let _e258 = (*type_40);
    return ((_e256 >= 13u) && (_e258 <= 17u));
}

fn marchCeiling_u0028_() -> i32 {
    let _e256 = tuning.gridHeight;
    let _e259 = unnamed.maxOccupiedY;
    return min(bitcast<i32>(_e256), (bitcast<i32>(_e259) + 2i));
}

fn worldExtent_u0028_() -> vec3<f32> {
    let _e256 = tuning.gridWidth;
    let _e260 = tuning.gridHeight;
    let _e264 = tuning.gridDepth;
    return vec3<f32>(f32(bitcast<i32>(_e256)), f32(bitcast<i32>(_e260)), f32(bitcast<i32>(_e264)));
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
    let _e259 = worldExtent_u0028_();
    extent = _e259;
    let _e261 = (*p_5)[0u];
    let _e262 = thickness_1;
    let _e263 = (_e261 < _e262);
    phi_461_ = _e263;
    if !(_e263) {
        let _e266 = (*p_5)[0u];
        let _e268 = extent[0u];
        let _e269 = thickness_1;
        phi_461_ = (_e266 > (_e268 - _e269));
    }
    let _e273 = phi_461_;
    if _e273 {
        let _e274 = boundCount;
        boundCount = (_e274 + 1i);
    }
    let _e277 = (*p_5)[1u];
    let _e278 = thickness_1;
    let _e279 = (_e277 < _e278);
    phi_480_ = _e279;
    if !(_e279) {
        let _e282 = (*p_5)[1u];
        let _e284 = extent[1u];
        let _e285 = thickness_1;
        phi_480_ = (_e282 > (_e284 - _e285));
    }
    let _e289 = phi_480_;
    if _e289 {
        let _e290 = boundCount;
        boundCount = (_e290 + 1i);
    }
    let _e293 = (*p_5)[2u];
    let _e294 = thickness_1;
    let _e295 = (_e293 < _e294);
    phi_499_ = _e295;
    if !(_e295) {
        let _e298 = (*p_5)[2u];
        let _e300 = extent[2u];
        let _e301 = thickness_1;
        phi_499_ = (_e298 > (_e300 - _e301));
    }
    let _e305 = phi_499_;
    if _e305 {
        let _e306 = boundCount;
        boundCount = (_e306 + 1i);
    }
    let _e308 = boundCount;
    return (_e308 >= 2i);
}

fn rot_u0028_f1_u003b(a_2: ptr<function, f32>) -> mat2x2<f32> {
    var s: f32;
    var c_1: f32;

    let _e258 = (*a_2);
    s = sin(_e258);
    let _e260 = (*a_2);
    c_1 = cos(_e260);
    let _e262 = c_1;
    let _e263 = s;
    let _e265 = s;
    let _e266 = c_1;
    return mat2x2<f32>(vec2<f32>(_e262, -(_e263)), vec2<f32>(_e265, _e266));
}

fn applyCameraRotation_u0028_vf3_u003b(v: ptr<function, vec3<f32>>) -> vec3<f32> {
    var param_46: f32;
    var param_47: f32;

    let _e259 = pc.pitch;
    param_46 = _e259;
    let _e260 = rot_u0028_f1_u003b((&param_46));
    let _e261 = (*v);
    let _e263 = (_e261.yz * _e260);
    (*v)[1u] = _e263.x;
    (*v)[2u] = _e263.y;
    let _e269 = pc.yaw;
    param_47 = _e269;
    let _e270 = rot_u0028_f1_u003b((&param_47));
    let _e271 = (*v);
    let _e273 = (_e271.xz * _e270);
    (*v)[0u] = _e273.x;
    (*v)[2u] = _e273.y;
    let _e278 = (*v);
    return _e278;
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
    var c_2: f32;
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
    var c_3: f32;
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
    var phi_3627_: bool;
    var phi_3902_: bool;
    var phi_3909_: bool;
    var phi_3918_: bool;
    var phi_3924_: bool;
    var phi_3933_: bool;
    var phi_4144_: bool;
    var phi_4186_: bool;
    var phi_4208_: bool;
    var phi_4230_: bool;
    var phi_4258_: bool;
    var phi_4280_: bool;
    var phi_4302_: bool;

    let _e462 = inUV_1;
    screenSpace = ((_e462 * 2f) - vec2(1f));
    let _e467 = screenSpace[1u];
    screenSpace[1u] = -(_e467);
    let _e471 = pc.aspectScaleX;
    let _e473 = screenSpace[0u];
    screenSpace[0u] = (_e473 * _e471);
    let _e477 = pc.aspectScaleY;
    let _e479 = screenSpace[1u];
    screenSpace[1u] = (_e479 * _e477);
    let _e483 = pc.camX;
    let _e485 = pc.camY;
    let _e487 = pc.camZ;
    baseOrigin = vec3<f32>(_e483, _e485, _e487);
    param_48 = vec3<f32>(0f, 0f, 1f);
    let _e489 = applyCameraRotation_u0028_vf3_u003b((&param_48));
    forward = _e489;
    param_49 = vec3<f32>(1f, 0f, 0f);
    let _e490 = applyCameraRotation_u0028_vf3_u003b((&param_49));
    right = _e490;
    param_50 = vec3<f32>(0f, 1f, 0f);
    let _e491 = applyCameraRotation_u0028_vf3_u003b((&param_50));
    up = _e491;
    let _e493 = pc.perspectiveBlend;
    t_3 = clamp(_e493, 0f, 1f);
    let _e495 = worldExtent_u0028_();
    cubeCenter = (_e495 * 0.5f);
    let _e497 = cubeCenter;
    let _e498 = baseOrigin;
    let _e500 = forward;
    viewDistance = max(1f, dot((_e497 - _e498), _e500));
    let _e503 = viewDistance;
    let _e505 = pc.fovDistance;
    orthoHalfSize = (_e503 / _e505);
    let _e508 = screenSpace[0u];
    let _e510 = screenSpace[1u];
    let _e512 = pc.fovDistance;
    let _e514 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e508, _e510, _e512), vec3(_e514));
    let _e517 = right;
    let _e519 = localDir[0u];
    let _e521 = up;
    let _e523 = localDir[1u];
    let _e526 = forward;
    let _e528 = localDir[2u];
    rayDir_3 = normalize((((_e517 * _e519) + (_e521 * _e523)) + (_e526 * _e528)));
    let _e532 = right;
    let _e534 = screenSpace[0u];
    let _e536 = up;
    let _e538 = screenSpace[1u];
    let _e541 = orthoHalfSize;
    let _e543 = t_3;
    originOffset = ((((_e532 * _e534) + (_e536 * _e538)) * _e541) * (1f - _e543));
    let _e546 = baseOrigin;
    let _e547 = originOffset;
    rayOrigin_3 = (_e546 + _e547);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e549 = worldExtent_u0028_();
    let _e550 = rayOrigin_3;
    param_51 = _e550;
    let _e551 = rayDir_3;
    param_52 = _e551;
    param_53 = vec3<f32>(0f, 0f, 0f);
    param_54 = _e549;
    let _e552 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_51), (&param_52), (&param_53), (&param_54));
    aabbHit = _e552;
    hitFrontBox = false;
    hitBackBox = false;
    let _e554 = aabbHit[0u];
    let _e556 = aabbHit[1u];
    let _e557 = (_e554 < _e556);
    phi_2937_ = _e557;
    if _e557 {
        let _e559 = aabbHit[1u];
        phi_2937_ = (_e559 > 0f);
    }
    let _e562 = phi_2937_;
    if _e562 {
        let _e564 = aabbHit[0u];
        let _e565 = (_e564 > 0f);
        phi_2953_ = _e565;
        if _e565 {
            let _e566 = rayOrigin_3;
            let _e567 = rayDir_3;
            let _e569 = aabbHit[0u];
            param_55 = (_e566 + (_e567 * _e569));
            let _e572 = isEdge_u0028_vf3_u003b((&param_55));
            phi_2953_ = _e572;
        }
        let _e574 = phi_2953_;
        if _e574 {
            hitFrontBox = true;
        }
        let _e575 = rayOrigin_3;
        let _e576 = rayDir_3;
        let _e578 = aabbHit[1u];
        param_56 = (_e575 + (_e576 * _e578));
        let _e581 = isEdge_u0028_vf3_u003b((&param_56));
        if _e581 {
            hitBackBox = true;
        }
    }
    let _e582 = marchCeiling_u0028_();
    ceilingY_1 = _e582;
    let _e584 = tuning.gridWidth;
    let _e587 = ceilingY_1;
    let _e590 = tuning.gridDepth;
    let _e594 = rayOrigin_3;
    param_57 = _e594;
    let _e595 = rayDir_3;
    param_58 = _e595;
    param_59 = vec3<f32>(0f, 0f, 0f);
    param_60 = vec3<f32>(f32(bitcast<i32>(_e584)), f32(_e587), f32(bitcast<i32>(_e590)));
    let _e596 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_57), (&param_58), (&param_59), (&param_60));
    marchHit = _e596;
    let _e597 = rayOrigin_3;
    let _e598 = rayDir_3;
    let _e600 = marchHit[0u];
    currentPos = (_e597 + (_e598 * max(0f, _e600)));
    let _e605 = marchHit[0u];
    if (_e605 > 0f) {
        let _e607 = rayDir_3;
        let _e609 = currentPos;
        currentPos = (_e609 + (_e607 * 0.001f));
    }
    let _e611 = currentPos;
    voxelPos_16 = vec3<i32>(floor(_e611));
    let _e614 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e614));
    let _e618 = rayDir_3[0u];
    if (_e618 == 0f) {
        local_17 = 100000000f;
    } else {
        let _e621 = rayDir_3[0u];
        local_17 = abs((1f / _e621));
    }
    let _e624 = local_17;
    let _e626 = rayDir_3[1u];
    if (_e626 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e629 = rayDir_3[1u];
        local_18 = abs((1f / _e629));
    }
    let _e632 = local_18;
    let _e634 = rayDir_3[2u];
    if (_e634 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e637 = rayDir_3[2u];
        local_19 = abs((1f / _e637));
    }
    let _e640 = local_19;
    tDelta_3 = vec3<f32>(_e624, _e632, _e640);
    let _e643 = stepDir_3[0u];
    if (_e643 > 0i) {
        let _e646 = currentPos[0u];
        let _e650 = currentPos[0u];
        let _e653 = tDelta_3[0u];
        local_20 = (((floor(_e646) + 1f) - _e650) * _e653);
    } else {
        let _e656 = currentPos[0u];
        let _e658 = currentPos[0u];
        let _e662 = tDelta_3[0u];
        local_20 = ((_e656 - floor(_e658)) * _e662);
    }
    let _e664 = local_20;
    let _e666 = stepDir_3[1u];
    if (_e666 > 0i) {
        let _e669 = currentPos[1u];
        let _e673 = currentPos[1u];
        let _e676 = tDelta_3[1u];
        local_21 = (((floor(_e669) + 1f) - _e673) * _e676);
    } else {
        let _e679 = currentPos[1u];
        let _e681 = currentPos[1u];
        let _e685 = tDelta_3[1u];
        local_21 = ((_e679 - floor(_e681)) * _e685);
    }
    let _e687 = local_21;
    let _e689 = stepDir_3[2u];
    if (_e689 > 0i) {
        let _e692 = currentPos[2u];
        let _e696 = currentPos[2u];
        let _e699 = tDelta_3[2u];
        local_22 = (((floor(_e692) + 1f) - _e696) * _e699);
    } else {
        let _e702 = currentPos[2u];
        let _e704 = currentPos[2u];
        let _e708 = tDelta_3[2u];
        local_22 = ((_e702 - floor(_e704)) * _e708);
    }
    let _e710 = local_22;
    tMax_4 = vec3<f32>(_e664, _e687, _e710);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e713 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e713 * 1.5f));
    i_6 = 0i;
    loop {
        let _e716 = i_6;
        let _e718 = tuning.marchMaxSteps;
        if (_e716 < bitcast<i32>(_e718)) {
            let _e722 = voxelPos_16[0u];
            let _e723 = (_e722 < 0i);
            phi_3169_ = _e723;
            if !(_e723) {
                let _e726 = voxelPos_16[0u];
                let _e728 = tuning.gridWidth;
                phi_3169_ = (_e726 >= bitcast<i32>(_e728));
            }
            let _e732 = phi_3169_;
            phi_3176_ = _e732;
            if !(_e732) {
                let _e735 = voxelPos_16[1u];
                phi_3176_ = (_e735 < 0i);
            }
            let _e738 = phi_3176_;
            phi_3184_ = _e738;
            if !(_e738) {
                let _e741 = voxelPos_16[1u];
                let _e742 = ceilingY_1;
                phi_3184_ = (_e741 >= _e742);
            }
            let _e745 = phi_3184_;
            phi_3191_ = _e745;
            if !(_e745) {
                let _e748 = voxelPos_16[2u];
                phi_3191_ = (_e748 < 0i);
            }
            let _e751 = phi_3191_;
            phi_3201_ = _e751;
            if !(_e751) {
                let _e754 = voxelPos_16[2u];
                let _e756 = tuning.gridDepth;
                phi_3201_ = (_e754 >= bitcast<i32>(_e756));
            }
            let _e760 = phi_3201_;
            if _e760 {
                break;
            }
            let _e761 = voxelPos_16;
            param_61 = _e761;
            let _e762 = getVoxel_u0028_vi3_u003b((&param_61));
            rawVoxel_5 = _e762;
            let _e763 = rawVoxel_5;
            hitType = (_e763 & 255u);
            let _e765 = hitType;
            if (_e765 == 7u) {
                hitType = 0u;
            }
            let _e767 = hitType;
            if (_e767 != 0u) {
                let _e769 = hitType;
                if (_e769 == 6u) {
                    let _e771 = rawVoxel_5;
                    age_1 = ((_e771 >> bitcast<u32>(24i)) & 255u);
                    let _e775 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e775) / 100f), 0f, 1f));
                    let _e780 = inUV_1;
                    let _e782 = pc.time;
                    dither = fract((sin(dot((_e780 + vec2((_e782 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e790 = dither;
                    let _e791 = targetAlpha;
                    if (_e790 > _e791) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e793 = rawVoxel_5;
                        hitRawVoxel = _e793;
                        break;
                    }
                } else {
                    let _e794 = hitType;
                    param_62 = _e794;
                    let _e795 = isLocustType_u0028_u1_u003b((&param_62));
                    let _e796 = hitType;
                    if (_e795 || (_e796 == 18u)) {
                        let _e799 = hitType;
                        kind_2 = select(0u, 1u, (_e799 == 18u));
                        let _e802 = voxelPos_16;
                        param_63 = _e802;
                        let _e803 = rayOrigin_3;
                        param_64 = _e803;
                        let _e804 = rayDir_3;
                        param_65 = _e804;
                        let _e805 = kind_2;
                        param_66 = _e805;
                        let _e806 = hitType;
                        param_67 = _e806;
                        let _e807 = normal_4;
                        param_68 = _e807;
                        let _e808 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_63), (&param_64), (&param_65), (&param_66), (&param_67), (&param_68), (&param_69), (&param_70), (&param_71));
                        let _e809 = param_69;
                        subT = _e809;
                        let _e810 = param_70;
                        subNormal_1 = _e810;
                        let _e811 = param_71;
                        subCell_3 = _e811;
                        if _e808 {
                            hit = true;
                            let _e812 = rawVoxel_5;
                            hitRawVoxel = _e812;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e813 = rawVoxel_5;
                        hitRawVoxel = _e813;
                        break;
                    }
                }
            }
            let _e815 = tMax_4[0u];
            let _e817 = tMax_4[1u];
            if (_e815 < _e817) {
                let _e820 = tMax_4[0u];
                let _e822 = tMax_4[2u];
                if (_e820 < _e822) {
                    let _e825 = stepDir_3[0u];
                    let _e827 = voxelPos_16[0u];
                    voxelPos_16[0u] = (_e827 + _e825);
                    let _e831 = tDelta_3[0u];
                    let _e833 = tMax_4[0u];
                    tMax_4[0u] = (_e833 + _e831);
                    let _e837 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e837)), 0f, 0f);
                } else {
                    let _e842 = stepDir_3[2u];
                    let _e844 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e844 + _e842);
                    let _e848 = tDelta_3[2u];
                    let _e850 = tMax_4[2u];
                    tMax_4[2u] = (_e850 + _e848);
                    let _e854 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e854)));
                }
            } else {
                let _e859 = tMax_4[1u];
                let _e861 = tMax_4[2u];
                if (_e859 < _e861) {
                    let _e864 = stepDir_3[1u];
                    let _e866 = voxelPos_16[1u];
                    voxelPos_16[1u] = (_e866 + _e864);
                    let _e870 = tDelta_3[1u];
                    let _e872 = tMax_4[1u];
                    tMax_4[1u] = (_e872 + _e870);
                    let _e876 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e876)), 0f);
                } else {
                    let _e881 = stepDir_3[2u];
                    let _e883 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e883 + _e881);
                    let _e887 = tDelta_3[2u];
                    let _e889 = tMax_4[2u];
                    tMax_4[2u] = (_e889 + _e887);
                    let _e893 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e893)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e897 = i_6;
            i_6 = (_e897 + 1i);
        }
    }
    let _e899 = hit;
    if _e899 {
        let _e900 = normal_4;
        if (length(_e900) < 0.1f) {
            let _e903 = rayDir_3;
            normal_4 = -(_e903);
        }
        let _e905 = normal_4;
        ddaNormal_1 = _e905;
        let _e906 = hitType;
        if (_e906 == 2u) {
            let _e908 = voxelPos_16;
            param_72 = _e908;
            let _e909 = getWaterNormal_u0028_vi3_u003b((&param_72));
            param_73 = _e909;
            let _e910 = voxelPos_16;
            param_74 = _e910;
            let _e911 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_73), (&param_74));
            normal_4 = _e911;
        } else {
            let _e912 = hitType;
            param_75 = _e912;
            let _e913 = isLocustType_u0028_u1_u003b((&param_75));
            let _e914 = hitType;
            if (_e913 || (_e914 == 18u)) {
                let _e917 = subNormal_1;
                normal_4 = _e917;
            } else {
                let _e918 = voxelPos_16;
                param_76 = _e918;
                let _e919 = getSmoothNormal_u0028_vi3_u003b((&param_76));
                normal_4 = _e919;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e920 = normal_4;
        let _e921 = sunDir_2;
        diffuse_1 = max(dot(_e920, _e921), 0f);
        let _e924 = voxelPos_16;
        param_77 = _e924;
        let _e925 = ddaNormal_1;
        param_78 = _e925;
        let _e926 = sunDir_2;
        param_79 = _e926;
        let _e927 = ceilingY_1;
        param_80 = _e927;
        let _e928 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_77), (&param_78), (&param_79), (&param_80));
        shadow_1 = _e928;
        let _e929 = ambientColor;
        let _e930 = sunColor_1;
        let _e931 = diffuse_1;
        let _e933 = shadow_1;
        baseLighting_9 = (_e929 + ((_e930 * _e931) * _e933));
        let _e936 = baseLighting_9;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e936);
        let _e938 = hitType;
        switch bitcast<i32>(_e938) {
            case 1: {
                let _e940 = hitRawVoxel;
                param_81 = _e940;
                let _e941 = baseLighting_9;
                param_82 = _e941;
                let _e942 = renderSand_u0028_u1_u003b_vf3_u003b((&param_81), (&param_82));
                finalVoxelColor = _e942;
                break;
            }
            case 2: {
                let _e943 = voxelPos_16;
                param_83 = _e943;
                let _e944 = normal_4;
                param_84 = _e944;
                let _e945 = rayOrigin_3;
                param_85 = _e945;
                let _e946 = sunDir_2;
                param_86 = _e946;
                let _e947 = sunColor_1;
                param_87 = _e947;
                let _e948 = shadow_1;
                param_88 = _e948;
                let _e949 = baseLighting_9;
                param_89 = _e949;
                let _e950 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_83), (&param_84), (&param_85), (&param_86), (&param_87), (&param_88), (&param_89));
                finalVoxelColor = _e950;
                break;
            }
            case 3: {
                let _e951 = voxelPos_16;
                param_90 = _e951;
                let _e952 = baseLighting_9;
                param_91 = _e952;
                let _e953 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_90), (&param_91));
                finalVoxelColor = _e953;
                break;
            }
            case 4: {
                let _e954 = hitRawVoxel;
                param_92 = _e954;
                let _e955 = voxelPos_16;
                param_93 = _e955;
                let _e956 = ddaNormal_1;
                param_94 = _e956;
                let _e957 = baseLighting_9;
                param_95 = _e957;
                let _e958 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_92), (&param_93), (&param_94), (&param_95));
                finalVoxelColor = _e958;
                break;
            }
            case 5: {
                let _e959 = hitRawVoxel;
                param_96 = _e959;
                let _e960 = voxelPos_16;
                param_97 = _e960;
                let _e961 = renderFire_u0028_u1_u003b_vi3_u003b((&param_96), (&param_97));
                finalVoxelColor = _e961;
                break;
            }
            case 6: {
                let _e962 = voxelPos_16;
                param_98 = _e962;
                let _e963 = baseLighting_9;
                param_99 = _e963;
                let _e964 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_98), (&param_99));
                finalVoxelColor = _e964;
                break;
            }
            case 9, 10, 11, 8: {
                let _e965 = hitRawVoxel;
                param_100 = _e965;
                let _e966 = voxelPos_16;
                param_101 = _e966;
                let _e967 = renderLava_u0028_u1_u003b_vi3_u003b((&param_100), (&param_101));
                finalVoxelColor = _e967;
                break;
            }
            case 12: {
                let _e968 = voxelPos_16;
                param_102 = _e968;
                let _e969 = baseLighting_9;
                param_103 = _e969;
                let _e970 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_102), (&param_103));
                finalVoxelColor = _e970;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e971 = voxelPos_16;
                param_104 = _e971;
                let _e972 = subCell_3;
                param_105 = _e972;
                let _e973 = baseLighting_9;
                param_106 = _e973;
                let _e974 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_104), (&param_105), (&param_106));
                finalVoxelColor = _e974;
                break;
            }
            case 18: {
                let _e975 = voxelPos_16;
                param_107 = _e975;
                let _e976 = subCell_3;
                param_108 = _e976;
                let _e977 = baseLighting_9;
                param_109 = _e977;
                let _e978 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_107), (&param_108), (&param_109));
                finalVoxelColor = _e978;
                break;
            }
            case 19: {
                let _e979 = hitRawVoxel;
                param_110 = _e979;
                let _e980 = voxelPos_16;
                param_111 = _e980;
                let _e981 = baseLighting_9;
                param_112 = _e981;
                let _e982 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_110), (&param_111), (&param_112));
                finalVoxelColor = _e982;
                break;
            }
            default: {
                break;
            }
        }
        let _e983 = finalVoxelColor;
        param_113 = _e983;
        let _e984 = voxelPos_16;
        param_114 = _e984;
        let _e985 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_113), (&param_114));
        finalVoxelColor = _e985;
        let _e986 = hitType;
        param_115 = _e986;
        let _e987 = isLocustType_u0028_u1_u003b((&param_115));
        let _e988 = hitType;
        if (_e987 || (_e988 == 18u)) {
            let _e991 = subT;
            local_23 = _e991;
        } else {
            let _e992 = voxelPos_16;
            let _e995 = rayOrigin_3;
            local_23 = length(((vec3<f32>(_e992) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e995));
        }
        let _e998 = local_23;
        distanceTraveled = _e998;
        let _e999 = distanceTraveled;
        let _e1000 = MAX_VISIBILITY;
        let _e1004 = finalVoxelColor;
        finalVoxelColor = (_e1004 * mix(1f, 0f, clamp((_e999 / _e1000), 0f, 1f)));
        let _e1006 = distanceTraveled;
        finalDist = _e1006;
        let _e1007 = finalVoxelColor;
        finalColor = vec4<f32>(_e1007.x, _e1007.y, _e1007.z, 1f);
    } else {
        let _e1012 = hitBackBox;
        if _e1012 {
            let _e1014 = aabbHit[1u];
            finalDist = _e1014;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1016 = unnamed.blackHoleCount;
    if (_e1016 > 0u) {
        seenHoles = 0u;
        i_7 = 0i;
        loop {
            let _e1018 = i_7;
            let _e1019 = (_e1018 < 8i);
            phi_3627_ = _e1019;
            if _e1019 {
                let _e1020 = seenHoles;
                let _e1022 = unnamed.blackHoleCount;
                phi_3627_ = (_e1020 < _e1022);
            }
            let _e1025 = phi_3627_;
            if _e1025 {
                let _e1026 = i_7;
                let _e1029 = unnamed.blackHoles[_e1026];
                code_2 = _e1029;
                let _e1030 = code_2;
                if (_e1030 == 0u) {
                    continue;
                }
                let _e1032 = seenHoles;
                seenHoles = (_e1032 + bitcast<u32>(1i));
                let _e1035 = code_2;
                if ((_e1035 & 1073741824u) != 0u) {
                    let _e1039 = tuning.purgeLevel;
                    let _e1041 = i_7;
                    let _e1044 = unnamed.blackHoleMass[_e1041];
                    let _e1047 = tuning.purgeMass;
                    local_24 = u32((f32(_e1039) * clamp((f32(_e1044) / f32(max(_e1047, 1u))), 0f, 1f)));
                } else {
                    let _e1054 = i_7;
                    let _e1057 = unnamed.blackHoleMass[_e1054];
                    param_116 = _e1057;
                    let _e1058 = bhLevel_u0028_u1_u003b((&param_116));
                    local_24 = _e1058;
                }
                let _e1059 = local_24;
                bodyLevel = _e1059;
                let _e1060 = bodyLevel;
                param_117 = _e1060;
                let _e1061 = bhBodyRadius_u0028_u1_u003b((&param_117));
                bodyRadius = _e1061;
                let _e1062 = code_2;
                param_118 = _e1062;
                let _e1063 = bhDecode_u0028_u1_u003b((&param_118));
                center = (vec3<f32>(_e1063) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1066 = rayOrigin_3;
                let _e1067 = center;
                oc = (_e1066 - _e1067);
                let _e1069 = oc;
                let _e1070 = rayDir_3;
                b_2 = dot(_e1069, _e1070);
                let _e1072 = oc;
                let _e1073 = oc;
                let _e1075 = bodyRadius;
                let _e1076 = bodyRadius;
                c_2 = (dot(_e1072, _e1073) - (_e1075 * _e1076));
                let _e1079 = b_2;
                let _e1080 = b_2;
                let _e1082 = c_2;
                disc = ((_e1079 * _e1080) - _e1082);
                let _e1084 = disc;
                if (_e1084 <= 0f) {
                    continue;
                }
                let _e1086 = disc;
                sq = sqrt(_e1086);
                let _e1088 = b_2;
                let _e1090 = sq;
                tNear_1 = (-(_e1088) - _e1090);
                let _e1092 = b_2;
                let _e1094 = sq;
                tFar_1 = (-(_e1092) + _e1094);
                let _e1096 = tFar_1;
                if (_e1096 <= 0f) {
                    continue;
                }
                let _e1098 = tNear_1;
                bodyDist = max(0f, _e1098);
                let _e1100 = bodyDist;
                let _e1101 = finalDist;
                if (_e1100 < _e1101) {
                    let _e1103 = rayOrigin_3;
                    let _e1104 = rayDir_3;
                    let _e1105 = bodyDist;
                    let _e1108 = center;
                    surfaceNormal = normalize(((_e1103 + (_e1104 * _e1105)) - _e1108));
                    let _e1111 = surfaceNormal;
                    param_119 = _e1111;
                    let _e1112 = rayDir_3;
                    param_120 = _e1112;
                    let _e1113 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_119), (&param_120));
                    bodyColor = _e1113;
                    let _e1114 = bodyDist;
                    let _e1115 = MAX_VISIBILITY;
                    let _e1119 = bodyColor;
                    bodyColor = (_e1119 * mix(1f, 0f, clamp((_e1114 / _e1115), 0f, 1f)));
                    let _e1121 = bodyColor;
                    finalColor = vec4<f32>(_e1121.x, _e1121.y, _e1121.z, 1f);
                    let _e1126 = bodyDist;
                    finalDist = _e1126;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1127 = i_7;
                i_7 = (_e1127 + 1i);
            }
        }
    }
    let _e1130 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1130), 0f, 1f);
    let _e1134 = tuning.cloudMinAlpha;
    let _e1136 = tuning.cloudMaxAlpha;
    let _e1137 = charge;
    groupAlpha = mix(_e1134, _e1136, _e1137);
    let _e1139 = charge;
    cloudGreyness = _e1139;
    let _e1141 = unnamed.rainPhase;
    if (_e1141 == 1u) {
        let _e1144 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1144);
        let _e1146 = charge;
        let _e1148 = pc.time;
        let _e1149 = crossedTime;
        let _e1152 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1146, clamp(((_e1148 - _e1149) / _e1152), 0f, 1f));
    } else {
        let _e1157 = unnamed.rainPhase;
        if (_e1157 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1159 = groupAlpha;
    if (_e1159 > 0.002f) {
        let _e1161 = worldExtent_u0028_();
        let _e1162 = rayOrigin_3;
        param_121 = _e1162;
        let _e1163 = rayDir_3;
        param_122 = _e1163;
        param_123 = vec3<f32>(0f, 0f, 0f);
        param_124 = _e1161;
        let _e1164 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_121), (&param_122), (&param_123), (&param_124));
        cloudClip = _e1164;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1166 = cloudClip[0u];
        nearT = max(_e1166, 0f);
        let _e1169 = cloudClip[1u];
        let _e1170 = finalDist;
        farT = min(_e1169, _e1170);
        let _e1172 = nearT;
        let _e1173 = farT;
        if (_e1172 < _e1173) {
            let _e1175 = rayOrigin_3;
            param_125 = _e1175;
            let _e1176 = rayDir_3;
            param_126 = _e1176;
            let _e1177 = nearT;
            param_127 = _e1177;
            let _e1178 = farT;
            param_128 = _e1178;
            let _e1179 = cloudSunDir;
            param_129 = _e1179;
            let _e1180 = cloudGreyness;
            param_130 = _e1180;
            let _e1181 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b((&param_125), (&param_126), (&param_127), (&param_128), (&param_129), (&param_130), (&param_131), (&param_132), (&param_133));
            let _e1182 = param_131;
            cloudTHit = _e1182;
            let _e1183 = param_132;
            cloudColor = _e1183;
            let _e1184 = param_133;
            cloudDensity = _e1184;
            if _e1181 {
                let _e1185 = cloudTHit;
                if (_e1185 > 0f) {
                    let _e1187 = cloudTHit;
                    bestT = _e1187;
                    let _e1188 = cloudColor;
                    bestColor = _e1188;
                    let _e1189 = groupAlpha;
                    let _e1190 = cloudDensity;
                    bestAlpha = clamp((_e1189 * mix(0.35f, 1f, _e1190)), 0f, 0.95f);
                    foundCloud = true;
                }
            }
        }
        let _e1194 = foundCloud;
        let _e1195 = bestT;
        let _e1196 = finalDist;
        if (_e1194 && (_e1195 < _e1196)) {
            let _e1199 = finalColor;
            let _e1201 = bestColor;
            let _e1202 = bestAlpha;
            let _e1204 = mix(_e1199.xyz, _e1201, vec3(_e1202));
            finalColor[0u] = _e1204.x;
            finalColor[1u] = _e1204.y;
            finalColor[2u] = _e1204.z;
        }
    }
    let _e1212 = pc.spawnX;
    let _e1213 = (_e1212 >= 0i);
    phi_3902_ = _e1213;
    if _e1213 {
        let _e1215 = pc.spawnX;
        let _e1217 = tuning.gridWidth;
        phi_3902_ = (_e1215 < bitcast<i32>(_e1217));
    }
    let _e1221 = phi_3902_;
    phi_3909_ = _e1221;
    if _e1221 {
        let _e1223 = pc.spawnY;
        phi_3909_ = (_e1223 >= 0i);
    }
    let _e1226 = phi_3909_;
    phi_3918_ = _e1226;
    if _e1226 {
        let _e1228 = pc.spawnY;
        let _e1230 = tuning.gridHeight;
        phi_3918_ = (_e1228 < bitcast<i32>(_e1230));
    }
    let _e1234 = phi_3918_;
    phi_3924_ = _e1234;
    if _e1234 {
        let _e1236 = pc.spawnZ;
        phi_3924_ = (_e1236 >= 0i);
    }
    let _e1239 = phi_3924_;
    phi_3933_ = _e1239;
    if _e1239 {
        let _e1241 = pc.spawnZ;
        let _e1243 = tuning.gridDepth;
        phi_3933_ = (_e1241 < bitcast<i32>(_e1243));
    }
    let _e1247 = phi_3933_;
    if _e1247 {
        let _e1249 = pc.spawnSize;
        halfDistMin = (_e1249 / 2i);
        let _e1252 = pc.spawnSize;
        halfDistMax = ((_e1252 - 1i) / 2i);
        let _e1256 = pc.spawnX;
        let _e1257 = halfDistMin;
        let _e1261 = pc.spawnY;
        let _e1262 = halfDistMin;
        let _e1266 = pc.spawnZ;
        let _e1267 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1256 - _e1257)), f32((_e1261 - _e1262)), f32((_e1266 - _e1267)));
        let _e1272 = pc.spawnX;
        let _e1273 = halfDistMax;
        let _e1278 = pc.spawnY;
        let _e1279 = halfDistMax;
        let _e1284 = pc.spawnZ;
        let _e1285 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1272 + _e1273) + 1i)), f32(((_e1278 + _e1279) + 1i)), f32(((_e1284 + _e1285) + 1i)));
        let _e1291 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1294 = indexable_6[clamp(_e1291, 0i, 19i)];
        cursorColor = _e1294;
        let _e1296 = pc.spawnShape;
        if (_e1296 == 1i) {
            let _e1298 = boxMin_2;
            let _e1299 = boxMax_1;
            sphereCenter = ((_e1298 + _e1299) * 0.5f);
            let _e1303 = pc.spawnSize;
            sphereRadius = (f32(_e1303) * 0.5f);
            let _e1306 = rayOrigin_3;
            let _e1307 = sphereCenter;
            oc_1 = (_e1306 - _e1307);
            let _e1309 = oc_1;
            let _e1310 = rayDir_3;
            b_3 = dot(_e1309, _e1310);
            let _e1312 = oc_1;
            let _e1313 = oc_1;
            let _e1315 = sphereRadius;
            let _e1316 = sphereRadius;
            c_3 = (dot(_e1312, _e1313) - (_e1315 * _e1316));
            let _e1319 = b_3;
            let _e1320 = b_3;
            let _e1322 = c_3;
            disc_1 = ((_e1319 * _e1320) - _e1322);
            let _e1324 = disc_1;
            if (_e1324 > 0f) {
                let _e1326 = disc_1;
                sq_1 = sqrt(_e1326);
                let _e1328 = b_3;
                let _e1330 = sq_1;
                tNear_2 = (-(_e1328) - _e1330);
                let _e1332 = b_3;
                let _e1334 = sq_1;
                tFar_2 = (-(_e1332) + _e1334);
                let _e1336 = tFar_2;
                if (_e1336 > 0f) {
                    let _e1338 = tNear_2;
                    inside = (_e1338 <= 0f);
                    let _e1340 = inside;
                    let _e1341 = tFar_2;
                    let _e1342 = tNear_2;
                    cursorDist = select(_e1342, _e1341, _e1340);
                    let _e1344 = rayOrigin_3;
                    let _e1345 = rayDir_3;
                    let _e1346 = cursorDist;
                    let _e1349 = sphereCenter;
                    shellNormal = normalize(((_e1344 + (_e1345 * _e1346)) - _e1349));
                    let _e1352 = shellNormal;
                    let _e1353 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1352, _e1353)));
                    let _e1357 = rim_1;
                    let _e1360 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1357)) * select(1f, 0.35f, _e1360));
                    let _e1363 = cursorDist;
                    let _e1364 = finalDist;
                    if (_e1363 < _e1364) {
                        let _e1366 = finalColor;
                        let _e1368 = cursorColor;
                        let _e1369 = alpha;
                        let _e1371 = mix(_e1366.xyz, _e1368, vec3(_e1369));
                        finalColor[0u] = _e1371.x;
                        finalColor[1u] = _e1371.y;
                        finalColor[2u] = _e1371.z;
                    }
                }
            }
        } else {
            let _e1378 = rayOrigin_3;
            param_134 = _e1378;
            let _e1379 = rayDir_3;
            param_135 = _e1379;
            let _e1380 = boxMin_2;
            param_136 = _e1380;
            let _e1381 = boxMax_1;
            param_137 = _e1381;
            let _e1382 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_134), (&param_135), (&param_136), (&param_137));
            cursorHit = _e1382;
            let _e1384 = cursorHit[0u];
            let _e1386 = cursorHit[1u];
            let _e1387 = (_e1384 < _e1386);
            phi_4144_ = _e1387;
            if _e1387 {
                let _e1389 = cursorHit[1u];
                phi_4144_ = (_e1389 > 0f);
            }
            let _e1392 = phi_4144_;
            if _e1392 {
                let _e1394 = cursorHit[0u];
                distFront = max(0f, _e1394);
                let _e1397 = cursorHit[1u];
                distBack = _e1397;
                let _e1398 = rayOrigin_3;
                let _e1399 = rayDir_3;
                let _e1400 = distFront;
                hitPosFront = (_e1398 + (_e1399 * _e1400));
                let _e1403 = rayOrigin_3;
                let _e1404 = rayDir_3;
                let _e1405 = distBack;
                hitPosBack = (_e1403 + (_e1404 * _e1405));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1409 = hitPosFront[0u];
                let _e1411 = boxMin_2[0u];
                let _e1412 = e;
                let _e1414 = (_e1409 < (_e1411 + _e1412));
                phi_4186_ = _e1414;
                if !(_e1414) {
                    let _e1417 = hitPosFront[0u];
                    let _e1419 = boxMax_1[0u];
                    let _e1420 = e;
                    phi_4186_ = (_e1417 > (_e1419 - _e1420));
                }
                let _e1424 = phi_4186_;
                if _e1424 {
                    let _e1425 = edgesFront;
                    edgesFront = (_e1425 + 1i);
                }
                let _e1428 = hitPosFront[1u];
                let _e1430 = boxMin_2[1u];
                let _e1431 = e;
                let _e1433 = (_e1428 < (_e1430 + _e1431));
                phi_4208_ = _e1433;
                if !(_e1433) {
                    let _e1436 = hitPosFront[1u];
                    let _e1438 = boxMax_1[1u];
                    let _e1439 = e;
                    phi_4208_ = (_e1436 > (_e1438 - _e1439));
                }
                let _e1443 = phi_4208_;
                if _e1443 {
                    let _e1444 = edgesFront;
                    edgesFront = (_e1444 + 1i);
                }
                let _e1447 = hitPosFront[2u];
                let _e1449 = boxMin_2[2u];
                let _e1450 = e;
                let _e1452 = (_e1447 < (_e1449 + _e1450));
                phi_4230_ = _e1452;
                if !(_e1452) {
                    let _e1455 = hitPosFront[2u];
                    let _e1457 = boxMax_1[2u];
                    let _e1458 = e;
                    phi_4230_ = (_e1455 > (_e1457 - _e1458));
                }
                let _e1462 = phi_4230_;
                if _e1462 {
                    let _e1463 = edgesFront;
                    edgesFront = (_e1463 + 1i);
                }
                let _e1465 = edgesFront;
                if (_e1465 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1468 = hitPosBack[0u];
                let _e1470 = boxMin_2[0u];
                let _e1471 = e;
                let _e1473 = (_e1468 < (_e1470 + _e1471));
                phi_4258_ = _e1473;
                if !(_e1473) {
                    let _e1476 = hitPosBack[0u];
                    let _e1478 = boxMax_1[0u];
                    let _e1479 = e;
                    phi_4258_ = (_e1476 > (_e1478 - _e1479));
                }
                let _e1483 = phi_4258_;
                if _e1483 {
                    let _e1484 = edgesBack;
                    edgesBack = (_e1484 + 1i);
                }
                let _e1487 = hitPosBack[1u];
                let _e1489 = boxMin_2[1u];
                let _e1490 = e;
                let _e1492 = (_e1487 < (_e1489 + _e1490));
                phi_4280_ = _e1492;
                if !(_e1492) {
                    let _e1495 = hitPosBack[1u];
                    let _e1497 = boxMax_1[1u];
                    let _e1498 = e;
                    phi_4280_ = (_e1495 > (_e1497 - _e1498));
                }
                let _e1502 = phi_4280_;
                if _e1502 {
                    let _e1503 = edgesBack;
                    edgesBack = (_e1503 + 1i);
                }
                let _e1506 = hitPosBack[2u];
                let _e1508 = boxMin_2[2u];
                let _e1509 = e;
                let _e1511 = (_e1506 < (_e1508 + _e1509));
                phi_4302_ = _e1511;
                if !(_e1511) {
                    let _e1514 = hitPosBack[2u];
                    let _e1516 = boxMax_1[2u];
                    let _e1517 = e;
                    phi_4302_ = (_e1514 > (_e1516 - _e1517));
                }
                let _e1521 = phi_4302_;
                if _e1521 {
                    let _e1522 = edgesBack;
                    edgesBack = (_e1522 + 1i);
                }
                let _e1524 = edgesBack;
                if (_e1524 >= 2i) {
                    onBackEdge = true;
                }
                let _e1526 = onFrontEdge;
                let _e1527 = distFront;
                let _e1528 = finalDist;
                if (_e1526 && (_e1527 < _e1528)) {
                    let _e1531 = finalColor;
                    let _e1533 = cursorColor;
                    let _e1535 = mix(_e1531.xyz, _e1533, vec3(0.9f));
                    finalColor[0u] = _e1535.x;
                    finalColor[1u] = _e1535.y;
                    finalColor[2u] = _e1535.z;
                } else {
                    let _e1542 = onBackEdge;
                    let _e1543 = distBack;
                    let _e1544 = finalDist;
                    if (_e1542 && (_e1543 < _e1544)) {
                        let _e1547 = finalColor;
                        let _e1549 = cursorColor;
                        let _e1551 = mix(_e1547.xyz, _e1549, vec3(0.2f));
                        finalColor[0u] = _e1551.x;
                        finalColor[1u] = _e1551.y;
                        finalColor[2u] = _e1551.z;
                    } else {
                        let _e1558 = distFront;
                        let _e1559 = finalDist;
                        if (_e1558 < _e1559) {
                            let _e1561 = finalColor;
                            let _e1563 = cursorColor;
                            let _e1565 = mix(_e1561.xyz, _e1563, vec3(0.15f));
                            finalColor[0u] = _e1565.x;
                            finalColor[1u] = _e1565.y;
                            finalColor[2u] = _e1565.z;
                        }
                    }
                }
            }
        }
    }
    let _e1572 = hitFrontBox;
    if _e1572 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1573 = finalColor;
    outColor = _e1573;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
