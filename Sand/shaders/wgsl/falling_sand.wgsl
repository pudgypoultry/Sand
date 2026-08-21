// GENERATED FILE -- DO NOT EDIT.
//
// Translated from falling_sand.comp by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit falling_sand.comp and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 4cef157d767c8b6a92427010f4681c770b73b32400b276d75a86724cdac46b33

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
    treeMinHeight: u32,
    fireAshChance: f32,
    ashDriftChance: f32,
    ashEnrichChance: f32,
    ashEnrichAmount: u32,
    ashSettleTicks: u32,
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
    let _e216 = (*d);
    if (_e216 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e218 = (*d);
    if (_e218 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e220 = (*d);
    if (_e220 == 2i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    let _e222 = (*d);
    if (_e222 == 3i) {
        return vec3<i32>(0i, 0i, -1i);
    }
    let _e224 = (*d);
    if (_e224 == 4i) {
        return vec3<i32>(1i, 0i, 1i);
    }
    let _e226 = (*d);
    if (_e226 == 5i) {
        return vec3<i32>(1i, 0i, -1i);
    }
    let _e228 = (*d);
    if (_e228 == 6i) {
        return vec3<i32>(-1i, 0i, 1i);
    }
    return vec3<i32>(-1i, 0i, -1i);
}

fn getType_u0028_u1_u003b(val: ptr<function, u32>) -> u32 {
    let _e216 = (*val);
    return (_e216 & 255u);
}

fn readCell_u0028_u1_u003b(index: ptr<function, u32>) -> u32 {
    let _e216 = (*index);
    let _e219 = atomicLoad((&unnamed.grid[_e216]));
    return _e219;
}

fn tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex: ptr<function, u32>, currentValue: ptr<function, u32>, targetIndex: ptr<function, u32>, newValue: ptr<function, u32>) -> bool {
    var targetValue: u32;
    var param: u32;
    var targetType: u32;
    var param_1: u32;
    var currentType: u32;
    var param_2: u32;
    var actual: u32;
    var phi_1759_: bool;
    var phi_1768_: bool;

    let _e226 = (*targetIndex);
    param = _e226;
    let _e227 = readCell_u0028_u1_u003b((&param));
    targetValue = _e227;
    let _e228 = targetValue;
    param_1 = _e228;
    let _e229 = getType_u0028_u1_u003b((&param_1));
    targetType = _e229;
    let _e230 = (*currentValue);
    param_2 = _e230;
    let _e231 = getType_u0028_u1_u003b((&param_2));
    currentType = _e231;
    let _e232 = targetType;
    let _e233 = (_e232 == 0u);
    phi_1759_ = _e233;
    if !(_e233) {
        let _e235 = currentType;
        let _e237 = currentType;
        let _e240 = targetType;
        phi_1759_ = (((_e235 == 1u) || (_e237 == 4u)) && (_e240 == 2u));
    }
    let _e244 = phi_1759_;
    phi_1768_ = _e244;
    if !(_e244) {
        let _e246 = currentType;
        let _e248 = targetType;
        phi_1768_ = ((_e246 == 6u) && (_e248 == 5u));
    }
    let _e252 = phi_1768_;
    if _e252 {
        let _e253 = (*currentIndex);
        let _e256 = (*currentValue);
        let _e257 = atomicCompareExchangeWeak((&unnamed.grid[_e253]), _e256, 0u);
        let _e259 = (*currentValue);
        if (_e257.old_value == _e259) {
            let _e261 = (*targetIndex);
            let _e264 = targetValue;
            let _e265 = (*newValue);
            let _e266 = atomicCompareExchangeWeak((&unnamed.grid[_e261]), _e264, _e265);
            actual = _e266.old_value;
            let _e268 = actual;
            let _e269 = targetValue;
            if (_e268 == _e269) {
                let _e271 = targetType;
                if (_e271 != 0u) {
                    let _e273 = (*currentIndex);
                    let _e276 = targetValue;
                    let _e277 = atomicExchange((&unnamed.grid[_e273]), _e276);
                }
                return true;
            } else {
                let _e278 = (*currentIndex);
                let _e281 = (*currentValue);
                let _e282 = atomicCompareExchangeWeak((&unnamed.grid[_e278]), 0u, _e281);
            }
        }
    }
    return false;
}

fn pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(type_33: ptr<function, u32>, dir: ptr<function, u32>, sleep: ptr<function, u32>, age: ptr<function, u32>) -> u32 {
    let _e219 = (*type_33);
    let _e221 = (*dir);
    let _e226 = (*sleep);
    let _e231 = (*age);
    return ((((_e219 & 255u) | ((_e221 & 255u) << bitcast<u32>(8i))) | ((_e226 & 255u) << bitcast<u32>(16i))) | ((_e231 & 255u) << bitcast<u32>(24i)));
}

fn getAge_u0028_u1_u003b(val_1: ptr<function, u32>) -> u32 {
    let _e216 = (*val_1);
    return ((_e216 >> bitcast<u32>(24i)) & 255u);
}

fn getSleep_u0028_u1_u003b(val_2: ptr<function, u32>) -> u32 {
    let _e216 = (*val_2);
    return ((_e216 >> bitcast<u32>(16i)) & 255u);
}

fn getDir_u0028_u1_u003b(val_3: ptr<function, u32>) -> u32 {
    let _e216 = (*val_3);
    return ((_e216 >> bitcast<u32>(8i)) & 255u);
}

fn getIndex_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    let _e217 = (*pos)[0u];
    let _e219 = (*pos)[1u];
    let _e221 = tuning.gridWidth;
    let _e226 = (*pos)[2u];
    let _e228 = tuning.gridWidth;
    let _e232 = tuning.gridHeight;
    return bitcast<u32>(((_e217 + (_e219 * bitcast<i32>(_e221))) + ((_e226 * bitcast<i32>(_e228)) * bitcast<i32>(_e232))));
}

fn updateAsh_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_1: ptr<function, vec3<i32>>, currentIndex_1: ptr<function, u32>, rawValue: ptr<function, u32>, currentSleep: ptr<function, u32>, randVal: ptr<function, f32>) {
    var param_3: vec3<i32>;
    var param_4: u32;
    var param_5: u32;
    var param_6: vec3<i32>;
    var param_7: u32;
    var param_8: u32;
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
    var phi_7836_: bool;
    var phi_7862_: bool;
    var phi_7883_: bool;
    var phi_8037_: bool;
    var phi_8044_: bool;
    var phi_8055_: bool;
    var phi_8107_: bool;
    var phi_8146_: bool;
    var phi_8153_: bool;
    var phi_8164_: bool;

    let _e293 = (*pos_1)[1u];
    let _e294 = (_e293 > 1i);
    phi_7836_ = _e294;
    if _e294 {
        let _e295 = (*pos_1);
        param_3 = (_e295 + vec3<i32>(0i, -1i, 0i));
        let _e297 = getIndex_u0028_vi3_u003b((&param_3));
        param_4 = _e297;
        let _e298 = readCell_u0028_u1_u003b((&param_4));
        param_5 = _e298;
        let _e299 = getType_u0028_u1_u003b((&param_5));
        phi_7836_ = (_e299 == 2u);
    }
    let _e302 = phi_7836_;
    if _e302 {
        let _e303 = (*currentIndex_1);
        let _e306 = (*rawValue);
        let _e307 = atomicCompareExchangeWeak((&unnamed.grid[_e303]), _e306, 0u);
        return;
    }
    let _e310 = (*pos_1)[1u];
    let _e312 = tuning.gridHeight;
    let _e315 = (_e310 < (bitcast<i32>(_e312) - 1i));
    phi_7862_ = _e315;
    if _e315 {
        let _e316 = (*pos_1);
        param_6 = (_e316 + vec3<i32>(0i, 1i, 0i));
        let _e318 = getIndex_u0028_vi3_u003b((&param_6));
        param_7 = _e318;
        let _e319 = readCell_u0028_u1_u003b((&param_7));
        param_8 = _e319;
        let _e320 = getType_u0028_u1_u003b((&param_8));
        phi_7862_ = (_e320 == 2u);
    }
    let _e323 = phi_7862_;
    if _e323 {
        let _e324 = (*currentIndex_1);
        let _e327 = (*rawValue);
        let _e328 = atomicCompareExchangeWeak((&unnamed.grid[_e324]), _e327, 0u);
        return;
    }
    let _e331 = (*pos_1)[1u];
    let _e332 = (_e331 > 1i);
    phi_7883_ = _e332;
    if _e332 {
        let _e333 = (*randVal);
        let _e337 = tuning.ashEnrichChance;
        phi_7883_ = (fract((_e333 * 19f)) < _e337);
    }
    let _e340 = phi_7883_;
    if _e340 {
        let _e341 = (*pos_1);
        param_9 = (_e341 + vec3<i32>(0i, -1i, 0i));
        let _e343 = getIndex_u0028_vi3_u003b((&param_9));
        belowIndex = _e343;
        let _e344 = belowIndex;
        param_10 = _e344;
        let _e345 = readCell_u0028_u1_u003b((&param_10));
        belowValue = _e345;
        let _e346 = belowValue;
        param_11 = _e346;
        let _e347 = getType_u0028_u1_u003b((&param_11));
        if (_e347 == 4u) {
            let _e349 = belowValue;
            param_12 = _e349;
            let _e350 = getDir_u0028_u1_u003b((&param_12));
            flora = _e350;
            let _e351 = flora;
            if (_e351 < 99u) {
                let _e353 = flora;
                let _e355 = tuning.ashEnrichAmount;
                fed = min((_e353 + max(_e355, 1u)), 99u);
                let _e359 = belowIndex;
                let _e362 = belowValue;
                let _e363 = belowValue;
                param_13 = _e363;
                let _e364 = getSleep_u0028_u1_u003b((&param_13));
                let _e365 = belowValue;
                param_14 = _e365;
                let _e366 = getAge_u0028_u1_u003b((&param_14));
                param_15 = 4u;
                let _e367 = fed;
                param_16 = _e367;
                param_17 = _e364;
                param_18 = _e366;
                let _e368 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_15), (&param_16), (&param_17), (&param_18));
                let _e369 = atomicCompareExchangeWeak((&unnamed.grid[_e359]), _e362, _e368);
                let _e371 = belowValue;
                if (_e369.old_value == _e371) {
                    let _e373 = (*currentIndex_1);
                    let _e376 = (*rawValue);
                    let _e377 = atomicCompareExchangeWeak((&unnamed.grid[_e373]), _e376, 0u);
                    return;
                }
            }
        }
    }
    let _e380 = (*pos_1)[1u];
    if (_e380 > 1i) {
        let _e382 = (*pos_1);
        belowPos = (_e382 + vec3<i32>(0i, -1i, 0i));
        let _e384 = belowPos;
        param_19 = _e384;
        let _e385 = getIndex_u0028_vi3_u003b((&param_19));
        param_20 = _e385;
        let _e386 = readCell_u0028_u1_u003b((&param_20));
        param_21 = _e386;
        let _e387 = getType_u0028_u1_u003b((&param_21));
        if (_e387 == 0u) {
            let _e389 = belowPos;
            param_22 = _e389;
            let _e390 = getIndex_u0028_vi3_u003b((&param_22));
            param_23 = 20u;
            param_24 = 0u;
            param_25 = 0u;
            param_26 = 0u;
            let _e391 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_23), (&param_24), (&param_25), (&param_26));
            let _e392 = (*currentIndex_1);
            param_27 = _e392;
            let _e393 = (*rawValue);
            param_28 = _e393;
            param_29 = _e390;
            param_30 = _e391;
            let _e394 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_27), (&param_28), (&param_29), (&param_30));
            if _e394 {
                return;
            }
        }
        let _e395 = (*randVal);
        dir_1 = select(-1i, 1i, (fract((_e395 * 67f)) > 0.5f));
        let _e400 = (*randVal);
        if (fract((_e400 * 73f)) > 0.5f) {
            let _e404 = (*pos_1);
            let _e405 = dir_1;
            slide[0i] = (_e404 + vec3<i32>(_e405, -1i, 0i));
            let _e409 = (*pos_1);
            let _e410 = dir_1;
            slide[1i] = (_e409 + vec3<i32>(0i, -1i, _e410));
        } else {
            let _e414 = (*pos_1);
            let _e415 = dir_1;
            slide[0i] = (_e414 + vec3<i32>(0i, -1i, _e415));
            let _e419 = (*pos_1);
            let _e420 = dir_1;
            slide[1i] = (_e419 + vec3<i32>(_e420, -1i, 0i));
        }
        s = 0i;
        loop {
            let _e424 = s;
            if (_e424 < 2i) {
                let _e426 = s;
                let _e429 = slide[_e426][0u];
                let _e430 = (_e429 > 0i);
                phi_8037_ = _e430;
                if _e430 {
                    let _e431 = s;
                    let _e434 = slide[_e431][0u];
                    let _e436 = tuning.gridWidth;
                    phi_8037_ = (_e434 < (bitcast<i32>(_e436) - 1i));
                }
                let _e441 = phi_8037_;
                phi_8044_ = _e441;
                if _e441 {
                    let _e442 = s;
                    let _e445 = slide[_e442][2u];
                    phi_8044_ = (_e445 > 0i);
                }
                let _e448 = phi_8044_;
                phi_8055_ = _e448;
                if _e448 {
                    let _e449 = s;
                    let _e452 = slide[_e449][2u];
                    let _e454 = tuning.gridDepth;
                    phi_8055_ = (_e452 < (bitcast<i32>(_e454) - 1i));
                }
                let _e459 = phi_8055_;
                if _e459 {
                    let _e460 = s;
                    let _e462 = slide[_e460];
                    param_31 = _e462;
                    let _e463 = getIndex_u0028_vi3_u003b((&param_31));
                    param_32 = _e463;
                    let _e464 = readCell_u0028_u1_u003b((&param_32));
                    param_33 = _e464;
                    let _e465 = getType_u0028_u1_u003b((&param_33));
                    if (_e465 == 0u) {
                        let _e467 = s;
                        let _e469 = slide[_e467];
                        param_34 = _e469;
                        let _e470 = getIndex_u0028_vi3_u003b((&param_34));
                        param_35 = 20u;
                        param_36 = 0u;
                        param_37 = 0u;
                        param_38 = 0u;
                        let _e471 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_35), (&param_36), (&param_37), (&param_38));
                        let _e472 = (*currentIndex_1);
                        param_39 = _e472;
                        let _e473 = (*rawValue);
                        param_40 = _e473;
                        param_41 = _e470;
                        param_42 = _e471;
                        let _e474 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_39), (&param_40), (&param_41), (&param_42));
                        if _e474 {
                            return;
                        }
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e475 = s;
                s = (_e475 + 1i);
            }
        }
    }
    let _e477 = (*currentSleep);
    let _e479 = tuning.ashSettleTicks;
    let _e480 = (_e477 < _e479);
    phi_8107_ = _e480;
    if _e480 {
        let _e481 = (*randVal);
        let _e485 = tuning.ashDriftChance;
        phi_8107_ = (fract((_e481 * 79f)) < _e485);
    }
    let _e488 = phi_8107_;
    if _e488 {
        let _e489 = (*randVal);
        start = i32((fract((_e489 * 89f)) * 8f));
        i = 0i;
        loop {
            let _e494 = i;
            if (_e494 < 8i) {
                let _e496 = (*pos_1);
                let _e497 = start;
                let _e498 = i;
                let _e499 = (_e497 + _e498);
                param_43 = (_e499 - (i32(floor((f32(_e499) / f32(8i)))) * 8i));
                let _e507 = getHDir_u0028_i1_u003b((&param_43));
                target_ = (_e496 + _e507);
                let _e510 = target_[0u];
                let _e511 = (_e510 <= 0i);
                phi_8146_ = _e511;
                if !(_e511) {
                    let _e514 = target_[0u];
                    let _e516 = tuning.gridWidth;
                    phi_8146_ = (_e514 >= (bitcast<i32>(_e516) - 1i));
                }
                let _e521 = phi_8146_;
                phi_8153_ = _e521;
                if !(_e521) {
                    let _e524 = target_[2u];
                    phi_8153_ = (_e524 <= 0i);
                }
                let _e527 = phi_8153_;
                phi_8164_ = _e527;
                if !(_e527) {
                    let _e530 = target_[2u];
                    let _e532 = tuning.gridDepth;
                    phi_8164_ = (_e530 >= (bitcast<i32>(_e532) - 1i));
                }
                let _e537 = phi_8164_;
                if _e537 {
                    continue;
                }
                let _e538 = target_;
                param_44 = _e538;
                let _e539 = getIndex_u0028_vi3_u003b((&param_44));
                param_45 = _e539;
                let _e540 = readCell_u0028_u1_u003b((&param_45));
                param_46 = _e540;
                let _e541 = getType_u0028_u1_u003b((&param_46));
                if (_e541 != 0u) {
                    continue;
                }
                let _e544 = target_[1u];
                if (_e544 <= 1i) {
                    continue;
                }
                let _e546 = target_;
                param_47 = (_e546 + vec3<i32>(0i, -1i, 0i));
                let _e548 = getIndex_u0028_vi3_u003b((&param_47));
                param_48 = _e548;
                let _e549 = readCell_u0028_u1_u003b((&param_48));
                param_49 = _e549;
                let _e550 = getType_u0028_u1_u003b((&param_49));
                if (_e550 == 0u) {
                    continue;
                }
                let _e552 = (*currentSleep);
                carried = min((_e552 + 1u), 255u);
                let _e555 = target_;
                param_50 = _e555;
                let _e556 = getIndex_u0028_vi3_u003b((&param_50));
                param_51 = 20u;
                param_52 = 0u;
                let _e557 = carried;
                param_53 = _e557;
                param_54 = 0u;
                let _e558 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_51), (&param_52), (&param_53), (&param_54));
                let _e559 = (*currentIndex_1);
                param_55 = _e559;
                let _e560 = (*rawValue);
                param_56 = _e560;
                param_57 = _e556;
                param_58 = _e558;
                let _e561 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_55), (&param_56), (&param_57), (&param_58));
                if _e561 {
                    return;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e562 = i;
                i = (_e562 + 1i);
            }
        }
    }
    let _e564 = (*currentIndex_1);
    let _e567 = (*rawValue);
    let _e568 = (*currentSleep);
    param_59 = 20u;
    param_60 = 0u;
    param_61 = min((_e568 + 1u), 255u);
    param_62 = 0u;
    let _e571 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_59), (&param_60), (&param_61), (&param_62));
    let _e572 = atomicCompareExchangeWeak((&unnamed.grid[_e564]), _e567, _e571);
    return;
}

fn hash_u0028_vf3_u003b(p: ptr<function, vec3<f32>>) -> f32 {
    let _e216 = (*p);
    return fract((sin(dot(_e216, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn treeTargetHeight_u0028_vi3_u003b(pos_2: ptr<function, vec3<i32>>) -> u32 {
    var lo: u32;
    var hi: u32;
    var a: f32;
    var param_63: vec3<f32>;
    var b: f32;
    var param_64: vec3<f32>;
    var t: f32;

    let _e224 = tuning.treeMinHeight;
    lo = max(_e224, 1u);
    let _e227 = tuning.treeMaxHeight;
    let _e228 = lo;
    hi = max(_e227, _e228);
    let _e230 = hi;
    let _e231 = lo;
    if (_e230 == _e231) {
        let _e233 = lo;
        return _e233;
    }
    let _e235 = (*pos_2)[0u];
    let _e238 = (*pos_2)[2u];
    param_63 = vec3<f32>(f32(_e235), 0f, f32(_e238));
    let _e241 = hash_u0028_vf3_u003b((&param_63));
    a = _e241;
    let _e243 = (*pos_2)[2u];
    let _e248 = (*pos_2)[0u];
    param_64 = vec3<f32>(((f32(_e243) * 3f) + 11f), 7f, ((f32(_e248) * 5f) + 3f));
    let _e253 = hash_u0028_vf3_u003b((&param_64));
    b = _e253;
    let _e254 = a;
    let _e255 = b;
    t = clamp(((_e254 + _e255) * 0.5f), 0f, 0.999f);
    let _e259 = lo;
    let _e260 = t;
    let _e261 = hi;
    let _e262 = lo;
    return (_e259 + u32((_e260 * f32(((_e261 - _e262) + 1u)))));
}

fn tree26_u0028_i1_u003b(i_1: ptr<function, i32>) -> vec3<i32> {
    var j: i32;
    var local: i32;

    let _e218 = (*i_1);
    if (_e218 >= 13i) {
        let _e220 = (*i_1);
        local = (_e220 + 1i);
    } else {
        let _e222 = (*i_1);
        local = _e222;
    }
    let _e223 = local;
    j = _e223;
    let _e224 = j;
    let _e232 = j;
    let _e233 = (_e232 / 3i);
    let _e241 = j;
    return (vec3<i32>((_e224 - (i32(floor((f32(_e224) / f32(3i)))) * 3i)), (_e233 - (i32(floor((f32(_e233) / f32(3i)))) * 3i)), (_e241 / 9i)) - vec3<i32>(1i, 1i, 1i));
}

fn treeInBounds_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> bool {
    var phi_1187_: bool;
    var phi_1193_: bool;
    var phi_1203_: bool;
    var phi_1209_: bool;
    var phi_1219_: bool;

    let _e217 = (*p_1)[0u];
    let _e218 = (_e217 > 0i);
    phi_1187_ = _e218;
    if _e218 {
        let _e220 = (*p_1)[0u];
        let _e222 = tuning.gridWidth;
        phi_1187_ = (_e220 < (bitcast<i32>(_e222) - 1i));
    }
    let _e227 = phi_1187_;
    phi_1193_ = _e227;
    if _e227 {
        let _e229 = (*p_1)[1u];
        phi_1193_ = (_e229 > 0i);
    }
    let _e232 = phi_1193_;
    phi_1203_ = _e232;
    if _e232 {
        let _e234 = (*p_1)[1u];
        let _e236 = tuning.gridHeight;
        phi_1203_ = (_e234 < (bitcast<i32>(_e236) - 1i));
    }
    let _e241 = phi_1203_;
    phi_1209_ = _e241;
    if _e241 {
        let _e243 = (*p_1)[2u];
        phi_1209_ = (_e243 > 0i);
    }
    let _e246 = phi_1209_;
    phi_1219_ = _e246;
    if _e246 {
        let _e248 = (*p_1)[2u];
        let _e250 = tuning.gridDepth;
        phi_1219_ = (_e248 < (bitcast<i32>(_e250) - 1i));
    }
    let _e255 = phi_1219_;
    return _e255;
}

fn updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_3: ptr<function, vec3<i32>>, currentIndex_2: ptr<function, u32>, rawValue_1: ptr<function, u32>, currentAge: ptr<function, u32>, randVal_1: ptr<function, f32>) {
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
    var phi_6870_: bool;
    var phi_6955_: bool;
    var phi_7037_: bool;

    let _e267 = (*randVal_1);
    let _e271 = tuning.treeLeafTickChance;
    if (fract((_e267 * 7f)) >= _e271) {
        return;
    }
    let _e273 = (*currentAge);
    if (_e273 == 255u) {
        let _e275 = (*pos_3);
        belowPos_1 = (_e275 + vec3<i32>(0i, -1i, 0i));
        let _e277 = belowPos_1;
        param_65 = _e277;
        let _e278 = treeInBounds_u0028_vi3_u003b((&param_65));
        phi_6870_ = _e278;
        if _e278 {
            let _e279 = belowPos_1;
            param_66 = _e279;
            let _e280 = getIndex_u0028_vi3_u003b((&param_66));
            param_67 = _e280;
            let _e281 = readCell_u0028_u1_u003b((&param_67));
            phi_6870_ = (_e281 == 0u);
        }
        let _e284 = phi_6870_;
        if _e284 {
            let _e285 = belowPos_1;
            param_68 = _e285;
            let _e286 = getIndex_u0028_vi3_u003b((&param_68));
            param_69 = 19u;
            param_70 = 0u;
            param_71 = 0u;
            param_72 = 255u;
            let _e287 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_69), (&param_70), (&param_71), (&param_72));
            let _e288 = (*currentIndex_2);
            param_73 = _e288;
            let _e289 = (*rawValue_1);
            param_74 = _e289;
            param_75 = _e286;
            param_76 = _e287;
            let _e290 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_73), (&param_74), (&param_75), (&param_76));
            if _e290 {
                return;
            }
        }
        let _e291 = (*currentIndex_2);
        let _e294 = (*rawValue_1);
        let _e295 = atomicCompareExchangeWeak((&unnamed.grid[_e291]), _e294, 0u);
        return;
    }
    let _e297 = (*currentAge);
    dist = _e297;
    nearest = 255u;
    touchesTrunk = false;
    let _e298 = (*randVal_1);
    start_1 = i32((fract((_e298 * 71f)) * 26f));
    haveSpot = false;
    let _e303 = (*pos_3);
    spot = _e303;
    i_2 = 0i;
    loop {
        let _e304 = i_2;
        if (_e304 < 26i) {
            let _e306 = (*pos_3);
            let _e307 = start_1;
            let _e308 = i_2;
            let _e309 = (_e307 + _e308);
            param_77 = (_e309 - (i32(floor((f32(_e309) / f32(26i)))) * 26i));
            let _e317 = tree26_u0028_i1_u003b((&param_77));
            c = (_e306 + _e317);
            let _e319 = c;
            param_78 = _e319;
            let _e320 = treeInBounds_u0028_vi3_u003b((&param_78));
            if !(_e320) {
                continue;
            }
            let _e322 = c;
            param_79 = _e322;
            let _e323 = getIndex_u0028_vi3_u003b((&param_79));
            param_80 = _e323;
            let _e324 = readCell_u0028_u1_u003b((&param_80));
            v = _e324;
            let _e325 = v;
            param_81 = _e325;
            let _e326 = getType_u0028_u1_u003b((&param_81));
            t_1 = _e326;
            let _e327 = t_1;
            let _e328 = (_e327 == 18u);
            phi_6955_ = _e328;
            if _e328 {
                let _e329 = v;
                param_82 = _e329;
                let _e330 = getDir_u0028_u1_u003b((&param_82));
                let _e332 = c;
                param_83 = _e332;
                let _e333 = treeTargetHeight_u0028_vi3_u003b((&param_83));
                phi_6955_ = ((_e330 + 1u) >= _e333);
            }
            let _e336 = phi_6955_;
            if _e336 {
                touchesTrunk = true;
            } else {
                let _e337 = t_1;
                if (_e337 == 19u) {
                    let _e339 = nearest;
                    let _e340 = v;
                    param_84 = _e340;
                    let _e341 = getAge_u0028_u1_u003b((&param_84));
                    nearest = min(_e339, _e341);
                } else {
                    let _e343 = v;
                    let _e345 = haveSpot;
                    if ((_e343 == 0u) && !(_e345)) {
                        haveSpot = true;
                        let _e348 = c;
                        spot = _e348;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e349 = i_2;
            i_2 = (_e349 + 1i);
        }
    }
    let _e351 = touchesTrunk;
    if _e351 {
        local_1 = 1u;
    } else {
        let _e352 = nearest;
        if (_e352 >= 255u) {
            local_2 = 255u;
        } else {
            let _e354 = nearest;
            local_2 = (_e354 + 1u);
        }
        let _e356 = local_2;
        local_1 = _e356;
    }
    let _e357 = local_1;
    supported = _e357;
    let _e358 = supported;
    let _e360 = tuning.treeLeafReach;
    if (_e358 > _e360) {
        let _e362 = (*randVal_1);
        let _e366 = tuning.treeLeafFallChance;
        if (fract((_e362 * 83f)) < _e366) {
            let _e368 = (*currentIndex_2);
            let _e371 = (*rawValue_1);
            param_85 = 19u;
            param_86 = 0u;
            param_87 = 0u;
            param_88 = 255u;
            let _e372 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_85), (&param_86), (&param_87), (&param_88));
            let _e373 = atomicCompareExchangeWeak((&unnamed.grid[_e368]), _e371, _e372);
        }
        return;
    }
    let _e375 = supported;
    let _e377 = tuning.treeLeafReach;
    let _e379 = haveSpot;
    let _e380 = ((_e375 < _e377) && _e379);
    phi_7037_ = _e380;
    if _e380 {
        let _e381 = (*randVal_1);
        let _e385 = tuning.treeLeafSpreadChance;
        phi_7037_ = (fract((_e381 * 89f)) < _e385);
    }
    let _e388 = phi_7037_;
    if _e388 {
        let _e389 = spot;
        param_89 = _e389;
        let _e390 = getIndex_u0028_vi3_u003b((&param_89));
        let _e393 = supported;
        param_90 = 19u;
        param_91 = 0u;
        param_92 = 0u;
        param_93 = (_e393 + 1u);
        let _e395 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_90), (&param_91), (&param_92), (&param_93));
        let _e396 = atomicCompareExchangeWeak((&unnamed.grid[_e390]), 0u, _e395);
    }
    let _e398 = supported;
    let _e399 = dist;
    if (_e398 != _e399) {
        let _e401 = (*currentIndex_2);
        let _e404 = (*rawValue_1);
        param_94 = 19u;
        param_95 = 0u;
        param_96 = 0u;
        let _e405 = supported;
        param_97 = _e405;
        let _e406 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_94), (&param_95), (&param_96), (&param_97));
        let _e407 = atomicCompareExchangeWeak((&unnamed.grid[_e401]), _e404, _e406);
    }
    return;
}

fn isGrassBlock_u0028_u1_u003b(value: ptr<function, u32>) -> bool {
    var flora_1: u32;
    var param_98: u32;

    let _e218 = (*value);
    flora_1 = ((_e218 >> bitcast<u32>(8i)) & 255u);
    let _e222 = (*value);
    param_98 = _e222;
    let _e223 = getType_u0028_u1_u003b((&param_98));
    let _e225 = flora_1;
    let _e228 = flora_1;
    return (((_e223 == 4u) && (_e225 > 10u)) && (_e228 <= 100u));
}

fn updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_4: ptr<function, vec3<i32>>, currentIndex_3: ptr<function, u32>, rawValue_2: ptr<function, u32>, currentDir: ptr<function, u32>, currentAge_1: ptr<function, u32>, randVal_2: ptr<function, f32>) {
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
    var moisture: u32;
    var param_105: u32;
    var param_106: u32;
    var param_107: u32;
    var param_108: u32;
    var param_109: u32;
    var param_110: u32;
    var param_111: u32;
    var upPos: vec3<i32>;
    var upIsTrunk: bool;
    var upValue: u32;
    var upIndex: u32;
    var param_112: vec3<i32>;
    var param_113: vec3<i32>;
    var param_114: u32;
    var param_115: u32;
    var param_116: u32;
    var lifted: u32;
    var param_117: u32;
    var param_118: u32;
    var param_119: u32;
    var param_120: u32;
    var param_121: u32;
    var param_122: u32;
    var param_123: vec3<i32>;
    var param_124: vec3<i32>;
    var upType: u32;
    var param_125: u32;
    var sapling: u32;
    var param_126: u32;
    var param_127: u32;
    var param_128: u32;
    var param_129: u32;
    var start_3: i32;
    var i_4: i32;
    var c_2: vec3<i32>;
    var param_130: i32;
    var param_131: vec3<i32>;
    var idx_1: u32;
    var param_132: vec3<i32>;
    var param_133: u32;
    var param_134: u32;
    var param_135: u32;
    var param_136: u32;
    var param_137: u32;
    var start_4: i32;
    var i_5: i32;
    var c_3: vec3<i32>;
    var param_138: i32;
    var param_139: vec3<i32>;
    var idx_2: u32;
    var param_140: vec3<i32>;
    var param_141: u32;
    var param_142: vec3<i32>;
    var param_143: u32;
    var param_144: u32;
    var param_145: u32;
    var param_146: u32;
    var param_147: u32;
    var param_148: u32;
    var param_149: u32;
    var param_150: u32;
    var param_151: u32;
    var param_152: u32;
    var phi_6425_: bool;
    var phi_6569_: bool;
    var phi_6579_: bool;
    var phi_6624_: bool;
    var phi_6675_: bool;
    var phi_6754_: bool;

    let _e302 = (*currentDir);
    height = _e302;
    let _e303 = (*currentAge_1);
    water = _e303;
    changed = false;
    let _e304 = water;
    let _e306 = tuning.treeWaterMax;
    let _e307 = (_e304 < _e306);
    phi_6425_ = _e307;
    if _e307 {
        let _e308 = (*randVal_2);
        let _e312 = tuning.treeDrinkChance;
        phi_6425_ = (fract((_e308 * 13f)) < _e312);
    }
    let _e315 = phi_6425_;
    if _e315 {
        let _e316 = (*randVal_2);
        start_2 = i32((fract((_e316 * 101f)) * 17f));
        k = 0i;
        loop {
            let _e321 = k;
            if (_e321 < 17i) {
                let _e323 = start_2;
                let _e324 = k;
                let _e325 = (_e323 + _e324);
                i_3 = (_e325 - (i32(floor((f32(_e325) / f32(17i)))) * 17i));
                let _e333 = i_3;
                if (_e333 == 0i) {
                    let _e335 = (*pos_4);
                    local_3 = (_e335 + vec3<i32>(0i, -1i, 0i));
                } else {
                    let _e337 = i_3;
                    if (_e337 < 9i) {
                        let _e339 = (*pos_4);
                        let _e340 = i_3;
                        param_99 = (_e340 - 1i);
                        let _e342 = getHDir_u0028_i1_u003b((&param_99));
                        local_4 = ((_e339 + _e342) + vec3<i32>(0i, -1i, 0i));
                    } else {
                        let _e345 = (*pos_4);
                        let _e346 = i_3;
                        param_100 = (_e346 - 9i);
                        let _e348 = getHDir_u0028_i1_u003b((&param_100));
                        local_4 = (_e345 + _e348);
                    }
                    let _e350 = local_4;
                    local_3 = _e350;
                }
                let _e351 = local_3;
                c_1 = _e351;
                let _e352 = c_1;
                param_101 = _e352;
                let _e353 = treeInBounds_u0028_vi3_u003b((&param_101));
                if !(_e353) {
                    continue;
                }
                let _e355 = c_1;
                param_102 = _e355;
                let _e356 = getIndex_u0028_vi3_u003b((&param_102));
                idx = _e356;
                let _e357 = idx;
                param_103 = _e357;
                let _e358 = readCell_u0028_u1_u003b((&param_103));
                v_1 = _e358;
                let _e359 = v_1;
                param_104 = _e359;
                let _e360 = getType_u0028_u1_u003b((&param_104));
                if (_e360 != 4u) {
                    continue;
                }
                let _e362 = v_1;
                param_105 = _e362;
                let _e363 = getAge_u0028_u1_u003b((&param_105));
                moisture = _e363;
                let _e364 = moisture;
                let _e366 = tuning.treeSoilReserve;
                if (_e364 <= _e366) {
                    continue;
                }
                let _e368 = idx;
                let _e371 = v_1;
                let _e372 = v_1;
                param_106 = _e372;
                let _e373 = getDir_u0028_u1_u003b((&param_106));
                let _e374 = v_1;
                param_107 = _e374;
                let _e375 = getSleep_u0028_u1_u003b((&param_107));
                let _e376 = moisture;
                param_108 = 4u;
                param_109 = _e373;
                param_110 = _e375;
                param_111 = (_e376 - 1u);
                let _e378 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_108), (&param_109), (&param_110), (&param_111));
                let _e379 = atomicCompareExchangeWeak((&unnamed.grid[_e368]), _e371, _e378);
                let _e381 = v_1;
                if (_e379.old_value == _e381) {
                    let _e383 = water;
                    water = (_e383 + 1u);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e385 = k;
                k = (_e385 + 1i);
            }
        }
    }
    let _e387 = (*pos_4);
    upPos = (_e387 + vec3<i32>(0i, 1i, 0i));
    upIsTrunk = false;
    upValue = 0u;
    upIndex = 0u;
    let _e389 = upPos;
    param_112 = _e389;
    let _e390 = treeInBounds_u0028_vi3_u003b((&param_112));
    if _e390 {
        let _e391 = upPos;
        param_113 = _e391;
        let _e392 = getIndex_u0028_vi3_u003b((&param_113));
        upIndex = _e392;
        let _e393 = upIndex;
        param_114 = _e393;
        let _e394 = readCell_u0028_u1_u003b((&param_114));
        upValue = _e394;
        let _e395 = upValue;
        param_115 = _e395;
        let _e396 = getType_u0028_u1_u003b((&param_115));
        upIsTrunk = (_e396 == 18u);
    }
    let _e398 = upIsTrunk;
    let _e399 = water;
    let _e401 = (_e398 && (_e399 > 0u));
    phi_6569_ = _e401;
    if _e401 {
        let _e402 = upValue;
        param_116 = _e402;
        let _e403 = getAge_u0028_u1_u003b((&param_116));
        phi_6569_ = (_e403 < 255u);
    }
    let _e406 = phi_6569_;
    phi_6579_ = _e406;
    if _e406 {
        let _e407 = (*randVal_2);
        let _e411 = tuning.treeFlowChance;
        phi_6579_ = (fract((_e407 * 29f)) < _e411);
    }
    let _e414 = phi_6579_;
    if _e414 {
        let _e415 = upValue;
        param_117 = _e415;
        let _e416 = getDir_u0028_u1_u003b((&param_117));
        let _e417 = upValue;
        param_118 = _e417;
        let _e418 = getAge_u0028_u1_u003b((&param_118));
        param_119 = 18u;
        param_120 = _e416;
        param_121 = 0u;
        param_122 = (_e418 + 1u);
        let _e420 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_119), (&param_120), (&param_121), (&param_122));
        lifted = _e420;
        let _e421 = upIndex;
        let _e424 = upValue;
        let _e425 = lifted;
        let _e426 = atomicCompareExchangeWeak((&unnamed.grid[_e421]), _e424, _e425);
        let _e428 = upValue;
        if (_e426.old_value == _e428) {
            let _e430 = water;
            water = (_e430 - 1u);
            changed = true;
        }
    }
    let _e432 = height;
    let _e434 = (*pos_4);
    param_123 = _e434;
    let _e435 = treeTargetHeight_u0028_vi3_u003b((&param_123));
    if ((_e432 + 1u) < _e435) {
        let _e437 = water;
        let _e439 = tuning.treeGrowCost;
        let _e440 = (_e437 >= _e439);
        phi_6624_ = _e440;
        if _e440 {
            let _e441 = upPos;
            param_124 = _e441;
            let _e442 = treeInBounds_u0028_vi3_u003b((&param_124));
            phi_6624_ = _e442;
        }
        let _e444 = phi_6624_;
        if _e444 {
            let _e445 = upValue;
            param_125 = _e445;
            let _e446 = getType_u0028_u1_u003b((&param_125));
            upType = _e446;
            let _e447 = upType;
            let _e449 = upType;
            if ((_e447 == 0u) || (_e449 == 19u)) {
                let _e452 = height;
                param_126 = 18u;
                param_127 = (_e452 + 1u);
                param_128 = 0u;
                param_129 = 0u;
                let _e454 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_126), (&param_127), (&param_128), (&param_129));
                sapling = _e454;
                let _e455 = upIndex;
                let _e458 = upValue;
                let _e459 = sapling;
                let _e460 = atomicCompareExchangeWeak((&unnamed.grid[_e455]), _e458, _e459);
                let _e462 = upValue;
                if (_e460.old_value == _e462) {
                    let _e465 = tuning.treeGrowCost;
                    let _e466 = water;
                    water = (_e466 - _e465);
                    changed = true;
                }
            }
        }
    } else {
        let _e468 = water;
        let _e470 = tuning.treeLeafCost;
        let _e471 = (_e468 >= _e470);
        phi_6675_ = _e471;
        if _e471 {
            let _e472 = (*randVal_2);
            let _e476 = tuning.treeLeafChance;
            phi_6675_ = (fract((_e472 * 37f)) < _e476);
        }
        let _e479 = phi_6675_;
        if _e479 {
            let _e480 = (*randVal_2);
            start_3 = i32((fract((_e480 * 43f)) * 26f));
            i_4 = 0i;
            loop {
                let _e485 = i_4;
                if (_e485 < 26i) {
                    let _e487 = (*pos_4);
                    let _e488 = start_3;
                    let _e489 = i_4;
                    let _e490 = (_e488 + _e489);
                    param_130 = (_e490 - (i32(floor((f32(_e490) / f32(26i)))) * 26i));
                    let _e498 = tree26_u0028_i1_u003b((&param_130));
                    c_2 = (_e487 + _e498);
                    let _e500 = c_2;
                    param_131 = _e500;
                    let _e501 = treeInBounds_u0028_vi3_u003b((&param_131));
                    if !(_e501) {
                        continue;
                    }
                    let _e503 = c_2;
                    param_132 = _e503;
                    let _e504 = getIndex_u0028_vi3_u003b((&param_132));
                    idx_1 = _e504;
                    let _e505 = idx_1;
                    param_133 = _e505;
                    let _e506 = readCell_u0028_u1_u003b((&param_133));
                    if (_e506 != 0u) {
                        continue;
                    }
                    let _e508 = idx_1;
                    param_134 = 19u;
                    param_135 = 0u;
                    param_136 = 0u;
                    param_137 = 1u;
                    let _e511 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_134), (&param_135), (&param_136), (&param_137));
                    let _e512 = atomicCompareExchangeWeak((&unnamed.grid[_e508]), 0u, _e511);
                    if (_e512.old_value == 0u) {
                        let _e516 = tuning.treeLeafCost;
                        let _e517 = water;
                        water = (_e517 - _e516);
                        changed = true;
                        break;
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e519 = i_4;
                    i_4 = (_e519 + 1i);
                }
            }
        }
    }
    let _e521 = water;
    let _e523 = tuning.treeSpreadCost;
    let _e524 = (_e521 >= _e523);
    phi_6754_ = _e524;
    if _e524 {
        let _e525 = (*randVal_2);
        let _e529 = tuning.treeSpreadChance;
        phi_6754_ = (fract((_e525 * 59f)) < _e529);
    }
    let _e532 = phi_6754_;
    if _e532 {
        let _e533 = (*randVal_2);
        start_4 = i32((fract((_e533 * 61f)) * 8f));
        i_5 = 0i;
        loop {
            let _e538 = i_5;
            if (_e538 < 8i) {
                let _e540 = (*pos_4);
                let _e541 = start_4;
                let _e542 = i_5;
                let _e543 = (_e541 + _e542);
                param_138 = (_e543 - (i32(floor((f32(_e543) / f32(8i)))) * 8i));
                let _e551 = getHDir_u0028_i1_u003b((&param_138));
                c_3 = (_e540 + _e551);
                let _e553 = c_3;
                param_139 = _e553;
                let _e554 = treeInBounds_u0028_vi3_u003b((&param_139));
                if !(_e554) {
                    continue;
                }
                let _e556 = c_3;
                param_140 = _e556;
                let _e557 = getIndex_u0028_vi3_u003b((&param_140));
                idx_2 = _e557;
                let _e558 = idx_2;
                param_141 = _e558;
                let _e559 = readCell_u0028_u1_u003b((&param_141));
                if (_e559 != 0u) {
                    continue;
                }
                let _e561 = c_3;
                param_142 = (_e561 + vec3<i32>(0i, -1i, 0i));
                let _e563 = getIndex_u0028_vi3_u003b((&param_142));
                param_143 = _e563;
                let _e564 = readCell_u0028_u1_u003b((&param_143));
                param_144 = _e564;
                let _e565 = isGrassBlock_u0028_u1_u003b((&param_144));
                if !(_e565) {
                    continue;
                }
                let _e567 = idx_2;
                param_145 = 18u;
                param_146 = 0u;
                param_147 = 0u;
                param_148 = 0u;
                let _e570 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_145), (&param_146), (&param_147), (&param_148));
                let _e571 = atomicCompareExchangeWeak((&unnamed.grid[_e567]), 0u, _e570);
                if (_e571.old_value == 0u) {
                    let _e575 = tuning.treeSpreadCost;
                    let _e576 = water;
                    water = (_e576 - _e575);
                    changed = true;
                    break;
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
    }
    let _e580 = changed;
    if _e580 {
        let _e581 = (*currentIndex_3);
        let _e584 = (*rawValue_2);
        param_149 = 18u;
        let _e585 = height;
        param_150 = _e585;
        param_151 = 0u;
        let _e586 = water;
        param_152 = _e586;
        let _e587 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_149), (&param_150), (&param_151), (&param_152));
        let _e588 = atomicCompareExchangeWeak((&unnamed.grid[_e581]), _e584, _e587);
    }
    return;
}

fn locustPackNav_u0028_u1_u003b_u1_u003b(heading: ptr<function, u32>, steps: ptr<function, u32>) -> u32 {
    let _e217 = (*heading);
    let _e219 = (*steps);
    return ((_e217 & 7u) | (min(_e219, 7u) << bitcast<u32>(3i)));
}

fn locustReverse_u0028_u1_u003b(d_1: ptr<function, u32>) -> u32 {
    let _e216 = (*d_1);
    if (_e216 == 0u) {
        return 1u;
    }
    let _e218 = (*d_1);
    if (_e218 == 1u) {
        return 0u;
    }
    let _e220 = (*d_1);
    if (_e220 == 2u) {
        return 3u;
    }
    let _e222 = (*d_1);
    if (_e222 == 3u) {
        return 2u;
    }
    let _e224 = (*d_1);
    if (_e224 == 4u) {
        return 7u;
    }
    let _e226 = (*d_1);
    if (_e226 == 5u) {
        return 6u;
    }
    let _e228 = (*d_1);
    if (_e228 == 6u) {
        return 5u;
    }
    return 4u;
}

fn locustRunSteps_u0028_() -> u32 {
    let _e216 = tuning.locustRunLength;
    return clamp(_e216, 1u, 7u);
}

fn isLocustFood_u0028_u1_u003b(value_1: ptr<function, u32>) -> bool {
    var param_153: u32;
    var param_154: u32;
    var phi_980_: bool;

    let _e218 = (*value_1);
    param_153 = _e218;
    let _e219 = isGrassBlock_u0028_u1_u003b((&param_153));
    phi_980_ = _e219;
    if !(_e219) {
        let _e221 = (*value_1);
        param_154 = _e221;
        let _e222 = getType_u0028_u1_u003b((&param_154));
        phi_980_ = (_e222 == 19u);
    }
    let _e225 = phi_980_;
    return _e225;
}

fn locustFoodAt_u0028_vi3_u003b(p_2: ptr<function, vec3<i32>>) -> bool {
    var param_155: vec3<i32>;
    var param_156: u32;
    var param_157: u32;
    var phi_995_: bool;
    var phi_1002_: bool;
    var phi_1012_: bool;
    var phi_1019_: bool;
    var phi_1029_: bool;

    let _e220 = (*p_2)[0u];
    let _e221 = (_e220 < 0i);
    phi_995_ = _e221;
    if !(_e221) {
        let _e224 = (*p_2)[0u];
        let _e226 = tuning.gridWidth;
        phi_995_ = (_e224 >= bitcast<i32>(_e226));
    }
    let _e230 = phi_995_;
    phi_1002_ = _e230;
    if !(_e230) {
        let _e233 = (*p_2)[1u];
        phi_1002_ = (_e233 < 0i);
    }
    let _e236 = phi_1002_;
    phi_1012_ = _e236;
    if !(_e236) {
        let _e239 = (*p_2)[1u];
        let _e241 = tuning.gridHeight;
        phi_1012_ = (_e239 >= bitcast<i32>(_e241));
    }
    let _e245 = phi_1012_;
    phi_1019_ = _e245;
    if !(_e245) {
        let _e248 = (*p_2)[2u];
        phi_1019_ = (_e248 < 0i);
    }
    let _e251 = phi_1019_;
    phi_1029_ = _e251;
    if !(_e251) {
        let _e254 = (*p_2)[2u];
        let _e256 = tuning.gridDepth;
        phi_1029_ = (_e254 >= bitcast<i32>(_e256));
    }
    let _e260 = phi_1029_;
    if _e260 {
        return false;
    }
    let _e261 = (*p_2);
    param_155 = _e261;
    let _e262 = getIndex_u0028_vi3_u003b((&param_155));
    param_156 = _e262;
    let _e263 = readCell_u0028_u1_u003b((&param_156));
    param_157 = _e263;
    let _e264 = isLocustFood_u0028_u1_u003b((&param_157));
    return _e264;
}

fn locustSteps_u0028_u1_u003b(dirByte: ptr<function, u32>) -> u32 {
    let _e216 = (*dirByte);
    return ((_e216 >> bitcast<u32>(3i)) & 7u);
}

fn locustHeading_u0028_u1_u003b(dirByte_1: ptr<function, u32>) -> u32 {
    let _e216 = (*dirByte_1);
    return (_e216 & 7u);
}

fn locustArriveDir_u0028_vi3_u003b_u1_u003b(dest: ptr<function, vec3<i32>>, nav: ptr<function, u32>) -> u32 {
    var param_158: vec3<i32>;

    let _e218 = (*dest);
    param_158 = (_e218 + vec3<i32>(0i, -1i, 0i));
    let _e220 = locustFoodAt_u0028_vi3_u003b((&param_158));
    let _e221 = (*nav);
    return select(_e221, 0u, _e220);
}

fn locustHasGrip_u0028_vi3_u003b(pos_5: ptr<function, vec3<i32>>) -> bool {
    var d_2: i32;
    var n: vec3<i32>;
    var param_159: i32;
    var param_160: vec3<i32>;
    var param_161: u32;
    var phi_1132_: bool;
    var phi_1139_: bool;
    var phi_1150_: bool;

    d_2 = 0i;
    loop {
        let _e221 = d_2;
        if (_e221 < 8i) {
            let _e223 = (*pos_5);
            let _e224 = d_2;
            param_159 = _e224;
            let _e225 = getHDir_u0028_i1_u003b((&param_159));
            n = (_e223 + _e225);
            let _e228 = n[0u];
            let _e229 = (_e228 <= 0i);
            phi_1132_ = _e229;
            if !(_e229) {
                let _e232 = n[0u];
                let _e234 = tuning.gridWidth;
                phi_1132_ = (_e232 >= (bitcast<i32>(_e234) - 1i));
            }
            let _e239 = phi_1132_;
            phi_1139_ = _e239;
            if !(_e239) {
                let _e242 = n[2u];
                phi_1139_ = (_e242 <= 0i);
            }
            let _e245 = phi_1139_;
            phi_1150_ = _e245;
            if !(_e245) {
                let _e248 = n[2u];
                let _e250 = tuning.gridDepth;
                phi_1150_ = (_e248 >= (bitcast<i32>(_e250) - 1i));
            }
            let _e255 = phi_1150_;
            if _e255 {
                continue;
            }
            let _e256 = n;
            param_160 = _e256;
            let _e257 = getIndex_u0028_vi3_u003b((&param_160));
            param_161 = _e257;
            let _e258 = readCell_u0028_u1_u003b((&param_161));
            if (_e258 != 0u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e260 = d_2;
            d_2 = (_e260 + 1i);
        }
    }
    return false;
}

fn locustStage_u0028_() -> u32 {
    let _e216 = tuning.locustStageSize;
    return max(_e216, 1u);
}

fn locustTypeFor_u0028_u1_u003b(count: ptr<function, u32>) -> u32 {
    var stage: u32;
    var local_5: u32;

    let _e218 = (*count);
    if (_e218 == 0u) {
        local_5 = 0u;
    } else {
        let _e220 = (*count);
        let _e222 = locustStage_u0028_();
        local_5 = ((_e220 - 1u) / _e222);
    }
    let _e224 = local_5;
    stage = _e224;
    let _e225 = stage;
    return (13u + min(_e225, 4u));
}

fn locustInBounds_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> bool {
    var phi_916_: bool;
    var phi_922_: bool;
    var phi_932_: bool;
    var phi_938_: bool;
    var phi_948_: bool;

    let _e217 = (*p_3)[0u];
    let _e218 = (_e217 > 0i);
    phi_916_ = _e218;
    if _e218 {
        let _e220 = (*p_3)[0u];
        let _e222 = tuning.gridWidth;
        phi_916_ = (_e220 < (bitcast<i32>(_e222) - 1i));
    }
    let _e227 = phi_916_;
    phi_922_ = _e227;
    if _e227 {
        let _e229 = (*p_3)[1u];
        phi_922_ = (_e229 > 0i);
    }
    let _e232 = phi_922_;
    phi_932_ = _e232;
    if _e232 {
        let _e234 = (*p_3)[1u];
        let _e236 = tuning.gridHeight;
        phi_932_ = (_e234 < (bitcast<i32>(_e236) - 1i));
    }
    let _e241 = phi_932_;
    phi_938_ = _e241;
    if _e241 {
        let _e243 = (*p_3)[2u];
        phi_938_ = (_e243 > 0i);
    }
    let _e246 = phi_938_;
    phi_948_ = _e246;
    if _e246 {
        let _e248 = (*p_3)[2u];
        let _e250 = tuning.gridDepth;
        phi_948_ = (_e248 < (bitcast<i32>(_e250) - 1i));
    }
    let _e255 = phi_948_;
    return _e255;
}

fn locustMaxCount_u0028_() -> u32 {
    let _e216 = tuning.locustMaxSize;
    return max(_e216, 1u);
}

fn locustBud_u0028_vi3_u003b_f1_u003b(pos_6: ptr<function, vec3<i32>>, randVal_3: ptr<function, f32>) {
    var bud: u32;
    var start_5: i32;
    var i_6: i32;
    var d_3: i32;
    var c_4: vec3<i32>;
    var param_162: i32;
    var param_163: vec3<i32>;
    var idx_3: u32;
    var param_164: vec3<i32>;
    var param_165: u32;
    var param_166: u32;
    var param_167: u32;
    var param_168: u32;
    var param_169: u32;
    var param_170: u32;

    let _e233 = tuning.locustBudSize;
    let _e234 = locustMaxCount_u0028_();
    bud = clamp(_e233, 1u, _e234);
    let _e236 = (*randVal_3);
    start_5 = i32((fract((_e236 * 31f)) * 8f));
    i_6 = 0i;
    loop {
        let _e241 = i_6;
        if (_e241 < 8i) {
            let _e243 = start_5;
            let _e244 = i_6;
            let _e245 = (_e243 + _e244);
            d_3 = (_e245 - (i32(floor((f32(_e245) / f32(8i)))) * 8i));
            let _e253 = (*pos_6);
            let _e254 = d_3;
            param_162 = _e254;
            let _e255 = getHDir_u0028_i1_u003b((&param_162));
            c_4 = (_e253 + _e255);
            let _e257 = c_4;
            param_163 = _e257;
            let _e258 = locustInBounds_u0028_vi3_u003b((&param_163));
            if !(_e258) {
                continue;
            }
            let _e260 = c_4;
            param_164 = _e260;
            let _e261 = getIndex_u0028_vi3_u003b((&param_164));
            idx_3 = _e261;
            let _e262 = idx_3;
            param_165 = _e262;
            let _e263 = readCell_u0028_u1_u003b((&param_165));
            if (_e263 != 0u) {
                continue;
            }
            let _e265 = idx_3;
            let _e268 = bud;
            param_166 = _e268;
            let _e269 = locustTypeFor_u0028_u1_u003b((&param_166));
            param_167 = _e269;
            param_168 = 0u;
            param_169 = 0u;
            let _e270 = bud;
            param_170 = _e270;
            let _e271 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_167), (&param_168), (&param_169), (&param_170));
            let _e272 = atomicCompareExchangeWeak((&unnamed.grid[_e265]), 0u, _e271);
            if (_e272.old_value == 0u) {
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e275 = i_6;
            i_6 = (_e275 + 1i);
        }
    }
    return;
}

fn locustEatTicks_u0028_u1_u003b(count_1: ptr<function, u32>) -> u32 {
    var fast: u32;
    var slow: u32;
    var cap: u32;
    var floorCount: u32;
    var t_2: f32;

    let _e222 = tuning.locustEatTicksMin;
    fast = _e222;
    let _e224 = tuning.locustEatTicksMax;
    slow = _e224;
    let _e225 = locustMaxCount_u0028_();
    cap = _e225;
    let _e226 = locustStage_u0028_();
    let _e227 = cap;
    floorCount = min(_e226, _e227);
    let _e229 = (*count_1);
    let _e230 = cap;
    if (_e229 >= _e230) {
        let _e232 = fast;
        return _e232;
    }
    let _e233 = (*count_1);
    let _e234 = floorCount;
    let _e236 = cap;
    let _e237 = floorCount;
    if ((_e233 <= _e234) || (_e236 == _e237)) {
        let _e240 = slow;
        return _e240;
    }
    let _e241 = (*count_1);
    let _e242 = floorCount;
    let _e245 = cap;
    let _e246 = floorCount;
    t_2 = (f32((_e241 - _e242)) / f32((_e245 - _e246)));
    let _e250 = slow;
    let _e252 = fast;
    let _e254 = t_2;
    return u32(round(mix(f32(_e250), f32(_e252), _e254)));
}

fn isLava_u0028_u1_u003b(type_34: ptr<function, u32>) -> bool {
    let _e216 = (*type_34);
    let _e218 = (*type_34);
    return ((_e216 >= 8u) && (_e218 <= 11u));
}

fn updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_7: ptr<function, vec3<i32>>, currentIndex_4: ptr<function, u32>, rawValue_3: ptr<function, u32>, currentDir_1: ptr<function, u32>, currentSleep_1: ptr<function, u32>, currentAge_2: ptr<function, u32>, randVal_4: ptr<function, f32>) {
    var type_35: u32;
    var param_171: u32;
    var start_6: i32;
    var i_7: i32;
    var nPos: vec3<i32>;
    var param_172: i32;
    var param_173: vec3<i32>;
    var nType: u32;
    var param_174: vec3<i32>;
    var param_175: u32;
    var param_176: u32;
    var param_177: u32;
    var phase: u32;
    var param_178: u32;
    var param_179: u32;
    var param_180: u32;
    var param_181: u32;
    var count_2: u32;
    var belowPos_2: vec3<i32>;
    var belowIndex_1: u32;
    var param_182: vec3<i32>;
    var belowValue_1: u32;
    var param_183: u32;
    var param_184: u32;
    var onLeaf: bool;
    var param_185: u32;
    var need: u32;
    var param_186: u32;
    var progress: u32;
    var flora_2: u32;
    var bite: u32;
    var thinned: u32;
    var local_6: u32;
    var param_187: u32;
    var param_188: u32;
    var param_189: u32;
    var param_190: u32;
    var param_191: u32;
    var param_192: u32;
    var param_193: u32;
    var param_194: u32;
    var param_195: u32;
    var param_196: u32;
    var stripped: u32;
    var local_7: u32;
    var param_197: u32;
    var param_198: u32;
    var param_199: u32;
    var param_200: u32;
    var param_201: u32;
    var param_202: u32;
    var grown: u32;
    var param_203: vec3<i32>;
    var param_204: f32;
    var param_205: u32;
    var param_206: u32;
    var param_207: u32;
    var param_208: u32;
    var param_209: u32;
    var newType: u32;
    var param_210: u32;
    var param_211: u32;
    var param_212: vec3<i32>;
    var param_213: vec3<i32>;
    var param_214: vec3<i32>;
    var param_215: u32;
    var param_216: u32;
    var param_217: u32;
    var param_218: u32;
    var param_219: u32;
    var param_220: u32;
    var param_221: u32;
    var param_222: u32;
    var param_223: u32;
    var heading_1: u32;
    var param_224: u32;
    var steps_1: u32;
    var param_225: u32;
    var start_7: i32;
    var i_8: i32;
    var d_4: i32;
    var c_5: vec3<i32>;
    var param_226: i32;
    var rise: i32;
    var t_3: vec3<i32>;
    var local_8: i32;
    var param_227: vec3<i32>;
    var param_228: vec3<i32>;
    var param_229: u32;
    var param_230: vec3<i32>;
    var param_231: vec3<i32>;
    var param_232: u32;
    var param_233: u32;
    var param_234: u32;
    var param_235: u32;
    var param_236: u32;
    var param_237: u32;
    var param_238: u32;
    var param_239: u32;
    var target_1: vec3<i32>;
    var param_240: i32;
    var blocked: bool;
    var param_241: vec3<i32>;
    var param_242: vec3<i32>;
    var param_243: u32;
    var footing: vec3<i32>;
    var param_244: vec3<i32>;
    var param_245: vec3<i32>;
    var param_246: u32;
    var back: u32;
    var param_247: u32;
    var backPos: vec3<i32>;
    var param_248: i32;
    var backFoot: vec3<i32>;
    var backOpen: bool;
    var param_249: vec3<i32>;
    var param_250: vec3<i32>;
    var param_251: u32;
    var param_252: vec3<i32>;
    var param_253: vec3<i32>;
    var param_254: u32;
    var turnedNav: u32;
    var local_9: u32;
    var param_255: u32;
    var param_256: u32;
    var param_257: u32;
    var param_258: u32;
    var param_259: u32;
    var param_260: u32;
    var param_261: u32;
    var param_262: u32;
    var nav_1: u32;
    var param_263: u32;
    var param_264: u32;
    var param_265: vec3<i32>;
    var param_266: vec3<i32>;
    var param_267: u32;
    var param_268: u32;
    var param_269: u32;
    var param_270: u32;
    var param_271: u32;
    var param_272: u32;
    var param_273: u32;
    var param_274: u32;
    var param_275: u32;
    var overTop: vec3<i32>;
    var param_276: vec3<i32>;
    var param_277: vec3<i32>;
    var param_278: u32;
    var nav_2: u32;
    var param_279: u32;
    var param_280: u32;
    var param_281: vec3<i32>;
    var param_282: vec3<i32>;
    var param_283: u32;
    var param_284: u32;
    var param_285: u32;
    var param_286: u32;
    var param_287: u32;
    var param_288: u32;
    var param_289: u32;
    var param_290: u32;
    var param_291: u32;
    var up: vec3<i32>;
    var param_292: vec3<i32>;
    var param_293: vec3<i32>;
    var param_294: u32;
    var nav_3: u32;
    var param_295: u32;
    var param_296: u32;
    var param_297: vec3<i32>;
    var param_298: vec3<i32>;
    var param_299: u32;
    var param_300: u32;
    var param_301: u32;
    var param_302: u32;
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
    var phi_7184_: bool;
    var phi_7392_: bool;
    var phi_7399_: bool;
    var phi_7560_: bool;
    var phi_7579_: bool;
    var phi_7608_: bool;
    var phi_7622_: bool;
    var phi_7624_: bool;
    var phi_7716_: bool;
    var phi_7765_: bool;

    let _e409 = (*rawValue_3);
    param_171 = _e409;
    let _e410 = getType_u0028_u1_u003b((&param_171));
    type_35 = _e410;
    let _e411 = (*randVal_4);
    start_6 = i32((fract((_e411 * 61f)) * 26f));
    i_7 = 0i;
    loop {
        let _e416 = i_7;
        if (_e416 < 26i) {
            let _e418 = (*pos_7);
            let _e419 = start_6;
            let _e420 = i_7;
            let _e421 = (_e419 + _e420);
            param_172 = (_e421 - (i32(floor((f32(_e421) / f32(26i)))) * 26i));
            let _e429 = tree26_u0028_i1_u003b((&param_172));
            nPos = (_e418 + _e429);
            let _e431 = nPos;
            param_173 = _e431;
            let _e432 = locustInBounds_u0028_vi3_u003b((&param_173));
            if !(_e432) {
                continue;
            }
            let _e434 = nPos;
            param_174 = _e434;
            let _e435 = getIndex_u0028_vi3_u003b((&param_174));
            param_175 = _e435;
            let _e436 = readCell_u0028_u1_u003b((&param_175));
            param_176 = _e436;
            let _e437 = getType_u0028_u1_u003b((&param_176));
            nType = _e437;
            let _e438 = nType;
            let _e439 = (_e438 == 5u);
            phi_7184_ = _e439;
            if !(_e439) {
                let _e441 = nType;
                param_177 = _e441;
                let _e442 = isLava_u0028_u1_u003b((&param_177));
                phi_7184_ = _e442;
            }
            let _e444 = phi_7184_;
            if _e444 {
                let _e445 = (*currentIndex_4);
                let _e448 = (*rawValue_3);
                let _e449 = atomicCompareExchangeWeak((&unnamed.grid[_e445]), _e448, 0u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e451 = i_7;
            i_7 = (_e451 + 1i);
        }
    }
    let _e453 = (*currentSleep_1);
    phase = (_e453 + 1u);
    let _e455 = phase;
    let _e457 = tuning.locustTickDispatches;
    if (_e455 < _e457) {
        let _e459 = (*currentIndex_4);
        let _e462 = (*rawValue_3);
        let _e463 = type_35;
        param_178 = _e463;
        let _e464 = (*currentDir_1);
        param_179 = _e464;
        let _e465 = phase;
        param_180 = _e465;
        let _e466 = (*currentAge_2);
        param_181 = _e466;
        let _e467 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_178), (&param_179), (&param_180), (&param_181));
        let _e468 = atomicCompareExchangeWeak((&unnamed.grid[_e459]), _e462, _e467);
        return;
    }
    let _e470 = (*currentAge_2);
    count_2 = _e470;
    let _e471 = (*pos_7);
    belowPos_2 = (_e471 + vec3<i32>(0i, -1i, 0i));
    let _e473 = belowPos_2;
    param_182 = _e473;
    let _e474 = getIndex_u0028_vi3_u003b((&param_182));
    belowIndex_1 = _e474;
    let _e475 = belowIndex_1;
    param_183 = _e475;
    let _e476 = readCell_u0028_u1_u003b((&param_183));
    belowValue_1 = _e476;
    let _e477 = belowValue_1;
    param_184 = _e477;
    let _e478 = isLocustFood_u0028_u1_u003b((&param_184));
    if _e478 {
        let _e479 = belowValue_1;
        param_185 = _e479;
        let _e480 = getType_u0028_u1_u003b((&param_185));
        onLeaf = (_e480 == 19u);
        let _e482 = count_2;
        param_186 = _e482;
        let _e483 = locustEatTicks_u0028_u1_u003b((&param_186));
        need = _e483;
        let _e484 = (*currentDir_1);
        progress = (_e484 + 1u);
        let _e486 = progress;
        let _e487 = need;
        if (_e486 < _e487) {
            let _e489 = onLeaf;
            if !(_e489) {
                let _e491 = belowValue_1;
                flora_2 = ((_e491 >> bitcast<u32>(8i)) & 255u);
                let _e495 = need;
                bite = max((90u / max(_e495, 1u)), 1u);
                let _e499 = flora_2;
                let _e500 = bite;
                if (_e499 > (11u + _e500)) {
                    let _e503 = flora_2;
                    let _e504 = bite;
                    local_6 = (_e503 - _e504);
                } else {
                    local_6 = 11u;
                }
                let _e506 = local_6;
                thinned = _e506;
                let _e507 = belowIndex_1;
                let _e510 = belowValue_1;
                let _e511 = belowValue_1;
                param_187 = _e511;
                let _e512 = getSleep_u0028_u1_u003b((&param_187));
                let _e513 = belowValue_1;
                param_188 = _e513;
                let _e514 = getAge_u0028_u1_u003b((&param_188));
                param_189 = 4u;
                let _e515 = thinned;
                param_190 = _e515;
                param_191 = _e512;
                param_192 = _e514;
                let _e516 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_189), (&param_190), (&param_191), (&param_192));
                let _e517 = atomicCompareExchangeWeak((&unnamed.grid[_e507]), _e510, _e516);
            }
            let _e519 = (*currentIndex_4);
            let _e522 = (*rawValue_3);
            let _e523 = type_35;
            param_193 = _e523;
            let _e524 = progress;
            param_194 = _e524;
            param_195 = 0u;
            let _e525 = count_2;
            param_196 = _e525;
            let _e526 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_193), (&param_194), (&param_195), (&param_196));
            let _e527 = atomicCompareExchangeWeak((&unnamed.grid[_e519]), _e522, _e526);
            return;
        }
        let _e529 = onLeaf;
        if _e529 {
            local_7 = 0u;
        } else {
            let _e530 = belowValue_1;
            param_197 = _e530;
            let _e531 = getSleep_u0028_u1_u003b((&param_197));
            let _e532 = belowValue_1;
            param_198 = _e532;
            let _e533 = getAge_u0028_u1_u003b((&param_198));
            param_199 = 4u;
            param_200 = 0u;
            param_201 = _e531;
            param_202 = _e533;
            let _e534 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_199), (&param_200), (&param_201), (&param_202));
            local_7 = _e534;
        }
        let _e535 = local_7;
        stripped = _e535;
        let _e536 = belowIndex_1;
        let _e539 = belowValue_1;
        let _e540 = stripped;
        let _e541 = atomicCompareExchangeWeak((&unnamed.grid[_e536]), _e539, _e540);
        let _e543 = belowValue_1;
        if (_e541.old_value != _e543) {
            return;
        }
        let _e545 = count_2;
        let _e547 = tuning.locustEatGain;
        grown = (_e545 + _e547);
        let _e549 = grown;
        let _e550 = locustMaxCount_u0028_();
        if (_e549 > _e550) {
            let _e552 = (*pos_7);
            param_203 = _e552;
            let _e553 = (*randVal_4);
            param_204 = _e553;
            locustBud_u0028_vi3_u003b_f1_u003b((&param_203), (&param_204));
            let _e554 = locustMaxCount_u0028_();
            grown = _e554;
        }
        let _e555 = (*currentIndex_4);
        let _e558 = (*rawValue_3);
        let _e559 = grown;
        param_205 = _e559;
        let _e560 = locustTypeFor_u0028_u1_u003b((&param_205));
        param_206 = _e560;
        param_207 = 0u;
        param_208 = 0u;
        let _e561 = grown;
        param_209 = _e561;
        let _e562 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_206), (&param_207), (&param_208), (&param_209));
        let _e563 = atomicCompareExchangeWeak((&unnamed.grid[_e555]), _e558, _e562);
        return;
    }
    let _e565 = count_2;
    if (_e565 <= 1u) {
        let _e567 = (*currentIndex_4);
        let _e570 = (*rawValue_3);
        let _e571 = atomicCompareExchangeWeak((&unnamed.grid[_e567]), _e570, 0u);
        return;
    }
    let _e573 = count_2;
    count_2 = (_e573 - 1u);
    let _e575 = count_2;
    param_210 = _e575;
    let _e576 = locustTypeFor_u0028_u1_u003b((&param_210));
    newType = _e576;
    let _e577 = belowValue_1;
    param_211 = _e577;
    let _e578 = getType_u0028_u1_u003b((&param_211));
    let _e579 = (_e578 == 0u);
    phi_7392_ = _e579;
    if _e579 {
        let _e580 = belowPos_2;
        param_212 = _e580;
        let _e581 = locustInBounds_u0028_vi3_u003b((&param_212));
        phi_7392_ = _e581;
    }
    let _e583 = phi_7392_;
    phi_7399_ = _e583;
    if _e583 {
        let _e584 = (*pos_7);
        param_213 = _e584;
        let _e585 = locustHasGrip_u0028_vi3_u003b((&param_213));
        phi_7399_ = !(_e585);
    }
    let _e588 = phi_7399_;
    if _e588 {
        let _e589 = belowPos_2;
        param_214 = _e589;
        let _e590 = (*currentDir_1);
        param_215 = _e590;
        let _e591 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_214), (&param_215));
        let _e592 = newType;
        param_216 = _e592;
        param_217 = _e591;
        param_218 = 0u;
        let _e593 = count_2;
        param_219 = _e593;
        let _e594 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_216), (&param_217), (&param_218), (&param_219));
        let _e595 = (*currentIndex_4);
        param_220 = _e595;
        let _e596 = (*rawValue_3);
        param_221 = _e596;
        let _e597 = belowIndex_1;
        param_222 = _e597;
        param_223 = _e594;
        let _e598 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_220), (&param_221), (&param_222), (&param_223));
        if _e598 {
            return;
        }
    }
    let _e599 = (*currentDir_1);
    param_224 = _e599;
    let _e600 = locustHeading_u0028_u1_u003b((&param_224));
    heading_1 = _e600;
    let _e601 = (*currentDir_1);
    param_225 = _e601;
    let _e602 = locustSteps_u0028_u1_u003b((&param_225));
    steps_1 = _e602;
    let _e603 = steps_1;
    if (_e603 == 0u) {
        let _e605 = (*randVal_4);
        start_7 = i32((fract((_e605 * 17f)) * 8f));
        i_8 = 0i;
        loop {
            let _e610 = i_8;
            if (_e610 < 8i) {
                let _e612 = start_7;
                let _e613 = i_8;
                let _e614 = (_e612 + _e613);
                d_4 = (_e614 - (i32(floor((f32(_e614) / f32(8i)))) * 8i));
                let _e622 = (*pos_7);
                let _e623 = d_4;
                param_226 = _e623;
                let _e624 = getHDir_u0028_i1_u003b((&param_226));
                c_5 = (_e622 + _e624);
                rise = 0i;
                loop {
                    let _e626 = rise;
                    if (_e626 < 3i) {
                        let _e628 = c_5;
                        let _e629 = rise;
                        if (_e629 == 1i) {
                            local_8 = 1i;
                        } else {
                            let _e631 = rise;
                            local_8 = select(0i, -1i, (_e631 == 2i));
                        }
                        let _e634 = local_8;
                        t_3 = (_e628 + vec3<i32>(0i, _e634, 0i));
                        let _e637 = t_3;
                        param_227 = _e637;
                        let _e638 = locustInBounds_u0028_vi3_u003b((&param_227));
                        if !(_e638) {
                            continue;
                        }
                        let _e640 = t_3;
                        param_228 = _e640;
                        let _e641 = getIndex_u0028_vi3_u003b((&param_228));
                        param_229 = _e641;
                        let _e642 = readCell_u0028_u1_u003b((&param_229));
                        if (_e642 != 0u) {
                            continue;
                        }
                        let _e644 = t_3;
                        param_230 = (_e644 + vec3<i32>(0i, -1i, 0i));
                        let _e646 = locustFoodAt_u0028_vi3_u003b((&param_230));
                        if !(_e646) {
                            continue;
                        }
                        let _e648 = t_3;
                        param_231 = _e648;
                        let _e649 = getIndex_u0028_vi3_u003b((&param_231));
                        let _e650 = newType;
                        param_232 = _e650;
                        param_233 = 0u;
                        param_234 = 0u;
                        let _e651 = count_2;
                        param_235 = _e651;
                        let _e652 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_232), (&param_233), (&param_234), (&param_235));
                        let _e653 = (*currentIndex_4);
                        param_236 = _e653;
                        let _e654 = (*rawValue_3);
                        param_237 = _e654;
                        param_238 = _e649;
                        param_239 = _e652;
                        let _e655 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_236), (&param_237), (&param_238), (&param_239));
                        if _e655 {
                            return;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e656 = rise;
                        rise = (_e656 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e658 = i_8;
                i_8 = (_e658 + 1i);
            }
        }
        let _e660 = (*randVal_4);
        heading_1 = (u32((fract((_e660 * 23f)) * 8f)) & 7u);
        let _e666 = locustRunSteps_u0028_();
        steps_1 = _e666;
    }
    let _e667 = (*pos_7);
    let _e668 = heading_1;
    param_240 = bitcast<i32>(_e668);
    let _e670 = getHDir_u0028_i1_u003b((&param_240));
    target_1 = (_e667 + _e670);
    let _e672 = target_1;
    param_241 = _e672;
    let _e673 = locustInBounds_u0028_vi3_u003b((&param_241));
    let _e674 = !(_e673);
    phi_7560_ = _e674;
    if !(_e674) {
        let _e676 = target_1;
        param_242 = _e676;
        let _e677 = getIndex_u0028_vi3_u003b((&param_242));
        param_243 = _e677;
        let _e678 = readCell_u0028_u1_u003b((&param_243));
        phi_7560_ = (_e678 != 0u);
    }
    let _e681 = phi_7560_;
    blocked = _e681;
    let _e682 = blocked;
    if !(_e682) {
        let _e684 = target_1;
        footing = (_e684 + vec3<i32>(0i, -1i, 0i));
        let _e686 = footing;
        param_244 = _e686;
        let _e687 = locustInBounds_u0028_vi3_u003b((&param_244));
        phi_7579_ = _e687;
        if _e687 {
            let _e688 = footing;
            param_245 = _e688;
            let _e689 = getIndex_u0028_vi3_u003b((&param_245));
            param_246 = _e689;
            let _e690 = readCell_u0028_u1_u003b((&param_246));
            phi_7579_ = (_e690 == 0u);
        }
        let _e693 = phi_7579_;
        if _e693 {
            let _e694 = heading_1;
            param_247 = _e694;
            let _e695 = locustReverse_u0028_u1_u003b((&param_247));
            back = _e695;
            let _e696 = (*pos_7);
            let _e697 = back;
            param_248 = bitcast<i32>(_e697);
            let _e699 = getHDir_u0028_i1_u003b((&param_248));
            backPos = (_e696 + _e699);
            let _e701 = backPos;
            backFoot = (_e701 + vec3<i32>(0i, -1i, 0i));
            let _e703 = backPos;
            param_249 = _e703;
            let _e704 = locustInBounds_u0028_vi3_u003b((&param_249));
            phi_7608_ = _e704;
            if _e704 {
                let _e705 = backPos;
                param_250 = _e705;
                let _e706 = getIndex_u0028_vi3_u003b((&param_250));
                param_251 = _e706;
                let _e707 = readCell_u0028_u1_u003b((&param_251));
                phi_7608_ = (_e707 == 0u);
            }
            let _e710 = phi_7608_;
            phi_7624_ = _e710;
            if _e710 {
                let _e711 = backFoot;
                param_252 = _e711;
                let _e712 = locustInBounds_u0028_vi3_u003b((&param_252));
                phi_7622_ = _e712;
                if _e712 {
                    let _e713 = backFoot;
                    param_253 = _e713;
                    let _e714 = getIndex_u0028_vi3_u003b((&param_253));
                    param_254 = _e714;
                    let _e715 = readCell_u0028_u1_u003b((&param_254));
                    phi_7622_ = (_e715 == 0u);
                }
                let _e718 = phi_7622_;
                phi_7624_ = !(_e718);
            }
            let _e721 = phi_7624_;
            backOpen = _e721;
            let _e722 = backOpen;
            if _e722 {
                let _e723 = back;
                param_255 = _e723;
                let _e724 = steps_1;
                param_256 = _e724;
                let _e725 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_255), (&param_256));
                local_9 = _e725;
            } else {
                let _e726 = (*randVal_4);
                let _e732 = locustRunSteps_u0028_();
                param_257 = (u32((fract((_e726 * 71f)) * 8f)) & 7u);
                param_258 = _e732;
                let _e733 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_257), (&param_258));
                local_9 = _e733;
            }
            let _e734 = local_9;
            turnedNav = _e734;
            let _e735 = (*currentIndex_4);
            let _e738 = (*rawValue_3);
            let _e739 = newType;
            param_259 = _e739;
            let _e740 = turnedNav;
            param_260 = _e740;
            param_261 = 0u;
            let _e741 = count_2;
            param_262 = _e741;
            let _e742 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_259), (&param_260), (&param_261), (&param_262));
            let _e743 = atomicCompareExchangeWeak((&unnamed.grid[_e735]), _e738, _e742);
            return;
        }
        let _e745 = steps_1;
        let _e747 = heading_1;
        param_263 = _e747;
        param_264 = (_e745 - 1u);
        let _e748 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_263), (&param_264));
        nav_1 = _e748;
        let _e749 = target_1;
        param_265 = _e749;
        let _e750 = getIndex_u0028_vi3_u003b((&param_265));
        let _e751 = target_1;
        param_266 = _e751;
        let _e752 = nav_1;
        param_267 = _e752;
        let _e753 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_266), (&param_267));
        let _e754 = newType;
        param_268 = _e754;
        param_269 = _e753;
        param_270 = 0u;
        let _e755 = count_2;
        param_271 = _e755;
        let _e756 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_268), (&param_269), (&param_270), (&param_271));
        let _e757 = (*currentIndex_4);
        param_272 = _e757;
        let _e758 = (*rawValue_3);
        param_273 = _e758;
        param_274 = _e750;
        param_275 = _e756;
        let _e759 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_272), (&param_273), (&param_274), (&param_275));
        if _e759 {
            return;
        }
    } else {
        let _e760 = (*randVal_4);
        let _e764 = tuning.locustClimbChance;
        if (fract((_e760 * 41f)) < _e764) {
            let _e766 = target_1;
            overTop = (_e766 + vec3<i32>(0i, 1i, 0i));
            let _e768 = overTop;
            param_276 = _e768;
            let _e769 = locustInBounds_u0028_vi3_u003b((&param_276));
            phi_7716_ = _e769;
            if _e769 {
                let _e770 = overTop;
                param_277 = _e770;
                let _e771 = getIndex_u0028_vi3_u003b((&param_277));
                param_278 = _e771;
                let _e772 = readCell_u0028_u1_u003b((&param_278));
                phi_7716_ = (_e772 == 0u);
            }
            let _e775 = phi_7716_;
            if _e775 {
                let _e776 = steps_1;
                let _e778 = heading_1;
                param_279 = _e778;
                param_280 = (_e776 - 1u);
                let _e779 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_279), (&param_280));
                nav_2 = _e779;
                let _e780 = overTop;
                param_281 = _e780;
                let _e781 = getIndex_u0028_vi3_u003b((&param_281));
                let _e782 = overTop;
                param_282 = _e782;
                let _e783 = nav_2;
                param_283 = _e783;
                let _e784 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_282), (&param_283));
                let _e785 = newType;
                param_284 = _e785;
                param_285 = _e784;
                param_286 = 0u;
                let _e786 = count_2;
                param_287 = _e786;
                let _e787 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_284), (&param_285), (&param_286), (&param_287));
                let _e788 = (*currentIndex_4);
                param_288 = _e788;
                let _e789 = (*rawValue_3);
                param_289 = _e789;
                param_290 = _e781;
                param_291 = _e787;
                let _e790 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_288), (&param_289), (&param_290), (&param_291));
                if _e790 {
                    return;
                }
            }
            let _e791 = (*pos_7);
            up = (_e791 + vec3<i32>(0i, 1i, 0i));
            let _e793 = up;
            param_292 = _e793;
            let _e794 = locustInBounds_u0028_vi3_u003b((&param_292));
            phi_7765_ = _e794;
            if _e794 {
                let _e795 = up;
                param_293 = _e795;
                let _e796 = getIndex_u0028_vi3_u003b((&param_293));
                param_294 = _e796;
                let _e797 = readCell_u0028_u1_u003b((&param_294));
                phi_7765_ = (_e797 == 0u);
            }
            let _e800 = phi_7765_;
            if _e800 {
                let _e801 = heading_1;
                param_295 = _e801;
                let _e802 = steps_1;
                param_296 = _e802;
                let _e803 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_295), (&param_296));
                nav_3 = _e803;
                let _e804 = up;
                param_297 = _e804;
                let _e805 = getIndex_u0028_vi3_u003b((&param_297));
                let _e806 = up;
                param_298 = _e806;
                let _e807 = nav_3;
                param_299 = _e807;
                let _e808 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_298), (&param_299));
                let _e809 = newType;
                param_300 = _e809;
                param_301 = _e808;
                param_302 = 0u;
                let _e810 = count_2;
                param_303 = _e810;
                let _e811 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_300), (&param_301), (&param_302), (&param_303));
                let _e812 = (*currentIndex_4);
                param_304 = _e812;
                let _e813 = (*rawValue_3);
                param_305 = _e813;
                param_306 = _e805;
                param_307 = _e811;
                let _e814 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_304), (&param_305), (&param_306), (&param_307));
                if _e814 {
                    return;
                }
            }
        }
        let _e815 = (*randVal_4);
        heading_1 = (u32((fract((_e815 * 53f)) * 8f)) & 7u);
        let _e821 = locustRunSteps_u0028_();
        steps_1 = _e821;
    }
    let _e822 = (*currentIndex_4);
    let _e825 = (*rawValue_3);
    let _e826 = heading_1;
    param_308 = _e826;
    let _e827 = steps_1;
    param_309 = _e827;
    let _e828 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_308), (&param_309));
    let _e829 = newType;
    param_310 = _e829;
    param_311 = _e828;
    param_312 = 0u;
    let _e830 = count_2;
    param_313 = _e830;
    let _e831 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_310), (&param_311), (&param_312), (&param_313));
    let _e832 = atomicCompareExchangeWeak((&unnamed.grid[_e822]), _e825, _e831);
    return;
}

fn updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_8: ptr<function, vec3<i32>>, currentIndex_5: ptr<function, u32>, rawValue_4: ptr<function, u32>, currentAge_3: ptr<function, u32>, randVal_5: ptr<function, f32>) {
    var belowPos_3: vec3<i32>;
    var param_314: vec3<i32>;
    var param_315: u32;
    var param_316: u32;
    var param_317: vec3<i32>;
    var param_318: u32;
    var param_319: u32;
    var param_320: u32;
    var param_321: u32;
    var param_322: u32;
    var param_323: u32;
    var param_324: u32;
    var param_325: u32;
    var param_326: u32;
    var param_327: u32;
    var param_328: u32;
    var param_329: u32;
    var phi_6392_: bool;

    let _e238 = (*pos_8)[1u];
    if (_e238 > 1i) {
        let _e240 = (*pos_8);
        belowPos_3 = (_e240 + vec3<i32>(0i, -1i, 0i));
        let _e242 = belowPos_3;
        param_314 = _e242;
        let _e243 = getIndex_u0028_vi3_u003b((&param_314));
        param_315 = _e243;
        let _e244 = readCell_u0028_u1_u003b((&param_315));
        param_316 = _e244;
        let _e245 = getType_u0028_u1_u003b((&param_316));
        if (_e245 == 0u) {
            let _e247 = belowPos_3;
            param_317 = _e247;
            let _e248 = getIndex_u0028_vi3_u003b((&param_317));
            param_318 = 12u;
            param_319 = 0u;
            param_320 = 0u;
            let _e249 = (*currentAge_3);
            param_321 = _e249;
            let _e250 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_318), (&param_319), (&param_320), (&param_321));
            let _e251 = (*currentIndex_5);
            param_322 = _e251;
            let _e252 = (*rawValue_4);
            param_323 = _e252;
            param_324 = _e248;
            param_325 = _e250;
            let _e253 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_322), (&param_323), (&param_324), (&param_325));
            if _e253 {
                return;
            }
        }
    }
    let _e254 = (*currentAge_3);
    let _e255 = (_e254 > 0u);
    phi_6392_ = _e255;
    if _e255 {
        let _e256 = (*randVal_5);
        let _e260 = tuning.darkStoneDryChance;
        phi_6392_ = (fract((_e256 * 23f)) < _e260);
    }
    let _e263 = phi_6392_;
    if _e263 {
        let _e264 = (*currentIndex_5);
        let _e267 = (*rawValue_4);
        let _e268 = (*currentAge_3);
        param_326 = 12u;
        param_327 = 0u;
        param_328 = 0u;
        param_329 = (_e268 - 1u);
        let _e270 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_326), (&param_327), (&param_328), (&param_329));
        let _e271 = atomicCompareExchangeWeak((&unnamed.grid[_e264]), _e267, _e270);
    }
    return;
}

fn lavaTypeFor_u0028_u1_u003b(coolness: ptr<function, u32>) -> u32 {
    let _e216 = (*coolness);
    let _e218 = tuning.lavaStageSize;
    return (8u + min((_e216 / max(_e218, 1u)), 3u));
}

fn lavaSolidifyCoolness_u0028_() -> u32 {
    let _e216 = tuning.lavaStageSize;
    return min((max(_e216, 1u) * 4u), 255u);
}

fn decWater_u0028_() {
    let _e216 = atomicAdd((&unnamed_2.waterVoxelCount), 4294967295u);
    return;
}

fn getOrthoDir_u0028_i1_u003b(d_5: ptr<function, i32>) -> vec3<i32> {
    let _e216 = (*d_5);
    if (_e216 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e218 = (*d_5);
    if (_e218 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e220 = (*d_5);
    if (_e220 == 2i) {
        return vec3<i32>(0i, 1i, 0i);
    }
    let _e222 = (*d_5);
    if (_e222 == 3i) {
        return vec3<i32>(0i, -1i, 0i);
    }
    let _e224 = (*d_5);
    if (_e224 == 4i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    return vec3<i32>(0i, 0i, -1i);
}

fn lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b(pos_9: ptr<function, vec3<i32>>, coolness_1: ptr<function, u32>, randVal_6: ptr<function, f32>) {
    var startDir: i32;
    var i_9: i32;
    var d_6: i32;
    var nPos_1: vec3<i32>;
    var param_330: i32;
    var nIndex: u32;
    var param_331: vec3<i32>;
    var nVal: u32;
    var param_332: u32;
    var nType_1: u32;
    var param_333: u32;
    var param_334: u32;
    var param_335: u32;
    var param_336: u32;
    var param_337: u32;
    var param_338: u32;
    var param_339: u32;
    var param_340: u32;
    var param_341: u32;
    var param_342: u32;
    var param_343: u32;
    var param_344: u32;
    var param_345: u32;
    var moisture_1: u32;
    var param_346: u32;
    var flora_3: u32;
    var param_347: u32;
    var abovePos: vec3<i32>;
    var param_348: vec3<i32>;
    var param_349: u32;
    var param_350: u32;
    var param_351: vec3<i32>;
    var param_352: u32;
    var param_353: u32;
    var param_354: u32;
    var param_355: u32;
    var param_356: u32;
    var param_357: u32;
    var param_358: u32;
    var param_359: u32;
    var param_360: u32;
    var nCool: u32;
    var param_361: u32;
    var raised: u32;
    var raisedType: u32;
    var local_10: u32;
    var param_362: u32;
    var param_363: u32;
    var param_364: u32;
    var param_365: u32;
    var param_366: u32;
    var param_367: u32;
    var nCool_1: u32;
    var param_368: u32;
    var draws: bool;
    var lowered: u32;
    var local_11: u32;
    var melts: bool;
    var newType_1: u32;
    var local_12: u32;
    var param_369: u32;
    var param_370: u32;
    var param_371: u32;
    var param_372: u32;
    var param_373: u32;
    var phi_5446_: bool;
    var phi_5453_: bool;
    var phi_5464_: bool;
    var phi_5471_: bool;
    var phi_5482_: bool;
    var phi_5621_: bool;
    var phi_5632_: bool;

    let _e283 = (*randVal_6);
    startDir = i32((fract((_e283 * 17f)) * 6f));
    i_9 = 0i;
    loop {
        let _e288 = i_9;
        if (_e288 < 6i) {
            let _e290 = startDir;
            let _e291 = i_9;
            let _e292 = (_e290 + _e291);
            d_6 = (_e292 - (i32(floor((f32(_e292) / f32(6i)))) * 6i));
            let _e300 = (*pos_9);
            let _e301 = d_6;
            param_330 = _e301;
            let _e302 = getOrthoDir_u0028_i1_u003b((&param_330));
            nPos_1 = (_e300 + _e302);
            let _e305 = nPos_1[0u];
            let _e306 = (_e305 <= 0i);
            phi_5446_ = _e306;
            if !(_e306) {
                let _e309 = nPos_1[0u];
                let _e311 = tuning.gridWidth;
                phi_5446_ = (_e309 >= (bitcast<i32>(_e311) - 1i));
            }
            let _e316 = phi_5446_;
            phi_5453_ = _e316;
            if !(_e316) {
                let _e319 = nPos_1[1u];
                phi_5453_ = (_e319 <= 0i);
            }
            let _e322 = phi_5453_;
            phi_5464_ = _e322;
            if !(_e322) {
                let _e325 = nPos_1[1u];
                let _e327 = tuning.gridHeight;
                phi_5464_ = (_e325 >= (bitcast<i32>(_e327) - 1i));
            }
            let _e332 = phi_5464_;
            phi_5471_ = _e332;
            if !(_e332) {
                let _e335 = nPos_1[2u];
                phi_5471_ = (_e335 <= 0i);
            }
            let _e338 = phi_5471_;
            phi_5482_ = _e338;
            if !(_e338) {
                let _e341 = nPos_1[2u];
                let _e343 = tuning.gridDepth;
                phi_5482_ = (_e341 >= (bitcast<i32>(_e343) - 1i));
            }
            let _e348 = phi_5482_;
            if _e348 {
                continue;
            }
            let _e349 = nPos_1;
            param_331 = _e349;
            let _e350 = getIndex_u0028_vi3_u003b((&param_331));
            nIndex = _e350;
            let _e351 = nIndex;
            param_332 = _e351;
            let _e352 = readCell_u0028_u1_u003b((&param_332));
            nVal = _e352;
            let _e353 = nVal;
            param_333 = _e353;
            let _e354 = getType_u0028_u1_u003b((&param_333));
            nType_1 = _e354;
            let _e355 = nType_1;
            if (_e355 == 2u) {
                let _e357 = nIndex;
                let _e360 = nVal;
                param_334 = 6u;
                param_335 = 0u;
                param_336 = 0u;
                param_337 = 0u;
                let _e361 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_334), (&param_335), (&param_336), (&param_337));
                let _e362 = atomicCompareExchangeWeak((&unnamed.grid[_e357]), _e360, _e361);
                let _e364 = nVal;
                if (_e362.old_value == _e364) {
                    decWater_u0028_();
                    let _e366 = (*coolness_1);
                    let _e368 = tuning.lavaWaterCool;
                    (*coolness_1) = min((_e366 + _e368), 255u);
                    return;
                }
            } else {
                let _e371 = nType_1;
                if (_e371 == 19u) {
                    let _e373 = nIndex;
                    let _e376 = nVal;
                    let _e377 = atomicCompareExchangeWeak((&unnamed.grid[_e373]), _e376, 0u);
                    let _e379 = nVal;
                    if (_e377.old_value == _e379) {
                        return;
                    }
                } else {
                    let _e381 = nType_1;
                    if (_e381 == 18u) {
                        let _e383 = nIndex;
                        let _e386 = nVal;
                        param_338 = 5u;
                        param_339 = 0u;
                        param_340 = 0u;
                        param_341 = 0u;
                        let _e387 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_338), (&param_339), (&param_340), (&param_341));
                        let _e388 = atomicCompareExchangeWeak((&unnamed.grid[_e383]), _e386, _e387);
                        let _e390 = nVal;
                        if (_e388.old_value == _e390) {
                            return;
                        }
                    } else {
                        let _e392 = nType_1;
                        if (_e392 == 3u) {
                            let _e394 = nIndex;
                            let _e397 = nVal;
                            param_342 = 12u;
                            param_343 = 0u;
                            param_344 = 0u;
                            param_345 = 255u;
                            let _e398 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_342), (&param_343), (&param_344), (&param_345));
                            let _e399 = atomicCompareExchangeWeak((&unnamed.grid[_e394]), _e397, _e398);
                            let _e401 = nVal;
                            if (_e399.old_value == _e401) {
                                return;
                            }
                        } else {
                            let _e403 = nType_1;
                            let _e405 = nType_1;
                            if ((_e403 == 1u) || (_e405 == 4u)) {
                                let _e408 = nVal;
                                param_346 = _e408;
                                let _e409 = getAge_u0028_u1_u003b((&param_346));
                                moisture_1 = _e409;
                                let _e410 = nVal;
                                param_347 = _e410;
                                let _e411 = getDir_u0028_u1_u003b((&param_347));
                                flora_3 = _e411;
                                let _e412 = nType_1;
                                let _e414 = flora_3;
                                let _e417 = flora_3;
                                if (((_e412 == 4u) && (_e414 > 10u)) && (_e417 <= 100u)) {
                                    let _e420 = nPos_1;
                                    abovePos = (_e420 + vec3<i32>(0i, 1i, 0i));
                                    let _e423 = abovePos[1u];
                                    let _e425 = tuning.gridHeight;
                                    let _e428 = (_e423 < (bitcast<i32>(_e425) - 1i));
                                    phi_5621_ = _e428;
                                    if _e428 {
                                        let _e429 = abovePos;
                                        param_348 = _e429;
                                        let _e430 = getIndex_u0028_vi3_u003b((&param_348));
                                        param_349 = _e430;
                                        let _e431 = readCell_u0028_u1_u003b((&param_349));
                                        param_350 = _e431;
                                        let _e432 = getType_u0028_u1_u003b((&param_350));
                                        phi_5621_ = (_e432 == 0u);
                                    }
                                    let _e435 = phi_5621_;
                                    phi_5632_ = _e435;
                                    if _e435 {
                                        let _e436 = (*randVal_6);
                                        let _e440 = tuning.lavaIgniteChance;
                                        phi_5632_ = (fract((_e436 * 41f)) < _e440);
                                    }
                                    let _e443 = phi_5632_;
                                    if _e443 {
                                        let _e444 = abovePos;
                                        param_351 = _e444;
                                        let _e445 = getIndex_u0028_vi3_u003b((&param_351));
                                        param_352 = 5u;
                                        param_353 = 0u;
                                        param_354 = 0u;
                                        param_355 = 0u;
                                        let _e448 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_352), (&param_353), (&param_354), (&param_355));
                                        let _e449 = atomicCompareExchangeWeak((&unnamed.grid[_e445]), 0u, _e448);
                                        if (_e449.old_value == 0u) {
                                            return;
                                        }
                                    }
                                } else {
                                    let _e452 = moisture_1;
                                    if (_e452 > 0u) {
                                        let _e454 = nIndex;
                                        let _e457 = nVal;
                                        let _e458 = moisture_1;
                                        let _e460 = nType_1;
                                        param_356 = _e460;
                                        let _e461 = flora_3;
                                        param_357 = _e461;
                                        param_358 = 0u;
                                        param_359 = (_e458 - 1u);
                                        let _e462 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_356), (&param_357), (&param_358), (&param_359));
                                        let _e463 = atomicCompareExchangeWeak((&unnamed.grid[_e454]), _e457, _e462);
                                        let _e465 = nVal;
                                        if (_e463.old_value == _e465) {
                                            let _e467 = (*coolness_1);
                                            let _e469 = tuning.lavaMoistureCool;
                                            (*coolness_1) = min((_e467 + _e469), 255u);
                                            return;
                                        }
                                    } else {
                                        let _e472 = (*randVal_6);
                                        let _e476 = tuning.lavaConsumeChance;
                                        if (fract((_e472 * 53f)) < _e476) {
                                            let _e478 = nIndex;
                                            let _e481 = nVal;
                                            let _e482 = atomicCompareExchangeWeak((&unnamed.grid[_e478]), _e481, 0u);
                                            let _e484 = nVal;
                                            if (_e482.old_value == _e484) {
                                                return;
                                            }
                                        }
                                    }
                                }
                            } else {
                                let _e486 = nType_1;
                                param_360 = _e486;
                                let _e487 = isLava_u0028_u1_u003b((&param_360));
                                if _e487 {
                                    let _e488 = nVal;
                                    param_361 = _e488;
                                    let _e489 = getAge_u0028_u1_u003b((&param_361));
                                    nCool = _e489;
                                    let _e490 = (*coolness_1);
                                    let _e491 = nCool;
                                    if (_e490 > (_e491 + 1u)) {
                                        let _e494 = nCool;
                                        raised = (_e494 + 1u);
                                        let _e496 = raised;
                                        let _e497 = lavaSolidifyCoolness_u0028_();
                                        if (_e496 >= _e497) {
                                            local_10 = 12u;
                                        } else {
                                            let _e499 = raised;
                                            param_362 = _e499;
                                            let _e500 = lavaTypeFor_u0028_u1_u003b((&param_362));
                                            local_10 = _e500;
                                        }
                                        let _e501 = local_10;
                                        raisedType = _e501;
                                        let _e502 = nIndex;
                                        let _e505 = nVal;
                                        let _e506 = nVal;
                                        param_363 = _e506;
                                        let _e507 = getDir_u0028_u1_u003b((&param_363));
                                        let _e508 = raisedType;
                                        param_364 = _e508;
                                        param_365 = _e507;
                                        param_366 = 0u;
                                        let _e509 = raised;
                                        param_367 = _e509;
                                        let _e510 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_364), (&param_365), (&param_366), (&param_367));
                                        let _e511 = atomicCompareExchangeWeak((&unnamed.grid[_e502]), _e505, _e510);
                                        let _e513 = nVal;
                                        if (_e511.old_value == _e513) {
                                            let _e515 = (*coolness_1);
                                            (*coolness_1) = (_e515 - 1u);
                                            return;
                                        }
                                    }
                                } else {
                                    let _e517 = nType_1;
                                    if (_e517 == 12u) {
                                        let _e519 = nVal;
                                        param_368 = _e519;
                                        let _e520 = getAge_u0028_u1_u003b((&param_368));
                                        nCool_1 = _e520;
                                        let _e521 = nCool_1;
                                        let _e522 = (*coolness_1);
                                        draws = (_e521 > (_e522 + 1u));
                                        let _e525 = draws;
                                        if _e525 {
                                            let _e526 = nCool_1;
                                            local_11 = (_e526 - 1u);
                                        } else {
                                            let _e528 = nCool_1;
                                            local_11 = _e528;
                                        }
                                        let _e529 = local_11;
                                        lowered = _e529;
                                        let _e530 = lowered;
                                        let _e531 = lavaSolidifyCoolness_u0028_();
                                        melts = (_e530 < _e531);
                                        let _e533 = draws;
                                        let _e534 = melts;
                                        if (_e533 || _e534) {
                                            let _e536 = melts;
                                            if _e536 {
                                                let _e537 = lowered;
                                                param_369 = _e537;
                                                let _e538 = lavaTypeFor_u0028_u1_u003b((&param_369));
                                                local_12 = _e538;
                                            } else {
                                                local_12 = 12u;
                                            }
                                            let _e539 = local_12;
                                            newType_1 = _e539;
                                            let _e540 = nIndex;
                                            let _e543 = nVal;
                                            let _e544 = newType_1;
                                            param_370 = _e544;
                                            param_371 = 0u;
                                            param_372 = 0u;
                                            let _e545 = lowered;
                                            param_373 = _e545;
                                            let _e546 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_370), (&param_371), (&param_372), (&param_373));
                                            let _e547 = atomicCompareExchangeWeak((&unnamed.grid[_e540]), _e543, _e546);
                                            let _e549 = nVal;
                                            if (_e547.old_value == _e549) {
                                                let _e551 = draws;
                                                if _e551 {
                                                    let _e552 = (*coolness_1);
                                                    (*coolness_1) = min((_e552 + 1u), 255u);
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
            let _e555 = i_9;
            i_9 = (_e555 + 1i);
        }
    }
    return;
}

fn updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_10: ptr<function, vec3<i32>>, currentIndex_6: ptr<function, u32>, rawValue_5: ptr<function, u32>, currentDir_2: ptr<function, u32>, currentSleep_2: ptr<function, u32>, currentAge_4: ptr<function, u32>, randVal_7: ptr<function, f32>) {
    var coolness_2: u32;
    var param_374: vec3<i32>;
    var param_375: u32;
    var param_376: f32;
    var param_377: u32;
    var param_378: u32;
    var param_379: u32;
    var param_380: u32;
    var newType_2: u32;
    var param_381: u32;
    var belowPos_4: vec3<i32>;
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
    var slideDir: i32;
    var slide_1: array<vec3<i32>, 2>;
    var s_1: i32;
    var sPos: vec3<i32>;
    var param_394: vec3<i32>;
    var param_395: u32;
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
    var blockedMask: u32;
    var searchStart: i32;
    var reach: i32;
    var r: i32;
    var i_10: i32;
    var d_7: i32;
    var c_6: vec3<i32>;
    var param_406: i32;
    var param_407: vec3<i32>;
    var param_408: u32;
    var param_409: u32;
    var param_410: vec3<i32>;
    var param_411: u32;
    var param_412: u32;
    var param_413: vec3<i32>;
    var param_414: u32;
    var param_415: u32;
    var param_416: u32;
    var param_417: u32;
    var param_418: u32;
    var param_419: u32;
    var param_420: u32;
    var param_421: u32;
    var hasPressure: bool;
    var local_13: bool;
    var param_422: vec3<i32>;
    var param_423: u32;
    var param_424: u32;
    var stackedOnLava: bool;
    var local_14: bool;
    var param_425: vec3<i32>;
    var param_426: u32;
    var param_427: u32;
    var param_428: u32;
    var spreadStart: i32;
    var i_11: i32;
    var d_8: i32;
    var targetPos: vec3<i32>;
    var param_429: i32;
    var param_430: vec3<i32>;
    var param_431: u32;
    var param_432: u32;
    var param_433: vec3<i32>;
    var param_434: u32;
    var param_435: u32;
    var param_436: u32;
    var param_437: u32;
    var param_438: u32;
    var param_439: u32;
    var param_440: u32;
    var param_441: u32;
    var newSleep: u32;
    var param_442: u32;
    var param_443: u32;
    var param_444: u32;
    var param_445: u32;
    var phi_5840_: bool;
    var phi_5978_: bool;
    var phi_5984_: bool;
    var phi_5994_: bool;
    var phi_6106_: bool;
    var phi_6113_: bool;
    var phi_6124_: bool;
    var phi_6136_: bool;
    var phi_6158_: bool;
    var phi_6272_: bool;
    var phi_6278_: bool;
    var phi_6288_: bool;

    let _e317 = (*currentAge_4);
    coolness_2 = _e317;
    let _e318 = (*pos_10);
    param_374 = _e318;
    let _e319 = coolness_2;
    param_375 = _e319;
    let _e320 = (*randVal_7);
    param_376 = _e320;
    lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b((&param_374), (&param_375), (&param_376));
    let _e321 = param_375;
    coolness_2 = _e321;
    let _e322 = (*currentSleep_2);
    let _e324 = tuning.wakeSleepThreshold;
    let _e325 = (_e322 > _e324);
    phi_5840_ = _e325;
    if _e325 {
        let _e326 = (*randVal_7);
        let _e330 = tuning.lavaRestCoolChance;
        phi_5840_ = (fract((_e326 * 71f)) < _e330);
    }
    let _e333 = phi_5840_;
    if _e333 {
        let _e334 = coolness_2;
        coolness_2 = min((_e334 + 1u), 255u);
    }
    let _e337 = coolness_2;
    let _e338 = lavaSolidifyCoolness_u0028_();
    if (_e337 >= _e338) {
        let _e340 = (*currentIndex_6);
        let _e343 = (*rawValue_5);
        param_377 = 12u;
        param_378 = 0u;
        param_379 = 0u;
        let _e344 = coolness_2;
        param_380 = _e344;
        let _e345 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_377), (&param_378), (&param_379), (&param_380));
        let _e346 = atomicCompareExchangeWeak((&unnamed.grid[_e340]), _e343, _e345);
        return;
    }
    let _e348 = coolness_2;
    param_381 = _e348;
    let _e349 = lavaTypeFor_u0028_u1_u003b((&param_381));
    newType_2 = _e349;
    let _e350 = (*randVal_7);
    let _e354 = tuning.lavaViscosity;
    if (fract((_e350 * 89f)) < _e354) {
        let _e357 = (*pos_10)[1u];
        if (_e357 > 1i) {
            let _e359 = (*pos_10);
            belowPos_4 = (_e359 + vec3<i32>(0i, -1i, 0i));
            let _e361 = belowPos_4;
            param_382 = _e361;
            let _e362 = getIndex_u0028_vi3_u003b((&param_382));
            param_383 = _e362;
            let _e363 = readCell_u0028_u1_u003b((&param_383));
            param_384 = _e363;
            let _e364 = getType_u0028_u1_u003b((&param_384));
            if (_e364 == 0u) {
                let _e366 = belowPos_4;
                param_385 = _e366;
                let _e367 = getIndex_u0028_vi3_u003b((&param_385));
                let _e368 = newType_2;
                param_386 = _e368;
                let _e369 = (*currentDir_2);
                param_387 = _e369;
                param_388 = 0u;
                let _e370 = coolness_2;
                param_389 = _e370;
                let _e371 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_386), (&param_387), (&param_388), (&param_389));
                let _e372 = (*currentIndex_6);
                param_390 = _e372;
                let _e373 = (*rawValue_5);
                param_391 = _e373;
                param_392 = _e367;
                param_393 = _e371;
                let _e374 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_390), (&param_391), (&param_392), (&param_393));
                if _e374 {
                    return;
                }
            }
        }
        let _e376 = (*pos_10)[1u];
        if (_e376 > 1i) {
            let _e378 = (*randVal_7);
            slideDir = select(-1i, 1i, (fract((_e378 * 10f)) > 0.5f));
            let _e383 = (*randVal_7);
            if (fract((_e383 * 100f)) > 0.5f) {
                let _e387 = (*pos_10);
                let _e388 = slideDir;
                slide_1[0i] = (_e387 + vec3<i32>(_e388, -1i, 0i));
                let _e392 = (*pos_10);
                let _e393 = slideDir;
                slide_1[1i] = (_e392 + vec3<i32>(0i, -1i, _e393));
            } else {
                let _e397 = (*pos_10);
                let _e398 = slideDir;
                slide_1[0i] = (_e397 + vec3<i32>(0i, -1i, _e398));
                let _e402 = (*pos_10);
                let _e403 = slideDir;
                slide_1[1i] = (_e402 + vec3<i32>(_e403, -1i, 0i));
            }
            s_1 = 0i;
            loop {
                let _e407 = s_1;
                if (_e407 < 2i) {
                    let _e409 = s_1;
                    let _e411 = slide_1[_e409];
                    sPos = _e411;
                    let _e413 = sPos[0u];
                    let _e414 = (_e413 > 0i);
                    phi_5978_ = _e414;
                    if _e414 {
                        let _e416 = sPos[0u];
                        let _e418 = tuning.gridWidth;
                        phi_5978_ = (_e416 < (bitcast<i32>(_e418) - 1i));
                    }
                    let _e423 = phi_5978_;
                    phi_5984_ = _e423;
                    if _e423 {
                        let _e425 = sPos[2u];
                        phi_5984_ = (_e425 > 0i);
                    }
                    let _e428 = phi_5984_;
                    phi_5994_ = _e428;
                    if _e428 {
                        let _e430 = sPos[2u];
                        let _e432 = tuning.gridDepth;
                        phi_5994_ = (_e430 < (bitcast<i32>(_e432) - 1i));
                    }
                    let _e437 = phi_5994_;
                    if _e437 {
                        let _e438 = sPos;
                        param_394 = _e438;
                        let _e439 = getIndex_u0028_vi3_u003b((&param_394));
                        param_395 = _e439;
                        let _e440 = readCell_u0028_u1_u003b((&param_395));
                        param_396 = _e440;
                        let _e441 = getType_u0028_u1_u003b((&param_396));
                        if (_e441 == 0u) {
                            let _e443 = sPos;
                            param_397 = _e443;
                            let _e444 = getIndex_u0028_vi3_u003b((&param_397));
                            let _e445 = newType_2;
                            param_398 = _e445;
                            let _e446 = (*currentDir_2);
                            param_399 = _e446;
                            param_400 = 0u;
                            let _e447 = coolness_2;
                            param_401 = _e447;
                            let _e448 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_398), (&param_399), (&param_400), (&param_401));
                            let _e449 = (*currentIndex_6);
                            param_402 = _e449;
                            let _e450 = (*rawValue_5);
                            param_403 = _e450;
                            param_404 = _e444;
                            param_405 = _e448;
                            let _e451 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_402), (&param_403), (&param_404), (&param_405));
                            if _e451 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e452 = s_1;
                    s_1 = (_e452 + 1i);
                }
            }
        }
        let _e454 = (*currentSleep_2);
        let _e456 = tuning.wakeSleepThreshold;
        if (_e454 <= _e456) {
            blockedMask = 0u;
            let _e458 = (*randVal_7);
            searchStart = i32((fract((_e458 * 8f)) * 8f));
            let _e464 = tuning.lavaSpreadRadius;
            reach = bitcast<i32>(max(_e464, 1u));
            r = 1i;
            loop {
                let _e467 = r;
                let _e468 = reach;
                if (_e467 <= _e468) {
                    let _e470 = blockedMask;
                    if (_e470 == 255u) {
                        break;
                    }
                    i_10 = 0i;
                    loop {
                        let _e472 = i_10;
                        if (_e472 < 8i) {
                            let _e474 = searchStart;
                            let _e475 = i_10;
                            let _e476 = (_e474 + _e475);
                            d_7 = (_e476 - (i32(floor((f32(_e476) / f32(8i)))) * 8i));
                            let _e484 = blockedMask;
                            let _e485 = d_7;
                            if ((_e484 & (1u << bitcast<u32>(_e485))) != 0u) {
                                continue;
                            }
                            let _e490 = (*pos_10);
                            let _e491 = d_7;
                            param_406 = _e491;
                            let _e492 = getHDir_u0028_i1_u003b((&param_406));
                            let _e493 = r;
                            c_6 = (_e490 + (_e492 * vec3(_e493)));
                            let _e498 = c_6[0u];
                            let _e499 = (_e498 <= 0i);
                            phi_6106_ = _e499;
                            if !(_e499) {
                                let _e502 = c_6[0u];
                                let _e504 = tuning.gridWidth;
                                phi_6106_ = (_e502 >= (bitcast<i32>(_e504) - 1i));
                            }
                            let _e509 = phi_6106_;
                            phi_6113_ = _e509;
                            if !(_e509) {
                                let _e512 = c_6[2u];
                                phi_6113_ = (_e512 <= 0i);
                            }
                            let _e515 = phi_6113_;
                            phi_6124_ = _e515;
                            if !(_e515) {
                                let _e518 = c_6[2u];
                                let _e520 = tuning.gridDepth;
                                phi_6124_ = (_e518 >= (bitcast<i32>(_e520) - 1i));
                            }
                            let _e525 = phi_6124_;
                            phi_6136_ = _e525;
                            if !(_e525) {
                                let _e527 = c_6;
                                param_407 = _e527;
                                let _e528 = getIndex_u0028_vi3_u003b((&param_407));
                                param_408 = _e528;
                                let _e529 = readCell_u0028_u1_u003b((&param_408));
                                param_409 = _e529;
                                let _e530 = getType_u0028_u1_u003b((&param_409));
                                phi_6136_ = (_e530 != 0u);
                            }
                            let _e533 = phi_6136_;
                            if _e533 {
                                let _e534 = d_7;
                                let _e537 = blockedMask;
                                blockedMask = (_e537 | (1u << bitcast<u32>(_e534)));
                            } else {
                                let _e540 = c_6[1u];
                                let _e541 = (_e540 > 1i);
                                phi_6158_ = _e541;
                                if _e541 {
                                    let _e542 = c_6;
                                    param_410 = (_e542 + vec3<i32>(0i, -1i, 0i));
                                    let _e544 = getIndex_u0028_vi3_u003b((&param_410));
                                    param_411 = _e544;
                                    let _e545 = readCell_u0028_u1_u003b((&param_411));
                                    param_412 = _e545;
                                    let _e546 = getType_u0028_u1_u003b((&param_412));
                                    phi_6158_ = (_e546 == 0u);
                                }
                                let _e549 = phi_6158_;
                                if _e549 {
                                    let _e550 = c_6;
                                    param_413 = _e550;
                                    let _e551 = getIndex_u0028_vi3_u003b((&param_413));
                                    let _e552 = newType_2;
                                    param_414 = _e552;
                                    param_415 = 0u;
                                    param_416 = 0u;
                                    let _e553 = coolness_2;
                                    param_417 = _e553;
                                    let _e554 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_414), (&param_415), (&param_416), (&param_417));
                                    let _e555 = (*currentIndex_6);
                                    param_418 = _e555;
                                    let _e556 = (*rawValue_5);
                                    param_419 = _e556;
                                    param_420 = _e551;
                                    param_421 = _e554;
                                    let _e557 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_418), (&param_419), (&param_420), (&param_421));
                                    if _e557 {
                                        return;
                                    }
                                    let _e558 = d_7;
                                    let _e561 = blockedMask;
                                    blockedMask = (_e561 | (1u << bitcast<u32>(_e558)));
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e563 = i_10;
                            i_10 = (_e563 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e565 = r;
                    r = (_e565 + 1i);
                }
            }
            let _e568 = (*pos_10)[1u];
            let _e570 = tuning.gridHeight;
            if (_e568 < (bitcast<i32>(_e570) - 2i)) {
                let _e574 = (*pos_10);
                param_422 = (_e574 + vec3<i32>(0i, 1i, 0i));
                let _e576 = getIndex_u0028_vi3_u003b((&param_422));
                param_423 = _e576;
                let _e577 = readCell_u0028_u1_u003b((&param_423));
                param_424 = _e577;
                let _e578 = getType_u0028_u1_u003b((&param_424));
                local_13 = (_e578 != 0u);
            } else {
                local_13 = false;
            }
            let _e580 = local_13;
            hasPressure = _e580;
            let _e582 = (*pos_10)[1u];
            if (_e582 > 1i) {
                let _e584 = (*pos_10);
                param_425 = (_e584 + vec3<i32>(0i, -1i, 0i));
                let _e586 = getIndex_u0028_vi3_u003b((&param_425));
                param_426 = _e586;
                let _e587 = readCell_u0028_u1_u003b((&param_426));
                param_427 = _e587;
                let _e588 = getType_u0028_u1_u003b((&param_427));
                param_428 = _e588;
                let _e589 = isLava_u0028_u1_u003b((&param_428));
                local_14 = _e589;
            } else {
                local_14 = false;
            }
            let _e590 = local_14;
            stackedOnLava = _e590;
            let _e591 = hasPressure;
            let _e592 = stackedOnLava;
            if (_e591 || _e592) {
                let _e594 = (*randVal_7);
                spreadStart = i32((fract((_e594 * 8f)) * 8f));
                i_11 = 0i;
                loop {
                    let _e599 = i_11;
                    if (_e599 < 8i) {
                        let _e601 = spreadStart;
                        let _e602 = i_11;
                        let _e603 = (_e601 + _e602);
                        d_8 = (_e603 - (i32(floor((f32(_e603) / f32(8i)))) * 8i));
                        let _e611 = (*pos_10);
                        let _e612 = d_8;
                        param_429 = _e612;
                        let _e613 = getHDir_u0028_i1_u003b((&param_429));
                        targetPos = (_e611 + _e613);
                        let _e616 = targetPos[0u];
                        let _e617 = (_e616 > 0i);
                        phi_6272_ = _e617;
                        if _e617 {
                            let _e619 = targetPos[0u];
                            let _e621 = tuning.gridWidth;
                            phi_6272_ = (_e619 < (bitcast<i32>(_e621) - 1i));
                        }
                        let _e626 = phi_6272_;
                        phi_6278_ = _e626;
                        if _e626 {
                            let _e628 = targetPos[2u];
                            phi_6278_ = (_e628 > 0i);
                        }
                        let _e631 = phi_6278_;
                        phi_6288_ = _e631;
                        if _e631 {
                            let _e633 = targetPos[2u];
                            let _e635 = tuning.gridDepth;
                            phi_6288_ = (_e633 < (bitcast<i32>(_e635) - 1i));
                        }
                        let _e640 = phi_6288_;
                        if _e640 {
                            let _e641 = targetPos;
                            param_430 = _e641;
                            let _e642 = getIndex_u0028_vi3_u003b((&param_430));
                            param_431 = _e642;
                            let _e643 = readCell_u0028_u1_u003b((&param_431));
                            param_432 = _e643;
                            let _e644 = getType_u0028_u1_u003b((&param_432));
                            if (_e644 == 0u) {
                                let _e646 = targetPos;
                                param_433 = _e646;
                                let _e647 = getIndex_u0028_vi3_u003b((&param_433));
                                let _e648 = d_8;
                                let _e651 = newType_2;
                                param_434 = _e651;
                                param_435 = bitcast<u32>((_e648 + 1i));
                                param_436 = 0u;
                                let _e652 = coolness_2;
                                param_437 = _e652;
                                let _e653 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_434), (&param_435), (&param_436), (&param_437));
                                let _e654 = (*currentIndex_6);
                                param_438 = _e654;
                                let _e655 = (*rawValue_5);
                                param_439 = _e655;
                                param_440 = _e647;
                                param_441 = _e653;
                                let _e656 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_438), (&param_439), (&param_440), (&param_441));
                                if _e656 {
                                    return;
                                }
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e657 = i_11;
                        i_11 = (_e657 + 1i);
                    }
                }
            }
        }
    }
    let _e659 = (*currentSleep_2);
    newSleep = min((_e659 + 1u), 255u);
    let _e662 = (*currentIndex_6);
    let _e665 = (*rawValue_5);
    let _e666 = newType_2;
    param_442 = _e666;
    let _e667 = (*currentDir_2);
    param_443 = _e667;
    let _e668 = newSleep;
    param_444 = _e668;
    let _e669 = coolness_2;
    param_445 = _e669;
    let _e670 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_442), (&param_443), (&param_444), (&param_445));
    let _e671 = atomicCompareExchangeWeak((&unnamed.grid[_e662]), _e665, _e670);
    return;
}

fn getCloudMoved_u0028_u1_u003b(v_2: ptr<function, u32>) -> bool {
    let _e216 = (*v_2);
    return ((_e216 & 4u) != 0u);
}

fn getCloudKind_u0028_u1_u003b(v_3: ptr<function, u32>) -> u32 {
    let _e216 = (*v_3);
    return (_e216 & 3u);
}

fn cloudIsAtRest_u0028_u1_u003b(v_4: ptr<function, u32>) -> bool {
    var param_446: u32;
    var param_447: u32;
    var phi_736_: bool;

    let _e218 = (*v_4);
    param_446 = _e218;
    let _e219 = getCloudKind_u0028_u1_u003b((&param_446));
    let _e220 = (_e219 != 0u);
    phi_736_ = _e220;
    if _e220 {
        let _e221 = (*v_4);
        param_447 = _e221;
        let _e222 = getCloudMoved_u0028_u1_u003b((&param_447));
        phi_736_ = !(_e222);
    }
    let _e225 = phi_736_;
    return _e225;
}

fn cloudCellInBounds_u0028_vi3_u003b(p_4: ptr<function, vec3<i32>>) -> bool {
    var phi_595_: bool;
    var phi_601_: bool;
    var phi_611_: bool;
    var phi_617_: bool;
    var phi_627_: bool;

    let _e217 = (*p_4)[0u];
    let _e218 = (_e217 >= 1i);
    phi_595_ = _e218;
    if _e218 {
        let _e220 = (*p_4)[0u];
        let _e222 = tuning.gridWidth;
        phi_595_ = (_e220 < (bitcast<i32>(_e222) - 1i));
    }
    let _e227 = phi_595_;
    phi_601_ = _e227;
    if _e227 {
        let _e229 = (*p_4)[1u];
        phi_601_ = (_e229 >= 1i);
    }
    let _e232 = phi_601_;
    phi_611_ = _e232;
    if _e232 {
        let _e234 = (*p_4)[1u];
        let _e236 = tuning.gridHeight;
        phi_611_ = (_e234 < (bitcast<i32>(_e236) - 1i));
    }
    let _e241 = phi_611_;
    phi_617_ = _e241;
    if _e241 {
        let _e243 = (*p_4)[2u];
        phi_617_ = (_e243 >= 1i);
    }
    let _e246 = phi_617_;
    phi_627_ = _e246;
    if _e246 {
        let _e248 = (*p_4)[2u];
        let _e250 = tuning.gridDepth;
        phi_627_ = (_e248 < (bitcast<i32>(_e250) - 1i));
    }
    let _e255 = phi_627_;
    return _e255;
}

fn cloudTouchesRain_u0028_vi3_u003b(pos_11: ptr<function, vec3<i32>>) -> bool {
    var i_12: i32;
    var n_1: vec3<i32>;
    var param_448: i32;
    var param_449: vec3<i32>;
    var param_450: vec3<i32>;
    var param_451: u32;

    i_12 = 0i;
    loop {
        let _e222 = i_12;
        if (_e222 < 6i) {
            let _e224 = (*pos_11);
            let _e225 = i_12;
            param_448 = _e225;
            let _e226 = getOrthoDir_u0028_i1_u003b((&param_448));
            n_1 = (_e224 + _e226);
            let _e228 = n_1;
            param_449 = _e228;
            let _e229 = cloudCellInBounds_u0028_vi3_u003b((&param_449));
            if !(_e229) {
                continue;
            }
            let _e231 = n_1;
            param_450 = _e231;
            let _e232 = getIndex_u0028_vi3_u003b((&param_450));
            let _e235 = atomicLoad((&unnamed_1.cloudCells[_e232]));
            param_451 = _e235;
            let _e236 = getCloudKind_u0028_u1_u003b((&param_451));
            if (_e236 == 2u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e238 = i_12;
            i_12 = (_e238 + 1i);
        }
    }
    return false;
}

fn packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b(kind: ptr<function, u32>, moved: ptr<function, bool>, counter: ptr<function, u32>, target_2: ptr<function, u32>) -> u32 {
    let _e219 = (*kind);
    let _e221 = (*moved);
    let _e224 = (*counter);
    let _e229 = (*target_2);
    return ((((_e219 & 3u) | select(0u, 4u, _e221)) | (min(_e224, 2047u) << bitcast<u32>(3i))) | (min(_e229, 2047u) << bitcast<u32>(14i)));
}

fn updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_12: ptr<function, vec3<i32>>, currentIndex_7: ptr<function, u32>, rawValue_6: ptr<function, u32>, currentSleep_3: ptr<function, u32>, currentAge_5: ptr<function, u32>, randVal_8: ptr<function, f32>) {
    var newKind: u32;
    var param_452: u32;
    var param_453: bool;
    var param_454: u32;
    var param_455: u32;
    var newAge: u32;
    var newKind_1: u32;
    var param_456: vec3<i32>;
    var param_457: u32;
    var param_458: bool;
    var param_459: u32;
    var param_460: u32;
    var d_9: i32;
    var scatterPos: vec3<i32>;
    var param_461: i32;
    var sType: u32;
    var param_462: vec3<i32>;
    var param_463: u32;
    var param_464: u32;
    var param_465: vec3<i32>;
    var param_466: u32;
    var carried_1: u32;
    var param_467: vec3<i32>;
    var param_468: u32;
    var param_469: u32;
    var param_470: u32;
    var param_471: u32;
    var param_472: u32;
    var param_473: u32;
    var param_474: u32;
    var param_475: u32;
    var checkPos: array<vec3<i32>, 3>;
    var dir_2: i32;
    var upPos_1: vec3<i32>;
    var underSettled: bool;
    var param_476: vec3<i32>;
    var param_477: vec3<i32>;
    var param_478: u32;
    var touchingRain: bool;
    var param_479: vec3<i32>;
    var newKind_2: u32;
    var param_480: u32;
    var param_481: bool;
    var param_482: u32;
    var param_483: u32;
    var i_13: i32;
    var cPos: vec3<i32>;
    var cIndex: u32;
    var param_484: vec3<i32>;
    var cVal: u32;
    var param_485: u32;
    var cType: u32;
    var param_486: u32;
    var moisture_2: u32;
    var param_487: u32;
    var capacity: u32;
    var local_15: u32;
    var i_14: i32;
    var sPos_1: vec3<i32>;
    var sType_1: u32;
    var param_488: vec3<i32>;
    var param_489: u32;
    var param_490: u32;
    var param_491: vec3<i32>;
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
    var newSleep_1: u32;
    var param_502: u32;
    var param_503: u32;
    var param_504: u32;
    var param_505: u32;
    var phi_8986_: bool;
    var phi_9035_: bool;
    var phi_9041_: bool;
    var phi_9051_: bool;
    var phi_9057_: bool;
    var phi_9067_: bool;
    var phi_9093_: bool;
    var phi_9175_: bool;
    var phi_9193_: bool;
    var phi_9232_: bool;
    var phi_9238_: bool;
    var phi_9248_: bool;
    var phi_9329_: bool;
    var phi_9339_: bool;
    var phi_9345_: bool;
    var phi_9355_: bool;
    var phi_9381_: bool;

    let _e301 = (*pos_12)[1u];
    let _e303 = tuning.gridHeight;
    if (_e301 >= (bitcast<i32>(_e303) - 2i)) {
        let _e308 = unnamed_2.rainPhase;
        newKind = select(1u, 2u, (_e308 == 2u));
        let _e311 = (*currentIndex_7);
        let _e314 = newKind;
        param_452 = _e314;
        param_453 = false;
        param_454 = 0u;
        param_455 = 0u;
        let _e315 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_452), (&param_453), (&param_454), (&param_455));
        let _e316 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e311]), 0u, _e315);
        if (_e316.old_value == 0u) {
            let _e319 = (*currentIndex_7);
            let _e322 = atomicExchange((&unnamed.grid[_e319]), 0u);
            return;
        }
        let _e323 = (*currentIndex_7);
        let _e326 = atomicExchange((&unnamed.grid[_e323]), 0u);
        return;
    }
    let _e327 = (*currentAge_5);
    newAge = min((_e327 + 1u), 255u);
    let _e330 = (*currentSleep_3);
    let _e332 = tuning.steamCondenseTicks;
    if (_e330 >= _e332) {
        let _e335 = unnamed_2.rainPhase;
        let _e336 = (_e335 == 2u);
        phi_8986_ = _e336;
        if !(_e336) {
            let _e338 = (*pos_12);
            param_456 = _e338;
            let _e339 = cloudTouchesRain_u0028_vi3_u003b((&param_456));
            phi_8986_ = _e339;
        }
        let _e341 = phi_8986_;
        newKind_1 = select(1u, 2u, _e341);
        let _e343 = (*currentIndex_7);
        let _e346 = newKind_1;
        param_457 = _e346;
        param_458 = false;
        param_459 = 0u;
        param_460 = 0u;
        let _e347 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_457), (&param_458), (&param_459), (&param_460));
        let _e348 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e343]), 0u, _e347);
        let _e350 = (*currentIndex_7);
        let _e353 = atomicExchange((&unnamed.grid[_e350]), 0u);
        return;
    }
    let _e354 = (*randVal_8);
    let _e358 = tuning.steamScatterChance;
    if (fract((_e354 * 88f)) < _e358) {
        let _e360 = (*randVal_8);
        d_9 = i32((fract((_e360 * 13f)) * 6f));
        let _e365 = (*pos_12);
        let _e366 = d_9;
        param_461 = _e366;
        let _e367 = getOrthoDir_u0028_i1_u003b((&param_461));
        scatterPos = (_e365 + _e367);
        let _e370 = scatterPos[0u];
        let _e371 = (_e370 > 0i);
        phi_9035_ = _e371;
        if _e371 {
            let _e373 = scatterPos[0u];
            let _e375 = tuning.gridWidth;
            phi_9035_ = (_e373 < (bitcast<i32>(_e375) - 1i));
        }
        let _e380 = phi_9035_;
        phi_9041_ = _e380;
        if _e380 {
            let _e382 = scatterPos[1u];
            phi_9041_ = (_e382 > 0i);
        }
        let _e385 = phi_9041_;
        phi_9051_ = _e385;
        if _e385 {
            let _e387 = scatterPos[1u];
            let _e389 = tuning.gridHeight;
            phi_9051_ = (_e387 < (bitcast<i32>(_e389) - 1i));
        }
        let _e394 = phi_9051_;
        phi_9057_ = _e394;
        if _e394 {
            let _e396 = scatterPos[2u];
            phi_9057_ = (_e396 > 0i);
        }
        let _e399 = phi_9057_;
        phi_9067_ = _e399;
        if _e399 {
            let _e401 = scatterPos[2u];
            let _e403 = tuning.gridDepth;
            phi_9067_ = (_e401 < (bitcast<i32>(_e403) - 1i));
        }
        let _e408 = phi_9067_;
        if _e408 {
            let _e409 = scatterPos;
            param_462 = _e409;
            let _e410 = getIndex_u0028_vi3_u003b((&param_462));
            param_463 = _e410;
            let _e411 = readCell_u0028_u1_u003b((&param_463));
            param_464 = _e411;
            let _e412 = getType_u0028_u1_u003b((&param_464));
            sType = _e412;
            let _e413 = sType;
            let _e415 = sType;
            let _e417 = ((_e413 == 0u) || (_e415 == 5u));
            phi_9093_ = _e417;
            if _e417 {
                let _e418 = scatterPos;
                param_465 = _e418;
                let _e419 = getIndex_u0028_vi3_u003b((&param_465));
                let _e422 = atomicLoad((&unnamed_1.cloudCells[_e419]));
                param_466 = _e422;
                let _e423 = getCloudKind_u0028_u1_u003b((&param_466));
                phi_9093_ = (_e423 == 0u);
            }
            let _e426 = phi_9093_;
            if _e426 {
                let _e427 = (*currentSleep_3);
                carried_1 = min((_e427 + 1u), 255u);
                let _e430 = scatterPos;
                param_467 = _e430;
                let _e431 = getIndex_u0028_vi3_u003b((&param_467));
                param_468 = 6u;
                param_469 = 0u;
                let _e432 = carried_1;
                param_470 = _e432;
                let _e433 = newAge;
                param_471 = _e433;
                let _e434 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_468), (&param_469), (&param_470), (&param_471));
                let _e435 = (*currentIndex_7);
                param_472 = _e435;
                let _e436 = (*rawValue_6);
                param_473 = _e436;
                param_474 = _e431;
                param_475 = _e434;
                let _e437 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_472), (&param_473), (&param_474), (&param_475));
                if _e437 {
                    return;
                }
            }
        }
    }
    let _e438 = (*pos_12);
    checkPos[0i] = (_e438 + vec3<i32>(0i, 1i, 0i));
    let _e441 = (*randVal_8);
    dir_2 = select(-1i, 1i, (fract((_e441 * 10f)) > 0.5f));
    let _e446 = (*randVal_8);
    if (fract((_e446 * 100f)) > 0.5f) {
        let _e450 = (*pos_12);
        let _e451 = dir_2;
        checkPos[1i] = (_e450 + vec3<i32>(_e451, 1i, 0i));
        let _e455 = (*pos_12);
        let _e456 = dir_2;
        checkPos[2i] = (_e455 + vec3<i32>(0i, 1i, _e456));
    } else {
        let _e460 = (*pos_12);
        let _e461 = dir_2;
        checkPos[1i] = (_e460 + vec3<i32>(0i, 1i, _e461));
        let _e465 = (*pos_12);
        let _e466 = dir_2;
        checkPos[2i] = (_e465 + vec3<i32>(_e466, 1i, 0i));
    }
    let _e470 = (*pos_12);
    upPos_1 = (_e470 + vec3<i32>(0i, 1i, 0i));
    let _e472 = upPos_1;
    param_476 = _e472;
    let _e473 = cloudCellInBounds_u0028_vi3_u003b((&param_476));
    phi_9175_ = _e473;
    if _e473 {
        let _e474 = upPos_1;
        param_477 = _e474;
        let _e475 = getIndex_u0028_vi3_u003b((&param_477));
        let _e478 = atomicLoad((&unnamed_1.cloudCells[_e475]));
        param_478 = _e478;
        let _e479 = cloudIsAtRest_u0028_u1_u003b((&param_478));
        phi_9175_ = _e479;
    }
    let _e481 = phi_9175_;
    underSettled = _e481;
    let _e482 = (*pos_12);
    param_479 = _e482;
    let _e483 = cloudTouchesRain_u0028_vi3_u003b((&param_479));
    touchingRain = _e483;
    let _e484 = underSettled;
    let _e485 = touchingRain;
    if (_e484 || _e485) {
        let _e487 = touchingRain;
        phi_9193_ = _e487;
        if !(_e487) {
            let _e490 = unnamed_2.rainPhase;
            phi_9193_ = (_e490 == 2u);
        }
        let _e493 = phi_9193_;
        newKind_2 = select(1u, 2u, _e493);
        let _e495 = (*currentIndex_7);
        let _e498 = newKind_2;
        param_480 = _e498;
        param_481 = false;
        param_482 = 0u;
        param_483 = 0u;
        let _e499 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_480), (&param_481), (&param_482), (&param_483));
        let _e500 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e495]), 0u, _e499);
        let _e502 = (*currentIndex_7);
        let _e505 = atomicExchange((&unnamed.grid[_e502]), 0u);
        return;
    }
    i_13 = 0i;
    loop {
        let _e506 = i_13;
        if (_e506 < 3i) {
            let _e508 = i_13;
            let _e510 = checkPos[_e508];
            cPos = _e510;
            let _e512 = cPos[0u];
            let _e513 = (_e512 > 0i);
            phi_9232_ = _e513;
            if _e513 {
                let _e515 = cPos[0u];
                let _e517 = tuning.gridWidth;
                phi_9232_ = (_e515 < (bitcast<i32>(_e517) - 1i));
            }
            let _e522 = phi_9232_;
            phi_9238_ = _e522;
            if _e522 {
                let _e524 = cPos[2u];
                phi_9238_ = (_e524 > 0i);
            }
            let _e527 = phi_9238_;
            phi_9248_ = _e527;
            if _e527 {
                let _e529 = cPos[2u];
                let _e531 = tuning.gridDepth;
                phi_9248_ = (_e529 < (bitcast<i32>(_e531) - 1i));
            }
            let _e536 = phi_9248_;
            if _e536 {
                let _e537 = cPos;
                param_484 = _e537;
                let _e538 = getIndex_u0028_vi3_u003b((&param_484));
                cIndex = _e538;
                let _e539 = cIndex;
                param_485 = _e539;
                let _e540 = readCell_u0028_u1_u003b((&param_485));
                cVal = _e540;
                let _e541 = cVal;
                param_486 = _e541;
                let _e542 = getType_u0028_u1_u003b((&param_486));
                cType = _e542;
                let _e543 = cType;
                let _e545 = cType;
                if ((_e543 == 1u) || (_e545 == 4u)) {
                    let _e548 = cVal;
                    param_487 = _e548;
                    let _e549 = getAge_u0028_u1_u003b((&param_487));
                    moisture_2 = _e549;
                    let _e550 = cType;
                    if (_e550 == 4u) {
                        let _e553 = tuning.dirtMoistureCapacity;
                        local_15 = _e553;
                    } else {
                        let _e555 = tuning.sandMoistureCapacity;
                        local_15 = _e555;
                    }
                    let _e556 = local_15;
                    capacity = _e556;
                    let _e557 = moisture_2;
                    let _e558 = capacity;
                    if (_e557 < _e558) {
                        let _e560 = (*currentIndex_7);
                        let _e563 = (*rawValue_6);
                        let _e564 = atomicCompareExchangeWeak((&unnamed.grid[_e560]), _e563, 0u);
                        let _e566 = (*rawValue_6);
                        if (_e564.old_value == _e566) {
                            let _e568 = cIndex;
                            let _e571 = atomicAdd((&unnamed.grid[_e568]), 16777216u);
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
            let _e572 = i_13;
            i_13 = (_e572 + 1i);
        }
    }
    i_14 = 0i;
    loop {
        let _e574 = i_14;
        if (_e574 < 3i) {
            let _e576 = i_14;
            let _e578 = checkPos[_e576];
            sPos_1 = _e578;
            let _e580 = sPos_1[1u];
            let _e582 = tuning.gridHeight;
            let _e585 = (_e580 < (bitcast<i32>(_e582) - 1i));
            phi_9329_ = _e585;
            if _e585 {
                let _e587 = sPos_1[0u];
                phi_9329_ = (_e587 > 0i);
            }
            let _e590 = phi_9329_;
            phi_9339_ = _e590;
            if _e590 {
                let _e592 = sPos_1[0u];
                let _e594 = tuning.gridWidth;
                phi_9339_ = (_e592 < (bitcast<i32>(_e594) - 1i));
            }
            let _e599 = phi_9339_;
            phi_9345_ = _e599;
            if _e599 {
                let _e601 = sPos_1[2u];
                phi_9345_ = (_e601 > 0i);
            }
            let _e604 = phi_9345_;
            phi_9355_ = _e604;
            if _e604 {
                let _e606 = sPos_1[2u];
                let _e608 = tuning.gridDepth;
                phi_9355_ = (_e606 < (bitcast<i32>(_e608) - 1i));
            }
            let _e613 = phi_9355_;
            if _e613 {
                let _e614 = sPos_1;
                param_488 = _e614;
                let _e615 = getIndex_u0028_vi3_u003b((&param_488));
                param_489 = _e615;
                let _e616 = readCell_u0028_u1_u003b((&param_489));
                param_490 = _e616;
                let _e617 = getType_u0028_u1_u003b((&param_490));
                sType_1 = _e617;
                let _e618 = sType_1;
                let _e620 = sType_1;
                let _e622 = ((_e618 == 0u) || (_e620 == 5u));
                phi_9381_ = _e622;
                if _e622 {
                    let _e623 = sPos_1;
                    param_491 = _e623;
                    let _e624 = getIndex_u0028_vi3_u003b((&param_491));
                    let _e627 = atomicLoad((&unnamed_1.cloudCells[_e624]));
                    param_492 = _e627;
                    let _e628 = getCloudKind_u0028_u1_u003b((&param_492));
                    phi_9381_ = (_e628 == 0u);
                }
                let _e631 = phi_9381_;
                if _e631 {
                    let _e632 = sPos_1;
                    param_493 = _e632;
                    let _e633 = getIndex_u0028_vi3_u003b((&param_493));
                    param_494 = 6u;
                    param_495 = 0u;
                    param_496 = 0u;
                    let _e634 = newAge;
                    param_497 = _e634;
                    let _e635 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_494), (&param_495), (&param_496), (&param_497));
                    let _e636 = (*currentIndex_7);
                    param_498 = _e636;
                    let _e637 = (*rawValue_6);
                    param_499 = _e637;
                    param_500 = _e633;
                    param_501 = _e635;
                    let _e638 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_498), (&param_499), (&param_500), (&param_501));
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
            let _e639 = i_14;
            i_14 = (_e639 + 1i);
        }
    }
    let _e641 = (*currentSleep_3);
    newSleep_1 = min((_e641 + 1u), 255u);
    let _e644 = (*currentIndex_7);
    let _e647 = (*rawValue_6);
    param_502 = 6u;
    param_503 = 0u;
    let _e648 = newSleep_1;
    param_504 = _e648;
    let _e649 = newAge;
    param_505 = _e649;
    let _e650 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_502), (&param_503), (&param_504), (&param_505));
    let _e651 = atomicCompareExchangeWeak((&unnamed.grid[_e644]), _e647, _e650);
    return;
}

fn updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_13: ptr<function, vec3<i32>>, currentIndex_8: ptr<function, u32>, rawValue_7: ptr<function, u32>, currentDir_3: ptr<function, u32>, currentSleep_4: ptr<function, u32>, currentAge_6: ptr<function, u32>, randVal_9: ptr<function, f32>) {
    var newAge_1: u32;
    var isBurningGrass: bool;
    var i_15: i32;
    var nPos_2: vec3<i32>;
    var param_506: i32;
    var nIndex_1: u32;
    var param_507: vec3<i32>;
    var nVal_1: u32;
    var param_508: u32;
    var param_509: u32;
    var param_510: u32;
    var param_511: u32;
    var param_512: u32;
    var param_513: u32;
    var burnRoll: f32;
    var start_8: i32;
    var i_16: i32;
    var nPos_3: vec3<i32>;
    var param_514: i32;
    var param_515: vec3<i32>;
    var nIndex_2: u32;
    var param_516: vec3<i32>;
    var nVal_2: u32;
    var param_517: u32;
    var nType_2: u32;
    var param_518: u32;
    var need_1: f32;
    var local_16: f32;
    var param_519: u32;
    var param_520: u32;
    var param_521: u32;
    var param_522: u32;
    var belowPos_5: vec3<i32>;
    var belowIndex_2: u32;
    var param_523: vec3<i32>;
    var belowValue_2: u32;
    var param_524: u32;
    var belowType: u32;
    var param_525: u32;
    var param_526: u32;
    var param_527: u32;
    var param_528: u32;
    var param_529: u32;
    var param_530: u32;
    var param_531: u32;
    var param_532: u32;
    var param_533: u32;
    var moisture_3: u32;
    var param_534: u32;
    var newMoisture: u32;
    var local_17: u32;
    var newVal: u32;
    var param_535: u32;
    var param_536: u32;
    var param_537: u32;
    var param_538: u32;
    var param_539: u32;
    var flora_4: u32;
    var newFlora: u32;
    var newVal_1: u32;
    var param_540: u32;
    var param_541: u32;
    var param_542: u32;
    var param_543: u32;
    var param_544: u32;
    var d_10: i32;
    var targetPos_1: vec3<i32>;
    var param_545: i32;
    var targetIndex_1: u32;
    var param_546: vec3<i32>;
    var param_547: u32;
    var param_548: u32;
    var targetBelow: vec3<i32>;
    var tBelowVal: u32;
    var param_549: vec3<i32>;
    var param_550: u32;
    var param_551: u32;
    var tFlora: u32;
    var param_552: u32;
    var param_553: u32;
    var param_554: u32;
    var param_555: u32;
    var remains: u32;
    var local_18: u32;
    var param_556: u32;
    var param_557: u32;
    var param_558: u32;
    var param_559: u32;
    var param_560: u32;
    var param_561: u32;
    var param_562: u32;
    var param_563: u32;
    var phi_8264_: bool;
    var phi_8270_: bool;
    var phi_8280_: bool;
    var phi_8286_: bool;
    var phi_8296_: bool;
    var phi_8604_: bool;
    var phi_8610_: bool;
    var phi_8620_: bool;

    let _e314 = (*currentAge_6);
    newAge_1 = (_e314 + 1u);
    isBurningGrass = false;
    i_15 = 0i;
    loop {
        let _e316 = i_15;
        if (_e316 < 6i) {
            let _e318 = (*pos_13);
            let _e319 = i_15;
            param_506 = _e319;
            let _e320 = getOrthoDir_u0028_i1_u003b((&param_506));
            nPos_2 = (_e318 + _e320);
            let _e323 = nPos_2[0u];
            let _e324 = (_e323 > 0i);
            phi_8264_ = _e324;
            if _e324 {
                let _e326 = nPos_2[0u];
                let _e328 = tuning.gridWidth;
                phi_8264_ = (_e326 < (bitcast<i32>(_e328) - 1i));
            }
            let _e333 = phi_8264_;
            phi_8270_ = _e333;
            if _e333 {
                let _e335 = nPos_2[1u];
                phi_8270_ = (_e335 > 0i);
            }
            let _e338 = phi_8270_;
            phi_8280_ = _e338;
            if _e338 {
                let _e340 = nPos_2[1u];
                let _e342 = tuning.gridHeight;
                phi_8280_ = (_e340 < (bitcast<i32>(_e342) - 1i));
            }
            let _e347 = phi_8280_;
            phi_8286_ = _e347;
            if _e347 {
                let _e349 = nPos_2[2u];
                phi_8286_ = (_e349 > 0i);
            }
            let _e352 = phi_8286_;
            phi_8296_ = _e352;
            if _e352 {
                let _e354 = nPos_2[2u];
                let _e356 = tuning.gridDepth;
                phi_8296_ = (_e354 < (bitcast<i32>(_e356) - 1i));
            }
            let _e361 = phi_8296_;
            if _e361 {
                let _e362 = nPos_2;
                param_507 = _e362;
                let _e363 = getIndex_u0028_vi3_u003b((&param_507));
                nIndex_1 = _e363;
                let _e364 = nIndex_1;
                param_508 = _e364;
                let _e365 = readCell_u0028_u1_u003b((&param_508));
                nVal_1 = _e365;
                let _e366 = nVal_1;
                param_509 = _e366;
                let _e367 = getType_u0028_u1_u003b((&param_509));
                if (_e367 == 2u) {
                    let _e369 = nIndex_1;
                    let _e372 = nVal_1;
                    param_510 = 6u;
                    param_511 = 0u;
                    param_512 = 0u;
                    param_513 = 0u;
                    let _e373 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_510), (&param_511), (&param_512), (&param_513));
                    let _e374 = atomicCompareExchangeWeak((&unnamed.grid[_e369]), _e372, _e373);
                    let _e376 = nVal_1;
                    if (_e374.old_value == _e376) {
                        decWater_u0028_();
                        let _e378 = (*currentIndex_8);
                        let _e381 = atomicExchange((&unnamed.grid[_e378]), 0u);
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e382 = i_15;
            i_15 = (_e382 + 1i);
        }
    }
    let _e384 = (*randVal_9);
    burnRoll = fract((_e384 * 47f));
    let _e387 = burnRoll;
    let _e389 = tuning.treeLeafBurnChance;
    let _e391 = tuning.treeTrunkBurnChance;
    if (_e387 < max(_e389, _e391)) {
        let _e394 = (*randVal_9);
        start_8 = i32((fract((_e394 * 31f)) * 26f));
        i_16 = 0i;
        loop {
            let _e399 = i_16;
            if (_e399 < 26i) {
                let _e401 = (*pos_13);
                let _e402 = start_8;
                let _e403 = i_16;
                let _e404 = (_e402 + _e403);
                param_514 = (_e404 - (i32(floor((f32(_e404) / f32(26i)))) * 26i));
                let _e412 = tree26_u0028_i1_u003b((&param_514));
                nPos_3 = (_e401 + _e412);
                let _e414 = nPos_3;
                param_515 = _e414;
                let _e415 = treeInBounds_u0028_vi3_u003b((&param_515));
                if !(_e415) {
                    continue;
                }
                let _e417 = nPos_3;
                param_516 = _e417;
                let _e418 = getIndex_u0028_vi3_u003b((&param_516));
                nIndex_2 = _e418;
                let _e419 = nIndex_2;
                param_517 = _e419;
                let _e420 = readCell_u0028_u1_u003b((&param_517));
                nVal_2 = _e420;
                let _e421 = nVal_2;
                param_518 = _e421;
                let _e422 = getType_u0028_u1_u003b((&param_518));
                nType_2 = _e422;
                let _e423 = nType_2;
                let _e425 = nType_2;
                if ((_e423 != 19u) && (_e425 != 18u)) {
                    continue;
                }
                let _e428 = nType_2;
                if (_e428 == 19u) {
                    let _e431 = tuning.treeLeafBurnChance;
                    local_16 = _e431;
                } else {
                    let _e433 = tuning.treeTrunkBurnChance;
                    local_16 = _e433;
                }
                let _e434 = local_16;
                need_1 = _e434;
                let _e435 = burnRoll;
                let _e436 = need_1;
                if (_e435 < _e436) {
                    let _e438 = nIndex_2;
                    let _e441 = nVal_2;
                    param_519 = 5u;
                    param_520 = 0u;
                    param_521 = 0u;
                    param_522 = 0u;
                    let _e442 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_519), (&param_520), (&param_521), (&param_522));
                    let _e443 = atomicCompareExchangeWeak((&unnamed.grid[_e438]), _e441, _e442);
                }
                break;
            } else {
                break;
            }
            continuing {
                let _e445 = i_16;
                i_16 = (_e445 + 1i);
            }
        }
    }
    let _e448 = (*pos_13)[1u];
    if (_e448 > 1i) {
        let _e450 = (*pos_13);
        belowPos_5 = (_e450 + vec3<i32>(0i, -1i, 0i));
        let _e452 = belowPos_5;
        param_523 = _e452;
        let _e453 = getIndex_u0028_vi3_u003b((&param_523));
        belowIndex_2 = _e453;
        let _e454 = belowIndex_2;
        param_524 = _e454;
        let _e455 = readCell_u0028_u1_u003b((&param_524));
        belowValue_2 = _e455;
        let _e456 = belowValue_2;
        param_525 = _e456;
        let _e457 = getType_u0028_u1_u003b((&param_525));
        belowType = _e457;
        let _e458 = belowType;
        if (_e458 == 0u) {
            param_526 = 5u;
            param_527 = 0u;
            param_528 = 0u;
            let _e460 = newAge_1;
            param_529 = _e460;
            let _e461 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_526), (&param_527), (&param_528), (&param_529));
            let _e462 = (*currentIndex_8);
            param_530 = _e462;
            let _e463 = (*rawValue_7);
            param_531 = _e463;
            let _e464 = belowIndex_2;
            param_532 = _e464;
            param_533 = _e461;
            let _e465 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_530), (&param_531), (&param_532), (&param_533));
            if _e465 {
                return;
            }
        } else {
            let _e466 = belowType;
            if (_e466 == 2u) {
                let _e468 = (*currentIndex_8);
                let _e471 = atomicExchange((&unnamed.grid[_e468]), 0u);
                return;
            } else {
                let _e472 = belowType;
                if (_e472 == 1u) {
                    let _e474 = belowValue_2;
                    param_534 = _e474;
                    let _e475 = getAge_u0028_u1_u003b((&param_534));
                    moisture_3 = _e475;
                    let _e476 = moisture_3;
                    if (_e476 > 0u) {
                        let _e478 = moisture_3;
                        let _e480 = tuning.fireDryRate;
                        if (_e478 > _e480) {
                            let _e482 = moisture_3;
                            let _e484 = tuning.fireDryRate;
                            local_17 = (_e482 - _e484);
                        } else {
                            local_17 = 0u;
                        }
                        let _e486 = local_17;
                        newMoisture = _e486;
                        let _e487 = belowValue_2;
                        param_535 = _e487;
                        let _e488 = getDir_u0028_u1_u003b((&param_535));
                        param_536 = 1u;
                        param_537 = _e488;
                        param_538 = 0u;
                        let _e489 = newMoisture;
                        param_539 = _e489;
                        let _e490 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_536), (&param_537), (&param_538), (&param_539));
                        newVal = _e490;
                        let _e491 = belowIndex_2;
                        let _e494 = belowValue_2;
                        let _e495 = newVal;
                        let _e496 = atomicCompareExchangeWeak((&unnamed.grid[_e491]), _e494, _e495);
                        let _e498 = belowValue_2;
                        if (_e496.old_value == _e498) {
                            let _e500 = (*currentIndex_8);
                            let _e503 = atomicExchange((&unnamed.grid[_e500]), 0u);
                            return;
                        }
                    }
                } else {
                    let _e504 = belowType;
                    if (_e504 == 4u) {
                        let _e506 = belowValue_2;
                        flora_4 = ((_e506 >> bitcast<u32>(8i)) & 255u);
                        let _e510 = flora_4;
                        let _e512 = flora_4;
                        if ((_e510 > 10u) && (_e512 <= 100u)) {
                            isBurningGrass = true;
                            newAge_1 = 0u;
                            let _e515 = (*randVal_9);
                            let _e519 = tuning.fireBurnGrassChance;
                            if (fract((_e515 * 100f)) < _e519) {
                                let _e521 = flora_4;
                                newFlora = (_e521 - 1u);
                                let _e523 = belowValue_2;
                                param_540 = _e523;
                                let _e524 = getAge_u0028_u1_u003b((&param_540));
                                param_541 = 4u;
                                let _e525 = newFlora;
                                param_542 = _e525;
                                param_543 = 0u;
                                param_544 = _e524;
                                let _e526 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_541), (&param_542), (&param_543), (&param_544));
                                newVal_1 = _e526;
                                let _e527 = belowIndex_2;
                                let _e530 = belowValue_2;
                                let _e531 = newVal_1;
                                let _e532 = atomicCompareExchangeWeak((&unnamed.grid[_e527]), _e530, _e531);
                            }
                            let _e534 = (*randVal_9);
                            let _e538 = tuning.fireSpreadChance;
                            if (fract((_e534 * 100f)) < _e538) {
                                let _e540 = (*randVal_9);
                                d_10 = i32((fract((_e540 * 10f)) * 8f));
                                let _e545 = (*pos_13);
                                let _e546 = d_10;
                                param_545 = _e546;
                                let _e547 = getHDir_u0028_i1_u003b((&param_545));
                                targetPos_1 = (_e545 + _e547);
                                let _e550 = targetPos_1[0u];
                                let _e551 = (_e550 > 0i);
                                phi_8604_ = _e551;
                                if _e551 {
                                    let _e553 = targetPos_1[0u];
                                    let _e555 = tuning.gridWidth;
                                    phi_8604_ = (_e553 < (bitcast<i32>(_e555) - 1i));
                                }
                                let _e560 = phi_8604_;
                                phi_8610_ = _e560;
                                if _e560 {
                                    let _e562 = targetPos_1[2u];
                                    phi_8610_ = (_e562 > 0i);
                                }
                                let _e565 = phi_8610_;
                                phi_8620_ = _e565;
                                if _e565 {
                                    let _e567 = targetPos_1[2u];
                                    let _e569 = tuning.gridDepth;
                                    phi_8620_ = (_e567 < (bitcast<i32>(_e569) - 1i));
                                }
                                let _e574 = phi_8620_;
                                if _e574 {
                                    let _e575 = targetPos_1;
                                    param_546 = _e575;
                                    let _e576 = getIndex_u0028_vi3_u003b((&param_546));
                                    targetIndex_1 = _e576;
                                    let _e577 = targetIndex_1;
                                    param_547 = _e577;
                                    let _e578 = readCell_u0028_u1_u003b((&param_547));
                                    param_548 = _e578;
                                    let _e579 = getType_u0028_u1_u003b((&param_548));
                                    if (_e579 == 0u) {
                                        let _e581 = targetPos_1;
                                        targetBelow = (_e581 + vec3<i32>(0i, -1i, 0i));
                                        let _e583 = targetBelow;
                                        param_549 = _e583;
                                        let _e584 = getIndex_u0028_vi3_u003b((&param_549));
                                        param_550 = _e584;
                                        let _e585 = readCell_u0028_u1_u003b((&param_550));
                                        tBelowVal = _e585;
                                        let _e586 = tBelowVal;
                                        param_551 = _e586;
                                        let _e587 = getType_u0028_u1_u003b((&param_551));
                                        if (_e587 == 4u) {
                                            let _e589 = tBelowVal;
                                            tFlora = ((_e589 >> bitcast<u32>(8i)) & 255u);
                                            let _e593 = tFlora;
                                            let _e595 = tFlora;
                                            if ((_e593 > 10u) && (_e595 <= 100u)) {
                                                let _e598 = targetIndex_1;
                                                param_552 = 5u;
                                                param_553 = 0u;
                                                param_554 = 0u;
                                                param_555 = 0u;
                                                let _e601 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_552), (&param_553), (&param_554), (&param_555));
                                                let _e602 = atomicCompareExchangeWeak((&unnamed.grid[_e598]), 0u, _e601);
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
    let _e604 = newAge_1;
    let _e606 = tuning.fireLifetime;
    if (_e604 > _e606) {
        let _e608 = (*randVal_9);
        let _e612 = tuning.fireAshChance;
        if (fract((_e608 * 83f)) < _e612) {
            param_556 = 20u;
            param_557 = 0u;
            param_558 = 0u;
            param_559 = 0u;
            let _e614 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_556), (&param_557), (&param_558), (&param_559));
            local_18 = _e614;
        } else {
            local_18 = 0u;
        }
        let _e615 = local_18;
        remains = _e615;
        let _e616 = (*currentIndex_8);
        let _e619 = remains;
        let _e620 = atomicExchange((&unnamed.grid[_e616]), _e619);
        return;
    }
    let _e621 = (*currentIndex_8);
    let _e624 = (*rawValue_7);
    param_560 = 5u;
    param_561 = 0u;
    param_562 = 0u;
    let _e625 = newAge_1;
    param_563 = _e625;
    let _e626 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_560), (&param_561), (&param_562), (&param_563));
    let _e627 = atomicCompareExchangeWeak((&unnamed.grid[_e621]), _e624, _e626);
    return;
}

fn isLocust_u0028_u1_u003b(type_36: ptr<function, u32>) -> bool {
    let _e216 = (*type_36);
    let _e218 = (*type_36);
    return ((_e216 >= 13u) && (_e218 <= 17u));
}

fn tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex_9: ptr<function, u32>, currentValue_1: ptr<function, u32>, targetIndex_2: ptr<function, u32>, targetValue_1: ptr<function, u32>, pushIndex: ptr<function, u32>) -> bool {
    var displacedValue: u32;
    var param_564: u32;
    var param_565: u32;
    var param_566: u32;
    var param_567: u32;
    var param_568: u32;
    var actualPush: u32;
    var actualTarget: u32;

    let _e228 = (*currentIndex_9);
    let _e231 = (*currentValue_1);
    let _e232 = atomicCompareExchangeWeak((&unnamed.grid[_e228]), _e231, 0u);
    let _e234 = (*currentValue_1);
    if (_e232.old_value == _e234) {
        let _e236 = (*targetValue_1);
        param_564 = _e236;
        let _e237 = getType_u0028_u1_u003b((&param_564));
        param_565 = _e237;
        param_566 = 0u;
        param_567 = 0u;
        param_568 = 0u;
        let _e238 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_565), (&param_566), (&param_567), (&param_568));
        displacedValue = _e238;
        let _e239 = (*pushIndex);
        let _e242 = displacedValue;
        let _e243 = atomicCompareExchangeWeak((&unnamed.grid[_e239]), 0u, _e242);
        actualPush = _e243.old_value;
        let _e245 = actualPush;
        if (_e245 == 0u) {
            let _e247 = (*targetIndex_2);
            let _e250 = (*targetValue_1);
            let _e251 = (*currentValue_1);
            let _e252 = atomicCompareExchangeWeak((&unnamed.grid[_e247]), _e250, _e251);
            actualTarget = _e252.old_value;
            let _e254 = actualTarget;
            let _e255 = (*targetValue_1);
            if (_e254 == _e255) {
                return true;
            } else {
                let _e257 = (*pushIndex);
                let _e260 = displacedValue;
                let _e261 = atomicCompareExchangeWeak((&unnamed.grid[_e257]), _e260, 0u);
            }
        }
        let _e263 = (*currentIndex_9);
        let _e266 = (*currentValue_1);
        let _e267 = atomicCompareExchangeWeak((&unnamed.grid[_e263]), 0u, _e266);
    }
    return false;
}

fn grainCanMove_u0028_vi3_u003b(pos_14: ptr<function, vec3<i32>>) -> bool {
    var i_17: i32;
    var target_3: vec3<i32>;
    var local_19: i32;
    var local_20: i32;
    var t_4: u32;
    var param_569: vec3<i32>;
    var param_570: u32;
    var param_571: u32;
    var phi_2466_: bool;
    var phi_2473_: bool;
    var phi_2484_: bool;

    let _e225 = (*pos_14)[1u];
    if (_e225 <= 1i) {
        return false;
    }
    i_17 = 0i;
    loop {
        let _e227 = i_17;
        if (_e227 < 5i) {
            let _e229 = (*pos_14);
            let _e230 = i_17;
            if (_e230 == 1i) {
                local_19 = 1i;
            } else {
                let _e232 = i_17;
                local_19 = select(0i, -1i, (_e232 == 2i));
            }
            let _e235 = local_19;
            let _e236 = i_17;
            if (_e236 == 3i) {
                local_20 = 1i;
            } else {
                let _e238 = i_17;
                local_20 = select(0i, -1i, (_e238 == 4i));
            }
            let _e241 = local_20;
            target_3 = (_e229 + vec3<i32>(_e235, -1i, _e241));
            let _e245 = target_3[0u];
            let _e246 = (_e245 <= 0i);
            phi_2466_ = _e246;
            if !(_e246) {
                let _e249 = target_3[0u];
                let _e251 = tuning.gridWidth;
                phi_2466_ = (_e249 >= (bitcast<i32>(_e251) - 1i));
            }
            let _e256 = phi_2466_;
            phi_2473_ = _e256;
            if !(_e256) {
                let _e259 = target_3[2u];
                phi_2473_ = (_e259 <= 0i);
            }
            let _e262 = phi_2473_;
            phi_2484_ = _e262;
            if !(_e262) {
                let _e265 = target_3[2u];
                let _e267 = tuning.gridDepth;
                phi_2484_ = (_e265 >= (bitcast<i32>(_e267) - 1i));
            }
            let _e272 = phi_2484_;
            if _e272 {
                continue;
            }
            let _e273 = target_3;
            param_569 = _e273;
            let _e274 = getIndex_u0028_vi3_u003b((&param_569));
            param_570 = _e274;
            let _e275 = readCell_u0028_u1_u003b((&param_570));
            param_571 = _e275;
            let _e276 = getType_u0028_u1_u003b((&param_571));
            t_4 = _e276;
            let _e277 = t_4;
            let _e279 = t_4;
            if ((_e277 == 0u) || (_e279 == 2u)) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e282 = i_17;
            i_17 = (_e282 + 1i);
        }
    }
    return false;
}

fn updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_15: ptr<function, vec3<i32>>, currentIndex_10: ptr<function, u32>, rawValue_8: ptr<function, u32>, currentDir_4: ptr<function, u32>, currentSleep_5: ptr<function, u32>, currentAge_7: ptr<function, u32>, randVal_10: ptr<function, f32>) {
    var moisture_4: u32;
    var moistureModified: bool;
    var startDir_1: i32;
    var i_18: i32;
    var d_11: i32;
    var nPos_4: vec3<i32>;
    var param_572: i32;
    var nIndex_3: u32;
    var param_573: vec3<i32>;
    var nVal_3: u32;
    var param_574: u32;
    var param_575: u32;
    var d_12: i32;
    var nPos_5: vec3<i32>;
    var param_576: i32;
    var nIndex_4: u32;
    var param_577: vec3<i32>;
    var nVal_4: u32;
    var param_578: u32;
    var nType_3: u32;
    var param_579: u32;
    var nMoisture: u32;
    var param_580: u32;
    var nCapacity: u32;
    var local_21: u32;
    var canMove: bool;
    var param_581: vec3<i32>;
    var isClumped: bool;
    var emptyBelowCount: i32;
    var x: i32;
    var z: i32;
    var checkPos_1: vec3<i32>;
    var param_582: vec3<i32>;
    var param_583: u32;
    var param_584: u32;
    var clumpCount: i32;
    var x_1: i32;
    var y: i32;
    var z_1: i32;
    var nPos_6: vec3<i32>;
    var param_585: vec3<i32>;
    var param_586: u32;
    var param_587: u32;
    var belowPos_6: vec3<i32>;
    var param_588: vec3<i32>;
    var param_589: u32;
    var param_590: u32;
    var param_591: vec3<i32>;
    var param_592: u32;
    var param_593: u32;
    var param_594: u32;
    var param_595: u32;
    var param_596: u32;
    var param_597: u32;
    var param_598: u32;
    var param_599: u32;
    var dir_3: i32;
    var slidePos1_: vec3<i32>;
    var slidePos2_: vec3<i32>;
    var param_600: vec3<i32>;
    var param_601: u32;
    var param_602: u32;
    var param_603: vec3<i32>;
    var param_604: u32;
    var param_605: u32;
    var param_606: u32;
    var param_607: u32;
    var param_608: u32;
    var param_609: u32;
    var param_610: u32;
    var param_611: u32;
    var param_612: vec3<i32>;
    var param_613: u32;
    var param_614: u32;
    var param_615: vec3<i32>;
    var param_616: u32;
    var param_617: u32;
    var param_618: u32;
    var param_619: u32;
    var param_620: u32;
    var param_621: u32;
    var param_622: u32;
    var param_623: u32;
    var belowPos_7: vec3<i32>;
    var belowIndex_3: u32;
    var param_624: vec3<i32>;
    var belowValue_3: u32;
    var param_625: u32;
    var param_626: u32;
    var startDir_2: i32;
    var i_19: i32;
    var d_13: i32;
    var pushPos: vec3<i32>;
    var param_627: i32;
    var param_628: u32;
    var param_629: u32;
    var param_630: u32;
    var param_631: u32;
    var param_632: vec3<i32>;
    var param_633: u32;
    var param_634: u32;
    var param_635: u32;
    var param_636: u32;
    var param_637: u32;
    var param_638: u32;
    var param_639: u32;
    var param_640: u32;
    var param_641: u32;
    var param_642: u32;
    var param_643: u32;
    var param_644: u32;
    var param_645: u32;
    var dir_4: i32;
    var slidePos: array<vec3<i32>, 2>;
    var s_2: i32;
    var sPos_2: vec3<i32>;
    var sIndex: u32;
    var param_646: vec3<i32>;
    var sValue: u32;
    var param_647: u32;
    var param_648: u32;
    var startDir_3: i32;
    var i_20: i32;
    var d_14: i32;
    var pushPos_1: vec3<i32>;
    var param_649: i32;
    var param_650: u32;
    var param_651: u32;
    var param_652: u32;
    var param_653: u32;
    var param_654: vec3<i32>;
    var param_655: u32;
    var param_656: u32;
    var param_657: u32;
    var param_658: u32;
    var param_659: u32;
    var param_660: u32;
    var param_661: u32;
    var param_662: u32;
    var param_663: u32;
    var param_664: u32;
    var param_665: u32;
    var param_666: u32;
    var param_667: u32;
    var floraState: u32;
    var abovePos_1: vec3<i32>;
    var aboveInside: bool;
    var aboveIndex: u32;
    var param_668: vec3<i32>;
    var aboveType: u32;
    var local_22: u32;
    var param_669: u32;
    var param_670: u32;
    var param_671: u32;
    var param_672: u32;
    var param_673: u32;
    var param_674: u32;
    var param_675: u32;
    var newSleep_2: u32;
    var param_676: u32;
    var param_677: u32;
    var param_678: u32;
    var param_679: u32;
    var phi_3595_: bool;
    var phi_3601_: bool;
    var phi_3611_: bool;
    var phi_3617_: bool;
    var phi_3627_: bool;
    var phi_3693_: bool;
    var phi_3699_: bool;
    var phi_3709_: bool;
    var phi_3715_: bool;
    var phi_3725_: bool;
    var phi_3795_: bool;
    var phi_3837_: bool;
    var phi_3843_: bool;
    var phi_3852_: bool;
    var phi_3933_: bool;
    var phi_3939_: bool;
    var phi_3948_: bool;
    var phi_3954_: bool;
    var phi_3963_: bool;
    var phi_4082_: bool;
    var phi_4088_: bool;
    var phi_4098_: bool;
    var phi_4142_: bool;
    var phi_4148_: bool;
    var phi_4158_: bool;
    var phi_4249_: bool;
    var phi_4255_: bool;
    var phi_4265_: bool;
    var phi_4366_: bool;
    var phi_4372_: bool;
    var phi_4382_: bool;
    var phi_4439_: bool;
    var phi_4445_: bool;
    var phi_4455_: bool;
    var phi_4510_: bool;
    var phi_4584_: bool;
    var phi_4643_: bool;

    let _e385 = (*currentAge_7);
    moisture_4 = _e385;
    moistureModified = false;
    let _e386 = moisture_4;
    let _e388 = tuning.dirtMoistureCapacity;
    if (_e386 < _e388) {
        let _e390 = (*randVal_10);
        startDir_1 = i32((fract((_e390 * 17f)) * 6f));
        i_18 = 0i;
        loop {
            let _e395 = i_18;
            if (_e395 < 6i) {
                let _e397 = startDir_1;
                let _e398 = i_18;
                let _e399 = (_e397 + _e398);
                d_11 = (_e399 - (i32(floor((f32(_e399) / f32(6i)))) * 6i));
                let _e407 = (*pos_15);
                let _e408 = d_11;
                param_572 = _e408;
                let _e409 = getOrthoDir_u0028_i1_u003b((&param_572));
                nPos_4 = (_e407 + _e409);
                let _e412 = nPos_4[0u];
                let _e413 = (_e412 > 0i);
                phi_3595_ = _e413;
                if _e413 {
                    let _e415 = nPos_4[0u];
                    let _e417 = tuning.gridWidth;
                    phi_3595_ = (_e415 < (bitcast<i32>(_e417) - 1i));
                }
                let _e422 = phi_3595_;
                phi_3601_ = _e422;
                if _e422 {
                    let _e424 = nPos_4[1u];
                    phi_3601_ = (_e424 > 0i);
                }
                let _e427 = phi_3601_;
                phi_3611_ = _e427;
                if _e427 {
                    let _e429 = nPos_4[1u];
                    let _e431 = tuning.gridHeight;
                    phi_3611_ = (_e429 < (bitcast<i32>(_e431) - 1i));
                }
                let _e436 = phi_3611_;
                phi_3617_ = _e436;
                if _e436 {
                    let _e438 = nPos_4[2u];
                    phi_3617_ = (_e438 > 0i);
                }
                let _e441 = phi_3617_;
                phi_3627_ = _e441;
                if _e441 {
                    let _e443 = nPos_4[2u];
                    let _e445 = tuning.gridDepth;
                    phi_3627_ = (_e443 < (bitcast<i32>(_e445) - 1i));
                }
                let _e450 = phi_3627_;
                if _e450 {
                    let _e451 = nPos_4;
                    param_573 = _e451;
                    let _e452 = getIndex_u0028_vi3_u003b((&param_573));
                    nIndex_3 = _e452;
                    let _e453 = nIndex_3;
                    param_574 = _e453;
                    let _e454 = readCell_u0028_u1_u003b((&param_574));
                    nVal_3 = _e454;
                    let _e455 = nVal_3;
                    param_575 = _e455;
                    let _e456 = getType_u0028_u1_u003b((&param_575));
                    if (_e456 == 2u) {
                        let _e458 = nIndex_3;
                        let _e461 = nVal_3;
                        let _e462 = atomicCompareExchangeWeak((&unnamed.grid[_e458]), _e461, 0u);
                        let _e464 = nVal_3;
                        if (_e462.old_value == _e464) {
                            let _e466 = (*currentIndex_10);
                            let _e470 = tuning.sandWaterAbsorbUnit;
                            let _e473 = atomicAdd((&unnamed.grid[_e466]), (_e470 << bitcast<u32>(24i)));
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
                let _e474 = i_18;
                i_18 = (_e474 + 1i);
            }
        }
    }
    let _e476 = moistureModified;
    let _e478 = moisture_4;
    if (!(_e476) && (_e478 > 0u)) {
        let _e481 = (*randVal_10);
        d_12 = i32((fract((_e481 * 31f)) * 6f));
        let _e486 = (*pos_15);
        let _e487 = d_12;
        param_576 = _e487;
        let _e488 = getOrthoDir_u0028_i1_u003b((&param_576));
        nPos_5 = (_e486 + _e488);
        let _e491 = nPos_5[0u];
        let _e492 = (_e491 > 0i);
        phi_3693_ = _e492;
        if _e492 {
            let _e494 = nPos_5[0u];
            let _e496 = tuning.gridWidth;
            phi_3693_ = (_e494 < (bitcast<i32>(_e496) - 1i));
        }
        let _e501 = phi_3693_;
        phi_3699_ = _e501;
        if _e501 {
            let _e503 = nPos_5[1u];
            phi_3699_ = (_e503 > 0i);
        }
        let _e506 = phi_3699_;
        phi_3709_ = _e506;
        if _e506 {
            let _e508 = nPos_5[1u];
            let _e510 = tuning.gridHeight;
            phi_3709_ = (_e508 < (bitcast<i32>(_e510) - 1i));
        }
        let _e515 = phi_3709_;
        phi_3715_ = _e515;
        if _e515 {
            let _e517 = nPos_5[2u];
            phi_3715_ = (_e517 > 0i);
        }
        let _e520 = phi_3715_;
        phi_3725_ = _e520;
        if _e520 {
            let _e522 = nPos_5[2u];
            let _e524 = tuning.gridDepth;
            phi_3725_ = (_e522 < (bitcast<i32>(_e524) - 1i));
        }
        let _e529 = phi_3725_;
        if _e529 {
            let _e530 = nPos_5;
            param_577 = _e530;
            let _e531 = getIndex_u0028_vi3_u003b((&param_577));
            nIndex_4 = _e531;
            let _e532 = nIndex_4;
            param_578 = _e532;
            let _e533 = readCell_u0028_u1_u003b((&param_578));
            nVal_4 = _e533;
            let _e534 = nVal_4;
            param_579 = _e534;
            let _e535 = getType_u0028_u1_u003b((&param_579));
            nType_3 = _e535;
            let _e536 = nType_3;
            let _e538 = nType_3;
            if ((_e536 == 4u) || (_e538 == 1u)) {
                let _e541 = nVal_4;
                param_580 = _e541;
                let _e542 = getAge_u0028_u1_u003b((&param_580));
                nMoisture = _e542;
                let _e543 = nType_3;
                if (_e543 == 4u) {
                    let _e546 = tuning.dirtMoistureCapacity;
                    local_21 = _e546;
                } else {
                    let _e548 = tuning.sandMoistureCapacity;
                    local_21 = _e548;
                }
                let _e549 = local_21;
                nCapacity = _e549;
                let _e550 = moisture_4;
                let _e551 = nMoisture;
                let _e554 = nMoisture;
                let _e555 = nCapacity;
                if ((_e550 > (_e551 + 1u)) && (_e554 < _e555)) {
                    let _e558 = (*currentIndex_10);
                    let _e561 = atomicAdd((&unnamed.grid[_e558]), 4278190080u);
                    let _e562 = nIndex_4;
                    let _e565 = atomicAdd((&unnamed.grid[_e562]), 16777216u);
                    moistureModified = true;
                }
            }
        }
    }
    let _e566 = moistureModified;
    if _e566 {
        return;
    }
    let _e567 = (*pos_15);
    param_581 = _e567;
    let _e568 = grainCanMove_u0028_vi3_u003b((&param_581));
    canMove = _e568;
    isClumped = false;
    let _e569 = canMove;
    phi_3795_ = _e569;
    if _e569 {
        let _e570 = (*currentSleep_5);
        let _e572 = tuning.wakeSleepThreshold;
        phi_3795_ = (_e570 > _e572);
    }
    let _e575 = phi_3795_;
    if _e575 {
        emptyBelowCount = 0i;
        let _e577 = (*pos_15)[1u];
        if (_e577 > 1i) {
            x = -1i;
            loop {
                let _e579 = x;
                if (_e579 <= 1i) {
                    z = -1i;
                    loop {
                        let _e581 = z;
                        if (_e581 <= 1i) {
                            let _e583 = (*pos_15);
                            let _e584 = x;
                            let _e585 = z;
                            checkPos_1 = (_e583 + vec3<i32>(_e584, -1i, _e585));
                            let _e589 = checkPos_1[0u];
                            let _e590 = (_e589 >= 0i);
                            phi_3837_ = _e590;
                            if _e590 {
                                let _e592 = checkPos_1[0u];
                                let _e594 = tuning.gridWidth;
                                phi_3837_ = (_e592 < bitcast<i32>(_e594));
                            }
                            let _e598 = phi_3837_;
                            phi_3843_ = _e598;
                            if _e598 {
                                let _e600 = checkPos_1[2u];
                                phi_3843_ = (_e600 >= 0i);
                            }
                            let _e603 = phi_3843_;
                            phi_3852_ = _e603;
                            if _e603 {
                                let _e605 = checkPos_1[2u];
                                let _e607 = tuning.gridDepth;
                                phi_3852_ = (_e605 < bitcast<i32>(_e607));
                            }
                            let _e611 = phi_3852_;
                            if _e611 {
                                let _e612 = checkPos_1;
                                param_582 = _e612;
                                let _e613 = getIndex_u0028_vi3_u003b((&param_582));
                                param_583 = _e613;
                                let _e614 = readCell_u0028_u1_u003b((&param_583));
                                param_584 = _e614;
                                let _e615 = getType_u0028_u1_u003b((&param_584));
                                if (_e615 == 0u) {
                                    let _e617 = emptyBelowCount;
                                    emptyBelowCount = (_e617 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e619 = z;
                            z = (_e619 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e621 = x;
                    x = (_e621 + 1i);
                }
            }
        }
        let _e623 = emptyBelowCount;
        let _e625 = tuning.emptyBelowWakeCount;
        if (_e623 >= bitcast<i32>(_e625)) {
            (*currentSleep_5) = 0u;
        } else {
            clumpCount = 0i;
            x_1 = -1i;
            loop {
                let _e628 = x_1;
                if (_e628 <= 1i) {
                    y = -1i;
                    loop {
                        let _e630 = y;
                        if (_e630 <= 1i) {
                            z_1 = -1i;
                            loop {
                                let _e632 = z_1;
                                if (_e632 <= 1i) {
                                    let _e634 = x_1;
                                    let _e636 = y;
                                    let _e639 = z_1;
                                    if (((_e634 == 0i) && (_e636 == 0i)) && (_e639 == 0i)) {
                                        continue;
                                    }
                                    let _e642 = (*pos_15);
                                    let _e643 = x_1;
                                    let _e644 = y;
                                    let _e645 = z_1;
                                    nPos_6 = (_e642 + vec3<i32>(_e643, _e644, _e645));
                                    let _e649 = nPos_6[0u];
                                    let _e650 = (_e649 >= 0i);
                                    phi_3933_ = _e650;
                                    if _e650 {
                                        let _e652 = nPos_6[0u];
                                        let _e654 = tuning.gridWidth;
                                        phi_3933_ = (_e652 < bitcast<i32>(_e654));
                                    }
                                    let _e658 = phi_3933_;
                                    phi_3939_ = _e658;
                                    if _e658 {
                                        let _e660 = nPos_6[1u];
                                        phi_3939_ = (_e660 >= 0i);
                                    }
                                    let _e663 = phi_3939_;
                                    phi_3948_ = _e663;
                                    if _e663 {
                                        let _e665 = nPos_6[1u];
                                        let _e667 = tuning.gridHeight;
                                        phi_3948_ = (_e665 < bitcast<i32>(_e667));
                                    }
                                    let _e671 = phi_3948_;
                                    phi_3954_ = _e671;
                                    if _e671 {
                                        let _e673 = nPos_6[2u];
                                        phi_3954_ = (_e673 >= 0i);
                                    }
                                    let _e676 = phi_3954_;
                                    phi_3963_ = _e676;
                                    if _e676 {
                                        let _e678 = nPos_6[2u];
                                        let _e680 = tuning.gridDepth;
                                        phi_3963_ = (_e678 < bitcast<i32>(_e680));
                                    }
                                    let _e684 = phi_3963_;
                                    if _e684 {
                                        let _e685 = nPos_6;
                                        param_585 = _e685;
                                        let _e686 = getIndex_u0028_vi3_u003b((&param_585));
                                        param_586 = _e686;
                                        let _e687 = readCell_u0028_u1_u003b((&param_586));
                                        param_587 = _e687;
                                        let _e688 = getType_u0028_u1_u003b((&param_587));
                                        if (_e688 == 4u) {
                                            let _e690 = clumpCount;
                                            clumpCount = (_e690 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e692 = z_1;
                                    z_1 = (_e692 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e694 = y;
                            y = (_e694 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e696 = x_1;
                    x_1 = (_e696 + 1i);
                }
            }
            let _e698 = clumpCount;
            let _e700 = tuning.dirtClumpThreshold;
            if (_e698 >= bitcast<i32>(_e700)) {
                isClumped = true;
            }
        }
    }
    let _e703 = canMove;
    let _e704 = isClumped;
    if (_e703 && !(_e704)) {
        let _e708 = (*pos_15)[1u];
        if (_e708 > 1i) {
            let _e710 = (*pos_15);
            belowPos_6 = (_e710 + vec3<i32>(0i, -1i, 0i));
            let _e712 = belowPos_6;
            param_588 = _e712;
            let _e713 = getIndex_u0028_vi3_u003b((&param_588));
            param_589 = _e713;
            let _e714 = readCell_u0028_u1_u003b((&param_589));
            param_590 = _e714;
            let _e715 = getType_u0028_u1_u003b((&param_590));
            if (_e715 == 0u) {
                let _e717 = belowPos_6;
                param_591 = _e717;
                let _e718 = getIndex_u0028_vi3_u003b((&param_591));
                param_592 = 4u;
                param_593 = 0u;
                param_594 = 0u;
                let _e719 = moisture_4;
                param_595 = _e719;
                let _e720 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_592), (&param_593), (&param_594), (&param_595));
                let _e721 = (*currentIndex_10);
                param_596 = _e721;
                let _e722 = (*rawValue_8);
                param_597 = _e722;
                param_598 = _e718;
                param_599 = _e720;
                let _e723 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_596), (&param_597), (&param_598), (&param_599));
                if _e723 {
                    return;
                }
            }
        }
        let _e725 = (*pos_15)[1u];
        if (_e725 > 1i) {
            let _e727 = (*randVal_10);
            dir_3 = select(-1i, 1i, (fract((_e727 * 10f)) > 0.5f));
            let _e732 = (*randVal_10);
            if (fract((_e732 * 100f)) > 0.5f) {
                let _e736 = (*pos_15);
                let _e737 = dir_3;
                slidePos1_ = (_e736 + vec3<i32>(_e737, -1i, 0i));
                let _e740 = (*pos_15);
                let _e741 = dir_3;
                slidePos2_ = (_e740 + vec3<i32>(0i, -1i, _e741));
            } else {
                let _e744 = (*pos_15);
                let _e745 = dir_3;
                slidePos1_ = (_e744 + vec3<i32>(0i, -1i, _e745));
                let _e748 = (*pos_15);
                let _e749 = dir_3;
                slidePos2_ = (_e748 + vec3<i32>(_e749, -1i, 0i));
            }
            let _e753 = slidePos1_[0u];
            let _e754 = (_e753 > 0i);
            phi_4082_ = _e754;
            if _e754 {
                let _e756 = slidePos1_[0u];
                let _e758 = tuning.gridWidth;
                phi_4082_ = (_e756 < (bitcast<i32>(_e758) - 1i));
            }
            let _e763 = phi_4082_;
            phi_4088_ = _e763;
            if _e763 {
                let _e765 = slidePos1_[2u];
                phi_4088_ = (_e765 > 0i);
            }
            let _e768 = phi_4088_;
            phi_4098_ = _e768;
            if _e768 {
                let _e770 = slidePos1_[2u];
                let _e772 = tuning.gridDepth;
                phi_4098_ = (_e770 < (bitcast<i32>(_e772) - 1i));
            }
            let _e777 = phi_4098_;
            if _e777 {
                let _e778 = slidePos1_;
                param_600 = _e778;
                let _e779 = getIndex_u0028_vi3_u003b((&param_600));
                param_601 = _e779;
                let _e780 = readCell_u0028_u1_u003b((&param_601));
                param_602 = _e780;
                let _e781 = getType_u0028_u1_u003b((&param_602));
                if (_e781 == 0u) {
                    let _e783 = slidePos1_;
                    param_603 = _e783;
                    let _e784 = getIndex_u0028_vi3_u003b((&param_603));
                    param_604 = 4u;
                    param_605 = 0u;
                    param_606 = 0u;
                    let _e785 = moisture_4;
                    param_607 = _e785;
                    let _e786 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_604), (&param_605), (&param_606), (&param_607));
                    let _e787 = (*currentIndex_10);
                    param_608 = _e787;
                    let _e788 = (*rawValue_8);
                    param_609 = _e788;
                    param_610 = _e784;
                    param_611 = _e786;
                    let _e789 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_608), (&param_609), (&param_610), (&param_611));
                    if _e789 {
                        return;
                    }
                }
            }
            let _e791 = slidePos2_[0u];
            let _e792 = (_e791 > 0i);
            phi_4142_ = _e792;
            if _e792 {
                let _e794 = slidePos2_[0u];
                let _e796 = tuning.gridWidth;
                phi_4142_ = (_e794 < (bitcast<i32>(_e796) - 1i));
            }
            let _e801 = phi_4142_;
            phi_4148_ = _e801;
            if _e801 {
                let _e803 = slidePos2_[2u];
                phi_4148_ = (_e803 > 0i);
            }
            let _e806 = phi_4148_;
            phi_4158_ = _e806;
            if _e806 {
                let _e808 = slidePos2_[2u];
                let _e810 = tuning.gridDepth;
                phi_4158_ = (_e808 < (bitcast<i32>(_e810) - 1i));
            }
            let _e815 = phi_4158_;
            if _e815 {
                let _e816 = slidePos2_;
                param_612 = _e816;
                let _e817 = getIndex_u0028_vi3_u003b((&param_612));
                param_613 = _e817;
                let _e818 = readCell_u0028_u1_u003b((&param_613));
                param_614 = _e818;
                let _e819 = getType_u0028_u1_u003b((&param_614));
                if (_e819 == 0u) {
                    let _e821 = slidePos2_;
                    param_615 = _e821;
                    let _e822 = getIndex_u0028_vi3_u003b((&param_615));
                    param_616 = 4u;
                    param_617 = 0u;
                    param_618 = 0u;
                    let _e823 = moisture_4;
                    param_619 = _e823;
                    let _e824 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_616), (&param_617), (&param_618), (&param_619));
                    let _e825 = (*currentIndex_10);
                    param_620 = _e825;
                    let _e826 = (*rawValue_8);
                    param_621 = _e826;
                    param_622 = _e822;
                    param_623 = _e824;
                    let _e827 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_620), (&param_621), (&param_622), (&param_623));
                    if _e827 {
                        return;
                    }
                }
            }
        }
        let _e829 = (*pos_15)[1u];
        if (_e829 > 1i) {
            let _e831 = (*pos_15);
            belowPos_7 = (_e831 + vec3<i32>(0i, -1i, 0i));
            let _e833 = belowPos_7;
            param_624 = _e833;
            let _e834 = getIndex_u0028_vi3_u003b((&param_624));
            belowIndex_3 = _e834;
            let _e835 = belowIndex_3;
            param_625 = _e835;
            let _e836 = readCell_u0028_u1_u003b((&param_625));
            belowValue_3 = _e836;
            let _e837 = belowValue_3;
            param_626 = _e837;
            let _e838 = getType_u0028_u1_u003b((&param_626));
            if (_e838 == 2u) {
                let _e840 = (*randVal_10);
                startDir_2 = i32((fract((_e840 * 8f)) * 8f));
                i_19 = 0i;
                loop {
                    let _e845 = i_19;
                    if (_e845 < 8i) {
                        let _e847 = startDir_2;
                        let _e848 = i_19;
                        let _e849 = (_e847 + _e848);
                        d_13 = (_e849 - (i32(floor((f32(_e849) / f32(8i)))) * 8i));
                        let _e857 = belowPos_7;
                        let _e858 = d_13;
                        param_627 = _e858;
                        let _e859 = getHDir_u0028_i1_u003b((&param_627));
                        pushPos = (_e857 + _e859);
                        let _e862 = pushPos[0u];
                        let _e863 = (_e862 > 0i);
                        phi_4249_ = _e863;
                        if _e863 {
                            let _e865 = pushPos[0u];
                            let _e867 = tuning.gridWidth;
                            phi_4249_ = (_e865 < (bitcast<i32>(_e867) - 1i));
                        }
                        let _e872 = phi_4249_;
                        phi_4255_ = _e872;
                        if _e872 {
                            let _e874 = pushPos[2u];
                            phi_4255_ = (_e874 > 0i);
                        }
                        let _e877 = phi_4255_;
                        phi_4265_ = _e877;
                        if _e877 {
                            let _e879 = pushPos[2u];
                            let _e881 = tuning.gridDepth;
                            phi_4265_ = (_e879 < (bitcast<i32>(_e881) - 1i));
                        }
                        let _e886 = phi_4265_;
                        if _e886 {
                            param_628 = 4u;
                            param_629 = 0u;
                            param_630 = 0u;
                            let _e887 = moisture_4;
                            param_631 = _e887;
                            let _e888 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_628), (&param_629), (&param_630), (&param_631));
                            let _e889 = pushPos;
                            param_632 = _e889;
                            let _e890 = getIndex_u0028_vi3_u003b((&param_632));
                            let _e891 = (*currentIndex_10);
                            param_633 = _e891;
                            param_634 = _e888;
                            let _e892 = belowIndex_3;
                            param_635 = _e892;
                            let _e893 = belowValue_3;
                            param_636 = _e893;
                            param_637 = _e890;
                            let _e894 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_633), (&param_634), (&param_635), (&param_636), (&param_637));
                            if _e894 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e895 = i_19;
                        i_19 = (_e895 + 1i);
                    }
                }
                param_638 = 4u;
                param_639 = 0u;
                param_640 = 0u;
                let _e897 = moisture_4;
                param_641 = _e897;
                let _e898 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_638), (&param_639), (&param_640), (&param_641));
                let _e899 = (*currentIndex_10);
                param_642 = _e899;
                let _e900 = (*rawValue_8);
                param_643 = _e900;
                let _e901 = belowIndex_3;
                param_644 = _e901;
                param_645 = _e898;
                let _e902 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_642), (&param_643), (&param_644), (&param_645));
                if _e902 {
                    return;
                }
            }
            let _e903 = (*randVal_10);
            dir_4 = select(-1i, 1i, (fract((_e903 * 10f)) > 0.5f));
            let _e908 = (*randVal_10);
            if (fract((_e908 * 100f)) > 0.5f) {
                let _e912 = (*pos_15);
                let _e913 = dir_4;
                slidePos[0i] = (_e912 + vec3<i32>(_e913, -1i, 0i));
                let _e917 = (*pos_15);
                let _e918 = dir_4;
                slidePos[1i] = (_e917 + vec3<i32>(0i, -1i, _e918));
            } else {
                let _e922 = (*pos_15);
                let _e923 = dir_4;
                slidePos[0i] = (_e922 + vec3<i32>(0i, -1i, _e923));
                let _e927 = (*pos_15);
                let _e928 = dir_4;
                slidePos[1i] = (_e927 + vec3<i32>(_e928, -1i, 0i));
            }
            s_2 = 0i;
            loop {
                let _e932 = s_2;
                if (_e932 < 2i) {
                    let _e934 = s_2;
                    let _e936 = slidePos[_e934];
                    sPos_2 = _e936;
                    let _e938 = sPos_2[0u];
                    let _e939 = (_e938 > 0i);
                    phi_4366_ = _e939;
                    if _e939 {
                        let _e941 = sPos_2[0u];
                        let _e943 = tuning.gridWidth;
                        phi_4366_ = (_e941 < (bitcast<i32>(_e943) - 1i));
                    }
                    let _e948 = phi_4366_;
                    phi_4372_ = _e948;
                    if _e948 {
                        let _e950 = sPos_2[2u];
                        phi_4372_ = (_e950 > 0i);
                    }
                    let _e953 = phi_4372_;
                    phi_4382_ = _e953;
                    if _e953 {
                        let _e955 = sPos_2[2u];
                        let _e957 = tuning.gridDepth;
                        phi_4382_ = (_e955 < (bitcast<i32>(_e957) - 1i));
                    }
                    let _e962 = phi_4382_;
                    if _e962 {
                        let _e963 = sPos_2;
                        param_646 = _e963;
                        let _e964 = getIndex_u0028_vi3_u003b((&param_646));
                        sIndex = _e964;
                        let _e965 = sIndex;
                        param_647 = _e965;
                        let _e966 = readCell_u0028_u1_u003b((&param_647));
                        sValue = _e966;
                        let _e967 = sValue;
                        param_648 = _e967;
                        let _e968 = getType_u0028_u1_u003b((&param_648));
                        if (_e968 == 2u) {
                            let _e970 = (*randVal_10);
                            let _e972 = s_2;
                            startDir_3 = i32((fract(((_e970 * 8f) + f32(_e972))) * 8f));
                            i_20 = 0i;
                            loop {
                                let _e978 = i_20;
                                if (_e978 < 8i) {
                                    let _e980 = startDir_3;
                                    let _e981 = i_20;
                                    let _e982 = (_e980 + _e981);
                                    d_14 = (_e982 - (i32(floor((f32(_e982) / f32(8i)))) * 8i));
                                    let _e990 = sPos_2;
                                    let _e991 = d_14;
                                    param_649 = _e991;
                                    let _e992 = getHDir_u0028_i1_u003b((&param_649));
                                    pushPos_1 = (_e990 + _e992);
                                    let _e995 = pushPos_1[0u];
                                    let _e996 = (_e995 > 0i);
                                    phi_4439_ = _e996;
                                    if _e996 {
                                        let _e998 = pushPos_1[0u];
                                        let _e1000 = tuning.gridWidth;
                                        phi_4439_ = (_e998 < (bitcast<i32>(_e1000) - 1i));
                                    }
                                    let _e1005 = phi_4439_;
                                    phi_4445_ = _e1005;
                                    if _e1005 {
                                        let _e1007 = pushPos_1[2u];
                                        phi_4445_ = (_e1007 > 0i);
                                    }
                                    let _e1010 = phi_4445_;
                                    phi_4455_ = _e1010;
                                    if _e1010 {
                                        let _e1012 = pushPos_1[2u];
                                        let _e1014 = tuning.gridDepth;
                                        phi_4455_ = (_e1012 < (bitcast<i32>(_e1014) - 1i));
                                    }
                                    let _e1019 = phi_4455_;
                                    if _e1019 {
                                        param_650 = 4u;
                                        param_651 = 0u;
                                        param_652 = 0u;
                                        let _e1020 = moisture_4;
                                        param_653 = _e1020;
                                        let _e1021 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_650), (&param_651), (&param_652), (&param_653));
                                        let _e1022 = pushPos_1;
                                        param_654 = _e1022;
                                        let _e1023 = getIndex_u0028_vi3_u003b((&param_654));
                                        let _e1024 = (*currentIndex_10);
                                        param_655 = _e1024;
                                        param_656 = _e1021;
                                        let _e1025 = sIndex;
                                        param_657 = _e1025;
                                        let _e1026 = sValue;
                                        param_658 = _e1026;
                                        param_659 = _e1023;
                                        let _e1027 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_655), (&param_656), (&param_657), (&param_658), (&param_659));
                                        if _e1027 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1028 = i_20;
                                    i_20 = (_e1028 + 1i);
                                }
                            }
                            param_660 = 4u;
                            param_661 = 0u;
                            param_662 = 0u;
                            let _e1030 = moisture_4;
                            param_663 = _e1030;
                            let _e1031 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_660), (&param_661), (&param_662), (&param_663));
                            let _e1032 = (*currentIndex_10);
                            param_664 = _e1032;
                            let _e1033 = (*rawValue_8);
                            param_665 = _e1033;
                            let _e1034 = sIndex;
                            param_666 = _e1034;
                            param_667 = _e1031;
                            let _e1035 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_664), (&param_665), (&param_666), (&param_667));
                            if _e1035 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1036 = s_2;
                    s_2 = (_e1036 + 1i);
                }
            }
        }
    }
    let _e1038 = (*currentDir_4);
    floraState = _e1038;
    let _e1039 = isClumped;
    phi_4510_ = _e1039;
    if !(_e1039) {
        let _e1041 = (*currentSleep_5);
        let _e1043 = tuning.wakeSleepThreshold;
        phi_4510_ = (_e1041 > _e1043);
    }
    let _e1046 = phi_4510_;
    if _e1046 {
        let _e1047 = (*pos_15);
        abovePos_1 = (_e1047 + vec3<i32>(0i, 1i, 0i));
        let _e1050 = abovePos_1[1u];
        let _e1052 = tuning.gridHeight;
        aboveInside = (_e1050 < (bitcast<i32>(_e1052) - 1i));
        let _e1056 = abovePos_1;
        param_668 = _e1056;
        let _e1057 = getIndex_u0028_vi3_u003b((&param_668));
        aboveIndex = _e1057;
        let _e1058 = aboveInside;
        if _e1058 {
            let _e1059 = aboveIndex;
            param_669 = _e1059;
            let _e1060 = readCell_u0028_u1_u003b((&param_669));
            param_670 = _e1060;
            let _e1061 = getType_u0028_u1_u003b((&param_670));
            local_22 = _e1061;
        } else {
            local_22 = 0u;
        }
        let _e1062 = local_22;
        aboveType = _e1062;
        let _e1063 = aboveType;
        let _e1065 = aboveType;
        if ((_e1063 == 0u) || (_e1065 == 18u)) {
            let _e1068 = moisture_4;
            let _e1070 = floraState;
            if ((_e1068 >= 5u) && (_e1070 < 100u)) {
                let _e1073 = (*randVal_10);
                let _e1077 = tuning.grassGrowChance;
                if (fract((_e1073 * 55f)) < _e1077) {
                    let _e1079 = floraState;
                    floraState = (_e1079 + bitcast<u32>(1i));
                    let _e1082 = floraState;
                    let _e1084 = aboveType;
                    let _e1087 = aboveInside;
                    let _e1088 = (((_e1082 == 100u) && (_e1084 == 0u)) && _e1087);
                    phi_4584_ = _e1088;
                    if _e1088 {
                        let _e1089 = (*randVal_10);
                        let _e1093 = tuning.treeBloomChance;
                        phi_4584_ = (fract((_e1089 * 97f)) < _e1093);
                    }
                    let _e1096 = phi_4584_;
                    if _e1096 {
                        let _e1097 = aboveIndex;
                        param_671 = 18u;
                        param_672 = 0u;
                        param_673 = 0u;
                        param_674 = 0u;
                        let _e1100 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_671), (&param_672), (&param_673), (&param_674));
                        let _e1101 = atomicCompareExchangeWeak((&unnamed.grid[_e1097]), 0u, _e1100);
                    }
                }
            }
            let _e1103 = floraState;
            if (_e1103 > 100u) {
                floraState = 100u;
            }
        } else {
            let _e1105 = aboveType;
            if (_e1105 == 2u) {
                let _e1107 = floraState;
                if (_e1107 > 0u) {
                    let _e1109 = floraState;
                    if (_e1109 <= 100u) {
                        floraState = 101u;
                    }
                    let _e1111 = (*randVal_10);
                    let _e1115 = tuning.grassSubmergedDecayChance;
                    if (fract((_e1111 * 66f)) < _e1115) {
                        let _e1117 = floraState;
                        floraState = (_e1117 + bitcast<u32>(1i));
                    }
                    let _e1120 = floraState;
                    if (_e1120 >= 200u) {
                        floraState = 0u;
                    }
                }
            } else {
                let _e1122 = aboveType;
                let _e1124 = aboveType;
                let _e1126 = ((_e1122 != 5u) && (_e1124 != 20u));
                phi_4643_ = _e1126;
                if _e1126 {
                    let _e1127 = aboveType;
                    param_675 = _e1127;
                    let _e1128 = isLocust_u0028_u1_u003b((&param_675));
                    phi_4643_ = !(_e1128);
                }
                let _e1131 = phi_4643_;
                if _e1131 {
                    floraState = 0u;
                }
            }
        }
    }
    let _e1132 = (*currentSleep_5);
    newSleep_2 = min((_e1132 + 1u), 255u);
    let _e1135 = (*currentIndex_10);
    let _e1138 = (*rawValue_8);
    param_676 = 4u;
    let _e1139 = floraState;
    param_677 = _e1139;
    let _e1140 = newSleep_2;
    param_678 = _e1140;
    let _e1141 = moisture_4;
    param_679 = _e1141;
    let _e1142 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_676), (&param_677), (&param_678), (&param_679));
    let _e1143 = atomicCompareExchangeWeak((&unnamed.grid[_e1135]), _e1138, _e1142);
    return;
}

fn updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_16: ptr<function, vec3<i32>>, currentIndex_11: ptr<function, u32>, rawValue_9: ptr<function, u32>, currentDir_5: ptr<function, u32>, currentSleep_6: ptr<function, u32>, currentAge_8: ptr<function, u32>, randVal_11: ptr<function, f32>) {
    var wake: bool;
    var param_680: vec3<i32>;
    var param_681: u32;
    var param_682: u32;
    var hasPressure_1: bool;
    var local_23: bool;
    var param_683: vec3<i32>;
    var param_684: u32;
    var param_685: u32;
    var isStackedOnWater: bool;
    var local_24: bool;
    var param_686: vec3<i32>;
    var param_687: u32;
    var param_688: u32;
    var d_15: i32;
    var nPos_7: vec3<i32>;
    var param_689: i32;
    var param_690: vec3<i32>;
    var param_691: u32;
    var param_692: u32;
    var belowNeighbor: u32;
    var param_693: vec3<i32>;
    var param_694: u32;
    var param_695: u32;
    var newAge_2: u32;
    var belowPos_8: vec3<i32>;
    var param_696: vec3<i32>;
    var param_697: u32;
    var param_698: u32;
    var param_699: vec3<i32>;
    var param_700: u32;
    var param_701: u32;
    var param_702: u32;
    var param_703: u32;
    var param_704: u32;
    var param_705: u32;
    var param_706: u32;
    var param_707: u32;
    var newDir: u32;
    var r_1: f32;
    var diagDir: u32;
    var r_2: f32;
    var stepPos: vec3<i32>;
    var param_708: i32;
    var param_709: vec3<i32>;
    var param_710: u32;
    var param_711: u32;
    var newValue_1: u32;
    var param_712: u32;
    var param_713: u32;
    var param_714: u32;
    var param_715: u32;
    var param_716: vec3<i32>;
    var param_717: u32;
    var param_718: u32;
    var param_719: u32;
    var param_720: u32;
    var bestDropPos: vec3<i32>;
    var foundDrop: bool;
    var blockedMask_1: u32;
    var startDir_4: i32;
    var waterReach: i32;
    var r_3: i32;
    var i_21: i32;
    var d_16: i32;
    var c_7: vec3<i32>;
    var param_721: i32;
    var param_722: vec3<i32>;
    var param_723: u32;
    var param_724: u32;
    var param_725: vec3<i32>;
    var param_726: u32;
    var param_727: u32;
    var newValue_2: u32;
    var param_728: u32;
    var param_729: u32;
    var param_730: u32;
    var param_731: u32;
    var param_732: vec3<i32>;
    var param_733: u32;
    var param_734: u32;
    var param_735: u32;
    var param_736: u32;
    var hasPressure_2: bool;
    var local_25: bool;
    var param_737: vec3<i32>;
    var param_738: u32;
    var param_739: u32;
    var isStackedOnWater_1: bool;
    var local_26: bool;
    var param_740: vec3<i32>;
    var param_741: u32;
    var param_742: u32;
    var canStepOntoPool: bool;
    var d_17: i32;
    var nPos_8: vec3<i32>;
    var param_743: i32;
    var param_744: vec3<i32>;
    var param_745: u32;
    var param_746: u32;
    var param_747: vec3<i32>;
    var param_748: u32;
    var param_749: u32;
    var startSpreadDir: i32;
    var i_22: i32;
    var d_18: i32;
    var targetPos_2: vec3<i32>;
    var param_750: i32;
    var param_751: vec3<i32>;
    var param_752: u32;
    var param_753: u32;
    var newValue_3: u32;
    var param_754: u32;
    var param_755: u32;
    var param_756: u32;
    var param_757: u32;
    var param_758: vec3<i32>;
    var param_759: u32;
    var param_760: u32;
    var param_761: u32;
    var param_762: u32;
    var newSleep_3: u32;
    var sleepValue: u32;
    var param_763: u32;
    var param_764: u32;
    var param_765: u32;
    var param_766: u32;
    var phi_4683_: bool;
    var phi_4753_: bool;
    var phi_4759_: bool;
    var phi_4769_: bool;
    var phi_4955_: bool;
    var phi_4961_: bool;
    var phi_4971_: bool;
    var phi_5086_: bool;
    var phi_5093_: bool;
    var phi_5104_: bool;
    var phi_5116_: bool;
    var phi_5138_: bool;
    var phi_5242_: bool;
    var phi_5248_: bool;
    var phi_5258_: bool;
    var phi_5274_: bool;
    var phi_5286_: bool;
    var phi_5336_: bool;
    var phi_5342_: bool;
    var phi_5352_: bool;

    let _e349 = (*currentSleep_6);
    let _e351 = tuning.wakeSleepThreshold;
    if (_e349 > _e351) {
        wake = false;
        let _e354 = (*pos_16)[1u];
        let _e355 = (_e354 > 1i);
        phi_4683_ = _e355;
        if _e355 {
            let _e356 = (*pos_16);
            param_680 = (_e356 + vec3<i32>(0i, -1i, 0i));
            let _e358 = getIndex_u0028_vi3_u003b((&param_680));
            param_681 = _e358;
            let _e359 = readCell_u0028_u1_u003b((&param_681));
            param_682 = _e359;
            let _e360 = getType_u0028_u1_u003b((&param_682));
            phi_4683_ = (_e360 == 0u);
        }
        let _e363 = phi_4683_;
        if _e363 {
            wake = true;
        } else {
            let _e365 = (*pos_16)[1u];
            let _e367 = tuning.gridHeight;
            if (_e365 < (bitcast<i32>(_e367) - 2i)) {
                let _e371 = (*pos_16);
                param_683 = (_e371 + vec3<i32>(0i, 1i, 0i));
                let _e373 = getIndex_u0028_vi3_u003b((&param_683));
                param_684 = _e373;
                let _e374 = readCell_u0028_u1_u003b((&param_684));
                param_685 = _e374;
                let _e375 = getType_u0028_u1_u003b((&param_685));
                local_23 = (_e375 != 0u);
            } else {
                local_23 = false;
            }
            let _e377 = local_23;
            hasPressure_1 = _e377;
            let _e379 = (*pos_16)[1u];
            if (_e379 > 1i) {
                let _e381 = (*pos_16);
                param_686 = (_e381 + vec3<i32>(0i, -1i, 0i));
                let _e383 = getIndex_u0028_vi3_u003b((&param_686));
                param_687 = _e383;
                let _e384 = readCell_u0028_u1_u003b((&param_687));
                param_688 = _e384;
                let _e385 = getType_u0028_u1_u003b((&param_688));
                local_24 = (_e385 == 2u);
            } else {
                local_24 = false;
            }
            let _e387 = local_24;
            isStackedOnWater = _e387;
            d_15 = 0i;
            loop {
                let _e388 = d_15;
                if (_e388 < 8i) {
                    let _e390 = (*pos_16);
                    let _e391 = d_15;
                    param_689 = _e391;
                    let _e392 = getHDir_u0028_i1_u003b((&param_689));
                    nPos_7 = (_e390 + _e392);
                    let _e395 = nPos_7[0u];
                    let _e396 = (_e395 > 0i);
                    phi_4753_ = _e396;
                    if _e396 {
                        let _e398 = nPos_7[0u];
                        let _e400 = tuning.gridWidth;
                        phi_4753_ = (_e398 < (bitcast<i32>(_e400) - 1i));
                    }
                    let _e405 = phi_4753_;
                    phi_4759_ = _e405;
                    if _e405 {
                        let _e407 = nPos_7[2u];
                        phi_4759_ = (_e407 > 0i);
                    }
                    let _e410 = phi_4759_;
                    phi_4769_ = _e410;
                    if _e410 {
                        let _e412 = nPos_7[2u];
                        let _e414 = tuning.gridDepth;
                        phi_4769_ = (_e412 < (bitcast<i32>(_e414) - 1i));
                    }
                    let _e419 = phi_4769_;
                    if _e419 {
                        let _e420 = nPos_7;
                        param_690 = _e420;
                        let _e421 = getIndex_u0028_vi3_u003b((&param_690));
                        param_691 = _e421;
                        let _e422 = readCell_u0028_u1_u003b((&param_691));
                        param_692 = _e422;
                        let _e423 = getType_u0028_u1_u003b((&param_692));
                        if (_e423 == 0u) {
                            let _e425 = nPos_7;
                            param_693 = (_e425 + vec3<i32>(0i, -1i, 0i));
                            let _e427 = getIndex_u0028_vi3_u003b((&param_693));
                            param_694 = _e427;
                            let _e428 = readCell_u0028_u1_u003b((&param_694));
                            param_695 = _e428;
                            let _e429 = getType_u0028_u1_u003b((&param_695));
                            belowNeighbor = _e429;
                            let _e430 = belowNeighbor;
                            let _e432 = hasPressure_1;
                            let _e434 = isStackedOnWater;
                            let _e436 = belowNeighbor;
                            if ((((_e430 == 0u) || _e432) || _e434) || (_e436 == 2u)) {
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
                    let _e439 = d_15;
                    d_15 = (_e439 + 1i);
                }
            }
        }
        let _e441 = wake;
        if !(_e441) {
            return;
        }
        (*currentSleep_6) = 0u;
        (*currentAge_8) = 0u;
    }
    let _e443 = (*currentAge_8);
    newAge_2 = (_e443 + 1u);
    let _e446 = (*pos_16)[1u];
    if (_e446 > 1i) {
        let _e448 = (*pos_16);
        belowPos_8 = (_e448 + vec3<i32>(0i, -1i, 0i));
        let _e450 = belowPos_8;
        param_696 = _e450;
        let _e451 = getIndex_u0028_vi3_u003b((&param_696));
        param_697 = _e451;
        let _e452 = readCell_u0028_u1_u003b((&param_697));
        param_698 = _e452;
        let _e453 = getType_u0028_u1_u003b((&param_698));
        if (_e453 == 0u) {
            let _e455 = belowPos_8;
            param_699 = _e455;
            let _e456 = getIndex_u0028_vi3_u003b((&param_699));
            param_700 = 2u;
            param_701 = 0u;
            param_702 = 0u;
            let _e457 = newAge_2;
            param_703 = _e457;
            let _e458 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_700), (&param_701), (&param_702), (&param_703));
            let _e459 = (*currentIndex_11);
            param_704 = _e459;
            let _e460 = (*rawValue_9);
            param_705 = _e460;
            param_706 = _e456;
            param_707 = _e458;
            let _e461 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_704), (&param_705), (&param_706), (&param_707));
            if _e461 {
                return;
            }
        }
    }
    let _e462 = (*currentDir_5);
    newDir = _e462;
    let _e463 = newDir;
    let _e465 = newDir;
    if ((_e463 == 0u) || (_e465 == 9u)) {
        let _e468 = (*randVal_11);
        r_1 = fract((_e468 * 77f));
        let _e471 = r_1;
        if (_e471 < 0.25f) {
            newDir = 1u;
        } else {
            let _e473 = r_1;
            if (_e473 < 0.5f) {
                newDir = 2u;
            } else {
                let _e475 = r_1;
                if (_e475 < 0.75f) {
                    newDir = 3u;
                } else {
                    newDir = 4u;
                }
            }
        }
    }
    let _e477 = newAge_2;
    let _e480 = newAge_2;
    if (((_e477 % 3u) == 0u) && (_e480 > 0u)) {
        let _e483 = newDir;
        diagDir = _e483;
        let _e484 = diagDir;
        let _e486 = diagDir;
        if ((_e484 >= 1u) && (_e486 <= 4u)) {
            let _e489 = (*randVal_11);
            r_2 = fract((_e489 * 133f));
            let _e492 = diagDir;
            if (_e492 == 1u) {
                let _e494 = r_2;
                diagDir = select(6u, 5u, (_e494 > 0.5f));
            } else {
                let _e497 = diagDir;
                if (_e497 == 2u) {
                    let _e499 = r_2;
                    diagDir = select(8u, 7u, (_e499 > 0.5f));
                } else {
                    let _e502 = diagDir;
                    if (_e502 == 3u) {
                        let _e504 = r_2;
                        diagDir = select(7u, 5u, (_e504 > 0.5f));
                    } else {
                        let _e507 = diagDir;
                        if (_e507 == 4u) {
                            let _e509 = r_2;
                            diagDir = select(8u, 6u, (_e509 > 0.5f));
                        }
                    }
                }
            }
        }
        let _e512 = (*pos_16);
        let _e513 = diagDir;
        param_708 = (bitcast<i32>(_e513) - 1i);
        let _e516 = getHDir_u0028_i1_u003b((&param_708));
        stepPos = (_e512 + _e516);
        let _e519 = stepPos[0u];
        let _e520 = (_e519 > 0i);
        phi_4955_ = _e520;
        if _e520 {
            let _e522 = stepPos[0u];
            let _e524 = tuning.gridWidth;
            phi_4955_ = (_e522 < (bitcast<i32>(_e524) - 1i));
        }
        let _e529 = phi_4955_;
        phi_4961_ = _e529;
        if _e529 {
            let _e531 = stepPos[2u];
            phi_4961_ = (_e531 > 0i);
        }
        let _e534 = phi_4961_;
        phi_4971_ = _e534;
        if _e534 {
            let _e536 = stepPos[2u];
            let _e538 = tuning.gridDepth;
            phi_4971_ = (_e536 < (bitcast<i32>(_e538) - 1i));
        }
        let _e543 = phi_4971_;
        if _e543 {
            let _e544 = stepPos;
            param_709 = _e544;
            let _e545 = getIndex_u0028_vi3_u003b((&param_709));
            param_710 = _e545;
            let _e546 = readCell_u0028_u1_u003b((&param_710));
            param_711 = _e546;
            let _e547 = getType_u0028_u1_u003b((&param_711));
            if (_e547 == 0u) {
                param_712 = 2u;
                let _e549 = newDir;
                param_713 = _e549;
                param_714 = 0u;
                let _e550 = newAge_2;
                param_715 = _e550;
                let _e551 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_712), (&param_713), (&param_714), (&param_715));
                newValue_1 = _e551;
                let _e552 = stepPos;
                param_716 = _e552;
                let _e553 = getIndex_u0028_vi3_u003b((&param_716));
                let _e554 = (*currentIndex_11);
                param_717 = _e554;
                let _e555 = (*rawValue_9);
                param_718 = _e555;
                param_719 = _e553;
                let _e556 = newValue_1;
                param_720 = _e556;
                let _e557 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_717), (&param_718), (&param_719), (&param_720));
                if _e557 {
                    return;
                }
            }
        }
    }
    let _e558 = (*pos_16);
    bestDropPos = _e558;
    foundDrop = false;
    blockedMask_1 = 0u;
    let _e559 = (*randVal_11);
    startDir_4 = i32((fract((_e559 * 8f)) * 8f));
    let _e565 = tuning.waterSpreadRadius;
    let _e567 = tuning.gridWidth;
    let _e570 = tuning.gridHeight;
    waterReach = bitcast<i32>(clamp(_e565, 1u, bitcast<u32>(max(bitcast<i32>(_e567), bitcast<i32>(_e570)))));
    r_3 = 1i;
    loop {
        let _e576 = r_3;
        let _e577 = waterReach;
        if (_e576 <= _e577) {
            let _e579 = blockedMask_1;
            if (_e579 == 255u) {
                break;
            }
            i_21 = 0i;
            loop {
                let _e581 = i_21;
                if (_e581 < 8i) {
                    let _e583 = startDir_4;
                    let _e584 = i_21;
                    let _e585 = (_e583 + _e584);
                    d_16 = (_e585 - (i32(floor((f32(_e585) / f32(8i)))) * 8i));
                    let _e593 = blockedMask_1;
                    let _e594 = d_16;
                    if ((_e593 & (1u << bitcast<u32>(_e594))) == 0u) {
                        let _e599 = (*pos_16);
                        let _e600 = d_16;
                        param_721 = _e600;
                        let _e601 = getHDir_u0028_i1_u003b((&param_721));
                        let _e602 = r_3;
                        c_7 = (_e599 + (_e601 * vec3(_e602)));
                        let _e607 = c_7[0u];
                        let _e608 = (_e607 <= 0i);
                        phi_5086_ = _e608;
                        if !(_e608) {
                            let _e611 = c_7[0u];
                            let _e613 = tuning.gridWidth;
                            phi_5086_ = (_e611 >= (bitcast<i32>(_e613) - 1i));
                        }
                        let _e618 = phi_5086_;
                        phi_5093_ = _e618;
                        if !(_e618) {
                            let _e621 = c_7[2u];
                            phi_5093_ = (_e621 <= 0i);
                        }
                        let _e624 = phi_5093_;
                        phi_5104_ = _e624;
                        if !(_e624) {
                            let _e627 = c_7[2u];
                            let _e629 = tuning.gridDepth;
                            phi_5104_ = (_e627 >= (bitcast<i32>(_e629) - 1i));
                        }
                        let _e634 = phi_5104_;
                        phi_5116_ = _e634;
                        if !(_e634) {
                            let _e636 = c_7;
                            param_722 = _e636;
                            let _e637 = getIndex_u0028_vi3_u003b((&param_722));
                            param_723 = _e637;
                            let _e638 = readCell_u0028_u1_u003b((&param_723));
                            param_724 = _e638;
                            let _e639 = getType_u0028_u1_u003b((&param_724));
                            phi_5116_ = (_e639 != 0u);
                        }
                        let _e642 = phi_5116_;
                        if _e642 {
                            let _e643 = d_16;
                            let _e646 = blockedMask_1;
                            blockedMask_1 = (_e646 | (1u << bitcast<u32>(_e643)));
                        } else {
                            let _e649 = c_7[1u];
                            let _e650 = (_e649 > 1i);
                            phi_5138_ = _e650;
                            if _e650 {
                                let _e651 = c_7;
                                param_725 = (_e651 + vec3<i32>(0i, -1i, 0i));
                                let _e653 = getIndex_u0028_vi3_u003b((&param_725));
                                param_726 = _e653;
                                let _e654 = readCell_u0028_u1_u003b((&param_726));
                                param_727 = _e654;
                                let _e655 = getType_u0028_u1_u003b((&param_727));
                                phi_5138_ = (_e655 == 0u);
                            }
                            let _e658 = phi_5138_;
                            if _e658 {
                                let _e659 = c_7;
                                bestDropPos = _e659;
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
                    let _e660 = i_21;
                    i_21 = (_e660 + 1i);
                }
            }
            let _e662 = foundDrop;
            if _e662 {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e663 = r_3;
            r_3 = (_e663 + 1i);
        }
    }
    let _e665 = foundDrop;
    if _e665 {
        param_728 = 2u;
        param_729 = 0u;
        param_730 = 0u;
        param_731 = 0u;
        let _e666 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_728), (&param_729), (&param_730), (&param_731));
        newValue_2 = _e666;
        let _e667 = bestDropPos;
        param_732 = _e667;
        let _e668 = getIndex_u0028_vi3_u003b((&param_732));
        let _e669 = (*currentIndex_11);
        param_733 = _e669;
        let _e670 = (*rawValue_9);
        param_734 = _e670;
        param_735 = _e668;
        let _e671 = newValue_2;
        param_736 = _e671;
        let _e672 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_733), (&param_734), (&param_735), (&param_736));
        if _e672 {
            return;
        }
    } else {
        let _e674 = (*pos_16)[1u];
        let _e676 = tuning.gridHeight;
        if (_e674 < (bitcast<i32>(_e676) - 2i)) {
            let _e680 = (*pos_16);
            param_737 = (_e680 + vec3<i32>(0i, 1i, 0i));
            let _e682 = getIndex_u0028_vi3_u003b((&param_737));
            param_738 = _e682;
            let _e683 = readCell_u0028_u1_u003b((&param_738));
            param_739 = _e683;
            let _e684 = getType_u0028_u1_u003b((&param_739));
            local_25 = (_e684 != 0u);
        } else {
            local_25 = false;
        }
        let _e686 = local_25;
        hasPressure_2 = _e686;
        let _e688 = (*pos_16)[1u];
        if (_e688 > 1i) {
            let _e690 = (*pos_16);
            param_740 = (_e690 + vec3<i32>(0i, -1i, 0i));
            let _e692 = getIndex_u0028_vi3_u003b((&param_740));
            param_741 = _e692;
            let _e693 = readCell_u0028_u1_u003b((&param_741));
            param_742 = _e693;
            let _e694 = getType_u0028_u1_u003b((&param_742));
            local_26 = (_e694 == 2u);
        } else {
            local_26 = false;
        }
        let _e696 = local_26;
        isStackedOnWater_1 = _e696;
        canStepOntoPool = false;
        d_17 = 0i;
        loop {
            let _e697 = d_17;
            if (_e697 < 8i) {
                let _e699 = (*pos_16);
                let _e700 = d_17;
                param_743 = _e700;
                let _e701 = getHDir_u0028_i1_u003b((&param_743));
                nPos_8 = (_e699 + _e701);
                let _e704 = nPos_8[0u];
                let _e705 = (_e704 > 0i);
                phi_5242_ = _e705;
                if _e705 {
                    let _e707 = nPos_8[0u];
                    let _e709 = tuning.gridWidth;
                    phi_5242_ = (_e707 < (bitcast<i32>(_e709) - 1i));
                }
                let _e714 = phi_5242_;
                phi_5248_ = _e714;
                if _e714 {
                    let _e716 = nPos_8[2u];
                    phi_5248_ = (_e716 > 0i);
                }
                let _e719 = phi_5248_;
                phi_5258_ = _e719;
                if _e719 {
                    let _e721 = nPos_8[2u];
                    let _e723 = tuning.gridDepth;
                    phi_5258_ = (_e721 < (bitcast<i32>(_e723) - 1i));
                }
                let _e728 = phi_5258_;
                if _e728 {
                    let _e729 = nPos_8;
                    param_744 = _e729;
                    let _e730 = getIndex_u0028_vi3_u003b((&param_744));
                    param_745 = _e730;
                    let _e731 = readCell_u0028_u1_u003b((&param_745));
                    param_746 = _e731;
                    let _e732 = getType_u0028_u1_u003b((&param_746));
                    let _e733 = (_e732 == 0u);
                    phi_5274_ = _e733;
                    if _e733 {
                        let _e735 = (*pos_16)[1u];
                        phi_5274_ = (_e735 > 1i);
                    }
                    let _e738 = phi_5274_;
                    phi_5286_ = _e738;
                    if _e738 {
                        let _e739 = nPos_8;
                        param_747 = (_e739 + vec3<i32>(0i, -1i, 0i));
                        let _e741 = getIndex_u0028_vi3_u003b((&param_747));
                        param_748 = _e741;
                        let _e742 = readCell_u0028_u1_u003b((&param_748));
                        param_749 = _e742;
                        let _e743 = getType_u0028_u1_u003b((&param_749));
                        phi_5286_ = (_e743 == 2u);
                    }
                    let _e746 = phi_5286_;
                    if _e746 {
                        canStepOntoPool = true;
                        break;
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e747 = d_17;
                d_17 = (_e747 + 1i);
            }
        }
        let _e749 = hasPressure_2;
        let _e750 = isStackedOnWater_1;
        let _e752 = canStepOntoPool;
        if ((_e749 || _e750) || _e752) {
            let _e754 = (*randVal_11);
            startSpreadDir = i32((fract((_e754 * 8f)) * 8f));
            i_22 = 0i;
            loop {
                let _e759 = i_22;
                if (_e759 < 8i) {
                    let _e761 = startSpreadDir;
                    let _e762 = i_22;
                    let _e763 = (_e761 + _e762);
                    d_18 = (_e763 - (i32(floor((f32(_e763) / f32(8i)))) * 8i));
                    let _e771 = (*pos_16);
                    let _e772 = d_18;
                    param_750 = _e772;
                    let _e773 = getHDir_u0028_i1_u003b((&param_750));
                    targetPos_2 = (_e771 + _e773);
                    let _e776 = targetPos_2[0u];
                    let _e777 = (_e776 > 0i);
                    phi_5336_ = _e777;
                    if _e777 {
                        let _e779 = targetPos_2[0u];
                        let _e781 = tuning.gridWidth;
                        phi_5336_ = (_e779 < (bitcast<i32>(_e781) - 1i));
                    }
                    let _e786 = phi_5336_;
                    phi_5342_ = _e786;
                    if _e786 {
                        let _e788 = targetPos_2[2u];
                        phi_5342_ = (_e788 > 0i);
                    }
                    let _e791 = phi_5342_;
                    phi_5352_ = _e791;
                    if _e791 {
                        let _e793 = targetPos_2[2u];
                        let _e795 = tuning.gridDepth;
                        phi_5352_ = (_e793 < (bitcast<i32>(_e795) - 1i));
                    }
                    let _e800 = phi_5352_;
                    if _e800 {
                        let _e801 = targetPos_2;
                        param_751 = _e801;
                        let _e802 = getIndex_u0028_vi3_u003b((&param_751));
                        param_752 = _e802;
                        let _e803 = readCell_u0028_u1_u003b((&param_752));
                        param_753 = _e803;
                        let _e804 = getType_u0028_u1_u003b((&param_753));
                        if (_e804 == 0u) {
                            let _e806 = d_18;
                            param_754 = 2u;
                            param_755 = bitcast<u32>((_e806 + 1i));
                            param_756 = 0u;
                            let _e809 = newAge_2;
                            param_757 = _e809;
                            let _e810 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_754), (&param_755), (&param_756), (&param_757));
                            newValue_3 = _e810;
                            let _e811 = targetPos_2;
                            param_758 = _e811;
                            let _e812 = getIndex_u0028_vi3_u003b((&param_758));
                            let _e813 = (*currentIndex_11);
                            param_759 = _e813;
                            let _e814 = (*rawValue_9);
                            param_760 = _e814;
                            param_761 = _e812;
                            let _e815 = newValue_3;
                            param_762 = _e815;
                            let _e816 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_759), (&param_760), (&param_761), (&param_762));
                            if _e816 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e817 = i_22;
                    i_22 = (_e817 + 1i);
                }
            }
        }
    }
    let _e819 = (*currentSleep_6);
    newSleep_3 = min((_e819 + 1u), 255u);
    param_763 = 2u;
    param_764 = 0u;
    let _e822 = newSleep_3;
    param_765 = _e822;
    let _e823 = newAge_2;
    param_766 = _e823;
    let _e824 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_763), (&param_764), (&param_765), (&param_766));
    sleepValue = _e824;
    let _e825 = (*currentIndex_11);
    let _e828 = (*rawValue_9);
    let _e829 = sleepValue;
    let _e830 = atomicCompareExchangeWeak((&unnamed.grid[_e825]), _e828, _e829);
    return;
}

fn incWater_u0028_() {
    let _e216 = atomicAdd((&unnamed_2.waterVoxelCount), 1u);
    return;
}

fn updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_17: ptr<function, vec3<i32>>, currentIndex_12: ptr<function, u32>, rawValue_10: ptr<function, u32>, currentSleep_7: ptr<function, u32>, currentAge_9: ptr<function, u32>, randVal_12: ptr<function, f32>) {
    var moisture_5: u32;
    var moistureModified_1: bool;
    var startDir_5: i32;
    var i_23: i32;
    var d_19: i32;
    var nPos_9: vec3<i32>;
    var param_767: i32;
    var nIndex_5: u32;
    var param_768: vec3<i32>;
    var nVal_5: u32;
    var param_769: u32;
    var param_770: u32;
    var d_20: i32;
    var nPos_10: vec3<i32>;
    var param_771: i32;
    var nIndex_6: u32;
    var param_772: vec3<i32>;
    var nVal_6: u32;
    var param_773: u32;
    var nType_4: u32;
    var param_774: u32;
    var nMoisture_1: u32;
    var param_775: u32;
    var nCapacity_1: u32;
    var local_27: u32;
    var leakPos: vec3<i32>;
    var param_776: vec3<i32>;
    var param_777: u32;
    var param_778: u32;
    var param_779: vec3<i32>;
    var param_780: u32;
    var param_781: u32;
    var param_782: u32;
    var param_783: u32;
    var canMove_1: bool;
    var param_784: vec3<i32>;
    var isClumped_1: bool;
    var emptyBelowCount_1: i32;
    var x_2: i32;
    var z_2: i32;
    var checkPos_2: vec3<i32>;
    var param_785: vec3<i32>;
    var param_786: u32;
    var param_787: u32;
    var clumpCount_1: i32;
    var x_3: i32;
    var y_1: i32;
    var z_3: i32;
    var nPos_11: vec3<i32>;
    var param_788: vec3<i32>;
    var param_789: u32;
    var param_790: u32;
    var belowPos_9: vec3<i32>;
    var param_791: vec3<i32>;
    var param_792: u32;
    var param_793: u32;
    var param_794: vec3<i32>;
    var param_795: u32;
    var param_796: u32;
    var param_797: u32;
    var param_798: u32;
    var param_799: u32;
    var param_800: u32;
    var param_801: u32;
    var param_802: u32;
    var dir_5: i32;
    var slidePos1_1: vec3<i32>;
    var slidePos2_1: vec3<i32>;
    var param_803: vec3<i32>;
    var param_804: u32;
    var param_805: u32;
    var param_806: vec3<i32>;
    var param_807: u32;
    var param_808: u32;
    var param_809: u32;
    var param_810: u32;
    var param_811: u32;
    var param_812: u32;
    var param_813: u32;
    var param_814: u32;
    var param_815: vec3<i32>;
    var param_816: u32;
    var param_817: u32;
    var param_818: vec3<i32>;
    var param_819: u32;
    var param_820: u32;
    var param_821: u32;
    var param_822: u32;
    var param_823: u32;
    var param_824: u32;
    var param_825: u32;
    var param_826: u32;
    var belowPos_10: vec3<i32>;
    var belowIndex_4: u32;
    var param_827: vec3<i32>;
    var belowValue_4: u32;
    var param_828: u32;
    var param_829: u32;
    var startDir_6: i32;
    var i_24: i32;
    var d_21: i32;
    var pushPos_2: vec3<i32>;
    var param_830: i32;
    var param_831: u32;
    var param_832: u32;
    var param_833: u32;
    var param_834: u32;
    var param_835: vec3<i32>;
    var param_836: u32;
    var param_837: u32;
    var param_838: u32;
    var param_839: u32;
    var param_840: u32;
    var param_841: u32;
    var param_842: u32;
    var param_843: u32;
    var param_844: u32;
    var param_845: u32;
    var param_846: u32;
    var param_847: u32;
    var param_848: u32;
    var dir_6: i32;
    var slidePos_1: array<vec3<i32>, 2>;
    var s_3: i32;
    var sPos_3: vec3<i32>;
    var sIndex_1: u32;
    var param_849: vec3<i32>;
    var sValue_1: u32;
    var param_850: u32;
    var param_851: u32;
    var startDir_7: i32;
    var i_25: i32;
    var d_22: i32;
    var pushPos_3: vec3<i32>;
    var param_852: i32;
    var param_853: u32;
    var param_854: u32;
    var param_855: u32;
    var param_856: u32;
    var param_857: vec3<i32>;
    var param_858: u32;
    var param_859: u32;
    var param_860: u32;
    var param_861: u32;
    var param_862: u32;
    var param_863: u32;
    var param_864: u32;
    var param_865: u32;
    var param_866: u32;
    var param_867: u32;
    var param_868: u32;
    var param_869: u32;
    var param_870: u32;
    var newSleep_4: u32;
    var param_871: u32;
    var param_872: u32;
    var param_873: u32;
    var param_874: u32;
    var phi_2560_: bool;
    var phi_2566_: bool;
    var phi_2576_: bool;
    var phi_2582_: bool;
    var phi_2592_: bool;
    var phi_2663_: bool;
    var phi_2669_: bool;
    var phi_2679_: bool;
    var phi_2685_: bool;
    var phi_2695_: bool;
    var phi_2759_: bool;
    var phi_2778_: bool;
    var phi_2822_: bool;
    var phi_2864_: bool;
    var phi_2870_: bool;
    var phi_2879_: bool;
    var phi_2961_: bool;
    var phi_2967_: bool;
    var phi_2976_: bool;
    var phi_2982_: bool;
    var phi_2991_: bool;
    var phi_3113_: bool;
    var phi_3119_: bool;
    var phi_3129_: bool;
    var phi_3173_: bool;
    var phi_3179_: bool;
    var phi_3189_: bool;
    var phi_3281_: bool;
    var phi_3287_: bool;
    var phi_3297_: bool;
    var phi_3400_: bool;
    var phi_3406_: bool;
    var phi_3416_: bool;
    var phi_3473_: bool;
    var phi_3479_: bool;
    var phi_3489_: bool;

    let _e379 = (*currentAge_9);
    moisture_5 = _e379;
    moistureModified_1 = false;
    let _e380 = moisture_5;
    let _e382 = tuning.sandMoistureCapacity;
    if (_e380 < _e382) {
        let _e384 = (*randVal_12);
        startDir_5 = i32((fract((_e384 * 17f)) * 6f));
        i_23 = 0i;
        loop {
            let _e389 = i_23;
            if (_e389 < 6i) {
                let _e391 = startDir_5;
                let _e392 = i_23;
                let _e393 = (_e391 + _e392);
                d_19 = (_e393 - (i32(floor((f32(_e393) / f32(6i)))) * 6i));
                let _e401 = d_19;
                if (_e401 != 2i) {
                    let _e403 = (*pos_17);
                    let _e404 = d_19;
                    param_767 = _e404;
                    let _e405 = getOrthoDir_u0028_i1_u003b((&param_767));
                    nPos_9 = (_e403 + _e405);
                    let _e408 = nPos_9[0u];
                    let _e409 = (_e408 > 0i);
                    phi_2560_ = _e409;
                    if _e409 {
                        let _e411 = nPos_9[0u];
                        let _e413 = tuning.gridWidth;
                        phi_2560_ = (_e411 < (bitcast<i32>(_e413) - 1i));
                    }
                    let _e418 = phi_2560_;
                    phi_2566_ = _e418;
                    if _e418 {
                        let _e420 = nPos_9[1u];
                        phi_2566_ = (_e420 > 0i);
                    }
                    let _e423 = phi_2566_;
                    phi_2576_ = _e423;
                    if _e423 {
                        let _e425 = nPos_9[1u];
                        let _e427 = tuning.gridHeight;
                        phi_2576_ = (_e425 < (bitcast<i32>(_e427) - 1i));
                    }
                    let _e432 = phi_2576_;
                    phi_2582_ = _e432;
                    if _e432 {
                        let _e434 = nPos_9[2u];
                        phi_2582_ = (_e434 > 0i);
                    }
                    let _e437 = phi_2582_;
                    phi_2592_ = _e437;
                    if _e437 {
                        let _e439 = nPos_9[2u];
                        let _e441 = tuning.gridDepth;
                        phi_2592_ = (_e439 < (bitcast<i32>(_e441) - 1i));
                    }
                    let _e446 = phi_2592_;
                    if _e446 {
                        let _e447 = nPos_9;
                        param_768 = _e447;
                        let _e448 = getIndex_u0028_vi3_u003b((&param_768));
                        nIndex_5 = _e448;
                        let _e449 = nIndex_5;
                        param_769 = _e449;
                        let _e450 = readCell_u0028_u1_u003b((&param_769));
                        nVal_5 = _e450;
                        let _e451 = nVal_5;
                        param_770 = _e451;
                        let _e452 = getType_u0028_u1_u003b((&param_770));
                        if (_e452 == 2u) {
                            let _e454 = nIndex_5;
                            let _e457 = nVal_5;
                            let _e458 = atomicCompareExchangeWeak((&unnamed.grid[_e454]), _e457, 0u);
                            let _e460 = nVal_5;
                            if (_e458.old_value == _e460) {
                                let _e462 = (*currentIndex_12);
                                let _e466 = tuning.sandWaterAbsorbUnit;
                                let _e469 = atomicAdd((&unnamed.grid[_e462]), (_e466 << bitcast<u32>(24i)));
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
                let _e470 = i_23;
                i_23 = (_e470 + 1i);
            }
        }
    }
    let _e472 = moistureModified_1;
    let _e474 = moisture_5;
    if (!(_e472) && (_e474 > 0u)) {
        let _e477 = (*randVal_12);
        d_20 = i32((fract((_e477 * 31f)) * 6f));
        let _e482 = d_20;
        if (_e482 != 2i) {
            let _e484 = (*pos_17);
            let _e485 = d_20;
            param_771 = _e485;
            let _e486 = getOrthoDir_u0028_i1_u003b((&param_771));
            nPos_10 = (_e484 + _e486);
            let _e489 = nPos_10[0u];
            let _e490 = (_e489 > 0i);
            phi_2663_ = _e490;
            if _e490 {
                let _e492 = nPos_10[0u];
                let _e494 = tuning.gridWidth;
                phi_2663_ = (_e492 < (bitcast<i32>(_e494) - 1i));
            }
            let _e499 = phi_2663_;
            phi_2669_ = _e499;
            if _e499 {
                let _e501 = nPos_10[1u];
                phi_2669_ = (_e501 > 0i);
            }
            let _e504 = phi_2669_;
            phi_2679_ = _e504;
            if _e504 {
                let _e506 = nPos_10[1u];
                let _e508 = tuning.gridHeight;
                phi_2679_ = (_e506 < (bitcast<i32>(_e508) - 1i));
            }
            let _e513 = phi_2679_;
            phi_2685_ = _e513;
            if _e513 {
                let _e515 = nPos_10[2u];
                phi_2685_ = (_e515 > 0i);
            }
            let _e518 = phi_2685_;
            phi_2695_ = _e518;
            if _e518 {
                let _e520 = nPos_10[2u];
                let _e522 = tuning.gridDepth;
                phi_2695_ = (_e520 < (bitcast<i32>(_e522) - 1i));
            }
            let _e527 = phi_2695_;
            if _e527 {
                let _e528 = nPos_10;
                param_772 = _e528;
                let _e529 = getIndex_u0028_vi3_u003b((&param_772));
                nIndex_6 = _e529;
                let _e530 = nIndex_6;
                param_773 = _e530;
                let _e531 = readCell_u0028_u1_u003b((&param_773));
                nVal_6 = _e531;
                let _e532 = nVal_6;
                param_774 = _e532;
                let _e533 = getType_u0028_u1_u003b((&param_774));
                nType_4 = _e533;
                let _e534 = nType_4;
                let _e536 = nType_4;
                if ((_e534 == 1u) || (_e536 == 4u)) {
                    let _e539 = nVal_6;
                    param_775 = _e539;
                    let _e540 = getAge_u0028_u1_u003b((&param_775));
                    nMoisture_1 = _e540;
                    let _e541 = nType_4;
                    if (_e541 == 4u) {
                        let _e544 = tuning.dirtMoistureCapacity;
                        local_27 = _e544;
                    } else {
                        let _e546 = tuning.sandMoistureCapacity;
                        local_27 = _e546;
                    }
                    let _e547 = local_27;
                    nCapacity_1 = _e547;
                    let _e548 = moisture_5;
                    let _e549 = nMoisture_1;
                    let _e552 = nMoisture_1;
                    let _e553 = nCapacity_1;
                    if ((_e548 > (_e549 + 1u)) && (_e552 < _e553)) {
                        let _e556 = (*currentIndex_12);
                        let _e559 = atomicAdd((&unnamed.grid[_e556]), 4278190080u);
                        let _e560 = nIndex_6;
                        let _e563 = atomicAdd((&unnamed.grid[_e560]), 16777216u);
                        moistureModified_1 = true;
                    }
                }
            }
        }
    }
    let _e564 = moistureModified_1;
    let _e565 = !(_e564);
    phi_2759_ = _e565;
    if _e565 {
        let _e566 = moisture_5;
        let _e568 = tuning.sandWaterAbsorbUnit;
        phi_2759_ = (_e566 >= _e568);
    }
    let _e571 = phi_2759_;
    if _e571 {
        let _e572 = (*pos_17);
        leakPos = (_e572 + vec3<i32>(0i, -1i, 0i));
        let _e575 = leakPos[1u];
        let _e576 = (_e575 > 0i);
        phi_2778_ = _e576;
        if _e576 {
            let _e577 = leakPos;
            param_776 = _e577;
            let _e578 = getIndex_u0028_vi3_u003b((&param_776));
            param_777 = _e578;
            let _e579 = readCell_u0028_u1_u003b((&param_777));
            param_778 = _e579;
            let _e580 = getType_u0028_u1_u003b((&param_778));
            phi_2778_ = (_e580 == 0u);
        }
        let _e583 = phi_2778_;
        if _e583 {
            let _e584 = leakPos;
            param_779 = _e584;
            let _e585 = getIndex_u0028_vi3_u003b((&param_779));
            param_780 = 2u;
            param_781 = 0u;
            param_782 = 0u;
            param_783 = 0u;
            let _e588 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_780), (&param_781), (&param_782), (&param_783));
            let _e589 = atomicCompareExchangeWeak((&unnamed.grid[_e585]), 0u, _e588);
            if (_e589.old_value == 0u) {
                let _e592 = (*currentIndex_12);
                let _e596 = tuning.sandWaterAbsorbUnit;
                let _e600 = atomicAdd((&unnamed.grid[_e592]), ((0u - _e596) << bitcast<u32>(24i)));
                incWater_u0028_();
                moistureModified_1 = true;
            }
        }
    }
    let _e601 = moistureModified_1;
    if _e601 {
        return;
    }
    let _e602 = (*pos_17);
    param_784 = _e602;
    let _e603 = grainCanMove_u0028_vi3_u003b((&param_784));
    canMove_1 = _e603;
    isClumped_1 = false;
    let _e604 = canMove_1;
    let _e605 = moisture_5;
    let _e607 = (_e604 && (_e605 > 0u));
    phi_2822_ = _e607;
    if _e607 {
        let _e608 = (*currentSleep_7);
        let _e610 = tuning.wakeSleepThreshold;
        phi_2822_ = (_e608 > _e610);
    }
    let _e613 = phi_2822_;
    if _e613 {
        emptyBelowCount_1 = 0i;
        let _e615 = (*pos_17)[1u];
        if (_e615 > 1i) {
            x_2 = -1i;
            loop {
                let _e617 = x_2;
                if (_e617 <= 1i) {
                    z_2 = -1i;
                    loop {
                        let _e619 = z_2;
                        if (_e619 <= 1i) {
                            let _e621 = (*pos_17);
                            let _e622 = x_2;
                            let _e623 = z_2;
                            checkPos_2 = (_e621 + vec3<i32>(_e622, -1i, _e623));
                            let _e627 = checkPos_2[0u];
                            let _e628 = (_e627 >= 0i);
                            phi_2864_ = _e628;
                            if _e628 {
                                let _e630 = checkPos_2[0u];
                                let _e632 = tuning.gridWidth;
                                phi_2864_ = (_e630 < bitcast<i32>(_e632));
                            }
                            let _e636 = phi_2864_;
                            phi_2870_ = _e636;
                            if _e636 {
                                let _e638 = checkPos_2[2u];
                                phi_2870_ = (_e638 >= 0i);
                            }
                            let _e641 = phi_2870_;
                            phi_2879_ = _e641;
                            if _e641 {
                                let _e643 = checkPos_2[2u];
                                let _e645 = tuning.gridDepth;
                                phi_2879_ = (_e643 < bitcast<i32>(_e645));
                            }
                            let _e649 = phi_2879_;
                            if _e649 {
                                let _e650 = checkPos_2;
                                param_785 = _e650;
                                let _e651 = getIndex_u0028_vi3_u003b((&param_785));
                                param_786 = _e651;
                                let _e652 = readCell_u0028_u1_u003b((&param_786));
                                param_787 = _e652;
                                let _e653 = getType_u0028_u1_u003b((&param_787));
                                if (_e653 == 0u) {
                                    let _e655 = emptyBelowCount_1;
                                    emptyBelowCount_1 = (_e655 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e657 = z_2;
                            z_2 = (_e657 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e659 = x_2;
                    x_2 = (_e659 + 1i);
                }
            }
        }
        let _e661 = emptyBelowCount_1;
        let _e663 = tuning.emptyBelowWakeCount;
        if (_e661 >= bitcast<i32>(_e663)) {
            (*currentSleep_7) = 0u;
        } else {
            clumpCount_1 = 0i;
            x_3 = -1i;
            loop {
                let _e666 = x_3;
                if (_e666 <= 1i) {
                    y_1 = -1i;
                    loop {
                        let _e668 = y_1;
                        if (_e668 <= 1i) {
                            z_3 = -1i;
                            loop {
                                let _e670 = z_3;
                                if (_e670 <= 1i) {
                                    let _e672 = x_3;
                                    let _e674 = y_1;
                                    let _e677 = z_3;
                                    if (((_e672 == 0i) && (_e674 == 0i)) && (_e677 == 0i)) {
                                        continue;
                                    }
                                    let _e680 = (*pos_17);
                                    let _e681 = x_3;
                                    let _e682 = y_1;
                                    let _e683 = z_3;
                                    nPos_11 = (_e680 + vec3<i32>(_e681, _e682, _e683));
                                    let _e687 = nPos_11[0u];
                                    let _e688 = (_e687 >= 0i);
                                    phi_2961_ = _e688;
                                    if _e688 {
                                        let _e690 = nPos_11[0u];
                                        let _e692 = tuning.gridWidth;
                                        phi_2961_ = (_e690 < bitcast<i32>(_e692));
                                    }
                                    let _e696 = phi_2961_;
                                    phi_2967_ = _e696;
                                    if _e696 {
                                        let _e698 = nPos_11[1u];
                                        phi_2967_ = (_e698 >= 0i);
                                    }
                                    let _e701 = phi_2967_;
                                    phi_2976_ = _e701;
                                    if _e701 {
                                        let _e703 = nPos_11[1u];
                                        let _e705 = tuning.gridHeight;
                                        phi_2976_ = (_e703 < bitcast<i32>(_e705));
                                    }
                                    let _e709 = phi_2976_;
                                    phi_2982_ = _e709;
                                    if _e709 {
                                        let _e711 = nPos_11[2u];
                                        phi_2982_ = (_e711 >= 0i);
                                    }
                                    let _e714 = phi_2982_;
                                    phi_2991_ = _e714;
                                    if _e714 {
                                        let _e716 = nPos_11[2u];
                                        let _e718 = tuning.gridDepth;
                                        phi_2991_ = (_e716 < bitcast<i32>(_e718));
                                    }
                                    let _e722 = phi_2991_;
                                    if _e722 {
                                        let _e723 = nPos_11;
                                        param_788 = _e723;
                                        let _e724 = getIndex_u0028_vi3_u003b((&param_788));
                                        param_789 = _e724;
                                        let _e725 = readCell_u0028_u1_u003b((&param_789));
                                        param_790 = _e725;
                                        let _e726 = getType_u0028_u1_u003b((&param_790));
                                        if (_e726 == 1u) {
                                            let _e728 = clumpCount_1;
                                            clumpCount_1 = (_e728 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e730 = z_3;
                                    z_3 = (_e730 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e732 = y_1;
                            y_1 = (_e732 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e734 = x_3;
                    x_3 = (_e734 + 1i);
                }
            }
            let _e736 = clumpCount_1;
            let _e738 = tuning.sandClumpThreshold;
            if (_e736 >= bitcast<i32>(_e738)) {
                isClumped_1 = true;
            }
        }
    }
    let _e741 = canMove_1;
    let _e742 = isClumped_1;
    if (_e741 && !(_e742)) {
        let _e746 = (*pos_17)[1u];
        if (_e746 > 1i) {
            let _e748 = (*pos_17);
            belowPos_9 = (_e748 + vec3<i32>(0i, -1i, 0i));
            let _e750 = belowPos_9;
            param_791 = _e750;
            let _e751 = getIndex_u0028_vi3_u003b((&param_791));
            param_792 = _e751;
            let _e752 = readCell_u0028_u1_u003b((&param_792));
            param_793 = _e752;
            let _e753 = getType_u0028_u1_u003b((&param_793));
            if (_e753 == 0u) {
                let _e755 = belowPos_9;
                param_794 = _e755;
                let _e756 = getIndex_u0028_vi3_u003b((&param_794));
                param_795 = 1u;
                param_796 = 0u;
                param_797 = 0u;
                let _e757 = moisture_5;
                param_798 = _e757;
                let _e758 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_795), (&param_796), (&param_797), (&param_798));
                let _e759 = (*currentIndex_12);
                param_799 = _e759;
                let _e760 = (*rawValue_10);
                param_800 = _e760;
                param_801 = _e756;
                param_802 = _e758;
                let _e761 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_799), (&param_800), (&param_801), (&param_802));
                if _e761 {
                    return;
                }
            }
        }
        let _e763 = (*pos_17)[1u];
        if (_e763 > 1i) {
            let _e765 = (*randVal_12);
            dir_5 = select(-1i, 1i, (fract((_e765 * 10f)) > 0.5f));
            let _e770 = (*randVal_12);
            if (fract((_e770 * 100f)) > 0.5f) {
                let _e774 = (*pos_17);
                let _e775 = dir_5;
                slidePos1_1 = (_e774 + vec3<i32>(_e775, -1i, 0i));
                let _e778 = (*pos_17);
                let _e779 = dir_5;
                slidePos2_1 = (_e778 + vec3<i32>(0i, -1i, _e779));
            } else {
                let _e782 = (*pos_17);
                let _e783 = dir_5;
                slidePos1_1 = (_e782 + vec3<i32>(0i, -1i, _e783));
                let _e786 = (*pos_17);
                let _e787 = dir_5;
                slidePos2_1 = (_e786 + vec3<i32>(_e787, -1i, 0i));
            }
            let _e791 = slidePos1_1[0u];
            let _e792 = (_e791 > 0i);
            phi_3113_ = _e792;
            if _e792 {
                let _e794 = slidePos1_1[0u];
                let _e796 = tuning.gridWidth;
                phi_3113_ = (_e794 < (bitcast<i32>(_e796) - 1i));
            }
            let _e801 = phi_3113_;
            phi_3119_ = _e801;
            if _e801 {
                let _e803 = slidePos1_1[2u];
                phi_3119_ = (_e803 > 0i);
            }
            let _e806 = phi_3119_;
            phi_3129_ = _e806;
            if _e806 {
                let _e808 = slidePos1_1[2u];
                let _e810 = tuning.gridDepth;
                phi_3129_ = (_e808 < (bitcast<i32>(_e810) - 1i));
            }
            let _e815 = phi_3129_;
            if _e815 {
                let _e816 = slidePos1_1;
                param_803 = _e816;
                let _e817 = getIndex_u0028_vi3_u003b((&param_803));
                param_804 = _e817;
                let _e818 = readCell_u0028_u1_u003b((&param_804));
                param_805 = _e818;
                let _e819 = getType_u0028_u1_u003b((&param_805));
                if (_e819 == 0u) {
                    let _e821 = slidePos1_1;
                    param_806 = _e821;
                    let _e822 = getIndex_u0028_vi3_u003b((&param_806));
                    param_807 = 1u;
                    param_808 = 0u;
                    param_809 = 0u;
                    let _e823 = moisture_5;
                    param_810 = _e823;
                    let _e824 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_807), (&param_808), (&param_809), (&param_810));
                    let _e825 = (*currentIndex_12);
                    param_811 = _e825;
                    let _e826 = (*rawValue_10);
                    param_812 = _e826;
                    param_813 = _e822;
                    param_814 = _e824;
                    let _e827 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_811), (&param_812), (&param_813), (&param_814));
                    if _e827 {
                        return;
                    }
                }
            }
            let _e829 = slidePos2_1[0u];
            let _e830 = (_e829 > 0i);
            phi_3173_ = _e830;
            if _e830 {
                let _e832 = slidePos2_1[0u];
                let _e834 = tuning.gridWidth;
                phi_3173_ = (_e832 < (bitcast<i32>(_e834) - 1i));
            }
            let _e839 = phi_3173_;
            phi_3179_ = _e839;
            if _e839 {
                let _e841 = slidePos2_1[2u];
                phi_3179_ = (_e841 > 0i);
            }
            let _e844 = phi_3179_;
            phi_3189_ = _e844;
            if _e844 {
                let _e846 = slidePos2_1[2u];
                let _e848 = tuning.gridDepth;
                phi_3189_ = (_e846 < (bitcast<i32>(_e848) - 1i));
            }
            let _e853 = phi_3189_;
            if _e853 {
                let _e854 = slidePos2_1;
                param_815 = _e854;
                let _e855 = getIndex_u0028_vi3_u003b((&param_815));
                param_816 = _e855;
                let _e856 = readCell_u0028_u1_u003b((&param_816));
                param_817 = _e856;
                let _e857 = getType_u0028_u1_u003b((&param_817));
                if (_e857 == 0u) {
                    let _e859 = slidePos2_1;
                    param_818 = _e859;
                    let _e860 = getIndex_u0028_vi3_u003b((&param_818));
                    param_819 = 1u;
                    param_820 = 0u;
                    param_821 = 0u;
                    let _e861 = moisture_5;
                    param_822 = _e861;
                    let _e862 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_819), (&param_820), (&param_821), (&param_822));
                    let _e863 = (*currentIndex_12);
                    param_823 = _e863;
                    let _e864 = (*rawValue_10);
                    param_824 = _e864;
                    param_825 = _e860;
                    param_826 = _e862;
                    let _e865 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_823), (&param_824), (&param_825), (&param_826));
                    if _e865 {
                        return;
                    }
                }
            }
        }
        let _e867 = (*pos_17)[1u];
        if (_e867 > 1i) {
            let _e869 = (*pos_17);
            belowPos_10 = (_e869 + vec3<i32>(0i, -1i, 0i));
            let _e871 = belowPos_10;
            param_827 = _e871;
            let _e872 = getIndex_u0028_vi3_u003b((&param_827));
            belowIndex_4 = _e872;
            let _e873 = belowIndex_4;
            param_828 = _e873;
            let _e874 = readCell_u0028_u1_u003b((&param_828));
            belowValue_4 = _e874;
            let _e875 = belowValue_4;
            param_829 = _e875;
            let _e876 = getType_u0028_u1_u003b((&param_829));
            if (_e876 == 2u) {
                let _e878 = (*randVal_12);
                startDir_6 = i32((fract((_e878 * 8f)) * 8f));
                i_24 = 0i;
                loop {
                    let _e883 = i_24;
                    if (_e883 < 8i) {
                        let _e885 = startDir_6;
                        let _e886 = i_24;
                        let _e887 = (_e885 + _e886);
                        d_21 = (_e887 - (i32(floor((f32(_e887) / f32(8i)))) * 8i));
                        let _e895 = belowPos_10;
                        let _e896 = d_21;
                        param_830 = _e896;
                        let _e897 = getHDir_u0028_i1_u003b((&param_830));
                        pushPos_2 = (_e895 + _e897);
                        let _e900 = pushPos_2[0u];
                        let _e901 = (_e900 > 0i);
                        phi_3281_ = _e901;
                        if _e901 {
                            let _e903 = pushPos_2[0u];
                            let _e905 = tuning.gridWidth;
                            phi_3281_ = (_e903 < (bitcast<i32>(_e905) - 1i));
                        }
                        let _e910 = phi_3281_;
                        phi_3287_ = _e910;
                        if _e910 {
                            let _e912 = pushPos_2[2u];
                            phi_3287_ = (_e912 > 0i);
                        }
                        let _e915 = phi_3287_;
                        phi_3297_ = _e915;
                        if _e915 {
                            let _e917 = pushPos_2[2u];
                            let _e919 = tuning.gridDepth;
                            phi_3297_ = (_e917 < (bitcast<i32>(_e919) - 1i));
                        }
                        let _e924 = phi_3297_;
                        if _e924 {
                            param_831 = 1u;
                            param_832 = 0u;
                            param_833 = 0u;
                            let _e925 = moisture_5;
                            param_834 = _e925;
                            let _e926 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_831), (&param_832), (&param_833), (&param_834));
                            let _e927 = pushPos_2;
                            param_835 = _e927;
                            let _e928 = getIndex_u0028_vi3_u003b((&param_835));
                            let _e929 = (*currentIndex_12);
                            param_836 = _e929;
                            param_837 = _e926;
                            let _e930 = belowIndex_4;
                            param_838 = _e930;
                            let _e931 = belowValue_4;
                            param_839 = _e931;
                            param_840 = _e928;
                            let _e932 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_836), (&param_837), (&param_838), (&param_839), (&param_840));
                            if _e932 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e933 = i_24;
                        i_24 = (_e933 + 1i);
                    }
                }
                param_841 = 1u;
                param_842 = 0u;
                param_843 = 0u;
                let _e935 = moisture_5;
                param_844 = _e935;
                let _e936 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_841), (&param_842), (&param_843), (&param_844));
                let _e937 = (*currentIndex_12);
                param_845 = _e937;
                let _e938 = (*rawValue_10);
                param_846 = _e938;
                let _e939 = belowIndex_4;
                param_847 = _e939;
                param_848 = _e936;
                let _e940 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_845), (&param_846), (&param_847), (&param_848));
                if _e940 {
                    return;
                }
            }
            let _e941 = (*randVal_12);
            dir_6 = select(-1i, 1i, (fract((_e941 * 10f)) > 0.5f));
            let _e946 = (*randVal_12);
            if (fract((_e946 * 100f)) > 0.5f) {
                let _e950 = (*pos_17);
                let _e951 = dir_6;
                slidePos_1[0i] = (_e950 + vec3<i32>(_e951, -1i, 0i));
                let _e955 = (*pos_17);
                let _e956 = dir_6;
                slidePos_1[1i] = (_e955 + vec3<i32>(0i, -1i, _e956));
            } else {
                let _e960 = (*pos_17);
                let _e961 = dir_6;
                slidePos_1[0i] = (_e960 + vec3<i32>(0i, -1i, _e961));
                let _e965 = (*pos_17);
                let _e966 = dir_6;
                slidePos_1[1i] = (_e965 + vec3<i32>(_e966, -1i, 0i));
            }
            s_3 = 0i;
            loop {
                let _e970 = s_3;
                if (_e970 < 2i) {
                    let _e972 = s_3;
                    let _e974 = slidePos_1[_e972];
                    sPos_3 = _e974;
                    let _e976 = sPos_3[0u];
                    let _e977 = (_e976 > 0i);
                    phi_3400_ = _e977;
                    if _e977 {
                        let _e979 = sPos_3[0u];
                        let _e981 = tuning.gridWidth;
                        phi_3400_ = (_e979 < (bitcast<i32>(_e981) - 1i));
                    }
                    let _e986 = phi_3400_;
                    phi_3406_ = _e986;
                    if _e986 {
                        let _e988 = sPos_3[2u];
                        phi_3406_ = (_e988 > 0i);
                    }
                    let _e991 = phi_3406_;
                    phi_3416_ = _e991;
                    if _e991 {
                        let _e993 = sPos_3[2u];
                        let _e995 = tuning.gridDepth;
                        phi_3416_ = (_e993 < (bitcast<i32>(_e995) - 1i));
                    }
                    let _e1000 = phi_3416_;
                    if _e1000 {
                        let _e1001 = sPos_3;
                        param_849 = _e1001;
                        let _e1002 = getIndex_u0028_vi3_u003b((&param_849));
                        sIndex_1 = _e1002;
                        let _e1003 = sIndex_1;
                        param_850 = _e1003;
                        let _e1004 = readCell_u0028_u1_u003b((&param_850));
                        sValue_1 = _e1004;
                        let _e1005 = sValue_1;
                        param_851 = _e1005;
                        let _e1006 = getType_u0028_u1_u003b((&param_851));
                        if (_e1006 == 2u) {
                            let _e1008 = (*randVal_12);
                            let _e1010 = s_3;
                            startDir_7 = i32((fract(((_e1008 * 8f) + f32(_e1010))) * 8f));
                            i_25 = 0i;
                            loop {
                                let _e1016 = i_25;
                                if (_e1016 < 8i) {
                                    let _e1018 = startDir_7;
                                    let _e1019 = i_25;
                                    let _e1020 = (_e1018 + _e1019);
                                    d_22 = (_e1020 - (i32(floor((f32(_e1020) / f32(8i)))) * 8i));
                                    let _e1028 = sPos_3;
                                    let _e1029 = d_22;
                                    param_852 = _e1029;
                                    let _e1030 = getHDir_u0028_i1_u003b((&param_852));
                                    pushPos_3 = (_e1028 + _e1030);
                                    let _e1033 = pushPos_3[0u];
                                    let _e1034 = (_e1033 > 0i);
                                    phi_3473_ = _e1034;
                                    if _e1034 {
                                        let _e1036 = pushPos_3[0u];
                                        let _e1038 = tuning.gridWidth;
                                        phi_3473_ = (_e1036 < (bitcast<i32>(_e1038) - 1i));
                                    }
                                    let _e1043 = phi_3473_;
                                    phi_3479_ = _e1043;
                                    if _e1043 {
                                        let _e1045 = pushPos_3[2u];
                                        phi_3479_ = (_e1045 > 0i);
                                    }
                                    let _e1048 = phi_3479_;
                                    phi_3489_ = _e1048;
                                    if _e1048 {
                                        let _e1050 = pushPos_3[2u];
                                        let _e1052 = tuning.gridDepth;
                                        phi_3489_ = (_e1050 < (bitcast<i32>(_e1052) - 1i));
                                    }
                                    let _e1057 = phi_3489_;
                                    if _e1057 {
                                        param_853 = 1u;
                                        param_854 = 0u;
                                        param_855 = 0u;
                                        let _e1058 = moisture_5;
                                        param_856 = _e1058;
                                        let _e1059 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_853), (&param_854), (&param_855), (&param_856));
                                        let _e1060 = pushPos_3;
                                        param_857 = _e1060;
                                        let _e1061 = getIndex_u0028_vi3_u003b((&param_857));
                                        let _e1062 = (*currentIndex_12);
                                        param_858 = _e1062;
                                        param_859 = _e1059;
                                        let _e1063 = sIndex_1;
                                        param_860 = _e1063;
                                        let _e1064 = sValue_1;
                                        param_861 = _e1064;
                                        param_862 = _e1061;
                                        let _e1065 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_858), (&param_859), (&param_860), (&param_861), (&param_862));
                                        if _e1065 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1066 = i_25;
                                    i_25 = (_e1066 + 1i);
                                }
                            }
                            param_863 = 1u;
                            param_864 = 0u;
                            param_865 = 0u;
                            let _e1068 = moisture_5;
                            param_866 = _e1068;
                            let _e1069 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_863), (&param_864), (&param_865), (&param_866));
                            let _e1070 = (*currentIndex_12);
                            param_867 = _e1070;
                            let _e1071 = (*rawValue_10);
                            param_868 = _e1071;
                            let _e1072 = sIndex_1;
                            param_869 = _e1072;
                            param_870 = _e1069;
                            let _e1073 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_867), (&param_868), (&param_869), (&param_870));
                            if _e1073 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1074 = s_3;
                    s_3 = (_e1074 + 1i);
                }
            }
        }
    }
    let _e1076 = (*currentSleep_7);
    newSleep_4 = min((_e1076 + 1u), 255u);
    let _e1079 = (*currentIndex_12);
    let _e1082 = (*rawValue_10);
    param_871 = 1u;
    param_872 = 0u;
    let _e1083 = newSleep_4;
    param_873 = _e1083;
    let _e1084 = moisture_5;
    param_874 = _e1084;
    let _e1085 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_871), (&param_872), (&param_873), (&param_874));
    let _e1086 = atomicCompareExchangeWeak((&unnamed.grid[_e1079]), _e1082, _e1085);
    return;
}

fn orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b(pos_18: ptr<function, vec3<i32>>, currentIndex_13: ptr<function, u32>, rawValue_11: ptr<function, u32>, stepDir: ptr<function, vec3<i32>>) -> bool {
    var target_4: vec3<i32>;
    var targetIndex_3: u32;
    var param_875: vec3<i32>;
    var param_876: u32;
    var param_877: u32;
    var param_878: u32;
    var param_879: u32;
    var param_880: u32;
    var param_881: u32;
    var param_882: u32;
    var param_883: u32;
    var param_884: u32;
    var param_885: u32;
    var param_886: u32;
    var param_887: u32;
    var param_888: u32;
    var phi_1880_: bool;
    var phi_1887_: bool;
    var phi_1898_: bool;
    var phi_1905_: bool;
    var phi_1916_: bool;

    let _e235 = (*stepDir);
    if all((_e235 == vec3<i32>(0i, 0i, 0i))) {
        return false;
    }
    let _e238 = (*pos_18);
    let _e239 = (*stepDir);
    target_4 = (_e238 + _e239);
    let _e242 = target_4[0u];
    let _e243 = (_e242 < 1i);
    phi_1880_ = _e243;
    if !(_e243) {
        let _e246 = target_4[0u];
        let _e248 = tuning.gridWidth;
        phi_1880_ = (_e246 >= (bitcast<i32>(_e248) - 1i));
    }
    let _e253 = phi_1880_;
    phi_1887_ = _e253;
    if !(_e253) {
        let _e256 = target_4[1u];
        phi_1887_ = (_e256 < 1i);
    }
    let _e259 = phi_1887_;
    phi_1898_ = _e259;
    if !(_e259) {
        let _e262 = target_4[1u];
        let _e264 = tuning.gridHeight;
        phi_1898_ = (_e262 >= (bitcast<i32>(_e264) - 1i));
    }
    let _e269 = phi_1898_;
    phi_1905_ = _e269;
    if !(_e269) {
        let _e272 = target_4[2u];
        phi_1905_ = (_e272 < 1i);
    }
    let _e275 = phi_1905_;
    phi_1916_ = _e275;
    if !(_e275) {
        let _e278 = target_4[2u];
        let _e280 = tuning.gridDepth;
        phi_1916_ = (_e278 >= (bitcast<i32>(_e280) - 1i));
    }
    let _e285 = phi_1916_;
    if _e285 {
        return false;
    }
    let _e286 = target_4;
    param_875 = _e286;
    let _e287 = getIndex_u0028_vi3_u003b((&param_875));
    targetIndex_3 = _e287;
    let _e288 = targetIndex_3;
    param_876 = _e288;
    let _e289 = readCell_u0028_u1_u003b((&param_876));
    param_877 = _e289;
    let _e290 = getType_u0028_u1_u003b((&param_877));
    if (_e290 != 0u) {
        return false;
    }
    let _e292 = (*rawValue_11);
    param_878 = _e292;
    let _e293 = getType_u0028_u1_u003b((&param_878));
    let _e294 = (*rawValue_11);
    param_879 = _e294;
    let _e295 = getDir_u0028_u1_u003b((&param_879));
    let _e296 = (*rawValue_11);
    param_880 = _e296;
    let _e297 = getAge_u0028_u1_u003b((&param_880));
    param_881 = _e293;
    param_882 = _e295;
    param_883 = 0u;
    param_884 = _e297;
    let _e298 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_881), (&param_882), (&param_883), (&param_884));
    let _e299 = (*currentIndex_13);
    param_885 = _e299;
    let _e300 = (*rawValue_11);
    param_886 = _e300;
    let _e301 = targetIndex_3;
    param_887 = _e301;
    param_888 = _e298;
    let _e302 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_885), (&param_886), (&param_887), (&param_888));
    return _e302;
}

fn dominantAxis_u0028_vf3_u003b_f1_u003b(dir_7: ptr<function, vec3<f32>>, relative: ptr<function, f32>) -> vec3<i32> {
    var a_1: vec3<f32>;
    var m: f32;

    let _e219 = (*dir_7);
    a_1 = abs(_e219);
    let _e222 = a_1[0u];
    let _e224 = a_1[1u];
    let _e226 = a_1[2u];
    m = max(_e222, max(_e224, _e226));
    let _e229 = m;
    if (_e229 <= 0f) {
        return vec3<i32>(0i, 0i, 0i);
    }
    let _e231 = a_1;
    let _e232 = m;
    let _e233 = (*relative);
    let _e238 = (*dir_7);
    return (select(vec3<i32>(0i, 0i, 0i), vec3<i32>(1i, 1i, 1i), (_e231 >= vec3((_e232 * _e233)))) * vec3<i32>(sign(_e238)));
}

fn bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b(k_1: ptr<function, i32>, planeCount: ptr<function, i32>, seed: ptr<function, f32>) -> vec3<f32> {
    var z_4: f32;
    var r_4: f32;
    var a_2: f32;

    let _e221 = (*k_1);
    let _e224 = (*planeCount);
    z_4 = ((f32(_e221) + 0.5f) / f32(_e224));
    let _e227 = z_4;
    let _e228 = z_4;
    r_4 = sqrt(max(0f, (1f - (_e227 * _e228))));
    let _e233 = (*k_1);
    let _e236 = (*seed);
    a_2 = ((2.399963f * f32(_e233)) + _e236);
    let _e238 = r_4;
    let _e239 = a_2;
    let _e242 = z_4;
    let _e243 = r_4;
    let _e244 = a_2;
    return vec3<f32>((_e238 * cos(_e239)), _e242, (_e243 * sin(_e244)));
}

fn bhOrbitAxis_u0028_vi3_u003b_vi3_u003b(center: ptr<function, vec3<i32>>, pos_19: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radial: vec3<f32>;
    var planeCount_1: i32;
    var seed_1: f32;
    var param_889: vec3<f32>;
    var best: vec3<f32>;
    var bestAlign: f32;
    var bestK: i32;
    var k_2: i32;
    var n_2: vec3<f32>;
    var param_890: i32;
    var param_891: i32;
    var param_892: f32;
    var align: f32;
    var sense: f32;
    var param_893: vec3<f32>;

    let _e232 = (*pos_19);
    let _e233 = (*center);
    radial = normalize(vec3<f32>((_e232 - _e233)));
    let _e238 = tuning.blackHoleOrbitPlanes;
    planeCount_1 = bitcast<i32>(clamp(_e238, 1u, 32u));
    let _e241 = (*center);
    param_889 = (vec3<f32>(_e241) + vec3<f32>(29f, 3f, 71f));
    let _e244 = hash_u0028_vf3_u003b((&param_889));
    seed_1 = (_e244 * 6.28318f);
    best = vec3<f32>(0f, 1f, 0f);
    bestAlign = 2f;
    bestK = 0i;
    k_2 = 0i;
    loop {
        let _e246 = k_2;
        let _e247 = planeCount_1;
        if (_e246 < _e247) {
            let _e249 = k_2;
            param_890 = _e249;
            let _e250 = planeCount_1;
            param_891 = _e250;
            let _e251 = seed_1;
            param_892 = _e251;
            let _e252 = bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b((&param_890), (&param_891), (&param_892));
            n_2 = _e252;
            let _e253 = n_2;
            let _e254 = radial;
            align = abs(dot(_e253, _e254));
            let _e257 = align;
            let _e258 = bestAlign;
            if (_e257 < _e258) {
                let _e260 = align;
                bestAlign = _e260;
                let _e261 = n_2;
                best = _e261;
                let _e262 = k_2;
                bestK = _e262;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e263 = k_2;
            k_2 = (_e263 + 1i);
        }
    }
    let _e265 = (*center);
    let _e267 = bestK;
    param_893 = (vec3<f32>(_e265) + vec3<f32>((f32(_e267) * 13f), 101f, 47f));
    let _e272 = hash_u0028_vf3_u003b((&param_893));
    sense = select(1f, -1f, (_e272 < 0.5f));
    let _e275 = best;
    let _e276 = sense;
    return (_e275 * _e276);
}

fn bhIsPurge_u0028_u1_u003b(code: ptr<function, u32>) -> bool {
    let _e216 = (*code);
    return ((_e216 & 1073741824u) != 0u);
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e216 = (*level);
    return (f32(_e216) + 0.5f);
}

fn updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b(pos_20: ptr<function, vec3<i32>>, currentIndex_14: ptr<function, u32>, rawValue_12: ptr<function, u32>, center_1: ptr<function, vec3<i32>>, slot: ptr<function, i32>, level_1: ptr<function, u32>, purge: ptr<function, bool>, dist_1: ptr<function, f32>, randVal_13: ptr<function, f32>) {
    var type_37: u32;
    var param_894: u32;
    var sleep_1: u32;
    var param_895: u32;
    var param_896: u32;
    var param_897: u32;
    var orbitSpeed: f32;
    var local_28: f32;
    var infallChance: f32;
    var local_29: f32;
    var param_898: u32;
    var param_899: u32;
    var param_900: u32;
    var param_901: u32;
    var param_902: u32;
    var param_903: u32;
    var inward: vec3<f32>;
    var axis: vec3<f32>;
    var param_904: vec3<i32>;
    var param_905: vec3<i32>;
    var tangent: vec3<f32>;
    var tangentLen: f32;
    var axial: f32;
    var grip: vec3<f32>;
    var along: vec3<f32>;
    var pullIn: bool;
    var spiral: vec3<f32>;
    var param_906: vec3<f32>;
    var param_907: f32;
    var param_908: vec3<i32>;
    var param_909: u32;
    var param_910: u32;
    var param_911: vec3<i32>;
    var param_912: vec3<f32>;
    var param_913: f32;
    var param_914: vec3<i32>;
    var param_915: u32;
    var param_916: u32;
    var param_917: vec3<i32>;
    var param_918: vec3<f32>;
    var param_919: f32;
    var param_920: vec3<i32>;
    var param_921: u32;
    var param_922: u32;
    var param_923: vec3<i32>;
    var param_924: vec3<f32>;
    var param_925: f32;
    var param_926: vec3<i32>;
    var param_927: u32;
    var param_928: u32;
    var param_929: vec3<i32>;
    var param_930: vec3<f32>;
    var param_931: f32;
    var param_932: vec3<i32>;
    var param_933: u32;
    var param_934: u32;
    var param_935: vec3<i32>;
    var param_936: vec3<f32>;
    var param_937: f32;
    var param_938: vec3<i32>;
    var param_939: u32;
    var param_940: u32;
    var param_941: vec3<i32>;
    var param_942: u32;
    var param_943: u32;
    var param_944: u32;
    var param_945: u32;
    var param_946: u32;
    var param_947: u32;
    var phi_2179_: bool;

    let _e293 = (*rawValue_12);
    param_894 = _e293;
    let _e294 = getType_u0028_u1_u003b((&param_894));
    type_37 = _e294;
    let _e295 = (*rawValue_12);
    param_895 = _e295;
    let _e296 = getSleep_u0028_u1_u003b((&param_895));
    sleep_1 = _e296;
    let _e297 = (*slot);
    unnamed_2.blackHoleStarve[_e297] = 0u;
    let _e300 = (*dist_1);
    let _e301 = (*level_1);
    param_896 = _e301;
    let _e302 = bhBodyRadius_u0028_u1_u003b((&param_896));
    let _e304 = tuning.blackHoleHorizon;
    if (_e300 <= (_e302 + f32(_e304))) {
        let _e308 = (*currentIndex_14);
        let _e311 = (*rawValue_12);
        let _e312 = atomicCompareExchangeWeak((&unnamed.grid[_e308]), _e311, 0u);
        let _e314 = (*rawValue_12);
        if (_e312.old_value == _e314) {
            let _e316 = (*slot);
            let _e319 = atomicLoad((&unnamed_2.blackHoles[_e316]));
            param_897 = _e319;
            let _e320 = bhIsPurge_u0028_u1_u003b((&param_897));
            if !(_e320) {
                let _e322 = (*slot);
                let _e325 = atomicAdd((&unnamed_2.blackHoleMass[_e322]), 1u);
            }
            let _e326 = type_37;
            if (_e326 == 2u) {
                decWater_u0028_();
            }
        }
        return;
    }
    let _e328 = (*purge);
    if _e328 {
        let _e330 = tuning.purgeOrbitSpeed;
        local_28 = _e330;
    } else {
        let _e332 = tuning.blackHoleOrbitSpeed;
        local_28 = _e332;
    }
    let _e333 = local_28;
    orbitSpeed = _e333;
    let _e334 = (*purge);
    if _e334 {
        let _e336 = tuning.purgeInfall;
        local_29 = _e336;
    } else {
        let _e338 = tuning.blackHoleInfall;
        local_29 = _e338;
    }
    let _e339 = local_29;
    infallChance = _e339;
    let _e340 = (*randVal_13);
    let _e341 = orbitSpeed;
    let _e342 = (*dist_1);
    if (_e340 > clamp((_e341 / sqrt(max(_e342, 1f))), 0f, 1f)) {
        let _e348 = sleep_1;
        if (_e348 != 0u) {
            let _e350 = (*currentIndex_14);
            let _e353 = (*rawValue_12);
            let _e354 = (*rawValue_12);
            param_898 = _e354;
            let _e355 = getDir_u0028_u1_u003b((&param_898));
            let _e356 = (*rawValue_12);
            param_899 = _e356;
            let _e357 = getAge_u0028_u1_u003b((&param_899));
            let _e358 = type_37;
            param_900 = _e358;
            param_901 = _e355;
            param_902 = 0u;
            param_903 = _e357;
            let _e359 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_900), (&param_901), (&param_902), (&param_903));
            let _e360 = atomicCompareExchangeWeak((&unnamed.grid[_e350]), _e353, _e359);
        }
        return;
    }
    let _e362 = (*center_1);
    let _e363 = (*pos_20);
    inward = normalize(vec3<f32>((_e362 - _e363)));
    let _e367 = (*center_1);
    param_904 = _e367;
    let _e368 = (*pos_20);
    param_905 = _e368;
    let _e369 = bhOrbitAxis_u0028_vi3_u003b_vi3_u003b((&param_904), (&param_905));
    axis = _e369;
    let _e370 = axis;
    let _e371 = inward;
    tangent = cross(_e370, _e371);
    let _e373 = tangent;
    tangentLen = length(_e373);
    let _e375 = tangentLen;
    if (_e375 < 0.05f) {
        let _e377 = axis;
        tangent = normalize(cross(_e377, vec3<f32>(0.577f, 0.577f, 0.577f)));
    } else {
        let _e380 = tangentLen;
        let _e381 = tangent;
        tangent = (_e381 / vec3(_e380));
    }
    let _e384 = (*pos_20);
    let _e385 = (*center_1);
    let _e388 = axis;
    axial = dot(vec3<f32>((_e384 - _e385)), _e388);
    let _e390 = axis;
    let _e392 = axial;
    let _e397 = tuning.blackHolePlaneGrip;
    grip = ((-(_e390) * clamp((_e392 * 0.5f), -1f, 1f)) * _e397);
    let _e399 = tangent;
    let _e400 = grip;
    along = normalize((_e399 + _e400));
    let _e403 = (*randVal_13);
    let _e406 = infallChance;
    pullIn = (fract((_e403 * 61f)) < clamp(_e406, 0f, 1f));
    let _e409 = inward;
    let _e410 = tangent;
    spiral = normalize((_e409 + (_e410 * 0.6f)));
    let _e414 = pullIn;
    phi_2179_ = _e414;
    if _e414 {
        let _e415 = spiral;
        param_906 = _e415;
        param_907 = 0.55f;
        let _e416 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_906), (&param_907));
        let _e417 = (*pos_20);
        param_908 = _e417;
        let _e418 = (*currentIndex_14);
        param_909 = _e418;
        let _e419 = (*rawValue_12);
        param_910 = _e419;
        param_911 = _e416;
        let _e420 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_908), (&param_909), (&param_910), (&param_911));
        phi_2179_ = _e420;
    }
    let _e422 = phi_2179_;
    if _e422 {
        return;
    }
    let _e423 = along;
    param_912 = _e423;
    param_913 = 0.55f;
    let _e424 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_912), (&param_913));
    let _e425 = (*pos_20);
    param_914 = _e425;
    let _e426 = (*currentIndex_14);
    param_915 = _e426;
    let _e427 = (*rawValue_12);
    param_916 = _e427;
    param_917 = _e424;
    let _e428 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_914), (&param_915), (&param_916), (&param_917));
    if _e428 {
        return;
    }
    let _e429 = along;
    param_918 = _e429;
    param_919 = 1f;
    let _e430 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_918), (&param_919));
    let _e431 = (*pos_20);
    param_920 = _e431;
    let _e432 = (*currentIndex_14);
    param_921 = _e432;
    let _e433 = (*rawValue_12);
    param_922 = _e433;
    param_923 = _e430;
    let _e434 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_920), (&param_921), (&param_922), (&param_923));
    if _e434 {
        return;
    }
    let _e435 = tangent;
    param_924 = _e435;
    param_925 = 1f;
    let _e436 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_924), (&param_925));
    let _e437 = (*pos_20);
    param_926 = _e437;
    let _e438 = (*currentIndex_14);
    param_927 = _e438;
    let _e439 = (*rawValue_12);
    param_928 = _e439;
    param_929 = _e436;
    let _e440 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_926), (&param_927), (&param_928), (&param_929));
    if _e440 {
        return;
    }
    let _e441 = inward;
    param_930 = _e441;
    param_931 = 0.55f;
    let _e442 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_930), (&param_931));
    let _e443 = (*pos_20);
    param_932 = _e443;
    let _e444 = (*currentIndex_14);
    param_933 = _e444;
    let _e445 = (*rawValue_12);
    param_934 = _e445;
    param_935 = _e442;
    let _e446 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_932), (&param_933), (&param_934), (&param_935));
    if _e446 {
        return;
    }
    let _e447 = inward;
    param_936 = _e447;
    param_937 = 1f;
    let _e448 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_936), (&param_937));
    let _e449 = (*pos_20);
    param_938 = _e449;
    let _e450 = (*currentIndex_14);
    param_939 = _e450;
    let _e451 = (*rawValue_12);
    param_940 = _e451;
    param_941 = _e448;
    let _e452 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_938), (&param_939), (&param_940), (&param_941));
    if _e452 {
        return;
    }
    let _e453 = sleep_1;
    if (_e453 != 0u) {
        let _e455 = (*currentIndex_14);
        let _e458 = (*rawValue_12);
        let _e459 = (*rawValue_12);
        param_942 = _e459;
        let _e460 = getDir_u0028_u1_u003b((&param_942));
        let _e461 = (*rawValue_12);
        param_943 = _e461;
        let _e462 = getAge_u0028_u1_u003b((&param_943));
        let _e463 = type_37;
        param_944 = _e463;
        param_945 = _e460;
        param_946 = 0u;
        param_947 = _e462;
        let _e464 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_944), (&param_945), (&param_946), (&param_947));
        let _e465 = atomicCompareExchangeWeak((&unnamed.grid[_e455]), _e458, _e464);
    }
    return;
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_2: u32;
    var l: u32;
    var r_5: f32;
    var param_948: u32;
    var volume: f32;

    level_2 = 0u;
    l = 1u;
    loop {
        let _e221 = l;
        let _e223 = tuning.blackHoleMaxLevel;
        if (_e221 <= min(_e223, 16u)) {
            let _e226 = l;
            param_948 = _e226;
            let _e227 = bhBodyRadius_u0028_u1_u003b((&param_948));
            r_5 = _e227;
            let _e228 = r_5;
            let _e230 = r_5;
            let _e232 = r_5;
            volume = (((4.18879f * _e228) * _e230) * _e232);
            let _e234 = (*mass);
            let _e237 = tuning.blackHoleGrowthCost;
            let _e238 = volume;
            if (f32(_e234) < (_e237 * _e238)) {
                break;
            }
            let _e241 = l;
            level_2 = _e241;
            continue;
        } else {
            break;
        }
        continuing {
            let _e242 = l;
            l = (_e242 + bitcast<u32>(1i));
        }
    }
    let _e245 = level_2;
    return _e245;
}

fn bhLevelFor_u0028_u1_u003b_u1_u003b(code_1: ptr<function, u32>, mass_1: ptr<function, u32>) -> u32 {
    var param_949: u32;
    var param_950: u32;

    let _e219 = (*code_1);
    param_949 = _e219;
    let _e220 = bhIsPurge_u0028_u1_u003b((&param_949));
    if _e220 {
        let _e222 = tuning.purgeLevel;
        let _e224 = (*mass_1);
        let _e227 = tuning.purgeMass;
        return u32((f32(_e222) * clamp((f32(_e224) / f32(max(_e227, 1u))), 0f, 1f)));
    }
    let _e234 = (*mass_1);
    param_950 = _e234;
    let _e235 = bhLevel_u0028_u1_u003b((&param_950));
    return _e235;
}

fn bhDecode_u0028_u1_u003b(code_2: ptr<function, u32>) -> vec3<i32> {
    var i_26: u32;

    let _e217 = (*code_2);
    i_26 = (_e217 & 1073741823u);
    let _e219 = i_26;
    let _e221 = tuning.gridWidth;
    let _e226 = i_26;
    let _e228 = tuning.gridWidth;
    let _e233 = tuning.gridHeight;
    let _e238 = i_26;
    let _e240 = tuning.gridWidth;
    let _e243 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e219 % bitcast<u32>(bitcast<i32>(_e221)))), bitcast<i32>(((_e226 / bitcast<u32>(bitcast<i32>(_e228))) % bitcast<u32>(bitcast<i32>(_e233)))), bitcast<i32>((_e238 / bitcast<u32>((bitcast<i32>(_e240) * bitcast<i32>(_e243))))));
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
    var param_951: u32;
    var d_23: vec3<f32>;
    var distSq: f32;
    var purge_1: bool;
    var param_952: u32;
    var level_3: u32;
    var param_953: u32;
    var param_954: u32;
    var radius: f32;
    var local_30: f32;
    var param_955: vec3<i32>;
    var param_956: u32;
    var param_957: u32;
    var param_958: vec3<i32>;
    var param_959: i32;
    var param_960: u32;
    var param_961: bool;
    var param_962: f32;
    var param_963: f32;

    let _e249 = unnamed_2.blackHoleCount;
    if (_e249 == 0u) {
        return false;
    }
    bestDistSq = 3000000000f;
    bestCenter = vec3<i32>(0i, 0i, 0i);
    bestSlot = -1i;
    bestLevel = 0u;
    bestPurge = false;
    let _e252 = tuning.blackHoleRadius;
    let _e254 = tuning.blackHoleMaxLevel;
    maxRadius = f32((_e252 + min(_e254, 16u)));
    let _e258 = maxRadius;
    let _e259 = maxRadius;
    maxRadiusSq = (_e258 * _e259);
    i_27 = 0i;
    loop {
        let _e261 = i_27;
        if (_e261 < 8i) {
            let _e263 = i_27;
            let _e266 = atomicLoad((&unnamed_2.blackHoles[_e263]));
            code_3 = _e266;
            let _e267 = code_3;
            if (_e267 == 0u) {
                continue;
            }
            let _e269 = code_3;
            param_951 = _e269;
            let _e270 = bhDecode_u0028_u1_u003b((&param_951));
            center_2 = _e270;
            let _e271 = center_2;
            let _e272 = (*pos_21);
            d_23 = vec3<f32>((_e271 - _e272));
            let _e275 = d_23;
            let _e276 = d_23;
            distSq = dot(_e275, _e276);
            let _e278 = code_3;
            param_952 = _e278;
            let _e279 = bhIsPurge_u0028_u1_u003b((&param_952));
            purge_1 = _e279;
            let _e280 = purge_1;
            let _e282 = distSq;
            let _e283 = maxRadiusSq;
            if (!(_e280) && (_e282 > _e283)) {
                continue;
            }
            let _e286 = distSq;
            let _e287 = bestDistSq;
            if (_e286 >= _e287) {
                continue;
            }
            let _e289 = i_27;
            let _e290 = code_3;
            param_953 = _e290;
            let _e293 = atomicLoad((&unnamed_2.blackHoleMass[_e289]));
            param_954 = _e293;
            let _e294 = bhLevelFor_u0028_u1_u003b_u1_u003b((&param_953), (&param_954));
            level_3 = _e294;
            let _e295 = purge_1;
            if _e295 {
                local_30 = 1000000000f;
            } else {
                let _e297 = tuning.blackHoleRadius;
                let _e298 = level_3;
                local_30 = f32((_e297 + _e298));
            }
            let _e301 = local_30;
            radius = _e301;
            let _e302 = distSq;
            let _e303 = radius;
            let _e304 = radius;
            if (_e302 <= (_e303 * _e304)) {
                let _e307 = distSq;
                bestDistSq = _e307;
                let _e308 = center_2;
                bestCenter = _e308;
                let _e309 = i_27;
                bestSlot = _e309;
                let _e310 = level_3;
                bestLevel = _e310;
                let _e311 = purge_1;
                bestPurge = _e311;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e312 = i_27;
            i_27 = (_e312 + 1i);
        }
    }
    let _e314 = bestSlot;
    if (_e314 < 0i) {
        return false;
    }
    let _e316 = bestDistSq;
    let _e318 = (*pos_21);
    param_955 = _e318;
    let _e319 = (*currentIndex_15);
    param_956 = _e319;
    let _e320 = (*rawValue_13);
    param_957 = _e320;
    let _e321 = bestCenter;
    param_958 = _e321;
    let _e322 = bestSlot;
    param_959 = _e322;
    let _e323 = bestLevel;
    param_960 = _e323;
    let _e324 = bestPurge;
    param_961 = _e324;
    param_962 = sqrt(_e316);
    let _e325 = (*randVal_14);
    param_963 = _e325;
    updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b((&param_955), (&param_956), (&param_957), (&param_958), (&param_959), (&param_960), (&param_961), (&param_962), (&param_963));
    return true;
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x_4: ptr<function, i32>, z_5: ptr<function, i32>) -> u32 {
    let _e217 = (*x_4);
    let _e218 = (*z_5);
    let _e220 = tuning.gridWidth;
    return (bitcast<u32>((_e217 + (_e218 * bitcast<i32>(_e220)))) * 4u);
}

fn bhRegister_u0028_vi3_u003b(p_5: ptr<function, vec3<i32>>) -> bool {
    var code_4: u32;
    var param_964: vec3<i32>;
    var i_28: i32;

    let _e219 = (*p_5);
    param_964 = _e219;
    let _e220 = getIndex_u0028_vi3_u003b((&param_964));
    code_4 = (2147483648u | _e220);
    i_28 = 0i;
    loop {
        let _e222 = i_28;
        if (_e222 < 8i) {
            let _e224 = i_28;
            let _e227 = code_4;
            let _e228 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e224]), 0u, _e227);
            if (_e228.old_value == 0u) {
                let _e231 = i_28;
                atomicStore((&unnamed_2.blackHoleMass[_e231]), 0u);
                let _e234 = i_28;
                unnamed_2.blackHoleStarve[_e234] = 0u;
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e237 = i_28;
            i_28 = (_e237 + 1i);
        }
    }
    return false;
}

fn writeCell_u0028_u1_u003b_u1_u003b(index_1: ptr<function, u32>, value_2: ptr<function, u32>) {
    let _e217 = (*index_1);
    let _e218 = (*value_2);
    atomicStore((&unnamed.grid[_e217]), _e218);
    return;
}

fn lavaSpawnCoolness_u0028_u1_u003b(type_38: ptr<function, u32>) -> u32 {
    var param_965: u32;

    let _e217 = (*type_38);
    if (_e217 == 12u) {
        let _e219 = lavaSolidifyCoolness_u0028_();
        return _e219;
    }
    let _e220 = (*type_38);
    param_965 = _e220;
    let _e221 = isLava_u0028_u1_u003b((&param_965));
    if _e221 {
        let _e222 = (*type_38);
        let _e225 = tuning.lavaStageSize;
        return ((_e222 - 8u) * max(_e225, 1u));
    }
    return 0u;
}

fn locustSpawnCount_u0028_u1_u003b(type_39: ptr<function, u32>) -> u32 {
    var param_966: u32;

    let _e217 = (*type_39);
    param_966 = _e217;
    let _e218 = isLocust_u0028_u1_u003b((&param_966));
    if !(_e218) {
        return 0u;
    }
    let _e220 = (*type_39);
    let _e223 = locustStage_u0028_();
    let _e225 = locustMaxCount_u0028_();
    return min((((_e220 - 13u) + 1u) * _e223), _e225);
}

fn bhRelease_u0028_vi3_u003b(p_6: ptr<function, vec3<i32>>) {
    var code_5: u32;
    var param_967: vec3<i32>;
    var i_29: i32;

    let _e219 = (*p_6);
    param_967 = _e219;
    let _e220 = getIndex_u0028_vi3_u003b((&param_967));
    code_5 = (2147483648u | _e220);
    i_29 = 0i;
    loop {
        let _e222 = i_29;
        if (_e222 < 8i) {
            let _e224 = i_29;
            let _e227 = code_5;
            let _e228 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e224]), _e227, 0u);
            continue;
        } else {
            break;
        }
        continuing {
            let _e230 = i_29;
            i_29 = (_e230 + 1i);
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
    var phi_1641_: bool;
    var phi_1663_: bool;
    var phi_1684_: bool;

    let _e222 = pc.spawnSize;
    halfMin = (_e222 / 2i);
    let _e225 = pc.spawnSize;
    halfMax = ((_e225 - 1i) / 2i);
    let _e229 = (*pos_22)[0u];
    let _e231 = pc.spawnX;
    let _e232 = halfMin;
    let _e234 = (_e229 < (_e231 - _e232));
    phi_1641_ = _e234;
    if !(_e234) {
        let _e237 = (*pos_22)[0u];
        let _e239 = pc.spawnX;
        let _e240 = halfMax;
        phi_1641_ = (_e237 > (_e239 + _e240));
    }
    let _e244 = phi_1641_;
    if _e244 {
        return false;
    }
    let _e246 = (*pos_22)[1u];
    let _e248 = pc.spawnY;
    let _e249 = halfMin;
    let _e251 = (_e246 < (_e248 - _e249));
    phi_1663_ = _e251;
    if !(_e251) {
        let _e254 = (*pos_22)[1u];
        let _e256 = pc.spawnY;
        let _e257 = halfMax;
        phi_1663_ = (_e254 > (_e256 + _e257));
    }
    let _e261 = phi_1663_;
    if _e261 {
        return false;
    }
    let _e263 = (*pos_22)[2u];
    let _e265 = pc.spawnZ;
    let _e266 = halfMin;
    let _e268 = (_e263 < (_e265 - _e266));
    phi_1684_ = _e268;
    if !(_e268) {
        let _e271 = (*pos_22)[2u];
        let _e273 = pc.spawnZ;
        let _e274 = halfMax;
        phi_1684_ = (_e271 > (_e273 + _e274));
    }
    let _e278 = phi_1684_;
    if _e278 {
        return false;
    }
    let _e280 = pc.spawnShape;
    if (_e280 != 1i) {
        return true;
    }
    let _e283 = pc.spawnX;
    let _e286 = pc.spawnY;
    let _e289 = pc.spawnZ;
    let _e292 = halfMax;
    let _e293 = halfMin;
    center_3 = (vec3<f32>(f32(_e283), f32(_e286), f32(_e289)) + vec3((f32(((_e292 - _e293) + 1i)) * 0.5f)));
    let _e300 = (*pos_22);
    let _e304 = center_3;
    d_24 = ((vec3<f32>(_e300) + vec3(0.5f)) - _e304);
    let _e307 = pc.spawnSize;
    radius_1 = (f32(_e307) * 0.5f);
    let _e310 = d_24;
    let _e311 = d_24;
    let _e313 = radius_1;
    let _e314 = radius_1;
    return (dot(_e310, _e311) <= (_e313 * _e314));
}

fn tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(fromIndex: ptr<function, u32>, newValue_4: ptr<function, u32>, toIndex: ptr<function, u32>, expectedFromValue: ptr<function, u32>) -> bool {
    let _e219 = (*toIndex);
    let _e222 = (*newValue_4);
    let _e223 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e219]), 0u, _e222);
    if (_e223.old_value != 0u) {
        return false;
    }
    let _e226 = (*fromIndex);
    let _e229 = (*expectedFromValue);
    let _e230 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e226]), _e229, 0u);
    let _e232 = (*expectedFromValue);
    if (_e230.old_value != _e232) {
        let _e234 = (*toIndex);
        let _e237 = atomicExchange((&unnamed_1.cloudCells[_e234]), 0u);
        return false;
    }
    return true;
}

fn getCloudCounter_u0028_u1_u003b(v_5: ptr<function, u32>) -> u32 {
    let _e216 = (*v_5);
    return ((_e216 >> bitcast<u32>(3i)) & 2047u);
}

fn getCloudTarget_u0028_u1_u003b(v_6: ptr<function, u32>) -> u32 {
    let _e216 = (*v_6);
    return ((_e216 >> bitcast<u32>(14i)) & 2047u);
}

fn easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b(current: ptr<function, u32>, target_5: ptr<function, f32>, rate: ptr<function, f32>) -> u32 {
    var old: f32;
    var next: f32;

    let _e220 = (*current);
    old = f32(_e220);
    let _e222 = old;
    let _e223 = (*target_5);
    let _e224 = old;
    let _e226 = (*rate);
    next = (_e222 + ((_e223 - _e224) * _e226));
    let _e229 = (*target_5);
    let _e230 = old;
    if (_e229 > _e230) {
        let _e232 = next;
        let _e233 = old;
        let _e236 = old;
        let _e237 = (*target_5);
        next = clamp(max(_e232, (_e233 + 1f)), _e236, _e237);
    } else {
        let _e239 = (*target_5);
        let _e240 = old;
        if (_e239 < _e240) {
            let _e242 = next;
            let _e243 = old;
            let _e246 = (*target_5);
            let _e247 = old;
            next = clamp(min(_e242, (_e243 - 1f)), _e246, _e247);
        }
    }
    let _e249 = next;
    return u32(max(_e249, 0f));
}

fn updateCloudBlock_u0028_vi3_u003b(pos_23: ptr<function, vec3<i32>>) {
    var idx_4: u32;
    var param_968: vec3<i32>;
    var base: u32;
    var param_969: i32;
    var param_970: i32;
    var rate_1: f32;
    var tallied: u32;
    var param_971: u32;
    var param_972: f32;
    var param_973: f32;
    var param_974: u32;
    var param_975: f32;
    var param_976: f32;
    var cell: u32;
    var kind_1: u32;
    var param_977: u32;
    var param_978: vec3<i32>;
    var newCell: u32;
    var param_979: u32;
    var param_980: bool;
    var param_981: u32;
    var param_982: u32;
    var param_983: u32;
    var param_984: u32;
    var param_985: bool;
    var param_986: u32;
    var param_987: u32;
    var target_6: u32;
    var param_988: u32;
    var lo_1: u32;
    var hi_1: u32;
    var r_6: f32;
    var param_989: vec3<f32>;
    var param_990: u32;
    var param_991: bool;
    var param_992: u32;
    var param_993: u32;
    var counter_1: u32;
    var param_994: u32;
    var param_995: u32;
    var param_996: bool;
    var param_997: u32;
    var param_998: u32;
    var param_999: vec3<i32>;
    var g: u32;
    var param_1000: u32;
    var param_1001: u32;
    var param_1002: u32;
    var param_1003: u32;
    var param_1004: u32;
    var param_1005: u32;
    var randVal_15: f32;
    var param_1006: vec3<f32>;
    var counter_2: u32;
    var param_1007: u32;
    var target_7: u32;
    var param_1008: u32;
    var upPos_2: vec3<i32>;
    var param_1009: vec3<i32>;
    var param_1010: vec3<i32>;
    var param_1011: u32;
    var param_1012: u32;
    var param_1013: bool;
    var param_1014: u32;
    var param_1015: u32;
    var param_1016: vec3<i32>;
    var param_1017: u32;
    var param_1018: u32;
    var param_1019: u32;
    var param_1020: u32;
    var dir_8: i32;
    var slide1_: vec3<i32>;
    var slide2_: vec3<i32>;
    var i_30: i32;
    var t_5: vec3<i32>;
    var param_1021: vec3<i32>;
    var tIndex: u32;
    var param_1022: vec3<i32>;
    var param_1023: u32;
    var param_1024: u32;
    var param_1025: bool;
    var param_1026: u32;
    var param_1027: u32;
    var param_1028: u32;
    var param_1029: u32;
    var param_1030: u32;
    var param_1031: u32;
    var param_1032: u32;
    var param_1033: u32;
    var param_1034: bool;
    var param_1035: u32;
    var param_1036: u32;
    var phi_9563_: bool;
    var phi_9564_: bool;
    var phi_9772_: bool;

    let _e308 = (*pos_23);
    param_968 = _e308;
    let _e309 = getIndex_u0028_vi3_u003b((&param_968));
    idx_4 = _e309;
    let _e311 = (*pos_23)[0u];
    param_969 = _e311;
    let _e313 = (*pos_23)[2u];
    param_970 = _e313;
    let _e314 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_969), (&param_970));
    base = _e314;
    let _e316 = (*pos_23)[1u];
    if (_e316 == 0i) {
        let _e319 = tuning.cloudSmoothRate;
        rate_1 = clamp(_e319, 0.01f, 1f);
        let _e321 = base;
        let _e325 = atomicLoad((&unnamed_2.cloudColumn[(_e321 + 0u)]));
        tallied = _e325;
        let _e326 = base;
        let _e328 = base;
        let _e330 = tallied;
        let _e335 = atomicLoad((&unnamed_2.cloudColumn[(_e328 + 2u)]));
        param_971 = _e335;
        param_972 = (f32(_e330) * 16f);
        let _e336 = rate_1;
        param_973 = _e336;
        let _e337 = easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b((&param_971), (&param_972), (&param_973));
        atomicStore((&unnamed_2.cloudColumn[(_e326 + 2u)]), _e337);
        let _e340 = tallied;
        if (_e340 > 0u) {
            let _e342 = base;
            let _e344 = base;
            let _e346 = base;
            let _e350 = atomicLoad((&unnamed_2.cloudColumn[(_e346 + 1u)]));
            let _e355 = atomicLoad((&unnamed_2.cloudColumn[(_e344 + 3u)]));
            param_974 = _e355;
            param_975 = (f32(_e350) * 16f);
            let _e356 = rate_1;
            param_976 = _e356;
            let _e357 = easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b((&param_974), (&param_975), (&param_976));
            atomicStore((&unnamed_2.cloudColumn[(_e342 + 3u)]), _e357);
        }
        let _e360 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e360 + 0u)]), 0u);
        let _e364 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e364 + 1u)]), 0u);
    }
    let _e368 = idx_4;
    let _e371 = atomicLoad((&unnamed_1.cloudCells[_e368]));
    cell = _e371;
    let _e372 = cell;
    param_977 = _e372;
    let _e373 = getCloudKind_u0028_u1_u003b((&param_977));
    kind_1 = _e373;
    let _e374 = kind_1;
    if (_e374 == 0u) {
        return;
    }
    let _e377 = atomicAdd((&unnamed_2.cloudBlockCount), 1u);
    let _e378 = base;
    let _e382 = atomicAdd((&unnamed_2.cloudColumn[(_e378 + 0u)]), 1u);
    let _e383 = base;
    let _e388 = (*pos_23)[1u];
    let _e390 = atomicMax((&unnamed_2.cloudColumn[(_e383 + 1u)]), bitcast<u32>(_e388));
    let _e393 = (*pos_23)[1u];
    let _e395 = atomicMin((&unnamed_2.cloudMinYAcc), bitcast<u32>(_e393));
    let _e398 = (*pos_23)[1u];
    let _e400 = atomicMax((&unnamed_2.cloudMaxYAcc), bitcast<u32>(_e398));
    let _e401 = kind_1;
    let _e402 = (_e401 == 1u);
    phi_9564_ = _e402;
    if _e402 {
        let _e404 = unnamed_2.rainPhase;
        let _e405 = (_e404 == 2u);
        phi_9563_ = _e405;
        if !(_e405) {
            let _e407 = (*pos_23);
            param_978 = _e407;
            let _e408 = cloudTouchesRain_u0028_vi3_u003b((&param_978));
            phi_9563_ = _e408;
        }
        let _e410 = phi_9563_;
        phi_9564_ = _e410;
    }
    let _e412 = phi_9564_;
    if _e412 {
        param_979 = 2u;
        param_980 = false;
        param_981 = 0u;
        param_982 = 0u;
        let _e413 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_979), (&param_980), (&param_981), (&param_982));
        newCell = _e413;
        let _e414 = idx_4;
        let _e417 = cell;
        let _e418 = newCell;
        let _e419 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e414]), _e417, _e418);
        let _e421 = cell;
        if (_e419.old_value != _e421) {
            return;
        }
        let _e423 = newCell;
        cell = _e423;
        kind_1 = 2u;
    }
    let _e425 = (*pos_23)[1u];
    let _e427 = tuning.gridHeight;
    if (_e425 >= (bitcast<i32>(_e427) - 2i)) {
        let _e431 = kind_1;
        if (_e431 != 2u) {
            let _e433 = cell;
            param_983 = _e433;
            let _e434 = getCloudMoved_u0028_u1_u003b((&param_983));
            if _e434 {
                let _e435 = idx_4;
                let _e438 = cell;
                let _e439 = kind_1;
                param_984 = _e439;
                param_985 = false;
                param_986 = 0u;
                param_987 = 0u;
                let _e440 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_984), (&param_985), (&param_986), (&param_987));
                let _e441 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e435]), _e438, _e440);
            }
            return;
        }
        let _e443 = cell;
        param_988 = _e443;
        let _e444 = getCloudTarget_u0028_u1_u003b((&param_988));
        target_6 = _e444;
        let _e445 = target_6;
        if (_e445 == 0u) {
            let _e448 = tuning.rainWaitMinTicks;
            let _e450 = tuning.rainWaitMaxTicks;
            lo_1 = min(_e448, _e450);
            let _e453 = tuning.rainWaitMinTicks;
            let _e455 = tuning.rainWaitMaxTicks;
            hi_1 = max(_e453, _e455);
            let _e457 = (*pos_23);
            let _e460 = pc.time;
            param_989 = (vec3<f32>(_e457) + vec3<f32>(_e460, 17f, 3f));
            let _e463 = hash_u0028_vf3_u003b((&param_989));
            r_6 = _e463;
            let _e464 = lo_1;
            let _e465 = r_6;
            let _e466 = hi_1;
            let _e467 = lo_1;
            target_6 = (_e464 + u32((_e465 * f32(((_e466 - _e467) + 1u)))));
            let _e474 = idx_4;
            let _e477 = cell;
            param_990 = 2u;
            param_991 = false;
            param_992 = 0u;
            let _e478 = target_6;
            param_993 = _e478;
            let _e479 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_990), (&param_991), (&param_992), (&param_993));
            let _e480 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e474]), _e477, _e479);
            return;
        }
        let _e482 = cell;
        param_994 = _e482;
        let _e483 = getCloudCounter_u0028_u1_u003b((&param_994));
        counter_1 = _e483;
        let _e484 = counter_1;
        let _e485 = target_6;
        if (_e484 < _e485) {
            let _e487 = idx_4;
            let _e490 = cell;
            let _e491 = counter_1;
            param_995 = 2u;
            param_996 = false;
            param_997 = (_e491 + 1u);
            let _e493 = target_6;
            param_998 = _e493;
            let _e494 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_995), (&param_996), (&param_997), (&param_998));
            let _e495 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e487]), _e490, _e494);
            return;
        }
        let _e497 = (*pos_23);
        param_999 = _e497;
        let _e498 = cloudCellInBounds_u0028_vi3_u003b((&param_999));
        if !(_e498) {
            return;
        }
        let _e500 = idx_4;
        param_1000 = _e500;
        let _e501 = readCell_u0028_u1_u003b((&param_1000));
        g = _e501;
        let _e502 = g;
        param_1001 = _e502;
        let _e503 = getType_u0028_u1_u003b((&param_1001));
        if (_e503 != 0u) {
            return;
        }
        let _e505 = idx_4;
        let _e508 = g;
        param_1002 = 2u;
        param_1003 = 0u;
        param_1004 = 0u;
        param_1005 = 0u;
        let _e509 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_1002), (&param_1003), (&param_1004), (&param_1005));
        let _e510 = atomicCompareExchangeWeak((&unnamed.grid[_e505]), _e508, _e509);
        let _e512 = g;
        if (_e510.old_value != _e512) {
            return;
        }
        let _e514 = idx_4;
        let _e517 = atomicExchange((&unnamed_1.cloudCells[_e514]), 0u);
        incWater_u0028_();
        let _e519 = (*pos_23)[1u];
        let _e522 = atomicLoad((&unnamed_2.maxOccupiedY));
        if (bitcast<u32>(_e519) > _e522) {
            let _e526 = (*pos_23)[1u];
            let _e528 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e526));
        }
        return;
    }
    let _e529 = (*pos_23);
    let _e532 = pc.time;
    param_1006 = (vec3<f32>(_e529) + vec3<f32>((_e532 * 2.3f), 7f, 13f));
    let _e536 = hash_u0028_vf3_u003b((&param_1006));
    randVal_15 = _e536;
    let _e537 = cell;
    param_1007 = _e537;
    let _e538 = getCloudCounter_u0028_u1_u003b((&param_1007));
    counter_2 = _e538;
    let _e539 = cell;
    param_1008 = _e539;
    let _e540 = getCloudTarget_u0028_u1_u003b((&param_1008));
    target_7 = _e540;
    let _e541 = (*pos_23);
    upPos_2 = (_e541 + vec3<i32>(0i, 1i, 0i));
    let _e543 = upPos_2;
    param_1009 = _e543;
    let _e544 = cloudCellInBounds_u0028_vi3_u003b((&param_1009));
    phi_9772_ = _e544;
    if _e544 {
        let _e545 = upPos_2;
        param_1010 = _e545;
        let _e546 = getIndex_u0028_vi3_u003b((&param_1010));
        let _e549 = atomicLoad((&unnamed_1.cloudCells[_e546]));
        param_1011 = _e549;
        let _e550 = getCloudKind_u0028_u1_u003b((&param_1011));
        phi_9772_ = (_e550 == 0u);
    }
    let _e553 = phi_9772_;
    if _e553 {
        let _e554 = kind_1;
        param_1012 = _e554;
        param_1013 = true;
        let _e555 = counter_2;
        param_1014 = _e555;
        let _e556 = target_7;
        param_1015 = _e556;
        let _e557 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_1012), (&param_1013), (&param_1014), (&param_1015));
        let _e558 = upPos_2;
        param_1016 = _e558;
        let _e559 = getIndex_u0028_vi3_u003b((&param_1016));
        let _e560 = idx_4;
        param_1017 = _e560;
        param_1018 = _e557;
        param_1019 = _e559;
        let _e561 = cell;
        param_1020 = _e561;
        let _e562 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_1017), (&param_1018), (&param_1019), (&param_1020));
        if _e562 {
            let _e564 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
            return;
        }
    }
    let _e565 = randVal_15;
    dir_8 = select(-1i, 1i, (fract((_e565 * 10f)) > 0.5f));
    let _e570 = randVal_15;
    if (fract((_e570 * 100f)) > 0.5f) {
        let _e574 = (*pos_23);
        let _e575 = dir_8;
        slide1_ = (_e574 + vec3<i32>(_e575, 1i, 0i));
        let _e578 = (*pos_23);
        let _e579 = dir_8;
        slide2_ = (_e578 + vec3<i32>(0i, 1i, _e579));
    } else {
        let _e582 = (*pos_23);
        let _e583 = dir_8;
        slide1_ = (_e582 + vec3<i32>(0i, 1i, _e583));
        let _e586 = (*pos_23);
        let _e587 = dir_8;
        slide2_ = (_e586 + vec3<i32>(_e587, 1i, 0i));
    }
    i_30 = 0i;
    loop {
        let _e590 = i_30;
        if (_e590 < 2i) {
            let _e592 = i_30;
            let _e594 = slide1_;
            let _e595 = slide2_;
            t_5 = select(_e595, _e594, vec3((_e592 == 0i)));
            let _e598 = t_5;
            param_1021 = _e598;
            let _e599 = cloudCellInBounds_u0028_vi3_u003b((&param_1021));
            if !(_e599) {
                continue;
            }
            let _e601 = t_5;
            param_1022 = _e601;
            let _e602 = getIndex_u0028_vi3_u003b((&param_1022));
            tIndex = _e602;
            let _e603 = tIndex;
            let _e606 = atomicLoad((&unnamed_1.cloudCells[_e603]));
            param_1023 = _e606;
            let _e607 = getCloudKind_u0028_u1_u003b((&param_1023));
            if (_e607 != 0u) {
                continue;
            }
            let _e609 = kind_1;
            param_1024 = _e609;
            param_1025 = true;
            let _e610 = counter_2;
            param_1026 = _e610;
            let _e611 = target_7;
            param_1027 = _e611;
            let _e612 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_1024), (&param_1025), (&param_1026), (&param_1027));
            let _e613 = idx_4;
            param_1028 = _e613;
            param_1029 = _e612;
            let _e614 = tIndex;
            param_1030 = _e614;
            let _e615 = cell;
            param_1031 = _e615;
            let _e616 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_1028), (&param_1029), (&param_1030), (&param_1031));
            if _e616 {
                let _e618 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e619 = i_30;
            i_30 = (_e619 + 1i);
        }
    }
    let _e621 = cell;
    param_1032 = _e621;
    let _e622 = getCloudMoved_u0028_u1_u003b((&param_1032));
    if _e622 {
        let _e623 = idx_4;
        let _e626 = cell;
        let _e627 = kind_1;
        param_1033 = _e627;
        param_1034 = false;
        let _e628 = counter_2;
        param_1035 = _e628;
        let _e629 = target_7;
        param_1036 = _e629;
        let _e630 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_1033), (&param_1034), (&param_1035), (&param_1036));
        let _e631 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e623]), _e626, _e630);
    }
    return;
}

fn updateSimState_u0028_() {
    var live: u32;
    var i_31: i32;
    var code_6: u32;
    var voxel: u32;
    var param_1037: u32;
    var param_1038: u32;
    var starve: u32;
    var purge_2: bool;
    var param_1039: u32;
    var grace: u32;
    var local_31: u32;
    var decay: u32;
    var local_32: u32;
    var mass_2: u32;
    var param_1040: u32;
    var param_1041: u32;
    var movedLastTick: u32;
    var liveClouds: u32;
    var chargeTarget: f32;
    var charge: f32;
    var interval: u32;
    var phi_8722_: bool;
    var phi_8729_: bool;

    let _e237 = gl_GlobalInvocationID_1[0u];
    let _e238 = (_e237 != 0u);
    phi_8722_ = _e238;
    if !(_e238) {
        let _e241 = gl_GlobalInvocationID_1[1u];
        phi_8722_ = (_e241 != 0u);
    }
    let _e244 = phi_8722_;
    phi_8729_ = _e244;
    if !(_e244) {
        let _e247 = gl_GlobalInvocationID_1[2u];
        phi_8729_ = (_e247 != 0u);
    }
    let _e250 = phi_8729_;
    if _e250 {
        return;
    }
    live = 0u;
    i_31 = 0i;
    loop {
        let _e251 = i_31;
        if (_e251 < 8i) {
            let _e253 = i_31;
            let _e256 = atomicLoad((&unnamed_2.blackHoles[_e253]));
            code_6 = _e256;
            let _e257 = code_6;
            if (_e257 == 0u) {
                continue;
            }
            let _e259 = code_6;
            voxel = (_e259 & 1073741823u);
            let _e261 = voxel;
            param_1037 = _e261;
            let _e262 = readCell_u0028_u1_u003b((&param_1037));
            param_1038 = _e262;
            let _e263 = getType_u0028_u1_u003b((&param_1038));
            if (_e263 != 7u) {
                let _e265 = i_31;
                atomicStore((&unnamed_2.blackHoles[_e265]), 0u);
                continue;
            }
            let _e268 = i_31;
            let _e271 = unnamed_2.blackHoleStarve[_e268];
            starve = (_e271 + 1u);
            let _e273 = i_31;
            let _e274 = starve;
            unnamed_2.blackHoleStarve[_e273] = _e274;
            let _e277 = code_6;
            param_1039 = _e277;
            let _e278 = bhIsPurge_u0028_u1_u003b((&param_1039));
            purge_2 = _e278;
            let _e279 = purge_2;
            if _e279 {
                let _e281 = tuning.purgeStarveGrace;
                local_31 = _e281;
            } else {
                let _e283 = tuning.blackHoleStarveGrace;
                local_31 = _e283;
            }
            let _e284 = local_31;
            grace = _e284;
            let _e285 = purge_2;
            if _e285 {
                let _e287 = tuning.purgeDecayRate;
                local_32 = _e287;
            } else {
                let _e289 = tuning.blackHoleDecayRate;
                local_32 = _e289;
            }
            let _e290 = local_32;
            decay = _e290;
            let _e291 = starve;
            let _e292 = grace;
            if (_e291 > _e292) {
                let _e294 = i_31;
                let _e297 = atomicLoad((&unnamed_2.blackHoleMass[_e294]));
                mass_2 = _e297;
                let _e298 = mass_2;
                if (_e298 == 0u) {
                    let _e300 = voxel;
                    param_1040 = _e300;
                    param_1041 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_1040), (&param_1041));
                    let _e301 = i_31;
                    atomicStore((&unnamed_2.blackHoles[_e301]), 0u);
                    continue;
                }
                let _e304 = i_31;
                let _e305 = mass_2;
                let _e306 = mass_2;
                let _e307 = decay;
                atomicStore((&unnamed_2.blackHoleMass[_e304]), (_e305 - min(_e306, _e307)));
            }
            let _e312 = live;
            live = (_e312 + bitcast<u32>(1i));
            continue;
        } else {
            break;
        }
        continuing {
            let _e315 = i_31;
            i_31 = (_e315 + 1i);
        }
    }
    let _e317 = live;
    unnamed_2.blackHoleCount = _e317;
    let _e320 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (_e320 > 0u) {
        let _e323 = atomicAdd((&unnamed_2.maxOccupiedY), 4294967295u);
    }
    let _e325 = atomicLoad((&unnamed_2.rainCandidateCount));
    unnamed_2.rainCandidateEstimate = _e325;
    atomicStore((&unnamed_2.rainCandidateCount), 0u);
    let _e329 = unnamed_2.simTick;
    unnamed_2.simTick = (_e329 + 1u);
    let _e333 = atomicLoad((&unnamed_2.cloudMovedCount));
    movedLastTick = _e333;
    let _e335 = atomicLoad((&unnamed_2.cloudBlockCount));
    liveClouds = _e335;
    atomicStore((&unnamed_2.cloudBlockCount), 0u);
    atomicStore((&unnamed_2.cloudMovedCount), 0u);
    let _e339 = atomicLoad((&unnamed_2.cloudMinYAcc));
    unnamed_2.cloudMinY = _e339;
    let _e342 = atomicLoad((&unnamed_2.cloudMaxYAcc));
    unnamed_2.cloudMaxY = _e342;
    atomicStore((&unnamed_2.cloudMinYAcc), 4294967295u);
    atomicStore((&unnamed_2.cloudMaxYAcc), 0u);
    let _e347 = unnamed_2.rainPhase;
    chargeTarget = select(1f, 0f, (_e347 == 0u));
    let _e351 = unnamed_2.cloudChargeBits;
    charge = bitcast<f32>(_e351);
    let _e353 = chargeTarget;
    let _e354 = charge;
    let _e357 = tuning.cloudChargeEaseRate;
    let _e360 = charge;
    charge = (_e360 + ((_e353 - _e354) * clamp(_e357, 0f, 1f)));
    let _e362 = charge;
    unnamed_2.cloudChargeBits = bitcast<u32>(clamp(_e362, 0f, 1f));
    let _e367 = unnamed_2.rainPhase;
    if (_e367 == 0u) {
        let _e370 = tuning.cloudCheckIntervalTicks;
        interval = max(_e370, 1u);
        let _e373 = unnamed_2.simTick;
        let _e374 = interval;
        let _e377 = liveClouds;
        let _e380 = movedLastTick;
        if ((((_e373 % _e374) == 0u) && (_e377 > 0u)) && (_e380 == 0u)) {
            unnamed_2.rainPhase = 2u;
            let _e385 = pc.time;
            unnamed_2.rainPhaseTimeBits = bitcast<u32>(_e385);
            let _e389 = unnamed_2.simTick;
            unnamed_2.lastRainTick = _e389;
        }
    } else {
        let _e391 = liveClouds;
        if (_e391 == 0u) {
            unnamed_2.rainPhase = 0u;
            unnamed_2.rainPhaseTimeBits = 0u;
        }
    }
    return;
}

fn main_1() {
    var pos_24: vec3<i32>;
    var param_1042: vec3<i32>;
    var param_1043: vec3<i32>;
    var spawnIndex: u32;
    var param_1044: vec3<i32>;
    var oldType: u32;
    var param_1045: u32;
    var param_1046: u32;
    var newType_3: u32;
    var param_1047: vec3<i32>;
    var seedAge: u32;
    var param_1048: u32;
    var local_33: u32;
    var param_1049: u32;
    var param_1050: u32;
    var param_1051: u32;
    var param_1052: u32;
    var param_1053: u32;
    var param_1054: u32;
    var param_1055: u32;
    var param_1056: u32;
    var param_1057: vec3<i32>;
    var param_1058: u32;
    var param_1059: u32;
    var currentIndex_16: u32;
    var param_1060: vec3<i32>;
    var rawValue_14: u32;
    var param_1061: u32;
    var currentType_1: u32;
    var param_1062: u32;
    var param_1063: i32;
    var param_1064: i32;
    var randVal_16: f32;
    var param_1065: vec3<f32>;
    var param_1066: vec3<i32>;
    var param_1067: u32;
    var param_1068: u32;
    var param_1069: f32;
    var currentDir_6: u32;
    var param_1070: u32;
    var currentSleep_8: u32;
    var param_1071: u32;
    var currentAge_10: u32;
    var param_1072: u32;
    var param_1073: vec3<i32>;
    var param_1074: u32;
    var param_1075: u32;
    var param_1076: u32;
    var param_1077: u32;
    var param_1078: f32;
    var param_1079: vec3<i32>;
    var param_1080: u32;
    var param_1081: u32;
    var param_1082: u32;
    var param_1083: u32;
    var param_1084: u32;
    var param_1085: f32;
    var param_1086: vec3<i32>;
    var param_1087: u32;
    var param_1088: u32;
    var param_1089: u32;
    var param_1090: u32;
    var param_1091: u32;
    var param_1092: f32;
    var param_1093: vec3<i32>;
    var param_1094: u32;
    var param_1095: u32;
    var param_1096: u32;
    var param_1097: u32;
    var param_1098: u32;
    var param_1099: f32;
    var param_1100: vec3<i32>;
    var param_1101: u32;
    var param_1102: u32;
    var param_1103: u32;
    var param_1104: u32;
    var param_1105: f32;
    var param_1106: vec3<i32>;
    var param_1107: u32;
    var param_1108: u32;
    var param_1109: u32;
    var param_1110: u32;
    var param_1111: u32;
    var param_1112: f32;
    var param_1113: vec3<i32>;
    var param_1114: u32;
    var param_1115: u32;
    var param_1116: u32;
    var param_1117: f32;
    var param_1118: vec3<i32>;
    var param_1119: u32;
    var param_1120: u32;
    var param_1121: u32;
    var param_1122: u32;
    var param_1123: u32;
    var param_1124: f32;
    var param_1125: vec3<i32>;
    var param_1126: u32;
    var param_1127: u32;
    var param_1128: u32;
    var param_1129: u32;
    var param_1130: f32;
    var param_1131: vec3<i32>;
    var param_1132: u32;
    var param_1133: u32;
    var param_1134: u32;
    var param_1135: f32;
    var param_1136: vec3<i32>;
    var param_1137: u32;
    var param_1138: u32;
    var param_1139: u32;
    var param_1140: f32;
    var phi_9922_: bool;
    var phi_9932_: bool;
    var phi_9948_: bool;
    var phi_10047_: bool;
    var phi_10054_: bool;
    var phi_10065_: bool;
    var phi_10072_: bool;
    var phi_10083_: bool;
    var phi_10106_: bool;
    var phi_10116_: bool;
    var phi_10174_: bool;

    let _e327 = gl_GlobalInvocationID_1;
    pos_24 = bitcast<vec3<i32>>(_e327);
    let _e330 = pos_24[0u];
    let _e332 = tuning.gridWidth;
    let _e334 = (_e330 >= bitcast<i32>(_e332));
    phi_9922_ = _e334;
    if !(_e334) {
        let _e337 = pos_24[1u];
        let _e339 = tuning.gridHeight;
        phi_9922_ = (_e337 >= bitcast<i32>(_e339));
    }
    let _e343 = phi_9922_;
    phi_9932_ = _e343;
    if !(_e343) {
        let _e346 = pos_24[2u];
        let _e348 = tuning.gridDepth;
        phi_9932_ = (_e346 >= bitcast<i32>(_e348));
    }
    let _e352 = phi_9932_;
    if _e352 {
        return;
    }
    updateSimState_u0028_();
    let _e353 = pos_24;
    param_1042 = _e353;
    updateCloudBlock_u0028_vi3_u003b((&param_1042));
    let _e355 = pc.spawnActive;
    let _e356 = (_e355 == 1i);
    phi_9948_ = _e356;
    if _e356 {
        let _e357 = pos_24;
        param_1043 = _e357;
        let _e358 = inBrush_u0028_vi3_u003b((&param_1043));
        phi_9948_ = _e358;
    }
    let _e360 = phi_9948_;
    if _e360 {
        let _e361 = pos_24;
        param_1044 = _e361;
        let _e362 = getIndex_u0028_vi3_u003b((&param_1044));
        spawnIndex = _e362;
        let _e363 = spawnIndex;
        param_1045 = _e363;
        let _e364 = readCell_u0028_u1_u003b((&param_1045));
        param_1046 = _e364;
        let _e365 = getType_u0028_u1_u003b((&param_1046));
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
                    param_1047 = _e381;
                    bhRelease_u0028_vi3_u003b((&param_1047));
                }
                let _e382 = newType_3;
                if (_e382 == 2u) {
                    incWater_u0028_();
                }
            }
            let _e384 = newType_3;
            param_1048 = _e384;
            let _e385 = isLocust_u0028_u1_u003b((&param_1048));
            if _e385 {
                let _e386 = newType_3;
                param_1049 = _e386;
                let _e387 = locustSpawnCount_u0028_u1_u003b((&param_1049));
                local_33 = _e387;
            } else {
                let _e388 = newType_3;
                param_1050 = _e388;
                let _e389 = lavaSpawnCoolness_u0028_u1_u003b((&param_1050));
                local_33 = _e389;
            }
            let _e390 = local_33;
            seedAge = _e390;
            let _e391 = newType_3;
            param_1051 = _e391;
            param_1052 = 0u;
            param_1053 = 0u;
            let _e392 = seedAge;
            param_1054 = _e392;
            let _e393 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_1051), (&param_1052), (&param_1053), (&param_1054));
            let _e394 = spawnIndex;
            param_1055 = _e394;
            param_1056 = _e393;
            writeCell_u0028_u1_u003b_u1_u003b((&param_1055), (&param_1056));
            let _e395 = newType_3;
            if (_e395 == 7u) {
                let _e397 = pos_24;
                param_1057 = _e397;
                let _e398 = bhRegister_u0028_vi3_u003b((&param_1057));
                if !(_e398) {
                    let _e400 = spawnIndex;
                    param_1058 = _e400;
                    param_1059 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_1058), (&param_1059));
                }
            }
        }
    }
    let _e402 = pos_24[0u];
    let _e403 = (_e402 < 1i);
    phi_10047_ = _e403;
    if !(_e403) {
        let _e406 = pos_24[0u];
        let _e408 = tuning.gridWidth;
        phi_10047_ = (_e406 >= (bitcast<i32>(_e408) - 1i));
    }
    let _e413 = phi_10047_;
    phi_10054_ = _e413;
    if !(_e413) {
        let _e416 = pos_24[1u];
        phi_10054_ = (_e416 < 1i);
    }
    let _e419 = phi_10054_;
    phi_10065_ = _e419;
    if !(_e419) {
        let _e422 = pos_24[1u];
        let _e424 = tuning.gridHeight;
        phi_10065_ = (_e422 >= (bitcast<i32>(_e424) - 1i));
    }
    let _e429 = phi_10065_;
    phi_10072_ = _e429;
    if !(_e429) {
        let _e432 = pos_24[2u];
        phi_10072_ = (_e432 < 1i);
    }
    let _e435 = phi_10072_;
    phi_10083_ = _e435;
    if !(_e435) {
        let _e438 = pos_24[2u];
        let _e440 = tuning.gridDepth;
        phi_10083_ = (_e438 >= (bitcast<i32>(_e440) - 1i));
    }
    let _e445 = phi_10083_;
    if _e445 {
        return;
    }
    let _e446 = pos_24;
    param_1060 = _e446;
    let _e447 = getIndex_u0028_vi3_u003b((&param_1060));
    currentIndex_16 = _e447;
    let _e448 = currentIndex_16;
    param_1061 = _e448;
    let _e449 = readCell_u0028_u1_u003b((&param_1061));
    rawValue_14 = _e449;
    let _e450 = rawValue_14;
    param_1062 = _e450;
    let _e451 = getType_u0028_u1_u003b((&param_1062));
    currentType_1 = _e451;
    let _e452 = currentType_1;
    let _e453 = (_e452 == 0u);
    phi_10106_ = _e453;
    if _e453 {
        let _e455 = unnamed_2.rainPhase;
        phi_10106_ = (_e455 >= 1u);
    }
    let _e458 = phi_10106_;
    phi_10116_ = _e458;
    if _e458 {
        let _e460 = pos_24[1u];
        let _e462 = tuning.gridHeight;
        phi_10116_ = (_e460 == (bitcast<i32>(_e462) - 2i));
    }
    let _e467 = phi_10116_;
    if _e467 {
        let _e469 = pos_24[0u];
        param_1063 = _e469;
        let _e471 = pos_24[2u];
        param_1064 = _e471;
        let _e472 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_1063), (&param_1064));
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
    param_1065 = (vec3<f32>(_e493) + vec3(_e496));
    let _e499 = hash_u0028_vf3_u003b((&param_1065));
    randVal_16 = _e499;
    let _e500 = currentType_1;
    let _e501 = (_e500 != 7u);
    phi_10174_ = _e501;
    if _e501 {
        let _e502 = pos_24;
        param_1066 = _e502;
        let _e503 = currentIndex_16;
        param_1067 = _e503;
        let _e504 = rawValue_14;
        param_1068 = _e504;
        let _e505 = randVal_16;
        param_1069 = _e505;
        let _e506 = captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1066), (&param_1067), (&param_1068), (&param_1069));
        phi_10174_ = _e506;
    }
    let _e508 = phi_10174_;
    if _e508 {
        return;
    }
    let _e509 = currentType_1;
    let _e511 = currentType_1;
    if ((_e509 == 3u) || (_e511 == 7u)) {
        return;
    }
    let _e514 = rawValue_14;
    param_1070 = _e514;
    let _e515 = getDir_u0028_u1_u003b((&param_1070));
    currentDir_6 = _e515;
    let _e516 = rawValue_14;
    param_1071 = _e516;
    let _e517 = getSleep_u0028_u1_u003b((&param_1071));
    currentSleep_8 = _e517;
    let _e518 = rawValue_14;
    param_1072 = _e518;
    let _e519 = getAge_u0028_u1_u003b((&param_1072));
    currentAge_10 = _e519;
    let _e520 = currentType_1;
    switch bitcast<i32>(_e520) {
        case 1: {
            let _e522 = pos_24;
            param_1073 = _e522;
            let _e523 = currentIndex_16;
            param_1074 = _e523;
            let _e524 = rawValue_14;
            param_1075 = _e524;
            let _e525 = currentSleep_8;
            param_1076 = _e525;
            let _e526 = currentAge_10;
            param_1077 = _e526;
            let _e527 = randVal_16;
            param_1078 = _e527;
            updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1073), (&param_1074), (&param_1075), (&param_1076), (&param_1077), (&param_1078));
            break;
        }
        case 2: {
            let _e528 = pos_24;
            param_1079 = _e528;
            let _e529 = currentIndex_16;
            param_1080 = _e529;
            let _e530 = rawValue_14;
            param_1081 = _e530;
            let _e531 = currentDir_6;
            param_1082 = _e531;
            let _e532 = currentSleep_8;
            param_1083 = _e532;
            let _e533 = currentAge_10;
            param_1084 = _e533;
            let _e534 = randVal_16;
            param_1085 = _e534;
            updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1079), (&param_1080), (&param_1081), (&param_1082), (&param_1083), (&param_1084), (&param_1085));
            break;
        }
        case 4: {
            let _e535 = pos_24;
            param_1086 = _e535;
            let _e536 = currentIndex_16;
            param_1087 = _e536;
            let _e537 = rawValue_14;
            param_1088 = _e537;
            let _e538 = currentDir_6;
            param_1089 = _e538;
            let _e539 = currentSleep_8;
            param_1090 = _e539;
            let _e540 = currentAge_10;
            param_1091 = _e540;
            let _e541 = randVal_16;
            param_1092 = _e541;
            updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1086), (&param_1087), (&param_1088), (&param_1089), (&param_1090), (&param_1091), (&param_1092));
            break;
        }
        case 5: {
            let _e542 = pos_24;
            param_1093 = _e542;
            let _e543 = currentIndex_16;
            param_1094 = _e543;
            let _e544 = rawValue_14;
            param_1095 = _e544;
            let _e545 = currentDir_6;
            param_1096 = _e545;
            let _e546 = currentSleep_8;
            param_1097 = _e546;
            let _e547 = currentAge_10;
            param_1098 = _e547;
            let _e548 = randVal_16;
            param_1099 = _e548;
            updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1093), (&param_1094), (&param_1095), (&param_1096), (&param_1097), (&param_1098), (&param_1099));
            break;
        }
        case 6: {
            let _e549 = pos_24;
            param_1100 = _e549;
            let _e550 = currentIndex_16;
            param_1101 = _e550;
            let _e551 = rawValue_14;
            param_1102 = _e551;
            let _e552 = currentSleep_8;
            param_1103 = _e552;
            let _e553 = currentAge_10;
            param_1104 = _e553;
            let _e554 = randVal_16;
            param_1105 = _e554;
            updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1100), (&param_1101), (&param_1102), (&param_1103), (&param_1104), (&param_1105));
            break;
        }
        case 9, 10, 11, 8: {
            let _e555 = pos_24;
            param_1106 = _e555;
            let _e556 = currentIndex_16;
            param_1107 = _e556;
            let _e557 = rawValue_14;
            param_1108 = _e557;
            let _e558 = currentDir_6;
            param_1109 = _e558;
            let _e559 = currentSleep_8;
            param_1110 = _e559;
            let _e560 = currentAge_10;
            param_1111 = _e560;
            let _e561 = randVal_16;
            param_1112 = _e561;
            updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1106), (&param_1107), (&param_1108), (&param_1109), (&param_1110), (&param_1111), (&param_1112));
            break;
        }
        case 12: {
            let _e562 = pos_24;
            param_1113 = _e562;
            let _e563 = currentIndex_16;
            param_1114 = _e563;
            let _e564 = rawValue_14;
            param_1115 = _e564;
            let _e565 = currentAge_10;
            param_1116 = _e565;
            let _e566 = randVal_16;
            param_1117 = _e566;
            updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1113), (&param_1114), (&param_1115), (&param_1116), (&param_1117));
            break;
        }
        case 14, 15, 16, 17, 13: {
            let _e567 = pos_24;
            param_1118 = _e567;
            let _e568 = currentIndex_16;
            param_1119 = _e568;
            let _e569 = rawValue_14;
            param_1120 = _e569;
            let _e570 = currentDir_6;
            param_1121 = _e570;
            let _e571 = currentSleep_8;
            param_1122 = _e571;
            let _e572 = currentAge_10;
            param_1123 = _e572;
            let _e573 = randVal_16;
            param_1124 = _e573;
            updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1118), (&param_1119), (&param_1120), (&param_1121), (&param_1122), (&param_1123), (&param_1124));
            break;
        }
        case 18: {
            let _e574 = pos_24;
            param_1125 = _e574;
            let _e575 = currentIndex_16;
            param_1126 = _e575;
            let _e576 = rawValue_14;
            param_1127 = _e576;
            let _e577 = currentDir_6;
            param_1128 = _e577;
            let _e578 = currentAge_10;
            param_1129 = _e578;
            let _e579 = randVal_16;
            param_1130 = _e579;
            updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1125), (&param_1126), (&param_1127), (&param_1128), (&param_1129), (&param_1130));
            break;
        }
        case 19: {
            let _e580 = pos_24;
            param_1131 = _e580;
            let _e581 = currentIndex_16;
            param_1132 = _e581;
            let _e582 = rawValue_14;
            param_1133 = _e582;
            let _e583 = currentAge_10;
            param_1134 = _e583;
            let _e584 = randVal_16;
            param_1135 = _e584;
            updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1131), (&param_1132), (&param_1133), (&param_1134), (&param_1135));
            break;
        }
        case 20: {
            let _e585 = pos_24;
            param_1136 = _e585;
            let _e586 = currentIndex_16;
            param_1137 = _e586;
            let _e587 = rawValue_14;
            param_1138 = _e587;
            let _e588 = currentSleep_8;
            param_1139 = _e588;
            let _e589 = randVal_16;
            param_1140 = _e589;
            updateAsh_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1136), (&param_1137), (&param_1138), (&param_1139), (&param_1140));
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
