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
    // orbit field instead. That field is overwhelmingly tangential; blackHoleInfall is the chance
    // per move that a particle takes a spiralling-inward step instead, which is what makes the orbit
    // decay over many revolutions rather than dropping straight down the throat. Note it is a
    // probability, not a weight: a one-voxel move cannot carry a magnitude, and blending infall into
    // the direction instead locks orbits onto a fixed radius forever (see updateOrbital).
    // blackHoleOrbitSpeed scales a per-tick step probability of ~speed/sqrt(radius) for the same
    // reason, so inner orbits shear visibly past outer ones.
    //
    // Orbits are spread over every inclination rather than a single disk: each hole owns a fan of
    // blackHoleOrbitPlanes candidate planes and a particle rides whichever one most nearly contains
    // it, so the captured population is a shell of great circles at all angles. blackHolePlaneGrip
    // is how firmly a particle is held in its own plane -- drop it to 0 and orbits smear into a
    // diffuse cloud.
    //
    // A hole's body is a ball of radius level + 0.5, so its diameter runs 1, 3, 5, ... voxels as it
    // grows. It voids a spherical shell around that -- everything within level + 0.5 +
    // blackHoleHorizon -- so it never sits flush against what it eats. It advances a level once it
    // has swallowed blackHoleGrowthCost times the next size's own volume, and its reach grows with
    // it by one voxel per level.
    //
    // blackHoleGrowthCost must stay above 1, and that bound is not arbitrary. The void ball at level
    // L holds almost exactly the voxel count a cost of 1.0 requires to reach level L+1, so at 1.0 a
    // hole dropped in solid matter is always paid for its next level by its own expansion and
    // cascades to blackHoleMaxLevel in a few ticks. At 2.0 the void shell covers half of each level,
    // so the rest has to be accreted from orbit and growth stays driven by what actually spirals in.
    //
    // A hole with nothing captured within its reach starves: after blackHoleStarveGrace dispatches
    // it sheds blackHoleDecayRate of mass per dispatch, visibly shrinking, and is removed outright
    // once it hits zero. Capturing anything at all resets the clock, so only a hole in genuinely
    // empty space -- or one that has already eaten everything near it -- evaporates.
    uint32_t blackHoleHorizon = 1; // measured past the body's surface, not from its centre
    uint32_t blackHoleRadius = 28;
    float blackHoleOrbitSpeed = 2.2f;
    float blackHoleInfall = 0.16f;
    float blackHolePlaneGrip = 0.5f;
    float blackHoleGlow = 0.85f;
    uint32_t blackHoleOrbitPlanes = 16; // hard-capped at 32 by the shaders
    float blackHoleGrowthCost = 2.0f; // keep above 1.0 -- see the cascade note above
    uint32_t blackHoleMaxLevel = 8;     // 8 -> a 17-voxel-wide body at full size
    uint32_t blackHoleStarveGrace = 300; // dispatches with nothing captured before decay starts
    uint32_t blackHoleDecayRate = 1;     // mass shed per dispatch once starving
    // --- Water shadows ---
    // Fraction of light that survives crossing one water voxel on a shadow ray. Water used to block
    // shadow rays outright like any solid, and that hard binary test -- not the surface normal -- was
    // overwhelmingly the source of water's jitter: when a surface voxel shuffles one cell, a nearby
    // shadow ray flips blocked/unblocked and that pixel's brightness swings by the entire sun term.
    // Measured against a one-voxel hop, the shading change is 0.253 at 0.0 (hard block) versus 0.012
    // at 1.0, which is the floor set by the normal alone -- a factor of 21.
    //
    // Attenuating per voxel rather than just disabling it keeps the physics sensible: one voxel of
    // spray barely dims anything, while a deep pool crosses many voxels and still darkens the bed
    // beneath it. 0.9 puts the jitter near the floor and still leaves ~0.35 transmittance through ten
    // voxels of water. 1.0 removes water's shadow entirely.
    float waterShadowTransmit = 0.9f;
    // --- Water surface waves ---
    // A scrolling wave pattern perturbs the water's shading normal. Cosmetic only -- no geometry
    // moves, the voxel silhouette is unchanged, and it no longer has any job in hiding jitter now
    // that calculateShadow and getWaterNormal deal with that at source.
    //
    // Tuned to stay understated. At these values the tilt is a median of 1.8 degrees, 7.4 at the
    // 95th percentile, and peaks near 12 -- just inside the ~14 degree half-angle of the specular
    // lobe, so even a crest only MODULATES the highlight rather than switching it on and off. That
    // ceiling is what keeps it reading as calm water rather than as chop. The low scale gives long
    // broad swells instead of small ripples; raise it for a choppier surface.
    float waterWaveStrength = 0.9f;
    float waterWaveScale = 0.6f;
    float waterWaveSpeed = 0.4f;
};

// Config: everything loaded from the config file. Currently just the shader tuning params;
// later batches will add C++-side sections (camera, UI defaults, etc.) alongside this.
struct Config {
    TuningParams tuning;
};

// Loads key=value pairs from the given path. Missing file or missing keys silently fall back
// to the defaults above -- never throws, so a missing/partial config file can't crash startup.
Config loadConfig(const std::string& path);