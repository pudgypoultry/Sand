// GENERATED FILE -- DO NOT EDIT.
//
// Translated from falling_sand.comp by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit falling_sand.comp and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 96737a22d5d2cce90a990614f7d304ac2ab3a71a214bd42c3486e02f5063d012

struct VoxelGrid {
    grid: array<u32>,
}

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
}

struct CloudGrid {
    cloudCells: array<u32>,
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
    simTick: u32,
    lastRainTick: u32,
    blackHoleCount: u32,
    maxOccupiedY: u32,
    blackHoles: array<u32, 8>,
    blackHoleMass: array<u32, 8>,
    blackHoleStarve: array<u32, 8>,
    cloudColumn: array<u32>,
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

struct VoxelGrid_1 {
    grid: array<atomic<u32>>,
}

struct CloudGrid_1 {
    cloudCells: array<atomic<u32>>,
}

struct SimStats_1 {
    waterVoxelCount: atomic<u32>,
    waterHighMark: u32,
    cloudWaterCount: u32,
    rainPhase: u32,
    rainPhaseTimeBits: u32,
    rainTargetLevel: u32,
    rainCandidateCount: atomic<u32>,
    rainCandidateEstimate: u32,
    cloudChargeBits: u32,
    cloudBlockCount: atomic<u32>,
    cloudMovedCount: atomic<u32>,
    cloudStillTicks: u32,
    simTick: u32,
    lastRainTick: u32,
    blackHoleCount: u32,
    maxOccupiedY: atomic<u32>,
    blackHoles: array<atomic<u32>, 8>,
    blackHoleMass: array<atomic<u32>, 8>,
    blackHoleStarve: array<u32, 8>,
    cloudColumn: array<atomic<u32>>,
}

@group(0) @binding(0) 
var<storage, read_write> unnamed: VoxelGrid_1;
@group(0) @binding(2) 
var<uniform> tuning: TuningParams;
@group(0) @binding(4) 
var<storage, read_write> unnamed_1: CloudGrid_1;
@group(0) @binding(1) 
var<storage, read_write> unnamed_2: SimStats_1;
@group(0) @binding(3) 
var<uniform> pc: Constants;
var<private> gl_GlobalInvocationID_1: vec3<u32>;

fn getAge_u0028_u1_u003b(val: ptr<function, u32>) -> u32 {
    let _e197 = (*val);
    return ((_e197 >> bitcast<u32>(24i)) & 255u);
}

fn getDir_u0028_u1_u003b(val_1: ptr<function, u32>) -> u32 {
    let _e197 = (*val_1);
    return ((_e197 >> bitcast<u32>(8i)) & 255u);
}

fn getType_u0028_u1_u003b(val_2: ptr<function, u32>) -> u32 {
    let _e197 = (*val_2);
    return (_e197 & 255u);
}

fn tree26_u0028_i1_u003b(i: ptr<function, i32>) -> vec3<i32> {
    var j: i32;
    var local: i32;

    let _e199 = (*i);
    if (_e199 >= 13i) {
        let _e201 = (*i);
        local = (_e201 + 1i);
    } else {
        let _e203 = (*i);
        local = _e203;
    }
    let _e204 = local;
    j = _e204;
    let _e205 = j;
    let _e213 = j;
    let _e214 = (_e213 / 3i);
    let _e222 = j;
    return (vec3<i32>((_e205 - (i32(floor((f32(_e205) / f32(3i)))) * 3i)), (_e214 - (i32(floor((f32(_e214) / f32(3i)))) * 3i)), (_e222 / 9i)) - vec3<i32>(1i, 1i, 1i));
}

fn readCell_u0028_u1_u003b(index: ptr<function, u32>) -> u32 {
    let _e197 = (*index);
    let _e200 = atomicLoad((&unnamed.grid[_e197]));
    return _e200;
}

fn tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex: ptr<function, u32>, currentValue: ptr<function, u32>, targetIndex: ptr<function, u32>, newValue: ptr<function, u32>) -> bool {
    var targetValue: u32;
    var param: u32;
    var targetType: u32;
    var param_1: u32;
    var currentType: u32;
    var param_2: u32;
    var actual: u32;
    var phi_1637_: bool;
    var phi_1646_: bool;

    let _e207 = (*targetIndex);
    param = _e207;
    let _e208 = readCell_u0028_u1_u003b((&param));
    targetValue = _e208;
    let _e209 = targetValue;
    param_1 = _e209;
    let _e210 = getType_u0028_u1_u003b((&param_1));
    targetType = _e210;
    let _e211 = (*currentValue);
    param_2 = _e211;
    let _e212 = getType_u0028_u1_u003b((&param_2));
    currentType = _e212;
    let _e213 = targetType;
    let _e214 = (_e213 == 0u);
    phi_1637_ = _e214;
    if !(_e214) {
        let _e216 = currentType;
        let _e218 = currentType;
        let _e221 = targetType;
        phi_1637_ = (((_e216 == 1u) || (_e218 == 4u)) && (_e221 == 2u));
    }
    let _e225 = phi_1637_;
    phi_1646_ = _e225;
    if !(_e225) {
        let _e227 = currentType;
        let _e229 = targetType;
        phi_1646_ = ((_e227 == 6u) && (_e229 == 5u));
    }
    let _e233 = phi_1646_;
    if _e233 {
        let _e234 = (*currentIndex);
        let _e237 = (*currentValue);
        let _e238 = atomicCompareExchangeWeak((&unnamed.grid[_e234]), _e237, 0u);
        let _e240 = (*currentValue);
        if (_e238.old_value == _e240) {
            let _e242 = (*targetIndex);
            let _e245 = targetValue;
            let _e246 = (*newValue);
            let _e247 = atomicCompareExchangeWeak((&unnamed.grid[_e242]), _e245, _e246);
            actual = _e247.old_value;
            let _e249 = actual;
            let _e250 = targetValue;
            if (_e249 == _e250) {
                let _e252 = targetType;
                if (_e252 != 0u) {
                    let _e254 = (*currentIndex);
                    let _e257 = targetValue;
                    let _e258 = atomicExchange((&unnamed.grid[_e254]), _e257);
                }
                return true;
            } else {
                let _e259 = (*currentIndex);
                let _e262 = (*currentValue);
                let _e263 = atomicCompareExchangeWeak((&unnamed.grid[_e259]), 0u, _e262);
            }
        }
    }
    return false;
}

fn pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(type_33: ptr<function, u32>, dir: ptr<function, u32>, sleep: ptr<function, u32>, age: ptr<function, u32>) -> u32 {
    let _e200 = (*type_33);
    let _e202 = (*dir);
    let _e207 = (*sleep);
    let _e212 = (*age);
    return ((((_e200 & 255u) | ((_e202 & 255u) << bitcast<u32>(8i))) | ((_e207 & 255u) << bitcast<u32>(16i))) | ((_e212 & 255u) << bitcast<u32>(24i)));
}

fn getIndex_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    let _e198 = (*pos)[0u];
    let _e200 = (*pos)[1u];
    let _e202 = tuning.gridWidth;
    let _e207 = (*pos)[2u];
    let _e209 = tuning.gridWidth;
    let _e213 = tuning.gridHeight;
    return bitcast<u32>(((_e198 + (_e200 * bitcast<i32>(_e202))) + ((_e207 * bitcast<i32>(_e209)) * bitcast<i32>(_e213))));
}

fn treeInBounds_u0028_vi3_u003b(p: ptr<function, vec3<i32>>) -> bool {
    var phi_1128_: bool;
    var phi_1134_: bool;
    var phi_1144_: bool;
    var phi_1150_: bool;
    var phi_1160_: bool;

    let _e198 = (*p)[0u];
    let _e199 = (_e198 > 0i);
    phi_1128_ = _e199;
    if _e199 {
        let _e201 = (*p)[0u];
        let _e203 = tuning.gridWidth;
        phi_1128_ = (_e201 < (bitcast<i32>(_e203) - 1i));
    }
    let _e208 = phi_1128_;
    phi_1134_ = _e208;
    if _e208 {
        let _e210 = (*p)[1u];
        phi_1134_ = (_e210 > 0i);
    }
    let _e213 = phi_1134_;
    phi_1144_ = _e213;
    if _e213 {
        let _e215 = (*p)[1u];
        let _e217 = tuning.gridHeight;
        phi_1144_ = (_e215 < (bitcast<i32>(_e217) - 1i));
    }
    let _e222 = phi_1144_;
    phi_1150_ = _e222;
    if _e222 {
        let _e224 = (*p)[2u];
        phi_1150_ = (_e224 > 0i);
    }
    let _e227 = phi_1150_;
    phi_1160_ = _e227;
    if _e227 {
        let _e229 = (*p)[2u];
        let _e231 = tuning.gridDepth;
        phi_1160_ = (_e229 < (bitcast<i32>(_e231) - 1i));
    }
    let _e236 = phi_1160_;
    return _e236;
}

fn updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_1: ptr<function, vec3<i32>>, currentIndex_1: ptr<function, u32>, rawValue: ptr<function, u32>, currentAge: ptr<function, u32>, randVal: ptr<function, f32>) {
    var belowPos: vec3<i32>;
    var param_3: vec3<i32>;
    var param_4: vec3<i32>;
    var param_5: u32;
    var param_6: vec3<i32>;
    var param_7: u32;
    var param_8: u32;
    var param_9: u32;
    var param_10: u32;
    var param_11: u32;
    var param_12: u32;
    var param_13: u32;
    var param_14: u32;
    var dist: u32;
    var nearest: u32;
    var touchesTrunk: bool;
    var start: i32;
    var haveSpot: bool;
    var spot: vec3<i32>;
    var i_1: i32;
    var c: vec3<i32>;
    var param_15: i32;
    var param_16: vec3<i32>;
    var v: u32;
    var param_17: vec3<i32>;
    var param_18: u32;
    var t: u32;
    var param_19: u32;
    var param_20: u32;
    var param_21: u32;
    var supported: u32;
    var local_1: u32;
    var local_2: u32;
    var param_22: u32;
    var param_23: u32;
    var param_24: u32;
    var param_25: u32;
    var param_26: vec3<i32>;
    var param_27: u32;
    var param_28: u32;
    var param_29: u32;
    var param_30: u32;
    var param_31: u32;
    var param_32: u32;
    var param_33: u32;
    var param_34: u32;
    var phi_6746_: bool;
    var phi_6830_: bool;
    var phi_6912_: bool;

    let _e247 = (*randVal);
    let _e251 = tuning.treeLeafTickChance;
    if (fract((_e247 * 7f)) >= _e251) {
        return;
    }
    let _e253 = (*currentAge);
    if (_e253 == 255u) {
        let _e255 = (*pos_1);
        belowPos = (_e255 + vec3<i32>(0i, -1i, 0i));
        let _e257 = belowPos;
        param_3 = _e257;
        let _e258 = treeInBounds_u0028_vi3_u003b((&param_3));
        phi_6746_ = _e258;
        if _e258 {
            let _e259 = belowPos;
            param_4 = _e259;
            let _e260 = getIndex_u0028_vi3_u003b((&param_4));
            param_5 = _e260;
            let _e261 = readCell_u0028_u1_u003b((&param_5));
            phi_6746_ = (_e261 == 0u);
        }
        let _e264 = phi_6746_;
        if _e264 {
            let _e265 = belowPos;
            param_6 = _e265;
            let _e266 = getIndex_u0028_vi3_u003b((&param_6));
            param_7 = 19u;
            param_8 = 0u;
            param_9 = 0u;
            param_10 = 255u;
            let _e267 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_7), (&param_8), (&param_9), (&param_10));
            let _e268 = (*currentIndex_1);
            param_11 = _e268;
            let _e269 = (*rawValue);
            param_12 = _e269;
            param_13 = _e266;
            param_14 = _e267;
            let _e270 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_11), (&param_12), (&param_13), (&param_14));
            if _e270 {
                return;
            }
        }
        let _e271 = (*currentIndex_1);
        let _e274 = (*rawValue);
        let _e275 = atomicCompareExchangeWeak((&unnamed.grid[_e271]), _e274, 0u);
        return;
    }
    let _e277 = (*currentAge);
    dist = _e277;
    nearest = 255u;
    touchesTrunk = false;
    let _e278 = (*randVal);
    start = i32((fract((_e278 * 71f)) * 26f));
    haveSpot = false;
    let _e283 = (*pos_1);
    spot = _e283;
    i_1 = 0i;
    loop {
        let _e284 = i_1;
        if (_e284 < 26i) {
            let _e286 = (*pos_1);
            let _e287 = start;
            let _e288 = i_1;
            let _e289 = (_e287 + _e288);
            param_15 = (_e289 - (i32(floor((f32(_e289) / f32(26i)))) * 26i));
            let _e297 = tree26_u0028_i1_u003b((&param_15));
            c = (_e286 + _e297);
            let _e299 = c;
            param_16 = _e299;
            let _e300 = treeInBounds_u0028_vi3_u003b((&param_16));
            if !(_e300) {
                continue;
            }
            let _e302 = c;
            param_17 = _e302;
            let _e303 = getIndex_u0028_vi3_u003b((&param_17));
            param_18 = _e303;
            let _e304 = readCell_u0028_u1_u003b((&param_18));
            v = _e304;
            let _e305 = v;
            param_19 = _e305;
            let _e306 = getType_u0028_u1_u003b((&param_19));
            t = _e306;
            let _e307 = t;
            let _e308 = (_e307 == 18u);
            phi_6830_ = _e308;
            if _e308 {
                let _e309 = v;
                param_20 = _e309;
                let _e310 = getDir_u0028_u1_u003b((&param_20));
                let _e313 = tuning.treeMaxHeight;
                phi_6830_ = ((_e310 + 1u) >= _e313);
            }
            let _e316 = phi_6830_;
            if _e316 {
                touchesTrunk = true;
            } else {
                let _e317 = t;
                if (_e317 == 19u) {
                    let _e319 = nearest;
                    let _e320 = v;
                    param_21 = _e320;
                    let _e321 = getAge_u0028_u1_u003b((&param_21));
                    nearest = min(_e319, _e321);
                } else {
                    let _e323 = v;
                    let _e325 = haveSpot;
                    if ((_e323 == 0u) && !(_e325)) {
                        haveSpot = true;
                        let _e328 = c;
                        spot = _e328;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e329 = i_1;
            i_1 = (_e329 + 1i);
        }
    }
    let _e331 = touchesTrunk;
    if _e331 {
        local_1 = 1u;
    } else {
        let _e332 = nearest;
        if (_e332 >= 255u) {
            local_2 = 255u;
        } else {
            let _e334 = nearest;
            local_2 = (_e334 + 1u);
        }
        let _e336 = local_2;
        local_1 = _e336;
    }
    let _e337 = local_1;
    supported = _e337;
    let _e338 = supported;
    let _e340 = tuning.treeLeafReach;
    if (_e338 > _e340) {
        let _e342 = (*randVal);
        let _e346 = tuning.treeLeafFallChance;
        if (fract((_e342 * 83f)) < _e346) {
            let _e348 = (*currentIndex_1);
            let _e351 = (*rawValue);
            param_22 = 19u;
            param_23 = 0u;
            param_24 = 0u;
            param_25 = 255u;
            let _e352 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_22), (&param_23), (&param_24), (&param_25));
            let _e353 = atomicCompareExchangeWeak((&unnamed.grid[_e348]), _e351, _e352);
        }
        return;
    }
    let _e355 = supported;
    let _e357 = tuning.treeLeafReach;
    let _e359 = haveSpot;
    let _e360 = ((_e355 < _e357) && _e359);
    phi_6912_ = _e360;
    if _e360 {
        let _e361 = (*randVal);
        let _e365 = tuning.treeLeafSpreadChance;
        phi_6912_ = (fract((_e361 * 89f)) < _e365);
    }
    let _e368 = phi_6912_;
    if _e368 {
        let _e369 = spot;
        param_26 = _e369;
        let _e370 = getIndex_u0028_vi3_u003b((&param_26));
        let _e373 = supported;
        param_27 = 19u;
        param_28 = 0u;
        param_29 = 0u;
        param_30 = (_e373 + 1u);
        let _e375 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_27), (&param_28), (&param_29), (&param_30));
        let _e376 = atomicCompareExchangeWeak((&unnamed.grid[_e370]), 0u, _e375);
    }
    let _e378 = supported;
    let _e379 = dist;
    if (_e378 != _e379) {
        let _e381 = (*currentIndex_1);
        let _e384 = (*rawValue);
        param_31 = 19u;
        param_32 = 0u;
        param_33 = 0u;
        let _e385 = supported;
        param_34 = _e385;
        let _e386 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_31), (&param_32), (&param_33), (&param_34));
        let _e387 = atomicCompareExchangeWeak((&unnamed.grid[_e381]), _e384, _e386);
    }
    return;
}

fn isGrassBlock_u0028_u1_u003b(value: ptr<function, u32>) -> bool {
    var flora: u32;
    var param_35: u32;

    let _e199 = (*value);
    flora = ((_e199 >> bitcast<u32>(8i)) & 255u);
    let _e203 = (*value);
    param_35 = _e203;
    let _e204 = getType_u0028_u1_u003b((&param_35));
    let _e206 = flora;
    let _e209 = flora;
    return (((_e204 == 4u) && (_e206 > 10u)) && (_e209 <= 100u));
}

fn getSleep_u0028_u1_u003b(val_3: ptr<function, u32>) -> u32 {
    let _e197 = (*val_3);
    return ((_e197 >> bitcast<u32>(16i)) & 255u);
}

fn getHDir_u0028_i1_u003b(d: ptr<function, i32>) -> vec3<i32> {
    let _e197 = (*d);
    if (_e197 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e199 = (*d);
    if (_e199 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e201 = (*d);
    if (_e201 == 2i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    let _e203 = (*d);
    if (_e203 == 3i) {
        return vec3<i32>(0i, 0i, -1i);
    }
    let _e205 = (*d);
    if (_e205 == 4i) {
        return vec3<i32>(1i, 0i, 1i);
    }
    let _e207 = (*d);
    if (_e207 == 5i) {
        return vec3<i32>(1i, 0i, -1i);
    }
    let _e209 = (*d);
    if (_e209 == 6i) {
        return vec3<i32>(-1i, 0i, 1i);
    }
    return vec3<i32>(-1i, 0i, -1i);
}

fn updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_2: ptr<function, vec3<i32>>, currentIndex_2: ptr<function, u32>, rawValue_1: ptr<function, u32>, currentDir: ptr<function, u32>, currentAge_1: ptr<function, u32>, randVal_1: ptr<function, f32>) {
    var height: u32;
    var water: u32;
    var changed: bool;
    var start_1: i32;
    var k: i32;
    var i_2: i32;
    var c_1: vec3<i32>;
    var local_3: vec3<i32>;
    var local_4: vec3<i32>;
    var param_36: i32;
    var param_37: i32;
    var param_38: vec3<i32>;
    var idx: u32;
    var param_39: vec3<i32>;
    var v_1: u32;
    var param_40: u32;
    var param_41: u32;
    var moisture: u32;
    var param_42: u32;
    var param_43: u32;
    var param_44: u32;
    var param_45: u32;
    var param_46: u32;
    var param_47: u32;
    var param_48: u32;
    var upPos: vec3<i32>;
    var upIsTrunk: bool;
    var upValue: u32;
    var upIndex: u32;
    var param_49: vec3<i32>;
    var param_50: vec3<i32>;
    var param_51: u32;
    var param_52: u32;
    var param_53: u32;
    var lifted: u32;
    var param_54: u32;
    var param_55: u32;
    var param_56: u32;
    var param_57: u32;
    var param_58: u32;
    var param_59: u32;
    var param_60: vec3<i32>;
    var upType: u32;
    var param_61: u32;
    var sapling: u32;
    var param_62: u32;
    var param_63: u32;
    var param_64: u32;
    var param_65: u32;
    var start_2: i32;
    var i_3: i32;
    var c_2: vec3<i32>;
    var param_66: i32;
    var param_67: vec3<i32>;
    var idx_1: u32;
    var param_68: vec3<i32>;
    var param_69: u32;
    var param_70: u32;
    var param_71: u32;
    var param_72: u32;
    var param_73: u32;
    var start_3: i32;
    var i_4: i32;
    var c_3: vec3<i32>;
    var param_74: i32;
    var param_75: vec3<i32>;
    var idx_2: u32;
    var param_76: vec3<i32>;
    var param_77: u32;
    var param_78: vec3<i32>;
    var param_79: u32;
    var param_80: u32;
    var param_81: u32;
    var param_82: u32;
    var param_83: u32;
    var param_84: u32;
    var param_85: u32;
    var param_86: u32;
    var param_87: u32;
    var param_88: u32;
    var phi_6301_: bool;
    var phi_6444_: bool;
    var phi_6454_: bool;
    var phi_6499_: bool;
    var phi_6550_: bool;
    var phi_6629_: bool;

    let _e282 = (*currentDir);
    height = _e282;
    let _e283 = (*currentAge_1);
    water = _e283;
    changed = false;
    let _e284 = water;
    let _e286 = tuning.treeWaterMax;
    let _e287 = (_e284 < _e286);
    phi_6301_ = _e287;
    if _e287 {
        let _e288 = (*randVal_1);
        let _e292 = tuning.treeDrinkChance;
        phi_6301_ = (fract((_e288 * 13f)) < _e292);
    }
    let _e295 = phi_6301_;
    if _e295 {
        let _e296 = (*randVal_1);
        start_1 = i32((fract((_e296 * 101f)) * 17f));
        k = 0i;
        loop {
            let _e301 = k;
            if (_e301 < 17i) {
                let _e303 = start_1;
                let _e304 = k;
                let _e305 = (_e303 + _e304);
                i_2 = (_e305 - (i32(floor((f32(_e305) / f32(17i)))) * 17i));
                let _e313 = i_2;
                if (_e313 == 0i) {
                    let _e315 = (*pos_2);
                    local_3 = (_e315 + vec3<i32>(0i, -1i, 0i));
                } else {
                    let _e317 = i_2;
                    if (_e317 < 9i) {
                        let _e319 = (*pos_2);
                        let _e320 = i_2;
                        param_36 = (_e320 - 1i);
                        let _e322 = getHDir_u0028_i1_u003b((&param_36));
                        local_4 = ((_e319 + _e322) + vec3<i32>(0i, -1i, 0i));
                    } else {
                        let _e325 = (*pos_2);
                        let _e326 = i_2;
                        param_37 = (_e326 - 9i);
                        let _e328 = getHDir_u0028_i1_u003b((&param_37));
                        local_4 = (_e325 + _e328);
                    }
                    let _e330 = local_4;
                    local_3 = _e330;
                }
                let _e331 = local_3;
                c_1 = _e331;
                let _e332 = c_1;
                param_38 = _e332;
                let _e333 = treeInBounds_u0028_vi3_u003b((&param_38));
                if !(_e333) {
                    continue;
                }
                let _e335 = c_1;
                param_39 = _e335;
                let _e336 = getIndex_u0028_vi3_u003b((&param_39));
                idx = _e336;
                let _e337 = idx;
                param_40 = _e337;
                let _e338 = readCell_u0028_u1_u003b((&param_40));
                v_1 = _e338;
                let _e339 = v_1;
                param_41 = _e339;
                let _e340 = getType_u0028_u1_u003b((&param_41));
                if (_e340 != 4u) {
                    continue;
                }
                let _e342 = v_1;
                param_42 = _e342;
                let _e343 = getAge_u0028_u1_u003b((&param_42));
                moisture = _e343;
                let _e344 = moisture;
                let _e346 = tuning.treeSoilReserve;
                if (_e344 <= _e346) {
                    continue;
                }
                let _e348 = idx;
                let _e351 = v_1;
                let _e352 = v_1;
                param_43 = _e352;
                let _e353 = getDir_u0028_u1_u003b((&param_43));
                let _e354 = v_1;
                param_44 = _e354;
                let _e355 = getSleep_u0028_u1_u003b((&param_44));
                let _e356 = moisture;
                param_45 = 4u;
                param_46 = _e353;
                param_47 = _e355;
                param_48 = (_e356 - 1u);
                let _e358 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_45), (&param_46), (&param_47), (&param_48));
                let _e359 = atomicCompareExchangeWeak((&unnamed.grid[_e348]), _e351, _e358);
                let _e361 = v_1;
                if (_e359.old_value == _e361) {
                    let _e363 = water;
                    water = (_e363 + 1u);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e365 = k;
                k = (_e365 + 1i);
            }
        }
    }
    let _e367 = (*pos_2);
    upPos = (_e367 + vec3<i32>(0i, 1i, 0i));
    upIsTrunk = false;
    upValue = 0u;
    upIndex = 0u;
    let _e369 = upPos;
    param_49 = _e369;
    let _e370 = treeInBounds_u0028_vi3_u003b((&param_49));
    if _e370 {
        let _e371 = upPos;
        param_50 = _e371;
        let _e372 = getIndex_u0028_vi3_u003b((&param_50));
        upIndex = _e372;
        let _e373 = upIndex;
        param_51 = _e373;
        let _e374 = readCell_u0028_u1_u003b((&param_51));
        upValue = _e374;
        let _e375 = upValue;
        param_52 = _e375;
        let _e376 = getType_u0028_u1_u003b((&param_52));
        upIsTrunk = (_e376 == 18u);
    }
    let _e378 = upIsTrunk;
    let _e379 = water;
    let _e381 = (_e378 && (_e379 > 0u));
    phi_6444_ = _e381;
    if _e381 {
        let _e382 = upValue;
        param_53 = _e382;
        let _e383 = getAge_u0028_u1_u003b((&param_53));
        phi_6444_ = (_e383 < 255u);
    }
    let _e386 = phi_6444_;
    phi_6454_ = _e386;
    if _e386 {
        let _e387 = (*randVal_1);
        let _e391 = tuning.treeFlowChance;
        phi_6454_ = (fract((_e387 * 29f)) < _e391);
    }
    let _e394 = phi_6454_;
    if _e394 {
        let _e395 = upValue;
        param_54 = _e395;
        let _e396 = getDir_u0028_u1_u003b((&param_54));
        let _e397 = upValue;
        param_55 = _e397;
        let _e398 = getAge_u0028_u1_u003b((&param_55));
        param_56 = 18u;
        param_57 = _e396;
        param_58 = 0u;
        param_59 = (_e398 + 1u);
        let _e400 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_56), (&param_57), (&param_58), (&param_59));
        lifted = _e400;
        let _e401 = upIndex;
        let _e404 = upValue;
        let _e405 = lifted;
        let _e406 = atomicCompareExchangeWeak((&unnamed.grid[_e401]), _e404, _e405);
        let _e408 = upValue;
        if (_e406.old_value == _e408) {
            let _e410 = water;
            water = (_e410 - 1u);
            changed = true;
        }
    }
    let _e412 = height;
    let _e415 = tuning.treeMaxHeight;
    if ((_e412 + 1u) < _e415) {
        let _e417 = water;
        let _e419 = tuning.treeGrowCost;
        let _e420 = (_e417 >= _e419);
        phi_6499_ = _e420;
        if _e420 {
            let _e421 = upPos;
            param_60 = _e421;
            let _e422 = treeInBounds_u0028_vi3_u003b((&param_60));
            phi_6499_ = _e422;
        }
        let _e424 = phi_6499_;
        if _e424 {
            let _e425 = upValue;
            param_61 = _e425;
            let _e426 = getType_u0028_u1_u003b((&param_61));
            upType = _e426;
            let _e427 = upType;
            let _e429 = upType;
            if ((_e427 == 0u) || (_e429 == 19u)) {
                let _e432 = height;
                param_62 = 18u;
                param_63 = (_e432 + 1u);
                param_64 = 0u;
                param_65 = 0u;
                let _e434 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_62), (&param_63), (&param_64), (&param_65));
                sapling = _e434;
                let _e435 = upIndex;
                let _e438 = upValue;
                let _e439 = sapling;
                let _e440 = atomicCompareExchangeWeak((&unnamed.grid[_e435]), _e438, _e439);
                let _e442 = upValue;
                if (_e440.old_value == _e442) {
                    let _e445 = tuning.treeGrowCost;
                    let _e446 = water;
                    water = (_e446 - _e445);
                    changed = true;
                }
            }
        }
    } else {
        let _e448 = water;
        let _e450 = tuning.treeLeafCost;
        let _e451 = (_e448 >= _e450);
        phi_6550_ = _e451;
        if _e451 {
            let _e452 = (*randVal_1);
            let _e456 = tuning.treeLeafChance;
            phi_6550_ = (fract((_e452 * 37f)) < _e456);
        }
        let _e459 = phi_6550_;
        if _e459 {
            let _e460 = (*randVal_1);
            start_2 = i32((fract((_e460 * 43f)) * 26f));
            i_3 = 0i;
            loop {
                let _e465 = i_3;
                if (_e465 < 26i) {
                    let _e467 = (*pos_2);
                    let _e468 = start_2;
                    let _e469 = i_3;
                    let _e470 = (_e468 + _e469);
                    param_66 = (_e470 - (i32(floor((f32(_e470) / f32(26i)))) * 26i));
                    let _e478 = tree26_u0028_i1_u003b((&param_66));
                    c_2 = (_e467 + _e478);
                    let _e480 = c_2;
                    param_67 = _e480;
                    let _e481 = treeInBounds_u0028_vi3_u003b((&param_67));
                    if !(_e481) {
                        continue;
                    }
                    let _e483 = c_2;
                    param_68 = _e483;
                    let _e484 = getIndex_u0028_vi3_u003b((&param_68));
                    idx_1 = _e484;
                    let _e485 = idx_1;
                    param_69 = _e485;
                    let _e486 = readCell_u0028_u1_u003b((&param_69));
                    if (_e486 != 0u) {
                        continue;
                    }
                    let _e488 = idx_1;
                    param_70 = 19u;
                    param_71 = 0u;
                    param_72 = 0u;
                    param_73 = 1u;
                    let _e491 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_70), (&param_71), (&param_72), (&param_73));
                    let _e492 = atomicCompareExchangeWeak((&unnamed.grid[_e488]), 0u, _e491);
                    if (_e492.old_value == 0u) {
                        let _e496 = tuning.treeLeafCost;
                        let _e497 = water;
                        water = (_e497 - _e496);
                        changed = true;
                        break;
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e499 = i_3;
                    i_3 = (_e499 + 1i);
                }
            }
        }
    }
    let _e501 = water;
    let _e503 = tuning.treeSpreadCost;
    let _e504 = (_e501 >= _e503);
    phi_6629_ = _e504;
    if _e504 {
        let _e505 = (*randVal_1);
        let _e509 = tuning.treeSpreadChance;
        phi_6629_ = (fract((_e505 * 59f)) < _e509);
    }
    let _e512 = phi_6629_;
    if _e512 {
        let _e513 = (*randVal_1);
        start_3 = i32((fract((_e513 * 61f)) * 8f));
        i_4 = 0i;
        loop {
            let _e518 = i_4;
            if (_e518 < 8i) {
                let _e520 = (*pos_2);
                let _e521 = start_3;
                let _e522 = i_4;
                let _e523 = (_e521 + _e522);
                param_74 = (_e523 - (i32(floor((f32(_e523) / f32(8i)))) * 8i));
                let _e531 = getHDir_u0028_i1_u003b((&param_74));
                c_3 = (_e520 + _e531);
                let _e533 = c_3;
                param_75 = _e533;
                let _e534 = treeInBounds_u0028_vi3_u003b((&param_75));
                if !(_e534) {
                    continue;
                }
                let _e536 = c_3;
                param_76 = _e536;
                let _e537 = getIndex_u0028_vi3_u003b((&param_76));
                idx_2 = _e537;
                let _e538 = idx_2;
                param_77 = _e538;
                let _e539 = readCell_u0028_u1_u003b((&param_77));
                if (_e539 != 0u) {
                    continue;
                }
                let _e541 = c_3;
                param_78 = (_e541 + vec3<i32>(0i, -1i, 0i));
                let _e543 = getIndex_u0028_vi3_u003b((&param_78));
                param_79 = _e543;
                let _e544 = readCell_u0028_u1_u003b((&param_79));
                param_80 = _e544;
                let _e545 = isGrassBlock_u0028_u1_u003b((&param_80));
                if !(_e545) {
                    continue;
                }
                let _e547 = idx_2;
                param_81 = 18u;
                param_82 = 0u;
                param_83 = 0u;
                param_84 = 0u;
                let _e550 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_81), (&param_82), (&param_83), (&param_84));
                let _e551 = atomicCompareExchangeWeak((&unnamed.grid[_e547]), 0u, _e550);
                if (_e551.old_value == 0u) {
                    let _e555 = tuning.treeSpreadCost;
                    let _e556 = water;
                    water = (_e556 - _e555);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e558 = i_4;
                i_4 = (_e558 + 1i);
            }
        }
    }
    let _e560 = changed;
    if _e560 {
        let _e561 = (*currentIndex_2);
        let _e564 = (*rawValue_1);
        param_85 = 18u;
        let _e565 = height;
        param_86 = _e565;
        param_87 = 0u;
        let _e566 = water;
        param_88 = _e566;
        let _e567 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_85), (&param_86), (&param_87), (&param_88));
        let _e568 = atomicCompareExchangeWeak((&unnamed.grid[_e561]), _e564, _e567);
    }
    return;
}

fn locustPackNav_u0028_u1_u003b_u1_u003b(heading: ptr<function, u32>, steps: ptr<function, u32>) -> u32 {
    let _e198 = (*heading);
    let _e200 = (*steps);
    return ((_e198 & 7u) | (min(_e200, 7u) << bitcast<u32>(3i)));
}

fn locustReverse_u0028_u1_u003b(d_1: ptr<function, u32>) -> u32 {
    let _e197 = (*d_1);
    if (_e197 == 0u) {
        return 1u;
    }
    let _e199 = (*d_1);
    if (_e199 == 1u) {
        return 0u;
    }
    let _e201 = (*d_1);
    if (_e201 == 2u) {
        return 3u;
    }
    let _e203 = (*d_1);
    if (_e203 == 3u) {
        return 2u;
    }
    let _e205 = (*d_1);
    if (_e205 == 4u) {
        return 7u;
    }
    let _e207 = (*d_1);
    if (_e207 == 5u) {
        return 6u;
    }
    let _e209 = (*d_1);
    if (_e209 == 6u) {
        return 5u;
    }
    return 4u;
}

fn locustRunSteps_u0028_() -> u32 {
    let _e197 = tuning.locustRunLength;
    return clamp(_e197, 1u, 7u);
}

fn isLocustFood_u0028_u1_u003b(value_1: ptr<function, u32>) -> bool {
    var param_89: u32;
    var param_90: u32;
    var phi_921_: bool;

    let _e199 = (*value_1);
    param_89 = _e199;
    let _e200 = isGrassBlock_u0028_u1_u003b((&param_89));
    phi_921_ = _e200;
    if !(_e200) {
        let _e202 = (*value_1);
        param_90 = _e202;
        let _e203 = getType_u0028_u1_u003b((&param_90));
        phi_921_ = (_e203 == 19u);
    }
    let _e206 = phi_921_;
    return _e206;
}

fn locustFoodAt_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> bool {
    var param_91: vec3<i32>;
    var param_92: u32;
    var param_93: u32;
    var phi_936_: bool;
    var phi_943_: bool;
    var phi_953_: bool;
    var phi_960_: bool;
    var phi_970_: bool;

    let _e201 = (*p_1)[0u];
    let _e202 = (_e201 < 0i);
    phi_936_ = _e202;
    if !(_e202) {
        let _e205 = (*p_1)[0u];
        let _e207 = tuning.gridWidth;
        phi_936_ = (_e205 >= bitcast<i32>(_e207));
    }
    let _e211 = phi_936_;
    phi_943_ = _e211;
    if !(_e211) {
        let _e214 = (*p_1)[1u];
        phi_943_ = (_e214 < 0i);
    }
    let _e217 = phi_943_;
    phi_953_ = _e217;
    if !(_e217) {
        let _e220 = (*p_1)[1u];
        let _e222 = tuning.gridHeight;
        phi_953_ = (_e220 >= bitcast<i32>(_e222));
    }
    let _e226 = phi_953_;
    phi_960_ = _e226;
    if !(_e226) {
        let _e229 = (*p_1)[2u];
        phi_960_ = (_e229 < 0i);
    }
    let _e232 = phi_960_;
    phi_970_ = _e232;
    if !(_e232) {
        let _e235 = (*p_1)[2u];
        let _e237 = tuning.gridDepth;
        phi_970_ = (_e235 >= bitcast<i32>(_e237));
    }
    let _e241 = phi_970_;
    if _e241 {
        return false;
    }
    let _e242 = (*p_1);
    param_91 = _e242;
    let _e243 = getIndex_u0028_vi3_u003b((&param_91));
    param_92 = _e243;
    let _e244 = readCell_u0028_u1_u003b((&param_92));
    param_93 = _e244;
    let _e245 = isLocustFood_u0028_u1_u003b((&param_93));
    return _e245;
}

fn locustSteps_u0028_u1_u003b(dirByte: ptr<function, u32>) -> u32 {
    let _e197 = (*dirByte);
    return ((_e197 >> bitcast<u32>(3i)) & 7u);
}

fn locustHeading_u0028_u1_u003b(dirByte_1: ptr<function, u32>) -> u32 {
    let _e197 = (*dirByte_1);
    return (_e197 & 7u);
}

fn locustArriveDir_u0028_vi3_u003b_u1_u003b(dest: ptr<function, vec3<i32>>, nav: ptr<function, u32>) -> u32 {
    var param_94: vec3<i32>;

    let _e199 = (*dest);
    param_94 = (_e199 + vec3<i32>(0i, -1i, 0i));
    let _e201 = locustFoodAt_u0028_vi3_u003b((&param_94));
    let _e202 = (*nav);
    return select(_e202, 0u, _e201);
}

fn locustHasGrip_u0028_vi3_u003b(pos_3: ptr<function, vec3<i32>>) -> bool {
    var d_2: i32;
    var n: vec3<i32>;
    var param_95: i32;
    var param_96: vec3<i32>;
    var param_97: u32;
    var phi_1073_: bool;
    var phi_1080_: bool;
    var phi_1091_: bool;

    d_2 = 0i;
    loop {
        let _e202 = d_2;
        if (_e202 < 8i) {
            let _e204 = (*pos_3);
            let _e205 = d_2;
            param_95 = _e205;
            let _e206 = getHDir_u0028_i1_u003b((&param_95));
            n = (_e204 + _e206);
            let _e209 = n[0u];
            let _e210 = (_e209 <= 0i);
            phi_1073_ = _e210;
            if !(_e210) {
                let _e213 = n[0u];
                let _e215 = tuning.gridWidth;
                phi_1073_ = (_e213 >= (bitcast<i32>(_e215) - 1i));
            }
            let _e220 = phi_1073_;
            phi_1080_ = _e220;
            if !(_e220) {
                let _e223 = n[2u];
                phi_1080_ = (_e223 <= 0i);
            }
            let _e226 = phi_1080_;
            phi_1091_ = _e226;
            if !(_e226) {
                let _e229 = n[2u];
                let _e231 = tuning.gridDepth;
                phi_1091_ = (_e229 >= (bitcast<i32>(_e231) - 1i));
            }
            let _e236 = phi_1091_;
            if _e236 {
                continue;
            }
            let _e237 = n;
            param_96 = _e237;
            let _e238 = getIndex_u0028_vi3_u003b((&param_96));
            param_97 = _e238;
            let _e239 = readCell_u0028_u1_u003b((&param_97));
            if (_e239 != 0u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e241 = d_2;
            d_2 = (_e241 + 1i);
        }
    }
    return false;
}

fn locustInBounds_u0028_vi3_u003b(p_2: ptr<function, vec3<i32>>) -> bool {
    var phi_857_: bool;
    var phi_863_: bool;
    var phi_873_: bool;
    var phi_879_: bool;
    var phi_889_: bool;

    let _e198 = (*p_2)[0u];
    let _e199 = (_e198 > 0i);
    phi_857_ = _e199;
    if _e199 {
        let _e201 = (*p_2)[0u];
        let _e203 = tuning.gridWidth;
        phi_857_ = (_e201 < (bitcast<i32>(_e203) - 1i));
    }
    let _e208 = phi_857_;
    phi_863_ = _e208;
    if _e208 {
        let _e210 = (*p_2)[1u];
        phi_863_ = (_e210 > 0i);
    }
    let _e213 = phi_863_;
    phi_873_ = _e213;
    if _e213 {
        let _e215 = (*p_2)[1u];
        let _e217 = tuning.gridHeight;
        phi_873_ = (_e215 < (bitcast<i32>(_e217) - 1i));
    }
    let _e222 = phi_873_;
    phi_879_ = _e222;
    if _e222 {
        let _e224 = (*p_2)[2u];
        phi_879_ = (_e224 > 0i);
    }
    let _e227 = phi_879_;
    phi_889_ = _e227;
    if _e227 {
        let _e229 = (*p_2)[2u];
        let _e231 = tuning.gridDepth;
        phi_889_ = (_e229 < (bitcast<i32>(_e231) - 1i));
    }
    let _e236 = phi_889_;
    return _e236;
}

fn locustStage_u0028_() -> u32 {
    let _e197 = tuning.locustStageSize;
    return max(_e197, 1u);
}

fn locustTypeFor_u0028_u1_u003b(count: ptr<function, u32>) -> u32 {
    var stage: u32;
    var local_5: u32;

    let _e199 = (*count);
    if (_e199 == 0u) {
        local_5 = 0u;
    } else {
        let _e201 = (*count);
        let _e203 = locustStage_u0028_();
        local_5 = ((_e201 - 1u) / _e203);
    }
    let _e205 = local_5;
    stage = _e205;
    let _e206 = stage;
    return (13u + min(_e206, 4u));
}

fn locustMaxCount_u0028_() -> u32 {
    let _e197 = tuning.locustMaxSize;
    return max(_e197, 1u);
}

fn locustBud_u0028_vi3_u003b_f1_u003b(pos_4: ptr<function, vec3<i32>>, randVal_2: ptr<function, f32>) {
    var bud: u32;
    var start_4: i32;
    var i_5: i32;
    var d_3: i32;
    var c_4: vec3<i32>;
    var param_98: i32;
    var param_99: vec3<i32>;
    var idx_3: u32;
    var param_100: vec3<i32>;
    var param_101: u32;
    var param_102: u32;
    var param_103: u32;
    var param_104: u32;
    var param_105: u32;
    var param_106: u32;

    let _e214 = tuning.locustBudSize;
    let _e215 = locustMaxCount_u0028_();
    bud = clamp(_e214, 1u, _e215);
    let _e217 = (*randVal_2);
    start_4 = i32((fract((_e217 * 31f)) * 8f));
    i_5 = 0i;
    loop {
        let _e222 = i_5;
        if (_e222 < 8i) {
            let _e224 = start_4;
            let _e225 = i_5;
            let _e226 = (_e224 + _e225);
            d_3 = (_e226 - (i32(floor((f32(_e226) / f32(8i)))) * 8i));
            let _e234 = (*pos_4);
            let _e235 = d_3;
            param_98 = _e235;
            let _e236 = getHDir_u0028_i1_u003b((&param_98));
            c_4 = (_e234 + _e236);
            let _e238 = c_4;
            param_99 = _e238;
            let _e239 = locustInBounds_u0028_vi3_u003b((&param_99));
            if !(_e239) {
                continue;
            }
            let _e241 = c_4;
            param_100 = _e241;
            let _e242 = getIndex_u0028_vi3_u003b((&param_100));
            idx_3 = _e242;
            let _e243 = idx_3;
            param_101 = _e243;
            let _e244 = readCell_u0028_u1_u003b((&param_101));
            if (_e244 != 0u) {
                continue;
            }
            let _e246 = idx_3;
            let _e249 = bud;
            param_102 = _e249;
            let _e250 = locustTypeFor_u0028_u1_u003b((&param_102));
            param_103 = _e250;
            param_104 = 0u;
            param_105 = 0u;
            let _e251 = bud;
            param_106 = _e251;
            let _e252 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_103), (&param_104), (&param_105), (&param_106));
            let _e253 = atomicCompareExchangeWeak((&unnamed.grid[_e246]), 0u, _e252);
            if (_e253.old_value == 0u) {
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e256 = i_5;
            i_5 = (_e256 + 1i);
        }
    }
    return;
}

fn locustEatTicks_u0028_u1_u003b(count_1: ptr<function, u32>) -> u32 {
    var fast: u32;
    var slow: u32;
    var cap: u32;
    var floorCount: u32;
    var t_1: f32;

    let _e203 = tuning.locustEatTicksMin;
    fast = _e203;
    let _e205 = tuning.locustEatTicksMax;
    slow = _e205;
    let _e206 = locustMaxCount_u0028_();
    cap = _e206;
    let _e207 = locustStage_u0028_();
    let _e208 = cap;
    floorCount = min(_e207, _e208);
    let _e210 = (*count_1);
    let _e211 = cap;
    if (_e210 >= _e211) {
        let _e213 = fast;
        return _e213;
    }
    let _e214 = (*count_1);
    let _e215 = floorCount;
    let _e217 = cap;
    let _e218 = floorCount;
    if ((_e214 <= _e215) || (_e217 == _e218)) {
        let _e221 = slow;
        return _e221;
    }
    let _e222 = (*count_1);
    let _e223 = floorCount;
    let _e226 = cap;
    let _e227 = floorCount;
    t_1 = (f32((_e222 - _e223)) / f32((_e226 - _e227)));
    let _e231 = slow;
    let _e233 = fast;
    let _e235 = t_1;
    return u32(round(mix(f32(_e231), f32(_e233), _e235)));
}

fn updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_5: ptr<function, vec3<i32>>, currentIndex_3: ptr<function, u32>, rawValue_2: ptr<function, u32>, currentDir_1: ptr<function, u32>, currentSleep: ptr<function, u32>, currentAge_2: ptr<function, u32>, randVal_3: ptr<function, f32>) {
    var type_34: u32;
    var param_107: u32;
    var phase: u32;
    var param_108: u32;
    var param_109: u32;
    var param_110: u32;
    var param_111: u32;
    var count_2: u32;
    var belowPos_1: vec3<i32>;
    var belowIndex: u32;
    var param_112: vec3<i32>;
    var belowValue: u32;
    var param_113: u32;
    var param_114: u32;
    var onLeaf: bool;
    var param_115: u32;
    var need: u32;
    var param_116: u32;
    var progress: u32;
    var flora_1: u32;
    var bite: u32;
    var thinned: u32;
    var local_6: u32;
    var param_117: u32;
    var param_118: u32;
    var param_119: u32;
    var param_120: u32;
    var param_121: u32;
    var param_122: u32;
    var param_123: u32;
    var param_124: u32;
    var param_125: u32;
    var param_126: u32;
    var stripped: u32;
    var local_7: u32;
    var param_127: u32;
    var param_128: u32;
    var param_129: u32;
    var param_130: u32;
    var param_131: u32;
    var param_132: u32;
    var grown: u32;
    var param_133: vec3<i32>;
    var param_134: f32;
    var param_135: u32;
    var param_136: u32;
    var param_137: u32;
    var param_138: u32;
    var param_139: u32;
    var newType: u32;
    var param_140: u32;
    var param_141: u32;
    var param_142: vec3<i32>;
    var param_143: vec3<i32>;
    var param_144: vec3<i32>;
    var param_145: u32;
    var param_146: u32;
    var param_147: u32;
    var param_148: u32;
    var param_149: u32;
    var param_150: u32;
    var param_151: u32;
    var param_152: u32;
    var param_153: u32;
    var heading_1: u32;
    var param_154: u32;
    var steps_1: u32;
    var param_155: u32;
    var start_5: i32;
    var i_6: i32;
    var d_4: i32;
    var c_5: vec3<i32>;
    var param_156: i32;
    var rise: i32;
    var t_2: vec3<i32>;
    var local_8: i32;
    var param_157: vec3<i32>;
    var param_158: vec3<i32>;
    var param_159: u32;
    var param_160: vec3<i32>;
    var param_161: vec3<i32>;
    var param_162: u32;
    var param_163: u32;
    var param_164: u32;
    var param_165: u32;
    var param_166: u32;
    var param_167: u32;
    var param_168: u32;
    var param_169: u32;
    var target_: vec3<i32>;
    var param_170: i32;
    var blocked: bool;
    var param_171: vec3<i32>;
    var param_172: vec3<i32>;
    var param_173: u32;
    var footing: vec3<i32>;
    var param_174: vec3<i32>;
    var param_175: vec3<i32>;
    var param_176: u32;
    var back: u32;
    var param_177: u32;
    var backPos: vec3<i32>;
    var param_178: i32;
    var backFoot: vec3<i32>;
    var backOpen: bool;
    var param_179: vec3<i32>;
    var param_180: vec3<i32>;
    var param_181: u32;
    var param_182: vec3<i32>;
    var param_183: vec3<i32>;
    var param_184: u32;
    var turnedNav: u32;
    var local_9: u32;
    var param_185: u32;
    var param_186: u32;
    var param_187: u32;
    var param_188: u32;
    var param_189: u32;
    var param_190: u32;
    var param_191: u32;
    var param_192: u32;
    var nav_1: u32;
    var param_193: u32;
    var param_194: u32;
    var param_195: vec3<i32>;
    var param_196: vec3<i32>;
    var param_197: u32;
    var param_198: u32;
    var param_199: u32;
    var param_200: u32;
    var param_201: u32;
    var param_202: u32;
    var param_203: u32;
    var param_204: u32;
    var param_205: u32;
    var overTop: vec3<i32>;
    var param_206: vec3<i32>;
    var param_207: vec3<i32>;
    var param_208: u32;
    var nav_2: u32;
    var param_209: u32;
    var param_210: u32;
    var param_211: vec3<i32>;
    var param_212: vec3<i32>;
    var param_213: u32;
    var param_214: u32;
    var param_215: u32;
    var param_216: u32;
    var param_217: u32;
    var param_218: u32;
    var param_219: u32;
    var param_220: u32;
    var param_221: u32;
    var up: vec3<i32>;
    var param_222: vec3<i32>;
    var param_223: vec3<i32>;
    var param_224: u32;
    var nav_3: u32;
    var param_225: u32;
    var param_226: u32;
    var param_227: vec3<i32>;
    var param_228: vec3<i32>;
    var param_229: u32;
    var param_230: u32;
    var param_231: u32;
    var param_232: u32;
    var param_233: u32;
    var param_234: u32;
    var param_235: u32;
    var param_236: u32;
    var param_237: u32;
    var param_238: u32;
    var param_239: u32;
    var param_240: u32;
    var param_241: u32;
    var param_242: u32;
    var param_243: u32;
    var phi_7211_: bool;
    var phi_7218_: bool;
    var phi_7379_: bool;
    var phi_7398_: bool;
    var phi_7427_: bool;
    var phi_7441_: bool;
    var phi_7443_: bool;
    var phi_7535_: bool;
    var phi_7584_: bool;

    let _e380 = (*rawValue_2);
    param_107 = _e380;
    let _e381 = getType_u0028_u1_u003b((&param_107));
    type_34 = _e381;
    let _e382 = (*currentSleep);
    phase = (_e382 + 1u);
    let _e384 = phase;
    let _e386 = tuning.locustTickDispatches;
    if (_e384 < _e386) {
        let _e388 = (*currentIndex_3);
        let _e391 = (*rawValue_2);
        let _e392 = type_34;
        param_108 = _e392;
        let _e393 = (*currentDir_1);
        param_109 = _e393;
        let _e394 = phase;
        param_110 = _e394;
        let _e395 = (*currentAge_2);
        param_111 = _e395;
        let _e396 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_108), (&param_109), (&param_110), (&param_111));
        let _e397 = atomicCompareExchangeWeak((&unnamed.grid[_e388]), _e391, _e396);
        return;
    }
    let _e399 = (*currentAge_2);
    count_2 = _e399;
    let _e400 = (*pos_5);
    belowPos_1 = (_e400 + vec3<i32>(0i, -1i, 0i));
    let _e402 = belowPos_1;
    param_112 = _e402;
    let _e403 = getIndex_u0028_vi3_u003b((&param_112));
    belowIndex = _e403;
    let _e404 = belowIndex;
    param_113 = _e404;
    let _e405 = readCell_u0028_u1_u003b((&param_113));
    belowValue = _e405;
    let _e406 = belowValue;
    param_114 = _e406;
    let _e407 = isLocustFood_u0028_u1_u003b((&param_114));
    if _e407 {
        let _e408 = belowValue;
        param_115 = _e408;
        let _e409 = getType_u0028_u1_u003b((&param_115));
        onLeaf = (_e409 == 19u);
        let _e411 = count_2;
        param_116 = _e411;
        let _e412 = locustEatTicks_u0028_u1_u003b((&param_116));
        need = _e412;
        let _e413 = (*currentDir_1);
        progress = (_e413 + 1u);
        let _e415 = progress;
        let _e416 = need;
        if (_e415 < _e416) {
            let _e418 = onLeaf;
            if !(_e418) {
                let _e420 = belowValue;
                flora_1 = ((_e420 >> bitcast<u32>(8i)) & 255u);
                let _e424 = need;
                bite = max((90u / max(_e424, 1u)), 1u);
                let _e428 = flora_1;
                let _e429 = bite;
                if (_e428 > (11u + _e429)) {
                    let _e432 = flora_1;
                    let _e433 = bite;
                    local_6 = (_e432 - _e433);
                } else {
                    local_6 = 11u;
                }
                let _e435 = local_6;
                thinned = _e435;
                let _e436 = belowIndex;
                let _e439 = belowValue;
                let _e440 = belowValue;
                param_117 = _e440;
                let _e441 = getSleep_u0028_u1_u003b((&param_117));
                let _e442 = belowValue;
                param_118 = _e442;
                let _e443 = getAge_u0028_u1_u003b((&param_118));
                param_119 = 4u;
                let _e444 = thinned;
                param_120 = _e444;
                param_121 = _e441;
                param_122 = _e443;
                let _e445 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_119), (&param_120), (&param_121), (&param_122));
                let _e446 = atomicCompareExchangeWeak((&unnamed.grid[_e436]), _e439, _e445);
            }
            let _e448 = (*currentIndex_3);
            let _e451 = (*rawValue_2);
            let _e452 = type_34;
            param_123 = _e452;
            let _e453 = progress;
            param_124 = _e453;
            param_125 = 0u;
            let _e454 = count_2;
            param_126 = _e454;
            let _e455 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_123), (&param_124), (&param_125), (&param_126));
            let _e456 = atomicCompareExchangeWeak((&unnamed.grid[_e448]), _e451, _e455);
            return;
        }
        let _e458 = onLeaf;
        if _e458 {
            local_7 = 0u;
        } else {
            let _e459 = belowValue;
            param_127 = _e459;
            let _e460 = getSleep_u0028_u1_u003b((&param_127));
            let _e461 = belowValue;
            param_128 = _e461;
            let _e462 = getAge_u0028_u1_u003b((&param_128));
            param_129 = 4u;
            param_130 = 0u;
            param_131 = _e460;
            param_132 = _e462;
            let _e463 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_129), (&param_130), (&param_131), (&param_132));
            local_7 = _e463;
        }
        let _e464 = local_7;
        stripped = _e464;
        let _e465 = belowIndex;
        let _e468 = belowValue;
        let _e469 = stripped;
        let _e470 = atomicCompareExchangeWeak((&unnamed.grid[_e465]), _e468, _e469);
        let _e472 = belowValue;
        if (_e470.old_value != _e472) {
            return;
        }
        let _e474 = count_2;
        let _e476 = tuning.locustEatGain;
        grown = (_e474 + _e476);
        let _e478 = grown;
        let _e479 = locustMaxCount_u0028_();
        if (_e478 > _e479) {
            let _e481 = (*pos_5);
            param_133 = _e481;
            let _e482 = (*randVal_3);
            param_134 = _e482;
            locustBud_u0028_vi3_u003b_f1_u003b((&param_133), (&param_134));
            let _e483 = locustMaxCount_u0028_();
            grown = _e483;
        }
        let _e484 = (*currentIndex_3);
        let _e487 = (*rawValue_2);
        let _e488 = grown;
        param_135 = _e488;
        let _e489 = locustTypeFor_u0028_u1_u003b((&param_135));
        param_136 = _e489;
        param_137 = 0u;
        param_138 = 0u;
        let _e490 = grown;
        param_139 = _e490;
        let _e491 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_136), (&param_137), (&param_138), (&param_139));
        let _e492 = atomicCompareExchangeWeak((&unnamed.grid[_e484]), _e487, _e491);
        return;
    }
    let _e494 = count_2;
    if (_e494 <= 1u) {
        let _e496 = (*currentIndex_3);
        let _e499 = (*rawValue_2);
        let _e500 = atomicCompareExchangeWeak((&unnamed.grid[_e496]), _e499, 0u);
        return;
    }
    let _e502 = count_2;
    count_2 = (_e502 - 1u);
    let _e504 = count_2;
    param_140 = _e504;
    let _e505 = locustTypeFor_u0028_u1_u003b((&param_140));
    newType = _e505;
    let _e506 = belowValue;
    param_141 = _e506;
    let _e507 = getType_u0028_u1_u003b((&param_141));
    let _e508 = (_e507 == 0u);
    phi_7211_ = _e508;
    if _e508 {
        let _e509 = belowPos_1;
        param_142 = _e509;
        let _e510 = locustInBounds_u0028_vi3_u003b((&param_142));
        phi_7211_ = _e510;
    }
    let _e512 = phi_7211_;
    phi_7218_ = _e512;
    if _e512 {
        let _e513 = (*pos_5);
        param_143 = _e513;
        let _e514 = locustHasGrip_u0028_vi3_u003b((&param_143));
        phi_7218_ = !(_e514);
    }
    let _e517 = phi_7218_;
    if _e517 {
        let _e518 = belowPos_1;
        param_144 = _e518;
        let _e519 = (*currentDir_1);
        param_145 = _e519;
        let _e520 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_144), (&param_145));
        let _e521 = newType;
        param_146 = _e521;
        param_147 = _e520;
        param_148 = 0u;
        let _e522 = count_2;
        param_149 = _e522;
        let _e523 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_146), (&param_147), (&param_148), (&param_149));
        let _e524 = (*currentIndex_3);
        param_150 = _e524;
        let _e525 = (*rawValue_2);
        param_151 = _e525;
        let _e526 = belowIndex;
        param_152 = _e526;
        param_153 = _e523;
        let _e527 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_150), (&param_151), (&param_152), (&param_153));
        if _e527 {
            return;
        }
    }
    let _e528 = (*currentDir_1);
    param_154 = _e528;
    let _e529 = locustHeading_u0028_u1_u003b((&param_154));
    heading_1 = _e529;
    let _e530 = (*currentDir_1);
    param_155 = _e530;
    let _e531 = locustSteps_u0028_u1_u003b((&param_155));
    steps_1 = _e531;
    let _e532 = steps_1;
    if (_e532 == 0u) {
        let _e534 = (*randVal_3);
        start_5 = i32((fract((_e534 * 17f)) * 8f));
        i_6 = 0i;
        loop {
            let _e539 = i_6;
            if (_e539 < 8i) {
                let _e541 = start_5;
                let _e542 = i_6;
                let _e543 = (_e541 + _e542);
                d_4 = (_e543 - (i32(floor((f32(_e543) / f32(8i)))) * 8i));
                let _e551 = (*pos_5);
                let _e552 = d_4;
                param_156 = _e552;
                let _e553 = getHDir_u0028_i1_u003b((&param_156));
                c_5 = (_e551 + _e553);
                rise = 0i;
                loop {
                    let _e555 = rise;
                    if (_e555 < 3i) {
                        let _e557 = c_5;
                        let _e558 = rise;
                        if (_e558 == 1i) {
                            local_8 = 1i;
                        } else {
                            let _e560 = rise;
                            local_8 = select(0i, -1i, (_e560 == 2i));
                        }
                        let _e563 = local_8;
                        t_2 = (_e557 + vec3<i32>(0i, _e563, 0i));
                        let _e566 = t_2;
                        param_157 = _e566;
                        let _e567 = locustInBounds_u0028_vi3_u003b((&param_157));
                        if !(_e567) {
                            continue;
                        }
                        let _e569 = t_2;
                        param_158 = _e569;
                        let _e570 = getIndex_u0028_vi3_u003b((&param_158));
                        param_159 = _e570;
                        let _e571 = readCell_u0028_u1_u003b((&param_159));
                        if (_e571 != 0u) {
                            continue;
                        }
                        let _e573 = t_2;
                        param_160 = (_e573 + vec3<i32>(0i, -1i, 0i));
                        let _e575 = locustFoodAt_u0028_vi3_u003b((&param_160));
                        if !(_e575) {
                            continue;
                        }
                        let _e577 = t_2;
                        param_161 = _e577;
                        let _e578 = getIndex_u0028_vi3_u003b((&param_161));
                        let _e579 = newType;
                        param_162 = _e579;
                        param_163 = 0u;
                        param_164 = 0u;
                        let _e580 = count_2;
                        param_165 = _e580;
                        let _e581 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_162), (&param_163), (&param_164), (&param_165));
                        let _e582 = (*currentIndex_3);
                        param_166 = _e582;
                        let _e583 = (*rawValue_2);
                        param_167 = _e583;
                        param_168 = _e578;
                        param_169 = _e581;
                        let _e584 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_166), (&param_167), (&param_168), (&param_169));
                        if _e584 {
                            return;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e585 = rise;
                        rise = (_e585 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e587 = i_6;
                i_6 = (_e587 + 1i);
            }
        }
        let _e589 = (*randVal_3);
        heading_1 = (u32((fract((_e589 * 23f)) * 8f)) & 7u);
        let _e595 = locustRunSteps_u0028_();
        steps_1 = _e595;
    }
    let _e596 = (*pos_5);
    let _e597 = heading_1;
    param_170 = bitcast<i32>(_e597);
    let _e599 = getHDir_u0028_i1_u003b((&param_170));
    target_ = (_e596 + _e599);
    let _e601 = target_;
    param_171 = _e601;
    let _e602 = locustInBounds_u0028_vi3_u003b((&param_171));
    let _e603 = !(_e602);
    phi_7379_ = _e603;
    if !(_e603) {
        let _e605 = target_;
        param_172 = _e605;
        let _e606 = getIndex_u0028_vi3_u003b((&param_172));
        param_173 = _e606;
        let _e607 = readCell_u0028_u1_u003b((&param_173));
        phi_7379_ = (_e607 != 0u);
    }
    let _e610 = phi_7379_;
    blocked = _e610;
    let _e611 = blocked;
    if !(_e611) {
        let _e613 = target_;
        footing = (_e613 + vec3<i32>(0i, -1i, 0i));
        let _e615 = footing;
        param_174 = _e615;
        let _e616 = locustInBounds_u0028_vi3_u003b((&param_174));
        phi_7398_ = _e616;
        if _e616 {
            let _e617 = footing;
            param_175 = _e617;
            let _e618 = getIndex_u0028_vi3_u003b((&param_175));
            param_176 = _e618;
            let _e619 = readCell_u0028_u1_u003b((&param_176));
            phi_7398_ = (_e619 == 0u);
        }
        let _e622 = phi_7398_;
        if _e622 {
            let _e623 = heading_1;
            param_177 = _e623;
            let _e624 = locustReverse_u0028_u1_u003b((&param_177));
            back = _e624;
            let _e625 = (*pos_5);
            let _e626 = back;
            param_178 = bitcast<i32>(_e626);
            let _e628 = getHDir_u0028_i1_u003b((&param_178));
            backPos = (_e625 + _e628);
            let _e630 = backPos;
            backFoot = (_e630 + vec3<i32>(0i, -1i, 0i));
            let _e632 = backPos;
            param_179 = _e632;
            let _e633 = locustInBounds_u0028_vi3_u003b((&param_179));
            phi_7427_ = _e633;
            if _e633 {
                let _e634 = backPos;
                param_180 = _e634;
                let _e635 = getIndex_u0028_vi3_u003b((&param_180));
                param_181 = _e635;
                let _e636 = readCell_u0028_u1_u003b((&param_181));
                phi_7427_ = (_e636 == 0u);
            }
            let _e639 = phi_7427_;
            phi_7443_ = _e639;
            if _e639 {
                let _e640 = backFoot;
                param_182 = _e640;
                let _e641 = locustInBounds_u0028_vi3_u003b((&param_182));
                phi_7441_ = _e641;
                if _e641 {
                    let _e642 = backFoot;
                    param_183 = _e642;
                    let _e643 = getIndex_u0028_vi3_u003b((&param_183));
                    param_184 = _e643;
                    let _e644 = readCell_u0028_u1_u003b((&param_184));
                    phi_7441_ = (_e644 == 0u);
                }
                let _e647 = phi_7441_;
                phi_7443_ = !(_e647);
            }
            let _e650 = phi_7443_;
            backOpen = _e650;
            let _e651 = backOpen;
            if _e651 {
                let _e652 = back;
                param_185 = _e652;
                let _e653 = steps_1;
                param_186 = _e653;
                let _e654 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_185), (&param_186));
                local_9 = _e654;
            } else {
                let _e655 = (*randVal_3);
                let _e661 = locustRunSteps_u0028_();
                param_187 = (u32((fract((_e655 * 71f)) * 8f)) & 7u);
                param_188 = _e661;
                let _e662 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_187), (&param_188));
                local_9 = _e662;
            }
            let _e663 = local_9;
            turnedNav = _e663;
            let _e664 = (*currentIndex_3);
            let _e667 = (*rawValue_2);
            let _e668 = newType;
            param_189 = _e668;
            let _e669 = turnedNav;
            param_190 = _e669;
            param_191 = 0u;
            let _e670 = count_2;
            param_192 = _e670;
            let _e671 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_189), (&param_190), (&param_191), (&param_192));
            let _e672 = atomicCompareExchangeWeak((&unnamed.grid[_e664]), _e667, _e671);
            return;
        }
        let _e674 = steps_1;
        let _e676 = heading_1;
        param_193 = _e676;
        param_194 = (_e674 - 1u);
        let _e677 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_193), (&param_194));
        nav_1 = _e677;
        let _e678 = target_;
        param_195 = _e678;
        let _e679 = getIndex_u0028_vi3_u003b((&param_195));
        let _e680 = target_;
        param_196 = _e680;
        let _e681 = nav_1;
        param_197 = _e681;
        let _e682 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_196), (&param_197));
        let _e683 = newType;
        param_198 = _e683;
        param_199 = _e682;
        param_200 = 0u;
        let _e684 = count_2;
        param_201 = _e684;
        let _e685 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_198), (&param_199), (&param_200), (&param_201));
        let _e686 = (*currentIndex_3);
        param_202 = _e686;
        let _e687 = (*rawValue_2);
        param_203 = _e687;
        param_204 = _e679;
        param_205 = _e685;
        let _e688 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_202), (&param_203), (&param_204), (&param_205));
        if _e688 {
            return;
        }
    } else {
        let _e689 = (*randVal_3);
        let _e693 = tuning.locustClimbChance;
        if (fract((_e689 * 41f)) < _e693) {
            let _e695 = target_;
            overTop = (_e695 + vec3<i32>(0i, 1i, 0i));
            let _e697 = overTop;
            param_206 = _e697;
            let _e698 = locustInBounds_u0028_vi3_u003b((&param_206));
            phi_7535_ = _e698;
            if _e698 {
                let _e699 = overTop;
                param_207 = _e699;
                let _e700 = getIndex_u0028_vi3_u003b((&param_207));
                param_208 = _e700;
                let _e701 = readCell_u0028_u1_u003b((&param_208));
                phi_7535_ = (_e701 == 0u);
            }
            let _e704 = phi_7535_;
            if _e704 {
                let _e705 = steps_1;
                let _e707 = heading_1;
                param_209 = _e707;
                param_210 = (_e705 - 1u);
                let _e708 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_209), (&param_210));
                nav_2 = _e708;
                let _e709 = overTop;
                param_211 = _e709;
                let _e710 = getIndex_u0028_vi3_u003b((&param_211));
                let _e711 = overTop;
                param_212 = _e711;
                let _e712 = nav_2;
                param_213 = _e712;
                let _e713 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_212), (&param_213));
                let _e714 = newType;
                param_214 = _e714;
                param_215 = _e713;
                param_216 = 0u;
                let _e715 = count_2;
                param_217 = _e715;
                let _e716 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_214), (&param_215), (&param_216), (&param_217));
                let _e717 = (*currentIndex_3);
                param_218 = _e717;
                let _e718 = (*rawValue_2);
                param_219 = _e718;
                param_220 = _e710;
                param_221 = _e716;
                let _e719 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_218), (&param_219), (&param_220), (&param_221));
                if _e719 {
                    return;
                }
            }
            let _e720 = (*pos_5);
            up = (_e720 + vec3<i32>(0i, 1i, 0i));
            let _e722 = up;
            param_222 = _e722;
            let _e723 = locustInBounds_u0028_vi3_u003b((&param_222));
            phi_7584_ = _e723;
            if _e723 {
                let _e724 = up;
                param_223 = _e724;
                let _e725 = getIndex_u0028_vi3_u003b((&param_223));
                param_224 = _e725;
                let _e726 = readCell_u0028_u1_u003b((&param_224));
                phi_7584_ = (_e726 == 0u);
            }
            let _e729 = phi_7584_;
            if _e729 {
                let _e730 = heading_1;
                param_225 = _e730;
                let _e731 = steps_1;
                param_226 = _e731;
                let _e732 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_225), (&param_226));
                nav_3 = _e732;
                let _e733 = up;
                param_227 = _e733;
                let _e734 = getIndex_u0028_vi3_u003b((&param_227));
                let _e735 = up;
                param_228 = _e735;
                let _e736 = nav_3;
                param_229 = _e736;
                let _e737 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_228), (&param_229));
                let _e738 = newType;
                param_230 = _e738;
                param_231 = _e737;
                param_232 = 0u;
                let _e739 = count_2;
                param_233 = _e739;
                let _e740 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_230), (&param_231), (&param_232), (&param_233));
                let _e741 = (*currentIndex_3);
                param_234 = _e741;
                let _e742 = (*rawValue_2);
                param_235 = _e742;
                param_236 = _e734;
                param_237 = _e740;
                let _e743 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_234), (&param_235), (&param_236), (&param_237));
                if _e743 {
                    return;
                }
            }
        }
        let _e744 = (*randVal_3);
        heading_1 = (u32((fract((_e744 * 53f)) * 8f)) & 7u);
        let _e750 = locustRunSteps_u0028_();
        steps_1 = _e750;
    }
    let _e751 = (*currentIndex_3);
    let _e754 = (*rawValue_2);
    let _e755 = heading_1;
    param_238 = _e755;
    let _e756 = steps_1;
    param_239 = _e756;
    let _e757 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_238), (&param_239));
    let _e758 = newType;
    param_240 = _e758;
    param_241 = _e757;
    param_242 = 0u;
    let _e759 = count_2;
    param_243 = _e759;
    let _e760 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_240), (&param_241), (&param_242), (&param_243));
    let _e761 = atomicCompareExchangeWeak((&unnamed.grid[_e751]), _e754, _e760);
    return;
}

fn updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_6: ptr<function, vec3<i32>>, currentIndex_4: ptr<function, u32>, rawValue_3: ptr<function, u32>, currentAge_3: ptr<function, u32>, randVal_4: ptr<function, f32>) {
    var belowPos_2: vec3<i32>;
    var param_244: vec3<i32>;
    var param_245: u32;
    var param_246: u32;
    var param_247: vec3<i32>;
    var param_248: u32;
    var param_249: u32;
    var param_250: u32;
    var param_251: u32;
    var param_252: u32;
    var param_253: u32;
    var param_254: u32;
    var param_255: u32;
    var param_256: u32;
    var param_257: u32;
    var param_258: u32;
    var param_259: u32;
    var phi_6268_: bool;

    let _e219 = (*pos_6)[1u];
    if (_e219 > 1i) {
        let _e221 = (*pos_6);
        belowPos_2 = (_e221 + vec3<i32>(0i, -1i, 0i));
        let _e223 = belowPos_2;
        param_244 = _e223;
        let _e224 = getIndex_u0028_vi3_u003b((&param_244));
        param_245 = _e224;
        let _e225 = readCell_u0028_u1_u003b((&param_245));
        param_246 = _e225;
        let _e226 = getType_u0028_u1_u003b((&param_246));
        if (_e226 == 0u) {
            let _e228 = belowPos_2;
            param_247 = _e228;
            let _e229 = getIndex_u0028_vi3_u003b((&param_247));
            param_248 = 12u;
            param_249 = 0u;
            param_250 = 0u;
            let _e230 = (*currentAge_3);
            param_251 = _e230;
            let _e231 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_248), (&param_249), (&param_250), (&param_251));
            let _e232 = (*currentIndex_4);
            param_252 = _e232;
            let _e233 = (*rawValue_3);
            param_253 = _e233;
            param_254 = _e229;
            param_255 = _e231;
            let _e234 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_252), (&param_253), (&param_254), (&param_255));
            if _e234 {
                return;
            }
        }
    }
    let _e235 = (*currentAge_3);
    let _e236 = (_e235 > 0u);
    phi_6268_ = _e236;
    if _e236 {
        let _e237 = (*randVal_4);
        let _e241 = tuning.darkStoneDryChance;
        phi_6268_ = (fract((_e237 * 23f)) < _e241);
    }
    let _e244 = phi_6268_;
    if _e244 {
        let _e245 = (*currentIndex_4);
        let _e248 = (*rawValue_3);
        let _e249 = (*currentAge_3);
        param_256 = 12u;
        param_257 = 0u;
        param_258 = 0u;
        param_259 = (_e249 - 1u);
        let _e251 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_256), (&param_257), (&param_258), (&param_259));
        let _e252 = atomicCompareExchangeWeak((&unnamed.grid[_e245]), _e248, _e251);
    }
    return;
}

fn isLava_u0028_u1_u003b(type_35: ptr<function, u32>) -> bool {
    let _e197 = (*type_35);
    let _e199 = (*type_35);
    return ((_e197 >= 8u) && (_e199 <= 11u));
}

fn lavaTypeFor_u0028_u1_u003b(coolness: ptr<function, u32>) -> u32 {
    let _e197 = (*coolness);
    let _e199 = tuning.lavaStageSize;
    return (8u + min((_e197 / max(_e199, 1u)), 3u));
}

fn lavaSolidifyCoolness_u0028_() -> u32 {
    let _e197 = tuning.lavaStageSize;
    return min((max(_e197, 1u) * 4u), 255u);
}

fn decWater_u0028_() {
    let _e197 = atomicAdd((&unnamed_2.waterVoxelCount), 4294967295u);
    return;
}

fn getOrthoDir_u0028_i1_u003b(d_5: ptr<function, i32>) -> vec3<i32> {
    let _e197 = (*d_5);
    if (_e197 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e199 = (*d_5);
    if (_e199 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e201 = (*d_5);
    if (_e201 == 2i) {
        return vec3<i32>(0i, 1i, 0i);
    }
    let _e203 = (*d_5);
    if (_e203 == 3i) {
        return vec3<i32>(0i, -1i, 0i);
    }
    let _e205 = (*d_5);
    if (_e205 == 4i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    return vec3<i32>(0i, 0i, -1i);
}

fn lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b(pos_7: ptr<function, vec3<i32>>, coolness_1: ptr<function, u32>, randVal_5: ptr<function, f32>) {
    var startDir: i32;
    var i_7: i32;
    var d_6: i32;
    var nPos: vec3<i32>;
    var param_260: i32;
    var nIndex: u32;
    var param_261: vec3<i32>;
    var nVal: u32;
    var param_262: u32;
    var nType: u32;
    var param_263: u32;
    var param_264: u32;
    var param_265: u32;
    var param_266: u32;
    var param_267: u32;
    var param_268: u32;
    var param_269: u32;
    var param_270: u32;
    var param_271: u32;
    var param_272: u32;
    var param_273: u32;
    var param_274: u32;
    var param_275: u32;
    var moisture_1: u32;
    var param_276: u32;
    var flora_2: u32;
    var param_277: u32;
    var abovePos: vec3<i32>;
    var param_278: vec3<i32>;
    var param_279: u32;
    var param_280: u32;
    var param_281: vec3<i32>;
    var param_282: u32;
    var param_283: u32;
    var param_284: u32;
    var param_285: u32;
    var param_286: u32;
    var param_287: u32;
    var param_288: u32;
    var param_289: u32;
    var param_290: u32;
    var nCool: u32;
    var param_291: u32;
    var raised: u32;
    var raisedType: u32;
    var local_10: u32;
    var param_292: u32;
    var param_293: u32;
    var param_294: u32;
    var param_295: u32;
    var param_296: u32;
    var param_297: u32;
    var nCool_1: u32;
    var param_298: u32;
    var draws: bool;
    var lowered: u32;
    var local_11: u32;
    var melts: bool;
    var newType_1: u32;
    var local_12: u32;
    var param_299: u32;
    var param_300: u32;
    var param_301: u32;
    var param_302: u32;
    var param_303: u32;
    var phi_5322_: bool;
    var phi_5329_: bool;
    var phi_5340_: bool;
    var phi_5347_: bool;
    var phi_5358_: bool;
    var phi_5497_: bool;
    var phi_5508_: bool;

    let _e264 = (*randVal_5);
    startDir = i32((fract((_e264 * 17f)) * 6f));
    i_7 = 0i;
    loop {
        let _e269 = i_7;
        if (_e269 < 6i) {
            let _e271 = startDir;
            let _e272 = i_7;
            let _e273 = (_e271 + _e272);
            d_6 = (_e273 - (i32(floor((f32(_e273) / f32(6i)))) * 6i));
            let _e281 = (*pos_7);
            let _e282 = d_6;
            param_260 = _e282;
            let _e283 = getOrthoDir_u0028_i1_u003b((&param_260));
            nPos = (_e281 + _e283);
            let _e286 = nPos[0u];
            let _e287 = (_e286 <= 0i);
            phi_5322_ = _e287;
            if !(_e287) {
                let _e290 = nPos[0u];
                let _e292 = tuning.gridWidth;
                phi_5322_ = (_e290 >= (bitcast<i32>(_e292) - 1i));
            }
            let _e297 = phi_5322_;
            phi_5329_ = _e297;
            if !(_e297) {
                let _e300 = nPos[1u];
                phi_5329_ = (_e300 <= 0i);
            }
            let _e303 = phi_5329_;
            phi_5340_ = _e303;
            if !(_e303) {
                let _e306 = nPos[1u];
                let _e308 = tuning.gridHeight;
                phi_5340_ = (_e306 >= (bitcast<i32>(_e308) - 1i));
            }
            let _e313 = phi_5340_;
            phi_5347_ = _e313;
            if !(_e313) {
                let _e316 = nPos[2u];
                phi_5347_ = (_e316 <= 0i);
            }
            let _e319 = phi_5347_;
            phi_5358_ = _e319;
            if !(_e319) {
                let _e322 = nPos[2u];
                let _e324 = tuning.gridDepth;
                phi_5358_ = (_e322 >= (bitcast<i32>(_e324) - 1i));
            }
            let _e329 = phi_5358_;
            if _e329 {
                continue;
            }
            let _e330 = nPos;
            param_261 = _e330;
            let _e331 = getIndex_u0028_vi3_u003b((&param_261));
            nIndex = _e331;
            let _e332 = nIndex;
            param_262 = _e332;
            let _e333 = readCell_u0028_u1_u003b((&param_262));
            nVal = _e333;
            let _e334 = nVal;
            param_263 = _e334;
            let _e335 = getType_u0028_u1_u003b((&param_263));
            nType = _e335;
            let _e336 = nType;
            if (_e336 == 2u) {
                let _e338 = nIndex;
                let _e341 = nVal;
                param_264 = 6u;
                param_265 = 0u;
                param_266 = 0u;
                param_267 = 0u;
                let _e342 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_264), (&param_265), (&param_266), (&param_267));
                let _e343 = atomicCompareExchangeWeak((&unnamed.grid[_e338]), _e341, _e342);
                let _e345 = nVal;
                if (_e343.old_value == _e345) {
                    decWater_u0028_();
                    let _e347 = (*coolness_1);
                    let _e349 = tuning.lavaWaterCool;
                    (*coolness_1) = min((_e347 + _e349), 255u);
                    return;
                }
            } else {
                let _e352 = nType;
                if (_e352 == 19u) {
                    let _e354 = nIndex;
                    let _e357 = nVal;
                    let _e358 = atomicCompareExchangeWeak((&unnamed.grid[_e354]), _e357, 0u);
                    let _e360 = nVal;
                    if (_e358.old_value == _e360) {
                        return;
                    }
                } else {
                    let _e362 = nType;
                    if (_e362 == 18u) {
                        let _e364 = nIndex;
                        let _e367 = nVal;
                        param_268 = 5u;
                        param_269 = 0u;
                        param_270 = 0u;
                        param_271 = 0u;
                        let _e368 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_268), (&param_269), (&param_270), (&param_271));
                        let _e369 = atomicCompareExchangeWeak((&unnamed.grid[_e364]), _e367, _e368);
                        let _e371 = nVal;
                        if (_e369.old_value == _e371) {
                            return;
                        }
                    } else {
                        let _e373 = nType;
                        if (_e373 == 3u) {
                            let _e375 = nIndex;
                            let _e378 = nVal;
                            param_272 = 12u;
                            param_273 = 0u;
                            param_274 = 0u;
                            param_275 = 255u;
                            let _e379 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_272), (&param_273), (&param_274), (&param_275));
                            let _e380 = atomicCompareExchangeWeak((&unnamed.grid[_e375]), _e378, _e379);
                            let _e382 = nVal;
                            if (_e380.old_value == _e382) {
                                return;
                            }
                        } else {
                            let _e384 = nType;
                            let _e386 = nType;
                            if ((_e384 == 1u) || (_e386 == 4u)) {
                                let _e389 = nVal;
                                param_276 = _e389;
                                let _e390 = getAge_u0028_u1_u003b((&param_276));
                                moisture_1 = _e390;
                                let _e391 = nVal;
                                param_277 = _e391;
                                let _e392 = getDir_u0028_u1_u003b((&param_277));
                                flora_2 = _e392;
                                let _e393 = nType;
                                let _e395 = flora_2;
                                let _e398 = flora_2;
                                if (((_e393 == 4u) && (_e395 > 10u)) && (_e398 <= 100u)) {
                                    let _e401 = nPos;
                                    abovePos = (_e401 + vec3<i32>(0i, 1i, 0i));
                                    let _e404 = abovePos[1u];
                                    let _e406 = tuning.gridHeight;
                                    let _e409 = (_e404 < (bitcast<i32>(_e406) - 1i));
                                    phi_5497_ = _e409;
                                    if _e409 {
                                        let _e410 = abovePos;
                                        param_278 = _e410;
                                        let _e411 = getIndex_u0028_vi3_u003b((&param_278));
                                        param_279 = _e411;
                                        let _e412 = readCell_u0028_u1_u003b((&param_279));
                                        param_280 = _e412;
                                        let _e413 = getType_u0028_u1_u003b((&param_280));
                                        phi_5497_ = (_e413 == 0u);
                                    }
                                    let _e416 = phi_5497_;
                                    phi_5508_ = _e416;
                                    if _e416 {
                                        let _e417 = (*randVal_5);
                                        let _e421 = tuning.lavaIgniteChance;
                                        phi_5508_ = (fract((_e417 * 41f)) < _e421);
                                    }
                                    let _e424 = phi_5508_;
                                    if _e424 {
                                        let _e425 = abovePos;
                                        param_281 = _e425;
                                        let _e426 = getIndex_u0028_vi3_u003b((&param_281));
                                        param_282 = 5u;
                                        param_283 = 0u;
                                        param_284 = 0u;
                                        param_285 = 0u;
                                        let _e429 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_282), (&param_283), (&param_284), (&param_285));
                                        let _e430 = atomicCompareExchangeWeak((&unnamed.grid[_e426]), 0u, _e429);
                                        if (_e430.old_value == 0u) {
                                            return;
                                        }
                                    }
                                } else {
                                    let _e433 = moisture_1;
                                    if (_e433 > 0u) {
                                        let _e435 = nIndex;
                                        let _e438 = nVal;
                                        let _e439 = moisture_1;
                                        let _e441 = nType;
                                        param_286 = _e441;
                                        let _e442 = flora_2;
                                        param_287 = _e442;
                                        param_288 = 0u;
                                        param_289 = (_e439 - 1u);
                                        let _e443 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_286), (&param_287), (&param_288), (&param_289));
                                        let _e444 = atomicCompareExchangeWeak((&unnamed.grid[_e435]), _e438, _e443);
                                        let _e446 = nVal;
                                        if (_e444.old_value == _e446) {
                                            let _e448 = (*coolness_1);
                                            let _e450 = tuning.lavaMoistureCool;
                                            (*coolness_1) = min((_e448 + _e450), 255u);
                                            return;
                                        }
                                    } else {
                                        let _e453 = (*randVal_5);
                                        let _e457 = tuning.lavaConsumeChance;
                                        if (fract((_e453 * 53f)) < _e457) {
                                            let _e459 = nIndex;
                                            let _e462 = nVal;
                                            let _e463 = atomicCompareExchangeWeak((&unnamed.grid[_e459]), _e462, 0u);
                                            let _e465 = nVal;
                                            if (_e463.old_value == _e465) {
                                                return;
                                            }
                                        }
                                    }
                                }
                            } else {
                                let _e467 = nType;
                                param_290 = _e467;
                                let _e468 = isLava_u0028_u1_u003b((&param_290));
                                if _e468 {
                                    let _e469 = nVal;
                                    param_291 = _e469;
                                    let _e470 = getAge_u0028_u1_u003b((&param_291));
                                    nCool = _e470;
                                    let _e471 = (*coolness_1);
                                    let _e472 = nCool;
                                    if (_e471 > (_e472 + 1u)) {
                                        let _e475 = nCool;
                                        raised = (_e475 + 1u);
                                        let _e477 = raised;
                                        let _e478 = lavaSolidifyCoolness_u0028_();
                                        if (_e477 >= _e478) {
                                            local_10 = 12u;
                                        } else {
                                            let _e480 = raised;
                                            param_292 = _e480;
                                            let _e481 = lavaTypeFor_u0028_u1_u003b((&param_292));
                                            local_10 = _e481;
                                        }
                                        let _e482 = local_10;
                                        raisedType = _e482;
                                        let _e483 = nIndex;
                                        let _e486 = nVal;
                                        let _e487 = nVal;
                                        param_293 = _e487;
                                        let _e488 = getDir_u0028_u1_u003b((&param_293));
                                        let _e489 = raisedType;
                                        param_294 = _e489;
                                        param_295 = _e488;
                                        param_296 = 0u;
                                        let _e490 = raised;
                                        param_297 = _e490;
                                        let _e491 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_294), (&param_295), (&param_296), (&param_297));
                                        let _e492 = atomicCompareExchangeWeak((&unnamed.grid[_e483]), _e486, _e491);
                                        let _e494 = nVal;
                                        if (_e492.old_value == _e494) {
                                            let _e496 = (*coolness_1);
                                            (*coolness_1) = (_e496 - 1u);
                                            return;
                                        }
                                    }
                                } else {
                                    let _e498 = nType;
                                    if (_e498 == 12u) {
                                        let _e500 = nVal;
                                        param_298 = _e500;
                                        let _e501 = getAge_u0028_u1_u003b((&param_298));
                                        nCool_1 = _e501;
                                        let _e502 = nCool_1;
                                        let _e503 = (*coolness_1);
                                        draws = (_e502 > (_e503 + 1u));
                                        let _e506 = draws;
                                        if _e506 {
                                            let _e507 = nCool_1;
                                            local_11 = (_e507 - 1u);
                                        } else {
                                            let _e509 = nCool_1;
                                            local_11 = _e509;
                                        }
                                        let _e510 = local_11;
                                        lowered = _e510;
                                        let _e511 = lowered;
                                        let _e512 = lavaSolidifyCoolness_u0028_();
                                        melts = (_e511 < _e512);
                                        let _e514 = draws;
                                        let _e515 = melts;
                                        if (_e514 || _e515) {
                                            let _e517 = melts;
                                            if _e517 {
                                                let _e518 = lowered;
                                                param_299 = _e518;
                                                let _e519 = lavaTypeFor_u0028_u1_u003b((&param_299));
                                                local_12 = _e519;
                                            } else {
                                                local_12 = 12u;
                                            }
                                            let _e520 = local_12;
                                            newType_1 = _e520;
                                            let _e521 = nIndex;
                                            let _e524 = nVal;
                                            let _e525 = newType_1;
                                            param_300 = _e525;
                                            param_301 = 0u;
                                            param_302 = 0u;
                                            let _e526 = lowered;
                                            param_303 = _e526;
                                            let _e527 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_300), (&param_301), (&param_302), (&param_303));
                                            let _e528 = atomicCompareExchangeWeak((&unnamed.grid[_e521]), _e524, _e527);
                                            let _e530 = nVal;
                                            if (_e528.old_value == _e530) {
                                                let _e532 = draws;
                                                if _e532 {
                                                    let _e533 = (*coolness_1);
                                                    (*coolness_1) = min((_e533 + 1u), 255u);
                                                }
                                                return;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e536 = i_7;
            i_7 = (_e536 + 1i);
        }
    }
    return;
}

fn updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_8: ptr<function, vec3<i32>>, currentIndex_5: ptr<function, u32>, rawValue_4: ptr<function, u32>, currentDir_2: ptr<function, u32>, currentSleep_1: ptr<function, u32>, currentAge_4: ptr<function, u32>, randVal_6: ptr<function, f32>) {
    var coolness_2: u32;
    var param_304: vec3<i32>;
    var param_305: u32;
    var param_306: f32;
    var param_307: u32;
    var param_308: u32;
    var param_309: u32;
    var param_310: u32;
    var newType_2: u32;
    var param_311: u32;
    var belowPos_3: vec3<i32>;
    var param_312: vec3<i32>;
    var param_313: u32;
    var param_314: u32;
    var param_315: vec3<i32>;
    var param_316: u32;
    var param_317: u32;
    var param_318: u32;
    var param_319: u32;
    var param_320: u32;
    var param_321: u32;
    var param_322: u32;
    var param_323: u32;
    var slideDir: i32;
    var slide: array<vec3<i32>, 2>;
    var s: i32;
    var sPos: vec3<i32>;
    var param_324: vec3<i32>;
    var param_325: u32;
    var param_326: u32;
    var param_327: vec3<i32>;
    var param_328: u32;
    var param_329: u32;
    var param_330: u32;
    var param_331: u32;
    var param_332: u32;
    var param_333: u32;
    var param_334: u32;
    var param_335: u32;
    var blockedMask: u32;
    var searchStart: i32;
    var reach: i32;
    var r: i32;
    var i_8: i32;
    var d_7: i32;
    var c_6: vec3<i32>;
    var param_336: i32;
    var param_337: vec3<i32>;
    var param_338: u32;
    var param_339: u32;
    var param_340: vec3<i32>;
    var param_341: u32;
    var param_342: u32;
    var param_343: vec3<i32>;
    var param_344: u32;
    var param_345: u32;
    var param_346: u32;
    var param_347: u32;
    var param_348: u32;
    var param_349: u32;
    var param_350: u32;
    var param_351: u32;
    var hasPressure: bool;
    var local_13: bool;
    var param_352: vec3<i32>;
    var param_353: u32;
    var param_354: u32;
    var stackedOnLava: bool;
    var local_14: bool;
    var param_355: vec3<i32>;
    var param_356: u32;
    var param_357: u32;
    var param_358: u32;
    var spreadStart: i32;
    var i_9: i32;
    var d_8: i32;
    var targetPos: vec3<i32>;
    var param_359: i32;
    var param_360: vec3<i32>;
    var param_361: u32;
    var param_362: u32;
    var param_363: vec3<i32>;
    var param_364: u32;
    var param_365: u32;
    var param_366: u32;
    var param_367: u32;
    var param_368: u32;
    var param_369: u32;
    var param_370: u32;
    var param_371: u32;
    var newSleep: u32;
    var param_372: u32;
    var param_373: u32;
    var param_374: u32;
    var param_375: u32;
    var phi_5716_: bool;
    var phi_5854_: bool;
    var phi_5860_: bool;
    var phi_5870_: bool;
    var phi_5982_: bool;
    var phi_5989_: bool;
    var phi_6000_: bool;
    var phi_6012_: bool;
    var phi_6034_: bool;
    var phi_6148_: bool;
    var phi_6154_: bool;
    var phi_6164_: bool;

    let _e298 = (*currentAge_4);
    coolness_2 = _e298;
    let _e299 = (*pos_8);
    param_304 = _e299;
    let _e300 = coolness_2;
    param_305 = _e300;
    let _e301 = (*randVal_6);
    param_306 = _e301;
    lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b((&param_304), (&param_305), (&param_306));
    let _e302 = param_305;
    coolness_2 = _e302;
    let _e303 = (*currentSleep_1);
    let _e305 = tuning.wakeSleepThreshold;
    let _e306 = (_e303 > _e305);
    phi_5716_ = _e306;
    if _e306 {
        let _e307 = (*randVal_6);
        let _e311 = tuning.lavaRestCoolChance;
        phi_5716_ = (fract((_e307 * 71f)) < _e311);
    }
    let _e314 = phi_5716_;
    if _e314 {
        let _e315 = coolness_2;
        coolness_2 = min((_e315 + 1u), 255u);
    }
    let _e318 = coolness_2;
    let _e319 = lavaSolidifyCoolness_u0028_();
    if (_e318 >= _e319) {
        let _e321 = (*currentIndex_5);
        let _e324 = (*rawValue_4);
        param_307 = 12u;
        param_308 = 0u;
        param_309 = 0u;
        let _e325 = coolness_2;
        param_310 = _e325;
        let _e326 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_307), (&param_308), (&param_309), (&param_310));
        let _e327 = atomicCompareExchangeWeak((&unnamed.grid[_e321]), _e324, _e326);
        return;
    }
    let _e329 = coolness_2;
    param_311 = _e329;
    let _e330 = lavaTypeFor_u0028_u1_u003b((&param_311));
    newType_2 = _e330;
    let _e331 = (*randVal_6);
    let _e335 = tuning.lavaViscosity;
    if (fract((_e331 * 89f)) < _e335) {
        let _e338 = (*pos_8)[1u];
        if (_e338 > 1i) {
            let _e340 = (*pos_8);
            belowPos_3 = (_e340 + vec3<i32>(0i, -1i, 0i));
            let _e342 = belowPos_3;
            param_312 = _e342;
            let _e343 = getIndex_u0028_vi3_u003b((&param_312));
            param_313 = _e343;
            let _e344 = readCell_u0028_u1_u003b((&param_313));
            param_314 = _e344;
            let _e345 = getType_u0028_u1_u003b((&param_314));
            if (_e345 == 0u) {
                let _e347 = belowPos_3;
                param_315 = _e347;
                let _e348 = getIndex_u0028_vi3_u003b((&param_315));
                let _e349 = newType_2;
                param_316 = _e349;
                let _e350 = (*currentDir_2);
                param_317 = _e350;
                param_318 = 0u;
                let _e351 = coolness_2;
                param_319 = _e351;
                let _e352 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_316), (&param_317), (&param_318), (&param_319));
                let _e353 = (*currentIndex_5);
                param_320 = _e353;
                let _e354 = (*rawValue_4);
                param_321 = _e354;
                param_322 = _e348;
                param_323 = _e352;
                let _e355 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_320), (&param_321), (&param_322), (&param_323));
                if _e355 {
                    return;
                }
            }
        }
        let _e357 = (*pos_8)[1u];
        if (_e357 > 1i) {
            let _e359 = (*randVal_6);
            slideDir = select(-1i, 1i, (fract((_e359 * 10f)) > 0.5f));
            let _e364 = (*randVal_6);
            if (fract((_e364 * 100f)) > 0.5f) {
                let _e368 = (*pos_8);
                let _e369 = slideDir;
                slide[0i] = (_e368 + vec3<i32>(_e369, -1i, 0i));
                let _e373 = (*pos_8);
                let _e374 = slideDir;
                slide[1i] = (_e373 + vec3<i32>(0i, -1i, _e374));
            } else {
                let _e378 = (*pos_8);
                let _e379 = slideDir;
                slide[0i] = (_e378 + vec3<i32>(0i, -1i, _e379));
                let _e383 = (*pos_8);
                let _e384 = slideDir;
                slide[1i] = (_e383 + vec3<i32>(_e384, -1i, 0i));
            }
            s = 0i;
            loop {
                let _e388 = s;
                if (_e388 < 2i) {
                    let _e390 = s;
                    let _e392 = slide[_e390];
                    sPos = _e392;
                    let _e394 = sPos[0u];
                    let _e395 = (_e394 > 0i);
                    phi_5854_ = _e395;
                    if _e395 {
                        let _e397 = sPos[0u];
                        let _e399 = tuning.gridWidth;
                        phi_5854_ = (_e397 < (bitcast<i32>(_e399) - 1i));
                    }
                    let _e404 = phi_5854_;
                    phi_5860_ = _e404;
                    if _e404 {
                        let _e406 = sPos[2u];
                        phi_5860_ = (_e406 > 0i);
                    }
                    let _e409 = phi_5860_;
                    phi_5870_ = _e409;
                    if _e409 {
                        let _e411 = sPos[2u];
                        let _e413 = tuning.gridDepth;
                        phi_5870_ = (_e411 < (bitcast<i32>(_e413) - 1i));
                    }
                    let _e418 = phi_5870_;
                    if _e418 {
                        let _e419 = sPos;
                        param_324 = _e419;
                        let _e420 = getIndex_u0028_vi3_u003b((&param_324));
                        param_325 = _e420;
                        let _e421 = readCell_u0028_u1_u003b((&param_325));
                        param_326 = _e421;
                        let _e422 = getType_u0028_u1_u003b((&param_326));
                        if (_e422 == 0u) {
                            let _e424 = sPos;
                            param_327 = _e424;
                            let _e425 = getIndex_u0028_vi3_u003b((&param_327));
                            let _e426 = newType_2;
                            param_328 = _e426;
                            let _e427 = (*currentDir_2);
                            param_329 = _e427;
                            param_330 = 0u;
                            let _e428 = coolness_2;
                            param_331 = _e428;
                            let _e429 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_328), (&param_329), (&param_330), (&param_331));
                            let _e430 = (*currentIndex_5);
                            param_332 = _e430;
                            let _e431 = (*rawValue_4);
                            param_333 = _e431;
                            param_334 = _e425;
                            param_335 = _e429;
                            let _e432 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_332), (&param_333), (&param_334), (&param_335));
                            if _e432 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e433 = s;
                    s = (_e433 + 1i);
                }
            }
        }
        let _e435 = (*currentSleep_1);
        let _e437 = tuning.wakeSleepThreshold;
        if (_e435 <= _e437) {
            blockedMask = 0u;
            let _e439 = (*randVal_6);
            searchStart = i32((fract((_e439 * 8f)) * 8f));
            let _e445 = tuning.lavaSpreadRadius;
            reach = bitcast<i32>(max(_e445, 1u));
            r = 1i;
            loop {
                let _e448 = r;
                let _e449 = reach;
                if (_e448 <= _e449) {
                    let _e451 = blockedMask;
                    if (_e451 == 255u) {
                        break;
                    }
                    i_8 = 0i;
                    loop {
                        let _e453 = i_8;
                        if (_e453 < 8i) {
                            let _e455 = searchStart;
                            let _e456 = i_8;
                            let _e457 = (_e455 + _e456);
                            d_7 = (_e457 - (i32(floor((f32(_e457) / f32(8i)))) * 8i));
                            let _e465 = blockedMask;
                            let _e466 = d_7;
                            if ((_e465 & (1u << bitcast<u32>(_e466))) != 0u) {
                                continue;
                            }
                            let _e471 = (*pos_8);
                            let _e472 = d_7;
                            param_336 = _e472;
                            let _e473 = getHDir_u0028_i1_u003b((&param_336));
                            let _e474 = r;
                            c_6 = (_e471 + (_e473 * vec3(_e474)));
                            let _e479 = c_6[0u];
                            let _e480 = (_e479 <= 0i);
                            phi_5982_ = _e480;
                            if !(_e480) {
                                let _e483 = c_6[0u];
                                let _e485 = tuning.gridWidth;
                                phi_5982_ = (_e483 >= (bitcast<i32>(_e485) - 1i));
                            }
                            let _e490 = phi_5982_;
                            phi_5989_ = _e490;
                            if !(_e490) {
                                let _e493 = c_6[2u];
                                phi_5989_ = (_e493 <= 0i);
                            }
                            let _e496 = phi_5989_;
                            phi_6000_ = _e496;
                            if !(_e496) {
                                let _e499 = c_6[2u];
                                let _e501 = tuning.gridDepth;
                                phi_6000_ = (_e499 >= (bitcast<i32>(_e501) - 1i));
                            }
                            let _e506 = phi_6000_;
                            phi_6012_ = _e506;
                            if !(_e506) {
                                let _e508 = c_6;
                                param_337 = _e508;
                                let _e509 = getIndex_u0028_vi3_u003b((&param_337));
                                param_338 = _e509;
                                let _e510 = readCell_u0028_u1_u003b((&param_338));
                                param_339 = _e510;
                                let _e511 = getType_u0028_u1_u003b((&param_339));
                                phi_6012_ = (_e511 != 0u);
                            }
                            let _e514 = phi_6012_;
                            if _e514 {
                                let _e515 = d_7;
                                let _e518 = blockedMask;
                                blockedMask = (_e518 | (1u << bitcast<u32>(_e515)));
                            } else {
                                let _e521 = c_6[1u];
                                let _e522 = (_e521 > 1i);
                                phi_6034_ = _e522;
                                if _e522 {
                                    let _e523 = c_6;
                                    param_340 = (_e523 + vec3<i32>(0i, -1i, 0i));
                                    let _e525 = getIndex_u0028_vi3_u003b((&param_340));
                                    param_341 = _e525;
                                    let _e526 = readCell_u0028_u1_u003b((&param_341));
                                    param_342 = _e526;
                                    let _e527 = getType_u0028_u1_u003b((&param_342));
                                    phi_6034_ = (_e527 == 0u);
                                }
                                let _e530 = phi_6034_;
                                if _e530 {
                                    let _e531 = c_6;
                                    param_343 = _e531;
                                    let _e532 = getIndex_u0028_vi3_u003b((&param_343));
                                    let _e533 = newType_2;
                                    param_344 = _e533;
                                    param_345 = 0u;
                                    param_346 = 0u;
                                    let _e534 = coolness_2;
                                    param_347 = _e534;
                                    let _e535 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_344), (&param_345), (&param_346), (&param_347));
                                    let _e536 = (*currentIndex_5);
                                    param_348 = _e536;
                                    let _e537 = (*rawValue_4);
                                    param_349 = _e537;
                                    param_350 = _e532;
                                    param_351 = _e535;
                                    let _e538 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_348), (&param_349), (&param_350), (&param_351));
                                    if _e538 {
                                        return;
                                    }
                                    let _e539 = d_7;
                                    let _e542 = blockedMask;
                                    blockedMask = (_e542 | (1u << bitcast<u32>(_e539)));
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e544 = i_8;
                            i_8 = (_e544 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e546 = r;
                    r = (_e546 + 1i);
                }
            }
            let _e549 = (*pos_8)[1u];
            let _e551 = tuning.gridHeight;
            if (_e549 < (bitcast<i32>(_e551) - 2i)) {
                let _e555 = (*pos_8);
                param_352 = (_e555 + vec3<i32>(0i, 1i, 0i));
                let _e557 = getIndex_u0028_vi3_u003b((&param_352));
                param_353 = _e557;
                let _e558 = readCell_u0028_u1_u003b((&param_353));
                param_354 = _e558;
                let _e559 = getType_u0028_u1_u003b((&param_354));
                local_13 = (_e559 != 0u);
            } else {
                local_13 = false;
            }
            let _e561 = local_13;
            hasPressure = _e561;
            let _e563 = (*pos_8)[1u];
            if (_e563 > 1i) {
                let _e565 = (*pos_8);
                param_355 = (_e565 + vec3<i32>(0i, -1i, 0i));
                let _e567 = getIndex_u0028_vi3_u003b((&param_355));
                param_356 = _e567;
                let _e568 = readCell_u0028_u1_u003b((&param_356));
                param_357 = _e568;
                let _e569 = getType_u0028_u1_u003b((&param_357));
                param_358 = _e569;
                let _e570 = isLava_u0028_u1_u003b((&param_358));
                local_14 = _e570;
            } else {
                local_14 = false;
            }
            let _e571 = local_14;
            stackedOnLava = _e571;
            let _e572 = hasPressure;
            let _e573 = stackedOnLava;
            if (_e572 || _e573) {
                let _e575 = (*randVal_6);
                spreadStart = i32((fract((_e575 * 8f)) * 8f));
                i_9 = 0i;
                loop {
                    let _e580 = i_9;
                    if (_e580 < 8i) {
                        let _e582 = spreadStart;
                        let _e583 = i_9;
                        let _e584 = (_e582 + _e583);
                        d_8 = (_e584 - (i32(floor((f32(_e584) / f32(8i)))) * 8i));
                        let _e592 = (*pos_8);
                        let _e593 = d_8;
                        param_359 = _e593;
                        let _e594 = getHDir_u0028_i1_u003b((&param_359));
                        targetPos = (_e592 + _e594);
                        let _e597 = targetPos[0u];
                        let _e598 = (_e597 > 0i);
                        phi_6148_ = _e598;
                        if _e598 {
                            let _e600 = targetPos[0u];
                            let _e602 = tuning.gridWidth;
                            phi_6148_ = (_e600 < (bitcast<i32>(_e602) - 1i));
                        }
                        let _e607 = phi_6148_;
                        phi_6154_ = _e607;
                        if _e607 {
                            let _e609 = targetPos[2u];
                            phi_6154_ = (_e609 > 0i);
                        }
                        let _e612 = phi_6154_;
                        phi_6164_ = _e612;
                        if _e612 {
                            let _e614 = targetPos[2u];
                            let _e616 = tuning.gridDepth;
                            phi_6164_ = (_e614 < (bitcast<i32>(_e616) - 1i));
                        }
                        let _e621 = phi_6164_;
                        if _e621 {
                            let _e622 = targetPos;
                            param_360 = _e622;
                            let _e623 = getIndex_u0028_vi3_u003b((&param_360));
                            param_361 = _e623;
                            let _e624 = readCell_u0028_u1_u003b((&param_361));
                            param_362 = _e624;
                            let _e625 = getType_u0028_u1_u003b((&param_362));
                            if (_e625 == 0u) {
                                let _e627 = targetPos;
                                param_363 = _e627;
                                let _e628 = getIndex_u0028_vi3_u003b((&param_363));
                                let _e629 = d_8;
                                let _e632 = newType_2;
                                param_364 = _e632;
                                param_365 = bitcast<u32>((_e629 + 1i));
                                param_366 = 0u;
                                let _e633 = coolness_2;
                                param_367 = _e633;
                                let _e634 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_364), (&param_365), (&param_366), (&param_367));
                                let _e635 = (*currentIndex_5);
                                param_368 = _e635;
                                let _e636 = (*rawValue_4);
                                param_369 = _e636;
                                param_370 = _e628;
                                param_371 = _e634;
                                let _e637 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_368), (&param_369), (&param_370), (&param_371));
                                if _e637 {
                                    return;
                                }
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e638 = i_9;
                        i_9 = (_e638 + 1i);
                    }
                }
            }
        }
    }
    let _e640 = (*currentSleep_1);
    newSleep = min((_e640 + 1u), 255u);
    let _e643 = (*currentIndex_5);
    let _e646 = (*rawValue_4);
    let _e647 = newType_2;
    param_372 = _e647;
    let _e648 = (*currentDir_2);
    param_373 = _e648;
    let _e649 = newSleep;
    param_374 = _e649;
    let _e650 = coolness_2;
    param_375 = _e650;
    let _e651 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_372), (&param_373), (&param_374), (&param_375));
    let _e652 = atomicCompareExchangeWeak((&unnamed.grid[_e643]), _e646, _e651);
    return;
}

fn getCloudKind_u0028_u1_u003b(v_2: ptr<function, u32>) -> u32 {
    let _e197 = (*v_2);
    return (_e197 & 3u);
}

fn cloudCellInBounds_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> bool {
    var phi_579_: bool;
    var phi_585_: bool;
    var phi_595_: bool;
    var phi_601_: bool;
    var phi_611_: bool;

    let _e198 = (*p_3)[0u];
    let _e199 = (_e198 >= 1i);
    phi_579_ = _e199;
    if _e199 {
        let _e201 = (*p_3)[0u];
        let _e203 = tuning.gridWidth;
        phi_579_ = (_e201 < (bitcast<i32>(_e203) - 1i));
    }
    let _e208 = phi_579_;
    phi_585_ = _e208;
    if _e208 {
        let _e210 = (*p_3)[1u];
        phi_585_ = (_e210 >= 1i);
    }
    let _e213 = phi_585_;
    phi_595_ = _e213;
    if _e213 {
        let _e215 = (*p_3)[1u];
        let _e217 = tuning.gridHeight;
        phi_595_ = (_e215 < (bitcast<i32>(_e217) - 1i));
    }
    let _e222 = phi_595_;
    phi_601_ = _e222;
    if _e222 {
        let _e224 = (*p_3)[2u];
        phi_601_ = (_e224 >= 1i);
    }
    let _e227 = phi_601_;
    phi_611_ = _e227;
    if _e227 {
        let _e229 = (*p_3)[2u];
        let _e231 = tuning.gridDepth;
        phi_611_ = (_e229 < (bitcast<i32>(_e231) - 1i));
    }
    let _e236 = phi_611_;
    return _e236;
}

fn cloudTouchesRain_u0028_vi3_u003b(pos_9: ptr<function, vec3<i32>>) -> bool {
    var i_10: i32;
    var n_1: vec3<i32>;
    var param_376: i32;
    var param_377: vec3<i32>;
    var param_378: vec3<i32>;
    var param_379: u32;

    i_10 = 0i;
    loop {
        let _e203 = i_10;
        if (_e203 < 6i) {
            let _e205 = (*pos_9);
            let _e206 = i_10;
            param_376 = _e206;
            let _e207 = getOrthoDir_u0028_i1_u003b((&param_376));
            n_1 = (_e205 + _e207);
            let _e209 = n_1;
            param_377 = _e209;
            let _e210 = cloudCellInBounds_u0028_vi3_u003b((&param_377));
            if !(_e210) {
                continue;
            }
            let _e212 = n_1;
            param_378 = _e212;
            let _e213 = getIndex_u0028_vi3_u003b((&param_378));
            let _e216 = atomicLoad((&unnamed_1.cloudCells[_e213]));
            param_379 = _e216;
            let _e217 = getCloudKind_u0028_u1_u003b((&param_379));
            if (_e217 == 2u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e219 = i_10;
            i_10 = (_e219 + 1i);
        }
    }
    return false;
}

fn getCloudMoved_u0028_u1_u003b(v_3: ptr<function, u32>) -> bool {
    let _e197 = (*v_3);
    return ((_e197 & 4u) != 0u);
}

fn cloudIsAtRest_u0028_u1_u003b(v_4: ptr<function, u32>) -> bool {
    var param_380: u32;
    var param_381: u32;
    var phi_677_: bool;

    let _e199 = (*v_4);
    param_380 = _e199;
    let _e200 = getCloudKind_u0028_u1_u003b((&param_380));
    let _e201 = (_e200 != 0u);
    phi_677_ = _e201;
    if _e201 {
        let _e202 = (*v_4);
        param_381 = _e202;
        let _e203 = getCloudMoved_u0028_u1_u003b((&param_381));
        phi_677_ = !(_e203);
    }
    let _e206 = phi_677_;
    return _e206;
}

fn packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b(kind: ptr<function, u32>, moved: ptr<function, bool>, counter: ptr<function, u32>, target_1: ptr<function, u32>) -> u32 {
    let _e200 = (*kind);
    let _e202 = (*moved);
    let _e205 = (*counter);
    let _e210 = (*target_1);
    return ((((_e200 & 3u) | select(0u, 4u, _e202)) | (min(_e205, 2047u) << bitcast<u32>(3i))) | (min(_e210, 2047u) << bitcast<u32>(14i)));
}

fn updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_10: ptr<function, vec3<i32>>, currentIndex_6: ptr<function, u32>, rawValue_5: ptr<function, u32>, currentSleep_2: ptr<function, u32>, currentAge_5: ptr<function, u32>, randVal_7: ptr<function, f32>) {
    var newKind: u32;
    var param_382: u32;
    var param_383: bool;
    var param_384: u32;
    var param_385: u32;
    var newAge: u32;
    var d_9: i32;
    var scatterPos: vec3<i32>;
    var param_386: i32;
    var sType: u32;
    var param_387: vec3<i32>;
    var param_388: u32;
    var param_389: u32;
    var param_390: vec3<i32>;
    var param_391: u32;
    var param_392: vec3<i32>;
    var param_393: u32;
    var param_394: u32;
    var param_395: u32;
    var param_396: u32;
    var param_397: u32;
    var param_398: u32;
    var param_399: u32;
    var param_400: u32;
    var checkPos: array<vec3<i32>, 3>;
    var dir_1: i32;
    var upPos_1: vec3<i32>;
    var underSettled: bool;
    var param_401: vec3<i32>;
    var param_402: vec3<i32>;
    var param_403: u32;
    var touchingRain: bool;
    var param_404: vec3<i32>;
    var newKind_1: u32;
    var param_405: u32;
    var param_406: bool;
    var param_407: u32;
    var param_408: u32;
    var i_11: i32;
    var cPos: vec3<i32>;
    var cIndex: u32;
    var param_409: vec3<i32>;
    var cVal: u32;
    var param_410: u32;
    var cType: u32;
    var param_411: u32;
    var moisture_2: u32;
    var param_412: u32;
    var capacity: u32;
    var local_15: u32;
    var i_12: i32;
    var sPos_1: vec3<i32>;
    var sType_1: u32;
    var param_413: vec3<i32>;
    var param_414: u32;
    var param_415: u32;
    var param_416: vec3<i32>;
    var param_417: u32;
    var param_418: vec3<i32>;
    var param_419: u32;
    var param_420: u32;
    var param_421: u32;
    var param_422: u32;
    var param_423: u32;
    var param_424: u32;
    var param_425: u32;
    var param_426: u32;
    var newSleep_1: u32;
    var param_427: u32;
    var param_428: u32;
    var param_429: u32;
    var param_430: u32;
    var phi_8382_: bool;
    var phi_8388_: bool;
    var phi_8398_: bool;
    var phi_8404_: bool;
    var phi_8414_: bool;
    var phi_8440_: bool;
    var phi_8517_: bool;
    var phi_8535_: bool;
    var phi_8577_: bool;
    var phi_8583_: bool;
    var phi_8593_: bool;
    var phi_8674_: bool;
    var phi_8684_: bool;
    var phi_8690_: bool;
    var phi_8700_: bool;
    var phi_8726_: bool;

    let _e275 = (*pos_10)[1u];
    let _e277 = tuning.gridHeight;
    if (_e275 >= (bitcast<i32>(_e277) - 2i)) {
        let _e282 = unnamed_2.rainPhase;
        newKind = select(1u, 2u, (_e282 == 2u));
        let _e285 = (*currentIndex_6);
        let _e288 = newKind;
        param_382 = _e288;
        param_383 = false;
        param_384 = 0u;
        param_385 = 0u;
        let _e289 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_382), (&param_383), (&param_384), (&param_385));
        let _e290 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e285]), 0u, _e289);
        if (_e290.old_value == 0u) {
            let _e293 = (*currentIndex_6);
            let _e296 = atomicExchange((&unnamed.grid[_e293]), 0u);
            return;
        }
        let _e297 = (*currentIndex_6);
        let _e300 = atomicExchange((&unnamed.grid[_e297]), 0u);
        return;
    }
    let _e301 = (*currentAge_5);
    newAge = min((_e301 + 1u), 255u);
    let _e304 = (*randVal_7);
    let _e308 = tuning.steamScatterChance;
    if (fract((_e304 * 88f)) < _e308) {
        let _e310 = (*randVal_7);
        d_9 = i32((fract((_e310 * 13f)) * 6f));
        let _e315 = (*pos_10);
        let _e316 = d_9;
        param_386 = _e316;
        let _e317 = getOrthoDir_u0028_i1_u003b((&param_386));
        scatterPos = (_e315 + _e317);
        let _e320 = scatterPos[0u];
        let _e321 = (_e320 > 0i);
        phi_8382_ = _e321;
        if _e321 {
            let _e323 = scatterPos[0u];
            let _e325 = tuning.gridWidth;
            phi_8382_ = (_e323 < (bitcast<i32>(_e325) - 1i));
        }
        let _e330 = phi_8382_;
        phi_8388_ = _e330;
        if _e330 {
            let _e332 = scatterPos[1u];
            phi_8388_ = (_e332 > 0i);
        }
        let _e335 = phi_8388_;
        phi_8398_ = _e335;
        if _e335 {
            let _e337 = scatterPos[1u];
            let _e339 = tuning.gridHeight;
            phi_8398_ = (_e337 < (bitcast<i32>(_e339) - 1i));
        }
        let _e344 = phi_8398_;
        phi_8404_ = _e344;
        if _e344 {
            let _e346 = scatterPos[2u];
            phi_8404_ = (_e346 > 0i);
        }
        let _e349 = phi_8404_;
        phi_8414_ = _e349;
        if _e349 {
            let _e351 = scatterPos[2u];
            let _e353 = tuning.gridDepth;
            phi_8414_ = (_e351 < (bitcast<i32>(_e353) - 1i));
        }
        let _e358 = phi_8414_;
        if _e358 {
            let _e359 = scatterPos;
            param_387 = _e359;
            let _e360 = getIndex_u0028_vi3_u003b((&param_387));
            param_388 = _e360;
            let _e361 = readCell_u0028_u1_u003b((&param_388));
            param_389 = _e361;
            let _e362 = getType_u0028_u1_u003b((&param_389));
            sType = _e362;
            let _e363 = sType;
            let _e365 = sType;
            let _e367 = ((_e363 == 0u) || (_e365 == 5u));
            phi_8440_ = _e367;
            if _e367 {
                let _e368 = scatterPos;
                param_390 = _e368;
                let _e369 = getIndex_u0028_vi3_u003b((&param_390));
                let _e372 = atomicLoad((&unnamed_1.cloudCells[_e369]));
                param_391 = _e372;
                let _e373 = getCloudKind_u0028_u1_u003b((&param_391));
                phi_8440_ = (_e373 == 0u);
            }
            let _e376 = phi_8440_;
            if _e376 {
                let _e377 = scatterPos;
                param_392 = _e377;
                let _e378 = getIndex_u0028_vi3_u003b((&param_392));
                param_393 = 6u;
                param_394 = 0u;
                param_395 = 0u;
                let _e379 = newAge;
                param_396 = _e379;
                let _e380 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_393), (&param_394), (&param_395), (&param_396));
                let _e381 = (*currentIndex_6);
                param_397 = _e381;
                let _e382 = (*rawValue_5);
                param_398 = _e382;
                param_399 = _e378;
                param_400 = _e380;
                let _e383 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_397), (&param_398), (&param_399), (&param_400));
                if _e383 {
                    return;
                }
            }
        }
    }
    let _e384 = (*pos_10);
    checkPos[0i] = (_e384 + vec3<i32>(0i, 1i, 0i));
    let _e387 = (*randVal_7);
    dir_1 = select(-1i, 1i, (fract((_e387 * 10f)) > 0.5f));
    let _e392 = (*randVal_7);
    if (fract((_e392 * 100f)) > 0.5f) {
        let _e396 = (*pos_10);
        let _e397 = dir_1;
        checkPos[1i] = (_e396 + vec3<i32>(_e397, 1i, 0i));
        let _e401 = (*pos_10);
        let _e402 = dir_1;
        checkPos[2i] = (_e401 + vec3<i32>(0i, 1i, _e402));
    } else {
        let _e406 = (*pos_10);
        let _e407 = dir_1;
        checkPos[1i] = (_e406 + vec3<i32>(0i, 1i, _e407));
        let _e411 = (*pos_10);
        let _e412 = dir_1;
        checkPos[2i] = (_e411 + vec3<i32>(_e412, 1i, 0i));
    }
    let _e416 = (*pos_10);
    upPos_1 = (_e416 + vec3<i32>(0i, 1i, 0i));
    let _e418 = upPos_1;
    param_401 = _e418;
    let _e419 = cloudCellInBounds_u0028_vi3_u003b((&param_401));
    phi_8517_ = _e419;
    if _e419 {
        let _e420 = upPos_1;
        param_402 = _e420;
        let _e421 = getIndex_u0028_vi3_u003b((&param_402));
        let _e424 = atomicLoad((&unnamed_1.cloudCells[_e421]));
        param_403 = _e424;
        let _e425 = cloudIsAtRest_u0028_u1_u003b((&param_403));
        phi_8517_ = _e425;
    }
    let _e427 = phi_8517_;
    underSettled = _e427;
    let _e428 = (*pos_10);
    param_404 = _e428;
    let _e429 = cloudTouchesRain_u0028_vi3_u003b((&param_404));
    touchingRain = _e429;
    let _e430 = underSettled;
    let _e431 = touchingRain;
    if (_e430 || _e431) {
        let _e433 = touchingRain;
        phi_8535_ = _e433;
        if !(_e433) {
            let _e436 = unnamed_2.rainPhase;
            phi_8535_ = (_e436 == 2u);
        }
        let _e439 = phi_8535_;
        newKind_1 = select(1u, 2u, _e439);
        let _e441 = (*currentIndex_6);
        let _e444 = newKind_1;
        param_405 = _e444;
        param_406 = false;
        param_407 = 0u;
        param_408 = 0u;
        let _e445 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_405), (&param_406), (&param_407), (&param_408));
        let _e446 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e441]), 0u, _e445);
        if (_e446.old_value == 0u) {
            let _e449 = (*currentIndex_6);
            let _e452 = atomicExchange((&unnamed.grid[_e449]), 0u);
        }
        return;
    }
    i_11 = 0i;
    loop {
        let _e453 = i_11;
        if (_e453 < 3i) {
            let _e455 = i_11;
            let _e457 = checkPos[_e455];
            cPos = _e457;
            let _e459 = cPos[0u];
            let _e460 = (_e459 > 0i);
            phi_8577_ = _e460;
            if _e460 {
                let _e462 = cPos[0u];
                let _e464 = tuning.gridWidth;
                phi_8577_ = (_e462 < (bitcast<i32>(_e464) - 1i));
            }
            let _e469 = phi_8577_;
            phi_8583_ = _e469;
            if _e469 {
                let _e471 = cPos[2u];
                phi_8583_ = (_e471 > 0i);
            }
            let _e474 = phi_8583_;
            phi_8593_ = _e474;
            if _e474 {
                let _e476 = cPos[2u];
                let _e478 = tuning.gridDepth;
                phi_8593_ = (_e476 < (bitcast<i32>(_e478) - 1i));
            }
            let _e483 = phi_8593_;
            if _e483 {
                let _e484 = cPos;
                param_409 = _e484;
                let _e485 = getIndex_u0028_vi3_u003b((&param_409));
                cIndex = _e485;
                let _e486 = cIndex;
                param_410 = _e486;
                let _e487 = readCell_u0028_u1_u003b((&param_410));
                cVal = _e487;
                let _e488 = cVal;
                param_411 = _e488;
                let _e489 = getType_u0028_u1_u003b((&param_411));
                cType = _e489;
                let _e490 = cType;
                let _e492 = cType;
                if ((_e490 == 1u) || (_e492 == 4u)) {
                    let _e495 = cVal;
                    param_412 = _e495;
                    let _e496 = getAge_u0028_u1_u003b((&param_412));
                    moisture_2 = _e496;
                    let _e497 = cType;
                    if (_e497 == 4u) {
                        let _e500 = tuning.dirtMoistureCapacity;
                        local_15 = _e500;
                    } else {
                        let _e502 = tuning.sandMoistureCapacity;
                        local_15 = _e502;
                    }
                    let _e503 = local_15;
                    capacity = _e503;
                    let _e504 = moisture_2;
                    let _e505 = capacity;
                    if (_e504 < _e505) {
                        let _e507 = (*currentIndex_6);
                        let _e510 = (*rawValue_5);
                        let _e511 = atomicCompareExchangeWeak((&unnamed.grid[_e507]), _e510, 0u);
                        let _e513 = (*rawValue_5);
                        if (_e511.old_value == _e513) {
                            let _e515 = cIndex;
                            let _e518 = atomicAdd((&unnamed.grid[_e515]), 16777216u);
                            return;
                        }
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e519 = i_11;
            i_11 = (_e519 + 1i);
        }
    }
    i_12 = 0i;
    loop {
        let _e521 = i_12;
        if (_e521 < 3i) {
            let _e523 = i_12;
            let _e525 = checkPos[_e523];
            sPos_1 = _e525;
            let _e527 = sPos_1[1u];
            let _e529 = tuning.gridHeight;
            let _e532 = (_e527 < (bitcast<i32>(_e529) - 1i));
            phi_8674_ = _e532;
            if _e532 {
                let _e534 = sPos_1[0u];
                phi_8674_ = (_e534 > 0i);
            }
            let _e537 = phi_8674_;
            phi_8684_ = _e537;
            if _e537 {
                let _e539 = sPos_1[0u];
                let _e541 = tuning.gridWidth;
                phi_8684_ = (_e539 < (bitcast<i32>(_e541) - 1i));
            }
            let _e546 = phi_8684_;
            phi_8690_ = _e546;
            if _e546 {
                let _e548 = sPos_1[2u];
                phi_8690_ = (_e548 > 0i);
            }
            let _e551 = phi_8690_;
            phi_8700_ = _e551;
            if _e551 {
                let _e553 = sPos_1[2u];
                let _e555 = tuning.gridDepth;
                phi_8700_ = (_e553 < (bitcast<i32>(_e555) - 1i));
            }
            let _e560 = phi_8700_;
            if _e560 {
                let _e561 = sPos_1;
                param_413 = _e561;
                let _e562 = getIndex_u0028_vi3_u003b((&param_413));
                param_414 = _e562;
                let _e563 = readCell_u0028_u1_u003b((&param_414));
                param_415 = _e563;
                let _e564 = getType_u0028_u1_u003b((&param_415));
                sType_1 = _e564;
                let _e565 = sType_1;
                let _e567 = sType_1;
                let _e569 = ((_e565 == 0u) || (_e567 == 5u));
                phi_8726_ = _e569;
                if _e569 {
                    let _e570 = sPos_1;
                    param_416 = _e570;
                    let _e571 = getIndex_u0028_vi3_u003b((&param_416));
                    let _e574 = atomicLoad((&unnamed_1.cloudCells[_e571]));
                    param_417 = _e574;
                    let _e575 = getCloudKind_u0028_u1_u003b((&param_417));
                    phi_8726_ = (_e575 == 0u);
                }
                let _e578 = phi_8726_;
                if _e578 {
                    let _e579 = sPos_1;
                    param_418 = _e579;
                    let _e580 = getIndex_u0028_vi3_u003b((&param_418));
                    param_419 = 6u;
                    param_420 = 0u;
                    param_421 = 0u;
                    let _e581 = newAge;
                    param_422 = _e581;
                    let _e582 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_419), (&param_420), (&param_421), (&param_422));
                    let _e583 = (*currentIndex_6);
                    param_423 = _e583;
                    let _e584 = (*rawValue_5);
                    param_424 = _e584;
                    param_425 = _e580;
                    param_426 = _e582;
                    let _e585 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_423), (&param_424), (&param_425), (&param_426));
                    if _e585 {
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e586 = i_12;
            i_12 = (_e586 + 1i);
        }
    }
    let _e588 = (*currentSleep_2);
    newSleep_1 = min((_e588 + 1u), 255u);
    let _e591 = (*currentIndex_6);
    let _e594 = (*rawValue_5);
    param_427 = 6u;
    param_428 = 0u;
    let _e595 = newSleep_1;
    param_429 = _e595;
    let _e596 = newAge;
    param_430 = _e596;
    let _e597 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_427), (&param_428), (&param_429), (&param_430));
    let _e598 = atomicCompareExchangeWeak((&unnamed.grid[_e591]), _e594, _e597);
    return;
}

fn updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_11: ptr<function, vec3<i32>>, currentIndex_7: ptr<function, u32>, rawValue_6: ptr<function, u32>, currentDir_3: ptr<function, u32>, currentSleep_3: ptr<function, u32>, currentAge_6: ptr<function, u32>, randVal_8: ptr<function, f32>) {
    var newAge_1: u32;
    var isBurningGrass: bool;
    var i_13: i32;
    var nPos_1: vec3<i32>;
    var param_431: i32;
    var nIndex_1: u32;
    var param_432: vec3<i32>;
    var nVal_1: u32;
    var param_433: u32;
    var param_434: u32;
    var param_435: u32;
    var param_436: u32;
    var param_437: u32;
    var param_438: u32;
    var burnRoll: f32;
    var start_6: i32;
    var i_14: i32;
    var nPos_2: vec3<i32>;
    var param_439: i32;
    var param_440: vec3<i32>;
    var nIndex_2: u32;
    var param_441: vec3<i32>;
    var nVal_2: u32;
    var param_442: u32;
    var nType_1: u32;
    var param_443: u32;
    var need_1: f32;
    var local_16: f32;
    var param_444: u32;
    var param_445: u32;
    var param_446: u32;
    var param_447: u32;
    var belowPos_4: vec3<i32>;
    var belowIndex_1: u32;
    var param_448: vec3<i32>;
    var belowValue_1: u32;
    var param_449: u32;
    var belowType: u32;
    var param_450: u32;
    var param_451: u32;
    var param_452: u32;
    var param_453: u32;
    var param_454: u32;
    var param_455: u32;
    var param_456: u32;
    var param_457: u32;
    var param_458: u32;
    var moisture_3: u32;
    var param_459: u32;
    var newMoisture: u32;
    var local_17: u32;
    var newVal: u32;
    var param_460: u32;
    var param_461: u32;
    var param_462: u32;
    var param_463: u32;
    var param_464: u32;
    var flora_3: u32;
    var newFlora: u32;
    var newVal_1: u32;
    var param_465: u32;
    var param_466: u32;
    var param_467: u32;
    var param_468: u32;
    var param_469: u32;
    var d_10: i32;
    var targetPos_1: vec3<i32>;
    var param_470: i32;
    var targetIndex_1: u32;
    var param_471: vec3<i32>;
    var param_472: u32;
    var param_473: u32;
    var targetBelow: vec3<i32>;
    var tBelowVal: u32;
    var param_474: vec3<i32>;
    var param_475: u32;
    var param_476: u32;
    var tFlora: u32;
    var param_477: u32;
    var param_478: u32;
    var param_479: u32;
    var param_480: u32;
    var param_481: u32;
    var param_482: u32;
    var param_483: u32;
    var param_484: u32;
    var phi_7671_: bool;
    var phi_7677_: bool;
    var phi_7687_: bool;
    var phi_7693_: bool;
    var phi_7703_: bool;
    var phi_8011_: bool;
    var phi_8017_: bool;
    var phi_8027_: bool;

    let _e289 = (*currentAge_6);
    newAge_1 = (_e289 + 1u);
    isBurningGrass = false;
    i_13 = 0i;
    loop {
        let _e291 = i_13;
        if (_e291 < 6i) {
            let _e293 = (*pos_11);
            let _e294 = i_13;
            param_431 = _e294;
            let _e295 = getOrthoDir_u0028_i1_u003b((&param_431));
            nPos_1 = (_e293 + _e295);
            let _e298 = nPos_1[0u];
            let _e299 = (_e298 > 0i);
            phi_7671_ = _e299;
            if _e299 {
                let _e301 = nPos_1[0u];
                let _e303 = tuning.gridWidth;
                phi_7671_ = (_e301 < (bitcast<i32>(_e303) - 1i));
            }
            let _e308 = phi_7671_;
            phi_7677_ = _e308;
            if _e308 {
                let _e310 = nPos_1[1u];
                phi_7677_ = (_e310 > 0i);
            }
            let _e313 = phi_7677_;
            phi_7687_ = _e313;
            if _e313 {
                let _e315 = nPos_1[1u];
                let _e317 = tuning.gridHeight;
                phi_7687_ = (_e315 < (bitcast<i32>(_e317) - 1i));
            }
            let _e322 = phi_7687_;
            phi_7693_ = _e322;
            if _e322 {
                let _e324 = nPos_1[2u];
                phi_7693_ = (_e324 > 0i);
            }
            let _e327 = phi_7693_;
            phi_7703_ = _e327;
            if _e327 {
                let _e329 = nPos_1[2u];
                let _e331 = tuning.gridDepth;
                phi_7703_ = (_e329 < (bitcast<i32>(_e331) - 1i));
            }
            let _e336 = phi_7703_;
            if _e336 {
                let _e337 = nPos_1;
                param_432 = _e337;
                let _e338 = getIndex_u0028_vi3_u003b((&param_432));
                nIndex_1 = _e338;
                let _e339 = nIndex_1;
                param_433 = _e339;
                let _e340 = readCell_u0028_u1_u003b((&param_433));
                nVal_1 = _e340;
                let _e341 = nVal_1;
                param_434 = _e341;
                let _e342 = getType_u0028_u1_u003b((&param_434));
                if (_e342 == 2u) {
                    let _e344 = nIndex_1;
                    let _e347 = nVal_1;
                    param_435 = 6u;
                    param_436 = 0u;
                    param_437 = 0u;
                    param_438 = 0u;
                    let _e348 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_435), (&param_436), (&param_437), (&param_438));
                    let _e349 = atomicCompareExchangeWeak((&unnamed.grid[_e344]), _e347, _e348);
                    let _e351 = nVal_1;
                    if (_e349.old_value == _e351) {
                        decWater_u0028_();
                        let _e353 = (*currentIndex_7);
                        let _e356 = atomicExchange((&unnamed.grid[_e353]), 0u);
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e357 = i_13;
            i_13 = (_e357 + 1i);
        }
    }
    let _e359 = (*randVal_8);
    burnRoll = fract((_e359 * 47f));
    let _e362 = burnRoll;
    let _e364 = tuning.treeLeafBurnChance;
    let _e366 = tuning.treeTrunkBurnChance;
    if (_e362 < max(_e364, _e366)) {
        let _e369 = (*randVal_8);
        start_6 = i32((fract((_e369 * 31f)) * 26f));
        i_14 = 0i;
        loop {
            let _e374 = i_14;
            if (_e374 < 26i) {
                let _e376 = (*pos_11);
                let _e377 = start_6;
                let _e378 = i_14;
                let _e379 = (_e377 + _e378);
                param_439 = (_e379 - (i32(floor((f32(_e379) / f32(26i)))) * 26i));
                let _e387 = tree26_u0028_i1_u003b((&param_439));
                nPos_2 = (_e376 + _e387);
                let _e389 = nPos_2;
                param_440 = _e389;
                let _e390 = treeInBounds_u0028_vi3_u003b((&param_440));
                if !(_e390) {
                    continue;
                }
                let _e392 = nPos_2;
                param_441 = _e392;
                let _e393 = getIndex_u0028_vi3_u003b((&param_441));
                nIndex_2 = _e393;
                let _e394 = nIndex_2;
                param_442 = _e394;
                let _e395 = readCell_u0028_u1_u003b((&param_442));
                nVal_2 = _e395;
                let _e396 = nVal_2;
                param_443 = _e396;
                let _e397 = getType_u0028_u1_u003b((&param_443));
                nType_1 = _e397;
                let _e398 = nType_1;
                let _e400 = nType_1;
                if ((_e398 != 19u) && (_e400 != 18u)) {
                    continue;
                }
                let _e403 = nType_1;
                if (_e403 == 19u) {
                    let _e406 = tuning.treeLeafBurnChance;
                    local_16 = _e406;
                } else {
                    let _e408 = tuning.treeTrunkBurnChance;
                    local_16 = _e408;
                }
                let _e409 = local_16;
                need_1 = _e409;
                let _e410 = burnRoll;
                let _e411 = need_1;
                if (_e410 < _e411) {
                    let _e413 = nIndex_2;
                    let _e416 = nVal_2;
                    param_444 = 5u;
                    param_445 = 0u;
                    param_446 = 0u;
                    param_447 = 0u;
                    let _e417 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_444), (&param_445), (&param_446), (&param_447));
                    let _e418 = atomicCompareExchangeWeak((&unnamed.grid[_e413]), _e416, _e417);
                }
                break;
            } else {
                break;
            }
            continuing {
                let _e420 = i_14;
                i_14 = (_e420 + 1i);
            }
        }
    }
    let _e423 = (*pos_11)[1u];
    if (_e423 > 1i) {
        let _e425 = (*pos_11);
        belowPos_4 = (_e425 + vec3<i32>(0i, -1i, 0i));
        let _e427 = belowPos_4;
        param_448 = _e427;
        let _e428 = getIndex_u0028_vi3_u003b((&param_448));
        belowIndex_1 = _e428;
        let _e429 = belowIndex_1;
        param_449 = _e429;
        let _e430 = readCell_u0028_u1_u003b((&param_449));
        belowValue_1 = _e430;
        let _e431 = belowValue_1;
        param_450 = _e431;
        let _e432 = getType_u0028_u1_u003b((&param_450));
        belowType = _e432;
        let _e433 = belowType;
        if (_e433 == 0u) {
            param_451 = 5u;
            param_452 = 0u;
            param_453 = 0u;
            let _e435 = newAge_1;
            param_454 = _e435;
            let _e436 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_451), (&param_452), (&param_453), (&param_454));
            let _e437 = (*currentIndex_7);
            param_455 = _e437;
            let _e438 = (*rawValue_6);
            param_456 = _e438;
            let _e439 = belowIndex_1;
            param_457 = _e439;
            param_458 = _e436;
            let _e440 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_455), (&param_456), (&param_457), (&param_458));
            if _e440 {
                return;
            }
        } else {
            let _e441 = belowType;
            if (_e441 == 2u) {
                let _e443 = (*currentIndex_7);
                let _e446 = atomicExchange((&unnamed.grid[_e443]), 0u);
                return;
            } else {
                let _e447 = belowType;
                if (_e447 == 1u) {
                    let _e449 = belowValue_1;
                    param_459 = _e449;
                    let _e450 = getAge_u0028_u1_u003b((&param_459));
                    moisture_3 = _e450;
                    let _e451 = moisture_3;
                    if (_e451 > 0u) {
                        let _e453 = moisture_3;
                        let _e455 = tuning.fireDryRate;
                        if (_e453 > _e455) {
                            let _e457 = moisture_3;
                            let _e459 = tuning.fireDryRate;
                            local_17 = (_e457 - _e459);
                        } else {
                            local_17 = 0u;
                        }
                        let _e461 = local_17;
                        newMoisture = _e461;
                        let _e462 = belowValue_1;
                        param_460 = _e462;
                        let _e463 = getDir_u0028_u1_u003b((&param_460));
                        param_461 = 1u;
                        param_462 = _e463;
                        param_463 = 0u;
                        let _e464 = newMoisture;
                        param_464 = _e464;
                        let _e465 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_461), (&param_462), (&param_463), (&param_464));
                        newVal = _e465;
                        let _e466 = belowIndex_1;
                        let _e469 = belowValue_1;
                        let _e470 = newVal;
                        let _e471 = atomicCompareExchangeWeak((&unnamed.grid[_e466]), _e469, _e470);
                        let _e473 = belowValue_1;
                        if (_e471.old_value == _e473) {
                            let _e475 = (*currentIndex_7);
                            let _e478 = atomicExchange((&unnamed.grid[_e475]), 0u);
                            return;
                        }
                    }
                } else {
                    let _e479 = belowType;
                    if (_e479 == 4u) {
                        let _e481 = belowValue_1;
                        flora_3 = ((_e481 >> bitcast<u32>(8i)) & 255u);
                        let _e485 = flora_3;
                        let _e487 = flora_3;
                        if ((_e485 > 10u) && (_e487 <= 100u)) {
                            isBurningGrass = true;
                            newAge_1 = 0u;
                            let _e490 = (*randVal_8);
                            let _e494 = tuning.fireBurnGrassChance;
                            if (fract((_e490 * 100f)) < _e494) {
                                let _e496 = flora_3;
                                newFlora = (_e496 - 1u);
                                let _e498 = belowValue_1;
                                param_465 = _e498;
                                let _e499 = getAge_u0028_u1_u003b((&param_465));
                                param_466 = 4u;
                                let _e500 = newFlora;
                                param_467 = _e500;
                                param_468 = 0u;
                                param_469 = _e499;
                                let _e501 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_466), (&param_467), (&param_468), (&param_469));
                                newVal_1 = _e501;
                                let _e502 = belowIndex_1;
                                let _e505 = belowValue_1;
                                let _e506 = newVal_1;
                                let _e507 = atomicCompareExchangeWeak((&unnamed.grid[_e502]), _e505, _e506);
                            }
                            let _e509 = (*randVal_8);
                            let _e513 = tuning.fireSpreadChance;
                            if (fract((_e509 * 100f)) < _e513) {
                                let _e515 = (*randVal_8);
                                d_10 = i32((fract((_e515 * 10f)) * 8f));
                                let _e520 = (*pos_11);
                                let _e521 = d_10;
                                param_470 = _e521;
                                let _e522 = getHDir_u0028_i1_u003b((&param_470));
                                targetPos_1 = (_e520 + _e522);
                                let _e525 = targetPos_1[0u];
                                let _e526 = (_e525 > 0i);
                                phi_8011_ = _e526;
                                if _e526 {
                                    let _e528 = targetPos_1[0u];
                                    let _e530 = tuning.gridWidth;
                                    phi_8011_ = (_e528 < (bitcast<i32>(_e530) - 1i));
                                }
                                let _e535 = phi_8011_;
                                phi_8017_ = _e535;
                                if _e535 {
                                    let _e537 = targetPos_1[2u];
                                    phi_8017_ = (_e537 > 0i);
                                }
                                let _e540 = phi_8017_;
                                phi_8027_ = _e540;
                                if _e540 {
                                    let _e542 = targetPos_1[2u];
                                    let _e544 = tuning.gridDepth;
                                    phi_8027_ = (_e542 < (bitcast<i32>(_e544) - 1i));
                                }
                                let _e549 = phi_8027_;
                                if _e549 {
                                    let _e550 = targetPos_1;
                                    param_471 = _e550;
                                    let _e551 = getIndex_u0028_vi3_u003b((&param_471));
                                    targetIndex_1 = _e551;
                                    let _e552 = targetIndex_1;
                                    param_472 = _e552;
                                    let _e553 = readCell_u0028_u1_u003b((&param_472));
                                    param_473 = _e553;
                                    let _e554 = getType_u0028_u1_u003b((&param_473));
                                    if (_e554 == 0u) {
                                        let _e556 = targetPos_1;
                                        targetBelow = (_e556 + vec3<i32>(0i, -1i, 0i));
                                        let _e558 = targetBelow;
                                        param_474 = _e558;
                                        let _e559 = getIndex_u0028_vi3_u003b((&param_474));
                                        param_475 = _e559;
                                        let _e560 = readCell_u0028_u1_u003b((&param_475));
                                        tBelowVal = _e560;
                                        let _e561 = tBelowVal;
                                        param_476 = _e561;
                                        let _e562 = getType_u0028_u1_u003b((&param_476));
                                        if (_e562 == 4u) {
                                            let _e564 = tBelowVal;
                                            tFlora = ((_e564 >> bitcast<u32>(8i)) & 255u);
                                            let _e568 = tFlora;
                                            let _e570 = tFlora;
                                            if ((_e568 > 10u) && (_e570 <= 100u)) {
                                                let _e573 = targetIndex_1;
                                                param_477 = 5u;
                                                param_478 = 0u;
                                                param_479 = 0u;
                                                param_480 = 0u;
                                                let _e576 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_477), (&param_478), (&param_479), (&param_480));
                                                let _e577 = atomicCompareExchangeWeak((&unnamed.grid[_e573]), 0u, _e576);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    let _e579 = newAge_1;
    let _e581 = tuning.fireLifetime;
    if (_e579 > _e581) {
        let _e583 = (*currentIndex_7);
        let _e586 = atomicExchange((&unnamed.grid[_e583]), 0u);
        return;
    }
    let _e587 = (*currentIndex_7);
    let _e590 = (*rawValue_6);
    param_481 = 5u;
    param_482 = 0u;
    param_483 = 0u;
    let _e591 = newAge_1;
    param_484 = _e591;
    let _e592 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_481), (&param_482), (&param_483), (&param_484));
    let _e593 = atomicCompareExchangeWeak((&unnamed.grid[_e587]), _e590, _e592);
    return;
}

fn isLocust_u0028_u1_u003b(type_36: ptr<function, u32>) -> bool {
    let _e197 = (*type_36);
    let _e199 = (*type_36);
    return ((_e197 >= 13u) && (_e199 <= 17u));
}

fn tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex_8: ptr<function, u32>, currentValue_1: ptr<function, u32>, targetIndex_2: ptr<function, u32>, targetValue_1: ptr<function, u32>, pushIndex: ptr<function, u32>) -> bool {
    var displacedValue: u32;
    var param_485: u32;
    var param_486: u32;
    var param_487: u32;
    var param_488: u32;
    var param_489: u32;
    var actualPush: u32;
    var actualTarget: u32;

    let _e209 = (*currentIndex_8);
    let _e212 = (*currentValue_1);
    let _e213 = atomicCompareExchangeWeak((&unnamed.grid[_e209]), _e212, 0u);
    let _e215 = (*currentValue_1);
    if (_e213.old_value == _e215) {
        let _e217 = (*targetValue_1);
        param_485 = _e217;
        let _e218 = getType_u0028_u1_u003b((&param_485));
        param_486 = _e218;
        param_487 = 0u;
        param_488 = 0u;
        param_489 = 0u;
        let _e219 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_486), (&param_487), (&param_488), (&param_489));
        displacedValue = _e219;
        let _e220 = (*pushIndex);
        let _e223 = displacedValue;
        let _e224 = atomicCompareExchangeWeak((&unnamed.grid[_e220]), 0u, _e223);
        actualPush = _e224.old_value;
        let _e226 = actualPush;
        if (_e226 == 0u) {
            let _e228 = (*targetIndex_2);
            let _e231 = (*targetValue_1);
            let _e232 = (*currentValue_1);
            let _e233 = atomicCompareExchangeWeak((&unnamed.grid[_e228]), _e231, _e232);
            actualTarget = _e233.old_value;
            let _e235 = actualTarget;
            let _e236 = (*targetValue_1);
            if (_e235 == _e236) {
                return true;
            } else {
                let _e238 = (*pushIndex);
                let _e241 = displacedValue;
                let _e242 = atomicCompareExchangeWeak((&unnamed.grid[_e238]), _e241, 0u);
            }
        }
        let _e244 = (*currentIndex_8);
        let _e247 = (*currentValue_1);
        let _e248 = atomicCompareExchangeWeak((&unnamed.grid[_e244]), 0u, _e247);
    }
    return false;
}

fn grainCanMove_u0028_vi3_u003b(pos_12: ptr<function, vec3<i32>>) -> bool {
    var i_15: i32;
    var target_2: vec3<i32>;
    var local_18: i32;
    var local_19: i32;
    var t_3: u32;
    var param_490: vec3<i32>;
    var param_491: u32;
    var param_492: u32;
    var phi_2343_: bool;
    var phi_2350_: bool;
    var phi_2361_: bool;

    let _e206 = (*pos_12)[1u];
    if (_e206 <= 1i) {
        return false;
    }
    i_15 = 0i;
    loop {
        let _e208 = i_15;
        if (_e208 < 5i) {
            let _e210 = (*pos_12);
            let _e211 = i_15;
            if (_e211 == 1i) {
                local_18 = 1i;
            } else {
                let _e213 = i_15;
                local_18 = select(0i, -1i, (_e213 == 2i));
            }
            let _e216 = local_18;
            let _e217 = i_15;
            if (_e217 == 3i) {
                local_19 = 1i;
            } else {
                let _e219 = i_15;
                local_19 = select(0i, -1i, (_e219 == 4i));
            }
            let _e222 = local_19;
            target_2 = (_e210 + vec3<i32>(_e216, -1i, _e222));
            let _e226 = target_2[0u];
            let _e227 = (_e226 <= 0i);
            phi_2343_ = _e227;
            if !(_e227) {
                let _e230 = target_2[0u];
                let _e232 = tuning.gridWidth;
                phi_2343_ = (_e230 >= (bitcast<i32>(_e232) - 1i));
            }
            let _e237 = phi_2343_;
            phi_2350_ = _e237;
            if !(_e237) {
                let _e240 = target_2[2u];
                phi_2350_ = (_e240 <= 0i);
            }
            let _e243 = phi_2350_;
            phi_2361_ = _e243;
            if !(_e243) {
                let _e246 = target_2[2u];
                let _e248 = tuning.gridDepth;
                phi_2361_ = (_e246 >= (bitcast<i32>(_e248) - 1i));
            }
            let _e253 = phi_2361_;
            if _e253 {
                continue;
            }
            let _e254 = target_2;
            param_490 = _e254;
            let _e255 = getIndex_u0028_vi3_u003b((&param_490));
            param_491 = _e255;
            let _e256 = readCell_u0028_u1_u003b((&param_491));
            param_492 = _e256;
            let _e257 = getType_u0028_u1_u003b((&param_492));
            t_3 = _e257;
            let _e258 = t_3;
            let _e260 = t_3;
            if ((_e258 == 0u) || (_e260 == 2u)) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e263 = i_15;
            i_15 = (_e263 + 1i);
        }
    }
    return false;
}

fn updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_13: ptr<function, vec3<i32>>, currentIndex_9: ptr<function, u32>, rawValue_7: ptr<function, u32>, currentDir_4: ptr<function, u32>, currentSleep_4: ptr<function, u32>, currentAge_7: ptr<function, u32>, randVal_9: ptr<function, f32>) {
    var moisture_4: u32;
    var moistureModified: bool;
    var startDir_1: i32;
    var i_16: i32;
    var d_11: i32;
    var nPos_3: vec3<i32>;
    var param_493: i32;
    var nIndex_3: u32;
    var param_494: vec3<i32>;
    var nVal_3: u32;
    var param_495: u32;
    var param_496: u32;
    var d_12: i32;
    var nPos_4: vec3<i32>;
    var param_497: i32;
    var nIndex_4: u32;
    var param_498: vec3<i32>;
    var nVal_4: u32;
    var param_499: u32;
    var nType_2: u32;
    var param_500: u32;
    var nMoisture: u32;
    var param_501: u32;
    var nCapacity: u32;
    var local_20: u32;
    var canMove: bool;
    var param_502: vec3<i32>;
    var isClumped: bool;
    var emptyBelowCount: i32;
    var x: i32;
    var z: i32;
    var checkPos_1: vec3<i32>;
    var param_503: vec3<i32>;
    var param_504: u32;
    var param_505: u32;
    var clumpCount: i32;
    var x_1: i32;
    var y: i32;
    var z_1: i32;
    var nPos_5: vec3<i32>;
    var param_506: vec3<i32>;
    var param_507: u32;
    var param_508: u32;
    var belowPos_5: vec3<i32>;
    var param_509: vec3<i32>;
    var param_510: u32;
    var param_511: u32;
    var param_512: vec3<i32>;
    var param_513: u32;
    var param_514: u32;
    var param_515: u32;
    var param_516: u32;
    var param_517: u32;
    var param_518: u32;
    var param_519: u32;
    var param_520: u32;
    var dir_2: i32;
    var slidePos1_: vec3<i32>;
    var slidePos2_: vec3<i32>;
    var param_521: vec3<i32>;
    var param_522: u32;
    var param_523: u32;
    var param_524: vec3<i32>;
    var param_525: u32;
    var param_526: u32;
    var param_527: u32;
    var param_528: u32;
    var param_529: u32;
    var param_530: u32;
    var param_531: u32;
    var param_532: u32;
    var param_533: vec3<i32>;
    var param_534: u32;
    var param_535: u32;
    var param_536: vec3<i32>;
    var param_537: u32;
    var param_538: u32;
    var param_539: u32;
    var param_540: u32;
    var param_541: u32;
    var param_542: u32;
    var param_543: u32;
    var param_544: u32;
    var belowPos_6: vec3<i32>;
    var belowIndex_2: u32;
    var param_545: vec3<i32>;
    var belowValue_2: u32;
    var param_546: u32;
    var param_547: u32;
    var startDir_2: i32;
    var i_17: i32;
    var d_13: i32;
    var pushPos: vec3<i32>;
    var param_548: i32;
    var param_549: u32;
    var param_550: u32;
    var param_551: u32;
    var param_552: u32;
    var param_553: vec3<i32>;
    var param_554: u32;
    var param_555: u32;
    var param_556: u32;
    var param_557: u32;
    var param_558: u32;
    var param_559: u32;
    var param_560: u32;
    var param_561: u32;
    var param_562: u32;
    var param_563: u32;
    var param_564: u32;
    var param_565: u32;
    var param_566: u32;
    var dir_3: i32;
    var slidePos: array<vec3<i32>, 2>;
    var s_1: i32;
    var sPos_2: vec3<i32>;
    var sIndex: u32;
    var param_567: vec3<i32>;
    var sValue: u32;
    var param_568: u32;
    var param_569: u32;
    var startDir_3: i32;
    var i_18: i32;
    var d_14: i32;
    var pushPos_1: vec3<i32>;
    var param_570: i32;
    var param_571: u32;
    var param_572: u32;
    var param_573: u32;
    var param_574: u32;
    var param_575: vec3<i32>;
    var param_576: u32;
    var param_577: u32;
    var param_578: u32;
    var param_579: u32;
    var param_580: u32;
    var param_581: u32;
    var param_582: u32;
    var param_583: u32;
    var param_584: u32;
    var param_585: u32;
    var param_586: u32;
    var param_587: u32;
    var param_588: u32;
    var floraState: u32;
    var abovePos_1: vec3<i32>;
    var aboveInside: bool;
    var aboveIndex: u32;
    var param_589: vec3<i32>;
    var aboveType: u32;
    var local_21: u32;
    var param_590: u32;
    var param_591: u32;
    var param_592: u32;
    var param_593: u32;
    var param_594: u32;
    var param_595: u32;
    var param_596: u32;
    var newSleep_2: u32;
    var param_597: u32;
    var param_598: u32;
    var param_599: u32;
    var param_600: u32;
    var phi_3475_: bool;
    var phi_3481_: bool;
    var phi_3491_: bool;
    var phi_3497_: bool;
    var phi_3507_: bool;
    var phi_3573_: bool;
    var phi_3579_: bool;
    var phi_3589_: bool;
    var phi_3595_: bool;
    var phi_3605_: bool;
    var phi_3675_: bool;
    var phi_3717_: bool;
    var phi_3723_: bool;
    var phi_3732_: bool;
    var phi_3813_: bool;
    var phi_3819_: bool;
    var phi_3828_: bool;
    var phi_3834_: bool;
    var phi_3843_: bool;
    var phi_3962_: bool;
    var phi_3968_: bool;
    var phi_3978_: bool;
    var phi_4022_: bool;
    var phi_4028_: bool;
    var phi_4038_: bool;
    var phi_4129_: bool;
    var phi_4135_: bool;
    var phi_4145_: bool;
    var phi_4246_: bool;
    var phi_4252_: bool;
    var phi_4262_: bool;
    var phi_4319_: bool;
    var phi_4325_: bool;
    var phi_4335_: bool;
    var phi_4390_: bool;
    var phi_4464_: bool;
    var phi_4519_: bool;

    let _e366 = (*currentAge_7);
    moisture_4 = _e366;
    moistureModified = false;
    let _e367 = moisture_4;
    let _e369 = tuning.dirtMoistureCapacity;
    if (_e367 < _e369) {
        let _e371 = (*randVal_9);
        startDir_1 = i32((fract((_e371 * 17f)) * 6f));
        i_16 = 0i;
        loop {
            let _e376 = i_16;
            if (_e376 < 6i) {
                let _e378 = startDir_1;
                let _e379 = i_16;
                let _e380 = (_e378 + _e379);
                d_11 = (_e380 - (i32(floor((f32(_e380) / f32(6i)))) * 6i));
                let _e388 = (*pos_13);
                let _e389 = d_11;
                param_493 = _e389;
                let _e390 = getOrthoDir_u0028_i1_u003b((&param_493));
                nPos_3 = (_e388 + _e390);
                let _e393 = nPos_3[0u];
                let _e394 = (_e393 > 0i);
                phi_3475_ = _e394;
                if _e394 {
                    let _e396 = nPos_3[0u];
                    let _e398 = tuning.gridWidth;
                    phi_3475_ = (_e396 < (bitcast<i32>(_e398) - 1i));
                }
                let _e403 = phi_3475_;
                phi_3481_ = _e403;
                if _e403 {
                    let _e405 = nPos_3[1u];
                    phi_3481_ = (_e405 > 0i);
                }
                let _e408 = phi_3481_;
                phi_3491_ = _e408;
                if _e408 {
                    let _e410 = nPos_3[1u];
                    let _e412 = tuning.gridHeight;
                    phi_3491_ = (_e410 < (bitcast<i32>(_e412) - 1i));
                }
                let _e417 = phi_3491_;
                phi_3497_ = _e417;
                if _e417 {
                    let _e419 = nPos_3[2u];
                    phi_3497_ = (_e419 > 0i);
                }
                let _e422 = phi_3497_;
                phi_3507_ = _e422;
                if _e422 {
                    let _e424 = nPos_3[2u];
                    let _e426 = tuning.gridDepth;
                    phi_3507_ = (_e424 < (bitcast<i32>(_e426) - 1i));
                }
                let _e431 = phi_3507_;
                if _e431 {
                    let _e432 = nPos_3;
                    param_494 = _e432;
                    let _e433 = getIndex_u0028_vi3_u003b((&param_494));
                    nIndex_3 = _e433;
                    let _e434 = nIndex_3;
                    param_495 = _e434;
                    let _e435 = readCell_u0028_u1_u003b((&param_495));
                    nVal_3 = _e435;
                    let _e436 = nVal_3;
                    param_496 = _e436;
                    let _e437 = getType_u0028_u1_u003b((&param_496));
                    if (_e437 == 2u) {
                        let _e439 = nIndex_3;
                        let _e442 = nVal_3;
                        let _e443 = atomicCompareExchangeWeak((&unnamed.grid[_e439]), _e442, 0u);
                        let _e445 = nVal_3;
                        if (_e443.old_value == _e445) {
                            let _e447 = (*currentIndex_9);
                            let _e451 = tuning.sandWaterAbsorbUnit;
                            let _e454 = atomicAdd((&unnamed.grid[_e447]), (_e451 << bitcast<u32>(24i)));
                            decWater_u0028_();
                            moistureModified = true;
                            break;
                        }
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e455 = i_16;
                i_16 = (_e455 + 1i);
            }
        }
    }
    let _e457 = moistureModified;
    let _e459 = moisture_4;
    if (!(_e457) && (_e459 > 0u)) {
        let _e462 = (*randVal_9);
        d_12 = i32((fract((_e462 * 31f)) * 6f));
        let _e467 = (*pos_13);
        let _e468 = d_12;
        param_497 = _e468;
        let _e469 = getOrthoDir_u0028_i1_u003b((&param_497));
        nPos_4 = (_e467 + _e469);
        let _e472 = nPos_4[0u];
        let _e473 = (_e472 > 0i);
        phi_3573_ = _e473;
        if _e473 {
            let _e475 = nPos_4[0u];
            let _e477 = tuning.gridWidth;
            phi_3573_ = (_e475 < (bitcast<i32>(_e477) - 1i));
        }
        let _e482 = phi_3573_;
        phi_3579_ = _e482;
        if _e482 {
            let _e484 = nPos_4[1u];
            phi_3579_ = (_e484 > 0i);
        }
        let _e487 = phi_3579_;
        phi_3589_ = _e487;
        if _e487 {
            let _e489 = nPos_4[1u];
            let _e491 = tuning.gridHeight;
            phi_3589_ = (_e489 < (bitcast<i32>(_e491) - 1i));
        }
        let _e496 = phi_3589_;
        phi_3595_ = _e496;
        if _e496 {
            let _e498 = nPos_4[2u];
            phi_3595_ = (_e498 > 0i);
        }
        let _e501 = phi_3595_;
        phi_3605_ = _e501;
        if _e501 {
            let _e503 = nPos_4[2u];
            let _e505 = tuning.gridDepth;
            phi_3605_ = (_e503 < (bitcast<i32>(_e505) - 1i));
        }
        let _e510 = phi_3605_;
        if _e510 {
            let _e511 = nPos_4;
            param_498 = _e511;
            let _e512 = getIndex_u0028_vi3_u003b((&param_498));
            nIndex_4 = _e512;
            let _e513 = nIndex_4;
            param_499 = _e513;
            let _e514 = readCell_u0028_u1_u003b((&param_499));
            nVal_4 = _e514;
            let _e515 = nVal_4;
            param_500 = _e515;
            let _e516 = getType_u0028_u1_u003b((&param_500));
            nType_2 = _e516;
            let _e517 = nType_2;
            let _e519 = nType_2;
            if ((_e517 == 4u) || (_e519 == 1u)) {
                let _e522 = nVal_4;
                param_501 = _e522;
                let _e523 = getAge_u0028_u1_u003b((&param_501));
                nMoisture = _e523;
                let _e524 = nType_2;
                if (_e524 == 4u) {
                    let _e527 = tuning.dirtMoistureCapacity;
                    local_20 = _e527;
                } else {
                    let _e529 = tuning.sandMoistureCapacity;
                    local_20 = _e529;
                }
                let _e530 = local_20;
                nCapacity = _e530;
                let _e531 = moisture_4;
                let _e532 = nMoisture;
                let _e535 = nMoisture;
                let _e536 = nCapacity;
                if ((_e531 > (_e532 + 1u)) && (_e535 < _e536)) {
                    let _e539 = (*currentIndex_9);
                    let _e542 = atomicAdd((&unnamed.grid[_e539]), 4278190080u);
                    let _e543 = nIndex_4;
                    let _e546 = atomicAdd((&unnamed.grid[_e543]), 16777216u);
                    moistureModified = true;
                }
            }
        }
    }
    let _e547 = moistureModified;
    if _e547 {
        return;
    }
    let _e548 = (*pos_13);
    param_502 = _e548;
    let _e549 = grainCanMove_u0028_vi3_u003b((&param_502));
    canMove = _e549;
    isClumped = false;
    let _e550 = canMove;
    phi_3675_ = _e550;
    if _e550 {
        let _e551 = (*currentSleep_4);
        let _e553 = tuning.wakeSleepThreshold;
        phi_3675_ = (_e551 > _e553);
    }
    let _e556 = phi_3675_;
    if _e556 {
        emptyBelowCount = 0i;
        let _e558 = (*pos_13)[1u];
        if (_e558 > 1i) {
            x = -1i;
            loop {
                let _e560 = x;
                if (_e560 <= 1i) {
                    z = -1i;
                    loop {
                        let _e562 = z;
                        if (_e562 <= 1i) {
                            let _e564 = (*pos_13);
                            let _e565 = x;
                            let _e566 = z;
                            checkPos_1 = (_e564 + vec3<i32>(_e565, -1i, _e566));
                            let _e570 = checkPos_1[0u];
                            let _e571 = (_e570 >= 0i);
                            phi_3717_ = _e571;
                            if _e571 {
                                let _e573 = checkPos_1[0u];
                                let _e575 = tuning.gridWidth;
                                phi_3717_ = (_e573 < bitcast<i32>(_e575));
                            }
                            let _e579 = phi_3717_;
                            phi_3723_ = _e579;
                            if _e579 {
                                let _e581 = checkPos_1[2u];
                                phi_3723_ = (_e581 >= 0i);
                            }
                            let _e584 = phi_3723_;
                            phi_3732_ = _e584;
                            if _e584 {
                                let _e586 = checkPos_1[2u];
                                let _e588 = tuning.gridDepth;
                                phi_3732_ = (_e586 < bitcast<i32>(_e588));
                            }
                            let _e592 = phi_3732_;
                            if _e592 {
                                let _e593 = checkPos_1;
                                param_503 = _e593;
                                let _e594 = getIndex_u0028_vi3_u003b((&param_503));
                                param_504 = _e594;
                                let _e595 = readCell_u0028_u1_u003b((&param_504));
                                param_505 = _e595;
                                let _e596 = getType_u0028_u1_u003b((&param_505));
                                if (_e596 == 0u) {
                                    let _e598 = emptyBelowCount;
                                    emptyBelowCount = (_e598 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e600 = z;
                            z = (_e600 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e602 = x;
                    x = (_e602 + 1i);
                }
            }
        }
        let _e604 = emptyBelowCount;
        let _e606 = tuning.emptyBelowWakeCount;
        if (_e604 >= bitcast<i32>(_e606)) {
            (*currentSleep_4) = 0u;
        } else {
            clumpCount = 0i;
            x_1 = -1i;
            loop {
                let _e609 = x_1;
                if (_e609 <= 1i) {
                    y = -1i;
                    loop {
                        let _e611 = y;
                        if (_e611 <= 1i) {
                            z_1 = -1i;
                            loop {
                                let _e613 = z_1;
                                if (_e613 <= 1i) {
                                    let _e615 = x_1;
                                    let _e617 = y;
                                    let _e620 = z_1;
                                    if (((_e615 == 0i) && (_e617 == 0i)) && (_e620 == 0i)) {
                                        continue;
                                    }
                                    let _e623 = (*pos_13);
                                    let _e624 = x_1;
                                    let _e625 = y;
                                    let _e626 = z_1;
                                    nPos_5 = (_e623 + vec3<i32>(_e624, _e625, _e626));
                                    let _e630 = nPos_5[0u];
                                    let _e631 = (_e630 >= 0i);
                                    phi_3813_ = _e631;
                                    if _e631 {
                                        let _e633 = nPos_5[0u];
                                        let _e635 = tuning.gridWidth;
                                        phi_3813_ = (_e633 < bitcast<i32>(_e635));
                                    }
                                    let _e639 = phi_3813_;
                                    phi_3819_ = _e639;
                                    if _e639 {
                                        let _e641 = nPos_5[1u];
                                        phi_3819_ = (_e641 >= 0i);
                                    }
                                    let _e644 = phi_3819_;
                                    phi_3828_ = _e644;
                                    if _e644 {
                                        let _e646 = nPos_5[1u];
                                        let _e648 = tuning.gridHeight;
                                        phi_3828_ = (_e646 < bitcast<i32>(_e648));
                                    }
                                    let _e652 = phi_3828_;
                                    phi_3834_ = _e652;
                                    if _e652 {
                                        let _e654 = nPos_5[2u];
                                        phi_3834_ = (_e654 >= 0i);
                                    }
                                    let _e657 = phi_3834_;
                                    phi_3843_ = _e657;
                                    if _e657 {
                                        let _e659 = nPos_5[2u];
                                        let _e661 = tuning.gridDepth;
                                        phi_3843_ = (_e659 < bitcast<i32>(_e661));
                                    }
                                    let _e665 = phi_3843_;
                                    if _e665 {
                                        let _e666 = nPos_5;
                                        param_506 = _e666;
                                        let _e667 = getIndex_u0028_vi3_u003b((&param_506));
                                        param_507 = _e667;
                                        let _e668 = readCell_u0028_u1_u003b((&param_507));
                                        param_508 = _e668;
                                        let _e669 = getType_u0028_u1_u003b((&param_508));
                                        if (_e669 == 4u) {
                                            let _e671 = clumpCount;
                                            clumpCount = (_e671 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e673 = z_1;
                                    z_1 = (_e673 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e675 = y;
                            y = (_e675 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e677 = x_1;
                    x_1 = (_e677 + 1i);
                }
            }
            let _e679 = clumpCount;
            let _e681 = tuning.dirtClumpThreshold;
            if (_e679 >= bitcast<i32>(_e681)) {
                isClumped = true;
            }
        }
    }
    let _e684 = canMove;
    let _e685 = isClumped;
    if (_e684 && !(_e685)) {
        let _e689 = (*pos_13)[1u];
        if (_e689 > 1i) {
            let _e691 = (*pos_13);
            belowPos_5 = (_e691 + vec3<i32>(0i, -1i, 0i));
            let _e693 = belowPos_5;
            param_509 = _e693;
            let _e694 = getIndex_u0028_vi3_u003b((&param_509));
            param_510 = _e694;
            let _e695 = readCell_u0028_u1_u003b((&param_510));
            param_511 = _e695;
            let _e696 = getType_u0028_u1_u003b((&param_511));
            if (_e696 == 0u) {
                let _e698 = belowPos_5;
                param_512 = _e698;
                let _e699 = getIndex_u0028_vi3_u003b((&param_512));
                param_513 = 4u;
                param_514 = 0u;
                param_515 = 0u;
                let _e700 = moisture_4;
                param_516 = _e700;
                let _e701 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_513), (&param_514), (&param_515), (&param_516));
                let _e702 = (*currentIndex_9);
                param_517 = _e702;
                let _e703 = (*rawValue_7);
                param_518 = _e703;
                param_519 = _e699;
                param_520 = _e701;
                let _e704 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_517), (&param_518), (&param_519), (&param_520));
                if _e704 {
                    return;
                }
            }
        }
        let _e706 = (*pos_13)[1u];
        if (_e706 > 1i) {
            let _e708 = (*randVal_9);
            dir_2 = select(-1i, 1i, (fract((_e708 * 10f)) > 0.5f));
            let _e713 = (*randVal_9);
            if (fract((_e713 * 100f)) > 0.5f) {
                let _e717 = (*pos_13);
                let _e718 = dir_2;
                slidePos1_ = (_e717 + vec3<i32>(_e718, -1i, 0i));
                let _e721 = (*pos_13);
                let _e722 = dir_2;
                slidePos2_ = (_e721 + vec3<i32>(0i, -1i, _e722));
            } else {
                let _e725 = (*pos_13);
                let _e726 = dir_2;
                slidePos1_ = (_e725 + vec3<i32>(0i, -1i, _e726));
                let _e729 = (*pos_13);
                let _e730 = dir_2;
                slidePos2_ = (_e729 + vec3<i32>(_e730, -1i, 0i));
            }
            let _e734 = slidePos1_[0u];
            let _e735 = (_e734 > 0i);
            phi_3962_ = _e735;
            if _e735 {
                let _e737 = slidePos1_[0u];
                let _e739 = tuning.gridWidth;
                phi_3962_ = (_e737 < (bitcast<i32>(_e739) - 1i));
            }
            let _e744 = phi_3962_;
            phi_3968_ = _e744;
            if _e744 {
                let _e746 = slidePos1_[2u];
                phi_3968_ = (_e746 > 0i);
            }
            let _e749 = phi_3968_;
            phi_3978_ = _e749;
            if _e749 {
                let _e751 = slidePos1_[2u];
                let _e753 = tuning.gridDepth;
                phi_3978_ = (_e751 < (bitcast<i32>(_e753) - 1i));
            }
            let _e758 = phi_3978_;
            if _e758 {
                let _e759 = slidePos1_;
                param_521 = _e759;
                let _e760 = getIndex_u0028_vi3_u003b((&param_521));
                param_522 = _e760;
                let _e761 = readCell_u0028_u1_u003b((&param_522));
                param_523 = _e761;
                let _e762 = getType_u0028_u1_u003b((&param_523));
                if (_e762 == 0u) {
                    let _e764 = slidePos1_;
                    param_524 = _e764;
                    let _e765 = getIndex_u0028_vi3_u003b((&param_524));
                    param_525 = 4u;
                    param_526 = 0u;
                    param_527 = 0u;
                    let _e766 = moisture_4;
                    param_528 = _e766;
                    let _e767 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_525), (&param_526), (&param_527), (&param_528));
                    let _e768 = (*currentIndex_9);
                    param_529 = _e768;
                    let _e769 = (*rawValue_7);
                    param_530 = _e769;
                    param_531 = _e765;
                    param_532 = _e767;
                    let _e770 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_529), (&param_530), (&param_531), (&param_532));
                    if _e770 {
                        return;
                    }
                }
            }
            let _e772 = slidePos2_[0u];
            let _e773 = (_e772 > 0i);
            phi_4022_ = _e773;
            if _e773 {
                let _e775 = slidePos2_[0u];
                let _e777 = tuning.gridWidth;
                phi_4022_ = (_e775 < (bitcast<i32>(_e777) - 1i));
            }
            let _e782 = phi_4022_;
            phi_4028_ = _e782;
            if _e782 {
                let _e784 = slidePos2_[2u];
                phi_4028_ = (_e784 > 0i);
            }
            let _e787 = phi_4028_;
            phi_4038_ = _e787;
            if _e787 {
                let _e789 = slidePos2_[2u];
                let _e791 = tuning.gridDepth;
                phi_4038_ = (_e789 < (bitcast<i32>(_e791) - 1i));
            }
            let _e796 = phi_4038_;
            if _e796 {
                let _e797 = slidePos2_;
                param_533 = _e797;
                let _e798 = getIndex_u0028_vi3_u003b((&param_533));
                param_534 = _e798;
                let _e799 = readCell_u0028_u1_u003b((&param_534));
                param_535 = _e799;
                let _e800 = getType_u0028_u1_u003b((&param_535));
                if (_e800 == 0u) {
                    let _e802 = slidePos2_;
                    param_536 = _e802;
                    let _e803 = getIndex_u0028_vi3_u003b((&param_536));
                    param_537 = 4u;
                    param_538 = 0u;
                    param_539 = 0u;
                    let _e804 = moisture_4;
                    param_540 = _e804;
                    let _e805 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_537), (&param_538), (&param_539), (&param_540));
                    let _e806 = (*currentIndex_9);
                    param_541 = _e806;
                    let _e807 = (*rawValue_7);
                    param_542 = _e807;
                    param_543 = _e803;
                    param_544 = _e805;
                    let _e808 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_541), (&param_542), (&param_543), (&param_544));
                    if _e808 {
                        return;
                    }
                }
            }
        }
        let _e810 = (*pos_13)[1u];
        if (_e810 > 1i) {
            let _e812 = (*pos_13);
            belowPos_6 = (_e812 + vec3<i32>(0i, -1i, 0i));
            let _e814 = belowPos_6;
            param_545 = _e814;
            let _e815 = getIndex_u0028_vi3_u003b((&param_545));
            belowIndex_2 = _e815;
            let _e816 = belowIndex_2;
            param_546 = _e816;
            let _e817 = readCell_u0028_u1_u003b((&param_546));
            belowValue_2 = _e817;
            let _e818 = belowValue_2;
            param_547 = _e818;
            let _e819 = getType_u0028_u1_u003b((&param_547));
            if (_e819 == 2u) {
                let _e821 = (*randVal_9);
                startDir_2 = i32((fract((_e821 * 8f)) * 8f));
                i_17 = 0i;
                loop {
                    let _e826 = i_17;
                    if (_e826 < 8i) {
                        let _e828 = startDir_2;
                        let _e829 = i_17;
                        let _e830 = (_e828 + _e829);
                        d_13 = (_e830 - (i32(floor((f32(_e830) / f32(8i)))) * 8i));
                        let _e838 = belowPos_6;
                        let _e839 = d_13;
                        param_548 = _e839;
                        let _e840 = getHDir_u0028_i1_u003b((&param_548));
                        pushPos = (_e838 + _e840);
                        let _e843 = pushPos[0u];
                        let _e844 = (_e843 > 0i);
                        phi_4129_ = _e844;
                        if _e844 {
                            let _e846 = pushPos[0u];
                            let _e848 = tuning.gridWidth;
                            phi_4129_ = (_e846 < (bitcast<i32>(_e848) - 1i));
                        }
                        let _e853 = phi_4129_;
                        phi_4135_ = _e853;
                        if _e853 {
                            let _e855 = pushPos[2u];
                            phi_4135_ = (_e855 > 0i);
                        }
                        let _e858 = phi_4135_;
                        phi_4145_ = _e858;
                        if _e858 {
                            let _e860 = pushPos[2u];
                            let _e862 = tuning.gridDepth;
                            phi_4145_ = (_e860 < (bitcast<i32>(_e862) - 1i));
                        }
                        let _e867 = phi_4145_;
                        if _e867 {
                            param_549 = 4u;
                            param_550 = 0u;
                            param_551 = 0u;
                            let _e868 = moisture_4;
                            param_552 = _e868;
                            let _e869 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_549), (&param_550), (&param_551), (&param_552));
                            let _e870 = pushPos;
                            param_553 = _e870;
                            let _e871 = getIndex_u0028_vi3_u003b((&param_553));
                            let _e872 = (*currentIndex_9);
                            param_554 = _e872;
                            param_555 = _e869;
                            let _e873 = belowIndex_2;
                            param_556 = _e873;
                            let _e874 = belowValue_2;
                            param_557 = _e874;
                            param_558 = _e871;
                            let _e875 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_554), (&param_555), (&param_556), (&param_557), (&param_558));
                            if _e875 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e876 = i_17;
                        i_17 = (_e876 + 1i);
                    }
                }
                param_559 = 4u;
                param_560 = 0u;
                param_561 = 0u;
                let _e878 = moisture_4;
                param_562 = _e878;
                let _e879 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_559), (&param_560), (&param_561), (&param_562));
                let _e880 = (*currentIndex_9);
                param_563 = _e880;
                let _e881 = (*rawValue_7);
                param_564 = _e881;
                let _e882 = belowIndex_2;
                param_565 = _e882;
                param_566 = _e879;
                let _e883 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_563), (&param_564), (&param_565), (&param_566));
                if _e883 {
                    return;
                }
            }
            let _e884 = (*randVal_9);
            dir_3 = select(-1i, 1i, (fract((_e884 * 10f)) > 0.5f));
            let _e889 = (*randVal_9);
            if (fract((_e889 * 100f)) > 0.5f) {
                let _e893 = (*pos_13);
                let _e894 = dir_3;
                slidePos[0i] = (_e893 + vec3<i32>(_e894, -1i, 0i));
                let _e898 = (*pos_13);
                let _e899 = dir_3;
                slidePos[1i] = (_e898 + vec3<i32>(0i, -1i, _e899));
            } else {
                let _e903 = (*pos_13);
                let _e904 = dir_3;
                slidePos[0i] = (_e903 + vec3<i32>(0i, -1i, _e904));
                let _e908 = (*pos_13);
                let _e909 = dir_3;
                slidePos[1i] = (_e908 + vec3<i32>(_e909, -1i, 0i));
            }
            s_1 = 0i;
            loop {
                let _e913 = s_1;
                if (_e913 < 2i) {
                    let _e915 = s_1;
                    let _e917 = slidePos[_e915];
                    sPos_2 = _e917;
                    let _e919 = sPos_2[0u];
                    let _e920 = (_e919 > 0i);
                    phi_4246_ = _e920;
                    if _e920 {
                        let _e922 = sPos_2[0u];
                        let _e924 = tuning.gridWidth;
                        phi_4246_ = (_e922 < (bitcast<i32>(_e924) - 1i));
                    }
                    let _e929 = phi_4246_;
                    phi_4252_ = _e929;
                    if _e929 {
                        let _e931 = sPos_2[2u];
                        phi_4252_ = (_e931 > 0i);
                    }
                    let _e934 = phi_4252_;
                    phi_4262_ = _e934;
                    if _e934 {
                        let _e936 = sPos_2[2u];
                        let _e938 = tuning.gridDepth;
                        phi_4262_ = (_e936 < (bitcast<i32>(_e938) - 1i));
                    }
                    let _e943 = phi_4262_;
                    if _e943 {
                        let _e944 = sPos_2;
                        param_567 = _e944;
                        let _e945 = getIndex_u0028_vi3_u003b((&param_567));
                        sIndex = _e945;
                        let _e946 = sIndex;
                        param_568 = _e946;
                        let _e947 = readCell_u0028_u1_u003b((&param_568));
                        sValue = _e947;
                        let _e948 = sValue;
                        param_569 = _e948;
                        let _e949 = getType_u0028_u1_u003b((&param_569));
                        if (_e949 == 2u) {
                            let _e951 = (*randVal_9);
                            let _e953 = s_1;
                            startDir_3 = i32((fract(((_e951 * 8f) + f32(_e953))) * 8f));
                            i_18 = 0i;
                            loop {
                                let _e959 = i_18;
                                if (_e959 < 8i) {
                                    let _e961 = startDir_3;
                                    let _e962 = i_18;
                                    let _e963 = (_e961 + _e962);
                                    d_14 = (_e963 - (i32(floor((f32(_e963) / f32(8i)))) * 8i));
                                    let _e971 = sPos_2;
                                    let _e972 = d_14;
                                    param_570 = _e972;
                                    let _e973 = getHDir_u0028_i1_u003b((&param_570));
                                    pushPos_1 = (_e971 + _e973);
                                    let _e976 = pushPos_1[0u];
                                    let _e977 = (_e976 > 0i);
                                    phi_4319_ = _e977;
                                    if _e977 {
                                        let _e979 = pushPos_1[0u];
                                        let _e981 = tuning.gridWidth;
                                        phi_4319_ = (_e979 < (bitcast<i32>(_e981) - 1i));
                                    }
                                    let _e986 = phi_4319_;
                                    phi_4325_ = _e986;
                                    if _e986 {
                                        let _e988 = pushPos_1[2u];
                                        phi_4325_ = (_e988 > 0i);
                                    }
                                    let _e991 = phi_4325_;
                                    phi_4335_ = _e991;
                                    if _e991 {
                                        let _e993 = pushPos_1[2u];
                                        let _e995 = tuning.gridDepth;
                                        phi_4335_ = (_e993 < (bitcast<i32>(_e995) - 1i));
                                    }
                                    let _e1000 = phi_4335_;
                                    if _e1000 {
                                        param_571 = 4u;
                                        param_572 = 0u;
                                        param_573 = 0u;
                                        let _e1001 = moisture_4;
                                        param_574 = _e1001;
                                        let _e1002 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_571), (&param_572), (&param_573), (&param_574));
                                        let _e1003 = pushPos_1;
                                        param_575 = _e1003;
                                        let _e1004 = getIndex_u0028_vi3_u003b((&param_575));
                                        let _e1005 = (*currentIndex_9);
                                        param_576 = _e1005;
                                        param_577 = _e1002;
                                        let _e1006 = sIndex;
                                        param_578 = _e1006;
                                        let _e1007 = sValue;
                                        param_579 = _e1007;
                                        param_580 = _e1004;
                                        let _e1008 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_576), (&param_577), (&param_578), (&param_579), (&param_580));
                                        if _e1008 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1009 = i_18;
                                    i_18 = (_e1009 + 1i);
                                }
                            }
                            param_581 = 4u;
                            param_582 = 0u;
                            param_583 = 0u;
                            let _e1011 = moisture_4;
                            param_584 = _e1011;
                            let _e1012 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_581), (&param_582), (&param_583), (&param_584));
                            let _e1013 = (*currentIndex_9);
                            param_585 = _e1013;
                            let _e1014 = (*rawValue_7);
                            param_586 = _e1014;
                            let _e1015 = sIndex;
                            param_587 = _e1015;
                            param_588 = _e1012;
                            let _e1016 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_585), (&param_586), (&param_587), (&param_588));
                            if _e1016 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1017 = s_1;
                    s_1 = (_e1017 + 1i);
                }
            }
        }
    }
    let _e1019 = (*currentDir_4);
    floraState = _e1019;
    let _e1020 = isClumped;
    phi_4390_ = _e1020;
    if !(_e1020) {
        let _e1022 = (*currentSleep_4);
        let _e1024 = tuning.wakeSleepThreshold;
        phi_4390_ = (_e1022 > _e1024);
    }
    let _e1027 = phi_4390_;
    if _e1027 {
        let _e1028 = (*pos_13);
        abovePos_1 = (_e1028 + vec3<i32>(0i, 1i, 0i));
        let _e1031 = abovePos_1[1u];
        let _e1033 = tuning.gridHeight;
        aboveInside = (_e1031 < (bitcast<i32>(_e1033) - 1i));
        let _e1037 = abovePos_1;
        param_589 = _e1037;
        let _e1038 = getIndex_u0028_vi3_u003b((&param_589));
        aboveIndex = _e1038;
        let _e1039 = aboveInside;
        if _e1039 {
            let _e1040 = aboveIndex;
            param_590 = _e1040;
            let _e1041 = readCell_u0028_u1_u003b((&param_590));
            param_591 = _e1041;
            let _e1042 = getType_u0028_u1_u003b((&param_591));
            local_21 = _e1042;
        } else {
            local_21 = 0u;
        }
        let _e1043 = local_21;
        aboveType = _e1043;
        let _e1044 = aboveType;
        let _e1046 = aboveType;
        if ((_e1044 == 0u) || (_e1046 == 18u)) {
            let _e1049 = moisture_4;
            let _e1051 = floraState;
            if ((_e1049 >= 5u) && (_e1051 < 100u)) {
                let _e1054 = (*randVal_9);
                let _e1058 = tuning.grassGrowChance;
                if (fract((_e1054 * 55f)) < _e1058) {
                    let _e1060 = floraState;
                    floraState = (_e1060 + bitcast<u32>(1i));
                    let _e1063 = floraState;
                    let _e1065 = aboveType;
                    let _e1068 = aboveInside;
                    let _e1069 = (((_e1063 == 100u) && (_e1065 == 0u)) && _e1068);
                    phi_4464_ = _e1069;
                    if _e1069 {
                        let _e1070 = (*randVal_9);
                        let _e1074 = tuning.treeBloomChance;
                        phi_4464_ = (fract((_e1070 * 97f)) < _e1074);
                    }
                    let _e1077 = phi_4464_;
                    if _e1077 {
                        let _e1078 = aboveIndex;
                        param_592 = 18u;
                        param_593 = 0u;
                        param_594 = 0u;
                        param_595 = 0u;
                        let _e1081 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_592), (&param_593), (&param_594), (&param_595));
                        let _e1082 = atomicCompareExchangeWeak((&unnamed.grid[_e1078]), 0u, _e1081);
                    }
                }
            }
            let _e1084 = floraState;
            if (_e1084 > 100u) {
                floraState = 100u;
            }
        } else {
            let _e1086 = aboveType;
            if (_e1086 == 2u) {
                let _e1088 = floraState;
                if (_e1088 > 0u) {
                    let _e1090 = floraState;
                    if (_e1090 <= 100u) {
                        floraState = 101u;
                    }
                    let _e1092 = (*randVal_9);
                    let _e1096 = tuning.grassSubmergedDecayChance;
                    if (fract((_e1092 * 66f)) < _e1096) {
                        let _e1098 = floraState;
                        floraState = (_e1098 + bitcast<u32>(1i));
                    }
                    let _e1101 = floraState;
                    if (_e1101 >= 200u) {
                        floraState = 0u;
                    }
                }
            } else {
                let _e1103 = aboveType;
                let _e1104 = (_e1103 != 5u);
                phi_4519_ = _e1104;
                if _e1104 {
                    let _e1105 = aboveType;
                    param_596 = _e1105;
                    let _e1106 = isLocust_u0028_u1_u003b((&param_596));
                    phi_4519_ = !(_e1106);
                }
                let _e1109 = phi_4519_;
                if _e1109 {
                    floraState = 0u;
                }
            }
        }
    }
    let _e1110 = (*currentSleep_4);
    newSleep_2 = min((_e1110 + 1u), 255u);
    let _e1113 = (*currentIndex_9);
    let _e1116 = (*rawValue_7);
    param_597 = 4u;
    let _e1117 = floraState;
    param_598 = _e1117;
    let _e1118 = newSleep_2;
    param_599 = _e1118;
    let _e1119 = moisture_4;
    param_600 = _e1119;
    let _e1120 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_597), (&param_598), (&param_599), (&param_600));
    let _e1121 = atomicCompareExchangeWeak((&unnamed.grid[_e1113]), _e1116, _e1120);
    return;
}

fn updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_14: ptr<function, vec3<i32>>, currentIndex_10: ptr<function, u32>, rawValue_8: ptr<function, u32>, currentDir_5: ptr<function, u32>, currentSleep_5: ptr<function, u32>, currentAge_8: ptr<function, u32>, randVal_10: ptr<function, f32>) {
    var wake: bool;
    var param_601: vec3<i32>;
    var param_602: u32;
    var param_603: u32;
    var hasPressure_1: bool;
    var local_22: bool;
    var param_604: vec3<i32>;
    var param_605: u32;
    var param_606: u32;
    var isStackedOnWater: bool;
    var local_23: bool;
    var param_607: vec3<i32>;
    var param_608: u32;
    var param_609: u32;
    var d_15: i32;
    var nPos_6: vec3<i32>;
    var param_610: i32;
    var param_611: vec3<i32>;
    var param_612: u32;
    var param_613: u32;
    var belowNeighbor: u32;
    var param_614: vec3<i32>;
    var param_615: u32;
    var param_616: u32;
    var newAge_2: u32;
    var belowPos_7: vec3<i32>;
    var param_617: vec3<i32>;
    var param_618: u32;
    var param_619: u32;
    var param_620: vec3<i32>;
    var param_621: u32;
    var param_622: u32;
    var param_623: u32;
    var param_624: u32;
    var param_625: u32;
    var param_626: u32;
    var param_627: u32;
    var param_628: u32;
    var newDir: u32;
    var r_1: f32;
    var diagDir: u32;
    var r_2: f32;
    var stepPos: vec3<i32>;
    var param_629: i32;
    var param_630: vec3<i32>;
    var param_631: u32;
    var param_632: u32;
    var newValue_1: u32;
    var param_633: u32;
    var param_634: u32;
    var param_635: u32;
    var param_636: u32;
    var param_637: vec3<i32>;
    var param_638: u32;
    var param_639: u32;
    var param_640: u32;
    var param_641: u32;
    var bestDropPos: vec3<i32>;
    var foundDrop: bool;
    var blockedMask_1: u32;
    var startDir_4: i32;
    var waterReach: i32;
    var r_3: i32;
    var i_19: i32;
    var d_16: i32;
    var c_7: vec3<i32>;
    var param_642: i32;
    var param_643: vec3<i32>;
    var param_644: u32;
    var param_645: u32;
    var param_646: vec3<i32>;
    var param_647: u32;
    var param_648: u32;
    var newValue_2: u32;
    var param_649: u32;
    var param_650: u32;
    var param_651: u32;
    var param_652: u32;
    var param_653: vec3<i32>;
    var param_654: u32;
    var param_655: u32;
    var param_656: u32;
    var param_657: u32;
    var hasPressure_2: bool;
    var local_24: bool;
    var param_658: vec3<i32>;
    var param_659: u32;
    var param_660: u32;
    var isStackedOnWater_1: bool;
    var local_25: bool;
    var param_661: vec3<i32>;
    var param_662: u32;
    var param_663: u32;
    var canStepOntoPool: bool;
    var d_17: i32;
    var nPos_7: vec3<i32>;
    var param_664: i32;
    var param_665: vec3<i32>;
    var param_666: u32;
    var param_667: u32;
    var param_668: vec3<i32>;
    var param_669: u32;
    var param_670: u32;
    var startSpreadDir: i32;
    var i_20: i32;
    var d_18: i32;
    var targetPos_2: vec3<i32>;
    var param_671: i32;
    var param_672: vec3<i32>;
    var param_673: u32;
    var param_674: u32;
    var newValue_3: u32;
    var param_675: u32;
    var param_676: u32;
    var param_677: u32;
    var param_678: u32;
    var param_679: vec3<i32>;
    var param_680: u32;
    var param_681: u32;
    var param_682: u32;
    var param_683: u32;
    var newSleep_3: u32;
    var sleepValue: u32;
    var param_684: u32;
    var param_685: u32;
    var param_686: u32;
    var param_687: u32;
    var phi_4559_: bool;
    var phi_4629_: bool;
    var phi_4635_: bool;
    var phi_4645_: bool;
    var phi_4831_: bool;
    var phi_4837_: bool;
    var phi_4847_: bool;
    var phi_4962_: bool;
    var phi_4969_: bool;
    var phi_4980_: bool;
    var phi_4992_: bool;
    var phi_5014_: bool;
    var phi_5118_: bool;
    var phi_5124_: bool;
    var phi_5134_: bool;
    var phi_5150_: bool;
    var phi_5162_: bool;
    var phi_5212_: bool;
    var phi_5218_: bool;
    var phi_5228_: bool;

    let _e330 = (*currentSleep_5);
    let _e332 = tuning.wakeSleepThreshold;
    if (_e330 > _e332) {
        wake = false;
        let _e335 = (*pos_14)[1u];
        let _e336 = (_e335 > 1i);
        phi_4559_ = _e336;
        if _e336 {
            let _e337 = (*pos_14);
            param_601 = (_e337 + vec3<i32>(0i, -1i, 0i));
            let _e339 = getIndex_u0028_vi3_u003b((&param_601));
            param_602 = _e339;
            let _e340 = readCell_u0028_u1_u003b((&param_602));
            param_603 = _e340;
            let _e341 = getType_u0028_u1_u003b((&param_603));
            phi_4559_ = (_e341 == 0u);
        }
        let _e344 = phi_4559_;
        if _e344 {
            wake = true;
        } else {
            let _e346 = (*pos_14)[1u];
            let _e348 = tuning.gridHeight;
            if (_e346 < (bitcast<i32>(_e348) - 2i)) {
                let _e352 = (*pos_14);
                param_604 = (_e352 + vec3<i32>(0i, 1i, 0i));
                let _e354 = getIndex_u0028_vi3_u003b((&param_604));
                param_605 = _e354;
                let _e355 = readCell_u0028_u1_u003b((&param_605));
                param_606 = _e355;
                let _e356 = getType_u0028_u1_u003b((&param_606));
                local_22 = (_e356 != 0u);
            } else {
                local_22 = false;
            }
            let _e358 = local_22;
            hasPressure_1 = _e358;
            let _e360 = (*pos_14)[1u];
            if (_e360 > 1i) {
                let _e362 = (*pos_14);
                param_607 = (_e362 + vec3<i32>(0i, -1i, 0i));
                let _e364 = getIndex_u0028_vi3_u003b((&param_607));
                param_608 = _e364;
                let _e365 = readCell_u0028_u1_u003b((&param_608));
                param_609 = _e365;
                let _e366 = getType_u0028_u1_u003b((&param_609));
                local_23 = (_e366 == 2u);
            } else {
                local_23 = false;
            }
            let _e368 = local_23;
            isStackedOnWater = _e368;
            d_15 = 0i;
            loop {
                let _e369 = d_15;
                if (_e369 < 8i) {
                    let _e371 = (*pos_14);
                    let _e372 = d_15;
                    param_610 = _e372;
                    let _e373 = getHDir_u0028_i1_u003b((&param_610));
                    nPos_6 = (_e371 + _e373);
                    let _e376 = nPos_6[0u];
                    let _e377 = (_e376 > 0i);
                    phi_4629_ = _e377;
                    if _e377 {
                        let _e379 = nPos_6[0u];
                        let _e381 = tuning.gridWidth;
                        phi_4629_ = (_e379 < (bitcast<i32>(_e381) - 1i));
                    }
                    let _e386 = phi_4629_;
                    phi_4635_ = _e386;
                    if _e386 {
                        let _e388 = nPos_6[2u];
                        phi_4635_ = (_e388 > 0i);
                    }
                    let _e391 = phi_4635_;
                    phi_4645_ = _e391;
                    if _e391 {
                        let _e393 = nPos_6[2u];
                        let _e395 = tuning.gridDepth;
                        phi_4645_ = (_e393 < (bitcast<i32>(_e395) - 1i));
                    }
                    let _e400 = phi_4645_;
                    if _e400 {
                        let _e401 = nPos_6;
                        param_611 = _e401;
                        let _e402 = getIndex_u0028_vi3_u003b((&param_611));
                        param_612 = _e402;
                        let _e403 = readCell_u0028_u1_u003b((&param_612));
                        param_613 = _e403;
                        let _e404 = getType_u0028_u1_u003b((&param_613));
                        if (_e404 == 0u) {
                            let _e406 = nPos_6;
                            param_614 = (_e406 + vec3<i32>(0i, -1i, 0i));
                            let _e408 = getIndex_u0028_vi3_u003b((&param_614));
                            param_615 = _e408;
                            let _e409 = readCell_u0028_u1_u003b((&param_615));
                            param_616 = _e409;
                            let _e410 = getType_u0028_u1_u003b((&param_616));
                            belowNeighbor = _e410;
                            let _e411 = belowNeighbor;
                            let _e413 = hasPressure_1;
                            let _e415 = isStackedOnWater;
                            let _e417 = belowNeighbor;
                            if ((((_e411 == 0u) || _e413) || _e415) || (_e417 == 2u)) {
                                wake = true;
                                break;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e420 = d_15;
                    d_15 = (_e420 + 1i);
                }
            }
        }
        let _e422 = wake;
        if !(_e422) {
            return;
        }
        (*currentSleep_5) = 0u;
        (*currentAge_8) = 0u;
    }
    let _e424 = (*currentAge_8);
    newAge_2 = (_e424 + 1u);
    let _e427 = (*pos_14)[1u];
    if (_e427 > 1i) {
        let _e429 = (*pos_14);
        belowPos_7 = (_e429 + vec3<i32>(0i, -1i, 0i));
        let _e431 = belowPos_7;
        param_617 = _e431;
        let _e432 = getIndex_u0028_vi3_u003b((&param_617));
        param_618 = _e432;
        let _e433 = readCell_u0028_u1_u003b((&param_618));
        param_619 = _e433;
        let _e434 = getType_u0028_u1_u003b((&param_619));
        if (_e434 == 0u) {
            let _e436 = belowPos_7;
            param_620 = _e436;
            let _e437 = getIndex_u0028_vi3_u003b((&param_620));
            param_621 = 2u;
            param_622 = 0u;
            param_623 = 0u;
            let _e438 = newAge_2;
            param_624 = _e438;
            let _e439 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_621), (&param_622), (&param_623), (&param_624));
            let _e440 = (*currentIndex_10);
            param_625 = _e440;
            let _e441 = (*rawValue_8);
            param_626 = _e441;
            param_627 = _e437;
            param_628 = _e439;
            let _e442 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_625), (&param_626), (&param_627), (&param_628));
            if _e442 {
                return;
            }
        }
    }
    let _e443 = (*currentDir_5);
    newDir = _e443;
    let _e444 = newDir;
    let _e446 = newDir;
    if ((_e444 == 0u) || (_e446 == 9u)) {
        let _e449 = (*randVal_10);
        r_1 = fract((_e449 * 77f));
        let _e452 = r_1;
        if (_e452 < 0.25f) {
            newDir = 1u;
        } else {
            let _e454 = r_1;
            if (_e454 < 0.5f) {
                newDir = 2u;
            } else {
                let _e456 = r_1;
                if (_e456 < 0.75f) {
                    newDir = 3u;
                } else {
                    newDir = 4u;
                }
            }
        }
    }
    let _e458 = newAge_2;
    let _e461 = newAge_2;
    if (((_e458 % 3u) == 0u) && (_e461 > 0u)) {
        let _e464 = newDir;
        diagDir = _e464;
        let _e465 = diagDir;
        let _e467 = diagDir;
        if ((_e465 >= 1u) && (_e467 <= 4u)) {
            let _e470 = (*randVal_10);
            r_2 = fract((_e470 * 133f));
            let _e473 = diagDir;
            if (_e473 == 1u) {
                let _e475 = r_2;
                diagDir = select(6u, 5u, (_e475 > 0.5f));
            } else {
                let _e478 = diagDir;
                if (_e478 == 2u) {
                    let _e480 = r_2;
                    diagDir = select(8u, 7u, (_e480 > 0.5f));
                } else {
                    let _e483 = diagDir;
                    if (_e483 == 3u) {
                        let _e485 = r_2;
                        diagDir = select(7u, 5u, (_e485 > 0.5f));
                    } else {
                        let _e488 = diagDir;
                        if (_e488 == 4u) {
                            let _e490 = r_2;
                            diagDir = select(8u, 6u, (_e490 > 0.5f));
                        }
                    }
                }
            }
        }
        let _e493 = (*pos_14);
        let _e494 = diagDir;
        param_629 = (bitcast<i32>(_e494) - 1i);
        let _e497 = getHDir_u0028_i1_u003b((&param_629));
        stepPos = (_e493 + _e497);
        let _e500 = stepPos[0u];
        let _e501 = (_e500 > 0i);
        phi_4831_ = _e501;
        if _e501 {
            let _e503 = stepPos[0u];
            let _e505 = tuning.gridWidth;
            phi_4831_ = (_e503 < (bitcast<i32>(_e505) - 1i));
        }
        let _e510 = phi_4831_;
        phi_4837_ = _e510;
        if _e510 {
            let _e512 = stepPos[2u];
            phi_4837_ = (_e512 > 0i);
        }
        let _e515 = phi_4837_;
        phi_4847_ = _e515;
        if _e515 {
            let _e517 = stepPos[2u];
            let _e519 = tuning.gridDepth;
            phi_4847_ = (_e517 < (bitcast<i32>(_e519) - 1i));
        }
        let _e524 = phi_4847_;
        if _e524 {
            let _e525 = stepPos;
            param_630 = _e525;
            let _e526 = getIndex_u0028_vi3_u003b((&param_630));
            param_631 = _e526;
            let _e527 = readCell_u0028_u1_u003b((&param_631));
            param_632 = _e527;
            let _e528 = getType_u0028_u1_u003b((&param_632));
            if (_e528 == 0u) {
                param_633 = 2u;
                let _e530 = newDir;
                param_634 = _e530;
                param_635 = 0u;
                let _e531 = newAge_2;
                param_636 = _e531;
                let _e532 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_633), (&param_634), (&param_635), (&param_636));
                newValue_1 = _e532;
                let _e533 = stepPos;
                param_637 = _e533;
                let _e534 = getIndex_u0028_vi3_u003b((&param_637));
                let _e535 = (*currentIndex_10);
                param_638 = _e535;
                let _e536 = (*rawValue_8);
                param_639 = _e536;
                param_640 = _e534;
                let _e537 = newValue_1;
                param_641 = _e537;
                let _e538 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_638), (&param_639), (&param_640), (&param_641));
                if _e538 {
                    return;
                }
            }
        }
    }
    let _e539 = (*pos_14);
    bestDropPos = _e539;
    foundDrop = false;
    blockedMask_1 = 0u;
    let _e540 = (*randVal_10);
    startDir_4 = i32((fract((_e540 * 8f)) * 8f));
    let _e546 = tuning.waterSpreadRadius;
    let _e548 = tuning.gridWidth;
    let _e551 = tuning.gridHeight;
    waterReach = bitcast<i32>(clamp(_e546, 1u, bitcast<u32>(max(bitcast<i32>(_e548), bitcast<i32>(_e551)))));
    r_3 = 1i;
    loop {
        let _e557 = r_3;
        let _e558 = waterReach;
        if (_e557 <= _e558) {
            let _e560 = blockedMask_1;
            if (_e560 == 255u) {
                break;
            }
            i_19 = 0i;
            loop {
                let _e562 = i_19;
                if (_e562 < 8i) {
                    let _e564 = startDir_4;
                    let _e565 = i_19;
                    let _e566 = (_e564 + _e565);
                    d_16 = (_e566 - (i32(floor((f32(_e566) / f32(8i)))) * 8i));
                    let _e574 = blockedMask_1;
                    let _e575 = d_16;
                    if ((_e574 & (1u << bitcast<u32>(_e575))) == 0u) {
                        let _e580 = (*pos_14);
                        let _e581 = d_16;
                        param_642 = _e581;
                        let _e582 = getHDir_u0028_i1_u003b((&param_642));
                        let _e583 = r_3;
                        c_7 = (_e580 + (_e582 * vec3(_e583)));
                        let _e588 = c_7[0u];
                        let _e589 = (_e588 <= 0i);
                        phi_4962_ = _e589;
                        if !(_e589) {
                            let _e592 = c_7[0u];
                            let _e594 = tuning.gridWidth;
                            phi_4962_ = (_e592 >= (bitcast<i32>(_e594) - 1i));
                        }
                        let _e599 = phi_4962_;
                        phi_4969_ = _e599;
                        if !(_e599) {
                            let _e602 = c_7[2u];
                            phi_4969_ = (_e602 <= 0i);
                        }
                        let _e605 = phi_4969_;
                        phi_4980_ = _e605;
                        if !(_e605) {
                            let _e608 = c_7[2u];
                            let _e610 = tuning.gridDepth;
                            phi_4980_ = (_e608 >= (bitcast<i32>(_e610) - 1i));
                        }
                        let _e615 = phi_4980_;
                        phi_4992_ = _e615;
                        if !(_e615) {
                            let _e617 = c_7;
                            param_643 = _e617;
                            let _e618 = getIndex_u0028_vi3_u003b((&param_643));
                            param_644 = _e618;
                            let _e619 = readCell_u0028_u1_u003b((&param_644));
                            param_645 = _e619;
                            let _e620 = getType_u0028_u1_u003b((&param_645));
                            phi_4992_ = (_e620 != 0u);
                        }
                        let _e623 = phi_4992_;
                        if _e623 {
                            let _e624 = d_16;
                            let _e627 = blockedMask_1;
                            blockedMask_1 = (_e627 | (1u << bitcast<u32>(_e624)));
                        } else {
                            let _e630 = c_7[1u];
                            let _e631 = (_e630 > 1i);
                            phi_5014_ = _e631;
                            if _e631 {
                                let _e632 = c_7;
                                param_646 = (_e632 + vec3<i32>(0i, -1i, 0i));
                                let _e634 = getIndex_u0028_vi3_u003b((&param_646));
                                param_647 = _e634;
                                let _e635 = readCell_u0028_u1_u003b((&param_647));
                                param_648 = _e635;
                                let _e636 = getType_u0028_u1_u003b((&param_648));
                                phi_5014_ = (_e636 == 0u);
                            }
                            let _e639 = phi_5014_;
                            if _e639 {
                                let _e640 = c_7;
                                bestDropPos = _e640;
                                foundDrop = true;
                                break;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e641 = i_19;
                    i_19 = (_e641 + 1i);
                }
            }
            let _e643 = foundDrop;
            if _e643 {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e644 = r_3;
            r_3 = (_e644 + 1i);
        }
    }
    let _e646 = foundDrop;
    if _e646 {
        param_649 = 2u;
        param_650 = 0u;
        param_651 = 0u;
        param_652 = 0u;
        let _e647 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_649), (&param_650), (&param_651), (&param_652));
        newValue_2 = _e647;
        let _e648 = bestDropPos;
        param_653 = _e648;
        let _e649 = getIndex_u0028_vi3_u003b((&param_653));
        let _e650 = (*currentIndex_10);
        param_654 = _e650;
        let _e651 = (*rawValue_8);
        param_655 = _e651;
        param_656 = _e649;
        let _e652 = newValue_2;
        param_657 = _e652;
        let _e653 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_654), (&param_655), (&param_656), (&param_657));
        if _e653 {
            return;
        }
    } else {
        let _e655 = (*pos_14)[1u];
        let _e657 = tuning.gridHeight;
        if (_e655 < (bitcast<i32>(_e657) - 2i)) {
            let _e661 = (*pos_14);
            param_658 = (_e661 + vec3<i32>(0i, 1i, 0i));
            let _e663 = getIndex_u0028_vi3_u003b((&param_658));
            param_659 = _e663;
            let _e664 = readCell_u0028_u1_u003b((&param_659));
            param_660 = _e664;
            let _e665 = getType_u0028_u1_u003b((&param_660));
            local_24 = (_e665 != 0u);
        } else {
            local_24 = false;
        }
        let _e667 = local_24;
        hasPressure_2 = _e667;
        let _e669 = (*pos_14)[1u];
        if (_e669 > 1i) {
            let _e671 = (*pos_14);
            param_661 = (_e671 + vec3<i32>(0i, -1i, 0i));
            let _e673 = getIndex_u0028_vi3_u003b((&param_661));
            param_662 = _e673;
            let _e674 = readCell_u0028_u1_u003b((&param_662));
            param_663 = _e674;
            let _e675 = getType_u0028_u1_u003b((&param_663));
            local_25 = (_e675 == 2u);
        } else {
            local_25 = false;
        }
        let _e677 = local_25;
        isStackedOnWater_1 = _e677;
        canStepOntoPool = false;
        d_17 = 0i;
        loop {
            let _e678 = d_17;
            if (_e678 < 8i) {
                let _e680 = (*pos_14);
                let _e681 = d_17;
                param_664 = _e681;
                let _e682 = getHDir_u0028_i1_u003b((&param_664));
                nPos_7 = (_e680 + _e682);
                let _e685 = nPos_7[0u];
                let _e686 = (_e685 > 0i);
                phi_5118_ = _e686;
                if _e686 {
                    let _e688 = nPos_7[0u];
                    let _e690 = tuning.gridWidth;
                    phi_5118_ = (_e688 < (bitcast<i32>(_e690) - 1i));
                }
                let _e695 = phi_5118_;
                phi_5124_ = _e695;
                if _e695 {
                    let _e697 = nPos_7[2u];
                    phi_5124_ = (_e697 > 0i);
                }
                let _e700 = phi_5124_;
                phi_5134_ = _e700;
                if _e700 {
                    let _e702 = nPos_7[2u];
                    let _e704 = tuning.gridDepth;
                    phi_5134_ = (_e702 < (bitcast<i32>(_e704) - 1i));
                }
                let _e709 = phi_5134_;
                if _e709 {
                    let _e710 = nPos_7;
                    param_665 = _e710;
                    let _e711 = getIndex_u0028_vi3_u003b((&param_665));
                    param_666 = _e711;
                    let _e712 = readCell_u0028_u1_u003b((&param_666));
                    param_667 = _e712;
                    let _e713 = getType_u0028_u1_u003b((&param_667));
                    let _e714 = (_e713 == 0u);
                    phi_5150_ = _e714;
                    if _e714 {
                        let _e716 = (*pos_14)[1u];
                        phi_5150_ = (_e716 > 1i);
                    }
                    let _e719 = phi_5150_;
                    phi_5162_ = _e719;
                    if _e719 {
                        let _e720 = nPos_7;
                        param_668 = (_e720 + vec3<i32>(0i, -1i, 0i));
                        let _e722 = getIndex_u0028_vi3_u003b((&param_668));
                        param_669 = _e722;
                        let _e723 = readCell_u0028_u1_u003b((&param_669));
                        param_670 = _e723;
                        let _e724 = getType_u0028_u1_u003b((&param_670));
                        phi_5162_ = (_e724 == 2u);
                    }
                    let _e727 = phi_5162_;
                    if _e727 {
                        canStepOntoPool = true;
                        break;
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e728 = d_17;
                d_17 = (_e728 + 1i);
            }
        }
        let _e730 = hasPressure_2;
        let _e731 = isStackedOnWater_1;
        let _e733 = canStepOntoPool;
        if ((_e730 || _e731) || _e733) {
            let _e735 = (*randVal_10);
            startSpreadDir = i32((fract((_e735 * 8f)) * 8f));
            i_20 = 0i;
            loop {
                let _e740 = i_20;
                if (_e740 < 8i) {
                    let _e742 = startSpreadDir;
                    let _e743 = i_20;
                    let _e744 = (_e742 + _e743);
                    d_18 = (_e744 - (i32(floor((f32(_e744) / f32(8i)))) * 8i));
                    let _e752 = (*pos_14);
                    let _e753 = d_18;
                    param_671 = _e753;
                    let _e754 = getHDir_u0028_i1_u003b((&param_671));
                    targetPos_2 = (_e752 + _e754);
                    let _e757 = targetPos_2[0u];
                    let _e758 = (_e757 > 0i);
                    phi_5212_ = _e758;
                    if _e758 {
                        let _e760 = targetPos_2[0u];
                        let _e762 = tuning.gridWidth;
                        phi_5212_ = (_e760 < (bitcast<i32>(_e762) - 1i));
                    }
                    let _e767 = phi_5212_;
                    phi_5218_ = _e767;
                    if _e767 {
                        let _e769 = targetPos_2[2u];
                        phi_5218_ = (_e769 > 0i);
                    }
                    let _e772 = phi_5218_;
                    phi_5228_ = _e772;
                    if _e772 {
                        let _e774 = targetPos_2[2u];
                        let _e776 = tuning.gridDepth;
                        phi_5228_ = (_e774 < (bitcast<i32>(_e776) - 1i));
                    }
                    let _e781 = phi_5228_;
                    if _e781 {
                        let _e782 = targetPos_2;
                        param_672 = _e782;
                        let _e783 = getIndex_u0028_vi3_u003b((&param_672));
                        param_673 = _e783;
                        let _e784 = readCell_u0028_u1_u003b((&param_673));
                        param_674 = _e784;
                        let _e785 = getType_u0028_u1_u003b((&param_674));
                        if (_e785 == 0u) {
                            let _e787 = d_18;
                            param_675 = 2u;
                            param_676 = bitcast<u32>((_e787 + 1i));
                            param_677 = 0u;
                            let _e790 = newAge_2;
                            param_678 = _e790;
                            let _e791 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_675), (&param_676), (&param_677), (&param_678));
                            newValue_3 = _e791;
                            let _e792 = targetPos_2;
                            param_679 = _e792;
                            let _e793 = getIndex_u0028_vi3_u003b((&param_679));
                            let _e794 = (*currentIndex_10);
                            param_680 = _e794;
                            let _e795 = (*rawValue_8);
                            param_681 = _e795;
                            param_682 = _e793;
                            let _e796 = newValue_3;
                            param_683 = _e796;
                            let _e797 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_680), (&param_681), (&param_682), (&param_683));
                            if _e797 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e798 = i_20;
                    i_20 = (_e798 + 1i);
                }
            }
        }
    }
    let _e800 = (*currentSleep_5);
    newSleep_3 = min((_e800 + 1u), 255u);
    param_684 = 2u;
    param_685 = 0u;
    let _e803 = newSleep_3;
    param_686 = _e803;
    let _e804 = newAge_2;
    param_687 = _e804;
    let _e805 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_684), (&param_685), (&param_686), (&param_687));
    sleepValue = _e805;
    let _e806 = (*currentIndex_10);
    let _e809 = (*rawValue_8);
    let _e810 = sleepValue;
    let _e811 = atomicCompareExchangeWeak((&unnamed.grid[_e806]), _e809, _e810);
    return;
}

fn incWater_u0028_() {
    let _e197 = atomicAdd((&unnamed_2.waterVoxelCount), 1u);
    return;
}

fn updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_15: ptr<function, vec3<i32>>, currentIndex_11: ptr<function, u32>, rawValue_9: ptr<function, u32>, currentSleep_6: ptr<function, u32>, currentAge_9: ptr<function, u32>, randVal_11: ptr<function, f32>) {
    var moisture_5: u32;
    var moistureModified_1: bool;
    var startDir_5: i32;
    var i_21: i32;
    var d_19: i32;
    var nPos_8: vec3<i32>;
    var param_688: i32;
    var nIndex_5: u32;
    var param_689: vec3<i32>;
    var nVal_5: u32;
    var param_690: u32;
    var param_691: u32;
    var d_20: i32;
    var nPos_9: vec3<i32>;
    var param_692: i32;
    var nIndex_6: u32;
    var param_693: vec3<i32>;
    var nVal_6: u32;
    var param_694: u32;
    var nType_3: u32;
    var param_695: u32;
    var nMoisture_1: u32;
    var param_696: u32;
    var nCapacity_1: u32;
    var local_26: u32;
    var leakPos: vec3<i32>;
    var param_697: vec3<i32>;
    var param_698: u32;
    var param_699: u32;
    var param_700: vec3<i32>;
    var param_701: u32;
    var param_702: u32;
    var param_703: u32;
    var param_704: u32;
    var canMove_1: bool;
    var param_705: vec3<i32>;
    var isClumped_1: bool;
    var emptyBelowCount_1: i32;
    var x_2: i32;
    var z_2: i32;
    var checkPos_2: vec3<i32>;
    var param_706: vec3<i32>;
    var param_707: u32;
    var param_708: u32;
    var clumpCount_1: i32;
    var x_3: i32;
    var y_1: i32;
    var z_3: i32;
    var nPos_10: vec3<i32>;
    var param_709: vec3<i32>;
    var param_710: u32;
    var param_711: u32;
    var belowPos_8: vec3<i32>;
    var param_712: vec3<i32>;
    var param_713: u32;
    var param_714: u32;
    var param_715: vec3<i32>;
    var param_716: u32;
    var param_717: u32;
    var param_718: u32;
    var param_719: u32;
    var param_720: u32;
    var param_721: u32;
    var param_722: u32;
    var param_723: u32;
    var dir_4: i32;
    var slidePos1_1: vec3<i32>;
    var slidePos2_1: vec3<i32>;
    var param_724: vec3<i32>;
    var param_725: u32;
    var param_726: u32;
    var param_727: vec3<i32>;
    var param_728: u32;
    var param_729: u32;
    var param_730: u32;
    var param_731: u32;
    var param_732: u32;
    var param_733: u32;
    var param_734: u32;
    var param_735: u32;
    var param_736: vec3<i32>;
    var param_737: u32;
    var param_738: u32;
    var param_739: vec3<i32>;
    var param_740: u32;
    var param_741: u32;
    var param_742: u32;
    var param_743: u32;
    var param_744: u32;
    var param_745: u32;
    var param_746: u32;
    var param_747: u32;
    var belowPos_9: vec3<i32>;
    var belowIndex_3: u32;
    var param_748: vec3<i32>;
    var belowValue_3: u32;
    var param_749: u32;
    var param_750: u32;
    var startDir_6: i32;
    var i_22: i32;
    var d_21: i32;
    var pushPos_2: vec3<i32>;
    var param_751: i32;
    var param_752: u32;
    var param_753: u32;
    var param_754: u32;
    var param_755: u32;
    var param_756: vec3<i32>;
    var param_757: u32;
    var param_758: u32;
    var param_759: u32;
    var param_760: u32;
    var param_761: u32;
    var param_762: u32;
    var param_763: u32;
    var param_764: u32;
    var param_765: u32;
    var param_766: u32;
    var param_767: u32;
    var param_768: u32;
    var param_769: u32;
    var dir_5: i32;
    var slidePos_1: array<vec3<i32>, 2>;
    var s_2: i32;
    var sPos_3: vec3<i32>;
    var sIndex_1: u32;
    var param_770: vec3<i32>;
    var sValue_1: u32;
    var param_771: u32;
    var param_772: u32;
    var startDir_7: i32;
    var i_23: i32;
    var d_22: i32;
    var pushPos_3: vec3<i32>;
    var param_773: i32;
    var param_774: u32;
    var param_775: u32;
    var param_776: u32;
    var param_777: u32;
    var param_778: vec3<i32>;
    var param_779: u32;
    var param_780: u32;
    var param_781: u32;
    var param_782: u32;
    var param_783: u32;
    var param_784: u32;
    var param_785: u32;
    var param_786: u32;
    var param_787: u32;
    var param_788: u32;
    var param_789: u32;
    var param_790: u32;
    var param_791: u32;
    var newSleep_4: u32;
    var param_792: u32;
    var param_793: u32;
    var param_794: u32;
    var param_795: u32;
    var phi_2438_: bool;
    var phi_2444_: bool;
    var phi_2454_: bool;
    var phi_2460_: bool;
    var phi_2470_: bool;
    var phi_2542_: bool;
    var phi_2548_: bool;
    var phi_2558_: bool;
    var phi_2564_: bool;
    var phi_2574_: bool;
    var phi_2639_: bool;
    var phi_2658_: bool;
    var phi_2702_: bool;
    var phi_2744_: bool;
    var phi_2750_: bool;
    var phi_2759_: bool;
    var phi_2841_: bool;
    var phi_2847_: bool;
    var phi_2856_: bool;
    var phi_2862_: bool;
    var phi_2871_: bool;
    var phi_2993_: bool;
    var phi_2999_: bool;
    var phi_3009_: bool;
    var phi_3053_: bool;
    var phi_3059_: bool;
    var phi_3069_: bool;
    var phi_3161_: bool;
    var phi_3167_: bool;
    var phi_3177_: bool;
    var phi_3280_: bool;
    var phi_3286_: bool;
    var phi_3296_: bool;
    var phi_3353_: bool;
    var phi_3359_: bool;
    var phi_3369_: bool;

    let _e360 = (*currentAge_9);
    moisture_5 = _e360;
    moistureModified_1 = false;
    let _e361 = moisture_5;
    let _e363 = tuning.sandMoistureCapacity;
    if (_e361 < _e363) {
        let _e365 = (*randVal_11);
        startDir_5 = i32((fract((_e365 * 17f)) * 6f));
        i_21 = 0i;
        loop {
            let _e370 = i_21;
            if (_e370 < 6i) {
                let _e372 = startDir_5;
                let _e373 = i_21;
                let _e374 = (_e372 + _e373);
                d_19 = (_e374 - (i32(floor((f32(_e374) / f32(6i)))) * 6i));
                let _e382 = d_19;
                if (_e382 != 2i) {
                    let _e384 = (*pos_15);
                    let _e385 = d_19;
                    param_688 = _e385;
                    let _e386 = getOrthoDir_u0028_i1_u003b((&param_688));
                    nPos_8 = (_e384 + _e386);
                    let _e389 = nPos_8[0u];
                    let _e390 = (_e389 > 0i);
                    phi_2438_ = _e390;
                    if _e390 {
                        let _e392 = nPos_8[0u];
                        let _e394 = tuning.gridWidth;
                        phi_2438_ = (_e392 < (bitcast<i32>(_e394) - 1i));
                    }
                    let _e399 = phi_2438_;
                    phi_2444_ = _e399;
                    if _e399 {
                        let _e401 = nPos_8[1u];
                        phi_2444_ = (_e401 > 0i);
                    }
                    let _e404 = phi_2444_;
                    phi_2454_ = _e404;
                    if _e404 {
                        let _e406 = nPos_8[1u];
                        let _e408 = tuning.gridHeight;
                        phi_2454_ = (_e406 < (bitcast<i32>(_e408) - 1i));
                    }
                    let _e413 = phi_2454_;
                    phi_2460_ = _e413;
                    if _e413 {
                        let _e415 = nPos_8[2u];
                        phi_2460_ = (_e415 > 0i);
                    }
                    let _e418 = phi_2460_;
                    phi_2470_ = _e418;
                    if _e418 {
                        let _e420 = nPos_8[2u];
                        let _e422 = tuning.gridDepth;
                        phi_2470_ = (_e420 < (bitcast<i32>(_e422) - 1i));
                    }
                    let _e427 = phi_2470_;
                    if _e427 {
                        let _e428 = nPos_8;
                        param_689 = _e428;
                        let _e429 = getIndex_u0028_vi3_u003b((&param_689));
                        nIndex_5 = _e429;
                        let _e430 = nIndex_5;
                        param_690 = _e430;
                        let _e431 = readCell_u0028_u1_u003b((&param_690));
                        nVal_5 = _e431;
                        let _e432 = nVal_5;
                        param_691 = _e432;
                        let _e433 = getType_u0028_u1_u003b((&param_691));
                        if (_e433 == 2u) {
                            let _e435 = nIndex_5;
                            let _e438 = nVal_5;
                            let _e439 = atomicCompareExchangeWeak((&unnamed.grid[_e435]), _e438, 0u);
                            let _e441 = nVal_5;
                            if (_e439.old_value == _e441) {
                                let _e443 = (*currentIndex_11);
                                let _e447 = tuning.sandWaterAbsorbUnit;
                                let _e450 = atomicAdd((&unnamed.grid[_e443]), (_e447 << bitcast<u32>(24i)));
                                decWater_u0028_();
                                moistureModified_1 = true;
                                break;
                            }
                        }
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e451 = i_21;
                i_21 = (_e451 + 1i);
            }
        }
    }
    let _e453 = moistureModified_1;
    let _e455 = moisture_5;
    if (!(_e453) && (_e455 > 0u)) {
        let _e458 = (*randVal_11);
        d_20 = i32((fract((_e458 * 31f)) * 6f));
        let _e463 = d_20;
        if (_e463 != 2i) {
            let _e465 = (*pos_15);
            let _e466 = d_20;
            param_692 = _e466;
            let _e467 = getOrthoDir_u0028_i1_u003b((&param_692));
            nPos_9 = (_e465 + _e467);
            let _e470 = nPos_9[0u];
            let _e471 = (_e470 > 0i);
            phi_2542_ = _e471;
            if _e471 {
                let _e473 = nPos_9[0u];
                let _e475 = tuning.gridWidth;
                phi_2542_ = (_e473 < (bitcast<i32>(_e475) - 1i));
            }
            let _e480 = phi_2542_;
            phi_2548_ = _e480;
            if _e480 {
                let _e482 = nPos_9[1u];
                phi_2548_ = (_e482 > 0i);
            }
            let _e485 = phi_2548_;
            phi_2558_ = _e485;
            if _e485 {
                let _e487 = nPos_9[1u];
                let _e489 = tuning.gridHeight;
                phi_2558_ = (_e487 < (bitcast<i32>(_e489) - 1i));
            }
            let _e494 = phi_2558_;
            phi_2564_ = _e494;
            if _e494 {
                let _e496 = nPos_9[2u];
                phi_2564_ = (_e496 > 0i);
            }
            let _e499 = phi_2564_;
            phi_2574_ = _e499;
            if _e499 {
                let _e501 = nPos_9[2u];
                let _e503 = tuning.gridDepth;
                phi_2574_ = (_e501 < (bitcast<i32>(_e503) - 1i));
            }
            let _e508 = phi_2574_;
            if _e508 {
                let _e509 = nPos_9;
                param_693 = _e509;
                let _e510 = getIndex_u0028_vi3_u003b((&param_693));
                nIndex_6 = _e510;
                let _e511 = nIndex_6;
                param_694 = _e511;
                let _e512 = readCell_u0028_u1_u003b((&param_694));
                nVal_6 = _e512;
                let _e513 = nVal_6;
                param_695 = _e513;
                let _e514 = getType_u0028_u1_u003b((&param_695));
                nType_3 = _e514;
                let _e515 = nType_3;
                let _e517 = nType_3;
                if ((_e515 == 1u) || (_e517 == 4u)) {
                    let _e520 = nVal_6;
                    param_696 = _e520;
                    let _e521 = getAge_u0028_u1_u003b((&param_696));
                    nMoisture_1 = _e521;
                    let _e522 = nType_3;
                    if (_e522 == 4u) {
                        let _e525 = tuning.dirtMoistureCapacity;
                        local_26 = _e525;
                    } else {
                        let _e527 = tuning.sandMoistureCapacity;
                        local_26 = _e527;
                    }
                    let _e528 = local_26;
                    nCapacity_1 = _e528;
                    let _e529 = moisture_5;
                    let _e530 = nMoisture_1;
                    let _e533 = nMoisture_1;
                    let _e534 = nCapacity_1;
                    if ((_e529 > (_e530 + 1u)) && (_e533 < _e534)) {
                        let _e537 = (*currentIndex_11);
                        let _e540 = atomicAdd((&unnamed.grid[_e537]), 4278190080u);
                        let _e541 = nIndex_6;
                        let _e544 = atomicAdd((&unnamed.grid[_e541]), 16777216u);
                        moistureModified_1 = true;
                    }
                }
            }
        }
    }
    let _e545 = moistureModified_1;
    let _e546 = !(_e545);
    phi_2639_ = _e546;
    if _e546 {
        let _e547 = moisture_5;
        let _e549 = tuning.sandWaterAbsorbUnit;
        phi_2639_ = (_e547 >= _e549);
    }
    let _e552 = phi_2639_;
    if _e552 {
        let _e553 = (*pos_15);
        leakPos = (_e553 + vec3<i32>(0i, -1i, 0i));
        let _e556 = leakPos[1u];
        let _e557 = (_e556 > 0i);
        phi_2658_ = _e557;
        if _e557 {
            let _e558 = leakPos;
            param_697 = _e558;
            let _e559 = getIndex_u0028_vi3_u003b((&param_697));
            param_698 = _e559;
            let _e560 = readCell_u0028_u1_u003b((&param_698));
            param_699 = _e560;
            let _e561 = getType_u0028_u1_u003b((&param_699));
            phi_2658_ = (_e561 == 0u);
        }
        let _e564 = phi_2658_;
        if _e564 {
            let _e565 = leakPos;
            param_700 = _e565;
            let _e566 = getIndex_u0028_vi3_u003b((&param_700));
            param_701 = 2u;
            param_702 = 0u;
            param_703 = 0u;
            param_704 = 0u;
            let _e569 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_701), (&param_702), (&param_703), (&param_704));
            let _e570 = atomicCompareExchangeWeak((&unnamed.grid[_e566]), 0u, _e569);
            if (_e570.old_value == 0u) {
                let _e573 = (*currentIndex_11);
                let _e577 = tuning.sandWaterAbsorbUnit;
                let _e581 = atomicAdd((&unnamed.grid[_e573]), ((0u - _e577) << bitcast<u32>(24i)));
                incWater_u0028_();
                moistureModified_1 = true;
            }
        }
    }
    let _e582 = moistureModified_1;
    if _e582 {
        return;
    }
    let _e583 = (*pos_15);
    param_705 = _e583;
    let _e584 = grainCanMove_u0028_vi3_u003b((&param_705));
    canMove_1 = _e584;
    isClumped_1 = false;
    let _e585 = canMove_1;
    let _e586 = moisture_5;
    let _e588 = (_e585 && (_e586 > 0u));
    phi_2702_ = _e588;
    if _e588 {
        let _e589 = (*currentSleep_6);
        let _e591 = tuning.wakeSleepThreshold;
        phi_2702_ = (_e589 > _e591);
    }
    let _e594 = phi_2702_;
    if _e594 {
        emptyBelowCount_1 = 0i;
        let _e596 = (*pos_15)[1u];
        if (_e596 > 1i) {
            x_2 = -1i;
            loop {
                let _e598 = x_2;
                if (_e598 <= 1i) {
                    z_2 = -1i;
                    loop {
                        let _e600 = z_2;
                        if (_e600 <= 1i) {
                            let _e602 = (*pos_15);
                            let _e603 = x_2;
                            let _e604 = z_2;
                            checkPos_2 = (_e602 + vec3<i32>(_e603, -1i, _e604));
                            let _e608 = checkPos_2[0u];
                            let _e609 = (_e608 >= 0i);
                            phi_2744_ = _e609;
                            if _e609 {
                                let _e611 = checkPos_2[0u];
                                let _e613 = tuning.gridWidth;
                                phi_2744_ = (_e611 < bitcast<i32>(_e613));
                            }
                            let _e617 = phi_2744_;
                            phi_2750_ = _e617;
                            if _e617 {
                                let _e619 = checkPos_2[2u];
                                phi_2750_ = (_e619 >= 0i);
                            }
                            let _e622 = phi_2750_;
                            phi_2759_ = _e622;
                            if _e622 {
                                let _e624 = checkPos_2[2u];
                                let _e626 = tuning.gridDepth;
                                phi_2759_ = (_e624 < bitcast<i32>(_e626));
                            }
                            let _e630 = phi_2759_;
                            if _e630 {
                                let _e631 = checkPos_2;
                                param_706 = _e631;
                                let _e632 = getIndex_u0028_vi3_u003b((&param_706));
                                param_707 = _e632;
                                let _e633 = readCell_u0028_u1_u003b((&param_707));
                                param_708 = _e633;
                                let _e634 = getType_u0028_u1_u003b((&param_708));
                                if (_e634 == 0u) {
                                    let _e636 = emptyBelowCount_1;
                                    emptyBelowCount_1 = (_e636 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e638 = z_2;
                            z_2 = (_e638 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e640 = x_2;
                    x_2 = (_e640 + 1i);
                }
            }
        }
        let _e642 = emptyBelowCount_1;
        let _e644 = tuning.emptyBelowWakeCount;
        if (_e642 >= bitcast<i32>(_e644)) {
            (*currentSleep_6) = 0u;
        } else {
            clumpCount_1 = 0i;
            x_3 = -1i;
            loop {
                let _e647 = x_3;
                if (_e647 <= 1i) {
                    y_1 = -1i;
                    loop {
                        let _e649 = y_1;
                        if (_e649 <= 1i) {
                            z_3 = -1i;
                            loop {
                                let _e651 = z_3;
                                if (_e651 <= 1i) {
                                    let _e653 = x_3;
                                    let _e655 = y_1;
                                    let _e658 = z_3;
                                    if (((_e653 == 0i) && (_e655 == 0i)) && (_e658 == 0i)) {
                                        continue;
                                    }
                                    let _e661 = (*pos_15);
                                    let _e662 = x_3;
                                    let _e663 = y_1;
                                    let _e664 = z_3;
                                    nPos_10 = (_e661 + vec3<i32>(_e662, _e663, _e664));
                                    let _e668 = nPos_10[0u];
                                    let _e669 = (_e668 >= 0i);
                                    phi_2841_ = _e669;
                                    if _e669 {
                                        let _e671 = nPos_10[0u];
                                        let _e673 = tuning.gridWidth;
                                        phi_2841_ = (_e671 < bitcast<i32>(_e673));
                                    }
                                    let _e677 = phi_2841_;
                                    phi_2847_ = _e677;
                                    if _e677 {
                                        let _e679 = nPos_10[1u];
                                        phi_2847_ = (_e679 >= 0i);
                                    }
                                    let _e682 = phi_2847_;
                                    phi_2856_ = _e682;
                                    if _e682 {
                                        let _e684 = nPos_10[1u];
                                        let _e686 = tuning.gridHeight;
                                        phi_2856_ = (_e684 < bitcast<i32>(_e686));
                                    }
                                    let _e690 = phi_2856_;
                                    phi_2862_ = _e690;
                                    if _e690 {
                                        let _e692 = nPos_10[2u];
                                        phi_2862_ = (_e692 >= 0i);
                                    }
                                    let _e695 = phi_2862_;
                                    phi_2871_ = _e695;
                                    if _e695 {
                                        let _e697 = nPos_10[2u];
                                        let _e699 = tuning.gridDepth;
                                        phi_2871_ = (_e697 < bitcast<i32>(_e699));
                                    }
                                    let _e703 = phi_2871_;
                                    if _e703 {
                                        let _e704 = nPos_10;
                                        param_709 = _e704;
                                        let _e705 = getIndex_u0028_vi3_u003b((&param_709));
                                        param_710 = _e705;
                                        let _e706 = readCell_u0028_u1_u003b((&param_710));
                                        param_711 = _e706;
                                        let _e707 = getType_u0028_u1_u003b((&param_711));
                                        if (_e707 == 1u) {
                                            let _e709 = clumpCount_1;
                                            clumpCount_1 = (_e709 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e711 = z_3;
                                    z_3 = (_e711 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e713 = y_1;
                            y_1 = (_e713 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e715 = x_3;
                    x_3 = (_e715 + 1i);
                }
            }
            let _e717 = clumpCount_1;
            let _e719 = tuning.sandClumpThreshold;
            if (_e717 >= bitcast<i32>(_e719)) {
                isClumped_1 = true;
            }
        }
    }
    let _e722 = canMove_1;
    let _e723 = isClumped_1;
    if (_e722 && !(_e723)) {
        let _e727 = (*pos_15)[1u];
        if (_e727 > 1i) {
            let _e729 = (*pos_15);
            belowPos_8 = (_e729 + vec3<i32>(0i, -1i, 0i));
            let _e731 = belowPos_8;
            param_712 = _e731;
            let _e732 = getIndex_u0028_vi3_u003b((&param_712));
            param_713 = _e732;
            let _e733 = readCell_u0028_u1_u003b((&param_713));
            param_714 = _e733;
            let _e734 = getType_u0028_u1_u003b((&param_714));
            if (_e734 == 0u) {
                let _e736 = belowPos_8;
                param_715 = _e736;
                let _e737 = getIndex_u0028_vi3_u003b((&param_715));
                param_716 = 1u;
                param_717 = 0u;
                param_718 = 0u;
                let _e738 = moisture_5;
                param_719 = _e738;
                let _e739 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_716), (&param_717), (&param_718), (&param_719));
                let _e740 = (*currentIndex_11);
                param_720 = _e740;
                let _e741 = (*rawValue_9);
                param_721 = _e741;
                param_722 = _e737;
                param_723 = _e739;
                let _e742 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_720), (&param_721), (&param_722), (&param_723));
                if _e742 {
                    return;
                }
            }
        }
        let _e744 = (*pos_15)[1u];
        if (_e744 > 1i) {
            let _e746 = (*randVal_11);
            dir_4 = select(-1i, 1i, (fract((_e746 * 10f)) > 0.5f));
            let _e751 = (*randVal_11);
            if (fract((_e751 * 100f)) > 0.5f) {
                let _e755 = (*pos_15);
                let _e756 = dir_4;
                slidePos1_1 = (_e755 + vec3<i32>(_e756, -1i, 0i));
                let _e759 = (*pos_15);
                let _e760 = dir_4;
                slidePos2_1 = (_e759 + vec3<i32>(0i, -1i, _e760));
            } else {
                let _e763 = (*pos_15);
                let _e764 = dir_4;
                slidePos1_1 = (_e763 + vec3<i32>(0i, -1i, _e764));
                let _e767 = (*pos_15);
                let _e768 = dir_4;
                slidePos2_1 = (_e767 + vec3<i32>(_e768, -1i, 0i));
            }
            let _e772 = slidePos1_1[0u];
            let _e773 = (_e772 > 0i);
            phi_2993_ = _e773;
            if _e773 {
                let _e775 = slidePos1_1[0u];
                let _e777 = tuning.gridWidth;
                phi_2993_ = (_e775 < (bitcast<i32>(_e777) - 1i));
            }
            let _e782 = phi_2993_;
            phi_2999_ = _e782;
            if _e782 {
                let _e784 = slidePos1_1[2u];
                phi_2999_ = (_e784 > 0i);
            }
            let _e787 = phi_2999_;
            phi_3009_ = _e787;
            if _e787 {
                let _e789 = slidePos1_1[2u];
                let _e791 = tuning.gridDepth;
                phi_3009_ = (_e789 < (bitcast<i32>(_e791) - 1i));
            }
            let _e796 = phi_3009_;
            if _e796 {
                let _e797 = slidePos1_1;
                param_724 = _e797;
                let _e798 = getIndex_u0028_vi3_u003b((&param_724));
                param_725 = _e798;
                let _e799 = readCell_u0028_u1_u003b((&param_725));
                param_726 = _e799;
                let _e800 = getType_u0028_u1_u003b((&param_726));
                if (_e800 == 0u) {
                    let _e802 = slidePos1_1;
                    param_727 = _e802;
                    let _e803 = getIndex_u0028_vi3_u003b((&param_727));
                    param_728 = 1u;
                    param_729 = 0u;
                    param_730 = 0u;
                    let _e804 = moisture_5;
                    param_731 = _e804;
                    let _e805 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_728), (&param_729), (&param_730), (&param_731));
                    let _e806 = (*currentIndex_11);
                    param_732 = _e806;
                    let _e807 = (*rawValue_9);
                    param_733 = _e807;
                    param_734 = _e803;
                    param_735 = _e805;
                    let _e808 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_732), (&param_733), (&param_734), (&param_735));
                    if _e808 {
                        return;
                    }
                }
            }
            let _e810 = slidePos2_1[0u];
            let _e811 = (_e810 > 0i);
            phi_3053_ = _e811;
            if _e811 {
                let _e813 = slidePos2_1[0u];
                let _e815 = tuning.gridWidth;
                phi_3053_ = (_e813 < (bitcast<i32>(_e815) - 1i));
            }
            let _e820 = phi_3053_;
            phi_3059_ = _e820;
            if _e820 {
                let _e822 = slidePos2_1[2u];
                phi_3059_ = (_e822 > 0i);
            }
            let _e825 = phi_3059_;
            phi_3069_ = _e825;
            if _e825 {
                let _e827 = slidePos2_1[2u];
                let _e829 = tuning.gridDepth;
                phi_3069_ = (_e827 < (bitcast<i32>(_e829) - 1i));
            }
            let _e834 = phi_3069_;
            if _e834 {
                let _e835 = slidePos2_1;
                param_736 = _e835;
                let _e836 = getIndex_u0028_vi3_u003b((&param_736));
                param_737 = _e836;
                let _e837 = readCell_u0028_u1_u003b((&param_737));
                param_738 = _e837;
                let _e838 = getType_u0028_u1_u003b((&param_738));
                if (_e838 == 0u) {
                    let _e840 = slidePos2_1;
                    param_739 = _e840;
                    let _e841 = getIndex_u0028_vi3_u003b((&param_739));
                    param_740 = 1u;
                    param_741 = 0u;
                    param_742 = 0u;
                    let _e842 = moisture_5;
                    param_743 = _e842;
                    let _e843 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_740), (&param_741), (&param_742), (&param_743));
                    let _e844 = (*currentIndex_11);
                    param_744 = _e844;
                    let _e845 = (*rawValue_9);
                    param_745 = _e845;
                    param_746 = _e841;
                    param_747 = _e843;
                    let _e846 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_744), (&param_745), (&param_746), (&param_747));
                    if _e846 {
                        return;
                    }
                }
            }
        }
        let _e848 = (*pos_15)[1u];
        if (_e848 > 1i) {
            let _e850 = (*pos_15);
            belowPos_9 = (_e850 + vec3<i32>(0i, -1i, 0i));
            let _e852 = belowPos_9;
            param_748 = _e852;
            let _e853 = getIndex_u0028_vi3_u003b((&param_748));
            belowIndex_3 = _e853;
            let _e854 = belowIndex_3;
            param_749 = _e854;
            let _e855 = readCell_u0028_u1_u003b((&param_749));
            belowValue_3 = _e855;
            let _e856 = belowValue_3;
            param_750 = _e856;
            let _e857 = getType_u0028_u1_u003b((&param_750));
            if (_e857 == 2u) {
                let _e859 = (*randVal_11);
                startDir_6 = i32((fract((_e859 * 8f)) * 8f));
                i_22 = 0i;
                loop {
                    let _e864 = i_22;
                    if (_e864 < 8i) {
                        let _e866 = startDir_6;
                        let _e867 = i_22;
                        let _e868 = (_e866 + _e867);
                        d_21 = (_e868 - (i32(floor((f32(_e868) / f32(8i)))) * 8i));
                        let _e876 = belowPos_9;
                        let _e877 = d_21;
                        param_751 = _e877;
                        let _e878 = getHDir_u0028_i1_u003b((&param_751));
                        pushPos_2 = (_e876 + _e878);
                        let _e881 = pushPos_2[0u];
                        let _e882 = (_e881 > 0i);
                        phi_3161_ = _e882;
                        if _e882 {
                            let _e884 = pushPos_2[0u];
                            let _e886 = tuning.gridWidth;
                            phi_3161_ = (_e884 < (bitcast<i32>(_e886) - 1i));
                        }
                        let _e891 = phi_3161_;
                        phi_3167_ = _e891;
                        if _e891 {
                            let _e893 = pushPos_2[2u];
                            phi_3167_ = (_e893 > 0i);
                        }
                        let _e896 = phi_3167_;
                        phi_3177_ = _e896;
                        if _e896 {
                            let _e898 = pushPos_2[2u];
                            let _e900 = tuning.gridDepth;
                            phi_3177_ = (_e898 < (bitcast<i32>(_e900) - 1i));
                        }
                        let _e905 = phi_3177_;
                        if _e905 {
                            param_752 = 1u;
                            param_753 = 0u;
                            param_754 = 0u;
                            let _e906 = moisture_5;
                            param_755 = _e906;
                            let _e907 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_752), (&param_753), (&param_754), (&param_755));
                            let _e908 = pushPos_2;
                            param_756 = _e908;
                            let _e909 = getIndex_u0028_vi3_u003b((&param_756));
                            let _e910 = (*currentIndex_11);
                            param_757 = _e910;
                            param_758 = _e907;
                            let _e911 = belowIndex_3;
                            param_759 = _e911;
                            let _e912 = belowValue_3;
                            param_760 = _e912;
                            param_761 = _e909;
                            let _e913 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_757), (&param_758), (&param_759), (&param_760), (&param_761));
                            if _e913 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e914 = i_22;
                        i_22 = (_e914 + 1i);
                    }
                }
                param_762 = 1u;
                param_763 = 0u;
                param_764 = 0u;
                let _e916 = moisture_5;
                param_765 = _e916;
                let _e917 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_762), (&param_763), (&param_764), (&param_765));
                let _e918 = (*currentIndex_11);
                param_766 = _e918;
                let _e919 = (*rawValue_9);
                param_767 = _e919;
                let _e920 = belowIndex_3;
                param_768 = _e920;
                param_769 = _e917;
                let _e921 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_766), (&param_767), (&param_768), (&param_769));
                if _e921 {
                    return;
                }
            }
            let _e922 = (*randVal_11);
            dir_5 = select(-1i, 1i, (fract((_e922 * 10f)) > 0.5f));
            let _e927 = (*randVal_11);
            if (fract((_e927 * 100f)) > 0.5f) {
                let _e931 = (*pos_15);
                let _e932 = dir_5;
                slidePos_1[0i] = (_e931 + vec3<i32>(_e932, -1i, 0i));
                let _e936 = (*pos_15);
                let _e937 = dir_5;
                slidePos_1[1i] = (_e936 + vec3<i32>(0i, -1i, _e937));
            } else {
                let _e941 = (*pos_15);
                let _e942 = dir_5;
                slidePos_1[0i] = (_e941 + vec3<i32>(0i, -1i, _e942));
                let _e946 = (*pos_15);
                let _e947 = dir_5;
                slidePos_1[1i] = (_e946 + vec3<i32>(_e947, -1i, 0i));
            }
            s_2 = 0i;
            loop {
                let _e951 = s_2;
                if (_e951 < 2i) {
                    let _e953 = s_2;
                    let _e955 = slidePos_1[_e953];
                    sPos_3 = _e955;
                    let _e957 = sPos_3[0u];
                    let _e958 = (_e957 > 0i);
                    phi_3280_ = _e958;
                    if _e958 {
                        let _e960 = sPos_3[0u];
                        let _e962 = tuning.gridWidth;
                        phi_3280_ = (_e960 < (bitcast<i32>(_e962) - 1i));
                    }
                    let _e967 = phi_3280_;
                    phi_3286_ = _e967;
                    if _e967 {
                        let _e969 = sPos_3[2u];
                        phi_3286_ = (_e969 > 0i);
                    }
                    let _e972 = phi_3286_;
                    phi_3296_ = _e972;
                    if _e972 {
                        let _e974 = sPos_3[2u];
                        let _e976 = tuning.gridDepth;
                        phi_3296_ = (_e974 < (bitcast<i32>(_e976) - 1i));
                    }
                    let _e981 = phi_3296_;
                    if _e981 {
                        let _e982 = sPos_3;
                        param_770 = _e982;
                        let _e983 = getIndex_u0028_vi3_u003b((&param_770));
                        sIndex_1 = _e983;
                        let _e984 = sIndex_1;
                        param_771 = _e984;
                        let _e985 = readCell_u0028_u1_u003b((&param_771));
                        sValue_1 = _e985;
                        let _e986 = sValue_1;
                        param_772 = _e986;
                        let _e987 = getType_u0028_u1_u003b((&param_772));
                        if (_e987 == 2u) {
                            let _e989 = (*randVal_11);
                            let _e991 = s_2;
                            startDir_7 = i32((fract(((_e989 * 8f) + f32(_e991))) * 8f));
                            i_23 = 0i;
                            loop {
                                let _e997 = i_23;
                                if (_e997 < 8i) {
                                    let _e999 = startDir_7;
                                    let _e1000 = i_23;
                                    let _e1001 = (_e999 + _e1000);
                                    d_22 = (_e1001 - (i32(floor((f32(_e1001) / f32(8i)))) * 8i));
                                    let _e1009 = sPos_3;
                                    let _e1010 = d_22;
                                    param_773 = _e1010;
                                    let _e1011 = getHDir_u0028_i1_u003b((&param_773));
                                    pushPos_3 = (_e1009 + _e1011);
                                    let _e1014 = pushPos_3[0u];
                                    let _e1015 = (_e1014 > 0i);
                                    phi_3353_ = _e1015;
                                    if _e1015 {
                                        let _e1017 = pushPos_3[0u];
                                        let _e1019 = tuning.gridWidth;
                                        phi_3353_ = (_e1017 < (bitcast<i32>(_e1019) - 1i));
                                    }
                                    let _e1024 = phi_3353_;
                                    phi_3359_ = _e1024;
                                    if _e1024 {
                                        let _e1026 = pushPos_3[2u];
                                        phi_3359_ = (_e1026 > 0i);
                                    }
                                    let _e1029 = phi_3359_;
                                    phi_3369_ = _e1029;
                                    if _e1029 {
                                        let _e1031 = pushPos_3[2u];
                                        let _e1033 = tuning.gridDepth;
                                        phi_3369_ = (_e1031 < (bitcast<i32>(_e1033) - 1i));
                                    }
                                    let _e1038 = phi_3369_;
                                    if _e1038 {
                                        param_774 = 1u;
                                        param_775 = 0u;
                                        param_776 = 0u;
                                        let _e1039 = moisture_5;
                                        param_777 = _e1039;
                                        let _e1040 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_774), (&param_775), (&param_776), (&param_777));
                                        let _e1041 = pushPos_3;
                                        param_778 = _e1041;
                                        let _e1042 = getIndex_u0028_vi3_u003b((&param_778));
                                        let _e1043 = (*currentIndex_11);
                                        param_779 = _e1043;
                                        param_780 = _e1040;
                                        let _e1044 = sIndex_1;
                                        param_781 = _e1044;
                                        let _e1045 = sValue_1;
                                        param_782 = _e1045;
                                        param_783 = _e1042;
                                        let _e1046 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_779), (&param_780), (&param_781), (&param_782), (&param_783));
                                        if _e1046 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1047 = i_23;
                                    i_23 = (_e1047 + 1i);
                                }
                            }
                            param_784 = 1u;
                            param_785 = 0u;
                            param_786 = 0u;
                            let _e1049 = moisture_5;
                            param_787 = _e1049;
                            let _e1050 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_784), (&param_785), (&param_786), (&param_787));
                            let _e1051 = (*currentIndex_11);
                            param_788 = _e1051;
                            let _e1052 = (*rawValue_9);
                            param_789 = _e1052;
                            let _e1053 = sIndex_1;
                            param_790 = _e1053;
                            param_791 = _e1050;
                            let _e1054 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_788), (&param_789), (&param_790), (&param_791));
                            if _e1054 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1055 = s_2;
                    s_2 = (_e1055 + 1i);
                }
            }
        }
    }
    let _e1057 = (*currentSleep_6);
    newSleep_4 = min((_e1057 + 1u), 255u);
    let _e1060 = (*currentIndex_11);
    let _e1063 = (*rawValue_9);
    param_792 = 1u;
    param_793 = 0u;
    let _e1064 = newSleep_4;
    param_794 = _e1064;
    let _e1065 = moisture_5;
    param_795 = _e1065;
    let _e1066 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_792), (&param_793), (&param_794), (&param_795));
    let _e1067 = atomicCompareExchangeWeak((&unnamed.grid[_e1060]), _e1063, _e1066);
    return;
}

fn orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b(pos_16: ptr<function, vec3<i32>>, currentIndex_12: ptr<function, u32>, rawValue_10: ptr<function, u32>, stepDir: ptr<function, vec3<i32>>) -> bool {
    var target_3: vec3<i32>;
    var targetIndex_3: u32;
    var param_796: vec3<i32>;
    var param_797: u32;
    var param_798: u32;
    var param_799: u32;
    var param_800: u32;
    var param_801: u32;
    var param_802: u32;
    var param_803: u32;
    var param_804: u32;
    var param_805: u32;
    var param_806: u32;
    var param_807: u32;
    var param_808: u32;
    var param_809: u32;
    var phi_1758_: bool;
    var phi_1765_: bool;
    var phi_1776_: bool;
    var phi_1783_: bool;
    var phi_1794_: bool;

    let _e216 = (*stepDir);
    if all((_e216 == vec3<i32>(0i, 0i, 0i))) {
        return false;
    }
    let _e219 = (*pos_16);
    let _e220 = (*stepDir);
    target_3 = (_e219 + _e220);
    let _e223 = target_3[0u];
    let _e224 = (_e223 < 1i);
    phi_1758_ = _e224;
    if !(_e224) {
        let _e227 = target_3[0u];
        let _e229 = tuning.gridWidth;
        phi_1758_ = (_e227 >= (bitcast<i32>(_e229) - 1i));
    }
    let _e234 = phi_1758_;
    phi_1765_ = _e234;
    if !(_e234) {
        let _e237 = target_3[1u];
        phi_1765_ = (_e237 < 1i);
    }
    let _e240 = phi_1765_;
    phi_1776_ = _e240;
    if !(_e240) {
        let _e243 = target_3[1u];
        let _e245 = tuning.gridHeight;
        phi_1776_ = (_e243 >= (bitcast<i32>(_e245) - 1i));
    }
    let _e250 = phi_1776_;
    phi_1783_ = _e250;
    if !(_e250) {
        let _e253 = target_3[2u];
        phi_1783_ = (_e253 < 1i);
    }
    let _e256 = phi_1783_;
    phi_1794_ = _e256;
    if !(_e256) {
        let _e259 = target_3[2u];
        let _e261 = tuning.gridDepth;
        phi_1794_ = (_e259 >= (bitcast<i32>(_e261) - 1i));
    }
    let _e266 = phi_1794_;
    if _e266 {
        return false;
    }
    let _e267 = target_3;
    param_796 = _e267;
    let _e268 = getIndex_u0028_vi3_u003b((&param_796));
    targetIndex_3 = _e268;
    let _e269 = targetIndex_3;
    param_797 = _e269;
    let _e270 = readCell_u0028_u1_u003b((&param_797));
    param_798 = _e270;
    let _e271 = getType_u0028_u1_u003b((&param_798));
    if (_e271 != 0u) {
        return false;
    }
    let _e273 = (*rawValue_10);
    param_799 = _e273;
    let _e274 = getType_u0028_u1_u003b((&param_799));
    let _e275 = (*rawValue_10);
    param_800 = _e275;
    let _e276 = getDir_u0028_u1_u003b((&param_800));
    let _e277 = (*rawValue_10);
    param_801 = _e277;
    let _e278 = getAge_u0028_u1_u003b((&param_801));
    param_802 = _e274;
    param_803 = _e276;
    param_804 = 0u;
    param_805 = _e278;
    let _e279 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_802), (&param_803), (&param_804), (&param_805));
    let _e280 = (*currentIndex_12);
    param_806 = _e280;
    let _e281 = (*rawValue_10);
    param_807 = _e281;
    let _e282 = targetIndex_3;
    param_808 = _e282;
    param_809 = _e279;
    let _e283 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_806), (&param_807), (&param_808), (&param_809));
    return _e283;
}

fn dominantAxis_u0028_vf3_u003b_f1_u003b(dir_6: ptr<function, vec3<f32>>, relative: ptr<function, f32>) -> vec3<i32> {
    var a: vec3<f32>;
    var m: f32;

    let _e200 = (*dir_6);
    a = abs(_e200);
    let _e203 = a[0u];
    let _e205 = a[1u];
    let _e207 = a[2u];
    m = max(_e203, max(_e205, _e207));
    let _e210 = m;
    if (_e210 <= 0f) {
        return vec3<i32>(0i, 0i, 0i);
    }
    let _e212 = a;
    let _e213 = m;
    let _e214 = (*relative);
    let _e219 = (*dir_6);
    return (select(vec3<i32>(0i, 0i, 0i), vec3<i32>(1i, 1i, 1i), (_e212 >= vec3((_e213 * _e214)))) * vec3<i32>(sign(_e219)));
}

fn bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b(k_1: ptr<function, i32>, planeCount: ptr<function, i32>, seed: ptr<function, f32>) -> vec3<f32> {
    var z_4: f32;
    var r_4: f32;
    var a_1: f32;

    let _e202 = (*k_1);
    let _e205 = (*planeCount);
    z_4 = ((f32(_e202) + 0.5f) / f32(_e205));
    let _e208 = z_4;
    let _e209 = z_4;
    r_4 = sqrt(max(0f, (1f - (_e208 * _e209))));
    let _e214 = (*k_1);
    let _e217 = (*seed);
    a_1 = ((2.399963f * f32(_e214)) + _e217);
    let _e219 = r_4;
    let _e220 = a_1;
    let _e223 = z_4;
    let _e224 = r_4;
    let _e225 = a_1;
    return vec3<f32>((_e219 * cos(_e220)), _e223, (_e224 * sin(_e225)));
}

fn hash_u0028_vf3_u003b(p_4: ptr<function, vec3<f32>>) -> f32 {
    let _e197 = (*p_4);
    return fract((sin(dot(_e197, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn bhOrbitAxis_u0028_vi3_u003b_vi3_u003b(center: ptr<function, vec3<i32>>, pos_17: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radial: vec3<f32>;
    var planeCount_1: i32;
    var seed_1: f32;
    var param_810: vec3<f32>;
    var best: vec3<f32>;
    var bestAlign: f32;
    var bestK: i32;
    var k_2: i32;
    var n_2: vec3<f32>;
    var param_811: i32;
    var param_812: i32;
    var param_813: f32;
    var align: f32;
    var sense: f32;
    var param_814: vec3<f32>;

    let _e213 = (*pos_17);
    let _e214 = (*center);
    radial = normalize(vec3<f32>((_e213 - _e214)));
    let _e219 = tuning.blackHoleOrbitPlanes;
    planeCount_1 = bitcast<i32>(clamp(_e219, 1u, 32u));
    let _e222 = (*center);
    param_810 = (vec3<f32>(_e222) + vec3<f32>(29f, 3f, 71f));
    let _e225 = hash_u0028_vf3_u003b((&param_810));
    seed_1 = (_e225 * 6.28318f);
    best = vec3<f32>(0f, 1f, 0f);
    bestAlign = 2f;
    bestK = 0i;
    k_2 = 0i;
    loop {
        let _e227 = k_2;
        let _e228 = planeCount_1;
        if (_e227 < _e228) {
            let _e230 = k_2;
            param_811 = _e230;
            let _e231 = planeCount_1;
            param_812 = _e231;
            let _e232 = seed_1;
            param_813 = _e232;
            let _e233 = bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b((&param_811), (&param_812), (&param_813));
            n_2 = _e233;
            let _e234 = n_2;
            let _e235 = radial;
            align = abs(dot(_e234, _e235));
            let _e238 = align;
            let _e239 = bestAlign;
            if (_e238 < _e239) {
                let _e241 = align;
                bestAlign = _e241;
                let _e242 = n_2;
                best = _e242;
                let _e243 = k_2;
                bestK = _e243;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e244 = k_2;
            k_2 = (_e244 + 1i);
        }
    }
    let _e246 = (*center);
    let _e248 = bestK;
    param_814 = (vec3<f32>(_e246) + vec3<f32>((f32(_e248) * 13f), 101f, 47f));
    let _e253 = hash_u0028_vf3_u003b((&param_814));
    sense = select(1f, -1f, (_e253 < 0.5f));
    let _e256 = best;
    let _e257 = sense;
    return (_e256 * _e257);
}

fn bhIsPurge_u0028_u1_u003b(code: ptr<function, u32>) -> bool {
    let _e197 = (*code);
    return ((_e197 & 1073741824u) != 0u);
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e197 = (*level);
    return (f32(_e197) + 0.5f);
}

fn updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b(pos_18: ptr<function, vec3<i32>>, currentIndex_13: ptr<function, u32>, rawValue_11: ptr<function, u32>, center_1: ptr<function, vec3<i32>>, slot: ptr<function, i32>, level_1: ptr<function, u32>, purge: ptr<function, bool>, dist_1: ptr<function, f32>, randVal_12: ptr<function, f32>) {
    var type_37: u32;
    var param_815: u32;
    var sleep_1: u32;
    var param_816: u32;
    var param_817: u32;
    var param_818: u32;
    var orbitSpeed: f32;
    var local_27: f32;
    var infallChance: f32;
    var local_28: f32;
    var param_819: u32;
    var param_820: u32;
    var param_821: u32;
    var param_822: u32;
    var param_823: u32;
    var param_824: u32;
    var inward: vec3<f32>;
    var axis: vec3<f32>;
    var param_825: vec3<i32>;
    var param_826: vec3<i32>;
    var tangent: vec3<f32>;
    var tangentLen: f32;
    var axial: f32;
    var grip: vec3<f32>;
    var along: vec3<f32>;
    var pullIn: bool;
    var spiral: vec3<f32>;
    var param_827: vec3<f32>;
    var param_828: f32;
    var param_829: vec3<i32>;
    var param_830: u32;
    var param_831: u32;
    var param_832: vec3<i32>;
    var param_833: vec3<f32>;
    var param_834: f32;
    var param_835: vec3<i32>;
    var param_836: u32;
    var param_837: u32;
    var param_838: vec3<i32>;
    var param_839: vec3<f32>;
    var param_840: f32;
    var param_841: vec3<i32>;
    var param_842: u32;
    var param_843: u32;
    var param_844: vec3<i32>;
    var param_845: vec3<f32>;
    var param_846: f32;
    var param_847: vec3<i32>;
    var param_848: u32;
    var param_849: u32;
    var param_850: vec3<i32>;
    var param_851: vec3<f32>;
    var param_852: f32;
    var param_853: vec3<i32>;
    var param_854: u32;
    var param_855: u32;
    var param_856: vec3<i32>;
    var param_857: vec3<f32>;
    var param_858: f32;
    var param_859: vec3<i32>;
    var param_860: u32;
    var param_861: u32;
    var param_862: vec3<i32>;
    var param_863: u32;
    var param_864: u32;
    var param_865: u32;
    var param_866: u32;
    var param_867: u32;
    var param_868: u32;
    var phi_2057_: bool;

    let _e274 = (*rawValue_11);
    param_815 = _e274;
    let _e275 = getType_u0028_u1_u003b((&param_815));
    type_37 = _e275;
    let _e276 = (*rawValue_11);
    param_816 = _e276;
    let _e277 = getSleep_u0028_u1_u003b((&param_816));
    sleep_1 = _e277;
    let _e278 = (*slot);
    unnamed_2.blackHoleStarve[_e278] = 0u;
    let _e281 = (*dist_1);
    let _e282 = (*level_1);
    param_817 = _e282;
    let _e283 = bhBodyRadius_u0028_u1_u003b((&param_817));
    let _e285 = tuning.blackHoleHorizon;
    if (_e281 <= (_e283 + f32(_e285))) {
        let _e289 = (*currentIndex_13);
        let _e292 = (*rawValue_11);
        let _e293 = atomicCompareExchangeWeak((&unnamed.grid[_e289]), _e292, 0u);
        let _e295 = (*rawValue_11);
        if (_e293.old_value == _e295) {
            let _e297 = (*slot);
            let _e300 = atomicLoad((&unnamed_2.blackHoles[_e297]));
            param_818 = _e300;
            let _e301 = bhIsPurge_u0028_u1_u003b((&param_818));
            if !(_e301) {
                let _e303 = (*slot);
                let _e306 = atomicAdd((&unnamed_2.blackHoleMass[_e303]), 1u);
            }
            let _e307 = type_37;
            if (_e307 == 2u) {
                decWater_u0028_();
            }
        }
        return;
    }
    let _e309 = (*purge);
    if _e309 {
        let _e311 = tuning.purgeOrbitSpeed;
        local_27 = _e311;
    } else {
        let _e313 = tuning.blackHoleOrbitSpeed;
        local_27 = _e313;
    }
    let _e314 = local_27;
    orbitSpeed = _e314;
    let _e315 = (*purge);
    if _e315 {
        let _e317 = tuning.purgeInfall;
        local_28 = _e317;
    } else {
        let _e319 = tuning.blackHoleInfall;
        local_28 = _e319;
    }
    let _e320 = local_28;
    infallChance = _e320;
    let _e321 = (*randVal_12);
    let _e322 = orbitSpeed;
    let _e323 = (*dist_1);
    if (_e321 > clamp((_e322 / sqrt(max(_e323, 1f))), 0f, 1f)) {
        let _e329 = sleep_1;
        if (_e329 != 0u) {
            let _e331 = (*currentIndex_13);
            let _e334 = (*rawValue_11);
            let _e335 = (*rawValue_11);
            param_819 = _e335;
            let _e336 = getDir_u0028_u1_u003b((&param_819));
            let _e337 = (*rawValue_11);
            param_820 = _e337;
            let _e338 = getAge_u0028_u1_u003b((&param_820));
            let _e339 = type_37;
            param_821 = _e339;
            param_822 = _e336;
            param_823 = 0u;
            param_824 = _e338;
            let _e340 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_821), (&param_822), (&param_823), (&param_824));
            let _e341 = atomicCompareExchangeWeak((&unnamed.grid[_e331]), _e334, _e340);
        }
        return;
    }
    let _e343 = (*center_1);
    let _e344 = (*pos_18);
    inward = normalize(vec3<f32>((_e343 - _e344)));
    let _e348 = (*center_1);
    param_825 = _e348;
    let _e349 = (*pos_18);
    param_826 = _e349;
    let _e350 = bhOrbitAxis_u0028_vi3_u003b_vi3_u003b((&param_825), (&param_826));
    axis = _e350;
    let _e351 = axis;
    let _e352 = inward;
    tangent = cross(_e351, _e352);
    let _e354 = tangent;
    tangentLen = length(_e354);
    let _e356 = tangentLen;
    if (_e356 < 0.05f) {
        let _e358 = axis;
        tangent = normalize(cross(_e358, vec3<f32>(0.577f, 0.577f, 0.577f)));
    } else {
        let _e361 = tangentLen;
        let _e362 = tangent;
        tangent = (_e362 / vec3(_e361));
    }
    let _e365 = (*pos_18);
    let _e366 = (*center_1);
    let _e369 = axis;
    axial = dot(vec3<f32>((_e365 - _e366)), _e369);
    let _e371 = axis;
    let _e373 = axial;
    let _e378 = tuning.blackHolePlaneGrip;
    grip = ((-(_e371) * clamp((_e373 * 0.5f), -1f, 1f)) * _e378);
    let _e380 = tangent;
    let _e381 = grip;
    along = normalize((_e380 + _e381));
    let _e384 = (*randVal_12);
    let _e387 = infallChance;
    pullIn = (fract((_e384 * 61f)) < clamp(_e387, 0f, 1f));
    let _e390 = inward;
    let _e391 = tangent;
    spiral = normalize((_e390 + (_e391 * 0.6f)));
    let _e395 = pullIn;
    phi_2057_ = _e395;
    if _e395 {
        let _e396 = spiral;
        param_827 = _e396;
        param_828 = 0.55f;
        let _e397 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_827), (&param_828));
        let _e398 = (*pos_18);
        param_829 = _e398;
        let _e399 = (*currentIndex_13);
        param_830 = _e399;
        let _e400 = (*rawValue_11);
        param_831 = _e400;
        param_832 = _e397;
        let _e401 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_829), (&param_830), (&param_831), (&param_832));
        phi_2057_ = _e401;
    }
    let _e403 = phi_2057_;
    if _e403 {
        return;
    }
    let _e404 = along;
    param_833 = _e404;
    param_834 = 0.55f;
    let _e405 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_833), (&param_834));
    let _e406 = (*pos_18);
    param_835 = _e406;
    let _e407 = (*currentIndex_13);
    param_836 = _e407;
    let _e408 = (*rawValue_11);
    param_837 = _e408;
    param_838 = _e405;
    let _e409 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_835), (&param_836), (&param_837), (&param_838));
    if _e409 {
        return;
    }
    let _e410 = along;
    param_839 = _e410;
    param_840 = 1f;
    let _e411 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_839), (&param_840));
    let _e412 = (*pos_18);
    param_841 = _e412;
    let _e413 = (*currentIndex_13);
    param_842 = _e413;
    let _e414 = (*rawValue_11);
    param_843 = _e414;
    param_844 = _e411;
    let _e415 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_841), (&param_842), (&param_843), (&param_844));
    if _e415 {
        return;
    }
    let _e416 = tangent;
    param_845 = _e416;
    param_846 = 1f;
    let _e417 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_845), (&param_846));
    let _e418 = (*pos_18);
    param_847 = _e418;
    let _e419 = (*currentIndex_13);
    param_848 = _e419;
    let _e420 = (*rawValue_11);
    param_849 = _e420;
    param_850 = _e417;
    let _e421 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_847), (&param_848), (&param_849), (&param_850));
    if _e421 {
        return;
    }
    let _e422 = inward;
    param_851 = _e422;
    param_852 = 0.55f;
    let _e423 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_851), (&param_852));
    let _e424 = (*pos_18);
    param_853 = _e424;
    let _e425 = (*currentIndex_13);
    param_854 = _e425;
    let _e426 = (*rawValue_11);
    param_855 = _e426;
    param_856 = _e423;
    let _e427 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_853), (&param_854), (&param_855), (&param_856));
    if _e427 {
        return;
    }
    let _e428 = inward;
    param_857 = _e428;
    param_858 = 1f;
    let _e429 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_857), (&param_858));
    let _e430 = (*pos_18);
    param_859 = _e430;
    let _e431 = (*currentIndex_13);
    param_860 = _e431;
    let _e432 = (*rawValue_11);
    param_861 = _e432;
    param_862 = _e429;
    let _e433 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_859), (&param_860), (&param_861), (&param_862));
    if _e433 {
        return;
    }
    let _e434 = sleep_1;
    if (_e434 != 0u) {
        let _e436 = (*currentIndex_13);
        let _e439 = (*rawValue_11);
        let _e440 = (*rawValue_11);
        param_863 = _e440;
        let _e441 = getDir_u0028_u1_u003b((&param_863));
        let _e442 = (*rawValue_11);
        param_864 = _e442;
        let _e443 = getAge_u0028_u1_u003b((&param_864));
        let _e444 = type_37;
        param_865 = _e444;
        param_866 = _e441;
        param_867 = 0u;
        param_868 = _e443;
        let _e445 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_865), (&param_866), (&param_867), (&param_868));
        let _e446 = atomicCompareExchangeWeak((&unnamed.grid[_e436]), _e439, _e445);
    }
    return;
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_2: u32;
    var l: u32;
    var r_5: f32;
    var param_869: u32;
    var volume: f32;

    level_2 = 0u;
    l = 1u;
    loop {
        let _e202 = l;
        let _e204 = tuning.blackHoleMaxLevel;
        if (_e202 <= min(_e204, 16u)) {
            let _e207 = l;
            param_869 = _e207;
            let _e208 = bhBodyRadius_u0028_u1_u003b((&param_869));
            r_5 = _e208;
            let _e209 = r_5;
            let _e211 = r_5;
            let _e213 = r_5;
            volume = (((4.18879f * _e209) * _e211) * _e213);
            let _e215 = (*mass);
            let _e218 = tuning.blackHoleGrowthCost;
            let _e219 = volume;
            if (f32(_e215) < (_e218 * _e219)) {
                break;
            }
            let _e222 = l;
            level_2 = _e222;
            continue;
        } else {
            break;
        }
        continuing {
            let _e223 = l;
            l = (_e223 + bitcast<u32>(1i));
        }
    }
    let _e226 = level_2;
    return _e226;
}

fn bhLevelFor_u0028_u1_u003b_u1_u003b(code_1: ptr<function, u32>, mass_1: ptr<function, u32>) -> u32 {
    var param_870: u32;
    var param_871: u32;

    let _e200 = (*code_1);
    param_870 = _e200;
    let _e201 = bhIsPurge_u0028_u1_u003b((&param_870));
    if _e201 {
        let _e203 = tuning.purgeLevel;
        let _e205 = (*mass_1);
        let _e208 = tuning.purgeMass;
        return u32((f32(_e203) * clamp((f32(_e205) / f32(max(_e208, 1u))), 0f, 1f)));
    }
    let _e215 = (*mass_1);
    param_871 = _e215;
    let _e216 = bhLevel_u0028_u1_u003b((&param_871));
    return _e216;
}

fn bhDecode_u0028_u1_u003b(code_2: ptr<function, u32>) -> vec3<i32> {
    var i_24: u32;

    let _e198 = (*code_2);
    i_24 = (_e198 & 1073741823u);
    let _e200 = i_24;
    let _e202 = tuning.gridWidth;
    let _e207 = i_24;
    let _e209 = tuning.gridWidth;
    let _e214 = tuning.gridHeight;
    let _e219 = i_24;
    let _e221 = tuning.gridWidth;
    let _e224 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e200 % bitcast<u32>(bitcast<i32>(_e202)))), bitcast<i32>(((_e207 / bitcast<u32>(bitcast<i32>(_e209))) % bitcast<u32>(bitcast<i32>(_e214)))), bitcast<i32>((_e219 / bitcast<u32>((bitcast<i32>(_e221) * bitcast<i32>(_e224))))));
}

fn captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b(pos_19: ptr<function, vec3<i32>>, currentIndex_14: ptr<function, u32>, rawValue_12: ptr<function, u32>, randVal_13: ptr<function, f32>) -> bool {
    var bestDistSq: f32;
    var bestCenter: vec3<i32>;
    var bestSlot: i32;
    var bestLevel: u32;
    var bestPurge: bool;
    var maxRadius: f32;
    var maxRadiusSq: f32;
    var i_25: i32;
    var code_3: u32;
    var center_2: vec3<i32>;
    var param_872: u32;
    var d_23: vec3<f32>;
    var distSq: f32;
    var purge_1: bool;
    var param_873: u32;
    var level_3: u32;
    var param_874: u32;
    var param_875: u32;
    var radius: f32;
    var local_29: f32;
    var param_876: vec3<i32>;
    var param_877: u32;
    var param_878: u32;
    var param_879: vec3<i32>;
    var param_880: i32;
    var param_881: u32;
    var param_882: bool;
    var param_883: f32;
    var param_884: f32;

    let _e230 = unnamed_2.blackHoleCount;
    if (_e230 == 0u) {
        return false;
    }
    bestDistSq = 3000000000f;
    bestCenter = vec3<i32>(0i, 0i, 0i);
    bestSlot = -1i;
    bestLevel = 0u;
    bestPurge = false;
    let _e233 = tuning.blackHoleRadius;
    let _e235 = tuning.blackHoleMaxLevel;
    maxRadius = f32((_e233 + min(_e235, 16u)));
    let _e239 = maxRadius;
    let _e240 = maxRadius;
    maxRadiusSq = (_e239 * _e240);
    i_25 = 0i;
    loop {
        let _e242 = i_25;
        if (_e242 < 8i) {
            let _e244 = i_25;
            let _e247 = atomicLoad((&unnamed_2.blackHoles[_e244]));
            code_3 = _e247;
            let _e248 = code_3;
            if (_e248 == 0u) {
                continue;
            }
            let _e250 = code_3;
            param_872 = _e250;
            let _e251 = bhDecode_u0028_u1_u003b((&param_872));
            center_2 = _e251;
            let _e252 = center_2;
            let _e253 = (*pos_19);
            d_23 = vec3<f32>((_e252 - _e253));
            let _e256 = d_23;
            let _e257 = d_23;
            distSq = dot(_e256, _e257);
            let _e259 = code_3;
            param_873 = _e259;
            let _e260 = bhIsPurge_u0028_u1_u003b((&param_873));
            purge_1 = _e260;
            let _e261 = purge_1;
            let _e263 = distSq;
            let _e264 = maxRadiusSq;
            if (!(_e261) && (_e263 > _e264)) {
                continue;
            }
            let _e267 = distSq;
            let _e268 = bestDistSq;
            if (_e267 >= _e268) {
                continue;
            }
            let _e270 = i_25;
            let _e271 = code_3;
            param_874 = _e271;
            let _e274 = atomicLoad((&unnamed_2.blackHoleMass[_e270]));
            param_875 = _e274;
            let _e275 = bhLevelFor_u0028_u1_u003b_u1_u003b((&param_874), (&param_875));
            level_3 = _e275;
            let _e276 = purge_1;
            if _e276 {
                local_29 = 1000000000f;
            } else {
                let _e278 = tuning.blackHoleRadius;
                let _e279 = level_3;
                local_29 = f32((_e278 + _e279));
            }
            let _e282 = local_29;
            radius = _e282;
            let _e283 = distSq;
            let _e284 = radius;
            let _e285 = radius;
            if (_e283 <= (_e284 * _e285)) {
                let _e288 = distSq;
                bestDistSq = _e288;
                let _e289 = center_2;
                bestCenter = _e289;
                let _e290 = i_25;
                bestSlot = _e290;
                let _e291 = level_3;
                bestLevel = _e291;
                let _e292 = purge_1;
                bestPurge = _e292;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e293 = i_25;
            i_25 = (_e293 + 1i);
        }
    }
    let _e295 = bestSlot;
    if (_e295 < 0i) {
        return false;
    }
    let _e297 = bestDistSq;
    let _e299 = (*pos_19);
    param_876 = _e299;
    let _e300 = (*currentIndex_14);
    param_877 = _e300;
    let _e301 = (*rawValue_12);
    param_878 = _e301;
    let _e302 = bestCenter;
    param_879 = _e302;
    let _e303 = bestSlot;
    param_880 = _e303;
    let _e304 = bestLevel;
    param_881 = _e304;
    let _e305 = bestPurge;
    param_882 = _e305;
    param_883 = sqrt(_e297);
    let _e306 = (*randVal_13);
    param_884 = _e306;
    updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b((&param_876), (&param_877), (&param_878), (&param_879), (&param_880), (&param_881), (&param_882), (&param_883), (&param_884));
    return true;
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x_4: ptr<function, i32>, z_5: ptr<function, i32>) -> u32 {
    let _e198 = (*x_4);
    let _e199 = (*z_5);
    let _e201 = tuning.gridWidth;
    return (bitcast<u32>((_e198 + (_e199 * bitcast<i32>(_e201)))) * 4u);
}

fn bhRegister_u0028_vi3_u003b(p_5: ptr<function, vec3<i32>>) -> bool {
    var code_4: u32;
    var param_885: vec3<i32>;
    var i_26: i32;

    let _e200 = (*p_5);
    param_885 = _e200;
    let _e201 = getIndex_u0028_vi3_u003b((&param_885));
    code_4 = (2147483648u | _e201);
    i_26 = 0i;
    loop {
        let _e203 = i_26;
        if (_e203 < 8i) {
            let _e205 = i_26;
            let _e208 = code_4;
            let _e209 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e205]), 0u, _e208);
            if (_e209.old_value == 0u) {
                let _e212 = i_26;
                atomicStore((&unnamed_2.blackHoleMass[_e212]), 0u);
                let _e215 = i_26;
                unnamed_2.blackHoleStarve[_e215] = 0u;
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e218 = i_26;
            i_26 = (_e218 + 1i);
        }
    }
    return false;
}

fn writeCell_u0028_u1_u003b_u1_u003b(index_1: ptr<function, u32>, value_2: ptr<function, u32>) {
    let _e198 = (*index_1);
    let _e199 = (*value_2);
    atomicStore((&unnamed.grid[_e198]), _e199);
    return;
}

fn lavaSpawnCoolness_u0028_u1_u003b(type_38: ptr<function, u32>) -> u32 {
    var param_886: u32;

    let _e198 = (*type_38);
    if (_e198 == 12u) {
        let _e200 = lavaSolidifyCoolness_u0028_();
        return _e200;
    }
    let _e201 = (*type_38);
    param_886 = _e201;
    let _e202 = isLava_u0028_u1_u003b((&param_886));
    if _e202 {
        let _e203 = (*type_38);
        let _e206 = tuning.lavaStageSize;
        return ((_e203 - 8u) * max(_e206, 1u));
    }
    return 0u;
}

fn locustSpawnCount_u0028_u1_u003b(type_39: ptr<function, u32>) -> u32 {
    var param_887: u32;

    let _e198 = (*type_39);
    param_887 = _e198;
    let _e199 = isLocust_u0028_u1_u003b((&param_887));
    if !(_e199) {
        return 0u;
    }
    let _e201 = (*type_39);
    let _e204 = locustStage_u0028_();
    let _e206 = locustMaxCount_u0028_();
    return min((((_e201 - 13u) + 1u) * _e204), _e206);
}

fn bhRelease_u0028_vi3_u003b(p_6: ptr<function, vec3<i32>>) {
    var code_5: u32;
    var param_888: vec3<i32>;
    var i_27: i32;

    let _e200 = (*p_6);
    param_888 = _e200;
    let _e201 = getIndex_u0028_vi3_u003b((&param_888));
    code_5 = (2147483648u | _e201);
    i_27 = 0i;
    loop {
        let _e203 = i_27;
        if (_e203 < 8i) {
            let _e205 = i_27;
            let _e208 = code_5;
            let _e209 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e205]), _e208, 0u);
            continue;
        } else {
            break;
        }
        continuing {
            let _e211 = i_27;
            i_27 = (_e211 + 1i);
        }
    }
    return;
}

fn inBrush_u0028_vi3_u003b(pos_20: ptr<function, vec3<i32>>) -> bool {
    var halfMin: i32;
    var halfMax: i32;
    var center_3: vec3<f32>;
    var d_24: vec3<f32>;
    var radius_1: f32;
    var phi_1519_: bool;
    var phi_1541_: bool;
    var phi_1562_: bool;

    let _e203 = pc.spawnSize;
    halfMin = (_e203 / 2i);
    let _e206 = pc.spawnSize;
    halfMax = ((_e206 - 1i) / 2i);
    let _e210 = (*pos_20)[0u];
    let _e212 = pc.spawnX;
    let _e213 = halfMin;
    let _e215 = (_e210 < (_e212 - _e213));
    phi_1519_ = _e215;
    if !(_e215) {
        let _e218 = (*pos_20)[0u];
        let _e220 = pc.spawnX;
        let _e221 = halfMax;
        phi_1519_ = (_e218 > (_e220 + _e221));
    }
    let _e225 = phi_1519_;
    if _e225 {
        return false;
    }
    let _e227 = (*pos_20)[1u];
    let _e229 = pc.spawnY;
    let _e230 = halfMin;
    let _e232 = (_e227 < (_e229 - _e230));
    phi_1541_ = _e232;
    if !(_e232) {
        let _e235 = (*pos_20)[1u];
        let _e237 = pc.spawnY;
        let _e238 = halfMax;
        phi_1541_ = (_e235 > (_e237 + _e238));
    }
    let _e242 = phi_1541_;
    if _e242 {
        return false;
    }
    let _e244 = (*pos_20)[2u];
    let _e246 = pc.spawnZ;
    let _e247 = halfMin;
    let _e249 = (_e244 < (_e246 - _e247));
    phi_1562_ = _e249;
    if !(_e249) {
        let _e252 = (*pos_20)[2u];
        let _e254 = pc.spawnZ;
        let _e255 = halfMax;
        phi_1562_ = (_e252 > (_e254 + _e255));
    }
    let _e259 = phi_1562_;
    if _e259 {
        return false;
    }
    let _e261 = pc.spawnShape;
    if (_e261 != 1i) {
        return true;
    }
    let _e264 = pc.spawnX;
    let _e267 = pc.spawnY;
    let _e270 = pc.spawnZ;
    let _e273 = halfMax;
    let _e274 = halfMin;
    center_3 = (vec3<f32>(f32(_e264), f32(_e267), f32(_e270)) + vec3((f32(((_e273 - _e274) + 1i)) * 0.5f)));
    let _e281 = (*pos_20);
    let _e285 = center_3;
    d_24 = ((vec3<f32>(_e281) + vec3(0.5f)) - _e285);
    let _e288 = pc.spawnSize;
    radius_1 = (f32(_e288) * 0.5f);
    let _e291 = d_24;
    let _e292 = d_24;
    let _e294 = radius_1;
    let _e295 = radius_1;
    return (dot(_e291, _e292) <= (_e294 * _e295));
}

fn tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(fromIndex: ptr<function, u32>, newValue_4: ptr<function, u32>, toIndex: ptr<function, u32>, expectedFromValue: ptr<function, u32>) -> bool {
    let _e200 = (*toIndex);
    let _e203 = (*newValue_4);
    let _e204 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e200]), 0u, _e203);
    if (_e204.old_value != 0u) {
        return false;
    }
    let _e207 = (*fromIndex);
    let _e210 = (*expectedFromValue);
    let _e211 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e207]), _e210, 0u);
    let _e213 = (*expectedFromValue);
    if (_e211.old_value != _e213) {
        let _e215 = (*toIndex);
        let _e218 = atomicExchange((&unnamed_1.cloudCells[_e215]), 0u);
        return false;
    }
    return true;
}

fn getCloudCounter_u0028_u1_u003b(v_5: ptr<function, u32>) -> u32 {
    let _e197 = (*v_5);
    return ((_e197 >> bitcast<u32>(3i)) & 2047u);
}

fn getCloudTarget_u0028_u1_u003b(v_6: ptr<function, u32>) -> u32 {
    let _e197 = (*v_6);
    return ((_e197 >> bitcast<u32>(14i)) & 2047u);
}

fn updateCloudBlock_u0028_vi3_u003b(pos_21: ptr<function, vec3<i32>>) {
    var idx_4: u32;
    var param_889: vec3<i32>;
    var base: u32;
    var param_890: i32;
    var param_891: i32;
    var cell: u32;
    var kind_1: u32;
    var param_892: u32;
    var param_893: vec3<i32>;
    var newCell: u32;
    var param_894: u32;
    var param_895: bool;
    var param_896: u32;
    var param_897: u32;
    var param_898: u32;
    var param_899: u32;
    var param_900: bool;
    var param_901: u32;
    var param_902: u32;
    var target_4: u32;
    var param_903: u32;
    var lo: u32;
    var hi: u32;
    var r_6: f32;
    var param_904: vec3<f32>;
    var param_905: u32;
    var param_906: bool;
    var param_907: u32;
    var param_908: u32;
    var counter_1: u32;
    var param_909: u32;
    var param_910: u32;
    var param_911: bool;
    var param_912: u32;
    var param_913: u32;
    var param_914: vec3<i32>;
    var g: u32;
    var param_915: u32;
    var param_916: u32;
    var param_917: u32;
    var param_918: u32;
    var param_919: u32;
    var param_920: u32;
    var randVal_14: f32;
    var param_921: vec3<f32>;
    var counter_2: u32;
    var param_922: u32;
    var target_5: u32;
    var param_923: u32;
    var upPos_2: vec3<i32>;
    var param_924: vec3<i32>;
    var param_925: vec3<i32>;
    var param_926: u32;
    var param_927: u32;
    var param_928: bool;
    var param_929: u32;
    var param_930: u32;
    var param_931: vec3<i32>;
    var param_932: u32;
    var param_933: u32;
    var param_934: u32;
    var param_935: u32;
    var dir_7: i32;
    var slide1_: vec3<i32>;
    var slide2_: vec3<i32>;
    var i_28: i32;
    var t_4: vec3<i32>;
    var param_936: vec3<i32>;
    var tIndex: u32;
    var param_937: vec3<i32>;
    var param_938: u32;
    var param_939: u32;
    var param_940: bool;
    var param_941: u32;
    var param_942: u32;
    var param_943: u32;
    var param_944: u32;
    var param_945: u32;
    var param_946: u32;
    var param_947: u32;
    var param_948: u32;
    var param_949: bool;
    var param_950: u32;
    var param_951: u32;
    var phi_8864_: bool;
    var phi_8865_: bool;
    var phi_9073_: bool;

    let _e281 = (*pos_21);
    param_889 = _e281;
    let _e282 = getIndex_u0028_vi3_u003b((&param_889));
    idx_4 = _e282;
    let _e284 = (*pos_21)[0u];
    param_890 = _e284;
    let _e286 = (*pos_21)[2u];
    param_891 = _e286;
    let _e287 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_890), (&param_891));
    base = _e287;
    let _e289 = (*pos_21)[1u];
    if (_e289 == 0i) {
        let _e291 = base;
        let _e293 = base;
        let _e297 = atomicLoad((&unnamed_2.cloudColumn[(_e293 + 0u)]));
        atomicStore((&unnamed_2.cloudColumn[(_e291 + 2u)]), _e297);
        let _e300 = base;
        let _e302 = base;
        let _e306 = atomicLoad((&unnamed_2.cloudColumn[(_e302 + 1u)]));
        atomicStore((&unnamed_2.cloudColumn[(_e300 + 3u)]), _e306);
        let _e309 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e309 + 0u)]), 0u);
        let _e313 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e313 + 1u)]), 0u);
    }
    let _e317 = idx_4;
    let _e320 = atomicLoad((&unnamed_1.cloudCells[_e317]));
    cell = _e320;
    let _e321 = cell;
    param_892 = _e321;
    let _e322 = getCloudKind_u0028_u1_u003b((&param_892));
    kind_1 = _e322;
    let _e323 = kind_1;
    if (_e323 == 0u) {
        return;
    }
    let _e326 = atomicAdd((&unnamed_2.cloudBlockCount), 1u);
    let _e327 = base;
    let _e331 = atomicAdd((&unnamed_2.cloudColumn[(_e327 + 0u)]), 1u);
    let _e332 = base;
    let _e337 = (*pos_21)[1u];
    let _e339 = atomicMax((&unnamed_2.cloudColumn[(_e332 + 1u)]), bitcast<u32>(_e337));
    let _e340 = kind_1;
    let _e341 = (_e340 == 1u);
    phi_8865_ = _e341;
    if _e341 {
        let _e343 = unnamed_2.rainPhase;
        let _e344 = (_e343 == 2u);
        phi_8864_ = _e344;
        if !(_e344) {
            let _e346 = (*pos_21);
            param_893 = _e346;
            let _e347 = cloudTouchesRain_u0028_vi3_u003b((&param_893));
            phi_8864_ = _e347;
        }
        let _e349 = phi_8864_;
        phi_8865_ = _e349;
    }
    let _e351 = phi_8865_;
    if _e351 {
        param_894 = 2u;
        param_895 = false;
        param_896 = 0u;
        param_897 = 0u;
        let _e352 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_894), (&param_895), (&param_896), (&param_897));
        newCell = _e352;
        let _e353 = idx_4;
        let _e356 = cell;
        let _e357 = newCell;
        let _e358 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e353]), _e356, _e357);
        let _e360 = cell;
        if (_e358.old_value != _e360) {
            return;
        }
        let _e362 = newCell;
        cell = _e362;
        kind_1 = 2u;
    }
    let _e364 = (*pos_21)[1u];
    let _e366 = tuning.gridHeight;
    if (_e364 >= (bitcast<i32>(_e366) - 2i)) {
        let _e370 = kind_1;
        if (_e370 != 2u) {
            let _e372 = cell;
            param_898 = _e372;
            let _e373 = getCloudMoved_u0028_u1_u003b((&param_898));
            if _e373 {
                let _e374 = idx_4;
                let _e377 = cell;
                let _e378 = kind_1;
                param_899 = _e378;
                param_900 = false;
                param_901 = 0u;
                param_902 = 0u;
                let _e379 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_899), (&param_900), (&param_901), (&param_902));
                let _e380 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e374]), _e377, _e379);
            }
            return;
        }
        let _e382 = cell;
        param_903 = _e382;
        let _e383 = getCloudTarget_u0028_u1_u003b((&param_903));
        target_4 = _e383;
        let _e384 = target_4;
        if (_e384 == 0u) {
            let _e387 = tuning.rainWaitMinTicks;
            let _e389 = tuning.rainWaitMaxTicks;
            lo = min(_e387, _e389);
            let _e392 = tuning.rainWaitMinTicks;
            let _e394 = tuning.rainWaitMaxTicks;
            hi = max(_e392, _e394);
            let _e396 = (*pos_21);
            let _e399 = pc.time;
            param_904 = (vec3<f32>(_e396) + vec3<f32>(_e399, 17f, 3f));
            let _e402 = hash_u0028_vf3_u003b((&param_904));
            r_6 = _e402;
            let _e403 = lo;
            let _e404 = r_6;
            let _e405 = hi;
            let _e406 = lo;
            target_4 = (_e403 + u32((_e404 * f32(((_e405 - _e406) + 1u)))));
            let _e413 = idx_4;
            let _e416 = cell;
            param_905 = 2u;
            param_906 = false;
            param_907 = 0u;
            let _e417 = target_4;
            param_908 = _e417;
            let _e418 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_905), (&param_906), (&param_907), (&param_908));
            let _e419 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e413]), _e416, _e418);
            return;
        }
        let _e421 = cell;
        param_909 = _e421;
        let _e422 = getCloudCounter_u0028_u1_u003b((&param_909));
        counter_1 = _e422;
        let _e423 = counter_1;
        let _e424 = target_4;
        if (_e423 < _e424) {
            let _e426 = idx_4;
            let _e429 = cell;
            let _e430 = counter_1;
            param_910 = 2u;
            param_911 = false;
            param_912 = (_e430 + 1u);
            let _e432 = target_4;
            param_913 = _e432;
            let _e433 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_910), (&param_911), (&param_912), (&param_913));
            let _e434 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e426]), _e429, _e433);
            return;
        }
        let _e436 = (*pos_21);
        param_914 = _e436;
        let _e437 = cloudCellInBounds_u0028_vi3_u003b((&param_914));
        if !(_e437) {
            return;
        }
        let _e439 = idx_4;
        param_915 = _e439;
        let _e440 = readCell_u0028_u1_u003b((&param_915));
        g = _e440;
        let _e441 = g;
        param_916 = _e441;
        let _e442 = getType_u0028_u1_u003b((&param_916));
        if (_e442 != 0u) {
            return;
        }
        let _e444 = idx_4;
        let _e447 = g;
        param_917 = 2u;
        param_918 = 0u;
        param_919 = 0u;
        param_920 = 0u;
        let _e448 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_917), (&param_918), (&param_919), (&param_920));
        let _e449 = atomicCompareExchangeWeak((&unnamed.grid[_e444]), _e447, _e448);
        let _e451 = g;
        if (_e449.old_value != _e451) {
            return;
        }
        let _e453 = idx_4;
        let _e456 = atomicExchange((&unnamed_1.cloudCells[_e453]), 0u);
        incWater_u0028_();
        let _e458 = (*pos_21)[1u];
        let _e461 = atomicLoad((&unnamed_2.maxOccupiedY));
        if (bitcast<u32>(_e458) > _e461) {
            let _e465 = (*pos_21)[1u];
            let _e467 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e465));
        }
        return;
    }
    let _e468 = (*pos_21);
    let _e471 = pc.time;
    param_921 = (vec3<f32>(_e468) + vec3<f32>((_e471 * 2.3f), 7f, 13f));
    let _e475 = hash_u0028_vf3_u003b((&param_921));
    randVal_14 = _e475;
    let _e476 = cell;
    param_922 = _e476;
    let _e477 = getCloudCounter_u0028_u1_u003b((&param_922));
    counter_2 = _e477;
    let _e478 = cell;
    param_923 = _e478;
    let _e479 = getCloudTarget_u0028_u1_u003b((&param_923));
    target_5 = _e479;
    let _e480 = (*pos_21);
    upPos_2 = (_e480 + vec3<i32>(0i, 1i, 0i));
    let _e482 = upPos_2;
    param_924 = _e482;
    let _e483 = cloudCellInBounds_u0028_vi3_u003b((&param_924));
    phi_9073_ = _e483;
    if _e483 {
        let _e484 = upPos_2;
        param_925 = _e484;
        let _e485 = getIndex_u0028_vi3_u003b((&param_925));
        let _e488 = atomicLoad((&unnamed_1.cloudCells[_e485]));
        param_926 = _e488;
        let _e489 = getCloudKind_u0028_u1_u003b((&param_926));
        phi_9073_ = (_e489 == 0u);
    }
    let _e492 = phi_9073_;
    if _e492 {
        let _e493 = kind_1;
        param_927 = _e493;
        param_928 = true;
        let _e494 = counter_2;
        param_929 = _e494;
        let _e495 = target_5;
        param_930 = _e495;
        let _e496 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_927), (&param_928), (&param_929), (&param_930));
        let _e497 = upPos_2;
        param_931 = _e497;
        let _e498 = getIndex_u0028_vi3_u003b((&param_931));
        let _e499 = idx_4;
        param_932 = _e499;
        param_933 = _e496;
        param_934 = _e498;
        let _e500 = cell;
        param_935 = _e500;
        let _e501 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_932), (&param_933), (&param_934), (&param_935));
        if _e501 {
            let _e503 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
            return;
        }
    }
    let _e504 = randVal_14;
    dir_7 = select(-1i, 1i, (fract((_e504 * 10f)) > 0.5f));
    let _e509 = randVal_14;
    if (fract((_e509 * 100f)) > 0.5f) {
        let _e513 = (*pos_21);
        let _e514 = dir_7;
        slide1_ = (_e513 + vec3<i32>(_e514, 1i, 0i));
        let _e517 = (*pos_21);
        let _e518 = dir_7;
        slide2_ = (_e517 + vec3<i32>(0i, 1i, _e518));
    } else {
        let _e521 = (*pos_21);
        let _e522 = dir_7;
        slide1_ = (_e521 + vec3<i32>(0i, 1i, _e522));
        let _e525 = (*pos_21);
        let _e526 = dir_7;
        slide2_ = (_e525 + vec3<i32>(_e526, 1i, 0i));
    }
    i_28 = 0i;
    loop {
        let _e529 = i_28;
        if (_e529 < 2i) {
            let _e531 = i_28;
            let _e533 = slide1_;
            let _e534 = slide2_;
            t_4 = select(_e534, _e533, vec3((_e531 == 0i)));
            let _e537 = t_4;
            param_936 = _e537;
            let _e538 = cloudCellInBounds_u0028_vi3_u003b((&param_936));
            if !(_e538) {
                continue;
            }
            let _e540 = t_4;
            param_937 = _e540;
            let _e541 = getIndex_u0028_vi3_u003b((&param_937));
            tIndex = _e541;
            let _e542 = tIndex;
            let _e545 = atomicLoad((&unnamed_1.cloudCells[_e542]));
            param_938 = _e545;
            let _e546 = getCloudKind_u0028_u1_u003b((&param_938));
            if (_e546 != 0u) {
                continue;
            }
            let _e548 = kind_1;
            param_939 = _e548;
            param_940 = true;
            let _e549 = counter_2;
            param_941 = _e549;
            let _e550 = target_5;
            param_942 = _e550;
            let _e551 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_939), (&param_940), (&param_941), (&param_942));
            let _e552 = idx_4;
            param_943 = _e552;
            param_944 = _e551;
            let _e553 = tIndex;
            param_945 = _e553;
            let _e554 = cell;
            param_946 = _e554;
            let _e555 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_943), (&param_944), (&param_945), (&param_946));
            if _e555 {
                let _e557 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e558 = i_28;
            i_28 = (_e558 + 1i);
        }
    }
    let _e560 = cell;
    param_947 = _e560;
    let _e561 = getCloudMoved_u0028_u1_u003b((&param_947));
    if _e561 {
        let _e562 = idx_4;
        let _e565 = cell;
        let _e566 = kind_1;
        param_948 = _e566;
        param_949 = false;
        let _e567 = counter_2;
        param_950 = _e567;
        let _e568 = target_5;
        param_951 = _e568;
        let _e569 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_948), (&param_949), (&param_950), (&param_951));
        let _e570 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e562]), _e565, _e569);
    }
    return;
}

fn updateSimState_u0028_() {
    var live: u32;
    var i_29: i32;
    var code_6: u32;
    var voxel: u32;
    var param_952: u32;
    var param_953: u32;
    var starve: u32;
    var purge_2: bool;
    var param_954: u32;
    var grace: u32;
    var local_30: u32;
    var decay: u32;
    var local_31: u32;
    var mass_2: u32;
    var param_955: u32;
    var param_956: u32;
    var movedLastTick: u32;
    var liveClouds: u32;
    var chargeTarget: f32;
    var charge: f32;
    var interval: u32;
    var phi_8110_: bool;
    var phi_8117_: bool;

    let _e218 = gl_GlobalInvocationID_1[0u];
    let _e219 = (_e218 != 0u);
    phi_8110_ = _e219;
    if !(_e219) {
        let _e222 = gl_GlobalInvocationID_1[1u];
        phi_8110_ = (_e222 != 0u);
    }
    let _e225 = phi_8110_;
    phi_8117_ = _e225;
    if !(_e225) {
        let _e228 = gl_GlobalInvocationID_1[2u];
        phi_8117_ = (_e228 != 0u);
    }
    let _e231 = phi_8117_;
    if _e231 {
        return;
    }
    live = 0u;
    i_29 = 0i;
    loop {
        let _e232 = i_29;
        if (_e232 < 8i) {
            let _e234 = i_29;
            let _e237 = atomicLoad((&unnamed_2.blackHoles[_e234]));
            code_6 = _e237;
            let _e238 = code_6;
            if (_e238 == 0u) {
                continue;
            }
            let _e240 = code_6;
            voxel = (_e240 & 1073741823u);
            let _e242 = voxel;
            param_952 = _e242;
            let _e243 = readCell_u0028_u1_u003b((&param_952));
            param_953 = _e243;
            let _e244 = getType_u0028_u1_u003b((&param_953));
            if (_e244 != 7u) {
                let _e246 = i_29;
                atomicStore((&unnamed_2.blackHoles[_e246]), 0u);
                continue;
            }
            let _e249 = i_29;
            let _e252 = unnamed_2.blackHoleStarve[_e249];
            starve = (_e252 + 1u);
            let _e254 = i_29;
            let _e255 = starve;
            unnamed_2.blackHoleStarve[_e254] = _e255;
            let _e258 = code_6;
            param_954 = _e258;
            let _e259 = bhIsPurge_u0028_u1_u003b((&param_954));
            purge_2 = _e259;
            let _e260 = purge_2;
            if _e260 {
                let _e262 = tuning.purgeStarveGrace;
                local_30 = _e262;
            } else {
                let _e264 = tuning.blackHoleStarveGrace;
                local_30 = _e264;
            }
            let _e265 = local_30;
            grace = _e265;
            let _e266 = purge_2;
            if _e266 {
                let _e268 = tuning.purgeDecayRate;
                local_31 = _e268;
            } else {
                let _e270 = tuning.blackHoleDecayRate;
                local_31 = _e270;
            }
            let _e271 = local_31;
            decay = _e271;
            let _e272 = starve;
            let _e273 = grace;
            if (_e272 > _e273) {
                let _e275 = i_29;
                let _e278 = atomicLoad((&unnamed_2.blackHoleMass[_e275]));
                mass_2 = _e278;
                let _e279 = mass_2;
                if (_e279 == 0u) {
                    let _e281 = voxel;
                    param_955 = _e281;
                    param_956 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_955), (&param_956));
                    let _e282 = i_29;
                    atomicStore((&unnamed_2.blackHoles[_e282]), 0u);
                    continue;
                }
                let _e285 = i_29;
                let _e286 = mass_2;
                let _e287 = mass_2;
                let _e288 = decay;
                atomicStore((&unnamed_2.blackHoleMass[_e285]), (_e286 - min(_e287, _e288)));
            }
            let _e293 = live;
            live = (_e293 + bitcast<u32>(1i));
            continue;
        } else {
            break;
        }
        continuing {
            let _e296 = i_29;
            i_29 = (_e296 + 1i);
        }
    }
    let _e298 = live;
    unnamed_2.blackHoleCount = _e298;
    let _e301 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (_e301 > 0u) {
        let _e304 = atomicAdd((&unnamed_2.maxOccupiedY), 4294967295u);
    }
    let _e306 = atomicLoad((&unnamed_2.rainCandidateCount));
    unnamed_2.rainCandidateEstimate = _e306;
    atomicStore((&unnamed_2.rainCandidateCount), 0u);
    let _e310 = unnamed_2.simTick;
    unnamed_2.simTick = (_e310 + 1u);
    let _e314 = atomicLoad((&unnamed_2.cloudMovedCount));
    movedLastTick = _e314;
    let _e316 = atomicLoad((&unnamed_2.cloudBlockCount));
    liveClouds = _e316;
    atomicStore((&unnamed_2.cloudBlockCount), 0u);
    atomicStore((&unnamed_2.cloudMovedCount), 0u);
    let _e320 = unnamed_2.rainPhase;
    chargeTarget = select(1f, 0f, (_e320 == 0u));
    let _e324 = unnamed_2.cloudChargeBits;
    charge = bitcast<f32>(_e324);
    let _e326 = chargeTarget;
    let _e327 = charge;
    let _e330 = tuning.cloudChargeEaseRate;
    let _e333 = charge;
    charge = (_e333 + ((_e326 - _e327) * clamp(_e330, 0f, 1f)));
    let _e335 = charge;
    unnamed_2.cloudChargeBits = bitcast<u32>(clamp(_e335, 0f, 1f));
    let _e340 = unnamed_2.rainPhase;
    if (_e340 == 0u) {
        let _e343 = tuning.cloudCheckIntervalTicks;
        interval = max(_e343, 1u);
        let _e346 = unnamed_2.simTick;
        let _e347 = interval;
        let _e350 = liveClouds;
        let _e353 = movedLastTick;
        if ((((_e346 % _e347) == 0u) && (_e350 > 0u)) && (_e353 == 0u)) {
            unnamed_2.rainPhase = 2u;
            let _e358 = pc.time;
            unnamed_2.rainPhaseTimeBits = bitcast<u32>(_e358);
            let _e362 = unnamed_2.simTick;
            unnamed_2.lastRainTick = _e362;
        }
    } else {
        let _e364 = liveClouds;
        if (_e364 == 0u) {
            unnamed_2.rainPhase = 0u;
            unnamed_2.rainPhaseTimeBits = 0u;
        }
    }
    return;
}

fn main_1() {
    var pos_22: vec3<i32>;
    var param_957: vec3<i32>;
    var param_958: vec3<i32>;
    var spawnIndex: u32;
    var param_959: vec3<i32>;
    var oldType: u32;
    var param_960: u32;
    var param_961: u32;
    var newType_3: u32;
    var param_962: vec3<i32>;
    var seedAge: u32;
    var param_963: u32;
    var local_32: u32;
    var param_964: u32;
    var param_965: u32;
    var param_966: u32;
    var param_967: u32;
    var param_968: u32;
    var param_969: u32;
    var param_970: u32;
    var param_971: u32;
    var param_972: vec3<i32>;
    var param_973: u32;
    var param_974: u32;
    var currentIndex_15: u32;
    var param_975: vec3<i32>;
    var rawValue_13: u32;
    var param_976: u32;
    var currentType_1: u32;
    var param_977: u32;
    var param_978: i32;
    var param_979: i32;
    var randVal_15: f32;
    var param_980: vec3<f32>;
    var param_981: vec3<i32>;
    var param_982: u32;
    var param_983: u32;
    var param_984: f32;
    var currentDir_6: u32;
    var param_985: u32;
    var currentSleep_7: u32;
    var param_986: u32;
    var currentAge_10: u32;
    var param_987: u32;
    var param_988: vec3<i32>;
    var param_989: u32;
    var param_990: u32;
    var param_991: u32;
    var param_992: u32;
    var param_993: f32;
    var param_994: vec3<i32>;
    var param_995: u32;
    var param_996: u32;
    var param_997: u32;
    var param_998: u32;
    var param_999: u32;
    var param_1000: f32;
    var param_1001: vec3<i32>;
    var param_1002: u32;
    var param_1003: u32;
    var param_1004: u32;
    var param_1005: u32;
    var param_1006: u32;
    var param_1007: f32;
    var param_1008: vec3<i32>;
    var param_1009: u32;
    var param_1010: u32;
    var param_1011: u32;
    var param_1012: u32;
    var param_1013: u32;
    var param_1014: f32;
    var param_1015: vec3<i32>;
    var param_1016: u32;
    var param_1017: u32;
    var param_1018: u32;
    var param_1019: u32;
    var param_1020: f32;
    var param_1021: vec3<i32>;
    var param_1022: u32;
    var param_1023: u32;
    var param_1024: u32;
    var param_1025: u32;
    var param_1026: u32;
    var param_1027: f32;
    var param_1028: vec3<i32>;
    var param_1029: u32;
    var param_1030: u32;
    var param_1031: u32;
    var param_1032: f32;
    var param_1033: vec3<i32>;
    var param_1034: u32;
    var param_1035: u32;
    var param_1036: u32;
    var param_1037: u32;
    var param_1038: u32;
    var param_1039: f32;
    var param_1040: vec3<i32>;
    var param_1041: u32;
    var param_1042: u32;
    var param_1043: u32;
    var param_1044: u32;
    var param_1045: f32;
    var param_1046: vec3<i32>;
    var param_1047: u32;
    var param_1048: u32;
    var param_1049: u32;
    var param_1050: f32;
    var phi_9223_: bool;
    var phi_9233_: bool;
    var phi_9249_: bool;
    var phi_9348_: bool;
    var phi_9355_: bool;
    var phi_9366_: bool;
    var phi_9373_: bool;
    var phi_9384_: bool;
    var phi_9407_: bool;
    var phi_9417_: bool;
    var phi_9475_: bool;

    let _e303 = gl_GlobalInvocationID_1;
    pos_22 = bitcast<vec3<i32>>(_e303);
    let _e306 = pos_22[0u];
    let _e308 = tuning.gridWidth;
    let _e310 = (_e306 >= bitcast<i32>(_e308));
    phi_9223_ = _e310;
    if !(_e310) {
        let _e313 = pos_22[1u];
        let _e315 = tuning.gridHeight;
        phi_9223_ = (_e313 >= bitcast<i32>(_e315));
    }
    let _e319 = phi_9223_;
    phi_9233_ = _e319;
    if !(_e319) {
        let _e322 = pos_22[2u];
        let _e324 = tuning.gridDepth;
        phi_9233_ = (_e322 >= bitcast<i32>(_e324));
    }
    let _e328 = phi_9233_;
    if _e328 {
        return;
    }
    updateSimState_u0028_();
    let _e329 = pos_22;
    param_957 = _e329;
    updateCloudBlock_u0028_vi3_u003b((&param_957));
    let _e331 = pc.spawnActive;
    let _e332 = (_e331 == 1i);
    phi_9249_ = _e332;
    if _e332 {
        let _e333 = pos_22;
        param_958 = _e333;
        let _e334 = inBrush_u0028_vi3_u003b((&param_958));
        phi_9249_ = _e334;
    }
    let _e336 = phi_9249_;
    if _e336 {
        let _e337 = pos_22;
        param_959 = _e337;
        let _e338 = getIndex_u0028_vi3_u003b((&param_959));
        spawnIndex = _e338;
        let _e339 = spawnIndex;
        param_960 = _e339;
        let _e340 = readCell_u0028_u1_u003b((&param_960));
        param_961 = _e340;
        let _e341 = getType_u0028_u1_u003b((&param_961));
        oldType = _e341;
        let _e343 = pc.spawnType;
        newType_3 = bitcast<u32>(_e343);
        let _e345 = newType_3;
        let _e347 = oldType;
        if ((_e345 != 7u) || (_e347 != 7u)) {
            let _e350 = oldType;
            let _e351 = newType_3;
            if (_e350 != _e351) {
                let _e353 = oldType;
                if (_e353 == 2u) {
                    decWater_u0028_();
                }
                let _e355 = oldType;
                if (_e355 == 7u) {
                    let _e357 = pos_22;
                    param_962 = _e357;
                    bhRelease_u0028_vi3_u003b((&param_962));
                }
                let _e358 = newType_3;
                if (_e358 == 2u) {
                    incWater_u0028_();
                }
            }
            let _e360 = newType_3;
            param_963 = _e360;
            let _e361 = isLocust_u0028_u1_u003b((&param_963));
            if _e361 {
                let _e362 = newType_3;
                param_964 = _e362;
                let _e363 = locustSpawnCount_u0028_u1_u003b((&param_964));
                local_32 = _e363;
            } else {
                let _e364 = newType_3;
                param_965 = _e364;
                let _e365 = lavaSpawnCoolness_u0028_u1_u003b((&param_965));
                local_32 = _e365;
            }
            let _e366 = local_32;
            seedAge = _e366;
            let _e367 = newType_3;
            param_966 = _e367;
            param_967 = 0u;
            param_968 = 0u;
            let _e368 = seedAge;
            param_969 = _e368;
            let _e369 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_966), (&param_967), (&param_968), (&param_969));
            let _e370 = spawnIndex;
            param_970 = _e370;
            param_971 = _e369;
            writeCell_u0028_u1_u003b_u1_u003b((&param_970), (&param_971));
            let _e371 = newType_3;
            if (_e371 == 7u) {
                let _e373 = pos_22;
                param_972 = _e373;
                let _e374 = bhRegister_u0028_vi3_u003b((&param_972));
                if !(_e374) {
                    let _e376 = spawnIndex;
                    param_973 = _e376;
                    param_974 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_973), (&param_974));
                }
            }
        }
    }
    let _e378 = pos_22[0u];
    let _e379 = (_e378 < 1i);
    phi_9348_ = _e379;
    if !(_e379) {
        let _e382 = pos_22[0u];
        let _e384 = tuning.gridWidth;
        phi_9348_ = (_e382 >= (bitcast<i32>(_e384) - 1i));
    }
    let _e389 = phi_9348_;
    phi_9355_ = _e389;
    if !(_e389) {
        let _e392 = pos_22[1u];
        phi_9355_ = (_e392 < 1i);
    }
    let _e395 = phi_9355_;
    phi_9366_ = _e395;
    if !(_e395) {
        let _e398 = pos_22[1u];
        let _e400 = tuning.gridHeight;
        phi_9366_ = (_e398 >= (bitcast<i32>(_e400) - 1i));
    }
    let _e405 = phi_9366_;
    phi_9373_ = _e405;
    if !(_e405) {
        let _e408 = pos_22[2u];
        phi_9373_ = (_e408 < 1i);
    }
    let _e411 = phi_9373_;
    phi_9384_ = _e411;
    if !(_e411) {
        let _e414 = pos_22[2u];
        let _e416 = tuning.gridDepth;
        phi_9384_ = (_e414 >= (bitcast<i32>(_e416) - 1i));
    }
    let _e421 = phi_9384_;
    if _e421 {
        return;
    }
    let _e422 = pos_22;
    param_975 = _e422;
    let _e423 = getIndex_u0028_vi3_u003b((&param_975));
    currentIndex_15 = _e423;
    let _e424 = currentIndex_15;
    param_976 = _e424;
    let _e425 = readCell_u0028_u1_u003b((&param_976));
    rawValue_13 = _e425;
    let _e426 = rawValue_13;
    param_977 = _e426;
    let _e427 = getType_u0028_u1_u003b((&param_977));
    currentType_1 = _e427;
    let _e428 = currentType_1;
    let _e429 = (_e428 == 0u);
    phi_9407_ = _e429;
    if _e429 {
        let _e431 = unnamed_2.rainPhase;
        phi_9407_ = (_e431 >= 1u);
    }
    let _e434 = phi_9407_;
    phi_9417_ = _e434;
    if _e434 {
        let _e436 = pos_22[1u];
        let _e438 = tuning.gridHeight;
        phi_9417_ = (_e436 == (bitcast<i32>(_e438) - 2i));
    }
    let _e443 = phi_9417_;
    if _e443 {
        let _e445 = pos_22[0u];
        param_978 = _e445;
        let _e447 = pos_22[2u];
        param_979 = _e447;
        let _e448 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_978), (&param_979));
        let _e452 = atomicLoad((&unnamed_2.cloudColumn[(_e448 + 2u)]));
        if (_e452 != 0u) {
            let _e455 = atomicAdd((&unnamed_2.rainCandidateCount), 1u);
        }
    }
    let _e456 = currentType_1;
    if (_e456 == 0u) {
        return;
    }
    let _e459 = pos_22[1u];
    let _e462 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (bitcast<u32>(_e459) > _e462) {
        let _e466 = pos_22[1u];
        let _e468 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e466));
    }
    let _e469 = pos_22;
    let _e472 = pc.time;
    param_980 = (vec3<f32>(_e469) + vec3(_e472));
    let _e475 = hash_u0028_vf3_u003b((&param_980));
    randVal_15 = _e475;
    let _e476 = currentType_1;
    let _e477 = (_e476 != 7u);
    phi_9475_ = _e477;
    if _e477 {
        let _e478 = pos_22;
        param_981 = _e478;
        let _e479 = currentIndex_15;
        param_982 = _e479;
        let _e480 = rawValue_13;
        param_983 = _e480;
        let _e481 = randVal_15;
        param_984 = _e481;
        let _e482 = captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b((&param_981), (&param_982), (&param_983), (&param_984));
        phi_9475_ = _e482;
    }
    let _e484 = phi_9475_;
    if _e484 {
        return;
    }
    let _e485 = currentType_1;
    let _e487 = currentType_1;
    if ((_e485 == 3u) || (_e487 == 7u)) {
        return;
    }
    let _e490 = rawValue_13;
    param_985 = _e490;
    let _e491 = getDir_u0028_u1_u003b((&param_985));
    currentDir_6 = _e491;
    let _e492 = rawValue_13;
    param_986 = _e492;
    let _e493 = getSleep_u0028_u1_u003b((&param_986));
    currentSleep_7 = _e493;
    let _e494 = rawValue_13;
    param_987 = _e494;
    let _e495 = getAge_u0028_u1_u003b((&param_987));
    currentAge_10 = _e495;
    let _e496 = currentType_1;
    switch bitcast<i32>(_e496) {
        case 1: {
            let _e498 = pos_22;
            param_988 = _e498;
            let _e499 = currentIndex_15;
            param_989 = _e499;
            let _e500 = rawValue_13;
            param_990 = _e500;
            let _e501 = currentSleep_7;
            param_991 = _e501;
            let _e502 = currentAge_10;
            param_992 = _e502;
            let _e503 = randVal_15;
            param_993 = _e503;
            updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_988), (&param_989), (&param_990), (&param_991), (&param_992), (&param_993));
            break;
        }
        case 2: {
            let _e504 = pos_22;
            param_994 = _e504;
            let _e505 = currentIndex_15;
            param_995 = _e505;
            let _e506 = rawValue_13;
            param_996 = _e506;
            let _e507 = currentDir_6;
            param_997 = _e507;
            let _e508 = currentSleep_7;
            param_998 = _e508;
            let _e509 = currentAge_10;
            param_999 = _e509;
            let _e510 = randVal_15;
            param_1000 = _e510;
            updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_994), (&param_995), (&param_996), (&param_997), (&param_998), (&param_999), (&param_1000));
            break;
        }
        case 4: {
            let _e511 = pos_22;
            param_1001 = _e511;
            let _e512 = currentIndex_15;
            param_1002 = _e512;
            let _e513 = rawValue_13;
            param_1003 = _e513;
            let _e514 = currentDir_6;
            param_1004 = _e514;
            let _e515 = currentSleep_7;
            param_1005 = _e515;
            let _e516 = currentAge_10;
            param_1006 = _e516;
            let _e517 = randVal_15;
            param_1007 = _e517;
            updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1001), (&param_1002), (&param_1003), (&param_1004), (&param_1005), (&param_1006), (&param_1007));
            break;
        }
        case 5: {
            let _e518 = pos_22;
            param_1008 = _e518;
            let _e519 = currentIndex_15;
            param_1009 = _e519;
            let _e520 = rawValue_13;
            param_1010 = _e520;
            let _e521 = currentDir_6;
            param_1011 = _e521;
            let _e522 = currentSleep_7;
            param_1012 = _e522;
            let _e523 = currentAge_10;
            param_1013 = _e523;
            let _e524 = randVal_15;
            param_1014 = _e524;
            updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1008), (&param_1009), (&param_1010), (&param_1011), (&param_1012), (&param_1013), (&param_1014));
            break;
        }
        case 6: {
            let _e525 = pos_22;
            param_1015 = _e525;
            let _e526 = currentIndex_15;
            param_1016 = _e526;
            let _e527 = rawValue_13;
            param_1017 = _e527;
            let _e528 = currentSleep_7;
            param_1018 = _e528;
            let _e529 = currentAge_10;
            param_1019 = _e529;
            let _e530 = randVal_15;
            param_1020 = _e530;
            updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1015), (&param_1016), (&param_1017), (&param_1018), (&param_1019), (&param_1020));
            break;
        }
        case 9, 10, 11, 8: {
            let _e531 = pos_22;
            param_1021 = _e531;
            let _e532 = currentIndex_15;
            param_1022 = _e532;
            let _e533 = rawValue_13;
            param_1023 = _e533;
            let _e534 = currentDir_6;
            param_1024 = _e534;
            let _e535 = currentSleep_7;
            param_1025 = _e535;
            let _e536 = currentAge_10;
            param_1026 = _e536;
            let _e537 = randVal_15;
            param_1027 = _e537;
            updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1021), (&param_1022), (&param_1023), (&param_1024), (&param_1025), (&param_1026), (&param_1027));
            break;
        }
        case 12: {
            let _e538 = pos_22;
            param_1028 = _e538;
            let _e539 = currentIndex_15;
            param_1029 = _e539;
            let _e540 = rawValue_13;
            param_1030 = _e540;
            let _e541 = currentAge_10;
            param_1031 = _e541;
            let _e542 = randVal_15;
            param_1032 = _e542;
            updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1028), (&param_1029), (&param_1030), (&param_1031), (&param_1032));
            break;
        }
        case 14, 15, 16, 17, 13: {
            let _e543 = pos_22;
            param_1033 = _e543;
            let _e544 = currentIndex_15;
            param_1034 = _e544;
            let _e545 = rawValue_13;
            param_1035 = _e545;
            let _e546 = currentDir_6;
            param_1036 = _e546;
            let _e547 = currentSleep_7;
            param_1037 = _e547;
            let _e548 = currentAge_10;
            param_1038 = _e548;
            let _e549 = randVal_15;
            param_1039 = _e549;
            updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1033), (&param_1034), (&param_1035), (&param_1036), (&param_1037), (&param_1038), (&param_1039));
            break;
        }
        case 18: {
            let _e550 = pos_22;
            param_1040 = _e550;
            let _e551 = currentIndex_15;
            param_1041 = _e551;
            let _e552 = rawValue_13;
            param_1042 = _e552;
            let _e553 = currentDir_6;
            param_1043 = _e553;
            let _e554 = currentAge_10;
            param_1044 = _e554;
            let _e555 = randVal_15;
            param_1045 = _e555;
            updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1040), (&param_1041), (&param_1042), (&param_1043), (&param_1044), (&param_1045));
            break;
        }
        case 19: {
            let _e556 = pos_22;
            param_1046 = _e556;
            let _e557 = currentIndex_15;
            param_1047 = _e557;
            let _e558 = rawValue_13;
            param_1048 = _e558;
            let _e559 = currentAge_10;
            param_1049 = _e559;
            let _e560 = randVal_15;
            param_1050 = _e560;
            updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1046), (&param_1047), (&param_1048), (&param_1049), (&param_1050));
            break;
        }
        default: {
            break;
        }
    }
    return;
}

@compute @workgroup_size(8, 8, 4) 
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID: vec3<u32>) {
    gl_GlobalInvocationID_1 = gl_GlobalInvocationID;
    main_1();
}
