// Config.cpp
#include "Config.hpp"
#include <fstream>
#include <unordered_map>
#include <iostream>

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
    config.tuning.waterShadowTransmit = getFloat(values, "water.shadow_transmit", config.tuning.waterShadowTransmit);

    return config;
}