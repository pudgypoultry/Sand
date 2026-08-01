// Config.hpp
#pragma once

#include <string>

// Values read from the config file that get uploaded into the shader-side TuningParams
// uniform buffer (binding = 2, shared by falling_sand.comp and raymarch.frag).
// Layout must stay a flat struct of floats/ints to map directly onto the UBO's std140 layout --
// add new fields at the end, and mirror any addition in both shaders' TuningParams block.
struct TuningParams {
    // --- World shape ---
    // Derived in loadConfig from sim.grid_size rather than set directly, so the three can never
    // disagree about the shape of the world.
    //
    // These live in the UBO rather than being compiled in, which costs a uniform read everywhere the
    // old literals were. Specialisation constants would let the compiler fold them back into
    // immediates and would be the natural next step if this ever shows up in a profile.
    uint32_t gridWidth = 128;
    uint32_t gridHeight = 128;
    uint32_t gridDepth = 128;
    // Upper bound on the primary raymarch, in voxel steps. A DDA crossing a WxHxD box visits at most
    // W+H+D cells, so this is derived from the world rather than fixed: the old hardcoded 400 was
    // sized for 128^3 (384) and silently truncated every ray at larger sizes, which cut the far side
    // of the world out of the image entirely.
    uint32_t marchMaxSteps = 384;
    // Shadow rays are bounded separately because truncating one is graceful -- it reads as lit --
    // and at large world sizes tracing them in full is the more expensive half of the frame.
    uint32_t shadowMaxSteps = 256;
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
    // How far water looks sideways for somewhere to fall. This is the single most expensive thing in
    // the simulation: 8 directions x this radius of grid reads, per awake water voxel, per dispatch,
    // and at 128 that is 1024 reads against lava's 48. It is also the only cost that scales with the
    // Simulation Speed slider in practice -- every other material either sleeps or is inert.
    //
    // Defaulted to 128 to preserve existing behaviour exactly; lower it to trade long-range levelling
    // speed for frame time. Water that cannot find a distant drop falls back to spreading one cell at
    // a time, so a basin still levels, just incrementally rather than by teleporting across it.
    //
    // Do NOT be tempted to sample this range coarsely to cheapen it. The walk doubles as a
    // line-of-sight test -- it marks a direction blocked on the first solid cell -- so skipping cells
    // would let water step over a wall it never checked.
    uint32_t waterSpreadRadius = 128;
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
    // --- Purge (the Clear Grid button) ---
    // Clear Grid does not wipe the grid. It resets the sky, then drops one enormous black hole at the
    // centre with unlimited reach, and lets it eat the world. It is an ordinary hole flagged in the
    // table rather than a new material: everything that makes it different is a property of the HOLE
    // -- its reach, its size, how fast it gives up -- not of the voxel, so a separate block type
    // would have meant duplicating the orbit and void machinery to change three numbers.
    //
    // Its ending is free. A hole that captures nothing already starves, shrinks and removes itself,
    // which is exactly "once nothing remains, shrink and disappear" -- so the purge only needs a much
    // shorter fuse and a much faster burn than a normal hole, not new logic.
    //
    // Size is taken straight from mass/purgeMass rather than from the growth curve, so the shrink is
    // a smooth ramp to nothing and neither shader has to re-derive the volume formula.
    uint32_t purgeLevel = 10;        // body radius at full mass -- 10 is 21 voxels across
    uint32_t purgeMass = 10000;      // starting mass, and the divisor the size ramp is measured against
    uint32_t purgeStarveGrace = 30;  // dispatches with nothing left to catch before it starts shrinking
    uint32_t purgeDecayRate = 200;   // mass shed per dispatch while shrinking; 10000/200 = ~0.8s
    // The purge hole cannot use the normal orbit tuning. Those numbers are chosen so a captured
    // stream takes many revolutions to come in, which is right for a hole you placed on purpose and
    // badly wrong for a button that is supposed to clear the grid: at speed 2.2 / infall 0.16 a voxel
    // in the far corner needs about 2100 ticks, i.e. 35 seconds. These bring that to ~3.5 seconds
    // while still spending half of every move going sideways, so it visibly swirls in rather than
    // collapsing straight to the centre.
    float purgeOrbitSpeed = 8.0f;
    float purgeInfall = 0.5f;
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
    // --- Lava ---
    // Lava carries one 8-bit number, "coolness", and everything about its life is a function of it.
    // Absorbing water raises it, boiling moisture out of soil raises it, and simply sitting still
    // raises it slowly -- so "cooled because it drank" and "cooled because it sat there" are the same
    // quantity rather than two counters that could disagree. The visual stage (types 8..11, hottest
    // to coldest) is derived from it, and at 4 * lavaStageSize the voxel becomes dark stone.
    //
    // That single number is also what makes the sharing rules work: lava/lava contact and
    // lava/dark-stone contact are the same one-unit diffusion step, just in whichever direction the
    // gradient runs. Stone is hotter-in-reverse -- it holds a high coolness, so contact drains it,
    // and dark stone re-melts once contact drags it back under the solidify point.
    uint32_t lavaStageSize = 48;       // coolness per stage; 4x this is the solidify threshold
    float lavaViscosity = 0.125f;      // chance per tick to attempt a move at all
    uint32_t lavaSpreadRadius = 6;     // how far it will look sideways for somewhere to fall
    uint32_t lavaWaterCool = 40;       // coolness gained per water voxel flashed to steam
    uint32_t lavaMoistureCool = 2;     // coolness gained per unit of soil moisture boiled off
    float lavaRestCoolChance = 0.01f;  // chance per tick to cool while settled (rule 7's clock)
    float lavaConsumeChance = 0.05f;   // chance per tick to eat a neighbour it has already dried out
    float lavaIgniteChance = 0.2f;     // chance per tick to set adjacent grass alight
    float darkStoneDryChance = 0.002f; // chance per tick for dark stone to shed one unit of water

    // --- Locusts ---
    // A swarm voxel carrying a head count in its age byte, with the visual stage (types 13..17,
    // sparsest to densest) derived from it exactly the way lava derives its stage from coolness.
    //
    // locustTickDispatches is the one that makes the rest of these mean anything. A dispatch is not
    // a locust's tick: at sim speed 1 that is one per frame, so "loses one locust per tick" would
    // starve a fresh swarm in half a second and "eats for 10-30 ticks" would be a sixth of a second.
    // Locusts therefore run on their own clock, one tick per this many dispatches, counted in each
    // voxel's own sleep byte. Raise it for slower, more deliberate swarms; set it to 1 to get the
    // literal per-dispatch reading.
    uint32_t locustTickDispatches = 12; // dispatches per locust tick (~5 ticks/sec at 60fps)
    uint32_t locustStageSize = 10;      // head count per visual stage; 5 stages, so 50 is the cap
    uint32_t locustSpawnSize = 30;      // head count a hand-placed swarm starts with
    uint32_t locustMaxSize = 50;        // hard cap; exceeding it buds off a child swarm
    uint32_t locustBudSize = 10;        // head count a budded child starts with
    uint32_t locustEatGain = 20;        // head count gained per grass block finished
    uint32_t locustEatTicksMin = 10;    // ticks to eat one grass block at the cap
    uint32_t locustEatTicksMax = 30;    // ticks to eat one grass block at one stage
    uint32_t locustRunLength = 3;       // steps committed to a heading before re-scanning for grass
    float locustClimbChance = 0.5f;     // when blocked, chance to climb rather than turn
    float locustDensityMin = 0.18f;     // sub-cube fill of the sparsest stage
    float locustDensityMax = 0.62f;     // sub-cube fill of the densest stage
    uint32_t locustSubdivision = 4;     // sub-cubes per voxel edge; 4 means up to 64 per block
    float locustCrawlRate = 6.0f;       // swarm re-scatters this many times a second
};

// Config: everything loaded from the config file. Currently just the shader tuning params;
// later batches will add C++-side sections (camera, UI defaults, etc.) alongside this.
struct Config {
    TuningParams tuning;
};

// Loads key=value pairs from the given path. Missing file or missing keys silently fall back
// to the defaults above -- never throws, so a missing/partial config file can't crash startup.
Config loadConfig(const std::string& path);