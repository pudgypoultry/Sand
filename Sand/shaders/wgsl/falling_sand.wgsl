// GENERATED FILE -- DO NOT EDIT.
//
// Translated from falling_sand.comp by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit falling_sand.comp and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 5f1967690187b7e7cd381705d9597d1ebd0e8b50aa6a7b04df6706cf515af3b0

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
    let _e205 = (*val);
    return ((_e205 >> bitcast<u32>(24i)) & 255u);
}

fn hash_u0028_vf3_u003b(p: ptr<function, vec3<f32>>) -> f32 {
    let _e205 = (*p);
    return fract((sin(dot(_e205, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn treeTargetHeight_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    var lo: u32;
    var hi: u32;
    var a: f32;
    var param: vec3<f32>;
    var b: f32;
    var param_1: vec3<f32>;
    var t: f32;

    let _e213 = tuning.treeMinHeight;
    lo = max(_e213, 1u);
    let _e216 = tuning.treeMaxHeight;
    let _e217 = lo;
    hi = max(_e216, _e217);
    let _e219 = hi;
    let _e220 = lo;
    if (_e219 == _e220) {
        let _e222 = lo;
        return _e222;
    }
    let _e224 = (*pos)[0u];
    let _e227 = (*pos)[2u];
    param = vec3<f32>(f32(_e224), 0f, f32(_e227));
    let _e230 = hash_u0028_vf3_u003b((&param));
    a = _e230;
    let _e232 = (*pos)[2u];
    let _e237 = (*pos)[0u];
    param_1 = vec3<f32>(((f32(_e232) * 3f) + 11f), 7f, ((f32(_e237) * 5f) + 3f));
    let _e242 = hash_u0028_vf3_u003b((&param_1));
    b = _e242;
    let _e243 = a;
    let _e244 = b;
    t = clamp(((_e243 + _e244) * 0.5f), 0f, 0.999f);
    let _e248 = lo;
    let _e249 = t;
    let _e250 = hi;
    let _e251 = lo;
    return (_e248 + u32((_e249 * f32(((_e250 - _e251) + 1u)))));
}

fn getDir_u0028_u1_u003b(val_1: ptr<function, u32>) -> u32 {
    let _e205 = (*val_1);
    return ((_e205 >> bitcast<u32>(8i)) & 255u);
}

fn getType_u0028_u1_u003b(val_2: ptr<function, u32>) -> u32 {
    let _e205 = (*val_2);
    return (_e205 & 255u);
}

fn tree26_u0028_i1_u003b(i: ptr<function, i32>) -> vec3<i32> {
    var j: i32;
    var local: i32;

    let _e207 = (*i);
    if (_e207 >= 13i) {
        let _e209 = (*i);
        local = (_e209 + 1i);
    } else {
        let _e211 = (*i);
        local = _e211;
    }
    let _e212 = local;
    j = _e212;
    let _e213 = j;
    let _e221 = j;
    let _e222 = (_e221 / 3i);
    let _e230 = j;
    return (vec3<i32>((_e213 - (i32(floor((f32(_e213) / f32(3i)))) * 3i)), (_e222 - (i32(floor((f32(_e222) / f32(3i)))) * 3i)), (_e230 / 9i)) - vec3<i32>(1i, 1i, 1i));
}

fn readCell_u0028_u1_u003b(index: ptr<function, u32>) -> u32 {
    let _e205 = (*index);
    let _e208 = atomicLoad((&unnamed.grid[_e205]));
    return _e208;
}

fn tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex: ptr<function, u32>, currentValue: ptr<function, u32>, targetIndex: ptr<function, u32>, newValue: ptr<function, u32>) -> bool {
    var targetValue: u32;
    var param_2: u32;
    var targetType: u32;
    var param_3: u32;
    var currentType: u32;
    var param_4: u32;
    var actual: u32;
    var phi_1752_: bool;
    var phi_1761_: bool;

    let _e215 = (*targetIndex);
    param_2 = _e215;
    let _e216 = readCell_u0028_u1_u003b((&param_2));
    targetValue = _e216;
    let _e217 = targetValue;
    param_3 = _e217;
    let _e218 = getType_u0028_u1_u003b((&param_3));
    targetType = _e218;
    let _e219 = (*currentValue);
    param_4 = _e219;
    let _e220 = getType_u0028_u1_u003b((&param_4));
    currentType = _e220;
    let _e221 = targetType;
    let _e222 = (_e221 == 0u);
    phi_1752_ = _e222;
    if !(_e222) {
        let _e224 = currentType;
        let _e226 = currentType;
        let _e229 = targetType;
        phi_1752_ = (((_e224 == 1u) || (_e226 == 4u)) && (_e229 == 2u));
    }
    let _e233 = phi_1752_;
    phi_1761_ = _e233;
    if !(_e233) {
        let _e235 = currentType;
        let _e237 = targetType;
        phi_1761_ = ((_e235 == 6u) && (_e237 == 5u));
    }
    let _e241 = phi_1761_;
    if _e241 {
        let _e242 = (*currentIndex);
        let _e245 = (*currentValue);
        let _e246 = atomicCompareExchangeWeak((&unnamed.grid[_e242]), _e245, 0u);
        let _e248 = (*currentValue);
        if (_e246.old_value == _e248) {
            let _e250 = (*targetIndex);
            let _e253 = targetValue;
            let _e254 = (*newValue);
            let _e255 = atomicCompareExchangeWeak((&unnamed.grid[_e250]), _e253, _e254);
            actual = _e255.old_value;
            let _e257 = actual;
            let _e258 = targetValue;
            if (_e257 == _e258) {
                let _e260 = targetType;
                if (_e260 != 0u) {
                    let _e262 = (*currentIndex);
                    let _e265 = targetValue;
                    let _e266 = atomicExchange((&unnamed.grid[_e262]), _e265);
                }
                return true;
            } else {
                let _e267 = (*currentIndex);
                let _e270 = (*currentValue);
                let _e271 = atomicCompareExchangeWeak((&unnamed.grid[_e267]), 0u, _e270);
            }
        }
    }
    return false;
}

fn pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(type_33: ptr<function, u32>, dir: ptr<function, u32>, sleep: ptr<function, u32>, age: ptr<function, u32>) -> u32 {
    let _e208 = (*type_33);
    let _e210 = (*dir);
    let _e215 = (*sleep);
    let _e220 = (*age);
    return ((((_e208 & 255u) | ((_e210 & 255u) << bitcast<u32>(8i))) | ((_e215 & 255u) << bitcast<u32>(16i))) | ((_e220 & 255u) << bitcast<u32>(24i)));
}

fn getIndex_u0028_vi3_u003b(pos_1: ptr<function, vec3<i32>>) -> u32 {
    let _e206 = (*pos_1)[0u];
    let _e208 = (*pos_1)[1u];
    let _e210 = tuning.gridWidth;
    let _e215 = (*pos_1)[2u];
    let _e217 = tuning.gridWidth;
    let _e221 = tuning.gridHeight;
    return bitcast<u32>(((_e206 + (_e208 * bitcast<i32>(_e210))) + ((_e215 * bitcast<i32>(_e217)) * bitcast<i32>(_e221))));
}

fn treeInBounds_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> bool {
    var phi_1180_: bool;
    var phi_1186_: bool;
    var phi_1196_: bool;
    var phi_1202_: bool;
    var phi_1212_: bool;

    let _e206 = (*p_1)[0u];
    let _e207 = (_e206 > 0i);
    phi_1180_ = _e207;
    if _e207 {
        let _e209 = (*p_1)[0u];
        let _e211 = tuning.gridWidth;
        phi_1180_ = (_e209 < (bitcast<i32>(_e211) - 1i));
    }
    let _e216 = phi_1180_;
    phi_1186_ = _e216;
    if _e216 {
        let _e218 = (*p_1)[1u];
        phi_1186_ = (_e218 > 0i);
    }
    let _e221 = phi_1186_;
    phi_1196_ = _e221;
    if _e221 {
        let _e223 = (*p_1)[1u];
        let _e225 = tuning.gridHeight;
        phi_1196_ = (_e223 < (bitcast<i32>(_e225) - 1i));
    }
    let _e230 = phi_1196_;
    phi_1202_ = _e230;
    if _e230 {
        let _e232 = (*p_1)[2u];
        phi_1202_ = (_e232 > 0i);
    }
    let _e235 = phi_1202_;
    phi_1212_ = _e235;
    if _e235 {
        let _e237 = (*p_1)[2u];
        let _e239 = tuning.gridDepth;
        phi_1212_ = (_e237 < (bitcast<i32>(_e239) - 1i));
    }
    let _e244 = phi_1212_;
    return _e244;
}

fn updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_2: ptr<function, vec3<i32>>, currentIndex_1: ptr<function, u32>, rawValue: ptr<function, u32>, currentAge: ptr<function, u32>, randVal: ptr<function, f32>) {
    var belowPos: vec3<i32>;
    var param_5: vec3<i32>;
    var param_6: vec3<i32>;
    var param_7: u32;
    var param_8: vec3<i32>;
    var param_9: u32;
    var param_10: u32;
    var param_11: u32;
    var param_12: u32;
    var param_13: u32;
    var param_14: u32;
    var param_15: u32;
    var param_16: u32;
    var dist: u32;
    var nearest: u32;
    var touchesTrunk: bool;
    var start: i32;
    var haveSpot: bool;
    var spot: vec3<i32>;
    var i_1: i32;
    var c: vec3<i32>;
    var param_17: i32;
    var param_18: vec3<i32>;
    var v: u32;
    var param_19: vec3<i32>;
    var param_20: u32;
    var t_1: u32;
    var param_21: u32;
    var param_22: u32;
    var param_23: vec3<i32>;
    var param_24: u32;
    var supported: u32;
    var local_1: u32;
    var local_2: u32;
    var param_25: u32;
    var param_26: u32;
    var param_27: u32;
    var param_28: u32;
    var param_29: vec3<i32>;
    var param_30: u32;
    var param_31: u32;
    var param_32: u32;
    var param_33: u32;
    var param_34: u32;
    var param_35: u32;
    var param_36: u32;
    var param_37: u32;
    var phi_6859_: bool;
    var phi_6944_: bool;
    var phi_7026_: bool;

    let _e256 = (*randVal);
    let _e260 = tuning.treeLeafTickChance;
    if (fract((_e256 * 7f)) >= _e260) {
        return;
    }
    let _e262 = (*currentAge);
    if (_e262 == 255u) {
        let _e264 = (*pos_2);
        belowPos = (_e264 + vec3<i32>(0i, -1i, 0i));
        let _e266 = belowPos;
        param_5 = _e266;
        let _e267 = treeInBounds_u0028_vi3_u003b((&param_5));
        phi_6859_ = _e267;
        if _e267 {
            let _e268 = belowPos;
            param_6 = _e268;
            let _e269 = getIndex_u0028_vi3_u003b((&param_6));
            param_7 = _e269;
            let _e270 = readCell_u0028_u1_u003b((&param_7));
            phi_6859_ = (_e270 == 0u);
        }
        let _e273 = phi_6859_;
        if _e273 {
            let _e274 = belowPos;
            param_8 = _e274;
            let _e275 = getIndex_u0028_vi3_u003b((&param_8));
            param_9 = 19u;
            param_10 = 0u;
            param_11 = 0u;
            param_12 = 255u;
            let _e276 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_9), (&param_10), (&param_11), (&param_12));
            let _e277 = (*currentIndex_1);
            param_13 = _e277;
            let _e278 = (*rawValue);
            param_14 = _e278;
            param_15 = _e275;
            param_16 = _e276;
            let _e279 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_13), (&param_14), (&param_15), (&param_16));
            if _e279 {
                return;
            }
        }
        let _e280 = (*currentIndex_1);
        let _e283 = (*rawValue);
        let _e284 = atomicCompareExchangeWeak((&unnamed.grid[_e280]), _e283, 0u);
        return;
    }
    let _e286 = (*currentAge);
    dist = _e286;
    nearest = 255u;
    touchesTrunk = false;
    let _e287 = (*randVal);
    start = i32((fract((_e287 * 71f)) * 26f));
    haveSpot = false;
    let _e292 = (*pos_2);
    spot = _e292;
    i_1 = 0i;
    loop {
        let _e293 = i_1;
        if (_e293 < 26i) {
            let _e295 = (*pos_2);
            let _e296 = start;
            let _e297 = i_1;
            let _e298 = (_e296 + _e297);
            param_17 = (_e298 - (i32(floor((f32(_e298) / f32(26i)))) * 26i));
            let _e306 = tree26_u0028_i1_u003b((&param_17));
            c = (_e295 + _e306);
            let _e308 = c;
            param_18 = _e308;
            let _e309 = treeInBounds_u0028_vi3_u003b((&param_18));
            if !(_e309) {
                continue;
            }
            let _e311 = c;
            param_19 = _e311;
            let _e312 = getIndex_u0028_vi3_u003b((&param_19));
            param_20 = _e312;
            let _e313 = readCell_u0028_u1_u003b((&param_20));
            v = _e313;
            let _e314 = v;
            param_21 = _e314;
            let _e315 = getType_u0028_u1_u003b((&param_21));
            t_1 = _e315;
            let _e316 = t_1;
            let _e317 = (_e316 == 18u);
            phi_6944_ = _e317;
            if _e317 {
                let _e318 = v;
                param_22 = _e318;
                let _e319 = getDir_u0028_u1_u003b((&param_22));
                let _e321 = c;
                param_23 = _e321;
                let _e322 = treeTargetHeight_u0028_vi3_u003b((&param_23));
                phi_6944_ = ((_e319 + 1u) >= _e322);
            }
            let _e325 = phi_6944_;
            if _e325 {
                touchesTrunk = true;
            } else {
                let _e326 = t_1;
                if (_e326 == 19u) {
                    let _e328 = nearest;
                    let _e329 = v;
                    param_24 = _e329;
                    let _e330 = getAge_u0028_u1_u003b((&param_24));
                    nearest = min(_e328, _e330);
                } else {
                    let _e332 = v;
                    let _e334 = haveSpot;
                    if ((_e332 == 0u) && !(_e334)) {
                        haveSpot = true;
                        let _e337 = c;
                        spot = _e337;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e338 = i_1;
            i_1 = (_e338 + 1i);
        }
    }
    let _e340 = touchesTrunk;
    if _e340 {
        local_1 = 1u;
    } else {
        let _e341 = nearest;
        if (_e341 >= 255u) {
            local_2 = 255u;
        } else {
            let _e343 = nearest;
            local_2 = (_e343 + 1u);
        }
        let _e345 = local_2;
        local_1 = _e345;
    }
    let _e346 = local_1;
    supported = _e346;
    let _e347 = supported;
    let _e349 = tuning.treeLeafReach;
    if (_e347 > _e349) {
        let _e351 = (*randVal);
        let _e355 = tuning.treeLeafFallChance;
        if (fract((_e351 * 83f)) < _e355) {
            let _e357 = (*currentIndex_1);
            let _e360 = (*rawValue);
            param_25 = 19u;
            param_26 = 0u;
            param_27 = 0u;
            param_28 = 255u;
            let _e361 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_25), (&param_26), (&param_27), (&param_28));
            let _e362 = atomicCompareExchangeWeak((&unnamed.grid[_e357]), _e360, _e361);
        }
        return;
    }
    let _e364 = supported;
    let _e366 = tuning.treeLeafReach;
    let _e368 = haveSpot;
    let _e369 = ((_e364 < _e366) && _e368);
    phi_7026_ = _e369;
    if _e369 {
        let _e370 = (*randVal);
        let _e374 = tuning.treeLeafSpreadChance;
        phi_7026_ = (fract((_e370 * 89f)) < _e374);
    }
    let _e377 = phi_7026_;
    if _e377 {
        let _e378 = spot;
        param_29 = _e378;
        let _e379 = getIndex_u0028_vi3_u003b((&param_29));
        let _e382 = supported;
        param_30 = 19u;
        param_31 = 0u;
        param_32 = 0u;
        param_33 = (_e382 + 1u);
        let _e384 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_30), (&param_31), (&param_32), (&param_33));
        let _e385 = atomicCompareExchangeWeak((&unnamed.grid[_e379]), 0u, _e384);
    }
    let _e387 = supported;
    let _e388 = dist;
    if (_e387 != _e388) {
        let _e390 = (*currentIndex_1);
        let _e393 = (*rawValue);
        param_34 = 19u;
        param_35 = 0u;
        param_36 = 0u;
        let _e394 = supported;
        param_37 = _e394;
        let _e395 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_34), (&param_35), (&param_36), (&param_37));
        let _e396 = atomicCompareExchangeWeak((&unnamed.grid[_e390]), _e393, _e395);
    }
    return;
}

fn isGrassBlock_u0028_u1_u003b(value: ptr<function, u32>) -> bool {
    var flora: u32;
    var param_38: u32;

    let _e207 = (*value);
    flora = ((_e207 >> bitcast<u32>(8i)) & 255u);
    let _e211 = (*value);
    param_38 = _e211;
    let _e212 = getType_u0028_u1_u003b((&param_38));
    let _e214 = flora;
    let _e217 = flora;
    return (((_e212 == 4u) && (_e214 > 10u)) && (_e217 <= 100u));
}

fn getSleep_u0028_u1_u003b(val_3: ptr<function, u32>) -> u32 {
    let _e205 = (*val_3);
    return ((_e205 >> bitcast<u32>(16i)) & 255u);
}

fn getHDir_u0028_i1_u003b(d: ptr<function, i32>) -> vec3<i32> {
    let _e205 = (*d);
    if (_e205 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e207 = (*d);
    if (_e207 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e209 = (*d);
    if (_e209 == 2i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    let _e211 = (*d);
    if (_e211 == 3i) {
        return vec3<i32>(0i, 0i, -1i);
    }
    let _e213 = (*d);
    if (_e213 == 4i) {
        return vec3<i32>(1i, 0i, 1i);
    }
    let _e215 = (*d);
    if (_e215 == 5i) {
        return vec3<i32>(1i, 0i, -1i);
    }
    let _e217 = (*d);
    if (_e217 == 6i) {
        return vec3<i32>(-1i, 0i, 1i);
    }
    return vec3<i32>(-1i, 0i, -1i);
}

fn updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_3: ptr<function, vec3<i32>>, currentIndex_2: ptr<function, u32>, rawValue_1: ptr<function, u32>, currentDir: ptr<function, u32>, currentAge_1: ptr<function, u32>, randVal_1: ptr<function, f32>) {
    var height: u32;
    var water: u32;
    var changed: bool;
    var start_1: i32;
    var k: i32;
    var i_2: i32;
    var c_1: vec3<i32>;
    var local_3: vec3<i32>;
    var local_4: vec3<i32>;
    var param_39: i32;
    var param_40: i32;
    var param_41: vec3<i32>;
    var idx: u32;
    var param_42: vec3<i32>;
    var v_1: u32;
    var param_43: u32;
    var param_44: u32;
    var moisture: u32;
    var param_45: u32;
    var param_46: u32;
    var param_47: u32;
    var param_48: u32;
    var param_49: u32;
    var param_50: u32;
    var param_51: u32;
    var upPos: vec3<i32>;
    var upIsTrunk: bool;
    var upValue: u32;
    var upIndex: u32;
    var param_52: vec3<i32>;
    var param_53: vec3<i32>;
    var param_54: u32;
    var param_55: u32;
    var param_56: u32;
    var lifted: u32;
    var param_57: u32;
    var param_58: u32;
    var param_59: u32;
    var param_60: u32;
    var param_61: u32;
    var param_62: u32;
    var param_63: vec3<i32>;
    var param_64: vec3<i32>;
    var upType: u32;
    var param_65: u32;
    var sapling: u32;
    var param_66: u32;
    var param_67: u32;
    var param_68: u32;
    var param_69: u32;
    var start_2: i32;
    var i_3: i32;
    var c_2: vec3<i32>;
    var param_70: i32;
    var param_71: vec3<i32>;
    var idx_1: u32;
    var param_72: vec3<i32>;
    var param_73: u32;
    var param_74: u32;
    var param_75: u32;
    var param_76: u32;
    var param_77: u32;
    var start_3: i32;
    var i_4: i32;
    var c_3: vec3<i32>;
    var param_78: i32;
    var param_79: vec3<i32>;
    var idx_2: u32;
    var param_80: vec3<i32>;
    var param_81: u32;
    var param_82: vec3<i32>;
    var param_83: u32;
    var param_84: u32;
    var param_85: u32;
    var param_86: u32;
    var param_87: u32;
    var param_88: u32;
    var param_89: u32;
    var param_90: u32;
    var param_91: u32;
    var param_92: u32;
    var phi_6414_: bool;
    var phi_6558_: bool;
    var phi_6568_: bool;
    var phi_6613_: bool;
    var phi_6664_: bool;
    var phi_6743_: bool;

    let _e291 = (*currentDir);
    height = _e291;
    let _e292 = (*currentAge_1);
    water = _e292;
    changed = false;
    let _e293 = water;
    let _e295 = tuning.treeWaterMax;
    let _e296 = (_e293 < _e295);
    phi_6414_ = _e296;
    if _e296 {
        let _e297 = (*randVal_1);
        let _e301 = tuning.treeDrinkChance;
        phi_6414_ = (fract((_e297 * 13f)) < _e301);
    }
    let _e304 = phi_6414_;
    if _e304 {
        let _e305 = (*randVal_1);
        start_1 = i32((fract((_e305 * 101f)) * 17f));
        k = 0i;
        loop {
            let _e310 = k;
            if (_e310 < 17i) {
                let _e312 = start_1;
                let _e313 = k;
                let _e314 = (_e312 + _e313);
                i_2 = (_e314 - (i32(floor((f32(_e314) / f32(17i)))) * 17i));
                let _e322 = i_2;
                if (_e322 == 0i) {
                    let _e324 = (*pos_3);
                    local_3 = (_e324 + vec3<i32>(0i, -1i, 0i));
                } else {
                    let _e326 = i_2;
                    if (_e326 < 9i) {
                        let _e328 = (*pos_3);
                        let _e329 = i_2;
                        param_39 = (_e329 - 1i);
                        let _e331 = getHDir_u0028_i1_u003b((&param_39));
                        local_4 = ((_e328 + _e331) + vec3<i32>(0i, -1i, 0i));
                    } else {
                        let _e334 = (*pos_3);
                        let _e335 = i_2;
                        param_40 = (_e335 - 9i);
                        let _e337 = getHDir_u0028_i1_u003b((&param_40));
                        local_4 = (_e334 + _e337);
                    }
                    let _e339 = local_4;
                    local_3 = _e339;
                }
                let _e340 = local_3;
                c_1 = _e340;
                let _e341 = c_1;
                param_41 = _e341;
                let _e342 = treeInBounds_u0028_vi3_u003b((&param_41));
                if !(_e342) {
                    continue;
                }
                let _e344 = c_1;
                param_42 = _e344;
                let _e345 = getIndex_u0028_vi3_u003b((&param_42));
                idx = _e345;
                let _e346 = idx;
                param_43 = _e346;
                let _e347 = readCell_u0028_u1_u003b((&param_43));
                v_1 = _e347;
                let _e348 = v_1;
                param_44 = _e348;
                let _e349 = getType_u0028_u1_u003b((&param_44));
                if (_e349 != 4u) {
                    continue;
                }
                let _e351 = v_1;
                param_45 = _e351;
                let _e352 = getAge_u0028_u1_u003b((&param_45));
                moisture = _e352;
                let _e353 = moisture;
                let _e355 = tuning.treeSoilReserve;
                if (_e353 <= _e355) {
                    continue;
                }
                let _e357 = idx;
                let _e360 = v_1;
                let _e361 = v_1;
                param_46 = _e361;
                let _e362 = getDir_u0028_u1_u003b((&param_46));
                let _e363 = v_1;
                param_47 = _e363;
                let _e364 = getSleep_u0028_u1_u003b((&param_47));
                let _e365 = moisture;
                param_48 = 4u;
                param_49 = _e362;
                param_50 = _e364;
                param_51 = (_e365 - 1u);
                let _e367 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_48), (&param_49), (&param_50), (&param_51));
                let _e368 = atomicCompareExchangeWeak((&unnamed.grid[_e357]), _e360, _e367);
                let _e370 = v_1;
                if (_e368.old_value == _e370) {
                    let _e372 = water;
                    water = (_e372 + 1u);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e374 = k;
                k = (_e374 + 1i);
            }
        }
    }
    let _e376 = (*pos_3);
    upPos = (_e376 + vec3<i32>(0i, 1i, 0i));
    upIsTrunk = false;
    upValue = 0u;
    upIndex = 0u;
    let _e378 = upPos;
    param_52 = _e378;
    let _e379 = treeInBounds_u0028_vi3_u003b((&param_52));
    if _e379 {
        let _e380 = upPos;
        param_53 = _e380;
        let _e381 = getIndex_u0028_vi3_u003b((&param_53));
        upIndex = _e381;
        let _e382 = upIndex;
        param_54 = _e382;
        let _e383 = readCell_u0028_u1_u003b((&param_54));
        upValue = _e383;
        let _e384 = upValue;
        param_55 = _e384;
        let _e385 = getType_u0028_u1_u003b((&param_55));
        upIsTrunk = (_e385 == 18u);
    }
    let _e387 = upIsTrunk;
    let _e388 = water;
    let _e390 = (_e387 && (_e388 > 0u));
    phi_6558_ = _e390;
    if _e390 {
        let _e391 = upValue;
        param_56 = _e391;
        let _e392 = getAge_u0028_u1_u003b((&param_56));
        phi_6558_ = (_e392 < 255u);
    }
    let _e395 = phi_6558_;
    phi_6568_ = _e395;
    if _e395 {
        let _e396 = (*randVal_1);
        let _e400 = tuning.treeFlowChance;
        phi_6568_ = (fract((_e396 * 29f)) < _e400);
    }
    let _e403 = phi_6568_;
    if _e403 {
        let _e404 = upValue;
        param_57 = _e404;
        let _e405 = getDir_u0028_u1_u003b((&param_57));
        let _e406 = upValue;
        param_58 = _e406;
        let _e407 = getAge_u0028_u1_u003b((&param_58));
        param_59 = 18u;
        param_60 = _e405;
        param_61 = 0u;
        param_62 = (_e407 + 1u);
        let _e409 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_59), (&param_60), (&param_61), (&param_62));
        lifted = _e409;
        let _e410 = upIndex;
        let _e413 = upValue;
        let _e414 = lifted;
        let _e415 = atomicCompareExchangeWeak((&unnamed.grid[_e410]), _e413, _e414);
        let _e417 = upValue;
        if (_e415.old_value == _e417) {
            let _e419 = water;
            water = (_e419 - 1u);
            changed = true;
        }
    }
    let _e421 = height;
    let _e423 = (*pos_3);
    param_63 = _e423;
    let _e424 = treeTargetHeight_u0028_vi3_u003b((&param_63));
    if ((_e421 + 1u) < _e424) {
        let _e426 = water;
        let _e428 = tuning.treeGrowCost;
        let _e429 = (_e426 >= _e428);
        phi_6613_ = _e429;
        if _e429 {
            let _e430 = upPos;
            param_64 = _e430;
            let _e431 = treeInBounds_u0028_vi3_u003b((&param_64));
            phi_6613_ = _e431;
        }
        let _e433 = phi_6613_;
        if _e433 {
            let _e434 = upValue;
            param_65 = _e434;
            let _e435 = getType_u0028_u1_u003b((&param_65));
            upType = _e435;
            let _e436 = upType;
            let _e438 = upType;
            if ((_e436 == 0u) || (_e438 == 19u)) {
                let _e441 = height;
                param_66 = 18u;
                param_67 = (_e441 + 1u);
                param_68 = 0u;
                param_69 = 0u;
                let _e443 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_66), (&param_67), (&param_68), (&param_69));
                sapling = _e443;
                let _e444 = upIndex;
                let _e447 = upValue;
                let _e448 = sapling;
                let _e449 = atomicCompareExchangeWeak((&unnamed.grid[_e444]), _e447, _e448);
                let _e451 = upValue;
                if (_e449.old_value == _e451) {
                    let _e454 = tuning.treeGrowCost;
                    let _e455 = water;
                    water = (_e455 - _e454);
                    changed = true;
                }
            }
        }
    } else {
        let _e457 = water;
        let _e459 = tuning.treeLeafCost;
        let _e460 = (_e457 >= _e459);
        phi_6664_ = _e460;
        if _e460 {
            let _e461 = (*randVal_1);
            let _e465 = tuning.treeLeafChance;
            phi_6664_ = (fract((_e461 * 37f)) < _e465);
        }
        let _e468 = phi_6664_;
        if _e468 {
            let _e469 = (*randVal_1);
            start_2 = i32((fract((_e469 * 43f)) * 26f));
            i_3 = 0i;
            loop {
                let _e474 = i_3;
                if (_e474 < 26i) {
                    let _e476 = (*pos_3);
                    let _e477 = start_2;
                    let _e478 = i_3;
                    let _e479 = (_e477 + _e478);
                    param_70 = (_e479 - (i32(floor((f32(_e479) / f32(26i)))) * 26i));
                    let _e487 = tree26_u0028_i1_u003b((&param_70));
                    c_2 = (_e476 + _e487);
                    let _e489 = c_2;
                    param_71 = _e489;
                    let _e490 = treeInBounds_u0028_vi3_u003b((&param_71));
                    if !(_e490) {
                        continue;
                    }
                    let _e492 = c_2;
                    param_72 = _e492;
                    let _e493 = getIndex_u0028_vi3_u003b((&param_72));
                    idx_1 = _e493;
                    let _e494 = idx_1;
                    param_73 = _e494;
                    let _e495 = readCell_u0028_u1_u003b((&param_73));
                    if (_e495 != 0u) {
                        continue;
                    }
                    let _e497 = idx_1;
                    param_74 = 19u;
                    param_75 = 0u;
                    param_76 = 0u;
                    param_77 = 1u;
                    let _e500 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_74), (&param_75), (&param_76), (&param_77));
                    let _e501 = atomicCompareExchangeWeak((&unnamed.grid[_e497]), 0u, _e500);
                    if (_e501.old_value == 0u) {
                        let _e505 = tuning.treeLeafCost;
                        let _e506 = water;
                        water = (_e506 - _e505);
                        changed = true;
                        break;
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e508 = i_3;
                    i_3 = (_e508 + 1i);
                }
            }
        }
    }
    let _e510 = water;
    let _e512 = tuning.treeSpreadCost;
    let _e513 = (_e510 >= _e512);
    phi_6743_ = _e513;
    if _e513 {
        let _e514 = (*randVal_1);
        let _e518 = tuning.treeSpreadChance;
        phi_6743_ = (fract((_e514 * 59f)) < _e518);
    }
    let _e521 = phi_6743_;
    if _e521 {
        let _e522 = (*randVal_1);
        start_3 = i32((fract((_e522 * 61f)) * 8f));
        i_4 = 0i;
        loop {
            let _e527 = i_4;
            if (_e527 < 8i) {
                let _e529 = (*pos_3);
                let _e530 = start_3;
                let _e531 = i_4;
                let _e532 = (_e530 + _e531);
                param_78 = (_e532 - (i32(floor((f32(_e532) / f32(8i)))) * 8i));
                let _e540 = getHDir_u0028_i1_u003b((&param_78));
                c_3 = (_e529 + _e540);
                let _e542 = c_3;
                param_79 = _e542;
                let _e543 = treeInBounds_u0028_vi3_u003b((&param_79));
                if !(_e543) {
                    continue;
                }
                let _e545 = c_3;
                param_80 = _e545;
                let _e546 = getIndex_u0028_vi3_u003b((&param_80));
                idx_2 = _e546;
                let _e547 = idx_2;
                param_81 = _e547;
                let _e548 = readCell_u0028_u1_u003b((&param_81));
                if (_e548 != 0u) {
                    continue;
                }
                let _e550 = c_3;
                param_82 = (_e550 + vec3<i32>(0i, -1i, 0i));
                let _e552 = getIndex_u0028_vi3_u003b((&param_82));
                param_83 = _e552;
                let _e553 = readCell_u0028_u1_u003b((&param_83));
                param_84 = _e553;
                let _e554 = isGrassBlock_u0028_u1_u003b((&param_84));
                if !(_e554) {
                    continue;
                }
                let _e556 = idx_2;
                param_85 = 18u;
                param_86 = 0u;
                param_87 = 0u;
                param_88 = 0u;
                let _e559 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_85), (&param_86), (&param_87), (&param_88));
                let _e560 = atomicCompareExchangeWeak((&unnamed.grid[_e556]), 0u, _e559);
                if (_e560.old_value == 0u) {
                    let _e564 = tuning.treeSpreadCost;
                    let _e565 = water;
                    water = (_e565 - _e564);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e567 = i_4;
                i_4 = (_e567 + 1i);
            }
        }
    }
    let _e569 = changed;
    if _e569 {
        let _e570 = (*currentIndex_2);
        let _e573 = (*rawValue_1);
        param_89 = 18u;
        let _e574 = height;
        param_90 = _e574;
        param_91 = 0u;
        let _e575 = water;
        param_92 = _e575;
        let _e576 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_89), (&param_90), (&param_91), (&param_92));
        let _e577 = atomicCompareExchangeWeak((&unnamed.grid[_e570]), _e573, _e576);
    }
    return;
}

fn locustPackNav_u0028_u1_u003b_u1_u003b(heading: ptr<function, u32>, steps: ptr<function, u32>) -> u32 {
    let _e206 = (*heading);
    let _e208 = (*steps);
    return ((_e206 & 7u) | (min(_e208, 7u) << bitcast<u32>(3i)));
}

fn locustReverse_u0028_u1_u003b(d_1: ptr<function, u32>) -> u32 {
    let _e205 = (*d_1);
    if (_e205 == 0u) {
        return 1u;
    }
    let _e207 = (*d_1);
    if (_e207 == 1u) {
        return 0u;
    }
    let _e209 = (*d_1);
    if (_e209 == 2u) {
        return 3u;
    }
    let _e211 = (*d_1);
    if (_e211 == 3u) {
        return 2u;
    }
    let _e213 = (*d_1);
    if (_e213 == 4u) {
        return 7u;
    }
    let _e215 = (*d_1);
    if (_e215 == 5u) {
        return 6u;
    }
    let _e217 = (*d_1);
    if (_e217 == 6u) {
        return 5u;
    }
    return 4u;
}

fn locustRunSteps_u0028_() -> u32 {
    let _e205 = tuning.locustRunLength;
    return clamp(_e205, 1u, 7u);
}

fn isLocustFood_u0028_u1_u003b(value_1: ptr<function, u32>) -> bool {
    var param_93: u32;
    var param_94: u32;
    var phi_973_: bool;

    let _e207 = (*value_1);
    param_93 = _e207;
    let _e208 = isGrassBlock_u0028_u1_u003b((&param_93));
    phi_973_ = _e208;
    if !(_e208) {
        let _e210 = (*value_1);
        param_94 = _e210;
        let _e211 = getType_u0028_u1_u003b((&param_94));
        phi_973_ = (_e211 == 19u);
    }
    let _e214 = phi_973_;
    return _e214;
}

fn locustFoodAt_u0028_vi3_u003b(p_2: ptr<function, vec3<i32>>) -> bool {
    var param_95: vec3<i32>;
    var param_96: u32;
    var param_97: u32;
    var phi_988_: bool;
    var phi_995_: bool;
    var phi_1005_: bool;
    var phi_1012_: bool;
    var phi_1022_: bool;

    let _e209 = (*p_2)[0u];
    let _e210 = (_e209 < 0i);
    phi_988_ = _e210;
    if !(_e210) {
        let _e213 = (*p_2)[0u];
        let _e215 = tuning.gridWidth;
        phi_988_ = (_e213 >= bitcast<i32>(_e215));
    }
    let _e219 = phi_988_;
    phi_995_ = _e219;
    if !(_e219) {
        let _e222 = (*p_2)[1u];
        phi_995_ = (_e222 < 0i);
    }
    let _e225 = phi_995_;
    phi_1005_ = _e225;
    if !(_e225) {
        let _e228 = (*p_2)[1u];
        let _e230 = tuning.gridHeight;
        phi_1005_ = (_e228 >= bitcast<i32>(_e230));
    }
    let _e234 = phi_1005_;
    phi_1012_ = _e234;
    if !(_e234) {
        let _e237 = (*p_2)[2u];
        phi_1012_ = (_e237 < 0i);
    }
    let _e240 = phi_1012_;
    phi_1022_ = _e240;
    if !(_e240) {
        let _e243 = (*p_2)[2u];
        let _e245 = tuning.gridDepth;
        phi_1022_ = (_e243 >= bitcast<i32>(_e245));
    }
    let _e249 = phi_1022_;
    if _e249 {
        return false;
    }
    let _e250 = (*p_2);
    param_95 = _e250;
    let _e251 = getIndex_u0028_vi3_u003b((&param_95));
    param_96 = _e251;
    let _e252 = readCell_u0028_u1_u003b((&param_96));
    param_97 = _e252;
    let _e253 = isLocustFood_u0028_u1_u003b((&param_97));
    return _e253;
}

fn locustSteps_u0028_u1_u003b(dirByte: ptr<function, u32>) -> u32 {
    let _e205 = (*dirByte);
    return ((_e205 >> bitcast<u32>(3i)) & 7u);
}

fn locustHeading_u0028_u1_u003b(dirByte_1: ptr<function, u32>) -> u32 {
    let _e205 = (*dirByte_1);
    return (_e205 & 7u);
}

fn locustArriveDir_u0028_vi3_u003b_u1_u003b(dest: ptr<function, vec3<i32>>, nav: ptr<function, u32>) -> u32 {
    var param_98: vec3<i32>;

    let _e207 = (*dest);
    param_98 = (_e207 + vec3<i32>(0i, -1i, 0i));
    let _e209 = locustFoodAt_u0028_vi3_u003b((&param_98));
    let _e210 = (*nav);
    return select(_e210, 0u, _e209);
}

fn locustHasGrip_u0028_vi3_u003b(pos_4: ptr<function, vec3<i32>>) -> bool {
    var d_2: i32;
    var n: vec3<i32>;
    var param_99: i32;
    var param_100: vec3<i32>;
    var param_101: u32;
    var phi_1125_: bool;
    var phi_1132_: bool;
    var phi_1143_: bool;

    d_2 = 0i;
    loop {
        let _e210 = d_2;
        if (_e210 < 8i) {
            let _e212 = (*pos_4);
            let _e213 = d_2;
            param_99 = _e213;
            let _e214 = getHDir_u0028_i1_u003b((&param_99));
            n = (_e212 + _e214);
            let _e217 = n[0u];
            let _e218 = (_e217 <= 0i);
            phi_1125_ = _e218;
            if !(_e218) {
                let _e221 = n[0u];
                let _e223 = tuning.gridWidth;
                phi_1125_ = (_e221 >= (bitcast<i32>(_e223) - 1i));
            }
            let _e228 = phi_1125_;
            phi_1132_ = _e228;
            if !(_e228) {
                let _e231 = n[2u];
                phi_1132_ = (_e231 <= 0i);
            }
            let _e234 = phi_1132_;
            phi_1143_ = _e234;
            if !(_e234) {
                let _e237 = n[2u];
                let _e239 = tuning.gridDepth;
                phi_1143_ = (_e237 >= (bitcast<i32>(_e239) - 1i));
            }
            let _e244 = phi_1143_;
            if _e244 {
                continue;
            }
            let _e245 = n;
            param_100 = _e245;
            let _e246 = getIndex_u0028_vi3_u003b((&param_100));
            param_101 = _e246;
            let _e247 = readCell_u0028_u1_u003b((&param_101));
            if (_e247 != 0u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e249 = d_2;
            d_2 = (_e249 + 1i);
        }
    }
    return false;
}

fn locustStage_u0028_() -> u32 {
    let _e205 = tuning.locustStageSize;
    return max(_e205, 1u);
}

fn locustTypeFor_u0028_u1_u003b(count: ptr<function, u32>) -> u32 {
    var stage: u32;
    var local_5: u32;

    let _e207 = (*count);
    if (_e207 == 0u) {
        local_5 = 0u;
    } else {
        let _e209 = (*count);
        let _e211 = locustStage_u0028_();
        local_5 = ((_e209 - 1u) / _e211);
    }
    let _e213 = local_5;
    stage = _e213;
    let _e214 = stage;
    return (13u + min(_e214, 4u));
}

fn locustInBounds_u0028_vi3_u003b(p_3: ptr<function, vec3<i32>>) -> bool {
    var phi_909_: bool;
    var phi_915_: bool;
    var phi_925_: bool;
    var phi_931_: bool;
    var phi_941_: bool;

    let _e206 = (*p_3)[0u];
    let _e207 = (_e206 > 0i);
    phi_909_ = _e207;
    if _e207 {
        let _e209 = (*p_3)[0u];
        let _e211 = tuning.gridWidth;
        phi_909_ = (_e209 < (bitcast<i32>(_e211) - 1i));
    }
    let _e216 = phi_909_;
    phi_915_ = _e216;
    if _e216 {
        let _e218 = (*p_3)[1u];
        phi_915_ = (_e218 > 0i);
    }
    let _e221 = phi_915_;
    phi_925_ = _e221;
    if _e221 {
        let _e223 = (*p_3)[1u];
        let _e225 = tuning.gridHeight;
        phi_925_ = (_e223 < (bitcast<i32>(_e225) - 1i));
    }
    let _e230 = phi_925_;
    phi_931_ = _e230;
    if _e230 {
        let _e232 = (*p_3)[2u];
        phi_931_ = (_e232 > 0i);
    }
    let _e235 = phi_931_;
    phi_941_ = _e235;
    if _e235 {
        let _e237 = (*p_3)[2u];
        let _e239 = tuning.gridDepth;
        phi_941_ = (_e237 < (bitcast<i32>(_e239) - 1i));
    }
    let _e244 = phi_941_;
    return _e244;
}

fn locustMaxCount_u0028_() -> u32 {
    let _e205 = tuning.locustMaxSize;
    return max(_e205, 1u);
}

fn locustBud_u0028_vi3_u003b_f1_u003b(pos_5: ptr<function, vec3<i32>>, randVal_2: ptr<function, f32>) {
    var bud: u32;
    var start_4: i32;
    var i_5: i32;
    var d_3: i32;
    var c_4: vec3<i32>;
    var param_102: i32;
    var param_103: vec3<i32>;
    var idx_3: u32;
    var param_104: vec3<i32>;
    var param_105: u32;
    var param_106: u32;
    var param_107: u32;
    var param_108: u32;
    var param_109: u32;
    var param_110: u32;

    let _e222 = tuning.locustBudSize;
    let _e223 = locustMaxCount_u0028_();
    bud = clamp(_e222, 1u, _e223);
    let _e225 = (*randVal_2);
    start_4 = i32((fract((_e225 * 31f)) * 8f));
    i_5 = 0i;
    loop {
        let _e230 = i_5;
        if (_e230 < 8i) {
            let _e232 = start_4;
            let _e233 = i_5;
            let _e234 = (_e232 + _e233);
            d_3 = (_e234 - (i32(floor((f32(_e234) / f32(8i)))) * 8i));
            let _e242 = (*pos_5);
            let _e243 = d_3;
            param_102 = _e243;
            let _e244 = getHDir_u0028_i1_u003b((&param_102));
            c_4 = (_e242 + _e244);
            let _e246 = c_4;
            param_103 = _e246;
            let _e247 = locustInBounds_u0028_vi3_u003b((&param_103));
            if !(_e247) {
                continue;
            }
            let _e249 = c_4;
            param_104 = _e249;
            let _e250 = getIndex_u0028_vi3_u003b((&param_104));
            idx_3 = _e250;
            let _e251 = idx_3;
            param_105 = _e251;
            let _e252 = readCell_u0028_u1_u003b((&param_105));
            if (_e252 != 0u) {
                continue;
            }
            let _e254 = idx_3;
            let _e257 = bud;
            param_106 = _e257;
            let _e258 = locustTypeFor_u0028_u1_u003b((&param_106));
            param_107 = _e258;
            param_108 = 0u;
            param_109 = 0u;
            let _e259 = bud;
            param_110 = _e259;
            let _e260 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_107), (&param_108), (&param_109), (&param_110));
            let _e261 = atomicCompareExchangeWeak((&unnamed.grid[_e254]), 0u, _e260);
            if (_e261.old_value == 0u) {
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e264 = i_5;
            i_5 = (_e264 + 1i);
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

    let _e211 = tuning.locustEatTicksMin;
    fast = _e211;
    let _e213 = tuning.locustEatTicksMax;
    slow = _e213;
    let _e214 = locustMaxCount_u0028_();
    cap = _e214;
    let _e215 = locustStage_u0028_();
    let _e216 = cap;
    floorCount = min(_e215, _e216);
    let _e218 = (*count_1);
    let _e219 = cap;
    if (_e218 >= _e219) {
        let _e221 = fast;
        return _e221;
    }
    let _e222 = (*count_1);
    let _e223 = floorCount;
    let _e225 = cap;
    let _e226 = floorCount;
    if ((_e222 <= _e223) || (_e225 == _e226)) {
        let _e229 = slow;
        return _e229;
    }
    let _e230 = (*count_1);
    let _e231 = floorCount;
    let _e234 = cap;
    let _e235 = floorCount;
    t_2 = (f32((_e230 - _e231)) / f32((_e234 - _e235)));
    let _e239 = slow;
    let _e241 = fast;
    let _e243 = t_2;
    return u32(round(mix(f32(_e239), f32(_e241), _e243)));
}

fn isLava_u0028_u1_u003b(type_34: ptr<function, u32>) -> bool {
    let _e205 = (*type_34);
    let _e207 = (*type_34);
    return ((_e205 >= 8u) && (_e207 <= 11u));
}

fn updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_6: ptr<function, vec3<i32>>, currentIndex_3: ptr<function, u32>, rawValue_2: ptr<function, u32>, currentDir_1: ptr<function, u32>, currentSleep: ptr<function, u32>, currentAge_2: ptr<function, u32>, randVal_3: ptr<function, f32>) {
    var type_35: u32;
    var param_111: u32;
    var start_5: i32;
    var i_6: i32;
    var nPos: vec3<i32>;
    var param_112: i32;
    var param_113: vec3<i32>;
    var nType: u32;
    var param_114: vec3<i32>;
    var param_115: u32;
    var param_116: u32;
    var param_117: u32;
    var phase: u32;
    var param_118: u32;
    var param_119: u32;
    var param_120: u32;
    var param_121: u32;
    var count_2: u32;
    var belowPos_1: vec3<i32>;
    var belowIndex: u32;
    var param_122: vec3<i32>;
    var belowValue: u32;
    var param_123: u32;
    var param_124: u32;
    var onLeaf: bool;
    var param_125: u32;
    var need: u32;
    var param_126: u32;
    var progress: u32;
    var flora_1: u32;
    var bite: u32;
    var thinned: u32;
    var local_6: u32;
    var param_127: u32;
    var param_128: u32;
    var param_129: u32;
    var param_130: u32;
    var param_131: u32;
    var param_132: u32;
    var param_133: u32;
    var param_134: u32;
    var param_135: u32;
    var param_136: u32;
    var stripped: u32;
    var local_7: u32;
    var param_137: u32;
    var param_138: u32;
    var param_139: u32;
    var param_140: u32;
    var param_141: u32;
    var param_142: u32;
    var grown: u32;
    var param_143: vec3<i32>;
    var param_144: f32;
    var param_145: u32;
    var param_146: u32;
    var param_147: u32;
    var param_148: u32;
    var param_149: u32;
    var newType: u32;
    var param_150: u32;
    var param_151: u32;
    var param_152: vec3<i32>;
    var param_153: vec3<i32>;
    var param_154: vec3<i32>;
    var param_155: u32;
    var param_156: u32;
    var param_157: u32;
    var param_158: u32;
    var param_159: u32;
    var param_160: u32;
    var param_161: u32;
    var param_162: u32;
    var param_163: u32;
    var heading_1: u32;
    var param_164: u32;
    var steps_1: u32;
    var param_165: u32;
    var start_6: i32;
    var i_7: i32;
    var d_4: i32;
    var c_5: vec3<i32>;
    var param_166: i32;
    var rise: i32;
    var t_3: vec3<i32>;
    var local_8: i32;
    var param_167: vec3<i32>;
    var param_168: vec3<i32>;
    var param_169: u32;
    var param_170: vec3<i32>;
    var param_171: vec3<i32>;
    var param_172: u32;
    var param_173: u32;
    var param_174: u32;
    var param_175: u32;
    var param_176: u32;
    var param_177: u32;
    var param_178: u32;
    var param_179: u32;
    var target_: vec3<i32>;
    var param_180: i32;
    var blocked: bool;
    var param_181: vec3<i32>;
    var param_182: vec3<i32>;
    var param_183: u32;
    var footing: vec3<i32>;
    var param_184: vec3<i32>;
    var param_185: vec3<i32>;
    var param_186: u32;
    var back: u32;
    var param_187: u32;
    var backPos: vec3<i32>;
    var param_188: i32;
    var backFoot: vec3<i32>;
    var backOpen: bool;
    var param_189: vec3<i32>;
    var param_190: vec3<i32>;
    var param_191: u32;
    var param_192: vec3<i32>;
    var param_193: vec3<i32>;
    var param_194: u32;
    var turnedNav: u32;
    var local_9: u32;
    var param_195: u32;
    var param_196: u32;
    var param_197: u32;
    var param_198: u32;
    var param_199: u32;
    var param_200: u32;
    var param_201: u32;
    var param_202: u32;
    var nav_1: u32;
    var param_203: u32;
    var param_204: u32;
    var param_205: vec3<i32>;
    var param_206: vec3<i32>;
    var param_207: u32;
    var param_208: u32;
    var param_209: u32;
    var param_210: u32;
    var param_211: u32;
    var param_212: u32;
    var param_213: u32;
    var param_214: u32;
    var param_215: u32;
    var overTop: vec3<i32>;
    var param_216: vec3<i32>;
    var param_217: vec3<i32>;
    var param_218: u32;
    var nav_2: u32;
    var param_219: u32;
    var param_220: u32;
    var param_221: vec3<i32>;
    var param_222: vec3<i32>;
    var param_223: u32;
    var param_224: u32;
    var param_225: u32;
    var param_226: u32;
    var param_227: u32;
    var param_228: u32;
    var param_229: u32;
    var param_230: u32;
    var param_231: u32;
    var up: vec3<i32>;
    var param_232: vec3<i32>;
    var param_233: vec3<i32>;
    var param_234: u32;
    var nav_3: u32;
    var param_235: u32;
    var param_236: u32;
    var param_237: vec3<i32>;
    var param_238: vec3<i32>;
    var param_239: u32;
    var param_240: u32;
    var param_241: u32;
    var param_242: u32;
    var param_243: u32;
    var param_244: u32;
    var param_245: u32;
    var param_246: u32;
    var param_247: u32;
    var param_248: u32;
    var param_249: u32;
    var param_250: u32;
    var param_251: u32;
    var param_252: u32;
    var param_253: u32;
    var phi_7173_: bool;
    var phi_7381_: bool;
    var phi_7388_: bool;
    var phi_7549_: bool;
    var phi_7568_: bool;
    var phi_7597_: bool;
    var phi_7611_: bool;
    var phi_7613_: bool;
    var phi_7705_: bool;
    var phi_7754_: bool;

    let _e398 = (*rawValue_2);
    param_111 = _e398;
    let _e399 = getType_u0028_u1_u003b((&param_111));
    type_35 = _e399;
    let _e400 = (*randVal_3);
    start_5 = i32((fract((_e400 * 61f)) * 26f));
    i_6 = 0i;
    loop {
        let _e405 = i_6;
        if (_e405 < 26i) {
            let _e407 = (*pos_6);
            let _e408 = start_5;
            let _e409 = i_6;
            let _e410 = (_e408 + _e409);
            param_112 = (_e410 - (i32(floor((f32(_e410) / f32(26i)))) * 26i));
            let _e418 = tree26_u0028_i1_u003b((&param_112));
            nPos = (_e407 + _e418);
            let _e420 = nPos;
            param_113 = _e420;
            let _e421 = locustInBounds_u0028_vi3_u003b((&param_113));
            if !(_e421) {
                continue;
            }
            let _e423 = nPos;
            param_114 = _e423;
            let _e424 = getIndex_u0028_vi3_u003b((&param_114));
            param_115 = _e424;
            let _e425 = readCell_u0028_u1_u003b((&param_115));
            param_116 = _e425;
            let _e426 = getType_u0028_u1_u003b((&param_116));
            nType = _e426;
            let _e427 = nType;
            let _e428 = (_e427 == 5u);
            phi_7173_ = _e428;
            if !(_e428) {
                let _e430 = nType;
                param_117 = _e430;
                let _e431 = isLava_u0028_u1_u003b((&param_117));
                phi_7173_ = _e431;
            }
            let _e433 = phi_7173_;
            if _e433 {
                let _e434 = (*currentIndex_3);
                let _e437 = (*rawValue_2);
                let _e438 = atomicCompareExchangeWeak((&unnamed.grid[_e434]), _e437, 0u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e440 = i_6;
            i_6 = (_e440 + 1i);
        }
    }
    let _e442 = (*currentSleep);
    phase = (_e442 + 1u);
    let _e444 = phase;
    let _e446 = tuning.locustTickDispatches;
    if (_e444 < _e446) {
        let _e448 = (*currentIndex_3);
        let _e451 = (*rawValue_2);
        let _e452 = type_35;
        param_118 = _e452;
        let _e453 = (*currentDir_1);
        param_119 = _e453;
        let _e454 = phase;
        param_120 = _e454;
        let _e455 = (*currentAge_2);
        param_121 = _e455;
        let _e456 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_118), (&param_119), (&param_120), (&param_121));
        let _e457 = atomicCompareExchangeWeak((&unnamed.grid[_e448]), _e451, _e456);
        return;
    }
    let _e459 = (*currentAge_2);
    count_2 = _e459;
    let _e460 = (*pos_6);
    belowPos_1 = (_e460 + vec3<i32>(0i, -1i, 0i));
    let _e462 = belowPos_1;
    param_122 = _e462;
    let _e463 = getIndex_u0028_vi3_u003b((&param_122));
    belowIndex = _e463;
    let _e464 = belowIndex;
    param_123 = _e464;
    let _e465 = readCell_u0028_u1_u003b((&param_123));
    belowValue = _e465;
    let _e466 = belowValue;
    param_124 = _e466;
    let _e467 = isLocustFood_u0028_u1_u003b((&param_124));
    if _e467 {
        let _e468 = belowValue;
        param_125 = _e468;
        let _e469 = getType_u0028_u1_u003b((&param_125));
        onLeaf = (_e469 == 19u);
        let _e471 = count_2;
        param_126 = _e471;
        let _e472 = locustEatTicks_u0028_u1_u003b((&param_126));
        need = _e472;
        let _e473 = (*currentDir_1);
        progress = (_e473 + 1u);
        let _e475 = progress;
        let _e476 = need;
        if (_e475 < _e476) {
            let _e478 = onLeaf;
            if !(_e478) {
                let _e480 = belowValue;
                flora_1 = ((_e480 >> bitcast<u32>(8i)) & 255u);
                let _e484 = need;
                bite = max((90u / max(_e484, 1u)), 1u);
                let _e488 = flora_1;
                let _e489 = bite;
                if (_e488 > (11u + _e489)) {
                    let _e492 = flora_1;
                    let _e493 = bite;
                    local_6 = (_e492 - _e493);
                } else {
                    local_6 = 11u;
                }
                let _e495 = local_6;
                thinned = _e495;
                let _e496 = belowIndex;
                let _e499 = belowValue;
                let _e500 = belowValue;
                param_127 = _e500;
                let _e501 = getSleep_u0028_u1_u003b((&param_127));
                let _e502 = belowValue;
                param_128 = _e502;
                let _e503 = getAge_u0028_u1_u003b((&param_128));
                param_129 = 4u;
                let _e504 = thinned;
                param_130 = _e504;
                param_131 = _e501;
                param_132 = _e503;
                let _e505 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_129), (&param_130), (&param_131), (&param_132));
                let _e506 = atomicCompareExchangeWeak((&unnamed.grid[_e496]), _e499, _e505);
            }
            let _e508 = (*currentIndex_3);
            let _e511 = (*rawValue_2);
            let _e512 = type_35;
            param_133 = _e512;
            let _e513 = progress;
            param_134 = _e513;
            param_135 = 0u;
            let _e514 = count_2;
            param_136 = _e514;
            let _e515 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_133), (&param_134), (&param_135), (&param_136));
            let _e516 = atomicCompareExchangeWeak((&unnamed.grid[_e508]), _e511, _e515);
            return;
        }
        let _e518 = onLeaf;
        if _e518 {
            local_7 = 0u;
        } else {
            let _e519 = belowValue;
            param_137 = _e519;
            let _e520 = getSleep_u0028_u1_u003b((&param_137));
            let _e521 = belowValue;
            param_138 = _e521;
            let _e522 = getAge_u0028_u1_u003b((&param_138));
            param_139 = 4u;
            param_140 = 0u;
            param_141 = _e520;
            param_142 = _e522;
            let _e523 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_139), (&param_140), (&param_141), (&param_142));
            local_7 = _e523;
        }
        let _e524 = local_7;
        stripped = _e524;
        let _e525 = belowIndex;
        let _e528 = belowValue;
        let _e529 = stripped;
        let _e530 = atomicCompareExchangeWeak((&unnamed.grid[_e525]), _e528, _e529);
        let _e532 = belowValue;
        if (_e530.old_value != _e532) {
            return;
        }
        let _e534 = count_2;
        let _e536 = tuning.locustEatGain;
        grown = (_e534 + _e536);
        let _e538 = grown;
        let _e539 = locustMaxCount_u0028_();
        if (_e538 > _e539) {
            let _e541 = (*pos_6);
            param_143 = _e541;
            let _e542 = (*randVal_3);
            param_144 = _e542;
            locustBud_u0028_vi3_u003b_f1_u003b((&param_143), (&param_144));
            let _e543 = locustMaxCount_u0028_();
            grown = _e543;
        }
        let _e544 = (*currentIndex_3);
        let _e547 = (*rawValue_2);
        let _e548 = grown;
        param_145 = _e548;
        let _e549 = locustTypeFor_u0028_u1_u003b((&param_145));
        param_146 = _e549;
        param_147 = 0u;
        param_148 = 0u;
        let _e550 = grown;
        param_149 = _e550;
        let _e551 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_146), (&param_147), (&param_148), (&param_149));
        let _e552 = atomicCompareExchangeWeak((&unnamed.grid[_e544]), _e547, _e551);
        return;
    }
    let _e554 = count_2;
    if (_e554 <= 1u) {
        let _e556 = (*currentIndex_3);
        let _e559 = (*rawValue_2);
        let _e560 = atomicCompareExchangeWeak((&unnamed.grid[_e556]), _e559, 0u);
        return;
    }
    let _e562 = count_2;
    count_2 = (_e562 - 1u);
    let _e564 = count_2;
    param_150 = _e564;
    let _e565 = locustTypeFor_u0028_u1_u003b((&param_150));
    newType = _e565;
    let _e566 = belowValue;
    param_151 = _e566;
    let _e567 = getType_u0028_u1_u003b((&param_151));
    let _e568 = (_e567 == 0u);
    phi_7381_ = _e568;
    if _e568 {
        let _e569 = belowPos_1;
        param_152 = _e569;
        let _e570 = locustInBounds_u0028_vi3_u003b((&param_152));
        phi_7381_ = _e570;
    }
    let _e572 = phi_7381_;
    phi_7388_ = _e572;
    if _e572 {
        let _e573 = (*pos_6);
        param_153 = _e573;
        let _e574 = locustHasGrip_u0028_vi3_u003b((&param_153));
        phi_7388_ = !(_e574);
    }
    let _e577 = phi_7388_;
    if _e577 {
        let _e578 = belowPos_1;
        param_154 = _e578;
        let _e579 = (*currentDir_1);
        param_155 = _e579;
        let _e580 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_154), (&param_155));
        let _e581 = newType;
        param_156 = _e581;
        param_157 = _e580;
        param_158 = 0u;
        let _e582 = count_2;
        param_159 = _e582;
        let _e583 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_156), (&param_157), (&param_158), (&param_159));
        let _e584 = (*currentIndex_3);
        param_160 = _e584;
        let _e585 = (*rawValue_2);
        param_161 = _e585;
        let _e586 = belowIndex;
        param_162 = _e586;
        param_163 = _e583;
        let _e587 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_160), (&param_161), (&param_162), (&param_163));
        if _e587 {
            return;
        }
    }
    let _e588 = (*currentDir_1);
    param_164 = _e588;
    let _e589 = locustHeading_u0028_u1_u003b((&param_164));
    heading_1 = _e589;
    let _e590 = (*currentDir_1);
    param_165 = _e590;
    let _e591 = locustSteps_u0028_u1_u003b((&param_165));
    steps_1 = _e591;
    let _e592 = steps_1;
    if (_e592 == 0u) {
        let _e594 = (*randVal_3);
        start_6 = i32((fract((_e594 * 17f)) * 8f));
        i_7 = 0i;
        loop {
            let _e599 = i_7;
            if (_e599 < 8i) {
                let _e601 = start_6;
                let _e602 = i_7;
                let _e603 = (_e601 + _e602);
                d_4 = (_e603 - (i32(floor((f32(_e603) / f32(8i)))) * 8i));
                let _e611 = (*pos_6);
                let _e612 = d_4;
                param_166 = _e612;
                let _e613 = getHDir_u0028_i1_u003b((&param_166));
                c_5 = (_e611 + _e613);
                rise = 0i;
                loop {
                    let _e615 = rise;
                    if (_e615 < 3i) {
                        let _e617 = c_5;
                        let _e618 = rise;
                        if (_e618 == 1i) {
                            local_8 = 1i;
                        } else {
                            let _e620 = rise;
                            local_8 = select(0i, -1i, (_e620 == 2i));
                        }
                        let _e623 = local_8;
                        t_3 = (_e617 + vec3<i32>(0i, _e623, 0i));
                        let _e626 = t_3;
                        param_167 = _e626;
                        let _e627 = locustInBounds_u0028_vi3_u003b((&param_167));
                        if !(_e627) {
                            continue;
                        }
                        let _e629 = t_3;
                        param_168 = _e629;
                        let _e630 = getIndex_u0028_vi3_u003b((&param_168));
                        param_169 = _e630;
                        let _e631 = readCell_u0028_u1_u003b((&param_169));
                        if (_e631 != 0u) {
                            continue;
                        }
                        let _e633 = t_3;
                        param_170 = (_e633 + vec3<i32>(0i, -1i, 0i));
                        let _e635 = locustFoodAt_u0028_vi3_u003b((&param_170));
                        if !(_e635) {
                            continue;
                        }
                        let _e637 = t_3;
                        param_171 = _e637;
                        let _e638 = getIndex_u0028_vi3_u003b((&param_171));
                        let _e639 = newType;
                        param_172 = _e639;
                        param_173 = 0u;
                        param_174 = 0u;
                        let _e640 = count_2;
                        param_175 = _e640;
                        let _e641 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_172), (&param_173), (&param_174), (&param_175));
                        let _e642 = (*currentIndex_3);
                        param_176 = _e642;
                        let _e643 = (*rawValue_2);
                        param_177 = _e643;
                        param_178 = _e638;
                        param_179 = _e641;
                        let _e644 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_176), (&param_177), (&param_178), (&param_179));
                        if _e644 {
                            return;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e645 = rise;
                        rise = (_e645 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e647 = i_7;
                i_7 = (_e647 + 1i);
            }
        }
        let _e649 = (*randVal_3);
        heading_1 = (u32((fract((_e649 * 23f)) * 8f)) & 7u);
        let _e655 = locustRunSteps_u0028_();
        steps_1 = _e655;
    }
    let _e656 = (*pos_6);
    let _e657 = heading_1;
    param_180 = bitcast<i32>(_e657);
    let _e659 = getHDir_u0028_i1_u003b((&param_180));
    target_ = (_e656 + _e659);
    let _e661 = target_;
    param_181 = _e661;
    let _e662 = locustInBounds_u0028_vi3_u003b((&param_181));
    let _e663 = !(_e662);
    phi_7549_ = _e663;
    if !(_e663) {
        let _e665 = target_;
        param_182 = _e665;
        let _e666 = getIndex_u0028_vi3_u003b((&param_182));
        param_183 = _e666;
        let _e667 = readCell_u0028_u1_u003b((&param_183));
        phi_7549_ = (_e667 != 0u);
    }
    let _e670 = phi_7549_;
    blocked = _e670;
    let _e671 = blocked;
    if !(_e671) {
        let _e673 = target_;
        footing = (_e673 + vec3<i32>(0i, -1i, 0i));
        let _e675 = footing;
        param_184 = _e675;
        let _e676 = locustInBounds_u0028_vi3_u003b((&param_184));
        phi_7568_ = _e676;
        if _e676 {
            let _e677 = footing;
            param_185 = _e677;
            let _e678 = getIndex_u0028_vi3_u003b((&param_185));
            param_186 = _e678;
            let _e679 = readCell_u0028_u1_u003b((&param_186));
            phi_7568_ = (_e679 == 0u);
        }
        let _e682 = phi_7568_;
        if _e682 {
            let _e683 = heading_1;
            param_187 = _e683;
            let _e684 = locustReverse_u0028_u1_u003b((&param_187));
            back = _e684;
            let _e685 = (*pos_6);
            let _e686 = back;
            param_188 = bitcast<i32>(_e686);
            let _e688 = getHDir_u0028_i1_u003b((&param_188));
            backPos = (_e685 + _e688);
            let _e690 = backPos;
            backFoot = (_e690 + vec3<i32>(0i, -1i, 0i));
            let _e692 = backPos;
            param_189 = _e692;
            let _e693 = locustInBounds_u0028_vi3_u003b((&param_189));
            phi_7597_ = _e693;
            if _e693 {
                let _e694 = backPos;
                param_190 = _e694;
                let _e695 = getIndex_u0028_vi3_u003b((&param_190));
                param_191 = _e695;
                let _e696 = readCell_u0028_u1_u003b((&param_191));
                phi_7597_ = (_e696 == 0u);
            }
            let _e699 = phi_7597_;
            phi_7613_ = _e699;
            if _e699 {
                let _e700 = backFoot;
                param_192 = _e700;
                let _e701 = locustInBounds_u0028_vi3_u003b((&param_192));
                phi_7611_ = _e701;
                if _e701 {
                    let _e702 = backFoot;
                    param_193 = _e702;
                    let _e703 = getIndex_u0028_vi3_u003b((&param_193));
                    param_194 = _e703;
                    let _e704 = readCell_u0028_u1_u003b((&param_194));
                    phi_7611_ = (_e704 == 0u);
                }
                let _e707 = phi_7611_;
                phi_7613_ = !(_e707);
            }
            let _e710 = phi_7613_;
            backOpen = _e710;
            let _e711 = backOpen;
            if _e711 {
                let _e712 = back;
                param_195 = _e712;
                let _e713 = steps_1;
                param_196 = _e713;
                let _e714 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_195), (&param_196));
                local_9 = _e714;
            } else {
                let _e715 = (*randVal_3);
                let _e721 = locustRunSteps_u0028_();
                param_197 = (u32((fract((_e715 * 71f)) * 8f)) & 7u);
                param_198 = _e721;
                let _e722 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_197), (&param_198));
                local_9 = _e722;
            }
            let _e723 = local_9;
            turnedNav = _e723;
            let _e724 = (*currentIndex_3);
            let _e727 = (*rawValue_2);
            let _e728 = newType;
            param_199 = _e728;
            let _e729 = turnedNav;
            param_200 = _e729;
            param_201 = 0u;
            let _e730 = count_2;
            param_202 = _e730;
            let _e731 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_199), (&param_200), (&param_201), (&param_202));
            let _e732 = atomicCompareExchangeWeak((&unnamed.grid[_e724]), _e727, _e731);
            return;
        }
        let _e734 = steps_1;
        let _e736 = heading_1;
        param_203 = _e736;
        param_204 = (_e734 - 1u);
        let _e737 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_203), (&param_204));
        nav_1 = _e737;
        let _e738 = target_;
        param_205 = _e738;
        let _e739 = getIndex_u0028_vi3_u003b((&param_205));
        let _e740 = target_;
        param_206 = _e740;
        let _e741 = nav_1;
        param_207 = _e741;
        let _e742 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_206), (&param_207));
        let _e743 = newType;
        param_208 = _e743;
        param_209 = _e742;
        param_210 = 0u;
        let _e744 = count_2;
        param_211 = _e744;
        let _e745 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_208), (&param_209), (&param_210), (&param_211));
        let _e746 = (*currentIndex_3);
        param_212 = _e746;
        let _e747 = (*rawValue_2);
        param_213 = _e747;
        param_214 = _e739;
        param_215 = _e745;
        let _e748 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_212), (&param_213), (&param_214), (&param_215));
        if _e748 {
            return;
        }
    } else {
        let _e749 = (*randVal_3);
        let _e753 = tuning.locustClimbChance;
        if (fract((_e749 * 41f)) < _e753) {
            let _e755 = target_;
            overTop = (_e755 + vec3<i32>(0i, 1i, 0i));
            let _e757 = overTop;
            param_216 = _e757;
            let _e758 = locustInBounds_u0028_vi3_u003b((&param_216));
            phi_7705_ = _e758;
            if _e758 {
                let _e759 = overTop;
                param_217 = _e759;
                let _e760 = getIndex_u0028_vi3_u003b((&param_217));
                param_218 = _e760;
                let _e761 = readCell_u0028_u1_u003b((&param_218));
                phi_7705_ = (_e761 == 0u);
            }
            let _e764 = phi_7705_;
            if _e764 {
                let _e765 = steps_1;
                let _e767 = heading_1;
                param_219 = _e767;
                param_220 = (_e765 - 1u);
                let _e768 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_219), (&param_220));
                nav_2 = _e768;
                let _e769 = overTop;
                param_221 = _e769;
                let _e770 = getIndex_u0028_vi3_u003b((&param_221));
                let _e771 = overTop;
                param_222 = _e771;
                let _e772 = nav_2;
                param_223 = _e772;
                let _e773 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_222), (&param_223));
                let _e774 = newType;
                param_224 = _e774;
                param_225 = _e773;
                param_226 = 0u;
                let _e775 = count_2;
                param_227 = _e775;
                let _e776 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_224), (&param_225), (&param_226), (&param_227));
                let _e777 = (*currentIndex_3);
                param_228 = _e777;
                let _e778 = (*rawValue_2);
                param_229 = _e778;
                param_230 = _e770;
                param_231 = _e776;
                let _e779 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_228), (&param_229), (&param_230), (&param_231));
                if _e779 {
                    return;
                }
            }
            let _e780 = (*pos_6);
            up = (_e780 + vec3<i32>(0i, 1i, 0i));
            let _e782 = up;
            param_232 = _e782;
            let _e783 = locustInBounds_u0028_vi3_u003b((&param_232));
            phi_7754_ = _e783;
            if _e783 {
                let _e784 = up;
                param_233 = _e784;
                let _e785 = getIndex_u0028_vi3_u003b((&param_233));
                param_234 = _e785;
                let _e786 = readCell_u0028_u1_u003b((&param_234));
                phi_7754_ = (_e786 == 0u);
            }
            let _e789 = phi_7754_;
            if _e789 {
                let _e790 = heading_1;
                param_235 = _e790;
                let _e791 = steps_1;
                param_236 = _e791;
                let _e792 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_235), (&param_236));
                nav_3 = _e792;
                let _e793 = up;
                param_237 = _e793;
                let _e794 = getIndex_u0028_vi3_u003b((&param_237));
                let _e795 = up;
                param_238 = _e795;
                let _e796 = nav_3;
                param_239 = _e796;
                let _e797 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_238), (&param_239));
                let _e798 = newType;
                param_240 = _e798;
                param_241 = _e797;
                param_242 = 0u;
                let _e799 = count_2;
                param_243 = _e799;
                let _e800 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_240), (&param_241), (&param_242), (&param_243));
                let _e801 = (*currentIndex_3);
                param_244 = _e801;
                let _e802 = (*rawValue_2);
                param_245 = _e802;
                param_246 = _e794;
                param_247 = _e800;
                let _e803 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_244), (&param_245), (&param_246), (&param_247));
                if _e803 {
                    return;
                }
            }
        }
        let _e804 = (*randVal_3);
        heading_1 = (u32((fract((_e804 * 53f)) * 8f)) & 7u);
        let _e810 = locustRunSteps_u0028_();
        steps_1 = _e810;
    }
    let _e811 = (*currentIndex_3);
    let _e814 = (*rawValue_2);
    let _e815 = heading_1;
    param_248 = _e815;
    let _e816 = steps_1;
    param_249 = _e816;
    let _e817 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_248), (&param_249));
    let _e818 = newType;
    param_250 = _e818;
    param_251 = _e817;
    param_252 = 0u;
    let _e819 = count_2;
    param_253 = _e819;
    let _e820 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_250), (&param_251), (&param_252), (&param_253));
    let _e821 = atomicCompareExchangeWeak((&unnamed.grid[_e811]), _e814, _e820);
    return;
}

fn updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_7: ptr<function, vec3<i32>>, currentIndex_4: ptr<function, u32>, rawValue_3: ptr<function, u32>, currentAge_3: ptr<function, u32>, randVal_4: ptr<function, f32>) {
    var belowPos_2: vec3<i32>;
    var param_254: vec3<i32>;
    var param_255: u32;
    var param_256: u32;
    var param_257: vec3<i32>;
    var param_258: u32;
    var param_259: u32;
    var param_260: u32;
    var param_261: u32;
    var param_262: u32;
    var param_263: u32;
    var param_264: u32;
    var param_265: u32;
    var param_266: u32;
    var param_267: u32;
    var param_268: u32;
    var param_269: u32;
    var phi_6381_: bool;

    let _e227 = (*pos_7)[1u];
    if (_e227 > 1i) {
        let _e229 = (*pos_7);
        belowPos_2 = (_e229 + vec3<i32>(0i, -1i, 0i));
        let _e231 = belowPos_2;
        param_254 = _e231;
        let _e232 = getIndex_u0028_vi3_u003b((&param_254));
        param_255 = _e232;
        let _e233 = readCell_u0028_u1_u003b((&param_255));
        param_256 = _e233;
        let _e234 = getType_u0028_u1_u003b((&param_256));
        if (_e234 == 0u) {
            let _e236 = belowPos_2;
            param_257 = _e236;
            let _e237 = getIndex_u0028_vi3_u003b((&param_257));
            param_258 = 12u;
            param_259 = 0u;
            param_260 = 0u;
            let _e238 = (*currentAge_3);
            param_261 = _e238;
            let _e239 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_258), (&param_259), (&param_260), (&param_261));
            let _e240 = (*currentIndex_4);
            param_262 = _e240;
            let _e241 = (*rawValue_3);
            param_263 = _e241;
            param_264 = _e237;
            param_265 = _e239;
            let _e242 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_262), (&param_263), (&param_264), (&param_265));
            if _e242 {
                return;
            }
        }
    }
    let _e243 = (*currentAge_3);
    let _e244 = (_e243 > 0u);
    phi_6381_ = _e244;
    if _e244 {
        let _e245 = (*randVal_4);
        let _e249 = tuning.darkStoneDryChance;
        phi_6381_ = (fract((_e245 * 23f)) < _e249);
    }
    let _e252 = phi_6381_;
    if _e252 {
        let _e253 = (*currentIndex_4);
        let _e256 = (*rawValue_3);
        let _e257 = (*currentAge_3);
        param_266 = 12u;
        param_267 = 0u;
        param_268 = 0u;
        param_269 = (_e257 - 1u);
        let _e259 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_266), (&param_267), (&param_268), (&param_269));
        let _e260 = atomicCompareExchangeWeak((&unnamed.grid[_e253]), _e256, _e259);
    }
    return;
}

fn lavaTypeFor_u0028_u1_u003b(coolness: ptr<function, u32>) -> u32 {
    let _e205 = (*coolness);
    let _e207 = tuning.lavaStageSize;
    return (8u + min((_e205 / max(_e207, 1u)), 3u));
}

fn lavaSolidifyCoolness_u0028_() -> u32 {
    let _e205 = tuning.lavaStageSize;
    return min((max(_e205, 1u) * 4u), 255u);
}

fn decWater_u0028_() {
    let _e205 = atomicAdd((&unnamed_2.waterVoxelCount), 4294967295u);
    return;
}

fn getOrthoDir_u0028_i1_u003b(d_5: ptr<function, i32>) -> vec3<i32> {
    let _e205 = (*d_5);
    if (_e205 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e207 = (*d_5);
    if (_e207 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e209 = (*d_5);
    if (_e209 == 2i) {
        return vec3<i32>(0i, 1i, 0i);
    }
    let _e211 = (*d_5);
    if (_e211 == 3i) {
        return vec3<i32>(0i, -1i, 0i);
    }
    let _e213 = (*d_5);
    if (_e213 == 4i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    return vec3<i32>(0i, 0i, -1i);
}

fn lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b(pos_8: ptr<function, vec3<i32>>, coolness_1: ptr<function, u32>, randVal_5: ptr<function, f32>) {
    var startDir: i32;
    var i_8: i32;
    var d_6: i32;
    var nPos_1: vec3<i32>;
    var param_270: i32;
    var nIndex: u32;
    var param_271: vec3<i32>;
    var nVal: u32;
    var param_272: u32;
    var nType_1: u32;
    var param_273: u32;
    var param_274: u32;
    var param_275: u32;
    var param_276: u32;
    var param_277: u32;
    var param_278: u32;
    var param_279: u32;
    var param_280: u32;
    var param_281: u32;
    var param_282: u32;
    var param_283: u32;
    var param_284: u32;
    var param_285: u32;
    var moisture_1: u32;
    var param_286: u32;
    var flora_2: u32;
    var param_287: u32;
    var abovePos: vec3<i32>;
    var param_288: vec3<i32>;
    var param_289: u32;
    var param_290: u32;
    var param_291: vec3<i32>;
    var param_292: u32;
    var param_293: u32;
    var param_294: u32;
    var param_295: u32;
    var param_296: u32;
    var param_297: u32;
    var param_298: u32;
    var param_299: u32;
    var param_300: u32;
    var nCool: u32;
    var param_301: u32;
    var raised: u32;
    var raisedType: u32;
    var local_10: u32;
    var param_302: u32;
    var param_303: u32;
    var param_304: u32;
    var param_305: u32;
    var param_306: u32;
    var param_307: u32;
    var nCool_1: u32;
    var param_308: u32;
    var draws: bool;
    var lowered: u32;
    var local_11: u32;
    var melts: bool;
    var newType_1: u32;
    var local_12: u32;
    var param_309: u32;
    var param_310: u32;
    var param_311: u32;
    var param_312: u32;
    var param_313: u32;
    var phi_5435_: bool;
    var phi_5442_: bool;
    var phi_5453_: bool;
    var phi_5460_: bool;
    var phi_5471_: bool;
    var phi_5610_: bool;
    var phi_5621_: bool;

    let _e272 = (*randVal_5);
    startDir = i32((fract((_e272 * 17f)) * 6f));
    i_8 = 0i;
    loop {
        let _e277 = i_8;
        if (_e277 < 6i) {
            let _e279 = startDir;
            let _e280 = i_8;
            let _e281 = (_e279 + _e280);
            d_6 = (_e281 - (i32(floor((f32(_e281) / f32(6i)))) * 6i));
            let _e289 = (*pos_8);
            let _e290 = d_6;
            param_270 = _e290;
            let _e291 = getOrthoDir_u0028_i1_u003b((&param_270));
            nPos_1 = (_e289 + _e291);
            let _e294 = nPos_1[0u];
            let _e295 = (_e294 <= 0i);
            phi_5435_ = _e295;
            if !(_e295) {
                let _e298 = nPos_1[0u];
                let _e300 = tuning.gridWidth;
                phi_5435_ = (_e298 >= (bitcast<i32>(_e300) - 1i));
            }
            let _e305 = phi_5435_;
            phi_5442_ = _e305;
            if !(_e305) {
                let _e308 = nPos_1[1u];
                phi_5442_ = (_e308 <= 0i);
            }
            let _e311 = phi_5442_;
            phi_5453_ = _e311;
            if !(_e311) {
                let _e314 = nPos_1[1u];
                let _e316 = tuning.gridHeight;
                phi_5453_ = (_e314 >= (bitcast<i32>(_e316) - 1i));
            }
            let _e321 = phi_5453_;
            phi_5460_ = _e321;
            if !(_e321) {
                let _e324 = nPos_1[2u];
                phi_5460_ = (_e324 <= 0i);
            }
            let _e327 = phi_5460_;
            phi_5471_ = _e327;
            if !(_e327) {
                let _e330 = nPos_1[2u];
                let _e332 = tuning.gridDepth;
                phi_5471_ = (_e330 >= (bitcast<i32>(_e332) - 1i));
            }
            let _e337 = phi_5471_;
            if _e337 {
                continue;
            }
            let _e338 = nPos_1;
            param_271 = _e338;
            let _e339 = getIndex_u0028_vi3_u003b((&param_271));
            nIndex = _e339;
            let _e340 = nIndex;
            param_272 = _e340;
            let _e341 = readCell_u0028_u1_u003b((&param_272));
            nVal = _e341;
            let _e342 = nVal;
            param_273 = _e342;
            let _e343 = getType_u0028_u1_u003b((&param_273));
            nType_1 = _e343;
            let _e344 = nType_1;
            if (_e344 == 2u) {
                let _e346 = nIndex;
                let _e349 = nVal;
                param_274 = 6u;
                param_275 = 0u;
                param_276 = 0u;
                param_277 = 0u;
                let _e350 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_274), (&param_275), (&param_276), (&param_277));
                let _e351 = atomicCompareExchangeWeak((&unnamed.grid[_e346]), _e349, _e350);
                let _e353 = nVal;
                if (_e351.old_value == _e353) {
                    decWater_u0028_();
                    let _e355 = (*coolness_1);
                    let _e357 = tuning.lavaWaterCool;
                    (*coolness_1) = min((_e355 + _e357), 255u);
                    return;
                }
            } else {
                let _e360 = nType_1;
                if (_e360 == 19u) {
                    let _e362 = nIndex;
                    let _e365 = nVal;
                    let _e366 = atomicCompareExchangeWeak((&unnamed.grid[_e362]), _e365, 0u);
                    let _e368 = nVal;
                    if (_e366.old_value == _e368) {
                        return;
                    }
                } else {
                    let _e370 = nType_1;
                    if (_e370 == 18u) {
                        let _e372 = nIndex;
                        let _e375 = nVal;
                        param_278 = 5u;
                        param_279 = 0u;
                        param_280 = 0u;
                        param_281 = 0u;
                        let _e376 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_278), (&param_279), (&param_280), (&param_281));
                        let _e377 = atomicCompareExchangeWeak((&unnamed.grid[_e372]), _e375, _e376);
                        let _e379 = nVal;
                        if (_e377.old_value == _e379) {
                            return;
                        }
                    } else {
                        let _e381 = nType_1;
                        if (_e381 == 3u) {
                            let _e383 = nIndex;
                            let _e386 = nVal;
                            param_282 = 12u;
                            param_283 = 0u;
                            param_284 = 0u;
                            param_285 = 255u;
                            let _e387 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_282), (&param_283), (&param_284), (&param_285));
                            let _e388 = atomicCompareExchangeWeak((&unnamed.grid[_e383]), _e386, _e387);
                            let _e390 = nVal;
                            if (_e388.old_value == _e390) {
                                return;
                            }
                        } else {
                            let _e392 = nType_1;
                            let _e394 = nType_1;
                            if ((_e392 == 1u) || (_e394 == 4u)) {
                                let _e397 = nVal;
                                param_286 = _e397;
                                let _e398 = getAge_u0028_u1_u003b((&param_286));
                                moisture_1 = _e398;
                                let _e399 = nVal;
                                param_287 = _e399;
                                let _e400 = getDir_u0028_u1_u003b((&param_287));
                                flora_2 = _e400;
                                let _e401 = nType_1;
                                let _e403 = flora_2;
                                let _e406 = flora_2;
                                if (((_e401 == 4u) && (_e403 > 10u)) && (_e406 <= 100u)) {
                                    let _e409 = nPos_1;
                                    abovePos = (_e409 + vec3<i32>(0i, 1i, 0i));
                                    let _e412 = abovePos[1u];
                                    let _e414 = tuning.gridHeight;
                                    let _e417 = (_e412 < (bitcast<i32>(_e414) - 1i));
                                    phi_5610_ = _e417;
                                    if _e417 {
                                        let _e418 = abovePos;
                                        param_288 = _e418;
                                        let _e419 = getIndex_u0028_vi3_u003b((&param_288));
                                        param_289 = _e419;
                                        let _e420 = readCell_u0028_u1_u003b((&param_289));
                                        param_290 = _e420;
                                        let _e421 = getType_u0028_u1_u003b((&param_290));
                                        phi_5610_ = (_e421 == 0u);
                                    }
                                    let _e424 = phi_5610_;
                                    phi_5621_ = _e424;
                                    if _e424 {
                                        let _e425 = (*randVal_5);
                                        let _e429 = tuning.lavaIgniteChance;
                                        phi_5621_ = (fract((_e425 * 41f)) < _e429);
                                    }
                                    let _e432 = phi_5621_;
                                    if _e432 {
                                        let _e433 = abovePos;
                                        param_291 = _e433;
                                        let _e434 = getIndex_u0028_vi3_u003b((&param_291));
                                        param_292 = 5u;
                                        param_293 = 0u;
                                        param_294 = 0u;
                                        param_295 = 0u;
                                        let _e437 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_292), (&param_293), (&param_294), (&param_295));
                                        let _e438 = atomicCompareExchangeWeak((&unnamed.grid[_e434]), 0u, _e437);
                                        if (_e438.old_value == 0u) {
                                            return;
                                        }
                                    }
                                } else {
                                    let _e441 = moisture_1;
                                    if (_e441 > 0u) {
                                        let _e443 = nIndex;
                                        let _e446 = nVal;
                                        let _e447 = moisture_1;
                                        let _e449 = nType_1;
                                        param_296 = _e449;
                                        let _e450 = flora_2;
                                        param_297 = _e450;
                                        param_298 = 0u;
                                        param_299 = (_e447 - 1u);
                                        let _e451 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_296), (&param_297), (&param_298), (&param_299));
                                        let _e452 = atomicCompareExchangeWeak((&unnamed.grid[_e443]), _e446, _e451);
                                        let _e454 = nVal;
                                        if (_e452.old_value == _e454) {
                                            let _e456 = (*coolness_1);
                                            let _e458 = tuning.lavaMoistureCool;
                                            (*coolness_1) = min((_e456 + _e458), 255u);
                                            return;
                                        }
                                    } else {
                                        let _e461 = (*randVal_5);
                                        let _e465 = tuning.lavaConsumeChance;
                                        if (fract((_e461 * 53f)) < _e465) {
                                            let _e467 = nIndex;
                                            let _e470 = nVal;
                                            let _e471 = atomicCompareExchangeWeak((&unnamed.grid[_e467]), _e470, 0u);
                                            let _e473 = nVal;
                                            if (_e471.old_value == _e473) {
                                                return;
                                            }
                                        }
                                    }
                                }
                            } else {
                                let _e475 = nType_1;
                                param_300 = _e475;
                                let _e476 = isLava_u0028_u1_u003b((&param_300));
                                if _e476 {
                                    let _e477 = nVal;
                                    param_301 = _e477;
                                    let _e478 = getAge_u0028_u1_u003b((&param_301));
                                    nCool = _e478;
                                    let _e479 = (*coolness_1);
                                    let _e480 = nCool;
                                    if (_e479 > (_e480 + 1u)) {
                                        let _e483 = nCool;
                                        raised = (_e483 + 1u);
                                        let _e485 = raised;
                                        let _e486 = lavaSolidifyCoolness_u0028_();
                                        if (_e485 >= _e486) {
                                            local_10 = 12u;
                                        } else {
                                            let _e488 = raised;
                                            param_302 = _e488;
                                            let _e489 = lavaTypeFor_u0028_u1_u003b((&param_302));
                                            local_10 = _e489;
                                        }
                                        let _e490 = local_10;
                                        raisedType = _e490;
                                        let _e491 = nIndex;
                                        let _e494 = nVal;
                                        let _e495 = nVal;
                                        param_303 = _e495;
                                        let _e496 = getDir_u0028_u1_u003b((&param_303));
                                        let _e497 = raisedType;
                                        param_304 = _e497;
                                        param_305 = _e496;
                                        param_306 = 0u;
                                        let _e498 = raised;
                                        param_307 = _e498;
                                        let _e499 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_304), (&param_305), (&param_306), (&param_307));
                                        let _e500 = atomicCompareExchangeWeak((&unnamed.grid[_e491]), _e494, _e499);
                                        let _e502 = nVal;
                                        if (_e500.old_value == _e502) {
                                            let _e504 = (*coolness_1);
                                            (*coolness_1) = (_e504 - 1u);
                                            return;
                                        }
                                    }
                                } else {
                                    let _e506 = nType_1;
                                    if (_e506 == 12u) {
                                        let _e508 = nVal;
                                        param_308 = _e508;
                                        let _e509 = getAge_u0028_u1_u003b((&param_308));
                                        nCool_1 = _e509;
                                        let _e510 = nCool_1;
                                        let _e511 = (*coolness_1);
                                        draws = (_e510 > (_e511 + 1u));
                                        let _e514 = draws;
                                        if _e514 {
                                            let _e515 = nCool_1;
                                            local_11 = (_e515 - 1u);
                                        } else {
                                            let _e517 = nCool_1;
                                            local_11 = _e517;
                                        }
                                        let _e518 = local_11;
                                        lowered = _e518;
                                        let _e519 = lowered;
                                        let _e520 = lavaSolidifyCoolness_u0028_();
                                        melts = (_e519 < _e520);
                                        let _e522 = draws;
                                        let _e523 = melts;
                                        if (_e522 || _e523) {
                                            let _e525 = melts;
                                            if _e525 {
                                                let _e526 = lowered;
                                                param_309 = _e526;
                                                let _e527 = lavaTypeFor_u0028_u1_u003b((&param_309));
                                                local_12 = _e527;
                                            } else {
                                                local_12 = 12u;
                                            }
                                            let _e528 = local_12;
                                            newType_1 = _e528;
                                            let _e529 = nIndex;
                                            let _e532 = nVal;
                                            let _e533 = newType_1;
                                            param_310 = _e533;
                                            param_311 = 0u;
                                            param_312 = 0u;
                                            let _e534 = lowered;
                                            param_313 = _e534;
                                            let _e535 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_310), (&param_311), (&param_312), (&param_313));
                                            let _e536 = atomicCompareExchangeWeak((&unnamed.grid[_e529]), _e532, _e535);
                                            let _e538 = nVal;
                                            if (_e536.old_value == _e538) {
                                                let _e540 = draws;
                                                if _e540 {
                                                    let _e541 = (*coolness_1);
                                                    (*coolness_1) = min((_e541 + 1u), 255u);
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
            let _e544 = i_8;
            i_8 = (_e544 + 1i);
        }
    }
    return;
}

fn updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_9: ptr<function, vec3<i32>>, currentIndex_5: ptr<function, u32>, rawValue_4: ptr<function, u32>, currentDir_2: ptr<function, u32>, currentSleep_1: ptr<function, u32>, currentAge_4: ptr<function, u32>, randVal_6: ptr<function, f32>) {
    var coolness_2: u32;
    var param_314: vec3<i32>;
    var param_315: u32;
    var param_316: f32;
    var param_317: u32;
    var param_318: u32;
    var param_319: u32;
    var param_320: u32;
    var newType_2: u32;
    var param_321: u32;
    var belowPos_3: vec3<i32>;
    var param_322: vec3<i32>;
    var param_323: u32;
    var param_324: u32;
    var param_325: vec3<i32>;
    var param_326: u32;
    var param_327: u32;
    var param_328: u32;
    var param_329: u32;
    var param_330: u32;
    var param_331: u32;
    var param_332: u32;
    var param_333: u32;
    var slideDir: i32;
    var slide: array<vec3<i32>, 2>;
    var s: i32;
    var sPos: vec3<i32>;
    var param_334: vec3<i32>;
    var param_335: u32;
    var param_336: u32;
    var param_337: vec3<i32>;
    var param_338: u32;
    var param_339: u32;
    var param_340: u32;
    var param_341: u32;
    var param_342: u32;
    var param_343: u32;
    var param_344: u32;
    var param_345: u32;
    var blockedMask: u32;
    var searchStart: i32;
    var reach: i32;
    var r: i32;
    var i_9: i32;
    var d_7: i32;
    var c_6: vec3<i32>;
    var param_346: i32;
    var param_347: vec3<i32>;
    var param_348: u32;
    var param_349: u32;
    var param_350: vec3<i32>;
    var param_351: u32;
    var param_352: u32;
    var param_353: vec3<i32>;
    var param_354: u32;
    var param_355: u32;
    var param_356: u32;
    var param_357: u32;
    var param_358: u32;
    var param_359: u32;
    var param_360: u32;
    var param_361: u32;
    var hasPressure: bool;
    var local_13: bool;
    var param_362: vec3<i32>;
    var param_363: u32;
    var param_364: u32;
    var stackedOnLava: bool;
    var local_14: bool;
    var param_365: vec3<i32>;
    var param_366: u32;
    var param_367: u32;
    var param_368: u32;
    var spreadStart: i32;
    var i_10: i32;
    var d_8: i32;
    var targetPos: vec3<i32>;
    var param_369: i32;
    var param_370: vec3<i32>;
    var param_371: u32;
    var param_372: u32;
    var param_373: vec3<i32>;
    var param_374: u32;
    var param_375: u32;
    var param_376: u32;
    var param_377: u32;
    var param_378: u32;
    var param_379: u32;
    var param_380: u32;
    var param_381: u32;
    var newSleep: u32;
    var param_382: u32;
    var param_383: u32;
    var param_384: u32;
    var param_385: u32;
    var phi_5829_: bool;
    var phi_5967_: bool;
    var phi_5973_: bool;
    var phi_5983_: bool;
    var phi_6095_: bool;
    var phi_6102_: bool;
    var phi_6113_: bool;
    var phi_6125_: bool;
    var phi_6147_: bool;
    var phi_6261_: bool;
    var phi_6267_: bool;
    var phi_6277_: bool;

    let _e306 = (*currentAge_4);
    coolness_2 = _e306;
    let _e307 = (*pos_9);
    param_314 = _e307;
    let _e308 = coolness_2;
    param_315 = _e308;
    let _e309 = (*randVal_6);
    param_316 = _e309;
    lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b((&param_314), (&param_315), (&param_316));
    let _e310 = param_315;
    coolness_2 = _e310;
    let _e311 = (*currentSleep_1);
    let _e313 = tuning.wakeSleepThreshold;
    let _e314 = (_e311 > _e313);
    phi_5829_ = _e314;
    if _e314 {
        let _e315 = (*randVal_6);
        let _e319 = tuning.lavaRestCoolChance;
        phi_5829_ = (fract((_e315 * 71f)) < _e319);
    }
    let _e322 = phi_5829_;
    if _e322 {
        let _e323 = coolness_2;
        coolness_2 = min((_e323 + 1u), 255u);
    }
    let _e326 = coolness_2;
    let _e327 = lavaSolidifyCoolness_u0028_();
    if (_e326 >= _e327) {
        let _e329 = (*currentIndex_5);
        let _e332 = (*rawValue_4);
        param_317 = 12u;
        param_318 = 0u;
        param_319 = 0u;
        let _e333 = coolness_2;
        param_320 = _e333;
        let _e334 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_317), (&param_318), (&param_319), (&param_320));
        let _e335 = atomicCompareExchangeWeak((&unnamed.grid[_e329]), _e332, _e334);
        return;
    }
    let _e337 = coolness_2;
    param_321 = _e337;
    let _e338 = lavaTypeFor_u0028_u1_u003b((&param_321));
    newType_2 = _e338;
    let _e339 = (*randVal_6);
    let _e343 = tuning.lavaViscosity;
    if (fract((_e339 * 89f)) < _e343) {
        let _e346 = (*pos_9)[1u];
        if (_e346 > 1i) {
            let _e348 = (*pos_9);
            belowPos_3 = (_e348 + vec3<i32>(0i, -1i, 0i));
            let _e350 = belowPos_3;
            param_322 = _e350;
            let _e351 = getIndex_u0028_vi3_u003b((&param_322));
            param_323 = _e351;
            let _e352 = readCell_u0028_u1_u003b((&param_323));
            param_324 = _e352;
            let _e353 = getType_u0028_u1_u003b((&param_324));
            if (_e353 == 0u) {
                let _e355 = belowPos_3;
                param_325 = _e355;
                let _e356 = getIndex_u0028_vi3_u003b((&param_325));
                let _e357 = newType_2;
                param_326 = _e357;
                let _e358 = (*currentDir_2);
                param_327 = _e358;
                param_328 = 0u;
                let _e359 = coolness_2;
                param_329 = _e359;
                let _e360 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_326), (&param_327), (&param_328), (&param_329));
                let _e361 = (*currentIndex_5);
                param_330 = _e361;
                let _e362 = (*rawValue_4);
                param_331 = _e362;
                param_332 = _e356;
                param_333 = _e360;
                let _e363 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_330), (&param_331), (&param_332), (&param_333));
                if _e363 {
                    return;
                }
            }
        }
        let _e365 = (*pos_9)[1u];
        if (_e365 > 1i) {
            let _e367 = (*randVal_6);
            slideDir = select(-1i, 1i, (fract((_e367 * 10f)) > 0.5f));
            let _e372 = (*randVal_6);
            if (fract((_e372 * 100f)) > 0.5f) {
                let _e376 = (*pos_9);
                let _e377 = slideDir;
                slide[0i] = (_e376 + vec3<i32>(_e377, -1i, 0i));
                let _e381 = (*pos_9);
                let _e382 = slideDir;
                slide[1i] = (_e381 + vec3<i32>(0i, -1i, _e382));
            } else {
                let _e386 = (*pos_9);
                let _e387 = slideDir;
                slide[0i] = (_e386 + vec3<i32>(0i, -1i, _e387));
                let _e391 = (*pos_9);
                let _e392 = slideDir;
                slide[1i] = (_e391 + vec3<i32>(_e392, -1i, 0i));
            }
            s = 0i;
            loop {
                let _e396 = s;
                if (_e396 < 2i) {
                    let _e398 = s;
                    let _e400 = slide[_e398];
                    sPos = _e400;
                    let _e402 = sPos[0u];
                    let _e403 = (_e402 > 0i);
                    phi_5967_ = _e403;
                    if _e403 {
                        let _e405 = sPos[0u];
                        let _e407 = tuning.gridWidth;
                        phi_5967_ = (_e405 < (bitcast<i32>(_e407) - 1i));
                    }
                    let _e412 = phi_5967_;
                    phi_5973_ = _e412;
                    if _e412 {
                        let _e414 = sPos[2u];
                        phi_5973_ = (_e414 > 0i);
                    }
                    let _e417 = phi_5973_;
                    phi_5983_ = _e417;
                    if _e417 {
                        let _e419 = sPos[2u];
                        let _e421 = tuning.gridDepth;
                        phi_5983_ = (_e419 < (bitcast<i32>(_e421) - 1i));
                    }
                    let _e426 = phi_5983_;
                    if _e426 {
                        let _e427 = sPos;
                        param_334 = _e427;
                        let _e428 = getIndex_u0028_vi3_u003b((&param_334));
                        param_335 = _e428;
                        let _e429 = readCell_u0028_u1_u003b((&param_335));
                        param_336 = _e429;
                        let _e430 = getType_u0028_u1_u003b((&param_336));
                        if (_e430 == 0u) {
                            let _e432 = sPos;
                            param_337 = _e432;
                            let _e433 = getIndex_u0028_vi3_u003b((&param_337));
                            let _e434 = newType_2;
                            param_338 = _e434;
                            let _e435 = (*currentDir_2);
                            param_339 = _e435;
                            param_340 = 0u;
                            let _e436 = coolness_2;
                            param_341 = _e436;
                            let _e437 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_338), (&param_339), (&param_340), (&param_341));
                            let _e438 = (*currentIndex_5);
                            param_342 = _e438;
                            let _e439 = (*rawValue_4);
                            param_343 = _e439;
                            param_344 = _e433;
                            param_345 = _e437;
                            let _e440 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_342), (&param_343), (&param_344), (&param_345));
                            if _e440 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e441 = s;
                    s = (_e441 + 1i);
                }
            }
        }
        let _e443 = (*currentSleep_1);
        let _e445 = tuning.wakeSleepThreshold;
        if (_e443 <= _e445) {
            blockedMask = 0u;
            let _e447 = (*randVal_6);
            searchStart = i32((fract((_e447 * 8f)) * 8f));
            let _e453 = tuning.lavaSpreadRadius;
            reach = bitcast<i32>(max(_e453, 1u));
            r = 1i;
            loop {
                let _e456 = r;
                let _e457 = reach;
                if (_e456 <= _e457) {
                    let _e459 = blockedMask;
                    if (_e459 == 255u) {
                        break;
                    }
                    i_9 = 0i;
                    loop {
                        let _e461 = i_9;
                        if (_e461 < 8i) {
                            let _e463 = searchStart;
                            let _e464 = i_9;
                            let _e465 = (_e463 + _e464);
                            d_7 = (_e465 - (i32(floor((f32(_e465) / f32(8i)))) * 8i));
                            let _e473 = blockedMask;
                            let _e474 = d_7;
                            if ((_e473 & (1u << bitcast<u32>(_e474))) != 0u) {
                                continue;
                            }
                            let _e479 = (*pos_9);
                            let _e480 = d_7;
                            param_346 = _e480;
                            let _e481 = getHDir_u0028_i1_u003b((&param_346));
                            let _e482 = r;
                            c_6 = (_e479 + (_e481 * vec3(_e482)));
                            let _e487 = c_6[0u];
                            let _e488 = (_e487 <= 0i);
                            phi_6095_ = _e488;
                            if !(_e488) {
                                let _e491 = c_6[0u];
                                let _e493 = tuning.gridWidth;
                                phi_6095_ = (_e491 >= (bitcast<i32>(_e493) - 1i));
                            }
                            let _e498 = phi_6095_;
                            phi_6102_ = _e498;
                            if !(_e498) {
                                let _e501 = c_6[2u];
                                phi_6102_ = (_e501 <= 0i);
                            }
                            let _e504 = phi_6102_;
                            phi_6113_ = _e504;
                            if !(_e504) {
                                let _e507 = c_6[2u];
                                let _e509 = tuning.gridDepth;
                                phi_6113_ = (_e507 >= (bitcast<i32>(_e509) - 1i));
                            }
                            let _e514 = phi_6113_;
                            phi_6125_ = _e514;
                            if !(_e514) {
                                let _e516 = c_6;
                                param_347 = _e516;
                                let _e517 = getIndex_u0028_vi3_u003b((&param_347));
                                param_348 = _e517;
                                let _e518 = readCell_u0028_u1_u003b((&param_348));
                                param_349 = _e518;
                                let _e519 = getType_u0028_u1_u003b((&param_349));
                                phi_6125_ = (_e519 != 0u);
                            }
                            let _e522 = phi_6125_;
                            if _e522 {
                                let _e523 = d_7;
                                let _e526 = blockedMask;
                                blockedMask = (_e526 | (1u << bitcast<u32>(_e523)));
                            } else {
                                let _e529 = c_6[1u];
                                let _e530 = (_e529 > 1i);
                                phi_6147_ = _e530;
                                if _e530 {
                                    let _e531 = c_6;
                                    param_350 = (_e531 + vec3<i32>(0i, -1i, 0i));
                                    let _e533 = getIndex_u0028_vi3_u003b((&param_350));
                                    param_351 = _e533;
                                    let _e534 = readCell_u0028_u1_u003b((&param_351));
                                    param_352 = _e534;
                                    let _e535 = getType_u0028_u1_u003b((&param_352));
                                    phi_6147_ = (_e535 == 0u);
                                }
                                let _e538 = phi_6147_;
                                if _e538 {
                                    let _e539 = c_6;
                                    param_353 = _e539;
                                    let _e540 = getIndex_u0028_vi3_u003b((&param_353));
                                    let _e541 = newType_2;
                                    param_354 = _e541;
                                    param_355 = 0u;
                                    param_356 = 0u;
                                    let _e542 = coolness_2;
                                    param_357 = _e542;
                                    let _e543 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_354), (&param_355), (&param_356), (&param_357));
                                    let _e544 = (*currentIndex_5);
                                    param_358 = _e544;
                                    let _e545 = (*rawValue_4);
                                    param_359 = _e545;
                                    param_360 = _e540;
                                    param_361 = _e543;
                                    let _e546 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_358), (&param_359), (&param_360), (&param_361));
                                    if _e546 {
                                        return;
                                    }
                                    let _e547 = d_7;
                                    let _e550 = blockedMask;
                                    blockedMask = (_e550 | (1u << bitcast<u32>(_e547)));
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e552 = i_9;
                            i_9 = (_e552 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e554 = r;
                    r = (_e554 + 1i);
                }
            }
            let _e557 = (*pos_9)[1u];
            let _e559 = tuning.gridHeight;
            if (_e557 < (bitcast<i32>(_e559) - 2i)) {
                let _e563 = (*pos_9);
                param_362 = (_e563 + vec3<i32>(0i, 1i, 0i));
                let _e565 = getIndex_u0028_vi3_u003b((&param_362));
                param_363 = _e565;
                let _e566 = readCell_u0028_u1_u003b((&param_363));
                param_364 = _e566;
                let _e567 = getType_u0028_u1_u003b((&param_364));
                local_13 = (_e567 != 0u);
            } else {
                local_13 = false;
            }
            let _e569 = local_13;
            hasPressure = _e569;
            let _e571 = (*pos_9)[1u];
            if (_e571 > 1i) {
                let _e573 = (*pos_9);
                param_365 = (_e573 + vec3<i32>(0i, -1i, 0i));
                let _e575 = getIndex_u0028_vi3_u003b((&param_365));
                param_366 = _e575;
                let _e576 = readCell_u0028_u1_u003b((&param_366));
                param_367 = _e576;
                let _e577 = getType_u0028_u1_u003b((&param_367));
                param_368 = _e577;
                let _e578 = isLava_u0028_u1_u003b((&param_368));
                local_14 = _e578;
            } else {
                local_14 = false;
            }
            let _e579 = local_14;
            stackedOnLava = _e579;
            let _e580 = hasPressure;
            let _e581 = stackedOnLava;
            if (_e580 || _e581) {
                let _e583 = (*randVal_6);
                spreadStart = i32((fract((_e583 * 8f)) * 8f));
                i_10 = 0i;
                loop {
                    let _e588 = i_10;
                    if (_e588 < 8i) {
                        let _e590 = spreadStart;
                        let _e591 = i_10;
                        let _e592 = (_e590 + _e591);
                        d_8 = (_e592 - (i32(floor((f32(_e592) / f32(8i)))) * 8i));
                        let _e600 = (*pos_9);
                        let _e601 = d_8;
                        param_369 = _e601;
                        let _e602 = getHDir_u0028_i1_u003b((&param_369));
                        targetPos = (_e600 + _e602);
                        let _e605 = targetPos[0u];
                        let _e606 = (_e605 > 0i);
                        phi_6261_ = _e606;
                        if _e606 {
                            let _e608 = targetPos[0u];
                            let _e610 = tuning.gridWidth;
                            phi_6261_ = (_e608 < (bitcast<i32>(_e610) - 1i));
                        }
                        let _e615 = phi_6261_;
                        phi_6267_ = _e615;
                        if _e615 {
                            let _e617 = targetPos[2u];
                            phi_6267_ = (_e617 > 0i);
                        }
                        let _e620 = phi_6267_;
                        phi_6277_ = _e620;
                        if _e620 {
                            let _e622 = targetPos[2u];
                            let _e624 = tuning.gridDepth;
                            phi_6277_ = (_e622 < (bitcast<i32>(_e624) - 1i));
                        }
                        let _e629 = phi_6277_;
                        if _e629 {
                            let _e630 = targetPos;
                            param_370 = _e630;
                            let _e631 = getIndex_u0028_vi3_u003b((&param_370));
                            param_371 = _e631;
                            let _e632 = readCell_u0028_u1_u003b((&param_371));
                            param_372 = _e632;
                            let _e633 = getType_u0028_u1_u003b((&param_372));
                            if (_e633 == 0u) {
                                let _e635 = targetPos;
                                param_373 = _e635;
                                let _e636 = getIndex_u0028_vi3_u003b((&param_373));
                                let _e637 = d_8;
                                let _e640 = newType_2;
                                param_374 = _e640;
                                param_375 = bitcast<u32>((_e637 + 1i));
                                param_376 = 0u;
                                let _e641 = coolness_2;
                                param_377 = _e641;
                                let _e642 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_374), (&param_375), (&param_376), (&param_377));
                                let _e643 = (*currentIndex_5);
                                param_378 = _e643;
                                let _e644 = (*rawValue_4);
                                param_379 = _e644;
                                param_380 = _e636;
                                param_381 = _e642;
                                let _e645 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_378), (&param_379), (&param_380), (&param_381));
                                if _e645 {
                                    return;
                                }
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e646 = i_10;
                        i_10 = (_e646 + 1i);
                    }
                }
            }
        }
    }
    let _e648 = (*currentSleep_1);
    newSleep = min((_e648 + 1u), 255u);
    let _e651 = (*currentIndex_5);
    let _e654 = (*rawValue_4);
    let _e655 = newType_2;
    param_382 = _e655;
    let _e656 = (*currentDir_2);
    param_383 = _e656;
    let _e657 = newSleep;
    param_384 = _e657;
    let _e658 = coolness_2;
    param_385 = _e658;
    let _e659 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_382), (&param_383), (&param_384), (&param_385));
    let _e660 = atomicCompareExchangeWeak((&unnamed.grid[_e651]), _e654, _e659);
    return;
}

fn getCloudMoved_u0028_u1_u003b(v_2: ptr<function, u32>) -> bool {
    let _e205 = (*v_2);
    return ((_e205 & 4u) != 0u);
}

fn getCloudKind_u0028_u1_u003b(v_3: ptr<function, u32>) -> u32 {
    let _e205 = (*v_3);
    return (_e205 & 3u);
}

fn cloudIsAtRest_u0028_u1_u003b(v_4: ptr<function, u32>) -> bool {
    var param_386: u32;
    var param_387: u32;
    var phi_729_: bool;

    let _e207 = (*v_4);
    param_386 = _e207;
    let _e208 = getCloudKind_u0028_u1_u003b((&param_386));
    let _e209 = (_e208 != 0u);
    phi_729_ = _e209;
    if _e209 {
        let _e210 = (*v_4);
        param_387 = _e210;
        let _e211 = getCloudMoved_u0028_u1_u003b((&param_387));
        phi_729_ = !(_e211);
    }
    let _e214 = phi_729_;
    return _e214;
}

fn cloudCellInBounds_u0028_vi3_u003b(p_4: ptr<function, vec3<i32>>) -> bool {
    var phi_588_: bool;
    var phi_594_: bool;
    var phi_604_: bool;
    var phi_610_: bool;
    var phi_620_: bool;

    let _e206 = (*p_4)[0u];
    let _e207 = (_e206 >= 1i);
    phi_588_ = _e207;
    if _e207 {
        let _e209 = (*p_4)[0u];
        let _e211 = tuning.gridWidth;
        phi_588_ = (_e209 < (bitcast<i32>(_e211) - 1i));
    }
    let _e216 = phi_588_;
    phi_594_ = _e216;
    if _e216 {
        let _e218 = (*p_4)[1u];
        phi_594_ = (_e218 >= 1i);
    }
    let _e221 = phi_594_;
    phi_604_ = _e221;
    if _e221 {
        let _e223 = (*p_4)[1u];
        let _e225 = tuning.gridHeight;
        phi_604_ = (_e223 < (bitcast<i32>(_e225) - 1i));
    }
    let _e230 = phi_604_;
    phi_610_ = _e230;
    if _e230 {
        let _e232 = (*p_4)[2u];
        phi_610_ = (_e232 >= 1i);
    }
    let _e235 = phi_610_;
    phi_620_ = _e235;
    if _e235 {
        let _e237 = (*p_4)[2u];
        let _e239 = tuning.gridDepth;
        phi_620_ = (_e237 < (bitcast<i32>(_e239) - 1i));
    }
    let _e244 = phi_620_;
    return _e244;
}

fn cloudTouchesRain_u0028_vi3_u003b(pos_10: ptr<function, vec3<i32>>) -> bool {
    var i_11: i32;
    var n_1: vec3<i32>;
    var param_388: i32;
    var param_389: vec3<i32>;
    var param_390: vec3<i32>;
    var param_391: u32;

    i_11 = 0i;
    loop {
        let _e211 = i_11;
        if (_e211 < 6i) {
            let _e213 = (*pos_10);
            let _e214 = i_11;
            param_388 = _e214;
            let _e215 = getOrthoDir_u0028_i1_u003b((&param_388));
            n_1 = (_e213 + _e215);
            let _e217 = n_1;
            param_389 = _e217;
            let _e218 = cloudCellInBounds_u0028_vi3_u003b((&param_389));
            if !(_e218) {
                continue;
            }
            let _e220 = n_1;
            param_390 = _e220;
            let _e221 = getIndex_u0028_vi3_u003b((&param_390));
            let _e224 = atomicLoad((&unnamed_1.cloudCells[_e221]));
            param_391 = _e224;
            let _e225 = getCloudKind_u0028_u1_u003b((&param_391));
            if (_e225 == 2u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e227 = i_11;
            i_11 = (_e227 + 1i);
        }
    }
    return false;
}

fn packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b(kind: ptr<function, u32>, moved: ptr<function, bool>, counter: ptr<function, u32>, target_1: ptr<function, u32>) -> u32 {
    let _e208 = (*kind);
    let _e210 = (*moved);
    let _e213 = (*counter);
    let _e218 = (*target_1);
    return ((((_e208 & 3u) | select(0u, 4u, _e210)) | (min(_e213, 2047u) << bitcast<u32>(3i))) | (min(_e218, 2047u) << bitcast<u32>(14i)));
}

fn updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_11: ptr<function, vec3<i32>>, currentIndex_6: ptr<function, u32>, rawValue_5: ptr<function, u32>, currentSleep_2: ptr<function, u32>, currentAge_5: ptr<function, u32>, randVal_7: ptr<function, f32>) {
    var newKind: u32;
    var param_392: u32;
    var param_393: bool;
    var param_394: u32;
    var param_395: u32;
    var newAge: u32;
    var newKind_1: u32;
    var param_396: vec3<i32>;
    var param_397: u32;
    var param_398: bool;
    var param_399: u32;
    var param_400: u32;
    var d_9: i32;
    var scatterPos: vec3<i32>;
    var param_401: i32;
    var sType: u32;
    var param_402: vec3<i32>;
    var param_403: u32;
    var param_404: u32;
    var param_405: vec3<i32>;
    var param_406: u32;
    var carried: u32;
    var param_407: vec3<i32>;
    var param_408: u32;
    var param_409: u32;
    var param_410: u32;
    var param_411: u32;
    var param_412: u32;
    var param_413: u32;
    var param_414: u32;
    var param_415: u32;
    var checkPos: array<vec3<i32>, 3>;
    var dir_1: i32;
    var upPos_1: vec3<i32>;
    var underSettled: bool;
    var param_416: vec3<i32>;
    var param_417: vec3<i32>;
    var param_418: u32;
    var touchingRain: bool;
    var param_419: vec3<i32>;
    var newKind_2: u32;
    var param_420: u32;
    var param_421: bool;
    var param_422: u32;
    var param_423: u32;
    var i_12: i32;
    var cPos: vec3<i32>;
    var cIndex: u32;
    var param_424: vec3<i32>;
    var cVal: u32;
    var param_425: u32;
    var cType: u32;
    var param_426: u32;
    var moisture_2: u32;
    var param_427: u32;
    var capacity: u32;
    var local_15: u32;
    var i_13: i32;
    var sPos_1: vec3<i32>;
    var sType_1: u32;
    var param_428: vec3<i32>;
    var param_429: u32;
    var param_430: u32;
    var param_431: vec3<i32>;
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
    var newSleep_1: u32;
    var param_442: u32;
    var param_443: u32;
    var param_444: u32;
    var param_445: u32;
    var phi_8544_: bool;
    var phi_8593_: bool;
    var phi_8599_: bool;
    var phi_8609_: bool;
    var phi_8615_: bool;
    var phi_8625_: bool;
    var phi_8651_: bool;
    var phi_8733_: bool;
    var phi_8751_: bool;
    var phi_8790_: bool;
    var phi_8796_: bool;
    var phi_8806_: bool;
    var phi_8887_: bool;
    var phi_8897_: bool;
    var phi_8903_: bool;
    var phi_8913_: bool;
    var phi_8939_: bool;

    let _e290 = (*pos_11)[1u];
    let _e292 = tuning.gridHeight;
    if (_e290 >= (bitcast<i32>(_e292) - 2i)) {
        let _e297 = unnamed_2.rainPhase;
        newKind = select(1u, 2u, (_e297 == 2u));
        let _e300 = (*currentIndex_6);
        let _e303 = newKind;
        param_392 = _e303;
        param_393 = false;
        param_394 = 0u;
        param_395 = 0u;
        let _e304 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_392), (&param_393), (&param_394), (&param_395));
        let _e305 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e300]), 0u, _e304);
        if (_e305.old_value == 0u) {
            let _e308 = (*currentIndex_6);
            let _e311 = atomicExchange((&unnamed.grid[_e308]), 0u);
            return;
        }
        let _e312 = (*currentIndex_6);
        let _e315 = atomicExchange((&unnamed.grid[_e312]), 0u);
        return;
    }
    let _e316 = (*currentAge_5);
    newAge = min((_e316 + 1u), 255u);
    let _e319 = (*currentSleep_2);
    let _e321 = tuning.steamCondenseTicks;
    if (_e319 >= _e321) {
        let _e324 = unnamed_2.rainPhase;
        let _e325 = (_e324 == 2u);
        phi_8544_ = _e325;
        if !(_e325) {
            let _e327 = (*pos_11);
            param_396 = _e327;
            let _e328 = cloudTouchesRain_u0028_vi3_u003b((&param_396));
            phi_8544_ = _e328;
        }
        let _e330 = phi_8544_;
        newKind_1 = select(1u, 2u, _e330);
        let _e332 = (*currentIndex_6);
        let _e335 = newKind_1;
        param_397 = _e335;
        param_398 = false;
        param_399 = 0u;
        param_400 = 0u;
        let _e336 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_397), (&param_398), (&param_399), (&param_400));
        let _e337 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e332]), 0u, _e336);
        let _e339 = (*currentIndex_6);
        let _e342 = atomicExchange((&unnamed.grid[_e339]), 0u);
        return;
    }
    let _e343 = (*randVal_7);
    let _e347 = tuning.steamScatterChance;
    if (fract((_e343 * 88f)) < _e347) {
        let _e349 = (*randVal_7);
        d_9 = i32((fract((_e349 * 13f)) * 6f));
        let _e354 = (*pos_11);
        let _e355 = d_9;
        param_401 = _e355;
        let _e356 = getOrthoDir_u0028_i1_u003b((&param_401));
        scatterPos = (_e354 + _e356);
        let _e359 = scatterPos[0u];
        let _e360 = (_e359 > 0i);
        phi_8593_ = _e360;
        if _e360 {
            let _e362 = scatterPos[0u];
            let _e364 = tuning.gridWidth;
            phi_8593_ = (_e362 < (bitcast<i32>(_e364) - 1i));
        }
        let _e369 = phi_8593_;
        phi_8599_ = _e369;
        if _e369 {
            let _e371 = scatterPos[1u];
            phi_8599_ = (_e371 > 0i);
        }
        let _e374 = phi_8599_;
        phi_8609_ = _e374;
        if _e374 {
            let _e376 = scatterPos[1u];
            let _e378 = tuning.gridHeight;
            phi_8609_ = (_e376 < (bitcast<i32>(_e378) - 1i));
        }
        let _e383 = phi_8609_;
        phi_8615_ = _e383;
        if _e383 {
            let _e385 = scatterPos[2u];
            phi_8615_ = (_e385 > 0i);
        }
        let _e388 = phi_8615_;
        phi_8625_ = _e388;
        if _e388 {
            let _e390 = scatterPos[2u];
            let _e392 = tuning.gridDepth;
            phi_8625_ = (_e390 < (bitcast<i32>(_e392) - 1i));
        }
        let _e397 = phi_8625_;
        if _e397 {
            let _e398 = scatterPos;
            param_402 = _e398;
            let _e399 = getIndex_u0028_vi3_u003b((&param_402));
            param_403 = _e399;
            let _e400 = readCell_u0028_u1_u003b((&param_403));
            param_404 = _e400;
            let _e401 = getType_u0028_u1_u003b((&param_404));
            sType = _e401;
            let _e402 = sType;
            let _e404 = sType;
            let _e406 = ((_e402 == 0u) || (_e404 == 5u));
            phi_8651_ = _e406;
            if _e406 {
                let _e407 = scatterPos;
                param_405 = _e407;
                let _e408 = getIndex_u0028_vi3_u003b((&param_405));
                let _e411 = atomicLoad((&unnamed_1.cloudCells[_e408]));
                param_406 = _e411;
                let _e412 = getCloudKind_u0028_u1_u003b((&param_406));
                phi_8651_ = (_e412 == 0u);
            }
            let _e415 = phi_8651_;
            if _e415 {
                let _e416 = (*currentSleep_2);
                carried = min((_e416 + 1u), 255u);
                let _e419 = scatterPos;
                param_407 = _e419;
                let _e420 = getIndex_u0028_vi3_u003b((&param_407));
                param_408 = 6u;
                param_409 = 0u;
                let _e421 = carried;
                param_410 = _e421;
                let _e422 = newAge;
                param_411 = _e422;
                let _e423 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_408), (&param_409), (&param_410), (&param_411));
                let _e424 = (*currentIndex_6);
                param_412 = _e424;
                let _e425 = (*rawValue_5);
                param_413 = _e425;
                param_414 = _e420;
                param_415 = _e423;
                let _e426 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_412), (&param_413), (&param_414), (&param_415));
                if _e426 {
                    return;
                }
            }
        }
    }
    let _e427 = (*pos_11);
    checkPos[0i] = (_e427 + vec3<i32>(0i, 1i, 0i));
    let _e430 = (*randVal_7);
    dir_1 = select(-1i, 1i, (fract((_e430 * 10f)) > 0.5f));
    let _e435 = (*randVal_7);
    if (fract((_e435 * 100f)) > 0.5f) {
        let _e439 = (*pos_11);
        let _e440 = dir_1;
        checkPos[1i] = (_e439 + vec3<i32>(_e440, 1i, 0i));
        let _e444 = (*pos_11);
        let _e445 = dir_1;
        checkPos[2i] = (_e444 + vec3<i32>(0i, 1i, _e445));
    } else {
        let _e449 = (*pos_11);
        let _e450 = dir_1;
        checkPos[1i] = (_e449 + vec3<i32>(0i, 1i, _e450));
        let _e454 = (*pos_11);
        let _e455 = dir_1;
        checkPos[2i] = (_e454 + vec3<i32>(_e455, 1i, 0i));
    }
    let _e459 = (*pos_11);
    upPos_1 = (_e459 + vec3<i32>(0i, 1i, 0i));
    let _e461 = upPos_1;
    param_416 = _e461;
    let _e462 = cloudCellInBounds_u0028_vi3_u003b((&param_416));
    phi_8733_ = _e462;
    if _e462 {
        let _e463 = upPos_1;
        param_417 = _e463;
        let _e464 = getIndex_u0028_vi3_u003b((&param_417));
        let _e467 = atomicLoad((&unnamed_1.cloudCells[_e464]));
        param_418 = _e467;
        let _e468 = cloudIsAtRest_u0028_u1_u003b((&param_418));
        phi_8733_ = _e468;
    }
    let _e470 = phi_8733_;
    underSettled = _e470;
    let _e471 = (*pos_11);
    param_419 = _e471;
    let _e472 = cloudTouchesRain_u0028_vi3_u003b((&param_419));
    touchingRain = _e472;
    let _e473 = underSettled;
    let _e474 = touchingRain;
    if (_e473 || _e474) {
        let _e476 = touchingRain;
        phi_8751_ = _e476;
        if !(_e476) {
            let _e479 = unnamed_2.rainPhase;
            phi_8751_ = (_e479 == 2u);
        }
        let _e482 = phi_8751_;
        newKind_2 = select(1u, 2u, _e482);
        let _e484 = (*currentIndex_6);
        let _e487 = newKind_2;
        param_420 = _e487;
        param_421 = false;
        param_422 = 0u;
        param_423 = 0u;
        let _e488 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_420), (&param_421), (&param_422), (&param_423));
        let _e489 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e484]), 0u, _e488);
        let _e491 = (*currentIndex_6);
        let _e494 = atomicExchange((&unnamed.grid[_e491]), 0u);
        return;
    }
    i_12 = 0i;
    loop {
        let _e495 = i_12;
        if (_e495 < 3i) {
            let _e497 = i_12;
            let _e499 = checkPos[_e497];
            cPos = _e499;
            let _e501 = cPos[0u];
            let _e502 = (_e501 > 0i);
            phi_8790_ = _e502;
            if _e502 {
                let _e504 = cPos[0u];
                let _e506 = tuning.gridWidth;
                phi_8790_ = (_e504 < (bitcast<i32>(_e506) - 1i));
            }
            let _e511 = phi_8790_;
            phi_8796_ = _e511;
            if _e511 {
                let _e513 = cPos[2u];
                phi_8796_ = (_e513 > 0i);
            }
            let _e516 = phi_8796_;
            phi_8806_ = _e516;
            if _e516 {
                let _e518 = cPos[2u];
                let _e520 = tuning.gridDepth;
                phi_8806_ = (_e518 < (bitcast<i32>(_e520) - 1i));
            }
            let _e525 = phi_8806_;
            if _e525 {
                let _e526 = cPos;
                param_424 = _e526;
                let _e527 = getIndex_u0028_vi3_u003b((&param_424));
                cIndex = _e527;
                let _e528 = cIndex;
                param_425 = _e528;
                let _e529 = readCell_u0028_u1_u003b((&param_425));
                cVal = _e529;
                let _e530 = cVal;
                param_426 = _e530;
                let _e531 = getType_u0028_u1_u003b((&param_426));
                cType = _e531;
                let _e532 = cType;
                let _e534 = cType;
                if ((_e532 == 1u) || (_e534 == 4u)) {
                    let _e537 = cVal;
                    param_427 = _e537;
                    let _e538 = getAge_u0028_u1_u003b((&param_427));
                    moisture_2 = _e538;
                    let _e539 = cType;
                    if (_e539 == 4u) {
                        let _e542 = tuning.dirtMoistureCapacity;
                        local_15 = _e542;
                    } else {
                        let _e544 = tuning.sandMoistureCapacity;
                        local_15 = _e544;
                    }
                    let _e545 = local_15;
                    capacity = _e545;
                    let _e546 = moisture_2;
                    let _e547 = capacity;
                    if (_e546 < _e547) {
                        let _e549 = (*currentIndex_6);
                        let _e552 = (*rawValue_5);
                        let _e553 = atomicCompareExchangeWeak((&unnamed.grid[_e549]), _e552, 0u);
                        let _e555 = (*rawValue_5);
                        if (_e553.old_value == _e555) {
                            let _e557 = cIndex;
                            let _e560 = atomicAdd((&unnamed.grid[_e557]), 16777216u);
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
            let _e561 = i_12;
            i_12 = (_e561 + 1i);
        }
    }
    i_13 = 0i;
    loop {
        let _e563 = i_13;
        if (_e563 < 3i) {
            let _e565 = i_13;
            let _e567 = checkPos[_e565];
            sPos_1 = _e567;
            let _e569 = sPos_1[1u];
            let _e571 = tuning.gridHeight;
            let _e574 = (_e569 < (bitcast<i32>(_e571) - 1i));
            phi_8887_ = _e574;
            if _e574 {
                let _e576 = sPos_1[0u];
                phi_8887_ = (_e576 > 0i);
            }
            let _e579 = phi_8887_;
            phi_8897_ = _e579;
            if _e579 {
                let _e581 = sPos_1[0u];
                let _e583 = tuning.gridWidth;
                phi_8897_ = (_e581 < (bitcast<i32>(_e583) - 1i));
            }
            let _e588 = phi_8897_;
            phi_8903_ = _e588;
            if _e588 {
                let _e590 = sPos_1[2u];
                phi_8903_ = (_e590 > 0i);
            }
            let _e593 = phi_8903_;
            phi_8913_ = _e593;
            if _e593 {
                let _e595 = sPos_1[2u];
                let _e597 = tuning.gridDepth;
                phi_8913_ = (_e595 < (bitcast<i32>(_e597) - 1i));
            }
            let _e602 = phi_8913_;
            if _e602 {
                let _e603 = sPos_1;
                param_428 = _e603;
                let _e604 = getIndex_u0028_vi3_u003b((&param_428));
                param_429 = _e604;
                let _e605 = readCell_u0028_u1_u003b((&param_429));
                param_430 = _e605;
                let _e606 = getType_u0028_u1_u003b((&param_430));
                sType_1 = _e606;
                let _e607 = sType_1;
                let _e609 = sType_1;
                let _e611 = ((_e607 == 0u) || (_e609 == 5u));
                phi_8939_ = _e611;
                if _e611 {
                    let _e612 = sPos_1;
                    param_431 = _e612;
                    let _e613 = getIndex_u0028_vi3_u003b((&param_431));
                    let _e616 = atomicLoad((&unnamed_1.cloudCells[_e613]));
                    param_432 = _e616;
                    let _e617 = getCloudKind_u0028_u1_u003b((&param_432));
                    phi_8939_ = (_e617 == 0u);
                }
                let _e620 = phi_8939_;
                if _e620 {
                    let _e621 = sPos_1;
                    param_433 = _e621;
                    let _e622 = getIndex_u0028_vi3_u003b((&param_433));
                    param_434 = 6u;
                    param_435 = 0u;
                    param_436 = 0u;
                    let _e623 = newAge;
                    param_437 = _e623;
                    let _e624 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_434), (&param_435), (&param_436), (&param_437));
                    let _e625 = (*currentIndex_6);
                    param_438 = _e625;
                    let _e626 = (*rawValue_5);
                    param_439 = _e626;
                    param_440 = _e622;
                    param_441 = _e624;
                    let _e627 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_438), (&param_439), (&param_440), (&param_441));
                    if _e627 {
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e628 = i_13;
            i_13 = (_e628 + 1i);
        }
    }
    let _e630 = (*currentSleep_2);
    newSleep_1 = min((_e630 + 1u), 255u);
    let _e633 = (*currentIndex_6);
    let _e636 = (*rawValue_5);
    param_442 = 6u;
    param_443 = 0u;
    let _e637 = newSleep_1;
    param_444 = _e637;
    let _e638 = newAge;
    param_445 = _e638;
    let _e639 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_442), (&param_443), (&param_444), (&param_445));
    let _e640 = atomicCompareExchangeWeak((&unnamed.grid[_e633]), _e636, _e639);
    return;
}

fn updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_12: ptr<function, vec3<i32>>, currentIndex_7: ptr<function, u32>, rawValue_6: ptr<function, u32>, currentDir_3: ptr<function, u32>, currentSleep_3: ptr<function, u32>, currentAge_6: ptr<function, u32>, randVal_8: ptr<function, f32>) {
    var newAge_1: u32;
    var isBurningGrass: bool;
    var i_14: i32;
    var nPos_2: vec3<i32>;
    var param_446: i32;
    var nIndex_1: u32;
    var param_447: vec3<i32>;
    var nVal_1: u32;
    var param_448: u32;
    var param_449: u32;
    var param_450: u32;
    var param_451: u32;
    var param_452: u32;
    var param_453: u32;
    var burnRoll: f32;
    var start_7: i32;
    var i_15: i32;
    var nPos_3: vec3<i32>;
    var param_454: i32;
    var param_455: vec3<i32>;
    var nIndex_2: u32;
    var param_456: vec3<i32>;
    var nVal_2: u32;
    var param_457: u32;
    var nType_2: u32;
    var param_458: u32;
    var need_1: f32;
    var local_16: f32;
    var param_459: u32;
    var param_460: u32;
    var param_461: u32;
    var param_462: u32;
    var belowPos_4: vec3<i32>;
    var belowIndex_1: u32;
    var param_463: vec3<i32>;
    var belowValue_1: u32;
    var param_464: u32;
    var belowType: u32;
    var param_465: u32;
    var param_466: u32;
    var param_467: u32;
    var param_468: u32;
    var param_469: u32;
    var param_470: u32;
    var param_471: u32;
    var param_472: u32;
    var param_473: u32;
    var moisture_3: u32;
    var param_474: u32;
    var newMoisture: u32;
    var local_17: u32;
    var newVal: u32;
    var param_475: u32;
    var param_476: u32;
    var param_477: u32;
    var param_478: u32;
    var param_479: u32;
    var flora_3: u32;
    var newFlora: u32;
    var newVal_1: u32;
    var param_480: u32;
    var param_481: u32;
    var param_482: u32;
    var param_483: u32;
    var param_484: u32;
    var d_10: i32;
    var targetPos_1: vec3<i32>;
    var param_485: i32;
    var targetIndex_1: u32;
    var param_486: vec3<i32>;
    var param_487: u32;
    var param_488: u32;
    var targetBelow: vec3<i32>;
    var tBelowVal: u32;
    var param_489: vec3<i32>;
    var param_490: u32;
    var param_491: u32;
    var tFlora: u32;
    var param_492: u32;
    var param_493: u32;
    var param_494: u32;
    var param_495: u32;
    var param_496: u32;
    var param_497: u32;
    var param_498: u32;
    var param_499: u32;
    var phi_7841_: bool;
    var phi_7847_: bool;
    var phi_7857_: bool;
    var phi_7863_: bool;
    var phi_7873_: bool;
    var phi_8181_: bool;
    var phi_8187_: bool;
    var phi_8197_: bool;

    let _e297 = (*currentAge_6);
    newAge_1 = (_e297 + 1u);
    isBurningGrass = false;
    i_14 = 0i;
    loop {
        let _e299 = i_14;
        if (_e299 < 6i) {
            let _e301 = (*pos_12);
            let _e302 = i_14;
            param_446 = _e302;
            let _e303 = getOrthoDir_u0028_i1_u003b((&param_446));
            nPos_2 = (_e301 + _e303);
            let _e306 = nPos_2[0u];
            let _e307 = (_e306 > 0i);
            phi_7841_ = _e307;
            if _e307 {
                let _e309 = nPos_2[0u];
                let _e311 = tuning.gridWidth;
                phi_7841_ = (_e309 < (bitcast<i32>(_e311) - 1i));
            }
            let _e316 = phi_7841_;
            phi_7847_ = _e316;
            if _e316 {
                let _e318 = nPos_2[1u];
                phi_7847_ = (_e318 > 0i);
            }
            let _e321 = phi_7847_;
            phi_7857_ = _e321;
            if _e321 {
                let _e323 = nPos_2[1u];
                let _e325 = tuning.gridHeight;
                phi_7857_ = (_e323 < (bitcast<i32>(_e325) - 1i));
            }
            let _e330 = phi_7857_;
            phi_7863_ = _e330;
            if _e330 {
                let _e332 = nPos_2[2u];
                phi_7863_ = (_e332 > 0i);
            }
            let _e335 = phi_7863_;
            phi_7873_ = _e335;
            if _e335 {
                let _e337 = nPos_2[2u];
                let _e339 = tuning.gridDepth;
                phi_7873_ = (_e337 < (bitcast<i32>(_e339) - 1i));
            }
            let _e344 = phi_7873_;
            if _e344 {
                let _e345 = nPos_2;
                param_447 = _e345;
                let _e346 = getIndex_u0028_vi3_u003b((&param_447));
                nIndex_1 = _e346;
                let _e347 = nIndex_1;
                param_448 = _e347;
                let _e348 = readCell_u0028_u1_u003b((&param_448));
                nVal_1 = _e348;
                let _e349 = nVal_1;
                param_449 = _e349;
                let _e350 = getType_u0028_u1_u003b((&param_449));
                if (_e350 == 2u) {
                    let _e352 = nIndex_1;
                    let _e355 = nVal_1;
                    param_450 = 6u;
                    param_451 = 0u;
                    param_452 = 0u;
                    param_453 = 0u;
                    let _e356 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_450), (&param_451), (&param_452), (&param_453));
                    let _e357 = atomicCompareExchangeWeak((&unnamed.grid[_e352]), _e355, _e356);
                    let _e359 = nVal_1;
                    if (_e357.old_value == _e359) {
                        decWater_u0028_();
                        let _e361 = (*currentIndex_7);
                        let _e364 = atomicExchange((&unnamed.grid[_e361]), 0u);
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e365 = i_14;
            i_14 = (_e365 + 1i);
        }
    }
    let _e367 = (*randVal_8);
    burnRoll = fract((_e367 * 47f));
    let _e370 = burnRoll;
    let _e372 = tuning.treeLeafBurnChance;
    let _e374 = tuning.treeTrunkBurnChance;
    if (_e370 < max(_e372, _e374)) {
        let _e377 = (*randVal_8);
        start_7 = i32((fract((_e377 * 31f)) * 26f));
        i_15 = 0i;
        loop {
            let _e382 = i_15;
            if (_e382 < 26i) {
                let _e384 = (*pos_12);
                let _e385 = start_7;
                let _e386 = i_15;
                let _e387 = (_e385 + _e386);
                param_454 = (_e387 - (i32(floor((f32(_e387) / f32(26i)))) * 26i));
                let _e395 = tree26_u0028_i1_u003b((&param_454));
                nPos_3 = (_e384 + _e395);
                let _e397 = nPos_3;
                param_455 = _e397;
                let _e398 = treeInBounds_u0028_vi3_u003b((&param_455));
                if !(_e398) {
                    continue;
                }
                let _e400 = nPos_3;
                param_456 = _e400;
                let _e401 = getIndex_u0028_vi3_u003b((&param_456));
                nIndex_2 = _e401;
                let _e402 = nIndex_2;
                param_457 = _e402;
                let _e403 = readCell_u0028_u1_u003b((&param_457));
                nVal_2 = _e403;
                let _e404 = nVal_2;
                param_458 = _e404;
                let _e405 = getType_u0028_u1_u003b((&param_458));
                nType_2 = _e405;
                let _e406 = nType_2;
                let _e408 = nType_2;
                if ((_e406 != 19u) && (_e408 != 18u)) {
                    continue;
                }
                let _e411 = nType_2;
                if (_e411 == 19u) {
                    let _e414 = tuning.treeLeafBurnChance;
                    local_16 = _e414;
                } else {
                    let _e416 = tuning.treeTrunkBurnChance;
                    local_16 = _e416;
                }
                let _e417 = local_16;
                need_1 = _e417;
                let _e418 = burnRoll;
                let _e419 = need_1;
                if (_e418 < _e419) {
                    let _e421 = nIndex_2;
                    let _e424 = nVal_2;
                    param_459 = 5u;
                    param_460 = 0u;
                    param_461 = 0u;
                    param_462 = 0u;
                    let _e425 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_459), (&param_460), (&param_461), (&param_462));
                    let _e426 = atomicCompareExchangeWeak((&unnamed.grid[_e421]), _e424, _e425);
                }
                break;
            } else {
                break;
            }
            continuing {
                let _e428 = i_15;
                i_15 = (_e428 + 1i);
            }
        }
    }
    let _e431 = (*pos_12)[1u];
    if (_e431 > 1i) {
        let _e433 = (*pos_12);
        belowPos_4 = (_e433 + vec3<i32>(0i, -1i, 0i));
        let _e435 = belowPos_4;
        param_463 = _e435;
        let _e436 = getIndex_u0028_vi3_u003b((&param_463));
        belowIndex_1 = _e436;
        let _e437 = belowIndex_1;
        param_464 = _e437;
        let _e438 = readCell_u0028_u1_u003b((&param_464));
        belowValue_1 = _e438;
        let _e439 = belowValue_1;
        param_465 = _e439;
        let _e440 = getType_u0028_u1_u003b((&param_465));
        belowType = _e440;
        let _e441 = belowType;
        if (_e441 == 0u) {
            param_466 = 5u;
            param_467 = 0u;
            param_468 = 0u;
            let _e443 = newAge_1;
            param_469 = _e443;
            let _e444 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_466), (&param_467), (&param_468), (&param_469));
            let _e445 = (*currentIndex_7);
            param_470 = _e445;
            let _e446 = (*rawValue_6);
            param_471 = _e446;
            let _e447 = belowIndex_1;
            param_472 = _e447;
            param_473 = _e444;
            let _e448 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_470), (&param_471), (&param_472), (&param_473));
            if _e448 {
                return;
            }
        } else {
            let _e449 = belowType;
            if (_e449 == 2u) {
                let _e451 = (*currentIndex_7);
                let _e454 = atomicExchange((&unnamed.grid[_e451]), 0u);
                return;
            } else {
                let _e455 = belowType;
                if (_e455 == 1u) {
                    let _e457 = belowValue_1;
                    param_474 = _e457;
                    let _e458 = getAge_u0028_u1_u003b((&param_474));
                    moisture_3 = _e458;
                    let _e459 = moisture_3;
                    if (_e459 > 0u) {
                        let _e461 = moisture_3;
                        let _e463 = tuning.fireDryRate;
                        if (_e461 > _e463) {
                            let _e465 = moisture_3;
                            let _e467 = tuning.fireDryRate;
                            local_17 = (_e465 - _e467);
                        } else {
                            local_17 = 0u;
                        }
                        let _e469 = local_17;
                        newMoisture = _e469;
                        let _e470 = belowValue_1;
                        param_475 = _e470;
                        let _e471 = getDir_u0028_u1_u003b((&param_475));
                        param_476 = 1u;
                        param_477 = _e471;
                        param_478 = 0u;
                        let _e472 = newMoisture;
                        param_479 = _e472;
                        let _e473 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_476), (&param_477), (&param_478), (&param_479));
                        newVal = _e473;
                        let _e474 = belowIndex_1;
                        let _e477 = belowValue_1;
                        let _e478 = newVal;
                        let _e479 = atomicCompareExchangeWeak((&unnamed.grid[_e474]), _e477, _e478);
                        let _e481 = belowValue_1;
                        if (_e479.old_value == _e481) {
                            let _e483 = (*currentIndex_7);
                            let _e486 = atomicExchange((&unnamed.grid[_e483]), 0u);
                            return;
                        }
                    }
                } else {
                    let _e487 = belowType;
                    if (_e487 == 4u) {
                        let _e489 = belowValue_1;
                        flora_3 = ((_e489 >> bitcast<u32>(8i)) & 255u);
                        let _e493 = flora_3;
                        let _e495 = flora_3;
                        if ((_e493 > 10u) && (_e495 <= 100u)) {
                            isBurningGrass = true;
                            newAge_1 = 0u;
                            let _e498 = (*randVal_8);
                            let _e502 = tuning.fireBurnGrassChance;
                            if (fract((_e498 * 100f)) < _e502) {
                                let _e504 = flora_3;
                                newFlora = (_e504 - 1u);
                                let _e506 = belowValue_1;
                                param_480 = _e506;
                                let _e507 = getAge_u0028_u1_u003b((&param_480));
                                param_481 = 4u;
                                let _e508 = newFlora;
                                param_482 = _e508;
                                param_483 = 0u;
                                param_484 = _e507;
                                let _e509 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_481), (&param_482), (&param_483), (&param_484));
                                newVal_1 = _e509;
                                let _e510 = belowIndex_1;
                                let _e513 = belowValue_1;
                                let _e514 = newVal_1;
                                let _e515 = atomicCompareExchangeWeak((&unnamed.grid[_e510]), _e513, _e514);
                            }
                            let _e517 = (*randVal_8);
                            let _e521 = tuning.fireSpreadChance;
                            if (fract((_e517 * 100f)) < _e521) {
                                let _e523 = (*randVal_8);
                                d_10 = i32((fract((_e523 * 10f)) * 8f));
                                let _e528 = (*pos_12);
                                let _e529 = d_10;
                                param_485 = _e529;
                                let _e530 = getHDir_u0028_i1_u003b((&param_485));
                                targetPos_1 = (_e528 + _e530);
                                let _e533 = targetPos_1[0u];
                                let _e534 = (_e533 > 0i);
                                phi_8181_ = _e534;
                                if _e534 {
                                    let _e536 = targetPos_1[0u];
                                    let _e538 = tuning.gridWidth;
                                    phi_8181_ = (_e536 < (bitcast<i32>(_e538) - 1i));
                                }
                                let _e543 = phi_8181_;
                                phi_8187_ = _e543;
                                if _e543 {
                                    let _e545 = targetPos_1[2u];
                                    phi_8187_ = (_e545 > 0i);
                                }
                                let _e548 = phi_8187_;
                                phi_8197_ = _e548;
                                if _e548 {
                                    let _e550 = targetPos_1[2u];
                                    let _e552 = tuning.gridDepth;
                                    phi_8197_ = (_e550 < (bitcast<i32>(_e552) - 1i));
                                }
                                let _e557 = phi_8197_;
                                if _e557 {
                                    let _e558 = targetPos_1;
                                    param_486 = _e558;
                                    let _e559 = getIndex_u0028_vi3_u003b((&param_486));
                                    targetIndex_1 = _e559;
                                    let _e560 = targetIndex_1;
                                    param_487 = _e560;
                                    let _e561 = readCell_u0028_u1_u003b((&param_487));
                                    param_488 = _e561;
                                    let _e562 = getType_u0028_u1_u003b((&param_488));
                                    if (_e562 == 0u) {
                                        let _e564 = targetPos_1;
                                        targetBelow = (_e564 + vec3<i32>(0i, -1i, 0i));
                                        let _e566 = targetBelow;
                                        param_489 = _e566;
                                        let _e567 = getIndex_u0028_vi3_u003b((&param_489));
                                        param_490 = _e567;
                                        let _e568 = readCell_u0028_u1_u003b((&param_490));
                                        tBelowVal = _e568;
                                        let _e569 = tBelowVal;
                                        param_491 = _e569;
                                        let _e570 = getType_u0028_u1_u003b((&param_491));
                                        if (_e570 == 4u) {
                                            let _e572 = tBelowVal;
                                            tFlora = ((_e572 >> bitcast<u32>(8i)) & 255u);
                                            let _e576 = tFlora;
                                            let _e578 = tFlora;
                                            if ((_e576 > 10u) && (_e578 <= 100u)) {
                                                let _e581 = targetIndex_1;
                                                param_492 = 5u;
                                                param_493 = 0u;
                                                param_494 = 0u;
                                                param_495 = 0u;
                                                let _e584 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_492), (&param_493), (&param_494), (&param_495));
                                                let _e585 = atomicCompareExchangeWeak((&unnamed.grid[_e581]), 0u, _e584);
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
    let _e587 = newAge_1;
    let _e589 = tuning.fireLifetime;
    if (_e587 > _e589) {
        let _e591 = (*currentIndex_7);
        let _e594 = atomicExchange((&unnamed.grid[_e591]), 0u);
        return;
    }
    let _e595 = (*currentIndex_7);
    let _e598 = (*rawValue_6);
    param_496 = 5u;
    param_497 = 0u;
    param_498 = 0u;
    let _e599 = newAge_1;
    param_499 = _e599;
    let _e600 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_496), (&param_497), (&param_498), (&param_499));
    let _e601 = atomicCompareExchangeWeak((&unnamed.grid[_e595]), _e598, _e600);
    return;
}

fn isLocust_u0028_u1_u003b(type_36: ptr<function, u32>) -> bool {
    let _e205 = (*type_36);
    let _e207 = (*type_36);
    return ((_e205 >= 13u) && (_e207 <= 17u));
}

fn tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex_8: ptr<function, u32>, currentValue_1: ptr<function, u32>, targetIndex_2: ptr<function, u32>, targetValue_1: ptr<function, u32>, pushIndex: ptr<function, u32>) -> bool {
    var displacedValue: u32;
    var param_500: u32;
    var param_501: u32;
    var param_502: u32;
    var param_503: u32;
    var param_504: u32;
    var actualPush: u32;
    var actualTarget: u32;

    let _e217 = (*currentIndex_8);
    let _e220 = (*currentValue_1);
    let _e221 = atomicCompareExchangeWeak((&unnamed.grid[_e217]), _e220, 0u);
    let _e223 = (*currentValue_1);
    if (_e221.old_value == _e223) {
        let _e225 = (*targetValue_1);
        param_500 = _e225;
        let _e226 = getType_u0028_u1_u003b((&param_500));
        param_501 = _e226;
        param_502 = 0u;
        param_503 = 0u;
        param_504 = 0u;
        let _e227 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_501), (&param_502), (&param_503), (&param_504));
        displacedValue = _e227;
        let _e228 = (*pushIndex);
        let _e231 = displacedValue;
        let _e232 = atomicCompareExchangeWeak((&unnamed.grid[_e228]), 0u, _e231);
        actualPush = _e232.old_value;
        let _e234 = actualPush;
        if (_e234 == 0u) {
            let _e236 = (*targetIndex_2);
            let _e239 = (*targetValue_1);
            let _e240 = (*currentValue_1);
            let _e241 = atomicCompareExchangeWeak((&unnamed.grid[_e236]), _e239, _e240);
            actualTarget = _e241.old_value;
            let _e243 = actualTarget;
            let _e244 = (*targetValue_1);
            if (_e243 == _e244) {
                return true;
            } else {
                let _e246 = (*pushIndex);
                let _e249 = displacedValue;
                let _e250 = atomicCompareExchangeWeak((&unnamed.grid[_e246]), _e249, 0u);
            }
        }
        let _e252 = (*currentIndex_8);
        let _e255 = (*currentValue_1);
        let _e256 = atomicCompareExchangeWeak((&unnamed.grid[_e252]), 0u, _e255);
    }
    return false;
}

fn grainCanMove_u0028_vi3_u003b(pos_13: ptr<function, vec3<i32>>) -> bool {
    var i_16: i32;
    var target_2: vec3<i32>;
    var local_18: i32;
    var local_19: i32;
    var t_4: u32;
    var param_505: vec3<i32>;
    var param_506: u32;
    var param_507: u32;
    var phi_2459_: bool;
    var phi_2466_: bool;
    var phi_2477_: bool;

    let _e214 = (*pos_13)[1u];
    if (_e214 <= 1i) {
        return false;
    }
    i_16 = 0i;
    loop {
        let _e216 = i_16;
        if (_e216 < 5i) {
            let _e218 = (*pos_13);
            let _e219 = i_16;
            if (_e219 == 1i) {
                local_18 = 1i;
            } else {
                let _e221 = i_16;
                local_18 = select(0i, -1i, (_e221 == 2i));
            }
            let _e224 = local_18;
            let _e225 = i_16;
            if (_e225 == 3i) {
                local_19 = 1i;
            } else {
                let _e227 = i_16;
                local_19 = select(0i, -1i, (_e227 == 4i));
            }
            let _e230 = local_19;
            target_2 = (_e218 + vec3<i32>(_e224, -1i, _e230));
            let _e234 = target_2[0u];
            let _e235 = (_e234 <= 0i);
            phi_2459_ = _e235;
            if !(_e235) {
                let _e238 = target_2[0u];
                let _e240 = tuning.gridWidth;
                phi_2459_ = (_e238 >= (bitcast<i32>(_e240) - 1i));
            }
            let _e245 = phi_2459_;
            phi_2466_ = _e245;
            if !(_e245) {
                let _e248 = target_2[2u];
                phi_2466_ = (_e248 <= 0i);
            }
            let _e251 = phi_2466_;
            phi_2477_ = _e251;
            if !(_e251) {
                let _e254 = target_2[2u];
                let _e256 = tuning.gridDepth;
                phi_2477_ = (_e254 >= (bitcast<i32>(_e256) - 1i));
            }
            let _e261 = phi_2477_;
            if _e261 {
                continue;
            }
            let _e262 = target_2;
            param_505 = _e262;
            let _e263 = getIndex_u0028_vi3_u003b((&param_505));
            param_506 = _e263;
            let _e264 = readCell_u0028_u1_u003b((&param_506));
            param_507 = _e264;
            let _e265 = getType_u0028_u1_u003b((&param_507));
            t_4 = _e265;
            let _e266 = t_4;
            let _e268 = t_4;
            if ((_e266 == 0u) || (_e268 == 2u)) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e271 = i_16;
            i_16 = (_e271 + 1i);
        }
    }
    return false;
}

fn updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_14: ptr<function, vec3<i32>>, currentIndex_9: ptr<function, u32>, rawValue_7: ptr<function, u32>, currentDir_4: ptr<function, u32>, currentSleep_4: ptr<function, u32>, currentAge_7: ptr<function, u32>, randVal_9: ptr<function, f32>) {
    var moisture_4: u32;
    var moistureModified: bool;
    var startDir_1: i32;
    var i_17: i32;
    var d_11: i32;
    var nPos_4: vec3<i32>;
    var param_508: i32;
    var nIndex_3: u32;
    var param_509: vec3<i32>;
    var nVal_3: u32;
    var param_510: u32;
    var param_511: u32;
    var d_12: i32;
    var nPos_5: vec3<i32>;
    var param_512: i32;
    var nIndex_4: u32;
    var param_513: vec3<i32>;
    var nVal_4: u32;
    var param_514: u32;
    var nType_3: u32;
    var param_515: u32;
    var nMoisture: u32;
    var param_516: u32;
    var nCapacity: u32;
    var local_20: u32;
    var canMove: bool;
    var param_517: vec3<i32>;
    var isClumped: bool;
    var emptyBelowCount: i32;
    var x: i32;
    var z: i32;
    var checkPos_1: vec3<i32>;
    var param_518: vec3<i32>;
    var param_519: u32;
    var param_520: u32;
    var clumpCount: i32;
    var x_1: i32;
    var y: i32;
    var z_1: i32;
    var nPos_6: vec3<i32>;
    var param_521: vec3<i32>;
    var param_522: u32;
    var param_523: u32;
    var belowPos_5: vec3<i32>;
    var param_524: vec3<i32>;
    var param_525: u32;
    var param_526: u32;
    var param_527: vec3<i32>;
    var param_528: u32;
    var param_529: u32;
    var param_530: u32;
    var param_531: u32;
    var param_532: u32;
    var param_533: u32;
    var param_534: u32;
    var param_535: u32;
    var dir_2: i32;
    var slidePos1_: vec3<i32>;
    var slidePos2_: vec3<i32>;
    var param_536: vec3<i32>;
    var param_537: u32;
    var param_538: u32;
    var param_539: vec3<i32>;
    var param_540: u32;
    var param_541: u32;
    var param_542: u32;
    var param_543: u32;
    var param_544: u32;
    var param_545: u32;
    var param_546: u32;
    var param_547: u32;
    var param_548: vec3<i32>;
    var param_549: u32;
    var param_550: u32;
    var param_551: vec3<i32>;
    var param_552: u32;
    var param_553: u32;
    var param_554: u32;
    var param_555: u32;
    var param_556: u32;
    var param_557: u32;
    var param_558: u32;
    var param_559: u32;
    var belowPos_6: vec3<i32>;
    var belowIndex_2: u32;
    var param_560: vec3<i32>;
    var belowValue_2: u32;
    var param_561: u32;
    var param_562: u32;
    var startDir_2: i32;
    var i_18: i32;
    var d_13: i32;
    var pushPos: vec3<i32>;
    var param_563: i32;
    var param_564: u32;
    var param_565: u32;
    var param_566: u32;
    var param_567: u32;
    var param_568: vec3<i32>;
    var param_569: u32;
    var param_570: u32;
    var param_571: u32;
    var param_572: u32;
    var param_573: u32;
    var param_574: u32;
    var param_575: u32;
    var param_576: u32;
    var param_577: u32;
    var param_578: u32;
    var param_579: u32;
    var param_580: u32;
    var param_581: u32;
    var dir_3: i32;
    var slidePos: array<vec3<i32>, 2>;
    var s_1: i32;
    var sPos_2: vec3<i32>;
    var sIndex: u32;
    var param_582: vec3<i32>;
    var sValue: u32;
    var param_583: u32;
    var param_584: u32;
    var startDir_3: i32;
    var i_19: i32;
    var d_14: i32;
    var pushPos_1: vec3<i32>;
    var param_585: i32;
    var param_586: u32;
    var param_587: u32;
    var param_588: u32;
    var param_589: u32;
    var param_590: vec3<i32>;
    var param_591: u32;
    var param_592: u32;
    var param_593: u32;
    var param_594: u32;
    var param_595: u32;
    var param_596: u32;
    var param_597: u32;
    var param_598: u32;
    var param_599: u32;
    var param_600: u32;
    var param_601: u32;
    var param_602: u32;
    var param_603: u32;
    var floraState: u32;
    var abovePos_1: vec3<i32>;
    var aboveInside: bool;
    var aboveIndex: u32;
    var param_604: vec3<i32>;
    var aboveType: u32;
    var local_21: u32;
    var param_605: u32;
    var param_606: u32;
    var param_607: u32;
    var param_608: u32;
    var param_609: u32;
    var param_610: u32;
    var param_611: u32;
    var newSleep_2: u32;
    var param_612: u32;
    var param_613: u32;
    var param_614: u32;
    var param_615: u32;
    var phi_3588_: bool;
    var phi_3594_: bool;
    var phi_3604_: bool;
    var phi_3610_: bool;
    var phi_3620_: bool;
    var phi_3686_: bool;
    var phi_3692_: bool;
    var phi_3702_: bool;
    var phi_3708_: bool;
    var phi_3718_: bool;
    var phi_3788_: bool;
    var phi_3830_: bool;
    var phi_3836_: bool;
    var phi_3845_: bool;
    var phi_3926_: bool;
    var phi_3932_: bool;
    var phi_3941_: bool;
    var phi_3947_: bool;
    var phi_3956_: bool;
    var phi_4075_: bool;
    var phi_4081_: bool;
    var phi_4091_: bool;
    var phi_4135_: bool;
    var phi_4141_: bool;
    var phi_4151_: bool;
    var phi_4242_: bool;
    var phi_4248_: bool;
    var phi_4258_: bool;
    var phi_4359_: bool;
    var phi_4365_: bool;
    var phi_4375_: bool;
    var phi_4432_: bool;
    var phi_4438_: bool;
    var phi_4448_: bool;
    var phi_4503_: bool;
    var phi_4577_: bool;
    var phi_4632_: bool;

    let _e374 = (*currentAge_7);
    moisture_4 = _e374;
    moistureModified = false;
    let _e375 = moisture_4;
    let _e377 = tuning.dirtMoistureCapacity;
    if (_e375 < _e377) {
        let _e379 = (*randVal_9);
        startDir_1 = i32((fract((_e379 * 17f)) * 6f));
        i_17 = 0i;
        loop {
            let _e384 = i_17;
            if (_e384 < 6i) {
                let _e386 = startDir_1;
                let _e387 = i_17;
                let _e388 = (_e386 + _e387);
                d_11 = (_e388 - (i32(floor((f32(_e388) / f32(6i)))) * 6i));
                let _e396 = (*pos_14);
                let _e397 = d_11;
                param_508 = _e397;
                let _e398 = getOrthoDir_u0028_i1_u003b((&param_508));
                nPos_4 = (_e396 + _e398);
                let _e401 = nPos_4[0u];
                let _e402 = (_e401 > 0i);
                phi_3588_ = _e402;
                if _e402 {
                    let _e404 = nPos_4[0u];
                    let _e406 = tuning.gridWidth;
                    phi_3588_ = (_e404 < (bitcast<i32>(_e406) - 1i));
                }
                let _e411 = phi_3588_;
                phi_3594_ = _e411;
                if _e411 {
                    let _e413 = nPos_4[1u];
                    phi_3594_ = (_e413 > 0i);
                }
                let _e416 = phi_3594_;
                phi_3604_ = _e416;
                if _e416 {
                    let _e418 = nPos_4[1u];
                    let _e420 = tuning.gridHeight;
                    phi_3604_ = (_e418 < (bitcast<i32>(_e420) - 1i));
                }
                let _e425 = phi_3604_;
                phi_3610_ = _e425;
                if _e425 {
                    let _e427 = nPos_4[2u];
                    phi_3610_ = (_e427 > 0i);
                }
                let _e430 = phi_3610_;
                phi_3620_ = _e430;
                if _e430 {
                    let _e432 = nPos_4[2u];
                    let _e434 = tuning.gridDepth;
                    phi_3620_ = (_e432 < (bitcast<i32>(_e434) - 1i));
                }
                let _e439 = phi_3620_;
                if _e439 {
                    let _e440 = nPos_4;
                    param_509 = _e440;
                    let _e441 = getIndex_u0028_vi3_u003b((&param_509));
                    nIndex_3 = _e441;
                    let _e442 = nIndex_3;
                    param_510 = _e442;
                    let _e443 = readCell_u0028_u1_u003b((&param_510));
                    nVal_3 = _e443;
                    let _e444 = nVal_3;
                    param_511 = _e444;
                    let _e445 = getType_u0028_u1_u003b((&param_511));
                    if (_e445 == 2u) {
                        let _e447 = nIndex_3;
                        let _e450 = nVal_3;
                        let _e451 = atomicCompareExchangeWeak((&unnamed.grid[_e447]), _e450, 0u);
                        let _e453 = nVal_3;
                        if (_e451.old_value == _e453) {
                            let _e455 = (*currentIndex_9);
                            let _e459 = tuning.sandWaterAbsorbUnit;
                            let _e462 = atomicAdd((&unnamed.grid[_e455]), (_e459 << bitcast<u32>(24i)));
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
                let _e463 = i_17;
                i_17 = (_e463 + 1i);
            }
        }
    }
    let _e465 = moistureModified;
    let _e467 = moisture_4;
    if (!(_e465) && (_e467 > 0u)) {
        let _e470 = (*randVal_9);
        d_12 = i32((fract((_e470 * 31f)) * 6f));
        let _e475 = (*pos_14);
        let _e476 = d_12;
        param_512 = _e476;
        let _e477 = getOrthoDir_u0028_i1_u003b((&param_512));
        nPos_5 = (_e475 + _e477);
        let _e480 = nPos_5[0u];
        let _e481 = (_e480 > 0i);
        phi_3686_ = _e481;
        if _e481 {
            let _e483 = nPos_5[0u];
            let _e485 = tuning.gridWidth;
            phi_3686_ = (_e483 < (bitcast<i32>(_e485) - 1i));
        }
        let _e490 = phi_3686_;
        phi_3692_ = _e490;
        if _e490 {
            let _e492 = nPos_5[1u];
            phi_3692_ = (_e492 > 0i);
        }
        let _e495 = phi_3692_;
        phi_3702_ = _e495;
        if _e495 {
            let _e497 = nPos_5[1u];
            let _e499 = tuning.gridHeight;
            phi_3702_ = (_e497 < (bitcast<i32>(_e499) - 1i));
        }
        let _e504 = phi_3702_;
        phi_3708_ = _e504;
        if _e504 {
            let _e506 = nPos_5[2u];
            phi_3708_ = (_e506 > 0i);
        }
        let _e509 = phi_3708_;
        phi_3718_ = _e509;
        if _e509 {
            let _e511 = nPos_5[2u];
            let _e513 = tuning.gridDepth;
            phi_3718_ = (_e511 < (bitcast<i32>(_e513) - 1i));
        }
        let _e518 = phi_3718_;
        if _e518 {
            let _e519 = nPos_5;
            param_513 = _e519;
            let _e520 = getIndex_u0028_vi3_u003b((&param_513));
            nIndex_4 = _e520;
            let _e521 = nIndex_4;
            param_514 = _e521;
            let _e522 = readCell_u0028_u1_u003b((&param_514));
            nVal_4 = _e522;
            let _e523 = nVal_4;
            param_515 = _e523;
            let _e524 = getType_u0028_u1_u003b((&param_515));
            nType_3 = _e524;
            let _e525 = nType_3;
            let _e527 = nType_3;
            if ((_e525 == 4u) || (_e527 == 1u)) {
                let _e530 = nVal_4;
                param_516 = _e530;
                let _e531 = getAge_u0028_u1_u003b((&param_516));
                nMoisture = _e531;
                let _e532 = nType_3;
                if (_e532 == 4u) {
                    let _e535 = tuning.dirtMoistureCapacity;
                    local_20 = _e535;
                } else {
                    let _e537 = tuning.sandMoistureCapacity;
                    local_20 = _e537;
                }
                let _e538 = local_20;
                nCapacity = _e538;
                let _e539 = moisture_4;
                let _e540 = nMoisture;
                let _e543 = nMoisture;
                let _e544 = nCapacity;
                if ((_e539 > (_e540 + 1u)) && (_e543 < _e544)) {
                    let _e547 = (*currentIndex_9);
                    let _e550 = atomicAdd((&unnamed.grid[_e547]), 4278190080u);
                    let _e551 = nIndex_4;
                    let _e554 = atomicAdd((&unnamed.grid[_e551]), 16777216u);
                    moistureModified = true;
                }
            }
        }
    }
    let _e555 = moistureModified;
    if _e555 {
        return;
    }
    let _e556 = (*pos_14);
    param_517 = _e556;
    let _e557 = grainCanMove_u0028_vi3_u003b((&param_517));
    canMove = _e557;
    isClumped = false;
    let _e558 = canMove;
    phi_3788_ = _e558;
    if _e558 {
        let _e559 = (*currentSleep_4);
        let _e561 = tuning.wakeSleepThreshold;
        phi_3788_ = (_e559 > _e561);
    }
    let _e564 = phi_3788_;
    if _e564 {
        emptyBelowCount = 0i;
        let _e566 = (*pos_14)[1u];
        if (_e566 > 1i) {
            x = -1i;
            loop {
                let _e568 = x;
                if (_e568 <= 1i) {
                    z = -1i;
                    loop {
                        let _e570 = z;
                        if (_e570 <= 1i) {
                            let _e572 = (*pos_14);
                            let _e573 = x;
                            let _e574 = z;
                            checkPos_1 = (_e572 + vec3<i32>(_e573, -1i, _e574));
                            let _e578 = checkPos_1[0u];
                            let _e579 = (_e578 >= 0i);
                            phi_3830_ = _e579;
                            if _e579 {
                                let _e581 = checkPos_1[0u];
                                let _e583 = tuning.gridWidth;
                                phi_3830_ = (_e581 < bitcast<i32>(_e583));
                            }
                            let _e587 = phi_3830_;
                            phi_3836_ = _e587;
                            if _e587 {
                                let _e589 = checkPos_1[2u];
                                phi_3836_ = (_e589 >= 0i);
                            }
                            let _e592 = phi_3836_;
                            phi_3845_ = _e592;
                            if _e592 {
                                let _e594 = checkPos_1[2u];
                                let _e596 = tuning.gridDepth;
                                phi_3845_ = (_e594 < bitcast<i32>(_e596));
                            }
                            let _e600 = phi_3845_;
                            if _e600 {
                                let _e601 = checkPos_1;
                                param_518 = _e601;
                                let _e602 = getIndex_u0028_vi3_u003b((&param_518));
                                param_519 = _e602;
                                let _e603 = readCell_u0028_u1_u003b((&param_519));
                                param_520 = _e603;
                                let _e604 = getType_u0028_u1_u003b((&param_520));
                                if (_e604 == 0u) {
                                    let _e606 = emptyBelowCount;
                                    emptyBelowCount = (_e606 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e608 = z;
                            z = (_e608 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e610 = x;
                    x = (_e610 + 1i);
                }
            }
        }
        let _e612 = emptyBelowCount;
        let _e614 = tuning.emptyBelowWakeCount;
        if (_e612 >= bitcast<i32>(_e614)) {
            (*currentSleep_4) = 0u;
        } else {
            clumpCount = 0i;
            x_1 = -1i;
            loop {
                let _e617 = x_1;
                if (_e617 <= 1i) {
                    y = -1i;
                    loop {
                        let _e619 = y;
                        if (_e619 <= 1i) {
                            z_1 = -1i;
                            loop {
                                let _e621 = z_1;
                                if (_e621 <= 1i) {
                                    let _e623 = x_1;
                                    let _e625 = y;
                                    let _e628 = z_1;
                                    if (((_e623 == 0i) && (_e625 == 0i)) && (_e628 == 0i)) {
                                        continue;
                                    }
                                    let _e631 = (*pos_14);
                                    let _e632 = x_1;
                                    let _e633 = y;
                                    let _e634 = z_1;
                                    nPos_6 = (_e631 + vec3<i32>(_e632, _e633, _e634));
                                    let _e638 = nPos_6[0u];
                                    let _e639 = (_e638 >= 0i);
                                    phi_3926_ = _e639;
                                    if _e639 {
                                        let _e641 = nPos_6[0u];
                                        let _e643 = tuning.gridWidth;
                                        phi_3926_ = (_e641 < bitcast<i32>(_e643));
                                    }
                                    let _e647 = phi_3926_;
                                    phi_3932_ = _e647;
                                    if _e647 {
                                        let _e649 = nPos_6[1u];
                                        phi_3932_ = (_e649 >= 0i);
                                    }
                                    let _e652 = phi_3932_;
                                    phi_3941_ = _e652;
                                    if _e652 {
                                        let _e654 = nPos_6[1u];
                                        let _e656 = tuning.gridHeight;
                                        phi_3941_ = (_e654 < bitcast<i32>(_e656));
                                    }
                                    let _e660 = phi_3941_;
                                    phi_3947_ = _e660;
                                    if _e660 {
                                        let _e662 = nPos_6[2u];
                                        phi_3947_ = (_e662 >= 0i);
                                    }
                                    let _e665 = phi_3947_;
                                    phi_3956_ = _e665;
                                    if _e665 {
                                        let _e667 = nPos_6[2u];
                                        let _e669 = tuning.gridDepth;
                                        phi_3956_ = (_e667 < bitcast<i32>(_e669));
                                    }
                                    let _e673 = phi_3956_;
                                    if _e673 {
                                        let _e674 = nPos_6;
                                        param_521 = _e674;
                                        let _e675 = getIndex_u0028_vi3_u003b((&param_521));
                                        param_522 = _e675;
                                        let _e676 = readCell_u0028_u1_u003b((&param_522));
                                        param_523 = _e676;
                                        let _e677 = getType_u0028_u1_u003b((&param_523));
                                        if (_e677 == 4u) {
                                            let _e679 = clumpCount;
                                            clumpCount = (_e679 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e681 = z_1;
                                    z_1 = (_e681 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e683 = y;
                            y = (_e683 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e685 = x_1;
                    x_1 = (_e685 + 1i);
                }
            }
            let _e687 = clumpCount;
            let _e689 = tuning.dirtClumpThreshold;
            if (_e687 >= bitcast<i32>(_e689)) {
                isClumped = true;
            }
        }
    }
    let _e692 = canMove;
    let _e693 = isClumped;
    if (_e692 && !(_e693)) {
        let _e697 = (*pos_14)[1u];
        if (_e697 > 1i) {
            let _e699 = (*pos_14);
            belowPos_5 = (_e699 + vec3<i32>(0i, -1i, 0i));
            let _e701 = belowPos_5;
            param_524 = _e701;
            let _e702 = getIndex_u0028_vi3_u003b((&param_524));
            param_525 = _e702;
            let _e703 = readCell_u0028_u1_u003b((&param_525));
            param_526 = _e703;
            let _e704 = getType_u0028_u1_u003b((&param_526));
            if (_e704 == 0u) {
                let _e706 = belowPos_5;
                param_527 = _e706;
                let _e707 = getIndex_u0028_vi3_u003b((&param_527));
                param_528 = 4u;
                param_529 = 0u;
                param_530 = 0u;
                let _e708 = moisture_4;
                param_531 = _e708;
                let _e709 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_528), (&param_529), (&param_530), (&param_531));
                let _e710 = (*currentIndex_9);
                param_532 = _e710;
                let _e711 = (*rawValue_7);
                param_533 = _e711;
                param_534 = _e707;
                param_535 = _e709;
                let _e712 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_532), (&param_533), (&param_534), (&param_535));
                if _e712 {
                    return;
                }
            }
        }
        let _e714 = (*pos_14)[1u];
        if (_e714 > 1i) {
            let _e716 = (*randVal_9);
            dir_2 = select(-1i, 1i, (fract((_e716 * 10f)) > 0.5f));
            let _e721 = (*randVal_9);
            if (fract((_e721 * 100f)) > 0.5f) {
                let _e725 = (*pos_14);
                let _e726 = dir_2;
                slidePos1_ = (_e725 + vec3<i32>(_e726, -1i, 0i));
                let _e729 = (*pos_14);
                let _e730 = dir_2;
                slidePos2_ = (_e729 + vec3<i32>(0i, -1i, _e730));
            } else {
                let _e733 = (*pos_14);
                let _e734 = dir_2;
                slidePos1_ = (_e733 + vec3<i32>(0i, -1i, _e734));
                let _e737 = (*pos_14);
                let _e738 = dir_2;
                slidePos2_ = (_e737 + vec3<i32>(_e738, -1i, 0i));
            }
            let _e742 = slidePos1_[0u];
            let _e743 = (_e742 > 0i);
            phi_4075_ = _e743;
            if _e743 {
                let _e745 = slidePos1_[0u];
                let _e747 = tuning.gridWidth;
                phi_4075_ = (_e745 < (bitcast<i32>(_e747) - 1i));
            }
            let _e752 = phi_4075_;
            phi_4081_ = _e752;
            if _e752 {
                let _e754 = slidePos1_[2u];
                phi_4081_ = (_e754 > 0i);
            }
            let _e757 = phi_4081_;
            phi_4091_ = _e757;
            if _e757 {
                let _e759 = slidePos1_[2u];
                let _e761 = tuning.gridDepth;
                phi_4091_ = (_e759 < (bitcast<i32>(_e761) - 1i));
            }
            let _e766 = phi_4091_;
            if _e766 {
                let _e767 = slidePos1_;
                param_536 = _e767;
                let _e768 = getIndex_u0028_vi3_u003b((&param_536));
                param_537 = _e768;
                let _e769 = readCell_u0028_u1_u003b((&param_537));
                param_538 = _e769;
                let _e770 = getType_u0028_u1_u003b((&param_538));
                if (_e770 == 0u) {
                    let _e772 = slidePos1_;
                    param_539 = _e772;
                    let _e773 = getIndex_u0028_vi3_u003b((&param_539));
                    param_540 = 4u;
                    param_541 = 0u;
                    param_542 = 0u;
                    let _e774 = moisture_4;
                    param_543 = _e774;
                    let _e775 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_540), (&param_541), (&param_542), (&param_543));
                    let _e776 = (*currentIndex_9);
                    param_544 = _e776;
                    let _e777 = (*rawValue_7);
                    param_545 = _e777;
                    param_546 = _e773;
                    param_547 = _e775;
                    let _e778 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_544), (&param_545), (&param_546), (&param_547));
                    if _e778 {
                        return;
                    }
                }
            }
            let _e780 = slidePos2_[0u];
            let _e781 = (_e780 > 0i);
            phi_4135_ = _e781;
            if _e781 {
                let _e783 = slidePos2_[0u];
                let _e785 = tuning.gridWidth;
                phi_4135_ = (_e783 < (bitcast<i32>(_e785) - 1i));
            }
            let _e790 = phi_4135_;
            phi_4141_ = _e790;
            if _e790 {
                let _e792 = slidePos2_[2u];
                phi_4141_ = (_e792 > 0i);
            }
            let _e795 = phi_4141_;
            phi_4151_ = _e795;
            if _e795 {
                let _e797 = slidePos2_[2u];
                let _e799 = tuning.gridDepth;
                phi_4151_ = (_e797 < (bitcast<i32>(_e799) - 1i));
            }
            let _e804 = phi_4151_;
            if _e804 {
                let _e805 = slidePos2_;
                param_548 = _e805;
                let _e806 = getIndex_u0028_vi3_u003b((&param_548));
                param_549 = _e806;
                let _e807 = readCell_u0028_u1_u003b((&param_549));
                param_550 = _e807;
                let _e808 = getType_u0028_u1_u003b((&param_550));
                if (_e808 == 0u) {
                    let _e810 = slidePos2_;
                    param_551 = _e810;
                    let _e811 = getIndex_u0028_vi3_u003b((&param_551));
                    param_552 = 4u;
                    param_553 = 0u;
                    param_554 = 0u;
                    let _e812 = moisture_4;
                    param_555 = _e812;
                    let _e813 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_552), (&param_553), (&param_554), (&param_555));
                    let _e814 = (*currentIndex_9);
                    param_556 = _e814;
                    let _e815 = (*rawValue_7);
                    param_557 = _e815;
                    param_558 = _e811;
                    param_559 = _e813;
                    let _e816 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_556), (&param_557), (&param_558), (&param_559));
                    if _e816 {
                        return;
                    }
                }
            }
        }
        let _e818 = (*pos_14)[1u];
        if (_e818 > 1i) {
            let _e820 = (*pos_14);
            belowPos_6 = (_e820 + vec3<i32>(0i, -1i, 0i));
            let _e822 = belowPos_6;
            param_560 = _e822;
            let _e823 = getIndex_u0028_vi3_u003b((&param_560));
            belowIndex_2 = _e823;
            let _e824 = belowIndex_2;
            param_561 = _e824;
            let _e825 = readCell_u0028_u1_u003b((&param_561));
            belowValue_2 = _e825;
            let _e826 = belowValue_2;
            param_562 = _e826;
            let _e827 = getType_u0028_u1_u003b((&param_562));
            if (_e827 == 2u) {
                let _e829 = (*randVal_9);
                startDir_2 = i32((fract((_e829 * 8f)) * 8f));
                i_18 = 0i;
                loop {
                    let _e834 = i_18;
                    if (_e834 < 8i) {
                        let _e836 = startDir_2;
                        let _e837 = i_18;
                        let _e838 = (_e836 + _e837);
                        d_13 = (_e838 - (i32(floor((f32(_e838) / f32(8i)))) * 8i));
                        let _e846 = belowPos_6;
                        let _e847 = d_13;
                        param_563 = _e847;
                        let _e848 = getHDir_u0028_i1_u003b((&param_563));
                        pushPos = (_e846 + _e848);
                        let _e851 = pushPos[0u];
                        let _e852 = (_e851 > 0i);
                        phi_4242_ = _e852;
                        if _e852 {
                            let _e854 = pushPos[0u];
                            let _e856 = tuning.gridWidth;
                            phi_4242_ = (_e854 < (bitcast<i32>(_e856) - 1i));
                        }
                        let _e861 = phi_4242_;
                        phi_4248_ = _e861;
                        if _e861 {
                            let _e863 = pushPos[2u];
                            phi_4248_ = (_e863 > 0i);
                        }
                        let _e866 = phi_4248_;
                        phi_4258_ = _e866;
                        if _e866 {
                            let _e868 = pushPos[2u];
                            let _e870 = tuning.gridDepth;
                            phi_4258_ = (_e868 < (bitcast<i32>(_e870) - 1i));
                        }
                        let _e875 = phi_4258_;
                        if _e875 {
                            param_564 = 4u;
                            param_565 = 0u;
                            param_566 = 0u;
                            let _e876 = moisture_4;
                            param_567 = _e876;
                            let _e877 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_564), (&param_565), (&param_566), (&param_567));
                            let _e878 = pushPos;
                            param_568 = _e878;
                            let _e879 = getIndex_u0028_vi3_u003b((&param_568));
                            let _e880 = (*currentIndex_9);
                            param_569 = _e880;
                            param_570 = _e877;
                            let _e881 = belowIndex_2;
                            param_571 = _e881;
                            let _e882 = belowValue_2;
                            param_572 = _e882;
                            param_573 = _e879;
                            let _e883 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_569), (&param_570), (&param_571), (&param_572), (&param_573));
                            if _e883 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e884 = i_18;
                        i_18 = (_e884 + 1i);
                    }
                }
                param_574 = 4u;
                param_575 = 0u;
                param_576 = 0u;
                let _e886 = moisture_4;
                param_577 = _e886;
                let _e887 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_574), (&param_575), (&param_576), (&param_577));
                let _e888 = (*currentIndex_9);
                param_578 = _e888;
                let _e889 = (*rawValue_7);
                param_579 = _e889;
                let _e890 = belowIndex_2;
                param_580 = _e890;
                param_581 = _e887;
                let _e891 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_578), (&param_579), (&param_580), (&param_581));
                if _e891 {
                    return;
                }
            }
            let _e892 = (*randVal_9);
            dir_3 = select(-1i, 1i, (fract((_e892 * 10f)) > 0.5f));
            let _e897 = (*randVal_9);
            if (fract((_e897 * 100f)) > 0.5f) {
                let _e901 = (*pos_14);
                let _e902 = dir_3;
                slidePos[0i] = (_e901 + vec3<i32>(_e902, -1i, 0i));
                let _e906 = (*pos_14);
                let _e907 = dir_3;
                slidePos[1i] = (_e906 + vec3<i32>(0i, -1i, _e907));
            } else {
                let _e911 = (*pos_14);
                let _e912 = dir_3;
                slidePos[0i] = (_e911 + vec3<i32>(0i, -1i, _e912));
                let _e916 = (*pos_14);
                let _e917 = dir_3;
                slidePos[1i] = (_e916 + vec3<i32>(_e917, -1i, 0i));
            }
            s_1 = 0i;
            loop {
                let _e921 = s_1;
                if (_e921 < 2i) {
                    let _e923 = s_1;
                    let _e925 = slidePos[_e923];
                    sPos_2 = _e925;
                    let _e927 = sPos_2[0u];
                    let _e928 = (_e927 > 0i);
                    phi_4359_ = _e928;
                    if _e928 {
                        let _e930 = sPos_2[0u];
                        let _e932 = tuning.gridWidth;
                        phi_4359_ = (_e930 < (bitcast<i32>(_e932) - 1i));
                    }
                    let _e937 = phi_4359_;
                    phi_4365_ = _e937;
                    if _e937 {
                        let _e939 = sPos_2[2u];
                        phi_4365_ = (_e939 > 0i);
                    }
                    let _e942 = phi_4365_;
                    phi_4375_ = _e942;
                    if _e942 {
                        let _e944 = sPos_2[2u];
                        let _e946 = tuning.gridDepth;
                        phi_4375_ = (_e944 < (bitcast<i32>(_e946) - 1i));
                    }
                    let _e951 = phi_4375_;
                    if _e951 {
                        let _e952 = sPos_2;
                        param_582 = _e952;
                        let _e953 = getIndex_u0028_vi3_u003b((&param_582));
                        sIndex = _e953;
                        let _e954 = sIndex;
                        param_583 = _e954;
                        let _e955 = readCell_u0028_u1_u003b((&param_583));
                        sValue = _e955;
                        let _e956 = sValue;
                        param_584 = _e956;
                        let _e957 = getType_u0028_u1_u003b((&param_584));
                        if (_e957 == 2u) {
                            let _e959 = (*randVal_9);
                            let _e961 = s_1;
                            startDir_3 = i32((fract(((_e959 * 8f) + f32(_e961))) * 8f));
                            i_19 = 0i;
                            loop {
                                let _e967 = i_19;
                                if (_e967 < 8i) {
                                    let _e969 = startDir_3;
                                    let _e970 = i_19;
                                    let _e971 = (_e969 + _e970);
                                    d_14 = (_e971 - (i32(floor((f32(_e971) / f32(8i)))) * 8i));
                                    let _e979 = sPos_2;
                                    let _e980 = d_14;
                                    param_585 = _e980;
                                    let _e981 = getHDir_u0028_i1_u003b((&param_585));
                                    pushPos_1 = (_e979 + _e981);
                                    let _e984 = pushPos_1[0u];
                                    let _e985 = (_e984 > 0i);
                                    phi_4432_ = _e985;
                                    if _e985 {
                                        let _e987 = pushPos_1[0u];
                                        let _e989 = tuning.gridWidth;
                                        phi_4432_ = (_e987 < (bitcast<i32>(_e989) - 1i));
                                    }
                                    let _e994 = phi_4432_;
                                    phi_4438_ = _e994;
                                    if _e994 {
                                        let _e996 = pushPos_1[2u];
                                        phi_4438_ = (_e996 > 0i);
                                    }
                                    let _e999 = phi_4438_;
                                    phi_4448_ = _e999;
                                    if _e999 {
                                        let _e1001 = pushPos_1[2u];
                                        let _e1003 = tuning.gridDepth;
                                        phi_4448_ = (_e1001 < (bitcast<i32>(_e1003) - 1i));
                                    }
                                    let _e1008 = phi_4448_;
                                    if _e1008 {
                                        param_586 = 4u;
                                        param_587 = 0u;
                                        param_588 = 0u;
                                        let _e1009 = moisture_4;
                                        param_589 = _e1009;
                                        let _e1010 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_586), (&param_587), (&param_588), (&param_589));
                                        let _e1011 = pushPos_1;
                                        param_590 = _e1011;
                                        let _e1012 = getIndex_u0028_vi3_u003b((&param_590));
                                        let _e1013 = (*currentIndex_9);
                                        param_591 = _e1013;
                                        param_592 = _e1010;
                                        let _e1014 = sIndex;
                                        param_593 = _e1014;
                                        let _e1015 = sValue;
                                        param_594 = _e1015;
                                        param_595 = _e1012;
                                        let _e1016 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_591), (&param_592), (&param_593), (&param_594), (&param_595));
                                        if _e1016 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1017 = i_19;
                                    i_19 = (_e1017 + 1i);
                                }
                            }
                            param_596 = 4u;
                            param_597 = 0u;
                            param_598 = 0u;
                            let _e1019 = moisture_4;
                            param_599 = _e1019;
                            let _e1020 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_596), (&param_597), (&param_598), (&param_599));
                            let _e1021 = (*currentIndex_9);
                            param_600 = _e1021;
                            let _e1022 = (*rawValue_7);
                            param_601 = _e1022;
                            let _e1023 = sIndex;
                            param_602 = _e1023;
                            param_603 = _e1020;
                            let _e1024 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_600), (&param_601), (&param_602), (&param_603));
                            if _e1024 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1025 = s_1;
                    s_1 = (_e1025 + 1i);
                }
            }
        }
    }
    let _e1027 = (*currentDir_4);
    floraState = _e1027;
    let _e1028 = isClumped;
    phi_4503_ = _e1028;
    if !(_e1028) {
        let _e1030 = (*currentSleep_4);
        let _e1032 = tuning.wakeSleepThreshold;
        phi_4503_ = (_e1030 > _e1032);
    }
    let _e1035 = phi_4503_;
    if _e1035 {
        let _e1036 = (*pos_14);
        abovePos_1 = (_e1036 + vec3<i32>(0i, 1i, 0i));
        let _e1039 = abovePos_1[1u];
        let _e1041 = tuning.gridHeight;
        aboveInside = (_e1039 < (bitcast<i32>(_e1041) - 1i));
        let _e1045 = abovePos_1;
        param_604 = _e1045;
        let _e1046 = getIndex_u0028_vi3_u003b((&param_604));
        aboveIndex = _e1046;
        let _e1047 = aboveInside;
        if _e1047 {
            let _e1048 = aboveIndex;
            param_605 = _e1048;
            let _e1049 = readCell_u0028_u1_u003b((&param_605));
            param_606 = _e1049;
            let _e1050 = getType_u0028_u1_u003b((&param_606));
            local_21 = _e1050;
        } else {
            local_21 = 0u;
        }
        let _e1051 = local_21;
        aboveType = _e1051;
        let _e1052 = aboveType;
        let _e1054 = aboveType;
        if ((_e1052 == 0u) || (_e1054 == 18u)) {
            let _e1057 = moisture_4;
            let _e1059 = floraState;
            if ((_e1057 >= 5u) && (_e1059 < 100u)) {
                let _e1062 = (*randVal_9);
                let _e1066 = tuning.grassGrowChance;
                if (fract((_e1062 * 55f)) < _e1066) {
                    let _e1068 = floraState;
                    floraState = (_e1068 + bitcast<u32>(1i));
                    let _e1071 = floraState;
                    let _e1073 = aboveType;
                    let _e1076 = aboveInside;
                    let _e1077 = (((_e1071 == 100u) && (_e1073 == 0u)) && _e1076);
                    phi_4577_ = _e1077;
                    if _e1077 {
                        let _e1078 = (*randVal_9);
                        let _e1082 = tuning.treeBloomChance;
                        phi_4577_ = (fract((_e1078 * 97f)) < _e1082);
                    }
                    let _e1085 = phi_4577_;
                    if _e1085 {
                        let _e1086 = aboveIndex;
                        param_607 = 18u;
                        param_608 = 0u;
                        param_609 = 0u;
                        param_610 = 0u;
                        let _e1089 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_607), (&param_608), (&param_609), (&param_610));
                        let _e1090 = atomicCompareExchangeWeak((&unnamed.grid[_e1086]), 0u, _e1089);
                    }
                }
            }
            let _e1092 = floraState;
            if (_e1092 > 100u) {
                floraState = 100u;
            }
        } else {
            let _e1094 = aboveType;
            if (_e1094 == 2u) {
                let _e1096 = floraState;
                if (_e1096 > 0u) {
                    let _e1098 = floraState;
                    if (_e1098 <= 100u) {
                        floraState = 101u;
                    }
                    let _e1100 = (*randVal_9);
                    let _e1104 = tuning.grassSubmergedDecayChance;
                    if (fract((_e1100 * 66f)) < _e1104) {
                        let _e1106 = floraState;
                        floraState = (_e1106 + bitcast<u32>(1i));
                    }
                    let _e1109 = floraState;
                    if (_e1109 >= 200u) {
                        floraState = 0u;
                    }
                }
            } else {
                let _e1111 = aboveType;
                let _e1112 = (_e1111 != 5u);
                phi_4632_ = _e1112;
                if _e1112 {
                    let _e1113 = aboveType;
                    param_611 = _e1113;
                    let _e1114 = isLocust_u0028_u1_u003b((&param_611));
                    phi_4632_ = !(_e1114);
                }
                let _e1117 = phi_4632_;
                if _e1117 {
                    floraState = 0u;
                }
            }
        }
    }
    let _e1118 = (*currentSleep_4);
    newSleep_2 = min((_e1118 + 1u), 255u);
    let _e1121 = (*currentIndex_9);
    let _e1124 = (*rawValue_7);
    param_612 = 4u;
    let _e1125 = floraState;
    param_613 = _e1125;
    let _e1126 = newSleep_2;
    param_614 = _e1126;
    let _e1127 = moisture_4;
    param_615 = _e1127;
    let _e1128 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_612), (&param_613), (&param_614), (&param_615));
    let _e1129 = atomicCompareExchangeWeak((&unnamed.grid[_e1121]), _e1124, _e1128);
    return;
}

fn updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_15: ptr<function, vec3<i32>>, currentIndex_10: ptr<function, u32>, rawValue_8: ptr<function, u32>, currentDir_5: ptr<function, u32>, currentSleep_5: ptr<function, u32>, currentAge_8: ptr<function, u32>, randVal_10: ptr<function, f32>) {
    var wake: bool;
    var param_616: vec3<i32>;
    var param_617: u32;
    var param_618: u32;
    var hasPressure_1: bool;
    var local_22: bool;
    var param_619: vec3<i32>;
    var param_620: u32;
    var param_621: u32;
    var isStackedOnWater: bool;
    var local_23: bool;
    var param_622: vec3<i32>;
    var param_623: u32;
    var param_624: u32;
    var d_15: i32;
    var nPos_7: vec3<i32>;
    var param_625: i32;
    var param_626: vec3<i32>;
    var param_627: u32;
    var param_628: u32;
    var belowNeighbor: u32;
    var param_629: vec3<i32>;
    var param_630: u32;
    var param_631: u32;
    var newAge_2: u32;
    var belowPos_7: vec3<i32>;
    var param_632: vec3<i32>;
    var param_633: u32;
    var param_634: u32;
    var param_635: vec3<i32>;
    var param_636: u32;
    var param_637: u32;
    var param_638: u32;
    var param_639: u32;
    var param_640: u32;
    var param_641: u32;
    var param_642: u32;
    var param_643: u32;
    var newDir: u32;
    var r_1: f32;
    var diagDir: u32;
    var r_2: f32;
    var stepPos: vec3<i32>;
    var param_644: i32;
    var param_645: vec3<i32>;
    var param_646: u32;
    var param_647: u32;
    var newValue_1: u32;
    var param_648: u32;
    var param_649: u32;
    var param_650: u32;
    var param_651: u32;
    var param_652: vec3<i32>;
    var param_653: u32;
    var param_654: u32;
    var param_655: u32;
    var param_656: u32;
    var bestDropPos: vec3<i32>;
    var foundDrop: bool;
    var blockedMask_1: u32;
    var startDir_4: i32;
    var waterReach: i32;
    var r_3: i32;
    var i_20: i32;
    var d_16: i32;
    var c_7: vec3<i32>;
    var param_657: i32;
    var param_658: vec3<i32>;
    var param_659: u32;
    var param_660: u32;
    var param_661: vec3<i32>;
    var param_662: u32;
    var param_663: u32;
    var newValue_2: u32;
    var param_664: u32;
    var param_665: u32;
    var param_666: u32;
    var param_667: u32;
    var param_668: vec3<i32>;
    var param_669: u32;
    var param_670: u32;
    var param_671: u32;
    var param_672: u32;
    var hasPressure_2: bool;
    var local_24: bool;
    var param_673: vec3<i32>;
    var param_674: u32;
    var param_675: u32;
    var isStackedOnWater_1: bool;
    var local_25: bool;
    var param_676: vec3<i32>;
    var param_677: u32;
    var param_678: u32;
    var canStepOntoPool: bool;
    var d_17: i32;
    var nPos_8: vec3<i32>;
    var param_679: i32;
    var param_680: vec3<i32>;
    var param_681: u32;
    var param_682: u32;
    var param_683: vec3<i32>;
    var param_684: u32;
    var param_685: u32;
    var startSpreadDir: i32;
    var i_21: i32;
    var d_18: i32;
    var targetPos_2: vec3<i32>;
    var param_686: i32;
    var param_687: vec3<i32>;
    var param_688: u32;
    var param_689: u32;
    var newValue_3: u32;
    var param_690: u32;
    var param_691: u32;
    var param_692: u32;
    var param_693: u32;
    var param_694: vec3<i32>;
    var param_695: u32;
    var param_696: u32;
    var param_697: u32;
    var param_698: u32;
    var newSleep_3: u32;
    var sleepValue: u32;
    var param_699: u32;
    var param_700: u32;
    var param_701: u32;
    var param_702: u32;
    var phi_4672_: bool;
    var phi_4742_: bool;
    var phi_4748_: bool;
    var phi_4758_: bool;
    var phi_4944_: bool;
    var phi_4950_: bool;
    var phi_4960_: bool;
    var phi_5075_: bool;
    var phi_5082_: bool;
    var phi_5093_: bool;
    var phi_5105_: bool;
    var phi_5127_: bool;
    var phi_5231_: bool;
    var phi_5237_: bool;
    var phi_5247_: bool;
    var phi_5263_: bool;
    var phi_5275_: bool;
    var phi_5325_: bool;
    var phi_5331_: bool;
    var phi_5341_: bool;

    let _e338 = (*currentSleep_5);
    let _e340 = tuning.wakeSleepThreshold;
    if (_e338 > _e340) {
        wake = false;
        let _e343 = (*pos_15)[1u];
        let _e344 = (_e343 > 1i);
        phi_4672_ = _e344;
        if _e344 {
            let _e345 = (*pos_15);
            param_616 = (_e345 + vec3<i32>(0i, -1i, 0i));
            let _e347 = getIndex_u0028_vi3_u003b((&param_616));
            param_617 = _e347;
            let _e348 = readCell_u0028_u1_u003b((&param_617));
            param_618 = _e348;
            let _e349 = getType_u0028_u1_u003b((&param_618));
            phi_4672_ = (_e349 == 0u);
        }
        let _e352 = phi_4672_;
        if _e352 {
            wake = true;
        } else {
            let _e354 = (*pos_15)[1u];
            let _e356 = tuning.gridHeight;
            if (_e354 < (bitcast<i32>(_e356) - 2i)) {
                let _e360 = (*pos_15);
                param_619 = (_e360 + vec3<i32>(0i, 1i, 0i));
                let _e362 = getIndex_u0028_vi3_u003b((&param_619));
                param_620 = _e362;
                let _e363 = readCell_u0028_u1_u003b((&param_620));
                param_621 = _e363;
                let _e364 = getType_u0028_u1_u003b((&param_621));
                local_22 = (_e364 != 0u);
            } else {
                local_22 = false;
            }
            let _e366 = local_22;
            hasPressure_1 = _e366;
            let _e368 = (*pos_15)[1u];
            if (_e368 > 1i) {
                let _e370 = (*pos_15);
                param_622 = (_e370 + vec3<i32>(0i, -1i, 0i));
                let _e372 = getIndex_u0028_vi3_u003b((&param_622));
                param_623 = _e372;
                let _e373 = readCell_u0028_u1_u003b((&param_623));
                param_624 = _e373;
                let _e374 = getType_u0028_u1_u003b((&param_624));
                local_23 = (_e374 == 2u);
            } else {
                local_23 = false;
            }
            let _e376 = local_23;
            isStackedOnWater = _e376;
            d_15 = 0i;
            loop {
                let _e377 = d_15;
                if (_e377 < 8i) {
                    let _e379 = (*pos_15);
                    let _e380 = d_15;
                    param_625 = _e380;
                    let _e381 = getHDir_u0028_i1_u003b((&param_625));
                    nPos_7 = (_e379 + _e381);
                    let _e384 = nPos_7[0u];
                    let _e385 = (_e384 > 0i);
                    phi_4742_ = _e385;
                    if _e385 {
                        let _e387 = nPos_7[0u];
                        let _e389 = tuning.gridWidth;
                        phi_4742_ = (_e387 < (bitcast<i32>(_e389) - 1i));
                    }
                    let _e394 = phi_4742_;
                    phi_4748_ = _e394;
                    if _e394 {
                        let _e396 = nPos_7[2u];
                        phi_4748_ = (_e396 > 0i);
                    }
                    let _e399 = phi_4748_;
                    phi_4758_ = _e399;
                    if _e399 {
                        let _e401 = nPos_7[2u];
                        let _e403 = tuning.gridDepth;
                        phi_4758_ = (_e401 < (bitcast<i32>(_e403) - 1i));
                    }
                    let _e408 = phi_4758_;
                    if _e408 {
                        let _e409 = nPos_7;
                        param_626 = _e409;
                        let _e410 = getIndex_u0028_vi3_u003b((&param_626));
                        param_627 = _e410;
                        let _e411 = readCell_u0028_u1_u003b((&param_627));
                        param_628 = _e411;
                        let _e412 = getType_u0028_u1_u003b((&param_628));
                        if (_e412 == 0u) {
                            let _e414 = nPos_7;
                            param_629 = (_e414 + vec3<i32>(0i, -1i, 0i));
                            let _e416 = getIndex_u0028_vi3_u003b((&param_629));
                            param_630 = _e416;
                            let _e417 = readCell_u0028_u1_u003b((&param_630));
                            param_631 = _e417;
                            let _e418 = getType_u0028_u1_u003b((&param_631));
                            belowNeighbor = _e418;
                            let _e419 = belowNeighbor;
                            let _e421 = hasPressure_1;
                            let _e423 = isStackedOnWater;
                            let _e425 = belowNeighbor;
                            if ((((_e419 == 0u) || _e421) || _e423) || (_e425 == 2u)) {
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
                    let _e428 = d_15;
                    d_15 = (_e428 + 1i);
                }
            }
        }
        let _e430 = wake;
        if !(_e430) {
            return;
        }
        (*currentSleep_5) = 0u;
        (*currentAge_8) = 0u;
    }
    let _e432 = (*currentAge_8);
    newAge_2 = (_e432 + 1u);
    let _e435 = (*pos_15)[1u];
    if (_e435 > 1i) {
        let _e437 = (*pos_15);
        belowPos_7 = (_e437 + vec3<i32>(0i, -1i, 0i));
        let _e439 = belowPos_7;
        param_632 = _e439;
        let _e440 = getIndex_u0028_vi3_u003b((&param_632));
        param_633 = _e440;
        let _e441 = readCell_u0028_u1_u003b((&param_633));
        param_634 = _e441;
        let _e442 = getType_u0028_u1_u003b((&param_634));
        if (_e442 == 0u) {
            let _e444 = belowPos_7;
            param_635 = _e444;
            let _e445 = getIndex_u0028_vi3_u003b((&param_635));
            param_636 = 2u;
            param_637 = 0u;
            param_638 = 0u;
            let _e446 = newAge_2;
            param_639 = _e446;
            let _e447 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_636), (&param_637), (&param_638), (&param_639));
            let _e448 = (*currentIndex_10);
            param_640 = _e448;
            let _e449 = (*rawValue_8);
            param_641 = _e449;
            param_642 = _e445;
            param_643 = _e447;
            let _e450 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_640), (&param_641), (&param_642), (&param_643));
            if _e450 {
                return;
            }
        }
    }
    let _e451 = (*currentDir_5);
    newDir = _e451;
    let _e452 = newDir;
    let _e454 = newDir;
    if ((_e452 == 0u) || (_e454 == 9u)) {
        let _e457 = (*randVal_10);
        r_1 = fract((_e457 * 77f));
        let _e460 = r_1;
        if (_e460 < 0.25f) {
            newDir = 1u;
        } else {
            let _e462 = r_1;
            if (_e462 < 0.5f) {
                newDir = 2u;
            } else {
                let _e464 = r_1;
                if (_e464 < 0.75f) {
                    newDir = 3u;
                } else {
                    newDir = 4u;
                }
            }
        }
    }
    let _e466 = newAge_2;
    let _e469 = newAge_2;
    if (((_e466 % 3u) == 0u) && (_e469 > 0u)) {
        let _e472 = newDir;
        diagDir = _e472;
        let _e473 = diagDir;
        let _e475 = diagDir;
        if ((_e473 >= 1u) && (_e475 <= 4u)) {
            let _e478 = (*randVal_10);
            r_2 = fract((_e478 * 133f));
            let _e481 = diagDir;
            if (_e481 == 1u) {
                let _e483 = r_2;
                diagDir = select(6u, 5u, (_e483 > 0.5f));
            } else {
                let _e486 = diagDir;
                if (_e486 == 2u) {
                    let _e488 = r_2;
                    diagDir = select(8u, 7u, (_e488 > 0.5f));
                } else {
                    let _e491 = diagDir;
                    if (_e491 == 3u) {
                        let _e493 = r_2;
                        diagDir = select(7u, 5u, (_e493 > 0.5f));
                    } else {
                        let _e496 = diagDir;
                        if (_e496 == 4u) {
                            let _e498 = r_2;
                            diagDir = select(8u, 6u, (_e498 > 0.5f));
                        }
                    }
                }
            }
        }
        let _e501 = (*pos_15);
        let _e502 = diagDir;
        param_644 = (bitcast<i32>(_e502) - 1i);
        let _e505 = getHDir_u0028_i1_u003b((&param_644));
        stepPos = (_e501 + _e505);
        let _e508 = stepPos[0u];
        let _e509 = (_e508 > 0i);
        phi_4944_ = _e509;
        if _e509 {
            let _e511 = stepPos[0u];
            let _e513 = tuning.gridWidth;
            phi_4944_ = (_e511 < (bitcast<i32>(_e513) - 1i));
        }
        let _e518 = phi_4944_;
        phi_4950_ = _e518;
        if _e518 {
            let _e520 = stepPos[2u];
            phi_4950_ = (_e520 > 0i);
        }
        let _e523 = phi_4950_;
        phi_4960_ = _e523;
        if _e523 {
            let _e525 = stepPos[2u];
            let _e527 = tuning.gridDepth;
            phi_4960_ = (_e525 < (bitcast<i32>(_e527) - 1i));
        }
        let _e532 = phi_4960_;
        if _e532 {
            let _e533 = stepPos;
            param_645 = _e533;
            let _e534 = getIndex_u0028_vi3_u003b((&param_645));
            param_646 = _e534;
            let _e535 = readCell_u0028_u1_u003b((&param_646));
            param_647 = _e535;
            let _e536 = getType_u0028_u1_u003b((&param_647));
            if (_e536 == 0u) {
                param_648 = 2u;
                let _e538 = newDir;
                param_649 = _e538;
                param_650 = 0u;
                let _e539 = newAge_2;
                param_651 = _e539;
                let _e540 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_648), (&param_649), (&param_650), (&param_651));
                newValue_1 = _e540;
                let _e541 = stepPos;
                param_652 = _e541;
                let _e542 = getIndex_u0028_vi3_u003b((&param_652));
                let _e543 = (*currentIndex_10);
                param_653 = _e543;
                let _e544 = (*rawValue_8);
                param_654 = _e544;
                param_655 = _e542;
                let _e545 = newValue_1;
                param_656 = _e545;
                let _e546 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_653), (&param_654), (&param_655), (&param_656));
                if _e546 {
                    return;
                }
            }
        }
    }
    let _e547 = (*pos_15);
    bestDropPos = _e547;
    foundDrop = false;
    blockedMask_1 = 0u;
    let _e548 = (*randVal_10);
    startDir_4 = i32((fract((_e548 * 8f)) * 8f));
    let _e554 = tuning.waterSpreadRadius;
    let _e556 = tuning.gridWidth;
    let _e559 = tuning.gridHeight;
    waterReach = bitcast<i32>(clamp(_e554, 1u, bitcast<u32>(max(bitcast<i32>(_e556), bitcast<i32>(_e559)))));
    r_3 = 1i;
    loop {
        let _e565 = r_3;
        let _e566 = waterReach;
        if (_e565 <= _e566) {
            let _e568 = blockedMask_1;
            if (_e568 == 255u) {
                break;
            }
            i_20 = 0i;
            loop {
                let _e570 = i_20;
                if (_e570 < 8i) {
                    let _e572 = startDir_4;
                    let _e573 = i_20;
                    let _e574 = (_e572 + _e573);
                    d_16 = (_e574 - (i32(floor((f32(_e574) / f32(8i)))) * 8i));
                    let _e582 = blockedMask_1;
                    let _e583 = d_16;
                    if ((_e582 & (1u << bitcast<u32>(_e583))) == 0u) {
                        let _e588 = (*pos_15);
                        let _e589 = d_16;
                        param_657 = _e589;
                        let _e590 = getHDir_u0028_i1_u003b((&param_657));
                        let _e591 = r_3;
                        c_7 = (_e588 + (_e590 * vec3(_e591)));
                        let _e596 = c_7[0u];
                        let _e597 = (_e596 <= 0i);
                        phi_5075_ = _e597;
                        if !(_e597) {
                            let _e600 = c_7[0u];
                            let _e602 = tuning.gridWidth;
                            phi_5075_ = (_e600 >= (bitcast<i32>(_e602) - 1i));
                        }
                        let _e607 = phi_5075_;
                        phi_5082_ = _e607;
                        if !(_e607) {
                            let _e610 = c_7[2u];
                            phi_5082_ = (_e610 <= 0i);
                        }
                        let _e613 = phi_5082_;
                        phi_5093_ = _e613;
                        if !(_e613) {
                            let _e616 = c_7[2u];
                            let _e618 = tuning.gridDepth;
                            phi_5093_ = (_e616 >= (bitcast<i32>(_e618) - 1i));
                        }
                        let _e623 = phi_5093_;
                        phi_5105_ = _e623;
                        if !(_e623) {
                            let _e625 = c_7;
                            param_658 = _e625;
                            let _e626 = getIndex_u0028_vi3_u003b((&param_658));
                            param_659 = _e626;
                            let _e627 = readCell_u0028_u1_u003b((&param_659));
                            param_660 = _e627;
                            let _e628 = getType_u0028_u1_u003b((&param_660));
                            phi_5105_ = (_e628 != 0u);
                        }
                        let _e631 = phi_5105_;
                        if _e631 {
                            let _e632 = d_16;
                            let _e635 = blockedMask_1;
                            blockedMask_1 = (_e635 | (1u << bitcast<u32>(_e632)));
                        } else {
                            let _e638 = c_7[1u];
                            let _e639 = (_e638 > 1i);
                            phi_5127_ = _e639;
                            if _e639 {
                                let _e640 = c_7;
                                param_661 = (_e640 + vec3<i32>(0i, -1i, 0i));
                                let _e642 = getIndex_u0028_vi3_u003b((&param_661));
                                param_662 = _e642;
                                let _e643 = readCell_u0028_u1_u003b((&param_662));
                                param_663 = _e643;
                                let _e644 = getType_u0028_u1_u003b((&param_663));
                                phi_5127_ = (_e644 == 0u);
                            }
                            let _e647 = phi_5127_;
                            if _e647 {
                                let _e648 = c_7;
                                bestDropPos = _e648;
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
                    let _e649 = i_20;
                    i_20 = (_e649 + 1i);
                }
            }
            let _e651 = foundDrop;
            if _e651 {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e652 = r_3;
            r_3 = (_e652 + 1i);
        }
    }
    let _e654 = foundDrop;
    if _e654 {
        param_664 = 2u;
        param_665 = 0u;
        param_666 = 0u;
        param_667 = 0u;
        let _e655 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_664), (&param_665), (&param_666), (&param_667));
        newValue_2 = _e655;
        let _e656 = bestDropPos;
        param_668 = _e656;
        let _e657 = getIndex_u0028_vi3_u003b((&param_668));
        let _e658 = (*currentIndex_10);
        param_669 = _e658;
        let _e659 = (*rawValue_8);
        param_670 = _e659;
        param_671 = _e657;
        let _e660 = newValue_2;
        param_672 = _e660;
        let _e661 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_669), (&param_670), (&param_671), (&param_672));
        if _e661 {
            return;
        }
    } else {
        let _e663 = (*pos_15)[1u];
        let _e665 = tuning.gridHeight;
        if (_e663 < (bitcast<i32>(_e665) - 2i)) {
            let _e669 = (*pos_15);
            param_673 = (_e669 + vec3<i32>(0i, 1i, 0i));
            let _e671 = getIndex_u0028_vi3_u003b((&param_673));
            param_674 = _e671;
            let _e672 = readCell_u0028_u1_u003b((&param_674));
            param_675 = _e672;
            let _e673 = getType_u0028_u1_u003b((&param_675));
            local_24 = (_e673 != 0u);
        } else {
            local_24 = false;
        }
        let _e675 = local_24;
        hasPressure_2 = _e675;
        let _e677 = (*pos_15)[1u];
        if (_e677 > 1i) {
            let _e679 = (*pos_15);
            param_676 = (_e679 + vec3<i32>(0i, -1i, 0i));
            let _e681 = getIndex_u0028_vi3_u003b((&param_676));
            param_677 = _e681;
            let _e682 = readCell_u0028_u1_u003b((&param_677));
            param_678 = _e682;
            let _e683 = getType_u0028_u1_u003b((&param_678));
            local_25 = (_e683 == 2u);
        } else {
            local_25 = false;
        }
        let _e685 = local_25;
        isStackedOnWater_1 = _e685;
        canStepOntoPool = false;
        d_17 = 0i;
        loop {
            let _e686 = d_17;
            if (_e686 < 8i) {
                let _e688 = (*pos_15);
                let _e689 = d_17;
                param_679 = _e689;
                let _e690 = getHDir_u0028_i1_u003b((&param_679));
                nPos_8 = (_e688 + _e690);
                let _e693 = nPos_8[0u];
                let _e694 = (_e693 > 0i);
                phi_5231_ = _e694;
                if _e694 {
                    let _e696 = nPos_8[0u];
                    let _e698 = tuning.gridWidth;
                    phi_5231_ = (_e696 < (bitcast<i32>(_e698) - 1i));
                }
                let _e703 = phi_5231_;
                phi_5237_ = _e703;
                if _e703 {
                    let _e705 = nPos_8[2u];
                    phi_5237_ = (_e705 > 0i);
                }
                let _e708 = phi_5237_;
                phi_5247_ = _e708;
                if _e708 {
                    let _e710 = nPos_8[2u];
                    let _e712 = tuning.gridDepth;
                    phi_5247_ = (_e710 < (bitcast<i32>(_e712) - 1i));
                }
                let _e717 = phi_5247_;
                if _e717 {
                    let _e718 = nPos_8;
                    param_680 = _e718;
                    let _e719 = getIndex_u0028_vi3_u003b((&param_680));
                    param_681 = _e719;
                    let _e720 = readCell_u0028_u1_u003b((&param_681));
                    param_682 = _e720;
                    let _e721 = getType_u0028_u1_u003b((&param_682));
                    let _e722 = (_e721 == 0u);
                    phi_5263_ = _e722;
                    if _e722 {
                        let _e724 = (*pos_15)[1u];
                        phi_5263_ = (_e724 > 1i);
                    }
                    let _e727 = phi_5263_;
                    phi_5275_ = _e727;
                    if _e727 {
                        let _e728 = nPos_8;
                        param_683 = (_e728 + vec3<i32>(0i, -1i, 0i));
                        let _e730 = getIndex_u0028_vi3_u003b((&param_683));
                        param_684 = _e730;
                        let _e731 = readCell_u0028_u1_u003b((&param_684));
                        param_685 = _e731;
                        let _e732 = getType_u0028_u1_u003b((&param_685));
                        phi_5275_ = (_e732 == 2u);
                    }
                    let _e735 = phi_5275_;
                    if _e735 {
                        canStepOntoPool = true;
                        break;
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e736 = d_17;
                d_17 = (_e736 + 1i);
            }
        }
        let _e738 = hasPressure_2;
        let _e739 = isStackedOnWater_1;
        let _e741 = canStepOntoPool;
        if ((_e738 || _e739) || _e741) {
            let _e743 = (*randVal_10);
            startSpreadDir = i32((fract((_e743 * 8f)) * 8f));
            i_21 = 0i;
            loop {
                let _e748 = i_21;
                if (_e748 < 8i) {
                    let _e750 = startSpreadDir;
                    let _e751 = i_21;
                    let _e752 = (_e750 + _e751);
                    d_18 = (_e752 - (i32(floor((f32(_e752) / f32(8i)))) * 8i));
                    let _e760 = (*pos_15);
                    let _e761 = d_18;
                    param_686 = _e761;
                    let _e762 = getHDir_u0028_i1_u003b((&param_686));
                    targetPos_2 = (_e760 + _e762);
                    let _e765 = targetPos_2[0u];
                    let _e766 = (_e765 > 0i);
                    phi_5325_ = _e766;
                    if _e766 {
                        let _e768 = targetPos_2[0u];
                        let _e770 = tuning.gridWidth;
                        phi_5325_ = (_e768 < (bitcast<i32>(_e770) - 1i));
                    }
                    let _e775 = phi_5325_;
                    phi_5331_ = _e775;
                    if _e775 {
                        let _e777 = targetPos_2[2u];
                        phi_5331_ = (_e777 > 0i);
                    }
                    let _e780 = phi_5331_;
                    phi_5341_ = _e780;
                    if _e780 {
                        let _e782 = targetPos_2[2u];
                        let _e784 = tuning.gridDepth;
                        phi_5341_ = (_e782 < (bitcast<i32>(_e784) - 1i));
                    }
                    let _e789 = phi_5341_;
                    if _e789 {
                        let _e790 = targetPos_2;
                        param_687 = _e790;
                        let _e791 = getIndex_u0028_vi3_u003b((&param_687));
                        param_688 = _e791;
                        let _e792 = readCell_u0028_u1_u003b((&param_688));
                        param_689 = _e792;
                        let _e793 = getType_u0028_u1_u003b((&param_689));
                        if (_e793 == 0u) {
                            let _e795 = d_18;
                            param_690 = 2u;
                            param_691 = bitcast<u32>((_e795 + 1i));
                            param_692 = 0u;
                            let _e798 = newAge_2;
                            param_693 = _e798;
                            let _e799 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_690), (&param_691), (&param_692), (&param_693));
                            newValue_3 = _e799;
                            let _e800 = targetPos_2;
                            param_694 = _e800;
                            let _e801 = getIndex_u0028_vi3_u003b((&param_694));
                            let _e802 = (*currentIndex_10);
                            param_695 = _e802;
                            let _e803 = (*rawValue_8);
                            param_696 = _e803;
                            param_697 = _e801;
                            let _e804 = newValue_3;
                            param_698 = _e804;
                            let _e805 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_695), (&param_696), (&param_697), (&param_698));
                            if _e805 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e806 = i_21;
                    i_21 = (_e806 + 1i);
                }
            }
        }
    }
    let _e808 = (*currentSleep_5);
    newSleep_3 = min((_e808 + 1u), 255u);
    param_699 = 2u;
    param_700 = 0u;
    let _e811 = newSleep_3;
    param_701 = _e811;
    let _e812 = newAge_2;
    param_702 = _e812;
    let _e813 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_699), (&param_700), (&param_701), (&param_702));
    sleepValue = _e813;
    let _e814 = (*currentIndex_10);
    let _e817 = (*rawValue_8);
    let _e818 = sleepValue;
    let _e819 = atomicCompareExchangeWeak((&unnamed.grid[_e814]), _e817, _e818);
    return;
}

fn incWater_u0028_() {
    let _e205 = atomicAdd((&unnamed_2.waterVoxelCount), 1u);
    return;
}

fn updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_16: ptr<function, vec3<i32>>, currentIndex_11: ptr<function, u32>, rawValue_9: ptr<function, u32>, currentSleep_6: ptr<function, u32>, currentAge_9: ptr<function, u32>, randVal_11: ptr<function, f32>) {
    var moisture_5: u32;
    var moistureModified_1: bool;
    var startDir_5: i32;
    var i_22: i32;
    var d_19: i32;
    var nPos_9: vec3<i32>;
    var param_703: i32;
    var nIndex_5: u32;
    var param_704: vec3<i32>;
    var nVal_5: u32;
    var param_705: u32;
    var param_706: u32;
    var d_20: i32;
    var nPos_10: vec3<i32>;
    var param_707: i32;
    var nIndex_6: u32;
    var param_708: vec3<i32>;
    var nVal_6: u32;
    var param_709: u32;
    var nType_4: u32;
    var param_710: u32;
    var nMoisture_1: u32;
    var param_711: u32;
    var nCapacity_1: u32;
    var local_26: u32;
    var leakPos: vec3<i32>;
    var param_712: vec3<i32>;
    var param_713: u32;
    var param_714: u32;
    var param_715: vec3<i32>;
    var param_716: u32;
    var param_717: u32;
    var param_718: u32;
    var param_719: u32;
    var canMove_1: bool;
    var param_720: vec3<i32>;
    var isClumped_1: bool;
    var emptyBelowCount_1: i32;
    var x_2: i32;
    var z_2: i32;
    var checkPos_2: vec3<i32>;
    var param_721: vec3<i32>;
    var param_722: u32;
    var param_723: u32;
    var clumpCount_1: i32;
    var x_3: i32;
    var y_1: i32;
    var z_3: i32;
    var nPos_11: vec3<i32>;
    var param_724: vec3<i32>;
    var param_725: u32;
    var param_726: u32;
    var belowPos_8: vec3<i32>;
    var param_727: vec3<i32>;
    var param_728: u32;
    var param_729: u32;
    var param_730: vec3<i32>;
    var param_731: u32;
    var param_732: u32;
    var param_733: u32;
    var param_734: u32;
    var param_735: u32;
    var param_736: u32;
    var param_737: u32;
    var param_738: u32;
    var dir_4: i32;
    var slidePos1_1: vec3<i32>;
    var slidePos2_1: vec3<i32>;
    var param_739: vec3<i32>;
    var param_740: u32;
    var param_741: u32;
    var param_742: vec3<i32>;
    var param_743: u32;
    var param_744: u32;
    var param_745: u32;
    var param_746: u32;
    var param_747: u32;
    var param_748: u32;
    var param_749: u32;
    var param_750: u32;
    var param_751: vec3<i32>;
    var param_752: u32;
    var param_753: u32;
    var param_754: vec3<i32>;
    var param_755: u32;
    var param_756: u32;
    var param_757: u32;
    var param_758: u32;
    var param_759: u32;
    var param_760: u32;
    var param_761: u32;
    var param_762: u32;
    var belowPos_9: vec3<i32>;
    var belowIndex_3: u32;
    var param_763: vec3<i32>;
    var belowValue_3: u32;
    var param_764: u32;
    var param_765: u32;
    var startDir_6: i32;
    var i_23: i32;
    var d_21: i32;
    var pushPos_2: vec3<i32>;
    var param_766: i32;
    var param_767: u32;
    var param_768: u32;
    var param_769: u32;
    var param_770: u32;
    var param_771: vec3<i32>;
    var param_772: u32;
    var param_773: u32;
    var param_774: u32;
    var param_775: u32;
    var param_776: u32;
    var param_777: u32;
    var param_778: u32;
    var param_779: u32;
    var param_780: u32;
    var param_781: u32;
    var param_782: u32;
    var param_783: u32;
    var param_784: u32;
    var dir_5: i32;
    var slidePos_1: array<vec3<i32>, 2>;
    var s_2: i32;
    var sPos_3: vec3<i32>;
    var sIndex_1: u32;
    var param_785: vec3<i32>;
    var sValue_1: u32;
    var param_786: u32;
    var param_787: u32;
    var startDir_7: i32;
    var i_24: i32;
    var d_22: i32;
    var pushPos_3: vec3<i32>;
    var param_788: i32;
    var param_789: u32;
    var param_790: u32;
    var param_791: u32;
    var param_792: u32;
    var param_793: vec3<i32>;
    var param_794: u32;
    var param_795: u32;
    var param_796: u32;
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
    var newSleep_4: u32;
    var param_807: u32;
    var param_808: u32;
    var param_809: u32;
    var param_810: u32;
    var phi_2553_: bool;
    var phi_2559_: bool;
    var phi_2569_: bool;
    var phi_2575_: bool;
    var phi_2585_: bool;
    var phi_2656_: bool;
    var phi_2662_: bool;
    var phi_2672_: bool;
    var phi_2678_: bool;
    var phi_2688_: bool;
    var phi_2752_: bool;
    var phi_2771_: bool;
    var phi_2815_: bool;
    var phi_2857_: bool;
    var phi_2863_: bool;
    var phi_2872_: bool;
    var phi_2954_: bool;
    var phi_2960_: bool;
    var phi_2969_: bool;
    var phi_2975_: bool;
    var phi_2984_: bool;
    var phi_3106_: bool;
    var phi_3112_: bool;
    var phi_3122_: bool;
    var phi_3166_: bool;
    var phi_3172_: bool;
    var phi_3182_: bool;
    var phi_3274_: bool;
    var phi_3280_: bool;
    var phi_3290_: bool;
    var phi_3393_: bool;
    var phi_3399_: bool;
    var phi_3409_: bool;
    var phi_3466_: bool;
    var phi_3472_: bool;
    var phi_3482_: bool;

    let _e368 = (*currentAge_9);
    moisture_5 = _e368;
    moistureModified_1 = false;
    let _e369 = moisture_5;
    let _e371 = tuning.sandMoistureCapacity;
    if (_e369 < _e371) {
        let _e373 = (*randVal_11);
        startDir_5 = i32((fract((_e373 * 17f)) * 6f));
        i_22 = 0i;
        loop {
            let _e378 = i_22;
            if (_e378 < 6i) {
                let _e380 = startDir_5;
                let _e381 = i_22;
                let _e382 = (_e380 + _e381);
                d_19 = (_e382 - (i32(floor((f32(_e382) / f32(6i)))) * 6i));
                let _e390 = d_19;
                if (_e390 != 2i) {
                    let _e392 = (*pos_16);
                    let _e393 = d_19;
                    param_703 = _e393;
                    let _e394 = getOrthoDir_u0028_i1_u003b((&param_703));
                    nPos_9 = (_e392 + _e394);
                    let _e397 = nPos_9[0u];
                    let _e398 = (_e397 > 0i);
                    phi_2553_ = _e398;
                    if _e398 {
                        let _e400 = nPos_9[0u];
                        let _e402 = tuning.gridWidth;
                        phi_2553_ = (_e400 < (bitcast<i32>(_e402) - 1i));
                    }
                    let _e407 = phi_2553_;
                    phi_2559_ = _e407;
                    if _e407 {
                        let _e409 = nPos_9[1u];
                        phi_2559_ = (_e409 > 0i);
                    }
                    let _e412 = phi_2559_;
                    phi_2569_ = _e412;
                    if _e412 {
                        let _e414 = nPos_9[1u];
                        let _e416 = tuning.gridHeight;
                        phi_2569_ = (_e414 < (bitcast<i32>(_e416) - 1i));
                    }
                    let _e421 = phi_2569_;
                    phi_2575_ = _e421;
                    if _e421 {
                        let _e423 = nPos_9[2u];
                        phi_2575_ = (_e423 > 0i);
                    }
                    let _e426 = phi_2575_;
                    phi_2585_ = _e426;
                    if _e426 {
                        let _e428 = nPos_9[2u];
                        let _e430 = tuning.gridDepth;
                        phi_2585_ = (_e428 < (bitcast<i32>(_e430) - 1i));
                    }
                    let _e435 = phi_2585_;
                    if _e435 {
                        let _e436 = nPos_9;
                        param_704 = _e436;
                        let _e437 = getIndex_u0028_vi3_u003b((&param_704));
                        nIndex_5 = _e437;
                        let _e438 = nIndex_5;
                        param_705 = _e438;
                        let _e439 = readCell_u0028_u1_u003b((&param_705));
                        nVal_5 = _e439;
                        let _e440 = nVal_5;
                        param_706 = _e440;
                        let _e441 = getType_u0028_u1_u003b((&param_706));
                        if (_e441 == 2u) {
                            let _e443 = nIndex_5;
                            let _e446 = nVal_5;
                            let _e447 = atomicCompareExchangeWeak((&unnamed.grid[_e443]), _e446, 0u);
                            let _e449 = nVal_5;
                            if (_e447.old_value == _e449) {
                                let _e451 = (*currentIndex_11);
                                let _e455 = tuning.sandWaterAbsorbUnit;
                                let _e458 = atomicAdd((&unnamed.grid[_e451]), (_e455 << bitcast<u32>(24i)));
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
                let _e459 = i_22;
                i_22 = (_e459 + 1i);
            }
        }
    }
    let _e461 = moistureModified_1;
    let _e463 = moisture_5;
    if (!(_e461) && (_e463 > 0u)) {
        let _e466 = (*randVal_11);
        d_20 = i32((fract((_e466 * 31f)) * 6f));
        let _e471 = d_20;
        if (_e471 != 2i) {
            let _e473 = (*pos_16);
            let _e474 = d_20;
            param_707 = _e474;
            let _e475 = getOrthoDir_u0028_i1_u003b((&param_707));
            nPos_10 = (_e473 + _e475);
            let _e478 = nPos_10[0u];
            let _e479 = (_e478 > 0i);
            phi_2656_ = _e479;
            if _e479 {
                let _e481 = nPos_10[0u];
                let _e483 = tuning.gridWidth;
                phi_2656_ = (_e481 < (bitcast<i32>(_e483) - 1i));
            }
            let _e488 = phi_2656_;
            phi_2662_ = _e488;
            if _e488 {
                let _e490 = nPos_10[1u];
                phi_2662_ = (_e490 > 0i);
            }
            let _e493 = phi_2662_;
            phi_2672_ = _e493;
            if _e493 {
                let _e495 = nPos_10[1u];
                let _e497 = tuning.gridHeight;
                phi_2672_ = (_e495 < (bitcast<i32>(_e497) - 1i));
            }
            let _e502 = phi_2672_;
            phi_2678_ = _e502;
            if _e502 {
                let _e504 = nPos_10[2u];
                phi_2678_ = (_e504 > 0i);
            }
            let _e507 = phi_2678_;
            phi_2688_ = _e507;
            if _e507 {
                let _e509 = nPos_10[2u];
                let _e511 = tuning.gridDepth;
                phi_2688_ = (_e509 < (bitcast<i32>(_e511) - 1i));
            }
            let _e516 = phi_2688_;
            if _e516 {
                let _e517 = nPos_10;
                param_708 = _e517;
                let _e518 = getIndex_u0028_vi3_u003b((&param_708));
                nIndex_6 = _e518;
                let _e519 = nIndex_6;
                param_709 = _e519;
                let _e520 = readCell_u0028_u1_u003b((&param_709));
                nVal_6 = _e520;
                let _e521 = nVal_6;
                param_710 = _e521;
                let _e522 = getType_u0028_u1_u003b((&param_710));
                nType_4 = _e522;
                let _e523 = nType_4;
                let _e525 = nType_4;
                if ((_e523 == 1u) || (_e525 == 4u)) {
                    let _e528 = nVal_6;
                    param_711 = _e528;
                    let _e529 = getAge_u0028_u1_u003b((&param_711));
                    nMoisture_1 = _e529;
                    let _e530 = nType_4;
                    if (_e530 == 4u) {
                        let _e533 = tuning.dirtMoistureCapacity;
                        local_26 = _e533;
                    } else {
                        let _e535 = tuning.sandMoistureCapacity;
                        local_26 = _e535;
                    }
                    let _e536 = local_26;
                    nCapacity_1 = _e536;
                    let _e537 = moisture_5;
                    let _e538 = nMoisture_1;
                    let _e541 = nMoisture_1;
                    let _e542 = nCapacity_1;
                    if ((_e537 > (_e538 + 1u)) && (_e541 < _e542)) {
                        let _e545 = (*currentIndex_11);
                        let _e548 = atomicAdd((&unnamed.grid[_e545]), 4278190080u);
                        let _e549 = nIndex_6;
                        let _e552 = atomicAdd((&unnamed.grid[_e549]), 16777216u);
                        moistureModified_1 = true;
                    }
                }
            }
        }
    }
    let _e553 = moistureModified_1;
    let _e554 = !(_e553);
    phi_2752_ = _e554;
    if _e554 {
        let _e555 = moisture_5;
        let _e557 = tuning.sandWaterAbsorbUnit;
        phi_2752_ = (_e555 >= _e557);
    }
    let _e560 = phi_2752_;
    if _e560 {
        let _e561 = (*pos_16);
        leakPos = (_e561 + vec3<i32>(0i, -1i, 0i));
        let _e564 = leakPos[1u];
        let _e565 = (_e564 > 0i);
        phi_2771_ = _e565;
        if _e565 {
            let _e566 = leakPos;
            param_712 = _e566;
            let _e567 = getIndex_u0028_vi3_u003b((&param_712));
            param_713 = _e567;
            let _e568 = readCell_u0028_u1_u003b((&param_713));
            param_714 = _e568;
            let _e569 = getType_u0028_u1_u003b((&param_714));
            phi_2771_ = (_e569 == 0u);
        }
        let _e572 = phi_2771_;
        if _e572 {
            let _e573 = leakPos;
            param_715 = _e573;
            let _e574 = getIndex_u0028_vi3_u003b((&param_715));
            param_716 = 2u;
            param_717 = 0u;
            param_718 = 0u;
            param_719 = 0u;
            let _e577 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_716), (&param_717), (&param_718), (&param_719));
            let _e578 = atomicCompareExchangeWeak((&unnamed.grid[_e574]), 0u, _e577);
            if (_e578.old_value == 0u) {
                let _e581 = (*currentIndex_11);
                let _e585 = tuning.sandWaterAbsorbUnit;
                let _e589 = atomicAdd((&unnamed.grid[_e581]), ((0u - _e585) << bitcast<u32>(24i)));
                incWater_u0028_();
                moistureModified_1 = true;
            }
        }
    }
    let _e590 = moistureModified_1;
    if _e590 {
        return;
    }
    let _e591 = (*pos_16);
    param_720 = _e591;
    let _e592 = grainCanMove_u0028_vi3_u003b((&param_720));
    canMove_1 = _e592;
    isClumped_1 = false;
    let _e593 = canMove_1;
    let _e594 = moisture_5;
    let _e596 = (_e593 && (_e594 > 0u));
    phi_2815_ = _e596;
    if _e596 {
        let _e597 = (*currentSleep_6);
        let _e599 = tuning.wakeSleepThreshold;
        phi_2815_ = (_e597 > _e599);
    }
    let _e602 = phi_2815_;
    if _e602 {
        emptyBelowCount_1 = 0i;
        let _e604 = (*pos_16)[1u];
        if (_e604 > 1i) {
            x_2 = -1i;
            loop {
                let _e606 = x_2;
                if (_e606 <= 1i) {
                    z_2 = -1i;
                    loop {
                        let _e608 = z_2;
                        if (_e608 <= 1i) {
                            let _e610 = (*pos_16);
                            let _e611 = x_2;
                            let _e612 = z_2;
                            checkPos_2 = (_e610 + vec3<i32>(_e611, -1i, _e612));
                            let _e616 = checkPos_2[0u];
                            let _e617 = (_e616 >= 0i);
                            phi_2857_ = _e617;
                            if _e617 {
                                let _e619 = checkPos_2[0u];
                                let _e621 = tuning.gridWidth;
                                phi_2857_ = (_e619 < bitcast<i32>(_e621));
                            }
                            let _e625 = phi_2857_;
                            phi_2863_ = _e625;
                            if _e625 {
                                let _e627 = checkPos_2[2u];
                                phi_2863_ = (_e627 >= 0i);
                            }
                            let _e630 = phi_2863_;
                            phi_2872_ = _e630;
                            if _e630 {
                                let _e632 = checkPos_2[2u];
                                let _e634 = tuning.gridDepth;
                                phi_2872_ = (_e632 < bitcast<i32>(_e634));
                            }
                            let _e638 = phi_2872_;
                            if _e638 {
                                let _e639 = checkPos_2;
                                param_721 = _e639;
                                let _e640 = getIndex_u0028_vi3_u003b((&param_721));
                                param_722 = _e640;
                                let _e641 = readCell_u0028_u1_u003b((&param_722));
                                param_723 = _e641;
                                let _e642 = getType_u0028_u1_u003b((&param_723));
                                if (_e642 == 0u) {
                                    let _e644 = emptyBelowCount_1;
                                    emptyBelowCount_1 = (_e644 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e646 = z_2;
                            z_2 = (_e646 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e648 = x_2;
                    x_2 = (_e648 + 1i);
                }
            }
        }
        let _e650 = emptyBelowCount_1;
        let _e652 = tuning.emptyBelowWakeCount;
        if (_e650 >= bitcast<i32>(_e652)) {
            (*currentSleep_6) = 0u;
        } else {
            clumpCount_1 = 0i;
            x_3 = -1i;
            loop {
                let _e655 = x_3;
                if (_e655 <= 1i) {
                    y_1 = -1i;
                    loop {
                        let _e657 = y_1;
                        if (_e657 <= 1i) {
                            z_3 = -1i;
                            loop {
                                let _e659 = z_3;
                                if (_e659 <= 1i) {
                                    let _e661 = x_3;
                                    let _e663 = y_1;
                                    let _e666 = z_3;
                                    if (((_e661 == 0i) && (_e663 == 0i)) && (_e666 == 0i)) {
                                        continue;
                                    }
                                    let _e669 = (*pos_16);
                                    let _e670 = x_3;
                                    let _e671 = y_1;
                                    let _e672 = z_3;
                                    nPos_11 = (_e669 + vec3<i32>(_e670, _e671, _e672));
                                    let _e676 = nPos_11[0u];
                                    let _e677 = (_e676 >= 0i);
                                    phi_2954_ = _e677;
                                    if _e677 {
                                        let _e679 = nPos_11[0u];
                                        let _e681 = tuning.gridWidth;
                                        phi_2954_ = (_e679 < bitcast<i32>(_e681));
                                    }
                                    let _e685 = phi_2954_;
                                    phi_2960_ = _e685;
                                    if _e685 {
                                        let _e687 = nPos_11[1u];
                                        phi_2960_ = (_e687 >= 0i);
                                    }
                                    let _e690 = phi_2960_;
                                    phi_2969_ = _e690;
                                    if _e690 {
                                        let _e692 = nPos_11[1u];
                                        let _e694 = tuning.gridHeight;
                                        phi_2969_ = (_e692 < bitcast<i32>(_e694));
                                    }
                                    let _e698 = phi_2969_;
                                    phi_2975_ = _e698;
                                    if _e698 {
                                        let _e700 = nPos_11[2u];
                                        phi_2975_ = (_e700 >= 0i);
                                    }
                                    let _e703 = phi_2975_;
                                    phi_2984_ = _e703;
                                    if _e703 {
                                        let _e705 = nPos_11[2u];
                                        let _e707 = tuning.gridDepth;
                                        phi_2984_ = (_e705 < bitcast<i32>(_e707));
                                    }
                                    let _e711 = phi_2984_;
                                    if _e711 {
                                        let _e712 = nPos_11;
                                        param_724 = _e712;
                                        let _e713 = getIndex_u0028_vi3_u003b((&param_724));
                                        param_725 = _e713;
                                        let _e714 = readCell_u0028_u1_u003b((&param_725));
                                        param_726 = _e714;
                                        let _e715 = getType_u0028_u1_u003b((&param_726));
                                        if (_e715 == 1u) {
                                            let _e717 = clumpCount_1;
                                            clumpCount_1 = (_e717 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e719 = z_3;
                                    z_3 = (_e719 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e721 = y_1;
                            y_1 = (_e721 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e723 = x_3;
                    x_3 = (_e723 + 1i);
                }
            }
            let _e725 = clumpCount_1;
            let _e727 = tuning.sandClumpThreshold;
            if (_e725 >= bitcast<i32>(_e727)) {
                isClumped_1 = true;
            }
        }
    }
    let _e730 = canMove_1;
    let _e731 = isClumped_1;
    if (_e730 && !(_e731)) {
        let _e735 = (*pos_16)[1u];
        if (_e735 > 1i) {
            let _e737 = (*pos_16);
            belowPos_8 = (_e737 + vec3<i32>(0i, -1i, 0i));
            let _e739 = belowPos_8;
            param_727 = _e739;
            let _e740 = getIndex_u0028_vi3_u003b((&param_727));
            param_728 = _e740;
            let _e741 = readCell_u0028_u1_u003b((&param_728));
            param_729 = _e741;
            let _e742 = getType_u0028_u1_u003b((&param_729));
            if (_e742 == 0u) {
                let _e744 = belowPos_8;
                param_730 = _e744;
                let _e745 = getIndex_u0028_vi3_u003b((&param_730));
                param_731 = 1u;
                param_732 = 0u;
                param_733 = 0u;
                let _e746 = moisture_5;
                param_734 = _e746;
                let _e747 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_731), (&param_732), (&param_733), (&param_734));
                let _e748 = (*currentIndex_11);
                param_735 = _e748;
                let _e749 = (*rawValue_9);
                param_736 = _e749;
                param_737 = _e745;
                param_738 = _e747;
                let _e750 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_735), (&param_736), (&param_737), (&param_738));
                if _e750 {
                    return;
                }
            }
        }
        let _e752 = (*pos_16)[1u];
        if (_e752 > 1i) {
            let _e754 = (*randVal_11);
            dir_4 = select(-1i, 1i, (fract((_e754 * 10f)) > 0.5f));
            let _e759 = (*randVal_11);
            if (fract((_e759 * 100f)) > 0.5f) {
                let _e763 = (*pos_16);
                let _e764 = dir_4;
                slidePos1_1 = (_e763 + vec3<i32>(_e764, -1i, 0i));
                let _e767 = (*pos_16);
                let _e768 = dir_4;
                slidePos2_1 = (_e767 + vec3<i32>(0i, -1i, _e768));
            } else {
                let _e771 = (*pos_16);
                let _e772 = dir_4;
                slidePos1_1 = (_e771 + vec3<i32>(0i, -1i, _e772));
                let _e775 = (*pos_16);
                let _e776 = dir_4;
                slidePos2_1 = (_e775 + vec3<i32>(_e776, -1i, 0i));
            }
            let _e780 = slidePos1_1[0u];
            let _e781 = (_e780 > 0i);
            phi_3106_ = _e781;
            if _e781 {
                let _e783 = slidePos1_1[0u];
                let _e785 = tuning.gridWidth;
                phi_3106_ = (_e783 < (bitcast<i32>(_e785) - 1i));
            }
            let _e790 = phi_3106_;
            phi_3112_ = _e790;
            if _e790 {
                let _e792 = slidePos1_1[2u];
                phi_3112_ = (_e792 > 0i);
            }
            let _e795 = phi_3112_;
            phi_3122_ = _e795;
            if _e795 {
                let _e797 = slidePos1_1[2u];
                let _e799 = tuning.gridDepth;
                phi_3122_ = (_e797 < (bitcast<i32>(_e799) - 1i));
            }
            let _e804 = phi_3122_;
            if _e804 {
                let _e805 = slidePos1_1;
                param_739 = _e805;
                let _e806 = getIndex_u0028_vi3_u003b((&param_739));
                param_740 = _e806;
                let _e807 = readCell_u0028_u1_u003b((&param_740));
                param_741 = _e807;
                let _e808 = getType_u0028_u1_u003b((&param_741));
                if (_e808 == 0u) {
                    let _e810 = slidePos1_1;
                    param_742 = _e810;
                    let _e811 = getIndex_u0028_vi3_u003b((&param_742));
                    param_743 = 1u;
                    param_744 = 0u;
                    param_745 = 0u;
                    let _e812 = moisture_5;
                    param_746 = _e812;
                    let _e813 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_743), (&param_744), (&param_745), (&param_746));
                    let _e814 = (*currentIndex_11);
                    param_747 = _e814;
                    let _e815 = (*rawValue_9);
                    param_748 = _e815;
                    param_749 = _e811;
                    param_750 = _e813;
                    let _e816 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_747), (&param_748), (&param_749), (&param_750));
                    if _e816 {
                        return;
                    }
                }
            }
            let _e818 = slidePos2_1[0u];
            let _e819 = (_e818 > 0i);
            phi_3166_ = _e819;
            if _e819 {
                let _e821 = slidePos2_1[0u];
                let _e823 = tuning.gridWidth;
                phi_3166_ = (_e821 < (bitcast<i32>(_e823) - 1i));
            }
            let _e828 = phi_3166_;
            phi_3172_ = _e828;
            if _e828 {
                let _e830 = slidePos2_1[2u];
                phi_3172_ = (_e830 > 0i);
            }
            let _e833 = phi_3172_;
            phi_3182_ = _e833;
            if _e833 {
                let _e835 = slidePos2_1[2u];
                let _e837 = tuning.gridDepth;
                phi_3182_ = (_e835 < (bitcast<i32>(_e837) - 1i));
            }
            let _e842 = phi_3182_;
            if _e842 {
                let _e843 = slidePos2_1;
                param_751 = _e843;
                let _e844 = getIndex_u0028_vi3_u003b((&param_751));
                param_752 = _e844;
                let _e845 = readCell_u0028_u1_u003b((&param_752));
                param_753 = _e845;
                let _e846 = getType_u0028_u1_u003b((&param_753));
                if (_e846 == 0u) {
                    let _e848 = slidePos2_1;
                    param_754 = _e848;
                    let _e849 = getIndex_u0028_vi3_u003b((&param_754));
                    param_755 = 1u;
                    param_756 = 0u;
                    param_757 = 0u;
                    let _e850 = moisture_5;
                    param_758 = _e850;
                    let _e851 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_755), (&param_756), (&param_757), (&param_758));
                    let _e852 = (*currentIndex_11);
                    param_759 = _e852;
                    let _e853 = (*rawValue_9);
                    param_760 = _e853;
                    param_761 = _e849;
                    param_762 = _e851;
                    let _e854 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_759), (&param_760), (&param_761), (&param_762));
                    if _e854 {
                        return;
                    }
                }
            }
        }
        let _e856 = (*pos_16)[1u];
        if (_e856 > 1i) {
            let _e858 = (*pos_16);
            belowPos_9 = (_e858 + vec3<i32>(0i, -1i, 0i));
            let _e860 = belowPos_9;
            param_763 = _e860;
            let _e861 = getIndex_u0028_vi3_u003b((&param_763));
            belowIndex_3 = _e861;
            let _e862 = belowIndex_3;
            param_764 = _e862;
            let _e863 = readCell_u0028_u1_u003b((&param_764));
            belowValue_3 = _e863;
            let _e864 = belowValue_3;
            param_765 = _e864;
            let _e865 = getType_u0028_u1_u003b((&param_765));
            if (_e865 == 2u) {
                let _e867 = (*randVal_11);
                startDir_6 = i32((fract((_e867 * 8f)) * 8f));
                i_23 = 0i;
                loop {
                    let _e872 = i_23;
                    if (_e872 < 8i) {
                        let _e874 = startDir_6;
                        let _e875 = i_23;
                        let _e876 = (_e874 + _e875);
                        d_21 = (_e876 - (i32(floor((f32(_e876) / f32(8i)))) * 8i));
                        let _e884 = belowPos_9;
                        let _e885 = d_21;
                        param_766 = _e885;
                        let _e886 = getHDir_u0028_i1_u003b((&param_766));
                        pushPos_2 = (_e884 + _e886);
                        let _e889 = pushPos_2[0u];
                        let _e890 = (_e889 > 0i);
                        phi_3274_ = _e890;
                        if _e890 {
                            let _e892 = pushPos_2[0u];
                            let _e894 = tuning.gridWidth;
                            phi_3274_ = (_e892 < (bitcast<i32>(_e894) - 1i));
                        }
                        let _e899 = phi_3274_;
                        phi_3280_ = _e899;
                        if _e899 {
                            let _e901 = pushPos_2[2u];
                            phi_3280_ = (_e901 > 0i);
                        }
                        let _e904 = phi_3280_;
                        phi_3290_ = _e904;
                        if _e904 {
                            let _e906 = pushPos_2[2u];
                            let _e908 = tuning.gridDepth;
                            phi_3290_ = (_e906 < (bitcast<i32>(_e908) - 1i));
                        }
                        let _e913 = phi_3290_;
                        if _e913 {
                            param_767 = 1u;
                            param_768 = 0u;
                            param_769 = 0u;
                            let _e914 = moisture_5;
                            param_770 = _e914;
                            let _e915 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_767), (&param_768), (&param_769), (&param_770));
                            let _e916 = pushPos_2;
                            param_771 = _e916;
                            let _e917 = getIndex_u0028_vi3_u003b((&param_771));
                            let _e918 = (*currentIndex_11);
                            param_772 = _e918;
                            param_773 = _e915;
                            let _e919 = belowIndex_3;
                            param_774 = _e919;
                            let _e920 = belowValue_3;
                            param_775 = _e920;
                            param_776 = _e917;
                            let _e921 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_772), (&param_773), (&param_774), (&param_775), (&param_776));
                            if _e921 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e922 = i_23;
                        i_23 = (_e922 + 1i);
                    }
                }
                param_777 = 1u;
                param_778 = 0u;
                param_779 = 0u;
                let _e924 = moisture_5;
                param_780 = _e924;
                let _e925 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_777), (&param_778), (&param_779), (&param_780));
                let _e926 = (*currentIndex_11);
                param_781 = _e926;
                let _e927 = (*rawValue_9);
                param_782 = _e927;
                let _e928 = belowIndex_3;
                param_783 = _e928;
                param_784 = _e925;
                let _e929 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_781), (&param_782), (&param_783), (&param_784));
                if _e929 {
                    return;
                }
            }
            let _e930 = (*randVal_11);
            dir_5 = select(-1i, 1i, (fract((_e930 * 10f)) > 0.5f));
            let _e935 = (*randVal_11);
            if (fract((_e935 * 100f)) > 0.5f) {
                let _e939 = (*pos_16);
                let _e940 = dir_5;
                slidePos_1[0i] = (_e939 + vec3<i32>(_e940, -1i, 0i));
                let _e944 = (*pos_16);
                let _e945 = dir_5;
                slidePos_1[1i] = (_e944 + vec3<i32>(0i, -1i, _e945));
            } else {
                let _e949 = (*pos_16);
                let _e950 = dir_5;
                slidePos_1[0i] = (_e949 + vec3<i32>(0i, -1i, _e950));
                let _e954 = (*pos_16);
                let _e955 = dir_5;
                slidePos_1[1i] = (_e954 + vec3<i32>(_e955, -1i, 0i));
            }
            s_2 = 0i;
            loop {
                let _e959 = s_2;
                if (_e959 < 2i) {
                    let _e961 = s_2;
                    let _e963 = slidePos_1[_e961];
                    sPos_3 = _e963;
                    let _e965 = sPos_3[0u];
                    let _e966 = (_e965 > 0i);
                    phi_3393_ = _e966;
                    if _e966 {
                        let _e968 = sPos_3[0u];
                        let _e970 = tuning.gridWidth;
                        phi_3393_ = (_e968 < (bitcast<i32>(_e970) - 1i));
                    }
                    let _e975 = phi_3393_;
                    phi_3399_ = _e975;
                    if _e975 {
                        let _e977 = sPos_3[2u];
                        phi_3399_ = (_e977 > 0i);
                    }
                    let _e980 = phi_3399_;
                    phi_3409_ = _e980;
                    if _e980 {
                        let _e982 = sPos_3[2u];
                        let _e984 = tuning.gridDepth;
                        phi_3409_ = (_e982 < (bitcast<i32>(_e984) - 1i));
                    }
                    let _e989 = phi_3409_;
                    if _e989 {
                        let _e990 = sPos_3;
                        param_785 = _e990;
                        let _e991 = getIndex_u0028_vi3_u003b((&param_785));
                        sIndex_1 = _e991;
                        let _e992 = sIndex_1;
                        param_786 = _e992;
                        let _e993 = readCell_u0028_u1_u003b((&param_786));
                        sValue_1 = _e993;
                        let _e994 = sValue_1;
                        param_787 = _e994;
                        let _e995 = getType_u0028_u1_u003b((&param_787));
                        if (_e995 == 2u) {
                            let _e997 = (*randVal_11);
                            let _e999 = s_2;
                            startDir_7 = i32((fract(((_e997 * 8f) + f32(_e999))) * 8f));
                            i_24 = 0i;
                            loop {
                                let _e1005 = i_24;
                                if (_e1005 < 8i) {
                                    let _e1007 = startDir_7;
                                    let _e1008 = i_24;
                                    let _e1009 = (_e1007 + _e1008);
                                    d_22 = (_e1009 - (i32(floor((f32(_e1009) / f32(8i)))) * 8i));
                                    let _e1017 = sPos_3;
                                    let _e1018 = d_22;
                                    param_788 = _e1018;
                                    let _e1019 = getHDir_u0028_i1_u003b((&param_788));
                                    pushPos_3 = (_e1017 + _e1019);
                                    let _e1022 = pushPos_3[0u];
                                    let _e1023 = (_e1022 > 0i);
                                    phi_3466_ = _e1023;
                                    if _e1023 {
                                        let _e1025 = pushPos_3[0u];
                                        let _e1027 = tuning.gridWidth;
                                        phi_3466_ = (_e1025 < (bitcast<i32>(_e1027) - 1i));
                                    }
                                    let _e1032 = phi_3466_;
                                    phi_3472_ = _e1032;
                                    if _e1032 {
                                        let _e1034 = pushPos_3[2u];
                                        phi_3472_ = (_e1034 > 0i);
                                    }
                                    let _e1037 = phi_3472_;
                                    phi_3482_ = _e1037;
                                    if _e1037 {
                                        let _e1039 = pushPos_3[2u];
                                        let _e1041 = tuning.gridDepth;
                                        phi_3482_ = (_e1039 < (bitcast<i32>(_e1041) - 1i));
                                    }
                                    let _e1046 = phi_3482_;
                                    if _e1046 {
                                        param_789 = 1u;
                                        param_790 = 0u;
                                        param_791 = 0u;
                                        let _e1047 = moisture_5;
                                        param_792 = _e1047;
                                        let _e1048 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_789), (&param_790), (&param_791), (&param_792));
                                        let _e1049 = pushPos_3;
                                        param_793 = _e1049;
                                        let _e1050 = getIndex_u0028_vi3_u003b((&param_793));
                                        let _e1051 = (*currentIndex_11);
                                        param_794 = _e1051;
                                        param_795 = _e1048;
                                        let _e1052 = sIndex_1;
                                        param_796 = _e1052;
                                        let _e1053 = sValue_1;
                                        param_797 = _e1053;
                                        param_798 = _e1050;
                                        let _e1054 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_794), (&param_795), (&param_796), (&param_797), (&param_798));
                                        if _e1054 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1055 = i_24;
                                    i_24 = (_e1055 + 1i);
                                }
                            }
                            param_799 = 1u;
                            param_800 = 0u;
                            param_801 = 0u;
                            let _e1057 = moisture_5;
                            param_802 = _e1057;
                            let _e1058 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_799), (&param_800), (&param_801), (&param_802));
                            let _e1059 = (*currentIndex_11);
                            param_803 = _e1059;
                            let _e1060 = (*rawValue_9);
                            param_804 = _e1060;
                            let _e1061 = sIndex_1;
                            param_805 = _e1061;
                            param_806 = _e1058;
                            let _e1062 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_803), (&param_804), (&param_805), (&param_806));
                            if _e1062 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1063 = s_2;
                    s_2 = (_e1063 + 1i);
                }
            }
        }
    }
    let _e1065 = (*currentSleep_6);
    newSleep_4 = min((_e1065 + 1u), 255u);
    let _e1068 = (*currentIndex_11);
    let _e1071 = (*rawValue_9);
    param_807 = 1u;
    param_808 = 0u;
    let _e1072 = newSleep_4;
    param_809 = _e1072;
    let _e1073 = moisture_5;
    param_810 = _e1073;
    let _e1074 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_807), (&param_808), (&param_809), (&param_810));
    let _e1075 = atomicCompareExchangeWeak((&unnamed.grid[_e1068]), _e1071, _e1074);
    return;
}

fn orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b(pos_17: ptr<function, vec3<i32>>, currentIndex_12: ptr<function, u32>, rawValue_10: ptr<function, u32>, stepDir: ptr<function, vec3<i32>>) -> bool {
    var target_3: vec3<i32>;
    var targetIndex_3: u32;
    var param_811: vec3<i32>;
    var param_812: u32;
    var param_813: u32;
    var param_814: u32;
    var param_815: u32;
    var param_816: u32;
    var param_817: u32;
    var param_818: u32;
    var param_819: u32;
    var param_820: u32;
    var param_821: u32;
    var param_822: u32;
    var param_823: u32;
    var param_824: u32;
    var phi_1873_: bool;
    var phi_1880_: bool;
    var phi_1891_: bool;
    var phi_1898_: bool;
    var phi_1909_: bool;

    let _e224 = (*stepDir);
    if all((_e224 == vec3<i32>(0i, 0i, 0i))) {
        return false;
    }
    let _e227 = (*pos_17);
    let _e228 = (*stepDir);
    target_3 = (_e227 + _e228);
    let _e231 = target_3[0u];
    let _e232 = (_e231 < 1i);
    phi_1873_ = _e232;
    if !(_e232) {
        let _e235 = target_3[0u];
        let _e237 = tuning.gridWidth;
        phi_1873_ = (_e235 >= (bitcast<i32>(_e237) - 1i));
    }
    let _e242 = phi_1873_;
    phi_1880_ = _e242;
    if !(_e242) {
        let _e245 = target_3[1u];
        phi_1880_ = (_e245 < 1i);
    }
    let _e248 = phi_1880_;
    phi_1891_ = _e248;
    if !(_e248) {
        let _e251 = target_3[1u];
        let _e253 = tuning.gridHeight;
        phi_1891_ = (_e251 >= (bitcast<i32>(_e253) - 1i));
    }
    let _e258 = phi_1891_;
    phi_1898_ = _e258;
    if !(_e258) {
        let _e261 = target_3[2u];
        phi_1898_ = (_e261 < 1i);
    }
    let _e264 = phi_1898_;
    phi_1909_ = _e264;
    if !(_e264) {
        let _e267 = target_3[2u];
        let _e269 = tuning.gridDepth;
        phi_1909_ = (_e267 >= (bitcast<i32>(_e269) - 1i));
    }
    let _e274 = phi_1909_;
    if _e274 {
        return false;
    }
    let _e275 = target_3;
    param_811 = _e275;
    let _e276 = getIndex_u0028_vi3_u003b((&param_811));
    targetIndex_3 = _e276;
    let _e277 = targetIndex_3;
    param_812 = _e277;
    let _e278 = readCell_u0028_u1_u003b((&param_812));
    param_813 = _e278;
    let _e279 = getType_u0028_u1_u003b((&param_813));
    if (_e279 != 0u) {
        return false;
    }
    let _e281 = (*rawValue_10);
    param_814 = _e281;
    let _e282 = getType_u0028_u1_u003b((&param_814));
    let _e283 = (*rawValue_10);
    param_815 = _e283;
    let _e284 = getDir_u0028_u1_u003b((&param_815));
    let _e285 = (*rawValue_10);
    param_816 = _e285;
    let _e286 = getAge_u0028_u1_u003b((&param_816));
    param_817 = _e282;
    param_818 = _e284;
    param_819 = 0u;
    param_820 = _e286;
    let _e287 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_817), (&param_818), (&param_819), (&param_820));
    let _e288 = (*currentIndex_12);
    param_821 = _e288;
    let _e289 = (*rawValue_10);
    param_822 = _e289;
    let _e290 = targetIndex_3;
    param_823 = _e290;
    param_824 = _e287;
    let _e291 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_821), (&param_822), (&param_823), (&param_824));
    return _e291;
}

fn dominantAxis_u0028_vf3_u003b_f1_u003b(dir_6: ptr<function, vec3<f32>>, relative: ptr<function, f32>) -> vec3<i32> {
    var a_1: vec3<f32>;
    var m: f32;

    let _e208 = (*dir_6);
    a_1 = abs(_e208);
    let _e211 = a_1[0u];
    let _e213 = a_1[1u];
    let _e215 = a_1[2u];
    m = max(_e211, max(_e213, _e215));
    let _e218 = m;
    if (_e218 <= 0f) {
        return vec3<i32>(0i, 0i, 0i);
    }
    let _e220 = a_1;
    let _e221 = m;
    let _e222 = (*relative);
    let _e227 = (*dir_6);
    return (select(vec3<i32>(0i, 0i, 0i), vec3<i32>(1i, 1i, 1i), (_e220 >= vec3((_e221 * _e222)))) * vec3<i32>(sign(_e227)));
}

fn bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b(k_1: ptr<function, i32>, planeCount: ptr<function, i32>, seed: ptr<function, f32>) -> vec3<f32> {
    var z_4: f32;
    var r_4: f32;
    var a_2: f32;

    let _e210 = (*k_1);
    let _e213 = (*planeCount);
    z_4 = ((f32(_e210) + 0.5f) / f32(_e213));
    let _e216 = z_4;
    let _e217 = z_4;
    r_4 = sqrt(max(0f, (1f - (_e216 * _e217))));
    let _e222 = (*k_1);
    let _e225 = (*seed);
    a_2 = ((2.399963f * f32(_e222)) + _e225);
    let _e227 = r_4;
    let _e228 = a_2;
    let _e231 = z_4;
    let _e232 = r_4;
    let _e233 = a_2;
    return vec3<f32>((_e227 * cos(_e228)), _e231, (_e232 * sin(_e233)));
}

fn bhOrbitAxis_u0028_vi3_u003b_vi3_u003b(center: ptr<function, vec3<i32>>, pos_18: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radial: vec3<f32>;
    var planeCount_1: i32;
    var seed_1: f32;
    var param_825: vec3<f32>;
    var best: vec3<f32>;
    var bestAlign: f32;
    var bestK: i32;
    var k_2: i32;
    var n_2: vec3<f32>;
    var param_826: i32;
    var param_827: i32;
    var param_828: f32;
    var align: f32;
    var sense: f32;
    var param_829: vec3<f32>;

    let _e221 = (*pos_18);
    let _e222 = (*center);
    radial = normalize(vec3<f32>((_e221 - _e222)));
    let _e227 = tuning.blackHoleOrbitPlanes;
    planeCount_1 = bitcast<i32>(clamp(_e227, 1u, 32u));
    let _e230 = (*center);
    param_825 = (vec3<f32>(_e230) + vec3<f32>(29f, 3f, 71f));
    let _e233 = hash_u0028_vf3_u003b((&param_825));
    seed_1 = (_e233 * 6.28318f);
    best = vec3<f32>(0f, 1f, 0f);
    bestAlign = 2f;
    bestK = 0i;
    k_2 = 0i;
    loop {
        let _e235 = k_2;
        let _e236 = planeCount_1;
        if (_e235 < _e236) {
            let _e238 = k_2;
            param_826 = _e238;
            let _e239 = planeCount_1;
            param_827 = _e239;
            let _e240 = seed_1;
            param_828 = _e240;
            let _e241 = bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b((&param_826), (&param_827), (&param_828));
            n_2 = _e241;
            let _e242 = n_2;
            let _e243 = radial;
            align = abs(dot(_e242, _e243));
            let _e246 = align;
            let _e247 = bestAlign;
            if (_e246 < _e247) {
                let _e249 = align;
                bestAlign = _e249;
                let _e250 = n_2;
                best = _e250;
                let _e251 = k_2;
                bestK = _e251;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e252 = k_2;
            k_2 = (_e252 + 1i);
        }
    }
    let _e254 = (*center);
    let _e256 = bestK;
    param_829 = (vec3<f32>(_e254) + vec3<f32>((f32(_e256) * 13f), 101f, 47f));
    let _e261 = hash_u0028_vf3_u003b((&param_829));
    sense = select(1f, -1f, (_e261 < 0.5f));
    let _e264 = best;
    let _e265 = sense;
    return (_e264 * _e265);
}

fn bhIsPurge_u0028_u1_u003b(code: ptr<function, u32>) -> bool {
    let _e205 = (*code);
    return ((_e205 & 1073741824u) != 0u);
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e205 = (*level);
    return (f32(_e205) + 0.5f);
}

fn updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b(pos_19: ptr<function, vec3<i32>>, currentIndex_13: ptr<function, u32>, rawValue_11: ptr<function, u32>, center_1: ptr<function, vec3<i32>>, slot: ptr<function, i32>, level_1: ptr<function, u32>, purge: ptr<function, bool>, dist_1: ptr<function, f32>, randVal_12: ptr<function, f32>) {
    var type_37: u32;
    var param_830: u32;
    var sleep_1: u32;
    var param_831: u32;
    var param_832: u32;
    var param_833: u32;
    var orbitSpeed: f32;
    var local_27: f32;
    var infallChance: f32;
    var local_28: f32;
    var param_834: u32;
    var param_835: u32;
    var param_836: u32;
    var param_837: u32;
    var param_838: u32;
    var param_839: u32;
    var inward: vec3<f32>;
    var axis: vec3<f32>;
    var param_840: vec3<i32>;
    var param_841: vec3<i32>;
    var tangent: vec3<f32>;
    var tangentLen: f32;
    var axial: f32;
    var grip: vec3<f32>;
    var along: vec3<f32>;
    var pullIn: bool;
    var spiral: vec3<f32>;
    var param_842: vec3<f32>;
    var param_843: f32;
    var param_844: vec3<i32>;
    var param_845: u32;
    var param_846: u32;
    var param_847: vec3<i32>;
    var param_848: vec3<f32>;
    var param_849: f32;
    var param_850: vec3<i32>;
    var param_851: u32;
    var param_852: u32;
    var param_853: vec3<i32>;
    var param_854: vec3<f32>;
    var param_855: f32;
    var param_856: vec3<i32>;
    var param_857: u32;
    var param_858: u32;
    var param_859: vec3<i32>;
    var param_860: vec3<f32>;
    var param_861: f32;
    var param_862: vec3<i32>;
    var param_863: u32;
    var param_864: u32;
    var param_865: vec3<i32>;
    var param_866: vec3<f32>;
    var param_867: f32;
    var param_868: vec3<i32>;
    var param_869: u32;
    var param_870: u32;
    var param_871: vec3<i32>;
    var param_872: vec3<f32>;
    var param_873: f32;
    var param_874: vec3<i32>;
    var param_875: u32;
    var param_876: u32;
    var param_877: vec3<i32>;
    var param_878: u32;
    var param_879: u32;
    var param_880: u32;
    var param_881: u32;
    var param_882: u32;
    var param_883: u32;
    var phi_2172_: bool;

    let _e282 = (*rawValue_11);
    param_830 = _e282;
    let _e283 = getType_u0028_u1_u003b((&param_830));
    type_37 = _e283;
    let _e284 = (*rawValue_11);
    param_831 = _e284;
    let _e285 = getSleep_u0028_u1_u003b((&param_831));
    sleep_1 = _e285;
    let _e286 = (*slot);
    unnamed_2.blackHoleStarve[_e286] = 0u;
    let _e289 = (*dist_1);
    let _e290 = (*level_1);
    param_832 = _e290;
    let _e291 = bhBodyRadius_u0028_u1_u003b((&param_832));
    let _e293 = tuning.blackHoleHorizon;
    if (_e289 <= (_e291 + f32(_e293))) {
        let _e297 = (*currentIndex_13);
        let _e300 = (*rawValue_11);
        let _e301 = atomicCompareExchangeWeak((&unnamed.grid[_e297]), _e300, 0u);
        let _e303 = (*rawValue_11);
        if (_e301.old_value == _e303) {
            let _e305 = (*slot);
            let _e308 = atomicLoad((&unnamed_2.blackHoles[_e305]));
            param_833 = _e308;
            let _e309 = bhIsPurge_u0028_u1_u003b((&param_833));
            if !(_e309) {
                let _e311 = (*slot);
                let _e314 = atomicAdd((&unnamed_2.blackHoleMass[_e311]), 1u);
            }
            let _e315 = type_37;
            if (_e315 == 2u) {
                decWater_u0028_();
            }
        }
        return;
    }
    let _e317 = (*purge);
    if _e317 {
        let _e319 = tuning.purgeOrbitSpeed;
        local_27 = _e319;
    } else {
        let _e321 = tuning.blackHoleOrbitSpeed;
        local_27 = _e321;
    }
    let _e322 = local_27;
    orbitSpeed = _e322;
    let _e323 = (*purge);
    if _e323 {
        let _e325 = tuning.purgeInfall;
        local_28 = _e325;
    } else {
        let _e327 = tuning.blackHoleInfall;
        local_28 = _e327;
    }
    let _e328 = local_28;
    infallChance = _e328;
    let _e329 = (*randVal_12);
    let _e330 = orbitSpeed;
    let _e331 = (*dist_1);
    if (_e329 > clamp((_e330 / sqrt(max(_e331, 1f))), 0f, 1f)) {
        let _e337 = sleep_1;
        if (_e337 != 0u) {
            let _e339 = (*currentIndex_13);
            let _e342 = (*rawValue_11);
            let _e343 = (*rawValue_11);
            param_834 = _e343;
            let _e344 = getDir_u0028_u1_u003b((&param_834));
            let _e345 = (*rawValue_11);
            param_835 = _e345;
            let _e346 = getAge_u0028_u1_u003b((&param_835));
            let _e347 = type_37;
            param_836 = _e347;
            param_837 = _e344;
            param_838 = 0u;
            param_839 = _e346;
            let _e348 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_836), (&param_837), (&param_838), (&param_839));
            let _e349 = atomicCompareExchangeWeak((&unnamed.grid[_e339]), _e342, _e348);
        }
        return;
    }
    let _e351 = (*center_1);
    let _e352 = (*pos_19);
    inward = normalize(vec3<f32>((_e351 - _e352)));
    let _e356 = (*center_1);
    param_840 = _e356;
    let _e357 = (*pos_19);
    param_841 = _e357;
    let _e358 = bhOrbitAxis_u0028_vi3_u003b_vi3_u003b((&param_840), (&param_841));
    axis = _e358;
    let _e359 = axis;
    let _e360 = inward;
    tangent = cross(_e359, _e360);
    let _e362 = tangent;
    tangentLen = length(_e362);
    let _e364 = tangentLen;
    if (_e364 < 0.05f) {
        let _e366 = axis;
        tangent = normalize(cross(_e366, vec3<f32>(0.577f, 0.577f, 0.577f)));
    } else {
        let _e369 = tangentLen;
        let _e370 = tangent;
        tangent = (_e370 / vec3(_e369));
    }
    let _e373 = (*pos_19);
    let _e374 = (*center_1);
    let _e377 = axis;
    axial = dot(vec3<f32>((_e373 - _e374)), _e377);
    let _e379 = axis;
    let _e381 = axial;
    let _e386 = tuning.blackHolePlaneGrip;
    grip = ((-(_e379) * clamp((_e381 * 0.5f), -1f, 1f)) * _e386);
    let _e388 = tangent;
    let _e389 = grip;
    along = normalize((_e388 + _e389));
    let _e392 = (*randVal_12);
    let _e395 = infallChance;
    pullIn = (fract((_e392 * 61f)) < clamp(_e395, 0f, 1f));
    let _e398 = inward;
    let _e399 = tangent;
    spiral = normalize((_e398 + (_e399 * 0.6f)));
    let _e403 = pullIn;
    phi_2172_ = _e403;
    if _e403 {
        let _e404 = spiral;
        param_842 = _e404;
        param_843 = 0.55f;
        let _e405 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_842), (&param_843));
        let _e406 = (*pos_19);
        param_844 = _e406;
        let _e407 = (*currentIndex_13);
        param_845 = _e407;
        let _e408 = (*rawValue_11);
        param_846 = _e408;
        param_847 = _e405;
        let _e409 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_844), (&param_845), (&param_846), (&param_847));
        phi_2172_ = _e409;
    }
    let _e411 = phi_2172_;
    if _e411 {
        return;
    }
    let _e412 = along;
    param_848 = _e412;
    param_849 = 0.55f;
    let _e413 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_848), (&param_849));
    let _e414 = (*pos_19);
    param_850 = _e414;
    let _e415 = (*currentIndex_13);
    param_851 = _e415;
    let _e416 = (*rawValue_11);
    param_852 = _e416;
    param_853 = _e413;
    let _e417 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_850), (&param_851), (&param_852), (&param_853));
    if _e417 {
        return;
    }
    let _e418 = along;
    param_854 = _e418;
    param_855 = 1f;
    let _e419 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_854), (&param_855));
    let _e420 = (*pos_19);
    param_856 = _e420;
    let _e421 = (*currentIndex_13);
    param_857 = _e421;
    let _e422 = (*rawValue_11);
    param_858 = _e422;
    param_859 = _e419;
    let _e423 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_856), (&param_857), (&param_858), (&param_859));
    if _e423 {
        return;
    }
    let _e424 = tangent;
    param_860 = _e424;
    param_861 = 1f;
    let _e425 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_860), (&param_861));
    let _e426 = (*pos_19);
    param_862 = _e426;
    let _e427 = (*currentIndex_13);
    param_863 = _e427;
    let _e428 = (*rawValue_11);
    param_864 = _e428;
    param_865 = _e425;
    let _e429 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_862), (&param_863), (&param_864), (&param_865));
    if _e429 {
        return;
    }
    let _e430 = inward;
    param_866 = _e430;
    param_867 = 0.55f;
    let _e431 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_866), (&param_867));
    let _e432 = (*pos_19);
    param_868 = _e432;
    let _e433 = (*currentIndex_13);
    param_869 = _e433;
    let _e434 = (*rawValue_11);
    param_870 = _e434;
    param_871 = _e431;
    let _e435 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_868), (&param_869), (&param_870), (&param_871));
    if _e435 {
        return;
    }
    let _e436 = inward;
    param_872 = _e436;
    param_873 = 1f;
    let _e437 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_872), (&param_873));
    let _e438 = (*pos_19);
    param_874 = _e438;
    let _e439 = (*currentIndex_13);
    param_875 = _e439;
    let _e440 = (*rawValue_11);
    param_876 = _e440;
    param_877 = _e437;
    let _e441 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_874), (&param_875), (&param_876), (&param_877));
    if _e441 {
        return;
    }
    let _e442 = sleep_1;
    if (_e442 != 0u) {
        let _e444 = (*currentIndex_13);
        let _e447 = (*rawValue_11);
        let _e448 = (*rawValue_11);
        param_878 = _e448;
        let _e449 = getDir_u0028_u1_u003b((&param_878));
        let _e450 = (*rawValue_11);
        param_879 = _e450;
        let _e451 = getAge_u0028_u1_u003b((&param_879));
        let _e452 = type_37;
        param_880 = _e452;
        param_881 = _e449;
        param_882 = 0u;
        param_883 = _e451;
        let _e453 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_880), (&param_881), (&param_882), (&param_883));
        let _e454 = atomicCompareExchangeWeak((&unnamed.grid[_e444]), _e447, _e453);
    }
    return;
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_2: u32;
    var l: u32;
    var r_5: f32;
    var param_884: u32;
    var volume: f32;

    level_2 = 0u;
    l = 1u;
    loop {
        let _e210 = l;
        let _e212 = tuning.blackHoleMaxLevel;
        if (_e210 <= min(_e212, 16u)) {
            let _e215 = l;
            param_884 = _e215;
            let _e216 = bhBodyRadius_u0028_u1_u003b((&param_884));
            r_5 = _e216;
            let _e217 = r_5;
            let _e219 = r_5;
            let _e221 = r_5;
            volume = (((4.18879f * _e217) * _e219) * _e221);
            let _e223 = (*mass);
            let _e226 = tuning.blackHoleGrowthCost;
            let _e227 = volume;
            if (f32(_e223) < (_e226 * _e227)) {
                break;
            }
            let _e230 = l;
            level_2 = _e230;
            continue;
        } else {
            break;
        }
        continuing {
            let _e231 = l;
            l = (_e231 + bitcast<u32>(1i));
        }
    }
    let _e234 = level_2;
    return _e234;
}

fn bhLevelFor_u0028_u1_u003b_u1_u003b(code_1: ptr<function, u32>, mass_1: ptr<function, u32>) -> u32 {
    var param_885: u32;
    var param_886: u32;

    let _e208 = (*code_1);
    param_885 = _e208;
    let _e209 = bhIsPurge_u0028_u1_u003b((&param_885));
    if _e209 {
        let _e211 = tuning.purgeLevel;
        let _e213 = (*mass_1);
        let _e216 = tuning.purgeMass;
        return u32((f32(_e211) * clamp((f32(_e213) / f32(max(_e216, 1u))), 0f, 1f)));
    }
    let _e223 = (*mass_1);
    param_886 = _e223;
    let _e224 = bhLevel_u0028_u1_u003b((&param_886));
    return _e224;
}

fn bhDecode_u0028_u1_u003b(code_2: ptr<function, u32>) -> vec3<i32> {
    var i_25: u32;

    let _e206 = (*code_2);
    i_25 = (_e206 & 1073741823u);
    let _e208 = i_25;
    let _e210 = tuning.gridWidth;
    let _e215 = i_25;
    let _e217 = tuning.gridWidth;
    let _e222 = tuning.gridHeight;
    let _e227 = i_25;
    let _e229 = tuning.gridWidth;
    let _e232 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e208 % bitcast<u32>(bitcast<i32>(_e210)))), bitcast<i32>(((_e215 / bitcast<u32>(bitcast<i32>(_e217))) % bitcast<u32>(bitcast<i32>(_e222)))), bitcast<i32>((_e227 / bitcast<u32>((bitcast<i32>(_e229) * bitcast<i32>(_e232))))));
}

fn captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b(pos_20: ptr<function, vec3<i32>>, currentIndex_14: ptr<function, u32>, rawValue_12: ptr<function, u32>, randVal_13: ptr<function, f32>) -> bool {
    var bestDistSq: f32;
    var bestCenter: vec3<i32>;
    var bestSlot: i32;
    var bestLevel: u32;
    var bestPurge: bool;
    var maxRadius: f32;
    var maxRadiusSq: f32;
    var i_26: i32;
    var code_3: u32;
    var center_2: vec3<i32>;
    var param_887: u32;
    var d_23: vec3<f32>;
    var distSq: f32;
    var purge_1: bool;
    var param_888: u32;
    var level_3: u32;
    var param_889: u32;
    var param_890: u32;
    var radius: f32;
    var local_29: f32;
    var param_891: vec3<i32>;
    var param_892: u32;
    var param_893: u32;
    var param_894: vec3<i32>;
    var param_895: i32;
    var param_896: u32;
    var param_897: bool;
    var param_898: f32;
    var param_899: f32;

    let _e238 = unnamed_2.blackHoleCount;
    if (_e238 == 0u) {
        return false;
    }
    bestDistSq = 3000000000f;
    bestCenter = vec3<i32>(0i, 0i, 0i);
    bestSlot = -1i;
    bestLevel = 0u;
    bestPurge = false;
    let _e241 = tuning.blackHoleRadius;
    let _e243 = tuning.blackHoleMaxLevel;
    maxRadius = f32((_e241 + min(_e243, 16u)));
    let _e247 = maxRadius;
    let _e248 = maxRadius;
    maxRadiusSq = (_e247 * _e248);
    i_26 = 0i;
    loop {
        let _e250 = i_26;
        if (_e250 < 8i) {
            let _e252 = i_26;
            let _e255 = atomicLoad((&unnamed_2.blackHoles[_e252]));
            code_3 = _e255;
            let _e256 = code_3;
            if (_e256 == 0u) {
                continue;
            }
            let _e258 = code_3;
            param_887 = _e258;
            let _e259 = bhDecode_u0028_u1_u003b((&param_887));
            center_2 = _e259;
            let _e260 = center_2;
            let _e261 = (*pos_20);
            d_23 = vec3<f32>((_e260 - _e261));
            let _e264 = d_23;
            let _e265 = d_23;
            distSq = dot(_e264, _e265);
            let _e267 = code_3;
            param_888 = _e267;
            let _e268 = bhIsPurge_u0028_u1_u003b((&param_888));
            purge_1 = _e268;
            let _e269 = purge_1;
            let _e271 = distSq;
            let _e272 = maxRadiusSq;
            if (!(_e269) && (_e271 > _e272)) {
                continue;
            }
            let _e275 = distSq;
            let _e276 = bestDistSq;
            if (_e275 >= _e276) {
                continue;
            }
            let _e278 = i_26;
            let _e279 = code_3;
            param_889 = _e279;
            let _e282 = atomicLoad((&unnamed_2.blackHoleMass[_e278]));
            param_890 = _e282;
            let _e283 = bhLevelFor_u0028_u1_u003b_u1_u003b((&param_889), (&param_890));
            level_3 = _e283;
            let _e284 = purge_1;
            if _e284 {
                local_29 = 1000000000f;
            } else {
                let _e286 = tuning.blackHoleRadius;
                let _e287 = level_3;
                local_29 = f32((_e286 + _e287));
            }
            let _e290 = local_29;
            radius = _e290;
            let _e291 = distSq;
            let _e292 = radius;
            let _e293 = radius;
            if (_e291 <= (_e292 * _e293)) {
                let _e296 = distSq;
                bestDistSq = _e296;
                let _e297 = center_2;
                bestCenter = _e297;
                let _e298 = i_26;
                bestSlot = _e298;
                let _e299 = level_3;
                bestLevel = _e299;
                let _e300 = purge_1;
                bestPurge = _e300;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e301 = i_26;
            i_26 = (_e301 + 1i);
        }
    }
    let _e303 = bestSlot;
    if (_e303 < 0i) {
        return false;
    }
    let _e305 = bestDistSq;
    let _e307 = (*pos_20);
    param_891 = _e307;
    let _e308 = (*currentIndex_14);
    param_892 = _e308;
    let _e309 = (*rawValue_12);
    param_893 = _e309;
    let _e310 = bestCenter;
    param_894 = _e310;
    let _e311 = bestSlot;
    param_895 = _e311;
    let _e312 = bestLevel;
    param_896 = _e312;
    let _e313 = bestPurge;
    param_897 = _e313;
    param_898 = sqrt(_e305);
    let _e314 = (*randVal_13);
    param_899 = _e314;
    updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b((&param_891), (&param_892), (&param_893), (&param_894), (&param_895), (&param_896), (&param_897), (&param_898), (&param_899));
    return true;
}

fn cloudColumnBase_u0028_i1_u003b_i1_u003b(x_4: ptr<function, i32>, z_5: ptr<function, i32>) -> u32 {
    let _e206 = (*x_4);
    let _e207 = (*z_5);
    let _e209 = tuning.gridWidth;
    return (bitcast<u32>((_e206 + (_e207 * bitcast<i32>(_e209)))) * 4u);
}

fn bhRegister_u0028_vi3_u003b(p_5: ptr<function, vec3<i32>>) -> bool {
    var code_4: u32;
    var param_900: vec3<i32>;
    var i_27: i32;

    let _e208 = (*p_5);
    param_900 = _e208;
    let _e209 = getIndex_u0028_vi3_u003b((&param_900));
    code_4 = (2147483648u | _e209);
    i_27 = 0i;
    loop {
        let _e211 = i_27;
        if (_e211 < 8i) {
            let _e213 = i_27;
            let _e216 = code_4;
            let _e217 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e213]), 0u, _e216);
            if (_e217.old_value == 0u) {
                let _e220 = i_27;
                atomicStore((&unnamed_2.blackHoleMass[_e220]), 0u);
                let _e223 = i_27;
                unnamed_2.blackHoleStarve[_e223] = 0u;
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e226 = i_27;
            i_27 = (_e226 + 1i);
        }
    }
    return false;
}

fn writeCell_u0028_u1_u003b_u1_u003b(index_1: ptr<function, u32>, value_2: ptr<function, u32>) {
    let _e206 = (*index_1);
    let _e207 = (*value_2);
    atomicStore((&unnamed.grid[_e206]), _e207);
    return;
}

fn lavaSpawnCoolness_u0028_u1_u003b(type_38: ptr<function, u32>) -> u32 {
    var param_901: u32;

    let _e206 = (*type_38);
    if (_e206 == 12u) {
        let _e208 = lavaSolidifyCoolness_u0028_();
        return _e208;
    }
    let _e209 = (*type_38);
    param_901 = _e209;
    let _e210 = isLava_u0028_u1_u003b((&param_901));
    if _e210 {
        let _e211 = (*type_38);
        let _e214 = tuning.lavaStageSize;
        return ((_e211 - 8u) * max(_e214, 1u));
    }
    return 0u;
}

fn locustSpawnCount_u0028_u1_u003b(type_39: ptr<function, u32>) -> u32 {
    var param_902: u32;

    let _e206 = (*type_39);
    param_902 = _e206;
    let _e207 = isLocust_u0028_u1_u003b((&param_902));
    if !(_e207) {
        return 0u;
    }
    let _e209 = (*type_39);
    let _e212 = locustStage_u0028_();
    let _e214 = locustMaxCount_u0028_();
    return min((((_e209 - 13u) + 1u) * _e212), _e214);
}

fn bhRelease_u0028_vi3_u003b(p_6: ptr<function, vec3<i32>>) {
    var code_5: u32;
    var param_903: vec3<i32>;
    var i_28: i32;

    let _e208 = (*p_6);
    param_903 = _e208;
    let _e209 = getIndex_u0028_vi3_u003b((&param_903));
    code_5 = (2147483648u | _e209);
    i_28 = 0i;
    loop {
        let _e211 = i_28;
        if (_e211 < 8i) {
            let _e213 = i_28;
            let _e216 = code_5;
            let _e217 = atomicCompareExchangeWeak((&unnamed_2.blackHoles[_e213]), _e216, 0u);
            continue;
        } else {
            break;
        }
        continuing {
            let _e219 = i_28;
            i_28 = (_e219 + 1i);
        }
    }
    return;
}

fn inBrush_u0028_vi3_u003b(pos_21: ptr<function, vec3<i32>>) -> bool {
    var halfMin: i32;
    var halfMax: i32;
    var center_3: vec3<f32>;
    var d_24: vec3<f32>;
    var radius_1: f32;
    var phi_1634_: bool;
    var phi_1656_: bool;
    var phi_1677_: bool;

    let _e211 = pc.spawnSize;
    halfMin = (_e211 / 2i);
    let _e214 = pc.spawnSize;
    halfMax = ((_e214 - 1i) / 2i);
    let _e218 = (*pos_21)[0u];
    let _e220 = pc.spawnX;
    let _e221 = halfMin;
    let _e223 = (_e218 < (_e220 - _e221));
    phi_1634_ = _e223;
    if !(_e223) {
        let _e226 = (*pos_21)[0u];
        let _e228 = pc.spawnX;
        let _e229 = halfMax;
        phi_1634_ = (_e226 > (_e228 + _e229));
    }
    let _e233 = phi_1634_;
    if _e233 {
        return false;
    }
    let _e235 = (*pos_21)[1u];
    let _e237 = pc.spawnY;
    let _e238 = halfMin;
    let _e240 = (_e235 < (_e237 - _e238));
    phi_1656_ = _e240;
    if !(_e240) {
        let _e243 = (*pos_21)[1u];
        let _e245 = pc.spawnY;
        let _e246 = halfMax;
        phi_1656_ = (_e243 > (_e245 + _e246));
    }
    let _e250 = phi_1656_;
    if _e250 {
        return false;
    }
    let _e252 = (*pos_21)[2u];
    let _e254 = pc.spawnZ;
    let _e255 = halfMin;
    let _e257 = (_e252 < (_e254 - _e255));
    phi_1677_ = _e257;
    if !(_e257) {
        let _e260 = (*pos_21)[2u];
        let _e262 = pc.spawnZ;
        let _e263 = halfMax;
        phi_1677_ = (_e260 > (_e262 + _e263));
    }
    let _e267 = phi_1677_;
    if _e267 {
        return false;
    }
    let _e269 = pc.spawnShape;
    if (_e269 != 1i) {
        return true;
    }
    let _e272 = pc.spawnX;
    let _e275 = pc.spawnY;
    let _e278 = pc.spawnZ;
    let _e281 = halfMax;
    let _e282 = halfMin;
    center_3 = (vec3<f32>(f32(_e272), f32(_e275), f32(_e278)) + vec3((f32(((_e281 - _e282) + 1i)) * 0.5f)));
    let _e289 = (*pos_21);
    let _e293 = center_3;
    d_24 = ((vec3<f32>(_e289) + vec3(0.5f)) - _e293);
    let _e296 = pc.spawnSize;
    radius_1 = (f32(_e296) * 0.5f);
    let _e299 = d_24;
    let _e300 = d_24;
    let _e302 = radius_1;
    let _e303 = radius_1;
    return (dot(_e299, _e300) <= (_e302 * _e303));
}

fn tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(fromIndex: ptr<function, u32>, newValue_4: ptr<function, u32>, toIndex: ptr<function, u32>, expectedFromValue: ptr<function, u32>) -> bool {
    let _e208 = (*toIndex);
    let _e211 = (*newValue_4);
    let _e212 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e208]), 0u, _e211);
    if (_e212.old_value != 0u) {
        return false;
    }
    let _e215 = (*fromIndex);
    let _e218 = (*expectedFromValue);
    let _e219 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e215]), _e218, 0u);
    let _e221 = (*expectedFromValue);
    if (_e219.old_value != _e221) {
        let _e223 = (*toIndex);
        let _e226 = atomicExchange((&unnamed_1.cloudCells[_e223]), 0u);
        return false;
    }
    return true;
}

fn getCloudCounter_u0028_u1_u003b(v_5: ptr<function, u32>) -> u32 {
    let _e205 = (*v_5);
    return ((_e205 >> bitcast<u32>(3i)) & 2047u);
}

fn getCloudTarget_u0028_u1_u003b(v_6: ptr<function, u32>) -> u32 {
    let _e205 = (*v_6);
    return ((_e205 >> bitcast<u32>(14i)) & 2047u);
}

fn easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b(current: ptr<function, u32>, target_4: ptr<function, f32>, rate: ptr<function, f32>) -> u32 {
    var old: f32;
    var next: f32;

    let _e209 = (*current);
    old = f32(_e209);
    let _e211 = old;
    let _e212 = (*target_4);
    let _e213 = old;
    let _e215 = (*rate);
    next = (_e211 + ((_e212 - _e213) * _e215));
    let _e218 = (*target_4);
    let _e219 = old;
    if (_e218 > _e219) {
        let _e221 = next;
        let _e222 = old;
        let _e225 = old;
        let _e226 = (*target_4);
        next = clamp(max(_e221, (_e222 + 1f)), _e225, _e226);
    } else {
        let _e228 = (*target_4);
        let _e229 = old;
        if (_e228 < _e229) {
            let _e231 = next;
            let _e232 = old;
            let _e235 = (*target_4);
            let _e236 = old;
            next = clamp(min(_e231, (_e232 - 1f)), _e235, _e236);
        }
    }
    let _e238 = next;
    return u32(max(_e238, 0f));
}

fn updateCloudBlock_u0028_vi3_u003b(pos_22: ptr<function, vec3<i32>>) {
    var idx_4: u32;
    var param_904: vec3<i32>;
    var base: u32;
    var param_905: i32;
    var param_906: i32;
    var rate_1: f32;
    var tallied: u32;
    var param_907: u32;
    var param_908: f32;
    var param_909: f32;
    var param_910: u32;
    var param_911: f32;
    var param_912: f32;
    var cell: u32;
    var kind_1: u32;
    var param_913: u32;
    var param_914: vec3<i32>;
    var newCell: u32;
    var param_915: u32;
    var param_916: bool;
    var param_917: u32;
    var param_918: u32;
    var param_919: u32;
    var param_920: u32;
    var param_921: bool;
    var param_922: u32;
    var param_923: u32;
    var target_5: u32;
    var param_924: u32;
    var lo_1: u32;
    var hi_1: u32;
    var r_6: f32;
    var param_925: vec3<f32>;
    var param_926: u32;
    var param_927: bool;
    var param_928: u32;
    var param_929: u32;
    var counter_1: u32;
    var param_930: u32;
    var param_931: u32;
    var param_932: bool;
    var param_933: u32;
    var param_934: u32;
    var param_935: vec3<i32>;
    var g: u32;
    var param_936: u32;
    var param_937: u32;
    var param_938: u32;
    var param_939: u32;
    var param_940: u32;
    var param_941: u32;
    var randVal_14: f32;
    var param_942: vec3<f32>;
    var counter_2: u32;
    var param_943: u32;
    var target_6: u32;
    var param_944: u32;
    var upPos_2: vec3<i32>;
    var param_945: vec3<i32>;
    var param_946: vec3<i32>;
    var param_947: u32;
    var param_948: u32;
    var param_949: bool;
    var param_950: u32;
    var param_951: u32;
    var param_952: vec3<i32>;
    var param_953: u32;
    var param_954: u32;
    var param_955: u32;
    var param_956: u32;
    var dir_7: i32;
    var slide1_: vec3<i32>;
    var slide2_: vec3<i32>;
    var i_29: i32;
    var t_5: vec3<i32>;
    var param_957: vec3<i32>;
    var tIndex: u32;
    var param_958: vec3<i32>;
    var param_959: u32;
    var param_960: u32;
    var param_961: bool;
    var param_962: u32;
    var param_963: u32;
    var param_964: u32;
    var param_965: u32;
    var param_966: u32;
    var param_967: u32;
    var param_968: u32;
    var param_969: u32;
    var param_970: bool;
    var param_971: u32;
    var param_972: u32;
    var phi_9121_: bool;
    var phi_9122_: bool;
    var phi_9330_: bool;

    let _e297 = (*pos_22);
    param_904 = _e297;
    let _e298 = getIndex_u0028_vi3_u003b((&param_904));
    idx_4 = _e298;
    let _e300 = (*pos_22)[0u];
    param_905 = _e300;
    let _e302 = (*pos_22)[2u];
    param_906 = _e302;
    let _e303 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_905), (&param_906));
    base = _e303;
    let _e305 = (*pos_22)[1u];
    if (_e305 == 0i) {
        let _e308 = tuning.cloudSmoothRate;
        rate_1 = clamp(_e308, 0.01f, 1f);
        let _e310 = base;
        let _e314 = atomicLoad((&unnamed_2.cloudColumn[(_e310 + 0u)]));
        tallied = _e314;
        let _e315 = base;
        let _e317 = base;
        let _e319 = tallied;
        let _e324 = atomicLoad((&unnamed_2.cloudColumn[(_e317 + 2u)]));
        param_907 = _e324;
        param_908 = (f32(_e319) * 16f);
        let _e325 = rate_1;
        param_909 = _e325;
        let _e326 = easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b((&param_907), (&param_908), (&param_909));
        atomicStore((&unnamed_2.cloudColumn[(_e315 + 2u)]), _e326);
        let _e329 = tallied;
        if (_e329 > 0u) {
            let _e331 = base;
            let _e333 = base;
            let _e335 = base;
            let _e339 = atomicLoad((&unnamed_2.cloudColumn[(_e335 + 1u)]));
            let _e344 = atomicLoad((&unnamed_2.cloudColumn[(_e333 + 3u)]));
            param_910 = _e344;
            param_911 = (f32(_e339) * 16f);
            let _e345 = rate_1;
            param_912 = _e345;
            let _e346 = easeTowards_u0028_u1_u003b_f1_u003b_f1_u003b((&param_910), (&param_911), (&param_912));
            atomicStore((&unnamed_2.cloudColumn[(_e331 + 3u)]), _e346);
        }
        let _e349 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e349 + 0u)]), 0u);
        let _e353 = base;
        atomicStore((&unnamed_2.cloudColumn[(_e353 + 1u)]), 0u);
    }
    let _e357 = idx_4;
    let _e360 = atomicLoad((&unnamed_1.cloudCells[_e357]));
    cell = _e360;
    let _e361 = cell;
    param_913 = _e361;
    let _e362 = getCloudKind_u0028_u1_u003b((&param_913));
    kind_1 = _e362;
    let _e363 = kind_1;
    if (_e363 == 0u) {
        return;
    }
    let _e366 = atomicAdd((&unnamed_2.cloudBlockCount), 1u);
    let _e367 = base;
    let _e371 = atomicAdd((&unnamed_2.cloudColumn[(_e367 + 0u)]), 1u);
    let _e372 = base;
    let _e377 = (*pos_22)[1u];
    let _e379 = atomicMax((&unnamed_2.cloudColumn[(_e372 + 1u)]), bitcast<u32>(_e377));
    let _e382 = (*pos_22)[1u];
    let _e384 = atomicMin((&unnamed_2.cloudMinYAcc), bitcast<u32>(_e382));
    let _e387 = (*pos_22)[1u];
    let _e389 = atomicMax((&unnamed_2.cloudMaxYAcc), bitcast<u32>(_e387));
    let _e390 = kind_1;
    let _e391 = (_e390 == 1u);
    phi_9122_ = _e391;
    if _e391 {
        let _e393 = unnamed_2.rainPhase;
        let _e394 = (_e393 == 2u);
        phi_9121_ = _e394;
        if !(_e394) {
            let _e396 = (*pos_22);
            param_914 = _e396;
            let _e397 = cloudTouchesRain_u0028_vi3_u003b((&param_914));
            phi_9121_ = _e397;
        }
        let _e399 = phi_9121_;
        phi_9122_ = _e399;
    }
    let _e401 = phi_9122_;
    if _e401 {
        param_915 = 2u;
        param_916 = false;
        param_917 = 0u;
        param_918 = 0u;
        let _e402 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_915), (&param_916), (&param_917), (&param_918));
        newCell = _e402;
        let _e403 = idx_4;
        let _e406 = cell;
        let _e407 = newCell;
        let _e408 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e403]), _e406, _e407);
        let _e410 = cell;
        if (_e408.old_value != _e410) {
            return;
        }
        let _e412 = newCell;
        cell = _e412;
        kind_1 = 2u;
    }
    let _e414 = (*pos_22)[1u];
    let _e416 = tuning.gridHeight;
    if (_e414 >= (bitcast<i32>(_e416) - 2i)) {
        let _e420 = kind_1;
        if (_e420 != 2u) {
            let _e422 = cell;
            param_919 = _e422;
            let _e423 = getCloudMoved_u0028_u1_u003b((&param_919));
            if _e423 {
                let _e424 = idx_4;
                let _e427 = cell;
                let _e428 = kind_1;
                param_920 = _e428;
                param_921 = false;
                param_922 = 0u;
                param_923 = 0u;
                let _e429 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_920), (&param_921), (&param_922), (&param_923));
                let _e430 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e424]), _e427, _e429);
            }
            return;
        }
        let _e432 = cell;
        param_924 = _e432;
        let _e433 = getCloudTarget_u0028_u1_u003b((&param_924));
        target_5 = _e433;
        let _e434 = target_5;
        if (_e434 == 0u) {
            let _e437 = tuning.rainWaitMinTicks;
            let _e439 = tuning.rainWaitMaxTicks;
            lo_1 = min(_e437, _e439);
            let _e442 = tuning.rainWaitMinTicks;
            let _e444 = tuning.rainWaitMaxTicks;
            hi_1 = max(_e442, _e444);
            let _e446 = (*pos_22);
            let _e449 = pc.time;
            param_925 = (vec3<f32>(_e446) + vec3<f32>(_e449, 17f, 3f));
            let _e452 = hash_u0028_vf3_u003b((&param_925));
            r_6 = _e452;
            let _e453 = lo_1;
            let _e454 = r_6;
            let _e455 = hi_1;
            let _e456 = lo_1;
            target_5 = (_e453 + u32((_e454 * f32(((_e455 - _e456) + 1u)))));
            let _e463 = idx_4;
            let _e466 = cell;
            param_926 = 2u;
            param_927 = false;
            param_928 = 0u;
            let _e467 = target_5;
            param_929 = _e467;
            let _e468 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_926), (&param_927), (&param_928), (&param_929));
            let _e469 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e463]), _e466, _e468);
            return;
        }
        let _e471 = cell;
        param_930 = _e471;
        let _e472 = getCloudCounter_u0028_u1_u003b((&param_930));
        counter_1 = _e472;
        let _e473 = counter_1;
        let _e474 = target_5;
        if (_e473 < _e474) {
            let _e476 = idx_4;
            let _e479 = cell;
            let _e480 = counter_1;
            param_931 = 2u;
            param_932 = false;
            param_933 = (_e480 + 1u);
            let _e482 = target_5;
            param_934 = _e482;
            let _e483 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_931), (&param_932), (&param_933), (&param_934));
            let _e484 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e476]), _e479, _e483);
            return;
        }
        let _e486 = (*pos_22);
        param_935 = _e486;
        let _e487 = cloudCellInBounds_u0028_vi3_u003b((&param_935));
        if !(_e487) {
            return;
        }
        let _e489 = idx_4;
        param_936 = _e489;
        let _e490 = readCell_u0028_u1_u003b((&param_936));
        g = _e490;
        let _e491 = g;
        param_937 = _e491;
        let _e492 = getType_u0028_u1_u003b((&param_937));
        if (_e492 != 0u) {
            return;
        }
        let _e494 = idx_4;
        let _e497 = g;
        param_938 = 2u;
        param_939 = 0u;
        param_940 = 0u;
        param_941 = 0u;
        let _e498 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_938), (&param_939), (&param_940), (&param_941));
        let _e499 = atomicCompareExchangeWeak((&unnamed.grid[_e494]), _e497, _e498);
        let _e501 = g;
        if (_e499.old_value != _e501) {
            return;
        }
        let _e503 = idx_4;
        let _e506 = atomicExchange((&unnamed_1.cloudCells[_e503]), 0u);
        incWater_u0028_();
        let _e508 = (*pos_22)[1u];
        let _e511 = atomicLoad((&unnamed_2.maxOccupiedY));
        if (bitcast<u32>(_e508) > _e511) {
            let _e515 = (*pos_22)[1u];
            let _e517 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e515));
        }
        return;
    }
    let _e518 = (*pos_22);
    let _e521 = pc.time;
    param_942 = (vec3<f32>(_e518) + vec3<f32>((_e521 * 2.3f), 7f, 13f));
    let _e525 = hash_u0028_vf3_u003b((&param_942));
    randVal_14 = _e525;
    let _e526 = cell;
    param_943 = _e526;
    let _e527 = getCloudCounter_u0028_u1_u003b((&param_943));
    counter_2 = _e527;
    let _e528 = cell;
    param_944 = _e528;
    let _e529 = getCloudTarget_u0028_u1_u003b((&param_944));
    target_6 = _e529;
    let _e530 = (*pos_22);
    upPos_2 = (_e530 + vec3<i32>(0i, 1i, 0i));
    let _e532 = upPos_2;
    param_945 = _e532;
    let _e533 = cloudCellInBounds_u0028_vi3_u003b((&param_945));
    phi_9330_ = _e533;
    if _e533 {
        let _e534 = upPos_2;
        param_946 = _e534;
        let _e535 = getIndex_u0028_vi3_u003b((&param_946));
        let _e538 = atomicLoad((&unnamed_1.cloudCells[_e535]));
        param_947 = _e538;
        let _e539 = getCloudKind_u0028_u1_u003b((&param_947));
        phi_9330_ = (_e539 == 0u);
    }
    let _e542 = phi_9330_;
    if _e542 {
        let _e543 = kind_1;
        param_948 = _e543;
        param_949 = true;
        let _e544 = counter_2;
        param_950 = _e544;
        let _e545 = target_6;
        param_951 = _e545;
        let _e546 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_948), (&param_949), (&param_950), (&param_951));
        let _e547 = upPos_2;
        param_952 = _e547;
        let _e548 = getIndex_u0028_vi3_u003b((&param_952));
        let _e549 = idx_4;
        param_953 = _e549;
        param_954 = _e546;
        param_955 = _e548;
        let _e550 = cell;
        param_956 = _e550;
        let _e551 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_953), (&param_954), (&param_955), (&param_956));
        if _e551 {
            let _e553 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
            return;
        }
    }
    let _e554 = randVal_14;
    dir_7 = select(-1i, 1i, (fract((_e554 * 10f)) > 0.5f));
    let _e559 = randVal_14;
    if (fract((_e559 * 100f)) > 0.5f) {
        let _e563 = (*pos_22);
        let _e564 = dir_7;
        slide1_ = (_e563 + vec3<i32>(_e564, 1i, 0i));
        let _e567 = (*pos_22);
        let _e568 = dir_7;
        slide2_ = (_e567 + vec3<i32>(0i, 1i, _e568));
    } else {
        let _e571 = (*pos_22);
        let _e572 = dir_7;
        slide1_ = (_e571 + vec3<i32>(0i, 1i, _e572));
        let _e575 = (*pos_22);
        let _e576 = dir_7;
        slide2_ = (_e575 + vec3<i32>(_e576, 1i, 0i));
    }
    i_29 = 0i;
    loop {
        let _e579 = i_29;
        if (_e579 < 2i) {
            let _e581 = i_29;
            let _e583 = slide1_;
            let _e584 = slide2_;
            t_5 = select(_e584, _e583, vec3((_e581 == 0i)));
            let _e587 = t_5;
            param_957 = _e587;
            let _e588 = cloudCellInBounds_u0028_vi3_u003b((&param_957));
            if !(_e588) {
                continue;
            }
            let _e590 = t_5;
            param_958 = _e590;
            let _e591 = getIndex_u0028_vi3_u003b((&param_958));
            tIndex = _e591;
            let _e592 = tIndex;
            let _e595 = atomicLoad((&unnamed_1.cloudCells[_e592]));
            param_959 = _e595;
            let _e596 = getCloudKind_u0028_u1_u003b((&param_959));
            if (_e596 != 0u) {
                continue;
            }
            let _e598 = kind_1;
            param_960 = _e598;
            param_961 = true;
            let _e599 = counter_2;
            param_962 = _e599;
            let _e600 = target_6;
            param_963 = _e600;
            let _e601 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_960), (&param_961), (&param_962), (&param_963));
            let _e602 = idx_4;
            param_964 = _e602;
            param_965 = _e601;
            let _e603 = tIndex;
            param_966 = _e603;
            let _e604 = cell;
            param_967 = _e604;
            let _e605 = tryMoveCloud_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_964), (&param_965), (&param_966), (&param_967));
            if _e605 {
                let _e607 = atomicAdd((&unnamed_2.cloudMovedCount), 1u);
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e608 = i_29;
            i_29 = (_e608 + 1i);
        }
    }
    let _e610 = cell;
    param_968 = _e610;
    let _e611 = getCloudMoved_u0028_u1_u003b((&param_968));
    if _e611 {
        let _e612 = idx_4;
        let _e615 = cell;
        let _e616 = kind_1;
        param_969 = _e616;
        param_970 = false;
        let _e617 = counter_2;
        param_971 = _e617;
        let _e618 = target_6;
        param_972 = _e618;
        let _e619 = packCloud_u0028_u1_u003b_b1_u003b_u1_u003b_u1_u003b((&param_969), (&param_970), (&param_971), (&param_972));
        let _e620 = atomicCompareExchangeWeak((&unnamed_1.cloudCells[_e612]), _e615, _e619);
    }
    return;
}

fn updateSimState_u0028_() {
    var live: u32;
    var i_30: i32;
    var code_6: u32;
    var voxel: u32;
    var param_973: u32;
    var param_974: u32;
    var starve: u32;
    var purge_2: bool;
    var param_975: u32;
    var grace: u32;
    var local_30: u32;
    var decay: u32;
    var local_31: u32;
    var mass_2: u32;
    var param_976: u32;
    var param_977: u32;
    var movedLastTick: u32;
    var liveClouds: u32;
    var chargeTarget: f32;
    var charge: f32;
    var interval: u32;
    var phi_8280_: bool;
    var phi_8287_: bool;

    let _e226 = gl_GlobalInvocationID_1[0u];
    let _e227 = (_e226 != 0u);
    phi_8280_ = _e227;
    if !(_e227) {
        let _e230 = gl_GlobalInvocationID_1[1u];
        phi_8280_ = (_e230 != 0u);
    }
    let _e233 = phi_8280_;
    phi_8287_ = _e233;
    if !(_e233) {
        let _e236 = gl_GlobalInvocationID_1[2u];
        phi_8287_ = (_e236 != 0u);
    }
    let _e239 = phi_8287_;
    if _e239 {
        return;
    }
    live = 0u;
    i_30 = 0i;
    loop {
        let _e240 = i_30;
        if (_e240 < 8i) {
            let _e242 = i_30;
            let _e245 = atomicLoad((&unnamed_2.blackHoles[_e242]));
            code_6 = _e245;
            let _e246 = code_6;
            if (_e246 == 0u) {
                continue;
            }
            let _e248 = code_6;
            voxel = (_e248 & 1073741823u);
            let _e250 = voxel;
            param_973 = _e250;
            let _e251 = readCell_u0028_u1_u003b((&param_973));
            param_974 = _e251;
            let _e252 = getType_u0028_u1_u003b((&param_974));
            if (_e252 != 7u) {
                let _e254 = i_30;
                atomicStore((&unnamed_2.blackHoles[_e254]), 0u);
                continue;
            }
            let _e257 = i_30;
            let _e260 = unnamed_2.blackHoleStarve[_e257];
            starve = (_e260 + 1u);
            let _e262 = i_30;
            let _e263 = starve;
            unnamed_2.blackHoleStarve[_e262] = _e263;
            let _e266 = code_6;
            param_975 = _e266;
            let _e267 = bhIsPurge_u0028_u1_u003b((&param_975));
            purge_2 = _e267;
            let _e268 = purge_2;
            if _e268 {
                let _e270 = tuning.purgeStarveGrace;
                local_30 = _e270;
            } else {
                let _e272 = tuning.blackHoleStarveGrace;
                local_30 = _e272;
            }
            let _e273 = local_30;
            grace = _e273;
            let _e274 = purge_2;
            if _e274 {
                let _e276 = tuning.purgeDecayRate;
                local_31 = _e276;
            } else {
                let _e278 = tuning.blackHoleDecayRate;
                local_31 = _e278;
            }
            let _e279 = local_31;
            decay = _e279;
            let _e280 = starve;
            let _e281 = grace;
            if (_e280 > _e281) {
                let _e283 = i_30;
                let _e286 = atomicLoad((&unnamed_2.blackHoleMass[_e283]));
                mass_2 = _e286;
                let _e287 = mass_2;
                if (_e287 == 0u) {
                    let _e289 = voxel;
                    param_976 = _e289;
                    param_977 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_976), (&param_977));
                    let _e290 = i_30;
                    atomicStore((&unnamed_2.blackHoles[_e290]), 0u);
                    continue;
                }
                let _e293 = i_30;
                let _e294 = mass_2;
                let _e295 = mass_2;
                let _e296 = decay;
                atomicStore((&unnamed_2.blackHoleMass[_e293]), (_e294 - min(_e295, _e296)));
            }
            let _e301 = live;
            live = (_e301 + bitcast<u32>(1i));
            continue;
        } else {
            break;
        }
        continuing {
            let _e304 = i_30;
            i_30 = (_e304 + 1i);
        }
    }
    let _e306 = live;
    unnamed_2.blackHoleCount = _e306;
    let _e309 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (_e309 > 0u) {
        let _e312 = atomicAdd((&unnamed_2.maxOccupiedY), 4294967295u);
    }
    let _e314 = atomicLoad((&unnamed_2.rainCandidateCount));
    unnamed_2.rainCandidateEstimate = _e314;
    atomicStore((&unnamed_2.rainCandidateCount), 0u);
    let _e318 = unnamed_2.simTick;
    unnamed_2.simTick = (_e318 + 1u);
    let _e322 = atomicLoad((&unnamed_2.cloudMovedCount));
    movedLastTick = _e322;
    let _e324 = atomicLoad((&unnamed_2.cloudBlockCount));
    liveClouds = _e324;
    atomicStore((&unnamed_2.cloudBlockCount), 0u);
    atomicStore((&unnamed_2.cloudMovedCount), 0u);
    let _e328 = atomicLoad((&unnamed_2.cloudMinYAcc));
    unnamed_2.cloudMinY = _e328;
    let _e331 = atomicLoad((&unnamed_2.cloudMaxYAcc));
    unnamed_2.cloudMaxY = _e331;
    atomicStore((&unnamed_2.cloudMinYAcc), 4294967295u);
    atomicStore((&unnamed_2.cloudMaxYAcc), 0u);
    let _e336 = unnamed_2.rainPhase;
    chargeTarget = select(1f, 0f, (_e336 == 0u));
    let _e340 = unnamed_2.cloudChargeBits;
    charge = bitcast<f32>(_e340);
    let _e342 = chargeTarget;
    let _e343 = charge;
    let _e346 = tuning.cloudChargeEaseRate;
    let _e349 = charge;
    charge = (_e349 + ((_e342 - _e343) * clamp(_e346, 0f, 1f)));
    let _e351 = charge;
    unnamed_2.cloudChargeBits = bitcast<u32>(clamp(_e351, 0f, 1f));
    let _e356 = unnamed_2.rainPhase;
    if (_e356 == 0u) {
        let _e359 = tuning.cloudCheckIntervalTicks;
        interval = max(_e359, 1u);
        let _e362 = unnamed_2.simTick;
        let _e363 = interval;
        let _e366 = liveClouds;
        let _e369 = movedLastTick;
        if ((((_e362 % _e363) == 0u) && (_e366 > 0u)) && (_e369 == 0u)) {
            unnamed_2.rainPhase = 2u;
            let _e374 = pc.time;
            unnamed_2.rainPhaseTimeBits = bitcast<u32>(_e374);
            let _e378 = unnamed_2.simTick;
            unnamed_2.lastRainTick = _e378;
        }
    } else {
        let _e380 = liveClouds;
        if (_e380 == 0u) {
            unnamed_2.rainPhase = 0u;
            unnamed_2.rainPhaseTimeBits = 0u;
        }
    }
    return;
}

fn main_1() {
    var pos_23: vec3<i32>;
    var param_978: vec3<i32>;
    var param_979: vec3<i32>;
    var spawnIndex: u32;
    var param_980: vec3<i32>;
    var oldType: u32;
    var param_981: u32;
    var param_982: u32;
    var newType_3: u32;
    var param_983: vec3<i32>;
    var seedAge: u32;
    var param_984: u32;
    var local_32: u32;
    var param_985: u32;
    var param_986: u32;
    var param_987: u32;
    var param_988: u32;
    var param_989: u32;
    var param_990: u32;
    var param_991: u32;
    var param_992: u32;
    var param_993: vec3<i32>;
    var param_994: u32;
    var param_995: u32;
    var currentIndex_15: u32;
    var param_996: vec3<i32>;
    var rawValue_13: u32;
    var param_997: u32;
    var currentType_1: u32;
    var param_998: u32;
    var param_999: i32;
    var param_1000: i32;
    var randVal_15: f32;
    var param_1001: vec3<f32>;
    var param_1002: vec3<i32>;
    var param_1003: u32;
    var param_1004: u32;
    var param_1005: f32;
    var currentDir_6: u32;
    var param_1006: u32;
    var currentSleep_7: u32;
    var param_1007: u32;
    var currentAge_10: u32;
    var param_1008: u32;
    var param_1009: vec3<i32>;
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
    var param_1020: u32;
    var param_1021: f32;
    var param_1022: vec3<i32>;
    var param_1023: u32;
    var param_1024: u32;
    var param_1025: u32;
    var param_1026: u32;
    var param_1027: u32;
    var param_1028: f32;
    var param_1029: vec3<i32>;
    var param_1030: u32;
    var param_1031: u32;
    var param_1032: u32;
    var param_1033: u32;
    var param_1034: u32;
    var param_1035: f32;
    var param_1036: vec3<i32>;
    var param_1037: u32;
    var param_1038: u32;
    var param_1039: u32;
    var param_1040: u32;
    var param_1041: f32;
    var param_1042: vec3<i32>;
    var param_1043: u32;
    var param_1044: u32;
    var param_1045: u32;
    var param_1046: u32;
    var param_1047: u32;
    var param_1048: f32;
    var param_1049: vec3<i32>;
    var param_1050: u32;
    var param_1051: u32;
    var param_1052: u32;
    var param_1053: f32;
    var param_1054: vec3<i32>;
    var param_1055: u32;
    var param_1056: u32;
    var param_1057: u32;
    var param_1058: u32;
    var param_1059: u32;
    var param_1060: f32;
    var param_1061: vec3<i32>;
    var param_1062: u32;
    var param_1063: u32;
    var param_1064: u32;
    var param_1065: u32;
    var param_1066: f32;
    var param_1067: vec3<i32>;
    var param_1068: u32;
    var param_1069: u32;
    var param_1070: u32;
    var param_1071: f32;
    var phi_9480_: bool;
    var phi_9490_: bool;
    var phi_9506_: bool;
    var phi_9605_: bool;
    var phi_9612_: bool;
    var phi_9623_: bool;
    var phi_9630_: bool;
    var phi_9641_: bool;
    var phi_9664_: bool;
    var phi_9674_: bool;
    var phi_9732_: bool;

    let _e311 = gl_GlobalInvocationID_1;
    pos_23 = bitcast<vec3<i32>>(_e311);
    let _e314 = pos_23[0u];
    let _e316 = tuning.gridWidth;
    let _e318 = (_e314 >= bitcast<i32>(_e316));
    phi_9480_ = _e318;
    if !(_e318) {
        let _e321 = pos_23[1u];
        let _e323 = tuning.gridHeight;
        phi_9480_ = (_e321 >= bitcast<i32>(_e323));
    }
    let _e327 = phi_9480_;
    phi_9490_ = _e327;
    if !(_e327) {
        let _e330 = pos_23[2u];
        let _e332 = tuning.gridDepth;
        phi_9490_ = (_e330 >= bitcast<i32>(_e332));
    }
    let _e336 = phi_9490_;
    if _e336 {
        return;
    }
    updateSimState_u0028_();
    let _e337 = pos_23;
    param_978 = _e337;
    updateCloudBlock_u0028_vi3_u003b((&param_978));
    let _e339 = pc.spawnActive;
    let _e340 = (_e339 == 1i);
    phi_9506_ = _e340;
    if _e340 {
        let _e341 = pos_23;
        param_979 = _e341;
        let _e342 = inBrush_u0028_vi3_u003b((&param_979));
        phi_9506_ = _e342;
    }
    let _e344 = phi_9506_;
    if _e344 {
        let _e345 = pos_23;
        param_980 = _e345;
        let _e346 = getIndex_u0028_vi3_u003b((&param_980));
        spawnIndex = _e346;
        let _e347 = spawnIndex;
        param_981 = _e347;
        let _e348 = readCell_u0028_u1_u003b((&param_981));
        param_982 = _e348;
        let _e349 = getType_u0028_u1_u003b((&param_982));
        oldType = _e349;
        let _e351 = pc.spawnType;
        newType_3 = bitcast<u32>(_e351);
        let _e353 = newType_3;
        let _e355 = oldType;
        if ((_e353 != 7u) || (_e355 != 7u)) {
            let _e358 = oldType;
            let _e359 = newType_3;
            if (_e358 != _e359) {
                let _e361 = oldType;
                if (_e361 == 2u) {
                    decWater_u0028_();
                }
                let _e363 = oldType;
                if (_e363 == 7u) {
                    let _e365 = pos_23;
                    param_983 = _e365;
                    bhRelease_u0028_vi3_u003b((&param_983));
                }
                let _e366 = newType_3;
                if (_e366 == 2u) {
                    incWater_u0028_();
                }
            }
            let _e368 = newType_3;
            param_984 = _e368;
            let _e369 = isLocust_u0028_u1_u003b((&param_984));
            if _e369 {
                let _e370 = newType_3;
                param_985 = _e370;
                let _e371 = locustSpawnCount_u0028_u1_u003b((&param_985));
                local_32 = _e371;
            } else {
                let _e372 = newType_3;
                param_986 = _e372;
                let _e373 = lavaSpawnCoolness_u0028_u1_u003b((&param_986));
                local_32 = _e373;
            }
            let _e374 = local_32;
            seedAge = _e374;
            let _e375 = newType_3;
            param_987 = _e375;
            param_988 = 0u;
            param_989 = 0u;
            let _e376 = seedAge;
            param_990 = _e376;
            let _e377 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_987), (&param_988), (&param_989), (&param_990));
            let _e378 = spawnIndex;
            param_991 = _e378;
            param_992 = _e377;
            writeCell_u0028_u1_u003b_u1_u003b((&param_991), (&param_992));
            let _e379 = newType_3;
            if (_e379 == 7u) {
                let _e381 = pos_23;
                param_993 = _e381;
                let _e382 = bhRegister_u0028_vi3_u003b((&param_993));
                if !(_e382) {
                    let _e384 = spawnIndex;
                    param_994 = _e384;
                    param_995 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_994), (&param_995));
                }
            }
        }
    }
    let _e386 = pos_23[0u];
    let _e387 = (_e386 < 1i);
    phi_9605_ = _e387;
    if !(_e387) {
        let _e390 = pos_23[0u];
        let _e392 = tuning.gridWidth;
        phi_9605_ = (_e390 >= (bitcast<i32>(_e392) - 1i));
    }
    let _e397 = phi_9605_;
    phi_9612_ = _e397;
    if !(_e397) {
        let _e400 = pos_23[1u];
        phi_9612_ = (_e400 < 1i);
    }
    let _e403 = phi_9612_;
    phi_9623_ = _e403;
    if !(_e403) {
        let _e406 = pos_23[1u];
        let _e408 = tuning.gridHeight;
        phi_9623_ = (_e406 >= (bitcast<i32>(_e408) - 1i));
    }
    let _e413 = phi_9623_;
    phi_9630_ = _e413;
    if !(_e413) {
        let _e416 = pos_23[2u];
        phi_9630_ = (_e416 < 1i);
    }
    let _e419 = phi_9630_;
    phi_9641_ = _e419;
    if !(_e419) {
        let _e422 = pos_23[2u];
        let _e424 = tuning.gridDepth;
        phi_9641_ = (_e422 >= (bitcast<i32>(_e424) - 1i));
    }
    let _e429 = phi_9641_;
    if _e429 {
        return;
    }
    let _e430 = pos_23;
    param_996 = _e430;
    let _e431 = getIndex_u0028_vi3_u003b((&param_996));
    currentIndex_15 = _e431;
    let _e432 = currentIndex_15;
    param_997 = _e432;
    let _e433 = readCell_u0028_u1_u003b((&param_997));
    rawValue_13 = _e433;
    let _e434 = rawValue_13;
    param_998 = _e434;
    let _e435 = getType_u0028_u1_u003b((&param_998));
    currentType_1 = _e435;
    let _e436 = currentType_1;
    let _e437 = (_e436 == 0u);
    phi_9664_ = _e437;
    if _e437 {
        let _e439 = unnamed_2.rainPhase;
        phi_9664_ = (_e439 >= 1u);
    }
    let _e442 = phi_9664_;
    phi_9674_ = _e442;
    if _e442 {
        let _e444 = pos_23[1u];
        let _e446 = tuning.gridHeight;
        phi_9674_ = (_e444 == (bitcast<i32>(_e446) - 2i));
    }
    let _e451 = phi_9674_;
    if _e451 {
        let _e453 = pos_23[0u];
        param_999 = _e453;
        let _e455 = pos_23[2u];
        param_1000 = _e455;
        let _e456 = cloudColumnBase_u0028_i1_u003b_i1_u003b((&param_999), (&param_1000));
        let _e460 = atomicLoad((&unnamed_2.cloudColumn[(_e456 + 2u)]));
        if (_e460 != 0u) {
            let _e463 = atomicAdd((&unnamed_2.rainCandidateCount), 1u);
        }
    }
    let _e464 = currentType_1;
    if (_e464 == 0u) {
        return;
    }
    let _e467 = pos_23[1u];
    let _e470 = atomicLoad((&unnamed_2.maxOccupiedY));
    if (bitcast<u32>(_e467) > _e470) {
        let _e474 = pos_23[1u];
        let _e476 = atomicMax((&unnamed_2.maxOccupiedY), bitcast<u32>(_e474));
    }
    let _e477 = pos_23;
    let _e480 = pc.time;
    param_1001 = (vec3<f32>(_e477) + vec3(_e480));
    let _e483 = hash_u0028_vf3_u003b((&param_1001));
    randVal_15 = _e483;
    let _e484 = currentType_1;
    let _e485 = (_e484 != 7u);
    phi_9732_ = _e485;
    if _e485 {
        let _e486 = pos_23;
        param_1002 = _e486;
        let _e487 = currentIndex_15;
        param_1003 = _e487;
        let _e488 = rawValue_13;
        param_1004 = _e488;
        let _e489 = randVal_15;
        param_1005 = _e489;
        let _e490 = captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1002), (&param_1003), (&param_1004), (&param_1005));
        phi_9732_ = _e490;
    }
    let _e492 = phi_9732_;
    if _e492 {
        return;
    }
    let _e493 = currentType_1;
    let _e495 = currentType_1;
    if ((_e493 == 3u) || (_e495 == 7u)) {
        return;
    }
    let _e498 = rawValue_13;
    param_1006 = _e498;
    let _e499 = getDir_u0028_u1_u003b((&param_1006));
    currentDir_6 = _e499;
    let _e500 = rawValue_13;
    param_1007 = _e500;
    let _e501 = getSleep_u0028_u1_u003b((&param_1007));
    currentSleep_7 = _e501;
    let _e502 = rawValue_13;
    param_1008 = _e502;
    let _e503 = getAge_u0028_u1_u003b((&param_1008));
    currentAge_10 = _e503;
    let _e504 = currentType_1;
    switch bitcast<i32>(_e504) {
        case 1: {
            let _e506 = pos_23;
            param_1009 = _e506;
            let _e507 = currentIndex_15;
            param_1010 = _e507;
            let _e508 = rawValue_13;
            param_1011 = _e508;
            let _e509 = currentSleep_7;
            param_1012 = _e509;
            let _e510 = currentAge_10;
            param_1013 = _e510;
            let _e511 = randVal_15;
            param_1014 = _e511;
            updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1009), (&param_1010), (&param_1011), (&param_1012), (&param_1013), (&param_1014));
            break;
        }
        case 2: {
            let _e512 = pos_23;
            param_1015 = _e512;
            let _e513 = currentIndex_15;
            param_1016 = _e513;
            let _e514 = rawValue_13;
            param_1017 = _e514;
            let _e515 = currentDir_6;
            param_1018 = _e515;
            let _e516 = currentSleep_7;
            param_1019 = _e516;
            let _e517 = currentAge_10;
            param_1020 = _e517;
            let _e518 = randVal_15;
            param_1021 = _e518;
            updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1015), (&param_1016), (&param_1017), (&param_1018), (&param_1019), (&param_1020), (&param_1021));
            break;
        }
        case 4: {
            let _e519 = pos_23;
            param_1022 = _e519;
            let _e520 = currentIndex_15;
            param_1023 = _e520;
            let _e521 = rawValue_13;
            param_1024 = _e521;
            let _e522 = currentDir_6;
            param_1025 = _e522;
            let _e523 = currentSleep_7;
            param_1026 = _e523;
            let _e524 = currentAge_10;
            param_1027 = _e524;
            let _e525 = randVal_15;
            param_1028 = _e525;
            updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1022), (&param_1023), (&param_1024), (&param_1025), (&param_1026), (&param_1027), (&param_1028));
            break;
        }
        case 5: {
            let _e526 = pos_23;
            param_1029 = _e526;
            let _e527 = currentIndex_15;
            param_1030 = _e527;
            let _e528 = rawValue_13;
            param_1031 = _e528;
            let _e529 = currentDir_6;
            param_1032 = _e529;
            let _e530 = currentSleep_7;
            param_1033 = _e530;
            let _e531 = currentAge_10;
            param_1034 = _e531;
            let _e532 = randVal_15;
            param_1035 = _e532;
            updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1029), (&param_1030), (&param_1031), (&param_1032), (&param_1033), (&param_1034), (&param_1035));
            break;
        }
        case 6: {
            let _e533 = pos_23;
            param_1036 = _e533;
            let _e534 = currentIndex_15;
            param_1037 = _e534;
            let _e535 = rawValue_13;
            param_1038 = _e535;
            let _e536 = currentSleep_7;
            param_1039 = _e536;
            let _e537 = currentAge_10;
            param_1040 = _e537;
            let _e538 = randVal_15;
            param_1041 = _e538;
            updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1036), (&param_1037), (&param_1038), (&param_1039), (&param_1040), (&param_1041));
            break;
        }
        case 9, 10, 11, 8: {
            let _e539 = pos_23;
            param_1042 = _e539;
            let _e540 = currentIndex_15;
            param_1043 = _e540;
            let _e541 = rawValue_13;
            param_1044 = _e541;
            let _e542 = currentDir_6;
            param_1045 = _e542;
            let _e543 = currentSleep_7;
            param_1046 = _e543;
            let _e544 = currentAge_10;
            param_1047 = _e544;
            let _e545 = randVal_15;
            param_1048 = _e545;
            updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1042), (&param_1043), (&param_1044), (&param_1045), (&param_1046), (&param_1047), (&param_1048));
            break;
        }
        case 12: {
            let _e546 = pos_23;
            param_1049 = _e546;
            let _e547 = currentIndex_15;
            param_1050 = _e547;
            let _e548 = rawValue_13;
            param_1051 = _e548;
            let _e549 = currentAge_10;
            param_1052 = _e549;
            let _e550 = randVal_15;
            param_1053 = _e550;
            updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1049), (&param_1050), (&param_1051), (&param_1052), (&param_1053));
            break;
        }
        case 14, 15, 16, 17, 13: {
            let _e551 = pos_23;
            param_1054 = _e551;
            let _e552 = currentIndex_15;
            param_1055 = _e552;
            let _e553 = rawValue_13;
            param_1056 = _e553;
            let _e554 = currentDir_6;
            param_1057 = _e554;
            let _e555 = currentSleep_7;
            param_1058 = _e555;
            let _e556 = currentAge_10;
            param_1059 = _e556;
            let _e557 = randVal_15;
            param_1060 = _e557;
            updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1054), (&param_1055), (&param_1056), (&param_1057), (&param_1058), (&param_1059), (&param_1060));
            break;
        }
        case 18: {
            let _e558 = pos_23;
            param_1061 = _e558;
            let _e559 = currentIndex_15;
            param_1062 = _e559;
            let _e560 = rawValue_13;
            param_1063 = _e560;
            let _e561 = currentDir_6;
            param_1064 = _e561;
            let _e562 = currentAge_10;
            param_1065 = _e562;
            let _e563 = randVal_15;
            param_1066 = _e563;
            updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1061), (&param_1062), (&param_1063), (&param_1064), (&param_1065), (&param_1066));
            break;
        }
        case 19: {
            let _e564 = pos_23;
            param_1067 = _e564;
            let _e565 = currentIndex_15;
            param_1068 = _e565;
            let _e566 = rawValue_13;
            param_1069 = _e566;
            let _e567 = currentAge_10;
            param_1070 = _e567;
            let _e568 = randVal_15;
            param_1071 = _e568;
            updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_1067), (&param_1068), (&param_1069), (&param_1070), (&param_1071));
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
