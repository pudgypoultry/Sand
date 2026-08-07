// GENERATED FILE -- DO NOT EDIT.
//
// Translated from falling_sand.comp by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit falling_sand.comp and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 7df308a378dbb299b211f9a4210e3d900f41a4f9727ea34ba500f59ea60f7edd

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
    cloudChangedCount: u32,
    cloudStillTicks: u32,
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

struct CloudGrid {
    cloudCells: array<u32>,
}

struct VoxelGrid_1 {
    grid: array<atomic<u32>>,
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
    cloudChangedCount: atomic<u32>,
    cloudStillTicks: u32,
    blackHoleCount: u32,
    maxOccupiedY: atomic<u32>,
    blackHoles: array<atomic<u32>, 8>,
    blackHoleMass: array<atomic<u32>, 8>,
    blackHoleStarve: array<u32, 8>,
    cloudColumn: array<atomic<u32>>,
}

struct CloudGrid_1 {
    cloudCells: array<atomic<u32>>,
}

@group(0) @binding(0) 
var<storage, read_write> unnamed: VoxelGrid_1;
@group(0) @binding(2) 
var<uniform> tuning: TuningParams;
@group(0) @binding(1) 
var<storage, read_write> unnamed_1: SimStats_1;
@group(0) @binding(3) 
var<uniform> pc: Constants;
var<private> gl_GlobalInvocationID_1: vec3<u32>;
@group(0) @binding(4) 
var<storage, read_write> unnamed_2: CloudGrid_1;

fn getAge_u0028_u1_u003b(val: ptr<function, u32>) -> u32 {
    let _e199 = (*val);
    return ((_e199 >> bitcast<u32>(24i)) & 255u);
}

fn getDir_u0028_u1_u003b(val_1: ptr<function, u32>) -> u32 {
    let _e199 = (*val_1);
    return ((_e199 >> bitcast<u32>(8i)) & 255u);
}

fn getType_u0028_u1_u003b(val_2: ptr<function, u32>) -> u32 {
    let _e199 = (*val_2);
    return (_e199 & 255u);
}

fn tree26_u0028_i1_u003b(i: ptr<function, i32>) -> vec3<i32> {
    var j: i32;
    var local: i32;

    let _e201 = (*i);
    if (_e201 >= 13i) {
        let _e203 = (*i);
        local = (_e203 + 1i);
    } else {
        let _e205 = (*i);
        local = _e205;
    }
    let _e206 = local;
    j = _e206;
    let _e207 = j;
    let _e215 = j;
    let _e216 = (_e215 / 3i);
    let _e224 = j;
    return (vec3<i32>((_e207 - (i32(floor((f32(_e207) / f32(3i)))) * 3i)), (_e216 - (i32(floor((f32(_e216) / f32(3i)))) * 3i)), (_e224 / 9i)) - vec3<i32>(1i, 1i, 1i));
}

fn readCell_u0028_u1_u003b(index: ptr<function, u32>) -> u32 {
    let _e199 = (*index);
    let _e202 = atomicLoad((&unnamed.grid[_e199]));
    return _e202;
}

fn tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex: ptr<function, u32>, currentValue: ptr<function, u32>, targetIndex: ptr<function, u32>, newValue: ptr<function, u32>) -> bool {
    var targetValue: u32;
    var param: u32;
    var targetType: u32;
    var param_1: u32;
    var currentType: u32;
    var param_2: u32;
    var actual: u32;
    var phi_1584_: bool;
    var phi_1593_: bool;

    let _e209 = (*targetIndex);
    param = _e209;
    let _e210 = readCell_u0028_u1_u003b((&param));
    targetValue = _e210;
    let _e211 = targetValue;
    param_1 = _e211;
    let _e212 = getType_u0028_u1_u003b((&param_1));
    targetType = _e212;
    let _e213 = (*currentValue);
    param_2 = _e213;
    let _e214 = getType_u0028_u1_u003b((&param_2));
    currentType = _e214;
    let _e215 = targetType;
    let _e216 = (_e215 == 0u);
    phi_1584_ = _e216;
    if !(_e216) {
        let _e218 = currentType;
        let _e220 = currentType;
        let _e223 = targetType;
        phi_1584_ = (((_e218 == 1u) || (_e220 == 4u)) && (_e223 == 2u));
    }
    let _e227 = phi_1584_;
    phi_1593_ = _e227;
    if !(_e227) {
        let _e229 = currentType;
        let _e231 = targetType;
        phi_1593_ = ((_e229 == 6u) && (_e231 == 5u));
    }
    let _e235 = phi_1593_;
    if _e235 {
        let _e236 = (*currentIndex);
        let _e239 = (*currentValue);
        let _e240 = atomicCompareExchangeWeak((&unnamed.grid[_e236]), _e239, 0u);
        let _e242 = (*currentValue);
        if (_e240.old_value == _e242) {
            let _e244 = (*targetIndex);
            let _e247 = targetValue;
            let _e248 = (*newValue);
            let _e249 = atomicCompareExchangeWeak((&unnamed.grid[_e244]), _e247, _e248);
            actual = _e249.old_value;
            let _e251 = actual;
            let _e252 = targetValue;
            if (_e251 == _e252) {
                let _e254 = targetType;
                if (_e254 != 0u) {
                    let _e256 = (*currentIndex);
                    let _e259 = targetValue;
                    let _e260 = atomicExchange((&unnamed.grid[_e256]), _e259);
                }
                return true;
            } else {
                let _e261 = (*currentIndex);
                let _e264 = (*currentValue);
                let _e265 = atomicCompareExchangeWeak((&unnamed.grid[_e261]), 0u, _e264);
            }
        }
    }
    return false;
}

fn pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(type_33: ptr<function, u32>, dir: ptr<function, u32>, sleep: ptr<function, u32>, age: ptr<function, u32>) -> u32 {
    let _e202 = (*type_33);
    let _e204 = (*dir);
    let _e209 = (*sleep);
    let _e214 = (*age);
    return ((((_e202 & 255u) | ((_e204 & 255u) << bitcast<u32>(8i))) | ((_e209 & 255u) << bitcast<u32>(16i))) | ((_e214 & 255u) << bitcast<u32>(24i)));
}

fn getIndex_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    let _e200 = (*pos)[0u];
    let _e202 = (*pos)[1u];
    let _e204 = tuning.gridWidth;
    let _e209 = (*pos)[2u];
    let _e211 = tuning.gridWidth;
    let _e215 = tuning.gridHeight;
    return bitcast<u32>(((_e200 + (_e202 * bitcast<i32>(_e204))) + ((_e209 * bitcast<i32>(_e211)) * bitcast<i32>(_e215))));
}

fn treeInBounds_u0028_vi3_u003b(p: ptr<function, vec3<i32>>) -> bool {
    var phi_1075_: bool;
    var phi_1081_: bool;
    var phi_1091_: bool;
    var phi_1097_: bool;
    var phi_1107_: bool;

    let _e200 = (*p)[0u];
    let _e201 = (_e200 > 0i);
    phi_1075_ = _e201;
    if _e201 {
        let _e203 = (*p)[0u];
        let _e205 = tuning.gridWidth;
        phi_1075_ = (_e203 < (bitcast<i32>(_e205) - 1i));
    }
    let _e210 = phi_1075_;
    phi_1081_ = _e210;
    if _e210 {
        let _e212 = (*p)[1u];
        phi_1081_ = (_e212 > 0i);
    }
    let _e215 = phi_1081_;
    phi_1091_ = _e215;
    if _e215 {
        let _e217 = (*p)[1u];
        let _e219 = tuning.gridHeight;
        phi_1091_ = (_e217 < (bitcast<i32>(_e219) - 1i));
    }
    let _e224 = phi_1091_;
    phi_1097_ = _e224;
    if _e224 {
        let _e226 = (*p)[2u];
        phi_1097_ = (_e226 > 0i);
    }
    let _e229 = phi_1097_;
    phi_1107_ = _e229;
    if _e229 {
        let _e231 = (*p)[2u];
        let _e233 = tuning.gridDepth;
        phi_1107_ = (_e231 < (bitcast<i32>(_e233) - 1i));
    }
    let _e238 = phi_1107_;
    return _e238;
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
    var phi_6694_: bool;
    var phi_6778_: bool;
    var phi_6860_: bool;

    let _e249 = (*randVal);
    let _e253 = tuning.treeLeafTickChance;
    if (fract((_e249 * 7f)) >= _e253) {
        return;
    }
    let _e255 = (*currentAge);
    if (_e255 == 255u) {
        let _e257 = (*pos_1);
        belowPos = (_e257 + vec3<i32>(0i, -1i, 0i));
        let _e259 = belowPos;
        param_3 = _e259;
        let _e260 = treeInBounds_u0028_vi3_u003b((&param_3));
        phi_6694_ = _e260;
        if _e260 {
            let _e261 = belowPos;
            param_4 = _e261;
            let _e262 = getIndex_u0028_vi3_u003b((&param_4));
            param_5 = _e262;
            let _e263 = readCell_u0028_u1_u003b((&param_5));
            phi_6694_ = (_e263 == 0u);
        }
        let _e266 = phi_6694_;
        if _e266 {
            let _e267 = belowPos;
            param_6 = _e267;
            let _e268 = getIndex_u0028_vi3_u003b((&param_6));
            param_7 = 19u;
            param_8 = 0u;
            param_9 = 0u;
            param_10 = 255u;
            let _e269 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_7), (&param_8), (&param_9), (&param_10));
            let _e270 = (*currentIndex_1);
            param_11 = _e270;
            let _e271 = (*rawValue);
            param_12 = _e271;
            param_13 = _e268;
            param_14 = _e269;
            let _e272 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_11), (&param_12), (&param_13), (&param_14));
            if _e272 {
                return;
            }
        }
        let _e273 = (*currentIndex_1);
        let _e276 = (*rawValue);
        let _e277 = atomicCompareExchangeWeak((&unnamed.grid[_e273]), _e276, 0u);
        return;
    }
    let _e279 = (*currentAge);
    dist = _e279;
    nearest = 255u;
    touchesTrunk = false;
    let _e280 = (*randVal);
    start = i32((fract((_e280 * 71f)) * 26f));
    haveSpot = false;
    let _e285 = (*pos_1);
    spot = _e285;
    i_1 = 0i;
    loop {
        let _e286 = i_1;
        if (_e286 < 26i) {
            let _e288 = (*pos_1);
            let _e289 = start;
            let _e290 = i_1;
            let _e291 = (_e289 + _e290);
            param_15 = (_e291 - (i32(floor((f32(_e291) / f32(26i)))) * 26i));
            let _e299 = tree26_u0028_i1_u003b((&param_15));
            c = (_e288 + _e299);
            let _e301 = c;
            param_16 = _e301;
            let _e302 = treeInBounds_u0028_vi3_u003b((&param_16));
            if !(_e302) {
                continue;
            }
            let _e304 = c;
            param_17 = _e304;
            let _e305 = getIndex_u0028_vi3_u003b((&param_17));
            param_18 = _e305;
            let _e306 = readCell_u0028_u1_u003b((&param_18));
            v = _e306;
            let _e307 = v;
            param_19 = _e307;
            let _e308 = getType_u0028_u1_u003b((&param_19));
            t = _e308;
            let _e309 = t;
            let _e310 = (_e309 == 18u);
            phi_6778_ = _e310;
            if _e310 {
                let _e311 = v;
                param_20 = _e311;
                let _e312 = getDir_u0028_u1_u003b((&param_20));
                let _e315 = tuning.treeMaxHeight;
                phi_6778_ = ((_e312 + 1u) >= _e315);
            }
            let _e318 = phi_6778_;
            if _e318 {
                touchesTrunk = true;
            } else {
                let _e319 = t;
                if (_e319 == 19u) {
                    let _e321 = nearest;
                    let _e322 = v;
                    param_21 = _e322;
                    let _e323 = getAge_u0028_u1_u003b((&param_21));
                    nearest = min(_e321, _e323);
                } else {
                    let _e325 = v;
                    let _e327 = haveSpot;
                    if ((_e325 == 0u) && !(_e327)) {
                        haveSpot = true;
                        let _e330 = c;
                        spot = _e330;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e331 = i_1;
            i_1 = (_e331 + 1i);
        }
    }
    let _e333 = touchesTrunk;
    if _e333 {
        local_1 = 1u;
    } else {
        let _e334 = nearest;
        if (_e334 >= 255u) {
            local_2 = 255u;
        } else {
            let _e336 = nearest;
            local_2 = (_e336 + 1u);
        }
        let _e338 = local_2;
        local_1 = _e338;
    }
    let _e339 = local_1;
    supported = _e339;
    let _e340 = supported;
    let _e342 = tuning.treeLeafReach;
    if (_e340 > _e342) {
        let _e344 = (*randVal);
        let _e348 = tuning.treeLeafFallChance;
        if (fract((_e344 * 83f)) < _e348) {
            let _e350 = (*currentIndex_1);
            let _e353 = (*rawValue);
            param_22 = 19u;
            param_23 = 0u;
            param_24 = 0u;
            param_25 = 255u;
            let _e354 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_22), (&param_23), (&param_24), (&param_25));
            let _e355 = atomicCompareExchangeWeak((&unnamed.grid[_e350]), _e353, _e354);
        }
        return;
    }
    let _e357 = supported;
    let _e359 = tuning.treeLeafReach;
    let _e361 = haveSpot;
    let _e362 = ((_e357 < _e359) && _e361);
    phi_6860_ = _e362;
    if _e362 {
        let _e363 = (*randVal);
        let _e367 = tuning.treeLeafSpreadChance;
        phi_6860_ = (fract((_e363 * 89f)) < _e367);
    }
    let _e370 = phi_6860_;
    if _e370 {
        let _e371 = spot;
        param_26 = _e371;
        let _e372 = getIndex_u0028_vi3_u003b((&param_26));
        let _e375 = supported;
        param_27 = 19u;
        param_28 = 0u;
        param_29 = 0u;
        param_30 = (_e375 + 1u);
        let _e377 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_27), (&param_28), (&param_29), (&param_30));
        let _e378 = atomicCompareExchangeWeak((&unnamed.grid[_e372]), 0u, _e377);
    }
    let _e380 = supported;
    let _e381 = dist;
    if (_e380 != _e381) {
        let _e383 = (*currentIndex_1);
        let _e386 = (*rawValue);
        param_31 = 19u;
        param_32 = 0u;
        param_33 = 0u;
        let _e387 = supported;
        param_34 = _e387;
        let _e388 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_31), (&param_32), (&param_33), (&param_34));
        let _e389 = atomicCompareExchangeWeak((&unnamed.grid[_e383]), _e386, _e388);
    }
    return;
}

fn isGrassBlock_u0028_u1_u003b(value: ptr<function, u32>) -> bool {
    var flora: u32;
    var param_35: u32;

    let _e201 = (*value);
    flora = ((_e201 >> bitcast<u32>(8i)) & 255u);
    let _e205 = (*value);
    param_35 = _e205;
    let _e206 = getType_u0028_u1_u003b((&param_35));
    let _e208 = flora;
    let _e211 = flora;
    return (((_e206 == 4u) && (_e208 > 10u)) && (_e211 <= 100u));
}

fn getSleep_u0028_u1_u003b(val_3: ptr<function, u32>) -> u32 {
    let _e199 = (*val_3);
    return ((_e199 >> bitcast<u32>(16i)) & 255u);
}

fn getHDir_u0028_i1_u003b(d: ptr<function, i32>) -> vec3<i32> {
    let _e199 = (*d);
    if (_e199 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e201 = (*d);
    if (_e201 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e203 = (*d);
    if (_e203 == 2i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    let _e205 = (*d);
    if (_e205 == 3i) {
        return vec3<i32>(0i, 0i, -1i);
    }
    let _e207 = (*d);
    if (_e207 == 4i) {
        return vec3<i32>(1i, 0i, 1i);
    }
    let _e209 = (*d);
    if (_e209 == 5i) {
        return vec3<i32>(1i, 0i, -1i);
    }
    let _e211 = (*d);
    if (_e211 == 6i) {
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
    var phi_6248_: bool;
    var phi_6392_: bool;
    var phi_6402_: bool;
    var phi_6447_: bool;
    var phi_6498_: bool;
    var phi_6577_: bool;

    let _e284 = (*currentDir);
    height = _e284;
    let _e285 = (*currentAge_1);
    water = _e285;
    changed = false;
    let _e286 = water;
    let _e288 = tuning.treeWaterMax;
    let _e289 = (_e286 < _e288);
    phi_6248_ = _e289;
    if _e289 {
        let _e290 = (*randVal_1);
        let _e294 = tuning.treeDrinkChance;
        phi_6248_ = (fract((_e290 * 13f)) < _e294);
    }
    let _e297 = phi_6248_;
    if _e297 {
        let _e298 = (*randVal_1);
        start_1 = i32((fract((_e298 * 101f)) * 17f));
        k = 0i;
        loop {
            let _e303 = k;
            if (_e303 < 17i) {
                let _e305 = start_1;
                let _e306 = k;
                let _e307 = (_e305 + _e306);
                i_2 = (_e307 - (i32(floor((f32(_e307) / f32(17i)))) * 17i));
                let _e315 = i_2;
                if (_e315 == 0i) {
                    let _e317 = (*pos_2);
                    local_3 = (_e317 + vec3<i32>(0i, -1i, 0i));
                } else {
                    let _e319 = i_2;
                    if (_e319 < 9i) {
                        let _e321 = (*pos_2);
                        let _e322 = i_2;
                        param_36 = (_e322 - 1i);
                        let _e324 = getHDir_u0028_i1_u003b((&param_36));
                        local_4 = ((_e321 + _e324) + vec3<i32>(0i, -1i, 0i));
                    } else {
                        let _e327 = (*pos_2);
                        let _e328 = i_2;
                        param_37 = (_e328 - 9i);
                        let _e330 = getHDir_u0028_i1_u003b((&param_37));
                        local_4 = (_e327 + _e330);
                    }
                    let _e332 = local_4;
                    local_3 = _e332;
                }
                let _e333 = local_3;
                c_1 = _e333;
                let _e334 = c_1;
                param_38 = _e334;
                let _e335 = treeInBounds_u0028_vi3_u003b((&param_38));
                if !(_e335) {
                    continue;
                }
                let _e337 = c_1;
                param_39 = _e337;
                let _e338 = getIndex_u0028_vi3_u003b((&param_39));
                idx = _e338;
                let _e339 = idx;
                param_40 = _e339;
                let _e340 = readCell_u0028_u1_u003b((&param_40));
                v_1 = _e340;
                let _e341 = v_1;
                param_41 = _e341;
                let _e342 = getType_u0028_u1_u003b((&param_41));
                if (_e342 != 4u) {
                    continue;
                }
                let _e344 = v_1;
                param_42 = _e344;
                let _e345 = getAge_u0028_u1_u003b((&param_42));
                moisture = _e345;
                let _e346 = moisture;
                let _e348 = tuning.treeSoilReserve;
                if (_e346 <= _e348) {
                    continue;
                }
                let _e350 = idx;
                let _e353 = v_1;
                let _e354 = v_1;
                param_43 = _e354;
                let _e355 = getDir_u0028_u1_u003b((&param_43));
                let _e356 = v_1;
                param_44 = _e356;
                let _e357 = getSleep_u0028_u1_u003b((&param_44));
                let _e358 = moisture;
                param_45 = 4u;
                param_46 = _e355;
                param_47 = _e357;
                param_48 = (_e358 - 1u);
                let _e360 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_45), (&param_46), (&param_47), (&param_48));
                let _e361 = atomicCompareExchangeWeak((&unnamed.grid[_e350]), _e353, _e360);
                let _e363 = v_1;
                if (_e361.old_value == _e363) {
                    let _e365 = water;
                    water = (_e365 + 1u);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e367 = k;
                k = (_e367 + 1i);
            }
        }
    }
    let _e369 = (*pos_2);
    upPos = (_e369 + vec3<i32>(0i, 1i, 0i));
    upIsTrunk = false;
    upValue = 0u;
    upIndex = 0u;
    let _e371 = upPos;
    param_49 = _e371;
    let _e372 = treeInBounds_u0028_vi3_u003b((&param_49));
    if _e372 {
        let _e373 = upPos;
        param_50 = _e373;
        let _e374 = getIndex_u0028_vi3_u003b((&param_50));
        upIndex = _e374;
        let _e375 = upIndex;
        param_51 = _e375;
        let _e376 = readCell_u0028_u1_u003b((&param_51));
        upValue = _e376;
        let _e377 = upValue;
        param_52 = _e377;
        let _e378 = getType_u0028_u1_u003b((&param_52));
        upIsTrunk = (_e378 == 18u);
    }
    let _e380 = upIsTrunk;
    let _e381 = water;
    let _e383 = (_e380 && (_e381 > 0u));
    phi_6392_ = _e383;
    if _e383 {
        let _e384 = upValue;
        param_53 = _e384;
        let _e385 = getAge_u0028_u1_u003b((&param_53));
        phi_6392_ = (_e385 < 255u);
    }
    let _e388 = phi_6392_;
    phi_6402_ = _e388;
    if _e388 {
        let _e389 = (*randVal_1);
        let _e393 = tuning.treeFlowChance;
        phi_6402_ = (fract((_e389 * 29f)) < _e393);
    }
    let _e396 = phi_6402_;
    if _e396 {
        let _e397 = upValue;
        param_54 = _e397;
        let _e398 = getDir_u0028_u1_u003b((&param_54));
        let _e399 = upValue;
        param_55 = _e399;
        let _e400 = getAge_u0028_u1_u003b((&param_55));
        param_56 = 18u;
        param_57 = _e398;
        param_58 = 0u;
        param_59 = (_e400 + 1u);
        let _e402 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_56), (&param_57), (&param_58), (&param_59));
        lifted = _e402;
        let _e403 = upIndex;
        let _e406 = upValue;
        let _e407 = lifted;
        let _e408 = atomicCompareExchangeWeak((&unnamed.grid[_e403]), _e406, _e407);
        let _e410 = upValue;
        if (_e408.old_value == _e410) {
            let _e412 = water;
            water = (_e412 - 1u);
            changed = true;
        }
    }
    let _e414 = height;
    let _e417 = tuning.treeMaxHeight;
    if ((_e414 + 1u) < _e417) {
        let _e419 = water;
        let _e421 = tuning.treeGrowCost;
        let _e422 = (_e419 >= _e421);
        phi_6447_ = _e422;
        if _e422 {
            let _e423 = upPos;
            param_60 = _e423;
            let _e424 = treeInBounds_u0028_vi3_u003b((&param_60));
            phi_6447_ = _e424;
        }
        let _e426 = phi_6447_;
        if _e426 {
            let _e427 = upValue;
            param_61 = _e427;
            let _e428 = getType_u0028_u1_u003b((&param_61));
            upType = _e428;
            let _e429 = upType;
            let _e431 = upType;
            if ((_e429 == 0u) || (_e431 == 19u)) {
                let _e434 = height;
                param_62 = 18u;
                param_63 = (_e434 + 1u);
                param_64 = 0u;
                param_65 = 0u;
                let _e436 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_62), (&param_63), (&param_64), (&param_65));
                sapling = _e436;
                let _e437 = upIndex;
                let _e440 = upValue;
                let _e441 = sapling;
                let _e442 = atomicCompareExchangeWeak((&unnamed.grid[_e437]), _e440, _e441);
                let _e444 = upValue;
                if (_e442.old_value == _e444) {
                    let _e447 = tuning.treeGrowCost;
                    let _e448 = water;
                    water = (_e448 - _e447);
                    changed = true;
                }
            }
        }
    } else {
        let _e450 = water;
        let _e452 = tuning.treeLeafCost;
        let _e453 = (_e450 >= _e452);
        phi_6498_ = _e453;
        if _e453 {
            let _e454 = (*randVal_1);
            let _e458 = tuning.treeLeafChance;
            phi_6498_ = (fract((_e454 * 37f)) < _e458);
        }
        let _e461 = phi_6498_;
        if _e461 {
            let _e462 = (*randVal_1);
            start_2 = i32((fract((_e462 * 43f)) * 26f));
            i_3 = 0i;
            loop {
                let _e467 = i_3;
                if (_e467 < 26i) {
                    let _e469 = (*pos_2);
                    let _e470 = start_2;
                    let _e471 = i_3;
                    let _e472 = (_e470 + _e471);
                    param_66 = (_e472 - (i32(floor((f32(_e472) / f32(26i)))) * 26i));
                    let _e480 = tree26_u0028_i1_u003b((&param_66));
                    c_2 = (_e469 + _e480);
                    let _e482 = c_2;
                    param_67 = _e482;
                    let _e483 = treeInBounds_u0028_vi3_u003b((&param_67));
                    if !(_e483) {
                        continue;
                    }
                    let _e485 = c_2;
                    param_68 = _e485;
                    let _e486 = getIndex_u0028_vi3_u003b((&param_68));
                    idx_1 = _e486;
                    let _e487 = idx_1;
                    param_69 = _e487;
                    let _e488 = readCell_u0028_u1_u003b((&param_69));
                    if (_e488 != 0u) {
                        continue;
                    }
                    let _e490 = idx_1;
                    param_70 = 19u;
                    param_71 = 0u;
                    param_72 = 0u;
                    param_73 = 1u;
                    let _e493 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_70), (&param_71), (&param_72), (&param_73));
                    let _e494 = atomicCompareExchangeWeak((&unnamed.grid[_e490]), 0u, _e493);
                    if (_e494.old_value == 0u) {
                        let _e498 = tuning.treeLeafCost;
                        let _e499 = water;
                        water = (_e499 - _e498);
                        changed = true;
                        break;
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e501 = i_3;
                    i_3 = (_e501 + 1i);
                }
            }
        }
    }
    let _e503 = water;
    let _e505 = tuning.treeSpreadCost;
    let _e506 = (_e503 >= _e505);
    phi_6577_ = _e506;
    if _e506 {
        let _e507 = (*randVal_1);
        let _e511 = tuning.treeSpreadChance;
        phi_6577_ = (fract((_e507 * 59f)) < _e511);
    }
    let _e514 = phi_6577_;
    if _e514 {
        let _e515 = (*randVal_1);
        start_3 = i32((fract((_e515 * 61f)) * 8f));
        i_4 = 0i;
        loop {
            let _e520 = i_4;
            if (_e520 < 8i) {
                let _e522 = (*pos_2);
                let _e523 = start_3;
                let _e524 = i_4;
                let _e525 = (_e523 + _e524);
                param_74 = (_e525 - (i32(floor((f32(_e525) / f32(8i)))) * 8i));
                let _e533 = getHDir_u0028_i1_u003b((&param_74));
                c_3 = (_e522 + _e533);
                let _e535 = c_3;
                param_75 = _e535;
                let _e536 = treeInBounds_u0028_vi3_u003b((&param_75));
                if !(_e536) {
                    continue;
                }
                let _e538 = c_3;
                param_76 = _e538;
                let _e539 = getIndex_u0028_vi3_u003b((&param_76));
                idx_2 = _e539;
                let _e540 = idx_2;
                param_77 = _e540;
                let _e541 = readCell_u0028_u1_u003b((&param_77));
                if (_e541 != 0u) {
                    continue;
                }
                let _e543 = c_3;
                param_78 = (_e543 + vec3<i32>(0i, -1i, 0i));
                let _e545 = getIndex_u0028_vi3_u003b((&param_78));
                param_79 = _e545;
                let _e546 = readCell_u0028_u1_u003b((&param_79));
                param_80 = _e546;
                let _e547 = isGrassBlock_u0028_u1_u003b((&param_80));
                if !(_e547) {
                    continue;
                }
                let _e549 = idx_2;
                param_81 = 18u;
                param_82 = 0u;
                param_83 = 0u;
                param_84 = 0u;
                let _e552 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_81), (&param_82), (&param_83), (&param_84));
                let _e553 = atomicCompareExchangeWeak((&unnamed.grid[_e549]), 0u, _e552);
                if (_e553.old_value == 0u) {
                    let _e557 = tuning.treeSpreadCost;
                    let _e558 = water;
                    water = (_e558 - _e557);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e560 = i_4;
                i_4 = (_e560 + 1i);
            }
        }
    }
    let _e562 = changed;
    if _e562 {
        let _e563 = (*currentIndex_2);
        let _e566 = (*rawValue_1);
        param_85 = 18u;
        let _e567 = height;
        param_86 = _e567;
        param_87 = 0u;
        let _e568 = water;
        param_88 = _e568;
        let _e569 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_85), (&param_86), (&param_87), (&param_88));
        let _e570 = atomicCompareExchangeWeak((&unnamed.grid[_e563]), _e566, _e569);
    }
    return;
}

fn locustPackNav_u0028_u1_u003b_u1_u003b(heading: ptr<function, u32>, steps: ptr<function, u32>) -> u32 {
    let _e200 = (*heading);
    let _e202 = (*steps);
    return ((_e200 & 7u) | (min(_e202, 7u) << bitcast<u32>(3i)));
}

fn locustReverse_u0028_u1_u003b(d_1: ptr<function, u32>) -> u32 {
    let _e199 = (*d_1);
    if (_e199 == 0u) {
        return 1u;
    }
    let _e201 = (*d_1);
    if (_e201 == 1u) {
        return 0u;
    }
    let _e203 = (*d_1);
    if (_e203 == 2u) {
        return 3u;
    }
    let _e205 = (*d_1);
    if (_e205 == 3u) {
        return 2u;
    }
    let _e207 = (*d_1);
    if (_e207 == 4u) {
        return 7u;
    }
    let _e209 = (*d_1);
    if (_e209 == 5u) {
        return 6u;
    }
    let _e211 = (*d_1);
    if (_e211 == 6u) {
        return 5u;
    }
    return 4u;
}

fn locustRunSteps_u0028_() -> u32 {
    let _e199 = tuning.locustRunLength;
    return clamp(_e199, 1u, 7u);
}

fn isLocustFood_u0028_u1_u003b(value_1: ptr<function, u32>) -> bool {
    var param_89: u32;
    var param_90: u32;
    var phi_866_: bool;

    let _e201 = (*value_1);
    param_89 = _e201;
    let _e202 = isGrassBlock_u0028_u1_u003b((&param_89));
    phi_866_ = _e202;
    if !(_e202) {
        let _e204 = (*value_1);
        param_90 = _e204;
        let _e205 = getType_u0028_u1_u003b((&param_90));
        phi_866_ = (_e205 == 19u);
    }
    let _e208 = phi_866_;
    return _e208;
}

fn locustFoodAt_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> bool {
    var param_91: vec3<i32>;
    var param_92: u32;
    var param_93: u32;
    var phi_881_: bool;
    var phi_888_: bool;
    var phi_898_: bool;
    var phi_905_: bool;
    var phi_915_: bool;

    let _e203 = (*p_1)[0u];
    let _e204 = (_e203 < 0i);
    phi_881_ = _e204;
    if !(_e204) {
        let _e207 = (*p_1)[0u];
        let _e209 = tuning.gridWidth;
        phi_881_ = (_e207 >= bitcast<i32>(_e209));
    }
    let _e213 = phi_881_;
    phi_888_ = _e213;
    if !(_e213) {
        let _e216 = (*p_1)[1u];
        phi_888_ = (_e216 < 0i);
    }
    let _e219 = phi_888_;
    phi_898_ = _e219;
    if !(_e219) {
        let _e222 = (*p_1)[1u];
        let _e224 = tuning.gridHeight;
        phi_898_ = (_e222 >= bitcast<i32>(_e224));
    }
    let _e228 = phi_898_;
    phi_905_ = _e228;
    if !(_e228) {
        let _e231 = (*p_1)[2u];
        phi_905_ = (_e231 < 0i);
    }
    let _e234 = phi_905_;
    phi_915_ = _e234;
    if !(_e234) {
        let _e237 = (*p_1)[2u];
        let _e239 = tuning.gridDepth;
        phi_915_ = (_e237 >= bitcast<i32>(_e239));
    }
    let _e243 = phi_915_;
    if _e243 {
        return false;
    }
    let _e244 = (*p_1);
    param_91 = _e244;
    let _e245 = getIndex_u0028_vi3_u003b((&param_91));
    param_92 = _e245;
    let _e246 = readCell_u0028_u1_u003b((&param_92));
    param_93 = _e246;
    let _e247 = isLocustFood_u0028_u1_u003b((&param_93));
    return _e247;
}

fn locustSteps_u0028_u1_u003b(dirByte: ptr<function, u32>) -> u32 {
    let _e199 = (*dirByte);
    return ((_e199 >> bitcast<u32>(3i)) & 7u);
}

fn locustHeading_u0028_u1_u003b(dirByte_1: ptr<function, u32>) -> u32 {
    let _e199 = (*dirByte_1);
    return (_e199 & 7u);
}

fn locustArriveDir_u0028_vi3_u003b_u1_u003b(dest: ptr<function, vec3<i32>>, nav: ptr<function, u32>) -> u32 {
    var param_94: vec3<i32>;

    let _e201 = (*dest);
    param_94 = (_e201 + vec3<i32>(0i, -1i, 0i));
    let _e203 = locustFoodAt_u0028_vi3_u003b((&param_94));
    let _e204 = (*nav);
    return select(_e204, 0u, _e203);
}

fn locustHasGrip_u0028_vi3_u003b(pos_3: ptr<function, vec3<i32>>) -> bool {
    var d_2: i32;
    var n: vec3<i32>;
    var param_95: i32;
    var param_96: vec3<i32>;
    var param_97: u32;
    var phi_1019_: bool;
    var phi_1026_: bool;
    var phi_1037_: bool;

    d_2 = 0i;
    loop {
        let _e204 = d_2;
        if (_e204 < 8i) {
            let _e206 = (*pos_3);
            let _e207 = d_2;
            param_95 = _e207;
            let _e208 = getHDir_u0028_i1_u003b((&param_95));
            n = (_e206 + _e208);
            let _e211 = n[0u];
            let _e212 = (_e211 <= 0i);
            phi_1019_ = _e212;
            if !(_e212) {
                let _e215 = n[0u];
                let _e217 = tuning.gridWidth;
                phi_1019_ = (_e215 >= (bitcast<i32>(_e217) - 1i));
            }
            let _e222 = phi_1019_;
            phi_1026_ = _e222;
            if !(_e222) {
                let _e225 = n[2u];
                phi_1026_ = (_e225 <= 0i);
            }
            let _e228 = phi_1026_;
            phi_1037_ = _e228;
            if !(_e228) {
                let _e231 = n[2u];
                let _e233 = tuning.gridDepth;
                phi_1037_ = (_e231 >= (bitcast<i32>(_e233) - 1i));
            }
            let _e238 = phi_1037_;
            if _e238 {
                continue;
            }
            let _e239 = n;
            param_96 = _e239;
            let _e240 = getIndex_u0028_vi3_u003b((&param_96));
            param_97 = _e240;
            let _e241 = readCell_u0028_u1_u003b((&param_97));
            if (_e241 != 0u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e243 = d_2;
            d_2 = (_e243 + 1i);
        }
    }
    return false;
}

fn locustInBounds_u0028_vi3_u003b(p_2: ptr<function, vec3<i32>>) -> bool {
    var phi_802_: bool;
    var phi_808_: bool;
    var phi_818_: bool;
    var phi_824_: bool;
    var phi_834_: bool;

    let _e200 = (*p_2)[0u];
    let _e201 = (_e200 > 0i);
    phi_802_ = _e201;
    if _e201 {
        let _e203 = (*p_2)[0u];
        let _e205 = tuning.gridWidth;
        phi_802_ = (_e203 < (bitcast<i32>(_e205) - 1i));
    }
    let _e210 = phi_802_;
    phi_808_ = _e210;
    if _e210 {
        let _e212 = (*p_2)[1u];
        phi_808_ = (_e212 > 0i);
    }
    let _e215 = phi_808_;
    phi_818_ = _e215;
    if _e215 {
        let _e217 = (*p_2)[1u];
        let _e219 = tuning.gridHeight;
        phi_818_ = (_e217 < (bitcast<i32>(_e219) - 1i));
    }
    let _e224 = phi_818_;
    phi_824_ = _e224;
    if _e224 {
        let _e226 = (*p_2)[2u];
        phi_824_ = (_e226 > 0i);
    }
    let _e229 = phi_824_;
    phi_834_ = _e229;
    if _e229 {
        let _e231 = (*p_2)[2u];
        let _e233 = tuning.gridDepth;
        phi_834_ = (_e231 < (bitcast<i32>(_e233) - 1i));
    }
    let _e238 = phi_834_;
    return _e238;
}

fn locustStage_u0028_() -> u32 {
    let _e199 = tuning.locustStageSize;
    return max(_e199, 1u);
}

fn locustTypeFor_u0028_u1_u003b(count: ptr<function, u32>) -> u32 {
    var stage: u32;
    var local_5: u32;

    let _e201 = (*count);
    if (_e201 == 0u) {
        local_5 = 0u;
    } else {
        let _e203 = (*count);
        let _e205 = locustStage_u0028_();
        local_5 = ((_e203 - 1u) / _e205);
    }
    let _e207 = local_5;
    stage = _e207;
    let _e208 = stage;
    return (13u + min(_e208, 4u));
}

fn locustMaxCount_u0028_() -> u32 {
    let _e199 = tuning.locustMaxSize;
    return max(_e199, 1u);
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

    let _e216 = tuning.locustBudSize;
    let _e217 = locustMaxCount_u0028_();
    bud = clamp(_e216, 1u, _e217);
    let _e219 = (*randVal_2);
    start_4 = i32((fract((_e219 * 31f)) * 8f));
    i_5 = 0i;
    loop {
        let _e224 = i_5;
        if (_e224 < 8i) {
            let _e226 = start_4;
            let _e227 = i_5;
            let _e228 = (_e226 + _e227);
            d_3 = (_e228 - (i32(floor((f32(_e228) / f32(8i)))) * 8i));
            let _e236 = (*pos_4);
            let _e237 = d_3;
            param_98 = _e237;
            let _e238 = getHDir_u0028_i1_u003b((&param_98));
            c_4 = (_e236 + _e238);
            let _e240 = c_4;
            param_99 = _e240;
            let _e241 = locustInBounds_u0028_vi3_u003b((&param_99));
            if !(_e241) {
                continue;
            }
            let _e243 = c_4;
            param_100 = _e243;
            let _e244 = getIndex_u0028_vi3_u003b((&param_100));
            idx_3 = _e244;
            let _e245 = idx_3;
            param_101 = _e245;
            let _e246 = readCell_u0028_u1_u003b((&param_101));
            if (_e246 != 0u) {
                continue;
            }
            let _e248 = idx_3;
            let _e251 = bud;
            param_102 = _e251;
            let _e252 = locustTypeFor_u0028_u1_u003b((&param_102));
            param_103 = _e252;
            param_104 = 0u;
            param_105 = 0u;
            let _e253 = bud;
            param_106 = _e253;
            let _e254 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_103), (&param_104), (&param_105), (&param_106));
            let _e255 = atomicCompareExchangeWeak((&unnamed.grid[_e248]), 0u, _e254);
            if (_e255.old_value == 0u) {
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e258 = i_5;
            i_5 = (_e258 + 1i);
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

    let _e205 = tuning.locustEatTicksMin;
    fast = _e205;
    let _e207 = tuning.locustEatTicksMax;
    slow = _e207;
    let _e208 = locustMaxCount_u0028_();
    cap = _e208;
    let _e209 = locustStage_u0028_();
    let _e210 = cap;
    floorCount = min(_e209, _e210);
    let _e212 = (*count_1);
    let _e213 = cap;
    if (_e212 >= _e213) {
        let _e215 = fast;
        return _e215;
    }
    let _e216 = (*count_1);
    let _e217 = floorCount;
    let _e219 = cap;
    let _e220 = floorCount;
    if ((_e216 <= _e217) || (_e219 == _e220)) {
        let _e223 = slow;
        return _e223;
    }
    let _e224 = (*count_1);
    let _e225 = floorCount;
    let _e228 = cap;
    let _e229 = floorCount;
    t_1 = (f32((_e224 - _e225)) / f32((_e228 - _e229)));
    let _e233 = slow;
    let _e235 = fast;
    let _e237 = t_1;
    return u32(round(mix(f32(_e233), f32(_e235), _e237)));
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
    var phi_7159_: bool;
    var phi_7166_: bool;
    var phi_7327_: bool;
    var phi_7346_: bool;
    var phi_7375_: bool;
    var phi_7389_: bool;
    var phi_7391_: bool;
    var phi_7483_: bool;
    var phi_7532_: bool;

    let _e382 = (*rawValue_2);
    param_107 = _e382;
    let _e383 = getType_u0028_u1_u003b((&param_107));
    type_34 = _e383;
    let _e384 = (*currentSleep);
    phase = (_e384 + 1u);
    let _e386 = phase;
    let _e388 = tuning.locustTickDispatches;
    if (_e386 < _e388) {
        let _e390 = (*currentIndex_3);
        let _e393 = (*rawValue_2);
        let _e394 = type_34;
        param_108 = _e394;
        let _e395 = (*currentDir_1);
        param_109 = _e395;
        let _e396 = phase;
        param_110 = _e396;
        let _e397 = (*currentAge_2);
        param_111 = _e397;
        let _e398 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_108), (&param_109), (&param_110), (&param_111));
        let _e399 = atomicCompareExchangeWeak((&unnamed.grid[_e390]), _e393, _e398);
        return;
    }
    let _e401 = (*currentAge_2);
    count_2 = _e401;
    let _e402 = (*pos_5);
    belowPos_1 = (_e402 + vec3<i32>(0i, -1i, 0i));
    let _e404 = belowPos_1;
    param_112 = _e404;
    let _e405 = getIndex_u0028_vi3_u003b((&param_112));
    belowIndex = _e405;
    let _e406 = belowIndex;
    param_113 = _e406;
    let _e407 = readCell_u0028_u1_u003b((&param_113));
    belowValue = _e407;
    let _e408 = belowValue;
    param_114 = _e408;
    let _e409 = isLocustFood_u0028_u1_u003b((&param_114));
    if _e409 {
        let _e410 = belowValue;
        param_115 = _e410;
        let _e411 = getType_u0028_u1_u003b((&param_115));
        onLeaf = (_e411 == 19u);
        let _e413 = count_2;
        param_116 = _e413;
        let _e414 = locustEatTicks_u0028_u1_u003b((&param_116));
        need = _e414;
        let _e415 = (*currentDir_1);
        progress = (_e415 + 1u);
        let _e417 = progress;
        let _e418 = need;
        if (_e417 < _e418) {
            let _e420 = onLeaf;
            if !(_e420) {
                let _e422 = belowValue;
                flora_1 = ((_e422 >> bitcast<u32>(8i)) & 255u);
                let _e426 = need;
                bite = max((90u / max(_e426, 1u)), 1u);
                let _e430 = flora_1;
                let _e431 = bite;
                if (_e430 > (11u + _e431)) {
                    let _e434 = flora_1;
                    let _e435 = bite;
                    local_6 = (_e434 - _e435);
                } else {
                    local_6 = 11u;
                }
                let _e437 = local_6;
                thinned = _e437;
                let _e438 = belowIndex;
                let _e441 = belowValue;
                let _e442 = belowValue;
                param_117 = _e442;
                let _e443 = getSleep_u0028_u1_u003b((&param_117));
                let _e444 = belowValue;
                param_118 = _e444;
                let _e445 = getAge_u0028_u1_u003b((&param_118));
                param_119 = 4u;
                let _e446 = thinned;
                param_120 = _e446;
                param_121 = _e443;
                param_122 = _e445;
                let _e447 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_119), (&param_120), (&param_121), (&param_122));
                let _e448 = atomicCompareExchangeWeak((&unnamed.grid[_e438]), _e441, _e447);
            }
            let _e450 = (*currentIndex_3);
            let _e453 = (*rawValue_2);
            let _e454 = type_34;
            param_123 = _e454;
            let _e455 = progress;
            param_124 = _e455;
            param_125 = 0u;
            let _e456 = count_2;
            param_126 = _e456;
            let _e457 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_123), (&param_124), (&param_125), (&param_126));
            let _e458 = atomicCompareExchangeWeak((&unnamed.grid[_e450]), _e453, _e457);
            return;
        }
        let _e460 = onLeaf;
        if _e460 {
            local_7 = 0u;
        } else {
            let _e461 = belowValue;
            param_127 = _e461;
            let _e462 = getSleep_u0028_u1_u003b((&param_127));
            let _e463 = belowValue;
            param_128 = _e463;
            let _e464 = getAge_u0028_u1_u003b((&param_128));
            param_129 = 4u;
            param_130 = 0u;
            param_131 = _e462;
            param_132 = _e464;
            let _e465 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_129), (&param_130), (&param_131), (&param_132));
            local_7 = _e465;
        }
        let _e466 = local_7;
        stripped = _e466;
        let _e467 = belowIndex;
        let _e470 = belowValue;
        let _e471 = stripped;
        let _e472 = atomicCompareExchangeWeak((&unnamed.grid[_e467]), _e470, _e471);
        let _e474 = belowValue;
        if (_e472.old_value != _e474) {
            return;
        }
        let _e476 = count_2;
        let _e478 = tuning.locustEatGain;
        grown = (_e476 + _e478);
        let _e480 = grown;
        let _e481 = locustMaxCount_u0028_();
        if (_e480 > _e481) {
            let _e483 = (*pos_5);
            param_133 = _e483;
            let _e484 = (*randVal_3);
            param_134 = _e484;
            locustBud_u0028_vi3_u003b_f1_u003b((&param_133), (&param_134));
            let _e485 = locustMaxCount_u0028_();
            grown = _e485;
        }
        let _e486 = (*currentIndex_3);
        let _e489 = (*rawValue_2);
        let _e490 = grown;
        param_135 = _e490;
        let _e491 = locustTypeFor_u0028_u1_u003b((&param_135));
        param_136 = _e491;
        param_137 = 0u;
        param_138 = 0u;
        let _e492 = grown;
        param_139 = _e492;
        let _e493 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_136), (&param_137), (&param_138), (&param_139));
        let _e494 = atomicCompareExchangeWeak((&unnamed.grid[_e486]), _e489, _e493);
        return;
    }
    let _e496 = count_2;
    if (_e496 <= 1u) {
        let _e498 = (*currentIndex_3);
        let _e501 = (*rawValue_2);
        let _e502 = atomicCompareExchangeWeak((&unnamed.grid[_e498]), _e501, 0u);
        return;
    }
    let _e504 = count_2;
    count_2 = (_e504 - 1u);
    let _e506 = count_2;
    param_140 = _e506;
    let _e507 = locustTypeFor_u0028_u1_u003b((&param_140));
    newType = _e507;
    let _e508 = belowValue;
    param_141 = _e508;
    let _e509 = getType_u0028_u1_u003b((&param_141));
    let _e510 = (_e509 == 0u);
    phi_7159_ = _e510;
    if _e510 {
        let _e511 = belowPos_1;
        param_142 = _e511;
        let _e512 = locustInBounds_u0028_vi3_u003b((&param_142));
        phi_7159_ = _e512;
    }
    let _e514 = phi_7159_;
    phi_7166_ = _e514;
    if _e514 {
        let _e515 = (*pos_5);
        param_143 = _e515;
        let _e516 = locustHasGrip_u0028_vi3_u003b((&param_143));
        phi_7166_ = !(_e516);
    }
    let _e519 = phi_7166_;
    if _e519 {
        let _e520 = belowPos_1;
        param_144 = _e520;
        let _e521 = (*currentDir_1);
        param_145 = _e521;
        let _e522 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_144), (&param_145));
        let _e523 = newType;
        param_146 = _e523;
        param_147 = _e522;
        param_148 = 0u;
        let _e524 = count_2;
        param_149 = _e524;
        let _e525 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_146), (&param_147), (&param_148), (&param_149));
        let _e526 = (*currentIndex_3);
        param_150 = _e526;
        let _e527 = (*rawValue_2);
        param_151 = _e527;
        let _e528 = belowIndex;
        param_152 = _e528;
        param_153 = _e525;
        let _e529 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_150), (&param_151), (&param_152), (&param_153));
        if _e529 {
            return;
        }
    }
    let _e530 = (*currentDir_1);
    param_154 = _e530;
    let _e531 = locustHeading_u0028_u1_u003b((&param_154));
    heading_1 = _e531;
    let _e532 = (*currentDir_1);
    param_155 = _e532;
    let _e533 = locustSteps_u0028_u1_u003b((&param_155));
    steps_1 = _e533;
    let _e534 = steps_1;
    if (_e534 == 0u) {
        let _e536 = (*randVal_3);
        start_5 = i32((fract((_e536 * 17f)) * 8f));
        i_6 = 0i;
        loop {
            let _e541 = i_6;
            if (_e541 < 8i) {
                let _e543 = start_5;
                let _e544 = i_6;
                let _e545 = (_e543 + _e544);
                d_4 = (_e545 - (i32(floor((f32(_e545) / f32(8i)))) * 8i));
                let _e553 = (*pos_5);
                let _e554 = d_4;
                param_156 = _e554;
                let _e555 = getHDir_u0028_i1_u003b((&param_156));
                c_5 = (_e553 + _e555);
                rise = 0i;
                loop {
                    let _e557 = rise;
                    if (_e557 < 3i) {
                        let _e559 = c_5;
                        let _e560 = rise;
                        if (_e560 == 1i) {
                            local_8 = 1i;
                        } else {
                            let _e562 = rise;
                            local_8 = select(0i, -1i, (_e562 == 2i));
                        }
                        let _e565 = local_8;
                        t_2 = (_e559 + vec3<i32>(0i, _e565, 0i));
                        let _e568 = t_2;
                        param_157 = _e568;
                        let _e569 = locustInBounds_u0028_vi3_u003b((&param_157));
                        if !(_e569) {
                            continue;
                        }
                        let _e571 = t_2;
                        param_158 = _e571;
                        let _e572 = getIndex_u0028_vi3_u003b((&param_158));
                        param_159 = _e572;
                        let _e573 = readCell_u0028_u1_u003b((&param_159));
                        if (_e573 != 0u) {
                            continue;
                        }
                        let _e575 = t_2;
                        param_160 = (_e575 + vec3<i32>(0i, -1i, 0i));
                        let _e577 = locustFoodAt_u0028_vi3_u003b((&param_160));
                        if !(_e577) {
                            continue;
                        }
                        let _e579 = t_2;
                        param_161 = _e579;
                        let _e580 = getIndex_u0028_vi3_u003b((&param_161));
                        let _e581 = newType;
                        param_162 = _e581;
                        param_163 = 0u;
                        param_164 = 0u;
                        let _e582 = count_2;
                        param_165 = _e582;
                        let _e583 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_162), (&param_163), (&param_164), (&param_165));
                        let _e584 = (*currentIndex_3);
                        param_166 = _e584;
                        let _e585 = (*rawValue_2);
                        param_167 = _e585;
                        param_168 = _e580;
                        param_169 = _e583;
                        let _e586 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_166), (&param_167), (&param_168), (&param_169));
                        if _e586 {
                            return;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e587 = rise;
                        rise = (_e587 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e589 = i_6;
                i_6 = (_e589 + 1i);
            }
        }
        let _e591 = (*randVal_3);
        heading_1 = (u32((fract((_e591 * 23f)) * 8f)) & 7u);
        let _e597 = locustRunSteps_u0028_();
        steps_1 = _e597;
    }
    let _e598 = (*pos_5);
    let _e599 = heading_1;
    param_170 = bitcast<i32>(_e599);
    let _e601 = getHDir_u0028_i1_u003b((&param_170));
    target_ = (_e598 + _e601);
    let _e603 = target_;
    param_171 = _e603;
    let _e604 = locustInBounds_u0028_vi3_u003b((&param_171));
    let _e605 = !(_e604);
    phi_7327_ = _e605;
    if !(_e605) {
        let _e607 = target_;
        param_172 = _e607;
        let _e608 = getIndex_u0028_vi3_u003b((&param_172));
        param_173 = _e608;
        let _e609 = readCell_u0028_u1_u003b((&param_173));
        phi_7327_ = (_e609 != 0u);
    }
    let _e612 = phi_7327_;
    blocked = _e612;
    let _e613 = blocked;
    if !(_e613) {
        let _e615 = target_;
        footing = (_e615 + vec3<i32>(0i, -1i, 0i));
        let _e617 = footing;
        param_174 = _e617;
        let _e618 = locustInBounds_u0028_vi3_u003b((&param_174));
        phi_7346_ = _e618;
        if _e618 {
            let _e619 = footing;
            param_175 = _e619;
            let _e620 = getIndex_u0028_vi3_u003b((&param_175));
            param_176 = _e620;
            let _e621 = readCell_u0028_u1_u003b((&param_176));
            phi_7346_ = (_e621 == 0u);
        }
        let _e624 = phi_7346_;
        if _e624 {
            let _e625 = heading_1;
            param_177 = _e625;
            let _e626 = locustReverse_u0028_u1_u003b((&param_177));
            back = _e626;
            let _e627 = (*pos_5);
            let _e628 = back;
            param_178 = bitcast<i32>(_e628);
            let _e630 = getHDir_u0028_i1_u003b((&param_178));
            backPos = (_e627 + _e630);
            let _e632 = backPos;
            backFoot = (_e632 + vec3<i32>(0i, -1i, 0i));
            let _e634 = backPos;
            param_179 = _e634;
            let _e635 = locustInBounds_u0028_vi3_u003b((&param_179));
            phi_7375_ = _e635;
            if _e635 {
                let _e636 = backPos;
                param_180 = _e636;
                let _e637 = getIndex_u0028_vi3_u003b((&param_180));
                param_181 = _e637;
                let _e638 = readCell_u0028_u1_u003b((&param_181));
                phi_7375_ = (_e638 == 0u);
            }
            let _e641 = phi_7375_;
            phi_7391_ = _e641;
            if _e641 {
                let _e642 = backFoot;
                param_182 = _e642;
                let _e643 = locustInBounds_u0028_vi3_u003b((&param_182));
                phi_7389_ = _e643;
                if _e643 {
                    let _e644 = backFoot;
                    param_183 = _e644;
                    let _e645 = getIndex_u0028_vi3_u003b((&param_183));
                    param_184 = _e645;
                    let _e646 = readCell_u0028_u1_u003b((&param_184));
                    phi_7389_ = (_e646 == 0u);
                }
                let _e649 = phi_7389_;
                phi_7391_ = !(_e649);
            }
            let _e652 = phi_7391_;
            backOpen = _e652;
            let _e653 = backOpen;
            if _e653 {
                let _e654 = back;
                param_185 = _e654;
                let _e655 = steps_1;
                param_186 = _e655;
                let _e656 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_185), (&param_186));
                local_9 = _e656;
            } else {
                let _e657 = (*randVal_3);
                let _e663 = locustRunSteps_u0028_();
                param_187 = (u32((fract((_e657 * 71f)) * 8f)) & 7u);
                param_188 = _e663;
                let _e664 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_187), (&param_188));
                local_9 = _e664;
            }
            let _e665 = local_9;
            turnedNav = _e665;
            let _e666 = (*currentIndex_3);
            let _e669 = (*rawValue_2);
            let _e670 = newType;
            param_189 = _e670;
            let _e671 = turnedNav;
            param_190 = _e671;
            param_191 = 0u;
            let _e672 = count_2;
            param_192 = _e672;
            let _e673 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_189), (&param_190), (&param_191), (&param_192));
            let _e674 = atomicCompareExchangeWeak((&unnamed.grid[_e666]), _e669, _e673);
            return;
        }
        let _e676 = steps_1;
        let _e678 = heading_1;
        param_193 = _e678;
        param_194 = (_e676 - 1u);
        let _e679 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_193), (&param_194));
        nav_1 = _e679;
        let _e680 = target_;
        param_195 = _e680;
        let _e681 = getIndex_u0028_vi3_u003b((&param_195));
        let _e682 = target_;
        param_196 = _e682;
        let _e683 = nav_1;
        param_197 = _e683;
        let _e684 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_196), (&param_197));
        let _e685 = newType;
        param_198 = _e685;
        param_199 = _e684;
        param_200 = 0u;
        let _e686 = count_2;
        param_201 = _e686;
        let _e687 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_198), (&param_199), (&param_200), (&param_201));
        let _e688 = (*currentIndex_3);
        param_202 = _e688;
        let _e689 = (*rawValue_2);
        param_203 = _e689;
        param_204 = _e681;
        param_205 = _e687;
        let _e690 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_202), (&param_203), (&param_204), (&param_205));
        if _e690 {
            return;
        }
    } else {
        let _e691 = (*randVal_3);
        let _e695 = tuning.locustClimbChance;
        if (fract((_e691 * 41f)) < _e695) {
            let _e697 = target_;
            overTop = (_e697 + vec3<i32>(0i, 1i, 0i));
            let _e699 = overTop;
            param_206 = _e699;
            let _e700 = locustInBounds_u0028_vi3_u003b((&param_206));
            phi_7483_ = _e700;
            if _e700 {
                let _e701 = overTop;
                param_207 = _e701;
                let _e702 = getIndex_u0028_vi3_u003b((&param_207));
                param_208 = _e702;
                let _e703 = readCell_u0028_u1_u003b((&param_208));
                phi_7483_ = (_e703 == 0u);
            }
            let _e706 = phi_7483_;
            if _e706 {
                let _e707 = steps_1;
                let _e709 = heading_1;
                param_209 = _e709;
                param_210 = (_e707 - 1u);
                let _e710 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_209), (&param_210));
                nav_2 = _e710;
                let _e711 = overTop;
                param_211 = _e711;
                let _e712 = getIndex_u0028_vi3_u003b((&param_211));
                let _e713 = overTop;
                param_212 = _e713;
                let _e714 = nav_2;
                param_213 = _e714;
                let _e715 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_212), (&param_213));
                let _e716 = newType;
                param_214 = _e716;
                param_215 = _e715;
                param_216 = 0u;
                let _e717 = count_2;
                param_217 = _e717;
                let _e718 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_214), (&param_215), (&param_216), (&param_217));
                let _e719 = (*currentIndex_3);
                param_218 = _e719;
                let _e720 = (*rawValue_2);
                param_219 = _e720;
                param_220 = _e712;
                param_221 = _e718;
                let _e721 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_218), (&param_219), (&param_220), (&param_221));
                if _e721 {
                    return;
                }
            }
            let _e722 = (*pos_5);
            up = (_e722 + vec3<i32>(0i, 1i, 0i));
            let _e724 = up;
            param_222 = _e724;
            let _e725 = locustInBounds_u0028_vi3_u003b((&param_222));
            phi_7532_ = _e725;
            if _e725 {
                let _e726 = up;
                param_223 = _e726;
                let _e727 = getIndex_u0028_vi3_u003b((&param_223));
                param_224 = _e727;
                let _e728 = readCell_u0028_u1_u003b((&param_224));
                phi_7532_ = (_e728 == 0u);
            }
            let _e731 = phi_7532_;
            if _e731 {
                let _e732 = heading_1;
                param_225 = _e732;
                let _e733 = steps_1;
                param_226 = _e733;
                let _e734 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_225), (&param_226));
                nav_3 = _e734;
                let _e735 = up;
                param_227 = _e735;
                let _e736 = getIndex_u0028_vi3_u003b((&param_227));
                let _e737 = up;
                param_228 = _e737;
                let _e738 = nav_3;
                param_229 = _e738;
                let _e739 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_228), (&param_229));
                let _e740 = newType;
                param_230 = _e740;
                param_231 = _e739;
                param_232 = 0u;
                let _e741 = count_2;
                param_233 = _e741;
                let _e742 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_230), (&param_231), (&param_232), (&param_233));
                let _e743 = (*currentIndex_3);
                param_234 = _e743;
                let _e744 = (*rawValue_2);
                param_235 = _e744;
                param_236 = _e736;
                param_237 = _e742;
                let _e745 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_234), (&param_235), (&param_236), (&param_237));
                if _e745 {
                    return;
                }
            }
        }
        let _e746 = (*randVal_3);
        heading_1 = (u32((fract((_e746 * 53f)) * 8f)) & 7u);
        let _e752 = locustRunSteps_u0028_();
        steps_1 = _e752;
    }
    let _e753 = (*currentIndex_3);
    let _e756 = (*rawValue_2);
    let _e757 = heading_1;
    param_238 = _e757;
    let _e758 = steps_1;
    param_239 = _e758;
    let _e759 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_238), (&param_239));
    let _e760 = newType;
    param_240 = _e760;
    param_241 = _e759;
    param_242 = 0u;
    let _e761 = count_2;
    param_243 = _e761;
    let _e762 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_240), (&param_241), (&param_242), (&param_243));
    let _e763 = atomicCompareExchangeWeak((&unnamed.grid[_e753]), _e756, _e762);
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
    var phi_6215_: bool;

    let _e221 = (*pos_6)[1u];
    if (_e221 > 1i) {
        let _e223 = (*pos_6);
        belowPos_2 = (_e223 + vec3<i32>(0i, -1i, 0i));
        let _e225 = belowPos_2;
        param_244 = _e225;
        let _e226 = getIndex_u0028_vi3_u003b((&param_244));
        param_245 = _e226;
        let _e227 = readCell_u0028_u1_u003b((&param_245));
        param_246 = _e227;
        let _e228 = getType_u0028_u1_u003b((&param_246));
        if (_e228 == 0u) {
            let _e230 = belowPos_2;
            param_247 = _e230;
            let _e231 = getIndex_u0028_vi3_u003b((&param_247));
            param_248 = 12u;
            param_249 = 0u;
            param_250 = 0u;
            let _e232 = (*currentAge_3);
            param_251 = _e232;
            let _e233 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_248), (&param_249), (&param_250), (&param_251));
            let _e234 = (*currentIndex_4);
            param_252 = _e234;
            let _e235 = (*rawValue_3);
            param_253 = _e235;
            param_254 = _e231;
            param_255 = _e233;
            let _e236 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_252), (&param_253), (&param_254), (&param_255));
            if _e236 {
                return;
            }
        }
    }
    let _e237 = (*currentAge_3);
    let _e238 = (_e237 > 0u);
    phi_6215_ = _e238;
    if _e238 {
        let _e239 = (*randVal_4);
        let _e243 = tuning.darkStoneDryChance;
        phi_6215_ = (fract((_e239 * 23f)) < _e243);
    }
    let _e246 = phi_6215_;
    if _e246 {
        let _e247 = (*currentIndex_4);
        let _e250 = (*rawValue_3);
        let _e251 = (*currentAge_3);
        param_256 = 12u;
        param_257 = 0u;
        param_258 = 0u;
        param_259 = (_e251 - 1u);
        let _e253 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_256), (&param_257), (&param_258), (&param_259));
        let _e254 = atomicCompareExchangeWeak((&unnamed.grid[_e247]), _e250, _e253);
    }
    return;
}

fn isLava_u0028_u1_u003b(type_35: ptr<function, u32>) -> bool {
    let _e199 = (*type_35);
    let _e201 = (*type_35);
    return ((_e199 >= 8u) && (_e201 <= 11u));
}

fn lavaTypeFor_u0028_u1_u003b(coolness: ptr<function, u32>) -> u32 {
    let _e199 = (*coolness);
    let _e201 = tuning.lavaStageSize;
    return (8u + min((_e199 / max(_e201, 1u)), 3u));
}

fn lavaSolidifyCoolness_u0028_() -> u32 {
    let _e199 = tuning.lavaStageSize;
    return min((max(_e199, 1u) * 4u), 255u);
}

fn decWater_u0028_() {
    let _e199 = atomicAdd((&unnamed_1.waterVoxelCount), 4294967295u);
    return;
}

fn getOrthoDir_u0028_i1_u003b(d_5: ptr<function, i32>) -> vec3<i32> {
    let _e199 = (*d_5);
    if (_e199 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e201 = (*d_5);
    if (_e201 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e203 = (*d_5);
    if (_e203 == 2i) {
        return vec3<i32>(0i, 1i, 0i);
    }
    let _e205 = (*d_5);
    if (_e205 == 3i) {
        return vec3<i32>(0i, -1i, 0i);
    }
    let _e207 = (*d_5);
    if (_e207 == 4i) {
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
    var phi_5269_: bool;
    var phi_5276_: bool;
    var phi_5287_: bool;
    var phi_5294_: bool;
    var phi_5305_: bool;
    var phi_5444_: bool;
    var phi_5455_: bool;

    let _e266 = (*randVal_5);
    startDir = i32((fract((_e266 * 17f)) * 6f));
    i_7 = 0i;
    loop {
        let _e271 = i_7;
        if (_e271 < 6i) {
            let _e273 = startDir;
            let _e274 = i_7;
            let _e275 = (_e273 + _e274);
            d_6 = (_e275 - (i32(floor((f32(_e275) / f32(6i)))) * 6i));
            let _e283 = (*pos_7);
            let _e284 = d_6;
            param_260 = _e284;
            let _e285 = getOrthoDir_u0028_i1_u003b((&param_260));
            nPos = (_e283 + _e285);
            let _e288 = nPos[0u];
            let _e289 = (_e288 <= 0i);
            phi_5269_ = _e289;
            if !(_e289) {
                let _e292 = nPos[0u];
                let _e294 = tuning.gridWidth;
                phi_5269_ = (_e292 >= (bitcast<i32>(_e294) - 1i));
            }
            let _e299 = phi_5269_;
            phi_5276_ = _e299;
            if !(_e299) {
                let _e302 = nPos[1u];
                phi_5276_ = (_e302 <= 0i);
            }
            let _e305 = phi_5276_;
            phi_5287_ = _e305;
            if !(_e305) {
                let _e308 = nPos[1u];
                let _e310 = tuning.gridHeight;
                phi_5287_ = (_e308 >= (bitcast<i32>(_e310) - 1i));
            }
            let _e315 = phi_5287_;
            phi_5294_ = _e315;
            if !(_e315) {
                let _e318 = nPos[2u];
                phi_5294_ = (_e318 <= 0i);
            }
            let _e321 = phi_5294_;
            phi_5305_ = _e321;
            if !(_e321) {
                let _e324 = nPos[2u];
                let _e326 = tuning.gridDepth;
                phi_5305_ = (_e324 >= (bitcast<i32>(_e326) - 1i));
            }
            let _e331 = phi_5305_;
            if _e331 {
                continue;
            }
            let _e332 = nPos;
            param_261 = _e332;
            let _e333 = getIndex_u0028_vi3_u003b((&param_261));
            nIndex = _e333;
            let _e334 = nIndex;
            param_262 = _e334;
            let _e335 = readCell_u0028_u1_u003b((&param_262));
            nVal = _e335;
            let _e336 = nVal;
            param_263 = _e336;
            let _e337 = getType_u0028_u1_u003b((&param_263));
            nType = _e337;
            let _e338 = nType;
            if (_e338 == 2u) {
                let _e340 = nIndex;
                let _e343 = nVal;
                param_264 = 6u;
                param_265 = 0u;
                param_266 = 0u;
                param_267 = 0u;
                let _e344 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_264), (&param_265), (&param_266), (&param_267));
                let _e345 = atomicCompareExchangeWeak((&unnamed.grid[_e340]), _e343, _e344);
                let _e347 = nVal;
                if (_e345.old_value == _e347) {
                    decWater_u0028_();
                    let _e349 = (*coolness_1);
                    let _e351 = tuning.lavaWaterCool;
                    (*coolness_1) = min((_e349 + _e351), 255u);
                    return;
                }
            } else {
                let _e354 = nType;
                if (_e354 == 19u) {
                    let _e356 = nIndex;
                    let _e359 = nVal;
                    let _e360 = atomicCompareExchangeWeak((&unnamed.grid[_e356]), _e359, 0u);
                    let _e362 = nVal;
                    if (_e360.old_value == _e362) {
                        return;
                    }
                } else {
                    let _e364 = nType;
                    if (_e364 == 18u) {
                        let _e366 = nIndex;
                        let _e369 = nVal;
                        param_268 = 5u;
                        param_269 = 0u;
                        param_270 = 0u;
                        param_271 = 0u;
                        let _e370 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_268), (&param_269), (&param_270), (&param_271));
                        let _e371 = atomicCompareExchangeWeak((&unnamed.grid[_e366]), _e369, _e370);
                        let _e373 = nVal;
                        if (_e371.old_value == _e373) {
                            return;
                        }
                    } else {
                        let _e375 = nType;
                        if (_e375 == 3u) {
                            let _e377 = nIndex;
                            let _e380 = nVal;
                            param_272 = 12u;
                            param_273 = 0u;
                            param_274 = 0u;
                            param_275 = 255u;
                            let _e381 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_272), (&param_273), (&param_274), (&param_275));
                            let _e382 = atomicCompareExchangeWeak((&unnamed.grid[_e377]), _e380, _e381);
                            let _e384 = nVal;
                            if (_e382.old_value == _e384) {
                                return;
                            }
                        } else {
                            let _e386 = nType;
                            let _e388 = nType;
                            if ((_e386 == 1u) || (_e388 == 4u)) {
                                let _e391 = nVal;
                                param_276 = _e391;
                                let _e392 = getAge_u0028_u1_u003b((&param_276));
                                moisture_1 = _e392;
                                let _e393 = nVal;
                                param_277 = _e393;
                                let _e394 = getDir_u0028_u1_u003b((&param_277));
                                flora_2 = _e394;
                                let _e395 = nType;
                                let _e397 = flora_2;
                                let _e400 = flora_2;
                                if (((_e395 == 4u) && (_e397 > 10u)) && (_e400 <= 100u)) {
                                    let _e403 = nPos;
                                    abovePos = (_e403 + vec3<i32>(0i, 1i, 0i));
                                    let _e406 = abovePos[1u];
                                    let _e408 = tuning.gridHeight;
                                    let _e411 = (_e406 < (bitcast<i32>(_e408) - 1i));
                                    phi_5444_ = _e411;
                                    if _e411 {
                                        let _e412 = abovePos;
                                        param_278 = _e412;
                                        let _e413 = getIndex_u0028_vi3_u003b((&param_278));
                                        param_279 = _e413;
                                        let _e414 = readCell_u0028_u1_u003b((&param_279));
                                        param_280 = _e414;
                                        let _e415 = getType_u0028_u1_u003b((&param_280));
                                        phi_5444_ = (_e415 == 0u);
                                    }
                                    let _e418 = phi_5444_;
                                    phi_5455_ = _e418;
                                    if _e418 {
                                        let _e419 = (*randVal_5);
                                        let _e423 = tuning.lavaIgniteChance;
                                        phi_5455_ = (fract((_e419 * 41f)) < _e423);
                                    }
                                    let _e426 = phi_5455_;
                                    if _e426 {
                                        let _e427 = abovePos;
                                        param_281 = _e427;
                                        let _e428 = getIndex_u0028_vi3_u003b((&param_281));
                                        param_282 = 5u;
                                        param_283 = 0u;
                                        param_284 = 0u;
                                        param_285 = 0u;
                                        let _e431 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_282), (&param_283), (&param_284), (&param_285));
                                        let _e432 = atomicCompareExchangeWeak((&unnamed.grid[_e428]), 0u, _e431);
                                        if (_e432.old_value == 0u) {
                                            return;
                                        }
                                    }
                                } else {
                                    let _e435 = moisture_1;
                                    if (_e435 > 0u) {
                                        let _e437 = nIndex;
                                        let _e440 = nVal;
                                        let _e441 = moisture_1;
                                        let _e443 = nType;
                                        param_286 = _e443;
                                        let _e444 = flora_2;
                                        param_287 = _e444;
                                        param_288 = 0u;
                                        param_289 = (_e441 - 1u);
                                        let _e445 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_286), (&param_287), (&param_288), (&param_289));
                                        let _e446 = atomicCompareExchangeWeak((&unnamed.grid[_e437]), _e440, _e445);
                                        let _e448 = nVal;
                                        if (_e446.old_value == _e448) {
                                            let _e450 = (*coolness_1);
                                            let _e452 = tuning.lavaMoistureCool;
                                            (*coolness_1) = min((_e450 + _e452), 255u);
                                            return;
                                        }
                                    } else {
                                        let _e455 = (*randVal_5);
                                        let _e459 = tuning.lavaConsumeChance;
                                        if (fract((_e455 * 53f)) < _e459) {
                                            let _e461 = nIndex;
                                            let _e464 = nVal;
                                            let _e465 = atomicCompareExchangeWeak((&unnamed.grid[_e461]), _e464, 0u);
                                            let _e467 = nVal;
                                            if (_e465.old_value == _e467) {
                                                return;
                                            }
                                        }
                                    }
                                }
                            } else {
                                let _e469 = nType;
                                param_290 = _e469;
                                let _e470 = isLava_u0028_u1_u003b((&param_290));
                                if _e470 {
                                    let _e471 = nVal;
                                    param_291 = _e471;
                                    let _e472 = getAge_u0028_u1_u003b((&param_291));
                                    nCool = _e472;
                                    let _e473 = (*coolness_1);
                                    let _e474 = nCool;
                                    if (_e473 > (_e474 + 1u)) {
                                        let _e477 = nCool;
                                        raised = (_e477 + 1u);
                                        let _e479 = raised;
                                        let _e480 = lavaSolidifyCoolness_u0028_();
                                        if (_e479 >= _e480) {
                                            local_10 = 12u;
                                        } else {
                                            let _e482 = raised;
                                            param_292 = _e482;
                                            let _e483 = lavaTypeFor_u0028_u1_u003b((&param_292));
                                            local_10 = _e483;
                                        }
                                        let _e484 = local_10;
                                        raisedType = _e484;
                                        let _e485 = nIndex;
                                        let _e488 = nVal;
                                        let _e489 = nVal;
                                        param_293 = _e489;
                                        let _e490 = getDir_u0028_u1_u003b((&param_293));
                                        let _e491 = raisedType;
                                        param_294 = _e491;
                                        param_295 = _e490;
                                        param_296 = 0u;
                                        let _e492 = raised;
                                        param_297 = _e492;
                                        let _e493 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_294), (&param_295), (&param_296), (&param_297));
                                        let _e494 = atomicCompareExchangeWeak((&unnamed.grid[_e485]), _e488, _e493);
                                        let _e496 = nVal;
                                        if (_e494.old_value == _e496) {
                                            let _e498 = (*coolness_1);
                                            (*coolness_1) = (_e498 - 1u);
                                            return;
                                        }
                                    }
                                } else {
                                    let _e500 = nType;
                                    if (_e500 == 12u) {
                                        let _e502 = nVal;
                                        param_298 = _e502;
                                        let _e503 = getAge_u0028_u1_u003b((&param_298));
                                        nCool_1 = _e503;
                                        let _e504 = nCool_1;
                                        let _e505 = (*coolness_1);
                                        draws = (_e504 > (_e505 + 1u));
                                        let _e508 = draws;
                                        if _e508 {
                                            let _e509 = nCool_1;
                                            local_11 = (_e509 - 1u);
                                        } else {
                                            let _e511 = nCool_1;
                                            local_11 = _e511;
                                        }
                                        let _e512 = local_11;
                                        lowered = _e512;
                                        let _e513 = lowered;
                                        let _e514 = lavaSolidifyCoolness_u0028_();
                                        melts = (_e513 < _e514);
                                        let _e516 = draws;
                                        let _e517 = melts;
                                        if (_e516 || _e517) {
                                            let _e519 = melts;
                                            if _e519 {
                                                let _e520 = lowered;
                                                param_299 = _e520;
                                                let _e521 = lavaTypeFor_u0028_u1_u003b((&param_299));
                                                local_12 = _e521;
                                            } else {
                                                local_12 = 12u;
                                            }
                                            let _e522 = local_12;
                                            newType_1 = _e522;
                                            let _e523 = nIndex;
                                            let _e526 = nVal;
                                            let _e527 = newType_1;
                                            param_300 = _e527;
                                            param_301 = 0u;
                                            param_302 = 0u;
                                            let _e528 = lowered;
                                            param_303 = _e528;
                                            let _e529 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_300), (&param_301), (&param_302), (&param_303));
                                            let _e530 = atomicCompareExchangeWeak((&unnamed.grid[_e523]), _e526, _e529);
                                            let _e532 = nVal;
                                            if (_e530.old_value == _e532) {
                                                let _e534 = draws;
                                                if _e534 {
                                                    let _e535 = (*coolness_1);
                                                    (*coolness_1) = min((_e535 + 1u), 255u);
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
            let _e538 = i_7;
            i_7 = (_e538 + 1i);
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
    var phi_5663_: bool;
    var phi_5801_: bool;
    var phi_5807_: bool;
    var phi_5817_: bool;
    var phi_5929_: bool;
    var phi_5936_: bool;
    var phi_5947_: bool;
    var phi_5959_: bool;
    var phi_5981_: bool;
    var phi_6095_: bool;
    var phi_6101_: bool;
    var phi_6111_: bool;

    let _e300 = (*currentAge_4);
    coolness_2 = _e300;
    let _e301 = (*pos_8);
    param_304 = _e301;
    let _e302 = coolness_2;
    param_305 = _e302;
    let _e303 = (*randVal_6);
    param_306 = _e303;
    lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b((&param_304), (&param_305), (&param_306));
    let _e304 = param_305;
    coolness_2 = _e304;
    let _e305 = (*currentSleep_1);
    let _e307 = tuning.wakeSleepThreshold;
    let _e308 = (_e305 > _e307);
    phi_5663_ = _e308;
    if _e308 {
        let _e309 = (*randVal_6);
        let _e313 = tuning.lavaRestCoolChance;
        phi_5663_ = (fract((_e309 * 71f)) < _e313);
    }
    let _e316 = phi_5663_;
    if _e316 {
        let _e317 = coolness_2;
        coolness_2 = min((_e317 + 1u), 255u);
    }
    let _e320 = coolness_2;
    let _e321 = lavaSolidifyCoolness_u0028_();
    if (_e320 >= _e321) {
        let _e323 = (*currentIndex_5);
        let _e326 = (*rawValue_4);
        param_307 = 12u;
        param_308 = 0u;
        param_309 = 0u;
        let _e327 = coolness_2;
        param_310 = _e327;
        let _e328 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_307), (&param_308), (&param_309), (&param_310));
        let _e329 = atomicCompareExchangeWeak((&unnamed.grid[_e323]), _e326, _e328);
        return;
    }
    let _e331 = coolness_2;
    param_311 = _e331;
    let _e332 = lavaTypeFor_u0028_u1_u003b((&param_311));
    newType_2 = _e332;
    let _e333 = (*randVal_6);
    let _e337 = tuning.lavaViscosity;
    if (fract((_e333 * 89f)) < _e337) {
        let _e340 = (*pos_8)[1u];
        if (_e340 > 1i) {
            let _e342 = (*pos_8);
            belowPos_3 = (_e342 + vec3<i32>(0i, -1i, 0i));
            let _e344 = belowPos_3;
            param_312 = _e344;
            let _e345 = getIndex_u0028_vi3_u003b((&param_312));
            param_313 = _e345;
            let _e346 = readCell_u0028_u1_u003b((&param_313));
            param_314 = _e346;
            let _e347 = getType_u0028_u1_u003b((&param_314));
            if (_e347 == 0u) {
                let _e349 = belowPos_3;
                param_315 = _e349;
                let _e350 = getIndex_u0028_vi3_u003b((&param_315));
                let _e351 = newType_2;
                param_316 = _e351;
                let _e352 = (*currentDir_2);
                param_317 = _e352;
                param_318 = 0u;
                let _e353 = coolness_2;
                param_319 = _e353;
                let _e354 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_316), (&param_317), (&param_318), (&param_319));
                let _e355 = (*currentIndex_5);
                param_320 = _e355;
                let _e356 = (*rawValue_4);
                param_321 = _e356;
                param_322 = _e350;
                param_323 = _e354;
                let _e357 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_320), (&param_321), (&param_322), (&param_323));
                if _e357 {
                    return;
                }
            }
        }
        let _e359 = (*pos_8)[1u];
        if (_e359 > 1i) {
            let _e361 = (*randVal_6);
            slideDir = select(-1i, 1i, (fract((_e361 * 10f)) > 0.5f));
            let _e366 = (*randVal_6);
            if (fract((_e366 * 100f)) > 0.5f) {
                let _e370 = (*pos_8);
                let _e371 = slideDir;
                slide[0i] = (_e370 + vec3<i32>(_e371, -1i, 0i));
                let _e375 = (*pos_8);
                let _e376 = slideDir;
                slide[1i] = (_e375 + vec3<i32>(0i, -1i, _e376));
            } else {
                let _e380 = (*pos_8);
                let _e381 = slideDir;
                slide[0i] = (_e380 + vec3<i32>(0i, -1i, _e381));
                let _e385 = (*pos_8);
                let _e386 = slideDir;
                slide[1i] = (_e385 + vec3<i32>(_e386, -1i, 0i));
            }
            s = 0i;
            loop {
                let _e390 = s;
                if (_e390 < 2i) {
                    let _e392 = s;
                    let _e394 = slide[_e392];
                    sPos = _e394;
                    let _e396 = sPos[0u];
                    let _e397 = (_e396 > 0i);
                    phi_5801_ = _e397;
                    if _e397 {
                        let _e399 = sPos[0u];
                        let _e401 = tuning.gridWidth;
                        phi_5801_ = (_e399 < (bitcast<i32>(_e401) - 1i));
                    }
                    let _e406 = phi_5801_;
                    phi_5807_ = _e406;
                    if _e406 {
                        let _e408 = sPos[2u];
                        phi_5807_ = (_e408 > 0i);
                    }
                    let _e411 = phi_5807_;
                    phi_5817_ = _e411;
                    if _e411 {
                        let _e413 = sPos[2u];
                        let _e415 = tuning.gridDepth;
                        phi_5817_ = (_e413 < (bitcast<i32>(_e415) - 1i));
                    }
                    let _e420 = phi_5817_;
                    if _e420 {
                        let _e421 = sPos;
                        param_324 = _e421;
                        let _e422 = getIndex_u0028_vi3_u003b((&param_324));
                        param_325 = _e422;
                        let _e423 = readCell_u0028_u1_u003b((&param_325));
                        param_326 = _e423;
                        let _e424 = getType_u0028_u1_u003b((&param_326));
                        if (_e424 == 0u) {
                            let _e426 = sPos;
                            param_327 = _e426;
                            let _e427 = getIndex_u0028_vi3_u003b((&param_327));
                            let _e428 = newType_2;
                            param_328 = _e428;
                            let _e429 = (*currentDir_2);
                            param_329 = _e429;
                            param_330 = 0u;
                            let _e430 = coolness_2;
                            param_331 = _e430;
                            let _e431 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_328), (&param_329), (&param_330), (&param_331));
                            let _e432 = (*currentIndex_5);
                            param_332 = _e432;
                            let _e433 = (*rawValue_4);
                            param_333 = _e433;
                            param_334 = _e427;
                            param_335 = _e431;
                            let _e434 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_332), (&param_333), (&param_334), (&param_335));
                            if _e434 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e435 = s;
                    s = (_e435 + 1i);
                }
            }
        }
        let _e437 = (*currentSleep_1);
        let _e439 = tuning.wakeSleepThreshold;
        if (_e437 <= _e439) {
            blockedMask = 0u;
            let _e441 = (*randVal_6);
            searchStart = i32((fract((_e441 * 8f)) * 8f));
            let _e447 = tuning.lavaSpreadRadius;
            reach = bitcast<i32>(max(_e447, 1u));
            r = 1i;
            loop {
                let _e450 = r;
                let _e451 = reach;
                if (_e450 <= _e451) {
                    let _e453 = blockedMask;
                    if (_e453 == 255u) {
                        break;
                    }
                    i_8 = 0i;
                    loop {
                        let _e455 = i_8;
                        if (_e455 < 8i) {
                            let _e457 = searchStart;
                            let _e458 = i_8;
                            let _e459 = (_e457 + _e458);
                            d_7 = (_e459 - (i32(floor((f32(_e459) / f32(8i)))) * 8i));
                            let _e467 = blockedMask;
                            let _e468 = d_7;
                            if ((_e467 & (1u << bitcast<u32>(_e468))) != 0u) {
                                continue;
                            }
                            let _e473 = (*pos_8);
                            let _e474 = d_7;
                            param_336 = _e474;
                            let _e475 = getHDir_u0028_i1_u003b((&param_336));
                            let _e476 = r;
                            c_6 = (_e473 + (_e475 * vec3(_e476)));
                            let _e481 = c_6[0u];
                            let _e482 = (_e481 <= 0i);
                            phi_5929_ = _e482;
                            if !(_e482) {
                                let _e485 = c_6[0u];
                                let _e487 = tuning.gridWidth;
                                phi_5929_ = (_e485 >= (bitcast<i32>(_e487) - 1i));
                            }
                            let _e492 = phi_5929_;
                            phi_5936_ = _e492;
                            if !(_e492) {
                                let _e495 = c_6[2u];
                                phi_5936_ = (_e495 <= 0i);
                            }
                            let _e498 = phi_5936_;
                            phi_5947_ = _e498;
                            if !(_e498) {
                                let _e501 = c_6[2u];
                                let _e503 = tuning.gridDepth;
                                phi_5947_ = (_e501 >= (bitcast<i32>(_e503) - 1i));
                            }
                            let _e508 = phi_5947_;
                            phi_5959_ = _e508;
                            if !(_e508) {
                                let _e510 = c_6;
                                param_337 = _e510;
                                let _e511 = getIndex_u0028_vi3_u003b((&param_337));
                                param_338 = _e511;
                                let _e512 = readCell_u0028_u1_u003b((&param_338));
                                param_339 = _e512;
                                let _e513 = getType_u0028_u1_u003b((&param_339));
                                phi_5959_ = (_e513 != 0u);
                            }
                            let _e516 = phi_5959_;
                            if _e516 {
                                let _e517 = d_7;
                                let _e520 = blockedMask;
                                blockedMask = (_e520 | (1u << bitcast<u32>(_e517)));
                            } else {
                                let _e523 = c_6[1u];
                                let _e524 = (_e523 > 1i);
                                phi_5981_ = _e524;
                                if _e524 {
                                    let _e525 = c_6;
                                    param_340 = (_e525 + vec3<i32>(0i, -1i, 0i));
                                    let _e527 = getIndex_u0028_vi3_u003b((&param_340));
                                    param_341 = _e527;
                                    let _e528 = readCell_u0028_u1_u003b((&param_341));
                                    param_342 = _e528;
                                    let _e529 = getType_u0028_u1_u003b((&param_342));
                                    phi_5981_ = (_e529 == 0u);
                                }
                                let _e532 = phi_5981_;
                                if _e532 {
                                    let _e533 = c_6;
                                    param_343 = _e533;
                                    let _e534 = getIndex_u0028_vi3_u003b((&param_343));
                                    let _e535 = newType_2;
                                    param_344 = _e535;
                                    param_345 = 0u;
                                    param_346 = 0u;
                                    let _e536 = coolness_2;
                                    param_347 = _e536;
                                    let _e537 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_344), (&param_345), (&param_346), (&param_347));
                                    let _e538 = (*currentIndex_5);
                                    param_348 = _e538;
                                    let _e539 = (*rawValue_4);
                                    param_349 = _e539;
                                    param_350 = _e534;
                                    param_351 = _e537;
                                    let _e540 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_348), (&param_349), (&param_350), (&param_351));
                                    if _e540 {
                                        return;
                                    }
                                    let _e541 = d_7;
                                    let _e544 = blockedMask;
                                    blockedMask = (_e544 | (1u << bitcast<u32>(_e541)));
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e546 = i_8;
                            i_8 = (_e546 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e548 = r;
                    r = (_e548 + 1i);
                }
            }
            let _e551 = (*pos_8)[1u];
            let _e553 = tuning.gridHeight;
            if (_e551 < (bitcast<i32>(_e553) - 2i)) {
                let _e557 = (*pos_8);
                param_352 = (_e557 + vec3<i32>(0i, 1i, 0i));
                let _e559 = getIndex_u0028_vi3_u003b((&param_352));
                param_353 = _e559;
                let _e560 = readCell_u0028_u1_u003b((&param_353));
                param_354 = _e560;
                let _e561 = getType_u0028_u1_u003b((&param_354));
                local_13 = (_e561 != 0u);
            } else {
                local_13 = false;
            }
            let _e563 = local_13;
            hasPressure = _e563;
            let _e565 = (*pos_8)[1u];
            if (_e565 > 1i) {
                let _e567 = (*pos_8);
                param_355 = (_e567 + vec3<i32>(0i, -1i, 0i));
                let _e569 = getIndex_u0028_vi3_u003b((&param_355));
                param_356 = _e569;
                let _e570 = readCell_u0028_u1_u003b((&param_356));
                param_357 = _e570;
                let _e571 = getType_u0028_u1_u003b((&param_357));
                param_358 = _e571;
                let _e572 = isLava_u0028_u1_u003b((&param_358));
                local_14 = _e572;
            } else {
                local_14 = false;
            }
            let _e573 = local_14;
            stackedOnLava = _e573;
            let _e574 = hasPressure;
            let _e575 = stackedOnLava;
            if (_e574 || _e575) {
                let _e577 = (*randVal_6);
                spreadStart = i32((fract((_e577 * 8f)) * 8f));
                i_9 = 0i;
                loop {
                    let _e582 = i_9;
                    if (_e582 < 8i) {
                        let _e584 = spreadStart;
                        let _e585 = i_9;
                        let _e586 = (_e584 + _e585);
                        d_8 = (_e586 - (i32(floor((f32(_e586) / f32(8i)))) * 8i));
                        let _e594 = (*pos_8);
                        let _e595 = d_8;
                        param_359 = _e595;
                        let _e596 = getHDir_u0028_i1_u003b((&param_359));
                        targetPos = (_e594 + _e596);
                        let _e599 = targetPos[0u];
                        let _e600 = (_e599 > 0i);
                        phi_6095_ = _e600;
                        if _e600 {
                            let _e602 = targetPos[0u];
                            let _e604 = tuning.gridWidth;
                            phi_6095_ = (_e602 < (bitcast<i32>(_e604) - 1i));
                        }
                        let _e609 = phi_6095_;
                        phi_6101_ = _e609;
                        if _e609 {
                            let _e611 = targetPos[2u];
                            phi_6101_ = (_e611 > 0i);
                        }
                        let _e614 = phi_6101_;
                        phi_6111_ = _e614;
                        if _e614 {
                            let _e616 = targetPos[2u];
                            let _e618 = tuning.gridDepth;
                            phi_6111_ = (_e616 < (bitcast<i32>(_e618) - 1i));
                        }
                        let _e623 = phi_6111_;
                        if _e623 {
                            let _e624 = targetPos;
                            param_360 = _e624;
                            let _e625 = getIndex_u0028_vi3_u003b((&param_360));
                            param_361 = _e625;
                            let _e626 = readCell_u0028_u1_u003b((&param_361));
                            param_362 = _e626;
                            let _e627 = getType_u0028_u1_u003b((&param_362));
                            if (_e627 == 0u) {
                                let _e629 = targetPos;
                                param_363 = _e629;
                                let _e630 = getIndex_u0028_vi3_u003b((&param_363));
                                let _e631 = d_8;
                                let _e634 = newType_2;
                                param_364 = _e634;
                                param_365 = bitcast<u32>((_e631 + 1i));
                                param_366 = 0u;
                                let _e635 = coolness_2;
                                param_367 = _e635;
                                let _e636 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_364), (&param_365), (&param_366), (&param_367));
                                let _e637 = (*currentIndex_5);
                                param_368 = _e637;
                                let _e638 = (*rawValue_4);
                                param_369 = _e638;
                                param_370 = _e630;
                                param_371 = _e636;
                                let _e639 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_368), (&param_369), (&param_370), (&param_371));
                                if _e639 {
                                    return;
                                }
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e640 = i_9;
                        i_9 = (_e640 + 1i);
                    }
                }
            }
        }
    }
    let _e642 = (*currentSleep_1);
    newSleep = min((_e642 + 1u), 255u);
    let _e645 = (*currentIndex_5);
    let _e648 = (*rawValue_4);
    let _e649 = newType_2;
    param_372 = _e649;
    let _e650 = (*currentDir_2);
    param_373 = _e650;
    let _e651 = newSleep;
    param_374 = _e651;
    let _e652 = coolness_2;
    param_375 = _e652;
    let _e653 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_372), (&param_373), (&param_374), (&param_375));
    let _e654 = atomicCompareExchangeWeak((&unnamed.grid[_e645]), _e648, _e653);
    return;
}

fn getCloudSleep_u0028_u1_u003b(v_2: ptr<function, u32>) -> u32 {
    let _e199 = (*v_2);
    return ((_e199 >> bitcast<u32>(10i)) & 255u);
}

fn getCloudKind_u0028_u1_u003b(v_3: ptr<function, u32>) -> u32 {
    let _e199 = (*v_3);
    return (_e199 & 3u);
}

fn cloudIsAtRest_u0028_u1_u003b(v_4: ptr<function, u32>) -> bool {
    var param_376: u32;
    var param_377: u32;
    var phi_622_: bool;

    let _e201 = (*v_4);
    param_376 = _e201;
    let _e202 = getCloudKind_u0028_u1_u003b((&param_376));
    let _e203 = (_e202 != 0u);
    phi_622_ = _e203;
    if _e203 {
        let _e204 = (*v_4);
        param_377 = _e204;
        let _e205 = getCloudSleep_u0028_u1_u003b((&param_377));
        let _e207 = tuning.wakeSleepThreshold;
        phi_622_ = (_e205 >= _e207);
    }
    let _e210 = phi_622_;
    return _e210;
}

fn packCloud_u0028_u1_u003b_u1_u003b_u1_u003b(kind: ptr<function, u32>, wait: ptr<function, u32>, sleep_1: ptr<function, u32>) -> u32 {
    let _e201 = (*kind);
    let _e203 = (*wait);
    let _e208 = (*sleep_1);
    return (((_e201 & 3u) | ((_e203 & 255u) << bitcast<u32>(2i))) | ((_e208 & 255u) << bitcast<u32>(10i)));
}

fn updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_9: ptr<function, vec3<i32>>, currentIndex_6: ptr<function, u32>, rawValue_5: ptr<function, u32>, currentSleep_2: ptr<function, u32>, currentAge_5: ptr<function, u32>, randVal_7: ptr<function, f32>) {
    var param_378: u32;
    var param_379: u32;
    var param_380: u32;
    var newAge: u32;
    var d_9: i32;
    var scatterPos: vec3<i32>;
    var param_381: i32;
    var sType: u32;
    var param_382: vec3<i32>;
    var param_383: u32;
    var param_384: u32;
    var param_385: vec3<i32>;
    var param_386: u32;
    var param_387: u32;
    var param_388: u32;
    var param_389: u32;
    var param_390: u32;
    var param_391: u32;
    var param_392: u32;
    var param_393: u32;
    var checkPos: array<vec3<i32>, 3>;
    var dir_1: i32;
    var upPos_1: vec3<i32>;
    var param_394: vec3<i32>;
    var param_395: u32;
    var param_396: u32;
    var param_397: u32;
    var param_398: u32;
    var i_10: i32;
    var cPos: vec3<i32>;
    var cIndex: u32;
    var param_399: vec3<i32>;
    var cVal: u32;
    var param_400: u32;
    var cType: u32;
    var param_401: u32;
    var moisture_2: u32;
    var param_402: u32;
    var capacity: u32;
    var local_15: u32;
    var i_11: i32;
    var sPos_1: vec3<i32>;
    var sType_1: u32;
    var param_403: vec3<i32>;
    var param_404: u32;
    var param_405: u32;
    var param_406: vec3<i32>;
    var param_407: u32;
    var param_408: u32;
    var param_409: u32;
    var param_410: u32;
    var param_411: u32;
    var param_412: u32;
    var param_413: u32;
    var param_414: u32;
    var newSleep_1: u32;
    var param_415: u32;
    var param_416: u32;
    var param_417: u32;
    var param_418: u32;
    var phi_8350_: bool;
    var phi_8356_: bool;
    var phi_8366_: bool;
    var phi_8372_: bool;
    var phi_8382_: bool;
    var phi_8476_: bool;
    var phi_8519_: bool;
    var phi_8525_: bool;
    var phi_8535_: bool;
    var phi_8616_: bool;
    var phi_8626_: bool;
    var phi_8632_: bool;
    var phi_8642_: bool;

    let _e265 = (*pos_9)[1u];
    let _e267 = tuning.gridHeight;
    if (_e265 >= (bitcast<i32>(_e267) - 2i)) {
        let _e271 = (*currentIndex_6);
        param_378 = 1u;
        param_379 = 0u;
        param_380 = 0u;
        let _e274 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_378), (&param_379), (&param_380));
        let _e275 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e271]), 0u, _e274);
        if (_e275.old_value == 0u) {
            let _e278 = (*currentIndex_6);
            let _e281 = atomicExchange((&unnamed.grid[_e278]), 0u);
            let _e283 = atomicAdd((&unnamed_1.cloudChangedCount), 1u);
            return;
        }
    }
    let _e284 = (*currentAge_5);
    newAge = min((_e284 + 1u), 255u);
    let _e287 = (*randVal_7);
    let _e291 = tuning.steamScatterChance;
    if (fract((_e287 * 88f)) < _e291) {
        let _e293 = (*randVal_7);
        d_9 = i32((fract((_e293 * 13f)) * 6f));
        let _e298 = (*pos_9);
        let _e299 = d_9;
        param_381 = _e299;
        let _e300 = getOrthoDir_u0028_i1_u003b((&param_381));
        scatterPos = (_e298 + _e300);
        let _e303 = scatterPos[0u];
        let _e304 = (_e303 > 0i);
        phi_8350_ = _e304;
        if _e304 {
            let _e306 = scatterPos[0u];
            let _e308 = tuning.gridWidth;
            phi_8350_ = (_e306 < (bitcast<i32>(_e308) - 1i));
        }
        let _e313 = phi_8350_;
        phi_8356_ = _e313;
        if _e313 {
            let _e315 = scatterPos[1u];
            phi_8356_ = (_e315 > 0i);
        }
        let _e318 = phi_8356_;
        phi_8366_ = _e318;
        if _e318 {
            let _e320 = scatterPos[1u];
            let _e322 = tuning.gridHeight;
            phi_8366_ = (_e320 < (bitcast<i32>(_e322) - 1i));
        }
        let _e327 = phi_8366_;
        phi_8372_ = _e327;
        if _e327 {
            let _e329 = scatterPos[2u];
            phi_8372_ = (_e329 > 0i);
        }
        let _e332 = phi_8372_;
        phi_8382_ = _e332;
        if _e332 {
            let _e334 = scatterPos[2u];
            let _e336 = tuning.gridDepth;
            phi_8382_ = (_e334 < (bitcast<i32>(_e336) - 1i));
        }
        let _e341 = phi_8382_;
        if _e341 {
            let _e342 = scatterPos;
            param_382 = _e342;
            let _e343 = getIndex_u0028_vi3_u003b((&param_382));
            param_383 = _e343;
            let _e344 = readCell_u0028_u1_u003b((&param_383));
            param_384 = _e344;
            let _e345 = getType_u0028_u1_u003b((&param_384));
            sType = _e345;
            let _e346 = sType;
            let _e348 = sType;
            if ((_e346 == 0u) || (_e348 == 5u)) {
                let _e351 = scatterPos;
                param_385 = _e351;
                let _e352 = getIndex_u0028_vi3_u003b((&param_385));
                param_386 = 6u;
                param_387 = 0u;
                param_388 = 0u;
                let _e353 = newAge;
                param_389 = _e353;
                let _e354 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_386), (&param_387), (&param_388), (&param_389));
                let _e355 = (*currentIndex_6);
                param_390 = _e355;
                let _e356 = (*rawValue_5);
                param_391 = _e356;
                param_392 = _e352;
                param_393 = _e354;
                let _e357 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_390), (&param_391), (&param_392), (&param_393));
                if _e357 {
                    return;
                }
            }
        }
    }
    let _e358 = (*pos_9);
    checkPos[0i] = (_e358 + vec3<i32>(0i, 1i, 0i));
    let _e361 = (*randVal_7);
    dir_1 = select(-1i, 1i, (fract((_e361 * 10f)) > 0.5f));
    let _e366 = (*randVal_7);
    if (fract((_e366 * 100f)) > 0.5f) {
        let _e370 = (*pos_9);
        let _e371 = dir_1;
        checkPos[1i] = (_e370 + vec3<i32>(_e371, 1i, 0i));
        let _e375 = (*pos_9);
        let _e376 = dir_1;
        checkPos[2i] = (_e375 + vec3<i32>(0i, 1i, _e376));
    } else {
        let _e380 = (*pos_9);
        let _e381 = dir_1;
        checkPos[1i] = (_e380 + vec3<i32>(0i, 1i, _e381));
        let _e385 = (*pos_9);
        let _e386 = dir_1;
        checkPos[2i] = (_e385 + vec3<i32>(_e386, 1i, 0i));
    }
    let _e390 = (*pos_9);
    upPos_1 = (_e390 + vec3<i32>(0i, 1i, 0i));
    let _e393 = upPos_1[1u];
    let _e395 = tuning.gridHeight;
    let _e397 = (_e393 < bitcast<i32>(_e395));
    phi_8476_ = _e397;
    if _e397 {
        let _e398 = upPos_1;
        param_394 = _e398;
        let _e399 = getIndex_u0028_vi3_u003b((&param_394));
        let _e402 = atomicLoad((&unnamed_2.cloudCells[_e399]));
        param_395 = _e402;
        let _e403 = cloudIsAtRest_u0028_u1_u003b((&param_395));
        phi_8476_ = _e403;
    }
    let _e405 = phi_8476_;
    if _e405 {
        let _e406 = (*currentIndex_6);
        param_396 = 1u;
        param_397 = 0u;
        param_398 = 0u;
        let _e409 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_396), (&param_397), (&param_398));
        let _e410 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e406]), 0u, _e409);
        if (_e410.old_value == 0u) {
            let _e413 = (*currentIndex_6);
            let _e416 = atomicExchange((&unnamed.grid[_e413]), 0u);
            let _e418 = atomicAdd((&unnamed_1.cloudChangedCount), 1u);
        }
        return;
    }
    i_10 = 0i;
    loop {
        let _e419 = i_10;
        if (_e419 < 3i) {
            let _e421 = i_10;
            let _e423 = checkPos[_e421];
            cPos = _e423;
            let _e425 = cPos[0u];
            let _e426 = (_e425 > 0i);
            phi_8519_ = _e426;
            if _e426 {
                let _e428 = cPos[0u];
                let _e430 = tuning.gridWidth;
                phi_8519_ = (_e428 < (bitcast<i32>(_e430) - 1i));
            }
            let _e435 = phi_8519_;
            phi_8525_ = _e435;
            if _e435 {
                let _e437 = cPos[2u];
                phi_8525_ = (_e437 > 0i);
            }
            let _e440 = phi_8525_;
            phi_8535_ = _e440;
            if _e440 {
                let _e442 = cPos[2u];
                let _e444 = tuning.gridDepth;
                phi_8535_ = (_e442 < (bitcast<i32>(_e444) - 1i));
            }
            let _e449 = phi_8535_;
            if _e449 {
                let _e450 = cPos;
                param_399 = _e450;
                let _e451 = getIndex_u0028_vi3_u003b((&param_399));
                cIndex = _e451;
                let _e452 = cIndex;
                param_400 = _e452;
                let _e453 = readCell_u0028_u1_u003b((&param_400));
                cVal = _e453;
                let _e454 = cVal;
                param_401 = _e454;
                let _e455 = getType_u0028_u1_u003b((&param_401));
                cType = _e455;
                let _e456 = cType;
                let _e458 = cType;
                if ((_e456 == 1u) || (_e458 == 4u)) {
                    let _e461 = cVal;
                    param_402 = _e461;
                    let _e462 = getAge_u0028_u1_u003b((&param_402));
                    moisture_2 = _e462;
                    let _e463 = cType;
                    if (_e463 == 4u) {
                        let _e466 = tuning.dirtMoistureCapacity;
                        local_15 = _e466;
                    } else {
                        let _e468 = tuning.sandMoistureCapacity;
                        local_15 = _e468;
                    }
                    let _e469 = local_15;
                    capacity = _e469;
                    let _e470 = moisture_2;
                    let _e471 = capacity;
                    if (_e470 < _e471) {
                        let _e473 = (*currentIndex_6);
                        let _e476 = (*rawValue_5);
                        let _e477 = atomicCompareExchangeWeak((&unnamed.grid[_e473]), _e476, 0u);
                        let _e479 = (*rawValue_5);
                        if (_e477.old_value == _e479) {
                            let _e481 = cIndex;
                            let _e484 = atomicAdd((&unnamed.grid[_e481]), 16777216u);
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
            let _e485 = i_10;
            i_10 = (_e485 + 1i);
        }
    }
    i_11 = 0i;
    loop {
        let _e487 = i_11;
        if (_e487 < 3i) {
            let _e489 = i_11;
            let _e491 = checkPos[_e489];
            sPos_1 = _e491;
            let _e493 = sPos_1[1u];
            let _e495 = tuning.gridHeight;
            let _e498 = (_e493 < (bitcast<i32>(_e495) - 1i));
            phi_8616_ = _e498;
            if _e498 {
                let _e500 = sPos_1[0u];
                phi_8616_ = (_e500 > 0i);
            }
            let _e503 = phi_8616_;
            phi_8626_ = _e503;
            if _e503 {
                let _e505 = sPos_1[0u];
                let _e507 = tuning.gridWidth;
                phi_8626_ = (_e505 < (bitcast<i32>(_e507) - 1i));
            }
            let _e512 = phi_8626_;
            phi_8632_ = _e512;
            if _e512 {
                let _e514 = sPos_1[2u];
                phi_8632_ = (_e514 > 0i);
            }
            let _e517 = phi_8632_;
            phi_8642_ = _e517;
            if _e517 {
                let _e519 = sPos_1[2u];
                let _e521 = tuning.gridDepth;
                phi_8642_ = (_e519 < (bitcast<i32>(_e521) - 1i));
            }
            let _e526 = phi_8642_;
            if _e526 {
                let _e527 = sPos_1;
                param_403 = _e527;
                let _e528 = getIndex_u0028_vi3_u003b((&param_403));
                param_404 = _e528;
                let _e529 = readCell_u0028_u1_u003b((&param_404));
                param_405 = _e529;
                let _e530 = getType_u0028_u1_u003b((&param_405));
                sType_1 = _e530;
                let _e531 = sType_1;
                let _e533 = sType_1;
                if ((_e531 == 0u) || (_e533 == 5u)) {
                    let _e536 = sPos_1;
                    param_406 = _e536;
                    let _e537 = getIndex_u0028_vi3_u003b((&param_406));
                    param_407 = 6u;
                    param_408 = 0u;
                    param_409 = 0u;
                    let _e538 = newAge;
                    param_410 = _e538;
                    let _e539 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_407), (&param_408), (&param_409), (&param_410));
                    let _e540 = (*currentIndex_6);
                    param_411 = _e540;
                    let _e541 = (*rawValue_5);
                    param_412 = _e541;
                    param_413 = _e537;
                    param_414 = _e539;
                    let _e542 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_411), (&param_412), (&param_413), (&param_414));
                    if _e542 {
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e543 = i_11;
            i_11 = (_e543 + 1i);
        }
    }
    let _e545 = (*currentSleep_2);
    newSleep_1 = min((_e545 + 1u), 255u);
    let _e548 = (*currentIndex_6);
    let _e551 = (*rawValue_5);
    param_415 = 6u;
    param_416 = 0u;
    let _e552 = newSleep_1;
    param_417 = _e552;
    let _e553 = newAge;
    param_418 = _e553;
    let _e554 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_415), (&param_416), (&param_417), (&param_418));
    let _e555 = atomicCompareExchangeWeak((&unnamed.grid[_e548]), _e551, _e554);
    return;
}

fn updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_10: ptr<function, vec3<i32>>, currentIndex_7: ptr<function, u32>, rawValue_6: ptr<function, u32>, currentDir_3: ptr<function, u32>, currentSleep_3: ptr<function, u32>, currentAge_6: ptr<function, u32>, randVal_8: ptr<function, f32>) {
    var newAge_1: u32;
    var isBurningGrass: bool;
    var i_12: i32;
    var nPos_1: vec3<i32>;
    var param_419: i32;
    var nIndex_1: u32;
    var param_420: vec3<i32>;
    var nVal_1: u32;
    var param_421: u32;
    var param_422: u32;
    var param_423: u32;
    var param_424: u32;
    var param_425: u32;
    var param_426: u32;
    var burnRoll: f32;
    var start_6: i32;
    var i_13: i32;
    var nPos_2: vec3<i32>;
    var param_427: i32;
    var param_428: vec3<i32>;
    var nIndex_2: u32;
    var param_429: vec3<i32>;
    var nVal_2: u32;
    var param_430: u32;
    var nType_1: u32;
    var param_431: u32;
    var need_1: f32;
    var local_16: f32;
    var param_432: u32;
    var param_433: u32;
    var param_434: u32;
    var param_435: u32;
    var belowPos_4: vec3<i32>;
    var belowIndex_1: u32;
    var param_436: vec3<i32>;
    var belowValue_1: u32;
    var param_437: u32;
    var belowType: u32;
    var param_438: u32;
    var param_439: u32;
    var param_440: u32;
    var param_441: u32;
    var param_442: u32;
    var param_443: u32;
    var param_444: u32;
    var param_445: u32;
    var param_446: u32;
    var moisture_3: u32;
    var param_447: u32;
    var newMoisture: u32;
    var local_17: u32;
    var newVal: u32;
    var param_448: u32;
    var param_449: u32;
    var param_450: u32;
    var param_451: u32;
    var param_452: u32;
    var flora_3: u32;
    var newFlora: u32;
    var newVal_1: u32;
    var param_453: u32;
    var param_454: u32;
    var param_455: u32;
    var param_456: u32;
    var param_457: u32;
    var d_10: i32;
    var targetPos_1: vec3<i32>;
    var param_458: i32;
    var targetIndex_1: u32;
    var param_459: vec3<i32>;
    var param_460: u32;
    var param_461: u32;
    var targetBelow: vec3<i32>;
    var tBelowVal: u32;
    var param_462: vec3<i32>;
    var param_463: u32;
    var param_464: u32;
    var tFlora: u32;
    var param_465: u32;
    var param_466: u32;
    var param_467: u32;
    var param_468: u32;
    var param_469: u32;
    var param_470: u32;
    var param_471: u32;
    var param_472: u32;
    var phi_7619_: bool;
    var phi_7625_: bool;
    var phi_7635_: bool;
    var phi_7641_: bool;
    var phi_7651_: bool;
    var phi_7959_: bool;
    var phi_7965_: bool;
    var phi_7975_: bool;

    let _e291 = (*currentAge_6);
    newAge_1 = (_e291 + 1u);
    isBurningGrass = false;
    i_12 = 0i;
    loop {
        let _e293 = i_12;
        if (_e293 < 6i) {
            let _e295 = (*pos_10);
            let _e296 = i_12;
            param_419 = _e296;
            let _e297 = getOrthoDir_u0028_i1_u003b((&param_419));
            nPos_1 = (_e295 + _e297);
            let _e300 = nPos_1[0u];
            let _e301 = (_e300 > 0i);
            phi_7619_ = _e301;
            if _e301 {
                let _e303 = nPos_1[0u];
                let _e305 = tuning.gridWidth;
                phi_7619_ = (_e303 < (bitcast<i32>(_e305) - 1i));
            }
            let _e310 = phi_7619_;
            phi_7625_ = _e310;
            if _e310 {
                let _e312 = nPos_1[1u];
                phi_7625_ = (_e312 > 0i);
            }
            let _e315 = phi_7625_;
            phi_7635_ = _e315;
            if _e315 {
                let _e317 = nPos_1[1u];
                let _e319 = tuning.gridHeight;
                phi_7635_ = (_e317 < (bitcast<i32>(_e319) - 1i));
            }
            let _e324 = phi_7635_;
            phi_7641_ = _e324;
            if _e324 {
                let _e326 = nPos_1[2u];
                phi_7641_ = (_e326 > 0i);
            }
            let _e329 = phi_7641_;
            phi_7651_ = _e329;
            if _e329 {
                let _e331 = nPos_1[2u];
                let _e333 = tuning.gridDepth;
                phi_7651_ = (_e331 < (bitcast<i32>(_e333) - 1i));
            }
            let _e338 = phi_7651_;
            if _e338 {
                let _e339 = nPos_1;
                param_420 = _e339;
                let _e340 = getIndex_u0028_vi3_u003b((&param_420));
                nIndex_1 = _e340;
                let _e341 = nIndex_1;
                param_421 = _e341;
                let _e342 = readCell_u0028_u1_u003b((&param_421));
                nVal_1 = _e342;
                let _e343 = nVal_1;
                param_422 = _e343;
                let _e344 = getType_u0028_u1_u003b((&param_422));
                if (_e344 == 2u) {
                    let _e346 = nIndex_1;
                    let _e349 = nVal_1;
                    param_423 = 6u;
                    param_424 = 0u;
                    param_425 = 0u;
                    param_426 = 0u;
                    let _e350 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_423), (&param_424), (&param_425), (&param_426));
                    let _e351 = atomicCompareExchangeWeak((&unnamed.grid[_e346]), _e349, _e350);
                    let _e353 = nVal_1;
                    if (_e351.old_value == _e353) {
                        decWater_u0028_();
                        let _e355 = (*currentIndex_7);
                        let _e358 = atomicExchange((&unnamed.grid[_e355]), 0u);
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e359 = i_12;
            i_12 = (_e359 + 1i);
        }
    }
    let _e361 = (*randVal_8);
    burnRoll = fract((_e361 * 47f));
    let _e364 = burnRoll;
    let _e366 = tuning.treeLeafBurnChance;
    let _e368 = tuning.treeTrunkBurnChance;
    if (_e364 < max(_e366, _e368)) {
        let _e371 = (*randVal_8);
        start_6 = i32((fract((_e371 * 31f)) * 26f));
        i_13 = 0i;
        loop {
            let _e376 = i_13;
            if (_e376 < 26i) {
                let _e378 = (*pos_10);
                let _e379 = start_6;
                let _e380 = i_13;
                let _e381 = (_e379 + _e380);
                param_427 = (_e381 - (i32(floor((f32(_e381) / f32(26i)))) * 26i));
                let _e389 = tree26_u0028_i1_u003b((&param_427));
                nPos_2 = (_e378 + _e389);
                let _e391 = nPos_2;
                param_428 = _e391;
                let _e392 = treeInBounds_u0028_vi3_u003b((&param_428));
                if !(_e392) {
                    continue;
                }
                let _e394 = nPos_2;
                param_429 = _e394;
                let _e395 = getIndex_u0028_vi3_u003b((&param_429));
                nIndex_2 = _e395;
                let _e396 = nIndex_2;
                param_430 = _e396;
                let _e397 = readCell_u0028_u1_u003b((&param_430));
                nVal_2 = _e397;
                let _e398 = nVal_2;
                param_431 = _e398;
                let _e399 = getType_u0028_u1_u003b((&param_431));
                nType_1 = _e399;
                let _e400 = nType_1;
                let _e402 = nType_1;
                if ((_e400 != 19u) && (_e402 != 18u)) {
                    continue;
                }
                let _e405 = nType_1;
                if (_e405 == 19u) {
                    let _e408 = tuning.treeLeafBurnChance;
                    local_16 = _e408;
                } else {
                    let _e410 = tuning.treeTrunkBurnChance;
                    local_16 = _e410;
                }
                let _e411 = local_16;
                need_1 = _e411;
                let _e412 = burnRoll;
                let _e413 = need_1;
                if (_e412 < _e413) {
                    let _e415 = nIndex_2;
                    let _e418 = nVal_2;
                    param_432 = 5u;
                    param_433 = 0u;
                    param_434 = 0u;
                    param_435 = 0u;
                    let _e419 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_432), (&param_433), (&param_434), (&param_435));
                    let _e420 = atomicCompareExchangeWeak((&unnamed.grid[_e415]), _e418, _e419);
                }
                break;
            } else {
                break;
            }
            continuing {
                let _e422 = i_13;
                i_13 = (_e422 + 1i);
            }
        }
    }
    let _e425 = (*pos_10)[1u];
    if (_e425 > 1i) {
        let _e427 = (*pos_10);
        belowPos_4 = (_e427 + vec3<i32>(0i, -1i, 0i));
        let _e429 = belowPos_4;
        param_436 = _e429;
        let _e430 = getIndex_u0028_vi3_u003b((&param_436));
        belowIndex_1 = _e430;
        let _e431 = belowIndex_1;
        param_437 = _e431;
        let _e432 = readCell_u0028_u1_u003b((&param_437));
        belowValue_1 = _e432;
        let _e433 = belowValue_1;
        param_438 = _e433;
        let _e434 = getType_u0028_u1_u003b((&param_438));
        belowType = _e434;
        let _e435 = belowType;
        if (_e435 == 0u) {
            param_439 = 5u;
            param_440 = 0u;
            param_441 = 0u;
            let _e437 = newAge_1;
            param_442 = _e437;
            let _e438 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_439), (&param_440), (&param_441), (&param_442));
            let _e439 = (*currentIndex_7);
            param_443 = _e439;
            let _e440 = (*rawValue_6);
            param_444 = _e440;
            let _e441 = belowIndex_1;
            param_445 = _e441;
            param_446 = _e438;
            let _e442 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_443), (&param_444), (&param_445), (&param_446));
            if _e442 {
                return;
            }
        } else {
            let _e443 = belowType;
            if (_e443 == 2u) {
                let _e445 = (*currentIndex_7);
                let _e448 = atomicExchange((&unnamed.grid[_e445]), 0u);
                return;
            } else {
                let _e449 = belowType;
                if (_e449 == 1u) {
                    let _e451 = belowValue_1;
                    param_447 = _e451;
                    let _e452 = getAge_u0028_u1_u003b((&param_447));
                    moisture_3 = _e452;
                    let _e453 = moisture_3;
                    if (_e453 > 0u) {
                        let _e455 = moisture_3;
                        let _e457 = tuning.fireDryRate;
                        if (_e455 > _e457) {
                            let _e459 = moisture_3;
                            let _e461 = tuning.fireDryRate;
                            local_17 = (_e459 - _e461);
                        } else {
                            local_17 = 0u;
                        }
                        let _e463 = local_17;
                        newMoisture = _e463;
                        let _e464 = belowValue_1;
                        param_448 = _e464;
                        let _e465 = getDir_u0028_u1_u003b((&param_448));
                        param_449 = 1u;
                        param_450 = _e465;
                        param_451 = 0u;
                        let _e466 = newMoisture;
                        param_452 = _e466;
                        let _e467 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_449), (&param_450), (&param_451), (&param_452));
                        newVal = _e467;
                        let _e468 = belowIndex_1;
                        let _e471 = belowValue_1;
                        let _e472 = newVal;
                        let _e473 = atomicCompareExchangeWeak((&unnamed.grid[_e468]), _e471, _e472);
                        let _e475 = belowValue_1;
                        if (_e473.old_value == _e475) {
                            let _e477 = (*currentIndex_7);
                            let _e480 = atomicExchange((&unnamed.grid[_e477]), 0u);
                            return;
                        }
                    }
                } else {
                    let _e481 = belowType;
                    if (_e481 == 4u) {
                        let _e483 = belowValue_1;
                        flora_3 = ((_e483 >> bitcast<u32>(8i)) & 255u);
                        let _e487 = flora_3;
                        let _e489 = flora_3;
                        if ((_e487 > 10u) && (_e489 <= 100u)) {
                            isBurningGrass = true;
                            newAge_1 = 0u;
                            let _e492 = (*randVal_8);
                            let _e496 = tuning.fireBurnGrassChance;
                            if (fract((_e492 * 100f)) < _e496) {
                                let _e498 = flora_3;
                                newFlora = (_e498 - 1u);
                                let _e500 = belowValue_1;
                                param_453 = _e500;
                                let _e501 = getAge_u0028_u1_u003b((&param_453));
                                param_454 = 4u;
                                let _e502 = newFlora;
                                param_455 = _e502;
                                param_456 = 0u;
                                param_457 = _e501;
                                let _e503 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_454), (&param_455), (&param_456), (&param_457));
                                newVal_1 = _e503;
                                let _e504 = belowIndex_1;
                                let _e507 = belowValue_1;
                                let _e508 = newVal_1;
                                let _e509 = atomicCompareExchangeWeak((&unnamed.grid[_e504]), _e507, _e508);
                            }
                            let _e511 = (*randVal_8);
                            let _e515 = tuning.fireSpreadChance;
                            if (fract((_e511 * 100f)) < _e515) {
                                let _e517 = (*randVal_8);
                                d_10 = i32((fract((_e517 * 10f)) * 8f));
                                let _e522 = (*pos_10);
                                let _e523 = d_10;
                                param_458 = _e523;
                                let _e524 = getHDir_u0028_i1_u003b((&param_458));
                                targetPos_1 = (_e522 + _e524);
                                let _e527 = targetPos_1[0u];
                                let _e528 = (_e527 > 0i);
                                phi_7959_ = _e528;
                                if _e528 {
                                    let _e530 = targetPos_1[0u];
                                    let _e532 = tuning.gridWidth;
                                    phi_7959_ = (_e530 < (bitcast<i32>(_e532) - 1i));
                                }
                                let _e537 = phi_7959_;
                                phi_7965_ = _e537;
                                if _e537 {
                                    let _e539 = targetPos_1[2u];
                                    phi_7965_ = (_e539 > 0i);
                                }
                                let _e542 = phi_7965_;
                                phi_7975_ = _e542;
                                if _e542 {
                                    let _e544 = targetPos_1[2u];
                                    let _e546 = tuning.gridDepth;
                                    phi_7975_ = (_e544 < (bitcast<i32>(_e546) - 1i));
                                }
                                let _e551 = phi_7975_;
                                if _e551 {
                                    let _e552 = targetPos_1;
                                    param_459 = _e552;
                                    let _e553 = getIndex_u0028_vi3_u003b((&param_459));
                                    targetIndex_1 = _e553;
                                    let _e554 = targetIndex_1;
                                    param_460 = _e554;
                                    let _e555 = readCell_u0028_u1_u003b((&param_460));
                                    param_461 = _e555;
                                    let _e556 = getType_u0028_u1_u003b((&param_461));
                                    if (_e556 == 0u) {
                                        let _e558 = targetPos_1;
                                        targetBelow = (_e558 + vec3<i32>(0i, -1i, 0i));
                                        let _e560 = targetBelow;
                                        param_462 = _e560;
                                        let _e561 = getIndex_u0028_vi3_u003b((&param_462));
                                        param_463 = _e561;
                                        let _e562 = readCell_u0028_u1_u003b((&param_463));
                                        tBelowVal = _e562;
                                        let _e563 = tBelowVal;
                                        param_464 = _e563;
                                        let _e564 = getType_u0028_u1_u003b((&param_464));
                                        if (_e564 == 4u) {
                                            let _e566 = tBelowVal;
                                            tFlora = ((_e566 >> bitcast<u32>(8i)) & 255u);
                                            let _e570 = tFlora;
                                            let _e572 = tFlora;
                                            if ((_e570 > 10u) && (_e572 <= 100u)) {
                                                let _e575 = targetIndex_1;
                                                param_465 = 5u;
                                                param_466 = 0u;
                                                param_467 = 0u;
                                                param_468 = 0u;
                                                let _e578 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_465), (&param_466), (&param_467), (&param_468));
                                                let _e579 = atomicCompareExchangeWeak((&unnamed.grid[_e575]), 0u, _e578);
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
    let _e581 = newAge_1;
    let _e583 = tuning.fireLifetime;
    if (_e581 > _e583) {
        let _e585 = (*currentIndex_7);
        let _e588 = atomicExchange((&unnamed.grid[_e585]), 0u);
        return;
    }
    let _e589 = (*currentIndex_7);
    let _e592 = (*rawValue_6);
    param_469 = 5u;
    param_470 = 0u;
    param_471 = 0u;
    let _e593 = newAge_1;
    param_472 = _e593;
    let _e594 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_469), (&param_470), (&param_471), (&param_472));
    let _e595 = atomicCompareExchangeWeak((&unnamed.grid[_e589]), _e592, _e594);
    return;
}

fn isLocust_u0028_u1_u003b(type_36: ptr<function, u32>) -> bool {
    let _e199 = (*type_36);
    let _e201 = (*type_36);
    return ((_e199 >= 13u) && (_e201 <= 17u));
}

fn tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex_8: ptr<function, u32>, currentValue_1: ptr<function, u32>, targetIndex_2: ptr<function, u32>, targetValue_1: ptr<function, u32>, pushIndex: ptr<function, u32>) -> bool {
    var displacedValue: u32;
    var param_473: u32;
    var param_474: u32;
    var param_475: u32;
    var param_476: u32;
    var param_477: u32;
    var actualPush: u32;
    var actualTarget: u32;

    let _e211 = (*currentIndex_8);
    let _e214 = (*currentValue_1);
    let _e215 = atomicCompareExchangeWeak((&unnamed.grid[_e211]), _e214, 0u);
    let _e217 = (*currentValue_1);
    if (_e215.old_value == _e217) {
        let _e219 = (*targetValue_1);
        param_473 = _e219;
        let _e220 = getType_u0028_u1_u003b((&param_473));
        param_474 = _e220;
        param_475 = 0u;
        param_476 = 0u;
        param_477 = 0u;
        let _e221 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_474), (&param_475), (&param_476), (&param_477));
        displacedValue = _e221;
        let _e222 = (*pushIndex);
        let _e225 = displacedValue;
        let _e226 = atomicCompareExchangeWeak((&unnamed.grid[_e222]), 0u, _e225);
        actualPush = _e226.old_value;
        let _e228 = actualPush;
        if (_e228 == 0u) {
            let _e230 = (*targetIndex_2);
            let _e233 = (*targetValue_1);
            let _e234 = (*currentValue_1);
            let _e235 = atomicCompareExchangeWeak((&unnamed.grid[_e230]), _e233, _e234);
            actualTarget = _e235.old_value;
            let _e237 = actualTarget;
            let _e238 = (*targetValue_1);
            if (_e237 == _e238) {
                return true;
            } else {
                let _e240 = (*pushIndex);
                let _e243 = displacedValue;
                let _e244 = atomicCompareExchangeWeak((&unnamed.grid[_e240]), _e243, 0u);
            }
        }
        let _e246 = (*currentIndex_8);
        let _e249 = (*currentValue_1);
        let _e250 = atomicCompareExchangeWeak((&unnamed.grid[_e246]), 0u, _e249);
    }
    return false;
}

fn grainCanMove_u0028_vi3_u003b(pos_11: ptr<function, vec3<i32>>) -> bool {
    var i_14: i32;
    var target_1: vec3<i32>;
    var local_18: i32;
    var local_19: i32;
    var t_3: u32;
    var param_478: vec3<i32>;
    var param_479: u32;
    var param_480: u32;
    var phi_2291_: bool;
    var phi_2298_: bool;
    var phi_2309_: bool;

    let _e208 = (*pos_11)[1u];
    if (_e208 <= 1i) {
        return false;
    }
    i_14 = 0i;
    loop {
        let _e210 = i_14;
        if (_e210 < 5i) {
            let _e212 = (*pos_11);
            let _e213 = i_14;
            if (_e213 == 1i) {
                local_18 = 1i;
            } else {
                let _e215 = i_14;
                local_18 = select(0i, -1i, (_e215 == 2i));
            }
            let _e218 = local_18;
            let _e219 = i_14;
            if (_e219 == 3i) {
                local_19 = 1i;
            } else {
                let _e221 = i_14;
                local_19 = select(0i, -1i, (_e221 == 4i));
            }
            let _e224 = local_19;
            target_1 = (_e212 + vec3<i32>(_e218, -1i, _e224));
            let _e228 = target_1[0u];
            let _e229 = (_e228 <= 0i);
            phi_2291_ = _e229;
            if !(_e229) {
                let _e232 = target_1[0u];
                let _e234 = tuning.gridWidth;
                phi_2291_ = (_e232 >= (bitcast<i32>(_e234) - 1i));
            }
            let _e239 = phi_2291_;
            phi_2298_ = _e239;
            if !(_e239) {
                let _e242 = target_1[2u];
                phi_2298_ = (_e242 <= 0i);
            }
            let _e245 = phi_2298_;
            phi_2309_ = _e245;
            if !(_e245) {
                let _e248 = target_1[2u];
                let _e250 = tuning.gridDepth;
                phi_2309_ = (_e248 >= (bitcast<i32>(_e250) - 1i));
            }
            let _e255 = phi_2309_;
            if _e255 {
                continue;
            }
            let _e256 = target_1;
            param_478 = _e256;
            let _e257 = getIndex_u0028_vi3_u003b((&param_478));
            param_479 = _e257;
            let _e258 = readCell_u0028_u1_u003b((&param_479));
            param_480 = _e258;
            let _e259 = getType_u0028_u1_u003b((&param_480));
            t_3 = _e259;
            let _e260 = t_3;
            let _e262 = t_3;
            if ((_e260 == 0u) || (_e262 == 2u)) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e265 = i_14;
            i_14 = (_e265 + 1i);
        }
    }
    return false;
}

fn updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_12: ptr<function, vec3<i32>>, currentIndex_9: ptr<function, u32>, rawValue_7: ptr<function, u32>, currentDir_4: ptr<function, u32>, currentSleep_4: ptr<function, u32>, currentAge_7: ptr<function, u32>, randVal_9: ptr<function, f32>) {
    var moisture_4: u32;
    var moistureModified: bool;
    var startDir_1: i32;
    var i_15: i32;
    var d_11: i32;
    var nPos_3: vec3<i32>;
    var param_481: i32;
    var nIndex_3: u32;
    var param_482: vec3<i32>;
    var nVal_3: u32;
    var param_483: u32;
    var param_484: u32;
    var d_12: i32;
    var nPos_4: vec3<i32>;
    var param_485: i32;
    var nIndex_4: u32;
    var param_486: vec3<i32>;
    var nVal_4: u32;
    var param_487: u32;
    var nType_2: u32;
    var param_488: u32;
    var nMoisture: u32;
    var param_489: u32;
    var nCapacity: u32;
    var local_20: u32;
    var canMove: bool;
    var param_490: vec3<i32>;
    var isClumped: bool;
    var emptyBelowCount: i32;
    var x: i32;
    var z: i32;
    var checkPos_1: vec3<i32>;
    var param_491: vec3<i32>;
    var param_492: u32;
    var param_493: u32;
    var clumpCount: i32;
    var x_1: i32;
    var y: i32;
    var z_1: i32;
    var nPos_5: vec3<i32>;
    var param_494: vec3<i32>;
    var param_495: u32;
    var param_496: u32;
    var belowPos_5: vec3<i32>;
    var param_497: vec3<i32>;
    var param_498: u32;
    var param_499: u32;
    var param_500: vec3<i32>;
    var param_501: u32;
    var param_502: u32;
    var param_503: u32;
    var param_504: u32;
    var param_505: u32;
    var param_506: u32;
    var param_507: u32;
    var param_508: u32;
    var dir_2: i32;
    var slidePos1_: vec3<i32>;
    var slidePos2_: vec3<i32>;
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
    var belowPos_6: vec3<i32>;
    var belowIndex_2: u32;
    var param_533: vec3<i32>;
    var belowValue_2: u32;
    var param_534: u32;
    var param_535: u32;
    var startDir_2: i32;
    var i_16: i32;
    var d_13: i32;
    var pushPos: vec3<i32>;
    var param_536: i32;
    var param_537: u32;
    var param_538: u32;
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
    var param_550: u32;
    var param_551: u32;
    var param_552: u32;
    var param_553: u32;
    var param_554: u32;
    var dir_3: i32;
    var slidePos: array<vec3<i32>, 2>;
    var s_1: i32;
    var sPos_2: vec3<i32>;
    var sIndex: u32;
    var param_555: vec3<i32>;
    var sValue: u32;
    var param_556: u32;
    var param_557: u32;
    var startDir_3: i32;
    var i_17: i32;
    var d_14: i32;
    var pushPos_1: vec3<i32>;
    var param_558: i32;
    var param_559: u32;
    var param_560: u32;
    var param_561: u32;
    var param_562: u32;
    var param_563: vec3<i32>;
    var param_564: u32;
    var param_565: u32;
    var param_566: u32;
    var param_567: u32;
    var param_568: u32;
    var param_569: u32;
    var param_570: u32;
    var param_571: u32;
    var param_572: u32;
    var param_573: u32;
    var param_574: u32;
    var param_575: u32;
    var param_576: u32;
    var floraState: u32;
    var abovePos_1: vec3<i32>;
    var aboveInside: bool;
    var aboveIndex: u32;
    var param_577: vec3<i32>;
    var aboveType: u32;
    var local_21: u32;
    var param_578: u32;
    var param_579: u32;
    var param_580: u32;
    var param_581: u32;
    var param_582: u32;
    var param_583: u32;
    var param_584: u32;
    var newSleep_2: u32;
    var param_585: u32;
    var param_586: u32;
    var param_587: u32;
    var param_588: u32;
    var phi_3422_: bool;
    var phi_3428_: bool;
    var phi_3438_: bool;
    var phi_3444_: bool;
    var phi_3454_: bool;
    var phi_3520_: bool;
    var phi_3526_: bool;
    var phi_3536_: bool;
    var phi_3542_: bool;
    var phi_3552_: bool;
    var phi_3622_: bool;
    var phi_3664_: bool;
    var phi_3670_: bool;
    var phi_3679_: bool;
    var phi_3760_: bool;
    var phi_3766_: bool;
    var phi_3775_: bool;
    var phi_3781_: bool;
    var phi_3790_: bool;
    var phi_3909_: bool;
    var phi_3915_: bool;
    var phi_3925_: bool;
    var phi_3969_: bool;
    var phi_3975_: bool;
    var phi_3985_: bool;
    var phi_4076_: bool;
    var phi_4082_: bool;
    var phi_4092_: bool;
    var phi_4193_: bool;
    var phi_4199_: bool;
    var phi_4209_: bool;
    var phi_4266_: bool;
    var phi_4272_: bool;
    var phi_4282_: bool;
    var phi_4337_: bool;
    var phi_4411_: bool;
    var phi_4466_: bool;

    let _e368 = (*currentAge_7);
    moisture_4 = _e368;
    moistureModified = false;
    let _e369 = moisture_4;
    let _e371 = tuning.dirtMoistureCapacity;
    if (_e369 < _e371) {
        let _e373 = (*randVal_9);
        startDir_1 = i32((fract((_e373 * 17f)) * 6f));
        i_15 = 0i;
        loop {
            let _e378 = i_15;
            if (_e378 < 6i) {
                let _e380 = startDir_1;
                let _e381 = i_15;
                let _e382 = (_e380 + _e381);
                d_11 = (_e382 - (i32(floor((f32(_e382) / f32(6i)))) * 6i));
                let _e390 = (*pos_12);
                let _e391 = d_11;
                param_481 = _e391;
                let _e392 = getOrthoDir_u0028_i1_u003b((&param_481));
                nPos_3 = (_e390 + _e392);
                let _e395 = nPos_3[0u];
                let _e396 = (_e395 > 0i);
                phi_3422_ = _e396;
                if _e396 {
                    let _e398 = nPos_3[0u];
                    let _e400 = tuning.gridWidth;
                    phi_3422_ = (_e398 < (bitcast<i32>(_e400) - 1i));
                }
                let _e405 = phi_3422_;
                phi_3428_ = _e405;
                if _e405 {
                    let _e407 = nPos_3[1u];
                    phi_3428_ = (_e407 > 0i);
                }
                let _e410 = phi_3428_;
                phi_3438_ = _e410;
                if _e410 {
                    let _e412 = nPos_3[1u];
                    let _e414 = tuning.gridHeight;
                    phi_3438_ = (_e412 < (bitcast<i32>(_e414) - 1i));
                }
                let _e419 = phi_3438_;
                phi_3444_ = _e419;
                if _e419 {
                    let _e421 = nPos_3[2u];
                    phi_3444_ = (_e421 > 0i);
                }
                let _e424 = phi_3444_;
                phi_3454_ = _e424;
                if _e424 {
                    let _e426 = nPos_3[2u];
                    let _e428 = tuning.gridDepth;
                    phi_3454_ = (_e426 < (bitcast<i32>(_e428) - 1i));
                }
                let _e433 = phi_3454_;
                if _e433 {
                    let _e434 = nPos_3;
                    param_482 = _e434;
                    let _e435 = getIndex_u0028_vi3_u003b((&param_482));
                    nIndex_3 = _e435;
                    let _e436 = nIndex_3;
                    param_483 = _e436;
                    let _e437 = readCell_u0028_u1_u003b((&param_483));
                    nVal_3 = _e437;
                    let _e438 = nVal_3;
                    param_484 = _e438;
                    let _e439 = getType_u0028_u1_u003b((&param_484));
                    if (_e439 == 2u) {
                        let _e441 = nIndex_3;
                        let _e444 = nVal_3;
                        let _e445 = atomicCompareExchangeWeak((&unnamed.grid[_e441]), _e444, 0u);
                        let _e447 = nVal_3;
                        if (_e445.old_value == _e447) {
                            let _e449 = (*currentIndex_9);
                            let _e453 = tuning.sandWaterAbsorbUnit;
                            let _e456 = atomicAdd((&unnamed.grid[_e449]), (_e453 << bitcast<u32>(24i)));
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
                let _e457 = i_15;
                i_15 = (_e457 + 1i);
            }
        }
    }
    let _e459 = moistureModified;
    let _e461 = moisture_4;
    if (!(_e459) && (_e461 > 0u)) {
        let _e464 = (*randVal_9);
        d_12 = i32((fract((_e464 * 31f)) * 6f));
        let _e469 = (*pos_12);
        let _e470 = d_12;
        param_485 = _e470;
        let _e471 = getOrthoDir_u0028_i1_u003b((&param_485));
        nPos_4 = (_e469 + _e471);
        let _e474 = nPos_4[0u];
        let _e475 = (_e474 > 0i);
        phi_3520_ = _e475;
        if _e475 {
            let _e477 = nPos_4[0u];
            let _e479 = tuning.gridWidth;
            phi_3520_ = (_e477 < (bitcast<i32>(_e479) - 1i));
        }
        let _e484 = phi_3520_;
        phi_3526_ = _e484;
        if _e484 {
            let _e486 = nPos_4[1u];
            phi_3526_ = (_e486 > 0i);
        }
        let _e489 = phi_3526_;
        phi_3536_ = _e489;
        if _e489 {
            let _e491 = nPos_4[1u];
            let _e493 = tuning.gridHeight;
            phi_3536_ = (_e491 < (bitcast<i32>(_e493) - 1i));
        }
        let _e498 = phi_3536_;
        phi_3542_ = _e498;
        if _e498 {
            let _e500 = nPos_4[2u];
            phi_3542_ = (_e500 > 0i);
        }
        let _e503 = phi_3542_;
        phi_3552_ = _e503;
        if _e503 {
            let _e505 = nPos_4[2u];
            let _e507 = tuning.gridDepth;
            phi_3552_ = (_e505 < (bitcast<i32>(_e507) - 1i));
        }
        let _e512 = phi_3552_;
        if _e512 {
            let _e513 = nPos_4;
            param_486 = _e513;
            let _e514 = getIndex_u0028_vi3_u003b((&param_486));
            nIndex_4 = _e514;
            let _e515 = nIndex_4;
            param_487 = _e515;
            let _e516 = readCell_u0028_u1_u003b((&param_487));
            nVal_4 = _e516;
            let _e517 = nVal_4;
            param_488 = _e517;
            let _e518 = getType_u0028_u1_u003b((&param_488));
            nType_2 = _e518;
            let _e519 = nType_2;
            let _e521 = nType_2;
            if ((_e519 == 4u) || (_e521 == 1u)) {
                let _e524 = nVal_4;
                param_489 = _e524;
                let _e525 = getAge_u0028_u1_u003b((&param_489));
                nMoisture = _e525;
                let _e526 = nType_2;
                if (_e526 == 4u) {
                    let _e529 = tuning.dirtMoistureCapacity;
                    local_20 = _e529;
                } else {
                    let _e531 = tuning.sandMoistureCapacity;
                    local_20 = _e531;
                }
                let _e532 = local_20;
                nCapacity = _e532;
                let _e533 = moisture_4;
                let _e534 = nMoisture;
                let _e537 = nMoisture;
                let _e538 = nCapacity;
                if ((_e533 > (_e534 + 1u)) && (_e537 < _e538)) {
                    let _e541 = (*currentIndex_9);
                    let _e544 = atomicAdd((&unnamed.grid[_e541]), 4278190080u);
                    let _e545 = nIndex_4;
                    let _e548 = atomicAdd((&unnamed.grid[_e545]), 16777216u);
                    moistureModified = true;
                }
            }
        }
    }
    let _e549 = moistureModified;
    if _e549 {
        return;
    }
    let _e550 = (*pos_12);
    param_490 = _e550;
    let _e551 = grainCanMove_u0028_vi3_u003b((&param_490));
    canMove = _e551;
    isClumped = false;
    let _e552 = canMove;
    phi_3622_ = _e552;
    if _e552 {
        let _e553 = (*currentSleep_4);
        let _e555 = tuning.wakeSleepThreshold;
        phi_3622_ = (_e553 > _e555);
    }
    let _e558 = phi_3622_;
    if _e558 {
        emptyBelowCount = 0i;
        let _e560 = (*pos_12)[1u];
        if (_e560 > 1i) {
            x = -1i;
            loop {
                let _e562 = x;
                if (_e562 <= 1i) {
                    z = -1i;
                    loop {
                        let _e564 = z;
                        if (_e564 <= 1i) {
                            let _e566 = (*pos_12);
                            let _e567 = x;
                            let _e568 = z;
                            checkPos_1 = (_e566 + vec3<i32>(_e567, -1i, _e568));
                            let _e572 = checkPos_1[0u];
                            let _e573 = (_e572 >= 0i);
                            phi_3664_ = _e573;
                            if _e573 {
                                let _e575 = checkPos_1[0u];
                                let _e577 = tuning.gridWidth;
                                phi_3664_ = (_e575 < bitcast<i32>(_e577));
                            }
                            let _e581 = phi_3664_;
                            phi_3670_ = _e581;
                            if _e581 {
                                let _e583 = checkPos_1[2u];
                                phi_3670_ = (_e583 >= 0i);
                            }
                            let _e586 = phi_3670_;
                            phi_3679_ = _e586;
                            if _e586 {
                                let _e588 = checkPos_1[2u];
                                let _e590 = tuning.gridDepth;
                                phi_3679_ = (_e588 < bitcast<i32>(_e590));
                            }
                            let _e594 = phi_3679_;
                            if _e594 {
                                let _e595 = checkPos_1;
                                param_491 = _e595;
                                let _e596 = getIndex_u0028_vi3_u003b((&param_491));
                                param_492 = _e596;
                                let _e597 = readCell_u0028_u1_u003b((&param_492));
                                param_493 = _e597;
                                let _e598 = getType_u0028_u1_u003b((&param_493));
                                if (_e598 == 0u) {
                                    let _e600 = emptyBelowCount;
                                    emptyBelowCount = (_e600 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e602 = z;
                            z = (_e602 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e604 = x;
                    x = (_e604 + 1i);
                }
            }
        }
        let _e606 = emptyBelowCount;
        let _e608 = tuning.emptyBelowWakeCount;
        if (_e606 >= bitcast<i32>(_e608)) {
            (*currentSleep_4) = 0u;
        } else {
            clumpCount = 0i;
            x_1 = -1i;
            loop {
                let _e611 = x_1;
                if (_e611 <= 1i) {
                    y = -1i;
                    loop {
                        let _e613 = y;
                        if (_e613 <= 1i) {
                            z_1 = -1i;
                            loop {
                                let _e615 = z_1;
                                if (_e615 <= 1i) {
                                    let _e617 = x_1;
                                    let _e619 = y;
                                    let _e622 = z_1;
                                    if (((_e617 == 0i) && (_e619 == 0i)) && (_e622 == 0i)) {
                                        continue;
                                    }
                                    let _e625 = (*pos_12);
                                    let _e626 = x_1;
                                    let _e627 = y;
                                    let _e628 = z_1;
                                    nPos_5 = (_e625 + vec3<i32>(_e626, _e627, _e628));
                                    let _e632 = nPos_5[0u];
                                    let _e633 = (_e632 >= 0i);
                                    phi_3760_ = _e633;
                                    if _e633 {
                                        let _e635 = nPos_5[0u];
                                        let _e637 = tuning.gridWidth;
                                        phi_3760_ = (_e635 < bitcast<i32>(_e637));
                                    }
                                    let _e641 = phi_3760_;
                                    phi_3766_ = _e641;
                                    if _e641 {
                                        let _e643 = nPos_5[1u];
                                        phi_3766_ = (_e643 >= 0i);
                                    }
                                    let _e646 = phi_3766_;
                                    phi_3775_ = _e646;
                                    if _e646 {
                                        let _e648 = nPos_5[1u];
                                        let _e650 = tuning.gridHeight;
                                        phi_3775_ = (_e648 < bitcast<i32>(_e650));
                                    }
                                    let _e654 = phi_3775_;
                                    phi_3781_ = _e654;
                                    if _e654 {
                                        let _e656 = nPos_5[2u];
                                        phi_3781_ = (_e656 >= 0i);
                                    }
                                    let _e659 = phi_3781_;
                                    phi_3790_ = _e659;
                                    if _e659 {
                                        let _e661 = nPos_5[2u];
                                        let _e663 = tuning.gridDepth;
                                        phi_3790_ = (_e661 < bitcast<i32>(_e663));
                                    }
                                    let _e667 = phi_3790_;
                                    if _e667 {
                                        let _e668 = nPos_5;
                                        param_494 = _e668;
                                        let _e669 = getIndex_u0028_vi3_u003b((&param_494));
                                        param_495 = _e669;
                                        let _e670 = readCell_u0028_u1_u003b((&param_495));
                                        param_496 = _e670;
                                        let _e671 = getType_u0028_u1_u003b((&param_496));
                                        if (_e671 == 4u) {
                                            let _e673 = clumpCount;
                                            clumpCount = (_e673 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e675 = z_1;
                                    z_1 = (_e675 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e677 = y;
                            y = (_e677 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e679 = x_1;
                    x_1 = (_e679 + 1i);
                }
            }
            let _e681 = clumpCount;
            let _e683 = tuning.dirtClumpThreshold;
            if (_e681 >= bitcast<i32>(_e683)) {
                isClumped = true;
            }
        }
    }
    let _e686 = canMove;
    let _e687 = isClumped;
    if (_e686 && !(_e687)) {
        let _e691 = (*pos_12)[1u];
        if (_e691 > 1i) {
            let _e693 = (*pos_12);
            belowPos_5 = (_e693 + vec3<i32>(0i, -1i, 0i));
            let _e695 = belowPos_5;
            param_497 = _e695;
            let _e696 = getIndex_u0028_vi3_u003b((&param_497));
            param_498 = _e696;
            let _e697 = readCell_u0028_u1_u003b((&param_498));
            param_499 = _e697;
            let _e698 = getType_u0028_u1_u003b((&param_499));
            if (_e698 == 0u) {
                let _e700 = belowPos_5;
                param_500 = _e700;
                let _e701 = getIndex_u0028_vi3_u003b((&param_500));
                param_501 = 4u;
                param_502 = 0u;
                param_503 = 0u;
                let _e702 = moisture_4;
                param_504 = _e702;
                let _e703 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_501), (&param_502), (&param_503), (&param_504));
                let _e704 = (*currentIndex_9);
                param_505 = _e704;
                let _e705 = (*rawValue_7);
                param_506 = _e705;
                param_507 = _e701;
                param_508 = _e703;
                let _e706 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_505), (&param_506), (&param_507), (&param_508));
                if _e706 {
                    return;
                }
            }
        }
        let _e708 = (*pos_12)[1u];
        if (_e708 > 1i) {
            let _e710 = (*randVal_9);
            dir_2 = select(-1i, 1i, (fract((_e710 * 10f)) > 0.5f));
            let _e715 = (*randVal_9);
            if (fract((_e715 * 100f)) > 0.5f) {
                let _e719 = (*pos_12);
                let _e720 = dir_2;
                slidePos1_ = (_e719 + vec3<i32>(_e720, -1i, 0i));
                let _e723 = (*pos_12);
                let _e724 = dir_2;
                slidePos2_ = (_e723 + vec3<i32>(0i, -1i, _e724));
            } else {
                let _e727 = (*pos_12);
                let _e728 = dir_2;
                slidePos1_ = (_e727 + vec3<i32>(0i, -1i, _e728));
                let _e731 = (*pos_12);
                let _e732 = dir_2;
                slidePos2_ = (_e731 + vec3<i32>(_e732, -1i, 0i));
            }
            let _e736 = slidePos1_[0u];
            let _e737 = (_e736 > 0i);
            phi_3909_ = _e737;
            if _e737 {
                let _e739 = slidePos1_[0u];
                let _e741 = tuning.gridWidth;
                phi_3909_ = (_e739 < (bitcast<i32>(_e741) - 1i));
            }
            let _e746 = phi_3909_;
            phi_3915_ = _e746;
            if _e746 {
                let _e748 = slidePos1_[2u];
                phi_3915_ = (_e748 > 0i);
            }
            let _e751 = phi_3915_;
            phi_3925_ = _e751;
            if _e751 {
                let _e753 = slidePos1_[2u];
                let _e755 = tuning.gridDepth;
                phi_3925_ = (_e753 < (bitcast<i32>(_e755) - 1i));
            }
            let _e760 = phi_3925_;
            if _e760 {
                let _e761 = slidePos1_;
                param_509 = _e761;
                let _e762 = getIndex_u0028_vi3_u003b((&param_509));
                param_510 = _e762;
                let _e763 = readCell_u0028_u1_u003b((&param_510));
                param_511 = _e763;
                let _e764 = getType_u0028_u1_u003b((&param_511));
                if (_e764 == 0u) {
                    let _e766 = slidePos1_;
                    param_512 = _e766;
                    let _e767 = getIndex_u0028_vi3_u003b((&param_512));
                    param_513 = 4u;
                    param_514 = 0u;
                    param_515 = 0u;
                    let _e768 = moisture_4;
                    param_516 = _e768;
                    let _e769 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_513), (&param_514), (&param_515), (&param_516));
                    let _e770 = (*currentIndex_9);
                    param_517 = _e770;
                    let _e771 = (*rawValue_7);
                    param_518 = _e771;
                    param_519 = _e767;
                    param_520 = _e769;
                    let _e772 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_517), (&param_518), (&param_519), (&param_520));
                    if _e772 {
                        return;
                    }
                }
            }
            let _e774 = slidePos2_[0u];
            let _e775 = (_e774 > 0i);
            phi_3969_ = _e775;
            if _e775 {
                let _e777 = slidePos2_[0u];
                let _e779 = tuning.gridWidth;
                phi_3969_ = (_e777 < (bitcast<i32>(_e779) - 1i));
            }
            let _e784 = phi_3969_;
            phi_3975_ = _e784;
            if _e784 {
                let _e786 = slidePos2_[2u];
                phi_3975_ = (_e786 > 0i);
            }
            let _e789 = phi_3975_;
            phi_3985_ = _e789;
            if _e789 {
                let _e791 = slidePos2_[2u];
                let _e793 = tuning.gridDepth;
                phi_3985_ = (_e791 < (bitcast<i32>(_e793) - 1i));
            }
            let _e798 = phi_3985_;
            if _e798 {
                let _e799 = slidePos2_;
                param_521 = _e799;
                let _e800 = getIndex_u0028_vi3_u003b((&param_521));
                param_522 = _e800;
                let _e801 = readCell_u0028_u1_u003b((&param_522));
                param_523 = _e801;
                let _e802 = getType_u0028_u1_u003b((&param_523));
                if (_e802 == 0u) {
                    let _e804 = slidePos2_;
                    param_524 = _e804;
                    let _e805 = getIndex_u0028_vi3_u003b((&param_524));
                    param_525 = 4u;
                    param_526 = 0u;
                    param_527 = 0u;
                    let _e806 = moisture_4;
                    param_528 = _e806;
                    let _e807 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_525), (&param_526), (&param_527), (&param_528));
                    let _e808 = (*currentIndex_9);
                    param_529 = _e808;
                    let _e809 = (*rawValue_7);
                    param_530 = _e809;
                    param_531 = _e805;
                    param_532 = _e807;
                    let _e810 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_529), (&param_530), (&param_531), (&param_532));
                    if _e810 {
                        return;
                    }
                }
            }
        }
        let _e812 = (*pos_12)[1u];
        if (_e812 > 1i) {
            let _e814 = (*pos_12);
            belowPos_6 = (_e814 + vec3<i32>(0i, -1i, 0i));
            let _e816 = belowPos_6;
            param_533 = _e816;
            let _e817 = getIndex_u0028_vi3_u003b((&param_533));
            belowIndex_2 = _e817;
            let _e818 = belowIndex_2;
            param_534 = _e818;
            let _e819 = readCell_u0028_u1_u003b((&param_534));
            belowValue_2 = _e819;
            let _e820 = belowValue_2;
            param_535 = _e820;
            let _e821 = getType_u0028_u1_u003b((&param_535));
            if (_e821 == 2u) {
                let _e823 = (*randVal_9);
                startDir_2 = i32((fract((_e823 * 8f)) * 8f));
                i_16 = 0i;
                loop {
                    let _e828 = i_16;
                    if (_e828 < 8i) {
                        let _e830 = startDir_2;
                        let _e831 = i_16;
                        let _e832 = (_e830 + _e831);
                        d_13 = (_e832 - (i32(floor((f32(_e832) / f32(8i)))) * 8i));
                        let _e840 = belowPos_6;
                        let _e841 = d_13;
                        param_536 = _e841;
                        let _e842 = getHDir_u0028_i1_u003b((&param_536));
                        pushPos = (_e840 + _e842);
                        let _e845 = pushPos[0u];
                        let _e846 = (_e845 > 0i);
                        phi_4076_ = _e846;
                        if _e846 {
                            let _e848 = pushPos[0u];
                            let _e850 = tuning.gridWidth;
                            phi_4076_ = (_e848 < (bitcast<i32>(_e850) - 1i));
                        }
                        let _e855 = phi_4076_;
                        phi_4082_ = _e855;
                        if _e855 {
                            let _e857 = pushPos[2u];
                            phi_4082_ = (_e857 > 0i);
                        }
                        let _e860 = phi_4082_;
                        phi_4092_ = _e860;
                        if _e860 {
                            let _e862 = pushPos[2u];
                            let _e864 = tuning.gridDepth;
                            phi_4092_ = (_e862 < (bitcast<i32>(_e864) - 1i));
                        }
                        let _e869 = phi_4092_;
                        if _e869 {
                            param_537 = 4u;
                            param_538 = 0u;
                            param_539 = 0u;
                            let _e870 = moisture_4;
                            param_540 = _e870;
                            let _e871 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_537), (&param_538), (&param_539), (&param_540));
                            let _e872 = pushPos;
                            param_541 = _e872;
                            let _e873 = getIndex_u0028_vi3_u003b((&param_541));
                            let _e874 = (*currentIndex_9);
                            param_542 = _e874;
                            param_543 = _e871;
                            let _e875 = belowIndex_2;
                            param_544 = _e875;
                            let _e876 = belowValue_2;
                            param_545 = _e876;
                            param_546 = _e873;
                            let _e877 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_542), (&param_543), (&param_544), (&param_545), (&param_546));
                            if _e877 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e878 = i_16;
                        i_16 = (_e878 + 1i);
                    }
                }
                param_547 = 4u;
                param_548 = 0u;
                param_549 = 0u;
                let _e880 = moisture_4;
                param_550 = _e880;
                let _e881 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_547), (&param_548), (&param_549), (&param_550));
                let _e882 = (*currentIndex_9);
                param_551 = _e882;
                let _e883 = (*rawValue_7);
                param_552 = _e883;
                let _e884 = belowIndex_2;
                param_553 = _e884;
                param_554 = _e881;
                let _e885 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_551), (&param_552), (&param_553), (&param_554));
                if _e885 {
                    return;
                }
            }
            let _e886 = (*randVal_9);
            dir_3 = select(-1i, 1i, (fract((_e886 * 10f)) > 0.5f));
            let _e891 = (*randVal_9);
            if (fract((_e891 * 100f)) > 0.5f) {
                let _e895 = (*pos_12);
                let _e896 = dir_3;
                slidePos[0i] = (_e895 + vec3<i32>(_e896, -1i, 0i));
                let _e900 = (*pos_12);
                let _e901 = dir_3;
                slidePos[1i] = (_e900 + vec3<i32>(0i, -1i, _e901));
            } else {
                let _e905 = (*pos_12);
                let _e906 = dir_3;
                slidePos[0i] = (_e905 + vec3<i32>(0i, -1i, _e906));
                let _e910 = (*pos_12);
                let _e911 = dir_3;
                slidePos[1i] = (_e910 + vec3<i32>(_e911, -1i, 0i));
            }
            s_1 = 0i;
            loop {
                let _e915 = s_1;
                if (_e915 < 2i) {
                    let _e917 = s_1;
                    let _e919 = slidePos[_e917];
                    sPos_2 = _e919;
                    let _e921 = sPos_2[0u];
                    let _e922 = (_e921 > 0i);
                    phi_4193_ = _e922;
                    if _e922 {
                        let _e924 = sPos_2[0u];
                        let _e926 = tuning.gridWidth;
                        phi_4193_ = (_e924 < (bitcast<i32>(_e926) - 1i));
                    }
                    let _e931 = phi_4193_;
                    phi_4199_ = _e931;
                    if _e931 {
                        let _e933 = sPos_2[2u];
                        phi_4199_ = (_e933 > 0i);
                    }
                    let _e936 = phi_4199_;
                    phi_4209_ = _e936;
                    if _e936 {
                        let _e938 = sPos_2[2u];
                        let _e940 = tuning.gridDepth;
                        phi_4209_ = (_e938 < (bitcast<i32>(_e940) - 1i));
                    }
                    let _e945 = phi_4209_;
                    if _e945 {
                        let _e946 = sPos_2;
                        param_555 = _e946;
                        let _e947 = getIndex_u0028_vi3_u003b((&param_555));
                        sIndex = _e947;
                        let _e948 = sIndex;
                        param_556 = _e948;
                        let _e949 = readCell_u0028_u1_u003b((&param_556));
                        sValue = _e949;
                        let _e950 = sValue;
                        param_557 = _e950;
                        let _e951 = getType_u0028_u1_u003b((&param_557));
                        if (_e951 == 2u) {
                            let _e953 = (*randVal_9);
                            let _e955 = s_1;
                            startDir_3 = i32((fract(((_e953 * 8f) + f32(_e955))) * 8f));
                            i_17 = 0i;
                            loop {
                                let _e961 = i_17;
                                if (_e961 < 8i) {
                                    let _e963 = startDir_3;
                                    let _e964 = i_17;
                                    let _e965 = (_e963 + _e964);
                                    d_14 = (_e965 - (i32(floor((f32(_e965) / f32(8i)))) * 8i));
                                    let _e973 = sPos_2;
                                    let _e974 = d_14;
                                    param_558 = _e974;
                                    let _e975 = getHDir_u0028_i1_u003b((&param_558));
                                    pushPos_1 = (_e973 + _e975);
                                    let _e978 = pushPos_1[0u];
                                    let _e979 = (_e978 > 0i);
                                    phi_4266_ = _e979;
                                    if _e979 {
                                        let _e981 = pushPos_1[0u];
                                        let _e983 = tuning.gridWidth;
                                        phi_4266_ = (_e981 < (bitcast<i32>(_e983) - 1i));
                                    }
                                    let _e988 = phi_4266_;
                                    phi_4272_ = _e988;
                                    if _e988 {
                                        let _e990 = pushPos_1[2u];
                                        phi_4272_ = (_e990 > 0i);
                                    }
                                    let _e993 = phi_4272_;
                                    phi_4282_ = _e993;
                                    if _e993 {
                                        let _e995 = pushPos_1[2u];
                                        let _e997 = tuning.gridDepth;
                                        phi_4282_ = (_e995 < (bitcast<i32>(_e997) - 1i));
                                    }
                                    let _e1002 = phi_4282_;
                                    if _e1002 {
                                        param_559 = 4u;
                                        param_560 = 0u;
                                        param_561 = 0u;
                                        let _e1003 = moisture_4;
                                        param_562 = _e1003;
                                        let _e1004 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_559), (&param_560), (&param_561), (&param_562));
                                        let _e1005 = pushPos_1;
                                        param_563 = _e1005;
                                        let _e1006 = getIndex_u0028_vi3_u003b((&param_563));
                                        let _e1007 = (*currentIndex_9);
                                        param_564 = _e1007;
                                        param_565 = _e1004;
                                        let _e1008 = sIndex;
                                        param_566 = _e1008;
                                        let _e1009 = sValue;
                                        param_567 = _e1009;
                                        param_568 = _e1006;
                                        let _e1010 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_564), (&param_565), (&param_566), (&param_567), (&param_568));
                                        if _e1010 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1011 = i_17;
                                    i_17 = (_e1011 + 1i);
                                }
                            }
                            param_569 = 4u;
                            param_570 = 0u;
                            param_571 = 0u;
                            let _e1013 = moisture_4;
                            param_572 = _e1013;
                            let _e1014 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_569), (&param_570), (&param_571), (&param_572));
                            let _e1015 = (*currentIndex_9);
                            param_573 = _e1015;
                            let _e1016 = (*rawValue_7);
                            param_574 = _e1016;
                            let _e1017 = sIndex;
                            param_575 = _e1017;
                            param_576 = _e1014;
                            let _e1018 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_573), (&param_574), (&param_575), (&param_576));
                            if _e1018 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1019 = s_1;
                    s_1 = (_e1019 + 1i);
                }
            }
        }
    }
    let _e1021 = (*currentDir_4);
    floraState = _e1021;
    let _e1022 = isClumped;
    phi_4337_ = _e1022;
    if !(_e1022) {
        let _e1024 = (*currentSleep_4);
        let _e1026 = tuning.wakeSleepThreshold;
        phi_4337_ = (_e1024 > _e1026);
    }
    let _e1029 = phi_4337_;
    if _e1029 {
        let _e1030 = (*pos_12);
        abovePos_1 = (_e1030 + vec3<i32>(0i, 1i, 0i));
        let _e1033 = abovePos_1[1u];
        let _e1035 = tuning.gridHeight;
        aboveInside = (_e1033 < (bitcast<i32>(_e1035) - 1i));
        let _e1039 = abovePos_1;
        param_577 = _e1039;
        let _e1040 = getIndex_u0028_vi3_u003b((&param_577));
        aboveIndex = _e1040;
        let _e1041 = aboveInside;
        if _e1041 {
            let _e1042 = aboveIndex;
            param_578 = _e1042;
            let _e1043 = readCell_u0028_u1_u003b((&param_578));
            param_579 = _e1043;
            let _e1044 = getType_u0028_u1_u003b((&param_579));
            local_21 = _e1044;
        } else {
            local_21 = 0u;
        }
        let _e1045 = local_21;
        aboveType = _e1045;
        let _e1046 = aboveType;
        let _e1048 = aboveType;
        if ((_e1046 == 0u) || (_e1048 == 18u)) {
            let _e1051 = moisture_4;
            let _e1053 = floraState;
            if ((_e1051 >= 5u) && (_e1053 < 100u)) {
                let _e1056 = (*randVal_9);
                let _e1060 = tuning.grassGrowChance;
                if (fract((_e1056 * 55f)) < _e1060) {
                    let _e1062 = floraState;
                    floraState = (_e1062 + bitcast<u32>(1i));
                    let _e1065 = floraState;
                    let _e1067 = aboveType;
                    let _e1070 = aboveInside;
                    let _e1071 = (((_e1065 == 100u) && (_e1067 == 0u)) && _e1070);
                    phi_4411_ = _e1071;
                    if _e1071 {
                        let _e1072 = (*randVal_9);
                        let _e1076 = tuning.treeBloomChance;
                        phi_4411_ = (fract((_e1072 * 97f)) < _e1076);
                    }
                    let _e1079 = phi_4411_;
                    if _e1079 {
                        let _e1080 = aboveIndex;
                        param_580 = 18u;
                        param_581 = 0u;
                        param_582 = 0u;
                        param_583 = 0u;
                        let _e1083 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_580), (&param_581), (&param_582), (&param_583));
                        let _e1084 = atomicCompareExchangeWeak((&unnamed.grid[_e1080]), 0u, _e1083);
                    }
                }
            }
            let _e1086 = floraState;
            if (_e1086 > 100u) {
                floraState = 100u;
            }
        } else {
            let _e1088 = aboveType;
            if (_e1088 == 2u) {
                let _e1090 = floraState;
                if (_e1090 > 0u) {
                    let _e1092 = floraState;
                    if (_e1092 <= 100u) {
                        floraState = 101u;
                    }
                    let _e1094 = (*randVal_9);
                    let _e1098 = tuning.grassSubmergedDecayChance;
                    if (fract((_e1094 * 66f)) < _e1098) {
                        let _e1100 = floraState;
                        floraState = (_e1100 + bitcast<u32>(1i));
                    }
                    let _e1103 = floraState;
                    if (_e1103 >= 200u) {
                        floraState = 0u;
                    }
                }
            } else {
                let _e1105 = aboveType;
                let _e1106 = (_e1105 != 5u);
                phi_4466_ = _e1106;
                if _e1106 {
                    let _e1107 = aboveType;
                    param_584 = _e1107;
                    let _e1108 = isLocust_u0028_u1_u003b((&param_584));
                    phi_4466_ = !(_e1108);
                }
                let _e1111 = phi_4466_;
                if _e1111 {
                    floraState = 0u;
                }
            }
        }
    }
    let _e1112 = (*currentSleep_4);
    newSleep_2 = min((_e1112 + 1u), 255u);
    let _e1115 = (*currentIndex_9);
    let _e1118 = (*rawValue_7);
    param_585 = 4u;
    let _e1119 = floraState;
    param_586 = _e1119;
    let _e1120 = newSleep_2;
    param_587 = _e1120;
    let _e1121 = moisture_4;
    param_588 = _e1121;
    let _e1122 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_585), (&param_586), (&param_587), (&param_588));
    let _e1123 = atomicCompareExchangeWeak((&unnamed.grid[_e1115]), _e1118, _e1122);
    return;
}

fn updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_13: ptr<function, vec3<i32>>, currentIndex_10: ptr<function, u32>, rawValue_8: ptr<function, u32>, currentDir_5: ptr<function, u32>, currentSleep_5: ptr<function, u32>, currentAge_8: ptr<function, u32>, randVal_10: ptr<function, f32>) {
    var wake: bool;
    var param_589: vec3<i32>;
    var param_590: u32;
    var param_591: u32;
    var hasPressure_1: bool;
    var local_22: bool;
    var param_592: vec3<i32>;
    var param_593: u32;
    var param_594: u32;
    var isStackedOnWater: bool;
    var local_23: bool;
    var param_595: vec3<i32>;
    var param_596: u32;
    var param_597: u32;
    var d_15: i32;
    var nPos_6: vec3<i32>;
    var param_598: i32;
    var param_599: vec3<i32>;
    var param_600: u32;
    var param_601: u32;
    var belowNeighbor: u32;
    var param_602: vec3<i32>;
    var param_603: u32;
    var param_604: u32;
    var newAge_2: u32;
    var belowPos_7: vec3<i32>;
    var param_605: vec3<i32>;
    var param_606: u32;
    var param_607: u32;
    var param_608: vec3<i32>;
    var param_609: u32;
    var param_610: u32;
    var param_611: u32;
    var param_612: u32;
    var param_613: u32;
    var param_614: u32;
    var param_615: u32;
    var param_616: u32;
    var newDir: u32;
    var r_1: f32;
    var diagDir: u32;
    var r_2: f32;
    var stepPos: vec3<i32>;
    var param_617: i32;
    var param_618: vec3<i32>;
    var param_619: u32;
    var param_620: u32;
    var newValue_1: u32;
    var param_621: u32;
    var param_622: u32;
    var param_623: u32;
    var param_624: u32;
    var param_625: vec3<i32>;
    var param_626: u32;
    var param_627: u32;
    var param_628: u32;
    var param_629: u32;
    var bestDropPos: vec3<i32>;
    var foundDrop: bool;
    var blockedMask_1: u32;
    var startDir_4: i32;
    var waterReach: i32;
    var r_3: i32;
    var i_18: i32;
    var d_16: i32;
    var c_7: vec3<i32>;
    var param_630: i32;
    var param_631: vec3<i32>;
    var param_632: u32;
    var param_633: u32;
    var param_634: vec3<i32>;
    var param_635: u32;
    var param_636: u32;
    var newValue_2: u32;
    var param_637: u32;
    var param_638: u32;
    var param_639: u32;
    var param_640: u32;
    var param_641: vec3<i32>;
    var param_642: u32;
    var param_643: u32;
    var param_644: u32;
    var param_645: u32;
    var hasPressure_2: bool;
    var local_24: bool;
    var param_646: vec3<i32>;
    var param_647: u32;
    var param_648: u32;
    var isStackedOnWater_1: bool;
    var local_25: bool;
    var param_649: vec3<i32>;
    var param_650: u32;
    var param_651: u32;
    var canStepOntoPool: bool;
    var d_17: i32;
    var nPos_7: vec3<i32>;
    var param_652: i32;
    var param_653: vec3<i32>;
    var param_654: u32;
    var param_655: u32;
    var param_656: vec3<i32>;
    var param_657: u32;
    var param_658: u32;
    var startSpreadDir: i32;
    var i_19: i32;
    var d_18: i32;
    var targetPos_2: vec3<i32>;
    var param_659: i32;
    var param_660: vec3<i32>;
    var param_661: u32;
    var param_662: u32;
    var newValue_3: u32;
    var param_663: u32;
    var param_664: u32;
    var param_665: u32;
    var param_666: u32;
    var param_667: vec3<i32>;
    var param_668: u32;
    var param_669: u32;
    var param_670: u32;
    var param_671: u32;
    var newSleep_3: u32;
    var sleepValue: u32;
    var param_672: u32;
    var param_673: u32;
    var param_674: u32;
    var param_675: u32;
    var phi_4506_: bool;
    var phi_4576_: bool;
    var phi_4582_: bool;
    var phi_4592_: bool;
    var phi_4778_: bool;
    var phi_4784_: bool;
    var phi_4794_: bool;
    var phi_4909_: bool;
    var phi_4916_: bool;
    var phi_4927_: bool;
    var phi_4939_: bool;
    var phi_4961_: bool;
    var phi_5065_: bool;
    var phi_5071_: bool;
    var phi_5081_: bool;
    var phi_5097_: bool;
    var phi_5109_: bool;
    var phi_5159_: bool;
    var phi_5165_: bool;
    var phi_5175_: bool;

    let _e332 = (*currentSleep_5);
    let _e334 = tuning.wakeSleepThreshold;
    if (_e332 > _e334) {
        wake = false;
        let _e337 = (*pos_13)[1u];
        let _e338 = (_e337 > 1i);
        phi_4506_ = _e338;
        if _e338 {
            let _e339 = (*pos_13);
            param_589 = (_e339 + vec3<i32>(0i, -1i, 0i));
            let _e341 = getIndex_u0028_vi3_u003b((&param_589));
            param_590 = _e341;
            let _e342 = readCell_u0028_u1_u003b((&param_590));
            param_591 = _e342;
            let _e343 = getType_u0028_u1_u003b((&param_591));
            phi_4506_ = (_e343 == 0u);
        }
        let _e346 = phi_4506_;
        if _e346 {
            wake = true;
        } else {
            let _e348 = (*pos_13)[1u];
            let _e350 = tuning.gridHeight;
            if (_e348 < (bitcast<i32>(_e350) - 2i)) {
                let _e354 = (*pos_13);
                param_592 = (_e354 + vec3<i32>(0i, 1i, 0i));
                let _e356 = getIndex_u0028_vi3_u003b((&param_592));
                param_593 = _e356;
                let _e357 = readCell_u0028_u1_u003b((&param_593));
                param_594 = _e357;
                let _e358 = getType_u0028_u1_u003b((&param_594));
                local_22 = (_e358 != 0u);
            } else {
                local_22 = false;
            }
            let _e360 = local_22;
            hasPressure_1 = _e360;
            let _e362 = (*pos_13)[1u];
            if (_e362 > 1i) {
                let _e364 = (*pos_13);
                param_595 = (_e364 + vec3<i32>(0i, -1i, 0i));
                let _e366 = getIndex_u0028_vi3_u003b((&param_595));
                param_596 = _e366;
                let _e367 = readCell_u0028_u1_u003b((&param_596));
                param_597 = _e367;
                let _e368 = getType_u0028_u1_u003b((&param_597));
                local_23 = (_e368 == 2u);
            } else {
                local_23 = false;
            }
            let _e370 = local_23;
            isStackedOnWater = _e370;
            d_15 = 0i;
            loop {
                let _e371 = d_15;
                if (_e371 < 8i) {
                    let _e373 = (*pos_13);
                    let _e374 = d_15;
                    param_598 = _e374;
                    let _e375 = getHDir_u0028_i1_u003b((&param_598));
                    nPos_6 = (_e373 + _e375);
                    let _e378 = nPos_6[0u];
                    let _e379 = (_e378 > 0i);
                    phi_4576_ = _e379;
                    if _e379 {
                        let _e381 = nPos_6[0u];
                        let _e383 = tuning.gridWidth;
                        phi_4576_ = (_e381 < (bitcast<i32>(_e383) - 1i));
                    }
                    let _e388 = phi_4576_;
                    phi_4582_ = _e388;
                    if _e388 {
                        let _e390 = nPos_6[2u];
                        phi_4582_ = (_e390 > 0i);
                    }
                    let _e393 = phi_4582_;
                    phi_4592_ = _e393;
                    if _e393 {
                        let _e395 = nPos_6[2u];
                        let _e397 = tuning.gridDepth;
                        phi_4592_ = (_e395 < (bitcast<i32>(_e397) - 1i));
                    }
                    let _e402 = phi_4592_;
                    if _e402 {
                        let _e403 = nPos_6;
                        param_599 = _e403;
                        let _e404 = getIndex_u0028_vi3_u003b((&param_599));
                        param_600 = _e404;
                        let _e405 = readCell_u0028_u1_u003b((&param_600));
                        param_601 = _e405;
                        let _e406 = getType_u0028_u1_u003b((&param_601));
                        if (_e406 == 0u) {
                            let _e408 = nPos_6;
                            param_602 = (_e408 + vec3<i32>(0i, -1i, 0i));
                            let _e410 = getIndex_u0028_vi3_u003b((&param_602));
                            param_603 = _e410;
                            let _e411 = readCell_u0028_u1_u003b((&param_603));
                            param_604 = _e411;
                            let _e412 = getType_u0028_u1_u003b((&param_604));
                            belowNeighbor = _e412;
                            let _e413 = belowNeighbor;
                            let _e415 = hasPressure_1;
                            let _e417 = isStackedOnWater;
                            let _e419 = belowNeighbor;
                            if ((((_e413 == 0u) || _e415) || _e417) || (_e419 == 2u)) {
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
                    let _e422 = d_15;
                    d_15 = (_e422 + 1i);
                }
            }
        }
        let _e424 = wake;
        if !(_e424) {
            return;
        }
        (*currentSleep_5) = 0u;
        (*currentAge_8) = 0u;
    }
    let _e426 = (*currentAge_8);
    newAge_2 = (_e426 + 1u);
    let _e429 = (*pos_13)[1u];
    if (_e429 > 1i) {
        let _e431 = (*pos_13);
        belowPos_7 = (_e431 + vec3<i32>(0i, -1i, 0i));
        let _e433 = belowPos_7;
        param_605 = _e433;
        let _e434 = getIndex_u0028_vi3_u003b((&param_605));
        param_606 = _e434;
        let _e435 = readCell_u0028_u1_u003b((&param_606));
        param_607 = _e435;
        let _e436 = getType_u0028_u1_u003b((&param_607));
        if (_e436 == 0u) {
            let _e438 = belowPos_7;
            param_608 = _e438;
            let _e439 = getIndex_u0028_vi3_u003b((&param_608));
            param_609 = 2u;
            param_610 = 0u;
            param_611 = 0u;
            let _e440 = newAge_2;
            param_612 = _e440;
            let _e441 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_609), (&param_610), (&param_611), (&param_612));
            let _e442 = (*currentIndex_10);
            param_613 = _e442;
            let _e443 = (*rawValue_8);
            param_614 = _e443;
            param_615 = _e439;
            param_616 = _e441;
            let _e444 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_613), (&param_614), (&param_615), (&param_616));
            if _e444 {
                return;
            }
        }
    }
    let _e445 = (*currentDir_5);
    newDir = _e445;
    let _e446 = newDir;
    let _e448 = newDir;
    if ((_e446 == 0u) || (_e448 == 9u)) {
        let _e451 = (*randVal_10);
        r_1 = fract((_e451 * 77f));
        let _e454 = r_1;
        if (_e454 < 0.25f) {
            newDir = 1u;
        } else {
            let _e456 = r_1;
            if (_e456 < 0.5f) {
                newDir = 2u;
            } else {
                let _e458 = r_1;
                if (_e458 < 0.75f) {
                    newDir = 3u;
                } else {
                    newDir = 4u;
                }
            }
        }
    }
    let _e460 = newAge_2;
    let _e463 = newAge_2;
    if (((_e460 % 3u) == 0u) && (_e463 > 0u)) {
        let _e466 = newDir;
        diagDir = _e466;
        let _e467 = diagDir;
        let _e469 = diagDir;
        if ((_e467 >= 1u) && (_e469 <= 4u)) {
            let _e472 = (*randVal_10);
            r_2 = fract((_e472 * 133f));
            let _e475 = diagDir;
            if (_e475 == 1u) {
                let _e477 = r_2;
                diagDir = select(6u, 5u, (_e477 > 0.5f));
            } else {
                let _e480 = diagDir;
                if (_e480 == 2u) {
                    let _e482 = r_2;
                    diagDir = select(8u, 7u, (_e482 > 0.5f));
                } else {
                    let _e485 = diagDir;
                    if (_e485 == 3u) {
                        let _e487 = r_2;
                        diagDir = select(7u, 5u, (_e487 > 0.5f));
                    } else {
                        let _e490 = diagDir;
                        if (_e490 == 4u) {
                            let _e492 = r_2;
                            diagDir = select(8u, 6u, (_e492 > 0.5f));
                        }
                    }
                }
            }
        }
        let _e495 = (*pos_13);
        let _e496 = diagDir;
        param_617 = (bitcast<i32>(_e496) - 1i);
        let _e499 = getHDir_u0028_i1_u003b((&param_617));
        stepPos = (_e495 + _e499);
        let _e502 = stepPos[0u];
        let _e503 = (_e502 > 0i);
        phi_4778_ = _e503;
        if _e503 {
            let _e505 = stepPos[0u];
            let _e507 = tuning.gridWidth;
            phi_4778_ = (_e505 < (bitcast<i32>(_e507) - 1i));
        }
        let _e512 = phi_4778_;
        phi_4784_ = _e512;
        if _e512 {
            let _e514 = stepPos[2u];
            phi_4784_ = (_e514 > 0i);
        }
        let _e517 = phi_4784_;
        phi_4794_ = _e517;
        if _e517 {
            let _e519 = stepPos[2u];
            let _e521 = tuning.gridDepth;
            phi_4794_ = (_e519 < (bitcast<i32>(_e521) - 1i));
        }
        let _e526 = phi_4794_;
        if _e526 {
            let _e527 = stepPos;
            param_618 = _e527;
            let _e528 = getIndex_u0028_vi3_u003b((&param_618));
            param_619 = _e528;
            let _e529 = readCell_u0028_u1_u003b((&param_619));
            param_620 = _e529;
            let _e530 = getType_u0028_u1_u003b((&param_620));
            if (_e530 == 0u) {
                param_621 = 2u;
                let _e532 = newDir;
                param_622 = _e532;
                param_623 = 0u;
                let _e533 = newAge_2;
                param_624 = _e533;
                let _e534 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_621), (&param_622), (&param_623), (&param_624));
                newValue_1 = _e534;
                let _e535 = stepPos;
                param_625 = _e535;
                let _e536 = getIndex_u0028_vi3_u003b((&param_625));
                let _e537 = (*currentIndex_10);
                param_626 = _e537;
                let _e538 = (*rawValue_8);
                param_627 = _e538;
                param_628 = _e536;
                let _e539 = newValue_1;
                param_629 = _e539;
                let _e540 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_626), (&param_627), (&param_628), (&param_629));
                if _e540 {
                    return;
                }
            }
        }
    }
    let _e541 = (*pos_13);
    bestDropPos = _e541;
    foundDrop = false;
    blockedMask_1 = 0u;
    let _e542 = (*randVal_10);
    startDir_4 = i32((fract((_e542 * 8f)) * 8f));
    let _e548 = tuning.waterSpreadRadius;
    let _e550 = tuning.gridWidth;
    let _e553 = tuning.gridHeight;
    waterReach = bitcast<i32>(clamp(_e548, 1u, bitcast<u32>(max(bitcast<i32>(_e550), bitcast<i32>(_e553)))));
    r_3 = 1i;
    loop {
        let _e559 = r_3;
        let _e560 = waterReach;
        if (_e559 <= _e560) {
            let _e562 = blockedMask_1;
            if (_e562 == 255u) {
                break;
            }
            i_18 = 0i;
            loop {
                let _e564 = i_18;
                if (_e564 < 8i) {
                    let _e566 = startDir_4;
                    let _e567 = i_18;
                    let _e568 = (_e566 + _e567);
                    d_16 = (_e568 - (i32(floor((f32(_e568) / f32(8i)))) * 8i));
                    let _e576 = blockedMask_1;
                    let _e577 = d_16;
                    if ((_e576 & (1u << bitcast<u32>(_e577))) == 0u) {
                        let _e582 = (*pos_13);
                        let _e583 = d_16;
                        param_630 = _e583;
                        let _e584 = getHDir_u0028_i1_u003b((&param_630));
                        let _e585 = r_3;
                        c_7 = (_e582 + (_e584 * vec3(_e585)));
                        let _e590 = c_7[0u];
                        let _e591 = (_e590 <= 0i);
                        phi_4909_ = _e591;
                        if !(_e591) {
                            let _e594 = c_7[0u];
                            let _e596 = tuning.gridWidth;
                            phi_4909_ = (_e594 >= (bitcast<i32>(_e596) - 1i));
                        }
                        let _e601 = phi_4909_;
                        phi_4916_ = _e601;
                        if !(_e601) {
                            let _e604 = c_7[2u];
                            phi_4916_ = (_e604 <= 0i);
                        }
                        let _e607 = phi_4916_;
                        phi_4927_ = _e607;
                        if !(_e607) {
                            let _e610 = c_7[2u];
                            let _e612 = tuning.gridDepth;
                            phi_4927_ = (_e610 >= (bitcast<i32>(_e612) - 1i));
                        }
                        let _e617 = phi_4927_;
                        phi_4939_ = _e617;
                        if !(_e617) {
                            let _e619 = c_7;
                            param_631 = _e619;
                            let _e620 = getIndex_u0028_vi3_u003b((&param_631));
                            param_632 = _e620;
                            let _e621 = readCell_u0028_u1_u003b((&param_632));
                            param_633 = _e621;
                            let _e622 = getType_u0028_u1_u003b((&param_633));
                            phi_4939_ = (_e622 != 0u);
                        }
                        let _e625 = phi_4939_;
                        if _e625 {
                            let _e626 = d_16;
                            let _e629 = blockedMask_1;
                            blockedMask_1 = (_e629 | (1u << bitcast<u32>(_e626)));
                        } else {
                            let _e632 = c_7[1u];
                            let _e633 = (_e632 > 1i);
                            phi_4961_ = _e633;
                            if _e633 {
                                let _e634 = c_7;
                                param_634 = (_e634 + vec3<i32>(0i, -1i, 0i));
                                let _e636 = getIndex_u0028_vi3_u003b((&param_634));
                                param_635 = _e636;
                                let _e637 = readCell_u0028_u1_u003b((&param_635));
                                param_636 = _e637;
                                let _e638 = getType_u0028_u1_u003b((&param_636));
                                phi_4961_ = (_e638 == 0u);
                            }
                            let _e641 = phi_4961_;
                            if _e641 {
                                let _e642 = c_7;
                                bestDropPos = _e642;
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
                    let _e643 = i_18;
                    i_18 = (_e643 + 1i);
                }
            }
            let _e645 = foundDrop;
            if _e645 {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e646 = r_3;
            r_3 = (_e646 + 1i);
        }
    }
    let _e648 = foundDrop;
    if _e648 {
        param_637 = 2u;
        param_638 = 0u;
        param_639 = 0u;
        param_640 = 0u;
        let _e649 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_637), (&param_638), (&param_639), (&param_640));
        newValue_2 = _e649;
        let _e650 = bestDropPos;
        param_641 = _e650;
        let _e651 = getIndex_u0028_vi3_u003b((&param_641));
        let _e652 = (*currentIndex_10);
        param_642 = _e652;
        let _e653 = (*rawValue_8);
        param_643 = _e653;
        param_644 = _e651;
        let _e654 = newValue_2;
        param_645 = _e654;
        let _e655 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_642), (&param_643), (&param_644), (&param_645));
        if _e655 {
            return;
        }
    } else {
        let _e657 = (*pos_13)[1u];
        let _e659 = tuning.gridHeight;
        if (_e657 < (bitcast<i32>(_e659) - 2i)) {
            let _e663 = (*pos_13);
            param_646 = (_e663 + vec3<i32>(0i, 1i, 0i));
            let _e665 = getIndex_u0028_vi3_u003b((&param_646));
            param_647 = _e665;
            let _e666 = readCell_u0028_u1_u003b((&param_647));
            param_648 = _e666;
            let _e667 = getType_u0028_u1_u003b((&param_648));
            local_24 = (_e667 != 0u);
        } else {
            local_24 = false;
        }
        let _e669 = local_24;
        hasPressure_2 = _e669;
        let _e671 = (*pos_13)[1u];
        if (_e671 > 1i) {
            let _e673 = (*pos_13);
            param_649 = (_e673 + vec3<i32>(0i, -1i, 0i));
            let _e675 = getIndex_u0028_vi3_u003b((&param_649));
            param_650 = _e675;
            let _e676 = readCell_u0028_u1_u003b((&param_650));
            param_651 = _e676;
            let _e677 = getType_u0028_u1_u003b((&param_651));
            local_25 = (_e677 == 2u);
        } else {
            local_25 = false;
        }
        let _e679 = local_25;
        isStackedOnWater_1 = _e679;
        canStepOntoPool = false;
        d_17 = 0i;
        loop {
            let _e680 = d_17;
            if (_e680 < 8i) {
                let _e682 = (*pos_13);
                let _e683 = d_17;
                param_652 = _e683;
                let _e684 = getHDir_u0028_i1_u003b((&param_652));
                nPos_7 = (_e682 + _e684);
                let _e687 = nPos_7[0u];
                let _e688 = (_e687 > 0i);
                phi_5065_ = _e688;
                if _e688 {
                    let _e690 = nPos_7[0u];
                    let _e692 = tuning.gridWidth;
                    phi_5065_ = (_e690 < (bitcast<i32>(_e692) - 1i));
                }
                let _e697 = phi_5065_;
                phi_5071_ = _e697;
                if _e697 {
                    let _e699 = nPos_7[2u];
                    phi_5071_ = (_e699 > 0i);
                }
                let _e702 = phi_5071_;
                phi_5081_ = _e702;
                if _e702 {
                    let _e704 = nPos_7[2u];
                    let _e706 = tuning.gridDepth;
                    phi_5081_ = (_e704 < (bitcast<i32>(_e706) - 1i));
                }
                let _e711 = phi_5081_;
                if _e711 {
                    let _e712 = nPos_7;
                    param_653 = _e712;
                    let _e713 = getIndex_u0028_vi3_u003b((&param_653));
                    param_654 = _e713;
                    let _e714 = readCell_u0028_u1_u003b((&param_654));
                    param_655 = _e714;
                    let _e715 = getType_u0028_u1_u003b((&param_655));
                    let _e716 = (_e715 == 0u);
                    phi_5097_ = _e716;
                    if _e716 {
                        let _e718 = (*pos_13)[1u];
                        phi_5097_ = (_e718 > 1i);
                    }
                    let _e721 = phi_5097_;
                    phi_5109_ = _e721;
                    if _e721 {
                        let _e722 = nPos_7;
                        param_656 = (_e722 + vec3<i32>(0i, -1i, 0i));
                        let _e724 = getIndex_u0028_vi3_u003b((&param_656));
                        param_657 = _e724;
                        let _e725 = readCell_u0028_u1_u003b((&param_657));
                        param_658 = _e725;
                        let _e726 = getType_u0028_u1_u003b((&param_658));
                        phi_5109_ = (_e726 == 2u);
                    }
                    let _e729 = phi_5109_;
                    if _e729 {
                        canStepOntoPool = true;
                        break;
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e730 = d_17;
                d_17 = (_e730 + 1i);
            }
        }
        let _e732 = hasPressure_2;
        let _e733 = isStackedOnWater_1;
        let _e735 = canStepOntoPool;
        if ((_e732 || _e733) || _e735) {
            let _e737 = (*randVal_10);
            startSpreadDir = i32((fract((_e737 * 8f)) * 8f));
            i_19 = 0i;
            loop {
                let _e742 = i_19;
                if (_e742 < 8i) {
                    let _e744 = startSpreadDir;
                    let _e745 = i_19;
                    let _e746 = (_e744 + _e745);
                    d_18 = (_e746 - (i32(floor((f32(_e746) / f32(8i)))) * 8i));
                    let _e754 = (*pos_13);
                    let _e755 = d_18;
                    param_659 = _e755;
                    let _e756 = getHDir_u0028_i1_u003b((&param_659));
                    targetPos_2 = (_e754 + _e756);
                    let _e759 = targetPos_2[0u];
                    let _e760 = (_e759 > 0i);
                    phi_5159_ = _e760;
                    if _e760 {
                        let _e762 = targetPos_2[0u];
                        let _e764 = tuning.gridWidth;
                        phi_5159_ = (_e762 < (bitcast<i32>(_e764) - 1i));
                    }
                    let _e769 = phi_5159_;
                    phi_5165_ = _e769;
                    if _e769 {
                        let _e771 = targetPos_2[2u];
                        phi_5165_ = (_e771 > 0i);
                    }
                    let _e774 = phi_5165_;
                    phi_5175_ = _e774;
                    if _e774 {
                        let _e776 = targetPos_2[2u];
                        let _e778 = tuning.gridDepth;
                        phi_5175_ = (_e776 < (bitcast<i32>(_e778) - 1i));
                    }
                    let _e783 = phi_5175_;
                    if _e783 {
                        let _e784 = targetPos_2;
                        param_660 = _e784;
                        let _e785 = getIndex_u0028_vi3_u003b((&param_660));
                        param_661 = _e785;
                        let _e786 = readCell_u0028_u1_u003b((&param_661));
                        param_662 = _e786;
                        let _e787 = getType_u0028_u1_u003b((&param_662));
                        if (_e787 == 0u) {
                            let _e789 = d_18;
                            param_663 = 2u;
                            param_664 = bitcast<u32>((_e789 + 1i));
                            param_665 = 0u;
                            let _e792 = newAge_2;
                            param_666 = _e792;
                            let _e793 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_663), (&param_664), (&param_665), (&param_666));
                            newValue_3 = _e793;
                            let _e794 = targetPos_2;
                            param_667 = _e794;
                            let _e795 = getIndex_u0028_vi3_u003b((&param_667));
                            let _e796 = (*currentIndex_10);
                            param_668 = _e796;
                            let _e797 = (*rawValue_8);
                            param_669 = _e797;
                            param_670 = _e795;
                            let _e798 = newValue_3;
                            param_671 = _e798;
                            let _e799 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_668), (&param_669), (&param_670), (&param_671));
                            if _e799 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e800 = i_19;
                    i_19 = (_e800 + 1i);
                }
            }
        }
    }
    let _e802 = (*currentSleep_5);
    newSleep_3 = min((_e802 + 1u), 255u);
    param_672 = 2u;
    param_673 = 0u;
    let _e805 = newSleep_3;
    param_674 = _e805;
    let _e806 = newAge_2;
    param_675 = _e806;
    let _e807 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_672), (&param_673), (&param_674), (&param_675));
    sleepValue = _e807;
    let _e808 = (*currentIndex_10);
    let _e811 = (*rawValue_8);
    let _e812 = sleepValue;
    let _e813 = atomicCompareExchangeWeak((&unnamed.grid[_e808]), _e811, _e812);
    return;
}

fn incWater_u0028_() {
    let _e199 = atomicAdd((&unnamed_1.waterVoxelCount), 1u);
    return;
}

fn updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_14: ptr<function, vec3<i32>>, currentIndex_11: ptr<function, u32>, rawValue_9: ptr<function, u32>, currentSleep_6: ptr<function, u32>, currentAge_9: ptr<function, u32>, randVal_11: ptr<function, f32>) {
    var moisture_5: u32;
    var moistureModified_1: bool;
    var startDir_5: i32;
    var i_20: i32;
    var d_19: i32;
    var nPos_8: vec3<i32>;
    var param_676: i32;
    var nIndex_5: u32;
    var param_677: vec3<i32>;
    var nVal_5: u32;
    var param_678: u32;
    var param_679: u32;
    var d_20: i32;
    var nPos_9: vec3<i32>;
    var param_680: i32;
    var nIndex_6: u32;
    var param_681: vec3<i32>;
    var nVal_6: u32;
    var param_682: u32;
    var nType_3: u32;
    var param_683: u32;
    var nMoisture_1: u32;
    var param_684: u32;
    var nCapacity_1: u32;
    var local_26: u32;
    var leakPos: vec3<i32>;
    var param_685: vec3<i32>;
    var param_686: u32;
    var param_687: u32;
    var param_688: vec3<i32>;
    var param_689: u32;
    var param_690: u32;
    var param_691: u32;
    var param_692: u32;
    var canMove_1: bool;
    var param_693: vec3<i32>;
    var isClumped_1: bool;
    var emptyBelowCount_1: i32;
    var x_2: i32;
    var z_2: i32;
    var checkPos_2: vec3<i32>;
    var param_694: vec3<i32>;
    var param_695: u32;
    var param_696: u32;
    var clumpCount_1: i32;
    var x_3: i32;
    var y_1: i32;
    var z_3: i32;
    var nPos_10: vec3<i32>;
    var param_697: vec3<i32>;
    var param_698: u32;
    var param_699: u32;
    var belowPos_8: vec3<i32>;
    var param_700: vec3<i32>;
    var param_701: u32;
    var param_702: u32;
    var param_703: vec3<i32>;
    var param_704: u32;
    var param_705: u32;
    var param_706: u32;
    var param_707: u32;
    var param_708: u32;
    var param_709: u32;
    var param_710: u32;
    var param_711: u32;
    var dir_4: i32;
    var slidePos1_1: vec3<i32>;
    var slidePos2_1: vec3<i32>;
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
    var belowPos_9: vec3<i32>;
    var belowIndex_3: u32;
    var param_736: vec3<i32>;
    var belowValue_3: u32;
    var param_737: u32;
    var param_738: u32;
    var startDir_6: i32;
    var i_21: i32;
    var d_21: i32;
    var pushPos_2: vec3<i32>;
    var param_739: i32;
    var param_740: u32;
    var param_741: u32;
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
    var param_753: u32;
    var param_754: u32;
    var param_755: u32;
    var param_756: u32;
    var param_757: u32;
    var dir_5: i32;
    var slidePos_1: array<vec3<i32>, 2>;
    var s_2: i32;
    var sPos_3: vec3<i32>;
    var sIndex_1: u32;
    var param_758: vec3<i32>;
    var sValue_1: u32;
    var param_759: u32;
    var param_760: u32;
    var startDir_7: i32;
    var i_22: i32;
    var d_22: i32;
    var pushPos_3: vec3<i32>;
    var param_761: i32;
    var param_762: u32;
    var param_763: u32;
    var param_764: u32;
    var param_765: u32;
    var param_766: vec3<i32>;
    var param_767: u32;
    var param_768: u32;
    var param_769: u32;
    var param_770: u32;
    var param_771: u32;
    var param_772: u32;
    var param_773: u32;
    var param_774: u32;
    var param_775: u32;
    var param_776: u32;
    var param_777: u32;
    var param_778: u32;
    var param_779: u32;
    var newSleep_4: u32;
    var param_780: u32;
    var param_781: u32;
    var param_782: u32;
    var param_783: u32;
    var phi_2386_: bool;
    var phi_2392_: bool;
    var phi_2402_: bool;
    var phi_2408_: bool;
    var phi_2418_: bool;
    var phi_2490_: bool;
    var phi_2496_: bool;
    var phi_2506_: bool;
    var phi_2512_: bool;
    var phi_2522_: bool;
    var phi_2587_: bool;
    var phi_2606_: bool;
    var phi_2649_: bool;
    var phi_2691_: bool;
    var phi_2697_: bool;
    var phi_2706_: bool;
    var phi_2788_: bool;
    var phi_2794_: bool;
    var phi_2803_: bool;
    var phi_2809_: bool;
    var phi_2818_: bool;
    var phi_2940_: bool;
    var phi_2946_: bool;
    var phi_2956_: bool;
    var phi_3000_: bool;
    var phi_3006_: bool;
    var phi_3016_: bool;
    var phi_3108_: bool;
    var phi_3114_: bool;
    var phi_3124_: bool;
    var phi_3227_: bool;
    var phi_3233_: bool;
    var phi_3243_: bool;
    var phi_3300_: bool;
    var phi_3306_: bool;
    var phi_3316_: bool;

    let _e362 = (*currentAge_9);
    moisture_5 = _e362;
    moistureModified_1 = false;
    let _e363 = moisture_5;
    let _e365 = tuning.sandMoistureCapacity;
    if (_e363 < _e365) {
        let _e367 = (*randVal_11);
        startDir_5 = i32((fract((_e367 * 17f)) * 6f));
        i_20 = 0i;
        loop {
            let _e372 = i_20;
            if (_e372 < 6i) {
                let _e374 = startDir_5;
                let _e375 = i_20;
                let _e376 = (_e374 + _e375);
                d_19 = (_e376 - (i32(floor((f32(_e376) / f32(6i)))) * 6i));
                let _e384 = d_19;
                if (_e384 != 2i) {
                    let _e386 = (*pos_14);
                    let _e387 = d_19;
                    param_676 = _e387;
                    let _e388 = getOrthoDir_u0028_i1_u003b((&param_676));
                    nPos_8 = (_e386 + _e388);
                    let _e391 = nPos_8[0u];
                    let _e392 = (_e391 > 0i);
                    phi_2386_ = _e392;
                    if _e392 {
                        let _e394 = nPos_8[0u];
                        let _e396 = tuning.gridWidth;
                        phi_2386_ = (_e394 < (bitcast<i32>(_e396) - 1i));
                    }
                    let _e401 = phi_2386_;
                    phi_2392_ = _e401;
                    if _e401 {
                        let _e403 = nPos_8[1u];
                        phi_2392_ = (_e403 > 0i);
                    }
                    let _e406 = phi_2392_;
                    phi_2402_ = _e406;
                    if _e406 {
                        let _e408 = nPos_8[1u];
                        let _e410 = tuning.gridHeight;
                        phi_2402_ = (_e408 < (bitcast<i32>(_e410) - 1i));
                    }
                    let _e415 = phi_2402_;
                    phi_2408_ = _e415;
                    if _e415 {
                        let _e417 = nPos_8[2u];
                        phi_2408_ = (_e417 > 0i);
                    }
                    let _e420 = phi_2408_;
                    phi_2418_ = _e420;
                    if _e420 {
                        let _e422 = nPos_8[2u];
                        let _e424 = tuning.gridDepth;
                        phi_2418_ = (_e422 < (bitcast<i32>(_e424) - 1i));
                    }
                    let _e429 = phi_2418_;
                    if _e429 {
                        let _e430 = nPos_8;
                        param_677 = _e430;
                        let _e431 = getIndex_u0028_vi3_u003b((&param_677));
                        nIndex_5 = _e431;
                        let _e432 = nIndex_5;
                        param_678 = _e432;
                        let _e433 = readCell_u0028_u1_u003b((&param_678));
                        nVal_5 = _e433;
                        let _e434 = nVal_5;
                        param_679 = _e434;
                        let _e435 = getType_u0028_u1_u003b((&param_679));
                        if (_e435 == 2u) {
                            let _e437 = nIndex_5;
                            let _e440 = nVal_5;
                            let _e441 = atomicCompareExchangeWeak((&unnamed.grid[_e437]), _e440, 0u);
                            let _e443 = nVal_5;
                            if (_e441.old_value == _e443) {
                                let _e445 = (*currentIndex_11);
                                let _e449 = tuning.sandWaterAbsorbUnit;
                                let _e452 = atomicAdd((&unnamed.grid[_e445]), (_e449 << bitcast<u32>(24i)));
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
                let _e453 = i_20;
                i_20 = (_e453 + 1i);
            }
        }
    }
    let _e455 = moistureModified_1;
    let _e457 = moisture_5;
    if (!(_e455) && (_e457 > 0u)) {
        let _e460 = (*randVal_11);
        d_20 = i32((fract((_e460 * 31f)) * 6f));
        let _e465 = d_20;
        if (_e465 != 2i) {
            let _e467 = (*pos_14);
            let _e468 = d_20;
            param_680 = _e468;
            let _e469 = getOrthoDir_u0028_i1_u003b((&param_680));
            nPos_9 = (_e467 + _e469);
            let _e472 = nPos_9[0u];
            let _e473 = (_e472 > 0i);
            phi_2490_ = _e473;
            if _e473 {
                let _e475 = nPos_9[0u];
                let _e477 = tuning.gridWidth;
                phi_2490_ = (_e475 < (bitcast<i32>(_e477) - 1i));
            }
            let _e482 = phi_2490_;
            phi_2496_ = _e482;
            if _e482 {
                let _e484 = nPos_9[1u];
                phi_2496_ = (_e484 > 0i);
            }
            let _e487 = phi_2496_;
            phi_2506_ = _e487;
            if _e487 {
                let _e489 = nPos_9[1u];
                let _e491 = tuning.gridHeight;
                phi_2506_ = (_e489 < (bitcast<i32>(_e491) - 1i));
            }
            let _e496 = phi_2506_;
            phi_2512_ = _e496;
            if _e496 {
                let _e498 = nPos_9[2u];
                phi_2512_ = (_e498 > 0i);
            }
            let _e501 = phi_2512_;
            phi_2522_ = _e501;
            if _e501 {
                let _e503 = nPos_9[2u];
                let _e505 = tuning.gridDepth;
                phi_2522_ = (_e503 < (bitcast<i32>(_e505) - 1i));
            }
            let _e510 = phi_2522_;
            if _e510 {
                let _e511 = nPos_9;
                param_681 = _e511;
                let _e512 = getIndex_u0028_vi3_u003b((&param_681));
                nIndex_6 = _e512;
                let _e513 = nIndex_6;
                param_682 = _e513;
                let _e514 = readCell_u0028_u1_u003b((&param_682));
                nVal_6 = _e514;
                let _e515 = nVal_6;
                param_683 = _e515;
                let _e516 = getType_u0028_u1_u003b((&param_683));
                nType_3 = _e516;
                let _e517 = nType_3;
                let _e519 = nType_3;
                if ((_e517 == 1u) || (_e519 == 4u)) {
                    let _e522 = nVal_6;
                    param_684 = _e522;
                    let _e523 = getAge_u0028_u1_u003b((&param_684));
                    nMoisture_1 = _e523;
                    let _e524 = nType_3;
                    if (_e524 == 4u) {
                        let _e527 = tuning.dirtMoistureCapacity;
                        local_26 = _e527;
                    } else {
                        let _e529 = tuning.sandMoistureCapacity;
                        local_26 = _e529;
                    }
                    let _e530 = local_26;
                    nCapacity_1 = _e530;
                    let _e531 = moisture_5;
                    let _e532 = nMoisture_1;
                    let _e535 = nMoisture_1;
                    let _e536 = nCapacity_1;
                    if ((_e531 > (_e532 + 1u)) && (_e535 < _e536)) {
                        let _e539 = (*currentIndex_11);
                        let _e542 = atomicAdd((&unnamed.grid[_e539]), 4278190080u);
                        let _e543 = nIndex_6;
                        let _e546 = atomicAdd((&unnamed.grid[_e543]), 16777216u);
                        moistureModified_1 = true;
                    }
                }
            }
        }
    }
    let _e547 = moistureModified_1;
    let _e548 = !(_e547);
    phi_2587_ = _e548;
    if _e548 {
        let _e549 = moisture_5;
        let _e551 = tuning.sandWaterAbsorbUnit;
        phi_2587_ = (_e549 >= _e551);
    }
    let _e554 = phi_2587_;
    if _e554 {
        let _e555 = (*pos_14);
        leakPos = (_e555 + vec3<i32>(0i, -1i, 0i));
        let _e558 = leakPos[1u];
        let _e559 = (_e558 > 0i);
        phi_2606_ = _e559;
        if _e559 {
            let _e560 = leakPos;
            param_685 = _e560;
            let _e561 = getIndex_u0028_vi3_u003b((&param_685));
            param_686 = _e561;
            let _e562 = readCell_u0028_u1_u003b((&param_686));
            param_687 = _e562;
            let _e563 = getType_u0028_u1_u003b((&param_687));
            phi_2606_ = (_e563 == 0u);
        }
        let _e566 = phi_2606_;
        if _e566 {
            let _e567 = leakPos;
            param_688 = _e567;
            let _e568 = getIndex_u0028_vi3_u003b((&param_688));
            param_689 = 2u;
            param_690 = 0u;
            param_691 = 0u;
            param_692 = 0u;
            let _e571 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_689), (&param_690), (&param_691), (&param_692));
            let _e572 = atomicCompareExchangeWeak((&unnamed.grid[_e568]), 0u, _e571);
            if (_e572.old_value == 0u) {
                let _e575 = (*currentIndex_11);
                let _e579 = tuning.sandWaterAbsorbUnit;
                let _e583 = atomicAdd((&unnamed.grid[_e575]), ((0u - _e579) << bitcast<u32>(24i)));
                incWater_u0028_();
                moistureModified_1 = true;
            }
        }
    }
    let _e584 = moistureModified_1;
    if _e584 {
        return;
    }
    let _e585 = (*pos_14);
    param_693 = _e585;
    let _e586 = grainCanMove_u0028_vi3_u003b((&param_693));
    canMove_1 = _e586;
    isClumped_1 = false;
    let _e587 = canMove_1;
    let _e588 = moisture_5;
    let _e590 = (_e587 && (_e588 > 0u));
    phi_2649_ = _e590;
    if _e590 {
        let _e591 = (*currentSleep_6);
        let _e593 = tuning.wakeSleepThreshold;
        phi_2649_ = (_e591 > _e593);
    }
    let _e596 = phi_2649_;
    if _e596 {
        emptyBelowCount_1 = 0i;
        let _e598 = (*pos_14)[1u];
        if (_e598 > 1i) {
            x_2 = -1i;
            loop {
                let _e600 = x_2;
                if (_e600 <= 1i) {
                    z_2 = -1i;
                    loop {
                        let _e602 = z_2;
                        if (_e602 <= 1i) {
                            let _e604 = (*pos_14);
                            let _e605 = x_2;
                            let _e606 = z_2;
                            checkPos_2 = (_e604 + vec3<i32>(_e605, -1i, _e606));
                            let _e610 = checkPos_2[0u];
                            let _e611 = (_e610 >= 0i);
                            phi_2691_ = _e611;
                            if _e611 {
                                let _e613 = checkPos_2[0u];
                                let _e615 = tuning.gridWidth;
                                phi_2691_ = (_e613 < bitcast<i32>(_e615));
                            }
                            let _e619 = phi_2691_;
                            phi_2697_ = _e619;
                            if _e619 {
                                let _e621 = checkPos_2[2u];
                                phi_2697_ = (_e621 >= 0i);
                            }
                            let _e624 = phi_2697_;
                            phi_2706_ = _e624;
                            if _e624 {
                                let _e626 = checkPos_2[2u];
                                let _e628 = tuning.gridDepth;
                                phi_2706_ = (_e626 < bitcast<i32>(_e628));
                            }
                            let _e632 = phi_2706_;
                            if _e632 {
                                let _e633 = checkPos_2;
                                param_694 = _e633;
                                let _e634 = getIndex_u0028_vi3_u003b((&param_694));
                                param_695 = _e634;
                                let _e635 = readCell_u0028_u1_u003b((&param_695));
                                param_696 = _e635;
                                let _e636 = getType_u0028_u1_u003b((&param_696));
                                if (_e636 == 0u) {
                                    let _e638 = emptyBelowCount_1;
                                    emptyBelowCount_1 = (_e638 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e640 = z_2;
                            z_2 = (_e640 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e642 = x_2;
                    x_2 = (_e642 + 1i);
                }
            }
        }
        let _e644 = emptyBelowCount_1;
        let _e646 = tuning.emptyBelowWakeCount;
        if (_e644 >= bitcast<i32>(_e646)) {
            (*currentSleep_6) = 0u;
        } else {
            clumpCount_1 = 0i;
            x_3 = -1i;
            loop {
                let _e649 = x_3;
                if (_e649 <= 1i) {
                    y_1 = -1i;
                    loop {
                        let _e651 = y_1;
                        if (_e651 <= 1i) {
                            z_3 = -1i;
                            loop {
                                let _e653 = z_3;
                                if (_e653 <= 1i) {
                                    let _e655 = x_3;
                                    let _e657 = y_1;
                                    let _e660 = z_3;
                                    if (((_e655 == 0i) && (_e657 == 0i)) && (_e660 == 0i)) {
                                        continue;
                                    }
                                    let _e663 = (*pos_14);
                                    let _e664 = x_3;
                                    let _e665 = y_1;
                                    let _e666 = z_3;
                                    nPos_10 = (_e663 + vec3<i32>(_e664, _e665, _e666));
                                    let _e670 = nPos_10[0u];
                                    let _e671 = (_e670 >= 0i);
                                    phi_2788_ = _e671;
                                    if _e671 {
                                        let _e673 = nPos_10[0u];
                                        let _e675 = tuning.gridWidth;
                                        phi_2788_ = (_e673 < bitcast<i32>(_e675));
                                    }
                                    let _e679 = phi_2788_;
                                    phi_2794_ = _e679;
                                    if _e679 {
                                        let _e681 = nPos_10[1u];
                                        phi_2794_ = (_e681 >= 0i);
                                    }
                                    let _e684 = phi_2794_;
                                    phi_2803_ = _e684;
                                    if _e684 {
                                        let _e686 = nPos_10[1u];
                                        let _e688 = tuning.gridHeight;
                                        phi_2803_ = (_e686 < bitcast<i32>(_e688));
                                    }
                                    let _e692 = phi_2803_;
                                    phi_2809_ = _e692;
                                    if _e692 {
                                        let _e694 = nPos_10[2u];
                                        phi_2809_ = (_e694 >= 0i);
                                    }
                                    let _e697 = phi_2809_;
                                    phi_2818_ = _e697;
                                    if _e697 {
                                        let _e699 = nPos_10[2u];
                                        let _e701 = tuning.gridDepth;
                                        phi_2818_ = (_e699 < bitcast<i32>(_e701));
                                    }
                                    let _e705 = phi_2818_;
                                    if _e705 {
                                        let _e706 = nPos_10;
                                        param_697 = _e706;
                                        let _e707 = getIndex_u0028_vi3_u003b((&param_697));
                                        param_698 = _e707;
                                        let _e708 = readCell_u0028_u1_u003b((&param_698));
                                        param_699 = _e708;
                                        let _e709 = getType_u0028_u1_u003b((&param_699));
                                        if (_e709 == 1u) {
                                            let _e711 = clumpCount_1;
                                            clumpCount_1 = (_e711 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e713 = z_3;
                                    z_3 = (_e713 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e715 = y_1;
                            y_1 = (_e715 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e717 = x_3;
                    x_3 = (_e717 + 1i);
                }
            }
            let _e719 = clumpCount_1;
            let _e721 = tuning.sandClumpThreshold;
            if (_e719 >= bitcast<i32>(_e721)) {
                isClumped_1 = true;
            }
        }
    }
    let _e724 = canMove_1;
    let _e725 = isClumped_1;
    if (_e724 && !(_e725)) {
        let _e729 = (*pos_14)[1u];
        if (_e729 > 1i) {
            let _e731 = (*pos_14);
            belowPos_8 = (_e731 + vec3<i32>(0i, -1i, 0i));
            let _e733 = belowPos_8;
            param_700 = _e733;
            let _e734 = getIndex_u0028_vi3_u003b((&param_700));
            param_701 = _e734;
            let _e735 = readCell_u0028_u1_u003b((&param_701));
            param_702 = _e735;
            let _e736 = getType_u0028_u1_u003b((&param_702));
            if (_e736 == 0u) {
                let _e738 = belowPos_8;
                param_703 = _e738;
                let _e739 = getIndex_u0028_vi3_u003b((&param_703));
                param_704 = 1u;
                param_705 = 0u;
                param_706 = 0u;
                let _e740 = moisture_5;
                param_707 = _e740;
                let _e741 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_704), (&param_705), (&param_706), (&param_707));
                let _e742 = (*currentIndex_11);
                param_708 = _e742;
                let _e743 = (*rawValue_9);
                param_709 = _e743;
                param_710 = _e739;
                param_711 = _e741;
                let _e744 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_708), (&param_709), (&param_710), (&param_711));
                if _e744 {
                    return;
                }
            }
        }
        let _e746 = (*pos_14)[1u];
        if (_e746 > 1i) {
            let _e748 = (*randVal_11);
            dir_4 = select(-1i, 1i, (fract((_e748 * 10f)) > 0.5f));
            let _e753 = (*randVal_11);
            if (fract((_e753 * 100f)) > 0.5f) {
                let _e757 = (*pos_14);
                let _e758 = dir_4;
                slidePos1_1 = (_e757 + vec3<i32>(_e758, -1i, 0i));
                let _e761 = (*pos_14);
                let _e762 = dir_4;
                slidePos2_1 = (_e761 + vec3<i32>(0i, -1i, _e762));
            } else {
                let _e765 = (*pos_14);
                let _e766 = dir_4;
                slidePos1_1 = (_e765 + vec3<i32>(0i, -1i, _e766));
                let _e769 = (*pos_14);
                let _e770 = dir_4;
                slidePos2_1 = (_e769 + vec3<i32>(_e770, -1i, 0i));
            }
            let _e774 = slidePos1_1[0u];
            let _e775 = (_e774 > 0i);
            phi_2940_ = _e775;
            if _e775 {
                let _e777 = slidePos1_1[0u];
                let _e779 = tuning.gridWidth;
                phi_2940_ = (_e777 < (bitcast<i32>(_e779) - 1i));
            }
            let _e784 = phi_2940_;
            phi_2946_ = _e784;
            if _e784 {
                let _e786 = slidePos1_1[2u];
                phi_2946_ = (_e786 > 0i);
            }
            let _e789 = phi_2946_;
            phi_2956_ = _e789;
            if _e789 {
                let _e791 = slidePos1_1[2u];
                let _e793 = tuning.gridDepth;
                phi_2956_ = (_e791 < (bitcast<i32>(_e793) - 1i));
            }
            let _e798 = phi_2956_;
            if _e798 {
                let _e799 = slidePos1_1;
                param_712 = _e799;
                let _e800 = getIndex_u0028_vi3_u003b((&param_712));
                param_713 = _e800;
                let _e801 = readCell_u0028_u1_u003b((&param_713));
                param_714 = _e801;
                let _e802 = getType_u0028_u1_u003b((&param_714));
                if (_e802 == 0u) {
                    let _e804 = slidePos1_1;
                    param_715 = _e804;
                    let _e805 = getIndex_u0028_vi3_u003b((&param_715));
                    param_716 = 1u;
                    param_717 = 0u;
                    param_718 = 0u;
                    let _e806 = moisture_5;
                    param_719 = _e806;
                    let _e807 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_716), (&param_717), (&param_718), (&param_719));
                    let _e808 = (*currentIndex_11);
                    param_720 = _e808;
                    let _e809 = (*rawValue_9);
                    param_721 = _e809;
                    param_722 = _e805;
                    param_723 = _e807;
                    let _e810 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_720), (&param_721), (&param_722), (&param_723));
                    if _e810 {
                        return;
                    }
                }
            }
            let _e812 = slidePos2_1[0u];
            let _e813 = (_e812 > 0i);
            phi_3000_ = _e813;
            if _e813 {
                let _e815 = slidePos2_1[0u];
                let _e817 = tuning.gridWidth;
                phi_3000_ = (_e815 < (bitcast<i32>(_e817) - 1i));
            }
            let _e822 = phi_3000_;
            phi_3006_ = _e822;
            if _e822 {
                let _e824 = slidePos2_1[2u];
                phi_3006_ = (_e824 > 0i);
            }
            let _e827 = phi_3006_;
            phi_3016_ = _e827;
            if _e827 {
                let _e829 = slidePos2_1[2u];
                let _e831 = tuning.gridDepth;
                phi_3016_ = (_e829 < (bitcast<i32>(_e831) - 1i));
            }
            let _e836 = phi_3016_;
            if _e836 {
                let _e837 = slidePos2_1;
                param_724 = _e837;
                let _e838 = getIndex_u0028_vi3_u003b((&param_724));
                param_725 = _e838;
                let _e839 = readCell_u0028_u1_u003b((&param_725));
                param_726 = _e839;
                let _e840 = getType_u0028_u1_u003b((&param_726));
                if (_e840 == 0u) {
                    let _e842 = slidePos2_1;
                    param_727 = _e842;
                    let _e843 = getIndex_u0028_vi3_u003b((&param_727));
                    param_728 = 1u;
                    param_729 = 0u;
                    param_730 = 0u;
                    let _e844 = moisture_5;
                    param_731 = _e844;
                    let _e845 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_728), (&param_729), (&param_730), (&param_731));
                    let _e846 = (*currentIndex_11);
                    param_732 = _e846;
                    let _e847 = (*rawValue_9);
                    param_733 = _e847;
                    param_734 = _e843;
                    param_735 = _e845;
                    let _e848 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_732), (&param_733), (&param_734), (&param_735));
                    if _e848 {
                        return;
                    }
                }
            }
        }
        let _e850 = (*pos_14)[1u];
        if (_e850 > 1i) {
            let _e852 = (*pos_14);
            belowPos_9 = (_e852 + vec3<i32>(0i, -1i, 0i));
            let _e854 = belowPos_9;
            param_736 = _e854;
            let _e855 = getIndex_u0028_vi3_u003b((&param_736));
            belowIndex_3 = _e855;
            let _e856 = belowIndex_3;
            param_737 = _e856;
            let _e857 = readCell_u0028_u1_u003b((&param_737));
            belowValue_3 = _e857;
            let _e858 = belowValue_3;
            param_738 = _e858;
            let _e859 = getType_u0028_u1_u003b((&param_738));
            if (_e859 == 2u) {
                let _e861 = (*randVal_11);
                startDir_6 = i32((fract((_e861 * 8f)) * 8f));
                i_21 = 0i;
                loop {
                    let _e866 = i_21;
                    if (_e866 < 8i) {
                        let _e868 = startDir_6;
                        let _e869 = i_21;
                        let _e870 = (_e868 + _e869);
                        d_21 = (_e870 - (i32(floor((f32(_e870) / f32(8i)))) * 8i));
                        let _e878 = belowPos_9;
                        let _e879 = d_21;
                        param_739 = _e879;
                        let _e880 = getHDir_u0028_i1_u003b((&param_739));
                        pushPos_2 = (_e878 + _e880);
                        let _e883 = pushPos_2[0u];
                        let _e884 = (_e883 > 0i);
                        phi_3108_ = _e884;
                        if _e884 {
                            let _e886 = pushPos_2[0u];
                            let _e888 = tuning.gridWidth;
                            phi_3108_ = (_e886 < (bitcast<i32>(_e888) - 1i));
                        }
                        let _e893 = phi_3108_;
                        phi_3114_ = _e893;
                        if _e893 {
                            let _e895 = pushPos_2[2u];
                            phi_3114_ = (_e895 > 0i);
                        }
                        let _e898 = phi_3114_;
                        phi_3124_ = _e898;
                        if _e898 {
                            let _e900 = pushPos_2[2u];
                            let _e902 = tuning.gridDepth;
                            phi_3124_ = (_e900 < (bitcast<i32>(_e902) - 1i));
                        }
                        let _e907 = phi_3124_;
                        if _e907 {
                            param_740 = 1u;
                            param_741 = 0u;
                            param_742 = 0u;
                            let _e908 = moisture_5;
                            param_743 = _e908;
                            let _e909 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_740), (&param_741), (&param_742), (&param_743));
                            let _e910 = pushPos_2;
                            param_744 = _e910;
                            let _e911 = getIndex_u0028_vi3_u003b((&param_744));
                            let _e912 = (*currentIndex_11);
                            param_745 = _e912;
                            param_746 = _e909;
                            let _e913 = belowIndex_3;
                            param_747 = _e913;
                            let _e914 = belowValue_3;
                            param_748 = _e914;
                            param_749 = _e911;
                            let _e915 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_745), (&param_746), (&param_747), (&param_748), (&param_749));
                            if _e915 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e916 = i_21;
                        i_21 = (_e916 + 1i);
                    }
                }
                param_750 = 1u;
                param_751 = 0u;
                param_752 = 0u;
                let _e918 = moisture_5;
                param_753 = _e918;
                let _e919 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_750), (&param_751), (&param_752), (&param_753));
                let _e920 = (*currentIndex_11);
                param_754 = _e920;
                let _e921 = (*rawValue_9);
                param_755 = _e921;
                let _e922 = belowIndex_3;
                param_756 = _e922;
                param_757 = _e919;
                let _e923 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_754), (&param_755), (&param_756), (&param_757));
                if _e923 {
                    return;
                }
            }
            let _e924 = (*randVal_11);
            dir_5 = select(-1i, 1i, (fract((_e924 * 10f)) > 0.5f));
            let _e929 = (*randVal_11);
            if (fract((_e929 * 100f)) > 0.5f) {
                let _e933 = (*pos_14);
                let _e934 = dir_5;
                slidePos_1[0i] = (_e933 + vec3<i32>(_e934, -1i, 0i));
                let _e938 = (*pos_14);
                let _e939 = dir_5;
                slidePos_1[1i] = (_e938 + vec3<i32>(0i, -1i, _e939));
            } else {
                let _e943 = (*pos_14);
                let _e944 = dir_5;
                slidePos_1[0i] = (_e943 + vec3<i32>(0i, -1i, _e944));
                let _e948 = (*pos_14);
                let _e949 = dir_5;
                slidePos_1[1i] = (_e948 + vec3<i32>(_e949, -1i, 0i));
            }
            s_2 = 0i;
            loop {
                let _e953 = s_2;
                if (_e953 < 2i) {
                    let _e955 = s_2;
                    let _e957 = slidePos_1[_e955];
                    sPos_3 = _e957;
                    let _e959 = sPos_3[0u];
                    let _e960 = (_e959 > 0i);
                    phi_3227_ = _e960;
                    if _e960 {
                        let _e962 = sPos_3[0u];
                        let _e964 = tuning.gridWidth;
                        phi_3227_ = (_e962 < (bitcast<i32>(_e964) - 1i));
                    }
                    let _e969 = phi_3227_;
                    phi_3233_ = _e969;
                    if _e969 {
                        let _e971 = sPos_3[2u];
                        phi_3233_ = (_e971 > 0i);
                    }
                    let _e974 = phi_3233_;
                    phi_3243_ = _e974;
                    if _e974 {
                        let _e976 = sPos_3[2u];
                        let _e978 = tuning.gridDepth;
                        phi_3243_ = (_e976 < (bitcast<i32>(_e978) - 1i));
                    }
                    let _e983 = phi_3243_;
                    if _e983 {
                        let _e984 = sPos_3;
                        param_758 = _e984;
                        let _e985 = getIndex_u0028_vi3_u003b((&param_758));
                        sIndex_1 = _e985;
                        let _e986 = sIndex_1;
                        param_759 = _e986;
                        let _e987 = readCell_u0028_u1_u003b((&param_759));
                        sValue_1 = _e987;
                        let _e988 = sValue_1;
                        param_760 = _e988;
                        let _e989 = getType_u0028_u1_u003b((&param_760));
                        if (_e989 == 2u) {
                            let _e991 = (*randVal_11);
                            let _e993 = s_2;
                            startDir_7 = i32((fract(((_e991 * 8f) + f32(_e993))) * 8f));
                            i_22 = 0i;
                            loop {
                                let _e999 = i_22;
                                if (_e999 < 8i) {
                                    let _e1001 = startDir_7;
                                    let _e1002 = i_22;
                                    let _e1003 = (_e1001 + _e1002);
                                    d_22 = (_e1003 - (i32(floor((f32(_e1003) / f32(8i)))) * 8i));
                                    let _e1011 = sPos_3;
                                    let _e1012 = d_22;
                                    param_761 = _e1012;
                                    let _e1013 = getHDir_u0028_i1_u003b((&param_761));
                                    pushPos_3 = (_e1011 + _e1013);
                                    let _e1016 = pushPos_3[0u];
                                    let _e1017 = (_e1016 > 0i);
                                    phi_3300_ = _e1017;
                                    if _e1017 {
                                        let _e1019 = pushPos_3[0u];
                                        let _e1021 = tuning.gridWidth;
                                        phi_3300_ = (_e1019 < (bitcast<i32>(_e1021) - 1i));
                                    }
                                    let _e1026 = phi_3300_;
                                    phi_3306_ = _e1026;
                                    if _e1026 {
                                        let _e1028 = pushPos_3[2u];
                                        phi_3306_ = (_e1028 > 0i);
                                    }
                                    let _e1031 = phi_3306_;
                                    phi_3316_ = _e1031;
                                    if _e1031 {
                                        let _e1033 = pushPos_3[2u];
                                        let _e1035 = tuning.gridDepth;
                                        phi_3316_ = (_e1033 < (bitcast<i32>(_e1035) - 1i));
                                    }
                                    let _e1040 = phi_3316_;
                                    if _e1040 {
                                        param_762 = 1u;
                                        param_763 = 0u;
                                        param_764 = 0u;
                                        let _e1041 = moisture_5;
                                        param_765 = _e1041;
                                        let _e1042 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_762), (&param_763), (&param_764), (&param_765));
                                        let _e1043 = pushPos_3;
                                        param_766 = _e1043;
                                        let _e1044 = getIndex_u0028_vi3_u003b((&param_766));
                                        let _e1045 = (*currentIndex_11);
                                        param_767 = _e1045;
                                        param_768 = _e1042;
                                        let _e1046 = sIndex_1;
                                        param_769 = _e1046;
                                        let _e1047 = sValue_1;
                                        param_770 = _e1047;
                                        param_771 = _e1044;
                                        let _e1048 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_767), (&param_768), (&param_769), (&param_770), (&param_771));
                                        if _e1048 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1049 = i_22;
                                    i_22 = (_e1049 + 1i);
                                }
                            }
                            param_772 = 1u;
                            param_773 = 0u;
                            param_774 = 0u;
                            let _e1051 = moisture_5;
                            param_775 = _e1051;
                            let _e1052 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_772), (&param_773), (&param_774), (&param_775));
                            let _e1053 = (*currentIndex_11);
                            param_776 = _e1053;
                            let _e1054 = (*rawValue_9);
                            param_777 = _e1054;
                            let _e1055 = sIndex_1;
                            param_778 = _e1055;
                            param_779 = _e1052;
                            let _e1056 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_776), (&param_777), (&param_778), (&param_779));
                            if _e1056 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1057 = s_2;
                    s_2 = (_e1057 + 1i);
                }
            }
        }
    }
    let _e1059 = (*currentSleep_6);
    newSleep_4 = min((_e1059 + 1u), 255u);
    let _e1062 = (*currentIndex_11);
    let _e1065 = (*rawValue_9);
    param_780 = 1u;
    param_781 = 0u;
    let _e1066 = newSleep_4;
    param_782 = _e1066;
    let _e1067 = moisture_5;
    param_783 = _e1067;
    let _e1068 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_780), (&param_781), (&param_782), (&param_783));
    let _e1069 = atomicCompareExchangeWeak((&unnamed.grid[_e1062]), _e1065, _e1068);
    return;
}

fn orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b(pos_15: ptr<function, vec3<i32>>, currentIndex_12: ptr<function, u32>, rawValue_10: ptr<function, u32>, stepDir: ptr<function, vec3<i32>>) -> bool {
    var target_2: vec3<i32>;
    var targetIndex_3: u32;
    var param_784: vec3<i32>;
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
    var param_797: u32;
    var phi_1705_: bool;
    var phi_1712_: bool;
    var phi_1723_: bool;
    var phi_1730_: bool;
    var phi_1741_: bool;

    let _e218 = (*stepDir);
    if all((_e218 == vec3<i32>(0i, 0i, 0i))) {
        return false;
    }
    let _e221 = (*pos_15);
    let _e222 = (*stepDir);
    target_2 = (_e221 + _e222);
    let _e225 = target_2[0u];
    let _e226 = (_e225 < 1i);
    phi_1705_ = _e226;
    if !(_e226) {
        let _e229 = target_2[0u];
        let _e231 = tuning.gridWidth;
        phi_1705_ = (_e229 >= (bitcast<i32>(_e231) - 1i));
    }
    let _e236 = phi_1705_;
    phi_1712_ = _e236;
    if !(_e236) {
        let _e239 = target_2[1u];
        phi_1712_ = (_e239 < 1i);
    }
    let _e242 = phi_1712_;
    phi_1723_ = _e242;
    if !(_e242) {
        let _e245 = target_2[1u];
        let _e247 = tuning.gridHeight;
        phi_1723_ = (_e245 >= (bitcast<i32>(_e247) - 1i));
    }
    let _e252 = phi_1723_;
    phi_1730_ = _e252;
    if !(_e252) {
        let _e255 = target_2[2u];
        phi_1730_ = (_e255 < 1i);
    }
    let _e258 = phi_1730_;
    phi_1741_ = _e258;
    if !(_e258) {
        let _e261 = target_2[2u];
        let _e263 = tuning.gridDepth;
        phi_1741_ = (_e261 >= (bitcast<i32>(_e263) - 1i));
    }
    let _e268 = phi_1741_;
    if _e268 {
        return false;
    }
    let _e269 = target_2;
    param_784 = _e269;
    let _e270 = getIndex_u0028_vi3_u003b((&param_784));
    targetIndex_3 = _e270;
    let _e271 = targetIndex_3;
    param_785 = _e271;
    let _e272 = readCell_u0028_u1_u003b((&param_785));
    param_786 = _e272;
    let _e273 = getType_u0028_u1_u003b((&param_786));
    if (_e273 != 0u) {
        return false;
    }
    let _e275 = (*rawValue_10);
    param_787 = _e275;
    let _e276 = getType_u0028_u1_u003b((&param_787));
    let _e277 = (*rawValue_10);
    param_788 = _e277;
    let _e278 = getDir_u0028_u1_u003b((&param_788));
    let _e279 = (*rawValue_10);
    param_789 = _e279;
    let _e280 = getAge_u0028_u1_u003b((&param_789));
    param_790 = _e276;
    param_791 = _e278;
    param_792 = 0u;
    param_793 = _e280;
    let _e281 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_790), (&param_791), (&param_792), (&param_793));
    let _e282 = (*currentIndex_12);
    param_794 = _e282;
    let _e283 = (*rawValue_10);
    param_795 = _e283;
    let _e284 = targetIndex_3;
    param_796 = _e284;
    param_797 = _e281;
    let _e285 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_794), (&param_795), (&param_796), (&param_797));
    return _e285;
}

fn dominantAxis_u0028_vf3_u003b_f1_u003b(dir_6: ptr<function, vec3<f32>>, relative: ptr<function, f32>) -> vec3<i32> {
    var a: vec3<f32>;
    var m: f32;

    let _e202 = (*dir_6);
    a = abs(_e202);
    let _e205 = a[0u];
    let _e207 = a[1u];
    let _e209 = a[2u];
    m = max(_e205, max(_e207, _e209));
    let _e212 = m;
    if (_e212 <= 0f) {
        return vec3<i32>(0i, 0i, 0i);
    }
    let _e214 = a;
    let _e215 = m;
    let _e216 = (*relative);
    let _e221 = (*dir_6);
    return (select(vec3<i32>(0i, 0i, 0i), vec3<i32>(1i, 1i, 1i), (_e214 >= vec3((_e215 * _e216)))) * vec3<i32>(sign(_e221)));
}

fn bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b(k_1: ptr<function, i32>, planeCount: ptr<function, i32>, seed: ptr<function, f32>) -> vec3<f32> {
    var z_4: f32;
    var r_4: f32;
    var a_1: f32;

    let _e204 = (*k_1);
    let _e207 = (*planeCount);
    z_4 = ((f32(_e204) + 0.5f) / f32(_e207));
    let _e210 = z_4;
    let _e211 = z_4;
    r_4 = sqrt(max(0f, (1f - (_e210 * _e211))));
    let _e216 = (*k_1);
    let _e219 = (*seed);
    a_1 = ((2.399963f * f32(_e216)) + _e219);
    let _e221 = r_4;
    let _e222 = a_1;
    let _e225 = z_4;
    let _e226 = r_4;
    let _e227 = a_1;
    return vec3<f32>((_e221 * cos(_e222)), _e225, (_e226 * sin(_e227)));
}

fn hash_u0028_vf3_u003b(p_3: ptr<function, vec3<f32>>) -> f32 {
    let _e199 = (*p_3);
    return fract((sin(dot(_e199, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn bhOrbitAxis_u0028_vi3_u003b_vi3_u003b(center: ptr<function, vec3<i32>>, pos_16: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radial: vec3<f32>;
    var planeCount_1: i32;
    var seed_1: f32;
    var param_798: vec3<f32>;
    var best: vec3<f32>;
    var bestAlign: f32;
    var bestK: i32;
    var k_2: i32;
    var n_1: vec3<f32>;
    var param_799: i32;
    var param_800: i32;
    var param_801: f32;
    var align: f32;
    var sense: f32;
    var param_802: vec3<f32>;

    let _e215 = (*pos_16);
    let _e216 = (*center);
    radial = normalize(vec3<f32>((_e215 - _e216)));
    let _e221 = tuning.blackHoleOrbitPlanes;
    planeCount_1 = bitcast<i32>(clamp(_e221, 1u, 32u));
    let _e224 = (*center);
    param_798 = (vec3<f32>(_e224) + vec3<f32>(29f, 3f, 71f));
    let _e227 = hash_u0028_vf3_u003b((&param_798));
    seed_1 = (_e227 * 6.28318f);
    best = vec3<f32>(0f, 1f, 0f);
    bestAlign = 2f;
    bestK = 0i;
    k_2 = 0i;
    loop {
        let _e229 = k_2;
        let _e230 = planeCount_1;
        if (_e229 < _e230) {
            let _e232 = k_2;
            param_799 = _e232;
            let _e233 = planeCount_1;
            param_800 = _e233;
            let _e234 = seed_1;
            param_801 = _e234;
            let _e235 = bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b((&param_799), (&param_800), (&param_801));
            n_1 = _e235;
            let _e236 = n_1;
            let _e237 = radial;
            align = abs(dot(_e236, _e237));
            let _e240 = align;
            let _e241 = bestAlign;
            if (_e240 < _e241) {
                let _e243 = align;
                bestAlign = _e243;
                let _e244 = n_1;
                best = _e244;
                let _e245 = k_2;
                bestK = _e245;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e246 = k_2;
            k_2 = (_e246 + 1i);
        }
    }
    let _e248 = (*center);
    let _e250 = bestK;
    param_802 = (vec3<f32>(_e248) + vec3<f32>((f32(_e250) * 13f), 101f, 47f));
    let _e255 = hash_u0028_vf3_u003b((&param_802));
    sense = select(1f, -1f, (_e255 < 0.5f));
    let _e258 = best;
    let _e259 = sense;
    return (_e258 * _e259);
}

fn bhIsPurge_u0028_u1_u003b(code: ptr<function, u32>) -> bool {
    let _e199 = (*code);
    return ((_e199 & 1073741824u) != 0u);
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e199 = (*level);
    return (f32(_e199) + 0.5f);
}

fn updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b(pos_17: ptr<function, vec3<i32>>, currentIndex_13: ptr<function, u32>, rawValue_11: ptr<function, u32>, center_1: ptr<function, vec3<i32>>, slot: ptr<function, i32>, level_1: ptr<function, u32>, purge: ptr<function, bool>, dist_1: ptr<function, f32>, randVal_12: ptr<function, f32>) {
    var type_37: u32;
    var param_803: u32;
    var sleep_2: u32;
    var param_804: u32;
    var param_805: u32;
    var param_806: u32;
    var orbitSpeed: f32;
    var local_27: f32;
    var infallChance: f32;
    var local_28: f32;
    var param_807: u32;
    var param_808: u32;
    var param_809: u32;
    var param_810: u32;
    var param_811: u32;
    var param_812: u32;
    var inward: vec3<f32>;
    var axis: vec3<f32>;
    var param_813: vec3<i32>;
    var param_814: vec3<i32>;
    var tangent: vec3<f32>;
    var tangentLen: f32;
    var axial: f32;
    var grip: vec3<f32>;
    var along: vec3<f32>;
    var pullIn: bool;
    var spiral: vec3<f32>;
    var param_815: vec3<f32>;
    var param_816: f32;
    var param_817: vec3<i32>;
    var param_818: u32;
    var param_819: u32;
    var param_820: vec3<i32>;
    var param_821: vec3<f32>;
    var param_822: f32;
    var param_823: vec3<i32>;
    var param_824: u32;
    var param_825: u32;
    var param_826: vec3<i32>;
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
    var param_851: u32;
    var param_852: u32;
    var param_853: u32;
    var param_854: u32;
    var param_855: u32;
    var param_856: u32;
    var phi_2004_: bool;

    let _e276 = (*rawValue_11);
    param_803 = _e276;
    let _e277 = getType_u0028_u1_u003b((&param_803));
    type_37 = _e277;
    let _e278 = (*rawValue_11);
    param_804 = _e278;
    let _e279 = getSleep_u0028_u1_u003b((&param_804));
    sleep_2 = _e279;
    let _e280 = (*slot);
    unnamed_1.blackHoleStarve[_e280] = 0u;
    let _e283 = (*dist_1);
    let _e284 = (*level_1);
    param_805 = _e284;
    let _e285 = bhBodyRadius_u0028_u1_u003b((&param_805));
    let _e287 = tuning.blackHoleHorizon;
    if (_e283 <= (_e285 + f32(_e287))) {
        let _e291 = (*currentIndex_13);
        let _e294 = (*rawValue_11);
        let _e295 = atomicCompareExchangeWeak((&unnamed.grid[_e291]), _e294, 0u);
        let _e297 = (*rawValue_11);
        if (_e295.old_value == _e297) {
            let _e299 = (*slot);
            let _e302 = atomicLoad((&unnamed_1.blackHoles[_e299]));
            param_806 = _e302;
            let _e303 = bhIsPurge_u0028_u1_u003b((&param_806));
            if !(_e303) {
                let _e305 = (*slot);
                let _e308 = atomicAdd((&unnamed_1.blackHoleMass[_e305]), 1u);
            }
            let _e309 = type_37;
            if (_e309 == 2u) {
                decWater_u0028_();
            }
        }
        return;
    }
    let _e311 = (*purge);
    if _e311 {
        let _e313 = tuning.purgeOrbitSpeed;
        local_27 = _e313;
    } else {
        let _e315 = tuning.blackHoleOrbitSpeed;
        local_27 = _e315;
    }
    let _e316 = local_27;
    orbitSpeed = _e316;
    let _e317 = (*purge);
    if _e317 {
        let _e319 = tuning.purgeInfall;
        local_28 = _e319;
    } else {
        let _e321 = tuning.blackHoleInfall;
        local_28 = _e321;
    }
    let _e322 = local_28;
    infallChance = _e322;
    let _e323 = (*randVal_12);
    let _e324 = orbitSpeed;
    let _e325 = (*dist_1);
    if (_e323 > clamp((_e324 / sqrt(max(_e325, 1f))), 0f, 1f)) {
        let _e331 = sleep_2;
        if (_e331 != 0u) {
            let _e333 = (*currentIndex_13);
            let _e336 = (*rawValue_11);
            let _e337 = (*rawValue_11);
            param_807 = _e337;
            let _e338 = getDir_u0028_u1_u003b((&param_807));
            let _e339 = (*rawValue_11);
            param_808 = _e339;
            let _e340 = getAge_u0028_u1_u003b((&param_808));
            let _e341 = type_37;
            param_809 = _e341;
            param_810 = _e338;
            param_811 = 0u;
            param_812 = _e340;
            let _e342 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_809), (&param_810), (&param_811), (&param_812));
            let _e343 = atomicCompareExchangeWeak((&unnamed.grid[_e333]), _e336, _e342);
        }
        return;
    }
    let _e345 = (*center_1);
    let _e346 = (*pos_17);
    inward = normalize(vec3<f32>((_e345 - _e346)));
    let _e350 = (*center_1);
    param_813 = _e350;
    let _e351 = (*pos_17);
    param_814 = _e351;
    let _e352 = bhOrbitAxis_u0028_vi3_u003b_vi3_u003b((&param_813), (&param_814));
    axis = _e352;
    let _e353 = axis;
    let _e354 = inward;
    tangent = cross(_e353, _e354);
    let _e356 = tangent;
    tangentLen = length(_e356);
    let _e358 = tangentLen;
    if (_e358 < 0.05f) {
        let _e360 = axis;
        tangent = normalize(cross(_e360, vec3<f32>(0.577f, 0.577f, 0.577f)));
    } else {
        let _e363 = tangentLen;
        let _e364 = tangent;
        tangent = (_e364 / vec3(_e363));
    }
    let _e367 = (*pos_17);
    let _e368 = (*center_1);
    let _e371 = axis;
    axial = dot(vec3<f32>((_e367 - _e368)), _e371);
    let _e373 = axis;
    let _e375 = axial;
    let _e380 = tuning.blackHolePlaneGrip;
    grip = ((-(_e373) * clamp((_e375 * 0.5f), -1f, 1f)) * _e380);
    let _e382 = tangent;
    let _e383 = grip;
    along = normalize((_e382 + _e383));
    let _e386 = (*randVal_12);
    let _e389 = infallChance;
    pullIn = (fract((_e386 * 61f)) < clamp(_e389, 0f, 1f));
    let _e392 = inward;
    let _e393 = tangent;
    spiral = normalize((_e392 + (_e393 * 0.6f)));
    let _e397 = pullIn;
    phi_2004_ = _e397;
    if _e397 {
        let _e398 = spiral;
        param_815 = _e398;
        param_816 = 0.55f;
        let _e399 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_815), (&param_816));
        let _e400 = (*pos_17);
        param_817 = _e400;
        let _e401 = (*currentIndex_13);
        param_818 = _e401;
        let _e402 = (*rawValue_11);
        param_819 = _e402;
        param_820 = _e399;
        let _e403 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_817), (&param_818), (&param_819), (&param_820));
        phi_2004_ = _e403;
    }
    let _e405 = phi_2004_;
    if _e405 {
        return;
    }
    let _e406 = along;
    param_821 = _e406;
    param_822 = 0.55f;
    let _e407 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_821), (&param_822));
    let _e408 = (*pos_17);
    param_823 = _e408;
    let _e409 = (*currentIndex_13);
    param_824 = _e409;
    let _e410 = (*rawValue_11);
    param_825 = _e410;
    param_826 = _e407;
    let _e411 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_823), (&param_824), (&param_825), (&param_826));
    if _e411 {
        return;
    }
    let _e412 = along;
    param_827 = _e412;
    param_828 = 1f;
    let _e413 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_827), (&param_828));
    let _e414 = (*pos_17);
    param_829 = _e414;
    let _e415 = (*currentIndex_13);
    param_830 = _e415;
    let _e416 = (*rawValue_11);
    param_831 = _e416;
    param_832 = _e413;
    let _e417 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_829), (&param_830), (&param_831), (&param_832));
    if _e417 {
        return;
    }
    let _e418 = tangent;
    param_833 = _e418;
    param_834 = 1f;
    let _e419 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_833), (&param_834));
    let _e420 = (*pos_17);
    param_835 = _e420;
    let _e421 = (*currentIndex_13);
    param_836 = _e421;
    let _e422 = (*rawValue_11);
    param_837 = _e422;
    param_838 = _e419;
    let _e423 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_835), (&param_836), (&param_837), (&param_838));
    if _e423 {
        return;
    }
    let _e424 = inward;
    param_839 = _e424;
    param_840 = 0.55f;
    let _e425 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_839), (&param_840));
    let _e426 = (*pos_17);
    param_841 = _e426;
    let _e427 = (*currentIndex_13);
    param_842 = _e427;
    let _e428 = (*rawValue_11);
    param_843 = _e428;
    param_844 = _e425;
    let _e429 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_841), (&param_842), (&param_843), (&param_844));
    if _e429 {
        return;
    }
    let _e430 = inward;
    param_845 = _e430;
    param_846 = 1f;
    let _e431 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_845), (&param_846));
    let _e432 = (*pos_17);
    param_847 = _e432;
    let _e433 = (*currentIndex_13);
    param_848 = _e433;
    let _e434 = (*rawValue_11);
    param_849 = _e434;
    param_850 = _e431;
    let _e435 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_847), (&param_848), (&param_849), (&param_850));
    if _e435 {
        return;
    }
    let _e436 = sleep_2;
    if (_e436 != 0u) {
        let _e438 = (*currentIndex_13);
        let _e441 = (*rawValue_11);
        let _e442 = (*rawValue_11);
        param_851 = _e442;
        let _e443 = getDir_u0028_u1_u003b((&param_851));
        let _e444 = (*rawValue_11);
        param_852 = _e444;
        let _e445 = getAge_u0028_u1_u003b((&param_852));
        let _e446 = type_37;
        param_853 = _e446;
        param_854 = _e443;
        param_855 = 0u;
        param_856 = _e445;
        let _e447 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_853), (&param_854), (&param_855), (&param_856));
        let _e448 = atomicCompareExchangeWeak((&unnamed.grid[_e438]), _e441, _e447);
    }
    return;
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_2: u32;
    var l: u32;
    var r_5: f32;
    var param_857: u32;
    var volume: f32;

    level_2 = 0u;
    l = 1u;
    loop {
        let _e204 = l;
        let _e206 = tuning.blackHoleMaxLevel;
        if (_e204 <= min(_e206, 16u)) {
            let _e209 = l;
            param_857 = _e209;
            let _e210 = bhBodyRadius_u0028_u1_u003b((&param_857));
            r_5 = _e210;
            let _e211 = r_5;
            let _e213 = r_5;
            let _e215 = r_5;
            volume = (((4.18879f * _e211) * _e213) * _e215);
            let _e217 = (*mass);
            let _e220 = tuning.blackHoleGrowthCost;
            let _e221 = volume;
            if (f32(_e217) < (_e220 * _e221)) {
                break;
            }
            let _e224 = l;
            level_2 = _e224;
            continue;
        } else {
            break;
        }
        continuing {
            let _e225 = l;
            l = (_e225 + bitcast<u32>(1i));
        }
    }
    let _e228 = level_2;
    return _e228;
}

fn bhLevelFor_u0028_u1_u003b_u1_u003b(code_1: ptr<function, u32>, mass_1: ptr<function, u32>) -> u32 {
    var param_858: u32;
    var param_859: u32;

    let _e202 = (*code_1);
    param_858 = _e202;
    let _e203 = bhIsPurge_u0028_u1_u003b((&param_858));
    if _e203 {
        let _e205 = tuning.purgeLevel;
        let _e207 = (*mass_1);
        let _e210 = tuning.purgeMass;
        return u32((f32(_e205) * clamp((f32(_e207) / f32(max(_e210, 1u))), 0f, 1f)));
    }
    let _e217 = (*mass_1);
    param_859 = _e217;
    let _e218 = bhLevel_u0028_u1_u003b((&param_859));
    return _e218;
}

fn bhDecode_u0028_u1_u003b(code_2: ptr<function, u32>) -> vec3<i32> {
    var i_23: u32;

    let _e200 = (*code_2);
    i_23 = (_e200 & 1073741823u);
    let _e202 = i_23;
    let _e204 = tuning.gridWidth;
    let _e209 = i_23;
    let _e211 = tuning.gridWidth;
    let _e216 = tuning.gridHeight;
    let _e221 = i_23;
    let _e223 = tuning.gridWidth;
    let _e226 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e202 % bitcast<u32>(bitcast<i32>(_e204)))), bitcast<i32>(((_e209 / bitcast<u32>(bitcast<i32>(_e211))) % bitcast<u32>(bitcast<i32>(_e216)))), bitcast<i32>((_e221 / bitcast<u32>((bitcast<i32>(_e223) * bitcast<i32>(_e226))))));
}

fn captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b(pos_18: ptr<function, vec3<i32>>, currentIndex_14: ptr<function, u32>, rawValue_12: ptr<function, u32>, randVal_13: ptr<function, f32>) -> bool {
    var bestDistSq: f32;
    var bestCenter: vec3<i32>;
    var bestSlot: i32;
    var bestLevel: u32;
    var bestPurge: bool;
    var maxRadius: f32;
    var maxRadiusSq: f32;
    var i_24: i32;
    var code_3: u32;
    var center_2: vec3<i32>;
    var param_860: u32;
    var d_23: vec3<f32>;
    var distSq: f32;
    var purge_1: bool;
    var param_861: u32;
    var level_3: u32;
    var param_862: u32;
    var param_863: u32;
    var radius: f32;
    var local_29: f32;
    var param_864: vec3<i32>;
    var param_865: u32;
    var param_866: u32;
    var param_867: vec3<i32>;
    var param_868: i32;
    var param_869: u32;
    var param_870: bool;
    var param_871: f32;
    var param_872: f32;

    let _e232 = unnamed_1.blackHoleCount;
    if (_e232 == 0u) {
        return false;
    }
    bestDistSq = 3000000000f;
    bestCenter = vec3<i32>(0i, 0i, 0i);
    bestSlot = -1i;
    bestLevel = 0u;
    bestPurge = false;
    let _e235 = tuning.blackHoleRadius;
    let _e237 = tuning.blackHoleMaxLevel;
    maxRadius = f32((_e235 + min(_e237, 16u)));
    let _e241 = maxRadius;
    let _e242 = maxRadius;
    maxRadiusSq = (_e241 * _e242);
    i_24 = 0i;
    loop {
        let _e244 = i_24;
        if (_e244 < 8i) {
            let _e246 = i_24;
            let _e249 = atomicLoad((&unnamed_1.blackHoles[_e246]));
            code_3 = _e249;
            let _e250 = code_3;
            if (_e250 == 0u) {
                continue;
            }
            let _e252 = code_3;
            param_860 = _e252;
            let _e253 = bhDecode_u0028_u1_u003b((&param_860));
            center_2 = _e253;
            let _e254 = center_2;
            let _e255 = (*pos_18);
            d_23 = vec3<f32>((_e254 - _e255));
            let _e258 = d_23;
            let _e259 = d_23;
            distSq = dot(_e258, _e259);
            let _e261 = code_3;
            param_861 = _e261;
            let _e262 = bhIsPurge_u0028_u1_u003b((&param_861));
            purge_1 = _e262;
            let _e263 = purge_1;
            let _e265 = distSq;
            let _e266 = maxRadiusSq;
            if (!(_e263) && (_e265 > _e266)) {
                continue;
            }
            let _e269 = distSq;
            let _e270 = bestDistSq;
            if (_e269 >= _e270) {
                continue;
            }
            let _e272 = i_24;
            let _e273 = code_3;
            param_862 = _e273;
            let _e276 = atomicLoad((&unnamed_1.blackHoleMass[_e272]));
            param_863 = _e276;
            let _e277 = bhLevelFor_u0028_u1_u003b_u1_u003b((&param_862), (&param_863));
            level_3 = _e277;
            let _e278 = purge_1;
            if _e278 {
                local_29 = 1000000000f;
            } else {
                let _e280 = tuning.blackHoleRadius;
                let _e281 = level_3;
                local_29 = f32((_e280 + _e281));
            }
            let _e284 = local_29;
            radius = _e284;
            let _e285 = distSq;
            let _e286 = radius;
            let _e287 = radius;
            if (_e285 <= (_e286 * _e287)) {
                let _e290 = distSq;
                bestDistSq = _e290;
                let _e291 = center_2;
                bestCenter = _e291;
                let _e292 = i_24;
                bestSlot = _e292;
                let _e293 = level_3;
                bestLevel = _e293;
                let _e294 = purge_1;
                bestPurge = _e294;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e295 = i_24;
            i_24 = (_e295 + 1i);
        }
    }
    let _e297 = bestSlot;
    if (_e297 < 0i) {
        return false;
    }
    let _e299 = bestDistSq;
    let _e301 = (*pos_18);
    param_864 = _e301;
    let _e302 = (*currentIndex_14);
    param_865 = _e302;
    let _e303 = (*rawValue_12);
    param_866 = _e303;
    let _e304 = bestCenter;
    param_867 = _e304;
    let _e305 = bestSlot;
    param_868 = _e305;
    let _e306 = bestLevel;
    param_869 = _e306;
    let _e307 = bestPurge;
    param_870 = _e307;
    param_871 = sqrt(_e299);
    let _e308 = (*randVal_13);
    param_872 = _e308;
    updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b((&param_864), (&param_865), (&param_866), (&param_867), (&param_868), (&param_869), (&param_870), (&param_871), (&param_872));
    return true;
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x_4: ptr<function, i32>, z_5: ptr<function, i32>) -> u32 {
    let _e200 = (*x_4);
    let _e201 = (*z_5);
    let _e203 = tuning.gridWidth;
    return (bitcast<u32>((_e200 + (_e201 * bitcast<i32>(_e203)))) * 4u);
}

fn bhRegister_u0028_vi3_u003b(p_4: ptr<function, vec3<i32>>) -> bool {
    var code_4: u32;
    var param_873: vec3<i32>;
    var i_25: i32;

    let _e202 = (*p_4);
    param_873 = _e202;
    let _e203 = getIndex_u0028_vi3_u003b((&param_873));
    code_4 = (2147483648u | _e203);
    i_25 = 0i;
    loop {
        let _e205 = i_25;
        if (_e205 < 8i) {
            let _e207 = i_25;
            let _e210 = code_4;
            let _e211 = atomicCompareExchangeWeak((&unnamed_1.blackHoles[_e207]), 0u, _e210);
            if (_e211.old_value == 0u) {
                let _e214 = i_25;
                atomicStore((&unnamed_1.blackHoleMass[_e214]), 0u);
                let _e217 = i_25;
                unnamed_1.blackHoleStarve[_e217] = 0u;
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e220 = i_25;
            i_25 = (_e220 + 1i);
        }
    }
    return false;
}

fn writeCell_u0028_u1_u003b_u1_u003b(index_1: ptr<function, u32>, value_2: ptr<function, u32>) {
    let _e200 = (*index_1);
    let _e201 = (*value_2);
    atomicStore((&unnamed.grid[_e200]), _e201);
    return;
}

fn lavaSpawnCoolness_u0028_u1_u003b(type_38: ptr<function, u32>) -> u32 {
    var param_874: u32;

    let _e200 = (*type_38);
    if (_e200 == 12u) {
        let _e202 = lavaSolidifyCoolness_u0028_();
        return _e202;
    }
    let _e203 = (*type_38);
    param_874 = _e203;
    let _e204 = isLava_u0028_u1_u003b((&param_874));
    if _e204 {
        let _e205 = (*type_38);
        let _e208 = tuning.lavaStageSize;
        return ((_e205 - 8u) * max(_e208, 1u));
    }
    return 0u;
}

fn locustSpawnCount_u0028_u1_u003b(type_39: ptr<function, u32>) -> u32 {
    var param_875: u32;

    let _e200 = (*type_39);
    param_875 = _e200;
    let _e201 = isLocust_u0028_u1_u003b((&param_875));
    if !(_e201) {
        return 0u;
    }
    let _e203 = (*type_39);
    let _e206 = locustStage_u0028_();
    let _e208 = locustMaxCount_u0028_();
    return min((((_e203 - 13u) + 1u) * _e206), _e208);
}

fn bhRelease_u0028_vi3_u003b(p_5: ptr<function, vec3<i32>>) {
    var code_5: u32;
    var param_876: vec3<i32>;
    var i_26: i32;

    let _e202 = (*p_5);
    param_876 = _e202;
    let _e203 = getIndex_u0028_vi3_u003b((&param_876));
    code_5 = (2147483648u | _e203);
    i_26 = 0i;
    loop {
        let _e205 = i_26;
        if (_e205 < 8i) {
            let _e207 = i_26;
            let _e210 = code_5;
            let _e211 = atomicCompareExchangeWeak((&unnamed_1.blackHoles[_e207]), _e210, 0u);
            continue;
        } else {
            break;
        }
        continuing {
            let _e213 = i_26;
            i_26 = (_e213 + 1i);
        }
    }
    return;
}

fn inBrush_u0028_vi3_u003b(pos_19: ptr<function, vec3<i32>>) -> bool {
    var halfMin: i32;
    var halfMax: i32;
    var center_3: vec3<f32>;
    var d_24: vec3<f32>;
    var radius_1: f32;
    var phi_1466_: bool;
    var phi_1488_: bool;
    var phi_1509_: bool;

    let _e205 = pc.spawnSize;
    halfMin = (_e205 / 2i);
    let _e208 = pc.spawnSize;
    halfMax = ((_e208 - 1i) / 2i);
    let _e212 = (*pos_19)[0u];
    let _e214 = pc.spawnX;
    let _e215 = halfMin;
    let _e217 = (_e212 < (_e214 - _e215));
    phi_1466_ = _e217;
    if !(_e217) {
        let _e220 = (*pos_19)[0u];
        let _e222 = pc.spawnX;
        let _e223 = halfMax;
        phi_1466_ = (_e220 > (_e222 + _e223));
    }
    let _e227 = phi_1466_;
    if _e227 {
        return false;
    }
    let _e229 = (*pos_19)[1u];
    let _e231 = pc.spawnY;
    let _e232 = halfMin;
    let _e234 = (_e229 < (_e231 - _e232));
    phi_1488_ = _e234;
    if !(_e234) {
        let _e237 = (*pos_19)[1u];
        let _e239 = pc.spawnY;
        let _e240 = halfMax;
        phi_1488_ = (_e237 > (_e239 + _e240));
    }
    let _e244 = phi_1488_;
    if _e244 {
        return false;
    }
    let _e246 = (*pos_19)[2u];
    let _e248 = pc.spawnZ;
    let _e249 = halfMin;
    let _e251 = (_e246 < (_e248 - _e249));
    phi_1509_ = _e251;
    if !(_e251) {
        let _e254 = (*pos_19)[2u];
        let _e256 = pc.spawnZ;
        let _e257 = halfMax;
        phi_1509_ = (_e254 > (_e256 + _e257));
    }
    let _e261 = phi_1509_;
    if _e261 {
        return false;
    }
    let _e263 = pc.spawnShape;
    if (_e263 != 1i) {
        return true;
    }
    let _e266 = pc.spawnX;
    let _e269 = pc.spawnY;
    let _e272 = pc.spawnZ;
    let _e275 = halfMax;
    let _e276 = halfMin;
    center_3 = (vec3<f32>(f32(_e266), f32(_e269), f32(_e272)) + vec3((f32(((_e275 - _e276) + 1i)) * 0.5f)));
    let _e283 = (*pos_19);
    let _e287 = center_3;
    d_24 = ((vec3<f32>(_e283) + vec3(0.5f)) - _e287);
    let _e290 = pc.spawnSize;
    radius_1 = (f32(_e290) * 0.5f);
    let _e293 = d_24;
    let _e294 = d_24;
    let _e296 = radius_1;
    let _e297 = radius_1;
    return (dot(_e293, _e294) <= (_e296 * _e297));
}

fn tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(fromIndex: ptr<function, u32>, newValue_4: ptr<function, u32>, toIndex: ptr<function, u32>, expectedFromValue: ptr<function, u32>) -> bool {
    let _e202 = (*toIndex);
    let _e205 = (*newValue_4);
    let _e206 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e202]), 0u, _e205);
    if (_e206.old_value != 0u) {
        return false;
    }
    let _e209 = (*fromIndex);
    let _e212 = (*expectedFromValue);
    let _e213 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e209]), _e212, 0u);
    let _e215 = (*expectedFromValue);
    if (_e213.old_value != _e215) {
        let _e217 = (*toIndex);
        let _e220 = atomicExchange((&unnamed_2.cloudCells[_e217]), 0u);
        return false;
    }
    return true;
}

fn cloudCellInBounds_u0028_vi3_u003b(p_6: ptr<function, vec3<i32>>) -> bool {
    var phi_574_: bool;
    var phi_580_: bool;
    var phi_590_: bool;
    var phi_596_: bool;
    var phi_606_: bool;

    let _e200 = (*p_6)[0u];
    let _e201 = (_e200 >= 1i);
    phi_574_ = _e201;
    if _e201 {
        let _e203 = (*p_6)[0u];
        let _e205 = tuning.gridWidth;
        phi_574_ = (_e203 < (bitcast<i32>(_e205) - 1i));
    }
    let _e210 = phi_574_;
    phi_580_ = _e210;
    if _e210 {
        let _e212 = (*p_6)[1u];
        phi_580_ = (_e212 >= 1i);
    }
    let _e215 = phi_580_;
    phi_590_ = _e215;
    if _e215 {
        let _e217 = (*p_6)[1u];
        let _e219 = tuning.gridHeight;
        phi_590_ = (_e217 < (bitcast<i32>(_e219) - 1i));
    }
    let _e224 = phi_590_;
    phi_596_ = _e224;
    if _e224 {
        let _e226 = (*p_6)[2u];
        phi_596_ = (_e226 >= 1i);
    }
    let _e229 = phi_596_;
    phi_606_ = _e229;
    if _e229 {
        let _e231 = (*p_6)[2u];
        let _e233 = tuning.gridDepth;
        phi_606_ = (_e231 < (bitcast<i32>(_e233) - 1i));
    }
    let _e238 = phi_606_;
    return _e238;
}

fn getCloudWait_u0028_u1_u003b(v_5: ptr<function, u32>) -> u32 {
    let _e199 = (*v_5);
    return ((_e199 >> bitcast<u32>(2i)) & 255u);
}

fn updateCloudBlock_u0028_vi3_u003b(pos_20: ptr<function, vec3<i32>>) {
    var idx_4: u32;
    var param_877: vec3<i32>;
    var base: u32;
    var param_878: i32;
    var param_879: i32;
    var cell: u32;
    var kind_1: u32;
    var param_880: u32;
    var r_6: f32;
    var param_881: vec3<f32>;
    var waitMax: u32;
    var newCell: u32;
    var param_882: u32;
    var param_883: u32;
    var param_884: u32;
    var param_885: u32;
    var param_886: u32;
    var param_887: u32;
    var param_888: u32;
    var param_889: u32;
    var wait_1: u32;
    var param_890: u32;
    var param_891: u32;
    var param_892: u32;
    var param_893: u32;
    var param_894: vec3<i32>;
    var g: u32;
    var param_895: u32;
    var param_896: u32;
    var param_897: u32;
    var param_898: u32;
    var param_899: u32;
    var param_900: u32;
    var randVal_14: f32;
    var param_901: vec3<f32>;
    var sleep_3: u32;
    var param_902: u32;
    var canRise: bool;
    var i_27: i32;
    var t_4: vec3<i32>;
    var local_30: vec3<i32>;
    var local_31: vec3<i32>;
    var local_32: vec3<i32>;
    var param_903: vec3<i32>;
    var param_904: vec3<i32>;
    var param_905: u32;
    var param_906: u32;
    var param_907: u32;
    var param_908: u32;
    var param_909: u32;
    var isClumped_2: bool;
    var clump: u32;
    var x_5: i32;
    var y_2: i32;
    var z_6: i32;
    var n_2: vec3<i32>;
    var param_910: vec3<i32>;
    var param_911: u32;
    var param_912: u32;
    var param_913: u32;
    var param_914: u32;
    var param_915: u32;
    var upPos_2: vec3<i32>;
    var upIndex_1: u32;
    var param_916: vec3<i32>;
    var param_917: vec3<i32>;
    var param_918: u32;
    var param_919: u32;
    var param_920: u32;
    var param_921: u32;
    var param_922: u32;
    var param_923: u32;
    var param_924: u32;
    var param_925: u32;
    var param_926: u32;
    var dir_7: i32;
    var slide1_: vec3<i32>;
    var slide2_: vec3<i32>;
    var i_28: i32;
    var t_5: vec3<i32>;
    var param_927: vec3<i32>;
    var tIndex: u32;
    var param_928: vec3<i32>;
    var param_929: u32;
    var param_930: u32;
    var param_931: u32;
    var param_932: u32;
    var param_933: u32;
    var param_934: u32;
    var param_935: u32;
    var param_936: u32;
    var param_937: u32;
    var param_938: u32;
    var param_939: u32;
    var param_940: u32;
    var param_941: u32;
    var phi_8788_: bool;
    var phi_9036_: bool;
    var phi_9094_: bool;
    var phi_9101_: bool;
    var phi_9111_: bool;
    var phi_9118_: bool;
    var phi_9128_: bool;
    var phi_9193_: bool;

    let _e295 = (*pos_20);
    param_877 = _e295;
    let _e296 = getIndex_u0028_vi3_u003b((&param_877));
    idx_4 = _e296;
    let _e298 = (*pos_20)[0u];
    param_878 = _e298;
    let _e300 = (*pos_20)[2u];
    param_879 = _e300;
    let _e301 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_878), (&param_879));
    base = _e301;
    let _e303 = (*pos_20)[1u];
    if (_e303 == 0i) {
        let _e305 = base;
        let _e307 = base;
        let _e311 = atomicLoad((&unnamed_1.cloudColumn[(_e307 + 0u)]));
        atomicStore((&unnamed_1.cloudColumn[(_e305 + 2u)]), _e311);
        let _e314 = base;
        let _e316 = base;
        let _e320 = atomicLoad((&unnamed_1.cloudColumn[(_e316 + 1u)]));
        atomicStore((&unnamed_1.cloudColumn[(_e314 + 3u)]), _e320);
        let _e323 = base;
        atomicStore((&unnamed_1.cloudColumn[(_e323 + 0u)]), 0u);
        let _e327 = base;
        atomicStore((&unnamed_1.cloudColumn[(_e327 + 1u)]), 0u);
    }
    let _e331 = idx_4;
    let _e334 = atomicLoad((&unnamed_2.cloudCells[_e331]));
    cell = _e334;
    let _e335 = cell;
    param_880 = _e335;
    let _e336 = getCloudKind_u0028_u1_u003b((&param_880));
    kind_1 = _e336;
    let _e337 = kind_1;
    if (_e337 == 0u) {
        return;
    }
    let _e340 = atomicAdd((&unnamed_1.cloudBlockCount), 1u);
    let _e341 = base;
    let _e345 = atomicAdd((&unnamed_1.cloudColumn[(_e341 + 0u)]), 1u);
    let _e346 = base;
    let _e351 = (*pos_20)[1u];
    let _e353 = atomicMax((&unnamed_1.cloudColumn[(_e346 + 1u)]), bitcast<u32>(_e351));
    let _e354 = kind_1;
    let _e355 = (_e354 == 1u);
    phi_8788_ = _e355;
    if _e355 {
        let _e357 = unnamed_1.rainPhase;
        phi_8788_ = (_e357 == 2u);
    }
    let _e360 = phi_8788_;
    if _e360 {
        let _e361 = (*pos_20);
        let _e364 = pc.time;
        param_881 = (vec3<f32>(_e361) + vec3<f32>(_e364, 17f, 3f));
        let _e367 = hash_u0028_vf3_u003b((&param_881));
        r_6 = _e367;
        let _e369 = tuning.stormWaitMaxTicks;
        waitMax = clamp(_e369, 1u, 255u);
        let _e371 = r_6;
        let _e372 = waitMax;
        param_882 = 2u;
        param_883 = u32((_e371 * f32(_e372)));
        param_884 = 0u;
        let _e376 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_882), (&param_883), (&param_884));
        newCell = _e376;
        let _e377 = idx_4;
        let _e380 = cell;
        let _e381 = newCell;
        let _e382 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e377]), _e380, _e381);
        let _e384 = cell;
        if (_e382.old_value != _e384) {
            return;
        }
        let _e386 = newCell;
        cell = _e386;
        kind_1 = 2u;
    }
    let _e388 = (*pos_20)[1u];
    let _e390 = tuning.gridHeight;
    if (_e388 >= (bitcast<i32>(_e390) - 2i)) {
        let _e394 = kind_1;
        if (_e394 != 2u) {
            let _e396 = cell;
            param_885 = _e396;
            let _e397 = getCloudSleep_u0028_u1_u003b((&param_885));
            if (_e397 < 255u) {
                let _e399 = idx_4;
                let _e402 = cell;
                let _e403 = cell;
                param_886 = _e403;
                let _e404 = getCloudWait_u0028_u1_u003b((&param_886));
                let _e405 = kind_1;
                param_887 = _e405;
                param_888 = _e404;
                param_889 = 255u;
                let _e406 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_887), (&param_888), (&param_889));
                let _e407 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e399]), _e402, _e406);
            }
            return;
        }
        let _e409 = cell;
        param_890 = _e409;
        let _e410 = getCloudWait_u0028_u1_u003b((&param_890));
        wait_1 = _e410;
        let _e411 = wait_1;
        if (_e411 > 0u) {
            let _e413 = idx_4;
            let _e416 = cell;
            let _e417 = wait_1;
            param_891 = 2u;
            param_892 = (_e417 - 1u);
            param_893 = 0u;
            let _e419 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_891), (&param_892), (&param_893));
            let _e420 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e413]), _e416, _e419);
            return;
        }
        let _e422 = (*pos_20);
        param_894 = _e422;
        let _e423 = cloudCellInBounds_u0028_vi3_u003b((&param_894));
        if !(_e423) {
            return;
        }
        let _e425 = idx_4;
        param_895 = _e425;
        let _e426 = readCell_u0028_u1_u003b((&param_895));
        g = _e426;
        let _e427 = g;
        param_896 = _e427;
        let _e428 = getType_u0028_u1_u003b((&param_896));
        if (_e428 != 0u) {
            return;
        }
        let _e430 = idx_4;
        let _e433 = g;
        param_897 = 2u;
        param_898 = 0u;
        param_899 = 0u;
        param_900 = 0u;
        let _e434 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_897), (&param_898), (&param_899), (&param_900));
        let _e435 = atomicCompareExchangeWeak((&unnamed.grid[_e430]), _e433, _e434);
        let _e437 = g;
        if (_e435.old_value != _e437) {
            return;
        }
        let _e439 = idx_4;
        let _e442 = atomicExchange((&unnamed_2.cloudCells[_e439]), 0u);
        incWater_u0028_();
        let _e444 = (*pos_20)[1u];
        let _e447 = atomicLoad((&unnamed_1.maxOccupiedY));
        if (bitcast<u32>(_e444) > _e447) {
            let _e451 = (*pos_20)[1u];
            let _e453 = atomicMax((&unnamed_1.maxOccupiedY), bitcast<u32>(_e451));
        }
        return;
    }
    let _e454 = (*pos_20);
    let _e457 = pc.time;
    param_901 = (vec3<f32>(_e454) + vec3<f32>((_e457 * 2.3f), 7f, 13f));
    let _e461 = hash_u0028_vf3_u003b((&param_901));
    randVal_14 = _e461;
    let _e462 = cell;
    param_902 = _e462;
    let _e463 = getCloudSleep_u0028_u1_u003b((&param_902));
    sleep_3 = _e463;
    canRise = false;
    i_27 = 0i;
    loop {
        let _e464 = i_27;
        let _e466 = canRise;
        if ((_e464 < 5i) && !(_e466)) {
            let _e469 = (*pos_20);
            let _e470 = i_27;
            if (_e470 == 0i) {
                local_30 = vec3<i32>(0i, 1i, 0i);
            } else {
                let _e472 = i_27;
                if (_e472 == 1i) {
                    local_31 = vec3<i32>(1i, 1i, 0i);
                } else {
                    let _e474 = i_27;
                    if (_e474 == 2i) {
                        local_32 = vec3<i32>(-1i, 1i, 0i);
                    } else {
                        let _e476 = i_27;
                        local_32 = select(vec3<i32>(0i, 1i, -1i), vec3<i32>(0i, 1i, 1i), vec3((_e476 == 3i)));
                    }
                    let _e480 = local_32;
                    local_31 = _e480;
                }
                let _e481 = local_31;
                local_30 = _e481;
            }
            let _e482 = local_30;
            t_4 = (_e469 + _e482);
            let _e484 = t_4;
            param_903 = _e484;
            let _e485 = cloudCellInBounds_u0028_vi3_u003b((&param_903));
            if !(_e485) {
                continue;
            }
            let _e487 = t_4;
            param_904 = _e487;
            let _e488 = getIndex_u0028_vi3_u003b((&param_904));
            let _e491 = atomicLoad((&unnamed_2.cloudCells[_e488]));
            param_905 = _e491;
            let _e492 = getCloudKind_u0028_u1_u003b((&param_905));
            if (_e492 == 0u) {
                canRise = true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e494 = i_27;
            i_27 = (_e494 + 1i);
        }
    }
    let _e496 = canRise;
    if !(_e496) {
        let _e498 = idx_4;
        let _e501 = cell;
        let _e502 = cell;
        param_906 = _e502;
        let _e503 = getCloudWait_u0028_u1_u003b((&param_906));
        let _e504 = sleep_3;
        let _e507 = kind_1;
        param_907 = _e507;
        param_908 = _e503;
        param_909 = min((_e504 + 1u), 255u);
        let _e508 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_907), (&param_908), (&param_909));
        let _e509 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e498]), _e501, _e508);
        return;
    }
    isClumped_2 = false;
    let _e511 = sleep_3;
    let _e513 = tuning.wakeSleepThreshold;
    let _e514 = (_e511 > _e513);
    phi_9036_ = _e514;
    if _e514 {
        let _e516 = tuning.cloudClumpThreshold;
        phi_9036_ = (_e516 > 0u);
    }
    let _e519 = phi_9036_;
    if _e519 {
        clump = 0u;
        x_5 = -1i;
        loop {
            let _e520 = x_5;
            if (_e520 <= 1i) {
                y_2 = -1i;
                loop {
                    let _e522 = y_2;
                    if (_e522 <= 1i) {
                        z_6 = -1i;
                        loop {
                            let _e524 = z_6;
                            if (_e524 <= 1i) {
                                let _e526 = x_5;
                                let _e528 = y_2;
                                let _e531 = z_6;
                                if (((_e526 == 0i) && (_e528 == 0i)) && (_e531 == 0i)) {
                                    continue;
                                }
                                let _e534 = (*pos_20);
                                let _e535 = x_5;
                                let _e536 = y_2;
                                let _e537 = z_6;
                                n_2 = (_e534 + vec3<i32>(_e535, _e536, _e537));
                                let _e541 = n_2[0u];
                                let _e542 = (_e541 < 0i);
                                phi_9094_ = _e542;
                                if !(_e542) {
                                    let _e545 = n_2[0u];
                                    let _e547 = tuning.gridWidth;
                                    phi_9094_ = (_e545 >= bitcast<i32>(_e547));
                                }
                                let _e551 = phi_9094_;
                                phi_9101_ = _e551;
                                if !(_e551) {
                                    let _e554 = n_2[1u];
                                    phi_9101_ = (_e554 < 0i);
                                }
                                let _e557 = phi_9101_;
                                phi_9111_ = _e557;
                                if !(_e557) {
                                    let _e560 = n_2[1u];
                                    let _e562 = tuning.gridHeight;
                                    phi_9111_ = (_e560 >= bitcast<i32>(_e562));
                                }
                                let _e566 = phi_9111_;
                                phi_9118_ = _e566;
                                if !(_e566) {
                                    let _e569 = n_2[2u];
                                    phi_9118_ = (_e569 < 0i);
                                }
                                let _e572 = phi_9118_;
                                phi_9128_ = _e572;
                                if !(_e572) {
                                    let _e575 = n_2[2u];
                                    let _e577 = tuning.gridDepth;
                                    phi_9128_ = (_e575 >= bitcast<i32>(_e577));
                                }
                                let _e581 = phi_9128_;
                                if _e581 {
                                    continue;
                                }
                                let _e582 = n_2;
                                param_910 = _e582;
                                let _e583 = getIndex_u0028_vi3_u003b((&param_910));
                                let _e586 = atomicLoad((&unnamed_2.cloudCells[_e583]));
                                param_911 = _e586;
                                let _e587 = getCloudKind_u0028_u1_u003b((&param_911));
                                if (_e587 != 0u) {
                                    let _e589 = clump;
                                    clump = (_e589 + bitcast<u32>(1i));
                                }
                                continue;
                            } else {
                                break;
                            }
                            continuing {
                                let _e592 = z_6;
                                z_6 = (_e592 + 1i);
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e594 = y_2;
                        y_2 = (_e594 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e596 = x_5;
                x_5 = (_e596 + 1i);
            }
        }
        let _e598 = clump;
        let _e600 = tuning.cloudClumpThreshold;
        if (_e598 >= _e600) {
            isClumped_2 = true;
        }
    }
    let _e602 = isClumped_2;
    if _e602 {
        let _e603 = idx_4;
        let _e606 = cell;
        let _e607 = cell;
        param_912 = _e607;
        let _e608 = getCloudWait_u0028_u1_u003b((&param_912));
        let _e609 = sleep_3;
        let _e612 = kind_1;
        param_913 = _e612;
        param_914 = _e608;
        param_915 = min((_e609 + 1u), 255u);
        let _e613 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_913), (&param_914), (&param_915));
        let _e614 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e603]), _e606, _e613);
        return;
    }
    let _e616 = (*pos_20);
    upPos_2 = (_e616 + vec3<i32>(0i, 1i, 0i));
    let _e618 = upPos_2;
    param_916 = _e618;
    let _e619 = getIndex_u0028_vi3_u003b((&param_916));
    upIndex_1 = _e619;
    let _e620 = upPos_2;
    param_917 = _e620;
    let _e621 = cloudCellInBounds_u0028_vi3_u003b((&param_917));
    phi_9193_ = _e621;
    if _e621 {
        let _e622 = upIndex_1;
        let _e625 = atomicLoad((&unnamed_2.cloudCells[_e622]));
        param_918 = _e625;
        let _e626 = getCloudKind_u0028_u1_u003b((&param_918));
        phi_9193_ = (_e626 == 0u);
    }
    let _e629 = phi_9193_;
    if _e629 {
        let _e630 = cell;
        param_919 = _e630;
        let _e631 = getCloudWait_u0028_u1_u003b((&param_919));
        let _e632 = kind_1;
        param_920 = _e632;
        param_921 = _e631;
        param_922 = 0u;
        let _e633 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_920), (&param_921), (&param_922));
        let _e634 = idx_4;
        param_923 = _e634;
        param_924 = _e633;
        let _e635 = upIndex_1;
        param_925 = _e635;
        let _e636 = cell;
        param_926 = _e636;
        let _e637 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_923), (&param_924), (&param_925), (&param_926));
        if _e637 {
            let _e639 = atomicAdd((&unnamed_1.cloudChangedCount), 1u);
            return;
        }
    }
    let _e640 = randVal_14;
    dir_7 = select(-1i, 1i, (fract((_e640 * 10f)) > 0.5f));
    let _e645 = randVal_14;
    if (fract((_e645 * 100f)) > 0.5f) {
        let _e649 = (*pos_20);
        let _e650 = dir_7;
        slide1_ = (_e649 + vec3<i32>(_e650, 1i, 0i));
        let _e653 = (*pos_20);
        let _e654 = dir_7;
        slide2_ = (_e653 + vec3<i32>(0i, 1i, _e654));
    } else {
        let _e657 = (*pos_20);
        let _e658 = dir_7;
        slide1_ = (_e657 + vec3<i32>(0i, 1i, _e658));
        let _e661 = (*pos_20);
        let _e662 = dir_7;
        slide2_ = (_e661 + vec3<i32>(_e662, 1i, 0i));
    }
    i_28 = 0i;
    loop {
        let _e665 = i_28;
        if (_e665 < 2i) {
            let _e667 = i_28;
            let _e669 = slide1_;
            let _e670 = slide2_;
            t_5 = select(_e670, _e669, vec3((_e667 == 0i)));
            let _e673 = t_5;
            param_927 = _e673;
            let _e674 = cloudCellInBounds_u0028_vi3_u003b((&param_927));
            if !(_e674) {
                continue;
            }
            let _e676 = t_5;
            param_928 = _e676;
            let _e677 = getIndex_u0028_vi3_u003b((&param_928));
            tIndex = _e677;
            let _e678 = tIndex;
            let _e681 = atomicLoad((&unnamed_2.cloudCells[_e678]));
            param_929 = _e681;
            let _e682 = getCloudKind_u0028_u1_u003b((&param_929));
            if (_e682 != 0u) {
                continue;
            }
            let _e684 = cell;
            param_930 = _e684;
            let _e685 = getCloudWait_u0028_u1_u003b((&param_930));
            let _e686 = kind_1;
            param_931 = _e686;
            param_932 = _e685;
            param_933 = 0u;
            let _e687 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_931), (&param_932), (&param_933));
            let _e688 = idx_4;
            param_934 = _e688;
            param_935 = _e687;
            let _e689 = tIndex;
            param_936 = _e689;
            let _e690 = cell;
            param_937 = _e690;
            let _e691 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_934), (&param_935), (&param_936), (&param_937));
            if _e691 {
                let _e693 = atomicAdd((&unnamed_1.cloudChangedCount), 1u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e694 = i_28;
            i_28 = (_e694 + 1i);
        }
    }
    let _e696 = idx_4;
    let _e699 = cell;
    let _e700 = cell;
    param_938 = _e700;
    let _e701 = getCloudWait_u0028_u1_u003b((&param_938));
    let _e702 = sleep_3;
    let _e705 = kind_1;
    param_939 = _e705;
    param_940 = _e701;
    param_941 = min((_e702 + 1u), 255u);
    let _e706 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_939), (&param_940), (&param_941));
    let _e707 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e696]), _e699, _e706);
    return;
}

fn updateSimState_u0028_() {
    var live: u32;
    var i_29: i32;
    var code_6: u32;
    var voxel: u32;
    var param_942: u32;
    var param_943: u32;
    var starve: u32;
    var purge_2: bool;
    var param_944: u32;
    var grace: u32;
    var local_33: u32;
    var decay: u32;
    var local_34: u32;
    var mass_2: u32;
    var param_945: u32;
    var param_946: u32;
    var liveClouds: u32;
    var chargeTarget: f32;
    var charge: f32;
    var crossedTime: f32;
    var phi_8058_: bool;
    var phi_8065_: bool;
    var phi_8238_: bool;

    let _e219 = gl_GlobalInvocationID_1[0u];
    let _e220 = (_e219 != 0u);
    phi_8058_ = _e220;
    if !(_e220) {
        let _e223 = gl_GlobalInvocationID_1[1u];
        phi_8058_ = (_e223 != 0u);
    }
    let _e226 = phi_8058_;
    phi_8065_ = _e226;
    if !(_e226) {
        let _e229 = gl_GlobalInvocationID_1[2u];
        phi_8065_ = (_e229 != 0u);
    }
    let _e232 = phi_8065_;
    if _e232 {
        return;
    }
    live = 0u;
    i_29 = 0i;
    loop {
        let _e233 = i_29;
        if (_e233 < 8i) {
            let _e235 = i_29;
            let _e238 = atomicLoad((&unnamed_1.blackHoles[_e235]));
            code_6 = _e238;
            let _e239 = code_6;
            if (_e239 == 0u) {
                continue;
            }
            let _e241 = code_6;
            voxel = (_e241 & 1073741823u);
            let _e243 = voxel;
            param_942 = _e243;
            let _e244 = readCell_u0028_u1_u003b((&param_942));
            param_943 = _e244;
            let _e245 = getType_u0028_u1_u003b((&param_943));
            if (_e245 != 7u) {
                let _e247 = i_29;
                atomicStore((&unnamed_1.blackHoles[_e247]), 0u);
                continue;
            }
            let _e250 = i_29;
            let _e253 = unnamed_1.blackHoleStarve[_e250];
            starve = (_e253 + 1u);
            let _e255 = i_29;
            let _e256 = starve;
            unnamed_1.blackHoleStarve[_e255] = _e256;
            let _e259 = code_6;
            param_944 = _e259;
            let _e260 = bhIsPurge_u0028_u1_u003b((&param_944));
            purge_2 = _e260;
            let _e261 = purge_2;
            if _e261 {
                let _e263 = tuning.purgeStarveGrace;
                local_33 = _e263;
            } else {
                let _e265 = tuning.blackHoleStarveGrace;
                local_33 = _e265;
            }
            let _e266 = local_33;
            grace = _e266;
            let _e267 = purge_2;
            if _e267 {
                let _e269 = tuning.purgeDecayRate;
                local_34 = _e269;
            } else {
                let _e271 = tuning.blackHoleDecayRate;
                local_34 = _e271;
            }
            let _e272 = local_34;
            decay = _e272;
            let _e273 = starve;
            let _e274 = grace;
            if (_e273 > _e274) {
                let _e276 = i_29;
                let _e279 = atomicLoad((&unnamed_1.blackHoleMass[_e276]));
                mass_2 = _e279;
                let _e280 = mass_2;
                if (_e280 == 0u) {
                    let _e282 = voxel;
                    param_945 = _e282;
                    param_946 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_945), (&param_946));
                    let _e283 = i_29;
                    atomicStore((&unnamed_1.blackHoles[_e283]), 0u);
                    continue;
                }
                let _e286 = i_29;
                let _e287 = mass_2;
                let _e288 = mass_2;
                let _e289 = decay;
                atomicStore((&unnamed_1.blackHoleMass[_e286]), (_e287 - min(_e288, _e289)));
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
    unnamed_1.blackHoleCount = _e299;
    let _e302 = atomicLoad((&unnamed_1.maxOccupiedY));
    if (_e302 > 0u) {
        let _e305 = atomicAdd((&unnamed_1.maxOccupiedY), 4294967295u);
    }
    let _e307 = atomicLoad((&unnamed_1.rainCandidateCount));
    unnamed_1.rainCandidateEstimate = _e307;
    atomicStore((&unnamed_1.rainCandidateCount), 0u);
    let _e311 = atomicLoad((&unnamed_1.cloudChangedCount));
    if (_e311 == 0u) {
        let _e314 = unnamed_1.cloudStillTicks;
        unnamed_1.cloudStillTicks = min((_e314 + 1u), 4294967294u);
    } else {
        unnamed_1.cloudStillTicks = 0u;
    }
    let _e320 = atomicLoad((&unnamed_1.cloudBlockCount));
    liveClouds = _e320;
    atomicStore((&unnamed_1.cloudBlockCount), 0u);
    atomicStore((&unnamed_1.cloudChangedCount), 0u);
    let _e324 = unnamed_1.rainPhase;
    chargeTarget = select(1f, 0f, (_e324 == 0u));
    let _e328 = unnamed_1.cloudChargeBits;
    charge = bitcast<f32>(_e328);
    let _e330 = chargeTarget;
    let _e331 = charge;
    let _e334 = tuning.cloudChargeEaseRate;
    let _e337 = charge;
    charge = (_e337 + ((_e330 - _e331) * clamp(_e334, 0f, 1f)));
    let _e339 = charge;
    unnamed_1.cloudChargeBits = bitcast<u32>(clamp(_e339, 0f, 1f));
    let _e344 = unnamed_1.rainPhase;
    if (_e344 == 0u) {
        let _e346 = liveClouds;
        let _e347 = (_e346 > 0u);
        phi_8238_ = _e347;
        if _e347 {
            let _e349 = unnamed_1.cloudStillTicks;
            let _e351 = tuning.cloudStillTicksToStorm;
            phi_8238_ = (_e349 >= _e351);
        }
        let _e354 = phi_8238_;
        if _e354 {
            unnamed_1.rainPhase = 1u;
            let _e357 = pc.time;
            unnamed_1.rainPhaseTimeBits = bitcast<u32>(_e357);
        }
    } else {
        let _e361 = unnamed_1.rainPhase;
        if (_e361 == 1u) {
            let _e364 = unnamed_1.rainPhaseTimeBits;
            crossedTime = bitcast<f32>(_e364);
            let _e367 = pc.time;
            let _e368 = crossedTime;
            let _e371 = tuning.rainDarkenDelay;
            if ((_e367 - _e368) >= _e371) {
                unnamed_1.rainPhase = 2u;
                let _e375 = pc.time;
                unnamed_1.rainPhaseTimeBits = bitcast<u32>(_e375);
            }
        } else {
            let _e379 = unnamed_1.rainPhase;
            if (_e379 == 2u) {
                let _e381 = liveClouds;
                if (_e381 == 0u) {
                    unnamed_1.rainPhase = 0u;
                    unnamed_1.rainPhaseTimeBits = 0u;
                    unnamed_1.cloudStillTicks = 0u;
                }
            }
        }
    }
    return;
}

fn main_1() {
    var pos_21: vec3<i32>;
    var param_947: vec3<i32>;
    var param_948: vec3<i32>;
    var spawnIndex: u32;
    var param_949: vec3<i32>;
    var oldType: u32;
    var param_950: u32;
    var param_951: u32;
    var newType_3: u32;
    var param_952: vec3<i32>;
    var seedAge: u32;
    var param_953: u32;
    var local_35: u32;
    var param_954: u32;
    var param_955: u32;
    var param_956: u32;
    var param_957: u32;
    var param_958: u32;
    var param_959: u32;
    var param_960: u32;
    var param_961: u32;
    var param_962: vec3<i32>;
    var param_963: u32;
    var param_964: u32;
    var currentIndex_15: u32;
    var param_965: vec3<i32>;
    var rawValue_13: u32;
    var param_966: u32;
    var currentType_1: u32;
    var param_967: u32;
    var param_968: i32;
    var param_969: i32;
    var randVal_15: f32;
    var param_970: vec3<f32>;
    var param_971: vec3<i32>;
    var param_972: u32;
    var param_973: u32;
    var param_974: f32;
    var currentDir_6: u32;
    var param_975: u32;
    var currentSleep_7: u32;
    var param_976: u32;
    var currentAge_10: u32;
    var param_977: u32;
    var param_978: vec3<i32>;
    var param_979: u32;
    var param_980: u32;
    var param_981: u32;
    var param_982: u32;
    var param_983: f32;
    var param_984: vec3<i32>;
    var param_985: u32;
    var param_986: u32;
    var param_987: u32;
    var param_988: u32;
    var param_989: u32;
    var param_990: f32;
    var param_991: vec3<i32>;
    var param_992: u32;
    var param_993: u32;
    var param_994: u32;
    var param_995: u32;
    var param_996: u32;
    var param_997: f32;
    var param_998: vec3<i32>;
    var param_999: u32;
    var param_1000: u32;
    var param_1001: u32;
    var param_1002: u32;
    var param_1003: u32;
    var param_1004: f32;
    var param_1005: vec3<i32>;
    var param_1006: u32;
    var param_1007: u32;
    var param_1008: u32;
    var param_1009: u32;
    var param_1010: f32;
    var param_1011: vec3<i32>;
    var param_1012: u32;
    var param_1013: u32;
    var param_1014: u32;
    var param_1015: u32;
    var param_1016: u32;
    var param_1017: f32;
    var param_1018: vec3<i32>;
    var param_1019: u32;
    var param_1020: u32;
    var param_1021: u32;
    var param_1022: f32;
    var param_1023: vec3<i32>;
    var param_1024: u32;
    var param_1025: u32;
    var param_1026: u32;
    var param_1027: u32;
    var param_1028: u32;
    var param_1029: f32;
    var param_1030: vec3<i32>;
    var param_1031: u32;
    var param_1032: u32;
    var param_1033: u32;
    var param_1034: u32;
    var param_1035: f32;
    var param_1036: vec3<i32>;
    var param_1037: u32;
    var param_1038: u32;
    var param_1039: u32;
    var param_1040: f32;
    var phi_9339_: bool;
    var phi_9349_: bool;
    var phi_9365_: bool;
    var phi_9464_: bool;
    var phi_9471_: bool;
    var phi_9482_: bool;
    var phi_9489_: bool;
    var phi_9500_: bool;
    var phi_9523_: bool;
    var phi_9533_: bool;
    var phi_9591_: bool;

    let _e305 = gl_GlobalInvocationID_1;
    pos_21 = bitcast<vec3<i32>>(_e305);
    let _e308 = pos_21[0u];
    let _e310 = tuning.gridWidth;
    let _e312 = (_e308 >= bitcast<i32>(_e310));
    phi_9339_ = _e312;
    if !(_e312) {
        let _e315 = pos_21[1u];
        let _e317 = tuning.gridHeight;
        phi_9339_ = (_e315 >= bitcast<i32>(_e317));
    }
    let _e321 = phi_9339_;
    phi_9349_ = _e321;
    if !(_e321) {
        let _e324 = pos_21[2u];
        let _e326 = tuning.gridDepth;
        phi_9349_ = (_e324 >= bitcast<i32>(_e326));
    }
    let _e330 = phi_9349_;
    if _e330 {
        return;
    }
    updateSimState_u0028_();
    let _e331 = pos_21;
    param_947 = _e331;
    updateCloudBlock_u0028_vi3_u003b((&param_947));
    let _e333 = pc.spawnActive;
    let _e334 = (_e333 == 1i);
    phi_9365_ = _e334;
    if _e334 {
        let _e335 = pos_21;
        param_948 = _e335;
        let _e336 = inBrush_u0028_vi3_u003b((&param_948));
        phi_9365_ = _e336;
    }
    let _e338 = phi_9365_;
    if _e338 {
        let _e339 = pos_21;
        param_949 = _e339;
        let _e340 = getIndex_u0028_vi3_u003b((&param_949));
        spawnIndex = _e340;
        let _e341 = spawnIndex;
        param_950 = _e341;
        let _e342 = readCell_u0028_u1_u003b((&param_950));
        param_951 = _e342;
        let _e343 = getType_u0028_u1_u003b((&param_951));
        oldType = _e343;
        let _e345 = pc.spawnType;
        newType_3 = bitcast<u32>(_e345);
        let _e347 = newType_3;
        let _e349 = oldType;
        if ((_e347 != 7u) || (_e349 != 7u)) {
            let _e352 = oldType;
            let _e353 = newType_3;
            if (_e352 != _e353) {
                let _e355 = oldType;
                if (_e355 == 2u) {
                    decWater_u0028_();
                }
                let _e357 = oldType;
                if (_e357 == 7u) {
                    let _e359 = pos_21;
                    param_952 = _e359;
                    bhRelease_u0028_vi3_u003b((&param_952));
                }
                let _e360 = newType_3;
                if (_e360 == 2u) {
                    incWater_u0028_();
                }
            }
            let _e362 = newType_3;
            param_953 = _e362;
            let _e363 = isLocust_u0028_u1_u003b((&param_953));
            if _e363 {
                let _e364 = newType_3;
                param_954 = _e364;
                let _e365 = locustSpawnCount_u0028_u1_u003b((&param_954));
                local_35 = _e365;
            } else {
                let _e366 = newType_3;
                param_955 = _e366;
                let _e367 = lavaSpawnCoolness_u0028_u1_u003b((&param_955));
                local_35 = _e367;
            }
            let _e368 = local_35;
            seedAge = _e368;
            let _e369 = newType_3;
            param_956 = _e369;
            param_957 = 0u;
            param_958 = 0u;
            let _e370 = seedAge;
            param_959 = _e370;
            let _e371 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_956), (&param_957), (&param_958), (&param_959));
            let _e372 = spawnIndex;
            param_960 = _e372;
            param_961 = _e371;
            writeCell_u0028_u1_u003b_u1_u003b((&param_960), (&param_961));
            let _e373 = newType_3;
            if (_e373 == 7u) {
                let _e375 = pos_21;
                param_962 = _e375;
                let _e376 = bhRegister_u0028_vi3_u003b((&param_962));
                if !(_e376) {
                    let _e378 = spawnIndex;
                    param_963 = _e378;
                    param_964 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_963), (&param_964));
                }
            }
        }
    }
    let _e380 = pos_21[0u];
    let _e381 = (_e380 < 1i);
    phi_9464_ = _e381;
    if !(_e381) {
        let _e384 = pos_21[0u];
        let _e386 = tuning.gridWidth;
        phi_9464_ = (_e384 >= (bitcast<i32>(_e386) - 1i));
    }
    let _e391 = phi_9464_;
    phi_9471_ = _e391;
    if !(_e391) {
        let _e394 = pos_21[1u];
        phi_9471_ = (_e394 < 1i);
    }
    let _e397 = phi_9471_;
    phi_9482_ = _e397;
    if !(_e397) {
        let _e400 = pos_21[1u];
        let _e402 = tuning.gridHeight;
        phi_9482_ = (_e400 >= (bitcast<i32>(_e402) - 1i));
    }
    let _e407 = phi_9482_;
    phi_9489_ = _e407;
    if !(_e407) {
        let _e410 = pos_21[2u];
        phi_9489_ = (_e410 < 1i);
    }
    let _e413 = phi_9489_;
    phi_9500_ = _e413;
    if !(_e413) {
        let _e416 = pos_21[2u];
        let _e418 = tuning.gridDepth;
        phi_9500_ = (_e416 >= (bitcast<i32>(_e418) - 1i));
    }
    let _e423 = phi_9500_;
    if _e423 {
        return;
    }
    let _e424 = pos_21;
    param_965 = _e424;
    let _e425 = getIndex_u0028_vi3_u003b((&param_965));
    currentIndex_15 = _e425;
    let _e426 = currentIndex_15;
    param_966 = _e426;
    let _e427 = readCell_u0028_u1_u003b((&param_966));
    rawValue_13 = _e427;
    let _e428 = rawValue_13;
    param_967 = _e428;
    let _e429 = getType_u0028_u1_u003b((&param_967));
    currentType_1 = _e429;
    let _e430 = currentType_1;
    let _e431 = (_e430 == 0u);
    phi_9523_ = _e431;
    if _e431 {
        let _e433 = unnamed_1.rainPhase;
        phi_9523_ = (_e433 >= 1u);
    }
    let _e436 = phi_9523_;
    phi_9533_ = _e436;
    if _e436 {
        let _e438 = pos_21[1u];
        let _e440 = tuning.gridHeight;
        phi_9533_ = (_e438 == (bitcast<i32>(_e440) - 2i));
    }
    let _e445 = phi_9533_;
    if _e445 {
        let _e447 = pos_21[0u];
        param_968 = _e447;
        let _e449 = pos_21[2u];
        param_969 = _e449;
        let _e450 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_968), (&param_969));
        let _e454 = atomicLoad((&unnamed_1.cloudColumn[(_e450 + 2u)]));
        if (_e454 != 0u) {
            let _e457 = atomicAdd((&unnamed_1.rainCandidateCount), 1u);
        }
    }
    let _e458 = currentType_1;
    if (_e458 == 0u) {
        return;
    }
    let _e461 = pos_21[1u];
    let _e464 = atomicLoad((&unnamed_1.maxOccupiedY));
    if (bitcast<u32>(_e461) > _e464) {
        let _e468 = pos_21[1u];
        let _e470 = atomicMax((&unnamed_1.maxOccupiedY), bitcast<u32>(_e468));
    }
    let _e471 = pos_21;
    let _e474 = pc.time;
    param_970 = (vec3<f32>(_e471) + vec3(_e474));
    let _e477 = hash_u0028_vf3_u003b((&param_970));
    randVal_15 = _e477;
    let _e478 = currentType_1;
    let _e479 = (_e478 != 7u);
    phi_9591_ = _e479;
    if _e479 {
        let _e480 = pos_21;
        param_971 = _e480;
        let _e481 = currentIndex_15;
        param_972 = _e481;
        let _e482 = rawValue_13;
        param_973 = _e482;
        let _e483 = randVal_15;
        param_974 = _e483;
        let _e484 = captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b((&param_971), (&param_972), (&param_973), (&param_974));
        phi_9591_ = _e484;
    }
    let _e486 = phi_9591_;
    if _e486 {
        return;
    }
    let _e487 = currentType_1;
    let _e489 = currentType_1;
    if ((_e487 == 3u) || (_e489 == 7u)) {
        return;
    }
    let _e492 = rawValue_13;
    param_975 = _e492;
    let _e493 = getDir_u0028_u1_u003b((&param_975));
    currentDir_6 = _e493;
    let _e494 = rawValue_13;
    param_976 = _e494;
    let _e495 = getSleep_u0028_u1_u003b((&param_976));
    currentSleep_7 = _e495;
    let _e496 = rawValue_13;
    param_977 = _e496;
    let _e497 = getAge_u0028_u1_u003b((&param_977));
    currentAge_10 = _e497;
    let _e498 = currentType_1;
    switch bitcast<i32>(_e498) {
        case 1: {
            let _e500 = pos_21;
            param_978 = _e500;
            let _e501 = currentIndex_15;
            param_979 = _e501;
            let _e502 = rawValue_13;
            param_980 = _e502;
            let _e503 = currentSleep_7;
            param_981 = _e503;
            let _e504 = currentAge_10;
            param_982 = _e504;
            let _e505 = randVal_15;
            param_983 = _e505;
            updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_978), (&param_979), (&param_980), (&param_981), (&param_982), (&param_983));
            break;
        }
        case 2: {
            let _e506 = pos_21;
            param_984 = _e506;
            let _e507 = currentIndex_15;
            param_985 = _e507;
            let _e508 = rawValue_13;
            param_986 = _e508;
            let _e509 = currentDir_6;
            param_987 = _e509;
            let _e510 = currentSleep_7;
            param_988 = _e510;
            let _e511 = currentAge_10;
            param_989 = _e511;
            let _e512 = randVal_15;
            param_990 = _e512;
            updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_984), (&param_985), (&param_986), (&param_987), (&param_988), (&param_989), (&param_990));
            break;
        }
        case 4: {
            let _e513 = pos_21;
            param_991 = _e513;
            let _e514 = currentIndex_15;
            param_992 = _e514;
            let _e515 = rawValue_13;
            param_993 = _e515;
            let _e516 = currentDir_6;
            param_994 = _e516;
            let _e517 = currentSleep_7;
            param_995 = _e517;
            let _e518 = currentAge_10;
            param_996 = _e518;
            let _e519 = randVal_15;
            param_997 = _e519;
            updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_991), (&param_992), (&param_993), (&param_994), (&param_995), (&param_996), (&param_997));
            break;
        }
        case 5: {
            let _e520 = pos_21;
            param_998 = _e520;
            let _e521 = currentIndex_15;
            param_999 = _e521;
            let _e522 = rawValue_13;
            param_1000 = _e522;
            let _e523 = currentDir_6;
            param_1001 = _e523;
            let _e524 = currentSleep_7;
            param_1002 = _e524;
            let _e525 = currentAge_10;
            param_1003 = _e525;
            let _e526 = randVal_15;
            param_1004 = _e526;
            updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_998), (&param_999), (&param_1000), (&param_1001), (&param_1002), (&param_1003), (&param_1004));
            break;
        }
        case 6: {
            let _e527 = pos_21;
            param_1005 = _e527;
            let _e528 = currentIndex_15;
            param_1006 = _e528;
            let _e529 = rawValue_13;
            param_1007 = _e529;
            let _e530 = currentSleep_7;
            param_1008 = _e530;
            let _e531 = currentAge_10;
            param_1009 = _e531;
            let _e532 = randVal_15;
            param_1010 = _e532;
            updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1005), (&param_1006), (&param_1007), (&param_1008), (&param_1009), (&param_1010));
            break;
        }
        case 9, 10, 11, 8: {
            let _e533 = pos_21;
            param_1011 = _e533;
            let _e534 = currentIndex_15;
            param_1012 = _e534;
            let _e535 = rawValue_13;
            param_1013 = _e535;
            let _e536 = currentDir_6;
            param_1014 = _e536;
            let _e537 = currentSleep_7;
            param_1015 = _e537;
            let _e538 = currentAge_10;
            param_1016 = _e538;
            let _e539 = randVal_15;
            param_1017 = _e539;
            updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1011), (&param_1012), (&param_1013), (&param_1014), (&param_1015), (&param_1016), (&param_1017));
            break;
        }
        case 12: {
            let _e540 = pos_21;
            param_1018 = _e540;
            let _e541 = currentIndex_15;
            param_1019 = _e541;
            let _e542 = rawValue_13;
            param_1020 = _e542;
            let _e543 = currentAge_10;
            param_1021 = _e543;
            let _e544 = randVal_15;
            param_1022 = _e544;
            updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1018), (&param_1019), (&param_1020), (&param_1021), (&param_1022));
            break;
        }
        case 14, 15, 16, 17, 13: {
            let _e545 = pos_21;
            param_1023 = _e545;
            let _e546 = currentIndex_15;
            param_1024 = _e546;
            let _e547 = rawValue_13;
            param_1025 = _e547;
            let _e548 = currentDir_6;
            param_1026 = _e548;
            let _e549 = currentSleep_7;
            param_1027 = _e549;
            let _e550 = currentAge_10;
            param_1028 = _e550;
            let _e551 = randVal_15;
            param_1029 = _e551;
            updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1023), (&param_1024), (&param_1025), (&param_1026), (&param_1027), (&param_1028), (&param_1029));
            break;
        }
        case 18: {
            let _e552 = pos_21;
            param_1030 = _e552;
            let _e553 = currentIndex_15;
            param_1031 = _e553;
            let _e554 = rawValue_13;
            param_1032 = _e554;
            let _e555 = currentDir_6;
            param_1033 = _e555;
            let _e556 = currentAge_10;
            param_1034 = _e556;
            let _e557 = randVal_15;
            param_1035 = _e557;
            updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1030), (&param_1031), (&param_1032), (&param_1033), (&param_1034), (&param_1035));
            break;
        }
        case 19: {
            let _e558 = pos_21;
            param_1036 = _e558;
            let _e559 = currentIndex_15;
            param_1037 = _e559;
            let _e560 = rawValue_13;
            param_1038 = _e560;
            let _e561 = currentAge_10;
            param_1039 = _e561;
            let _e562 = randVal_15;
            param_1040 = _e562;
            updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1036), (&param_1037), (&param_1038), (&param_1039), (&param_1040));
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
