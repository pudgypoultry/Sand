// GENERATED FILE -- DO NOT EDIT.
//
// Translated from raymarch.frag by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit raymarch.frag and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 0db38a614a3a710e236fec15aa928fdaf8155807f0c48870753ed04d38eb2ae5

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
    let _e258 = (*p);
    return fract((sin(dot(_e258, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x: ptr<function, i32>, z: ptr<function, i32>) -> u32 {
    let _e259 = (*x);
    let _e260 = (*z);
    let _e262 = tuning.gridWidth;
    return (bitcast<u32>((_e259 + (_e260 * bitcast<i32>(_e262)))) * 4u);
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

    let _e302 = (*tEnter);
    (*tEnter) = max(_e302, 0f);
    let _e304 = (*tEnter);
    let _e305 = (*tExit);
    if (_e304 >= _e305) {
        return false;
    }
    let _e307 = (*rayOrigin);
    let _e308 = (*rayDir);
    let _e309 = (*tEnter);
    startPos = (_e307 + (_e308 * _e309));
    let _e312 = startPos;
    let _e314 = tuning.cloudVoxelSize;
    cellPos = vec3<i32>(floor((_e312 / vec3(_e314))));
    let _e319 = (*rayDir);
    stepDir = vec3<i32>(sign(_e319));
    let _e323 = (*rayDir)[0u];
    if (_e323 == 0f) {
        local = 100000000f;
    } else {
        let _e326 = tuning.cloudVoxelSize;
        let _e328 = (*rayDir)[0u];
        local = abs((_e326 / _e328));
    }
    let _e331 = local;
    let _e333 = (*rayDir)[1u];
    if (_e333 == 0f) {
        local_1 = 100000000f;
    } else {
        let _e336 = tuning.cloudVoxelSize;
        let _e338 = (*rayDir)[1u];
        local_1 = abs((_e336 / _e338));
    }
    let _e341 = local_1;
    let _e343 = (*rayDir)[2u];
    if (_e343 == 0f) {
        local_2 = 100000000f;
    } else {
        let _e346 = tuning.cloudVoxelSize;
        let _e348 = (*rayDir)[2u];
        local_2 = abs((_e346 / _e348));
    }
    let _e351 = local_2;
    tDelta = vec3<f32>(_e331, _e341, _e351);
    let _e353 = startPos;
    let _e355 = tuning.cloudVoxelSize;
    let _e358 = cellPos;
    fracPos = ((_e353 / vec3(_e355)) - vec3<f32>(_e358));
    let _e361 = (*tEnter);
    let _e363 = stepDir[0u];
    if (_e363 > 0i) {
        let _e366 = fracPos[0u];
        let _e369 = tDelta[0u];
        local_3 = ((1f - _e366) * _e369);
    } else {
        let _e372 = fracPos[0u];
        let _e374 = tDelta[0u];
        local_3 = (_e372 * _e374);
    }
    let _e376 = local_3;
    let _e378 = stepDir[1u];
    if (_e378 > 0i) {
        let _e381 = fracPos[1u];
        let _e384 = tDelta[1u];
        local_4 = ((1f - _e381) * _e384);
    } else {
        let _e387 = fracPos[1u];
        let _e389 = tDelta[1u];
        local_4 = (_e387 * _e389);
    }
    let _e391 = local_4;
    let _e393 = stepDir[2u];
    if (_e393 > 0i) {
        let _e396 = fracPos[2u];
        let _e399 = tDelta[2u];
        local_5 = ((1f - _e396) * _e399);
    } else {
        let _e402 = fracPos[2u];
        let _e404 = tDelta[2u];
        local_5 = (_e402 * _e404);
    }
    let _e406 = local_5;
    tMax = (vec3(_e361) + vec3<f32>(_e376, _e391, _e406));
    normal = vec3<f32>(0f, 0f, 0f);
    let _e410 = (*tEnter);
    t = _e410;
    i = 0i;
    loop {
        let _e411 = i;
        let _e413 = tuning.maxCloudSteps;
        if (_e411 < bitcast<i32>(_e413)) {
            let _e416 = t;
            let _e417 = (*tExit);
            if (_e416 > _e417) {
                break;
            }
            let _e419 = cellPos;
            let _e424 = tuning.cloudVoxelSize;
            cellCenter = ((vec3<f32>(_e419) + vec3(0.5f)) * _e424);
            let _e427 = cellCenter[0u];
            cx = i32(floor(_e427));
            let _e431 = cellCenter[2u];
            cz = i32(floor(_e431));
            let _e434 = cx;
            let _e435 = (_e434 >= 0i);
            phi_2548_ = _e435;
            if _e435 {
                let _e436 = cx;
                let _e438 = tuning.gridWidth;
                phi_2548_ = (_e436 < bitcast<i32>(_e438));
            }
            let _e442 = phi_2548_;
            let _e443 = cz;
            let _e445 = (_e442 && (_e443 >= 0i));
            phi_2559_ = _e445;
            if _e445 {
                let _e446 = cz;
                let _e448 = tuning.gridDepth;
                phi_2559_ = (_e446 < bitcast<i32>(_e448));
            }
            let _e452 = phi_2559_;
            if _e452 {
                let _e453 = cx;
                param = _e453;
                let _e454 = cz;
                param_1 = _e454;
                let _e455 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param), (&param_1));
                base = _e455;
                let _e456 = base;
                let _e460 = unnamed.cloudColumn[(_e456 + 2u)];
                count = _e460;
                let _e461 = count;
                if (_e461 > 0u) {
                    let _e463 = base;
                    let _e467 = unnamed.cloudColumn[(_e463 + 3u)];
                    baseY = f32(_e467);
                    let _e469 = count;
                    let _e472 = tuning.cloudThicknessPerBlock;
                    thickness = (f32(_e469) * max(_e472, 0.01f));
                    let _e475 = baseY;
                    let _e476 = thickness;
                    capY = (_e475 + _e476);
                    let _e479 = cellCenter[1u];
                    let _e480 = baseY;
                    let _e481 = (_e479 >= _e480);
                    phi_2607_ = _e481;
                    if _e481 {
                        let _e483 = cellCenter[1u];
                        let _e484 = capY;
                        phi_2607_ = (_e483 <= _e484);
                    }
                    let _e487 = phi_2607_;
                    if _e487 {
                        let _e488 = count;
                        let _e491 = tuning.cloudColumnFullCount;
                        density = clamp((f32(_e488) / max(_e491, 1f)), 0f, 1f);
                        let _e495 = baseY;
                        let _e496 = capY;
                        mid = ((_e495 + _e496) * 0.5f);
                        let _e500 = cellCenter[1u];
                        let _e501 = mid;
                        let _e504 = thickness;
                        edgeFactor = clamp((abs((_e500 - _e501)) / max((_e504 * 0.5f), 0.001f)), 0f, 1f);
                        let _e510 = tuning.cloudEdgeThresholdMin;
                        let _e512 = tuning.cloudEdgeThresholdMax;
                        let _e513 = edgeFactor;
                        threshold = mix(_e510, _e512, _e513);
                        let _e515 = threshold;
                        let _e516 = density;
                        threshold = mix(1f, _e515, _e516);
                        let _e518 = cellPos;
                        param_2 = vec3<f32>(_e518);
                        let _e520 = hash_u0028_vf3_u003b((&param_2));
                        fillHash = _e520;
                        let _e521 = fillHash;
                        let _e522 = threshold;
                        if (_e521 > _e522) {
                            let _e524 = t;
                            (*tHit) = _e524;
                            let _e525 = density;
                            (*hitDensity) = _e525;
                            let _e526 = cellPos;
                            param_3 = ((vec3<f32>(_e526) * 3.71f) + vec3<f32>(91f, 5f, 7f));
                            let _e530 = hash_u0028_vf3_u003b((&param_3));
                            shadeHash = _e530;
                            let _e531 = shadeHash;
                            baseColor = mix(vec3<f32>(0.76f, 0.76f, 0.78f), vec3<f32>(1f, 1f, 1f), vec3(_e531));
                            stormColor = vec3<f32>(0.32f, 0.33f, 0.36f);
                            let _e534 = baseColor;
                            let _e535 = stormColor;
                            let _e536 = (*greyness);
                            baseColor = mix(_e534, _e535, vec3(_e536));
                            let _e539 = normal;
                            let _e540 = (*sunDir);
                            diffuse = (0.6f + (0.4f * max(dot(_e539, _e540), 0f)));
                            let _e545 = baseColor;
                            let _e546 = diffuse;
                            (*hitColor) = (_e545 * _e546);
                            return true;
                        }
                    }
                }
            }
            let _e549 = tMax[0u];
            let _e551 = tMax[1u];
            if (_e549 < _e551) {
                let _e554 = tMax[0u];
                let _e556 = tMax[2u];
                if (_e554 < _e556) {
                    let _e559 = stepDir[0u];
                    let _e561 = cellPos[0u];
                    cellPos[0u] = (_e561 + _e559);
                    let _e565 = tMax[0u];
                    t = _e565;
                    let _e567 = tDelta[0u];
                    let _e569 = tMax[0u];
                    tMax[0u] = (_e569 + _e567);
                    let _e573 = stepDir[0u];
                    normal = vec3<f32>(f32(-(_e573)), 0f, 0f);
                } else {
                    let _e578 = stepDir[2u];
                    let _e580 = cellPos[2u];
                    cellPos[2u] = (_e580 + _e578);
                    let _e584 = tMax[2u];
                    t = _e584;
                    let _e586 = tDelta[2u];
                    let _e588 = tMax[2u];
                    tMax[2u] = (_e588 + _e586);
                    let _e592 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e592)));
                }
            } else {
                let _e597 = tMax[1u];
                let _e599 = tMax[2u];
                if (_e597 < _e599) {
                    let _e602 = stepDir[1u];
                    let _e604 = cellPos[1u];
                    cellPos[1u] = (_e604 + _e602);
                    let _e608 = tMax[1u];
                    t = _e608;
                    let _e610 = tDelta[1u];
                    let _e612 = tMax[1u];
                    tMax[1u] = (_e612 + _e610);
                    let _e616 = stepDir[1u];
                    normal = vec3<f32>(0f, f32(-(_e616)), 0f);
                } else {
                    let _e621 = stepDir[2u];
                    let _e623 = cellPos[2u];
                    cellPos[2u] = (_e623 + _e621);
                    let _e627 = tMax[2u];
                    t = _e627;
                    let _e629 = tDelta[2u];
                    let _e631 = tMax[2u];
                    tMax[2u] = (_e631 + _e629);
                    let _e635 = stepDir[2u];
                    normal = vec3<f32>(0f, 0f, f32(-(_e635)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e639 = i;
            i = (_e639 + 1i);
        }
    }
    return false;
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
    var i_1: u32;

    let _e259 = (*code);
    i_1 = (_e259 & 1073741823u);
    let _e261 = i_1;
    let _e263 = tuning.gridWidth;
    let _e268 = i_1;
    let _e270 = tuning.gridWidth;
    let _e275 = tuning.gridHeight;
    let _e280 = i_1;
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
    var param_4: u32;
    var volume: f32;

    level_1 = 0u;
    l = 1u;
    loop {
        let _e263 = l;
        let _e265 = tuning.blackHoleMaxLevel;
        if (_e263 <= min(_e265, 16u)) {
            let _e268 = l;
            param_4 = _e268;
            let _e269 = bhBodyRadius_u0028_u1_u003b((&param_4));
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
    var i_2: i32;
    var code_1: u32;
    var d: vec3<f32>;
    var param_5: u32;
    var closest: f32;
    var heat: f32;
    var hot: vec3<f32>;
    var phi_2253_: bool;
    var phi_2282_: bool;

    let _e270 = unnamed.blackHoleCount;
    let _e271 = (_e270 == 0u);
    phi_2253_ = _e271;
    if !(_e271) {
        let _e274 = tuning.blackHoleGlow;
        phi_2253_ = (_e274 <= 0f);
    }
    let _e277 = phi_2253_;
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
    i_2 = 0i;
    loop {
        let _e285 = i_2;
        let _e286 = (_e285 < 8i);
        phi_2282_ = _e286;
        if _e286 {
            let _e287 = seen;
            let _e289 = unnamed.blackHoleCount;
            phi_2282_ = (_e287 < _e289);
        }
        let _e292 = phi_2282_;
        if _e292 {
            let _e293 = i_2;
            let _e296 = unnamed.blackHoles[_e293];
            code_1 = _e296;
            let _e297 = code_1;
            if (_e297 == 0u) {
                continue;
            }
            let _e299 = seen;
            seen = (_e299 + bitcast<u32>(1i));
            let _e302 = code_1;
            param_5 = _e302;
            let _e303 = bhDecode_u0028_u1_u003b((&param_5));
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
            let _e312 = i_2;
            i_2 = (_e312 + 1i);
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
    var param_6: vec3<f32>;
    var dist: u32;
    var depth: f32;
    var inner: vec3<f32>;
    var outer: vec3<f32>;
    var leaf: vec3<f32>;

    let _e267 = (*voxelPos_1);
    param_6 = vec3<f32>(_e267);
    let _e269 = hash_u0028_vf3_u003b((&param_6));
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
    var param_7: vec3<f32>;
    var bark: vec3<f32>;

    let _e264 = (*voxelPos_2)[0u];
    let _e267 = (*voxelPos_2)[1u];
    let _e271 = (*subCell)[1u];
    let _e275 = (*voxelPos_2)[2u];
    param_7 = vec3<f32>(f32(_e264), ((f32(_e267) * 0.35f) + (_e271 * 0.2f)), f32(_e275));
    let _e278 = hash_u0028_vf3_u003b((&param_7));
    grain = _e278;
    let _e279 = grain;
    bark = mix(vec3<f32>(0.2f, 0.13f, 0.07f), vec3<f32>(0.38f, 0.25f, 0.13f), vec3(_e279));
    let _e282 = bark;
    let _e283 = (*baseLighting_1);
    return (_e282 * _e283);
}

fn renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b(voxelPos_3: ptr<function, vec3<i32>>, subCell_1: ptr<function, vec3<f32>>, baseLighting_2: ptr<function, vec3<f32>>) -> vec3<f32> {
    var n_1: f32;
    var param_8: vec3<f32>;
    var shell: vec3<f32>;

    let _e263 = (*subCell_1);
    let _e265 = (*voxelPos_3);
    param_8 = ((_e263 * 1.37f) + (vec3<f32>(_e265) * 0.11f));
    let _e269 = hash_u0028_vf3_u003b((&param_8));
    n_1 = _e269;
    let _e270 = n_1;
    shell = mix(vec3<f32>(0.15f, 0.1f, 0.035f), vec3<f32>(0.55f, 0.4f, 0.11f), vec3(_e270));
    let _e273 = shell;
    let _e274 = (*baseLighting_2);
    return (_e273 * _e274);
}

fn renderDarkStone_u0028_vi3_u003b_vf3_u003b(voxelPos_4: ptr<function, vec3<i32>>, baseLighting_3: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise: f32;
    var param_9: vec3<f32>;
    var val: f32;

    let _e262 = (*voxelPos_4);
    param_9 = vec3<f32>(_e262);
    let _e264 = hash_u0028_vf3_u003b((&param_9));
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

    let _e273 = (*rawVoxel_1);
    stage_1 = clamp((bitcast<i32>((_e273 & 255u)) - 8i), 0i, 3i);
    let _e279 = pc.time;
    let _e281 = tuning.lavaChurnRate;
    let _e283 = (*voxelPos_5);
    param_10 = vec3<f32>(_e283);
    let _e285 = hash_u0028_vf3_u003b((&param_10));
    phase = fract(((_e279 * _e281) + _e285));
    let _e288 = phase;
    if (_e288 < 0.33333334f) {
        let _e290 = stage_1;
        param_11 = (_e290 - 1i);
        let _e292 = lavaStageColor_u0028_i1_u003b((&param_11));
        from_ = _e292;
        let _e293 = stage_1;
        param_12 = _e293;
        let _e294 = lavaStageColor_u0028_i1_u003b((&param_12));
        to = _e294;
        let _e295 = phase;
        leg = (_e295 * 3f);
    } else {
        let _e297 = phase;
        if (_e297 < 0.6666667f) {
            let _e299 = stage_1;
            param_13 = _e299;
            let _e300 = lavaStageColor_u0028_i1_u003b((&param_13));
            from_ = _e300;
            let _e301 = stage_1;
            param_14 = (_e301 + 1i);
            let _e303 = lavaStageColor_u0028_i1_u003b((&param_14));
            to = _e303;
            let _e304 = phase;
            leg = ((_e304 * 3f) - 1f);
        } else {
            let _e307 = stage_1;
            param_15 = (_e307 + 1i);
            let _e309 = lavaStageColor_u0028_i1_u003b((&param_15));
            from_ = _e309;
            let _e310 = stage_1;
            param_16 = (_e310 - 1i);
            let _e312 = lavaStageColor_u0028_i1_u003b((&param_16));
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
    param_17 = (vec3<f32>(_e323) * 1.7f);
    let _e326 = hash_u0028_vf3_u003b((&param_17));
    return (_e322 * (0.9f + (_e326 * 0.1f)));
}

fn renderSteam_u0028_vi3_u003b_vf3_u003b(voxelPos_6: ptr<function, vec3<i32>>, baseLighting_4: ptr<function, vec3<f32>>) -> vec3<f32> {
    var noise_1: f32;
    var param_18: vec3<f32>;
    var val_1: f32;
    var baseColor_1: vec3<f32>;

    let _e263 = (*voxelPos_6);
    let _e266 = pc.time;
    param_18 = (vec3<f32>(_e263) + vec3(_e266));
    let _e269 = hash_u0028_vf3_u003b((&param_18));
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
    var param_19: vec3<f32>;
    var age: u32;
    var life: f32;
    var coreColor: vec3<f32>;
    var edgeColor: vec3<f32>;
    var fireColor: vec3<f32>;

    let _e266 = (*voxelPos_7);
    let _e269 = pc.time;
    param_19 = (vec3<f32>(_e266) + vec3((_e269 * 10f)));
    let _e273 = hash_u0028_vf3_u003b((&param_19));
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

    let _e273 = (*voxelPos_8);
    param_20 = vec3<f32>(_e273);
    let _e275 = hash_u0028_vf3_u003b((&param_20));
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
    phi_1254_ = _e311;
    if _e311 {
        let _e313 = (*ddaNormal)[1u];
        phi_1254_ = (_e313 > 0.5f);
    }
    let _e316 = phi_1254_;
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
    var param_21: vec3<f32>;
    var val_3: f32;
    var baseColor_3: vec3<f32>;

    let _e263 = (*voxelPos_9);
    param_21 = vec3<f32>(_e263);
    let _e265 = hash_u0028_vf3_u003b((&param_21));
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
    var phi_269_: bool;
    var phi_277_: bool;
    var phi_287_: bool;
    var phi_295_: bool;
    var phi_305_: bool;

    let _e260 = (*pos)[0u];
    let _e261 = (_e260 < 0i);
    phi_269_ = _e261;
    if !(_e261) {
        let _e264 = (*pos)[0u];
        let _e266 = tuning.gridWidth;
        phi_269_ = (_e264 >= bitcast<i32>(_e266));
    }
    let _e270 = phi_269_;
    phi_277_ = _e270;
    if !(_e270) {
        let _e273 = (*pos)[1u];
        phi_277_ = (_e273 < 0i);
    }
    let _e276 = phi_277_;
    phi_287_ = _e276;
    if !(_e276) {
        let _e279 = (*pos)[1u];
        let _e281 = tuning.gridHeight;
        phi_287_ = (_e279 >= bitcast<i32>(_e281));
    }
    let _e285 = phi_287_;
    phi_295_ = _e285;
    if !(_e285) {
        let _e288 = (*pos)[2u];
        phi_295_ = (_e288 < 0i);
    }
    let _e291 = phi_295_;
    phi_305_ = _e291;
    if !(_e291) {
        let _e294 = (*pos)[2u];
        let _e296 = tuning.gridDepth;
        phi_305_ = (_e294 >= bitcast<i32>(_e296));
    }
    let _e300 = phi_305_;
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

    let _e272 = (*hitVoxelPos);
    let _e273 = (*hitNormal);
    voxelPos_11 = (_e272 + vec3<i32>(round(_e273)));
    let _e277 = (*lightDir);
    stepDir_1 = vec3<i32>(sign(_e277));
    let _e281 = (*lightDir)[0u];
    if (_e281 == 0f) {
        local_6 = 100000000f;
    } else {
        let _e284 = (*lightDir)[0u];
        local_6 = abs((1f / _e284));
    }
    let _e287 = local_6;
    let _e289 = (*lightDir)[1u];
    if (_e289 == 0f) {
        local_7 = 100000000f;
    } else {
        let _e292 = (*lightDir)[1u];
        local_7 = abs((1f / _e292));
    }
    let _e295 = local_7;
    let _e297 = (*lightDir)[2u];
    if (_e297 == 0f) {
        local_8 = 100000000f;
    } else {
        let _e300 = (*lightDir)[2u];
        local_8 = abs((1f / _e300));
    }
    let _e303 = local_8;
    tDelta_1 = vec3<f32>(_e287, _e295, _e303);
    let _e305 = tDelta_1;
    tMax_1 = (_e305 * 0.5f);
    transmittance = 1f;
    i_3 = 0i;
    loop {
        let _e307 = i_3;
        let _e309 = tuning.shadowMaxSteps;
        if (_e307 < bitcast<i32>(_e309)) {
            let _e313 = voxelPos_11[0u];
            let _e314 = (_e313 < 0i);
            phi_586_ = _e314;
            if !(_e314) {
                let _e317 = voxelPos_11[0u];
                let _e319 = tuning.gridWidth;
                phi_586_ = (_e317 >= bitcast<i32>(_e319));
            }
            let _e323 = phi_586_;
            phi_593_ = _e323;
            if !(_e323) {
                let _e326 = voxelPos_11[1u];
                phi_593_ = (_e326 < 0i);
            }
            let _e329 = phi_593_;
            phi_601_ = _e329;
            if !(_e329) {
                let _e332 = voxelPos_11[1u];
                let _e333 = (*ceilingY);
                phi_601_ = (_e332 >= _e333);
            }
            let _e336 = phi_601_;
            phi_608_ = _e336;
            if !(_e336) {
                let _e339 = voxelPos_11[2u];
                phi_608_ = (_e339 < 0i);
            }
            let _e342 = phi_608_;
            phi_618_ = _e342;
            if !(_e342) {
                let _e345 = voxelPos_11[2u];
                let _e347 = tuning.gridDepth;
                phi_618_ = (_e345 >= bitcast<i32>(_e347));
            }
            let _e351 = phi_618_;
            if _e351 {
                let _e352 = transmittance;
                return _e352;
            }
            let _e353 = voxelPos_11;
            param_22 = _e353;
            let _e354 = getVoxel_u0028_vi3_u003b((&param_22));
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
            let _e429 = i_3;
            i_3 = (_e429 + 1i);
        }
    }
    let _e431 = transmittance;
    return _e431;
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
        let _e264 = x_1;
        if (_e264 <= 1i) {
            y = -1i;
            loop {
                let _e266 = y;
                if (_e266 <= 1i) {
                    z_1 = -1i;
                    loop {
                        let _e268 = z_1;
                        if (_e268 <= 1i) {
                            let _e270 = x_1;
                            let _e272 = y;
                            let _e275 = z_1;
                            if (((_e270 == 0i) && (_e272 == 0i)) && (_e275 == 0i)) {
                                continue;
                            }
                            let _e278 = (*p_1);
                            let _e279 = x_1;
                            let _e280 = y;
                            let _e281 = z_1;
                            param_23 = (_e278 + vec3<i32>(_e279, _e280, _e281));
                            let _e284 = getVoxel_u0028_vi3_u003b((&param_23));
                            if ((_e284 & 255u) == 0u) {
                                continue;
                            }
                            let _e287 = x_1;
                            let _e289 = y;
                            let _e291 = z_1;
                            offset = vec3<f32>(f32(_e287), f32(_e289), f32(_e291));
                            let _e294 = offset;
                            let _e295 = x_1;
                            let _e296 = x_1;
                            let _e298 = y;
                            let _e299 = y;
                            let _e302 = z_1;
                            let _e303 = z_1;
                            let _e309 = n_2;
                            n_2 = (_e309 - (_e294 * inverseSqrt(f32((((_e295 * _e296) + (_e298 * _e299)) + (_e302 * _e303))))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e311 = z_1;
                            z_1 = (_e311 + 1i);
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
            let _e315 = x_1;
            x_1 = (_e315 + 1i);
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
    var i_4: i32;
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
    i_4 = 0i;
    loop {
        let _e297 = i_4;
        if (_e297 < 5i) {
            let _e299 = i_4;
            indexable_1 = array<f32, 5>(0.11f, 0.19f, 0.31f, 0.53f, 0.87f);
            let _e301 = indexable_1[_e299];
            let _e302 = scale;
            f = (_e301 * _e302);
            let _e304 = i_4;
            indexable_2 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e306 = indexable_2[_e304];
            let _e307 = q;
            let _e309 = f;
            let _e311 = (*t_1);
            let _e312 = i_4;
            indexable_3 = array<f32, 5>(1f, 1.37f, 0.83f, 1.71f, 0.61f);
            let _e314 = indexable_3[_e312];
            let _e317 = tuning.waterWaveSpeed;
            phase_1 = ((dot(_e306, _e307) * _e309) + ((_e311 * _e314) * _e317));
            let _e320 = i_4;
            indexable_4 = array<vec2<f32>, 5>(vec2<f32>(0.86f, 0.51f), vec2<f32>(-0.421f, 0.907f), vec2<f32>(0.707f, -0.707f), vec2<f32>(-0.966f, -0.259f), vec2<f32>(0.259f, 0.966f));
            let _e322 = indexable_4[_e320];
            let _e323 = i_4;
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
            let _e334 = i_4;
            i_4 = (_e334 + 1i);
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
    var param_24: vec2<f32>;
    var param_25: f32;

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
    param_24 = (vec2<f32>(_e273.xz) + vec2<f32>(0.5f, 0.5f));
    let _e278 = pc.time;
    param_25 = _e278;
    let _e279 = waterWaveGradient_u0028_vf2_u003b_f1_u003b((&param_24), (&param_25));
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
    var x_2: i32;
    var y_1: i32;
    var z_2: i32;
    var d2_: i32;
    var param_26: vec3<i32>;

    n_3 = vec3<f32>(0f, 0f, 0f);
    x_2 = -2i;
    loop {
        let _e264 = x_2;
        if (_e264 <= 2i) {
            y_1 = -2i;
            loop {
                let _e266 = y_1;
                if (_e266 <= 2i) {
                    z_2 = -2i;
                    loop {
                        let _e268 = z_2;
                        if (_e268 <= 2i) {
                            let _e270 = x_2;
                            let _e272 = y_1;
                            let _e275 = z_2;
                            if (((_e270 == 0i) && (_e272 == 0i)) && (_e275 == 0i)) {
                                continue;
                            }
                            let _e278 = x_2;
                            let _e279 = x_2;
                            let _e281 = y_1;
                            let _e282 = y_1;
                            let _e285 = z_2;
                            let _e286 = z_2;
                            d2_ = (((_e278 * _e279) + (_e281 * _e282)) + (_e285 * _e286));
                            let _e289 = d2_;
                            if (_e289 > 6i) {
                                continue;
                            }
                            let _e291 = (*p_3);
                            let _e292 = x_2;
                            let _e293 = y_1;
                            let _e294 = z_2;
                            param_26 = (_e291 + vec3<i32>(_e292, _e293, _e294));
                            let _e297 = getVoxel_u0028_vi3_u003b((&param_26));
                            if ((_e297 & 255u) == 0u) {
                                continue;
                            }
                            let _e300 = x_2;
                            let _e302 = y_1;
                            let _e304 = z_2;
                            let _e307 = d2_;
                            let _e311 = n_3;
                            n_3 = (_e311 - (vec3<f32>(f32(_e300), f32(_e302), f32(_e304)) / vec3(f32(_e307))));
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e313 = z_2;
                            z_2 = (_e313 + 1i);
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
            let _e317 = x_2;
            x_2 = (_e317 + 1i);
        }
    }
    let _e319 = n_3;
    if (length(_e319) < 0.001f) {
        return vec3<f32>(0f, 1f, 0f);
    }
    let _e322 = n_3;
    return normalize(_e322);
}

fn locustDensity_u0028_u1_u003b(type_37: ptr<function, u32>) -> f32 {
    var stage_2: f32;

    let _e259 = (*type_37);
    stage_2 = (f32((_e259 - 13u)) / 4f);
    let _e264 = tuning.locustDensityMin;
    let _e266 = tuning.locustDensityMax;
    let _e267 = stage_2;
    return clamp(mix(_e264, _e266, _e267), 0.02f, 0.98f);
}

fn trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b(voxelPos_13: ptr<function, vec3<i32>>, a: ptr<function, vec2<f32>>, b: ptr<function, vec2<f32>>, count_1: ptr<function, i32>) {
    var h0_: f32;
    var param_27: vec3<f32>;
    var h1_: f32;
    var param_28: vec3<f32>;
    var h2_: f32;
    var param_29: vec3<f32>;

    let _e268 = (*voxelPos_13)[0u];
    let _e271 = (*voxelPos_13)[2u];
    param_27 = vec3<f32>(f32(_e268), 7f, f32(_e271));
    let _e274 = hash_u0028_vf3_u003b((&param_27));
    h0_ = _e274;
    let _e276 = (*voxelPos_13)[0u];
    let _e279 = (*voxelPos_13)[2u];
    param_28 = vec3<f32>(f32(_e276), 19f, f32(_e279));
    let _e282 = hash_u0028_vf3_u003b((&param_28));
    h1_ = _e282;
    let _e284 = (*voxelPos_13)[0u];
    let _e287 = (*voxelPos_13)[2u];
    param_29 = vec3<f32>(f32(_e284), 53f, f32(_e287));
    let _e290 = hash_u0028_vf3_u003b((&param_29));
    h2_ = _e290;
    let _e291 = h2_;
    let _e293 = tuning.treeTrunkColumns;
    (*count_1) = (1i + i32((_e291 * f32(max(bitcast<i32>(_e293), 1i)))));
    let _e300 = (*count_1);
    (*count_1) = clamp(_e300, 1i, 2i);
    let _e302 = h0_;
    let _e305 = h1_;
    (*a) = vec2<f32>((0.3f + (_e302 * 0.4f)), (0.3f + (_e305 * 0.4f)));
    let _e309 = h1_;
    let _e312 = h0_;
    (*b) = vec2<f32>((0.3f + (_e309 * 0.4f)), (0.3f + (_e312 * 0.4f)));
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

    let _e274 = (*kind);
    if (_e274 == 1u) {
        let _e276 = (*cell);
        let _e281 = (*sub);
        p_4 = ((vec2<f32>(_e276.xz) + vec2(0.5f)) / vec2(f32(_e281)));
        let _e285 = (*voxelPos_14);
        param_30 = _e285;
        trunkStems_u0028_vi3_u003b_vf2_u003b_vf2_u003b_i1_u003b((&param_30), (&param_31), (&param_32), (&param_33));
        let _e286 = param_31;
        a_1 = _e286;
        let _e287 = param_32;
        b_1 = _e287;
        let _e288 = param_33;
        count_2 = _e288;
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
        let _e303 = count_2;
        let _e304 = (_e303 > 1i);
        phi_1620_ = _e304;
        if _e304 {
            let _e305 = p_4;
            let _e306 = b_1;
            let _e308 = p_4;
            let _e309 = b_1;
            let _e312 = r_1;
            let _e313 = r_1;
            phi_1620_ = (dot((_e305 - _e306), (_e308 - _e309)) <= (_e312 * _e313));
        }
        let _e317 = phi_1620_;
        if _e317 {
            return true;
        }
        return false;
    }
    let _e318 = (*voxelPos_14);
    let _e319 = (*sub);
    let _e322 = (*cell);
    let _e325 = (*jitter);
    param_34 = (vec3<f32>(((_e318 * vec3(_e319)) + _e322)) + _e325);
    let _e327 = hash_u0028_vf3_u003b((&param_34));
    let _e328 = (*type_38);
    param_35 = _e328;
    let _e329 = locustDensity_u0028_u1_u003b((&param_35));
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
    param_36 = _e308;
    let _e309 = (*rayDir_2);
    param_37 = _e309;
    let _e310 = boxMin_1;
    param_38 = _e310;
    param_39 = (_e306 + vec3<f32>(1f, 1f, 1f));
    let _e311 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_36), (&param_37), (&param_38), (&param_39));
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
    local_9 = (((_e319 + (_e320 * (_e321 + 0.0001f))) - _e325) * f32(_e327));
    let _e330 = local_9;
    let _e333 = sub_1;
    c = clamp(vec3<i32>(floor(_e330)), vec3<i32>(0i, 0i, 0i), vec3((_e333 - 1i)));
    let _e337 = (*rayDir_2);
    stepDir_2 = vec3<i32>(sign(_e337));
    let _e341 = (*rayDir_2)[0u];
    if (_e341 == 0f) {
        local_10 = 1000000f;
    } else {
        let _e343 = cellSize;
        let _e345 = (*rayDir_2)[0u];
        local_10 = abs((_e343 / _e345));
    }
    let _e348 = local_10;
    let _e350 = (*rayDir_2)[1u];
    if (_e350 == 0f) {
        local_11 = 1000000f;
    } else {
        let _e352 = cellSize;
        let _e354 = (*rayDir_2)[1u];
        local_11 = abs((_e352 / _e354));
    }
    let _e357 = local_11;
    let _e359 = (*rayDir_2)[2u];
    if (_e359 == 0f) {
        local_12 = 1000000f;
    } else {
        let _e361 = cellSize;
        let _e363 = (*rayDir_2)[2u];
        local_12 = abs((_e361 / _e363));
    }
    let _e366 = local_12;
    tDelta_2 = vec3<f32>(_e348, _e357, _e366);
    let _e368 = local_9;
    let _e369 = c;
    fracPos_1 = (_e368 - vec3<f32>(_e369));
    let _e372 = t_2;
    let _e374 = stepDir_2[0u];
    if (_e374 > 0i) {
        let _e377 = fracPos_1[0u];
        let _e380 = tDelta_2[0u];
        local_13 = ((1f - _e377) * _e380);
    } else {
        let _e383 = fracPos_1[0u];
        let _e385 = tDelta_2[0u];
        local_13 = (_e383 * _e385);
    }
    let _e387 = local_13;
    let _e389 = stepDir_2[1u];
    if (_e389 > 0i) {
        let _e392 = fracPos_1[1u];
        let _e395 = tDelta_2[1u];
        local_14 = ((1f - _e392) * _e395);
    } else {
        let _e398 = fracPos_1[1u];
        let _e400 = tDelta_2[1u];
        local_14 = (_e398 * _e400);
    }
    let _e402 = local_14;
    let _e404 = stepDir_2[2u];
    if (_e404 > 0i) {
        let _e407 = fracPos_1[2u];
        let _e410 = tDelta_2[2u];
        local_15 = ((1f - _e407) * _e410);
    } else {
        let _e413 = fracPos_1[2u];
        let _e415 = tDelta_2[2u];
        local_15 = (_e413 * _e415);
    }
    let _e417 = local_15;
    tMax_3 = (vec3(_e372) + vec3<f32>(_e387, _e402, _e417));
    let _e421 = (*kind_1);
    if (_e421 == 0u) {
        let _e424 = pc.time;
        let _e426 = tuning.locustCrawlRate;
        local_16 = vec3((floor((_e424 * _e426)) * 1.7f));
    } else {
        local_16 = vec3<f32>(0f, 0f, 0f);
    }
    let _e431 = local_16;
    jitter_1 = _e431;
    i_5 = 0i;
    loop {
        let _e432 = i_5;
        let _e433 = sub_1;
        if (_e432 < (3i * _e433)) {
            let _e437 = c[0u];
            let _e438 = (_e437 < 0i);
            phi_1852_ = _e438;
            if !(_e438) {
                let _e441 = c[0u];
                let _e442 = sub_1;
                phi_1852_ = (_e441 >= _e442);
            }
            let _e445 = phi_1852_;
            phi_1859_ = _e445;
            if !(_e445) {
                let _e448 = c[1u];
                phi_1859_ = (_e448 < 0i);
            }
            let _e451 = phi_1859_;
            phi_1867_ = _e451;
            if !(_e451) {
                let _e454 = c[1u];
                let _e455 = sub_1;
                phi_1867_ = (_e454 >= _e455);
            }
            let _e458 = phi_1867_;
            phi_1874_ = _e458;
            if !(_e458) {
                let _e461 = c[2u];
                phi_1874_ = (_e461 < 0i);
            }
            let _e464 = phi_1874_;
            phi_1882_ = _e464;
            if !(_e464) {
                let _e467 = c[2u];
                let _e468 = sub_1;
                phi_1882_ = (_e467 >= _e468);
            }
            let _e471 = phi_1882_;
            if _e471 {
                return false;
            }
            let _e472 = (*kind_1);
            param_40 = _e472;
            let _e473 = (*type_39);
            param_41 = _e473;
            let _e474 = (*voxelPos_15);
            param_42 = _e474;
            let _e475 = c;
            param_43 = _e475;
            let _e476 = sub_1;
            param_44 = _e476;
            let _e477 = jitter_1;
            param_45 = _e477;
            let _e478 = subOccupied_u0028_u1_u003b_u1_u003b_vi3_u003b_vi3_u003b_i1_u003b_vf3_u003b((&param_40), (&param_41), (&param_42), (&param_43), (&param_44), (&param_45));
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
            let _e573 = i_5;
            i_5 = (_e573 + 1i);
        }
    }
    return false;
}

fn isLocustType_u0028_u1_u003b(type_40: ptr<function, u32>) -> bool {
    let _e258 = (*type_40);
    let _e260 = (*type_40);
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
    var thickness_1: f32;
    var boundCount: i32;
    var extent: vec3<f32>;
    var phi_461_: bool;
    var phi_480_: bool;
    var phi_499_: bool;

    thickness_1 = 0.3f;
    boundCount = 0i;
    let _e261 = worldExtent_u0028_();
    extent = _e261;
    let _e263 = (*p_5)[0u];
    let _e264 = thickness_1;
    let _e265 = (_e263 < _e264);
    phi_461_ = _e265;
    if !(_e265) {
        let _e268 = (*p_5)[0u];
        let _e270 = extent[0u];
        let _e271 = thickness_1;
        phi_461_ = (_e268 > (_e270 - _e271));
    }
    let _e275 = phi_461_;
    if _e275 {
        let _e276 = boundCount;
        boundCount = (_e276 + 1i);
    }
    let _e279 = (*p_5)[1u];
    let _e280 = thickness_1;
    let _e281 = (_e279 < _e280);
    phi_480_ = _e281;
    if !(_e281) {
        let _e284 = (*p_5)[1u];
        let _e286 = extent[1u];
        let _e287 = thickness_1;
        phi_480_ = (_e284 > (_e286 - _e287));
    }
    let _e291 = phi_480_;
    if _e291 {
        let _e292 = boundCount;
        boundCount = (_e292 + 1i);
    }
    let _e295 = (*p_5)[2u];
    let _e296 = thickness_1;
    let _e297 = (_e295 < _e296);
    phi_499_ = _e297;
    if !(_e297) {
        let _e300 = (*p_5)[2u];
        let _e302 = extent[2u];
        let _e303 = thickness_1;
        phi_499_ = (_e300 > (_e302 - _e303));
    }
    let _e307 = phi_499_;
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
    var param_46: f32;
    var param_47: f32;

    let _e261 = pc.pitch;
    param_46 = _e261;
    let _e262 = rot_u0028_f1_u003b((&param_46));
    let _e263 = (*v);
    let _e265 = (_e263.yz * _e262);
    (*v)[1u] = _e265.x;
    (*v)[2u] = _e265.y;
    let _e271 = pc.yaw;
    param_47 = _e271;
    let _e272 = rot_u0028_f1_u003b((&param_47));
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
    var phi_3908_: bool;
    var phi_3915_: bool;
    var phi_3924_: bool;
    var phi_3930_: bool;
    var phi_3939_: bool;
    var phi_4150_: bool;
    var phi_4192_: bool;
    var phi_4214_: bool;
    var phi_4236_: bool;
    var phi_4264_: bool;
    var phi_4286_: bool;
    var phi_4308_: bool;

    let _e464 = inUV_1;
    screenSpace = ((_e464 * 2f) - vec2(1f));
    let _e469 = screenSpace[1u];
    screenSpace[1u] = -(_e469);
    let _e473 = pc.aspectScaleX;
    let _e475 = screenSpace[0u];
    screenSpace[0u] = (_e475 * _e473);
    let _e479 = pc.aspectScaleY;
    let _e481 = screenSpace[1u];
    screenSpace[1u] = (_e481 * _e479);
    let _e485 = pc.camX;
    let _e487 = pc.camY;
    let _e489 = pc.camZ;
    baseOrigin = vec3<f32>(_e485, _e487, _e489);
    param_48 = vec3<f32>(0f, 0f, 1f);
    let _e491 = applyCameraRotation_u0028_vf3_u003b((&param_48));
    forward = _e491;
    param_49 = vec3<f32>(1f, 0f, 0f);
    let _e492 = applyCameraRotation_u0028_vf3_u003b((&param_49));
    right = _e492;
    param_50 = vec3<f32>(0f, 1f, 0f);
    let _e493 = applyCameraRotation_u0028_vf3_u003b((&param_50));
    up = _e493;
    let _e495 = pc.perspectiveBlend;
    t_3 = clamp(_e495, 0f, 1f);
    let _e497 = worldExtent_u0028_();
    cubeCenter = (_e497 * 0.5f);
    let _e499 = cubeCenter;
    let _e500 = baseOrigin;
    let _e502 = forward;
    viewDistance = max(1f, dot((_e499 - _e500), _e502));
    let _e505 = viewDistance;
    let _e507 = pc.fovDistance;
    orthoHalfSize = (_e505 / _e507);
    let _e510 = screenSpace[0u];
    let _e512 = screenSpace[1u];
    let _e514 = pc.fovDistance;
    let _e516 = t_3;
    localDir = mix(vec3<f32>(0f, 0f, 1f), vec3<f32>(_e510, _e512, _e514), vec3(_e516));
    let _e519 = right;
    let _e521 = localDir[0u];
    let _e523 = up;
    let _e525 = localDir[1u];
    let _e528 = forward;
    let _e530 = localDir[2u];
    rayDir_3 = normalize((((_e519 * _e521) + (_e523 * _e525)) + (_e528 * _e530)));
    let _e534 = right;
    let _e536 = screenSpace[0u];
    let _e538 = up;
    let _e540 = screenSpace[1u];
    let _e543 = orthoHalfSize;
    let _e545 = t_3;
    originOffset = ((((_e534 * _e536) + (_e538 * _e540)) * _e543) * (1f - _e545));
    let _e548 = baseOrigin;
    let _e549 = originOffset;
    rayOrigin_3 = (_e548 + _e549);
    finalColor = vec4<f32>(0.05f, 0.05f, 0.1f, 1f);
    finalDist = 1000000f;
    let _e551 = worldExtent_u0028_();
    let _e552 = rayOrigin_3;
    param_51 = _e552;
    let _e553 = rayDir_3;
    param_52 = _e553;
    param_53 = vec3<f32>(0f, 0f, 0f);
    param_54 = _e551;
    let _e554 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_51), (&param_52), (&param_53), (&param_54));
    aabbHit = _e554;
    hitFrontBox = false;
    hitBackBox = false;
    let _e556 = aabbHit[0u];
    let _e558 = aabbHit[1u];
    let _e559 = (_e556 < _e558);
    phi_2937_ = _e559;
    if _e559 {
        let _e561 = aabbHit[1u];
        phi_2937_ = (_e561 > 0f);
    }
    let _e564 = phi_2937_;
    if _e564 {
        let _e566 = aabbHit[0u];
        let _e567 = (_e566 > 0f);
        phi_2953_ = _e567;
        if _e567 {
            let _e568 = rayOrigin_3;
            let _e569 = rayDir_3;
            let _e571 = aabbHit[0u];
            param_55 = (_e568 + (_e569 * _e571));
            let _e574 = isEdge_u0028_vf3_u003b((&param_55));
            phi_2953_ = _e574;
        }
        let _e576 = phi_2953_;
        if _e576 {
            hitFrontBox = true;
        }
        let _e577 = rayOrigin_3;
        let _e578 = rayDir_3;
        let _e580 = aabbHit[1u];
        param_56 = (_e577 + (_e578 * _e580));
        let _e583 = isEdge_u0028_vf3_u003b((&param_56));
        if _e583 {
            hitBackBox = true;
        }
    }
    let _e584 = marchCeiling_u0028_();
    ceilingY_1 = _e584;
    let _e586 = tuning.gridWidth;
    let _e589 = ceilingY_1;
    let _e592 = tuning.gridDepth;
    let _e596 = rayOrigin_3;
    param_57 = _e596;
    let _e597 = rayDir_3;
    param_58 = _e597;
    param_59 = vec3<f32>(0f, 0f, 0f);
    param_60 = vec3<f32>(f32(bitcast<i32>(_e586)), f32(_e589), f32(bitcast<i32>(_e592)));
    let _e598 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_57), (&param_58), (&param_59), (&param_60));
    marchHit = _e598;
    let _e599 = rayOrigin_3;
    let _e600 = rayDir_3;
    let _e602 = marchHit[0u];
    currentPos = (_e599 + (_e600 * max(0f, _e602)));
    let _e607 = marchHit[0u];
    if (_e607 > 0f) {
        let _e609 = rayDir_3;
        let _e611 = currentPos;
        currentPos = (_e611 + (_e609 * 0.001f));
    }
    let _e613 = currentPos;
    voxelPos_16 = vec3<i32>(floor(_e613));
    let _e616 = rayDir_3;
    stepDir_3 = vec3<i32>(sign(_e616));
    let _e620 = rayDir_3[0u];
    if (_e620 == 0f) {
        local_17 = 100000000f;
    } else {
        let _e623 = rayDir_3[0u];
        local_17 = abs((1f / _e623));
    }
    let _e626 = local_17;
    let _e628 = rayDir_3[1u];
    if (_e628 == 0f) {
        local_18 = 100000000f;
    } else {
        let _e631 = rayDir_3[1u];
        local_18 = abs((1f / _e631));
    }
    let _e634 = local_18;
    let _e636 = rayDir_3[2u];
    if (_e636 == 0f) {
        local_19 = 100000000f;
    } else {
        let _e639 = rayDir_3[2u];
        local_19 = abs((1f / _e639));
    }
    let _e642 = local_19;
    tDelta_3 = vec3<f32>(_e626, _e634, _e642);
    let _e645 = stepDir_3[0u];
    if (_e645 > 0i) {
        let _e648 = currentPos[0u];
        let _e652 = currentPos[0u];
        let _e655 = tDelta_3[0u];
        local_20 = (((floor(_e648) + 1f) - _e652) * _e655);
    } else {
        let _e658 = currentPos[0u];
        let _e660 = currentPos[0u];
        let _e664 = tDelta_3[0u];
        local_20 = ((_e658 - floor(_e660)) * _e664);
    }
    let _e666 = local_20;
    let _e668 = stepDir_3[1u];
    if (_e668 > 0i) {
        let _e671 = currentPos[1u];
        let _e675 = currentPos[1u];
        let _e678 = tDelta_3[1u];
        local_21 = (((floor(_e671) + 1f) - _e675) * _e678);
    } else {
        let _e681 = currentPos[1u];
        let _e683 = currentPos[1u];
        let _e687 = tDelta_3[1u];
        local_21 = ((_e681 - floor(_e683)) * _e687);
    }
    let _e689 = local_21;
    let _e691 = stepDir_3[2u];
    if (_e691 > 0i) {
        let _e694 = currentPos[2u];
        let _e698 = currentPos[2u];
        let _e701 = tDelta_3[2u];
        local_22 = (((floor(_e694) + 1f) - _e698) * _e701);
    } else {
        let _e704 = currentPos[2u];
        let _e706 = currentPos[2u];
        let _e710 = tDelta_3[2u];
        local_22 = ((_e704 - floor(_e706)) * _e710);
    }
    let _e712 = local_22;
    tMax_4 = vec3<f32>(_e666, _e689, _e712);
    normal_4 = vec3<f32>(0f, 0f, 0f);
    hit = false;
    hitType = 0u;
    hitRawVoxel = 0u;
    subT = 0f;
    subNormal_1 = vec3<f32>(0f, 1f, 0f);
    subCell_3 = vec3<f32>(0f, 0f, 0f);
    let _e715 = aabbHit[1u];
    MAX_VISIBILITY = max(300f, (_e715 * 1.5f));
    i_6 = 0i;
    loop {
        let _e718 = i_6;
        let _e720 = tuning.marchMaxSteps;
        if (_e718 < bitcast<i32>(_e720)) {
            let _e724 = voxelPos_16[0u];
            let _e725 = (_e724 < 0i);
            phi_3169_ = _e725;
            if !(_e725) {
                let _e728 = voxelPos_16[0u];
                let _e730 = tuning.gridWidth;
                phi_3169_ = (_e728 >= bitcast<i32>(_e730));
            }
            let _e734 = phi_3169_;
            phi_3176_ = _e734;
            if !(_e734) {
                let _e737 = voxelPos_16[1u];
                phi_3176_ = (_e737 < 0i);
            }
            let _e740 = phi_3176_;
            phi_3184_ = _e740;
            if !(_e740) {
                let _e743 = voxelPos_16[1u];
                let _e744 = ceilingY_1;
                phi_3184_ = (_e743 >= _e744);
            }
            let _e747 = phi_3184_;
            phi_3191_ = _e747;
            if !(_e747) {
                let _e750 = voxelPos_16[2u];
                phi_3191_ = (_e750 < 0i);
            }
            let _e753 = phi_3191_;
            phi_3201_ = _e753;
            if !(_e753) {
                let _e756 = voxelPos_16[2u];
                let _e758 = tuning.gridDepth;
                phi_3201_ = (_e756 >= bitcast<i32>(_e758));
            }
            let _e762 = phi_3201_;
            if _e762 {
                break;
            }
            let _e763 = voxelPos_16;
            param_61 = _e763;
            let _e764 = getVoxel_u0028_vi3_u003b((&param_61));
            rawVoxel_5 = _e764;
            let _e765 = rawVoxel_5;
            hitType = (_e765 & 255u);
            let _e767 = hitType;
            if (_e767 == 7u) {
                hitType = 0u;
            }
            let _e769 = hitType;
            if (_e769 != 0u) {
                let _e771 = hitType;
                if (_e771 == 6u) {
                    let _e773 = rawVoxel_5;
                    age_1 = ((_e773 >> bitcast<u32>(24i)) & 255u);
                    let _e777 = age_1;
                    targetAlpha = mix(1f, 0.3f, clamp((f32(_e777) / 100f), 0f, 1f));
                    let _e782 = inUV_1;
                    let _e784 = pc.time;
                    dither = fract((sin(dot((_e782 + vec2((_e784 * 0.1f))), vec2<f32>(12.9898f, 78.233f))) * 43758.547f));
                    let _e792 = dither;
                    let _e793 = targetAlpha;
                    if (_e792 > _e793) {
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e795 = rawVoxel_5;
                        hitRawVoxel = _e795;
                        break;
                    }
                } else {
                    let _e796 = hitType;
                    param_62 = _e796;
                    let _e797 = isLocustType_u0028_u1_u003b((&param_62));
                    let _e798 = hitType;
                    if (_e797 || (_e798 == 18u)) {
                        let _e801 = hitType;
                        kind_2 = select(0u, 1u, (_e801 == 18u));
                        let _e804 = voxelPos_16;
                        param_63 = _e804;
                        let _e805 = rayOrigin_3;
                        param_64 = _e805;
                        let _e806 = rayDir_3;
                        param_65 = _e806;
                        let _e807 = kind_2;
                        param_66 = _e807;
                        let _e808 = hitType;
                        param_67 = _e808;
                        let _e809 = normal_4;
                        param_68 = _e809;
                        let _e810 = subMarch_u0028_vi3_u003b_vf3_u003b_vf3_u003b_u1_u003b_u1_u003b_vf3_u003b_f1_u003b_vf3_u003b_vf3_u003b((&param_63), (&param_64), (&param_65), (&param_66), (&param_67), (&param_68), (&param_69), (&param_70), (&param_71));
                        let _e811 = param_69;
                        subT = _e811;
                        let _e812 = param_70;
                        subNormal_1 = _e812;
                        let _e813 = param_71;
                        subCell_3 = _e813;
                        if _e810 {
                            hit = true;
                            let _e814 = rawVoxel_5;
                            hitRawVoxel = _e814;
                            break;
                        }
                        hitType = 0u;
                    } else {
                        hit = true;
                        let _e815 = rawVoxel_5;
                        hitRawVoxel = _e815;
                        break;
                    }
                }
            }
            let _e817 = tMax_4[0u];
            let _e819 = tMax_4[1u];
            if (_e817 < _e819) {
                let _e822 = tMax_4[0u];
                let _e824 = tMax_4[2u];
                if (_e822 < _e824) {
                    let _e827 = stepDir_3[0u];
                    let _e829 = voxelPos_16[0u];
                    voxelPos_16[0u] = (_e829 + _e827);
                    let _e833 = tDelta_3[0u];
                    let _e835 = tMax_4[0u];
                    tMax_4[0u] = (_e835 + _e833);
                    let _e839 = stepDir_3[0u];
                    normal_4 = vec3<f32>(f32(-(_e839)), 0f, 0f);
                } else {
                    let _e844 = stepDir_3[2u];
                    let _e846 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e846 + _e844);
                    let _e850 = tDelta_3[2u];
                    let _e852 = tMax_4[2u];
                    tMax_4[2u] = (_e852 + _e850);
                    let _e856 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e856)));
                }
            } else {
                let _e861 = tMax_4[1u];
                let _e863 = tMax_4[2u];
                if (_e861 < _e863) {
                    let _e866 = stepDir_3[1u];
                    let _e868 = voxelPos_16[1u];
                    voxelPos_16[1u] = (_e868 + _e866);
                    let _e872 = tDelta_3[1u];
                    let _e874 = tMax_4[1u];
                    tMax_4[1u] = (_e874 + _e872);
                    let _e878 = stepDir_3[1u];
                    normal_4 = vec3<f32>(0f, f32(-(_e878)), 0f);
                } else {
                    let _e883 = stepDir_3[2u];
                    let _e885 = voxelPos_16[2u];
                    voxelPos_16[2u] = (_e885 + _e883);
                    let _e889 = tDelta_3[2u];
                    let _e891 = tMax_4[2u];
                    tMax_4[2u] = (_e891 + _e889);
                    let _e895 = stepDir_3[2u];
                    normal_4 = vec3<f32>(0f, 0f, f32(-(_e895)));
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e899 = i_6;
            i_6 = (_e899 + 1i);
        }
    }
    let _e901 = hit;
    if _e901 {
        let _e902 = normal_4;
        if (length(_e902) < 0.1f) {
            let _e905 = rayDir_3;
            normal_4 = -(_e905);
        }
        let _e907 = normal_4;
        ddaNormal_1 = _e907;
        let _e908 = hitType;
        if (_e908 == 2u) {
            let _e910 = voxelPos_16;
            param_72 = _e910;
            let _e911 = getWaterNormal_u0028_vi3_u003b((&param_72));
            param_73 = _e911;
            let _e912 = voxelPos_16;
            param_74 = _e912;
            let _e913 = applyWaterWaves_u0028_vf3_u003b_vi3_u003b((&param_73), (&param_74));
            normal_4 = _e913;
        } else {
            let _e914 = hitType;
            param_75 = _e914;
            let _e915 = isLocustType_u0028_u1_u003b((&param_75));
            let _e916 = hitType;
            if (_e915 || (_e916 == 18u)) {
                let _e919 = subNormal_1;
                normal_4 = _e919;
            } else {
                let _e920 = voxelPos_16;
                param_76 = _e920;
                let _e921 = getSmoothNormal_u0028_vi3_u003b((&param_76));
                normal_4 = _e921;
            }
        }
        sunDir_2 = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        sunColor_1 = vec3<f32>(1f, 0.95f, 0.85f);
        ambientColor = vec3<f32>(0.15f, 0.2f, 0.3f);
        let _e922 = normal_4;
        let _e923 = sunDir_2;
        diffuse_1 = max(dot(_e922, _e923), 0f);
        let _e926 = voxelPos_16;
        param_77 = _e926;
        let _e927 = ddaNormal_1;
        param_78 = _e927;
        let _e928 = sunDir_2;
        param_79 = _e928;
        let _e929 = ceilingY_1;
        param_80 = _e929;
        let _e930 = calculateShadow_u0028_vi3_u003b_vf3_u003b_vf3_u003b_i1_u003b((&param_77), (&param_78), (&param_79), (&param_80));
        shadow_1 = _e930;
        let _e931 = ambientColor;
        let _e932 = sunColor_1;
        let _e933 = diffuse_1;
        let _e935 = shadow_1;
        baseLighting_9 = (_e931 + ((_e932 * _e933) * _e935));
        let _e938 = baseLighting_9;
        finalVoxelColor = (vec3<f32>(1f, 0f, 1f) * _e938);
        let _e940 = hitType;
        switch bitcast<i32>(_e940) {
            case 1: {
                let _e942 = hitRawVoxel;
                param_81 = _e942;
                let _e943 = baseLighting_9;
                param_82 = _e943;
                let _e944 = renderSand_u0028_u1_u003b_vf3_u003b((&param_81), (&param_82));
                finalVoxelColor = _e944;
                break;
            }
            case 2: {
                let _e945 = voxelPos_16;
                param_83 = _e945;
                let _e946 = normal_4;
                param_84 = _e946;
                let _e947 = rayOrigin_3;
                param_85 = _e947;
                let _e948 = sunDir_2;
                param_86 = _e948;
                let _e949 = sunColor_1;
                param_87 = _e949;
                let _e950 = shadow_1;
                param_88 = _e950;
                let _e951 = baseLighting_9;
                param_89 = _e951;
                let _e952 = renderWater_u0028_vi3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b_f1_u003b_vf3_u003b((&param_83), (&param_84), (&param_85), (&param_86), (&param_87), (&param_88), (&param_89));
                finalVoxelColor = _e952;
                break;
            }
            case 3: {
                let _e953 = voxelPos_16;
                param_90 = _e953;
                let _e954 = baseLighting_9;
                param_91 = _e954;
                let _e955 = renderStone_u0028_vi3_u003b_vf3_u003b((&param_90), (&param_91));
                finalVoxelColor = _e955;
                break;
            }
            case 4: {
                let _e956 = hitRawVoxel;
                param_92 = _e956;
                let _e957 = voxelPos_16;
                param_93 = _e957;
                let _e958 = ddaNormal_1;
                param_94 = _e958;
                let _e959 = baseLighting_9;
                param_95 = _e959;
                let _e960 = renderDirt_u0028_u1_u003b_vi3_u003b_vf3_u003b_vf3_u003b((&param_92), (&param_93), (&param_94), (&param_95));
                finalVoxelColor = _e960;
                break;
            }
            case 5: {
                let _e961 = hitRawVoxel;
                param_96 = _e961;
                let _e962 = voxelPos_16;
                param_97 = _e962;
                let _e963 = renderFire_u0028_u1_u003b_vi3_u003b((&param_96), (&param_97));
                finalVoxelColor = _e963;
                break;
            }
            case 6: {
                let _e964 = voxelPos_16;
                param_98 = _e964;
                let _e965 = baseLighting_9;
                param_99 = _e965;
                let _e966 = renderSteam_u0028_vi3_u003b_vf3_u003b((&param_98), (&param_99));
                finalVoxelColor = _e966;
                break;
            }
            case 9, 10, 11, 8: {
                let _e967 = hitRawVoxel;
                param_100 = _e967;
                let _e968 = voxelPos_16;
                param_101 = _e968;
                let _e969 = renderLava_u0028_u1_u003b_vi3_u003b((&param_100), (&param_101));
                finalVoxelColor = _e969;
                break;
            }
            case 12: {
                let _e970 = voxelPos_16;
                param_102 = _e970;
                let _e971 = baseLighting_9;
                param_103 = _e971;
                let _e972 = renderDarkStone_u0028_vi3_u003b_vf3_u003b((&param_102), (&param_103));
                finalVoxelColor = _e972;
                break;
            }
            case 14, 15, 16, 17, 13: {
                let _e973 = voxelPos_16;
                param_104 = _e973;
                let _e974 = subCell_3;
                param_105 = _e974;
                let _e975 = baseLighting_9;
                param_106 = _e975;
                let _e976 = renderLocust_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_104), (&param_105), (&param_106));
                finalVoxelColor = _e976;
                break;
            }
            case 18: {
                let _e977 = voxelPos_16;
                param_107 = _e977;
                let _e978 = subCell_3;
                param_108 = _e978;
                let _e979 = baseLighting_9;
                param_109 = _e979;
                let _e980 = renderTrunk_u0028_vi3_u003b_vf3_u003b_vf3_u003b((&param_107), (&param_108), (&param_109));
                finalVoxelColor = _e980;
                break;
            }
            case 19: {
                let _e981 = hitRawVoxel;
                param_110 = _e981;
                let _e982 = voxelPos_16;
                param_111 = _e982;
                let _e983 = baseLighting_9;
                param_112 = _e983;
                let _e984 = renderLeaf_u0028_u1_u003b_vi3_u003b_vf3_u003b((&param_110), (&param_111), (&param_112));
                finalVoxelColor = _e984;
                break;
            }
            default: {
                break;
            }
        }
        let _e985 = finalVoxelColor;
        param_113 = _e985;
        let _e986 = voxelPos_16;
        param_114 = _e986;
        let _e987 = accretionGlow_u0028_vf3_u003b_vi3_u003b((&param_113), (&param_114));
        finalVoxelColor = _e987;
        let _e988 = hitType;
        param_115 = _e988;
        let _e989 = isLocustType_u0028_u1_u003b((&param_115));
        let _e990 = hitType;
        if (_e989 || (_e990 == 18u)) {
            let _e993 = subT;
            local_23 = _e993;
        } else {
            let _e994 = voxelPos_16;
            let _e997 = rayOrigin_3;
            local_23 = length(((vec3<f32>(_e994) + vec3<f32>(0.5f, 0.5f, 0.5f)) - _e997));
        }
        let _e1000 = local_23;
        distanceTraveled = _e1000;
        let _e1001 = distanceTraveled;
        let _e1002 = MAX_VISIBILITY;
        let _e1006 = finalVoxelColor;
        finalVoxelColor = (_e1006 * mix(1f, 0f, clamp((_e1001 / _e1002), 0f, 1f)));
        let _e1008 = distanceTraveled;
        finalDist = _e1008;
        let _e1009 = finalVoxelColor;
        finalColor = vec4<f32>(_e1009.x, _e1009.y, _e1009.z, 1f);
    } else {
        let _e1014 = hitBackBox;
        if _e1014 {
            let _e1016 = aabbHit[1u];
            finalDist = _e1016;
            finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
        }
    }
    let _e1018 = unnamed.blackHoleCount;
    if (_e1018 > 0u) {
        seenHoles = 0u;
        i_7 = 0i;
        loop {
            let _e1020 = i_7;
            let _e1021 = (_e1020 < 8i);
            phi_3627_ = _e1021;
            if _e1021 {
                let _e1022 = seenHoles;
                let _e1024 = unnamed.blackHoleCount;
                phi_3627_ = (_e1022 < _e1024);
            }
            let _e1027 = phi_3627_;
            if _e1027 {
                let _e1028 = i_7;
                let _e1031 = unnamed.blackHoles[_e1028];
                code_2 = _e1031;
                let _e1032 = code_2;
                if (_e1032 == 0u) {
                    continue;
                }
                let _e1034 = seenHoles;
                seenHoles = (_e1034 + bitcast<u32>(1i));
                let _e1037 = code_2;
                if ((_e1037 & 1073741824u) != 0u) {
                    let _e1041 = tuning.purgeLevel;
                    let _e1043 = i_7;
                    let _e1046 = unnamed.blackHoleMass[_e1043];
                    let _e1049 = tuning.purgeMass;
                    local_24 = u32((f32(_e1041) * clamp((f32(_e1046) / f32(max(_e1049, 1u))), 0f, 1f)));
                } else {
                    let _e1056 = i_7;
                    let _e1059 = unnamed.blackHoleMass[_e1056];
                    param_116 = _e1059;
                    let _e1060 = bhLevel_u0028_u1_u003b((&param_116));
                    local_24 = _e1060;
                }
                let _e1061 = local_24;
                bodyLevel = _e1061;
                let _e1062 = bodyLevel;
                param_117 = _e1062;
                let _e1063 = bhBodyRadius_u0028_u1_u003b((&param_117));
                bodyRadius = _e1063;
                let _e1064 = code_2;
                param_118 = _e1064;
                let _e1065 = bhDecode_u0028_u1_u003b((&param_118));
                center = (vec3<f32>(_e1065) + vec3<f32>(0.5f, 0.5f, 0.5f));
                let _e1068 = rayOrigin_3;
                let _e1069 = center;
                oc = (_e1068 - _e1069);
                let _e1071 = oc;
                let _e1072 = rayDir_3;
                b_2 = dot(_e1071, _e1072);
                let _e1074 = oc;
                let _e1075 = oc;
                let _e1077 = bodyRadius;
                let _e1078 = bodyRadius;
                c_2 = (dot(_e1074, _e1075) - (_e1077 * _e1078));
                let _e1081 = b_2;
                let _e1082 = b_2;
                let _e1084 = c_2;
                disc = ((_e1081 * _e1082) - _e1084);
                let _e1086 = disc;
                if (_e1086 <= 0f) {
                    continue;
                }
                let _e1088 = disc;
                sq = sqrt(_e1088);
                let _e1090 = b_2;
                let _e1092 = sq;
                tNear_1 = (-(_e1090) - _e1092);
                let _e1094 = b_2;
                let _e1096 = sq;
                tFar_1 = (-(_e1094) + _e1096);
                let _e1098 = tFar_1;
                if (_e1098 <= 0f) {
                    continue;
                }
                let _e1100 = tNear_1;
                bodyDist = max(0f, _e1100);
                let _e1102 = bodyDist;
                let _e1103 = finalDist;
                if (_e1102 < _e1103) {
                    let _e1105 = rayOrigin_3;
                    let _e1106 = rayDir_3;
                    let _e1107 = bodyDist;
                    let _e1110 = center;
                    surfaceNormal = normalize(((_e1105 + (_e1106 * _e1107)) - _e1110));
                    let _e1113 = surfaceNormal;
                    param_119 = _e1113;
                    let _e1114 = rayDir_3;
                    param_120 = _e1114;
                    let _e1115 = renderBlackHole_u0028_vf3_u003b_vf3_u003b((&param_119), (&param_120));
                    bodyColor = _e1115;
                    let _e1116 = bodyDist;
                    let _e1117 = MAX_VISIBILITY;
                    let _e1121 = bodyColor;
                    bodyColor = (_e1121 * mix(1f, 0f, clamp((_e1116 / _e1117), 0f, 1f)));
                    let _e1123 = bodyColor;
                    finalColor = vec4<f32>(_e1123.x, _e1123.y, _e1123.z, 1f);
                    let _e1128 = bodyDist;
                    finalDist = _e1128;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e1129 = i_7;
                i_7 = (_e1129 + 1i);
            }
        }
    }
    let _e1132 = unnamed.cloudChargeBits;
    charge = clamp(bitcast<f32>(_e1132), 0f, 1f);
    let _e1136 = tuning.cloudMinAlpha;
    let _e1138 = tuning.cloudMaxAlpha;
    let _e1139 = charge;
    groupAlpha = mix(_e1136, _e1138, _e1139);
    let _e1141 = charge;
    cloudGreyness = _e1141;
    let _e1143 = unnamed.rainPhase;
    if (_e1143 == 1u) {
        let _e1146 = unnamed.rainPhaseTimeBits;
        crossedTime = bitcast<f32>(_e1146);
        let _e1148 = charge;
        let _e1150 = pc.time;
        let _e1151 = crossedTime;
        let _e1154 = tuning.rainDarkenDelay;
        cloudGreyness = max(_e1148, clamp(((_e1150 - _e1151) / _e1154), 0f, 1f));
    } else {
        let _e1159 = unnamed.rainPhase;
        if (_e1159 == 2u) {
            cloudGreyness = 1f;
        }
    }
    let _e1161 = groupAlpha;
    if (_e1161 > 0.002f) {
        let _e1163 = worldExtent_u0028_();
        let _e1165 = worldExtent_u0028_();
        let _e1168 = rayOrigin_3;
        param_121 = _e1168;
        let _e1169 = rayDir_3;
        param_122 = _e1169;
        param_123 = vec3<f32>(0f, -1000000f, 0f);
        param_124 = vec3<f32>(_e1163.x, 1000000f, _e1165.z);
        let _e1170 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_121), (&param_122), (&param_123), (&param_124));
        cloudClip = _e1170;
        cloudSunDir = vec3<f32>(0.58191437f, 0.727393f, 0.3636965f);
        bestT = 1000000f;
        bestColor = vec3<f32>(0f, 0f, 0f);
        bestAlpha = 0f;
        foundCloud = false;
        let _e1172 = cloudClip[0u];
        nearT = max(_e1172, 0f);
        let _e1175 = cloudClip[1u];
        let _e1176 = finalDist;
        farT = min(_e1175, _e1176);
        let _e1178 = nearT;
        let _e1179 = farT;
        if (_e1178 < _e1179) {
            let _e1181 = rayOrigin_3;
            param_125 = _e1181;
            let _e1182 = rayDir_3;
            param_126 = _e1182;
            let _e1183 = nearT;
            param_127 = _e1183;
            let _e1184 = farT;
            param_128 = _e1184;
            let _e1185 = cloudSunDir;
            param_129 = _e1185;
            let _e1186 = cloudGreyness;
            param_130 = _e1186;
            let _e1187 = marchBlockyCloud_u0028_vf3_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b_f1_u003b_vf3_u003b_f1_u003b((&param_125), (&param_126), (&param_127), (&param_128), (&param_129), (&param_130), (&param_131), (&param_132), (&param_133));
            let _e1188 = param_131;
            cloudTHit = _e1188;
            let _e1189 = param_132;
            cloudColor = _e1189;
            let _e1190 = param_133;
            cloudDensity = _e1190;
            if _e1187 {
                let _e1191 = cloudTHit;
                if (_e1191 > 0f) {
                    let _e1193 = cloudTHit;
                    bestT = _e1193;
                    let _e1194 = cloudColor;
                    bestColor = _e1194;
                    let _e1195 = groupAlpha;
                    let _e1196 = cloudDensity;
                    bestAlpha = clamp((_e1195 * mix(0.35f, 1f, _e1196)), 0f, 0.95f);
                    foundCloud = true;
                }
            }
        }
        let _e1200 = foundCloud;
        let _e1201 = bestT;
        let _e1202 = finalDist;
        if (_e1200 && (_e1201 < _e1202)) {
            let _e1205 = finalColor;
            let _e1207 = bestColor;
            let _e1208 = bestAlpha;
            let _e1210 = mix(_e1205.xyz, _e1207, vec3(_e1208));
            finalColor[0u] = _e1210.x;
            finalColor[1u] = _e1210.y;
            finalColor[2u] = _e1210.z;
        }
    }
    let _e1218 = pc.spawnX;
    let _e1219 = (_e1218 >= 0i);
    phi_3908_ = _e1219;
    if _e1219 {
        let _e1221 = pc.spawnX;
        let _e1223 = tuning.gridWidth;
        phi_3908_ = (_e1221 < bitcast<i32>(_e1223));
    }
    let _e1227 = phi_3908_;
    phi_3915_ = _e1227;
    if _e1227 {
        let _e1229 = pc.spawnY;
        phi_3915_ = (_e1229 >= 0i);
    }
    let _e1232 = phi_3915_;
    phi_3924_ = _e1232;
    if _e1232 {
        let _e1234 = pc.spawnY;
        let _e1236 = tuning.gridHeight;
        phi_3924_ = (_e1234 < bitcast<i32>(_e1236));
    }
    let _e1240 = phi_3924_;
    phi_3930_ = _e1240;
    if _e1240 {
        let _e1242 = pc.spawnZ;
        phi_3930_ = (_e1242 >= 0i);
    }
    let _e1245 = phi_3930_;
    phi_3939_ = _e1245;
    if _e1245 {
        let _e1247 = pc.spawnZ;
        let _e1249 = tuning.gridDepth;
        phi_3939_ = (_e1247 < bitcast<i32>(_e1249));
    }
    let _e1253 = phi_3939_;
    if _e1253 {
        let _e1255 = pc.spawnSize;
        halfDistMin = (_e1255 / 2i);
        let _e1258 = pc.spawnSize;
        halfDistMax = ((_e1258 - 1i) / 2i);
        let _e1262 = pc.spawnX;
        let _e1263 = halfDistMin;
        let _e1267 = pc.spawnY;
        let _e1268 = halfDistMin;
        let _e1272 = pc.spawnZ;
        let _e1273 = halfDistMin;
        boxMin_2 = vec3<f32>(f32((_e1262 - _e1263)), f32((_e1267 - _e1268)), f32((_e1272 - _e1273)));
        let _e1278 = pc.spawnX;
        let _e1279 = halfDistMax;
        let _e1284 = pc.spawnY;
        let _e1285 = halfDistMax;
        let _e1290 = pc.spawnZ;
        let _e1291 = halfDistMax;
        boxMax_1 = vec3<f32>(f32(((_e1278 + _e1279) + 1i)), f32(((_e1284 + _e1285) + 1i)), f32(((_e1290 + _e1291) + 1i)));
        let _e1297 = pc.spawnType;
        indexable_6 = array<vec3<f32>, 20>(vec3<f32>(0.1f, 0.1f, 0.1f), vec3<f32>(1f, 0.9f, 0.2f), vec3<f32>(0.2f, 0.6f, 1f), vec3<f32>(0.6f, 0.6f, 0.6f), vec3<f32>(0.5f, 0.35f, 0.15f), vec3<f32>(1f, 0.5f, 0f), vec3<f32>(0.9f, 0.9f, 0.9f), vec3<f32>(0.8f, 0.4f, 1f), vec3<f32>(1f, 0.45f, 0.1f), vec3<f32>(0.85f, 0.3f, 0.07f), vec3<f32>(0.65f, 0.2f, 0.06f), vec3<f32>(0.45f, 0.14f, 0.06f), vec3<f32>(0.22f, 0.19f, 0.18f), vec3<f32>(0.38f, 0.3f, 0.12f), vec3<f32>(0.46f, 0.35f, 0.13f), vec3<f32>(0.54f, 0.4f, 0.14f), vec3<f32>(0.62f, 0.45f, 0.15f), vec3<f32>(0.7f, 0.51f, 0.16f), vec3<f32>(0.36f, 0.24f, 0.12f), vec3<f32>(0.22f, 0.46f, 0.15f));
        let _e1300 = indexable_6[clamp(_e1297, 0i, 19i)];
        cursorColor = _e1300;
        let _e1302 = pc.spawnShape;
        if (_e1302 == 1i) {
            let _e1304 = boxMin_2;
            let _e1305 = boxMax_1;
            sphereCenter = ((_e1304 + _e1305) * 0.5f);
            let _e1309 = pc.spawnSize;
            sphereRadius = (f32(_e1309) * 0.5f);
            let _e1312 = rayOrigin_3;
            let _e1313 = sphereCenter;
            oc_1 = (_e1312 - _e1313);
            let _e1315 = oc_1;
            let _e1316 = rayDir_3;
            b_3 = dot(_e1315, _e1316);
            let _e1318 = oc_1;
            let _e1319 = oc_1;
            let _e1321 = sphereRadius;
            let _e1322 = sphereRadius;
            c_3 = (dot(_e1318, _e1319) - (_e1321 * _e1322));
            let _e1325 = b_3;
            let _e1326 = b_3;
            let _e1328 = c_3;
            disc_1 = ((_e1325 * _e1326) - _e1328);
            let _e1330 = disc_1;
            if (_e1330 > 0f) {
                let _e1332 = disc_1;
                sq_1 = sqrt(_e1332);
                let _e1334 = b_3;
                let _e1336 = sq_1;
                tNear_2 = (-(_e1334) - _e1336);
                let _e1338 = b_3;
                let _e1340 = sq_1;
                tFar_2 = (-(_e1338) + _e1340);
                let _e1342 = tFar_2;
                if (_e1342 > 0f) {
                    let _e1344 = tNear_2;
                    inside = (_e1344 <= 0f);
                    let _e1346 = inside;
                    let _e1347 = tFar_2;
                    let _e1348 = tNear_2;
                    cursorDist = select(_e1348, _e1347, _e1346);
                    let _e1350 = rayOrigin_3;
                    let _e1351 = rayDir_3;
                    let _e1352 = cursorDist;
                    let _e1355 = sphereCenter;
                    shellNormal = normalize(((_e1350 + (_e1351 * _e1352)) - _e1355));
                    let _e1358 = shellNormal;
                    let _e1359 = rayDir_3;
                    rim_1 = (1f - abs(dot(_e1358, _e1359)));
                    let _e1363 = rim_1;
                    let _e1366 = inside;
                    alpha = (mix(0.12f, 0.9f, smoothstep(0.55f, 0.97f, _e1363)) * select(1f, 0.35f, _e1366));
                    let _e1369 = cursorDist;
                    let _e1370 = finalDist;
                    if (_e1369 < _e1370) {
                        let _e1372 = finalColor;
                        let _e1374 = cursorColor;
                        let _e1375 = alpha;
                        let _e1377 = mix(_e1372.xyz, _e1374, vec3(_e1375));
                        finalColor[0u] = _e1377.x;
                        finalColor[1u] = _e1377.y;
                        finalColor[2u] = _e1377.z;
                    }
                }
            }
        } else {
            let _e1384 = rayOrigin_3;
            param_134 = _e1384;
            let _e1385 = rayDir_3;
            param_135 = _e1385;
            let _e1386 = boxMin_2;
            param_136 = _e1386;
            let _e1387 = boxMax_1;
            param_137 = _e1387;
            let _e1388 = intersectAABB_u0028_vf3_u003b_vf3_u003b_vf3_u003b_vf3_u003b((&param_134), (&param_135), (&param_136), (&param_137));
            cursorHit = _e1388;
            let _e1390 = cursorHit[0u];
            let _e1392 = cursorHit[1u];
            let _e1393 = (_e1390 < _e1392);
            phi_4150_ = _e1393;
            if _e1393 {
                let _e1395 = cursorHit[1u];
                phi_4150_ = (_e1395 > 0f);
            }
            let _e1398 = phi_4150_;
            if _e1398 {
                let _e1400 = cursorHit[0u];
                distFront = max(0f, _e1400);
                let _e1403 = cursorHit[1u];
                distBack = _e1403;
                let _e1404 = rayOrigin_3;
                let _e1405 = rayDir_3;
                let _e1406 = distFront;
                hitPosFront = (_e1404 + (_e1405 * _e1406));
                let _e1409 = rayOrigin_3;
                let _e1410 = rayDir_3;
                let _e1411 = distBack;
                hitPosBack = (_e1409 + (_e1410 * _e1411));
                e = 0.15f;
                onFrontEdge = false;
                edgesFront = 0i;
                let _e1415 = hitPosFront[0u];
                let _e1417 = boxMin_2[0u];
                let _e1418 = e;
                let _e1420 = (_e1415 < (_e1417 + _e1418));
                phi_4192_ = _e1420;
                if !(_e1420) {
                    let _e1423 = hitPosFront[0u];
                    let _e1425 = boxMax_1[0u];
                    let _e1426 = e;
                    phi_4192_ = (_e1423 > (_e1425 - _e1426));
                }
                let _e1430 = phi_4192_;
                if _e1430 {
                    let _e1431 = edgesFront;
                    edgesFront = (_e1431 + 1i);
                }
                let _e1434 = hitPosFront[1u];
                let _e1436 = boxMin_2[1u];
                let _e1437 = e;
                let _e1439 = (_e1434 < (_e1436 + _e1437));
                phi_4214_ = _e1439;
                if !(_e1439) {
                    let _e1442 = hitPosFront[1u];
                    let _e1444 = boxMax_1[1u];
                    let _e1445 = e;
                    phi_4214_ = (_e1442 > (_e1444 - _e1445));
                }
                let _e1449 = phi_4214_;
                if _e1449 {
                    let _e1450 = edgesFront;
                    edgesFront = (_e1450 + 1i);
                }
                let _e1453 = hitPosFront[2u];
                let _e1455 = boxMin_2[2u];
                let _e1456 = e;
                let _e1458 = (_e1453 < (_e1455 + _e1456));
                phi_4236_ = _e1458;
                if !(_e1458) {
                    let _e1461 = hitPosFront[2u];
                    let _e1463 = boxMax_1[2u];
                    let _e1464 = e;
                    phi_4236_ = (_e1461 > (_e1463 - _e1464));
                }
                let _e1468 = phi_4236_;
                if _e1468 {
                    let _e1469 = edgesFront;
                    edgesFront = (_e1469 + 1i);
                }
                let _e1471 = edgesFront;
                if (_e1471 >= 2i) {
                    onFrontEdge = true;
                }
                onBackEdge = false;
                edgesBack = 0i;
                let _e1474 = hitPosBack[0u];
                let _e1476 = boxMin_2[0u];
                let _e1477 = e;
                let _e1479 = (_e1474 < (_e1476 + _e1477));
                phi_4264_ = _e1479;
                if !(_e1479) {
                    let _e1482 = hitPosBack[0u];
                    let _e1484 = boxMax_1[0u];
                    let _e1485 = e;
                    phi_4264_ = (_e1482 > (_e1484 - _e1485));
                }
                let _e1489 = phi_4264_;
                if _e1489 {
                    let _e1490 = edgesBack;
                    edgesBack = (_e1490 + 1i);
                }
                let _e1493 = hitPosBack[1u];
                let _e1495 = boxMin_2[1u];
                let _e1496 = e;
                let _e1498 = (_e1493 < (_e1495 + _e1496));
                phi_4286_ = _e1498;
                if !(_e1498) {
                    let _e1501 = hitPosBack[1u];
                    let _e1503 = boxMax_1[1u];
                    let _e1504 = e;
                    phi_4286_ = (_e1501 > (_e1503 - _e1504));
                }
                let _e1508 = phi_4286_;
                if _e1508 {
                    let _e1509 = edgesBack;
                    edgesBack = (_e1509 + 1i);
                }
                let _e1512 = hitPosBack[2u];
                let _e1514 = boxMin_2[2u];
                let _e1515 = e;
                let _e1517 = (_e1512 < (_e1514 + _e1515));
                phi_4308_ = _e1517;
                if !(_e1517) {
                    let _e1520 = hitPosBack[2u];
                    let _e1522 = boxMax_1[2u];
                    let _e1523 = e;
                    phi_4308_ = (_e1520 > (_e1522 - _e1523));
                }
                let _e1527 = phi_4308_;
                if _e1527 {
                    let _e1528 = edgesBack;
                    edgesBack = (_e1528 + 1i);
                }
                let _e1530 = edgesBack;
                if (_e1530 >= 2i) {
                    onBackEdge = true;
                }
                let _e1532 = onFrontEdge;
                let _e1533 = distFront;
                let _e1534 = finalDist;
                if (_e1532 && (_e1533 < _e1534)) {
                    let _e1537 = finalColor;
                    let _e1539 = cursorColor;
                    let _e1541 = mix(_e1537.xyz, _e1539, vec3(0.9f));
                    finalColor[0u] = _e1541.x;
                    finalColor[1u] = _e1541.y;
                    finalColor[2u] = _e1541.z;
                } else {
                    let _e1548 = onBackEdge;
                    let _e1549 = distBack;
                    let _e1550 = finalDist;
                    if (_e1548 && (_e1549 < _e1550)) {
                        let _e1553 = finalColor;
                        let _e1555 = cursorColor;
                        let _e1557 = mix(_e1553.xyz, _e1555, vec3(0.2f));
                        finalColor[0u] = _e1557.x;
                        finalColor[1u] = _e1557.y;
                        finalColor[2u] = _e1557.z;
                    } else {
                        let _e1564 = distFront;
                        let _e1565 = finalDist;
                        if (_e1564 < _e1565) {
                            let _e1567 = finalColor;
                            let _e1569 = cursorColor;
                            let _e1571 = mix(_e1567.xyz, _e1569, vec3(0.15f));
                            finalColor[0u] = _e1571.x;
                            finalColor[1u] = _e1571.y;
                            finalColor[2u] = _e1571.z;
                        }
                    }
                }
            }
        }
    }
    let _e1578 = hitFrontBox;
    if _e1578 {
        finalColor = vec4<f32>(1f, 0.2f, 0.2f, 1f);
    }
    let _e1579 = finalColor;
    outColor = _e1579;
    return;
}

@fragment 
fn main(@location(0) inUV: vec2<f32>) -> @location(0) vec4<f32> {
    inUV_1 = inUV;
    main_1();
    let _e3 = outColor;
    return _e3;
}
