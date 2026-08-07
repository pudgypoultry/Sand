// GENERATED FILE -- DO NOT EDIT.
//
// Translated from falling_sand.comp by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit falling_sand.comp and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 9b0abd8ebeb33e1ec0e04f1b27b0cc24f5252edc968639e55ad642ecc26bd710

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
    let _e205 = (*val);
    return ((_e205 >> bitcast<u32>(24i)) & 255u);
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
    var param: u32;
    var targetType: u32;
    var param_1: u32;
    var currentType: u32;
    var param_2: u32;
    var actual: u32;
    var phi_1818_: bool;
    var phi_1827_: bool;

    let _e215 = (*targetIndex);
    param = _e215;
    let _e216 = readCell_u0028_u1_u003b((&param));
    targetValue = _e216;
    let _e217 = targetValue;
    param_1 = _e217;
    let _e218 = getType_u0028_u1_u003b((&param_1));
    targetType = _e218;
    let _e219 = (*currentValue);
    param_2 = _e219;
    let _e220 = getType_u0028_u1_u003b((&param_2));
    currentType = _e220;
    let _e221 = targetType;
    let _e222 = (_e221 == 0u);
    phi_1818_ = _e222;
    if !(_e222) {
        let _e224 = currentType;
        let _e226 = currentType;
        let _e229 = targetType;
        phi_1818_ = (((_e224 == 1u) || (_e226 == 4u)) && (_e229 == 2u));
    }
    let _e233 = phi_1818_;
    phi_1827_ = _e233;
    if !(_e233) {
        let _e235 = currentType;
        let _e237 = targetType;
        phi_1827_ = ((_e235 == 6u) && (_e237 == 5u));
    }
    let _e241 = phi_1827_;
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

fn pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b(type_35: ptr<function, u32>, dir: ptr<function, u32>, sleep: ptr<function, u32>, age: ptr<function, u32>) -> u32 {
    let _e208 = (*type_35);
    let _e210 = (*dir);
    let _e215 = (*sleep);
    let _e220 = (*age);
    return ((((_e208 & 255u) | ((_e210 & 255u) << bitcast<u32>(8i))) | ((_e215 & 255u) << bitcast<u32>(16i))) | ((_e220 & 255u) << bitcast<u32>(24i)));
}

fn getIndex_u0028_vi3_u003b(pos: ptr<function, vec3<i32>>) -> u32 {
    let _e206 = (*pos)[0u];
    let _e208 = (*pos)[1u];
    let _e210 = tuning.gridWidth;
    let _e215 = (*pos)[2u];
    let _e217 = tuning.gridWidth;
    let _e221 = tuning.gridHeight;
    return bitcast<u32>(((_e206 + (_e208 * bitcast<i32>(_e210))) + ((_e215 * bitcast<i32>(_e217)) * bitcast<i32>(_e221))));
}

fn treeInBounds_u0028_vi3_u003b(p: ptr<function, vec3<i32>>) -> bool {
    var phi_977_: bool;
    var phi_983_: bool;
    var phi_993_: bool;
    var phi_999_: bool;
    var phi_1009_: bool;

    let _e206 = (*p)[0u];
    let _e207 = (_e206 > 0i);
    phi_977_ = _e207;
    if _e207 {
        let _e209 = (*p)[0u];
        let _e211 = tuning.gridWidth;
        phi_977_ = (_e209 < (bitcast<i32>(_e211) - 1i));
    }
    let _e216 = phi_977_;
    phi_983_ = _e216;
    if _e216 {
        let _e218 = (*p)[1u];
        phi_983_ = (_e218 > 0i);
    }
    let _e221 = phi_983_;
    phi_993_ = _e221;
    if _e221 {
        let _e223 = (*p)[1u];
        let _e225 = tuning.gridHeight;
        phi_993_ = (_e223 < (bitcast<i32>(_e225) - 1i));
    }
    let _e230 = phi_993_;
    phi_999_ = _e230;
    if _e230 {
        let _e232 = (*p)[2u];
        phi_999_ = (_e232 > 0i);
    }
    let _e235 = phi_999_;
    phi_1009_ = _e235;
    if _e235 {
        let _e237 = (*p)[2u];
        let _e239 = tuning.gridDepth;
        phi_1009_ = (_e237 < (bitcast<i32>(_e239) - 1i));
    }
    let _e244 = phi_1009_;
    return _e244;
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

    let _e255 = (*randVal);
    let _e259 = tuning.treeLeafTickChance;
    if (fract((_e255 * 7f)) >= _e259) {
        return;
    }
    let _e261 = (*currentAge);
    if (_e261 == 255u) {
        let _e263 = (*pos_1);
        belowPos = (_e263 + vec3<i32>(0i, -1i, 0i));
        let _e265 = belowPos;
        param_3 = _e265;
        let _e266 = treeInBounds_u0028_vi3_u003b((&param_3));
        phi_6941_ = _e266;
        if _e266 {
            let _e267 = belowPos;
            param_4 = _e267;
            let _e268 = getIndex_u0028_vi3_u003b((&param_4));
            param_5 = _e268;
            let _e269 = readCell_u0028_u1_u003b((&param_5));
            phi_6941_ = (_e269 == 0u);
        }
        let _e272 = phi_6941_;
        if _e272 {
            let _e273 = belowPos;
            param_6 = _e273;
            let _e274 = getIndex_u0028_vi3_u003b((&param_6));
            param_7 = 19u;
            param_8 = 0u;
            param_9 = 0u;
            param_10 = 255u;
            let _e275 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_7), (&param_8), (&param_9), (&param_10));
            let _e276 = (*currentIndex_1);
            param_11 = _e276;
            let _e277 = (*rawValue);
            param_12 = _e277;
            param_13 = _e274;
            param_14 = _e275;
            let _e278 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_11), (&param_12), (&param_13), (&param_14));
            if _e278 {
                return;
            }
        }
        let _e279 = (*currentIndex_1);
        let _e282 = (*rawValue);
        let _e283 = atomicCompareExchangeWeak((&unnamed.grid[_e279]), _e282, 0u);
        return;
    }
    let _e285 = (*currentAge);
    dist = _e285;
    nearest = 255u;
    touchesTrunk = false;
    let _e286 = (*randVal);
    start = i32((fract((_e286 * 71f)) * 26f));
    haveSpot = false;
    let _e291 = (*pos_1);
    spot = _e291;
    i_1 = 0i;
    loop {
        let _e292 = i_1;
        if (_e292 < 26i) {
            let _e294 = (*pos_1);
            let _e295 = start;
            let _e296 = i_1;
            let _e297 = (_e295 + _e296);
            param_15 = (_e297 - (i32(floor((f32(_e297) / f32(26i)))) * 26i));
            let _e305 = tree26_u0028_i1_u003b((&param_15));
            c = (_e294 + _e305);
            let _e307 = c;
            param_16 = _e307;
            let _e308 = treeInBounds_u0028_vi3_u003b((&param_16));
            if !(_e308) {
                continue;
            }
            let _e310 = c;
            param_17 = _e310;
            let _e311 = getIndex_u0028_vi3_u003b((&param_17));
            param_18 = _e311;
            let _e312 = readCell_u0028_u1_u003b((&param_18));
            v = _e312;
            let _e313 = v;
            param_19 = _e313;
            let _e314 = getType_u0028_u1_u003b((&param_19));
            t = _e314;
            let _e315 = t;
            let _e316 = (_e315 == 18u);
            phi_7025_ = _e316;
            if _e316 {
                let _e317 = v;
                param_20 = _e317;
                let _e318 = getDir_u0028_u1_u003b((&param_20));
                let _e321 = tuning.treeMaxHeight;
                phi_7025_ = ((_e318 + 1u) >= _e321);
            }
            let _e324 = phi_7025_;
            if _e324 {
                touchesTrunk = true;
            } else {
                let _e325 = t;
                if (_e325 == 19u) {
                    let _e327 = nearest;
                    let _e328 = v;
                    param_21 = _e328;
                    let _e329 = getAge_u0028_u1_u003b((&param_21));
                    nearest = min(_e327, _e329);
                } else {
                    let _e331 = v;
                    let _e333 = haveSpot;
                    if ((_e331 == 0u) && !(_e333)) {
                        haveSpot = true;
                        let _e336 = c;
                        spot = _e336;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e337 = i_1;
            i_1 = (_e337 + 1i);
        }
    }
    let _e339 = touchesTrunk;
    if _e339 {
        local_1 = 1u;
    } else {
        let _e340 = nearest;
        if (_e340 >= 255u) {
            local_2 = 255u;
        } else {
            let _e342 = nearest;
            local_2 = (_e342 + 1u);
        }
        let _e344 = local_2;
        local_1 = _e344;
    }
    let _e345 = local_1;
    supported = _e345;
    let _e346 = supported;
    let _e348 = tuning.treeLeafReach;
    if (_e346 > _e348) {
        let _e350 = (*randVal);
        let _e354 = tuning.treeLeafFallChance;
        if (fract((_e350 * 83f)) < _e354) {
            let _e356 = (*currentIndex_1);
            let _e359 = (*rawValue);
            param_22 = 19u;
            param_23 = 0u;
            param_24 = 0u;
            param_25 = 255u;
            let _e360 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_22), (&param_23), (&param_24), (&param_25));
            let _e361 = atomicCompareExchangeWeak((&unnamed.grid[_e356]), _e359, _e360);
        }
        return;
    }
    let _e363 = supported;
    let _e365 = tuning.treeLeafReach;
    let _e367 = haveSpot;
    let _e368 = ((_e363 < _e365) && _e367);
    phi_7107_ = _e368;
    if _e368 {
        let _e369 = (*randVal);
        let _e373 = tuning.treeLeafSpreadChance;
        phi_7107_ = (fract((_e369 * 89f)) < _e373);
    }
    let _e376 = phi_7107_;
    if _e376 {
        let _e377 = spot;
        param_26 = _e377;
        let _e378 = getIndex_u0028_vi3_u003b((&param_26));
        let _e381 = supported;
        param_27 = 19u;
        param_28 = 0u;
        param_29 = 0u;
        param_30 = (_e381 + 1u);
        let _e383 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_27), (&param_28), (&param_29), (&param_30));
        let _e384 = atomicCompareExchangeWeak((&unnamed.grid[_e378]), 0u, _e383);
    }
    let _e386 = supported;
    let _e387 = dist;
    if (_e386 != _e387) {
        let _e389 = (*currentIndex_1);
        let _e392 = (*rawValue);
        param_31 = 19u;
        param_32 = 0u;
        param_33 = 0u;
        let _e393 = supported;
        param_34 = _e393;
        let _e394 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_31), (&param_32), (&param_33), (&param_34));
        let _e395 = atomicCompareExchangeWeak((&unnamed.grid[_e389]), _e392, _e394);
    }
    return;
}

fn isGrassBlock_u0028_u1_u003b(value: ptr<function, u32>) -> bool {
    var flora: u32;
    var param_35: u32;

    let _e207 = (*value);
    flora = ((_e207 >> bitcast<u32>(8i)) & 255u);
    let _e211 = (*value);
    param_35 = _e211;
    let _e212 = getType_u0028_u1_u003b((&param_35));
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

    let _e290 = (*currentDir);
    height = _e290;
    let _e291 = (*currentAge_1);
    water = _e291;
    changed = false;
    let _e292 = water;
    let _e294 = tuning.treeWaterMax;
    let _e295 = (_e292 < _e294);
    phi_6496_ = _e295;
    if _e295 {
        let _e296 = (*randVal_1);
        let _e300 = tuning.treeDrinkChance;
        phi_6496_ = (fract((_e296 * 13f)) < _e300);
    }
    let _e303 = phi_6496_;
    if _e303 {
        let _e304 = (*randVal_1);
        start_1 = i32((fract((_e304 * 101f)) * 17f));
        k = 0i;
        loop {
            let _e309 = k;
            if (_e309 < 17i) {
                let _e311 = start_1;
                let _e312 = k;
                let _e313 = (_e311 + _e312);
                i_2 = (_e313 - (i32(floor((f32(_e313) / f32(17i)))) * 17i));
                let _e321 = i_2;
                if (_e321 == 0i) {
                    let _e323 = (*pos_2);
                    local_3 = (_e323 + vec3<i32>(0i, -1i, 0i));
                } else {
                    let _e325 = i_2;
                    if (_e325 < 9i) {
                        let _e327 = (*pos_2);
                        let _e328 = i_2;
                        param_36 = (_e328 - 1i);
                        let _e330 = getHDir_u0028_i1_u003b((&param_36));
                        local_4 = ((_e327 + _e330) + vec3<i32>(0i, -1i, 0i));
                    } else {
                        let _e333 = (*pos_2);
                        let _e334 = i_2;
                        param_37 = (_e334 - 9i);
                        let _e336 = getHDir_u0028_i1_u003b((&param_37));
                        local_4 = (_e333 + _e336);
                    }
                    let _e338 = local_4;
                    local_3 = _e338;
                }
                let _e339 = local_3;
                c_1 = _e339;
                let _e340 = c_1;
                param_38 = _e340;
                let _e341 = treeInBounds_u0028_vi3_u003b((&param_38));
                if !(_e341) {
                    continue;
                }
                let _e343 = c_1;
                param_39 = _e343;
                let _e344 = getIndex_u0028_vi3_u003b((&param_39));
                idx = _e344;
                let _e345 = idx;
                param_40 = _e345;
                let _e346 = readCell_u0028_u1_u003b((&param_40));
                v_1 = _e346;
                let _e347 = v_1;
                param_41 = _e347;
                let _e348 = getType_u0028_u1_u003b((&param_41));
                if (_e348 != 4u) {
                    continue;
                }
                let _e350 = v_1;
                param_42 = _e350;
                let _e351 = getAge_u0028_u1_u003b((&param_42));
                moisture = _e351;
                let _e352 = moisture;
                let _e354 = tuning.treeSoilReserve;
                if (_e352 <= _e354) {
                    continue;
                }
                let _e356 = idx;
                let _e359 = v_1;
                let _e360 = v_1;
                param_43 = _e360;
                let _e361 = getDir_u0028_u1_u003b((&param_43));
                let _e362 = v_1;
                param_44 = _e362;
                let _e363 = getSleep_u0028_u1_u003b((&param_44));
                let _e364 = moisture;
                param_45 = 4u;
                param_46 = _e361;
                param_47 = _e363;
                param_48 = (_e364 - 1u);
                let _e366 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_45), (&param_46), (&param_47), (&param_48));
                let _e367 = atomicCompareExchangeWeak((&unnamed.grid[_e356]), _e359, _e366);
                let _e369 = v_1;
                if (_e367.old_value == _e369) {
                    let _e371 = water;
                    water = (_e371 + 1u);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e373 = k;
                k = (_e373 + 1i);
            }
        }
    }
    let _e375 = (*pos_2);
    upPos = (_e375 + vec3<i32>(0i, 1i, 0i));
    upIsTrunk = false;
    upValue = 0u;
    upIndex = 0u;
    let _e377 = upPos;
    param_49 = _e377;
    let _e378 = treeInBounds_u0028_vi3_u003b((&param_49));
    if _e378 {
        let _e379 = upPos;
        param_50 = _e379;
        let _e380 = getIndex_u0028_vi3_u003b((&param_50));
        upIndex = _e380;
        let _e381 = upIndex;
        param_51 = _e381;
        let _e382 = readCell_u0028_u1_u003b((&param_51));
        upValue = _e382;
        let _e383 = upValue;
        param_52 = _e383;
        let _e384 = getType_u0028_u1_u003b((&param_52));
        upIsTrunk = (_e384 == 18u);
    }
    let _e386 = upIsTrunk;
    let _e387 = water;
    let _e389 = (_e386 && (_e387 > 0u));
    phi_6640_ = _e389;
    if _e389 {
        let _e390 = upValue;
        param_53 = _e390;
        let _e391 = getAge_u0028_u1_u003b((&param_53));
        phi_6640_ = (_e391 < 255u);
    }
    let _e394 = phi_6640_;
    phi_6650_ = _e394;
    if _e394 {
        let _e395 = (*randVal_1);
        let _e399 = tuning.treeFlowChance;
        phi_6650_ = (fract((_e395 * 29f)) < _e399);
    }
    let _e402 = phi_6650_;
    if _e402 {
        let _e403 = upValue;
        param_54 = _e403;
        let _e404 = getDir_u0028_u1_u003b((&param_54));
        let _e405 = upValue;
        param_55 = _e405;
        let _e406 = getAge_u0028_u1_u003b((&param_55));
        param_56 = 18u;
        param_57 = _e404;
        param_58 = 0u;
        param_59 = (_e406 + 1u);
        let _e408 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_56), (&param_57), (&param_58), (&param_59));
        lifted = _e408;
        let _e409 = upIndex;
        let _e412 = upValue;
        let _e413 = lifted;
        let _e414 = atomicCompareExchangeWeak((&unnamed.grid[_e409]), _e412, _e413);
        let _e416 = upValue;
        if (_e414.old_value == _e416) {
            let _e418 = water;
            water = (_e418 - 1u);
            changed = true;
        }
    }
    let _e420 = height;
    let _e423 = tuning.treeMaxHeight;
    if ((_e420 + 1u) < _e423) {
        let _e425 = water;
        let _e427 = tuning.treeGrowCost;
        let _e428 = (_e425 >= _e427);
        phi_6695_ = _e428;
        if _e428 {
            let _e429 = upPos;
            param_60 = _e429;
            let _e430 = treeInBounds_u0028_vi3_u003b((&param_60));
            phi_6695_ = _e430;
        }
        let _e432 = phi_6695_;
        if _e432 {
            let _e433 = upValue;
            param_61 = _e433;
            let _e434 = getType_u0028_u1_u003b((&param_61));
            upType = _e434;
            let _e435 = upType;
            let _e437 = upType;
            if ((_e435 == 0u) || (_e437 == 19u)) {
                let _e440 = height;
                param_62 = 18u;
                param_63 = (_e440 + 1u);
                param_64 = 0u;
                param_65 = 0u;
                let _e442 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_62), (&param_63), (&param_64), (&param_65));
                sapling = _e442;
                let _e443 = upIndex;
                let _e446 = upValue;
                let _e447 = sapling;
                let _e448 = atomicCompareExchangeWeak((&unnamed.grid[_e443]), _e446, _e447);
                let _e450 = upValue;
                if (_e448.old_value == _e450) {
                    let _e453 = tuning.treeGrowCost;
                    let _e454 = water;
                    water = (_e454 - _e453);
                    changed = true;
                }
            }
        }
    } else {
        let _e456 = water;
        let _e458 = tuning.treeLeafCost;
        let _e459 = (_e456 >= _e458);
        phi_6746_ = _e459;
        if _e459 {
            let _e460 = (*randVal_1);
            let _e464 = tuning.treeLeafChance;
            phi_6746_ = (fract((_e460 * 37f)) < _e464);
        }
        let _e467 = phi_6746_;
        if _e467 {
            let _e468 = (*randVal_1);
            start_2 = i32((fract((_e468 * 43f)) * 26f));
            i_3 = 0i;
            loop {
                let _e473 = i_3;
                if (_e473 < 26i) {
                    let _e475 = (*pos_2);
                    let _e476 = start_2;
                    let _e477 = i_3;
                    let _e478 = (_e476 + _e477);
                    param_66 = (_e478 - (i32(floor((f32(_e478) / f32(26i)))) * 26i));
                    let _e486 = tree26_u0028_i1_u003b((&param_66));
                    c_2 = (_e475 + _e486);
                    let _e488 = c_2;
                    param_67 = _e488;
                    let _e489 = treeInBounds_u0028_vi3_u003b((&param_67));
                    if !(_e489) {
                        continue;
                    }
                    let _e491 = c_2;
                    param_68 = _e491;
                    let _e492 = getIndex_u0028_vi3_u003b((&param_68));
                    idx_1 = _e492;
                    let _e493 = idx_1;
                    param_69 = _e493;
                    let _e494 = readCell_u0028_u1_u003b((&param_69));
                    if (_e494 != 0u) {
                        continue;
                    }
                    let _e496 = idx_1;
                    param_70 = 19u;
                    param_71 = 0u;
                    param_72 = 0u;
                    param_73 = 1u;
                    let _e499 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_70), (&param_71), (&param_72), (&param_73));
                    let _e500 = atomicCompareExchangeWeak((&unnamed.grid[_e496]), 0u, _e499);
                    if (_e500.old_value == 0u) {
                        let _e504 = tuning.treeLeafCost;
                        let _e505 = water;
                        water = (_e505 - _e504);
                        changed = true;
                        break;
                    }
                    continue;
                } else {
                    break;
                }
                continuing {
                    let _e507 = i_3;
                    i_3 = (_e507 + 1i);
                }
            }
        }
    }
    let _e509 = water;
    let _e511 = tuning.treeSpreadCost;
    let _e512 = (_e509 >= _e511);
    phi_6825_ = _e512;
    if _e512 {
        let _e513 = (*randVal_1);
        let _e517 = tuning.treeSpreadChance;
        phi_6825_ = (fract((_e513 * 59f)) < _e517);
    }
    let _e520 = phi_6825_;
    if _e520 {
        let _e521 = (*randVal_1);
        start_3 = i32((fract((_e521 * 61f)) * 8f));
        i_4 = 0i;
        loop {
            let _e526 = i_4;
            if (_e526 < 8i) {
                let _e528 = (*pos_2);
                let _e529 = start_3;
                let _e530 = i_4;
                let _e531 = (_e529 + _e530);
                param_74 = (_e531 - (i32(floor((f32(_e531) / f32(8i)))) * 8i));
                let _e539 = getHDir_u0028_i1_u003b((&param_74));
                c_3 = (_e528 + _e539);
                let _e541 = c_3;
                param_75 = _e541;
                let _e542 = treeInBounds_u0028_vi3_u003b((&param_75));
                if !(_e542) {
                    continue;
                }
                let _e544 = c_3;
                param_76 = _e544;
                let _e545 = getIndex_u0028_vi3_u003b((&param_76));
                idx_2 = _e545;
                let _e546 = idx_2;
                param_77 = _e546;
                let _e547 = readCell_u0028_u1_u003b((&param_77));
                if (_e547 != 0u) {
                    continue;
                }
                let _e549 = c_3;
                param_78 = (_e549 + vec3<i32>(0i, -1i, 0i));
                let _e551 = getIndex_u0028_vi3_u003b((&param_78));
                param_79 = _e551;
                let _e552 = readCell_u0028_u1_u003b((&param_79));
                param_80 = _e552;
                let _e553 = isGrassBlock_u0028_u1_u003b((&param_80));
                if !(_e553) {
                    continue;
                }
                let _e555 = idx_2;
                param_81 = 18u;
                param_82 = 0u;
                param_83 = 0u;
                param_84 = 0u;
                let _e558 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_81), (&param_82), (&param_83), (&param_84));
                let _e559 = atomicCompareExchangeWeak((&unnamed.grid[_e555]), 0u, _e558);
                if (_e559.old_value == 0u) {
                    let _e563 = tuning.treeSpreadCost;
                    let _e564 = water;
                    water = (_e564 - _e563);
                    changed = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e566 = i_4;
                i_4 = (_e566 + 1i);
            }
        }
    }
    let _e568 = changed;
    if _e568 {
        let _e569 = (*currentIndex_2);
        let _e572 = (*rawValue_1);
        param_85 = 18u;
        let _e573 = height;
        param_86 = _e573;
        param_87 = 0u;
        let _e574 = water;
        param_88 = _e574;
        let _e575 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_85), (&param_86), (&param_87), (&param_88));
        let _e576 = atomicCompareExchangeWeak((&unnamed.grid[_e569]), _e572, _e575);
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
    var param_89: u32;
    var param_90: u32;
    var phi_768_: bool;

    let _e207 = (*value_1);
    param_89 = _e207;
    let _e208 = isGrassBlock_u0028_u1_u003b((&param_89));
    phi_768_ = _e208;
    if !(_e208) {
        let _e210 = (*value_1);
        param_90 = _e210;
        let _e211 = getType_u0028_u1_u003b((&param_90));
        phi_768_ = (_e211 == 19u);
    }
    let _e214 = phi_768_;
    return _e214;
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

    let _e209 = (*p_1)[0u];
    let _e210 = (_e209 < 0i);
    phi_783_ = _e210;
    if !(_e210) {
        let _e213 = (*p_1)[0u];
        let _e215 = tuning.gridWidth;
        phi_783_ = (_e213 >= bitcast<i32>(_e215));
    }
    let _e219 = phi_783_;
    phi_790_ = _e219;
    if !(_e219) {
        let _e222 = (*p_1)[1u];
        phi_790_ = (_e222 < 0i);
    }
    let _e225 = phi_790_;
    phi_800_ = _e225;
    if !(_e225) {
        let _e228 = (*p_1)[1u];
        let _e230 = tuning.gridHeight;
        phi_800_ = (_e228 >= bitcast<i32>(_e230));
    }
    let _e234 = phi_800_;
    phi_807_ = _e234;
    if !(_e234) {
        let _e237 = (*p_1)[2u];
        phi_807_ = (_e237 < 0i);
    }
    let _e240 = phi_807_;
    phi_817_ = _e240;
    if !(_e240) {
        let _e243 = (*p_1)[2u];
        let _e245 = tuning.gridDepth;
        phi_817_ = (_e243 >= bitcast<i32>(_e245));
    }
    let _e249 = phi_817_;
    if _e249 {
        return false;
    }
    let _e250 = (*p_1);
    param_91 = _e250;
    let _e251 = getIndex_u0028_vi3_u003b((&param_91));
    param_92 = _e251;
    let _e252 = readCell_u0028_u1_u003b((&param_92));
    param_93 = _e252;
    let _e253 = isLocustFood_u0028_u1_u003b((&param_93));
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
    var param_94: vec3<i32>;

    let _e207 = (*dest);
    param_94 = (_e207 + vec3<i32>(0i, -1i, 0i));
    let _e209 = locustFoodAt_u0028_vi3_u003b((&param_94));
    let _e210 = (*nav);
    return select(_e210, 0u, _e209);
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
        let _e210 = d_2;
        if (_e210 < 8i) {
            let _e212 = (*pos_3);
            let _e213 = d_2;
            param_95 = _e213;
            let _e214 = getHDir_u0028_i1_u003b((&param_95));
            n = (_e212 + _e214);
            let _e217 = n[0u];
            let _e218 = (_e217 <= 0i);
            phi_921_ = _e218;
            if !(_e218) {
                let _e221 = n[0u];
                let _e223 = tuning.gridWidth;
                phi_921_ = (_e221 >= (bitcast<i32>(_e223) - 1i));
            }
            let _e228 = phi_921_;
            phi_928_ = _e228;
            if !(_e228) {
                let _e231 = n[2u];
                phi_928_ = (_e231 <= 0i);
            }
            let _e234 = phi_928_;
            phi_939_ = _e234;
            if !(_e234) {
                let _e237 = n[2u];
                let _e239 = tuning.gridDepth;
                phi_939_ = (_e237 >= (bitcast<i32>(_e239) - 1i));
            }
            let _e244 = phi_939_;
            if _e244 {
                continue;
            }
            let _e245 = n;
            param_96 = _e245;
            let _e246 = getIndex_u0028_vi3_u003b((&param_96));
            param_97 = _e246;
            let _e247 = readCell_u0028_u1_u003b((&param_97));
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

fn locustInBounds_u0028_vi3_u003b(p_2: ptr<function, vec3<i32>>) -> bool {
    var phi_704_: bool;
    var phi_710_: bool;
    var phi_720_: bool;
    var phi_726_: bool;
    var phi_736_: bool;

    let _e206 = (*p_2)[0u];
    let _e207 = (_e206 > 0i);
    phi_704_ = _e207;
    if _e207 {
        let _e209 = (*p_2)[0u];
        let _e211 = tuning.gridWidth;
        phi_704_ = (_e209 < (bitcast<i32>(_e211) - 1i));
    }
    let _e216 = phi_704_;
    phi_710_ = _e216;
    if _e216 {
        let _e218 = (*p_2)[1u];
        phi_710_ = (_e218 > 0i);
    }
    let _e221 = phi_710_;
    phi_720_ = _e221;
    if _e221 {
        let _e223 = (*p_2)[1u];
        let _e225 = tuning.gridHeight;
        phi_720_ = (_e223 < (bitcast<i32>(_e225) - 1i));
    }
    let _e230 = phi_720_;
    phi_726_ = _e230;
    if _e230 {
        let _e232 = (*p_2)[2u];
        phi_726_ = (_e232 > 0i);
    }
    let _e235 = phi_726_;
    phi_736_ = _e235;
    if _e235 {
        let _e237 = (*p_2)[2u];
        let _e239 = tuning.gridDepth;
        phi_736_ = (_e237 < (bitcast<i32>(_e239) - 1i));
    }
    let _e244 = phi_736_;
    return _e244;
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

fn locustMaxCount_u0028_() -> u32 {
    let _e205 = tuning.locustMaxSize;
    return max(_e205, 1u);
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
            let _e242 = (*pos_4);
            let _e243 = d_3;
            param_98 = _e243;
            let _e244 = getHDir_u0028_i1_u003b((&param_98));
            c_4 = (_e242 + _e244);
            let _e246 = c_4;
            param_99 = _e246;
            let _e247 = locustInBounds_u0028_vi3_u003b((&param_99));
            if !(_e247) {
                continue;
            }
            let _e249 = c_4;
            param_100 = _e249;
            let _e250 = getIndex_u0028_vi3_u003b((&param_100));
            idx_3 = _e250;
            let _e251 = idx_3;
            param_101 = _e251;
            let _e252 = readCell_u0028_u1_u003b((&param_101));
            if (_e252 != 0u) {
                continue;
            }
            let _e254 = idx_3;
            let _e257 = bud;
            param_102 = _e257;
            let _e258 = locustTypeFor_u0028_u1_u003b((&param_102));
            param_103 = _e258;
            param_104 = 0u;
            param_105 = 0u;
            let _e259 = bud;
            param_106 = _e259;
            let _e260 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_103), (&param_104), (&param_105), (&param_106));
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
    var t_1: f32;

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
    t_1 = (f32((_e230 - _e231)) / f32((_e234 - _e235)));
    let _e239 = slow;
    let _e241 = fast;
    let _e243 = t_1;
    return u32(round(mix(f32(_e239), f32(_e241), _e243)));
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

    let _e388 = (*rawValue_2);
    param_107 = _e388;
    let _e389 = getType_u0028_u1_u003b((&param_107));
    type_36 = _e389;
    let _e390 = (*currentSleep);
    phase = (_e390 + 1u);
    let _e392 = phase;
    let _e394 = tuning.locustTickDispatches;
    if (_e392 < _e394) {
        let _e396 = (*currentIndex_3);
        let _e399 = (*rawValue_2);
        let _e400 = type_36;
        param_108 = _e400;
        let _e401 = (*currentDir_1);
        param_109 = _e401;
        let _e402 = phase;
        param_110 = _e402;
        let _e403 = (*currentAge_2);
        param_111 = _e403;
        let _e404 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_108), (&param_109), (&param_110), (&param_111));
        let _e405 = atomicCompareExchangeWeak((&unnamed.grid[_e396]), _e399, _e404);
        return;
    }
    let _e407 = (*currentAge_2);
    count_2 = _e407;
    let _e408 = (*pos_5);
    belowPos_1 = (_e408 + vec3<i32>(0i, -1i, 0i));
    let _e410 = belowPos_1;
    param_112 = _e410;
    let _e411 = getIndex_u0028_vi3_u003b((&param_112));
    belowIndex = _e411;
    let _e412 = belowIndex;
    param_113 = _e412;
    let _e413 = readCell_u0028_u1_u003b((&param_113));
    belowValue = _e413;
    let _e414 = belowValue;
    param_114 = _e414;
    let _e415 = isLocustFood_u0028_u1_u003b((&param_114));
    if _e415 {
        let _e416 = belowValue;
        param_115 = _e416;
        let _e417 = getType_u0028_u1_u003b((&param_115));
        onLeaf = (_e417 == 19u);
        let _e419 = count_2;
        param_116 = _e419;
        let _e420 = locustEatTicks_u0028_u1_u003b((&param_116));
        need = _e420;
        let _e421 = (*currentDir_1);
        progress = (_e421 + 1u);
        let _e423 = progress;
        let _e424 = need;
        if (_e423 < _e424) {
            let _e426 = onLeaf;
            if !(_e426) {
                let _e428 = belowValue;
                flora_1 = ((_e428 >> bitcast<u32>(8i)) & 255u);
                let _e432 = need;
                bite = max((90u / max(_e432, 1u)), 1u);
                let _e436 = flora_1;
                let _e437 = bite;
                if (_e436 > (11u + _e437)) {
                    let _e440 = flora_1;
                    let _e441 = bite;
                    local_6 = (_e440 - _e441);
                } else {
                    local_6 = 11u;
                }
                let _e443 = local_6;
                thinned = _e443;
                let _e444 = belowIndex;
                let _e447 = belowValue;
                let _e448 = belowValue;
                param_117 = _e448;
                let _e449 = getSleep_u0028_u1_u003b((&param_117));
                let _e450 = belowValue;
                param_118 = _e450;
                let _e451 = getAge_u0028_u1_u003b((&param_118));
                param_119 = 4u;
                let _e452 = thinned;
                param_120 = _e452;
                param_121 = _e449;
                param_122 = _e451;
                let _e453 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_119), (&param_120), (&param_121), (&param_122));
                let _e454 = atomicCompareExchangeWeak((&unnamed.grid[_e444]), _e447, _e453);
            }
            let _e456 = (*currentIndex_3);
            let _e459 = (*rawValue_2);
            let _e460 = type_36;
            param_123 = _e460;
            let _e461 = progress;
            param_124 = _e461;
            param_125 = 0u;
            let _e462 = count_2;
            param_126 = _e462;
            let _e463 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_123), (&param_124), (&param_125), (&param_126));
            let _e464 = atomicCompareExchangeWeak((&unnamed.grid[_e456]), _e459, _e463);
            return;
        }
        let _e466 = onLeaf;
        if _e466 {
            local_7 = 0u;
        } else {
            let _e467 = belowValue;
            param_127 = _e467;
            let _e468 = getSleep_u0028_u1_u003b((&param_127));
            let _e469 = belowValue;
            param_128 = _e469;
            let _e470 = getAge_u0028_u1_u003b((&param_128));
            param_129 = 4u;
            param_130 = 0u;
            param_131 = _e468;
            param_132 = _e470;
            let _e471 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_129), (&param_130), (&param_131), (&param_132));
            local_7 = _e471;
        }
        let _e472 = local_7;
        stripped = _e472;
        let _e473 = belowIndex;
        let _e476 = belowValue;
        let _e477 = stripped;
        let _e478 = atomicCompareExchangeWeak((&unnamed.grid[_e473]), _e476, _e477);
        let _e480 = belowValue;
        if (_e478.old_value != _e480) {
            return;
        }
        let _e482 = count_2;
        let _e484 = tuning.locustEatGain;
        grown = (_e482 + _e484);
        let _e486 = grown;
        let _e487 = locustMaxCount_u0028_();
        if (_e486 > _e487) {
            let _e489 = (*pos_5);
            param_133 = _e489;
            let _e490 = (*randVal_3);
            param_134 = _e490;
            locustBud_u0028_vi3_u003b_f1_u003b((&param_133), (&param_134));
            let _e491 = locustMaxCount_u0028_();
            grown = _e491;
        }
        let _e492 = (*currentIndex_3);
        let _e495 = (*rawValue_2);
        let _e496 = grown;
        param_135 = _e496;
        let _e497 = locustTypeFor_u0028_u1_u003b((&param_135));
        param_136 = _e497;
        param_137 = 0u;
        param_138 = 0u;
        let _e498 = grown;
        param_139 = _e498;
        let _e499 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_136), (&param_137), (&param_138), (&param_139));
        let _e500 = atomicCompareExchangeWeak((&unnamed.grid[_e492]), _e495, _e499);
        return;
    }
    let _e502 = count_2;
    if (_e502 <= 1u) {
        let _e504 = (*currentIndex_3);
        let _e507 = (*rawValue_2);
        let _e508 = atomicCompareExchangeWeak((&unnamed.grid[_e504]), _e507, 0u);
        return;
    }
    let _e510 = count_2;
    count_2 = (_e510 - 1u);
    let _e512 = count_2;
    param_140 = _e512;
    let _e513 = locustTypeFor_u0028_u1_u003b((&param_140));
    newType = _e513;
    let _e514 = belowValue;
    param_141 = _e514;
    let _e515 = getType_u0028_u1_u003b((&param_141));
    let _e516 = (_e515 == 0u);
    phi_7406_ = _e516;
    if _e516 {
        let _e517 = belowPos_1;
        param_142 = _e517;
        let _e518 = locustInBounds_u0028_vi3_u003b((&param_142));
        phi_7406_ = _e518;
    }
    let _e520 = phi_7406_;
    phi_7413_ = _e520;
    if _e520 {
        let _e521 = (*pos_5);
        param_143 = _e521;
        let _e522 = locustHasGrip_u0028_vi3_u003b((&param_143));
        phi_7413_ = !(_e522);
    }
    let _e525 = phi_7413_;
    if _e525 {
        let _e526 = belowPos_1;
        param_144 = _e526;
        let _e527 = (*currentDir_1);
        param_145 = _e527;
        let _e528 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_144), (&param_145));
        let _e529 = newType;
        param_146 = _e529;
        param_147 = _e528;
        param_148 = 0u;
        let _e530 = count_2;
        param_149 = _e530;
        let _e531 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_146), (&param_147), (&param_148), (&param_149));
        let _e532 = (*currentIndex_3);
        param_150 = _e532;
        let _e533 = (*rawValue_2);
        param_151 = _e533;
        let _e534 = belowIndex;
        param_152 = _e534;
        param_153 = _e531;
        let _e535 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_150), (&param_151), (&param_152), (&param_153));
        if _e535 {
            return;
        }
    }
    let _e536 = (*currentDir_1);
    param_154 = _e536;
    let _e537 = locustHeading_u0028_u1_u003b((&param_154));
    heading_1 = _e537;
    let _e538 = (*currentDir_1);
    param_155 = _e538;
    let _e539 = locustSteps_u0028_u1_u003b((&param_155));
    steps_1 = _e539;
    let _e540 = steps_1;
    if (_e540 == 0u) {
        let _e542 = (*randVal_3);
        start_5 = i32((fract((_e542 * 17f)) * 8f));
        i_6 = 0i;
        loop {
            let _e547 = i_6;
            if (_e547 < 8i) {
                let _e549 = start_5;
                let _e550 = i_6;
                let _e551 = (_e549 + _e550);
                d_4 = (_e551 - (i32(floor((f32(_e551) / f32(8i)))) * 8i));
                let _e559 = (*pos_5);
                let _e560 = d_4;
                param_156 = _e560;
                let _e561 = getHDir_u0028_i1_u003b((&param_156));
                c_5 = (_e559 + _e561);
                rise = 0i;
                loop {
                    let _e563 = rise;
                    if (_e563 < 3i) {
                        let _e565 = c_5;
                        let _e566 = rise;
                        if (_e566 == 1i) {
                            local_8 = 1i;
                        } else {
                            let _e568 = rise;
                            local_8 = select(0i, -1i, (_e568 == 2i));
                        }
                        let _e571 = local_8;
                        t_2 = (_e565 + vec3<i32>(0i, _e571, 0i));
                        let _e574 = t_2;
                        param_157 = _e574;
                        let _e575 = locustInBounds_u0028_vi3_u003b((&param_157));
                        if !(_e575) {
                            continue;
                        }
                        let _e577 = t_2;
                        param_158 = _e577;
                        let _e578 = getIndex_u0028_vi3_u003b((&param_158));
                        param_159 = _e578;
                        let _e579 = readCell_u0028_u1_u003b((&param_159));
                        if (_e579 != 0u) {
                            continue;
                        }
                        let _e581 = t_2;
                        param_160 = (_e581 + vec3<i32>(0i, -1i, 0i));
                        let _e583 = locustFoodAt_u0028_vi3_u003b((&param_160));
                        if !(_e583) {
                            continue;
                        }
                        let _e585 = t_2;
                        param_161 = _e585;
                        let _e586 = getIndex_u0028_vi3_u003b((&param_161));
                        let _e587 = newType;
                        param_162 = _e587;
                        param_163 = 0u;
                        param_164 = 0u;
                        let _e588 = count_2;
                        param_165 = _e588;
                        let _e589 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_162), (&param_163), (&param_164), (&param_165));
                        let _e590 = (*currentIndex_3);
                        param_166 = _e590;
                        let _e591 = (*rawValue_2);
                        param_167 = _e591;
                        param_168 = _e586;
                        param_169 = _e589;
                        let _e592 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_166), (&param_167), (&param_168), (&param_169));
                        if _e592 {
                            return;
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e593 = rise;
                        rise = (_e593 + 1i);
                    }
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e595 = i_6;
                i_6 = (_e595 + 1i);
            }
        }
        let _e597 = (*randVal_3);
        heading_1 = (u32((fract((_e597 * 23f)) * 8f)) & 7u);
        let _e603 = locustRunSteps_u0028_();
        steps_1 = _e603;
    }
    let _e604 = (*pos_5);
    let _e605 = heading_1;
    param_170 = bitcast<i32>(_e605);
    let _e607 = getHDir_u0028_i1_u003b((&param_170));
    target_ = (_e604 + _e607);
    let _e609 = target_;
    param_171 = _e609;
    let _e610 = locustInBounds_u0028_vi3_u003b((&param_171));
    let _e611 = !(_e610);
    phi_7574_ = _e611;
    if !(_e611) {
        let _e613 = target_;
        param_172 = _e613;
        let _e614 = getIndex_u0028_vi3_u003b((&param_172));
        param_173 = _e614;
        let _e615 = readCell_u0028_u1_u003b((&param_173));
        phi_7574_ = (_e615 != 0u);
    }
    let _e618 = phi_7574_;
    blocked = _e618;
    let _e619 = blocked;
    if !(_e619) {
        let _e621 = target_;
        footing = (_e621 + vec3<i32>(0i, -1i, 0i));
        let _e623 = footing;
        param_174 = _e623;
        let _e624 = locustInBounds_u0028_vi3_u003b((&param_174));
        phi_7593_ = _e624;
        if _e624 {
            let _e625 = footing;
            param_175 = _e625;
            let _e626 = getIndex_u0028_vi3_u003b((&param_175));
            param_176 = _e626;
            let _e627 = readCell_u0028_u1_u003b((&param_176));
            phi_7593_ = (_e627 == 0u);
        }
        let _e630 = phi_7593_;
        if _e630 {
            let _e631 = heading_1;
            param_177 = _e631;
            let _e632 = locustReverse_u0028_u1_u003b((&param_177));
            back = _e632;
            let _e633 = (*pos_5);
            let _e634 = back;
            param_178 = bitcast<i32>(_e634);
            let _e636 = getHDir_u0028_i1_u003b((&param_178));
            backPos = (_e633 + _e636);
            let _e638 = backPos;
            backFoot = (_e638 + vec3<i32>(0i, -1i, 0i));
            let _e640 = backPos;
            param_179 = _e640;
            let _e641 = locustInBounds_u0028_vi3_u003b((&param_179));
            phi_7622_ = _e641;
            if _e641 {
                let _e642 = backPos;
                param_180 = _e642;
                let _e643 = getIndex_u0028_vi3_u003b((&param_180));
                param_181 = _e643;
                let _e644 = readCell_u0028_u1_u003b((&param_181));
                phi_7622_ = (_e644 == 0u);
            }
            let _e647 = phi_7622_;
            phi_7638_ = _e647;
            if _e647 {
                let _e648 = backFoot;
                param_182 = _e648;
                let _e649 = locustInBounds_u0028_vi3_u003b((&param_182));
                phi_7636_ = _e649;
                if _e649 {
                    let _e650 = backFoot;
                    param_183 = _e650;
                    let _e651 = getIndex_u0028_vi3_u003b((&param_183));
                    param_184 = _e651;
                    let _e652 = readCell_u0028_u1_u003b((&param_184));
                    phi_7636_ = (_e652 == 0u);
                }
                let _e655 = phi_7636_;
                phi_7638_ = !(_e655);
            }
            let _e658 = phi_7638_;
            backOpen = _e658;
            let _e659 = backOpen;
            if _e659 {
                let _e660 = back;
                param_185 = _e660;
                let _e661 = steps_1;
                param_186 = _e661;
                let _e662 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_185), (&param_186));
                local_9 = _e662;
            } else {
                let _e663 = (*randVal_3);
                let _e669 = locustRunSteps_u0028_();
                param_187 = (u32((fract((_e663 * 71f)) * 8f)) & 7u);
                param_188 = _e669;
                let _e670 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_187), (&param_188));
                local_9 = _e670;
            }
            let _e671 = local_9;
            turnedNav = _e671;
            let _e672 = (*currentIndex_3);
            let _e675 = (*rawValue_2);
            let _e676 = newType;
            param_189 = _e676;
            let _e677 = turnedNav;
            param_190 = _e677;
            param_191 = 0u;
            let _e678 = count_2;
            param_192 = _e678;
            let _e679 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_189), (&param_190), (&param_191), (&param_192));
            let _e680 = atomicCompareExchangeWeak((&unnamed.grid[_e672]), _e675, _e679);
            return;
        }
        let _e682 = steps_1;
        let _e684 = heading_1;
        param_193 = _e684;
        param_194 = (_e682 - 1u);
        let _e685 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_193), (&param_194));
        nav_1 = _e685;
        let _e686 = target_;
        param_195 = _e686;
        let _e687 = getIndex_u0028_vi3_u003b((&param_195));
        let _e688 = target_;
        param_196 = _e688;
        let _e689 = nav_1;
        param_197 = _e689;
        let _e690 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_196), (&param_197));
        let _e691 = newType;
        param_198 = _e691;
        param_199 = _e690;
        param_200 = 0u;
        let _e692 = count_2;
        param_201 = _e692;
        let _e693 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_198), (&param_199), (&param_200), (&param_201));
        let _e694 = (*currentIndex_3);
        param_202 = _e694;
        let _e695 = (*rawValue_2);
        param_203 = _e695;
        param_204 = _e687;
        param_205 = _e693;
        let _e696 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_202), (&param_203), (&param_204), (&param_205));
        if _e696 {
            return;
        }
    } else {
        let _e697 = (*randVal_3);
        let _e701 = tuning.locustClimbChance;
        if (fract((_e697 * 41f)) < _e701) {
            let _e703 = target_;
            overTop = (_e703 + vec3<i32>(0i, 1i, 0i));
            let _e705 = overTop;
            param_206 = _e705;
            let _e706 = locustInBounds_u0028_vi3_u003b((&param_206));
            phi_7730_ = _e706;
            if _e706 {
                let _e707 = overTop;
                param_207 = _e707;
                let _e708 = getIndex_u0028_vi3_u003b((&param_207));
                param_208 = _e708;
                let _e709 = readCell_u0028_u1_u003b((&param_208));
                phi_7730_ = (_e709 == 0u);
            }
            let _e712 = phi_7730_;
            if _e712 {
                let _e713 = steps_1;
                let _e715 = heading_1;
                param_209 = _e715;
                param_210 = (_e713 - 1u);
                let _e716 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_209), (&param_210));
                nav_2 = _e716;
                let _e717 = overTop;
                param_211 = _e717;
                let _e718 = getIndex_u0028_vi3_u003b((&param_211));
                let _e719 = overTop;
                param_212 = _e719;
                let _e720 = nav_2;
                param_213 = _e720;
                let _e721 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_212), (&param_213));
                let _e722 = newType;
                param_214 = _e722;
                param_215 = _e721;
                param_216 = 0u;
                let _e723 = count_2;
                param_217 = _e723;
                let _e724 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_214), (&param_215), (&param_216), (&param_217));
                let _e725 = (*currentIndex_3);
                param_218 = _e725;
                let _e726 = (*rawValue_2);
                param_219 = _e726;
                param_220 = _e718;
                param_221 = _e724;
                let _e727 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_218), (&param_219), (&param_220), (&param_221));
                if _e727 {
                    return;
                }
            }
            let _e728 = (*pos_5);
            up = (_e728 + vec3<i32>(0i, 1i, 0i));
            let _e730 = up;
            param_222 = _e730;
            let _e731 = locustInBounds_u0028_vi3_u003b((&param_222));
            phi_7779_ = _e731;
            if _e731 {
                let _e732 = up;
                param_223 = _e732;
                let _e733 = getIndex_u0028_vi3_u003b((&param_223));
                param_224 = _e733;
                let _e734 = readCell_u0028_u1_u003b((&param_224));
                phi_7779_ = (_e734 == 0u);
            }
            let _e737 = phi_7779_;
            if _e737 {
                let _e738 = heading_1;
                param_225 = _e738;
                let _e739 = steps_1;
                param_226 = _e739;
                let _e740 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_225), (&param_226));
                nav_3 = _e740;
                let _e741 = up;
                param_227 = _e741;
                let _e742 = getIndex_u0028_vi3_u003b((&param_227));
                let _e743 = up;
                param_228 = _e743;
                let _e744 = nav_3;
                param_229 = _e744;
                let _e745 = locustArriveDir_u0028_vi3_u003b_u1_u003b((&param_228), (&param_229));
                let _e746 = newType;
                param_230 = _e746;
                param_231 = _e745;
                param_232 = 0u;
                let _e747 = count_2;
                param_233 = _e747;
                let _e748 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_230), (&param_231), (&param_232), (&param_233));
                let _e749 = (*currentIndex_3);
                param_234 = _e749;
                let _e750 = (*rawValue_2);
                param_235 = _e750;
                param_236 = _e742;
                param_237 = _e748;
                let _e751 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_234), (&param_235), (&param_236), (&param_237));
                if _e751 {
                    return;
                }
            }
        }
        let _e752 = (*randVal_3);
        heading_1 = (u32((fract((_e752 * 53f)) * 8f)) & 7u);
        let _e758 = locustRunSteps_u0028_();
        steps_1 = _e758;
    }
    let _e759 = (*currentIndex_3);
    let _e762 = (*rawValue_2);
    let _e763 = heading_1;
    param_238 = _e763;
    let _e764 = steps_1;
    param_239 = _e764;
    let _e765 = locustPackNav_u0028_u1_u003b_u1_u003b((&param_238), (&param_239));
    let _e766 = newType;
    param_240 = _e766;
    param_241 = _e765;
    param_242 = 0u;
    let _e767 = count_2;
    param_243 = _e767;
    let _e768 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_240), (&param_241), (&param_242), (&param_243));
    let _e769 = atomicCompareExchangeWeak((&unnamed.grid[_e759]), _e762, _e768);
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

    let _e227 = (*pos_6)[1u];
    if (_e227 > 1i) {
        let _e229 = (*pos_6);
        belowPos_2 = (_e229 + vec3<i32>(0i, -1i, 0i));
        let _e231 = belowPos_2;
        param_244 = _e231;
        let _e232 = getIndex_u0028_vi3_u003b((&param_244));
        param_245 = _e232;
        let _e233 = readCell_u0028_u1_u003b((&param_245));
        param_246 = _e233;
        let _e234 = getType_u0028_u1_u003b((&param_246));
        if (_e234 == 0u) {
            let _e236 = belowPos_2;
            param_247 = _e236;
            let _e237 = getIndex_u0028_vi3_u003b((&param_247));
            param_248 = 12u;
            param_249 = 0u;
            param_250 = 0u;
            let _e238 = (*currentAge_3);
            param_251 = _e238;
            let _e239 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_248), (&param_249), (&param_250), (&param_251));
            let _e240 = (*currentIndex_4);
            param_252 = _e240;
            let _e241 = (*rawValue_3);
            param_253 = _e241;
            param_254 = _e237;
            param_255 = _e239;
            let _e242 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_252), (&param_253), (&param_254), (&param_255));
            if _e242 {
                return;
            }
        }
    }
    let _e243 = (*currentAge_3);
    let _e244 = (_e243 > 0u);
    phi_6463_ = _e244;
    if _e244 {
        let _e245 = (*randVal_4);
        let _e249 = tuning.darkStoneDryChance;
        phi_6463_ = (fract((_e245 * 23f)) < _e249);
    }
    let _e252 = phi_6463_;
    if _e252 {
        let _e253 = (*currentIndex_4);
        let _e256 = (*rawValue_3);
        let _e257 = (*currentAge_3);
        param_256 = 12u;
        param_257 = 0u;
        param_258 = 0u;
        param_259 = (_e257 - 1u);
        let _e259 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_256), (&param_257), (&param_258), (&param_259));
        let _e260 = atomicCompareExchangeWeak((&unnamed.grid[_e253]), _e256, _e259);
    }
    return;
}

fn isLava_u0028_u1_u003b(type_37: ptr<function, u32>) -> bool {
    let _e205 = (*type_37);
    let _e207 = (*type_37);
    return ((_e205 >= 8u) && (_e207 <= 11u));
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
    let _e205 = atomicAdd((&unnamed_1.waterVoxelCount), 4294967295u);
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

    let _e272 = (*randVal_5);
    startDir = i32((fract((_e272 * 17f)) * 6f));
    i_7 = 0i;
    loop {
        let _e277 = i_7;
        if (_e277 < 6i) {
            let _e279 = startDir;
            let _e280 = i_7;
            let _e281 = (_e279 + _e280);
            d_6 = (_e281 - (i32(floor((f32(_e281) / f32(6i)))) * 6i));
            let _e289 = (*pos_7);
            let _e290 = d_6;
            param_260 = _e290;
            let _e291 = getOrthoDir_u0028_i1_u003b((&param_260));
            nPos = (_e289 + _e291);
            let _e294 = nPos[0u];
            let _e295 = (_e294 <= 0i);
            phi_5517_ = _e295;
            if !(_e295) {
                let _e298 = nPos[0u];
                let _e300 = tuning.gridWidth;
                phi_5517_ = (_e298 >= (bitcast<i32>(_e300) - 1i));
            }
            let _e305 = phi_5517_;
            phi_5524_ = _e305;
            if !(_e305) {
                let _e308 = nPos[1u];
                phi_5524_ = (_e308 <= 0i);
            }
            let _e311 = phi_5524_;
            phi_5535_ = _e311;
            if !(_e311) {
                let _e314 = nPos[1u];
                let _e316 = tuning.gridHeight;
                phi_5535_ = (_e314 >= (bitcast<i32>(_e316) - 1i));
            }
            let _e321 = phi_5535_;
            phi_5542_ = _e321;
            if !(_e321) {
                let _e324 = nPos[2u];
                phi_5542_ = (_e324 <= 0i);
            }
            let _e327 = phi_5542_;
            phi_5553_ = _e327;
            if !(_e327) {
                let _e330 = nPos[2u];
                let _e332 = tuning.gridDepth;
                phi_5553_ = (_e330 >= (bitcast<i32>(_e332) - 1i));
            }
            let _e337 = phi_5553_;
            if _e337 {
                continue;
            }
            let _e338 = nPos;
            param_261 = _e338;
            let _e339 = getIndex_u0028_vi3_u003b((&param_261));
            nIndex = _e339;
            let _e340 = nIndex;
            param_262 = _e340;
            let _e341 = readCell_u0028_u1_u003b((&param_262));
            nVal = _e341;
            let _e342 = nVal;
            param_263 = _e342;
            let _e343 = getType_u0028_u1_u003b((&param_263));
            nType = _e343;
            let _e344 = nType;
            if (_e344 == 2u) {
                let _e346 = nIndex;
                let _e349 = nVal;
                param_264 = 6u;
                param_265 = 0u;
                param_266 = 0u;
                param_267 = 0u;
                let _e350 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_264), (&param_265), (&param_266), (&param_267));
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
                let _e360 = nType;
                if (_e360 == 19u) {
                    let _e362 = nIndex;
                    let _e365 = nVal;
                    let _e366 = atomicCompareExchangeWeak((&unnamed.grid[_e362]), _e365, 0u);
                    let _e368 = nVal;
                    if (_e366.old_value == _e368) {
                        return;
                    }
                } else {
                    let _e370 = nType;
                    if (_e370 == 18u) {
                        let _e372 = nIndex;
                        let _e375 = nVal;
                        param_268 = 5u;
                        param_269 = 0u;
                        param_270 = 0u;
                        param_271 = 0u;
                        let _e376 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_268), (&param_269), (&param_270), (&param_271));
                        let _e377 = atomicCompareExchangeWeak((&unnamed.grid[_e372]), _e375, _e376);
                        let _e379 = nVal;
                        if (_e377.old_value == _e379) {
                            return;
                        }
                    } else {
                        let _e381 = nType;
                        if (_e381 == 3u) {
                            let _e383 = nIndex;
                            let _e386 = nVal;
                            param_272 = 12u;
                            param_273 = 0u;
                            param_274 = 0u;
                            param_275 = 255u;
                            let _e387 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_272), (&param_273), (&param_274), (&param_275));
                            let _e388 = atomicCompareExchangeWeak((&unnamed.grid[_e383]), _e386, _e387);
                            let _e390 = nVal;
                            if (_e388.old_value == _e390) {
                                return;
                            }
                        } else {
                            let _e392 = nType;
                            let _e394 = nType;
                            if ((_e392 == 1u) || (_e394 == 4u)) {
                                let _e397 = nVal;
                                param_276 = _e397;
                                let _e398 = getAge_u0028_u1_u003b((&param_276));
                                moisture_1 = _e398;
                                let _e399 = nVal;
                                param_277 = _e399;
                                let _e400 = getDir_u0028_u1_u003b((&param_277));
                                flora_2 = _e400;
                                let _e401 = nType;
                                let _e403 = flora_2;
                                let _e406 = flora_2;
                                if (((_e401 == 4u) && (_e403 > 10u)) && (_e406 <= 100u)) {
                                    let _e409 = nPos;
                                    abovePos = (_e409 + vec3<i32>(0i, 1i, 0i));
                                    let _e412 = abovePos[1u];
                                    let _e414 = tuning.gridHeight;
                                    let _e417 = (_e412 < (bitcast<i32>(_e414) - 1i));
                                    phi_5692_ = _e417;
                                    if _e417 {
                                        let _e418 = abovePos;
                                        param_278 = _e418;
                                        let _e419 = getIndex_u0028_vi3_u003b((&param_278));
                                        param_279 = _e419;
                                        let _e420 = readCell_u0028_u1_u003b((&param_279));
                                        param_280 = _e420;
                                        let _e421 = getType_u0028_u1_u003b((&param_280));
                                        phi_5692_ = (_e421 == 0u);
                                    }
                                    let _e424 = phi_5692_;
                                    phi_5703_ = _e424;
                                    if _e424 {
                                        let _e425 = (*randVal_5);
                                        let _e429 = tuning.lavaIgniteChance;
                                        phi_5703_ = (fract((_e425 * 41f)) < _e429);
                                    }
                                    let _e432 = phi_5703_;
                                    if _e432 {
                                        let _e433 = abovePos;
                                        param_281 = _e433;
                                        let _e434 = getIndex_u0028_vi3_u003b((&param_281));
                                        param_282 = 5u;
                                        param_283 = 0u;
                                        param_284 = 0u;
                                        param_285 = 0u;
                                        let _e437 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_282), (&param_283), (&param_284), (&param_285));
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
                                        let _e449 = nType;
                                        param_286 = _e449;
                                        let _e450 = flora_2;
                                        param_287 = _e450;
                                        param_288 = 0u;
                                        param_289 = (_e447 - 1u);
                                        let _e451 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_286), (&param_287), (&param_288), (&param_289));
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
                                let _e475 = nType;
                                param_290 = _e475;
                                let _e476 = isLava_u0028_u1_u003b((&param_290));
                                if _e476 {
                                    let _e477 = nVal;
                                    param_291 = _e477;
                                    let _e478 = getAge_u0028_u1_u003b((&param_291));
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
                                            param_292 = _e488;
                                            let _e489 = lavaTypeFor_u0028_u1_u003b((&param_292));
                                            local_10 = _e489;
                                        }
                                        let _e490 = local_10;
                                        raisedType = _e490;
                                        let _e491 = nIndex;
                                        let _e494 = nVal;
                                        let _e495 = nVal;
                                        param_293 = _e495;
                                        let _e496 = getDir_u0028_u1_u003b((&param_293));
                                        let _e497 = raisedType;
                                        param_294 = _e497;
                                        param_295 = _e496;
                                        param_296 = 0u;
                                        let _e498 = raised;
                                        param_297 = _e498;
                                        let _e499 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_294), (&param_295), (&param_296), (&param_297));
                                        let _e500 = atomicCompareExchangeWeak((&unnamed.grid[_e491]), _e494, _e499);
                                        let _e502 = nVal;
                                        if (_e500.old_value == _e502) {
                                            let _e504 = (*coolness_1);
                                            (*coolness_1) = (_e504 - 1u);
                                            return;
                                        }
                                    }
                                } else {
                                    let _e506 = nType;
                                    if (_e506 == 12u) {
                                        let _e508 = nVal;
                                        param_298 = _e508;
                                        let _e509 = getAge_u0028_u1_u003b((&param_298));
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
                                                param_299 = _e526;
                                                let _e527 = lavaTypeFor_u0028_u1_u003b((&param_299));
                                                local_12 = _e527;
                                            } else {
                                                local_12 = 12u;
                                            }
                                            let _e528 = local_12;
                                            newType_1 = _e528;
                                            let _e529 = nIndex;
                                            let _e532 = nVal;
                                            let _e533 = newType_1;
                                            param_300 = _e533;
                                            param_301 = 0u;
                                            param_302 = 0u;
                                            let _e534 = lowered;
                                            param_303 = _e534;
                                            let _e535 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_300), (&param_301), (&param_302), (&param_303));
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
            let _e544 = i_7;
            i_7 = (_e544 + 1i);
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

    let _e306 = (*currentAge_4);
    coolness_2 = _e306;
    let _e307 = (*pos_8);
    param_304 = _e307;
    let _e308 = coolness_2;
    param_305 = _e308;
    let _e309 = (*randVal_6);
    param_306 = _e309;
    lavaInteract_u0028_vi3_u003b_u1_u003b_f1_u003b((&param_304), (&param_305), (&param_306));
    let _e310 = param_305;
    coolness_2 = _e310;
    let _e311 = (*currentSleep_1);
    let _e313 = tuning.wakeSleepThreshold;
    let _e314 = (_e311 > _e313);
    phi_5911_ = _e314;
    if _e314 {
        let _e315 = (*randVal_6);
        let _e319 = tuning.lavaRestCoolChance;
        phi_5911_ = (fract((_e315 * 71f)) < _e319);
    }
    let _e322 = phi_5911_;
    if _e322 {
        let _e323 = coolness_2;
        coolness_2 = min((_e323 + 1u), 255u);
    }
    let _e326 = coolness_2;
    let _e327 = lavaSolidifyCoolness_u0028_();
    if (_e326 >= _e327) {
        let _e329 = (*currentIndex_5);
        let _e332 = (*rawValue_4);
        param_307 = 12u;
        param_308 = 0u;
        param_309 = 0u;
        let _e333 = coolness_2;
        param_310 = _e333;
        let _e334 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_307), (&param_308), (&param_309), (&param_310));
        let _e335 = atomicCompareExchangeWeak((&unnamed.grid[_e329]), _e332, _e334);
        return;
    }
    let _e337 = coolness_2;
    param_311 = _e337;
    let _e338 = lavaTypeFor_u0028_u1_u003b((&param_311));
    newType_2 = _e338;
    let _e339 = (*randVal_6);
    let _e343 = tuning.lavaViscosity;
    if (fract((_e339 * 89f)) < _e343) {
        let _e346 = (*pos_8)[1u];
        if (_e346 > 1i) {
            let _e348 = (*pos_8);
            belowPos_3 = (_e348 + vec3<i32>(0i, -1i, 0i));
            let _e350 = belowPos_3;
            param_312 = _e350;
            let _e351 = getIndex_u0028_vi3_u003b((&param_312));
            param_313 = _e351;
            let _e352 = readCell_u0028_u1_u003b((&param_313));
            param_314 = _e352;
            let _e353 = getType_u0028_u1_u003b((&param_314));
            if (_e353 == 0u) {
                let _e355 = belowPos_3;
                param_315 = _e355;
                let _e356 = getIndex_u0028_vi3_u003b((&param_315));
                let _e357 = newType_2;
                param_316 = _e357;
                let _e358 = (*currentDir_2);
                param_317 = _e358;
                param_318 = 0u;
                let _e359 = coolness_2;
                param_319 = _e359;
                let _e360 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_316), (&param_317), (&param_318), (&param_319));
                let _e361 = (*currentIndex_5);
                param_320 = _e361;
                let _e362 = (*rawValue_4);
                param_321 = _e362;
                param_322 = _e356;
                param_323 = _e360;
                let _e363 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_320), (&param_321), (&param_322), (&param_323));
                if _e363 {
                    return;
                }
            }
        }
        let _e365 = (*pos_8)[1u];
        if (_e365 > 1i) {
            let _e367 = (*randVal_6);
            slideDir = select(-1i, 1i, (fract((_e367 * 10f)) > 0.5f));
            let _e372 = (*randVal_6);
            if (fract((_e372 * 100f)) > 0.5f) {
                let _e376 = (*pos_8);
                let _e377 = slideDir;
                slide[0i] = (_e376 + vec3<i32>(_e377, -1i, 0i));
                let _e381 = (*pos_8);
                let _e382 = slideDir;
                slide[1i] = (_e381 + vec3<i32>(0i, -1i, _e382));
            } else {
                let _e386 = (*pos_8);
                let _e387 = slideDir;
                slide[0i] = (_e386 + vec3<i32>(0i, -1i, _e387));
                let _e391 = (*pos_8);
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
                    phi_6049_ = _e403;
                    if _e403 {
                        let _e405 = sPos[0u];
                        let _e407 = tuning.gridWidth;
                        phi_6049_ = (_e405 < (bitcast<i32>(_e407) - 1i));
                    }
                    let _e412 = phi_6049_;
                    phi_6055_ = _e412;
                    if _e412 {
                        let _e414 = sPos[2u];
                        phi_6055_ = (_e414 > 0i);
                    }
                    let _e417 = phi_6055_;
                    phi_6065_ = _e417;
                    if _e417 {
                        let _e419 = sPos[2u];
                        let _e421 = tuning.gridDepth;
                        phi_6065_ = (_e419 < (bitcast<i32>(_e421) - 1i));
                    }
                    let _e426 = phi_6065_;
                    if _e426 {
                        let _e427 = sPos;
                        param_324 = _e427;
                        let _e428 = getIndex_u0028_vi3_u003b((&param_324));
                        param_325 = _e428;
                        let _e429 = readCell_u0028_u1_u003b((&param_325));
                        param_326 = _e429;
                        let _e430 = getType_u0028_u1_u003b((&param_326));
                        if (_e430 == 0u) {
                            let _e432 = sPos;
                            param_327 = _e432;
                            let _e433 = getIndex_u0028_vi3_u003b((&param_327));
                            let _e434 = newType_2;
                            param_328 = _e434;
                            let _e435 = (*currentDir_2);
                            param_329 = _e435;
                            param_330 = 0u;
                            let _e436 = coolness_2;
                            param_331 = _e436;
                            let _e437 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_328), (&param_329), (&param_330), (&param_331));
                            let _e438 = (*currentIndex_5);
                            param_332 = _e438;
                            let _e439 = (*rawValue_4);
                            param_333 = _e439;
                            param_334 = _e433;
                            param_335 = _e437;
                            let _e440 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_332), (&param_333), (&param_334), (&param_335));
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
                    i_8 = 0i;
                    loop {
                        let _e461 = i_8;
                        if (_e461 < 8i) {
                            let _e463 = searchStart;
                            let _e464 = i_8;
                            let _e465 = (_e463 + _e464);
                            d_7 = (_e465 - (i32(floor((f32(_e465) / f32(8i)))) * 8i));
                            let _e473 = blockedMask;
                            let _e474 = d_7;
                            if ((_e473 & (1u << bitcast<u32>(_e474))) != 0u) {
                                continue;
                            }
                            let _e479 = (*pos_8);
                            let _e480 = d_7;
                            param_336 = _e480;
                            let _e481 = getHDir_u0028_i1_u003b((&param_336));
                            let _e482 = r;
                            c_6 = (_e479 + (_e481 * vec3(_e482)));
                            let _e487 = c_6[0u];
                            let _e488 = (_e487 <= 0i);
                            phi_6177_ = _e488;
                            if !(_e488) {
                                let _e491 = c_6[0u];
                                let _e493 = tuning.gridWidth;
                                phi_6177_ = (_e491 >= (bitcast<i32>(_e493) - 1i));
                            }
                            let _e498 = phi_6177_;
                            phi_6184_ = _e498;
                            if !(_e498) {
                                let _e501 = c_6[2u];
                                phi_6184_ = (_e501 <= 0i);
                            }
                            let _e504 = phi_6184_;
                            phi_6195_ = _e504;
                            if !(_e504) {
                                let _e507 = c_6[2u];
                                let _e509 = tuning.gridDepth;
                                phi_6195_ = (_e507 >= (bitcast<i32>(_e509) - 1i));
                            }
                            let _e514 = phi_6195_;
                            phi_6207_ = _e514;
                            if !(_e514) {
                                let _e516 = c_6;
                                param_337 = _e516;
                                let _e517 = getIndex_u0028_vi3_u003b((&param_337));
                                param_338 = _e517;
                                let _e518 = readCell_u0028_u1_u003b((&param_338));
                                param_339 = _e518;
                                let _e519 = getType_u0028_u1_u003b((&param_339));
                                phi_6207_ = (_e519 != 0u);
                            }
                            let _e522 = phi_6207_;
                            if _e522 {
                                let _e523 = d_7;
                                let _e526 = blockedMask;
                                blockedMask = (_e526 | (1u << bitcast<u32>(_e523)));
                            } else {
                                let _e529 = c_6[1u];
                                let _e530 = (_e529 > 1i);
                                phi_6229_ = _e530;
                                if _e530 {
                                    let _e531 = c_6;
                                    param_340 = (_e531 + vec3<i32>(0i, -1i, 0i));
                                    let _e533 = getIndex_u0028_vi3_u003b((&param_340));
                                    param_341 = _e533;
                                    let _e534 = readCell_u0028_u1_u003b((&param_341));
                                    param_342 = _e534;
                                    let _e535 = getType_u0028_u1_u003b((&param_342));
                                    phi_6229_ = (_e535 == 0u);
                                }
                                let _e538 = phi_6229_;
                                if _e538 {
                                    let _e539 = c_6;
                                    param_343 = _e539;
                                    let _e540 = getIndex_u0028_vi3_u003b((&param_343));
                                    let _e541 = newType_2;
                                    param_344 = _e541;
                                    param_345 = 0u;
                                    param_346 = 0u;
                                    let _e542 = coolness_2;
                                    param_347 = _e542;
                                    let _e543 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_344), (&param_345), (&param_346), (&param_347));
                                    let _e544 = (*currentIndex_5);
                                    param_348 = _e544;
                                    let _e545 = (*rawValue_4);
                                    param_349 = _e545;
                                    param_350 = _e540;
                                    param_351 = _e543;
                                    let _e546 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_348), (&param_349), (&param_350), (&param_351));
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
                            let _e552 = i_8;
                            i_8 = (_e552 + 1i);
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
            let _e557 = (*pos_8)[1u];
            let _e559 = tuning.gridHeight;
            if (_e557 < (bitcast<i32>(_e559) - 2i)) {
                let _e563 = (*pos_8);
                param_352 = (_e563 + vec3<i32>(0i, 1i, 0i));
                let _e565 = getIndex_u0028_vi3_u003b((&param_352));
                param_353 = _e565;
                let _e566 = readCell_u0028_u1_u003b((&param_353));
                param_354 = _e566;
                let _e567 = getType_u0028_u1_u003b((&param_354));
                local_13 = (_e567 != 0u);
            } else {
                local_13 = false;
            }
            let _e569 = local_13;
            hasPressure = _e569;
            let _e571 = (*pos_8)[1u];
            if (_e571 > 1i) {
                let _e573 = (*pos_8);
                param_355 = (_e573 + vec3<i32>(0i, -1i, 0i));
                let _e575 = getIndex_u0028_vi3_u003b((&param_355));
                param_356 = _e575;
                let _e576 = readCell_u0028_u1_u003b((&param_356));
                param_357 = _e576;
                let _e577 = getType_u0028_u1_u003b((&param_357));
                param_358 = _e577;
                let _e578 = isLava_u0028_u1_u003b((&param_358));
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
                i_9 = 0i;
                loop {
                    let _e588 = i_9;
                    if (_e588 < 8i) {
                        let _e590 = spreadStart;
                        let _e591 = i_9;
                        let _e592 = (_e590 + _e591);
                        d_8 = (_e592 - (i32(floor((f32(_e592) / f32(8i)))) * 8i));
                        let _e600 = (*pos_8);
                        let _e601 = d_8;
                        param_359 = _e601;
                        let _e602 = getHDir_u0028_i1_u003b((&param_359));
                        targetPos = (_e600 + _e602);
                        let _e605 = targetPos[0u];
                        let _e606 = (_e605 > 0i);
                        phi_6343_ = _e606;
                        if _e606 {
                            let _e608 = targetPos[0u];
                            let _e610 = tuning.gridWidth;
                            phi_6343_ = (_e608 < (bitcast<i32>(_e610) - 1i));
                        }
                        let _e615 = phi_6343_;
                        phi_6349_ = _e615;
                        if _e615 {
                            let _e617 = targetPos[2u];
                            phi_6349_ = (_e617 > 0i);
                        }
                        let _e620 = phi_6349_;
                        phi_6359_ = _e620;
                        if _e620 {
                            let _e622 = targetPos[2u];
                            let _e624 = tuning.gridDepth;
                            phi_6359_ = (_e622 < (bitcast<i32>(_e624) - 1i));
                        }
                        let _e629 = phi_6359_;
                        if _e629 {
                            let _e630 = targetPos;
                            param_360 = _e630;
                            let _e631 = getIndex_u0028_vi3_u003b((&param_360));
                            param_361 = _e631;
                            let _e632 = readCell_u0028_u1_u003b((&param_361));
                            param_362 = _e632;
                            let _e633 = getType_u0028_u1_u003b((&param_362));
                            if (_e633 == 0u) {
                                let _e635 = targetPos;
                                param_363 = _e635;
                                let _e636 = getIndex_u0028_vi3_u003b((&param_363));
                                let _e637 = d_8;
                                let _e640 = newType_2;
                                param_364 = _e640;
                                param_365 = bitcast<u32>((_e637 + 1i));
                                param_366 = 0u;
                                let _e641 = coolness_2;
                                param_367 = _e641;
                                let _e642 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_364), (&param_365), (&param_366), (&param_367));
                                let _e643 = (*currentIndex_5);
                                param_368 = _e643;
                                let _e644 = (*rawValue_4);
                                param_369 = _e644;
                                param_370 = _e636;
                                param_371 = _e642;
                                let _e645 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_368), (&param_369), (&param_370), (&param_371));
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
                        let _e646 = i_9;
                        i_9 = (_e646 + 1i);
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
    param_372 = _e655;
    let _e656 = (*currentDir_2);
    param_373 = _e656;
    let _e657 = newSleep;
    param_374 = _e657;
    let _e658 = coolness_2;
    param_375 = _e658;
    let _e659 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_372), (&param_373), (&param_374), (&param_375));
    let _e660 = atomicCompareExchangeWeak((&unnamed.grid[_e651]), _e654, _e659);
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

    let _e262 = (*pos_9)[1u];
    let _e264 = tuning.gridHeight;
    if (_e262 >= (bitcast<i32>(_e264) - 2i)) {
        let _e269 = atomicAdd((&unnamed_1.cloudWaterCount), 1u);
        let _e270 = (*currentIndex_6);
        let _e273 = atomicExchange((&unnamed.grid[_e270]), 0u);
        return;
    }
    let _e274 = (*currentAge_5);
    newAge = min((_e274 + 1u), 255u);
    let _e277 = (*randVal_7);
    let _e281 = tuning.steamScatterChance;
    if (fract((_e277 * 88f)) < _e281) {
        let _e283 = (*randVal_7);
        d_9 = i32((fract((_e283 * 13f)) * 6f));
        let _e288 = (*pos_9);
        let _e289 = d_9;
        param_376 = _e289;
        let _e290 = getOrthoDir_u0028_i1_u003b((&param_376));
        scatterPos = (_e288 + _e290);
        let _e293 = scatterPos[0u];
        let _e294 = (_e293 > 0i);
        phi_8619_ = _e294;
        if _e294 {
            let _e296 = scatterPos[0u];
            let _e298 = tuning.gridWidth;
            phi_8619_ = (_e296 < (bitcast<i32>(_e298) - 1i));
        }
        let _e303 = phi_8619_;
        phi_8625_ = _e303;
        if _e303 {
            let _e305 = scatterPos[1u];
            phi_8625_ = (_e305 > 0i);
        }
        let _e308 = phi_8625_;
        phi_8635_ = _e308;
        if _e308 {
            let _e310 = scatterPos[1u];
            let _e312 = tuning.gridHeight;
            phi_8635_ = (_e310 < (bitcast<i32>(_e312) - 1i));
        }
        let _e317 = phi_8635_;
        phi_8641_ = _e317;
        if _e317 {
            let _e319 = scatterPos[2u];
            phi_8641_ = (_e319 > 0i);
        }
        let _e322 = phi_8641_;
        phi_8651_ = _e322;
        if _e322 {
            let _e324 = scatterPos[2u];
            let _e326 = tuning.gridDepth;
            phi_8651_ = (_e324 < (bitcast<i32>(_e326) - 1i));
        }
        let _e331 = phi_8651_;
        if _e331 {
            let _e332 = scatterPos;
            param_377 = _e332;
            let _e333 = getIndex_u0028_vi3_u003b((&param_377));
            param_378 = _e333;
            let _e334 = readCell_u0028_u1_u003b((&param_378));
            param_379 = _e334;
            let _e335 = getType_u0028_u1_u003b((&param_379));
            sType = _e335;
            let _e336 = sType;
            let _e338 = sType;
            if ((_e336 == 0u) || (_e338 == 5u)) {
                let _e341 = scatterPos;
                param_380 = _e341;
                let _e342 = getIndex_u0028_vi3_u003b((&param_380));
                param_381 = 6u;
                param_382 = 0u;
                param_383 = 0u;
                let _e343 = newAge;
                param_384 = _e343;
                let _e344 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_381), (&param_382), (&param_383), (&param_384));
                let _e345 = (*currentIndex_6);
                param_385 = _e345;
                let _e346 = (*rawValue_5);
                param_386 = _e346;
                param_387 = _e342;
                param_388 = _e344;
                let _e347 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_385), (&param_386), (&param_387), (&param_388));
                if _e347 {
                    return;
                }
            }
        }
    }
    let _e348 = (*pos_9);
    checkPos[0i] = (_e348 + vec3<i32>(0i, 1i, 0i));
    let _e351 = (*randVal_7);
    dir_1 = select(-1i, 1i, (fract((_e351 * 10f)) > 0.5f));
    let _e356 = (*randVal_7);
    if (fract((_e356 * 100f)) > 0.5f) {
        let _e360 = (*pos_9);
        let _e361 = dir_1;
        checkPos[1i] = (_e360 + vec3<i32>(_e361, 1i, 0i));
        let _e365 = (*pos_9);
        let _e366 = dir_1;
        checkPos[2i] = (_e365 + vec3<i32>(0i, 1i, _e366));
    } else {
        let _e370 = (*pos_9);
        let _e371 = dir_1;
        checkPos[1i] = (_e370 + vec3<i32>(0i, 1i, _e371));
        let _e375 = (*pos_9);
        let _e376 = dir_1;
        checkPos[2i] = (_e375 + vec3<i32>(_e376, 1i, 0i));
    }
    i_10 = 0i;
    loop {
        let _e380 = i_10;
        if (_e380 < 3i) {
            let _e382 = i_10;
            let _e384 = checkPos[_e382];
            cPos = _e384;
            let _e386 = cPos[0u];
            let _e387 = (_e386 > 0i);
            phi_8751_ = _e387;
            if _e387 {
                let _e389 = cPos[0u];
                let _e391 = tuning.gridWidth;
                phi_8751_ = (_e389 < (bitcast<i32>(_e391) - 1i));
            }
            let _e396 = phi_8751_;
            phi_8757_ = _e396;
            if _e396 {
                let _e398 = cPos[2u];
                phi_8757_ = (_e398 > 0i);
            }
            let _e401 = phi_8757_;
            phi_8767_ = _e401;
            if _e401 {
                let _e403 = cPos[2u];
                let _e405 = tuning.gridDepth;
                phi_8767_ = (_e403 < (bitcast<i32>(_e405) - 1i));
            }
            let _e410 = phi_8767_;
            if _e410 {
                let _e411 = cPos;
                param_389 = _e411;
                let _e412 = getIndex_u0028_vi3_u003b((&param_389));
                cIndex = _e412;
                let _e413 = cIndex;
                param_390 = _e413;
                let _e414 = readCell_u0028_u1_u003b((&param_390));
                cVal = _e414;
                let _e415 = cVal;
                param_391 = _e415;
                let _e416 = getType_u0028_u1_u003b((&param_391));
                cType = _e416;
                let _e417 = cType;
                let _e419 = cType;
                if ((_e417 == 1u) || (_e419 == 4u)) {
                    let _e422 = cVal;
                    param_392 = _e422;
                    let _e423 = getAge_u0028_u1_u003b((&param_392));
                    moisture_2 = _e423;
                    let _e424 = cType;
                    if (_e424 == 4u) {
                        let _e427 = tuning.dirtMoistureCapacity;
                        local_15 = _e427;
                    } else {
                        let _e429 = tuning.sandMoistureCapacity;
                        local_15 = _e429;
                    }
                    let _e430 = local_15;
                    capacity = _e430;
                    let _e431 = moisture_2;
                    let _e432 = capacity;
                    if (_e431 < _e432) {
                        let _e434 = (*currentIndex_6);
                        let _e437 = (*rawValue_5);
                        let _e438 = atomicCompareExchangeWeak((&unnamed.grid[_e434]), _e437, 0u);
                        let _e440 = (*rawValue_5);
                        if (_e438.old_value == _e440) {
                            let _e442 = cIndex;
                            let _e445 = atomicAdd((&unnamed.grid[_e442]), 16777216u);
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
            let _e446 = i_10;
            i_10 = (_e446 + 1i);
        }
    }
    i_11 = 0i;
    loop {
        let _e448 = i_11;
        if (_e448 < 3i) {
            let _e450 = i_11;
            let _e452 = checkPos[_e450];
            sPos_1 = _e452;
            let _e454 = sPos_1[0u];
            let _e455 = (_e454 > 0i);
            phi_8848_ = _e455;
            if _e455 {
                let _e457 = sPos_1[0u];
                let _e459 = tuning.gridWidth;
                phi_8848_ = (_e457 < (bitcast<i32>(_e459) - 1i));
            }
            let _e464 = phi_8848_;
            phi_8854_ = _e464;
            if _e464 {
                let _e466 = sPos_1[2u];
                phi_8854_ = (_e466 > 0i);
            }
            let _e469 = phi_8854_;
            phi_8864_ = _e469;
            if _e469 {
                let _e471 = sPos_1[2u];
                let _e473 = tuning.gridDepth;
                phi_8864_ = (_e471 < (bitcast<i32>(_e473) - 1i));
            }
            let _e478 = phi_8864_;
            if _e478 {
                let _e479 = sPos_1;
                param_393 = _e479;
                let _e480 = getIndex_u0028_vi3_u003b((&param_393));
                param_394 = _e480;
                let _e481 = readCell_u0028_u1_u003b((&param_394));
                param_395 = _e481;
                let _e482 = getType_u0028_u1_u003b((&param_395));
                sType_1 = _e482;
                let _e483 = sType_1;
                let _e485 = sType_1;
                if ((_e483 == 0u) || (_e485 == 5u)) {
                    let _e488 = sPos_1;
                    param_396 = _e488;
                    let _e489 = getIndex_u0028_vi3_u003b((&param_396));
                    param_397 = 6u;
                    param_398 = 0u;
                    param_399 = 0u;
                    let _e490 = newAge;
                    param_400 = _e490;
                    let _e491 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_397), (&param_398), (&param_399), (&param_400));
                    let _e492 = (*currentIndex_6);
                    param_401 = _e492;
                    let _e493 = (*rawValue_5);
                    param_402 = _e493;
                    param_403 = _e489;
                    param_404 = _e491;
                    let _e494 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_401), (&param_402), (&param_403), (&param_404));
                    if _e494 {
                        return;
                    }
                }
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e495 = i_11;
            i_11 = (_e495 + 1i);
        }
    }
    let _e497 = (*currentSleep_2);
    newSleep_1 = min((_e497 + 1u), 255u);
    let _e500 = (*currentIndex_6);
    let _e503 = (*rawValue_5);
    param_405 = 6u;
    param_406 = 0u;
    let _e504 = newSleep_1;
    param_407 = _e504;
    let _e505 = newAge;
    param_408 = _e505;
    let _e506 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_405), (&param_406), (&param_407), (&param_408));
    let _e507 = atomicCompareExchangeWeak((&unnamed.grid[_e500]), _e503, _e506);
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

    let _e297 = (*currentAge_6);
    newAge_1 = (_e297 + 1u);
    isBurningGrass = false;
    i_12 = 0i;
    loop {
        let _e299 = i_12;
        if (_e299 < 6i) {
            let _e301 = (*pos_10);
            let _e302 = i_12;
            param_409 = _e302;
            let _e303 = getOrthoDir_u0028_i1_u003b((&param_409));
            nPos_1 = (_e301 + _e303);
            let _e306 = nPos_1[0u];
            let _e307 = (_e306 > 0i);
            phi_7866_ = _e307;
            if _e307 {
                let _e309 = nPos_1[0u];
                let _e311 = tuning.gridWidth;
                phi_7866_ = (_e309 < (bitcast<i32>(_e311) - 1i));
            }
            let _e316 = phi_7866_;
            phi_7872_ = _e316;
            if _e316 {
                let _e318 = nPos_1[1u];
                phi_7872_ = (_e318 > 0i);
            }
            let _e321 = phi_7872_;
            phi_7882_ = _e321;
            if _e321 {
                let _e323 = nPos_1[1u];
                let _e325 = tuning.gridHeight;
                phi_7882_ = (_e323 < (bitcast<i32>(_e325) - 1i));
            }
            let _e330 = phi_7882_;
            phi_7888_ = _e330;
            if _e330 {
                let _e332 = nPos_1[2u];
                phi_7888_ = (_e332 > 0i);
            }
            let _e335 = phi_7888_;
            phi_7898_ = _e335;
            if _e335 {
                let _e337 = nPos_1[2u];
                let _e339 = tuning.gridDepth;
                phi_7898_ = (_e337 < (bitcast<i32>(_e339) - 1i));
            }
            let _e344 = phi_7898_;
            if _e344 {
                let _e345 = nPos_1;
                param_410 = _e345;
                let _e346 = getIndex_u0028_vi3_u003b((&param_410));
                nIndex_1 = _e346;
                let _e347 = nIndex_1;
                param_411 = _e347;
                let _e348 = readCell_u0028_u1_u003b((&param_411));
                nVal_1 = _e348;
                let _e349 = nVal_1;
                param_412 = _e349;
                let _e350 = getType_u0028_u1_u003b((&param_412));
                if (_e350 == 2u) {
                    let _e352 = nIndex_1;
                    let _e355 = nVal_1;
                    param_413 = 6u;
                    param_414 = 0u;
                    param_415 = 0u;
                    param_416 = 0u;
                    let _e356 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_413), (&param_414), (&param_415), (&param_416));
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
            let _e365 = i_12;
            i_12 = (_e365 + 1i);
        }
    }
    let _e367 = (*randVal_8);
    burnRoll = fract((_e367 * 47f));
    let _e370 = burnRoll;
    let _e372 = tuning.treeLeafBurnChance;
    let _e374 = tuning.treeTrunkBurnChance;
    if (_e370 < max(_e372, _e374)) {
        let _e377 = (*randVal_8);
        start_6 = i32((fract((_e377 * 31f)) * 26f));
        i_13 = 0i;
        loop {
            let _e382 = i_13;
            if (_e382 < 26i) {
                let _e384 = (*pos_10);
                let _e385 = start_6;
                let _e386 = i_13;
                let _e387 = (_e385 + _e386);
                param_417 = (_e387 - (i32(floor((f32(_e387) / f32(26i)))) * 26i));
                let _e395 = tree26_u0028_i1_u003b((&param_417));
                nPos_2 = (_e384 + _e395);
                let _e397 = nPos_2;
                param_418 = _e397;
                let _e398 = treeInBounds_u0028_vi3_u003b((&param_418));
                if !(_e398) {
                    continue;
                }
                let _e400 = nPos_2;
                param_419 = _e400;
                let _e401 = getIndex_u0028_vi3_u003b((&param_419));
                nIndex_2 = _e401;
                let _e402 = nIndex_2;
                param_420 = _e402;
                let _e403 = readCell_u0028_u1_u003b((&param_420));
                nVal_2 = _e403;
                let _e404 = nVal_2;
                param_421 = _e404;
                let _e405 = getType_u0028_u1_u003b((&param_421));
                nType_1 = _e405;
                let _e406 = nType_1;
                let _e408 = nType_1;
                if ((_e406 != 19u) && (_e408 != 18u)) {
                    continue;
                }
                let _e411 = nType_1;
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
                    param_422 = 5u;
                    param_423 = 0u;
                    param_424 = 0u;
                    param_425 = 0u;
                    let _e425 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_422), (&param_423), (&param_424), (&param_425));
                    let _e426 = atomicCompareExchangeWeak((&unnamed.grid[_e421]), _e424, _e425);
                }
                break;
            } else {
                break;
            }
            continuing {
                let _e428 = i_13;
                i_13 = (_e428 + 1i);
            }
        }
    }
    let _e431 = (*pos_10)[1u];
    if (_e431 > 1i) {
        let _e433 = (*pos_10);
        belowPos_4 = (_e433 + vec3<i32>(0i, -1i, 0i));
        let _e435 = belowPos_4;
        param_426 = _e435;
        let _e436 = getIndex_u0028_vi3_u003b((&param_426));
        belowIndex_1 = _e436;
        let _e437 = belowIndex_1;
        param_427 = _e437;
        let _e438 = readCell_u0028_u1_u003b((&param_427));
        belowValue_1 = _e438;
        let _e439 = belowValue_1;
        param_428 = _e439;
        let _e440 = getType_u0028_u1_u003b((&param_428));
        belowType = _e440;
        let _e441 = belowType;
        if (_e441 == 0u) {
            param_429 = 5u;
            param_430 = 0u;
            param_431 = 0u;
            let _e443 = newAge_1;
            param_432 = _e443;
            let _e444 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_429), (&param_430), (&param_431), (&param_432));
            let _e445 = (*currentIndex_7);
            param_433 = _e445;
            let _e446 = (*rawValue_6);
            param_434 = _e446;
            let _e447 = belowIndex_1;
            param_435 = _e447;
            param_436 = _e444;
            let _e448 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_433), (&param_434), (&param_435), (&param_436));
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
                    param_437 = _e457;
                    let _e458 = getAge_u0028_u1_u003b((&param_437));
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
                        param_438 = _e470;
                        let _e471 = getDir_u0028_u1_u003b((&param_438));
                        param_439 = 1u;
                        param_440 = _e471;
                        param_441 = 0u;
                        let _e472 = newMoisture;
                        param_442 = _e472;
                        let _e473 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_439), (&param_440), (&param_441), (&param_442));
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
                                param_443 = _e506;
                                let _e507 = getAge_u0028_u1_u003b((&param_443));
                                param_444 = 4u;
                                let _e508 = newFlora;
                                param_445 = _e508;
                                param_446 = 0u;
                                param_447 = _e507;
                                let _e509 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_444), (&param_445), (&param_446), (&param_447));
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
                                let _e528 = (*pos_10);
                                let _e529 = d_10;
                                param_448 = _e529;
                                let _e530 = getHDir_u0028_i1_u003b((&param_448));
                                targetPos_1 = (_e528 + _e530);
                                let _e533 = targetPos_1[0u];
                                let _e534 = (_e533 > 0i);
                                phi_8206_ = _e534;
                                if _e534 {
                                    let _e536 = targetPos_1[0u];
                                    let _e538 = tuning.gridWidth;
                                    phi_8206_ = (_e536 < (bitcast<i32>(_e538) - 1i));
                                }
                                let _e543 = phi_8206_;
                                phi_8212_ = _e543;
                                if _e543 {
                                    let _e545 = targetPos_1[2u];
                                    phi_8212_ = (_e545 > 0i);
                                }
                                let _e548 = phi_8212_;
                                phi_8222_ = _e548;
                                if _e548 {
                                    let _e550 = targetPos_1[2u];
                                    let _e552 = tuning.gridDepth;
                                    phi_8222_ = (_e550 < (bitcast<i32>(_e552) - 1i));
                                }
                                let _e557 = phi_8222_;
                                if _e557 {
                                    let _e558 = targetPos_1;
                                    param_449 = _e558;
                                    let _e559 = getIndex_u0028_vi3_u003b((&param_449));
                                    targetIndex_1 = _e559;
                                    let _e560 = targetIndex_1;
                                    param_450 = _e560;
                                    let _e561 = readCell_u0028_u1_u003b((&param_450));
                                    param_451 = _e561;
                                    let _e562 = getType_u0028_u1_u003b((&param_451));
                                    if (_e562 == 0u) {
                                        let _e564 = targetPos_1;
                                        targetBelow = (_e564 + vec3<i32>(0i, -1i, 0i));
                                        let _e566 = targetBelow;
                                        param_452 = _e566;
                                        let _e567 = getIndex_u0028_vi3_u003b((&param_452));
                                        param_453 = _e567;
                                        let _e568 = readCell_u0028_u1_u003b((&param_453));
                                        tBelowVal = _e568;
                                        let _e569 = tBelowVal;
                                        param_454 = _e569;
                                        let _e570 = getType_u0028_u1_u003b((&param_454));
                                        if (_e570 == 4u) {
                                            let _e572 = tBelowVal;
                                            tFlora = ((_e572 >> bitcast<u32>(8i)) & 255u);
                                            let _e576 = tFlora;
                                            let _e578 = tFlora;
                                            if ((_e576 > 10u) && (_e578 <= 100u)) {
                                                let _e581 = targetIndex_1;
                                                param_455 = 5u;
                                                param_456 = 0u;
                                                param_457 = 0u;
                                                param_458 = 0u;
                                                let _e584 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_455), (&param_456), (&param_457), (&param_458));
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
    param_459 = 5u;
    param_460 = 0u;
    param_461 = 0u;
    let _e599 = newAge_1;
    param_462 = _e599;
    let _e600 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_459), (&param_460), (&param_461), (&param_462));
    let _e601 = atomicCompareExchangeWeak((&unnamed.grid[_e595]), _e598, _e600);
    return;
}

fn isLocust_u0028_u1_u003b(type_38: ptr<function, u32>) -> bool {
    let _e205 = (*type_38);
    let _e207 = (*type_38);
    return ((_e205 >= 13u) && (_e207 <= 17u));
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

    let _e217 = (*currentIndex_8);
    let _e220 = (*currentValue_1);
    let _e221 = atomicCompareExchangeWeak((&unnamed.grid[_e217]), _e220, 0u);
    let _e223 = (*currentValue_1);
    if (_e221.old_value == _e223) {
        let _e225 = (*targetValue_1);
        param_463 = _e225;
        let _e226 = getType_u0028_u1_u003b((&param_463));
        param_464 = _e226;
        param_465 = 0u;
        param_466 = 0u;
        param_467 = 0u;
        let _e227 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_464), (&param_465), (&param_466), (&param_467));
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

    let _e214 = (*pos_11)[1u];
    if (_e214 <= 1i) {
        return false;
    }
    i_14 = 0i;
    loop {
        let _e216 = i_14;
        if (_e216 < 5i) {
            let _e218 = (*pos_11);
            let _e219 = i_14;
            if (_e219 == 1i) {
                local_18 = 1i;
            } else {
                let _e221 = i_14;
                local_18 = select(0i, -1i, (_e221 == 2i));
            }
            let _e224 = local_18;
            let _e225 = i_14;
            if (_e225 == 3i) {
                local_19 = 1i;
            } else {
                let _e227 = i_14;
                local_19 = select(0i, -1i, (_e227 == 4i));
            }
            let _e230 = local_19;
            target_1 = (_e218 + vec3<i32>(_e224, -1i, _e230));
            let _e234 = target_1[0u];
            let _e235 = (_e234 <= 0i);
            phi_2541_ = _e235;
            if !(_e235) {
                let _e238 = target_1[0u];
                let _e240 = tuning.gridWidth;
                phi_2541_ = (_e238 >= (bitcast<i32>(_e240) - 1i));
            }
            let _e245 = phi_2541_;
            phi_2548_ = _e245;
            if !(_e245) {
                let _e248 = target_1[2u];
                phi_2548_ = (_e248 <= 0i);
            }
            let _e251 = phi_2548_;
            phi_2559_ = _e251;
            if !(_e251) {
                let _e254 = target_1[2u];
                let _e256 = tuning.gridDepth;
                phi_2559_ = (_e254 >= (bitcast<i32>(_e256) - 1i));
            }
            let _e261 = phi_2559_;
            if _e261 {
                continue;
            }
            let _e262 = target_1;
            param_468 = _e262;
            let _e263 = getIndex_u0028_vi3_u003b((&param_468));
            param_469 = _e263;
            let _e264 = readCell_u0028_u1_u003b((&param_469));
            param_470 = _e264;
            let _e265 = getType_u0028_u1_u003b((&param_470));
            t_3 = _e265;
            let _e266 = t_3;
            let _e268 = t_3;
            if ((_e266 == 0u) || (_e268 == 2u)) {
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e271 = i_14;
            i_14 = (_e271 + 1i);
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

    let _e374 = (*currentAge_7);
    moisture_4 = _e374;
    moistureModified = false;
    let _e375 = moisture_4;
    let _e377 = tuning.dirtMoistureCapacity;
    if (_e375 < _e377) {
        let _e379 = (*randVal_9);
        startDir_1 = i32((fract((_e379 * 17f)) * 6f));
        i_15 = 0i;
        loop {
            let _e384 = i_15;
            if (_e384 < 6i) {
                let _e386 = startDir_1;
                let _e387 = i_15;
                let _e388 = (_e386 + _e387);
                d_11 = (_e388 - (i32(floor((f32(_e388) / f32(6i)))) * 6i));
                let _e396 = (*pos_12);
                let _e397 = d_11;
                param_471 = _e397;
                let _e398 = getOrthoDir_u0028_i1_u003b((&param_471));
                nPos_3 = (_e396 + _e398);
                let _e401 = nPos_3[0u];
                let _e402 = (_e401 > 0i);
                phi_3671_ = _e402;
                if _e402 {
                    let _e404 = nPos_3[0u];
                    let _e406 = tuning.gridWidth;
                    phi_3671_ = (_e404 < (bitcast<i32>(_e406) - 1i));
                }
                let _e411 = phi_3671_;
                phi_3677_ = _e411;
                if _e411 {
                    let _e413 = nPos_3[1u];
                    phi_3677_ = (_e413 > 0i);
                }
                let _e416 = phi_3677_;
                phi_3687_ = _e416;
                if _e416 {
                    let _e418 = nPos_3[1u];
                    let _e420 = tuning.gridHeight;
                    phi_3687_ = (_e418 < (bitcast<i32>(_e420) - 1i));
                }
                let _e425 = phi_3687_;
                phi_3693_ = _e425;
                if _e425 {
                    let _e427 = nPos_3[2u];
                    phi_3693_ = (_e427 > 0i);
                }
                let _e430 = phi_3693_;
                phi_3703_ = _e430;
                if _e430 {
                    let _e432 = nPos_3[2u];
                    let _e434 = tuning.gridDepth;
                    phi_3703_ = (_e432 < (bitcast<i32>(_e434) - 1i));
                }
                let _e439 = phi_3703_;
                if _e439 {
                    let _e440 = nPos_3;
                    param_472 = _e440;
                    let _e441 = getIndex_u0028_vi3_u003b((&param_472));
                    nIndex_3 = _e441;
                    let _e442 = nIndex_3;
                    param_473 = _e442;
                    let _e443 = readCell_u0028_u1_u003b((&param_473));
                    nVal_3 = _e443;
                    let _e444 = nVal_3;
                    param_474 = _e444;
                    let _e445 = getType_u0028_u1_u003b((&param_474));
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
                let _e463 = i_15;
                i_15 = (_e463 + 1i);
            }
        }
    }
    let _e465 = moistureModified;
    let _e467 = moisture_4;
    if (!(_e465) && (_e467 > 0u)) {
        let _e470 = (*randVal_9);
        d_12 = i32((fract((_e470 * 31f)) * 6f));
        let _e475 = (*pos_12);
        let _e476 = d_12;
        param_475 = _e476;
        let _e477 = getOrthoDir_u0028_i1_u003b((&param_475));
        nPos_4 = (_e475 + _e477);
        let _e480 = nPos_4[0u];
        let _e481 = (_e480 > 0i);
        phi_3769_ = _e481;
        if _e481 {
            let _e483 = nPos_4[0u];
            let _e485 = tuning.gridWidth;
            phi_3769_ = (_e483 < (bitcast<i32>(_e485) - 1i));
        }
        let _e490 = phi_3769_;
        phi_3775_ = _e490;
        if _e490 {
            let _e492 = nPos_4[1u];
            phi_3775_ = (_e492 > 0i);
        }
        let _e495 = phi_3775_;
        phi_3785_ = _e495;
        if _e495 {
            let _e497 = nPos_4[1u];
            let _e499 = tuning.gridHeight;
            phi_3785_ = (_e497 < (bitcast<i32>(_e499) - 1i));
        }
        let _e504 = phi_3785_;
        phi_3791_ = _e504;
        if _e504 {
            let _e506 = nPos_4[2u];
            phi_3791_ = (_e506 > 0i);
        }
        let _e509 = phi_3791_;
        phi_3801_ = _e509;
        if _e509 {
            let _e511 = nPos_4[2u];
            let _e513 = tuning.gridDepth;
            phi_3801_ = (_e511 < (bitcast<i32>(_e513) - 1i));
        }
        let _e518 = phi_3801_;
        if _e518 {
            let _e519 = nPos_4;
            param_476 = _e519;
            let _e520 = getIndex_u0028_vi3_u003b((&param_476));
            nIndex_4 = _e520;
            let _e521 = nIndex_4;
            param_477 = _e521;
            let _e522 = readCell_u0028_u1_u003b((&param_477));
            nVal_4 = _e522;
            let _e523 = nVal_4;
            param_478 = _e523;
            let _e524 = getType_u0028_u1_u003b((&param_478));
            nType_2 = _e524;
            let _e525 = nType_2;
            let _e527 = nType_2;
            if ((_e525 == 4u) || (_e527 == 1u)) {
                let _e530 = nVal_4;
                param_479 = _e530;
                let _e531 = getAge_u0028_u1_u003b((&param_479));
                nMoisture = _e531;
                let _e532 = nType_2;
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
    let _e556 = (*pos_12);
    param_480 = _e556;
    let _e557 = grainCanMove_u0028_vi3_u003b((&param_480));
    canMove = _e557;
    isClumped = false;
    let _e558 = canMove;
    phi_3871_ = _e558;
    if _e558 {
        let _e559 = (*currentSleep_4);
        let _e561 = tuning.wakeSleepThreshold;
        phi_3871_ = (_e559 > _e561);
    }
    let _e564 = phi_3871_;
    if _e564 {
        emptyBelowCount = 0i;
        let _e566 = (*pos_12)[1u];
        if (_e566 > 1i) {
            x = -1i;
            loop {
                let _e568 = x;
                if (_e568 <= 1i) {
                    z = -1i;
                    loop {
                        let _e570 = z;
                        if (_e570 <= 1i) {
                            let _e572 = (*pos_12);
                            let _e573 = x;
                            let _e574 = z;
                            checkPos_1 = (_e572 + vec3<i32>(_e573, -1i, _e574));
                            let _e578 = checkPos_1[0u];
                            let _e579 = (_e578 >= 0i);
                            phi_3913_ = _e579;
                            if _e579 {
                                let _e581 = checkPos_1[0u];
                                let _e583 = tuning.gridWidth;
                                phi_3913_ = (_e581 < bitcast<i32>(_e583));
                            }
                            let _e587 = phi_3913_;
                            phi_3919_ = _e587;
                            if _e587 {
                                let _e589 = checkPos_1[2u];
                                phi_3919_ = (_e589 >= 0i);
                            }
                            let _e592 = phi_3919_;
                            phi_3928_ = _e592;
                            if _e592 {
                                let _e594 = checkPos_1[2u];
                                let _e596 = tuning.gridDepth;
                                phi_3928_ = (_e594 < bitcast<i32>(_e596));
                            }
                            let _e600 = phi_3928_;
                            if _e600 {
                                let _e601 = checkPos_1;
                                param_481 = _e601;
                                let _e602 = getIndex_u0028_vi3_u003b((&param_481));
                                param_482 = _e602;
                                let _e603 = readCell_u0028_u1_u003b((&param_482));
                                param_483 = _e603;
                                let _e604 = getType_u0028_u1_u003b((&param_483));
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
                                    let _e631 = (*pos_12);
                                    let _e632 = x_1;
                                    let _e633 = y;
                                    let _e634 = z_1;
                                    nPos_5 = (_e631 + vec3<i32>(_e632, _e633, _e634));
                                    let _e638 = nPos_5[0u];
                                    let _e639 = (_e638 >= 0i);
                                    phi_4009_ = _e639;
                                    if _e639 {
                                        let _e641 = nPos_5[0u];
                                        let _e643 = tuning.gridWidth;
                                        phi_4009_ = (_e641 < bitcast<i32>(_e643));
                                    }
                                    let _e647 = phi_4009_;
                                    phi_4015_ = _e647;
                                    if _e647 {
                                        let _e649 = nPos_5[1u];
                                        phi_4015_ = (_e649 >= 0i);
                                    }
                                    let _e652 = phi_4015_;
                                    phi_4024_ = _e652;
                                    if _e652 {
                                        let _e654 = nPos_5[1u];
                                        let _e656 = tuning.gridHeight;
                                        phi_4024_ = (_e654 < bitcast<i32>(_e656));
                                    }
                                    let _e660 = phi_4024_;
                                    phi_4030_ = _e660;
                                    if _e660 {
                                        let _e662 = nPos_5[2u];
                                        phi_4030_ = (_e662 >= 0i);
                                    }
                                    let _e665 = phi_4030_;
                                    phi_4039_ = _e665;
                                    if _e665 {
                                        let _e667 = nPos_5[2u];
                                        let _e669 = tuning.gridDepth;
                                        phi_4039_ = (_e667 < bitcast<i32>(_e669));
                                    }
                                    let _e673 = phi_4039_;
                                    if _e673 {
                                        let _e674 = nPos_5;
                                        param_484 = _e674;
                                        let _e675 = getIndex_u0028_vi3_u003b((&param_484));
                                        param_485 = _e675;
                                        let _e676 = readCell_u0028_u1_u003b((&param_485));
                                        param_486 = _e676;
                                        let _e677 = getType_u0028_u1_u003b((&param_486));
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
        let _e697 = (*pos_12)[1u];
        if (_e697 > 1i) {
            let _e699 = (*pos_12);
            belowPos_5 = (_e699 + vec3<i32>(0i, -1i, 0i));
            let _e701 = belowPos_5;
            param_487 = _e701;
            let _e702 = getIndex_u0028_vi3_u003b((&param_487));
            param_488 = _e702;
            let _e703 = readCell_u0028_u1_u003b((&param_488));
            param_489 = _e703;
            let _e704 = getType_u0028_u1_u003b((&param_489));
            if (_e704 == 0u) {
                let _e706 = belowPos_5;
                param_490 = _e706;
                let _e707 = getIndex_u0028_vi3_u003b((&param_490));
                param_491 = 4u;
                param_492 = 0u;
                param_493 = 0u;
                let _e708 = moisture_4;
                param_494 = _e708;
                let _e709 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_491), (&param_492), (&param_493), (&param_494));
                let _e710 = (*currentIndex_9);
                param_495 = _e710;
                let _e711 = (*rawValue_7);
                param_496 = _e711;
                param_497 = _e707;
                param_498 = _e709;
                let _e712 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_495), (&param_496), (&param_497), (&param_498));
                if _e712 {
                    return;
                }
            }
        }
        let _e714 = (*pos_12)[1u];
        if (_e714 > 1i) {
            let _e716 = (*randVal_9);
            dir_2 = select(-1i, 1i, (fract((_e716 * 10f)) > 0.5f));
            let _e721 = (*randVal_9);
            if (fract((_e721 * 100f)) > 0.5f) {
                let _e725 = (*pos_12);
                let _e726 = dir_2;
                slidePos1_ = (_e725 + vec3<i32>(_e726, -1i, 0i));
                let _e729 = (*pos_12);
                let _e730 = dir_2;
                slidePos2_ = (_e729 + vec3<i32>(0i, -1i, _e730));
            } else {
                let _e733 = (*pos_12);
                let _e734 = dir_2;
                slidePos1_ = (_e733 + vec3<i32>(0i, -1i, _e734));
                let _e737 = (*pos_12);
                let _e738 = dir_2;
                slidePos2_ = (_e737 + vec3<i32>(_e738, -1i, 0i));
            }
            let _e742 = slidePos1_[0u];
            let _e743 = (_e742 > 0i);
            phi_4158_ = _e743;
            if _e743 {
                let _e745 = slidePos1_[0u];
                let _e747 = tuning.gridWidth;
                phi_4158_ = (_e745 < (bitcast<i32>(_e747) - 1i));
            }
            let _e752 = phi_4158_;
            phi_4164_ = _e752;
            if _e752 {
                let _e754 = slidePos1_[2u];
                phi_4164_ = (_e754 > 0i);
            }
            let _e757 = phi_4164_;
            phi_4174_ = _e757;
            if _e757 {
                let _e759 = slidePos1_[2u];
                let _e761 = tuning.gridDepth;
                phi_4174_ = (_e759 < (bitcast<i32>(_e761) - 1i));
            }
            let _e766 = phi_4174_;
            if _e766 {
                let _e767 = slidePos1_;
                param_499 = _e767;
                let _e768 = getIndex_u0028_vi3_u003b((&param_499));
                param_500 = _e768;
                let _e769 = readCell_u0028_u1_u003b((&param_500));
                param_501 = _e769;
                let _e770 = getType_u0028_u1_u003b((&param_501));
                if (_e770 == 0u) {
                    let _e772 = slidePos1_;
                    param_502 = _e772;
                    let _e773 = getIndex_u0028_vi3_u003b((&param_502));
                    param_503 = 4u;
                    param_504 = 0u;
                    param_505 = 0u;
                    let _e774 = moisture_4;
                    param_506 = _e774;
                    let _e775 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_503), (&param_504), (&param_505), (&param_506));
                    let _e776 = (*currentIndex_9);
                    param_507 = _e776;
                    let _e777 = (*rawValue_7);
                    param_508 = _e777;
                    param_509 = _e773;
                    param_510 = _e775;
                    let _e778 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_507), (&param_508), (&param_509), (&param_510));
                    if _e778 {
                        return;
                    }
                }
            }
            let _e780 = slidePos2_[0u];
            let _e781 = (_e780 > 0i);
            phi_4218_ = _e781;
            if _e781 {
                let _e783 = slidePos2_[0u];
                let _e785 = tuning.gridWidth;
                phi_4218_ = (_e783 < (bitcast<i32>(_e785) - 1i));
            }
            let _e790 = phi_4218_;
            phi_4224_ = _e790;
            if _e790 {
                let _e792 = slidePos2_[2u];
                phi_4224_ = (_e792 > 0i);
            }
            let _e795 = phi_4224_;
            phi_4234_ = _e795;
            if _e795 {
                let _e797 = slidePos2_[2u];
                let _e799 = tuning.gridDepth;
                phi_4234_ = (_e797 < (bitcast<i32>(_e799) - 1i));
            }
            let _e804 = phi_4234_;
            if _e804 {
                let _e805 = slidePos2_;
                param_511 = _e805;
                let _e806 = getIndex_u0028_vi3_u003b((&param_511));
                param_512 = _e806;
                let _e807 = readCell_u0028_u1_u003b((&param_512));
                param_513 = _e807;
                let _e808 = getType_u0028_u1_u003b((&param_513));
                if (_e808 == 0u) {
                    let _e810 = slidePos2_;
                    param_514 = _e810;
                    let _e811 = getIndex_u0028_vi3_u003b((&param_514));
                    param_515 = 4u;
                    param_516 = 0u;
                    param_517 = 0u;
                    let _e812 = moisture_4;
                    param_518 = _e812;
                    let _e813 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_515), (&param_516), (&param_517), (&param_518));
                    let _e814 = (*currentIndex_9);
                    param_519 = _e814;
                    let _e815 = (*rawValue_7);
                    param_520 = _e815;
                    param_521 = _e811;
                    param_522 = _e813;
                    let _e816 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_519), (&param_520), (&param_521), (&param_522));
                    if _e816 {
                        return;
                    }
                }
            }
        }
        let _e818 = (*pos_12)[1u];
        if (_e818 > 1i) {
            let _e820 = (*pos_12);
            belowPos_6 = (_e820 + vec3<i32>(0i, -1i, 0i));
            let _e822 = belowPos_6;
            param_523 = _e822;
            let _e823 = getIndex_u0028_vi3_u003b((&param_523));
            belowIndex_2 = _e823;
            let _e824 = belowIndex_2;
            param_524 = _e824;
            let _e825 = readCell_u0028_u1_u003b((&param_524));
            belowValue_2 = _e825;
            let _e826 = belowValue_2;
            param_525 = _e826;
            let _e827 = getType_u0028_u1_u003b((&param_525));
            if (_e827 == 2u) {
                let _e829 = (*randVal_9);
                startDir_2 = i32((fract((_e829 * 8f)) * 8f));
                i_16 = 0i;
                loop {
                    let _e834 = i_16;
                    if (_e834 < 8i) {
                        let _e836 = startDir_2;
                        let _e837 = i_16;
                        let _e838 = (_e836 + _e837);
                        d_13 = (_e838 - (i32(floor((f32(_e838) / f32(8i)))) * 8i));
                        let _e846 = belowPos_6;
                        let _e847 = d_13;
                        param_526 = _e847;
                        let _e848 = getHDir_u0028_i1_u003b((&param_526));
                        pushPos = (_e846 + _e848);
                        let _e851 = pushPos[0u];
                        let _e852 = (_e851 > 0i);
                        phi_4325_ = _e852;
                        if _e852 {
                            let _e854 = pushPos[0u];
                            let _e856 = tuning.gridWidth;
                            phi_4325_ = (_e854 < (bitcast<i32>(_e856) - 1i));
                        }
                        let _e861 = phi_4325_;
                        phi_4331_ = _e861;
                        if _e861 {
                            let _e863 = pushPos[2u];
                            phi_4331_ = (_e863 > 0i);
                        }
                        let _e866 = phi_4331_;
                        phi_4341_ = _e866;
                        if _e866 {
                            let _e868 = pushPos[2u];
                            let _e870 = tuning.gridDepth;
                            phi_4341_ = (_e868 < (bitcast<i32>(_e870) - 1i));
                        }
                        let _e875 = phi_4341_;
                        if _e875 {
                            param_527 = 4u;
                            param_528 = 0u;
                            param_529 = 0u;
                            let _e876 = moisture_4;
                            param_530 = _e876;
                            let _e877 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_527), (&param_528), (&param_529), (&param_530));
                            let _e878 = pushPos;
                            param_531 = _e878;
                            let _e879 = getIndex_u0028_vi3_u003b((&param_531));
                            let _e880 = (*currentIndex_9);
                            param_532 = _e880;
                            param_533 = _e877;
                            let _e881 = belowIndex_2;
                            param_534 = _e881;
                            let _e882 = belowValue_2;
                            param_535 = _e882;
                            param_536 = _e879;
                            let _e883 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_532), (&param_533), (&param_534), (&param_535), (&param_536));
                            if _e883 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e884 = i_16;
                        i_16 = (_e884 + 1i);
                    }
                }
                param_537 = 4u;
                param_538 = 0u;
                param_539 = 0u;
                let _e886 = moisture_4;
                param_540 = _e886;
                let _e887 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_537), (&param_538), (&param_539), (&param_540));
                let _e888 = (*currentIndex_9);
                param_541 = _e888;
                let _e889 = (*rawValue_7);
                param_542 = _e889;
                let _e890 = belowIndex_2;
                param_543 = _e890;
                param_544 = _e887;
                let _e891 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_541), (&param_542), (&param_543), (&param_544));
                if _e891 {
                    return;
                }
            }
            let _e892 = (*randVal_9);
            dir_3 = select(-1i, 1i, (fract((_e892 * 10f)) > 0.5f));
            let _e897 = (*randVal_9);
            if (fract((_e897 * 100f)) > 0.5f) {
                let _e901 = (*pos_12);
                let _e902 = dir_3;
                slidePos[0i] = (_e901 + vec3<i32>(_e902, -1i, 0i));
                let _e906 = (*pos_12);
                let _e907 = dir_3;
                slidePos[1i] = (_e906 + vec3<i32>(0i, -1i, _e907));
            } else {
                let _e911 = (*pos_12);
                let _e912 = dir_3;
                slidePos[0i] = (_e911 + vec3<i32>(0i, -1i, _e912));
                let _e916 = (*pos_12);
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
                    phi_4442_ = _e928;
                    if _e928 {
                        let _e930 = sPos_2[0u];
                        let _e932 = tuning.gridWidth;
                        phi_4442_ = (_e930 < (bitcast<i32>(_e932) - 1i));
                    }
                    let _e937 = phi_4442_;
                    phi_4448_ = _e937;
                    if _e937 {
                        let _e939 = sPos_2[2u];
                        phi_4448_ = (_e939 > 0i);
                    }
                    let _e942 = phi_4448_;
                    phi_4458_ = _e942;
                    if _e942 {
                        let _e944 = sPos_2[2u];
                        let _e946 = tuning.gridDepth;
                        phi_4458_ = (_e944 < (bitcast<i32>(_e946) - 1i));
                    }
                    let _e951 = phi_4458_;
                    if _e951 {
                        let _e952 = sPos_2;
                        param_545 = _e952;
                        let _e953 = getIndex_u0028_vi3_u003b((&param_545));
                        sIndex = _e953;
                        let _e954 = sIndex;
                        param_546 = _e954;
                        let _e955 = readCell_u0028_u1_u003b((&param_546));
                        sValue = _e955;
                        let _e956 = sValue;
                        param_547 = _e956;
                        let _e957 = getType_u0028_u1_u003b((&param_547));
                        if (_e957 == 2u) {
                            let _e959 = (*randVal_9);
                            let _e961 = s_1;
                            startDir_3 = i32((fract(((_e959 * 8f) + f32(_e961))) * 8f));
                            i_17 = 0i;
                            loop {
                                let _e967 = i_17;
                                if (_e967 < 8i) {
                                    let _e969 = startDir_3;
                                    let _e970 = i_17;
                                    let _e971 = (_e969 + _e970);
                                    d_14 = (_e971 - (i32(floor((f32(_e971) / f32(8i)))) * 8i));
                                    let _e979 = sPos_2;
                                    let _e980 = d_14;
                                    param_548 = _e980;
                                    let _e981 = getHDir_u0028_i1_u003b((&param_548));
                                    pushPos_1 = (_e979 + _e981);
                                    let _e984 = pushPos_1[0u];
                                    let _e985 = (_e984 > 0i);
                                    phi_4515_ = _e985;
                                    if _e985 {
                                        let _e987 = pushPos_1[0u];
                                        let _e989 = tuning.gridWidth;
                                        phi_4515_ = (_e987 < (bitcast<i32>(_e989) - 1i));
                                    }
                                    let _e994 = phi_4515_;
                                    phi_4521_ = _e994;
                                    if _e994 {
                                        let _e996 = pushPos_1[2u];
                                        phi_4521_ = (_e996 > 0i);
                                    }
                                    let _e999 = phi_4521_;
                                    phi_4531_ = _e999;
                                    if _e999 {
                                        let _e1001 = pushPos_1[2u];
                                        let _e1003 = tuning.gridDepth;
                                        phi_4531_ = (_e1001 < (bitcast<i32>(_e1003) - 1i));
                                    }
                                    let _e1008 = phi_4531_;
                                    if _e1008 {
                                        param_549 = 4u;
                                        param_550 = 0u;
                                        param_551 = 0u;
                                        let _e1009 = moisture_4;
                                        param_552 = _e1009;
                                        let _e1010 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_549), (&param_550), (&param_551), (&param_552));
                                        let _e1011 = pushPos_1;
                                        param_553 = _e1011;
                                        let _e1012 = getIndex_u0028_vi3_u003b((&param_553));
                                        let _e1013 = (*currentIndex_9);
                                        param_554 = _e1013;
                                        param_555 = _e1010;
                                        let _e1014 = sIndex;
                                        param_556 = _e1014;
                                        let _e1015 = sValue;
                                        param_557 = _e1015;
                                        param_558 = _e1012;
                                        let _e1016 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_554), (&param_555), (&param_556), (&param_557), (&param_558));
                                        if _e1016 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1017 = i_17;
                                    i_17 = (_e1017 + 1i);
                                }
                            }
                            param_559 = 4u;
                            param_560 = 0u;
                            param_561 = 0u;
                            let _e1019 = moisture_4;
                            param_562 = _e1019;
                            let _e1020 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_559), (&param_560), (&param_561), (&param_562));
                            let _e1021 = (*currentIndex_9);
                            param_563 = _e1021;
                            let _e1022 = (*rawValue_7);
                            param_564 = _e1022;
                            let _e1023 = sIndex;
                            param_565 = _e1023;
                            param_566 = _e1020;
                            let _e1024 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_563), (&param_564), (&param_565), (&param_566));
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
    phi_4586_ = _e1028;
    if !(_e1028) {
        let _e1030 = (*currentSleep_4);
        let _e1032 = tuning.wakeSleepThreshold;
        phi_4586_ = (_e1030 > _e1032);
    }
    let _e1035 = phi_4586_;
    if _e1035 {
        let _e1036 = (*pos_12);
        abovePos_1 = (_e1036 + vec3<i32>(0i, 1i, 0i));
        let _e1039 = abovePos_1[1u];
        let _e1041 = tuning.gridHeight;
        aboveInside = (_e1039 < (bitcast<i32>(_e1041) - 1i));
        let _e1045 = abovePos_1;
        param_567 = _e1045;
        let _e1046 = getIndex_u0028_vi3_u003b((&param_567));
        aboveIndex = _e1046;
        let _e1047 = aboveInside;
        if _e1047 {
            let _e1048 = aboveIndex;
            param_568 = _e1048;
            let _e1049 = readCell_u0028_u1_u003b((&param_568));
            param_569 = _e1049;
            let _e1050 = getType_u0028_u1_u003b((&param_569));
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
                    phi_4660_ = _e1077;
                    if _e1077 {
                        let _e1078 = (*randVal_9);
                        let _e1082 = tuning.treeBloomChance;
                        phi_4660_ = (fract((_e1078 * 97f)) < _e1082);
                    }
                    let _e1085 = phi_4660_;
                    if _e1085 {
                        let _e1086 = aboveIndex;
                        param_570 = 18u;
                        param_571 = 0u;
                        param_572 = 0u;
                        param_573 = 0u;
                        let _e1089 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_570), (&param_571), (&param_572), (&param_573));
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
                phi_4715_ = _e1112;
                if _e1112 {
                    let _e1113 = aboveType;
                    param_574 = _e1113;
                    let _e1114 = isLocust_u0028_u1_u003b((&param_574));
                    phi_4715_ = !(_e1114);
                }
                let _e1117 = phi_4715_;
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
    param_575 = 4u;
    let _e1125 = floraState;
    param_576 = _e1125;
    let _e1126 = newSleep_2;
    param_577 = _e1126;
    let _e1127 = moisture_4;
    param_578 = _e1127;
    let _e1128 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_575), (&param_576), (&param_577), (&param_578));
    let _e1129 = atomicCompareExchangeWeak((&unnamed.grid[_e1121]), _e1124, _e1128);
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

    let _e338 = (*currentSleep_5);
    let _e340 = tuning.wakeSleepThreshold;
    if (_e338 > _e340) {
        wake = false;
        let _e343 = (*pos_13)[1u];
        let _e344 = (_e343 > 1i);
        phi_4755_ = _e344;
        if _e344 {
            let _e345 = (*pos_13);
            param_579 = (_e345 + vec3<i32>(0i, -1i, 0i));
            let _e347 = getIndex_u0028_vi3_u003b((&param_579));
            param_580 = _e347;
            let _e348 = readCell_u0028_u1_u003b((&param_580));
            param_581 = _e348;
            let _e349 = getType_u0028_u1_u003b((&param_581));
            phi_4755_ = (_e349 == 0u);
        }
        let _e352 = phi_4755_;
        if _e352 {
            wake = true;
        } else {
            let _e354 = (*pos_13)[1u];
            let _e356 = tuning.gridHeight;
            if (_e354 < (bitcast<i32>(_e356) - 2i)) {
                let _e360 = (*pos_13);
                param_582 = (_e360 + vec3<i32>(0i, 1i, 0i));
                let _e362 = getIndex_u0028_vi3_u003b((&param_582));
                param_583 = _e362;
                let _e363 = readCell_u0028_u1_u003b((&param_583));
                param_584 = _e363;
                let _e364 = getType_u0028_u1_u003b((&param_584));
                local_22 = (_e364 != 0u);
            } else {
                local_22 = false;
            }
            let _e366 = local_22;
            hasPressure_1 = _e366;
            let _e368 = (*pos_13)[1u];
            if (_e368 > 1i) {
                let _e370 = (*pos_13);
                param_585 = (_e370 + vec3<i32>(0i, -1i, 0i));
                let _e372 = getIndex_u0028_vi3_u003b((&param_585));
                param_586 = _e372;
                let _e373 = readCell_u0028_u1_u003b((&param_586));
                param_587 = _e373;
                let _e374 = getType_u0028_u1_u003b((&param_587));
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
                    let _e379 = (*pos_13);
                    let _e380 = d_15;
                    param_588 = _e380;
                    let _e381 = getHDir_u0028_i1_u003b((&param_588));
                    nPos_6 = (_e379 + _e381);
                    let _e384 = nPos_6[0u];
                    let _e385 = (_e384 > 0i);
                    phi_4825_ = _e385;
                    if _e385 {
                        let _e387 = nPos_6[0u];
                        let _e389 = tuning.gridWidth;
                        phi_4825_ = (_e387 < (bitcast<i32>(_e389) - 1i));
                    }
                    let _e394 = phi_4825_;
                    phi_4831_ = _e394;
                    if _e394 {
                        let _e396 = nPos_6[2u];
                        phi_4831_ = (_e396 > 0i);
                    }
                    let _e399 = phi_4831_;
                    phi_4841_ = _e399;
                    if _e399 {
                        let _e401 = nPos_6[2u];
                        let _e403 = tuning.gridDepth;
                        phi_4841_ = (_e401 < (bitcast<i32>(_e403) - 1i));
                    }
                    let _e408 = phi_4841_;
                    if _e408 {
                        let _e409 = nPos_6;
                        param_589 = _e409;
                        let _e410 = getIndex_u0028_vi3_u003b((&param_589));
                        param_590 = _e410;
                        let _e411 = readCell_u0028_u1_u003b((&param_590));
                        param_591 = _e411;
                        let _e412 = getType_u0028_u1_u003b((&param_591));
                        if (_e412 == 0u) {
                            let _e414 = nPos_6;
                            param_592 = (_e414 + vec3<i32>(0i, -1i, 0i));
                            let _e416 = getIndex_u0028_vi3_u003b((&param_592));
                            param_593 = _e416;
                            let _e417 = readCell_u0028_u1_u003b((&param_593));
                            param_594 = _e417;
                            let _e418 = getType_u0028_u1_u003b((&param_594));
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
    let _e435 = (*pos_13)[1u];
    if (_e435 > 1i) {
        let _e437 = (*pos_13);
        belowPos_7 = (_e437 + vec3<i32>(0i, -1i, 0i));
        let _e439 = belowPos_7;
        param_595 = _e439;
        let _e440 = getIndex_u0028_vi3_u003b((&param_595));
        param_596 = _e440;
        let _e441 = readCell_u0028_u1_u003b((&param_596));
        param_597 = _e441;
        let _e442 = getType_u0028_u1_u003b((&param_597));
        if (_e442 == 0u) {
            let _e444 = belowPos_7;
            param_598 = _e444;
            let _e445 = getIndex_u0028_vi3_u003b((&param_598));
            param_599 = 2u;
            param_600 = 0u;
            param_601 = 0u;
            let _e446 = newAge_2;
            param_602 = _e446;
            let _e447 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_599), (&param_600), (&param_601), (&param_602));
            let _e448 = (*currentIndex_10);
            param_603 = _e448;
            let _e449 = (*rawValue_8);
            param_604 = _e449;
            param_605 = _e445;
            param_606 = _e447;
            let _e450 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_603), (&param_604), (&param_605), (&param_606));
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
        let _e501 = (*pos_13);
        let _e502 = diagDir;
        param_607 = (bitcast<i32>(_e502) - 1i);
        let _e505 = getHDir_u0028_i1_u003b((&param_607));
        stepPos = (_e501 + _e505);
        let _e508 = stepPos[0u];
        let _e509 = (_e508 > 0i);
        phi_5026_ = _e509;
        if _e509 {
            let _e511 = stepPos[0u];
            let _e513 = tuning.gridWidth;
            phi_5026_ = (_e511 < (bitcast<i32>(_e513) - 1i));
        }
        let _e518 = phi_5026_;
        phi_5032_ = _e518;
        if _e518 {
            let _e520 = stepPos[2u];
            phi_5032_ = (_e520 > 0i);
        }
        let _e523 = phi_5032_;
        phi_5042_ = _e523;
        if _e523 {
            let _e525 = stepPos[2u];
            let _e527 = tuning.gridDepth;
            phi_5042_ = (_e525 < (bitcast<i32>(_e527) - 1i));
        }
        let _e532 = phi_5042_;
        if _e532 {
            let _e533 = stepPos;
            param_608 = _e533;
            let _e534 = getIndex_u0028_vi3_u003b((&param_608));
            param_609 = _e534;
            let _e535 = readCell_u0028_u1_u003b((&param_609));
            param_610 = _e535;
            let _e536 = getType_u0028_u1_u003b((&param_610));
            if (_e536 == 0u) {
                param_611 = 2u;
                let _e538 = newDir;
                param_612 = _e538;
                param_613 = 0u;
                let _e539 = newAge_2;
                param_614 = _e539;
                let _e540 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_611), (&param_612), (&param_613), (&param_614));
                newValue_1 = _e540;
                let _e541 = stepPos;
                param_615 = _e541;
                let _e542 = getIndex_u0028_vi3_u003b((&param_615));
                let _e543 = (*currentIndex_10);
                param_616 = _e543;
                let _e544 = (*rawValue_8);
                param_617 = _e544;
                param_618 = _e542;
                let _e545 = newValue_1;
                param_619 = _e545;
                let _e546 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_616), (&param_617), (&param_618), (&param_619));
                if _e546 {
                    return;
                }
            }
        }
    }
    let _e547 = (*pos_13);
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
            i_18 = 0i;
            loop {
                let _e570 = i_18;
                if (_e570 < 8i) {
                    let _e572 = startDir_4;
                    let _e573 = i_18;
                    let _e574 = (_e572 + _e573);
                    d_16 = (_e574 - (i32(floor((f32(_e574) / f32(8i)))) * 8i));
                    let _e582 = blockedMask_1;
                    let _e583 = d_16;
                    if ((_e582 & (1u << bitcast<u32>(_e583))) == 0u) {
                        let _e588 = (*pos_13);
                        let _e589 = d_16;
                        param_620 = _e589;
                        let _e590 = getHDir_u0028_i1_u003b((&param_620));
                        let _e591 = r_3;
                        c_7 = (_e588 + (_e590 * vec3(_e591)));
                        let _e596 = c_7[0u];
                        let _e597 = (_e596 <= 0i);
                        phi_5157_ = _e597;
                        if !(_e597) {
                            let _e600 = c_7[0u];
                            let _e602 = tuning.gridWidth;
                            phi_5157_ = (_e600 >= (bitcast<i32>(_e602) - 1i));
                        }
                        let _e607 = phi_5157_;
                        phi_5164_ = _e607;
                        if !(_e607) {
                            let _e610 = c_7[2u];
                            phi_5164_ = (_e610 <= 0i);
                        }
                        let _e613 = phi_5164_;
                        phi_5175_ = _e613;
                        if !(_e613) {
                            let _e616 = c_7[2u];
                            let _e618 = tuning.gridDepth;
                            phi_5175_ = (_e616 >= (bitcast<i32>(_e618) - 1i));
                        }
                        let _e623 = phi_5175_;
                        phi_5187_ = _e623;
                        if !(_e623) {
                            let _e625 = c_7;
                            param_621 = _e625;
                            let _e626 = getIndex_u0028_vi3_u003b((&param_621));
                            param_622 = _e626;
                            let _e627 = readCell_u0028_u1_u003b((&param_622));
                            param_623 = _e627;
                            let _e628 = getType_u0028_u1_u003b((&param_623));
                            phi_5187_ = (_e628 != 0u);
                        }
                        let _e631 = phi_5187_;
                        if _e631 {
                            let _e632 = d_16;
                            let _e635 = blockedMask_1;
                            blockedMask_1 = (_e635 | (1u << bitcast<u32>(_e632)));
                        } else {
                            let _e638 = c_7[1u];
                            let _e639 = (_e638 > 1i);
                            phi_5209_ = _e639;
                            if _e639 {
                                let _e640 = c_7;
                                param_624 = (_e640 + vec3<i32>(0i, -1i, 0i));
                                let _e642 = getIndex_u0028_vi3_u003b((&param_624));
                                param_625 = _e642;
                                let _e643 = readCell_u0028_u1_u003b((&param_625));
                                param_626 = _e643;
                                let _e644 = getType_u0028_u1_u003b((&param_626));
                                phi_5209_ = (_e644 == 0u);
                            }
                            let _e647 = phi_5209_;
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
                    let _e649 = i_18;
                    i_18 = (_e649 + 1i);
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
        param_627 = 2u;
        param_628 = 0u;
        param_629 = 0u;
        param_630 = 0u;
        let _e655 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_627), (&param_628), (&param_629), (&param_630));
        newValue_2 = _e655;
        let _e656 = bestDropPos;
        param_631 = _e656;
        let _e657 = getIndex_u0028_vi3_u003b((&param_631));
        let _e658 = (*currentIndex_10);
        param_632 = _e658;
        let _e659 = (*rawValue_8);
        param_633 = _e659;
        param_634 = _e657;
        let _e660 = newValue_2;
        param_635 = _e660;
        let _e661 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_632), (&param_633), (&param_634), (&param_635));
        if _e661 {
            return;
        }
    } else {
        let _e663 = (*pos_13)[1u];
        let _e665 = tuning.gridHeight;
        if (_e663 < (bitcast<i32>(_e665) - 2i)) {
            let _e669 = (*pos_13);
            param_636 = (_e669 + vec3<i32>(0i, 1i, 0i));
            let _e671 = getIndex_u0028_vi3_u003b((&param_636));
            param_637 = _e671;
            let _e672 = readCell_u0028_u1_u003b((&param_637));
            param_638 = _e672;
            let _e673 = getType_u0028_u1_u003b((&param_638));
            local_24 = (_e673 != 0u);
        } else {
            local_24 = false;
        }
        let _e675 = local_24;
        hasPressure_2 = _e675;
        let _e677 = (*pos_13)[1u];
        if (_e677 > 1i) {
            let _e679 = (*pos_13);
            param_639 = (_e679 + vec3<i32>(0i, -1i, 0i));
            let _e681 = getIndex_u0028_vi3_u003b((&param_639));
            param_640 = _e681;
            let _e682 = readCell_u0028_u1_u003b((&param_640));
            param_641 = _e682;
            let _e683 = getType_u0028_u1_u003b((&param_641));
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
                let _e688 = (*pos_13);
                let _e689 = d_17;
                param_642 = _e689;
                let _e690 = getHDir_u0028_i1_u003b((&param_642));
                nPos_7 = (_e688 + _e690);
                let _e693 = nPos_7[0u];
                let _e694 = (_e693 > 0i);
                phi_5313_ = _e694;
                if _e694 {
                    let _e696 = nPos_7[0u];
                    let _e698 = tuning.gridWidth;
                    phi_5313_ = (_e696 < (bitcast<i32>(_e698) - 1i));
                }
                let _e703 = phi_5313_;
                phi_5319_ = _e703;
                if _e703 {
                    let _e705 = nPos_7[2u];
                    phi_5319_ = (_e705 > 0i);
                }
                let _e708 = phi_5319_;
                phi_5329_ = _e708;
                if _e708 {
                    let _e710 = nPos_7[2u];
                    let _e712 = tuning.gridDepth;
                    phi_5329_ = (_e710 < (bitcast<i32>(_e712) - 1i));
                }
                let _e717 = phi_5329_;
                if _e717 {
                    let _e718 = nPos_7;
                    param_643 = _e718;
                    let _e719 = getIndex_u0028_vi3_u003b((&param_643));
                    param_644 = _e719;
                    let _e720 = readCell_u0028_u1_u003b((&param_644));
                    param_645 = _e720;
                    let _e721 = getType_u0028_u1_u003b((&param_645));
                    let _e722 = (_e721 == 0u);
                    phi_5345_ = _e722;
                    if _e722 {
                        let _e724 = (*pos_13)[1u];
                        phi_5345_ = (_e724 > 1i);
                    }
                    let _e727 = phi_5345_;
                    phi_5357_ = _e727;
                    if _e727 {
                        let _e728 = nPos_7;
                        param_646 = (_e728 + vec3<i32>(0i, -1i, 0i));
                        let _e730 = getIndex_u0028_vi3_u003b((&param_646));
                        param_647 = _e730;
                        let _e731 = readCell_u0028_u1_u003b((&param_647));
                        param_648 = _e731;
                        let _e732 = getType_u0028_u1_u003b((&param_648));
                        phi_5357_ = (_e732 == 2u);
                    }
                    let _e735 = phi_5357_;
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
            i_19 = 0i;
            loop {
                let _e748 = i_19;
                if (_e748 < 8i) {
                    let _e750 = startSpreadDir;
                    let _e751 = i_19;
                    let _e752 = (_e750 + _e751);
                    d_18 = (_e752 - (i32(floor((f32(_e752) / f32(8i)))) * 8i));
                    let _e760 = (*pos_13);
                    let _e761 = d_18;
                    param_649 = _e761;
                    let _e762 = getHDir_u0028_i1_u003b((&param_649));
                    targetPos_2 = (_e760 + _e762);
                    let _e765 = targetPos_2[0u];
                    let _e766 = (_e765 > 0i);
                    phi_5407_ = _e766;
                    if _e766 {
                        let _e768 = targetPos_2[0u];
                        let _e770 = tuning.gridWidth;
                        phi_5407_ = (_e768 < (bitcast<i32>(_e770) - 1i));
                    }
                    let _e775 = phi_5407_;
                    phi_5413_ = _e775;
                    if _e775 {
                        let _e777 = targetPos_2[2u];
                        phi_5413_ = (_e777 > 0i);
                    }
                    let _e780 = phi_5413_;
                    phi_5423_ = _e780;
                    if _e780 {
                        let _e782 = targetPos_2[2u];
                        let _e784 = tuning.gridDepth;
                        phi_5423_ = (_e782 < (bitcast<i32>(_e784) - 1i));
                    }
                    let _e789 = phi_5423_;
                    if _e789 {
                        let _e790 = targetPos_2;
                        param_650 = _e790;
                        let _e791 = getIndex_u0028_vi3_u003b((&param_650));
                        param_651 = _e791;
                        let _e792 = readCell_u0028_u1_u003b((&param_651));
                        param_652 = _e792;
                        let _e793 = getType_u0028_u1_u003b((&param_652));
                        if (_e793 == 0u) {
                            let _e795 = d_18;
                            param_653 = 2u;
                            param_654 = bitcast<u32>((_e795 + 1i));
                            param_655 = 0u;
                            let _e798 = newAge_2;
                            param_656 = _e798;
                            let _e799 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_653), (&param_654), (&param_655), (&param_656));
                            newValue_3 = _e799;
                            let _e800 = targetPos_2;
                            param_657 = _e800;
                            let _e801 = getIndex_u0028_vi3_u003b((&param_657));
                            let _e802 = (*currentIndex_10);
                            param_658 = _e802;
                            let _e803 = (*rawValue_8);
                            param_659 = _e803;
                            param_660 = _e801;
                            let _e804 = newValue_3;
                            param_661 = _e804;
                            let _e805 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_658), (&param_659), (&param_660), (&param_661));
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
                    let _e806 = i_19;
                    i_19 = (_e806 + 1i);
                }
            }
        }
    }
    let _e808 = (*currentSleep_5);
    newSleep_3 = min((_e808 + 1u), 255u);
    param_662 = 2u;
    param_663 = 0u;
    let _e811 = newSleep_3;
    param_664 = _e811;
    let _e812 = newAge_2;
    param_665 = _e812;
    let _e813 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_662), (&param_663), (&param_664), (&param_665));
    sleepValue = _e813;
    let _e814 = (*currentIndex_10);
    let _e817 = (*rawValue_8);
    let _e818 = sleepValue;
    let _e819 = atomicCompareExchangeWeak((&unnamed.grid[_e814]), _e817, _e818);
    return;
}

fn incWater_u0028_() {
    let _e205 = atomicAdd((&unnamed_1.waterVoxelCount), 1u);
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

    let _e368 = (*currentAge_9);
    moisture_5 = _e368;
    moistureModified_1 = false;
    let _e369 = moisture_5;
    let _e371 = tuning.sandMoistureCapacity;
    if (_e369 < _e371) {
        let _e373 = (*randVal_11);
        startDir_5 = i32((fract((_e373 * 17f)) * 6f));
        i_20 = 0i;
        loop {
            let _e378 = i_20;
            if (_e378 < 6i) {
                let _e380 = startDir_5;
                let _e381 = i_20;
                let _e382 = (_e380 + _e381);
                d_19 = (_e382 - (i32(floor((f32(_e382) / f32(6i)))) * 6i));
                let _e390 = d_19;
                if (_e390 != 2i) {
                    let _e392 = (*pos_14);
                    let _e393 = d_19;
                    param_666 = _e393;
                    let _e394 = getOrthoDir_u0028_i1_u003b((&param_666));
                    nPos_8 = (_e392 + _e394);
                    let _e397 = nPos_8[0u];
                    let _e398 = (_e397 > 0i);
                    phi_2635_ = _e398;
                    if _e398 {
                        let _e400 = nPos_8[0u];
                        let _e402 = tuning.gridWidth;
                        phi_2635_ = (_e400 < (bitcast<i32>(_e402) - 1i));
                    }
                    let _e407 = phi_2635_;
                    phi_2641_ = _e407;
                    if _e407 {
                        let _e409 = nPos_8[1u];
                        phi_2641_ = (_e409 > 0i);
                    }
                    let _e412 = phi_2641_;
                    phi_2651_ = _e412;
                    if _e412 {
                        let _e414 = nPos_8[1u];
                        let _e416 = tuning.gridHeight;
                        phi_2651_ = (_e414 < (bitcast<i32>(_e416) - 1i));
                    }
                    let _e421 = phi_2651_;
                    phi_2657_ = _e421;
                    if _e421 {
                        let _e423 = nPos_8[2u];
                        phi_2657_ = (_e423 > 0i);
                    }
                    let _e426 = phi_2657_;
                    phi_2667_ = _e426;
                    if _e426 {
                        let _e428 = nPos_8[2u];
                        let _e430 = tuning.gridDepth;
                        phi_2667_ = (_e428 < (bitcast<i32>(_e430) - 1i));
                    }
                    let _e435 = phi_2667_;
                    if _e435 {
                        let _e436 = nPos_8;
                        param_667 = _e436;
                        let _e437 = getIndex_u0028_vi3_u003b((&param_667));
                        nIndex_5 = _e437;
                        let _e438 = nIndex_5;
                        param_668 = _e438;
                        let _e439 = readCell_u0028_u1_u003b((&param_668));
                        nVal_5 = _e439;
                        let _e440 = nVal_5;
                        param_669 = _e440;
                        let _e441 = getType_u0028_u1_u003b((&param_669));
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
                let _e459 = i_20;
                i_20 = (_e459 + 1i);
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
            let _e473 = (*pos_14);
            let _e474 = d_20;
            param_670 = _e474;
            let _e475 = getOrthoDir_u0028_i1_u003b((&param_670));
            nPos_9 = (_e473 + _e475);
            let _e478 = nPos_9[0u];
            let _e479 = (_e478 > 0i);
            phi_2739_ = _e479;
            if _e479 {
                let _e481 = nPos_9[0u];
                let _e483 = tuning.gridWidth;
                phi_2739_ = (_e481 < (bitcast<i32>(_e483) - 1i));
            }
            let _e488 = phi_2739_;
            phi_2745_ = _e488;
            if _e488 {
                let _e490 = nPos_9[1u];
                phi_2745_ = (_e490 > 0i);
            }
            let _e493 = phi_2745_;
            phi_2755_ = _e493;
            if _e493 {
                let _e495 = nPos_9[1u];
                let _e497 = tuning.gridHeight;
                phi_2755_ = (_e495 < (bitcast<i32>(_e497) - 1i));
            }
            let _e502 = phi_2755_;
            phi_2761_ = _e502;
            if _e502 {
                let _e504 = nPos_9[2u];
                phi_2761_ = (_e504 > 0i);
            }
            let _e507 = phi_2761_;
            phi_2771_ = _e507;
            if _e507 {
                let _e509 = nPos_9[2u];
                let _e511 = tuning.gridDepth;
                phi_2771_ = (_e509 < (bitcast<i32>(_e511) - 1i));
            }
            let _e516 = phi_2771_;
            if _e516 {
                let _e517 = nPos_9;
                param_671 = _e517;
                let _e518 = getIndex_u0028_vi3_u003b((&param_671));
                nIndex_6 = _e518;
                let _e519 = nIndex_6;
                param_672 = _e519;
                let _e520 = readCell_u0028_u1_u003b((&param_672));
                nVal_6 = _e520;
                let _e521 = nVal_6;
                param_673 = _e521;
                let _e522 = getType_u0028_u1_u003b((&param_673));
                nType_3 = _e522;
                let _e523 = nType_3;
                let _e525 = nType_3;
                if ((_e523 == 1u) || (_e525 == 4u)) {
                    let _e528 = nVal_6;
                    param_674 = _e528;
                    let _e529 = getAge_u0028_u1_u003b((&param_674));
                    nMoisture_1 = _e529;
                    let _e530 = nType_3;
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
    phi_2836_ = _e554;
    if _e554 {
        let _e555 = moisture_5;
        let _e557 = tuning.sandWaterAbsorbUnit;
        phi_2836_ = (_e555 >= _e557);
    }
    let _e560 = phi_2836_;
    if _e560 {
        let _e561 = (*pos_14);
        leakPos = (_e561 + vec3<i32>(0i, -1i, 0i));
        let _e564 = leakPos[1u];
        let _e565 = (_e564 > 0i);
        phi_2855_ = _e565;
        if _e565 {
            let _e566 = leakPos;
            param_675 = _e566;
            let _e567 = getIndex_u0028_vi3_u003b((&param_675));
            param_676 = _e567;
            let _e568 = readCell_u0028_u1_u003b((&param_676));
            param_677 = _e568;
            let _e569 = getType_u0028_u1_u003b((&param_677));
            phi_2855_ = (_e569 == 0u);
        }
        let _e572 = phi_2855_;
        if _e572 {
            let _e573 = leakPos;
            param_678 = _e573;
            let _e574 = getIndex_u0028_vi3_u003b((&param_678));
            param_679 = 2u;
            param_680 = 0u;
            param_681 = 0u;
            param_682 = 0u;
            let _e577 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_679), (&param_680), (&param_681), (&param_682));
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
    let _e591 = (*pos_14);
    param_683 = _e591;
    let _e592 = grainCanMove_u0028_vi3_u003b((&param_683));
    canMove_1 = _e592;
    isClumped_1 = false;
    let _e593 = canMove_1;
    let _e594 = moisture_5;
    let _e596 = (_e593 && (_e594 > 0u));
    phi_2899_ = _e596;
    if _e596 {
        let _e597 = (*currentSleep_6);
        let _e599 = tuning.wakeSleepThreshold;
        phi_2899_ = (_e597 > _e599);
    }
    let _e602 = phi_2899_;
    if _e602 {
        emptyBelowCount_1 = 0i;
        let _e604 = (*pos_14)[1u];
        if (_e604 > 1i) {
            x_2 = -1i;
            loop {
                let _e606 = x_2;
                if (_e606 <= 1i) {
                    z_2 = -1i;
                    loop {
                        let _e608 = z_2;
                        if (_e608 <= 1i) {
                            let _e610 = (*pos_14);
                            let _e611 = x_2;
                            let _e612 = z_2;
                            checkPos_2 = (_e610 + vec3<i32>(_e611, -1i, _e612));
                            let _e616 = checkPos_2[0u];
                            let _e617 = (_e616 >= 0i);
                            phi_2941_ = _e617;
                            if _e617 {
                                let _e619 = checkPos_2[0u];
                                let _e621 = tuning.gridWidth;
                                phi_2941_ = (_e619 < bitcast<i32>(_e621));
                            }
                            let _e625 = phi_2941_;
                            phi_2947_ = _e625;
                            if _e625 {
                                let _e627 = checkPos_2[2u];
                                phi_2947_ = (_e627 >= 0i);
                            }
                            let _e630 = phi_2947_;
                            phi_2956_ = _e630;
                            if _e630 {
                                let _e632 = checkPos_2[2u];
                                let _e634 = tuning.gridDepth;
                                phi_2956_ = (_e632 < bitcast<i32>(_e634));
                            }
                            let _e638 = phi_2956_;
                            if _e638 {
                                let _e639 = checkPos_2;
                                param_684 = _e639;
                                let _e640 = getIndex_u0028_vi3_u003b((&param_684));
                                param_685 = _e640;
                                let _e641 = readCell_u0028_u1_u003b((&param_685));
                                param_686 = _e641;
                                let _e642 = getType_u0028_u1_u003b((&param_686));
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
                                    let _e669 = (*pos_14);
                                    let _e670 = x_3;
                                    let _e671 = y_1;
                                    let _e672 = z_3;
                                    nPos_10 = (_e669 + vec3<i32>(_e670, _e671, _e672));
                                    let _e676 = nPos_10[0u];
                                    let _e677 = (_e676 >= 0i);
                                    phi_3038_ = _e677;
                                    if _e677 {
                                        let _e679 = nPos_10[0u];
                                        let _e681 = tuning.gridWidth;
                                        phi_3038_ = (_e679 < bitcast<i32>(_e681));
                                    }
                                    let _e685 = phi_3038_;
                                    phi_3044_ = _e685;
                                    if _e685 {
                                        let _e687 = nPos_10[1u];
                                        phi_3044_ = (_e687 >= 0i);
                                    }
                                    let _e690 = phi_3044_;
                                    phi_3053_ = _e690;
                                    if _e690 {
                                        let _e692 = nPos_10[1u];
                                        let _e694 = tuning.gridHeight;
                                        phi_3053_ = (_e692 < bitcast<i32>(_e694));
                                    }
                                    let _e698 = phi_3053_;
                                    phi_3059_ = _e698;
                                    if _e698 {
                                        let _e700 = nPos_10[2u];
                                        phi_3059_ = (_e700 >= 0i);
                                    }
                                    let _e703 = phi_3059_;
                                    phi_3068_ = _e703;
                                    if _e703 {
                                        let _e705 = nPos_10[2u];
                                        let _e707 = tuning.gridDepth;
                                        phi_3068_ = (_e705 < bitcast<i32>(_e707));
                                    }
                                    let _e711 = phi_3068_;
                                    if _e711 {
                                        let _e712 = nPos_10;
                                        param_687 = _e712;
                                        let _e713 = getIndex_u0028_vi3_u003b((&param_687));
                                        param_688 = _e713;
                                        let _e714 = readCell_u0028_u1_u003b((&param_688));
                                        param_689 = _e714;
                                        let _e715 = getType_u0028_u1_u003b((&param_689));
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
        let _e735 = (*pos_14)[1u];
        if (_e735 > 1i) {
            let _e737 = (*pos_14);
            belowPos_8 = (_e737 + vec3<i32>(0i, -1i, 0i));
            let _e739 = belowPos_8;
            param_690 = _e739;
            let _e740 = getIndex_u0028_vi3_u003b((&param_690));
            param_691 = _e740;
            let _e741 = readCell_u0028_u1_u003b((&param_691));
            param_692 = _e741;
            let _e742 = getType_u0028_u1_u003b((&param_692));
            if (_e742 == 0u) {
                let _e744 = belowPos_8;
                param_693 = _e744;
                let _e745 = getIndex_u0028_vi3_u003b((&param_693));
                param_694 = 1u;
                param_695 = 0u;
                param_696 = 0u;
                let _e746 = moisture_5;
                param_697 = _e746;
                let _e747 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_694), (&param_695), (&param_696), (&param_697));
                let _e748 = (*currentIndex_11);
                param_698 = _e748;
                let _e749 = (*rawValue_9);
                param_699 = _e749;
                param_700 = _e745;
                param_701 = _e747;
                let _e750 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_698), (&param_699), (&param_700), (&param_701));
                if _e750 {
                    return;
                }
            }
        }
        let _e752 = (*pos_14)[1u];
        if (_e752 > 1i) {
            let _e754 = (*randVal_11);
            dir_4 = select(-1i, 1i, (fract((_e754 * 10f)) > 0.5f));
            let _e759 = (*randVal_11);
            if (fract((_e759 * 100f)) > 0.5f) {
                let _e763 = (*pos_14);
                let _e764 = dir_4;
                slidePos1_1 = (_e763 + vec3<i32>(_e764, -1i, 0i));
                let _e767 = (*pos_14);
                let _e768 = dir_4;
                slidePos2_1 = (_e767 + vec3<i32>(0i, -1i, _e768));
            } else {
                let _e771 = (*pos_14);
                let _e772 = dir_4;
                slidePos1_1 = (_e771 + vec3<i32>(0i, -1i, _e772));
                let _e775 = (*pos_14);
                let _e776 = dir_4;
                slidePos2_1 = (_e775 + vec3<i32>(_e776, -1i, 0i));
            }
            let _e780 = slidePos1_1[0u];
            let _e781 = (_e780 > 0i);
            phi_3189_ = _e781;
            if _e781 {
                let _e783 = slidePos1_1[0u];
                let _e785 = tuning.gridWidth;
                phi_3189_ = (_e783 < (bitcast<i32>(_e785) - 1i));
            }
            let _e790 = phi_3189_;
            phi_3195_ = _e790;
            if _e790 {
                let _e792 = slidePos1_1[2u];
                phi_3195_ = (_e792 > 0i);
            }
            let _e795 = phi_3195_;
            phi_3205_ = _e795;
            if _e795 {
                let _e797 = slidePos1_1[2u];
                let _e799 = tuning.gridDepth;
                phi_3205_ = (_e797 < (bitcast<i32>(_e799) - 1i));
            }
            let _e804 = phi_3205_;
            if _e804 {
                let _e805 = slidePos1_1;
                param_702 = _e805;
                let _e806 = getIndex_u0028_vi3_u003b((&param_702));
                param_703 = _e806;
                let _e807 = readCell_u0028_u1_u003b((&param_703));
                param_704 = _e807;
                let _e808 = getType_u0028_u1_u003b((&param_704));
                if (_e808 == 0u) {
                    let _e810 = slidePos1_1;
                    param_705 = _e810;
                    let _e811 = getIndex_u0028_vi3_u003b((&param_705));
                    param_706 = 1u;
                    param_707 = 0u;
                    param_708 = 0u;
                    let _e812 = moisture_5;
                    param_709 = _e812;
                    let _e813 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_706), (&param_707), (&param_708), (&param_709));
                    let _e814 = (*currentIndex_11);
                    param_710 = _e814;
                    let _e815 = (*rawValue_9);
                    param_711 = _e815;
                    param_712 = _e811;
                    param_713 = _e813;
                    let _e816 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_710), (&param_711), (&param_712), (&param_713));
                    if _e816 {
                        return;
                    }
                }
            }
            let _e818 = slidePos2_1[0u];
            let _e819 = (_e818 > 0i);
            phi_3249_ = _e819;
            if _e819 {
                let _e821 = slidePos2_1[0u];
                let _e823 = tuning.gridWidth;
                phi_3249_ = (_e821 < (bitcast<i32>(_e823) - 1i));
            }
            let _e828 = phi_3249_;
            phi_3255_ = _e828;
            if _e828 {
                let _e830 = slidePos2_1[2u];
                phi_3255_ = (_e830 > 0i);
            }
            let _e833 = phi_3255_;
            phi_3265_ = _e833;
            if _e833 {
                let _e835 = slidePos2_1[2u];
                let _e837 = tuning.gridDepth;
                phi_3265_ = (_e835 < (bitcast<i32>(_e837) - 1i));
            }
            let _e842 = phi_3265_;
            if _e842 {
                let _e843 = slidePos2_1;
                param_714 = _e843;
                let _e844 = getIndex_u0028_vi3_u003b((&param_714));
                param_715 = _e844;
                let _e845 = readCell_u0028_u1_u003b((&param_715));
                param_716 = _e845;
                let _e846 = getType_u0028_u1_u003b((&param_716));
                if (_e846 == 0u) {
                    let _e848 = slidePos2_1;
                    param_717 = _e848;
                    let _e849 = getIndex_u0028_vi3_u003b((&param_717));
                    param_718 = 1u;
                    param_719 = 0u;
                    param_720 = 0u;
                    let _e850 = moisture_5;
                    param_721 = _e850;
                    let _e851 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_718), (&param_719), (&param_720), (&param_721));
                    let _e852 = (*currentIndex_11);
                    param_722 = _e852;
                    let _e853 = (*rawValue_9);
                    param_723 = _e853;
                    param_724 = _e849;
                    param_725 = _e851;
                    let _e854 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_722), (&param_723), (&param_724), (&param_725));
                    if _e854 {
                        return;
                    }
                }
            }
        }
        let _e856 = (*pos_14)[1u];
        if (_e856 > 1i) {
            let _e858 = (*pos_14);
            belowPos_9 = (_e858 + vec3<i32>(0i, -1i, 0i));
            let _e860 = belowPos_9;
            param_726 = _e860;
            let _e861 = getIndex_u0028_vi3_u003b((&param_726));
            belowIndex_3 = _e861;
            let _e862 = belowIndex_3;
            param_727 = _e862;
            let _e863 = readCell_u0028_u1_u003b((&param_727));
            belowValue_3 = _e863;
            let _e864 = belowValue_3;
            param_728 = _e864;
            let _e865 = getType_u0028_u1_u003b((&param_728));
            if (_e865 == 2u) {
                let _e867 = (*randVal_11);
                startDir_6 = i32((fract((_e867 * 8f)) * 8f));
                i_21 = 0i;
                loop {
                    let _e872 = i_21;
                    if (_e872 < 8i) {
                        let _e874 = startDir_6;
                        let _e875 = i_21;
                        let _e876 = (_e874 + _e875);
                        d_21 = (_e876 - (i32(floor((f32(_e876) / f32(8i)))) * 8i));
                        let _e884 = belowPos_9;
                        let _e885 = d_21;
                        param_729 = _e885;
                        let _e886 = getHDir_u0028_i1_u003b((&param_729));
                        pushPos_2 = (_e884 + _e886);
                        let _e889 = pushPos_2[0u];
                        let _e890 = (_e889 > 0i);
                        phi_3357_ = _e890;
                        if _e890 {
                            let _e892 = pushPos_2[0u];
                            let _e894 = tuning.gridWidth;
                            phi_3357_ = (_e892 < (bitcast<i32>(_e894) - 1i));
                        }
                        let _e899 = phi_3357_;
                        phi_3363_ = _e899;
                        if _e899 {
                            let _e901 = pushPos_2[2u];
                            phi_3363_ = (_e901 > 0i);
                        }
                        let _e904 = phi_3363_;
                        phi_3373_ = _e904;
                        if _e904 {
                            let _e906 = pushPos_2[2u];
                            let _e908 = tuning.gridDepth;
                            phi_3373_ = (_e906 < (bitcast<i32>(_e908) - 1i));
                        }
                        let _e913 = phi_3373_;
                        if _e913 {
                            param_730 = 1u;
                            param_731 = 0u;
                            param_732 = 0u;
                            let _e914 = moisture_5;
                            param_733 = _e914;
                            let _e915 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_730), (&param_731), (&param_732), (&param_733));
                            let _e916 = pushPos_2;
                            param_734 = _e916;
                            let _e917 = getIndex_u0028_vi3_u003b((&param_734));
                            let _e918 = (*currentIndex_11);
                            param_735 = _e918;
                            param_736 = _e915;
                            let _e919 = belowIndex_3;
                            param_737 = _e919;
                            let _e920 = belowValue_3;
                            param_738 = _e920;
                            param_739 = _e917;
                            let _e921 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_735), (&param_736), (&param_737), (&param_738), (&param_739));
                            if _e921 {
                                return;
                            }
                        }
                        continue;
                    } else {
                        break;
                    }
                    continuing {
                        let _e922 = i_21;
                        i_21 = (_e922 + 1i);
                    }
                }
                param_740 = 1u;
                param_741 = 0u;
                param_742 = 0u;
                let _e924 = moisture_5;
                param_743 = _e924;
                let _e925 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_740), (&param_741), (&param_742), (&param_743));
                let _e926 = (*currentIndex_11);
                param_744 = _e926;
                let _e927 = (*rawValue_9);
                param_745 = _e927;
                let _e928 = belowIndex_3;
                param_746 = _e928;
                param_747 = _e925;
                let _e929 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_744), (&param_745), (&param_746), (&param_747));
                if _e929 {
                    return;
                }
            }
            let _e930 = (*randVal_11);
            dir_5 = select(-1i, 1i, (fract((_e930 * 10f)) > 0.5f));
            let _e935 = (*randVal_11);
            if (fract((_e935 * 100f)) > 0.5f) {
                let _e939 = (*pos_14);
                let _e940 = dir_5;
                slidePos_1[0i] = (_e939 + vec3<i32>(_e940, -1i, 0i));
                let _e944 = (*pos_14);
                let _e945 = dir_5;
                slidePos_1[1i] = (_e944 + vec3<i32>(0i, -1i, _e945));
            } else {
                let _e949 = (*pos_14);
                let _e950 = dir_5;
                slidePos_1[0i] = (_e949 + vec3<i32>(0i, -1i, _e950));
                let _e954 = (*pos_14);
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
                    phi_3476_ = _e966;
                    if _e966 {
                        let _e968 = sPos_3[0u];
                        let _e970 = tuning.gridWidth;
                        phi_3476_ = (_e968 < (bitcast<i32>(_e970) - 1i));
                    }
                    let _e975 = phi_3476_;
                    phi_3482_ = _e975;
                    if _e975 {
                        let _e977 = sPos_3[2u];
                        phi_3482_ = (_e977 > 0i);
                    }
                    let _e980 = phi_3482_;
                    phi_3492_ = _e980;
                    if _e980 {
                        let _e982 = sPos_3[2u];
                        let _e984 = tuning.gridDepth;
                        phi_3492_ = (_e982 < (bitcast<i32>(_e984) - 1i));
                    }
                    let _e989 = phi_3492_;
                    if _e989 {
                        let _e990 = sPos_3;
                        param_748 = _e990;
                        let _e991 = getIndex_u0028_vi3_u003b((&param_748));
                        sIndex_1 = _e991;
                        let _e992 = sIndex_1;
                        param_749 = _e992;
                        let _e993 = readCell_u0028_u1_u003b((&param_749));
                        sValue_1 = _e993;
                        let _e994 = sValue_1;
                        param_750 = _e994;
                        let _e995 = getType_u0028_u1_u003b((&param_750));
                        if (_e995 == 2u) {
                            let _e997 = (*randVal_11);
                            let _e999 = s_2;
                            startDir_7 = i32((fract(((_e997 * 8f) + f32(_e999))) * 8f));
                            i_22 = 0i;
                            loop {
                                let _e1005 = i_22;
                                if (_e1005 < 8i) {
                                    let _e1007 = startDir_7;
                                    let _e1008 = i_22;
                                    let _e1009 = (_e1007 + _e1008);
                                    d_22 = (_e1009 - (i32(floor((f32(_e1009) / f32(8i)))) * 8i));
                                    let _e1017 = sPos_3;
                                    let _e1018 = d_22;
                                    param_751 = _e1018;
                                    let _e1019 = getHDir_u0028_i1_u003b((&param_751));
                                    pushPos_3 = (_e1017 + _e1019);
                                    let _e1022 = pushPos_3[0u];
                                    let _e1023 = (_e1022 > 0i);
                                    phi_3549_ = _e1023;
                                    if _e1023 {
                                        let _e1025 = pushPos_3[0u];
                                        let _e1027 = tuning.gridWidth;
                                        phi_3549_ = (_e1025 < (bitcast<i32>(_e1027) - 1i));
                                    }
                                    let _e1032 = phi_3549_;
                                    phi_3555_ = _e1032;
                                    if _e1032 {
                                        let _e1034 = pushPos_3[2u];
                                        phi_3555_ = (_e1034 > 0i);
                                    }
                                    let _e1037 = phi_3555_;
                                    phi_3565_ = _e1037;
                                    if _e1037 {
                                        let _e1039 = pushPos_3[2u];
                                        let _e1041 = tuning.gridDepth;
                                        phi_3565_ = (_e1039 < (bitcast<i32>(_e1041) - 1i));
                                    }
                                    let _e1046 = phi_3565_;
                                    if _e1046 {
                                        param_752 = 1u;
                                        param_753 = 0u;
                                        param_754 = 0u;
                                        let _e1047 = moisture_5;
                                        param_755 = _e1047;
                                        let _e1048 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_752), (&param_753), (&param_754), (&param_755));
                                        let _e1049 = pushPos_3;
                                        param_756 = _e1049;
                                        let _e1050 = getIndex_u0028_vi3_u003b((&param_756));
                                        let _e1051 = (*currentIndex_11);
                                        param_757 = _e1051;
                                        param_758 = _e1048;
                                        let _e1052 = sIndex_1;
                                        param_759 = _e1052;
                                        let _e1053 = sValue_1;
                                        param_760 = _e1053;
                                        param_761 = _e1050;
                                        let _e1054 = tryDisplace_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_757), (&param_758), (&param_759), (&param_760), (&param_761));
                                        if _e1054 {
                                            return;
                                        }
                                    }
                                    continue;
                                } else {
                                    break;
                                }
                                continuing {
                                    let _e1055 = i_22;
                                    i_22 = (_e1055 + 1i);
                                }
                            }
                            param_762 = 1u;
                            param_763 = 0u;
                            param_764 = 0u;
                            let _e1057 = moisture_5;
                            param_765 = _e1057;
                            let _e1058 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_762), (&param_763), (&param_764), (&param_765));
                            let _e1059 = (*currentIndex_11);
                            param_766 = _e1059;
                            let _e1060 = (*rawValue_9);
                            param_767 = _e1060;
                            let _e1061 = sIndex_1;
                            param_768 = _e1061;
                            param_769 = _e1058;
                            let _e1062 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_766), (&param_767), (&param_768), (&param_769));
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
    param_770 = 1u;
    param_771 = 0u;
    let _e1072 = newSleep_4;
    param_772 = _e1072;
    let _e1073 = moisture_5;
    param_773 = _e1073;
    let _e1074 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_770), (&param_771), (&param_772), (&param_773));
    let _e1075 = atomicCompareExchangeWeak((&unnamed.grid[_e1068]), _e1071, _e1074);
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

    let _e224 = (*stepDir);
    if all((_e224 == vec3<i32>(0i, 0i, 0i))) {
        return false;
    }
    let _e227 = (*pos_15);
    let _e228 = (*stepDir);
    target_2 = (_e227 + _e228);
    let _e231 = target_2[0u];
    let _e232 = (_e231 < 1i);
    phi_1939_ = _e232;
    if !(_e232) {
        let _e235 = target_2[0u];
        let _e237 = tuning.gridWidth;
        phi_1939_ = (_e235 >= (bitcast<i32>(_e237) - 1i));
    }
    let _e242 = phi_1939_;
    phi_1946_ = _e242;
    if !(_e242) {
        let _e245 = target_2[1u];
        phi_1946_ = (_e245 < 1i);
    }
    let _e248 = phi_1946_;
    phi_1957_ = _e248;
    if !(_e248) {
        let _e251 = target_2[1u];
        let _e253 = tuning.gridHeight;
        phi_1957_ = (_e251 >= (bitcast<i32>(_e253) - 1i));
    }
    let _e258 = phi_1957_;
    phi_1964_ = _e258;
    if !(_e258) {
        let _e261 = target_2[2u];
        phi_1964_ = (_e261 < 1i);
    }
    let _e264 = phi_1964_;
    phi_1975_ = _e264;
    if !(_e264) {
        let _e267 = target_2[2u];
        let _e269 = tuning.gridDepth;
        phi_1975_ = (_e267 >= (bitcast<i32>(_e269) - 1i));
    }
    let _e274 = phi_1975_;
    if _e274 {
        return false;
    }
    let _e275 = target_2;
    param_774 = _e275;
    let _e276 = getIndex_u0028_vi3_u003b((&param_774));
    targetIndex_3 = _e276;
    let _e277 = targetIndex_3;
    param_775 = _e277;
    let _e278 = readCell_u0028_u1_u003b((&param_775));
    param_776 = _e278;
    let _e279 = getType_u0028_u1_u003b((&param_776));
    if (_e279 != 0u) {
        return false;
    }
    let _e281 = (*rawValue_10);
    param_777 = _e281;
    let _e282 = getType_u0028_u1_u003b((&param_777));
    let _e283 = (*rawValue_10);
    param_778 = _e283;
    let _e284 = getDir_u0028_u1_u003b((&param_778));
    let _e285 = (*rawValue_10);
    param_779 = _e285;
    let _e286 = getAge_u0028_u1_u003b((&param_779));
    param_780 = _e282;
    param_781 = _e284;
    param_782 = 0u;
    param_783 = _e286;
    let _e287 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_780), (&param_781), (&param_782), (&param_783));
    let _e288 = (*currentIndex_12);
    param_784 = _e288;
    let _e289 = (*rawValue_10);
    param_785 = _e289;
    let _e290 = targetIndex_3;
    param_786 = _e290;
    param_787 = _e287;
    let _e291 = tryMove_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_784), (&param_785), (&param_786), (&param_787));
    return _e291;
}

fn dominantAxis_u0028_vf3_u003b_f1_u003b(dir_6: ptr<function, vec3<f32>>, relative: ptr<function, f32>) -> vec3<i32> {
    var a: vec3<f32>;
    var m: f32;

    let _e208 = (*dir_6);
    a = abs(_e208);
    let _e211 = a[0u];
    let _e213 = a[1u];
    let _e215 = a[2u];
    m = max(_e211, max(_e213, _e215));
    let _e218 = m;
    if (_e218 <= 0f) {
        return vec3<i32>(0i, 0i, 0i);
    }
    let _e220 = a;
    let _e221 = m;
    let _e222 = (*relative);
    let _e227 = (*dir_6);
    return (select(vec3<i32>(0i, 0i, 0i), vec3<i32>(1i, 1i, 1i), (_e220 >= vec3((_e221 * _e222)))) * vec3<i32>(sign(_e227)));
}

fn bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b(k_1: ptr<function, i32>, planeCount: ptr<function, i32>, seed: ptr<function, f32>) -> vec3<f32> {
    var z_4: f32;
    var r_4: f32;
    var a_1: f32;

    let _e210 = (*k_1);
    let _e213 = (*planeCount);
    z_4 = ((f32(_e210) + 0.5f) / f32(_e213));
    let _e216 = z_4;
    let _e217 = z_4;
    r_4 = sqrt(max(0f, (1f - (_e216 * _e217))));
    let _e222 = (*k_1);
    let _e225 = (*seed);
    a_1 = ((2.399963f * f32(_e222)) + _e225);
    let _e227 = r_4;
    let _e228 = a_1;
    let _e231 = z_4;
    let _e232 = r_4;
    let _e233 = a_1;
    return vec3<f32>((_e227 * cos(_e228)), _e231, (_e232 * sin(_e233)));
}

fn hash_u0028_vf3_u003b(p_3: ptr<function, vec3<f32>>) -> f32 {
    let _e205 = (*p_3);
    return fract((sin(dot(_e205, vec3<f32>(12.9898f, 78.233f, 45.164f))) * 43758.547f));
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

    let _e221 = (*pos_16);
    let _e222 = (*center);
    radial = normalize(vec3<f32>((_e221 - _e222)));
    let _e227 = tuning.blackHoleOrbitPlanes;
    planeCount_1 = bitcast<i32>(clamp(_e227, 1u, 32u));
    let _e230 = (*center);
    param_788 = (vec3<f32>(_e230) + vec3<f32>(29f, 3f, 71f));
    let _e233 = hash_u0028_vf3_u003b((&param_788));
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
            param_789 = _e238;
            let _e239 = planeCount_1;
            param_790 = _e239;
            let _e240 = seed_1;
            param_791 = _e240;
            let _e241 = bhPlaneNormal_u0028_i1_u003b_i1_u003b_f1_u003b((&param_789), (&param_790), (&param_791));
            n_1 = _e241;
            let _e242 = n_1;
            let _e243 = radial;
            align = abs(dot(_e242, _e243));
            let _e246 = align;
            let _e247 = bestAlign;
            if (_e246 < _e247) {
                let _e249 = align;
                bestAlign = _e249;
                let _e250 = n_1;
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
    param_792 = (vec3<f32>(_e254) + vec3<f32>((f32(_e256) * 13f), 101f, 47f));
    let _e261 = hash_u0028_vf3_u003b((&param_792));
    sense = select(1f, -1f, (_e261 < 0.5f));
    let _e264 = best;
    let _e265 = sense;
    return (_e264 * _e265);
}

fn decWaterHighMark_u0028_() {
    let _e205 = atomicAdd((&unnamed_1.waterHighMark), 4294967295u);
    if (_e205 == 0u) {
        let _e208 = atomicAdd((&unnamed_1.waterHighMark), 1u);
    }
    return;
}

fn bhIsPurge_u0028_u1_u003b(code: ptr<function, u32>) -> bool {
    let _e205 = (*code);
    return ((_e205 & 1073741824u) != 0u);
}

fn bhBodyRadius_u0028_u1_u003b(level: ptr<function, u32>) -> f32 {
    let _e205 = (*level);
    return (f32(_e205) + 0.5f);
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

    let _e282 = (*rawValue_11);
    param_793 = _e282;
    let _e283 = getType_u0028_u1_u003b((&param_793));
    type_39 = _e283;
    let _e284 = (*rawValue_11);
    param_794 = _e284;
    let _e285 = getSleep_u0028_u1_u003b((&param_794));
    sleep_1 = _e285;
    let _e286 = (*slot);
    unnamed_1.blackHoleStarve[_e286] = 0u;
    let _e289 = (*dist_1);
    let _e290 = (*level_1);
    param_795 = _e290;
    let _e291 = bhBodyRadius_u0028_u1_u003b((&param_795));
    let _e293 = tuning.blackHoleHorizon;
    if (_e289 <= (_e291 + f32(_e293))) {
        let _e297 = (*currentIndex_13);
        let _e300 = (*rawValue_11);
        let _e301 = atomicCompareExchangeWeak((&unnamed.grid[_e297]), _e300, 0u);
        let _e303 = (*rawValue_11);
        if (_e301.old_value == _e303) {
            let _e305 = (*slot);
            let _e308 = atomicLoad((&unnamed_1.blackHoles[_e305]));
            param_796 = _e308;
            let _e309 = bhIsPurge_u0028_u1_u003b((&param_796));
            if !(_e309) {
                let _e311 = (*slot);
                let _e314 = atomicAdd((&unnamed_1.blackHoleMass[_e311]), 1u);
            }
            let _e315 = type_39;
            if (_e315 == 2u) {
                decWater_u0028_();
                decWaterHighMark_u0028_();
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
            param_797 = _e343;
            let _e344 = getDir_u0028_u1_u003b((&param_797));
            let _e345 = (*rawValue_11);
            param_798 = _e345;
            let _e346 = getAge_u0028_u1_u003b((&param_798));
            let _e347 = type_39;
            param_799 = _e347;
            param_800 = _e344;
            param_801 = 0u;
            param_802 = _e346;
            let _e348 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_799), (&param_800), (&param_801), (&param_802));
            let _e349 = atomicCompareExchangeWeak((&unnamed.grid[_e339]), _e342, _e348);
        }
        return;
    }
    let _e351 = (*center_1);
    let _e352 = (*pos_17);
    inward = normalize(vec3<f32>((_e351 - _e352)));
    let _e356 = (*center_1);
    param_803 = _e356;
    let _e357 = (*pos_17);
    param_804 = _e357;
    let _e358 = bhOrbitAxis_u0028_vi3_u003b_vi3_u003b((&param_803), (&param_804));
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
    let _e373 = (*pos_17);
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
    phi_2237_ = _e403;
    if _e403 {
        let _e404 = spiral;
        param_805 = _e404;
        param_806 = 0.55f;
        let _e405 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_805), (&param_806));
        let _e406 = (*pos_17);
        param_807 = _e406;
        let _e407 = (*currentIndex_13);
        param_808 = _e407;
        let _e408 = (*rawValue_11);
        param_809 = _e408;
        param_810 = _e405;
        let _e409 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_807), (&param_808), (&param_809), (&param_810));
        phi_2237_ = _e409;
    }
    let _e411 = phi_2237_;
    if _e411 {
        return;
    }
    let _e412 = along;
    param_811 = _e412;
    param_812 = 0.55f;
    let _e413 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_811), (&param_812));
    let _e414 = (*pos_17);
    param_813 = _e414;
    let _e415 = (*currentIndex_13);
    param_814 = _e415;
    let _e416 = (*rawValue_11);
    param_815 = _e416;
    param_816 = _e413;
    let _e417 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_813), (&param_814), (&param_815), (&param_816));
    if _e417 {
        return;
    }
    let _e418 = along;
    param_817 = _e418;
    param_818 = 1f;
    let _e419 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_817), (&param_818));
    let _e420 = (*pos_17);
    param_819 = _e420;
    let _e421 = (*currentIndex_13);
    param_820 = _e421;
    let _e422 = (*rawValue_11);
    param_821 = _e422;
    param_822 = _e419;
    let _e423 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_819), (&param_820), (&param_821), (&param_822));
    if _e423 {
        return;
    }
    let _e424 = tangent;
    param_823 = _e424;
    param_824 = 1f;
    let _e425 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_823), (&param_824));
    let _e426 = (*pos_17);
    param_825 = _e426;
    let _e427 = (*currentIndex_13);
    param_826 = _e427;
    let _e428 = (*rawValue_11);
    param_827 = _e428;
    param_828 = _e425;
    let _e429 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_825), (&param_826), (&param_827), (&param_828));
    if _e429 {
        return;
    }
    let _e430 = inward;
    param_829 = _e430;
    param_830 = 0.55f;
    let _e431 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_829), (&param_830));
    let _e432 = (*pos_17);
    param_831 = _e432;
    let _e433 = (*currentIndex_13);
    param_832 = _e433;
    let _e434 = (*rawValue_11);
    param_833 = _e434;
    param_834 = _e431;
    let _e435 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_831), (&param_832), (&param_833), (&param_834));
    if _e435 {
        return;
    }
    let _e436 = inward;
    param_835 = _e436;
    param_836 = 1f;
    let _e437 = dominantAxis_u0028_vf3_u003b_f1_u003b((&param_835), (&param_836));
    let _e438 = (*pos_17);
    param_837 = _e438;
    let _e439 = (*currentIndex_13);
    param_838 = _e439;
    let _e440 = (*rawValue_11);
    param_839 = _e440;
    param_840 = _e437;
    let _e441 = orbitStep_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b((&param_837), (&param_838), (&param_839), (&param_840));
    if _e441 {
        return;
    }
    let _e442 = sleep_1;
    if (_e442 != 0u) {
        let _e444 = (*currentIndex_13);
        let _e447 = (*rawValue_11);
        let _e448 = (*rawValue_11);
        param_841 = _e448;
        let _e449 = getDir_u0028_u1_u003b((&param_841));
        let _e450 = (*rawValue_11);
        param_842 = _e450;
        let _e451 = getAge_u0028_u1_u003b((&param_842));
        let _e452 = type_39;
        param_843 = _e452;
        param_844 = _e449;
        param_845 = 0u;
        param_846 = _e451;
        let _e453 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_843), (&param_844), (&param_845), (&param_846));
        let _e454 = atomicCompareExchangeWeak((&unnamed.grid[_e444]), _e447, _e453);
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
        let _e210 = l;
        let _e212 = tuning.blackHoleMaxLevel;
        if (_e210 <= min(_e212, 16u)) {
            let _e215 = l;
            param_847 = _e215;
            let _e216 = bhBodyRadius_u0028_u1_u003b((&param_847));
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
    var param_848: u32;
    var param_849: u32;

    let _e208 = (*code_1);
    param_848 = _e208;
    let _e209 = bhIsPurge_u0028_u1_u003b((&param_848));
    if _e209 {
        let _e211 = tuning.purgeLevel;
        let _e213 = (*mass_1);
        let _e216 = tuning.purgeMass;
        return u32((f32(_e211) * clamp((f32(_e213) / f32(max(_e216, 1u))), 0f, 1f)));
    }
    let _e223 = (*mass_1);
    param_849 = _e223;
    let _e224 = bhLevel_u0028_u1_u003b((&param_849));
    return _e224;
}

fn bhDecode_u0028_u1_u003b(code_2: ptr<function, u32>) -> vec3<i32> {
    var i_23: u32;

    let _e206 = (*code_2);
    i_23 = (_e206 & 1073741823u);
    let _e208 = i_23;
    let _e210 = tuning.gridWidth;
    let _e215 = i_23;
    let _e217 = tuning.gridWidth;
    let _e222 = tuning.gridHeight;
    let _e227 = i_23;
    let _e229 = tuning.gridWidth;
    let _e232 = tuning.gridHeight;
    return vec3<i32>(bitcast<i32>((_e208 % bitcast<u32>(bitcast<i32>(_e210)))), bitcast<i32>(((_e215 / bitcast<u32>(bitcast<i32>(_e217))) % bitcast<u32>(bitcast<i32>(_e222)))), bitcast<i32>((_e227 / bitcast<u32>((bitcast<i32>(_e229) * bitcast<i32>(_e232))))));
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

    let _e238 = unnamed_1.blackHoleCount;
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
    i_24 = 0i;
    loop {
        let _e250 = i_24;
        if (_e250 < 8i) {
            let _e252 = i_24;
            let _e255 = atomicLoad((&unnamed_1.blackHoles[_e252]));
            code_3 = _e255;
            let _e256 = code_3;
            if (_e256 == 0u) {
                continue;
            }
            let _e258 = code_3;
            param_850 = _e258;
            let _e259 = bhDecode_u0028_u1_u003b((&param_850));
            center_2 = _e259;
            let _e260 = center_2;
            let _e261 = (*pos_18);
            d_23 = vec3<f32>((_e260 - _e261));
            let _e264 = d_23;
            let _e265 = d_23;
            distSq = dot(_e264, _e265);
            let _e267 = code_3;
            param_851 = _e267;
            let _e268 = bhIsPurge_u0028_u1_u003b((&param_851));
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
            let _e278 = i_24;
            let _e279 = code_3;
            param_852 = _e279;
            let _e282 = atomicLoad((&unnamed_1.blackHoleMass[_e278]));
            param_853 = _e282;
            let _e283 = bhLevelFor_u0028_u1_u003b_u1_u003b((&param_852), (&param_853));
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
                let _e298 = i_24;
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
            let _e301 = i_24;
            i_24 = (_e301 + 1i);
        }
    }
    let _e303 = bestSlot;
    if (_e303 < 0i) {
        return false;
    }
    let _e305 = bestDistSq;
    let _e307 = (*pos_18);
    param_854 = _e307;
    let _e308 = (*currentIndex_14);
    param_855 = _e308;
    let _e309 = (*rawValue_12);
    param_856 = _e309;
    let _e310 = bestCenter;
    param_857 = _e310;
    let _e311 = bestSlot;
    param_858 = _e311;
    let _e312 = bestLevel;
    param_859 = _e312;
    let _e313 = bestPurge;
    param_860 = _e313;
    param_861 = sqrt(_e305);
    let _e314 = (*randVal_13);
    param_862 = _e314;
    updateOrbital_u0028_vi3_u003b_u1_u003b_u1_u003b_vi3_u003b_i1_u003b_u1_u003b_b1_u003b_f1_u003b_f1_u003b((&param_854), (&param_855), (&param_856), (&param_857), (&param_858), (&param_859), (&param_860), (&param_861), (&param_862));
    return true;
}

fn getRainDropChance_u0028_u1_u003b_u1_u003b(candidates: ptr<function, u32>, remaining: ptr<function, u32>) -> f32 {
    var want: u32;

    let _e207 = (*candidates);
    if (_e207 == 0u) {
        return 0f;
    }
    let _e210 = tuning.rainDropsPerTick;
    let _e211 = (*remaining);
    want = min(_e210, _e211);
    let _e213 = want;
    let _e215 = (*candidates);
    return clamp((f32(_e213) / f32(_e215)), 0f, 1f);
}

fn cloudRadii_u0028_i1_u003b(i_25: ptr<function, i32>) -> vec3<f32> {
    let _e205 = (*i_25);
    let _e210 = unnamed_1.cloudCache[((_e205 * 7i) + 3i)];
    let _e211 = (*i_25);
    let _e216 = unnamed_1.cloudCache[((_e211 * 7i) + 4i)];
    let _e217 = (*i_25);
    let _e222 = unnamed_1.cloudCache[((_e217 * 7i) + 5i)];
    return vec3<f32>(_e210, _e216, _e222);
}

fn cloudCenter_u0028_i1_u003b(i_26: ptr<function, i32>) -> vec3<f32> {
    let _e205 = (*i_26);
    let _e210 = unnamed_1.cloudCache[((_e205 * 7i) + 0i)];
    let _e211 = (*i_26);
    let _e216 = unnamed_1.cloudCache[((_e211 * 7i) + 1i)];
    let _e217 = (*i_26);
    let _e222 = unnamed_1.cloudCache[((_e217 * 7i) + 2i)];
    return vec3<f32>(_e210, _e216, _e222);
}

fn cloudFade_u0028_i1_u003b(i_27: ptr<function, i32>) -> f32 {
    let _e205 = (*i_27);
    let _e210 = unnamed_1.cloudCache[((_e205 * 7i) + 6i)];
    return _e210;
}

fn bhRegister_u0028_vi3_u003b(p_4: ptr<function, vec3<i32>>) -> bool {
    var code_4: u32;
    var param_863: vec3<i32>;
    var i_28: i32;

    let _e208 = (*p_4);
    param_863 = _e208;
    let _e209 = getIndex_u0028_vi3_u003b((&param_863));
    code_4 = (2147483648u | _e209);
    i_28 = 0i;
    loop {
        let _e211 = i_28;
        if (_e211 < 8i) {
            let _e213 = i_28;
            let _e216 = code_4;
            let _e217 = atomicCompareExchangeWeak((&unnamed_1.blackHoles[_e213]), 0u, _e216);
            if (_e217.old_value == 0u) {
                let _e220 = i_28;
                atomicStore((&unnamed_1.blackHoleMass[_e220]), 0u);
                let _e223 = i_28;
                unnamed_1.blackHoleStarve[_e223] = 0u;
                return true;
            }
            continue;
        } else {
            break;
        }
        continuing {
            let _e226 = i_28;
            i_28 = (_e226 + 1i);
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

fn lavaSpawnCoolness_u0028_u1_u003b(type_40: ptr<function, u32>) -> u32 {
    var param_864: u32;

    let _e206 = (*type_40);
    if (_e206 == 12u) {
        let _e208 = lavaSolidifyCoolness_u0028_();
        return _e208;
    }
    let _e209 = (*type_40);
    param_864 = _e209;
    let _e210 = isLava_u0028_u1_u003b((&param_864));
    if _e210 {
        let _e211 = (*type_40);
        let _e214 = tuning.lavaStageSize;
        return ((_e211 - 8u) * max(_e214, 1u));
    }
    return 0u;
}

fn locustSpawnCount_u0028_u1_u003b(type_41: ptr<function, u32>) -> u32 {
    var param_865: u32;

    let _e206 = (*type_41);
    param_865 = _e206;
    let _e207 = isLocust_u0028_u1_u003b((&param_865));
    if !(_e207) {
        return 0u;
    }
    let _e209 = (*type_41);
    let _e212 = locustStage_u0028_();
    let _e214 = locustMaxCount_u0028_();
    return min((((_e209 - 13u) + 1u) * _e212), _e214);
}

fn bhRelease_u0028_vi3_u003b(p_5: ptr<function, vec3<i32>>) {
    var code_5: u32;
    var param_866: vec3<i32>;
    var i_29: i32;

    let _e208 = (*p_5);
    param_866 = _e208;
    let _e209 = getIndex_u0028_vi3_u003b((&param_866));
    code_5 = (2147483648u | _e209);
    i_29 = 0i;
    loop {
        let _e211 = i_29;
        if (_e211 < 8i) {
            let _e213 = i_29;
            let _e216 = code_5;
            let _e217 = atomicCompareExchangeWeak((&unnamed_1.blackHoles[_e213]), _e216, 0u);
            continue;
        } else {
            break;
        }
        continuing {
            let _e219 = i_29;
            i_29 = (_e219 + 1i);
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

    let _e211 = pc.spawnSize;
    halfMin = (_e211 / 2i);
    let _e214 = pc.spawnSize;
    halfMax = ((_e214 - 1i) / 2i);
    let _e218 = (*pos_19)[0u];
    let _e220 = pc.spawnX;
    let _e221 = halfMin;
    let _e223 = (_e218 < (_e220 - _e221));
    phi_1389_ = _e223;
    if !(_e223) {
        let _e226 = (*pos_19)[0u];
        let _e228 = pc.spawnX;
        let _e229 = halfMax;
        phi_1389_ = (_e226 > (_e228 + _e229));
    }
    let _e233 = phi_1389_;
    if _e233 {
        return false;
    }
    let _e235 = (*pos_19)[1u];
    let _e237 = pc.spawnY;
    let _e238 = halfMin;
    let _e240 = (_e235 < (_e237 - _e238));
    phi_1411_ = _e240;
    if !(_e240) {
        let _e243 = (*pos_19)[1u];
        let _e245 = pc.spawnY;
        let _e246 = halfMax;
        phi_1411_ = (_e243 > (_e245 + _e246));
    }
    let _e250 = phi_1411_;
    if _e250 {
        return false;
    }
    let _e252 = (*pos_19)[2u];
    let _e254 = pc.spawnZ;
    let _e255 = halfMin;
    let _e257 = (_e252 < (_e254 - _e255));
    phi_1432_ = _e257;
    if !(_e257) {
        let _e260 = (*pos_19)[2u];
        let _e262 = pc.spawnZ;
        let _e263 = halfMax;
        phi_1432_ = (_e260 > (_e262 + _e263));
    }
    let _e267 = phi_1432_;
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
    let _e289 = (*pos_19);
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

fn cloudEdgeFade_u0028_vf2_u003b(c_8: ptr<function, vec2<f32>>) -> f32 {
    var d_25: f32;
    var fx: f32;
    var fz: f32;

    let _e209 = tuning.cloudEdgeFadeDist;
    d_25 = max(_e209, 0.001f);
    let _e211 = d_25;
    let _e213 = (*c_8)[0u];
    let _e215 = d_25;
    let _e217 = tuning.gridWidth;
    let _e221 = (*c_8)[0u];
    fx = (smoothstep(0f, _e211, _e213) * smoothstep(0f, _e215, (f32(bitcast<i32>(_e217)) - _e221)));
    let _e225 = d_25;
    let _e227 = (*c_8)[1u];
    let _e229 = d_25;
    let _e231 = tuning.gridDepth;
    let _e235 = (*c_8)[1u];
    fz = (smoothstep(0f, _e225, _e227) * smoothstep(0f, _e229, (f32(bitcast<i32>(_e231)) - _e235)));
    let _e239 = fx;
    let _e240 = fz;
    return (_e239 * _e240);
}

fn cloudRadiiSource_u0028_i1_u003b(i_30: ptr<function, i32>) -> vec3<f32> {
    var h4_: f32;
    var param_867: vec3<f32>;
    var h5_: f32;
    var param_868: vec3<f32>;
    var h6_: f32;
    var param_869: vec3<f32>;
    var rxz: f32;

    let _e212 = (*i_30);
    param_867 = vec3<f32>(f32(_e212), 211f, 5f);
    let _e215 = hash_u0028_vf3_u003b((&param_867));
    h4_ = _e215;
    let _e216 = (*i_30);
    param_868 = vec3<f32>(f32(_e216), 71f, 61f);
    let _e219 = hash_u0028_vf3_u003b((&param_868));
    h5_ = _e219;
    let _e220 = (*i_30);
    param_869 = vec3<f32>(f32(_e220), 19f, 173f);
    let _e223 = hash_u0028_vf3_u003b((&param_869));
    h6_ = _e223;
    let _e224 = h4_;
    rxz = (10f + (_e224 * 18f));
    let _e227 = rxz;
    let _e228 = h5_;
    let _e231 = rxz;
    let _e232 = h6_;
    return vec3<f32>(_e227, (4f + (_e228 * 6f)), (_e231 * (0.7f + (_e232 * 0.6f))));
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

    let _e214 = (*i_31);
    param_870 = vec3<f32>(f32(_e214), 11f, 3f);
    let _e217 = hash_u0028_vf3_u003b((&param_870));
    h1_ = _e217;
    let _e218 = (*i_31);
    param_871 = vec3<f32>(f32(_e218), 47f, 91f);
    let _e221 = hash_u0028_vf3_u003b((&param_871));
    h2_ = _e221;
    let _e222 = (*i_31);
    param_872 = vec3<f32>(f32(_e222), 91f, 250f);
    let _e225 = hash_u0028_vf3_u003b((&param_872));
    phase_1 = (_e225 * 6.28318f);
    let _e227 = h1_;
    let _e229 = tuning.gridWidth;
    let _e233 = (*t_4);
    let _e235 = tuning.cloudDriftSpeed;
    let _e237 = ((_e227 * f32(bitcast<i32>(_e229))) + (_e233 * _e235));
    let _e239 = tuning.gridWidth;
    let _e241 = f32(bitcast<i32>(_e239));
    x_4 = (_e237 - (floor((_e237 / _e241)) * _e241));
    let _e246 = h2_;
    let _e248 = tuning.gridDepth;
    let _e252 = (*t_4);
    let _e254 = phase_1;
    let _e258 = ((_e246 * f32(bitcast<i32>(_e248))) + (sin(((_e252 * 0.12f) + _e254)) * 3f));
    let _e260 = tuning.gridDepth;
    let _e262 = f32(bitcast<i32>(_e260));
    z_5 = (_e258 - (floor((_e258 / _e262)) * _e262));
    let _e267 = x_4;
    let _e268 = z_5;
    return vec2<f32>(_e267, _e268);
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

    let _e215 = gl_GlobalInvocationID_1[1u];
    let _e216 = (_e215 != 0u);
    phi_1689_ = _e216;
    if !(_e216) {
        let _e219 = gl_GlobalInvocationID_1[2u];
        phi_1689_ = (_e219 != 0u);
    }
    let _e222 = phi_1689_;
    if _e222 {
        return;
    }
    let _e224 = gl_GlobalInvocationID_1[0u];
    i_32 = _e224;
    let _e225 = i_32;
    if (_e225 >= 64u) {
        return;
    }
    let _e227 = i_32;
    param_873 = bitcast<i32>(_e227);
    let _e230 = pc.time;
    param_874 = _e230;
    let _e231 = cloudCenterXZSource_u0028_i1_u003b_f1_u003b((&param_873), (&param_874));
    c_9 = _e231;
    let _e232 = i_32;
    param_875 = bitcast<i32>(_e232);
    let _e234 = cloudRadiiSource_u0028_i1_u003b((&param_875));
    r_6 = _e234;
    let _e235 = i_32;
    param_876 = vec3<f32>(f32(_e235), 133f, 7f);
    let _e238 = hash_u0028_vf3_u003b((&param_876));
    h3_ = _e238;
    let _e240 = tuning.gridHeight;
    let _e244 = r_6[1u];
    let _e246 = h3_;
    cy = ((f32(bitcast<i32>(_e240)) + _e244) + (_e246 * 4f));
    let _e249 = i_32;
    let _e253 = c_9[0u];
    unnamed_1.cloudCache[((_e249 * 7u) + 0u)] = _e253;
    let _e256 = i_32;
    let _e259 = cy;
    unnamed_1.cloudCache[((_e256 * 7u) + 1u)] = _e259;
    let _e262 = i_32;
    let _e266 = c_9[1u];
    unnamed_1.cloudCache[((_e262 * 7u) + 2u)] = _e266;
    let _e269 = i_32;
    let _e273 = r_6[0u];
    unnamed_1.cloudCache[((_e269 * 7u) + 3u)] = _e273;
    let _e276 = i_32;
    let _e280 = r_6[1u];
    unnamed_1.cloudCache[((_e276 * 7u) + 4u)] = _e280;
    let _e283 = i_32;
    let _e287 = r_6[2u];
    unnamed_1.cloudCache[((_e283 * 7u) + 5u)] = _e287;
    let _e290 = i_32;
    let _e293 = c_9;
    param_877 = _e293;
    let _e294 = cloudEdgeFade_u0028_vf2_u003b((&param_877));
    unnamed_1.cloudCache[((_e290 * 7u) + 6u)] = _e294;
    return;
}

fn getRainThreshold_u0028_() -> u32 {
    let _e205 = tuning.rainStartLayers;
    let _e207 = tuning.gridWidth;
    let _e211 = tuning.gridHeight;
    return (_e205 * (bitcast<u32>(bitcast<i32>(_e207)) * bitcast<u32>(bitcast<i32>(_e211))));
}

fn getWaterDeficit_u0028_() -> u32 {
    var local_30: u32;

    let _e206 = atomicLoad((&unnamed_1.waterHighMark));
    let _e208 = atomicLoad((&unnamed_1.waterVoxelCount));
    if (_e206 > _e208) {
        let _e211 = atomicLoad((&unnamed_1.waterHighMark));
        let _e213 = atomicLoad((&unnamed_1.waterVoxelCount));
        local_30 = (_e211 - _e213);
    } else {
        local_30 = 0u;
    }
    let _e215 = local_30;
    return _e215;
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

    let _e229 = gl_GlobalInvocationID_1[0u];
    let _e230 = (_e229 != 0u);
    phi_8301_ = _e230;
    if !(_e230) {
        let _e233 = gl_GlobalInvocationID_1[1u];
        phi_8301_ = (_e233 != 0u);
    }
    let _e236 = phi_8301_;
    phi_8308_ = _e236;
    if !(_e236) {
        let _e239 = gl_GlobalInvocationID_1[2u];
        phi_8308_ = (_e239 != 0u);
    }
    let _e242 = phi_8308_;
    if _e242 {
        return;
    }
    live = 0u;
    i_33 = 0i;
    loop {
        let _e243 = i_33;
        if (_e243 < 8i) {
            let _e245 = i_33;
            let _e248 = atomicLoad((&unnamed_1.blackHoles[_e245]));
            code_6 = _e248;
            let _e249 = code_6;
            if (_e249 == 0u) {
                continue;
            }
            let _e251 = code_6;
            voxel = (_e251 & 1073741823u);
            let _e253 = voxel;
            param_878 = _e253;
            let _e254 = readCell_u0028_u1_u003b((&param_878));
            param_879 = _e254;
            let _e255 = getType_u0028_u1_u003b((&param_879));
            if (_e255 != 7u) {
                let _e257 = i_33;
                atomicStore((&unnamed_1.blackHoles[_e257]), 0u);
                continue;
            }
            let _e260 = i_33;
            let _e263 = unnamed_1.blackHoleStarve[_e260];
            starve = (_e263 + 1u);
            let _e265 = i_33;
            let _e266 = starve;
            unnamed_1.blackHoleStarve[_e265] = _e266;
            let _e269 = code_6;
            param_880 = _e269;
            let _e270 = bhIsPurge_u0028_u1_u003b((&param_880));
            purge_2 = _e270;
            let _e271 = purge_2;
            if _e271 {
                let _e273 = tuning.purgeStarveGrace;
                local_31 = _e273;
            } else {
                let _e275 = tuning.blackHoleStarveGrace;
                local_31 = _e275;
            }
            let _e276 = local_31;
            grace = _e276;
            let _e277 = purge_2;
            if _e277 {
                let _e279 = tuning.purgeDecayRate;
                local_32 = _e279;
            } else {
                let _e281 = tuning.blackHoleDecayRate;
                local_32 = _e281;
            }
            let _e282 = local_32;
            decay = _e282;
            let _e283 = starve;
            let _e284 = grace;
            if (_e283 > _e284) {
                let _e286 = i_33;
                let _e289 = atomicLoad((&unnamed_1.blackHoleMass[_e286]));
                mass_2 = _e289;
                let _e290 = mass_2;
                if (_e290 == 0u) {
                    let _e292 = voxel;
                    param_881 = _e292;
                    param_882 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_881), (&param_882));
                    let _e293 = i_33;
                    atomicStore((&unnamed_1.blackHoles[_e293]), 0u);
                    continue;
                }
                let _e296 = i_33;
                let _e297 = mass_2;
                let _e298 = mass_2;
                let _e299 = decay;
                atomicStore((&unnamed_1.blackHoleMass[_e296]), (_e297 - min(_e298, _e299)));
            }
            let _e304 = live;
            live = (_e304 + bitcast<u32>(1i));
            continue;
        } else {
            break;
        }
        continuing {
            let _e307 = i_33;
            i_33 = (_e307 + 1i);
        }
    }
    let _e309 = live;
    unnamed_1.blackHoleCount = _e309;
    let _e312 = unnamed_1.rainPhase;
    let _e313 = (_e312 == 0u);
    phi_8425_ = _e313;
    if _e313 {
        let _e315 = atomicLoad((&unnamed_1.waterVoxelCount));
        let _e317 = atomicLoad((&unnamed_1.waterHighMark));
        phi_8425_ = (_e315 > _e317);
    }
    let _e320 = phi_8425_;
    if _e320 {
        let _e322 = atomicLoad((&unnamed_1.waterVoxelCount));
        atomicStore((&unnamed_1.waterHighMark), _e322);
    }
    let _e324 = getWaterDeficit_u0028_();
    deficit = _e324;
    let _e326 = atomicLoad((&unnamed_1.maxOccupiedY));
    if (_e326 > 0u) {
        let _e329 = atomicAdd((&unnamed_1.maxOccupiedY), 4294967295u);
    }
    let _e331 = atomicLoad((&unnamed_1.rainCandidateCount));
    unnamed_1.rainCandidateEstimate = _e331;
    atomicStore((&unnamed_1.rainCandidateCount), 0u);
    let _e335 = unnamed_1.rainTargetLevel;
    let _e337 = atomicLoad((&unnamed_1.waterVoxelCount));
    if (_e335 > _e337) {
        let _e340 = unnamed_1.rainTargetLevel;
        let _e342 = atomicLoad((&unnamed_1.waterVoxelCount));
        local_33 = (_e340 - _e342);
    } else {
        local_33 = 0u;
    }
    let _e344 = local_33;
    remainingToTarget = _e344;
    let _e346 = unnamed_1.rainPhase;
    if (_e346 == 0u) {
        let _e349 = atomicLoad((&unnamed_1.cloudWaterCount));
        local_34 = _e349;
    } else {
        let _e350 = remainingToTarget;
        local_34 = _e350;
    }
    let _e351 = local_34;
    chargeSource = _e351;
    let _e352 = chargeSource;
    let _e355 = tuning.cloudChargeSaturation;
    chargeTarget = clamp((f32(_e352) / max(_e355, 1f)), 0f, 1f);
    let _e360 = unnamed_1.cloudChargeBits;
    charge = bitcast<f32>(_e360);
    let _e362 = chargeTarget;
    let _e363 = charge;
    let _e366 = tuning.cloudChargeEaseRate;
    let _e369 = charge;
    charge = (_e369 + ((_e362 - _e363) * clamp(_e366, 0f, 1f)));
    let _e371 = charge;
    unnamed_1.cloudChargeBits = bitcast<u32>(clamp(_e371, 0f, 1f));
    let _e376 = unnamed_1.rainPhase;
    if (_e376 == 0u) {
        let _e379 = atomicLoad((&unnamed_1.cloudWaterCount));
        let _e380 = (_e379 > 0u);
        phi_8510_ = _e380;
        if _e380 {
            let _e381 = deficit;
            let _e382 = getRainThreshold_u0028_();
            phi_8510_ = (_e381 > _e382);
        }
        let _e385 = phi_8510_;
        if _e385 {
            unnamed_1.rainPhase = 1u;
            let _e388 = pc.time;
            unnamed_1.rainPhaseTimeBits = bitcast<u32>(_e388);
            let _e392 = atomicLoad((&unnamed_1.waterHighMark));
            let _e393 = deficit;
            let _e396 = tuning.rainOvershoot;
            unnamed_1.rainTargetLevel = (_e392 + u32((f32(_e393) * max(_e396, 0f))));
        }
    } else {
        let _e403 = unnamed_1.rainPhase;
        if (_e403 == 1u) {
            let _e406 = unnamed_1.rainPhaseTimeBits;
            crossedTime = bitcast<f32>(_e406);
            let _e409 = pc.time;
            let _e410 = crossedTime;
            let _e413 = tuning.rainDarkenDelay;
            if ((_e409 - _e410) >= _e413) {
                unnamed_1.rainPhase = 2u;
                let _e417 = pc.time;
                unnamed_1.rainPhaseTimeBits = bitcast<u32>(_e417);
            }
        } else {
            let _e421 = unnamed_1.rainPhase;
            if (_e421 == 2u) {
                let _e423 = remainingToTarget;
                if (_e423 == 0u) {
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
    var phi_9060_: bool;
    var phi_9067_: bool;
    var phi_9078_: bool;
    var phi_9085_: bool;
    var phi_9096_: bool;
    var phi_9119_: bool;
    var phi_9129_: bool;
    var phi_9307_: bool;

    let _e328 = gl_GlobalInvocationID_1;
    pos_20 = bitcast<vec3<i32>>(_e328);
    let _e331 = pos_20[0u];
    let _e333 = tuning.gridWidth;
    let _e335 = (_e331 >= bitcast<i32>(_e333));
    phi_8936_ = _e335;
    if !(_e335) {
        let _e338 = pos_20[1u];
        let _e340 = tuning.gridHeight;
        phi_8936_ = (_e338 >= bitcast<i32>(_e340));
    }
    let _e344 = phi_8936_;
    phi_8946_ = _e344;
    if !(_e344) {
        let _e347 = pos_20[2u];
        let _e349 = tuning.gridDepth;
        phi_8946_ = (_e347 >= bitcast<i32>(_e349));
    }
    let _e353 = phi_8946_;
    if _e353 {
        return;
    }
    updateSimState_u0028_();
    updateCloudCache_u0028_();
    let _e355 = pc.spawnActive;
    let _e356 = (_e355 == 1i);
    phi_8960_ = _e356;
    if _e356 {
        let _e357 = pos_20;
        param_883 = _e357;
        let _e358 = inBrush_u0028_vi3_u003b((&param_883));
        phi_8960_ = _e358;
    }
    let _e360 = phi_8960_;
    if _e360 {
        let _e361 = pos_20;
        param_884 = _e361;
        let _e362 = getIndex_u0028_vi3_u003b((&param_884));
        spawnIndex = _e362;
        let _e363 = spawnIndex;
        param_885 = _e363;
        let _e364 = readCell_u0028_u1_u003b((&param_885));
        param_886 = _e364;
        let _e365 = getType_u0028_u1_u003b((&param_886));
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
                    decWaterHighMark_u0028_();
                }
                let _e379 = oldType;
                if (_e379 == 7u) {
                    let _e381 = pos_20;
                    param_887 = _e381;
                    bhRelease_u0028_vi3_u003b((&param_887));
                }
                let _e382 = newType_3;
                if (_e382 == 2u) {
                    incWater_u0028_();
                }
            }
            let _e384 = newType_3;
            param_888 = _e384;
            let _e385 = isLocust_u0028_u1_u003b((&param_888));
            if _e385 {
                let _e386 = newType_3;
                param_889 = _e386;
                let _e387 = locustSpawnCount_u0028_u1_u003b((&param_889));
                local_35 = _e387;
            } else {
                let _e388 = newType_3;
                param_890 = _e388;
                let _e389 = lavaSpawnCoolness_u0028_u1_u003b((&param_890));
                local_35 = _e389;
            }
            let _e390 = local_35;
            seedAge = _e390;
            let _e391 = newType_3;
            param_891 = _e391;
            param_892 = 0u;
            param_893 = 0u;
            let _e392 = seedAge;
            param_894 = _e392;
            let _e393 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_891), (&param_892), (&param_893), (&param_894));
            let _e394 = spawnIndex;
            param_895 = _e394;
            param_896 = _e393;
            writeCell_u0028_u1_u003b_u1_u003b((&param_895), (&param_896));
            let _e395 = newType_3;
            if (_e395 == 7u) {
                let _e397 = pos_20;
                param_897 = _e397;
                let _e398 = bhRegister_u0028_vi3_u003b((&param_897));
                if !(_e398) {
                    let _e400 = spawnIndex;
                    param_898 = _e400;
                    param_899 = 0u;
                    writeCell_u0028_u1_u003b_u1_u003b((&param_898), (&param_899));
                }
            }
        }
    }
    let _e402 = pos_20[0u];
    let _e403 = (_e402 < 1i);
    phi_9060_ = _e403;
    if !(_e403) {
        let _e406 = pos_20[0u];
        let _e408 = tuning.gridWidth;
        phi_9060_ = (_e406 >= (bitcast<i32>(_e408) - 1i));
    }
    let _e413 = phi_9060_;
    phi_9067_ = _e413;
    if !(_e413) {
        let _e416 = pos_20[1u];
        phi_9067_ = (_e416 < 1i);
    }
    let _e419 = phi_9067_;
    phi_9078_ = _e419;
    if !(_e419) {
        let _e422 = pos_20[1u];
        let _e424 = tuning.gridHeight;
        phi_9078_ = (_e422 >= (bitcast<i32>(_e424) - 1i));
    }
    let _e429 = phi_9078_;
    phi_9085_ = _e429;
    if !(_e429) {
        let _e432 = pos_20[2u];
        phi_9085_ = (_e432 < 1i);
    }
    let _e435 = phi_9085_;
    phi_9096_ = _e435;
    if !(_e435) {
        let _e438 = pos_20[2u];
        let _e440 = tuning.gridDepth;
        phi_9096_ = (_e438 >= (bitcast<i32>(_e440) - 1i));
    }
    let _e445 = phi_9096_;
    if _e445 {
        return;
    }
    let _e446 = pos_20;
    param_900 = _e446;
    let _e447 = getIndex_u0028_vi3_u003b((&param_900));
    currentIndex_15 = _e447;
    let _e448 = currentIndex_15;
    param_901 = _e448;
    let _e449 = readCell_u0028_u1_u003b((&param_901));
    rawValue_13 = _e449;
    let _e450 = rawValue_13;
    param_902 = _e450;
    let _e451 = getType_u0028_u1_u003b((&param_902));
    currentType_1 = _e451;
    let _e452 = currentType_1;
    let _e453 = (_e452 == 0u);
    phi_9119_ = _e453;
    if _e453 {
        let _e455 = unnamed_1.rainPhase;
        phi_9119_ = (_e455 >= 1u);
    }
    let _e458 = phi_9119_;
    phi_9129_ = _e458;
    if _e458 {
        let _e460 = pos_20[1u];
        let _e462 = tuning.gridHeight;
        phi_9129_ = (_e460 == (bitcast<i32>(_e462) - 2i));
    }
    let _e467 = phi_9129_;
    if _e467 {
        underCloud = false;
        let _e469 = tuning.cloudCount;
        cloudN = bitcast<i32>(min(_e469, 64u));
        ci = 0i;
        loop {
            let _e472 = ci;
            let _e473 = cloudN;
            if (_e472 < _e473) {
                let _e475 = ci;
                param_903 = _e475;
                let _e476 = cloudFade_u0028_i1_u003b((&param_903));
                if (_e476 <= 0.01f) {
                    continue;
                }
                let _e478 = ci;
                param_904 = _e478;
                let _e479 = cloudCenter_u0028_i1_u003b((&param_904));
                c_10 = _e479;
                let _e480 = ci;
                param_905 = _e480;
                let _e481 = cloudRadii_u0028_i1_u003b((&param_905));
                r_7 = _e481;
                let _e483 = pos_20[0u];
                let _e486 = pos_20[2u];
                let _e489 = c_10;
                let _e493 = r_7[0u];
                let _e495 = r_7[2u];
                d_26 = ((vec2<f32>(f32(_e483), f32(_e486)) - _e489.xz) / vec2<f32>(_e493, _e495));
                let _e498 = d_26;
                let _e499 = d_26;
                if (dot(_e498, _e499) <= 1f) {
                    underCloud = true;
                    break;
                }
                continue;
            } else {
                break;
            }
            continuing {
                let _e502 = ci;
                ci = (_e502 + 1i);
            }
        }
        let _e504 = underCloud;
        if _e504 {
            let _e506 = atomicAdd((&unnamed_1.rainCandidateCount), 1u);
            let _e508 = unnamed_1.rainPhase;
            if (_e508 == 2u) {
                let _e511 = unnamed_1.rainTargetLevel;
                let _e513 = atomicLoad((&unnamed_1.waterVoxelCount));
                if (_e511 > _e513) {
                    let _e516 = unnamed_1.rainTargetLevel;
                    let _e518 = atomicLoad((&unnamed_1.waterVoxelCount));
                    local_36 = (_e516 - _e518);
                } else {
                    local_36 = 0u;
                }
                let _e520 = local_36;
                remaining_1 = _e520;
                let _e522 = unnamed_1.rainCandidateEstimate;
                param_906 = _e522;
                let _e523 = remaining_1;
                param_907 = _e523;
                let _e524 = getRainDropChance_u0028_u1_u003b_u1_u003b((&param_906), (&param_907));
                dropChance = _e524;
                let _e525 = pos_20;
                let _e528 = pc.time;
                param_908 = (vec3<f32>(_e525) + vec3<f32>((_e528 * 1.7f), 51f, 0f));
                let _e532 = hash_u0028_vf3_u003b((&param_908));
                rainRandVal = _e532;
                let _e533 = rainRandVal;
                let _e534 = dropChance;
                if (_e533 < _e534) {
                    let _e536 = currentIndex_15;
                    let _e539 = rawValue_13;
                    param_909 = 2u;
                    param_910 = 0u;
                    param_911 = 0u;
                    param_912 = 0u;
                    let _e540 = pack_u0028_u1_u003b_u1_u003b_u1_u003b_u1_u003b((&param_909), (&param_910), (&param_911), (&param_912));
                    let _e541 = atomicCompareExchangeWeak((&unnamed.grid[_e536]), _e539, _e540);
                    let _e543 = rawValue_13;
                    if (_e541.old_value == _e543) {
                        incWater_u0028_();
                        let _e546 = pos_20[1u];
                        let _e549 = atomicLoad((&unnamed_1.maxOccupiedY));
                        if (bitcast<u32>(_e546) > _e549) {
                            let _e553 = pos_20[1u];
                            let _e555 = atomicMax((&unnamed_1.maxOccupiedY), bitcast<u32>(_e553));
                        }
                        return;
                    }
                }
            }
        }
    }
    let _e556 = currentType_1;
    if (_e556 == 0u) {
        return;
    }
    let _e559 = pos_20[1u];
    let _e562 = atomicLoad((&unnamed_1.maxOccupiedY));
    if (bitcast<u32>(_e559) > _e562) {
        let _e566 = pos_20[1u];
        let _e568 = atomicMax((&unnamed_1.maxOccupiedY), bitcast<u32>(_e566));
    }
    let _e569 = pos_20;
    let _e572 = pc.time;
    param_913 = (vec3<f32>(_e569) + vec3(_e572));
    let _e575 = hash_u0028_vf3_u003b((&param_913));
    randVal_14 = _e575;
    let _e576 = currentType_1;
    let _e577 = (_e576 != 7u);
    phi_9307_ = _e577;
    if _e577 {
        let _e578 = pos_20;
        param_914 = _e578;
        let _e579 = currentIndex_15;
        param_915 = _e579;
        let _e580 = rawValue_13;
        param_916 = _e580;
        let _e581 = randVal_14;
        param_917 = _e581;
        let _e582 = captureByBlackHole_u0028_vi3_u003b_u1_u003b_u1_u003b_f1_u003b((&param_914), (&param_915), (&param_916), (&param_917));
        phi_9307_ = _e582;
    }
    let _e584 = phi_9307_;
    if _e584 {
        return;
    }
    let _e585 = currentType_1;
    let _e587 = currentType_1;
    if ((_e585 == 3u) || (_e587 == 7u)) {
        return;
    }
    let _e590 = rawValue_13;
    param_918 = _e590;
    let _e591 = getDir_u0028_u1_u003b((&param_918));
    currentDir_6 = _e591;
    let _e592 = rawValue_13;
    param_919 = _e592;
    let _e593 = getSleep_u0028_u1_u003b((&param_919));
    currentSleep_7 = _e593;
    let _e594 = rawValue_13;
    param_920 = _e594;
    let _e595 = getAge_u0028_u1_u003b((&param_920));
    currentAge_10 = _e595;
    let _e596 = currentType_1;
    switch bitcast<i32>(_e596) {
        case 1: {
            let _e598 = pos_20;
            param_921 = _e598;
            let _e599 = currentIndex_15;
            param_922 = _e599;
            let _e600 = rawValue_13;
            param_923 = _e600;
            let _e601 = currentSleep_7;
            param_924 = _e601;
            let _e602 = currentAge_10;
            param_925 = _e602;
            let _e603 = randVal_14;
            param_926 = _e603;
            updateSand_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_921), (&param_922), (&param_923), (&param_924), (&param_925), (&param_926));
            break;
        }
        case 2: {
            let _e604 = pos_20;
            param_927 = _e604;
            let _e605 = currentIndex_15;
            param_928 = _e605;
            let _e606 = rawValue_13;
            param_929 = _e606;
            let _e607 = currentDir_6;
            param_930 = _e607;
            let _e608 = currentSleep_7;
            param_931 = _e608;
            let _e609 = currentAge_10;
            param_932 = _e609;
            let _e610 = randVal_14;
            param_933 = _e610;
            updateWater_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_927), (&param_928), (&param_929), (&param_930), (&param_931), (&param_932), (&param_933));
            break;
        }
        case 4: {
            let _e611 = pos_20;
            param_934 = _e611;
            let _e612 = currentIndex_15;
            param_935 = _e612;
            let _e613 = rawValue_13;
            param_936 = _e613;
            let _e614 = currentDir_6;
            param_937 = _e614;
            let _e615 = currentSleep_7;
            param_938 = _e615;
            let _e616 = currentAge_10;
            param_939 = _e616;
            let _e617 = randVal_14;
            param_940 = _e617;
            updateDirt_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_934), (&param_935), (&param_936), (&param_937), (&param_938), (&param_939), (&param_940));
            break;
        }
        case 5: {
            let _e618 = pos_20;
            param_941 = _e618;
            let _e619 = currentIndex_15;
            param_942 = _e619;
            let _e620 = rawValue_13;
            param_943 = _e620;
            let _e621 = currentDir_6;
            param_944 = _e621;
            let _e622 = currentSleep_7;
            param_945 = _e622;
            let _e623 = currentAge_10;
            param_946 = _e623;
            let _e624 = randVal_14;
            param_947 = _e624;
            updateFire_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_941), (&param_942), (&param_943), (&param_944), (&param_945), (&param_946), (&param_947));
            break;
        }
        case 6: {
            let _e625 = pos_20;
            param_948 = _e625;
            let _e626 = currentIndex_15;
            param_949 = _e626;
            let _e627 = rawValue_13;
            param_950 = _e627;
            let _e628 = currentSleep_7;
            param_951 = _e628;
            let _e629 = currentAge_10;
            param_952 = _e629;
            let _e630 = randVal_14;
            param_953 = _e630;
            updateSteam_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_948), (&param_949), (&param_950), (&param_951), (&param_952), (&param_953));
            break;
        }
        case 9, 10, 11, 8: {
            let _e631 = pos_20;
            param_954 = _e631;
            let _e632 = currentIndex_15;
            param_955 = _e632;
            let _e633 = rawValue_13;
            param_956 = _e633;
            let _e634 = currentDir_6;
            param_957 = _e634;
            let _e635 = currentSleep_7;
            param_958 = _e635;
            let _e636 = currentAge_10;
            param_959 = _e636;
            let _e637 = randVal_14;
            param_960 = _e637;
            updateLava_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_954), (&param_955), (&param_956), (&param_957), (&param_958), (&param_959), (&param_960));
            break;
        }
        case 12: {
            let _e638 = pos_20;
            param_961 = _e638;
            let _e639 = currentIndex_15;
            param_962 = _e639;
            let _e640 = rawValue_13;
            param_963 = _e640;
            let _e641 = currentAge_10;
            param_964 = _e641;
            let _e642 = randVal_14;
            param_965 = _e642;
            updateDarkStone_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_961), (&param_962), (&param_963), (&param_964), (&param_965));
            break;
        }
        case 14, 15, 16, 17, 13: {
            let _e643 = pos_20;
            param_966 = _e643;
            let _e644 = currentIndex_15;
            param_967 = _e644;
            let _e645 = rawValue_13;
            param_968 = _e645;
            let _e646 = currentDir_6;
            param_969 = _e646;
            let _e647 = currentSleep_7;
            param_970 = _e647;
            let _e648 = currentAge_10;
            param_971 = _e648;
            let _e649 = randVal_14;
            param_972 = _e649;
            updateLocust_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_966), (&param_967), (&param_968), (&param_969), (&param_970), (&param_971), (&param_972));
            break;
        }
        case 18: {
            let _e650 = pos_20;
            param_973 = _e650;
            let _e651 = currentIndex_15;
            param_974 = _e651;
            let _e652 = rawValue_13;
            param_975 = _e652;
            let _e653 = currentDir_6;
            param_976 = _e653;
            let _e654 = currentAge_10;
            param_977 = _e654;
            let _e655 = randVal_14;
            param_978 = _e655;
            updateTrunk_u0028_vi3_u003b_u1_u003b_u1_u003b_u1_u003b_u1_u003b_f1_u003b((&param_973), (&param_974), (&param_975), (&param_976), (&param_977), (&param_978));
            break;
        }
        case 19: {
            let _e656 = pos_20;
            param_979 = _e656;
            let _e657 = currentIndex_15;
            param_980 = _e657;
            let _e658 = rawValue_13;
            param_981 = _e658;
            let _e659 = currentAge_10;
            param_982 = _e659;
            let _e660 = randVal_14;
            param_983 = _e660;
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
