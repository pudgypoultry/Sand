// GENERATED FILE -- DO NOT EDIT.
//
// Translated from falling_sand.comp by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit falling_sand.comp and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 941ed79b9227bf0bb97bf80396d8a9674436b7577d6aad4af3faf5c88245b40c

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

fn getHDir_u0028_i1_u003b(d: ptr<function, i32>) -> vec3<i32> {
    let _e215 = (*d);
    if (_e215 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e217 = (*d);
    if (_e217 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e219 = (*d);
    if (_e219 == 2i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    let _e221 = (*d);
    if (_e221 == 3i) {
        return vec3<i32>(0i, 0i, -1i);
    }
    let _e223 = (*d);
    if (_e223 == 4i) {
        return vec3<i32>(1i, 0i, 1i);
    }
    let _e225 = (*d);
    if (_e225 == 5i) {
        return vec3<i32>(1i, 0i, -1i);
    }
    let _e227 = (*d);
    if (_e227 == 6i) {
        return vec3<i32>(-1i, 0i, 1i);
    }
    return vec3<i32>(-1i, 0i, -1i);
}

fn getType_u0028_u1_u003b(val: ptr<function, u32>) -> u32 {
    let _e215 = (*val);
    return (_e215 & 255u);
}

fn readCell_u0028_u1_u003b(index: ptr<function, u32>) -> u32 {
    let _e215 = (*index);
    let _e218 = atomicLoad((&unnamed.grid[_e215]));
    return _e218;
}

fn tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex: ptr<function, u32>, currentValue: ptr<function, u32>, targetIndex: ptr<function, u32>, newValue: ptr<function, u32>) -> bool {
    var targetValue: u32;
    var param: u32;
    var targetType: u32;
    var param_1: u32;
    var currentType: u32;
    var param_2: u32;
    var actual: u32;
    var phi_1760_: bool;
    var phi_1769_: bool;

    let _e225 = (*targetIndex);
    param = _e225;
    let _e226 = readCell_u0028_u1_u003b((&param));
    targetValue = _e226;
    let _e227 = targetValue;
    param_1 = _e227;
    let _e228 = getType_u0028_u1_u003b((&param_1));
    targetType = _e228;
    let _e229 = (*currentValue);
    param_2 = _e229;
    let _e230 = getType_u0028_u1_u003b((&param_2));
    currentType = _e230;
    let _e231 = targetType;
    let _e232 = (_e231 == 0u);
    phi_1760_ = _e232;
    if !(_e232) {
        let _e234 = currentType;
        let _e236 = currentType;
        let _e239 = targetType;
        phi_1760_ = (((_e234 == 1u) || (_e236 == 4u)) && (_e239 == 2u));
    }
    let _e243 = phi_1760_;
    phi_1769_ = _e243;
    if !(_e243) {
        let _e245 = currentType;
        let _e247 = targetType;
        phi_1769_ = ((_e245 == 6u) && (_e247 == 5u));
    }
    let _e251 = phi_1769_;
    if _e251 {
        let _e252 = (*currentIndex);
        let _e255 = (*currentValue);
        let _e256 = atomicCompareExchangeWeak((&unnamed.grid[_e252]), _e255, 0u);
        let _e258 = (*currentValue);
        if (_e256.old_value == _e258) {
            let _e260 = (*targetIndex);
            let _e263 = targetValue;
            let _e264 = (*newValue);
            let _e265 = atomicCompareExchangeWeak((&unnamed.grid[_e260]), _e263, _e264);
            actual = _e265.old_value;
            let _e267 = actual;
            let _e268 = targetValue;
            if (_e267 == _e268) {
                let _e270 = targetType;
                if (_e270 != 0u) {
                    let _e272 = (*currentIndex);
                    let _e275 = targetValue;
                    let _e276 = atomicExchange((&unnamed.grid[_e272]), _e275);
                }
                return true;
            } else {
                let _e277 = (*currentIndex);
                let _e280 = (*currentValue);
                let _e281 = atomicCompareExchangeWeak((&unnamed.grid[_e277]), 0u, _e280);
            }
        }
    }
    return false;
}

fn pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(type_33: ptr<function, u32>, dir: ptr<function, u32>, sleep: ptr<function, u32>, age: ptr<function, u32>) -> u32 {
    let _e218 = (*type_33);
    let _e220 = (*dir);
    let _e225 = (*sleep);
    let _e230 = (*age);
    return ((((_e218 & 255u) | ((_e220 & 255u) << bitcast<u32>(8i))) | ((_e225 & 255u) << bitcast<u32>(16i))) | ((_e230 & 255u) << bitcast<u32>(24i)));
}

fn getAge_u0028_u1_u003b(val_1: ptr<function, u32>) -> u32 {
    let _e215 = (*val_1);
    return ((_e215 >> bitcast<u32>(24i)) & 255u);
}

fn getSleep_u0028_u1_u003b(val_2: ptr<function, u32>) -> u32 {
    let _e215 = (*val_2);
    return ((_e215 >> bitcast<u32>(16i)) & 255u);
}

fn getDir_u0028_u1_u003b(val_3: ptr<function, u32>) -> u32 {
    let _e215 = (*val_3);
    return ((_e215 >> bitcast<u32>(8i)) & 255u);
}

fn getIndex_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    let _e216 = (*pos)[0u];
    let _e218 = (*pos)[1u];
    let _e220 = tuning.gridWidth;
    let _e225 = (*pos)[2u];
    let _e227 = tuning.gridWidth;
    let _e231 = tuning.gridHeight;
    return bitcast<u32>(((_e216 + (_e218 * bitcast<i32>(_e220))) + ((_e225 * bitcast<i32>(_e227)) * bitcast<i32>(_e231))));
}

fn updateAsh_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_1: ptr<function, vec3<i32>>, currentIndex_1: ptr<function, u32>, rawValue: ptr<function, u32>, currentSleep: ptr<function, u32>, currentAge: ptr<function, u32>, randVal: ptr<function, f32>) {
    var param_3: vec3<i32>;
    var param_4: u32;
    var param_5: u32;
    var param_6: vec3<i32>;
    var param_7: u32;
    var param_8: u32;
    var soaked: u32;
    var belowIndex: u32;
    var param_9: vec3<i32>;
    var belowValue: u32;
    var param_10: u32;
    var param_11: u32;
    var flora: u32;
    var param_12: u32;
    var fed: u32;
    var param_13: u32;
    var param_14: u32;
    var param_15: u32;
    var param_16: u32;
    var param_17: u32;
    var param_18: u32;
    var belowPos: vec3<i32>;
    var param_19: vec3<i32>;
    var param_20: u32;
    var param_21: u32;
    var param_22: vec3<i32>;
    var param_23: u32;
    var param_24: u32;
    var param_25: u32;
    var param_26: u32;
    var param_27: u32;
    var param_28: u32;
    var param_29: u32;
    var param_30: u32;
    var dir_1: i32;
    var slide: array<vec3<i32>, 2>;
    var s: i32;
    var param_31: vec3<i32>;
    var param_32: u32;
    var param_33: u32;
    var param_34: vec3<i32>;
    var param_35: u32;
    var param_36: u32;
    var param_37: u32;
    var param_38: u32;
    var param_39: u32;
    var param_40: u32;
    var param_41: u32;
    var param_42: u32;
    var start: i32;
    var i: i32;
    var target_: vec3<i32>;
    var param_43: i32;
    var param_44: vec3<i32>;
    var param_45: u32;
    var param_46: u32;
    var param_47: vec3<i32>;
    var param_48: u32;
    var param_49: u32;
    var carried: u32;
    var param_50: vec3<i32>;
    var param_51: u32;
    var param_52: u32;
    var param_53: u32;
    var param_54: u32;
    var param_55: u32;
    var param_56: u32;
    var param_57: u32;
    var param_58: u32;
    var param_59: u32;
    var param_60: u32;
    var param_61: u32;
    var param_62: u32;
    var phi_7862_: bool;
    var phi_7888_: bool;
    var phi_8064_: bool;
    var phi_8071_: bool;
    var phi_8082_: bool;
    var phi_8134_: bool;
    var phi_8173_: bool;
    var phi_8180_: bool;
    var phi_8191_: bool;

    let _e294 = (*pos_1)[1u];
    let _e295 = (_e294 > 1i);
    phi_7862_ = _e295;
    if _e295 {
        let _e296 = (*pos_1);
        param_3 = (_e296 + vec3<i32>(0i, -1i, 0i));
        let _e298 = getIndex_u0028_vi3_u003b((&param_3));
        param_4 = _e298;
        let _e299 = readCell_u0028_u1_u003b((&param_4));
        param_5 = _e299;
        let _e300 = getType_u0028_u1_u003b((&param_5));
        phi_7862_ = (_e300 == 2u);
    }
    let _e303 = phi_7862_;
    if _e303 {
        let _e304 = (*currentIndex_1);
        let _e307 = (*rawValue);
        let _e308 = atomicCompareExchangeWeak((&unnamed.grid[_e304]), _e307, 0u);
        return;
    }
    let _e311 = (*pos_1)[1u];
    let _e313 = tuning.gridHeight;
    let _e316 = (_e311 < (bitcast<i32>(_e313) - 1i));
    phi_7888_ = _e316;
    if _e316 {
        let _e317 = (*pos_1);
        param_6 = (_e317 + vec3<i32>(0i, 1i, 0i));
        let _e319 = getIndex_u0028_vi3_u003b((&param_6));
        param_7 = _e319;
        let _e320 = readCell_u0028_u1_u003b((&param_7));
        param_8 = _e320;
        let _e321 = getType_u0028_u1_u003b((&param_8));
        phi_7888_ = (_e321 == 2u);
    }
    let _e324 = phi_7888_;
    if _e324 {
        let _e325 = (*currentIndex_1);
        let _e328 = (*rawValue);
        let _e329 = atomicCompareExchangeWeak((&unnamed.grid[_e325]), _e328, 0u);
        return;
    }
    soaked = 0u;
    let _e332 = (*pos_1)[1u];
    if (_e332 > 1i) {
        let _e334 = (*pos_1);
        param_9 = (_e334 + vec3<i32>(0i, -1i, 0i));
        let _e336 = getIndex_u0028_vi3_u003b((&param_9));
        belowIndex = _e336;
        let _e337 = belowIndex;
        param_10 = _e337;
        let _e338 = readCell_u0028_u1_u003b((&param_10));
        belowValue = _e338;
        let _e339 = belowValue;
        param_11 = _e339;
        let _e340 = getType_u0028_u1_u003b((&param_11));
        if (_e340 == 4u) {
            let _e342 = (*currentAge);
            soaked = min((_e342 + 1u), 255u);
        }
        let _e345 = soaked;
        let _e347 = tuning.ashAbsorbTicks;
        if (_e345 >= max(_e347, 1u)) {
            let _e350 = belowValue;
            param_12 = _e350;
            let _e351 = getDir_u0028_u1_u003b((&param_12));
            flora = _e351;
            let _e352 = flora;
            if (_e352 < 99u) {
                let _e354 = flora;
                let _e356 = tuning.ashEnrichAmount;
                fed = min((_e354 + max(_e356, 1u)), 99u);
                let _e360 = belowIndex;
                let _e363 = belowValue;
                let _e364 = belowValue;
                param_13 = _e364;
                let _e365 = getSleep_u0028_u1_u003b((&param_13));
                let _e366 = belowValue;
                param_14 = _e366;
                let _e367 = getAge_u0028_u1_u003b((&param_14));
                param_15 = 4u;
                let _e368 = fed;
                param_16 = _e368;
                param_17 = _e365;
                param_18 = _e367;
                let _e369 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_15), (&param_16), (&param_17), (&param_18));
                let _e370 = atomicCompareExchangeWeak((&unnamed.grid[_e360]), _e363, _e369);
                let _e372 = belowValue;
                if (_e370.old_value == _e372) {
                    let _e374 = (*currentIndex_1);
                    let _e377 = (*rawValue);
                    let _e378 = atomicCompareExchangeWeak((&unnamed.grid[_e374]), _e377, 0u);
                    return;
                }
            }
        }
    }
    let _e381 = (*pos_1)[1u];
    if (_e381 > 1i) {
        let _e383 = (*pos_1);
        belowPos = (_e383 + vec3<i32>(0i, -1i, 0i));
        let _e385 = belowPos;
        param_19 = _e385;
        let _e386 = getIndex_u0028_vi3_u003b((&param_19));
        param_20 = _e386;
        let _e387 = readCell_u0028_u1_u003b((&param_20));
        param_21 = _e387;
        let _e388 = getType_u0028_u1_u003b((&param_21));
        if (_e388 == 0u) {
            let _e390 = belowPos;
            param_22 = _e390;
            let _e391 = getIndex_u0028_vi3_u003b((&param_22));
            param_23 = 20u;
            param_24 = 0u;
            param_25 = 0u;
            param_26 = 0u;
            let _e392 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_23), (&param_24), (&param_25), (&param_26));
            let _e393 = (*currentIndex_1);
            param_27 = _e393;
            let _e394 = (*rawValue);
            param_28 = _e394;
            param_29 = _e391;
            param_30 = _e392;
            let _e395 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_27), (&param_28), (&param_29), (&param_30));
            if _e395 {
                return;
            }
        }
        let _e396 = (*randVal);
        dir_1 = select(-1i, 1i, (fract((_e396 * 67f)) > 0.5f));
        let _e401 = (*randVal);
        if (fract((_e401 * 73f)) > 0.5f) {
            let _e405 = (*pos_1);
            let _e406 = dir_1;
            slide[0i] = (_e405 + vec3<i32>(_e406, -1i, 0i));
            let _e410 = (*pos_1);
            let _e411 = dir_1;
            slide[1i] = (_e410 + vec3<i32>(0i, -1i, _e411));
        } else {
            let _e415 = (*pos_1);
            let _e416 = dir_1;
            slide[0i] = (_e415 + vec3<i32>(0i, -1i, _e416));
            let _e420 = (*pos_1);
            let _e421 = dir_1;
            slide[1i] = (_e420 + vec3<i32>(_e421, -1i, 0i));
        }
        s = 0i;
        loop {
            let _e425 = s;
            if (_e425 < 2i) {
                let _e427 = s;
                let _e430 = slide[_e427][0u];
                let _e431 = (_e430 > 0i);
                phi_8064_ = _e431;
                if _e431 {
                    let _e432 = s;
                    let _e435 = slide[_e432][0u];
                    let _e437 = tuning.gridWidth;
                    phi_8064_ = (_e435 < (bitcast<i32>(_e437) - 1i));
                }
                let _e442 = phi_8064_;
                phi_8071_ = _e442;
                if _e442 {
                    let _e443 = s;
                    let _e446 = slide[_e443][2u];
                    phi_8071_ = (_e446 > 0i);
                }
                let _e449 = phi_8071_;
                phi_8082_ = _e449;
                if _e449 {
                    let _e450 = s;
                    let _e453 = slide[_e450][2u];
                    let _e455 = tuning.gridDepth;
                    phi_8082_ = (_e453 < (bitcast<i32>(_e455) - 1i));
                }
                let _e460 = phi_8082_;
                if _e460 {
                    let _e461 = s;
                    let _e463 = slide[_e461];
                    param_31 = _e463;
                    let _e464 = getIndex_u0028_vi3_u003b((&param_31));
                    param_32 = _e464;
                    let _e465 = readCell_u0028_u1_u003b((&param_32));
                    param_33 = _e465;
                    let _e466 = getType_u0028_u1_u003b((&param_33));
                    if (_e466 == 0u) {
                        let _e468 = s;
                        let _e470 = slide[_e468];
                        param_34 = _e470;
                        let _e471 = getIndex_u0028_vi3_u003b((&param_34));
                        param_35 = 20u;
                        param_36 = 0u;
                        param_37 = 0u;
                        param_38 = 0u;
                        let _e472 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_35), (&param_36), (&param_37), (&param_38));
                        let _e473 = (*currentIndex_1);
                        param_39 = _e473;
                        let _e474 = (*rawValue);
                        param_40 = _e474;
                        param_41 = _e471;
                        param_42 = _e472;
                        let _e475 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_39), (&param_40), (&param_41), (&param_42));
                        if _e475 {
                            return;
                        }
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e476 = s;
                s = (_e476 + 1i);
            }
        }
    }
    let _e478 = (*currentSleep);
    let _e480 = tuning.ashSettleTicks;
    let _e481 = (_e478 < _e480);
    phi_8134_ = _e481;
    if _e481 {
        let _e482 = (*randVal);
        let _e486 = tuning.ashDriftChance;
        phi_8134_ = (fract((_e482 * 79f)) < _e486);
    }
    let _e489 = phi_8134_;
    if _e489 {
        let _e490 = (*randVal);
        start = i32((fract((_e490 * 89f)) * 8f));
        i = 0i;
        loop {
            let _e495 = i;
            if (_e495 < 8i) {
                let _e497 = (*pos_1);
                let _e498 = start;
                let _e499 = i;
                let _e500 = (_e498 + _e499);
                param_43 = (_e500 - (i32(floor((f32(_e500) / f32(8i)))) * 8i));
                let _e508 = getHDir_u0028_i1_u003b((&param_43));
                target_ = (_e497 + _e508);
                let _e511 = target_[0u];
                let _e512 = (_e511 <= 0i);
                phi_8173_ = _e512;
                if !(_e512) {
                    let _e515 = target_[0u];
                    let _e517 = tuning.gridWidth;
                    phi_8173_ = (_e515 >= (bitcast<i32>(_e517) - 1i));
                }
                let _e522 = phi_8173_;
                phi_8180_ = _e522;
                if !(_e522) {
                    let _e525 = target_[2u];
                    phi_8180_ = (_e525 <= 0i);
                }
                let _e528 = phi_8180_;
                phi_8191_ = _e528;
                if !(_e528) {
                    let _e531 = target_[2u];
                    let _e533 = tuning.gridDepth;
                    phi_8191_ = (_e531 >= (bitcast<i32>(_e533) - 1i));
                }
                let _e538 = phi_8191_;
                if _e538 {
                    continue;
                }
                let _e539 = target_;
                param_44 = _e539;
                let _e540 = getIndex_u0028_vi3_u003b((&param_44));
                param_45 = _e540;
                let _e541 = readCell_u0028_u1_u003b((&param_45));
                param_46 = _e541;
                let _e542 = getType_u0028_u1_u003b((&param_46));
                if (_e542 != 0u) {
                    continue;
                }
                let _e545 = target_[1u];
                if (_e545 <= 1i) {
                    continue;
                }
                let _e547 = target_;
                param_47 = (_e547 + vec3<i32>(0i, -1i, 0i));
                let _e549 = getIndex_u0028_vi3_u003b((&param_47));
                param_48 = _e549;
                let _e550 = readCell_u0028_u1_u003b((&param_48));
                param_49 = _e550;
                let _e551 = getType_u0028_u1_u003b((&param_49));
                if (_e551 == 0u) {
                    continue;
                }
                let _e553 = (*currentSleep);
                carried = min((_e553 + 1u), 255u);
                let _e556 = target_;
                param_50 = _e556;
                let _e557 = getIndex_u0028_vi3_u003b((&param_50));
                param_51 = 20u;
                param_52 = 0u;
                let _e558 = carried;
                param_53 = _e558;
                let _e559 = soaked;
                param_54 = _e559;
                let _e560 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_51), (&param_52), (&param_53), (&param_54));
                let _e561 = (*currentIndex_1);
                param_55 = _e561;
                let _e562 = (*rawValue);
                param_56 = _e562;
                param_57 = _e557;
                param_58 = _e560;
                let _e563 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_55), (&param_56), (&param_57), (&param_58));
                if _e563 {
                    return;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e564 = i;
                i = (_e564 + 1i);
            }
        }
    }
    let _e566 = (*currentIndex_1);
    let _e569 = (*rawValue);
    let _e570 = (*currentSleep);
    param_59 = 20u;
    param_60 = 0u;
    param_61 = min((_e570 + 1u), 255u);
    let _e573 = soaked;
    param_62 = _e573;
    let _e574 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_59), (&param_60), (&param_61), (&param_62));
    let _e575 = atomicCompareExchangeWeak((&unnamed.grid[_e566]), _e569, _e574);
    return;
}

fn hash_u0028_vf3_u003b(p: ptr<function, vec3<f32>>) -> f32 {
    let _e215 = (*p);
    return fract((sin(dot(_e215, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn treeTargetHeight_u0028_vi3_u003b(pos_2: ptr<function, vec3<i32>>) -> u32 {
    var lo: u32;
    var hi: u32;
    var a: f32;
    var param_63: vec3<f32>;
    var b: f32;
    var param_64: vec3<f32>;
    var t: f32;

    let _e223 = tuning.treeMinHeight;
    lo = max(_e223, 1u);
    let _e226 = tuning.treeMaxHeight;
    let _e227 = lo;
    hi = max(_e226, _e227);
    let _e229 = hi;
    let _e230 = lo;
    if (_e229 == _e230) {
        let _e232 = lo;
        return _e232;
    }
    let _e234 = (*pos_2)[0u];
    let _e237 = (*pos_2)[2u];
    param_63 = vec3<f32>(f32(_e234), 0f, f32(_e237));
    let _e240 = hash_u0028_vf3_u003b((&param_63));
    a = _e240;
    let _e242 = (*pos_2)[2u];
    let _e247 = (*pos_2)[0u];
    param_64 = vec3<f32>(((f32(_e242) * 3f) + 11f), 7f, ((f32(_e247) * 5f) + 3f));
    let _e252 = hash_u0028_vf3_u003b((&param_64));
    b = _e252;
    let _e253 = a;
    let _e254 = b;
    t = clamp(((_e253 + _e254) * 0.5f), 0f, 0.999f);
    let _e258 = lo;
    let _e259 = t;
    let _e260 = hi;
    let _e261 = lo;
    return (_e258 + u32((_e259 * f32(((_e260 - _e261) + 1u)))));
}

fn tree26_u0028_i1_u003b(i_1: ptr<function, i32>) -> vec3<i32> {
    var j: i32;
    var local: i32;

    let _e217 = (*i_1);
    if (_e217 >= 13i) {
        let _e219 = (*i_1);
        local = (_e219 + 1i);
    } else {
        let _e221 = (*i_1);
        local = _e221;
    }
    let _e222 = local;
    j = _e222;
    let _e223 = j;
    let _e231 = j;
    let _e232 = (_e231 / 3i);
    let _e240 = j;
    return (vec3<i32>((_e223 - (i32(floor((f32(_e223) / f32(3i)))) * 3i)), (_e232 - (i32(floor((f32(_e232) / f32(3i)))) * 3i)), (_e240 / 9i)) - vec3<i32>(1i, 1i, 1i));
}

fn treeInBounds_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> bool {
    var phi_1188_: bool;
    var phi_1194_: bool;
    var phi_1204_: bool;
    var phi_1210_: bool;
    var phi_1220_: bool;

    let _e216 = (*p_1)[0u];
    let _e217 = (_e216 > 0i);
    phi_1188_ = _e217;
    if _e217 {
        let _e219 = (*p_1)[0u];
        let _e221 = tuning.gridWidth;
        phi_1188_ = (_e219 < (bitcast<i32>(_e221) - 1i));
    }
    let _e226 = phi_1188_;
    phi_1194_ = _e226;
    if _e226 {
        let _e228 = (*p_1)[1u];
        phi_1194_ = (_e228 > 0i);
    }
    let _e231 = phi_1194_;
    phi_1204_ = _e231;
    if _e231 {
        let _e233 = (*p_1)[1u];
        let _e235 = tuning.gridHeight;
        phi_1204_ = (_e233 < (bitcast<i32>(_e235) - 1i));
    }
    let _e240 = phi_1204_;
    phi_1210_ = _e240;
    if _e240 {
        let _e242 = (*p_1)[2u];
        phi_1210_ = (_e242 > 0i);
    }
    let _e245 = phi_1210_;
    phi_1220_ = _e245;
    if _e245 {
        let _e247 = (*p_1)[2u];
        let _e249 = tuning.gridDepth;
        phi_1220_ = (_e247 < (bitcast<i32>(_e249) - 1i));
    }
    let _e254 = phi_1220_;
    return _e254;
}

fn updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_3: ptr<function, vec3<i32>>, currentIndex_2: ptr<function, u32>, rawValue_1: ptr<function, u32>, currentAge_1: ptr<function, u32>, randVal_1: ptr<function, f32>) {
    var belowPos_1: vec3<i32>;
    var param_65: vec3<i32>;
    var param_66: vec3<i32>;
    var param_67: u32;
    var param_68: vec3<i32>;
    var param_69: u32;
    var param_70: u32;
    var param_71: u32;
    var param_72: u32;
    var param_73: u32;
    var param_74: u32;
    var param_75: u32;
    var param_76: u32;
    var dist: u32;
    var nearest: u32;
    var touchesTrunk: bool;
    var start_1: i32;
    var haveSpot: bool;
    var spot: vec3<i32>;
    var i_2: i32;
    var c: vec3<i32>;
    var param_77: i32;
    var param_78: vec3<i32>;
    var v: u32;
    var param_79: vec3<i32>;
    var param_80: u32;
    var t_1: u32;
    var param_81: u32;
    var param_82: u32;
    var param_83: vec3<i32>;
    var param_84: u32;
    var supported: u32;
    var local_1: u32;
    var local_2: u32;
    var param_85: u32;
    var param_86: u32;
    var param_87: u32;
    var param_88: u32;
    var param_89: vec3<i32>;
    var param_90: u32;
    var param_91: u32;
    var param_92: u32;
    var param_93: u32;
    var param_94: u32;
    var param_95: u32;
    var param_96: u32;
    var param_97: u32;
    var phi_6896_: bool;
    var phi_6981_: bool;
    var phi_7063_: bool;

    let _e266 = (*randVal_1);
    let _e270 = tuning.treeLeafTickChance;
    if (fract((_e266 * 7f)) >= _e270) {
        return;
    }
    let _e272 = (*currentAge_1);
    if (_e272 == 255u) {
        let _e274 = (*pos_3);
        belowPos_1 = (_e274 + vec3<i32>(0i, -1i, 0i));
        let _e276 = belowPos_1;
        param_65 = _e276;
        let _e277 = treeInBounds_u0028_vi3_u003b((&param_65));
        phi_6896_ = _e277;
        if _e277 {
            let _e278 = belowPos_1;
            param_66 = _e278;
            let _e279 = getIndex_u0028_vi3_u003b((&param_66));
            param_67 = _e279;
            let _e280 = readCell_u0028_u1_u003b((&param_67));
            phi_6896_ = (_e280 == 0u);
        }
        let _e283 = phi_6896_;
        if _e283 {
            let _e284 = belowPos_1;
            param_68 = _e284;
            let _e285 = getIndex_u0028_vi3_u003b((&param_68));
            param_69 = 19u;
            param_70 = 0u;
            param_71 = 0u;
            param_72 = 255u;
            let _e286 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_69), (&param_70), (&param_71), (&param_72));
            let _e287 = (*currentIndex_2);
            param_73 = _e287;
            let _e288 = (*rawValue_1);
            param_74 = _e288;
            param_75 = _e285;
            param_76 = _e286;
            let _e289 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_73), (&param_74), (&param_75), (&param_76));
            if _e289 {
                return;
            }
        }
        let _e290 = (*currentIndex_2);
        let _e293 = (*rawValue_1);
        let _e294 = atomicCompareExchangeWeak((&unnamed.grid[_e290]), _e293, 0u);
        return;
    }
    let _e296 = (*currentAge_1);
    dist = _e296;
    nearest = 255u;
    touchesTrunk = false;
    let _e297 = (*randVal_1);
    start_1 = i32((fract((_e297 * 71f)) * 26f));
    haveSpot = false;
    let _e302 = (*pos_3);
    spot = _e302;
    i_2 = 0i;
    loop {
        let _e303 = i_2;
        if (_e303 < 26i) {
            let _e305 = (*pos_3);
            let _e306 = start_1;
            let _e307 = i_2;
            let _e308 = (_e306 + _e307);
            param_77 = (_e308 - (i32(floor((f32(_e308) / f32(26i)))) * 26i));
            let _e316 = tree26_u0028_i1_u003b((&param_77));
            c = (_e305 + _e316);
            let _e318 = c;
            param_78 = _e318;
            let _e319 = treeInBounds_u0028_vi3_u003b((&param_78));
            if !(_e319) {
                continue;
            }
            let _e321 = c;
            param_79 = _e321;
            let _e322 = getIndex_u0028_vi3_u003b((&param_79));
            param_80 = _e322;
            let _e323 = readCell_u0028_u1_u003b((&param_80));
            v = _e323;
            let _e324 = v;
            param_81 = _e324;
            let _e325 = getType_u0028_u1_u003b((&param_81));
            t_1 = _e325;
            let _e326 = t_1;
            let _e327 = (_e326 == 18u);
            phi_6981_ = _e327;
            if _e327 {
                let _e328 = v;
                param_82 = _e328;
                let _e329 = getDir_u0028_u1_u003b((&param_82));
                let _e331 = c;
                param_83 = _e331;
                let _e332 = treeTargetHeight_u0028_vi3_u003b((&param_83));
                phi_6981_ = ((_e329 + 1u) >= _e332);
            }
            let _e335 = phi_6981_;
            if _e335 {
                touchesTrunk = true;
            } else {
                let _e336 = t_1;
                if (_e336 == 19u) {
                    let _e338 = nearest;
                    let _e339 = v;
                    param_84 = _e339;
                    let _e340 = getAge_u0028_u1_u003b((&param_84));
                    nearest = min(_e338, _e340);
                } else {
                    let _e342 = v;
                    let _e344 = haveSpot;
                    if ((_e342 == 0u) && !(_e344)) {
                        haveSpot = true;
                        let _e347 = c;
                        spot = _e347;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e348 = i_2;
            i_2 = (_e348 + 1i);
        }
    }
    let _e350 = touchesTrunk;
    if _e350 {
        local_1 = 1u;
    } else {
        let _e351 = nearest;
        if (_e351 >= 255u) {
            local_2 = 255u;
        } else {
            let _e353 = nearest;
            local_2 = (_e353 + 1u);
        }
        let _e355 = local_2;
        local_1 = _e355;
    }
    let _e356 = local_1;
    supported = _e356;
    let _e357 = supported;
    let _e359 = tuning.treeLeafReach;
    if (_e357 > _e359) {
        let _e361 = (*randVal_1);
        let _e365 = tuning.treeLeafFallChance;
        if (fract((_e361 * 83f)) < _e365) {
            let _e367 = (*currentIndex_2);
            let _e370 = (*rawValue_1);
            param_85 = 19u;
            param_86 = 0u;
            param_87 = 0u;
            param_88 = 255u;
            let _e371 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_85), (&param_86), (&param_87), (&param_88));
            let _e372 = atomicCompareExchangeWeak((&unnamed.grid[_e367]), _e370, _e371);
        }
        return;
    }
    let _e374 = supported;
    let _e376 = tuning.treeLeafReach;
    let _e378 = haveSpot;
    let _e379 = ((_e374 < _e376) && _e378);
    phi_7063_ = _e379;
    if _e379 {
        let _e380 = (*randVal_1);
        let _e384 = tuning.treeLeafSpreadChance;
        phi_7063_ = (fract((_e380 * 89f)) < _e384);
    }
    let _e387 = phi_7063_;
    if _e387 {
        let _e388 = spot;
        param_89 = _e388;
        let _e389 = getIndex_u0028_vi3_u003b((&param_89));
        let _e392 = supported;
        param_90 = 19u;
        param_91 = 0u;
        param_92 = 0u;
        param_93 = (_e392 + 1u);
        let _e394 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_90), (&param_91), (&param_92), (&param_93));
        let _e395 = atomicCompareExchangeWeak((&unnamed.grid[_e389]), 0u, _e394);
    }
    let _e397 = supported;
    let _e398 = dist;
    if (_e397 != _e398) {
        let _e400 = (*currentIndex_2);
        let _e403 = (*rawValue_1);
        param_94 = 19u;
        param_95 = 0u;
        param_96 = 0u;
        let _e404 = supported;
        param_97 = _e404;
        let _e405 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_94), (&param_95), (&param_96), (&param_97));
        let _e406 = atomicCompareExchangeWeak((&unnamed.grid[_e400]), _e403, _e405);
    }
    return;
}

fn isGrassBlock_u0028_u1_u003b(value: ptr<function, u32>) -> bool {
    var flora_1: u32;
    var param_98: u32;

    let _e217 = (*value);
    flora_1 = ((_e217 >> bitcast<u32>(8i)) & 255u);
    let _e221 = (*value);
    param_98 = _e221;
    let _e222 = getType_u0028_u1_u003b((&param_98));
    let _e224 = flora_1;
    let _e227 = flora_1;
    return (((_e222 == 4u) && (_e224 > 10u)) && (_e227 <= 100u));
}

fn updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_4: ptr<function, vec3<i32>>, currentIndex_3: ptr<function, u32>, rawValue_2: ptr<function, u32>, currentDir: ptr<function, u32>, currentAge_2: ptr<function, u32>, randVal_2: ptr<function, f32>) {
    var height: u32;
    var water: u32;
    var changed: bool;
    var start_2: i32;
    var k: i32;
    var i_3: i32;
    var c_1: vec3<i32>;
    var local_3: vec3<i32>;
    var local_4: vec3<i32>;
    var param_99: i32;
    var param_100: i32;
    var param_101: vec3<i32>;
    var idx: u32;
    var param_102: vec3<i32>;
    var v_1: u32;
    var param_103: u32;
    var param_104: u32;
    var cap: vec3<i32>;
    var param_105: vec3<i32>;
    var param_106: vec3<i32>;
    var param_107: u32;
    var param_108: u32;
    var moisture: u32;
    var param_109: u32;
    var param_110: u32;
    var param_111: u32;
    var param_112: u32;
    var param_113: u32;
    var param_114: u32;
    var param_115: u32;
    var upPos: vec3<i32>;
    var upIsTrunk: bool;
    var upValue: u32;
    var upIndex: u32;
    var param_116: vec3<i32>;
    var param_117: vec3<i32>;
    var param_118: u32;
    var param_119: u32;
    var param_120: u32;
    var lifted: u32;
    var param_121: u32;
    var param_122: u32;
    var param_123: u32;
    var param_124: u32;
    var param_125: u32;
    var param_126: u32;
    var param_127: vec3<i32>;
    var param_128: vec3<i32>;
    var upType: u32;
    var param_129: u32;
    var sapling: u32;
    var param_130: u32;
    var param_131: u32;
    var param_132: u32;
    var param_133: u32;
    var start_3: i32;
    var i_4: i32;
    var c_2: vec3<i32>;
    var param_134: i32;
    var param_135: vec3<i32>;
    var idx_1: u32;
    var param_136: vec3<i32>;
    var param_137: u32;
    var param_138: u32;
    var param_139: u32;
    var param_140: u32;
    var param_141: u32;
    var start_4: i32;
    var i_5: i32;
    var c_3: vec3<i32>;
    var param_142: i32;
    var param_143: vec3<i32>;
    var idx_2: u32;
    var param_144: vec3<i32>;
    var param_145: u32;
    var param_146: vec3<i32>;
    var param_147: u32;
    var param_148: u32;
    var param_149: u32;
    var param_150: u32;
    var param_151: u32;
    var param_152: u32;
    var param_153: u32;
    var param_154: u32;
    var param_155: u32;
    var param_156: u32;
    var phi_6431_: bool;
    var phi_6522_: bool;
    var phi_6595_: bool;
    var phi_6605_: bool;
    var phi_6650_: bool;
    var phi_6701_: bool;
    var phi_6780_: bool;

    let _e306 = (*currentDir);
    height = _e306;
    let _e307 = (*currentAge_2);
    water = _e307;
    changed = false;
    let _e308 = water;
    let _e310 = tuning.treeWaterMax;
    let _e311 = (_e308 < _e310);
    phi_6431_ = _e311;
    if _e311 {
        let _e312 = (*randVal_2);
        let _e316 = tuning.treeDrinkChance;
        phi_6431_ = (fract((_e312 * 13f)) < _e316);
    }
    let _e319 = phi_6431_;
    if _e319 {
        let _e320 = (*randVal_2);
        start_2 = i32((fract((_e320 * 101f)) * 17f));
        k = 0i;
        loop {
            let _e325 = k;
            if (_e325 < 17i) {
                let _e327 = start_2;
                let _e328 = k;
                let _e329 = (_e327 + _e328);
                i_3 = (_e329 - (i32(floor((f32(_e329) / f32(17i)))) * 17i));
                let _e337 = i_3;
                if (_e337 == 0i) {
                    let _e339 = (*pos_4);
                    local_3 = (_e339 + vec3<i32>(0i, -1i, 0i));
                } else {
                    let _e341 = i_3;
                    if (_e341 < 9i) {
                        let _e343 = (*pos_4);
                        let _e344 = i_3;
                        param_99 = (_e344 - 1i);
                        let _e346 = getHDir_u0028_i1_u003b((&param_99));
                        local_4 = ((_e343 + _e346) + vec3<i32>(0i, -1i, 0i));
                    } else {
                        let _e349 = (*pos_4);
                        let _e350 = i_3;
                        param_100 = (_e350 - 9i);
                        let _e352 = getHDir_u0028_i1_u003b((&param_100));
                        local_4 = (_e349 + _e352);
                    }
                    let _e354 = local_4;
                    local_3 = _e354;
                }
                let _e355 = local_3;
                c_1 = _e355;
                let _e356 = c_1;
                param_101 = _e356;
                let _e357 = treeInBounds_u0028_vi3_u003b((&param_101));
                if !(_e357) {
                    continue;
                }
                let _e359 = c_1;
                param_102 = _e359;
                let _e360 = getIndex_u0028_vi3_u003b((&param_102));
                idx = _e360;
                let _e361 = idx;
                param_103 = _e361;
                let _e362 = readCell_u0028_u1_u003b((&param_103));
                v_1 = _e362;
                let _e363 = v_1;
                param_104 = _e363;
                let _e364 = getType_u0028_u1_u003b((&param_104));
                if (_e364 != 4u) {
                    continue;
                }
                let _e366 = c_1;
                cap = (_e366 + vec3<i32>(0i, 1i, 0i));
                let _e368 = cap;
                param_105 = _e368;
                let _e369 = treeInBounds_u0028_vi3_u003b((&param_105));
                phi_6522_ = _e369;
                if _e369 {
                    let _e370 = cap;
                    param_106 = _e370;
                    let _e371 = getIndex_u0028_vi3_u003b((&param_106));
                    param_107 = _e371;
                    let _e372 = readCell_u0028_u1_u003b((&param_107));
                    param_108 = _e372;
                    let _e373 = getType_u0028_u1_u003b((&param_108));
                    phi_6522_ = (_e373 == 20u);
                }
                let _e376 = phi_6522_;
                if _e376 {
                    continue;
                }
                let _e377 = v_1;
                param_109 = _e377;
                let _e378 = getAge_u0028_u1_u003b((&param_109));
                moisture = _e378;
                let _e379 = moisture;
                let _e381 = tuning.treeSoilReserve;
                if (_e379 <= _e381) {
                    continue;
                }
                let _e383 = idx;
                let _e386 = v_1;
                let _e387 = v_1;
                param_110 = _e387;
                let _e388 = getDir_u0028_u1_u003b((&param_110));
                let _e389 = v_1;
                param_111 = _e389;
                let _e390 = getSleep_u0028_u1_u003b((&param_111));
                let _e391 = moisture;
                param_112 = 4u;
                param_113 = _e388;
                param_114 = _e390;
                param_115 = (_e391 - 1u);
                let _e393 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_112), (&param_113), (&param_114), (&param_115));
                let _e394 = atomicCompareExchangeWeak((&unnamed.grid[_e383]), _e386, _e393);
                let _e396 = v_1;
                if (_e394.old_value == _e396) {
                    let _e398 = water;
                    water = (_e398 + 1u);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e400 = k;
                k = (_e400 + 1i);
            }
        }
    }
    let _e402 = (*pos_4);
    upPos = (_e402 + vec3<i32>(0i, 1i, 0i));
    upIsTrunk = false;
    upValue = 0u;
    upIndex = 0u;
    let _e404 = upPos;
    param_116 = _e404;
    let _e405 = treeInBounds_u0028_vi3_u003b((&param_116));
    if _e405 {
        let _e406 = upPos;
        param_117 = _e406;
        let _e407 = getIndex_u0028_vi3_u003b((&param_117));
        upIndex = _e407;
        let _e408 = upIndex;
        param_118 = _e408;
        let _e409 = readCell_u0028_u1_u003b((&param_118));
        upValue = _e409;
        let _e410 = upValue;
        param_119 = _e410;
        let _e411 = getType_u0028_u1_u003b((&param_119));
        upIsTrunk = (_e411 == 18u);
    }
    let _e413 = upIsTrunk;
    let _e414 = water;
    let _e416 = (_e413 && (_e414 > 0u));
    phi_6595_ = _e416;
    if _e416 {
        let _e417 = upValue;
        param_120 = _e417;
        let _e418 = getAge_u0028_u1_u003b((&param_120));
        phi_6595_ = (_e418 < 255u);
    }
    let _e421 = phi_6595_;
    phi_6605_ = _e421;
    if _e421 {
        let _e422 = (*randVal_2);
        let _e426 = tuning.treeFlowChance;
        phi_6605_ = (fract((_e422 * 29f)) < _e426);
    }
    let _e429 = phi_6605_;
    if _e429 {
        let _e430 = upValue;
        param_121 = _e430;
        let _e431 = getDir_u0028_u1_u003b((&param_121));
        let _e432 = upValue;
        param_122 = _e432;
        let _e433 = getAge_u0028_u1_u003b((&param_122));
        param_123 = 18u;
        param_124 = _e431;
        param_125 = 0u;
        param_126 = (_e433 + 1u);
        let _e435 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_123), (&param_124), (&param_125), (&param_126));
        lifted = _e435;
        let _e436 = upIndex;
        let _e439 = upValue;
        let _e440 = lifted;
        let _e441 = atomicCompareExchangeWeak((&unnamed.grid[_e436]), _e439, _e440);
        let _e443 = upValue;
        if (_e441.old_value == _e443) {
            let _e445 = water;
            water = (_e445 - 1u);
            changed = true;
        }
    }
    let _e447 = height;
    let _e449 = (*pos_4);
    param_127 = _e449;
    let _e450 = treeTargetHeight_u0028_vi3_u003b((&param_127));
    if ((_e447 + 1u) < _e450) {
        let _e452 = water;
        let _e454 = tuning.treeGrowCost;
        let _e455 = (_e452 >= _e454);
        phi_6650_ = _e455;
        if _e455 {
            let _e456 = upPos;
            param_128 = _e456;
            let _e457 = treeInBounds_u0028_vi3_u003b((&param_128));
            phi_6650_ = _e457;
        }
        let _e459 = phi_6650_;
        if _e459 {
            let _e460 = upValue;
            param_129 = _e460;
            let _e461 = getType_u0028_u1_u003b((&param_129));
            upType = _e461;
            let _e462 = upType;
            let _e464 = upType;
            if ((_e462 == 0u) || (_e464 == 19u)) {
                let _e467 = height;
                param_130 = 18u;
                param_131 = (_e467 + 1u);
                param_132 = 0u;
                param_133 = 0u;
                let _e469 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_130), (&param_131), (&param_132), (&param_133));
                sapling = _e469;
                let _e470 = upIndex;
                let _e473 = upValue;
                let _e474 = sapling;
                let _e475 = atomicCompareExchangeWeak((&unnamed.grid[_e470]), _e473, _e474);
                let _e477 = upValue;
                if (_e475.old_value == _e477) {
                    let _e480 = tuning.treeGrowCost;
                    let _e481 = water;
                    water = (_e481 - _e480);
                    changed = true;
                }
            }
        }
    } else {
        let _e483 = water;
        let _e485 = tuning.treeLeafCost;
        let _e486 = (_e483 >= _e485);
        phi_6701_ = _e486;
        if _e486 {
            let _e487 = (*randVal_2);
            let _e491 = tuning.treeLeafChance;
            phi_6701_ = (fract((_e487 * 37f)) < _e491);
        }
        let _e494 = phi_6701_;
        if _e494 {
            let _e495 = (*randVal_2);
            start_3 = i32((fract((_e495 * 43f)) * 26f));
            i_4 = 0i;
            loop {
                let _e500 = i_4;
                if (_e500 < 26i) {
                    let _e502 = (*pos_4);
                    let _e503 = start_3;
                    let _e504 = i_4;
                    let _e505 = (_e503 + _e504);
                    param_134 = (_e505 - (i32(floor((f32(_e505) / f32(26i)))) * 26i));
                    let _e513 = tree26_u0028_i1_u003b((&param_134));
                    c_2 = (_e502 + _e513);
                    let _e515 = c_2;
                    param_135 = _e515;
                    let _e516 = treeInBounds_u0028_vi3_u003b((&param_135));
                    if !(_e516) {
                        continue;
                    }
                    let _e518 = c_2;
                    param_136 = _e518;
                    let _e519 = getIndex_u0028_vi3_u003b((&param_136));
                    idx_1 = _e519;
                    let _e520 = idx_1;
                    param_137 = _e520;
                    let _e521 = readCell_u0028_u1_u003b((&param_137));
                    if (_e521 != 0u) {
                        continue;
                    }
                    let _e523 = idx_1;
                    param_138 = 19u;
                    param_139 = 0u;
                    param_140 = 0u;
                    param_141 = 1u;
                    let _e526 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_138), (&param_139), (&param_140), (&param_141));
                    let _e527 = atomicCompareExchangeWeak((&unnamed.grid[_e523]), 0u, _e526);
                    if (_e527.old_value == 0u) {
                        let _e531 = tuning.treeLeafCost;
                        let _e532 = water;
                        water = (_e532 - _e531);
                        changed = true;
                        break;
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e534 = i_4;
                    i_4 = (_e534 + 1i);
                }
            }
        }
    }
    let _e536 = water;
    let _e538 = tuning.treeSpreadCost;
    let _e539 = (_e536 >= _e538);
    phi_6780_ = _e539;
    if _e539 {
        let _e540 = (*randVal_2);
        let _e544 = tuning.treeSpreadChance;
        phi_6780_ = (fract((_e540 * 59f)) < _e544);
    }
    let _e547 = phi_6780_;
    if _e547 {
        let _e548 = (*randVal_2);
        start_4 = i32((fract((_e548 * 61f)) * 8f));
        i_5 = 0i;
        loop {
            let _e553 = i_5;
            if (_e553 < 8i) {
                let _e555 = (*pos_4);
                let _e556 = start_4;
                let _e557 = i_5;
                let _e558 = (_e556 + _e557);
                param_142 = (_e558 - (i32(floor((f32(_e558) / f32(8i)))) * 8i));
                let _e566 = getHDir_u0028_i1_u003b((&param_142));
                c_3 = (_e555 + _e566);
                let _e568 = c_3;
                param_143 = _e568;
                let _e569 = treeInBounds_u0028_vi3_u003b((&param_143));
                if !(_e569) {
                    continue;
                }
                let _e571 = c_3;
                param_144 = _e571;
                let _e572 = getIndex_u0028_vi3_u003b((&param_144));
                idx_2 = _e572;
                let _e573 = idx_2;
                param_145 = _e573;
                let _e574 = readCell_u0028_u1_u003b((&param_145));
                if (_e574 != 0u) {
                    continue;
                }
                let _e576 = c_3;
                param_146 = (_e576 + vec3<i32>(0i, -1i, 0i));
                let _e578 = getIndex_u0028_vi3_u003b((&param_146));
                param_147 = _e578;
                let _e579 = readCell_u0028_u1_u003b((&param_147));
                param_148 = _e579;
                let _e580 = isGrassBlock_u0028_u1_u003b((&param_148));
                if !(_e580) {
                    continue;
                }
                let _e582 = idx_2;
                param_149 = 18u;
                param_150 = 0u;
                param_151 = 0u;
                param_152 = 0u;
                let _e585 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_149), (&param_150), (&param_151), (&param_152));
                let _e586 = atomicCompareExchangeWeak((&unnamed.grid[_e582]), 0u, _e585);
                if (_e586.old_value == 0u) {
                    let _e590 = tuning.treeSpreadCost;
                    let _e591 = water;
                    water = (_e591 - _e590);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e593 = i_5;
                i_5 = (_e593 + 1i);
            }
        }
    }
    let _e595 = changed;
    if _e595 {
        let _e596 = (*currentIndex_3);
        let _e599 = (*rawValue_2);
        param_153 = 18u;
        let _e600 = height;
        param_154 = _e600;
        param_155 = 0u;
        let _e601 = water;
        param_156 = _e601;
        let _e602 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_153), (&param_154), (&param_155), (&param_156));
        let _e603 = atomicCompareExchangeWeak((&unnamed.grid[_e596]), _e599, _e602);
    }
    return;
}

fn locustPackNav_u0028_u1_u003b_u1_u003b(heading: ptr<function, u32>, steps: ptr<function, u32>) -> u32 {
    let _e216 = (*heading);
    let _e218 = (*steps);
    return ((_e216 & 7u) | (min(_e218, 7u) << bitcast<u32>(3i)));
}

fn locustReverse_u0028_u1_u003b(d_1: ptr<function, u32>) -> u32 {
    let _e215 = (*d_1);
    if (_e215 == 0u) {
        return 1u;
    }
    let _e217 = (*d_1);
    if (_e217 == 1u) {
        return 0u;
    }
    let _e219 = (*d_1);
    if (_e219 == 2u) {
        return 3u;
    }
    let _e221 = (*d_1);
    if (_e221 == 3u) {
        return 2u;
    }
    let _e223 = (*d_1);
    if (_e223 == 4u) {
        return 7u;
    }
    let _e225 = (*d_1);
    if (_e225 == 5u) {
        return 6u;
    }
    let _e227 = (*d_1);
    if (_e227 == 6u) {
        return 5u;
    }
    return 4u;
}

fn locustRunSteps_u0028_() -> u32 {
    let _e215 = tuning.locustRunLength;
    return clamp(_e215, 1u, 7u);
}

fn isLocustFood_u0028_u1_u003b(value_1: ptr<function, u32>) -> bool {
    var param_157: u32;
    var param_158: u32;
    var phi_981_: bool;

    let _e217 = (*value_1);
    param_157 = _e217;
    let _e218 = isGrassBlock_u0028_u1_u003b((&param_157));
    phi_981_ = _e218;
    if !(_e218) {
        let _e220 = (*value_1);
        param_158 = _e220;
        let _e221 = getType_u0028_u1_u003b((&param_158));
        phi_981_ = (_e221 == 19u);
    }
    let _e224 = phi_981_;
    return _e224;
}

fn locustFoodAt_u0028_vi3_u003b(p_2: ptr<function, vec3<i32>>) -> bool {
    var param_159: vec3<i32>;
    var param_160: u32;
    var param_161: u32;
    var phi_996_: bool;
    var phi_1003_: bool;
    var phi_1013_: bool;
    var phi_1020_: bool;
    var phi_1030_: bool;

    let _e219 = (*p_2)[0u];
    let _e220 = (_e219 < 0i);
    phi_996_ = _e220;
    if !(_e220) {
        let _e223 = (*p_2)[0u];
        let _e225 = tuning.gridWidth;
        phi_996_ = (_e223 >= bitcast<i32>(_e225));
    }
    let _e229 = phi_996_;
    phi_1003_ = _e229;
    if !(_e229) {
        let _e232 = (*p_2)[1u];
        phi_1003_ = (_e232 < 0i);
    }
    let _e235 = phi_1003_;
    phi_1013_ = _e235;
    if !(_e235) {
        let _e238 = (*p_2)[1u];
        let _e240 = tuning.gridHeight;
        phi_1013_ = (_e238 >= bitcast<i32>(_e240));
    }
    let _e244 = phi_1013_;
    phi_1020_ = _e244;
    if !(_e244) {
        let _e247 = (*p_2)[2u];
        phi_1020_ = (_e247 < 0i);
    }
    let _e250 = phi_1020_;
    phi_1030_ = _e250;
    if !(_e250) {
        let _e253 = (*p_2)[2u];
        let _e255 = tuning.gridDepth;
        phi_1030_ = (_e253 >= bitcast<i32>(_e255));
    }
    let _e259 = phi_1030_;
    if _e259 {
        return false;
    }
    let _e260 = (*p_2);
    param_159 = _e260;
    let _e261 = getIndex_u0028_vi3_u003b((&param_159));
    param_160 = _e261;
    let _e262 = readCell_u0028_u1_u003b((&param_160));
    param_161 = _e262;
    let _e263 = isLocustFood_u0028_u1_u003b((&param_161));
    return _e263;
}

fn locustSteps_u0028_u1_u003b(dirByte: ptr<function, u32>) -> u32 {
    let _e215 = (*dirByte);
    return ((_e215 >> bitcast<u32>(3i)) & 7u);
}

fn locustHeading_u0028_u1_u003b(dirByte_1: ptr<function, u32>) -> u32 {
    let _e215 = (*dirByte_1);
    return (_e215 & 7u);
}

fn locustArriveDir_u0028_vi3_u003b_u1_u003b(dest: ptr<function, vec3<i32>>, nav: ptr<function, u32>) -> u32 {
    var param_162: vec3<i32>;

    let _e217 = (*dest);
    param_162 = (_e217 + vec3<i32>(0i, -1i, 0i));
    let _e219 = locustFoodAt_u0028_vi3_u003b((&param_162));
    let _e220 = (*nav);
    return select(_e220, 0u, _e219);
}

fn locustHasGrip_u0028_vi3_u003b(pos_5: ptr<function, vec3<i32>>) -> bool {
    var d_2: i32;
    var n: vec3<i32>;
    var param_163: i32;
    var param_164: vec3<i32>;
    var param_165: u32;
    var phi_1133_: bool;
    var phi_1140_: bool;
    var phi_1151_: bool;

    d_2 = 0i;
    loop {
        let _e220 = d_2;
        if (_e220 < 8i) {
            let _e222 = (*pos_5);
            let _e223 = d_2;
            param_163 = _e223;
            let _e224 = getHDir_u0028_i1_u003b((&param_163));
            n = (_e222 + _e224);
            let _e227 = n[0u];
            let _e228 = (_e227 <= 0i);
            phi_1133_ = _e228;
            if !(_e228) {
                let _e231 = n[0u];
                let _e233 = tuning.gridWidth;
                phi_1133_ = (_e231 >= (bitcast<i32>(_e233) - 1i));
            }
            let _e238 = phi_1133_;
            phi_1140_ = _e238;
            if !(_e238) {
                let _e241 = n[2u];
                phi_1140_ = (_e241 <= 0i);
            }
            let _e244 = phi_1140_;
            phi_1151_ = _e244;
            if !(_e244) {
                let _e247 = n[2u];
                let _e249 = tuning.gridDepth;
                phi_1151_ = (_e247 >= (bitcast<i32>(_e249) - 1i));
            }
            let _e254 = phi_1151_;
            if _e254 {
                continue;
            }
            let _e255 = n;
            param_164 = _e255;
            let _e256 = getIndex_u0028_vi3_u003b((&param_164));
            param_165 = _e256;
            let _e257 = readCell_u0028_u1_u003b((&param_165));
            if (_e257 != 0u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e259 = d_2;
            d_2 = (_e259 + 1i);
        }
    }
    return false;
}

fn locustStage_u0028_() -> u32 {
    let _e215 = tuning.locustStageSize;
    return max(_e215, 1u);
}

fn locustTypeFor_u0028_u1_u003b(count: ptr<function, u32>) -> u32 {
    var stage: u32;
    var local_5: u32;

    let _e217 = (*count);
    if (_e217 == 0u) {
        local_5 = 0u;
    } else {
        let _e219 = (*count);
        let _e221 = locustStage_u0028_();
        local_5 = ((_e219 - 1u) / _e221);
    }
    let _e223 = local_5;
    stage = _e223;
    let _e224 = stage;
    return (13u + min(_e224, 4u));
}

fn locustInBounds_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> bool {
    var phi_917_: bool;
    var phi_923_: bool;
    var phi_933_: bool;
    var phi_939_: bool;
    var phi_949_: bool;

    let _e216 = (*p_3)[0u];
    let _e217 = (_e216 > 0i);
    phi_917_ = _e217;
    if _e217 {
        let _e219 = (*p_3)[0u];
        let _e221 = tuning.gridWidth;
        phi_917_ = (_e219 < (bitcast<i32>(_e221) - 1i));
    }
    let _e226 = phi_917_;
    phi_923_ = _e226;
    if _e226 {
        let _e228 = (*p_3)[1u];
        phi_923_ = (_e228 > 0i);
    }
    let _e231 = phi_923_;
    phi_933_ = _e231;
    if _e231 {
        let _e233 = (*p_3)[1u];
        let _e235 = tuning.gridHeight;
        phi_933_ = (_e233 < (bitcast<i32>(_e235) - 1i));
    }
    let _e240 = phi_933_;
    phi_939_ = _e240;
    if _e240 {
        let _e242 = (*p_3)[2u];
        phi_939_ = (_e242 > 0i);
    }
    let _e245 = phi_939_;
    phi_949_ = _e245;
    if _e245 {
        let _e247 = (*p_3)[2u];
        let _e249 = tuning.gridDepth;
        phi_949_ = (_e247 < (bitcast<i32>(_e249) - 1i));
    }
    let _e254 = phi_949_;
    return _e254;
}

fn locustMaxCount_u0028_() -> u32 {
    let _e215 = tuning.locustMaxSize;
    return max(_e215, 1u);
}

fn locustBud_u0028_vi3_u003b_f1_u003b(pos_6: ptr<function, vec3<i32>>, randVal_3: ptr<function, f32>) {
    var bud: u32;
    var start_5: i32;
    var i_6: i32;
    var d_3: i32;
    var c_4: vec3<i32>;
    var param_166: i32;
    var param_167: vec3<i32>;
    var idx_3: u32;
    var param_168: vec3<i32>;
    var param_169: u32;
    var param_170: u32;
    var param_171: u32;
    var param_172: u32;
    var param_173: u32;
    var param_174: u32;

    let _e232 = tuning.locustBudSize;
    let _e233 = locustMaxCount_u0028_();
    bud = clamp(_e232, 1u, _e233);
    let _e235 = (*randVal_3);
    start_5 = i32((fract((_e235 * 31f)) * 8f));
    i_6 = 0i;
    loop {
        let _e240 = i_6;
        if (_e240 < 8i) {
            let _e242 = start_5;
            let _e243 = i_6;
            let _e244 = (_e242 + _e243);
            d_3 = (_e244 - (i32(floor((f32(_e244) / f32(8i)))) * 8i));
            let _e252 = (*pos_6);
            let _e253 = d_3;
            param_166 = _e253;
            let _e254 = getHDir_u0028_i1_u003b((&param_166));
            c_4 = (_e252 + _e254);
            let _e256 = c_4;
            param_167 = _e256;
            let _e257 = locustInBounds_u0028_vi3_u003b((&param_167));
            if !(_e257) {
                continue;
            }
            let _e259 = c_4;
            param_168 = _e259;
            let _e260 = getIndex_u0028_vi3_u003b((&param_168));
            idx_3 = _e260;
            let _e261 = idx_3;
            param_169 = _e261;
            let _e262 = readCell_u0028_u1_u003b((&param_169));
            if (_e262 != 0u) {
                continue;
            }
            let _e264 = idx_3;
            let _e267 = bud;
            param_170 = _e267;
            let _e268 = locustTypeFor_u0028_u1_u003b((&param_170));
            param_171 = _e268;
            param_172 = 0u;
            param_173 = 0u;
            let _e269 = bud;
            param_174 = _e269;
            let _e270 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_171), (&param_172), (&param_173), (&param_174));
            let _e271 = atomicCompareExchangeWeak((&unnamed.grid[_e264]), 0u, _e270);
            if (_e271.old_value == 0u) {
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e274 = i_6;
            i_6 = (_e274 + 1i);
        }
    }
    return;
}

fn locustEatTicks_u0028_u1_u003b(count_1: ptr<function, u32>) -> u32 {
    var fast: u32;
    var slow: u32;
    var cap_1: u32;
    var floorCount: u32;
    var t_2: f32;

    let _e221 = tuning.locustEatTicksMin;
    fast = _e221;
    let _e223 = tuning.locustEatTicksMax;
    slow = _e223;
    let _e224 = locustMaxCount_u0028_();
    cap_1 = _e224;
    let _e225 = locustStage_u0028_();
    let _e226 = cap_1;
    floorCount = min(_e225, _e226);
    let _e228 = (*count_1);
    let _e229 = cap_1;
    if (_e228 >= _e229) {
        let _e231 = fast;
        return _e231;
    }
    let _e232 = (*count_1);
    let _e233 = floorCount;
    let _e235 = cap_1;
    let _e236 = floorCount;
    if ((_e232 <= _e233) || (_e235 == _e236)) {
        let _e239 = slow;
        return _e239;
    }
    let _e240 = (*count_1);
    let _e241 = floorCount;
    let _e244 = cap_1;
    let _e245 = floorCount;
    t_2 = (f32((_e240 - _e241)) / f32((_e244 - _e245)));
    let _e249 = slow;
    let _e251 = fast;
    let _e253 = t_2;
    return u32(round(mix(f32(_e249), f32(_e251), _e253)));
}

fn isLava_u0028_u1_u003b(type_34: ptr<function, u32>) -> bool {
    let _e215 = (*type_34);
    let _e217 = (*type_34);
    return ((_e215 >= 8u) && (_e217 <= 11u));
}

fn updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_7: ptr<function, vec3<i32>>, currentIndex_4: ptr<function, u32>, rawValue_3: ptr<function, u32>, currentDir_1: ptr<function, u32>, currentSleep_1: ptr<function, u32>, currentAge_3: ptr<function, u32>, randVal_4: ptr<function, f32>) {
    var type_35: u32;
    var param_175: u32;
    var start_6: i32;
    var i_7: i32;
    var nPos: vec3<i32>;
    var param_176: i32;
    var param_177: vec3<i32>;
    var nType: u32;
    var param_178: vec3<i32>;
    var param_179: u32;
    var param_180: u32;
    var param_181: u32;
    var phase: u32;
    var param_182: u32;
    var param_183: u32;
    var param_184: u32;
    var param_185: u32;
    var count_2: u32;
    var belowPos_2: vec3<i32>;
    var belowIndex_1: u32;
    var param_186: vec3<i32>;
    var belowValue_1: u32;
    var param_187: u32;
    var param_188: u32;
    var onLeaf: bool;
    var param_189: u32;
    var need: u32;
    var param_190: u32;
    var progress: u32;
    var flora_2: u32;
    var bite: u32;
    var thinned: u32;
    var local_6: u32;
    var param_191: u32;
    var param_192: u32;
    var param_193: u32;
    var param_194: u32;
    var param_195: u32;
    var param_196: u32;
    var param_197: u32;
    var param_198: u32;
    var param_199: u32;
    var param_200: u32;
    var stripped: u32;
    var local_7: u32;
    var param_201: u32;
    var param_202: u32;
    var param_203: u32;
    var param_204: u32;
    var param_205: u32;
    var param_206: u32;
    var grown: u32;
    var param_207: vec3<i32>;
    var param_208: f32;
    var param_209: u32;
    var param_210: u32;
    var param_211: u32;
    var param_212: u32;
    var param_213: u32;
    var newType: u32;
    var param_214: u32;
    var param_215: u32;
    var param_216: vec3<i32>;
    var param_217: vec3<i32>;
    var param_218: vec3<i32>;
    var param_219: u32;
    var param_220: u32;
    var param_221: u32;
    var param_222: u32;
    var param_223: u32;
    var param_224: u32;
    var param_225: u32;
    var param_226: u32;
    var param_227: u32;
    var heading_1: u32;
    var param_228: u32;
    var steps_1: u32;
    var param_229: u32;
    var start_7: i32;
    var i_8: i32;
    var d_4: i32;
    var c_5: vec3<i32>;
    var param_230: i32;
    var rise: i32;
    var t_3: vec3<i32>;
    var local_8: i32;
    var param_231: vec3<i32>;
    var param_232: vec3<i32>;
    var param_233: u32;
    var param_234: vec3<i32>;
    var param_235: vec3<i32>;
    var param_236: u32;
    var param_237: u32;
    var param_238: u32;
    var param_239: u32;
    var param_240: u32;
    var param_241: u32;
    var param_242: u32;
    var param_243: u32;
    var target_1: vec3<i32>;
    var param_244: i32;
    var blocked: bool;
    var param_245: vec3<i32>;
    var param_246: vec3<i32>;
    var param_247: u32;
    var footing: vec3<i32>;
    var param_248: vec3<i32>;
    var param_249: vec3<i32>;
    var param_250: u32;
    var back: u32;
    var param_251: u32;
    var backPos: vec3<i32>;
    var param_252: i32;
    var backFoot: vec3<i32>;
    var backOpen: bool;
    var param_253: vec3<i32>;
    var param_254: vec3<i32>;
    var param_255: u32;
    var param_256: vec3<i32>;
    var param_257: vec3<i32>;
    var param_258: u32;
    var turnedNav: u32;
    var local_9: u32;
    var param_259: u32;
    var param_260: u32;
    var param_261: u32;
    var param_262: u32;
    var param_263: u32;
    var param_264: u32;
    var param_265: u32;
    var param_266: u32;
    var nav_1: u32;
    var param_267: u32;
    var param_268: u32;
    var param_269: vec3<i32>;
    var param_270: vec3<i32>;
    var param_271: u32;
    var param_272: u32;
    var param_273: u32;
    var param_274: u32;
    var param_275: u32;
    var param_276: u32;
    var param_277: u32;
    var param_278: u32;
    var param_279: u32;
    var overTop: vec3<i32>;
    var param_280: vec3<i32>;
    var param_281: vec3<i32>;
    var param_282: u32;
    var nav_2: u32;
    var param_283: u32;
    var param_284: u32;
    var param_285: vec3<i32>;
    var param_286: vec3<i32>;
    var param_287: u32;
    var param_288: u32;
    var param_289: u32;
    var param_290: u32;
    var param_291: u32;
    var param_292: u32;
    var param_293: u32;
    var param_294: u32;
    var param_295: u32;
    var up: vec3<i32>;
    var param_296: vec3<i32>;
    var param_297: vec3<i32>;
    var param_298: u32;
    var nav_3: u32;
    var param_299: u32;
    var param_300: u32;
    var param_301: vec3<i32>;
    var param_302: vec3<i32>;
    var param_303: u32;
    var param_304: u32;
    var param_305: u32;
    var param_306: u32;
    var param_307: u32;
    var param_308: u32;
    var param_309: u32;
    var param_310: u32;
    var param_311: u32;
    var param_312: u32;
    var param_313: u32;
    var param_314: u32;
    var param_315: u32;
    var param_316: u32;
    var param_317: u32;
    var phi_7210_: bool;
    var phi_7418_: bool;
    var phi_7425_: bool;
    var phi_7586_: bool;
    var phi_7605_: bool;
    var phi_7634_: bool;
    var phi_7648_: bool;
    var phi_7650_: bool;
    var phi_7742_: bool;
    var phi_7791_: bool;

    let _e408 = (*rawValue_3);
    param_175 = _e408;
    let _e409 = getType_u0028_u1_u003b((&param_175));
    type_35 = _e409;
    let _e410 = (*randVal_4);
    start_6 = i32((fract((_e410 * 61f)) * 26f));
    i_7 = 0i;
    loop {
        let _e415 = i_7;
        if (_e415 < 26i) {
            let _e417 = (*pos_7);
            let _e418 = start_6;
            let _e419 = i_7;
            let _e420 = (_e418 + _e419);
            param_176 = (_e420 - (i32(floor((f32(_e420) / f32(26i)))) * 26i));
            let _e428 = tree26_u0028_i1_u003b((&param_176));
            nPos = (_e417 + _e428);
            let _e430 = nPos;
            param_177 = _e430;
            let _e431 = locustInBounds_u0028_vi3_u003b((&param_177));
            if !(_e431) {
                continue;
            }
            let _e433 = nPos;
            param_178 = _e433;
            let _e434 = getIndex_u0028_vi3_u003b((&param_178));
            param_179 = _e434;
            let _e435 = readCell_u0028_u1_u003b((&param_179));
            param_180 = _e435;
            let _e436 = getType_u0028_u1_u003b((&param_180));
            nType = _e436;
            let _e437 = nType;
            let _e438 = (_e437 == 5u);
            phi_7210_ = _e438;
            if !(_e438) {
                let _e440 = nType;
                param_181 = _e440;
                let _e441 = isLava_u0028_u1_u003b((&param_181));
                phi_7210_ = _e441;
            }
            let _e443 = phi_7210_;
            if _e443 {
                let _e444 = (*currentIndex_4);
                let _e447 = (*rawValue_3);
                let _e448 = atomicCompareExchangeWeak((&unnamed.grid[_e444]), _e447, 0u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e450 = i_7;
            i_7 = (_e450 + 1i);
        }
    }
    let _e452 = (*currentSleep_1);
    phase = (_e452 + 1u);
    let _e454 = phase;
    let _e456 = tuning.locustTickDispatches;
    if (_e454 < _e456) {
        let _e458 = (*currentIndex_4);
        let _e461 = (*rawValue_3);
        let _e462 = type_35;
        param_182 = _e462;
        let _e463 = (*currentDir_1);
        param_183 = _e463;
        let _e464 = phase;
        param_184 = _e464;
        let _e465 = (*currentAge_3);
        param_185 = _e465;
        let _e466 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_182), (&param_183), (&param_184), (&param_185));
        let _e467 = atomicCompareExchangeWeak((&unnamed.grid[_e458]), _e461, _e466);
        return;
    }
    let _e469 = (*currentAge_3);
    count_2 = _e469;
    let _e470 = (*pos_7);
    belowPos_2 = (_e470 + vec3<i32>(0i, -1i, 0i));
    let _e472 = belowPos_2;
    param_186 = _e472;
    let _e473 = getIndex_u0028_vi3_u003b((&param_186));
    belowIndex_1 = _e473;
    let _e474 = belowIndex_1;
    param_187 = _e474;
    let _e475 = readCell_u0028_u1_u003b((&param_187));
    belowValue_1 = _e475;
    let _e476 = belowValue_1;
    param_188 = _e476;
    let _e477 = isLocustFood_u0028_u1_u003b((&param_188));
    if _e477 {
        let _e478 = belowValue_1;
        param_189 = _e478;
        let _e479 = getType_u0028_u1_u003b((&param_189));
        onLeaf = (_e479 == 19u);
        let _e481 = count_2;
        param_190 = _e481;
        let _e482 = locustEatTicks_u0028_u1_u003b((&param_190));
        need = _e482;
        let _e483 = (*currentDir_1);
        progress = (_e483 + 1u);
        let _e485 = progress;
        let _e486 = need;
        if (_e485 < _e486) {
            let _e488 = onLeaf;
            if !(_e488) {
                let _e490 = belowValue_1;
                flora_2 = ((_e490 >> bitcast<u32>(8i)) & 255u);
                let _e494 = need;
                bite = max((90u / max(_e494, 1u)), 1u);
                let _e498 = flora_2;
                let _e499 = bite;
                if (_e498 > (11u + _e499)) {
                    let _e502 = flora_2;
                    let _e503 = bite;
                    local_6 = (_e502 - _e503);
                } else {
                    local_6 = 11u;
                }
                let _e505 = local_6;
                thinned = _e505;
                let _e506 = belowIndex_1;
                let _e509 = belowValue_1;
                let _e510 = belowValue_1;
                param_191 = _e510;
                let _e511 = getSleep_u0028_u1_u003b((&param_191));
                let _e512 = belowValue_1;
                param_192 = _e512;
                let _e513 = getAge_u0028_u1_u003b((&param_192));
                param_193 = 4u;
                let _e514 = thinned;
                param_194 = _e514;
                param_195 = _e511;
                param_196 = _e513;
                let _e515 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_193), (&param_194), (&param_195), (&param_196));
                let _e516 = atomicCompareExchangeWeak((&unnamed.grid[_e506]), _e509, _e515);
            }
            let _e518 = (*currentIndex_4);
            let _e521 = (*rawValue_3);
            let _e522 = type_35;
            param_197 = _e522;
            let _e523 = progress;
            param_198 = _e523;
            param_199 = 0u;
            let _e524 = count_2;
            param_200 = _e524;
            let _e525 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_197), (&param_198), (&param_199), (&param_200));
            let _e526 = atomicCompareExchangeWeak((&unnamed.grid[_e518]), _e521, _e525);
            return;
        }
        let _e528 = onLeaf;
        if _e528 {
            local_7 = 0u;
        } else {
            let _e529 = belowValue_1;
            param_201 = _e529;
            let _e530 = getSleep_u0028_u1_u003b((&param_201));
            let _e531 = belowValue_1;
            param_202 = _e531;
            let _e532 = getAge_u0028_u1_u003b((&param_202));
            param_203 = 4u;
            param_204 = 0u;
            param_205 = _e530;
            param_206 = _e532;
            let _e533 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_203), (&param_204), (&param_205), (&param_206));
            local_7 = _e533;
        }
        let _e534 = local_7;
        stripped = _e534;
        let _e535 = belowIndex_1;
        let _e538 = belowValue_1;
        let _e539 = stripped;
        let _e540 = atomicCompareExchangeWeak((&unnamed.grid[_e535]), _e538, _e539);
        let _e542 = belowValue_1;
        if (_e540.old_value != _e542) {
            return;
        }
        let _e544 = count_2;
        let _e546 = tuning.locustEatGain;
        grown = (_e544 + _e546);
        let _e548 = grown;
        let _e549 = locustMaxCount_u0028_();
        if (_e548 > _e549) {
            let _e551 = (*pos_7);
            param_207 = _e551;
            let _e552 = (*randVal_4);
            param_208 = _e552;
            locustBud_u0028_vi3_u003b_f1_u003b((&param_207), (&param_208));
            let _e553 = locustMaxCount_u0028_();
            grown = _e553;
        }
        let _e554 = (*currentIndex_4);
        let _e557 = (*rawValue_3);
        let _e558 = grown;
        param_209 = _e558;
        let _e559 = locustTypeFor_u0028_u1_u003b((&param_209));
        param_210 = _e559;
        param_211 = 0u;
        param_212 = 0u;
        let _e560 = grown;
        param_213 = _e560;
        let _e561 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_210), (&param_211), (&param_212), (&param_213));
        let _e562 = atomicCompareExchangeWeak((&unnamed.grid[_e554]), _e557, _e561);
        return;
    }
    let _e564 = count_2;
    if (_e564 <= 1u) {
        let _e566 = (*currentIndex_4);
        let _e569 = (*rawValue_3);
        let _e570 = atomicCompareExchangeWeak((&unnamed.grid[_e566]), _e569, 0u);
        return;
    }
    let _e572 = count_2;
    count_2 = (_e572 - 1u);
    let _e574 = count_2;
    param_214 = _e574;
    let _e575 = locustTypeFor_u0028_u1_u003b((&param_214));
    newType = _e575;
    let _e576 = belowValue_1;
    param_215 = _e576;
    let _e577 = getType_u0028_u1_u003b((&param_215));
    let _e578 = (_e577 == 0u);
    phi_7418_ = _e578;
    if _e578 {
        let _e579 = belowPos_2;
        param_216 = _e579;
        let _e580 = locustInBounds_u0028_vi3_u003b((&param_216));
        phi_7418_ = _e580;
    }
    let _e582 = phi_7418_;
    phi_7425_ = _e582;
    if _e582 {
        let _e583 = (*pos_7);
        param_217 = _e583;
        let _e584 = locustHasGrip_u0028_vi3_u003b((&param_217));
        phi_7425_ = !(_e584);
    }
    let _e587 = phi_7425_;
    if _e587 {
        let _e588 = belowPos_2;
        param_218 = _e588;
        let _e589 = (*currentDir_1);
        param_219 = _e589;
        let _e590 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_218), (&param_219));
        let _e591 = newType;
        param_220 = _e591;
        param_221 = _e590;
        param_222 = 0u;
        let _e592 = count_2;
        param_223 = _e592;
        let _e593 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_220), (&param_221), (&param_222), (&param_223));
        let _e594 = (*currentIndex_4);
        param_224 = _e594;
        let _e595 = (*rawValue_3);
        param_225 = _e595;
        let _e596 = belowIndex_1;
        param_226 = _e596;
        param_227 = _e593;
        let _e597 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_224), (&param_225), (&param_226), (&param_227));
        if _e597 {
            return;
        }
    }
    let _e598 = (*currentDir_1);
    param_228 = _e598;
    let _e599 = locustHeading_u0028_u1_u003b((&param_228));
    heading_1 = _e599;
    let _e600 = (*currentDir_1);
    param_229 = _e600;
    let _e601 = locustSteps_u0028_u1_u003b((&param_229));
    steps_1 = _e601;
    let _e602 = steps_1;
    if (_e602 == 0u) {
        let _e604 = (*randVal_4);
        start_7 = i32((fract((_e604 * 17f)) * 8f));
        i_8 = 0i;
        loop {
            let _e609 = i_8;
            if (_e609 < 8i) {
                let _e611 = start_7;
                let _e612 = i_8;
                let _e613 = (_e611 + _e612);
                d_4 = (_e613 - (i32(floor((f32(_e613) / f32(8i)))) * 8i));
                let _e621 = (*pos_7);
                let _e622 = d_4;
                param_230 = _e622;
                let _e623 = getHDir_u0028_i1_u003b((&param_230));
                c_5 = (_e621 + _e623);
                rise = 0i;
                loop {
                    let _e625 = rise;
                    if (_e625 < 3i) {
                        let _e627 = c_5;
                        let _e628 = rise;
                        if (_e628 == 1i) {
                            local_8 = 1i;
                        } else {
                            let _e630 = rise;
                            local_8 = select(0i, -1i, (_e630 == 2i));
                        }
                        let _e633 = local_8;
                        t_3 = (_e627 + vec3<i32>(0i, _e633, 0i));
                        let _e636 = t_3;
                        param_231 = _e636;
                        let _e637 = locustInBounds_u0028_vi3_u003b((&param_231));
                        if !(_e637) {
                            continue;
                        }
                        let _e639 = t_3;
                        param_232 = _e639;
                        let _e640 = getIndex_u0028_vi3_u003b((&param_232));
                        param_233 = _e640;
                        let _e641 = readCell_u0028_u1_u003b((&param_233));
                        if (_e641 != 0u) {
                            continue;
                        }
                        let _e643 = t_3;
                        param_234 = (_e643 + vec3<i32>(0i, -1i, 0i));
                        let _e645 = locustFoodAt_u0028_vi3_u003b((&param_234));
                        if !(_e645) {
                            continue;
                        }
                        let _e647 = t_3;
                        param_235 = _e647;
                        let _e648 = getIndex_u0028_vi3_u003b((&param_235));
                        let _e649 = newType;
                        param_236 = _e649;
                        param_237 = 0u;
                        param_238 = 0u;
                        let _e650 = count_2;
                        param_239 = _e650;
                        let _e651 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_236), (&param_237), (&param_238), (&param_239));
                        let _e652 = (*currentIndex_4);
                        param_240 = _e652;
                        let _e653 = (*rawValue_3);
                        param_241 = _e653;
                        param_242 = _e648;
                        param_243 = _e651;
                        let _e654 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_240), (&param_241), (&param_242), (&param_243));
                        if _e654 {
                            return;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e655 = rise;
                        rise = (_e655 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e657 = i_8;
                i_8 = (_e657 + 1i);
            }
        }
        let _e659 = (*randVal_4);
        heading_1 = (u32((fract((_e659 * 23f)) * 8f)) & 7u);
        let _e665 = locustRunSteps_u0028_();
        steps_1 = _e665;
    }
    let _e666 = (*pos_7);
    let _e667 = heading_1;
    param_244 = bitcast<i32>(_e667);
    let _e669 = getHDir_u0028_i1_u003b((&param_244));
    target_1 = (_e666 + _e669);
    let _e671 = target_1;
    param_245 = _e671;
    let _e672 = locustInBounds_u0028_vi3_u003b((&param_245));
    let _e673 = !(_e672);
    phi_7586_ = _e673;
    if !(_e673) {
        let _e675 = target_1;
        param_246 = _e675;
        let _e676 = getIndex_u0028_vi3_u003b((&param_246));
        param_247 = _e676;
        let _e677 = readCell_u0028_u1_u003b((&param_247));
        phi_7586_ = (_e677 != 0u);
    }
    let _e680 = phi_7586_;
    blocked = _e680;
    let _e681 = blocked;
    if !(_e681) {
        let _e683 = target_1;
        footing = (_e683 + vec3<i32>(0i, -1i, 0i));
        let _e685 = footing;
        param_248 = _e685;
        let _e686 = locustInBounds_u0028_vi3_u003b((&param_248));
        phi_7605_ = _e686;
        if _e686 {
            let _e687 = footing;
            param_249 = _e687;
            let _e688 = getIndex_u0028_vi3_u003b((&param_249));
            param_250 = _e688;
            let _e689 = readCell_u0028_u1_u003b((&param_250));
            phi_7605_ = (_e689 == 0u);
        }
        let _e692 = phi_7605_;
        if _e692 {
            let _e693 = heading_1;
            param_251 = _e693;
            let _e694 = locustReverse_u0028_u1_u003b((&param_251));
            back = _e694;
            let _e695 = (*pos_7);
            let _e696 = back;
            param_252 = bitcast<i32>(_e696);
            let _e698 = getHDir_u0028_i1_u003b((&param_252));
            backPos = (_e695 + _e698);
            let _e700 = backPos;
            backFoot = (_e700 + vec3<i32>(0i, -1i, 0i));
            let _e702 = backPos;
            param_253 = _e702;
            let _e703 = locustInBounds_u0028_vi3_u003b((&param_253));
            phi_7634_ = _e703;
            if _e703 {
                let _e704 = backPos;
                param_254 = _e704;
                let _e705 = getIndex_u0028_vi3_u003b((&param_254));
                param_255 = _e705;
                let _e706 = readCell_u0028_u1_u003b((&param_255));
                phi_7634_ = (_e706 == 0u);
            }
            let _e709 = phi_7634_;
            phi_7650_ = _e709;
            if _e709 {
                let _e710 = backFoot;
                param_256 = _e710;
                let _e711 = locustInBounds_u0028_vi3_u003b((&param_256));
                phi_7648_ = _e711;
                if _e711 {
                    let _e712 = backFoot;
                    param_257 = _e712;
                    let _e713 = getIndex_u0028_vi3_u003b((&param_257));
                    param_258 = _e713;
                    let _e714 = readCell_u0028_u1_u003b((&param_258));
                    phi_7648_ = (_e714 == 0u);
                }
                let _e717 = phi_7648_;
                phi_7650_ = !(_e717);
            }
            let _e720 = phi_7650_;
            backOpen = _e720;
            let _e721 = backOpen;
            if _e721 {
                let _e722 = back;
                param_259 = _e722;
                let _e723 = steps_1;
                param_260 = _e723;
                let _e724 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_259), (&param_260));
                local_9 = _e724;
            } else {
                let _e725 = (*randVal_4);
                let _e731 = locustRunSteps_u0028_();
                param_261 = (u32((fract((_e725 * 71f)) * 8f)) & 7u);
                param_262 = _e731;
                let _e732 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_261), (&param_262));
                local_9 = _e732;
            }
            let _e733 = local_9;
            turnedNav = _e733;
            let _e734 = (*currentIndex_4);
            let _e737 = (*rawValue_3);
            let _e738 = newType;
            param_263 = _e738;
            let _e739 = turnedNav;
            param_264 = _e739;
            param_265 = 0u;
            let _e740 = count_2;
            param_266 = _e740;
            let _e741 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_263), (&param_264), (&param_265), (&param_266));
            let _e742 = atomicCompareExchangeWeak((&unnamed.grid[_e734]), _e737, _e741);
            return;
        }
        let _e744 = steps_1;
        let _e746 = heading_1;
        param_267 = _e746;
        param_268 = (_e744 - 1u);
        let _e747 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_267), (&param_268));
        nav_1 = _e747;
        let _e748 = target_1;
        param_269 = _e748;
        let _e749 = getIndex_u0028_vi3_u003b((&param_269));
        let _e750 = target_1;
        param_270 = _e750;
        let _e751 = nav_1;
        param_271 = _e751;
        let _e752 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_270), (&param_271));
        let _e753 = newType;
        param_272 = _e753;
        param_273 = _e752;
        param_274 = 0u;
        let _e754 = count_2;
        param_275 = _e754;
        let _e755 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_272), (&param_273), (&param_274), (&param_275));
        let _e756 = (*currentIndex_4);
        param_276 = _e756;
        let _e757 = (*rawValue_3);
        param_277 = _e757;
        param_278 = _e749;
        param_279 = _e755;
        let _e758 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_276), (&param_277), (&param_278), (&param_279));
        if _e758 {
            return;
        }
    } else {
        let _e759 = (*randVal_4);
        let _e763 = tuning.locustClimbChance;
        if (fract((_e759 * 41f)) < _e763) {
            let _e765 = target_1;
            overTop = (_e765 + vec3<i32>(0i, 1i, 0i));
            let _e767 = overTop;
            param_280 = _e767;
            let _e768 = locustInBounds_u0028_vi3_u003b((&param_280));
            phi_7742_ = _e768;
            if _e768 {
                let _e769 = overTop;
                param_281 = _e769;
                let _e770 = getIndex_u0028_vi3_u003b((&param_281));
                param_282 = _e770;
                let _e771 = readCell_u0028_u1_u003b((&param_282));
                phi_7742_ = (_e771 == 0u);
            }
            let _e774 = phi_7742_;
            if _e774 {
                let _e775 = steps_1;
                let _e777 = heading_1;
                param_283 = _e777;
                param_284 = (_e775 - 1u);
                let _e778 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_283), (&param_284));
                nav_2 = _e778;
                let _e779 = overTop;
                param_285 = _e779;
                let _e780 = getIndex_u0028_vi3_u003b((&param_285));
                let _e781 = overTop;
                param_286 = _e781;
                let _e782 = nav_2;
                param_287 = _e782;
                let _e783 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_286), (&param_287));
                let _e784 = newType;
                param_288 = _e784;
                param_289 = _e783;
                param_290 = 0u;
                let _e785 = count_2;
                param_291 = _e785;
                let _e786 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_288), (&param_289), (&param_290), (&param_291));
                let _e787 = (*currentIndex_4);
                param_292 = _e787;
                let _e788 = (*rawValue_3);
                param_293 = _e788;
                param_294 = _e780;
                param_295 = _e786;
                let _e789 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_292), (&param_293), (&param_294), (&param_295));
                if _e789 {
                    return;
                }
            }
            let _e790 = (*pos_7);
            up = (_e790 + vec3<i32>(0i, 1i, 0i));
            let _e792 = up;
            param_296 = _e792;
            let _e793 = locustInBounds_u0028_vi3_u003b((&param_296));
            phi_7791_ = _e793;
            if _e793 {
                let _e794 = up;
                param_297 = _e794;
                let _e795 = getIndex_u0028_vi3_u003b((&param_297));
                param_298 = _e795;
                let _e796 = readCell_u0028_u1_u003b((&param_298));
                phi_7791_ = (_e796 == 0u);
            }
            let _e799 = phi_7791_;
            if _e799 {
                let _e800 = heading_1;
                param_299 = _e800;
                let _e801 = steps_1;
                param_300 = _e801;
                let _e802 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_299), (&param_300));
                nav_3 = _e802;
                let _e803 = up;
                param_301 = _e803;
                let _e804 = getIndex_u0028_vi3_u003b((&param_301));
                let _e805 = up;
                param_302 = _e805;
                let _e806 = nav_3;
                param_303 = _e806;
                let _e807 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_302), (&param_303));
                let _e808 = newType;
                param_304 = _e808;
                param_305 = _e807;
                param_306 = 0u;
                let _e809 = count_2;
                param_307 = _e809;
                let _e810 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_304), (&param_305), (&param_306), (&param_307));
                let _e811 = (*currentIndex_4);
                param_308 = _e811;
                let _e812 = (*rawValue_3);
                param_309 = _e812;
                param_310 = _e804;
                param_311 = _e810;
                let _e813 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_308), (&param_309), (&param_310), (&param_311));
                if _e813 {
                    return;
                }
            }
        }
        let _e814 = (*randVal_4);
        heading_1 = (u32((fract((_e814 * 53f)) * 8f)) & 7u);
        let _e820 = locustRunSteps_u0028_();
        steps_1 = _e820;
    }
    let _e821 = (*currentIndex_4);
    let _e824 = (*rawValue_3);
    let _e825 = heading_1;
    param_312 = _e825;
    let _e826 = steps_1;
    param_313 = _e826;
    let _e827 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_312), (&param_313));
    let _e828 = newType;
    param_314 = _e828;
    param_315 = _e827;
    param_316 = 0u;
    let _e829 = count_2;
    param_317 = _e829;
    let _e830 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_314), (&param_315), (&param_316), (&param_317));
    let _e831 = atomicCompareExchangeWeak((&unnamed.grid[_e821]), _e824, _e830);
    return;
}

fn updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_8: ptr<function, vec3<i32>>, currentIndex_5: ptr<function, u32>, rawValue_4: ptr<function, u32>, currentAge_4: ptr<function, u32>, randVal_5: ptr<function, f32>) {
    var belowPos_3: vec3<i32>;
    var param_318: vec3<i32>;
    var param_319: u32;
    var param_320: u32;
    var param_321: vec3<i32>;
    var param_322: u32;
    var param_323: u32;
    var param_324: u32;
    var param_325: u32;
    var param_326: u32;
    var param_327: u32;
    var param_328: u32;
    var param_329: u32;
    var param_330: u32;
    var param_331: u32;
    var param_332: u32;
    var param_333: u32;
    var phi_6398_: bool;

    let _e237 = (*pos_8)[1u];
    if (_e237 > 1i) {
        let _e239 = (*pos_8);
        belowPos_3 = (_e239 + vec3<i32>(0i, -1i, 0i));
        let _e241 = belowPos_3;
        param_318 = _e241;
        let _e242 = getIndex_u0028_vi3_u003b((&param_318));
        param_319 = _e242;
        let _e243 = readCell_u0028_u1_u003b((&param_319));
        param_320 = _e243;
        let _e244 = getType_u0028_u1_u003b((&param_320));
        if (_e244 == 0u) {
            let _e246 = belowPos_3;
            param_321 = _e246;
            let _e247 = getIndex_u0028_vi3_u003b((&param_321));
            param_322 = 12u;
            param_323 = 0u;
            param_324 = 0u;
            let _e248 = (*currentAge_4);
            param_325 = _e248;
            let _e249 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_322), (&param_323), (&param_324), (&param_325));
            let _e250 = (*currentIndex_5);
            param_326 = _e250;
            let _e251 = (*rawValue_4);
            param_327 = _e251;
            param_328 = _e247;
            param_329 = _e249;
            let _e252 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_326), (&param_327), (&param_328), (&param_329));
            if _e252 {
                return;
            }
        }
    }
    let _e253 = (*currentAge_4);
    let _e254 = (_e253 > 0u);
    phi_6398_ = _e254;
    if _e254 {
        let _e255 = (*randVal_5);
        let _e259 = tuning.darkStoneDryChance;
        phi_6398_ = (fract((_e255 * 23f)) < _e259);
    }
    let _e262 = phi_6398_;
    if _e262 {
        let _e263 = (*currentIndex_5);
        let _e266 = (*rawValue_4);
        let _e267 = (*currentAge_4);
        param_330 = 12u;
        param_331 = 0u;
        param_332 = 0u;
        param_333 = (_e267 - 1u);
        let _e269 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_330), (&param_331), (&param_332), (&param_333));
        let _e270 = atomicCompareExchangeWeak((&unnamed.grid[_e263]), _e266, _e269);
    }
    return;
}

fn lavaTypeFor_u0028_u1_u003b(coolness: ptr<function, u32>) -> u32 {
    let _e215 = (*coolness);
    let _e217 = tuning.lavaStageSize;
    return (8u + min((_e215 / max(_e217, 1u)), 3u));
}

fn lavaSolidifyCoolness_u0028_() -> u32 {
    let _e215 = tuning.lavaStageSize;
    return min((max(_e215, 1u) * 4u), 255u);
}

fn decWater_u0028_() {
    let _e215 = atomicAdd((&unnamed_2.waterVoxelCount), 4294967295u);
    return;
}

fn getOrthoDir_u0028_i1_u003b(d_5: ptr<function, i32>) -> vec3<i32> {
    let _e215 = (*d_5);
    if (_e215 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e217 = (*d_5);
    if (_e217 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e219 = (*d_5);
    if (_e219 == 2i) {
        return vec3<i32>(0i, 1i, 0i);
    }
    let _e221 = (*d_5);
    if (_e221 == 3i) {
        return vec3<i32>(0i, -1i, 0i);
    }
    let _e223 = (*d_5);
    if (_e223 == 4i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    return vec3<i32>(0i, 0i, -1i);
}

fn lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b(pos_9: ptr<function, vec3<i32>>, coolness_1: ptr<function, u32>, randVal_6: ptr<function, f32>) {
    var startDir: i32;
    var i_9: i32;
    var d_6: i32;
    var nPos_1: vec3<i32>;
    var param_334: i32;
    var nIndex: u32;
    var param_335: vec3<i32>;
    var nVal: u32;
    var param_336: u32;
    var nType_1: u32;
    var param_337: u32;
    var param_338: u32;
    var param_339: u32;
    var param_340: u32;
    var param_341: u32;
    var param_342: u32;
    var param_343: u32;
    var param_344: u32;
    var param_345: u32;
    var param_346: u32;
    var param_347: u32;
    var param_348: u32;
    var param_349: u32;
    var moisture_1: u32;
    var param_350: u32;
    var flora_3: u32;
    var param_351: u32;
    var abovePos: vec3<i32>;
    var param_352: vec3<i32>;
    var param_353: u32;
    var param_354: u32;
    var param_355: vec3<i32>;
    var param_356: u32;
    var param_357: u32;
    var param_358: u32;
    var param_359: u32;
    var param_360: u32;
    var param_361: u32;
    var param_362: u32;
    var param_363: u32;
    var param_364: u32;
    var nCool: u32;
    var param_365: u32;
    var raised: u32;
    var raisedType: u32;
    var local_10: u32;
    var param_366: u32;
    var param_367: u32;
    var param_368: u32;
    var param_369: u32;
    var param_370: u32;
    var param_371: u32;
    var nCool_1: u32;
    var param_372: u32;
    var draws: bool;
    var lowered: u32;
    var local_11: u32;
    var melts: bool;
    var newType_1: u32;
    var local_12: u32;
    var param_373: u32;
    var param_374: u32;
    var param_375: u32;
    var param_376: u32;
    var param_377: u32;
    var phi_5452_: bool;
    var phi_5459_: bool;
    var phi_5470_: bool;
    var phi_5477_: bool;
    var phi_5488_: bool;
    var phi_5627_: bool;
    var phi_5638_: bool;

    let _e282 = (*randVal_6);
    startDir = i32((fract((_e282 * 17f)) * 6f));
    i_9 = 0i;
    loop {
        let _e287 = i_9;
        if (_e287 < 6i) {
            let _e289 = startDir;
            let _e290 = i_9;
            let _e291 = (_e289 + _e290);
            d_6 = (_e291 - (i32(floor((f32(_e291) / f32(6i)))) * 6i));
            let _e299 = (*pos_9);
            let _e300 = d_6;
            param_334 = _e300;
            let _e301 = getOrthoDir_u0028_i1_u003b((&param_334));
            nPos_1 = (_e299 + _e301);
            let _e304 = nPos_1[0u];
            let _e305 = (_e304 <= 0i);
            phi_5452_ = _e305;
            if !(_e305) {
                let _e308 = nPos_1[0u];
                let _e310 = tuning.gridWidth;
                phi_5452_ = (_e308 >= (bitcast<i32>(_e310) - 1i));
            }
            let _e315 = phi_5452_;
            phi_5459_ = _e315;
            if !(_e315) {
                let _e318 = nPos_1[1u];
                phi_5459_ = (_e318 <= 0i);
            }
            let _e321 = phi_5459_;
            phi_5470_ = _e321;
            if !(_e321) {
                let _e324 = nPos_1[1u];
                let _e326 = tuning.gridHeight;
                phi_5470_ = (_e324 >= (bitcast<i32>(_e326) - 1i));
            }
            let _e331 = phi_5470_;
            phi_5477_ = _e331;
            if !(_e331) {
                let _e334 = nPos_1[2u];
                phi_5477_ = (_e334 <= 0i);
            }
            let _e337 = phi_5477_;
            phi_5488_ = _e337;
            if !(_e337) {
                let _e340 = nPos_1[2u];
                let _e342 = tuning.gridDepth;
                phi_5488_ = (_e340 >= (bitcast<i32>(_e342) - 1i));
            }
            let _e347 = phi_5488_;
            if _e347 {
                continue;
            }
            let _e348 = nPos_1;
            param_335 = _e348;
            let _e349 = getIndex_u0028_vi3_u003b((&param_335));
            nIndex = _e349;
            let _e350 = nIndex;
            param_336 = _e350;
            let _e351 = readCell_u0028_u1_u003b((&param_336));
            nVal = _e351;
            let _e352 = nVal;
            param_337 = _e352;
            let _e353 = getType_u0028_u1_u003b((&param_337));
            nType_1 = _e353;
            let _e354 = nType_1;
            if (_e354 == 2u) {
                let _e356 = nIndex;
                let _e359 = nVal;
                param_338 = 6u;
                param_339 = 0u;
                param_340 = 0u;
                param_341 = 0u;
                let _e360 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_338), (&param_339), (&param_340), (&param_341));
                let _e361 = atomicCompareExchangeWeak((&unnamed.grid[_e356]), _e359, _e360);
                let _e363 = nVal;
                if (_e361.old_value == _e363) {
                    decWater_u0028_();
                    let _e365 = (*coolness_1);
                    let _e367 = tuning.lavaWaterCool;
                    (*coolness_1) = min((_e365 + _e367), 255u);
                    return;
                }
            } else {
                let _e370 = nType_1;
                if (_e370 == 19u) {
                    let _e372 = nIndex;
                    let _e375 = nVal;
                    let _e376 = atomicCompareExchangeWeak((&unnamed.grid[_e372]), _e375, 0u);
                    let _e378 = nVal;
                    if (_e376.old_value == _e378) {
                        return;
                    }
                } else {
                    let _e380 = nType_1;
                    if (_e380 == 18u) {
                        let _e382 = nIndex;
                        let _e385 = nVal;
                        param_342 = 5u;
                        param_343 = 0u;
                        param_344 = 0u;
                        param_345 = 0u;
                        let _e386 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_342), (&param_343), (&param_344), (&param_345));
                        let _e387 = atomicCompareExchangeWeak((&unnamed.grid[_e382]), _e385, _e386);
                        let _e389 = nVal;
                        if (_e387.old_value == _e389) {
                            return;
                        }
                    } else {
                        let _e391 = nType_1;
                        if (_e391 == 3u) {
                            let _e393 = nIndex;
                            let _e396 = nVal;
                            param_346 = 12u;
                            param_347 = 0u;
                            param_348 = 0u;
                            param_349 = 255u;
                            let _e397 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_346), (&param_347), (&param_348), (&param_349));
                            let _e398 = atomicCompareExchangeWeak((&unnamed.grid[_e393]), _e396, _e397);
                            let _e400 = nVal;
                            if (_e398.old_value == _e400) {
                                return;
                            }
                        } else {
                            let _e402 = nType_1;
                            let _e404 = nType_1;
                            if ((_e402 == 1u) || (_e404 == 4u)) {
                                let _e407 = nVal;
                                param_350 = _e407;
                                let _e408 = getAge_u0028_u1_u003b((&param_350));
                                moisture_1 = _e408;
                                let _e409 = nVal;
                                param_351 = _e409;
                                let _e410 = getDir_u0028_u1_u003b((&param_351));
                                flora_3 = _e410;
                                let _e411 = nType_1;
                                let _e413 = flora_3;
                                let _e416 = flora_3;
                                if (((_e411 == 4u) && (_e413 > 10u)) && (_e416 <= 100u)) {
                                    let _e419 = nPos_1;
                                    abovePos = (_e419 + vec3<i32>(0i, 1i, 0i));
                                    let _e422 = abovePos[1u];
                                    let _e424 = tuning.gridHeight;
                                    let _e427 = (_e422 < (bitcast<i32>(_e424) - 1i));
                                    phi_5627_ = _e427;
                                    if _e427 {
                                        let _e428 = abovePos;
                                        param_352 = _e428;
                                        let _e429 = getIndex_u0028_vi3_u003b((&param_352));
                                        param_353 = _e429;
                                        let _e430 = readCell_u0028_u1_u003b((&param_353));
                                        param_354 = _e430;
                                        let _e431 = getType_u0028_u1_u003b((&param_354));
                                        phi_5627_ = (_e431 == 0u);
                                    }
                                    let _e434 = phi_5627_;
                                    phi_5638_ = _e434;
                                    if _e434 {
                                        let _e435 = (*randVal_6);
                                        let _e439 = tuning.lavaIgniteChance;
                                        phi_5638_ = (fract((_e435 * 41f)) < _e439);
                                    }
                                    let _e442 = phi_5638_;
                                    if _e442 {
                                        let _e443 = abovePos;
                                        param_355 = _e443;
                                        let _e444 = getIndex_u0028_vi3_u003b((&param_355));
                                        param_356 = 5u;
                                        param_357 = 0u;
                                        param_358 = 0u;
                                        param_359 = 0u;
                                        let _e447 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_356), (&param_357), (&param_358), (&param_359));
                                        let _e448 = atomicCompareExchangeWeak((&unnamed.grid[_e444]), 0u, _e447);
                                        if (_e448.old_value == 0u) {
                                            return;
                                        }
                                    }
                                } else {
                                    let _e451 = moisture_1;
                                    if (_e451 > 0u) {
                                        let _e453 = nIndex;
                                        let _e456 = nVal;
                                        let _e457 = moisture_1;
                                        let _e459 = nType_1;
                                        param_360 = _e459;
                                        let _e460 = flora_3;
                                        param_361 = _e460;
                                        param_362 = 0u;
                                        param_363 = (_e457 - 1u);
                                        let _e461 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_360), (&param_361), (&param_362), (&param_363));
                                        let _e462 = atomicCompareExchangeWeak((&unnamed.grid[_e453]), _e456, _e461);
                                        let _e464 = nVal;
                                        if (_e462.old_value == _e464) {
                                            let _e466 = (*coolness_1);
                                            let _e468 = tuning.lavaMoistureCool;
                                            (*coolness_1) = min((_e466 + _e468), 255u);
                                            return;
                                        }
                                    } else {
                                        let _e471 = (*randVal_6);
                                        let _e475 = tuning.lavaConsumeChance;
                                        if (fract((_e471 * 53f)) < _e475) {
                                            let _e477 = nIndex;
                                            let _e480 = nVal;
                                            let _e481 = atomicCompareExchangeWeak((&unnamed.grid[_e477]), _e480, 0u);
                                            let _e483 = nVal;
                                            if (_e481.old_value == _e483) {
                                                return;
                                            }
                                        }
                                    }
                                }
                            } else {
                                let _e485 = nType_1;
                                param_364 = _e485;
                                let _e486 = isLava_u0028_u1_u003b((&param_364));
                                if _e486 {
                                    let _e487 = nVal;
                                    param_365 = _e487;
                                    let _e488 = getAge_u0028_u1_u003b((&param_365));
                                    nCool = _e488;
                                    let _e489 = (*coolness_1);
                                    let _e490 = nCool;
                                    if (_e489 > (_e490 + 1u)) {
                                        let _e493 = nCool;
                                        raised = (_e493 + 1u);
                                        let _e495 = raised;
                                        let _e496 = lavaSolidifyCoolness_u0028_();
                                        if (_e495 >= _e496) {
                                            local_10 = 12u;
                                        } else {
                                            let _e498 = raised;
                                            param_366 = _e498;
                                            let _e499 = lavaTypeFor_u0028_u1_u003b((&param_366));
                                            local_10 = _e499;
                                        }
                                        let _e500 = local_10;
                                        raisedType = _e500;
                                        let _e501 = nIndex;
                                        let _e504 = nVal;
                                        let _e505 = nVal;
                                        param_367 = _e505;
                                        let _e506 = getDir_u0028_u1_u003b((&param_367));
                                        let _e507 = raisedType;
                                        param_368 = _e507;
                                        param_369 = _e506;
                                        param_370 = 0u;
                                        let _e508 = raised;
                                        param_371 = _e508;
                                        let _e509 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_368), (&param_369), (&param_370), (&param_371));
                                        let _e510 = atomicCompareExchangeWeak((&unnamed.grid[_e501]), _e504, _e509);
                                        let _e512 = nVal;
                                        if (_e510.old_value == _e512) {
                                            let _e514 = (*coolness_1);
                                            (*coolness_1) = (_e514 - 1u);
                                            return;
                                        }
                                    }
                                } else {
                                    let _e516 = nType_1;
                                    if (_e516 == 12u) {
                                        let _e518 = nVal;
                                        param_372 = _e518;
                                        let _e519 = getAge_u0028_u1_u003b((&param_372));
                                        nCool_1 = _e519;
                                        let _e520 = nCool_1;
                                        let _e521 = (*coolness_1);
                                        draws = (_e520 > (_e521 + 1u));
                                        let _e524 = draws;
                                        if _e524 {
                                            let _e525 = nCool_1;
                                            local_11 = (_e525 - 1u);
                                        } else {
                                            let _e527 = nCool_1;
                                            local_11 = _e527;
                                        }
                                        let _e528 = local_11;
                                        lowered = _e528;
                                        let _e529 = lowered;
                                        let _e530 = lavaSolidifyCoolness_u0028_();
                                        melts = (_e529 < _e530);
                                        let _e532 = draws;
                                        let _e533 = melts;
                                        if (_e532 || _e533) {
                                            let _e535 = melts;
                                            if _e535 {
                                                let _e536 = lowered;
                                                param_373 = _e536;
                                                let _e537 = lavaTypeFor_u0028_u1_u003b((&param_373));
                                                local_12 = _e537;
                                            } else {
                                                local_12 = 12u;
                                            }
                                            let _e538 = local_12;
                                            newType_1 = _e538;
                                            let _e539 = nIndex;
                                            let _e542 = nVal;
                                            let _e543 = newType_1;
                                            param_374 = _e543;
                                            param_375 = 0u;
                                            param_376 = 0u;
                                            let _e544 = lowered;
                                            param_377 = _e544;
                                            let _e545 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_374), (&param_375), (&param_376), (&param_377));
                                            let _e546 = atomicCompareExchangeWeak((&unnamed.grid[_e539]), _e542, _e545);
                                            let _e548 = nVal;
                                            if (_e546.old_value == _e548) {
                                                let _e550 = draws;
                                                if _e550 {
                                                    let _e551 = (*coolness_1);
                                                    (*coolness_1) = min((_e551 + 1u), 255u);
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
            let _e554 = i_9;
            i_9 = (_e554 + 1i);
        }
    }
    return;
}

fn updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_10: ptr<function, vec3<i32>>, currentIndex_6: ptr<function, u32>, rawValue_5: ptr<function, u32>, currentDir_2: ptr<function, u32>, currentSleep_2: ptr<function, u32>, currentAge_5: ptr<function, u32>, randVal_7: ptr<function, f32>) {
    var coolness_2: u32;
    var param_378: vec3<i32>;
    var param_379: u32;
    var param_380: f32;
    var param_381: u32;
    var param_382: u32;
    var param_383: u32;
    var param_384: u32;
    var newType_2: u32;
    var param_385: u32;
    var belowPos_4: vec3<i32>;
    var param_386: vec3<i32>;
    var param_387: u32;
    var param_388: u32;
    var param_389: vec3<i32>;
    var param_390: u32;
    var param_391: u32;
    var param_392: u32;
    var param_393: u32;
    var param_394: u32;
    var param_395: u32;
    var param_396: u32;
    var param_397: u32;
    var slideDir: i32;
    var slide_1: array<vec3<i32>, 2>;
    var s_1: i32;
    var sPos: vec3<i32>;
    var param_398: vec3<i32>;
    var param_399: u32;
    var param_400: u32;
    var param_401: vec3<i32>;
    var param_402: u32;
    var param_403: u32;
    var param_404: u32;
    var param_405: u32;
    var param_406: u32;
    var param_407: u32;
    var param_408: u32;
    var param_409: u32;
    var blockedMask: u32;
    var searchStart: i32;
    var reach: i32;
    var r: i32;
    var i_10: i32;
    var d_7: i32;
    var c_6: vec3<i32>;
    var param_410: i32;
    var param_411: vec3<i32>;
    var param_412: u32;
    var param_413: u32;
    var param_414: vec3<i32>;
    var param_415: u32;
    var param_416: u32;
    var param_417: vec3<i32>;
    var param_418: u32;
    var param_419: u32;
    var param_420: u32;
    var param_421: u32;
    var param_422: u32;
    var param_423: u32;
    var param_424: u32;
    var param_425: u32;
    var hasPressure: bool;
    var local_13: bool;
    var param_426: vec3<i32>;
    var param_427: u32;
    var param_428: u32;
    var stackedOnLava: bool;
    var local_14: bool;
    var param_429: vec3<i32>;
    var param_430: u32;
    var param_431: u32;
    var param_432: u32;
    var spreadStart: i32;
    var i_11: i32;
    var d_8: i32;
    var targetPos: vec3<i32>;
    var param_433: i32;
    var param_434: vec3<i32>;
    var param_435: u32;
    var param_436: u32;
    var param_437: vec3<i32>;
    var param_438: u32;
    var param_439: u32;
    var param_440: u32;
    var param_441: u32;
    var param_442: u32;
    var param_443: u32;
    var param_444: u32;
    var param_445: u32;
    var newSleep: u32;
    var param_446: u32;
    var param_447: u32;
    var param_448: u32;
    var param_449: u32;
    var phi_5846_: bool;
    var phi_5984_: bool;
    var phi_5990_: bool;
    var phi_6000_: bool;
    var phi_6112_: bool;
    var phi_6119_: bool;
    var phi_6130_: bool;
    var phi_6142_: bool;
    var phi_6164_: bool;
    var phi_6278_: bool;
    var phi_6284_: bool;
    var phi_6294_: bool;

    let _e316 = (*currentAge_5);
    coolness_2 = _e316;
    let _e317 = (*pos_10);
    param_378 = _e317;
    let _e318 = coolness_2;
    param_379 = _e318;
    let _e319 = (*randVal_7);
    param_380 = _e319;
    lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b((&param_378), (&param_379), (&param_380));
    let _e320 = param_379;
    coolness_2 = _e320;
    let _e321 = (*currentSleep_2);
    let _e323 = tuning.wakeSleepThreshold;
    let _e324 = (_e321 > _e323);
    phi_5846_ = _e324;
    if _e324 {
        let _e325 = (*randVal_7);
        let _e329 = tuning.lavaRestCoolChance;
        phi_5846_ = (fract((_e325 * 71f)) < _e329);
    }
    let _e332 = phi_5846_;
    if _e332 {
        let _e333 = coolness_2;
        coolness_2 = min((_e333 + 1u), 255u);
    }
    let _e336 = coolness_2;
    let _e337 = lavaSolidifyCoolness_u0028_();
    if (_e336 >= _e337) {
        let _e339 = (*currentIndex_6);
        let _e342 = (*rawValue_5);
        param_381 = 12u;
        param_382 = 0u;
        param_383 = 0u;
        let _e343 = coolness_2;
        param_384 = _e343;
        let _e344 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_381), (&param_382), (&param_383), (&param_384));
        let _e345 = atomicCompareExchangeWeak((&unnamed.grid[_e339]), _e342, _e344);
        return;
    }
    let _e347 = coolness_2;
    param_385 = _e347;
    let _e348 = lavaTypeFor_u0028_u1_u003b((&param_385));
    newType_2 = _e348;
    let _e349 = (*randVal_7);
    let _e353 = tuning.lavaViscosity;
    if (fract((_e349 * 89f)) < _e353) {
        let _e356 = (*pos_10)[1u];
        if (_e356 > 1i) {
            let _e358 = (*pos_10);
            belowPos_4 = (_e358 + vec3<i32>(0i, -1i, 0i));
            let _e360 = belowPos_4;
            param_386 = _e360;
            let _e361 = getIndex_u0028_vi3_u003b((&param_386));
            param_387 = _e361;
            let _e362 = readCell_u0028_u1_u003b((&param_387));
            param_388 = _e362;
            let _e363 = getType_u0028_u1_u003b((&param_388));
            if (_e363 == 0u) {
                let _e365 = belowPos_4;
                param_389 = _e365;
                let _e366 = getIndex_u0028_vi3_u003b((&param_389));
                let _e367 = newType_2;
                param_390 = _e367;
                let _e368 = (*currentDir_2);
                param_391 = _e368;
                param_392 = 0u;
                let _e369 = coolness_2;
                param_393 = _e369;
                let _e370 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_390), (&param_391), (&param_392), (&param_393));
                let _e371 = (*currentIndex_6);
                param_394 = _e371;
                let _e372 = (*rawValue_5);
                param_395 = _e372;
                param_396 = _e366;
                param_397 = _e370;
                let _e373 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_394), (&param_395), (&param_396), (&param_397));
                if _e373 {
                    return;
                }
            }
        }
        let _e375 = (*pos_10)[1u];
        if (_e375 > 1i) {
            let _e377 = (*randVal_7);
            slideDir = select(-1i, 1i, (fract((_e377 * 10f)) > 0.5f));
            let _e382 = (*randVal_7);
            if (fract((_e382 * 100f)) > 0.5f) {
                let _e386 = (*pos_10);
                let _e387 = slideDir;
                slide_1[0i] = (_e386 + vec3<i32>(_e387, -1i, 0i));
                let _e391 = (*pos_10);
                let _e392 = slideDir;
                slide_1[1i] = (_e391 + vec3<i32>(0i, -1i, _e392));
            } else {
                let _e396 = (*pos_10);
                let _e397 = slideDir;
                slide_1[0i] = (_e396 + vec3<i32>(0i, -1i, _e397));
                let _e401 = (*pos_10);
                let _e402 = slideDir;
                slide_1[1i] = (_e401 + vec3<i32>(_e402, -1i, 0i));
            }
            s_1 = 0i;
            loop {
                let _e406 = s_1;
                if (_e406 < 2i) {
                    let _e408 = s_1;
                    let _e410 = slide_1[_e408];
                    sPos = _e410;
                    let _e412 = sPos[0u];
                    let _e413 = (_e412 > 0i);
                    phi_5984_ = _e413;
                    if _e413 {
                        let _e415 = sPos[0u];
                        let _e417 = tuning.gridWidth;
                        phi_5984_ = (_e415 < (bitcast<i32>(_e417) - 1i));
                    }
                    let _e422 = phi_5984_;
                    phi_5990_ = _e422;
                    if _e422 {
                        let _e424 = sPos[2u];
                        phi_5990_ = (_e424 > 0i);
                    }
                    let _e427 = phi_5990_;
                    phi_6000_ = _e427;
                    if _e427 {
                        let _e429 = sPos[2u];
                        let _e431 = tuning.gridDepth;
                        phi_6000_ = (_e429 < (bitcast<i32>(_e431) - 1i));
                    }
                    let _e436 = phi_6000_;
                    if _e436 {
                        let _e437 = sPos;
                        param_398 = _e437;
                        let _e438 = getIndex_u0028_vi3_u003b((&param_398));
                        param_399 = _e438;
                        let _e439 = readCell_u0028_u1_u003b((&param_399));
                        param_400 = _e439;
                        let _e440 = getType_u0028_u1_u003b((&param_400));
                        if (_e440 == 0u) {
                            let _e442 = sPos;
                            param_401 = _e442;
                            let _e443 = getIndex_u0028_vi3_u003b((&param_401));
                            let _e444 = newType_2;
                            param_402 = _e444;
                            let _e445 = (*currentDir_2);
                            param_403 = _e445;
                            param_404 = 0u;
                            let _e446 = coolness_2;
                            param_405 = _e446;
                            let _e447 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_402), (&param_403), (&param_404), (&param_405));
                            let _e448 = (*currentIndex_6);
                            param_406 = _e448;
                            let _e449 = (*rawValue_5);
                            param_407 = _e449;
                            param_408 = _e443;
                            param_409 = _e447;
                            let _e450 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_406), (&param_407), (&param_408), (&param_409));
                            if _e450 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e451 = s_1;
                    s_1 = (_e451 + 1i);
                }
            }
        }
        let _e453 = (*currentSleep_2);
        let _e455 = tuning.wakeSleepThreshold;
        if (_e453 <= _e455) {
            blockedMask = 0u;
            let _e457 = (*randVal_7);
            searchStart = i32((fract((_e457 * 8f)) * 8f));
            let _e463 = tuning.lavaSpreadRadius;
            reach = bitcast<i32>(max(_e463, 1u));
            r = 1i;
            loop {
                let _e466 = r;
                let _e467 = reach;
                if (_e466 <= _e467) {
                    let _e469 = blockedMask;
                    if (_e469 == 255u) {
                        break;
                    }
                    i_10 = 0i;
                    loop {
                        let _e471 = i_10;
                        if (_e471 < 8i) {
                            let _e473 = searchStart;
                            let _e474 = i_10;
                            let _e475 = (_e473 + _e474);
                            d_7 = (_e475 - (i32(floor((f32(_e475) / f32(8i)))) * 8i));
                            let _e483 = blockedMask;
                            let _e484 = d_7;
                            if ((_e483 & (1u << bitcast<u32>(_e484))) != 0u) {
                                continue;
                            }
                            let _e489 = (*pos_10);
                            let _e490 = d_7;
                            param_410 = _e490;
                            let _e491 = getHDir_u0028_i1_u003b((&param_410));
                            let _e492 = r;
                            c_6 = (_e489 + (_e491 * vec3(_e492)));
                            let _e497 = c_6[0u];
                            let _e498 = (_e497 <= 0i);
                            phi_6112_ = _e498;
                            if !(_e498) {
                                let _e501 = c_6[0u];
                                let _e503 = tuning.gridWidth;
                                phi_6112_ = (_e501 >= (bitcast<i32>(_e503) - 1i));
                            }
                            let _e508 = phi_6112_;
                            phi_6119_ = _e508;
                            if !(_e508) {
                                let _e511 = c_6[2u];
                                phi_6119_ = (_e511 <= 0i);
                            }
                            let _e514 = phi_6119_;
                            phi_6130_ = _e514;
                            if !(_e514) {
                                let _e517 = c_6[2u];
                                let _e519 = tuning.gridDepth;
                                phi_6130_ = (_e517 >= (bitcast<i32>(_e519) - 1i));
                            }
                            let _e524 = phi_6130_;
                            phi_6142_ = _e524;
                            if !(_e524) {
                                let _e526 = c_6;
                                param_411 = _e526;
                                let _e527 = getIndex_u0028_vi3_u003b((&param_411));
                                param_412 = _e527;
                                let _e528 = readCell_u0028_u1_u003b((&param_412));
                                param_413 = _e528;
                                let _e529 = getType_u0028_u1_u003b((&param_413));
                                phi_6142_ = (_e529 != 0u);
                            }
                            let _e532 = phi_6142_;
                            if _e532 {
                                let _e533 = d_7;
                                let _e536 = blockedMask;
                                blockedMask = (_e536 | (1u << bitcast<u32>(_e533)));
                            } else {
                                let _e539 = c_6[1u];
                                let _e540 = (_e539 > 1i);
                                phi_6164_ = _e540;
                                if _e540 {
                                    let _e541 = c_6;
                                    param_414 = (_e541 + vec3<i32>(0i, -1i, 0i));
                                    let _e543 = getIndex_u0028_vi3_u003b((&param_414));
                                    param_415 = _e543;
                                    let _e544 = readCell_u0028_u1_u003b((&param_415));
                                    param_416 = _e544;
                                    let _e545 = getType_u0028_u1_u003b((&param_416));
                                    phi_6164_ = (_e545 == 0u);
                                }
                                let _e548 = phi_6164_;
                                if _e548 {
                                    let _e549 = c_6;
                                    param_417 = _e549;
                                    let _e550 = getIndex_u0028_vi3_u003b((&param_417));
                                    let _e551 = newType_2;
                                    param_418 = _e551;
                                    param_419 = 0u;
                                    param_420 = 0u;
                                    let _e552 = coolness_2;
                                    param_421 = _e552;
                                    let _e553 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_418), (&param_419), (&param_420), (&param_421));
                                    let _e554 = (*currentIndex_6);
                                    param_422 = _e554;
                                    let _e555 = (*rawValue_5);
                                    param_423 = _e555;
                                    param_424 = _e550;
                                    param_425 = _e553;
                                    let _e556 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_422), (&param_423), (&param_424), (&param_425));
                                    if _e556 {
                                        return;
                                    }
                                    let _e557 = d_7;
                                    let _e560 = blockedMask;
                                    blockedMask = (_e560 | (1u << bitcast<u32>(_e557)));
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e562 = i_10;
                            i_10 = (_e562 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e564 = r;
                    r = (_e564 + 1i);
                }
            }
            let _e567 = (*pos_10)[1u];
            let _e569 = tuning.gridHeight;
            if (_e567 < (bitcast<i32>(_e569) - 2i)) {
                let _e573 = (*pos_10);
                param_426 = (_e573 + vec3<i32>(0i, 1i, 0i));
                let _e575 = getIndex_u0028_vi3_u003b((&param_426));
                param_427 = _e575;
                let _e576 = readCell_u0028_u1_u003b((&param_427));
                param_428 = _e576;
                let _e577 = getType_u0028_u1_u003b((&param_428));
                local_13 = (_e577 != 0u);
            } else {
                local_13 = false;
            }
            let _e579 = local_13;
            hasPressure = _e579;
            let _e581 = (*pos_10)[1u];
            if (_e581 > 1i) {
                let _e583 = (*pos_10);
                param_429 = (_e583 + vec3<i32>(0i, -1i, 0i));
                let _e585 = getIndex_u0028_vi3_u003b((&param_429));
                param_430 = _e585;
                let _e586 = readCell_u0028_u1_u003b((&param_430));
                param_431 = _e586;
                let _e587 = getType_u0028_u1_u003b((&param_431));
                param_432 = _e587;
                let _e588 = isLava_u0028_u1_u003b((&param_432));
                local_14 = _e588;
            } else {
                local_14 = false;
            }
            let _e589 = local_14;
            stackedOnLava = _e589;
            let _e590 = hasPressure;
            let _e591 = stackedOnLava;
            if (_e590 || _e591) {
                let _e593 = (*randVal_7);
                spreadStart = i32((fract((_e593 * 8f)) * 8f));
                i_11 = 0i;
                loop {
                    let _e598 = i_11;
                    if (_e598 < 8i) {
                        let _e600 = spreadStart;
                        let _e601 = i_11;
                        let _e602 = (_e600 + _e601);
                        d_8 = (_e602 - (i32(floor((f32(_e602) / f32(8i)))) * 8i));
                        let _e610 = (*pos_10);
                        let _e611 = d_8;
                        param_433 = _e611;
                        let _e612 = getHDir_u0028_i1_u003b((&param_433));
                        targetPos = (_e610 + _e612);
                        let _e615 = targetPos[0u];
                        let _e616 = (_e615 > 0i);
                        phi_6278_ = _e616;
                        if _e616 {
                            let _e618 = targetPos[0u];
                            let _e620 = tuning.gridWidth;
                            phi_6278_ = (_e618 < (bitcast<i32>(_e620) - 1i));
                        }
                        let _e625 = phi_6278_;
                        phi_6284_ = _e625;
                        if _e625 {
                            let _e627 = targetPos[2u];
                            phi_6284_ = (_e627 > 0i);
                        }
                        let _e630 = phi_6284_;
                        phi_6294_ = _e630;
                        if _e630 {
                            let _e632 = targetPos[2u];
                            let _e634 = tuning.gridDepth;
                            phi_6294_ = (_e632 < (bitcast<i32>(_e634) - 1i));
                        }
                        let _e639 = phi_6294_;
                        if _e639 {
                            let _e640 = targetPos;
                            param_434 = _e640;
                            let _e641 = getIndex_u0028_vi3_u003b((&param_434));
                            param_435 = _e641;
                            let _e642 = readCell_u0028_u1_u003b((&param_435));
                            param_436 = _e642;
                            let _e643 = getType_u0028_u1_u003b((&param_436));
                            if (_e643 == 0u) {
                                let _e645 = targetPos;
                                param_437 = _e645;
                                let _e646 = getIndex_u0028_vi3_u003b((&param_437));
                                let _e647 = d_8;
                                let _e650 = newType_2;
                                param_438 = _e650;
                                param_439 = bitcast<u32>((_e647 + 1i));
                                param_440 = 0u;
                                let _e651 = coolness_2;
                                param_441 = _e651;
                                let _e652 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_438), (&param_439), (&param_440), (&param_441));
                                let _e653 = (*currentIndex_6);
                                param_442 = _e653;
                                let _e654 = (*rawValue_5);
                                param_443 = _e654;
                                param_444 = _e646;
                                param_445 = _e652;
                                let _e655 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_442), (&param_443), (&param_444), (&param_445));
                                if _e655 {
                                    return;
                                }
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e656 = i_11;
                        i_11 = (_e656 + 1i);
                    }
                }
            }
        }
    }
    let _e658 = (*currentSleep_2);
    newSleep = min((_e658 + 1u), 255u);
    let _e661 = (*currentIndex_6);
    let _e664 = (*rawValue_5);
    let _e665 = newType_2;
    param_446 = _e665;
    let _e666 = (*currentDir_2);
    param_447 = _e666;
    let _e667 = newSleep;
    param_448 = _e667;
    let _e668 = coolness_2;
    param_449 = _e668;
    let _e669 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_446), (&param_447), (&param_448), (&param_449));
    let _e670 = atomicCompareExchangeWeak((&unnamed.grid[_e661]), _e664, _e669);
    return;
}

fn getCloudMoved_u0028_u1_u003b(v_2: ptr<function, u32>) -> bool {
    let _e215 = (*v_2);
    return ((_e215 & 4u) != 0u);
}

fn getCloudKind_u0028_u1_u003b(v_3: ptr<function, u32>) -> u32 {
    let _e215 = (*v_3);
    return (_e215 & 3u);
}

fn cloudIsAtRest_u0028_u1_u003b(v_4: ptr<function, u32>) -> bool {
    var param_450: u32;
    var param_451: u32;
    var phi_737_: bool;

    let _e217 = (*v_4);
    param_450 = _e217;
    let _e218 = getCloudKind_u0028_u1_u003b((&param_450));
    let _e219 = (_e218 != 0u);
    phi_737_ = _e219;
    if _e219 {
        let _e220 = (*v_4);
        param_451 = _e220;
        let _e221 = getCloudMoved_u0028_u1_u003b((&param_451));
        phi_737_ = !(_e221);
    }
    let _e224 = phi_737_;
    return _e224;
}

fn cloudCellInBounds_u0028_vi3_u003b(p_4: ptr<function, vec3<i32>>) -> bool {
    var phi_596_: bool;
    var phi_602_: bool;
    var phi_612_: bool;
    var phi_618_: bool;
    var phi_628_: bool;

    let _e216 = (*p_4)[0u];
    let _e217 = (_e216 >= 1i);
    phi_596_ = _e217;
    if _e217 {
        let _e219 = (*p_4)[0u];
        let _e221 = tuning.gridWidth;
        phi_596_ = (_e219 < (bitcast<i32>(_e221) - 1i));
    }
    let _e226 = phi_596_;
    phi_602_ = _e226;
    if _e226 {
        let _e228 = (*p_4)[1u];
        phi_602_ = (_e228 >= 1i);
    }
    let _e231 = phi_602_;
    phi_612_ = _e231;
    if _e231 {
        let _e233 = (*p_4)[1u];
        let _e235 = tuning.gridHeight;
        phi_612_ = (_e233 < (bitcast<i32>(_e235) - 1i));
    }
    let _e240 = phi_612_;
    phi_618_ = _e240;
    if _e240 {
        let _e242 = (*p_4)[2u];
        phi_618_ = (_e242 >= 1i);
    }
    let _e245 = phi_618_;
    phi_628_ = _e245;
    if _e245 {
        let _e247 = (*p_4)[2u];
        let _e249 = tuning.gridDepth;
        phi_628_ = (_e247 < (bitcast<i32>(_e249) - 1i));
    }
    let _e254 = phi_628_;
    return _e254;
}

fn cloudTouchesRain_u0028_vi3_u003b(pos_11: ptr<function, vec3<i32>>) -> bool {
    var i_12: i32;
    var n_1: vec3<i32>;
    var param_452: i32;
    var param_453: vec3<i32>;
    var param_454: vec3<i32>;
    var param_455: u32;

    i_12 = 0i;
    loop {
        let _e221 = i_12;
        if (_e221 < 6i) {
            let _e223 = (*pos_11);
            let _e224 = i_12;
            param_452 = _e224;
            let _e225 = getOrthoDir_u0028_i1_u003b((&param_452));
            n_1 = (_e223 + _e225);
            let _e227 = n_1;
            param_453 = _e227;
            let _e228 = cloudCellInBounds_u0028_vi3_u003b((&param_453));
            if !(_e228) {
                continue;
            }
            let _e230 = n_1;
            param_454 = _e230;
            let _e231 = getIndex_u0028_vi3_u003b((&param_454));
            let _e234 = atomicLoad((&unnamed_1.cloudCells[_e231]));
            param_455 = _e234;
            let _e235 = getCloudKind_u0028_u1_u003b((&param_455));
            if (_e235 == 2u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e237 = i_12;
            i_12 = (_e237 + 1i);
        }
    }
    return false;
}

fn packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b(kind: ptr<function, u32>, moved: ptr<function, bool>, counter: ptr<function, u32>, target_2: ptr<function, u32>) -> u32 {
    let _e218 = (*kind);
    let _e220 = (*moved);
    let _e223 = (*counter);
    let _e228 = (*target_2);
    return ((((_e218 & 3u) | select(0u, 4u, _e220)) | (min(_e223, 2047u) << bitcast<u32>(3i))) | (min(_e228, 2047u) << bitcast<u32>(14i)));
}

fn updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_12: ptr<function, vec3<i32>>, currentIndex_7: ptr<function, u32>, rawValue_6: ptr<function, u32>, currentSleep_3: ptr<function, u32>, currentAge_6: ptr<function, u32>, randVal_8: ptr<function, f32>) {
    var newKind: u32;
    var param_456: u32;
    var param_457: bool;
    var param_458: u32;
    var param_459: u32;
    var newAge: u32;
    var newKind_1: u32;
    var param_460: vec3<i32>;
    var param_461: u32;
    var param_462: bool;
    var param_463: u32;
    var param_464: u32;
    var d_9: i32;
    var scatterPos: vec3<i32>;
    var param_465: i32;
    var sType: u32;
    var param_466: vec3<i32>;
    var param_467: u32;
    var param_468: u32;
    var param_469: vec3<i32>;
    var param_470: u32;
    var carried_1: u32;
    var param_471: vec3<i32>;
    var param_472: u32;
    var param_473: u32;
    var param_474: u32;
    var param_475: u32;
    var param_476: u32;
    var param_477: u32;
    var param_478: u32;
    var param_479: u32;
    var checkPos: array<vec3<i32>, 3>;
    var dir_2: i32;
    var upPos_1: vec3<i32>;
    var underSettled: bool;
    var param_480: vec3<i32>;
    var param_481: vec3<i32>;
    var param_482: u32;
    var touchingRain: bool;
    var param_483: vec3<i32>;
    var newKind_2: u32;
    var param_484: u32;
    var param_485: bool;
    var param_486: u32;
    var param_487: u32;
    var i_13: i32;
    var cPos: vec3<i32>;
    var cIndex: u32;
    var param_488: vec3<i32>;
    var cVal: u32;
    var param_489: u32;
    var cType: u32;
    var param_490: u32;
    var moisture_2: u32;
    var param_491: u32;
    var capacity: u32;
    var local_15: u32;
    var i_14: i32;
    var sPos_1: vec3<i32>;
    var sType_1: u32;
    var param_492: vec3<i32>;
    var param_493: u32;
    var param_494: u32;
    var param_495: vec3<i32>;
    var param_496: u32;
    var param_497: vec3<i32>;
    var param_498: u32;
    var param_499: u32;
    var param_500: u32;
    var param_501: u32;
    var param_502: u32;
    var param_503: u32;
    var param_504: u32;
    var param_505: u32;
    var newSleep_1: u32;
    var param_506: u32;
    var param_507: u32;
    var param_508: u32;
    var param_509: u32;
    var phi_9015_: bool;
    var phi_9064_: bool;
    var phi_9070_: bool;
    var phi_9080_: bool;
    var phi_9086_: bool;
    var phi_9096_: bool;
    var phi_9122_: bool;
    var phi_9204_: bool;
    var phi_9222_: bool;
    var phi_9261_: bool;
    var phi_9267_: bool;
    var phi_9277_: bool;
    var phi_9358_: bool;
    var phi_9368_: bool;
    var phi_9374_: bool;
    var phi_9384_: bool;
    var phi_9410_: bool;

    let _e300 = (*pos_12)[1u];
    let _e302 = tuning.gridHeight;
    if (_e300 >= (bitcast<i32>(_e302) - 2i)) {
        let _e307 = unnamed_2.rainPhase;
        newKind = select(1u, 2u, (_e307 == 2u));
        let _e310 = (*currentIndex_7);
        let _e313 = newKind;
        param_456 = _e313;
        param_457 = false;
        param_458 = 0u;
        param_459 = 0u;
        let _e314 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_456), (&param_457), (&param_458), (&param_459));
        let _e315 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e310]), 0u, _e314);
        if (_e315.old_value == 0u) {
            let _e318 = (*currentIndex_7);
            let _e321 = atomicExchange((&unnamed.grid[_e318]), 0u);
            return;
        }
        let _e322 = (*currentIndex_7);
        let _e325 = atomicExchange((&unnamed.grid[_e322]), 0u);
        return;
    }
    let _e326 = (*currentAge_6);
    newAge = min((_e326 + 1u), 255u);
    let _e329 = (*currentSleep_3);
    let _e331 = tuning.steamCondenseTicks;
    if (_e329 >= _e331) {
        let _e334 = unnamed_2.rainPhase;
        let _e335 = (_e334 == 2u);
        phi_9015_ = _e335;
        if !(_e335) {
            let _e337 = (*pos_12);
            param_460 = _e337;
            let _e338 = cloudTouchesRain_u0028_vi3_u003b((&param_460));
            phi_9015_ = _e338;
        }
        let _e340 = phi_9015_;
        newKind_1 = select(1u, 2u, _e340);
        let _e342 = (*currentIndex_7);
        let _e345 = newKind_1;
        param_461 = _e345;
        param_462 = false;
        param_463 = 0u;
        param_464 = 0u;
        let _e346 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_461), (&param_462), (&param_463), (&param_464));
        let _e347 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e342]), 0u, _e346);
        let _e349 = (*currentIndex_7);
        let _e352 = atomicExchange((&unnamed.grid[_e349]), 0u);
        return;
    }
    let _e353 = (*randVal_8);
    let _e357 = tuning.steamScatterChance;
    if (fract((_e353 * 88f)) < _e357) {
        let _e359 = (*randVal_8);
        d_9 = i32((fract((_e359 * 13f)) * 6f));
        let _e364 = (*pos_12);
        let _e365 = d_9;
        param_465 = _e365;
        let _e366 = getOrthoDir_u0028_i1_u003b((&param_465));
        scatterPos = (_e364 + _e366);
        let _e369 = scatterPos[0u];
        let _e370 = (_e369 > 0i);
        phi_9064_ = _e370;
        if _e370 {
            let _e372 = scatterPos[0u];
            let _e374 = tuning.gridWidth;
            phi_9064_ = (_e372 < (bitcast<i32>(_e374) - 1i));
        }
        let _e379 = phi_9064_;
        phi_9070_ = _e379;
        if _e379 {
            let _e381 = scatterPos[1u];
            phi_9070_ = (_e381 > 0i);
        }
        let _e384 = phi_9070_;
        phi_9080_ = _e384;
        if _e384 {
            let _e386 = scatterPos[1u];
            let _e388 = tuning.gridHeight;
            phi_9080_ = (_e386 < (bitcast<i32>(_e388) - 1i));
        }
        let _e393 = phi_9080_;
        phi_9086_ = _e393;
        if _e393 {
            let _e395 = scatterPos[2u];
            phi_9086_ = (_e395 > 0i);
        }
        let _e398 = phi_9086_;
        phi_9096_ = _e398;
        if _e398 {
            let _e400 = scatterPos[2u];
            let _e402 = tuning.gridDepth;
            phi_9096_ = (_e400 < (bitcast<i32>(_e402) - 1i));
        }
        let _e407 = phi_9096_;
        if _e407 {
            let _e408 = scatterPos;
            param_466 = _e408;
            let _e409 = getIndex_u0028_vi3_u003b((&param_466));
            param_467 = _e409;
            let _e410 = readCell_u0028_u1_u003b((&param_467));
            param_468 = _e410;
            let _e411 = getType_u0028_u1_u003b((&param_468));
            sType = _e411;
            let _e412 = sType;
            let _e414 = sType;
            let _e416 = ((_e412 == 0u) || (_e414 == 5u));
            phi_9122_ = _e416;
            if _e416 {
                let _e417 = scatterPos;
                param_469 = _e417;
                let _e418 = getIndex_u0028_vi3_u003b((&param_469));
                let _e421 = atomicLoad((&unnamed_1.cloudCells[_e418]));
                param_470 = _e421;
                let _e422 = getCloudKind_u0028_u1_u003b((&param_470));
                phi_9122_ = (_e422 == 0u);
            }
            let _e425 = phi_9122_;
            if _e425 {
                let _e426 = (*currentSleep_3);
                carried_1 = min((_e426 + 1u), 255u);
                let _e429 = scatterPos;
                param_471 = _e429;
                let _e430 = getIndex_u0028_vi3_u003b((&param_471));
                param_472 = 6u;
                param_473 = 0u;
                let _e431 = carried_1;
                param_474 = _e431;
                let _e432 = newAge;
                param_475 = _e432;
                let _e433 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_472), (&param_473), (&param_474), (&param_475));
                let _e434 = (*currentIndex_7);
                param_476 = _e434;
                let _e435 = (*rawValue_6);
                param_477 = _e435;
                param_478 = _e430;
                param_479 = _e433;
                let _e436 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_476), (&param_477), (&param_478), (&param_479));
                if _e436 {
                    return;
                }
            }
        }
    }
    let _e437 = (*pos_12);
    checkPos[0i] = (_e437 + vec3<i32>(0i, 1i, 0i));
    let _e440 = (*randVal_8);
    dir_2 = select(-1i, 1i, (fract((_e440 * 10f)) > 0.5f));
    let _e445 = (*randVal_8);
    if (fract((_e445 * 100f)) > 0.5f) {
        let _e449 = (*pos_12);
        let _e450 = dir_2;
        checkPos[1i] = (_e449 + vec3<i32>(_e450, 1i, 0i));
        let _e454 = (*pos_12);
        let _e455 = dir_2;
        checkPos[2i] = (_e454 + vec3<i32>(0i, 1i, _e455));
    } else {
        let _e459 = (*pos_12);
        let _e460 = dir_2;
        checkPos[1i] = (_e459 + vec3<i32>(0i, 1i, _e460));
        let _e464 = (*pos_12);
        let _e465 = dir_2;
        checkPos[2i] = (_e464 + vec3<i32>(_e465, 1i, 0i));
    }
    let _e469 = (*pos_12);
    upPos_1 = (_e469 + vec3<i32>(0i, 1i, 0i));
    let _e471 = upPos_1;
    param_480 = _e471;
    let _e472 = cloudCellInBounds_u0028_vi3_u003b((&param_480));
    phi_9204_ = _e472;
    if _e472 {
        let _e473 = upPos_1;
        param_481 = _e473;
        let _e474 = getIndex_u0028_vi3_u003b((&param_481));
        let _e477 = atomicLoad((&unnamed_1.cloudCells[_e474]));
        param_482 = _e477;
        let _e478 = cloudIsAtRest_u0028_u1_u003b((&param_482));
        phi_9204_ = _e478;
    }
    let _e480 = phi_9204_;
    underSettled = _e480;
    let _e481 = (*pos_12);
    param_483 = _e481;
    let _e482 = cloudTouchesRain_u0028_vi3_u003b((&param_483));
    touchingRain = _e482;
    let _e483 = underSettled;
    let _e484 = touchingRain;
    if (_e483 || _e484) {
        let _e486 = touchingRain;
        phi_9222_ = _e486;
        if !(_e486) {
            let _e489 = unnamed_2.rainPhase;
            phi_9222_ = (_e489 == 2u);
        }
        let _e492 = phi_9222_;
        newKind_2 = select(1u, 2u, _e492);
        let _e494 = (*currentIndex_7);
        let _e497 = newKind_2;
        param_484 = _e497;
        param_485 = false;
        param_486 = 0u;
        param_487 = 0u;
        let _e498 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_484), (&param_485), (&param_486), (&param_487));
        let _e499 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e494]), 0u, _e498);
        let _e501 = (*currentIndex_7);
        let _e504 = atomicExchange((&unnamed.grid[_e501]), 0u);
        return;
    }
    i_13 = 0i;
    loop {
        let _e505 = i_13;
        if (_e505 < 3i) {
            let _e507 = i_13;
            let _e509 = checkPos[_e507];
            cPos = _e509;
            let _e511 = cPos[0u];
            let _e512 = (_e511 > 0i);
            phi_9261_ = _e512;
            if _e512 {
                let _e514 = cPos[0u];
                let _e516 = tuning.gridWidth;
                phi_9261_ = (_e514 < (bitcast<i32>(_e516) - 1i));
            }
            let _e521 = phi_9261_;
            phi_9267_ = _e521;
            if _e521 {
                let _e523 = cPos[2u];
                phi_9267_ = (_e523 > 0i);
            }
            let _e526 = phi_9267_;
            phi_9277_ = _e526;
            if _e526 {
                let _e528 = cPos[2u];
                let _e530 = tuning.gridDepth;
                phi_9277_ = (_e528 < (bitcast<i32>(_e530) - 1i));
            }
            let _e535 = phi_9277_;
            if _e535 {
                let _e536 = cPos;
                param_488 = _e536;
                let _e537 = getIndex_u0028_vi3_u003b((&param_488));
                cIndex = _e537;
                let _e538 = cIndex;
                param_489 = _e538;
                let _e539 = readCell_u0028_u1_u003b((&param_489));
                cVal = _e539;
                let _e540 = cVal;
                param_490 = _e540;
                let _e541 = getType_u0028_u1_u003b((&param_490));
                cType = _e541;
                let _e542 = cType;
                let _e544 = cType;
                if ((_e542 == 1u) || (_e544 == 4u)) {
                    let _e547 = cVal;
                    param_491 = _e547;
                    let _e548 = getAge_u0028_u1_u003b((&param_491));
                    moisture_2 = _e548;
                    let _e549 = cType;
                    if (_e549 == 4u) {
                        let _e552 = tuning.dirtMoistureCapacity;
                        local_15 = _e552;
                    } else {
                        let _e554 = tuning.sandMoistureCapacity;
                        local_15 = _e554;
                    }
                    let _e555 = local_15;
                    capacity = _e555;
                    let _e556 = moisture_2;
                    let _e557 = capacity;
                    if (_e556 < _e557) {
                        let _e559 = (*currentIndex_7);
                        let _e562 = (*rawValue_6);
                        let _e563 = atomicCompareExchangeWeak((&unnamed.grid[_e559]), _e562, 0u);
                        let _e565 = (*rawValue_6);
                        if (_e563.old_value == _e565) {
                            let _e567 = cIndex;
                            let _e570 = atomicAdd((&unnamed.grid[_e567]), 16777216u);
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
            let _e571 = i_13;
            i_13 = (_e571 + 1i);
        }
    }
    i_14 = 0i;
    loop {
        let _e573 = i_14;
        if (_e573 < 3i) {
            let _e575 = i_14;
            let _e577 = checkPos[_e575];
            sPos_1 = _e577;
            let _e579 = sPos_1[1u];
            let _e581 = tuning.gridHeight;
            let _e584 = (_e579 < (bitcast<i32>(_e581) - 1i));
            phi_9358_ = _e584;
            if _e584 {
                let _e586 = sPos_1[0u];
                phi_9358_ = (_e586 > 0i);
            }
            let _e589 = phi_9358_;
            phi_9368_ = _e589;
            if _e589 {
                let _e591 = sPos_1[0u];
                let _e593 = tuning.gridWidth;
                phi_9368_ = (_e591 < (bitcast<i32>(_e593) - 1i));
            }
            let _e598 = phi_9368_;
            phi_9374_ = _e598;
            if _e598 {
                let _e600 = sPos_1[2u];
                phi_9374_ = (_e600 > 0i);
            }
            let _e603 = phi_9374_;
            phi_9384_ = _e603;
            if _e603 {
                let _e605 = sPos_1[2u];
                let _e607 = tuning.gridDepth;
                phi_9384_ = (_e605 < (bitcast<i32>(_e607) - 1i));
            }
            let _e612 = phi_9384_;
            if _e612 {
                let _e613 = sPos_1;
                param_492 = _e613;
                let _e614 = getIndex_u0028_vi3_u003b((&param_492));
                param_493 = _e614;
                let _e615 = readCell_u0028_u1_u003b((&param_493));
                param_494 = _e615;
                let _e616 = getType_u0028_u1_u003b((&param_494));
                sType_1 = _e616;
                let _e617 = sType_1;
                let _e619 = sType_1;
                let _e621 = ((_e617 == 0u) || (_e619 == 5u));
                phi_9410_ = _e621;
                if _e621 {
                    let _e622 = sPos_1;
                    param_495 = _e622;
                    let _e623 = getIndex_u0028_vi3_u003b((&param_495));
                    let _e626 = atomicLoad((&unnamed_1.cloudCells[_e623]));
                    param_496 = _e626;
                    let _e627 = getCloudKind_u0028_u1_u003b((&param_496));
                    phi_9410_ = (_e627 == 0u);
                }
                let _e630 = phi_9410_;
                if _e630 {
                    let _e631 = sPos_1;
                    param_497 = _e631;
                    let _e632 = getIndex_u0028_vi3_u003b((&param_497));
                    param_498 = 6u;
                    param_499 = 0u;
                    param_500 = 0u;
                    let _e633 = newAge;
                    param_501 = _e633;
                    let _e634 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_498), (&param_499), (&param_500), (&param_501));
                    let _e635 = (*currentIndex_7);
                    param_502 = _e635;
                    let _e636 = (*rawValue_6);
                    param_503 = _e636;
                    param_504 = _e632;
                    param_505 = _e634;
                    let _e637 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_502), (&param_503), (&param_504), (&param_505));
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
            let _e638 = i_14;
            i_14 = (_e638 + 1i);
        }
    }
    let _e640 = (*currentSleep_3);
    newSleep_1 = min((_e640 + 1u), 255u);
    let _e643 = (*currentIndex_7);
    let _e646 = (*rawValue_6);
    param_506 = 6u;
    param_507 = 0u;
    let _e647 = newSleep_1;
    param_508 = _e647;
    let _e648 = newAge;
    param_509 = _e648;
    let _e649 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_506), (&param_507), (&param_508), (&param_509));
    let _e650 = atomicCompareExchangeWeak((&unnamed.grid[_e643]), _e646, _e649);
    return;
}

fn updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_13: ptr<function, vec3<i32>>, currentIndex_8: ptr<function, u32>, rawValue_7: ptr<function, u32>, currentDir_3: ptr<function, u32>, currentSleep_4: ptr<function, u32>, currentAge_7: ptr<function, u32>, randVal_9: ptr<function, f32>) {
    var newAge_1: u32;
    var isBurningGrass: bool;
    var i_15: i32;
    var nPos_2: vec3<i32>;
    var param_510: i32;
    var nIndex_1: u32;
    var param_511: vec3<i32>;
    var nVal_1: u32;
    var param_512: u32;
    var param_513: u32;
    var param_514: u32;
    var param_515: u32;
    var param_516: u32;
    var param_517: u32;
    var burnRoll: f32;
    var start_8: i32;
    var i_16: i32;
    var nPos_3: vec3<i32>;
    var param_518: i32;
    var param_519: vec3<i32>;
    var nIndex_2: u32;
    var param_520: vec3<i32>;
    var nVal_2: u32;
    var param_521: u32;
    var nType_2: u32;
    var param_522: u32;
    var need_1: f32;
    var local_16: f32;
    var param_523: u32;
    var param_524: u32;
    var param_525: u32;
    var param_526: u32;
    var belowPos_5: vec3<i32>;
    var belowIndex_2: u32;
    var param_527: vec3<i32>;
    var belowValue_2: u32;
    var param_528: u32;
    var belowType: u32;
    var param_529: u32;
    var param_530: u32;
    var param_531: u32;
    var param_532: u32;
    var param_533: u32;
    var param_534: u32;
    var param_535: u32;
    var param_536: u32;
    var param_537: u32;
    var moisture_3: u32;
    var param_538: u32;
    var newMoisture: u32;
    var local_17: u32;
    var newVal: u32;
    var param_539: u32;
    var param_540: u32;
    var param_541: u32;
    var param_542: u32;
    var param_543: u32;
    var flora_4: u32;
    var newFlora: u32;
    var newVal_1: u32;
    var param_544: u32;
    var param_545: u32;
    var param_546: u32;
    var param_547: u32;
    var param_548: u32;
    var d_10: i32;
    var targetPos_1: vec3<i32>;
    var param_549: i32;
    var targetIndex_1: u32;
    var param_550: vec3<i32>;
    var param_551: u32;
    var param_552: u32;
    var targetBelow: vec3<i32>;
    var tBelowVal: u32;
    var param_553: vec3<i32>;
    var param_554: u32;
    var param_555: u32;
    var tFlora: u32;
    var param_556: u32;
    var param_557: u32;
    var param_558: u32;
    var param_559: u32;
    var remains: u32;
    var local_18: u32;
    var param_560: u32;
    var param_561: u32;
    var param_562: u32;
    var param_563: u32;
    var param_564: u32;
    var param_565: u32;
    var param_566: u32;
    var param_567: u32;
    var phi_8293_: bool;
    var phi_8299_: bool;
    var phi_8309_: bool;
    var phi_8315_: bool;
    var phi_8325_: bool;
    var phi_8633_: bool;
    var phi_8639_: bool;
    var phi_8649_: bool;

    let _e313 = (*currentAge_7);
    newAge_1 = (_e313 + 1u);
    isBurningGrass = false;
    i_15 = 0i;
    loop {
        let _e315 = i_15;
        if (_e315 < 6i) {
            let _e317 = (*pos_13);
            let _e318 = i_15;
            param_510 = _e318;
            let _e319 = getOrthoDir_u0028_i1_u003b((&param_510));
            nPos_2 = (_e317 + _e319);
            let _e322 = nPos_2[0u];
            let _e323 = (_e322 > 0i);
            phi_8293_ = _e323;
            if _e323 {
                let _e325 = nPos_2[0u];
                let _e327 = tuning.gridWidth;
                phi_8293_ = (_e325 < (bitcast<i32>(_e327) - 1i));
            }
            let _e332 = phi_8293_;
            phi_8299_ = _e332;
            if _e332 {
                let _e334 = nPos_2[1u];
                phi_8299_ = (_e334 > 0i);
            }
            let _e337 = phi_8299_;
            phi_8309_ = _e337;
            if _e337 {
                let _e339 = nPos_2[1u];
                let _e341 = tuning.gridHeight;
                phi_8309_ = (_e339 < (bitcast<i32>(_e341) - 1i));
            }
            let _e346 = phi_8309_;
            phi_8315_ = _e346;
            if _e346 {
                let _e348 = nPos_2[2u];
                phi_8315_ = (_e348 > 0i);
            }
            let _e351 = phi_8315_;
            phi_8325_ = _e351;
            if _e351 {
                let _e353 = nPos_2[2u];
                let _e355 = tuning.gridDepth;
                phi_8325_ = (_e353 < (bitcast<i32>(_e355) - 1i));
            }
            let _e360 = phi_8325_;
            if _e360 {
                let _e361 = nPos_2;
                param_511 = _e361;
                let _e362 = getIndex_u0028_vi3_u003b((&param_511));
                nIndex_1 = _e362;
                let _e363 = nIndex_1;
                param_512 = _e363;
                let _e364 = readCell_u0028_u1_u003b((&param_512));
                nVal_1 = _e364;
                let _e365 = nVal_1;
                param_513 = _e365;
                let _e366 = getType_u0028_u1_u003b((&param_513));
                if (_e366 == 2u) {
                    let _e368 = nIndex_1;
                    let _e371 = nVal_1;
                    param_514 = 6u;
                    param_515 = 0u;
                    param_516 = 0u;
                    param_517 = 0u;
                    let _e372 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_514), (&param_515), (&param_516), (&param_517));
                    let _e373 = atomicCompareExchangeWeak((&unnamed.grid[_e368]), _e371, _e372);
                    let _e375 = nVal_1;
                    if (_e373.old_value == _e375) {
                        decWater_u0028_();
                        let _e377 = (*currentIndex_8);
                        let _e380 = atomicExchange((&unnamed.grid[_e377]), 0u);
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e381 = i_15;
            i_15 = (_e381 + 1i);
        }
    }
    let _e383 = (*randVal_9);
    burnRoll = fract((_e383 * 47f));
    let _e386 = burnRoll;
    let _e388 = tuning.treeLeafBurnChance;
    let _e390 = tuning.treeTrunkBurnChance;
    if (_e386 < max(_e388, _e390)) {
        let _e393 = (*randVal_9);
        start_8 = i32((fract((_e393 * 31f)) * 26f));
        i_16 = 0i;
        loop {
            let _e398 = i_16;
            if (_e398 < 26i) {
                let _e400 = (*pos_13);
                let _e401 = start_8;
                let _e402 = i_16;
                let _e403 = (_e401 + _e402);
                param_518 = (_e403 - (i32(floor((f32(_e403) / f32(26i)))) * 26i));
                let _e411 = tree26_u0028_i1_u003b((&param_518));
                nPos_3 = (_e400 + _e411);
                let _e413 = nPos_3;
                param_519 = _e413;
                let _e414 = treeInBounds_u0028_vi3_u003b((&param_519));
                if !(_e414) {
                    continue;
                }
                let _e416 = nPos_3;
                param_520 = _e416;
                let _e417 = getIndex_u0028_vi3_u003b((&param_520));
                nIndex_2 = _e417;
                let _e418 = nIndex_2;
                param_521 = _e418;
                let _e419 = readCell_u0028_u1_u003b((&param_521));
                nVal_2 = _e419;
                let _e420 = nVal_2;
                param_522 = _e420;
                let _e421 = getType_u0028_u1_u003b((&param_522));
                nType_2 = _e421;
                let _e422 = nType_2;
                let _e424 = nType_2;
                if ((_e422 != 19u) && (_e424 != 18u)) {
                    continue;
                }
                let _e427 = nType_2;
                if (_e427 == 19u) {
                    let _e430 = tuning.treeLeafBurnChance;
                    local_16 = _e430;
                } else {
                    let _e432 = tuning.treeTrunkBurnChance;
                    local_16 = _e432;
                }
                let _e433 = local_16;
                need_1 = _e433;
                let _e434 = burnRoll;
                let _e435 = need_1;
                if (_e434 < _e435) {
                    let _e437 = nIndex_2;
                    let _e440 = nVal_2;
                    param_523 = 5u;
                    param_524 = 0u;
                    param_525 = 0u;
                    param_526 = 0u;
                    let _e441 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_523), (&param_524), (&param_525), (&param_526));
                    let _e442 = atomicCompareExchangeWeak((&unnamed.grid[_e437]), _e440, _e441);
                }
                break;
            } else {
                break;
            }
            continuing {
                let _e444 = i_16;
                i_16 = (_e444 + 1i);
            }
        }
    }
    let _e447 = (*pos_13)[1u];
    if (_e447 > 1i) {
        let _e449 = (*pos_13);
        belowPos_5 = (_e449 + vec3<i32>(0i, -1i, 0i));
        let _e451 = belowPos_5;
        param_527 = _e451;
        let _e452 = getIndex_u0028_vi3_u003b((&param_527));
        belowIndex_2 = _e452;
        let _e453 = belowIndex_2;
        param_528 = _e453;
        let _e454 = readCell_u0028_u1_u003b((&param_528));
        belowValue_2 = _e454;
        let _e455 = belowValue_2;
        param_529 = _e455;
        let _e456 = getType_u0028_u1_u003b((&param_529));
        belowType = _e456;
        let _e457 = belowType;
        if (_e457 == 0u) {
            param_530 = 5u;
            param_531 = 0u;
            param_532 = 0u;
            let _e459 = newAge_1;
            param_533 = _e459;
            let _e460 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_530), (&param_531), (&param_532), (&param_533));
            let _e461 = (*currentIndex_8);
            param_534 = _e461;
            let _e462 = (*rawValue_7);
            param_535 = _e462;
            let _e463 = belowIndex_2;
            param_536 = _e463;
            param_537 = _e460;
            let _e464 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_534), (&param_535), (&param_536), (&param_537));
            if _e464 {
                return;
            }
        } else {
            let _e465 = belowType;
            if (_e465 == 2u) {
                let _e467 = (*currentIndex_8);
                let _e470 = atomicExchange((&unnamed.grid[_e467]), 0u);
                return;
            } else {
                let _e471 = belowType;
                if (_e471 == 1u) {
                    let _e473 = belowValue_2;
                    param_538 = _e473;
                    let _e474 = getAge_u0028_u1_u003b((&param_538));
                    moisture_3 = _e474;
                    let _e475 = moisture_3;
                    if (_e475 > 0u) {
                        let _e477 = moisture_3;
                        let _e479 = tuning.fireDryRate;
                        if (_e477 > _e479) {
                            let _e481 = moisture_3;
                            let _e483 = tuning.fireDryRate;
                            local_17 = (_e481 - _e483);
                        } else {
                            local_17 = 0u;
                        }
                        let _e485 = local_17;
                        newMoisture = _e485;
                        let _e486 = belowValue_2;
                        param_539 = _e486;
                        let _e487 = getDir_u0028_u1_u003b((&param_539));
                        param_540 = 1u;
                        param_541 = _e487;
                        param_542 = 0u;
                        let _e488 = newMoisture;
                        param_543 = _e488;
                        let _e489 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_540), (&param_541), (&param_542), (&param_543));
                        newVal = _e489;
                        let _e490 = belowIndex_2;
                        let _e493 = belowValue_2;
                        let _e494 = newVal;
                        let _e495 = atomicCompareExchangeWeak((&unnamed.grid[_e490]), _e493, _e494);
                        let _e497 = belowValue_2;
                        if (_e495.old_value == _e497) {
                            let _e499 = (*currentIndex_8);
                            let _e502 = atomicExchange((&unnamed.grid[_e499]), 0u);
                            return;
                        }
                    }
                } else {
                    let _e503 = belowType;
                    if (_e503 == 4u) {
                        let _e505 = belowValue_2;
                        flora_4 = ((_e505 >> bitcast<u32>(8i)) & 255u);
                        let _e509 = flora_4;
                        let _e511 = flora_4;
                        if ((_e509 > 10u) && (_e511 <= 100u)) {
                            isBurningGrass = true;
                            newAge_1 = 0u;
                            let _e514 = (*randVal_9);
                            let _e518 = tuning.fireBurnGrassChance;
                            if (fract((_e514 * 100f)) < _e518) {
                                let _e520 = flora_4;
                                newFlora = (_e520 - 1u);
                                let _e522 = belowValue_2;
                                param_544 = _e522;
                                let _e523 = getAge_u0028_u1_u003b((&param_544));
                                param_545 = 4u;
                                let _e524 = newFlora;
                                param_546 = _e524;
                                param_547 = 0u;
                                param_548 = _e523;
                                let _e525 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_545), (&param_546), (&param_547), (&param_548));
                                newVal_1 = _e525;
                                let _e526 = belowIndex_2;
                                let _e529 = belowValue_2;
                                let _e530 = newVal_1;
                                let _e531 = atomicCompareExchangeWeak((&unnamed.grid[_e526]), _e529, _e530);
                            }
                            let _e533 = (*randVal_9);
                            let _e537 = tuning.fireSpreadChance;
                            if (fract((_e533 * 100f)) < _e537) {
                                let _e539 = (*randVal_9);
                                d_10 = i32((fract((_e539 * 10f)) * 8f));
                                let _e544 = (*pos_13);
                                let _e545 = d_10;
                                param_549 = _e545;
                                let _e546 = getHDir_u0028_i1_u003b((&param_549));
                                targetPos_1 = (_e544 + _e546);
                                let _e549 = targetPos_1[0u];
                                let _e550 = (_e549 > 0i);
                                phi_8633_ = _e550;
                                if _e550 {
                                    let _e552 = targetPos_1[0u];
                                    let _e554 = tuning.gridWidth;
                                    phi_8633_ = (_e552 < (bitcast<i32>(_e554) - 1i));
                                }
                                let _e559 = phi_8633_;
                                phi_8639_ = _e559;
                                if _e559 {
                                    let _e561 = targetPos_1[2u];
                                    phi_8639_ = (_e561 > 0i);
                                }
                                let _e564 = phi_8639_;
                                phi_8649_ = _e564;
                                if _e564 {
                                    let _e566 = targetPos_1[2u];
                                    let _e568 = tuning.gridDepth;
                                    phi_8649_ = (_e566 < (bitcast<i32>(_e568) - 1i));
                                }
                                let _e573 = phi_8649_;
                                if _e573 {
                                    let _e574 = targetPos_1;
                                    param_550 = _e574;
                                    let _e575 = getIndex_u0028_vi3_u003b((&param_550));
                                    targetIndex_1 = _e575;
                                    let _e576 = targetIndex_1;
                                    param_551 = _e576;
                                    let _e577 = readCell_u0028_u1_u003b((&param_551));
                                    param_552 = _e577;
                                    let _e578 = getType_u0028_u1_u003b((&param_552));
                                    if (_e578 == 0u) {
                                        let _e580 = targetPos_1;
                                        targetBelow = (_e580 + vec3<i32>(0i, -1i, 0i));
                                        let _e582 = targetBelow;
                                        param_553 = _e582;
                                        let _e583 = getIndex_u0028_vi3_u003b((&param_553));
                                        param_554 = _e583;
                                        let _e584 = readCell_u0028_u1_u003b((&param_554));
                                        tBelowVal = _e584;
                                        let _e585 = tBelowVal;
                                        param_555 = _e585;
                                        let _e586 = getType_u0028_u1_u003b((&param_555));
                                        if (_e586 == 4u) {
                                            let _e588 = tBelowVal;
                                            tFlora = ((_e588 >> bitcast<u32>(8i)) & 255u);
                                            let _e592 = tFlora;
                                            let _e594 = tFlora;
                                            if ((_e592 > 10u) && (_e594 <= 100u)) {
                                                let _e597 = targetIndex_1;
                                                param_556 = 5u;
                                                param_557 = 0u;
                                                param_558 = 0u;
                                                param_559 = 0u;
                                                let _e600 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_556), (&param_557), (&param_558), (&param_559));
                                                let _e601 = atomicCompareExchangeWeak((&unnamed.grid[_e597]), 0u, _e600);
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
    let _e603 = newAge_1;
    let _e605 = tuning.fireLifetime;
    if (_e603 > _e605) {
        let _e607 = (*randVal_9);
        let _e611 = tuning.fireAshChance;
        if (fract((_e607 * 83f)) < _e611) {
            param_560 = 20u;
            param_561 = 0u;
            param_562 = 0u;
            param_563 = 0u;
            let _e613 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_560), (&param_561), (&param_562), (&param_563));
            local_18 = _e613;
        } else {
            local_18 = 0u;
        }
        let _e614 = local_18;
        remains = _e614;
        let _e615 = (*currentIndex_8);
        let _e618 = remains;
        let _e619 = atomicExchange((&unnamed.grid[_e615]), _e618);
        return;
    }
    let _e620 = (*currentIndex_8);
    let _e623 = (*rawValue_7);
    param_564 = 5u;
    param_565 = 0u;
    param_566 = 0u;
    let _e624 = newAge_1;
    param_567 = _e624;
    let _e625 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_564), (&param_565), (&param_566), (&param_567));
    let _e626 = atomicCompareExchangeWeak((&unnamed.grid[_e620]), _e623, _e625);
    return;
}

fn isLocust_u0028_u1_u003b(type_36: ptr<function, u32>) -> bool {
    let _e215 = (*type_36);
    let _e217 = (*type_36);
    return ((_e215 >= 13u) && (_e217 <= 17u));
}

fn tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex_9: ptr<function, u32>, currentValue_1: ptr<function, u32>, targetIndex_2: ptr<function, u32>, targetValue_1: ptr<function, u32>, pushIndex: ptr<function, u32>) -> bool {
    var displacedValue: u32;
    var param_568: u32;
    var param_569: u32;
    var param_570: u32;
    var param_571: u32;
    var param_572: u32;
    var actualPush: u32;
    var actualTarget: u32;

    let _e227 = (*currentIndex_9);
    let _e230 = (*currentValue_1);
    let _e231 = atomicCompareExchangeWeak((&unnamed.grid[_e227]), _e230, 0u);
    let _e233 = (*currentValue_1);
    if (_e231.old_value == _e233) {
        let _e235 = (*targetValue_1);
        param_568 = _e235;
        let _e236 = getType_u0028_u1_u003b((&param_568));
        param_569 = _e236;
        param_570 = 0u;
        param_571 = 0u;
        param_572 = 0u;
        let _e237 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_569), (&param_570), (&param_571), (&param_572));
        displacedValue = _e237;
        let _e238 = (*pushIndex);
        let _e241 = displacedValue;
        let _e242 = atomicCompareExchangeWeak((&unnamed.grid[_e238]), 0u, _e241);
        actualPush = _e242.old_value;
        let _e244 = actualPush;
        if (_e244 == 0u) {
            let _e246 = (*targetIndex_2);
            let _e249 = (*targetValue_1);
            let _e250 = (*currentValue_1);
            let _e251 = atomicCompareExchangeWeak((&unnamed.grid[_e246]), _e249, _e250);
            actualTarget = _e251.old_value;
            let _e253 = actualTarget;
            let _e254 = (*targetValue_1);
            if (_e253 == _e254) {
                return true;
            } else {
                let _e256 = (*pushIndex);
                let _e259 = displacedValue;
                let _e260 = atomicCompareExchangeWeak((&unnamed.grid[_e256]), _e259, 0u);
            }
        }
        let _e262 = (*currentIndex_9);
        let _e265 = (*currentValue_1);
        let _e266 = atomicCompareExchangeWeak((&unnamed.grid[_e262]), 0u, _e265);
    }
    return false;
}

fn grainCanMove_u0028_vi3_u003b(pos_14: ptr<function, vec3<i32>>) -> bool {
    var i_17: i32;
    var target_3: vec3<i32>;
    var local_19: i32;
    var local_20: i32;
    var t_4: u32;
    var param_573: vec3<i32>;
    var param_574: u32;
    var param_575: u32;
    var phi_2467_: bool;
    var phi_2474_: bool;
    var phi_2485_: bool;

    let _e224 = (*pos_14)[1u];
    if (_e224 <= 1i) {
        return false;
    }
    i_17 = 0i;
    loop {
        let _e226 = i_17;
        if (_e226 < 5i) {
            let _e228 = (*pos_14);
            let _e229 = i_17;
            if (_e229 == 1i) {
                local_19 = 1i;
            } else {
                let _e231 = i_17;
                local_19 = select(0i, -1i, (_e231 == 2i));
            }
            let _e234 = local_19;
            let _e235 = i_17;
            if (_e235 == 3i) {
                local_20 = 1i;
            } else {
                let _e237 = i_17;
                local_20 = select(0i, -1i, (_e237 == 4i));
            }
            let _e240 = local_20;
            target_3 = (_e228 + vec3<i32>(_e234, -1i, _e240));
            let _e244 = target_3[0u];
            let _e245 = (_e244 <= 0i);
            phi_2467_ = _e245;
            if !(_e245) {
                let _e248 = target_3[0u];
                let _e250 = tuning.gridWidth;
                phi_2467_ = (_e248 >= (bitcast<i32>(_e250) - 1i));
            }
            let _e255 = phi_2467_;
            phi_2474_ = _e255;
            if !(_e255) {
                let _e258 = target_3[2u];
                phi_2474_ = (_e258 <= 0i);
            }
            let _e261 = phi_2474_;
            phi_2485_ = _e261;
            if !(_e261) {
                let _e264 = target_3[2u];
                let _e266 = tuning.gridDepth;
                phi_2485_ = (_e264 >= (bitcast<i32>(_e266) - 1i));
            }
            let _e271 = phi_2485_;
            if _e271 {
                continue;
            }
            let _e272 = target_3;
            param_573 = _e272;
            let _e273 = getIndex_u0028_vi3_u003b((&param_573));
            param_574 = _e273;
            let _e274 = readCell_u0028_u1_u003b((&param_574));
            param_575 = _e274;
            let _e275 = getType_u0028_u1_u003b((&param_575));
            t_4 = _e275;
            let _e276 = t_4;
            let _e278 = t_4;
            if ((_e276 == 0u) || (_e278 == 2u)) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e281 = i_17;
            i_17 = (_e281 + 1i);
        }
    }
    return false;
}

fn updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_15: ptr<function, vec3<i32>>, currentIndex_10: ptr<function, u32>, rawValue_8: ptr<function, u32>, currentDir_4: ptr<function, u32>, currentSleep_5: ptr<function, u32>, currentAge_8: ptr<function, u32>, randVal_10: ptr<function, f32>) {
    var moisture_4: u32;
    var moistureModified: bool;
    var startDir_1: i32;
    var i_18: i32;
    var d_11: i32;
    var nPos_4: vec3<i32>;
    var param_576: i32;
    var nIndex_3: u32;
    var param_577: vec3<i32>;
    var nVal_3: u32;
    var param_578: u32;
    var param_579: u32;
    var d_12: i32;
    var nPos_5: vec3<i32>;
    var param_580: i32;
    var nIndex_4: u32;
    var param_581: vec3<i32>;
    var nVal_4: u32;
    var param_582: u32;
    var nType_3: u32;
    var param_583: u32;
    var nMoisture: u32;
    var param_584: u32;
    var nCapacity: u32;
    var local_21: u32;
    var canMove: bool;
    var param_585: vec3<i32>;
    var isClumped: bool;
    var emptyBelowCount: i32;
    var x: i32;
    var z: i32;
    var checkPos_1: vec3<i32>;
    var param_586: vec3<i32>;
    var param_587: u32;
    var param_588: u32;
    var clumpCount: i32;
    var x_1: i32;
    var y: i32;
    var z_1: i32;
    var nPos_6: vec3<i32>;
    var param_589: vec3<i32>;
    var param_590: u32;
    var param_591: u32;
    var belowPos_6: vec3<i32>;
    var param_592: vec3<i32>;
    var param_593: u32;
    var param_594: u32;
    var param_595: vec3<i32>;
    var param_596: u32;
    var param_597: u32;
    var param_598: u32;
    var param_599: u32;
    var param_600: u32;
    var param_601: u32;
    var param_602: u32;
    var param_603: u32;
    var dir_3: i32;
    var slidePos1_: vec3<i32>;
    var slidePos2_: vec3<i32>;
    var param_604: vec3<i32>;
    var param_605: u32;
    var param_606: u32;
    var param_607: vec3<i32>;
    var param_608: u32;
    var param_609: u32;
    var param_610: u32;
    var param_611: u32;
    var param_612: u32;
    var param_613: u32;
    var param_614: u32;
    var param_615: u32;
    var param_616: vec3<i32>;
    var param_617: u32;
    var param_618: u32;
    var param_619: vec3<i32>;
    var param_620: u32;
    var param_621: u32;
    var param_622: u32;
    var param_623: u32;
    var param_624: u32;
    var param_625: u32;
    var param_626: u32;
    var param_627: u32;
    var belowPos_7: vec3<i32>;
    var belowIndex_3: u32;
    var param_628: vec3<i32>;
    var belowValue_3: u32;
    var param_629: u32;
    var param_630: u32;
    var startDir_2: i32;
    var i_19: i32;
    var d_13: i32;
    var pushPos: vec3<i32>;
    var param_631: i32;
    var param_632: u32;
    var param_633: u32;
    var param_634: u32;
    var param_635: u32;
    var param_636: vec3<i32>;
    var param_637: u32;
    var param_638: u32;
    var param_639: u32;
    var param_640: u32;
    var param_641: u32;
    var param_642: u32;
    var param_643: u32;
    var param_644: u32;
    var param_645: u32;
    var param_646: u32;
    var param_647: u32;
    var param_648: u32;
    var param_649: u32;
    var dir_4: i32;
    var slidePos: array<vec3<i32>, 2>;
    var s_2: i32;
    var sPos_2: vec3<i32>;
    var sIndex: u32;
    var param_650: vec3<i32>;
    var sValue: u32;
    var param_651: u32;
    var param_652: u32;
    var startDir_3: i32;
    var i_20: i32;
    var d_14: i32;
    var pushPos_1: vec3<i32>;
    var param_653: i32;
    var param_654: u32;
    var param_655: u32;
    var param_656: u32;
    var param_657: u32;
    var param_658: vec3<i32>;
    var param_659: u32;
    var param_660: u32;
    var param_661: u32;
    var param_662: u32;
    var param_663: u32;
    var param_664: u32;
    var param_665: u32;
    var param_666: u32;
    var param_667: u32;
    var param_668: u32;
    var param_669: u32;
    var param_670: u32;
    var param_671: u32;
    var floraState: u32;
    var abovePos_1: vec3<i32>;
    var aboveInside: bool;
    var aboveIndex: u32;
    var param_672: vec3<i32>;
    var aboveType: u32;
    var local_22: u32;
    var param_673: u32;
    var param_674: u32;
    var param_675: u32;
    var param_676: u32;
    var param_677: u32;
    var param_678: u32;
    var param_679: u32;
    var newSleep_2: u32;
    var param_680: u32;
    var param_681: u32;
    var param_682: u32;
    var param_683: u32;
    var phi_3596_: bool;
    var phi_3602_: bool;
    var phi_3612_: bool;
    var phi_3618_: bool;
    var phi_3628_: bool;
    var phi_3694_: bool;
    var phi_3700_: bool;
    var phi_3710_: bool;
    var phi_3716_: bool;
    var phi_3726_: bool;
    var phi_3796_: bool;
    var phi_3838_: bool;
    var phi_3844_: bool;
    var phi_3853_: bool;
    var phi_3934_: bool;
    var phi_3940_: bool;
    var phi_3949_: bool;
    var phi_3955_: bool;
    var phi_3964_: bool;
    var phi_4083_: bool;
    var phi_4089_: bool;
    var phi_4099_: bool;
    var phi_4143_: bool;
    var phi_4149_: bool;
    var phi_4159_: bool;
    var phi_4250_: bool;
    var phi_4256_: bool;
    var phi_4266_: bool;
    var phi_4367_: bool;
    var phi_4373_: bool;
    var phi_4383_: bool;
    var phi_4440_: bool;
    var phi_4446_: bool;
    var phi_4456_: bool;
    var phi_4511_: bool;
    var phi_4591_: bool;
    var phi_4649_: bool;

    let _e384 = (*currentAge_8);
    moisture_4 = _e384;
    moistureModified = false;
    let _e385 = moisture_4;
    let _e387 = tuning.dirtMoistureCapacity;
    if (_e385 < _e387) {
        let _e389 = (*randVal_10);
        startDir_1 = i32((fract((_e389 * 17f)) * 6f));
        i_18 = 0i;
        loop {
            let _e394 = i_18;
            if (_e394 < 6i) {
                let _e396 = startDir_1;
                let _e397 = i_18;
                let _e398 = (_e396 + _e397);
                d_11 = (_e398 - (i32(floor((f32(_e398) / f32(6i)))) * 6i));
                let _e406 = (*pos_15);
                let _e407 = d_11;
                param_576 = _e407;
                let _e408 = getOrthoDir_u0028_i1_u003b((&param_576));
                nPos_4 = (_e406 + _e408);
                let _e411 = nPos_4[0u];
                let _e412 = (_e411 > 0i);
                phi_3596_ = _e412;
                if _e412 {
                    let _e414 = nPos_4[0u];
                    let _e416 = tuning.gridWidth;
                    phi_3596_ = (_e414 < (bitcast<i32>(_e416) - 1i));
                }
                let _e421 = phi_3596_;
                phi_3602_ = _e421;
                if _e421 {
                    let _e423 = nPos_4[1u];
                    phi_3602_ = (_e423 > 0i);
                }
                let _e426 = phi_3602_;
                phi_3612_ = _e426;
                if _e426 {
                    let _e428 = nPos_4[1u];
                    let _e430 = tuning.gridHeight;
                    phi_3612_ = (_e428 < (bitcast<i32>(_e430) - 1i));
                }
                let _e435 = phi_3612_;
                phi_3618_ = _e435;
                if _e435 {
                    let _e437 = nPos_4[2u];
                    phi_3618_ = (_e437 > 0i);
                }
                let _e440 = phi_3618_;
                phi_3628_ = _e440;
                if _e440 {
                    let _e442 = nPos_4[2u];
                    let _e444 = tuning.gridDepth;
                    phi_3628_ = (_e442 < (bitcast<i32>(_e444) - 1i));
                }
                let _e449 = phi_3628_;
                if _e449 {
                    let _e450 = nPos_4;
                    param_577 = _e450;
                    let _e451 = getIndex_u0028_vi3_u003b((&param_577));
                    nIndex_3 = _e451;
                    let _e452 = nIndex_3;
                    param_578 = _e452;
                    let _e453 = readCell_u0028_u1_u003b((&param_578));
                    nVal_3 = _e453;
                    let _e454 = nVal_3;
                    param_579 = _e454;
                    let _e455 = getType_u0028_u1_u003b((&param_579));
                    if (_e455 == 2u) {
                        let _e457 = nIndex_3;
                        let _e460 = nVal_3;
                        let _e461 = atomicCompareExchangeWeak((&unnamed.grid[_e457]), _e460, 0u);
                        let _e463 = nVal_3;
                        if (_e461.old_value == _e463) {
                            let _e465 = (*currentIndex_10);
                            let _e469 = tuning.sandWaterAbsorbUnit;
                            let _e472 = atomicAdd((&unnamed.grid[_e465]), (_e469 << bitcast<u32>(24i)));
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
                let _e473 = i_18;
                i_18 = (_e473 + 1i);
            }
        }
    }
    let _e475 = moistureModified;
    let _e477 = moisture_4;
    if (!(_e475) && (_e477 > 0u)) {
        let _e480 = (*randVal_10);
        d_12 = i32((fract((_e480 * 31f)) * 6f));
        let _e485 = (*pos_15);
        let _e486 = d_12;
        param_580 = _e486;
        let _e487 = getOrthoDir_u0028_i1_u003b((&param_580));
        nPos_5 = (_e485 + _e487);
        let _e490 = nPos_5[0u];
        let _e491 = (_e490 > 0i);
        phi_3694_ = _e491;
        if _e491 {
            let _e493 = nPos_5[0u];
            let _e495 = tuning.gridWidth;
            phi_3694_ = (_e493 < (bitcast<i32>(_e495) - 1i));
        }
        let _e500 = phi_3694_;
        phi_3700_ = _e500;
        if _e500 {
            let _e502 = nPos_5[1u];
            phi_3700_ = (_e502 > 0i);
        }
        let _e505 = phi_3700_;
        phi_3710_ = _e505;
        if _e505 {
            let _e507 = nPos_5[1u];
            let _e509 = tuning.gridHeight;
            phi_3710_ = (_e507 < (bitcast<i32>(_e509) - 1i));
        }
        let _e514 = phi_3710_;
        phi_3716_ = _e514;
        if _e514 {
            let _e516 = nPos_5[2u];
            phi_3716_ = (_e516 > 0i);
        }
        let _e519 = phi_3716_;
        phi_3726_ = _e519;
        if _e519 {
            let _e521 = nPos_5[2u];
            let _e523 = tuning.gridDepth;
            phi_3726_ = (_e521 < (bitcast<i32>(_e523) - 1i));
        }
        let _e528 = phi_3726_;
        if _e528 {
            let _e529 = nPos_5;
            param_581 = _e529;
            let _e530 = getIndex_u0028_vi3_u003b((&param_581));
            nIndex_4 = _e530;
            let _e531 = nIndex_4;
            param_582 = _e531;
            let _e532 = readCell_u0028_u1_u003b((&param_582));
            nVal_4 = _e532;
            let _e533 = nVal_4;
            param_583 = _e533;
            let _e534 = getType_u0028_u1_u003b((&param_583));
            nType_3 = _e534;
            let _e535 = nType_3;
            let _e537 = nType_3;
            if ((_e535 == 4u) || (_e537 == 1u)) {
                let _e540 = nVal_4;
                param_584 = _e540;
                let _e541 = getAge_u0028_u1_u003b((&param_584));
                nMoisture = _e541;
                let _e542 = nType_3;
                if (_e542 == 4u) {
                    let _e545 = tuning.dirtMoistureCapacity;
                    local_21 = _e545;
                } else {
                    let _e547 = tuning.sandMoistureCapacity;
                    local_21 = _e547;
                }
                let _e548 = local_21;
                nCapacity = _e548;
                let _e549 = moisture_4;
                let _e550 = nMoisture;
                let _e553 = nMoisture;
                let _e554 = nCapacity;
                if ((_e549 > (_e550 + 1u)) && (_e553 < _e554)) {
                    let _e557 = (*currentIndex_10);
                    let _e560 = atomicAdd((&unnamed.grid[_e557]), 4278190080u);
                    let _e561 = nIndex_4;
                    let _e564 = atomicAdd((&unnamed.grid[_e561]), 16777216u);
                    moistureModified = true;
                }
            }
        }
    }
    let _e565 = moistureModified;
    if _e565 {
        return;
    }
    let _e566 = (*pos_15);
    param_585 = _e566;
    let _e567 = grainCanMove_u0028_vi3_u003b((&param_585));
    canMove = _e567;
    isClumped = false;
    let _e568 = canMove;
    phi_3796_ = _e568;
    if _e568 {
        let _e569 = (*currentSleep_5);
        let _e571 = tuning.wakeSleepThreshold;
        phi_3796_ = (_e569 > _e571);
    }
    let _e574 = phi_3796_;
    if _e574 {
        emptyBelowCount = 0i;
        let _e576 = (*pos_15)[1u];
        if (_e576 > 1i) {
            x = -1i;
            loop {
                let _e578 = x;
                if (_e578 <= 1i) {
                    z = -1i;
                    loop {
                        let _e580 = z;
                        if (_e580 <= 1i) {
                            let _e582 = (*pos_15);
                            let _e583 = x;
                            let _e584 = z;
                            checkPos_1 = (_e582 + vec3<i32>(_e583, -1i, _e584));
                            let _e588 = checkPos_1[0u];
                            let _e589 = (_e588 >= 0i);
                            phi_3838_ = _e589;
                            if _e589 {
                                let _e591 = checkPos_1[0u];
                                let _e593 = tuning.gridWidth;
                                phi_3838_ = (_e591 < bitcast<i32>(_e593));
                            }
                            let _e597 = phi_3838_;
                            phi_3844_ = _e597;
                            if _e597 {
                                let _e599 = checkPos_1[2u];
                                phi_3844_ = (_e599 >= 0i);
                            }
                            let _e602 = phi_3844_;
                            phi_3853_ = _e602;
                            if _e602 {
                                let _e604 = checkPos_1[2u];
                                let _e606 = tuning.gridDepth;
                                phi_3853_ = (_e604 < bitcast<i32>(_e606));
                            }
                            let _e610 = phi_3853_;
                            if _e610 {
                                let _e611 = checkPos_1;
                                param_586 = _e611;
                                let _e612 = getIndex_u0028_vi3_u003b((&param_586));
                                param_587 = _e612;
                                let _e613 = readCell_u0028_u1_u003b((&param_587));
                                param_588 = _e613;
                                let _e614 = getType_u0028_u1_u003b((&param_588));
                                if (_e614 == 0u) {
                                    let _e616 = emptyBelowCount;
                                    emptyBelowCount = (_e616 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e618 = z;
                            z = (_e618 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e620 = x;
                    x = (_e620 + 1i);
                }
            }
        }
        let _e622 = emptyBelowCount;
        let _e624 = tuning.emptyBelowWakeCount;
        if (_e622 >= bitcast<i32>(_e624)) {
            (*currentSleep_5) = 0u;
        } else {
            clumpCount = 0i;
            x_1 = -1i;
            loop {
                let _e627 = x_1;
                if (_e627 <= 1i) {
                    y = -1i;
                    loop {
                        let _e629 = y;
                        if (_e629 <= 1i) {
                            z_1 = -1i;
                            loop {
                                let _e631 = z_1;
                                if (_e631 <= 1i) {
                                    let _e633 = x_1;
                                    let _e635 = y;
                                    let _e638 = z_1;
                                    if (((_e633 == 0i) && (_e635 == 0i)) && (_e638 == 0i)) {
                                        continue;
                                    }
                                    let _e641 = (*pos_15);
                                    let _e642 = x_1;
                                    let _e643 = y;
                                    let _e644 = z_1;
                                    nPos_6 = (_e641 + vec3<i32>(_e642, _e643, _e644));
                                    let _e648 = nPos_6[0u];
                                    let _e649 = (_e648 >= 0i);
                                    phi_3934_ = _e649;
                                    if _e649 {
                                        let _e651 = nPos_6[0u];
                                        let _e653 = tuning.gridWidth;
                                        phi_3934_ = (_e651 < bitcast<i32>(_e653));
                                    }
                                    let _e657 = phi_3934_;
                                    phi_3940_ = _e657;
                                    if _e657 {
                                        let _e659 = nPos_6[1u];
                                        phi_3940_ = (_e659 >= 0i);
                                    }
                                    let _e662 = phi_3940_;
                                    phi_3949_ = _e662;
                                    if _e662 {
                                        let _e664 = nPos_6[1u];
                                        let _e666 = tuning.gridHeight;
                                        phi_3949_ = (_e664 < bitcast<i32>(_e666));
                                    }
                                    let _e670 = phi_3949_;
                                    phi_3955_ = _e670;
                                    if _e670 {
                                        let _e672 = nPos_6[2u];
                                        phi_3955_ = (_e672 >= 0i);
                                    }
                                    let _e675 = phi_3955_;
                                    phi_3964_ = _e675;
                                    if _e675 {
                                        let _e677 = nPos_6[2u];
                                        let _e679 = tuning.gridDepth;
                                        phi_3964_ = (_e677 < bitcast<i32>(_e679));
                                    }
                                    let _e683 = phi_3964_;
                                    if _e683 {
                                        let _e684 = nPos_6;
                                        param_589 = _e684;
                                        let _e685 = getIndex_u0028_vi3_u003b((&param_589));
                                        param_590 = _e685;
                                        let _e686 = readCell_u0028_u1_u003b((&param_590));
                                        param_591 = _e686;
                                        let _e687 = getType_u0028_u1_u003b((&param_591));
                                        if (_e687 == 4u) {
                                            let _e689 = clumpCount;
                                            clumpCount = (_e689 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e691 = z_1;
                                    z_1 = (_e691 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e693 = y;
                            y = (_e693 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e695 = x_1;
                    x_1 = (_e695 + 1i);
                }
            }
            let _e697 = clumpCount;
            let _e699 = tuning.dirtClumpThreshold;
            if (_e697 >= bitcast<i32>(_e699)) {
                isClumped = true;
            }
        }
    }
    let _e702 = canMove;
    let _e703 = isClumped;
    if (_e702 && !(_e703)) {
        let _e707 = (*pos_15)[1u];
        if (_e707 > 1i) {
            let _e709 = (*pos_15);
            belowPos_6 = (_e709 + vec3<i32>(0i, -1i, 0i));
            let _e711 = belowPos_6;
            param_592 = _e711;
            let _e712 = getIndex_u0028_vi3_u003b((&param_592));
            param_593 = _e712;
            let _e713 = readCell_u0028_u1_u003b((&param_593));
            param_594 = _e713;
            let _e714 = getType_u0028_u1_u003b((&param_594));
            if (_e714 == 0u) {
                let _e716 = belowPos_6;
                param_595 = _e716;
                let _e717 = getIndex_u0028_vi3_u003b((&param_595));
                param_596 = 4u;
                param_597 = 0u;
                param_598 = 0u;
                let _e718 = moisture_4;
                param_599 = _e718;
                let _e719 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_596), (&param_597), (&param_598), (&param_599));
                let _e720 = (*currentIndex_10);
                param_600 = _e720;
                let _e721 = (*rawValue_8);
                param_601 = _e721;
                param_602 = _e717;
                param_603 = _e719;
                let _e722 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_600), (&param_601), (&param_602), (&param_603));
                if _e722 {
                    return;
                }
            }
        }
        let _e724 = (*pos_15)[1u];
        if (_e724 > 1i) {
            let _e726 = (*randVal_10);
            dir_3 = select(-1i, 1i, (fract((_e726 * 10f)) > 0.5f));
            let _e731 = (*randVal_10);
            if (fract((_e731 * 100f)) > 0.5f) {
                let _e735 = (*pos_15);
                let _e736 = dir_3;
                slidePos1_ = (_e735 + vec3<i32>(_e736, -1i, 0i));
                let _e739 = (*pos_15);
                let _e740 = dir_3;
                slidePos2_ = (_e739 + vec3<i32>(0i, -1i, _e740));
            } else {
                let _e743 = (*pos_15);
                let _e744 = dir_3;
                slidePos1_ = (_e743 + vec3<i32>(0i, -1i, _e744));
                let _e747 = (*pos_15);
                let _e748 = dir_3;
                slidePos2_ = (_e747 + vec3<i32>(_e748, -1i, 0i));
            }
            let _e752 = slidePos1_[0u];
            let _e753 = (_e752 > 0i);
            phi_4083_ = _e753;
            if _e753 {
                let _e755 = slidePos1_[0u];
                let _e757 = tuning.gridWidth;
                phi_4083_ = (_e755 < (bitcast<i32>(_e757) - 1i));
            }
            let _e762 = phi_4083_;
            phi_4089_ = _e762;
            if _e762 {
                let _e764 = slidePos1_[2u];
                phi_4089_ = (_e764 > 0i);
            }
            let _e767 = phi_4089_;
            phi_4099_ = _e767;
            if _e767 {
                let _e769 = slidePos1_[2u];
                let _e771 = tuning.gridDepth;
                phi_4099_ = (_e769 < (bitcast<i32>(_e771) - 1i));
            }
            let _e776 = phi_4099_;
            if _e776 {
                let _e777 = slidePos1_;
                param_604 = _e777;
                let _e778 = getIndex_u0028_vi3_u003b((&param_604));
                param_605 = _e778;
                let _e779 = readCell_u0028_u1_u003b((&param_605));
                param_606 = _e779;
                let _e780 = getType_u0028_u1_u003b((&param_606));
                if (_e780 == 0u) {
                    let _e782 = slidePos1_;
                    param_607 = _e782;
                    let _e783 = getIndex_u0028_vi3_u003b((&param_607));
                    param_608 = 4u;
                    param_609 = 0u;
                    param_610 = 0u;
                    let _e784 = moisture_4;
                    param_611 = _e784;
                    let _e785 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_608), (&param_609), (&param_610), (&param_611));
                    let _e786 = (*currentIndex_10);
                    param_612 = _e786;
                    let _e787 = (*rawValue_8);
                    param_613 = _e787;
                    param_614 = _e783;
                    param_615 = _e785;
                    let _e788 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_612), (&param_613), (&param_614), (&param_615));
                    if _e788 {
                        return;
                    }
                }
            }
            let _e790 = slidePos2_[0u];
            let _e791 = (_e790 > 0i);
            phi_4143_ = _e791;
            if _e791 {
                let _e793 = slidePos2_[0u];
                let _e795 = tuning.gridWidth;
                phi_4143_ = (_e793 < (bitcast<i32>(_e795) - 1i));
            }
            let _e800 = phi_4143_;
            phi_4149_ = _e800;
            if _e800 {
                let _e802 = slidePos2_[2u];
                phi_4149_ = (_e802 > 0i);
            }
            let _e805 = phi_4149_;
            phi_4159_ = _e805;
            if _e805 {
                let _e807 = slidePos2_[2u];
                let _e809 = tuning.gridDepth;
                phi_4159_ = (_e807 < (bitcast<i32>(_e809) - 1i));
            }
            let _e814 = phi_4159_;
            if _e814 {
                let _e815 = slidePos2_;
                param_616 = _e815;
                let _e816 = getIndex_u0028_vi3_u003b((&param_616));
                param_617 = _e816;
                let _e817 = readCell_u0028_u1_u003b((&param_617));
                param_618 = _e817;
                let _e818 = getType_u0028_u1_u003b((&param_618));
                if (_e818 == 0u) {
                    let _e820 = slidePos2_;
                    param_619 = _e820;
                    let _e821 = getIndex_u0028_vi3_u003b((&param_619));
                    param_620 = 4u;
                    param_621 = 0u;
                    param_622 = 0u;
                    let _e822 = moisture_4;
                    param_623 = _e822;
                    let _e823 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_620), (&param_621), (&param_622), (&param_623));
                    let _e824 = (*currentIndex_10);
                    param_624 = _e824;
                    let _e825 = (*rawValue_8);
                    param_625 = _e825;
                    param_626 = _e821;
                    param_627 = _e823;
                    let _e826 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_624), (&param_625), (&param_626), (&param_627));
                    if _e826 {
                        return;
                    }
                }
            }
        }
        let _e828 = (*pos_15)[1u];
        if (_e828 > 1i) {
            let _e830 = (*pos_15);
            belowPos_7 = (_e830 + vec3<i32>(0i, -1i, 0i));
            let _e832 = belowPos_7;
            param_628 = _e832;
            let _e833 = getIndex_u0028_vi3_u003b((&param_628));
            belowIndex_3 = _e833;
            let _e834 = belowIndex_3;
            param_629 = _e834;
            let _e835 = readCell_u0028_u1_u003b((&param_629));
            belowValue_3 = _e835;
            let _e836 = belowValue_3;
            param_630 = _e836;
            let _e837 = getType_u0028_u1_u003b((&param_630));
            if (_e837 == 2u) {
                let _e839 = (*randVal_10);
                startDir_2 = i32((fract((_e839 * 8f)) * 8f));
                i_19 = 0i;
                loop {
                    let _e844 = i_19;
                    if (_e844 < 8i) {
                        let _e846 = startDir_2;
                        let _e847 = i_19;
                        let _e848 = (_e846 + _e847);
                        d_13 = (_e848 - (i32(floor((f32(_e848) / f32(8i)))) * 8i));
                        let _e856 = belowPos_7;
                        let _e857 = d_13;
                        param_631 = _e857;
                        let _e858 = getHDir_u0028_i1_u003b((&param_631));
                        pushPos = (_e856 + _e858);
                        let _e861 = pushPos[0u];
                        let _e862 = (_e861 > 0i);
                        phi_4250_ = _e862;
                        if _e862 {
                            let _e864 = pushPos[0u];
                            let _e866 = tuning.gridWidth;
                            phi_4250_ = (_e864 < (bitcast<i32>(_e866) - 1i));
                        }
                        let _e871 = phi_4250_;
                        phi_4256_ = _e871;
                        if _e871 {
                            let _e873 = pushPos[2u];
                            phi_4256_ = (_e873 > 0i);
                        }
                        let _e876 = phi_4256_;
                        phi_4266_ = _e876;
                        if _e876 {
                            let _e878 = pushPos[2u];
                            let _e880 = tuning.gridDepth;
                            phi_4266_ = (_e878 < (bitcast<i32>(_e880) - 1i));
                        }
                        let _e885 = phi_4266_;
                        if _e885 {
                            param_632 = 4u;
                            param_633 = 0u;
                            param_634 = 0u;
                            let _e886 = moisture_4;
                            param_635 = _e886;
                            let _e887 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_632), (&param_633), (&param_634), (&param_635));
                            let _e888 = pushPos;
                            param_636 = _e888;
                            let _e889 = getIndex_u0028_vi3_u003b((&param_636));
                            let _e890 = (*currentIndex_10);
                            param_637 = _e890;
                            param_638 = _e887;
                            let _e891 = belowIndex_3;
                            param_639 = _e891;
                            let _e892 = belowValue_3;
                            param_640 = _e892;
                            param_641 = _e889;
                            let _e893 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_637), (&param_638), (&param_639), (&param_640), (&param_641));
                            if _e893 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e894 = i_19;
                        i_19 = (_e894 + 1i);
                    }
                }
                param_642 = 4u;
                param_643 = 0u;
                param_644 = 0u;
                let _e896 = moisture_4;
                param_645 = _e896;
                let _e897 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_642), (&param_643), (&param_644), (&param_645));
                let _e898 = (*currentIndex_10);
                param_646 = _e898;
                let _e899 = (*rawValue_8);
                param_647 = _e899;
                let _e900 = belowIndex_3;
                param_648 = _e900;
                param_649 = _e897;
                let _e901 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_646), (&param_647), (&param_648), (&param_649));
                if _e901 {
                    return;
                }
            }
            let _e902 = (*randVal_10);
            dir_4 = select(-1i, 1i, (fract((_e902 * 10f)) > 0.5f));
            let _e907 = (*randVal_10);
            if (fract((_e907 * 100f)) > 0.5f) {
                let _e911 = (*pos_15);
                let _e912 = dir_4;
                slidePos[0i] = (_e911 + vec3<i32>(_e912, -1i, 0i));
                let _e916 = (*pos_15);
                let _e917 = dir_4;
                slidePos[1i] = (_e916 + vec3<i32>(0i, -1i, _e917));
            } else {
                let _e921 = (*pos_15);
                let _e922 = dir_4;
                slidePos[0i] = (_e921 + vec3<i32>(0i, -1i, _e922));
                let _e926 = (*pos_15);
                let _e927 = dir_4;
                slidePos[1i] = (_e926 + vec3<i32>(_e927, -1i, 0i));
            }
            s_2 = 0i;
            loop {
                let _e931 = s_2;
                if (_e931 < 2i) {
                    let _e933 = s_2;
                    let _e935 = slidePos[_e933];
                    sPos_2 = _e935;
                    let _e937 = sPos_2[0u];
                    let _e938 = (_e937 > 0i);
                    phi_4367_ = _e938;
                    if _e938 {
                        let _e940 = sPos_2[0u];
                        let _e942 = tuning.gridWidth;
                        phi_4367_ = (_e940 < (bitcast<i32>(_e942) - 1i));
                    }
                    let _e947 = phi_4367_;
                    phi_4373_ = _e947;
                    if _e947 {
                        let _e949 = sPos_2[2u];
                        phi_4373_ = (_e949 > 0i);
                    }
                    let _e952 = phi_4373_;
                    phi_4383_ = _e952;
                    if _e952 {
                        let _e954 = sPos_2[2u];
                        let _e956 = tuning.gridDepth;
                        phi_4383_ = (_e954 < (bitcast<i32>(_e956) - 1i));
                    }
                    let _e961 = phi_4383_;
                    if _e961 {
                        let _e962 = sPos_2;
                        param_650 = _e962;
                        let _e963 = getIndex_u0028_vi3_u003b((&param_650));
                        sIndex = _e963;
                        let _e964 = sIndex;
                        param_651 = _e964;
                        let _e965 = readCell_u0028_u1_u003b((&param_651));
                        sValue = _e965;
                        let _e966 = sValue;
                        param_652 = _e966;
                        let _e967 = getType_u0028_u1_u003b((&param_652));
                        if (_e967 == 2u) {
                            let _e969 = (*randVal_10);
                            let _e971 = s_2;
                            startDir_3 = i32((fract(((_e969 * 8f) + f32(_e971))) * 8f));
                            i_20 = 0i;
                            loop {
                                let _e977 = i_20;
                                if (_e977 < 8i) {
                                    let _e979 = startDir_3;
                                    let _e980 = i_20;
                                    let _e981 = (_e979 + _e980);
                                    d_14 = (_e981 - (i32(floor((f32(_e981) / f32(8i)))) * 8i));
                                    let _e989 = sPos_2;
                                    let _e990 = d_14;
                                    param_653 = _e990;
                                    let _e991 = getHDir_u0028_i1_u003b((&param_653));
                                    pushPos_1 = (_e989 + _e991);
                                    let _e994 = pushPos_1[0u];
                                    let _e995 = (_e994 > 0i);
                                    phi_4440_ = _e995;
                                    if _e995 {
                                        let _e997 = pushPos_1[0u];
                                        let _e999 = tuning.gridWidth;
                                        phi_4440_ = (_e997 < (bitcast<i32>(_e999) - 1i));
                                    }
                                    let _e1004 = phi_4440_;
                                    phi_4446_ = _e1004;
                                    if _e1004 {
                                        let _e1006 = pushPos_1[2u];
                                        phi_4446_ = (_e1006 > 0i);
                                    }
                                    let _e1009 = phi_4446_;
                                    phi_4456_ = _e1009;
                                    if _e1009 {
                                        let _e1011 = pushPos_1[2u];
                                        let _e1013 = tuning.gridDepth;
                                        phi_4456_ = (_e1011 < (bitcast<i32>(_e1013) - 1i));
                                    }
                                    let _e1018 = phi_4456_;
                                    if _e1018 {
                                        param_654 = 4u;
                                        param_655 = 0u;
                                        param_656 = 0u;
                                        let _e1019 = moisture_4;
                                        param_657 = _e1019;
                                        let _e1020 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_654), (&param_655), (&param_656), (&param_657));
                                        let _e1021 = pushPos_1;
                                        param_658 = _e1021;
                                        let _e1022 = getIndex_u0028_vi3_u003b((&param_658));
                                        let _e1023 = (*currentIndex_10);
                                        param_659 = _e1023;
                                        param_660 = _e1020;
                                        let _e1024 = sIndex;
                                        param_661 = _e1024;
                                        let _e1025 = sValue;
                                        param_662 = _e1025;
                                        param_663 = _e1022;
                                        let _e1026 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_659), (&param_660), (&param_661), (&param_662), (&param_663));
                                        if _e1026 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1027 = i_20;
                                    i_20 = (_e1027 + 1i);
                                }
                            }
                            param_664 = 4u;
                            param_665 = 0u;
                            param_666 = 0u;
                            let _e1029 = moisture_4;
                            param_667 = _e1029;
                            let _e1030 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_664), (&param_665), (&param_666), (&param_667));
                            let _e1031 = (*currentIndex_10);
                            param_668 = _e1031;
                            let _e1032 = (*rawValue_8);
                            param_669 = _e1032;
                            let _e1033 = sIndex;
                            param_670 = _e1033;
                            param_671 = _e1030;
                            let _e1034 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_668), (&param_669), (&param_670), (&param_671));
                            if _e1034 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1035 = s_2;
                    s_2 = (_e1035 + 1i);
                }
            }
        }
    }
    let _e1037 = (*currentDir_4);
    floraState = _e1037;
    let _e1038 = isClumped;
    phi_4511_ = _e1038;
    if !(_e1038) {
        let _e1040 = (*currentSleep_5);
        let _e1042 = tuning.wakeSleepThreshold;
        phi_4511_ = (_e1040 > _e1042);
    }
    let _e1045 = phi_4511_;
    if _e1045 {
        let _e1046 = (*pos_15);
        abovePos_1 = (_e1046 + vec3<i32>(0i, 1i, 0i));
        let _e1049 = abovePos_1[1u];
        let _e1051 = tuning.gridHeight;
        aboveInside = (_e1049 < (bitcast<i32>(_e1051) - 1i));
        let _e1055 = abovePos_1;
        param_672 = _e1055;
        let _e1056 = getIndex_u0028_vi3_u003b((&param_672));
        aboveIndex = _e1056;
        let _e1057 = aboveInside;
        if _e1057 {
            let _e1058 = aboveIndex;
            param_673 = _e1058;
            let _e1059 = readCell_u0028_u1_u003b((&param_673));
            param_674 = _e1059;
            let _e1060 = getType_u0028_u1_u003b((&param_674));
            local_22 = _e1060;
        } else {
            local_22 = 0u;
        }
        let _e1061 = local_22;
        aboveType = _e1061;
        let _e1062 = aboveType;
        if (_e1062 == 20u) {
        } else {
            let _e1064 = aboveType;
            let _e1066 = aboveType;
            if ((_e1064 == 0u) || (_e1066 == 18u)) {
                let _e1069 = moisture_4;
                let _e1071 = floraState;
                if ((_e1069 >= 5u) && (_e1071 < 100u)) {
                    let _e1074 = (*randVal_10);
                    let _e1078 = tuning.grassGrowChance;
                    if (fract((_e1074 * 55f)) < _e1078) {
                        let _e1080 = floraState;
                        floraState = (_e1080 + bitcast<u32>(1i));
                        let _e1083 = floraState;
                        let _e1085 = aboveType;
                        let _e1088 = aboveInside;
                        let _e1089 = (((_e1083 == 100u) && (_e1085 == 0u)) && _e1088);
                        phi_4591_ = _e1089;
                        if _e1089 {
                            let _e1090 = (*randVal_10);
                            let _e1094 = tuning.treeBloomChance;
                            phi_4591_ = (fract((_e1090 * 97f)) < _e1094);
                        }
                        let _e1097 = phi_4591_;
                        if _e1097 {
                            let _e1098 = aboveIndex;
                            param_675 = 18u;
                            param_676 = 0u;
                            param_677 = 0u;
                            param_678 = 0u;
                            let _e1101 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_675), (&param_676), (&param_677), (&param_678));
                            let _e1102 = atomicCompareExchangeWeak((&unnamed.grid[_e1098]), 0u, _e1101);
                        }
                    }
                }
                let _e1104 = floraState;
                if (_e1104 > 100u) {
                    floraState = 100u;
                }
            } else {
                let _e1106 = aboveType;
                if (_e1106 == 2u) {
                    let _e1108 = floraState;
                    if (_e1108 > 0u) {
                        let _e1110 = floraState;
                        if (_e1110 <= 100u) {
                            floraState = 101u;
                        }
                        let _e1112 = (*randVal_10);
                        let _e1116 = tuning.grassSubmergedDecayChance;
                        if (fract((_e1112 * 66f)) < _e1116) {
                            let _e1118 = floraState;
                            floraState = (_e1118 + bitcast<u32>(1i));
                        }
                        let _e1121 = floraState;
                        if (_e1121 >= 200u) {
                            floraState = 0u;
                        }
                    }
                } else {
                    let _e1123 = aboveType;
                    let _e1125 = aboveType;
                    let _e1127 = ((_e1123 != 5u) && (_e1125 != 20u));
                    phi_4649_ = _e1127;
                    if _e1127 {
                        let _e1128 = aboveType;
                        param_679 = _e1128;
                        let _e1129 = isLocust_u0028_u1_u003b((&param_679));
                        phi_4649_ = !(_e1129);
                    }
                    let _e1132 = phi_4649_;
                    if _e1132 {
                        floraState = 0u;
                    }
                }
            }
        }
    }
    let _e1133 = (*currentSleep_5);
    newSleep_2 = min((_e1133 + 1u), 255u);
    let _e1136 = (*currentIndex_10);
    let _e1139 = (*rawValue_8);
    param_680 = 4u;
    let _e1140 = floraState;
    param_681 = _e1140;
    let _e1141 = newSleep_2;
    param_682 = _e1141;
    let _e1142 = moisture_4;
    param_683 = _e1142;
    let _e1143 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_680), (&param_681), (&param_682), (&param_683));
    let _e1144 = atomicCompareExchangeWeak((&unnamed.grid[_e1136]), _e1139, _e1143);
    return;
}

fn updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_16: ptr<function, vec3<i32>>, currentIndex_11: ptr<function, u32>, rawValue_9: ptr<function, u32>, currentDir_5: ptr<function, u32>, currentSleep_6: ptr<function, u32>, currentAge_9: ptr<function, u32>, randVal_11: ptr<function, f32>) {
    var wake: bool;
    var param_684: vec3<i32>;
    var param_685: u32;
    var param_686: u32;
    var hasPressure_1: bool;
    var local_23: bool;
    var param_687: vec3<i32>;
    var param_688: u32;
    var param_689: u32;
    var isStackedOnWater: bool;
    var local_24: bool;
    var param_690: vec3<i32>;
    var param_691: u32;
    var param_692: u32;
    var d_15: i32;
    var nPos_7: vec3<i32>;
    var param_693: i32;
    var param_694: vec3<i32>;
    var param_695: u32;
    var param_696: u32;
    var belowNeighbor: u32;
    var param_697: vec3<i32>;
    var param_698: u32;
    var param_699: u32;
    var newAge_2: u32;
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
    var newDir: u32;
    var r_1: f32;
    var diagDir: u32;
    var r_2: f32;
    var stepPos: vec3<i32>;
    var param_712: i32;
    var param_713: vec3<i32>;
    var param_714: u32;
    var param_715: u32;
    var newValue_1: u32;
    var param_716: u32;
    var param_717: u32;
    var param_718: u32;
    var param_719: u32;
    var param_720: vec3<i32>;
    var param_721: u32;
    var param_722: u32;
    var param_723: u32;
    var param_724: u32;
    var bestDropPos: vec3<i32>;
    var foundDrop: bool;
    var blockedMask_1: u32;
    var startDir_4: i32;
    var waterReach: i32;
    var r_3: i32;
    var i_21: i32;
    var d_16: i32;
    var c_7: vec3<i32>;
    var param_725: i32;
    var param_726: vec3<i32>;
    var param_727: u32;
    var param_728: u32;
    var param_729: vec3<i32>;
    var param_730: u32;
    var param_731: u32;
    var newValue_2: u32;
    var param_732: u32;
    var param_733: u32;
    var param_734: u32;
    var param_735: u32;
    var param_736: vec3<i32>;
    var param_737: u32;
    var param_738: u32;
    var param_739: u32;
    var param_740: u32;
    var hasPressure_2: bool;
    var local_25: bool;
    var param_741: vec3<i32>;
    var param_742: u32;
    var param_743: u32;
    var isStackedOnWater_1: bool;
    var local_26: bool;
    var param_744: vec3<i32>;
    var param_745: u32;
    var param_746: u32;
    var canStepOntoPool: bool;
    var d_17: i32;
    var nPos_8: vec3<i32>;
    var param_747: i32;
    var param_748: vec3<i32>;
    var param_749: u32;
    var param_750: u32;
    var param_751: vec3<i32>;
    var param_752: u32;
    var param_753: u32;
    var startSpreadDir: i32;
    var i_22: i32;
    var d_18: i32;
    var targetPos_2: vec3<i32>;
    var param_754: i32;
    var param_755: vec3<i32>;
    var param_756: u32;
    var param_757: u32;
    var newValue_3: u32;
    var param_758: u32;
    var param_759: u32;
    var param_760: u32;
    var param_761: u32;
    var param_762: vec3<i32>;
    var param_763: u32;
    var param_764: u32;
    var param_765: u32;
    var param_766: u32;
    var newSleep_3: u32;
    var sleepValue: u32;
    var param_767: u32;
    var param_768: u32;
    var param_769: u32;
    var param_770: u32;
    var phi_4689_: bool;
    var phi_4759_: bool;
    var phi_4765_: bool;
    var phi_4775_: bool;
    var phi_4961_: bool;
    var phi_4967_: bool;
    var phi_4977_: bool;
    var phi_5092_: bool;
    var phi_5099_: bool;
    var phi_5110_: bool;
    var phi_5122_: bool;
    var phi_5144_: bool;
    var phi_5248_: bool;
    var phi_5254_: bool;
    var phi_5264_: bool;
    var phi_5280_: bool;
    var phi_5292_: bool;
    var phi_5342_: bool;
    var phi_5348_: bool;
    var phi_5358_: bool;

    let _e348 = (*currentSleep_6);
    let _e350 = tuning.wakeSleepThreshold;
    if (_e348 > _e350) {
        wake = false;
        let _e353 = (*pos_16)[1u];
        let _e354 = (_e353 > 1i);
        phi_4689_ = _e354;
        if _e354 {
            let _e355 = (*pos_16);
            param_684 = (_e355 + vec3<i32>(0i, -1i, 0i));
            let _e357 = getIndex_u0028_vi3_u003b((&param_684));
            param_685 = _e357;
            let _e358 = readCell_u0028_u1_u003b((&param_685));
            param_686 = _e358;
            let _e359 = getType_u0028_u1_u003b((&param_686));
            phi_4689_ = (_e359 == 0u);
        }
        let _e362 = phi_4689_;
        if _e362 {
            wake = true;
        } else {
            let _e364 = (*pos_16)[1u];
            let _e366 = tuning.gridHeight;
            if (_e364 < (bitcast<i32>(_e366) - 2i)) {
                let _e370 = (*pos_16);
                param_687 = (_e370 + vec3<i32>(0i, 1i, 0i));
                let _e372 = getIndex_u0028_vi3_u003b((&param_687));
                param_688 = _e372;
                let _e373 = readCell_u0028_u1_u003b((&param_688));
                param_689 = _e373;
                let _e374 = getType_u0028_u1_u003b((&param_689));
                local_23 = (_e374 != 0u);
            } else {
                local_23 = false;
            }
            let _e376 = local_23;
            hasPressure_1 = _e376;
            let _e378 = (*pos_16)[1u];
            if (_e378 > 1i) {
                let _e380 = (*pos_16);
                param_690 = (_e380 + vec3<i32>(0i, -1i, 0i));
                let _e382 = getIndex_u0028_vi3_u003b((&param_690));
                param_691 = _e382;
                let _e383 = readCell_u0028_u1_u003b((&param_691));
                param_692 = _e383;
                let _e384 = getType_u0028_u1_u003b((&param_692));
                local_24 = (_e384 == 2u);
            } else {
                local_24 = false;
            }
            let _e386 = local_24;
            isStackedOnWater = _e386;
            d_15 = 0i;
            loop {
                let _e387 = d_15;
                if (_e387 < 8i) {
                    let _e389 = (*pos_16);
                    let _e390 = d_15;
                    param_693 = _e390;
                    let _e391 = getHDir_u0028_i1_u003b((&param_693));
                    nPos_7 = (_e389 + _e391);
                    let _e394 = nPos_7[0u];
                    let _e395 = (_e394 > 0i);
                    phi_4759_ = _e395;
                    if _e395 {
                        let _e397 = nPos_7[0u];
                        let _e399 = tuning.gridWidth;
                        phi_4759_ = (_e397 < (bitcast<i32>(_e399) - 1i));
                    }
                    let _e404 = phi_4759_;
                    phi_4765_ = _e404;
                    if _e404 {
                        let _e406 = nPos_7[2u];
                        phi_4765_ = (_e406 > 0i);
                    }
                    let _e409 = phi_4765_;
                    phi_4775_ = _e409;
                    if _e409 {
                        let _e411 = nPos_7[2u];
                        let _e413 = tuning.gridDepth;
                        phi_4775_ = (_e411 < (bitcast<i32>(_e413) - 1i));
                    }
                    let _e418 = phi_4775_;
                    if _e418 {
                        let _e419 = nPos_7;
                        param_694 = _e419;
                        let _e420 = getIndex_u0028_vi3_u003b((&param_694));
                        param_695 = _e420;
                        let _e421 = readCell_u0028_u1_u003b((&param_695));
                        param_696 = _e421;
                        let _e422 = getType_u0028_u1_u003b((&param_696));
                        if (_e422 == 0u) {
                            let _e424 = nPos_7;
                            param_697 = (_e424 + vec3<i32>(0i, -1i, 0i));
                            let _e426 = getIndex_u0028_vi3_u003b((&param_697));
                            param_698 = _e426;
                            let _e427 = readCell_u0028_u1_u003b((&param_698));
                            param_699 = _e427;
                            let _e428 = getType_u0028_u1_u003b((&param_699));
                            belowNeighbor = _e428;
                            let _e429 = belowNeighbor;
                            let _e431 = hasPressure_1;
                            let _e433 = isStackedOnWater;
                            let _e435 = belowNeighbor;
                            if ((((_e429 == 0u) || _e431) || _e433) || (_e435 == 2u)) {
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
                    let _e438 = d_15;
                    d_15 = (_e438 + 1i);
                }
            }
        }
        let _e440 = wake;
        if !(_e440) {
            return;
        }
        (*currentSleep_6) = 0u;
        (*currentAge_9) = 0u;
    }
    let _e442 = (*currentAge_9);
    newAge_2 = (_e442 + 1u);
    let _e445 = (*pos_16)[1u];
    if (_e445 > 1i) {
        let _e447 = (*pos_16);
        belowPos_8 = (_e447 + vec3<i32>(0i, -1i, 0i));
        let _e449 = belowPos_8;
        param_700 = _e449;
        let _e450 = getIndex_u0028_vi3_u003b((&param_700));
        param_701 = _e450;
        let _e451 = readCell_u0028_u1_u003b((&param_701));
        param_702 = _e451;
        let _e452 = getType_u0028_u1_u003b((&param_702));
        if (_e452 == 0u) {
            let _e454 = belowPos_8;
            param_703 = _e454;
            let _e455 = getIndex_u0028_vi3_u003b((&param_703));
            param_704 = 2u;
            param_705 = 0u;
            param_706 = 0u;
            let _e456 = newAge_2;
            param_707 = _e456;
            let _e457 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_704), (&param_705), (&param_706), (&param_707));
            let _e458 = (*currentIndex_11);
            param_708 = _e458;
            let _e459 = (*rawValue_9);
            param_709 = _e459;
            param_710 = _e455;
            param_711 = _e457;
            let _e460 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_708), (&param_709), (&param_710), (&param_711));
            if _e460 {
                return;
            }
        }
    }
    let _e461 = (*currentDir_5);
    newDir = _e461;
    let _e462 = newDir;
    let _e464 = newDir;
    if ((_e462 == 0u) || (_e464 == 9u)) {
        let _e467 = (*randVal_11);
        r_1 = fract((_e467 * 77f));
        let _e470 = r_1;
        if (_e470 < 0.25f) {
            newDir = 1u;
        } else {
            let _e472 = r_1;
            if (_e472 < 0.5f) {
                newDir = 2u;
            } else {
                let _e474 = r_1;
                if (_e474 < 0.75f) {
                    newDir = 3u;
                } else {
                    newDir = 4u;
                }
            }
        }
    }
    let _e476 = newAge_2;
    let _e479 = newAge_2;
    if (((_e476 % 3u) == 0u) && (_e479 > 0u)) {
        let _e482 = newDir;
        diagDir = _e482;
        let _e483 = diagDir;
        let _e485 = diagDir;
        if ((_e483 >= 1u) && (_e485 <= 4u)) {
            let _e488 = (*randVal_11);
            r_2 = fract((_e488 * 133f));
            let _e491 = diagDir;
            if (_e491 == 1u) {
                let _e493 = r_2;
                diagDir = select(6u, 5u, (_e493 > 0.5f));
            } else {
                let _e496 = diagDir;
                if (_e496 == 2u) {
                    let _e498 = r_2;
                    diagDir = select(8u, 7u, (_e498 > 0.5f));
                } else {
                    let _e501 = diagDir;
                    if (_e501 == 3u) {
                        let _e503 = r_2;
                        diagDir = select(7u, 5u, (_e503 > 0.5f));
                    } else {
                        let _e506 = diagDir;
                        if (_e506 == 4u) {
                            let _e508 = r_2;
                            diagDir = select(8u, 6u, (_e508 > 0.5f));
                        }
                    }
                }
            }
        }
        let _e511 = (*pos_16);
        let _e512 = diagDir;
        param_712 = (bitcast<i32>(_e512) - 1i);
        let _e515 = getHDir_u0028_i1_u003b((&param_712));
        stepPos = (_e511 + _e515);
        let _e518 = stepPos[0u];
        let _e519 = (_e518 > 0i);
        phi_4961_ = _e519;
        if _e519 {
            let _e521 = stepPos[0u];
            let _e523 = tuning.gridWidth;
            phi_4961_ = (_e521 < (bitcast<i32>(_e523) - 1i));
        }
        let _e528 = phi_4961_;
        phi_4967_ = _e528;
        if _e528 {
            let _e530 = stepPos[2u];
            phi_4967_ = (_e530 > 0i);
        }
        let _e533 = phi_4967_;
        phi_4977_ = _e533;
        if _e533 {
            let _e535 = stepPos[2u];
            let _e537 = tuning.gridDepth;
            phi_4977_ = (_e535 < (bitcast<i32>(_e537) - 1i));
        }
        let _e542 = phi_4977_;
        if _e542 {
            let _e543 = stepPos;
            param_713 = _e543;
            let _e544 = getIndex_u0028_vi3_u003b((&param_713));
            param_714 = _e544;
            let _e545 = readCell_u0028_u1_u003b((&param_714));
            param_715 = _e545;
            let _e546 = getType_u0028_u1_u003b((&param_715));
            if (_e546 == 0u) {
                param_716 = 2u;
                let _e548 = newDir;
                param_717 = _e548;
                param_718 = 0u;
                let _e549 = newAge_2;
                param_719 = _e549;
                let _e550 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_716), (&param_717), (&param_718), (&param_719));
                newValue_1 = _e550;
                let _e551 = stepPos;
                param_720 = _e551;
                let _e552 = getIndex_u0028_vi3_u003b((&param_720));
                let _e553 = (*currentIndex_11);
                param_721 = _e553;
                let _e554 = (*rawValue_9);
                param_722 = _e554;
                param_723 = _e552;
                let _e555 = newValue_1;
                param_724 = _e555;
                let _e556 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_721), (&param_722), (&param_723), (&param_724));
                if _e556 {
                    return;
                }
            }
        }
    }
    let _e557 = (*pos_16);
    bestDropPos = _e557;
    foundDrop = false;
    blockedMask_1 = 0u;
    let _e558 = (*randVal_11);
    startDir_4 = i32((fract((_e558 * 8f)) * 8f));
    let _e564 = tuning.waterSpreadRadius;
    let _e566 = tuning.gridWidth;
    let _e569 = tuning.gridHeight;
    waterReach = bitcast<i32>(clamp(_e564, 1u, bitcast<u32>(max(bitcast<i32>(_e566), bitcast<i32>(_e569)))));
    r_3 = 1i;
    loop {
        let _e575 = r_3;
        let _e576 = waterReach;
        if (_e575 <= _e576) {
            let _e578 = blockedMask_1;
            if (_e578 == 255u) {
                break;
            }
            i_21 = 0i;
            loop {
                let _e580 = i_21;
                if (_e580 < 8i) {
                    let _e582 = startDir_4;
                    let _e583 = i_21;
                    let _e584 = (_e582 + _e583);
                    d_16 = (_e584 - (i32(floor((f32(_e584) / f32(8i)))) * 8i));
                    let _e592 = blockedMask_1;
                    let _e593 = d_16;
                    if ((_e592 & (1u << bitcast<u32>(_e593))) == 0u) {
                        let _e598 = (*pos_16);
                        let _e599 = d_16;
                        param_725 = _e599;
                        let _e600 = getHDir_u0028_i1_u003b((&param_725));
                        let _e601 = r_3;
                        c_7 = (_e598 + (_e600 * vec3(_e601)));
                        let _e606 = c_7[0u];
                        let _e607 = (_e606 <= 0i);
                        phi_5092_ = _e607;
                        if !(_e607) {
                            let _e610 = c_7[0u];
                            let _e612 = tuning.gridWidth;
                            phi_5092_ = (_e610 >= (bitcast<i32>(_e612) - 1i));
                        }
                        let _e617 = phi_5092_;
                        phi_5099_ = _e617;
                        if !(_e617) {
                            let _e620 = c_7[2u];
                            phi_5099_ = (_e620 <= 0i);
                        }
                        let _e623 = phi_5099_;
                        phi_5110_ = _e623;
                        if !(_e623) {
                            let _e626 = c_7[2u];
                            let _e628 = tuning.gridDepth;
                            phi_5110_ = (_e626 >= (bitcast<i32>(_e628) - 1i));
                        }
                        let _e633 = phi_5110_;
                        phi_5122_ = _e633;
                        if !(_e633) {
                            let _e635 = c_7;
                            param_726 = _e635;
                            let _e636 = getIndex_u0028_vi3_u003b((&param_726));
                            param_727 = _e636;
                            let _e637 = readCell_u0028_u1_u003b((&param_727));
                            param_728 = _e637;
                            let _e638 = getType_u0028_u1_u003b((&param_728));
                            phi_5122_ = (_e638 != 0u);
                        }
                        let _e641 = phi_5122_;
                        if _e641 {
                            let _e642 = d_16;
                            let _e645 = blockedMask_1;
                            blockedMask_1 = (_e645 | (1u << bitcast<u32>(_e642)));
                        } else {
                            let _e648 = c_7[1u];
                            let _e649 = (_e648 > 1i);
                            phi_5144_ = _e649;
                            if _e649 {
                                let _e650 = c_7;
                                param_729 = (_e650 + vec3<i32>(0i, -1i, 0i));
                                let _e652 = getIndex_u0028_vi3_u003b((&param_729));
                                param_730 = _e652;
                                let _e653 = readCell_u0028_u1_u003b((&param_730));
                                param_731 = _e653;
                                let _e654 = getType_u0028_u1_u003b((&param_731));
                                phi_5144_ = (_e654 == 0u);
                            }
                            let _e657 = phi_5144_;
                            if _e657 {
                                let _e658 = c_7;
                                bestDropPos = _e658;
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
                    let _e659 = i_21;
                    i_21 = (_e659 + 1i);
                }
            }
            let _e661 = foundDrop;
            if _e661 {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e662 = r_3;
            r_3 = (_e662 + 1i);
        }
    }
    let _e664 = foundDrop;
    if _e664 {
        param_732 = 2u;
        param_733 = 0u;
        param_734 = 0u;
        param_735 = 0u;
        let _e665 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_732), (&param_733), (&param_734), (&param_735));
        newValue_2 = _e665;
        let _e666 = bestDropPos;
        param_736 = _e666;
        let _e667 = getIndex_u0028_vi3_u003b((&param_736));
        let _e668 = (*currentIndex_11);
        param_737 = _e668;
        let _e669 = (*rawValue_9);
        param_738 = _e669;
        param_739 = _e667;
        let _e670 = newValue_2;
        param_740 = _e670;
        let _e671 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_737), (&param_738), (&param_739), (&param_740));
        if _e671 {
            return;
        }
    } else {
        let _e673 = (*pos_16)[1u];
        let _e675 = tuning.gridHeight;
        if (_e673 < (bitcast<i32>(_e675) - 2i)) {
            let _e679 = (*pos_16);
            param_741 = (_e679 + vec3<i32>(0i, 1i, 0i));
            let _e681 = getIndex_u0028_vi3_u003b((&param_741));
            param_742 = _e681;
            let _e682 = readCell_u0028_u1_u003b((&param_742));
            param_743 = _e682;
            let _e683 = getType_u0028_u1_u003b((&param_743));
            local_25 = (_e683 != 0u);
        } else {
            local_25 = false;
        }
        let _e685 = local_25;
        hasPressure_2 = _e685;
        let _e687 = (*pos_16)[1u];
        if (_e687 > 1i) {
            let _e689 = (*pos_16);
            param_744 = (_e689 + vec3<i32>(0i, -1i, 0i));
            let _e691 = getIndex_u0028_vi3_u003b((&param_744));
            param_745 = _e691;
            let _e692 = readCell_u0028_u1_u003b((&param_745));
            param_746 = _e692;
            let _e693 = getType_u0028_u1_u003b((&param_746));
            local_26 = (_e693 == 2u);
        } else {
            local_26 = false;
        }
        let _e695 = local_26;
        isStackedOnWater_1 = _e695;
        canStepOntoPool = false;
        d_17 = 0i;
        loop {
            let _e696 = d_17;
            if (_e696 < 8i) {
                let _e698 = (*pos_16);
                let _e699 = d_17;
                param_747 = _e699;
                let _e700 = getHDir_u0028_i1_u003b((&param_747));
                nPos_8 = (_e698 + _e700);
                let _e703 = nPos_8[0u];
                let _e704 = (_e703 > 0i);
                phi_5248_ = _e704;
                if _e704 {
                    let _e706 = nPos_8[0u];
                    let _e708 = tuning.gridWidth;
                    phi_5248_ = (_e706 < (bitcast<i32>(_e708) - 1i));
                }
                let _e713 = phi_5248_;
                phi_5254_ = _e713;
                if _e713 {
                    let _e715 = nPos_8[2u];
                    phi_5254_ = (_e715 > 0i);
                }
                let _e718 = phi_5254_;
                phi_5264_ = _e718;
                if _e718 {
                    let _e720 = nPos_8[2u];
                    let _e722 = tuning.gridDepth;
                    phi_5264_ = (_e720 < (bitcast<i32>(_e722) - 1i));
                }
                let _e727 = phi_5264_;
                if _e727 {
                    let _e728 = nPos_8;
                    param_748 = _e728;
                    let _e729 = getIndex_u0028_vi3_u003b((&param_748));
                    param_749 = _e729;
                    let _e730 = readCell_u0028_u1_u003b((&param_749));
                    param_750 = _e730;
                    let _e731 = getType_u0028_u1_u003b((&param_750));
                    let _e732 = (_e731 == 0u);
                    phi_5280_ = _e732;
                    if _e732 {
                        let _e734 = (*pos_16)[1u];
                        phi_5280_ = (_e734 > 1i);
                    }
                    let _e737 = phi_5280_;
                    phi_5292_ = _e737;
                    if _e737 {
                        let _e738 = nPos_8;
                        param_751 = (_e738 + vec3<i32>(0i, -1i, 0i));
                        let _e740 = getIndex_u0028_vi3_u003b((&param_751));
                        param_752 = _e740;
                        let _e741 = readCell_u0028_u1_u003b((&param_752));
                        param_753 = _e741;
                        let _e742 = getType_u0028_u1_u003b((&param_753));
                        phi_5292_ = (_e742 == 2u);
                    }
                    let _e745 = phi_5292_;
                    if _e745 {
                        canStepOntoPool = true;
                        break;
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e746 = d_17;
                d_17 = (_e746 + 1i);
            }
        }
        let _e748 = hasPressure_2;
        let _e749 = isStackedOnWater_1;
        let _e751 = canStepOntoPool;
        if ((_e748 || _e749) || _e751) {
            let _e753 = (*randVal_11);
            startSpreadDir = i32((fract((_e753 * 8f)) * 8f));
            i_22 = 0i;
            loop {
                let _e758 = i_22;
                if (_e758 < 8i) {
                    let _e760 = startSpreadDir;
                    let _e761 = i_22;
                    let _e762 = (_e760 + _e761);
                    d_18 = (_e762 - (i32(floor((f32(_e762) / f32(8i)))) * 8i));
                    let _e770 = (*pos_16);
                    let _e771 = d_18;
                    param_754 = _e771;
                    let _e772 = getHDir_u0028_i1_u003b((&param_754));
                    targetPos_2 = (_e770 + _e772);
                    let _e775 = targetPos_2[0u];
                    let _e776 = (_e775 > 0i);
                    phi_5342_ = _e776;
                    if _e776 {
                        let _e778 = targetPos_2[0u];
                        let _e780 = tuning.gridWidth;
                        phi_5342_ = (_e778 < (bitcast<i32>(_e780) - 1i));
                    }
                    let _e785 = phi_5342_;
                    phi_5348_ = _e785;
                    if _e785 {
                        let _e787 = targetPos_2[2u];
                        phi_5348_ = (_e787 > 0i);
                    }
                    let _e790 = phi_5348_;
                    phi_5358_ = _e790;
                    if _e790 {
                        let _e792 = targetPos_2[2u];
                        let _e794 = tuning.gridDepth;
                        phi_5358_ = (_e792 < (bitcast<i32>(_e794) - 1i));
                    }
                    let _e799 = phi_5358_;
                    if _e799 {
                        let _e800 = targetPos_2;
                        param_755 = _e800;
                        let _e801 = getIndex_u0028_vi3_u003b((&param_755));
                        param_756 = _e801;
                        let _e802 = readCell_u0028_u1_u003b((&param_756));
                        param_757 = _e802;
                        let _e803 = getType_u0028_u1_u003b((&param_757));
                        if (_e803 == 0u) {
                            let _e805 = d_18;
                            param_758 = 2u;
                            param_759 = bitcast<u32>((_e805 + 1i));
                            param_760 = 0u;
                            let _e808 = newAge_2;
                            param_761 = _e808;
                            let _e809 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_758), (&param_759), (&param_760), (&param_761));
                            newValue_3 = _e809;
                            let _e810 = targetPos_2;
                            param_762 = _e810;
                            let _e811 = getIndex_u0028_vi3_u003b((&param_762));
                            let _e812 = (*currentIndex_11);
                            param_763 = _e812;
                            let _e813 = (*rawValue_9);
                            param_764 = _e813;
                            param_765 = _e811;
                            let _e814 = newValue_3;
                            param_766 = _e814;
                            let _e815 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_763), (&param_764), (&param_765), (&param_766));
                            if _e815 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e816 = i_22;
                    i_22 = (_e816 + 1i);
                }
            }
        }
    }
    let _e818 = (*currentSleep_6);
    newSleep_3 = min((_e818 + 1u), 255u);
    param_767 = 2u;
    param_768 = 0u;
    let _e821 = newSleep_3;
    param_769 = _e821;
    let _e822 = newAge_2;
    param_770 = _e822;
    let _e823 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_767), (&param_768), (&param_769), (&param_770));
    sleepValue = _e823;
    let _e824 = (*currentIndex_11);
    let _e827 = (*rawValue_9);
    let _e828 = sleepValue;
    let _e829 = atomicCompareExchangeWeak((&unnamed.grid[_e824]), _e827, _e828);
    return;
}

fn incWater_u0028_() {
    let _e215 = atomicAdd((&unnamed_2.waterVoxelCount), 1u);
    return;
}

fn updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_17: ptr<function, vec3<i32>>, currentIndex_12: ptr<function, u32>, rawValue_10: ptr<function, u32>, currentSleep_7: ptr<function, u32>, currentAge_10: ptr<function, u32>, randVal_12: ptr<function, f32>) {
    var moisture_5: u32;
    var moistureModified_1: bool;
    var startDir_5: i32;
    var i_23: i32;
    var d_19: i32;
    var nPos_9: vec3<i32>;
    var param_771: i32;
    var nIndex_5: u32;
    var param_772: vec3<i32>;
    var nVal_5: u32;
    var param_773: u32;
    var param_774: u32;
    var d_20: i32;
    var nPos_10: vec3<i32>;
    var param_775: i32;
    var nIndex_6: u32;
    var param_776: vec3<i32>;
    var nVal_6: u32;
    var param_777: u32;
    var nType_4: u32;
    var param_778: u32;
    var nMoisture_1: u32;
    var param_779: u32;
    var nCapacity_1: u32;
    var local_27: u32;
    var leakPos: vec3<i32>;
    var param_780: vec3<i32>;
    var param_781: u32;
    var param_782: u32;
    var param_783: vec3<i32>;
    var param_784: u32;
    var param_785: u32;
    var param_786: u32;
    var param_787: u32;
    var canMove_1: bool;
    var param_788: vec3<i32>;
    var isClumped_1: bool;
    var emptyBelowCount_1: i32;
    var x_2: i32;
    var z_2: i32;
    var checkPos_2: vec3<i32>;
    var param_789: vec3<i32>;
    var param_790: u32;
    var param_791: u32;
    var clumpCount_1: i32;
    var x_3: i32;
    var y_1: i32;
    var z_3: i32;
    var nPos_11: vec3<i32>;
    var param_792: vec3<i32>;
    var param_793: u32;
    var param_794: u32;
    var belowPos_9: vec3<i32>;
    var param_795: vec3<i32>;
    var param_796: u32;
    var param_797: u32;
    var param_798: vec3<i32>;
    var param_799: u32;
    var param_800: u32;
    var param_801: u32;
    var param_802: u32;
    var param_803: u32;
    var param_804: u32;
    var param_805: u32;
    var param_806: u32;
    var dir_5: i32;
    var slidePos1_1: vec3<i32>;
    var slidePos2_1: vec3<i32>;
    var param_807: vec3<i32>;
    var param_808: u32;
    var param_809: u32;
    var param_810: vec3<i32>;
    var param_811: u32;
    var param_812: u32;
    var param_813: u32;
    var param_814: u32;
    var param_815: u32;
    var param_816: u32;
    var param_817: u32;
    var param_818: u32;
    var param_819: vec3<i32>;
    var param_820: u32;
    var param_821: u32;
    var param_822: vec3<i32>;
    var param_823: u32;
    var param_824: u32;
    var param_825: u32;
    var param_826: u32;
    var param_827: u32;
    var param_828: u32;
    var param_829: u32;
    var param_830: u32;
    var belowPos_10: vec3<i32>;
    var belowIndex_4: u32;
    var param_831: vec3<i32>;
    var belowValue_4: u32;
    var param_832: u32;
    var param_833: u32;
    var startDir_6: i32;
    var i_24: i32;
    var d_21: i32;
    var pushPos_2: vec3<i32>;
    var param_834: i32;
    var param_835: u32;
    var param_836: u32;
    var param_837: u32;
    var param_838: u32;
    var param_839: vec3<i32>;
    var param_840: u32;
    var param_841: u32;
    var param_842: u32;
    var param_843: u32;
    var param_844: u32;
    var param_845: u32;
    var param_846: u32;
    var param_847: u32;
    var param_848: u32;
    var param_849: u32;
    var param_850: u32;
    var param_851: u32;
    var param_852: u32;
    var dir_6: i32;
    var slidePos_1: array<vec3<i32>, 2>;
    var s_3: i32;
    var sPos_3: vec3<i32>;
    var sIndex_1: u32;
    var param_853: vec3<i32>;
    var sValue_1: u32;
    var param_854: u32;
    var param_855: u32;
    var startDir_7: i32;
    var i_25: i32;
    var d_22: i32;
    var pushPos_3: vec3<i32>;
    var param_856: i32;
    var param_857: u32;
    var param_858: u32;
    var param_859: u32;
    var param_860: u32;
    var param_861: vec3<i32>;
    var param_862: u32;
    var param_863: u32;
    var param_864: u32;
    var param_865: u32;
    var param_866: u32;
    var param_867: u32;
    var param_868: u32;
    var param_869: u32;
    var param_870: u32;
    var param_871: u32;
    var param_872: u32;
    var param_873: u32;
    var param_874: u32;
    var newSleep_4: u32;
    var param_875: u32;
    var param_876: u32;
    var param_877: u32;
    var param_878: u32;
    var phi_2561_: bool;
    var phi_2567_: bool;
    var phi_2577_: bool;
    var phi_2583_: bool;
    var phi_2593_: bool;
    var phi_2664_: bool;
    var phi_2670_: bool;
    var phi_2680_: bool;
    var phi_2686_: bool;
    var phi_2696_: bool;
    var phi_2760_: bool;
    var phi_2779_: bool;
    var phi_2823_: bool;
    var phi_2865_: bool;
    var phi_2871_: bool;
    var phi_2880_: bool;
    var phi_2962_: bool;
    var phi_2968_: bool;
    var phi_2977_: bool;
    var phi_2983_: bool;
    var phi_2992_: bool;
    var phi_3114_: bool;
    var phi_3120_: bool;
    var phi_3130_: bool;
    var phi_3174_: bool;
    var phi_3180_: bool;
    var phi_3190_: bool;
    var phi_3282_: bool;
    var phi_3288_: bool;
    var phi_3298_: bool;
    var phi_3401_: bool;
    var phi_3407_: bool;
    var phi_3417_: bool;
    var phi_3474_: bool;
    var phi_3480_: bool;
    var phi_3490_: bool;

    let _e378 = (*currentAge_10);
    moisture_5 = _e378;
    moistureModified_1 = false;
    let _e379 = moisture_5;
    let _e381 = tuning.sandMoistureCapacity;
    if (_e379 < _e381) {
        let _e383 = (*randVal_12);
        startDir_5 = i32((fract((_e383 * 17f)) * 6f));
        i_23 = 0i;
        loop {
            let _e388 = i_23;
            if (_e388 < 6i) {
                let _e390 = startDir_5;
                let _e391 = i_23;
                let _e392 = (_e390 + _e391);
                d_19 = (_e392 - (i32(floor((f32(_e392) / f32(6i)))) * 6i));
                let _e400 = d_19;
                if (_e400 != 2i) {
                    let _e402 = (*pos_17);
                    let _e403 = d_19;
                    param_771 = _e403;
                    let _e404 = getOrthoDir_u0028_i1_u003b((&param_771));
                    nPos_9 = (_e402 + _e404);
                    let _e407 = nPos_9[0u];
                    let _e408 = (_e407 > 0i);
                    phi_2561_ = _e408;
                    if _e408 {
                        let _e410 = nPos_9[0u];
                        let _e412 = tuning.gridWidth;
                        phi_2561_ = (_e410 < (bitcast<i32>(_e412) - 1i));
                    }
                    let _e417 = phi_2561_;
                    phi_2567_ = _e417;
                    if _e417 {
                        let _e419 = nPos_9[1u];
                        phi_2567_ = (_e419 > 0i);
                    }
                    let _e422 = phi_2567_;
                    phi_2577_ = _e422;
                    if _e422 {
                        let _e424 = nPos_9[1u];
                        let _e426 = tuning.gridHeight;
                        phi_2577_ = (_e424 < (bitcast<i32>(_e426) - 1i));
                    }
                    let _e431 = phi_2577_;
                    phi_2583_ = _e431;
                    if _e431 {
                        let _e433 = nPos_9[2u];
                        phi_2583_ = (_e433 > 0i);
                    }
                    let _e436 = phi_2583_;
                    phi_2593_ = _e436;
                    if _e436 {
                        let _e438 = nPos_9[2u];
                        let _e440 = tuning.gridDepth;
                        phi_2593_ = (_e438 < (bitcast<i32>(_e440) - 1i));
                    }
                    let _e445 = phi_2593_;
                    if _e445 {
                        let _e446 = nPos_9;
                        param_772 = _e446;
                        let _e447 = getIndex_u0028_vi3_u003b((&param_772));
                        nIndex_5 = _e447;
                        let _e448 = nIndex_5;
                        param_773 = _e448;
                        let _e449 = readCell_u0028_u1_u003b((&param_773));
                        nVal_5 = _e449;
                        let _e450 = nVal_5;
                        param_774 = _e450;
                        let _e451 = getType_u0028_u1_u003b((&param_774));
                        if (_e451 == 2u) {
                            let _e453 = nIndex_5;
                            let _e456 = nVal_5;
                            let _e457 = atomicCompareExchangeWeak((&unnamed.grid[_e453]), _e456, 0u);
                            let _e459 = nVal_5;
                            if (_e457.old_value == _e459) {
                                let _e461 = (*currentIndex_12);
                                let _e465 = tuning.sandWaterAbsorbUnit;
                                let _e468 = atomicAdd((&unnamed.grid[_e461]), (_e465 << bitcast<u32>(24i)));
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
                let _e469 = i_23;
                i_23 = (_e469 + 1i);
            }
        }
    }
    let _e471 = moistureModified_1;
    let _e473 = moisture_5;
    if (!(_e471) && (_e473 > 0u)) {
        let _e476 = (*randVal_12);
        d_20 = i32((fract((_e476 * 31f)) * 6f));
        let _e481 = d_20;
        if (_e481 != 2i) {
            let _e483 = (*pos_17);
            let _e484 = d_20;
            param_775 = _e484;
            let _e485 = getOrthoDir_u0028_i1_u003b((&param_775));
            nPos_10 = (_e483 + _e485);
            let _e488 = nPos_10[0u];
            let _e489 = (_e488 > 0i);
            phi_2664_ = _e489;
            if _e489 {
                let _e491 = nPos_10[0u];
                let _e493 = tuning.gridWidth;
                phi_2664_ = (_e491 < (bitcast<i32>(_e493) - 1i));
            }
            let _e498 = phi_2664_;
            phi_2670_ = _e498;
            if _e498 {
                let _e500 = nPos_10[1u];
                phi_2670_ = (_e500 > 0i);
            }
            let _e503 = phi_2670_;
            phi_2680_ = _e503;
            if _e503 {
                let _e505 = nPos_10[1u];
                let _e507 = tuning.gridHeight;
                phi_2680_ = (_e505 < (bitcast<i32>(_e507) - 1i));
            }
            let _e512 = phi_2680_;
            phi_2686_ = _e512;
            if _e512 {
                let _e514 = nPos_10[2u];
                phi_2686_ = (_e514 > 0i);
            }
            let _e517 = phi_2686_;
            phi_2696_ = _e517;
            if _e517 {
                let _e519 = nPos_10[2u];
                let _e521 = tuning.gridDepth;
                phi_2696_ = (_e519 < (bitcast<i32>(_e521) - 1i));
            }
            let _e526 = phi_2696_;
            if _e526 {
                let _e527 = nPos_10;
                param_776 = _e527;
                let _e528 = getIndex_u0028_vi3_u003b((&param_776));
                nIndex_6 = _e528;
                let _e529 = nIndex_6;
                param_777 = _e529;
                let _e530 = readCell_u0028_u1_u003b((&param_777));
                nVal_6 = _e530;
                let _e531 = nVal_6;
                param_778 = _e531;
                let _e532 = getType_u0028_u1_u003b((&param_778));
                nType_4 = _e532;
                let _e533 = nType_4;
                let _e535 = nType_4;
                if ((_e533 == 1u) || (_e535 == 4u)) {
                    let _e538 = nVal_6;
                    param_779 = _e538;
                    let _e539 = getAge_u0028_u1_u003b((&param_779));
                    nMoisture_1 = _e539;
                    let _e540 = nType_4;
                    if (_e540 == 4u) {
                        let _e543 = tuning.dirtMoistureCapacity;
                        local_27 = _e543;
                    } else {
                        let _e545 = tuning.sandMoistureCapacity;
                        local_27 = _e545;
                    }
                    let _e546 = local_27;
                    nCapacity_1 = _e546;
                    let _e547 = moisture_5;
                    let _e548 = nMoisture_1;
                    let _e551 = nMoisture_1;
                    let _e552 = nCapacity_1;
                    if ((_e547 > (_e548 + 1u)) && (_e551 < _e552)) {
                        let _e555 = (*currentIndex_12);
                        let _e558 = atomicAdd((&unnamed.grid[_e555]), 4278190080u);
                        let _e559 = nIndex_6;
                        let _e562 = atomicAdd((&unnamed.grid[_e559]), 16777216u);
                        moistureModified_1 = true;
                    }
                }
            }
        }
    }
    let _e563 = moistureModified_1;
    let _e564 = !(_e563);
    phi_2760_ = _e564;
    if _e564 {
        let _e565 = moisture_5;
        let _e567 = tuning.sandWaterAbsorbUnit;
        phi_2760_ = (_e565 >= _e567);
    }
    let _e570 = phi_2760_;
    if _e570 {
        let _e571 = (*pos_17);
        leakPos = (_e571 + vec3<i32>(0i, -1i, 0i));
        let _e574 = leakPos[1u];
        let _e575 = (_e574 > 0i);
        phi_2779_ = _e575;
        if _e575 {
            let _e576 = leakPos;
            param_780 = _e576;
            let _e577 = getIndex_u0028_vi3_u003b((&param_780));
            param_781 = _e577;
            let _e578 = readCell_u0028_u1_u003b((&param_781));
            param_782 = _e578;
            let _e579 = getType_u0028_u1_u003b((&param_782));
            phi_2779_ = (_e579 == 0u);
        }
        let _e582 = phi_2779_;
        if _e582 {
            let _e583 = leakPos;
            param_783 = _e583;
            let _e584 = getIndex_u0028_vi3_u003b((&param_783));
            param_784 = 2u;
            param_785 = 0u;
            param_786 = 0u;
            param_787 = 0u;
            let _e587 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_784), (&param_785), (&param_786), (&param_787));
            let _e588 = atomicCompareExchangeWeak((&unnamed.grid[_e584]), 0u, _e587);
            if (_e588.old_value == 0u) {
                let _e591 = (*currentIndex_12);
                let _e595 = tuning.sandWaterAbsorbUnit;
                let _e599 = atomicAdd((&unnamed.grid[_e591]), ((0u - _e595) << bitcast<u32>(24i)));
                incWater_u0028_();
                moistureModified_1 = true;
            }
        }
    }
    let _e600 = moistureModified_1;
    if _e600 {
        return;
    }
    let _e601 = (*pos_17);
    param_788 = _e601;
    let _e602 = grainCanMove_u0028_vi3_u003b((&param_788));
    canMove_1 = _e602;
    isClumped_1 = false;
    let _e603 = canMove_1;
    let _e604 = moisture_5;
    let _e606 = (_e603 && (_e604 > 0u));
    phi_2823_ = _e606;
    if _e606 {
        let _e607 = (*currentSleep_7);
        let _e609 = tuning.wakeSleepThreshold;
        phi_2823_ = (_e607 > _e609);
    }
    let _e612 = phi_2823_;
    if _e612 {
        emptyBelowCount_1 = 0i;
        let _e614 = (*pos_17)[1u];
        if (_e614 > 1i) {
            x_2 = -1i;
            loop {
                let _e616 = x_2;
                if (_e616 <= 1i) {
                    z_2 = -1i;
                    loop {
                        let _e618 = z_2;
                        if (_e618 <= 1i) {
                            let _e620 = (*pos_17);
                            let _e621 = x_2;
                            let _e622 = z_2;
                            checkPos_2 = (_e620 + vec3<i32>(_e621, -1i, _e622));
                            let _e626 = checkPos_2[0u];
                            let _e627 = (_e626 >= 0i);
                            phi_2865_ = _e627;
                            if _e627 {
                                let _e629 = checkPos_2[0u];
                                let _e631 = tuning.gridWidth;
                                phi_2865_ = (_e629 < bitcast<i32>(_e631));
                            }
                            let _e635 = phi_2865_;
                            phi_2871_ = _e635;
                            if _e635 {
                                let _e637 = checkPos_2[2u];
                                phi_2871_ = (_e637 >= 0i);
                            }
                            let _e640 = phi_2871_;
                            phi_2880_ = _e640;
                            if _e640 {
                                let _e642 = checkPos_2[2u];
                                let _e644 = tuning.gridDepth;
                                phi_2880_ = (_e642 < bitcast<i32>(_e644));
                            }
                            let _e648 = phi_2880_;
                            if _e648 {
                                let _e649 = checkPos_2;
                                param_789 = _e649;
                                let _e650 = getIndex_u0028_vi3_u003b((&param_789));
                                param_790 = _e650;
                                let _e651 = readCell_u0028_u1_u003b((&param_790));
                                param_791 = _e651;
                                let _e652 = getType_u0028_u1_u003b((&param_791));
                                if (_e652 == 0u) {
                                    let _e654 = emptyBelowCount_1;
                                    emptyBelowCount_1 = (_e654 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e656 = z_2;
                            z_2 = (_e656 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e658 = x_2;
                    x_2 = (_e658 + 1i);
                }
            }
        }
        let _e660 = emptyBelowCount_1;
        let _e662 = tuning.emptyBelowWakeCount;
        if (_e660 >= bitcast<i32>(_e662)) {
            (*currentSleep_7) = 0u;
        } else {
            clumpCount_1 = 0i;
            x_3 = -1i;
            loop {
                let _e665 = x_3;
                if (_e665 <= 1i) {
                    y_1 = -1i;
                    loop {
                        let _e667 = y_1;
                        if (_e667 <= 1i) {
                            z_3 = -1i;
                            loop {
                                let _e669 = z_3;
                                if (_e669 <= 1i) {
                                    let _e671 = x_3;
                                    let _e673 = y_1;
                                    let _e676 = z_3;
                                    if (((_e671 == 0i) && (_e673 == 0i)) && (_e676 == 0i)) {
                                        continue;
                                    }
                                    let _e679 = (*pos_17);
                                    let _e680 = x_3;
                                    let _e681 = y_1;
                                    let _e682 = z_3;
                                    nPos_11 = (_e679 + vec3<i32>(_e680, _e681, _e682));
                                    let _e686 = nPos_11[0u];
                                    let _e687 = (_e686 >= 0i);
                                    phi_2962_ = _e687;
                                    if _e687 {
                                        let _e689 = nPos_11[0u];
                                        let _e691 = tuning.gridWidth;
                                        phi_2962_ = (_e689 < bitcast<i32>(_e691));
                                    }
                                    let _e695 = phi_2962_;
                                    phi_2968_ = _e695;
                                    if _e695 {
                                        let _e697 = nPos_11[1u];
                                        phi_2968_ = (_e697 >= 0i);
                                    }
                                    let _e700 = phi_2968_;
                                    phi_2977_ = _e700;
                                    if _e700 {
                                        let _e702 = nPos_11[1u];
                                        let _e704 = tuning.gridHeight;
                                        phi_2977_ = (_e702 < bitcast<i32>(_e704));
                                    }
                                    let _e708 = phi_2977_;
                                    phi_2983_ = _e708;
                                    if _e708 {
                                        let _e710 = nPos_11[2u];
                                        phi_2983_ = (_e710 >= 0i);
                                    }
                                    let _e713 = phi_2983_;
                                    phi_2992_ = _e713;
                                    if _e713 {
                                        let _e715 = nPos_11[2u];
                                        let _e717 = tuning.gridDepth;
                                        phi_2992_ = (_e715 < bitcast<i32>(_e717));
                                    }
                                    let _e721 = phi_2992_;
                                    if _e721 {
                                        let _e722 = nPos_11;
                                        param_792 = _e722;
                                        let _e723 = getIndex_u0028_vi3_u003b((&param_792));
                                        param_793 = _e723;
                                        let _e724 = readCell_u0028_u1_u003b((&param_793));
                                        param_794 = _e724;
                                        let _e725 = getType_u0028_u1_u003b((&param_794));
                                        if (_e725 == 1u) {
                                            let _e727 = clumpCount_1;
                                            clumpCount_1 = (_e727 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e729 = z_3;
                                    z_3 = (_e729 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e731 = y_1;
                            y_1 = (_e731 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e733 = x_3;
                    x_3 = (_e733 + 1i);
                }
            }
            let _e735 = clumpCount_1;
            let _e737 = tuning.sandClumpThreshold;
            if (_e735 >= bitcast<i32>(_e737)) {
                isClumped_1 = true;
            }
        }
    }
    let _e740 = canMove_1;
    let _e741 = isClumped_1;
    if (_e740 && !(_e741)) {
        let _e745 = (*pos_17)[1u];
        if (_e745 > 1i) {
            let _e747 = (*pos_17);
            belowPos_9 = (_e747 + vec3<i32>(0i, -1i, 0i));
            let _e749 = belowPos_9;
            param_795 = _e749;
            let _e750 = getIndex_u0028_vi3_u003b((&param_795));
            param_796 = _e750;
            let _e751 = readCell_u0028_u1_u003b((&param_796));
            param_797 = _e751;
            let _e752 = getType_u0028_u1_u003b((&param_797));
            if (_e752 == 0u) {
                let _e754 = belowPos_9;
                param_798 = _e754;
                let _e755 = getIndex_u0028_vi3_u003b((&param_798));
                param_799 = 1u;
                param_800 = 0u;
                param_801 = 0u;
                let _e756 = moisture_5;
                param_802 = _e756;
                let _e757 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_799), (&param_800), (&param_801), (&param_802));
                let _e758 = (*currentIndex_12);
                param_803 = _e758;
                let _e759 = (*rawValue_10);
                param_804 = _e759;
                param_805 = _e755;
                param_806 = _e757;
                let _e760 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_803), (&param_804), (&param_805), (&param_806));
                if _e760 {
                    return;
                }
            }
        }
        let _e762 = (*pos_17)[1u];
        if (_e762 > 1i) {
            let _e764 = (*randVal_12);
            dir_5 = select(-1i, 1i, (fract((_e764 * 10f)) > 0.5f));
            let _e769 = (*randVal_12);
            if (fract((_e769 * 100f)) > 0.5f) {
                let _e773 = (*pos_17);
                let _e774 = dir_5;
                slidePos1_1 = (_e773 + vec3<i32>(_e774, -1i, 0i));
                let _e777 = (*pos_17);
                let _e778 = dir_5;
                slidePos2_1 = (_e777 + vec3<i32>(0i, -1i, _e778));
            } else {
                let _e781 = (*pos_17);
                let _e782 = dir_5;
                slidePos1_1 = (_e781 + vec3<i32>(0i, -1i, _e782));
                let _e785 = (*pos_17);
                let _e786 = dir_5;
                slidePos2_1 = (_e785 + vec3<i32>(_e786, -1i, 0i));
            }
            let _e790 = slidePos1_1[0u];
            let _e791 = (_e790 > 0i);
            phi_3114_ = _e791;
            if _e791 {
                let _e793 = slidePos1_1[0u];
                let _e795 = tuning.gridWidth;
                phi_3114_ = (_e793 < (bitcast<i32>(_e795) - 1i));
            }
            let _e800 = phi_3114_;
            phi_3120_ = _e800;
            if _e800 {
                let _e802 = slidePos1_1[2u];
                phi_3120_ = (_e802 > 0i);
            }
            let _e805 = phi_3120_;
            phi_3130_ = _e805;
            if _e805 {
                let _e807 = slidePos1_1[2u];
                let _e809 = tuning.gridDepth;
                phi_3130_ = (_e807 < (bitcast<i32>(_e809) - 1i));
            }
            let _e814 = phi_3130_;
            if _e814 {
                let _e815 = slidePos1_1;
                param_807 = _e815;
                let _e816 = getIndex_u0028_vi3_u003b((&param_807));
                param_808 = _e816;
                let _e817 = readCell_u0028_u1_u003b((&param_808));
                param_809 = _e817;
                let _e818 = getType_u0028_u1_u003b((&param_809));
                if (_e818 == 0u) {
                    let _e820 = slidePos1_1;
                    param_810 = _e820;
                    let _e821 = getIndex_u0028_vi3_u003b((&param_810));
                    param_811 = 1u;
                    param_812 = 0u;
                    param_813 = 0u;
                    let _e822 = moisture_5;
                    param_814 = _e822;
                    let _e823 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_811), (&param_812), (&param_813), (&param_814));
                    let _e824 = (*currentIndex_12);
                    param_815 = _e824;
                    let _e825 = (*rawValue_10);
                    param_816 = _e825;
                    param_817 = _e821;
                    param_818 = _e823;
                    let _e826 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_815), (&param_816), (&param_817), (&param_818));
                    if _e826 {
                        return;
                    }
                }
            }
            let _e828 = slidePos2_1[0u];
            let _e829 = (_e828 > 0i);
            phi_3174_ = _e829;
            if _e829 {
                let _e831 = slidePos2_1[0u];
                let _e833 = tuning.gridWidth;
                phi_3174_ = (_e831 < (bitcast<i32>(_e833) - 1i));
            }
            let _e838 = phi_3174_;
            phi_3180_ = _e838;
            if _e838 {
                let _e840 = slidePos2_1[2u];
                phi_3180_ = (_e840 > 0i);
            }
            let _e843 = phi_3180_;
            phi_3190_ = _e843;
            if _e843 {
                let _e845 = slidePos2_1[2u];
                let _e847 = tuning.gridDepth;
                phi_3190_ = (_e845 < (bitcast<i32>(_e847) - 1i));
            }
            let _e852 = phi_3190_;
            if _e852 {
                let _e853 = slidePos2_1;
                param_819 = _e853;
                let _e854 = getIndex_u0028_vi3_u003b((&param_819));
                param_820 = _e854;
                let _e855 = readCell_u0028_u1_u003b((&param_820));
                param_821 = _e855;
                let _e856 = getType_u0028_u1_u003b((&param_821));
                if (_e856 == 0u) {
                    let _e858 = slidePos2_1;
                    param_822 = _e858;
                    let _e859 = getIndex_u0028_vi3_u003b((&param_822));
                    param_823 = 1u;
                    param_824 = 0u;
                    param_825 = 0u;
                    let _e860 = moisture_5;
                    param_826 = _e860;
                    let _e861 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_823), (&param_824), (&param_825), (&param_826));
                    let _e862 = (*currentIndex_12);
                    param_827 = _e862;
                    let _e863 = (*rawValue_10);
                    param_828 = _e863;
                    param_829 = _e859;
                    param_830 = _e861;
                    let _e864 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_827), (&param_828), (&param_829), (&param_830));
                    if _e864 {
                        return;
                    }
                }
            }
        }
        let _e866 = (*pos_17)[1u];
        if (_e866 > 1i) {
            let _e868 = (*pos_17);
            belowPos_10 = (_e868 + vec3<i32>(0i, -1i, 0i));
            let _e870 = belowPos_10;
            param_831 = _e870;
            let _e871 = getIndex_u0028_vi3_u003b((&param_831));
            belowIndex_4 = _e871;
            let _e872 = belowIndex_4;
            param_832 = _e872;
            let _e873 = readCell_u0028_u1_u003b((&param_832));
            belowValue_4 = _e873;
            let _e874 = belowValue_4;
            param_833 = _e874;
            let _e875 = getType_u0028_u1_u003b((&param_833));
            if (_e875 == 2u) {
                let _e877 = (*randVal_12);
                startDir_6 = i32((fract((_e877 * 8f)) * 8f));
                i_24 = 0i;
                loop {
                    let _e882 = i_24;
                    if (_e882 < 8i) {
                        let _e884 = startDir_6;
                        let _e885 = i_24;
                        let _e886 = (_e884 + _e885);
                        d_21 = (_e886 - (i32(floor((f32(_e886) / f32(8i)))) * 8i));
                        let _e894 = belowPos_10;
                        let _e895 = d_21;
                        param_834 = _e895;
                        let _e896 = getHDir_u0028_i1_u003b((&param_834));
                        pushPos_2 = (_e894 + _e896);
                        let _e899 = pushPos_2[0u];
                        let _e900 = (_e899 > 0i);
                        phi_3282_ = _e900;
                        if _e900 {
                            let _e902 = pushPos_2[0u];
                            let _e904 = tuning.gridWidth;
                            phi_3282_ = (_e902 < (bitcast<i32>(_e904) - 1i));
                        }
                        let _e909 = phi_3282_;
                        phi_3288_ = _e909;
                        if _e909 {
                            let _e911 = pushPos_2[2u];
                            phi_3288_ = (_e911 > 0i);
                        }
                        let _e914 = phi_3288_;
                        phi_3298_ = _e914;
                        if _e914 {
                            let _e916 = pushPos_2[2u];
                            let _e918 = tuning.gridDepth;
                            phi_3298_ = (_e916 < (bitcast<i32>(_e918) - 1i));
                        }
                        let _e923 = phi_3298_;
                        if _e923 {
                            param_835 = 1u;
                            param_836 = 0u;
                            param_837 = 0u;
                            let _e924 = moisture_5;
                            param_838 = _e924;
                            let _e925 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_835), (&param_836), (&param_837), (&param_838));
                            let _e926 = pushPos_2;
                            param_839 = _e926;
                            let _e927 = getIndex_u0028_vi3_u003b((&param_839));
                            let _e928 = (*currentIndex_12);
                            param_840 = _e928;
                            param_841 = _e925;
                            let _e929 = belowIndex_4;
                            param_842 = _e929;
                            let _e930 = belowValue_4;
                            param_843 = _e930;
                            param_844 = _e927;
                            let _e931 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_840), (&param_841), (&param_842), (&param_843), (&param_844));
                            if _e931 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e932 = i_24;
                        i_24 = (_e932 + 1i);
                    }
                }
                param_845 = 1u;
                param_846 = 0u;
                param_847 = 0u;
                let _e934 = moisture_5;
                param_848 = _e934;
                let _e935 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_845), (&param_846), (&param_847), (&param_848));
                let _e936 = (*currentIndex_12);
                param_849 = _e936;
                let _e937 = (*rawValue_10);
                param_850 = _e937;
                let _e938 = belowIndex_4;
                param_851 = _e938;
                param_852 = _e935;
                let _e939 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_849), (&param_850), (&param_851), (&param_852));
                if _e939 {
                    return;
                }
            }
            let _e940 = (*randVal_12);
            dir_6 = select(-1i, 1i, (fract((_e940 * 10f)) > 0.5f));
            let _e945 = (*randVal_12);
            if (fract((_e945 * 100f)) > 0.5f) {
                let _e949 = (*pos_17);
                let _e950 = dir_6;
                slidePos_1[0i] = (_e949 + vec3<i32>(_e950, -1i, 0i));
                let _e954 = (*pos_17);
                let _e955 = dir_6;
                slidePos_1[1i] = (_e954 + vec3<i32>(0i, -1i, _e955));
            } else {
                let _e959 = (*pos_17);
                let _e960 = dir_6;
                slidePos_1[0i] = (_e959 + vec3<i32>(0i, -1i, _e960));
                let _e964 = (*pos_17);
                let _e965 = dir_6;
                slidePos_1[1i] = (_e964 + vec3<i32>(_e965, -1i, 0i));
            }
            s_3 = 0i;
            loop {
                let _e969 = s_3;
                if (_e969 < 2i) {
                    let _e971 = s_3;
                    let _e973 = slidePos_1[_e971];
                    sPos_3 = _e973;
                    let _e975 = sPos_3[0u];
                    let _e976 = (_e975 > 0i);
                    phi_3401_ = _e976;
                    if _e976 {
                        let _e978 = sPos_3[0u];
                        let _e980 = tuning.gridWidth;
                        phi_3401_ = (_e978 < (bitcast<i32>(_e980) - 1i));
                    }
                    let _e985 = phi_3401_;
                    phi_3407_ = _e985;
                    if _e985 {
                        let _e987 = sPos_3[2u];
                        phi_3407_ = (_e987 > 0i);
                    }
                    let _e990 = phi_3407_;
                    phi_3417_ = _e990;
                    if _e990 {
                        let _e992 = sPos_3[2u];
                        let _e994 = tuning.gridDepth;
                        phi_3417_ = (_e992 < (bitcast<i32>(_e994) - 1i));
                    }
                    let _e999 = phi_3417_;
                    if _e999 {
                        let _e1000 = sPos_3;
                        param_853 = _e1000;
                        let _e1001 = getIndex_u0028_vi3_u003b((&param_853));
                        sIndex_1 = _e1001;
                        let _e1002 = sIndex_1;
                        param_854 = _e1002;
                        let _e1003 = readCell_u0028_u1_u003b((&param_854));
                        sValue_1 = _e1003;
                        let _e1004 = sValue_1;
                        param_855 = _e1004;
                        let _e1005 = getType_u0028_u1_u003b((&param_855));
                        if (_e1005 == 2u) {
                            let _e1007 = (*randVal_12);
                            let _e1009 = s_3;
                            startDir_7 = i32((fract(((_e1007 * 8f) + f32(_e1009))) * 8f));
                            i_25 = 0i;
                            loop {
                                let _e1015 = i_25;
                                if (_e1015 < 8i) {
                                    let _e1017 = startDir_7;
                                    let _e1018 = i_25;
                                    let _e1019 = (_e1017 + _e1018);
                                    d_22 = (_e1019 - (i32(floor((f32(_e1019) / f32(8i)))) * 8i));
                                    let _e1027 = sPos_3;
                                    let _e1028 = d_22;
                                    param_856 = _e1028;
                                    let _e1029 = getHDir_u0028_i1_u003b((&param_856));
                                    pushPos_3 = (_e1027 + _e1029);
                                    let _e1032 = pushPos_3[0u];
                                    let _e1033 = (_e1032 > 0i);
                                    phi_3474_ = _e1033;
                                    if _e1033 {
                                        let _e1035 = pushPos_3[0u];
                                        let _e1037 = tuning.gridWidth;
                                        phi_3474_ = (_e1035 < (bitcast<i32>(_e1037) - 1i));
                                    }
                                    let _e1042 = phi_3474_;
                                    phi_3480_ = _e1042;
                                    if _e1042 {
                                        let _e1044 = pushPos_3[2u];
                                        phi_3480_ = (_e1044 > 0i);
                                    }
                                    let _e1047 = phi_3480_;
                                    phi_3490_ = _e1047;
                                    if _e1047 {
                                        let _e1049 = pushPos_3[2u];
                                        let _e1051 = tuning.gridDepth;
                                        phi_3490_ = (_e1049 < (bitcast<i32>(_e1051) - 1i));
                                    }
                                    let _e1056 = phi_3490_;
                                    if _e1056 {
                                        param_857 = 1u;
                                        param_858 = 0u;
                                        param_859 = 0u;
                                        let _e1057 = moisture_5;
                                        param_860 = _e1057;
                                        let _e1058 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_857), (&param_858), (&param_859), (&param_860));
                                        let _e1059 = pushPos_3;
                                        param_861 = _e1059;
                                        let _e1060 = getIndex_u0028_vi3_u003b((&param_861));
                                        let _e1061 = (*currentIndex_12);
                                        param_862 = _e1061;
                                        param_863 = _e1058;
                                        let _e1062 = sIndex_1;
                                        param_864 = _e1062;
                                        let _e1063 = sValue_1;
                                        param_865 = _e1063;
                                        param_866 = _e1060;
                                        let _e1064 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_862), (&param_863), (&param_864), (&param_865), (&param_866));
                                        if _e1064 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1065 = i_25;
                                    i_25 = (_e1065 + 1i);
                                }
                            }
                            param_867 = 1u;
                            param_868 = 0u;
                            param_869 = 0u;
                            let _e1067 = moisture_5;
                            param_870 = _e1067;
                            let _e1068 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_867), (&param_868), (&param_869), (&param_870));
                            let _e1069 = (*currentIndex_12);
                            param_871 = _e1069;
                            let _e1070 = (*rawValue_10);
                            param_872 = _e1070;
                            let _e1071 = sIndex_1;
                            param_873 = _e1071;
                            param_874 = _e1068;
                            let _e1072 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_871), (&param_872), (&param_873), (&param_874));
                            if _e1072 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1073 = s_3;
                    s_3 = (_e1073 + 1i);
                }
            }
        }
    }
    let _e1075 = (*currentSleep_7);
    newSleep_4 = min((_e1075 + 1u), 255u);
    let _e1078 = (*currentIndex_12);
    let _e1081 = (*rawValue_10);
    param_875 = 1u;
    param_876 = 0u;
    let _e1082 = newSleep_4;
    param_877 = _e1082;
    let _e1083 = moisture_5;
    param_878 = _e1083;
    let _e1084 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_875), (&param_876), (&param_877), (&param_878));
    let _e1085 = atomicCompareExchangeWeak((&unnamed.grid[_e1078]), _e1081, _e1084);
    return;
}

fn orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b(pos_18: ptr<function, vec3<i32>>, currentIndex_13: ptr<function, u32>, rawValue_11: ptr<function, u32>, stepDir: ptr<function, vec3<i32>>) -> bool {
    var target_4: vec3<i32>;
    var targetIndex_3: u32;
    var param_879: vec3<i32>;
    var param_880: u32;
    var param_881: u32;
    var param_882: u32;
    var param_883: u32;
    var param_884: u32;
    var param_885: u32;
    var param_886: u32;
    var param_887: u32;
    var param_888: u32;
    var param_889: u32;
    var param_890: u32;
    var param_891: u32;
    var param_892: u32;
    var phi_1881_: bool;
    var phi_1888_: bool;
    var phi_1899_: bool;
    var phi_1906_: bool;
    var phi_1917_: bool;

    let _e234 = (*stepDir);
    if all((_e234 == vec3<i32>(0i, 0i, 0i))) {
        return false;
    }
    let _e237 = (*pos_18);
    let _e238 = (*stepDir);
    target_4 = (_e237 + _e238);
    let _e241 = target_4[0u];
    let _e242 = (_e241 < 1i);
    phi_1881_ = _e242;
    if !(_e242) {
        let _e245 = target_4[0u];
        let _e247 = tuning.gridWidth;
        phi_1881_ = (_e245 >= (bitcast<i32>(_e247) - 1i));
    }
    let _e252 = phi_1881_;
    phi_1888_ = _e252;
    if !(_e252) {
        let _e255 = target_4[1u];
        phi_1888_ = (_e255 < 1i);
    }
    let _e258 = phi_1888_;
    phi_1899_ = _e258;
    if !(_e258) {
        let _e261 = target_4[1u];
        let _e263 = tuning.gridHeight;
        phi_1899_ = (_e261 >= (bitcast<i32>(_e263) - 1i));
    }
    let _e268 = phi_1899_;
    phi_1906_ = _e268;
    if !(_e268) {
        let _e271 = target_4[2u];
        phi_1906_ = (_e271 < 1i);
    }
    let _e274 = phi_1906_;
    phi_1917_ = _e274;
    if !(_e274) {
        let _e277 = target_4[2u];
        let _e279 = tuning.gridDepth;
        phi_1917_ = (_e277 >= (bitcast<i32>(_e279) - 1i));
    }
    let _e284 = phi_1917_;
    if _e284 {
        return false;
    }
    let _e285 = target_4;
    param_879 = _e285;
    let _e286 = getIndex_u0028_vi3_u003b((&param_879));
    targetIndex_3 = _e286;
    let _e287 = targetIndex_3;
    param_880 = _e287;
    let _e288 = readCell_u0028_u1_u003b((&param_880));
    param_881 = _e288;
    let _e289 = getType_u0028_u1_u003b((&param_881));
    if (_e289 != 0u) {
        return false;
    }
    let _e291 = (*rawValue_11);
    param_882 = _e291;
    let _e292 = getType_u0028_u1_u003b((&param_882));
    let _e293 = (*rawValue_11);
    param_883 = _e293;
    let _e294 = getDir_u0028_u1_u003b((&param_883));
    let _e295 = (*rawValue_11);
    param_884 = _e295;
    let _e296 = getAge_u0028_u1_u003b((&param_884));
    param_885 = _e292;
    param_886 = _e294;
    param_887 = 0u;
    param_888 = _e296;
    let _e297 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_885), (&param_886), (&param_887), (&param_888));
    let _e298 = (*currentIndex_13);
    param_889 = _e298;
    let _e299 = (*rawValue_11);
    param_890 = _e299;
    let _e300 = targetIndex_3;
    param_891 = _e300;
    param_892 = _e297;
    let _e301 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_889), (&param_890), (&param_891), (&param_892));
    return _e301;
}

fn dominantAxis_u0028_vf3_u003b_f1_u003b(dir_7: ptr<function, vec3<f32>>, relative: ptr<function, f32>) -> vec3<i32> {
    var a_1: vec3<f32>;
    var m: f32;

    let _e218 = (*dir_7);
    a_1 = abs(_e218);
    let _e221 = a_1[0u];
    let _e223 = a_1[1u];
    let _e225 = a_1[2u];
    m = max(_e221, max(_e223, _e225));
    let _e228 = m;
    if (_e228 <= 0f) {
        return vec3<i32>(0i, 0i, 0i);
    }
    let _e230 = a_1;
    let _e231 = m;
    let _e232 = (*relative);
    let _e237 = (*dir_7);
    return (select(vec3<i32>(0i, 0i, 0i), vec3<i32>(1i, 1i, 1i), (_e230 >= vec3((_e231 * _e232)))) * vec3<i32>(sign(_e237)));
}

fn bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b(k_1: ptr<function, i32>, planeCount: ptr<function, i32>, seed: ptr<function, f32>) -> vec3<f32> {
    var z_4: f32;
    var r_4: f32;
    var a_2: f32;

    let _e220 = (*k_1);
    let _e223 = (*planeCount);
    z_4 = ((f32(_e220) + 0.5f) / f32(_e223));
    let _e226 = z_4;
    let _e227 = z_4;
    r_4 = sqrt(max(0f, (1f - (_e226 * _e227))));
    let _e232 = (*k_1);
    let _e235 = (*seed);
    a_2 = ((2.399963f * f32(_e232)) + _e235);
    let _e237 = r_4;
    let _e238 = a_2;
    let _e241 = z_4;
    let _e242 = r_4;
    let _e243 = a_2;
    return vec3<f32>((_e237 * cos(_e238)), _e241, (_e242 * sin(_e243)));
}

fn bhOrbitAxis_u0028_vi3_u003b_vi3_u003b(center: ptr<function, vec3<i32>>, pos_19: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radial: vec3<f32>;
    var planeCount_1: i32;
    var seed_1: f32;
    var param_893: vec3<f32>;
    var best: vec3<f32>;
    var bestAlign: f32;
    var bestK: i32;
    var k_2: i32;
    var n_2: vec3<f32>;
    var param_894: i32;
    var param_895: i32;
    var param_896: f32;
    var align: f32;
    var sense: f32;
    var param_897: vec3<f32>;

    let _e231 = (*pos_19);
    let _e232 = (*center);
    radial = normalize(vec3<f32>((_e231 - _e232)));
    let _e237 = tuning.blackHoleOrbitPlanes;
    planeCount_1 = bitcast<i32>(clamp(_e237, 1u, 32u));
    let _e240 = (*center);
    param_893 = (vec3<f32>(_e240) + vec3<f32>(29f, 3f, 71f));
    let _e243 = hash_u0028_vf3_u003b((&param_893));
    seed_1 = (_e243 * 6.28318f);
    best = vec3<f32>(0f, 1f, 0f);
    bestAlign = 2f;
    bestK = 0i;
    k_2 = 0i;
    loop {
        let _e245 = k_2;
        let _e246 = planeCount_1;
        if (_e245 < _e246) {
            let _e248 = k_2;
            param_894 = _e248;
            let _e249 = planeCount_1;
            param_895 = _e249;
            let _e250 = seed_1;
            param_896 = _e250;
            let _e251 = bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b((&param_894), (&param_895), (&param_896));
            n_2 = _e251;
            let _e252 = n_2;
            let _e253 = radial;
            align = abs(dot(_e252, _e253));
            let _e256 = align;
            let _e257 = bestAlign;
            if (_e256 < _e257) {
                let _e259 = align;
                bestAlign = _e259;
                let _e260 = n_2;
                best = _e260;
                let _e261 = k_2;
                bestK = _e261;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e262 = k_2;
            k_2 = (_e262 + 1i);
        }
    }
    let _e264 = (*center);
    let _e266 = bestK;
    param_897 = (vec3<f32>(_e264) + vec3<f32>((f32(_e266) * 13f), 101f, 47f));
    let _e271 = hash_u0028_vf3_u003b((&param_897));
    sense = select(1f, -1f, (_e271 < 0.5f));
    let _e274 = best;
    let _e275 = sense;
    return (_e274 * _e275);
}

fn bhIsPurge_u0028_u1_u003b(code: ptr<function, u32>) -> bool {
    let _e215 = (*code);
    return ((_e215 & 1073741824u) != 0u);
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e215 = (*level);
    return (f32(_e215) + 0.5f);
}

fn updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b(pos_20: ptr<function, vec3<i32>>, currentIndex_14: ptr<function, u32>, rawValue_12: ptr<function, u32>, center_1: ptr<function, vec3<i32>>, slot: ptr<function, i32>, level_1: ptr<function, u32>, purge: ptr<function, bool>, dist_1: ptr<function, f32>, randVal_13: ptr<function, f32>) {
    var type_37: u32;
    var param_898: u32;
    var sleep_1: u32;
    var param_899: u32;
    var param_900: u32;
    var param_901: u32;
    var orbitSpeed: f32;
    var local_28: f32;
    var infallChance: f32;
    var local_29: f32;
    var param_902: u32;
    var param_903: u32;
    var param_904: u32;
    var param_905: u32;
    var param_906: u32;
    var param_907: u32;
    var inward: vec3<f32>;
    var axis: vec3<f32>;
    var param_908: vec3<i32>;
    var param_909: vec3<i32>;
    var tangent: vec3<f32>;
    var tangentLen: f32;
    var axial: f32;
    var grip: vec3<f32>;
    var along: vec3<f32>;
    var pullIn: bool;
    var spiral: vec3<f32>;
    var param_910: vec3<f32>;
    var param_911: f32;
    var param_912: vec3<i32>;
    var param_913: u32;
    var param_914: u32;
    var param_915: vec3<i32>;
    var param_916: vec3<f32>;
    var param_917: f32;
    var param_918: vec3<i32>;
    var param_919: u32;
    var param_920: u32;
    var param_921: vec3<i32>;
    var param_922: vec3<f32>;
    var param_923: f32;
    var param_924: vec3<i32>;
    var param_925: u32;
    var param_926: u32;
    var param_927: vec3<i32>;
    var param_928: vec3<f32>;
    var param_929: f32;
    var param_930: vec3<i32>;
    var param_931: u32;
    var param_932: u32;
    var param_933: vec3<i32>;
    var param_934: vec3<f32>;
    var param_935: f32;
    var param_936: vec3<i32>;
    var param_937: u32;
    var param_938: u32;
    var param_939: vec3<i32>;
    var param_940: vec3<f32>;
    var param_941: f32;
    var param_942: vec3<i32>;
    var param_943: u32;
    var param_944: u32;
    var param_945: vec3<i32>;
    var param_946: u32;
    var param_947: u32;
    var param_948: u32;
    var param_949: u32;
    var param_950: u32;
    var param_951: u32;
    var phi_2180_: bool;

    let _e292 = (*rawValue_12);
    param_898 = _e292;
    let _e293 = getType_u0028_u1_u003b((&param_898));
    type_37 = _e293;
    let _e294 = (*rawValue_12);
    param_899 = _e294;
    let _e295 = getSleep_u0028_u1_u003b((&param_899));
    sleep_1 = _e295;
    let _e296 = (*slot);
    unnamed_2.blackHoleStarve[_e296] = 0u;
    let _e299 = (*dist_1);
    let _e300 = (*level_1);
    param_900 = _e300;
    let _e301 = bhBodyRadius_u0028_u1_u003b((&param_900));
    let _e303 = tuning.blackHoleHorizon;
    if (_e299 <= (_e301 + f32(_e303))) {
        let _e307 = (*currentIndex_14);
        let _e310 = (*rawValue_12);
        let _e311 = atomicCompareExchangeWeak((&unnamed.grid[_e307]), _e310, 0u);
        let _e313 = (*rawValue_12);
        if (_e311.old_value == _e313) {
            let _e315 = (*slot);
            let _e318 = atomicLoad((&unnamed_2.blackHoles[_e315]));
            param_901 = _e318;
            let _e319 = bhIsPurge_u0028_u1_u003b((&param_901));
            if !(_e319) {
                let _e321 = (*slot);
                let _e324 = atomicAdd((&unnamed_2.blackHoleMass[_e321]), 1u);
            }
            let _e325 = type_37;
            if (_e325 == 2u) {
                decWater_u0028_();
            }
        }
        return;
    }
    let _e327 = (*purge);
    if _e327 {
        let _e329 = tuning.purgeOrbitSpeed;
        local_28 = _e329;
    } else {
        let _e331 = tuning.blackHoleOrbitSpeed;
        local_28 = _e331;
    }
    let _e332 = local_28;
    orbitSpeed = _e332;
    let _e333 = (*purge);
    if _e333 {
        let _e335 = tuning.purgeInfall;
        local_29 = _e335;
    } else {
        let _e337 = tuning.blackHoleInfall;
        local_29 = _e337;
    }
    let _e338 = local_29;
    infallChance = _e338;
    let _e339 = (*randVal_13);
    let _e340 = orbitSpeed;
    let _e341 = (*dist_1);
    if (_e339 > clamp((_e340 / sqrt(max(_e341, 1f))), 0f, 1f)) {
        let _e347 = sleep_1;
        if (_e347 != 0u) {
            let _e349 = (*currentIndex_14);
            let _e352 = (*rawValue_12);
            let _e353 = (*rawValue_12);
            param_902 = _e353;
            let _e354 = getDir_u0028_u1_u003b((&param_902));
            let _e355 = (*rawValue_12);
            param_903 = _e355;
            let _e356 = getAge_u0028_u1_u003b((&param_903));
            let _e357 = type_37;
            param_904 = _e357;
            param_905 = _e354;
            param_906 = 0u;
            param_907 = _e356;
            let _e358 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_904), (&param_905), (&param_906), (&param_907));
            let _e359 = atomicCompareExchangeWeak((&unnamed.grid[_e349]), _e352, _e358);
        }
        return;
    }
    let _e361 = (*center_1);
    let _e362 = (*pos_20);
    inward = normalize(vec3<f32>((_e361 - _e362)));
    let _e366 = (*center_1);
    param_908 = _e366;
    let _e367 = (*pos_20);
    param_909 = _e367;
    let _e368 = bhOrbitAxis_u0028_vi3_u003b_vi3_u003b((&param_908), (&param_909));
    axis = _e368;
    let _e369 = axis;
    let _e370 = inward;
    tangent = cross(_e369, _e370);
    let _e372 = tangent;
    tangentLen = length(_e372);
    let _e374 = tangentLen;
    if (_e374 < 0.05f) {
        let _e376 = axis;
        tangent = normalize(cross(_e376, vec3<f32>(0.577f, 0.577f, 0.577f)));
    } else {
        let _e379 = tangentLen;
        let _e380 = tangent;
        tangent = (_e380 / vec3(_e379));
    }
    let _e383 = (*pos_20);
    let _e384 = (*center_1);
    let _e387 = axis;
    axial = dot(vec3<f32>((_e383 - _e384)), _e387);
    let _e389 = axis;
    let _e391 = axial;
    let _e396 = tuning.blackHolePlaneGrip;
    grip = ((-(_e389) * clamp((_e391 * 0.5f), -1f, 1f)) * _e396);
    let _e398 = tangent;
    let _e399 = grip;
    along = normalize((_e398 + _e399));
    let _e402 = (*randVal_13);
    let _e405 = infallChance;
    pullIn = (fract((_e402 * 61f)) < clamp(_e405, 0f, 1f));
    let _e408 = inward;
    let _e409 = tangent;
    spiral = normalize((_e408 + (_e409 * 0.6f)));
    let _e413 = pullIn;
    phi_2180_ = _e413;
    if _e413 {
        let _e414 = spiral;
        param_910 = _e414;
        param_911 = 0.55f;
        let _e415 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_910), (&param_911));
        let _e416 = (*pos_20);
        param_912 = _e416;
        let _e417 = (*currentIndex_14);
        param_913 = _e417;
        let _e418 = (*rawValue_12);
        param_914 = _e418;
        param_915 = _e415;
        let _e419 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_912), (&param_913), (&param_914), (&param_915));
        phi_2180_ = _e419;
    }
    let _e421 = phi_2180_;
    if _e421 {
        return;
    }
    let _e422 = along;
    param_916 = _e422;
    param_917 = 0.55f;
    let _e423 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_916), (&param_917));
    let _e424 = (*pos_20);
    param_918 = _e424;
    let _e425 = (*currentIndex_14);
    param_919 = _e425;
    let _e426 = (*rawValue_12);
    param_920 = _e426;
    param_921 = _e423;
    let _e427 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_918), (&param_919), (&param_920), (&param_921));
    if _e427 {
        return;
    }
    let _e428 = along;
    param_922 = _e428;
    param_923 = 1f;
    let _e429 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_922), (&param_923));
    let _e430 = (*pos_20);
    param_924 = _e430;
    let _e431 = (*currentIndex_14);
    param_925 = _e431;
    let _e432 = (*rawValue_12);
    param_926 = _e432;
    param_927 = _e429;
    let _e433 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_924), (&param_925), (&param_926), (&param_927));
    if _e433 {
        return;
    }
    let _e434 = tangent;
    param_928 = _e434;
    param_929 = 1f;
    let _e435 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_928), (&param_929));
    let _e436 = (*pos_20);
    param_930 = _e436;
    let _e437 = (*currentIndex_14);
    param_931 = _e437;
    let _e438 = (*rawValue_12);
    param_932 = _e438;
    param_933 = _e435;
    let _e439 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_930), (&param_931), (&param_932), (&param_933));
    if _e439 {
        return;
    }
    let _e440 = inward;
    param_934 = _e440;
    param_935 = 0.55f;
    let _e441 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_934), (&param_935));
    let _e442 = (*pos_20);
    param_936 = _e442;
    let _e443 = (*currentIndex_14);
    param_937 = _e443;
    let _e444 = (*rawValue_12);
    param_938 = _e444;
    param_939 = _e441;
    let _e445 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_936), (&param_937), (&param_938), (&param_939));
    if _e445 {
        return;
    }
    let _e446 = inward;
    param_940 = _e446;
    param_941 = 1f;
    let _e447 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_940), (&param_941));
    let _e448 = (*pos_20);
    param_942 = _e448;
    let _e449 = (*currentIndex_14);
    param_943 = _e449;
    let _e450 = (*rawValue_12);
    param_944 = _e450;
    param_945 = _e447;
    let _e451 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_942), (&param_943), (&param_944), (&param_945));
    if _e451 {
        return;
    }
    let _e452 = sleep_1;
    if (_e452 != 0u) {
        let _e454 = (*currentIndex_14);
        let _e457 = (*rawValue_12);
        let _e458 = (*rawValue_12);
        param_946 = _e458;
        let _e459 = getDir_u0028_u1_u003b((&param_946));
        let _e460 = (*rawValue_12);
        param_947 = _e460;
        let _e461 = getAge_u0028_u1_u003b((&param_947));
        let _e462 = type_37;
        param_948 = _e462;
        param_949 = _e459;
        param_950 = 0u;
        param_951 = _e461;
        let _e463 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_948), (&param_949), (&param_950), (&param_951));
        let _e464 = atomicCompareExchangeWeak((&unnamed.grid[_e454]), _e457, _e463);
    }
    return;
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_2: u32;
    var l: u32;
    var r_5: f32;
    var param_952: u32;
    var volume: f32;

    level_2 = 0u;
    l = 1u;
    loop {
        let _e220 = l;
        let _e222 = tuning.blackHoleMaxLevel;
        if (_e220 <= min(_e222, 16u)) {
            let _e225 = l;
            param_952 = _e225;
            let _e226 = bhBodyRadius_u0028_u1_u003b((&param_952));
            r_5 = _e226;
            let _e227 = r_5;
            let _e229 = r_5;
            let _e231 = r_5;
            volume = (((4.18879f * _e227) * _e229) * _e231);
            let _e233 = (*mass);
            let _e236 = tuning.blackHoleGrowthCost;
            let _e237 = volume;
            if (f32(_e233) < (_e236 * _e237)) {
                break;
            }
            let _e240 = l;
            level_2 = _e240;
            continue;
        } else {
            break;
        }
        continuing {
            let _e241 = l;
            l = (_e241 + bitcast<u32>(1i));
        }
    }
    let _e244 = level_2;
    return _e244;
}

fn bhLevelFor_u0028_u1_u003b_u1_u003b(code_1: ptr<function, u32>, mass_1: ptr<function, u32>) -> u32 {
    var param_953: u32;
    var param_954: u32;

    let _e218 = (*code_1);
    param_953 = _e218;
    let _e219 = bhIsPurge_u0028_u1_u003b((&param_953));
    if _e219 {
        let _e221 = tuning.purgeLevel;
        let _e223 = (*mass_1);
        let _e226 = tuning.purgeMass;
        return u32((f32(_e221) * clamp((f32(_e223) / f32(max(_e226, 1u))), 0f, 1f)));
    }
    let _e233 = (*mass_1);
    param_954 = _e233;
    let _e234 = bhLevel_u0028_u1_u003b((&param_954));
    return _e234;
}

fn bhDecode_u0028_u1_u003b(code_2: ptr<function, u32>) -> vec3<i32> {
    var i_26: u32;

    let _e216 = (*code_2);
    i_26 = (_e216 & 1073741823u);
    let _e218 = i_26;
    let _e220 = tuning.gridWidth;
    let _e225 = i_26;
    let _e227 = tuning.gridWidth;
    let _e232 = tuning.gridHeight;
    let _e237 = i_26;
    let _e239 = tuning.gridWidth;
    let _e242 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e218 % bitcast<u32>(bitcast<i32>(_e220)))), bitcast<i32>(((_e225 / bitcast<u32>(bitcast<i32>(_e227))) % bitcast<u32>(bitcast<i32>(_e232)))), bitcast<i32>((_e237 / bitcast<u32>((bitcast<i32>(_e239) * bitcast<i32>(_e242))))));
}

fn captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b(pos_21: ptr<function, vec3<i32>>, currentIndex_15: ptr<function, u32>, rawValue_13: ptr<function, u32>, randVal_14: ptr<function, f32>) -> bool {
    var bestDistSq: f32;
    var bestCenter: vec3<i32>;
    var bestSlot: i32;
    var bestLevel: u32;
    var bestPurge: bool;
    var maxRadius: f32;
    var maxRadiusSq: f32;
    var i_27: i32;
    var code_3: u32;
    var center_2: vec3<i32>;
    var param_955: u32;
    var d_23: vec3<f32>;
    var distSq: f32;
    var purge_1: bool;
    var param_956: u32;
    var level_3: u32;
    var param_957: u32;
    var param_958: u32;
    var radius: f32;
    var local_30: f32;
    var param_959: vec3<i32>;
    var param_960: u32;
    var param_961: u32;
    var param_962: vec3<i32>;
    var param_963: i32;
    var param_964: u32;
    var param_965: bool;
    var param_966: f32;
    var param_967: f32;

    let _e248 = unnamed_2.blackHoleCount;
    if (_e248 == 0u) {
        return false;
    }
    bestDistSq = 3000000000f;
    bestCenter = vec3<i32>(0i, 0i, 0i);
    bestSlot = -1i;
    bestLevel = 0u;
    bestPurge = false;
    let _e251 = tuning.blackHoleRadius;
    let _e253 = tuning.blackHoleMaxLevel;
    maxRadius = f32((_e251 + min(_e253, 16u)));
    let _e257 = maxRadius;
    let _e258 = maxRadius;
    maxRadiusSq = (_e257 * _e258);
    i_27 = 0i;
    loop {
        let _e260 = i_27;
        if (_e260 < 8i) {
            let _e262 = i_27;
            let _e265 = atomicLoad((&unnamed_2.blackHoles[_e262]));
            code_3 = _e265;
            let _e266 = code_3;
            if (_e266 == 0u) {
                continue;
            }
            let _e268 = code_3;
            param_955 = _e268;
            let _e269 = bhDecode_u0028_u1_u003b((&param_955));
            center_2 = _e269;
            let _e270 = center_2;
            let _e271 = (*pos_21);
            d_23 = vec3<f32>((_e270 - _e271));
            let _e274 = d_23;
            let _e275 = d_23;
            distSq = dot(_e274, _e275);
            let _e277 = code_3;
            param_956 = _e277;
            let _e278 = bhIsPurge_u0028_u1_u003b((&param_956));
            purge_1 = _e278;
            let _e279 = purge_1;
            let _e281 = distSq;
            let _e282 = maxRadiusSq;
            if (!(_e279) && (_e281 > _e282)) {
                continue;
            }
            let _e285 = distSq;
            let _e286 = bestDistSq;
            if (_e285 >= _e286) {
                continue;
            }
            let _e288 = i_27;
            let _e289 = code_3;
            param_957 = _e289;
            let _e292 = atomicLoad((&unnamed_2.blackHoleMass[_e288]));
            param_958 = _e292;
            let _e293 = bhLevelFor_u0028_u1_u003b_u1_u003b((&param_957), (&param_958));
            level_3 = _e293;
            let _e294 = purge_1;
            if _e294 {
                local_30 = 1000000000f;
            } else {
                let _e296 = tuning.blackHoleRadius;
                let _e297 = level_3;
                local_30 = f32((_e296 + _e297));
            }
            let _e300 = local_30;
            radius = _e300;
            let _e301 = distSq;
            let _e302 = radius;
            let _e303 = radius;
            if (_e301 <= (_e302 * _e303)) {
                let _e306 = distSq;
                bestDistSq = _e306;
                let _e307 = center_2;
                bestCenter = _e307;
                let _e308 = i_27;
                bestSlot = _e308;
                let _e309 = level_3;
                bestLevel = _e309;
                let _e310 = purge_1;
                bestPurge = _e310;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e311 = i_27;
            i_27 = (_e311 + 1i);
        }
    }
    let _e313 = bestSlot;
    if (_e313 < 0i) {
        return false;
    }
    let _e315 = bestDistSq;
    let _e317 = (*pos_21);
    param_959 = _e317;
    let _e318 = (*currentIndex_15);
    param_960 = _e318;
    let _e319 = (*rawValue_13);
    param_961 = _e319;
    let _e320 = bestCenter;
    param_962 = _e320;
    let _e321 = bestSlot;
    param_963 = _e321;
    let _e322 = bestLevel;
    param_964 = _e322;
    let _e323 = bestPurge;
    param_965 = _e323;
    param_966 = sqrt(_e315);
    let _e324 = (*randVal_14);
    param_967 = _e324;
    updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b((&param_959), (&param_960), (&param_961), (&param_962), (&param_963), (&param_964), (&param_965), (&param_966), (&param_967));
    return true;
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x_4: ptr<function, i32>, z_5: ptr<function, i32>) -> u32 {
    let _e216 = (*x_4);
    let _e217 = (*z_5);
    let _e219 = tuning.gridWidth;
    return (bitcast<u32>((_e216 + (_e217 * bitcast<i32>(_e219)))) * 4u);
}

fn bhRegister_u0028_vi3_u003b(p_5: ptr<function, vec3<i32>>) -> bool {
    var code_4: u32;
    var param_968: vec3<i32>;
    var i_28: i32;

    let _e218 = (*p_5);
    param_968 = _e218;
    let _e219 = getIndex_u0028_vi3_u003b((&param_968));
    code_4 = (2147483648u | _e219);
    i_28 = 0i;
    loop {
        let _e221 = i_28;
        if (_e221 < 8i) {
            let _e223 = i_28;
            let _e226 = code_4;
            let _e227 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e223]), 0u, _e226);
            if (_e227.old_value == 0u) {
                let _e230 = i_28;
                atomicStore((&unnamed_2.blackHoleMass[_e230]), 0u);
                let _e233 = i_28;
                unnamed_2.blackHoleStarve[_e233] = 0u;
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e236 = i_28;
            i_28 = (_e236 + 1i);
        }
    }
    return false;
}

fn writeCell_u0028_u1_u003b_u1_u003b(index_1: ptr<function, u32>, value_2: ptr<function, u32>) {
    let _e216 = (*index_1);
    let _e217 = (*value_2);
    atomicStore((&unnamed.grid[_e216]), _e217);
    return;
}

fn lavaSpawnCoolness_u0028_u1_u003b(type_38: ptr<function, u32>) -> u32 {
    var param_969: u32;

    let _e216 = (*type_38);
    if (_e216 == 12u) {
        let _e218 = lavaSolidifyCoolness_u0028_();
        return _e218;
    }
    let _e219 = (*type_38);
    param_969 = _e219;
    let _e220 = isLava_u0028_u1_u003b((&param_969));
    if _e220 {
        let _e221 = (*type_38);
        let _e224 = tuning.lavaStageSize;
        return ((_e221 - 8u) * max(_e224, 1u));
    }
    return 0u;
}

fn locustSpawnCount_u0028_u1_u003b(type_39: ptr<function, u32>) -> u32 {
    var param_970: u32;

    let _e216 = (*type_39);
    param_970 = _e216;
    let _e217 = isLocust_u0028_u1_u003b((&param_970));
    if !(_e217) {
        return 0u;
    }
    let _e219 = (*type_39);
    let _e222 = locustStage_u0028_();
    let _e224 = locustMaxCount_u0028_();
    return min((((_e219 - 13u) + 1u) * _e222), _e224);
}

fn bhRelease_u0028_vi3_u003b(p_6: ptr<function, vec3<i32>>) {
    var code_5: u32;
    var param_971: vec3<i32>;
    var i_29: i32;

    let _e218 = (*p_6);
    param_971 = _e218;
    let _e219 = getIndex_u0028_vi3_u003b((&param_971));
    code_5 = (2147483648u | _e219);
    i_29 = 0i;
    loop {
        let _e221 = i_29;
        if (_e221 < 8i) {
            let _e223 = i_29;
            let _e226 = code_5;
            let _e227 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e223]), _e226, 0u);
            continue;
        } else {
            break;
        }
        continuing {
            let _e229 = i_29;
            i_29 = (_e229 + 1i);
        }
    }
    return;
}

fn inBrush_u0028_vi3_u003b(pos_22: ptr<function, vec3<i32>>) -> bool {
    var halfMin: i32;
    var halfMax: i32;
    var center_3: vec3<f32>;
    var d_24: vec3<f32>;
    var radius_1: f32;
    var phi_1642_: bool;
    var phi_1664_: bool;
    var phi_1685_: bool;

    let _e221 = pc.spawnSize;
    halfMin = (_e221 / 2i);
    let _e224 = pc.spawnSize;
    halfMax = ((_e224 - 1i) / 2i);
    let _e228 = (*pos_22)[0u];
    let _e230 = pc.spawnX;
    let _e231 = halfMin;
    let _e233 = (_e228 < (_e230 - _e231));
    phi_1642_ = _e233;
    if !(_e233) {
        let _e236 = (*pos_22)[0u];
        let _e238 = pc.spawnX;
        let _e239 = halfMax;
        phi_1642_ = (_e236 > (_e238 + _e239));
    }
    let _e243 = phi_1642_;
    if _e243 {
        return false;
    }
    let _e245 = (*pos_22)[1u];
    let _e247 = pc.spawnY;
    let _e248 = halfMin;
    let _e250 = (_e245 < (_e247 - _e248));
    phi_1664_ = _e250;
    if !(_e250) {
        let _e253 = (*pos_22)[1u];
        let _e255 = pc.spawnY;
        let _e256 = halfMax;
        phi_1664_ = (_e253 > (_e255 + _e256));
    }
    let _e260 = phi_1664_;
    if _e260 {
        return false;
    }
    let _e262 = (*pos_22)[2u];
    let _e264 = pc.spawnZ;
    let _e265 = halfMin;
    let _e267 = (_e262 < (_e264 - _e265));
    phi_1685_ = _e267;
    if !(_e267) {
        let _e270 = (*pos_22)[2u];
        let _e272 = pc.spawnZ;
        let _e273 = halfMax;
        phi_1685_ = (_e270 > (_e272 + _e273));
    }
    let _e277 = phi_1685_;
    if _e277 {
        return false;
    }
    let _e279 = pc.spawnShape;
    if (_e279 != 1i) {
        return true;
    }
    let _e282 = pc.spawnX;
    let _e285 = pc.spawnY;
    let _e288 = pc.spawnZ;
    let _e291 = halfMax;
    let _e292 = halfMin;
    center_3 = (vec3<f32>(f32(_e282), f32(_e285), f32(_e288)) + vec3((f32(((_e291 - _e292) + 1i)) * 0.5f)));
    let _e299 = (*pos_22);
    let _e303 = center_3;
    d_24 = ((vec3<f32>(_e299) + vec3(0.5f)) - _e303);
    let _e306 = pc.spawnSize;
    radius_1 = (f32(_e306) * 0.5f);
    let _e309 = d_24;
    let _e310 = d_24;
    let _e312 = radius_1;
    let _e313 = radius_1;
    return (dot(_e309, _e310) <= (_e312 * _e313));
}

fn tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(fromIndex: ptr<function, u32>, newValue_4: ptr<function, u32>, toIndex: ptr<function, u32>, expectedFromValue: ptr<function, u32>) -> bool {
    let _e218 = (*toIndex);
    let _e221 = (*newValue_4);
    let _e222 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e218]), 0u, _e221);
    if (_e222.old_value != 0u) {
        return false;
    }
    let _e225 = (*fromIndex);
    let _e228 = (*expectedFromValue);
    let _e229 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e225]), _e228, 0u);
    let _e231 = (*expectedFromValue);
    if (_e229.old_value != _e231) {
        let _e233 = (*toIndex);
        let _e236 = atomicExchange((&unnamed_1.cloudCells[_e233]), 0u);
        return false;
    }
    return true;
}

fn getCloudCounter_u0028_u1_u003b(v_5: ptr<function, u32>) -> u32 {
    let _e215 = (*v_5);
    return ((_e215 >> bitcast<u32>(3i)) & 2047u);
}

fn getCloudTarget_u0028_u1_u003b(v_6: ptr<function, u32>) -> u32 {
    let _e215 = (*v_6);
    return ((_e215 >> bitcast<u32>(14i)) & 2047u);
}

fn easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b(current: ptr<function, u32>, target_5: ptr<function, f32>, rate: ptr<function, f32>) -> u32 {
    var old: f32;
    var next: f32;

    let _e219 = (*current);
    old = f32(_e219);
    let _e221 = old;
    let _e222 = (*target_5);
    let _e223 = old;
    let _e225 = (*rate);
    next = (_e221 + ((_e222 - _e223) * _e225));
    let _e228 = (*target_5);
    let _e229 = old;
    if (_e228 > _e229) {
        let _e231 = next;
        let _e232 = old;
        let _e235 = old;
        let _e236 = (*target_5);
        next = clamp(max(_e231, (_e232 + 1f)), _e235, _e236);
    } else {
        let _e238 = (*target_5);
        let _e239 = old;
        if (_e238 < _e239) {
            let _e241 = next;
            let _e242 = old;
            let _e245 = (*target_5);
            let _e246 = old;
            next = clamp(min(_e241, (_e242 - 1f)), _e245, _e246);
        }
    }
    let _e248 = next;
    return u32(max(_e248, 0f));
}

fn updateCloudBlock_u0028_vi3_u003b(pos_23: ptr<function, vec3<i32>>) {
    var idx_4: u32;
    var param_972: vec3<i32>;
    var base: u32;
    var param_973: i32;
    var param_974: i32;
    var rate_1: f32;
    var tallied: u32;
    var param_975: u32;
    var param_976: f32;
    var param_977: f32;
    var param_978: u32;
    var param_979: f32;
    var param_980: f32;
    var cell: u32;
    var kind_1: u32;
    var param_981: u32;
    var param_982: vec3<i32>;
    var newCell: u32;
    var param_983: u32;
    var param_984: bool;
    var param_985: u32;
    var param_986: u32;
    var param_987: u32;
    var param_988: u32;
    var param_989: bool;
    var param_990: u32;
    var param_991: u32;
    var target_6: u32;
    var param_992: u32;
    var lo_1: u32;
    var hi_1: u32;
    var r_6: f32;
    var param_993: vec3<f32>;
    var param_994: u32;
    var param_995: bool;
    var param_996: u32;
    var param_997: u32;
    var counter_1: u32;
    var param_998: u32;
    var param_999: u32;
    var param_1000: bool;
    var param_1001: u32;
    var param_1002: u32;
    var param_1003: vec3<i32>;
    var g: u32;
    var param_1004: u32;
    var param_1005: u32;
    var param_1006: u32;
    var param_1007: u32;
    var param_1008: u32;
    var param_1009: u32;
    var randVal_15: f32;
    var param_1010: vec3<f32>;
    var counter_2: u32;
    var param_1011: u32;
    var target_7: u32;
    var param_1012: u32;
    var upPos_2: vec3<i32>;
    var param_1013: vec3<i32>;
    var param_1014: vec3<i32>;
    var param_1015: u32;
    var param_1016: u32;
    var param_1017: bool;
    var param_1018: u32;
    var param_1019: u32;
    var param_1020: vec3<i32>;
    var param_1021: u32;
    var param_1022: u32;
    var param_1023: u32;
    var param_1024: u32;
    var dir_8: i32;
    var slide1_: vec3<i32>;
    var slide2_: vec3<i32>;
    var i_30: i32;
    var t_5: vec3<i32>;
    var param_1025: vec3<i32>;
    var tIndex: u32;
    var param_1026: vec3<i32>;
    var param_1027: u32;
    var param_1028: u32;
    var param_1029: bool;
    var param_1030: u32;
    var param_1031: u32;
    var param_1032: u32;
    var param_1033: u32;
    var param_1034: u32;
    var param_1035: u32;
    var param_1036: u32;
    var param_1037: u32;
    var param_1038: bool;
    var param_1039: u32;
    var param_1040: u32;
    var phi_9592_: bool;
    var phi_9593_: bool;
    var phi_9801_: bool;

    let _e307 = (*pos_23);
    param_972 = _e307;
    let _e308 = getIndex_u0028_vi3_u003b((&param_972));
    idx_4 = _e308;
    let _e310 = (*pos_23)[0u];
    param_973 = _e310;
    let _e312 = (*pos_23)[2u];
    param_974 = _e312;
    let _e313 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_973), (&param_974));
    base = _e313;
    let _e315 = (*pos_23)[1u];
    if (_e315 == 0i) {
        let _e318 = tuning.cloudSmoothRate;
        rate_1 = clamp(_e318, 0.01f, 1f);
        let _e320 = base;
        let _e324 = atomicLoad((&unnamed_2.cloudColumn[(_e320 + 0u)]));
        tallied = _e324;
        let _e325 = base;
        let _e327 = base;
        let _e329 = tallied;
        let _e334 = atomicLoad((&unnamed_2.cloudColumn[(_e327 + 2u)]));
        param_975 = _e334;
        param_976 = (f32(_e329) * 16f);
        let _e335 = rate_1;
        param_977 = _e335;
        let _e336 = easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b((&param_975), (&param_976), (&param_977));
        atomicStore((&unnamed_2.cloudColumn[(_e325 + 2u)]), _e336);
        let _e339 = tallied;
        if (_e339 > 0u) {
            let _e341 = base;
            let _e343 = base;
            let _e345 = base;
            let _e349 = atomicLoad((&unnamed_2.cloudColumn[(_e345 + 1u)]));
            let _e354 = atomicLoad((&unnamed_2.cloudColumn[(_e343 + 3u)]));
            param_978 = _e354;
            param_979 = (f32(_e349) * 16f);
            let _e355 = rate_1;
            param_980 = _e355;
            let _e356 = easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b((&param_978), (&param_979), (&param_980));
            atomicStore((&unnamed_2.cloudColumn[(_e341 + 3u)]), _e356);
        }
        let _e359 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e359 + 0u)]), 0u);
        let _e363 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e363 + 1u)]), 0u);
    }
    let _e367 = idx_4;
    let _e370 = atomicLoad((&unnamed_1.cloudCells[_e367]));
    cell = _e370;
    let _e371 = cell;
    param_981 = _e371;
    let _e372 = getCloudKind_u0028_u1_u003b((&param_981));
    kind_1 = _e372;
    let _e373 = kind_1;
    if (_e373 == 0u) {
        return;
    }
    let _e376 = atomicAdd((&unnamed_2.cloudBlockCount), 1u);
    let _e377 = base;
    let _e381 = atomicAdd((&unnamed_2.cloudColumn[(_e377 + 0u)]), 1u);
    let _e382 = base;
    let _e387 = (*pos_23)[1u];
    let _e389 = atomicMax((&unnamed_2.cloudColumn[(_e382 + 1u)]), bitcast<u32>(_e387));
    let _e392 = (*pos_23)[1u];
    let _e394 = atomicMin((&unnamed_2.cloudMinYAcc), bitcast<u32>(_e392));
    let _e397 = (*pos_23)[1u];
    let _e399 = atomicMax((&unnamed_2.cloudMaxYAcc), bitcast<u32>(_e397));
    let _e400 = kind_1;
    let _e401 = (_e400 == 1u);
    phi_9593_ = _e401;
    if _e401 {
        let _e403 = unnamed_2.rainPhase;
        let _e404 = (_e403 == 2u);
        phi_9592_ = _e404;
        if !(_e404) {
            let _e406 = (*pos_23);
            param_982 = _e406;
            let _e407 = cloudTouchesRain_u0028_vi3_u003b((&param_982));
            phi_9592_ = _e407;
        }
        let _e409 = phi_9592_;
        phi_9593_ = _e409;
    }
    let _e411 = phi_9593_;
    if _e411 {
        param_983 = 2u;
        param_984 = false;
        param_985 = 0u;
        param_986 = 0u;
        let _e412 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_983), (&param_984), (&param_985), (&param_986));
        newCell = _e412;
        let _e413 = idx_4;
        let _e416 = cell;
        let _e417 = newCell;
        let _e418 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e413]), _e416, _e417);
        let _e420 = cell;
        if (_e418.old_value != _e420) {
            return;
        }
        let _e422 = newCell;
        cell = _e422;
        kind_1 = 2u;
    }
    let _e424 = (*pos_23)[1u];
    let _e426 = tuning.gridHeight;
    if (_e424 >= (bitcast<i32>(_e426) - 2i)) {
        let _e430 = kind_1;
        if (_e430 != 2u) {
            let _e432 = cell;
            param_987 = _e432;
            let _e433 = getCloudMoved_u0028_u1_u003b((&param_987));
            if _e433 {
                let _e434 = idx_4;
                let _e437 = cell;
                let _e438 = kind_1;
                param_988 = _e438;
                param_989 = false;
                param_990 = 0u;
                param_991 = 0u;
                let _e439 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_988), (&param_989), (&param_990), (&param_991));
                let _e440 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e434]), _e437, _e439);
            }
            return;
        }
        let _e442 = cell;
        param_992 = _e442;
        let _e443 = getCloudTarget_u0028_u1_u003b((&param_992));
        target_6 = _e443;
        let _e444 = target_6;
        if (_e444 == 0u) {
            let _e447 = tuning.rainWaitMinTicks;
            let _e449 = tuning.rainWaitMaxTicks;
            lo_1 = min(_e447, _e449);
            let _e452 = tuning.rainWaitMinTicks;
            let _e454 = tuning.rainWaitMaxTicks;
            hi_1 = max(_e452, _e454);
            let _e456 = (*pos_23);
            let _e459 = pc.time;
            param_993 = (vec3<f32>(_e456) + vec3<f32>(_e459, 17f, 3f));
            let _e462 = hash_u0028_vf3_u003b((&param_993));
            r_6 = _e462;
            let _e463 = lo_1;
            let _e464 = r_6;
            let _e465 = hi_1;
            let _e466 = lo_1;
            target_6 = (_e463 + u32((_e464 * f32(((_e465 - _e466) + 1u)))));
            let _e473 = idx_4;
            let _e476 = cell;
            param_994 = 2u;
            param_995 = false;
            param_996 = 0u;
            let _e477 = target_6;
            param_997 = _e477;
            let _e478 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_994), (&param_995), (&param_996), (&param_997));
            let _e479 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e473]), _e476, _e478);
            return;
        }
        let _e481 = cell;
        param_998 = _e481;
        let _e482 = getCloudCounter_u0028_u1_u003b((&param_998));
        counter_1 = _e482;
        let _e483 = counter_1;
        let _e484 = target_6;
        if (_e483 < _e484) {
            let _e486 = idx_4;
            let _e489 = cell;
            let _e490 = counter_1;
            param_999 = 2u;
            param_1000 = false;
            param_1001 = (_e490 + 1u);
            let _e492 = target_6;
            param_1002 = _e492;
            let _e493 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_999), (&param_1000), (&param_1001), (&param_1002));
            let _e494 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e486]), _e489, _e493);
            return;
        }
        let _e496 = (*pos_23);
        param_1003 = _e496;
        let _e497 = cloudCellInBounds_u0028_vi3_u003b((&param_1003));
        if !(_e497) {
            return;
        }
        let _e499 = idx_4;
        param_1004 = _e499;
        let _e500 = readCell_u0028_u1_u003b((&param_1004));
        g = _e500;
        let _e501 = g;
        param_1005 = _e501;
        let _e502 = getType_u0028_u1_u003b((&param_1005));
        if (_e502 != 0u) {
            return;
        }
        let _e504 = idx_4;
        let _e507 = g;
        param_1006 = 2u;
        param_1007 = 0u;
        param_1008 = 0u;
        param_1009 = 0u;
        let _e508 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_1006), (&param_1007), (&param_1008), (&param_1009));
        let _e509 = atomicCompareExchangeWeak((&unnamed.grid[_e504]), _e507, _e508);
        let _e511 = g;
        if (_e509.old_value != _e511) {
            return;
        }
        let _e513 = idx_4;
        let _e516 = atomicExchange((&unnamed_1.cloudCells[_e513]), 0u);
        incWater_u0028_();
        let _e518 = (*pos_23)[1u];
        let _e521 = atomicLoad((&unnamed_2.maxOccupiedY));
        if (bitcast<u32>(_e518) > _e521) {
            let _e525 = (*pos_23)[1u];
            let _e527 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e525));
        }
        return;
    }
    let _e528 = (*pos_23);
    let _e531 = pc.time;
    param_1010 = (vec3<f32>(_e528) + vec3<f32>((_e531 * 2.3f), 7f, 13f));
    let _e535 = hash_u0028_vf3_u003b((&param_1010));
    randVal_15 = _e535;
    let _e536 = cell;
    param_1011 = _e536;
    let _e537 = getCloudCounter_u0028_u1_u003b((&param_1011));
    counter_2 = _e537;
    let _e538 = cell;
    param_1012 = _e538;
    let _e539 = getCloudTarget_u0028_u1_u003b((&param_1012));
    target_7 = _e539;
    let _e540 = (*pos_23);
    upPos_2 = (_e540 + vec3<i32>(0i, 1i, 0i));
    let _e542 = upPos_2;
    param_1013 = _e542;
    let _e543 = cloudCellInBounds_u0028_vi3_u003b((&param_1013));
    phi_9801_ = _e543;
    if _e543 {
        let _e544 = upPos_2;
        param_1014 = _e544;
        let _e545 = getIndex_u0028_vi3_u003b((&param_1014));
        let _e548 = atomicLoad((&unnamed_1.cloudCells[_e545]));
        param_1015 = _e548;
        let _e549 = getCloudKind_u0028_u1_u003b((&param_1015));
        phi_9801_ = (_e549 == 0u);
    }
    let _e552 = phi_9801_;
    if _e552 {
        let _e553 = kind_1;
        param_1016 = _e553;
        param_1017 = true;
        let _e554 = counter_2;
        param_1018 = _e554;
        let _e555 = target_7;
        param_1019 = _e555;
        let _e556 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_1016), (&param_1017), (&param_1018), (&param_1019));
        let _e557 = upPos_2;
        param_1020 = _e557;
        let _e558 = getIndex_u0028_vi3_u003b((&param_1020));
        let _e559 = idx_4;
        param_1021 = _e559;
        param_1022 = _e556;
        param_1023 = _e558;
        let _e560 = cell;
        param_1024 = _e560;
        let _e561 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_1021), (&param_1022), (&param_1023), (&param_1024));
        if _e561 {
            let _e563 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
            return;
        }
    }
    let _e564 = randVal_15;
    dir_8 = select(-1i, 1i, (fract((_e564 * 10f)) > 0.5f));
    let _e569 = randVal_15;
    if (fract((_e569 * 100f)) > 0.5f) {
        let _e573 = (*pos_23);
        let _e574 = dir_8;
        slide1_ = (_e573 + vec3<i32>(_e574, 1i, 0i));
        let _e577 = (*pos_23);
        let _e578 = dir_8;
        slide2_ = (_e577 + vec3<i32>(0i, 1i, _e578));
    } else {
        let _e581 = (*pos_23);
        let _e582 = dir_8;
        slide1_ = (_e581 + vec3<i32>(0i, 1i, _e582));
        let _e585 = (*pos_23);
        let _e586 = dir_8;
        slide2_ = (_e585 + vec3<i32>(_e586, 1i, 0i));
    }
    i_30 = 0i;
    loop {
        let _e589 = i_30;
        if (_e589 < 2i) {
            let _e591 = i_30;
            let _e593 = slide1_;
            let _e594 = slide2_;
            t_5 = select(_e594, _e593, vec3((_e591 == 0i)));
            let _e597 = t_5;
            param_1025 = _e597;
            let _e598 = cloudCellInBounds_u0028_vi3_u003b((&param_1025));
            if !(_e598) {
                continue;
            }
            let _e600 = t_5;
            param_1026 = _e600;
            let _e601 = getIndex_u0028_vi3_u003b((&param_1026));
            tIndex = _e601;
            let _e602 = tIndex;
            let _e605 = atomicLoad((&unnamed_1.cloudCells[_e602]));
            param_1027 = _e605;
            let _e606 = getCloudKind_u0028_u1_u003b((&param_1027));
            if (_e606 != 0u) {
                continue;
            }
            let _e608 = kind_1;
            param_1028 = _e608;
            param_1029 = true;
            let _e609 = counter_2;
            param_1030 = _e609;
            let _e610 = target_7;
            param_1031 = _e610;
            let _e611 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_1028), (&param_1029), (&param_1030), (&param_1031));
            let _e612 = idx_4;
            param_1032 = _e612;
            param_1033 = _e611;
            let _e613 = tIndex;
            param_1034 = _e613;
            let _e614 = cell;
            param_1035 = _e614;
            let _e615 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_1032), (&param_1033), (&param_1034), (&param_1035));
            if _e615 {
                let _e617 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e618 = i_30;
            i_30 = (_e618 + 1i);
        }
    }
    let _e620 = cell;
    param_1036 = _e620;
    let _e621 = getCloudMoved_u0028_u1_u003b((&param_1036));
    if _e621 {
        let _e622 = idx_4;
        let _e625 = cell;
        let _e626 = kind_1;
        param_1037 = _e626;
        param_1038 = false;
        let _e627 = counter_2;
        param_1039 = _e627;
        let _e628 = target_7;
        param_1040 = _e628;
        let _e629 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_1037), (&param_1038), (&param_1039), (&param_1040));
        let _e630 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e622]), _e625, _e629);
    }
    return;
}

fn updateSimState_u0028_() {
    var live: u32;
    var i_31: i32;
    var code_6: u32;
    var voxel: u32;
    var param_1041: u32;
    var param_1042: u32;
    var starve: u32;
    var purge_2: bool;
    var param_1043: u32;
    var grace: u32;
    var local_31: u32;
    var decay: u32;
    var local_32: u32;
    var mass_2: u32;
    var param_1044: u32;
    var param_1045: u32;
    var movedLastTick: u32;
    var liveClouds: u32;
    var chargeTarget: f32;
    var charge: f32;
    var interval: u32;
    var phi_8751_: bool;
    var phi_8758_: bool;

    let _e236 = gl_GlobalInvocationID_1[0u];
    let _e237 = (_e236 != 0u);
    phi_8751_ = _e237;
    if !(_e237) {
        let _e240 = gl_GlobalInvocationID_1[1u];
        phi_8751_ = (_e240 != 0u);
    }
    let _e243 = phi_8751_;
    phi_8758_ = _e243;
    if !(_e243) {
        let _e246 = gl_GlobalInvocationID_1[2u];
        phi_8758_ = (_e246 != 0u);
    }
    let _e249 = phi_8758_;
    if _e249 {
        return;
    }
    live = 0u;
    i_31 = 0i;
    loop {
        let _e250 = i_31;
        if (_e250 < 8i) {
            let _e252 = i_31;
            let _e255 = atomicLoad((&unnamed_2.blackHoles[_e252]));
            code_6 = _e255;
            let _e256 = code_6;
            if (_e256 == 0u) {
                continue;
            }
            let _e258 = code_6;
            voxel = (_e258 & 1073741823u);
            let _e260 = voxel;
            param_1041 = _e260;
            let _e261 = readCell_u0028_u1_u003b((&param_1041));
            param_1042 = _e261;
            let _e262 = getType_u0028_u1_u003b((&param_1042));
            if (_e262 != 7u) {
                let _e264 = i_31;
                atomicStore((&unnamed_2.blackHoles[_e264]), 0u);
                continue;
            }
            let _e267 = i_31;
            let _e270 = unnamed_2.blackHoleStarve[_e267];
            starve = (_e270 + 1u);
            let _e272 = i_31;
            let _e273 = starve;
            unnamed_2.blackHoleStarve[_e272] = _e273;
            let _e276 = code_6;
            param_1043 = _e276;
            let _e277 = bhIsPurge_u0028_u1_u003b((&param_1043));
            purge_2 = _e277;
            let _e278 = purge_2;
            if _e278 {
                let _e280 = tuning.purgeStarveGrace;
                local_31 = _e280;
            } else {
                let _e282 = tuning.blackHoleStarveGrace;
                local_31 = _e282;
            }
            let _e283 = local_31;
            grace = _e283;
            let _e284 = purge_2;
            if _e284 {
                let _e286 = tuning.purgeDecayRate;
                local_32 = _e286;
            } else {
                let _e288 = tuning.blackHoleDecayRate;
                local_32 = _e288;
            }
            let _e289 = local_32;
            decay = _e289;
            let _e290 = starve;
            let _e291 = grace;
            if (_e290 > _e291) {
                let _e293 = i_31;
                let _e296 = atomicLoad((&unnamed_2.blackHoleMass[_e293]));
                mass_2 = _e296;
                let _e297 = mass_2;
                if (_e297 == 0u) {
                    let _e299 = voxel;
                    param_1044 = _e299;
                    param_1045 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_1044), (&param_1045));
                    let _e300 = i_31;
                    atomicStore((&unnamed_2.blackHoles[_e300]), 0u);
                    continue;
                }
                let _e303 = i_31;
                let _e304 = mass_2;
                let _e305 = mass_2;
                let _e306 = decay;
                atomicStore((&unnamed_2.blackHoleMass[_e303]), (_e304 - min(_e305, _e306)));
            }
            let _e311 = live;
            live = (_e311 + bitcast<u32>(1i));
            continue;
        } else {
            break;
        }
        continuing {
            let _e314 = i_31;
            i_31 = (_e314 + 1i);
        }
    }
    let _e316 = live;
    unnamed_2.blackHoleCount = _e316;
    let _e319 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (_e319 > 0u) {
        let _e322 = atomicAdd((&unnamed_2.maxOccupiedY), 4294967295u);
    }
    let _e324 = atomicLoad((&unnamed_2.rainCandidateCount));
    unnamed_2.rainCandidateEstimate = _e324;
    atomicStore((&unnamed_2.rainCandidateCount), 0u);
    let _e328 = unnamed_2.simTick;
    unnamed_2.simTick = (_e328 + 1u);
    let _e332 = atomicLoad((&unnamed_2.cloudMovedCount));
    movedLastTick = _e332;
    let _e334 = atomicLoad((&unnamed_2.cloudBlockCount));
    liveClouds = _e334;
    atomicStore((&unnamed_2.cloudBlockCount), 0u);
    atomicStore((&unnamed_2.cloudMovedCount), 0u);
    let _e338 = atomicLoad((&unnamed_2.cloudMinYAcc));
    unnamed_2.cloudMinY = _e338;
    let _e341 = atomicLoad((&unnamed_2.cloudMaxYAcc));
    unnamed_2.cloudMaxY = _e341;
    atomicStore((&unnamed_2.cloudMinYAcc), 4294967295u);
    atomicStore((&unnamed_2.cloudMaxYAcc), 0u);
    let _e346 = unnamed_2.rainPhase;
    chargeTarget = select(1f, 0f, (_e346 == 0u));
    let _e350 = unnamed_2.cloudChargeBits;
    charge = bitcast<f32>(_e350);
    let _e352 = chargeTarget;
    let _e353 = charge;
    let _e356 = tuning.cloudChargeEaseRate;
    let _e359 = charge;
    charge = (_e359 + ((_e352 - _e353) * clamp(_e356, 0f, 1f)));
    let _e361 = charge;
    unnamed_2.cloudChargeBits = bitcast<u32>(clamp(_e361, 0f, 1f));
    let _e366 = unnamed_2.rainPhase;
    if (_e366 == 0u) {
        let _e369 = tuning.cloudCheckIntervalTicks;
        interval = max(_e369, 1u);
        let _e372 = unnamed_2.simTick;
        let _e373 = interval;
        let _e376 = liveClouds;
        let _e379 = movedLastTick;
        if ((((_e372 % _e373) == 0u) && (_e376 > 0u)) && (_e379 == 0u)) {
            unnamed_2.rainPhase = 2u;
            let _e384 = pc.time;
            unnamed_2.rainPhaseTimeBits = bitcast<u32>(_e384);
            let _e388 = unnamed_2.simTick;
            unnamed_2.lastRainTick = _e388;
        }
    } else {
        let _e390 = liveClouds;
        if (_e390 == 0u) {
            unnamed_2.rainPhase = 0u;
            unnamed_2.rainPhaseTimeBits = 0u;
        }
    }
    return;
}

fn main_1() {
    var pos_24: vec3<i32>;
    var param_1046: vec3<i32>;
    var param_1047: vec3<i32>;
    var spawnIndex: u32;
    var param_1048: vec3<i32>;
    var oldType: u32;
    var param_1049: u32;
    var param_1050: u32;
    var newType_3: u32;
    var param_1051: vec3<i32>;
    var seedAge: u32;
    var param_1052: u32;
    var local_33: u32;
    var param_1053: u32;
    var param_1054: u32;
    var param_1055: u32;
    var param_1056: u32;
    var param_1057: u32;
    var param_1058: u32;
    var param_1059: u32;
    var param_1060: u32;
    var param_1061: vec3<i32>;
    var param_1062: u32;
    var param_1063: u32;
    var currentIndex_16: u32;
    var param_1064: vec3<i32>;
    var rawValue_14: u32;
    var param_1065: u32;
    var currentType_1: u32;
    var param_1066: u32;
    var param_1067: i32;
    var param_1068: i32;
    var randVal_16: f32;
    var param_1069: vec3<f32>;
    var param_1070: vec3<i32>;
    var param_1071: u32;
    var param_1072: u32;
    var param_1073: f32;
    var currentDir_6: u32;
    var param_1074: u32;
    var currentSleep_8: u32;
    var param_1075: u32;
    var currentAge_11: u32;
    var param_1076: u32;
    var param_1077: vec3<i32>;
    var param_1078: u32;
    var param_1079: u32;
    var param_1080: u32;
    var param_1081: u32;
    var param_1082: f32;
    var param_1083: vec3<i32>;
    var param_1084: u32;
    var param_1085: u32;
    var param_1086: u32;
    var param_1087: u32;
    var param_1088: u32;
    var param_1089: f32;
    var param_1090: vec3<i32>;
    var param_1091: u32;
    var param_1092: u32;
    var param_1093: u32;
    var param_1094: u32;
    var param_1095: u32;
    var param_1096: f32;
    var param_1097: vec3<i32>;
    var param_1098: u32;
    var param_1099: u32;
    var param_1100: u32;
    var param_1101: u32;
    var param_1102: u32;
    var param_1103: f32;
    var param_1104: vec3<i32>;
    var param_1105: u32;
    var param_1106: u32;
    var param_1107: u32;
    var param_1108: u32;
    var param_1109: f32;
    var param_1110: vec3<i32>;
    var param_1111: u32;
    var param_1112: u32;
    var param_1113: u32;
    var param_1114: u32;
    var param_1115: u32;
    var param_1116: f32;
    var param_1117: vec3<i32>;
    var param_1118: u32;
    var param_1119: u32;
    var param_1120: u32;
    var param_1121: f32;
    var param_1122: vec3<i32>;
    var param_1123: u32;
    var param_1124: u32;
    var param_1125: u32;
    var param_1126: u32;
    var param_1127: u32;
    var param_1128: f32;
    var param_1129: vec3<i32>;
    var param_1130: u32;
    var param_1131: u32;
    var param_1132: u32;
    var param_1133: u32;
    var param_1134: f32;
    var param_1135: vec3<i32>;
    var param_1136: u32;
    var param_1137: u32;
    var param_1138: u32;
    var param_1139: f32;
    var param_1140: vec3<i32>;
    var param_1141: u32;
    var param_1142: u32;
    var param_1143: u32;
    var param_1144: u32;
    var param_1145: f32;
    var phi_9951_: bool;
    var phi_9961_: bool;
    var phi_9977_: bool;
    var phi_10076_: bool;
    var phi_10083_: bool;
    var phi_10094_: bool;
    var phi_10101_: bool;
    var phi_10112_: bool;
    var phi_10135_: bool;
    var phi_10145_: bool;
    var phi_10203_: bool;

    let _e327 = gl_GlobalInvocationID_1;
    pos_24 = bitcast<vec3<i32>>(_e327);
    let _e330 = pos_24[0u];
    let _e332 = tuning.gridWidth;
    let _e334 = (_e330 >= bitcast<i32>(_e332));
    phi_9951_ = _e334;
    if !(_e334) {
        let _e337 = pos_24[1u];
        let _e339 = tuning.gridHeight;
        phi_9951_ = (_e337 >= bitcast<i32>(_e339));
    }
    let _e343 = phi_9951_;
    phi_9961_ = _e343;
    if !(_e343) {
        let _e346 = pos_24[2u];
        let _e348 = tuning.gridDepth;
        phi_9961_ = (_e346 >= bitcast<i32>(_e348));
    }
    let _e352 = phi_9961_;
    if _e352 {
        return;
    }
    updateSimState_u0028_();
    let _e353 = pos_24;
    param_1046 = _e353;
    updateCloudBlock_u0028_vi3_u003b((&param_1046));
    let _e355 = pc.spawnActive;
    let _e356 = (_e355 == 1i);
    phi_9977_ = _e356;
    if _e356 {
        let _e357 = pos_24;
        param_1047 = _e357;
        let _e358 = inBrush_u0028_vi3_u003b((&param_1047));
        phi_9977_ = _e358;
    }
    let _e360 = phi_9977_;
    if _e360 {
        let _e361 = pos_24;
        param_1048 = _e361;
        let _e362 = getIndex_u0028_vi3_u003b((&param_1048));
        spawnIndex = _e362;
        let _e363 = spawnIndex;
        param_1049 = _e363;
        let _e364 = readCell_u0028_u1_u003b((&param_1049));
        param_1050 = _e364;
        let _e365 = getType_u0028_u1_u003b((&param_1050));
        oldType = _e365;
        let _e367 = pc.spawnType;
        newType_3 = bitcast<u32>(_e367);
        let _e369 = newType_3;
        let _e371 = oldType;
        if ((_e369 != 7u) || (_e371 != 7u)) {
            let _e374 = oldType;
            let _e375 = newType_3;
            if (_e374 != _e375) {
                let _e377 = oldType;
                if (_e377 == 2u) {
                    decWater_u0028_();
                }
                let _e379 = oldType;
                if (_e379 == 7u) {
                    let _e381 = pos_24;
                    param_1051 = _e381;
                    bhRelease_u0028_vi3_u003b((&param_1051));
                }
                let _e382 = newType_3;
                if (_e382 == 2u) {
                    incWater_u0028_();
                }
            }
            let _e384 = newType_3;
            param_1052 = _e384;
            let _e385 = isLocust_u0028_u1_u003b((&param_1052));
            if _e385 {
                let _e386 = newType_3;
                param_1053 = _e386;
                let _e387 = locustSpawnCount_u0028_u1_u003b((&param_1053));
                local_33 = _e387;
            } else {
                let _e388 = newType_3;
                param_1054 = _e388;
                let _e389 = lavaSpawnCoolness_u0028_u1_u003b((&param_1054));
                local_33 = _e389;
            }
            let _e390 = local_33;
            seedAge = _e390;
            let _e391 = newType_3;
            param_1055 = _e391;
            param_1056 = 0u;
            param_1057 = 0u;
            let _e392 = seedAge;
            param_1058 = _e392;
            let _e393 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_1055), (&param_1056), (&param_1057), (&param_1058));
            let _e394 = spawnIndex;
            param_1059 = _e394;
            param_1060 = _e393;
            writeCell_u0028_u1_u003b_u1_u003b((&param_1059), (&param_1060));
            let _e395 = newType_3;
            if (_e395 == 7u) {
                let _e397 = pos_24;
                param_1061 = _e397;
                let _e398 = bhRegister_u0028_vi3_u003b((&param_1061));
                if !(_e398) {
                    let _e400 = spawnIndex;
                    param_1062 = _e400;
                    param_1063 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_1062), (&param_1063));
                }
            }
        }
    }
    let _e402 = pos_24[0u];
    let _e403 = (_e402 < 1i);
    phi_10076_ = _e403;
    if !(_e403) {
        let _e406 = pos_24[0u];
        let _e408 = tuning.gridWidth;
        phi_10076_ = (_e406 >= (bitcast<i32>(_e408) - 1i));
    }
    let _e413 = phi_10076_;
    phi_10083_ = _e413;
    if !(_e413) {
        let _e416 = pos_24[1u];
        phi_10083_ = (_e416 < 1i);
    }
    let _e419 = phi_10083_;
    phi_10094_ = _e419;
    if !(_e419) {
        let _e422 = pos_24[1u];
        let _e424 = tuning.gridHeight;
        phi_10094_ = (_e422 >= (bitcast<i32>(_e424) - 1i));
    }
    let _e429 = phi_10094_;
    phi_10101_ = _e429;
    if !(_e429) {
        let _e432 = pos_24[2u];
        phi_10101_ = (_e432 < 1i);
    }
    let _e435 = phi_10101_;
    phi_10112_ = _e435;
    if !(_e435) {
        let _e438 = pos_24[2u];
        let _e440 = tuning.gridDepth;
        phi_10112_ = (_e438 >= (bitcast<i32>(_e440) - 1i));
    }
    let _e445 = phi_10112_;
    if _e445 {
        return;
    }
    let _e446 = pos_24;
    param_1064 = _e446;
    let _e447 = getIndex_u0028_vi3_u003b((&param_1064));
    currentIndex_16 = _e447;
    let _e448 = currentIndex_16;
    param_1065 = _e448;
    let _e449 = readCell_u0028_u1_u003b((&param_1065));
    rawValue_14 = _e449;
    let _e450 = rawValue_14;
    param_1066 = _e450;
    let _e451 = getType_u0028_u1_u003b((&param_1066));
    currentType_1 = _e451;
    let _e452 = currentType_1;
    let _e453 = (_e452 == 0u);
    phi_10135_ = _e453;
    if _e453 {
        let _e455 = unnamed_2.rainPhase;
        phi_10135_ = (_e455 >= 1u);
    }
    let _e458 = phi_10135_;
    phi_10145_ = _e458;
    if _e458 {
        let _e460 = pos_24[1u];
        let _e462 = tuning.gridHeight;
        phi_10145_ = (_e460 == (bitcast<i32>(_e462) - 2i));
    }
    let _e467 = phi_10145_;
    if _e467 {
        let _e469 = pos_24[0u];
        param_1067 = _e469;
        let _e471 = pos_24[2u];
        param_1068 = _e471;
        let _e472 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_1067), (&param_1068));
        let _e476 = atomicLoad((&unnamed_2.cloudColumn[(_e472 + 2u)]));
        if (_e476 != 0u) {
            let _e479 = atomicAdd((&unnamed_2.rainCandidateCount), 1u);
        }
    }
    let _e480 = currentType_1;
    if (_e480 == 0u) {
        return;
    }
    let _e483 = pos_24[1u];
    let _e486 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (bitcast<u32>(_e483) > _e486) {
        let _e490 = pos_24[1u];
        let _e492 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e490));
    }
    let _e493 = pos_24;
    let _e496 = pc.time;
    param_1069 = (vec3<f32>(_e493) + vec3(_e496));
    let _e499 = hash_u0028_vf3_u003b((&param_1069));
    randVal_16 = _e499;
    let _e500 = currentType_1;
    let _e501 = (_e500 != 7u);
    phi_10203_ = _e501;
    if _e501 {
        let _e502 = pos_24;
        param_1070 = _e502;
        let _e503 = currentIndex_16;
        param_1071 = _e503;
        let _e504 = rawValue_14;
        param_1072 = _e504;
        let _e505 = randVal_16;
        param_1073 = _e505;
        let _e506 = captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1070), (&param_1071), (&param_1072), (&param_1073));
        phi_10203_ = _e506;
    }
    let _e508 = phi_10203_;
    if _e508 {
        return;
    }
    let _e509 = currentType_1;
    let _e511 = currentType_1;
    if ((_e509 == 3u) || (_e511 == 7u)) {
        return;
    }
    let _e514 = rawValue_14;
    param_1074 = _e514;
    let _e515 = getDir_u0028_u1_u003b((&param_1074));
    currentDir_6 = _e515;
    let _e516 = rawValue_14;
    param_1075 = _e516;
    let _e517 = getSleep_u0028_u1_u003b((&param_1075));
    currentSleep_8 = _e517;
    let _e518 = rawValue_14;
    param_1076 = _e518;
    let _e519 = getAge_u0028_u1_u003b((&param_1076));
    currentAge_11 = _e519;
    let _e520 = currentType_1;
    switch bitcast<i32>(_e520) {
        case 1: {
            let _e522 = pos_24;
            param_1077 = _e522;
            let _e523 = currentIndex_16;
            param_1078 = _e523;
            let _e524 = rawValue_14;
            param_1079 = _e524;
            let _e525 = currentSleep_8;
            param_1080 = _e525;
            let _e526 = currentAge_11;
            param_1081 = _e526;
            let _e527 = randVal_16;
            param_1082 = _e527;
            updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1077), (&param_1078), (&param_1079), (&param_1080), (&param_1081), (&param_1082));
            break;
        }
        case 2: {
            let _e528 = pos_24;
            param_1083 = _e528;
            let _e529 = currentIndex_16;
            param_1084 = _e529;
            let _e530 = rawValue_14;
            param_1085 = _e530;
            let _e531 = currentDir_6;
            param_1086 = _e531;
            let _e532 = currentSleep_8;
            param_1087 = _e532;
            let _e533 = currentAge_11;
            param_1088 = _e533;
            let _e534 = randVal_16;
            param_1089 = _e534;
            updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1083), (&param_1084), (&param_1085), (&param_1086), (&param_1087), (&param_1088), (&param_1089));
            break;
        }
        case 4: {
            let _e535 = pos_24;
            param_1090 = _e535;
            let _e536 = currentIndex_16;
            param_1091 = _e536;
            let _e537 = rawValue_14;
            param_1092 = _e537;
            let _e538 = currentDir_6;
            param_1093 = _e538;
            let _e539 = currentSleep_8;
            param_1094 = _e539;
            let _e540 = currentAge_11;
            param_1095 = _e540;
            let _e541 = randVal_16;
            param_1096 = _e541;
            updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1090), (&param_1091), (&param_1092), (&param_1093), (&param_1094), (&param_1095), (&param_1096));
            break;
        }
        case 5: {
            let _e542 = pos_24;
            param_1097 = _e542;
            let _e543 = currentIndex_16;
            param_1098 = _e543;
            let _e544 = rawValue_14;
            param_1099 = _e544;
            let _e545 = currentDir_6;
            param_1100 = _e545;
            let _e546 = currentSleep_8;
            param_1101 = _e546;
            let _e547 = currentAge_11;
            param_1102 = _e547;
            let _e548 = randVal_16;
            param_1103 = _e548;
            updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1097), (&param_1098), (&param_1099), (&param_1100), (&param_1101), (&param_1102), (&param_1103));
            break;
        }
        case 6: {
            let _e549 = pos_24;
            param_1104 = _e549;
            let _e550 = currentIndex_16;
            param_1105 = _e550;
            let _e551 = rawValue_14;
            param_1106 = _e551;
            let _e552 = currentSleep_8;
            param_1107 = _e552;
            let _e553 = currentAge_11;
            param_1108 = _e553;
            let _e554 = randVal_16;
            param_1109 = _e554;
            updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1104), (&param_1105), (&param_1106), (&param_1107), (&param_1108), (&param_1109));
            break;
        }
        case 9, 10, 11, 8: {
            let _e555 = pos_24;
            param_1110 = _e555;
            let _e556 = currentIndex_16;
            param_1111 = _e556;
            let _e557 = rawValue_14;
            param_1112 = _e557;
            let _e558 = currentDir_6;
            param_1113 = _e558;
            let _e559 = currentSleep_8;
            param_1114 = _e559;
            let _e560 = currentAge_11;
            param_1115 = _e560;
            let _e561 = randVal_16;
            param_1116 = _e561;
            updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1110), (&param_1111), (&param_1112), (&param_1113), (&param_1114), (&param_1115), (&param_1116));
            break;
        }
        case 12: {
            let _e562 = pos_24;
            param_1117 = _e562;
            let _e563 = currentIndex_16;
            param_1118 = _e563;
            let _e564 = rawValue_14;
            param_1119 = _e564;
            let _e565 = currentAge_11;
            param_1120 = _e565;
            let _e566 = randVal_16;
            param_1121 = _e566;
            updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1117), (&param_1118), (&param_1119), (&param_1120), (&param_1121));
            break;
        }
        case 14, 15, 16, 17, 13: {
            let _e567 = pos_24;
            param_1122 = _e567;
            let _e568 = currentIndex_16;
            param_1123 = _e568;
            let _e569 = rawValue_14;
            param_1124 = _e569;
            let _e570 = currentDir_6;
            param_1125 = _e570;
            let _e571 = currentSleep_8;
            param_1126 = _e571;
            let _e572 = currentAge_11;
            param_1127 = _e572;
            let _e573 = randVal_16;
            param_1128 = _e573;
            updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1122), (&param_1123), (&param_1124), (&param_1125), (&param_1126), (&param_1127), (&param_1128));
            break;
        }
        case 18: {
            let _e574 = pos_24;
            param_1129 = _e574;
            let _e575 = currentIndex_16;
            param_1130 = _e575;
            let _e576 = rawValue_14;
            param_1131 = _e576;
            let _e577 = currentDir_6;
            param_1132 = _e577;
            let _e578 = currentAge_11;
            param_1133 = _e578;
            let _e579 = randVal_16;
            param_1134 = _e579;
            updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1129), (&param_1130), (&param_1131), (&param_1132), (&param_1133), (&param_1134));
            break;
        }
        case 19: {
            let _e580 = pos_24;
            param_1135 = _e580;
            let _e581 = currentIndex_16;
            param_1136 = _e581;
            let _e582 = rawValue_14;
            param_1137 = _e582;
            let _e583 = currentAge_11;
            param_1138 = _e583;
            let _e584 = randVal_16;
            param_1139 = _e584;
            updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1135), (&param_1136), (&param_1137), (&param_1138), (&param_1139));
            break;
        }
        case 20: {
            let _e585 = pos_24;
            param_1140 = _e585;
            let _e586 = currentIndex_16;
            param_1141 = _e586;
            let _e587 = rawValue_14;
            param_1142 = _e587;
            let _e588 = currentSleep_8;
            param_1143 = _e588;
            let _e589 = currentAge_11;
            param_1144 = _e589;
            let _e590 = randVal_16;
            param_1145 = _e590;
            updateAsh_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1140), (&param_1141), (&param_1142), (&param_1143), (&param_1144), (&param_1145));
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
