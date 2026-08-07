// GENERATED FILE -- DO NOT EDIT.
//
// Translated from falling_sand.comp by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit falling_sand.comp and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: db9fcef799fe499c11163de98183c325740f2a95035d36ee95c474ef3124a112

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
    cloudSmoothRate: f32,
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
    cloudMinYAcc: atomic<u32>,
    cloudMaxYAcc: atomic<u32>,
    cloudMinY: u32,
    cloudMaxY: u32,
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
    let _e201 = (*val);
    return ((_e201 >> bitcast<u32>(24i)) & 255u);
}

fn getDir_u0028_u1_u003b(val_1: ptr<function, u32>) -> u32 {
    let _e201 = (*val_1);
    return ((_e201 >> bitcast<u32>(8i)) & 255u);
}

fn getType_u0028_u1_u003b(val_2: ptr<function, u32>) -> u32 {
    let _e201 = (*val_2);
    return (_e201 & 255u);
}

fn tree26_u0028_i1_u003b(i: ptr<function, i32>) -> vec3<i32> {
    var j: i32;
    var local: i32;

    let _e203 = (*i);
    if (_e203 >= 13i) {
        let _e205 = (*i);
        local = (_e205 + 1i);
    } else {
        let _e207 = (*i);
        local = _e207;
    }
    let _e208 = local;
    j = _e208;
    let _e209 = j;
    let _e217 = j;
    let _e218 = (_e217 / 3i);
    let _e226 = j;
    return (vec3<i32>((_e209 - (i32(floor((f32(_e209) / f32(3i)))) * 3i)), (_e218 - (i32(floor((f32(_e218) / f32(3i)))) * 3i)), (_e226 / 9i)) - vec3<i32>(1i, 1i, 1i));
}

fn readCell_u0028_u1_u003b(index: ptr<function, u32>) -> u32 {
    let _e201 = (*index);
    let _e204 = atomicLoad((&unnamed.grid[_e201]));
    return _e204;
}

fn tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex: ptr<function, u32>, currentValue: ptr<function, u32>, targetIndex: ptr<function, u32>, newValue: ptr<function, u32>) -> bool {
    var targetValue: u32;
    var param: u32;
    var targetType: u32;
    var param_1: u32;
    var currentType: u32;
    var param_2: u32;
    var actual: u32;
    var phi_1685_: bool;
    var phi_1694_: bool;

    let _e211 = (*targetIndex);
    param = _e211;
    let _e212 = readCell_u0028_u1_u003b((&param));
    targetValue = _e212;
    let _e213 = targetValue;
    param_1 = _e213;
    let _e214 = getType_u0028_u1_u003b((&param_1));
    targetType = _e214;
    let _e215 = (*currentValue);
    param_2 = _e215;
    let _e216 = getType_u0028_u1_u003b((&param_2));
    currentType = _e216;
    let _e217 = targetType;
    let _e218 = (_e217 == 0u);
    phi_1685_ = _e218;
    if !(_e218) {
        let _e220 = currentType;
        let _e222 = currentType;
        let _e225 = targetType;
        phi_1685_ = (((_e220 == 1u) || (_e222 == 4u)) && (_e225 == 2u));
    }
    let _e229 = phi_1685_;
    phi_1694_ = _e229;
    if !(_e229) {
        let _e231 = currentType;
        let _e233 = targetType;
        phi_1694_ = ((_e231 == 6u) && (_e233 == 5u));
    }
    let _e237 = phi_1694_;
    if _e237 {
        let _e238 = (*currentIndex);
        let _e241 = (*currentValue);
        let _e242 = atomicCompareExchangeWeak((&unnamed.grid[_e238]), _e241, 0u);
        let _e244 = (*currentValue);
        if (_e242.old_value == _e244) {
            let _e246 = (*targetIndex);
            let _e249 = targetValue;
            let _e250 = (*newValue);
            let _e251 = atomicCompareExchangeWeak((&unnamed.grid[_e246]), _e249, _e250);
            actual = _e251.old_value;
            let _e253 = actual;
            let _e254 = targetValue;
            if (_e253 == _e254) {
                let _e256 = targetType;
                if (_e256 != 0u) {
                    let _e258 = (*currentIndex);
                    let _e261 = targetValue;
                    let _e262 = atomicExchange((&unnamed.grid[_e258]), _e261);
                }
                return true;
            } else {
                let _e263 = (*currentIndex);
                let _e266 = (*currentValue);
                let _e267 = atomicCompareExchangeWeak((&unnamed.grid[_e263]), 0u, _e266);
            }
        }
    }
    return false;
}

fn pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(type_33: ptr<function, u32>, dir: ptr<function, u32>, sleep: ptr<function, u32>, age: ptr<function, u32>) -> u32 {
    let _e204 = (*type_33);
    let _e206 = (*dir);
    let _e211 = (*sleep);
    let _e216 = (*age);
    return ((((_e204 & 255u) | ((_e206 & 255u) << bitcast<u32>(8i))) | ((_e211 & 255u) << bitcast<u32>(16i))) | ((_e216 & 255u) << bitcast<u32>(24i)));
}

fn getIndex_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    let _e202 = (*pos)[0u];
    let _e204 = (*pos)[1u];
    let _e206 = tuning.gridWidth;
    let _e211 = (*pos)[2u];
    let _e213 = tuning.gridWidth;
    let _e217 = tuning.gridHeight;
    return bitcast<u32>(((_e202 + (_e204 * bitcast<i32>(_e206))) + ((_e211 * bitcast<i32>(_e213)) * bitcast<i32>(_e217))));
}

fn treeInBounds_u0028_vi3_u003b(p: ptr<function, vec3<i32>>) -> bool {
    var phi_1177_: bool;
    var phi_1183_: bool;
    var phi_1193_: bool;
    var phi_1199_: bool;
    var phi_1209_: bool;

    let _e202 = (*p)[0u];
    let _e203 = (_e202 > 0i);
    phi_1177_ = _e203;
    if _e203 {
        let _e205 = (*p)[0u];
        let _e207 = tuning.gridWidth;
        phi_1177_ = (_e205 < (bitcast<i32>(_e207) - 1i));
    }
    let _e212 = phi_1177_;
    phi_1183_ = _e212;
    if _e212 {
        let _e214 = (*p)[1u];
        phi_1183_ = (_e214 > 0i);
    }
    let _e217 = phi_1183_;
    phi_1193_ = _e217;
    if _e217 {
        let _e219 = (*p)[1u];
        let _e221 = tuning.gridHeight;
        phi_1193_ = (_e219 < (bitcast<i32>(_e221) - 1i));
    }
    let _e226 = phi_1193_;
    phi_1199_ = _e226;
    if _e226 {
        let _e228 = (*p)[2u];
        phi_1199_ = (_e228 > 0i);
    }
    let _e231 = phi_1199_;
    phi_1209_ = _e231;
    if _e231 {
        let _e233 = (*p)[2u];
        let _e235 = tuning.gridDepth;
        phi_1209_ = (_e233 < (bitcast<i32>(_e235) - 1i));
    }
    let _e240 = phi_1209_;
    return _e240;
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
    var phi_6793_: bool;
    var phi_6877_: bool;
    var phi_6959_: bool;

    let _e251 = (*randVal);
    let _e255 = tuning.treeLeafTickChance;
    if (fract((_e251 * 7f)) >= _e255) {
        return;
    }
    let _e257 = (*currentAge);
    if (_e257 == 255u) {
        let _e259 = (*pos_1);
        belowPos = (_e259 + vec3<i32>(0i, -1i, 0i));
        let _e261 = belowPos;
        param_3 = _e261;
        let _e262 = treeInBounds_u0028_vi3_u003b((&param_3));
        phi_6793_ = _e262;
        if _e262 {
            let _e263 = belowPos;
            param_4 = _e263;
            let _e264 = getIndex_u0028_vi3_u003b((&param_4));
            param_5 = _e264;
            let _e265 = readCell_u0028_u1_u003b((&param_5));
            phi_6793_ = (_e265 == 0u);
        }
        let _e268 = phi_6793_;
        if _e268 {
            let _e269 = belowPos;
            param_6 = _e269;
            let _e270 = getIndex_u0028_vi3_u003b((&param_6));
            param_7 = 19u;
            param_8 = 0u;
            param_9 = 0u;
            param_10 = 255u;
            let _e271 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_7), (&param_8), (&param_9), (&param_10));
            let _e272 = (*currentIndex_1);
            param_11 = _e272;
            let _e273 = (*rawValue);
            param_12 = _e273;
            param_13 = _e270;
            param_14 = _e271;
            let _e274 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_11), (&param_12), (&param_13), (&param_14));
            if _e274 {
                return;
            }
        }
        let _e275 = (*currentIndex_1);
        let _e278 = (*rawValue);
        let _e279 = atomicCompareExchangeWeak((&unnamed.grid[_e275]), _e278, 0u);
        return;
    }
    let _e281 = (*currentAge);
    dist = _e281;
    nearest = 255u;
    touchesTrunk = false;
    let _e282 = (*randVal);
    start = i32((fract((_e282 * 71f)) * 26f));
    haveSpot = false;
    let _e287 = (*pos_1);
    spot = _e287;
    i_1 = 0i;
    loop {
        let _e288 = i_1;
        if (_e288 < 26i) {
            let _e290 = (*pos_1);
            let _e291 = start;
            let _e292 = i_1;
            let _e293 = (_e291 + _e292);
            param_15 = (_e293 - (i32(floor((f32(_e293) / f32(26i)))) * 26i));
            let _e301 = tree26_u0028_i1_u003b((&param_15));
            c = (_e290 + _e301);
            let _e303 = c;
            param_16 = _e303;
            let _e304 = treeInBounds_u0028_vi3_u003b((&param_16));
            if !(_e304) {
                continue;
            }
            let _e306 = c;
            param_17 = _e306;
            let _e307 = getIndex_u0028_vi3_u003b((&param_17));
            param_18 = _e307;
            let _e308 = readCell_u0028_u1_u003b((&param_18));
            v = _e308;
            let _e309 = v;
            param_19 = _e309;
            let _e310 = getType_u0028_u1_u003b((&param_19));
            t = _e310;
            let _e311 = t;
            let _e312 = (_e311 == 18u);
            phi_6877_ = _e312;
            if _e312 {
                let _e313 = v;
                param_20 = _e313;
                let _e314 = getDir_u0028_u1_u003b((&param_20));
                let _e317 = tuning.treeMaxHeight;
                phi_6877_ = ((_e314 + 1u) >= _e317);
            }
            let _e320 = phi_6877_;
            if _e320 {
                touchesTrunk = true;
            } else {
                let _e321 = t;
                if (_e321 == 19u) {
                    let _e323 = nearest;
                    let _e324 = v;
                    param_21 = _e324;
                    let _e325 = getAge_u0028_u1_u003b((&param_21));
                    nearest = min(_e323, _e325);
                } else {
                    let _e327 = v;
                    let _e329 = haveSpot;
                    if ((_e327 == 0u) && !(_e329)) {
                        haveSpot = true;
                        let _e332 = c;
                        spot = _e332;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e333 = i_1;
            i_1 = (_e333 + 1i);
        }
    }
    let _e335 = touchesTrunk;
    if _e335 {
        local_1 = 1u;
    } else {
        let _e336 = nearest;
        if (_e336 >= 255u) {
            local_2 = 255u;
        } else {
            let _e338 = nearest;
            local_2 = (_e338 + 1u);
        }
        let _e340 = local_2;
        local_1 = _e340;
    }
    let _e341 = local_1;
    supported = _e341;
    let _e342 = supported;
    let _e344 = tuning.treeLeafReach;
    if (_e342 > _e344) {
        let _e346 = (*randVal);
        let _e350 = tuning.treeLeafFallChance;
        if (fract((_e346 * 83f)) < _e350) {
            let _e352 = (*currentIndex_1);
            let _e355 = (*rawValue);
            param_22 = 19u;
            param_23 = 0u;
            param_24 = 0u;
            param_25 = 255u;
            let _e356 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_22), (&param_23), (&param_24), (&param_25));
            let _e357 = atomicCompareExchangeWeak((&unnamed.grid[_e352]), _e355, _e356);
        }
        return;
    }
    let _e359 = supported;
    let _e361 = tuning.treeLeafReach;
    let _e363 = haveSpot;
    let _e364 = ((_e359 < _e361) && _e363);
    phi_6959_ = _e364;
    if _e364 {
        let _e365 = (*randVal);
        let _e369 = tuning.treeLeafSpreadChance;
        phi_6959_ = (fract((_e365 * 89f)) < _e369);
    }
    let _e372 = phi_6959_;
    if _e372 {
        let _e373 = spot;
        param_26 = _e373;
        let _e374 = getIndex_u0028_vi3_u003b((&param_26));
        let _e377 = supported;
        param_27 = 19u;
        param_28 = 0u;
        param_29 = 0u;
        param_30 = (_e377 + 1u);
        let _e379 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_27), (&param_28), (&param_29), (&param_30));
        let _e380 = atomicCompareExchangeWeak((&unnamed.grid[_e374]), 0u, _e379);
    }
    let _e382 = supported;
    let _e383 = dist;
    if (_e382 != _e383) {
        let _e385 = (*currentIndex_1);
        let _e388 = (*rawValue);
        param_31 = 19u;
        param_32 = 0u;
        param_33 = 0u;
        let _e389 = supported;
        param_34 = _e389;
        let _e390 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_31), (&param_32), (&param_33), (&param_34));
        let _e391 = atomicCompareExchangeWeak((&unnamed.grid[_e385]), _e388, _e390);
    }
    return;
}

fn isGrassBlock_u0028_u1_u003b(value: ptr<function, u32>) -> bool {
    var flora: u32;
    var param_35: u32;

    let _e203 = (*value);
    flora = ((_e203 >> bitcast<u32>(8i)) & 255u);
    let _e207 = (*value);
    param_35 = _e207;
    let _e208 = getType_u0028_u1_u003b((&param_35));
    let _e210 = flora;
    let _e213 = flora;
    return (((_e208 == 4u) && (_e210 > 10u)) && (_e213 <= 100u));
}

fn getSleep_u0028_u1_u003b(val_3: ptr<function, u32>) -> u32 {
    let _e201 = (*val_3);
    return ((_e201 >> bitcast<u32>(16i)) & 255u);
}

fn getHDir_u0028_i1_u003b(d: ptr<function, i32>) -> vec3<i32> {
    let _e201 = (*d);
    if (_e201 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e203 = (*d);
    if (_e203 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e205 = (*d);
    if (_e205 == 2i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    let _e207 = (*d);
    if (_e207 == 3i) {
        return vec3<i32>(0i, 0i, -1i);
    }
    let _e209 = (*d);
    if (_e209 == 4i) {
        return vec3<i32>(1i, 0i, 1i);
    }
    let _e211 = (*d);
    if (_e211 == 5i) {
        return vec3<i32>(1i, 0i, -1i);
    }
    let _e213 = (*d);
    if (_e213 == 6i) {
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
    var phi_6347_: bool;
    var phi_6491_: bool;
    var phi_6501_: bool;
    var phi_6546_: bool;
    var phi_6597_: bool;
    var phi_6676_: bool;

    let _e286 = (*currentDir);
    height = _e286;
    let _e287 = (*currentAge_1);
    water = _e287;
    changed = false;
    let _e288 = water;
    let _e290 = tuning.treeWaterMax;
    let _e291 = (_e288 < _e290);
    phi_6347_ = _e291;
    if _e291 {
        let _e292 = (*randVal_1);
        let _e296 = tuning.treeDrinkChance;
        phi_6347_ = (fract((_e292 * 13f)) < _e296);
    }
    let _e299 = phi_6347_;
    if _e299 {
        let _e300 = (*randVal_1);
        start_1 = i32((fract((_e300 * 101f)) * 17f));
        k = 0i;
        loop {
            let _e305 = k;
            if (_e305 < 17i) {
                let _e307 = start_1;
                let _e308 = k;
                let _e309 = (_e307 + _e308);
                i_2 = (_e309 - (i32(floor((f32(_e309) / f32(17i)))) * 17i));
                let _e317 = i_2;
                if (_e317 == 0i) {
                    let _e319 = (*pos_2);
                    local_3 = (_e319 + vec3<i32>(0i, -1i, 0i));
                } else {
                    let _e321 = i_2;
                    if (_e321 < 9i) {
                        let _e323 = (*pos_2);
                        let _e324 = i_2;
                        param_36 = (_e324 - 1i);
                        let _e326 = getHDir_u0028_i1_u003b((&param_36));
                        local_4 = ((_e323 + _e326) + vec3<i32>(0i, -1i, 0i));
                    } else {
                        let _e329 = (*pos_2);
                        let _e330 = i_2;
                        param_37 = (_e330 - 9i);
                        let _e332 = getHDir_u0028_i1_u003b((&param_37));
                        local_4 = (_e329 + _e332);
                    }
                    let _e334 = local_4;
                    local_3 = _e334;
                }
                let _e335 = local_3;
                c_1 = _e335;
                let _e336 = c_1;
                param_38 = _e336;
                let _e337 = treeInBounds_u0028_vi3_u003b((&param_38));
                if !(_e337) {
                    continue;
                }
                let _e339 = c_1;
                param_39 = _e339;
                let _e340 = getIndex_u0028_vi3_u003b((&param_39));
                idx = _e340;
                let _e341 = idx;
                param_40 = _e341;
                let _e342 = readCell_u0028_u1_u003b((&param_40));
                v_1 = _e342;
                let _e343 = v_1;
                param_41 = _e343;
                let _e344 = getType_u0028_u1_u003b((&param_41));
                if (_e344 != 4u) {
                    continue;
                }
                let _e346 = v_1;
                param_42 = _e346;
                let _e347 = getAge_u0028_u1_u003b((&param_42));
                moisture = _e347;
                let _e348 = moisture;
                let _e350 = tuning.treeSoilReserve;
                if (_e348 <= _e350) {
                    continue;
                }
                let _e352 = idx;
                let _e355 = v_1;
                let _e356 = v_1;
                param_43 = _e356;
                let _e357 = getDir_u0028_u1_u003b((&param_43));
                let _e358 = v_1;
                param_44 = _e358;
                let _e359 = getSleep_u0028_u1_u003b((&param_44));
                let _e360 = moisture;
                param_45 = 4u;
                param_46 = _e357;
                param_47 = _e359;
                param_48 = (_e360 - 1u);
                let _e362 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_45), (&param_46), (&param_47), (&param_48));
                let _e363 = atomicCompareExchangeWeak((&unnamed.grid[_e352]), _e355, _e362);
                let _e365 = v_1;
                if (_e363.old_value == _e365) {
                    let _e367 = water;
                    water = (_e367 + 1u);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e369 = k;
                k = (_e369 + 1i);
            }
        }
    }
    let _e371 = (*pos_2);
    upPos = (_e371 + vec3<i32>(0i, 1i, 0i));
    upIsTrunk = false;
    upValue = 0u;
    upIndex = 0u;
    let _e373 = upPos;
    param_49 = _e373;
    let _e374 = treeInBounds_u0028_vi3_u003b((&param_49));
    if _e374 {
        let _e375 = upPos;
        param_50 = _e375;
        let _e376 = getIndex_u0028_vi3_u003b((&param_50));
        upIndex = _e376;
        let _e377 = upIndex;
        param_51 = _e377;
        let _e378 = readCell_u0028_u1_u003b((&param_51));
        upValue = _e378;
        let _e379 = upValue;
        param_52 = _e379;
        let _e380 = getType_u0028_u1_u003b((&param_52));
        upIsTrunk = (_e380 == 18u);
    }
    let _e382 = upIsTrunk;
    let _e383 = water;
    let _e385 = (_e382 && (_e383 > 0u));
    phi_6491_ = _e385;
    if _e385 {
        let _e386 = upValue;
        param_53 = _e386;
        let _e387 = getAge_u0028_u1_u003b((&param_53));
        phi_6491_ = (_e387 < 255u);
    }
    let _e390 = phi_6491_;
    phi_6501_ = _e390;
    if _e390 {
        let _e391 = (*randVal_1);
        let _e395 = tuning.treeFlowChance;
        phi_6501_ = (fract((_e391 * 29f)) < _e395);
    }
    let _e398 = phi_6501_;
    if _e398 {
        let _e399 = upValue;
        param_54 = _e399;
        let _e400 = getDir_u0028_u1_u003b((&param_54));
        let _e401 = upValue;
        param_55 = _e401;
        let _e402 = getAge_u0028_u1_u003b((&param_55));
        param_56 = 18u;
        param_57 = _e400;
        param_58 = 0u;
        param_59 = (_e402 + 1u);
        let _e404 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_56), (&param_57), (&param_58), (&param_59));
        lifted = _e404;
        let _e405 = upIndex;
        let _e408 = upValue;
        let _e409 = lifted;
        let _e410 = atomicCompareExchangeWeak((&unnamed.grid[_e405]), _e408, _e409);
        let _e412 = upValue;
        if (_e410.old_value == _e412) {
            let _e414 = water;
            water = (_e414 - 1u);
            changed = true;
        }
    }
    let _e416 = height;
    let _e419 = tuning.treeMaxHeight;
    if ((_e416 + 1u) < _e419) {
        let _e421 = water;
        let _e423 = tuning.treeGrowCost;
        let _e424 = (_e421 >= _e423);
        phi_6546_ = _e424;
        if _e424 {
            let _e425 = upPos;
            param_60 = _e425;
            let _e426 = treeInBounds_u0028_vi3_u003b((&param_60));
            phi_6546_ = _e426;
        }
        let _e428 = phi_6546_;
        if _e428 {
            let _e429 = upValue;
            param_61 = _e429;
            let _e430 = getType_u0028_u1_u003b((&param_61));
            upType = _e430;
            let _e431 = upType;
            let _e433 = upType;
            if ((_e431 == 0u) || (_e433 == 19u)) {
                let _e436 = height;
                param_62 = 18u;
                param_63 = (_e436 + 1u);
                param_64 = 0u;
                param_65 = 0u;
                let _e438 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_62), (&param_63), (&param_64), (&param_65));
                sapling = _e438;
                let _e439 = upIndex;
                let _e442 = upValue;
                let _e443 = sapling;
                let _e444 = atomicCompareExchangeWeak((&unnamed.grid[_e439]), _e442, _e443);
                let _e446 = upValue;
                if (_e444.old_value == _e446) {
                    let _e449 = tuning.treeGrowCost;
                    let _e450 = water;
                    water = (_e450 - _e449);
                    changed = true;
                }
            }
        }
    } else {
        let _e452 = water;
        let _e454 = tuning.treeLeafCost;
        let _e455 = (_e452 >= _e454);
        phi_6597_ = _e455;
        if _e455 {
            let _e456 = (*randVal_1);
            let _e460 = tuning.treeLeafChance;
            phi_6597_ = (fract((_e456 * 37f)) < _e460);
        }
        let _e463 = phi_6597_;
        if _e463 {
            let _e464 = (*randVal_1);
            start_2 = i32((fract((_e464 * 43f)) * 26f));
            i_3 = 0i;
            loop {
                let _e469 = i_3;
                if (_e469 < 26i) {
                    let _e471 = (*pos_2);
                    let _e472 = start_2;
                    let _e473 = i_3;
                    let _e474 = (_e472 + _e473);
                    param_66 = (_e474 - (i32(floor((f32(_e474) / f32(26i)))) * 26i));
                    let _e482 = tree26_u0028_i1_u003b((&param_66));
                    c_2 = (_e471 + _e482);
                    let _e484 = c_2;
                    param_67 = _e484;
                    let _e485 = treeInBounds_u0028_vi3_u003b((&param_67));
                    if !(_e485) {
                        continue;
                    }
                    let _e487 = c_2;
                    param_68 = _e487;
                    let _e488 = getIndex_u0028_vi3_u003b((&param_68));
                    idx_1 = _e488;
                    let _e489 = idx_1;
                    param_69 = _e489;
                    let _e490 = readCell_u0028_u1_u003b((&param_69));
                    if (_e490 != 0u) {
                        continue;
                    }
                    let _e492 = idx_1;
                    param_70 = 19u;
                    param_71 = 0u;
                    param_72 = 0u;
                    param_73 = 1u;
                    let _e495 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_70), (&param_71), (&param_72), (&param_73));
                    let _e496 = atomicCompareExchangeWeak((&unnamed.grid[_e492]), 0u, _e495);
                    if (_e496.old_value == 0u) {
                        let _e500 = tuning.treeLeafCost;
                        let _e501 = water;
                        water = (_e501 - _e500);
                        changed = true;
                        break;
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e503 = i_3;
                    i_3 = (_e503 + 1i);
                }
            }
        }
    }
    let _e505 = water;
    let _e507 = tuning.treeSpreadCost;
    let _e508 = (_e505 >= _e507);
    phi_6676_ = _e508;
    if _e508 {
        let _e509 = (*randVal_1);
        let _e513 = tuning.treeSpreadChance;
        phi_6676_ = (fract((_e509 * 59f)) < _e513);
    }
    let _e516 = phi_6676_;
    if _e516 {
        let _e517 = (*randVal_1);
        start_3 = i32((fract((_e517 * 61f)) * 8f));
        i_4 = 0i;
        loop {
            let _e522 = i_4;
            if (_e522 < 8i) {
                let _e524 = (*pos_2);
                let _e525 = start_3;
                let _e526 = i_4;
                let _e527 = (_e525 + _e526);
                param_74 = (_e527 - (i32(floor((f32(_e527) / f32(8i)))) * 8i));
                let _e535 = getHDir_u0028_i1_u003b((&param_74));
                c_3 = (_e524 + _e535);
                let _e537 = c_3;
                param_75 = _e537;
                let _e538 = treeInBounds_u0028_vi3_u003b((&param_75));
                if !(_e538) {
                    continue;
                }
                let _e540 = c_3;
                param_76 = _e540;
                let _e541 = getIndex_u0028_vi3_u003b((&param_76));
                idx_2 = _e541;
                let _e542 = idx_2;
                param_77 = _e542;
                let _e543 = readCell_u0028_u1_u003b((&param_77));
                if (_e543 != 0u) {
                    continue;
                }
                let _e545 = c_3;
                param_78 = (_e545 + vec3<i32>(0i, -1i, 0i));
                let _e547 = getIndex_u0028_vi3_u003b((&param_78));
                param_79 = _e547;
                let _e548 = readCell_u0028_u1_u003b((&param_79));
                param_80 = _e548;
                let _e549 = isGrassBlock_u0028_u1_u003b((&param_80));
                if !(_e549) {
                    continue;
                }
                let _e551 = idx_2;
                param_81 = 18u;
                param_82 = 0u;
                param_83 = 0u;
                param_84 = 0u;
                let _e554 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_81), (&param_82), (&param_83), (&param_84));
                let _e555 = atomicCompareExchangeWeak((&unnamed.grid[_e551]), 0u, _e554);
                if (_e555.old_value == 0u) {
                    let _e559 = tuning.treeSpreadCost;
                    let _e560 = water;
                    water = (_e560 - _e559);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e562 = i_4;
                i_4 = (_e562 + 1i);
            }
        }
    }
    let _e564 = changed;
    if _e564 {
        let _e565 = (*currentIndex_2);
        let _e568 = (*rawValue_1);
        param_85 = 18u;
        let _e569 = height;
        param_86 = _e569;
        param_87 = 0u;
        let _e570 = water;
        param_88 = _e570;
        let _e571 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_85), (&param_86), (&param_87), (&param_88));
        let _e572 = atomicCompareExchangeWeak((&unnamed.grid[_e565]), _e568, _e571);
    }
    return;
}

fn locustPackNav_u0028_u1_u003b_u1_u003b(heading: ptr<function, u32>, steps: ptr<function, u32>) -> u32 {
    let _e202 = (*heading);
    let _e204 = (*steps);
    return ((_e202 & 7u) | (min(_e204, 7u) << bitcast<u32>(3i)));
}

fn locustReverse_u0028_u1_u003b(d_1: ptr<function, u32>) -> u32 {
    let _e201 = (*d_1);
    if (_e201 == 0u) {
        return 1u;
    }
    let _e203 = (*d_1);
    if (_e203 == 1u) {
        return 0u;
    }
    let _e205 = (*d_1);
    if (_e205 == 2u) {
        return 3u;
    }
    let _e207 = (*d_1);
    if (_e207 == 3u) {
        return 2u;
    }
    let _e209 = (*d_1);
    if (_e209 == 4u) {
        return 7u;
    }
    let _e211 = (*d_1);
    if (_e211 == 5u) {
        return 6u;
    }
    let _e213 = (*d_1);
    if (_e213 == 6u) {
        return 5u;
    }
    return 4u;
}

fn locustRunSteps_u0028_() -> u32 {
    let _e201 = tuning.locustRunLength;
    return clamp(_e201, 1u, 7u);
}

fn isLocustFood_u0028_u1_u003b(value_1: ptr<function, u32>) -> bool {
    var param_89: u32;
    var param_90: u32;
    var phi_970_: bool;

    let _e203 = (*value_1);
    param_89 = _e203;
    let _e204 = isGrassBlock_u0028_u1_u003b((&param_89));
    phi_970_ = _e204;
    if !(_e204) {
        let _e206 = (*value_1);
        param_90 = _e206;
        let _e207 = getType_u0028_u1_u003b((&param_90));
        phi_970_ = (_e207 == 19u);
    }
    let _e210 = phi_970_;
    return _e210;
}

fn locustFoodAt_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> bool {
    var param_91: vec3<i32>;
    var param_92: u32;
    var param_93: u32;
    var phi_985_: bool;
    var phi_992_: bool;
    var phi_1002_: bool;
    var phi_1009_: bool;
    var phi_1019_: bool;

    let _e205 = (*p_1)[0u];
    let _e206 = (_e205 < 0i);
    phi_985_ = _e206;
    if !(_e206) {
        let _e209 = (*p_1)[0u];
        let _e211 = tuning.gridWidth;
        phi_985_ = (_e209 >= bitcast<i32>(_e211));
    }
    let _e215 = phi_985_;
    phi_992_ = _e215;
    if !(_e215) {
        let _e218 = (*p_1)[1u];
        phi_992_ = (_e218 < 0i);
    }
    let _e221 = phi_992_;
    phi_1002_ = _e221;
    if !(_e221) {
        let _e224 = (*p_1)[1u];
        let _e226 = tuning.gridHeight;
        phi_1002_ = (_e224 >= bitcast<i32>(_e226));
    }
    let _e230 = phi_1002_;
    phi_1009_ = _e230;
    if !(_e230) {
        let _e233 = (*p_1)[2u];
        phi_1009_ = (_e233 < 0i);
    }
    let _e236 = phi_1009_;
    phi_1019_ = _e236;
    if !(_e236) {
        let _e239 = (*p_1)[2u];
        let _e241 = tuning.gridDepth;
        phi_1019_ = (_e239 >= bitcast<i32>(_e241));
    }
    let _e245 = phi_1019_;
    if _e245 {
        return false;
    }
    let _e246 = (*p_1);
    param_91 = _e246;
    let _e247 = getIndex_u0028_vi3_u003b((&param_91));
    param_92 = _e247;
    let _e248 = readCell_u0028_u1_u003b((&param_92));
    param_93 = _e248;
    let _e249 = isLocustFood_u0028_u1_u003b((&param_93));
    return _e249;
}

fn locustSteps_u0028_u1_u003b(dirByte: ptr<function, u32>) -> u32 {
    let _e201 = (*dirByte);
    return ((_e201 >> bitcast<u32>(3i)) & 7u);
}

fn locustHeading_u0028_u1_u003b(dirByte_1: ptr<function, u32>) -> u32 {
    let _e201 = (*dirByte_1);
    return (_e201 & 7u);
}

fn locustArriveDir_u0028_vi3_u003b_u1_u003b(dest: ptr<function, vec3<i32>>, nav: ptr<function, u32>) -> u32 {
    var param_94: vec3<i32>;

    let _e203 = (*dest);
    param_94 = (_e203 + vec3<i32>(0i, -1i, 0i));
    let _e205 = locustFoodAt_u0028_vi3_u003b((&param_94));
    let _e206 = (*nav);
    return select(_e206, 0u, _e205);
}

fn locustHasGrip_u0028_vi3_u003b(pos_3: ptr<function, vec3<i32>>) -> bool {
    var d_2: i32;
    var n: vec3<i32>;
    var param_95: i32;
    var param_96: vec3<i32>;
    var param_97: u32;
    var phi_1122_: bool;
    var phi_1129_: bool;
    var phi_1140_: bool;

    d_2 = 0i;
    loop {
        let _e206 = d_2;
        if (_e206 < 8i) {
            let _e208 = (*pos_3);
            let _e209 = d_2;
            param_95 = _e209;
            let _e210 = getHDir_u0028_i1_u003b((&param_95));
            n = (_e208 + _e210);
            let _e213 = n[0u];
            let _e214 = (_e213 <= 0i);
            phi_1122_ = _e214;
            if !(_e214) {
                let _e217 = n[0u];
                let _e219 = tuning.gridWidth;
                phi_1122_ = (_e217 >= (bitcast<i32>(_e219) - 1i));
            }
            let _e224 = phi_1122_;
            phi_1129_ = _e224;
            if !(_e224) {
                let _e227 = n[2u];
                phi_1129_ = (_e227 <= 0i);
            }
            let _e230 = phi_1129_;
            phi_1140_ = _e230;
            if !(_e230) {
                let _e233 = n[2u];
                let _e235 = tuning.gridDepth;
                phi_1140_ = (_e233 >= (bitcast<i32>(_e235) - 1i));
            }
            let _e240 = phi_1140_;
            if _e240 {
                continue;
            }
            let _e241 = n;
            param_96 = _e241;
            let _e242 = getIndex_u0028_vi3_u003b((&param_96));
            param_97 = _e242;
            let _e243 = readCell_u0028_u1_u003b((&param_97));
            if (_e243 != 0u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e245 = d_2;
            d_2 = (_e245 + 1i);
        }
    }
    return false;
}

fn locustInBounds_u0028_vi3_u003b(p_2: ptr<function, vec3<i32>>) -> bool {
    var phi_906_: bool;
    var phi_912_: bool;
    var phi_922_: bool;
    var phi_928_: bool;
    var phi_938_: bool;

    let _e202 = (*p_2)[0u];
    let _e203 = (_e202 > 0i);
    phi_906_ = _e203;
    if _e203 {
        let _e205 = (*p_2)[0u];
        let _e207 = tuning.gridWidth;
        phi_906_ = (_e205 < (bitcast<i32>(_e207) - 1i));
    }
    let _e212 = phi_906_;
    phi_912_ = _e212;
    if _e212 {
        let _e214 = (*p_2)[1u];
        phi_912_ = (_e214 > 0i);
    }
    let _e217 = phi_912_;
    phi_922_ = _e217;
    if _e217 {
        let _e219 = (*p_2)[1u];
        let _e221 = tuning.gridHeight;
        phi_922_ = (_e219 < (bitcast<i32>(_e221) - 1i));
    }
    let _e226 = phi_922_;
    phi_928_ = _e226;
    if _e226 {
        let _e228 = (*p_2)[2u];
        phi_928_ = (_e228 > 0i);
    }
    let _e231 = phi_928_;
    phi_938_ = _e231;
    if _e231 {
        let _e233 = (*p_2)[2u];
        let _e235 = tuning.gridDepth;
        phi_938_ = (_e233 < (bitcast<i32>(_e235) - 1i));
    }
    let _e240 = phi_938_;
    return _e240;
}

fn locustStage_u0028_() -> u32 {
    let _e201 = tuning.locustStageSize;
    return max(_e201, 1u);
}

fn locustTypeFor_u0028_u1_u003b(count: ptr<function, u32>) -> u32 {
    var stage: u32;
    var local_5: u32;

    let _e203 = (*count);
    if (_e203 == 0u) {
        local_5 = 0u;
    } else {
        let _e205 = (*count);
        let _e207 = locustStage_u0028_();
        local_5 = ((_e205 - 1u) / _e207);
    }
    let _e209 = local_5;
    stage = _e209;
    let _e210 = stage;
    return (13u + min(_e210, 4u));
}

fn locustMaxCount_u0028_() -> u32 {
    let _e201 = tuning.locustMaxSize;
    return max(_e201, 1u);
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

    let _e218 = tuning.locustBudSize;
    let _e219 = locustMaxCount_u0028_();
    bud = clamp(_e218, 1u, _e219);
    let _e221 = (*randVal_2);
    start_4 = i32((fract((_e221 * 31f)) * 8f));
    i_5 = 0i;
    loop {
        let _e226 = i_5;
        if (_e226 < 8i) {
            let _e228 = start_4;
            let _e229 = i_5;
            let _e230 = (_e228 + _e229);
            d_3 = (_e230 - (i32(floor((f32(_e230) / f32(8i)))) * 8i));
            let _e238 = (*pos_4);
            let _e239 = d_3;
            param_98 = _e239;
            let _e240 = getHDir_u0028_i1_u003b((&param_98));
            c_4 = (_e238 + _e240);
            let _e242 = c_4;
            param_99 = _e242;
            let _e243 = locustInBounds_u0028_vi3_u003b((&param_99));
            if !(_e243) {
                continue;
            }
            let _e245 = c_4;
            param_100 = _e245;
            let _e246 = getIndex_u0028_vi3_u003b((&param_100));
            idx_3 = _e246;
            let _e247 = idx_3;
            param_101 = _e247;
            let _e248 = readCell_u0028_u1_u003b((&param_101));
            if (_e248 != 0u) {
                continue;
            }
            let _e250 = idx_3;
            let _e253 = bud;
            param_102 = _e253;
            let _e254 = locustTypeFor_u0028_u1_u003b((&param_102));
            param_103 = _e254;
            param_104 = 0u;
            param_105 = 0u;
            let _e255 = bud;
            param_106 = _e255;
            let _e256 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_103), (&param_104), (&param_105), (&param_106));
            let _e257 = atomicCompareExchangeWeak((&unnamed.grid[_e250]), 0u, _e256);
            if (_e257.old_value == 0u) {
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e260 = i_5;
            i_5 = (_e260 + 1i);
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

    let _e207 = tuning.locustEatTicksMin;
    fast = _e207;
    let _e209 = tuning.locustEatTicksMax;
    slow = _e209;
    let _e210 = locustMaxCount_u0028_();
    cap = _e210;
    let _e211 = locustStage_u0028_();
    let _e212 = cap;
    floorCount = min(_e211, _e212);
    let _e214 = (*count_1);
    let _e215 = cap;
    if (_e214 >= _e215) {
        let _e217 = fast;
        return _e217;
    }
    let _e218 = (*count_1);
    let _e219 = floorCount;
    let _e221 = cap;
    let _e222 = floorCount;
    if ((_e218 <= _e219) || (_e221 == _e222)) {
        let _e225 = slow;
        return _e225;
    }
    let _e226 = (*count_1);
    let _e227 = floorCount;
    let _e230 = cap;
    let _e231 = floorCount;
    t_1 = (f32((_e226 - _e227)) / f32((_e230 - _e231)));
    let _e235 = slow;
    let _e237 = fast;
    let _e239 = t_1;
    return u32(round(mix(f32(_e235), f32(_e237), _e239)));
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
    var phi_7258_: bool;
    var phi_7265_: bool;
    var phi_7426_: bool;
    var phi_7445_: bool;
    var phi_7474_: bool;
    var phi_7488_: bool;
    var phi_7490_: bool;
    var phi_7582_: bool;
    var phi_7631_: bool;

    let _e384 = (*rawValue_2);
    param_107 = _e384;
    let _e385 = getType_u0028_u1_u003b((&param_107));
    type_34 = _e385;
    let _e386 = (*currentSleep);
    phase = (_e386 + 1u);
    let _e388 = phase;
    let _e390 = tuning.locustTickDispatches;
    if (_e388 < _e390) {
        let _e392 = (*currentIndex_3);
        let _e395 = (*rawValue_2);
        let _e396 = type_34;
        param_108 = _e396;
        let _e397 = (*currentDir_1);
        param_109 = _e397;
        let _e398 = phase;
        param_110 = _e398;
        let _e399 = (*currentAge_2);
        param_111 = _e399;
        let _e400 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_108), (&param_109), (&param_110), (&param_111));
        let _e401 = atomicCompareExchangeWeak((&unnamed.grid[_e392]), _e395, _e400);
        return;
    }
    let _e403 = (*currentAge_2);
    count_2 = _e403;
    let _e404 = (*pos_5);
    belowPos_1 = (_e404 + vec3<i32>(0i, -1i, 0i));
    let _e406 = belowPos_1;
    param_112 = _e406;
    let _e407 = getIndex_u0028_vi3_u003b((&param_112));
    belowIndex = _e407;
    let _e408 = belowIndex;
    param_113 = _e408;
    let _e409 = readCell_u0028_u1_u003b((&param_113));
    belowValue = _e409;
    let _e410 = belowValue;
    param_114 = _e410;
    let _e411 = isLocustFood_u0028_u1_u003b((&param_114));
    if _e411 {
        let _e412 = belowValue;
        param_115 = _e412;
        let _e413 = getType_u0028_u1_u003b((&param_115));
        onLeaf = (_e413 == 19u);
        let _e415 = count_2;
        param_116 = _e415;
        let _e416 = locustEatTicks_u0028_u1_u003b((&param_116));
        need = _e416;
        let _e417 = (*currentDir_1);
        progress = (_e417 + 1u);
        let _e419 = progress;
        let _e420 = need;
        if (_e419 < _e420) {
            let _e422 = onLeaf;
            if !(_e422) {
                let _e424 = belowValue;
                flora_1 = ((_e424 >> bitcast<u32>(8i)) & 255u);
                let _e428 = need;
                bite = max((90u / max(_e428, 1u)), 1u);
                let _e432 = flora_1;
                let _e433 = bite;
                if (_e432 > (11u + _e433)) {
                    let _e436 = flora_1;
                    let _e437 = bite;
                    local_6 = (_e436 - _e437);
                } else {
                    local_6 = 11u;
                }
                let _e439 = local_6;
                thinned = _e439;
                let _e440 = belowIndex;
                let _e443 = belowValue;
                let _e444 = belowValue;
                param_117 = _e444;
                let _e445 = getSleep_u0028_u1_u003b((&param_117));
                let _e446 = belowValue;
                param_118 = _e446;
                let _e447 = getAge_u0028_u1_u003b((&param_118));
                param_119 = 4u;
                let _e448 = thinned;
                param_120 = _e448;
                param_121 = _e445;
                param_122 = _e447;
                let _e449 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_119), (&param_120), (&param_121), (&param_122));
                let _e450 = atomicCompareExchangeWeak((&unnamed.grid[_e440]), _e443, _e449);
            }
            let _e452 = (*currentIndex_3);
            let _e455 = (*rawValue_2);
            let _e456 = type_34;
            param_123 = _e456;
            let _e457 = progress;
            param_124 = _e457;
            param_125 = 0u;
            let _e458 = count_2;
            param_126 = _e458;
            let _e459 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_123), (&param_124), (&param_125), (&param_126));
            let _e460 = atomicCompareExchangeWeak((&unnamed.grid[_e452]), _e455, _e459);
            return;
        }
        let _e462 = onLeaf;
        if _e462 {
            local_7 = 0u;
        } else {
            let _e463 = belowValue;
            param_127 = _e463;
            let _e464 = getSleep_u0028_u1_u003b((&param_127));
            let _e465 = belowValue;
            param_128 = _e465;
            let _e466 = getAge_u0028_u1_u003b((&param_128));
            param_129 = 4u;
            param_130 = 0u;
            param_131 = _e464;
            param_132 = _e466;
            let _e467 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_129), (&param_130), (&param_131), (&param_132));
            local_7 = _e467;
        }
        let _e468 = local_7;
        stripped = _e468;
        let _e469 = belowIndex;
        let _e472 = belowValue;
        let _e473 = stripped;
        let _e474 = atomicCompareExchangeWeak((&unnamed.grid[_e469]), _e472, _e473);
        let _e476 = belowValue;
        if (_e474.old_value != _e476) {
            return;
        }
        let _e478 = count_2;
        let _e480 = tuning.locustEatGain;
        grown = (_e478 + _e480);
        let _e482 = grown;
        let _e483 = locustMaxCount_u0028_();
        if (_e482 > _e483) {
            let _e485 = (*pos_5);
            param_133 = _e485;
            let _e486 = (*randVal_3);
            param_134 = _e486;
            locustBud_u0028_vi3_u003b_f1_u003b((&param_133), (&param_134));
            let _e487 = locustMaxCount_u0028_();
            grown = _e487;
        }
        let _e488 = (*currentIndex_3);
        let _e491 = (*rawValue_2);
        let _e492 = grown;
        param_135 = _e492;
        let _e493 = locustTypeFor_u0028_u1_u003b((&param_135));
        param_136 = _e493;
        param_137 = 0u;
        param_138 = 0u;
        let _e494 = grown;
        param_139 = _e494;
        let _e495 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_136), (&param_137), (&param_138), (&param_139));
        let _e496 = atomicCompareExchangeWeak((&unnamed.grid[_e488]), _e491, _e495);
        return;
    }
    let _e498 = count_2;
    if (_e498 <= 1u) {
        let _e500 = (*currentIndex_3);
        let _e503 = (*rawValue_2);
        let _e504 = atomicCompareExchangeWeak((&unnamed.grid[_e500]), _e503, 0u);
        return;
    }
    let _e506 = count_2;
    count_2 = (_e506 - 1u);
    let _e508 = count_2;
    param_140 = _e508;
    let _e509 = locustTypeFor_u0028_u1_u003b((&param_140));
    newType = _e509;
    let _e510 = belowValue;
    param_141 = _e510;
    let _e511 = getType_u0028_u1_u003b((&param_141));
    let _e512 = (_e511 == 0u);
    phi_7258_ = _e512;
    if _e512 {
        let _e513 = belowPos_1;
        param_142 = _e513;
        let _e514 = locustInBounds_u0028_vi3_u003b((&param_142));
        phi_7258_ = _e514;
    }
    let _e516 = phi_7258_;
    phi_7265_ = _e516;
    if _e516 {
        let _e517 = (*pos_5);
        param_143 = _e517;
        let _e518 = locustHasGrip_u0028_vi3_u003b((&param_143));
        phi_7265_ = !(_e518);
    }
    let _e521 = phi_7265_;
    if _e521 {
        let _e522 = belowPos_1;
        param_144 = _e522;
        let _e523 = (*currentDir_1);
        param_145 = _e523;
        let _e524 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_144), (&param_145));
        let _e525 = newType;
        param_146 = _e525;
        param_147 = _e524;
        param_148 = 0u;
        let _e526 = count_2;
        param_149 = _e526;
        let _e527 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_146), (&param_147), (&param_148), (&param_149));
        let _e528 = (*currentIndex_3);
        param_150 = _e528;
        let _e529 = (*rawValue_2);
        param_151 = _e529;
        let _e530 = belowIndex;
        param_152 = _e530;
        param_153 = _e527;
        let _e531 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_150), (&param_151), (&param_152), (&param_153));
        if _e531 {
            return;
        }
    }
    let _e532 = (*currentDir_1);
    param_154 = _e532;
    let _e533 = locustHeading_u0028_u1_u003b((&param_154));
    heading_1 = _e533;
    let _e534 = (*currentDir_1);
    param_155 = _e534;
    let _e535 = locustSteps_u0028_u1_u003b((&param_155));
    steps_1 = _e535;
    let _e536 = steps_1;
    if (_e536 == 0u) {
        let _e538 = (*randVal_3);
        start_5 = i32((fract((_e538 * 17f)) * 8f));
        i_6 = 0i;
        loop {
            let _e543 = i_6;
            if (_e543 < 8i) {
                let _e545 = start_5;
                let _e546 = i_6;
                let _e547 = (_e545 + _e546);
                d_4 = (_e547 - (i32(floor((f32(_e547) / f32(8i)))) * 8i));
                let _e555 = (*pos_5);
                let _e556 = d_4;
                param_156 = _e556;
                let _e557 = getHDir_u0028_i1_u003b((&param_156));
                c_5 = (_e555 + _e557);
                rise = 0i;
                loop {
                    let _e559 = rise;
                    if (_e559 < 3i) {
                        let _e561 = c_5;
                        let _e562 = rise;
                        if (_e562 == 1i) {
                            local_8 = 1i;
                        } else {
                            let _e564 = rise;
                            local_8 = select(0i, -1i, (_e564 == 2i));
                        }
                        let _e567 = local_8;
                        t_2 = (_e561 + vec3<i32>(0i, _e567, 0i));
                        let _e570 = t_2;
                        param_157 = _e570;
                        let _e571 = locustInBounds_u0028_vi3_u003b((&param_157));
                        if !(_e571) {
                            continue;
                        }
                        let _e573 = t_2;
                        param_158 = _e573;
                        let _e574 = getIndex_u0028_vi3_u003b((&param_158));
                        param_159 = _e574;
                        let _e575 = readCell_u0028_u1_u003b((&param_159));
                        if (_e575 != 0u) {
                            continue;
                        }
                        let _e577 = t_2;
                        param_160 = (_e577 + vec3<i32>(0i, -1i, 0i));
                        let _e579 = locustFoodAt_u0028_vi3_u003b((&param_160));
                        if !(_e579) {
                            continue;
                        }
                        let _e581 = t_2;
                        param_161 = _e581;
                        let _e582 = getIndex_u0028_vi3_u003b((&param_161));
                        let _e583 = newType;
                        param_162 = _e583;
                        param_163 = 0u;
                        param_164 = 0u;
                        let _e584 = count_2;
                        param_165 = _e584;
                        let _e585 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_162), (&param_163), (&param_164), (&param_165));
                        let _e586 = (*currentIndex_3);
                        param_166 = _e586;
                        let _e587 = (*rawValue_2);
                        param_167 = _e587;
                        param_168 = _e582;
                        param_169 = _e585;
                        let _e588 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_166), (&param_167), (&param_168), (&param_169));
                        if _e588 {
                            return;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e589 = rise;
                        rise = (_e589 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e591 = i_6;
                i_6 = (_e591 + 1i);
            }
        }
        let _e593 = (*randVal_3);
        heading_1 = (u32((fract((_e593 * 23f)) * 8f)) & 7u);
        let _e599 = locustRunSteps_u0028_();
        steps_1 = _e599;
    }
    let _e600 = (*pos_5);
    let _e601 = heading_1;
    param_170 = bitcast<i32>(_e601);
    let _e603 = getHDir_u0028_i1_u003b((&param_170));
    target_ = (_e600 + _e603);
    let _e605 = target_;
    param_171 = _e605;
    let _e606 = locustInBounds_u0028_vi3_u003b((&param_171));
    let _e607 = !(_e606);
    phi_7426_ = _e607;
    if !(_e607) {
        let _e609 = target_;
        param_172 = _e609;
        let _e610 = getIndex_u0028_vi3_u003b((&param_172));
        param_173 = _e610;
        let _e611 = readCell_u0028_u1_u003b((&param_173));
        phi_7426_ = (_e611 != 0u);
    }
    let _e614 = phi_7426_;
    blocked = _e614;
    let _e615 = blocked;
    if !(_e615) {
        let _e617 = target_;
        footing = (_e617 + vec3<i32>(0i, -1i, 0i));
        let _e619 = footing;
        param_174 = _e619;
        let _e620 = locustInBounds_u0028_vi3_u003b((&param_174));
        phi_7445_ = _e620;
        if _e620 {
            let _e621 = footing;
            param_175 = _e621;
            let _e622 = getIndex_u0028_vi3_u003b((&param_175));
            param_176 = _e622;
            let _e623 = readCell_u0028_u1_u003b((&param_176));
            phi_7445_ = (_e623 == 0u);
        }
        let _e626 = phi_7445_;
        if _e626 {
            let _e627 = heading_1;
            param_177 = _e627;
            let _e628 = locustReverse_u0028_u1_u003b((&param_177));
            back = _e628;
            let _e629 = (*pos_5);
            let _e630 = back;
            param_178 = bitcast<i32>(_e630);
            let _e632 = getHDir_u0028_i1_u003b((&param_178));
            backPos = (_e629 + _e632);
            let _e634 = backPos;
            backFoot = (_e634 + vec3<i32>(0i, -1i, 0i));
            let _e636 = backPos;
            param_179 = _e636;
            let _e637 = locustInBounds_u0028_vi3_u003b((&param_179));
            phi_7474_ = _e637;
            if _e637 {
                let _e638 = backPos;
                param_180 = _e638;
                let _e639 = getIndex_u0028_vi3_u003b((&param_180));
                param_181 = _e639;
                let _e640 = readCell_u0028_u1_u003b((&param_181));
                phi_7474_ = (_e640 == 0u);
            }
            let _e643 = phi_7474_;
            phi_7490_ = _e643;
            if _e643 {
                let _e644 = backFoot;
                param_182 = _e644;
                let _e645 = locustInBounds_u0028_vi3_u003b((&param_182));
                phi_7488_ = _e645;
                if _e645 {
                    let _e646 = backFoot;
                    param_183 = _e646;
                    let _e647 = getIndex_u0028_vi3_u003b((&param_183));
                    param_184 = _e647;
                    let _e648 = readCell_u0028_u1_u003b((&param_184));
                    phi_7488_ = (_e648 == 0u);
                }
                let _e651 = phi_7488_;
                phi_7490_ = !(_e651);
            }
            let _e654 = phi_7490_;
            backOpen = _e654;
            let _e655 = backOpen;
            if _e655 {
                let _e656 = back;
                param_185 = _e656;
                let _e657 = steps_1;
                param_186 = _e657;
                let _e658 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_185), (&param_186));
                local_9 = _e658;
            } else {
                let _e659 = (*randVal_3);
                let _e665 = locustRunSteps_u0028_();
                param_187 = (u32((fract((_e659 * 71f)) * 8f)) & 7u);
                param_188 = _e665;
                let _e666 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_187), (&param_188));
                local_9 = _e666;
            }
            let _e667 = local_9;
            turnedNav = _e667;
            let _e668 = (*currentIndex_3);
            let _e671 = (*rawValue_2);
            let _e672 = newType;
            param_189 = _e672;
            let _e673 = turnedNav;
            param_190 = _e673;
            param_191 = 0u;
            let _e674 = count_2;
            param_192 = _e674;
            let _e675 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_189), (&param_190), (&param_191), (&param_192));
            let _e676 = atomicCompareExchangeWeak((&unnamed.grid[_e668]), _e671, _e675);
            return;
        }
        let _e678 = steps_1;
        let _e680 = heading_1;
        param_193 = _e680;
        param_194 = (_e678 - 1u);
        let _e681 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_193), (&param_194));
        nav_1 = _e681;
        let _e682 = target_;
        param_195 = _e682;
        let _e683 = getIndex_u0028_vi3_u003b((&param_195));
        let _e684 = target_;
        param_196 = _e684;
        let _e685 = nav_1;
        param_197 = _e685;
        let _e686 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_196), (&param_197));
        let _e687 = newType;
        param_198 = _e687;
        param_199 = _e686;
        param_200 = 0u;
        let _e688 = count_2;
        param_201 = _e688;
        let _e689 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_198), (&param_199), (&param_200), (&param_201));
        let _e690 = (*currentIndex_3);
        param_202 = _e690;
        let _e691 = (*rawValue_2);
        param_203 = _e691;
        param_204 = _e683;
        param_205 = _e689;
        let _e692 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_202), (&param_203), (&param_204), (&param_205));
        if _e692 {
            return;
        }
    } else {
        let _e693 = (*randVal_3);
        let _e697 = tuning.locustClimbChance;
        if (fract((_e693 * 41f)) < _e697) {
            let _e699 = target_;
            overTop = (_e699 + vec3<i32>(0i, 1i, 0i));
            let _e701 = overTop;
            param_206 = _e701;
            let _e702 = locustInBounds_u0028_vi3_u003b((&param_206));
            phi_7582_ = _e702;
            if _e702 {
                let _e703 = overTop;
                param_207 = _e703;
                let _e704 = getIndex_u0028_vi3_u003b((&param_207));
                param_208 = _e704;
                let _e705 = readCell_u0028_u1_u003b((&param_208));
                phi_7582_ = (_e705 == 0u);
            }
            let _e708 = phi_7582_;
            if _e708 {
                let _e709 = steps_1;
                let _e711 = heading_1;
                param_209 = _e711;
                param_210 = (_e709 - 1u);
                let _e712 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_209), (&param_210));
                nav_2 = _e712;
                let _e713 = overTop;
                param_211 = _e713;
                let _e714 = getIndex_u0028_vi3_u003b((&param_211));
                let _e715 = overTop;
                param_212 = _e715;
                let _e716 = nav_2;
                param_213 = _e716;
                let _e717 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_212), (&param_213));
                let _e718 = newType;
                param_214 = _e718;
                param_215 = _e717;
                param_216 = 0u;
                let _e719 = count_2;
                param_217 = _e719;
                let _e720 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_214), (&param_215), (&param_216), (&param_217));
                let _e721 = (*currentIndex_3);
                param_218 = _e721;
                let _e722 = (*rawValue_2);
                param_219 = _e722;
                param_220 = _e714;
                param_221 = _e720;
                let _e723 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_218), (&param_219), (&param_220), (&param_221));
                if _e723 {
                    return;
                }
            }
            let _e724 = (*pos_5);
            up = (_e724 + vec3<i32>(0i, 1i, 0i));
            let _e726 = up;
            param_222 = _e726;
            let _e727 = locustInBounds_u0028_vi3_u003b((&param_222));
            phi_7631_ = _e727;
            if _e727 {
                let _e728 = up;
                param_223 = _e728;
                let _e729 = getIndex_u0028_vi3_u003b((&param_223));
                param_224 = _e729;
                let _e730 = readCell_u0028_u1_u003b((&param_224));
                phi_7631_ = (_e730 == 0u);
            }
            let _e733 = phi_7631_;
            if _e733 {
                let _e734 = heading_1;
                param_225 = _e734;
                let _e735 = steps_1;
                param_226 = _e735;
                let _e736 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_225), (&param_226));
                nav_3 = _e736;
                let _e737 = up;
                param_227 = _e737;
                let _e738 = getIndex_u0028_vi3_u003b((&param_227));
                let _e739 = up;
                param_228 = _e739;
                let _e740 = nav_3;
                param_229 = _e740;
                let _e741 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_228), (&param_229));
                let _e742 = newType;
                param_230 = _e742;
                param_231 = _e741;
                param_232 = 0u;
                let _e743 = count_2;
                param_233 = _e743;
                let _e744 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_230), (&param_231), (&param_232), (&param_233));
                let _e745 = (*currentIndex_3);
                param_234 = _e745;
                let _e746 = (*rawValue_2);
                param_235 = _e746;
                param_236 = _e738;
                param_237 = _e744;
                let _e747 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_234), (&param_235), (&param_236), (&param_237));
                if _e747 {
                    return;
                }
            }
        }
        let _e748 = (*randVal_3);
        heading_1 = (u32((fract((_e748 * 53f)) * 8f)) & 7u);
        let _e754 = locustRunSteps_u0028_();
        steps_1 = _e754;
    }
    let _e755 = (*currentIndex_3);
    let _e758 = (*rawValue_2);
    let _e759 = heading_1;
    param_238 = _e759;
    let _e760 = steps_1;
    param_239 = _e760;
    let _e761 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_238), (&param_239));
    let _e762 = newType;
    param_240 = _e762;
    param_241 = _e761;
    param_242 = 0u;
    let _e763 = count_2;
    param_243 = _e763;
    let _e764 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_240), (&param_241), (&param_242), (&param_243));
    let _e765 = atomicCompareExchangeWeak((&unnamed.grid[_e755]), _e758, _e764);
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
    var phi_6314_: bool;

    let _e223 = (*pos_6)[1u];
    if (_e223 > 1i) {
        let _e225 = (*pos_6);
        belowPos_2 = (_e225 + vec3<i32>(0i, -1i, 0i));
        let _e227 = belowPos_2;
        param_244 = _e227;
        let _e228 = getIndex_u0028_vi3_u003b((&param_244));
        param_245 = _e228;
        let _e229 = readCell_u0028_u1_u003b((&param_245));
        param_246 = _e229;
        let _e230 = getType_u0028_u1_u003b((&param_246));
        if (_e230 == 0u) {
            let _e232 = belowPos_2;
            param_247 = _e232;
            let _e233 = getIndex_u0028_vi3_u003b((&param_247));
            param_248 = 12u;
            param_249 = 0u;
            param_250 = 0u;
            let _e234 = (*currentAge_3);
            param_251 = _e234;
            let _e235 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_248), (&param_249), (&param_250), (&param_251));
            let _e236 = (*currentIndex_4);
            param_252 = _e236;
            let _e237 = (*rawValue_3);
            param_253 = _e237;
            param_254 = _e233;
            param_255 = _e235;
            let _e238 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_252), (&param_253), (&param_254), (&param_255));
            if _e238 {
                return;
            }
        }
    }
    let _e239 = (*currentAge_3);
    let _e240 = (_e239 > 0u);
    phi_6314_ = _e240;
    if _e240 {
        let _e241 = (*randVal_4);
        let _e245 = tuning.darkStoneDryChance;
        phi_6314_ = (fract((_e241 * 23f)) < _e245);
    }
    let _e248 = phi_6314_;
    if _e248 {
        let _e249 = (*currentIndex_4);
        let _e252 = (*rawValue_3);
        let _e253 = (*currentAge_3);
        param_256 = 12u;
        param_257 = 0u;
        param_258 = 0u;
        param_259 = (_e253 - 1u);
        let _e255 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_256), (&param_257), (&param_258), (&param_259));
        let _e256 = atomicCompareExchangeWeak((&unnamed.grid[_e249]), _e252, _e255);
    }
    return;
}

fn isLava_u0028_u1_u003b(type_35: ptr<function, u32>) -> bool {
    let _e201 = (*type_35);
    let _e203 = (*type_35);
    return ((_e201 >= 8u) && (_e203 <= 11u));
}

fn lavaTypeFor_u0028_u1_u003b(coolness: ptr<function, u32>) -> u32 {
    let _e201 = (*coolness);
    let _e203 = tuning.lavaStageSize;
    return (8u + min((_e201 / max(_e203, 1u)), 3u));
}

fn lavaSolidifyCoolness_u0028_() -> u32 {
    let _e201 = tuning.lavaStageSize;
    return min((max(_e201, 1u) * 4u), 255u);
}

fn decWater_u0028_() {
    let _e201 = atomicAdd((&unnamed_2.waterVoxelCount), 4294967295u);
    return;
}

fn getOrthoDir_u0028_i1_u003b(d_5: ptr<function, i32>) -> vec3<i32> {
    let _e201 = (*d_5);
    if (_e201 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e203 = (*d_5);
    if (_e203 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e205 = (*d_5);
    if (_e205 == 2i) {
        return vec3<i32>(0i, 1i, 0i);
    }
    let _e207 = (*d_5);
    if (_e207 == 3i) {
        return vec3<i32>(0i, -1i, 0i);
    }
    let _e209 = (*d_5);
    if (_e209 == 4i) {
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
    var phi_5368_: bool;
    var phi_5375_: bool;
    var phi_5386_: bool;
    var phi_5393_: bool;
    var phi_5404_: bool;
    var phi_5543_: bool;
    var phi_5554_: bool;

    let _e268 = (*randVal_5);
    startDir = i32((fract((_e268 * 17f)) * 6f));
    i_7 = 0i;
    loop {
        let _e273 = i_7;
        if (_e273 < 6i) {
            let _e275 = startDir;
            let _e276 = i_7;
            let _e277 = (_e275 + _e276);
            d_6 = (_e277 - (i32(floor((f32(_e277) / f32(6i)))) * 6i));
            let _e285 = (*pos_7);
            let _e286 = d_6;
            param_260 = _e286;
            let _e287 = getOrthoDir_u0028_i1_u003b((&param_260));
            nPos = (_e285 + _e287);
            let _e290 = nPos[0u];
            let _e291 = (_e290 <= 0i);
            phi_5368_ = _e291;
            if !(_e291) {
                let _e294 = nPos[0u];
                let _e296 = tuning.gridWidth;
                phi_5368_ = (_e294 >= (bitcast<i32>(_e296) - 1i));
            }
            let _e301 = phi_5368_;
            phi_5375_ = _e301;
            if !(_e301) {
                let _e304 = nPos[1u];
                phi_5375_ = (_e304 <= 0i);
            }
            let _e307 = phi_5375_;
            phi_5386_ = _e307;
            if !(_e307) {
                let _e310 = nPos[1u];
                let _e312 = tuning.gridHeight;
                phi_5386_ = (_e310 >= (bitcast<i32>(_e312) - 1i));
            }
            let _e317 = phi_5386_;
            phi_5393_ = _e317;
            if !(_e317) {
                let _e320 = nPos[2u];
                phi_5393_ = (_e320 <= 0i);
            }
            let _e323 = phi_5393_;
            phi_5404_ = _e323;
            if !(_e323) {
                let _e326 = nPos[2u];
                let _e328 = tuning.gridDepth;
                phi_5404_ = (_e326 >= (bitcast<i32>(_e328) - 1i));
            }
            let _e333 = phi_5404_;
            if _e333 {
                continue;
            }
            let _e334 = nPos;
            param_261 = _e334;
            let _e335 = getIndex_u0028_vi3_u003b((&param_261));
            nIndex = _e335;
            let _e336 = nIndex;
            param_262 = _e336;
            let _e337 = readCell_u0028_u1_u003b((&param_262));
            nVal = _e337;
            let _e338 = nVal;
            param_263 = _e338;
            let _e339 = getType_u0028_u1_u003b((&param_263));
            nType = _e339;
            let _e340 = nType;
            if (_e340 == 2u) {
                let _e342 = nIndex;
                let _e345 = nVal;
                param_264 = 6u;
                param_265 = 0u;
                param_266 = 0u;
                param_267 = 0u;
                let _e346 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_264), (&param_265), (&param_266), (&param_267));
                let _e347 = atomicCompareExchangeWeak((&unnamed.grid[_e342]), _e345, _e346);
                let _e349 = nVal;
                if (_e347.old_value == _e349) {
                    decWater_u0028_();
                    let _e351 = (*coolness_1);
                    let _e353 = tuning.lavaWaterCool;
                    (*coolness_1) = min((_e351 + _e353), 255u);
                    return;
                }
            } else {
                let _e356 = nType;
                if (_e356 == 19u) {
                    let _e358 = nIndex;
                    let _e361 = nVal;
                    let _e362 = atomicCompareExchangeWeak((&unnamed.grid[_e358]), _e361, 0u);
                    let _e364 = nVal;
                    if (_e362.old_value == _e364) {
                        return;
                    }
                } else {
                    let _e366 = nType;
                    if (_e366 == 18u) {
                        let _e368 = nIndex;
                        let _e371 = nVal;
                        param_268 = 5u;
                        param_269 = 0u;
                        param_270 = 0u;
                        param_271 = 0u;
                        let _e372 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_268), (&param_269), (&param_270), (&param_271));
                        let _e373 = atomicCompareExchangeWeak((&unnamed.grid[_e368]), _e371, _e372);
                        let _e375 = nVal;
                        if (_e373.old_value == _e375) {
                            return;
                        }
                    } else {
                        let _e377 = nType;
                        if (_e377 == 3u) {
                            let _e379 = nIndex;
                            let _e382 = nVal;
                            param_272 = 12u;
                            param_273 = 0u;
                            param_274 = 0u;
                            param_275 = 255u;
                            let _e383 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_272), (&param_273), (&param_274), (&param_275));
                            let _e384 = atomicCompareExchangeWeak((&unnamed.grid[_e379]), _e382, _e383);
                            let _e386 = nVal;
                            if (_e384.old_value == _e386) {
                                return;
                            }
                        } else {
                            let _e388 = nType;
                            let _e390 = nType;
                            if ((_e388 == 1u) || (_e390 == 4u)) {
                                let _e393 = nVal;
                                param_276 = _e393;
                                let _e394 = getAge_u0028_u1_u003b((&param_276));
                                moisture_1 = _e394;
                                let _e395 = nVal;
                                param_277 = _e395;
                                let _e396 = getDir_u0028_u1_u003b((&param_277));
                                flora_2 = _e396;
                                let _e397 = nType;
                                let _e399 = flora_2;
                                let _e402 = flora_2;
                                if (((_e397 == 4u) && (_e399 > 10u)) && (_e402 <= 100u)) {
                                    let _e405 = nPos;
                                    abovePos = (_e405 + vec3<i32>(0i, 1i, 0i));
                                    let _e408 = abovePos[1u];
                                    let _e410 = tuning.gridHeight;
                                    let _e413 = (_e408 < (bitcast<i32>(_e410) - 1i));
                                    phi_5543_ = _e413;
                                    if _e413 {
                                        let _e414 = abovePos;
                                        param_278 = _e414;
                                        let _e415 = getIndex_u0028_vi3_u003b((&param_278));
                                        param_279 = _e415;
                                        let _e416 = readCell_u0028_u1_u003b((&param_279));
                                        param_280 = _e416;
                                        let _e417 = getType_u0028_u1_u003b((&param_280));
                                        phi_5543_ = (_e417 == 0u);
                                    }
                                    let _e420 = phi_5543_;
                                    phi_5554_ = _e420;
                                    if _e420 {
                                        let _e421 = (*randVal_5);
                                        let _e425 = tuning.lavaIgniteChance;
                                        phi_5554_ = (fract((_e421 * 41f)) < _e425);
                                    }
                                    let _e428 = phi_5554_;
                                    if _e428 {
                                        let _e429 = abovePos;
                                        param_281 = _e429;
                                        let _e430 = getIndex_u0028_vi3_u003b((&param_281));
                                        param_282 = 5u;
                                        param_283 = 0u;
                                        param_284 = 0u;
                                        param_285 = 0u;
                                        let _e433 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_282), (&param_283), (&param_284), (&param_285));
                                        let _e434 = atomicCompareExchangeWeak((&unnamed.grid[_e430]), 0u, _e433);
                                        if (_e434.old_value == 0u) {
                                            return;
                                        }
                                    }
                                } else {
                                    let _e437 = moisture_1;
                                    if (_e437 > 0u) {
                                        let _e439 = nIndex;
                                        let _e442 = nVal;
                                        let _e443 = moisture_1;
                                        let _e445 = nType;
                                        param_286 = _e445;
                                        let _e446 = flora_2;
                                        param_287 = _e446;
                                        param_288 = 0u;
                                        param_289 = (_e443 - 1u);
                                        let _e447 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_286), (&param_287), (&param_288), (&param_289));
                                        let _e448 = atomicCompareExchangeWeak((&unnamed.grid[_e439]), _e442, _e447);
                                        let _e450 = nVal;
                                        if (_e448.old_value == _e450) {
                                            let _e452 = (*coolness_1);
                                            let _e454 = tuning.lavaMoistureCool;
                                            (*coolness_1) = min((_e452 + _e454), 255u);
                                            return;
                                        }
                                    } else {
                                        let _e457 = (*randVal_5);
                                        let _e461 = tuning.lavaConsumeChance;
                                        if (fract((_e457 * 53f)) < _e461) {
                                            let _e463 = nIndex;
                                            let _e466 = nVal;
                                            let _e467 = atomicCompareExchangeWeak((&unnamed.grid[_e463]), _e466, 0u);
                                            let _e469 = nVal;
                                            if (_e467.old_value == _e469) {
                                                return;
                                            }
                                        }
                                    }
                                }
                            } else {
                                let _e471 = nType;
                                param_290 = _e471;
                                let _e472 = isLava_u0028_u1_u003b((&param_290));
                                if _e472 {
                                    let _e473 = nVal;
                                    param_291 = _e473;
                                    let _e474 = getAge_u0028_u1_u003b((&param_291));
                                    nCool = _e474;
                                    let _e475 = (*coolness_1);
                                    let _e476 = nCool;
                                    if (_e475 > (_e476 + 1u)) {
                                        let _e479 = nCool;
                                        raised = (_e479 + 1u);
                                        let _e481 = raised;
                                        let _e482 = lavaSolidifyCoolness_u0028_();
                                        if (_e481 >= _e482) {
                                            local_10 = 12u;
                                        } else {
                                            let _e484 = raised;
                                            param_292 = _e484;
                                            let _e485 = lavaTypeFor_u0028_u1_u003b((&param_292));
                                            local_10 = _e485;
                                        }
                                        let _e486 = local_10;
                                        raisedType = _e486;
                                        let _e487 = nIndex;
                                        let _e490 = nVal;
                                        let _e491 = nVal;
                                        param_293 = _e491;
                                        let _e492 = getDir_u0028_u1_u003b((&param_293));
                                        let _e493 = raisedType;
                                        param_294 = _e493;
                                        param_295 = _e492;
                                        param_296 = 0u;
                                        let _e494 = raised;
                                        param_297 = _e494;
                                        let _e495 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_294), (&param_295), (&param_296), (&param_297));
                                        let _e496 = atomicCompareExchangeWeak((&unnamed.grid[_e487]), _e490, _e495);
                                        let _e498 = nVal;
                                        if (_e496.old_value == _e498) {
                                            let _e500 = (*coolness_1);
                                            (*coolness_1) = (_e500 - 1u);
                                            return;
                                        }
                                    }
                                } else {
                                    let _e502 = nType;
                                    if (_e502 == 12u) {
                                        let _e504 = nVal;
                                        param_298 = _e504;
                                        let _e505 = getAge_u0028_u1_u003b((&param_298));
                                        nCool_1 = _e505;
                                        let _e506 = nCool_1;
                                        let _e507 = (*coolness_1);
                                        draws = (_e506 > (_e507 + 1u));
                                        let _e510 = draws;
                                        if _e510 {
                                            let _e511 = nCool_1;
                                            local_11 = (_e511 - 1u);
                                        } else {
                                            let _e513 = nCool_1;
                                            local_11 = _e513;
                                        }
                                        let _e514 = local_11;
                                        lowered = _e514;
                                        let _e515 = lowered;
                                        let _e516 = lavaSolidifyCoolness_u0028_();
                                        melts = (_e515 < _e516);
                                        let _e518 = draws;
                                        let _e519 = melts;
                                        if (_e518 || _e519) {
                                            let _e521 = melts;
                                            if _e521 {
                                                let _e522 = lowered;
                                                param_299 = _e522;
                                                let _e523 = lavaTypeFor_u0028_u1_u003b((&param_299));
                                                local_12 = _e523;
                                            } else {
                                                local_12 = 12u;
                                            }
                                            let _e524 = local_12;
                                            newType_1 = _e524;
                                            let _e525 = nIndex;
                                            let _e528 = nVal;
                                            let _e529 = newType_1;
                                            param_300 = _e529;
                                            param_301 = 0u;
                                            param_302 = 0u;
                                            let _e530 = lowered;
                                            param_303 = _e530;
                                            let _e531 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_300), (&param_301), (&param_302), (&param_303));
                                            let _e532 = atomicCompareExchangeWeak((&unnamed.grid[_e525]), _e528, _e531);
                                            let _e534 = nVal;
                                            if (_e532.old_value == _e534) {
                                                let _e536 = draws;
                                                if _e536 {
                                                    let _e537 = (*coolness_1);
                                                    (*coolness_1) = min((_e537 + 1u), 255u);
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
            let _e540 = i_7;
            i_7 = (_e540 + 1i);
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
    var phi_5762_: bool;
    var phi_5900_: bool;
    var phi_5906_: bool;
    var phi_5916_: bool;
    var phi_6028_: bool;
    var phi_6035_: bool;
    var phi_6046_: bool;
    var phi_6058_: bool;
    var phi_6080_: bool;
    var phi_6194_: bool;
    var phi_6200_: bool;
    var phi_6210_: bool;

    let _e302 = (*currentAge_4);
    coolness_2 = _e302;
    let _e303 = (*pos_8);
    param_304 = _e303;
    let _e304 = coolness_2;
    param_305 = _e304;
    let _e305 = (*randVal_6);
    param_306 = _e305;
    lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b((&param_304), (&param_305), (&param_306));
    let _e306 = param_305;
    coolness_2 = _e306;
    let _e307 = (*currentSleep_1);
    let _e309 = tuning.wakeSleepThreshold;
    let _e310 = (_e307 > _e309);
    phi_5762_ = _e310;
    if _e310 {
        let _e311 = (*randVal_6);
        let _e315 = tuning.lavaRestCoolChance;
        phi_5762_ = (fract((_e311 * 71f)) < _e315);
    }
    let _e318 = phi_5762_;
    if _e318 {
        let _e319 = coolness_2;
        coolness_2 = min((_e319 + 1u), 255u);
    }
    let _e322 = coolness_2;
    let _e323 = lavaSolidifyCoolness_u0028_();
    if (_e322 >= _e323) {
        let _e325 = (*currentIndex_5);
        let _e328 = (*rawValue_4);
        param_307 = 12u;
        param_308 = 0u;
        param_309 = 0u;
        let _e329 = coolness_2;
        param_310 = _e329;
        let _e330 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_307), (&param_308), (&param_309), (&param_310));
        let _e331 = atomicCompareExchangeWeak((&unnamed.grid[_e325]), _e328, _e330);
        return;
    }
    let _e333 = coolness_2;
    param_311 = _e333;
    let _e334 = lavaTypeFor_u0028_u1_u003b((&param_311));
    newType_2 = _e334;
    let _e335 = (*randVal_6);
    let _e339 = tuning.lavaViscosity;
    if (fract((_e335 * 89f)) < _e339) {
        let _e342 = (*pos_8)[1u];
        if (_e342 > 1i) {
            let _e344 = (*pos_8);
            belowPos_3 = (_e344 + vec3<i32>(0i, -1i, 0i));
            let _e346 = belowPos_3;
            param_312 = _e346;
            let _e347 = getIndex_u0028_vi3_u003b((&param_312));
            param_313 = _e347;
            let _e348 = readCell_u0028_u1_u003b((&param_313));
            param_314 = _e348;
            let _e349 = getType_u0028_u1_u003b((&param_314));
            if (_e349 == 0u) {
                let _e351 = belowPos_3;
                param_315 = _e351;
                let _e352 = getIndex_u0028_vi3_u003b((&param_315));
                let _e353 = newType_2;
                param_316 = _e353;
                let _e354 = (*currentDir_2);
                param_317 = _e354;
                param_318 = 0u;
                let _e355 = coolness_2;
                param_319 = _e355;
                let _e356 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_316), (&param_317), (&param_318), (&param_319));
                let _e357 = (*currentIndex_5);
                param_320 = _e357;
                let _e358 = (*rawValue_4);
                param_321 = _e358;
                param_322 = _e352;
                param_323 = _e356;
                let _e359 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_320), (&param_321), (&param_322), (&param_323));
                if _e359 {
                    return;
                }
            }
        }
        let _e361 = (*pos_8)[1u];
        if (_e361 > 1i) {
            let _e363 = (*randVal_6);
            slideDir = select(-1i, 1i, (fract((_e363 * 10f)) > 0.5f));
            let _e368 = (*randVal_6);
            if (fract((_e368 * 100f)) > 0.5f) {
                let _e372 = (*pos_8);
                let _e373 = slideDir;
                slide[0i] = (_e372 + vec3<i32>(_e373, -1i, 0i));
                let _e377 = (*pos_8);
                let _e378 = slideDir;
                slide[1i] = (_e377 + vec3<i32>(0i, -1i, _e378));
            } else {
                let _e382 = (*pos_8);
                let _e383 = slideDir;
                slide[0i] = (_e382 + vec3<i32>(0i, -1i, _e383));
                let _e387 = (*pos_8);
                let _e388 = slideDir;
                slide[1i] = (_e387 + vec3<i32>(_e388, -1i, 0i));
            }
            s = 0i;
            loop {
                let _e392 = s;
                if (_e392 < 2i) {
                    let _e394 = s;
                    let _e396 = slide[_e394];
                    sPos = _e396;
                    let _e398 = sPos[0u];
                    let _e399 = (_e398 > 0i);
                    phi_5900_ = _e399;
                    if _e399 {
                        let _e401 = sPos[0u];
                        let _e403 = tuning.gridWidth;
                        phi_5900_ = (_e401 < (bitcast<i32>(_e403) - 1i));
                    }
                    let _e408 = phi_5900_;
                    phi_5906_ = _e408;
                    if _e408 {
                        let _e410 = sPos[2u];
                        phi_5906_ = (_e410 > 0i);
                    }
                    let _e413 = phi_5906_;
                    phi_5916_ = _e413;
                    if _e413 {
                        let _e415 = sPos[2u];
                        let _e417 = tuning.gridDepth;
                        phi_5916_ = (_e415 < (bitcast<i32>(_e417) - 1i));
                    }
                    let _e422 = phi_5916_;
                    if _e422 {
                        let _e423 = sPos;
                        param_324 = _e423;
                        let _e424 = getIndex_u0028_vi3_u003b((&param_324));
                        param_325 = _e424;
                        let _e425 = readCell_u0028_u1_u003b((&param_325));
                        param_326 = _e425;
                        let _e426 = getType_u0028_u1_u003b((&param_326));
                        if (_e426 == 0u) {
                            let _e428 = sPos;
                            param_327 = _e428;
                            let _e429 = getIndex_u0028_vi3_u003b((&param_327));
                            let _e430 = newType_2;
                            param_328 = _e430;
                            let _e431 = (*currentDir_2);
                            param_329 = _e431;
                            param_330 = 0u;
                            let _e432 = coolness_2;
                            param_331 = _e432;
                            let _e433 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_328), (&param_329), (&param_330), (&param_331));
                            let _e434 = (*currentIndex_5);
                            param_332 = _e434;
                            let _e435 = (*rawValue_4);
                            param_333 = _e435;
                            param_334 = _e429;
                            param_335 = _e433;
                            let _e436 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_332), (&param_333), (&param_334), (&param_335));
                            if _e436 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e437 = s;
                    s = (_e437 + 1i);
                }
            }
        }
        let _e439 = (*currentSleep_1);
        let _e441 = tuning.wakeSleepThreshold;
        if (_e439 <= _e441) {
            blockedMask = 0u;
            let _e443 = (*randVal_6);
            searchStart = i32((fract((_e443 * 8f)) * 8f));
            let _e449 = tuning.lavaSpreadRadius;
            reach = bitcast<i32>(max(_e449, 1u));
            r = 1i;
            loop {
                let _e452 = r;
                let _e453 = reach;
                if (_e452 <= _e453) {
                    let _e455 = blockedMask;
                    if (_e455 == 255u) {
                        break;
                    }
                    i_8 = 0i;
                    loop {
                        let _e457 = i_8;
                        if (_e457 < 8i) {
                            let _e459 = searchStart;
                            let _e460 = i_8;
                            let _e461 = (_e459 + _e460);
                            d_7 = (_e461 - (i32(floor((f32(_e461) / f32(8i)))) * 8i));
                            let _e469 = blockedMask;
                            let _e470 = d_7;
                            if ((_e469 & (1u << bitcast<u32>(_e470))) != 0u) {
                                continue;
                            }
                            let _e475 = (*pos_8);
                            let _e476 = d_7;
                            param_336 = _e476;
                            let _e477 = getHDir_u0028_i1_u003b((&param_336));
                            let _e478 = r;
                            c_6 = (_e475 + (_e477 * vec3(_e478)));
                            let _e483 = c_6[0u];
                            let _e484 = (_e483 <= 0i);
                            phi_6028_ = _e484;
                            if !(_e484) {
                                let _e487 = c_6[0u];
                                let _e489 = tuning.gridWidth;
                                phi_6028_ = (_e487 >= (bitcast<i32>(_e489) - 1i));
                            }
                            let _e494 = phi_6028_;
                            phi_6035_ = _e494;
                            if !(_e494) {
                                let _e497 = c_6[2u];
                                phi_6035_ = (_e497 <= 0i);
                            }
                            let _e500 = phi_6035_;
                            phi_6046_ = _e500;
                            if !(_e500) {
                                let _e503 = c_6[2u];
                                let _e505 = tuning.gridDepth;
                                phi_6046_ = (_e503 >= (bitcast<i32>(_e505) - 1i));
                            }
                            let _e510 = phi_6046_;
                            phi_6058_ = _e510;
                            if !(_e510) {
                                let _e512 = c_6;
                                param_337 = _e512;
                                let _e513 = getIndex_u0028_vi3_u003b((&param_337));
                                param_338 = _e513;
                                let _e514 = readCell_u0028_u1_u003b((&param_338));
                                param_339 = _e514;
                                let _e515 = getType_u0028_u1_u003b((&param_339));
                                phi_6058_ = (_e515 != 0u);
                            }
                            let _e518 = phi_6058_;
                            if _e518 {
                                let _e519 = d_7;
                                let _e522 = blockedMask;
                                blockedMask = (_e522 | (1u << bitcast<u32>(_e519)));
                            } else {
                                let _e525 = c_6[1u];
                                let _e526 = (_e525 > 1i);
                                phi_6080_ = _e526;
                                if _e526 {
                                    let _e527 = c_6;
                                    param_340 = (_e527 + vec3<i32>(0i, -1i, 0i));
                                    let _e529 = getIndex_u0028_vi3_u003b((&param_340));
                                    param_341 = _e529;
                                    let _e530 = readCell_u0028_u1_u003b((&param_341));
                                    param_342 = _e530;
                                    let _e531 = getType_u0028_u1_u003b((&param_342));
                                    phi_6080_ = (_e531 == 0u);
                                }
                                let _e534 = phi_6080_;
                                if _e534 {
                                    let _e535 = c_6;
                                    param_343 = _e535;
                                    let _e536 = getIndex_u0028_vi3_u003b((&param_343));
                                    let _e537 = newType_2;
                                    param_344 = _e537;
                                    param_345 = 0u;
                                    param_346 = 0u;
                                    let _e538 = coolness_2;
                                    param_347 = _e538;
                                    let _e539 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_344), (&param_345), (&param_346), (&param_347));
                                    let _e540 = (*currentIndex_5);
                                    param_348 = _e540;
                                    let _e541 = (*rawValue_4);
                                    param_349 = _e541;
                                    param_350 = _e536;
                                    param_351 = _e539;
                                    let _e542 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_348), (&param_349), (&param_350), (&param_351));
                                    if _e542 {
                                        return;
                                    }
                                    let _e543 = d_7;
                                    let _e546 = blockedMask;
                                    blockedMask = (_e546 | (1u << bitcast<u32>(_e543)));
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e548 = i_8;
                            i_8 = (_e548 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e550 = r;
                    r = (_e550 + 1i);
                }
            }
            let _e553 = (*pos_8)[1u];
            let _e555 = tuning.gridHeight;
            if (_e553 < (bitcast<i32>(_e555) - 2i)) {
                let _e559 = (*pos_8);
                param_352 = (_e559 + vec3<i32>(0i, 1i, 0i));
                let _e561 = getIndex_u0028_vi3_u003b((&param_352));
                param_353 = _e561;
                let _e562 = readCell_u0028_u1_u003b((&param_353));
                param_354 = _e562;
                let _e563 = getType_u0028_u1_u003b((&param_354));
                local_13 = (_e563 != 0u);
            } else {
                local_13 = false;
            }
            let _e565 = local_13;
            hasPressure = _e565;
            let _e567 = (*pos_8)[1u];
            if (_e567 > 1i) {
                let _e569 = (*pos_8);
                param_355 = (_e569 + vec3<i32>(0i, -1i, 0i));
                let _e571 = getIndex_u0028_vi3_u003b((&param_355));
                param_356 = _e571;
                let _e572 = readCell_u0028_u1_u003b((&param_356));
                param_357 = _e572;
                let _e573 = getType_u0028_u1_u003b((&param_357));
                param_358 = _e573;
                let _e574 = isLava_u0028_u1_u003b((&param_358));
                local_14 = _e574;
            } else {
                local_14 = false;
            }
            let _e575 = local_14;
            stackedOnLava = _e575;
            let _e576 = hasPressure;
            let _e577 = stackedOnLava;
            if (_e576 || _e577) {
                let _e579 = (*randVal_6);
                spreadStart = i32((fract((_e579 * 8f)) * 8f));
                i_9 = 0i;
                loop {
                    let _e584 = i_9;
                    if (_e584 < 8i) {
                        let _e586 = spreadStart;
                        let _e587 = i_9;
                        let _e588 = (_e586 + _e587);
                        d_8 = (_e588 - (i32(floor((f32(_e588) / f32(8i)))) * 8i));
                        let _e596 = (*pos_8);
                        let _e597 = d_8;
                        param_359 = _e597;
                        let _e598 = getHDir_u0028_i1_u003b((&param_359));
                        targetPos = (_e596 + _e598);
                        let _e601 = targetPos[0u];
                        let _e602 = (_e601 > 0i);
                        phi_6194_ = _e602;
                        if _e602 {
                            let _e604 = targetPos[0u];
                            let _e606 = tuning.gridWidth;
                            phi_6194_ = (_e604 < (bitcast<i32>(_e606) - 1i));
                        }
                        let _e611 = phi_6194_;
                        phi_6200_ = _e611;
                        if _e611 {
                            let _e613 = targetPos[2u];
                            phi_6200_ = (_e613 > 0i);
                        }
                        let _e616 = phi_6200_;
                        phi_6210_ = _e616;
                        if _e616 {
                            let _e618 = targetPos[2u];
                            let _e620 = tuning.gridDepth;
                            phi_6210_ = (_e618 < (bitcast<i32>(_e620) - 1i));
                        }
                        let _e625 = phi_6210_;
                        if _e625 {
                            let _e626 = targetPos;
                            param_360 = _e626;
                            let _e627 = getIndex_u0028_vi3_u003b((&param_360));
                            param_361 = _e627;
                            let _e628 = readCell_u0028_u1_u003b((&param_361));
                            param_362 = _e628;
                            let _e629 = getType_u0028_u1_u003b((&param_362));
                            if (_e629 == 0u) {
                                let _e631 = targetPos;
                                param_363 = _e631;
                                let _e632 = getIndex_u0028_vi3_u003b((&param_363));
                                let _e633 = d_8;
                                let _e636 = newType_2;
                                param_364 = _e636;
                                param_365 = bitcast<u32>((_e633 + 1i));
                                param_366 = 0u;
                                let _e637 = coolness_2;
                                param_367 = _e637;
                                let _e638 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_364), (&param_365), (&param_366), (&param_367));
                                let _e639 = (*currentIndex_5);
                                param_368 = _e639;
                                let _e640 = (*rawValue_4);
                                param_369 = _e640;
                                param_370 = _e632;
                                param_371 = _e638;
                                let _e641 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_368), (&param_369), (&param_370), (&param_371));
                                if _e641 {
                                    return;
                                }
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e642 = i_9;
                        i_9 = (_e642 + 1i);
                    }
                }
            }
        }
    }
    let _e644 = (*currentSleep_1);
    newSleep = min((_e644 + 1u), 255u);
    let _e647 = (*currentIndex_5);
    let _e650 = (*rawValue_4);
    let _e651 = newType_2;
    param_372 = _e651;
    let _e652 = (*currentDir_2);
    param_373 = _e652;
    let _e653 = newSleep;
    param_374 = _e653;
    let _e654 = coolness_2;
    param_375 = _e654;
    let _e655 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_372), (&param_373), (&param_374), (&param_375));
    let _e656 = atomicCompareExchangeWeak((&unnamed.grid[_e647]), _e650, _e655);
    return;
}

fn getCloudMoved_u0028_u1_u003b(v_2: ptr<function, u32>) -> bool {
    let _e201 = (*v_2);
    return ((_e201 & 4u) != 0u);
}

fn getCloudKind_u0028_u1_u003b(v_3: ptr<function, u32>) -> u32 {
    let _e201 = (*v_3);
    return (_e201 & 3u);
}

fn cloudIsAtRest_u0028_u1_u003b(v_4: ptr<function, u32>) -> bool {
    var param_376: u32;
    var param_377: u32;
    var phi_726_: bool;

    let _e203 = (*v_4);
    param_376 = _e203;
    let _e204 = getCloudKind_u0028_u1_u003b((&param_376));
    let _e205 = (_e204 != 0u);
    phi_726_ = _e205;
    if _e205 {
        let _e206 = (*v_4);
        param_377 = _e206;
        let _e207 = getCloudMoved_u0028_u1_u003b((&param_377));
        phi_726_ = !(_e207);
    }
    let _e210 = phi_726_;
    return _e210;
}

fn cloudCellInBounds_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> bool {
    var phi_585_: bool;
    var phi_591_: bool;
    var phi_601_: bool;
    var phi_607_: bool;
    var phi_617_: bool;

    let _e202 = (*p_3)[0u];
    let _e203 = (_e202 >= 1i);
    phi_585_ = _e203;
    if _e203 {
        let _e205 = (*p_3)[0u];
        let _e207 = tuning.gridWidth;
        phi_585_ = (_e205 < (bitcast<i32>(_e207) - 1i));
    }
    let _e212 = phi_585_;
    phi_591_ = _e212;
    if _e212 {
        let _e214 = (*p_3)[1u];
        phi_591_ = (_e214 >= 1i);
    }
    let _e217 = phi_591_;
    phi_601_ = _e217;
    if _e217 {
        let _e219 = (*p_3)[1u];
        let _e221 = tuning.gridHeight;
        phi_601_ = (_e219 < (bitcast<i32>(_e221) - 1i));
    }
    let _e226 = phi_601_;
    phi_607_ = _e226;
    if _e226 {
        let _e228 = (*p_3)[2u];
        phi_607_ = (_e228 >= 1i);
    }
    let _e231 = phi_607_;
    phi_617_ = _e231;
    if _e231 {
        let _e233 = (*p_3)[2u];
        let _e235 = tuning.gridDepth;
        phi_617_ = (_e233 < (bitcast<i32>(_e235) - 1i));
    }
    let _e240 = phi_617_;
    return _e240;
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
        let _e207 = i_10;
        if (_e207 < 6i) {
            let _e209 = (*pos_9);
            let _e210 = i_10;
            param_378 = _e210;
            let _e211 = getOrthoDir_u0028_i1_u003b((&param_378));
            n_1 = (_e209 + _e211);
            let _e213 = n_1;
            param_379 = _e213;
            let _e214 = cloudCellInBounds_u0028_vi3_u003b((&param_379));
            if !(_e214) {
                continue;
            }
            let _e216 = n_1;
            param_380 = _e216;
            let _e217 = getIndex_u0028_vi3_u003b((&param_380));
            let _e220 = atomicLoad((&unnamed_1.cloudCells[_e217]));
            param_381 = _e220;
            let _e221 = getCloudKind_u0028_u1_u003b((&param_381));
            if (_e221 == 2u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e223 = i_10;
            i_10 = (_e223 + 1i);
        }
    }
    return false;
}

fn packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b(kind: ptr<function, u32>, moved: ptr<function, bool>, counter: ptr<function, u32>, target_1: ptr<function, u32>) -> u32 {
    let _e204 = (*kind);
    let _e206 = (*moved);
    let _e209 = (*counter);
    let _e214 = (*target_1);
    return ((((_e204 & 3u) | select(0u, 4u, _e206)) | (min(_e209, 2047u) << bitcast<u32>(3i))) | (min(_e214, 2047u) << bitcast<u32>(14i)));
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
    var carried: u32;
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
    var phi_8421_: bool;
    var phi_8470_: bool;
    var phi_8476_: bool;
    var phi_8486_: bool;
    var phi_8492_: bool;
    var phi_8502_: bool;
    var phi_8528_: bool;
    var phi_8610_: bool;
    var phi_8628_: bool;
    var phi_8667_: bool;
    var phi_8673_: bool;
    var phi_8683_: bool;
    var phi_8764_: bool;
    var phi_8774_: bool;
    var phi_8780_: bool;
    var phi_8790_: bool;
    var phi_8816_: bool;

    let _e286 = (*pos_10)[1u];
    let _e288 = tuning.gridHeight;
    if (_e286 >= (bitcast<i32>(_e288) - 2i)) {
        let _e293 = unnamed_2.rainPhase;
        newKind = select(1u, 2u, (_e293 == 2u));
        let _e296 = (*currentIndex_6);
        let _e299 = newKind;
        param_382 = _e299;
        param_383 = false;
        param_384 = 0u;
        param_385 = 0u;
        let _e300 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_382), (&param_383), (&param_384), (&param_385));
        let _e301 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e296]), 0u, _e300);
        if (_e301.old_value == 0u) {
            let _e304 = (*currentIndex_6);
            let _e307 = atomicExchange((&unnamed.grid[_e304]), 0u);
            return;
        }
        let _e308 = (*currentIndex_6);
        let _e311 = atomicExchange((&unnamed.grid[_e308]), 0u);
        return;
    }
    let _e312 = (*currentAge_5);
    newAge = min((_e312 + 1u), 255u);
    let _e315 = (*currentSleep_2);
    let _e317 = tuning.steamCondenseTicks;
    if (_e315 >= _e317) {
        let _e320 = unnamed_2.rainPhase;
        let _e321 = (_e320 == 2u);
        phi_8421_ = _e321;
        if !(_e321) {
            let _e323 = (*pos_10);
            param_386 = _e323;
            let _e324 = cloudTouchesRain_u0028_vi3_u003b((&param_386));
            phi_8421_ = _e324;
        }
        let _e326 = phi_8421_;
        newKind_1 = select(1u, 2u, _e326);
        let _e328 = (*currentIndex_6);
        let _e331 = newKind_1;
        param_387 = _e331;
        param_388 = false;
        param_389 = 0u;
        param_390 = 0u;
        let _e332 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_387), (&param_388), (&param_389), (&param_390));
        let _e333 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e328]), 0u, _e332);
        let _e335 = (*currentIndex_6);
        let _e338 = atomicExchange((&unnamed.grid[_e335]), 0u);
        return;
    }
    let _e339 = (*randVal_7);
    let _e343 = tuning.steamScatterChance;
    if (fract((_e339 * 88f)) < _e343) {
        let _e345 = (*randVal_7);
        d_9 = i32((fract((_e345 * 13f)) * 6f));
        let _e350 = (*pos_10);
        let _e351 = d_9;
        param_391 = _e351;
        let _e352 = getOrthoDir_u0028_i1_u003b((&param_391));
        scatterPos = (_e350 + _e352);
        let _e355 = scatterPos[0u];
        let _e356 = (_e355 > 0i);
        phi_8470_ = _e356;
        if _e356 {
            let _e358 = scatterPos[0u];
            let _e360 = tuning.gridWidth;
            phi_8470_ = (_e358 < (bitcast<i32>(_e360) - 1i));
        }
        let _e365 = phi_8470_;
        phi_8476_ = _e365;
        if _e365 {
            let _e367 = scatterPos[1u];
            phi_8476_ = (_e367 > 0i);
        }
        let _e370 = phi_8476_;
        phi_8486_ = _e370;
        if _e370 {
            let _e372 = scatterPos[1u];
            let _e374 = tuning.gridHeight;
            phi_8486_ = (_e372 < (bitcast<i32>(_e374) - 1i));
        }
        let _e379 = phi_8486_;
        phi_8492_ = _e379;
        if _e379 {
            let _e381 = scatterPos[2u];
            phi_8492_ = (_e381 > 0i);
        }
        let _e384 = phi_8492_;
        phi_8502_ = _e384;
        if _e384 {
            let _e386 = scatterPos[2u];
            let _e388 = tuning.gridDepth;
            phi_8502_ = (_e386 < (bitcast<i32>(_e388) - 1i));
        }
        let _e393 = phi_8502_;
        if _e393 {
            let _e394 = scatterPos;
            param_392 = _e394;
            let _e395 = getIndex_u0028_vi3_u003b((&param_392));
            param_393 = _e395;
            let _e396 = readCell_u0028_u1_u003b((&param_393));
            param_394 = _e396;
            let _e397 = getType_u0028_u1_u003b((&param_394));
            sType = _e397;
            let _e398 = sType;
            let _e400 = sType;
            let _e402 = ((_e398 == 0u) || (_e400 == 5u));
            phi_8528_ = _e402;
            if _e402 {
                let _e403 = scatterPos;
                param_395 = _e403;
                let _e404 = getIndex_u0028_vi3_u003b((&param_395));
                let _e407 = atomicLoad((&unnamed_1.cloudCells[_e404]));
                param_396 = _e407;
                let _e408 = getCloudKind_u0028_u1_u003b((&param_396));
                phi_8528_ = (_e408 == 0u);
            }
            let _e411 = phi_8528_;
            if _e411 {
                let _e412 = (*currentSleep_2);
                carried = min((_e412 + 1u), 255u);
                let _e415 = scatterPos;
                param_397 = _e415;
                let _e416 = getIndex_u0028_vi3_u003b((&param_397));
                param_398 = 6u;
                param_399 = 0u;
                let _e417 = carried;
                param_400 = _e417;
                let _e418 = newAge;
                param_401 = _e418;
                let _e419 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_398), (&param_399), (&param_400), (&param_401));
                let _e420 = (*currentIndex_6);
                param_402 = _e420;
                let _e421 = (*rawValue_5);
                param_403 = _e421;
                param_404 = _e416;
                param_405 = _e419;
                let _e422 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_402), (&param_403), (&param_404), (&param_405));
                if _e422 {
                    return;
                }
            }
        }
    }
    let _e423 = (*pos_10);
    checkPos[0i] = (_e423 + vec3<i32>(0i, 1i, 0i));
    let _e426 = (*randVal_7);
    dir_1 = select(-1i, 1i, (fract((_e426 * 10f)) > 0.5f));
    let _e431 = (*randVal_7);
    if (fract((_e431 * 100f)) > 0.5f) {
        let _e435 = (*pos_10);
        let _e436 = dir_1;
        checkPos[1i] = (_e435 + vec3<i32>(_e436, 1i, 0i));
        let _e440 = (*pos_10);
        let _e441 = dir_1;
        checkPos[2i] = (_e440 + vec3<i32>(0i, 1i, _e441));
    } else {
        let _e445 = (*pos_10);
        let _e446 = dir_1;
        checkPos[1i] = (_e445 + vec3<i32>(0i, 1i, _e446));
        let _e450 = (*pos_10);
        let _e451 = dir_1;
        checkPos[2i] = (_e450 + vec3<i32>(_e451, 1i, 0i));
    }
    let _e455 = (*pos_10);
    upPos_1 = (_e455 + vec3<i32>(0i, 1i, 0i));
    let _e457 = upPos_1;
    param_406 = _e457;
    let _e458 = cloudCellInBounds_u0028_vi3_u003b((&param_406));
    phi_8610_ = _e458;
    if _e458 {
        let _e459 = upPos_1;
        param_407 = _e459;
        let _e460 = getIndex_u0028_vi3_u003b((&param_407));
        let _e463 = atomicLoad((&unnamed_1.cloudCells[_e460]));
        param_408 = _e463;
        let _e464 = cloudIsAtRest_u0028_u1_u003b((&param_408));
        phi_8610_ = _e464;
    }
    let _e466 = phi_8610_;
    underSettled = _e466;
    let _e467 = (*pos_10);
    param_409 = _e467;
    let _e468 = cloudTouchesRain_u0028_vi3_u003b((&param_409));
    touchingRain = _e468;
    let _e469 = underSettled;
    let _e470 = touchingRain;
    if (_e469 || _e470) {
        let _e472 = touchingRain;
        phi_8628_ = _e472;
        if !(_e472) {
            let _e475 = unnamed_2.rainPhase;
            phi_8628_ = (_e475 == 2u);
        }
        let _e478 = phi_8628_;
        newKind_2 = select(1u, 2u, _e478);
        let _e480 = (*currentIndex_6);
        let _e483 = newKind_2;
        param_410 = _e483;
        param_411 = false;
        param_412 = 0u;
        param_413 = 0u;
        let _e484 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_410), (&param_411), (&param_412), (&param_413));
        let _e485 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e480]), 0u, _e484);
        let _e487 = (*currentIndex_6);
        let _e490 = atomicExchange((&unnamed.grid[_e487]), 0u);
        return;
    }
    i_11 = 0i;
    loop {
        let _e491 = i_11;
        if (_e491 < 3i) {
            let _e493 = i_11;
            let _e495 = checkPos[_e493];
            cPos = _e495;
            let _e497 = cPos[0u];
            let _e498 = (_e497 > 0i);
            phi_8667_ = _e498;
            if _e498 {
                let _e500 = cPos[0u];
                let _e502 = tuning.gridWidth;
                phi_8667_ = (_e500 < (bitcast<i32>(_e502) - 1i));
            }
            let _e507 = phi_8667_;
            phi_8673_ = _e507;
            if _e507 {
                let _e509 = cPos[2u];
                phi_8673_ = (_e509 > 0i);
            }
            let _e512 = phi_8673_;
            phi_8683_ = _e512;
            if _e512 {
                let _e514 = cPos[2u];
                let _e516 = tuning.gridDepth;
                phi_8683_ = (_e514 < (bitcast<i32>(_e516) - 1i));
            }
            let _e521 = phi_8683_;
            if _e521 {
                let _e522 = cPos;
                param_414 = _e522;
                let _e523 = getIndex_u0028_vi3_u003b((&param_414));
                cIndex = _e523;
                let _e524 = cIndex;
                param_415 = _e524;
                let _e525 = readCell_u0028_u1_u003b((&param_415));
                cVal = _e525;
                let _e526 = cVal;
                param_416 = _e526;
                let _e527 = getType_u0028_u1_u003b((&param_416));
                cType = _e527;
                let _e528 = cType;
                let _e530 = cType;
                if ((_e528 == 1u) || (_e530 == 4u)) {
                    let _e533 = cVal;
                    param_417 = _e533;
                    let _e534 = getAge_u0028_u1_u003b((&param_417));
                    moisture_2 = _e534;
                    let _e535 = cType;
                    if (_e535 == 4u) {
                        let _e538 = tuning.dirtMoistureCapacity;
                        local_15 = _e538;
                    } else {
                        let _e540 = tuning.sandMoistureCapacity;
                        local_15 = _e540;
                    }
                    let _e541 = local_15;
                    capacity = _e541;
                    let _e542 = moisture_2;
                    let _e543 = capacity;
                    if (_e542 < _e543) {
                        let _e545 = (*currentIndex_6);
                        let _e548 = (*rawValue_5);
                        let _e549 = atomicCompareExchangeWeak((&unnamed.grid[_e545]), _e548, 0u);
                        let _e551 = (*rawValue_5);
                        if (_e549.old_value == _e551) {
                            let _e553 = cIndex;
                            let _e556 = atomicAdd((&unnamed.grid[_e553]), 16777216u);
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
            let _e557 = i_11;
            i_11 = (_e557 + 1i);
        }
    }
    i_12 = 0i;
    loop {
        let _e559 = i_12;
        if (_e559 < 3i) {
            let _e561 = i_12;
            let _e563 = checkPos[_e561];
            sPos_1 = _e563;
            let _e565 = sPos_1[1u];
            let _e567 = tuning.gridHeight;
            let _e570 = (_e565 < (bitcast<i32>(_e567) - 1i));
            phi_8764_ = _e570;
            if _e570 {
                let _e572 = sPos_1[0u];
                phi_8764_ = (_e572 > 0i);
            }
            let _e575 = phi_8764_;
            phi_8774_ = _e575;
            if _e575 {
                let _e577 = sPos_1[0u];
                let _e579 = tuning.gridWidth;
                phi_8774_ = (_e577 < (bitcast<i32>(_e579) - 1i));
            }
            let _e584 = phi_8774_;
            phi_8780_ = _e584;
            if _e584 {
                let _e586 = sPos_1[2u];
                phi_8780_ = (_e586 > 0i);
            }
            let _e589 = phi_8780_;
            phi_8790_ = _e589;
            if _e589 {
                let _e591 = sPos_1[2u];
                let _e593 = tuning.gridDepth;
                phi_8790_ = (_e591 < (bitcast<i32>(_e593) - 1i));
            }
            let _e598 = phi_8790_;
            if _e598 {
                let _e599 = sPos_1;
                param_418 = _e599;
                let _e600 = getIndex_u0028_vi3_u003b((&param_418));
                param_419 = _e600;
                let _e601 = readCell_u0028_u1_u003b((&param_419));
                param_420 = _e601;
                let _e602 = getType_u0028_u1_u003b((&param_420));
                sType_1 = _e602;
                let _e603 = sType_1;
                let _e605 = sType_1;
                let _e607 = ((_e603 == 0u) || (_e605 == 5u));
                phi_8816_ = _e607;
                if _e607 {
                    let _e608 = sPos_1;
                    param_421 = _e608;
                    let _e609 = getIndex_u0028_vi3_u003b((&param_421));
                    let _e612 = atomicLoad((&unnamed_1.cloudCells[_e609]));
                    param_422 = _e612;
                    let _e613 = getCloudKind_u0028_u1_u003b((&param_422));
                    phi_8816_ = (_e613 == 0u);
                }
                let _e616 = phi_8816_;
                if _e616 {
                    let _e617 = sPos_1;
                    param_423 = _e617;
                    let _e618 = getIndex_u0028_vi3_u003b((&param_423));
                    param_424 = 6u;
                    param_425 = 0u;
                    param_426 = 0u;
                    let _e619 = newAge;
                    param_427 = _e619;
                    let _e620 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_424), (&param_425), (&param_426), (&param_427));
                    let _e621 = (*currentIndex_6);
                    param_428 = _e621;
                    let _e622 = (*rawValue_5);
                    param_429 = _e622;
                    param_430 = _e618;
                    param_431 = _e620;
                    let _e623 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_428), (&param_429), (&param_430), (&param_431));
                    if _e623 {
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e624 = i_12;
            i_12 = (_e624 + 1i);
        }
    }
    let _e626 = (*currentSleep_2);
    newSleep_1 = min((_e626 + 1u), 255u);
    let _e629 = (*currentIndex_6);
    let _e632 = (*rawValue_5);
    param_432 = 6u;
    param_433 = 0u;
    let _e633 = newSleep_1;
    param_434 = _e633;
    let _e634 = newAge;
    param_435 = _e634;
    let _e635 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_432), (&param_433), (&param_434), (&param_435));
    let _e636 = atomicCompareExchangeWeak((&unnamed.grid[_e629]), _e632, _e635);
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
    var phi_7718_: bool;
    var phi_7724_: bool;
    var phi_7734_: bool;
    var phi_7740_: bool;
    var phi_7750_: bool;
    var phi_8058_: bool;
    var phi_8064_: bool;
    var phi_8074_: bool;

    let _e293 = (*currentAge_6);
    newAge_1 = (_e293 + 1u);
    isBurningGrass = false;
    i_13 = 0i;
    loop {
        let _e295 = i_13;
        if (_e295 < 6i) {
            let _e297 = (*pos_11);
            let _e298 = i_13;
            param_436 = _e298;
            let _e299 = getOrthoDir_u0028_i1_u003b((&param_436));
            nPos_1 = (_e297 + _e299);
            let _e302 = nPos_1[0u];
            let _e303 = (_e302 > 0i);
            phi_7718_ = _e303;
            if _e303 {
                let _e305 = nPos_1[0u];
                let _e307 = tuning.gridWidth;
                phi_7718_ = (_e305 < (bitcast<i32>(_e307) - 1i));
            }
            let _e312 = phi_7718_;
            phi_7724_ = _e312;
            if _e312 {
                let _e314 = nPos_1[1u];
                phi_7724_ = (_e314 > 0i);
            }
            let _e317 = phi_7724_;
            phi_7734_ = _e317;
            if _e317 {
                let _e319 = nPos_1[1u];
                let _e321 = tuning.gridHeight;
                phi_7734_ = (_e319 < (bitcast<i32>(_e321) - 1i));
            }
            let _e326 = phi_7734_;
            phi_7740_ = _e326;
            if _e326 {
                let _e328 = nPos_1[2u];
                phi_7740_ = (_e328 > 0i);
            }
            let _e331 = phi_7740_;
            phi_7750_ = _e331;
            if _e331 {
                let _e333 = nPos_1[2u];
                let _e335 = tuning.gridDepth;
                phi_7750_ = (_e333 < (bitcast<i32>(_e335) - 1i));
            }
            let _e340 = phi_7750_;
            if _e340 {
                let _e341 = nPos_1;
                param_437 = _e341;
                let _e342 = getIndex_u0028_vi3_u003b((&param_437));
                nIndex_1 = _e342;
                let _e343 = nIndex_1;
                param_438 = _e343;
                let _e344 = readCell_u0028_u1_u003b((&param_438));
                nVal_1 = _e344;
                let _e345 = nVal_1;
                param_439 = _e345;
                let _e346 = getType_u0028_u1_u003b((&param_439));
                if (_e346 == 2u) {
                    let _e348 = nIndex_1;
                    let _e351 = nVal_1;
                    param_440 = 6u;
                    param_441 = 0u;
                    param_442 = 0u;
                    param_443 = 0u;
                    let _e352 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_440), (&param_441), (&param_442), (&param_443));
                    let _e353 = atomicCompareExchangeWeak((&unnamed.grid[_e348]), _e351, _e352);
                    let _e355 = nVal_1;
                    if (_e353.old_value == _e355) {
                        decWater_u0028_();
                        let _e357 = (*currentIndex_7);
                        let _e360 = atomicExchange((&unnamed.grid[_e357]), 0u);
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e361 = i_13;
            i_13 = (_e361 + 1i);
        }
    }
    let _e363 = (*randVal_8);
    burnRoll = fract((_e363 * 47f));
    let _e366 = burnRoll;
    let _e368 = tuning.treeLeafBurnChance;
    let _e370 = tuning.treeTrunkBurnChance;
    if (_e366 < max(_e368, _e370)) {
        let _e373 = (*randVal_8);
        start_6 = i32((fract((_e373 * 31f)) * 26f));
        i_14 = 0i;
        loop {
            let _e378 = i_14;
            if (_e378 < 26i) {
                let _e380 = (*pos_11);
                let _e381 = start_6;
                let _e382 = i_14;
                let _e383 = (_e381 + _e382);
                param_444 = (_e383 - (i32(floor((f32(_e383) / f32(26i)))) * 26i));
                let _e391 = tree26_u0028_i1_u003b((&param_444));
                nPos_2 = (_e380 + _e391);
                let _e393 = nPos_2;
                param_445 = _e393;
                let _e394 = treeInBounds_u0028_vi3_u003b((&param_445));
                if !(_e394) {
                    continue;
                }
                let _e396 = nPos_2;
                param_446 = _e396;
                let _e397 = getIndex_u0028_vi3_u003b((&param_446));
                nIndex_2 = _e397;
                let _e398 = nIndex_2;
                param_447 = _e398;
                let _e399 = readCell_u0028_u1_u003b((&param_447));
                nVal_2 = _e399;
                let _e400 = nVal_2;
                param_448 = _e400;
                let _e401 = getType_u0028_u1_u003b((&param_448));
                nType_1 = _e401;
                let _e402 = nType_1;
                let _e404 = nType_1;
                if ((_e402 != 19u) && (_e404 != 18u)) {
                    continue;
                }
                let _e407 = nType_1;
                if (_e407 == 19u) {
                    let _e410 = tuning.treeLeafBurnChance;
                    local_16 = _e410;
                } else {
                    let _e412 = tuning.treeTrunkBurnChance;
                    local_16 = _e412;
                }
                let _e413 = local_16;
                need_1 = _e413;
                let _e414 = burnRoll;
                let _e415 = need_1;
                if (_e414 < _e415) {
                    let _e417 = nIndex_2;
                    let _e420 = nVal_2;
                    param_449 = 5u;
                    param_450 = 0u;
                    param_451 = 0u;
                    param_452 = 0u;
                    let _e421 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_449), (&param_450), (&param_451), (&param_452));
                    let _e422 = atomicCompareExchangeWeak((&unnamed.grid[_e417]), _e420, _e421);
                }
                break;
            } else {
                break;
            }
            continuing {
                let _e424 = i_14;
                i_14 = (_e424 + 1i);
            }
        }
    }
    let _e427 = (*pos_11)[1u];
    if (_e427 > 1i) {
        let _e429 = (*pos_11);
        belowPos_4 = (_e429 + vec3<i32>(0i, -1i, 0i));
        let _e431 = belowPos_4;
        param_453 = _e431;
        let _e432 = getIndex_u0028_vi3_u003b((&param_453));
        belowIndex_1 = _e432;
        let _e433 = belowIndex_1;
        param_454 = _e433;
        let _e434 = readCell_u0028_u1_u003b((&param_454));
        belowValue_1 = _e434;
        let _e435 = belowValue_1;
        param_455 = _e435;
        let _e436 = getType_u0028_u1_u003b((&param_455));
        belowType = _e436;
        let _e437 = belowType;
        if (_e437 == 0u) {
            param_456 = 5u;
            param_457 = 0u;
            param_458 = 0u;
            let _e439 = newAge_1;
            param_459 = _e439;
            let _e440 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_456), (&param_457), (&param_458), (&param_459));
            let _e441 = (*currentIndex_7);
            param_460 = _e441;
            let _e442 = (*rawValue_6);
            param_461 = _e442;
            let _e443 = belowIndex_1;
            param_462 = _e443;
            param_463 = _e440;
            let _e444 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_460), (&param_461), (&param_462), (&param_463));
            if _e444 {
                return;
            }
        } else {
            let _e445 = belowType;
            if (_e445 == 2u) {
                let _e447 = (*currentIndex_7);
                let _e450 = atomicExchange((&unnamed.grid[_e447]), 0u);
                return;
            } else {
                let _e451 = belowType;
                if (_e451 == 1u) {
                    let _e453 = belowValue_1;
                    param_464 = _e453;
                    let _e454 = getAge_u0028_u1_u003b((&param_464));
                    moisture_3 = _e454;
                    let _e455 = moisture_3;
                    if (_e455 > 0u) {
                        let _e457 = moisture_3;
                        let _e459 = tuning.fireDryRate;
                        if (_e457 > _e459) {
                            let _e461 = moisture_3;
                            let _e463 = tuning.fireDryRate;
                            local_17 = (_e461 - _e463);
                        } else {
                            local_17 = 0u;
                        }
                        let _e465 = local_17;
                        newMoisture = _e465;
                        let _e466 = belowValue_1;
                        param_465 = _e466;
                        let _e467 = getDir_u0028_u1_u003b((&param_465));
                        param_466 = 1u;
                        param_467 = _e467;
                        param_468 = 0u;
                        let _e468 = newMoisture;
                        param_469 = _e468;
                        let _e469 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_466), (&param_467), (&param_468), (&param_469));
                        newVal = _e469;
                        let _e470 = belowIndex_1;
                        let _e473 = belowValue_1;
                        let _e474 = newVal;
                        let _e475 = atomicCompareExchangeWeak((&unnamed.grid[_e470]), _e473, _e474);
                        let _e477 = belowValue_1;
                        if (_e475.old_value == _e477) {
                            let _e479 = (*currentIndex_7);
                            let _e482 = atomicExchange((&unnamed.grid[_e479]), 0u);
                            return;
                        }
                    }
                } else {
                    let _e483 = belowType;
                    if (_e483 == 4u) {
                        let _e485 = belowValue_1;
                        flora_3 = ((_e485 >> bitcast<u32>(8i)) & 255u);
                        let _e489 = flora_3;
                        let _e491 = flora_3;
                        if ((_e489 > 10u) && (_e491 <= 100u)) {
                            isBurningGrass = true;
                            newAge_1 = 0u;
                            let _e494 = (*randVal_8);
                            let _e498 = tuning.fireBurnGrassChance;
                            if (fract((_e494 * 100f)) < _e498) {
                                let _e500 = flora_3;
                                newFlora = (_e500 - 1u);
                                let _e502 = belowValue_1;
                                param_470 = _e502;
                                let _e503 = getAge_u0028_u1_u003b((&param_470));
                                param_471 = 4u;
                                let _e504 = newFlora;
                                param_472 = _e504;
                                param_473 = 0u;
                                param_474 = _e503;
                                let _e505 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_471), (&param_472), (&param_473), (&param_474));
                                newVal_1 = _e505;
                                let _e506 = belowIndex_1;
                                let _e509 = belowValue_1;
                                let _e510 = newVal_1;
                                let _e511 = atomicCompareExchangeWeak((&unnamed.grid[_e506]), _e509, _e510);
                            }
                            let _e513 = (*randVal_8);
                            let _e517 = tuning.fireSpreadChance;
                            if (fract((_e513 * 100f)) < _e517) {
                                let _e519 = (*randVal_8);
                                d_10 = i32((fract((_e519 * 10f)) * 8f));
                                let _e524 = (*pos_11);
                                let _e525 = d_10;
                                param_475 = _e525;
                                let _e526 = getHDir_u0028_i1_u003b((&param_475));
                                targetPos_1 = (_e524 + _e526);
                                let _e529 = targetPos_1[0u];
                                let _e530 = (_e529 > 0i);
                                phi_8058_ = _e530;
                                if _e530 {
                                    let _e532 = targetPos_1[0u];
                                    let _e534 = tuning.gridWidth;
                                    phi_8058_ = (_e532 < (bitcast<i32>(_e534) - 1i));
                                }
                                let _e539 = phi_8058_;
                                phi_8064_ = _e539;
                                if _e539 {
                                    let _e541 = targetPos_1[2u];
                                    phi_8064_ = (_e541 > 0i);
                                }
                                let _e544 = phi_8064_;
                                phi_8074_ = _e544;
                                if _e544 {
                                    let _e546 = targetPos_1[2u];
                                    let _e548 = tuning.gridDepth;
                                    phi_8074_ = (_e546 < (bitcast<i32>(_e548) - 1i));
                                }
                                let _e553 = phi_8074_;
                                if _e553 {
                                    let _e554 = targetPos_1;
                                    param_476 = _e554;
                                    let _e555 = getIndex_u0028_vi3_u003b((&param_476));
                                    targetIndex_1 = _e555;
                                    let _e556 = targetIndex_1;
                                    param_477 = _e556;
                                    let _e557 = readCell_u0028_u1_u003b((&param_477));
                                    param_478 = _e557;
                                    let _e558 = getType_u0028_u1_u003b((&param_478));
                                    if (_e558 == 0u) {
                                        let _e560 = targetPos_1;
                                        targetBelow = (_e560 + vec3<i32>(0i, -1i, 0i));
                                        let _e562 = targetBelow;
                                        param_479 = _e562;
                                        let _e563 = getIndex_u0028_vi3_u003b((&param_479));
                                        param_480 = _e563;
                                        let _e564 = readCell_u0028_u1_u003b((&param_480));
                                        tBelowVal = _e564;
                                        let _e565 = tBelowVal;
                                        param_481 = _e565;
                                        let _e566 = getType_u0028_u1_u003b((&param_481));
                                        if (_e566 == 4u) {
                                            let _e568 = tBelowVal;
                                            tFlora = ((_e568 >> bitcast<u32>(8i)) & 255u);
                                            let _e572 = tFlora;
                                            let _e574 = tFlora;
                                            if ((_e572 > 10u) && (_e574 <= 100u)) {
                                                let _e577 = targetIndex_1;
                                                param_482 = 5u;
                                                param_483 = 0u;
                                                param_484 = 0u;
                                                param_485 = 0u;
                                                let _e580 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_482), (&param_483), (&param_484), (&param_485));
                                                let _e581 = atomicCompareExchangeWeak((&unnamed.grid[_e577]), 0u, _e580);
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
    let _e583 = newAge_1;
    let _e585 = tuning.fireLifetime;
    if (_e583 > _e585) {
        let _e587 = (*currentIndex_7);
        let _e590 = atomicExchange((&unnamed.grid[_e587]), 0u);
        return;
    }
    let _e591 = (*currentIndex_7);
    let _e594 = (*rawValue_6);
    param_486 = 5u;
    param_487 = 0u;
    param_488 = 0u;
    let _e595 = newAge_1;
    param_489 = _e595;
    let _e596 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_486), (&param_487), (&param_488), (&param_489));
    let _e597 = atomicCompareExchangeWeak((&unnamed.grid[_e591]), _e594, _e596);
    return;
}

fn isLocust_u0028_u1_u003b(type_36: ptr<function, u32>) -> bool {
    let _e201 = (*type_36);
    let _e203 = (*type_36);
    return ((_e201 >= 13u) && (_e203 <= 17u));
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

    let _e213 = (*currentIndex_8);
    let _e216 = (*currentValue_1);
    let _e217 = atomicCompareExchangeWeak((&unnamed.grid[_e213]), _e216, 0u);
    let _e219 = (*currentValue_1);
    if (_e217.old_value == _e219) {
        let _e221 = (*targetValue_1);
        param_490 = _e221;
        let _e222 = getType_u0028_u1_u003b((&param_490));
        param_491 = _e222;
        param_492 = 0u;
        param_493 = 0u;
        param_494 = 0u;
        let _e223 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_491), (&param_492), (&param_493), (&param_494));
        displacedValue = _e223;
        let _e224 = (*pushIndex);
        let _e227 = displacedValue;
        let _e228 = atomicCompareExchangeWeak((&unnamed.grid[_e224]), 0u, _e227);
        actualPush = _e228.old_value;
        let _e230 = actualPush;
        if (_e230 == 0u) {
            let _e232 = (*targetIndex_2);
            let _e235 = (*targetValue_1);
            let _e236 = (*currentValue_1);
            let _e237 = atomicCompareExchangeWeak((&unnamed.grid[_e232]), _e235, _e236);
            actualTarget = _e237.old_value;
            let _e239 = actualTarget;
            let _e240 = (*targetValue_1);
            if (_e239 == _e240) {
                return true;
            } else {
                let _e242 = (*pushIndex);
                let _e245 = displacedValue;
                let _e246 = atomicCompareExchangeWeak((&unnamed.grid[_e242]), _e245, 0u);
            }
        }
        let _e248 = (*currentIndex_8);
        let _e251 = (*currentValue_1);
        let _e252 = atomicCompareExchangeWeak((&unnamed.grid[_e248]), 0u, _e251);
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
    var phi_2392_: bool;
    var phi_2399_: bool;
    var phi_2410_: bool;

    let _e210 = (*pos_12)[1u];
    if (_e210 <= 1i) {
        return false;
    }
    i_15 = 0i;
    loop {
        let _e212 = i_15;
        if (_e212 < 5i) {
            let _e214 = (*pos_12);
            let _e215 = i_15;
            if (_e215 == 1i) {
                local_18 = 1i;
            } else {
                let _e217 = i_15;
                local_18 = select(0i, -1i, (_e217 == 2i));
            }
            let _e220 = local_18;
            let _e221 = i_15;
            if (_e221 == 3i) {
                local_19 = 1i;
            } else {
                let _e223 = i_15;
                local_19 = select(0i, -1i, (_e223 == 4i));
            }
            let _e226 = local_19;
            target_2 = (_e214 + vec3<i32>(_e220, -1i, _e226));
            let _e230 = target_2[0u];
            let _e231 = (_e230 <= 0i);
            phi_2392_ = _e231;
            if !(_e231) {
                let _e234 = target_2[0u];
                let _e236 = tuning.gridWidth;
                phi_2392_ = (_e234 >= (bitcast<i32>(_e236) - 1i));
            }
            let _e241 = phi_2392_;
            phi_2399_ = _e241;
            if !(_e241) {
                let _e244 = target_2[2u];
                phi_2399_ = (_e244 <= 0i);
            }
            let _e247 = phi_2399_;
            phi_2410_ = _e247;
            if !(_e247) {
                let _e250 = target_2[2u];
                let _e252 = tuning.gridDepth;
                phi_2410_ = (_e250 >= (bitcast<i32>(_e252) - 1i));
            }
            let _e257 = phi_2410_;
            if _e257 {
                continue;
            }
            let _e258 = target_2;
            param_495 = _e258;
            let _e259 = getIndex_u0028_vi3_u003b((&param_495));
            param_496 = _e259;
            let _e260 = readCell_u0028_u1_u003b((&param_496));
            param_497 = _e260;
            let _e261 = getType_u0028_u1_u003b((&param_497));
            t_3 = _e261;
            let _e262 = t_3;
            let _e264 = t_3;
            if ((_e262 == 0u) || (_e264 == 2u)) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e267 = i_15;
            i_15 = (_e267 + 1i);
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
    var phi_3521_: bool;
    var phi_3527_: bool;
    var phi_3537_: bool;
    var phi_3543_: bool;
    var phi_3553_: bool;
    var phi_3619_: bool;
    var phi_3625_: bool;
    var phi_3635_: bool;
    var phi_3641_: bool;
    var phi_3651_: bool;
    var phi_3721_: bool;
    var phi_3763_: bool;
    var phi_3769_: bool;
    var phi_3778_: bool;
    var phi_3859_: bool;
    var phi_3865_: bool;
    var phi_3874_: bool;
    var phi_3880_: bool;
    var phi_3889_: bool;
    var phi_4008_: bool;
    var phi_4014_: bool;
    var phi_4024_: bool;
    var phi_4068_: bool;
    var phi_4074_: bool;
    var phi_4084_: bool;
    var phi_4175_: bool;
    var phi_4181_: bool;
    var phi_4191_: bool;
    var phi_4292_: bool;
    var phi_4298_: bool;
    var phi_4308_: bool;
    var phi_4365_: bool;
    var phi_4371_: bool;
    var phi_4381_: bool;
    var phi_4436_: bool;
    var phi_4510_: bool;
    var phi_4565_: bool;

    let _e370 = (*currentAge_7);
    moisture_4 = _e370;
    moistureModified = false;
    let _e371 = moisture_4;
    let _e373 = tuning.dirtMoistureCapacity;
    if (_e371 < _e373) {
        let _e375 = (*randVal_9);
        startDir_1 = i32((fract((_e375 * 17f)) * 6f));
        i_16 = 0i;
        loop {
            let _e380 = i_16;
            if (_e380 < 6i) {
                let _e382 = startDir_1;
                let _e383 = i_16;
                let _e384 = (_e382 + _e383);
                d_11 = (_e384 - (i32(floor((f32(_e384) / f32(6i)))) * 6i));
                let _e392 = (*pos_13);
                let _e393 = d_11;
                param_498 = _e393;
                let _e394 = getOrthoDir_u0028_i1_u003b((&param_498));
                nPos_3 = (_e392 + _e394);
                let _e397 = nPos_3[0u];
                let _e398 = (_e397 > 0i);
                phi_3521_ = _e398;
                if _e398 {
                    let _e400 = nPos_3[0u];
                    let _e402 = tuning.gridWidth;
                    phi_3521_ = (_e400 < (bitcast<i32>(_e402) - 1i));
                }
                let _e407 = phi_3521_;
                phi_3527_ = _e407;
                if _e407 {
                    let _e409 = nPos_3[1u];
                    phi_3527_ = (_e409 > 0i);
                }
                let _e412 = phi_3527_;
                phi_3537_ = _e412;
                if _e412 {
                    let _e414 = nPos_3[1u];
                    let _e416 = tuning.gridHeight;
                    phi_3537_ = (_e414 < (bitcast<i32>(_e416) - 1i));
                }
                let _e421 = phi_3537_;
                phi_3543_ = _e421;
                if _e421 {
                    let _e423 = nPos_3[2u];
                    phi_3543_ = (_e423 > 0i);
                }
                let _e426 = phi_3543_;
                phi_3553_ = _e426;
                if _e426 {
                    let _e428 = nPos_3[2u];
                    let _e430 = tuning.gridDepth;
                    phi_3553_ = (_e428 < (bitcast<i32>(_e430) - 1i));
                }
                let _e435 = phi_3553_;
                if _e435 {
                    let _e436 = nPos_3;
                    param_499 = _e436;
                    let _e437 = getIndex_u0028_vi3_u003b((&param_499));
                    nIndex_3 = _e437;
                    let _e438 = nIndex_3;
                    param_500 = _e438;
                    let _e439 = readCell_u0028_u1_u003b((&param_500));
                    nVal_3 = _e439;
                    let _e440 = nVal_3;
                    param_501 = _e440;
                    let _e441 = getType_u0028_u1_u003b((&param_501));
                    if (_e441 == 2u) {
                        let _e443 = nIndex_3;
                        let _e446 = nVal_3;
                        let _e447 = atomicCompareExchangeWeak((&unnamed.grid[_e443]), _e446, 0u);
                        let _e449 = nVal_3;
                        if (_e447.old_value == _e449) {
                            let _e451 = (*currentIndex_9);
                            let _e455 = tuning.sandWaterAbsorbUnit;
                            let _e458 = atomicAdd((&unnamed.grid[_e451]), (_e455 << bitcast<u32>(24i)));
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
                let _e459 = i_16;
                i_16 = (_e459 + 1i);
            }
        }
    }
    let _e461 = moistureModified;
    let _e463 = moisture_4;
    if (!(_e461) && (_e463 > 0u)) {
        let _e466 = (*randVal_9);
        d_12 = i32((fract((_e466 * 31f)) * 6f));
        let _e471 = (*pos_13);
        let _e472 = d_12;
        param_502 = _e472;
        let _e473 = getOrthoDir_u0028_i1_u003b((&param_502));
        nPos_4 = (_e471 + _e473);
        let _e476 = nPos_4[0u];
        let _e477 = (_e476 > 0i);
        phi_3619_ = _e477;
        if _e477 {
            let _e479 = nPos_4[0u];
            let _e481 = tuning.gridWidth;
            phi_3619_ = (_e479 < (bitcast<i32>(_e481) - 1i));
        }
        let _e486 = phi_3619_;
        phi_3625_ = _e486;
        if _e486 {
            let _e488 = nPos_4[1u];
            phi_3625_ = (_e488 > 0i);
        }
        let _e491 = phi_3625_;
        phi_3635_ = _e491;
        if _e491 {
            let _e493 = nPos_4[1u];
            let _e495 = tuning.gridHeight;
            phi_3635_ = (_e493 < (bitcast<i32>(_e495) - 1i));
        }
        let _e500 = phi_3635_;
        phi_3641_ = _e500;
        if _e500 {
            let _e502 = nPos_4[2u];
            phi_3641_ = (_e502 > 0i);
        }
        let _e505 = phi_3641_;
        phi_3651_ = _e505;
        if _e505 {
            let _e507 = nPos_4[2u];
            let _e509 = tuning.gridDepth;
            phi_3651_ = (_e507 < (bitcast<i32>(_e509) - 1i));
        }
        let _e514 = phi_3651_;
        if _e514 {
            let _e515 = nPos_4;
            param_503 = _e515;
            let _e516 = getIndex_u0028_vi3_u003b((&param_503));
            nIndex_4 = _e516;
            let _e517 = nIndex_4;
            param_504 = _e517;
            let _e518 = readCell_u0028_u1_u003b((&param_504));
            nVal_4 = _e518;
            let _e519 = nVal_4;
            param_505 = _e519;
            let _e520 = getType_u0028_u1_u003b((&param_505));
            nType_2 = _e520;
            let _e521 = nType_2;
            let _e523 = nType_2;
            if ((_e521 == 4u) || (_e523 == 1u)) {
                let _e526 = nVal_4;
                param_506 = _e526;
                let _e527 = getAge_u0028_u1_u003b((&param_506));
                nMoisture = _e527;
                let _e528 = nType_2;
                if (_e528 == 4u) {
                    let _e531 = tuning.dirtMoistureCapacity;
                    local_20 = _e531;
                } else {
                    let _e533 = tuning.sandMoistureCapacity;
                    local_20 = _e533;
                }
                let _e534 = local_20;
                nCapacity = _e534;
                let _e535 = moisture_4;
                let _e536 = nMoisture;
                let _e539 = nMoisture;
                let _e540 = nCapacity;
                if ((_e535 > (_e536 + 1u)) && (_e539 < _e540)) {
                    let _e543 = (*currentIndex_9);
                    let _e546 = atomicAdd((&unnamed.grid[_e543]), 4278190080u);
                    let _e547 = nIndex_4;
                    let _e550 = atomicAdd((&unnamed.grid[_e547]), 16777216u);
                    moistureModified = true;
                }
            }
        }
    }
    let _e551 = moistureModified;
    if _e551 {
        return;
    }
    let _e552 = (*pos_13);
    param_507 = _e552;
    let _e553 = grainCanMove_u0028_vi3_u003b((&param_507));
    canMove = _e553;
    isClumped = false;
    let _e554 = canMove;
    phi_3721_ = _e554;
    if _e554 {
        let _e555 = (*currentSleep_4);
        let _e557 = tuning.wakeSleepThreshold;
        phi_3721_ = (_e555 > _e557);
    }
    let _e560 = phi_3721_;
    if _e560 {
        emptyBelowCount = 0i;
        let _e562 = (*pos_13)[1u];
        if (_e562 > 1i) {
            x = -1i;
            loop {
                let _e564 = x;
                if (_e564 <= 1i) {
                    z = -1i;
                    loop {
                        let _e566 = z;
                        if (_e566 <= 1i) {
                            let _e568 = (*pos_13);
                            let _e569 = x;
                            let _e570 = z;
                            checkPos_1 = (_e568 + vec3<i32>(_e569, -1i, _e570));
                            let _e574 = checkPos_1[0u];
                            let _e575 = (_e574 >= 0i);
                            phi_3763_ = _e575;
                            if _e575 {
                                let _e577 = checkPos_1[0u];
                                let _e579 = tuning.gridWidth;
                                phi_3763_ = (_e577 < bitcast<i32>(_e579));
                            }
                            let _e583 = phi_3763_;
                            phi_3769_ = _e583;
                            if _e583 {
                                let _e585 = checkPos_1[2u];
                                phi_3769_ = (_e585 >= 0i);
                            }
                            let _e588 = phi_3769_;
                            phi_3778_ = _e588;
                            if _e588 {
                                let _e590 = checkPos_1[2u];
                                let _e592 = tuning.gridDepth;
                                phi_3778_ = (_e590 < bitcast<i32>(_e592));
                            }
                            let _e596 = phi_3778_;
                            if _e596 {
                                let _e597 = checkPos_1;
                                param_508 = _e597;
                                let _e598 = getIndex_u0028_vi3_u003b((&param_508));
                                param_509 = _e598;
                                let _e599 = readCell_u0028_u1_u003b((&param_509));
                                param_510 = _e599;
                                let _e600 = getType_u0028_u1_u003b((&param_510));
                                if (_e600 == 0u) {
                                    let _e602 = emptyBelowCount;
                                    emptyBelowCount = (_e602 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e604 = z;
                            z = (_e604 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e606 = x;
                    x = (_e606 + 1i);
                }
            }
        }
        let _e608 = emptyBelowCount;
        let _e610 = tuning.emptyBelowWakeCount;
        if (_e608 >= bitcast<i32>(_e610)) {
            (*currentSleep_4) = 0u;
        } else {
            clumpCount = 0i;
            x_1 = -1i;
            loop {
                let _e613 = x_1;
                if (_e613 <= 1i) {
                    y = -1i;
                    loop {
                        let _e615 = y;
                        if (_e615 <= 1i) {
                            z_1 = -1i;
                            loop {
                                let _e617 = z_1;
                                if (_e617 <= 1i) {
                                    let _e619 = x_1;
                                    let _e621 = y;
                                    let _e624 = z_1;
                                    if (((_e619 == 0i) && (_e621 == 0i)) && (_e624 == 0i)) {
                                        continue;
                                    }
                                    let _e627 = (*pos_13);
                                    let _e628 = x_1;
                                    let _e629 = y;
                                    let _e630 = z_1;
                                    nPos_5 = (_e627 + vec3<i32>(_e628, _e629, _e630));
                                    let _e634 = nPos_5[0u];
                                    let _e635 = (_e634 >= 0i);
                                    phi_3859_ = _e635;
                                    if _e635 {
                                        let _e637 = nPos_5[0u];
                                        let _e639 = tuning.gridWidth;
                                        phi_3859_ = (_e637 < bitcast<i32>(_e639));
                                    }
                                    let _e643 = phi_3859_;
                                    phi_3865_ = _e643;
                                    if _e643 {
                                        let _e645 = nPos_5[1u];
                                        phi_3865_ = (_e645 >= 0i);
                                    }
                                    let _e648 = phi_3865_;
                                    phi_3874_ = _e648;
                                    if _e648 {
                                        let _e650 = nPos_5[1u];
                                        let _e652 = tuning.gridHeight;
                                        phi_3874_ = (_e650 < bitcast<i32>(_e652));
                                    }
                                    let _e656 = phi_3874_;
                                    phi_3880_ = _e656;
                                    if _e656 {
                                        let _e658 = nPos_5[2u];
                                        phi_3880_ = (_e658 >= 0i);
                                    }
                                    let _e661 = phi_3880_;
                                    phi_3889_ = _e661;
                                    if _e661 {
                                        let _e663 = nPos_5[2u];
                                        let _e665 = tuning.gridDepth;
                                        phi_3889_ = (_e663 < bitcast<i32>(_e665));
                                    }
                                    let _e669 = phi_3889_;
                                    if _e669 {
                                        let _e670 = nPos_5;
                                        param_511 = _e670;
                                        let _e671 = getIndex_u0028_vi3_u003b((&param_511));
                                        param_512 = _e671;
                                        let _e672 = readCell_u0028_u1_u003b((&param_512));
                                        param_513 = _e672;
                                        let _e673 = getType_u0028_u1_u003b((&param_513));
                                        if (_e673 == 4u) {
                                            let _e675 = clumpCount;
                                            clumpCount = (_e675 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e677 = z_1;
                                    z_1 = (_e677 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e679 = y;
                            y = (_e679 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e681 = x_1;
                    x_1 = (_e681 + 1i);
                }
            }
            let _e683 = clumpCount;
            let _e685 = tuning.dirtClumpThreshold;
            if (_e683 >= bitcast<i32>(_e685)) {
                isClumped = true;
            }
        }
    }
    let _e688 = canMove;
    let _e689 = isClumped;
    if (_e688 && !(_e689)) {
        let _e693 = (*pos_13)[1u];
        if (_e693 > 1i) {
            let _e695 = (*pos_13);
            belowPos_5 = (_e695 + vec3<i32>(0i, -1i, 0i));
            let _e697 = belowPos_5;
            param_514 = _e697;
            let _e698 = getIndex_u0028_vi3_u003b((&param_514));
            param_515 = _e698;
            let _e699 = readCell_u0028_u1_u003b((&param_515));
            param_516 = _e699;
            let _e700 = getType_u0028_u1_u003b((&param_516));
            if (_e700 == 0u) {
                let _e702 = belowPos_5;
                param_517 = _e702;
                let _e703 = getIndex_u0028_vi3_u003b((&param_517));
                param_518 = 4u;
                param_519 = 0u;
                param_520 = 0u;
                let _e704 = moisture_4;
                param_521 = _e704;
                let _e705 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_518), (&param_519), (&param_520), (&param_521));
                let _e706 = (*currentIndex_9);
                param_522 = _e706;
                let _e707 = (*rawValue_7);
                param_523 = _e707;
                param_524 = _e703;
                param_525 = _e705;
                let _e708 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_522), (&param_523), (&param_524), (&param_525));
                if _e708 {
                    return;
                }
            }
        }
        let _e710 = (*pos_13)[1u];
        if (_e710 > 1i) {
            let _e712 = (*randVal_9);
            dir_2 = select(-1i, 1i, (fract((_e712 * 10f)) > 0.5f));
            let _e717 = (*randVal_9);
            if (fract((_e717 * 100f)) > 0.5f) {
                let _e721 = (*pos_13);
                let _e722 = dir_2;
                slidePos1_ = (_e721 + vec3<i32>(_e722, -1i, 0i));
                let _e725 = (*pos_13);
                let _e726 = dir_2;
                slidePos2_ = (_e725 + vec3<i32>(0i, -1i, _e726));
            } else {
                let _e729 = (*pos_13);
                let _e730 = dir_2;
                slidePos1_ = (_e729 + vec3<i32>(0i, -1i, _e730));
                let _e733 = (*pos_13);
                let _e734 = dir_2;
                slidePos2_ = (_e733 + vec3<i32>(_e734, -1i, 0i));
            }
            let _e738 = slidePos1_[0u];
            let _e739 = (_e738 > 0i);
            phi_4008_ = _e739;
            if _e739 {
                let _e741 = slidePos1_[0u];
                let _e743 = tuning.gridWidth;
                phi_4008_ = (_e741 < (bitcast<i32>(_e743) - 1i));
            }
            let _e748 = phi_4008_;
            phi_4014_ = _e748;
            if _e748 {
                let _e750 = slidePos1_[2u];
                phi_4014_ = (_e750 > 0i);
            }
            let _e753 = phi_4014_;
            phi_4024_ = _e753;
            if _e753 {
                let _e755 = slidePos1_[2u];
                let _e757 = tuning.gridDepth;
                phi_4024_ = (_e755 < (bitcast<i32>(_e757) - 1i));
            }
            let _e762 = phi_4024_;
            if _e762 {
                let _e763 = slidePos1_;
                param_526 = _e763;
                let _e764 = getIndex_u0028_vi3_u003b((&param_526));
                param_527 = _e764;
                let _e765 = readCell_u0028_u1_u003b((&param_527));
                param_528 = _e765;
                let _e766 = getType_u0028_u1_u003b((&param_528));
                if (_e766 == 0u) {
                    let _e768 = slidePos1_;
                    param_529 = _e768;
                    let _e769 = getIndex_u0028_vi3_u003b((&param_529));
                    param_530 = 4u;
                    param_531 = 0u;
                    param_532 = 0u;
                    let _e770 = moisture_4;
                    param_533 = _e770;
                    let _e771 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_530), (&param_531), (&param_532), (&param_533));
                    let _e772 = (*currentIndex_9);
                    param_534 = _e772;
                    let _e773 = (*rawValue_7);
                    param_535 = _e773;
                    param_536 = _e769;
                    param_537 = _e771;
                    let _e774 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_534), (&param_535), (&param_536), (&param_537));
                    if _e774 {
                        return;
                    }
                }
            }
            let _e776 = slidePos2_[0u];
            let _e777 = (_e776 > 0i);
            phi_4068_ = _e777;
            if _e777 {
                let _e779 = slidePos2_[0u];
                let _e781 = tuning.gridWidth;
                phi_4068_ = (_e779 < (bitcast<i32>(_e781) - 1i));
            }
            let _e786 = phi_4068_;
            phi_4074_ = _e786;
            if _e786 {
                let _e788 = slidePos2_[2u];
                phi_4074_ = (_e788 > 0i);
            }
            let _e791 = phi_4074_;
            phi_4084_ = _e791;
            if _e791 {
                let _e793 = slidePos2_[2u];
                let _e795 = tuning.gridDepth;
                phi_4084_ = (_e793 < (bitcast<i32>(_e795) - 1i));
            }
            let _e800 = phi_4084_;
            if _e800 {
                let _e801 = slidePos2_;
                param_538 = _e801;
                let _e802 = getIndex_u0028_vi3_u003b((&param_538));
                param_539 = _e802;
                let _e803 = readCell_u0028_u1_u003b((&param_539));
                param_540 = _e803;
                let _e804 = getType_u0028_u1_u003b((&param_540));
                if (_e804 == 0u) {
                    let _e806 = slidePos2_;
                    param_541 = _e806;
                    let _e807 = getIndex_u0028_vi3_u003b((&param_541));
                    param_542 = 4u;
                    param_543 = 0u;
                    param_544 = 0u;
                    let _e808 = moisture_4;
                    param_545 = _e808;
                    let _e809 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_542), (&param_543), (&param_544), (&param_545));
                    let _e810 = (*currentIndex_9);
                    param_546 = _e810;
                    let _e811 = (*rawValue_7);
                    param_547 = _e811;
                    param_548 = _e807;
                    param_549 = _e809;
                    let _e812 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_546), (&param_547), (&param_548), (&param_549));
                    if _e812 {
                        return;
                    }
                }
            }
        }
        let _e814 = (*pos_13)[1u];
        if (_e814 > 1i) {
            let _e816 = (*pos_13);
            belowPos_6 = (_e816 + vec3<i32>(0i, -1i, 0i));
            let _e818 = belowPos_6;
            param_550 = _e818;
            let _e819 = getIndex_u0028_vi3_u003b((&param_550));
            belowIndex_2 = _e819;
            let _e820 = belowIndex_2;
            param_551 = _e820;
            let _e821 = readCell_u0028_u1_u003b((&param_551));
            belowValue_2 = _e821;
            let _e822 = belowValue_2;
            param_552 = _e822;
            let _e823 = getType_u0028_u1_u003b((&param_552));
            if (_e823 == 2u) {
                let _e825 = (*randVal_9);
                startDir_2 = i32((fract((_e825 * 8f)) * 8f));
                i_17 = 0i;
                loop {
                    let _e830 = i_17;
                    if (_e830 < 8i) {
                        let _e832 = startDir_2;
                        let _e833 = i_17;
                        let _e834 = (_e832 + _e833);
                        d_13 = (_e834 - (i32(floor((f32(_e834) / f32(8i)))) * 8i));
                        let _e842 = belowPos_6;
                        let _e843 = d_13;
                        param_553 = _e843;
                        let _e844 = getHDir_u0028_i1_u003b((&param_553));
                        pushPos = (_e842 + _e844);
                        let _e847 = pushPos[0u];
                        let _e848 = (_e847 > 0i);
                        phi_4175_ = _e848;
                        if _e848 {
                            let _e850 = pushPos[0u];
                            let _e852 = tuning.gridWidth;
                            phi_4175_ = (_e850 < (bitcast<i32>(_e852) - 1i));
                        }
                        let _e857 = phi_4175_;
                        phi_4181_ = _e857;
                        if _e857 {
                            let _e859 = pushPos[2u];
                            phi_4181_ = (_e859 > 0i);
                        }
                        let _e862 = phi_4181_;
                        phi_4191_ = _e862;
                        if _e862 {
                            let _e864 = pushPos[2u];
                            let _e866 = tuning.gridDepth;
                            phi_4191_ = (_e864 < (bitcast<i32>(_e866) - 1i));
                        }
                        let _e871 = phi_4191_;
                        if _e871 {
                            param_554 = 4u;
                            param_555 = 0u;
                            param_556 = 0u;
                            let _e872 = moisture_4;
                            param_557 = _e872;
                            let _e873 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_554), (&param_555), (&param_556), (&param_557));
                            let _e874 = pushPos;
                            param_558 = _e874;
                            let _e875 = getIndex_u0028_vi3_u003b((&param_558));
                            let _e876 = (*currentIndex_9);
                            param_559 = _e876;
                            param_560 = _e873;
                            let _e877 = belowIndex_2;
                            param_561 = _e877;
                            let _e878 = belowValue_2;
                            param_562 = _e878;
                            param_563 = _e875;
                            let _e879 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_559), (&param_560), (&param_561), (&param_562), (&param_563));
                            if _e879 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e880 = i_17;
                        i_17 = (_e880 + 1i);
                    }
                }
                param_564 = 4u;
                param_565 = 0u;
                param_566 = 0u;
                let _e882 = moisture_4;
                param_567 = _e882;
                let _e883 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_564), (&param_565), (&param_566), (&param_567));
                let _e884 = (*currentIndex_9);
                param_568 = _e884;
                let _e885 = (*rawValue_7);
                param_569 = _e885;
                let _e886 = belowIndex_2;
                param_570 = _e886;
                param_571 = _e883;
                let _e887 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_568), (&param_569), (&param_570), (&param_571));
                if _e887 {
                    return;
                }
            }
            let _e888 = (*randVal_9);
            dir_3 = select(-1i, 1i, (fract((_e888 * 10f)) > 0.5f));
            let _e893 = (*randVal_9);
            if (fract((_e893 * 100f)) > 0.5f) {
                let _e897 = (*pos_13);
                let _e898 = dir_3;
                slidePos[0i] = (_e897 + vec3<i32>(_e898, -1i, 0i));
                let _e902 = (*pos_13);
                let _e903 = dir_3;
                slidePos[1i] = (_e902 + vec3<i32>(0i, -1i, _e903));
            } else {
                let _e907 = (*pos_13);
                let _e908 = dir_3;
                slidePos[0i] = (_e907 + vec3<i32>(0i, -1i, _e908));
                let _e912 = (*pos_13);
                let _e913 = dir_3;
                slidePos[1i] = (_e912 + vec3<i32>(_e913, -1i, 0i));
            }
            s_1 = 0i;
            loop {
                let _e917 = s_1;
                if (_e917 < 2i) {
                    let _e919 = s_1;
                    let _e921 = slidePos[_e919];
                    sPos_2 = _e921;
                    let _e923 = sPos_2[0u];
                    let _e924 = (_e923 > 0i);
                    phi_4292_ = _e924;
                    if _e924 {
                        let _e926 = sPos_2[0u];
                        let _e928 = tuning.gridWidth;
                        phi_4292_ = (_e926 < (bitcast<i32>(_e928) - 1i));
                    }
                    let _e933 = phi_4292_;
                    phi_4298_ = _e933;
                    if _e933 {
                        let _e935 = sPos_2[2u];
                        phi_4298_ = (_e935 > 0i);
                    }
                    let _e938 = phi_4298_;
                    phi_4308_ = _e938;
                    if _e938 {
                        let _e940 = sPos_2[2u];
                        let _e942 = tuning.gridDepth;
                        phi_4308_ = (_e940 < (bitcast<i32>(_e942) - 1i));
                    }
                    let _e947 = phi_4308_;
                    if _e947 {
                        let _e948 = sPos_2;
                        param_572 = _e948;
                        let _e949 = getIndex_u0028_vi3_u003b((&param_572));
                        sIndex = _e949;
                        let _e950 = sIndex;
                        param_573 = _e950;
                        let _e951 = readCell_u0028_u1_u003b((&param_573));
                        sValue = _e951;
                        let _e952 = sValue;
                        param_574 = _e952;
                        let _e953 = getType_u0028_u1_u003b((&param_574));
                        if (_e953 == 2u) {
                            let _e955 = (*randVal_9);
                            let _e957 = s_1;
                            startDir_3 = i32((fract(((_e955 * 8f) + f32(_e957))) * 8f));
                            i_18 = 0i;
                            loop {
                                let _e963 = i_18;
                                if (_e963 < 8i) {
                                    let _e965 = startDir_3;
                                    let _e966 = i_18;
                                    let _e967 = (_e965 + _e966);
                                    d_14 = (_e967 - (i32(floor((f32(_e967) / f32(8i)))) * 8i));
                                    let _e975 = sPos_2;
                                    let _e976 = d_14;
                                    param_575 = _e976;
                                    let _e977 = getHDir_u0028_i1_u003b((&param_575));
                                    pushPos_1 = (_e975 + _e977);
                                    let _e980 = pushPos_1[0u];
                                    let _e981 = (_e980 > 0i);
                                    phi_4365_ = _e981;
                                    if _e981 {
                                        let _e983 = pushPos_1[0u];
                                        let _e985 = tuning.gridWidth;
                                        phi_4365_ = (_e983 < (bitcast<i32>(_e985) - 1i));
                                    }
                                    let _e990 = phi_4365_;
                                    phi_4371_ = _e990;
                                    if _e990 {
                                        let _e992 = pushPos_1[2u];
                                        phi_4371_ = (_e992 > 0i);
                                    }
                                    let _e995 = phi_4371_;
                                    phi_4381_ = _e995;
                                    if _e995 {
                                        let _e997 = pushPos_1[2u];
                                        let _e999 = tuning.gridDepth;
                                        phi_4381_ = (_e997 < (bitcast<i32>(_e999) - 1i));
                                    }
                                    let _e1004 = phi_4381_;
                                    if _e1004 {
                                        param_576 = 4u;
                                        param_577 = 0u;
                                        param_578 = 0u;
                                        let _e1005 = moisture_4;
                                        param_579 = _e1005;
                                        let _e1006 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_576), (&param_577), (&param_578), (&param_579));
                                        let _e1007 = pushPos_1;
                                        param_580 = _e1007;
                                        let _e1008 = getIndex_u0028_vi3_u003b((&param_580));
                                        let _e1009 = (*currentIndex_9);
                                        param_581 = _e1009;
                                        param_582 = _e1006;
                                        let _e1010 = sIndex;
                                        param_583 = _e1010;
                                        let _e1011 = sValue;
                                        param_584 = _e1011;
                                        param_585 = _e1008;
                                        let _e1012 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_581), (&param_582), (&param_583), (&param_584), (&param_585));
                                        if _e1012 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1013 = i_18;
                                    i_18 = (_e1013 + 1i);
                                }
                            }
                            param_586 = 4u;
                            param_587 = 0u;
                            param_588 = 0u;
                            let _e1015 = moisture_4;
                            param_589 = _e1015;
                            let _e1016 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_586), (&param_587), (&param_588), (&param_589));
                            let _e1017 = (*currentIndex_9);
                            param_590 = _e1017;
                            let _e1018 = (*rawValue_7);
                            param_591 = _e1018;
                            let _e1019 = sIndex;
                            param_592 = _e1019;
                            param_593 = _e1016;
                            let _e1020 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_590), (&param_591), (&param_592), (&param_593));
                            if _e1020 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1021 = s_1;
                    s_1 = (_e1021 + 1i);
                }
            }
        }
    }
    let _e1023 = (*currentDir_4);
    floraState = _e1023;
    let _e1024 = isClumped;
    phi_4436_ = _e1024;
    if !(_e1024) {
        let _e1026 = (*currentSleep_4);
        let _e1028 = tuning.wakeSleepThreshold;
        phi_4436_ = (_e1026 > _e1028);
    }
    let _e1031 = phi_4436_;
    if _e1031 {
        let _e1032 = (*pos_13);
        abovePos_1 = (_e1032 + vec3<i32>(0i, 1i, 0i));
        let _e1035 = abovePos_1[1u];
        let _e1037 = tuning.gridHeight;
        aboveInside = (_e1035 < (bitcast<i32>(_e1037) - 1i));
        let _e1041 = abovePos_1;
        param_594 = _e1041;
        let _e1042 = getIndex_u0028_vi3_u003b((&param_594));
        aboveIndex = _e1042;
        let _e1043 = aboveInside;
        if _e1043 {
            let _e1044 = aboveIndex;
            param_595 = _e1044;
            let _e1045 = readCell_u0028_u1_u003b((&param_595));
            param_596 = _e1045;
            let _e1046 = getType_u0028_u1_u003b((&param_596));
            local_21 = _e1046;
        } else {
            local_21 = 0u;
        }
        let _e1047 = local_21;
        aboveType = _e1047;
        let _e1048 = aboveType;
        let _e1050 = aboveType;
        if ((_e1048 == 0u) || (_e1050 == 18u)) {
            let _e1053 = moisture_4;
            let _e1055 = floraState;
            if ((_e1053 >= 5u) && (_e1055 < 100u)) {
                let _e1058 = (*randVal_9);
                let _e1062 = tuning.grassGrowChance;
                if (fract((_e1058 * 55f)) < _e1062) {
                    let _e1064 = floraState;
                    floraState = (_e1064 + bitcast<u32>(1i));
                    let _e1067 = floraState;
                    let _e1069 = aboveType;
                    let _e1072 = aboveInside;
                    let _e1073 = (((_e1067 == 100u) && (_e1069 == 0u)) && _e1072);
                    phi_4510_ = _e1073;
                    if _e1073 {
                        let _e1074 = (*randVal_9);
                        let _e1078 = tuning.treeBloomChance;
                        phi_4510_ = (fract((_e1074 * 97f)) < _e1078);
                    }
                    let _e1081 = phi_4510_;
                    if _e1081 {
                        let _e1082 = aboveIndex;
                        param_597 = 18u;
                        param_598 = 0u;
                        param_599 = 0u;
                        param_600 = 0u;
                        let _e1085 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_597), (&param_598), (&param_599), (&param_600));
                        let _e1086 = atomicCompareExchangeWeak((&unnamed.grid[_e1082]), 0u, _e1085);
                    }
                }
            }
            let _e1088 = floraState;
            if (_e1088 > 100u) {
                floraState = 100u;
            }
        } else {
            let _e1090 = aboveType;
            if (_e1090 == 2u) {
                let _e1092 = floraState;
                if (_e1092 > 0u) {
                    let _e1094 = floraState;
                    if (_e1094 <= 100u) {
                        floraState = 101u;
                    }
                    let _e1096 = (*randVal_9);
                    let _e1100 = tuning.grassSubmergedDecayChance;
                    if (fract((_e1096 * 66f)) < _e1100) {
                        let _e1102 = floraState;
                        floraState = (_e1102 + bitcast<u32>(1i));
                    }
                    let _e1105 = floraState;
                    if (_e1105 >= 200u) {
                        floraState = 0u;
                    }
                }
            } else {
                let _e1107 = aboveType;
                let _e1108 = (_e1107 != 5u);
                phi_4565_ = _e1108;
                if _e1108 {
                    let _e1109 = aboveType;
                    param_601 = _e1109;
                    let _e1110 = isLocust_u0028_u1_u003b((&param_601));
                    phi_4565_ = !(_e1110);
                }
                let _e1113 = phi_4565_;
                if _e1113 {
                    floraState = 0u;
                }
            }
        }
    }
    let _e1114 = (*currentSleep_4);
    newSleep_2 = min((_e1114 + 1u), 255u);
    let _e1117 = (*currentIndex_9);
    let _e1120 = (*rawValue_7);
    param_602 = 4u;
    let _e1121 = floraState;
    param_603 = _e1121;
    let _e1122 = newSleep_2;
    param_604 = _e1122;
    let _e1123 = moisture_4;
    param_605 = _e1123;
    let _e1124 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_602), (&param_603), (&param_604), (&param_605));
    let _e1125 = atomicCompareExchangeWeak((&unnamed.grid[_e1117]), _e1120, _e1124);
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
    var phi_4605_: bool;
    var phi_4675_: bool;
    var phi_4681_: bool;
    var phi_4691_: bool;
    var phi_4877_: bool;
    var phi_4883_: bool;
    var phi_4893_: bool;
    var phi_5008_: bool;
    var phi_5015_: bool;
    var phi_5026_: bool;
    var phi_5038_: bool;
    var phi_5060_: bool;
    var phi_5164_: bool;
    var phi_5170_: bool;
    var phi_5180_: bool;
    var phi_5196_: bool;
    var phi_5208_: bool;
    var phi_5258_: bool;
    var phi_5264_: bool;
    var phi_5274_: bool;

    let _e334 = (*currentSleep_5);
    let _e336 = tuning.wakeSleepThreshold;
    if (_e334 > _e336) {
        wake = false;
        let _e339 = (*pos_14)[1u];
        let _e340 = (_e339 > 1i);
        phi_4605_ = _e340;
        if _e340 {
            let _e341 = (*pos_14);
            param_606 = (_e341 + vec3<i32>(0i, -1i, 0i));
            let _e343 = getIndex_u0028_vi3_u003b((&param_606));
            param_607 = _e343;
            let _e344 = readCell_u0028_u1_u003b((&param_607));
            param_608 = _e344;
            let _e345 = getType_u0028_u1_u003b((&param_608));
            phi_4605_ = (_e345 == 0u);
        }
        let _e348 = phi_4605_;
        if _e348 {
            wake = true;
        } else {
            let _e350 = (*pos_14)[1u];
            let _e352 = tuning.gridHeight;
            if (_e350 < (bitcast<i32>(_e352) - 2i)) {
                let _e356 = (*pos_14);
                param_609 = (_e356 + vec3<i32>(0i, 1i, 0i));
                let _e358 = getIndex_u0028_vi3_u003b((&param_609));
                param_610 = _e358;
                let _e359 = readCell_u0028_u1_u003b((&param_610));
                param_611 = _e359;
                let _e360 = getType_u0028_u1_u003b((&param_611));
                local_22 = (_e360 != 0u);
            } else {
                local_22 = false;
            }
            let _e362 = local_22;
            hasPressure_1 = _e362;
            let _e364 = (*pos_14)[1u];
            if (_e364 > 1i) {
                let _e366 = (*pos_14);
                param_612 = (_e366 + vec3<i32>(0i, -1i, 0i));
                let _e368 = getIndex_u0028_vi3_u003b((&param_612));
                param_613 = _e368;
                let _e369 = readCell_u0028_u1_u003b((&param_613));
                param_614 = _e369;
                let _e370 = getType_u0028_u1_u003b((&param_614));
                local_23 = (_e370 == 2u);
            } else {
                local_23 = false;
            }
            let _e372 = local_23;
            isStackedOnWater = _e372;
            d_15 = 0i;
            loop {
                let _e373 = d_15;
                if (_e373 < 8i) {
                    let _e375 = (*pos_14);
                    let _e376 = d_15;
                    param_615 = _e376;
                    let _e377 = getHDir_u0028_i1_u003b((&param_615));
                    nPos_6 = (_e375 + _e377);
                    let _e380 = nPos_6[0u];
                    let _e381 = (_e380 > 0i);
                    phi_4675_ = _e381;
                    if _e381 {
                        let _e383 = nPos_6[0u];
                        let _e385 = tuning.gridWidth;
                        phi_4675_ = (_e383 < (bitcast<i32>(_e385) - 1i));
                    }
                    let _e390 = phi_4675_;
                    phi_4681_ = _e390;
                    if _e390 {
                        let _e392 = nPos_6[2u];
                        phi_4681_ = (_e392 > 0i);
                    }
                    let _e395 = phi_4681_;
                    phi_4691_ = _e395;
                    if _e395 {
                        let _e397 = nPos_6[2u];
                        let _e399 = tuning.gridDepth;
                        phi_4691_ = (_e397 < (bitcast<i32>(_e399) - 1i));
                    }
                    let _e404 = phi_4691_;
                    if _e404 {
                        let _e405 = nPos_6;
                        param_616 = _e405;
                        let _e406 = getIndex_u0028_vi3_u003b((&param_616));
                        param_617 = _e406;
                        let _e407 = readCell_u0028_u1_u003b((&param_617));
                        param_618 = _e407;
                        let _e408 = getType_u0028_u1_u003b((&param_618));
                        if (_e408 == 0u) {
                            let _e410 = nPos_6;
                            param_619 = (_e410 + vec3<i32>(0i, -1i, 0i));
                            let _e412 = getIndex_u0028_vi3_u003b((&param_619));
                            param_620 = _e412;
                            let _e413 = readCell_u0028_u1_u003b((&param_620));
                            param_621 = _e413;
                            let _e414 = getType_u0028_u1_u003b((&param_621));
                            belowNeighbor = _e414;
                            let _e415 = belowNeighbor;
                            let _e417 = hasPressure_1;
                            let _e419 = isStackedOnWater;
                            let _e421 = belowNeighbor;
                            if ((((_e415 == 0u) || _e417) || _e419) || (_e421 == 2u)) {
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
                    let _e424 = d_15;
                    d_15 = (_e424 + 1i);
                }
            }
        }
        let _e426 = wake;
        if !(_e426) {
            return;
        }
        (*currentSleep_5) = 0u;
        (*currentAge_8) = 0u;
    }
    let _e428 = (*currentAge_8);
    newAge_2 = (_e428 + 1u);
    let _e431 = (*pos_14)[1u];
    if (_e431 > 1i) {
        let _e433 = (*pos_14);
        belowPos_7 = (_e433 + vec3<i32>(0i, -1i, 0i));
        let _e435 = belowPos_7;
        param_622 = _e435;
        let _e436 = getIndex_u0028_vi3_u003b((&param_622));
        param_623 = _e436;
        let _e437 = readCell_u0028_u1_u003b((&param_623));
        param_624 = _e437;
        let _e438 = getType_u0028_u1_u003b((&param_624));
        if (_e438 == 0u) {
            let _e440 = belowPos_7;
            param_625 = _e440;
            let _e441 = getIndex_u0028_vi3_u003b((&param_625));
            param_626 = 2u;
            param_627 = 0u;
            param_628 = 0u;
            let _e442 = newAge_2;
            param_629 = _e442;
            let _e443 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_626), (&param_627), (&param_628), (&param_629));
            let _e444 = (*currentIndex_10);
            param_630 = _e444;
            let _e445 = (*rawValue_8);
            param_631 = _e445;
            param_632 = _e441;
            param_633 = _e443;
            let _e446 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_630), (&param_631), (&param_632), (&param_633));
            if _e446 {
                return;
            }
        }
    }
    let _e447 = (*currentDir_5);
    newDir = _e447;
    let _e448 = newDir;
    let _e450 = newDir;
    if ((_e448 == 0u) || (_e450 == 9u)) {
        let _e453 = (*randVal_10);
        r_1 = fract((_e453 * 77f));
        let _e456 = r_1;
        if (_e456 < 0.25f) {
            newDir = 1u;
        } else {
            let _e458 = r_1;
            if (_e458 < 0.5f) {
                newDir = 2u;
            } else {
                let _e460 = r_1;
                if (_e460 < 0.75f) {
                    newDir = 3u;
                } else {
                    newDir = 4u;
                }
            }
        }
    }
    let _e462 = newAge_2;
    let _e465 = newAge_2;
    if (((_e462 % 3u) == 0u) && (_e465 > 0u)) {
        let _e468 = newDir;
        diagDir = _e468;
        let _e469 = diagDir;
        let _e471 = diagDir;
        if ((_e469 >= 1u) && (_e471 <= 4u)) {
            let _e474 = (*randVal_10);
            r_2 = fract((_e474 * 133f));
            let _e477 = diagDir;
            if (_e477 == 1u) {
                let _e479 = r_2;
                diagDir = select(6u, 5u, (_e479 > 0.5f));
            } else {
                let _e482 = diagDir;
                if (_e482 == 2u) {
                    let _e484 = r_2;
                    diagDir = select(8u, 7u, (_e484 > 0.5f));
                } else {
                    let _e487 = diagDir;
                    if (_e487 == 3u) {
                        let _e489 = r_2;
                        diagDir = select(7u, 5u, (_e489 > 0.5f));
                    } else {
                        let _e492 = diagDir;
                        if (_e492 == 4u) {
                            let _e494 = r_2;
                            diagDir = select(8u, 6u, (_e494 > 0.5f));
                        }
                    }
                }
            }
        }
        let _e497 = (*pos_14);
        let _e498 = diagDir;
        param_634 = (bitcast<i32>(_e498) - 1i);
        let _e501 = getHDir_u0028_i1_u003b((&param_634));
        stepPos = (_e497 + _e501);
        let _e504 = stepPos[0u];
        let _e505 = (_e504 > 0i);
        phi_4877_ = _e505;
        if _e505 {
            let _e507 = stepPos[0u];
            let _e509 = tuning.gridWidth;
            phi_4877_ = (_e507 < (bitcast<i32>(_e509) - 1i));
        }
        let _e514 = phi_4877_;
        phi_4883_ = _e514;
        if _e514 {
            let _e516 = stepPos[2u];
            phi_4883_ = (_e516 > 0i);
        }
        let _e519 = phi_4883_;
        phi_4893_ = _e519;
        if _e519 {
            let _e521 = stepPos[2u];
            let _e523 = tuning.gridDepth;
            phi_4893_ = (_e521 < (bitcast<i32>(_e523) - 1i));
        }
        let _e528 = phi_4893_;
        if _e528 {
            let _e529 = stepPos;
            param_635 = _e529;
            let _e530 = getIndex_u0028_vi3_u003b((&param_635));
            param_636 = _e530;
            let _e531 = readCell_u0028_u1_u003b((&param_636));
            param_637 = _e531;
            let _e532 = getType_u0028_u1_u003b((&param_637));
            if (_e532 == 0u) {
                param_638 = 2u;
                let _e534 = newDir;
                param_639 = _e534;
                param_640 = 0u;
                let _e535 = newAge_2;
                param_641 = _e535;
                let _e536 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_638), (&param_639), (&param_640), (&param_641));
                newValue_1 = _e536;
                let _e537 = stepPos;
                param_642 = _e537;
                let _e538 = getIndex_u0028_vi3_u003b((&param_642));
                let _e539 = (*currentIndex_10);
                param_643 = _e539;
                let _e540 = (*rawValue_8);
                param_644 = _e540;
                param_645 = _e538;
                let _e541 = newValue_1;
                param_646 = _e541;
                let _e542 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_643), (&param_644), (&param_645), (&param_646));
                if _e542 {
                    return;
                }
            }
        }
    }
    let _e543 = (*pos_14);
    bestDropPos = _e543;
    foundDrop = false;
    blockedMask_1 = 0u;
    let _e544 = (*randVal_10);
    startDir_4 = i32((fract((_e544 * 8f)) * 8f));
    let _e550 = tuning.waterSpreadRadius;
    let _e552 = tuning.gridWidth;
    let _e555 = tuning.gridHeight;
    waterReach = bitcast<i32>(clamp(_e550, 1u, bitcast<u32>(max(bitcast<i32>(_e552), bitcast<i32>(_e555)))));
    r_3 = 1i;
    loop {
        let _e561 = r_3;
        let _e562 = waterReach;
        if (_e561 <= _e562) {
            let _e564 = blockedMask_1;
            if (_e564 == 255u) {
                break;
            }
            i_19 = 0i;
            loop {
                let _e566 = i_19;
                if (_e566 < 8i) {
                    let _e568 = startDir_4;
                    let _e569 = i_19;
                    let _e570 = (_e568 + _e569);
                    d_16 = (_e570 - (i32(floor((f32(_e570) / f32(8i)))) * 8i));
                    let _e578 = blockedMask_1;
                    let _e579 = d_16;
                    if ((_e578 & (1u << bitcast<u32>(_e579))) == 0u) {
                        let _e584 = (*pos_14);
                        let _e585 = d_16;
                        param_647 = _e585;
                        let _e586 = getHDir_u0028_i1_u003b((&param_647));
                        let _e587 = r_3;
                        c_7 = (_e584 + (_e586 * vec3(_e587)));
                        let _e592 = c_7[0u];
                        let _e593 = (_e592 <= 0i);
                        phi_5008_ = _e593;
                        if !(_e593) {
                            let _e596 = c_7[0u];
                            let _e598 = tuning.gridWidth;
                            phi_5008_ = (_e596 >= (bitcast<i32>(_e598) - 1i));
                        }
                        let _e603 = phi_5008_;
                        phi_5015_ = _e603;
                        if !(_e603) {
                            let _e606 = c_7[2u];
                            phi_5015_ = (_e606 <= 0i);
                        }
                        let _e609 = phi_5015_;
                        phi_5026_ = _e609;
                        if !(_e609) {
                            let _e612 = c_7[2u];
                            let _e614 = tuning.gridDepth;
                            phi_5026_ = (_e612 >= (bitcast<i32>(_e614) - 1i));
                        }
                        let _e619 = phi_5026_;
                        phi_5038_ = _e619;
                        if !(_e619) {
                            let _e621 = c_7;
                            param_648 = _e621;
                            let _e622 = getIndex_u0028_vi3_u003b((&param_648));
                            param_649 = _e622;
                            let _e623 = readCell_u0028_u1_u003b((&param_649));
                            param_650 = _e623;
                            let _e624 = getType_u0028_u1_u003b((&param_650));
                            phi_5038_ = (_e624 != 0u);
                        }
                        let _e627 = phi_5038_;
                        if _e627 {
                            let _e628 = d_16;
                            let _e631 = blockedMask_1;
                            blockedMask_1 = (_e631 | (1u << bitcast<u32>(_e628)));
                        } else {
                            let _e634 = c_7[1u];
                            let _e635 = (_e634 > 1i);
                            phi_5060_ = _e635;
                            if _e635 {
                                let _e636 = c_7;
                                param_651 = (_e636 + vec3<i32>(0i, -1i, 0i));
                                let _e638 = getIndex_u0028_vi3_u003b((&param_651));
                                param_652 = _e638;
                                let _e639 = readCell_u0028_u1_u003b((&param_652));
                                param_653 = _e639;
                                let _e640 = getType_u0028_u1_u003b((&param_653));
                                phi_5060_ = (_e640 == 0u);
                            }
                            let _e643 = phi_5060_;
                            if _e643 {
                                let _e644 = c_7;
                                bestDropPos = _e644;
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
                    let _e645 = i_19;
                    i_19 = (_e645 + 1i);
                }
            }
            let _e647 = foundDrop;
            if _e647 {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e648 = r_3;
            r_3 = (_e648 + 1i);
        }
    }
    let _e650 = foundDrop;
    if _e650 {
        param_654 = 2u;
        param_655 = 0u;
        param_656 = 0u;
        param_657 = 0u;
        let _e651 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_654), (&param_655), (&param_656), (&param_657));
        newValue_2 = _e651;
        let _e652 = bestDropPos;
        param_658 = _e652;
        let _e653 = getIndex_u0028_vi3_u003b((&param_658));
        let _e654 = (*currentIndex_10);
        param_659 = _e654;
        let _e655 = (*rawValue_8);
        param_660 = _e655;
        param_661 = _e653;
        let _e656 = newValue_2;
        param_662 = _e656;
        let _e657 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_659), (&param_660), (&param_661), (&param_662));
        if _e657 {
            return;
        }
    } else {
        let _e659 = (*pos_14)[1u];
        let _e661 = tuning.gridHeight;
        if (_e659 < (bitcast<i32>(_e661) - 2i)) {
            let _e665 = (*pos_14);
            param_663 = (_e665 + vec3<i32>(0i, 1i, 0i));
            let _e667 = getIndex_u0028_vi3_u003b((&param_663));
            param_664 = _e667;
            let _e668 = readCell_u0028_u1_u003b((&param_664));
            param_665 = _e668;
            let _e669 = getType_u0028_u1_u003b((&param_665));
            local_24 = (_e669 != 0u);
        } else {
            local_24 = false;
        }
        let _e671 = local_24;
        hasPressure_2 = _e671;
        let _e673 = (*pos_14)[1u];
        if (_e673 > 1i) {
            let _e675 = (*pos_14);
            param_666 = (_e675 + vec3<i32>(0i, -1i, 0i));
            let _e677 = getIndex_u0028_vi3_u003b((&param_666));
            param_667 = _e677;
            let _e678 = readCell_u0028_u1_u003b((&param_667));
            param_668 = _e678;
            let _e679 = getType_u0028_u1_u003b((&param_668));
            local_25 = (_e679 == 2u);
        } else {
            local_25 = false;
        }
        let _e681 = local_25;
        isStackedOnWater_1 = _e681;
        canStepOntoPool = false;
        d_17 = 0i;
        loop {
            let _e682 = d_17;
            if (_e682 < 8i) {
                let _e684 = (*pos_14);
                let _e685 = d_17;
                param_669 = _e685;
                let _e686 = getHDir_u0028_i1_u003b((&param_669));
                nPos_7 = (_e684 + _e686);
                let _e689 = nPos_7[0u];
                let _e690 = (_e689 > 0i);
                phi_5164_ = _e690;
                if _e690 {
                    let _e692 = nPos_7[0u];
                    let _e694 = tuning.gridWidth;
                    phi_5164_ = (_e692 < (bitcast<i32>(_e694) - 1i));
                }
                let _e699 = phi_5164_;
                phi_5170_ = _e699;
                if _e699 {
                    let _e701 = nPos_7[2u];
                    phi_5170_ = (_e701 > 0i);
                }
                let _e704 = phi_5170_;
                phi_5180_ = _e704;
                if _e704 {
                    let _e706 = nPos_7[2u];
                    let _e708 = tuning.gridDepth;
                    phi_5180_ = (_e706 < (bitcast<i32>(_e708) - 1i));
                }
                let _e713 = phi_5180_;
                if _e713 {
                    let _e714 = nPos_7;
                    param_670 = _e714;
                    let _e715 = getIndex_u0028_vi3_u003b((&param_670));
                    param_671 = _e715;
                    let _e716 = readCell_u0028_u1_u003b((&param_671));
                    param_672 = _e716;
                    let _e717 = getType_u0028_u1_u003b((&param_672));
                    let _e718 = (_e717 == 0u);
                    phi_5196_ = _e718;
                    if _e718 {
                        let _e720 = (*pos_14)[1u];
                        phi_5196_ = (_e720 > 1i);
                    }
                    let _e723 = phi_5196_;
                    phi_5208_ = _e723;
                    if _e723 {
                        let _e724 = nPos_7;
                        param_673 = (_e724 + vec3<i32>(0i, -1i, 0i));
                        let _e726 = getIndex_u0028_vi3_u003b((&param_673));
                        param_674 = _e726;
                        let _e727 = readCell_u0028_u1_u003b((&param_674));
                        param_675 = _e727;
                        let _e728 = getType_u0028_u1_u003b((&param_675));
                        phi_5208_ = (_e728 == 2u);
                    }
                    let _e731 = phi_5208_;
                    if _e731 {
                        canStepOntoPool = true;
                        break;
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e732 = d_17;
                d_17 = (_e732 + 1i);
            }
        }
        let _e734 = hasPressure_2;
        let _e735 = isStackedOnWater_1;
        let _e737 = canStepOntoPool;
        if ((_e734 || _e735) || _e737) {
            let _e739 = (*randVal_10);
            startSpreadDir = i32((fract((_e739 * 8f)) * 8f));
            i_20 = 0i;
            loop {
                let _e744 = i_20;
                if (_e744 < 8i) {
                    let _e746 = startSpreadDir;
                    let _e747 = i_20;
                    let _e748 = (_e746 + _e747);
                    d_18 = (_e748 - (i32(floor((f32(_e748) / f32(8i)))) * 8i));
                    let _e756 = (*pos_14);
                    let _e757 = d_18;
                    param_676 = _e757;
                    let _e758 = getHDir_u0028_i1_u003b((&param_676));
                    targetPos_2 = (_e756 + _e758);
                    let _e761 = targetPos_2[0u];
                    let _e762 = (_e761 > 0i);
                    phi_5258_ = _e762;
                    if _e762 {
                        let _e764 = targetPos_2[0u];
                        let _e766 = tuning.gridWidth;
                        phi_5258_ = (_e764 < (bitcast<i32>(_e766) - 1i));
                    }
                    let _e771 = phi_5258_;
                    phi_5264_ = _e771;
                    if _e771 {
                        let _e773 = targetPos_2[2u];
                        phi_5264_ = (_e773 > 0i);
                    }
                    let _e776 = phi_5264_;
                    phi_5274_ = _e776;
                    if _e776 {
                        let _e778 = targetPos_2[2u];
                        let _e780 = tuning.gridDepth;
                        phi_5274_ = (_e778 < (bitcast<i32>(_e780) - 1i));
                    }
                    let _e785 = phi_5274_;
                    if _e785 {
                        let _e786 = targetPos_2;
                        param_677 = _e786;
                        let _e787 = getIndex_u0028_vi3_u003b((&param_677));
                        param_678 = _e787;
                        let _e788 = readCell_u0028_u1_u003b((&param_678));
                        param_679 = _e788;
                        let _e789 = getType_u0028_u1_u003b((&param_679));
                        if (_e789 == 0u) {
                            let _e791 = d_18;
                            param_680 = 2u;
                            param_681 = bitcast<u32>((_e791 + 1i));
                            param_682 = 0u;
                            let _e794 = newAge_2;
                            param_683 = _e794;
                            let _e795 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_680), (&param_681), (&param_682), (&param_683));
                            newValue_3 = _e795;
                            let _e796 = targetPos_2;
                            param_684 = _e796;
                            let _e797 = getIndex_u0028_vi3_u003b((&param_684));
                            let _e798 = (*currentIndex_10);
                            param_685 = _e798;
                            let _e799 = (*rawValue_8);
                            param_686 = _e799;
                            param_687 = _e797;
                            let _e800 = newValue_3;
                            param_688 = _e800;
                            let _e801 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_685), (&param_686), (&param_687), (&param_688));
                            if _e801 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e802 = i_20;
                    i_20 = (_e802 + 1i);
                }
            }
        }
    }
    let _e804 = (*currentSleep_5);
    newSleep_3 = min((_e804 + 1u), 255u);
    param_689 = 2u;
    param_690 = 0u;
    let _e807 = newSleep_3;
    param_691 = _e807;
    let _e808 = newAge_2;
    param_692 = _e808;
    let _e809 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_689), (&param_690), (&param_691), (&param_692));
    sleepValue = _e809;
    let _e810 = (*currentIndex_10);
    let _e813 = (*rawValue_8);
    let _e814 = sleepValue;
    let _e815 = atomicCompareExchangeWeak((&unnamed.grid[_e810]), _e813, _e814);
    return;
}

fn incWater_u0028_() {
    let _e201 = atomicAdd((&unnamed_2.waterVoxelCount), 1u);
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
    var phi_2486_: bool;
    var phi_2492_: bool;
    var phi_2502_: bool;
    var phi_2508_: bool;
    var phi_2518_: bool;
    var phi_2589_: bool;
    var phi_2595_: bool;
    var phi_2605_: bool;
    var phi_2611_: bool;
    var phi_2621_: bool;
    var phi_2685_: bool;
    var phi_2704_: bool;
    var phi_2748_: bool;
    var phi_2790_: bool;
    var phi_2796_: bool;
    var phi_2805_: bool;
    var phi_2887_: bool;
    var phi_2893_: bool;
    var phi_2902_: bool;
    var phi_2908_: bool;
    var phi_2917_: bool;
    var phi_3039_: bool;
    var phi_3045_: bool;
    var phi_3055_: bool;
    var phi_3099_: bool;
    var phi_3105_: bool;
    var phi_3115_: bool;
    var phi_3207_: bool;
    var phi_3213_: bool;
    var phi_3223_: bool;
    var phi_3326_: bool;
    var phi_3332_: bool;
    var phi_3342_: bool;
    var phi_3399_: bool;
    var phi_3405_: bool;
    var phi_3415_: bool;

    let _e364 = (*currentAge_9);
    moisture_5 = _e364;
    moistureModified_1 = false;
    let _e365 = moisture_5;
    let _e367 = tuning.sandMoistureCapacity;
    if (_e365 < _e367) {
        let _e369 = (*randVal_11);
        startDir_5 = i32((fract((_e369 * 17f)) * 6f));
        i_21 = 0i;
        loop {
            let _e374 = i_21;
            if (_e374 < 6i) {
                let _e376 = startDir_5;
                let _e377 = i_21;
                let _e378 = (_e376 + _e377);
                d_19 = (_e378 - (i32(floor((f32(_e378) / f32(6i)))) * 6i));
                let _e386 = d_19;
                if (_e386 != 2i) {
                    let _e388 = (*pos_15);
                    let _e389 = d_19;
                    param_693 = _e389;
                    let _e390 = getOrthoDir_u0028_i1_u003b((&param_693));
                    nPos_8 = (_e388 + _e390);
                    let _e393 = nPos_8[0u];
                    let _e394 = (_e393 > 0i);
                    phi_2486_ = _e394;
                    if _e394 {
                        let _e396 = nPos_8[0u];
                        let _e398 = tuning.gridWidth;
                        phi_2486_ = (_e396 < (bitcast<i32>(_e398) - 1i));
                    }
                    let _e403 = phi_2486_;
                    phi_2492_ = _e403;
                    if _e403 {
                        let _e405 = nPos_8[1u];
                        phi_2492_ = (_e405 > 0i);
                    }
                    let _e408 = phi_2492_;
                    phi_2502_ = _e408;
                    if _e408 {
                        let _e410 = nPos_8[1u];
                        let _e412 = tuning.gridHeight;
                        phi_2502_ = (_e410 < (bitcast<i32>(_e412) - 1i));
                    }
                    let _e417 = phi_2502_;
                    phi_2508_ = _e417;
                    if _e417 {
                        let _e419 = nPos_8[2u];
                        phi_2508_ = (_e419 > 0i);
                    }
                    let _e422 = phi_2508_;
                    phi_2518_ = _e422;
                    if _e422 {
                        let _e424 = nPos_8[2u];
                        let _e426 = tuning.gridDepth;
                        phi_2518_ = (_e424 < (bitcast<i32>(_e426) - 1i));
                    }
                    let _e431 = phi_2518_;
                    if _e431 {
                        let _e432 = nPos_8;
                        param_694 = _e432;
                        let _e433 = getIndex_u0028_vi3_u003b((&param_694));
                        nIndex_5 = _e433;
                        let _e434 = nIndex_5;
                        param_695 = _e434;
                        let _e435 = readCell_u0028_u1_u003b((&param_695));
                        nVal_5 = _e435;
                        let _e436 = nVal_5;
                        param_696 = _e436;
                        let _e437 = getType_u0028_u1_u003b((&param_696));
                        if (_e437 == 2u) {
                            let _e439 = nIndex_5;
                            let _e442 = nVal_5;
                            let _e443 = atomicCompareExchangeWeak((&unnamed.grid[_e439]), _e442, 0u);
                            let _e445 = nVal_5;
                            if (_e443.old_value == _e445) {
                                let _e447 = (*currentIndex_11);
                                let _e451 = tuning.sandWaterAbsorbUnit;
                                let _e454 = atomicAdd((&unnamed.grid[_e447]), (_e451 << bitcast<u32>(24i)));
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
                let _e455 = i_21;
                i_21 = (_e455 + 1i);
            }
        }
    }
    let _e457 = moistureModified_1;
    let _e459 = moisture_5;
    if (!(_e457) && (_e459 > 0u)) {
        let _e462 = (*randVal_11);
        d_20 = i32((fract((_e462 * 31f)) * 6f));
        let _e467 = d_20;
        if (_e467 != 2i) {
            let _e469 = (*pos_15);
            let _e470 = d_20;
            param_697 = _e470;
            let _e471 = getOrthoDir_u0028_i1_u003b((&param_697));
            nPos_9 = (_e469 + _e471);
            let _e474 = nPos_9[0u];
            let _e475 = (_e474 > 0i);
            phi_2589_ = _e475;
            if _e475 {
                let _e477 = nPos_9[0u];
                let _e479 = tuning.gridWidth;
                phi_2589_ = (_e477 < (bitcast<i32>(_e479) - 1i));
            }
            let _e484 = phi_2589_;
            phi_2595_ = _e484;
            if _e484 {
                let _e486 = nPos_9[1u];
                phi_2595_ = (_e486 > 0i);
            }
            let _e489 = phi_2595_;
            phi_2605_ = _e489;
            if _e489 {
                let _e491 = nPos_9[1u];
                let _e493 = tuning.gridHeight;
                phi_2605_ = (_e491 < (bitcast<i32>(_e493) - 1i));
            }
            let _e498 = phi_2605_;
            phi_2611_ = _e498;
            if _e498 {
                let _e500 = nPos_9[2u];
                phi_2611_ = (_e500 > 0i);
            }
            let _e503 = phi_2611_;
            phi_2621_ = _e503;
            if _e503 {
                let _e505 = nPos_9[2u];
                let _e507 = tuning.gridDepth;
                phi_2621_ = (_e505 < (bitcast<i32>(_e507) - 1i));
            }
            let _e512 = phi_2621_;
            if _e512 {
                let _e513 = nPos_9;
                param_698 = _e513;
                let _e514 = getIndex_u0028_vi3_u003b((&param_698));
                nIndex_6 = _e514;
                let _e515 = nIndex_6;
                param_699 = _e515;
                let _e516 = readCell_u0028_u1_u003b((&param_699));
                nVal_6 = _e516;
                let _e517 = nVal_6;
                param_700 = _e517;
                let _e518 = getType_u0028_u1_u003b((&param_700));
                nType_3 = _e518;
                let _e519 = nType_3;
                let _e521 = nType_3;
                if ((_e519 == 1u) || (_e521 == 4u)) {
                    let _e524 = nVal_6;
                    param_701 = _e524;
                    let _e525 = getAge_u0028_u1_u003b((&param_701));
                    nMoisture_1 = _e525;
                    let _e526 = nType_3;
                    if (_e526 == 4u) {
                        let _e529 = tuning.dirtMoistureCapacity;
                        local_26 = _e529;
                    } else {
                        let _e531 = tuning.sandMoistureCapacity;
                        local_26 = _e531;
                    }
                    let _e532 = local_26;
                    nCapacity_1 = _e532;
                    let _e533 = moisture_5;
                    let _e534 = nMoisture_1;
                    let _e537 = nMoisture_1;
                    let _e538 = nCapacity_1;
                    if ((_e533 > (_e534 + 1u)) && (_e537 < _e538)) {
                        let _e541 = (*currentIndex_11);
                        let _e544 = atomicAdd((&unnamed.grid[_e541]), 4278190080u);
                        let _e545 = nIndex_6;
                        let _e548 = atomicAdd((&unnamed.grid[_e545]), 16777216u);
                        moistureModified_1 = true;
                    }
                }
            }
        }
    }
    let _e549 = moistureModified_1;
    let _e550 = !(_e549);
    phi_2685_ = _e550;
    if _e550 {
        let _e551 = moisture_5;
        let _e553 = tuning.sandWaterAbsorbUnit;
        phi_2685_ = (_e551 >= _e553);
    }
    let _e556 = phi_2685_;
    if _e556 {
        let _e557 = (*pos_15);
        leakPos = (_e557 + vec3<i32>(0i, -1i, 0i));
        let _e560 = leakPos[1u];
        let _e561 = (_e560 > 0i);
        phi_2704_ = _e561;
        if _e561 {
            let _e562 = leakPos;
            param_702 = _e562;
            let _e563 = getIndex_u0028_vi3_u003b((&param_702));
            param_703 = _e563;
            let _e564 = readCell_u0028_u1_u003b((&param_703));
            param_704 = _e564;
            let _e565 = getType_u0028_u1_u003b((&param_704));
            phi_2704_ = (_e565 == 0u);
        }
        let _e568 = phi_2704_;
        if _e568 {
            let _e569 = leakPos;
            param_705 = _e569;
            let _e570 = getIndex_u0028_vi3_u003b((&param_705));
            param_706 = 2u;
            param_707 = 0u;
            param_708 = 0u;
            param_709 = 0u;
            let _e573 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_706), (&param_707), (&param_708), (&param_709));
            let _e574 = atomicCompareExchangeWeak((&unnamed.grid[_e570]), 0u, _e573);
            if (_e574.old_value == 0u) {
                let _e577 = (*currentIndex_11);
                let _e581 = tuning.sandWaterAbsorbUnit;
                let _e585 = atomicAdd((&unnamed.grid[_e577]), ((0u - _e581) << bitcast<u32>(24i)));
                incWater_u0028_();
                moistureModified_1 = true;
            }
        }
    }
    let _e586 = moistureModified_1;
    if _e586 {
        return;
    }
    let _e587 = (*pos_15);
    param_710 = _e587;
    let _e588 = grainCanMove_u0028_vi3_u003b((&param_710));
    canMove_1 = _e588;
    isClumped_1 = false;
    let _e589 = canMove_1;
    let _e590 = moisture_5;
    let _e592 = (_e589 && (_e590 > 0u));
    phi_2748_ = _e592;
    if _e592 {
        let _e593 = (*currentSleep_6);
        let _e595 = tuning.wakeSleepThreshold;
        phi_2748_ = (_e593 > _e595);
    }
    let _e598 = phi_2748_;
    if _e598 {
        emptyBelowCount_1 = 0i;
        let _e600 = (*pos_15)[1u];
        if (_e600 > 1i) {
            x_2 = -1i;
            loop {
                let _e602 = x_2;
                if (_e602 <= 1i) {
                    z_2 = -1i;
                    loop {
                        let _e604 = z_2;
                        if (_e604 <= 1i) {
                            let _e606 = (*pos_15);
                            let _e607 = x_2;
                            let _e608 = z_2;
                            checkPos_2 = (_e606 + vec3<i32>(_e607, -1i, _e608));
                            let _e612 = checkPos_2[0u];
                            let _e613 = (_e612 >= 0i);
                            phi_2790_ = _e613;
                            if _e613 {
                                let _e615 = checkPos_2[0u];
                                let _e617 = tuning.gridWidth;
                                phi_2790_ = (_e615 < bitcast<i32>(_e617));
                            }
                            let _e621 = phi_2790_;
                            phi_2796_ = _e621;
                            if _e621 {
                                let _e623 = checkPos_2[2u];
                                phi_2796_ = (_e623 >= 0i);
                            }
                            let _e626 = phi_2796_;
                            phi_2805_ = _e626;
                            if _e626 {
                                let _e628 = checkPos_2[2u];
                                let _e630 = tuning.gridDepth;
                                phi_2805_ = (_e628 < bitcast<i32>(_e630));
                            }
                            let _e634 = phi_2805_;
                            if _e634 {
                                let _e635 = checkPos_2;
                                param_711 = _e635;
                                let _e636 = getIndex_u0028_vi3_u003b((&param_711));
                                param_712 = _e636;
                                let _e637 = readCell_u0028_u1_u003b((&param_712));
                                param_713 = _e637;
                                let _e638 = getType_u0028_u1_u003b((&param_713));
                                if (_e638 == 0u) {
                                    let _e640 = emptyBelowCount_1;
                                    emptyBelowCount_1 = (_e640 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e642 = z_2;
                            z_2 = (_e642 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e644 = x_2;
                    x_2 = (_e644 + 1i);
                }
            }
        }
        let _e646 = emptyBelowCount_1;
        let _e648 = tuning.emptyBelowWakeCount;
        if (_e646 >= bitcast<i32>(_e648)) {
            (*currentSleep_6) = 0u;
        } else {
            clumpCount_1 = 0i;
            x_3 = -1i;
            loop {
                let _e651 = x_3;
                if (_e651 <= 1i) {
                    y_1 = -1i;
                    loop {
                        let _e653 = y_1;
                        if (_e653 <= 1i) {
                            z_3 = -1i;
                            loop {
                                let _e655 = z_3;
                                if (_e655 <= 1i) {
                                    let _e657 = x_3;
                                    let _e659 = y_1;
                                    let _e662 = z_3;
                                    if (((_e657 == 0i) && (_e659 == 0i)) && (_e662 == 0i)) {
                                        continue;
                                    }
                                    let _e665 = (*pos_15);
                                    let _e666 = x_3;
                                    let _e667 = y_1;
                                    let _e668 = z_3;
                                    nPos_10 = (_e665 + vec3<i32>(_e666, _e667, _e668));
                                    let _e672 = nPos_10[0u];
                                    let _e673 = (_e672 >= 0i);
                                    phi_2887_ = _e673;
                                    if _e673 {
                                        let _e675 = nPos_10[0u];
                                        let _e677 = tuning.gridWidth;
                                        phi_2887_ = (_e675 < bitcast<i32>(_e677));
                                    }
                                    let _e681 = phi_2887_;
                                    phi_2893_ = _e681;
                                    if _e681 {
                                        let _e683 = nPos_10[1u];
                                        phi_2893_ = (_e683 >= 0i);
                                    }
                                    let _e686 = phi_2893_;
                                    phi_2902_ = _e686;
                                    if _e686 {
                                        let _e688 = nPos_10[1u];
                                        let _e690 = tuning.gridHeight;
                                        phi_2902_ = (_e688 < bitcast<i32>(_e690));
                                    }
                                    let _e694 = phi_2902_;
                                    phi_2908_ = _e694;
                                    if _e694 {
                                        let _e696 = nPos_10[2u];
                                        phi_2908_ = (_e696 >= 0i);
                                    }
                                    let _e699 = phi_2908_;
                                    phi_2917_ = _e699;
                                    if _e699 {
                                        let _e701 = nPos_10[2u];
                                        let _e703 = tuning.gridDepth;
                                        phi_2917_ = (_e701 < bitcast<i32>(_e703));
                                    }
                                    let _e707 = phi_2917_;
                                    if _e707 {
                                        let _e708 = nPos_10;
                                        param_714 = _e708;
                                        let _e709 = getIndex_u0028_vi3_u003b((&param_714));
                                        param_715 = _e709;
                                        let _e710 = readCell_u0028_u1_u003b((&param_715));
                                        param_716 = _e710;
                                        let _e711 = getType_u0028_u1_u003b((&param_716));
                                        if (_e711 == 1u) {
                                            let _e713 = clumpCount_1;
                                            clumpCount_1 = (_e713 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e715 = z_3;
                                    z_3 = (_e715 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e717 = y_1;
                            y_1 = (_e717 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e719 = x_3;
                    x_3 = (_e719 + 1i);
                }
            }
            let _e721 = clumpCount_1;
            let _e723 = tuning.sandClumpThreshold;
            if (_e721 >= bitcast<i32>(_e723)) {
                isClumped_1 = true;
            }
        }
    }
    let _e726 = canMove_1;
    let _e727 = isClumped_1;
    if (_e726 && !(_e727)) {
        let _e731 = (*pos_15)[1u];
        if (_e731 > 1i) {
            let _e733 = (*pos_15);
            belowPos_8 = (_e733 + vec3<i32>(0i, -1i, 0i));
            let _e735 = belowPos_8;
            param_717 = _e735;
            let _e736 = getIndex_u0028_vi3_u003b((&param_717));
            param_718 = _e736;
            let _e737 = readCell_u0028_u1_u003b((&param_718));
            param_719 = _e737;
            let _e738 = getType_u0028_u1_u003b((&param_719));
            if (_e738 == 0u) {
                let _e740 = belowPos_8;
                param_720 = _e740;
                let _e741 = getIndex_u0028_vi3_u003b((&param_720));
                param_721 = 1u;
                param_722 = 0u;
                param_723 = 0u;
                let _e742 = moisture_5;
                param_724 = _e742;
                let _e743 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_721), (&param_722), (&param_723), (&param_724));
                let _e744 = (*currentIndex_11);
                param_725 = _e744;
                let _e745 = (*rawValue_9);
                param_726 = _e745;
                param_727 = _e741;
                param_728 = _e743;
                let _e746 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_725), (&param_726), (&param_727), (&param_728));
                if _e746 {
                    return;
                }
            }
        }
        let _e748 = (*pos_15)[1u];
        if (_e748 > 1i) {
            let _e750 = (*randVal_11);
            dir_4 = select(-1i, 1i, (fract((_e750 * 10f)) > 0.5f));
            let _e755 = (*randVal_11);
            if (fract((_e755 * 100f)) > 0.5f) {
                let _e759 = (*pos_15);
                let _e760 = dir_4;
                slidePos1_1 = (_e759 + vec3<i32>(_e760, -1i, 0i));
                let _e763 = (*pos_15);
                let _e764 = dir_4;
                slidePos2_1 = (_e763 + vec3<i32>(0i, -1i, _e764));
            } else {
                let _e767 = (*pos_15);
                let _e768 = dir_4;
                slidePos1_1 = (_e767 + vec3<i32>(0i, -1i, _e768));
                let _e771 = (*pos_15);
                let _e772 = dir_4;
                slidePos2_1 = (_e771 + vec3<i32>(_e772, -1i, 0i));
            }
            let _e776 = slidePos1_1[0u];
            let _e777 = (_e776 > 0i);
            phi_3039_ = _e777;
            if _e777 {
                let _e779 = slidePos1_1[0u];
                let _e781 = tuning.gridWidth;
                phi_3039_ = (_e779 < (bitcast<i32>(_e781) - 1i));
            }
            let _e786 = phi_3039_;
            phi_3045_ = _e786;
            if _e786 {
                let _e788 = slidePos1_1[2u];
                phi_3045_ = (_e788 > 0i);
            }
            let _e791 = phi_3045_;
            phi_3055_ = _e791;
            if _e791 {
                let _e793 = slidePos1_1[2u];
                let _e795 = tuning.gridDepth;
                phi_3055_ = (_e793 < (bitcast<i32>(_e795) - 1i));
            }
            let _e800 = phi_3055_;
            if _e800 {
                let _e801 = slidePos1_1;
                param_729 = _e801;
                let _e802 = getIndex_u0028_vi3_u003b((&param_729));
                param_730 = _e802;
                let _e803 = readCell_u0028_u1_u003b((&param_730));
                param_731 = _e803;
                let _e804 = getType_u0028_u1_u003b((&param_731));
                if (_e804 == 0u) {
                    let _e806 = slidePos1_1;
                    param_732 = _e806;
                    let _e807 = getIndex_u0028_vi3_u003b((&param_732));
                    param_733 = 1u;
                    param_734 = 0u;
                    param_735 = 0u;
                    let _e808 = moisture_5;
                    param_736 = _e808;
                    let _e809 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_733), (&param_734), (&param_735), (&param_736));
                    let _e810 = (*currentIndex_11);
                    param_737 = _e810;
                    let _e811 = (*rawValue_9);
                    param_738 = _e811;
                    param_739 = _e807;
                    param_740 = _e809;
                    let _e812 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_737), (&param_738), (&param_739), (&param_740));
                    if _e812 {
                        return;
                    }
                }
            }
            let _e814 = slidePos2_1[0u];
            let _e815 = (_e814 > 0i);
            phi_3099_ = _e815;
            if _e815 {
                let _e817 = slidePos2_1[0u];
                let _e819 = tuning.gridWidth;
                phi_3099_ = (_e817 < (bitcast<i32>(_e819) - 1i));
            }
            let _e824 = phi_3099_;
            phi_3105_ = _e824;
            if _e824 {
                let _e826 = slidePos2_1[2u];
                phi_3105_ = (_e826 > 0i);
            }
            let _e829 = phi_3105_;
            phi_3115_ = _e829;
            if _e829 {
                let _e831 = slidePos2_1[2u];
                let _e833 = tuning.gridDepth;
                phi_3115_ = (_e831 < (bitcast<i32>(_e833) - 1i));
            }
            let _e838 = phi_3115_;
            if _e838 {
                let _e839 = slidePos2_1;
                param_741 = _e839;
                let _e840 = getIndex_u0028_vi3_u003b((&param_741));
                param_742 = _e840;
                let _e841 = readCell_u0028_u1_u003b((&param_742));
                param_743 = _e841;
                let _e842 = getType_u0028_u1_u003b((&param_743));
                if (_e842 == 0u) {
                    let _e844 = slidePos2_1;
                    param_744 = _e844;
                    let _e845 = getIndex_u0028_vi3_u003b((&param_744));
                    param_745 = 1u;
                    param_746 = 0u;
                    param_747 = 0u;
                    let _e846 = moisture_5;
                    param_748 = _e846;
                    let _e847 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_745), (&param_746), (&param_747), (&param_748));
                    let _e848 = (*currentIndex_11);
                    param_749 = _e848;
                    let _e849 = (*rawValue_9);
                    param_750 = _e849;
                    param_751 = _e845;
                    param_752 = _e847;
                    let _e850 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_749), (&param_750), (&param_751), (&param_752));
                    if _e850 {
                        return;
                    }
                }
            }
        }
        let _e852 = (*pos_15)[1u];
        if (_e852 > 1i) {
            let _e854 = (*pos_15);
            belowPos_9 = (_e854 + vec3<i32>(0i, -1i, 0i));
            let _e856 = belowPos_9;
            param_753 = _e856;
            let _e857 = getIndex_u0028_vi3_u003b((&param_753));
            belowIndex_3 = _e857;
            let _e858 = belowIndex_3;
            param_754 = _e858;
            let _e859 = readCell_u0028_u1_u003b((&param_754));
            belowValue_3 = _e859;
            let _e860 = belowValue_3;
            param_755 = _e860;
            let _e861 = getType_u0028_u1_u003b((&param_755));
            if (_e861 == 2u) {
                let _e863 = (*randVal_11);
                startDir_6 = i32((fract((_e863 * 8f)) * 8f));
                i_22 = 0i;
                loop {
                    let _e868 = i_22;
                    if (_e868 < 8i) {
                        let _e870 = startDir_6;
                        let _e871 = i_22;
                        let _e872 = (_e870 + _e871);
                        d_21 = (_e872 - (i32(floor((f32(_e872) / f32(8i)))) * 8i));
                        let _e880 = belowPos_9;
                        let _e881 = d_21;
                        param_756 = _e881;
                        let _e882 = getHDir_u0028_i1_u003b((&param_756));
                        pushPos_2 = (_e880 + _e882);
                        let _e885 = pushPos_2[0u];
                        let _e886 = (_e885 > 0i);
                        phi_3207_ = _e886;
                        if _e886 {
                            let _e888 = pushPos_2[0u];
                            let _e890 = tuning.gridWidth;
                            phi_3207_ = (_e888 < (bitcast<i32>(_e890) - 1i));
                        }
                        let _e895 = phi_3207_;
                        phi_3213_ = _e895;
                        if _e895 {
                            let _e897 = pushPos_2[2u];
                            phi_3213_ = (_e897 > 0i);
                        }
                        let _e900 = phi_3213_;
                        phi_3223_ = _e900;
                        if _e900 {
                            let _e902 = pushPos_2[2u];
                            let _e904 = tuning.gridDepth;
                            phi_3223_ = (_e902 < (bitcast<i32>(_e904) - 1i));
                        }
                        let _e909 = phi_3223_;
                        if _e909 {
                            param_757 = 1u;
                            param_758 = 0u;
                            param_759 = 0u;
                            let _e910 = moisture_5;
                            param_760 = _e910;
                            let _e911 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_757), (&param_758), (&param_759), (&param_760));
                            let _e912 = pushPos_2;
                            param_761 = _e912;
                            let _e913 = getIndex_u0028_vi3_u003b((&param_761));
                            let _e914 = (*currentIndex_11);
                            param_762 = _e914;
                            param_763 = _e911;
                            let _e915 = belowIndex_3;
                            param_764 = _e915;
                            let _e916 = belowValue_3;
                            param_765 = _e916;
                            param_766 = _e913;
                            let _e917 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_762), (&param_763), (&param_764), (&param_765), (&param_766));
                            if _e917 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e918 = i_22;
                        i_22 = (_e918 + 1i);
                    }
                }
                param_767 = 1u;
                param_768 = 0u;
                param_769 = 0u;
                let _e920 = moisture_5;
                param_770 = _e920;
                let _e921 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_767), (&param_768), (&param_769), (&param_770));
                let _e922 = (*currentIndex_11);
                param_771 = _e922;
                let _e923 = (*rawValue_9);
                param_772 = _e923;
                let _e924 = belowIndex_3;
                param_773 = _e924;
                param_774 = _e921;
                let _e925 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_771), (&param_772), (&param_773), (&param_774));
                if _e925 {
                    return;
                }
            }
            let _e926 = (*randVal_11);
            dir_5 = select(-1i, 1i, (fract((_e926 * 10f)) > 0.5f));
            let _e931 = (*randVal_11);
            if (fract((_e931 * 100f)) > 0.5f) {
                let _e935 = (*pos_15);
                let _e936 = dir_5;
                slidePos_1[0i] = (_e935 + vec3<i32>(_e936, -1i, 0i));
                let _e940 = (*pos_15);
                let _e941 = dir_5;
                slidePos_1[1i] = (_e940 + vec3<i32>(0i, -1i, _e941));
            } else {
                let _e945 = (*pos_15);
                let _e946 = dir_5;
                slidePos_1[0i] = (_e945 + vec3<i32>(0i, -1i, _e946));
                let _e950 = (*pos_15);
                let _e951 = dir_5;
                slidePos_1[1i] = (_e950 + vec3<i32>(_e951, -1i, 0i));
            }
            s_2 = 0i;
            loop {
                let _e955 = s_2;
                if (_e955 < 2i) {
                    let _e957 = s_2;
                    let _e959 = slidePos_1[_e957];
                    sPos_3 = _e959;
                    let _e961 = sPos_3[0u];
                    let _e962 = (_e961 > 0i);
                    phi_3326_ = _e962;
                    if _e962 {
                        let _e964 = sPos_3[0u];
                        let _e966 = tuning.gridWidth;
                        phi_3326_ = (_e964 < (bitcast<i32>(_e966) - 1i));
                    }
                    let _e971 = phi_3326_;
                    phi_3332_ = _e971;
                    if _e971 {
                        let _e973 = sPos_3[2u];
                        phi_3332_ = (_e973 > 0i);
                    }
                    let _e976 = phi_3332_;
                    phi_3342_ = _e976;
                    if _e976 {
                        let _e978 = sPos_3[2u];
                        let _e980 = tuning.gridDepth;
                        phi_3342_ = (_e978 < (bitcast<i32>(_e980) - 1i));
                    }
                    let _e985 = phi_3342_;
                    if _e985 {
                        let _e986 = sPos_3;
                        param_775 = _e986;
                        let _e987 = getIndex_u0028_vi3_u003b((&param_775));
                        sIndex_1 = _e987;
                        let _e988 = sIndex_1;
                        param_776 = _e988;
                        let _e989 = readCell_u0028_u1_u003b((&param_776));
                        sValue_1 = _e989;
                        let _e990 = sValue_1;
                        param_777 = _e990;
                        let _e991 = getType_u0028_u1_u003b((&param_777));
                        if (_e991 == 2u) {
                            let _e993 = (*randVal_11);
                            let _e995 = s_2;
                            startDir_7 = i32((fract(((_e993 * 8f) + f32(_e995))) * 8f));
                            i_23 = 0i;
                            loop {
                                let _e1001 = i_23;
                                if (_e1001 < 8i) {
                                    let _e1003 = startDir_7;
                                    let _e1004 = i_23;
                                    let _e1005 = (_e1003 + _e1004);
                                    d_22 = (_e1005 - (i32(floor((f32(_e1005) / f32(8i)))) * 8i));
                                    let _e1013 = sPos_3;
                                    let _e1014 = d_22;
                                    param_778 = _e1014;
                                    let _e1015 = getHDir_u0028_i1_u003b((&param_778));
                                    pushPos_3 = (_e1013 + _e1015);
                                    let _e1018 = pushPos_3[0u];
                                    let _e1019 = (_e1018 > 0i);
                                    phi_3399_ = _e1019;
                                    if _e1019 {
                                        let _e1021 = pushPos_3[0u];
                                        let _e1023 = tuning.gridWidth;
                                        phi_3399_ = (_e1021 < (bitcast<i32>(_e1023) - 1i));
                                    }
                                    let _e1028 = phi_3399_;
                                    phi_3405_ = _e1028;
                                    if _e1028 {
                                        let _e1030 = pushPos_3[2u];
                                        phi_3405_ = (_e1030 > 0i);
                                    }
                                    let _e1033 = phi_3405_;
                                    phi_3415_ = _e1033;
                                    if _e1033 {
                                        let _e1035 = pushPos_3[2u];
                                        let _e1037 = tuning.gridDepth;
                                        phi_3415_ = (_e1035 < (bitcast<i32>(_e1037) - 1i));
                                    }
                                    let _e1042 = phi_3415_;
                                    if _e1042 {
                                        param_779 = 1u;
                                        param_780 = 0u;
                                        param_781 = 0u;
                                        let _e1043 = moisture_5;
                                        param_782 = _e1043;
                                        let _e1044 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_779), (&param_780), (&param_781), (&param_782));
                                        let _e1045 = pushPos_3;
                                        param_783 = _e1045;
                                        let _e1046 = getIndex_u0028_vi3_u003b((&param_783));
                                        let _e1047 = (*currentIndex_11);
                                        param_784 = _e1047;
                                        param_785 = _e1044;
                                        let _e1048 = sIndex_1;
                                        param_786 = _e1048;
                                        let _e1049 = sValue_1;
                                        param_787 = _e1049;
                                        param_788 = _e1046;
                                        let _e1050 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_784), (&param_785), (&param_786), (&param_787), (&param_788));
                                        if _e1050 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1051 = i_23;
                                    i_23 = (_e1051 + 1i);
                                }
                            }
                            param_789 = 1u;
                            param_790 = 0u;
                            param_791 = 0u;
                            let _e1053 = moisture_5;
                            param_792 = _e1053;
                            let _e1054 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_789), (&param_790), (&param_791), (&param_792));
                            let _e1055 = (*currentIndex_11);
                            param_793 = _e1055;
                            let _e1056 = (*rawValue_9);
                            param_794 = _e1056;
                            let _e1057 = sIndex_1;
                            param_795 = _e1057;
                            param_796 = _e1054;
                            let _e1058 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_793), (&param_794), (&param_795), (&param_796));
                            if _e1058 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1059 = s_2;
                    s_2 = (_e1059 + 1i);
                }
            }
        }
    }
    let _e1061 = (*currentSleep_6);
    newSleep_4 = min((_e1061 + 1u), 255u);
    let _e1064 = (*currentIndex_11);
    let _e1067 = (*rawValue_9);
    param_797 = 1u;
    param_798 = 0u;
    let _e1068 = newSleep_4;
    param_799 = _e1068;
    let _e1069 = moisture_5;
    param_800 = _e1069;
    let _e1070 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_797), (&param_798), (&param_799), (&param_800));
    let _e1071 = atomicCompareExchangeWeak((&unnamed.grid[_e1064]), _e1067, _e1070);
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
    var phi_1806_: bool;
    var phi_1813_: bool;
    var phi_1824_: bool;
    var phi_1831_: bool;
    var phi_1842_: bool;

    let _e220 = (*stepDir);
    if all((_e220 == vec3<i32>(0i, 0i, 0i))) {
        return false;
    }
    let _e223 = (*pos_16);
    let _e224 = (*stepDir);
    target_3 = (_e223 + _e224);
    let _e227 = target_3[0u];
    let _e228 = (_e227 < 1i);
    phi_1806_ = _e228;
    if !(_e228) {
        let _e231 = target_3[0u];
        let _e233 = tuning.gridWidth;
        phi_1806_ = (_e231 >= (bitcast<i32>(_e233) - 1i));
    }
    let _e238 = phi_1806_;
    phi_1813_ = _e238;
    if !(_e238) {
        let _e241 = target_3[1u];
        phi_1813_ = (_e241 < 1i);
    }
    let _e244 = phi_1813_;
    phi_1824_ = _e244;
    if !(_e244) {
        let _e247 = target_3[1u];
        let _e249 = tuning.gridHeight;
        phi_1824_ = (_e247 >= (bitcast<i32>(_e249) - 1i));
    }
    let _e254 = phi_1824_;
    phi_1831_ = _e254;
    if !(_e254) {
        let _e257 = target_3[2u];
        phi_1831_ = (_e257 < 1i);
    }
    let _e260 = phi_1831_;
    phi_1842_ = _e260;
    if !(_e260) {
        let _e263 = target_3[2u];
        let _e265 = tuning.gridDepth;
        phi_1842_ = (_e263 >= (bitcast<i32>(_e265) - 1i));
    }
    let _e270 = phi_1842_;
    if _e270 {
        return false;
    }
    let _e271 = target_3;
    param_801 = _e271;
    let _e272 = getIndex_u0028_vi3_u003b((&param_801));
    targetIndex_3 = _e272;
    let _e273 = targetIndex_3;
    param_802 = _e273;
    let _e274 = readCell_u0028_u1_u003b((&param_802));
    param_803 = _e274;
    let _e275 = getType_u0028_u1_u003b((&param_803));
    if (_e275 != 0u) {
        return false;
    }
    let _e277 = (*rawValue_10);
    param_804 = _e277;
    let _e278 = getType_u0028_u1_u003b((&param_804));
    let _e279 = (*rawValue_10);
    param_805 = _e279;
    let _e280 = getDir_u0028_u1_u003b((&param_805));
    let _e281 = (*rawValue_10);
    param_806 = _e281;
    let _e282 = getAge_u0028_u1_u003b((&param_806));
    param_807 = _e278;
    param_808 = _e280;
    param_809 = 0u;
    param_810 = _e282;
    let _e283 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_807), (&param_808), (&param_809), (&param_810));
    let _e284 = (*currentIndex_12);
    param_811 = _e284;
    let _e285 = (*rawValue_10);
    param_812 = _e285;
    let _e286 = targetIndex_3;
    param_813 = _e286;
    param_814 = _e283;
    let _e287 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_811), (&param_812), (&param_813), (&param_814));
    return _e287;
}

fn dominantAxis_u0028_vf3_u003b_f1_u003b(dir_6: ptr<function, vec3<f32>>, relative: ptr<function, f32>) -> vec3<i32> {
    var a: vec3<f32>;
    var m: f32;

    let _e204 = (*dir_6);
    a = abs(_e204);
    let _e207 = a[0u];
    let _e209 = a[1u];
    let _e211 = a[2u];
    m = max(_e207, max(_e209, _e211));
    let _e214 = m;
    if (_e214 <= 0f) {
        return vec3<i32>(0i, 0i, 0i);
    }
    let _e216 = a;
    let _e217 = m;
    let _e218 = (*relative);
    let _e223 = (*dir_6);
    return (select(vec3<i32>(0i, 0i, 0i), vec3<i32>(1i, 1i, 1i), (_e216 >= vec3((_e217 * _e218)))) * vec3<i32>(sign(_e223)));
}

fn bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b(k_1: ptr<function, i32>, planeCount: ptr<function, i32>, seed: ptr<function, f32>) -> vec3<f32> {
    var z_4: f32;
    var r_4: f32;
    var a_1: f32;

    let _e206 = (*k_1);
    let _e209 = (*planeCount);
    z_4 = ((f32(_e206) + 0.5f) / f32(_e209));
    let _e212 = z_4;
    let _e213 = z_4;
    r_4 = sqrt(max(0f, (1f - (_e212 * _e213))));
    let _e218 = (*k_1);
    let _e221 = (*seed);
    a_1 = ((2.399963f * f32(_e218)) + _e221);
    let _e223 = r_4;
    let _e224 = a_1;
    let _e227 = z_4;
    let _e228 = r_4;
    let _e229 = a_1;
    return vec3<f32>((_e223 * cos(_e224)), _e227, (_e228 * sin(_e229)));
}

fn hash_u0028_vf3_u003b(p_4: ptr<function, vec3<f32>>) -> f32 {
    let _e201 = (*p_4);
    return fract((sin(dot(_e201, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
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

    let _e217 = (*pos_17);
    let _e218 = (*center);
    radial = normalize(vec3<f32>((_e217 - _e218)));
    let _e223 = tuning.blackHoleOrbitPlanes;
    planeCount_1 = bitcast<i32>(clamp(_e223, 1u, 32u));
    let _e226 = (*center);
    param_815 = (vec3<f32>(_e226) + vec3<f32>(29f, 3f, 71f));
    let _e229 = hash_u0028_vf3_u003b((&param_815));
    seed_1 = (_e229 * 6.28318f);
    best = vec3<f32>(0f, 1f, 0f);
    bestAlign = 2f;
    bestK = 0i;
    k_2 = 0i;
    loop {
        let _e231 = k_2;
        let _e232 = planeCount_1;
        if (_e231 < _e232) {
            let _e234 = k_2;
            param_816 = _e234;
            let _e235 = planeCount_1;
            param_817 = _e235;
            let _e236 = seed_1;
            param_818 = _e236;
            let _e237 = bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b((&param_816), (&param_817), (&param_818));
            n_2 = _e237;
            let _e238 = n_2;
            let _e239 = radial;
            align = abs(dot(_e238, _e239));
            let _e242 = align;
            let _e243 = bestAlign;
            if (_e242 < _e243) {
                let _e245 = align;
                bestAlign = _e245;
                let _e246 = n_2;
                best = _e246;
                let _e247 = k_2;
                bestK = _e247;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e248 = k_2;
            k_2 = (_e248 + 1i);
        }
    }
    let _e250 = (*center);
    let _e252 = bestK;
    param_819 = (vec3<f32>(_e250) + vec3<f32>((f32(_e252) * 13f), 101f, 47f));
    let _e257 = hash_u0028_vf3_u003b((&param_819));
    sense = select(1f, -1f, (_e257 < 0.5f));
    let _e260 = best;
    let _e261 = sense;
    return (_e260 * _e261);
}

fn bhIsPurge_u0028_u1_u003b(code: ptr<function, u32>) -> bool {
    let _e201 = (*code);
    return ((_e201 & 1073741824u) != 0u);
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e201 = (*level);
    return (f32(_e201) + 0.5f);
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
    var phi_2105_: bool;

    let _e278 = (*rawValue_11);
    param_820 = _e278;
    let _e279 = getType_u0028_u1_u003b((&param_820));
    type_37 = _e279;
    let _e280 = (*rawValue_11);
    param_821 = _e280;
    let _e281 = getSleep_u0028_u1_u003b((&param_821));
    sleep_1 = _e281;
    let _e282 = (*slot);
    unnamed_2.blackHoleStarve[_e282] = 0u;
    let _e285 = (*dist_1);
    let _e286 = (*level_1);
    param_822 = _e286;
    let _e287 = bhBodyRadius_u0028_u1_u003b((&param_822));
    let _e289 = tuning.blackHoleHorizon;
    if (_e285 <= (_e287 + f32(_e289))) {
        let _e293 = (*currentIndex_13);
        let _e296 = (*rawValue_11);
        let _e297 = atomicCompareExchangeWeak((&unnamed.grid[_e293]), _e296, 0u);
        let _e299 = (*rawValue_11);
        if (_e297.old_value == _e299) {
            let _e301 = (*slot);
            let _e304 = atomicLoad((&unnamed_2.blackHoles[_e301]));
            param_823 = _e304;
            let _e305 = bhIsPurge_u0028_u1_u003b((&param_823));
            if !(_e305) {
                let _e307 = (*slot);
                let _e310 = atomicAdd((&unnamed_2.blackHoleMass[_e307]), 1u);
            }
            let _e311 = type_37;
            if (_e311 == 2u) {
                decWater_u0028_();
            }
        }
        return;
    }
    let _e313 = (*purge);
    if _e313 {
        let _e315 = tuning.purgeOrbitSpeed;
        local_27 = _e315;
    } else {
        let _e317 = tuning.blackHoleOrbitSpeed;
        local_27 = _e317;
    }
    let _e318 = local_27;
    orbitSpeed = _e318;
    let _e319 = (*purge);
    if _e319 {
        let _e321 = tuning.purgeInfall;
        local_28 = _e321;
    } else {
        let _e323 = tuning.blackHoleInfall;
        local_28 = _e323;
    }
    let _e324 = local_28;
    infallChance = _e324;
    let _e325 = (*randVal_12);
    let _e326 = orbitSpeed;
    let _e327 = (*dist_1);
    if (_e325 > clamp((_e326 / sqrt(max(_e327, 1f))), 0f, 1f)) {
        let _e333 = sleep_1;
        if (_e333 != 0u) {
            let _e335 = (*currentIndex_13);
            let _e338 = (*rawValue_11);
            let _e339 = (*rawValue_11);
            param_824 = _e339;
            let _e340 = getDir_u0028_u1_u003b((&param_824));
            let _e341 = (*rawValue_11);
            param_825 = _e341;
            let _e342 = getAge_u0028_u1_u003b((&param_825));
            let _e343 = type_37;
            param_826 = _e343;
            param_827 = _e340;
            param_828 = 0u;
            param_829 = _e342;
            let _e344 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_826), (&param_827), (&param_828), (&param_829));
            let _e345 = atomicCompareExchangeWeak((&unnamed.grid[_e335]), _e338, _e344);
        }
        return;
    }
    let _e347 = (*center_1);
    let _e348 = (*pos_18);
    inward = normalize(vec3<f32>((_e347 - _e348)));
    let _e352 = (*center_1);
    param_830 = _e352;
    let _e353 = (*pos_18);
    param_831 = _e353;
    let _e354 = bhOrbitAxis_u0028_vi3_u003b_vi3_u003b((&param_830), (&param_831));
    axis = _e354;
    let _e355 = axis;
    let _e356 = inward;
    tangent = cross(_e355, _e356);
    let _e358 = tangent;
    tangentLen = length(_e358);
    let _e360 = tangentLen;
    if (_e360 < 0.05f) {
        let _e362 = axis;
        tangent = normalize(cross(_e362, vec3<f32>(0.577f, 0.577f, 0.577f)));
    } else {
        let _e365 = tangentLen;
        let _e366 = tangent;
        tangent = (_e366 / vec3(_e365));
    }
    let _e369 = (*pos_18);
    let _e370 = (*center_1);
    let _e373 = axis;
    axial = dot(vec3<f32>((_e369 - _e370)), _e373);
    let _e375 = axis;
    let _e377 = axial;
    let _e382 = tuning.blackHolePlaneGrip;
    grip = ((-(_e375) * clamp((_e377 * 0.5f), -1f, 1f)) * _e382);
    let _e384 = tangent;
    let _e385 = grip;
    along = normalize((_e384 + _e385));
    let _e388 = (*randVal_12);
    let _e391 = infallChance;
    pullIn = (fract((_e388 * 61f)) < clamp(_e391, 0f, 1f));
    let _e394 = inward;
    let _e395 = tangent;
    spiral = normalize((_e394 + (_e395 * 0.6f)));
    let _e399 = pullIn;
    phi_2105_ = _e399;
    if _e399 {
        let _e400 = spiral;
        param_832 = _e400;
        param_833 = 0.55f;
        let _e401 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_832), (&param_833));
        let _e402 = (*pos_18);
        param_834 = _e402;
        let _e403 = (*currentIndex_13);
        param_835 = _e403;
        let _e404 = (*rawValue_11);
        param_836 = _e404;
        param_837 = _e401;
        let _e405 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_834), (&param_835), (&param_836), (&param_837));
        phi_2105_ = _e405;
    }
    let _e407 = phi_2105_;
    if _e407 {
        return;
    }
    let _e408 = along;
    param_838 = _e408;
    param_839 = 0.55f;
    let _e409 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_838), (&param_839));
    let _e410 = (*pos_18);
    param_840 = _e410;
    let _e411 = (*currentIndex_13);
    param_841 = _e411;
    let _e412 = (*rawValue_11);
    param_842 = _e412;
    param_843 = _e409;
    let _e413 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_840), (&param_841), (&param_842), (&param_843));
    if _e413 {
        return;
    }
    let _e414 = along;
    param_844 = _e414;
    param_845 = 1f;
    let _e415 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_844), (&param_845));
    let _e416 = (*pos_18);
    param_846 = _e416;
    let _e417 = (*currentIndex_13);
    param_847 = _e417;
    let _e418 = (*rawValue_11);
    param_848 = _e418;
    param_849 = _e415;
    let _e419 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_846), (&param_847), (&param_848), (&param_849));
    if _e419 {
        return;
    }
    let _e420 = tangent;
    param_850 = _e420;
    param_851 = 1f;
    let _e421 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_850), (&param_851));
    let _e422 = (*pos_18);
    param_852 = _e422;
    let _e423 = (*currentIndex_13);
    param_853 = _e423;
    let _e424 = (*rawValue_11);
    param_854 = _e424;
    param_855 = _e421;
    let _e425 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_852), (&param_853), (&param_854), (&param_855));
    if _e425 {
        return;
    }
    let _e426 = inward;
    param_856 = _e426;
    param_857 = 0.55f;
    let _e427 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_856), (&param_857));
    let _e428 = (*pos_18);
    param_858 = _e428;
    let _e429 = (*currentIndex_13);
    param_859 = _e429;
    let _e430 = (*rawValue_11);
    param_860 = _e430;
    param_861 = _e427;
    let _e431 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_858), (&param_859), (&param_860), (&param_861));
    if _e431 {
        return;
    }
    let _e432 = inward;
    param_862 = _e432;
    param_863 = 1f;
    let _e433 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_862), (&param_863));
    let _e434 = (*pos_18);
    param_864 = _e434;
    let _e435 = (*currentIndex_13);
    param_865 = _e435;
    let _e436 = (*rawValue_11);
    param_866 = _e436;
    param_867 = _e433;
    let _e437 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_864), (&param_865), (&param_866), (&param_867));
    if _e437 {
        return;
    }
    let _e438 = sleep_1;
    if (_e438 != 0u) {
        let _e440 = (*currentIndex_13);
        let _e443 = (*rawValue_11);
        let _e444 = (*rawValue_11);
        param_868 = _e444;
        let _e445 = getDir_u0028_u1_u003b((&param_868));
        let _e446 = (*rawValue_11);
        param_869 = _e446;
        let _e447 = getAge_u0028_u1_u003b((&param_869));
        let _e448 = type_37;
        param_870 = _e448;
        param_871 = _e445;
        param_872 = 0u;
        param_873 = _e447;
        let _e449 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_870), (&param_871), (&param_872), (&param_873));
        let _e450 = atomicCompareExchangeWeak((&unnamed.grid[_e440]), _e443, _e449);
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
        let _e206 = l;
        let _e208 = tuning.blackHoleMaxLevel;
        if (_e206 <= min(_e208, 16u)) {
            let _e211 = l;
            param_874 = _e211;
            let _e212 = bhBodyRadius_u0028_u1_u003b((&param_874));
            r_5 = _e212;
            let _e213 = r_5;
            let _e215 = r_5;
            let _e217 = r_5;
            volume = (((4.18879f * _e213) * _e215) * _e217);
            let _e219 = (*mass);
            let _e222 = tuning.blackHoleGrowthCost;
            let _e223 = volume;
            if (f32(_e219) < (_e222 * _e223)) {
                break;
            }
            let _e226 = l;
            level_2 = _e226;
            continue;
        } else {
            break;
        }
        continuing {
            let _e227 = l;
            l = (_e227 + bitcast<u32>(1i));
        }
    }
    let _e230 = level_2;
    return _e230;
}

fn bhLevelFor_u0028_u1_u003b_u1_u003b(code_1: ptr<function, u32>, mass_1: ptr<function, u32>) -> u32 {
    var param_875: u32;
    var param_876: u32;

    let _e204 = (*code_1);
    param_875 = _e204;
    let _e205 = bhIsPurge_u0028_u1_u003b((&param_875));
    if _e205 {
        let _e207 = tuning.purgeLevel;
        let _e209 = (*mass_1);
        let _e212 = tuning.purgeMass;
        return u32((f32(_e207) * clamp((f32(_e209) / f32(max(_e212, 1u))), 0f, 1f)));
    }
    let _e219 = (*mass_1);
    param_876 = _e219;
    let _e220 = bhLevel_u0028_u1_u003b((&param_876));
    return _e220;
}

fn bhDecode_u0028_u1_u003b(code_2: ptr<function, u32>) -> vec3<i32> {
    var i_24: u32;

    let _e202 = (*code_2);
    i_24 = (_e202 & 1073741823u);
    let _e204 = i_24;
    let _e206 = tuning.gridWidth;
    let _e211 = i_24;
    let _e213 = tuning.gridWidth;
    let _e218 = tuning.gridHeight;
    let _e223 = i_24;
    let _e225 = tuning.gridWidth;
    let _e228 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e204 % bitcast<u32>(bitcast<i32>(_e206)))), bitcast<i32>(((_e211 / bitcast<u32>(bitcast<i32>(_e213))) % bitcast<u32>(bitcast<i32>(_e218)))), bitcast<i32>((_e223 / bitcast<u32>((bitcast<i32>(_e225) * bitcast<i32>(_e228))))));
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

    let _e234 = unnamed_2.blackHoleCount;
    if (_e234 == 0u) {
        return false;
    }
    bestDistSq = 3000000000f;
    bestCenter = vec3<i32>(0i, 0i, 0i);
    bestSlot = -1i;
    bestLevel = 0u;
    bestPurge = false;
    let _e237 = tuning.blackHoleRadius;
    let _e239 = tuning.blackHoleMaxLevel;
    maxRadius = f32((_e237 + min(_e239, 16u)));
    let _e243 = maxRadius;
    let _e244 = maxRadius;
    maxRadiusSq = (_e243 * _e244);
    i_25 = 0i;
    loop {
        let _e246 = i_25;
        if (_e246 < 8i) {
            let _e248 = i_25;
            let _e251 = atomicLoad((&unnamed_2.blackHoles[_e248]));
            code_3 = _e251;
            let _e252 = code_3;
            if (_e252 == 0u) {
                continue;
            }
            let _e254 = code_3;
            param_877 = _e254;
            let _e255 = bhDecode_u0028_u1_u003b((&param_877));
            center_2 = _e255;
            let _e256 = center_2;
            let _e257 = (*pos_19);
            d_23 = vec3<f32>((_e256 - _e257));
            let _e260 = d_23;
            let _e261 = d_23;
            distSq = dot(_e260, _e261);
            let _e263 = code_3;
            param_878 = _e263;
            let _e264 = bhIsPurge_u0028_u1_u003b((&param_878));
            purge_1 = _e264;
            let _e265 = purge_1;
            let _e267 = distSq;
            let _e268 = maxRadiusSq;
            if (!(_e265) && (_e267 > _e268)) {
                continue;
            }
            let _e271 = distSq;
            let _e272 = bestDistSq;
            if (_e271 >= _e272) {
                continue;
            }
            let _e274 = i_25;
            let _e275 = code_3;
            param_879 = _e275;
            let _e278 = atomicLoad((&unnamed_2.blackHoleMass[_e274]));
            param_880 = _e278;
            let _e279 = bhLevelFor_u0028_u1_u003b_u1_u003b((&param_879), (&param_880));
            level_3 = _e279;
            let _e280 = purge_1;
            if _e280 {
                local_29 = 1000000000f;
            } else {
                let _e282 = tuning.blackHoleRadius;
                let _e283 = level_3;
                local_29 = f32((_e282 + _e283));
            }
            let _e286 = local_29;
            radius = _e286;
            let _e287 = distSq;
            let _e288 = radius;
            let _e289 = radius;
            if (_e287 <= (_e288 * _e289)) {
                let _e292 = distSq;
                bestDistSq = _e292;
                let _e293 = center_2;
                bestCenter = _e293;
                let _e294 = i_25;
                bestSlot = _e294;
                let _e295 = level_3;
                bestLevel = _e295;
                let _e296 = purge_1;
                bestPurge = _e296;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e297 = i_25;
            i_25 = (_e297 + 1i);
        }
    }
    let _e299 = bestSlot;
    if (_e299 < 0i) {
        return false;
    }
    let _e301 = bestDistSq;
    let _e303 = (*pos_19);
    param_881 = _e303;
    let _e304 = (*currentIndex_14);
    param_882 = _e304;
    let _e305 = (*rawValue_12);
    param_883 = _e305;
    let _e306 = bestCenter;
    param_884 = _e306;
    let _e307 = bestSlot;
    param_885 = _e307;
    let _e308 = bestLevel;
    param_886 = _e308;
    let _e309 = bestPurge;
    param_887 = _e309;
    param_888 = sqrt(_e301);
    let _e310 = (*randVal_13);
    param_889 = _e310;
    updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b((&param_881), (&param_882), (&param_883), (&param_884), (&param_885), (&param_886), (&param_887), (&param_888), (&param_889));
    return true;
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x_4: ptr<function, i32>, z_5: ptr<function, i32>) -> u32 {
    let _e202 = (*x_4);
    let _e203 = (*z_5);
    let _e205 = tuning.gridWidth;
    return (bitcast<u32>((_e202 + (_e203 * bitcast<i32>(_e205)))) * 4u);
}

fn bhRegister_u0028_vi3_u003b(p_5: ptr<function, vec3<i32>>) -> bool {
    var code_4: u32;
    var param_890: vec3<i32>;
    var i_26: i32;

    let _e204 = (*p_5);
    param_890 = _e204;
    let _e205 = getIndex_u0028_vi3_u003b((&param_890));
    code_4 = (2147483648u | _e205);
    i_26 = 0i;
    loop {
        let _e207 = i_26;
        if (_e207 < 8i) {
            let _e209 = i_26;
            let _e212 = code_4;
            let _e213 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e209]), 0u, _e212);
            if (_e213.old_value == 0u) {
                let _e216 = i_26;
                atomicStore((&unnamed_2.blackHoleMass[_e216]), 0u);
                let _e219 = i_26;
                unnamed_2.blackHoleStarve[_e219] = 0u;
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e222 = i_26;
            i_26 = (_e222 + 1i);
        }
    }
    return false;
}

fn writeCell_u0028_u1_u003b_u1_u003b(index_1: ptr<function, u32>, value_2: ptr<function, u32>) {
    let _e202 = (*index_1);
    let _e203 = (*value_2);
    atomicStore((&unnamed.grid[_e202]), _e203);
    return;
}

fn lavaSpawnCoolness_u0028_u1_u003b(type_38: ptr<function, u32>) -> u32 {
    var param_891: u32;

    let _e202 = (*type_38);
    if (_e202 == 12u) {
        let _e204 = lavaSolidifyCoolness_u0028_();
        return _e204;
    }
    let _e205 = (*type_38);
    param_891 = _e205;
    let _e206 = isLava_u0028_u1_u003b((&param_891));
    if _e206 {
        let _e207 = (*type_38);
        let _e210 = tuning.lavaStageSize;
        return ((_e207 - 8u) * max(_e210, 1u));
    }
    return 0u;
}

fn locustSpawnCount_u0028_u1_u003b(type_39: ptr<function, u32>) -> u32 {
    var param_892: u32;

    let _e202 = (*type_39);
    param_892 = _e202;
    let _e203 = isLocust_u0028_u1_u003b((&param_892));
    if !(_e203) {
        return 0u;
    }
    let _e205 = (*type_39);
    let _e208 = locustStage_u0028_();
    let _e210 = locustMaxCount_u0028_();
    return min((((_e205 - 13u) + 1u) * _e208), _e210);
}

fn bhRelease_u0028_vi3_u003b(p_6: ptr<function, vec3<i32>>) {
    var code_5: u32;
    var param_893: vec3<i32>;
    var i_27: i32;

    let _e204 = (*p_6);
    param_893 = _e204;
    let _e205 = getIndex_u0028_vi3_u003b((&param_893));
    code_5 = (2147483648u | _e205);
    i_27 = 0i;
    loop {
        let _e207 = i_27;
        if (_e207 < 8i) {
            let _e209 = i_27;
            let _e212 = code_5;
            let _e213 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e209]), _e212, 0u);
            continue;
        } else {
            break;
        }
        continuing {
            let _e215 = i_27;
            i_27 = (_e215 + 1i);
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
    var phi_1567_: bool;
    var phi_1589_: bool;
    var phi_1610_: bool;

    let _e207 = pc.spawnSize;
    halfMin = (_e207 / 2i);
    let _e210 = pc.spawnSize;
    halfMax = ((_e210 - 1i) / 2i);
    let _e214 = (*pos_20)[0u];
    let _e216 = pc.spawnX;
    let _e217 = halfMin;
    let _e219 = (_e214 < (_e216 - _e217));
    phi_1567_ = _e219;
    if !(_e219) {
        let _e222 = (*pos_20)[0u];
        let _e224 = pc.spawnX;
        let _e225 = halfMax;
        phi_1567_ = (_e222 > (_e224 + _e225));
    }
    let _e229 = phi_1567_;
    if _e229 {
        return false;
    }
    let _e231 = (*pos_20)[1u];
    let _e233 = pc.spawnY;
    let _e234 = halfMin;
    let _e236 = (_e231 < (_e233 - _e234));
    phi_1589_ = _e236;
    if !(_e236) {
        let _e239 = (*pos_20)[1u];
        let _e241 = pc.spawnY;
        let _e242 = halfMax;
        phi_1589_ = (_e239 > (_e241 + _e242));
    }
    let _e246 = phi_1589_;
    if _e246 {
        return false;
    }
    let _e248 = (*pos_20)[2u];
    let _e250 = pc.spawnZ;
    let _e251 = halfMin;
    let _e253 = (_e248 < (_e250 - _e251));
    phi_1610_ = _e253;
    if !(_e253) {
        let _e256 = (*pos_20)[2u];
        let _e258 = pc.spawnZ;
        let _e259 = halfMax;
        phi_1610_ = (_e256 > (_e258 + _e259));
    }
    let _e263 = phi_1610_;
    if _e263 {
        return false;
    }
    let _e265 = pc.spawnShape;
    if (_e265 != 1i) {
        return true;
    }
    let _e268 = pc.spawnX;
    let _e271 = pc.spawnY;
    let _e274 = pc.spawnZ;
    let _e277 = halfMax;
    let _e278 = halfMin;
    center_3 = (vec3<f32>(f32(_e268), f32(_e271), f32(_e274)) + vec3((f32(((_e277 - _e278) + 1i)) * 0.5f)));
    let _e285 = (*pos_20);
    let _e289 = center_3;
    d_24 = ((vec3<f32>(_e285) + vec3(0.5f)) - _e289);
    let _e292 = pc.spawnSize;
    radius_1 = (f32(_e292) * 0.5f);
    let _e295 = d_24;
    let _e296 = d_24;
    let _e298 = radius_1;
    let _e299 = radius_1;
    return (dot(_e295, _e296) <= (_e298 * _e299));
}

fn tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(fromIndex: ptr<function, u32>, newValue_4: ptr<function, u32>, toIndex: ptr<function, u32>, expectedFromValue: ptr<function, u32>) -> bool {
    let _e204 = (*toIndex);
    let _e207 = (*newValue_4);
    let _e208 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e204]), 0u, _e207);
    if (_e208.old_value != 0u) {
        return false;
    }
    let _e211 = (*fromIndex);
    let _e214 = (*expectedFromValue);
    let _e215 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e211]), _e214, 0u);
    let _e217 = (*expectedFromValue);
    if (_e215.old_value != _e217) {
        let _e219 = (*toIndex);
        let _e222 = atomicExchange((&unnamed_1.cloudCells[_e219]), 0u);
        return false;
    }
    return true;
}

fn getCloudCounter_u0028_u1_u003b(v_5: ptr<function, u32>) -> u32 {
    let _e201 = (*v_5);
    return ((_e201 >> bitcast<u32>(3i)) & 2047u);
}

fn getCloudTarget_u0028_u1_u003b(v_6: ptr<function, u32>) -> u32 {
    let _e201 = (*v_6);
    return ((_e201 >> bitcast<u32>(14i)) & 2047u);
}

fn easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b(current: ptr<function, u32>, target_4: ptr<function, f32>, rate: ptr<function, f32>) -> u32 {
    var old: f32;
    var next: f32;

    let _e205 = (*current);
    old = f32(_e205);
    let _e207 = old;
    let _e208 = (*target_4);
    let _e209 = old;
    let _e211 = (*rate);
    next = (_e207 + ((_e208 - _e209) * _e211));
    let _e214 = (*target_4);
    let _e215 = old;
    if (_e214 > _e215) {
        let _e217 = next;
        let _e218 = old;
        let _e221 = old;
        let _e222 = (*target_4);
        next = clamp(max(_e217, (_e218 + 1f)), _e221, _e222);
    } else {
        let _e224 = (*target_4);
        let _e225 = old;
        if (_e224 < _e225) {
            let _e227 = next;
            let _e228 = old;
            let _e231 = (*target_4);
            let _e232 = old;
            next = clamp(min(_e227, (_e228 - 1f)), _e231, _e232);
        }
    }
    let _e234 = next;
    return u32(max(_e234, 0f));
}

fn updateCloudBlock_u0028_vi3_u003b(pos_21: ptr<function, vec3<i32>>) {
    var idx_4: u32;
    var param_894: vec3<i32>;
    var base: u32;
    var param_895: i32;
    var param_896: i32;
    var rate_1: f32;
    var tallied: u32;
    var param_897: u32;
    var param_898: f32;
    var param_899: f32;
    var param_900: u32;
    var param_901: f32;
    var param_902: f32;
    var cell: u32;
    var kind_1: u32;
    var param_903: u32;
    var param_904: vec3<i32>;
    var newCell: u32;
    var param_905: u32;
    var param_906: bool;
    var param_907: u32;
    var param_908: u32;
    var param_909: u32;
    var param_910: u32;
    var param_911: bool;
    var param_912: u32;
    var param_913: u32;
    var target_5: u32;
    var param_914: u32;
    var lo: u32;
    var hi: u32;
    var r_6: f32;
    var param_915: vec3<f32>;
    var param_916: u32;
    var param_917: bool;
    var param_918: u32;
    var param_919: u32;
    var counter_1: u32;
    var param_920: u32;
    var param_921: u32;
    var param_922: bool;
    var param_923: u32;
    var param_924: u32;
    var param_925: vec3<i32>;
    var g: u32;
    var param_926: u32;
    var param_927: u32;
    var param_928: u32;
    var param_929: u32;
    var param_930: u32;
    var param_931: u32;
    var randVal_14: f32;
    var param_932: vec3<f32>;
    var counter_2: u32;
    var param_933: u32;
    var target_6: u32;
    var param_934: u32;
    var upPos_2: vec3<i32>;
    var param_935: vec3<i32>;
    var param_936: vec3<i32>;
    var param_937: u32;
    var param_938: u32;
    var param_939: bool;
    var param_940: u32;
    var param_941: u32;
    var param_942: vec3<i32>;
    var param_943: u32;
    var param_944: u32;
    var param_945: u32;
    var param_946: u32;
    var dir_7: i32;
    var slide1_: vec3<i32>;
    var slide2_: vec3<i32>;
    var i_28: i32;
    var t_4: vec3<i32>;
    var param_947: vec3<i32>;
    var tIndex: u32;
    var param_948: vec3<i32>;
    var param_949: u32;
    var param_950: u32;
    var param_951: bool;
    var param_952: u32;
    var param_953: u32;
    var param_954: u32;
    var param_955: u32;
    var param_956: u32;
    var param_957: u32;
    var param_958: u32;
    var param_959: u32;
    var param_960: bool;
    var param_961: u32;
    var param_962: u32;
    var phi_8998_: bool;
    var phi_8999_: bool;
    var phi_9207_: bool;

    let _e293 = (*pos_21);
    param_894 = _e293;
    let _e294 = getIndex_u0028_vi3_u003b((&param_894));
    idx_4 = _e294;
    let _e296 = (*pos_21)[0u];
    param_895 = _e296;
    let _e298 = (*pos_21)[2u];
    param_896 = _e298;
    let _e299 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_895), (&param_896));
    base = _e299;
    let _e301 = (*pos_21)[1u];
    if (_e301 == 0i) {
        let _e304 = tuning.cloudSmoothRate;
        rate_1 = clamp(_e304, 0.01f, 1f);
        let _e306 = base;
        let _e310 = atomicLoad((&unnamed_2.cloudColumn[(_e306 + 0u)]));
        tallied = _e310;
        let _e311 = base;
        let _e313 = base;
        let _e315 = tallied;
        let _e320 = atomicLoad((&unnamed_2.cloudColumn[(_e313 + 2u)]));
        param_897 = _e320;
        param_898 = (f32(_e315) * 16f);
        let _e321 = rate_1;
        param_899 = _e321;
        let _e322 = easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b((&param_897), (&param_898), (&param_899));
        atomicStore((&unnamed_2.cloudColumn[(_e311 + 2u)]), _e322);
        let _e325 = tallied;
        if (_e325 > 0u) {
            let _e327 = base;
            let _e329 = base;
            let _e331 = base;
            let _e335 = atomicLoad((&unnamed_2.cloudColumn[(_e331 + 1u)]));
            let _e340 = atomicLoad((&unnamed_2.cloudColumn[(_e329 + 3u)]));
            param_900 = _e340;
            param_901 = (f32(_e335) * 16f);
            let _e341 = rate_1;
            param_902 = _e341;
            let _e342 = easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b((&param_900), (&param_901), (&param_902));
            atomicStore((&unnamed_2.cloudColumn[(_e327 + 3u)]), _e342);
        }
        let _e345 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e345 + 0u)]), 0u);
        let _e349 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e349 + 1u)]), 0u);
    }
    let _e353 = idx_4;
    let _e356 = atomicLoad((&unnamed_1.cloudCells[_e353]));
    cell = _e356;
    let _e357 = cell;
    param_903 = _e357;
    let _e358 = getCloudKind_u0028_u1_u003b((&param_903));
    kind_1 = _e358;
    let _e359 = kind_1;
    if (_e359 == 0u) {
        return;
    }
    let _e362 = atomicAdd((&unnamed_2.cloudBlockCount), 1u);
    let _e363 = base;
    let _e367 = atomicAdd((&unnamed_2.cloudColumn[(_e363 + 0u)]), 1u);
    let _e368 = base;
    let _e373 = (*pos_21)[1u];
    let _e375 = atomicMax((&unnamed_2.cloudColumn[(_e368 + 1u)]), bitcast<u32>(_e373));
    let _e378 = (*pos_21)[1u];
    let _e380 = atomicMin((&unnamed_2.cloudMinYAcc), bitcast<u32>(_e378));
    let _e383 = (*pos_21)[1u];
    let _e385 = atomicMax((&unnamed_2.cloudMaxYAcc), bitcast<u32>(_e383));
    let _e386 = kind_1;
    let _e387 = (_e386 == 1u);
    phi_8999_ = _e387;
    if _e387 {
        let _e389 = unnamed_2.rainPhase;
        let _e390 = (_e389 == 2u);
        phi_8998_ = _e390;
        if !(_e390) {
            let _e392 = (*pos_21);
            param_904 = _e392;
            let _e393 = cloudTouchesRain_u0028_vi3_u003b((&param_904));
            phi_8998_ = _e393;
        }
        let _e395 = phi_8998_;
        phi_8999_ = _e395;
    }
    let _e397 = phi_8999_;
    if _e397 {
        param_905 = 2u;
        param_906 = false;
        param_907 = 0u;
        param_908 = 0u;
        let _e398 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_905), (&param_906), (&param_907), (&param_908));
        newCell = _e398;
        let _e399 = idx_4;
        let _e402 = cell;
        let _e403 = newCell;
        let _e404 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e399]), _e402, _e403);
        let _e406 = cell;
        if (_e404.old_value != _e406) {
            return;
        }
        let _e408 = newCell;
        cell = _e408;
        kind_1 = 2u;
    }
    let _e410 = (*pos_21)[1u];
    let _e412 = tuning.gridHeight;
    if (_e410 >= (bitcast<i32>(_e412) - 2i)) {
        let _e416 = kind_1;
        if (_e416 != 2u) {
            let _e418 = cell;
            param_909 = _e418;
            let _e419 = getCloudMoved_u0028_u1_u003b((&param_909));
            if _e419 {
                let _e420 = idx_4;
                let _e423 = cell;
                let _e424 = kind_1;
                param_910 = _e424;
                param_911 = false;
                param_912 = 0u;
                param_913 = 0u;
                let _e425 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_910), (&param_911), (&param_912), (&param_913));
                let _e426 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e420]), _e423, _e425);
            }
            return;
        }
        let _e428 = cell;
        param_914 = _e428;
        let _e429 = getCloudTarget_u0028_u1_u003b((&param_914));
        target_5 = _e429;
        let _e430 = target_5;
        if (_e430 == 0u) {
            let _e433 = tuning.rainWaitMinTicks;
            let _e435 = tuning.rainWaitMaxTicks;
            lo = min(_e433, _e435);
            let _e438 = tuning.rainWaitMinTicks;
            let _e440 = tuning.rainWaitMaxTicks;
            hi = max(_e438, _e440);
            let _e442 = (*pos_21);
            let _e445 = pc.time;
            param_915 = (vec3<f32>(_e442) + vec3<f32>(_e445, 17f, 3f));
            let _e448 = hash_u0028_vf3_u003b((&param_915));
            r_6 = _e448;
            let _e449 = lo;
            let _e450 = r_6;
            let _e451 = hi;
            let _e452 = lo;
            target_5 = (_e449 + u32((_e450 * f32(((_e451 - _e452) + 1u)))));
            let _e459 = idx_4;
            let _e462 = cell;
            param_916 = 2u;
            param_917 = false;
            param_918 = 0u;
            let _e463 = target_5;
            param_919 = _e463;
            let _e464 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_916), (&param_917), (&param_918), (&param_919));
            let _e465 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e459]), _e462, _e464);
            return;
        }
        let _e467 = cell;
        param_920 = _e467;
        let _e468 = getCloudCounter_u0028_u1_u003b((&param_920));
        counter_1 = _e468;
        let _e469 = counter_1;
        let _e470 = target_5;
        if (_e469 < _e470) {
            let _e472 = idx_4;
            let _e475 = cell;
            let _e476 = counter_1;
            param_921 = 2u;
            param_922 = false;
            param_923 = (_e476 + 1u);
            let _e478 = target_5;
            param_924 = _e478;
            let _e479 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_921), (&param_922), (&param_923), (&param_924));
            let _e480 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e472]), _e475, _e479);
            return;
        }
        let _e482 = (*pos_21);
        param_925 = _e482;
        let _e483 = cloudCellInBounds_u0028_vi3_u003b((&param_925));
        if !(_e483) {
            return;
        }
        let _e485 = idx_4;
        param_926 = _e485;
        let _e486 = readCell_u0028_u1_u003b((&param_926));
        g = _e486;
        let _e487 = g;
        param_927 = _e487;
        let _e488 = getType_u0028_u1_u003b((&param_927));
        if (_e488 != 0u) {
            return;
        }
        let _e490 = idx_4;
        let _e493 = g;
        param_928 = 2u;
        param_929 = 0u;
        param_930 = 0u;
        param_931 = 0u;
        let _e494 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_928), (&param_929), (&param_930), (&param_931));
        let _e495 = atomicCompareExchangeWeak((&unnamed.grid[_e490]), _e493, _e494);
        let _e497 = g;
        if (_e495.old_value != _e497) {
            return;
        }
        let _e499 = idx_4;
        let _e502 = atomicExchange((&unnamed_1.cloudCells[_e499]), 0u);
        incWater_u0028_();
        let _e504 = (*pos_21)[1u];
        let _e507 = atomicLoad((&unnamed_2.maxOccupiedY));
        if (bitcast<u32>(_e504) > _e507) {
            let _e511 = (*pos_21)[1u];
            let _e513 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e511));
        }
        return;
    }
    let _e514 = (*pos_21);
    let _e517 = pc.time;
    param_932 = (vec3<f32>(_e514) + vec3<f32>((_e517 * 2.3f), 7f, 13f));
    let _e521 = hash_u0028_vf3_u003b((&param_932));
    randVal_14 = _e521;
    let _e522 = cell;
    param_933 = _e522;
    let _e523 = getCloudCounter_u0028_u1_u003b((&param_933));
    counter_2 = _e523;
    let _e524 = cell;
    param_934 = _e524;
    let _e525 = getCloudTarget_u0028_u1_u003b((&param_934));
    target_6 = _e525;
    let _e526 = (*pos_21);
    upPos_2 = (_e526 + vec3<i32>(0i, 1i, 0i));
    let _e528 = upPos_2;
    param_935 = _e528;
    let _e529 = cloudCellInBounds_u0028_vi3_u003b((&param_935));
    phi_9207_ = _e529;
    if _e529 {
        let _e530 = upPos_2;
        param_936 = _e530;
        let _e531 = getIndex_u0028_vi3_u003b((&param_936));
        let _e534 = atomicLoad((&unnamed_1.cloudCells[_e531]));
        param_937 = _e534;
        let _e535 = getCloudKind_u0028_u1_u003b((&param_937));
        phi_9207_ = (_e535 == 0u);
    }
    let _e538 = phi_9207_;
    if _e538 {
        let _e539 = kind_1;
        param_938 = _e539;
        param_939 = true;
        let _e540 = counter_2;
        param_940 = _e540;
        let _e541 = target_6;
        param_941 = _e541;
        let _e542 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_938), (&param_939), (&param_940), (&param_941));
        let _e543 = upPos_2;
        param_942 = _e543;
        let _e544 = getIndex_u0028_vi3_u003b((&param_942));
        let _e545 = idx_4;
        param_943 = _e545;
        param_944 = _e542;
        param_945 = _e544;
        let _e546 = cell;
        param_946 = _e546;
        let _e547 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_943), (&param_944), (&param_945), (&param_946));
        if _e547 {
            let _e549 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
            return;
        }
    }
    let _e550 = randVal_14;
    dir_7 = select(-1i, 1i, (fract((_e550 * 10f)) > 0.5f));
    let _e555 = randVal_14;
    if (fract((_e555 * 100f)) > 0.5f) {
        let _e559 = (*pos_21);
        let _e560 = dir_7;
        slide1_ = (_e559 + vec3<i32>(_e560, 1i, 0i));
        let _e563 = (*pos_21);
        let _e564 = dir_7;
        slide2_ = (_e563 + vec3<i32>(0i, 1i, _e564));
    } else {
        let _e567 = (*pos_21);
        let _e568 = dir_7;
        slide1_ = (_e567 + vec3<i32>(0i, 1i, _e568));
        let _e571 = (*pos_21);
        let _e572 = dir_7;
        slide2_ = (_e571 + vec3<i32>(_e572, 1i, 0i));
    }
    i_28 = 0i;
    loop {
        let _e575 = i_28;
        if (_e575 < 2i) {
            let _e577 = i_28;
            let _e579 = slide1_;
            let _e580 = slide2_;
            t_4 = select(_e580, _e579, vec3((_e577 == 0i)));
            let _e583 = t_4;
            param_947 = _e583;
            let _e584 = cloudCellInBounds_u0028_vi3_u003b((&param_947));
            if !(_e584) {
                continue;
            }
            let _e586 = t_4;
            param_948 = _e586;
            let _e587 = getIndex_u0028_vi3_u003b((&param_948));
            tIndex = _e587;
            let _e588 = tIndex;
            let _e591 = atomicLoad((&unnamed_1.cloudCells[_e588]));
            param_949 = _e591;
            let _e592 = getCloudKind_u0028_u1_u003b((&param_949));
            if (_e592 != 0u) {
                continue;
            }
            let _e594 = kind_1;
            param_950 = _e594;
            param_951 = true;
            let _e595 = counter_2;
            param_952 = _e595;
            let _e596 = target_6;
            param_953 = _e596;
            let _e597 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_950), (&param_951), (&param_952), (&param_953));
            let _e598 = idx_4;
            param_954 = _e598;
            param_955 = _e597;
            let _e599 = tIndex;
            param_956 = _e599;
            let _e600 = cell;
            param_957 = _e600;
            let _e601 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_954), (&param_955), (&param_956), (&param_957));
            if _e601 {
                let _e603 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e604 = i_28;
            i_28 = (_e604 + 1i);
        }
    }
    let _e606 = cell;
    param_958 = _e606;
    let _e607 = getCloudMoved_u0028_u1_u003b((&param_958));
    if _e607 {
        let _e608 = idx_4;
        let _e611 = cell;
        let _e612 = kind_1;
        param_959 = _e612;
        param_960 = false;
        let _e613 = counter_2;
        param_961 = _e613;
        let _e614 = target_6;
        param_962 = _e614;
        let _e615 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_959), (&param_960), (&param_961), (&param_962));
        let _e616 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e608]), _e611, _e615);
    }
    return;
}

fn updateSimState_u0028_() {
    var live: u32;
    var i_29: i32;
    var code_6: u32;
    var voxel: u32;
    var param_963: u32;
    var param_964: u32;
    var starve: u32;
    var purge_2: bool;
    var param_965: u32;
    var grace: u32;
    var local_30: u32;
    var decay: u32;
    var local_31: u32;
    var mass_2: u32;
    var param_966: u32;
    var param_967: u32;
    var movedLastTick: u32;
    var liveClouds: u32;
    var chargeTarget: f32;
    var charge: f32;
    var interval: u32;
    var phi_8157_: bool;
    var phi_8164_: bool;

    let _e222 = gl_GlobalInvocationID_1[0u];
    let _e223 = (_e222 != 0u);
    phi_8157_ = _e223;
    if !(_e223) {
        let _e226 = gl_GlobalInvocationID_1[1u];
        phi_8157_ = (_e226 != 0u);
    }
    let _e229 = phi_8157_;
    phi_8164_ = _e229;
    if !(_e229) {
        let _e232 = gl_GlobalInvocationID_1[2u];
        phi_8164_ = (_e232 != 0u);
    }
    let _e235 = phi_8164_;
    if _e235 {
        return;
    }
    live = 0u;
    i_29 = 0i;
    loop {
        let _e236 = i_29;
        if (_e236 < 8i) {
            let _e238 = i_29;
            let _e241 = atomicLoad((&unnamed_2.blackHoles[_e238]));
            code_6 = _e241;
            let _e242 = code_6;
            if (_e242 == 0u) {
                continue;
            }
            let _e244 = code_6;
            voxel = (_e244 & 1073741823u);
            let _e246 = voxel;
            param_963 = _e246;
            let _e247 = readCell_u0028_u1_u003b((&param_963));
            param_964 = _e247;
            let _e248 = getType_u0028_u1_u003b((&param_964));
            if (_e248 != 7u) {
                let _e250 = i_29;
                atomicStore((&unnamed_2.blackHoles[_e250]), 0u);
                continue;
            }
            let _e253 = i_29;
            let _e256 = unnamed_2.blackHoleStarve[_e253];
            starve = (_e256 + 1u);
            let _e258 = i_29;
            let _e259 = starve;
            unnamed_2.blackHoleStarve[_e258] = _e259;
            let _e262 = code_6;
            param_965 = _e262;
            let _e263 = bhIsPurge_u0028_u1_u003b((&param_965));
            purge_2 = _e263;
            let _e264 = purge_2;
            if _e264 {
                let _e266 = tuning.purgeStarveGrace;
                local_30 = _e266;
            } else {
                let _e268 = tuning.blackHoleStarveGrace;
                local_30 = _e268;
            }
            let _e269 = local_30;
            grace = _e269;
            let _e270 = purge_2;
            if _e270 {
                let _e272 = tuning.purgeDecayRate;
                local_31 = _e272;
            } else {
                let _e274 = tuning.blackHoleDecayRate;
                local_31 = _e274;
            }
            let _e275 = local_31;
            decay = _e275;
            let _e276 = starve;
            let _e277 = grace;
            if (_e276 > _e277) {
                let _e279 = i_29;
                let _e282 = atomicLoad((&unnamed_2.blackHoleMass[_e279]));
                mass_2 = _e282;
                let _e283 = mass_2;
                if (_e283 == 0u) {
                    let _e285 = voxel;
                    param_966 = _e285;
                    param_967 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_966), (&param_967));
                    let _e286 = i_29;
                    atomicStore((&unnamed_2.blackHoles[_e286]), 0u);
                    continue;
                }
                let _e289 = i_29;
                let _e290 = mass_2;
                let _e291 = mass_2;
                let _e292 = decay;
                atomicStore((&unnamed_2.blackHoleMass[_e289]), (_e290 - min(_e291, _e292)));
            }
            let _e297 = live;
            live = (_e297 + bitcast<u32>(1i));
            continue;
        } else {
            break;
        }
        continuing {
            let _e300 = i_29;
            i_29 = (_e300 + 1i);
        }
    }
    let _e302 = live;
    unnamed_2.blackHoleCount = _e302;
    let _e305 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (_e305 > 0u) {
        let _e308 = atomicAdd((&unnamed_2.maxOccupiedY), 4294967295u);
    }
    let _e310 = atomicLoad((&unnamed_2.rainCandidateCount));
    unnamed_2.rainCandidateEstimate = _e310;
    atomicStore((&unnamed_2.rainCandidateCount), 0u);
    let _e314 = unnamed_2.simTick;
    unnamed_2.simTick = (_e314 + 1u);
    let _e318 = atomicLoad((&unnamed_2.cloudMovedCount));
    movedLastTick = _e318;
    let _e320 = atomicLoad((&unnamed_2.cloudBlockCount));
    liveClouds = _e320;
    atomicStore((&unnamed_2.cloudBlockCount), 0u);
    atomicStore((&unnamed_2.cloudMovedCount), 0u);
    let _e324 = atomicLoad((&unnamed_2.cloudMinYAcc));
    unnamed_2.cloudMinY = _e324;
    let _e327 = atomicLoad((&unnamed_2.cloudMaxYAcc));
    unnamed_2.cloudMaxY = _e327;
    atomicStore((&unnamed_2.cloudMinYAcc), 4294967295u);
    atomicStore((&unnamed_2.cloudMaxYAcc), 0u);
    let _e332 = unnamed_2.rainPhase;
    chargeTarget = select(1f, 0f, (_e332 == 0u));
    let _e336 = unnamed_2.cloudChargeBits;
    charge = bitcast<f32>(_e336);
    let _e338 = chargeTarget;
    let _e339 = charge;
    let _e342 = tuning.cloudChargeEaseRate;
    let _e345 = charge;
    charge = (_e345 + ((_e338 - _e339) * clamp(_e342, 0f, 1f)));
    let _e347 = charge;
    unnamed_2.cloudChargeBits = bitcast<u32>(clamp(_e347, 0f, 1f));
    let _e352 = unnamed_2.rainPhase;
    if (_e352 == 0u) {
        let _e355 = tuning.cloudCheckIntervalTicks;
        interval = max(_e355, 1u);
        let _e358 = unnamed_2.simTick;
        let _e359 = interval;
        let _e362 = liveClouds;
        let _e365 = movedLastTick;
        if ((((_e358 % _e359) == 0u) && (_e362 > 0u)) && (_e365 == 0u)) {
            unnamed_2.rainPhase = 2u;
            let _e370 = pc.time;
            unnamed_2.rainPhaseTimeBits = bitcast<u32>(_e370);
            let _e374 = unnamed_2.simTick;
            unnamed_2.lastRainTick = _e374;
        }
    } else {
        let _e376 = liveClouds;
        if (_e376 == 0u) {
            unnamed_2.rainPhase = 0u;
            unnamed_2.rainPhaseTimeBits = 0u;
        }
    }
    return;
}

fn main_1() {
    var pos_22: vec3<i32>;
    var param_968: vec3<i32>;
    var param_969: vec3<i32>;
    var spawnIndex: u32;
    var param_970: vec3<i32>;
    var oldType: u32;
    var param_971: u32;
    var param_972: u32;
    var newType_3: u32;
    var param_973: vec3<i32>;
    var seedAge: u32;
    var param_974: u32;
    var local_32: u32;
    var param_975: u32;
    var param_976: u32;
    var param_977: u32;
    var param_978: u32;
    var param_979: u32;
    var param_980: u32;
    var param_981: u32;
    var param_982: u32;
    var param_983: vec3<i32>;
    var param_984: u32;
    var param_985: u32;
    var currentIndex_15: u32;
    var param_986: vec3<i32>;
    var rawValue_13: u32;
    var param_987: u32;
    var currentType_1: u32;
    var param_988: u32;
    var param_989: i32;
    var param_990: i32;
    var randVal_15: f32;
    var param_991: vec3<f32>;
    var param_992: vec3<i32>;
    var param_993: u32;
    var param_994: u32;
    var param_995: f32;
    var currentDir_6: u32;
    var param_996: u32;
    var currentSleep_7: u32;
    var param_997: u32;
    var currentAge_10: u32;
    var param_998: u32;
    var param_999: vec3<i32>;
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
    var param_1010: u32;
    var param_1011: f32;
    var param_1012: vec3<i32>;
    var param_1013: u32;
    var param_1014: u32;
    var param_1015: u32;
    var param_1016: u32;
    var param_1017: u32;
    var param_1018: f32;
    var param_1019: vec3<i32>;
    var param_1020: u32;
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
    var param_1031: f32;
    var param_1032: vec3<i32>;
    var param_1033: u32;
    var param_1034: u32;
    var param_1035: u32;
    var param_1036: u32;
    var param_1037: u32;
    var param_1038: f32;
    var param_1039: vec3<i32>;
    var param_1040: u32;
    var param_1041: u32;
    var param_1042: u32;
    var param_1043: f32;
    var param_1044: vec3<i32>;
    var param_1045: u32;
    var param_1046: u32;
    var param_1047: u32;
    var param_1048: u32;
    var param_1049: u32;
    var param_1050: f32;
    var param_1051: vec3<i32>;
    var param_1052: u32;
    var param_1053: u32;
    var param_1054: u32;
    var param_1055: u32;
    var param_1056: f32;
    var param_1057: vec3<i32>;
    var param_1058: u32;
    var param_1059: u32;
    var param_1060: u32;
    var param_1061: f32;
    var phi_9357_: bool;
    var phi_9367_: bool;
    var phi_9383_: bool;
    var phi_9482_: bool;
    var phi_9489_: bool;
    var phi_9500_: bool;
    var phi_9507_: bool;
    var phi_9518_: bool;
    var phi_9541_: bool;
    var phi_9551_: bool;
    var phi_9609_: bool;

    let _e307 = gl_GlobalInvocationID_1;
    pos_22 = bitcast<vec3<i32>>(_e307);
    let _e310 = pos_22[0u];
    let _e312 = tuning.gridWidth;
    let _e314 = (_e310 >= bitcast<i32>(_e312));
    phi_9357_ = _e314;
    if !(_e314) {
        let _e317 = pos_22[1u];
        let _e319 = tuning.gridHeight;
        phi_9357_ = (_e317 >= bitcast<i32>(_e319));
    }
    let _e323 = phi_9357_;
    phi_9367_ = _e323;
    if !(_e323) {
        let _e326 = pos_22[2u];
        let _e328 = tuning.gridDepth;
        phi_9367_ = (_e326 >= bitcast<i32>(_e328));
    }
    let _e332 = phi_9367_;
    if _e332 {
        return;
    }
    updateSimState_u0028_();
    let _e333 = pos_22;
    param_968 = _e333;
    updateCloudBlock_u0028_vi3_u003b((&param_968));
    let _e335 = pc.spawnActive;
    let _e336 = (_e335 == 1i);
    phi_9383_ = _e336;
    if _e336 {
        let _e337 = pos_22;
        param_969 = _e337;
        let _e338 = inBrush_u0028_vi3_u003b((&param_969));
        phi_9383_ = _e338;
    }
    let _e340 = phi_9383_;
    if _e340 {
        let _e341 = pos_22;
        param_970 = _e341;
        let _e342 = getIndex_u0028_vi3_u003b((&param_970));
        spawnIndex = _e342;
        let _e343 = spawnIndex;
        param_971 = _e343;
        let _e344 = readCell_u0028_u1_u003b((&param_971));
        param_972 = _e344;
        let _e345 = getType_u0028_u1_u003b((&param_972));
        oldType = _e345;
        let _e347 = pc.spawnType;
        newType_3 = bitcast<u32>(_e347);
        let _e349 = newType_3;
        let _e351 = oldType;
        if ((_e349 != 7u) || (_e351 != 7u)) {
            let _e354 = oldType;
            let _e355 = newType_3;
            if (_e354 != _e355) {
                let _e357 = oldType;
                if (_e357 == 2u) {
                    decWater_u0028_();
                }
                let _e359 = oldType;
                if (_e359 == 7u) {
                    let _e361 = pos_22;
                    param_973 = _e361;
                    bhRelease_u0028_vi3_u003b((&param_973));
                }
                let _e362 = newType_3;
                if (_e362 == 2u) {
                    incWater_u0028_();
                }
            }
            let _e364 = newType_3;
            param_974 = _e364;
            let _e365 = isLocust_u0028_u1_u003b((&param_974));
            if _e365 {
                let _e366 = newType_3;
                param_975 = _e366;
                let _e367 = locustSpawnCount_u0028_u1_u003b((&param_975));
                local_32 = _e367;
            } else {
                let _e368 = newType_3;
                param_976 = _e368;
                let _e369 = lavaSpawnCoolness_u0028_u1_u003b((&param_976));
                local_32 = _e369;
            }
            let _e370 = local_32;
            seedAge = _e370;
            let _e371 = newType_3;
            param_977 = _e371;
            param_978 = 0u;
            param_979 = 0u;
            let _e372 = seedAge;
            param_980 = _e372;
            let _e373 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_977), (&param_978), (&param_979), (&param_980));
            let _e374 = spawnIndex;
            param_981 = _e374;
            param_982 = _e373;
            writeCell_u0028_u1_u003b_u1_u003b((&param_981), (&param_982));
            let _e375 = newType_3;
            if (_e375 == 7u) {
                let _e377 = pos_22;
                param_983 = _e377;
                let _e378 = bhRegister_u0028_vi3_u003b((&param_983));
                if !(_e378) {
                    let _e380 = spawnIndex;
                    param_984 = _e380;
                    param_985 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_984), (&param_985));
                }
            }
        }
    }
    let _e382 = pos_22[0u];
    let _e383 = (_e382 < 1i);
    phi_9482_ = _e383;
    if !(_e383) {
        let _e386 = pos_22[0u];
        let _e388 = tuning.gridWidth;
        phi_9482_ = (_e386 >= (bitcast<i32>(_e388) - 1i));
    }
    let _e393 = phi_9482_;
    phi_9489_ = _e393;
    if !(_e393) {
        let _e396 = pos_22[1u];
        phi_9489_ = (_e396 < 1i);
    }
    let _e399 = phi_9489_;
    phi_9500_ = _e399;
    if !(_e399) {
        let _e402 = pos_22[1u];
        let _e404 = tuning.gridHeight;
        phi_9500_ = (_e402 >= (bitcast<i32>(_e404) - 1i));
    }
    let _e409 = phi_9500_;
    phi_9507_ = _e409;
    if !(_e409) {
        let _e412 = pos_22[2u];
        phi_9507_ = (_e412 < 1i);
    }
    let _e415 = phi_9507_;
    phi_9518_ = _e415;
    if !(_e415) {
        let _e418 = pos_22[2u];
        let _e420 = tuning.gridDepth;
        phi_9518_ = (_e418 >= (bitcast<i32>(_e420) - 1i));
    }
    let _e425 = phi_9518_;
    if _e425 {
        return;
    }
    let _e426 = pos_22;
    param_986 = _e426;
    let _e427 = getIndex_u0028_vi3_u003b((&param_986));
    currentIndex_15 = _e427;
    let _e428 = currentIndex_15;
    param_987 = _e428;
    let _e429 = readCell_u0028_u1_u003b((&param_987));
    rawValue_13 = _e429;
    let _e430 = rawValue_13;
    param_988 = _e430;
    let _e431 = getType_u0028_u1_u003b((&param_988));
    currentType_1 = _e431;
    let _e432 = currentType_1;
    let _e433 = (_e432 == 0u);
    phi_9541_ = _e433;
    if _e433 {
        let _e435 = unnamed_2.rainPhase;
        phi_9541_ = (_e435 >= 1u);
    }
    let _e438 = phi_9541_;
    phi_9551_ = _e438;
    if _e438 {
        let _e440 = pos_22[1u];
        let _e442 = tuning.gridHeight;
        phi_9551_ = (_e440 == (bitcast<i32>(_e442) - 2i));
    }
    let _e447 = phi_9551_;
    if _e447 {
        let _e449 = pos_22[0u];
        param_989 = _e449;
        let _e451 = pos_22[2u];
        param_990 = _e451;
        let _e452 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_989), (&param_990));
        let _e456 = atomicLoad((&unnamed_2.cloudColumn[(_e452 + 2u)]));
        if (_e456 != 0u) {
            let _e459 = atomicAdd((&unnamed_2.rainCandidateCount), 1u);
        }
    }
    let _e460 = currentType_1;
    if (_e460 == 0u) {
        return;
    }
    let _e463 = pos_22[1u];
    let _e466 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (bitcast<u32>(_e463) > _e466) {
        let _e470 = pos_22[1u];
        let _e472 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e470));
    }
    let _e473 = pos_22;
    let _e476 = pc.time;
    param_991 = (vec3<f32>(_e473) + vec3(_e476));
    let _e479 = hash_u0028_vf3_u003b((&param_991));
    randVal_15 = _e479;
    let _e480 = currentType_1;
    let _e481 = (_e480 != 7u);
    phi_9609_ = _e481;
    if _e481 {
        let _e482 = pos_22;
        param_992 = _e482;
        let _e483 = currentIndex_15;
        param_993 = _e483;
        let _e484 = rawValue_13;
        param_994 = _e484;
        let _e485 = randVal_15;
        param_995 = _e485;
        let _e486 = captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b((&param_992), (&param_993), (&param_994), (&param_995));
        phi_9609_ = _e486;
    }
    let _e488 = phi_9609_;
    if _e488 {
        return;
    }
    let _e489 = currentType_1;
    let _e491 = currentType_1;
    if ((_e489 == 3u) || (_e491 == 7u)) {
        return;
    }
    let _e494 = rawValue_13;
    param_996 = _e494;
    let _e495 = getDir_u0028_u1_u003b((&param_996));
    currentDir_6 = _e495;
    let _e496 = rawValue_13;
    param_997 = _e496;
    let _e497 = getSleep_u0028_u1_u003b((&param_997));
    currentSleep_7 = _e497;
    let _e498 = rawValue_13;
    param_998 = _e498;
    let _e499 = getAge_u0028_u1_u003b((&param_998));
    currentAge_10 = _e499;
    let _e500 = currentType_1;
    switch bitcast<i32>(_e500) {
        case 1: {
            let _e502 = pos_22;
            param_999 = _e502;
            let _e503 = currentIndex_15;
            param_1000 = _e503;
            let _e504 = rawValue_13;
            param_1001 = _e504;
            let _e505 = currentSleep_7;
            param_1002 = _e505;
            let _e506 = currentAge_10;
            param_1003 = _e506;
            let _e507 = randVal_15;
            param_1004 = _e507;
            updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_999), (&param_1000), (&param_1001), (&param_1002), (&param_1003), (&param_1004));
            break;
        }
        case 2: {
            let _e508 = pos_22;
            param_1005 = _e508;
            let _e509 = currentIndex_15;
            param_1006 = _e509;
            let _e510 = rawValue_13;
            param_1007 = _e510;
            let _e511 = currentDir_6;
            param_1008 = _e511;
            let _e512 = currentSleep_7;
            param_1009 = _e512;
            let _e513 = currentAge_10;
            param_1010 = _e513;
            let _e514 = randVal_15;
            param_1011 = _e514;
            updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1005), (&param_1006), (&param_1007), (&param_1008), (&param_1009), (&param_1010), (&param_1011));
            break;
        }
        case 4: {
            let _e515 = pos_22;
            param_1012 = _e515;
            let _e516 = currentIndex_15;
            param_1013 = _e516;
            let _e517 = rawValue_13;
            param_1014 = _e517;
            let _e518 = currentDir_6;
            param_1015 = _e518;
            let _e519 = currentSleep_7;
            param_1016 = _e519;
            let _e520 = currentAge_10;
            param_1017 = _e520;
            let _e521 = randVal_15;
            param_1018 = _e521;
            updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1012), (&param_1013), (&param_1014), (&param_1015), (&param_1016), (&param_1017), (&param_1018));
            break;
        }
        case 5: {
            let _e522 = pos_22;
            param_1019 = _e522;
            let _e523 = currentIndex_15;
            param_1020 = _e523;
            let _e524 = rawValue_13;
            param_1021 = _e524;
            let _e525 = currentDir_6;
            param_1022 = _e525;
            let _e526 = currentSleep_7;
            param_1023 = _e526;
            let _e527 = currentAge_10;
            param_1024 = _e527;
            let _e528 = randVal_15;
            param_1025 = _e528;
            updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1019), (&param_1020), (&param_1021), (&param_1022), (&param_1023), (&param_1024), (&param_1025));
            break;
        }
        case 6: {
            let _e529 = pos_22;
            param_1026 = _e529;
            let _e530 = currentIndex_15;
            param_1027 = _e530;
            let _e531 = rawValue_13;
            param_1028 = _e531;
            let _e532 = currentSleep_7;
            param_1029 = _e532;
            let _e533 = currentAge_10;
            param_1030 = _e533;
            let _e534 = randVal_15;
            param_1031 = _e534;
            updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1026), (&param_1027), (&param_1028), (&param_1029), (&param_1030), (&param_1031));
            break;
        }
        case 9, 10, 11, 8: {
            let _e535 = pos_22;
            param_1032 = _e535;
            let _e536 = currentIndex_15;
            param_1033 = _e536;
            let _e537 = rawValue_13;
            param_1034 = _e537;
            let _e538 = currentDir_6;
            param_1035 = _e538;
            let _e539 = currentSleep_7;
            param_1036 = _e539;
            let _e540 = currentAge_10;
            param_1037 = _e540;
            let _e541 = randVal_15;
            param_1038 = _e541;
            updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1032), (&param_1033), (&param_1034), (&param_1035), (&param_1036), (&param_1037), (&param_1038));
            break;
        }
        case 12: {
            let _e542 = pos_22;
            param_1039 = _e542;
            let _e543 = currentIndex_15;
            param_1040 = _e543;
            let _e544 = rawValue_13;
            param_1041 = _e544;
            let _e545 = currentAge_10;
            param_1042 = _e545;
            let _e546 = randVal_15;
            param_1043 = _e546;
            updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1039), (&param_1040), (&param_1041), (&param_1042), (&param_1043));
            break;
        }
        case 14, 15, 16, 17, 13: {
            let _e547 = pos_22;
            param_1044 = _e547;
            let _e548 = currentIndex_15;
            param_1045 = _e548;
            let _e549 = rawValue_13;
            param_1046 = _e549;
            let _e550 = currentDir_6;
            param_1047 = _e550;
            let _e551 = currentSleep_7;
            param_1048 = _e551;
            let _e552 = currentAge_10;
            param_1049 = _e552;
            let _e553 = randVal_15;
            param_1050 = _e553;
            updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1044), (&param_1045), (&param_1046), (&param_1047), (&param_1048), (&param_1049), (&param_1050));
            break;
        }
        case 18: {
            let _e554 = pos_22;
            param_1051 = _e554;
            let _e555 = currentIndex_15;
            param_1052 = _e555;
            let _e556 = rawValue_13;
            param_1053 = _e556;
            let _e557 = currentDir_6;
            param_1054 = _e557;
            let _e558 = currentAge_10;
            param_1055 = _e558;
            let _e559 = randVal_15;
            param_1056 = _e559;
            updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1051), (&param_1052), (&param_1053), (&param_1054), (&param_1055), (&param_1056));
            break;
        }
        case 19: {
            let _e560 = pos_22;
            param_1057 = _e560;
            let _e561 = currentIndex_15;
            param_1058 = _e561;
            let _e562 = rawValue_13;
            param_1059 = _e562;
            let _e563 = currentAge_10;
            param_1060 = _e563;
            let _e564 = randVal_15;
            param_1061 = _e564;
            updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1057), (&param_1058), (&param_1059), (&param_1060), (&param_1061));
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
