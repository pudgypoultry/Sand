// Config.hpp
#pragma once

#include <string>

// Values read from the config file that get uploaded into the shader-side TuningParams
// uniform buffer (binding = 2, shared by falling_sand.comp and raymarch.frag).
// Layout must stay a flat struct of floats/ints to map directly onto the UBO's std140 layout --
// add new fields at the end, and mirror any addition in both shaders' TuningParams block.
struct TuningParams {
    // --- Rain ---
    // A storm begins once the water deficit exceeds rainStartLayers full grid layers, then
    // returns water at rainDropsPerTick per dispatch until the deficit is repaid -- so storm
    // length scales with how much actually went missing. The rate is achieved by dividing
    // rainDropsPerTick across a live census of rainable columns, giving every column under any
    // cloud identical odds, so rain stays evenly spread no matter how many clouds are overhead.
    // rainOvershoot is deliberate headroom: drops still falling already count as water, so the
    // level reads restored slightly before they land (and some then soak into soil instead of
    // pooling). 0.2 delivers 20% past the measured deficit to absorb that.
    uint32_t rainStartLayers = 2;
    uint32_t rainDropsPerTick = 50;
    float rainOvershoot = 0.2f;
    float rainDarkenDelay = 6.0f;
    // --- Clouds ---
    // A fixed population of cloudCount clouds drifts along +X and wraps, dissolving over
    // cloudEdgeFadeDist as it nears a border. The whole field shares one "charge" value -- eased
    // toward banked steam before a storm and toward the outstanding water deficit during one --
    // which drives opacity between cloudMinAlpha and cloudMaxAlpha and greys the field as it
    // rises, so the sky reacts as a single mass instead of clouds appearing one at a time.
    uint32_t cloudCount = 32;          // hard-capped at 64 by the shaders
    float cloudDriftSpeed = 2.0f;      // world units per second
    float cloudEdgeFadeDist = 20.0f;
    float cloudChargeSaturation = 20000.0f;
    float cloudChargeEaseRate = 0.02f; // per dispatch, so it is framerate-dependent by design
    float cloudMinAlpha = 0.05f;       // set to 0 for a completely clear sky until steam appears
    float cloudMaxAlpha = 0.9f;
    float cloudVoxelSize = 3.0f;
    float cloudEdgeThresholdMin = 0.15f;
    float cloudEdgeThresholdMax = 0.7f;
    uint32_t maxCloudSteps = 32;
    // --- Physics ---
    uint32_t sandMoistureCapacity = 10;
    uint32_t dirtMoistureCapacity = 30;
    uint32_t sandWaterAbsorbUnit = 90;
    uint32_t sandClumpThreshold = 9;
    uint32_t dirtClumpThreshold = 5;
    uint32_t wakeSleepThreshold = 5;
    uint32_t emptyBelowWakeCount = 6;
    uint32_t fireLifetime = 30;
    uint32_t fireDryRate = 5;
    float grassGrowChance = 0.001f;
    float grassSubmergedDecayChance = 0.1f;
    float fireBurnGrassChance = 0.05f;
    float fireSpreadChance = 0.1f;
    float steamScatterChance = 0.3f;
    // --- Black hole ---
    // Anything inside blackHoleRadius stops running its own material update and follows the hole's
    // orbit field instead. That field is overwhelmingly tangential: blackHoleInfall is how much
    // straight-in pull is mixed on top, and keeping it small is what makes captured matter wind
    // up into a spiral rather than dropping down the throat. blackHoleOrbitSpeed scales a per-tick
    // step probability of ~speed/sqrt(radius), so inner orbits shear visibly past outer ones.
    //
    // Orbits are spread over every inclination rather than a single disk: each hole owns a fan of
    // blackHoleOrbitPlanes candidate planes and a particle rides whichever one most nearly contains
    // it, so the captured population is a shell of great circles at all angles. blackHolePlaneGrip
    // is how firmly a particle is held in its own plane -- drop it to 0 and orbits smear into a
    // diffuse cloud.
    //
    // A hole voids a cubic shell around itself -- Chebyshev distance <= level + blackHoleHorizon --
    // so at level 0 with horizon 1 it clears a 3x3x3 region and never sits flush against what it
    // eats. Its body grows with what it swallows: side length 2*level+1 (1x1x1, 3x3x3, 5x5x5, ...),
    // advancing a level once it has eaten blackHoleGrowthCost times that size's voxel count. Its
    // reach grows with it, by one voxel per level.
    //
    // blackHoleGrowthCost must stay above 1, and that bound is not arbitrary. The void region at
    // level L holds (2L+3)^3 voxels, which is exactly the count a cost of 1.0 requires to reach
    // level L+1 -- so at 1.0 a hole dropped in solid matter is always paid for its next level by its
    // own expansion and cascades to blackHoleMaxLevel in a few ticks. At 2.0 the void shell covers
    // half of each level, so the rest has to be accreted from orbit and growth stays driven by what
    // actually spirals in.
    uint32_t blackHoleHorizon = 1; // measured past the body's face, not from its centre
    uint32_t blackHoleRadius = 28;
    float blackHoleOrbitSpeed = 2.2f;
    float blackHoleInfall = 0.16f;
    float blackHolePlaneGrip = 0.5f;
    float blackHoleGlow = 0.85f;
    uint32_t blackHoleOrbitPlanes = 16; // hard-capped at 32 by the shaders
    float blackHoleGrowthCost = 2.0f; // keep above 1.0 -- see the cascade note above
    uint32_t blackHoleMaxLevel = 8;     // 8 -> a 17x17x17 body at full size
};

// Config: everything loaded from the config file. Currently just the shader tuning params;
// later batches will add C++-side sections (camera, UI defaults, etc.) alongside this.
struct Config {
    TuningParams tuning;
};

// Loads key=value pairs from the given path. Missing file or missing keys silently fall back
// to the defaults above -- never throws, so a missing/partial config file can't crash startup.
Config loadConfig(const std::string& path);