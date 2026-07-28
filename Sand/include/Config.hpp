// Config.hpp
#pragma once

#include <string>

// Values read from the config file that get uploaded into the shader-side TuningParams
// uniform buffer (binding = 2, shared by falling_sand.comp and raymarch.frag).
// Layout must stay a flat struct of floats/ints to map directly onto the UBO's std140 layout --
// add new fields at the end, and mirror any addition in both shaders' TuningParams block.
struct TuningParams {
    float rainChanceStart = 0.0001f;
    float rainChanceMax = 0.002f;
    float rainRampDuration = 30.0f;
    float cloudRevealCooldown = 1.5f;
    uint32_t cloudRevealTargetSlots = 15;
    uint32_t rainStartLayers = 2;
    uint32_t rainMinWaterInCubeLayers = 10;
    float rainDarkenDelay = 6.0f;
    float cloudFadeDuration = 2.5f;
    float cloudDensitySaturation = 300.0f;
    float cloudDisappearDuration = 5.0f;
    float cloudVoxelSize = 3.0f;
    float cloudEdgeThresholdMin = 0.15f;
    float cloudEdgeThresholdMax = 0.7f;
    uint32_t maxCloudSteps = 32;
    uint32_t sandMoistureCapacity = 10;
    uint32_t dirtMoistureCapacity = 30;
    uint32_t sandWaterAbsorbUnit = 90;
    uint32_t sandClumpThreshold = 9;
    uint32_t dirtClumpThreshold = 5;
    uint32_t wakeSleepThreshold = 5;
    uint32_t emptyBelowWakeCount = 6;
    uint32_t waterAgeTimeout = 200;
    uint32_t fireLifetime = 30;
    uint32_t fireDryRate = 5;
    float grassGrowChance = 0.001f;
    float grassSubmergedDecayChance = 0.1f;
    float fireBurnGrassChance = 0.05f;
    float fireSpreadChance = 0.1f;
    float steamScatterChance = 0.3f;
};

// Config: everything loaded from the config file. Currently just the shader tuning params;
// later batches will add C++-side sections (camera, UI defaults, etc.) alongside this.
struct Config {
    TuningParams tuning;
};

// Loads key=value pairs from the given path. Missing file or missing keys silently fall back
// to the defaults above -- never throws, so a missing/partial config file can't crash startup.
Config loadConfig(const std::string& path);