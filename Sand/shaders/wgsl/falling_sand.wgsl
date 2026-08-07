// GENERATED FILE -- DO NOT EDIT.
//
// Translated from falling_sand.comp by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit falling_sand.comp and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 7151c3af765300452dc378f5df372d6b62917a2ce95005d5fb873b3a8b73cacd

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
    cloudMovedCount: atomic<u32>,
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
    let _e194 = (*val);
    return ((_e194 >> bitcast<u32>(24i)) & 255u);
}

fn getDir_u0028_u1_u003b(val_1: ptr<function, u32>) -> u32 {
    let _e194 = (*val_1);
    return ((_e194 >> bitcast<u32>(8i)) & 255u);
}

fn getType_u0028_u1_u003b(val_2: ptr<function, u32>) -> u32 {
    let _e194 = (*val_2);
    return (_e194 & 255u);
}

fn tree26_u0028_i1_u003b(i: ptr<function, i32>) -> vec3<i32> {
    var j: i32;
    var local: i32;

    let _e196 = (*i);
    if (_e196 >= 13i) {
        let _e198 = (*i);
        local = (_e198 + 1i);
    } else {
        let _e200 = (*i);
        local = _e200;
    }
    let _e201 = local;
    j = _e201;
    let _e202 = j;
    let _e210 = j;
    let _e211 = (_e210 / 3i);
    let _e219 = j;
    return (vec3<i32>((_e202 - (i32(floor((f32(_e202) / f32(3i)))) * 3i)), (_e211 - (i32(floor((f32(_e211) / f32(3i)))) * 3i)), (_e219 / 9i)) - vec3<i32>(1i, 1i, 1i));
}

fn readCell_u0028_u1_u003b(index: ptr<function, u32>) -> u32 {
    let _e194 = (*index);
    let _e197 = atomicLoad((&unnamed.grid[_e194]));
    return _e197;
}

fn tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex: ptr<function, u32>, currentValue: ptr<function, u32>, targetIndex: ptr<function, u32>, newValue: ptr<function, u32>) -> bool {
    var targetValue: u32;
    var param: u32;
    var targetType: u32;
    var param_1: u32;
    var currentType: u32;
    var param_2: u32;
    var actual: u32;
    var phi_1507_: bool;
    var phi_1516_: bool;

    let _e204 = (*targetIndex);
    param = _e204;
    let _e205 = readCell_u0028_u1_u003b((&param));
    targetValue = _e205;
    let _e206 = targetValue;
    param_1 = _e206;
    let _e207 = getType_u0028_u1_u003b((&param_1));
    targetType = _e207;
    let _e208 = (*currentValue);
    param_2 = _e208;
    let _e209 = getType_u0028_u1_u003b((&param_2));
    currentType = _e209;
    let _e210 = targetType;
    let _e211 = (_e210 == 0u);
    phi_1507_ = _e211;
    if !(_e211) {
        let _e213 = currentType;
        let _e215 = currentType;
        let _e218 = targetType;
        phi_1507_ = (((_e213 == 1u) || (_e215 == 4u)) && (_e218 == 2u));
    }
    let _e222 = phi_1507_;
    phi_1516_ = _e222;
    if !(_e222) {
        let _e224 = currentType;
        let _e226 = targetType;
        phi_1516_ = ((_e224 == 6u) && (_e226 == 5u));
    }
    let _e230 = phi_1516_;
    if _e230 {
        let _e231 = (*currentIndex);
        let _e234 = (*currentValue);
        let _e235 = atomicCompareExchangeWeak((&unnamed.grid[_e231]), _e234, 0u);
        let _e237 = (*currentValue);
        if (_e235.old_value == _e237) {
            let _e239 = (*targetIndex);
            let _e242 = targetValue;
            let _e243 = (*newValue);
            let _e244 = atomicCompareExchangeWeak((&unnamed.grid[_e239]), _e242, _e243);
            actual = _e244.old_value;
            let _e246 = actual;
            let _e247 = targetValue;
            if (_e246 == _e247) {
                let _e249 = targetType;
                if (_e249 != 0u) {
                    let _e251 = (*currentIndex);
                    let _e254 = targetValue;
                    let _e255 = atomicExchange((&unnamed.grid[_e251]), _e254);
                }
                return true;
            } else {
                let _e256 = (*currentIndex);
                let _e259 = (*currentValue);
                let _e260 = atomicCompareExchangeWeak((&unnamed.grid[_e256]), 0u, _e259);
            }
        }
    }
    return false;
}

fn pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(type_33: ptr<function, u32>, dir: ptr<function, u32>, sleep: ptr<function, u32>, age: ptr<function, u32>) -> u32 {
    let _e197 = (*type_33);
    let _e199 = (*dir);
    let _e204 = (*sleep);
    let _e209 = (*age);
    return ((((_e197 & 255u) | ((_e199 & 255u) << bitcast<u32>(8i))) | ((_e204 & 255u) << bitcast<u32>(16i))) | ((_e209 & 255u) << bitcast<u32>(24i)));
}

fn getIndex_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    let _e195 = (*pos)[0u];
    let _e197 = (*pos)[1u];
    let _e199 = tuning.gridWidth;
    let _e204 = (*pos)[2u];
    let _e206 = tuning.gridWidth;
    let _e210 = tuning.gridHeight;
    return bitcast<u32>(((_e195 + (_e197 * bitcast<i32>(_e199))) + ((_e204 * bitcast<i32>(_e206)) * bitcast<i32>(_e210))));
}

fn treeInBounds_u0028_vi3_u003b(p: ptr<function, vec3<i32>>) -> bool {
    var phi_998_: bool;
    var phi_1004_: bool;
    var phi_1014_: bool;
    var phi_1020_: bool;
    var phi_1030_: bool;

    let _e195 = (*p)[0u];
    let _e196 = (_e195 > 0i);
    phi_998_ = _e196;
    if _e196 {
        let _e198 = (*p)[0u];
        let _e200 = tuning.gridWidth;
        phi_998_ = (_e198 < (bitcast<i32>(_e200) - 1i));
    }
    let _e205 = phi_998_;
    phi_1004_ = _e205;
    if _e205 {
        let _e207 = (*p)[1u];
        phi_1004_ = (_e207 > 0i);
    }
    let _e210 = phi_1004_;
    phi_1014_ = _e210;
    if _e210 {
        let _e212 = (*p)[1u];
        let _e214 = tuning.gridHeight;
        phi_1014_ = (_e212 < (bitcast<i32>(_e214) - 1i));
    }
    let _e219 = phi_1014_;
    phi_1020_ = _e219;
    if _e219 {
        let _e221 = (*p)[2u];
        phi_1020_ = (_e221 > 0i);
    }
    let _e224 = phi_1020_;
    phi_1030_ = _e224;
    if _e224 {
        let _e226 = (*p)[2u];
        let _e228 = tuning.gridDepth;
        phi_1030_ = (_e226 < (bitcast<i32>(_e228) - 1i));
    }
    let _e233 = phi_1030_;
    return _e233;
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
    var phi_6618_: bool;
    var phi_6702_: bool;
    var phi_6784_: bool;

    let _e244 = (*randVal);
    let _e248 = tuning.treeLeafTickChance;
    if (fract((_e244 * 7f)) >= _e248) {
        return;
    }
    let _e250 = (*currentAge);
    if (_e250 == 255u) {
        let _e252 = (*pos_1);
        belowPos = (_e252 + vec3<i32>(0i, -1i, 0i));
        let _e254 = belowPos;
        param_3 = _e254;
        let _e255 = treeInBounds_u0028_vi3_u003b((&param_3));
        phi_6618_ = _e255;
        if _e255 {
            let _e256 = belowPos;
            param_4 = _e256;
            let _e257 = getIndex_u0028_vi3_u003b((&param_4));
            param_5 = _e257;
            let _e258 = readCell_u0028_u1_u003b((&param_5));
            phi_6618_ = (_e258 == 0u);
        }
        let _e261 = phi_6618_;
        if _e261 {
            let _e262 = belowPos;
            param_6 = _e262;
            let _e263 = getIndex_u0028_vi3_u003b((&param_6));
            param_7 = 19u;
            param_8 = 0u;
            param_9 = 0u;
            param_10 = 255u;
            let _e264 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_7), (&param_8), (&param_9), (&param_10));
            let _e265 = (*currentIndex_1);
            param_11 = _e265;
            let _e266 = (*rawValue);
            param_12 = _e266;
            param_13 = _e263;
            param_14 = _e264;
            let _e267 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_11), (&param_12), (&param_13), (&param_14));
            if _e267 {
                return;
            }
        }
        let _e268 = (*currentIndex_1);
        let _e271 = (*rawValue);
        let _e272 = atomicCompareExchangeWeak((&unnamed.grid[_e268]), _e271, 0u);
        return;
    }
    let _e274 = (*currentAge);
    dist = _e274;
    nearest = 255u;
    touchesTrunk = false;
    let _e275 = (*randVal);
    start = i32((fract((_e275 * 71f)) * 26f));
    haveSpot = false;
    let _e280 = (*pos_1);
    spot = _e280;
    i_1 = 0i;
    loop {
        let _e281 = i_1;
        if (_e281 < 26i) {
            let _e283 = (*pos_1);
            let _e284 = start;
            let _e285 = i_1;
            let _e286 = (_e284 + _e285);
            param_15 = (_e286 - (i32(floor((f32(_e286) / f32(26i)))) * 26i));
            let _e294 = tree26_u0028_i1_u003b((&param_15));
            c = (_e283 + _e294);
            let _e296 = c;
            param_16 = _e296;
            let _e297 = treeInBounds_u0028_vi3_u003b((&param_16));
            if !(_e297) {
                continue;
            }
            let _e299 = c;
            param_17 = _e299;
            let _e300 = getIndex_u0028_vi3_u003b((&param_17));
            param_18 = _e300;
            let _e301 = readCell_u0028_u1_u003b((&param_18));
            v = _e301;
            let _e302 = v;
            param_19 = _e302;
            let _e303 = getType_u0028_u1_u003b((&param_19));
            t = _e303;
            let _e304 = t;
            let _e305 = (_e304 == 18u);
            phi_6702_ = _e305;
            if _e305 {
                let _e306 = v;
                param_20 = _e306;
                let _e307 = getDir_u0028_u1_u003b((&param_20));
                let _e310 = tuning.treeMaxHeight;
                phi_6702_ = ((_e307 + 1u) >= _e310);
            }
            let _e313 = phi_6702_;
            if _e313 {
                touchesTrunk = true;
            } else {
                let _e314 = t;
                if (_e314 == 19u) {
                    let _e316 = nearest;
                    let _e317 = v;
                    param_21 = _e317;
                    let _e318 = getAge_u0028_u1_u003b((&param_21));
                    nearest = min(_e316, _e318);
                } else {
                    let _e320 = v;
                    let _e322 = haveSpot;
                    if ((_e320 == 0u) && !(_e322)) {
                        haveSpot = true;
                        let _e325 = c;
                        spot = _e325;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e326 = i_1;
            i_1 = (_e326 + 1i);
        }
    }
    let _e328 = touchesTrunk;
    if _e328 {
        local_1 = 1u;
    } else {
        let _e329 = nearest;
        if (_e329 >= 255u) {
            local_2 = 255u;
        } else {
            let _e331 = nearest;
            local_2 = (_e331 + 1u);
        }
        let _e333 = local_2;
        local_1 = _e333;
    }
    let _e334 = local_1;
    supported = _e334;
    let _e335 = supported;
    let _e337 = tuning.treeLeafReach;
    if (_e335 > _e337) {
        let _e339 = (*randVal);
        let _e343 = tuning.treeLeafFallChance;
        if (fract((_e339 * 83f)) < _e343) {
            let _e345 = (*currentIndex_1);
            let _e348 = (*rawValue);
            param_22 = 19u;
            param_23 = 0u;
            param_24 = 0u;
            param_25 = 255u;
            let _e349 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_22), (&param_23), (&param_24), (&param_25));
            let _e350 = atomicCompareExchangeWeak((&unnamed.grid[_e345]), _e348, _e349);
        }
        return;
    }
    let _e352 = supported;
    let _e354 = tuning.treeLeafReach;
    let _e356 = haveSpot;
    let _e357 = ((_e352 < _e354) && _e356);
    phi_6784_ = _e357;
    if _e357 {
        let _e358 = (*randVal);
        let _e362 = tuning.treeLeafSpreadChance;
        phi_6784_ = (fract((_e358 * 89f)) < _e362);
    }
    let _e365 = phi_6784_;
    if _e365 {
        let _e366 = spot;
        param_26 = _e366;
        let _e367 = getIndex_u0028_vi3_u003b((&param_26));
        let _e370 = supported;
        param_27 = 19u;
        param_28 = 0u;
        param_29 = 0u;
        param_30 = (_e370 + 1u);
        let _e372 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_27), (&param_28), (&param_29), (&param_30));
        let _e373 = atomicCompareExchangeWeak((&unnamed.grid[_e367]), 0u, _e372);
    }
    let _e375 = supported;
    let _e376 = dist;
    if (_e375 != _e376) {
        let _e378 = (*currentIndex_1);
        let _e381 = (*rawValue);
        param_31 = 19u;
        param_32 = 0u;
        param_33 = 0u;
        let _e382 = supported;
        param_34 = _e382;
        let _e383 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_31), (&param_32), (&param_33), (&param_34));
        let _e384 = atomicCompareExchangeWeak((&unnamed.grid[_e378]), _e381, _e383);
    }
    return;
}

fn isGrassBlock_u0028_u1_u003b(value: ptr<function, u32>) -> bool {
    var flora: u32;
    var param_35: u32;

    let _e196 = (*value);
    flora = ((_e196 >> bitcast<u32>(8i)) & 255u);
    let _e200 = (*value);
    param_35 = _e200;
    let _e201 = getType_u0028_u1_u003b((&param_35));
    let _e203 = flora;
    let _e206 = flora;
    return (((_e201 == 4u) && (_e203 > 10u)) && (_e206 <= 100u));
}

fn getSleep_u0028_u1_u003b(val_3: ptr<function, u32>) -> u32 {
    let _e194 = (*val_3);
    return ((_e194 >> bitcast<u32>(16i)) & 255u);
}

fn getHDir_u0028_i1_u003b(d: ptr<function, i32>) -> vec3<i32> {
    let _e194 = (*d);
    if (_e194 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e196 = (*d);
    if (_e196 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e198 = (*d);
    if (_e198 == 2i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    let _e200 = (*d);
    if (_e200 == 3i) {
        return vec3<i32>(0i, 0i, -1i);
    }
    let _e202 = (*d);
    if (_e202 == 4i) {
        return vec3<i32>(1i, 0i, 1i);
    }
    let _e204 = (*d);
    if (_e204 == 5i) {
        return vec3<i32>(1i, 0i, -1i);
    }
    let _e206 = (*d);
    if (_e206 == 6i) {
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
    var phi_6172_: bool;
    var phi_6316_: bool;
    var phi_6326_: bool;
    var phi_6371_: bool;
    var phi_6422_: bool;
    var phi_6501_: bool;

    let _e279 = (*currentDir);
    height = _e279;
    let _e280 = (*currentAge_1);
    water = _e280;
    changed = false;
    let _e281 = water;
    let _e283 = tuning.treeWaterMax;
    let _e284 = (_e281 < _e283);
    phi_6172_ = _e284;
    if _e284 {
        let _e285 = (*randVal_1);
        let _e289 = tuning.treeDrinkChance;
        phi_6172_ = (fract((_e285 * 13f)) < _e289);
    }
    let _e292 = phi_6172_;
    if _e292 {
        let _e293 = (*randVal_1);
        start_1 = i32((fract((_e293 * 101f)) * 17f));
        k = 0i;
        loop {
            let _e298 = k;
            if (_e298 < 17i) {
                let _e300 = start_1;
                let _e301 = k;
                let _e302 = (_e300 + _e301);
                i_2 = (_e302 - (i32(floor((f32(_e302) / f32(17i)))) * 17i));
                let _e310 = i_2;
                if (_e310 == 0i) {
                    let _e312 = (*pos_2);
                    local_3 = (_e312 + vec3<i32>(0i, -1i, 0i));
                } else {
                    let _e314 = i_2;
                    if (_e314 < 9i) {
                        let _e316 = (*pos_2);
                        let _e317 = i_2;
                        param_36 = (_e317 - 1i);
                        let _e319 = getHDir_u0028_i1_u003b((&param_36));
                        local_4 = ((_e316 + _e319) + vec3<i32>(0i, -1i, 0i));
                    } else {
                        let _e322 = (*pos_2);
                        let _e323 = i_2;
                        param_37 = (_e323 - 9i);
                        let _e325 = getHDir_u0028_i1_u003b((&param_37));
                        local_4 = (_e322 + _e325);
                    }
                    let _e327 = local_4;
                    local_3 = _e327;
                }
                let _e328 = local_3;
                c_1 = _e328;
                let _e329 = c_1;
                param_38 = _e329;
                let _e330 = treeInBounds_u0028_vi3_u003b((&param_38));
                if !(_e330) {
                    continue;
                }
                let _e332 = c_1;
                param_39 = _e332;
                let _e333 = getIndex_u0028_vi3_u003b((&param_39));
                idx = _e333;
                let _e334 = idx;
                param_40 = _e334;
                let _e335 = readCell_u0028_u1_u003b((&param_40));
                v_1 = _e335;
                let _e336 = v_1;
                param_41 = _e336;
                let _e337 = getType_u0028_u1_u003b((&param_41));
                if (_e337 != 4u) {
                    continue;
                }
                let _e339 = v_1;
                param_42 = _e339;
                let _e340 = getAge_u0028_u1_u003b((&param_42));
                moisture = _e340;
                let _e341 = moisture;
                let _e343 = tuning.treeSoilReserve;
                if (_e341 <= _e343) {
                    continue;
                }
                let _e345 = idx;
                let _e348 = v_1;
                let _e349 = v_1;
                param_43 = _e349;
                let _e350 = getDir_u0028_u1_u003b((&param_43));
                let _e351 = v_1;
                param_44 = _e351;
                let _e352 = getSleep_u0028_u1_u003b((&param_44));
                let _e353 = moisture;
                param_45 = 4u;
                param_46 = _e350;
                param_47 = _e352;
                param_48 = (_e353 - 1u);
                let _e355 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_45), (&param_46), (&param_47), (&param_48));
                let _e356 = atomicCompareExchangeWeak((&unnamed.grid[_e345]), _e348, _e355);
                let _e358 = v_1;
                if (_e356.old_value == _e358) {
                    let _e360 = water;
                    water = (_e360 + 1u);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e362 = k;
                k = (_e362 + 1i);
            }
        }
    }
    let _e364 = (*pos_2);
    upPos = (_e364 + vec3<i32>(0i, 1i, 0i));
    upIsTrunk = false;
    upValue = 0u;
    upIndex = 0u;
    let _e366 = upPos;
    param_49 = _e366;
    let _e367 = treeInBounds_u0028_vi3_u003b((&param_49));
    if _e367 {
        let _e368 = upPos;
        param_50 = _e368;
        let _e369 = getIndex_u0028_vi3_u003b((&param_50));
        upIndex = _e369;
        let _e370 = upIndex;
        param_51 = _e370;
        let _e371 = readCell_u0028_u1_u003b((&param_51));
        upValue = _e371;
        let _e372 = upValue;
        param_52 = _e372;
        let _e373 = getType_u0028_u1_u003b((&param_52));
        upIsTrunk = (_e373 == 18u);
    }
    let _e375 = upIsTrunk;
    let _e376 = water;
    let _e378 = (_e375 && (_e376 > 0u));
    phi_6316_ = _e378;
    if _e378 {
        let _e379 = upValue;
        param_53 = _e379;
        let _e380 = getAge_u0028_u1_u003b((&param_53));
        phi_6316_ = (_e380 < 255u);
    }
    let _e383 = phi_6316_;
    phi_6326_ = _e383;
    if _e383 {
        let _e384 = (*randVal_1);
        let _e388 = tuning.treeFlowChance;
        phi_6326_ = (fract((_e384 * 29f)) < _e388);
    }
    let _e391 = phi_6326_;
    if _e391 {
        let _e392 = upValue;
        param_54 = _e392;
        let _e393 = getDir_u0028_u1_u003b((&param_54));
        let _e394 = upValue;
        param_55 = _e394;
        let _e395 = getAge_u0028_u1_u003b((&param_55));
        param_56 = 18u;
        param_57 = _e393;
        param_58 = 0u;
        param_59 = (_e395 + 1u);
        let _e397 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_56), (&param_57), (&param_58), (&param_59));
        lifted = _e397;
        let _e398 = upIndex;
        let _e401 = upValue;
        let _e402 = lifted;
        let _e403 = atomicCompareExchangeWeak((&unnamed.grid[_e398]), _e401, _e402);
        let _e405 = upValue;
        if (_e403.old_value == _e405) {
            let _e407 = water;
            water = (_e407 - 1u);
            changed = true;
        }
    }
    let _e409 = height;
    let _e412 = tuning.treeMaxHeight;
    if ((_e409 + 1u) < _e412) {
        let _e414 = water;
        let _e416 = tuning.treeGrowCost;
        let _e417 = (_e414 >= _e416);
        phi_6371_ = _e417;
        if _e417 {
            let _e418 = upPos;
            param_60 = _e418;
            let _e419 = treeInBounds_u0028_vi3_u003b((&param_60));
            phi_6371_ = _e419;
        }
        let _e421 = phi_6371_;
        if _e421 {
            let _e422 = upValue;
            param_61 = _e422;
            let _e423 = getType_u0028_u1_u003b((&param_61));
            upType = _e423;
            let _e424 = upType;
            let _e426 = upType;
            if ((_e424 == 0u) || (_e426 == 19u)) {
                let _e429 = height;
                param_62 = 18u;
                param_63 = (_e429 + 1u);
                param_64 = 0u;
                param_65 = 0u;
                let _e431 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_62), (&param_63), (&param_64), (&param_65));
                sapling = _e431;
                let _e432 = upIndex;
                let _e435 = upValue;
                let _e436 = sapling;
                let _e437 = atomicCompareExchangeWeak((&unnamed.grid[_e432]), _e435, _e436);
                let _e439 = upValue;
                if (_e437.old_value == _e439) {
                    let _e442 = tuning.treeGrowCost;
                    let _e443 = water;
                    water = (_e443 - _e442);
                    changed = true;
                }
            }
        }
    } else {
        let _e445 = water;
        let _e447 = tuning.treeLeafCost;
        let _e448 = (_e445 >= _e447);
        phi_6422_ = _e448;
        if _e448 {
            let _e449 = (*randVal_1);
            let _e453 = tuning.treeLeafChance;
            phi_6422_ = (fract((_e449 * 37f)) < _e453);
        }
        let _e456 = phi_6422_;
        if _e456 {
            let _e457 = (*randVal_1);
            start_2 = i32((fract((_e457 * 43f)) * 26f));
            i_3 = 0i;
            loop {
                let _e462 = i_3;
                if (_e462 < 26i) {
                    let _e464 = (*pos_2);
                    let _e465 = start_2;
                    let _e466 = i_3;
                    let _e467 = (_e465 + _e466);
                    param_66 = (_e467 - (i32(floor((f32(_e467) / f32(26i)))) * 26i));
                    let _e475 = tree26_u0028_i1_u003b((&param_66));
                    c_2 = (_e464 + _e475);
                    let _e477 = c_2;
                    param_67 = _e477;
                    let _e478 = treeInBounds_u0028_vi3_u003b((&param_67));
                    if !(_e478) {
                        continue;
                    }
                    let _e480 = c_2;
                    param_68 = _e480;
                    let _e481 = getIndex_u0028_vi3_u003b((&param_68));
                    idx_1 = _e481;
                    let _e482 = idx_1;
                    param_69 = _e482;
                    let _e483 = readCell_u0028_u1_u003b((&param_69));
                    if (_e483 != 0u) {
                        continue;
                    }
                    let _e485 = idx_1;
                    param_70 = 19u;
                    param_71 = 0u;
                    param_72 = 0u;
                    param_73 = 1u;
                    let _e488 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_70), (&param_71), (&param_72), (&param_73));
                    let _e489 = atomicCompareExchangeWeak((&unnamed.grid[_e485]), 0u, _e488);
                    if (_e489.old_value == 0u) {
                        let _e493 = tuning.treeLeafCost;
                        let _e494 = water;
                        water = (_e494 - _e493);
                        changed = true;
                        break;
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e496 = i_3;
                    i_3 = (_e496 + 1i);
                }
            }
        }
    }
    let _e498 = water;
    let _e500 = tuning.treeSpreadCost;
    let _e501 = (_e498 >= _e500);
    phi_6501_ = _e501;
    if _e501 {
        let _e502 = (*randVal_1);
        let _e506 = tuning.treeSpreadChance;
        phi_6501_ = (fract((_e502 * 59f)) < _e506);
    }
    let _e509 = phi_6501_;
    if _e509 {
        let _e510 = (*randVal_1);
        start_3 = i32((fract((_e510 * 61f)) * 8f));
        i_4 = 0i;
        loop {
            let _e515 = i_4;
            if (_e515 < 8i) {
                let _e517 = (*pos_2);
                let _e518 = start_3;
                let _e519 = i_4;
                let _e520 = (_e518 + _e519);
                param_74 = (_e520 - (i32(floor((f32(_e520) / f32(8i)))) * 8i));
                let _e528 = getHDir_u0028_i1_u003b((&param_74));
                c_3 = (_e517 + _e528);
                let _e530 = c_3;
                param_75 = _e530;
                let _e531 = treeInBounds_u0028_vi3_u003b((&param_75));
                if !(_e531) {
                    continue;
                }
                let _e533 = c_3;
                param_76 = _e533;
                let _e534 = getIndex_u0028_vi3_u003b((&param_76));
                idx_2 = _e534;
                let _e535 = idx_2;
                param_77 = _e535;
                let _e536 = readCell_u0028_u1_u003b((&param_77));
                if (_e536 != 0u) {
                    continue;
                }
                let _e538 = c_3;
                param_78 = (_e538 + vec3<i32>(0i, -1i, 0i));
                let _e540 = getIndex_u0028_vi3_u003b((&param_78));
                param_79 = _e540;
                let _e541 = readCell_u0028_u1_u003b((&param_79));
                param_80 = _e541;
                let _e542 = isGrassBlock_u0028_u1_u003b((&param_80));
                if !(_e542) {
                    continue;
                }
                let _e544 = idx_2;
                param_81 = 18u;
                param_82 = 0u;
                param_83 = 0u;
                param_84 = 0u;
                let _e547 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_81), (&param_82), (&param_83), (&param_84));
                let _e548 = atomicCompareExchangeWeak((&unnamed.grid[_e544]), 0u, _e547);
                if (_e548.old_value == 0u) {
                    let _e552 = tuning.treeSpreadCost;
                    let _e553 = water;
                    water = (_e553 - _e552);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e555 = i_4;
                i_4 = (_e555 + 1i);
            }
        }
    }
    let _e557 = changed;
    if _e557 {
        let _e558 = (*currentIndex_2);
        let _e561 = (*rawValue_1);
        param_85 = 18u;
        let _e562 = height;
        param_86 = _e562;
        param_87 = 0u;
        let _e563 = water;
        param_88 = _e563;
        let _e564 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_85), (&param_86), (&param_87), (&param_88));
        let _e565 = atomicCompareExchangeWeak((&unnamed.grid[_e558]), _e561, _e564);
    }
    return;
}

fn locustPackNav_u0028_u1_u003b_u1_u003b(heading: ptr<function, u32>, steps: ptr<function, u32>) -> u32 {
    let _e195 = (*heading);
    let _e197 = (*steps);
    return ((_e195 & 7u) | (min(_e197, 7u) << bitcast<u32>(3i)));
}

fn locustReverse_u0028_u1_u003b(d_1: ptr<function, u32>) -> u32 {
    let _e194 = (*d_1);
    if (_e194 == 0u) {
        return 1u;
    }
    let _e196 = (*d_1);
    if (_e196 == 1u) {
        return 0u;
    }
    let _e198 = (*d_1);
    if (_e198 == 2u) {
        return 3u;
    }
    let _e200 = (*d_1);
    if (_e200 == 3u) {
        return 2u;
    }
    let _e202 = (*d_1);
    if (_e202 == 4u) {
        return 7u;
    }
    let _e204 = (*d_1);
    if (_e204 == 5u) {
        return 6u;
    }
    let _e206 = (*d_1);
    if (_e206 == 6u) {
        return 5u;
    }
    return 4u;
}

fn locustRunSteps_u0028_() -> u32 {
    let _e194 = tuning.locustRunLength;
    return clamp(_e194, 1u, 7u);
}

fn isLocustFood_u0028_u1_u003b(value_1: ptr<function, u32>) -> bool {
    var param_89: u32;
    var param_90: u32;
    var phi_789_: bool;

    let _e196 = (*value_1);
    param_89 = _e196;
    let _e197 = isGrassBlock_u0028_u1_u003b((&param_89));
    phi_789_ = _e197;
    if !(_e197) {
        let _e199 = (*value_1);
        param_90 = _e199;
        let _e200 = getType_u0028_u1_u003b((&param_90));
        phi_789_ = (_e200 == 19u);
    }
    let _e203 = phi_789_;
    return _e203;
}

fn locustFoodAt_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> bool {
    var param_91: vec3<i32>;
    var param_92: u32;
    var param_93: u32;
    var phi_804_: bool;
    var phi_811_: bool;
    var phi_821_: bool;
    var phi_828_: bool;
    var phi_838_: bool;

    let _e198 = (*p_1)[0u];
    let _e199 = (_e198 < 0i);
    phi_804_ = _e199;
    if !(_e199) {
        let _e202 = (*p_1)[0u];
        let _e204 = tuning.gridWidth;
        phi_804_ = (_e202 >= bitcast<i32>(_e204));
    }
    let _e208 = phi_804_;
    phi_811_ = _e208;
    if !(_e208) {
        let _e211 = (*p_1)[1u];
        phi_811_ = (_e211 < 0i);
    }
    let _e214 = phi_811_;
    phi_821_ = _e214;
    if !(_e214) {
        let _e217 = (*p_1)[1u];
        let _e219 = tuning.gridHeight;
        phi_821_ = (_e217 >= bitcast<i32>(_e219));
    }
    let _e223 = phi_821_;
    phi_828_ = _e223;
    if !(_e223) {
        let _e226 = (*p_1)[2u];
        phi_828_ = (_e226 < 0i);
    }
    let _e229 = phi_828_;
    phi_838_ = _e229;
    if !(_e229) {
        let _e232 = (*p_1)[2u];
        let _e234 = tuning.gridDepth;
        phi_838_ = (_e232 >= bitcast<i32>(_e234));
    }
    let _e238 = phi_838_;
    if _e238 {
        return false;
    }
    let _e239 = (*p_1);
    param_91 = _e239;
    let _e240 = getIndex_u0028_vi3_u003b((&param_91));
    param_92 = _e240;
    let _e241 = readCell_u0028_u1_u003b((&param_92));
    param_93 = _e241;
    let _e242 = isLocustFood_u0028_u1_u003b((&param_93));
    return _e242;
}

fn locustSteps_u0028_u1_u003b(dirByte: ptr<function, u32>) -> u32 {
    let _e194 = (*dirByte);
    return ((_e194 >> bitcast<u32>(3i)) & 7u);
}

fn locustHeading_u0028_u1_u003b(dirByte_1: ptr<function, u32>) -> u32 {
    let _e194 = (*dirByte_1);
    return (_e194 & 7u);
}

fn locustArriveDir_u0028_vi3_u003b_u1_u003b(dest: ptr<function, vec3<i32>>, nav: ptr<function, u32>) -> u32 {
    var param_94: vec3<i32>;

    let _e196 = (*dest);
    param_94 = (_e196 + vec3<i32>(0i, -1i, 0i));
    let _e198 = locustFoodAt_u0028_vi3_u003b((&param_94));
    let _e199 = (*nav);
    return select(_e199, 0u, _e198);
}

fn locustHasGrip_u0028_vi3_u003b(pos_3: ptr<function, vec3<i32>>) -> bool {
    var d_2: i32;
    var n: vec3<i32>;
    var param_95: i32;
    var param_96: vec3<i32>;
    var param_97: u32;
    var phi_942_: bool;
    var phi_949_: bool;
    var phi_960_: bool;

    d_2 = 0i;
    loop {
        let _e199 = d_2;
        if (_e199 < 8i) {
            let _e201 = (*pos_3);
            let _e202 = d_2;
            param_95 = _e202;
            let _e203 = getHDir_u0028_i1_u003b((&param_95));
            n = (_e201 + _e203);
            let _e206 = n[0u];
            let _e207 = (_e206 <= 0i);
            phi_942_ = _e207;
            if !(_e207) {
                let _e210 = n[0u];
                let _e212 = tuning.gridWidth;
                phi_942_ = (_e210 >= (bitcast<i32>(_e212) - 1i));
            }
            let _e217 = phi_942_;
            phi_949_ = _e217;
            if !(_e217) {
                let _e220 = n[2u];
                phi_949_ = (_e220 <= 0i);
            }
            let _e223 = phi_949_;
            phi_960_ = _e223;
            if !(_e223) {
                let _e226 = n[2u];
                let _e228 = tuning.gridDepth;
                phi_960_ = (_e226 >= (bitcast<i32>(_e228) - 1i));
            }
            let _e233 = phi_960_;
            if _e233 {
                continue;
            }
            let _e234 = n;
            param_96 = _e234;
            let _e235 = getIndex_u0028_vi3_u003b((&param_96));
            param_97 = _e235;
            let _e236 = readCell_u0028_u1_u003b((&param_97));
            if (_e236 != 0u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e238 = d_2;
            d_2 = (_e238 + 1i);
        }
    }
    return false;
}

fn locustInBounds_u0028_vi3_u003b(p_2: ptr<function, vec3<i32>>) -> bool {
    var phi_725_: bool;
    var phi_731_: bool;
    var phi_741_: bool;
    var phi_747_: bool;
    var phi_757_: bool;

    let _e195 = (*p_2)[0u];
    let _e196 = (_e195 > 0i);
    phi_725_ = _e196;
    if _e196 {
        let _e198 = (*p_2)[0u];
        let _e200 = tuning.gridWidth;
        phi_725_ = (_e198 < (bitcast<i32>(_e200) - 1i));
    }
    let _e205 = phi_725_;
    phi_731_ = _e205;
    if _e205 {
        let _e207 = (*p_2)[1u];
        phi_731_ = (_e207 > 0i);
    }
    let _e210 = phi_731_;
    phi_741_ = _e210;
    if _e210 {
        let _e212 = (*p_2)[1u];
        let _e214 = tuning.gridHeight;
        phi_741_ = (_e212 < (bitcast<i32>(_e214) - 1i));
    }
    let _e219 = phi_741_;
    phi_747_ = _e219;
    if _e219 {
        let _e221 = (*p_2)[2u];
        phi_747_ = (_e221 > 0i);
    }
    let _e224 = phi_747_;
    phi_757_ = _e224;
    if _e224 {
        let _e226 = (*p_2)[2u];
        let _e228 = tuning.gridDepth;
        phi_757_ = (_e226 < (bitcast<i32>(_e228) - 1i));
    }
    let _e233 = phi_757_;
    return _e233;
}

fn locustStage_u0028_() -> u32 {
    let _e194 = tuning.locustStageSize;
    return max(_e194, 1u);
}

fn locustTypeFor_u0028_u1_u003b(count: ptr<function, u32>) -> u32 {
    var stage: u32;
    var local_5: u32;

    let _e196 = (*count);
    if (_e196 == 0u) {
        local_5 = 0u;
    } else {
        let _e198 = (*count);
        let _e200 = locustStage_u0028_();
        local_5 = ((_e198 - 1u) / _e200);
    }
    let _e202 = local_5;
    stage = _e202;
    let _e203 = stage;
    return (13u + min(_e203, 4u));
}

fn locustMaxCount_u0028_() -> u32 {
    let _e194 = tuning.locustMaxSize;
    return max(_e194, 1u);
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

    let _e211 = tuning.locustBudSize;
    let _e212 = locustMaxCount_u0028_();
    bud = clamp(_e211, 1u, _e212);
    let _e214 = (*randVal_2);
    start_4 = i32((fract((_e214 * 31f)) * 8f));
    i_5 = 0i;
    loop {
        let _e219 = i_5;
        if (_e219 < 8i) {
            let _e221 = start_4;
            let _e222 = i_5;
            let _e223 = (_e221 + _e222);
            d_3 = (_e223 - (i32(floor((f32(_e223) / f32(8i)))) * 8i));
            let _e231 = (*pos_4);
            let _e232 = d_3;
            param_98 = _e232;
            let _e233 = getHDir_u0028_i1_u003b((&param_98));
            c_4 = (_e231 + _e233);
            let _e235 = c_4;
            param_99 = _e235;
            let _e236 = locustInBounds_u0028_vi3_u003b((&param_99));
            if !(_e236) {
                continue;
            }
            let _e238 = c_4;
            param_100 = _e238;
            let _e239 = getIndex_u0028_vi3_u003b((&param_100));
            idx_3 = _e239;
            let _e240 = idx_3;
            param_101 = _e240;
            let _e241 = readCell_u0028_u1_u003b((&param_101));
            if (_e241 != 0u) {
                continue;
            }
            let _e243 = idx_3;
            let _e246 = bud;
            param_102 = _e246;
            let _e247 = locustTypeFor_u0028_u1_u003b((&param_102));
            param_103 = _e247;
            param_104 = 0u;
            param_105 = 0u;
            let _e248 = bud;
            param_106 = _e248;
            let _e249 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_103), (&param_104), (&param_105), (&param_106));
            let _e250 = atomicCompareExchangeWeak((&unnamed.grid[_e243]), 0u, _e249);
            if (_e250.old_value == 0u) {
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e253 = i_5;
            i_5 = (_e253 + 1i);
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

    let _e200 = tuning.locustEatTicksMin;
    fast = _e200;
    let _e202 = tuning.locustEatTicksMax;
    slow = _e202;
    let _e203 = locustMaxCount_u0028_();
    cap = _e203;
    let _e204 = locustStage_u0028_();
    let _e205 = cap;
    floorCount = min(_e204, _e205);
    let _e207 = (*count_1);
    let _e208 = cap;
    if (_e207 >= _e208) {
        let _e210 = fast;
        return _e210;
    }
    let _e211 = (*count_1);
    let _e212 = floorCount;
    let _e214 = cap;
    let _e215 = floorCount;
    if ((_e211 <= _e212) || (_e214 == _e215)) {
        let _e218 = slow;
        return _e218;
    }
    let _e219 = (*count_1);
    let _e220 = floorCount;
    let _e223 = cap;
    let _e224 = floorCount;
    t_1 = (f32((_e219 - _e220)) / f32((_e223 - _e224)));
    let _e228 = slow;
    let _e230 = fast;
    let _e232 = t_1;
    return u32(round(mix(f32(_e228), f32(_e230), _e232)));
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
    var phi_7083_: bool;
    var phi_7090_: bool;
    var phi_7251_: bool;
    var phi_7270_: bool;
    var phi_7299_: bool;
    var phi_7313_: bool;
    var phi_7315_: bool;
    var phi_7407_: bool;
    var phi_7456_: bool;

    let _e377 = (*rawValue_2);
    param_107 = _e377;
    let _e378 = getType_u0028_u1_u003b((&param_107));
    type_34 = _e378;
    let _e379 = (*currentSleep);
    phase = (_e379 + 1u);
    let _e381 = phase;
    let _e383 = tuning.locustTickDispatches;
    if (_e381 < _e383) {
        let _e385 = (*currentIndex_3);
        let _e388 = (*rawValue_2);
        let _e389 = type_34;
        param_108 = _e389;
        let _e390 = (*currentDir_1);
        param_109 = _e390;
        let _e391 = phase;
        param_110 = _e391;
        let _e392 = (*currentAge_2);
        param_111 = _e392;
        let _e393 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_108), (&param_109), (&param_110), (&param_111));
        let _e394 = atomicCompareExchangeWeak((&unnamed.grid[_e385]), _e388, _e393);
        return;
    }
    let _e396 = (*currentAge_2);
    count_2 = _e396;
    let _e397 = (*pos_5);
    belowPos_1 = (_e397 + vec3<i32>(0i, -1i, 0i));
    let _e399 = belowPos_1;
    param_112 = _e399;
    let _e400 = getIndex_u0028_vi3_u003b((&param_112));
    belowIndex = _e400;
    let _e401 = belowIndex;
    param_113 = _e401;
    let _e402 = readCell_u0028_u1_u003b((&param_113));
    belowValue = _e402;
    let _e403 = belowValue;
    param_114 = _e403;
    let _e404 = isLocustFood_u0028_u1_u003b((&param_114));
    if _e404 {
        let _e405 = belowValue;
        param_115 = _e405;
        let _e406 = getType_u0028_u1_u003b((&param_115));
        onLeaf = (_e406 == 19u);
        let _e408 = count_2;
        param_116 = _e408;
        let _e409 = locustEatTicks_u0028_u1_u003b((&param_116));
        need = _e409;
        let _e410 = (*currentDir_1);
        progress = (_e410 + 1u);
        let _e412 = progress;
        let _e413 = need;
        if (_e412 < _e413) {
            let _e415 = onLeaf;
            if !(_e415) {
                let _e417 = belowValue;
                flora_1 = ((_e417 >> bitcast<u32>(8i)) & 255u);
                let _e421 = need;
                bite = max((90u / max(_e421, 1u)), 1u);
                let _e425 = flora_1;
                let _e426 = bite;
                if (_e425 > (11u + _e426)) {
                    let _e429 = flora_1;
                    let _e430 = bite;
                    local_6 = (_e429 - _e430);
                } else {
                    local_6 = 11u;
                }
                let _e432 = local_6;
                thinned = _e432;
                let _e433 = belowIndex;
                let _e436 = belowValue;
                let _e437 = belowValue;
                param_117 = _e437;
                let _e438 = getSleep_u0028_u1_u003b((&param_117));
                let _e439 = belowValue;
                param_118 = _e439;
                let _e440 = getAge_u0028_u1_u003b((&param_118));
                param_119 = 4u;
                let _e441 = thinned;
                param_120 = _e441;
                param_121 = _e438;
                param_122 = _e440;
                let _e442 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_119), (&param_120), (&param_121), (&param_122));
                let _e443 = atomicCompareExchangeWeak((&unnamed.grid[_e433]), _e436, _e442);
            }
            let _e445 = (*currentIndex_3);
            let _e448 = (*rawValue_2);
            let _e449 = type_34;
            param_123 = _e449;
            let _e450 = progress;
            param_124 = _e450;
            param_125 = 0u;
            let _e451 = count_2;
            param_126 = _e451;
            let _e452 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_123), (&param_124), (&param_125), (&param_126));
            let _e453 = atomicCompareExchangeWeak((&unnamed.grid[_e445]), _e448, _e452);
            return;
        }
        let _e455 = onLeaf;
        if _e455 {
            local_7 = 0u;
        } else {
            let _e456 = belowValue;
            param_127 = _e456;
            let _e457 = getSleep_u0028_u1_u003b((&param_127));
            let _e458 = belowValue;
            param_128 = _e458;
            let _e459 = getAge_u0028_u1_u003b((&param_128));
            param_129 = 4u;
            param_130 = 0u;
            param_131 = _e457;
            param_132 = _e459;
            let _e460 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_129), (&param_130), (&param_131), (&param_132));
            local_7 = _e460;
        }
        let _e461 = local_7;
        stripped = _e461;
        let _e462 = belowIndex;
        let _e465 = belowValue;
        let _e466 = stripped;
        let _e467 = atomicCompareExchangeWeak((&unnamed.grid[_e462]), _e465, _e466);
        let _e469 = belowValue;
        if (_e467.old_value != _e469) {
            return;
        }
        let _e471 = count_2;
        let _e473 = tuning.locustEatGain;
        grown = (_e471 + _e473);
        let _e475 = grown;
        let _e476 = locustMaxCount_u0028_();
        if (_e475 > _e476) {
            let _e478 = (*pos_5);
            param_133 = _e478;
            let _e479 = (*randVal_3);
            param_134 = _e479;
            locustBud_u0028_vi3_u003b_f1_u003b((&param_133), (&param_134));
            let _e480 = locustMaxCount_u0028_();
            grown = _e480;
        }
        let _e481 = (*currentIndex_3);
        let _e484 = (*rawValue_2);
        let _e485 = grown;
        param_135 = _e485;
        let _e486 = locustTypeFor_u0028_u1_u003b((&param_135));
        param_136 = _e486;
        param_137 = 0u;
        param_138 = 0u;
        let _e487 = grown;
        param_139 = _e487;
        let _e488 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_136), (&param_137), (&param_138), (&param_139));
        let _e489 = atomicCompareExchangeWeak((&unnamed.grid[_e481]), _e484, _e488);
        return;
    }
    let _e491 = count_2;
    if (_e491 <= 1u) {
        let _e493 = (*currentIndex_3);
        let _e496 = (*rawValue_2);
        let _e497 = atomicCompareExchangeWeak((&unnamed.grid[_e493]), _e496, 0u);
        return;
    }
    let _e499 = count_2;
    count_2 = (_e499 - 1u);
    let _e501 = count_2;
    param_140 = _e501;
    let _e502 = locustTypeFor_u0028_u1_u003b((&param_140));
    newType = _e502;
    let _e503 = belowValue;
    param_141 = _e503;
    let _e504 = getType_u0028_u1_u003b((&param_141));
    let _e505 = (_e504 == 0u);
    phi_7083_ = _e505;
    if _e505 {
        let _e506 = belowPos_1;
        param_142 = _e506;
        let _e507 = locustInBounds_u0028_vi3_u003b((&param_142));
        phi_7083_ = _e507;
    }
    let _e509 = phi_7083_;
    phi_7090_ = _e509;
    if _e509 {
        let _e510 = (*pos_5);
        param_143 = _e510;
        let _e511 = locustHasGrip_u0028_vi3_u003b((&param_143));
        phi_7090_ = !(_e511);
    }
    let _e514 = phi_7090_;
    if _e514 {
        let _e515 = belowPos_1;
        param_144 = _e515;
        let _e516 = (*currentDir_1);
        param_145 = _e516;
        let _e517 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_144), (&param_145));
        let _e518 = newType;
        param_146 = _e518;
        param_147 = _e517;
        param_148 = 0u;
        let _e519 = count_2;
        param_149 = _e519;
        let _e520 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_146), (&param_147), (&param_148), (&param_149));
        let _e521 = (*currentIndex_3);
        param_150 = _e521;
        let _e522 = (*rawValue_2);
        param_151 = _e522;
        let _e523 = belowIndex;
        param_152 = _e523;
        param_153 = _e520;
        let _e524 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_150), (&param_151), (&param_152), (&param_153));
        if _e524 {
            return;
        }
    }
    let _e525 = (*currentDir_1);
    param_154 = _e525;
    let _e526 = locustHeading_u0028_u1_u003b((&param_154));
    heading_1 = _e526;
    let _e527 = (*currentDir_1);
    param_155 = _e527;
    let _e528 = locustSteps_u0028_u1_u003b((&param_155));
    steps_1 = _e528;
    let _e529 = steps_1;
    if (_e529 == 0u) {
        let _e531 = (*randVal_3);
        start_5 = i32((fract((_e531 * 17f)) * 8f));
        i_6 = 0i;
        loop {
            let _e536 = i_6;
            if (_e536 < 8i) {
                let _e538 = start_5;
                let _e539 = i_6;
                let _e540 = (_e538 + _e539);
                d_4 = (_e540 - (i32(floor((f32(_e540) / f32(8i)))) * 8i));
                let _e548 = (*pos_5);
                let _e549 = d_4;
                param_156 = _e549;
                let _e550 = getHDir_u0028_i1_u003b((&param_156));
                c_5 = (_e548 + _e550);
                rise = 0i;
                loop {
                    let _e552 = rise;
                    if (_e552 < 3i) {
                        let _e554 = c_5;
                        let _e555 = rise;
                        if (_e555 == 1i) {
                            local_8 = 1i;
                        } else {
                            let _e557 = rise;
                            local_8 = select(0i, -1i, (_e557 == 2i));
                        }
                        let _e560 = local_8;
                        t_2 = (_e554 + vec3<i32>(0i, _e560, 0i));
                        let _e563 = t_2;
                        param_157 = _e563;
                        let _e564 = locustInBounds_u0028_vi3_u003b((&param_157));
                        if !(_e564) {
                            continue;
                        }
                        let _e566 = t_2;
                        param_158 = _e566;
                        let _e567 = getIndex_u0028_vi3_u003b((&param_158));
                        param_159 = _e567;
                        let _e568 = readCell_u0028_u1_u003b((&param_159));
                        if (_e568 != 0u) {
                            continue;
                        }
                        let _e570 = t_2;
                        param_160 = (_e570 + vec3<i32>(0i, -1i, 0i));
                        let _e572 = locustFoodAt_u0028_vi3_u003b((&param_160));
                        if !(_e572) {
                            continue;
                        }
                        let _e574 = t_2;
                        param_161 = _e574;
                        let _e575 = getIndex_u0028_vi3_u003b((&param_161));
                        let _e576 = newType;
                        param_162 = _e576;
                        param_163 = 0u;
                        param_164 = 0u;
                        let _e577 = count_2;
                        param_165 = _e577;
                        let _e578 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_162), (&param_163), (&param_164), (&param_165));
                        let _e579 = (*currentIndex_3);
                        param_166 = _e579;
                        let _e580 = (*rawValue_2);
                        param_167 = _e580;
                        param_168 = _e575;
                        param_169 = _e578;
                        let _e581 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_166), (&param_167), (&param_168), (&param_169));
                        if _e581 {
                            return;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e582 = rise;
                        rise = (_e582 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e584 = i_6;
                i_6 = (_e584 + 1i);
            }
        }
        let _e586 = (*randVal_3);
        heading_1 = (u32((fract((_e586 * 23f)) * 8f)) & 7u);
        let _e592 = locustRunSteps_u0028_();
        steps_1 = _e592;
    }
    let _e593 = (*pos_5);
    let _e594 = heading_1;
    param_170 = bitcast<i32>(_e594);
    let _e596 = getHDir_u0028_i1_u003b((&param_170));
    target_ = (_e593 + _e596);
    let _e598 = target_;
    param_171 = _e598;
    let _e599 = locustInBounds_u0028_vi3_u003b((&param_171));
    let _e600 = !(_e599);
    phi_7251_ = _e600;
    if !(_e600) {
        let _e602 = target_;
        param_172 = _e602;
        let _e603 = getIndex_u0028_vi3_u003b((&param_172));
        param_173 = _e603;
        let _e604 = readCell_u0028_u1_u003b((&param_173));
        phi_7251_ = (_e604 != 0u);
    }
    let _e607 = phi_7251_;
    blocked = _e607;
    let _e608 = blocked;
    if !(_e608) {
        let _e610 = target_;
        footing = (_e610 + vec3<i32>(0i, -1i, 0i));
        let _e612 = footing;
        param_174 = _e612;
        let _e613 = locustInBounds_u0028_vi3_u003b((&param_174));
        phi_7270_ = _e613;
        if _e613 {
            let _e614 = footing;
            param_175 = _e614;
            let _e615 = getIndex_u0028_vi3_u003b((&param_175));
            param_176 = _e615;
            let _e616 = readCell_u0028_u1_u003b((&param_176));
            phi_7270_ = (_e616 == 0u);
        }
        let _e619 = phi_7270_;
        if _e619 {
            let _e620 = heading_1;
            param_177 = _e620;
            let _e621 = locustReverse_u0028_u1_u003b((&param_177));
            back = _e621;
            let _e622 = (*pos_5);
            let _e623 = back;
            param_178 = bitcast<i32>(_e623);
            let _e625 = getHDir_u0028_i1_u003b((&param_178));
            backPos = (_e622 + _e625);
            let _e627 = backPos;
            backFoot = (_e627 + vec3<i32>(0i, -1i, 0i));
            let _e629 = backPos;
            param_179 = _e629;
            let _e630 = locustInBounds_u0028_vi3_u003b((&param_179));
            phi_7299_ = _e630;
            if _e630 {
                let _e631 = backPos;
                param_180 = _e631;
                let _e632 = getIndex_u0028_vi3_u003b((&param_180));
                param_181 = _e632;
                let _e633 = readCell_u0028_u1_u003b((&param_181));
                phi_7299_ = (_e633 == 0u);
            }
            let _e636 = phi_7299_;
            phi_7315_ = _e636;
            if _e636 {
                let _e637 = backFoot;
                param_182 = _e637;
                let _e638 = locustInBounds_u0028_vi3_u003b((&param_182));
                phi_7313_ = _e638;
                if _e638 {
                    let _e639 = backFoot;
                    param_183 = _e639;
                    let _e640 = getIndex_u0028_vi3_u003b((&param_183));
                    param_184 = _e640;
                    let _e641 = readCell_u0028_u1_u003b((&param_184));
                    phi_7313_ = (_e641 == 0u);
                }
                let _e644 = phi_7313_;
                phi_7315_ = !(_e644);
            }
            let _e647 = phi_7315_;
            backOpen = _e647;
            let _e648 = backOpen;
            if _e648 {
                let _e649 = back;
                param_185 = _e649;
                let _e650 = steps_1;
                param_186 = _e650;
                let _e651 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_185), (&param_186));
                local_9 = _e651;
            } else {
                let _e652 = (*randVal_3);
                let _e658 = locustRunSteps_u0028_();
                param_187 = (u32((fract((_e652 * 71f)) * 8f)) & 7u);
                param_188 = _e658;
                let _e659 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_187), (&param_188));
                local_9 = _e659;
            }
            let _e660 = local_9;
            turnedNav = _e660;
            let _e661 = (*currentIndex_3);
            let _e664 = (*rawValue_2);
            let _e665 = newType;
            param_189 = _e665;
            let _e666 = turnedNav;
            param_190 = _e666;
            param_191 = 0u;
            let _e667 = count_2;
            param_192 = _e667;
            let _e668 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_189), (&param_190), (&param_191), (&param_192));
            let _e669 = atomicCompareExchangeWeak((&unnamed.grid[_e661]), _e664, _e668);
            return;
        }
        let _e671 = steps_1;
        let _e673 = heading_1;
        param_193 = _e673;
        param_194 = (_e671 - 1u);
        let _e674 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_193), (&param_194));
        nav_1 = _e674;
        let _e675 = target_;
        param_195 = _e675;
        let _e676 = getIndex_u0028_vi3_u003b((&param_195));
        let _e677 = target_;
        param_196 = _e677;
        let _e678 = nav_1;
        param_197 = _e678;
        let _e679 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_196), (&param_197));
        let _e680 = newType;
        param_198 = _e680;
        param_199 = _e679;
        param_200 = 0u;
        let _e681 = count_2;
        param_201 = _e681;
        let _e682 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_198), (&param_199), (&param_200), (&param_201));
        let _e683 = (*currentIndex_3);
        param_202 = _e683;
        let _e684 = (*rawValue_2);
        param_203 = _e684;
        param_204 = _e676;
        param_205 = _e682;
        let _e685 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_202), (&param_203), (&param_204), (&param_205));
        if _e685 {
            return;
        }
    } else {
        let _e686 = (*randVal_3);
        let _e690 = tuning.locustClimbChance;
        if (fract((_e686 * 41f)) < _e690) {
            let _e692 = target_;
            overTop = (_e692 + vec3<i32>(0i, 1i, 0i));
            let _e694 = overTop;
            param_206 = _e694;
            let _e695 = locustInBounds_u0028_vi3_u003b((&param_206));
            phi_7407_ = _e695;
            if _e695 {
                let _e696 = overTop;
                param_207 = _e696;
                let _e697 = getIndex_u0028_vi3_u003b((&param_207));
                param_208 = _e697;
                let _e698 = readCell_u0028_u1_u003b((&param_208));
                phi_7407_ = (_e698 == 0u);
            }
            let _e701 = phi_7407_;
            if _e701 {
                let _e702 = steps_1;
                let _e704 = heading_1;
                param_209 = _e704;
                param_210 = (_e702 - 1u);
                let _e705 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_209), (&param_210));
                nav_2 = _e705;
                let _e706 = overTop;
                param_211 = _e706;
                let _e707 = getIndex_u0028_vi3_u003b((&param_211));
                let _e708 = overTop;
                param_212 = _e708;
                let _e709 = nav_2;
                param_213 = _e709;
                let _e710 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_212), (&param_213));
                let _e711 = newType;
                param_214 = _e711;
                param_215 = _e710;
                param_216 = 0u;
                let _e712 = count_2;
                param_217 = _e712;
                let _e713 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_214), (&param_215), (&param_216), (&param_217));
                let _e714 = (*currentIndex_3);
                param_218 = _e714;
                let _e715 = (*rawValue_2);
                param_219 = _e715;
                param_220 = _e707;
                param_221 = _e713;
                let _e716 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_218), (&param_219), (&param_220), (&param_221));
                if _e716 {
                    return;
                }
            }
            let _e717 = (*pos_5);
            up = (_e717 + vec3<i32>(0i, 1i, 0i));
            let _e719 = up;
            param_222 = _e719;
            let _e720 = locustInBounds_u0028_vi3_u003b((&param_222));
            phi_7456_ = _e720;
            if _e720 {
                let _e721 = up;
                param_223 = _e721;
                let _e722 = getIndex_u0028_vi3_u003b((&param_223));
                param_224 = _e722;
                let _e723 = readCell_u0028_u1_u003b((&param_224));
                phi_7456_ = (_e723 == 0u);
            }
            let _e726 = phi_7456_;
            if _e726 {
                let _e727 = heading_1;
                param_225 = _e727;
                let _e728 = steps_1;
                param_226 = _e728;
                let _e729 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_225), (&param_226));
                nav_3 = _e729;
                let _e730 = up;
                param_227 = _e730;
                let _e731 = getIndex_u0028_vi3_u003b((&param_227));
                let _e732 = up;
                param_228 = _e732;
                let _e733 = nav_3;
                param_229 = _e733;
                let _e734 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_228), (&param_229));
                let _e735 = newType;
                param_230 = _e735;
                param_231 = _e734;
                param_232 = 0u;
                let _e736 = count_2;
                param_233 = _e736;
                let _e737 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_230), (&param_231), (&param_232), (&param_233));
                let _e738 = (*currentIndex_3);
                param_234 = _e738;
                let _e739 = (*rawValue_2);
                param_235 = _e739;
                param_236 = _e731;
                param_237 = _e737;
                let _e740 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_234), (&param_235), (&param_236), (&param_237));
                if _e740 {
                    return;
                }
            }
        }
        let _e741 = (*randVal_3);
        heading_1 = (u32((fract((_e741 * 53f)) * 8f)) & 7u);
        let _e747 = locustRunSteps_u0028_();
        steps_1 = _e747;
    }
    let _e748 = (*currentIndex_3);
    let _e751 = (*rawValue_2);
    let _e752 = heading_1;
    param_238 = _e752;
    let _e753 = steps_1;
    param_239 = _e753;
    let _e754 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_238), (&param_239));
    let _e755 = newType;
    param_240 = _e755;
    param_241 = _e754;
    param_242 = 0u;
    let _e756 = count_2;
    param_243 = _e756;
    let _e757 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_240), (&param_241), (&param_242), (&param_243));
    let _e758 = atomicCompareExchangeWeak((&unnamed.grid[_e748]), _e751, _e757);
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
    var phi_6139_: bool;

    let _e216 = (*pos_6)[1u];
    if (_e216 > 1i) {
        let _e218 = (*pos_6);
        belowPos_2 = (_e218 + vec3<i32>(0i, -1i, 0i));
        let _e220 = belowPos_2;
        param_244 = _e220;
        let _e221 = getIndex_u0028_vi3_u003b((&param_244));
        param_245 = _e221;
        let _e222 = readCell_u0028_u1_u003b((&param_245));
        param_246 = _e222;
        let _e223 = getType_u0028_u1_u003b((&param_246));
        if (_e223 == 0u) {
            let _e225 = belowPos_2;
            param_247 = _e225;
            let _e226 = getIndex_u0028_vi3_u003b((&param_247));
            param_248 = 12u;
            param_249 = 0u;
            param_250 = 0u;
            let _e227 = (*currentAge_3);
            param_251 = _e227;
            let _e228 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_248), (&param_249), (&param_250), (&param_251));
            let _e229 = (*currentIndex_4);
            param_252 = _e229;
            let _e230 = (*rawValue_3);
            param_253 = _e230;
            param_254 = _e226;
            param_255 = _e228;
            let _e231 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_252), (&param_253), (&param_254), (&param_255));
            if _e231 {
                return;
            }
        }
    }
    let _e232 = (*currentAge_3);
    let _e233 = (_e232 > 0u);
    phi_6139_ = _e233;
    if _e233 {
        let _e234 = (*randVal_4);
        let _e238 = tuning.darkStoneDryChance;
        phi_6139_ = (fract((_e234 * 23f)) < _e238);
    }
    let _e241 = phi_6139_;
    if _e241 {
        let _e242 = (*currentIndex_4);
        let _e245 = (*rawValue_3);
        let _e246 = (*currentAge_3);
        param_256 = 12u;
        param_257 = 0u;
        param_258 = 0u;
        param_259 = (_e246 - 1u);
        let _e248 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_256), (&param_257), (&param_258), (&param_259));
        let _e249 = atomicCompareExchangeWeak((&unnamed.grid[_e242]), _e245, _e248);
    }
    return;
}

fn isLava_u0028_u1_u003b(type_35: ptr<function, u32>) -> bool {
    let _e194 = (*type_35);
    let _e196 = (*type_35);
    return ((_e194 >= 8u) && (_e196 <= 11u));
}

fn lavaTypeFor_u0028_u1_u003b(coolness: ptr<function, u32>) -> u32 {
    let _e194 = (*coolness);
    let _e196 = tuning.lavaStageSize;
    return (8u + min((_e194 / max(_e196, 1u)), 3u));
}

fn lavaSolidifyCoolness_u0028_() -> u32 {
    let _e194 = tuning.lavaStageSize;
    return min((max(_e194, 1u) * 4u), 255u);
}

fn decWater_u0028_() {
    let _e194 = atomicAdd((&unnamed_1.waterVoxelCount), 4294967295u);
    return;
}

fn getOrthoDir_u0028_i1_u003b(d_5: ptr<function, i32>) -> vec3<i32> {
    let _e194 = (*d_5);
    if (_e194 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e196 = (*d_5);
    if (_e196 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e198 = (*d_5);
    if (_e198 == 2i) {
        return vec3<i32>(0i, 1i, 0i);
    }
    let _e200 = (*d_5);
    if (_e200 == 3i) {
        return vec3<i32>(0i, -1i, 0i);
    }
    let _e202 = (*d_5);
    if (_e202 == 4i) {
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
    var phi_5193_: bool;
    var phi_5200_: bool;
    var phi_5211_: bool;
    var phi_5218_: bool;
    var phi_5229_: bool;
    var phi_5368_: bool;
    var phi_5379_: bool;

    let _e261 = (*randVal_5);
    startDir = i32((fract((_e261 * 17f)) * 6f));
    i_7 = 0i;
    loop {
        let _e266 = i_7;
        if (_e266 < 6i) {
            let _e268 = startDir;
            let _e269 = i_7;
            let _e270 = (_e268 + _e269);
            d_6 = (_e270 - (i32(floor((f32(_e270) / f32(6i)))) * 6i));
            let _e278 = (*pos_7);
            let _e279 = d_6;
            param_260 = _e279;
            let _e280 = getOrthoDir_u0028_i1_u003b((&param_260));
            nPos = (_e278 + _e280);
            let _e283 = nPos[0u];
            let _e284 = (_e283 <= 0i);
            phi_5193_ = _e284;
            if !(_e284) {
                let _e287 = nPos[0u];
                let _e289 = tuning.gridWidth;
                phi_5193_ = (_e287 >= (bitcast<i32>(_e289) - 1i));
            }
            let _e294 = phi_5193_;
            phi_5200_ = _e294;
            if !(_e294) {
                let _e297 = nPos[1u];
                phi_5200_ = (_e297 <= 0i);
            }
            let _e300 = phi_5200_;
            phi_5211_ = _e300;
            if !(_e300) {
                let _e303 = nPos[1u];
                let _e305 = tuning.gridHeight;
                phi_5211_ = (_e303 >= (bitcast<i32>(_e305) - 1i));
            }
            let _e310 = phi_5211_;
            phi_5218_ = _e310;
            if !(_e310) {
                let _e313 = nPos[2u];
                phi_5218_ = (_e313 <= 0i);
            }
            let _e316 = phi_5218_;
            phi_5229_ = _e316;
            if !(_e316) {
                let _e319 = nPos[2u];
                let _e321 = tuning.gridDepth;
                phi_5229_ = (_e319 >= (bitcast<i32>(_e321) - 1i));
            }
            let _e326 = phi_5229_;
            if _e326 {
                continue;
            }
            let _e327 = nPos;
            param_261 = _e327;
            let _e328 = getIndex_u0028_vi3_u003b((&param_261));
            nIndex = _e328;
            let _e329 = nIndex;
            param_262 = _e329;
            let _e330 = readCell_u0028_u1_u003b((&param_262));
            nVal = _e330;
            let _e331 = nVal;
            param_263 = _e331;
            let _e332 = getType_u0028_u1_u003b((&param_263));
            nType = _e332;
            let _e333 = nType;
            if (_e333 == 2u) {
                let _e335 = nIndex;
                let _e338 = nVal;
                param_264 = 6u;
                param_265 = 0u;
                param_266 = 0u;
                param_267 = 0u;
                let _e339 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_264), (&param_265), (&param_266), (&param_267));
                let _e340 = atomicCompareExchangeWeak((&unnamed.grid[_e335]), _e338, _e339);
                let _e342 = nVal;
                if (_e340.old_value == _e342) {
                    decWater_u0028_();
                    let _e344 = (*coolness_1);
                    let _e346 = tuning.lavaWaterCool;
                    (*coolness_1) = min((_e344 + _e346), 255u);
                    return;
                }
            } else {
                let _e349 = nType;
                if (_e349 == 19u) {
                    let _e351 = nIndex;
                    let _e354 = nVal;
                    let _e355 = atomicCompareExchangeWeak((&unnamed.grid[_e351]), _e354, 0u);
                    let _e357 = nVal;
                    if (_e355.old_value == _e357) {
                        return;
                    }
                } else {
                    let _e359 = nType;
                    if (_e359 == 18u) {
                        let _e361 = nIndex;
                        let _e364 = nVal;
                        param_268 = 5u;
                        param_269 = 0u;
                        param_270 = 0u;
                        param_271 = 0u;
                        let _e365 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_268), (&param_269), (&param_270), (&param_271));
                        let _e366 = atomicCompareExchangeWeak((&unnamed.grid[_e361]), _e364, _e365);
                        let _e368 = nVal;
                        if (_e366.old_value == _e368) {
                            return;
                        }
                    } else {
                        let _e370 = nType;
                        if (_e370 == 3u) {
                            let _e372 = nIndex;
                            let _e375 = nVal;
                            param_272 = 12u;
                            param_273 = 0u;
                            param_274 = 0u;
                            param_275 = 255u;
                            let _e376 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_272), (&param_273), (&param_274), (&param_275));
                            let _e377 = atomicCompareExchangeWeak((&unnamed.grid[_e372]), _e375, _e376);
                            let _e379 = nVal;
                            if (_e377.old_value == _e379) {
                                return;
                            }
                        } else {
                            let _e381 = nType;
                            let _e383 = nType;
                            if ((_e381 == 1u) || (_e383 == 4u)) {
                                let _e386 = nVal;
                                param_276 = _e386;
                                let _e387 = getAge_u0028_u1_u003b((&param_276));
                                moisture_1 = _e387;
                                let _e388 = nVal;
                                param_277 = _e388;
                                let _e389 = getDir_u0028_u1_u003b((&param_277));
                                flora_2 = _e389;
                                let _e390 = nType;
                                let _e392 = flora_2;
                                let _e395 = flora_2;
                                if (((_e390 == 4u) && (_e392 > 10u)) && (_e395 <= 100u)) {
                                    let _e398 = nPos;
                                    abovePos = (_e398 + vec3<i32>(0i, 1i, 0i));
                                    let _e401 = abovePos[1u];
                                    let _e403 = tuning.gridHeight;
                                    let _e406 = (_e401 < (bitcast<i32>(_e403) - 1i));
                                    phi_5368_ = _e406;
                                    if _e406 {
                                        let _e407 = abovePos;
                                        param_278 = _e407;
                                        let _e408 = getIndex_u0028_vi3_u003b((&param_278));
                                        param_279 = _e408;
                                        let _e409 = readCell_u0028_u1_u003b((&param_279));
                                        param_280 = _e409;
                                        let _e410 = getType_u0028_u1_u003b((&param_280));
                                        phi_5368_ = (_e410 == 0u);
                                    }
                                    let _e413 = phi_5368_;
                                    phi_5379_ = _e413;
                                    if _e413 {
                                        let _e414 = (*randVal_5);
                                        let _e418 = tuning.lavaIgniteChance;
                                        phi_5379_ = (fract((_e414 * 41f)) < _e418);
                                    }
                                    let _e421 = phi_5379_;
                                    if _e421 {
                                        let _e422 = abovePos;
                                        param_281 = _e422;
                                        let _e423 = getIndex_u0028_vi3_u003b((&param_281));
                                        param_282 = 5u;
                                        param_283 = 0u;
                                        param_284 = 0u;
                                        param_285 = 0u;
                                        let _e426 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_282), (&param_283), (&param_284), (&param_285));
                                        let _e427 = atomicCompareExchangeWeak((&unnamed.grid[_e423]), 0u, _e426);
                                        if (_e427.old_value == 0u) {
                                            return;
                                        }
                                    }
                                } else {
                                    let _e430 = moisture_1;
                                    if (_e430 > 0u) {
                                        let _e432 = nIndex;
                                        let _e435 = nVal;
                                        let _e436 = moisture_1;
                                        let _e438 = nType;
                                        param_286 = _e438;
                                        let _e439 = flora_2;
                                        param_287 = _e439;
                                        param_288 = 0u;
                                        param_289 = (_e436 - 1u);
                                        let _e440 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_286), (&param_287), (&param_288), (&param_289));
                                        let _e441 = atomicCompareExchangeWeak((&unnamed.grid[_e432]), _e435, _e440);
                                        let _e443 = nVal;
                                        if (_e441.old_value == _e443) {
                                            let _e445 = (*coolness_1);
                                            let _e447 = tuning.lavaMoistureCool;
                                            (*coolness_1) = min((_e445 + _e447), 255u);
                                            return;
                                        }
                                    } else {
                                        let _e450 = (*randVal_5);
                                        let _e454 = tuning.lavaConsumeChance;
                                        if (fract((_e450 * 53f)) < _e454) {
                                            let _e456 = nIndex;
                                            let _e459 = nVal;
                                            let _e460 = atomicCompareExchangeWeak((&unnamed.grid[_e456]), _e459, 0u);
                                            let _e462 = nVal;
                                            if (_e460.old_value == _e462) {
                                                return;
                                            }
                                        }
                                    }
                                }
                            } else {
                                let _e464 = nType;
                                param_290 = _e464;
                                let _e465 = isLava_u0028_u1_u003b((&param_290));
                                if _e465 {
                                    let _e466 = nVal;
                                    param_291 = _e466;
                                    let _e467 = getAge_u0028_u1_u003b((&param_291));
                                    nCool = _e467;
                                    let _e468 = (*coolness_1);
                                    let _e469 = nCool;
                                    if (_e468 > (_e469 + 1u)) {
                                        let _e472 = nCool;
                                        raised = (_e472 + 1u);
                                        let _e474 = raised;
                                        let _e475 = lavaSolidifyCoolness_u0028_();
                                        if (_e474 >= _e475) {
                                            local_10 = 12u;
                                        } else {
                                            let _e477 = raised;
                                            param_292 = _e477;
                                            let _e478 = lavaTypeFor_u0028_u1_u003b((&param_292));
                                            local_10 = _e478;
                                        }
                                        let _e479 = local_10;
                                        raisedType = _e479;
                                        let _e480 = nIndex;
                                        let _e483 = nVal;
                                        let _e484 = nVal;
                                        param_293 = _e484;
                                        let _e485 = getDir_u0028_u1_u003b((&param_293));
                                        let _e486 = raisedType;
                                        param_294 = _e486;
                                        param_295 = _e485;
                                        param_296 = 0u;
                                        let _e487 = raised;
                                        param_297 = _e487;
                                        let _e488 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_294), (&param_295), (&param_296), (&param_297));
                                        let _e489 = atomicCompareExchangeWeak((&unnamed.grid[_e480]), _e483, _e488);
                                        let _e491 = nVal;
                                        if (_e489.old_value == _e491) {
                                            let _e493 = (*coolness_1);
                                            (*coolness_1) = (_e493 - 1u);
                                            return;
                                        }
                                    }
                                } else {
                                    let _e495 = nType;
                                    if (_e495 == 12u) {
                                        let _e497 = nVal;
                                        param_298 = _e497;
                                        let _e498 = getAge_u0028_u1_u003b((&param_298));
                                        nCool_1 = _e498;
                                        let _e499 = nCool_1;
                                        let _e500 = (*coolness_1);
                                        draws = (_e499 > (_e500 + 1u));
                                        let _e503 = draws;
                                        if _e503 {
                                            let _e504 = nCool_1;
                                            local_11 = (_e504 - 1u);
                                        } else {
                                            let _e506 = nCool_1;
                                            local_11 = _e506;
                                        }
                                        let _e507 = local_11;
                                        lowered = _e507;
                                        let _e508 = lowered;
                                        let _e509 = lavaSolidifyCoolness_u0028_();
                                        melts = (_e508 < _e509);
                                        let _e511 = draws;
                                        let _e512 = melts;
                                        if (_e511 || _e512) {
                                            let _e514 = melts;
                                            if _e514 {
                                                let _e515 = lowered;
                                                param_299 = _e515;
                                                let _e516 = lavaTypeFor_u0028_u1_u003b((&param_299));
                                                local_12 = _e516;
                                            } else {
                                                local_12 = 12u;
                                            }
                                            let _e517 = local_12;
                                            newType_1 = _e517;
                                            let _e518 = nIndex;
                                            let _e521 = nVal;
                                            let _e522 = newType_1;
                                            param_300 = _e522;
                                            param_301 = 0u;
                                            param_302 = 0u;
                                            let _e523 = lowered;
                                            param_303 = _e523;
                                            let _e524 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_300), (&param_301), (&param_302), (&param_303));
                                            let _e525 = atomicCompareExchangeWeak((&unnamed.grid[_e518]), _e521, _e524);
                                            let _e527 = nVal;
                                            if (_e525.old_value == _e527) {
                                                let _e529 = draws;
                                                if _e529 {
                                                    let _e530 = (*coolness_1);
                                                    (*coolness_1) = min((_e530 + 1u), 255u);
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
            let _e533 = i_7;
            i_7 = (_e533 + 1i);
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
    var phi_5587_: bool;
    var phi_5725_: bool;
    var phi_5731_: bool;
    var phi_5741_: bool;
    var phi_5853_: bool;
    var phi_5860_: bool;
    var phi_5871_: bool;
    var phi_5883_: bool;
    var phi_5905_: bool;
    var phi_6019_: bool;
    var phi_6025_: bool;
    var phi_6035_: bool;

    let _e295 = (*currentAge_4);
    coolness_2 = _e295;
    let _e296 = (*pos_8);
    param_304 = _e296;
    let _e297 = coolness_2;
    param_305 = _e297;
    let _e298 = (*randVal_6);
    param_306 = _e298;
    lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b((&param_304), (&param_305), (&param_306));
    let _e299 = param_305;
    coolness_2 = _e299;
    let _e300 = (*currentSleep_1);
    let _e302 = tuning.wakeSleepThreshold;
    let _e303 = (_e300 > _e302);
    phi_5587_ = _e303;
    if _e303 {
        let _e304 = (*randVal_6);
        let _e308 = tuning.lavaRestCoolChance;
        phi_5587_ = (fract((_e304 * 71f)) < _e308);
    }
    let _e311 = phi_5587_;
    if _e311 {
        let _e312 = coolness_2;
        coolness_2 = min((_e312 + 1u), 255u);
    }
    let _e315 = coolness_2;
    let _e316 = lavaSolidifyCoolness_u0028_();
    if (_e315 >= _e316) {
        let _e318 = (*currentIndex_5);
        let _e321 = (*rawValue_4);
        param_307 = 12u;
        param_308 = 0u;
        param_309 = 0u;
        let _e322 = coolness_2;
        param_310 = _e322;
        let _e323 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_307), (&param_308), (&param_309), (&param_310));
        let _e324 = atomicCompareExchangeWeak((&unnamed.grid[_e318]), _e321, _e323);
        return;
    }
    let _e326 = coolness_2;
    param_311 = _e326;
    let _e327 = lavaTypeFor_u0028_u1_u003b((&param_311));
    newType_2 = _e327;
    let _e328 = (*randVal_6);
    let _e332 = tuning.lavaViscosity;
    if (fract((_e328 * 89f)) < _e332) {
        let _e335 = (*pos_8)[1u];
        if (_e335 > 1i) {
            let _e337 = (*pos_8);
            belowPos_3 = (_e337 + vec3<i32>(0i, -1i, 0i));
            let _e339 = belowPos_3;
            param_312 = _e339;
            let _e340 = getIndex_u0028_vi3_u003b((&param_312));
            param_313 = _e340;
            let _e341 = readCell_u0028_u1_u003b((&param_313));
            param_314 = _e341;
            let _e342 = getType_u0028_u1_u003b((&param_314));
            if (_e342 == 0u) {
                let _e344 = belowPos_3;
                param_315 = _e344;
                let _e345 = getIndex_u0028_vi3_u003b((&param_315));
                let _e346 = newType_2;
                param_316 = _e346;
                let _e347 = (*currentDir_2);
                param_317 = _e347;
                param_318 = 0u;
                let _e348 = coolness_2;
                param_319 = _e348;
                let _e349 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_316), (&param_317), (&param_318), (&param_319));
                let _e350 = (*currentIndex_5);
                param_320 = _e350;
                let _e351 = (*rawValue_4);
                param_321 = _e351;
                param_322 = _e345;
                param_323 = _e349;
                let _e352 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_320), (&param_321), (&param_322), (&param_323));
                if _e352 {
                    return;
                }
            }
        }
        let _e354 = (*pos_8)[1u];
        if (_e354 > 1i) {
            let _e356 = (*randVal_6);
            slideDir = select(-1i, 1i, (fract((_e356 * 10f)) > 0.5f));
            let _e361 = (*randVal_6);
            if (fract((_e361 * 100f)) > 0.5f) {
                let _e365 = (*pos_8);
                let _e366 = slideDir;
                slide[0i] = (_e365 + vec3<i32>(_e366, -1i, 0i));
                let _e370 = (*pos_8);
                let _e371 = slideDir;
                slide[1i] = (_e370 + vec3<i32>(0i, -1i, _e371));
            } else {
                let _e375 = (*pos_8);
                let _e376 = slideDir;
                slide[0i] = (_e375 + vec3<i32>(0i, -1i, _e376));
                let _e380 = (*pos_8);
                let _e381 = slideDir;
                slide[1i] = (_e380 + vec3<i32>(_e381, -1i, 0i));
            }
            s = 0i;
            loop {
                let _e385 = s;
                if (_e385 < 2i) {
                    let _e387 = s;
                    let _e389 = slide[_e387];
                    sPos = _e389;
                    let _e391 = sPos[0u];
                    let _e392 = (_e391 > 0i);
                    phi_5725_ = _e392;
                    if _e392 {
                        let _e394 = sPos[0u];
                        let _e396 = tuning.gridWidth;
                        phi_5725_ = (_e394 < (bitcast<i32>(_e396) - 1i));
                    }
                    let _e401 = phi_5725_;
                    phi_5731_ = _e401;
                    if _e401 {
                        let _e403 = sPos[2u];
                        phi_5731_ = (_e403 > 0i);
                    }
                    let _e406 = phi_5731_;
                    phi_5741_ = _e406;
                    if _e406 {
                        let _e408 = sPos[2u];
                        let _e410 = tuning.gridDepth;
                        phi_5741_ = (_e408 < (bitcast<i32>(_e410) - 1i));
                    }
                    let _e415 = phi_5741_;
                    if _e415 {
                        let _e416 = sPos;
                        param_324 = _e416;
                        let _e417 = getIndex_u0028_vi3_u003b((&param_324));
                        param_325 = _e417;
                        let _e418 = readCell_u0028_u1_u003b((&param_325));
                        param_326 = _e418;
                        let _e419 = getType_u0028_u1_u003b((&param_326));
                        if (_e419 == 0u) {
                            let _e421 = sPos;
                            param_327 = _e421;
                            let _e422 = getIndex_u0028_vi3_u003b((&param_327));
                            let _e423 = newType_2;
                            param_328 = _e423;
                            let _e424 = (*currentDir_2);
                            param_329 = _e424;
                            param_330 = 0u;
                            let _e425 = coolness_2;
                            param_331 = _e425;
                            let _e426 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_328), (&param_329), (&param_330), (&param_331));
                            let _e427 = (*currentIndex_5);
                            param_332 = _e427;
                            let _e428 = (*rawValue_4);
                            param_333 = _e428;
                            param_334 = _e422;
                            param_335 = _e426;
                            let _e429 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_332), (&param_333), (&param_334), (&param_335));
                            if _e429 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e430 = s;
                    s = (_e430 + 1i);
                }
            }
        }
        let _e432 = (*currentSleep_1);
        let _e434 = tuning.wakeSleepThreshold;
        if (_e432 <= _e434) {
            blockedMask = 0u;
            let _e436 = (*randVal_6);
            searchStart = i32((fract((_e436 * 8f)) * 8f));
            let _e442 = tuning.lavaSpreadRadius;
            reach = bitcast<i32>(max(_e442, 1u));
            r = 1i;
            loop {
                let _e445 = r;
                let _e446 = reach;
                if (_e445 <= _e446) {
                    let _e448 = blockedMask;
                    if (_e448 == 255u) {
                        break;
                    }
                    i_8 = 0i;
                    loop {
                        let _e450 = i_8;
                        if (_e450 < 8i) {
                            let _e452 = searchStart;
                            let _e453 = i_8;
                            let _e454 = (_e452 + _e453);
                            d_7 = (_e454 - (i32(floor((f32(_e454) / f32(8i)))) * 8i));
                            let _e462 = blockedMask;
                            let _e463 = d_7;
                            if ((_e462 & (1u << bitcast<u32>(_e463))) != 0u) {
                                continue;
                            }
                            let _e468 = (*pos_8);
                            let _e469 = d_7;
                            param_336 = _e469;
                            let _e470 = getHDir_u0028_i1_u003b((&param_336));
                            let _e471 = r;
                            c_6 = (_e468 + (_e470 * vec3(_e471)));
                            let _e476 = c_6[0u];
                            let _e477 = (_e476 <= 0i);
                            phi_5853_ = _e477;
                            if !(_e477) {
                                let _e480 = c_6[0u];
                                let _e482 = tuning.gridWidth;
                                phi_5853_ = (_e480 >= (bitcast<i32>(_e482) - 1i));
                            }
                            let _e487 = phi_5853_;
                            phi_5860_ = _e487;
                            if !(_e487) {
                                let _e490 = c_6[2u];
                                phi_5860_ = (_e490 <= 0i);
                            }
                            let _e493 = phi_5860_;
                            phi_5871_ = _e493;
                            if !(_e493) {
                                let _e496 = c_6[2u];
                                let _e498 = tuning.gridDepth;
                                phi_5871_ = (_e496 >= (bitcast<i32>(_e498) - 1i));
                            }
                            let _e503 = phi_5871_;
                            phi_5883_ = _e503;
                            if !(_e503) {
                                let _e505 = c_6;
                                param_337 = _e505;
                                let _e506 = getIndex_u0028_vi3_u003b((&param_337));
                                param_338 = _e506;
                                let _e507 = readCell_u0028_u1_u003b((&param_338));
                                param_339 = _e507;
                                let _e508 = getType_u0028_u1_u003b((&param_339));
                                phi_5883_ = (_e508 != 0u);
                            }
                            let _e511 = phi_5883_;
                            if _e511 {
                                let _e512 = d_7;
                                let _e515 = blockedMask;
                                blockedMask = (_e515 | (1u << bitcast<u32>(_e512)));
                            } else {
                                let _e518 = c_6[1u];
                                let _e519 = (_e518 > 1i);
                                phi_5905_ = _e519;
                                if _e519 {
                                    let _e520 = c_6;
                                    param_340 = (_e520 + vec3<i32>(0i, -1i, 0i));
                                    let _e522 = getIndex_u0028_vi3_u003b((&param_340));
                                    param_341 = _e522;
                                    let _e523 = readCell_u0028_u1_u003b((&param_341));
                                    param_342 = _e523;
                                    let _e524 = getType_u0028_u1_u003b((&param_342));
                                    phi_5905_ = (_e524 == 0u);
                                }
                                let _e527 = phi_5905_;
                                if _e527 {
                                    let _e528 = c_6;
                                    param_343 = _e528;
                                    let _e529 = getIndex_u0028_vi3_u003b((&param_343));
                                    let _e530 = newType_2;
                                    param_344 = _e530;
                                    param_345 = 0u;
                                    param_346 = 0u;
                                    let _e531 = coolness_2;
                                    param_347 = _e531;
                                    let _e532 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_344), (&param_345), (&param_346), (&param_347));
                                    let _e533 = (*currentIndex_5);
                                    param_348 = _e533;
                                    let _e534 = (*rawValue_4);
                                    param_349 = _e534;
                                    param_350 = _e529;
                                    param_351 = _e532;
                                    let _e535 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_348), (&param_349), (&param_350), (&param_351));
                                    if _e535 {
                                        return;
                                    }
                                    let _e536 = d_7;
                                    let _e539 = blockedMask;
                                    blockedMask = (_e539 | (1u << bitcast<u32>(_e536)));
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e541 = i_8;
                            i_8 = (_e541 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e543 = r;
                    r = (_e543 + 1i);
                }
            }
            let _e546 = (*pos_8)[1u];
            let _e548 = tuning.gridHeight;
            if (_e546 < (bitcast<i32>(_e548) - 2i)) {
                let _e552 = (*pos_8);
                param_352 = (_e552 + vec3<i32>(0i, 1i, 0i));
                let _e554 = getIndex_u0028_vi3_u003b((&param_352));
                param_353 = _e554;
                let _e555 = readCell_u0028_u1_u003b((&param_353));
                param_354 = _e555;
                let _e556 = getType_u0028_u1_u003b((&param_354));
                local_13 = (_e556 != 0u);
            } else {
                local_13 = false;
            }
            let _e558 = local_13;
            hasPressure = _e558;
            let _e560 = (*pos_8)[1u];
            if (_e560 > 1i) {
                let _e562 = (*pos_8);
                param_355 = (_e562 + vec3<i32>(0i, -1i, 0i));
                let _e564 = getIndex_u0028_vi3_u003b((&param_355));
                param_356 = _e564;
                let _e565 = readCell_u0028_u1_u003b((&param_356));
                param_357 = _e565;
                let _e566 = getType_u0028_u1_u003b((&param_357));
                param_358 = _e566;
                let _e567 = isLava_u0028_u1_u003b((&param_358));
                local_14 = _e567;
            } else {
                local_14 = false;
            }
            let _e568 = local_14;
            stackedOnLava = _e568;
            let _e569 = hasPressure;
            let _e570 = stackedOnLava;
            if (_e569 || _e570) {
                let _e572 = (*randVal_6);
                spreadStart = i32((fract((_e572 * 8f)) * 8f));
                i_9 = 0i;
                loop {
                    let _e577 = i_9;
                    if (_e577 < 8i) {
                        let _e579 = spreadStart;
                        let _e580 = i_9;
                        let _e581 = (_e579 + _e580);
                        d_8 = (_e581 - (i32(floor((f32(_e581) / f32(8i)))) * 8i));
                        let _e589 = (*pos_8);
                        let _e590 = d_8;
                        param_359 = _e590;
                        let _e591 = getHDir_u0028_i1_u003b((&param_359));
                        targetPos = (_e589 + _e591);
                        let _e594 = targetPos[0u];
                        let _e595 = (_e594 > 0i);
                        phi_6019_ = _e595;
                        if _e595 {
                            let _e597 = targetPos[0u];
                            let _e599 = tuning.gridWidth;
                            phi_6019_ = (_e597 < (bitcast<i32>(_e599) - 1i));
                        }
                        let _e604 = phi_6019_;
                        phi_6025_ = _e604;
                        if _e604 {
                            let _e606 = targetPos[2u];
                            phi_6025_ = (_e606 > 0i);
                        }
                        let _e609 = phi_6025_;
                        phi_6035_ = _e609;
                        if _e609 {
                            let _e611 = targetPos[2u];
                            let _e613 = tuning.gridDepth;
                            phi_6035_ = (_e611 < (bitcast<i32>(_e613) - 1i));
                        }
                        let _e618 = phi_6035_;
                        if _e618 {
                            let _e619 = targetPos;
                            param_360 = _e619;
                            let _e620 = getIndex_u0028_vi3_u003b((&param_360));
                            param_361 = _e620;
                            let _e621 = readCell_u0028_u1_u003b((&param_361));
                            param_362 = _e621;
                            let _e622 = getType_u0028_u1_u003b((&param_362));
                            if (_e622 == 0u) {
                                let _e624 = targetPos;
                                param_363 = _e624;
                                let _e625 = getIndex_u0028_vi3_u003b((&param_363));
                                let _e626 = d_8;
                                let _e629 = newType_2;
                                param_364 = _e629;
                                param_365 = bitcast<u32>((_e626 + 1i));
                                param_366 = 0u;
                                let _e630 = coolness_2;
                                param_367 = _e630;
                                let _e631 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_364), (&param_365), (&param_366), (&param_367));
                                let _e632 = (*currentIndex_5);
                                param_368 = _e632;
                                let _e633 = (*rawValue_4);
                                param_369 = _e633;
                                param_370 = _e625;
                                param_371 = _e631;
                                let _e634 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_368), (&param_369), (&param_370), (&param_371));
                                if _e634 {
                                    return;
                                }
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e635 = i_9;
                        i_9 = (_e635 + 1i);
                    }
                }
            }
        }
    }
    let _e637 = (*currentSleep_1);
    newSleep = min((_e637 + 1u), 255u);
    let _e640 = (*currentIndex_5);
    let _e643 = (*rawValue_4);
    let _e644 = newType_2;
    param_372 = _e644;
    let _e645 = (*currentDir_2);
    param_373 = _e645;
    let _e646 = newSleep;
    param_374 = _e646;
    let _e647 = coolness_2;
    param_375 = _e647;
    let _e648 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_372), (&param_373), (&param_374), (&param_375));
    let _e649 = atomicCompareExchangeWeak((&unnamed.grid[_e640]), _e643, _e648);
    return;
}

fn packCloud_u0028_u1_u003b_u1_u003b_u1_u003b(kind: ptr<function, u32>, wait: ptr<function, u32>, sleep_1: ptr<function, u32>) -> u32 {
    let _e196 = (*kind);
    let _e198 = (*wait);
    let _e203 = (*sleep_1);
    return (((_e196 & 3u) | ((_e198 & 255u) << bitcast<u32>(2i))) | ((_e203 & 255u) << bitcast<u32>(10i)));
}

fn updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_9: ptr<function, vec3<i32>>, currentIndex_6: ptr<function, u32>, rawValue_5: ptr<function, u32>, currentSleep_2: ptr<function, u32>, currentAge_5: ptr<function, u32>, randVal_7: ptr<function, f32>) {
    var param_376: u32;
    var param_377: u32;
    var param_378: u32;
    var newAge: u32;
    var d_9: i32;
    var scatterPos: vec3<i32>;
    var param_379: i32;
    var sType: u32;
    var param_380: vec3<i32>;
    var param_381: u32;
    var param_382: u32;
    var param_383: vec3<i32>;
    var param_384: u32;
    var param_385: u32;
    var param_386: u32;
    var param_387: u32;
    var param_388: u32;
    var param_389: u32;
    var param_390: u32;
    var param_391: u32;
    var checkPos: array<vec3<i32>, 3>;
    var dir_1: i32;
    var i_10: i32;
    var cPos: vec3<i32>;
    var cIndex: u32;
    var param_392: vec3<i32>;
    var cVal: u32;
    var param_393: u32;
    var cType: u32;
    var param_394: u32;
    var moisture_2: u32;
    var param_395: u32;
    var capacity: u32;
    var local_15: u32;
    var i_11: i32;
    var sPos_1: vec3<i32>;
    var sType_1: u32;
    var param_396: vec3<i32>;
    var param_397: u32;
    var param_398: u32;
    var param_399: vec3<i32>;
    var param_400: u32;
    var param_401: u32;
    var param_402: u32;
    var param_403: u32;
    var param_404: u32;
    var param_405: u32;
    var param_406: u32;
    var param_407: u32;
    var newSleep_1: u32;
    var param_408: u32;
    var param_409: u32;
    var param_410: u32;
    var param_411: u32;
    var phi_8272_: bool;
    var phi_8278_: bool;
    var phi_8288_: bool;
    var phi_8294_: bool;
    var phi_8304_: bool;
    var phi_8404_: bool;
    var phi_8410_: bool;
    var phi_8420_: bool;
    var phi_8501_: bool;
    var phi_8507_: bool;
    var phi_8517_: bool;

    let _e254 = (*pos_9)[1u];
    let _e256 = tuning.gridHeight;
    if (_e254 >= (bitcast<i32>(_e256) - 2i)) {
        let _e260 = (*currentIndex_6);
        param_376 = 1u;
        param_377 = 0u;
        param_378 = 0u;
        let _e263 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_376), (&param_377), (&param_378));
        let _e264 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e260]), 0u, _e263);
        if (_e264.old_value == 0u) {
            let _e267 = (*currentIndex_6);
            let _e270 = atomicExchange((&unnamed.grid[_e267]), 0u);
        }
        return;
    }
    let _e271 = (*currentAge_5);
    newAge = min((_e271 + 1u), 255u);
    let _e274 = (*randVal_7);
    let _e278 = tuning.steamScatterChance;
    if (fract((_e274 * 88f)) < _e278) {
        let _e280 = (*randVal_7);
        d_9 = i32((fract((_e280 * 13f)) * 6f));
        let _e285 = (*pos_9);
        let _e286 = d_9;
        param_379 = _e286;
        let _e287 = getOrthoDir_u0028_i1_u003b((&param_379));
        scatterPos = (_e285 + _e287);
        let _e290 = scatterPos[0u];
        let _e291 = (_e290 > 0i);
        phi_8272_ = _e291;
        if _e291 {
            let _e293 = scatterPos[0u];
            let _e295 = tuning.gridWidth;
            phi_8272_ = (_e293 < (bitcast<i32>(_e295) - 1i));
        }
        let _e300 = phi_8272_;
        phi_8278_ = _e300;
        if _e300 {
            let _e302 = scatterPos[1u];
            phi_8278_ = (_e302 > 0i);
        }
        let _e305 = phi_8278_;
        phi_8288_ = _e305;
        if _e305 {
            let _e307 = scatterPos[1u];
            let _e309 = tuning.gridHeight;
            phi_8288_ = (_e307 < (bitcast<i32>(_e309) - 1i));
        }
        let _e314 = phi_8288_;
        phi_8294_ = _e314;
        if _e314 {
            let _e316 = scatterPos[2u];
            phi_8294_ = (_e316 > 0i);
        }
        let _e319 = phi_8294_;
        phi_8304_ = _e319;
        if _e319 {
            let _e321 = scatterPos[2u];
            let _e323 = tuning.gridDepth;
            phi_8304_ = (_e321 < (bitcast<i32>(_e323) - 1i));
        }
        let _e328 = phi_8304_;
        if _e328 {
            let _e329 = scatterPos;
            param_380 = _e329;
            let _e330 = getIndex_u0028_vi3_u003b((&param_380));
            param_381 = _e330;
            let _e331 = readCell_u0028_u1_u003b((&param_381));
            param_382 = _e331;
            let _e332 = getType_u0028_u1_u003b((&param_382));
            sType = _e332;
            let _e333 = sType;
            let _e335 = sType;
            if ((_e333 == 0u) || (_e335 == 5u)) {
                let _e338 = scatterPos;
                param_383 = _e338;
                let _e339 = getIndex_u0028_vi3_u003b((&param_383));
                param_384 = 6u;
                param_385 = 0u;
                param_386 = 0u;
                let _e340 = newAge;
                param_387 = _e340;
                let _e341 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_384), (&param_385), (&param_386), (&param_387));
                let _e342 = (*currentIndex_6);
                param_388 = _e342;
                let _e343 = (*rawValue_5);
                param_389 = _e343;
                param_390 = _e339;
                param_391 = _e341;
                let _e344 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_388), (&param_389), (&param_390), (&param_391));
                if _e344 {
                    return;
                }
            }
        }
    }
    let _e345 = (*pos_9);
    checkPos[0i] = (_e345 + vec3<i32>(0i, 1i, 0i));
    let _e348 = (*randVal_7);
    dir_1 = select(-1i, 1i, (fract((_e348 * 10f)) > 0.5f));
    let _e353 = (*randVal_7);
    if (fract((_e353 * 100f)) > 0.5f) {
        let _e357 = (*pos_9);
        let _e358 = dir_1;
        checkPos[1i] = (_e357 + vec3<i32>(_e358, 1i, 0i));
        let _e362 = (*pos_9);
        let _e363 = dir_1;
        checkPos[2i] = (_e362 + vec3<i32>(0i, 1i, _e363));
    } else {
        let _e367 = (*pos_9);
        let _e368 = dir_1;
        checkPos[1i] = (_e367 + vec3<i32>(0i, 1i, _e368));
        let _e372 = (*pos_9);
        let _e373 = dir_1;
        checkPos[2i] = (_e372 + vec3<i32>(_e373, 1i, 0i));
    }
    i_10 = 0i;
    loop {
        let _e377 = i_10;
        if (_e377 < 3i) {
            let _e379 = i_10;
            let _e381 = checkPos[_e379];
            cPos = _e381;
            let _e383 = cPos[0u];
            let _e384 = (_e383 > 0i);
            phi_8404_ = _e384;
            if _e384 {
                let _e386 = cPos[0u];
                let _e388 = tuning.gridWidth;
                phi_8404_ = (_e386 < (bitcast<i32>(_e388) - 1i));
            }
            let _e393 = phi_8404_;
            phi_8410_ = _e393;
            if _e393 {
                let _e395 = cPos[2u];
                phi_8410_ = (_e395 > 0i);
            }
            let _e398 = phi_8410_;
            phi_8420_ = _e398;
            if _e398 {
                let _e400 = cPos[2u];
                let _e402 = tuning.gridDepth;
                phi_8420_ = (_e400 < (bitcast<i32>(_e402) - 1i));
            }
            let _e407 = phi_8420_;
            if _e407 {
                let _e408 = cPos;
                param_392 = _e408;
                let _e409 = getIndex_u0028_vi3_u003b((&param_392));
                cIndex = _e409;
                let _e410 = cIndex;
                param_393 = _e410;
                let _e411 = readCell_u0028_u1_u003b((&param_393));
                cVal = _e411;
                let _e412 = cVal;
                param_394 = _e412;
                let _e413 = getType_u0028_u1_u003b((&param_394));
                cType = _e413;
                let _e414 = cType;
                let _e416 = cType;
                if ((_e414 == 1u) || (_e416 == 4u)) {
                    let _e419 = cVal;
                    param_395 = _e419;
                    let _e420 = getAge_u0028_u1_u003b((&param_395));
                    moisture_2 = _e420;
                    let _e421 = cType;
                    if (_e421 == 4u) {
                        let _e424 = tuning.dirtMoistureCapacity;
                        local_15 = _e424;
                    } else {
                        let _e426 = tuning.sandMoistureCapacity;
                        local_15 = _e426;
                    }
                    let _e427 = local_15;
                    capacity = _e427;
                    let _e428 = moisture_2;
                    let _e429 = capacity;
                    if (_e428 < _e429) {
                        let _e431 = (*currentIndex_6);
                        let _e434 = (*rawValue_5);
                        let _e435 = atomicCompareExchangeWeak((&unnamed.grid[_e431]), _e434, 0u);
                        let _e437 = (*rawValue_5);
                        if (_e435.old_value == _e437) {
                            let _e439 = cIndex;
                            let _e442 = atomicAdd((&unnamed.grid[_e439]), 16777216u);
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
            let _e443 = i_10;
            i_10 = (_e443 + 1i);
        }
    }
    i_11 = 0i;
    loop {
        let _e445 = i_11;
        if (_e445 < 3i) {
            let _e447 = i_11;
            let _e449 = checkPos[_e447];
            sPos_1 = _e449;
            let _e451 = sPos_1[0u];
            let _e452 = (_e451 > 0i);
            phi_8501_ = _e452;
            if _e452 {
                let _e454 = sPos_1[0u];
                let _e456 = tuning.gridWidth;
                phi_8501_ = (_e454 < (bitcast<i32>(_e456) - 1i));
            }
            let _e461 = phi_8501_;
            phi_8507_ = _e461;
            if _e461 {
                let _e463 = sPos_1[2u];
                phi_8507_ = (_e463 > 0i);
            }
            let _e466 = phi_8507_;
            phi_8517_ = _e466;
            if _e466 {
                let _e468 = sPos_1[2u];
                let _e470 = tuning.gridDepth;
                phi_8517_ = (_e468 < (bitcast<i32>(_e470) - 1i));
            }
            let _e475 = phi_8517_;
            if _e475 {
                let _e476 = sPos_1;
                param_396 = _e476;
                let _e477 = getIndex_u0028_vi3_u003b((&param_396));
                param_397 = _e477;
                let _e478 = readCell_u0028_u1_u003b((&param_397));
                param_398 = _e478;
                let _e479 = getType_u0028_u1_u003b((&param_398));
                sType_1 = _e479;
                let _e480 = sType_1;
                let _e482 = sType_1;
                if ((_e480 == 0u) || (_e482 == 5u)) {
                    let _e485 = sPos_1;
                    param_399 = _e485;
                    let _e486 = getIndex_u0028_vi3_u003b((&param_399));
                    param_400 = 6u;
                    param_401 = 0u;
                    param_402 = 0u;
                    let _e487 = newAge;
                    param_403 = _e487;
                    let _e488 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_400), (&param_401), (&param_402), (&param_403));
                    let _e489 = (*currentIndex_6);
                    param_404 = _e489;
                    let _e490 = (*rawValue_5);
                    param_405 = _e490;
                    param_406 = _e486;
                    param_407 = _e488;
                    let _e491 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_404), (&param_405), (&param_406), (&param_407));
                    if _e491 {
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e492 = i_11;
            i_11 = (_e492 + 1i);
        }
    }
    let _e494 = (*currentSleep_2);
    newSleep_1 = min((_e494 + 1u), 255u);
    let _e497 = (*currentIndex_6);
    let _e500 = (*rawValue_5);
    param_408 = 6u;
    param_409 = 0u;
    let _e501 = newSleep_1;
    param_410 = _e501;
    let _e502 = newAge;
    param_411 = _e502;
    let _e503 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_408), (&param_409), (&param_410), (&param_411));
    let _e504 = atomicCompareExchangeWeak((&unnamed.grid[_e497]), _e500, _e503);
    return;
}

fn updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_10: ptr<function, vec3<i32>>, currentIndex_7: ptr<function, u32>, rawValue_6: ptr<function, u32>, currentDir_3: ptr<function, u32>, currentSleep_3: ptr<function, u32>, currentAge_6: ptr<function, u32>, randVal_8: ptr<function, f32>) {
    var newAge_1: u32;
    var isBurningGrass: bool;
    var i_12: i32;
    var nPos_1: vec3<i32>;
    var param_412: i32;
    var nIndex_1: u32;
    var param_413: vec3<i32>;
    var nVal_1: u32;
    var param_414: u32;
    var param_415: u32;
    var param_416: u32;
    var param_417: u32;
    var param_418: u32;
    var param_419: u32;
    var burnRoll: f32;
    var start_6: i32;
    var i_13: i32;
    var nPos_2: vec3<i32>;
    var param_420: i32;
    var param_421: vec3<i32>;
    var nIndex_2: u32;
    var param_422: vec3<i32>;
    var nVal_2: u32;
    var param_423: u32;
    var nType_1: u32;
    var param_424: u32;
    var need_1: f32;
    var local_16: f32;
    var param_425: u32;
    var param_426: u32;
    var param_427: u32;
    var param_428: u32;
    var belowPos_4: vec3<i32>;
    var belowIndex_1: u32;
    var param_429: vec3<i32>;
    var belowValue_1: u32;
    var param_430: u32;
    var belowType: u32;
    var param_431: u32;
    var param_432: u32;
    var param_433: u32;
    var param_434: u32;
    var param_435: u32;
    var param_436: u32;
    var param_437: u32;
    var param_438: u32;
    var param_439: u32;
    var moisture_3: u32;
    var param_440: u32;
    var newMoisture: u32;
    var local_17: u32;
    var newVal: u32;
    var param_441: u32;
    var param_442: u32;
    var param_443: u32;
    var param_444: u32;
    var param_445: u32;
    var flora_3: u32;
    var newFlora: u32;
    var newVal_1: u32;
    var param_446: u32;
    var param_447: u32;
    var param_448: u32;
    var param_449: u32;
    var param_450: u32;
    var d_10: i32;
    var targetPos_1: vec3<i32>;
    var param_451: i32;
    var targetIndex_1: u32;
    var param_452: vec3<i32>;
    var param_453: u32;
    var param_454: u32;
    var targetBelow: vec3<i32>;
    var tBelowVal: u32;
    var param_455: vec3<i32>;
    var param_456: u32;
    var param_457: u32;
    var tFlora: u32;
    var param_458: u32;
    var param_459: u32;
    var param_460: u32;
    var param_461: u32;
    var param_462: u32;
    var param_463: u32;
    var param_464: u32;
    var param_465: u32;
    var phi_7543_: bool;
    var phi_7549_: bool;
    var phi_7559_: bool;
    var phi_7565_: bool;
    var phi_7575_: bool;
    var phi_7883_: bool;
    var phi_7889_: bool;
    var phi_7899_: bool;

    let _e286 = (*currentAge_6);
    newAge_1 = (_e286 + 1u);
    isBurningGrass = false;
    i_12 = 0i;
    loop {
        let _e288 = i_12;
        if (_e288 < 6i) {
            let _e290 = (*pos_10);
            let _e291 = i_12;
            param_412 = _e291;
            let _e292 = getOrthoDir_u0028_i1_u003b((&param_412));
            nPos_1 = (_e290 + _e292);
            let _e295 = nPos_1[0u];
            let _e296 = (_e295 > 0i);
            phi_7543_ = _e296;
            if _e296 {
                let _e298 = nPos_1[0u];
                let _e300 = tuning.gridWidth;
                phi_7543_ = (_e298 < (bitcast<i32>(_e300) - 1i));
            }
            let _e305 = phi_7543_;
            phi_7549_ = _e305;
            if _e305 {
                let _e307 = nPos_1[1u];
                phi_7549_ = (_e307 > 0i);
            }
            let _e310 = phi_7549_;
            phi_7559_ = _e310;
            if _e310 {
                let _e312 = nPos_1[1u];
                let _e314 = tuning.gridHeight;
                phi_7559_ = (_e312 < (bitcast<i32>(_e314) - 1i));
            }
            let _e319 = phi_7559_;
            phi_7565_ = _e319;
            if _e319 {
                let _e321 = nPos_1[2u];
                phi_7565_ = (_e321 > 0i);
            }
            let _e324 = phi_7565_;
            phi_7575_ = _e324;
            if _e324 {
                let _e326 = nPos_1[2u];
                let _e328 = tuning.gridDepth;
                phi_7575_ = (_e326 < (bitcast<i32>(_e328) - 1i));
            }
            let _e333 = phi_7575_;
            if _e333 {
                let _e334 = nPos_1;
                param_413 = _e334;
                let _e335 = getIndex_u0028_vi3_u003b((&param_413));
                nIndex_1 = _e335;
                let _e336 = nIndex_1;
                param_414 = _e336;
                let _e337 = readCell_u0028_u1_u003b((&param_414));
                nVal_1 = _e337;
                let _e338 = nVal_1;
                param_415 = _e338;
                let _e339 = getType_u0028_u1_u003b((&param_415));
                if (_e339 == 2u) {
                    let _e341 = nIndex_1;
                    let _e344 = nVal_1;
                    param_416 = 6u;
                    param_417 = 0u;
                    param_418 = 0u;
                    param_419 = 0u;
                    let _e345 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_416), (&param_417), (&param_418), (&param_419));
                    let _e346 = atomicCompareExchangeWeak((&unnamed.grid[_e341]), _e344, _e345);
                    let _e348 = nVal_1;
                    if (_e346.old_value == _e348) {
                        decWater_u0028_();
                        let _e350 = (*currentIndex_7);
                        let _e353 = atomicExchange((&unnamed.grid[_e350]), 0u);
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e354 = i_12;
            i_12 = (_e354 + 1i);
        }
    }
    let _e356 = (*randVal_8);
    burnRoll = fract((_e356 * 47f));
    let _e359 = burnRoll;
    let _e361 = tuning.treeLeafBurnChance;
    let _e363 = tuning.treeTrunkBurnChance;
    if (_e359 < max(_e361, _e363)) {
        let _e366 = (*randVal_8);
        start_6 = i32((fract((_e366 * 31f)) * 26f));
        i_13 = 0i;
        loop {
            let _e371 = i_13;
            if (_e371 < 26i) {
                let _e373 = (*pos_10);
                let _e374 = start_6;
                let _e375 = i_13;
                let _e376 = (_e374 + _e375);
                param_420 = (_e376 - (i32(floor((f32(_e376) / f32(26i)))) * 26i));
                let _e384 = tree26_u0028_i1_u003b((&param_420));
                nPos_2 = (_e373 + _e384);
                let _e386 = nPos_2;
                param_421 = _e386;
                let _e387 = treeInBounds_u0028_vi3_u003b((&param_421));
                if !(_e387) {
                    continue;
                }
                let _e389 = nPos_2;
                param_422 = _e389;
                let _e390 = getIndex_u0028_vi3_u003b((&param_422));
                nIndex_2 = _e390;
                let _e391 = nIndex_2;
                param_423 = _e391;
                let _e392 = readCell_u0028_u1_u003b((&param_423));
                nVal_2 = _e392;
                let _e393 = nVal_2;
                param_424 = _e393;
                let _e394 = getType_u0028_u1_u003b((&param_424));
                nType_1 = _e394;
                let _e395 = nType_1;
                let _e397 = nType_1;
                if ((_e395 != 19u) && (_e397 != 18u)) {
                    continue;
                }
                let _e400 = nType_1;
                if (_e400 == 19u) {
                    let _e403 = tuning.treeLeafBurnChance;
                    local_16 = _e403;
                } else {
                    let _e405 = tuning.treeTrunkBurnChance;
                    local_16 = _e405;
                }
                let _e406 = local_16;
                need_1 = _e406;
                let _e407 = burnRoll;
                let _e408 = need_1;
                if (_e407 < _e408) {
                    let _e410 = nIndex_2;
                    let _e413 = nVal_2;
                    param_425 = 5u;
                    param_426 = 0u;
                    param_427 = 0u;
                    param_428 = 0u;
                    let _e414 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_425), (&param_426), (&param_427), (&param_428));
                    let _e415 = atomicCompareExchangeWeak((&unnamed.grid[_e410]), _e413, _e414);
                }
                break;
            } else {
                break;
            }
            continuing {
                let _e417 = i_13;
                i_13 = (_e417 + 1i);
            }
        }
    }
    let _e420 = (*pos_10)[1u];
    if (_e420 > 1i) {
        let _e422 = (*pos_10);
        belowPos_4 = (_e422 + vec3<i32>(0i, -1i, 0i));
        let _e424 = belowPos_4;
        param_429 = _e424;
        let _e425 = getIndex_u0028_vi3_u003b((&param_429));
        belowIndex_1 = _e425;
        let _e426 = belowIndex_1;
        param_430 = _e426;
        let _e427 = readCell_u0028_u1_u003b((&param_430));
        belowValue_1 = _e427;
        let _e428 = belowValue_1;
        param_431 = _e428;
        let _e429 = getType_u0028_u1_u003b((&param_431));
        belowType = _e429;
        let _e430 = belowType;
        if (_e430 == 0u) {
            param_432 = 5u;
            param_433 = 0u;
            param_434 = 0u;
            let _e432 = newAge_1;
            param_435 = _e432;
            let _e433 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_432), (&param_433), (&param_434), (&param_435));
            let _e434 = (*currentIndex_7);
            param_436 = _e434;
            let _e435 = (*rawValue_6);
            param_437 = _e435;
            let _e436 = belowIndex_1;
            param_438 = _e436;
            param_439 = _e433;
            let _e437 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_436), (&param_437), (&param_438), (&param_439));
            if _e437 {
                return;
            }
        } else {
            let _e438 = belowType;
            if (_e438 == 2u) {
                let _e440 = (*currentIndex_7);
                let _e443 = atomicExchange((&unnamed.grid[_e440]), 0u);
                return;
            } else {
                let _e444 = belowType;
                if (_e444 == 1u) {
                    let _e446 = belowValue_1;
                    param_440 = _e446;
                    let _e447 = getAge_u0028_u1_u003b((&param_440));
                    moisture_3 = _e447;
                    let _e448 = moisture_3;
                    if (_e448 > 0u) {
                        let _e450 = moisture_3;
                        let _e452 = tuning.fireDryRate;
                        if (_e450 > _e452) {
                            let _e454 = moisture_3;
                            let _e456 = tuning.fireDryRate;
                            local_17 = (_e454 - _e456);
                        } else {
                            local_17 = 0u;
                        }
                        let _e458 = local_17;
                        newMoisture = _e458;
                        let _e459 = belowValue_1;
                        param_441 = _e459;
                        let _e460 = getDir_u0028_u1_u003b((&param_441));
                        param_442 = 1u;
                        param_443 = _e460;
                        param_444 = 0u;
                        let _e461 = newMoisture;
                        param_445 = _e461;
                        let _e462 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_442), (&param_443), (&param_444), (&param_445));
                        newVal = _e462;
                        let _e463 = belowIndex_1;
                        let _e466 = belowValue_1;
                        let _e467 = newVal;
                        let _e468 = atomicCompareExchangeWeak((&unnamed.grid[_e463]), _e466, _e467);
                        let _e470 = belowValue_1;
                        if (_e468.old_value == _e470) {
                            let _e472 = (*currentIndex_7);
                            let _e475 = atomicExchange((&unnamed.grid[_e472]), 0u);
                            return;
                        }
                    }
                } else {
                    let _e476 = belowType;
                    if (_e476 == 4u) {
                        let _e478 = belowValue_1;
                        flora_3 = ((_e478 >> bitcast<u32>(8i)) & 255u);
                        let _e482 = flora_3;
                        let _e484 = flora_3;
                        if ((_e482 > 10u) && (_e484 <= 100u)) {
                            isBurningGrass = true;
                            newAge_1 = 0u;
                            let _e487 = (*randVal_8);
                            let _e491 = tuning.fireBurnGrassChance;
                            if (fract((_e487 * 100f)) < _e491) {
                                let _e493 = flora_3;
                                newFlora = (_e493 - 1u);
                                let _e495 = belowValue_1;
                                param_446 = _e495;
                                let _e496 = getAge_u0028_u1_u003b((&param_446));
                                param_447 = 4u;
                                let _e497 = newFlora;
                                param_448 = _e497;
                                param_449 = 0u;
                                param_450 = _e496;
                                let _e498 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_447), (&param_448), (&param_449), (&param_450));
                                newVal_1 = _e498;
                                let _e499 = belowIndex_1;
                                let _e502 = belowValue_1;
                                let _e503 = newVal_1;
                                let _e504 = atomicCompareExchangeWeak((&unnamed.grid[_e499]), _e502, _e503);
                            }
                            let _e506 = (*randVal_8);
                            let _e510 = tuning.fireSpreadChance;
                            if (fract((_e506 * 100f)) < _e510) {
                                let _e512 = (*randVal_8);
                                d_10 = i32((fract((_e512 * 10f)) * 8f));
                                let _e517 = (*pos_10);
                                let _e518 = d_10;
                                param_451 = _e518;
                                let _e519 = getHDir_u0028_i1_u003b((&param_451));
                                targetPos_1 = (_e517 + _e519);
                                let _e522 = targetPos_1[0u];
                                let _e523 = (_e522 > 0i);
                                phi_7883_ = _e523;
                                if _e523 {
                                    let _e525 = targetPos_1[0u];
                                    let _e527 = tuning.gridWidth;
                                    phi_7883_ = (_e525 < (bitcast<i32>(_e527) - 1i));
                                }
                                let _e532 = phi_7883_;
                                phi_7889_ = _e532;
                                if _e532 {
                                    let _e534 = targetPos_1[2u];
                                    phi_7889_ = (_e534 > 0i);
                                }
                                let _e537 = phi_7889_;
                                phi_7899_ = _e537;
                                if _e537 {
                                    let _e539 = targetPos_1[2u];
                                    let _e541 = tuning.gridDepth;
                                    phi_7899_ = (_e539 < (bitcast<i32>(_e541) - 1i));
                                }
                                let _e546 = phi_7899_;
                                if _e546 {
                                    let _e547 = targetPos_1;
                                    param_452 = _e547;
                                    let _e548 = getIndex_u0028_vi3_u003b((&param_452));
                                    targetIndex_1 = _e548;
                                    let _e549 = targetIndex_1;
                                    param_453 = _e549;
                                    let _e550 = readCell_u0028_u1_u003b((&param_453));
                                    param_454 = _e550;
                                    let _e551 = getType_u0028_u1_u003b((&param_454));
                                    if (_e551 == 0u) {
                                        let _e553 = targetPos_1;
                                        targetBelow = (_e553 + vec3<i32>(0i, -1i, 0i));
                                        let _e555 = targetBelow;
                                        param_455 = _e555;
                                        let _e556 = getIndex_u0028_vi3_u003b((&param_455));
                                        param_456 = _e556;
                                        let _e557 = readCell_u0028_u1_u003b((&param_456));
                                        tBelowVal = _e557;
                                        let _e558 = tBelowVal;
                                        param_457 = _e558;
                                        let _e559 = getType_u0028_u1_u003b((&param_457));
                                        if (_e559 == 4u) {
                                            let _e561 = tBelowVal;
                                            tFlora = ((_e561 >> bitcast<u32>(8i)) & 255u);
                                            let _e565 = tFlora;
                                            let _e567 = tFlora;
                                            if ((_e565 > 10u) && (_e567 <= 100u)) {
                                                let _e570 = targetIndex_1;
                                                param_458 = 5u;
                                                param_459 = 0u;
                                                param_460 = 0u;
                                                param_461 = 0u;
                                                let _e573 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_458), (&param_459), (&param_460), (&param_461));
                                                let _e574 = atomicCompareExchangeWeak((&unnamed.grid[_e570]), 0u, _e573);
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
    let _e576 = newAge_1;
    let _e578 = tuning.fireLifetime;
    if (_e576 > _e578) {
        let _e580 = (*currentIndex_7);
        let _e583 = atomicExchange((&unnamed.grid[_e580]), 0u);
        return;
    }
    let _e584 = (*currentIndex_7);
    let _e587 = (*rawValue_6);
    param_462 = 5u;
    param_463 = 0u;
    param_464 = 0u;
    let _e588 = newAge_1;
    param_465 = _e588;
    let _e589 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_462), (&param_463), (&param_464), (&param_465));
    let _e590 = atomicCompareExchangeWeak((&unnamed.grid[_e584]), _e587, _e589);
    return;
}

fn isLocust_u0028_u1_u003b(type_36: ptr<function, u32>) -> bool {
    let _e194 = (*type_36);
    let _e196 = (*type_36);
    return ((_e194 >= 13u) && (_e196 <= 17u));
}

fn tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex_8: ptr<function, u32>, currentValue_1: ptr<function, u32>, targetIndex_2: ptr<function, u32>, targetValue_1: ptr<function, u32>, pushIndex: ptr<function, u32>) -> bool {
    var displacedValue: u32;
    var param_466: u32;
    var param_467: u32;
    var param_468: u32;
    var param_469: u32;
    var param_470: u32;
    var actualPush: u32;
    var actualTarget: u32;

    let _e206 = (*currentIndex_8);
    let _e209 = (*currentValue_1);
    let _e210 = atomicCompareExchangeWeak((&unnamed.grid[_e206]), _e209, 0u);
    let _e212 = (*currentValue_1);
    if (_e210.old_value == _e212) {
        let _e214 = (*targetValue_1);
        param_466 = _e214;
        let _e215 = getType_u0028_u1_u003b((&param_466));
        param_467 = _e215;
        param_468 = 0u;
        param_469 = 0u;
        param_470 = 0u;
        let _e216 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_467), (&param_468), (&param_469), (&param_470));
        displacedValue = _e216;
        let _e217 = (*pushIndex);
        let _e220 = displacedValue;
        let _e221 = atomicCompareExchangeWeak((&unnamed.grid[_e217]), 0u, _e220);
        actualPush = _e221.old_value;
        let _e223 = actualPush;
        if (_e223 == 0u) {
            let _e225 = (*targetIndex_2);
            let _e228 = (*targetValue_1);
            let _e229 = (*currentValue_1);
            let _e230 = atomicCompareExchangeWeak((&unnamed.grid[_e225]), _e228, _e229);
            actualTarget = _e230.old_value;
            let _e232 = actualTarget;
            let _e233 = (*targetValue_1);
            if (_e232 == _e233) {
                return true;
            } else {
                let _e235 = (*pushIndex);
                let _e238 = displacedValue;
                let _e239 = atomicCompareExchangeWeak((&unnamed.grid[_e235]), _e238, 0u);
            }
        }
        let _e241 = (*currentIndex_8);
        let _e244 = (*currentValue_1);
        let _e245 = atomicCompareExchangeWeak((&unnamed.grid[_e241]), 0u, _e244);
    }
    return false;
}

fn grainCanMove_u0028_vi3_u003b(pos_11: ptr<function, vec3<i32>>) -> bool {
    var i_14: i32;
    var target_1: vec3<i32>;
    var local_18: i32;
    var local_19: i32;
    var t_3: u32;
    var param_471: vec3<i32>;
    var param_472: u32;
    var param_473: u32;
    var phi_2214_: bool;
    var phi_2221_: bool;
    var phi_2232_: bool;

    let _e203 = (*pos_11)[1u];
    if (_e203 <= 1i) {
        return false;
    }
    i_14 = 0i;
    loop {
        let _e205 = i_14;
        if (_e205 < 5i) {
            let _e207 = (*pos_11);
            let _e208 = i_14;
            if (_e208 == 1i) {
                local_18 = 1i;
            } else {
                let _e210 = i_14;
                local_18 = select(0i, -1i, (_e210 == 2i));
            }
            let _e213 = local_18;
            let _e214 = i_14;
            if (_e214 == 3i) {
                local_19 = 1i;
            } else {
                let _e216 = i_14;
                local_19 = select(0i, -1i, (_e216 == 4i));
            }
            let _e219 = local_19;
            target_1 = (_e207 + vec3<i32>(_e213, -1i, _e219));
            let _e223 = target_1[0u];
            let _e224 = (_e223 <= 0i);
            phi_2214_ = _e224;
            if !(_e224) {
                let _e227 = target_1[0u];
                let _e229 = tuning.gridWidth;
                phi_2214_ = (_e227 >= (bitcast<i32>(_e229) - 1i));
            }
            let _e234 = phi_2214_;
            phi_2221_ = _e234;
            if !(_e234) {
                let _e237 = target_1[2u];
                phi_2221_ = (_e237 <= 0i);
            }
            let _e240 = phi_2221_;
            phi_2232_ = _e240;
            if !(_e240) {
                let _e243 = target_1[2u];
                let _e245 = tuning.gridDepth;
                phi_2232_ = (_e243 >= (bitcast<i32>(_e245) - 1i));
            }
            let _e250 = phi_2232_;
            if _e250 {
                continue;
            }
            let _e251 = target_1;
            param_471 = _e251;
            let _e252 = getIndex_u0028_vi3_u003b((&param_471));
            param_472 = _e252;
            let _e253 = readCell_u0028_u1_u003b((&param_472));
            param_473 = _e253;
            let _e254 = getType_u0028_u1_u003b((&param_473));
            t_3 = _e254;
            let _e255 = t_3;
            let _e257 = t_3;
            if ((_e255 == 0u) || (_e257 == 2u)) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e260 = i_14;
            i_14 = (_e260 + 1i);
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
    var param_474: i32;
    var nIndex_3: u32;
    var param_475: vec3<i32>;
    var nVal_3: u32;
    var param_476: u32;
    var param_477: u32;
    var d_12: i32;
    var nPos_4: vec3<i32>;
    var param_478: i32;
    var nIndex_4: u32;
    var param_479: vec3<i32>;
    var nVal_4: u32;
    var param_480: u32;
    var nType_2: u32;
    var param_481: u32;
    var nMoisture: u32;
    var param_482: u32;
    var nCapacity: u32;
    var local_20: u32;
    var canMove: bool;
    var param_483: vec3<i32>;
    var isClumped: bool;
    var emptyBelowCount: i32;
    var x: i32;
    var z: i32;
    var checkPos_1: vec3<i32>;
    var param_484: vec3<i32>;
    var param_485: u32;
    var param_486: u32;
    var clumpCount: i32;
    var x_1: i32;
    var y: i32;
    var z_1: i32;
    var nPos_5: vec3<i32>;
    var param_487: vec3<i32>;
    var param_488: u32;
    var param_489: u32;
    var belowPos_5: vec3<i32>;
    var param_490: vec3<i32>;
    var param_491: u32;
    var param_492: u32;
    var param_493: vec3<i32>;
    var param_494: u32;
    var param_495: u32;
    var param_496: u32;
    var param_497: u32;
    var param_498: u32;
    var param_499: u32;
    var param_500: u32;
    var param_501: u32;
    var dir_2: i32;
    var slidePos1_: vec3<i32>;
    var slidePos2_: vec3<i32>;
    var param_502: vec3<i32>;
    var param_503: u32;
    var param_504: u32;
    var param_505: vec3<i32>;
    var param_506: u32;
    var param_507: u32;
    var param_508: u32;
    var param_509: u32;
    var param_510: u32;
    var param_511: u32;
    var param_512: u32;
    var param_513: u32;
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
    var belowPos_6: vec3<i32>;
    var belowIndex_2: u32;
    var param_526: vec3<i32>;
    var belowValue_2: u32;
    var param_527: u32;
    var param_528: u32;
    var startDir_2: i32;
    var i_16: i32;
    var d_13: i32;
    var pushPos: vec3<i32>;
    var param_529: i32;
    var param_530: u32;
    var param_531: u32;
    var param_532: u32;
    var param_533: u32;
    var param_534: vec3<i32>;
    var param_535: u32;
    var param_536: u32;
    var param_537: u32;
    var param_538: u32;
    var param_539: u32;
    var param_540: u32;
    var param_541: u32;
    var param_542: u32;
    var param_543: u32;
    var param_544: u32;
    var param_545: u32;
    var param_546: u32;
    var param_547: u32;
    var dir_3: i32;
    var slidePos: array<vec3<i32>, 2>;
    var s_1: i32;
    var sPos_2: vec3<i32>;
    var sIndex: u32;
    var param_548: vec3<i32>;
    var sValue: u32;
    var param_549: u32;
    var param_550: u32;
    var startDir_3: i32;
    var i_17: i32;
    var d_14: i32;
    var pushPos_1: vec3<i32>;
    var param_551: i32;
    var param_552: u32;
    var param_553: u32;
    var param_554: u32;
    var param_555: u32;
    var param_556: vec3<i32>;
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
    var param_567: u32;
    var param_568: u32;
    var param_569: u32;
    var floraState: u32;
    var abovePos_1: vec3<i32>;
    var aboveInside: bool;
    var aboveIndex: u32;
    var param_570: vec3<i32>;
    var aboveType: u32;
    var local_21: u32;
    var param_571: u32;
    var param_572: u32;
    var param_573: u32;
    var param_574: u32;
    var param_575: u32;
    var param_576: u32;
    var param_577: u32;
    var newSleep_2: u32;
    var param_578: u32;
    var param_579: u32;
    var param_580: u32;
    var param_581: u32;
    var phi_3346_: bool;
    var phi_3352_: bool;
    var phi_3362_: bool;
    var phi_3368_: bool;
    var phi_3378_: bool;
    var phi_3444_: bool;
    var phi_3450_: bool;
    var phi_3460_: bool;
    var phi_3466_: bool;
    var phi_3476_: bool;
    var phi_3546_: bool;
    var phi_3588_: bool;
    var phi_3594_: bool;
    var phi_3603_: bool;
    var phi_3684_: bool;
    var phi_3690_: bool;
    var phi_3699_: bool;
    var phi_3705_: bool;
    var phi_3714_: bool;
    var phi_3833_: bool;
    var phi_3839_: bool;
    var phi_3849_: bool;
    var phi_3893_: bool;
    var phi_3899_: bool;
    var phi_3909_: bool;
    var phi_4000_: bool;
    var phi_4006_: bool;
    var phi_4016_: bool;
    var phi_4117_: bool;
    var phi_4123_: bool;
    var phi_4133_: bool;
    var phi_4190_: bool;
    var phi_4196_: bool;
    var phi_4206_: bool;
    var phi_4261_: bool;
    var phi_4335_: bool;
    var phi_4390_: bool;

    let _e363 = (*currentAge_7);
    moisture_4 = _e363;
    moistureModified = false;
    let _e364 = moisture_4;
    let _e366 = tuning.dirtMoistureCapacity;
    if (_e364 < _e366) {
        let _e368 = (*randVal_9);
        startDir_1 = i32((fract((_e368 * 17f)) * 6f));
        i_15 = 0i;
        loop {
            let _e373 = i_15;
            if (_e373 < 6i) {
                let _e375 = startDir_1;
                let _e376 = i_15;
                let _e377 = (_e375 + _e376);
                d_11 = (_e377 - (i32(floor((f32(_e377) / f32(6i)))) * 6i));
                let _e385 = (*pos_12);
                let _e386 = d_11;
                param_474 = _e386;
                let _e387 = getOrthoDir_u0028_i1_u003b((&param_474));
                nPos_3 = (_e385 + _e387);
                let _e390 = nPos_3[0u];
                let _e391 = (_e390 > 0i);
                phi_3346_ = _e391;
                if _e391 {
                    let _e393 = nPos_3[0u];
                    let _e395 = tuning.gridWidth;
                    phi_3346_ = (_e393 < (bitcast<i32>(_e395) - 1i));
                }
                let _e400 = phi_3346_;
                phi_3352_ = _e400;
                if _e400 {
                    let _e402 = nPos_3[1u];
                    phi_3352_ = (_e402 > 0i);
                }
                let _e405 = phi_3352_;
                phi_3362_ = _e405;
                if _e405 {
                    let _e407 = nPos_3[1u];
                    let _e409 = tuning.gridHeight;
                    phi_3362_ = (_e407 < (bitcast<i32>(_e409) - 1i));
                }
                let _e414 = phi_3362_;
                phi_3368_ = _e414;
                if _e414 {
                    let _e416 = nPos_3[2u];
                    phi_3368_ = (_e416 > 0i);
                }
                let _e419 = phi_3368_;
                phi_3378_ = _e419;
                if _e419 {
                    let _e421 = nPos_3[2u];
                    let _e423 = tuning.gridDepth;
                    phi_3378_ = (_e421 < (bitcast<i32>(_e423) - 1i));
                }
                let _e428 = phi_3378_;
                if _e428 {
                    let _e429 = nPos_3;
                    param_475 = _e429;
                    let _e430 = getIndex_u0028_vi3_u003b((&param_475));
                    nIndex_3 = _e430;
                    let _e431 = nIndex_3;
                    param_476 = _e431;
                    let _e432 = readCell_u0028_u1_u003b((&param_476));
                    nVal_3 = _e432;
                    let _e433 = nVal_3;
                    param_477 = _e433;
                    let _e434 = getType_u0028_u1_u003b((&param_477));
                    if (_e434 == 2u) {
                        let _e436 = nIndex_3;
                        let _e439 = nVal_3;
                        let _e440 = atomicCompareExchangeWeak((&unnamed.grid[_e436]), _e439, 0u);
                        let _e442 = nVal_3;
                        if (_e440.old_value == _e442) {
                            let _e444 = (*currentIndex_9);
                            let _e448 = tuning.sandWaterAbsorbUnit;
                            let _e451 = atomicAdd((&unnamed.grid[_e444]), (_e448 << bitcast<u32>(24i)));
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
                let _e452 = i_15;
                i_15 = (_e452 + 1i);
            }
        }
    }
    let _e454 = moistureModified;
    let _e456 = moisture_4;
    if (!(_e454) && (_e456 > 0u)) {
        let _e459 = (*randVal_9);
        d_12 = i32((fract((_e459 * 31f)) * 6f));
        let _e464 = (*pos_12);
        let _e465 = d_12;
        param_478 = _e465;
        let _e466 = getOrthoDir_u0028_i1_u003b((&param_478));
        nPos_4 = (_e464 + _e466);
        let _e469 = nPos_4[0u];
        let _e470 = (_e469 > 0i);
        phi_3444_ = _e470;
        if _e470 {
            let _e472 = nPos_4[0u];
            let _e474 = tuning.gridWidth;
            phi_3444_ = (_e472 < (bitcast<i32>(_e474) - 1i));
        }
        let _e479 = phi_3444_;
        phi_3450_ = _e479;
        if _e479 {
            let _e481 = nPos_4[1u];
            phi_3450_ = (_e481 > 0i);
        }
        let _e484 = phi_3450_;
        phi_3460_ = _e484;
        if _e484 {
            let _e486 = nPos_4[1u];
            let _e488 = tuning.gridHeight;
            phi_3460_ = (_e486 < (bitcast<i32>(_e488) - 1i));
        }
        let _e493 = phi_3460_;
        phi_3466_ = _e493;
        if _e493 {
            let _e495 = nPos_4[2u];
            phi_3466_ = (_e495 > 0i);
        }
        let _e498 = phi_3466_;
        phi_3476_ = _e498;
        if _e498 {
            let _e500 = nPos_4[2u];
            let _e502 = tuning.gridDepth;
            phi_3476_ = (_e500 < (bitcast<i32>(_e502) - 1i));
        }
        let _e507 = phi_3476_;
        if _e507 {
            let _e508 = nPos_4;
            param_479 = _e508;
            let _e509 = getIndex_u0028_vi3_u003b((&param_479));
            nIndex_4 = _e509;
            let _e510 = nIndex_4;
            param_480 = _e510;
            let _e511 = readCell_u0028_u1_u003b((&param_480));
            nVal_4 = _e511;
            let _e512 = nVal_4;
            param_481 = _e512;
            let _e513 = getType_u0028_u1_u003b((&param_481));
            nType_2 = _e513;
            let _e514 = nType_2;
            let _e516 = nType_2;
            if ((_e514 == 4u) || (_e516 == 1u)) {
                let _e519 = nVal_4;
                param_482 = _e519;
                let _e520 = getAge_u0028_u1_u003b((&param_482));
                nMoisture = _e520;
                let _e521 = nType_2;
                if (_e521 == 4u) {
                    let _e524 = tuning.dirtMoistureCapacity;
                    local_20 = _e524;
                } else {
                    let _e526 = tuning.sandMoistureCapacity;
                    local_20 = _e526;
                }
                let _e527 = local_20;
                nCapacity = _e527;
                let _e528 = moisture_4;
                let _e529 = nMoisture;
                let _e532 = nMoisture;
                let _e533 = nCapacity;
                if ((_e528 > (_e529 + 1u)) && (_e532 < _e533)) {
                    let _e536 = (*currentIndex_9);
                    let _e539 = atomicAdd((&unnamed.grid[_e536]), 4278190080u);
                    let _e540 = nIndex_4;
                    let _e543 = atomicAdd((&unnamed.grid[_e540]), 16777216u);
                    moistureModified = true;
                }
            }
        }
    }
    let _e544 = moistureModified;
    if _e544 {
        return;
    }
    let _e545 = (*pos_12);
    param_483 = _e545;
    let _e546 = grainCanMove_u0028_vi3_u003b((&param_483));
    canMove = _e546;
    isClumped = false;
    let _e547 = canMove;
    phi_3546_ = _e547;
    if _e547 {
        let _e548 = (*currentSleep_4);
        let _e550 = tuning.wakeSleepThreshold;
        phi_3546_ = (_e548 > _e550);
    }
    let _e553 = phi_3546_;
    if _e553 {
        emptyBelowCount = 0i;
        let _e555 = (*pos_12)[1u];
        if (_e555 > 1i) {
            x = -1i;
            loop {
                let _e557 = x;
                if (_e557 <= 1i) {
                    z = -1i;
                    loop {
                        let _e559 = z;
                        if (_e559 <= 1i) {
                            let _e561 = (*pos_12);
                            let _e562 = x;
                            let _e563 = z;
                            checkPos_1 = (_e561 + vec3<i32>(_e562, -1i, _e563));
                            let _e567 = checkPos_1[0u];
                            let _e568 = (_e567 >= 0i);
                            phi_3588_ = _e568;
                            if _e568 {
                                let _e570 = checkPos_1[0u];
                                let _e572 = tuning.gridWidth;
                                phi_3588_ = (_e570 < bitcast<i32>(_e572));
                            }
                            let _e576 = phi_3588_;
                            phi_3594_ = _e576;
                            if _e576 {
                                let _e578 = checkPos_1[2u];
                                phi_3594_ = (_e578 >= 0i);
                            }
                            let _e581 = phi_3594_;
                            phi_3603_ = _e581;
                            if _e581 {
                                let _e583 = checkPos_1[2u];
                                let _e585 = tuning.gridDepth;
                                phi_3603_ = (_e583 < bitcast<i32>(_e585));
                            }
                            let _e589 = phi_3603_;
                            if _e589 {
                                let _e590 = checkPos_1;
                                param_484 = _e590;
                                let _e591 = getIndex_u0028_vi3_u003b((&param_484));
                                param_485 = _e591;
                                let _e592 = readCell_u0028_u1_u003b((&param_485));
                                param_486 = _e592;
                                let _e593 = getType_u0028_u1_u003b((&param_486));
                                if (_e593 == 0u) {
                                    let _e595 = emptyBelowCount;
                                    emptyBelowCount = (_e595 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e597 = z;
                            z = (_e597 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e599 = x;
                    x = (_e599 + 1i);
                }
            }
        }
        let _e601 = emptyBelowCount;
        let _e603 = tuning.emptyBelowWakeCount;
        if (_e601 >= bitcast<i32>(_e603)) {
            (*currentSleep_4) = 0u;
        } else {
            clumpCount = 0i;
            x_1 = -1i;
            loop {
                let _e606 = x_1;
                if (_e606 <= 1i) {
                    y = -1i;
                    loop {
                        let _e608 = y;
                        if (_e608 <= 1i) {
                            z_1 = -1i;
                            loop {
                                let _e610 = z_1;
                                if (_e610 <= 1i) {
                                    let _e612 = x_1;
                                    let _e614 = y;
                                    let _e617 = z_1;
                                    if (((_e612 == 0i) && (_e614 == 0i)) && (_e617 == 0i)) {
                                        continue;
                                    }
                                    let _e620 = (*pos_12);
                                    let _e621 = x_1;
                                    let _e622 = y;
                                    let _e623 = z_1;
                                    nPos_5 = (_e620 + vec3<i32>(_e621, _e622, _e623));
                                    let _e627 = nPos_5[0u];
                                    let _e628 = (_e627 >= 0i);
                                    phi_3684_ = _e628;
                                    if _e628 {
                                        let _e630 = nPos_5[0u];
                                        let _e632 = tuning.gridWidth;
                                        phi_3684_ = (_e630 < bitcast<i32>(_e632));
                                    }
                                    let _e636 = phi_3684_;
                                    phi_3690_ = _e636;
                                    if _e636 {
                                        let _e638 = nPos_5[1u];
                                        phi_3690_ = (_e638 >= 0i);
                                    }
                                    let _e641 = phi_3690_;
                                    phi_3699_ = _e641;
                                    if _e641 {
                                        let _e643 = nPos_5[1u];
                                        let _e645 = tuning.gridHeight;
                                        phi_3699_ = (_e643 < bitcast<i32>(_e645));
                                    }
                                    let _e649 = phi_3699_;
                                    phi_3705_ = _e649;
                                    if _e649 {
                                        let _e651 = nPos_5[2u];
                                        phi_3705_ = (_e651 >= 0i);
                                    }
                                    let _e654 = phi_3705_;
                                    phi_3714_ = _e654;
                                    if _e654 {
                                        let _e656 = nPos_5[2u];
                                        let _e658 = tuning.gridDepth;
                                        phi_3714_ = (_e656 < bitcast<i32>(_e658));
                                    }
                                    let _e662 = phi_3714_;
                                    if _e662 {
                                        let _e663 = nPos_5;
                                        param_487 = _e663;
                                        let _e664 = getIndex_u0028_vi3_u003b((&param_487));
                                        param_488 = _e664;
                                        let _e665 = readCell_u0028_u1_u003b((&param_488));
                                        param_489 = _e665;
                                        let _e666 = getType_u0028_u1_u003b((&param_489));
                                        if (_e666 == 4u) {
                                            let _e668 = clumpCount;
                                            clumpCount = (_e668 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e670 = z_1;
                                    z_1 = (_e670 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e672 = y;
                            y = (_e672 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e674 = x_1;
                    x_1 = (_e674 + 1i);
                }
            }
            let _e676 = clumpCount;
            let _e678 = tuning.dirtClumpThreshold;
            if (_e676 >= bitcast<i32>(_e678)) {
                isClumped = true;
            }
        }
    }
    let _e681 = canMove;
    let _e682 = isClumped;
    if (_e681 && !(_e682)) {
        let _e686 = (*pos_12)[1u];
        if (_e686 > 1i) {
            let _e688 = (*pos_12);
            belowPos_5 = (_e688 + vec3<i32>(0i, -1i, 0i));
            let _e690 = belowPos_5;
            param_490 = _e690;
            let _e691 = getIndex_u0028_vi3_u003b((&param_490));
            param_491 = _e691;
            let _e692 = readCell_u0028_u1_u003b((&param_491));
            param_492 = _e692;
            let _e693 = getType_u0028_u1_u003b((&param_492));
            if (_e693 == 0u) {
                let _e695 = belowPos_5;
                param_493 = _e695;
                let _e696 = getIndex_u0028_vi3_u003b((&param_493));
                param_494 = 4u;
                param_495 = 0u;
                param_496 = 0u;
                let _e697 = moisture_4;
                param_497 = _e697;
                let _e698 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_494), (&param_495), (&param_496), (&param_497));
                let _e699 = (*currentIndex_9);
                param_498 = _e699;
                let _e700 = (*rawValue_7);
                param_499 = _e700;
                param_500 = _e696;
                param_501 = _e698;
                let _e701 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_498), (&param_499), (&param_500), (&param_501));
                if _e701 {
                    return;
                }
            }
        }
        let _e703 = (*pos_12)[1u];
        if (_e703 > 1i) {
            let _e705 = (*randVal_9);
            dir_2 = select(-1i, 1i, (fract((_e705 * 10f)) > 0.5f));
            let _e710 = (*randVal_9);
            if (fract((_e710 * 100f)) > 0.5f) {
                let _e714 = (*pos_12);
                let _e715 = dir_2;
                slidePos1_ = (_e714 + vec3<i32>(_e715, -1i, 0i));
                let _e718 = (*pos_12);
                let _e719 = dir_2;
                slidePos2_ = (_e718 + vec3<i32>(0i, -1i, _e719));
            } else {
                let _e722 = (*pos_12);
                let _e723 = dir_2;
                slidePos1_ = (_e722 + vec3<i32>(0i, -1i, _e723));
                let _e726 = (*pos_12);
                let _e727 = dir_2;
                slidePos2_ = (_e726 + vec3<i32>(_e727, -1i, 0i));
            }
            let _e731 = slidePos1_[0u];
            let _e732 = (_e731 > 0i);
            phi_3833_ = _e732;
            if _e732 {
                let _e734 = slidePos1_[0u];
                let _e736 = tuning.gridWidth;
                phi_3833_ = (_e734 < (bitcast<i32>(_e736) - 1i));
            }
            let _e741 = phi_3833_;
            phi_3839_ = _e741;
            if _e741 {
                let _e743 = slidePos1_[2u];
                phi_3839_ = (_e743 > 0i);
            }
            let _e746 = phi_3839_;
            phi_3849_ = _e746;
            if _e746 {
                let _e748 = slidePos1_[2u];
                let _e750 = tuning.gridDepth;
                phi_3849_ = (_e748 < (bitcast<i32>(_e750) - 1i));
            }
            let _e755 = phi_3849_;
            if _e755 {
                let _e756 = slidePos1_;
                param_502 = _e756;
                let _e757 = getIndex_u0028_vi3_u003b((&param_502));
                param_503 = _e757;
                let _e758 = readCell_u0028_u1_u003b((&param_503));
                param_504 = _e758;
                let _e759 = getType_u0028_u1_u003b((&param_504));
                if (_e759 == 0u) {
                    let _e761 = slidePos1_;
                    param_505 = _e761;
                    let _e762 = getIndex_u0028_vi3_u003b((&param_505));
                    param_506 = 4u;
                    param_507 = 0u;
                    param_508 = 0u;
                    let _e763 = moisture_4;
                    param_509 = _e763;
                    let _e764 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_506), (&param_507), (&param_508), (&param_509));
                    let _e765 = (*currentIndex_9);
                    param_510 = _e765;
                    let _e766 = (*rawValue_7);
                    param_511 = _e766;
                    param_512 = _e762;
                    param_513 = _e764;
                    let _e767 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_510), (&param_511), (&param_512), (&param_513));
                    if _e767 {
                        return;
                    }
                }
            }
            let _e769 = slidePos2_[0u];
            let _e770 = (_e769 > 0i);
            phi_3893_ = _e770;
            if _e770 {
                let _e772 = slidePos2_[0u];
                let _e774 = tuning.gridWidth;
                phi_3893_ = (_e772 < (bitcast<i32>(_e774) - 1i));
            }
            let _e779 = phi_3893_;
            phi_3899_ = _e779;
            if _e779 {
                let _e781 = slidePos2_[2u];
                phi_3899_ = (_e781 > 0i);
            }
            let _e784 = phi_3899_;
            phi_3909_ = _e784;
            if _e784 {
                let _e786 = slidePos2_[2u];
                let _e788 = tuning.gridDepth;
                phi_3909_ = (_e786 < (bitcast<i32>(_e788) - 1i));
            }
            let _e793 = phi_3909_;
            if _e793 {
                let _e794 = slidePos2_;
                param_514 = _e794;
                let _e795 = getIndex_u0028_vi3_u003b((&param_514));
                param_515 = _e795;
                let _e796 = readCell_u0028_u1_u003b((&param_515));
                param_516 = _e796;
                let _e797 = getType_u0028_u1_u003b((&param_516));
                if (_e797 == 0u) {
                    let _e799 = slidePos2_;
                    param_517 = _e799;
                    let _e800 = getIndex_u0028_vi3_u003b((&param_517));
                    param_518 = 4u;
                    param_519 = 0u;
                    param_520 = 0u;
                    let _e801 = moisture_4;
                    param_521 = _e801;
                    let _e802 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_518), (&param_519), (&param_520), (&param_521));
                    let _e803 = (*currentIndex_9);
                    param_522 = _e803;
                    let _e804 = (*rawValue_7);
                    param_523 = _e804;
                    param_524 = _e800;
                    param_525 = _e802;
                    let _e805 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_522), (&param_523), (&param_524), (&param_525));
                    if _e805 {
                        return;
                    }
                }
            }
        }
        let _e807 = (*pos_12)[1u];
        if (_e807 > 1i) {
            let _e809 = (*pos_12);
            belowPos_6 = (_e809 + vec3<i32>(0i, -1i, 0i));
            let _e811 = belowPos_6;
            param_526 = _e811;
            let _e812 = getIndex_u0028_vi3_u003b((&param_526));
            belowIndex_2 = _e812;
            let _e813 = belowIndex_2;
            param_527 = _e813;
            let _e814 = readCell_u0028_u1_u003b((&param_527));
            belowValue_2 = _e814;
            let _e815 = belowValue_2;
            param_528 = _e815;
            let _e816 = getType_u0028_u1_u003b((&param_528));
            if (_e816 == 2u) {
                let _e818 = (*randVal_9);
                startDir_2 = i32((fract((_e818 * 8f)) * 8f));
                i_16 = 0i;
                loop {
                    let _e823 = i_16;
                    if (_e823 < 8i) {
                        let _e825 = startDir_2;
                        let _e826 = i_16;
                        let _e827 = (_e825 + _e826);
                        d_13 = (_e827 - (i32(floor((f32(_e827) / f32(8i)))) * 8i));
                        let _e835 = belowPos_6;
                        let _e836 = d_13;
                        param_529 = _e836;
                        let _e837 = getHDir_u0028_i1_u003b((&param_529));
                        pushPos = (_e835 + _e837);
                        let _e840 = pushPos[0u];
                        let _e841 = (_e840 > 0i);
                        phi_4000_ = _e841;
                        if _e841 {
                            let _e843 = pushPos[0u];
                            let _e845 = tuning.gridWidth;
                            phi_4000_ = (_e843 < (bitcast<i32>(_e845) - 1i));
                        }
                        let _e850 = phi_4000_;
                        phi_4006_ = _e850;
                        if _e850 {
                            let _e852 = pushPos[2u];
                            phi_4006_ = (_e852 > 0i);
                        }
                        let _e855 = phi_4006_;
                        phi_4016_ = _e855;
                        if _e855 {
                            let _e857 = pushPos[2u];
                            let _e859 = tuning.gridDepth;
                            phi_4016_ = (_e857 < (bitcast<i32>(_e859) - 1i));
                        }
                        let _e864 = phi_4016_;
                        if _e864 {
                            param_530 = 4u;
                            param_531 = 0u;
                            param_532 = 0u;
                            let _e865 = moisture_4;
                            param_533 = _e865;
                            let _e866 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_530), (&param_531), (&param_532), (&param_533));
                            let _e867 = pushPos;
                            param_534 = _e867;
                            let _e868 = getIndex_u0028_vi3_u003b((&param_534));
                            let _e869 = (*currentIndex_9);
                            param_535 = _e869;
                            param_536 = _e866;
                            let _e870 = belowIndex_2;
                            param_537 = _e870;
                            let _e871 = belowValue_2;
                            param_538 = _e871;
                            param_539 = _e868;
                            let _e872 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_535), (&param_536), (&param_537), (&param_538), (&param_539));
                            if _e872 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e873 = i_16;
                        i_16 = (_e873 + 1i);
                    }
                }
                param_540 = 4u;
                param_541 = 0u;
                param_542 = 0u;
                let _e875 = moisture_4;
                param_543 = _e875;
                let _e876 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_540), (&param_541), (&param_542), (&param_543));
                let _e877 = (*currentIndex_9);
                param_544 = _e877;
                let _e878 = (*rawValue_7);
                param_545 = _e878;
                let _e879 = belowIndex_2;
                param_546 = _e879;
                param_547 = _e876;
                let _e880 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_544), (&param_545), (&param_546), (&param_547));
                if _e880 {
                    return;
                }
            }
            let _e881 = (*randVal_9);
            dir_3 = select(-1i, 1i, (fract((_e881 * 10f)) > 0.5f));
            let _e886 = (*randVal_9);
            if (fract((_e886 * 100f)) > 0.5f) {
                let _e890 = (*pos_12);
                let _e891 = dir_3;
                slidePos[0i] = (_e890 + vec3<i32>(_e891, -1i, 0i));
                let _e895 = (*pos_12);
                let _e896 = dir_3;
                slidePos[1i] = (_e895 + vec3<i32>(0i, -1i, _e896));
            } else {
                let _e900 = (*pos_12);
                let _e901 = dir_3;
                slidePos[0i] = (_e900 + vec3<i32>(0i, -1i, _e901));
                let _e905 = (*pos_12);
                let _e906 = dir_3;
                slidePos[1i] = (_e905 + vec3<i32>(_e906, -1i, 0i));
            }
            s_1 = 0i;
            loop {
                let _e910 = s_1;
                if (_e910 < 2i) {
                    let _e912 = s_1;
                    let _e914 = slidePos[_e912];
                    sPos_2 = _e914;
                    let _e916 = sPos_2[0u];
                    let _e917 = (_e916 > 0i);
                    phi_4117_ = _e917;
                    if _e917 {
                        let _e919 = sPos_2[0u];
                        let _e921 = tuning.gridWidth;
                        phi_4117_ = (_e919 < (bitcast<i32>(_e921) - 1i));
                    }
                    let _e926 = phi_4117_;
                    phi_4123_ = _e926;
                    if _e926 {
                        let _e928 = sPos_2[2u];
                        phi_4123_ = (_e928 > 0i);
                    }
                    let _e931 = phi_4123_;
                    phi_4133_ = _e931;
                    if _e931 {
                        let _e933 = sPos_2[2u];
                        let _e935 = tuning.gridDepth;
                        phi_4133_ = (_e933 < (bitcast<i32>(_e935) - 1i));
                    }
                    let _e940 = phi_4133_;
                    if _e940 {
                        let _e941 = sPos_2;
                        param_548 = _e941;
                        let _e942 = getIndex_u0028_vi3_u003b((&param_548));
                        sIndex = _e942;
                        let _e943 = sIndex;
                        param_549 = _e943;
                        let _e944 = readCell_u0028_u1_u003b((&param_549));
                        sValue = _e944;
                        let _e945 = sValue;
                        param_550 = _e945;
                        let _e946 = getType_u0028_u1_u003b((&param_550));
                        if (_e946 == 2u) {
                            let _e948 = (*randVal_9);
                            let _e950 = s_1;
                            startDir_3 = i32((fract(((_e948 * 8f) + f32(_e950))) * 8f));
                            i_17 = 0i;
                            loop {
                                let _e956 = i_17;
                                if (_e956 < 8i) {
                                    let _e958 = startDir_3;
                                    let _e959 = i_17;
                                    let _e960 = (_e958 + _e959);
                                    d_14 = (_e960 - (i32(floor((f32(_e960) / f32(8i)))) * 8i));
                                    let _e968 = sPos_2;
                                    let _e969 = d_14;
                                    param_551 = _e969;
                                    let _e970 = getHDir_u0028_i1_u003b((&param_551));
                                    pushPos_1 = (_e968 + _e970);
                                    let _e973 = pushPos_1[0u];
                                    let _e974 = (_e973 > 0i);
                                    phi_4190_ = _e974;
                                    if _e974 {
                                        let _e976 = pushPos_1[0u];
                                        let _e978 = tuning.gridWidth;
                                        phi_4190_ = (_e976 < (bitcast<i32>(_e978) - 1i));
                                    }
                                    let _e983 = phi_4190_;
                                    phi_4196_ = _e983;
                                    if _e983 {
                                        let _e985 = pushPos_1[2u];
                                        phi_4196_ = (_e985 > 0i);
                                    }
                                    let _e988 = phi_4196_;
                                    phi_4206_ = _e988;
                                    if _e988 {
                                        let _e990 = pushPos_1[2u];
                                        let _e992 = tuning.gridDepth;
                                        phi_4206_ = (_e990 < (bitcast<i32>(_e992) - 1i));
                                    }
                                    let _e997 = phi_4206_;
                                    if _e997 {
                                        param_552 = 4u;
                                        param_553 = 0u;
                                        param_554 = 0u;
                                        let _e998 = moisture_4;
                                        param_555 = _e998;
                                        let _e999 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_552), (&param_553), (&param_554), (&param_555));
                                        let _e1000 = pushPos_1;
                                        param_556 = _e1000;
                                        let _e1001 = getIndex_u0028_vi3_u003b((&param_556));
                                        let _e1002 = (*currentIndex_9);
                                        param_557 = _e1002;
                                        param_558 = _e999;
                                        let _e1003 = sIndex;
                                        param_559 = _e1003;
                                        let _e1004 = sValue;
                                        param_560 = _e1004;
                                        param_561 = _e1001;
                                        let _e1005 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_557), (&param_558), (&param_559), (&param_560), (&param_561));
                                        if _e1005 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1006 = i_17;
                                    i_17 = (_e1006 + 1i);
                                }
                            }
                            param_562 = 4u;
                            param_563 = 0u;
                            param_564 = 0u;
                            let _e1008 = moisture_4;
                            param_565 = _e1008;
                            let _e1009 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_562), (&param_563), (&param_564), (&param_565));
                            let _e1010 = (*currentIndex_9);
                            param_566 = _e1010;
                            let _e1011 = (*rawValue_7);
                            param_567 = _e1011;
                            let _e1012 = sIndex;
                            param_568 = _e1012;
                            param_569 = _e1009;
                            let _e1013 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_566), (&param_567), (&param_568), (&param_569));
                            if _e1013 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1014 = s_1;
                    s_1 = (_e1014 + 1i);
                }
            }
        }
    }
    let _e1016 = (*currentDir_4);
    floraState = _e1016;
    let _e1017 = isClumped;
    phi_4261_ = _e1017;
    if !(_e1017) {
        let _e1019 = (*currentSleep_4);
        let _e1021 = tuning.wakeSleepThreshold;
        phi_4261_ = (_e1019 > _e1021);
    }
    let _e1024 = phi_4261_;
    if _e1024 {
        let _e1025 = (*pos_12);
        abovePos_1 = (_e1025 + vec3<i32>(0i, 1i, 0i));
        let _e1028 = abovePos_1[1u];
        let _e1030 = tuning.gridHeight;
        aboveInside = (_e1028 < (bitcast<i32>(_e1030) - 1i));
        let _e1034 = abovePos_1;
        param_570 = _e1034;
        let _e1035 = getIndex_u0028_vi3_u003b((&param_570));
        aboveIndex = _e1035;
        let _e1036 = aboveInside;
        if _e1036 {
            let _e1037 = aboveIndex;
            param_571 = _e1037;
            let _e1038 = readCell_u0028_u1_u003b((&param_571));
            param_572 = _e1038;
            let _e1039 = getType_u0028_u1_u003b((&param_572));
            local_21 = _e1039;
        } else {
            local_21 = 0u;
        }
        let _e1040 = local_21;
        aboveType = _e1040;
        let _e1041 = aboveType;
        let _e1043 = aboveType;
        if ((_e1041 == 0u) || (_e1043 == 18u)) {
            let _e1046 = moisture_4;
            let _e1048 = floraState;
            if ((_e1046 >= 5u) && (_e1048 < 100u)) {
                let _e1051 = (*randVal_9);
                let _e1055 = tuning.grassGrowChance;
                if (fract((_e1051 * 55f)) < _e1055) {
                    let _e1057 = floraState;
                    floraState = (_e1057 + bitcast<u32>(1i));
                    let _e1060 = floraState;
                    let _e1062 = aboveType;
                    let _e1065 = aboveInside;
                    let _e1066 = (((_e1060 == 100u) && (_e1062 == 0u)) && _e1065);
                    phi_4335_ = _e1066;
                    if _e1066 {
                        let _e1067 = (*randVal_9);
                        let _e1071 = tuning.treeBloomChance;
                        phi_4335_ = (fract((_e1067 * 97f)) < _e1071);
                    }
                    let _e1074 = phi_4335_;
                    if _e1074 {
                        let _e1075 = aboveIndex;
                        param_573 = 18u;
                        param_574 = 0u;
                        param_575 = 0u;
                        param_576 = 0u;
                        let _e1078 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_573), (&param_574), (&param_575), (&param_576));
                        let _e1079 = atomicCompareExchangeWeak((&unnamed.grid[_e1075]), 0u, _e1078);
                    }
                }
            }
            let _e1081 = floraState;
            if (_e1081 > 100u) {
                floraState = 100u;
            }
        } else {
            let _e1083 = aboveType;
            if (_e1083 == 2u) {
                let _e1085 = floraState;
                if (_e1085 > 0u) {
                    let _e1087 = floraState;
                    if (_e1087 <= 100u) {
                        floraState = 101u;
                    }
                    let _e1089 = (*randVal_9);
                    let _e1093 = tuning.grassSubmergedDecayChance;
                    if (fract((_e1089 * 66f)) < _e1093) {
                        let _e1095 = floraState;
                        floraState = (_e1095 + bitcast<u32>(1i));
                    }
                    let _e1098 = floraState;
                    if (_e1098 >= 200u) {
                        floraState = 0u;
                    }
                }
            } else {
                let _e1100 = aboveType;
                let _e1101 = (_e1100 != 5u);
                phi_4390_ = _e1101;
                if _e1101 {
                    let _e1102 = aboveType;
                    param_577 = _e1102;
                    let _e1103 = isLocust_u0028_u1_u003b((&param_577));
                    phi_4390_ = !(_e1103);
                }
                let _e1106 = phi_4390_;
                if _e1106 {
                    floraState = 0u;
                }
            }
        }
    }
    let _e1107 = (*currentSleep_4);
    newSleep_2 = min((_e1107 + 1u), 255u);
    let _e1110 = (*currentIndex_9);
    let _e1113 = (*rawValue_7);
    param_578 = 4u;
    let _e1114 = floraState;
    param_579 = _e1114;
    let _e1115 = newSleep_2;
    param_580 = _e1115;
    let _e1116 = moisture_4;
    param_581 = _e1116;
    let _e1117 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_578), (&param_579), (&param_580), (&param_581));
    let _e1118 = atomicCompareExchangeWeak((&unnamed.grid[_e1110]), _e1113, _e1117);
    return;
}

fn updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_13: ptr<function, vec3<i32>>, currentIndex_10: ptr<function, u32>, rawValue_8: ptr<function, u32>, currentDir_5: ptr<function, u32>, currentSleep_5: ptr<function, u32>, currentAge_8: ptr<function, u32>, randVal_10: ptr<function, f32>) {
    var wake: bool;
    var param_582: vec3<i32>;
    var param_583: u32;
    var param_584: u32;
    var hasPressure_1: bool;
    var local_22: bool;
    var param_585: vec3<i32>;
    var param_586: u32;
    var param_587: u32;
    var isStackedOnWater: bool;
    var local_23: bool;
    var param_588: vec3<i32>;
    var param_589: u32;
    var param_590: u32;
    var d_15: i32;
    var nPos_6: vec3<i32>;
    var param_591: i32;
    var param_592: vec3<i32>;
    var param_593: u32;
    var param_594: u32;
    var belowNeighbor: u32;
    var param_595: vec3<i32>;
    var param_596: u32;
    var param_597: u32;
    var newAge_2: u32;
    var belowPos_7: vec3<i32>;
    var param_598: vec3<i32>;
    var param_599: u32;
    var param_600: u32;
    var param_601: vec3<i32>;
    var param_602: u32;
    var param_603: u32;
    var param_604: u32;
    var param_605: u32;
    var param_606: u32;
    var param_607: u32;
    var param_608: u32;
    var param_609: u32;
    var newDir: u32;
    var r_1: f32;
    var diagDir: u32;
    var r_2: f32;
    var stepPos: vec3<i32>;
    var param_610: i32;
    var param_611: vec3<i32>;
    var param_612: u32;
    var param_613: u32;
    var newValue_1: u32;
    var param_614: u32;
    var param_615: u32;
    var param_616: u32;
    var param_617: u32;
    var param_618: vec3<i32>;
    var param_619: u32;
    var param_620: u32;
    var param_621: u32;
    var param_622: u32;
    var bestDropPos: vec3<i32>;
    var foundDrop: bool;
    var blockedMask_1: u32;
    var startDir_4: i32;
    var waterReach: i32;
    var r_3: i32;
    var i_18: i32;
    var d_16: i32;
    var c_7: vec3<i32>;
    var param_623: i32;
    var param_624: vec3<i32>;
    var param_625: u32;
    var param_626: u32;
    var param_627: vec3<i32>;
    var param_628: u32;
    var param_629: u32;
    var newValue_2: u32;
    var param_630: u32;
    var param_631: u32;
    var param_632: u32;
    var param_633: u32;
    var param_634: vec3<i32>;
    var param_635: u32;
    var param_636: u32;
    var param_637: u32;
    var param_638: u32;
    var hasPressure_2: bool;
    var local_24: bool;
    var param_639: vec3<i32>;
    var param_640: u32;
    var param_641: u32;
    var isStackedOnWater_1: bool;
    var local_25: bool;
    var param_642: vec3<i32>;
    var param_643: u32;
    var param_644: u32;
    var canStepOntoPool: bool;
    var d_17: i32;
    var nPos_7: vec3<i32>;
    var param_645: i32;
    var param_646: vec3<i32>;
    var param_647: u32;
    var param_648: u32;
    var param_649: vec3<i32>;
    var param_650: u32;
    var param_651: u32;
    var startSpreadDir: i32;
    var i_19: i32;
    var d_18: i32;
    var targetPos_2: vec3<i32>;
    var param_652: i32;
    var param_653: vec3<i32>;
    var param_654: u32;
    var param_655: u32;
    var newValue_3: u32;
    var param_656: u32;
    var param_657: u32;
    var param_658: u32;
    var param_659: u32;
    var param_660: vec3<i32>;
    var param_661: u32;
    var param_662: u32;
    var param_663: u32;
    var param_664: u32;
    var newSleep_3: u32;
    var sleepValue: u32;
    var param_665: u32;
    var param_666: u32;
    var param_667: u32;
    var param_668: u32;
    var phi_4430_: bool;
    var phi_4500_: bool;
    var phi_4506_: bool;
    var phi_4516_: bool;
    var phi_4702_: bool;
    var phi_4708_: bool;
    var phi_4718_: bool;
    var phi_4833_: bool;
    var phi_4840_: bool;
    var phi_4851_: bool;
    var phi_4863_: bool;
    var phi_4885_: bool;
    var phi_4989_: bool;
    var phi_4995_: bool;
    var phi_5005_: bool;
    var phi_5021_: bool;
    var phi_5033_: bool;
    var phi_5083_: bool;
    var phi_5089_: bool;
    var phi_5099_: bool;

    let _e327 = (*currentSleep_5);
    let _e329 = tuning.wakeSleepThreshold;
    if (_e327 > _e329) {
        wake = false;
        let _e332 = (*pos_13)[1u];
        let _e333 = (_e332 > 1i);
        phi_4430_ = _e333;
        if _e333 {
            let _e334 = (*pos_13);
            param_582 = (_e334 + vec3<i32>(0i, -1i, 0i));
            let _e336 = getIndex_u0028_vi3_u003b((&param_582));
            param_583 = _e336;
            let _e337 = readCell_u0028_u1_u003b((&param_583));
            param_584 = _e337;
            let _e338 = getType_u0028_u1_u003b((&param_584));
            phi_4430_ = (_e338 == 0u);
        }
        let _e341 = phi_4430_;
        if _e341 {
            wake = true;
        } else {
            let _e343 = (*pos_13)[1u];
            let _e345 = tuning.gridHeight;
            if (_e343 < (bitcast<i32>(_e345) - 2i)) {
                let _e349 = (*pos_13);
                param_585 = (_e349 + vec3<i32>(0i, 1i, 0i));
                let _e351 = getIndex_u0028_vi3_u003b((&param_585));
                param_586 = _e351;
                let _e352 = readCell_u0028_u1_u003b((&param_586));
                param_587 = _e352;
                let _e353 = getType_u0028_u1_u003b((&param_587));
                local_22 = (_e353 != 0u);
            } else {
                local_22 = false;
            }
            let _e355 = local_22;
            hasPressure_1 = _e355;
            let _e357 = (*pos_13)[1u];
            if (_e357 > 1i) {
                let _e359 = (*pos_13);
                param_588 = (_e359 + vec3<i32>(0i, -1i, 0i));
                let _e361 = getIndex_u0028_vi3_u003b((&param_588));
                param_589 = _e361;
                let _e362 = readCell_u0028_u1_u003b((&param_589));
                param_590 = _e362;
                let _e363 = getType_u0028_u1_u003b((&param_590));
                local_23 = (_e363 == 2u);
            } else {
                local_23 = false;
            }
            let _e365 = local_23;
            isStackedOnWater = _e365;
            d_15 = 0i;
            loop {
                let _e366 = d_15;
                if (_e366 < 8i) {
                    let _e368 = (*pos_13);
                    let _e369 = d_15;
                    param_591 = _e369;
                    let _e370 = getHDir_u0028_i1_u003b((&param_591));
                    nPos_6 = (_e368 + _e370);
                    let _e373 = nPos_6[0u];
                    let _e374 = (_e373 > 0i);
                    phi_4500_ = _e374;
                    if _e374 {
                        let _e376 = nPos_6[0u];
                        let _e378 = tuning.gridWidth;
                        phi_4500_ = (_e376 < (bitcast<i32>(_e378) - 1i));
                    }
                    let _e383 = phi_4500_;
                    phi_4506_ = _e383;
                    if _e383 {
                        let _e385 = nPos_6[2u];
                        phi_4506_ = (_e385 > 0i);
                    }
                    let _e388 = phi_4506_;
                    phi_4516_ = _e388;
                    if _e388 {
                        let _e390 = nPos_6[2u];
                        let _e392 = tuning.gridDepth;
                        phi_4516_ = (_e390 < (bitcast<i32>(_e392) - 1i));
                    }
                    let _e397 = phi_4516_;
                    if _e397 {
                        let _e398 = nPos_6;
                        param_592 = _e398;
                        let _e399 = getIndex_u0028_vi3_u003b((&param_592));
                        param_593 = _e399;
                        let _e400 = readCell_u0028_u1_u003b((&param_593));
                        param_594 = _e400;
                        let _e401 = getType_u0028_u1_u003b((&param_594));
                        if (_e401 == 0u) {
                            let _e403 = nPos_6;
                            param_595 = (_e403 + vec3<i32>(0i, -1i, 0i));
                            let _e405 = getIndex_u0028_vi3_u003b((&param_595));
                            param_596 = _e405;
                            let _e406 = readCell_u0028_u1_u003b((&param_596));
                            param_597 = _e406;
                            let _e407 = getType_u0028_u1_u003b((&param_597));
                            belowNeighbor = _e407;
                            let _e408 = belowNeighbor;
                            let _e410 = hasPressure_1;
                            let _e412 = isStackedOnWater;
                            let _e414 = belowNeighbor;
                            if ((((_e408 == 0u) || _e410) || _e412) || (_e414 == 2u)) {
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
                    let _e417 = d_15;
                    d_15 = (_e417 + 1i);
                }
            }
        }
        let _e419 = wake;
        if !(_e419) {
            return;
        }
        (*currentSleep_5) = 0u;
        (*currentAge_8) = 0u;
    }
    let _e421 = (*currentAge_8);
    newAge_2 = (_e421 + 1u);
    let _e424 = (*pos_13)[1u];
    if (_e424 > 1i) {
        let _e426 = (*pos_13);
        belowPos_7 = (_e426 + vec3<i32>(0i, -1i, 0i));
        let _e428 = belowPos_7;
        param_598 = _e428;
        let _e429 = getIndex_u0028_vi3_u003b((&param_598));
        param_599 = _e429;
        let _e430 = readCell_u0028_u1_u003b((&param_599));
        param_600 = _e430;
        let _e431 = getType_u0028_u1_u003b((&param_600));
        if (_e431 == 0u) {
            let _e433 = belowPos_7;
            param_601 = _e433;
            let _e434 = getIndex_u0028_vi3_u003b((&param_601));
            param_602 = 2u;
            param_603 = 0u;
            param_604 = 0u;
            let _e435 = newAge_2;
            param_605 = _e435;
            let _e436 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_602), (&param_603), (&param_604), (&param_605));
            let _e437 = (*currentIndex_10);
            param_606 = _e437;
            let _e438 = (*rawValue_8);
            param_607 = _e438;
            param_608 = _e434;
            param_609 = _e436;
            let _e439 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_606), (&param_607), (&param_608), (&param_609));
            if _e439 {
                return;
            }
        }
    }
    let _e440 = (*currentDir_5);
    newDir = _e440;
    let _e441 = newDir;
    let _e443 = newDir;
    if ((_e441 == 0u) || (_e443 == 9u)) {
        let _e446 = (*randVal_10);
        r_1 = fract((_e446 * 77f));
        let _e449 = r_1;
        if (_e449 < 0.25f) {
            newDir = 1u;
        } else {
            let _e451 = r_1;
            if (_e451 < 0.5f) {
                newDir = 2u;
            } else {
                let _e453 = r_1;
                if (_e453 < 0.75f) {
                    newDir = 3u;
                } else {
                    newDir = 4u;
                }
            }
        }
    }
    let _e455 = newAge_2;
    let _e458 = newAge_2;
    if (((_e455 % 3u) == 0u) && (_e458 > 0u)) {
        let _e461 = newDir;
        diagDir = _e461;
        let _e462 = diagDir;
        let _e464 = diagDir;
        if ((_e462 >= 1u) && (_e464 <= 4u)) {
            let _e467 = (*randVal_10);
            r_2 = fract((_e467 * 133f));
            let _e470 = diagDir;
            if (_e470 == 1u) {
                let _e472 = r_2;
                diagDir = select(6u, 5u, (_e472 > 0.5f));
            } else {
                let _e475 = diagDir;
                if (_e475 == 2u) {
                    let _e477 = r_2;
                    diagDir = select(8u, 7u, (_e477 > 0.5f));
                } else {
                    let _e480 = diagDir;
                    if (_e480 == 3u) {
                        let _e482 = r_2;
                        diagDir = select(7u, 5u, (_e482 > 0.5f));
                    } else {
                        let _e485 = diagDir;
                        if (_e485 == 4u) {
                            let _e487 = r_2;
                            diagDir = select(8u, 6u, (_e487 > 0.5f));
                        }
                    }
                }
            }
        }
        let _e490 = (*pos_13);
        let _e491 = diagDir;
        param_610 = (bitcast<i32>(_e491) - 1i);
        let _e494 = getHDir_u0028_i1_u003b((&param_610));
        stepPos = (_e490 + _e494);
        let _e497 = stepPos[0u];
        let _e498 = (_e497 > 0i);
        phi_4702_ = _e498;
        if _e498 {
            let _e500 = stepPos[0u];
            let _e502 = tuning.gridWidth;
            phi_4702_ = (_e500 < (bitcast<i32>(_e502) - 1i));
        }
        let _e507 = phi_4702_;
        phi_4708_ = _e507;
        if _e507 {
            let _e509 = stepPos[2u];
            phi_4708_ = (_e509 > 0i);
        }
        let _e512 = phi_4708_;
        phi_4718_ = _e512;
        if _e512 {
            let _e514 = stepPos[2u];
            let _e516 = tuning.gridDepth;
            phi_4718_ = (_e514 < (bitcast<i32>(_e516) - 1i));
        }
        let _e521 = phi_4718_;
        if _e521 {
            let _e522 = stepPos;
            param_611 = _e522;
            let _e523 = getIndex_u0028_vi3_u003b((&param_611));
            param_612 = _e523;
            let _e524 = readCell_u0028_u1_u003b((&param_612));
            param_613 = _e524;
            let _e525 = getType_u0028_u1_u003b((&param_613));
            if (_e525 == 0u) {
                param_614 = 2u;
                let _e527 = newDir;
                param_615 = _e527;
                param_616 = 0u;
                let _e528 = newAge_2;
                param_617 = _e528;
                let _e529 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_614), (&param_615), (&param_616), (&param_617));
                newValue_1 = _e529;
                let _e530 = stepPos;
                param_618 = _e530;
                let _e531 = getIndex_u0028_vi3_u003b((&param_618));
                let _e532 = (*currentIndex_10);
                param_619 = _e532;
                let _e533 = (*rawValue_8);
                param_620 = _e533;
                param_621 = _e531;
                let _e534 = newValue_1;
                param_622 = _e534;
                let _e535 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_619), (&param_620), (&param_621), (&param_622));
                if _e535 {
                    return;
                }
            }
        }
    }
    let _e536 = (*pos_13);
    bestDropPos = _e536;
    foundDrop = false;
    blockedMask_1 = 0u;
    let _e537 = (*randVal_10);
    startDir_4 = i32((fract((_e537 * 8f)) * 8f));
    let _e543 = tuning.waterSpreadRadius;
    let _e545 = tuning.gridWidth;
    let _e548 = tuning.gridHeight;
    waterReach = bitcast<i32>(clamp(_e543, 1u, bitcast<u32>(max(bitcast<i32>(_e545), bitcast<i32>(_e548)))));
    r_3 = 1i;
    loop {
        let _e554 = r_3;
        let _e555 = waterReach;
        if (_e554 <= _e555) {
            let _e557 = blockedMask_1;
            if (_e557 == 255u) {
                break;
            }
            i_18 = 0i;
            loop {
                let _e559 = i_18;
                if (_e559 < 8i) {
                    let _e561 = startDir_4;
                    let _e562 = i_18;
                    let _e563 = (_e561 + _e562);
                    d_16 = (_e563 - (i32(floor((f32(_e563) / f32(8i)))) * 8i));
                    let _e571 = blockedMask_1;
                    let _e572 = d_16;
                    if ((_e571 & (1u << bitcast<u32>(_e572))) == 0u) {
                        let _e577 = (*pos_13);
                        let _e578 = d_16;
                        param_623 = _e578;
                        let _e579 = getHDir_u0028_i1_u003b((&param_623));
                        let _e580 = r_3;
                        c_7 = (_e577 + (_e579 * vec3(_e580)));
                        let _e585 = c_7[0u];
                        let _e586 = (_e585 <= 0i);
                        phi_4833_ = _e586;
                        if !(_e586) {
                            let _e589 = c_7[0u];
                            let _e591 = tuning.gridWidth;
                            phi_4833_ = (_e589 >= (bitcast<i32>(_e591) - 1i));
                        }
                        let _e596 = phi_4833_;
                        phi_4840_ = _e596;
                        if !(_e596) {
                            let _e599 = c_7[2u];
                            phi_4840_ = (_e599 <= 0i);
                        }
                        let _e602 = phi_4840_;
                        phi_4851_ = _e602;
                        if !(_e602) {
                            let _e605 = c_7[2u];
                            let _e607 = tuning.gridDepth;
                            phi_4851_ = (_e605 >= (bitcast<i32>(_e607) - 1i));
                        }
                        let _e612 = phi_4851_;
                        phi_4863_ = _e612;
                        if !(_e612) {
                            let _e614 = c_7;
                            param_624 = _e614;
                            let _e615 = getIndex_u0028_vi3_u003b((&param_624));
                            param_625 = _e615;
                            let _e616 = readCell_u0028_u1_u003b((&param_625));
                            param_626 = _e616;
                            let _e617 = getType_u0028_u1_u003b((&param_626));
                            phi_4863_ = (_e617 != 0u);
                        }
                        let _e620 = phi_4863_;
                        if _e620 {
                            let _e621 = d_16;
                            let _e624 = blockedMask_1;
                            blockedMask_1 = (_e624 | (1u << bitcast<u32>(_e621)));
                        } else {
                            let _e627 = c_7[1u];
                            let _e628 = (_e627 > 1i);
                            phi_4885_ = _e628;
                            if _e628 {
                                let _e629 = c_7;
                                param_627 = (_e629 + vec3<i32>(0i, -1i, 0i));
                                let _e631 = getIndex_u0028_vi3_u003b((&param_627));
                                param_628 = _e631;
                                let _e632 = readCell_u0028_u1_u003b((&param_628));
                                param_629 = _e632;
                                let _e633 = getType_u0028_u1_u003b((&param_629));
                                phi_4885_ = (_e633 == 0u);
                            }
                            let _e636 = phi_4885_;
                            if _e636 {
                                let _e637 = c_7;
                                bestDropPos = _e637;
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
                    let _e638 = i_18;
                    i_18 = (_e638 + 1i);
                }
            }
            let _e640 = foundDrop;
            if _e640 {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e641 = r_3;
            r_3 = (_e641 + 1i);
        }
    }
    let _e643 = foundDrop;
    if _e643 {
        param_630 = 2u;
        param_631 = 0u;
        param_632 = 0u;
        param_633 = 0u;
        let _e644 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_630), (&param_631), (&param_632), (&param_633));
        newValue_2 = _e644;
        let _e645 = bestDropPos;
        param_634 = _e645;
        let _e646 = getIndex_u0028_vi3_u003b((&param_634));
        let _e647 = (*currentIndex_10);
        param_635 = _e647;
        let _e648 = (*rawValue_8);
        param_636 = _e648;
        param_637 = _e646;
        let _e649 = newValue_2;
        param_638 = _e649;
        let _e650 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_635), (&param_636), (&param_637), (&param_638));
        if _e650 {
            return;
        }
    } else {
        let _e652 = (*pos_13)[1u];
        let _e654 = tuning.gridHeight;
        if (_e652 < (bitcast<i32>(_e654) - 2i)) {
            let _e658 = (*pos_13);
            param_639 = (_e658 + vec3<i32>(0i, 1i, 0i));
            let _e660 = getIndex_u0028_vi3_u003b((&param_639));
            param_640 = _e660;
            let _e661 = readCell_u0028_u1_u003b((&param_640));
            param_641 = _e661;
            let _e662 = getType_u0028_u1_u003b((&param_641));
            local_24 = (_e662 != 0u);
        } else {
            local_24 = false;
        }
        let _e664 = local_24;
        hasPressure_2 = _e664;
        let _e666 = (*pos_13)[1u];
        if (_e666 > 1i) {
            let _e668 = (*pos_13);
            param_642 = (_e668 + vec3<i32>(0i, -1i, 0i));
            let _e670 = getIndex_u0028_vi3_u003b((&param_642));
            param_643 = _e670;
            let _e671 = readCell_u0028_u1_u003b((&param_643));
            param_644 = _e671;
            let _e672 = getType_u0028_u1_u003b((&param_644));
            local_25 = (_e672 == 2u);
        } else {
            local_25 = false;
        }
        let _e674 = local_25;
        isStackedOnWater_1 = _e674;
        canStepOntoPool = false;
        d_17 = 0i;
        loop {
            let _e675 = d_17;
            if (_e675 < 8i) {
                let _e677 = (*pos_13);
                let _e678 = d_17;
                param_645 = _e678;
                let _e679 = getHDir_u0028_i1_u003b((&param_645));
                nPos_7 = (_e677 + _e679);
                let _e682 = nPos_7[0u];
                let _e683 = (_e682 > 0i);
                phi_4989_ = _e683;
                if _e683 {
                    let _e685 = nPos_7[0u];
                    let _e687 = tuning.gridWidth;
                    phi_4989_ = (_e685 < (bitcast<i32>(_e687) - 1i));
                }
                let _e692 = phi_4989_;
                phi_4995_ = _e692;
                if _e692 {
                    let _e694 = nPos_7[2u];
                    phi_4995_ = (_e694 > 0i);
                }
                let _e697 = phi_4995_;
                phi_5005_ = _e697;
                if _e697 {
                    let _e699 = nPos_7[2u];
                    let _e701 = tuning.gridDepth;
                    phi_5005_ = (_e699 < (bitcast<i32>(_e701) - 1i));
                }
                let _e706 = phi_5005_;
                if _e706 {
                    let _e707 = nPos_7;
                    param_646 = _e707;
                    let _e708 = getIndex_u0028_vi3_u003b((&param_646));
                    param_647 = _e708;
                    let _e709 = readCell_u0028_u1_u003b((&param_647));
                    param_648 = _e709;
                    let _e710 = getType_u0028_u1_u003b((&param_648));
                    let _e711 = (_e710 == 0u);
                    phi_5021_ = _e711;
                    if _e711 {
                        let _e713 = (*pos_13)[1u];
                        phi_5021_ = (_e713 > 1i);
                    }
                    let _e716 = phi_5021_;
                    phi_5033_ = _e716;
                    if _e716 {
                        let _e717 = nPos_7;
                        param_649 = (_e717 + vec3<i32>(0i, -1i, 0i));
                        let _e719 = getIndex_u0028_vi3_u003b((&param_649));
                        param_650 = _e719;
                        let _e720 = readCell_u0028_u1_u003b((&param_650));
                        param_651 = _e720;
                        let _e721 = getType_u0028_u1_u003b((&param_651));
                        phi_5033_ = (_e721 == 2u);
                    }
                    let _e724 = phi_5033_;
                    if _e724 {
                        canStepOntoPool = true;
                        break;
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e725 = d_17;
                d_17 = (_e725 + 1i);
            }
        }
        let _e727 = hasPressure_2;
        let _e728 = isStackedOnWater_1;
        let _e730 = canStepOntoPool;
        if ((_e727 || _e728) || _e730) {
            let _e732 = (*randVal_10);
            startSpreadDir = i32((fract((_e732 * 8f)) * 8f));
            i_19 = 0i;
            loop {
                let _e737 = i_19;
                if (_e737 < 8i) {
                    let _e739 = startSpreadDir;
                    let _e740 = i_19;
                    let _e741 = (_e739 + _e740);
                    d_18 = (_e741 - (i32(floor((f32(_e741) / f32(8i)))) * 8i));
                    let _e749 = (*pos_13);
                    let _e750 = d_18;
                    param_652 = _e750;
                    let _e751 = getHDir_u0028_i1_u003b((&param_652));
                    targetPos_2 = (_e749 + _e751);
                    let _e754 = targetPos_2[0u];
                    let _e755 = (_e754 > 0i);
                    phi_5083_ = _e755;
                    if _e755 {
                        let _e757 = targetPos_2[0u];
                        let _e759 = tuning.gridWidth;
                        phi_5083_ = (_e757 < (bitcast<i32>(_e759) - 1i));
                    }
                    let _e764 = phi_5083_;
                    phi_5089_ = _e764;
                    if _e764 {
                        let _e766 = targetPos_2[2u];
                        phi_5089_ = (_e766 > 0i);
                    }
                    let _e769 = phi_5089_;
                    phi_5099_ = _e769;
                    if _e769 {
                        let _e771 = targetPos_2[2u];
                        let _e773 = tuning.gridDepth;
                        phi_5099_ = (_e771 < (bitcast<i32>(_e773) - 1i));
                    }
                    let _e778 = phi_5099_;
                    if _e778 {
                        let _e779 = targetPos_2;
                        param_653 = _e779;
                        let _e780 = getIndex_u0028_vi3_u003b((&param_653));
                        param_654 = _e780;
                        let _e781 = readCell_u0028_u1_u003b((&param_654));
                        param_655 = _e781;
                        let _e782 = getType_u0028_u1_u003b((&param_655));
                        if (_e782 == 0u) {
                            let _e784 = d_18;
                            param_656 = 2u;
                            param_657 = bitcast<u32>((_e784 + 1i));
                            param_658 = 0u;
                            let _e787 = newAge_2;
                            param_659 = _e787;
                            let _e788 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_656), (&param_657), (&param_658), (&param_659));
                            newValue_3 = _e788;
                            let _e789 = targetPos_2;
                            param_660 = _e789;
                            let _e790 = getIndex_u0028_vi3_u003b((&param_660));
                            let _e791 = (*currentIndex_10);
                            param_661 = _e791;
                            let _e792 = (*rawValue_8);
                            param_662 = _e792;
                            param_663 = _e790;
                            let _e793 = newValue_3;
                            param_664 = _e793;
                            let _e794 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_661), (&param_662), (&param_663), (&param_664));
                            if _e794 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e795 = i_19;
                    i_19 = (_e795 + 1i);
                }
            }
        }
    }
    let _e797 = (*currentSleep_5);
    newSleep_3 = min((_e797 + 1u), 255u);
    param_665 = 2u;
    param_666 = 0u;
    let _e800 = newSleep_3;
    param_667 = _e800;
    let _e801 = newAge_2;
    param_668 = _e801;
    let _e802 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_665), (&param_666), (&param_667), (&param_668));
    sleepValue = _e802;
    let _e803 = (*currentIndex_10);
    let _e806 = (*rawValue_8);
    let _e807 = sleepValue;
    let _e808 = atomicCompareExchangeWeak((&unnamed.grid[_e803]), _e806, _e807);
    return;
}

fn incWater_u0028_() {
    let _e194 = atomicAdd((&unnamed_1.waterVoxelCount), 1u);
    return;
}

fn updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_14: ptr<function, vec3<i32>>, currentIndex_11: ptr<function, u32>, rawValue_9: ptr<function, u32>, currentSleep_6: ptr<function, u32>, currentAge_9: ptr<function, u32>, randVal_11: ptr<function, f32>) {
    var moisture_5: u32;
    var moistureModified_1: bool;
    var startDir_5: i32;
    var i_20: i32;
    var d_19: i32;
    var nPos_8: vec3<i32>;
    var param_669: i32;
    var nIndex_5: u32;
    var param_670: vec3<i32>;
    var nVal_5: u32;
    var param_671: u32;
    var param_672: u32;
    var d_20: i32;
    var nPos_9: vec3<i32>;
    var param_673: i32;
    var nIndex_6: u32;
    var param_674: vec3<i32>;
    var nVal_6: u32;
    var param_675: u32;
    var nType_3: u32;
    var param_676: u32;
    var nMoisture_1: u32;
    var param_677: u32;
    var nCapacity_1: u32;
    var local_26: u32;
    var leakPos: vec3<i32>;
    var param_678: vec3<i32>;
    var param_679: u32;
    var param_680: u32;
    var param_681: vec3<i32>;
    var param_682: u32;
    var param_683: u32;
    var param_684: u32;
    var param_685: u32;
    var canMove_1: bool;
    var param_686: vec3<i32>;
    var isClumped_1: bool;
    var emptyBelowCount_1: i32;
    var x_2: i32;
    var z_2: i32;
    var checkPos_2: vec3<i32>;
    var param_687: vec3<i32>;
    var param_688: u32;
    var param_689: u32;
    var clumpCount_1: i32;
    var x_3: i32;
    var y_1: i32;
    var z_3: i32;
    var nPos_10: vec3<i32>;
    var param_690: vec3<i32>;
    var param_691: u32;
    var param_692: u32;
    var belowPos_8: vec3<i32>;
    var param_693: vec3<i32>;
    var param_694: u32;
    var param_695: u32;
    var param_696: vec3<i32>;
    var param_697: u32;
    var param_698: u32;
    var param_699: u32;
    var param_700: u32;
    var param_701: u32;
    var param_702: u32;
    var param_703: u32;
    var param_704: u32;
    var dir_4: i32;
    var slidePos1_1: vec3<i32>;
    var slidePos2_1: vec3<i32>;
    var param_705: vec3<i32>;
    var param_706: u32;
    var param_707: u32;
    var param_708: vec3<i32>;
    var param_709: u32;
    var param_710: u32;
    var param_711: u32;
    var param_712: u32;
    var param_713: u32;
    var param_714: u32;
    var param_715: u32;
    var param_716: u32;
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
    var belowPos_9: vec3<i32>;
    var belowIndex_3: u32;
    var param_729: vec3<i32>;
    var belowValue_3: u32;
    var param_730: u32;
    var param_731: u32;
    var startDir_6: i32;
    var i_21: i32;
    var d_21: i32;
    var pushPos_2: vec3<i32>;
    var param_732: i32;
    var param_733: u32;
    var param_734: u32;
    var param_735: u32;
    var param_736: u32;
    var param_737: vec3<i32>;
    var param_738: u32;
    var param_739: u32;
    var param_740: u32;
    var param_741: u32;
    var param_742: u32;
    var param_743: u32;
    var param_744: u32;
    var param_745: u32;
    var param_746: u32;
    var param_747: u32;
    var param_748: u32;
    var param_749: u32;
    var param_750: u32;
    var dir_5: i32;
    var slidePos_1: array<vec3<i32>, 2>;
    var s_2: i32;
    var sPos_3: vec3<i32>;
    var sIndex_1: u32;
    var param_751: vec3<i32>;
    var sValue_1: u32;
    var param_752: u32;
    var param_753: u32;
    var startDir_7: i32;
    var i_22: i32;
    var d_22: i32;
    var pushPos_3: vec3<i32>;
    var param_754: i32;
    var param_755: u32;
    var param_756: u32;
    var param_757: u32;
    var param_758: u32;
    var param_759: vec3<i32>;
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
    var param_770: u32;
    var param_771: u32;
    var param_772: u32;
    var newSleep_4: u32;
    var param_773: u32;
    var param_774: u32;
    var param_775: u32;
    var param_776: u32;
    var phi_2309_: bool;
    var phi_2315_: bool;
    var phi_2325_: bool;
    var phi_2331_: bool;
    var phi_2341_: bool;
    var phi_2413_: bool;
    var phi_2419_: bool;
    var phi_2429_: bool;
    var phi_2435_: bool;
    var phi_2445_: bool;
    var phi_2510_: bool;
    var phi_2529_: bool;
    var phi_2573_: bool;
    var phi_2615_: bool;
    var phi_2621_: bool;
    var phi_2630_: bool;
    var phi_2712_: bool;
    var phi_2718_: bool;
    var phi_2727_: bool;
    var phi_2733_: bool;
    var phi_2742_: bool;
    var phi_2864_: bool;
    var phi_2870_: bool;
    var phi_2880_: bool;
    var phi_2924_: bool;
    var phi_2930_: bool;
    var phi_2940_: bool;
    var phi_3032_: bool;
    var phi_3038_: bool;
    var phi_3048_: bool;
    var phi_3151_: bool;
    var phi_3157_: bool;
    var phi_3167_: bool;
    var phi_3224_: bool;
    var phi_3230_: bool;
    var phi_3240_: bool;

    let _e357 = (*currentAge_9);
    moisture_5 = _e357;
    moistureModified_1 = false;
    let _e358 = moisture_5;
    let _e360 = tuning.sandMoistureCapacity;
    if (_e358 < _e360) {
        let _e362 = (*randVal_11);
        startDir_5 = i32((fract((_e362 * 17f)) * 6f));
        i_20 = 0i;
        loop {
            let _e367 = i_20;
            if (_e367 < 6i) {
                let _e369 = startDir_5;
                let _e370 = i_20;
                let _e371 = (_e369 + _e370);
                d_19 = (_e371 - (i32(floor((f32(_e371) / f32(6i)))) * 6i));
                let _e379 = d_19;
                if (_e379 != 2i) {
                    let _e381 = (*pos_14);
                    let _e382 = d_19;
                    param_669 = _e382;
                    let _e383 = getOrthoDir_u0028_i1_u003b((&param_669));
                    nPos_8 = (_e381 + _e383);
                    let _e386 = nPos_8[0u];
                    let _e387 = (_e386 > 0i);
                    phi_2309_ = _e387;
                    if _e387 {
                        let _e389 = nPos_8[0u];
                        let _e391 = tuning.gridWidth;
                        phi_2309_ = (_e389 < (bitcast<i32>(_e391) - 1i));
                    }
                    let _e396 = phi_2309_;
                    phi_2315_ = _e396;
                    if _e396 {
                        let _e398 = nPos_8[1u];
                        phi_2315_ = (_e398 > 0i);
                    }
                    let _e401 = phi_2315_;
                    phi_2325_ = _e401;
                    if _e401 {
                        let _e403 = nPos_8[1u];
                        let _e405 = tuning.gridHeight;
                        phi_2325_ = (_e403 < (bitcast<i32>(_e405) - 1i));
                    }
                    let _e410 = phi_2325_;
                    phi_2331_ = _e410;
                    if _e410 {
                        let _e412 = nPos_8[2u];
                        phi_2331_ = (_e412 > 0i);
                    }
                    let _e415 = phi_2331_;
                    phi_2341_ = _e415;
                    if _e415 {
                        let _e417 = nPos_8[2u];
                        let _e419 = tuning.gridDepth;
                        phi_2341_ = (_e417 < (bitcast<i32>(_e419) - 1i));
                    }
                    let _e424 = phi_2341_;
                    if _e424 {
                        let _e425 = nPos_8;
                        param_670 = _e425;
                        let _e426 = getIndex_u0028_vi3_u003b((&param_670));
                        nIndex_5 = _e426;
                        let _e427 = nIndex_5;
                        param_671 = _e427;
                        let _e428 = readCell_u0028_u1_u003b((&param_671));
                        nVal_5 = _e428;
                        let _e429 = nVal_5;
                        param_672 = _e429;
                        let _e430 = getType_u0028_u1_u003b((&param_672));
                        if (_e430 == 2u) {
                            let _e432 = nIndex_5;
                            let _e435 = nVal_5;
                            let _e436 = atomicCompareExchangeWeak((&unnamed.grid[_e432]), _e435, 0u);
                            let _e438 = nVal_5;
                            if (_e436.old_value == _e438) {
                                let _e440 = (*currentIndex_11);
                                let _e444 = tuning.sandWaterAbsorbUnit;
                                let _e447 = atomicAdd((&unnamed.grid[_e440]), (_e444 << bitcast<u32>(24i)));
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
                let _e448 = i_20;
                i_20 = (_e448 + 1i);
            }
        }
    }
    let _e450 = moistureModified_1;
    let _e452 = moisture_5;
    if (!(_e450) && (_e452 > 0u)) {
        let _e455 = (*randVal_11);
        d_20 = i32((fract((_e455 * 31f)) * 6f));
        let _e460 = d_20;
        if (_e460 != 2i) {
            let _e462 = (*pos_14);
            let _e463 = d_20;
            param_673 = _e463;
            let _e464 = getOrthoDir_u0028_i1_u003b((&param_673));
            nPos_9 = (_e462 + _e464);
            let _e467 = nPos_9[0u];
            let _e468 = (_e467 > 0i);
            phi_2413_ = _e468;
            if _e468 {
                let _e470 = nPos_9[0u];
                let _e472 = tuning.gridWidth;
                phi_2413_ = (_e470 < (bitcast<i32>(_e472) - 1i));
            }
            let _e477 = phi_2413_;
            phi_2419_ = _e477;
            if _e477 {
                let _e479 = nPos_9[1u];
                phi_2419_ = (_e479 > 0i);
            }
            let _e482 = phi_2419_;
            phi_2429_ = _e482;
            if _e482 {
                let _e484 = nPos_9[1u];
                let _e486 = tuning.gridHeight;
                phi_2429_ = (_e484 < (bitcast<i32>(_e486) - 1i));
            }
            let _e491 = phi_2429_;
            phi_2435_ = _e491;
            if _e491 {
                let _e493 = nPos_9[2u];
                phi_2435_ = (_e493 > 0i);
            }
            let _e496 = phi_2435_;
            phi_2445_ = _e496;
            if _e496 {
                let _e498 = nPos_9[2u];
                let _e500 = tuning.gridDepth;
                phi_2445_ = (_e498 < (bitcast<i32>(_e500) - 1i));
            }
            let _e505 = phi_2445_;
            if _e505 {
                let _e506 = nPos_9;
                param_674 = _e506;
                let _e507 = getIndex_u0028_vi3_u003b((&param_674));
                nIndex_6 = _e507;
                let _e508 = nIndex_6;
                param_675 = _e508;
                let _e509 = readCell_u0028_u1_u003b((&param_675));
                nVal_6 = _e509;
                let _e510 = nVal_6;
                param_676 = _e510;
                let _e511 = getType_u0028_u1_u003b((&param_676));
                nType_3 = _e511;
                let _e512 = nType_3;
                let _e514 = nType_3;
                if ((_e512 == 1u) || (_e514 == 4u)) {
                    let _e517 = nVal_6;
                    param_677 = _e517;
                    let _e518 = getAge_u0028_u1_u003b((&param_677));
                    nMoisture_1 = _e518;
                    let _e519 = nType_3;
                    if (_e519 == 4u) {
                        let _e522 = tuning.dirtMoistureCapacity;
                        local_26 = _e522;
                    } else {
                        let _e524 = tuning.sandMoistureCapacity;
                        local_26 = _e524;
                    }
                    let _e525 = local_26;
                    nCapacity_1 = _e525;
                    let _e526 = moisture_5;
                    let _e527 = nMoisture_1;
                    let _e530 = nMoisture_1;
                    let _e531 = nCapacity_1;
                    if ((_e526 > (_e527 + 1u)) && (_e530 < _e531)) {
                        let _e534 = (*currentIndex_11);
                        let _e537 = atomicAdd((&unnamed.grid[_e534]), 4278190080u);
                        let _e538 = nIndex_6;
                        let _e541 = atomicAdd((&unnamed.grid[_e538]), 16777216u);
                        moistureModified_1 = true;
                    }
                }
            }
        }
    }
    let _e542 = moistureModified_1;
    let _e543 = !(_e542);
    phi_2510_ = _e543;
    if _e543 {
        let _e544 = moisture_5;
        let _e546 = tuning.sandWaterAbsorbUnit;
        phi_2510_ = (_e544 >= _e546);
    }
    let _e549 = phi_2510_;
    if _e549 {
        let _e550 = (*pos_14);
        leakPos = (_e550 + vec3<i32>(0i, -1i, 0i));
        let _e553 = leakPos[1u];
        let _e554 = (_e553 > 0i);
        phi_2529_ = _e554;
        if _e554 {
            let _e555 = leakPos;
            param_678 = _e555;
            let _e556 = getIndex_u0028_vi3_u003b((&param_678));
            param_679 = _e556;
            let _e557 = readCell_u0028_u1_u003b((&param_679));
            param_680 = _e557;
            let _e558 = getType_u0028_u1_u003b((&param_680));
            phi_2529_ = (_e558 == 0u);
        }
        let _e561 = phi_2529_;
        if _e561 {
            let _e562 = leakPos;
            param_681 = _e562;
            let _e563 = getIndex_u0028_vi3_u003b((&param_681));
            param_682 = 2u;
            param_683 = 0u;
            param_684 = 0u;
            param_685 = 0u;
            let _e566 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_682), (&param_683), (&param_684), (&param_685));
            let _e567 = atomicCompareExchangeWeak((&unnamed.grid[_e563]), 0u, _e566);
            if (_e567.old_value == 0u) {
                let _e570 = (*currentIndex_11);
                let _e574 = tuning.sandWaterAbsorbUnit;
                let _e578 = atomicAdd((&unnamed.grid[_e570]), ((0u - _e574) << bitcast<u32>(24i)));
                incWater_u0028_();
                moistureModified_1 = true;
            }
        }
    }
    let _e579 = moistureModified_1;
    if _e579 {
        return;
    }
    let _e580 = (*pos_14);
    param_686 = _e580;
    let _e581 = grainCanMove_u0028_vi3_u003b((&param_686));
    canMove_1 = _e581;
    isClumped_1 = false;
    let _e582 = canMove_1;
    let _e583 = moisture_5;
    let _e585 = (_e582 && (_e583 > 0u));
    phi_2573_ = _e585;
    if _e585 {
        let _e586 = (*currentSleep_6);
        let _e588 = tuning.wakeSleepThreshold;
        phi_2573_ = (_e586 > _e588);
    }
    let _e591 = phi_2573_;
    if _e591 {
        emptyBelowCount_1 = 0i;
        let _e593 = (*pos_14)[1u];
        if (_e593 > 1i) {
            x_2 = -1i;
            loop {
                let _e595 = x_2;
                if (_e595 <= 1i) {
                    z_2 = -1i;
                    loop {
                        let _e597 = z_2;
                        if (_e597 <= 1i) {
                            let _e599 = (*pos_14);
                            let _e600 = x_2;
                            let _e601 = z_2;
                            checkPos_2 = (_e599 + vec3<i32>(_e600, -1i, _e601));
                            let _e605 = checkPos_2[0u];
                            let _e606 = (_e605 >= 0i);
                            phi_2615_ = _e606;
                            if _e606 {
                                let _e608 = checkPos_2[0u];
                                let _e610 = tuning.gridWidth;
                                phi_2615_ = (_e608 < bitcast<i32>(_e610));
                            }
                            let _e614 = phi_2615_;
                            phi_2621_ = _e614;
                            if _e614 {
                                let _e616 = checkPos_2[2u];
                                phi_2621_ = (_e616 >= 0i);
                            }
                            let _e619 = phi_2621_;
                            phi_2630_ = _e619;
                            if _e619 {
                                let _e621 = checkPos_2[2u];
                                let _e623 = tuning.gridDepth;
                                phi_2630_ = (_e621 < bitcast<i32>(_e623));
                            }
                            let _e627 = phi_2630_;
                            if _e627 {
                                let _e628 = checkPos_2;
                                param_687 = _e628;
                                let _e629 = getIndex_u0028_vi3_u003b((&param_687));
                                param_688 = _e629;
                                let _e630 = readCell_u0028_u1_u003b((&param_688));
                                param_689 = _e630;
                                let _e631 = getType_u0028_u1_u003b((&param_689));
                                if (_e631 == 0u) {
                                    let _e633 = emptyBelowCount_1;
                                    emptyBelowCount_1 = (_e633 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e635 = z_2;
                            z_2 = (_e635 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e637 = x_2;
                    x_2 = (_e637 + 1i);
                }
            }
        }
        let _e639 = emptyBelowCount_1;
        let _e641 = tuning.emptyBelowWakeCount;
        if (_e639 >= bitcast<i32>(_e641)) {
            (*currentSleep_6) = 0u;
        } else {
            clumpCount_1 = 0i;
            x_3 = -1i;
            loop {
                let _e644 = x_3;
                if (_e644 <= 1i) {
                    y_1 = -1i;
                    loop {
                        let _e646 = y_1;
                        if (_e646 <= 1i) {
                            z_3 = -1i;
                            loop {
                                let _e648 = z_3;
                                if (_e648 <= 1i) {
                                    let _e650 = x_3;
                                    let _e652 = y_1;
                                    let _e655 = z_3;
                                    if (((_e650 == 0i) && (_e652 == 0i)) && (_e655 == 0i)) {
                                        continue;
                                    }
                                    let _e658 = (*pos_14);
                                    let _e659 = x_3;
                                    let _e660 = y_1;
                                    let _e661 = z_3;
                                    nPos_10 = (_e658 + vec3<i32>(_e659, _e660, _e661));
                                    let _e665 = nPos_10[0u];
                                    let _e666 = (_e665 >= 0i);
                                    phi_2712_ = _e666;
                                    if _e666 {
                                        let _e668 = nPos_10[0u];
                                        let _e670 = tuning.gridWidth;
                                        phi_2712_ = (_e668 < bitcast<i32>(_e670));
                                    }
                                    let _e674 = phi_2712_;
                                    phi_2718_ = _e674;
                                    if _e674 {
                                        let _e676 = nPos_10[1u];
                                        phi_2718_ = (_e676 >= 0i);
                                    }
                                    let _e679 = phi_2718_;
                                    phi_2727_ = _e679;
                                    if _e679 {
                                        let _e681 = nPos_10[1u];
                                        let _e683 = tuning.gridHeight;
                                        phi_2727_ = (_e681 < bitcast<i32>(_e683));
                                    }
                                    let _e687 = phi_2727_;
                                    phi_2733_ = _e687;
                                    if _e687 {
                                        let _e689 = nPos_10[2u];
                                        phi_2733_ = (_e689 >= 0i);
                                    }
                                    let _e692 = phi_2733_;
                                    phi_2742_ = _e692;
                                    if _e692 {
                                        let _e694 = nPos_10[2u];
                                        let _e696 = tuning.gridDepth;
                                        phi_2742_ = (_e694 < bitcast<i32>(_e696));
                                    }
                                    let _e700 = phi_2742_;
                                    if _e700 {
                                        let _e701 = nPos_10;
                                        param_690 = _e701;
                                        let _e702 = getIndex_u0028_vi3_u003b((&param_690));
                                        param_691 = _e702;
                                        let _e703 = readCell_u0028_u1_u003b((&param_691));
                                        param_692 = _e703;
                                        let _e704 = getType_u0028_u1_u003b((&param_692));
                                        if (_e704 == 1u) {
                                            let _e706 = clumpCount_1;
                                            clumpCount_1 = (_e706 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e708 = z_3;
                                    z_3 = (_e708 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e710 = y_1;
                            y_1 = (_e710 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e712 = x_3;
                    x_3 = (_e712 + 1i);
                }
            }
            let _e714 = clumpCount_1;
            let _e716 = tuning.sandClumpThreshold;
            if (_e714 >= bitcast<i32>(_e716)) {
                isClumped_1 = true;
            }
        }
    }
    let _e719 = canMove_1;
    let _e720 = isClumped_1;
    if (_e719 && !(_e720)) {
        let _e724 = (*pos_14)[1u];
        if (_e724 > 1i) {
            let _e726 = (*pos_14);
            belowPos_8 = (_e726 + vec3<i32>(0i, -1i, 0i));
            let _e728 = belowPos_8;
            param_693 = _e728;
            let _e729 = getIndex_u0028_vi3_u003b((&param_693));
            param_694 = _e729;
            let _e730 = readCell_u0028_u1_u003b((&param_694));
            param_695 = _e730;
            let _e731 = getType_u0028_u1_u003b((&param_695));
            if (_e731 == 0u) {
                let _e733 = belowPos_8;
                param_696 = _e733;
                let _e734 = getIndex_u0028_vi3_u003b((&param_696));
                param_697 = 1u;
                param_698 = 0u;
                param_699 = 0u;
                let _e735 = moisture_5;
                param_700 = _e735;
                let _e736 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_697), (&param_698), (&param_699), (&param_700));
                let _e737 = (*currentIndex_11);
                param_701 = _e737;
                let _e738 = (*rawValue_9);
                param_702 = _e738;
                param_703 = _e734;
                param_704 = _e736;
                let _e739 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_701), (&param_702), (&param_703), (&param_704));
                if _e739 {
                    return;
                }
            }
        }
        let _e741 = (*pos_14)[1u];
        if (_e741 > 1i) {
            let _e743 = (*randVal_11);
            dir_4 = select(-1i, 1i, (fract((_e743 * 10f)) > 0.5f));
            let _e748 = (*randVal_11);
            if (fract((_e748 * 100f)) > 0.5f) {
                let _e752 = (*pos_14);
                let _e753 = dir_4;
                slidePos1_1 = (_e752 + vec3<i32>(_e753, -1i, 0i));
                let _e756 = (*pos_14);
                let _e757 = dir_4;
                slidePos2_1 = (_e756 + vec3<i32>(0i, -1i, _e757));
            } else {
                let _e760 = (*pos_14);
                let _e761 = dir_4;
                slidePos1_1 = (_e760 + vec3<i32>(0i, -1i, _e761));
                let _e764 = (*pos_14);
                let _e765 = dir_4;
                slidePos2_1 = (_e764 + vec3<i32>(_e765, -1i, 0i));
            }
            let _e769 = slidePos1_1[0u];
            let _e770 = (_e769 > 0i);
            phi_2864_ = _e770;
            if _e770 {
                let _e772 = slidePos1_1[0u];
                let _e774 = tuning.gridWidth;
                phi_2864_ = (_e772 < (bitcast<i32>(_e774) - 1i));
            }
            let _e779 = phi_2864_;
            phi_2870_ = _e779;
            if _e779 {
                let _e781 = slidePos1_1[2u];
                phi_2870_ = (_e781 > 0i);
            }
            let _e784 = phi_2870_;
            phi_2880_ = _e784;
            if _e784 {
                let _e786 = slidePos1_1[2u];
                let _e788 = tuning.gridDepth;
                phi_2880_ = (_e786 < (bitcast<i32>(_e788) - 1i));
            }
            let _e793 = phi_2880_;
            if _e793 {
                let _e794 = slidePos1_1;
                param_705 = _e794;
                let _e795 = getIndex_u0028_vi3_u003b((&param_705));
                param_706 = _e795;
                let _e796 = readCell_u0028_u1_u003b((&param_706));
                param_707 = _e796;
                let _e797 = getType_u0028_u1_u003b((&param_707));
                if (_e797 == 0u) {
                    let _e799 = slidePos1_1;
                    param_708 = _e799;
                    let _e800 = getIndex_u0028_vi3_u003b((&param_708));
                    param_709 = 1u;
                    param_710 = 0u;
                    param_711 = 0u;
                    let _e801 = moisture_5;
                    param_712 = _e801;
                    let _e802 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_709), (&param_710), (&param_711), (&param_712));
                    let _e803 = (*currentIndex_11);
                    param_713 = _e803;
                    let _e804 = (*rawValue_9);
                    param_714 = _e804;
                    param_715 = _e800;
                    param_716 = _e802;
                    let _e805 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_713), (&param_714), (&param_715), (&param_716));
                    if _e805 {
                        return;
                    }
                }
            }
            let _e807 = slidePos2_1[0u];
            let _e808 = (_e807 > 0i);
            phi_2924_ = _e808;
            if _e808 {
                let _e810 = slidePos2_1[0u];
                let _e812 = tuning.gridWidth;
                phi_2924_ = (_e810 < (bitcast<i32>(_e812) - 1i));
            }
            let _e817 = phi_2924_;
            phi_2930_ = _e817;
            if _e817 {
                let _e819 = slidePos2_1[2u];
                phi_2930_ = (_e819 > 0i);
            }
            let _e822 = phi_2930_;
            phi_2940_ = _e822;
            if _e822 {
                let _e824 = slidePos2_1[2u];
                let _e826 = tuning.gridDepth;
                phi_2940_ = (_e824 < (bitcast<i32>(_e826) - 1i));
            }
            let _e831 = phi_2940_;
            if _e831 {
                let _e832 = slidePos2_1;
                param_717 = _e832;
                let _e833 = getIndex_u0028_vi3_u003b((&param_717));
                param_718 = _e833;
                let _e834 = readCell_u0028_u1_u003b((&param_718));
                param_719 = _e834;
                let _e835 = getType_u0028_u1_u003b((&param_719));
                if (_e835 == 0u) {
                    let _e837 = slidePos2_1;
                    param_720 = _e837;
                    let _e838 = getIndex_u0028_vi3_u003b((&param_720));
                    param_721 = 1u;
                    param_722 = 0u;
                    param_723 = 0u;
                    let _e839 = moisture_5;
                    param_724 = _e839;
                    let _e840 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_721), (&param_722), (&param_723), (&param_724));
                    let _e841 = (*currentIndex_11);
                    param_725 = _e841;
                    let _e842 = (*rawValue_9);
                    param_726 = _e842;
                    param_727 = _e838;
                    param_728 = _e840;
                    let _e843 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_725), (&param_726), (&param_727), (&param_728));
                    if _e843 {
                        return;
                    }
                }
            }
        }
        let _e845 = (*pos_14)[1u];
        if (_e845 > 1i) {
            let _e847 = (*pos_14);
            belowPos_9 = (_e847 + vec3<i32>(0i, -1i, 0i));
            let _e849 = belowPos_9;
            param_729 = _e849;
            let _e850 = getIndex_u0028_vi3_u003b((&param_729));
            belowIndex_3 = _e850;
            let _e851 = belowIndex_3;
            param_730 = _e851;
            let _e852 = readCell_u0028_u1_u003b((&param_730));
            belowValue_3 = _e852;
            let _e853 = belowValue_3;
            param_731 = _e853;
            let _e854 = getType_u0028_u1_u003b((&param_731));
            if (_e854 == 2u) {
                let _e856 = (*randVal_11);
                startDir_6 = i32((fract((_e856 * 8f)) * 8f));
                i_21 = 0i;
                loop {
                    let _e861 = i_21;
                    if (_e861 < 8i) {
                        let _e863 = startDir_6;
                        let _e864 = i_21;
                        let _e865 = (_e863 + _e864);
                        d_21 = (_e865 - (i32(floor((f32(_e865) / f32(8i)))) * 8i));
                        let _e873 = belowPos_9;
                        let _e874 = d_21;
                        param_732 = _e874;
                        let _e875 = getHDir_u0028_i1_u003b((&param_732));
                        pushPos_2 = (_e873 + _e875);
                        let _e878 = pushPos_2[0u];
                        let _e879 = (_e878 > 0i);
                        phi_3032_ = _e879;
                        if _e879 {
                            let _e881 = pushPos_2[0u];
                            let _e883 = tuning.gridWidth;
                            phi_3032_ = (_e881 < (bitcast<i32>(_e883) - 1i));
                        }
                        let _e888 = phi_3032_;
                        phi_3038_ = _e888;
                        if _e888 {
                            let _e890 = pushPos_2[2u];
                            phi_3038_ = (_e890 > 0i);
                        }
                        let _e893 = phi_3038_;
                        phi_3048_ = _e893;
                        if _e893 {
                            let _e895 = pushPos_2[2u];
                            let _e897 = tuning.gridDepth;
                            phi_3048_ = (_e895 < (bitcast<i32>(_e897) - 1i));
                        }
                        let _e902 = phi_3048_;
                        if _e902 {
                            param_733 = 1u;
                            param_734 = 0u;
                            param_735 = 0u;
                            let _e903 = moisture_5;
                            param_736 = _e903;
                            let _e904 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_733), (&param_734), (&param_735), (&param_736));
                            let _e905 = pushPos_2;
                            param_737 = _e905;
                            let _e906 = getIndex_u0028_vi3_u003b((&param_737));
                            let _e907 = (*currentIndex_11);
                            param_738 = _e907;
                            param_739 = _e904;
                            let _e908 = belowIndex_3;
                            param_740 = _e908;
                            let _e909 = belowValue_3;
                            param_741 = _e909;
                            param_742 = _e906;
                            let _e910 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_738), (&param_739), (&param_740), (&param_741), (&param_742));
                            if _e910 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e911 = i_21;
                        i_21 = (_e911 + 1i);
                    }
                }
                param_743 = 1u;
                param_744 = 0u;
                param_745 = 0u;
                let _e913 = moisture_5;
                param_746 = _e913;
                let _e914 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_743), (&param_744), (&param_745), (&param_746));
                let _e915 = (*currentIndex_11);
                param_747 = _e915;
                let _e916 = (*rawValue_9);
                param_748 = _e916;
                let _e917 = belowIndex_3;
                param_749 = _e917;
                param_750 = _e914;
                let _e918 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_747), (&param_748), (&param_749), (&param_750));
                if _e918 {
                    return;
                }
            }
            let _e919 = (*randVal_11);
            dir_5 = select(-1i, 1i, (fract((_e919 * 10f)) > 0.5f));
            let _e924 = (*randVal_11);
            if (fract((_e924 * 100f)) > 0.5f) {
                let _e928 = (*pos_14);
                let _e929 = dir_5;
                slidePos_1[0i] = (_e928 + vec3<i32>(_e929, -1i, 0i));
                let _e933 = (*pos_14);
                let _e934 = dir_5;
                slidePos_1[1i] = (_e933 + vec3<i32>(0i, -1i, _e934));
            } else {
                let _e938 = (*pos_14);
                let _e939 = dir_5;
                slidePos_1[0i] = (_e938 + vec3<i32>(0i, -1i, _e939));
                let _e943 = (*pos_14);
                let _e944 = dir_5;
                slidePos_1[1i] = (_e943 + vec3<i32>(_e944, -1i, 0i));
            }
            s_2 = 0i;
            loop {
                let _e948 = s_2;
                if (_e948 < 2i) {
                    let _e950 = s_2;
                    let _e952 = slidePos_1[_e950];
                    sPos_3 = _e952;
                    let _e954 = sPos_3[0u];
                    let _e955 = (_e954 > 0i);
                    phi_3151_ = _e955;
                    if _e955 {
                        let _e957 = sPos_3[0u];
                        let _e959 = tuning.gridWidth;
                        phi_3151_ = (_e957 < (bitcast<i32>(_e959) - 1i));
                    }
                    let _e964 = phi_3151_;
                    phi_3157_ = _e964;
                    if _e964 {
                        let _e966 = sPos_3[2u];
                        phi_3157_ = (_e966 > 0i);
                    }
                    let _e969 = phi_3157_;
                    phi_3167_ = _e969;
                    if _e969 {
                        let _e971 = sPos_3[2u];
                        let _e973 = tuning.gridDepth;
                        phi_3167_ = (_e971 < (bitcast<i32>(_e973) - 1i));
                    }
                    let _e978 = phi_3167_;
                    if _e978 {
                        let _e979 = sPos_3;
                        param_751 = _e979;
                        let _e980 = getIndex_u0028_vi3_u003b((&param_751));
                        sIndex_1 = _e980;
                        let _e981 = sIndex_1;
                        param_752 = _e981;
                        let _e982 = readCell_u0028_u1_u003b((&param_752));
                        sValue_1 = _e982;
                        let _e983 = sValue_1;
                        param_753 = _e983;
                        let _e984 = getType_u0028_u1_u003b((&param_753));
                        if (_e984 == 2u) {
                            let _e986 = (*randVal_11);
                            let _e988 = s_2;
                            startDir_7 = i32((fract(((_e986 * 8f) + f32(_e988))) * 8f));
                            i_22 = 0i;
                            loop {
                                let _e994 = i_22;
                                if (_e994 < 8i) {
                                    let _e996 = startDir_7;
                                    let _e997 = i_22;
                                    let _e998 = (_e996 + _e997);
                                    d_22 = (_e998 - (i32(floor((f32(_e998) / f32(8i)))) * 8i));
                                    let _e1006 = sPos_3;
                                    let _e1007 = d_22;
                                    param_754 = _e1007;
                                    let _e1008 = getHDir_u0028_i1_u003b((&param_754));
                                    pushPos_3 = (_e1006 + _e1008);
                                    let _e1011 = pushPos_3[0u];
                                    let _e1012 = (_e1011 > 0i);
                                    phi_3224_ = _e1012;
                                    if _e1012 {
                                        let _e1014 = pushPos_3[0u];
                                        let _e1016 = tuning.gridWidth;
                                        phi_3224_ = (_e1014 < (bitcast<i32>(_e1016) - 1i));
                                    }
                                    let _e1021 = phi_3224_;
                                    phi_3230_ = _e1021;
                                    if _e1021 {
                                        let _e1023 = pushPos_3[2u];
                                        phi_3230_ = (_e1023 > 0i);
                                    }
                                    let _e1026 = phi_3230_;
                                    phi_3240_ = _e1026;
                                    if _e1026 {
                                        let _e1028 = pushPos_3[2u];
                                        let _e1030 = tuning.gridDepth;
                                        phi_3240_ = (_e1028 < (bitcast<i32>(_e1030) - 1i));
                                    }
                                    let _e1035 = phi_3240_;
                                    if _e1035 {
                                        param_755 = 1u;
                                        param_756 = 0u;
                                        param_757 = 0u;
                                        let _e1036 = moisture_5;
                                        param_758 = _e1036;
                                        let _e1037 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_755), (&param_756), (&param_757), (&param_758));
                                        let _e1038 = pushPos_3;
                                        param_759 = _e1038;
                                        let _e1039 = getIndex_u0028_vi3_u003b((&param_759));
                                        let _e1040 = (*currentIndex_11);
                                        param_760 = _e1040;
                                        param_761 = _e1037;
                                        let _e1041 = sIndex_1;
                                        param_762 = _e1041;
                                        let _e1042 = sValue_1;
                                        param_763 = _e1042;
                                        param_764 = _e1039;
                                        let _e1043 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_760), (&param_761), (&param_762), (&param_763), (&param_764));
                                        if _e1043 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1044 = i_22;
                                    i_22 = (_e1044 + 1i);
                                }
                            }
                            param_765 = 1u;
                            param_766 = 0u;
                            param_767 = 0u;
                            let _e1046 = moisture_5;
                            param_768 = _e1046;
                            let _e1047 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_765), (&param_766), (&param_767), (&param_768));
                            let _e1048 = (*currentIndex_11);
                            param_769 = _e1048;
                            let _e1049 = (*rawValue_9);
                            param_770 = _e1049;
                            let _e1050 = sIndex_1;
                            param_771 = _e1050;
                            param_772 = _e1047;
                            let _e1051 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_769), (&param_770), (&param_771), (&param_772));
                            if _e1051 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1052 = s_2;
                    s_2 = (_e1052 + 1i);
                }
            }
        }
    }
    let _e1054 = (*currentSleep_6);
    newSleep_4 = min((_e1054 + 1u), 255u);
    let _e1057 = (*currentIndex_11);
    let _e1060 = (*rawValue_9);
    param_773 = 1u;
    param_774 = 0u;
    let _e1061 = newSleep_4;
    param_775 = _e1061;
    let _e1062 = moisture_5;
    param_776 = _e1062;
    let _e1063 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_773), (&param_774), (&param_775), (&param_776));
    let _e1064 = atomicCompareExchangeWeak((&unnamed.grid[_e1057]), _e1060, _e1063);
    return;
}

fn orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b(pos_15: ptr<function, vec3<i32>>, currentIndex_12: ptr<function, u32>, rawValue_10: ptr<function, u32>, stepDir: ptr<function, vec3<i32>>) -> bool {
    var target_2: vec3<i32>;
    var targetIndex_3: u32;
    var param_777: vec3<i32>;
    var param_778: u32;
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
    var phi_1628_: bool;
    var phi_1635_: bool;
    var phi_1646_: bool;
    var phi_1653_: bool;
    var phi_1664_: bool;

    let _e213 = (*stepDir);
    if all((_e213 == vec3<i32>(0i, 0i, 0i))) {
        return false;
    }
    let _e216 = (*pos_15);
    let _e217 = (*stepDir);
    target_2 = (_e216 + _e217);
    let _e220 = target_2[0u];
    let _e221 = (_e220 < 1i);
    phi_1628_ = _e221;
    if !(_e221) {
        let _e224 = target_2[0u];
        let _e226 = tuning.gridWidth;
        phi_1628_ = (_e224 >= (bitcast<i32>(_e226) - 1i));
    }
    let _e231 = phi_1628_;
    phi_1635_ = _e231;
    if !(_e231) {
        let _e234 = target_2[1u];
        phi_1635_ = (_e234 < 1i);
    }
    let _e237 = phi_1635_;
    phi_1646_ = _e237;
    if !(_e237) {
        let _e240 = target_2[1u];
        let _e242 = tuning.gridHeight;
        phi_1646_ = (_e240 >= (bitcast<i32>(_e242) - 1i));
    }
    let _e247 = phi_1646_;
    phi_1653_ = _e247;
    if !(_e247) {
        let _e250 = target_2[2u];
        phi_1653_ = (_e250 < 1i);
    }
    let _e253 = phi_1653_;
    phi_1664_ = _e253;
    if !(_e253) {
        let _e256 = target_2[2u];
        let _e258 = tuning.gridDepth;
        phi_1664_ = (_e256 >= (bitcast<i32>(_e258) - 1i));
    }
    let _e263 = phi_1664_;
    if _e263 {
        return false;
    }
    let _e264 = target_2;
    param_777 = _e264;
    let _e265 = getIndex_u0028_vi3_u003b((&param_777));
    targetIndex_3 = _e265;
    let _e266 = targetIndex_3;
    param_778 = _e266;
    let _e267 = readCell_u0028_u1_u003b((&param_778));
    param_779 = _e267;
    let _e268 = getType_u0028_u1_u003b((&param_779));
    if (_e268 != 0u) {
        return false;
    }
    let _e270 = (*rawValue_10);
    param_780 = _e270;
    let _e271 = getType_u0028_u1_u003b((&param_780));
    let _e272 = (*rawValue_10);
    param_781 = _e272;
    let _e273 = getDir_u0028_u1_u003b((&param_781));
    let _e274 = (*rawValue_10);
    param_782 = _e274;
    let _e275 = getAge_u0028_u1_u003b((&param_782));
    param_783 = _e271;
    param_784 = _e273;
    param_785 = 0u;
    param_786 = _e275;
    let _e276 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_783), (&param_784), (&param_785), (&param_786));
    let _e277 = (*currentIndex_12);
    param_787 = _e277;
    let _e278 = (*rawValue_10);
    param_788 = _e278;
    let _e279 = targetIndex_3;
    param_789 = _e279;
    param_790 = _e276;
    let _e280 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_787), (&param_788), (&param_789), (&param_790));
    return _e280;
}

fn dominantAxis_u0028_vf3_u003b_f1_u003b(dir_6: ptr<function, vec3<f32>>, relative: ptr<function, f32>) -> vec3<i32> {
    var a: vec3<f32>;
    var m: f32;

    let _e197 = (*dir_6);
    a = abs(_e197);
    let _e200 = a[0u];
    let _e202 = a[1u];
    let _e204 = a[2u];
    m = max(_e200, max(_e202, _e204));
    let _e207 = m;
    if (_e207 <= 0f) {
        return vec3<i32>(0i, 0i, 0i);
    }
    let _e209 = a;
    let _e210 = m;
    let _e211 = (*relative);
    let _e216 = (*dir_6);
    return (select(vec3<i32>(0i, 0i, 0i), vec3<i32>(1i, 1i, 1i), (_e209 >= vec3((_e210 * _e211)))) * vec3<i32>(sign(_e216)));
}

fn bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b(k_1: ptr<function, i32>, planeCount: ptr<function, i32>, seed: ptr<function, f32>) -> vec3<f32> {
    var z_4: f32;
    var r_4: f32;
    var a_1: f32;

    let _e199 = (*k_1);
    let _e202 = (*planeCount);
    z_4 = ((f32(_e199) + 0.5f) / f32(_e202));
    let _e205 = z_4;
    let _e206 = z_4;
    r_4 = sqrt(max(0f, (1f - (_e205 * _e206))));
    let _e211 = (*k_1);
    let _e214 = (*seed);
    a_1 = ((2.399963f * f32(_e211)) + _e214);
    let _e216 = r_4;
    let _e217 = a_1;
    let _e220 = z_4;
    let _e221 = r_4;
    let _e222 = a_1;
    return vec3<f32>((_e216 * cos(_e217)), _e220, (_e221 * sin(_e222)));
}

fn hash_u0028_vf3_u003b(p_3: ptr<function, vec3<f32>>) -> f32 {
    let _e194 = (*p_3);
    return fract((sin(dot(_e194, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn bhOrbitAxis_u0028_vi3_u003b_vi3_u003b(center: ptr<function, vec3<i32>>, pos_16: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radial: vec3<f32>;
    var planeCount_1: i32;
    var seed_1: f32;
    var param_791: vec3<f32>;
    var best: vec3<f32>;
    var bestAlign: f32;
    var bestK: i32;
    var k_2: i32;
    var n_1: vec3<f32>;
    var param_792: i32;
    var param_793: i32;
    var param_794: f32;
    var align: f32;
    var sense: f32;
    var param_795: vec3<f32>;

    let _e210 = (*pos_16);
    let _e211 = (*center);
    radial = normalize(vec3<f32>((_e210 - _e211)));
    let _e216 = tuning.blackHoleOrbitPlanes;
    planeCount_1 = bitcast<i32>(clamp(_e216, 1u, 32u));
    let _e219 = (*center);
    param_791 = (vec3<f32>(_e219) + vec3<f32>(29f, 3f, 71f));
    let _e222 = hash_u0028_vf3_u003b((&param_791));
    seed_1 = (_e222 * 6.28318f);
    best = vec3<f32>(0f, 1f, 0f);
    bestAlign = 2f;
    bestK = 0i;
    k_2 = 0i;
    loop {
        let _e224 = k_2;
        let _e225 = planeCount_1;
        if (_e224 < _e225) {
            let _e227 = k_2;
            param_792 = _e227;
            let _e228 = planeCount_1;
            param_793 = _e228;
            let _e229 = seed_1;
            param_794 = _e229;
            let _e230 = bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b((&param_792), (&param_793), (&param_794));
            n_1 = _e230;
            let _e231 = n_1;
            let _e232 = radial;
            align = abs(dot(_e231, _e232));
            let _e235 = align;
            let _e236 = bestAlign;
            if (_e235 < _e236) {
                let _e238 = align;
                bestAlign = _e238;
                let _e239 = n_1;
                best = _e239;
                let _e240 = k_2;
                bestK = _e240;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e241 = k_2;
            k_2 = (_e241 + 1i);
        }
    }
    let _e243 = (*center);
    let _e245 = bestK;
    param_795 = (vec3<f32>(_e243) + vec3<f32>((f32(_e245) * 13f), 101f, 47f));
    let _e250 = hash_u0028_vf3_u003b((&param_795));
    sense = select(1f, -1f, (_e250 < 0.5f));
    let _e253 = best;
    let _e254 = sense;
    return (_e253 * _e254);
}

fn bhIsPurge_u0028_u1_u003b(code: ptr<function, u32>) -> bool {
    let _e194 = (*code);
    return ((_e194 & 1073741824u) != 0u);
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e194 = (*level);
    return (f32(_e194) + 0.5f);
}

fn updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b(pos_17: ptr<function, vec3<i32>>, currentIndex_13: ptr<function, u32>, rawValue_11: ptr<function, u32>, center_1: ptr<function, vec3<i32>>, slot: ptr<function, i32>, level_1: ptr<function, u32>, purge: ptr<function, bool>, dist_1: ptr<function, f32>, randVal_12: ptr<function, f32>) {
    var type_37: u32;
    var param_796: u32;
    var sleep_2: u32;
    var param_797: u32;
    var param_798: u32;
    var param_799: u32;
    var orbitSpeed: f32;
    var local_27: f32;
    var infallChance: f32;
    var local_28: f32;
    var param_800: u32;
    var param_801: u32;
    var param_802: u32;
    var param_803: u32;
    var param_804: u32;
    var param_805: u32;
    var inward: vec3<f32>;
    var axis: vec3<f32>;
    var param_806: vec3<i32>;
    var param_807: vec3<i32>;
    var tangent: vec3<f32>;
    var tangentLen: f32;
    var axial: f32;
    var grip: vec3<f32>;
    var along: vec3<f32>;
    var pullIn: bool;
    var spiral: vec3<f32>;
    var param_808: vec3<f32>;
    var param_809: f32;
    var param_810: vec3<i32>;
    var param_811: u32;
    var param_812: u32;
    var param_813: vec3<i32>;
    var param_814: vec3<f32>;
    var param_815: f32;
    var param_816: vec3<i32>;
    var param_817: u32;
    var param_818: u32;
    var param_819: vec3<i32>;
    var param_820: vec3<f32>;
    var param_821: f32;
    var param_822: vec3<i32>;
    var param_823: u32;
    var param_824: u32;
    var param_825: vec3<i32>;
    var param_826: vec3<f32>;
    var param_827: f32;
    var param_828: vec3<i32>;
    var param_829: u32;
    var param_830: u32;
    var param_831: vec3<i32>;
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
    var param_844: u32;
    var param_845: u32;
    var param_846: u32;
    var param_847: u32;
    var param_848: u32;
    var param_849: u32;
    var phi_1927_: bool;

    let _e271 = (*rawValue_11);
    param_796 = _e271;
    let _e272 = getType_u0028_u1_u003b((&param_796));
    type_37 = _e272;
    let _e273 = (*rawValue_11);
    param_797 = _e273;
    let _e274 = getSleep_u0028_u1_u003b((&param_797));
    sleep_2 = _e274;
    let _e275 = (*slot);
    unnamed_1.blackHoleStarve[_e275] = 0u;
    let _e278 = (*dist_1);
    let _e279 = (*level_1);
    param_798 = _e279;
    let _e280 = bhBodyRadius_u0028_u1_u003b((&param_798));
    let _e282 = tuning.blackHoleHorizon;
    if (_e278 <= (_e280 + f32(_e282))) {
        let _e286 = (*currentIndex_13);
        let _e289 = (*rawValue_11);
        let _e290 = atomicCompareExchangeWeak((&unnamed.grid[_e286]), _e289, 0u);
        let _e292 = (*rawValue_11);
        if (_e290.old_value == _e292) {
            let _e294 = (*slot);
            let _e297 = atomicLoad((&unnamed_1.blackHoles[_e294]));
            param_799 = _e297;
            let _e298 = bhIsPurge_u0028_u1_u003b((&param_799));
            if !(_e298) {
                let _e300 = (*slot);
                let _e303 = atomicAdd((&unnamed_1.blackHoleMass[_e300]), 1u);
            }
            let _e304 = type_37;
            if (_e304 == 2u) {
                decWater_u0028_();
            }
        }
        return;
    }
    let _e306 = (*purge);
    if _e306 {
        let _e308 = tuning.purgeOrbitSpeed;
        local_27 = _e308;
    } else {
        let _e310 = tuning.blackHoleOrbitSpeed;
        local_27 = _e310;
    }
    let _e311 = local_27;
    orbitSpeed = _e311;
    let _e312 = (*purge);
    if _e312 {
        let _e314 = tuning.purgeInfall;
        local_28 = _e314;
    } else {
        let _e316 = tuning.blackHoleInfall;
        local_28 = _e316;
    }
    let _e317 = local_28;
    infallChance = _e317;
    let _e318 = (*randVal_12);
    let _e319 = orbitSpeed;
    let _e320 = (*dist_1);
    if (_e318 > clamp((_e319 / sqrt(max(_e320, 1f))), 0f, 1f)) {
        let _e326 = sleep_2;
        if (_e326 != 0u) {
            let _e328 = (*currentIndex_13);
            let _e331 = (*rawValue_11);
            let _e332 = (*rawValue_11);
            param_800 = _e332;
            let _e333 = getDir_u0028_u1_u003b((&param_800));
            let _e334 = (*rawValue_11);
            param_801 = _e334;
            let _e335 = getAge_u0028_u1_u003b((&param_801));
            let _e336 = type_37;
            param_802 = _e336;
            param_803 = _e333;
            param_804 = 0u;
            param_805 = _e335;
            let _e337 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_802), (&param_803), (&param_804), (&param_805));
            let _e338 = atomicCompareExchangeWeak((&unnamed.grid[_e328]), _e331, _e337);
        }
        return;
    }
    let _e340 = (*center_1);
    let _e341 = (*pos_17);
    inward = normalize(vec3<f32>((_e340 - _e341)));
    let _e345 = (*center_1);
    param_806 = _e345;
    let _e346 = (*pos_17);
    param_807 = _e346;
    let _e347 = bhOrbitAxis_u0028_vi3_u003b_vi3_u003b((&param_806), (&param_807));
    axis = _e347;
    let _e348 = axis;
    let _e349 = inward;
    tangent = cross(_e348, _e349);
    let _e351 = tangent;
    tangentLen = length(_e351);
    let _e353 = tangentLen;
    if (_e353 < 0.05f) {
        let _e355 = axis;
        tangent = normalize(cross(_e355, vec3<f32>(0.577f, 0.577f, 0.577f)));
    } else {
        let _e358 = tangentLen;
        let _e359 = tangent;
        tangent = (_e359 / vec3(_e358));
    }
    let _e362 = (*pos_17);
    let _e363 = (*center_1);
    let _e366 = axis;
    axial = dot(vec3<f32>((_e362 - _e363)), _e366);
    let _e368 = axis;
    let _e370 = axial;
    let _e375 = tuning.blackHolePlaneGrip;
    grip = ((-(_e368) * clamp((_e370 * 0.5f), -1f, 1f)) * _e375);
    let _e377 = tangent;
    let _e378 = grip;
    along = normalize((_e377 + _e378));
    let _e381 = (*randVal_12);
    let _e384 = infallChance;
    pullIn = (fract((_e381 * 61f)) < clamp(_e384, 0f, 1f));
    let _e387 = inward;
    let _e388 = tangent;
    spiral = normalize((_e387 + (_e388 * 0.6f)));
    let _e392 = pullIn;
    phi_1927_ = _e392;
    if _e392 {
        let _e393 = spiral;
        param_808 = _e393;
        param_809 = 0.55f;
        let _e394 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_808), (&param_809));
        let _e395 = (*pos_17);
        param_810 = _e395;
        let _e396 = (*currentIndex_13);
        param_811 = _e396;
        let _e397 = (*rawValue_11);
        param_812 = _e397;
        param_813 = _e394;
        let _e398 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_810), (&param_811), (&param_812), (&param_813));
        phi_1927_ = _e398;
    }
    let _e400 = phi_1927_;
    if _e400 {
        return;
    }
    let _e401 = along;
    param_814 = _e401;
    param_815 = 0.55f;
    let _e402 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_814), (&param_815));
    let _e403 = (*pos_17);
    param_816 = _e403;
    let _e404 = (*currentIndex_13);
    param_817 = _e404;
    let _e405 = (*rawValue_11);
    param_818 = _e405;
    param_819 = _e402;
    let _e406 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_816), (&param_817), (&param_818), (&param_819));
    if _e406 {
        return;
    }
    let _e407 = along;
    param_820 = _e407;
    param_821 = 1f;
    let _e408 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_820), (&param_821));
    let _e409 = (*pos_17);
    param_822 = _e409;
    let _e410 = (*currentIndex_13);
    param_823 = _e410;
    let _e411 = (*rawValue_11);
    param_824 = _e411;
    param_825 = _e408;
    let _e412 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_822), (&param_823), (&param_824), (&param_825));
    if _e412 {
        return;
    }
    let _e413 = tangent;
    param_826 = _e413;
    param_827 = 1f;
    let _e414 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_826), (&param_827));
    let _e415 = (*pos_17);
    param_828 = _e415;
    let _e416 = (*currentIndex_13);
    param_829 = _e416;
    let _e417 = (*rawValue_11);
    param_830 = _e417;
    param_831 = _e414;
    let _e418 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_828), (&param_829), (&param_830), (&param_831));
    if _e418 {
        return;
    }
    let _e419 = inward;
    param_832 = _e419;
    param_833 = 0.55f;
    let _e420 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_832), (&param_833));
    let _e421 = (*pos_17);
    param_834 = _e421;
    let _e422 = (*currentIndex_13);
    param_835 = _e422;
    let _e423 = (*rawValue_11);
    param_836 = _e423;
    param_837 = _e420;
    let _e424 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_834), (&param_835), (&param_836), (&param_837));
    if _e424 {
        return;
    }
    let _e425 = inward;
    param_838 = _e425;
    param_839 = 1f;
    let _e426 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_838), (&param_839));
    let _e427 = (*pos_17);
    param_840 = _e427;
    let _e428 = (*currentIndex_13);
    param_841 = _e428;
    let _e429 = (*rawValue_11);
    param_842 = _e429;
    param_843 = _e426;
    let _e430 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_840), (&param_841), (&param_842), (&param_843));
    if _e430 {
        return;
    }
    let _e431 = sleep_2;
    if (_e431 != 0u) {
        let _e433 = (*currentIndex_13);
        let _e436 = (*rawValue_11);
        let _e437 = (*rawValue_11);
        param_844 = _e437;
        let _e438 = getDir_u0028_u1_u003b((&param_844));
        let _e439 = (*rawValue_11);
        param_845 = _e439;
        let _e440 = getAge_u0028_u1_u003b((&param_845));
        let _e441 = type_37;
        param_846 = _e441;
        param_847 = _e438;
        param_848 = 0u;
        param_849 = _e440;
        let _e442 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_846), (&param_847), (&param_848), (&param_849));
        let _e443 = atomicCompareExchangeWeak((&unnamed.grid[_e433]), _e436, _e442);
    }
    return;
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_2: u32;
    var l: u32;
    var r_5: f32;
    var param_850: u32;
    var volume: f32;

    level_2 = 0u;
    l = 1u;
    loop {
        let _e199 = l;
        let _e201 = tuning.blackHoleMaxLevel;
        if (_e199 <= min(_e201, 16u)) {
            let _e204 = l;
            param_850 = _e204;
            let _e205 = bhBodyRadius_u0028_u1_u003b((&param_850));
            r_5 = _e205;
            let _e206 = r_5;
            let _e208 = r_5;
            let _e210 = r_5;
            volume = (((4.18879f * _e206) * _e208) * _e210);
            let _e212 = (*mass);
            let _e215 = tuning.blackHoleGrowthCost;
            let _e216 = volume;
            if (f32(_e212) < (_e215 * _e216)) {
                break;
            }
            let _e219 = l;
            level_2 = _e219;
            continue;
        } else {
            break;
        }
        continuing {
            let _e220 = l;
            l = (_e220 + bitcast<u32>(1i));
        }
    }
    let _e223 = level_2;
    return _e223;
}

fn bhLevelFor_u0028_u1_u003b_u1_u003b(code_1: ptr<function, u32>, mass_1: ptr<function, u32>) -> u32 {
    var param_851: u32;
    var param_852: u32;

    let _e197 = (*code_1);
    param_851 = _e197;
    let _e198 = bhIsPurge_u0028_u1_u003b((&param_851));
    if _e198 {
        let _e200 = tuning.purgeLevel;
        let _e202 = (*mass_1);
        let _e205 = tuning.purgeMass;
        return u32((f32(_e200) * clamp((f32(_e202) / f32(max(_e205, 1u))), 0f, 1f)));
    }
    let _e212 = (*mass_1);
    param_852 = _e212;
    let _e213 = bhLevel_u0028_u1_u003b((&param_852));
    return _e213;
}

fn bhDecode_u0028_u1_u003b(code_2: ptr<function, u32>) -> vec3<i32> {
    var i_23: u32;

    let _e195 = (*code_2);
    i_23 = (_e195 & 1073741823u);
    let _e197 = i_23;
    let _e199 = tuning.gridWidth;
    let _e204 = i_23;
    let _e206 = tuning.gridWidth;
    let _e211 = tuning.gridHeight;
    let _e216 = i_23;
    let _e218 = tuning.gridWidth;
    let _e221 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e197 % bitcast<u32>(bitcast<i32>(_e199)))), bitcast<i32>(((_e204 / bitcast<u32>(bitcast<i32>(_e206))) % bitcast<u32>(bitcast<i32>(_e211)))), bitcast<i32>((_e216 / bitcast<u32>((bitcast<i32>(_e218) * bitcast<i32>(_e221))))));
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
    var param_853: u32;
    var d_23: vec3<f32>;
    var distSq: f32;
    var purge_1: bool;
    var param_854: u32;
    var level_3: u32;
    var param_855: u32;
    var param_856: u32;
    var radius: f32;
    var local_29: f32;
    var param_857: vec3<i32>;
    var param_858: u32;
    var param_859: u32;
    var param_860: vec3<i32>;
    var param_861: i32;
    var param_862: u32;
    var param_863: bool;
    var param_864: f32;
    var param_865: f32;

    let _e227 = unnamed_1.blackHoleCount;
    if (_e227 == 0u) {
        return false;
    }
    bestDistSq = 3000000000f;
    bestCenter = vec3<i32>(0i, 0i, 0i);
    bestSlot = -1i;
    bestLevel = 0u;
    bestPurge = false;
    let _e230 = tuning.blackHoleRadius;
    let _e232 = tuning.blackHoleMaxLevel;
    maxRadius = f32((_e230 + min(_e232, 16u)));
    let _e236 = maxRadius;
    let _e237 = maxRadius;
    maxRadiusSq = (_e236 * _e237);
    i_24 = 0i;
    loop {
        let _e239 = i_24;
        if (_e239 < 8i) {
            let _e241 = i_24;
            let _e244 = atomicLoad((&unnamed_1.blackHoles[_e241]));
            code_3 = _e244;
            let _e245 = code_3;
            if (_e245 == 0u) {
                continue;
            }
            let _e247 = code_3;
            param_853 = _e247;
            let _e248 = bhDecode_u0028_u1_u003b((&param_853));
            center_2 = _e248;
            let _e249 = center_2;
            let _e250 = (*pos_18);
            d_23 = vec3<f32>((_e249 - _e250));
            let _e253 = d_23;
            let _e254 = d_23;
            distSq = dot(_e253, _e254);
            let _e256 = code_3;
            param_854 = _e256;
            let _e257 = bhIsPurge_u0028_u1_u003b((&param_854));
            purge_1 = _e257;
            let _e258 = purge_1;
            let _e260 = distSq;
            let _e261 = maxRadiusSq;
            if (!(_e258) && (_e260 > _e261)) {
                continue;
            }
            let _e264 = distSq;
            let _e265 = bestDistSq;
            if (_e264 >= _e265) {
                continue;
            }
            let _e267 = i_24;
            let _e268 = code_3;
            param_855 = _e268;
            let _e271 = atomicLoad((&unnamed_1.blackHoleMass[_e267]));
            param_856 = _e271;
            let _e272 = bhLevelFor_u0028_u1_u003b_u1_u003b((&param_855), (&param_856));
            level_3 = _e272;
            let _e273 = purge_1;
            if _e273 {
                local_29 = 1000000000f;
            } else {
                let _e275 = tuning.blackHoleRadius;
                let _e276 = level_3;
                local_29 = f32((_e275 + _e276));
            }
            let _e279 = local_29;
            radius = _e279;
            let _e280 = distSq;
            let _e281 = radius;
            let _e282 = radius;
            if (_e280 <= (_e281 * _e282)) {
                let _e285 = distSq;
                bestDistSq = _e285;
                let _e286 = center_2;
                bestCenter = _e286;
                let _e287 = i_24;
                bestSlot = _e287;
                let _e288 = level_3;
                bestLevel = _e288;
                let _e289 = purge_1;
                bestPurge = _e289;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e290 = i_24;
            i_24 = (_e290 + 1i);
        }
    }
    let _e292 = bestSlot;
    if (_e292 < 0i) {
        return false;
    }
    let _e294 = bestDistSq;
    let _e296 = (*pos_18);
    param_857 = _e296;
    let _e297 = (*currentIndex_14);
    param_858 = _e297;
    let _e298 = (*rawValue_12);
    param_859 = _e298;
    let _e299 = bestCenter;
    param_860 = _e299;
    let _e300 = bestSlot;
    param_861 = _e300;
    let _e301 = bestLevel;
    param_862 = _e301;
    let _e302 = bestPurge;
    param_863 = _e302;
    param_864 = sqrt(_e294);
    let _e303 = (*randVal_13);
    param_865 = _e303;
    updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b((&param_857), (&param_858), (&param_859), (&param_860), (&param_861), (&param_862), (&param_863), (&param_864), (&param_865));
    return true;
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x_4: ptr<function, i32>, z_5: ptr<function, i32>) -> u32 {
    let _e195 = (*x_4);
    let _e196 = (*z_5);
    let _e198 = tuning.gridWidth;
    return (bitcast<u32>((_e195 + (_e196 * bitcast<i32>(_e198)))) * 4u);
}

fn bhRegister_u0028_vi3_u003b(p_4: ptr<function, vec3<i32>>) -> bool {
    var code_4: u32;
    var param_866: vec3<i32>;
    var i_25: i32;

    let _e197 = (*p_4);
    param_866 = _e197;
    let _e198 = getIndex_u0028_vi3_u003b((&param_866));
    code_4 = (2147483648u | _e198);
    i_25 = 0i;
    loop {
        let _e200 = i_25;
        if (_e200 < 8i) {
            let _e202 = i_25;
            let _e205 = code_4;
            let _e206 = atomicCompareExchangeWeak((&unnamed_1.blackHoles[_e202]), 0u, _e205);
            if (_e206.old_value == 0u) {
                let _e209 = i_25;
                atomicStore((&unnamed_1.blackHoleMass[_e209]), 0u);
                let _e212 = i_25;
                unnamed_1.blackHoleStarve[_e212] = 0u;
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e215 = i_25;
            i_25 = (_e215 + 1i);
        }
    }
    return false;
}

fn writeCell_u0028_u1_u003b_u1_u003b(index_1: ptr<function, u32>, value_2: ptr<function, u32>) {
    let _e195 = (*index_1);
    let _e196 = (*value_2);
    atomicStore((&unnamed.grid[_e195]), _e196);
    return;
}

fn lavaSpawnCoolness_u0028_u1_u003b(type_38: ptr<function, u32>) -> u32 {
    var param_867: u32;

    let _e195 = (*type_38);
    if (_e195 == 12u) {
        let _e197 = lavaSolidifyCoolness_u0028_();
        return _e197;
    }
    let _e198 = (*type_38);
    param_867 = _e198;
    let _e199 = isLava_u0028_u1_u003b((&param_867));
    if _e199 {
        let _e200 = (*type_38);
        let _e203 = tuning.lavaStageSize;
        return ((_e200 - 8u) * max(_e203, 1u));
    }
    return 0u;
}

fn locustSpawnCount_u0028_u1_u003b(type_39: ptr<function, u32>) -> u32 {
    var param_868: u32;

    let _e195 = (*type_39);
    param_868 = _e195;
    let _e196 = isLocust_u0028_u1_u003b((&param_868));
    if !(_e196) {
        return 0u;
    }
    let _e198 = (*type_39);
    let _e201 = locustStage_u0028_();
    let _e203 = locustMaxCount_u0028_();
    return min((((_e198 - 13u) + 1u) * _e201), _e203);
}

fn bhRelease_u0028_vi3_u003b(p_5: ptr<function, vec3<i32>>) {
    var code_5: u32;
    var param_869: vec3<i32>;
    var i_26: i32;

    let _e197 = (*p_5);
    param_869 = _e197;
    let _e198 = getIndex_u0028_vi3_u003b((&param_869));
    code_5 = (2147483648u | _e198);
    i_26 = 0i;
    loop {
        let _e200 = i_26;
        if (_e200 < 8i) {
            let _e202 = i_26;
            let _e205 = code_5;
            let _e206 = atomicCompareExchangeWeak((&unnamed_1.blackHoles[_e202]), _e205, 0u);
            continue;
        } else {
            break;
        }
        continuing {
            let _e208 = i_26;
            i_26 = (_e208 + 1i);
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
    var phi_1389_: bool;
    var phi_1411_: bool;
    var phi_1432_: bool;

    let _e200 = pc.spawnSize;
    halfMin = (_e200 / 2i);
    let _e203 = pc.spawnSize;
    halfMax = ((_e203 - 1i) / 2i);
    let _e207 = (*pos_19)[0u];
    let _e209 = pc.spawnX;
    let _e210 = halfMin;
    let _e212 = (_e207 < (_e209 - _e210));
    phi_1389_ = _e212;
    if !(_e212) {
        let _e215 = (*pos_19)[0u];
        let _e217 = pc.spawnX;
        let _e218 = halfMax;
        phi_1389_ = (_e215 > (_e217 + _e218));
    }
    let _e222 = phi_1389_;
    if _e222 {
        return false;
    }
    let _e224 = (*pos_19)[1u];
    let _e226 = pc.spawnY;
    let _e227 = halfMin;
    let _e229 = (_e224 < (_e226 - _e227));
    phi_1411_ = _e229;
    if !(_e229) {
        let _e232 = (*pos_19)[1u];
        let _e234 = pc.spawnY;
        let _e235 = halfMax;
        phi_1411_ = (_e232 > (_e234 + _e235));
    }
    let _e239 = phi_1411_;
    if _e239 {
        return false;
    }
    let _e241 = (*pos_19)[2u];
    let _e243 = pc.spawnZ;
    let _e244 = halfMin;
    let _e246 = (_e241 < (_e243 - _e244));
    phi_1432_ = _e246;
    if !(_e246) {
        let _e249 = (*pos_19)[2u];
        let _e251 = pc.spawnZ;
        let _e252 = halfMax;
        phi_1432_ = (_e249 > (_e251 + _e252));
    }
    let _e256 = phi_1432_;
    if _e256 {
        return false;
    }
    let _e258 = pc.spawnShape;
    if (_e258 != 1i) {
        return true;
    }
    let _e261 = pc.spawnX;
    let _e264 = pc.spawnY;
    let _e267 = pc.spawnZ;
    let _e270 = halfMax;
    let _e271 = halfMin;
    center_3 = (vec3<f32>(f32(_e261), f32(_e264), f32(_e267)) + vec3((f32(((_e270 - _e271) + 1i)) * 0.5f)));
    let _e278 = (*pos_19);
    let _e282 = center_3;
    d_24 = ((vec3<f32>(_e278) + vec3(0.5f)) - _e282);
    let _e285 = pc.spawnSize;
    radius_1 = (f32(_e285) * 0.5f);
    let _e288 = d_24;
    let _e289 = d_24;
    let _e291 = radius_1;
    let _e292 = radius_1;
    return (dot(_e288, _e289) <= (_e291 * _e292));
}

fn tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b(fromIndex: ptr<function, u32>, fromValue: ptr<function, u32>, toIndex: ptr<function, u32>) -> bool {
    let _e196 = (*toIndex);
    let _e199 = (*fromValue);
    let _e200 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e196]), 0u, _e199);
    if (_e200.old_value != 0u) {
        return false;
    }
    let _e203 = (*fromIndex);
    let _e206 = (*fromValue);
    let _e207 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e203]), _e206, 0u);
    let _e209 = (*fromValue);
    if (_e207.old_value != _e209) {
        let _e211 = (*toIndex);
        let _e214 = atomicExchange((&unnamed_2.cloudCells[_e211]), 0u);
        return false;
    }
    return true;
}

fn getCloudWait_u0028_u1_u003b(v_2: ptr<function, u32>) -> u32 {
    let _e194 = (*v_2);
    return ((_e194 >> bitcast<u32>(2i)) & 255u);
}

fn getCloudKind_u0028_u1_u003b(v_3: ptr<function, u32>) -> u32 {
    let _e194 = (*v_3);
    return (_e194 & 3u);
}

fn updateCloudBlock_u0028_vi3_u003b(pos_20: ptr<function, vec3<i32>>) {
    var idx_4: u32;
    var param_870: vec3<i32>;
    var base: u32;
    var param_871: i32;
    var param_872: i32;
    var cell: u32;
    var kind_1: u32;
    var param_873: u32;
    var r_6: f32;
    var param_874: vec3<f32>;
    var waitMax: u32;
    var newCell: u32;
    var param_875: u32;
    var param_876: u32;
    var param_877: u32;
    var wait_1: u32;
    var param_878: u32;
    var param_879: u32;
    var param_880: u32;
    var param_881: u32;
    var g: u32;
    var param_882: u32;
    var param_883: u32;
    var param_884: u32;
    var param_885: u32;
    var param_886: u32;
    var param_887: u32;
    var randVal_14: f32;
    var param_888: vec3<f32>;
    var upIndex_1: u32;
    var param_889: vec3<i32>;
    var param_890: u32;
    var param_891: u32;
    var param_892: u32;
    var param_893: u32;
    var dir_7: i32;
    var slide1_: vec3<i32>;
    var slide2_: vec3<i32>;
    var i_27: i32;
    var t_4: vec3<i32>;
    var tIndex: u32;
    var param_894: vec3<i32>;
    var param_895: u32;
    var param_896: u32;
    var param_897: u32;
    var param_898: u32;
    var phi_8663_: bool;
    var phi_8872_: bool;
    var phi_8879_: bool;
    var phi_8889_: bool;

    let _e240 = (*pos_20);
    param_870 = _e240;
    let _e241 = getIndex_u0028_vi3_u003b((&param_870));
    idx_4 = _e241;
    let _e243 = (*pos_20)[0u];
    param_871 = _e243;
    let _e245 = (*pos_20)[2u];
    param_872 = _e245;
    let _e246 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_871), (&param_872));
    base = _e246;
    let _e248 = (*pos_20)[1u];
    if (_e248 == 0i) {
        let _e250 = base;
        let _e252 = base;
        let _e256 = atomicLoad((&unnamed_1.cloudColumn[(_e252 + 0u)]));
        atomicStore((&unnamed_1.cloudColumn[(_e250 + 2u)]), _e256);
        let _e259 = base;
        let _e261 = base;
        let _e265 = atomicLoad((&unnamed_1.cloudColumn[(_e261 + 1u)]));
        atomicStore((&unnamed_1.cloudColumn[(_e259 + 3u)]), _e265);
        let _e268 = base;
        atomicStore((&unnamed_1.cloudColumn[(_e268 + 0u)]), 0u);
        let _e272 = base;
        atomicStore((&unnamed_1.cloudColumn[(_e272 + 1u)]), 0u);
    }
    let _e276 = idx_4;
    let _e279 = atomicLoad((&unnamed_2.cloudCells[_e276]));
    cell = _e279;
    let _e280 = cell;
    param_873 = _e280;
    let _e281 = getCloudKind_u0028_u1_u003b((&param_873));
    kind_1 = _e281;
    let _e282 = kind_1;
    if (_e282 == 0u) {
        return;
    }
    let _e285 = atomicAdd((&unnamed_1.cloudBlockCount), 1u);
    let _e286 = base;
    let _e290 = atomicAdd((&unnamed_1.cloudColumn[(_e286 + 0u)]), 1u);
    let _e291 = base;
    let _e296 = (*pos_20)[1u];
    let _e298 = atomicMax((&unnamed_1.cloudColumn[(_e291 + 1u)]), bitcast<u32>(_e296));
    let _e299 = kind_1;
    let _e300 = (_e299 == 1u);
    phi_8663_ = _e300;
    if _e300 {
        let _e302 = unnamed_1.rainPhase;
        phi_8663_ = (_e302 == 2u);
    }
    let _e305 = phi_8663_;
    if _e305 {
        let _e306 = (*pos_20);
        let _e309 = pc.time;
        param_874 = (vec3<f32>(_e306) + vec3<f32>(_e309, 17f, 3f));
        let _e312 = hash_u0028_vf3_u003b((&param_874));
        r_6 = _e312;
        let _e314 = tuning.stormWaitMaxTicks;
        waitMax = clamp(_e314, 1u, 255u);
        let _e316 = r_6;
        let _e317 = waitMax;
        param_875 = 2u;
        param_876 = u32((_e316 * f32(_e317)));
        param_877 = 0u;
        let _e321 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_875), (&param_876), (&param_877));
        newCell = _e321;
        let _e322 = idx_4;
        let _e325 = cell;
        let _e326 = newCell;
        let _e327 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e322]), _e325, _e326);
        let _e329 = cell;
        if (_e327.old_value != _e329) {
            return;
        }
        let _e331 = newCell;
        cell = _e331;
        kind_1 = 2u;
    }
    let _e333 = (*pos_20)[1u];
    let _e335 = tuning.gridHeight;
    if (_e333 >= (bitcast<i32>(_e335) - 2i)) {
        let _e339 = kind_1;
        if (_e339 != 2u) {
            return;
        }
        let _e341 = cell;
        param_878 = _e341;
        let _e342 = getCloudWait_u0028_u1_u003b((&param_878));
        wait_1 = _e342;
        let _e343 = wait_1;
        if (_e343 > 0u) {
            let _e345 = idx_4;
            let _e348 = cell;
            let _e349 = wait_1;
            param_879 = 2u;
            param_880 = (_e349 - 1u);
            param_881 = 0u;
            let _e351 = packCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_879), (&param_880), (&param_881));
            let _e352 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e345]), _e348, _e351);
            return;
        }
        let _e354 = idx_4;
        param_882 = _e354;
        let _e355 = readCell_u0028_u1_u003b((&param_882));
        g = _e355;
        let _e356 = g;
        param_883 = _e356;
        let _e357 = getType_u0028_u1_u003b((&param_883));
        if (_e357 != 0u) {
            return;
        }
        let _e359 = idx_4;
        let _e362 = g;
        param_884 = 2u;
        param_885 = 0u;
        param_886 = 0u;
        param_887 = 0u;
        let _e363 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_884), (&param_885), (&param_886), (&param_887));
        let _e364 = atomicCompareExchangeWeak((&unnamed.grid[_e359]), _e362, _e363);
        let _e366 = g;
        if (_e364.old_value != _e366) {
            return;
        }
        let _e368 = idx_4;
        let _e371 = cell;
        let _e372 = atomicCompareExchangeWeak((&unnamed_2.cloudCells[_e368]), _e371, 0u);
        incWater_u0028_();
        let _e375 = (*pos_20)[1u];
        let _e378 = atomicLoad((&unnamed_1.maxOccupiedY));
        if (bitcast<u32>(_e375) > _e378) {
            let _e382 = (*pos_20)[1u];
            let _e384 = atomicMax((&unnamed_1.maxOccupiedY), bitcast<u32>(_e382));
        }
        return;
    }
    let _e385 = (*pos_20);
    let _e388 = pc.time;
    param_888 = (vec3<f32>(_e385) + vec3<f32>((_e388 * 2.3f), 7f, 13f));
    let _e392 = hash_u0028_vf3_u003b((&param_888));
    randVal_14 = _e392;
    let _e393 = (*pos_20);
    param_889 = (_e393 + vec3<i32>(0i, 1i, 0i));
    let _e395 = getIndex_u0028_vi3_u003b((&param_889));
    upIndex_1 = _e395;
    let _e396 = upIndex_1;
    let _e399 = atomicLoad((&unnamed_2.cloudCells[_e396]));
    param_890 = _e399;
    let _e400 = getCloudKind_u0028_u1_u003b((&param_890));
    if (_e400 == 0u) {
        let _e402 = idx_4;
        param_891 = _e402;
        let _e403 = cell;
        param_892 = _e403;
        let _e404 = upIndex_1;
        param_893 = _e404;
        let _e405 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_891), (&param_892), (&param_893));
        if _e405 {
            let _e407 = atomicAdd((&unnamed_1.cloudMovedCount), 1u);
            return;
        }
    }
    let _e408 = randVal_14;
    dir_7 = select(-1i, 1i, (fract((_e408 * 10f)) > 0.5f));
    let _e413 = randVal_14;
    if (fract((_e413 * 100f)) > 0.5f) {
        let _e417 = (*pos_20);
        let _e418 = dir_7;
        slide1_ = (_e417 + vec3<i32>(_e418, 1i, 0i));
        let _e421 = (*pos_20);
        let _e422 = dir_7;
        slide2_ = (_e421 + vec3<i32>(0i, 1i, _e422));
    } else {
        let _e425 = (*pos_20);
        let _e426 = dir_7;
        slide1_ = (_e425 + vec3<i32>(0i, 1i, _e426));
        let _e429 = (*pos_20);
        let _e430 = dir_7;
        slide2_ = (_e429 + vec3<i32>(_e430, 1i, 0i));
    }
    i_27 = 0i;
    loop {
        let _e433 = i_27;
        if (_e433 < 2i) {
            let _e435 = i_27;
            let _e437 = slide1_;
            let _e438 = slide2_;
            t_4 = select(_e438, _e437, vec3((_e435 == 0i)));
            let _e442 = t_4[0u];
            let _e443 = (_e442 < 0i);
            phi_8872_ = _e443;
            if !(_e443) {
                let _e446 = t_4[0u];
                let _e448 = tuning.gridWidth;
                phi_8872_ = (_e446 >= bitcast<i32>(_e448));
            }
            let _e452 = phi_8872_;
            phi_8879_ = _e452;
            if !(_e452) {
                let _e455 = t_4[2u];
                phi_8879_ = (_e455 < 0i);
            }
            let _e458 = phi_8879_;
            phi_8889_ = _e458;
            if !(_e458) {
                let _e461 = t_4[2u];
                let _e463 = tuning.gridDepth;
                phi_8889_ = (_e461 >= bitcast<i32>(_e463));
            }
            let _e467 = phi_8889_;
            if _e467 {
                continue;
            }
            let _e468 = t_4;
            param_894 = _e468;
            let _e469 = getIndex_u0028_vi3_u003b((&param_894));
            tIndex = _e469;
            let _e470 = tIndex;
            let _e473 = atomicLoad((&unnamed_2.cloudCells[_e470]));
            param_895 = _e473;
            let _e474 = getCloudKind_u0028_u1_u003b((&param_895));
            if (_e474 != 0u) {
                continue;
            }
            let _e476 = idx_4;
            param_896 = _e476;
            let _e477 = cell;
            param_897 = _e477;
            let _e478 = tIndex;
            param_898 = _e478;
            let _e479 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b((&param_896), (&param_897), (&param_898));
            if _e479 {
                let _e481 = atomicAdd((&unnamed_1.cloudMovedCount), 1u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e482 = i_27;
            i_27 = (_e482 + 1i);
        }
    }
    return;
}

fn updateSimState_u0028_() {
    var live: u32;
    var i_28: i32;
    var code_6: u32;
    var voxel: u32;
    var param_899: u32;
    var param_900: u32;
    var starve: u32;
    var purge_2: bool;
    var param_901: u32;
    var grace: u32;
    var local_30: u32;
    var decay: u32;
    var local_31: u32;
    var mass_2: u32;
    var param_902: u32;
    var param_903: u32;
    var liveClouds: u32;
    var chargeTarget: f32;
    var charge: f32;
    var crossedTime: f32;
    var phi_7982_: bool;
    var phi_7989_: bool;
    var phi_8162_: bool;

    let _e214 = gl_GlobalInvocationID_1[0u];
    let _e215 = (_e214 != 0u);
    phi_7982_ = _e215;
    if !(_e215) {
        let _e218 = gl_GlobalInvocationID_1[1u];
        phi_7982_ = (_e218 != 0u);
    }
    let _e221 = phi_7982_;
    phi_7989_ = _e221;
    if !(_e221) {
        let _e224 = gl_GlobalInvocationID_1[2u];
        phi_7989_ = (_e224 != 0u);
    }
    let _e227 = phi_7989_;
    if _e227 {
        return;
    }
    live = 0u;
    i_28 = 0i;
    loop {
        let _e228 = i_28;
        if (_e228 < 8i) {
            let _e230 = i_28;
            let _e233 = atomicLoad((&unnamed_1.blackHoles[_e230]));
            code_6 = _e233;
            let _e234 = code_6;
            if (_e234 == 0u) {
                continue;
            }
            let _e236 = code_6;
            voxel = (_e236 & 1073741823u);
            let _e238 = voxel;
            param_899 = _e238;
            let _e239 = readCell_u0028_u1_u003b((&param_899));
            param_900 = _e239;
            let _e240 = getType_u0028_u1_u003b((&param_900));
            if (_e240 != 7u) {
                let _e242 = i_28;
                atomicStore((&unnamed_1.blackHoles[_e242]), 0u);
                continue;
            }
            let _e245 = i_28;
            let _e248 = unnamed_1.blackHoleStarve[_e245];
            starve = (_e248 + 1u);
            let _e250 = i_28;
            let _e251 = starve;
            unnamed_1.blackHoleStarve[_e250] = _e251;
            let _e254 = code_6;
            param_901 = _e254;
            let _e255 = bhIsPurge_u0028_u1_u003b((&param_901));
            purge_2 = _e255;
            let _e256 = purge_2;
            if _e256 {
                let _e258 = tuning.purgeStarveGrace;
                local_30 = _e258;
            } else {
                let _e260 = tuning.blackHoleStarveGrace;
                local_30 = _e260;
            }
            let _e261 = local_30;
            grace = _e261;
            let _e262 = purge_2;
            if _e262 {
                let _e264 = tuning.purgeDecayRate;
                local_31 = _e264;
            } else {
                let _e266 = tuning.blackHoleDecayRate;
                local_31 = _e266;
            }
            let _e267 = local_31;
            decay = _e267;
            let _e268 = starve;
            let _e269 = grace;
            if (_e268 > _e269) {
                let _e271 = i_28;
                let _e274 = atomicLoad((&unnamed_1.blackHoleMass[_e271]));
                mass_2 = _e274;
                let _e275 = mass_2;
                if (_e275 == 0u) {
                    let _e277 = voxel;
                    param_902 = _e277;
                    param_903 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_902), (&param_903));
                    let _e278 = i_28;
                    atomicStore((&unnamed_1.blackHoles[_e278]), 0u);
                    continue;
                }
                let _e281 = i_28;
                let _e282 = mass_2;
                let _e283 = mass_2;
                let _e284 = decay;
                atomicStore((&unnamed_1.blackHoleMass[_e281]), (_e282 - min(_e283, _e284)));
            }
            let _e289 = live;
            live = (_e289 + bitcast<u32>(1i));
            continue;
        } else {
            break;
        }
        continuing {
            let _e292 = i_28;
            i_28 = (_e292 + 1i);
        }
    }
    let _e294 = live;
    unnamed_1.blackHoleCount = _e294;
    let _e297 = atomicLoad((&unnamed_1.maxOccupiedY));
    if (_e297 > 0u) {
        let _e300 = atomicAdd((&unnamed_1.maxOccupiedY), 4294967295u);
    }
    let _e302 = atomicLoad((&unnamed_1.rainCandidateCount));
    unnamed_1.rainCandidateEstimate = _e302;
    atomicStore((&unnamed_1.rainCandidateCount), 0u);
    let _e306 = atomicLoad((&unnamed_1.cloudMovedCount));
    if (_e306 == 0u) {
        let _e309 = unnamed_1.cloudStillTicks;
        unnamed_1.cloudStillTicks = min((_e309 + 1u), 4294967294u);
    } else {
        unnamed_1.cloudStillTicks = 0u;
    }
    let _e315 = atomicLoad((&unnamed_1.cloudBlockCount));
    liveClouds = _e315;
    atomicStore((&unnamed_1.cloudBlockCount), 0u);
    atomicStore((&unnamed_1.cloudMovedCount), 0u);
    let _e319 = unnamed_1.rainPhase;
    chargeTarget = select(1f, 0f, (_e319 == 0u));
    let _e323 = unnamed_1.cloudChargeBits;
    charge = bitcast<f32>(_e323);
    let _e325 = chargeTarget;
    let _e326 = charge;
    let _e329 = tuning.cloudChargeEaseRate;
    let _e332 = charge;
    charge = (_e332 + ((_e325 - _e326) * clamp(_e329, 0f, 1f)));
    let _e334 = charge;
    unnamed_1.cloudChargeBits = bitcast<u32>(clamp(_e334, 0f, 1f));
    let _e339 = unnamed_1.rainPhase;
    if (_e339 == 0u) {
        let _e341 = liveClouds;
        let _e342 = (_e341 > 0u);
        phi_8162_ = _e342;
        if _e342 {
            let _e344 = unnamed_1.cloudStillTicks;
            let _e346 = tuning.cloudStillTicksToStorm;
            phi_8162_ = (_e344 >= _e346);
        }
        let _e349 = phi_8162_;
        if _e349 {
            unnamed_1.rainPhase = 1u;
            let _e352 = pc.time;
            unnamed_1.rainPhaseTimeBits = bitcast<u32>(_e352);
        }
    } else {
        let _e356 = unnamed_1.rainPhase;
        if (_e356 == 1u) {
            let _e359 = unnamed_1.rainPhaseTimeBits;
            crossedTime = bitcast<f32>(_e359);
            let _e362 = pc.time;
            let _e363 = crossedTime;
            let _e366 = tuning.rainDarkenDelay;
            if ((_e362 - _e363) >= _e366) {
                unnamed_1.rainPhase = 2u;
                let _e370 = pc.time;
                unnamed_1.rainPhaseTimeBits = bitcast<u32>(_e370);
            }
        } else {
            let _e374 = unnamed_1.rainPhase;
            if (_e374 == 2u) {
                let _e376 = liveClouds;
                if (_e376 == 0u) {
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
    var param_904: vec3<i32>;
    var param_905: vec3<i32>;
    var spawnIndex: u32;
    var param_906: vec3<i32>;
    var oldType: u32;
    var param_907: u32;
    var param_908: u32;
    var newType_3: u32;
    var param_909: vec3<i32>;
    var seedAge: u32;
    var param_910: u32;
    var local_32: u32;
    var param_911: u32;
    var param_912: u32;
    var param_913: u32;
    var param_914: u32;
    var param_915: u32;
    var param_916: u32;
    var param_917: u32;
    var param_918: u32;
    var param_919: vec3<i32>;
    var param_920: u32;
    var param_921: u32;
    var currentIndex_15: u32;
    var param_922: vec3<i32>;
    var rawValue_13: u32;
    var param_923: u32;
    var currentType_1: u32;
    var param_924: u32;
    var param_925: i32;
    var param_926: i32;
    var randVal_15: f32;
    var param_927: vec3<f32>;
    var param_928: vec3<i32>;
    var param_929: u32;
    var param_930: u32;
    var param_931: f32;
    var currentDir_6: u32;
    var param_932: u32;
    var currentSleep_7: u32;
    var param_933: u32;
    var currentAge_10: u32;
    var param_934: u32;
    var param_935: vec3<i32>;
    var param_936: u32;
    var param_937: u32;
    var param_938: u32;
    var param_939: u32;
    var param_940: f32;
    var param_941: vec3<i32>;
    var param_942: u32;
    var param_943: u32;
    var param_944: u32;
    var param_945: u32;
    var param_946: u32;
    var param_947: f32;
    var param_948: vec3<i32>;
    var param_949: u32;
    var param_950: u32;
    var param_951: u32;
    var param_952: u32;
    var param_953: u32;
    var param_954: f32;
    var param_955: vec3<i32>;
    var param_956: u32;
    var param_957: u32;
    var param_958: u32;
    var param_959: u32;
    var param_960: u32;
    var param_961: f32;
    var param_962: vec3<i32>;
    var param_963: u32;
    var param_964: u32;
    var param_965: u32;
    var param_966: u32;
    var param_967: f32;
    var param_968: vec3<i32>;
    var param_969: u32;
    var param_970: u32;
    var param_971: u32;
    var param_972: u32;
    var param_973: u32;
    var param_974: f32;
    var param_975: vec3<i32>;
    var param_976: u32;
    var param_977: u32;
    var param_978: u32;
    var param_979: f32;
    var param_980: vec3<i32>;
    var param_981: u32;
    var param_982: u32;
    var param_983: u32;
    var param_984: u32;
    var param_985: u32;
    var param_986: f32;
    var param_987: vec3<i32>;
    var param_988: u32;
    var param_989: u32;
    var param_990: u32;
    var param_991: u32;
    var param_992: f32;
    var param_993: vec3<i32>;
    var param_994: u32;
    var param_995: u32;
    var param_996: u32;
    var param_997: f32;
    var phi_8938_: bool;
    var phi_8948_: bool;
    var phi_8964_: bool;
    var phi_9063_: bool;
    var phi_9070_: bool;
    var phi_9081_: bool;
    var phi_9088_: bool;
    var phi_9099_: bool;
    var phi_9122_: bool;
    var phi_9132_: bool;
    var phi_9190_: bool;

    let _e300 = gl_GlobalInvocationID_1;
    pos_21 = bitcast<vec3<i32>>(_e300);
    let _e303 = pos_21[0u];
    let _e305 = tuning.gridWidth;
    let _e307 = (_e303 >= bitcast<i32>(_e305));
    phi_8938_ = _e307;
    if !(_e307) {
        let _e310 = pos_21[1u];
        let _e312 = tuning.gridHeight;
        phi_8938_ = (_e310 >= bitcast<i32>(_e312));
    }
    let _e316 = phi_8938_;
    phi_8948_ = _e316;
    if !(_e316) {
        let _e319 = pos_21[2u];
        let _e321 = tuning.gridDepth;
        phi_8948_ = (_e319 >= bitcast<i32>(_e321));
    }
    let _e325 = phi_8948_;
    if _e325 {
        return;
    }
    updateSimState_u0028_();
    let _e326 = pos_21;
    param_904 = _e326;
    updateCloudBlock_u0028_vi3_u003b((&param_904));
    let _e328 = pc.spawnActive;
    let _e329 = (_e328 == 1i);
    phi_8964_ = _e329;
    if _e329 {
        let _e330 = pos_21;
        param_905 = _e330;
        let _e331 = inBrush_u0028_vi3_u003b((&param_905));
        phi_8964_ = _e331;
    }
    let _e333 = phi_8964_;
    if _e333 {
        let _e334 = pos_21;
        param_906 = _e334;
        let _e335 = getIndex_u0028_vi3_u003b((&param_906));
        spawnIndex = _e335;
        let _e336 = spawnIndex;
        param_907 = _e336;
        let _e337 = readCell_u0028_u1_u003b((&param_907));
        param_908 = _e337;
        let _e338 = getType_u0028_u1_u003b((&param_908));
        oldType = _e338;
        let _e340 = pc.spawnType;
        newType_3 = bitcast<u32>(_e340);
        let _e342 = newType_3;
        let _e344 = oldType;
        if ((_e342 != 7u) || (_e344 != 7u)) {
            let _e347 = oldType;
            let _e348 = newType_3;
            if (_e347 != _e348) {
                let _e350 = oldType;
                if (_e350 == 2u) {
                    decWater_u0028_();
                }
                let _e352 = oldType;
                if (_e352 == 7u) {
                    let _e354 = pos_21;
                    param_909 = _e354;
                    bhRelease_u0028_vi3_u003b((&param_909));
                }
                let _e355 = newType_3;
                if (_e355 == 2u) {
                    incWater_u0028_();
                }
            }
            let _e357 = newType_3;
            param_910 = _e357;
            let _e358 = isLocust_u0028_u1_u003b((&param_910));
            if _e358 {
                let _e359 = newType_3;
                param_911 = _e359;
                let _e360 = locustSpawnCount_u0028_u1_u003b((&param_911));
                local_32 = _e360;
            } else {
                let _e361 = newType_3;
                param_912 = _e361;
                let _e362 = lavaSpawnCoolness_u0028_u1_u003b((&param_912));
                local_32 = _e362;
            }
            let _e363 = local_32;
            seedAge = _e363;
            let _e364 = newType_3;
            param_913 = _e364;
            param_914 = 0u;
            param_915 = 0u;
            let _e365 = seedAge;
            param_916 = _e365;
            let _e366 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_913), (&param_914), (&param_915), (&param_916));
            let _e367 = spawnIndex;
            param_917 = _e367;
            param_918 = _e366;
            writeCell_u0028_u1_u003b_u1_u003b((&param_917), (&param_918));
            let _e368 = newType_3;
            if (_e368 == 7u) {
                let _e370 = pos_21;
                param_919 = _e370;
                let _e371 = bhRegister_u0028_vi3_u003b((&param_919));
                if !(_e371) {
                    let _e373 = spawnIndex;
                    param_920 = _e373;
                    param_921 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_920), (&param_921));
                }
            }
        }
    }
    let _e375 = pos_21[0u];
    let _e376 = (_e375 < 1i);
    phi_9063_ = _e376;
    if !(_e376) {
        let _e379 = pos_21[0u];
        let _e381 = tuning.gridWidth;
        phi_9063_ = (_e379 >= (bitcast<i32>(_e381) - 1i));
    }
    let _e386 = phi_9063_;
    phi_9070_ = _e386;
    if !(_e386) {
        let _e389 = pos_21[1u];
        phi_9070_ = (_e389 < 1i);
    }
    let _e392 = phi_9070_;
    phi_9081_ = _e392;
    if !(_e392) {
        let _e395 = pos_21[1u];
        let _e397 = tuning.gridHeight;
        phi_9081_ = (_e395 >= (bitcast<i32>(_e397) - 1i));
    }
    let _e402 = phi_9081_;
    phi_9088_ = _e402;
    if !(_e402) {
        let _e405 = pos_21[2u];
        phi_9088_ = (_e405 < 1i);
    }
    let _e408 = phi_9088_;
    phi_9099_ = _e408;
    if !(_e408) {
        let _e411 = pos_21[2u];
        let _e413 = tuning.gridDepth;
        phi_9099_ = (_e411 >= (bitcast<i32>(_e413) - 1i));
    }
    let _e418 = phi_9099_;
    if _e418 {
        return;
    }
    let _e419 = pos_21;
    param_922 = _e419;
    let _e420 = getIndex_u0028_vi3_u003b((&param_922));
    currentIndex_15 = _e420;
    let _e421 = currentIndex_15;
    param_923 = _e421;
    let _e422 = readCell_u0028_u1_u003b((&param_923));
    rawValue_13 = _e422;
    let _e423 = rawValue_13;
    param_924 = _e423;
    let _e424 = getType_u0028_u1_u003b((&param_924));
    currentType_1 = _e424;
    let _e425 = currentType_1;
    let _e426 = (_e425 == 0u);
    phi_9122_ = _e426;
    if _e426 {
        let _e428 = unnamed_1.rainPhase;
        phi_9122_ = (_e428 >= 1u);
    }
    let _e431 = phi_9122_;
    phi_9132_ = _e431;
    if _e431 {
        let _e433 = pos_21[1u];
        let _e435 = tuning.gridHeight;
        phi_9132_ = (_e433 == (bitcast<i32>(_e435) - 2i));
    }
    let _e440 = phi_9132_;
    if _e440 {
        let _e442 = pos_21[0u];
        param_925 = _e442;
        let _e444 = pos_21[2u];
        param_926 = _e444;
        let _e445 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_925), (&param_926));
        let _e449 = atomicLoad((&unnamed_1.cloudColumn[(_e445 + 2u)]));
        if (_e449 != 0u) {
            let _e452 = atomicAdd((&unnamed_1.rainCandidateCount), 1u);
        }
    }
    let _e453 = currentType_1;
    if (_e453 == 0u) {
        return;
    }
    let _e456 = pos_21[1u];
    let _e459 = atomicLoad((&unnamed_1.maxOccupiedY));
    if (bitcast<u32>(_e456) > _e459) {
        let _e463 = pos_21[1u];
        let _e465 = atomicMax((&unnamed_1.maxOccupiedY), bitcast<u32>(_e463));
    }
    let _e466 = pos_21;
    let _e469 = pc.time;
    param_927 = (vec3<f32>(_e466) + vec3(_e469));
    let _e472 = hash_u0028_vf3_u003b((&param_927));
    randVal_15 = _e472;
    let _e473 = currentType_1;
    let _e474 = (_e473 != 7u);
    phi_9190_ = _e474;
    if _e474 {
        let _e475 = pos_21;
        param_928 = _e475;
        let _e476 = currentIndex_15;
        param_929 = _e476;
        let _e477 = rawValue_13;
        param_930 = _e477;
        let _e478 = randVal_15;
        param_931 = _e478;
        let _e479 = captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b((&param_928), (&param_929), (&param_930), (&param_931));
        phi_9190_ = _e479;
    }
    let _e481 = phi_9190_;
    if _e481 {
        return;
    }
    let _e482 = currentType_1;
    let _e484 = currentType_1;
    if ((_e482 == 3u) || (_e484 == 7u)) {
        return;
    }
    let _e487 = rawValue_13;
    param_932 = _e487;
    let _e488 = getDir_u0028_u1_u003b((&param_932));
    currentDir_6 = _e488;
    let _e489 = rawValue_13;
    param_933 = _e489;
    let _e490 = getSleep_u0028_u1_u003b((&param_933));
    currentSleep_7 = _e490;
    let _e491 = rawValue_13;
    param_934 = _e491;
    let _e492 = getAge_u0028_u1_u003b((&param_934));
    currentAge_10 = _e492;
    let _e493 = currentType_1;
    switch bitcast<i32>(_e493) {
        case 1: {
            let _e495 = pos_21;
            param_935 = _e495;
            let _e496 = currentIndex_15;
            param_936 = _e496;
            let _e497 = rawValue_13;
            param_937 = _e497;
            let _e498 = currentSleep_7;
            param_938 = _e498;
            let _e499 = currentAge_10;
            param_939 = _e499;
            let _e500 = randVal_15;
            param_940 = _e500;
            updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_935), (&param_936), (&param_937), (&param_938), (&param_939), (&param_940));
            break;
        }
        case 2: {
            let _e501 = pos_21;
            param_941 = _e501;
            let _e502 = currentIndex_15;
            param_942 = _e502;
            let _e503 = rawValue_13;
            param_943 = _e503;
            let _e504 = currentDir_6;
            param_944 = _e504;
            let _e505 = currentSleep_7;
            param_945 = _e505;
            let _e506 = currentAge_10;
            param_946 = _e506;
            let _e507 = randVal_15;
            param_947 = _e507;
            updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_941), (&param_942), (&param_943), (&param_944), (&param_945), (&param_946), (&param_947));
            break;
        }
        case 4: {
            let _e508 = pos_21;
            param_948 = _e508;
            let _e509 = currentIndex_15;
            param_949 = _e509;
            let _e510 = rawValue_13;
            param_950 = _e510;
            let _e511 = currentDir_6;
            param_951 = _e511;
            let _e512 = currentSleep_7;
            param_952 = _e512;
            let _e513 = currentAge_10;
            param_953 = _e513;
            let _e514 = randVal_15;
            param_954 = _e514;
            updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_948), (&param_949), (&param_950), (&param_951), (&param_952), (&param_953), (&param_954));
            break;
        }
        case 5: {
            let _e515 = pos_21;
            param_955 = _e515;
            let _e516 = currentIndex_15;
            param_956 = _e516;
            let _e517 = rawValue_13;
            param_957 = _e517;
            let _e518 = currentDir_6;
            param_958 = _e518;
            let _e519 = currentSleep_7;
            param_959 = _e519;
            let _e520 = currentAge_10;
            param_960 = _e520;
            let _e521 = randVal_15;
            param_961 = _e521;
            updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_955), (&param_956), (&param_957), (&param_958), (&param_959), (&param_960), (&param_961));
            break;
        }
        case 6: {
            let _e522 = pos_21;
            param_962 = _e522;
            let _e523 = currentIndex_15;
            param_963 = _e523;
            let _e524 = rawValue_13;
            param_964 = _e524;
            let _e525 = currentSleep_7;
            param_965 = _e525;
            let _e526 = currentAge_10;
            param_966 = _e526;
            let _e527 = randVal_15;
            param_967 = _e527;
            updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_962), (&param_963), (&param_964), (&param_965), (&param_966), (&param_967));
            break;
        }
        case 9, 10, 11, 8: {
            let _e528 = pos_21;
            param_968 = _e528;
            let _e529 = currentIndex_15;
            param_969 = _e529;
            let _e530 = rawValue_13;
            param_970 = _e530;
            let _e531 = currentDir_6;
            param_971 = _e531;
            let _e532 = currentSleep_7;
            param_972 = _e532;
            let _e533 = currentAge_10;
            param_973 = _e533;
            let _e534 = randVal_15;
            param_974 = _e534;
            updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_968), (&param_969), (&param_970), (&param_971), (&param_972), (&param_973), (&param_974));
            break;
        }
        case 12: {
            let _e535 = pos_21;
            param_975 = _e535;
            let _e536 = currentIndex_15;
            param_976 = _e536;
            let _e537 = rawValue_13;
            param_977 = _e537;
            let _e538 = currentAge_10;
            param_978 = _e538;
            let _e539 = randVal_15;
            param_979 = _e539;
            updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_975), (&param_976), (&param_977), (&param_978), (&param_979));
            break;
        }
        case 14, 15, 16, 17, 13: {
            let _e540 = pos_21;
            param_980 = _e540;
            let _e541 = currentIndex_15;
            param_981 = _e541;
            let _e542 = rawValue_13;
            param_982 = _e542;
            let _e543 = currentDir_6;
            param_983 = _e543;
            let _e544 = currentSleep_7;
            param_984 = _e544;
            let _e545 = currentAge_10;
            param_985 = _e545;
            let _e546 = randVal_15;
            param_986 = _e546;
            updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_980), (&param_981), (&param_982), (&param_983), (&param_984), (&param_985), (&param_986));
            break;
        }
        case 18: {
            let _e547 = pos_21;
            param_987 = _e547;
            let _e548 = currentIndex_15;
            param_988 = _e548;
            let _e549 = rawValue_13;
            param_989 = _e549;
            let _e550 = currentDir_6;
            param_990 = _e550;
            let _e551 = currentAge_10;
            param_991 = _e551;
            let _e552 = randVal_15;
            param_992 = _e552;
            updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_987), (&param_988), (&param_989), (&param_990), (&param_991), (&param_992));
            break;
        }
        case 19: {
            let _e553 = pos_21;
            param_993 = _e553;
            let _e554 = currentIndex_15;
            param_994 = _e554;
            let _e555 = rawValue_13;
            param_995 = _e555;
            let _e556 = currentAge_10;
            param_996 = _e556;
            let _e557 = randVal_15;
            param_997 = _e557;
            updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_993), (&param_994), (&param_995), (&param_996), (&param_997));
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
