// Config.cpp
#include "Config.hpp"
#include <fstream>
#include <unordered_map>
#include <iostream>
#include <algorithm>

// FUNCTION: trim
static std::string trim(const std::string& s) {
    size_t start = s.find_first_not_of(" \t\r\n");
    if (start == std::string::npos) return "";
    size_t end = s.find_last_not_of(" \t\r\n");
    return s.substr(start, end - start + 1);
}

// FUNCTION: getUint
static uint32_t getUint(const std::unordered_map<std::string, std::string>& values, const std::string& key, uint32_t fallback) {
    auto it = values.find(key);
    if (it == values.end()) return fallback;
    try {
        return static_cast<uint32_t>(std::stoul(it->second));
    }
    catch (...) {
        std::cout << "Config key '" << key << "' has an invalid integer value; using default.\n";
        return fallback;
    }
}

// FUNCTION: parseKeyValueFile
static std::unordered_map<std::string, std::string> parseKeyValueFile(const std::string& path) {
    std::unordered_map<std::string, std::string> values;

    std::ifstream file(path);
    if (!file.is_open()) {
        std::cout << "Config file '" << path << "' not found, using defaults.\n";
        return values;
    }

    std::string line;
    while (std::getline(file, line)) {
        std::string trimmed = trim(line);
        if (trimmed.empty() || trimmed[0] == '#') continue;

        size_t eq = trimmed.find('=');
        if (eq == std::string::npos) continue;

        std::string key = trim(trimmed.substr(0, eq));
        std::string value = trim(trimmed.substr(eq + 1));
        values[key] = value;
    }

    return values;
}

// FUNCTION: getFloat
static float getFloat(const std::unordered_map<std::string, std::string>& values, const std::string& key, float fallback) {
    auto it = values.find(key);
    if (it == values.end()) return fallback;
    try {
        return std::stof(it->second);
    }
    catch (...) {
        std::cout << "Config key '" << key << "' has an invalid float value; using default.\n";
        return fallback;
    }
}

// FUNCTION: loadConfig
Config loadConfig(const std::string& path) {
    Config config; // struct defaults apply unless overridden below
    auto values = parseKeyValueFile(path);

    // World shape first: everything downstream is sized against it, including the raymarch budget.
    uint32_t gridSize = getUint(values, "sim.grid_size", config.tuning.gridWidth);
    if (gridSize < 8u) {
        std::cout << "Config 'sim.grid_size' below the 8-voxel minimum; clamping to 8.\n";
        gridSize = 8u;
    }
    if (gridSize > 512u) {
        std::cout << "Config 'sim.grid_size' above the 512-voxel maximum; clamping to 512.\n";
        gridSize = 512u;
    }
    config.tuning.gridWidth = gridSize;
    config.tuning.gridHeight = gridSize;
    config.tuning.gridDepth = gridSize;

    // A DDA crossing the box visits at most W+H+D cells, so that is exactly the budget a ray needs
    // to reach the far side. 0 means "derive it", which is the default precisely so the whole world
    // stays visible when grid_size changes -- a literal here is what silently cropped the far half of
    // a large world before. A non-zero value overrides, to trade distant geometry for frame time.
    const uint32_t autoMarchSteps = config.tuning.gridWidth + config.tuning.gridHeight + config.tuning.gridDepth;
    config.tuning.marchMaxSteps = getUint(values, "render.march_max_steps", 0u);
    if (config.tuning.marchMaxSteps == 0u) config.tuning.marchMaxSteps = autoMarchSteps;
    config.tuning.shadowMaxSteps = getUint(values, "render.shadow_max_steps", config.tuning.shadowMaxSteps);

    config.tuning.rainStartLayers = getUint(values, "rain.start_layers", config.tuning.rainStartLayers);
    config.tuning.rainDropsPerTick = getUint(values, "rain.drops_per_tick", config.tuning.rainDropsPerTick);
    config.tuning.rainOvershoot = getFloat(values, "rain.overshoot", config.tuning.rainOvershoot);
    config.tuning.rainDarkenDelay = getFloat(values, "rain.darken_delay", config.tuning.rainDarkenDelay);
    config.tuning.cloudCount = getUint(values, "cloud.count", config.tuning.cloudCount);
    config.tuning.cloudDriftSpeed = getFloat(values, "cloud.drift_speed", config.tuning.cloudDriftSpeed);
    config.tuning.cloudEdgeFadeDist = getFloat(values, "cloud.edge_fade_dist", config.tuning.cloudEdgeFadeDist);
    config.tuning.cloudChargeSaturation = getFloat(values, "cloud.charge_saturation", config.tuning.cloudChargeSaturation);
    config.tuning.cloudChargeEaseRate = getFloat(values, "cloud.charge_ease_rate", config.tuning.cloudChargeEaseRate);
    config.tuning.cloudMinAlpha = getFloat(values, "cloud.min_alpha", config.tuning.cloudMinAlpha);
    config.tuning.cloudMaxAlpha = getFloat(values, "cloud.max_alpha", config.tuning.cloudMaxAlpha);
    config.tuning.cloudVoxelSize = getFloat(values, "cloud.voxel_size", config.tuning.cloudVoxelSize);
    config.tuning.cloudEdgeThresholdMin = getFloat(values, "cloud.edge_threshold_min", config.tuning.cloudEdgeThresholdMin);
    config.tuning.cloudEdgeThresholdMax = getFloat(values, "cloud.edge_threshold_max", config.tuning.cloudEdgeThresholdMax);
    config.tuning.maxCloudSteps = getUint(values, "cloud.max_steps", config.tuning.maxCloudSteps);
    config.tuning.sandMoistureCapacity = getUint(values, "physics.sand_moisture_capacity", config.tuning.sandMoistureCapacity);
    config.tuning.dirtMoistureCapacity = getUint(values, "physics.dirt_moisture_capacity", config.tuning.dirtMoistureCapacity);
    config.tuning.sandWaterAbsorbUnit = getUint(values, "physics.sand_water_absorb_unit", config.tuning.sandWaterAbsorbUnit);
    config.tuning.sandClumpThreshold = getUint(values, "physics.sand_clump_threshold", config.tuning.sandClumpThreshold);
    config.tuning.dirtClumpThreshold = getUint(values, "physics.dirt_clump_threshold", config.tuning.dirtClumpThreshold);
    config.tuning.wakeSleepThreshold = getUint(values, "physics.wake_sleep_threshold", config.tuning.wakeSleepThreshold);
    config.tuning.emptyBelowWakeCount = getUint(values, "physics.empty_below_wake_count", config.tuning.emptyBelowWakeCount);
    config.tuning.waterSpreadRadius = getUint(values, "physics.water_spread_radius", config.tuning.waterSpreadRadius);
    config.tuning.fireLifetime = getUint(values, "physics.fire_lifetime", config.tuning.fireLifetime);
    config.tuning.fireDryRate = getUint(values, "physics.fire_dry_rate", config.tuning.fireDryRate);
    config.tuning.grassGrowChance = getFloat(values, "physics.grass_grow_chance", config.tuning.grassGrowChance);
    config.tuning.grassSubmergedDecayChance = getFloat(values, "physics.grass_submerged_decay_chance", config.tuning.grassSubmergedDecayChance);
    config.tuning.fireBurnGrassChance = getFloat(values, "physics.fire_burn_grass_chance", config.tuning.fireBurnGrassChance);
    config.tuning.fireSpreadChance = getFloat(values, "physics.fire_spread_chance", config.tuning.fireSpreadChance);
    config.tuning.steamScatterChance = getFloat(values, "physics.steam_scatter_chance", config.tuning.steamScatterChance);
    config.tuning.blackHoleHorizon = getUint(values, "blackhole.horizon", config.tuning.blackHoleHorizon);
    config.tuning.blackHoleRadius = getUint(values, "blackhole.radius", config.tuning.blackHoleRadius);
    config.tuning.blackHoleOrbitSpeed = getFloat(values, "blackhole.orbit_speed", config.tuning.blackHoleOrbitSpeed);
    config.tuning.blackHoleInfall = getFloat(values, "blackhole.infall", config.tuning.blackHoleInfall);
    config.tuning.blackHolePlaneGrip = getFloat(values, "blackhole.plane_grip", config.tuning.blackHolePlaneGrip);
    config.tuning.blackHoleGlow = getFloat(values, "blackhole.glow", config.tuning.blackHoleGlow);
    config.tuning.blackHoleOrbitPlanes = getUint(values, "blackhole.orbit_planes", config.tuning.blackHoleOrbitPlanes);
    config.tuning.blackHoleGrowthCost = getFloat(values, "blackhole.growth_cost", config.tuning.blackHoleGrowthCost);
    config.tuning.blackHoleMaxLevel = getUint(values, "blackhole.max_level", config.tuning.blackHoleMaxLevel);
    config.tuning.blackHoleStarveGrace = getUint(values, "blackhole.starve_grace", config.tuning.blackHoleStarveGrace);
    config.tuning.blackHoleDecayRate = getUint(values, "blackhole.decay_rate", config.tuning.blackHoleDecayRate);
    config.tuning.purgeLevel = getUint(values, "purge.level", config.tuning.purgeLevel);
    config.tuning.purgeMass = getUint(values, "purge.mass", config.tuning.purgeMass);
    config.tuning.purgeStarveGrace = getUint(values, "purge.starve_grace", config.tuning.purgeStarveGrace);
    config.tuning.purgeDecayRate = getUint(values, "purge.decay_rate", config.tuning.purgeDecayRate);
    config.tuning.purgeOrbitSpeed = getFloat(values, "purge.orbit_speed", config.tuning.purgeOrbitSpeed);
    config.tuning.purgeInfall = getFloat(values, "purge.infall", config.tuning.purgeInfall);
    config.tuning.waterShadowTransmit = getFloat(values, "water.shadow_transmit", config.tuning.waterShadowTransmit);
    config.tuning.waterWaveStrength = getFloat(values, "water.wave_strength", config.tuning.waterWaveStrength);
    config.tuning.waterWaveScale = getFloat(values, "water.wave_scale", config.tuning.waterWaveScale);
    config.tuning.waterWaveSpeed = getFloat(values, "water.wave_speed", config.tuning.waterWaveSpeed);
    config.tuning.lavaStageSize = getUint(values, "lava.stage_size", config.tuning.lavaStageSize);
    config.tuning.lavaViscosity = getFloat(values, "lava.viscosity", config.tuning.lavaViscosity);
    config.tuning.lavaSpreadRadius = getUint(values, "lava.spread_radius", config.tuning.lavaSpreadRadius);
    config.tuning.lavaWaterCool = getUint(values, "lava.water_cool", config.tuning.lavaWaterCool);
    config.tuning.lavaMoistureCool = getUint(values, "lava.moisture_cool", config.tuning.lavaMoistureCool);
    config.tuning.lavaRestCoolChance = getFloat(values, "lava.rest_cool_chance", config.tuning.lavaRestCoolChance);
    config.tuning.lavaConsumeChance = getFloat(values, "lava.consume_chance", config.tuning.lavaConsumeChance);
    config.tuning.lavaIgniteChance = getFloat(values, "lava.ignite_chance", config.tuning.lavaIgniteChance);
    config.tuning.darkStoneDryChance = getFloat(values, "lava.dark_stone_dry_chance", config.tuning.darkStoneDryChance);
    config.tuning.locustTickDispatches = getUint(values, "locust.tick_dispatches", config.tuning.locustTickDispatches);
    config.tuning.locustStageSize = getUint(values, "locust.stage_size", config.tuning.locustStageSize);
    config.tuning.locustSpawnSize = getUint(values, "locust.spawn_size", config.tuning.locustSpawnSize);
    config.tuning.locustMaxSize = getUint(values, "locust.max_size", config.tuning.locustMaxSize);
    config.tuning.locustBudSize = getUint(values, "locust.bud_size", config.tuning.locustBudSize);
    config.tuning.locustEatGain = getUint(values, "locust.eat_gain", config.tuning.locustEatGain);
    config.tuning.locustEatTicksMin = getUint(values, "locust.eat_ticks_min", config.tuning.locustEatTicksMin);
    config.tuning.locustEatTicksMax = getUint(values, "locust.eat_ticks_max", config.tuning.locustEatTicksMax);
    config.tuning.locustRunLength = getUint(values, "locust.run_length", config.tuning.locustRunLength);
    config.tuning.locustClimbChance = getFloat(values, "locust.climb_chance", config.tuning.locustClimbChance);
    config.tuning.locustDensityMin = getFloat(values, "locust.density_min", config.tuning.locustDensityMin);
    config.tuning.locustDensityMax = getFloat(values, "locust.density_max", config.tuning.locustDensityMax);
    config.tuning.locustSubdivision = getUint(values, "locust.subdivision", config.tuning.locustSubdivision);
    config.tuning.locustCrawlRate = getFloat(values, "locust.crawl_rate", config.tuning.locustCrawlRate);

    config.tuning.treeBloomChance = getFloat(values, "tree.bloom_chance", config.tuning.treeBloomChance);
    config.tuning.treeMaxHeight = getUint(values, "tree.max_height", config.tuning.treeMaxHeight);
    config.tuning.treeSoilReserve = getUint(values, "tree.soil_reserve", config.tuning.treeSoilReserve);
    config.tuning.treeWaterMax = getUint(values, "tree.water_max", config.tuning.treeWaterMax);
    config.tuning.treeDrinkChance = getFloat(values, "tree.drink_chance", config.tuning.treeDrinkChance);
    config.tuning.treeFlowChance = getFloat(values, "tree.flow_chance", config.tuning.treeFlowChance);
    config.tuning.treeGrowCost = getUint(values, "tree.grow_cost", config.tuning.treeGrowCost);
    config.tuning.treeLeafCost = getUint(values, "tree.leaf_cost", config.tuning.treeLeafCost);
    config.tuning.treeSpreadCost = getUint(values, "tree.spread_cost", config.tuning.treeSpreadCost);
    config.tuning.treeSpreadChance = getFloat(values, "tree.spread_chance", config.tuning.treeSpreadChance);
    config.tuning.treeLeafChance = getFloat(values, "tree.leaf_chance", config.tuning.treeLeafChance);
    config.tuning.treeLeafReach = getUint(values, "tree.leaf_reach", config.tuning.treeLeafReach);
    config.tuning.treeLeafSpreadChance = getFloat(values, "tree.leaf_spread_chance", config.tuning.treeLeafSpreadChance);
    config.tuning.treeLeafTickChance = getFloat(values, "tree.leaf_tick_chance", config.tuning.treeLeafTickChance);
    config.tuning.treeLeafDecayChance = getFloat(values, "tree.leaf_decay_chance", config.tuning.treeLeafDecayChance);
    config.tuning.treeLeafBurnChance = getFloat(values, "tree.leaf_burn_chance", config.tuning.treeLeafBurnChance);
    config.tuning.treeTrunkColumns = getUint(values, "tree.trunk_columns", config.tuning.treeTrunkColumns);
    config.tuning.treeTrunkRadius = getFloat(values, "tree.trunk_radius", config.tuning.treeTrunkRadius);

    // The trunk's height counter and the leaf's distance counter are each one byte, and a max height
    // of 0 would leave a sapling unable to ever be a crown -- so it would never put out a leaf.
    config.tuning.treeMaxHeight = std::clamp(config.tuning.treeMaxHeight, 1u, 255u);
    config.tuning.treeLeafReach = std::clamp(config.tuning.treeLeafReach, 1u, 200u);
    config.tuning.treeWaterMax = std::clamp(config.tuning.treeWaterMax, 1u, 255u);

    // Every locust field below shares a voxel's three spare bytes, so each has a hard ceiling that
    // is a property of the packing rather than a taste call -- past it the value silently wraps and
    // the swarm's behaviour goes strange rather than merely wrong.
    //
    // The tick phase lives in the sleep byte and is compared against this, so an interval it can
    // never reach freezes every swarm in the world; 0 does the same from the other end.
    config.tuning.locustTickDispatches = std::clamp(config.tuning.locustTickDispatches, 1u, 255u);
    // The eat timer lives in the dir byte and counts up to this.
    config.tuning.locustEatTicksMax = std::clamp(config.tuning.locustEatTicksMax, 1u, 255u);
    config.tuning.locustEatTicksMin = std::clamp(config.tuning.locustEatTicksMin, 1u, config.tuning.locustEatTicksMax);
    // Steps left in a run get 3 bits alongside the heading's 3.
    config.tuning.locustRunLength = std::clamp(config.tuning.locustRunLength, 1u, 7u);
    // The stage table is exactly 5 wide, so the cap has to be reachable within 5 bands or the top
    // stages would be unreachable and the head count could outrun its own type.
    if (config.tuning.locustStageSize == 0u) config.tuning.locustStageSize = 1u;
    config.tuning.locustMaxSize = std::min(config.tuning.locustMaxSize, config.tuning.locustStageSize * 5u);
    config.tuning.locustMaxSize = std::max(config.tuning.locustMaxSize, 1u);
    // The head count shares an 8-bit field with nothing, but it is still one byte.
    config.tuning.locustMaxSize = std::min(config.tuning.locustMaxSize, 255u);

    return config;
}