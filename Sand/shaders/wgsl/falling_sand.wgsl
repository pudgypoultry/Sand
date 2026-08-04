// GENERATED FILE -- DO NOT EDIT.
//
// Translated from falling_sand.comp by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit falling_sand.comp and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 40e92c737c6353d97a7e3563703ca7dce3f1e337044405c41c3aec350763aed3

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
    blackHoleCount: u32,
    maxOccupiedY: u32,
    blackHoles: array<u32, 8>,
    blackHoleMass: array<u32, 8>,
    blackHoleStarve: array<u32, 8>,
    cloudCache: array<f32, 448>,
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
}

struct VoxelGrid_1 {
    grid: array<atomic<u32>>,
}

struct SimStats_1 {
    waterVoxelCount: atomic<u32>,
    waterHighMark: atomic<u32>,
    cloudWaterCount: atomic<u32>,
    rainPhase: u32,
    rainPhaseTimeBits: u32,
    rainTargetLevel: u32,
    rainCandidateCount: atomic<u32>,
    rainCandidateEstimate: u32,
    cloudChargeBits: u32,
    blackHoleCount: u32,
    maxOccupiedY: atomic<u32>,
    blackHoles: array<atomic<u32>, 8>,
    blackHoleMass: array<atomic<u32>, 8>,
    blackHoleStarve: array<u32, 8>,
    cloudCache: array<f32, 448>,
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

fn getAge_u0028_u1_u003b(val: ptr<function, u32>) -> u32 {
    let _e206 = (*val);
    return ((_e206 >> bitcast<u32>(24i)) & 255u);
}

fn getDir_u0028_u1_u003b(val_1: ptr<function, u32>) -> u32 {
    let _e206 = (*val_1);
    return ((_e206 >> bitcast<u32>(8i)) & 255u);
}

fn getType_u0028_u1_u003b(val_2: ptr<function, u32>) -> u32 {
    let _e206 = (*val_2);
    return (_e206 & 255u);
}

fn tree26_u0028_i1_u003b(i: ptr<function, i32>) -> vec3<i32> {
    var j: i32;
    var local: i32;

    let _e208 = (*i);
    if (_e208 >= 13i) {
        let _e210 = (*i);
        local = (_e210 + 1i);
    } else {
        let _e212 = (*i);
        local = _e212;
    }
    let _e213 = local;
    j = _e213;
    let _e214 = j;
    let _e222 = j;
    let _e223 = (_e222 / 3i);
    let _e231 = j;
    return (vec3<i32>((_e214 - (i32(floor((f32(_e214) / f32(3i)))) * 3i)), (_e223 - (i32(floor((f32(_e223) / f32(3i)))) * 3i)), (_e231 / 9i)) - vec3<i32>(1i, 1i, 1i));
}

fn readCell_u0028_u1_u003b(index: ptr<function, u32>) -> u32 {
    let _e206 = (*index);
    let _e209 = atomicLoad((&unnamed.grid[_e206]));
    return _e209;
}

fn tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex: ptr<function, u32>, currentValue: ptr<function, u32>, targetIndex: ptr<function, u32>, newValue: ptr<function, u32>) -> bool {
    var targetValue: u32;
    var param: u32;
    var targetType: u32;
    var param_1: u32;
    var currentType: u32;
    var param_2: u32;
    var actual: u32;
    var phi_1818_: bool;
    var phi_1827_: bool;

    let _e216 = (*targetIndex);
    param = _e216;
    let _e217 = readCell_u0028_u1_u003b((&param));
    targetValue = _e217;
    let _e218 = targetValue;
    param_1 = _e218;
    let _e219 = getType_u0028_u1_u003b((&param_1));
    targetType = _e219;
    let _e220 = (*currentValue);
    param_2 = _e220;
    let _e221 = getType_u0028_u1_u003b((&param_2));
    currentType = _e221;
    let _e222 = targetType;
    let _e223 = (_e222 == 0u);
    phi_1818_ = _e223;
    if !(_e223) {
        let _e225 = currentType;
        let _e227 = currentType;
        let _e230 = targetType;
        phi_1818_ = (((_e225 == 1u) || (_e227 == 4u)) && (_e230 == 2u));
    }
    let _e234 = phi_1818_;
    phi_1827_ = _e234;
    if !(_e234) {
        let _e236 = currentType;
        let _e238 = targetType;
        phi_1827_ = ((_e236 == 6u) && (_e238 == 5u));
    }
    let _e242 = phi_1827_;
    if _e242 {
        let _e243 = (*currentIndex);
        let _e246 = (*currentValue);
        let _e247 = atomicCompareExchangeWeak((&unnamed.grid[_e243]), _e246, 0u);
        let _e249 = (*currentValue);
        if (_e247.old_value == _e249) {
            let _e251 = (*targetIndex);
            let _e254 = targetValue;
            let _e255 = (*newValue);
            let _e256 = atomicCompareExchangeWeak((&unnamed.grid[_e251]), _e254, _e255);
            actual = _e256.old_value;
            let _e258 = actual;
            let _e259 = targetValue;
            if (_e258 == _e259) {
                let _e261 = targetType;
                if (_e261 != 0u) {
                    let _e263 = (*currentIndex);
                    let _e266 = targetValue;
                    let _e267 = atomicExchange((&unnamed.grid[_e263]), _e266);
                }
                return true;
            } else {
                let _e268 = (*currentIndex);
                let _e271 = (*currentValue);
                let _e272 = atomicCompareExchangeWeak((&unnamed.grid[_e268]), 0u, _e271);
            }
        }
    }
    return false;
}

fn pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(type_35: ptr<function, u32>, dir: ptr<function, u32>, sleep: ptr<function, u32>, age: ptr<function, u32>) -> u32 {
    let _e209 = (*type_35);
    let _e211 = (*dir);
    let _e216 = (*sleep);
    let _e221 = (*age);
    return ((((_e209 & 255u) | ((_e211 & 255u) << bitcast<u32>(8i))) | ((_e216 & 255u) << bitcast<u32>(16i))) | ((_e221 & 255u) << bitcast<u32>(24i)));
}

fn getIndex_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    let _e207 = (*pos)[0u];
    let _e209 = (*pos)[1u];
    let _e211 = tuning.gridWidth;
    let _e216 = (*pos)[2u];
    let _e218 = tuning.gridWidth;
    let _e222 = tuning.gridHeight;
    return bitcast<u32>(((_e207 + (_e209 * bitcast<i32>(_e211))) + ((_e216 * bitcast<i32>(_e218)) * bitcast<i32>(_e222))));
}

fn treeInBounds_u0028_vi3_u003b(p: ptr<function, vec3<i32>>) -> bool {
    var phi_977_: bool;
    var phi_983_: bool;
    var phi_993_: bool;
    var phi_999_: bool;
    var phi_1009_: bool;

    let _e207 = (*p)[0u];
    let _e208 = (_e207 > 0i);
    phi_977_ = _e208;
    if _e208 {
        let _e210 = (*p)[0u];
        let _e212 = tuning.gridWidth;
        phi_977_ = (_e210 < (bitcast<i32>(_e212) - 1i));
    }
    let _e217 = phi_977_;
    phi_983_ = _e217;
    if _e217 {
        let _e219 = (*p)[1u];
        phi_983_ = (_e219 > 0i);
    }
    let _e222 = phi_983_;
    phi_993_ = _e222;
    if _e222 {
        let _e224 = (*p)[1u];
        let _e226 = tuning.gridHeight;
        phi_993_ = (_e224 < (bitcast<i32>(_e226) - 1i));
    }
    let _e231 = phi_993_;
    phi_999_ = _e231;
    if _e231 {
        let _e233 = (*p)[2u];
        phi_999_ = (_e233 > 0i);
    }
    let _e236 = phi_999_;
    phi_1009_ = _e236;
    if _e236 {
        let _e238 = (*p)[2u];
        let _e240 = tuning.gridDepth;
        phi_1009_ = (_e238 < (bitcast<i32>(_e240) - 1i));
    }
    let _e245 = phi_1009_;
    return _e245;
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
    var phi_6941_: bool;
    var phi_7025_: bool;
    var phi_7107_: bool;

    let _e256 = (*randVal);
    let _e260 = tuning.treeLeafTickChance;
    if (fract((_e256 * 7f)) >= _e260) {
        return;
    }
    let _e262 = (*currentAge);
    if (_e262 == 255u) {
        let _e264 = (*pos_1);
        belowPos = (_e264 + vec3<i32>(0i, -1i, 0i));
        let _e266 = belowPos;
        param_3 = _e266;
        let _e267 = treeInBounds_u0028_vi3_u003b((&param_3));
        phi_6941_ = _e267;
        if _e267 {
            let _e268 = belowPos;
            param_4 = _e268;
            let _e269 = getIndex_u0028_vi3_u003b((&param_4));
            param_5 = _e269;
            let _e270 = readCell_u0028_u1_u003b((&param_5));
            phi_6941_ = (_e270 == 0u);
        }
        let _e273 = phi_6941_;
        if _e273 {
            let _e274 = belowPos;
            param_6 = _e274;
            let _e275 = getIndex_u0028_vi3_u003b((&param_6));
            param_7 = 19u;
            param_8 = 0u;
            param_9 = 0u;
            param_10 = 255u;
            let _e276 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_7), (&param_8), (&param_9), (&param_10));
            let _e277 = (*currentIndex_1);
            param_11 = _e277;
            let _e278 = (*rawValue);
            param_12 = _e278;
            param_13 = _e275;
            param_14 = _e276;
            let _e279 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_11), (&param_12), (&param_13), (&param_14));
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
    let _e292 = (*pos_1);
    spot = _e292;
    i_1 = 0i;
    loop {
        let _e293 = i_1;
        if (_e293 < 26i) {
            let _e295 = (*pos_1);
            let _e296 = start;
            let _e297 = i_1;
            let _e298 = (_e296 + _e297);
            param_15 = (_e298 - (i32(floor((f32(_e298) / f32(26i)))) * 26i));
            let _e306 = tree26_u0028_i1_u003b((&param_15));
            c = (_e295 + _e306);
            let _e308 = c;
            param_16 = _e308;
            let _e309 = treeInBounds_u0028_vi3_u003b((&param_16));
            if !(_e309) {
                continue;
            }
            let _e311 = c;
            param_17 = _e311;
            let _e312 = getIndex_u0028_vi3_u003b((&param_17));
            param_18 = _e312;
            let _e313 = readCell_u0028_u1_u003b((&param_18));
            v = _e313;
            let _e314 = v;
            param_19 = _e314;
            let _e315 = getType_u0028_u1_u003b((&param_19));
            t = _e315;
            let _e316 = t;
            let _e317 = (_e316 == 18u);
            phi_7025_ = _e317;
            if _e317 {
                let _e318 = v;
                param_20 = _e318;
                let _e319 = getDir_u0028_u1_u003b((&param_20));
                let _e322 = tuning.treeMaxHeight;
                phi_7025_ = ((_e319 + 1u) >= _e322);
            }
            let _e325 = phi_7025_;
            if _e325 {
                touchesTrunk = true;
            } else {
                let _e326 = t;
                if (_e326 == 19u) {
                    let _e328 = nearest;
                    let _e329 = v;
                    param_21 = _e329;
                    let _e330 = getAge_u0028_u1_u003b((&param_21));
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
            param_22 = 19u;
            param_23 = 0u;
            param_24 = 0u;
            param_25 = 255u;
            let _e361 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_22), (&param_23), (&param_24), (&param_25));
            let _e362 = atomicCompareExchangeWeak((&unnamed.grid[_e357]), _e360, _e361);
        }
        return;
    }
    let _e364 = supported;
    let _e366 = tuning.treeLeafReach;
    let _e368 = haveSpot;
    let _e369 = ((_e364 < _e366) && _e368);
    phi_7107_ = _e369;
    if _e369 {
        let _e370 = (*randVal);
        let _e374 = tuning.treeLeafSpreadChance;
        phi_7107_ = (fract((_e370 * 89f)) < _e374);
    }
    let _e377 = phi_7107_;
    if _e377 {
        let _e378 = spot;
        param_26 = _e378;
        let _e379 = getIndex_u0028_vi3_u003b((&param_26));
        let _e382 = supported;
        param_27 = 19u;
        param_28 = 0u;
        param_29 = 0u;
        param_30 = (_e382 + 1u);
        let _e384 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_27), (&param_28), (&param_29), (&param_30));
        let _e385 = atomicCompareExchangeWeak((&unnamed.grid[_e379]), 0u, _e384);
    }
    let _e387 = supported;
    let _e388 = dist;
    if (_e387 != _e388) {
        let _e390 = (*currentIndex_1);
        let _e393 = (*rawValue);
        param_31 = 19u;
        param_32 = 0u;
        param_33 = 0u;
        let _e394 = supported;
        param_34 = _e394;
        let _e395 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_31), (&param_32), (&param_33), (&param_34));
        let _e396 = atomicCompareExchangeWeak((&unnamed.grid[_e390]), _e393, _e395);
    }
    return;
}

fn isGrassBlock_u0028_u1_u003b(value: ptr<function, u32>) -> bool {
    var flora: u32;
    var param_35: u32;

    let _e208 = (*value);
    flora = ((_e208 >> bitcast<u32>(8i)) & 255u);
    let _e212 = (*value);
    param_35 = _e212;
    let _e213 = getType_u0028_u1_u003b((&param_35));
    let _e215 = flora;
    let _e218 = flora;
    return (((_e213 == 4u) && (_e215 > 10u)) && (_e218 <= 100u));
}

fn getSleep_u0028_u1_u003b(val_3: ptr<function, u32>) -> u32 {
    let _e206 = (*val_3);
    return ((_e206 >> bitcast<u32>(16i)) & 255u);
}

fn getHDir_u0028_i1_u003b(d: ptr<function, i32>) -> vec3<i32> {
    let _e206 = (*d);
    if (_e206 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e208 = (*d);
    if (_e208 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e210 = (*d);
    if (_e210 == 2i) {
        return vec3<i32>(0i, 0i, 1i);
    }
    let _e212 = (*d);
    if (_e212 == 3i) {
        return vec3<i32>(0i, 0i, -1i);
    }
    let _e214 = (*d);
    if (_e214 == 4i) {
        return vec3<i32>(1i, 0i, 1i);
    }
    let _e216 = (*d);
    if (_e216 == 5i) {
        return vec3<i32>(1i, 0i, -1i);
    }
    let _e218 = (*d);
    if (_e218 == 6i) {
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
    var phi_6496_: bool;
    var phi_6640_: bool;
    var phi_6650_: bool;
    var phi_6695_: bool;
    var phi_6746_: bool;
    var phi_6825_: bool;

    let _e291 = (*currentDir);
    height = _e291;
    let _e292 = (*currentAge_1);
    water = _e292;
    changed = false;
    let _e293 = water;
    let _e295 = tuning.treeWaterMax;
    let _e296 = (_e293 < _e295);
    phi_6496_ = _e296;
    if _e296 {
        let _e297 = (*randVal_1);
        let _e301 = tuning.treeDrinkChance;
        phi_6496_ = (fract((_e297 * 13f)) < _e301);
    }
    let _e304 = phi_6496_;
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
                    let _e324 = (*pos_2);
                    local_3 = (_e324 + vec3<i32>(0i, -1i, 0i));
                } else {
                    let _e326 = i_2;
                    if (_e326 < 9i) {
                        let _e328 = (*pos_2);
                        let _e329 = i_2;
                        param_36 = (_e329 - 1i);
                        let _e331 = getHDir_u0028_i1_u003b((&param_36));
                        local_4 = ((_e328 + _e331) + vec3<i32>(0i, -1i, 0i));
                    } else {
                        let _e334 = (*pos_2);
                        let _e335 = i_2;
                        param_37 = (_e335 - 9i);
                        let _e337 = getHDir_u0028_i1_u003b((&param_37));
                        local_4 = (_e334 + _e337);
                    }
                    let _e339 = local_4;
                    local_3 = _e339;
                }
                let _e340 = local_3;
                c_1 = _e340;
                let _e341 = c_1;
                param_38 = _e341;
                let _e342 = treeInBounds_u0028_vi3_u003b((&param_38));
                if !(_e342) {
                    continue;
                }
                let _e344 = c_1;
                param_39 = _e344;
                let _e345 = getIndex_u0028_vi3_u003b((&param_39));
                idx = _e345;
                let _e346 = idx;
                param_40 = _e346;
                let _e347 = readCell_u0028_u1_u003b((&param_40));
                v_1 = _e347;
                let _e348 = v_1;
                param_41 = _e348;
                let _e349 = getType_u0028_u1_u003b((&param_41));
                if (_e349 != 4u) {
                    continue;
                }
                let _e351 = v_1;
                param_42 = _e351;
                let _e352 = getAge_u0028_u1_u003b((&param_42));
                moisture = _e352;
                let _e353 = moisture;
                let _e355 = tuning.treeSoilReserve;
                if (_e353 <= _e355) {
                    continue;
                }
                let _e357 = idx;
                let _e360 = v_1;
                let _e361 = v_1;
                param_43 = _e361;
                let _e362 = getDir_u0028_u1_u003b((&param_43));
                let _e363 = v_1;
                param_44 = _e363;
                let _e364 = getSleep_u0028_u1_u003b((&param_44));
                let _e365 = moisture;
                param_45 = 4u;
                param_46 = _e362;
                param_47 = _e364;
                param_48 = (_e365 - 1u);
                let _e367 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_45), (&param_46), (&param_47), (&param_48));
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
    let _e376 = (*pos_2);
    upPos = (_e376 + vec3<i32>(0i, 1i, 0i));
    upIsTrunk = false;
    upValue = 0u;
    upIndex = 0u;
    let _e378 = upPos;
    param_49 = _e378;
    let _e379 = treeInBounds_u0028_vi3_u003b((&param_49));
    if _e379 {
        let _e380 = upPos;
        param_50 = _e380;
        let _e381 = getIndex_u0028_vi3_u003b((&param_50));
        upIndex = _e381;
        let _e382 = upIndex;
        param_51 = _e382;
        let _e383 = readCell_u0028_u1_u003b((&param_51));
        upValue = _e383;
        let _e384 = upValue;
        param_52 = _e384;
        let _e385 = getType_u0028_u1_u003b((&param_52));
        upIsTrunk = (_e385 == 18u);
    }
    let _e387 = upIsTrunk;
    let _e388 = water;
    let _e390 = (_e387 && (_e388 > 0u));
    phi_6640_ = _e390;
    if _e390 {
        let _e391 = upValue;
        param_53 = _e391;
        let _e392 = getAge_u0028_u1_u003b((&param_53));
        phi_6640_ = (_e392 < 255u);
    }
    let _e395 = phi_6640_;
    phi_6650_ = _e395;
    if _e395 {
        let _e396 = (*randVal_1);
        let _e400 = tuning.treeFlowChance;
        phi_6650_ = (fract((_e396 * 29f)) < _e400);
    }
    let _e403 = phi_6650_;
    if _e403 {
        let _e404 = upValue;
        param_54 = _e404;
        let _e405 = getDir_u0028_u1_u003b((&param_54));
        let _e406 = upValue;
        param_55 = _e406;
        let _e407 = getAge_u0028_u1_u003b((&param_55));
        param_56 = 18u;
        param_57 = _e405;
        param_58 = 0u;
        param_59 = (_e407 + 1u);
        let _e409 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_56), (&param_57), (&param_58), (&param_59));
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
    let _e424 = tuning.treeMaxHeight;
    if ((_e421 + 1u) < _e424) {
        let _e426 = water;
        let _e428 = tuning.treeGrowCost;
        let _e429 = (_e426 >= _e428);
        phi_6695_ = _e429;
        if _e429 {
            let _e430 = upPos;
            param_60 = _e430;
            let _e431 = treeInBounds_u0028_vi3_u003b((&param_60));
            phi_6695_ = _e431;
        }
        let _e433 = phi_6695_;
        if _e433 {
            let _e434 = upValue;
            param_61 = _e434;
            let _e435 = getType_u0028_u1_u003b((&param_61));
            upType = _e435;
            let _e436 = upType;
            let _e438 = upType;
            if ((_e436 == 0u) || (_e438 == 19u)) {
                let _e441 = height;
                param_62 = 18u;
                param_63 = (_e441 + 1u);
                param_64 = 0u;
                param_65 = 0u;
                let _e443 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_62), (&param_63), (&param_64), (&param_65));
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
        phi_6746_ = _e460;
        if _e460 {
            let _e461 = (*randVal_1);
            let _e465 = tuning.treeLeafChance;
            phi_6746_ = (fract((_e461 * 37f)) < _e465);
        }
        let _e468 = phi_6746_;
        if _e468 {
            let _e469 = (*randVal_1);
            start_2 = i32((fract((_e469 * 43f)) * 26f));
            i_3 = 0i;
            loop {
                let _e474 = i_3;
                if (_e474 < 26i) {
                    let _e476 = (*pos_2);
                    let _e477 = start_2;
                    let _e478 = i_3;
                    let _e479 = (_e477 + _e478);
                    param_66 = (_e479 - (i32(floor((f32(_e479) / f32(26i)))) * 26i));
                    let _e487 = tree26_u0028_i1_u003b((&param_66));
                    c_2 = (_e476 + _e487);
                    let _e489 = c_2;
                    param_67 = _e489;
                    let _e490 = treeInBounds_u0028_vi3_u003b((&param_67));
                    if !(_e490) {
                        continue;
                    }
                    let _e492 = c_2;
                    param_68 = _e492;
                    let _e493 = getIndex_u0028_vi3_u003b((&param_68));
                    idx_1 = _e493;
                    let _e494 = idx_1;
                    param_69 = _e494;
                    let _e495 = readCell_u0028_u1_u003b((&param_69));
                    if (_e495 != 0u) {
                        continue;
                    }
                    let _e497 = idx_1;
                    param_70 = 19u;
                    param_71 = 0u;
                    param_72 = 0u;
                    param_73 = 1u;
                    let _e500 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_70), (&param_71), (&param_72), (&param_73));
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
    phi_6825_ = _e513;
    if _e513 {
        let _e514 = (*randVal_1);
        let _e518 = tuning.treeSpreadChance;
        phi_6825_ = (fract((_e514 * 59f)) < _e518);
    }
    let _e521 = phi_6825_;
    if _e521 {
        let _e522 = (*randVal_1);
        start_3 = i32((fract((_e522 * 61f)) * 8f));
        i_4 = 0i;
        loop {
            let _e527 = i_4;
            if (_e527 < 8i) {
                let _e529 = (*pos_2);
                let _e530 = start_3;
                let _e531 = i_4;
                let _e532 = (_e530 + _e531);
                param_74 = (_e532 - (i32(floor((f32(_e532) / f32(8i)))) * 8i));
                let _e540 = getHDir_u0028_i1_u003b((&param_74));
                c_3 = (_e529 + _e540);
                let _e542 = c_3;
                param_75 = _e542;
                let _e543 = treeInBounds_u0028_vi3_u003b((&param_75));
                if !(_e543) {
                    continue;
                }
                let _e545 = c_3;
                param_76 = _e545;
                let _e546 = getIndex_u0028_vi3_u003b((&param_76));
                idx_2 = _e546;
                let _e547 = idx_2;
                param_77 = _e547;
                let _e548 = readCell_u0028_u1_u003b((&param_77));
                if (_e548 != 0u) {
                    continue;
                }
                let _e550 = c_3;
                param_78 = (_e550 + vec3<i32>(0i, -1i, 0i));
                let _e552 = getIndex_u0028_vi3_u003b((&param_78));
                param_79 = _e552;
                let _e553 = readCell_u0028_u1_u003b((&param_79));
                param_80 = _e553;
                let _e554 = isGrassBlock_u0028_u1_u003b((&param_80));
                if !(_e554) {
                    continue;
                }
                let _e556 = idx_2;
                param_81 = 18u;
                param_82 = 0u;
                param_83 = 0u;
                param_84 = 0u;
                let _e559 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_81), (&param_82), (&param_83), (&param_84));
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
        param_85 = 18u;
        let _e574 = height;
        param_86 = _e574;
        param_87 = 0u;
        let _e575 = water;
        param_88 = _e575;
        let _e576 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_85), (&param_86), (&param_87), (&param_88));
        let _e577 = atomicCompareExchangeWeak((&unnamed.grid[_e570]), _e573, _e576);
    }
    return;
}

fn locustPackNav_u0028_u1_u003b_u1_u003b(heading: ptr<function, u32>, steps: ptr<function, u32>) -> u32 {
    let _e207 = (*heading);
    let _e209 = (*steps);
    return ((_e207 & 7u) | (min(_e209, 7u) << bitcast<u32>(3i)));
}

fn locustReverse_u0028_u1_u003b(d_1: ptr<function, u32>) -> u32 {
    let _e206 = (*d_1);
    if (_e206 == 0u) {
        return 1u;
    }
    let _e208 = (*d_1);
    if (_e208 == 1u) {
        return 0u;
    }
    let _e210 = (*d_1);
    if (_e210 == 2u) {
        return 3u;
    }
    let _e212 = (*d_1);
    if (_e212 == 3u) {
        return 2u;
    }
    let _e214 = (*d_1);
    if (_e214 == 4u) {
        return 7u;
    }
    let _e216 = (*d_1);
    if (_e216 == 5u) {
        return 6u;
    }
    let _e218 = (*d_1);
    if (_e218 == 6u) {
        return 5u;
    }
    return 4u;
}

fn locustRunSteps_u0028_() -> u32 {
    let _e206 = tuning.locustRunLength;
    return clamp(_e206, 1u, 7u);
}

fn isLocustFood_u0028_u1_u003b(value_1: ptr<function, u32>) -> bool {
    var param_89: u32;
    var param_90: u32;
    var phi_768_: bool;

    let _e208 = (*value_1);
    param_89 = _e208;
    let _e209 = isGrassBlock_u0028_u1_u003b((&param_89));
    phi_768_ = _e209;
    if !(_e209) {
        let _e211 = (*value_1);
        param_90 = _e211;
        let _e212 = getType_u0028_u1_u003b((&param_90));
        phi_768_ = (_e212 == 19u);
    }
    let _e215 = phi_768_;
    return _e215;
}

fn locustFoodAt_u0028_vi3_u003b(p_1: ptr<function, vec3<i32>>) -> bool {
    var param_91: vec3<i32>;
    var param_92: u32;
    var param_93: u32;
    var phi_783_: bool;
    var phi_790_: bool;
    var phi_800_: bool;
    var phi_807_: bool;
    var phi_817_: bool;

    let _e210 = (*p_1)[0u];
    let _e211 = (_e210 < 0i);
    phi_783_ = _e211;
    if !(_e211) {
        let _e214 = (*p_1)[0u];
        let _e216 = tuning.gridWidth;
        phi_783_ = (_e214 >= bitcast<i32>(_e216));
    }
    let _e220 = phi_783_;
    phi_790_ = _e220;
    if !(_e220) {
        let _e223 = (*p_1)[1u];
        phi_790_ = (_e223 < 0i);
    }
    let _e226 = phi_790_;
    phi_800_ = _e226;
    if !(_e226) {
        let _e229 = (*p_1)[1u];
        let _e231 = tuning.gridHeight;
        phi_800_ = (_e229 >= bitcast<i32>(_e231));
    }
    let _e235 = phi_800_;
    phi_807_ = _e235;
    if !(_e235) {
        let _e238 = (*p_1)[2u];
        phi_807_ = (_e238 < 0i);
    }
    let _e241 = phi_807_;
    phi_817_ = _e241;
    if !(_e241) {
        let _e244 = (*p_1)[2u];
        let _e246 = tuning.gridDepth;
        phi_817_ = (_e244 >= bitcast<i32>(_e246));
    }
    let _e250 = phi_817_;
    if _e250 {
        return false;
    }
    let _e251 = (*p_1);
    param_91 = _e251;
    let _e252 = getIndex_u0028_vi3_u003b((&param_91));
    param_92 = _e252;
    let _e253 = readCell_u0028_u1_u003b((&param_92));
    param_93 = _e253;
    let _e254 = isLocustFood_u0028_u1_u003b((&param_93));
    return _e254;
}

fn locustSteps_u0028_u1_u003b(dirByte: ptr<function, u32>) -> u32 {
    let _e206 = (*dirByte);
    return ((_e206 >> bitcast<u32>(3i)) & 7u);
}

fn locustHeading_u0028_u1_u003b(dirByte_1: ptr<function, u32>) -> u32 {
    let _e206 = (*dirByte_1);
    return (_e206 & 7u);
}

fn locustArriveDir_u0028_vi3_u003b_u1_u003b(dest: ptr<function, vec3<i32>>, nav: ptr<function, u32>) -> u32 {
    var param_94: vec3<i32>;

    let _e208 = (*dest);
    param_94 = (_e208 + vec3<i32>(0i, -1i, 0i));
    let _e210 = locustFoodAt_u0028_vi3_u003b((&param_94));
    let _e211 = (*nav);
    return select(_e211, 0u, _e210);
}

fn locustHasGrip_u0028_vi3_u003b(pos_3: ptr<function, vec3<i32>>) -> bool {
    var d_2: i32;
    var n: vec3<i32>;
    var param_95: i32;
    var param_96: vec3<i32>;
    var param_97: u32;
    var phi_921_: bool;
    var phi_928_: bool;
    var phi_939_: bool;

    d_2 = 0i;
    loop {
        let _e211 = d_2;
        if (_e211 < 8i) {
            let _e213 = (*pos_3);
            let _e214 = d_2;
            param_95 = _e214;
            let _e215 = getHDir_u0028_i1_u003b((&param_95));
            n = (_e213 + _e215);
            let _e218 = n[0u];
            let _e219 = (_e218 <= 0i);
            phi_921_ = _e219;
            if !(_e219) {
                let _e222 = n[0u];
                let _e224 = tuning.gridWidth;
                phi_921_ = (_e222 >= (bitcast<i32>(_e224) - 1i));
            }
            let _e229 = phi_921_;
            phi_928_ = _e229;
            if !(_e229) {
                let _e232 = n[2u];
                phi_928_ = (_e232 <= 0i);
            }
            let _e235 = phi_928_;
            phi_939_ = _e235;
            if !(_e235) {
                let _e238 = n[2u];
                let _e240 = tuning.gridDepth;
                phi_939_ = (_e238 >= (bitcast<i32>(_e240) - 1i));
            }
            let _e245 = phi_939_;
            if _e245 {
                continue;
            }
            let _e246 = n;
            param_96 = _e246;
            let _e247 = getIndex_u0028_vi3_u003b((&param_96));
            param_97 = _e247;
            let _e248 = readCell_u0028_u1_u003b((&param_97));
            if (_e248 != 0u) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e250 = d_2;
            d_2 = (_e250 + 1i);
        }
    }
    return false;
}

fn locustInBounds_u0028_vi3_u003b(p_2: ptr<function, vec3<i32>>) -> bool {
    var phi_704_: bool;
    var phi_710_: bool;
    var phi_720_: bool;
    var phi_726_: bool;
    var phi_736_: bool;

    let _e207 = (*p_2)[0u];
    let _e208 = (_e207 > 0i);
    phi_704_ = _e208;
    if _e208 {
        let _e210 = (*p_2)[0u];
        let _e212 = tuning.gridWidth;
        phi_704_ = (_e210 < (bitcast<i32>(_e212) - 1i));
    }
    let _e217 = phi_704_;
    phi_710_ = _e217;
    if _e217 {
        let _e219 = (*p_2)[1u];
        phi_710_ = (_e219 > 0i);
    }
    let _e222 = phi_710_;
    phi_720_ = _e222;
    if _e222 {
        let _e224 = (*p_2)[1u];
        let _e226 = tuning.gridHeight;
        phi_720_ = (_e224 < (bitcast<i32>(_e226) - 1i));
    }
    let _e231 = phi_720_;
    phi_726_ = _e231;
    if _e231 {
        let _e233 = (*p_2)[2u];
        phi_726_ = (_e233 > 0i);
    }
    let _e236 = phi_726_;
    phi_736_ = _e236;
    if _e236 {
        let _e238 = (*p_2)[2u];
        let _e240 = tuning.gridDepth;
        phi_736_ = (_e238 < (bitcast<i32>(_e240) - 1i));
    }
    let _e245 = phi_736_;
    return _e245;
}

fn locustStage_u0028_() -> u32 {
    let _e206 = tuning.locustStageSize;
    return max(_e206, 1u);
}

fn locustTypeFor_u0028_u1_u003b(count: ptr<function, u32>) -> u32 {
    var stage: u32;
    var local_5: u32;

    let _e208 = (*count);
    if (_e208 == 0u) {
        local_5 = 0u;
    } else {
        let _e210 = (*count);
        let _e212 = locustStage_u0028_();
        local_5 = ((_e210 - 1u) / _e212);
    }
    let _e214 = local_5;
    stage = _e214;
    let _e215 = stage;
    return (13u + min(_e215, 4u));
}

fn locustMaxCount_u0028_() -> u32 {
    let _e206 = tuning.locustMaxSize;
    return max(_e206, 1u);
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

    let _e223 = tuning.locustBudSize;
    let _e224 = locustMaxCount_u0028_();
    bud = clamp(_e223, 1u, _e224);
    let _e226 = (*randVal_2);
    start_4 = i32((fract((_e226 * 31f)) * 8f));
    i_5 = 0i;
    loop {
        let _e231 = i_5;
        if (_e231 < 8i) {
            let _e233 = start_4;
            let _e234 = i_5;
            let _e235 = (_e233 + _e234);
            d_3 = (_e235 - (i32(floor((f32(_e235) / f32(8i)))) * 8i));
            let _e243 = (*pos_4);
            let _e244 = d_3;
            param_98 = _e244;
            let _e245 = getHDir_u0028_i1_u003b((&param_98));
            c_4 = (_e243 + _e245);
            let _e247 = c_4;
            param_99 = _e247;
            let _e248 = locustInBounds_u0028_vi3_u003b((&param_99));
            if !(_e248) {
                continue;
            }
            let _e250 = c_4;
            param_100 = _e250;
            let _e251 = getIndex_u0028_vi3_u003b((&param_100));
            idx_3 = _e251;
            let _e252 = idx_3;
            param_101 = _e252;
            let _e253 = readCell_u0028_u1_u003b((&param_101));
            if (_e253 != 0u) {
                continue;
            }
            let _e255 = idx_3;
            let _e258 = bud;
            param_102 = _e258;
            let _e259 = locustTypeFor_u0028_u1_u003b((&param_102));
            param_103 = _e259;
            param_104 = 0u;
            param_105 = 0u;
            let _e260 = bud;
            param_106 = _e260;
            let _e261 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_103), (&param_104), (&param_105), (&param_106));
            let _e262 = atomicCompareExchangeWeak((&unnamed.grid[_e255]), 0u, _e261);
            if (_e262.old_value == 0u) {
                return;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e265 = i_5;
            i_5 = (_e265 + 1i);
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

    let _e212 = tuning.locustEatTicksMin;
    fast = _e212;
    let _e214 = tuning.locustEatTicksMax;
    slow = _e214;
    let _e215 = locustMaxCount_u0028_();
    cap = _e215;
    let _e216 = locustStage_u0028_();
    let _e217 = cap;
    floorCount = min(_e216, _e217);
    let _e219 = (*count_1);
    let _e220 = cap;
    if (_e219 >= _e220) {
        let _e222 = fast;
        return _e222;
    }
    let _e223 = (*count_1);
    let _e224 = floorCount;
    let _e226 = cap;
    let _e227 = floorCount;
    if ((_e223 <= _e224) || (_e226 == _e227)) {
        let _e230 = slow;
        return _e230;
    }
    let _e231 = (*count_1);
    let _e232 = floorCount;
    let _e235 = cap;
    let _e236 = floorCount;
    t_1 = (f32((_e231 - _e232)) / f32((_e235 - _e236)));
    let _e240 = slow;
    let _e242 = fast;
    let _e244 = t_1;
    return u32(round(mix(f32(_e240), f32(_e242), _e244)));
}

fn updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_5: ptr<function, vec3<i32>>, currentIndex_3: ptr<function, u32>, rawValue_2: ptr<function, u32>, currentDir_1: ptr<function, u32>, currentSleep: ptr<function, u32>, currentAge_2: ptr<function, u32>, randVal_3: ptr<function, f32>) {
    var type_36: u32;
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
    var phi_7406_: bool;
    var phi_7413_: bool;
    var phi_7574_: bool;
    var phi_7593_: bool;
    var phi_7622_: bool;
    var phi_7636_: bool;
    var phi_7638_: bool;
    var phi_7730_: bool;
    var phi_7779_: bool;

    let _e389 = (*rawValue_2);
    param_107 = _e389;
    let _e390 = getType_u0028_u1_u003b((&param_107));
    type_36 = _e390;
    let _e391 = (*currentSleep);
    phase = (_e391 + 1u);
    let _e393 = phase;
    let _e395 = tuning.locustTickDispatches;
    if (_e393 < _e395) {
        let _e397 = (*currentIndex_3);
        let _e400 = (*rawValue_2);
        let _e401 = type_36;
        param_108 = _e401;
        let _e402 = (*currentDir_1);
        param_109 = _e402;
        let _e403 = phase;
        param_110 = _e403;
        let _e404 = (*currentAge_2);
        param_111 = _e404;
        let _e405 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_108), (&param_109), (&param_110), (&param_111));
        let _e406 = atomicCompareExchangeWeak((&unnamed.grid[_e397]), _e400, _e405);
        return;
    }
    let _e408 = (*currentAge_2);
    count_2 = _e408;
    let _e409 = (*pos_5);
    belowPos_1 = (_e409 + vec3<i32>(0i, -1i, 0i));
    let _e411 = belowPos_1;
    param_112 = _e411;
    let _e412 = getIndex_u0028_vi3_u003b((&param_112));
    belowIndex = _e412;
    let _e413 = belowIndex;
    param_113 = _e413;
    let _e414 = readCell_u0028_u1_u003b((&param_113));
    belowValue = _e414;
    let _e415 = belowValue;
    param_114 = _e415;
    let _e416 = isLocustFood_u0028_u1_u003b((&param_114));
    if _e416 {
        let _e417 = belowValue;
        param_115 = _e417;
        let _e418 = getType_u0028_u1_u003b((&param_115));
        onLeaf = (_e418 == 19u);
        let _e420 = count_2;
        param_116 = _e420;
        let _e421 = locustEatTicks_u0028_u1_u003b((&param_116));
        need = _e421;
        let _e422 = (*currentDir_1);
        progress = (_e422 + 1u);
        let _e424 = progress;
        let _e425 = need;
        if (_e424 < _e425) {
            let _e427 = onLeaf;
            if !(_e427) {
                let _e429 = belowValue;
                flora_1 = ((_e429 >> bitcast<u32>(8i)) & 255u);
                let _e433 = need;
                bite = max((90u / max(_e433, 1u)), 1u);
                let _e437 = flora_1;
                let _e438 = bite;
                if (_e437 > (11u + _e438)) {
                    let _e441 = flora_1;
                    let _e442 = bite;
                    local_6 = (_e441 - _e442);
                } else {
                    local_6 = 11u;
                }
                let _e444 = local_6;
                thinned = _e444;
                let _e445 = belowIndex;
                let _e448 = belowValue;
                let _e449 = belowValue;
                param_117 = _e449;
                let _e450 = getSleep_u0028_u1_u003b((&param_117));
                let _e451 = belowValue;
                param_118 = _e451;
                let _e452 = getAge_u0028_u1_u003b((&param_118));
                param_119 = 4u;
                let _e453 = thinned;
                param_120 = _e453;
                param_121 = _e450;
                param_122 = _e452;
                let _e454 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_119), (&param_120), (&param_121), (&param_122));
                let _e455 = atomicCompareExchangeWeak((&unnamed.grid[_e445]), _e448, _e454);
            }
            let _e457 = (*currentIndex_3);
            let _e460 = (*rawValue_2);
            let _e461 = type_36;
            param_123 = _e461;
            let _e462 = progress;
            param_124 = _e462;
            param_125 = 0u;
            let _e463 = count_2;
            param_126 = _e463;
            let _e464 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_123), (&param_124), (&param_125), (&param_126));
            let _e465 = atomicCompareExchangeWeak((&unnamed.grid[_e457]), _e460, _e464);
            return;
        }
        let _e467 = onLeaf;
        if _e467 {
            local_7 = 0u;
        } else {
            let _e468 = belowValue;
            param_127 = _e468;
            let _e469 = getSleep_u0028_u1_u003b((&param_127));
            let _e470 = belowValue;
            param_128 = _e470;
            let _e471 = getAge_u0028_u1_u003b((&param_128));
            param_129 = 4u;
            param_130 = 0u;
            param_131 = _e469;
            param_132 = _e471;
            let _e472 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_129), (&param_130), (&param_131), (&param_132));
            local_7 = _e472;
        }
        let _e473 = local_7;
        stripped = _e473;
        let _e474 = belowIndex;
        let _e477 = belowValue;
        let _e478 = stripped;
        let _e479 = atomicCompareExchangeWeak((&unnamed.grid[_e474]), _e477, _e478);
        let _e481 = belowValue;
        if (_e479.old_value != _e481) {
            return;
        }
        let _e483 = count_2;
        let _e485 = tuning.locustEatGain;
        grown = (_e483 + _e485);
        let _e487 = grown;
        let _e488 = locustMaxCount_u0028_();
        if (_e487 > _e488) {
            let _e490 = (*pos_5);
            param_133 = _e490;
            let _e491 = (*randVal_3);
            param_134 = _e491;
            locustBud_u0028_vi3_u003b_f1_u003b((&param_133), (&param_134));
            let _e492 = locustMaxCount_u0028_();
            grown = _e492;
        }
        let _e493 = (*currentIndex_3);
        let _e496 = (*rawValue_2);
        let _e497 = grown;
        param_135 = _e497;
        let _e498 = locustTypeFor_u0028_u1_u003b((&param_135));
        param_136 = _e498;
        param_137 = 0u;
        param_138 = 0u;
        let _e499 = grown;
        param_139 = _e499;
        let _e500 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_136), (&param_137), (&param_138), (&param_139));
        let _e501 = atomicCompareExchangeWeak((&unnamed.grid[_e493]), _e496, _e500);
        return;
    }
    let _e503 = count_2;
    if (_e503 <= 1u) {
        let _e505 = (*currentIndex_3);
        let _e508 = (*rawValue_2);
        let _e509 = atomicCompareExchangeWeak((&unnamed.grid[_e505]), _e508, 0u);
        return;
    }
    let _e511 = count_2;
    count_2 = (_e511 - 1u);
    let _e513 = count_2;
    param_140 = _e513;
    let _e514 = locustTypeFor_u0028_u1_u003b((&param_140));
    newType = _e514;
    let _e515 = belowValue;
    param_141 = _e515;
    let _e516 = getType_u0028_u1_u003b((&param_141));
    let _e517 = (_e516 == 0u);
    phi_7406_ = _e517;
    if _e517 {
        let _e518 = belowPos_1;
        param_142 = _e518;
        let _e519 = locustInBounds_u0028_vi3_u003b((&param_142));
        phi_7406_ = _e519;
    }
    let _e521 = phi_7406_;
    phi_7413_ = _e521;
    if _e521 {
        let _e522 = (*pos_5);
        param_143 = _e522;
        let _e523 = locustHasGrip_u0028_vi3_u003b((&param_143));
        phi_7413_ = !(_e523);
    }
    let _e526 = phi_7413_;
    if _e526 {
        let _e527 = belowPos_1;
        param_144 = _e527;
        let _e528 = (*currentDir_1);
        param_145 = _e528;
        let _e529 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_144), (&param_145));
        let _e530 = newType;
        param_146 = _e530;
        param_147 = _e529;
        param_148 = 0u;
        let _e531 = count_2;
        param_149 = _e531;
        let _e532 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_146), (&param_147), (&param_148), (&param_149));
        let _e533 = (*currentIndex_3);
        param_150 = _e533;
        let _e534 = (*rawValue_2);
        param_151 = _e534;
        let _e535 = belowIndex;
        param_152 = _e535;
        param_153 = _e532;
        let _e536 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_150), (&param_151), (&param_152), (&param_153));
        if _e536 {
            return;
        }
    }
    let _e537 = (*currentDir_1);
    param_154 = _e537;
    let _e538 = locustHeading_u0028_u1_u003b((&param_154));
    heading_1 = _e538;
    let _e539 = (*currentDir_1);
    param_155 = _e539;
    let _e540 = locustSteps_u0028_u1_u003b((&param_155));
    steps_1 = _e540;
    let _e541 = steps_1;
    if (_e541 == 0u) {
        let _e543 = (*randVal_3);
        start_5 = i32((fract((_e543 * 17f)) * 8f));
        i_6 = 0i;
        loop {
            let _e548 = i_6;
            if (_e548 < 8i) {
                let _e550 = start_5;
                let _e551 = i_6;
                let _e552 = (_e550 + _e551);
                d_4 = (_e552 - (i32(floor((f32(_e552) / f32(8i)))) * 8i));
                let _e560 = (*pos_5);
                let _e561 = d_4;
                param_156 = _e561;
                let _e562 = getHDir_u0028_i1_u003b((&param_156));
                c_5 = (_e560 + _e562);
                rise = 0i;
                loop {
                    let _e564 = rise;
                    if (_e564 < 3i) {
                        let _e566 = c_5;
                        let _e567 = rise;
                        if (_e567 == 1i) {
                            local_8 = 1i;
                        } else {
                            let _e569 = rise;
                            local_8 = select(0i, -1i, (_e569 == 2i));
                        }
                        let _e572 = local_8;
                        t_2 = (_e566 + vec3<i32>(0i, _e572, 0i));
                        let _e575 = t_2;
                        param_157 = _e575;
                        let _e576 = locustInBounds_u0028_vi3_u003b((&param_157));
                        if !(_e576) {
                            continue;
                        }
                        let _e578 = t_2;
                        param_158 = _e578;
                        let _e579 = getIndex_u0028_vi3_u003b((&param_158));
                        param_159 = _e579;
                        let _e580 = readCell_u0028_u1_u003b((&param_159));
                        if (_e580 != 0u) {
                            continue;
                        }
                        let _e582 = t_2;
                        param_160 = (_e582 + vec3<i32>(0i, -1i, 0i));
                        let _e584 = locustFoodAt_u0028_vi3_u003b((&param_160));
                        if !(_e584) {
                            continue;
                        }
                        let _e586 = t_2;
                        param_161 = _e586;
                        let _e587 = getIndex_u0028_vi3_u003b((&param_161));
                        let _e588 = newType;
                        param_162 = _e588;
                        param_163 = 0u;
                        param_164 = 0u;
                        let _e589 = count_2;
                        param_165 = _e589;
                        let _e590 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_162), (&param_163), (&param_164), (&param_165));
                        let _e591 = (*currentIndex_3);
                        param_166 = _e591;
                        let _e592 = (*rawValue_2);
                        param_167 = _e592;
                        param_168 = _e587;
                        param_169 = _e590;
                        let _e593 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_166), (&param_167), (&param_168), (&param_169));
                        if _e593 {
                            return;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e594 = rise;
                        rise = (_e594 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e596 = i_6;
                i_6 = (_e596 + 1i);
            }
        }
        let _e598 = (*randVal_3);
        heading_1 = (u32((fract((_e598 * 23f)) * 8f)) & 7u);
        let _e604 = locustRunSteps_u0028_();
        steps_1 = _e604;
    }
    let _e605 = (*pos_5);
    let _e606 = heading_1;
    param_170 = bitcast<i32>(_e606);
    let _e608 = getHDir_u0028_i1_u003b((&param_170));
    target_ = (_e605 + _e608);
    let _e610 = target_;
    param_171 = _e610;
    let _e611 = locustInBounds_u0028_vi3_u003b((&param_171));
    let _e612 = !(_e611);
    phi_7574_ = _e612;
    if !(_e612) {
        let _e614 = target_;
        param_172 = _e614;
        let _e615 = getIndex_u0028_vi3_u003b((&param_172));
        param_173 = _e615;
        let _e616 = readCell_u0028_u1_u003b((&param_173));
        phi_7574_ = (_e616 != 0u);
    }
    let _e619 = phi_7574_;
    blocked = _e619;
    let _e620 = blocked;
    if !(_e620) {
        let _e622 = target_;
        footing = (_e622 + vec3<i32>(0i, -1i, 0i));
        let _e624 = footing;
        param_174 = _e624;
        let _e625 = locustInBounds_u0028_vi3_u003b((&param_174));
        phi_7593_ = _e625;
        if _e625 {
            let _e626 = footing;
            param_175 = _e626;
            let _e627 = getIndex_u0028_vi3_u003b((&param_175));
            param_176 = _e627;
            let _e628 = readCell_u0028_u1_u003b((&param_176));
            phi_7593_ = (_e628 == 0u);
        }
        let _e631 = phi_7593_;
        if _e631 {
            let _e632 = heading_1;
            param_177 = _e632;
            let _e633 = locustReverse_u0028_u1_u003b((&param_177));
            back = _e633;
            let _e634 = (*pos_5);
            let _e635 = back;
            param_178 = bitcast<i32>(_e635);
            let _e637 = getHDir_u0028_i1_u003b((&param_178));
            backPos = (_e634 + _e637);
            let _e639 = backPos;
            backFoot = (_e639 + vec3<i32>(0i, -1i, 0i));
            let _e641 = backPos;
            param_179 = _e641;
            let _e642 = locustInBounds_u0028_vi3_u003b((&param_179));
            phi_7622_ = _e642;
            if _e642 {
                let _e643 = backPos;
                param_180 = _e643;
                let _e644 = getIndex_u0028_vi3_u003b((&param_180));
                param_181 = _e644;
                let _e645 = readCell_u0028_u1_u003b((&param_181));
                phi_7622_ = (_e645 == 0u);
            }
            let _e648 = phi_7622_;
            phi_7638_ = _e648;
            if _e648 {
                let _e649 = backFoot;
                param_182 = _e649;
                let _e650 = locustInBounds_u0028_vi3_u003b((&param_182));
                phi_7636_ = _e650;
                if _e650 {
                    let _e651 = backFoot;
                    param_183 = _e651;
                    let _e652 = getIndex_u0028_vi3_u003b((&param_183));
                    param_184 = _e652;
                    let _e653 = readCell_u0028_u1_u003b((&param_184));
                    phi_7636_ = (_e653 == 0u);
                }
                let _e656 = phi_7636_;
                phi_7638_ = !(_e656);
            }
            let _e659 = phi_7638_;
            backOpen = _e659;
            let _e660 = backOpen;
            if _e660 {
                let _e661 = back;
                param_185 = _e661;
                let _e662 = steps_1;
                param_186 = _e662;
                let _e663 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_185), (&param_186));
                local_9 = _e663;
            } else {
                let _e664 = (*randVal_3);
                let _e670 = locustRunSteps_u0028_();
                param_187 = (u32((fract((_e664 * 71f)) * 8f)) & 7u);
                param_188 = _e670;
                let _e671 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_187), (&param_188));
                local_9 = _e671;
            }
            let _e672 = local_9;
            turnedNav = _e672;
            let _e673 = (*currentIndex_3);
            let _e676 = (*rawValue_2);
            let _e677 = newType;
            param_189 = _e677;
            let _e678 = turnedNav;
            param_190 = _e678;
            param_191 = 0u;
            let _e679 = count_2;
            param_192 = _e679;
            let _e680 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_189), (&param_190), (&param_191), (&param_192));
            let _e681 = atomicCompareExchangeWeak((&unnamed.grid[_e673]), _e676, _e680);
            return;
        }
        let _e683 = steps_1;
        let _e685 = heading_1;
        param_193 = _e685;
        param_194 = (_e683 - 1u);
        let _e686 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_193), (&param_194));
        nav_1 = _e686;
        let _e687 = target_;
        param_195 = _e687;
        let _e688 = getIndex_u0028_vi3_u003b((&param_195));
        let _e689 = target_;
        param_196 = _e689;
        let _e690 = nav_1;
        param_197 = _e690;
        let _e691 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_196), (&param_197));
        let _e692 = newType;
        param_198 = _e692;
        param_199 = _e691;
        param_200 = 0u;
        let _e693 = count_2;
        param_201 = _e693;
        let _e694 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_198), (&param_199), (&param_200), (&param_201));
        let _e695 = (*currentIndex_3);
        param_202 = _e695;
        let _e696 = (*rawValue_2);
        param_203 = _e696;
        param_204 = _e688;
        param_205 = _e694;
        let _e697 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_202), (&param_203), (&param_204), (&param_205));
        if _e697 {
            return;
        }
    } else {
        let _e698 = (*randVal_3);
        let _e702 = tuning.locustClimbChance;
        if (fract((_e698 * 41f)) < _e702) {
            let _e704 = target_;
            overTop = (_e704 + vec3<i32>(0i, 1i, 0i));
            let _e706 = overTop;
            param_206 = _e706;
            let _e707 = locustInBounds_u0028_vi3_u003b((&param_206));
            phi_7730_ = _e707;
            if _e707 {
                let _e708 = overTop;
                param_207 = _e708;
                let _e709 = getIndex_u0028_vi3_u003b((&param_207));
                param_208 = _e709;
                let _e710 = readCell_u0028_u1_u003b((&param_208));
                phi_7730_ = (_e710 == 0u);
            }
            let _e713 = phi_7730_;
            if _e713 {
                let _e714 = steps_1;
                let _e716 = heading_1;
                param_209 = _e716;
                param_210 = (_e714 - 1u);
                let _e717 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_209), (&param_210));
                nav_2 = _e717;
                let _e718 = overTop;
                param_211 = _e718;
                let _e719 = getIndex_u0028_vi3_u003b((&param_211));
                let _e720 = overTop;
                param_212 = _e720;
                let _e721 = nav_2;
                param_213 = _e721;
                let _e722 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_212), (&param_213));
                let _e723 = newType;
                param_214 = _e723;
                param_215 = _e722;
                param_216 = 0u;
                let _e724 = count_2;
                param_217 = _e724;
                let _e725 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_214), (&param_215), (&param_216), (&param_217));
                let _e726 = (*currentIndex_3);
                param_218 = _e726;
                let _e727 = (*rawValue_2);
                param_219 = _e727;
                param_220 = _e719;
                param_221 = _e725;
                let _e728 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_218), (&param_219), (&param_220), (&param_221));
                if _e728 {
                    return;
                }
            }
            let _e729 = (*pos_5);
            up = (_e729 + vec3<i32>(0i, 1i, 0i));
            let _e731 = up;
            param_222 = _e731;
            let _e732 = locustInBounds_u0028_vi3_u003b((&param_222));
            phi_7779_ = _e732;
            if _e732 {
                let _e733 = up;
                param_223 = _e733;
                let _e734 = getIndex_u0028_vi3_u003b((&param_223));
                param_224 = _e734;
                let _e735 = readCell_u0028_u1_u003b((&param_224));
                phi_7779_ = (_e735 == 0u);
            }
            let _e738 = phi_7779_;
            if _e738 {
                let _e739 = heading_1;
                param_225 = _e739;
                let _e740 = steps_1;
                param_226 = _e740;
                let _e741 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_225), (&param_226));
                nav_3 = _e741;
                let _e742 = up;
                param_227 = _e742;
                let _e743 = getIndex_u0028_vi3_u003b((&param_227));
                let _e744 = up;
                param_228 = _e744;
                let _e745 = nav_3;
                param_229 = _e745;
                let _e746 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_228), (&param_229));
                let _e747 = newType;
                param_230 = _e747;
                param_231 = _e746;
                param_232 = 0u;
                let _e748 = count_2;
                param_233 = _e748;
                let _e749 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_230), (&param_231), (&param_232), (&param_233));
                let _e750 = (*currentIndex_3);
                param_234 = _e750;
                let _e751 = (*rawValue_2);
                param_235 = _e751;
                param_236 = _e743;
                param_237 = _e749;
                let _e752 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_234), (&param_235), (&param_236), (&param_237));
                if _e752 {
                    return;
                }
            }
        }
        let _e753 = (*randVal_3);
        heading_1 = (u32((fract((_e753 * 53f)) * 8f)) & 7u);
        let _e759 = locustRunSteps_u0028_();
        steps_1 = _e759;
    }
    let _e760 = (*currentIndex_3);
    let _e763 = (*rawValue_2);
    let _e764 = heading_1;
    param_238 = _e764;
    let _e765 = steps_1;
    param_239 = _e765;
    let _e766 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_238), (&param_239));
    let _e767 = newType;
    param_240 = _e767;
    param_241 = _e766;
    param_242 = 0u;
    let _e768 = count_2;
    param_243 = _e768;
    let _e769 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_240), (&param_241), (&param_242), (&param_243));
    let _e770 = atomicCompareExchangeWeak((&unnamed.grid[_e760]), _e763, _e769);
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
    var phi_6463_: bool;

    let _e228 = (*pos_6)[1u];
    if (_e228 > 1i) {
        let _e230 = (*pos_6);
        belowPos_2 = (_e230 + vec3<i32>(0i, -1i, 0i));
        let _e232 = belowPos_2;
        param_244 = _e232;
        let _e233 = getIndex_u0028_vi3_u003b((&param_244));
        param_245 = _e233;
        let _e234 = readCell_u0028_u1_u003b((&param_245));
        param_246 = _e234;
        let _e235 = getType_u0028_u1_u003b((&param_246));
        if (_e235 == 0u) {
            let _e237 = belowPos_2;
            param_247 = _e237;
            let _e238 = getIndex_u0028_vi3_u003b((&param_247));
            param_248 = 12u;
            param_249 = 0u;
            param_250 = 0u;
            let _e239 = (*currentAge_3);
            param_251 = _e239;
            let _e240 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_248), (&param_249), (&param_250), (&param_251));
            let _e241 = (*currentIndex_4);
            param_252 = _e241;
            let _e242 = (*rawValue_3);
            param_253 = _e242;
            param_254 = _e238;
            param_255 = _e240;
            let _e243 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_252), (&param_253), (&param_254), (&param_255));
            if _e243 {
                return;
            }
        }
    }
    let _e244 = (*currentAge_3);
    let _e245 = (_e244 > 0u);
    phi_6463_ = _e245;
    if _e245 {
        let _e246 = (*randVal_4);
        let _e250 = tuning.darkStoneDryChance;
        phi_6463_ = (fract((_e246 * 23f)) < _e250);
    }
    let _e253 = phi_6463_;
    if _e253 {
        let _e254 = (*currentIndex_4);
        let _e257 = (*rawValue_3);
        let _e258 = (*currentAge_3);
        param_256 = 12u;
        param_257 = 0u;
        param_258 = 0u;
        param_259 = (_e258 - 1u);
        let _e260 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_256), (&param_257), (&param_258), (&param_259));
        let _e261 = atomicCompareExchangeWeak((&unnamed.grid[_e254]), _e257, _e260);
    }
    return;
}

fn isLava_u0028_u1_u003b(type_37: ptr<function, u32>) -> bool {
    let _e206 = (*type_37);
    let _e208 = (*type_37);
    return ((_e206 >= 8u) && (_e208 <= 11u));
}

fn lavaTypeFor_u0028_u1_u003b(coolness: ptr<function, u32>) -> u32 {
    let _e206 = (*coolness);
    let _e208 = tuning.lavaStageSize;
    return (8u + min((_e206 / max(_e208, 1u)), 3u));
}

fn lavaSolidifyCoolness_u0028_() -> u32 {
    let _e206 = tuning.lavaStageSize;
    return min((max(_e206, 1u) * 4u), 255u);
}

fn decWater_u0028_() {
    let _e206 = atomicAdd((&unnamed_1.waterVoxelCount), 4294967295u);
    return;
}

fn getOrthoDir_u0028_i1_u003b(d_5: ptr<function, i32>) -> vec3<i32> {
    let _e206 = (*d_5);
    if (_e206 == 0i) {
        return vec3<i32>(1i, 0i, 0i);
    }
    let _e208 = (*d_5);
    if (_e208 == 1i) {
        return vec3<i32>(-1i, 0i, 0i);
    }
    let _e210 = (*d_5);
    if (_e210 == 2i) {
        return vec3<i32>(0i, 1i, 0i);
    }
    let _e212 = (*d_5);
    if (_e212 == 3i) {
        return vec3<i32>(0i, -1i, 0i);
    }
    let _e214 = (*d_5);
    if (_e214 == 4i) {
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
    var phi_5517_: bool;
    var phi_5524_: bool;
    var phi_5535_: bool;
    var phi_5542_: bool;
    var phi_5553_: bool;
    var phi_5692_: bool;
    var phi_5703_: bool;

    let _e273 = (*randVal_5);
    startDir = i32((fract((_e273 * 17f)) * 6f));
    i_7 = 0i;
    loop {
        let _e278 = i_7;
        if (_e278 < 6i) {
            let _e280 = startDir;
            let _e281 = i_7;
            let _e282 = (_e280 + _e281);
            d_6 = (_e282 - (i32(floor((f32(_e282) / f32(6i)))) * 6i));
            let _e290 = (*pos_7);
            let _e291 = d_6;
            param_260 = _e291;
            let _e292 = getOrthoDir_u0028_i1_u003b((&param_260));
            nPos = (_e290 + _e292);
            let _e295 = nPos[0u];
            let _e296 = (_e295 <= 0i);
            phi_5517_ = _e296;
            if !(_e296) {
                let _e299 = nPos[0u];
                let _e301 = tuning.gridWidth;
                phi_5517_ = (_e299 >= (bitcast<i32>(_e301) - 1i));
            }
            let _e306 = phi_5517_;
            phi_5524_ = _e306;
            if !(_e306) {
                let _e309 = nPos[1u];
                phi_5524_ = (_e309 <= 0i);
            }
            let _e312 = phi_5524_;
            phi_5535_ = _e312;
            if !(_e312) {
                let _e315 = nPos[1u];
                let _e317 = tuning.gridHeight;
                phi_5535_ = (_e315 >= (bitcast<i32>(_e317) - 1i));
            }
            let _e322 = phi_5535_;
            phi_5542_ = _e322;
            if !(_e322) {
                let _e325 = nPos[2u];
                phi_5542_ = (_e325 <= 0i);
            }
            let _e328 = phi_5542_;
            phi_5553_ = _e328;
            if !(_e328) {
                let _e331 = nPos[2u];
                let _e333 = tuning.gridDepth;
                phi_5553_ = (_e331 >= (bitcast<i32>(_e333) - 1i));
            }
            let _e338 = phi_5553_;
            if _e338 {
                continue;
            }
            let _e339 = nPos;
            param_261 = _e339;
            let _e340 = getIndex_u0028_vi3_u003b((&param_261));
            nIndex = _e340;
            let _e341 = nIndex;
            param_262 = _e341;
            let _e342 = readCell_u0028_u1_u003b((&param_262));
            nVal = _e342;
            let _e343 = nVal;
            param_263 = _e343;
            let _e344 = getType_u0028_u1_u003b((&param_263));
            nType = _e344;
            let _e345 = nType;
            if (_e345 == 2u) {
                let _e347 = nIndex;
                let _e350 = nVal;
                param_264 = 6u;
                param_265 = 0u;
                param_266 = 0u;
                param_267 = 0u;
                let _e351 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_264), (&param_265), (&param_266), (&param_267));
                let _e352 = atomicCompareExchangeWeak((&unnamed.grid[_e347]), _e350, _e351);
                let _e354 = nVal;
                if (_e352.old_value == _e354) {
                    decWater_u0028_();
                    let _e356 = (*coolness_1);
                    let _e358 = tuning.lavaWaterCool;
                    (*coolness_1) = min((_e356 + _e358), 255u);
                    return;
                }
            } else {
                let _e361 = nType;
                if (_e361 == 19u) {
                    let _e363 = nIndex;
                    let _e366 = nVal;
                    let _e367 = atomicCompareExchangeWeak((&unnamed.grid[_e363]), _e366, 0u);
                    let _e369 = nVal;
                    if (_e367.old_value == _e369) {
                        return;
                    }
                } else {
                    let _e371 = nType;
                    if (_e371 == 18u) {
                        let _e373 = nIndex;
                        let _e376 = nVal;
                        param_268 = 5u;
                        param_269 = 0u;
                        param_270 = 0u;
                        param_271 = 0u;
                        let _e377 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_268), (&param_269), (&param_270), (&param_271));
                        let _e378 = atomicCompareExchangeWeak((&unnamed.grid[_e373]), _e376, _e377);
                        let _e380 = nVal;
                        if (_e378.old_value == _e380) {
                            return;
                        }
                    } else {
                        let _e382 = nType;
                        if (_e382 == 3u) {
                            let _e384 = nIndex;
                            let _e387 = nVal;
                            param_272 = 12u;
                            param_273 = 0u;
                            param_274 = 0u;
                            param_275 = 255u;
                            let _e388 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_272), (&param_273), (&param_274), (&param_275));
                            let _e389 = atomicCompareExchangeWeak((&unnamed.grid[_e384]), _e387, _e388);
                            let _e391 = nVal;
                            if (_e389.old_value == _e391) {
                                return;
                            }
                        } else {
                            let _e393 = nType;
                            let _e395 = nType;
                            if ((_e393 == 1u) || (_e395 == 4u)) {
                                let _e398 = nVal;
                                param_276 = _e398;
                                let _e399 = getAge_u0028_u1_u003b((&param_276));
                                moisture_1 = _e399;
                                let _e400 = nVal;
                                param_277 = _e400;
                                let _e401 = getDir_u0028_u1_u003b((&param_277));
                                flora_2 = _e401;
                                let _e402 = nType;
                                let _e404 = flora_2;
                                let _e407 = flora_2;
                                if (((_e402 == 4u) && (_e404 > 10u)) && (_e407 <= 100u)) {
                                    let _e410 = nPos;
                                    abovePos = (_e410 + vec3<i32>(0i, 1i, 0i));
                                    let _e413 = abovePos[1u];
                                    let _e415 = tuning.gridHeight;
                                    let _e418 = (_e413 < (bitcast<i32>(_e415) - 1i));
                                    phi_5692_ = _e418;
                                    if _e418 {
                                        let _e419 = abovePos;
                                        param_278 = _e419;
                                        let _e420 = getIndex_u0028_vi3_u003b((&param_278));
                                        param_279 = _e420;
                                        let _e421 = readCell_u0028_u1_u003b((&param_279));
                                        param_280 = _e421;
                                        let _e422 = getType_u0028_u1_u003b((&param_280));
                                        phi_5692_ = (_e422 == 0u);
                                    }
                                    let _e425 = phi_5692_;
                                    phi_5703_ = _e425;
                                    if _e425 {
                                        let _e426 = (*randVal_5);
                                        let _e430 = tuning.lavaIgniteChance;
                                        phi_5703_ = (fract((_e426 * 41f)) < _e430);
                                    }
                                    let _e433 = phi_5703_;
                                    if _e433 {
                                        let _e434 = abovePos;
                                        param_281 = _e434;
                                        let _e435 = getIndex_u0028_vi3_u003b((&param_281));
                                        param_282 = 5u;
                                        param_283 = 0u;
                                        param_284 = 0u;
                                        param_285 = 0u;
                                        let _e438 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_282), (&param_283), (&param_284), (&param_285));
                                        let _e439 = atomicCompareExchangeWeak((&unnamed.grid[_e435]), 0u, _e438);
                                        if (_e439.old_value == 0u) {
                                            return;
                                        }
                                    }
                                } else {
                                    let _e442 = moisture_1;
                                    if (_e442 > 0u) {
                                        let _e444 = nIndex;
                                        let _e447 = nVal;
                                        let _e448 = moisture_1;
                                        let _e450 = nType;
                                        param_286 = _e450;
                                        let _e451 = flora_2;
                                        param_287 = _e451;
                                        param_288 = 0u;
                                        param_289 = (_e448 - 1u);
                                        let _e452 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_286), (&param_287), (&param_288), (&param_289));
                                        let _e453 = atomicCompareExchangeWeak((&unnamed.grid[_e444]), _e447, _e452);
                                        let _e455 = nVal;
                                        if (_e453.old_value == _e455) {
                                            let _e457 = (*coolness_1);
                                            let _e459 = tuning.lavaMoistureCool;
                                            (*coolness_1) = min((_e457 + _e459), 255u);
                                            return;
                                        }
                                    } else {
                                        let _e462 = (*randVal_5);
                                        let _e466 = tuning.lavaConsumeChance;
                                        if (fract((_e462 * 53f)) < _e466) {
                                            let _e468 = nIndex;
                                            let _e471 = nVal;
                                            let _e472 = atomicCompareExchangeWeak((&unnamed.grid[_e468]), _e471, 0u);
                                            let _e474 = nVal;
                                            if (_e472.old_value == _e474) {
                                                return;
                                            }
                                        }
                                    }
                                }
                            } else {
                                let _e476 = nType;
                                param_290 = _e476;
                                let _e477 = isLava_u0028_u1_u003b((&param_290));
                                if _e477 {
                                    let _e478 = nVal;
                                    param_291 = _e478;
                                    let _e479 = getAge_u0028_u1_u003b((&param_291));
                                    nCool = _e479;
                                    let _e480 = (*coolness_1);
                                    let _e481 = nCool;
                                    if (_e480 > (_e481 + 1u)) {
                                        let _e484 = nCool;
                                        raised = (_e484 + 1u);
                                        let _e486 = raised;
                                        let _e487 = lavaSolidifyCoolness_u0028_();
                                        if (_e486 >= _e487) {
                                            local_10 = 12u;
                                        } else {
                                            let _e489 = raised;
                                            param_292 = _e489;
                                            let _e490 = lavaTypeFor_u0028_u1_u003b((&param_292));
                                            local_10 = _e490;
                                        }
                                        let _e491 = local_10;
                                        raisedType = _e491;
                                        let _e492 = nIndex;
                                        let _e495 = nVal;
                                        let _e496 = nVal;
                                        param_293 = _e496;
                                        let _e497 = getDir_u0028_u1_u003b((&param_293));
                                        let _e498 = raisedType;
                                        param_294 = _e498;
                                        param_295 = _e497;
                                        param_296 = 0u;
                                        let _e499 = raised;
                                        param_297 = _e499;
                                        let _e500 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_294), (&param_295), (&param_296), (&param_297));
                                        let _e501 = atomicCompareExchangeWeak((&unnamed.grid[_e492]), _e495, _e500);
                                        let _e503 = nVal;
                                        if (_e501.old_value == _e503) {
                                            let _e505 = (*coolness_1);
                                            (*coolness_1) = (_e505 - 1u);
                                            return;
                                        }
                                    }
                                } else {
                                    let _e507 = nType;
                                    if (_e507 == 12u) {
                                        let _e509 = nVal;
                                        param_298 = _e509;
                                        let _e510 = getAge_u0028_u1_u003b((&param_298));
                                        nCool_1 = _e510;
                                        let _e511 = nCool_1;
                                        let _e512 = (*coolness_1);
                                        draws = (_e511 > (_e512 + 1u));
                                        let _e515 = draws;
                                        if _e515 {
                                            let _e516 = nCool_1;
                                            local_11 = (_e516 - 1u);
                                        } else {
                                            let _e518 = nCool_1;
                                            local_11 = _e518;
                                        }
                                        let _e519 = local_11;
                                        lowered = _e519;
                                        let _e520 = lowered;
                                        let _e521 = lavaSolidifyCoolness_u0028_();
                                        melts = (_e520 < _e521);
                                        let _e523 = draws;
                                        let _e524 = melts;
                                        if (_e523 || _e524) {
                                            let _e526 = melts;
                                            if _e526 {
                                                let _e527 = lowered;
                                                param_299 = _e527;
                                                let _e528 = lavaTypeFor_u0028_u1_u003b((&param_299));
                                                local_12 = _e528;
                                            } else {
                                                local_12 = 12u;
                                            }
                                            let _e529 = local_12;
                                            newType_1 = _e529;
                                            let _e530 = nIndex;
                                            let _e533 = nVal;
                                            let _e534 = newType_1;
                                            param_300 = _e534;
                                            param_301 = 0u;
                                            param_302 = 0u;
                                            let _e535 = lowered;
                                            param_303 = _e535;
                                            let _e536 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_300), (&param_301), (&param_302), (&param_303));
                                            let _e537 = atomicCompareExchangeWeak((&unnamed.grid[_e530]), _e533, _e536);
                                            let _e539 = nVal;
                                            if (_e537.old_value == _e539) {
                                                let _e541 = draws;
                                                if _e541 {
                                                    let _e542 = (*coolness_1);
                                                    (*coolness_1) = min((_e542 + 1u), 255u);
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
            let _e545 = i_7;
            i_7 = (_e545 + 1i);
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
    var phi_5911_: bool;
    var phi_6049_: bool;
    var phi_6055_: bool;
    var phi_6065_: bool;
    var phi_6177_: bool;
    var phi_6184_: bool;
    var phi_6195_: bool;
    var phi_6207_: bool;
    var phi_6229_: bool;
    var phi_6343_: bool;
    var phi_6349_: bool;
    var phi_6359_: bool;

    let _e307 = (*currentAge_4);
    coolness_2 = _e307;
    let _e308 = (*pos_8);
    param_304 = _e308;
    let _e309 = coolness_2;
    param_305 = _e309;
    let _e310 = (*randVal_6);
    param_306 = _e310;
    lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b((&param_304), (&param_305), (&param_306));
    let _e311 = param_305;
    coolness_2 = _e311;
    let _e312 = (*currentSleep_1);
    let _e314 = tuning.wakeSleepThreshold;
    let _e315 = (_e312 > _e314);
    phi_5911_ = _e315;
    if _e315 {
        let _e316 = (*randVal_6);
        let _e320 = tuning.lavaRestCoolChance;
        phi_5911_ = (fract((_e316 * 71f)) < _e320);
    }
    let _e323 = phi_5911_;
    if _e323 {
        let _e324 = coolness_2;
        coolness_2 = min((_e324 + 1u), 255u);
    }
    let _e327 = coolness_2;
    let _e328 = lavaSolidifyCoolness_u0028_();
    if (_e327 >= _e328) {
        let _e330 = (*currentIndex_5);
        let _e333 = (*rawValue_4);
        param_307 = 12u;
        param_308 = 0u;
        param_309 = 0u;
        let _e334 = coolness_2;
        param_310 = _e334;
        let _e335 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_307), (&param_308), (&param_309), (&param_310));
        let _e336 = atomicCompareExchangeWeak((&unnamed.grid[_e330]), _e333, _e335);
        return;
    }
    let _e338 = coolness_2;
    param_311 = _e338;
    let _e339 = lavaTypeFor_u0028_u1_u003b((&param_311));
    newType_2 = _e339;
    let _e340 = (*randVal_6);
    let _e344 = tuning.lavaViscosity;
    if (fract((_e340 * 89f)) < _e344) {
        let _e347 = (*pos_8)[1u];
        if (_e347 > 1i) {
            let _e349 = (*pos_8);
            belowPos_3 = (_e349 + vec3<i32>(0i, -1i, 0i));
            let _e351 = belowPos_3;
            param_312 = _e351;
            let _e352 = getIndex_u0028_vi3_u003b((&param_312));
            param_313 = _e352;
            let _e353 = readCell_u0028_u1_u003b((&param_313));
            param_314 = _e353;
            let _e354 = getType_u0028_u1_u003b((&param_314));
            if (_e354 == 0u) {
                let _e356 = belowPos_3;
                param_315 = _e356;
                let _e357 = getIndex_u0028_vi3_u003b((&param_315));
                let _e358 = newType_2;
                param_316 = _e358;
                let _e359 = (*currentDir_2);
                param_317 = _e359;
                param_318 = 0u;
                let _e360 = coolness_2;
                param_319 = _e360;
                let _e361 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_316), (&param_317), (&param_318), (&param_319));
                let _e362 = (*currentIndex_5);
                param_320 = _e362;
                let _e363 = (*rawValue_4);
                param_321 = _e363;
                param_322 = _e357;
                param_323 = _e361;
                let _e364 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_320), (&param_321), (&param_322), (&param_323));
                if _e364 {
                    return;
                }
            }
        }
        let _e366 = (*pos_8)[1u];
        if (_e366 > 1i) {
            let _e368 = (*randVal_6);
            slideDir = select(-1i, 1i, (fract((_e368 * 10f)) > 0.5f));
            let _e373 = (*randVal_6);
            if (fract((_e373 * 100f)) > 0.5f) {
                let _e377 = (*pos_8);
                let _e378 = slideDir;
                slide[0i] = (_e377 + vec3<i32>(_e378, -1i, 0i));
                let _e382 = (*pos_8);
                let _e383 = slideDir;
                slide[1i] = (_e382 + vec3<i32>(0i, -1i, _e383));
            } else {
                let _e387 = (*pos_8);
                let _e388 = slideDir;
                slide[0i] = (_e387 + vec3<i32>(0i, -1i, _e388));
                let _e392 = (*pos_8);
                let _e393 = slideDir;
                slide[1i] = (_e392 + vec3<i32>(_e393, -1i, 0i));
            }
            s = 0i;
            loop {
                let _e397 = s;
                if (_e397 < 2i) {
                    let _e399 = s;
                    let _e401 = slide[_e399];
                    sPos = _e401;
                    let _e403 = sPos[0u];
                    let _e404 = (_e403 > 0i);
                    phi_6049_ = _e404;
                    if _e404 {
                        let _e406 = sPos[0u];
                        let _e408 = tuning.gridWidth;
                        phi_6049_ = (_e406 < (bitcast<i32>(_e408) - 1i));
                    }
                    let _e413 = phi_6049_;
                    phi_6055_ = _e413;
                    if _e413 {
                        let _e415 = sPos[2u];
                        phi_6055_ = (_e415 > 0i);
                    }
                    let _e418 = phi_6055_;
                    phi_6065_ = _e418;
                    if _e418 {
                        let _e420 = sPos[2u];
                        let _e422 = tuning.gridDepth;
                        phi_6065_ = (_e420 < (bitcast<i32>(_e422) - 1i));
                    }
                    let _e427 = phi_6065_;
                    if _e427 {
                        let _e428 = sPos;
                        param_324 = _e428;
                        let _e429 = getIndex_u0028_vi3_u003b((&param_324));
                        param_325 = _e429;
                        let _e430 = readCell_u0028_u1_u003b((&param_325));
                        param_326 = _e430;
                        let _e431 = getType_u0028_u1_u003b((&param_326));
                        if (_e431 == 0u) {
                            let _e433 = sPos;
                            param_327 = _e433;
                            let _e434 = getIndex_u0028_vi3_u003b((&param_327));
                            let _e435 = newType_2;
                            param_328 = _e435;
                            let _e436 = (*currentDir_2);
                            param_329 = _e436;
                            param_330 = 0u;
                            let _e437 = coolness_2;
                            param_331 = _e437;
                            let _e438 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_328), (&param_329), (&param_330), (&param_331));
                            let _e439 = (*currentIndex_5);
                            param_332 = _e439;
                            let _e440 = (*rawValue_4);
                            param_333 = _e440;
                            param_334 = _e434;
                            param_335 = _e438;
                            let _e441 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_332), (&param_333), (&param_334), (&param_335));
                            if _e441 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e442 = s;
                    s = (_e442 + 1i);
                }
            }
        }
        let _e444 = (*currentSleep_1);
        let _e446 = tuning.wakeSleepThreshold;
        if (_e444 <= _e446) {
            blockedMask = 0u;
            let _e448 = (*randVal_6);
            searchStart = i32((fract((_e448 * 8f)) * 8f));
            let _e454 = tuning.lavaSpreadRadius;
            reach = bitcast<i32>(max(_e454, 1u));
            r = 1i;
            loop {
                let _e457 = r;
                let _e458 = reach;
                if (_e457 <= _e458) {
                    let _e460 = blockedMask;
                    if (_e460 == 255u) {
                        break;
                    }
                    i_8 = 0i;
                    loop {
                        let _e462 = i_8;
                        if (_e462 < 8i) {
                            let _e464 = searchStart;
                            let _e465 = i_8;
                            let _e466 = (_e464 + _e465);
                            d_7 = (_e466 - (i32(floor((f32(_e466) / f32(8i)))) * 8i));
                            let _e474 = blockedMask;
                            let _e475 = d_7;
                            if ((_e474 & (1u << bitcast<u32>(_e475))) != 0u) {
                                continue;
                            }
                            let _e480 = (*pos_8);
                            let _e481 = d_7;
                            param_336 = _e481;
                            let _e482 = getHDir_u0028_i1_u003b((&param_336));
                            let _e483 = r;
                            c_6 = (_e480 + (_e482 * vec3(_e483)));
                            let _e488 = c_6[0u];
                            let _e489 = (_e488 <= 0i);
                            phi_6177_ = _e489;
                            if !(_e489) {
                                let _e492 = c_6[0u];
                                let _e494 = tuning.gridWidth;
                                phi_6177_ = (_e492 >= (bitcast<i32>(_e494) - 1i));
                            }
                            let _e499 = phi_6177_;
                            phi_6184_ = _e499;
                            if !(_e499) {
                                let _e502 = c_6[2u];
                                phi_6184_ = (_e502 <= 0i);
                            }
                            let _e505 = phi_6184_;
                            phi_6195_ = _e505;
                            if !(_e505) {
                                let _e508 = c_6[2u];
                                let _e510 = tuning.gridDepth;
                                phi_6195_ = (_e508 >= (bitcast<i32>(_e510) - 1i));
                            }
                            let _e515 = phi_6195_;
                            phi_6207_ = _e515;
                            if !(_e515) {
                                let _e517 = c_6;
                                param_337 = _e517;
                                let _e518 = getIndex_u0028_vi3_u003b((&param_337));
                                param_338 = _e518;
                                let _e519 = readCell_u0028_u1_u003b((&param_338));
                                param_339 = _e519;
                                let _e520 = getType_u0028_u1_u003b((&param_339));
                                phi_6207_ = (_e520 != 0u);
                            }
                            let _e523 = phi_6207_;
                            if _e523 {
                                let _e524 = d_7;
                                let _e527 = blockedMask;
                                blockedMask = (_e527 | (1u << bitcast<u32>(_e524)));
                            } else {
                                let _e530 = c_6[1u];
                                let _e531 = (_e530 > 1i);
                                phi_6229_ = _e531;
                                if _e531 {
                                    let _e532 = c_6;
                                    param_340 = (_e532 + vec3<i32>(0i, -1i, 0i));
                                    let _e534 = getIndex_u0028_vi3_u003b((&param_340));
                                    param_341 = _e534;
                                    let _e535 = readCell_u0028_u1_u003b((&param_341));
                                    param_342 = _e535;
                                    let _e536 = getType_u0028_u1_u003b((&param_342));
                                    phi_6229_ = (_e536 == 0u);
                                }
                                let _e539 = phi_6229_;
                                if _e539 {
                                    let _e540 = c_6;
                                    param_343 = _e540;
                                    let _e541 = getIndex_u0028_vi3_u003b((&param_343));
                                    let _e542 = newType_2;
                                    param_344 = _e542;
                                    param_345 = 0u;
                                    param_346 = 0u;
                                    let _e543 = coolness_2;
                                    param_347 = _e543;
                                    let _e544 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_344), (&param_345), (&param_346), (&param_347));
                                    let _e545 = (*currentIndex_5);
                                    param_348 = _e545;
                                    let _e546 = (*rawValue_4);
                                    param_349 = _e546;
                                    param_350 = _e541;
                                    param_351 = _e544;
                                    let _e547 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_348), (&param_349), (&param_350), (&param_351));
                                    if _e547 {
                                        return;
                                    }
                                    let _e548 = d_7;
                                    let _e551 = blockedMask;
                                    blockedMask = (_e551 | (1u << bitcast<u32>(_e548)));
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e553 = i_8;
                            i_8 = (_e553 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e555 = r;
                    r = (_e555 + 1i);
                }
            }
            let _e558 = (*pos_8)[1u];
            let _e560 = tuning.gridHeight;
            if (_e558 < (bitcast<i32>(_e560) - 2i)) {
                let _e564 = (*pos_8);
                param_352 = (_e564 + vec3<i32>(0i, 1i, 0i));
                let _e566 = getIndex_u0028_vi3_u003b((&param_352));
                param_353 = _e566;
                let _e567 = readCell_u0028_u1_u003b((&param_353));
                param_354 = _e567;
                let _e568 = getType_u0028_u1_u003b((&param_354));
                local_13 = (_e568 != 0u);
            } else {
                local_13 = false;
            }
            let _e570 = local_13;
            hasPressure = _e570;
            let _e572 = (*pos_8)[1u];
            if (_e572 > 1i) {
                let _e574 = (*pos_8);
                param_355 = (_e574 + vec3<i32>(0i, -1i, 0i));
                let _e576 = getIndex_u0028_vi3_u003b((&param_355));
                param_356 = _e576;
                let _e577 = readCell_u0028_u1_u003b((&param_356));
                param_357 = _e577;
                let _e578 = getType_u0028_u1_u003b((&param_357));
                param_358 = _e578;
                let _e579 = isLava_u0028_u1_u003b((&param_358));
                local_14 = _e579;
            } else {
                local_14 = false;
            }
            let _e580 = local_14;
            stackedOnLava = _e580;
            let _e581 = hasPressure;
            let _e582 = stackedOnLava;
            if (_e581 || _e582) {
                let _e584 = (*randVal_6);
                spreadStart = i32((fract((_e584 * 8f)) * 8f));
                i_9 = 0i;
                loop {
                    let _e589 = i_9;
                    if (_e589 < 8i) {
                        let _e591 = spreadStart;
                        let _e592 = i_9;
                        let _e593 = (_e591 + _e592);
                        d_8 = (_e593 - (i32(floor((f32(_e593) / f32(8i)))) * 8i));
                        let _e601 = (*pos_8);
                        let _e602 = d_8;
                        param_359 = _e602;
                        let _e603 = getHDir_u0028_i1_u003b((&param_359));
                        targetPos = (_e601 + _e603);
                        let _e606 = targetPos[0u];
                        let _e607 = (_e606 > 0i);
                        phi_6343_ = _e607;
                        if _e607 {
                            let _e609 = targetPos[0u];
                            let _e611 = tuning.gridWidth;
                            phi_6343_ = (_e609 < (bitcast<i32>(_e611) - 1i));
                        }
                        let _e616 = phi_6343_;
                        phi_6349_ = _e616;
                        if _e616 {
                            let _e618 = targetPos[2u];
                            phi_6349_ = (_e618 > 0i);
                        }
                        let _e621 = phi_6349_;
                        phi_6359_ = _e621;
                        if _e621 {
                            let _e623 = targetPos[2u];
                            let _e625 = tuning.gridDepth;
                            phi_6359_ = (_e623 < (bitcast<i32>(_e625) - 1i));
                        }
                        let _e630 = phi_6359_;
                        if _e630 {
                            let _e631 = targetPos;
                            param_360 = _e631;
                            let _e632 = getIndex_u0028_vi3_u003b((&param_360));
                            param_361 = _e632;
                            let _e633 = readCell_u0028_u1_u003b((&param_361));
                            param_362 = _e633;
                            let _e634 = getType_u0028_u1_u003b((&param_362));
                            if (_e634 == 0u) {
                                let _e636 = targetPos;
                                param_363 = _e636;
                                let _e637 = getIndex_u0028_vi3_u003b((&param_363));
                                let _e638 = d_8;
                                let _e641 = newType_2;
                                param_364 = _e641;
                                param_365 = bitcast<u32>((_e638 + 1i));
                                param_366 = 0u;
                                let _e642 = coolness_2;
                                param_367 = _e642;
                                let _e643 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_364), (&param_365), (&param_366), (&param_367));
                                let _e644 = (*currentIndex_5);
                                param_368 = _e644;
                                let _e645 = (*rawValue_4);
                                param_369 = _e645;
                                param_370 = _e637;
                                param_371 = _e643;
                                let _e646 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_368), (&param_369), (&param_370), (&param_371));
                                if _e646 {
                                    return;
                                }
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e647 = i_9;
                        i_9 = (_e647 + 1i);
                    }
                }
            }
        }
    }
    let _e649 = (*currentSleep_1);
    newSleep = min((_e649 + 1u), 255u);
    let _e652 = (*currentIndex_5);
    let _e655 = (*rawValue_4);
    let _e656 = newType_2;
    param_372 = _e656;
    let _e657 = (*currentDir_2);
    param_373 = _e657;
    let _e658 = newSleep;
    param_374 = _e658;
    let _e659 = coolness_2;
    param_375 = _e659;
    let _e660 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_372), (&param_373), (&param_374), (&param_375));
    let _e661 = atomicCompareExchangeWeak((&unnamed.grid[_e652]), _e655, _e660);
    return;
}

fn updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_9: ptr<function, vec3<i32>>, currentIndex_6: ptr<function, u32>, rawValue_5: ptr<function, u32>, currentSleep_2: ptr<function, u32>, currentAge_5: ptr<function, u32>, randVal_7: ptr<function, f32>) {
    var newAge: u32;
    var d_9: i32;
    var scatterPos: vec3<i32>;
    var param_376: i32;
    var sType: u32;
    var param_377: vec3<i32>;
    var param_378: u32;
    var param_379: u32;
    var param_380: vec3<i32>;
    var param_381: u32;
    var param_382: u32;
    var param_383: u32;
    var param_384: u32;
    var param_385: u32;
    var param_386: u32;
    var param_387: u32;
    var param_388: u32;
    var checkPos: array<vec3<i32>, 3>;
    var dir_1: i32;
    var i_10: i32;
    var cPos: vec3<i32>;
    var cIndex: u32;
    var param_389: vec3<i32>;
    var cVal: u32;
    var param_390: u32;
    var cType: u32;
    var param_391: u32;
    var moisture_2: u32;
    var param_392: u32;
    var capacity: u32;
    var local_15: u32;
    var i_11: i32;
    var sPos_1: vec3<i32>;
    var sType_1: u32;
    var param_393: vec3<i32>;
    var param_394: u32;
    var param_395: u32;
    var param_396: vec3<i32>;
    var param_397: u32;
    var param_398: u32;
    var param_399: u32;
    var param_400: u32;
    var param_401: u32;
    var param_402: u32;
    var param_403: u32;
    var param_404: u32;
    var newSleep_1: u32;
    var param_405: u32;
    var param_406: u32;
    var param_407: u32;
    var param_408: u32;
    var phi_8619_: bool;
    var phi_8625_: bool;
    var phi_8635_: bool;
    var phi_8641_: bool;
    var phi_8651_: bool;
    var phi_8751_: bool;
    var phi_8757_: bool;
    var phi_8767_: bool;
    var phi_8848_: bool;
    var phi_8854_: bool;
    var phi_8864_: bool;

    let _e263 = (*pos_9)[1u];
    let _e265 = tuning.gridHeight;
    if (_e263 >= (bitcast<i32>(_e265) - 2i)) {
        let _e270 = atomicAdd((&unnamed_1.cloudWaterCount), 1u);
        let _e271 = (*currentIndex_6);
        let _e274 = atomicExchange((&unnamed.grid[_e271]), 0u);
        return;
    }
    let _e275 = (*currentAge_5);
    newAge = min((_e275 + 1u), 255u);
    let _e278 = (*randVal_7);
    let _e282 = tuning.steamScatterChance;
    if (fract((_e278 * 88f)) < _e282) {
        let _e284 = (*randVal_7);
        d_9 = i32((fract((_e284 * 13f)) * 6f));
        let _e289 = (*pos_9);
        let _e290 = d_9;
        param_376 = _e290;
        let _e291 = getOrthoDir_u0028_i1_u003b((&param_376));
        scatterPos = (_e289 + _e291);
        let _e294 = scatterPos[0u];
        let _e295 = (_e294 > 0i);
        phi_8619_ = _e295;
        if _e295 {
            let _e297 = scatterPos[0u];
            let _e299 = tuning.gridWidth;
            phi_8619_ = (_e297 < (bitcast<i32>(_e299) - 1i));
        }
        let _e304 = phi_8619_;
        phi_8625_ = _e304;
        if _e304 {
            let _e306 = scatterPos[1u];
            phi_8625_ = (_e306 > 0i);
        }
        let _e309 = phi_8625_;
        phi_8635_ = _e309;
        if _e309 {
            let _e311 = scatterPos[1u];
            let _e313 = tuning.gridHeight;
            phi_8635_ = (_e311 < (bitcast<i32>(_e313) - 1i));
        }
        let _e318 = phi_8635_;
        phi_8641_ = _e318;
        if _e318 {
            let _e320 = scatterPos[2u];
            phi_8641_ = (_e320 > 0i);
        }
        let _e323 = phi_8641_;
        phi_8651_ = _e323;
        if _e323 {
            let _e325 = scatterPos[2u];
            let _e327 = tuning.gridDepth;
            phi_8651_ = (_e325 < (bitcast<i32>(_e327) - 1i));
        }
        let _e332 = phi_8651_;
        if _e332 {
            let _e333 = scatterPos;
            param_377 = _e333;
            let _e334 = getIndex_u0028_vi3_u003b((&param_377));
            param_378 = _e334;
            let _e335 = readCell_u0028_u1_u003b((&param_378));
            param_379 = _e335;
            let _e336 = getType_u0028_u1_u003b((&param_379));
            sType = _e336;
            let _e337 = sType;
            let _e339 = sType;
            if ((_e337 == 0u) || (_e339 == 5u)) {
                let _e342 = scatterPos;
                param_380 = _e342;
                let _e343 = getIndex_u0028_vi3_u003b((&param_380));
                param_381 = 6u;
                param_382 = 0u;
                param_383 = 0u;
                let _e344 = newAge;
                param_384 = _e344;
                let _e345 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_381), (&param_382), (&param_383), (&param_384));
                let _e346 = (*currentIndex_6);
                param_385 = _e346;
                let _e347 = (*rawValue_5);
                param_386 = _e347;
                param_387 = _e343;
                param_388 = _e345;
                let _e348 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_385), (&param_386), (&param_387), (&param_388));
                if _e348 {
                    return;
                }
            }
        }
    }
    let _e349 = (*pos_9);
    checkPos[0i] = (_e349 + vec3<i32>(0i, 1i, 0i));
    let _e352 = (*randVal_7);
    dir_1 = select(-1i, 1i, (fract((_e352 * 10f)) > 0.5f));
    let _e357 = (*randVal_7);
    if (fract((_e357 * 100f)) > 0.5f) {
        let _e361 = (*pos_9);
        let _e362 = dir_1;
        checkPos[1i] = (_e361 + vec3<i32>(_e362, 1i, 0i));
        let _e366 = (*pos_9);
        let _e367 = dir_1;
        checkPos[2i] = (_e366 + vec3<i32>(0i, 1i, _e367));
    } else {
        let _e371 = (*pos_9);
        let _e372 = dir_1;
        checkPos[1i] = (_e371 + vec3<i32>(0i, 1i, _e372));
        let _e376 = (*pos_9);
        let _e377 = dir_1;
        checkPos[2i] = (_e376 + vec3<i32>(_e377, 1i, 0i));
    }
    i_10 = 0i;
    loop {
        let _e381 = i_10;
        if (_e381 < 3i) {
            let _e383 = i_10;
            let _e385 = checkPos[_e383];
            cPos = _e385;
            let _e387 = cPos[0u];
            let _e388 = (_e387 > 0i);
            phi_8751_ = _e388;
            if _e388 {
                let _e390 = cPos[0u];
                let _e392 = tuning.gridWidth;
                phi_8751_ = (_e390 < (bitcast<i32>(_e392) - 1i));
            }
            let _e397 = phi_8751_;
            phi_8757_ = _e397;
            if _e397 {
                let _e399 = cPos[2u];
                phi_8757_ = (_e399 > 0i);
            }
            let _e402 = phi_8757_;
            phi_8767_ = _e402;
            if _e402 {
                let _e404 = cPos[2u];
                let _e406 = tuning.gridDepth;
                phi_8767_ = (_e404 < (bitcast<i32>(_e406) - 1i));
            }
            let _e411 = phi_8767_;
            if _e411 {
                let _e412 = cPos;
                param_389 = _e412;
                let _e413 = getIndex_u0028_vi3_u003b((&param_389));
                cIndex = _e413;
                let _e414 = cIndex;
                param_390 = _e414;
                let _e415 = readCell_u0028_u1_u003b((&param_390));
                cVal = _e415;
                let _e416 = cVal;
                param_391 = _e416;
                let _e417 = getType_u0028_u1_u003b((&param_391));
                cType = _e417;
                let _e418 = cType;
                let _e420 = cType;
                if ((_e418 == 1u) || (_e420 == 4u)) {
                    let _e423 = cVal;
                    param_392 = _e423;
                    let _e424 = getAge_u0028_u1_u003b((&param_392));
                    moisture_2 = _e424;
                    let _e425 = cType;
                    if (_e425 == 4u) {
                        let _e428 = tuning.dirtMoistureCapacity;
                        local_15 = _e428;
                    } else {
                        let _e430 = tuning.sandMoistureCapacity;
                        local_15 = _e430;
                    }
                    let _e431 = local_15;
                    capacity = _e431;
                    let _e432 = moisture_2;
                    let _e433 = capacity;
                    if (_e432 < _e433) {
                        let _e435 = (*currentIndex_6);
                        let _e438 = (*rawValue_5);
                        let _e439 = atomicCompareExchangeWeak((&unnamed.grid[_e435]), _e438, 0u);
                        let _e441 = (*rawValue_5);
                        if (_e439.old_value == _e441) {
                            let _e443 = cIndex;
                            let _e446 = atomicAdd((&unnamed.grid[_e443]), 16777216u);
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
            let _e447 = i_10;
            i_10 = (_e447 + 1i);
        }
    }
    i_11 = 0i;
    loop {
        let _e449 = i_11;
        if (_e449 < 3i) {
            let _e451 = i_11;
            let _e453 = checkPos[_e451];
            sPos_1 = _e453;
            let _e455 = sPos_1[0u];
            let _e456 = (_e455 > 0i);
            phi_8848_ = _e456;
            if _e456 {
                let _e458 = sPos_1[0u];
                let _e460 = tuning.gridWidth;
                phi_8848_ = (_e458 < (bitcast<i32>(_e460) - 1i));
            }
            let _e465 = phi_8848_;
            phi_8854_ = _e465;
            if _e465 {
                let _e467 = sPos_1[2u];
                phi_8854_ = (_e467 > 0i);
            }
            let _e470 = phi_8854_;
            phi_8864_ = _e470;
            if _e470 {
                let _e472 = sPos_1[2u];
                let _e474 = tuning.gridDepth;
                phi_8864_ = (_e472 < (bitcast<i32>(_e474) - 1i));
            }
            let _e479 = phi_8864_;
            if _e479 {
                let _e480 = sPos_1;
                param_393 = _e480;
                let _e481 = getIndex_u0028_vi3_u003b((&param_393));
                param_394 = _e481;
                let _e482 = readCell_u0028_u1_u003b((&param_394));
                param_395 = _e482;
                let _e483 = getType_u0028_u1_u003b((&param_395));
                sType_1 = _e483;
                let _e484 = sType_1;
                let _e486 = sType_1;
                if ((_e484 == 0u) || (_e486 == 5u)) {
                    let _e489 = sPos_1;
                    param_396 = _e489;
                    let _e490 = getIndex_u0028_vi3_u003b((&param_396));
                    param_397 = 6u;
                    param_398 = 0u;
                    param_399 = 0u;
                    let _e491 = newAge;
                    param_400 = _e491;
                    let _e492 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_397), (&param_398), (&param_399), (&param_400));
                    let _e493 = (*currentIndex_6);
                    param_401 = _e493;
                    let _e494 = (*rawValue_5);
                    param_402 = _e494;
                    param_403 = _e490;
                    param_404 = _e492;
                    let _e495 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_401), (&param_402), (&param_403), (&param_404));
                    if _e495 {
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e496 = i_11;
            i_11 = (_e496 + 1i);
        }
    }
    let _e498 = (*currentSleep_2);
    newSleep_1 = min((_e498 + 1u), 255u);
    let _e501 = (*currentIndex_6);
    let _e504 = (*rawValue_5);
    param_405 = 6u;
    param_406 = 0u;
    let _e505 = newSleep_1;
    param_407 = _e505;
    let _e506 = newAge;
    param_408 = _e506;
    let _e507 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_405), (&param_406), (&param_407), (&param_408));
    let _e508 = atomicCompareExchangeWeak((&unnamed.grid[_e501]), _e504, _e507);
    return;
}

fn updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_10: ptr<function, vec3<i32>>, currentIndex_7: ptr<function, u32>, rawValue_6: ptr<function, u32>, currentDir_3: ptr<function, u32>, currentSleep_3: ptr<function, u32>, currentAge_6: ptr<function, u32>, randVal_8: ptr<function, f32>) {
    var newAge_1: u32;
    var isBurningGrass: bool;
    var i_12: i32;
    var nPos_1: vec3<i32>;
    var param_409: i32;
    var nIndex_1: u32;
    var param_410: vec3<i32>;
    var nVal_1: u32;
    var param_411: u32;
    var param_412: u32;
    var param_413: u32;
    var param_414: u32;
    var param_415: u32;
    var param_416: u32;
    var burnRoll: f32;
    var start_6: i32;
    var i_13: i32;
    var nPos_2: vec3<i32>;
    var param_417: i32;
    var param_418: vec3<i32>;
    var nIndex_2: u32;
    var param_419: vec3<i32>;
    var nVal_2: u32;
    var param_420: u32;
    var nType_1: u32;
    var param_421: u32;
    var need_1: f32;
    var local_16: f32;
    var param_422: u32;
    var param_423: u32;
    var param_424: u32;
    var param_425: u32;
    var belowPos_4: vec3<i32>;
    var belowIndex_1: u32;
    var param_426: vec3<i32>;
    var belowValue_1: u32;
    var param_427: u32;
    var belowType: u32;
    var param_428: u32;
    var param_429: u32;
    var param_430: u32;
    var param_431: u32;
    var param_432: u32;
    var param_433: u32;
    var param_434: u32;
    var param_435: u32;
    var param_436: u32;
    var moisture_3: u32;
    var param_437: u32;
    var newMoisture: u32;
    var local_17: u32;
    var newVal: u32;
    var param_438: u32;
    var param_439: u32;
    var param_440: u32;
    var param_441: u32;
    var param_442: u32;
    var flora_3: u32;
    var newFlora: u32;
    var newVal_1: u32;
    var param_443: u32;
    var param_444: u32;
    var param_445: u32;
    var param_446: u32;
    var param_447: u32;
    var d_10: i32;
    var targetPos_1: vec3<i32>;
    var param_448: i32;
    var targetIndex_1: u32;
    var param_449: vec3<i32>;
    var param_450: u32;
    var param_451: u32;
    var targetBelow: vec3<i32>;
    var tBelowVal: u32;
    var param_452: vec3<i32>;
    var param_453: u32;
    var param_454: u32;
    var tFlora: u32;
    var param_455: u32;
    var param_456: u32;
    var param_457: u32;
    var param_458: u32;
    var param_459: u32;
    var param_460: u32;
    var param_461: u32;
    var param_462: u32;
    var phi_7866_: bool;
    var phi_7872_: bool;
    var phi_7882_: bool;
    var phi_7888_: bool;
    var phi_7898_: bool;
    var phi_8206_: bool;
    var phi_8212_: bool;
    var phi_8222_: bool;

    let _e298 = (*currentAge_6);
    newAge_1 = (_e298 + 1u);
    isBurningGrass = false;
    i_12 = 0i;
    loop {
        let _e300 = i_12;
        if (_e300 < 6i) {
            let _e302 = (*pos_10);
            let _e303 = i_12;
            param_409 = _e303;
            let _e304 = getOrthoDir_u0028_i1_u003b((&param_409));
            nPos_1 = (_e302 + _e304);
            let _e307 = nPos_1[0u];
            let _e308 = (_e307 > 0i);
            phi_7866_ = _e308;
            if _e308 {
                let _e310 = nPos_1[0u];
                let _e312 = tuning.gridWidth;
                phi_7866_ = (_e310 < (bitcast<i32>(_e312) - 1i));
            }
            let _e317 = phi_7866_;
            phi_7872_ = _e317;
            if _e317 {
                let _e319 = nPos_1[1u];
                phi_7872_ = (_e319 > 0i);
            }
            let _e322 = phi_7872_;
            phi_7882_ = _e322;
            if _e322 {
                let _e324 = nPos_1[1u];
                let _e326 = tuning.gridHeight;
                phi_7882_ = (_e324 < (bitcast<i32>(_e326) - 1i));
            }
            let _e331 = phi_7882_;
            phi_7888_ = _e331;
            if _e331 {
                let _e333 = nPos_1[2u];
                phi_7888_ = (_e333 > 0i);
            }
            let _e336 = phi_7888_;
            phi_7898_ = _e336;
            if _e336 {
                let _e338 = nPos_1[2u];
                let _e340 = tuning.gridDepth;
                phi_7898_ = (_e338 < (bitcast<i32>(_e340) - 1i));
            }
            let _e345 = phi_7898_;
            if _e345 {
                let _e346 = nPos_1;
                param_410 = _e346;
                let _e347 = getIndex_u0028_vi3_u003b((&param_410));
                nIndex_1 = _e347;
                let _e348 = nIndex_1;
                param_411 = _e348;
                let _e349 = readCell_u0028_u1_u003b((&param_411));
                nVal_1 = _e349;
                let _e350 = nVal_1;
                param_412 = _e350;
                let _e351 = getType_u0028_u1_u003b((&param_412));
                if (_e351 == 2u) {
                    let _e353 = nIndex_1;
                    let _e356 = nVal_1;
                    param_413 = 6u;
                    param_414 = 0u;
                    param_415 = 0u;
                    param_416 = 0u;
                    let _e357 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_413), (&param_414), (&param_415), (&param_416));
                    let _e358 = atomicCompareExchangeWeak((&unnamed.grid[_e353]), _e356, _e357);
                    let _e360 = nVal_1;
                    if (_e358.old_value == _e360) {
                        decWater_u0028_();
                        let _e362 = (*currentIndex_7);
                        let _e365 = atomicExchange((&unnamed.grid[_e362]), 0u);
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e366 = i_12;
            i_12 = (_e366 + 1i);
        }
    }
    let _e368 = (*randVal_8);
    burnRoll = fract((_e368 * 47f));
    let _e371 = burnRoll;
    let _e373 = tuning.treeLeafBurnChance;
    let _e375 = tuning.treeTrunkBurnChance;
    if (_e371 < max(_e373, _e375)) {
        let _e378 = (*randVal_8);
        start_6 = i32((fract((_e378 * 31f)) * 26f));
        i_13 = 0i;
        loop {
            let _e383 = i_13;
            if (_e383 < 26i) {
                let _e385 = (*pos_10);
                let _e386 = start_6;
                let _e387 = i_13;
                let _e388 = (_e386 + _e387);
                param_417 = (_e388 - (i32(floor((f32(_e388) / f32(26i)))) * 26i));
                let _e396 = tree26_u0028_i1_u003b((&param_417));
                nPos_2 = (_e385 + _e396);
                let _e398 = nPos_2;
                param_418 = _e398;
                let _e399 = treeInBounds_u0028_vi3_u003b((&param_418));
                if !(_e399) {
                    continue;
                }
                let _e401 = nPos_2;
                param_419 = _e401;
                let _e402 = getIndex_u0028_vi3_u003b((&param_419));
                nIndex_2 = _e402;
                let _e403 = nIndex_2;
                param_420 = _e403;
                let _e404 = readCell_u0028_u1_u003b((&param_420));
                nVal_2 = _e404;
                let _e405 = nVal_2;
                param_421 = _e405;
                let _e406 = getType_u0028_u1_u003b((&param_421));
                nType_1 = _e406;
                let _e407 = nType_1;
                let _e409 = nType_1;
                if ((_e407 != 19u) && (_e409 != 18u)) {
                    continue;
                }
                let _e412 = nType_1;
                if (_e412 == 19u) {
                    let _e415 = tuning.treeLeafBurnChance;
                    local_16 = _e415;
                } else {
                    let _e417 = tuning.treeTrunkBurnChance;
                    local_16 = _e417;
                }
                let _e418 = local_16;
                need_1 = _e418;
                let _e419 = burnRoll;
                let _e420 = need_1;
                if (_e419 < _e420) {
                    let _e422 = nIndex_2;
                    let _e425 = nVal_2;
                    param_422 = 5u;
                    param_423 = 0u;
                    param_424 = 0u;
                    param_425 = 0u;
                    let _e426 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_422), (&param_423), (&param_424), (&param_425));
                    let _e427 = atomicCompareExchangeWeak((&unnamed.grid[_e422]), _e425, _e426);
                }
                break;
            } else {
                break;
            }
            continuing {
                let _e429 = i_13;
                i_13 = (_e429 + 1i);
            }
        }
    }
    let _e432 = (*pos_10)[1u];
    if (_e432 > 1i) {
        let _e434 = (*pos_10);
        belowPos_4 = (_e434 + vec3<i32>(0i, -1i, 0i));
        let _e436 = belowPos_4;
        param_426 = _e436;
        let _e437 = getIndex_u0028_vi3_u003b((&param_426));
        belowIndex_1 = _e437;
        let _e438 = belowIndex_1;
        param_427 = _e438;
        let _e439 = readCell_u0028_u1_u003b((&param_427));
        belowValue_1 = _e439;
        let _e440 = belowValue_1;
        param_428 = _e440;
        let _e441 = getType_u0028_u1_u003b((&param_428));
        belowType = _e441;
        let _e442 = belowType;
        if (_e442 == 0u) {
            param_429 = 5u;
            param_430 = 0u;
            param_431 = 0u;
            let _e444 = newAge_1;
            param_432 = _e444;
            let _e445 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_429), (&param_430), (&param_431), (&param_432));
            let _e446 = (*currentIndex_7);
            param_433 = _e446;
            let _e447 = (*rawValue_6);
            param_434 = _e447;
            let _e448 = belowIndex_1;
            param_435 = _e448;
            param_436 = _e445;
            let _e449 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_433), (&param_434), (&param_435), (&param_436));
            if _e449 {
                return;
            }
        } else {
            let _e450 = belowType;
            if (_e450 == 2u) {
                let _e452 = (*currentIndex_7);
                let _e455 = atomicExchange((&unnamed.grid[_e452]), 0u);
                return;
            } else {
                let _e456 = belowType;
                if (_e456 == 1u) {
                    let _e458 = belowValue_1;
                    param_437 = _e458;
                    let _e459 = getAge_u0028_u1_u003b((&param_437));
                    moisture_3 = _e459;
                    let _e460 = moisture_3;
                    if (_e460 > 0u) {
                        let _e462 = moisture_3;
                        let _e464 = tuning.fireDryRate;
                        if (_e462 > _e464) {
                            let _e466 = moisture_3;
                            let _e468 = tuning.fireDryRate;
                            local_17 = (_e466 - _e468);
                        } else {
                            local_17 = 0u;
                        }
                        let _e470 = local_17;
                        newMoisture = _e470;
                        let _e471 = belowValue_1;
                        param_438 = _e471;
                        let _e472 = getDir_u0028_u1_u003b((&param_438));
                        param_439 = 1u;
                        param_440 = _e472;
                        param_441 = 0u;
                        let _e473 = newMoisture;
                        param_442 = _e473;
                        let _e474 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_439), (&param_440), (&param_441), (&param_442));
                        newVal = _e474;
                        let _e475 = belowIndex_1;
                        let _e478 = belowValue_1;
                        let _e479 = newVal;
                        let _e480 = atomicCompareExchangeWeak((&unnamed.grid[_e475]), _e478, _e479);
                        let _e482 = belowValue_1;
                        if (_e480.old_value == _e482) {
                            let _e484 = (*currentIndex_7);
                            let _e487 = atomicExchange((&unnamed.grid[_e484]), 0u);
                            return;
                        }
                    }
                } else {
                    let _e488 = belowType;
                    if (_e488 == 4u) {
                        let _e490 = belowValue_1;
                        flora_3 = ((_e490 >> bitcast<u32>(8i)) & 255u);
                        let _e494 = flora_3;
                        let _e496 = flora_3;
                        if ((_e494 > 10u) && (_e496 <= 100u)) {
                            isBurningGrass = true;
                            newAge_1 = 0u;
                            let _e499 = (*randVal_8);
                            let _e503 = tuning.fireBurnGrassChance;
                            if (fract((_e499 * 100f)) < _e503) {
                                let _e505 = flora_3;
                                newFlora = (_e505 - 1u);
                                let _e507 = belowValue_1;
                                param_443 = _e507;
                                let _e508 = getAge_u0028_u1_u003b((&param_443));
                                param_444 = 4u;
                                let _e509 = newFlora;
                                param_445 = _e509;
                                param_446 = 0u;
                                param_447 = _e508;
                                let _e510 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_444), (&param_445), (&param_446), (&param_447));
                                newVal_1 = _e510;
                                let _e511 = belowIndex_1;
                                let _e514 = belowValue_1;
                                let _e515 = newVal_1;
                                let _e516 = atomicCompareExchangeWeak((&unnamed.grid[_e511]), _e514, _e515);
                            }
                            let _e518 = (*randVal_8);
                            let _e522 = tuning.fireSpreadChance;
                            if (fract((_e518 * 100f)) < _e522) {
                                let _e524 = (*randVal_8);
                                d_10 = i32((fract((_e524 * 10f)) * 8f));
                                let _e529 = (*pos_10);
                                let _e530 = d_10;
                                param_448 = _e530;
                                let _e531 = getHDir_u0028_i1_u003b((&param_448));
                                targetPos_1 = (_e529 + _e531);
                                let _e534 = targetPos_1[0u];
                                let _e535 = (_e534 > 0i);
                                phi_8206_ = _e535;
                                if _e535 {
                                    let _e537 = targetPos_1[0u];
                                    let _e539 = tuning.gridWidth;
                                    phi_8206_ = (_e537 < (bitcast<i32>(_e539) - 1i));
                                }
                                let _e544 = phi_8206_;
                                phi_8212_ = _e544;
                                if _e544 {
                                    let _e546 = targetPos_1[2u];
                                    phi_8212_ = (_e546 > 0i);
                                }
                                let _e549 = phi_8212_;
                                phi_8222_ = _e549;
                                if _e549 {
                                    let _e551 = targetPos_1[2u];
                                    let _e553 = tuning.gridDepth;
                                    phi_8222_ = (_e551 < (bitcast<i32>(_e553) - 1i));
                                }
                                let _e558 = phi_8222_;
                                if _e558 {
                                    let _e559 = targetPos_1;
                                    param_449 = _e559;
                                    let _e560 = getIndex_u0028_vi3_u003b((&param_449));
                                    targetIndex_1 = _e560;
                                    let _e561 = targetIndex_1;
                                    param_450 = _e561;
                                    let _e562 = readCell_u0028_u1_u003b((&param_450));
                                    param_451 = _e562;
                                    let _e563 = getType_u0028_u1_u003b((&param_451));
                                    if (_e563 == 0u) {
                                        let _e565 = targetPos_1;
                                        targetBelow = (_e565 + vec3<i32>(0i, -1i, 0i));
                                        let _e567 = targetBelow;
                                        param_452 = _e567;
                                        let _e568 = getIndex_u0028_vi3_u003b((&param_452));
                                        param_453 = _e568;
                                        let _e569 = readCell_u0028_u1_u003b((&param_453));
                                        tBelowVal = _e569;
                                        let _e570 = tBelowVal;
                                        param_454 = _e570;
                                        let _e571 = getType_u0028_u1_u003b((&param_454));
                                        if (_e571 == 4u) {
                                            let _e573 = tBelowVal;
                                            tFlora = ((_e573 >> bitcast<u32>(8i)) & 255u);
                                            let _e577 = tFlora;
                                            let _e579 = tFlora;
                                            if ((_e577 > 10u) && (_e579 <= 100u)) {
                                                let _e582 = targetIndex_1;
                                                param_455 = 5u;
                                                param_456 = 0u;
                                                param_457 = 0u;
                                                param_458 = 0u;
                                                let _e585 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_455), (&param_456), (&param_457), (&param_458));
                                                let _e586 = atomicCompareExchangeWeak((&unnamed.grid[_e582]), 0u, _e585);
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
    let _e588 = newAge_1;
    let _e590 = tuning.fireLifetime;
    if (_e588 > _e590) {
        let _e592 = (*currentIndex_7);
        let _e595 = atomicExchange((&unnamed.grid[_e592]), 0u);
        return;
    }
    let _e596 = (*currentIndex_7);
    let _e599 = (*rawValue_6);
    param_459 = 5u;
    param_460 = 0u;
    param_461 = 0u;
    let _e600 = newAge_1;
    param_462 = _e600;
    let _e601 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_459), (&param_460), (&param_461), (&param_462));
    let _e602 = atomicCompareExchangeWeak((&unnamed.grid[_e596]), _e599, _e601);
    return;
}

fn isLocust_u0028_u1_u003b(type_38: ptr<function, u32>) -> bool {
    let _e206 = (*type_38);
    let _e208 = (*type_38);
    return ((_e206 >= 13u) && (_e208 <= 17u));
}

fn tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b(currentIndex_8: ptr<function, u32>, currentValue_1: ptr<function, u32>, targetIndex_2: ptr<function, u32>, targetValue_1: ptr<function, u32>, pushIndex: ptr<function, u32>) -> bool {
    var displacedValue: u32;
    var param_463: u32;
    var param_464: u32;
    var param_465: u32;
    var param_466: u32;
    var param_467: u32;
    var actualPush: u32;
    var actualTarget: u32;

    let _e218 = (*currentIndex_8);
    let _e221 = (*currentValue_1);
    let _e222 = atomicCompareExchangeWeak((&unnamed.grid[_e218]), _e221, 0u);
    let _e224 = (*currentValue_1);
    if (_e222.old_value == _e224) {
        let _e226 = (*targetValue_1);
        param_463 = _e226;
        let _e227 = getType_u0028_u1_u003b((&param_463));
        param_464 = _e227;
        param_465 = 0u;
        param_466 = 0u;
        param_467 = 0u;
        let _e228 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_464), (&param_465), (&param_466), (&param_467));
        displacedValue = _e228;
        let _e229 = (*pushIndex);
        let _e232 = displacedValue;
        let _e233 = atomicCompareExchangeWeak((&unnamed.grid[_e229]), 0u, _e232);
        actualPush = _e233.old_value;
        let _e235 = actualPush;
        if (_e235 == 0u) {
            let _e237 = (*targetIndex_2);
            let _e240 = (*targetValue_1);
            let _e241 = (*currentValue_1);
            let _e242 = atomicCompareExchangeWeak((&unnamed.grid[_e237]), _e240, _e241);
            actualTarget = _e242.old_value;
            let _e244 = actualTarget;
            let _e245 = (*targetValue_1);
            if (_e244 == _e245) {
                return true;
            } else {
                let _e247 = (*pushIndex);
                let _e250 = displacedValue;
                let _e251 = atomicCompareExchangeWeak((&unnamed.grid[_e247]), _e250, 0u);
            }
        }
        let _e253 = (*currentIndex_8);
        let _e256 = (*currentValue_1);
        let _e257 = atomicCompareExchangeWeak((&unnamed.grid[_e253]), 0u, _e256);
    }
    return false;
}

fn grainCanMove_u0028_vi3_u003b(pos_11: ptr<function, vec3<i32>>) -> bool {
    var i_14: i32;
    var target_1: vec3<i32>;
    var local_18: i32;
    var local_19: i32;
    var t_3: u32;
    var param_468: vec3<i32>;
    var param_469: u32;
    var param_470: u32;
    var phi_2541_: bool;
    var phi_2548_: bool;
    var phi_2559_: bool;

    let _e215 = (*pos_11)[1u];
    if (_e215 <= 1i) {
        return false;
    }
    i_14 = 0i;
    loop {
        let _e217 = i_14;
        if (_e217 < 5i) {
            let _e219 = (*pos_11);
            let _e220 = i_14;
            if (_e220 == 1i) {
                local_18 = 1i;
            } else {
                let _e222 = i_14;
                local_18 = select(0i, -1i, (_e222 == 2i));
            }
            let _e225 = local_18;
            let _e226 = i_14;
            if (_e226 == 3i) {
                local_19 = 1i;
            } else {
                let _e228 = i_14;
                local_19 = select(0i, -1i, (_e228 == 4i));
            }
            let _e231 = local_19;
            target_1 = (_e219 + vec3<i32>(_e225, -1i, _e231));
            let _e235 = target_1[0u];
            let _e236 = (_e235 <= 0i);
            phi_2541_ = _e236;
            if !(_e236) {
                let _e239 = target_1[0u];
                let _e241 = tuning.gridWidth;
                phi_2541_ = (_e239 >= (bitcast<i32>(_e241) - 1i));
            }
            let _e246 = phi_2541_;
            phi_2548_ = _e246;
            if !(_e246) {
                let _e249 = target_1[2u];
                phi_2548_ = (_e249 <= 0i);
            }
            let _e252 = phi_2548_;
            phi_2559_ = _e252;
            if !(_e252) {
                let _e255 = target_1[2u];
                let _e257 = tuning.gridDepth;
                phi_2559_ = (_e255 >= (bitcast<i32>(_e257) - 1i));
            }
            let _e262 = phi_2559_;
            if _e262 {
                continue;
            }
            let _e263 = target_1;
            param_468 = _e263;
            let _e264 = getIndex_u0028_vi3_u003b((&param_468));
            param_469 = _e264;
            let _e265 = readCell_u0028_u1_u003b((&param_469));
            param_470 = _e265;
            let _e266 = getType_u0028_u1_u003b((&param_470));
            t_3 = _e266;
            let _e267 = t_3;
            let _e269 = t_3;
            if ((_e267 == 0u) || (_e269 == 2u)) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e272 = i_14;
            i_14 = (_e272 + 1i);
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
    var param_471: i32;
    var nIndex_3: u32;
    var param_472: vec3<i32>;
    var nVal_3: u32;
    var param_473: u32;
    var param_474: u32;
    var d_12: i32;
    var nPos_4: vec3<i32>;
    var param_475: i32;
    var nIndex_4: u32;
    var param_476: vec3<i32>;
    var nVal_4: u32;
    var param_477: u32;
    var nType_2: u32;
    var param_478: u32;
    var nMoisture: u32;
    var param_479: u32;
    var nCapacity: u32;
    var local_20: u32;
    var canMove: bool;
    var param_480: vec3<i32>;
    var isClumped: bool;
    var emptyBelowCount: i32;
    var x: i32;
    var z: i32;
    var checkPos_1: vec3<i32>;
    var param_481: vec3<i32>;
    var param_482: u32;
    var param_483: u32;
    var clumpCount: i32;
    var x_1: i32;
    var y: i32;
    var z_1: i32;
    var nPos_5: vec3<i32>;
    var param_484: vec3<i32>;
    var param_485: u32;
    var param_486: u32;
    var belowPos_5: vec3<i32>;
    var param_487: vec3<i32>;
    var param_488: u32;
    var param_489: u32;
    var param_490: vec3<i32>;
    var param_491: u32;
    var param_492: u32;
    var param_493: u32;
    var param_494: u32;
    var param_495: u32;
    var param_496: u32;
    var param_497: u32;
    var param_498: u32;
    var dir_2: i32;
    var slidePos1_: vec3<i32>;
    var slidePos2_: vec3<i32>;
    var param_499: vec3<i32>;
    var param_500: u32;
    var param_501: u32;
    var param_502: vec3<i32>;
    var param_503: u32;
    var param_504: u32;
    var param_505: u32;
    var param_506: u32;
    var param_507: u32;
    var param_508: u32;
    var param_509: u32;
    var param_510: u32;
    var param_511: vec3<i32>;
    var param_512: u32;
    var param_513: u32;
    var param_514: vec3<i32>;
    var param_515: u32;
    var param_516: u32;
    var param_517: u32;
    var param_518: u32;
    var param_519: u32;
    var param_520: u32;
    var param_521: u32;
    var param_522: u32;
    var belowPos_6: vec3<i32>;
    var belowIndex_2: u32;
    var param_523: vec3<i32>;
    var belowValue_2: u32;
    var param_524: u32;
    var param_525: u32;
    var startDir_2: i32;
    var i_16: i32;
    var d_13: i32;
    var pushPos: vec3<i32>;
    var param_526: i32;
    var param_527: u32;
    var param_528: u32;
    var param_529: u32;
    var param_530: u32;
    var param_531: vec3<i32>;
    var param_532: u32;
    var param_533: u32;
    var param_534: u32;
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
    var dir_3: i32;
    var slidePos: array<vec3<i32>, 2>;
    var s_1: i32;
    var sPos_2: vec3<i32>;
    var sIndex: u32;
    var param_545: vec3<i32>;
    var sValue: u32;
    var param_546: u32;
    var param_547: u32;
    var startDir_3: i32;
    var i_17: i32;
    var d_14: i32;
    var pushPos_1: vec3<i32>;
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
    var floraState: u32;
    var abovePos_1: vec3<i32>;
    var aboveInside: bool;
    var aboveIndex: u32;
    var param_567: vec3<i32>;
    var aboveType: u32;
    var local_21: u32;
    var param_568: u32;
    var param_569: u32;
    var param_570: u32;
    var param_571: u32;
    var param_572: u32;
    var param_573: u32;
    var param_574: u32;
    var newSleep_2: u32;
    var param_575: u32;
    var param_576: u32;
    var param_577: u32;
    var param_578: u32;
    var phi_3671_: bool;
    var phi_3677_: bool;
    var phi_3687_: bool;
    var phi_3693_: bool;
    var phi_3703_: bool;
    var phi_3769_: bool;
    var phi_3775_: bool;
    var phi_3785_: bool;
    var phi_3791_: bool;
    var phi_3801_: bool;
    var phi_3871_: bool;
    var phi_3913_: bool;
    var phi_3919_: bool;
    var phi_3928_: bool;
    var phi_4009_: bool;
    var phi_4015_: bool;
    var phi_4024_: bool;
    var phi_4030_: bool;
    var phi_4039_: bool;
    var phi_4158_: bool;
    var phi_4164_: bool;
    var phi_4174_: bool;
    var phi_4218_: bool;
    var phi_4224_: bool;
    var phi_4234_: bool;
    var phi_4325_: bool;
    var phi_4331_: bool;
    var phi_4341_: bool;
    var phi_4442_: bool;
    var phi_4448_: bool;
    var phi_4458_: bool;
    var phi_4515_: bool;
    var phi_4521_: bool;
    var phi_4531_: bool;
    var phi_4586_: bool;
    var phi_4660_: bool;
    var phi_4715_: bool;

    let _e375 = (*currentAge_7);
    moisture_4 = _e375;
    moistureModified = false;
    let _e376 = moisture_4;
    let _e378 = tuning.dirtMoistureCapacity;
    if (_e376 < _e378) {
        let _e380 = (*randVal_9);
        startDir_1 = i32((fract((_e380 * 17f)) * 6f));
        i_15 = 0i;
        loop {
            let _e385 = i_15;
            if (_e385 < 6i) {
                let _e387 = startDir_1;
                let _e388 = i_15;
                let _e389 = (_e387 + _e388);
                d_11 = (_e389 - (i32(floor((f32(_e389) / f32(6i)))) * 6i));
                let _e397 = (*pos_12);
                let _e398 = d_11;
                param_471 = _e398;
                let _e399 = getOrthoDir_u0028_i1_u003b((&param_471));
                nPos_3 = (_e397 + _e399);
                let _e402 = nPos_3[0u];
                let _e403 = (_e402 > 0i);
                phi_3671_ = _e403;
                if _e403 {
                    let _e405 = nPos_3[0u];
                    let _e407 = tuning.gridWidth;
                    phi_3671_ = (_e405 < (bitcast<i32>(_e407) - 1i));
                }
                let _e412 = phi_3671_;
                phi_3677_ = _e412;
                if _e412 {
                    let _e414 = nPos_3[1u];
                    phi_3677_ = (_e414 > 0i);
                }
                let _e417 = phi_3677_;
                phi_3687_ = _e417;
                if _e417 {
                    let _e419 = nPos_3[1u];
                    let _e421 = tuning.gridHeight;
                    phi_3687_ = (_e419 < (bitcast<i32>(_e421) - 1i));
                }
                let _e426 = phi_3687_;
                phi_3693_ = _e426;
                if _e426 {
                    let _e428 = nPos_3[2u];
                    phi_3693_ = (_e428 > 0i);
                }
                let _e431 = phi_3693_;
                phi_3703_ = _e431;
                if _e431 {
                    let _e433 = nPos_3[2u];
                    let _e435 = tuning.gridDepth;
                    phi_3703_ = (_e433 < (bitcast<i32>(_e435) - 1i));
                }
                let _e440 = phi_3703_;
                if _e440 {
                    let _e441 = nPos_3;
                    param_472 = _e441;
                    let _e442 = getIndex_u0028_vi3_u003b((&param_472));
                    nIndex_3 = _e442;
                    let _e443 = nIndex_3;
                    param_473 = _e443;
                    let _e444 = readCell_u0028_u1_u003b((&param_473));
                    nVal_3 = _e444;
                    let _e445 = nVal_3;
                    param_474 = _e445;
                    let _e446 = getType_u0028_u1_u003b((&param_474));
                    if (_e446 == 2u) {
                        let _e448 = nIndex_3;
                        let _e451 = nVal_3;
                        let _e452 = atomicCompareExchangeWeak((&unnamed.grid[_e448]), _e451, 0u);
                        let _e454 = nVal_3;
                        if (_e452.old_value == _e454) {
                            let _e456 = (*currentIndex_9);
                            let _e460 = tuning.sandWaterAbsorbUnit;
                            let _e463 = atomicAdd((&unnamed.grid[_e456]), (_e460 << bitcast<u32>(24i)));
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
                let _e464 = i_15;
                i_15 = (_e464 + 1i);
            }
        }
    }
    let _e466 = moistureModified;
    let _e468 = moisture_4;
    if (!(_e466) && (_e468 > 0u)) {
        let _e471 = (*randVal_9);
        d_12 = i32((fract((_e471 * 31f)) * 6f));
        let _e476 = (*pos_12);
        let _e477 = d_12;
        param_475 = _e477;
        let _e478 = getOrthoDir_u0028_i1_u003b((&param_475));
        nPos_4 = (_e476 + _e478);
        let _e481 = nPos_4[0u];
        let _e482 = (_e481 > 0i);
        phi_3769_ = _e482;
        if _e482 {
            let _e484 = nPos_4[0u];
            let _e486 = tuning.gridWidth;
            phi_3769_ = (_e484 < (bitcast<i32>(_e486) - 1i));
        }
        let _e491 = phi_3769_;
        phi_3775_ = _e491;
        if _e491 {
            let _e493 = nPos_4[1u];
            phi_3775_ = (_e493 > 0i);
        }
        let _e496 = phi_3775_;
        phi_3785_ = _e496;
        if _e496 {
            let _e498 = nPos_4[1u];
            let _e500 = tuning.gridHeight;
            phi_3785_ = (_e498 < (bitcast<i32>(_e500) - 1i));
        }
        let _e505 = phi_3785_;
        phi_3791_ = _e505;
        if _e505 {
            let _e507 = nPos_4[2u];
            phi_3791_ = (_e507 > 0i);
        }
        let _e510 = phi_3791_;
        phi_3801_ = _e510;
        if _e510 {
            let _e512 = nPos_4[2u];
            let _e514 = tuning.gridDepth;
            phi_3801_ = (_e512 < (bitcast<i32>(_e514) - 1i));
        }
        let _e519 = phi_3801_;
        if _e519 {
            let _e520 = nPos_4;
            param_476 = _e520;
            let _e521 = getIndex_u0028_vi3_u003b((&param_476));
            nIndex_4 = _e521;
            let _e522 = nIndex_4;
            param_477 = _e522;
            let _e523 = readCell_u0028_u1_u003b((&param_477));
            nVal_4 = _e523;
            let _e524 = nVal_4;
            param_478 = _e524;
            let _e525 = getType_u0028_u1_u003b((&param_478));
            nType_2 = _e525;
            let _e526 = nType_2;
            let _e528 = nType_2;
            if ((_e526 == 4u) || (_e528 == 1u)) {
                let _e531 = nVal_4;
                param_479 = _e531;
                let _e532 = getAge_u0028_u1_u003b((&param_479));
                nMoisture = _e532;
                let _e533 = nType_2;
                if (_e533 == 4u) {
                    let _e536 = tuning.dirtMoistureCapacity;
                    local_20 = _e536;
                } else {
                    let _e538 = tuning.sandMoistureCapacity;
                    local_20 = _e538;
                }
                let _e539 = local_20;
                nCapacity = _e539;
                let _e540 = moisture_4;
                let _e541 = nMoisture;
                let _e544 = nMoisture;
                let _e545 = nCapacity;
                if ((_e540 > (_e541 + 1u)) && (_e544 < _e545)) {
                    let _e548 = (*currentIndex_9);
                    let _e551 = atomicAdd((&unnamed.grid[_e548]), 4278190080u);
                    let _e552 = nIndex_4;
                    let _e555 = atomicAdd((&unnamed.grid[_e552]), 16777216u);
                    moistureModified = true;
                }
            }
        }
    }
    let _e556 = moistureModified;
    if _e556 {
        return;
    }
    let _e557 = (*pos_12);
    param_480 = _e557;
    let _e558 = grainCanMove_u0028_vi3_u003b((&param_480));
    canMove = _e558;
    isClumped = false;
    let _e559 = canMove;
    phi_3871_ = _e559;
    if _e559 {
        let _e560 = (*currentSleep_4);
        let _e562 = tuning.wakeSleepThreshold;
        phi_3871_ = (_e560 > _e562);
    }
    let _e565 = phi_3871_;
    if _e565 {
        emptyBelowCount = 0i;
        let _e567 = (*pos_12)[1u];
        if (_e567 > 1i) {
            x = -1i;
            loop {
                let _e569 = x;
                if (_e569 <= 1i) {
                    z = -1i;
                    loop {
                        let _e571 = z;
                        if (_e571 <= 1i) {
                            let _e573 = (*pos_12);
                            let _e574 = x;
                            let _e575 = z;
                            checkPos_1 = (_e573 + vec3<i32>(_e574, -1i, _e575));
                            let _e579 = checkPos_1[0u];
                            let _e580 = (_e579 >= 0i);
                            phi_3913_ = _e580;
                            if _e580 {
                                let _e582 = checkPos_1[0u];
                                let _e584 = tuning.gridWidth;
                                phi_3913_ = (_e582 < bitcast<i32>(_e584));
                            }
                            let _e588 = phi_3913_;
                            phi_3919_ = _e588;
                            if _e588 {
                                let _e590 = checkPos_1[2u];
                                phi_3919_ = (_e590 >= 0i);
                            }
                            let _e593 = phi_3919_;
                            phi_3928_ = _e593;
                            if _e593 {
                                let _e595 = checkPos_1[2u];
                                let _e597 = tuning.gridDepth;
                                phi_3928_ = (_e595 < bitcast<i32>(_e597));
                            }
                            let _e601 = phi_3928_;
                            if _e601 {
                                let _e602 = checkPos_1;
                                param_481 = _e602;
                                let _e603 = getIndex_u0028_vi3_u003b((&param_481));
                                param_482 = _e603;
                                let _e604 = readCell_u0028_u1_u003b((&param_482));
                                param_483 = _e604;
                                let _e605 = getType_u0028_u1_u003b((&param_483));
                                if (_e605 == 0u) {
                                    let _e607 = emptyBelowCount;
                                    emptyBelowCount = (_e607 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e609 = z;
                            z = (_e609 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e611 = x;
                    x = (_e611 + 1i);
                }
            }
        }
        let _e613 = emptyBelowCount;
        let _e615 = tuning.emptyBelowWakeCount;
        if (_e613 >= bitcast<i32>(_e615)) {
            (*currentSleep_4) = 0u;
        } else {
            clumpCount = 0i;
            x_1 = -1i;
            loop {
                let _e618 = x_1;
                if (_e618 <= 1i) {
                    y = -1i;
                    loop {
                        let _e620 = y;
                        if (_e620 <= 1i) {
                            z_1 = -1i;
                            loop {
                                let _e622 = z_1;
                                if (_e622 <= 1i) {
                                    let _e624 = x_1;
                                    let _e626 = y;
                                    let _e629 = z_1;
                                    if (((_e624 == 0i) && (_e626 == 0i)) && (_e629 == 0i)) {
                                        continue;
                                    }
                                    let _e632 = (*pos_12);
                                    let _e633 = x_1;
                                    let _e634 = y;
                                    let _e635 = z_1;
                                    nPos_5 = (_e632 + vec3<i32>(_e633, _e634, _e635));
                                    let _e639 = nPos_5[0u];
                                    let _e640 = (_e639 >= 0i);
                                    phi_4009_ = _e640;
                                    if _e640 {
                                        let _e642 = nPos_5[0u];
                                        let _e644 = tuning.gridWidth;
                                        phi_4009_ = (_e642 < bitcast<i32>(_e644));
                                    }
                                    let _e648 = phi_4009_;
                                    phi_4015_ = _e648;
                                    if _e648 {
                                        let _e650 = nPos_5[1u];
                                        phi_4015_ = (_e650 >= 0i);
                                    }
                                    let _e653 = phi_4015_;
                                    phi_4024_ = _e653;
                                    if _e653 {
                                        let _e655 = nPos_5[1u];
                                        let _e657 = tuning.gridHeight;
                                        phi_4024_ = (_e655 < bitcast<i32>(_e657));
                                    }
                                    let _e661 = phi_4024_;
                                    phi_4030_ = _e661;
                                    if _e661 {
                                        let _e663 = nPos_5[2u];
                                        phi_4030_ = (_e663 >= 0i);
                                    }
                                    let _e666 = phi_4030_;
                                    phi_4039_ = _e666;
                                    if _e666 {
                                        let _e668 = nPos_5[2u];
                                        let _e670 = tuning.gridDepth;
                                        phi_4039_ = (_e668 < bitcast<i32>(_e670));
                                    }
                                    let _e674 = phi_4039_;
                                    if _e674 {
                                        let _e675 = nPos_5;
                                        param_484 = _e675;
                                        let _e676 = getIndex_u0028_vi3_u003b((&param_484));
                                        param_485 = _e676;
                                        let _e677 = readCell_u0028_u1_u003b((&param_485));
                                        param_486 = _e677;
                                        let _e678 = getType_u0028_u1_u003b((&param_486));
                                        if (_e678 == 4u) {
                                            let _e680 = clumpCount;
                                            clumpCount = (_e680 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e682 = z_1;
                                    z_1 = (_e682 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e684 = y;
                            y = (_e684 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e686 = x_1;
                    x_1 = (_e686 + 1i);
                }
            }
            let _e688 = clumpCount;
            let _e690 = tuning.dirtClumpThreshold;
            if (_e688 >= bitcast<i32>(_e690)) {
                isClumped = true;
            }
        }
    }
    let _e693 = canMove;
    let _e694 = isClumped;
    if (_e693 && !(_e694)) {
        let _e698 = (*pos_12)[1u];
        if (_e698 > 1i) {
            let _e700 = (*pos_12);
            belowPos_5 = (_e700 + vec3<i32>(0i, -1i, 0i));
            let _e702 = belowPos_5;
            param_487 = _e702;
            let _e703 = getIndex_u0028_vi3_u003b((&param_487));
            param_488 = _e703;
            let _e704 = readCell_u0028_u1_u003b((&param_488));
            param_489 = _e704;
            let _e705 = getType_u0028_u1_u003b((&param_489));
            if (_e705 == 0u) {
                let _e707 = belowPos_5;
                param_490 = _e707;
                let _e708 = getIndex_u0028_vi3_u003b((&param_490));
                param_491 = 4u;
                param_492 = 0u;
                param_493 = 0u;
                let _e709 = moisture_4;
                param_494 = _e709;
                let _e710 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_491), (&param_492), (&param_493), (&param_494));
                let _e711 = (*currentIndex_9);
                param_495 = _e711;
                let _e712 = (*rawValue_7);
                param_496 = _e712;
                param_497 = _e708;
                param_498 = _e710;
                let _e713 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_495), (&param_496), (&param_497), (&param_498));
                if _e713 {
                    return;
                }
            }
        }
        let _e715 = (*pos_12)[1u];
        if (_e715 > 1i) {
            let _e717 = (*randVal_9);
            dir_2 = select(-1i, 1i, (fract((_e717 * 10f)) > 0.5f));
            let _e722 = (*randVal_9);
            if (fract((_e722 * 100f)) > 0.5f) {
                let _e726 = (*pos_12);
                let _e727 = dir_2;
                slidePos1_ = (_e726 + vec3<i32>(_e727, -1i, 0i));
                let _e730 = (*pos_12);
                let _e731 = dir_2;
                slidePos2_ = (_e730 + vec3<i32>(0i, -1i, _e731));
            } else {
                let _e734 = (*pos_12);
                let _e735 = dir_2;
                slidePos1_ = (_e734 + vec3<i32>(0i, -1i, _e735));
                let _e738 = (*pos_12);
                let _e739 = dir_2;
                slidePos2_ = (_e738 + vec3<i32>(_e739, -1i, 0i));
            }
            let _e743 = slidePos1_[0u];
            let _e744 = (_e743 > 0i);
            phi_4158_ = _e744;
            if _e744 {
                let _e746 = slidePos1_[0u];
                let _e748 = tuning.gridWidth;
                phi_4158_ = (_e746 < (bitcast<i32>(_e748) - 1i));
            }
            let _e753 = phi_4158_;
            phi_4164_ = _e753;
            if _e753 {
                let _e755 = slidePos1_[2u];
                phi_4164_ = (_e755 > 0i);
            }
            let _e758 = phi_4164_;
            phi_4174_ = _e758;
            if _e758 {
                let _e760 = slidePos1_[2u];
                let _e762 = tuning.gridDepth;
                phi_4174_ = (_e760 < (bitcast<i32>(_e762) - 1i));
            }
            let _e767 = phi_4174_;
            if _e767 {
                let _e768 = slidePos1_;
                param_499 = _e768;
                let _e769 = getIndex_u0028_vi3_u003b((&param_499));
                param_500 = _e769;
                let _e770 = readCell_u0028_u1_u003b((&param_500));
                param_501 = _e770;
                let _e771 = getType_u0028_u1_u003b((&param_501));
                if (_e771 == 0u) {
                    let _e773 = slidePos1_;
                    param_502 = _e773;
                    let _e774 = getIndex_u0028_vi3_u003b((&param_502));
                    param_503 = 4u;
                    param_504 = 0u;
                    param_505 = 0u;
                    let _e775 = moisture_4;
                    param_506 = _e775;
                    let _e776 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_503), (&param_504), (&param_505), (&param_506));
                    let _e777 = (*currentIndex_9);
                    param_507 = _e777;
                    let _e778 = (*rawValue_7);
                    param_508 = _e778;
                    param_509 = _e774;
                    param_510 = _e776;
                    let _e779 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_507), (&param_508), (&param_509), (&param_510));
                    if _e779 {
                        return;
                    }
                }
            }
            let _e781 = slidePos2_[0u];
            let _e782 = (_e781 > 0i);
            phi_4218_ = _e782;
            if _e782 {
                let _e784 = slidePos2_[0u];
                let _e786 = tuning.gridWidth;
                phi_4218_ = (_e784 < (bitcast<i32>(_e786) - 1i));
            }
            let _e791 = phi_4218_;
            phi_4224_ = _e791;
            if _e791 {
                let _e793 = slidePos2_[2u];
                phi_4224_ = (_e793 > 0i);
            }
            let _e796 = phi_4224_;
            phi_4234_ = _e796;
            if _e796 {
                let _e798 = slidePos2_[2u];
                let _e800 = tuning.gridDepth;
                phi_4234_ = (_e798 < (bitcast<i32>(_e800) - 1i));
            }
            let _e805 = phi_4234_;
            if _e805 {
                let _e806 = slidePos2_;
                param_511 = _e806;
                let _e807 = getIndex_u0028_vi3_u003b((&param_511));
                param_512 = _e807;
                let _e808 = readCell_u0028_u1_u003b((&param_512));
                param_513 = _e808;
                let _e809 = getType_u0028_u1_u003b((&param_513));
                if (_e809 == 0u) {
                    let _e811 = slidePos2_;
                    param_514 = _e811;
                    let _e812 = getIndex_u0028_vi3_u003b((&param_514));
                    param_515 = 4u;
                    param_516 = 0u;
                    param_517 = 0u;
                    let _e813 = moisture_4;
                    param_518 = _e813;
                    let _e814 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_515), (&param_516), (&param_517), (&param_518));
                    let _e815 = (*currentIndex_9);
                    param_519 = _e815;
                    let _e816 = (*rawValue_7);
                    param_520 = _e816;
                    param_521 = _e812;
                    param_522 = _e814;
                    let _e817 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_519), (&param_520), (&param_521), (&param_522));
                    if _e817 {
                        return;
                    }
                }
            }
        }
        let _e819 = (*pos_12)[1u];
        if (_e819 > 1i) {
            let _e821 = (*pos_12);
            belowPos_6 = (_e821 + vec3<i32>(0i, -1i, 0i));
            let _e823 = belowPos_6;
            param_523 = _e823;
            let _e824 = getIndex_u0028_vi3_u003b((&param_523));
            belowIndex_2 = _e824;
            let _e825 = belowIndex_2;
            param_524 = _e825;
            let _e826 = readCell_u0028_u1_u003b((&param_524));
            belowValue_2 = _e826;
            let _e827 = belowValue_2;
            param_525 = _e827;
            let _e828 = getType_u0028_u1_u003b((&param_525));
            if (_e828 == 2u) {
                let _e830 = (*randVal_9);
                startDir_2 = i32((fract((_e830 * 8f)) * 8f));
                i_16 = 0i;
                loop {
                    let _e835 = i_16;
                    if (_e835 < 8i) {
                        let _e837 = startDir_2;
                        let _e838 = i_16;
                        let _e839 = (_e837 + _e838);
                        d_13 = (_e839 - (i32(floor((f32(_e839) / f32(8i)))) * 8i));
                        let _e847 = belowPos_6;
                        let _e848 = d_13;
                        param_526 = _e848;
                        let _e849 = getHDir_u0028_i1_u003b((&param_526));
                        pushPos = (_e847 + _e849);
                        let _e852 = pushPos[0u];
                        let _e853 = (_e852 > 0i);
                        phi_4325_ = _e853;
                        if _e853 {
                            let _e855 = pushPos[0u];
                            let _e857 = tuning.gridWidth;
                            phi_4325_ = (_e855 < (bitcast<i32>(_e857) - 1i));
                        }
                        let _e862 = phi_4325_;
                        phi_4331_ = _e862;
                        if _e862 {
                            let _e864 = pushPos[2u];
                            phi_4331_ = (_e864 > 0i);
                        }
                        let _e867 = phi_4331_;
                        phi_4341_ = _e867;
                        if _e867 {
                            let _e869 = pushPos[2u];
                            let _e871 = tuning.gridDepth;
                            phi_4341_ = (_e869 < (bitcast<i32>(_e871) - 1i));
                        }
                        let _e876 = phi_4341_;
                        if _e876 {
                            param_527 = 4u;
                            param_528 = 0u;
                            param_529 = 0u;
                            let _e877 = moisture_4;
                            param_530 = _e877;
                            let _e878 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_527), (&param_528), (&param_529), (&param_530));
                            let _e879 = pushPos;
                            param_531 = _e879;
                            let _e880 = getIndex_u0028_vi3_u003b((&param_531));
                            let _e881 = (*currentIndex_9);
                            param_532 = _e881;
                            param_533 = _e878;
                            let _e882 = belowIndex_2;
                            param_534 = _e882;
                            let _e883 = belowValue_2;
                            param_535 = _e883;
                            param_536 = _e880;
                            let _e884 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_532), (&param_533), (&param_534), (&param_535), (&param_536));
                            if _e884 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e885 = i_16;
                        i_16 = (_e885 + 1i);
                    }
                }
                param_537 = 4u;
                param_538 = 0u;
                param_539 = 0u;
                let _e887 = moisture_4;
                param_540 = _e887;
                let _e888 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_537), (&param_538), (&param_539), (&param_540));
                let _e889 = (*currentIndex_9);
                param_541 = _e889;
                let _e890 = (*rawValue_7);
                param_542 = _e890;
                let _e891 = belowIndex_2;
                param_543 = _e891;
                param_544 = _e888;
                let _e892 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_541), (&param_542), (&param_543), (&param_544));
                if _e892 {
                    return;
                }
            }
            let _e893 = (*randVal_9);
            dir_3 = select(-1i, 1i, (fract((_e893 * 10f)) > 0.5f));
            let _e898 = (*randVal_9);
            if (fract((_e898 * 100f)) > 0.5f) {
                let _e902 = (*pos_12);
                let _e903 = dir_3;
                slidePos[0i] = (_e902 + vec3<i32>(_e903, -1i, 0i));
                let _e907 = (*pos_12);
                let _e908 = dir_3;
                slidePos[1i] = (_e907 + vec3<i32>(0i, -1i, _e908));
            } else {
                let _e912 = (*pos_12);
                let _e913 = dir_3;
                slidePos[0i] = (_e912 + vec3<i32>(0i, -1i, _e913));
                let _e917 = (*pos_12);
                let _e918 = dir_3;
                slidePos[1i] = (_e917 + vec3<i32>(_e918, -1i, 0i));
            }
            s_1 = 0i;
            loop {
                let _e922 = s_1;
                if (_e922 < 2i) {
                    let _e924 = s_1;
                    let _e926 = slidePos[_e924];
                    sPos_2 = _e926;
                    let _e928 = sPos_2[0u];
                    let _e929 = (_e928 > 0i);
                    phi_4442_ = _e929;
                    if _e929 {
                        let _e931 = sPos_2[0u];
                        let _e933 = tuning.gridWidth;
                        phi_4442_ = (_e931 < (bitcast<i32>(_e933) - 1i));
                    }
                    let _e938 = phi_4442_;
                    phi_4448_ = _e938;
                    if _e938 {
                        let _e940 = sPos_2[2u];
                        phi_4448_ = (_e940 > 0i);
                    }
                    let _e943 = phi_4448_;
                    phi_4458_ = _e943;
                    if _e943 {
                        let _e945 = sPos_2[2u];
                        let _e947 = tuning.gridDepth;
                        phi_4458_ = (_e945 < (bitcast<i32>(_e947) - 1i));
                    }
                    let _e952 = phi_4458_;
                    if _e952 {
                        let _e953 = sPos_2;
                        param_545 = _e953;
                        let _e954 = getIndex_u0028_vi3_u003b((&param_545));
                        sIndex = _e954;
                        let _e955 = sIndex;
                        param_546 = _e955;
                        let _e956 = readCell_u0028_u1_u003b((&param_546));
                        sValue = _e956;
                        let _e957 = sValue;
                        param_547 = _e957;
                        let _e958 = getType_u0028_u1_u003b((&param_547));
                        if (_e958 == 2u) {
                            let _e960 = (*randVal_9);
                            let _e962 = s_1;
                            startDir_3 = i32((fract(((_e960 * 8f) + f32(_e962))) * 8f));
                            i_17 = 0i;
                            loop {
                                let _e968 = i_17;
                                if (_e968 < 8i) {
                                    let _e970 = startDir_3;
                                    let _e971 = i_17;
                                    let _e972 = (_e970 + _e971);
                                    d_14 = (_e972 - (i32(floor((f32(_e972) / f32(8i)))) * 8i));
                                    let _e980 = sPos_2;
                                    let _e981 = d_14;
                                    param_548 = _e981;
                                    let _e982 = getHDir_u0028_i1_u003b((&param_548));
                                    pushPos_1 = (_e980 + _e982);
                                    let _e985 = pushPos_1[0u];
                                    let _e986 = (_e985 > 0i);
                                    phi_4515_ = _e986;
                                    if _e986 {
                                        let _e988 = pushPos_1[0u];
                                        let _e990 = tuning.gridWidth;
                                        phi_4515_ = (_e988 < (bitcast<i32>(_e990) - 1i));
                                    }
                                    let _e995 = phi_4515_;
                                    phi_4521_ = _e995;
                                    if _e995 {
                                        let _e997 = pushPos_1[2u];
                                        phi_4521_ = (_e997 > 0i);
                                    }
                                    let _e1000 = phi_4521_;
                                    phi_4531_ = _e1000;
                                    if _e1000 {
                                        let _e1002 = pushPos_1[2u];
                                        let _e1004 = tuning.gridDepth;
                                        phi_4531_ = (_e1002 < (bitcast<i32>(_e1004) - 1i));
                                    }
                                    let _e1009 = phi_4531_;
                                    if _e1009 {
                                        param_549 = 4u;
                                        param_550 = 0u;
                                        param_551 = 0u;
                                        let _e1010 = moisture_4;
                                        param_552 = _e1010;
                                        let _e1011 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_549), (&param_550), (&param_551), (&param_552));
                                        let _e1012 = pushPos_1;
                                        param_553 = _e1012;
                                        let _e1013 = getIndex_u0028_vi3_u003b((&param_553));
                                        let _e1014 = (*currentIndex_9);
                                        param_554 = _e1014;
                                        param_555 = _e1011;
                                        let _e1015 = sIndex;
                                        param_556 = _e1015;
                                        let _e1016 = sValue;
                                        param_557 = _e1016;
                                        param_558 = _e1013;
                                        let _e1017 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_554), (&param_555), (&param_556), (&param_557), (&param_558));
                                        if _e1017 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1018 = i_17;
                                    i_17 = (_e1018 + 1i);
                                }
                            }
                            param_559 = 4u;
                            param_560 = 0u;
                            param_561 = 0u;
                            let _e1020 = moisture_4;
                            param_562 = _e1020;
                            let _e1021 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_559), (&param_560), (&param_561), (&param_562));
                            let _e1022 = (*currentIndex_9);
                            param_563 = _e1022;
                            let _e1023 = (*rawValue_7);
                            param_564 = _e1023;
                            let _e1024 = sIndex;
                            param_565 = _e1024;
                            param_566 = _e1021;
                            let _e1025 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_563), (&param_564), (&param_565), (&param_566));
                            if _e1025 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1026 = s_1;
                    s_1 = (_e1026 + 1i);
                }
            }
        }
    }
    let _e1028 = (*currentDir_4);
    floraState = _e1028;
    let _e1029 = isClumped;
    phi_4586_ = _e1029;
    if !(_e1029) {
        let _e1031 = (*currentSleep_4);
        let _e1033 = tuning.wakeSleepThreshold;
        phi_4586_ = (_e1031 > _e1033);
    }
    let _e1036 = phi_4586_;
    if _e1036 {
        let _e1037 = (*pos_12);
        abovePos_1 = (_e1037 + vec3<i32>(0i, 1i, 0i));
        let _e1040 = abovePos_1[1u];
        let _e1042 = tuning.gridHeight;
        aboveInside = (_e1040 < (bitcast<i32>(_e1042) - 1i));
        let _e1046 = abovePos_1;
        param_567 = _e1046;
        let _e1047 = getIndex_u0028_vi3_u003b((&param_567));
        aboveIndex = _e1047;
        let _e1048 = aboveInside;
        if _e1048 {
            let _e1049 = aboveIndex;
            param_568 = _e1049;
            let _e1050 = readCell_u0028_u1_u003b((&param_568));
            param_569 = _e1050;
            let _e1051 = getType_u0028_u1_u003b((&param_569));
            local_21 = _e1051;
        } else {
            local_21 = 0u;
        }
        let _e1052 = local_21;
        aboveType = _e1052;
        let _e1053 = aboveType;
        let _e1055 = aboveType;
        if ((_e1053 == 0u) || (_e1055 == 18u)) {
            let _e1058 = moisture_4;
            let _e1060 = floraState;
            if ((_e1058 >= 5u) && (_e1060 < 100u)) {
                let _e1063 = (*randVal_9);
                let _e1067 = tuning.grassGrowChance;
                if (fract((_e1063 * 55f)) < _e1067) {
                    let _e1069 = floraState;
                    floraState = (_e1069 + bitcast<u32>(1i));
                    let _e1072 = floraState;
                    let _e1074 = aboveType;
                    let _e1077 = aboveInside;
                    let _e1078 = (((_e1072 == 100u) && (_e1074 == 0u)) && _e1077);
                    phi_4660_ = _e1078;
                    if _e1078 {
                        let _e1079 = (*randVal_9);
                        let _e1083 = tuning.treeBloomChance;
                        phi_4660_ = (fract((_e1079 * 97f)) < _e1083);
                    }
                    let _e1086 = phi_4660_;
                    if _e1086 {
                        let _e1087 = aboveIndex;
                        param_570 = 18u;
                        param_571 = 0u;
                        param_572 = 0u;
                        param_573 = 0u;
                        let _e1090 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_570), (&param_571), (&param_572), (&param_573));
                        let _e1091 = atomicCompareExchangeWeak((&unnamed.grid[_e1087]), 0u, _e1090);
                    }
                }
            }
            let _e1093 = floraState;
            if (_e1093 > 100u) {
                floraState = 100u;
            }
        } else {
            let _e1095 = aboveType;
            if (_e1095 == 2u) {
                let _e1097 = floraState;
                if (_e1097 > 0u) {
                    let _e1099 = floraState;
                    if (_e1099 <= 100u) {
                        floraState = 101u;
                    }
                    let _e1101 = (*randVal_9);
                    let _e1105 = tuning.grassSubmergedDecayChance;
                    if (fract((_e1101 * 66f)) < _e1105) {
                        let _e1107 = floraState;
                        floraState = (_e1107 + bitcast<u32>(1i));
                    }
                    let _e1110 = floraState;
                    if (_e1110 >= 200u) {
                        floraState = 0u;
                    }
                }
            } else {
                let _e1112 = aboveType;
                let _e1113 = (_e1112 != 5u);
                phi_4715_ = _e1113;
                if _e1113 {
                    let _e1114 = aboveType;
                    param_574 = _e1114;
                    let _e1115 = isLocust_u0028_u1_u003b((&param_574));
                    phi_4715_ = !(_e1115);
                }
                let _e1118 = phi_4715_;
                if _e1118 {
                    floraState = 0u;
                }
            }
        }
    }
    let _e1119 = (*currentSleep_4);
    newSleep_2 = min((_e1119 + 1u), 255u);
    let _e1122 = (*currentIndex_9);
    let _e1125 = (*rawValue_7);
    param_575 = 4u;
    let _e1126 = floraState;
    param_576 = _e1126;
    let _e1127 = newSleep_2;
    param_577 = _e1127;
    let _e1128 = moisture_4;
    param_578 = _e1128;
    let _e1129 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_575), (&param_576), (&param_577), (&param_578));
    let _e1130 = atomicCompareExchangeWeak((&unnamed.grid[_e1122]), _e1125, _e1129);
    return;
}

fn updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_13: ptr<function, vec3<i32>>, currentIndex_10: ptr<function, u32>, rawValue_8: ptr<function, u32>, currentDir_5: ptr<function, u32>, currentSleep_5: ptr<function, u32>, currentAge_8: ptr<function, u32>, randVal_10: ptr<function, f32>) {
    var wake: bool;
    var param_579: vec3<i32>;
    var param_580: u32;
    var param_581: u32;
    var hasPressure_1: bool;
    var local_22: bool;
    var param_582: vec3<i32>;
    var param_583: u32;
    var param_584: u32;
    var isStackedOnWater: bool;
    var local_23: bool;
    var param_585: vec3<i32>;
    var param_586: u32;
    var param_587: u32;
    var d_15: i32;
    var nPos_6: vec3<i32>;
    var param_588: i32;
    var param_589: vec3<i32>;
    var param_590: u32;
    var param_591: u32;
    var belowNeighbor: u32;
    var param_592: vec3<i32>;
    var param_593: u32;
    var param_594: u32;
    var newAge_2: u32;
    var belowPos_7: vec3<i32>;
    var param_595: vec3<i32>;
    var param_596: u32;
    var param_597: u32;
    var param_598: vec3<i32>;
    var param_599: u32;
    var param_600: u32;
    var param_601: u32;
    var param_602: u32;
    var param_603: u32;
    var param_604: u32;
    var param_605: u32;
    var param_606: u32;
    var newDir: u32;
    var r_1: f32;
    var diagDir: u32;
    var r_2: f32;
    var stepPos: vec3<i32>;
    var param_607: i32;
    var param_608: vec3<i32>;
    var param_609: u32;
    var param_610: u32;
    var newValue_1: u32;
    var param_611: u32;
    var param_612: u32;
    var param_613: u32;
    var param_614: u32;
    var param_615: vec3<i32>;
    var param_616: u32;
    var param_617: u32;
    var param_618: u32;
    var param_619: u32;
    var bestDropPos: vec3<i32>;
    var foundDrop: bool;
    var blockedMask_1: u32;
    var startDir_4: i32;
    var waterReach: i32;
    var r_3: i32;
    var i_18: i32;
    var d_16: i32;
    var c_7: vec3<i32>;
    var param_620: i32;
    var param_621: vec3<i32>;
    var param_622: u32;
    var param_623: u32;
    var param_624: vec3<i32>;
    var param_625: u32;
    var param_626: u32;
    var newValue_2: u32;
    var param_627: u32;
    var param_628: u32;
    var param_629: u32;
    var param_630: u32;
    var param_631: vec3<i32>;
    var param_632: u32;
    var param_633: u32;
    var param_634: u32;
    var param_635: u32;
    var hasPressure_2: bool;
    var local_24: bool;
    var param_636: vec3<i32>;
    var param_637: u32;
    var param_638: u32;
    var isStackedOnWater_1: bool;
    var local_25: bool;
    var param_639: vec3<i32>;
    var param_640: u32;
    var param_641: u32;
    var canStepOntoPool: bool;
    var d_17: i32;
    var nPos_7: vec3<i32>;
    var param_642: i32;
    var param_643: vec3<i32>;
    var param_644: u32;
    var param_645: u32;
    var param_646: vec3<i32>;
    var param_647: u32;
    var param_648: u32;
    var startSpreadDir: i32;
    var i_19: i32;
    var d_18: i32;
    var targetPos_2: vec3<i32>;
    var param_649: i32;
    var param_650: vec3<i32>;
    var param_651: u32;
    var param_652: u32;
    var newValue_3: u32;
    var param_653: u32;
    var param_654: u32;
    var param_655: u32;
    var param_656: u32;
    var param_657: vec3<i32>;
    var param_658: u32;
    var param_659: u32;
    var param_660: u32;
    var param_661: u32;
    var newSleep_3: u32;
    var sleepValue: u32;
    var param_662: u32;
    var param_663: u32;
    var param_664: u32;
    var param_665: u32;
    var phi_4755_: bool;
    var phi_4825_: bool;
    var phi_4831_: bool;
    var phi_4841_: bool;
    var phi_5026_: bool;
    var phi_5032_: bool;
    var phi_5042_: bool;
    var phi_5157_: bool;
    var phi_5164_: bool;
    var phi_5175_: bool;
    var phi_5187_: bool;
    var phi_5209_: bool;
    var phi_5313_: bool;
    var phi_5319_: bool;
    var phi_5329_: bool;
    var phi_5345_: bool;
    var phi_5357_: bool;
    var phi_5407_: bool;
    var phi_5413_: bool;
    var phi_5423_: bool;

    let _e339 = (*currentSleep_5);
    let _e341 = tuning.wakeSleepThreshold;
    if (_e339 > _e341) {
        wake = false;
        let _e344 = (*pos_13)[1u];
        let _e345 = (_e344 > 1i);
        phi_4755_ = _e345;
        if _e345 {
            let _e346 = (*pos_13);
            param_579 = (_e346 + vec3<i32>(0i, -1i, 0i));
            let _e348 = getIndex_u0028_vi3_u003b((&param_579));
            param_580 = _e348;
            let _e349 = readCell_u0028_u1_u003b((&param_580));
            param_581 = _e349;
            let _e350 = getType_u0028_u1_u003b((&param_581));
            phi_4755_ = (_e350 == 0u);
        }
        let _e353 = phi_4755_;
        if _e353 {
            wake = true;
        } else {
            let _e355 = (*pos_13)[1u];
            let _e357 = tuning.gridHeight;
            if (_e355 < (bitcast<i32>(_e357) - 2i)) {
                let _e361 = (*pos_13);
                param_582 = (_e361 + vec3<i32>(0i, 1i, 0i));
                let _e363 = getIndex_u0028_vi3_u003b((&param_582));
                param_583 = _e363;
                let _e364 = readCell_u0028_u1_u003b((&param_583));
                param_584 = _e364;
                let _e365 = getType_u0028_u1_u003b((&param_584));
                local_22 = (_e365 != 0u);
            } else {
                local_22 = false;
            }
            let _e367 = local_22;
            hasPressure_1 = _e367;
            let _e369 = (*pos_13)[1u];
            if (_e369 > 1i) {
                let _e371 = (*pos_13);
                param_585 = (_e371 + vec3<i32>(0i, -1i, 0i));
                let _e373 = getIndex_u0028_vi3_u003b((&param_585));
                param_586 = _e373;
                let _e374 = readCell_u0028_u1_u003b((&param_586));
                param_587 = _e374;
                let _e375 = getType_u0028_u1_u003b((&param_587));
                local_23 = (_e375 == 2u);
            } else {
                local_23 = false;
            }
            let _e377 = local_23;
            isStackedOnWater = _e377;
            d_15 = 0i;
            loop {
                let _e378 = d_15;
                if (_e378 < 8i) {
                    let _e380 = (*pos_13);
                    let _e381 = d_15;
                    param_588 = _e381;
                    let _e382 = getHDir_u0028_i1_u003b((&param_588));
                    nPos_6 = (_e380 + _e382);
                    let _e385 = nPos_6[0u];
                    let _e386 = (_e385 > 0i);
                    phi_4825_ = _e386;
                    if _e386 {
                        let _e388 = nPos_6[0u];
                        let _e390 = tuning.gridWidth;
                        phi_4825_ = (_e388 < (bitcast<i32>(_e390) - 1i));
                    }
                    let _e395 = phi_4825_;
                    phi_4831_ = _e395;
                    if _e395 {
                        let _e397 = nPos_6[2u];
                        phi_4831_ = (_e397 > 0i);
                    }
                    let _e400 = phi_4831_;
                    phi_4841_ = _e400;
                    if _e400 {
                        let _e402 = nPos_6[2u];
                        let _e404 = tuning.gridDepth;
                        phi_4841_ = (_e402 < (bitcast<i32>(_e404) - 1i));
                    }
                    let _e409 = phi_4841_;
                    if _e409 {
                        let _e410 = nPos_6;
                        param_589 = _e410;
                        let _e411 = getIndex_u0028_vi3_u003b((&param_589));
                        param_590 = _e411;
                        let _e412 = readCell_u0028_u1_u003b((&param_590));
                        param_591 = _e412;
                        let _e413 = getType_u0028_u1_u003b((&param_591));
                        if (_e413 == 0u) {
                            let _e415 = nPos_6;
                            param_592 = (_e415 + vec3<i32>(0i, -1i, 0i));
                            let _e417 = getIndex_u0028_vi3_u003b((&param_592));
                            param_593 = _e417;
                            let _e418 = readCell_u0028_u1_u003b((&param_593));
                            param_594 = _e418;
                            let _e419 = getType_u0028_u1_u003b((&param_594));
                            belowNeighbor = _e419;
                            let _e420 = belowNeighbor;
                            let _e422 = hasPressure_1;
                            let _e424 = isStackedOnWater;
                            let _e426 = belowNeighbor;
                            if ((((_e420 == 0u) || _e422) || _e424) || (_e426 == 2u)) {
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
                    let _e429 = d_15;
                    d_15 = (_e429 + 1i);
                }
            }
        }
        let _e431 = wake;
        if !(_e431) {
            return;
        }
        (*currentSleep_5) = 0u;
        (*currentAge_8) = 0u;
    }
    let _e433 = (*currentAge_8);
    newAge_2 = (_e433 + 1u);
    let _e436 = (*pos_13)[1u];
    if (_e436 > 1i) {
        let _e438 = (*pos_13);
        belowPos_7 = (_e438 + vec3<i32>(0i, -1i, 0i));
        let _e440 = belowPos_7;
        param_595 = _e440;
        let _e441 = getIndex_u0028_vi3_u003b((&param_595));
        param_596 = _e441;
        let _e442 = readCell_u0028_u1_u003b((&param_596));
        param_597 = _e442;
        let _e443 = getType_u0028_u1_u003b((&param_597));
        if (_e443 == 0u) {
            let _e445 = belowPos_7;
            param_598 = _e445;
            let _e446 = getIndex_u0028_vi3_u003b((&param_598));
            param_599 = 2u;
            param_600 = 0u;
            param_601 = 0u;
            let _e447 = newAge_2;
            param_602 = _e447;
            let _e448 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_599), (&param_600), (&param_601), (&param_602));
            let _e449 = (*currentIndex_10);
            param_603 = _e449;
            let _e450 = (*rawValue_8);
            param_604 = _e450;
            param_605 = _e446;
            param_606 = _e448;
            let _e451 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_603), (&param_604), (&param_605), (&param_606));
            if _e451 {
                return;
            }
        }
    }
    let _e452 = (*currentDir_5);
    newDir = _e452;
    let _e453 = newDir;
    let _e455 = newDir;
    if ((_e453 == 0u) || (_e455 == 9u)) {
        let _e458 = (*randVal_10);
        r_1 = fract((_e458 * 77f));
        let _e461 = r_1;
        if (_e461 < 0.25f) {
            newDir = 1u;
        } else {
            let _e463 = r_1;
            if (_e463 < 0.5f) {
                newDir = 2u;
            } else {
                let _e465 = r_1;
                if (_e465 < 0.75f) {
                    newDir = 3u;
                } else {
                    newDir = 4u;
                }
            }
        }
    }
    let _e467 = newAge_2;
    let _e470 = newAge_2;
    if (((_e467 % 3u) == 0u) && (_e470 > 0u)) {
        let _e473 = newDir;
        diagDir = _e473;
        let _e474 = diagDir;
        let _e476 = diagDir;
        if ((_e474 >= 1u) && (_e476 <= 4u)) {
            let _e479 = (*randVal_10);
            r_2 = fract((_e479 * 133f));
            let _e482 = diagDir;
            if (_e482 == 1u) {
                let _e484 = r_2;
                diagDir = select(6u, 5u, (_e484 > 0.5f));
            } else {
                let _e487 = diagDir;
                if (_e487 == 2u) {
                    let _e489 = r_2;
                    diagDir = select(8u, 7u, (_e489 > 0.5f));
                } else {
                    let _e492 = diagDir;
                    if (_e492 == 3u) {
                        let _e494 = r_2;
                        diagDir = select(7u, 5u, (_e494 > 0.5f));
                    } else {
                        let _e497 = diagDir;
                        if (_e497 == 4u) {
                            let _e499 = r_2;
                            diagDir = select(8u, 6u, (_e499 > 0.5f));
                        }
                    }
                }
            }
        }
        let _e502 = (*pos_13);
        let _e503 = diagDir;
        param_607 = (bitcast<i32>(_e503) - 1i);
        let _e506 = getHDir_u0028_i1_u003b((&param_607));
        stepPos = (_e502 + _e506);
        let _e509 = stepPos[0u];
        let _e510 = (_e509 > 0i);
        phi_5026_ = _e510;
        if _e510 {
            let _e512 = stepPos[0u];
            let _e514 = tuning.gridWidth;
            phi_5026_ = (_e512 < (bitcast<i32>(_e514) - 1i));
        }
        let _e519 = phi_5026_;
        phi_5032_ = _e519;
        if _e519 {
            let _e521 = stepPos[2u];
            phi_5032_ = (_e521 > 0i);
        }
        let _e524 = phi_5032_;
        phi_5042_ = _e524;
        if _e524 {
            let _e526 = stepPos[2u];
            let _e528 = tuning.gridDepth;
            phi_5042_ = (_e526 < (bitcast<i32>(_e528) - 1i));
        }
        let _e533 = phi_5042_;
        if _e533 {
            let _e534 = stepPos;
            param_608 = _e534;
            let _e535 = getIndex_u0028_vi3_u003b((&param_608));
            param_609 = _e535;
            let _e536 = readCell_u0028_u1_u003b((&param_609));
            param_610 = _e536;
            let _e537 = getType_u0028_u1_u003b((&param_610));
            if (_e537 == 0u) {
                param_611 = 2u;
                let _e539 = newDir;
                param_612 = _e539;
                param_613 = 0u;
                let _e540 = newAge_2;
                param_614 = _e540;
                let _e541 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_611), (&param_612), (&param_613), (&param_614));
                newValue_1 = _e541;
                let _e542 = stepPos;
                param_615 = _e542;
                let _e543 = getIndex_u0028_vi3_u003b((&param_615));
                let _e544 = (*currentIndex_10);
                param_616 = _e544;
                let _e545 = (*rawValue_8);
                param_617 = _e545;
                param_618 = _e543;
                let _e546 = newValue_1;
                param_619 = _e546;
                let _e547 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_616), (&param_617), (&param_618), (&param_619));
                if _e547 {
                    return;
                }
            }
        }
    }
    let _e548 = (*pos_13);
    bestDropPos = _e548;
    foundDrop = false;
    blockedMask_1 = 0u;
    let _e549 = (*randVal_10);
    startDir_4 = i32((fract((_e549 * 8f)) * 8f));
    let _e555 = tuning.waterSpreadRadius;
    let _e557 = tuning.gridWidth;
    let _e560 = tuning.gridHeight;
    waterReach = bitcast<i32>(clamp(_e555, 1u, bitcast<u32>(max(bitcast<i32>(_e557), bitcast<i32>(_e560)))));
    r_3 = 1i;
    loop {
        let _e566 = r_3;
        let _e567 = waterReach;
        if (_e566 <= _e567) {
            let _e569 = blockedMask_1;
            if (_e569 == 255u) {
                break;
            }
            i_18 = 0i;
            loop {
                let _e571 = i_18;
                if (_e571 < 8i) {
                    let _e573 = startDir_4;
                    let _e574 = i_18;
                    let _e575 = (_e573 + _e574);
                    d_16 = (_e575 - (i32(floor((f32(_e575) / f32(8i)))) * 8i));
                    let _e583 = blockedMask_1;
                    let _e584 = d_16;
                    if ((_e583 & (1u << bitcast<u32>(_e584))) == 0u) {
                        let _e589 = (*pos_13);
                        let _e590 = d_16;
                        param_620 = _e590;
                        let _e591 = getHDir_u0028_i1_u003b((&param_620));
                        let _e592 = r_3;
                        c_7 = (_e589 + (_e591 * vec3(_e592)));
                        let _e597 = c_7[0u];
                        let _e598 = (_e597 <= 0i);
                        phi_5157_ = _e598;
                        if !(_e598) {
                            let _e601 = c_7[0u];
                            let _e603 = tuning.gridWidth;
                            phi_5157_ = (_e601 >= (bitcast<i32>(_e603) - 1i));
                        }
                        let _e608 = phi_5157_;
                        phi_5164_ = _e608;
                        if !(_e608) {
                            let _e611 = c_7[2u];
                            phi_5164_ = (_e611 <= 0i);
                        }
                        let _e614 = phi_5164_;
                        phi_5175_ = _e614;
                        if !(_e614) {
                            let _e617 = c_7[2u];
                            let _e619 = tuning.gridDepth;
                            phi_5175_ = (_e617 >= (bitcast<i32>(_e619) - 1i));
                        }
                        let _e624 = phi_5175_;
                        phi_5187_ = _e624;
                        if !(_e624) {
                            let _e626 = c_7;
                            param_621 = _e626;
                            let _e627 = getIndex_u0028_vi3_u003b((&param_621));
                            param_622 = _e627;
                            let _e628 = readCell_u0028_u1_u003b((&param_622));
                            param_623 = _e628;
                            let _e629 = getType_u0028_u1_u003b((&param_623));
                            phi_5187_ = (_e629 != 0u);
                        }
                        let _e632 = phi_5187_;
                        if _e632 {
                            let _e633 = d_16;
                            let _e636 = blockedMask_1;
                            blockedMask_1 = (_e636 | (1u << bitcast<u32>(_e633)));
                        } else {
                            let _e639 = c_7[1u];
                            let _e640 = (_e639 > 1i);
                            phi_5209_ = _e640;
                            if _e640 {
                                let _e641 = c_7;
                                param_624 = (_e641 + vec3<i32>(0i, -1i, 0i));
                                let _e643 = getIndex_u0028_vi3_u003b((&param_624));
                                param_625 = _e643;
                                let _e644 = readCell_u0028_u1_u003b((&param_625));
                                param_626 = _e644;
                                let _e645 = getType_u0028_u1_u003b((&param_626));
                                phi_5209_ = (_e645 == 0u);
                            }
                            let _e648 = phi_5209_;
                            if _e648 {
                                let _e649 = c_7;
                                bestDropPos = _e649;
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
                    let _e650 = i_18;
                    i_18 = (_e650 + 1i);
                }
            }
            let _e652 = foundDrop;
            if _e652 {
                break;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e653 = r_3;
            r_3 = (_e653 + 1i);
        }
    }
    let _e655 = foundDrop;
    if _e655 {
        param_627 = 2u;
        param_628 = 0u;
        param_629 = 0u;
        param_630 = 0u;
        let _e656 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_627), (&param_628), (&param_629), (&param_630));
        newValue_2 = _e656;
        let _e657 = bestDropPos;
        param_631 = _e657;
        let _e658 = getIndex_u0028_vi3_u003b((&param_631));
        let _e659 = (*currentIndex_10);
        param_632 = _e659;
        let _e660 = (*rawValue_8);
        param_633 = _e660;
        param_634 = _e658;
        let _e661 = newValue_2;
        param_635 = _e661;
        let _e662 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_632), (&param_633), (&param_634), (&param_635));
        if _e662 {
            return;
        }
    } else {
        let _e664 = (*pos_13)[1u];
        let _e666 = tuning.gridHeight;
        if (_e664 < (bitcast<i32>(_e666) - 2i)) {
            let _e670 = (*pos_13);
            param_636 = (_e670 + vec3<i32>(0i, 1i, 0i));
            let _e672 = getIndex_u0028_vi3_u003b((&param_636));
            param_637 = _e672;
            let _e673 = readCell_u0028_u1_u003b((&param_637));
            param_638 = _e673;
            let _e674 = getType_u0028_u1_u003b((&param_638));
            local_24 = (_e674 != 0u);
        } else {
            local_24 = false;
        }
        let _e676 = local_24;
        hasPressure_2 = _e676;
        let _e678 = (*pos_13)[1u];
        if (_e678 > 1i) {
            let _e680 = (*pos_13);
            param_639 = (_e680 + vec3<i32>(0i, -1i, 0i));
            let _e682 = getIndex_u0028_vi3_u003b((&param_639));
            param_640 = _e682;
            let _e683 = readCell_u0028_u1_u003b((&param_640));
            param_641 = _e683;
            let _e684 = getType_u0028_u1_u003b((&param_641));
            local_25 = (_e684 == 2u);
        } else {
            local_25 = false;
        }
        let _e686 = local_25;
        isStackedOnWater_1 = _e686;
        canStepOntoPool = false;
        d_17 = 0i;
        loop {
            let _e687 = d_17;
            if (_e687 < 8i) {
                let _e689 = (*pos_13);
                let _e690 = d_17;
                param_642 = _e690;
                let _e691 = getHDir_u0028_i1_u003b((&param_642));
                nPos_7 = (_e689 + _e691);
                let _e694 = nPos_7[0u];
                let _e695 = (_e694 > 0i);
                phi_5313_ = _e695;
                if _e695 {
                    let _e697 = nPos_7[0u];
                    let _e699 = tuning.gridWidth;
                    phi_5313_ = (_e697 < (bitcast<i32>(_e699) - 1i));
                }
                let _e704 = phi_5313_;
                phi_5319_ = _e704;
                if _e704 {
                    let _e706 = nPos_7[2u];
                    phi_5319_ = (_e706 > 0i);
                }
                let _e709 = phi_5319_;
                phi_5329_ = _e709;
                if _e709 {
                    let _e711 = nPos_7[2u];
                    let _e713 = tuning.gridDepth;
                    phi_5329_ = (_e711 < (bitcast<i32>(_e713) - 1i));
                }
                let _e718 = phi_5329_;
                if _e718 {
                    let _e719 = nPos_7;
                    param_643 = _e719;
                    let _e720 = getIndex_u0028_vi3_u003b((&param_643));
                    param_644 = _e720;
                    let _e721 = readCell_u0028_u1_u003b((&param_644));
                    param_645 = _e721;
                    let _e722 = getType_u0028_u1_u003b((&param_645));
                    let _e723 = (_e722 == 0u);
                    phi_5345_ = _e723;
                    if _e723 {
                        let _e725 = (*pos_13)[1u];
                        phi_5345_ = (_e725 > 1i);
                    }
                    let _e728 = phi_5345_;
                    phi_5357_ = _e728;
                    if _e728 {
                        let _e729 = nPos_7;
                        param_646 = (_e729 + vec3<i32>(0i, -1i, 0i));
                        let _e731 = getIndex_u0028_vi3_u003b((&param_646));
                        param_647 = _e731;
                        let _e732 = readCell_u0028_u1_u003b((&param_647));
                        param_648 = _e732;
                        let _e733 = getType_u0028_u1_u003b((&param_648));
                        phi_5357_ = (_e733 == 2u);
                    }
                    let _e736 = phi_5357_;
                    if _e736 {
                        canStepOntoPool = true;
                        break;
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e737 = d_17;
                d_17 = (_e737 + 1i);
            }
        }
        let _e739 = hasPressure_2;
        let _e740 = isStackedOnWater_1;
        let _e742 = canStepOntoPool;
        if ((_e739 || _e740) || _e742) {
            let _e744 = (*randVal_10);
            startSpreadDir = i32((fract((_e744 * 8f)) * 8f));
            i_19 = 0i;
            loop {
                let _e749 = i_19;
                if (_e749 < 8i) {
                    let _e751 = startSpreadDir;
                    let _e752 = i_19;
                    let _e753 = (_e751 + _e752);
                    d_18 = (_e753 - (i32(floor((f32(_e753) / f32(8i)))) * 8i));
                    let _e761 = (*pos_13);
                    let _e762 = d_18;
                    param_649 = _e762;
                    let _e763 = getHDir_u0028_i1_u003b((&param_649));
                    targetPos_2 = (_e761 + _e763);
                    let _e766 = targetPos_2[0u];
                    let _e767 = (_e766 > 0i);
                    phi_5407_ = _e767;
                    if _e767 {
                        let _e769 = targetPos_2[0u];
                        let _e771 = tuning.gridWidth;
                        phi_5407_ = (_e769 < (bitcast<i32>(_e771) - 1i));
                    }
                    let _e776 = phi_5407_;
                    phi_5413_ = _e776;
                    if _e776 {
                        let _e778 = targetPos_2[2u];
                        phi_5413_ = (_e778 > 0i);
                    }
                    let _e781 = phi_5413_;
                    phi_5423_ = _e781;
                    if _e781 {
                        let _e783 = targetPos_2[2u];
                        let _e785 = tuning.gridDepth;
                        phi_5423_ = (_e783 < (bitcast<i32>(_e785) - 1i));
                    }
                    let _e790 = phi_5423_;
                    if _e790 {
                        let _e791 = targetPos_2;
                        param_650 = _e791;
                        let _e792 = getIndex_u0028_vi3_u003b((&param_650));
                        param_651 = _e792;
                        let _e793 = readCell_u0028_u1_u003b((&param_651));
                        param_652 = _e793;
                        let _e794 = getType_u0028_u1_u003b((&param_652));
                        if (_e794 == 0u) {
                            let _e796 = d_18;
                            param_653 = 2u;
                            param_654 = bitcast<u32>((_e796 + 1i));
                            param_655 = 0u;
                            let _e799 = newAge_2;
                            param_656 = _e799;
                            let _e800 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_653), (&param_654), (&param_655), (&param_656));
                            newValue_3 = _e800;
                            let _e801 = targetPos_2;
                            param_657 = _e801;
                            let _e802 = getIndex_u0028_vi3_u003b((&param_657));
                            let _e803 = (*currentIndex_10);
                            param_658 = _e803;
                            let _e804 = (*rawValue_8);
                            param_659 = _e804;
                            param_660 = _e802;
                            let _e805 = newValue_3;
                            param_661 = _e805;
                            let _e806 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_658), (&param_659), (&param_660), (&param_661));
                            if _e806 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e807 = i_19;
                    i_19 = (_e807 + 1i);
                }
            }
        }
    }
    let _e809 = (*currentSleep_5);
    newSleep_3 = min((_e809 + 1u), 255u);
    param_662 = 2u;
    param_663 = 0u;
    let _e812 = newSleep_3;
    param_664 = _e812;
    let _e813 = newAge_2;
    param_665 = _e813;
    let _e814 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_662), (&param_663), (&param_664), (&param_665));
    sleepValue = _e814;
    let _e815 = (*currentIndex_10);
    let _e818 = (*rawValue_8);
    let _e819 = sleepValue;
    let _e820 = atomicCompareExchangeWeak((&unnamed.grid[_e815]), _e818, _e819);
    return;
}

fn incWater_u0028_() {
    let _e206 = atomicAdd((&unnamed_1.waterVoxelCount), 1u);
    return;
}

fn updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b(pos_14: ptr<function, vec3<i32>>, currentIndex_11: ptr<function, u32>, rawValue_9: ptr<function, u32>, currentSleep_6: ptr<function, u32>, currentAge_9: ptr<function, u32>, randVal_11: ptr<function, f32>) {
    var moisture_5: u32;
    var moistureModified_1: bool;
    var startDir_5: i32;
    var i_20: i32;
    var d_19: i32;
    var nPos_8: vec3<i32>;
    var param_666: i32;
    var nIndex_5: u32;
    var param_667: vec3<i32>;
    var nVal_5: u32;
    var param_668: u32;
    var param_669: u32;
    var d_20: i32;
    var nPos_9: vec3<i32>;
    var param_670: i32;
    var nIndex_6: u32;
    var param_671: vec3<i32>;
    var nVal_6: u32;
    var param_672: u32;
    var nType_3: u32;
    var param_673: u32;
    var nMoisture_1: u32;
    var param_674: u32;
    var nCapacity_1: u32;
    var local_26: u32;
    var leakPos: vec3<i32>;
    var param_675: vec3<i32>;
    var param_676: u32;
    var param_677: u32;
    var param_678: vec3<i32>;
    var param_679: u32;
    var param_680: u32;
    var param_681: u32;
    var param_682: u32;
    var canMove_1: bool;
    var param_683: vec3<i32>;
    var isClumped_1: bool;
    var emptyBelowCount_1: i32;
    var x_2: i32;
    var z_2: i32;
    var checkPos_2: vec3<i32>;
    var param_684: vec3<i32>;
    var param_685: u32;
    var param_686: u32;
    var clumpCount_1: i32;
    var x_3: i32;
    var y_1: i32;
    var z_3: i32;
    var nPos_10: vec3<i32>;
    var param_687: vec3<i32>;
    var param_688: u32;
    var param_689: u32;
    var belowPos_8: vec3<i32>;
    var param_690: vec3<i32>;
    var param_691: u32;
    var param_692: u32;
    var param_693: vec3<i32>;
    var param_694: u32;
    var param_695: u32;
    var param_696: u32;
    var param_697: u32;
    var param_698: u32;
    var param_699: u32;
    var param_700: u32;
    var param_701: u32;
    var dir_4: i32;
    var slidePos1_1: vec3<i32>;
    var slidePos2_1: vec3<i32>;
    var param_702: vec3<i32>;
    var param_703: u32;
    var param_704: u32;
    var param_705: vec3<i32>;
    var param_706: u32;
    var param_707: u32;
    var param_708: u32;
    var param_709: u32;
    var param_710: u32;
    var param_711: u32;
    var param_712: u32;
    var param_713: u32;
    var param_714: vec3<i32>;
    var param_715: u32;
    var param_716: u32;
    var param_717: vec3<i32>;
    var param_718: u32;
    var param_719: u32;
    var param_720: u32;
    var param_721: u32;
    var param_722: u32;
    var param_723: u32;
    var param_724: u32;
    var param_725: u32;
    var belowPos_9: vec3<i32>;
    var belowIndex_3: u32;
    var param_726: vec3<i32>;
    var belowValue_3: u32;
    var param_727: u32;
    var param_728: u32;
    var startDir_6: i32;
    var i_21: i32;
    var d_21: i32;
    var pushPos_2: vec3<i32>;
    var param_729: i32;
    var param_730: u32;
    var param_731: u32;
    var param_732: u32;
    var param_733: u32;
    var param_734: vec3<i32>;
    var param_735: u32;
    var param_736: u32;
    var param_737: u32;
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
    var dir_5: i32;
    var slidePos_1: array<vec3<i32>, 2>;
    var s_2: i32;
    var sPos_3: vec3<i32>;
    var sIndex_1: u32;
    var param_748: vec3<i32>;
    var sValue_1: u32;
    var param_749: u32;
    var param_750: u32;
    var startDir_7: i32;
    var i_22: i32;
    var d_22: i32;
    var pushPos_3: vec3<i32>;
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
    var newSleep_4: u32;
    var param_770: u32;
    var param_771: u32;
    var param_772: u32;
    var param_773: u32;
    var phi_2635_: bool;
    var phi_2641_: bool;
    var phi_2651_: bool;
    var phi_2657_: bool;
    var phi_2667_: bool;
    var phi_2739_: bool;
    var phi_2745_: bool;
    var phi_2755_: bool;
    var phi_2761_: bool;
    var phi_2771_: bool;
    var phi_2836_: bool;
    var phi_2855_: bool;
    var phi_2899_: bool;
    var phi_2941_: bool;
    var phi_2947_: bool;
    var phi_2956_: bool;
    var phi_3038_: bool;
    var phi_3044_: bool;
    var phi_3053_: bool;
    var phi_3059_: bool;
    var phi_3068_: bool;
    var phi_3189_: bool;
    var phi_3195_: bool;
    var phi_3205_: bool;
    var phi_3249_: bool;
    var phi_3255_: bool;
    var phi_3265_: bool;
    var phi_3357_: bool;
    var phi_3363_: bool;
    var phi_3373_: bool;
    var phi_3476_: bool;
    var phi_3482_: bool;
    var phi_3492_: bool;
    var phi_3549_: bool;
    var phi_3555_: bool;
    var phi_3565_: bool;

    let _e369 = (*currentAge_9);
    moisture_5 = _e369;
    moistureModified_1 = false;
    let _e370 = moisture_5;
    let _e372 = tuning.sandMoistureCapacity;
    if (_e370 < _e372) {
        let _e374 = (*randVal_11);
        startDir_5 = i32((fract((_e374 * 17f)) * 6f));
        i_20 = 0i;
        loop {
            let _e379 = i_20;
            if (_e379 < 6i) {
                let _e381 = startDir_5;
                let _e382 = i_20;
                let _e383 = (_e381 + _e382);
                d_19 = (_e383 - (i32(floor((f32(_e383) / f32(6i)))) * 6i));
                let _e391 = d_19;
                if (_e391 != 2i) {
                    let _e393 = (*pos_14);
                    let _e394 = d_19;
                    param_666 = _e394;
                    let _e395 = getOrthoDir_u0028_i1_u003b((&param_666));
                    nPos_8 = (_e393 + _e395);
                    let _e398 = nPos_8[0u];
                    let _e399 = (_e398 > 0i);
                    phi_2635_ = _e399;
                    if _e399 {
                        let _e401 = nPos_8[0u];
                        let _e403 = tuning.gridWidth;
                        phi_2635_ = (_e401 < (bitcast<i32>(_e403) - 1i));
                    }
                    let _e408 = phi_2635_;
                    phi_2641_ = _e408;
                    if _e408 {
                        let _e410 = nPos_8[1u];
                        phi_2641_ = (_e410 > 0i);
                    }
                    let _e413 = phi_2641_;
                    phi_2651_ = _e413;
                    if _e413 {
                        let _e415 = nPos_8[1u];
                        let _e417 = tuning.gridHeight;
                        phi_2651_ = (_e415 < (bitcast<i32>(_e417) - 1i));
                    }
                    let _e422 = phi_2651_;
                    phi_2657_ = _e422;
                    if _e422 {
                        let _e424 = nPos_8[2u];
                        phi_2657_ = (_e424 > 0i);
                    }
                    let _e427 = phi_2657_;
                    phi_2667_ = _e427;
                    if _e427 {
                        let _e429 = nPos_8[2u];
                        let _e431 = tuning.gridDepth;
                        phi_2667_ = (_e429 < (bitcast<i32>(_e431) - 1i));
                    }
                    let _e436 = phi_2667_;
                    if _e436 {
                        let _e437 = nPos_8;
                        param_667 = _e437;
                        let _e438 = getIndex_u0028_vi3_u003b((&param_667));
                        nIndex_5 = _e438;
                        let _e439 = nIndex_5;
                        param_668 = _e439;
                        let _e440 = readCell_u0028_u1_u003b((&param_668));
                        nVal_5 = _e440;
                        let _e441 = nVal_5;
                        param_669 = _e441;
                        let _e442 = getType_u0028_u1_u003b((&param_669));
                        if (_e442 == 2u) {
                            let _e444 = nIndex_5;
                            let _e447 = nVal_5;
                            let _e448 = atomicCompareExchangeWeak((&unnamed.grid[_e444]), _e447, 0u);
                            let _e450 = nVal_5;
                            if (_e448.old_value == _e450) {
                                let _e452 = (*currentIndex_11);
                                let _e456 = tuning.sandWaterAbsorbUnit;
                                let _e459 = atomicAdd((&unnamed.grid[_e452]), (_e456 << bitcast<u32>(24i)));
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
                let _e460 = i_20;
                i_20 = (_e460 + 1i);
            }
        }
    }
    let _e462 = moistureModified_1;
    let _e464 = moisture_5;
    if (!(_e462) && (_e464 > 0u)) {
        let _e467 = (*randVal_11);
        d_20 = i32((fract((_e467 * 31f)) * 6f));
        let _e472 = d_20;
        if (_e472 != 2i) {
            let _e474 = (*pos_14);
            let _e475 = d_20;
            param_670 = _e475;
            let _e476 = getOrthoDir_u0028_i1_u003b((&param_670));
            nPos_9 = (_e474 + _e476);
            let _e479 = nPos_9[0u];
            let _e480 = (_e479 > 0i);
            phi_2739_ = _e480;
            if _e480 {
                let _e482 = nPos_9[0u];
                let _e484 = tuning.gridWidth;
                phi_2739_ = (_e482 < (bitcast<i32>(_e484) - 1i));
            }
            let _e489 = phi_2739_;
            phi_2745_ = _e489;
            if _e489 {
                let _e491 = nPos_9[1u];
                phi_2745_ = (_e491 > 0i);
            }
            let _e494 = phi_2745_;
            phi_2755_ = _e494;
            if _e494 {
                let _e496 = nPos_9[1u];
                let _e498 = tuning.gridHeight;
                phi_2755_ = (_e496 < (bitcast<i32>(_e498) - 1i));
            }
            let _e503 = phi_2755_;
            phi_2761_ = _e503;
            if _e503 {
                let _e505 = nPos_9[2u];
                phi_2761_ = (_e505 > 0i);
            }
            let _e508 = phi_2761_;
            phi_2771_ = _e508;
            if _e508 {
                let _e510 = nPos_9[2u];
                let _e512 = tuning.gridDepth;
                phi_2771_ = (_e510 < (bitcast<i32>(_e512) - 1i));
            }
            let _e517 = phi_2771_;
            if _e517 {
                let _e518 = nPos_9;
                param_671 = _e518;
                let _e519 = getIndex_u0028_vi3_u003b((&param_671));
                nIndex_6 = _e519;
                let _e520 = nIndex_6;
                param_672 = _e520;
                let _e521 = readCell_u0028_u1_u003b((&param_672));
                nVal_6 = _e521;
                let _e522 = nVal_6;
                param_673 = _e522;
                let _e523 = getType_u0028_u1_u003b((&param_673));
                nType_3 = _e523;
                let _e524 = nType_3;
                let _e526 = nType_3;
                if ((_e524 == 1u) || (_e526 == 4u)) {
                    let _e529 = nVal_6;
                    param_674 = _e529;
                    let _e530 = getAge_u0028_u1_u003b((&param_674));
                    nMoisture_1 = _e530;
                    let _e531 = nType_3;
                    if (_e531 == 4u) {
                        let _e534 = tuning.dirtMoistureCapacity;
                        local_26 = _e534;
                    } else {
                        let _e536 = tuning.sandMoistureCapacity;
                        local_26 = _e536;
                    }
                    let _e537 = local_26;
                    nCapacity_1 = _e537;
                    let _e538 = moisture_5;
                    let _e539 = nMoisture_1;
                    let _e542 = nMoisture_1;
                    let _e543 = nCapacity_1;
                    if ((_e538 > (_e539 + 1u)) && (_e542 < _e543)) {
                        let _e546 = (*currentIndex_11);
                        let _e549 = atomicAdd((&unnamed.grid[_e546]), 4278190080u);
                        let _e550 = nIndex_6;
                        let _e553 = atomicAdd((&unnamed.grid[_e550]), 16777216u);
                        moistureModified_1 = true;
                    }
                }
            }
        }
    }
    let _e554 = moistureModified_1;
    let _e555 = !(_e554);
    phi_2836_ = _e555;
    if _e555 {
        let _e556 = moisture_5;
        let _e558 = tuning.sandWaterAbsorbUnit;
        phi_2836_ = (_e556 >= _e558);
    }
    let _e561 = phi_2836_;
    if _e561 {
        let _e562 = (*pos_14);
        leakPos = (_e562 + vec3<i32>(0i, -1i, 0i));
        let _e565 = leakPos[1u];
        let _e566 = (_e565 > 0i);
        phi_2855_ = _e566;
        if _e566 {
            let _e567 = leakPos;
            param_675 = _e567;
            let _e568 = getIndex_u0028_vi3_u003b((&param_675));
            param_676 = _e568;
            let _e569 = readCell_u0028_u1_u003b((&param_676));
            param_677 = _e569;
            let _e570 = getType_u0028_u1_u003b((&param_677));
            phi_2855_ = (_e570 == 0u);
        }
        let _e573 = phi_2855_;
        if _e573 {
            let _e574 = leakPos;
            param_678 = _e574;
            let _e575 = getIndex_u0028_vi3_u003b((&param_678));
            param_679 = 2u;
            param_680 = 0u;
            param_681 = 0u;
            param_682 = 0u;
            let _e578 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_679), (&param_680), (&param_681), (&param_682));
            let _e579 = atomicCompareExchangeWeak((&unnamed.grid[_e575]), 0u, _e578);
            if (_e579.old_value == 0u) {
                let _e582 = (*currentIndex_11);
                let _e586 = tuning.sandWaterAbsorbUnit;
                let _e590 = atomicAdd((&unnamed.grid[_e582]), ((0u - _e586) << bitcast<u32>(24i)));
                incWater_u0028_();
                moistureModified_1 = true;
            }
        }
    }
    let _e591 = moistureModified_1;
    if _e591 {
        return;
    }
    let _e592 = (*pos_14);
    param_683 = _e592;
    let _e593 = grainCanMove_u0028_vi3_u003b((&param_683));
    canMove_1 = _e593;
    isClumped_1 = false;
    let _e594 = canMove_1;
    let _e595 = moisture_5;
    let _e597 = (_e594 && (_e595 > 0u));
    phi_2899_ = _e597;
    if _e597 {
        let _e598 = (*currentSleep_6);
        let _e600 = tuning.wakeSleepThreshold;
        phi_2899_ = (_e598 > _e600);
    }
    let _e603 = phi_2899_;
    if _e603 {
        emptyBelowCount_1 = 0i;
        let _e605 = (*pos_14)[1u];
        if (_e605 > 1i) {
            x_2 = -1i;
            loop {
                let _e607 = x_2;
                if (_e607 <= 1i) {
                    z_2 = -1i;
                    loop {
                        let _e609 = z_2;
                        if (_e609 <= 1i) {
                            let _e611 = (*pos_14);
                            let _e612 = x_2;
                            let _e613 = z_2;
                            checkPos_2 = (_e611 + vec3<i32>(_e612, -1i, _e613));
                            let _e617 = checkPos_2[0u];
                            let _e618 = (_e617 >= 0i);
                            phi_2941_ = _e618;
                            if _e618 {
                                let _e620 = checkPos_2[0u];
                                let _e622 = tuning.gridWidth;
                                phi_2941_ = (_e620 < bitcast<i32>(_e622));
                            }
                            let _e626 = phi_2941_;
                            phi_2947_ = _e626;
                            if _e626 {
                                let _e628 = checkPos_2[2u];
                                phi_2947_ = (_e628 >= 0i);
                            }
                            let _e631 = phi_2947_;
                            phi_2956_ = _e631;
                            if _e631 {
                                let _e633 = checkPos_2[2u];
                                let _e635 = tuning.gridDepth;
                                phi_2956_ = (_e633 < bitcast<i32>(_e635));
                            }
                            let _e639 = phi_2956_;
                            if _e639 {
                                let _e640 = checkPos_2;
                                param_684 = _e640;
                                let _e641 = getIndex_u0028_vi3_u003b((&param_684));
                                param_685 = _e641;
                                let _e642 = readCell_u0028_u1_u003b((&param_685));
                                param_686 = _e642;
                                let _e643 = getType_u0028_u1_u003b((&param_686));
                                if (_e643 == 0u) {
                                    let _e645 = emptyBelowCount_1;
                                    emptyBelowCount_1 = (_e645 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e647 = z_2;
                            z_2 = (_e647 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e649 = x_2;
                    x_2 = (_e649 + 1i);
                }
            }
        }
        let _e651 = emptyBelowCount_1;
        let _e653 = tuning.emptyBelowWakeCount;
        if (_e651 >= bitcast<i32>(_e653)) {
            (*currentSleep_6) = 0u;
        } else {
            clumpCount_1 = 0i;
            x_3 = -1i;
            loop {
                let _e656 = x_3;
                if (_e656 <= 1i) {
                    y_1 = -1i;
                    loop {
                        let _e658 = y_1;
                        if (_e658 <= 1i) {
                            z_3 = -1i;
                            loop {
                                let _e660 = z_3;
                                if (_e660 <= 1i) {
                                    let _e662 = x_3;
                                    let _e664 = y_1;
                                    let _e667 = z_3;
                                    if (((_e662 == 0i) && (_e664 == 0i)) && (_e667 == 0i)) {
                                        continue;
                                    }
                                    let _e670 = (*pos_14);
                                    let _e671 = x_3;
                                    let _e672 = y_1;
                                    let _e673 = z_3;
                                    nPos_10 = (_e670 + vec3<i32>(_e671, _e672, _e673));
                                    let _e677 = nPos_10[0u];
                                    let _e678 = (_e677 >= 0i);
                                    phi_3038_ = _e678;
                                    if _e678 {
                                        let _e680 = nPos_10[0u];
                                        let _e682 = tuning.gridWidth;
                                        phi_3038_ = (_e680 < bitcast<i32>(_e682));
                                    }
                                    let _e686 = phi_3038_;
                                    phi_3044_ = _e686;
                                    if _e686 {
                                        let _e688 = nPos_10[1u];
                                        phi_3044_ = (_e688 >= 0i);
                                    }
                                    let _e691 = phi_3044_;
                                    phi_3053_ = _e691;
                                    if _e691 {
                                        let _e693 = nPos_10[1u];
                                        let _e695 = tuning.gridHeight;
                                        phi_3053_ = (_e693 < bitcast<i32>(_e695));
                                    }
                                    let _e699 = phi_3053_;
                                    phi_3059_ = _e699;
                                    if _e699 {
                                        let _e701 = nPos_10[2u];
                                        phi_3059_ = (_e701 >= 0i);
                                    }
                                    let _e704 = phi_3059_;
                                    phi_3068_ = _e704;
                                    if _e704 {
                                        let _e706 = nPos_10[2u];
                                        let _e708 = tuning.gridDepth;
                                        phi_3068_ = (_e706 < bitcast<i32>(_e708));
                                    }
                                    let _e712 = phi_3068_;
                                    if _e712 {
                                        let _e713 = nPos_10;
                                        param_687 = _e713;
                                        let _e714 = getIndex_u0028_vi3_u003b((&param_687));
                                        param_688 = _e714;
                                        let _e715 = readCell_u0028_u1_u003b((&param_688));
                                        param_689 = _e715;
                                        let _e716 = getType_u0028_u1_u003b((&param_689));
                                        if (_e716 == 1u) {
                                            let _e718 = clumpCount_1;
                                            clumpCount_1 = (_e718 + 1i);
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e720 = z_3;
                                    z_3 = (_e720 + 1i);
                                }
                            }
                            continue;
                        } else {
                            break;
                        }
                        continuing {
                            let _e722 = y_1;
                            y_1 = (_e722 + 1i);
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e724 = x_3;
                    x_3 = (_e724 + 1i);
                }
            }
            let _e726 = clumpCount_1;
            let _e728 = tuning.sandClumpThreshold;
            if (_e726 >= bitcast<i32>(_e728)) {
                isClumped_1 = true;
            }
        }
    }
    let _e731 = canMove_1;
    let _e732 = isClumped_1;
    if (_e731 && !(_e732)) {
        let _e736 = (*pos_14)[1u];
        if (_e736 > 1i) {
            let _e738 = (*pos_14);
            belowPos_8 = (_e738 + vec3<i32>(0i, -1i, 0i));
            let _e740 = belowPos_8;
            param_690 = _e740;
            let _e741 = getIndex_u0028_vi3_u003b((&param_690));
            param_691 = _e741;
            let _e742 = readCell_u0028_u1_u003b((&param_691));
            param_692 = _e742;
            let _e743 = getType_u0028_u1_u003b((&param_692));
            if (_e743 == 0u) {
                let _e745 = belowPos_8;
                param_693 = _e745;
                let _e746 = getIndex_u0028_vi3_u003b((&param_693));
                param_694 = 1u;
                param_695 = 0u;
                param_696 = 0u;
                let _e747 = moisture_5;
                param_697 = _e747;
                let _e748 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_694), (&param_695), (&param_696), (&param_697));
                let _e749 = (*currentIndex_11);
                param_698 = _e749;
                let _e750 = (*rawValue_9);
                param_699 = _e750;
                param_700 = _e746;
                param_701 = _e748;
                let _e751 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_698), (&param_699), (&param_700), (&param_701));
                if _e751 {
                    return;
                }
            }
        }
        let _e753 = (*pos_14)[1u];
        if (_e753 > 1i) {
            let _e755 = (*randVal_11);
            dir_4 = select(-1i, 1i, (fract((_e755 * 10f)) > 0.5f));
            let _e760 = (*randVal_11);
            if (fract((_e760 * 100f)) > 0.5f) {
                let _e764 = (*pos_14);
                let _e765 = dir_4;
                slidePos1_1 = (_e764 + vec3<i32>(_e765, -1i, 0i));
                let _e768 = (*pos_14);
                let _e769 = dir_4;
                slidePos2_1 = (_e768 + vec3<i32>(0i, -1i, _e769));
            } else {
                let _e772 = (*pos_14);
                let _e773 = dir_4;
                slidePos1_1 = (_e772 + vec3<i32>(0i, -1i, _e773));
                let _e776 = (*pos_14);
                let _e777 = dir_4;
                slidePos2_1 = (_e776 + vec3<i32>(_e777, -1i, 0i));
            }
            let _e781 = slidePos1_1[0u];
            let _e782 = (_e781 > 0i);
            phi_3189_ = _e782;
            if _e782 {
                let _e784 = slidePos1_1[0u];
                let _e786 = tuning.gridWidth;
                phi_3189_ = (_e784 < (bitcast<i32>(_e786) - 1i));
            }
            let _e791 = phi_3189_;
            phi_3195_ = _e791;
            if _e791 {
                let _e793 = slidePos1_1[2u];
                phi_3195_ = (_e793 > 0i);
            }
            let _e796 = phi_3195_;
            phi_3205_ = _e796;
            if _e796 {
                let _e798 = slidePos1_1[2u];
                let _e800 = tuning.gridDepth;
                phi_3205_ = (_e798 < (bitcast<i32>(_e800) - 1i));
            }
            let _e805 = phi_3205_;
            if _e805 {
                let _e806 = slidePos1_1;
                param_702 = _e806;
                let _e807 = getIndex_u0028_vi3_u003b((&param_702));
                param_703 = _e807;
                let _e808 = readCell_u0028_u1_u003b((&param_703));
                param_704 = _e808;
                let _e809 = getType_u0028_u1_u003b((&param_704));
                if (_e809 == 0u) {
                    let _e811 = slidePos1_1;
                    param_705 = _e811;
                    let _e812 = getIndex_u0028_vi3_u003b((&param_705));
                    param_706 = 1u;
                    param_707 = 0u;
                    param_708 = 0u;
                    let _e813 = moisture_5;
                    param_709 = _e813;
                    let _e814 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_706), (&param_707), (&param_708), (&param_709));
                    let _e815 = (*currentIndex_11);
                    param_710 = _e815;
                    let _e816 = (*rawValue_9);
                    param_711 = _e816;
                    param_712 = _e812;
                    param_713 = _e814;
                    let _e817 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_710), (&param_711), (&param_712), (&param_713));
                    if _e817 {
                        return;
                    }
                }
            }
            let _e819 = slidePos2_1[0u];
            let _e820 = (_e819 > 0i);
            phi_3249_ = _e820;
            if _e820 {
                let _e822 = slidePos2_1[0u];
                let _e824 = tuning.gridWidth;
                phi_3249_ = (_e822 < (bitcast<i32>(_e824) - 1i));
            }
            let _e829 = phi_3249_;
            phi_3255_ = _e829;
            if _e829 {
                let _e831 = slidePos2_1[2u];
                phi_3255_ = (_e831 > 0i);
            }
            let _e834 = phi_3255_;
            phi_3265_ = _e834;
            if _e834 {
                let _e836 = slidePos2_1[2u];
                let _e838 = tuning.gridDepth;
                phi_3265_ = (_e836 < (bitcast<i32>(_e838) - 1i));
            }
            let _e843 = phi_3265_;
            if _e843 {
                let _e844 = slidePos2_1;
                param_714 = _e844;
                let _e845 = getIndex_u0028_vi3_u003b((&param_714));
                param_715 = _e845;
                let _e846 = readCell_u0028_u1_u003b((&param_715));
                param_716 = _e846;
                let _e847 = getType_u0028_u1_u003b((&param_716));
                if (_e847 == 0u) {
                    let _e849 = slidePos2_1;
                    param_717 = _e849;
                    let _e850 = getIndex_u0028_vi3_u003b((&param_717));
                    param_718 = 1u;
                    param_719 = 0u;
                    param_720 = 0u;
                    let _e851 = moisture_5;
                    param_721 = _e851;
                    let _e852 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_718), (&param_719), (&param_720), (&param_721));
                    let _e853 = (*currentIndex_11);
                    param_722 = _e853;
                    let _e854 = (*rawValue_9);
                    param_723 = _e854;
                    param_724 = _e850;
                    param_725 = _e852;
                    let _e855 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_722), (&param_723), (&param_724), (&param_725));
                    if _e855 {
                        return;
                    }
                }
            }
        }
        let _e857 = (*pos_14)[1u];
        if (_e857 > 1i) {
            let _e859 = (*pos_14);
            belowPos_9 = (_e859 + vec3<i32>(0i, -1i, 0i));
            let _e861 = belowPos_9;
            param_726 = _e861;
            let _e862 = getIndex_u0028_vi3_u003b((&param_726));
            belowIndex_3 = _e862;
            let _e863 = belowIndex_3;
            param_727 = _e863;
            let _e864 = readCell_u0028_u1_u003b((&param_727));
            belowValue_3 = _e864;
            let _e865 = belowValue_3;
            param_728 = _e865;
            let _e866 = getType_u0028_u1_u003b((&param_728));
            if (_e866 == 2u) {
                let _e868 = (*randVal_11);
                startDir_6 = i32((fract((_e868 * 8f)) * 8f));
                i_21 = 0i;
                loop {
                    let _e873 = i_21;
                    if (_e873 < 8i) {
                        let _e875 = startDir_6;
                        let _e876 = i_21;
                        let _e877 = (_e875 + _e876);
                        d_21 = (_e877 - (i32(floor((f32(_e877) / f32(8i)))) * 8i));
                        let _e885 = belowPos_9;
                        let _e886 = d_21;
                        param_729 = _e886;
                        let _e887 = getHDir_u0028_i1_u003b((&param_729));
                        pushPos_2 = (_e885 + _e887);
                        let _e890 = pushPos_2[0u];
                        let _e891 = (_e890 > 0i);
                        phi_3357_ = _e891;
                        if _e891 {
                            let _e893 = pushPos_2[0u];
                            let _e895 = tuning.gridWidth;
                            phi_3357_ = (_e893 < (bitcast<i32>(_e895) - 1i));
                        }
                        let _e900 = phi_3357_;
                        phi_3363_ = _e900;
                        if _e900 {
                            let _e902 = pushPos_2[2u];
                            phi_3363_ = (_e902 > 0i);
                        }
                        let _e905 = phi_3363_;
                        phi_3373_ = _e905;
                        if _e905 {
                            let _e907 = pushPos_2[2u];
                            let _e909 = tuning.gridDepth;
                            phi_3373_ = (_e907 < (bitcast<i32>(_e909) - 1i));
                        }
                        let _e914 = phi_3373_;
                        if _e914 {
                            param_730 = 1u;
                            param_731 = 0u;
                            param_732 = 0u;
                            let _e915 = moisture_5;
                            param_733 = _e915;
                            let _e916 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_730), (&param_731), (&param_732), (&param_733));
                            let _e917 = pushPos_2;
                            param_734 = _e917;
                            let _e918 = getIndex_u0028_vi3_u003b((&param_734));
                            let _e919 = (*currentIndex_11);
                            param_735 = _e919;
                            param_736 = _e916;
                            let _e920 = belowIndex_3;
                            param_737 = _e920;
                            let _e921 = belowValue_3;
                            param_738 = _e921;
                            param_739 = _e918;
                            let _e922 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_735), (&param_736), (&param_737), (&param_738), (&param_739));
                            if _e922 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e923 = i_21;
                        i_21 = (_e923 + 1i);
                    }
                }
                param_740 = 1u;
                param_741 = 0u;
                param_742 = 0u;
                let _e925 = moisture_5;
                param_743 = _e925;
                let _e926 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_740), (&param_741), (&param_742), (&param_743));
                let _e927 = (*currentIndex_11);
                param_744 = _e927;
                let _e928 = (*rawValue_9);
                param_745 = _e928;
                let _e929 = belowIndex_3;
                param_746 = _e929;
                param_747 = _e926;
                let _e930 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_744), (&param_745), (&param_746), (&param_747));
                if _e930 {
                    return;
                }
            }
            let _e931 = (*randVal_11);
            dir_5 = select(-1i, 1i, (fract((_e931 * 10f)) > 0.5f));
            let _e936 = (*randVal_11);
            if (fract((_e936 * 100f)) > 0.5f) {
                let _e940 = (*pos_14);
                let _e941 = dir_5;
                slidePos_1[0i] = (_e940 + vec3<i32>(_e941, -1i, 0i));
                let _e945 = (*pos_14);
                let _e946 = dir_5;
                slidePos_1[1i] = (_e945 + vec3<i32>(0i, -1i, _e946));
            } else {
                let _e950 = (*pos_14);
                let _e951 = dir_5;
                slidePos_1[0i] = (_e950 + vec3<i32>(0i, -1i, _e951));
                let _e955 = (*pos_14);
                let _e956 = dir_5;
                slidePos_1[1i] = (_e955 + vec3<i32>(_e956, -1i, 0i));
            }
            s_2 = 0i;
            loop {
                let _e960 = s_2;
                if (_e960 < 2i) {
                    let _e962 = s_2;
                    let _e964 = slidePos_1[_e962];
                    sPos_3 = _e964;
                    let _e966 = sPos_3[0u];
                    let _e967 = (_e966 > 0i);
                    phi_3476_ = _e967;
                    if _e967 {
                        let _e969 = sPos_3[0u];
                        let _e971 = tuning.gridWidth;
                        phi_3476_ = (_e969 < (bitcast<i32>(_e971) - 1i));
                    }
                    let _e976 = phi_3476_;
                    phi_3482_ = _e976;
                    if _e976 {
                        let _e978 = sPos_3[2u];
                        phi_3482_ = (_e978 > 0i);
                    }
                    let _e981 = phi_3482_;
                    phi_3492_ = _e981;
                    if _e981 {
                        let _e983 = sPos_3[2u];
                        let _e985 = tuning.gridDepth;
                        phi_3492_ = (_e983 < (bitcast<i32>(_e985) - 1i));
                    }
                    let _e990 = phi_3492_;
                    if _e990 {
                        let _e991 = sPos_3;
                        param_748 = _e991;
                        let _e992 = getIndex_u0028_vi3_u003b((&param_748));
                        sIndex_1 = _e992;
                        let _e993 = sIndex_1;
                        param_749 = _e993;
                        let _e994 = readCell_u0028_u1_u003b((&param_749));
                        sValue_1 = _e994;
                        let _e995 = sValue_1;
                        param_750 = _e995;
                        let _e996 = getType_u0028_u1_u003b((&param_750));
                        if (_e996 == 2u) {
                            let _e998 = (*randVal_11);
                            let _e1000 = s_2;
                            startDir_7 = i32((fract(((_e998 * 8f) + f32(_e1000))) * 8f));
                            i_22 = 0i;
                            loop {
                                let _e1006 = i_22;
                                if (_e1006 < 8i) {
                                    let _e1008 = startDir_7;
                                    let _e1009 = i_22;
                                    let _e1010 = (_e1008 + _e1009);
                                    d_22 = (_e1010 - (i32(floor((f32(_e1010) / f32(8i)))) * 8i));
                                    let _e1018 = sPos_3;
                                    let _e1019 = d_22;
                                    param_751 = _e1019;
                                    let _e1020 = getHDir_u0028_i1_u003b((&param_751));
                                    pushPos_3 = (_e1018 + _e1020);
                                    let _e1023 = pushPos_3[0u];
                                    let _e1024 = (_e1023 > 0i);
                                    phi_3549_ = _e1024;
                                    if _e1024 {
                                        let _e1026 = pushPos_3[0u];
                                        let _e1028 = tuning.gridWidth;
                                        phi_3549_ = (_e1026 < (bitcast<i32>(_e1028) - 1i));
                                    }
                                    let _e1033 = phi_3549_;
                                    phi_3555_ = _e1033;
                                    if _e1033 {
                                        let _e1035 = pushPos_3[2u];
                                        phi_3555_ = (_e1035 > 0i);
                                    }
                                    let _e1038 = phi_3555_;
                                    phi_3565_ = _e1038;
                                    if _e1038 {
                                        let _e1040 = pushPos_3[2u];
                                        let _e1042 = tuning.gridDepth;
                                        phi_3565_ = (_e1040 < (bitcast<i32>(_e1042) - 1i));
                                    }
                                    let _e1047 = phi_3565_;
                                    if _e1047 {
                                        param_752 = 1u;
                                        param_753 = 0u;
                                        param_754 = 0u;
                                        let _e1048 = moisture_5;
                                        param_755 = _e1048;
                                        let _e1049 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_752), (&param_753), (&param_754), (&param_755));
                                        let _e1050 = pushPos_3;
                                        param_756 = _e1050;
                                        let _e1051 = getIndex_u0028_vi3_u003b((&param_756));
                                        let _e1052 = (*currentIndex_11);
                                        param_757 = _e1052;
                                        param_758 = _e1049;
                                        let _e1053 = sIndex_1;
                                        param_759 = _e1053;
                                        let _e1054 = sValue_1;
                                        param_760 = _e1054;
                                        param_761 = _e1051;
                                        let _e1055 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_757), (&param_758), (&param_759), (&param_760), (&param_761));
                                        if _e1055 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1056 = i_22;
                                    i_22 = (_e1056 + 1i);
                                }
                            }
                            param_762 = 1u;
                            param_763 = 0u;
                            param_764 = 0u;
                            let _e1058 = moisture_5;
                            param_765 = _e1058;
                            let _e1059 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_762), (&param_763), (&param_764), (&param_765));
                            let _e1060 = (*currentIndex_11);
                            param_766 = _e1060;
                            let _e1061 = (*rawValue_9);
                            param_767 = _e1061;
                            let _e1062 = sIndex_1;
                            param_768 = _e1062;
                            param_769 = _e1059;
                            let _e1063 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_766), (&param_767), (&param_768), (&param_769));
                            if _e1063 {
                                return;
                            }
                        }
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e1064 = s_2;
                    s_2 = (_e1064 + 1i);
                }
            }
        }
    }
    let _e1066 = (*currentSleep_6);
    newSleep_4 = min((_e1066 + 1u), 255u);
    let _e1069 = (*currentIndex_11);
    let _e1072 = (*rawValue_9);
    param_770 = 1u;
    param_771 = 0u;
    let _e1073 = newSleep_4;
    param_772 = _e1073;
    let _e1074 = moisture_5;
    param_773 = _e1074;
    let _e1075 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_770), (&param_771), (&param_772), (&param_773));
    let _e1076 = atomicCompareExchangeWeak((&unnamed.grid[_e1069]), _e1072, _e1075);
    return;
}

fn orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b(pos_15: ptr<function, vec3<i32>>, currentIndex_12: ptr<function, u32>, rawValue_10: ptr<function, u32>, stepDir: ptr<function, vec3<i32>>) -> bool {
    var target_2: vec3<i32>;
    var targetIndex_3: u32;
    var param_774: vec3<i32>;
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
    var param_785: u32;
    var param_786: u32;
    var param_787: u32;
    var phi_1939_: bool;
    var phi_1946_: bool;
    var phi_1957_: bool;
    var phi_1964_: bool;
    var phi_1975_: bool;

    let _e225 = (*stepDir);
    if all((_e225 == vec3<i32>(0i, 0i, 0i))) {
        return false;
    }
    let _e228 = (*pos_15);
    let _e229 = (*stepDir);
    target_2 = (_e228 + _e229);
    let _e232 = target_2[0u];
    let _e233 = (_e232 < 1i);
    phi_1939_ = _e233;
    if !(_e233) {
        let _e236 = target_2[0u];
        let _e238 = tuning.gridWidth;
        phi_1939_ = (_e236 >= (bitcast<i32>(_e238) - 1i));
    }
    let _e243 = phi_1939_;
    phi_1946_ = _e243;
    if !(_e243) {
        let _e246 = target_2[1u];
        phi_1946_ = (_e246 < 1i);
    }
    let _e249 = phi_1946_;
    phi_1957_ = _e249;
    if !(_e249) {
        let _e252 = target_2[1u];
        let _e254 = tuning.gridHeight;
        phi_1957_ = (_e252 >= (bitcast<i32>(_e254) - 1i));
    }
    let _e259 = phi_1957_;
    phi_1964_ = _e259;
    if !(_e259) {
        let _e262 = target_2[2u];
        phi_1964_ = (_e262 < 1i);
    }
    let _e265 = phi_1964_;
    phi_1975_ = _e265;
    if !(_e265) {
        let _e268 = target_2[2u];
        let _e270 = tuning.gridDepth;
        phi_1975_ = (_e268 >= (bitcast<i32>(_e270) - 1i));
    }
    let _e275 = phi_1975_;
    if _e275 {
        return false;
    }
    let _e276 = target_2;
    param_774 = _e276;
    let _e277 = getIndex_u0028_vi3_u003b((&param_774));
    targetIndex_3 = _e277;
    let _e278 = targetIndex_3;
    param_775 = _e278;
    let _e279 = readCell_u0028_u1_u003b((&param_775));
    param_776 = _e279;
    let _e280 = getType_u0028_u1_u003b((&param_776));
    if (_e280 != 0u) {
        return false;
    }
    let _e282 = (*rawValue_10);
    param_777 = _e282;
    let _e283 = getType_u0028_u1_u003b((&param_777));
    let _e284 = (*rawValue_10);
    param_778 = _e284;
    let _e285 = getDir_u0028_u1_u003b((&param_778));
    let _e286 = (*rawValue_10);
    param_779 = _e286;
    let _e287 = getAge_u0028_u1_u003b((&param_779));
    param_780 = _e283;
    param_781 = _e285;
    param_782 = 0u;
    param_783 = _e287;
    let _e288 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_780), (&param_781), (&param_782), (&param_783));
    let _e289 = (*currentIndex_12);
    param_784 = _e289;
    let _e290 = (*rawValue_10);
    param_785 = _e290;
    let _e291 = targetIndex_3;
    param_786 = _e291;
    param_787 = _e288;
    let _e292 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_784), (&param_785), (&param_786), (&param_787));
    return _e292;
}

fn dominantAxis_u0028_vf3_u003b_f1_u003b(dir_6: ptr<function, vec3<f32>>, relative: ptr<function, f32>) -> vec3<i32> {
    var a: vec3<f32>;
    var m: f32;

    let _e209 = (*dir_6);
    a = abs(_e209);
    let _e212 = a[0u];
    let _e214 = a[1u];
    let _e216 = a[2u];
    m = max(_e212, max(_e214, _e216));
    let _e219 = m;
    if (_e219 <= 0f) {
        return vec3<i32>(0i, 0i, 0i);
    }
    let _e221 = a;
    let _e222 = m;
    let _e223 = (*relative);
    let _e228 = (*dir_6);
    return (select(vec3<i32>(0i, 0i, 0i), vec3<i32>(1i, 1i, 1i), (_e221 >= vec3((_e222 * _e223)))) * vec3<i32>(sign(_e228)));
}

fn bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b(k_1: ptr<function, i32>, planeCount: ptr<function, i32>, seed: ptr<function, f32>) -> vec3<f32> {
    var z_4: f32;
    var r_4: f32;
    var a_1: f32;

    let _e211 = (*k_1);
    let _e214 = (*planeCount);
    z_4 = ((f32(_e211) + 0.5f) / f32(_e214));
    let _e217 = z_4;
    let _e218 = z_4;
    r_4 = sqrt(max(0f, (1f - (_e217 * _e218))));
    let _e223 = (*k_1);
    let _e226 = (*seed);
    a_1 = ((2.399963f * f32(_e223)) + _e226);
    let _e228 = r_4;
    let _e229 = a_1;
    let _e232 = z_4;
    let _e233 = r_4;
    let _e234 = a_1;
    return vec3<f32>((_e228 * cos(_e229)), _e232, (_e233 * sin(_e234)));
}

fn hash_u0028_vf3_u003b(p_3: ptr<function, vec3<f32>>) -> f32 {
    let _e206 = (*p_3);
    return fract((sin(dot(_e206, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
}

fn bhOrbitAxis_u0028_vi3_u003b_vi3_u003b(center: ptr<function, vec3<i32>>, pos_16: ptr<function, vec3<i32>>) -> vec3<f32> {
    var radial: vec3<f32>;
    var planeCount_1: i32;
    var seed_1: f32;
    var param_788: vec3<f32>;
    var best: vec3<f32>;
    var bestAlign: f32;
    var bestK: i32;
    var k_2: i32;
    var n_1: vec3<f32>;
    var param_789: i32;
    var param_790: i32;
    var param_791: f32;
    var align: f32;
    var sense: f32;
    var param_792: vec3<f32>;

    let _e222 = (*pos_16);
    let _e223 = (*center);
    radial = normalize(vec3<f32>((_e222 - _e223)));
    let _e228 = tuning.blackHoleOrbitPlanes;
    planeCount_1 = bitcast<i32>(clamp(_e228, 1u, 32u));
    let _e231 = (*center);
    param_788 = (vec3<f32>(_e231) + vec3<f32>(29f, 3f, 71f));
    let _e234 = hash_u0028_vf3_u003b((&param_788));
    seed_1 = (_e234 * 6.28318f);
    best = vec3<f32>(0f, 1f, 0f);
    bestAlign = 2f;
    bestK = 0i;
    k_2 = 0i;
    loop {
        let _e236 = k_2;
        let _e237 = planeCount_1;
        if (_e236 < _e237) {
            let _e239 = k_2;
            param_789 = _e239;
            let _e240 = planeCount_1;
            param_790 = _e240;
            let _e241 = seed_1;
            param_791 = _e241;
            let _e242 = bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b((&param_789), (&param_790), (&param_791));
            n_1 = _e242;
            let _e243 = n_1;
            let _e244 = radial;
            align = abs(dot(_e243, _e244));
            let _e247 = align;
            let _e248 = bestAlign;
            if (_e247 < _e248) {
                let _e250 = align;
                bestAlign = _e250;
                let _e251 = n_1;
                best = _e251;
                let _e252 = k_2;
                bestK = _e252;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e253 = k_2;
            k_2 = (_e253 + 1i);
        }
    }
    let _e255 = (*center);
    let _e257 = bestK;
    param_792 = (vec3<f32>(_e255) + vec3<f32>((f32(_e257) * 13f), 101f, 47f));
    let _e262 = hash_u0028_vf3_u003b((&param_792));
    sense = select(1f, -1f, (_e262 < 0.5f));
    let _e265 = best;
    let _e266 = sense;
    return (_e265 * _e266);
}

fn decWaterHighMark_u0028_() {
    let _e206 = atomicAdd((&unnamed_1.waterHighMark), 4294967295u);
    if (_e206 == 0u) {
        let _e209 = atomicAdd((&unnamed_1.waterHighMark), 1u);
    }
    return;
}

fn bhIsPurge_u0028_u1_u003b(code: ptr<function, u32>) -> bool {
    let _e206 = (*code);
    return ((_e206 & 1073741824u) != 0u);
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e206 = (*level);
    return (f32(_e206) + 0.5f);
}

fn updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b(pos_17: ptr<function, vec3<i32>>, currentIndex_13: ptr<function, u32>, rawValue_11: ptr<function, u32>, center_1: ptr<function, vec3<i32>>, slot: ptr<function, i32>, level_1: ptr<function, u32>, purge: ptr<function, bool>, dist_1: ptr<function, f32>, randVal_12: ptr<function, f32>) {
    var type_39: u32;
    var param_793: u32;
    var sleep_1: u32;
    var param_794: u32;
    var param_795: u32;
    var param_796: u32;
    var orbitSpeed: f32;
    var local_27: f32;
    var infallChance: f32;
    var local_28: f32;
    var param_797: u32;
    var param_798: u32;
    var param_799: u32;
    var param_800: u32;
    var param_801: u32;
    var param_802: u32;
    var inward: vec3<f32>;
    var axis: vec3<f32>;
    var param_803: vec3<i32>;
    var param_804: vec3<i32>;
    var tangent: vec3<f32>;
    var tangentLen: f32;
    var axial: f32;
    var grip: vec3<f32>;
    var along: vec3<f32>;
    var pullIn: bool;
    var spiral: vec3<f32>;
    var param_805: vec3<f32>;
    var param_806: f32;
    var param_807: vec3<i32>;
    var param_808: u32;
    var param_809: u32;
    var param_810: vec3<i32>;
    var param_811: vec3<f32>;
    var param_812: f32;
    var param_813: vec3<i32>;
    var param_814: u32;
    var param_815: u32;
    var param_816: vec3<i32>;
    var param_817: vec3<f32>;
    var param_818: f32;
    var param_819: vec3<i32>;
    var param_820: u32;
    var param_821: u32;
    var param_822: vec3<i32>;
    var param_823: vec3<f32>;
    var param_824: f32;
    var param_825: vec3<i32>;
    var param_826: u32;
    var param_827: u32;
    var param_828: vec3<i32>;
    var param_829: vec3<f32>;
    var param_830: f32;
    var param_831: vec3<i32>;
    var param_832: u32;
    var param_833: u32;
    var param_834: vec3<i32>;
    var param_835: vec3<f32>;
    var param_836: f32;
    var param_837: vec3<i32>;
    var param_838: u32;
    var param_839: u32;
    var param_840: vec3<i32>;
    var param_841: u32;
    var param_842: u32;
    var param_843: u32;
    var param_844: u32;
    var param_845: u32;
    var param_846: u32;
    var phi_2237_: bool;

    let _e283 = (*rawValue_11);
    param_793 = _e283;
    let _e284 = getType_u0028_u1_u003b((&param_793));
    type_39 = _e284;
    let _e285 = (*rawValue_11);
    param_794 = _e285;
    let _e286 = getSleep_u0028_u1_u003b((&param_794));
    sleep_1 = _e286;
    let _e287 = (*slot);
    unnamed_1.blackHoleStarve[_e287] = 0u;
    let _e290 = (*dist_1);
    let _e291 = (*level_1);
    param_795 = _e291;
    let _e292 = bhBodyRadius_u0028_u1_u003b((&param_795));
    let _e294 = tuning.blackHoleHorizon;
    if (_e290 <= (_e292 + f32(_e294))) {
        let _e298 = (*currentIndex_13);
        let _e301 = (*rawValue_11);
        let _e302 = atomicCompareExchangeWeak((&unnamed.grid[_e298]), _e301, 0u);
        let _e304 = (*rawValue_11);
        if (_e302.old_value == _e304) {
            let _e306 = (*slot);
            let _e309 = atomicLoad((&unnamed_1.blackHoles[_e306]));
            param_796 = _e309;
            let _e310 = bhIsPurge_u0028_u1_u003b((&param_796));
            if !(_e310) {
                let _e312 = (*slot);
                let _e315 = atomicAdd((&unnamed_1.blackHoleMass[_e312]), 1u);
            }
            let _e316 = type_39;
            if (_e316 == 2u) {
                decWater_u0028_();
                decWaterHighMark_u0028_();
            }
        }
        return;
    }
    let _e318 = (*purge);
    if _e318 {
        let _e320 = tuning.purgeOrbitSpeed;
        local_27 = _e320;
    } else {
        let _e322 = tuning.blackHoleOrbitSpeed;
        local_27 = _e322;
    }
    let _e323 = local_27;
    orbitSpeed = _e323;
    let _e324 = (*purge);
    if _e324 {
        let _e326 = tuning.purgeInfall;
        local_28 = _e326;
    } else {
        let _e328 = tuning.blackHoleInfall;
        local_28 = _e328;
    }
    let _e329 = local_28;
    infallChance = _e329;
    let _e330 = (*randVal_12);
    let _e331 = orbitSpeed;
    let _e332 = (*dist_1);
    if (_e330 > clamp((_e331 / sqrt(max(_e332, 1f))), 0f, 1f)) {
        let _e338 = sleep_1;
        if (_e338 != 0u) {
            let _e340 = (*currentIndex_13);
            let _e343 = (*rawValue_11);
            let _e344 = (*rawValue_11);
            param_797 = _e344;
            let _e345 = getDir_u0028_u1_u003b((&param_797));
            let _e346 = (*rawValue_11);
            param_798 = _e346;
            let _e347 = getAge_u0028_u1_u003b((&param_798));
            let _e348 = type_39;
            param_799 = _e348;
            param_800 = _e345;
            param_801 = 0u;
            param_802 = _e347;
            let _e349 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_799), (&param_800), (&param_801), (&param_802));
            let _e350 = atomicCompareExchangeWeak((&unnamed.grid[_e340]), _e343, _e349);
        }
        return;
    }
    let _e352 = (*center_1);
    let _e353 = (*pos_17);
    inward = normalize(vec3<f32>((_e352 - _e353)));
    let _e357 = (*center_1);
    param_803 = _e357;
    let _e358 = (*pos_17);
    param_804 = _e358;
    let _e359 = bhOrbitAxis_u0028_vi3_u003b_vi3_u003b((&param_803), (&param_804));
    axis = _e359;
    let _e360 = axis;
    let _e361 = inward;
    tangent = cross(_e360, _e361);
    let _e363 = tangent;
    tangentLen = length(_e363);
    let _e365 = tangentLen;
    if (_e365 < 0.05f) {
        let _e367 = axis;
        tangent = normalize(cross(_e367, vec3<f32>(0.577f, 0.577f, 0.577f)));
    } else {
        let _e370 = tangentLen;
        let _e371 = tangent;
        tangent = (_e371 / vec3(_e370));
    }
    let _e374 = (*pos_17);
    let _e375 = (*center_1);
    let _e378 = axis;
    axial = dot(vec3<f32>((_e374 - _e375)), _e378);
    let _e380 = axis;
    let _e382 = axial;
    let _e387 = tuning.blackHolePlaneGrip;
    grip = ((-(_e380) * clamp((_e382 * 0.5f), -1f, 1f)) * _e387);
    let _e389 = tangent;
    let _e390 = grip;
    along = normalize((_e389 + _e390));
    let _e393 = (*randVal_12);
    let _e396 = infallChance;
    pullIn = (fract((_e393 * 61f)) < clamp(_e396, 0f, 1f));
    let _e399 = inward;
    let _e400 = tangent;
    spiral = normalize((_e399 + (_e400 * 0.6f)));
    let _e404 = pullIn;
    phi_2237_ = _e404;
    if _e404 {
        let _e405 = spiral;
        param_805 = _e405;
        param_806 = 0.55f;
        let _e406 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_805), (&param_806));
        let _e407 = (*pos_17);
        param_807 = _e407;
        let _e408 = (*currentIndex_13);
        param_808 = _e408;
        let _e409 = (*rawValue_11);
        param_809 = _e409;
        param_810 = _e406;
        let _e410 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_807), (&param_808), (&param_809), (&param_810));
        phi_2237_ = _e410;
    }
    let _e412 = phi_2237_;
    if _e412 {
        return;
    }
    let _e413 = along;
    param_811 = _e413;
    param_812 = 0.55f;
    let _e414 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_811), (&param_812));
    let _e415 = (*pos_17);
    param_813 = _e415;
    let _e416 = (*currentIndex_13);
    param_814 = _e416;
    let _e417 = (*rawValue_11);
    param_815 = _e417;
    param_816 = _e414;
    let _e418 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_813), (&param_814), (&param_815), (&param_816));
    if _e418 {
        return;
    }
    let _e419 = along;
    param_817 = _e419;
    param_818 = 1f;
    let _e420 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_817), (&param_818));
    let _e421 = (*pos_17);
    param_819 = _e421;
    let _e422 = (*currentIndex_13);
    param_820 = _e422;
    let _e423 = (*rawValue_11);
    param_821 = _e423;
    param_822 = _e420;
    let _e424 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_819), (&param_820), (&param_821), (&param_822));
    if _e424 {
        return;
    }
    let _e425 = tangent;
    param_823 = _e425;
    param_824 = 1f;
    let _e426 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_823), (&param_824));
    let _e427 = (*pos_17);
    param_825 = _e427;
    let _e428 = (*currentIndex_13);
    param_826 = _e428;
    let _e429 = (*rawValue_11);
    param_827 = _e429;
    param_828 = _e426;
    let _e430 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_825), (&param_826), (&param_827), (&param_828));
    if _e430 {
        return;
    }
    let _e431 = inward;
    param_829 = _e431;
    param_830 = 0.55f;
    let _e432 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_829), (&param_830));
    let _e433 = (*pos_17);
    param_831 = _e433;
    let _e434 = (*currentIndex_13);
    param_832 = _e434;
    let _e435 = (*rawValue_11);
    param_833 = _e435;
    param_834 = _e432;
    let _e436 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_831), (&param_832), (&param_833), (&param_834));
    if _e436 {
        return;
    }
    let _e437 = inward;
    param_835 = _e437;
    param_836 = 1f;
    let _e438 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_835), (&param_836));
    let _e439 = (*pos_17);
    param_837 = _e439;
    let _e440 = (*currentIndex_13);
    param_838 = _e440;
    let _e441 = (*rawValue_11);
    param_839 = _e441;
    param_840 = _e438;
    let _e442 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_837), (&param_838), (&param_839), (&param_840));
    if _e442 {
        return;
    }
    let _e443 = sleep_1;
    if (_e443 != 0u) {
        let _e445 = (*currentIndex_13);
        let _e448 = (*rawValue_11);
        let _e449 = (*rawValue_11);
        param_841 = _e449;
        let _e450 = getDir_u0028_u1_u003b((&param_841));
        let _e451 = (*rawValue_11);
        param_842 = _e451;
        let _e452 = getAge_u0028_u1_u003b((&param_842));
        let _e453 = type_39;
        param_843 = _e453;
        param_844 = _e450;
        param_845 = 0u;
        param_846 = _e452;
        let _e454 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_843), (&param_844), (&param_845), (&param_846));
        let _e455 = atomicCompareExchangeWeak((&unnamed.grid[_e445]), _e448, _e454);
    }
    return;
}

fn bhLevel_u0028_u1_u003b(mass: ptr<function, u32>) -> u32 {
    var level_2: u32;
    var l: u32;
    var r_5: f32;
    var param_847: u32;
    var volume: f32;

    level_2 = 0u;
    l = 1u;
    loop {
        let _e211 = l;
        let _e213 = tuning.blackHoleMaxLevel;
        if (_e211 <= min(_e213, 16u)) {
            let _e216 = l;
            param_847 = _e216;
            let _e217 = bhBodyRadius_u0028_u1_u003b((&param_847));
            r_5 = _e217;
            let _e218 = r_5;
            let _e220 = r_5;
            let _e222 = r_5;
            volume = (((4.18879f * _e218) * _e220) * _e222);
            let _e224 = (*mass);
            let _e227 = tuning.blackHoleGrowthCost;
            let _e228 = volume;
            if (f32(_e224) < (_e227 * _e228)) {
                break;
            }
            let _e231 = l;
            level_2 = _e231;
            continue;
        } else {
            break;
        }
        continuing {
            let _e232 = l;
            l = (_e232 + bitcast<u32>(1i));
        }
    }
    let _e235 = level_2;
    return _e235;
}

fn bhLevelFor_u0028_u1_u003b_u1_u003b(code_1: ptr<function, u32>, mass_1: ptr<function, u32>) -> u32 {
    var param_848: u32;
    var param_849: u32;

    let _e209 = (*code_1);
    param_848 = _e209;
    let _e210 = bhIsPurge_u0028_u1_u003b((&param_848));
    if _e210 {
        let _e212 = tuning.purgeLevel;
        let _e214 = (*mass_1);
        let _e217 = tuning.purgeMass;
        return u32((f32(_e212) * clamp((f32(_e214) / f32(max(_e217, 1u))), 0f, 1f)));
    }
    let _e224 = (*mass_1);
    param_849 = _e224;
    let _e225 = bhLevel_u0028_u1_u003b((&param_849));
    return _e225;
}

fn bhDecode_u0028_u1_u003b(code_2: ptr<function, u32>) -> vec3<i32> {
    var i_23: u32;

    let _e207 = (*code_2);
    i_23 = (_e207 & 1073741823u);
    let _e209 = i_23;
    let _e211 = tuning.gridWidth;
    let _e216 = i_23;
    let _e218 = tuning.gridWidth;
    let _e223 = tuning.gridHeight;
    let _e228 = i_23;
    let _e230 = tuning.gridWidth;
    let _e233 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e209 % bitcast<u32>(bitcast<i32>(_e211)))), bitcast<i32>(((_e216 / bitcast<u32>(bitcast<i32>(_e218))) % bitcast<u32>(bitcast<i32>(_e223)))), bitcast<i32>((_e228 / bitcast<u32>((bitcast<i32>(_e230) * bitcast<i32>(_e233))))));
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
    var param_850: u32;
    var d_23: vec3<f32>;
    var distSq: f32;
    var purge_1: bool;
    var param_851: u32;
    var level_3: u32;
    var param_852: u32;
    var param_853: u32;
    var radius: f32;
    var local_29: f32;
    var param_854: vec3<i32>;
    var param_855: u32;
    var param_856: u32;
    var param_857: vec3<i32>;
    var param_858: i32;
    var param_859: u32;
    var param_860: bool;
    var param_861: f32;
    var param_862: f32;

    let _e239 = unnamed_1.blackHoleCount;
    if (_e239 == 0u) {
        return false;
    }
    bestDistSq = 3000000000f;
    bestCenter = vec3<i32>(0i, 0i, 0i);
    bestSlot = -1i;
    bestLevel = 0u;
    bestPurge = false;
    let _e242 = tuning.blackHoleRadius;
    let _e244 = tuning.blackHoleMaxLevel;
    maxRadius = f32((_e242 + min(_e244, 16u)));
    let _e248 = maxRadius;
    let _e249 = maxRadius;
    maxRadiusSq = (_e248 * _e249);
    i_24 = 0i;
    loop {
        let _e251 = i_24;
        if (_e251 < 8i) {
            let _e253 = i_24;
            let _e256 = atomicLoad((&unnamed_1.blackHoles[_e253]));
            code_3 = _e256;
            let _e257 = code_3;
            if (_e257 == 0u) {
                continue;
            }
            let _e259 = code_3;
            param_850 = _e259;
            let _e260 = bhDecode_u0028_u1_u003b((&param_850));
            center_2 = _e260;
            let _e261 = center_2;
            let _e262 = (*pos_18);
            d_23 = vec3<f32>((_e261 - _e262));
            let _e265 = d_23;
            let _e266 = d_23;
            distSq = dot(_e265, _e266);
            let _e268 = code_3;
            param_851 = _e268;
            let _e269 = bhIsPurge_u0028_u1_u003b((&param_851));
            purge_1 = _e269;
            let _e270 = purge_1;
            let _e272 = distSq;
            let _e273 = maxRadiusSq;
            if (!(_e270) && (_e272 > _e273)) {
                continue;
            }
            let _e276 = distSq;
            let _e277 = bestDistSq;
            if (_e276 >= _e277) {
                continue;
            }
            let _e279 = i_24;
            let _e280 = code_3;
            param_852 = _e280;
            let _e283 = atomicLoad((&unnamed_1.blackHoleMass[_e279]));
            param_853 = _e283;
            let _e284 = bhLevelFor_u0028_u1_u003b_u1_u003b((&param_852), (&param_853));
            level_3 = _e284;
            let _e285 = purge_1;
            if _e285 {
                local_29 = 1000000000f;
            } else {
                let _e287 = tuning.blackHoleRadius;
                let _e288 = level_3;
                local_29 = f32((_e287 + _e288));
            }
            let _e291 = local_29;
            radius = _e291;
            let _e292 = distSq;
            let _e293 = radius;
            let _e294 = radius;
            if (_e292 <= (_e293 * _e294)) {
                let _e297 = distSq;
                bestDistSq = _e297;
                let _e298 = center_2;
                bestCenter = _e298;
                let _e299 = i_24;
                bestSlot = _e299;
                let _e300 = level_3;
                bestLevel = _e300;
                let _e301 = purge_1;
                bestPurge = _e301;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e302 = i_24;
            i_24 = (_e302 + 1i);
        }
    }
    let _e304 = bestSlot;
    if (_e304 < 0i) {
        return false;
    }
    let _e306 = bestDistSq;
    let _e308 = (*pos_18);
    param_854 = _e308;
    let _e309 = (*currentIndex_14);
    param_855 = _e309;
    let _e310 = (*rawValue_12);
    param_856 = _e310;
    let _e311 = bestCenter;
    param_857 = _e311;
    let _e312 = bestSlot;
    param_858 = _e312;
    let _e313 = bestLevel;
    param_859 = _e313;
    let _e314 = bestPurge;
    param_860 = _e314;
    param_861 = sqrt(_e306);
    let _e315 = (*randVal_13);
    param_862 = _e315;
    updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b((&param_854), (&param_855), (&param_856), (&param_857), (&param_858), (&param_859), (&param_860), (&param_861), (&param_862));
    return true;
}

fn getRainDropChance_u0028_u1_u003b_u1_u003b(candidates: ptr<function, u32>, remaining: ptr<function, u32>) -> f32 {
    var want: u32;

    let _e208 = (*candidates);
    if (_e208 == 0u) {
        return 0f;
    }
    let _e211 = tuning.rainDropsPerTick;
    let _e212 = (*remaining);
    want = min(_e211, _e212);
    let _e214 = want;
    let _e216 = (*candidates);
    return clamp((f32(_e214) / f32(_e216)), 0f, 1f);
}

fn cloudRadii_u0028_i1_u003b(i_25: ptr<function, i32>) -> vec3<f32> {
    let _e206 = (*i_25);
    let _e211 = unnamed_1.cloudCache[((_e206 * 7i) + 3i)];
    let _e212 = (*i_25);
    let _e217 = unnamed_1.cloudCache[((_e212 * 7i) + 4i)];
    let _e218 = (*i_25);
    let _e223 = unnamed_1.cloudCache[((_e218 * 7i) + 5i)];
    return vec3<f32>(_e211, _e217, _e223);
}

fn cloudCenter_u0028_i1_u003b(i_26: ptr<function, i32>) -> vec3<f32> {
    let _e206 = (*i_26);
    let _e211 = unnamed_1.cloudCache[((_e206 * 7i) + 0i)];
    let _e212 = (*i_26);
    let _e217 = unnamed_1.cloudCache[((_e212 * 7i) + 1i)];
    let _e218 = (*i_26);
    let _e223 = unnamed_1.cloudCache[((_e218 * 7i) + 2i)];
    return vec3<f32>(_e211, _e217, _e223);
}

fn cloudFade_u0028_i1_u003b(i_27: ptr<function, i32>) -> f32 {
    let _e206 = (*i_27);
    let _e211 = unnamed_1.cloudCache[((_e206 * 7i) + 6i)];
    return _e211;
}

fn bhRegister_u0028_vi3_u003b(p_4: ptr<function, vec3<i32>>) -> bool {
    var code_4: u32;
    var param_863: vec3<i32>;
    var i_28: i32;

    let _e209 = (*p_4);
    param_863 = _e209;
    let _e210 = getIndex_u0028_vi3_u003b((&param_863));
    code_4 = (2147483648u | _e210);
    i_28 = 0i;
    loop {
        let _e212 = i_28;
        if (_e212 < 8i) {
            let _e214 = i_28;
            let _e217 = code_4;
            let _e218 = atomicCompareExchangeWeak((&unnamed_1.blackHoles[_e214]), 0u, _e217);
            if (_e218.old_value == 0u) {
                let _e221 = i_28;
                atomicStore((&unnamed_1.blackHoleMass[_e221]), 0u);
                let _e224 = i_28;
                unnamed_1.blackHoleStarve[_e224] = 0u;
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e227 = i_28;
            i_28 = (_e227 + 1i);
        }
    }
    return false;
}

fn writeCell_u0028_u1_u003b_u1_u003b(index_1: ptr<function, u32>, value_2: ptr<function, u32>) {
    let _e207 = (*index_1);
    let _e208 = (*value_2);
    atomicStore((&unnamed.grid[_e207]), _e208);
    return;
}

fn lavaSpawnCoolness_u0028_u1_u003b(type_40: ptr<function, u32>) -> u32 {
    var param_864: u32;

    let _e207 = (*type_40);
    if (_e207 == 12u) {
        let _e209 = lavaSolidifyCoolness_u0028_();
        return _e209;
    }
    let _e210 = (*type_40);
    param_864 = _e210;
    let _e211 = isLava_u0028_u1_u003b((&param_864));
    if _e211 {
        let _e212 = (*type_40);
        let _e215 = tuning.lavaStageSize;
        return ((_e212 - 8u) * max(_e215, 1u));
    }
    return 0u;
}

fn locustSpawnCount_u0028_u1_u003b(type_41: ptr<function, u32>) -> u32 {
    var param_865: u32;

    let _e207 = (*type_41);
    param_865 = _e207;
    let _e208 = isLocust_u0028_u1_u003b((&param_865));
    if !(_e208) {
        return 0u;
    }
    let _e210 = (*type_41);
    let _e213 = locustStage_u0028_();
    let _e215 = locustMaxCount_u0028_();
    return min((((_e210 - 13u) + 1u) * _e213), _e215);
}

fn bhRelease_u0028_vi3_u003b(p_5: ptr<function, vec3<i32>>) {
    var code_5: u32;
    var param_866: vec3<i32>;
    var i_29: i32;

    let _e209 = (*p_5);
    param_866 = _e209;
    let _e210 = getIndex_u0028_vi3_u003b((&param_866));
    code_5 = (2147483648u | _e210);
    i_29 = 0i;
    loop {
        let _e212 = i_29;
        if (_e212 < 8i) {
            let _e214 = i_29;
            let _e217 = code_5;
            let _e218 = atomicCompareExchangeWeak((&unnamed_1.blackHoles[_e214]), _e217, 0u);
            continue;
        } else {
            break;
        }
        continuing {
            let _e220 = i_29;
            i_29 = (_e220 + 1i);
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

    let _e212 = pc.spawnSize;
    halfMin = (_e212 / 2i);
    let _e215 = pc.spawnSize;
    halfMax = ((_e215 - 1i) / 2i);
    let _e219 = (*pos_19)[0u];
    let _e221 = pc.spawnX;
    let _e222 = halfMin;
    let _e224 = (_e219 < (_e221 - _e222));
    phi_1389_ = _e224;
    if !(_e224) {
        let _e227 = (*pos_19)[0u];
        let _e229 = pc.spawnX;
        let _e230 = halfMax;
        phi_1389_ = (_e227 > (_e229 + _e230));
    }
    let _e234 = phi_1389_;
    if _e234 {
        return false;
    }
    let _e236 = (*pos_19)[1u];
    let _e238 = pc.spawnY;
    let _e239 = halfMin;
    let _e241 = (_e236 < (_e238 - _e239));
    phi_1411_ = _e241;
    if !(_e241) {
        let _e244 = (*pos_19)[1u];
        let _e246 = pc.spawnY;
        let _e247 = halfMax;
        phi_1411_ = (_e244 > (_e246 + _e247));
    }
    let _e251 = phi_1411_;
    if _e251 {
        return false;
    }
    let _e253 = (*pos_19)[2u];
    let _e255 = pc.spawnZ;
    let _e256 = halfMin;
    let _e258 = (_e253 < (_e255 - _e256));
    phi_1432_ = _e258;
    if !(_e258) {
        let _e261 = (*pos_19)[2u];
        let _e263 = pc.spawnZ;
        let _e264 = halfMax;
        phi_1432_ = (_e261 > (_e263 + _e264));
    }
    let _e268 = phi_1432_;
    if _e268 {
        return false;
    }
    let _e270 = pc.spawnShape;
    if (_e270 != 1i) {
        return true;
    }
    let _e273 = pc.spawnX;
    let _e276 = pc.spawnY;
    let _e279 = pc.spawnZ;
    let _e282 = halfMax;
    let _e283 = halfMin;
    center_3 = (vec3<f32>(f32(_e273), f32(_e276), f32(_e279)) + vec3((f32(((_e282 - _e283) + 1i)) * 0.5f)));
    let _e290 = (*pos_19);
    let _e294 = center_3;
    d_24 = ((vec3<f32>(_e290) + vec3(0.5f)) - _e294);
    let _e297 = pc.spawnSize;
    radius_1 = (f32(_e297) * 0.5f);
    let _e300 = d_24;
    let _e301 = d_24;
    let _e303 = radius_1;
    let _e304 = radius_1;
    return (dot(_e300, _e301) <= (_e303 * _e304));
}

fn cloudEdgeFade_u0028_vf2_u003b(c_8: ptr<function, vec2<f32>>) -> f32 {
    var d_25: f32;
    var fx: f32;
    var fz: f32;

    let _e210 = tuning.cloudEdgeFadeDist;
    d_25 = max(_e210, 0.001f);
    let _e212 = d_25;
    let _e214 = (*c_8)[0u];
    let _e216 = d_25;
    let _e218 = tuning.gridWidth;
    let _e222 = (*c_8)[0u];
    fx = (smoothstep(0f, _e212, _e214) * smoothstep(0f, _e216, (f32(bitcast<i32>(_e218)) - _e222)));
    let _e226 = d_25;
    let _e228 = (*c_8)[1u];
    let _e230 = d_25;
    let _e232 = tuning.gridDepth;
    let _e236 = (*c_8)[1u];
    fz = (smoothstep(0f, _e226, _e228) * smoothstep(0f, _e230, (f32(bitcast<i32>(_e232)) - _e236)));
    let _e240 = fx;
    let _e241 = fz;
    return (_e240 * _e241);
}

fn cloudRadiiSource_u0028_i1_u003b(i_30: ptr<function, i32>) -> vec3<f32> {
    var h4_: f32;
    var param_867: vec3<f32>;
    var h5_: f32;
    var param_868: vec3<f32>;
    var h6_: f32;
    var param_869: vec3<f32>;
    var rxz: f32;

    let _e213 = (*i_30);
    param_867 = vec3<f32>(f32(_e213), 211f, 5f);
    let _e216 = hash_u0028_vf3_u003b((&param_867));
    h4_ = _e216;
    let _e217 = (*i_30);
    param_868 = vec3<f32>(f32(_e217), 71f, 61f);
    let _e220 = hash_u0028_vf3_u003b((&param_868));
    h5_ = _e220;
    let _e221 = (*i_30);
    param_869 = vec3<f32>(f32(_e221), 19f, 173f);
    let _e224 = hash_u0028_vf3_u003b((&param_869));
    h6_ = _e224;
    let _e225 = h4_;
    rxz = (10f + (_e225 * 18f));
    let _e228 = rxz;
    let _e229 = h5_;
    let _e232 = rxz;
    let _e233 = h6_;
    return vec3<f32>(_e228, (4f + (_e229 * 6f)), (_e232 * (0.7f + (_e233 * 0.6f))));
}

fn cloudCenterXZSource_u0028_i1_u003b_f1_u003b(i_31: ptr<function, i32>, t_4: ptr<function, f32>) -> vec2<f32> {
    var h1_: f32;
    var param_870: vec3<f32>;
    var h2_: f32;
    var param_871: vec3<f32>;
    var phase_1: f32;
    var param_872: vec3<f32>;
    var x_4: f32;
    var z_5: f32;

    let _e215 = (*i_31);
    param_870 = vec3<f32>(f32(_e215), 11f, 3f);
    let _e218 = hash_u0028_vf3_u003b((&param_870));
    h1_ = _e218;
    let _e219 = (*i_31);
    param_871 = vec3<f32>(f32(_e219), 47f, 91f);
    let _e222 = hash_u0028_vf3_u003b((&param_871));
    h2_ = _e222;
    let _e223 = (*i_31);
    param_872 = vec3<f32>(f32(_e223), 91f, 250f);
    let _e226 = hash_u0028_vf3_u003b((&param_872));
    phase_1 = (_e226 * 6.28318f);
    let _e228 = h1_;
    let _e230 = tuning.gridWidth;
    let _e234 = (*t_4);
    let _e236 = tuning.cloudDriftSpeed;
    let _e238 = ((_e228 * f32(bitcast<i32>(_e230))) + (_e234 * _e236));
    let _e240 = tuning.gridWidth;
    let _e242 = f32(bitcast<i32>(_e240));
    x_4 = (_e238 - (floor((_e238 / _e242)) * _e242));
    let _e247 = h2_;
    let _e249 = tuning.gridDepth;
    let _e253 = (*t_4);
    let _e255 = phase_1;
    let _e259 = ((_e247 * f32(bitcast<i32>(_e249))) + (sin(((_e253 * 0.12f) + _e255)) * 3f));
    let _e261 = tuning.gridDepth;
    let _e263 = f32(bitcast<i32>(_e261));
    z_5 = (_e259 - (floor((_e259 / _e263)) * _e263));
    let _e268 = x_4;
    let _e269 = z_5;
    return vec2<f32>(_e268, _e269);
}

fn updateCloudCache_u0028_() {
    var i_32: u32;
    var c_9: vec2<f32>;
    var param_873: i32;
    var param_874: f32;
    var r_6: vec3<f32>;
    var param_875: i32;
    var h3_: f32;
    var param_876: vec3<f32>;
    var cy: f32;
    var param_877: vec2<f32>;
    var phi_1689_: bool;

    let _e216 = gl_GlobalInvocationID_1[1u];
    let _e217 = (_e216 != 0u);
    phi_1689_ = _e217;
    if !(_e217) {
        let _e220 = gl_GlobalInvocationID_1[2u];
        phi_1689_ = (_e220 != 0u);
    }
    let _e223 = phi_1689_;
    if _e223 {
        return;
    }
    let _e225 = gl_GlobalInvocationID_1[0u];
    i_32 = _e225;
    let _e226 = i_32;
    if (_e226 >= 64u) {
        return;
    }
    let _e228 = i_32;
    param_873 = bitcast<i32>(_e228);
    let _e231 = pc.time;
    param_874 = _e231;
    let _e232 = cloudCenterXZSource_u0028_i1_u003b_f1_u003b((&param_873), (&param_874));
    c_9 = _e232;
    let _e233 = i_32;
    param_875 = bitcast<i32>(_e233);
    let _e235 = cloudRadiiSource_u0028_i1_u003b((&param_875));
    r_6 = _e235;
    let _e236 = i_32;
    param_876 = vec3<f32>(f32(_e236), 133f, 7f);
    let _e239 = hash_u0028_vf3_u003b((&param_876));
    h3_ = _e239;
    let _e241 = tuning.gridHeight;
    let _e245 = r_6[1u];
    let _e247 = h3_;
    cy = ((f32(bitcast<i32>(_e241)) + _e245) + (_e247 * 4f));
    let _e250 = i_32;
    let _e254 = c_9[0u];
    unnamed_1.cloudCache[((_e250 * 7u) + 0u)] = _e254;
    let _e257 = i_32;
    let _e260 = cy;
    unnamed_1.cloudCache[((_e257 * 7u) + 1u)] = _e260;
    let _e263 = i_32;
    let _e267 = c_9[1u];
    unnamed_1.cloudCache[((_e263 * 7u) + 2u)] = _e267;
    let _e270 = i_32;
    let _e274 = r_6[0u];
    unnamed_1.cloudCache[((_e270 * 7u) + 3u)] = _e274;
    let _e277 = i_32;
    let _e281 = r_6[1u];
    unnamed_1.cloudCache[((_e277 * 7u) + 4u)] = _e281;
    let _e284 = i_32;
    let _e288 = r_6[2u];
    unnamed_1.cloudCache[((_e284 * 7u) + 5u)] = _e288;
    let _e291 = i_32;
    let _e294 = c_9;
    param_877 = _e294;
    let _e295 = cloudEdgeFade_u0028_vf2_u003b((&param_877));
    unnamed_1.cloudCache[((_e291 * 7u) + 6u)] = _e295;
    return;
}

fn getRainThreshold_u0028_() -> u32 {
    let _e206 = tuning.rainStartLayers;
    let _e208 = tuning.gridWidth;
    let _e212 = tuning.gridHeight;
    return (_e206 * (bitcast<u32>(bitcast<i32>(_e208)) * bitcast<u32>(bitcast<i32>(_e212))));
}

fn getWaterDeficit_u0028_() -> u32 {
    var local_30: u32;

    let _e207 = atomicLoad((&unnamed_1.waterHighMark));
    let _e209 = atomicLoad((&unnamed_1.waterVoxelCount));
    if (_e207 > _e209) {
        let _e212 = atomicLoad((&unnamed_1.waterHighMark));
        let _e214 = atomicLoad((&unnamed_1.waterVoxelCount));
        local_30 = (_e212 - _e214);
    } else {
        local_30 = 0u;
    }
    let _e216 = local_30;
    return _e216;
}

fn updateSimState_u0028_() {
    var live: u32;
    var i_33: i32;
    var code_6: u32;
    var voxel: u32;
    var param_878: u32;
    var param_879: u32;
    var starve: u32;
    var purge_2: bool;
    var param_880: u32;
    var grace: u32;
    var local_31: u32;
    var decay: u32;
    var local_32: u32;
    var mass_2: u32;
    var param_881: u32;
    var param_882: u32;
    var deficit: u32;
    var remainingToTarget: u32;
    var local_33: u32;
    var chargeSource: u32;
    var local_34: u32;
    var chargeTarget: f32;
    var charge: f32;
    var crossedTime: f32;
    var phi_8301_: bool;
    var phi_8308_: bool;
    var phi_8425_: bool;
    var phi_8510_: bool;

    let _e230 = gl_GlobalInvocationID_1[0u];
    let _e231 = (_e230 != 0u);
    phi_8301_ = _e231;
    if !(_e231) {
        let _e234 = gl_GlobalInvocationID_1[1u];
        phi_8301_ = (_e234 != 0u);
    }
    let _e237 = phi_8301_;
    phi_8308_ = _e237;
    if !(_e237) {
        let _e240 = gl_GlobalInvocationID_1[2u];
        phi_8308_ = (_e240 != 0u);
    }
    let _e243 = phi_8308_;
    if _e243 {
        return;
    }
    live = 0u;
    i_33 = 0i;
    loop {
        let _e244 = i_33;
        if (_e244 < 8i) {
            let _e246 = i_33;
            let _e249 = atomicLoad((&unnamed_1.blackHoles[_e246]));
            code_6 = _e249;
            let _e250 = code_6;
            if (_e250 == 0u) {
                continue;
            }
            let _e252 = code_6;
            voxel = (_e252 & 1073741823u);
            let _e254 = voxel;
            param_878 = _e254;
            let _e255 = readCell_u0028_u1_u003b((&param_878));
            param_879 = _e255;
            let _e256 = getType_u0028_u1_u003b((&param_879));
            if (_e256 != 7u) {
                let _e258 = i_33;
                atomicStore((&unnamed_1.blackHoles[_e258]), 0u);
                continue;
            }
            let _e261 = i_33;
            let _e264 = unnamed_1.blackHoleStarve[_e261];
            starve = (_e264 + 1u);
            let _e266 = i_33;
            let _e267 = starve;
            unnamed_1.blackHoleStarve[_e266] = _e267;
            let _e270 = code_6;
            param_880 = _e270;
            let _e271 = bhIsPurge_u0028_u1_u003b((&param_880));
            purge_2 = _e271;
            let _e272 = purge_2;
            if _e272 {
                let _e274 = tuning.purgeStarveGrace;
                local_31 = _e274;
            } else {
                let _e276 = tuning.blackHoleStarveGrace;
                local_31 = _e276;
            }
            let _e277 = local_31;
            grace = _e277;
            let _e278 = purge_2;
            if _e278 {
                let _e280 = tuning.purgeDecayRate;
                local_32 = _e280;
            } else {
                let _e282 = tuning.blackHoleDecayRate;
                local_32 = _e282;
            }
            let _e283 = local_32;
            decay = _e283;
            let _e284 = starve;
            let _e285 = grace;
            if (_e284 > _e285) {
                let _e287 = i_33;
                let _e290 = atomicLoad((&unnamed_1.blackHoleMass[_e287]));
                mass_2 = _e290;
                let _e291 = mass_2;
                if (_e291 == 0u) {
                    let _e293 = voxel;
                    param_881 = _e293;
                    param_882 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_881), (&param_882));
                    let _e294 = i_33;
                    atomicStore((&unnamed_1.blackHoles[_e294]), 0u);
                    continue;
                }
                let _e297 = i_33;
                let _e298 = mass_2;
                let _e299 = mass_2;
                let _e300 = decay;
                atomicStore((&unnamed_1.blackHoleMass[_e297]), (_e298 - min(_e299, _e300)));
            }
            let _e305 = live;
            live = (_e305 + bitcast<u32>(1i));
            continue;
        } else {
            break;
        }
        continuing {
            let _e308 = i_33;
            i_33 = (_e308 + 1i);
        }
    }
    let _e310 = live;
    unnamed_1.blackHoleCount = _e310;
    let _e313 = unnamed_1.rainPhase;
    let _e314 = (_e313 == 0u);
    phi_8425_ = _e314;
    if _e314 {
        let _e316 = atomicLoad((&unnamed_1.waterVoxelCount));
        let _e318 = atomicLoad((&unnamed_1.waterHighMark));
        phi_8425_ = (_e316 > _e318);
    }
    let _e321 = phi_8425_;
    if _e321 {
        let _e323 = atomicLoad((&unnamed_1.waterVoxelCount));
        atomicStore((&unnamed_1.waterHighMark), _e323);
    }
    let _e325 = getWaterDeficit_u0028_();
    deficit = _e325;
    let _e327 = atomicLoad((&unnamed_1.maxOccupiedY));
    if (_e327 > 0u) {
        let _e330 = atomicAdd((&unnamed_1.maxOccupiedY), 4294967295u);
    }
    let _e332 = atomicLoad((&unnamed_1.rainCandidateCount));
    unnamed_1.rainCandidateEstimate = _e332;
    atomicStore((&unnamed_1.rainCandidateCount), 0u);
    let _e336 = unnamed_1.rainTargetLevel;
    let _e338 = atomicLoad((&unnamed_1.waterVoxelCount));
    if (_e336 > _e338) {
        let _e341 = unnamed_1.rainTargetLevel;
        let _e343 = atomicLoad((&unnamed_1.waterVoxelCount));
        local_33 = (_e341 - _e343);
    } else {
        local_33 = 0u;
    }
    let _e345 = local_33;
    remainingToTarget = _e345;
    let _e347 = unnamed_1.rainPhase;
    if (_e347 == 0u) {
        let _e350 = atomicLoad((&unnamed_1.cloudWaterCount));
        local_34 = _e350;
    } else {
        let _e351 = remainingToTarget;
        local_34 = _e351;
    }
    let _e352 = local_34;
    chargeSource = _e352;
    let _e353 = chargeSource;
    let _e356 = tuning.cloudChargeSaturation;
    chargeTarget = clamp((f32(_e353) / max(_e356, 1f)), 0f, 1f);
    let _e361 = unnamed_1.cloudChargeBits;
    charge = bitcast<f32>(_e361);
    let _e363 = chargeTarget;
    let _e364 = charge;
    let _e367 = tuning.cloudChargeEaseRate;
    let _e370 = charge;
    charge = (_e370 + ((_e363 - _e364) * clamp(_e367, 0f, 1f)));
    let _e372 = charge;
    unnamed_1.cloudChargeBits = bitcast<u32>(clamp(_e372, 0f, 1f));
    let _e377 = unnamed_1.rainPhase;
    if (_e377 == 0u) {
        let _e380 = atomicLoad((&unnamed_1.cloudWaterCount));
        let _e381 = (_e380 > 0u);
        phi_8510_ = _e381;
        if _e381 {
            let _e382 = deficit;
            let _e383 = getRainThreshold_u0028_();
            phi_8510_ = (_e382 > _e383);
        }
        let _e386 = phi_8510_;
        if _e386 {
            unnamed_1.rainPhase = 1u;
            let _e389 = pc.time;
            unnamed_1.rainPhaseTimeBits = bitcast<u32>(_e389);
            let _e393 = atomicLoad((&unnamed_1.waterHighMark));
            let _e394 = deficit;
            let _e397 = tuning.rainOvershoot;
            unnamed_1.rainTargetLevel = (_e393 + u32((f32(_e394) * max(_e397, 0f))));
        }
    } else {
        let _e404 = unnamed_1.rainPhase;
        if (_e404 == 1u) {
            let _e407 = unnamed_1.rainPhaseTimeBits;
            crossedTime = bitcast<f32>(_e407);
            let _e410 = pc.time;
            let _e411 = crossedTime;
            let _e414 = tuning.rainDarkenDelay;
            if ((_e410 - _e411) >= _e414) {
                unnamed_1.rainPhase = 2u;
                let _e418 = pc.time;
                unnamed_1.rainPhaseTimeBits = bitcast<u32>(_e418);
            }
        } else {
            let _e422 = unnamed_1.rainPhase;
            if (_e422 == 2u) {
                let _e424 = remainingToTarget;
                if (_e424 == 0u) {
                    unnamed_1.rainPhase = 0u;
                    unnamed_1.rainPhaseTimeBits = 0u;
                    atomicStore((&unnamed_1.cloudWaterCount), 0u);
                }
            }
        }
    }
    return;
}

fn main_1() {
    var pos_20: vec3<i32>;
    var param_883: vec3<i32>;
    var spawnIndex: u32;
    var param_884: vec3<i32>;
    var oldType: u32;
    var param_885: u32;
    var param_886: u32;
    var newType_3: u32;
    var param_887: vec3<i32>;
    var seedAge: u32;
    var param_888: u32;
    var local_35: u32;
    var param_889: u32;
    var param_890: u32;
    var param_891: u32;
    var param_892: u32;
    var param_893: u32;
    var param_894: u32;
    var param_895: u32;
    var param_896: u32;
    var param_897: vec3<i32>;
    var param_898: u32;
    var param_899: u32;
    var currentIndex_15: u32;
    var param_900: vec3<i32>;
    var rawValue_13: u32;
    var param_901: u32;
    var currentType_1: u32;
    var param_902: u32;
    var underCloud: bool;
    var cloudN: i32;
    var ci: i32;
    var param_903: i32;
    var c_10: vec3<f32>;
    var param_904: i32;
    var r_7: vec3<f32>;
    var param_905: i32;
    var d_26: vec2<f32>;
    var remaining_1: u32;
    var local_36: u32;
    var dropChance: f32;
    var param_906: u32;
    var param_907: u32;
    var rainRandVal: f32;
    var param_908: vec3<f32>;
    var param_909: u32;
    var param_910: u32;
    var param_911: u32;
    var param_912: u32;
    var randVal_14: f32;
    var param_913: vec3<f32>;
    var param_914: vec3<i32>;
    var param_915: u32;
    var param_916: u32;
    var param_917: f32;
    var currentDir_6: u32;
    var param_918: u32;
    var currentSleep_7: u32;
    var param_919: u32;
    var currentAge_10: u32;
    var param_920: u32;
    var param_921: vec3<i32>;
    var param_922: u32;
    var param_923: u32;
    var param_924: u32;
    var param_925: u32;
    var param_926: f32;
    var param_927: vec3<i32>;
    var param_928: u32;
    var param_929: u32;
    var param_930: u32;
    var param_931: u32;
    var param_932: u32;
    var param_933: f32;
    var param_934: vec3<i32>;
    var param_935: u32;
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
    var param_953: f32;
    var param_954: vec3<i32>;
    var param_955: u32;
    var param_956: u32;
    var param_957: u32;
    var param_958: u32;
    var param_959: u32;
    var param_960: f32;
    var param_961: vec3<i32>;
    var param_962: u32;
    var param_963: u32;
    var param_964: u32;
    var param_965: f32;
    var param_966: vec3<i32>;
    var param_967: u32;
    var param_968: u32;
    var param_969: u32;
    var param_970: u32;
    var param_971: u32;
    var param_972: f32;
    var param_973: vec3<i32>;
    var param_974: u32;
    var param_975: u32;
    var param_976: u32;
    var param_977: u32;
    var param_978: f32;
    var param_979: vec3<i32>;
    var param_980: u32;
    var param_981: u32;
    var param_982: u32;
    var param_983: f32;
    var phi_8936_: bool;
    var phi_8946_: bool;
    var phi_8960_: bool;
    var phi_9061_: bool;
    var phi_9068_: bool;
    var phi_9079_: bool;
    var phi_9086_: bool;
    var phi_9097_: bool;
    var phi_9120_: bool;
    var phi_9130_: bool;
    var phi_9308_: bool;

    let _e329 = gl_GlobalInvocationID_1;
    pos_20 = bitcast<vec3<i32>>(_e329);
    let _e332 = pos_20[0u];
    let _e334 = tuning.gridWidth;
    let _e336 = (_e332 >= bitcast<i32>(_e334));
    phi_8936_ = _e336;
    if !(_e336) {
        let _e339 = pos_20[1u];
        let _e341 = tuning.gridHeight;
        phi_8936_ = (_e339 >= bitcast<i32>(_e341));
    }
    let _e345 = phi_8936_;
    phi_8946_ = _e345;
    if !(_e345) {
        let _e348 = pos_20[2u];
        let _e350 = tuning.gridDepth;
        phi_8946_ = (_e348 >= bitcast<i32>(_e350));
    }
    let _e354 = phi_8946_;
    if _e354 {
        return;
    }
    updateSimState_u0028_();
    updateCloudCache_u0028_();
    let _e356 = pc.spawnActive;
    let _e357 = (_e356 == 1i);
    phi_8960_ = _e357;
    if _e357 {
        let _e358 = pos_20;
        param_883 = _e358;
        let _e359 = inBrush_u0028_vi3_u003b((&param_883));
        phi_8960_ = _e359;
    }
    let _e361 = phi_8960_;
    if _e361 {
        let _e362 = pos_20;
        param_884 = _e362;
        let _e363 = getIndex_u0028_vi3_u003b((&param_884));
        spawnIndex = _e363;
        let _e364 = spawnIndex;
        param_885 = _e364;
        let _e365 = readCell_u0028_u1_u003b((&param_885));
        param_886 = _e365;
        let _e366 = getType_u0028_u1_u003b((&param_886));
        oldType = _e366;
        let _e368 = pc.spawnType;
        newType_3 = bitcast<u32>(_e368);
        let _e370 = newType_3;
        let _e372 = oldType;
        if ((_e370 != 7u) || (_e372 != 7u)) {
            let _e375 = oldType;
            let _e376 = newType_3;
            if (_e375 != _e376) {
                let _e378 = oldType;
                if (_e378 == 2u) {
                    decWater_u0028_();
                    decWaterHighMark_u0028_();
                }
                let _e380 = oldType;
                if (_e380 == 7u) {
                    let _e382 = pos_20;
                    param_887 = _e382;
                    bhRelease_u0028_vi3_u003b((&param_887));
                }
                let _e383 = newType_3;
                if (_e383 == 2u) {
                    incWater_u0028_();
                }
            }
            let _e385 = newType_3;
            param_888 = _e385;
            let _e386 = isLocust_u0028_u1_u003b((&param_888));
            if _e386 {
                let _e387 = newType_3;
                param_889 = _e387;
                let _e388 = locustSpawnCount_u0028_u1_u003b((&param_889));
                local_35 = _e388;
            } else {
                let _e389 = newType_3;
                param_890 = _e389;
                let _e390 = lavaSpawnCoolness_u0028_u1_u003b((&param_890));
                local_35 = _e390;
            }
            let _e391 = local_35;
            seedAge = _e391;
            let _e392 = newType_3;
            param_891 = _e392;
            param_892 = 0u;
            param_893 = 0u;
            let _e393 = seedAge;
            param_894 = _e393;
            let _e394 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_891), (&param_892), (&param_893), (&param_894));
            let _e395 = spawnIndex;
            param_895 = _e395;
            param_896 = _e394;
            writeCell_u0028_u1_u003b_u1_u003b((&param_895), (&param_896));
            let _e396 = newType_3;
            if (_e396 == 7u) {
                storageBarrier();
                let _e398 = pos_20;
                param_897 = _e398;
                let _e399 = bhRegister_u0028_vi3_u003b((&param_897));
                if !(_e399) {
                    let _e401 = spawnIndex;
                    param_898 = _e401;
                    param_899 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_898), (&param_899));
                }
            }
        }
    }
    let _e403 = pos_20[0u];
    let _e404 = (_e403 < 1i);
    phi_9061_ = _e404;
    if !(_e404) {
        let _e407 = pos_20[0u];
        let _e409 = tuning.gridWidth;
        phi_9061_ = (_e407 >= (bitcast<i32>(_e409) - 1i));
    }
    let _e414 = phi_9061_;
    phi_9068_ = _e414;
    if !(_e414) {
        let _e417 = pos_20[1u];
        phi_9068_ = (_e417 < 1i);
    }
    let _e420 = phi_9068_;
    phi_9079_ = _e420;
    if !(_e420) {
        let _e423 = pos_20[1u];
        let _e425 = tuning.gridHeight;
        phi_9079_ = (_e423 >= (bitcast<i32>(_e425) - 1i));
    }
    let _e430 = phi_9079_;
    phi_9086_ = _e430;
    if !(_e430) {
        let _e433 = pos_20[2u];
        phi_9086_ = (_e433 < 1i);
    }
    let _e436 = phi_9086_;
    phi_9097_ = _e436;
    if !(_e436) {
        let _e439 = pos_20[2u];
        let _e441 = tuning.gridDepth;
        phi_9097_ = (_e439 >= (bitcast<i32>(_e441) - 1i));
    }
    let _e446 = phi_9097_;
    if _e446 {
        return;
    }
    let _e447 = pos_20;
    param_900 = _e447;
    let _e448 = getIndex_u0028_vi3_u003b((&param_900));
    currentIndex_15 = _e448;
    let _e449 = currentIndex_15;
    param_901 = _e449;
    let _e450 = readCell_u0028_u1_u003b((&param_901));
    rawValue_13 = _e450;
    let _e451 = rawValue_13;
    param_902 = _e451;
    let _e452 = getType_u0028_u1_u003b((&param_902));
    currentType_1 = _e452;
    let _e453 = currentType_1;
    let _e454 = (_e453 == 0u);
    phi_9120_ = _e454;
    if _e454 {
        let _e456 = unnamed_1.rainPhase;
        phi_9120_ = (_e456 >= 1u);
    }
    let _e459 = phi_9120_;
    phi_9130_ = _e459;
    if _e459 {
        let _e461 = pos_20[1u];
        let _e463 = tuning.gridHeight;
        phi_9130_ = (_e461 == (bitcast<i32>(_e463) - 2i));
    }
    let _e468 = phi_9130_;
    if _e468 {
        underCloud = false;
        let _e470 = tuning.cloudCount;
        cloudN = bitcast<i32>(min(_e470, 64u));
        ci = 0i;
        loop {
            let _e473 = ci;
            let _e474 = cloudN;
            if (_e473 < _e474) {
                let _e476 = ci;
                param_903 = _e476;
                let _e477 = cloudFade_u0028_i1_u003b((&param_903));
                if (_e477 <= 0.01f) {
                    continue;
                }
                let _e479 = ci;
                param_904 = _e479;
                let _e480 = cloudCenter_u0028_i1_u003b((&param_904));
                c_10 = _e480;
                let _e481 = ci;
                param_905 = _e481;
                let _e482 = cloudRadii_u0028_i1_u003b((&param_905));
                r_7 = _e482;
                let _e484 = pos_20[0u];
                let _e487 = pos_20[2u];
                let _e490 = c_10;
                let _e494 = r_7[0u];
                let _e496 = r_7[2u];
                d_26 = ((vec2<f32>(f32(_e484), f32(_e487)) - _e490.xz) / vec2<f32>(_e494, _e496));
                let _e499 = d_26;
                let _e500 = d_26;
                if (dot(_e499, _e500) <= 1f) {
                    underCloud = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e503 = ci;
                ci = (_e503 + 1i);
            }
        }
        let _e505 = underCloud;
        if _e505 {
            let _e507 = atomicAdd((&unnamed_1.rainCandidateCount), 1u);
            let _e509 = unnamed_1.rainPhase;
            if (_e509 == 2u) {
                let _e512 = unnamed_1.rainTargetLevel;
                let _e514 = atomicLoad((&unnamed_1.waterVoxelCount));
                if (_e512 > _e514) {
                    let _e517 = unnamed_1.rainTargetLevel;
                    let _e519 = atomicLoad((&unnamed_1.waterVoxelCount));
                    local_36 = (_e517 - _e519);
                } else {
                    local_36 = 0u;
                }
                let _e521 = local_36;
                remaining_1 = _e521;
                let _e523 = unnamed_1.rainCandidateEstimate;
                param_906 = _e523;
                let _e524 = remaining_1;
                param_907 = _e524;
                let _e525 = getRainDropChance_u0028_u1_u003b_u1_u003b((&param_906), (&param_907));
                dropChance = _e525;
                let _e526 = pos_20;
                let _e529 = pc.time;
                param_908 = (vec3<f32>(_e526) + vec3<f32>((_e529 * 1.7f), 51f, 0f));
                let _e533 = hash_u0028_vf3_u003b((&param_908));
                rainRandVal = _e533;
                let _e534 = rainRandVal;
                let _e535 = dropChance;
                if (_e534 < _e535) {
                    let _e537 = currentIndex_15;
                    let _e540 = rawValue_13;
                    param_909 = 2u;
                    param_910 = 0u;
                    param_911 = 0u;
                    param_912 = 0u;
                    let _e541 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_909), (&param_910), (&param_911), (&param_912));
                    let _e542 = atomicCompareExchangeWeak((&unnamed.grid[_e537]), _e540, _e541);
                    let _e544 = rawValue_13;
                    if (_e542.old_value == _e544) {
                        incWater_u0028_();
                        let _e547 = pos_20[1u];
                        let _e550 = atomicLoad((&unnamed_1.maxOccupiedY));
                        if (bitcast<u32>(_e547) > _e550) {
                            let _e554 = pos_20[1u];
                            let _e556 = atomicMax((&unnamed_1.maxOccupiedY), bitcast<u32>(_e554));
                        }
                        return;
                    }
                }
            }
        }
    }
    let _e557 = currentType_1;
    if (_e557 == 0u) {
        return;
    }
    let _e560 = pos_20[1u];
    let _e563 = atomicLoad((&unnamed_1.maxOccupiedY));
    if (bitcast<u32>(_e560) > _e563) {
        let _e567 = pos_20[1u];
        let _e569 = atomicMax((&unnamed_1.maxOccupiedY), bitcast<u32>(_e567));
    }
    let _e570 = pos_20;
    let _e573 = pc.time;
    param_913 = (vec3<f32>(_e570) + vec3(_e573));
    let _e576 = hash_u0028_vf3_u003b((&param_913));
    randVal_14 = _e576;
    let _e577 = currentType_1;
    let _e578 = (_e577 != 7u);
    phi_9308_ = _e578;
    if _e578 {
        let _e579 = pos_20;
        param_914 = _e579;
        let _e580 = currentIndex_15;
        param_915 = _e580;
        let _e581 = rawValue_13;
        param_916 = _e581;
        let _e582 = randVal_14;
        param_917 = _e582;
        let _e583 = captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b((&param_914), (&param_915), (&param_916), (&param_917));
        phi_9308_ = _e583;
    }
    let _e585 = phi_9308_;
    if _e585 {
        return;
    }
    let _e586 = currentType_1;
    let _e588 = currentType_1;
    if ((_e586 == 3u) || (_e588 == 7u)) {
        return;
    }
    let _e591 = rawValue_13;
    param_918 = _e591;
    let _e592 = getDir_u0028_u1_u003b((&param_918));
    currentDir_6 = _e592;
    let _e593 = rawValue_13;
    param_919 = _e593;
    let _e594 = getSleep_u0028_u1_u003b((&param_919));
    currentSleep_7 = _e594;
    let _e595 = rawValue_13;
    param_920 = _e595;
    let _e596 = getAge_u0028_u1_u003b((&param_920));
    currentAge_10 = _e596;
    let _e597 = currentType_1;
    switch bitcast<i32>(_e597) {
        case 1: {
            let _e599 = pos_20;
            param_921 = _e599;
            let _e600 = currentIndex_15;
            param_922 = _e600;
            let _e601 = rawValue_13;
            param_923 = _e601;
            let _e602 = currentSleep_7;
            param_924 = _e602;
            let _e603 = currentAge_10;
            param_925 = _e603;
            let _e604 = randVal_14;
            param_926 = _e604;
            updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_921), (&param_922), (&param_923), (&param_924), (&param_925), (&param_926));
            break;
        }
        case 2: {
            let _e605 = pos_20;
            param_927 = _e605;
            let _e606 = currentIndex_15;
            param_928 = _e606;
            let _e607 = rawValue_13;
            param_929 = _e607;
            let _e608 = currentDir_6;
            param_930 = _e608;
            let _e609 = currentSleep_7;
            param_931 = _e609;
            let _e610 = currentAge_10;
            param_932 = _e610;
            let _e611 = randVal_14;
            param_933 = _e611;
            updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_927), (&param_928), (&param_929), (&param_930), (&param_931), (&param_932), (&param_933));
            break;
        }
        case 4: {
            let _e612 = pos_20;
            param_934 = _e612;
            let _e613 = currentIndex_15;
            param_935 = _e613;
            let _e614 = rawValue_13;
            param_936 = _e614;
            let _e615 = currentDir_6;
            param_937 = _e615;
            let _e616 = currentSleep_7;
            param_938 = _e616;
            let _e617 = currentAge_10;
            param_939 = _e617;
            let _e618 = randVal_14;
            param_940 = _e618;
            updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_934), (&param_935), (&param_936), (&param_937), (&param_938), (&param_939), (&param_940));
            break;
        }
        case 5: {
            let _e619 = pos_20;
            param_941 = _e619;
            let _e620 = currentIndex_15;
            param_942 = _e620;
            let _e621 = rawValue_13;
            param_943 = _e621;
            let _e622 = currentDir_6;
            param_944 = _e622;
            let _e623 = currentSleep_7;
            param_945 = _e623;
            let _e624 = currentAge_10;
            param_946 = _e624;
            let _e625 = randVal_14;
            param_947 = _e625;
            updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_941), (&param_942), (&param_943), (&param_944), (&param_945), (&param_946), (&param_947));
            break;
        }
        case 6: {
            let _e626 = pos_20;
            param_948 = _e626;
            let _e627 = currentIndex_15;
            param_949 = _e627;
            let _e628 = rawValue_13;
            param_950 = _e628;
            let _e629 = currentSleep_7;
            param_951 = _e629;
            let _e630 = currentAge_10;
            param_952 = _e630;
            let _e631 = randVal_14;
            param_953 = _e631;
            updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_948), (&param_949), (&param_950), (&param_951), (&param_952), (&param_953));
            break;
        }
        case 9, 10, 11, 8: {
            let _e632 = pos_20;
            param_954 = _e632;
            let _e633 = currentIndex_15;
            param_955 = _e633;
            let _e634 = rawValue_13;
            param_956 = _e634;
            let _e635 = currentDir_6;
            param_957 = _e635;
            let _e636 = currentSleep_7;
            param_958 = _e636;
            let _e637 = currentAge_10;
            param_959 = _e637;
            let _e638 = randVal_14;
            param_960 = _e638;
            updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_954), (&param_955), (&param_956), (&param_957), (&param_958), (&param_959), (&param_960));
            break;
        }
        case 12: {
            let _e639 = pos_20;
            param_961 = _e639;
            let _e640 = currentIndex_15;
            param_962 = _e640;
            let _e641 = rawValue_13;
            param_963 = _e641;
            let _e642 = currentAge_10;
            param_964 = _e642;
            let _e643 = randVal_14;
            param_965 = _e643;
            updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_961), (&param_962), (&param_963), (&param_964), (&param_965));
            break;
        }
        case 14, 15, 16, 17, 13: {
            let _e644 = pos_20;
            param_966 = _e644;
            let _e645 = currentIndex_15;
            param_967 = _e645;
            let _e646 = rawValue_13;
            param_968 = _e646;
            let _e647 = currentDir_6;
            param_969 = _e647;
            let _e648 = currentSleep_7;
            param_970 = _e648;
            let _e649 = currentAge_10;
            param_971 = _e649;
            let _e650 = randVal_14;
            param_972 = _e650;
            updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_966), (&param_967), (&param_968), (&param_969), (&param_970), (&param_971), (&param_972));
            break;
        }
        case 18: {
            let _e651 = pos_20;
            param_973 = _e651;
            let _e652 = currentIndex_15;
            param_974 = _e652;
            let _e653 = rawValue_13;
            param_975 = _e653;
            let _e654 = currentDir_6;
            param_976 = _e654;
            let _e655 = currentAge_10;
            param_977 = _e655;
            let _e656 = randVal_14;
            param_978 = _e656;
            updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_973), (&param_974), (&param_975), (&param_976), (&param_977), (&param_978));
            break;
        }
        case 19: {
            let _e657 = pos_20;
            param_979 = _e657;
            let _e658 = currentIndex_15;
            param_980 = _e658;
            let _e659 = rawValue_13;
            param_981 = _e659;
            let _e660 = currentAge_10;
            param_982 = _e660;
            let _e661 = randVal_14;
            param_983 = _e661;
            updateLeaf_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_979), (&param_980), (&param_981), (&param_982), (&param_983));
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
