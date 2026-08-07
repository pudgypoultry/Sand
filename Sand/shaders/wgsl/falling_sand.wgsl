// GENERATED FILE -- DO NOT EDIT.
//
// Translated from falling_sand.comp by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit falling_sand.comp and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: dd1e62a3a97223a2bc05e81c2f5abaf9dba8b5e939556ff57d13f830639690f0

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
    steamCondenseTicks: u32,
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
    let _e198 = (*val);
    return ((_e198 >> bitcast<u32>(24i)) & 255u);
}

fn getDir_u0028_u1_u003b(val_1: ptr<function, u32>) -> u32 {
    let _e198 = (*val_1);
    return ((_e198 >> bitcast<u32>(8i)) & 255u);
}

fn getType_u0028_u1_u003b(val_2: ptr<function, u32>) -> u32 {
    let _e198 = (*val_2);
    return (_e198 & 255u);
}

fn tree26_u0028_i1_u003b(i: ptr<function, i32>) -> vec3<i32> {
    var j: i32;
    var local: i32;

    let _e200 = (*i);
    if (_e200 >= 13i) {
        let _e202 = (*i);
        local = (_e202 + 1i);
    } else {
        let _e204 = (*i);
        local = _e204;
    }
    let _e205 = local;
    j = _e205;
    let _e206 = j;
    let _e214 = j;
    let _e215 = (_e214 / 3i);
    let _e223 = j;
    return (vec3<i32>((_e206 - (i32(floor((f32(_e206) / f32(3i)))) * 3i)), (_e215 - (i32(floor((f32(_e215) / f32(3i)))) * 3i)), (_e223 / 9i)) - vec3<i32>(1i, 1i, 1i));
}

fn readCell_u0028_u1_u003b(index: ptr<function, u32>) -> u32 {
    let _e198 = (*index);
    let _e201 = atomicLoad((&unnamed.grid[_e198]));
    return _e201;
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

    let _e208 = (*targetIndex);
    param = _e208;
    let _e209 = readCell_u0028_u1_u003b((&param));
    targetValue = _e209;
    let _e210 = targetValue;
    param_1 = _e210;
    let _e211 = getType_u0028_u1_u003b((&param_1));
    targetType = _e211;
    let _e212 = (*currentValue);
    param_2 = _e212;
    let _e213 = getType_u0028_u1_u003b((&param_2));
    currentType = _e213;
    let _e214 = targetType;
    let _e215 = (_e214 == 0u);
    phi_1637_ = _e215;
    if !(_e215) {
        let _e217 = currentType;
        let _e219 = currentType;
        let _e222 = targetType;
        phi_1637_ = (((_e217 == 1u) || (_e219 == 4u)) && (_e222 == 2u));
    }
    let _e226 = phi_1637_;
    phi_1646_ = _e226;
    if !(_e226) {
        let _e228 = currentType;
        let _e230 = targetType;
        phi_1646_ = ((_e228 == 6u) && (_e230 == 5u));
    }
    let _e234 = phi_1646_;
    if _e234 {
        let _e235 = (*currentIndex);
        let _e238 = (*currentValue);
        let _e239 = atomicCompareExchangeWeak((&unnamed.grid[_e235]), _e238, 0u);
        let _e241 = (*currentValue);
        if (_e239.old_value == _e241) {
            let _e243 = (*targetIndex);
            let _e246 = targetValue;
            let _e247 = (*newValue);
            let _e248 = atomicCompareExchangeWeak((&unnamed.grid[_e243]), _e246, _e247);
            actual = _e248.old_value;
            let _e250 = actual;
            let _e251 = targetValue;
            if (_e250 == _e251) {
                let _e253 = targetType;
                if (_e253 != 0u) {
                    let _e255 = (*currentIndex);
                    let _e258 = targetValue;
                    let _e259 = atomicExchange((&unnamed.grid[_e255]), _e258);
                }
                return true;
            } else {
                let _e260 = (*currentIndex);
                let _e263 = (*currentValue);
                let _e264 = atomicCompareExchangeWeak((&unnamed.grid[_e260]), 0u, _e263);
            }
        }
    }
    return false;
}

fn pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(type_33: ptr<function, u32>, dir: ptr<function, u32>, sleep: ptr<function, u32>, age: ptr<function, u32>) -> u32 {
    let _e201 = (*type_33);
    let _e203 = (*dir);
    let _e208 = (*sleep);
    let _e213 = (*age);
    return ((((_e201 & 255u) | ((_e203 & 255u) << bitcast<u32>(8i))) | ((_e208 & 255u) << bitcast<u32>(16i))) | ((_e213 & 255u) << bitcast<u32>(24i)));
}

fn getIndex_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    let _e199 = (*pos)[0u];
    let _e201 = (*pos)[1u];
    let _e203 = tuning.gridWidth;
    let _e208 = (*pos)[2u];
    let _e210 = tuning.gridWidth;
    let _e214 = tuning.gridHeight;
    return bitcast<u32>(((_e199 + (_e201 * bitcast<i32>(_e203))) + ((_e208 * bitcast<i32>(_e210)) * bitcast<i32>(_e214))));
}

fn treeInBounds_u0028_vi3_u003b(p: ptr<function, vec3<i32>>) -> bool {
    var phi_1128_: bool;
    var phi_1134_: bool;
    var phi_1144_: bool;
    var phi_1150_: bool;
    var phi_1160_: bool;

    let _e199 = (*p)[0u];
    let _e200 = (_e199 > 0i);
    phi_1128_ = _e200;
    if _e200 {
        let _e202 = (*p)[0u];
        let _e204 = tuning.gridWidth;
        phi_1128_ = (_e202 < (bitcast<i32>(_e204) - 1i));
    }
    let _e209 = phi_1128_;
    phi_1134_ = _e209;
    if _e209 {
        let _e211 = (*p)[1u];
        phi_1134_ = (_e211 > 0i);
    }
    let _e214 = phi_1134_;
    phi_1144_ = _e214;
    if _e214 {
        let _e216 = (*p)[1u];
        let _e218 = tuning.gridHeight;
        phi_1144_ = (_e216 < (bitcast<i32>(_e218) - 1i));
    }
    let _e223 = phi_1144_;
    phi_1150_ = _e223;
    if _e223 {
        let _e225 = (*p)[2u];
        phi_1150_ = (_e225 > 0i);
    }
    let _e228 = phi_1150_;
    phi_1160_ = _e228;
    if _e228 {
        let _e230 = (*p)[2u];
        let _e232 = tuning.gridDepth;
        phi_1160_ = (_e230 < (bitcast<i32>(_e232) - 1i));
    }
    let _e237 = phi_1160_;
    return _e237;
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

    let _e248 = (*randVal);
    let _e252 = tuning.treeLeafTickChance;
    if (fract((_e248 * 7f)) >= _e252) {
        return;
    }
    let _e254 = (*currentAge);
    if (_e254 == 255u) {
        let _e256 = (*pos_1);
        belowPos = (_e256 + vec3<i32>(0i, -1i, 0i));
        let _e258 = belowPos;
        param_3 = _e258;
        let _e259 = treeInBounds_u0028_vi3_u003b((&param_3));
        phi_6746_ = _e259;
        if _e259 {
            let _e260 = belowPos;
            param_4 = _e260;
            let _e261 = getIndex_u0028_vi3_u003b((&param_4));
            param_5 = _e261;
            let _e262 = readCell_u0028_u1_u003b((&param_5));
            phi_6746_ = (_e262 == 0u);
        }
        let _e265 = phi_6746_;
        if _e265 {
            let _e266 = belowPos;
            param_6 = _e266;
            let _e267 = getIndex_u0028_vi3_u003b((&param_6));
            param_7 = 19u;
            param_8 = 0u;
            param_9 = 0u;
            param_10 = 255u;
            let _e268 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_7), (&param_8), (&param_9), (&param_10));
            let _e269 = (*currentIndex_1);
            param_11 = _e269;
            let _e270 = (*rawValue);
            param_12 = _e270;
            param_13 = _e267;
            param_14 = _e268;
            let _e271 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_11), (&param_12), (&param_13), (&param_14));
            if _e271 {
                return;
            }
        }
        let _e272 = (*currentIndex_1);
        let _e275 = (*rawValue);
        let _e276 = atomicCompareExchangeWeak((&unnamed.grid[_e272]), _e275, 0u);
        return;
    }
    let _e278 = (*currentAge);
    dist = _e278;
    nearest = 255u;
    touchesTrunk = false;
    let _e279 = (*randVal);
    start = i32((fract((_e279 * 71f)) * 26f));
    haveSpot = false;
    let _e284 = (*pos_1);
    spot = _e284;
    i_1 = 0i;
    loop {
        let _e285 = i_1;
        if (_e285 < 26i) {
            let _e287 = (*pos_1);
            let _e288 = start;
            let _e289 = i_1;
            let _e290 = (_e288 + _e289);
            param_15 = (_e290 - (i32(floor((f32(_e290) / f32(26i)))) * 26i));
            let _e298 = tree26_u0028_i1_u003b((&param_15));
            c = (_e287 + _e298);
            let _e300 = c;
            param_16 = _e300;
            let _e301 = treeInBounds_u0028_vi3_u003b((&param_16));
            if !(_e301) {
                continue;
            }
            let _e303 = c;
            param_17 = _e303;
            let _e304 = getIndex_u0028_vi3_u003b((&param_17));
            param_18 = _e304;
            let _e305 = readCell_u0028_u1_u003b((&param_18));
            v = _e305;
            let _e306 = v;
            param_19 = _e306;
            let _e307 = getType_u0028_u1_u003b((&param_19));
            t = _e307;
            let _e308 = t;
            let _e309 = (_e308 == 18u);
            phi_6830_ = _e309;
            if _e309 {
                let _e310 = v;
                param_20 = _e310;
                let _e311 = getDir_u0028_u1_u003b((&param_20));
                let _e314 = tuning.treeMaxHeight;
                phi_6830_ = ((_e311 + 1u) >= _e314);
            }
            let _e317 = phi_6830_;
            if _e317 {
                touchesTrunk = true;
            } else {
                let _e318 = t;
                if (_e318 == 19u) {
                    let _e320 = nearest;
                    let _e321 = v;
                    param_21 = _e321;
                    let _e322 = getAge_u0028_u1_u003b((&param_21));
                    nearest = min(_e320, _e322);
                } else {
                    let _e324 = v;
                    let _e326 = haveSpot;
                    if ((_e324 == 0u) && !(_e326)) {
                        haveSpot = true;
                        let _e329 = c;
                        spot = _e329;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e330 = i_1;
            i_1 = (_e330 + 1i);
        }
    }
    let _e332 = touchesTrunk;
    if _e332 {
        local_1 = 1u;
    } else {
        let _e333 = nearest;
        if (_e333 >= 255u) {
            local_2 = 255u;
        } else {
            let _e335 = nearest;
            local_2 = (_e335 + 1u);
        }
        let _e337 = local_2;
        local_1 = _e337;
    }
    let _e338 = local_1;
    supported = _e338;
    let _e339 = supported;
    let _e341 = tuning.treeLeafReach;
    if (_e339 > _e341) {
        let _e343 = (*randVal);
        let _e347 = tuning.treeLeafFallChance;
        if (fract((_e343 * 83f)) < _e347) {
            let _e349 = (*currentIndex_1);
            let _e352 = (*rawValue);
            param_22 = 19u;
            param_23 = 0u;
            param_24 = 0u;
            param_25 = 255u;
            let _e353 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_22), (&param_23), (&param_24), (&param_25));
            let _e354 = atomicCompareExchangeWeak((&unnamed.grid[_e349]), _e352, _e353);
        }
        return;
    }
    let _e356 = supported;
    let _e358 = tuning.treeLeafReach;
    let _e360 = haveSpot;
    let _e361 = ((_e356 < _e358) && _e360);
    phi_6912_ = _e361;
    if _e361 {
        let _e362 = (*randVal);
        let _e366 = tuning.treeLeafSpreadChance;
        phi_6912_ = (fract((_e362 * 89f)) < _e366);
    }
    let _e369 = phi_6912_;
    if _e369 {
        let _e370 = spot;
        param_26 = _e370;
        let _e371 = getIndex_u0028_vi3_u003b((&param_26));
        let _e374 = supported;
        param_27 = 19u;
        param_28 = 0u;
        param_29 = 0u;
        param_30 = (_e374 + 1u);
        let _e376 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_27), (&param_28), (&param_29), (&param_30));
        let _e377 = atomicCompareExchangeWeak((&unnamed.grid[_e371]), 0u, _e376);
    }
    let _e379 = supported;
    let _e380 = dist;
    if (_e379 != _e380) {
        let _e382 = (*currentIndex_1);
        let _e385 = (*rawValue);
        param_31 = 19u;
        param_32 = 0u;
        param_33 = 0u;
        let _e386 = supported;
        param_34 = _e386;
        let _e387 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_31), (&param_32), (&param_33), (&param_34));
        let _e388 = atomicCompareExchangeWeak((&unnamed.grid[_e382]), _e385, _e387);
    }
    return;
}

fn isGrassBlock_u0028_u1_u003b(value: ptr<function, u32>) -> bool {
    var flora: u32;
    var param_35: u32;

    let _e200 = (*value);
    flora = ((_e200 >> bitcast<u32>(8i)) & 255u);
    let _e204 = (*value);
    param_35 = _e204;
    let _e205 = getType_u0028_u1_u003b((&param_35));
    let _e207 = flora;
    let _e210 = flora;
    return (((_e205 == 4u) && (_e207 > 10u)) && (_e210 <= 100u));
}

fn getSleep_u0028_u1_u003b(val_3: ptr<function, u32>) -> u32 {
    let _e198 = (*val_3);
    return ((_e198 >> bitcast<u32>(16i)) & 255u);
}

fn getHDir_u0028_i1_u003b(d: ptr<function, i32>) -> vec3<i32> {
    let _e198 = (*d);
    if (_e198 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e200 = (*d);
    if (_e200 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e202 = (*d);
    if (_e202 == 2i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    let _e204 = (*d);
    if (_e204 == 3i) {
        return vec3<i32>(0i, 0i, -1i);
    }
    let _e206 = (*d);
    if (_e206 == 4i) {
        return vec3<i32>(1i, 0i, 1i);
    }
    let _e208 = (*d);
    if (_e208 == 5i) {
        return vec3<i32>(1i, 0i, -1i);
    }
    let _e210 = (*d);
    if (_e210 == 6i) {
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

    let _e283 = (*currentDir);
    height = _e283;
    let _e284 = (*currentAge_1);
    water = _e284;
    changed = false;
    let _e285 = water;
    let _e287 = tuning.treeWaterMax;
    let _e288 = (_e285 < _e287);
    phi_6301_ = _e288;
    if _e288 {
        let _e289 = (*randVal_1);
        let _e293 = tuning.treeDrinkChance;
        phi_6301_ = (fract((_e289 * 13f)) < _e293);
    }
    let _e296 = phi_6301_;
    if _e296 {
        let _e297 = (*randVal_1);
        start_1 = i32((fract((_e297 * 101f)) * 17f));
        k = 0i;
        loop {
            let _e302 = k;
            if (_e302 < 17i) {
                let _e304 = start_1;
                let _e305 = k;
                let _e306 = (_e304 + _e305);
                i_2 = (_e306 - (i32(floor((f32(_e306) / f32(17i)))) * 17i));
                let _e314 = i_2;
                if (_e314 == 0i) {
                    let _e316 = (*pos_2);
                    local_3 = (_e316 + vec3<i32>(0i, -1i, 0i));
                } else {
                    let _e318 = i_2;
                    if (_e318 < 9i) {
                        let _e320 = (*pos_2);
                        let _e321 = i_2;
                        param_36 = (_e321 - 1i);
                        let _e323 = getHDir_u0028_i1_u003b((&param_36));
                        local_4 = ((_e320 + _e323) + vec3<i32>(0i, -1i, 0i));
                    } else {
                        let _e326 = (*pos_2);
                        let _e327 = i_2;
                        param_37 = (_e327 - 9i);
                        let _e329 = getHDir_u0028_i1_u003b((&param_37));
                        local_4 = (_e326 + _e329);
                    }
                    let _e331 = local_4;
                    local_3 = _e331;
                }
                let _e332 = local_3;
                c_1 = _e332;
                let _e333 = c_1;
                param_38 = _e333;
                let _e334 = treeInBounds_u0028_vi3_u003b((&param_38));
                if !(_e334) {
                    continue;
                }
                let _e336 = c_1;
                param_39 = _e336;
                let _e337 = getIndex_u0028_vi3_u003b((&param_39));
                idx = _e337;
                let _e338 = idx;
                param_40 = _e338;
                let _e339 = readCell_u0028_u1_u003b((&param_40));
                v_1 = _e339;
                let _e340 = v_1;
                param_41 = _e340;
                let _e341 = getType_u0028_u1_u003b((&param_41));
                if (_e341 != 4u) {
                    continue;
                }
                let _e343 = v_1;
                param_42 = _e343;
                let _e344 = getAge_u0028_u1_u003b((&param_42));
                moisture = _e344;
                let _e345 = moisture;
                let _e347 = tuning.treeSoilReserve;
                if (_e345 <= _e347) {
                    continue;
                }
                let _e349 = idx;
                let _e352 = v_1;
                let _e353 = v_1;
                param_43 = _e353;
                let _e354 = getDir_u0028_u1_u003b((&param_43));
                let _e355 = v_1;
                param_44 = _e355;
                let _e356 = getSleep_u0028_u1_u003b((&param_44));
                let _e357 = moisture;
                param_45 = 4u;
                param_46 = _e354;
                param_47 = _e356;
                param_48 = (_e357 - 1u);
                let _e359 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_45), (&param_46), (&param_47), (&param_48));
                let _e360 = atomicCompareExchangeWeak((&unnamed.grid[_e349]), _e352, _e359);
                let _e362 = v_1;
                if (_e360.old_value == _e362) {
                    let _e364 = water;
                    water = (_e364 + 1u);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e366 = k;
                k = (_e366 + 1i);
            }
        }
    }
    let _e368 = (*pos_2);
    upPos = (_e368 + vec3<i32>(0i, 1i, 0i));
    upIsTrunk = false;
    upValue = 0u;
    upIndex = 0u;
    let _e370 = upPos;
    param_49 = _e370;
    let _e371 = treeInBounds_u0028_vi3_u003b((&param_49));
    if _e371 {
        let _e372 = upPos;
        param_50 = _e372;
        let _e373 = getIndex_u0028_vi3_u003b((&param_50));
        upIndex = _e373;
        let _e374 = upIndex;
        param_51 = _e374;
        let _e375 = readCell_u0028_u1_u003b((&param_51));
        upValue = _e375;
        let _e376 = upValue;
        param_52 = _e376;
        let _e377 = getType_u0028_u1_u003b((&param_52));
        upIsTrunk = (_e377 == 18u);
    }
    let _e379 = upIsTrunk;
    let _e380 = water;
    let _e382 = (_e379 && (_e380 > 0u));
    phi_6444_ = _e382;
    if _e382 {
        let _e383 = upValue;
        param_53 = _e383;
        let _e384 = getAge_u0028_u1_u003b((&param_53));
        phi_6444_ = (_e384 < 255u);
    }
    let _e387 = phi_6444_;
    phi_6454_ = _e387;
    if _e387 {
        let _e388 = (*randVal_1);
        let _e392 = tuning.treeFlowChance;
        phi_6454_ = (fract((_e388 * 29f)) < _e392);
    }
    let _e395 = phi_6454_;
    if _e395 {
        let _e396 = upValue;
        param_54 = _e396;
        let _e397 = getDir_u0028_u1_u003b((&param_54));
        let _e398 = upValue;
        param_55 = _e398;
        let _e399 = getAge_u0028_u1_u003b((&param_55));
        param_56 = 18u;
        param_57 = _e397;
        param_58 = 0u;
        param_59 = (_e399 + 1u);
        let _e401 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_56), (&param_57), (&param_58), (&param_59));
        lifted = _e401;
        let _e402 = upIndex;
        let _e405 = upValue;
        let _e406 = lifted;
        let _e407 = atomicCompareExchangeWeak((&unnamed.grid[_e402]), _e405, _e406);
        let _e409 = upValue;
        if (_e407.old_value == _e409) {
            let _e411 = water;
            water = (_e411 - 1u);
            changed = true;
        }
    }
    let _e413 = height;
    let _e416 = tuning.treeMaxHeight;
    if ((_e413 + 1u) < _e416) {
        let _e418 = water;
        let _e420 = tuning.treeGrowCost;
        let _e421 = (_e418 >= _e420);
        phi_6499_ = _e421;
        if _e421 {
            let _e422 = upPos;
            param_60 = _e422;
            let _e423 = treeInBounds_u0028_vi3_u003b((&param_60));
            phi_6499_ = _e423;
        }
        let _e425 = phi_6499_;
        if _e425 {
            let _e426 = upValue;
            param_61 = _e426;
            let _e427 = getType_u0028_u1_u003b((&param_61));
            upType = _e427;
            let _e428 = upType;
            let _e430 = upType;
            if ((_e428 == 0u) || (_e430 == 19u)) {
                let _e433 = height;
                param_62 = 18u;
                param_63 = (_e433 + 1u);
                param_64 = 0u;
                param_65 = 0u;
                let _e435 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_62), (&param_63), (&param_64), (&param_65));
                sapling = _e435;
                let _e436 = upIndex;
                let _e439 = upValue;
                let _e440 = sapling;
                let _e441 = atomicCompareExchangeWeak((&unnamed.grid[_e436]), _e439, _e440);
                let _e443 = upValue;
                if (_e441.old_value == _e443) {
                    let _e446 = tuning.treeGrowCost;
                    let _e447 = water;
                    water = (_e447 - _e446);
                    changed = true;
                }
            }
        }
    } else {
        let _e449 = water;
        let _e451 = tuning.treeLeafCost;
        let _e452 = (_e449 >= _e451);
        phi_6550_ = _e452;
        if _e452 {
            let _e453 = (*randVal_1);
            let _e457 = tuning.treeLeafChance;
            phi_6550_ = (fract((_e453 * 37f)) < _e457);
        }
        let _e460 = phi_6550_;
        if _e460 {
            let _e461 = (*randVal_1);
            start_2 = i32((fract((_e461 * 43f)) * 26f));
            i_3 = 0i;
            loop {
                let _e466 = i_3;
                if (_e466 < 26i) {
                    let _e468 = (*pos_2);
                    let _e469 = start_2;
                    let _e470 = i_3;
                    let _e471 = (_e469 + _e470);
                    param_66 = (_e471 - (i32(floor((f32(_e471) / f32(26i)))) * 26i));
                    let _e479 = tree26_u0028_i1_u003b((&param_66));
                    c_2 = (_e468 + _e479);
                    let _e481 = c_2;
                    param_67 = _e481;
                    let _e482 = treeInBounds_u0028_vi3_u003b((&param_67));
                    if !(_e482) {
                        continue;
                    }
                    let _e484 = c_2;
                    param_68 = _e484;
                    let _e485 = getIndex_u0028_vi3_u003b((&param_68));
                    idx_1 = _e485;
                    let _e486 = idx_1;
                    param_69 = _e486;
                    let _e487 = readCell_u0028_u1_u003b((&param_69));
                    if (_e487 != 0u) {
                        continue;
                    }
                    let _e489 = idx_1;
                    param_70 = 19u;
                    param_71 = 0u;
                    param_72 = 0u;
                    param_73 = 1u;
                    let _e492 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_70), (&param_71), (&param_72), (&param_73));
                    let _e493 = atomicCompareExchangeWeak((&unnamed.grid[_e489]), 0u, _e492);
                    if (_e493.old_value == 0u) {
                        let _e497 = tuning.treeLeafCost;
                        let _e498 = water;
                        water = (_e498 - _e497);
                        changed = true;
                        break;
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e500 = i_3;
                    i_3 = (_e500 + 1i);
                }
            }
        }
    }
    let _e502 = water;
    let _e504 = tuning.treeSpreadCost;
    let _e505 = (_e502 >= _e504);
    phi_6629_ = _e505;
    if _e505 {
        let _e506 = (*randVal_1);
        let _e510 = tuning.treeSpreadChance;
        phi_6629_ = (fract((_e506 * 59f)) < _e510);
    }
    let _e513 = phi_6629_;
    if _e513 {
        let _e514 = (*randVal_1);
        start_3 = i32((fract((_e514 * 61f)) * 8f));
        i_4 = 0i;
        loop {
            let _e519 = i_4;
            if (_e519 < 8i) {
                let _e521 = (*pos_2);
                let _e522 = start_3;
                let _e523 = i_4;
                let _e524 = (_e522 + _e523);
                param_74 = (_e524 - (i32(floor((f32(_e524) / f32(8i)))) * 8i));
                let _e532 = getHDir_u0028_i1_u003b((&param_74));
                c_3 = (_e521 + _e532);
                let _e534 = c_3;
                param_75 = _e534;
                let _e535 = treeInBounds_u0028_vi3_u003b((&param_75));
                if !(_e535) {
                    continue;
                }
                let _e537 = c_3;
                param_76 = _e537;
                let _e538 = getIndex_u0028_vi3_u003b((&param_76));
                idx_2 = _e538;
                let _e539 = idx_2;
                param_77 = _e539;
                let _e540 = readCell_u0028_u1_u003b((&param_77));
                if (_e540 != 0u) {
                    continue;
                }
                let _e542 = c_3;
                param_78 = (_e542 + vec3<i32>(0i, -1i, 0i));
                let _e544 = getIndex_u0028_vi3_u003b((&param_78));
                param_79 = _e544;
                let _e545 = readCell_u0028_u1_u003b((&param_79));
                param_80 = _e545;
                let _e546 = isGrassBlock_u0028_u1_u003b((&param_80));
                if !(_e546) {
                    continue;
                }
                let _e548 = idx_2;
                param_81 = 18u;
                param_82 = 0u;
                param_83 = 0u;
                param_84 = 0u;
                let _e551 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_81), (&param_82), (&param_83), (&param_84));
                let _e552 = atomicCompareExchangeWeak((&unnamed.grid[_e548]), 0u, _e551);
                if (_e552.old_value == 0u) {
                    let _e556 = tuning.treeSpreadCost;
                    let _e557 = water;
                    water = (_e557 - _e556);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e559 = i_4;
                i_4 = (_e559 + 1i);
            }
        }
    }
    let _e561 = changed;
    if _e561 {
        let _e562 = (*currentIndex_2);
        let _e565 = (*rawValue_1);
        param_85 = 18u;
        let _e566 = height;
        param_86 = _e566;
        param_87 = 0u;
        let _e567 = water;
        param_88 = _e567;
        let _e568 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_85), (&param_86), (&param_87), (&param_88));
        let _e569 = atomicCompareExchangeWeak((&unnamed.grid[_e562]), _e565, _e568);
    }
    return;
}

fn locustPackNav_u0028_u1_u003b_u1_u003b(heading: ptr<function, u32>, steps: ptr<function, u32>) -> u32 {
    let _e199 = (*heading);
    let _e201 = (*steps);
    return ((_e199 & 7u) | (min(_e201, 7u) << bitcast<u32>(3i)));
}

fn locustReverse_u0028_u1_u003b(d_1: ptr<function, u32>) -> u32 {
    let _e198 = (*d_1);
    if (_e198 == 0u) {
        return 1u;
    }
    let _e200 = (*d_1);
    if (_e200 == 1u) {
        return 0u;
    }
    let _e202 = (*d_1);
    if (_e202 == 2u) {
        return 3u;
    }
    let _e204 = (*d_1);
    if (_e204 == 3u) {
        return 2u;
    }
    let _e206 = (*d_1);
    if (_e206 == 4u) {
        return 7u;
    }
    let _e208 = (*d_1);
    if (_e208 == 5u) {
        return 6u;
    }
    let _e210 = (*d_1);
    if (_e210 == 6u) {
        return 5u;
    }
    return 4u;
}

fn locustRunSteps_u0028_() -> u32 {
    let _e198 = tuning.locustRunLength;
    return clamp(_e198, 1u, 7u);
}

fn isLocustFood_u0028_u1_u003b(value_1: ptr<function, u32>) -> bool {
    var param_89: u32;
    var param_90: u32;
    var phi_921_: bool;

    let _e200 = (*value_1);
    param_89 = _e200;
    let _e201 = isGrassBlock_u0028_u1_u003b((&param_89));
    phi_921_ = _e201;
    if !(_e201) {
        let _e203 = (*value_1);
        param_90 = _e203;
        let _e204 = getType_u0028_u1_u003b((&param_90));
        phi_921_ = (_e204 == 19u);
    }
    let _e207 = phi_921_;
    return _e207;
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

    let _e202 = (*p_1)[0u];
    let _e203 = (_e202 < 0i);
    phi_936_ = _e203;
    if !(_e203) {
        let _e206 = (*p_1)[0u];
        let _e208 = tuning.gridWidth;
        phi_936_ = (_e206 >= bitcast<i32>(_e208));
    }
    let _e212 = phi_936_;
    phi_943_ = _e212;
    if !(_e212) {
        let _e215 = (*p_1)[1u];
        phi_943_ = (_e215 < 0i);
    }
    let _e218 = phi_943_;
    phi_953_ = _e218;
    if !(_e218) {
        let _e221 = (*p_1)[1u];
        let _e223 = tuning.gridHeight;
        phi_953_ = (_e221 >= bitcast<i32>(_e223));
    }
    let _e227 = phi_953_;
    phi_960_ = _e227;
    if !(_e227) {
        let _e230 = (*p_1)[2u];
        phi_960_ = (_e230 < 0i);
    }
    let _e233 = phi_960_;
    phi_970_ = _e233;
    if !(_e233) {
        let _e236 = (*p_1)[2u];
        let _e238 = tuning.gridDepth;
        phi_970_ = (_e236 >= bitcast<i32>(_e238));
    }
    let _e242 = phi_970_;
    if _e242 {
        return false;
    }
    let _e243 = (*p_1);
    param_91 = _e243;
    let _e244 = getIndex_u0028_vi3_u003b((&param_91));
    param_92 = _e244;
    let _e245 = readCell_u0028_u1_u003b((&param_92));
    param_93 = _e245;
    let _e246 = isLocustFood_u0028_u1_u003b((&param_93));
    return _e246;
}

fn locustSteps_u0028_u1_u003b(dirByte: ptr<function, u32>) -> u32 {
    let _e198 = (*dirByte);
    return ((_e198 >> bitcast<u32>(3i)) & 7u);
}

fn locustHeading_u0028_u1_u003b(dirByte_1: ptr<function, u32>) -> u32 {
    let _e198 = (*dirByte_1);
    return (_e198 & 7u);
}

fn locustArriveDir_u0028_vi3_u003b_u1_u003b(dest: ptr<function, vec3<i32>>, nav: ptr<function, u32>) -> u32 {
    var param_94: vec3<i32>;

    let _e200 = (*dest);
    param_94 = (_e200 + vec3<i32>(0i, -1i, 0i));
    let _e202 = locustFoodAt_u0028_vi3_u003b((&param_94));
    let _e203 = (*nav);
    return select(_e203, 0u, _e202);
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
        let _e203 = d_2;
        if (_e203 < 8i) {
            let _e205 = (*pos_3);
            let _e206 = d_2;
            param_95 = _e206;
            let _e207 = getHDir_u0028_i1_u003b((&param_95));
            n = (_e205 + _e207);
            let _e210 = n[0u];
            let _e211 = (_e210 <= 0i);
            phi_1073_ = _e211;
            if !(_e211) {
                let _e214 = n[0u];
                let _e216 = tuning.gridWidth;
                phi_1073_ = (_e214 >= (bitcast<i32>(_e216) - 1i));
            }
            let _e221 = phi_1073_;
            phi_1080_ = _e221;
            if !(_e221) {
                let _e224 = n[2u];
                phi_1080_ = (_e224 <= 0i);
            }
            let _e227 = phi_1080_;
            phi_1091_ = _e227;
            if !(_e227) {
                let _e230 = n[2u];
                let _e232 = tuning.gridDepth;
                phi_1091_ = (_e230 >= (bitcast<i32>(_e232) - 1i));
            }
            let _e237 = phi_1091_;
            if _e237 {
                continue;
            }
            let _e238 = n;
            param_96 = _e238;
            let _e239 = getIndex_u0028_vi3_u003b((&param_96));
            param_97 = _e239;
            let _e240 = readCell_u0028_u1_u003b((&param_97));
            if (_e240 != 0u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e242 = d_2;
            d_2 = (_e242 + 1i);
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

    let _e199 = (*p_2)[0u];
    let _e200 = (_e199 > 0i);
    phi_857_ = _e200;
    if _e200 {
        let _e202 = (*p_2)[0u];
        let _e204 = tuning.gridWidth;
        phi_857_ = (_e202 < (bitcast<i32>(_e204) - 1i));
    }
    let _e209 = phi_857_;
    phi_863_ = _e209;
    if _e209 {
        let _e211 = (*p_2)[1u];
        phi_863_ = (_e211 > 0i);
    }
    let _e214 = phi_863_;
    phi_873_ = _e214;
    if _e214 {
        let _e216 = (*p_2)[1u];
        let _e218 = tuning.gridHeight;
        phi_873_ = (_e216 < (bitcast<i32>(_e218) - 1i));
    }
    let _e223 = phi_873_;
    phi_879_ = _e223;
    if _e223 {
        let _e225 = (*p_2)[2u];
        phi_879_ = (_e225 > 0i);
    }
    let _e228 = phi_879_;
    phi_889_ = _e228;
    if _e228 {
        let _e230 = (*p_2)[2u];
        let _e232 = tuning.gridDepth;
        phi_889_ = (_e230 < (bitcast<i32>(_e232) - 1i));
    }
    let _e237 = phi_889_;
    return _e237;
}

fn locustStage_u0028_() -> u32 {
    let _e198 = tuning.locustStageSize;
    return max(_e198, 1u);
}

fn locustTypeFor_u0028_u1_u003b(count: ptr<function, u32>) -> u32 {
    var stage: u32;
    var local_5: u32;

    let _e200 = (*count);
    if (_e200 == 0u) {
        local_5 = 0u;
    } else {
        let _e202 = (*count);
        let _e204 = locustStage_u0028_();
        local_5 = ((_e202 - 1u) / _e204);
    }
    let _e206 = local_5;
    stage = _e206;
    let _e207 = stage;
    return (13u + min(_e207, 4u));
}

fn locustMaxCount_u0028_() -> u32 {
    let _e198 = tuning.locustMaxSize;
    return max(_e198, 1u);
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

    let _e215 = tuning.locustBudSize;
    let _e216 = locustMaxCount_u0028_();
    bud = clamp(_e215, 1u, _e216);
    let _e218 = (*randVal_2);
    start_4 = i32((fract((_e218 * 31f)) * 8f));
    i_5 = 0i;
    loop {
        let _e223 = i_5;
        if (_e223 < 8i) {
            let _e225 = start_4;
            let _e226 = i_5;
            let _e227 = (_e225 + _e226);
            d_3 = (_e227 - (i32(floor((f32(_e227) / f32(8i)))) * 8i));
            let _e235 = (*pos_4);
            let _e236 = d_3;
            param_98 = _e236;
            let _e237 = getHDir_u0028_i1_u003b((&param_98));
            c_4 = (_e235 + _e237);
            let _e239 = c_4;
            param_99 = _e239;
            let _e240 = locustInBounds_u0028_vi3_u003b((&param_99));
            if !(_e240) {
                continue;
            }
            let _e242 = c_4;
            param_100 = _e242;
            let _e243 = getIndex_u0028_vi3_u003b((&param_100));
            idx_3 = _e243;
            let _e244 = idx_3;
            param_101 = _e244;
            let _e245 = readCell_u0028_u1_u003b((&param_101));
            if (_e245 != 0u) {
                continue;
            }
            let _e247 = idx_3;
            let _e250 = bud;
            param_102 = _e250;
            let _e251 = locustTypeFor_u0028_u1_u003b((&param_102));
            param_103 = _e251;
            param_104 = 0u;
            param_105 = 0u;
            let _e252 = bud;
            param_106 = _e252;
            let _e253 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_103), (&param_104), (&param_105), (&param_106));
            let _e254 = atomicCompareExchangeWeak((&unnamed.grid[_e247]), 0u, _e253);
            if (_e254.old_value == 0u) {
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e257 = i_5;
            i_5 = (_e257 + 1i);
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

    let _e204 = tuning.locustEatTicksMin;
    fast = _e204;
    let _e206 = tuning.locustEatTicksMax;
    slow = _e206;
    let _e207 = locustMaxCount_u0028_();
    cap = _e207;
    let _e208 = locustStage_u0028_();
    let _e209 = cap;
    floorCount = min(_e208, _e209);
    let _e211 = (*count_1);
    let _e212 = cap;
    if (_e211 >= _e212) {
        let _e214 = fast;
        return _e214;
    }
    let _e215 = (*count_1);
    let _e216 = floorCount;
    let _e218 = cap;
    let _e219 = floorCount;
    if ((_e215 <= _e216) || (_e218 == _e219)) {
        let _e222 = slow;
        return _e222;
    }
    let _e223 = (*count_1);
    let _e224 = floorCount;
    let _e227 = cap;
    let _e228 = floorCount;
    t_1 = (f32((_e223 - _e224)) / f32((_e227 - _e228)));
    let _e232 = slow;
    let _e234 = fast;
    let _e236 = t_1;
    return u32(round(mix(f32(_e232), f32(_e234), _e236)));
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

    let _e381 = (*rawValue_2);
    param_107 = _e381;
    let _e382 = getType_u0028_u1_u003b((&param_107));
    type_34 = _e382;
    let _e383 = (*currentSleep);
    phase = (_e383 + 1u);
    let _e385 = phase;
    let _e387 = tuning.locustTickDispatches;
    if (_e385 < _e387) {
        let _e389 = (*currentIndex_3);
        let _e392 = (*rawValue_2);
        let _e393 = type_34;
        param_108 = _e393;
        let _e394 = (*currentDir_1);
        param_109 = _e394;
        let _e395 = phase;
        param_110 = _e395;
        let _e396 = (*currentAge_2);
        param_111 = _e396;
        let _e397 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_108), (&param_109), (&param_110), (&param_111));
        let _e398 = atomicCompareExchangeWeak((&unnamed.grid[_e389]), _e392, _e397);
        return;
    }
    let _e400 = (*currentAge_2);
    count_2 = _e400;
    let _e401 = (*pos_5);
    belowPos_1 = (_e401 + vec3<i32>(0i, -1i, 0i));
    let _e403 = belowPos_1;
    param_112 = _e403;
    let _e404 = getIndex_u0028_vi3_u003b((&param_112));
    belowIndex = _e404;
    let _e405 = belowIndex;
    param_113 = _e405;
    let _e406 = readCell_u0028_u1_u003b((&param_113));
    belowValue = _e406;
    let _e407 = belowValue;
    param_114 = _e407;
    let _e408 = isLocustFood_u0028_u1_u003b((&param_114));
    if _e408 {
        let _e409 = belowValue;
        param_115 = _e409;
        let _e410 = getType_u0028_u1_u003b((&param_115));
        onLeaf = (_e410 == 19u);
        let _e412 = count_2;
        param_116 = _e412;
        let _e413 = locustEatTicks_u0028_u1_u003b((&param_116));
        need = _e413;
        let _e414 = (*currentDir_1);
        progress = (_e414 + 1u);
        let _e416 = progress;
        let _e417 = need;
        if (_e416 < _e417) {
            let _e419 = onLeaf;
            if !(_e419) {
                let _e421 = belowValue;
                flora_1 = ((_e421 >> bitcast<u32>(8i)) & 255u);
                let _e425 = need;
                bite = max((90u / max(_e425, 1u)), 1u);
                let _e429 = flora_1;
                let _e430 = bite;
                if (_e429 > (11u + _e430)) {
                    let _e433 = flora_1;
                    let _e434 = bite;
                    local_6 = (_e433 - _e434);
                } else {
                    local_6 = 11u;
                }
                let _e436 = local_6;
                thinned = _e436;
                let _e437 = belowIndex;
                let _e440 = belowValue;
                let _e441 = belowValue;
                param_117 = _e441;
                let _e442 = getSleep_u0028_u1_u003b((&param_117));
                let _e443 = belowValue;
                param_118 = _e443;
                let _e444 = getAge_u0028_u1_u003b((&param_118));
                param_119 = 4u;
                let _e445 = thinned;
                param_120 = _e445;
                param_121 = _e442;
                param_122 = _e444;
                let _e446 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_119), (&param_120), (&param_121), (&param_122));
                let _e447 = atomicCompareExchangeWeak((&unnamed.grid[_e437]), _e440, _e446);
            }
            let _e449 = (*currentIndex_3);
            let _e452 = (*rawValue_2);
            let _e453 = type_34;
            param_123 = _e453;
            let _e454 = progress;
            param_124 = _e454;
            param_125 = 0u;
            let _e455 = count_2;
            param_126 = _e455;
            let _e456 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_123), (&param_124), (&param_125), (&param_126));
            let _e457 = atomicCompareExchangeWeak((&unnamed.grid[_e449]), _e452, _e456);
            return;
        }
        let _e459 = onLeaf;
        if _e459 {
            local_7 = 0u;
        } else {
            let _e460 = belowValue;
            param_127 = _e460;
            let _e461 = getSleep_u0028_u1_u003b((&param_127));
            let _e462 = belowValue;
            param_128 = _e462;
            let _e463 = getAge_u0028_u1_u003b((&param_128));
            param_129 = 4u;
            param_130 = 0u;
            param_131 = _e461;
            param_132 = _e463;
            let _e464 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_129), (&param_130), (&param_131), (&param_132));
            local_7 = _e464;
        }
        let _e465 = local_7;
        stripped = _e465;
        let _e466 = belowIndex;
        let _e469 = belowValue;
        let _e470 = stripped;
        let _e471 = atomicCompareExchangeWeak((&unnamed.grid[_e466]), _e469, _e470);
        let _e473 = belowValue;
        if (_e471.old_value != _e473) {
            return;
        }
        let _e475 = count_2;
        let _e477 = tuning.locustEatGain;
        grown = (_e475 + _e477);
        let _e479 = grown;
        let _e480 = locustMaxCount_u0028_();
        if (_e479 > _e480) {
            let _e482 = (*pos_5);
            param_133 = _e482;
            let _e483 = (*randVal_3);
            param_134 = _e483;
            locustBud_u0028_vi3_u003b_f1_u003b((&param_133), (&param_134));
            let _e484 = locustMaxCount_u0028_();
            grown = _e484;
        }
        let _e485 = (*currentIndex_3);
        let _e488 = (*rawValue_2);
        let _e489 = grown;
        param_135 = _e489;
        let _e490 = locustTypeFor_u0028_u1_u003b((&param_135));
        param_136 = _e490;
        param_137 = 0u;
        param_138 = 0u;
        let _e491 = grown;
        param_139 = _e491;
        let _e492 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_136), (&param_137), (&param_138), (&param_139));
        let _e493 = atomicCompareExchangeWeak((&unnamed.grid[_e485]), _e488, _e492);
        return;
    }
    let _e495 = count_2;
    if (_e495 <= 1u) {
        let _e497 = (*currentIndex_3);
        let _e500 = (*rawValue_2);
        let _e501 = atomicCompareExchangeWeak((&unnamed.grid[_e497]), _e500, 0u);
        return;
    }
    let _e503 = count_2;
    count_2 = (_e503 - 1u);
    let _e505 = count_2;
    param_140 = _e505;
    let _e506 = locustTypeFor_u0028_u1_u003b((&param_140));
    newType = _e506;
    let _e507 = belowValue;
    param_141 = _e507;
    let _e508 = getType_u0028_u1_u003b((&param_141));
    let _e509 = (_e508 == 0u);
    phi_7211_ = _e509;
    if _e509 {
        let _e510 = belowPos_1;
        param_142 = _e510;
        let _e511 = locustInBounds_u0028_vi3_u003b((&param_142));
        phi_7211_ = _e511;
    }
    let _e513 = phi_7211_;
    phi_7218_ = _e513;
    if _e513 {
        let _e514 = (*pos_5);
        param_143 = _e514;
        let _e515 = locustHasGrip_u0028_vi3_u003b((&param_143));
        phi_7218_ = !(_e515);
    }
    let _e518 = phi_7218_;
    if _e518 {
        let _e519 = belowPos_1;
        param_144 = _e519;
        let _e520 = (*currentDir_1);
        param_145 = _e520;
        let _e521 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_144), (&param_145));
        let _e522 = newType;
        param_146 = _e522;
        param_147 = _e521;
        param_148 = 0u;
        let _e523 = count_2;
        param_149 = _e523;
        let _e524 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_146), (&param_147), (&param_148), (&param_149));
        let _e525 = (*currentIndex_3);
        param_150 = _e525;
        let _e526 = (*rawValue_2);
        param_151 = _e526;
        let _e527 = belowIndex;
        param_152 = _e527;
        param_153 = _e524;
        let _e528 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_150), (&param_151), (&param_152), (&param_153));
        if _e528 {
            return;
        }
    }
    let _e529 = (*currentDir_1);
    param_154 = _e529;
    let _e530 = locustHeading_u0028_u1_u003b((&param_154));
    heading_1 = _e530;
    let _e531 = (*currentDir_1);
    param_155 = _e531;
    let _e532 = locustSteps_u0028_u1_u003b((&param_155));
    steps_1 = _e532;
    let _e533 = steps_1;
    if (_e533 == 0u) {
        let _e535 = (*randVal_3);
        start_5 = i32((fract((_e535 * 17f)) * 8f));
        i_6 = 0i;
        loop {
            let _e540 = i_6;
            if (_e540 < 8i) {
                let _e542 = start_5;
                let _e543 = i_6;
                let _e544 = (_e542 + _e543);
                d_4 = (_e544 - (i32(floor((f32(_e544) / f32(8i)))) * 8i));
                let _e552 = (*pos_5);
                let _e553 = d_4;
                param_156 = _e553;
                let _e554 = getHDir_u0028_i1_u003b((&param_156));
                c_5 = (_e552 + _e554);
                rise = 0i;
                loop {
                    let _e556 = rise;
                    if (_e556 < 3i) {
                        let _e558 = c_5;
                        let _e559 = rise;
                        if (_e559 == 1i) {
                            local_8 = 1i;
                        } else {
                            let _e561 = rise;
                            local_8 = select(0i, -1i, (_e561 == 2i));
                        }
                        let _e564 = local_8;
                        t_2 = (_e558 + vec3<i32>(0i, _e564, 0i));
                        let _e567 = t_2;
                        param_157 = _e567;
                        let _e568 = locustInBounds_u0028_vi3_u003b((&param_157));
                        if !(_e568) {
                            continue;
                        }
                        let _e570 = t_2;
                        param_158 = _e570;
                        let _e571 = getIndex_u0028_vi3_u003b((&param_158));
                        param_159 = _e571;
                        let _e572 = readCell_u0028_u1_u003b((&param_159));
                        if (_e572 != 0u) {
                            continue;
                        }
                        let _e574 = t_2;
                        param_160 = (_e574 + vec3<i32>(0i, -1i, 0i));
                        let _e576 = locustFoodAt_u0028_vi3_u003b((&param_160));
                        if !(_e576) {
                            continue;
                        }
                        let _e578 = t_2;
                        param_161 = _e578;
                        let _e579 = getIndex_u0028_vi3_u003b((&param_161));
                        let _e580 = newType;
                        param_162 = _e580;
                        param_163 = 0u;
                        param_164 = 0u;
                        let _e581 = count_2;
                        param_165 = _e581;
                        let _e582 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_162), (&param_163), (&param_164), (&param_165));
                        let _e583 = (*currentIndex_3);
                        param_166 = _e583;
                        let _e584 = (*rawValue_2);
                        param_167 = _e584;
                        param_168 = _e579;
                        param_169 = _e582;
                        let _e585 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_166), (&param_167), (&param_168), (&param_169));
                        if _e585 {
                            return;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e586 = rise;
                        rise = (_e586 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e588 = i_6;
                i_6 = (_e588 + 1i);
            }
        }
        let _e590 = (*randVal_3);
        heading_1 = (u32((fract((_e590 * 23f)) * 8f)) & 7u);
        let _e596 = locustRunSteps_u0028_();
        steps_1 = _e596;
    }
    let _e597 = (*pos_5);
    let _e598 = heading_1;
    param_170 = bitcast<i32>(_e598);
    let _e600 = getHDir_u0028_i1_u003b((&param_170));
    target_ = (_e597 + _e600);
    let _e602 = target_;
    param_171 = _e602;
    let _e603 = locustInBounds_u0028_vi3_u003b((&param_171));
    let _e604 = !(_e603);
    phi_7379_ = _e604;
    if !(_e604) {
        let _e606 = target_;
        param_172 = _e606;
        let _e607 = getIndex_u0028_vi3_u003b((&param_172));
        param_173 = _e607;
        let _e608 = readCell_u0028_u1_u003b((&param_173));
        phi_7379_ = (_e608 != 0u);
    }
    let _e611 = phi_7379_;
    blocked = _e611;
    let _e612 = blocked;
    if !(_e612) {
        let _e614 = target_;
        footing = (_e614 + vec3<i32>(0i, -1i, 0i));
        let _e616 = footing;
        param_174 = _e616;
        let _e617 = locustInBounds_u0028_vi3_u003b((&param_174));
        phi_7398_ = _e617;
        if _e617 {
            let _e618 = footing;
            param_175 = _e618;
            let _e619 = getIndex_u0028_vi3_u003b((&param_175));
            param_176 = _e619;
            let _e620 = readCell_u0028_u1_u003b((&param_176));
            phi_7398_ = (_e620 == 0u);
        }
        let _e623 = phi_7398_;
        if _e623 {
            let _e624 = heading_1;
            param_177 = _e624;
            let _e625 = locustReverse_u0028_u1_u003b((&param_177));
            back = _e625;
            let _e626 = (*pos_5);
            let _e627 = back;
            param_178 = bitcast<i32>(_e627);
            let _e629 = getHDir_u0028_i1_u003b((&param_178));
            backPos = (_e626 + _e629);
            let _e631 = backPos;
            backFoot = (_e631 + vec3<i32>(0i, -1i, 0i));
            let _e633 = backPos;
            param_179 = _e633;
            let _e634 = locustInBounds_u0028_vi3_u003b((&param_179));
            phi_7427_ = _e634;
            if _e634 {
                let _e635 = backPos;
                param_180 = _e635;
                let _e636 = getIndex_u0028_vi3_u003b((&param_180));
                param_181 = _e636;
                let _e637 = readCell_u0028_u1_u003b((&param_181));
                phi_7427_ = (_e637 == 0u);
            }
            let _e640 = phi_7427_;
            phi_7443_ = _e640;
            if _e640 {
                let _e641 = backFoot;
                param_182 = _e641;
                let _e642 = locustInBounds_u0028_vi3_u003b((&param_182));
                phi_7441_ = _e642;
                if _e642 {
                    let _e643 = backFoot;
                    param_183 = _e643;
                    let _e644 = getIndex_u0028_vi3_u003b((&param_183));
                    param_184 = _e644;
                    let _e645 = readCell_u0028_u1_u003b((&param_184));
                    phi_7441_ = (_e645 == 0u);
                }
                let _e648 = phi_7441_;
                phi_7443_ = !(_e648);
            }
            let _e651 = phi_7443_;
            backOpen = _e651;
            let _e652 = backOpen;
            if _e652 {
                let _e653 = back;
                param_185 = _e653;
                let _e654 = steps_1;
                param_186 = _e654;
                let _e655 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_185), (&param_186));
                local_9 = _e655;
            } else {
                let _e656 = (*randVal_3);
                let _e662 = locustRunSteps_u0028_();
                param_187 = (u32((fract((_e656 * 71f)) * 8f)) & 7u);
                param_188 = _e662;
                let _e663 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_187), (&param_188));
                local_9 = _e663;
            }
            let _e664 = local_9;
            turnedNav = _e664;
            let _e665 = (*currentIndex_3);
            let _e668 = (*rawValue_2);
            let _e669 = newType;
            param_189 = _e669;
            let _e670 = turnedNav;
            param_190 = _e670;
            param_191 = 0u;
            let _e671 = count_2;
            param_192 = _e671;
            let _e672 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_189), (&param_190), (&param_191), (&param_192));
            let _e673 = atomicCompareExchangeWeak((&unnamed.grid[_e665]), _e668, _e672);
            return;
        }
        let _e675 = steps_1;
        let _e677 = heading_1;
        param_193 = _e677;
        param_194 = (_e675 - 1u);
        let _e678 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_193), (&param_194));
        nav_1 = _e678;
        let _e679 = target_;
        param_195 = _e679;
        let _e680 = getIndex_u0028_vi3_u003b((&param_195));
        let _e681 = target_;
        param_196 = _e681;
        let _e682 = nav_1;
        param_197 = _e682;
        let _e683 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_196), (&param_197));
        let _e684 = newType;
        param_198 = _e684;
        param_199 = _e683;
        param_200 = 0u;
        let _e685 = count_2;
        param_201 = _e685;
        let _e686 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_198), (&param_199), (&param_200), (&param_201));
        let _e687 = (*currentIndex_3);
        param_202 = _e687;
        let _e688 = (*rawValue_2);
        param_203 = _e688;
        param_204 = _e680;
        param_205 = _e686;
        let _e689 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_202), (&param_203), (&param_204), (&param_205));
        if _e689 {
            return;
        }
    } else {
        let _e690 = (*randVal_3);
        let _e694 = tuning.locustClimbChance;
        if (fract((_e690 * 41f)) < _e694) {
            let _e696 = target_;
            overTop = (_e696 + vec3<i32>(0i, 1i, 0i));
            let _e698 = overTop;
            param_206 = _e698;
            let _e699 = locustInBounds_u0028_vi3_u003b((&param_206));
            phi_7535_ = _e699;
            if _e699 {
                let _e700 = overTop;
                param_207 = _e700;
                let _e701 = getIndex_u0028_vi3_u003b((&param_207));
                param_208 = _e701;
                let _e702 = readCell_u0028_u1_u003b((&param_208));
                phi_7535_ = (_e702 == 0u);
            }
            let _e705 = phi_7535_;
            if _e705 {
                let _e706 = steps_1;
                let _e708 = heading_1;
                param_209 = _e708;
                param_210 = (_e706 - 1u);
                let _e709 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_209), (&param_210));
                nav_2 = _e709;
                let _e710 = overTop;
                param_211 = _e710;
                let _e711 = getIndex_u0028_vi3_u003b((&param_211));
                let _e712 = overTop;
                param_212 = _e712;
                let _e713 = nav_2;
                param_213 = _e713;
                let _e714 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_212), (&param_213));
                let _e715 = newType;
                param_214 = _e715;
                param_215 = _e714;
                param_216 = 0u;
                let _e716 = count_2;
                param_217 = _e716;
                let _e717 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_214), (&param_215), (&param_216), (&param_217));
                let _e718 = (*currentIndex_3);
                param_218 = _e718;
                let _e719 = (*rawValue_2);
                param_219 = _e719;
                param_220 = _e711;
                param_221 = _e717;
                let _e720 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_218), (&param_219), (&param_220), (&param_221));
                if _e720 {
                    return;
                }
            }
            let _e721 = (*pos_5);
            up = (_e721 + vec3<i32>(0i, 1i, 0i));
            let _e723 = up;
            param_222 = _e723;
            let _e724 = locustInBounds_u0028_vi3_u003b((&param_222));
            phi_7584_ = _e724;
            if _e724 {
                let _e725 = up;
                param_223 = _e725;
                let _e726 = getIndex_u0028_vi3_u003b((&param_223));
                param_224 = _e726;
                let _e727 = readCell_u0028_u1_u003b((&param_224));
                phi_7584_ = (_e727 == 0u);
            }
            let _e730 = phi_7584_;
            if _e730 {
                let _e731 = heading_1;
                param_225 = _e731;
                let _e732 = steps_1;
                param_226 = _e732;
                let _e733 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_225), (&param_226));
                nav_3 = _e733;
                let _e734 = up;
                param_227 = _e734;
                let _e735 = getIndex_u0028_vi3_u003b((&param_227));
                let _e736 = up;
                param_228 = _e736;
                let _e737 = nav_3;
                param_229 = _e737;
                let _e738 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_228), (&param_229));
                let _e739 = newType;
                param_230 = _e739;
                param_231 = _e738;
                param_232 = 0u;
                let _e740 = count_2;
                param_233 = _e740;
                let _e741 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_230), (&param_231), (&param_232), (&param_233));
                let _e742 = (*currentIndex_3);
                param_234 = _e742;
                let _e743 = (*rawValue_2);
                param_235 = _e743;
                param_236 = _e735;
                param_237 = _e741;
                let _e744 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_234), (&param_235), (&param_236), (&param_237));
                if _e744 {
                    return;
                }
            }
        }
        let _e745 = (*randVal_3);
        heading_1 = (u32((fract((_e745 * 53f)) * 8f)) & 7u);
        let _e751 = locustRunSteps_u0028_();
        steps_1 = _e751;
    }
    let _e752 = (*currentIndex_3);
    let _e755 = (*rawValue_2);
    let _e756 = heading_1;
    param_238 = _e756;
    let _e757 = steps_1;
    param_239 = _e757;
    let _e758 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_238), (&param_239));
    let _e759 = newType;
    param_240 = _e759;
    param_241 = _e758;
    param_242 = 0u;
    let _e760 = count_2;
    param_243 = _e760;
    let _e761 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_240), (&param_241), (&param_242), (&param_243));
    let _e762 = atomicCompareExchangeWeak((&unnamed.grid[_e752]), _e755, _e761);
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

    let _e220 = (*pos_6)[1u];
    if (_e220 > 1i) {
        let _e222 = (*pos_6);
        belowPos_2 = (_e222 + vec3<i32>(0i, -1i, 0i));
        let _e224 = belowPos_2;
        param_244 = _e224;
        let _e225 = getIndex_u0028_vi3_u003b((&param_244));
        param_245 = _e225;
        let _e226 = readCell_u0028_u1_u003b((&param_245));
        param_246 = _e226;
        let _e227 = getType_u0028_u1_u003b((&param_246));
        if (_e227 == 0u) {
            let _e229 = belowPos_2;
            param_247 = _e229;
            let _e230 = getIndex_u0028_vi3_u003b((&param_247));
            param_248 = 12u;
            param_249 = 0u;
            param_250 = 0u;
            let _e231 = (*currentAge_3);
            param_251 = _e231;
            let _e232 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_248), (&param_249), (&param_250), (&param_251));
            let _e233 = (*currentIndex_4);
            param_252 = _e233;
            let _e234 = (*rawValue_3);
            param_253 = _e234;
            param_254 = _e230;
            param_255 = _e232;
            let _e235 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_252), (&param_253), (&param_254), (&param_255));
            if _e235 {
                return;
            }
        }
    }
    let _e236 = (*currentAge_3);
    let _e237 = (_e236 > 0u);
    phi_6268_ = _e237;
    if _e237 {
        let _e238 = (*randVal_4);
        let _e242 = tuning.darkStoneDryChance;
        phi_6268_ = (fract((_e238 * 23f)) < _e242);
    }
    let _e245 = phi_6268_;
    if _e245 {
        let _e246 = (*currentIndex_4);
        let _e249 = (*rawValue_3);
        let _e250 = (*currentAge_3);
        param_256 = 12u;
        param_257 = 0u;
        param_258 = 0u;
        param_259 = (_e250 - 1u);
        let _e252 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_256), (&param_257), (&param_258), (&param_259));
        let _e253 = atomicCompareExchangeWeak((&unnamed.grid[_e246]), _e249, _e252);
    }
    return;
}

fn isLava_u0028_u1_u003b(type_35: ptr<function, u32>) -> bool {
    let _e198 = (*type_35);
    let _e200 = (*type_35);
    return ((_e198 >= 8u) && (_e200 <= 11u));
}

fn lavaTypeFor_u0028_u1_u003b(coolness: ptr<function, u32>) -> u32 {
    let _e198 = (*coolness);
    let _e200 = tuning.lavaStageSize;
    return (8u + min((_e198 / max(_e200, 1u)), 3u));
}

fn lavaSolidifyCoolness_u0028_() -> u32 {
    let _e198 = tuning.lavaStageSize;
    return min((max(_e198, 1u) * 4u), 255u);
}

fn decWater_u0028_() {
    let _e198 = atomicAdd((&unnamed_2.waterVoxelCount), 4294967295u);
    return;
}

fn getOrthoDir_u0028_i1_u003b(d_5: ptr<function, i32>) -> vec3<i32> {
    let _e198 = (*d_5);
    if (_e198 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e200 = (*d_5);
    if (_e200 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e202 = (*d_5);
    if (_e202 == 2i) {
        return vec3<i32>(0i, 1i, 0i);
    }
    let _e204 = (*d_5);
    if (_e204 == 3i) {
        return vec3<i32>(0i, -1i, 0i);
    }
    let _e206 = (*d_5);
    if (_e206 == 4i) {
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

    let _e265 = (*randVal_5);
    startDir = i32((fract((_e265 * 17f)) * 6f));
    i_7 = 0i;
    loop {
        let _e270 = i_7;
        if (_e270 < 6i) {
            let _e272 = startDir;
            let _e273 = i_7;
            let _e274 = (_e272 + _e273);
            d_6 = (_e274 - (i32(floor((f32(_e274) / f32(6i)))) * 6i));
            let _e282 = (*pos_7);
            let _e283 = d_6;
            param_260 = _e283;
            let _e284 = getOrthoDir_u0028_i1_u003b((&param_260));
            nPos = (_e282 + _e284);
            let _e287 = nPos[0u];
            let _e288 = (_e287 <= 0i);
            phi_5322_ = _e288;
            if !(_e288) {
                let _e291 = nPos[0u];
                let _e293 = tuning.gridWidth;
                phi_5322_ = (_e291 >= (bitcast<i32>(_e293) - 1i));
            }
            let _e298 = phi_5322_;
            phi_5329_ = _e298;
            if !(_e298) {
                let _e301 = nPos[1u];
                phi_5329_ = (_e301 <= 0i);
            }
            let _e304 = phi_5329_;
            phi_5340_ = _e304;
            if !(_e304) {
                let _e307 = nPos[1u];
                let _e309 = tuning.gridHeight;
                phi_5340_ = (_e307 >= (bitcast<i32>(_e309) - 1i));
            }
            let _e314 = phi_5340_;
            phi_5347_ = _e314;
            if !(_e314) {
                let _e317 = nPos[2u];
                phi_5347_ = (_e317 <= 0i);
            }
            let _e320 = phi_5347_;
            phi_5358_ = _e320;
            if !(_e320) {
                let _e323 = nPos[2u];
                let _e325 = tuning.gridDepth;
                phi_5358_ = (_e323 >= (bitcast<i32>(_e325) - 1i));
            }
            let _e330 = phi_5358_;
            if _e330 {
                continue;
            }
            let _e331 = nPos;
            param_261 = _e331;
            let _e332 = getIndex_u0028_vi3_u003b((&param_261));
            nIndex = _e332;
            let _e333 = nIndex;
            param_262 = _e333;
            let _e334 = readCell_u0028_u1_u003b((&param_262));
            nVal = _e334;
            let _e335 = nVal;
            param_263 = _e335;
            let _e336 = getType_u0028_u1_u003b((&param_263));
            nType = _e336;
            let _e337 = nType;
            if (_e337 == 2u) {
                let _e339 = nIndex;
                let _e342 = nVal;
                param_264 = 6u;
                param_265 = 0u;
                param_266 = 0u;
                param_267 = 0u;
                let _e343 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_264), (&param_265), (&param_266), (&param_267));
                let _e344 = atomicCompareExchangeWeak((&unnamed.grid[_e339]), _e342, _e343);
                let _e346 = nVal;
                if (_e344.old_value == _e346) {
                    decWater_u0028_();
                    let _e348 = (*coolness_1);
                    let _e350 = tuning.lavaWaterCool;
                    (*coolness_1) = min((_e348 + _e350), 255u);
                    return;
                }
            } else {
                let _e353 = nType;
                if (_e353 == 19u) {
                    let _e355 = nIndex;
                    let _e358 = nVal;
                    let _e359 = atomicCompareExchangeWeak((&unnamed.grid[_e355]), _e358, 0u);
                    let _e361 = nVal;
                    if (_e359.old_value == _e361) {
                        return;
                    }
                } else {
                    let _e363 = nType;
                    if (_e363 == 18u) {
                        let _e365 = nIndex;
                        let _e368 = nVal;
                        param_268 = 5u;
                        param_269 = 0u;
                        param_270 = 0u;
                        param_271 = 0u;
                        let _e369 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_268), (&param_269), (&param_270), (&param_271));
                        let _e370 = atomicCompareExchangeWeak((&unnamed.grid[_e365]), _e368, _e369);
                        let _e372 = nVal;
                        if (_e370.old_value == _e372) {
                            return;
                        }
                    } else {
                        let _e374 = nType;
                        if (_e374 == 3u) {
                            let _e376 = nIndex;
                            let _e379 = nVal;
                            param_272 = 12u;
                            param_273 = 0u;
                            param_274 = 0u;
                            param_275 = 255u;
                            let _e380 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_272), (&param_273), (&param_274), (&param_275));
                            let _e381 = atomicCompareExchangeWeak((&unnamed.grid[_e376]), _e379, _e380);
                            let _e383 = nVal;
                            if (_e381.old_value == _e383) {
                                return;
                            }
                        } else {
                            let _e385 = nType;
                            let _e387 = nType;
                            if ((_e385 == 1u) || (_e387 == 4u)) {
                                let _e390 = nVal;
                                param_276 = _e390;
                                let _e391 = getAge_u0028_u1_u003b((&param_276));
                                moisture_1 = _e391;
                                let _e392 = nVal;
                                param_277 = _e392;
                                let _e393 = getDir_u0028_u1_u003b((&param_277));
                                flora_2 = _e393;
                                let _e394 = nType;
                                let _e396 = flora_2;
                                let _e399 = flora_2;
                                if (((_e394 == 4u) && (_e396 > 10u)) && (_e399 <= 100u)) {
                                    let _e402 = nPos;
                                    abovePos = (_e402 + vec3<i32>(0i, 1i, 0i));
                                    let _e405 = abovePos[1u];
                                    let _e407 = tuning.gridHeight;
                                    let _e410 = (_e405 < (bitcast<i32>(_e407) - 1i));
                                    phi_5497_ = _e410;
                                    if _e410 {
                                        let _e411 = abovePos;
                                        param_278 = _e411;
                                        let _e412 = getIndex_u0028_vi3_u003b((&param_278));
                                        param_279 = _e412;
                                        let _e413 = readCell_u0028_u1_u003b((&param_279));
                                        param_280 = _e413;
                                        let _e414 = getType_u0028_u1_u003b((&param_280));
                                        phi_5497_ = (_e414 == 0u);
                                    }
                                    let _e417 = phi_5497_;
                                    phi_5508_ = _e417;
                                    if _e417 {
                                        let _e418 = (*randVal_5);
                                        let _e422 = tuning.lavaIgniteChance;
                                        phi_5508_ = (fract((_e418 * 41f)) < _e422);
                                    }
                                    let _e425 = phi_5508_;
                                    if _e425 {
                                        let _e426 = abovePos;
                                        param_281 = _e426;
                                        let _e427 = getIndex_u0028_vi3_u003b((&param_281));
                                        param_282 = 5u;
                                        param_283 = 0u;
                                        param_284 = 0u;
                                        param_285 = 0u;
                                        let _e430 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_282), (&param_283), (&param_284), (&param_285));
                                        let _e431 = atomicCompareExchangeWeak((&unnamed.grid[_e427]), 0u, _e430);
                                        if (_e431.old_value == 0u) {
                                            return;
                                        }
                                    }
                                } else {
                                    let _e434 = moisture_1;
                                    if (_e434 > 0u) {
                                        let _e436 = nIndex;
                                        let _e439 = nVal;
                                        let _e440 = moisture_1;
                                        let _e442 = nType;
                                        param_286 = _e442;
                                        let _e443 = flora_2;
                                        param_287 = _e443;
                                        param_288 = 0u;
                                        param_289 = (_e440 - 1u);
                                        let _e444 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_286), (&param_287), (&param_288), (&param_289));
                                        let _e445 = atomicCompareExchangeWeak((&unnamed.grid[_e436]), _e439, _e444);
                                        let _e447 = nVal;
                                        if (_e445.old_value == _e447) {
                                            let _e449 = (*coolness_1);
                                            let _e451 = tuning.lavaMoistureCool;
                                            (*coolness_1) = min((_e449 + _e451), 255u);
                                            return;
                                        }
                                    } else {
                                        let _e454 = (*randVal_5);
                                        let _e458 = tuning.lavaConsumeChance;
                                        if (fract((_e454 * 53f)) < _e458) {
                                            let _e460 = nIndex;
                                            let _e463 = nVal;
                                            let _e464 = atomicCompareExchangeWeak((&unnamed.grid[_e460]), _e463, 0u);
                                            let _e466 = nVal;
                                            if (_e464.old_value == _e466) {
                                                return;
                                            }
                                        }
                                    }
                                }
                            } else {
                                let _e468 = nType;
                                param_290 = _e468;
                                let _e469 = isLava_u0028_u1_u003b((&param_290));
                                if _e469 {
                                    let _e470 = nVal;
                                    param_291 = _e470;
                                    let _e471 = getAge_u0028_u1_u003b((&param_291));
                                    nCool = _e471;
                                    let _e472 = (*coolness_1);
                                    let _e473 = nCool;
                                    if (_e472 > (_e473 + 1u)) {
                                        let _e476 = nCool;
                                        raised = (_e476 + 1u);
                                        let _e478 = raised;
                                        let _e479 = lavaSolidifyCoolness_u0028_();
                                        if (_e478 >= _e479) {
                                            local_10 = 12u;
                                        } else {
                                            let _e481 = raised;
                                            param_292 = _e481;
                                            let _e482 = lavaTypeFor_u0028_u1_u003b((&param_292));
                                            local_10 = _e482;
                                        }
                                        let _e483 = local_10;
                                        raisedType = _e483;
                                        let _e484 = nIndex;
                                        let _e487 = nVal;
                                        let _e488 = nVal;
                                        param_293 = _e488;
                                        let _e489 = getDir_u0028_u1_u003b((&param_293));
                                        let _e490 = raisedType;
                                        param_294 = _e490;
                                        param_295 = _e489;
                                        param_296 = 0u;
                                        let _e491 = raised;
                                        param_297 = _e491;
                                        let _e492 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_294), (&param_295), (&param_296), (&param_297));
                                        let _e493 = atomicCompareExchangeWeak((&unnamed.grid[_e484]), _e487, _e492);
                                        let _e495 = nVal;
                                        if (_e493.old_value == _e495) {
                                            let _e497 = (*coolness_1);
                                            (*coolness_1) = (_e497 - 1u);
                                            return;
                                        }
                                    }
                                } else {
                                    let _e499 = nType;
                                    if (_e499 == 12u) {
                                        let _e501 = nVal;
                                        param_298 = _e501;
                                        let _e502 = getAge_u0028_u1_u003b((&param_298));
                                        nCool_1 = _e502;
                                        let _e503 = nCool_1;
                                        let _e504 = (*coolness_1);
                                        draws = (_e503 > (_e504 + 1u));
                                        let _e507 = draws;
                                        if _e507 {
                                            let _e508 = nCool_1;
                                            local_11 = (_e508 - 1u);
                                        } else {
                                            let _e510 = nCool_1;
                                            local_11 = _e510;
                                        }
                                        let _e511 = local_11;
                                        lowered = _e511;
                                        let _e512 = lowered;
                                        let _e513 = lavaSolidifyCoolness_u0028_();
                                        melts = (_e512 < _e513);
                                        let _e515 = draws;
                                        let _e516 = melts;
                                        if (_e515 || _e516) {
                                            let _e518 = melts;
                                            if _e518 {
                                                let _e519 = lowered;
                                                param_299 = _e519;
                                                let _e520 = lavaTypeFor_u0028_u1_u003b((&param_299));
                                                local_12 = _e520;
                                            } else {
                                                local_12 = 12u;
                                            }
                                            let _e521 = local_12;
                                            newType_1 = _e521;
                                            let _e522 = nIndex;
                                            let _e525 = nVal;
                                            let _e526 = newType_1;
                                            param_300 = _e526;
                                            param_301 = 0u;
                                            param_302 = 0u;
                                            let _e527 = lowered;
                                            param_303 = _e527;
                                            let _e528 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_300), (&param_301), (&param_302), (&param_303));
                                            let _e529 = atomicCompareExchangeWeak((&unnamed.grid[_e522]), _e525, _e528);
                                            let _e531 = nVal;
                                            if (_e529.old_value == _e531) {
                                                let _e533 = draws;
                                                if _e533 {
                                                    let _e534 = (*coolness_1);
                                                    (*coolness_1) = min((_e534 + 1u), 255u);
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
            let _e537 = i_7;
            i_7 = (_e537 + 1i);
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

    let _e299 = (*currentAge_4);
    coolness_2 = _e299;
    let _e300 = (*pos_8);
    param_304 = _e300;
    let _e301 = coolness_2;
    param_305 = _e301;
    let _e302 = (*randVal_6);
    param_306 = _e302;
    lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b((&param_304), (&param_305), (&param_306));
    let _e303 = param_305;
    coolness_2 = _e303;
    let _e304 = (*currentSleep_1);
    let _e306 = tuning.wakeSleepThreshold;
    let _e307 = (_e304 > _e306);
    phi_5716_ = _e307;
    if _e307 {
        let _e308 = (*randVal_6);
        let _e312 = tuning.lavaRestCoolChance;
        phi_5716_ = (fract((_e308 * 71f)) < _e312);
    }
    let _e315 = phi_5716_;
    if _e315 {
        let _e316 = coolness_2;
        coolness_2 = min((_e316 + 1u), 255u);
    }
    let _e319 = coolness_2;
    let _e320 = lavaSolidifyCoolness_u0028_();
    if (_e319 >= _e320) {
        let _e322 = (*currentIndex_5);
        let _e325 = (*rawValue_4);
        param_307 = 12u;
        param_308 = 0u;
        param_309 = 0u;
        let _e326 = coolness_2;
        param_310 = _e326;
        let _e327 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_307), (&param_308), (&param_309), (&param_310));
        let _e328 = atomicCompareExchangeWeak((&unnamed.grid[_e322]), _e325, _e327);
        return;
    }
    let _e330 = coolness_2;
    param_311 = _e330;
    let _e331 = lavaTypeFor_u0028_u1_u003b((&param_311));
    newType_2 = _e331;
    let _e332 = (*randVal_6);
    let _e336 = tuning.lavaViscosity;
    if (fract((_e332 * 89f)) < _e336) {
        let _e339 = (*pos_8)[1u];
        if (_e339 > 1i) {
            let _e341 = (*pos_8);
            belowPos_3 = (_e341 + vec3<i32>(0i, -1i, 0i));
            let _e343 = belowPos_3;
            param_312 = _e343;
            let _e344 = getIndex_u0028_vi3_u003b((&param_312));
            param_313 = _e344;
            let _e345 = readCell_u0028_u1_u003b((&param_313));
            param_314 = _e345;
            let _e346 = getType_u0028_u1_u003b((&param_314));
            if (_e346 == 0u) {
                let _e348 = belowPos_3;
                param_315 = _e348;
                let _e349 = getIndex_u0028_vi3_u003b((&param_315));
                let _e350 = newType_2;
                param_316 = _e350;
                let _e351 = (*currentDir_2);
                param_317 = _e351;
                param_318 = 0u;
                let _e352 = coolness_2;
                param_319 = _e352;
                let _e353 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_316), (&param_317), (&param_318), (&param_319));
                let _e354 = (*currentIndex_5);
                param_320 = _e354;
                let _e355 = (*rawValue_4);
                param_321 = _e355;
                param_322 = _e349;
                param_323 = _e353;
                let _e356 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_320), (&param_321), (&param_322), (&param_323));
                if _e356 {
                    return;
                }
            }
        }
        let _e358 = (*pos_8)[1u];
        if (_e358 > 1i) {
            let _e360 = (*randVal_6);
            slideDir = select(-1i, 1i, (fract((_e360 * 10f)) > 0.5f));
            let _e365 = (*randVal_6);
            if (fract((_e365 * 100f)) > 0.5f) {
                let _e369 = (*pos_8);
                let _e370 = slideDir;
                slide[0i] = (_e369 + vec3<i32>(_e370, -1i, 0i));
                let _e374 = (*pos_8);
                let _e375 = slideDir;
                slide[1i] = (_e374 + vec3<i32>(0i, -1i, _e375));
            } else {
                let _e379 = (*pos_8);
                let _e380 = slideDir;
                slide[0i] = (_e379 + vec3<i32>(0i, -1i, _e380));
                let _e384 = (*pos_8);
                let _e385 = slideDir;
                slide[1i] = (_e384 + vec3<i32>(_e385, -1i, 0i));
            }
            s = 0i;
            loop {
                let _e389 = s;
                if (_e389 < 2i) {
                    let _e391 = s;
                    let _e393 = slide[_e391];
                    sPos = _e393;
                    let _e395 = sPos[0u];
                    let _e396 = (_e395 > 0i);
                    phi_5854_ = _e396;
                    if _e396 {
                        let _e398 = sPos[0u];
                        let _e400 = tuning.gridWidth;
                        phi_5854_ = (_e398 < (bitcast<i32>(_e400) - 1i));
                    }
                    let _e405 = phi_5854_;
                    phi_5860_ = _e405;
                    if _e405 {
                        let _e407 = sPos[2u];
                        phi_5860_ = (_e407 > 0i);
                    }
                    let _e410 = phi_5860_;
                    phi_5870_ = _e410;
                    if _e410 {
                        let _e412 = sPos[2u];
                        let _e414 = tuning.gridDepth;
                        phi_5870_ = (_e412 < (bitcast<i32>(_e414) - 1i));
                    }
                    let _e419 = phi_5870_;
                    if _e419 {
                        let _e420 = sPos;
                        param_324 = _e420;
                        let _e421 = getIndex_u0028_vi3_u003b((&param_324));
                        param_325 = _e421;
                        let _e422 = readCell_u0028_u1_u003b((&param_325));
                        param_326 = _e422;
                        let _e423 = getType_u0028_u1_u003b((&param_326));
                        if (_e423 == 0u) {
                            let _e425 = sPos;
                            param_327 = _e425;
                            let _e426 = getIndex_u0028_vi3_u003b((&param_327));
                            let _e427 = newType_2;
                            param_328 = _e427;
                            let _e428 = (*currentDir_2);
                            param_329 = _e428;
                            param_330 = 0u;
                            let _e429 = coolness_2;
                            param_331 = _e429;
                            let _e430 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_328), (&param_329), (&param_330), (&param_331));
                            let _e431 = (*currentIndex_5);
                            param_332 = _e431;
                            let _e432 = (*rawValue_4);
                            param_333 = _e432;
                            param_334 = _e426;
                            param_335 = _e430;
                            let _e433 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_332), (&param_333), (&param_334), (&param_335));
                            if _e433 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e434 = s;
                    s = (_e434 + 1i);
                }
            }
        }
        let _e436 = (*currentSleep_1);
        let _e438 = tuning.wakeSleepThreshold;
        if (_e436 <= _e438) {
            blockedMask = 0u;
            let _e440 = (*randVal_6);
            searchStart = i32((fract((_e440 * 8f)) * 8f));
            let _e446 = tuning.lavaSpreadRadius;
            reach = bitcast<i32>(max(_e446, 1u));
            r = 1i;
            loop {
                let _e449 = r;
                let _e450 = reach;
                if (_e449 <= _e450) {
                    let _e452 = blockedMask;
                    if (_e452 == 255u) {
                        break;
                    }
                    i_8 = 0i;
                    loop {
                        let _e454 = i_8;
                        if (_e454 < 8i) {
                            let _e456 = searchStart;
                            let _e457 = i_8;
                            let _e458 = (_e456 + _e457);
                            d_7 = (_e458 - (i32(floor((f32(_e458) / f32(8i)))) * 8i));
                            let _e466 = blockedMask;
                            let _e467 = d_7;
                            if ((_e466 & (1u << bitcast<u32>(_e467))) != 0u) {
                                continue;
                            }
                            let _e472 = (*pos_8);
                            let _e473 = d_7;
                            param_336 = _e473;
                            let _e474 = getHDir_u0028_i1_u003b((&param_336));
                            let _e475 = r;
                            c_6 = (_e472 + (_e474 * vec3(_e475)));
                            let _e480 = c_6[0u];
                            let _e481 = (_e480 <= 0i);
                            phi_5982_ = _e481;
                            if !(_e481) {
                                let _e484 = c_6[0u];
                                let _e486 = tuning.gridWidth;
                                phi_5982_ = (_e484 >= (bitcast<i32>(_e486) - 1i));
                            }
                            let _e491 = phi_5982_;
                            phi_5989_ = _e491;
                            if !(_e491) {
                                let _e494 = c_6[2u];
                                phi_5989_ = (_e494 <= 0i);
                            }
                            let _e497 = phi_5989_;
                            phi_6000_ = _e497;
                            if !(_e497) {
                                let _e500 = c_6[2u];
                                let _e502 = tuning.gridDepth;
                                phi_6000_ = (_e500 >= (bitcast<i32>(_e502) - 1i));
                            }
                            let _e507 = phi_6000_;
                            phi_6012_ = _e507;
                            if !(_e507) {
                                let _e509 = c_6;
                                param_337 = _e509;
                                let _e510 = getIndex_u0028_vi3_u003b((&param_337));
                                param_338 = _e510;
                                let _e511 = readCell_u0028_u1_u003b((&param_338));
                                param_339 = _e511;
                                let _e512 = getType_u0028_u1_u003b((&param_339));
                                phi_6012_ = (_e512 != 0u);
                            }
                            let _e515 = phi_6012_;
                            if _e515 {
                                let _e516 = d_7;
                                let _e519 = blockedMask;
                                blockedMask = (_e519 | (1u << bitcast<u32>(_e516)));
                            } else {
                                let _e522 = c_6[1u];
                                let _e523 = (_e522 > 1i);
                                phi_6034_ = _e523;
                                if _e523 {
                                    let _e524 = c_6;
                                    param_340 = (_e524 + vec3<i32>(0i, -1i, 0i));
                                    let _e526 = getIndex_u0028_vi3_u003b((&param_340));
                                    param_341 = _e526;
                                    let _e527 = readCell_u0028_u1_u003b((&param_341));
                                    param_342 = _e527;
                                    let _e528 = getType_u0028_u1_u003b((&param_342));
                                    phi_6034_ = (_e528 == 0u);
                                }
                                let _e531 = phi_6034_;
                                if _e531 {
                                    let _e532 = c_6;
                                    param_343 = _e532;
                                    let _e533 = getIndex_u0028_vi3_u003b((&param_343));
                                    let _e534 = newType_2;
                                    param_344 = _e534;
                                    param_345 = 0u;
                                    param_346 = 0u;
                                    let _e535 = coolness_2;
                                    param_347 = _e535;
                                    let _e536 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_344), (&param_345), (&param_346), (&param_347));
                                    let _e537 = (*currentIndex_5);
                                    param_348 = _e537;
                                    let _e538 = (*rawValue_4);
                                    param_349 = _e538;
                                    param_350 = _e533;
                                    param_351 = _e536;
                                    let _e539 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_348), (&param_349), (&param_350), (&param_351));
                                    if _e539 {
                                        return;
                                    }
                                    let _e540 = d_7;
                                    let _e543 = blockedMask;
                                    blockedMask = (_e543 | (1u << bitcast<u32>(_e540)));
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e545 = i_8;
                            i_8 = (_e545 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e547 = r;
                    r = (_e547 + 1i);
                }
            }
            let _e550 = (*pos_8)[1u];
            let _e552 = tuning.gridHeight;
            if (_e550 < (bitcast<i32>(_e552) - 2i)) {
                let _e556 = (*pos_8);
                param_352 = (_e556 + vec3<i32>(0i, 1i, 0i));
                let _e558 = getIndex_u0028_vi3_u003b((&param_352));
                param_353 = _e558;
                let _e559 = readCell_u0028_u1_u003b((&param_353));
                param_354 = _e559;
                let _e560 = getType_u0028_u1_u003b((&param_354));
                local_13 = (_e560 != 0u);
            } else {
                local_13 = false;
            }
            let _e562 = local_13;
            hasPressure = _e562;
            let _e564 = (*pos_8)[1u];
            if (_e564 > 1i) {
                let _e566 = (*pos_8);
                param_355 = (_e566 + vec3<i32>(0i, -1i, 0i));
                let _e568 = getIndex_u0028_vi3_u003b((&param_355));
                param_356 = _e568;
                let _e569 = readCell_u0028_u1_u003b((&param_356));
                param_357 = _e569;
                let _e570 = getType_u0028_u1_u003b((&param_357));
                param_358 = _e570;
                let _e571 = isLava_u0028_u1_u003b((&param_358));
                local_14 = _e571;
            } else {
                local_14 = false;
            }
            let _e572 = local_14;
            stackedOnLava = _e572;
            let _e573 = hasPressure;
            let _e574 = stackedOnLava;
            if (_e573 || _e574) {
                let _e576 = (*randVal_6);
                spreadStart = i32((fract((_e576 * 8f)) * 8f));
                i_9 = 0i;
                loop {
                    let _e581 = i_9;
                    if (_e581 < 8i) {
                        let _e583 = spreadStart;
                        let _e584 = i_9;
                        let _e585 = (_e583 + _e584);
                        d_8 = (_e585 - (i32(floor((f32(_e585) / f32(8i)))) * 8i));
                        let _e593 = (*pos_8);
                        let _e594 = d_8;
                        param_359 = _e594;
                        let _e595 = getHDir_u0028_i1_u003b((&param_359));
                        targetPos = (_e593 + _e595);
                        let _e598 = targetPos[0u];
                        let _e599 = (_e598 > 0i);
                        phi_6148_ = _e599;
                        if _e599 {
                            let _e601 = targetPos[0u];
                            let _e603 = tuning.gridWidth;
                            phi_6148_ = (_e601 < (bitcast<i32>(_e603) - 1i));
                        }
                        let _e608 = phi_6148_;
                        phi_6154_ = _e608;
                        if _e608 {
                            let _e610 = targetPos[2u];
                            phi_6154_ = (_e610 > 0i);
                        }
                        let _e613 = phi_6154_;
                        phi_6164_ = _e613;
                        if _e613 {
                            let _e615 = targetPos[2u];
                            let _e617 = tuning.gridDepth;
                            phi_6164_ = (_e615 < (bitcast<i32>(_e617) - 1i));
                        }
                        let _e622 = phi_6164_;
                        if _e622 {
                            let _e623 = targetPos;
                            param_360 = _e623;
                            let _e624 = getIndex_u0028_vi3_u003b((&param_360));
                            param_361 = _e624;
                            let _e625 = readCell_u0028_u1_u003b((&param_361));
                            param_362 = _e625;
                            let _e626 = getType_u0028_u1_u003b((&param_362));
                            if (_e626 == 0u) {
                                let _e628 = targetPos;
                                param_363 = _e628;
                                let _e629 = getIndex_u0028_vi3_u003b((&param_363));
                                let _e630 = d_8;
                                let _e633 = newType_2;
                                param_364 = _e633;
                                param_365 = bitcast<u32>((_e630 + 1i));
                                param_366 = 0u;
                                let _e634 = coolness_2;
                                param_367 = _e634;
                                let _e635 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_364), (&param_365), (&param_366), (&param_367));
                                let _e636 = (*currentIndex_5);
                                param_368 = _e636;
                                let _e637 = (*rawValue_4);
                                param_369 = _e637;
                                param_370 = _e629;
                                param_371 = _e635;
                                let _e638 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_368), (&param_369), (&param_370), (&param_371));
                                if _e638 {
                                    return;
                                }
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e639 = i_9;
                        i_9 = (_e639 + 1i);
                    }
                }
            }
        }
    }
    let _e641 = (*currentSleep_1);
    newSleep = min((_e641 + 1u), 255u);
    let _e644 = (*currentIndex_5);
    let _e647 = (*rawValue_4);
    let _e648 = newType_2;
    param_372 = _e648;
    let _e649 = (*currentDir_2);
    param_373 = _e649;
    let _e650 = newSleep;
    param_374 = _e650;
    let _e651 = coolness_2;
    param_375 = _e651;
    let _e652 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_372), (&param_373), (&param_374), (&param_375));
    let _e653 = atomicCompareExchangeWeak((&unnamed.grid[_e644]), _e647, _e652);
    return;
}

fn getCloudMoved_u0028_u1_u003b(v_2: ptr<function, u32>) -> bool {
    let _e198 = (*v_2);
    return ((_e198 & 4u) != 0u);
}

fn getCloudKind_u0028_u1_u003b(v_3: ptr<function, u32>) -> u32 {
    let _e198 = (*v_3);
    return (_e198 & 3u);
}

fn cloudIsAtRest_u0028_u1_u003b(v_4: ptr<function, u32>) -> bool {
    var param_376: u32;
    var param_377: u32;
    var phi_677_: bool;

    let _e200 = (*v_4);
    param_376 = _e200;
    let _e201 = getCloudKind_u0028_u1_u003b((&param_376));
    let _e202 = (_e201 != 0u);
    phi_677_ = _e202;
    if _e202 {
        let _e203 = (*v_4);
        param_377 = _e203;
        let _e204 = getCloudMoved_u0028_u1_u003b((&param_377));
        phi_677_ = !(_e204);
    }
    let _e207 = phi_677_;
    return _e207;
}

fn cloudCellInBounds_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> bool {
    var phi_579_: bool;
    var phi_585_: bool;
    var phi_595_: bool;
    var phi_601_: bool;
    var phi_611_: bool;

    let _e199 = (*p_3)[0u];
    let _e200 = (_e199 >= 1i);
    phi_579_ = _e200;
    if _e200 {
        let _e202 = (*p_3)[0u];
        let _e204 = tuning.gridWidth;
        phi_579_ = (_e202 < (bitcast<i32>(_e204) - 1i));
    }
    let _e209 = phi_579_;
    phi_585_ = _e209;
    if _e209 {
        let _e211 = (*p_3)[1u];
        phi_585_ = (_e211 >= 1i);
    }
    let _e214 = phi_585_;
    phi_595_ = _e214;
    if _e214 {
        let _e216 = (*p_3)[1u];
        let _e218 = tuning.gridHeight;
        phi_595_ = (_e216 < (bitcast<i32>(_e218) - 1i));
    }
    let _e223 = phi_595_;
    phi_601_ = _e223;
    if _e223 {
        let _e225 = (*p_3)[2u];
        phi_601_ = (_e225 >= 1i);
    }
    let _e228 = phi_601_;
    phi_611_ = _e228;
    if _e228 {
        let _e230 = (*p_3)[2u];
        let _e232 = tuning.gridDepth;
        phi_611_ = (_e230 < (bitcast<i32>(_e232) - 1i));
    }
    let _e237 = phi_611_;
    return _e237;
}

fn cloudTouchesRain_u0028_vi3_u003b(pos_9: ptr<function, vec3<i32>>) -> bool {
    var i_10: i32;
    var n_1: vec3<i32>;
    var param_378: i32;
    var param_379: vec3<i32>;
    var param_380: vec3<i32>;
    var param_381: u32;

    i_10 = 0i;
    loop {
        let _e204 = i_10;
        if (_e204 < 6i) {
            let _e206 = (*pos_9);
            let _e207 = i_10;
            param_378 = _e207;
            let _e208 = getOrthoDir_u0028_i1_u003b((&param_378));
            n_1 = (_e206 + _e208);
            let _e210 = n_1;
            param_379 = _e210;
            let _e211 = cloudCellInBounds_u0028_vi3_u003b((&param_379));
            if !(_e211) {
                continue;
            }
            let _e213 = n_1;
            param_380 = _e213;
            let _e214 = getIndex_u0028_vi3_u003b((&param_380));
            let _e217 = atomicLoad((&unnamed_1.cloudCells[_e214]));
            param_381 = _e217;
            let _e218 = getCloudKind_u0028_u1_u003b((&param_381));
            if (_e218 == 2u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e220 = i_10;
            i_10 = (_e220 + 1i);
        }
    }
    return false;
}

fn packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b(kind: ptr<function, u32>, moved: ptr<function, bool>, counter: ptr<function, u32>, target_1: ptr<function, u32>) -> u32 {
    let _e201 = (*kind);
    let _e203 = (*moved);
    let _e206 = (*counter);
    let _e211 = (*target_1);
    return ((((_e201 & 3u) | select(0u, 4u, _e203)) | (min(_e206, 2047u) << bitcast<u32>(3i))) | (min(_e211, 2047u) << bitcast<u32>(14i)));
}

fn updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_10: ptr<function, vec3<i32>>, currentIndex_6: ptr<function, u32>, rawValue_5: ptr<function, u32>, currentSleep_2: ptr<function, u32>, currentAge_5: ptr<function, u32>, randVal_7: ptr<function, f32>) {
    var newKind: u32;
    var param_382: u32;
    var param_383: bool;
    var param_384: u32;
    var param_385: u32;
    var newAge: u32;
    var newKind_1: u32;
    var param_386: vec3<i32>;
    var param_387: u32;
    var param_388: bool;
    var param_389: u32;
    var param_390: u32;
    var d_9: i32;
    var scatterPos: vec3<i32>;
    var param_391: i32;
    var sType: u32;
    var param_392: vec3<i32>;
    var param_393: u32;
    var param_394: u32;
    var param_395: vec3<i32>;
    var param_396: u32;
    var param_397: vec3<i32>;
    var param_398: u32;
    var param_399: u32;
    var param_400: u32;
    var param_401: u32;
    var param_402: u32;
    var param_403: u32;
    var param_404: u32;
    var param_405: u32;
    var checkPos: array<vec3<i32>, 3>;
    var dir_1: i32;
    var upPos_1: vec3<i32>;
    var underSettled: bool;
    var param_406: vec3<i32>;
    var param_407: vec3<i32>;
    var param_408: u32;
    var touchingRain: bool;
    var param_409: vec3<i32>;
    var newKind_2: u32;
    var param_410: u32;
    var param_411: bool;
    var param_412: u32;
    var param_413: u32;
    var i_11: i32;
    var cPos: vec3<i32>;
    var cIndex: u32;
    var param_414: vec3<i32>;
    var cVal: u32;
    var param_415: u32;
    var cType: u32;
    var param_416: u32;
    var moisture_2: u32;
    var param_417: u32;
    var capacity: u32;
    var local_15: u32;
    var i_12: i32;
    var sPos_1: vec3<i32>;
    var sType_1: u32;
    var param_418: vec3<i32>;
    var param_419: u32;
    var param_420: u32;
    var param_421: vec3<i32>;
    var param_422: u32;
    var param_423: vec3<i32>;
    var param_424: u32;
    var param_425: u32;
    var param_426: u32;
    var param_427: u32;
    var param_428: u32;
    var param_429: u32;
    var param_430: u32;
    var param_431: u32;
    var newSleep_1: u32;
    var param_432: u32;
    var param_433: u32;
    var param_434: u32;
    var param_435: u32;
    var phi_8365_: bool;
    var phi_8414_: bool;
    var phi_8420_: bool;
    var phi_8430_: bool;
    var phi_8436_: bool;
    var phi_8446_: bool;
    var phi_8472_: bool;
    var phi_8549_: bool;
    var phi_8567_: bool;
    var phi_8609_: bool;
    var phi_8615_: bool;
    var phi_8625_: bool;
    var phi_8706_: bool;
    var phi_8716_: bool;
    var phi_8722_: bool;
    var phi_8732_: bool;
    var phi_8758_: bool;

    let _e282 = (*pos_10)[1u];
    let _e284 = tuning.gridHeight;
    if (_e282 >= (bitcast<i32>(_e284) - 2i)) {
        let _e289 = unnamed_2.rainPhase;
        newKind = select(1u, 2u, (_e289 == 2u));
        let _e292 = (*currentIndex_6);
        let _e295 = newKind;
        param_382 = _e295;
        param_383 = false;
        param_384 = 0u;
        param_385 = 0u;
        let _e296 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_382), (&param_383), (&param_384), (&param_385));
        let _e297 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e292]), 0u, _e296);
        if (_e297.old_value == 0u) {
            let _e300 = (*currentIndex_6);
            let _e303 = atomicExchange((&unnamed.grid[_e300]), 0u);
            return;
        }
        let _e304 = (*currentIndex_6);
        let _e307 = atomicExchange((&unnamed.grid[_e304]), 0u);
        return;
    }
    let _e308 = (*currentAge_5);
    newAge = min((_e308 + 1u), 255u);
    let _e311 = (*currentSleep_2);
    let _e313 = tuning.steamCondenseTicks;
    if (_e311 >= _e313) {
        let _e316 = unnamed_2.rainPhase;
        let _e317 = (_e316 == 2u);
        phi_8365_ = _e317;
        if !(_e317) {
            let _e319 = (*pos_10);
            param_386 = _e319;
            let _e320 = cloudTouchesRain_u0028_vi3_u003b((&param_386));
            phi_8365_ = _e320;
        }
        let _e322 = phi_8365_;
        newKind_1 = select(1u, 2u, _e322);
        let _e324 = (*currentIndex_6);
        let _e327 = newKind_1;
        param_387 = _e327;
        param_388 = false;
        param_389 = 0u;
        param_390 = 0u;
        let _e328 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_387), (&param_388), (&param_389), (&param_390));
        let _e329 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e324]), 0u, _e328);
        let _e331 = (*currentIndex_6);
        let _e334 = atomicExchange((&unnamed.grid[_e331]), 0u);
        return;
    }
    let _e335 = (*randVal_7);
    let _e339 = tuning.steamScatterChance;
    if (fract((_e335 * 88f)) < _e339) {
        let _e341 = (*randVal_7);
        d_9 = i32((fract((_e341 * 13f)) * 6f));
        let _e346 = (*pos_10);
        let _e347 = d_9;
        param_391 = _e347;
        let _e348 = getOrthoDir_u0028_i1_u003b((&param_391));
        scatterPos = (_e346 + _e348);
        let _e351 = scatterPos[0u];
        let _e352 = (_e351 > 0i);
        phi_8414_ = _e352;
        if _e352 {
            let _e354 = scatterPos[0u];
            let _e356 = tuning.gridWidth;
            phi_8414_ = (_e354 < (bitcast<i32>(_e356) - 1i));
        }
        let _e361 = phi_8414_;
        phi_8420_ = _e361;
        if _e361 {
            let _e363 = scatterPos[1u];
            phi_8420_ = (_e363 > 0i);
        }
        let _e366 = phi_8420_;
        phi_8430_ = _e366;
        if _e366 {
            let _e368 = scatterPos[1u];
            let _e370 = tuning.gridHeight;
            phi_8430_ = (_e368 < (bitcast<i32>(_e370) - 1i));
        }
        let _e375 = phi_8430_;
        phi_8436_ = _e375;
        if _e375 {
            let _e377 = scatterPos[2u];
            phi_8436_ = (_e377 > 0i);
        }
        let _e380 = phi_8436_;
        phi_8446_ = _e380;
        if _e380 {
            let _e382 = scatterPos[2u];
            let _e384 = tuning.gridDepth;
            phi_8446_ = (_e382 < (bitcast<i32>(_e384) - 1i));
        }
        let _e389 = phi_8446_;
        if _e389 {
            let _e390 = scatterPos;
            param_392 = _e390;
            let _e391 = getIndex_u0028_vi3_u003b((&param_392));
            param_393 = _e391;
            let _e392 = readCell_u0028_u1_u003b((&param_393));
            param_394 = _e392;
            let _e393 = getType_u0028_u1_u003b((&param_394));
            sType = _e393;
            let _e394 = sType;
            let _e396 = sType;
            let _e398 = ((_e394 == 0u) || (_e396 == 5u));
            phi_8472_ = _e398;
            if _e398 {
                let _e399 = scatterPos;
                param_395 = _e399;
                let _e400 = getIndex_u0028_vi3_u003b((&param_395));
                let _e403 = atomicLoad((&unnamed_1.cloudCells[_e400]));
                param_396 = _e403;
                let _e404 = getCloudKind_u0028_u1_u003b((&param_396));
                phi_8472_ = (_e404 == 0u);
            }
            let _e407 = phi_8472_;
            if _e407 {
                let _e408 = scatterPos;
                param_397 = _e408;
                let _e409 = getIndex_u0028_vi3_u003b((&param_397));
                param_398 = 6u;
                param_399 = 0u;
                param_400 = 0u;
                let _e410 = newAge;
                param_401 = _e410;
                let _e411 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_398), (&param_399), (&param_400), (&param_401));
                let _e412 = (*currentIndex_6);
                param_402 = _e412;
                let _e413 = (*rawValue_5);
                param_403 = _e413;
                param_404 = _e409;
                param_405 = _e411;
                let _e414 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_402), (&param_403), (&param_404), (&param_405));
                if _e414 {
                    return;
                }
            }
        }
    }
    let _e415 = (*pos_10);
    checkPos[0i] = (_e415 + vec3<i32>(0i, 1i, 0i));
    let _e418 = (*randVal_7);
    dir_1 = select(-1i, 1i, (fract((_e418 * 10f)) > 0.5f));
    let _e423 = (*randVal_7);
    if (fract((_e423 * 100f)) > 0.5f) {
        let _e427 = (*pos_10);
        let _e428 = dir_1;
        checkPos[1i] = (_e427 + vec3<i32>(_e428, 1i, 0i));
        let _e432 = (*pos_10);
        let _e433 = dir_1;
        checkPos[2i] = (_e432 + vec3<i32>(0i, 1i, _e433));
    } else {
        let _e437 = (*pos_10);
        let _e438 = dir_1;
        checkPos[1i] = (_e437 + vec3<i32>(0i, 1i, _e438));
        let _e442 = (*pos_10);
        let _e443 = dir_1;
        checkPos[2i] = (_e442 + vec3<i32>(_e443, 1i, 0i));
    }
    let _e447 = (*pos_10);
    upPos_1 = (_e447 + vec3<i32>(0i, 1i, 0i));
    let _e449 = upPos_1;
    param_406 = _e449;
    let _e450 = cloudCellInBounds_u0028_vi3_u003b((&param_406));
    phi_8549_ = _e450;
    if _e450 {
        let _e451 = upPos_1;
        param_407 = _e451;
        let _e452 = getIndex_u0028_vi3_u003b((&param_407));
        let _e455 = atomicLoad((&unnamed_1.cloudCells[_e452]));
        param_408 = _e455;
        let _e456 = cloudIsAtRest_u0028_u1_u003b((&param_408));
        phi_8549_ = _e456;
    }
    let _e458 = phi_8549_;
    underSettled = _e458;
    let _e459 = (*pos_10);
    param_409 = _e459;
    let _e460 = cloudTouchesRain_u0028_vi3_u003b((&param_409));
    touchingRain = _e460;
    let _e461 = underSettled;
    let _e462 = touchingRain;
    if (_e461 || _e462) {
        let _e464 = touchingRain;
        phi_8567_ = _e464;
        if !(_e464) {
            let _e467 = unnamed_2.rainPhase;
            phi_8567_ = (_e467 == 2u);
        }
        let _e470 = phi_8567_;
        newKind_2 = select(1u, 2u, _e470);
        let _e472 = (*currentIndex_6);
        let _e475 = newKind_2;
        param_410 = _e475;
        param_411 = false;
        param_412 = 0u;
        param_413 = 0u;
        let _e476 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_410), (&param_411), (&param_412), (&param_413));
        let _e477 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e472]), 0u, _e476);
        if (_e477.old_value == 0u) {
            let _e480 = (*currentIndex_6);
            let _e483 = atomicExchange((&unnamed.grid[_e480]), 0u);
        }
        return;
    }
    i_11 = 0i;
    loop {
        let _e484 = i_11;
        if (_e484 < 3i) {
            let _e486 = i_11;
            let _e488 = checkPos[_e486];
            cPos = _e488;
            let _e490 = cPos[0u];
            let _e491 = (_e490 > 0i);
            phi_8609_ = _e491;
            if _e491 {
                let _e493 = cPos[0u];
                let _e495 = tuning.gridWidth;
                phi_8609_ = (_e493 < (bitcast<i32>(_e495) - 1i));
            }
            let _e500 = phi_8609_;
            phi_8615_ = _e500;
            if _e500 {
                let _e502 = cPos[2u];
                phi_8615_ = (_e502 > 0i);
            }
            let _e505 = phi_8615_;
            phi_8625_ = _e505;
            if _e505 {
                let _e507 = cPos[2u];
                let _e509 = tuning.gridDepth;
                phi_8625_ = (_e507 < (bitcast<i32>(_e509) - 1i));
            }
            let _e514 = phi_8625_;
            if _e514 {
                let _e515 = cPos;
                param_414 = _e515;
                let _e516 = getIndex_u0028_vi3_u003b((&param_414));
                cIndex = _e516;
                let _e517 = cIndex;
                param_415 = _e517;
                let _e518 = readCell_u0028_u1_u003b((&param_415));
                cVal = _e518;
                let _e519 = cVal;
                param_416 = _e519;
                let _e520 = getType_u0028_u1_u003b((&param_416));
                cType = _e520;
                let _e521 = cType;
                let _e523 = cType;
                if ((_e521 == 1u) || (_e523 == 4u)) {
                    let _e526 = cVal;
                    param_417 = _e526;
                    let _e527 = getAge_u0028_u1_u003b((&param_417));
                    moisture_2 = _e527;
                    let _e528 = cType;
                    if (_e528 == 4u) {
                        let _e531 = tuning.dirtMoistureCapacity;
                        local_15 = _e531;
                    } else {
                        let _e533 = tuning.sandMoistureCapacity;
                        local_15 = _e533;
                    }
                    let _e534 = local_15;
                    capacity = _e534;
                    let _e535 = moisture_2;
                    let _e536 = capacity;
                    if (_e535 < _e536) {
                        let _e538 = (*currentIndex_6);
                        let _e541 = (*rawValue_5);
                        let _e542 = atomicCompareExchangeWeak((&unnamed.grid[_e538]), _e541, 0u);
                        let _e544 = (*rawValue_5);
                        if (_e542.old_value == _e544) {
                            let _e546 = cIndex;
                            let _e549 = atomicAdd((&unnamed.grid[_e546]), 16777216u);
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
            let _e550 = i_11;
            i_11 = (_e550 + 1i);
        }
    }
    i_12 = 0i;
    loop {
        let _e552 = i_12;
        if (_e552 < 3i) {
            let _e554 = i_12;
            let _e556 = checkPos[_e554];
            sPos_1 = _e556;
            let _e558 = sPos_1[1u];
            let _e560 = tuning.gridHeight;
            let _e563 = (_e558 < (bitcast<i32>(_e560) - 1i));
            phi_8706_ = _e563;
            if _e563 {
                let _e565 = sPos_1[0u];
                phi_8706_ = (_e565 > 0i);
            }
            let _e568 = phi_8706_;
            phi_8716_ = _e568;
            if _e568 {
                let _e570 = sPos_1[0u];
                let _e572 = tuning.gridWidth;
                phi_8716_ = (_e570 < (bitcast<i32>(_e572) - 1i));
            }
            let _e577 = phi_8716_;
            phi_8722_ = _e577;
            if _e577 {
                let _e579 = sPos_1[2u];
                phi_8722_ = (_e579 > 0i);
            }
            let _e582 = phi_8722_;
            phi_8732_ = _e582;
            if _e582 {
                let _e584 = sPos_1[2u];
                let _e586 = tuning.gridDepth;
                phi_8732_ = (_e584 < (bitcast<i32>(_e586) - 1i));
            }
            let _e591 = phi_8732_;
            if _e591 {
                let _e592 = sPos_1;
                param_418 = _e592;
                let _e593 = getIndex_u0028_vi3_u003b((&param_418));
                param_419 = _e593;
                let _e594 = readCell_u0028_u1_u003b((&param_419));
                param_420 = _e594;
                let _e595 = getType_u0028_u1_u003b((&param_420));
                sType_1 = _e595;
                let _e596 = sType_1;
                let _e598 = sType_1;
                let _e600 = ((_e596 == 0u) || (_e598 == 5u));
                phi_8758_ = _e600;
                if _e600 {
                    let _e601 = sPos_1;
                    param_421 = _e601;
                    let _e602 = getIndex_u0028_vi3_u003b((&param_421));
                    let _e605 = atomicLoad((&unnamed_1.cloudCells[_e602]));
                    param_422 = _e605;
                    let _e606 = getCloudKind_u0028_u1_u003b((&param_422));
                    phi_8758_ = (_e606 == 0u);
                }
                let _e609 = phi_8758_;
                if _e609 {
                    let _e610 = sPos_1;
                    param_423 = _e610;
                    let _e611 = getIndex_u0028_vi3_u003b((&param_423));
                    param_424 = 6u;
                    param_425 = 0u;
                    param_426 = 0u;
                    let _e612 = newAge;
                    param_427 = _e612;
                    let _e613 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_424), (&param_425), (&param_426), (&param_427));
                    let _e614 = (*currentIndex_6);
                    param_428 = _e614;
                    let _e615 = (*rawValue_5);
                    param_429 = _e615;
                    param_430 = _e611;
                    param_431 = _e613;
                    let _e616 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_428), (&param_429), (&param_430), (&param_431));
                    if _e616 {
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e617 = i_12;
            i_12 = (_e617 + 1i);
        }
    }
    let _e619 = (*currentSleep_2);
    newSleep_1 = min((_e619 + 1u), 255u);
    let _e622 = (*currentIndex_6);
    let _e625 = (*rawValue_5);
    param_432 = 6u;
    param_433 = 0u;
    let _e626 = newSleep_1;
    param_434 = _e626;
    let _e627 = newAge;
    param_435 = _e627;
    let _e628 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_432), (&param_433), (&param_434), (&param_435));
    let _e629 = atomicCompareExchangeWeak((&unnamed.grid[_e622]), _e625, _e628);
    return;
}

fn updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_11: ptr<function, vec3<i32>>, currentIndex_7: ptr<function, u32>, rawValue_6: ptr<function, u32>, currentDir_3: ptr<function, u32>, currentSleep_3: ptr<function, u32>, currentAge_6: ptr<function, u32>, randVal_8: ptr<function, f32>) {
    var newAge_1: u32;
    var isBurningGrass: bool;
    var i_13: i32;
    var nPos_1: vec3<i32>;
    var param_436: i32;
    var nIndex_1: u32;
    var param_437: vec3<i32>;
    var nVal_1: u32;
    var param_438: u32;
    var param_439: u32;
    var param_440: u32;
    var param_441: u32;
    var param_442: u32;
    var param_443: u32;
    var burnRoll: f32;
    var start_6: i32;
    var i_14: i32;
    var nPos_2: vec3<i32>;
    var param_444: i32;
    var param_445: vec3<i32>;
    var nIndex_2: u32;
    var param_446: vec3<i32>;
    var nVal_2: u32;
    var param_447: u32;
    var nType_1: u32;
    var param_448: u32;
    var need_1: f32;
    var local_16: f32;
    var param_449: u32;
    var param_450: u32;
    var param_451: u32;
    var param_452: u32;
    var belowPos_4: vec3<i32>;
    var belowIndex_1: u32;
    var param_453: vec3<i32>;
    var belowValue_1: u32;
    var param_454: u32;
    var belowType: u32;
    var param_455: u32;
    var param_456: u32;
    var param_457: u32;
    var param_458: u32;
    var param_459: u32;
    var param_460: u32;
    var param_461: u32;
    var param_462: u32;
    var param_463: u32;
    var moisture_3: u32;
    var param_464: u32;
    var newMoisture: u32;
    var local_17: u32;
    var newVal: u32;
    var param_465: u32;
    var param_466: u32;
    var param_467: u32;
    var param_468: u32;
    var param_469: u32;
    var flora_3: u32;
    var newFlora: u32;
    var newVal_1: u32;
    var param_470: u32;
    var param_471: u32;
    var param_472: u32;
    var param_473: u32;
    var param_474: u32;
    var d_10: i32;
    var targetPos_1: vec3<i32>;
    var param_475: i32;
    var targetIndex_1: u32;
    var param_476: vec3<i32>;
    var param_477: u32;
    var param_478: u32;
    var targetBelow: vec3<i32>;
    var tBelowVal: u32;
    var param_479: vec3<i32>;
    var param_480: u32;
    var param_481: u32;
    var tFlora: u32;
    var param_482: u32;
    var param_483: u32;
    var param_484: u32;
    var param_485: u32;
    var param_486: u32;
    var param_487: u32;
    var param_488: u32;
    var param_489: u32;
    var phi_7671_: bool;
    var phi_7677_: bool;
    var phi_7687_: bool;
    var phi_7693_: bool;
    var phi_7703_: bool;
    var phi_8011_: bool;
    var phi_8017_: bool;
    var phi_8027_: bool;

    let _e290 = (*currentAge_6);
    newAge_1 = (_e290 + 1u);
    isBurningGrass = false;
    i_13 = 0i;
    loop {
        let _e292 = i_13;
        if (_e292 < 6i) {
            let _e294 = (*pos_11);
            let _e295 = i_13;
            param_436 = _e295;
            let _e296 = getOrthoDir_u0028_i1_u003b((&param_436));
            nPos_1 = (_e294 + _e296);
            let _e299 = nPos_1[0u];
            let _e300 = (_e299 > 0i);
            phi_7671_ = _e300;
            if _e300 {
                let _e302 = nPos_1[0u];
                let _e304 = tuning.gridWidth;
                phi_7671_ = (_e302 < (bitcast<i32>(_e304) - 1i));
            }
            let _e309 = phi_7671_;
            phi_7677_ = _e309;
            if _e309 {
                let _e311 = nPos_1[1u];
                phi_7677_ = (_e311 > 0i);
            }
            let _e314 = phi_7677_;
            phi_7687_ = _e314;
            if _e314 {
                let _e316 = nPos_1[1u];
                let _e318 = tuning.gridHeight;
                phi_7687_ = (_e316 < (bitcast<i32>(_e318) - 1i));
            }
            let _e323 = phi_7687_;
            phi_7693_ = _e323;
            if _e323 {
                let _e325 = nPos_1[2u];
                phi_7693_ = (_e325 > 0i);
            }
            let _e328 = phi_7693_;
            phi_7703_ = _e328;
            if _e328 {
                let _e330 = nPos_1[2u];
                let _e332 = tuning.gridDepth;
                phi_7703_ = (_e330 < (bitcast<i32>(_e332) - 1i));
            }
            let _e337 = phi_7703_;
            if _e337 {
                let _e338 = nPos_1;
                param_437 = _e338;
                let _e339 = getIndex_u0028_vi3_u003b((&param_437));
                nIndex_1 = _e339;
                let _e340 = nIndex_1;
                param_438 = _e340;
                let _e341 = readCell_u0028_u1_u003b((&param_438));
                nVal_1 = _e341;
                let _e342 = nVal_1;
                param_439 = _e342;
                let _e343 = getType_u0028_u1_u003b((&param_439));
                if (_e343 == 2u) {
                    let _e345 = nIndex_1;
                    let _e348 = nVal_1;
                    param_440 = 6u;
                    param_441 = 0u;
                    param_442 = 0u;
                    param_443 = 0u;
                    let _e349 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_440), (&param_441), (&param_442), (&param_443));
                    let _e350 = atomicCompareExchangeWeak((&unnamed.grid[_e345]), _e348, _e349);
                    let _e352 = nVal_1;
                    if (_e350.old_value == _e352) {
                        decWater_u0028_();
                        let _e354 = (*currentIndex_7);
                        let _e357 = atomicExchange((&unnamed.grid[_e354]), 0u);
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e358 = i_13;
            i_13 = (_e358 + 1i);
        }
    }
    let _e360 = (*randVal_8);
    burnRoll = fract((_e360 * 47f));
    let _e363 = burnRoll;
    let _e365 = tuning.treeLeafBurnChance;
    let _e367 = tuning.treeTrunkBurnChance;
    if (_e363 < max(_e365, _e367)) {
        let _e370 = (*randVal_8);
        start_6 = i32((fract((_e370 * 31f)) * 26f));
        i_14 = 0i;
        loop {
            let _e375 = i_14;
            if (_e375 < 26i) {
                let _e377 = (*pos_11);
                let _e378 = start_6;
                let _e379 = i_14;
                let _e380 = (_e378 + _e379);
                param_444 = (_e380 - (i32(floor((f32(_e380) / f32(26i)))) * 26i));
                let _e388 = tree26_u0028_i1_u003b((&param_444));
                nPos_2 = (_e377 + _e388);
                let _e390 = nPos_2;
                param_445 = _e390;
                let _e391 = treeInBounds_u0028_vi3_u003b((&param_445));
                if !(_e391) {
                    continue;
                }
                let _e393 = nPos_2;
                param_446 = _e393;
                let _e394 = getIndex_u0028_vi3_u003b((&param_446));
                nIndex_2 = _e394;
                let _e395 = nIndex_2;
                param_447 = _e395;
                let _e396 = readCell_u0028_u1_u003b((&param_447));
                nVal_2 = _e396;
                let _e397 = nVal_2;
                param_448 = _e397;
                let _e398 = getType_u0028_u1_u003b((&param_448));
                nType_1 = _e398;
                let _e399 = nType_1;
                let _e401 = nType_1;
                if ((_e399 != 19u) && (_e401 != 18u)) {
                    continue;
                }
                let _e404 = nType_1;
                if (_e404 == 19u) {
                    let _e407 = tuning.treeLeafBurnChance;
                    local_16 = _e407;
                } else {
                    let _e409 = tuning.treeTrunkBurnChance;
                    local_16 = _e409;
                }
                let _e410 = local_16;
                need_1 = _e410;
                let _e411 = burnRoll;
                let _e412 = need_1;
                if (_e411 < _e412) {
                    let _e414 = nIndex_2;
                    let _e417 = nVal_2;
                    param_449 = 5u;
                    param_450 = 0u;
                    param_451 = 0u;
                    param_452 = 0u;
                    let _e418 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_449), (&param_450), (&param_451), (&param_452));
                    let _e419 = atomicCompareExchangeWeak((&unnamed.grid[_e414]), _e417, _e418);
                }
                break;
            } else {
                break;
            }
            continuing {
                let _e421 = i_14;
                i_14 = (_e421 + 1i);
            }
        }
    }
    let _e424 = (*pos_11)[1u];
    if (_e424 > 1i) {
        let _e426 = (*pos_11);
        belowPos_4 = (_e426 + vec3<i32>(0i, -1i, 0i));
        let _e428 = belowPos_4;
        param_453 = _e428;
        let _e429 = getIndex_u0028_vi3_u003b((&param_453));
        belowIndex_1 = _e429;
        let _e430 = belowIndex_1;
        param_454 = _e430;
        let _e431 = readCell_u0028_u1_u003b((&param_454));
        belowValue_1 = _e431;
        let _e432 = belowValue_1;
        param_455 = _e432;
        let _e433 = getType_u0028_u1_u003b((&param_455));
        belowType = _e433;
        let _e434 = belowType;
        if (_e434 == 0u) {
            param_456 = 5u;
            param_457 = 0u;
            param_458 = 0u;
            let _e436 = newAge_1;
            param_459 = _e436;
            let _e437 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_456), (&param_457), (&param_458), (&param_459));
            let _e438 = (*currentIndex_7);
            param_460 = _e438;
            let _e439 = (*rawValue_6);
            param_461 = _e439;
            let _e440 = belowIndex_1;
            param_462 = _e440;
            param_463 = _e437;
            let _e441 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_460), (&param_461), (&param_462), (&param_463));
            if _e441 {
                return;
            }
        } else {
            let _e442 = belowType;
            if (_e442 == 2u) {
                let _e444 = (*currentIndex_7);
                let _e447 = atomicExchange((&unnamed.grid[_e444]), 0u);
                return;
            } else {
                let _e448 = belowType;
                if (_e448 == 1u) {
                    let _e450 = belowValue_1;
                    param_464 = _e450;
                    let _e451 = getAge_u0028_u1_u003b((&param_464));
                    moisture_3 = _e451;
                    let _e452 = moisture_3;
                    if (_e452 > 0u) {
                        let _e454 = moisture_3;
                        let _e456 = tuning.fireDryRate;
                        if (_e454 > _e456) {
                            let _e458 = moisture_3;
                            let _e460 = tuning.fireDryRate;
                            local_17 = (_e458 - _e460);
                        } else {
                            local_17 = 0u;
                        }
                        let _e462 = local_17;
                        newMoisture = _e462;
                        let _e463 = belowValue_1;
                        param_465 = _e463;
                        let _e464 = getDir_u0028_u1_u003b((&param_465));
                        param_466 = 1u;
                        param_467 = _e464;
                        param_468 = 0u;
                        let _e465 = newMoisture;
                        param_469 = _e465;
                        let _e466 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_466), (&param_467), (&param_468), (&param_469));
                        newVal = _e466;
                        let _e467 = belowIndex_1;
                        let _e470 = belowValue_1;
                        let _e471 = newVal;
                        let _e472 = atomicCompareExchangeWeak((&unnamed.grid[_e467]), _e470, _e471);
                        let _e474 = belowValue_1;
                        if (_e472.old_value == _e474) {
                            let _e476 = (*currentIndex_7);
                            let _e479 = atomicExchange((&unnamed.grid[_e476]), 0u);
                            return;
                        }
                    }
                } else {
                    let _e480 = belowType;
                    if (_e480 == 4u) {
                        let _e482 = belowValue_1;
                        flora_3 = ((_e482 >> bitcast<u32>(8i)) & 255u);
                        let _e486 = flora_3;
                        let _e488 = flora_3;
                        if ((_e486 > 10u) && (_e488 <= 100u)) {
                            isBurningGrass = true;
                            newAge_1 = 0u;
                            let _e491 = (*randVal_8);
                            let _e495 = tuning.fireBurnGrassChance;
                            if (fract((_e491 * 100f)) < _e495) {
                                let _e497 = flora_3;
                                newFlora = (_e497 - 1u);
                                let _e499 = belowValue_1;
                                param_470 = _e499;
                                let _e500 = getAge_u0028_u1_u003b((&param_470));
                                param_471 = 4u;
                                let _e501 = newFlora;
                                param_472 = _e501;
                                param_473 = 0u;
                                param_474 = _e500;
                                let _e502 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_471), (&param_472), (&param_473), (&param_474));
                                newVal_1 = _e502;
                                let _e503 = belowIndex_1;
                                let _e506 = belowValue_1;
                                let _e507 = newVal_1;
                                let _e508 = atomicCompareExchangeWeak((&unnamed.grid[_e503]), _e506, _e507);
                            }
                            let _e510 = (*randVal_8);
                            let _e514 = tuning.fireSpreadChance;
                            if (fract((_e510 * 100f)) < _e514) {
                                let _e516 = (*randVal_8);
                                d_10 = i32((fract((_e516 * 10f)) * 8f));
                                let _e521 = (*pos_11);
                                let _e522 = d_10;
                                param_475 = _e522;
                                let _e523 = getHDir_u0028_i1_u003b((&param_475));
                                targetPos_1 = (_e521 + _e523);
                                let _e526 = targetPos_1[0u];
                                let _e527 = (_e526 > 0i);
                                phi_8011_ = _e527;
                                if _e527 {
                                    let _e529 = targetPos_1[0u];
                                    let _e531 = tuning.gridWidth;
                                    phi_8011_ = (_e529 < (bitcast<i32>(_e531) - 1i));
                                }
                                let _e536 = phi_8011_;
                                phi_8017_ = _e536;
                                if _e536 {
                                    let _e538 = targetPos_1[2u];
                                    phi_8017_ = (_e538 > 0i);
                                }
                                let _e541 = phi_8017_;
                                phi_8027_ = _e541;
                                if _e541 {
                                    let _e543 = targetPos_1[2u];
                                    let _e545 = tuning.gridDepth;
                                    phi_8027_ = (_e543 < (bitcast<i32>(_e545) - 1i));
                                }
                                let _e550 = phi_8027_;
                                if _e550 {
                                    let _e551 = targetPos_1;
                                    param_476 = _e551;
                                    let _e552 = getIndex_u0028_vi3_u003b((&param_476));
                                    targetIndex_1 = _e552;
                                    let _e553 = targetIndex_1;
                                    param_477 = _e553;
                                    let _e554 = readCell_u0028_u1_u003b((&param_477));
                                    param_478 = _e554;
                                    let _e555 = getType_u0028_u1_u003b((&param_478));
                                    if (_e555 == 0u) {
                                        let _e557 = targetPos_1;
                                        targetBelow = (_e557 + vec3<i32>(0i, -1i, 0i));
                                        let _e559 = targetBelow;
                                        param_479 = _e559;
                                        let _e560 = getIndex_u0028_vi3_u003b((&param_479));
                                        param_480 = _e560;
                                        let _e561 = readCell_u0028_u1_u003b((&param_480));
                                        tBelowVal = _e561;
                                        let _e562 = tBelowVal;
                                        param_481 = _e562;
                                        let _e563 = getType_u0028_u1_u003b((&param_481));
                                        if (_e563 == 4u) {
                                            let _e565 = tBelowVal;
                                            tFlora = ((_e565 >> bitcast<u32>(8i)) & 255u);
                                            let _e569 = tFlora;
                                            let _e571 = tFlora;
                                            if ((_e569 > 10u) && (_e571 <= 100u)) {
                                                let _e574 = targetIndex_1;
                                                param_482 = 5u;
                                                param_483 = 0u;
                                                param_484 = 0u;
                                                param_485 = 0u;
                                                let _e577 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_482), (&param_483), (&param_484), (&param_485));
                                                let _e578 = atomicCompareExchangeWeak((&unnamed.grid[_e574]), 0u, _e577);
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
    let _e580 = newAge_1;
    let _e582 = tuning.fireLifetime;
    if (_e580 > _e582) {
        let _e584 = (*currentIndex_7);
        let _e587 = atomicExchange((&unnamed.grid[_e584]), 0u);
        return;
    }
    let _e588 = (*currentIndex_7);
    let _e591 = (*rawValue_6);
    param_486 = 5u;
    param_487 = 0u;
    param_488 = 0u;
    let _e592 = newAge_1;
    param_489 = _e592;
    let _e593 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_486), (&param_487), (&param_488), (&param_489));
    let _e594 = atomicCompareExchangeWeak((&unnamed.grid[_e588]), _e591, _e593);
    return;
}

fn isLocust_u0028_u1_u003b(type_36: ptr<function, u32>) -> bool {
    let _e198 = (*type_36);
    let _e200 = (*type_36);
    return ((_e198 >= 13u) && (_e200 <= 17u));
}

fn tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex_8: ptr<function, u32>, currentValue_1: ptr<function, u32>, targetIndex_2: ptr<function, u32>, targetValue_1: ptr<function, u32>, pushIndex: ptr<function, u32>) -> bool {
    var displacedValue: u32;
    var param_490: u32;
    var param_491: u32;
    var param_492: u32;
    var param_493: u32;
    var param_494: u32;
    var actualPush: u32;
    var actualTarget: u32;

    let _e210 = (*currentIndex_8);
    let _e213 = (*currentValue_1);
    let _e214 = atomicCompareExchangeWeak((&unnamed.grid[_e210]), _e213, 0u);
    let _e216 = (*currentValue_1);
    if (_e214.old_value == _e216) {
        let _e218 = (*targetValue_1);
        param_490 = _e218;
        let _e219 = getType_u0028_u1_u003b((&param_490));
        param_491 = _e219;
        param_492 = 0u;
        param_493 = 0u;
        param_494 = 0u;
        let _e220 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_491), (&param_492), (&param_493), (&param_494));
        displacedValue = _e220;
        let _e221 = (*pushIndex);
        let _e224 = displacedValue;
        let _e225 = atomicCompareExchangeWeak((&unnamed.grid[_e221]), 0u, _e224);
        actualPush = _e225.old_value;
        let _e227 = actualPush;
        if (_e227 == 0u) {
            let _e229 = (*targetIndex_2);
            let _e232 = (*targetValue_1);
            let _e233 = (*currentValue_1);
            let _e234 = atomicCompareExchangeWeak((&unnamed.grid[_e229]), _e232, _e233);
            actualTarget = _e234.old_value;
            let _e236 = actualTarget;
            let _e237 = (*targetValue_1);
            if (_e236 == _e237) {
                return true;
            } else {
                let _e239 = (*pushIndex);
                let _e242 = displacedValue;
                let _e243 = atomicCompareExchangeWeak((&unnamed.grid[_e239]), _e242, 0u);
            }
        }
        let _e245 = (*currentIndex_8);
        let _e248 = (*currentValue_1);
        let _e249 = atomicCompareExchangeWeak((&unnamed.grid[_e245]), 0u, _e248);
    }
    return false;
}

fn grainCanMove_u0028_vi3_u003b(pos_12: ptr<function, vec3<i32>>) -> bool {
    var i_15: i32;
    var target_2: vec3<i32>;
    var local_18: i32;
    var local_19: i32;
    var t_3: u32;
    var param_495: vec3<i32>;
    var param_496: u32;
    var param_497: u32;
    var phi_2343_: bool;
    var phi_2350_: bool;
    var phi_2361_: bool;

    let _e207 = (*pos_12)[1u];
    if (_e207 <= 1i) {
        return false;
    }
    i_15 = 0i;
    loop {
        let _e209 = i_15;
        if (_e209 < 5i) {
            let _e211 = (*pos_12);
            let _e212 = i_15;
            if (_e212 == 1i) {
                local_18 = 1i;
            } else {
                let _e214 = i_15;
                local_18 = select(0i, -1i, (_e214 == 2i));
            }
            let _e217 = local_18;
            let _e218 = i_15;
            if (_e218 == 3i) {
                local_19 = 1i;
            } else {
                let _e220 = i_15;
                local_19 = select(0i, -1i, (_e220 == 4i));
            }
            let _e223 = local_19;
            target_2 = (_e211 + vec3<i32>(_e217, -1i, _e223));
            let _e227 = target_2[0u];
            let _e228 = (_e227 <= 0i);
            phi_2343_ = _e228;
            if !(_e228) {
                let _e231 = target_2[0u];
                let _e233 = tuning.gridWidth;
                phi_2343_ = (_e231 >= (bitcast<i32>(_e233) - 1i));
            }
            let _e238 = phi_2343_;
            phi_2350_ = _e238;
            if !(_e238) {
                let _e241 = target_2[2u];
                phi_2350_ = (_e241 <= 0i);
            }
            let _e244 = phi_2350_;
            phi_2361_ = _e244;
            if !(_e244) {
                let _e247 = target_2[2u];
                let _e249 = tuning.gridDepth;
                phi_2361_ = (_e247 >= (bitcast<i32>(_e249) - 1i));
            }
            let _e254 = phi_2361_;
            if _e254 {
                continue;
            }
            let _e255 = target_2;
            param_495 = _e255;
            let _e256 = getIndex_u0028_vi3_u003b((&param_495));
            param_496 = _e256;
            let _e257 = readCell_u0028_u1_u003b((&param_496));
            param_497 = _e257;
            let _e258 = getType_u0028_u1_u003b((&param_497));
            t_3 = _e258;
            let _e259 = t_3;
            let _e261 = t_3;
            if ((_e259 == 0u) || (_e261 == 2u)) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e264 = i_15;
            i_15 = (_e264 + 1i);
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
    var param_498: i32;
    var nIndex_3: u32;
    var param_499: vec3<i32>;
    var nVal_3: u32;
    var param_500: u32;
    var param_501: u32;
    var d_12: i32;
    var nPos_4: vec3<i32>;
    var param_502: i32;
    var nIndex_4: u32;
    var param_503: vec3<i32>;
    var nVal_4: u32;
    var param_504: u32;
    var nType_2: u32;
    var param_505: u32;
    var nMoisture: u32;
    var param_506: u32;
    var nCapacity: u32;
    var local_20: u32;
    var canMove: bool;
    var param_507: vec3<i32>;
    var isClumped: bool;
    var emptyBelowCount: i32;
    var x: i32;
    var z: i32;
    var checkPos_1: vec3<i32>;
    var param_508: vec3<i32>;
    var param_509: u32;
    var param_510: u32;
    var clumpCount: i32;
    var x_1: i32;
    var y: i32;
    var z_1: i32;
    var nPos_5: vec3<i32>;
    var param_511: vec3<i32>;
    var param_512: u32;
    var param_513: u32;
    var belowPos_5: vec3<i32>;
    var param_514: vec3<i32>;
    var param_515: u32;
    var param_516: u32;
    var param_517: vec3<i32>;
    var param_518: u32;
    var param_519: u32;
    var param_520: u32;
    var param_521: u32;
    var param_522: u32;
    var param_523: u32;
    var param_524: u32;
    var param_525: u32;
    var dir_2: i32;
    var slidePos1_: vec3<i32>;
    var slidePos2_: vec3<i32>;
    var param_526: vec3<i32>;
    var param_527: u32;
    var param_528: u32;
    var param_529: vec3<i32>;
    var param_530: u32;
    var param_531: u32;
    var param_532: u32;
    var param_533: u32;
    var param_534: u32;
    var param_535: u32;
    var param_536: u32;
    var param_537: u32;
    var param_538: vec3<i32>;
    var param_539: u32;
    var param_540: u32;
    var param_541: vec3<i32>;
    var param_542: u32;
    var param_543: u32;
    var param_544: u32;
    var param_545: u32;
    var param_546: u32;
    var param_547: u32;
    var param_548: u32;
    var param_549: u32;
    var belowPos_6: vec3<i32>;
    var belowIndex_2: u32;
    var param_550: vec3<i32>;
    var belowValue_2: u32;
    var param_551: u32;
    var param_552: u32;
    var startDir_2: i32;
    var i_17: i32;
    var d_13: i32;
    var pushPos: vec3<i32>;
    var param_553: i32;
    var param_554: u32;
    var param_555: u32;
    var param_556: u32;
    var param_557: u32;
    var param_558: vec3<i32>;
    var param_559: u32;
    var param_560: u32;
    var param_561: u32;
    var param_562: u32;
    var param_563: u32;
    var param_564: u32;
    var param_565: u32;
    var param_566: u32;
    var param_567: u32;
    var param_568: u32;
    var param_569: u32;
    var param_570: u32;
    var param_571: u32;
    var dir_3: i32;
    var slidePos: array<vec3<i32>, 2>;
    var s_1: i32;
    var sPos_2: vec3<i32>;
    var sIndex: u32;
    var param_572: vec3<i32>;
    var sValue: u32;
    var param_573: u32;
    var param_574: u32;
    var startDir_3: i32;
    var i_18: i32;
    var d_14: i32;
    var pushPos_1: vec3<i32>;
    var param_575: i32;
    var param_576: u32;
    var param_577: u32;
    var param_578: u32;
    var param_579: u32;
    var param_580: vec3<i32>;
    var param_581: u32;
    var param_582: u32;
    var param_583: u32;
    var param_584: u32;
    var param_585: u32;
    var param_586: u32;
    var param_587: u32;
    var param_588: u32;
    var param_589: u32;
    var param_590: u32;
    var param_591: u32;
    var param_592: u32;
    var param_593: u32;
    var floraState: u32;
    var abovePos_1: vec3<i32>;
    var aboveInside: bool;
    var aboveIndex: u32;
    var param_594: vec3<i32>;
    var aboveType: u32;
    var local_21: u32;
    var param_595: u32;
    var param_596: u32;
    var param_597: u32;
    var param_598: u32;
    var param_599: u32;
    var param_600: u32;
    var param_601: u32;
    var newSleep_2: u32;
    var param_602: u32;
    var param_603: u32;
    var param_604: u32;
    var param_605: u32;
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

    let _e367 = (*currentAge_7);
    moisture_4 = _e367;
    moistureModified = false;
    let _e368 = moisture_4;
    let _e370 = tuning.dirtMoistureCapacity;
    if (_e368 < _e370) {
        let _e372 = (*randVal_9);
        startDir_1 = i32((fract((_e372 * 17f)) * 6f));
        i_16 = 0i;
        loop {
            let _e377 = i_16;
            if (_e377 < 6i) {
                let _e379 = startDir_1;
                let _e380 = i_16;
                let _e381 = (_e379 + _e380);
                d_11 = (_e381 - (i32(floor((f32(_e381) / f32(6i)))) * 6i));
                let _e389 = (*pos_13);
                let _e390 = d_11;
                param_498 = _e390;
                let _e391 = getOrthoDir_u0028_i1_u003b((&param_498));
                nPos_3 = (_e389 + _e391);
                let _e394 = nPos_3[0u];
                let _e395 = (_e394 > 0i);
                phi_3475_ = _e395;
                if _e395 {
                    let _e397 = nPos_3[0u];
                    let _e399 = tuning.gridWidth;
                    phi_3475_ = (_e397 < (bitcast<i32>(_e399) - 1i));
                }
                let _e404 = phi_3475_;
                phi_3481_ = _e404;
                if _e404 {
                    let _e406 = nPos_3[1u];
                    phi_3481_ = (_e406 > 0i);
                }
                let _e409 = phi_3481_;
                phi_3491_ = _e409;
                if _e409 {
                    let _e411 = nPos_3[1u];
                    let _e413 = tuning.gridHeight;
                    phi_3491_ = (_e411 < (bitcast<i32>(_e413) - 1i));
                }
                let _e418 = phi_3491_;
                phi_3497_ = _e418;
                if _e418 {
                    let _e420 = nPos_3[2u];
                    phi_3497_ = (_e420 > 0i);
                }
                let _e423 = phi_3497_;
                phi_3507_ = _e423;
                if _e423 {
                    let _e425 = nPos_3[2u];
                    let _e427 = tuning.gridDepth;
                    phi_3507_ = (_e425 < (bitcast<i32>(_e427) - 1i));
                }
                let _e432 = phi_3507_;
                if _e432 {
                    let _e433 = nPos_3;
                    param_499 = _e433;
                    let _e434 = getIndex_u0028_vi3_u003b((&param_499));
                    nIndex_3 = _e434;
                    let _e435 = nIndex_3;
                    param_500 = _e435;
                    let _e436 = readCell_u0028_u1_u003b((&param_500));
                    nVal_3 = _e436;
                    let _e437 = nVal_3;
                    param_501 = _e437;
                    let _e438 = getType_u0028_u1_u003b((&param_501));
                    if (_e438 == 2u) {
                        let _e440 = nIndex_3;
                        let _e443 = nVal_3;
                        let _e444 = atomicCompareExchangeWeak((&unnamed.grid[_e440]), _e443, 0u);
                        let _e446 = nVal_3;
                        if (_e444.old_value == _e446) {
                            let _e448 = (*currentIndex_9);
                            let _e452 = tuning.sandWaterAbsorbUnit;
                            let _e455 = atomicAdd((&unnamed.grid[_e448]), (_e452 << bitcast<u32>(24i)));
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
                let _e456 = i_16;
                i_16 = (_e456 + 1i);
            }
        }
    }
    let _e458 = moistureModified;
    let _e460 = moisture_4;
    if (!(_e458) && (_e460 > 0u)) {
        let _e463 = (*randVal_9);
        d_12 = i32((fract((_e463 * 31f)) * 6f));
        let _e468 = (*pos_13);
        let _e469 = d_12;
        param_502 = _e469;
        let _e470 = getOrthoDir_u0028_i1_u003b((&param_502));
        nPos_4 = (_e468 + _e470);
        let _e473 = nPos_4[0u];
        let _e474 = (_e473 > 0i);
        phi_3573_ = _e474;
        if _e474 {
            let _e476 = nPos_4[0u];
            let _e478 = tuning.gridWidth;
            phi_3573_ = (_e476 < (bitcast<i32>(_e478) - 1i));
        }
        let _e483 = phi_3573_;
        phi_3579_ = _e483;
        if _e483 {
            let _e485 = nPos_4[1u];
            phi_3579_ = (_e485 > 0i);
        }
        let _e488 = phi_3579_;
        phi_3589_ = _e488;
        if _e488 {
            let _e490 = nPos_4[1u];
            let _e492 = tuning.gridHeight;
            phi_3589_ = (_e490 < (bitcast<i32>(_e492) - 1i));
        }
        let _e497 = phi_3589_;
        phi_3595_ = _e497;
        if _e497 {
            let _e499 = nPos_4[2u];
            phi_3595_ = (_e499 > 0i);
        }
        let _e502 = phi_3595_;
        phi_3605_ = _e502;
        if _e502 {
            let _e504 = nPos_4[2u];
            let _e506 = tuning.gridDepth;
            phi_3605_ = (_e504 < (bitcast<i32>(_e506) - 1i));
        }
        let _e511 = phi_3605_;
        if _e511 {
            let _e512 = nPos_4;
            param_503 = _e512;
            let _e513 = getIndex_u0028_vi3_u003b((&param_503));
            nIndex_4 = _e513;
            let _e514 = nIndex_4;
            param_504 = _e514;
            let _e515 = readCell_u0028_u1_u003b((&param_504));
            nVal_4 = _e515;
            let _e516 = nVal_4;
            param_505 = _e516;
            let _e517 = getType_u0028_u1_u003b((&param_505));
            nType_2 = _e517;
            let _e518 = nType_2;
            let _e520 = nType_2;
            if ((_e518 == 4u) || (_e520 == 1u)) {
                let _e523 = nVal_4;
                param_506 = _e523;
                let _e524 = getAge_u0028_u1_u003b((&param_506));
                nMoisture = _e524;
                let _e525 = nType_2;
                if (_e525 == 4u) {
                    let _e528 = tuning.dirtMoistureCapacity;
                    local_20 = _e528;
                } else {
                    let _e530 = tuning.sandMoistureCapacity;
                    local_20 = _e530;
                }
                let _e531 = local_20;
                nCapacity = _e531;
                let _e532 = moisture_4;
                let _e533 = nMoisture;
                let _e536 = nMoisture;
                let _e537 = nCapacity;
                if ((_e532 > (_e533 + 1u)) && (_e536 < _e537)) {
                    let _e540 = (*currentIndex_9);
                    let _e543 = atomicAdd((&unnamed.grid[_e540]), 4278190080u);
                    let _e544 = nIndex_4;
                    let _e547 = atomicAdd((&unnamed.grid[_e544]), 16777216u);
                    moistureModified = true;
                }
            }
        }
    }
    let _e548 = moistureModified;
    if _e548 {
        return;
    }
    let _e549 = (*pos_13);
    param_507 = _e549;
    let _e550 = grainCanMove_u0028_vi3_u003b((&param_507));
    canMove = _e550;
    isClumped = false;
    let _e551 = canMove;
    phi_3675_ = _e551;
    if _e551 {
        let _e552 = (*currentSleep_4);
        let _e554 = tuning.wakeSleepThreshold;
        phi_3675_ = (_e552 > _e554);
    }
    let _e557 = phi_3675_;
    if _e557 {
        emptyBelowCount = 0i;
        let _e559 = (*pos_13)[1u];
        if (_e559 > 1i) {
            x = -1i;
            loop {
                let _e561 = x;
                if (_e561 <= 1i) {
                    z = -1i;
                    loop {
                        let _e563 = z;
                        if (_e563 <= 1i) {
                            let _e565 = (*pos_13);
                            let _e566 = x;
                            let _e567 = z;
                            checkPos_1 = (_e565 + vec3<i32>(_e566, -1i, _e567));
                            let _e571 = checkPos_1[0u];
                            let _e572 = (_e571 >= 0i);
                            phi_3717_ = _e572;
                            if _e572 {
                                let _e574 = checkPos_1[0u];
                                let _e576 = tuning.gridWidth;
                                phi_3717_ = (_e574 < bitcast<i32>(_e576));
                            }
                            let _e580 = phi_3717_;
                            phi_3723_ = _e580;
                            if _e580 {
                                let _e582 = checkPos_1[2u];
                                phi_3723_ = (_e582 >= 0i);
                            }
                            let _e585 = phi_3723_;
                            phi_3732_ = _e585;
                            if _e585 {
                                let _e587 = checkPos_1[2u];
                                let _e589 = tuning.gridDepth;
                                phi_3732_ = (_e587 < bitcast<i32>(_e589));
                            }
                            let _e593 = phi_3732_;
                            if _e593 {
                                let _e594 = checkPos_1;
                                param_508 = _e594;
                                let _e595 = getIndex_u0028_vi3_u003b((&param_508));
                                param_509 = _e595;
                                let _e596 = readCell_u0028_u1_u003b((&param_509));
                                param_510 = _e596;
                                let _e597 = getType_u0028_u1_u003b((&param_510));
                                if (_e597 == 0u) {
                                    let _e599 = emptyBelowCount;
                                    emptyBelowCount = (_e599 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e601 = z;
                            z = (_e601 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e603 = x;
                    x = (_e603 + 1i);
                }
            }
        }
        let _e605 = emptyBelowCount;
        let _e607 = tuning.emptyBelowWakeCount;
        if (_e605 >= bitcast<i32>(_e607)) {
            (*currentSleep_4) = 0u;
        } else {
            clumpCount = 0i;
            x_1 = -1i;
            loop {
                let _e610 = x_1;
                if (_e610 <= 1i) {
                    y = -1i;
                    loop {
                        let _e612 = y;
                        if (_e612 <= 1i) {
                            z_1 = -1i;
                            loop {
                                let _e614 = z_1;
                                if (_e614 <= 1i) {
                                    let _e616 = x_1;
                                    let _e618 = y;
                                    let _e621 = z_1;
                                    if (((_e616 == 0i) && (_e618 == 0i)) && (_e621 == 0i)) {
                                        continue;
                                    }
                                    let _e624 = (*pos_13);
                                    let _e625 = x_1;
                                    let _e626 = y;
                                    let _e627 = z_1;
                                    nPos_5 = (_e624 + vec3<i32>(_e625, _e626, _e627));
                                    let _e631 = nPos_5[0u];
                                    let _e632 = (_e631 >= 0i);
                                    phi_3813_ = _e632;
                                    if _e632 {
                                        let _e634 = nPos_5[0u];
                                        let _e636 = tuning.gridWidth;
                                        phi_3813_ = (_e634 < bitcast<i32>(_e636));
                                    }
                                    let _e640 = phi_3813_;
                                    phi_3819_ = _e640;
                                    if _e640 {
                                        let _e642 = nPos_5[1u];
                                        phi_3819_ = (_e642 >= 0i);
                                    }
                                    let _e645 = phi_3819_;
                                    phi_3828_ = _e645;
                                    if _e645 {
                                        let _e647 = nPos_5[1u];
                                        let _e649 = tuning.gridHeight;
                                        phi_3828_ = (_e647 < bitcast<i32>(_e649));
                                    }
                                    let _e653 = phi_3828_;
                                    phi_3834_ = _e653;
                                    if _e653 {
                                        let _e655 = nPos_5[2u];
                                        phi_3834_ = (_e655 >= 0i);
                                    }
                                    let _e658 = phi_3834_;
                                    phi_3843_ = _e658;
                                    if _e658 {
                                        let _e660 = nPos_5[2u];
                                        let _e662 = tuning.gridDepth;
                                        phi_3843_ = (_e660 < bitcast<i32>(_e662));
                                    }
                                    let _e666 = phi_3843_;
                                    if _e666 {
                                        let _e667 = nPos_5;
                                        param_511 = _e667;
                                        let _e668 = getIndex_u0028_vi3_u003b((&param_511));
                                        param_512 = _e668;
                                        let _e669 = readCell_u0028_u1_u003b((&param_512));
                                        param_513 = _e669;
                                        let _e670 = getType_u0028_u1_u003b((&param_513));
                                        if (_e670 == 4u) {
                                            let _e672 = clumpCount;
                                            clumpCount = (_e672 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e674 = z_1;
                                    z_1 = (_e674 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e676 = y;
                            y = (_e676 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e678 = x_1;
                    x_1 = (_e678 + 1i);
                }
            }
            let _e680 = clumpCount;
            let _e682 = tuning.dirtClumpThreshold;
            if (_e680 >= bitcast<i32>(_e682)) {
                isClumped = true;
            }
        }
    }
    let _e685 = canMove;
    let _e686 = isClumped;
    if (_e685 && !(_e686)) {
        let _e690 = (*pos_13)[1u];
        if (_e690 > 1i) {
            let _e692 = (*pos_13);
            belowPos_5 = (_e692 + vec3<i32>(0i, -1i, 0i));
            let _e694 = belowPos_5;
            param_514 = _e694;
            let _e695 = getIndex_u0028_vi3_u003b((&param_514));
            param_515 = _e695;
            let _e696 = readCell_u0028_u1_u003b((&param_515));
            param_516 = _e696;
            let _e697 = getType_u0028_u1_u003b((&param_516));
            if (_e697 == 0u) {
                let _e699 = belowPos_5;
                param_517 = _e699;
                let _e700 = getIndex_u0028_vi3_u003b((&param_517));
                param_518 = 4u;
                param_519 = 0u;
                param_520 = 0u;
                let _e701 = moisture_4;
                param_521 = _e701;
                let _e702 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_518), (&param_519), (&param_520), (&param_521));
                let _e703 = (*currentIndex_9);
                param_522 = _e703;
                let _e704 = (*rawValue_7);
                param_523 = _e704;
                param_524 = _e700;
                param_525 = _e702;
                let _e705 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_522), (&param_523), (&param_524), (&param_525));
                if _e705 {
                    return;
                }
            }
        }
        let _e707 = (*pos_13)[1u];
        if (_e707 > 1i) {
            let _e709 = (*randVal_9);
            dir_2 = select(-1i, 1i, (fract((_e709 * 10f)) > 0.5f));
            let _e714 = (*randVal_9);
            if (fract((_e714 * 100f)) > 0.5f) {
                let _e718 = (*pos_13);
                let _e719 = dir_2;
                slidePos1_ = (_e718 + vec3<i32>(_e719, -1i, 0i));
                let _e722 = (*pos_13);
                let _e723 = dir_2;
                slidePos2_ = (_e722 + vec3<i32>(0i, -1i, _e723));
            } else {
                let _e726 = (*pos_13);
                let _e727 = dir_2;
                slidePos1_ = (_e726 + vec3<i32>(0i, -1i, _e727));
                let _e730 = (*pos_13);
                let _e731 = dir_2;
                slidePos2_ = (_e730 + vec3<i32>(_e731, -1i, 0i));
            }
            let _e735 = slidePos1_[0u];
            let _e736 = (_e735 > 0i);
            phi_3962_ = _e736;
            if _e736 {
                let _e738 = slidePos1_[0u];
                let _e740 = tuning.gridWidth;
                phi_3962_ = (_e738 < (bitcast<i32>(_e740) - 1i));
            }
            let _e745 = phi_3962_;
            phi_3968_ = _e745;
            if _e745 {
                let _e747 = slidePos1_[2u];
                phi_3968_ = (_e747 > 0i);
            }
            let _e750 = phi_3968_;
            phi_3978_ = _e750;
            if _e750 {
                let _e752 = slidePos1_[2u];
                let _e754 = tuning.gridDepth;
                phi_3978_ = (_e752 < (bitcast<i32>(_e754) - 1i));
            }
            let _e759 = phi_3978_;
            if _e759 {
                let _e760 = slidePos1_;
                param_526 = _e760;
                let _e761 = getIndex_u0028_vi3_u003b((&param_526));
                param_527 = _e761;
                let _e762 = readCell_u0028_u1_u003b((&param_527));
                param_528 = _e762;
                let _e763 = getType_u0028_u1_u003b((&param_528));
                if (_e763 == 0u) {
                    let _e765 = slidePos1_;
                    param_529 = _e765;
                    let _e766 = getIndex_u0028_vi3_u003b((&param_529));
                    param_530 = 4u;
                    param_531 = 0u;
                    param_532 = 0u;
                    let _e767 = moisture_4;
                    param_533 = _e767;
                    let _e768 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_530), (&param_531), (&param_532), (&param_533));
                    let _e769 = (*currentIndex_9);
                    param_534 = _e769;
                    let _e770 = (*rawValue_7);
                    param_535 = _e770;
                    param_536 = _e766;
                    param_537 = _e768;
                    let _e771 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_534), (&param_535), (&param_536), (&param_537));
                    if _e771 {
                        return;
                    }
                }
            }
            let _e773 = slidePos2_[0u];
            let _e774 = (_e773 > 0i);
            phi_4022_ = _e774;
            if _e774 {
                let _e776 = slidePos2_[0u];
                let _e778 = tuning.gridWidth;
                phi_4022_ = (_e776 < (bitcast<i32>(_e778) - 1i));
            }
            let _e783 = phi_4022_;
            phi_4028_ = _e783;
            if _e783 {
                let _e785 = slidePos2_[2u];
                phi_4028_ = (_e785 > 0i);
            }
            let _e788 = phi_4028_;
            phi_4038_ = _e788;
            if _e788 {
                let _e790 = slidePos2_[2u];
                let _e792 = tuning.gridDepth;
                phi_4038_ = (_e790 < (bitcast<i32>(_e792) - 1i));
            }
            let _e797 = phi_4038_;
            if _e797 {
                let _e798 = slidePos2_;
                param_538 = _e798;
                let _e799 = getIndex_u0028_vi3_u003b((&param_538));
                param_539 = _e799;
                let _e800 = readCell_u0028_u1_u003b((&param_539));
                param_540 = _e800;
                let _e801 = getType_u0028_u1_u003b((&param_540));
                if (_e801 == 0u) {
                    let _e803 = slidePos2_;
                    param_541 = _e803;
                    let _e804 = getIndex_u0028_vi3_u003b((&param_541));
                    param_542 = 4u;
                    param_543 = 0u;
                    param_544 = 0u;
                    let _e805 = moisture_4;
                    param_545 = _e805;
                    let _e806 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_542), (&param_543), (&param_544), (&param_545));
                    let _e807 = (*currentIndex_9);
                    param_546 = _e807;
                    let _e808 = (*rawValue_7);
                    param_547 = _e808;
                    param_548 = _e804;
                    param_549 = _e806;
                    let _e809 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_546), (&param_547), (&param_548), (&param_549));
                    if _e809 {
                        return;
                    }
                }
            }
        }
        let _e811 = (*pos_13)[1u];
        if (_e811 > 1i) {
            let _e813 = (*pos_13);
            belowPos_6 = (_e813 + vec3<i32>(0i, -1i, 0i));
            let _e815 = belowPos_6;
            param_550 = _e815;
            let _e816 = getIndex_u0028_vi3_u003b((&param_550));
            belowIndex_2 = _e816;
            let _e817 = belowIndex_2;
            param_551 = _e817;
            let _e818 = readCell_u0028_u1_u003b((&param_551));
            belowValue_2 = _e818;
            let _e819 = belowValue_2;
            param_552 = _e819;
            let _e820 = getType_u0028_u1_u003b((&param_552));
            if (_e820 == 2u) {
                let _e822 = (*randVal_9);
                startDir_2 = i32((fract((_e822 * 8f)) * 8f));
                i_17 = 0i;
                loop {
                    let _e827 = i_17;
                    if (_e827 < 8i) {
                        let _e829 = startDir_2;
                        let _e830 = i_17;
                        let _e831 = (_e829 + _e830);
                        d_13 = (_e831 - (i32(floor((f32(_e831) / f32(8i)))) * 8i));
                        let _e839 = belowPos_6;
                        let _e840 = d_13;
                        param_553 = _e840;
                        let _e841 = getHDir_u0028_i1_u003b((&param_553));
                        pushPos = (_e839 + _e841);
                        let _e844 = pushPos[0u];
                        let _e845 = (_e844 > 0i);
                        phi_4129_ = _e845;
                        if _e845 {
                            let _e847 = pushPos[0u];
                            let _e849 = tuning.gridWidth;
                            phi_4129_ = (_e847 < (bitcast<i32>(_e849) - 1i));
                        }
                        let _e854 = phi_4129_;
                        phi_4135_ = _e854;
                        if _e854 {
                            let _e856 = pushPos[2u];
                            phi_4135_ = (_e856 > 0i);
                        }
                        let _e859 = phi_4135_;
                        phi_4145_ = _e859;
                        if _e859 {
                            let _e861 = pushPos[2u];
                            let _e863 = tuning.gridDepth;
                            phi_4145_ = (_e861 < (bitcast<i32>(_e863) - 1i));
                        }
                        let _e868 = phi_4145_;
                        if _e868 {
                            param_554 = 4u;
                            param_555 = 0u;
                            param_556 = 0u;
                            let _e869 = moisture_4;
                            param_557 = _e869;
                            let _e870 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_554), (&param_555), (&param_556), (&param_557));
                            let _e871 = pushPos;
                            param_558 = _e871;
                            let _e872 = getIndex_u0028_vi3_u003b((&param_558));
                            let _e873 = (*currentIndex_9);
                            param_559 = _e873;
                            param_560 = _e870;
                            let _e874 = belowIndex_2;
                            param_561 = _e874;
                            let _e875 = belowValue_2;
                            param_562 = _e875;
                            param_563 = _e872;
                            let _e876 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_559), (&param_560), (&param_561), (&param_562), (&param_563));
                            if _e876 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e877 = i_17;
                        i_17 = (_e877 + 1i);
                    }
                }
                param_564 = 4u;
                param_565 = 0u;
                param_566 = 0u;
                let _e879 = moisture_4;
                param_567 = _e879;
                let _e880 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_564), (&param_565), (&param_566), (&param_567));
                let _e881 = (*currentIndex_9);
                param_568 = _e881;
                let _e882 = (*rawValue_7);
                param_569 = _e882;
                let _e883 = belowIndex_2;
                param_570 = _e883;
                param_571 = _e880;
                let _e884 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_568), (&param_569), (&param_570), (&param_571));
                if _e884 {
                    return;
                }
            }
            let _e885 = (*randVal_9);
            dir_3 = select(-1i, 1i, (fract((_e885 * 10f)) > 0.5f));
            let _e890 = (*randVal_9);
            if (fract((_e890 * 100f)) > 0.5f) {
                let _e894 = (*pos_13);
                let _e895 = dir_3;
                slidePos[0i] = (_e894 + vec3<i32>(_e895, -1i, 0i));
                let _e899 = (*pos_13);
                let _e900 = dir_3;
                slidePos[1i] = (_e899 + vec3<i32>(0i, -1i, _e900));
            } else {
                let _e904 = (*pos_13);
                let _e905 = dir_3;
                slidePos[0i] = (_e904 + vec3<i32>(0i, -1i, _e905));
                let _e909 = (*pos_13);
                let _e910 = dir_3;
                slidePos[1i] = (_e909 + vec3<i32>(_e910, -1i, 0i));
            }
            s_1 = 0i;
            loop {
                let _e914 = s_1;
                if (_e914 < 2i) {
                    let _e916 = s_1;
                    let _e918 = slidePos[_e916];
                    sPos_2 = _e918;
                    let _e920 = sPos_2[0u];
                    let _e921 = (_e920 > 0i);
                    phi_4246_ = _e921;
                    if _e921 {
                        let _e923 = sPos_2[0u];
                        let _e925 = tuning.gridWidth;
                        phi_4246_ = (_e923 < (bitcast<i32>(_e925) - 1i));
                    }
                    let _e930 = phi_4246_;
                    phi_4252_ = _e930;
                    if _e930 {
                        let _e932 = sPos_2[2u];
                        phi_4252_ = (_e932 > 0i);
                    }
                    let _e935 = phi_4252_;
                    phi_4262_ = _e935;
                    if _e935 {
                        let _e937 = sPos_2[2u];
                        let _e939 = tuning.gridDepth;
                        phi_4262_ = (_e937 < (bitcast<i32>(_e939) - 1i));
                    }
                    let _e944 = phi_4262_;
                    if _e944 {
                        let _e945 = sPos_2;
                        param_572 = _e945;
                        let _e946 = getIndex_u0028_vi3_u003b((&param_572));
                        sIndex = _e946;
                        let _e947 = sIndex;
                        param_573 = _e947;
                        let _e948 = readCell_u0028_u1_u003b((&param_573));
                        sValue = _e948;
                        let _e949 = sValue;
                        param_574 = _e949;
                        let _e950 = getType_u0028_u1_u003b((&param_574));
                        if (_e950 == 2u) {
                            let _e952 = (*randVal_9);
                            let _e954 = s_1;
                            startDir_3 = i32((fract(((_e952 * 8f) + f32(_e954))) * 8f));
                            i_18 = 0i;
                            loop {
                                let _e960 = i_18;
                                if (_e960 < 8i) {
                                    let _e962 = startDir_3;
                                    let _e963 = i_18;
                                    let _e964 = (_e962 + _e963);
                                    d_14 = (_e964 - (i32(floor((f32(_e964) / f32(8i)))) * 8i));
                                    let _e972 = sPos_2;
                                    let _e973 = d_14;
                                    param_575 = _e973;
                                    let _e974 = getHDir_u0028_i1_u003b((&param_575));
                                    pushPos_1 = (_e972 + _e974);
                                    let _e977 = pushPos_1[0u];
                                    let _e978 = (_e977 > 0i);
                                    phi_4319_ = _e978;
                                    if _e978 {
                                        let _e980 = pushPos_1[0u];
                                        let _e982 = tuning.gridWidth;
                                        phi_4319_ = (_e980 < (bitcast<i32>(_e982) - 1i));
                                    }
                                    let _e987 = phi_4319_;
                                    phi_4325_ = _e987;
                                    if _e987 {
                                        let _e989 = pushPos_1[2u];
                                        phi_4325_ = (_e989 > 0i);
                                    }
                                    let _e992 = phi_4325_;
                                    phi_4335_ = _e992;
                                    if _e992 {
                                        let _e994 = pushPos_1[2u];
                                        let _e996 = tuning.gridDepth;
                                        phi_4335_ = (_e994 < (bitcast<i32>(_e996) - 1i));
                                    }
                                    let _e1001 = phi_4335_;
                                    if _e1001 {
                                        param_576 = 4u;
                                        param_577 = 0u;
                                        param_578 = 0u;
                                        let _e1002 = moisture_4;
                                        param_579 = _e1002;
                                        let _e1003 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_576), (&param_577), (&param_578), (&param_579));
                                        let _e1004 = pushPos_1;
                                        param_580 = _e1004;
                                        let _e1005 = getIndex_u0028_vi3_u003b((&param_580));
                                        let _e1006 = (*currentIndex_9);
                                        param_581 = _e1006;
                                        param_582 = _e1003;
                                        let _e1007 = sIndex;
                                        param_583 = _e1007;
                                        let _e1008 = sValue;
                                        param_584 = _e1008;
                                        param_585 = _e1005;
                                        let _e1009 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_581), (&param_582), (&param_583), (&param_584), (&param_585));
                                        if _e1009 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1010 = i_18;
                                    i_18 = (_e1010 + 1i);
                                }
                            }
                            param_586 = 4u;
                            param_587 = 0u;
                            param_588 = 0u;
                            let _e1012 = moisture_4;
                            param_589 = _e1012;
                            let _e1013 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_586), (&param_587), (&param_588), (&param_589));
                            let _e1014 = (*currentIndex_9);
                            param_590 = _e1014;
                            let _e1015 = (*rawValue_7);
                            param_591 = _e1015;
                            let _e1016 = sIndex;
                            param_592 = _e1016;
                            param_593 = _e1013;
                            let _e1017 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_590), (&param_591), (&param_592), (&param_593));
                            if _e1017 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1018 = s_1;
                    s_1 = (_e1018 + 1i);
                }
            }
        }
    }
    let _e1020 = (*currentDir_4);
    floraState = _e1020;
    let _e1021 = isClumped;
    phi_4390_ = _e1021;
    if !(_e1021) {
        let _e1023 = (*currentSleep_4);
        let _e1025 = tuning.wakeSleepThreshold;
        phi_4390_ = (_e1023 > _e1025);
    }
    let _e1028 = phi_4390_;
    if _e1028 {
        let _e1029 = (*pos_13);
        abovePos_1 = (_e1029 + vec3<i32>(0i, 1i, 0i));
        let _e1032 = abovePos_1[1u];
        let _e1034 = tuning.gridHeight;
        aboveInside = (_e1032 < (bitcast<i32>(_e1034) - 1i));
        let _e1038 = abovePos_1;
        param_594 = _e1038;
        let _e1039 = getIndex_u0028_vi3_u003b((&param_594));
        aboveIndex = _e1039;
        let _e1040 = aboveInside;
        if _e1040 {
            let _e1041 = aboveIndex;
            param_595 = _e1041;
            let _e1042 = readCell_u0028_u1_u003b((&param_595));
            param_596 = _e1042;
            let _e1043 = getType_u0028_u1_u003b((&param_596));
            local_21 = _e1043;
        } else {
            local_21 = 0u;
        }
        let _e1044 = local_21;
        aboveType = _e1044;
        let _e1045 = aboveType;
        let _e1047 = aboveType;
        if ((_e1045 == 0u) || (_e1047 == 18u)) {
            let _e1050 = moisture_4;
            let _e1052 = floraState;
            if ((_e1050 >= 5u) && (_e1052 < 100u)) {
                let _e1055 = (*randVal_9);
                let _e1059 = tuning.grassGrowChance;
                if (fract((_e1055 * 55f)) < _e1059) {
                    let _e1061 = floraState;
                    floraState = (_e1061 + bitcast<u32>(1i));
                    let _e1064 = floraState;
                    let _e1066 = aboveType;
                    let _e1069 = aboveInside;
                    let _e1070 = (((_e1064 == 100u) && (_e1066 == 0u)) && _e1069);
                    phi_4464_ = _e1070;
                    if _e1070 {
                        let _e1071 = (*randVal_9);
                        let _e1075 = tuning.treeBloomChance;
                        phi_4464_ = (fract((_e1071 * 97f)) < _e1075);
                    }
                    let _e1078 = phi_4464_;
                    if _e1078 {
                        let _e1079 = aboveIndex;
                        param_597 = 18u;
                        param_598 = 0u;
                        param_599 = 0u;
                        param_600 = 0u;
                        let _e1082 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_597), (&param_598), (&param_599), (&param_600));
                        let _e1083 = atomicCompareExchangeWeak((&unnamed.grid[_e1079]), 0u, _e1082);
                    }
                }
            }
            let _e1085 = floraState;
            if (_e1085 > 100u) {
                floraState = 100u;
            }
        } else {
            let _e1087 = aboveType;
            if (_e1087 == 2u) {
                let _e1089 = floraState;
                if (_e1089 > 0u) {
                    let _e1091 = floraState;
                    if (_e1091 <= 100u) {
                        floraState = 101u;
                    }
                    let _e1093 = (*randVal_9);
                    let _e1097 = tuning.grassSubmergedDecayChance;
                    if (fract((_e1093 * 66f)) < _e1097) {
                        let _e1099 = floraState;
                        floraState = (_e1099 + bitcast<u32>(1i));
                    }
                    let _e1102 = floraState;
                    if (_e1102 >= 200u) {
                        floraState = 0u;
                    }
                }
            } else {
                let _e1104 = aboveType;
                let _e1105 = (_e1104 != 5u);
                phi_4519_ = _e1105;
                if _e1105 {
                    let _e1106 = aboveType;
                    param_601 = _e1106;
                    let _e1107 = isLocust_u0028_u1_u003b((&param_601));
                    phi_4519_ = !(_e1107);
                }
                let _e1110 = phi_4519_;
                if _e1110 {
                    floraState = 0u;
                }
            }
        }
    }
    let _e1111 = (*currentSleep_4);
    newSleep_2 = min((_e1111 + 1u), 255u);
    let _e1114 = (*currentIndex_9);
    let _e1117 = (*rawValue_7);
    param_602 = 4u;
    let _e1118 = floraState;
    param_603 = _e1118;
    let _e1119 = newSleep_2;
    param_604 = _e1119;
    let _e1120 = moisture_4;
    param_605 = _e1120;
    let _e1121 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_602), (&param_603), (&param_604), (&param_605));
    let _e1122 = atomicCompareExchangeWeak((&unnamed.grid[_e1114]), _e1117, _e1121);
    return;
}

fn updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_14: ptr<function, vec3<i32>>, currentIndex_10: ptr<function, u32>, rawValue_8: ptr<function, u32>, currentDir_5: ptr<function, u32>, currentSleep_5: ptr<function, u32>, currentAge_8: ptr<function, u32>, randVal_10: ptr<function, f32>) {
    var wake: bool;
    var param_606: vec3<i32>;
    var param_607: u32;
    var param_608: u32;
    var hasPressure_1: bool;
    var local_22: bool;
    var param_609: vec3<i32>;
    var param_610: u32;
    var param_611: u32;
    var isStackedOnWater: bool;
    var local_23: bool;
    var param_612: vec3<i32>;
    var param_613: u32;
    var param_614: u32;
    var d_15: i32;
    var nPos_6: vec3<i32>;
    var param_615: i32;
    var param_616: vec3<i32>;
    var param_617: u32;
    var param_618: u32;
    var belowNeighbor: u32;
    var param_619: vec3<i32>;
    var param_620: u32;
    var param_621: u32;
    var newAge_2: u32;
    var belowPos_7: vec3<i32>;
    var param_622: vec3<i32>;
    var param_623: u32;
    var param_624: u32;
    var param_625: vec3<i32>;
    var param_626: u32;
    var param_627: u32;
    var param_628: u32;
    var param_629: u32;
    var param_630: u32;
    var param_631: u32;
    var param_632: u32;
    var param_633: u32;
    var newDir: u32;
    var r_1: f32;
    var diagDir: u32;
    var r_2: f32;
    var stepPos: vec3<i32>;
    var param_634: i32;
    var param_635: vec3<i32>;
    var param_636: u32;
    var param_637: u32;
    var newValue_1: u32;
    var param_638: u32;
    var param_639: u32;
    var param_640: u32;
    var param_641: u32;
    var param_642: vec3<i32>;
    var param_643: u32;
    var param_644: u32;
    var param_645: u32;
    var param_646: u32;
    var bestDropPos: vec3<i32>;
    var foundDrop: bool;
    var blockedMask_1: u32;
    var startDir_4: i32;
    var waterReach: i32;
    var r_3: i32;
    var i_19: i32;
    var d_16: i32;
    var c_7: vec3<i32>;
    var param_647: i32;
    var param_648: vec3<i32>;
    var param_649: u32;
    var param_650: u32;
    var param_651: vec3<i32>;
    var param_652: u32;
    var param_653: u32;
    var newValue_2: u32;
    var param_654: u32;
    var param_655: u32;
    var param_656: u32;
    var param_657: u32;
    var param_658: vec3<i32>;
    var param_659: u32;
    var param_660: u32;
    var param_661: u32;
    var param_662: u32;
    var hasPressure_2: bool;
    var local_24: bool;
    var param_663: vec3<i32>;
    var param_664: u32;
    var param_665: u32;
    var isStackedOnWater_1: bool;
    var local_25: bool;
    var param_666: vec3<i32>;
    var param_667: u32;
    var param_668: u32;
    var canStepOntoPool: bool;
    var d_17: i32;
    var nPos_7: vec3<i32>;
    var param_669: i32;
    var param_670: vec3<i32>;
    var param_671: u32;
    var param_672: u32;
    var param_673: vec3<i32>;
    var param_674: u32;
    var param_675: u32;
    var startSpreadDir: i32;
    var i_20: i32;
    var d_18: i32;
    var targetPos_2: vec3<i32>;
    var param_676: i32;
    var param_677: vec3<i32>;
    var param_678: u32;
    var param_679: u32;
    var newValue_3: u32;
    var param_680: u32;
    var param_681: u32;
    var param_682: u32;
    var param_683: u32;
    var param_684: vec3<i32>;
    var param_685: u32;
    var param_686: u32;
    var param_687: u32;
    var param_688: u32;
    var newSleep_3: u32;
    var sleepValue: u32;
    var param_689: u32;
    var param_690: u32;
    var param_691: u32;
    var param_692: u32;
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

    let _e331 = (*currentSleep_5);
    let _e333 = tuning.wakeSleepThreshold;
    if (_e331 > _e333) {
        wake = false;
        let _e336 = (*pos_14)[1u];
        let _e337 = (_e336 > 1i);
        phi_4559_ = _e337;
        if _e337 {
            let _e338 = (*pos_14);
            param_606 = (_e338 + vec3<i32>(0i, -1i, 0i));
            let _e340 = getIndex_u0028_vi3_u003b((&param_606));
            param_607 = _e340;
            let _e341 = readCell_u0028_u1_u003b((&param_607));
            param_608 = _e341;
            let _e342 = getType_u0028_u1_u003b((&param_608));
            phi_4559_ = (_e342 == 0u);
        }
        let _e345 = phi_4559_;
        if _e345 {
            wake = true;
        } else {
            let _e347 = (*pos_14)[1u];
            let _e349 = tuning.gridHeight;
            if (_e347 < (bitcast<i32>(_e349) - 2i)) {
                let _e353 = (*pos_14);
                param_609 = (_e353 + vec3<i32>(0i, 1i, 0i));
                let _e355 = getIndex_u0028_vi3_u003b((&param_609));
                param_610 = _e355;
                let _e356 = readCell_u0028_u1_u003b((&param_610));
                param_611 = _e356;
                let _e357 = getType_u0028_u1_u003b((&param_611));
                local_22 = (_e357 != 0u);
            } else {
                local_22 = false;
            }
            let _e359 = local_22;
            hasPressure_1 = _e359;
            let _e361 = (*pos_14)[1u];
            if (_e361 > 1i) {
                let _e363 = (*pos_14);
                param_612 = (_e363 + vec3<i32>(0i, -1i, 0i));
                let _e365 = getIndex_u0028_vi3_u003b((&param_612));
                param_613 = _e365;
                let _e366 = readCell_u0028_u1_u003b((&param_613));
                param_614 = _e366;
                let _e367 = getType_u0028_u1_u003b((&param_614));
                local_23 = (_e367 == 2u);
            } else {
                local_23 = false;
            }
            let _e369 = local_23;
            isStackedOnWater = _e369;
            d_15 = 0i;
            loop {
                let _e370 = d_15;
                if (_e370 < 8i) {
                    let _e372 = (*pos_14);
                    let _e373 = d_15;
                    param_615 = _e373;
                    let _e374 = getHDir_u0028_i1_u003b((&param_615));
                    nPos_6 = (_e372 + _e374);
                    let _e377 = nPos_6[0u];
                    let _e378 = (_e377 > 0i);
                    phi_4629_ = _e378;
                    if _e378 {
                        let _e380 = nPos_6[0u];
                        let _e382 = tuning.gridWidth;
                        phi_4629_ = (_e380 < (bitcast<i32>(_e382) - 1i));
                    }
                    let _e387 = phi_4629_;
                    phi_4635_ = _e387;
                    if _e387 {
                        let _e389 = nPos_6[2u];
                        phi_4635_ = (_e389 > 0i);
                    }
                    let _e392 = phi_4635_;
                    phi_4645_ = _e392;
                    if _e392 {
                        let _e394 = nPos_6[2u];
                        let _e396 = tuning.gridDepth;
                        phi_4645_ = (_e394 < (bitcast<i32>(_e396) - 1i));
                    }
                    let _e401 = phi_4645_;
                    if _e401 {
                        let _e402 = nPos_6;
                        param_616 = _e402;
                        let _e403 = getIndex_u0028_vi3_u003b((&param_616));
                        param_617 = _e403;
                        let _e404 = readCell_u0028_u1_u003b((&param_617));
                        param_618 = _e404;
                        let _e405 = getType_u0028_u1_u003b((&param_618));
                        if (_e405 == 0u) {
                            let _e407 = nPos_6;
                            param_619 = (_e407 + vec3<i32>(0i, -1i, 0i));
                            let _e409 = getIndex_u0028_vi3_u003b((&param_619));
                            param_620 = _e409;
                            let _e410 = readCell_u0028_u1_u003b((&param_620));
                            param_621 = _e410;
                            let _e411 = getType_u0028_u1_u003b((&param_621));
                            belowNeighbor = _e411;
                            let _e412 = belowNeighbor;
                            let _e414 = hasPressure_1;
                            let _e416 = isStackedOnWater;
                            let _e418 = belowNeighbor;
                            if ((((_e412 == 0u) || _e414) || _e416) || (_e418 == 2u)) {
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
                    let _e421 = d_15;
                    d_15 = (_e421 + 1i);
                }
            }
        }
        let _e423 = wake;
        if !(_e423) {
            return;
        }
        (*currentSleep_5) = 0u;
        (*currentAge_8) = 0u;
    }
    let _e425 = (*currentAge_8);
    newAge_2 = (_e425 + 1u);
    let _e428 = (*pos_14)[1u];
    if (_e428 > 1i) {
        let _e430 = (*pos_14);
        belowPos_7 = (_e430 + vec3<i32>(0i, -1i, 0i));
        let _e432 = belowPos_7;
        param_622 = _e432;
        let _e433 = getIndex_u0028_vi3_u003b((&param_622));
        param_623 = _e433;
        let _e434 = readCell_u0028_u1_u003b((&param_623));
        param_624 = _e434;
        let _e435 = getType_u0028_u1_u003b((&param_624));
        if (_e435 == 0u) {
            let _e437 = belowPos_7;
            param_625 = _e437;
            let _e438 = getIndex_u0028_vi3_u003b((&param_625));
            param_626 = 2u;
            param_627 = 0u;
            param_628 = 0u;
            let _e439 = newAge_2;
            param_629 = _e439;
            let _e440 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_626), (&param_627), (&param_628), (&param_629));
            let _e441 = (*currentIndex_10);
            param_630 = _e441;
            let _e442 = (*rawValue_8);
            param_631 = _e442;
            param_632 = _e438;
            param_633 = _e440;
            let _e443 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_630), (&param_631), (&param_632), (&param_633));
            if _e443 {
                return;
            }
        }
    }
    let _e444 = (*currentDir_5);
    newDir = _e444;
    let _e445 = newDir;
    let _e447 = newDir;
    if ((_e445 == 0u) || (_e447 == 9u)) {
        let _e450 = (*randVal_10);
        r_1 = fract((_e450 * 77f));
        let _e453 = r_1;
        if (_e453 < 0.25f) {
            newDir = 1u;
        } else {
            let _e455 = r_1;
            if (_e455 < 0.5f) {
                newDir = 2u;
            } else {
                let _e457 = r_1;
                if (_e457 < 0.75f) {
                    newDir = 3u;
                } else {
                    newDir = 4u;
                }
            }
        }
    }
    let _e459 = newAge_2;
    let _e462 = newAge_2;
    if (((_e459 % 3u) == 0u) && (_e462 > 0u)) {
        let _e465 = newDir;
        diagDir = _e465;
        let _e466 = diagDir;
        let _e468 = diagDir;
        if ((_e466 >= 1u) && (_e468 <= 4u)) {
            let _e471 = (*randVal_10);
            r_2 = fract((_e471 * 133f));
            let _e474 = diagDir;
            if (_e474 == 1u) {
                let _e476 = r_2;
                diagDir = select(6u, 5u, (_e476 > 0.5f));
            } else {
                let _e479 = diagDir;
                if (_e479 == 2u) {
                    let _e481 = r_2;
                    diagDir = select(8u, 7u, (_e481 > 0.5f));
                } else {
                    let _e484 = diagDir;
                    if (_e484 == 3u) {
                        let _e486 = r_2;
                        diagDir = select(7u, 5u, (_e486 > 0.5f));
                    } else {
                        let _e489 = diagDir;
                        if (_e489 == 4u) {
                            let _e491 = r_2;
                            diagDir = select(8u, 6u, (_e491 > 0.5f));
                        }
                    }
                }
            }
        }
        let _e494 = (*pos_14);
        let _e495 = diagDir;
        param_634 = (bitcast<i32>(_e495) - 1i);
        let _e498 = getHDir_u0028_i1_u003b((&param_634));
        stepPos = (_e494 + _e498);
        let _e501 = stepPos[0u];
        let _e502 = (_e501 > 0i);
        phi_4831_ = _e502;
        if _e502 {
            let _e504 = stepPos[0u];
            let _e506 = tuning.gridWidth;
            phi_4831_ = (_e504 < (bitcast<i32>(_e506) - 1i));
        }
        let _e511 = phi_4831_;
        phi_4837_ = _e511;
        if _e511 {
            let _e513 = stepPos[2u];
            phi_4837_ = (_e513 > 0i);
        }
        let _e516 = phi_4837_;
        phi_4847_ = _e516;
        if _e516 {
            let _e518 = stepPos[2u];
            let _e520 = tuning.gridDepth;
            phi_4847_ = (_e518 < (bitcast<i32>(_e520) - 1i));
        }
        let _e525 = phi_4847_;
        if _e525 {
            let _e526 = stepPos;
            param_635 = _e526;
            let _e527 = getIndex_u0028_vi3_u003b((&param_635));
            param_636 = _e527;
            let _e528 = readCell_u0028_u1_u003b((&param_636));
            param_637 = _e528;
            let _e529 = getType_u0028_u1_u003b((&param_637));
            if (_e529 == 0u) {
                param_638 = 2u;
                let _e531 = newDir;
                param_639 = _e531;
                param_640 = 0u;
                let _e532 = newAge_2;
                param_641 = _e532;
                let _e533 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_638), (&param_639), (&param_640), (&param_641));
                newValue_1 = _e533;
                let _e534 = stepPos;
                param_642 = _e534;
                let _e535 = getIndex_u0028_vi3_u003b((&param_642));
                let _e536 = (*currentIndex_10);
                param_643 = _e536;
                let _e537 = (*rawValue_8);
                param_644 = _e537;
                param_645 = _e535;
                let _e538 = newValue_1;
                param_646 = _e538;
                let _e539 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_643), (&param_644), (&param_645), (&param_646));
                if _e539 {
                    return;
                }
            }
        }
    }
    let _e540 = (*pos_14);
    bestDropPos = _e540;
    foundDrop = false;
    blockedMask_1 = 0u;
    let _e541 = (*randVal_10);
    startDir_4 = i32((fract((_e541 * 8f)) * 8f));
    let _e547 = tuning.waterSpreadRadius;
    let _e549 = tuning.gridWidth;
    let _e552 = tuning.gridHeight;
    waterReach = bitcast<i32>(clamp(_e547, 1u, bitcast<u32>(max(bitcast<i32>(_e549), bitcast<i32>(_e552)))));
    r_3 = 1i;
    loop {
        let _e558 = r_3;
        let _e559 = waterReach;
        if (_e558 <= _e559) {
            let _e561 = blockedMask_1;
            if (_e561 == 255u) {
                break;
            }
            i_19 = 0i;
            loop {
                let _e563 = i_19;
                if (_e563 < 8i) {
                    let _e565 = startDir_4;
                    let _e566 = i_19;
                    let _e567 = (_e565 + _e566);
                    d_16 = (_e567 - (i32(floor((f32(_e567) / f32(8i)))) * 8i));
                    let _e575 = blockedMask_1;
                    let _e576 = d_16;
                    if ((_e575 & (1u << bitcast<u32>(_e576))) == 0u) {
                        let _e581 = (*pos_14);
                        let _e582 = d_16;
                        param_647 = _e582;
                        let _e583 = getHDir_u0028_i1_u003b((&param_647));
                        let _e584 = r_3;
                        c_7 = (_e581 + (_e583 * vec3(_e584)));
                        let _e589 = c_7[0u];
                        let _e590 = (_e589 <= 0i);
                        phi_4962_ = _e590;
                        if !(_e590) {
                            let _e593 = c_7[0u];
                            let _e595 = tuning.gridWidth;
                            phi_4962_ = (_e593 >= (bitcast<i32>(_e595) - 1i));
                        }
                        let _e600 = phi_4962_;
                        phi_4969_ = _e600;
                        if !(_e600) {
                            let _e603 = c_7[2u];
                            phi_4969_ = (_e603 <= 0i);
                        }
                        let _e606 = phi_4969_;
                        phi_4980_ = _e606;
                        if !(_e606) {
                            let _e609 = c_7[2u];
                            let _e611 = tuning.gridDepth;
                            phi_4980_ = (_e609 >= (bitcast<i32>(_e611) - 1i));
                        }
                        let _e616 = phi_4980_;
                        phi_4992_ = _e616;
                        if !(_e616) {
                            let _e618 = c_7;
                            param_648 = _e618;
                            let _e619 = getIndex_u0028_vi3_u003b((&param_648));
                            param_649 = _e619;
                            let _e620 = readCell_u0028_u1_u003b((&param_649));
                            param_650 = _e620;
                            let _e621 = getType_u0028_u1_u003b((&param_650));
                            phi_4992_ = (_e621 != 0u);
                        }
                        let _e624 = phi_4992_;
                        if _e624 {
                            let _e625 = d_16;
                            let _e628 = blockedMask_1;
                            blockedMask_1 = (_e628 | (1u << bitcast<u32>(_e625)));
                        } else {
                            let _e631 = c_7[1u];
                            let _e632 = (_e631 > 1i);
                            phi_5014_ = _e632;
                            if _e632 {
                                let _e633 = c_7;
                                param_651 = (_e633 + vec3<i32>(0i, -1i, 0i));
                                let _e635 = getIndex_u0028_vi3_u003b((&param_651));
                                param_652 = _e635;
                                let _e636 = readCell_u0028_u1_u003b((&param_652));
                                param_653 = _e636;
                                let _e637 = getType_u0028_u1_u003b((&param_653));
                                phi_5014_ = (_e637 == 0u);
                            }
                            let _e640 = phi_5014_;
                            if _e640 {
                                let _e641 = c_7;
                                bestDropPos = _e641;
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
                    let _e642 = i_19;
                    i_19 = (_e642 + 1i);
                }
            }
            let _e644 = foundDrop;
            if _e644 {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e645 = r_3;
            r_3 = (_e645 + 1i);
        }
    }
    let _e647 = foundDrop;
    if _e647 {
        param_654 = 2u;
        param_655 = 0u;
        param_656 = 0u;
        param_657 = 0u;
        let _e648 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_654), (&param_655), (&param_656), (&param_657));
        newValue_2 = _e648;
        let _e649 = bestDropPos;
        param_658 = _e649;
        let _e650 = getIndex_u0028_vi3_u003b((&param_658));
        let _e651 = (*currentIndex_10);
        param_659 = _e651;
        let _e652 = (*rawValue_8);
        param_660 = _e652;
        param_661 = _e650;
        let _e653 = newValue_2;
        param_662 = _e653;
        let _e654 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_659), (&param_660), (&param_661), (&param_662));
        if _e654 {
            return;
        }
    } else {
        let _e656 = (*pos_14)[1u];
        let _e658 = tuning.gridHeight;
        if (_e656 < (bitcast<i32>(_e658) - 2i)) {
            let _e662 = (*pos_14);
            param_663 = (_e662 + vec3<i32>(0i, 1i, 0i));
            let _e664 = getIndex_u0028_vi3_u003b((&param_663));
            param_664 = _e664;
            let _e665 = readCell_u0028_u1_u003b((&param_664));
            param_665 = _e665;
            let _e666 = getType_u0028_u1_u003b((&param_665));
            local_24 = (_e666 != 0u);
        } else {
            local_24 = false;
        }
        let _e668 = local_24;
        hasPressure_2 = _e668;
        let _e670 = (*pos_14)[1u];
        if (_e670 > 1i) {
            let _e672 = (*pos_14);
            param_666 = (_e672 + vec3<i32>(0i, -1i, 0i));
            let _e674 = getIndex_u0028_vi3_u003b((&param_666));
            param_667 = _e674;
            let _e675 = readCell_u0028_u1_u003b((&param_667));
            param_668 = _e675;
            let _e676 = getType_u0028_u1_u003b((&param_668));
            local_25 = (_e676 == 2u);
        } else {
            local_25 = false;
        }
        let _e678 = local_25;
        isStackedOnWater_1 = _e678;
        canStepOntoPool = false;
        d_17 = 0i;
        loop {
            let _e679 = d_17;
            if (_e679 < 8i) {
                let _e681 = (*pos_14);
                let _e682 = d_17;
                param_669 = _e682;
                let _e683 = getHDir_u0028_i1_u003b((&param_669));
                nPos_7 = (_e681 + _e683);
                let _e686 = nPos_7[0u];
                let _e687 = (_e686 > 0i);
                phi_5118_ = _e687;
                if _e687 {
                    let _e689 = nPos_7[0u];
                    let _e691 = tuning.gridWidth;
                    phi_5118_ = (_e689 < (bitcast<i32>(_e691) - 1i));
                }
                let _e696 = phi_5118_;
                phi_5124_ = _e696;
                if _e696 {
                    let _e698 = nPos_7[2u];
                    phi_5124_ = (_e698 > 0i);
                }
                let _e701 = phi_5124_;
                phi_5134_ = _e701;
                if _e701 {
                    let _e703 = nPos_7[2u];
                    let _e705 = tuning.gridDepth;
                    phi_5134_ = (_e703 < (bitcast<i32>(_e705) - 1i));
                }
                let _e710 = phi_5134_;
                if _e710 {
                    let _e711 = nPos_7;
                    param_670 = _e711;
                    let _e712 = getIndex_u0028_vi3_u003b((&param_670));
                    param_671 = _e712;
                    let _e713 = readCell_u0028_u1_u003b((&param_671));
                    param_672 = _e713;
                    let _e714 = getType_u0028_u1_u003b((&param_672));
                    let _e715 = (_e714 == 0u);
                    phi_5150_ = _e715;
                    if _e715 {
                        let _e717 = (*pos_14)[1u];
                        phi_5150_ = (_e717 > 1i);
                    }
                    let _e720 = phi_5150_;
                    phi_5162_ = _e720;
                    if _e720 {
                        let _e721 = nPos_7;
                        param_673 = (_e721 + vec3<i32>(0i, -1i, 0i));
                        let _e723 = getIndex_u0028_vi3_u003b((&param_673));
                        param_674 = _e723;
                        let _e724 = readCell_u0028_u1_u003b((&param_674));
                        param_675 = _e724;
                        let _e725 = getType_u0028_u1_u003b((&param_675));
                        phi_5162_ = (_e725 == 2u);
                    }
                    let _e728 = phi_5162_;
                    if _e728 {
                        canStepOntoPool = true;
                        break;
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e729 = d_17;
                d_17 = (_e729 + 1i);
            }
        }
        let _e731 = hasPressure_2;
        let _e732 = isStackedOnWater_1;
        let _e734 = canStepOntoPool;
        if ((_e731 || _e732) || _e734) {
            let _e736 = (*randVal_10);
            startSpreadDir = i32((fract((_e736 * 8f)) * 8f));
            i_20 = 0i;
            loop {
                let _e741 = i_20;
                if (_e741 < 8i) {
                    let _e743 = startSpreadDir;
                    let _e744 = i_20;
                    let _e745 = (_e743 + _e744);
                    d_18 = (_e745 - (i32(floor((f32(_e745) / f32(8i)))) * 8i));
                    let _e753 = (*pos_14);
                    let _e754 = d_18;
                    param_676 = _e754;
                    let _e755 = getHDir_u0028_i1_u003b((&param_676));
                    targetPos_2 = (_e753 + _e755);
                    let _e758 = targetPos_2[0u];
                    let _e759 = (_e758 > 0i);
                    phi_5212_ = _e759;
                    if _e759 {
                        let _e761 = targetPos_2[0u];
                        let _e763 = tuning.gridWidth;
                        phi_5212_ = (_e761 < (bitcast<i32>(_e763) - 1i));
                    }
                    let _e768 = phi_5212_;
                    phi_5218_ = _e768;
                    if _e768 {
                        let _e770 = targetPos_2[2u];
                        phi_5218_ = (_e770 > 0i);
                    }
                    let _e773 = phi_5218_;
                    phi_5228_ = _e773;
                    if _e773 {
                        let _e775 = targetPos_2[2u];
                        let _e777 = tuning.gridDepth;
                        phi_5228_ = (_e775 < (bitcast<i32>(_e777) - 1i));
                    }
                    let _e782 = phi_5228_;
                    if _e782 {
                        let _e783 = targetPos_2;
                        param_677 = _e783;
                        let _e784 = getIndex_u0028_vi3_u003b((&param_677));
                        param_678 = _e784;
                        let _e785 = readCell_u0028_u1_u003b((&param_678));
                        param_679 = _e785;
                        let _e786 = getType_u0028_u1_u003b((&param_679));
                        if (_e786 == 0u) {
                            let _e788 = d_18;
                            param_680 = 2u;
                            param_681 = bitcast<u32>((_e788 + 1i));
                            param_682 = 0u;
                            let _e791 = newAge_2;
                            param_683 = _e791;
                            let _e792 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_680), (&param_681), (&param_682), (&param_683));
                            newValue_3 = _e792;
                            let _e793 = targetPos_2;
                            param_684 = _e793;
                            let _e794 = getIndex_u0028_vi3_u003b((&param_684));
                            let _e795 = (*currentIndex_10);
                            param_685 = _e795;
                            let _e796 = (*rawValue_8);
                            param_686 = _e796;
                            param_687 = _e794;
                            let _e797 = newValue_3;
                            param_688 = _e797;
                            let _e798 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_685), (&param_686), (&param_687), (&param_688));
                            if _e798 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e799 = i_20;
                    i_20 = (_e799 + 1i);
                }
            }
        }
    }
    let _e801 = (*currentSleep_5);
    newSleep_3 = min((_e801 + 1u), 255u);
    param_689 = 2u;
    param_690 = 0u;
    let _e804 = newSleep_3;
    param_691 = _e804;
    let _e805 = newAge_2;
    param_692 = _e805;
    let _e806 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_689), (&param_690), (&param_691), (&param_692));
    sleepValue = _e806;
    let _e807 = (*currentIndex_10);
    let _e810 = (*rawValue_8);
    let _e811 = sleepValue;
    let _e812 = atomicCompareExchangeWeak((&unnamed.grid[_e807]), _e810, _e811);
    return;
}

fn incWater_u0028_() {
    let _e198 = atomicAdd((&unnamed_2.waterVoxelCount), 1u);
    return;
}

fn updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_15: ptr<function, vec3<i32>>, currentIndex_11: ptr<function, u32>, rawValue_9: ptr<function, u32>, currentSleep_6: ptr<function, u32>, currentAge_9: ptr<function, u32>, randVal_11: ptr<function, f32>) {
    var moisture_5: u32;
    var moistureModified_1: bool;
    var startDir_5: i32;
    var i_21: i32;
    var d_19: i32;
    var nPos_8: vec3<i32>;
    var param_693: i32;
    var nIndex_5: u32;
    var param_694: vec3<i32>;
    var nVal_5: u32;
    var param_695: u32;
    var param_696: u32;
    var d_20: i32;
    var nPos_9: vec3<i32>;
    var param_697: i32;
    var nIndex_6: u32;
    var param_698: vec3<i32>;
    var nVal_6: u32;
    var param_699: u32;
    var nType_3: u32;
    var param_700: u32;
    var nMoisture_1: u32;
    var param_701: u32;
    var nCapacity_1: u32;
    var local_26: u32;
    var leakPos: vec3<i32>;
    var param_702: vec3<i32>;
    var param_703: u32;
    var param_704: u32;
    var param_705: vec3<i32>;
    var param_706: u32;
    var param_707: u32;
    var param_708: u32;
    var param_709: u32;
    var canMove_1: bool;
    var param_710: vec3<i32>;
    var isClumped_1: bool;
    var emptyBelowCount_1: i32;
    var x_2: i32;
    var z_2: i32;
    var checkPos_2: vec3<i32>;
    var param_711: vec3<i32>;
    var param_712: u32;
    var param_713: u32;
    var clumpCount_1: i32;
    var x_3: i32;
    var y_1: i32;
    var z_3: i32;
    var nPos_10: vec3<i32>;
    var param_714: vec3<i32>;
    var param_715: u32;
    var param_716: u32;
    var belowPos_8: vec3<i32>;
    var param_717: vec3<i32>;
    var param_718: u32;
    var param_719: u32;
    var param_720: vec3<i32>;
    var param_721: u32;
    var param_722: u32;
    var param_723: u32;
    var param_724: u32;
    var param_725: u32;
    var param_726: u32;
    var param_727: u32;
    var param_728: u32;
    var dir_4: i32;
    var slidePos1_1: vec3<i32>;
    var slidePos2_1: vec3<i32>;
    var param_729: vec3<i32>;
    var param_730: u32;
    var param_731: u32;
    var param_732: vec3<i32>;
    var param_733: u32;
    var param_734: u32;
    var param_735: u32;
    var param_736: u32;
    var param_737: u32;
    var param_738: u32;
    var param_739: u32;
    var param_740: u32;
    var param_741: vec3<i32>;
    var param_742: u32;
    var param_743: u32;
    var param_744: vec3<i32>;
    var param_745: u32;
    var param_746: u32;
    var param_747: u32;
    var param_748: u32;
    var param_749: u32;
    var param_750: u32;
    var param_751: u32;
    var param_752: u32;
    var belowPos_9: vec3<i32>;
    var belowIndex_3: u32;
    var param_753: vec3<i32>;
    var belowValue_3: u32;
    var param_754: u32;
    var param_755: u32;
    var startDir_6: i32;
    var i_22: i32;
    var d_21: i32;
    var pushPos_2: vec3<i32>;
    var param_756: i32;
    var param_757: u32;
    var param_758: u32;
    var param_759: u32;
    var param_760: u32;
    var param_761: vec3<i32>;
    var param_762: u32;
    var param_763: u32;
    var param_764: u32;
    var param_765: u32;
    var param_766: u32;
    var param_767: u32;
    var param_768: u32;
    var param_769: u32;
    var param_770: u32;
    var param_771: u32;
    var param_772: u32;
    var param_773: u32;
    var param_774: u32;
    var dir_5: i32;
    var slidePos_1: array<vec3<i32>, 2>;
    var s_2: i32;
    var sPos_3: vec3<i32>;
    var sIndex_1: u32;
    var param_775: vec3<i32>;
    var sValue_1: u32;
    var param_776: u32;
    var param_777: u32;
    var startDir_7: i32;
    var i_23: i32;
    var d_22: i32;
    var pushPos_3: vec3<i32>;
    var param_778: i32;
    var param_779: u32;
    var param_780: u32;
    var param_781: u32;
    var param_782: u32;
    var param_783: vec3<i32>;
    var param_784: u32;
    var param_785: u32;
    var param_786: u32;
    var param_787: u32;
    var param_788: u32;
    var param_789: u32;
    var param_790: u32;
    var param_791: u32;
    var param_792: u32;
    var param_793: u32;
    var param_794: u32;
    var param_795: u32;
    var param_796: u32;
    var newSleep_4: u32;
    var param_797: u32;
    var param_798: u32;
    var param_799: u32;
    var param_800: u32;
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

    let _e361 = (*currentAge_9);
    moisture_5 = _e361;
    moistureModified_1 = false;
    let _e362 = moisture_5;
    let _e364 = tuning.sandMoistureCapacity;
    if (_e362 < _e364) {
        let _e366 = (*randVal_11);
        startDir_5 = i32((fract((_e366 * 17f)) * 6f));
        i_21 = 0i;
        loop {
            let _e371 = i_21;
            if (_e371 < 6i) {
                let _e373 = startDir_5;
                let _e374 = i_21;
                let _e375 = (_e373 + _e374);
                d_19 = (_e375 - (i32(floor((f32(_e375) / f32(6i)))) * 6i));
                let _e383 = d_19;
                if (_e383 != 2i) {
                    let _e385 = (*pos_15);
                    let _e386 = d_19;
                    param_693 = _e386;
                    let _e387 = getOrthoDir_u0028_i1_u003b((&param_693));
                    nPos_8 = (_e385 + _e387);
                    let _e390 = nPos_8[0u];
                    let _e391 = (_e390 > 0i);
                    phi_2438_ = _e391;
                    if _e391 {
                        let _e393 = nPos_8[0u];
                        let _e395 = tuning.gridWidth;
                        phi_2438_ = (_e393 < (bitcast<i32>(_e395) - 1i));
                    }
                    let _e400 = phi_2438_;
                    phi_2444_ = _e400;
                    if _e400 {
                        let _e402 = nPos_8[1u];
                        phi_2444_ = (_e402 > 0i);
                    }
                    let _e405 = phi_2444_;
                    phi_2454_ = _e405;
                    if _e405 {
                        let _e407 = nPos_8[1u];
                        let _e409 = tuning.gridHeight;
                        phi_2454_ = (_e407 < (bitcast<i32>(_e409) - 1i));
                    }
                    let _e414 = phi_2454_;
                    phi_2460_ = _e414;
                    if _e414 {
                        let _e416 = nPos_8[2u];
                        phi_2460_ = (_e416 > 0i);
                    }
                    let _e419 = phi_2460_;
                    phi_2470_ = _e419;
                    if _e419 {
                        let _e421 = nPos_8[2u];
                        let _e423 = tuning.gridDepth;
                        phi_2470_ = (_e421 < (bitcast<i32>(_e423) - 1i));
                    }
                    let _e428 = phi_2470_;
                    if _e428 {
                        let _e429 = nPos_8;
                        param_694 = _e429;
                        let _e430 = getIndex_u0028_vi3_u003b((&param_694));
                        nIndex_5 = _e430;
                        let _e431 = nIndex_5;
                        param_695 = _e431;
                        let _e432 = readCell_u0028_u1_u003b((&param_695));
                        nVal_5 = _e432;
                        let _e433 = nVal_5;
                        param_696 = _e433;
                        let _e434 = getType_u0028_u1_u003b((&param_696));
                        if (_e434 == 2u) {
                            let _e436 = nIndex_5;
                            let _e439 = nVal_5;
                            let _e440 = atomicCompareExchangeWeak((&unnamed.grid[_e436]), _e439, 0u);
                            let _e442 = nVal_5;
                            if (_e440.old_value == _e442) {
                                let _e444 = (*currentIndex_11);
                                let _e448 = tuning.sandWaterAbsorbUnit;
                                let _e451 = atomicAdd((&unnamed.grid[_e444]), (_e448 << bitcast<u32>(24i)));
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
                let _e452 = i_21;
                i_21 = (_e452 + 1i);
            }
        }
    }
    let _e454 = moistureModified_1;
    let _e456 = moisture_5;
    if (!(_e454) && (_e456 > 0u)) {
        let _e459 = (*randVal_11);
        d_20 = i32((fract((_e459 * 31f)) * 6f));
        let _e464 = d_20;
        if (_e464 != 2i) {
            let _e466 = (*pos_15);
            let _e467 = d_20;
            param_697 = _e467;
            let _e468 = getOrthoDir_u0028_i1_u003b((&param_697));
            nPos_9 = (_e466 + _e468);
            let _e471 = nPos_9[0u];
            let _e472 = (_e471 > 0i);
            phi_2542_ = _e472;
            if _e472 {
                let _e474 = nPos_9[0u];
                let _e476 = tuning.gridWidth;
                phi_2542_ = (_e474 < (bitcast<i32>(_e476) - 1i));
            }
            let _e481 = phi_2542_;
            phi_2548_ = _e481;
            if _e481 {
                let _e483 = nPos_9[1u];
                phi_2548_ = (_e483 > 0i);
            }
            let _e486 = phi_2548_;
            phi_2558_ = _e486;
            if _e486 {
                let _e488 = nPos_9[1u];
                let _e490 = tuning.gridHeight;
                phi_2558_ = (_e488 < (bitcast<i32>(_e490) - 1i));
            }
            let _e495 = phi_2558_;
            phi_2564_ = _e495;
            if _e495 {
                let _e497 = nPos_9[2u];
                phi_2564_ = (_e497 > 0i);
            }
            let _e500 = phi_2564_;
            phi_2574_ = _e500;
            if _e500 {
                let _e502 = nPos_9[2u];
                let _e504 = tuning.gridDepth;
                phi_2574_ = (_e502 < (bitcast<i32>(_e504) - 1i));
            }
            let _e509 = phi_2574_;
            if _e509 {
                let _e510 = nPos_9;
                param_698 = _e510;
                let _e511 = getIndex_u0028_vi3_u003b((&param_698));
                nIndex_6 = _e511;
                let _e512 = nIndex_6;
                param_699 = _e512;
                let _e513 = readCell_u0028_u1_u003b((&param_699));
                nVal_6 = _e513;
                let _e514 = nVal_6;
                param_700 = _e514;
                let _e515 = getType_u0028_u1_u003b((&param_700));
                nType_3 = _e515;
                let _e516 = nType_3;
                let _e518 = nType_3;
                if ((_e516 == 1u) || (_e518 == 4u)) {
                    let _e521 = nVal_6;
                    param_701 = _e521;
                    let _e522 = getAge_u0028_u1_u003b((&param_701));
                    nMoisture_1 = _e522;
                    let _e523 = nType_3;
                    if (_e523 == 4u) {
                        let _e526 = tuning.dirtMoistureCapacity;
                        local_26 = _e526;
                    } else {
                        let _e528 = tuning.sandMoistureCapacity;
                        local_26 = _e528;
                    }
                    let _e529 = local_26;
                    nCapacity_1 = _e529;
                    let _e530 = moisture_5;
                    let _e531 = nMoisture_1;
                    let _e534 = nMoisture_1;
                    let _e535 = nCapacity_1;
                    if ((_e530 > (_e531 + 1u)) && (_e534 < _e535)) {
                        let _e538 = (*currentIndex_11);
                        let _e541 = atomicAdd((&unnamed.grid[_e538]), 4278190080u);
                        let _e542 = nIndex_6;
                        let _e545 = atomicAdd((&unnamed.grid[_e542]), 16777216u);
                        moistureModified_1 = true;
                    }
                }
            }
        }
    }
    let _e546 = moistureModified_1;
    let _e547 = !(_e546);
    phi_2639_ = _e547;
    if _e547 {
        let _e548 = moisture_5;
        let _e550 = tuning.sandWaterAbsorbUnit;
        phi_2639_ = (_e548 >= _e550);
    }
    let _e553 = phi_2639_;
    if _e553 {
        let _e554 = (*pos_15);
        leakPos = (_e554 + vec3<i32>(0i, -1i, 0i));
        let _e557 = leakPos[1u];
        let _e558 = (_e557 > 0i);
        phi_2658_ = _e558;
        if _e558 {
            let _e559 = leakPos;
            param_702 = _e559;
            let _e560 = getIndex_u0028_vi3_u003b((&param_702));
            param_703 = _e560;
            let _e561 = readCell_u0028_u1_u003b((&param_703));
            param_704 = _e561;
            let _e562 = getType_u0028_u1_u003b((&param_704));
            phi_2658_ = (_e562 == 0u);
        }
        let _e565 = phi_2658_;
        if _e565 {
            let _e566 = leakPos;
            param_705 = _e566;
            let _e567 = getIndex_u0028_vi3_u003b((&param_705));
            param_706 = 2u;
            param_707 = 0u;
            param_708 = 0u;
            param_709 = 0u;
            let _e570 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_706), (&param_707), (&param_708), (&param_709));
            let _e571 = atomicCompareExchangeWeak((&unnamed.grid[_e567]), 0u, _e570);
            if (_e571.old_value == 0u) {
                let _e574 = (*currentIndex_11);
                let _e578 = tuning.sandWaterAbsorbUnit;
                let _e582 = atomicAdd((&unnamed.grid[_e574]), ((0u - _e578) << bitcast<u32>(24i)));
                incWater_u0028_();
                moistureModified_1 = true;
            }
        }
    }
    let _e583 = moistureModified_1;
    if _e583 {
        return;
    }
    let _e584 = (*pos_15);
    param_710 = _e584;
    let _e585 = grainCanMove_u0028_vi3_u003b((&param_710));
    canMove_1 = _e585;
    isClumped_1 = false;
    let _e586 = canMove_1;
    let _e587 = moisture_5;
    let _e589 = (_e586 && (_e587 > 0u));
    phi_2702_ = _e589;
    if _e589 {
        let _e590 = (*currentSleep_6);
        let _e592 = tuning.wakeSleepThreshold;
        phi_2702_ = (_e590 > _e592);
    }
    let _e595 = phi_2702_;
    if _e595 {
        emptyBelowCount_1 = 0i;
        let _e597 = (*pos_15)[1u];
        if (_e597 > 1i) {
            x_2 = -1i;
            loop {
                let _e599 = x_2;
                if (_e599 <= 1i) {
                    z_2 = -1i;
                    loop {
                        let _e601 = z_2;
                        if (_e601 <= 1i) {
                            let _e603 = (*pos_15);
                            let _e604 = x_2;
                            let _e605 = z_2;
                            checkPos_2 = (_e603 + vec3<i32>(_e604, -1i, _e605));
                            let _e609 = checkPos_2[0u];
                            let _e610 = (_e609 >= 0i);
                            phi_2744_ = _e610;
                            if _e610 {
                                let _e612 = checkPos_2[0u];
                                let _e614 = tuning.gridWidth;
                                phi_2744_ = (_e612 < bitcast<i32>(_e614));
                            }
                            let _e618 = phi_2744_;
                            phi_2750_ = _e618;
                            if _e618 {
                                let _e620 = checkPos_2[2u];
                                phi_2750_ = (_e620 >= 0i);
                            }
                            let _e623 = phi_2750_;
                            phi_2759_ = _e623;
                            if _e623 {
                                let _e625 = checkPos_2[2u];
                                let _e627 = tuning.gridDepth;
                                phi_2759_ = (_e625 < bitcast<i32>(_e627));
                            }
                            let _e631 = phi_2759_;
                            if _e631 {
                                let _e632 = checkPos_2;
                                param_711 = _e632;
                                let _e633 = getIndex_u0028_vi3_u003b((&param_711));
                                param_712 = _e633;
                                let _e634 = readCell_u0028_u1_u003b((&param_712));
                                param_713 = _e634;
                                let _e635 = getType_u0028_u1_u003b((&param_713));
                                if (_e635 == 0u) {
                                    let _e637 = emptyBelowCount_1;
                                    emptyBelowCount_1 = (_e637 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e639 = z_2;
                            z_2 = (_e639 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e641 = x_2;
                    x_2 = (_e641 + 1i);
                }
            }
        }
        let _e643 = emptyBelowCount_1;
        let _e645 = tuning.emptyBelowWakeCount;
        if (_e643 >= bitcast<i32>(_e645)) {
            (*currentSleep_6) = 0u;
        } else {
            clumpCount_1 = 0i;
            x_3 = -1i;
            loop {
                let _e648 = x_3;
                if (_e648 <= 1i) {
                    y_1 = -1i;
                    loop {
                        let _e650 = y_1;
                        if (_e650 <= 1i) {
                            z_3 = -1i;
                            loop {
                                let _e652 = z_3;
                                if (_e652 <= 1i) {
                                    let _e654 = x_3;
                                    let _e656 = y_1;
                                    let _e659 = z_3;
                                    if (((_e654 == 0i) && (_e656 == 0i)) && (_e659 == 0i)) {
                                        continue;
                                    }
                                    let _e662 = (*pos_15);
                                    let _e663 = x_3;
                                    let _e664 = y_1;
                                    let _e665 = z_3;
                                    nPos_10 = (_e662 + vec3<i32>(_e663, _e664, _e665));
                                    let _e669 = nPos_10[0u];
                                    let _e670 = (_e669 >= 0i);
                                    phi_2841_ = _e670;
                                    if _e670 {
                                        let _e672 = nPos_10[0u];
                                        let _e674 = tuning.gridWidth;
                                        phi_2841_ = (_e672 < bitcast<i32>(_e674));
                                    }
                                    let _e678 = phi_2841_;
                                    phi_2847_ = _e678;
                                    if _e678 {
                                        let _e680 = nPos_10[1u];
                                        phi_2847_ = (_e680 >= 0i);
                                    }
                                    let _e683 = phi_2847_;
                                    phi_2856_ = _e683;
                                    if _e683 {
                                        let _e685 = nPos_10[1u];
                                        let _e687 = tuning.gridHeight;
                                        phi_2856_ = (_e685 < bitcast<i32>(_e687));
                                    }
                                    let _e691 = phi_2856_;
                                    phi_2862_ = _e691;
                                    if _e691 {
                                        let _e693 = nPos_10[2u];
                                        phi_2862_ = (_e693 >= 0i);
                                    }
                                    let _e696 = phi_2862_;
                                    phi_2871_ = _e696;
                                    if _e696 {
                                        let _e698 = nPos_10[2u];
                                        let _e700 = tuning.gridDepth;
                                        phi_2871_ = (_e698 < bitcast<i32>(_e700));
                                    }
                                    let _e704 = phi_2871_;
                                    if _e704 {
                                        let _e705 = nPos_10;
                                        param_714 = _e705;
                                        let _e706 = getIndex_u0028_vi3_u003b((&param_714));
                                        param_715 = _e706;
                                        let _e707 = readCell_u0028_u1_u003b((&param_715));
                                        param_716 = _e707;
                                        let _e708 = getType_u0028_u1_u003b((&param_716));
                                        if (_e708 == 1u) {
                                            let _e710 = clumpCount_1;
                                            clumpCount_1 = (_e710 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e712 = z_3;
                                    z_3 = (_e712 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e714 = y_1;
                            y_1 = (_e714 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e716 = x_3;
                    x_3 = (_e716 + 1i);
                }
            }
            let _e718 = clumpCount_1;
            let _e720 = tuning.sandClumpThreshold;
            if (_e718 >= bitcast<i32>(_e720)) {
                isClumped_1 = true;
            }
        }
    }
    let _e723 = canMove_1;
    let _e724 = isClumped_1;
    if (_e723 && !(_e724)) {
        let _e728 = (*pos_15)[1u];
        if (_e728 > 1i) {
            let _e730 = (*pos_15);
            belowPos_8 = (_e730 + vec3<i32>(0i, -1i, 0i));
            let _e732 = belowPos_8;
            param_717 = _e732;
            let _e733 = getIndex_u0028_vi3_u003b((&param_717));
            param_718 = _e733;
            let _e734 = readCell_u0028_u1_u003b((&param_718));
            param_719 = _e734;
            let _e735 = getType_u0028_u1_u003b((&param_719));
            if (_e735 == 0u) {
                let _e737 = belowPos_8;
                param_720 = _e737;
                let _e738 = getIndex_u0028_vi3_u003b((&param_720));
                param_721 = 1u;
                param_722 = 0u;
                param_723 = 0u;
                let _e739 = moisture_5;
                param_724 = _e739;
                let _e740 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_721), (&param_722), (&param_723), (&param_724));
                let _e741 = (*currentIndex_11);
                param_725 = _e741;
                let _e742 = (*rawValue_9);
                param_726 = _e742;
                param_727 = _e738;
                param_728 = _e740;
                let _e743 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_725), (&param_726), (&param_727), (&param_728));
                if _e743 {
                    return;
                }
            }
        }
        let _e745 = (*pos_15)[1u];
        if (_e745 > 1i) {
            let _e747 = (*randVal_11);
            dir_4 = select(-1i, 1i, (fract((_e747 * 10f)) > 0.5f));
            let _e752 = (*randVal_11);
            if (fract((_e752 * 100f)) > 0.5f) {
                let _e756 = (*pos_15);
                let _e757 = dir_4;
                slidePos1_1 = (_e756 + vec3<i32>(_e757, -1i, 0i));
                let _e760 = (*pos_15);
                let _e761 = dir_4;
                slidePos2_1 = (_e760 + vec3<i32>(0i, -1i, _e761));
            } else {
                let _e764 = (*pos_15);
                let _e765 = dir_4;
                slidePos1_1 = (_e764 + vec3<i32>(0i, -1i, _e765));
                let _e768 = (*pos_15);
                let _e769 = dir_4;
                slidePos2_1 = (_e768 + vec3<i32>(_e769, -1i, 0i));
            }
            let _e773 = slidePos1_1[0u];
            let _e774 = (_e773 > 0i);
            phi_2993_ = _e774;
            if _e774 {
                let _e776 = slidePos1_1[0u];
                let _e778 = tuning.gridWidth;
                phi_2993_ = (_e776 < (bitcast<i32>(_e778) - 1i));
            }
            let _e783 = phi_2993_;
            phi_2999_ = _e783;
            if _e783 {
                let _e785 = slidePos1_1[2u];
                phi_2999_ = (_e785 > 0i);
            }
            let _e788 = phi_2999_;
            phi_3009_ = _e788;
            if _e788 {
                let _e790 = slidePos1_1[2u];
                let _e792 = tuning.gridDepth;
                phi_3009_ = (_e790 < (bitcast<i32>(_e792) - 1i));
            }
            let _e797 = phi_3009_;
            if _e797 {
                let _e798 = slidePos1_1;
                param_729 = _e798;
                let _e799 = getIndex_u0028_vi3_u003b((&param_729));
                param_730 = _e799;
                let _e800 = readCell_u0028_u1_u003b((&param_730));
                param_731 = _e800;
                let _e801 = getType_u0028_u1_u003b((&param_731));
                if (_e801 == 0u) {
                    let _e803 = slidePos1_1;
                    param_732 = _e803;
                    let _e804 = getIndex_u0028_vi3_u003b((&param_732));
                    param_733 = 1u;
                    param_734 = 0u;
                    param_735 = 0u;
                    let _e805 = moisture_5;
                    param_736 = _e805;
                    let _e806 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_733), (&param_734), (&param_735), (&param_736));
                    let _e807 = (*currentIndex_11);
                    param_737 = _e807;
                    let _e808 = (*rawValue_9);
                    param_738 = _e808;
                    param_739 = _e804;
                    param_740 = _e806;
                    let _e809 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_737), (&param_738), (&param_739), (&param_740));
                    if _e809 {
                        return;
                    }
                }
            }
            let _e811 = slidePos2_1[0u];
            let _e812 = (_e811 > 0i);
            phi_3053_ = _e812;
            if _e812 {
                let _e814 = slidePos2_1[0u];
                let _e816 = tuning.gridWidth;
                phi_3053_ = (_e814 < (bitcast<i32>(_e816) - 1i));
            }
            let _e821 = phi_3053_;
            phi_3059_ = _e821;
            if _e821 {
                let _e823 = slidePos2_1[2u];
                phi_3059_ = (_e823 > 0i);
            }
            let _e826 = phi_3059_;
            phi_3069_ = _e826;
            if _e826 {
                let _e828 = slidePos2_1[2u];
                let _e830 = tuning.gridDepth;
                phi_3069_ = (_e828 < (bitcast<i32>(_e830) - 1i));
            }
            let _e835 = phi_3069_;
            if _e835 {
                let _e836 = slidePos2_1;
                param_741 = _e836;
                let _e837 = getIndex_u0028_vi3_u003b((&param_741));
                param_742 = _e837;
                let _e838 = readCell_u0028_u1_u003b((&param_742));
                param_743 = _e838;
                let _e839 = getType_u0028_u1_u003b((&param_743));
                if (_e839 == 0u) {
                    let _e841 = slidePos2_1;
                    param_744 = _e841;
                    let _e842 = getIndex_u0028_vi3_u003b((&param_744));
                    param_745 = 1u;
                    param_746 = 0u;
                    param_747 = 0u;
                    let _e843 = moisture_5;
                    param_748 = _e843;
                    let _e844 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_745), (&param_746), (&param_747), (&param_748));
                    let _e845 = (*currentIndex_11);
                    param_749 = _e845;
                    let _e846 = (*rawValue_9);
                    param_750 = _e846;
                    param_751 = _e842;
                    param_752 = _e844;
                    let _e847 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_749), (&param_750), (&param_751), (&param_752));
                    if _e847 {
                        return;
                    }
                }
            }
        }
        let _e849 = (*pos_15)[1u];
        if (_e849 > 1i) {
            let _e851 = (*pos_15);
            belowPos_9 = (_e851 + vec3<i32>(0i, -1i, 0i));
            let _e853 = belowPos_9;
            param_753 = _e853;
            let _e854 = getIndex_u0028_vi3_u003b((&param_753));
            belowIndex_3 = _e854;
            let _e855 = belowIndex_3;
            param_754 = _e855;
            let _e856 = readCell_u0028_u1_u003b((&param_754));
            belowValue_3 = _e856;
            let _e857 = belowValue_3;
            param_755 = _e857;
            let _e858 = getType_u0028_u1_u003b((&param_755));
            if (_e858 == 2u) {
                let _e860 = (*randVal_11);
                startDir_6 = i32((fract((_e860 * 8f)) * 8f));
                i_22 = 0i;
                loop {
                    let _e865 = i_22;
                    if (_e865 < 8i) {
                        let _e867 = startDir_6;
                        let _e868 = i_22;
                        let _e869 = (_e867 + _e868);
                        d_21 = (_e869 - (i32(floor((f32(_e869) / f32(8i)))) * 8i));
                        let _e877 = belowPos_9;
                        let _e878 = d_21;
                        param_756 = _e878;
                        let _e879 = getHDir_u0028_i1_u003b((&param_756));
                        pushPos_2 = (_e877 + _e879);
                        let _e882 = pushPos_2[0u];
                        let _e883 = (_e882 > 0i);
                        phi_3161_ = _e883;
                        if _e883 {
                            let _e885 = pushPos_2[0u];
                            let _e887 = tuning.gridWidth;
                            phi_3161_ = (_e885 < (bitcast<i32>(_e887) - 1i));
                        }
                        let _e892 = phi_3161_;
                        phi_3167_ = _e892;
                        if _e892 {
                            let _e894 = pushPos_2[2u];
                            phi_3167_ = (_e894 > 0i);
                        }
                        let _e897 = phi_3167_;
                        phi_3177_ = _e897;
                        if _e897 {
                            let _e899 = pushPos_2[2u];
                            let _e901 = tuning.gridDepth;
                            phi_3177_ = (_e899 < (bitcast<i32>(_e901) - 1i));
                        }
                        let _e906 = phi_3177_;
                        if _e906 {
                            param_757 = 1u;
                            param_758 = 0u;
                            param_759 = 0u;
                            let _e907 = moisture_5;
                            param_760 = _e907;
                            let _e908 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_757), (&param_758), (&param_759), (&param_760));
                            let _e909 = pushPos_2;
                            param_761 = _e909;
                            let _e910 = getIndex_u0028_vi3_u003b((&param_761));
                            let _e911 = (*currentIndex_11);
                            param_762 = _e911;
                            param_763 = _e908;
                            let _e912 = belowIndex_3;
                            param_764 = _e912;
                            let _e913 = belowValue_3;
                            param_765 = _e913;
                            param_766 = _e910;
                            let _e914 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_762), (&param_763), (&param_764), (&param_765), (&param_766));
                            if _e914 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e915 = i_22;
                        i_22 = (_e915 + 1i);
                    }
                }
                param_767 = 1u;
                param_768 = 0u;
                param_769 = 0u;
                let _e917 = moisture_5;
                param_770 = _e917;
                let _e918 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_767), (&param_768), (&param_769), (&param_770));
                let _e919 = (*currentIndex_11);
                param_771 = _e919;
                let _e920 = (*rawValue_9);
                param_772 = _e920;
                let _e921 = belowIndex_3;
                param_773 = _e921;
                param_774 = _e918;
                let _e922 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_771), (&param_772), (&param_773), (&param_774));
                if _e922 {
                    return;
                }
            }
            let _e923 = (*randVal_11);
            dir_5 = select(-1i, 1i, (fract((_e923 * 10f)) > 0.5f));
            let _e928 = (*randVal_11);
            if (fract((_e928 * 100f)) > 0.5f) {
                let _e932 = (*pos_15);
                let _e933 = dir_5;
                slidePos_1[0i] = (_e932 + vec3<i32>(_e933, -1i, 0i));
                let _e937 = (*pos_15);
                let _e938 = dir_5;
                slidePos_1[1i] = (_e937 + vec3<i32>(0i, -1i, _e938));
            } else {
                let _e942 = (*pos_15);
                let _e943 = dir_5;
                slidePos_1[0i] = (_e942 + vec3<i32>(0i, -1i, _e943));
                let _e947 = (*pos_15);
                let _e948 = dir_5;
                slidePos_1[1i] = (_e947 + vec3<i32>(_e948, -1i, 0i));
            }
            s_2 = 0i;
            loop {
                let _e952 = s_2;
                if (_e952 < 2i) {
                    let _e954 = s_2;
                    let _e956 = slidePos_1[_e954];
                    sPos_3 = _e956;
                    let _e958 = sPos_3[0u];
                    let _e959 = (_e958 > 0i);
                    phi_3280_ = _e959;
                    if _e959 {
                        let _e961 = sPos_3[0u];
                        let _e963 = tuning.gridWidth;
                        phi_3280_ = (_e961 < (bitcast<i32>(_e963) - 1i));
                    }
                    let _e968 = phi_3280_;
                    phi_3286_ = _e968;
                    if _e968 {
                        let _e970 = sPos_3[2u];
                        phi_3286_ = (_e970 > 0i);
                    }
                    let _e973 = phi_3286_;
                    phi_3296_ = _e973;
                    if _e973 {
                        let _e975 = sPos_3[2u];
                        let _e977 = tuning.gridDepth;
                        phi_3296_ = (_e975 < (bitcast<i32>(_e977) - 1i));
                    }
                    let _e982 = phi_3296_;
                    if _e982 {
                        let _e983 = sPos_3;
                        param_775 = _e983;
                        let _e984 = getIndex_u0028_vi3_u003b((&param_775));
                        sIndex_1 = _e984;
                        let _e985 = sIndex_1;
                        param_776 = _e985;
                        let _e986 = readCell_u0028_u1_u003b((&param_776));
                        sValue_1 = _e986;
                        let _e987 = sValue_1;
                        param_777 = _e987;
                        let _e988 = getType_u0028_u1_u003b((&param_777));
                        if (_e988 == 2u) {
                            let _e990 = (*randVal_11);
                            let _e992 = s_2;
                            startDir_7 = i32((fract(((_e990 * 8f) + f32(_e992))) * 8f));
                            i_23 = 0i;
                            loop {
                                let _e998 = i_23;
                                if (_e998 < 8i) {
                                    let _e1000 = startDir_7;
                                    let _e1001 = i_23;
                                    let _e1002 = (_e1000 + _e1001);
                                    d_22 = (_e1002 - (i32(floor((f32(_e1002) / f32(8i)))) * 8i));
                                    let _e1010 = sPos_3;
                                    let _e1011 = d_22;
                                    param_778 = _e1011;
                                    let _e1012 = getHDir_u0028_i1_u003b((&param_778));
                                    pushPos_3 = (_e1010 + _e1012);
                                    let _e1015 = pushPos_3[0u];
                                    let _e1016 = (_e1015 > 0i);
                                    phi_3353_ = _e1016;
                                    if _e1016 {
                                        let _e1018 = pushPos_3[0u];
                                        let _e1020 = tuning.gridWidth;
                                        phi_3353_ = (_e1018 < (bitcast<i32>(_e1020) - 1i));
                                    }
                                    let _e1025 = phi_3353_;
                                    phi_3359_ = _e1025;
                                    if _e1025 {
                                        let _e1027 = pushPos_3[2u];
                                        phi_3359_ = (_e1027 > 0i);
                                    }
                                    let _e1030 = phi_3359_;
                                    phi_3369_ = _e1030;
                                    if _e1030 {
                                        let _e1032 = pushPos_3[2u];
                                        let _e1034 = tuning.gridDepth;
                                        phi_3369_ = (_e1032 < (bitcast<i32>(_e1034) - 1i));
                                    }
                                    let _e1039 = phi_3369_;
                                    if _e1039 {
                                        param_779 = 1u;
                                        param_780 = 0u;
                                        param_781 = 0u;
                                        let _e1040 = moisture_5;
                                        param_782 = _e1040;
                                        let _e1041 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_779), (&param_780), (&param_781), (&param_782));
                                        let _e1042 = pushPos_3;
                                        param_783 = _e1042;
                                        let _e1043 = getIndex_u0028_vi3_u003b((&param_783));
                                        let _e1044 = (*currentIndex_11);
                                        param_784 = _e1044;
                                        param_785 = _e1041;
                                        let _e1045 = sIndex_1;
                                        param_786 = _e1045;
                                        let _e1046 = sValue_1;
                                        param_787 = _e1046;
                                        param_788 = _e1043;
                                        let _e1047 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_784), (&param_785), (&param_786), (&param_787), (&param_788));
                                        if _e1047 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1048 = i_23;
                                    i_23 = (_e1048 + 1i);
                                }
                            }
                            param_789 = 1u;
                            param_790 = 0u;
                            param_791 = 0u;
                            let _e1050 = moisture_5;
                            param_792 = _e1050;
                            let _e1051 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_789), (&param_790), (&param_791), (&param_792));
                            let _e1052 = (*currentIndex_11);
                            param_793 = _e1052;
                            let _e1053 = (*rawValue_9);
                            param_794 = _e1053;
                            let _e1054 = sIndex_1;
                            param_795 = _e1054;
                            param_796 = _e1051;
                            let _e1055 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_793), (&param_794), (&param_795), (&param_796));
                            if _e1055 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1056 = s_2;
                    s_2 = (_e1056 + 1i);
                }
            }
        }
    }
    let _e1058 = (*currentSleep_6);
    newSleep_4 = min((_e1058 + 1u), 255u);
    let _e1061 = (*currentIndex_11);
    let _e1064 = (*rawValue_9);
    param_797 = 1u;
    param_798 = 0u;
    let _e1065 = newSleep_4;
    param_799 = _e1065;
    let _e1066 = moisture_5;
    param_800 = _e1066;
    let _e1067 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_797), (&param_798), (&param_799), (&param_800));
    let _e1068 = atomicCompareExchangeWeak((&unnamed.grid[_e1061]), _e1064, _e1067);
    return;
}

fn orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b(pos_16: ptr<function, vec3<i32>>, currentIndex_12: ptr<function, u32>, rawValue_10: ptr<function, u32>, stepDir: ptr<function, vec3<i32>>) -> bool {
    var target_3: vec3<i32>;
    var targetIndex_3: u32;
    var param_801: vec3<i32>;
    var param_802: u32;
    var param_803: u32;
    var param_804: u32;
    var param_805: u32;
    var param_806: u32;
    var param_807: u32;
    var param_808: u32;
    var param_809: u32;
    var param_810: u32;
    var param_811: u32;
    var param_812: u32;
    var param_813: u32;
    var param_814: u32;
    var phi_1758_: bool;
    var phi_1765_: bool;
    var phi_1776_: bool;
    var phi_1783_: bool;
    var phi_1794_: bool;

    let _e217 = (*stepDir);
    if all((_e217 == vec3<i32>(0i, 0i, 0i))) {
        return false;
    }
    let _e220 = (*pos_16);
    let _e221 = (*stepDir);
    target_3 = (_e220 + _e221);
    let _e224 = target_3[0u];
    let _e225 = (_e224 < 1i);
    phi_1758_ = _e225;
    if !(_e225) {
        let _e228 = target_3[0u];
        let _e230 = tuning.gridWidth;
        phi_1758_ = (_e228 >= (bitcast<i32>(_e230) - 1i));
    }
    let _e235 = phi_1758_;
    phi_1765_ = _e235;
    if !(_e235) {
        let _e238 = target_3[1u];
        phi_1765_ = (_e238 < 1i);
    }
    let _e241 = phi_1765_;
    phi_1776_ = _e241;
    if !(_e241) {
        let _e244 = target_3[1u];
        let _e246 = tuning.gridHeight;
        phi_1776_ = (_e244 >= (bitcast<i32>(_e246) - 1i));
    }
    let _e251 = phi_1776_;
    phi_1783_ = _e251;
    if !(_e251) {
        let _e254 = target_3[2u];
        phi_1783_ = (_e254 < 1i);
    }
    let _e257 = phi_1783_;
    phi_1794_ = _e257;
    if !(_e257) {
        let _e260 = target_3[2u];
        let _e262 = tuning.gridDepth;
        phi_1794_ = (_e260 >= (bitcast<i32>(_e262) - 1i));
    }
    let _e267 = phi_1794_;
    if _e267 {
        return false;
    }
    let _e268 = target_3;
    param_801 = _e268;
    let _e269 = getIndex_u0028_vi3_u003b((&param_801));
    targetIndex_3 = _e269;
    let _e270 = targetIndex_3;
    param_802 = _e270;
    let _e271 = readCell_u0028_u1_u003b((&param_802));
    param_803 = _e271;
    let _e272 = getType_u0028_u1_u003b((&param_803));
    if (_e272 != 0u) {
        return false;
    }
    let _e274 = (*rawValue_10);
    param_804 = _e274;
    let _e275 = getType_u0028_u1_u003b((&param_804));
    let _e276 = (*rawValue_10);
    param_805 = _e276;
    let _e277 = getDir_u0028_u1_u003b((&param_805));
    let _e278 = (*rawValue_10);
    param_806 = _e278;
    let _e279 = getAge_u0028_u1_u003b((&param_806));
    param_807 = _e275;
    param_808 = _e277;
    param_809 = 0u;
    param_810 = _e279;
    let _e280 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_807), (&param_808), (&param_809), (&param_810));
    let _e281 = (*currentIndex_12);
    param_811 = _e281;
    let _e282 = (*rawValue_10);
    param_812 = _e282;
    let _e283 = targetIndex_3;
    param_813 = _e283;
    param_814 = _e280;
    let _e284 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_811), (&param_812), (&param_813), (&param_814));
    return _e284;
}

fn dominantAxis_u0028_vf3_u003b_f1_u003b(dir_6: ptr<function, vec3<f32>>, relative: ptr<function, f32>) -> vec3<i32> {
    var a: vec3<f32>;
    var m: f32;

    let _e201 = (*dir_6);
    a = abs(_e201);
    let _e204 = a[0u];
    let _e206 = a[1u];
    let _e208 = a[2u];
    m = max(_e204, max(_e206, _e208));
    let _e211 = m;
    if (_e211 <= 0f) {
        return vec3<i32>(0i, 0i, 0i);
    }
    let _e213 = a;
    let _e214 = m;
    let _e215 = (*relative);
    let _e220 = (*dir_6);
    return (select(vec3<i32>(0i, 0i, 0i), vec3<i32>(1i, 1i, 1i), (_e213 >= vec3((_e214 * _e215)))) * vec3<i32>(sign(_e220)));
}

fn bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b(k_1: ptr<function, i32>, planeCount: ptr<function, i32>, seed: ptr<function, f32>) -> vec3<f32> {
    var z_4: f32;
    var r_4: f32;
    var a_1: f32;

    let _e203 = (*k_1);
    let _e206 = (*planeCount);
    z_4 = ((f32(_e203) + 0.5f) / f32(_e206));
    let _e209 = z_4;
    let _e210 = z_4;
    r_4 = sqrt(max(0f, (1f - (_e209 * _e210))));
    let _e215 = (*k_1);
    let _e218 = (*seed);
    a_1 = ((2.399963f * f32(_e215)) + _e218);
    let _e220 = r_4;
    let _e221 = a_1;
    let _e224 = z_4;
    let _e225 = r_4;
    let _e226 = a_1;
    return vec3<f32>((_e220 * cos(_e221)), _e224, (_e225 * sin(_e226)));
}

fn hash_u0028_vf3_u003b(p_4: ptr<function, vec3<f32>>) -> f32 {
    let _e198 = (*p_4);
    return fract((sin(dot(_e198, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn bhOrbitAxis_u0028_vi3_u003b_vi3_u003b(center: ptr<function, vec3<i32>>, pos_17: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radial: vec3<f32>;
    var planeCount_1: i32;
    var seed_1: f32;
    var param_815: vec3<f32>;
    var best: vec3<f32>;
    var bestAlign: f32;
    var bestK: i32;
    var k_2: i32;
    var n_2: vec3<f32>;
    var param_816: i32;
    var param_817: i32;
    var param_818: f32;
    var align: f32;
    var sense: f32;
    var param_819: vec3<f32>;

    let _e214 = (*pos_17);
    let _e215 = (*center);
    radial = normalize(vec3<f32>((_e214 - _e215)));
    let _e220 = tuning.blackHoleOrbitPlanes;
    planeCount_1 = bitcast<i32>(clamp(_e220, 1u, 32u));
    let _e223 = (*center);
    param_815 = (vec3<f32>(_e223) + vec3<f32>(29f, 3f, 71f));
    let _e226 = hash_u0028_vf3_u003b((&param_815));
    seed_1 = (_e226 * 6.28318f);
    best = vec3<f32>(0f, 1f, 0f);
    bestAlign = 2f;
    bestK = 0i;
    k_2 = 0i;
    loop {
        let _e228 = k_2;
        let _e229 = planeCount_1;
        if (_e228 < _e229) {
            let _e231 = k_2;
            param_816 = _e231;
            let _e232 = planeCount_1;
            param_817 = _e232;
            let _e233 = seed_1;
            param_818 = _e233;
            let _e234 = bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b((&param_816), (&param_817), (&param_818));
            n_2 = _e234;
            let _e235 = n_2;
            let _e236 = radial;
            align = abs(dot(_e235, _e236));
            let _e239 = align;
            let _e240 = bestAlign;
            if (_e239 < _e240) {
                let _e242 = align;
                bestAlign = _e242;
                let _e243 = n_2;
                best = _e243;
                let _e244 = k_2;
                bestK = _e244;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e245 = k_2;
            k_2 = (_e245 + 1i);
        }
    }
    let _e247 = (*center);
    let _e249 = bestK;
    param_819 = (vec3<f32>(_e247) + vec3<f32>((f32(_e249) * 13f), 101f, 47f));
    let _e254 = hash_u0028_vf3_u003b((&param_819));
    sense = select(1f, -1f, (_e254 < 0.5f));
    let _e257 = best;
    let _e258 = sense;
    return (_e257 * _e258);
}

fn bhIsPurge_u0028_u1_u003b(code: ptr<function, u32>) -> bool {
    let _e198 = (*code);
    return ((_e198 & 1073741824u) != 0u);
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e198 = (*level);
    return (f32(_e198) + 0.5f);
}

fn updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b(pos_18: ptr<function, vec3<i32>>, currentIndex_13: ptr<function, u32>, rawValue_11: ptr<function, u32>, center_1: ptr<function, vec3<i32>>, slot: ptr<function, i32>, level_1: ptr<function, u32>, purge: ptr<function, bool>, dist_1: ptr<function, f32>, randVal_12: ptr<function, f32>) {
    var type_37: u32;
    var param_820: u32;
    var sleep_1: u32;
    var param_821: u32;
    var param_822: u32;
    var param_823: u32;
    var orbitSpeed: f32;
    var local_27: f32;
    var infallChance: f32;
    var local_28: f32;
    var param_824: u32;
    var param_825: u32;
    var param_826: u32;
    var param_827: u32;
    var param_828: u32;
    var param_829: u32;
    var inward: vec3<f32>;
    var axis: vec3<f32>;
    var param_830: vec3<i32>;
    var param_831: vec3<i32>;
    var tangent: vec3<f32>;
    var tangentLen: f32;
    var axial: f32;
    var grip: vec3<f32>;
    var along: vec3<f32>;
    var pullIn: bool;
    var spiral: vec3<f32>;
    var param_832: vec3<f32>;
    var param_833: f32;
    var param_834: vec3<i32>;
    var param_835: u32;
    var param_836: u32;
    var param_837: vec3<i32>;
    var param_838: vec3<f32>;
    var param_839: f32;
    var param_840: vec3<i32>;
    var param_841: u32;
    var param_842: u32;
    var param_843: vec3<i32>;
    var param_844: vec3<f32>;
    var param_845: f32;
    var param_846: vec3<i32>;
    var param_847: u32;
    var param_848: u32;
    var param_849: vec3<i32>;
    var param_850: vec3<f32>;
    var param_851: f32;
    var param_852: vec3<i32>;
    var param_853: u32;
    var param_854: u32;
    var param_855: vec3<i32>;
    var param_856: vec3<f32>;
    var param_857: f32;
    var param_858: vec3<i32>;
    var param_859: u32;
    var param_860: u32;
    var param_861: vec3<i32>;
    var param_862: vec3<f32>;
    var param_863: f32;
    var param_864: vec3<i32>;
    var param_865: u32;
    var param_866: u32;
    var param_867: vec3<i32>;
    var param_868: u32;
    var param_869: u32;
    var param_870: u32;
    var param_871: u32;
    var param_872: u32;
    var param_873: u32;
    var phi_2057_: bool;

    let _e275 = (*rawValue_11);
    param_820 = _e275;
    let _e276 = getType_u0028_u1_u003b((&param_820));
    type_37 = _e276;
    let _e277 = (*rawValue_11);
    param_821 = _e277;
    let _e278 = getSleep_u0028_u1_u003b((&param_821));
    sleep_1 = _e278;
    let _e279 = (*slot);
    unnamed_2.blackHoleStarve[_e279] = 0u;
    let _e282 = (*dist_1);
    let _e283 = (*level_1);
    param_822 = _e283;
    let _e284 = bhBodyRadius_u0028_u1_u003b((&param_822));
    let _e286 = tuning.blackHoleHorizon;
    if (_e282 <= (_e284 + f32(_e286))) {
        let _e290 = (*currentIndex_13);
        let _e293 = (*rawValue_11);
        let _e294 = atomicCompareExchangeWeak((&unnamed.grid[_e290]), _e293, 0u);
        let _e296 = (*rawValue_11);
        if (_e294.old_value == _e296) {
            let _e298 = (*slot);
            let _e301 = atomicLoad((&unnamed_2.blackHoles[_e298]));
            param_823 = _e301;
            let _e302 = bhIsPurge_u0028_u1_u003b((&param_823));
            if !(_e302) {
                let _e304 = (*slot);
                let _e307 = atomicAdd((&unnamed_2.blackHoleMass[_e304]), 1u);
            }
            let _e308 = type_37;
            if (_e308 == 2u) {
                decWater_u0028_();
            }
        }
        return;
    }
    let _e310 = (*purge);
    if _e310 {
        let _e312 = tuning.purgeOrbitSpeed;
        local_27 = _e312;
    } else {
        let _e314 = tuning.blackHoleOrbitSpeed;
        local_27 = _e314;
    }
    let _e315 = local_27;
    orbitSpeed = _e315;
    let _e316 = (*purge);
    if _e316 {
        let _e318 = tuning.purgeInfall;
        local_28 = _e318;
    } else {
        let _e320 = tuning.blackHoleInfall;
        local_28 = _e320;
    }
    let _e321 = local_28;
    infallChance = _e321;
    let _e322 = (*randVal_12);
    let _e323 = orbitSpeed;
    let _e324 = (*dist_1);
    if (_e322 > clamp((_e323 / sqrt(max(_e324, 1f))), 0f, 1f)) {
        let _e330 = sleep_1;
        if (_e330 != 0u) {
            let _e332 = (*currentIndex_13);
            let _e335 = (*rawValue_11);
            let _e336 = (*rawValue_11);
            param_824 = _e336;
            let _e337 = getDir_u0028_u1_u003b((&param_824));
            let _e338 = (*rawValue_11);
            param_825 = _e338;
            let _e339 = getAge_u0028_u1_u003b((&param_825));
            let _e340 = type_37;
            param_826 = _e340;
            param_827 = _e337;
            param_828 = 0u;
            param_829 = _e339;
            let _e341 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_826), (&param_827), (&param_828), (&param_829));
            let _e342 = atomicCompareExchangeWeak((&unnamed.grid[_e332]), _e335, _e341);
        }
        return;
    }
    let _e344 = (*center_1);
    let _e345 = (*pos_18);
    inward = normalize(vec3<f32>((_e344 - _e345)));
    let _e349 = (*center_1);
    param_830 = _e349;
    let _e350 = (*pos_18);
    param_831 = _e350;
    let _e351 = bhOrbitAxis_u0028_vi3_u003b_vi3_u003b((&param_830), (&param_831));
    axis = _e351;
    let _e352 = axis;
    let _e353 = inward;
    tangent = cross(_e352, _e353);
    let _e355 = tangent;
    tangentLen = length(_e355);
    let _e357 = tangentLen;
    if (_e357 < 0.05f) {
        let _e359 = axis;
        tangent = normalize(cross(_e359, vec3<f32>(0.577f, 0.577f, 0.577f)));
    } else {
        let _e362 = tangentLen;
        let _e363 = tangent;
        tangent = (_e363 / vec3(_e362));
    }
    let _e366 = (*pos_18);
    let _e367 = (*center_1);
    let _e370 = axis;
    axial = dot(vec3<f32>((_e366 - _e367)), _e370);
    let _e372 = axis;
    let _e374 = axial;
    let _e379 = tuning.blackHolePlaneGrip;
    grip = ((-(_e372) * clamp((_e374 * 0.5f), -1f, 1f)) * _e379);
    let _e381 = tangent;
    let _e382 = grip;
    along = normalize((_e381 + _e382));
    let _e385 = (*randVal_12);
    let _e388 = infallChance;
    pullIn = (fract((_e385 * 61f)) < clamp(_e388, 0f, 1f));
    let _e391 = inward;
    let _e392 = tangent;
    spiral = normalize((_e391 + (_e392 * 0.6f)));
    let _e396 = pullIn;
    phi_2057_ = _e396;
    if _e396 {
        let _e397 = spiral;
        param_832 = _e397;
        param_833 = 0.55f;
        let _e398 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_832), (&param_833));
        let _e399 = (*pos_18);
        param_834 = _e399;
        let _e400 = (*currentIndex_13);
        param_835 = _e400;
        let _e401 = (*rawValue_11);
        param_836 = _e401;
        param_837 = _e398;
        let _e402 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_834), (&param_835), (&param_836), (&param_837));
        phi_2057_ = _e402;
    }
    let _e404 = phi_2057_;
    if _e404 {
        return;
    }
    let _e405 = along;
    param_838 = _e405;
    param_839 = 0.55f;
    let _e406 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_838), (&param_839));
    let _e407 = (*pos_18);
    param_840 = _e407;
    let _e408 = (*currentIndex_13);
    param_841 = _e408;
    let _e409 = (*rawValue_11);
    param_842 = _e409;
    param_843 = _e406;
    let _e410 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_840), (&param_841), (&param_842), (&param_843));
    if _e410 {
        return;
    }
    let _e411 = along;
    param_844 = _e411;
    param_845 = 1f;
    let _e412 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_844), (&param_845));
    let _e413 = (*pos_18);
    param_846 = _e413;
    let _e414 = (*currentIndex_13);
    param_847 = _e414;
    let _e415 = (*rawValue_11);
    param_848 = _e415;
    param_849 = _e412;
    let _e416 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_846), (&param_847), (&param_848), (&param_849));
    if _e416 {
        return;
    }
    let _e417 = tangent;
    param_850 = _e417;
    param_851 = 1f;
    let _e418 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_850), (&param_851));
    let _e419 = (*pos_18);
    param_852 = _e419;
    let _e420 = (*currentIndex_13);
    param_853 = _e420;
    let _e421 = (*rawValue_11);
    param_854 = _e421;
    param_855 = _e418;
    let _e422 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_852), (&param_853), (&param_854), (&param_855));
    if _e422 {
        return;
    }
    let _e423 = inward;
    param_856 = _e423;
    param_857 = 0.55f;
    let _e424 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_856), (&param_857));
    let _e425 = (*pos_18);
    param_858 = _e425;
    let _e426 = (*currentIndex_13);
    param_859 = _e426;
    let _e427 = (*rawValue_11);
    param_860 = _e427;
    param_861 = _e424;
    let _e428 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_858), (&param_859), (&param_860), (&param_861));
    if _e428 {
        return;
    }
    let _e429 = inward;
    param_862 = _e429;
    param_863 = 1f;
    let _e430 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_862), (&param_863));
    let _e431 = (*pos_18);
    param_864 = _e431;
    let _e432 = (*currentIndex_13);
    param_865 = _e432;
    let _e433 = (*rawValue_11);
    param_866 = _e433;
    param_867 = _e430;
    let _e434 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_864), (&param_865), (&param_866), (&param_867));
    if _e434 {
        return;
    }
    let _e435 = sleep_1;
    if (_e435 != 0u) {
        let _e437 = (*currentIndex_13);
        let _e440 = (*rawValue_11);
        let _e441 = (*rawValue_11);
        param_868 = _e441;
        let _e442 = getDir_u0028_u1_u003b((&param_868));
        let _e443 = (*rawValue_11);
        param_869 = _e443;
        let _e444 = getAge_u0028_u1_u003b((&param_869));
        let _e445 = type_37;
        param_870 = _e445;
        param_871 = _e442;
        param_872 = 0u;
        param_873 = _e444;
        let _e446 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_870), (&param_871), (&param_872), (&param_873));
        let _e447 = atomicCompareExchangeWeak((&unnamed.grid[_e437]), _e440, _e446);
    }
    return;
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_2: u32;
    var l: u32;
    var r_5: f32;
    var param_874: u32;
    var volume: f32;

    level_2 = 0u;
    l = 1u;
    loop {
        let _e203 = l;
        let _e205 = tuning.blackHoleMaxLevel;
        if (_e203 <= min(_e205, 16u)) {
            let _e208 = l;
            param_874 = _e208;
            let _e209 = bhBodyRadius_u0028_u1_u003b((&param_874));
            r_5 = _e209;
            let _e210 = r_5;
            let _e212 = r_5;
            let _e214 = r_5;
            volume = (((4.18879f * _e210) * _e212) * _e214);
            let _e216 = (*mass);
            let _e219 = tuning.blackHoleGrowthCost;
            let _e220 = volume;
            if (f32(_e216) < (_e219 * _e220)) {
                break;
            }
            let _e223 = l;
            level_2 = _e223;
            continue;
        } else {
            break;
        }
        continuing {
            let _e224 = l;
            l = (_e224 + bitcast<u32>(1i));
        }
    }
    let _e227 = level_2;
    return _e227;
}

fn bhLevelFor_u0028_u1_u003b_u1_u003b(code_1: ptr<function, u32>, mass_1: ptr<function, u32>) -> u32 {
    var param_875: u32;
    var param_876: u32;

    let _e201 = (*code_1);
    param_875 = _e201;
    let _e202 = bhIsPurge_u0028_u1_u003b((&param_875));
    if _e202 {
        let _e204 = tuning.purgeLevel;
        let _e206 = (*mass_1);
        let _e209 = tuning.purgeMass;
        return u32((f32(_e204) * clamp((f32(_e206) / f32(max(_e209, 1u))), 0f, 1f)));
    }
    let _e216 = (*mass_1);
    param_876 = _e216;
    let _e217 = bhLevel_u0028_u1_u003b((&param_876));
    return _e217;
}

fn bhDecode_u0028_u1_u003b(code_2: ptr<function, u32>) -> vec3<i32> {
    var i_24: u32;

    let _e199 = (*code_2);
    i_24 = (_e199 & 1073741823u);
    let _e201 = i_24;
    let _e203 = tuning.gridWidth;
    let _e208 = i_24;
    let _e210 = tuning.gridWidth;
    let _e215 = tuning.gridHeight;
    let _e220 = i_24;
    let _e222 = tuning.gridWidth;
    let _e225 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e201 % bitcast<u32>(bitcast<i32>(_e203)))), bitcast<i32>(((_e208 / bitcast<u32>(bitcast<i32>(_e210))) % bitcast<u32>(bitcast<i32>(_e215)))), bitcast<i32>((_e220 / bitcast<u32>((bitcast<i32>(_e222) * bitcast<i32>(_e225))))));
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
    var param_877: u32;
    var d_23: vec3<f32>;
    var distSq: f32;
    var purge_1: bool;
    var param_878: u32;
    var level_3: u32;
    var param_879: u32;
    var param_880: u32;
    var radius: f32;
    var local_29: f32;
    var param_881: vec3<i32>;
    var param_882: u32;
    var param_883: u32;
    var param_884: vec3<i32>;
    var param_885: i32;
    var param_886: u32;
    var param_887: bool;
    var param_888: f32;
    var param_889: f32;

    let _e231 = unnamed_2.blackHoleCount;
    if (_e231 == 0u) {
        return false;
    }
    bestDistSq = 3000000000f;
    bestCenter = vec3<i32>(0i, 0i, 0i);
    bestSlot = -1i;
    bestLevel = 0u;
    bestPurge = false;
    let _e234 = tuning.blackHoleRadius;
    let _e236 = tuning.blackHoleMaxLevel;
    maxRadius = f32((_e234 + min(_e236, 16u)));
    let _e240 = maxRadius;
    let _e241 = maxRadius;
    maxRadiusSq = (_e240 * _e241);
    i_25 = 0i;
    loop {
        let _e243 = i_25;
        if (_e243 < 8i) {
            let _e245 = i_25;
            let _e248 = atomicLoad((&unnamed_2.blackHoles[_e245]));
            code_3 = _e248;
            let _e249 = code_3;
            if (_e249 == 0u) {
                continue;
            }
            let _e251 = code_3;
            param_877 = _e251;
            let _e252 = bhDecode_u0028_u1_u003b((&param_877));
            center_2 = _e252;
            let _e253 = center_2;
            let _e254 = (*pos_19);
            d_23 = vec3<f32>((_e253 - _e254));
            let _e257 = d_23;
            let _e258 = d_23;
            distSq = dot(_e257, _e258);
            let _e260 = code_3;
            param_878 = _e260;
            let _e261 = bhIsPurge_u0028_u1_u003b((&param_878));
            purge_1 = _e261;
            let _e262 = purge_1;
            let _e264 = distSq;
            let _e265 = maxRadiusSq;
            if (!(_e262) && (_e264 > _e265)) {
                continue;
            }
            let _e268 = distSq;
            let _e269 = bestDistSq;
            if (_e268 >= _e269) {
                continue;
            }
            let _e271 = i_25;
            let _e272 = code_3;
            param_879 = _e272;
            let _e275 = atomicLoad((&unnamed_2.blackHoleMass[_e271]));
            param_880 = _e275;
            let _e276 = bhLevelFor_u0028_u1_u003b_u1_u003b((&param_879), (&param_880));
            level_3 = _e276;
            let _e277 = purge_1;
            if _e277 {
                local_29 = 1000000000f;
            } else {
                let _e279 = tuning.blackHoleRadius;
                let _e280 = level_3;
                local_29 = f32((_e279 + _e280));
            }
            let _e283 = local_29;
            radius = _e283;
            let _e284 = distSq;
            let _e285 = radius;
            let _e286 = radius;
            if (_e284 <= (_e285 * _e286)) {
                let _e289 = distSq;
                bestDistSq = _e289;
                let _e290 = center_2;
                bestCenter = _e290;
                let _e291 = i_25;
                bestSlot = _e291;
                let _e292 = level_3;
                bestLevel = _e292;
                let _e293 = purge_1;
                bestPurge = _e293;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e294 = i_25;
            i_25 = (_e294 + 1i);
        }
    }
    let _e296 = bestSlot;
    if (_e296 < 0i) {
        return false;
    }
    let _e298 = bestDistSq;
    let _e300 = (*pos_19);
    param_881 = _e300;
    let _e301 = (*currentIndex_14);
    param_882 = _e301;
    let _e302 = (*rawValue_12);
    param_883 = _e302;
    let _e303 = bestCenter;
    param_884 = _e303;
    let _e304 = bestSlot;
    param_885 = _e304;
    let _e305 = bestLevel;
    param_886 = _e305;
    let _e306 = bestPurge;
    param_887 = _e306;
    param_888 = sqrt(_e298);
    let _e307 = (*randVal_13);
    param_889 = _e307;
    updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b((&param_881), (&param_882), (&param_883), (&param_884), (&param_885), (&param_886), (&param_887), (&param_888), (&param_889));
    return true;
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x_4: ptr<function, i32>, z_5: ptr<function, i32>) -> u32 {
    let _e199 = (*x_4);
    let _e200 = (*z_5);
    let _e202 = tuning.gridWidth;
    return (bitcast<u32>((_e199 + (_e200 * bitcast<i32>(_e202)))) * 4u);
}

fn bhRegister_u0028_vi3_u003b(p_5: ptr<function, vec3<i32>>) -> bool {
    var code_4: u32;
    var param_890: vec3<i32>;
    var i_26: i32;

    let _e201 = (*p_5);
    param_890 = _e201;
    let _e202 = getIndex_u0028_vi3_u003b((&param_890));
    code_4 = (2147483648u | _e202);
    i_26 = 0i;
    loop {
        let _e204 = i_26;
        if (_e204 < 8i) {
            let _e206 = i_26;
            let _e209 = code_4;
            let _e210 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e206]), 0u, _e209);
            if (_e210.old_value == 0u) {
                let _e213 = i_26;
                atomicStore((&unnamed_2.blackHoleMass[_e213]), 0u);
                let _e216 = i_26;
                unnamed_2.blackHoleStarve[_e216] = 0u;
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e219 = i_26;
            i_26 = (_e219 + 1i);
        }
    }
    return false;
}

fn writeCell_u0028_u1_u003b_u1_u003b(index_1: ptr<function, u32>, value_2: ptr<function, u32>) {
    let _e199 = (*index_1);
    let _e200 = (*value_2);
    atomicStore((&unnamed.grid[_e199]), _e200);
    return;
}

fn lavaSpawnCoolness_u0028_u1_u003b(type_38: ptr<function, u32>) -> u32 {
    var param_891: u32;

    let _e199 = (*type_38);
    if (_e199 == 12u) {
        let _e201 = lavaSolidifyCoolness_u0028_();
        return _e201;
    }
    let _e202 = (*type_38);
    param_891 = _e202;
    let _e203 = isLava_u0028_u1_u003b((&param_891));
    if _e203 {
        let _e204 = (*type_38);
        let _e207 = tuning.lavaStageSize;
        return ((_e204 - 8u) * max(_e207, 1u));
    }
    return 0u;
}

fn locustSpawnCount_u0028_u1_u003b(type_39: ptr<function, u32>) -> u32 {
    var param_892: u32;

    let _e199 = (*type_39);
    param_892 = _e199;
    let _e200 = isLocust_u0028_u1_u003b((&param_892));
    if !(_e200) {
        return 0u;
    }
    let _e202 = (*type_39);
    let _e205 = locustStage_u0028_();
    let _e207 = locustMaxCount_u0028_();
    return min((((_e202 - 13u) + 1u) * _e205), _e207);
}

fn bhRelease_u0028_vi3_u003b(p_6: ptr<function, vec3<i32>>) {
    var code_5: u32;
    var param_893: vec3<i32>;
    var i_27: i32;

    let _e201 = (*p_6);
    param_893 = _e201;
    let _e202 = getIndex_u0028_vi3_u003b((&param_893));
    code_5 = (2147483648u | _e202);
    i_27 = 0i;
    loop {
        let _e204 = i_27;
        if (_e204 < 8i) {
            let _e206 = i_27;
            let _e209 = code_5;
            let _e210 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e206]), _e209, 0u);
            continue;
        } else {
            break;
        }
        continuing {
            let _e212 = i_27;
            i_27 = (_e212 + 1i);
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

    let _e204 = pc.spawnSize;
    halfMin = (_e204 / 2i);
    let _e207 = pc.spawnSize;
    halfMax = ((_e207 - 1i) / 2i);
    let _e211 = (*pos_20)[0u];
    let _e213 = pc.spawnX;
    let _e214 = halfMin;
    let _e216 = (_e211 < (_e213 - _e214));
    phi_1519_ = _e216;
    if !(_e216) {
        let _e219 = (*pos_20)[0u];
        let _e221 = pc.spawnX;
        let _e222 = halfMax;
        phi_1519_ = (_e219 > (_e221 + _e222));
    }
    let _e226 = phi_1519_;
    if _e226 {
        return false;
    }
    let _e228 = (*pos_20)[1u];
    let _e230 = pc.spawnY;
    let _e231 = halfMin;
    let _e233 = (_e228 < (_e230 - _e231));
    phi_1541_ = _e233;
    if !(_e233) {
        let _e236 = (*pos_20)[1u];
        let _e238 = pc.spawnY;
        let _e239 = halfMax;
        phi_1541_ = (_e236 > (_e238 + _e239));
    }
    let _e243 = phi_1541_;
    if _e243 {
        return false;
    }
    let _e245 = (*pos_20)[2u];
    let _e247 = pc.spawnZ;
    let _e248 = halfMin;
    let _e250 = (_e245 < (_e247 - _e248));
    phi_1562_ = _e250;
    if !(_e250) {
        let _e253 = (*pos_20)[2u];
        let _e255 = pc.spawnZ;
        let _e256 = halfMax;
        phi_1562_ = (_e253 > (_e255 + _e256));
    }
    let _e260 = phi_1562_;
    if _e260 {
        return false;
    }
    let _e262 = pc.spawnShape;
    if (_e262 != 1i) {
        return true;
    }
    let _e265 = pc.spawnX;
    let _e268 = pc.spawnY;
    let _e271 = pc.spawnZ;
    let _e274 = halfMax;
    let _e275 = halfMin;
    center_3 = (vec3<f32>(f32(_e265), f32(_e268), f32(_e271)) + vec3((f32(((_e274 - _e275) + 1i)) * 0.5f)));
    let _e282 = (*pos_20);
    let _e286 = center_3;
    d_24 = ((vec3<f32>(_e282) + vec3(0.5f)) - _e286);
    let _e289 = pc.spawnSize;
    radius_1 = (f32(_e289) * 0.5f);
    let _e292 = d_24;
    let _e293 = d_24;
    let _e295 = radius_1;
    let _e296 = radius_1;
    return (dot(_e292, _e293) <= (_e295 * _e296));
}

fn tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(fromIndex: ptr<function, u32>, newValue_4: ptr<function, u32>, toIndex: ptr<function, u32>, expectedFromValue: ptr<function, u32>) -> bool {
    let _e201 = (*toIndex);
    let _e204 = (*newValue_4);
    let _e205 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e201]), 0u, _e204);
    if (_e205.old_value != 0u) {
        return false;
    }
    let _e208 = (*fromIndex);
    let _e211 = (*expectedFromValue);
    let _e212 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e208]), _e211, 0u);
    let _e214 = (*expectedFromValue);
    if (_e212.old_value != _e214) {
        let _e216 = (*toIndex);
        let _e219 = atomicExchange((&unnamed_1.cloudCells[_e216]), 0u);
        return false;
    }
    return true;
}

fn getCloudCounter_u0028_u1_u003b(v_5: ptr<function, u32>) -> u32 {
    let _e198 = (*v_5);
    return ((_e198 >> bitcast<u32>(3i)) & 2047u);
}

fn getCloudTarget_u0028_u1_u003b(v_6: ptr<function, u32>) -> u32 {
    let _e198 = (*v_6);
    return ((_e198 >> bitcast<u32>(14i)) & 2047u);
}

fn updateCloudBlock_u0028_vi3_u003b(pos_21: ptr<function, vec3<i32>>) {
    var idx_4: u32;
    var param_894: vec3<i32>;
    var base: u32;
    var param_895: i32;
    var param_896: i32;
    var cell: u32;
    var kind_1: u32;
    var param_897: u32;
    var param_898: vec3<i32>;
    var newCell: u32;
    var param_899: u32;
    var param_900: bool;
    var param_901: u32;
    var param_902: u32;
    var param_903: u32;
    var param_904: u32;
    var param_905: bool;
    var param_906: u32;
    var param_907: u32;
    var target_4: u32;
    var param_908: u32;
    var lo: u32;
    var hi: u32;
    var r_6: f32;
    var param_909: vec3<f32>;
    var param_910: u32;
    var param_911: bool;
    var param_912: u32;
    var param_913: u32;
    var counter_1: u32;
    var param_914: u32;
    var param_915: u32;
    var param_916: bool;
    var param_917: u32;
    var param_918: u32;
    var param_919: vec3<i32>;
    var g: u32;
    var param_920: u32;
    var param_921: u32;
    var param_922: u32;
    var param_923: u32;
    var param_924: u32;
    var param_925: u32;
    var randVal_14: f32;
    var param_926: vec3<f32>;
    var counter_2: u32;
    var param_927: u32;
    var target_5: u32;
    var param_928: u32;
    var upPos_2: vec3<i32>;
    var param_929: vec3<i32>;
    var param_930: vec3<i32>;
    var param_931: u32;
    var param_932: u32;
    var param_933: bool;
    var param_934: u32;
    var param_935: u32;
    var param_936: vec3<i32>;
    var param_937: u32;
    var param_938: u32;
    var param_939: u32;
    var param_940: u32;
    var dir_7: i32;
    var slide1_: vec3<i32>;
    var slide2_: vec3<i32>;
    var i_28: i32;
    var t_4: vec3<i32>;
    var param_941: vec3<i32>;
    var tIndex: u32;
    var param_942: vec3<i32>;
    var param_943: u32;
    var param_944: u32;
    var param_945: bool;
    var param_946: u32;
    var param_947: u32;
    var param_948: u32;
    var param_949: u32;
    var param_950: u32;
    var param_951: u32;
    var param_952: u32;
    var param_953: u32;
    var param_954: bool;
    var param_955: u32;
    var param_956: u32;
    var phi_8896_: bool;
    var phi_8897_: bool;
    var phi_9105_: bool;

    let _e282 = (*pos_21);
    param_894 = _e282;
    let _e283 = getIndex_u0028_vi3_u003b((&param_894));
    idx_4 = _e283;
    let _e285 = (*pos_21)[0u];
    param_895 = _e285;
    let _e287 = (*pos_21)[2u];
    param_896 = _e287;
    let _e288 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_895), (&param_896));
    base = _e288;
    let _e290 = (*pos_21)[1u];
    if (_e290 == 0i) {
        let _e292 = base;
        let _e294 = base;
        let _e298 = atomicLoad((&unnamed_2.cloudColumn[(_e294 + 0u)]));
        atomicStore((&unnamed_2.cloudColumn[(_e292 + 2u)]), _e298);
        let _e301 = base;
        let _e303 = base;
        let _e307 = atomicLoad((&unnamed_2.cloudColumn[(_e303 + 1u)]));
        atomicStore((&unnamed_2.cloudColumn[(_e301 + 3u)]), _e307);
        let _e310 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e310 + 0u)]), 0u);
        let _e314 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e314 + 1u)]), 0u);
    }
    let _e318 = idx_4;
    let _e321 = atomicLoad((&unnamed_1.cloudCells[_e318]));
    cell = _e321;
    let _e322 = cell;
    param_897 = _e322;
    let _e323 = getCloudKind_u0028_u1_u003b((&param_897));
    kind_1 = _e323;
    let _e324 = kind_1;
    if (_e324 == 0u) {
        return;
    }
    let _e327 = atomicAdd((&unnamed_2.cloudBlockCount), 1u);
    let _e328 = base;
    let _e332 = atomicAdd((&unnamed_2.cloudColumn[(_e328 + 0u)]), 1u);
    let _e333 = base;
    let _e338 = (*pos_21)[1u];
    let _e340 = atomicMax((&unnamed_2.cloudColumn[(_e333 + 1u)]), bitcast<u32>(_e338));
    let _e341 = kind_1;
    let _e342 = (_e341 == 1u);
    phi_8897_ = _e342;
    if _e342 {
        let _e344 = unnamed_2.rainPhase;
        let _e345 = (_e344 == 2u);
        phi_8896_ = _e345;
        if !(_e345) {
            let _e347 = (*pos_21);
            param_898 = _e347;
            let _e348 = cloudTouchesRain_u0028_vi3_u003b((&param_898));
            phi_8896_ = _e348;
        }
        let _e350 = phi_8896_;
        phi_8897_ = _e350;
    }
    let _e352 = phi_8897_;
    if _e352 {
        param_899 = 2u;
        param_900 = false;
        param_901 = 0u;
        param_902 = 0u;
        let _e353 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_899), (&param_900), (&param_901), (&param_902));
        newCell = _e353;
        let _e354 = idx_4;
        let _e357 = cell;
        let _e358 = newCell;
        let _e359 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e354]), _e357, _e358);
        let _e361 = cell;
        if (_e359.old_value != _e361) {
            return;
        }
        let _e363 = newCell;
        cell = _e363;
        kind_1 = 2u;
    }
    let _e365 = (*pos_21)[1u];
    let _e367 = tuning.gridHeight;
    if (_e365 >= (bitcast<i32>(_e367) - 2i)) {
        let _e371 = kind_1;
        if (_e371 != 2u) {
            let _e373 = cell;
            param_903 = _e373;
            let _e374 = getCloudMoved_u0028_u1_u003b((&param_903));
            if _e374 {
                let _e375 = idx_4;
                let _e378 = cell;
                let _e379 = kind_1;
                param_904 = _e379;
                param_905 = false;
                param_906 = 0u;
                param_907 = 0u;
                let _e380 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_904), (&param_905), (&param_906), (&param_907));
                let _e381 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e375]), _e378, _e380);
            }
            return;
        }
        let _e383 = cell;
        param_908 = _e383;
        let _e384 = getCloudTarget_u0028_u1_u003b((&param_908));
        target_4 = _e384;
        let _e385 = target_4;
        if (_e385 == 0u) {
            let _e388 = tuning.rainWaitMinTicks;
            let _e390 = tuning.rainWaitMaxTicks;
            lo = min(_e388, _e390);
            let _e393 = tuning.rainWaitMinTicks;
            let _e395 = tuning.rainWaitMaxTicks;
            hi = max(_e393, _e395);
            let _e397 = (*pos_21);
            let _e400 = pc.time;
            param_909 = (vec3<f32>(_e397) + vec3<f32>(_e400, 17f, 3f));
            let _e403 = hash_u0028_vf3_u003b((&param_909));
            r_6 = _e403;
            let _e404 = lo;
            let _e405 = r_6;
            let _e406 = hi;
            let _e407 = lo;
            target_4 = (_e404 + u32((_e405 * f32(((_e406 - _e407) + 1u)))));
            let _e414 = idx_4;
            let _e417 = cell;
            param_910 = 2u;
            param_911 = false;
            param_912 = 0u;
            let _e418 = target_4;
            param_913 = _e418;
            let _e419 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_910), (&param_911), (&param_912), (&param_913));
            let _e420 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e414]), _e417, _e419);
            return;
        }
        let _e422 = cell;
        param_914 = _e422;
        let _e423 = getCloudCounter_u0028_u1_u003b((&param_914));
        counter_1 = _e423;
        let _e424 = counter_1;
        let _e425 = target_4;
        if (_e424 < _e425) {
            let _e427 = idx_4;
            let _e430 = cell;
            let _e431 = counter_1;
            param_915 = 2u;
            param_916 = false;
            param_917 = (_e431 + 1u);
            let _e433 = target_4;
            param_918 = _e433;
            let _e434 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_915), (&param_916), (&param_917), (&param_918));
            let _e435 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e427]), _e430, _e434);
            return;
        }
        let _e437 = (*pos_21);
        param_919 = _e437;
        let _e438 = cloudCellInBounds_u0028_vi3_u003b((&param_919));
        if !(_e438) {
            return;
        }
        let _e440 = idx_4;
        param_920 = _e440;
        let _e441 = readCell_u0028_u1_u003b((&param_920));
        g = _e441;
        let _e442 = g;
        param_921 = _e442;
        let _e443 = getType_u0028_u1_u003b((&param_921));
        if (_e443 != 0u) {
            return;
        }
        let _e445 = idx_4;
        let _e448 = g;
        param_922 = 2u;
        param_923 = 0u;
        param_924 = 0u;
        param_925 = 0u;
        let _e449 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_922), (&param_923), (&param_924), (&param_925));
        let _e450 = atomicCompareExchangeWeak((&unnamed.grid[_e445]), _e448, _e449);
        let _e452 = g;
        if (_e450.old_value != _e452) {
            return;
        }
        let _e454 = idx_4;
        let _e457 = atomicExchange((&unnamed_1.cloudCells[_e454]), 0u);
        incWater_u0028_();
        let _e459 = (*pos_21)[1u];
        let _e462 = atomicLoad((&unnamed_2.maxOccupiedY));
        if (bitcast<u32>(_e459) > _e462) {
            let _e466 = (*pos_21)[1u];
            let _e468 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e466));
        }
        return;
    }
    let _e469 = (*pos_21);
    let _e472 = pc.time;
    param_926 = (vec3<f32>(_e469) + vec3<f32>((_e472 * 2.3f), 7f, 13f));
    let _e476 = hash_u0028_vf3_u003b((&param_926));
    randVal_14 = _e476;
    let _e477 = cell;
    param_927 = _e477;
    let _e478 = getCloudCounter_u0028_u1_u003b((&param_927));
    counter_2 = _e478;
    let _e479 = cell;
    param_928 = _e479;
    let _e480 = getCloudTarget_u0028_u1_u003b((&param_928));
    target_5 = _e480;
    let _e481 = (*pos_21);
    upPos_2 = (_e481 + vec3<i32>(0i, 1i, 0i));
    let _e483 = upPos_2;
    param_929 = _e483;
    let _e484 = cloudCellInBounds_u0028_vi3_u003b((&param_929));
    phi_9105_ = _e484;
    if _e484 {
        let _e485 = upPos_2;
        param_930 = _e485;
        let _e486 = getIndex_u0028_vi3_u003b((&param_930));
        let _e489 = atomicLoad((&unnamed_1.cloudCells[_e486]));
        param_931 = _e489;
        let _e490 = getCloudKind_u0028_u1_u003b((&param_931));
        phi_9105_ = (_e490 == 0u);
    }
    let _e493 = phi_9105_;
    if _e493 {
        let _e494 = kind_1;
        param_932 = _e494;
        param_933 = true;
        let _e495 = counter_2;
        param_934 = _e495;
        let _e496 = target_5;
        param_935 = _e496;
        let _e497 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_932), (&param_933), (&param_934), (&param_935));
        let _e498 = upPos_2;
        param_936 = _e498;
        let _e499 = getIndex_u0028_vi3_u003b((&param_936));
        let _e500 = idx_4;
        param_937 = _e500;
        param_938 = _e497;
        param_939 = _e499;
        let _e501 = cell;
        param_940 = _e501;
        let _e502 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_937), (&param_938), (&param_939), (&param_940));
        if _e502 {
            let _e504 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
            return;
        }
    }
    let _e505 = randVal_14;
    dir_7 = select(-1i, 1i, (fract((_e505 * 10f)) > 0.5f));
    let _e510 = randVal_14;
    if (fract((_e510 * 100f)) > 0.5f) {
        let _e514 = (*pos_21);
        let _e515 = dir_7;
        slide1_ = (_e514 + vec3<i32>(_e515, 1i, 0i));
        let _e518 = (*pos_21);
        let _e519 = dir_7;
        slide2_ = (_e518 + vec3<i32>(0i, 1i, _e519));
    } else {
        let _e522 = (*pos_21);
        let _e523 = dir_7;
        slide1_ = (_e522 + vec3<i32>(0i, 1i, _e523));
        let _e526 = (*pos_21);
        let _e527 = dir_7;
        slide2_ = (_e526 + vec3<i32>(_e527, 1i, 0i));
    }
    i_28 = 0i;
    loop {
        let _e530 = i_28;
        if (_e530 < 2i) {
            let _e532 = i_28;
            let _e534 = slide1_;
            let _e535 = slide2_;
            t_4 = select(_e535, _e534, vec3((_e532 == 0i)));
            let _e538 = t_4;
            param_941 = _e538;
            let _e539 = cloudCellInBounds_u0028_vi3_u003b((&param_941));
            if !(_e539) {
                continue;
            }
            let _e541 = t_4;
            param_942 = _e541;
            let _e542 = getIndex_u0028_vi3_u003b((&param_942));
            tIndex = _e542;
            let _e543 = tIndex;
            let _e546 = atomicLoad((&unnamed_1.cloudCells[_e543]));
            param_943 = _e546;
            let _e547 = getCloudKind_u0028_u1_u003b((&param_943));
            if (_e547 != 0u) {
                continue;
            }
            let _e549 = kind_1;
            param_944 = _e549;
            param_945 = true;
            let _e550 = counter_2;
            param_946 = _e550;
            let _e551 = target_5;
            param_947 = _e551;
            let _e552 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_944), (&param_945), (&param_946), (&param_947));
            let _e553 = idx_4;
            param_948 = _e553;
            param_949 = _e552;
            let _e554 = tIndex;
            param_950 = _e554;
            let _e555 = cell;
            param_951 = _e555;
            let _e556 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_948), (&param_949), (&param_950), (&param_951));
            if _e556 {
                let _e558 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e559 = i_28;
            i_28 = (_e559 + 1i);
        }
    }
    let _e561 = cell;
    param_952 = _e561;
    let _e562 = getCloudMoved_u0028_u1_u003b((&param_952));
    if _e562 {
        let _e563 = idx_4;
        let _e566 = cell;
        let _e567 = kind_1;
        param_953 = _e567;
        param_954 = false;
        let _e568 = counter_2;
        param_955 = _e568;
        let _e569 = target_5;
        param_956 = _e569;
        let _e570 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_953), (&param_954), (&param_955), (&param_956));
        let _e571 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e563]), _e566, _e570);
    }
    return;
}

fn updateSimState_u0028_() {
    var live: u32;
    var i_29: i32;
    var code_6: u32;
    var voxel: u32;
    var param_957: u32;
    var param_958: u32;
    var starve: u32;
    var purge_2: bool;
    var param_959: u32;
    var grace: u32;
    var local_30: u32;
    var decay: u32;
    var local_31: u32;
    var mass_2: u32;
    var param_960: u32;
    var param_961: u32;
    var movedLastTick: u32;
    var liveClouds: u32;
    var chargeTarget: f32;
    var charge: f32;
    var interval: u32;
    var phi_8110_: bool;
    var phi_8117_: bool;

    let _e219 = gl_GlobalInvocationID_1[0u];
    let _e220 = (_e219 != 0u);
    phi_8110_ = _e220;
    if !(_e220) {
        let _e223 = gl_GlobalInvocationID_1[1u];
        phi_8110_ = (_e223 != 0u);
    }
    let _e226 = phi_8110_;
    phi_8117_ = _e226;
    if !(_e226) {
        let _e229 = gl_GlobalInvocationID_1[2u];
        phi_8117_ = (_e229 != 0u);
    }
    let _e232 = phi_8117_;
    if _e232 {
        return;
    }
    live = 0u;
    i_29 = 0i;
    loop {
        let _e233 = i_29;
        if (_e233 < 8i) {
            let _e235 = i_29;
            let _e238 = atomicLoad((&unnamed_2.blackHoles[_e235]));
            code_6 = _e238;
            let _e239 = code_6;
            if (_e239 == 0u) {
                continue;
            }
            let _e241 = code_6;
            voxel = (_e241 & 1073741823u);
            let _e243 = voxel;
            param_957 = _e243;
            let _e244 = readCell_u0028_u1_u003b((&param_957));
            param_958 = _e244;
            let _e245 = getType_u0028_u1_u003b((&param_958));
            if (_e245 != 7u) {
                let _e247 = i_29;
                atomicStore((&unnamed_2.blackHoles[_e247]), 0u);
                continue;
            }
            let _e250 = i_29;
            let _e253 = unnamed_2.blackHoleStarve[_e250];
            starve = (_e253 + 1u);
            let _e255 = i_29;
            let _e256 = starve;
            unnamed_2.blackHoleStarve[_e255] = _e256;
            let _e259 = code_6;
            param_959 = _e259;
            let _e260 = bhIsPurge_u0028_u1_u003b((&param_959));
            purge_2 = _e260;
            let _e261 = purge_2;
            if _e261 {
                let _e263 = tuning.purgeStarveGrace;
                local_30 = _e263;
            } else {
                let _e265 = tuning.blackHoleStarveGrace;
                local_30 = _e265;
            }
            let _e266 = local_30;
            grace = _e266;
            let _e267 = purge_2;
            if _e267 {
                let _e269 = tuning.purgeDecayRate;
                local_31 = _e269;
            } else {
                let _e271 = tuning.blackHoleDecayRate;
                local_31 = _e271;
            }
            let _e272 = local_31;
            decay = _e272;
            let _e273 = starve;
            let _e274 = grace;
            if (_e273 > _e274) {
                let _e276 = i_29;
                let _e279 = atomicLoad((&unnamed_2.blackHoleMass[_e276]));
                mass_2 = _e279;
                let _e280 = mass_2;
                if (_e280 == 0u) {
                    let _e282 = voxel;
                    param_960 = _e282;
                    param_961 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_960), (&param_961));
                    let _e283 = i_29;
                    atomicStore((&unnamed_2.blackHoles[_e283]), 0u);
                    continue;
                }
                let _e286 = i_29;
                let _e287 = mass_2;
                let _e288 = mass_2;
                let _e289 = decay;
                atomicStore((&unnamed_2.blackHoleMass[_e286]), (_e287 - min(_e288, _e289)));
            }
            let _e294 = live;
            live = (_e294 + bitcast<u32>(1i));
            continue;
        } else {
            break;
        }
        continuing {
            let _e297 = i_29;
            i_29 = (_e297 + 1i);
        }
    }
    let _e299 = live;
    unnamed_2.blackHoleCount = _e299;
    let _e302 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (_e302 > 0u) {
        let _e305 = atomicAdd((&unnamed_2.maxOccupiedY), 4294967295u);
    }
    let _e307 = atomicLoad((&unnamed_2.rainCandidateCount));
    unnamed_2.rainCandidateEstimate = _e307;
    atomicStore((&unnamed_2.rainCandidateCount), 0u);
    let _e311 = unnamed_2.simTick;
    unnamed_2.simTick = (_e311 + 1u);
    let _e315 = atomicLoad((&unnamed_2.cloudMovedCount));
    movedLastTick = _e315;
    let _e317 = atomicLoad((&unnamed_2.cloudBlockCount));
    liveClouds = _e317;
    atomicStore((&unnamed_2.cloudBlockCount), 0u);
    atomicStore((&unnamed_2.cloudMovedCount), 0u);
    let _e321 = unnamed_2.rainPhase;
    chargeTarget = select(1f, 0f, (_e321 == 0u));
    let _e325 = unnamed_2.cloudChargeBits;
    charge = bitcast<f32>(_e325);
    let _e327 = chargeTarget;
    let _e328 = charge;
    let _e331 = tuning.cloudChargeEaseRate;
    let _e334 = charge;
    charge = (_e334 + ((_e327 - _e328) * clamp(_e331, 0f, 1f)));
    let _e336 = charge;
    unnamed_2.cloudChargeBits = bitcast<u32>(clamp(_e336, 0f, 1f));
    let _e341 = unnamed_2.rainPhase;
    if (_e341 == 0u) {
        let _e344 = tuning.cloudCheckIntervalTicks;
        interval = max(_e344, 1u);
        let _e347 = unnamed_2.simTick;
        let _e348 = interval;
        let _e351 = liveClouds;
        let _e354 = movedLastTick;
        if ((((_e347 % _e348) == 0u) && (_e351 > 0u)) && (_e354 == 0u)) {
            unnamed_2.rainPhase = 2u;
            let _e359 = pc.time;
            unnamed_2.rainPhaseTimeBits = bitcast<u32>(_e359);
            let _e363 = unnamed_2.simTick;
            unnamed_2.lastRainTick = _e363;
        }
    } else {
        let _e365 = liveClouds;
        if (_e365 == 0u) {
            unnamed_2.rainPhase = 0u;
            unnamed_2.rainPhaseTimeBits = 0u;
        }
    }
    return;
}

fn main_1() {
    var pos_22: vec3<i32>;
    var param_962: vec3<i32>;
    var param_963: vec3<i32>;
    var spawnIndex: u32;
    var param_964: vec3<i32>;
    var oldType: u32;
    var param_965: u32;
    var param_966: u32;
    var newType_3: u32;
    var param_967: vec3<i32>;
    var seedAge: u32;
    var param_968: u32;
    var local_32: u32;
    var param_969: u32;
    var param_970: u32;
    var param_971: u32;
    var param_972: u32;
    var param_973: u32;
    var param_974: u32;
    var param_975: u32;
    var param_976: u32;
    var param_977: vec3<i32>;
    var param_978: u32;
    var param_979: u32;
    var currentIndex_15: u32;
    var param_980: vec3<i32>;
    var rawValue_13: u32;
    var param_981: u32;
    var currentType_1: u32;
    var param_982: u32;
    var param_983: i32;
    var param_984: i32;
    var randVal_15: f32;
    var param_985: vec3<f32>;
    var param_986: vec3<i32>;
    var param_987: u32;
    var param_988: u32;
    var param_989: f32;
    var currentDir_6: u32;
    var param_990: u32;
    var currentSleep_7: u32;
    var param_991: u32;
    var currentAge_10: u32;
    var param_992: u32;
    var param_993: vec3<i32>;
    var param_994: u32;
    var param_995: u32;
    var param_996: u32;
    var param_997: u32;
    var param_998: f32;
    var param_999: vec3<i32>;
    var param_1000: u32;
    var param_1001: u32;
    var param_1002: u32;
    var param_1003: u32;
    var param_1004: u32;
    var param_1005: f32;
    var param_1006: vec3<i32>;
    var param_1007: u32;
    var param_1008: u32;
    var param_1009: u32;
    var param_1010: u32;
    var param_1011: u32;
    var param_1012: f32;
    var param_1013: vec3<i32>;
    var param_1014: u32;
    var param_1015: u32;
    var param_1016: u32;
    var param_1017: u32;
    var param_1018: u32;
    var param_1019: f32;
    var param_1020: vec3<i32>;
    var param_1021: u32;
    var param_1022: u32;
    var param_1023: u32;
    var param_1024: u32;
    var param_1025: f32;
    var param_1026: vec3<i32>;
    var param_1027: u32;
    var param_1028: u32;
    var param_1029: u32;
    var param_1030: u32;
    var param_1031: u32;
    var param_1032: f32;
    var param_1033: vec3<i32>;
    var param_1034: u32;
    var param_1035: u32;
    var param_1036: u32;
    var param_1037: f32;
    var param_1038: vec3<i32>;
    var param_1039: u32;
    var param_1040: u32;
    var param_1041: u32;
    var param_1042: u32;
    var param_1043: u32;
    var param_1044: f32;
    var param_1045: vec3<i32>;
    var param_1046: u32;
    var param_1047: u32;
    var param_1048: u32;
    var param_1049: u32;
    var param_1050: f32;
    var param_1051: vec3<i32>;
    var param_1052: u32;
    var param_1053: u32;
    var param_1054: u32;
    var param_1055: f32;
    var phi_9255_: bool;
    var phi_9265_: bool;
    var phi_9281_: bool;
    var phi_9380_: bool;
    var phi_9387_: bool;
    var phi_9398_: bool;
    var phi_9405_: bool;
    var phi_9416_: bool;
    var phi_9439_: bool;
    var phi_9449_: bool;
    var phi_9507_: bool;

    let _e304 = gl_GlobalInvocationID_1;
    pos_22 = bitcast<vec3<i32>>(_e304);
    let _e307 = pos_22[0u];
    let _e309 = tuning.gridWidth;
    let _e311 = (_e307 >= bitcast<i32>(_e309));
    phi_9255_ = _e311;
    if !(_e311) {
        let _e314 = pos_22[1u];
        let _e316 = tuning.gridHeight;
        phi_9255_ = (_e314 >= bitcast<i32>(_e316));
    }
    let _e320 = phi_9255_;
    phi_9265_ = _e320;
    if !(_e320) {
        let _e323 = pos_22[2u];
        let _e325 = tuning.gridDepth;
        phi_9265_ = (_e323 >= bitcast<i32>(_e325));
    }
    let _e329 = phi_9265_;
    if _e329 {
        return;
    }
    updateSimState_u0028_();
    let _e330 = pos_22;
    param_962 = _e330;
    updateCloudBlock_u0028_vi3_u003b((&param_962));
    let _e332 = pc.spawnActive;
    let _e333 = (_e332 == 1i);
    phi_9281_ = _e333;
    if _e333 {
        let _e334 = pos_22;
        param_963 = _e334;
        let _e335 = inBrush_u0028_vi3_u003b((&param_963));
        phi_9281_ = _e335;
    }
    let _e337 = phi_9281_;
    if _e337 {
        let _e338 = pos_22;
        param_964 = _e338;
        let _e339 = getIndex_u0028_vi3_u003b((&param_964));
        spawnIndex = _e339;
        let _e340 = spawnIndex;
        param_965 = _e340;
        let _e341 = readCell_u0028_u1_u003b((&param_965));
        param_966 = _e341;
        let _e342 = getType_u0028_u1_u003b((&param_966));
        oldType = _e342;
        let _e344 = pc.spawnType;
        newType_3 = bitcast<u32>(_e344);
        let _e346 = newType_3;
        let _e348 = oldType;
        if ((_e346 != 7u) || (_e348 != 7u)) {
            let _e351 = oldType;
            let _e352 = newType_3;
            if (_e351 != _e352) {
                let _e354 = oldType;
                if (_e354 == 2u) {
                    decWater_u0028_();
                }
                let _e356 = oldType;
                if (_e356 == 7u) {
                    let _e358 = pos_22;
                    param_967 = _e358;
                    bhRelease_u0028_vi3_u003b((&param_967));
                }
                let _e359 = newType_3;
                if (_e359 == 2u) {
                    incWater_u0028_();
                }
            }
            let _e361 = newType_3;
            param_968 = _e361;
            let _e362 = isLocust_u0028_u1_u003b((&param_968));
            if _e362 {
                let _e363 = newType_3;
                param_969 = _e363;
                let _e364 = locustSpawnCount_u0028_u1_u003b((&param_969));
                local_32 = _e364;
            } else {
                let _e365 = newType_3;
                param_970 = _e365;
                let _e366 = lavaSpawnCoolness_u0028_u1_u003b((&param_970));
                local_32 = _e366;
            }
            let _e367 = local_32;
            seedAge = _e367;
            let _e368 = newType_3;
            param_971 = _e368;
            param_972 = 0u;
            param_973 = 0u;
            let _e369 = seedAge;
            param_974 = _e369;
            let _e370 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_971), (&param_972), (&param_973), (&param_974));
            let _e371 = spawnIndex;
            param_975 = _e371;
            param_976 = _e370;
            writeCell_u0028_u1_u003b_u1_u003b((&param_975), (&param_976));
            let _e372 = newType_3;
            if (_e372 == 7u) {
                let _e374 = pos_22;
                param_977 = _e374;
                let _e375 = bhRegister_u0028_vi3_u003b((&param_977));
                if !(_e375) {
                    let _e377 = spawnIndex;
                    param_978 = _e377;
                    param_979 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_978), (&param_979));
                }
            }
        }
    }
    let _e379 = pos_22[0u];
    let _e380 = (_e379 < 1i);
    phi_9380_ = _e380;
    if !(_e380) {
        let _e383 = pos_22[0u];
        let _e385 = tuning.gridWidth;
        phi_9380_ = (_e383 >= (bitcast<i32>(_e385) - 1i));
    }
    let _e390 = phi_9380_;
    phi_9387_ = _e390;
    if !(_e390) {
        let _e393 = pos_22[1u];
        phi_9387_ = (_e393 < 1i);
    }
    let _e396 = phi_9387_;
    phi_9398_ = _e396;
    if !(_e396) {
        let _e399 = pos_22[1u];
        let _e401 = tuning.gridHeight;
        phi_9398_ = (_e399 >= (bitcast<i32>(_e401) - 1i));
    }
    let _e406 = phi_9398_;
    phi_9405_ = _e406;
    if !(_e406) {
        let _e409 = pos_22[2u];
        phi_9405_ = (_e409 < 1i);
    }
    let _e412 = phi_9405_;
    phi_9416_ = _e412;
    if !(_e412) {
        let _e415 = pos_22[2u];
        let _e417 = tuning.gridDepth;
        phi_9416_ = (_e415 >= (bitcast<i32>(_e417) - 1i));
    }
    let _e422 = phi_9416_;
    if _e422 {
        return;
    }
    let _e423 = pos_22;
    param_980 = _e423;
    let _e424 = getIndex_u0028_vi3_u003b((&param_980));
    currentIndex_15 = _e424;
    let _e425 = currentIndex_15;
    param_981 = _e425;
    let _e426 = readCell_u0028_u1_u003b((&param_981));
    rawValue_13 = _e426;
    let _e427 = rawValue_13;
    param_982 = _e427;
    let _e428 = getType_u0028_u1_u003b((&param_982));
    currentType_1 = _e428;
    let _e429 = currentType_1;
    let _e430 = (_e429 == 0u);
    phi_9439_ = _e430;
    if _e430 {
        let _e432 = unnamed_2.rainPhase;
        phi_9439_ = (_e432 >= 1u);
    }
    let _e435 = phi_9439_;
    phi_9449_ = _e435;
    if _e435 {
        let _e437 = pos_22[1u];
        let _e439 = tuning.gridHeight;
        phi_9449_ = (_e437 == (bitcast<i32>(_e439) - 2i));
    }
    let _e444 = phi_9449_;
    if _e444 {
        let _e446 = pos_22[0u];
        param_983 = _e446;
        let _e448 = pos_22[2u];
        param_984 = _e448;
        let _e449 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_983), (&param_984));
        let _e453 = atomicLoad((&unnamed_2.cloudColumn[(_e449 + 2u)]));
        if (_e453 != 0u) {
            let _e456 = atomicAdd((&unnamed_2.rainCandidateCount), 1u);
        }
    }
    let _e457 = currentType_1;
    if (_e457 == 0u) {
        return;
    }
    let _e460 = pos_22[1u];
    let _e463 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (bitcast<u32>(_e460) > _e463) {
        let _e467 = pos_22[1u];
        let _e469 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e467));
    }
    let _e470 = pos_22;
    let _e473 = pc.time;
    param_985 = (vec3<f32>(_e470) + vec3(_e473));
    let _e476 = hash_u0028_vf3_u003b((&param_985));
    randVal_15 = _e476;
    let _e477 = currentType_1;
    let _e478 = (_e477 != 7u);
    phi_9507_ = _e478;
    if _e478 {
        let _e479 = pos_22;
        param_986 = _e479;
        let _e480 = currentIndex_15;
        param_987 = _e480;
        let _e481 = rawValue_13;
        param_988 = _e481;
        let _e482 = randVal_15;
        param_989 = _e482;
        let _e483 = captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b((&param_986), (&param_987), (&param_988), (&param_989));
        phi_9507_ = _e483;
    }
    let _e485 = phi_9507_;
    if _e485 {
        return;
    }
    let _e486 = currentType_1;
    let _e488 = currentType_1;
    if ((_e486 == 3u) || (_e488 == 7u)) {
        return;
    }
    let _e491 = rawValue_13;
    param_990 = _e491;
    let _e492 = getDir_u0028_u1_u003b((&param_990));
    currentDir_6 = _e492;
    let _e493 = rawValue_13;
    param_991 = _e493;
    let _e494 = getSleep_u0028_u1_u003b((&param_991));
    currentSleep_7 = _e494;
    let _e495 = rawValue_13;
    param_992 = _e495;
    let _e496 = getAge_u0028_u1_u003b((&param_992));
    currentAge_10 = _e496;
    let _e497 = currentType_1;
    switch bitcast<i32>(_e497) {
        case 1: {
            let _e499 = pos_22;
            param_993 = _e499;
            let _e500 = currentIndex_15;
            param_994 = _e500;
            let _e501 = rawValue_13;
            param_995 = _e501;
            let _e502 = currentSleep_7;
            param_996 = _e502;
            let _e503 = currentAge_10;
            param_997 = _e503;
            let _e504 = randVal_15;
            param_998 = _e504;
            updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_993), (&param_994), (&param_995), (&param_996), (&param_997), (&param_998));
            break;
        }
        case 2: {
            let _e505 = pos_22;
            param_999 = _e505;
            let _e506 = currentIndex_15;
            param_1000 = _e506;
            let _e507 = rawValue_13;
            param_1001 = _e507;
            let _e508 = currentDir_6;
            param_1002 = _e508;
            let _e509 = currentSleep_7;
            param_1003 = _e509;
            let _e510 = currentAge_10;
            param_1004 = _e510;
            let _e511 = randVal_15;
            param_1005 = _e511;
            updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_999), (&param_1000), (&param_1001), (&param_1002), (&param_1003), (&param_1004), (&param_1005));
            break;
        }
        case 4: {
            let _e512 = pos_22;
            param_1006 = _e512;
            let _e513 = currentIndex_15;
            param_1007 = _e513;
            let _e514 = rawValue_13;
            param_1008 = _e514;
            let _e515 = currentDir_6;
            param_1009 = _e515;
            let _e516 = currentSleep_7;
            param_1010 = _e516;
            let _e517 = currentAge_10;
            param_1011 = _e517;
            let _e518 = randVal_15;
            param_1012 = _e518;
            updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1006), (&param_1007), (&param_1008), (&param_1009), (&param_1010), (&param_1011), (&param_1012));
            break;
        }
        case 5: {
            let _e519 = pos_22;
            param_1013 = _e519;
            let _e520 = currentIndex_15;
            param_1014 = _e520;
            let _e521 = rawValue_13;
            param_1015 = _e521;
            let _e522 = currentDir_6;
            param_1016 = _e522;
            let _e523 = currentSleep_7;
            param_1017 = _e523;
            let _e524 = currentAge_10;
            param_1018 = _e524;
            let _e525 = randVal_15;
            param_1019 = _e525;
            updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1013), (&param_1014), (&param_1015), (&param_1016), (&param_1017), (&param_1018), (&param_1019));
            break;
        }
        case 6: {
            let _e526 = pos_22;
            param_1020 = _e526;
            let _e527 = currentIndex_15;
            param_1021 = _e527;
            let _e528 = rawValue_13;
            param_1022 = _e528;
            let _e529 = currentSleep_7;
            param_1023 = _e529;
            let _e530 = currentAge_10;
            param_1024 = _e530;
            let _e531 = randVal_15;
            param_1025 = _e531;
            updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1020), (&param_1021), (&param_1022), (&param_1023), (&param_1024), (&param_1025));
            break;
        }
        case 9, 10, 11, 8: {
            let _e532 = pos_22;
            param_1026 = _e532;
            let _e533 = currentIndex_15;
            param_1027 = _e533;
            let _e534 = rawValue_13;
            param_1028 = _e534;
            let _e535 = currentDir_6;
            param_1029 = _e535;
            let _e536 = currentSleep_7;
            param_1030 = _e536;
            let _e537 = currentAge_10;
            param_1031 = _e537;
            let _e538 = randVal_15;
            param_1032 = _e538;
            updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1026), (&param_1027), (&param_1028), (&param_1029), (&param_1030), (&param_1031), (&param_1032));
            break;
        }
        case 12: {
            let _e539 = pos_22;
            param_1033 = _e539;
            let _e540 = currentIndex_15;
            param_1034 = _e540;
            let _e541 = rawValue_13;
            param_1035 = _e541;
            let _e542 = currentAge_10;
            param_1036 = _e542;
            let _e543 = randVal_15;
            param_1037 = _e543;
            updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1033), (&param_1034), (&param_1035), (&param_1036), (&param_1037));
            break;
        }
        case 14, 15, 16, 17, 13: {
            let _e544 = pos_22;
            param_1038 = _e544;
            let _e545 = currentIndex_15;
            param_1039 = _e545;
            let _e546 = rawValue_13;
            param_1040 = _e546;
            let _e547 = currentDir_6;
            param_1041 = _e547;
            let _e548 = currentSleep_7;
            param_1042 = _e548;
            let _e549 = currentAge_10;
            param_1043 = _e549;
            let _e550 = randVal_15;
            param_1044 = _e550;
            updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1038), (&param_1039), (&param_1040), (&param_1041), (&param_1042), (&param_1043), (&param_1044));
            break;
        }
        case 18: {
            let _e551 = pos_22;
            param_1045 = _e551;
            let _e552 = currentIndex_15;
            param_1046 = _e552;
            let _e553 = rawValue_13;
            param_1047 = _e553;
            let _e554 = currentDir_6;
            param_1048 = _e554;
            let _e555 = currentAge_10;
            param_1049 = _e555;
            let _e556 = randVal_15;
            param_1050 = _e556;
            updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1045), (&param_1046), (&param_1047), (&param_1048), (&param_1049), (&param_1050));
            break;
        }
        case 19: {
            let _e557 = pos_22;
            param_1051 = _e557;
            let _e558 = currentIndex_15;
            param_1052 = _e558;
            let _e559 = rawValue_13;
            param_1053 = _e559;
            let _e560 = currentAge_10;
            param_1054 = _e560;
            let _e561 = randVal_15;
            param_1055 = _e561;
            updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1051), (&param_1052), (&param_1053), (&param_1054), (&param_1055));
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
