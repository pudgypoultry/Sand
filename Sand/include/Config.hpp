// Config.hpp
#pragma once

#include <string>
#include <cstdint>

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
    // Rain is no longer metered against a water deficit. Steam that reaches the top of the world
    // becomes a cloud block; once the cloud field has been still for cloud.still_ticks_to_storm
    // dispatches the sky darkens for rainDarkenDelay seconds, and then every cloud block becomes a
    // storm block that makes its own way to the ceiling and falls back as water. A storm therefore
    // returns exactly the water that evaporated, one block for one voxel, and ends when the last
    // block has fallen -- there is no target level to reach and nothing to overshoot.
    //
    // The first three are dead, kept for their offsets.
    uint32_t rainStartLayers = 2;      // UNUSED: no threshold; stillness starts a storm
    uint32_t rainDropsPerTick = 50;    // UNUSED: no rate; every cloud block falls once
    float rainOvershoot = 0.05f;       // UNUSED: no target level to overshoot
    float rainDarkenDelay = 6.0f;      // still used: seconds of darkening before rain starts
    // --- Clouds ---
    // Clouds are the visible shadow of an actual voxel field: cloud blocks rise, pile against the
    // ceiling, and the renderer draws a slab over each column sized from how many are stacked there.
    // The field still shares one "charge" value, which now tracks the storm phase rather than a
    // water deficit, driving opacity between cloudMinAlpha and cloudMaxAlpha and greying the sky as
    // it rises -- so the whole sky still reacts as one mass.
    //
    // Three of the fields below are dead: clouds became simulated voxels, so there is no drifting
    // population to count, no drift speed, and no water deficit for the charge to track. They stay
    // declared because every field after them has an offset both shaders depend on -- see the note
    // on renderScale at the end of this struct. cloudEdgeFadeDist came back into use: it fades the
    // deck at the world's edges, which is the same job it did for the old ellipsoids.
    uint32_t cloudCount = 32;          // UNUSED: clouds are voxels now, not a fixed population
    float cloudDriftSpeed = 2.0f;      // UNUSED: clouds no longer drift
    float cloudEdgeFadeDist = 20.0f;   // in use again: tapers the cloud deck at the world's edges
    float cloudChargeSaturation = 20000.0f; // UNUSED: charge tracks the storm phase, not a deficit
    float cloudChargeEaseRate = 0.02f; // per dispatch, so it is framerate-dependent by design
    float cloudMinAlpha = 0.00f;       // set to 0 for a completely clear sky until steam appears
    float cloudMaxAlpha = 0.9f;
    float cloudVoxelSize = 3.0f;
    float cloudEdgeThresholdMin = 0.15f;
    float cloudEdgeThresholdMax = 0.7f;
    // Must exceed the cells a ray crosses within the cloud band, or cloud goes missing at a
    // distance -- distance is what makes a ray shallow, and a shallow ray skims the band for the
    // whole width of the world. Measured worst case, with the band depth capped as the renderer
    // caps it, is 98 cells at a 128-cube and 184 at a 256-cube: so 128 covers the default world
    // with room, and a larger world wants this raised to match. Only pixels whose ray actually
    // traverses the band pay for it.
    uint32_t maxCloudSteps = 128;
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
    // How fast a lava voxel walks the three-colour cycle around its own stage: cycles per second.
    // Render-only, but it lives here with the rest of lava because it is a property of the material
    // rather than of the camera.
    float lavaChurnRate = 0.35f;

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

    // --- Trees ---
    // A trunk holds drawn-up water in its age byte and its height above the soil in dir, and spends
    // that water on the three things a tree does: growing taller, putting out leaves, and seeding
    // the grass next to it. Water enters only at the bottom, from soil moisture, and is passed up
    // the column one voxel at a time -- so a tree's reach really is limited by the ground under it.
    //
    // A leaf holds its distance from the nearest trunk. That single number does all the work: it
    // bounds how far a canopy can spread, it makes canopies of neighbouring trees merge into one
    // continuous roof, and it is what lets a leaf tell whether it is still attached to anything.
    float treeBloomChance = 0.001f;      // 1 in 1000 grass blocks sprouts a tree instead
    uint32_t treeMaxHeight = 6;          // trunk voxels in a full-grown column
    uint32_t treeSoilReserve = 5;        // soil moisture a trunk will not drink below
    uint32_t treeWaterMax = 255;         // trunk water capacity (one byte, so this is the ceiling)
    float treeDrinkChance = 0.20f;       // chance per tick to draw one unit out of the soil
    float treeFlowChance = 0.50f;        // chance per tick to pass one unit up the trunk
    uint32_t treeGrowCost = 20;          // water spent adding a trunk voxel
    uint32_t treeLeafCost = 6;           // water spent putting out one leaf
    uint32_t treeSpreadCost = 250;       // water spent seeding a neighbouring grass block
    float treeSpreadChance = 0.005f;     // chance per tick to try, once the water is there
    float treeLeafChance = 0.15f;        // chance per tick for a crown trunk to put out a leaf
    uint32_t treeLeafReach = 1;          // how many leaves a canopy may chain from its crown
    float treeLeafSpreadChance = 0.15f;  // chance per leaf tick to extend the canopy
    float treeLeafTickChance = 0.06f;    // chance a leaf does anything at all this dispatch
    float treeLeafFallChance = 0.10f;    // chance per leaf tick for an unsupported leaf to let go
    float treeTrunkBurnChance = 0.15f;   // chance per tick for fire to take an adjacent trunk
    float treeLeafBurnChance = 0.15f;    // chance per tick for fire to take an adjacent leaf
    uint32_t treeTrunkColumns = 2;       // upper bound on the little stems drawn inside a trunk
    float treeTrunkRadius = 0.17f;       // stem radius in voxel units

    // Appended rather than filed with the other render settings, deliberately: every field before
    // this one has an offset that both shaders' uniform blocks depend on, and inserting into the
    // middle would move all of them. The options screen still shows it under World, because the
    // schema orders the UI by its own table rather than by this declaration.
    float renderScale = 1.0f;            // drawing-buffer size as a fraction of the display area

    // --- Cloud blocks (see the CLOUD BLOCKS section in falling_sand.comp) -------------------------
    // Appended for the same reason renderScale was: every field above has an offset both shaders'
    // uniform blocks depend on.
    //
    // How often the sky is tested for a storm, in dispatches. On every multiple of this the
    // simulation asks whether any cloud block moved on the previous dispatch; if none did, the
    // field has settled and a rain event begins. A periodic check rather than a run of consecutive
    // still ticks, so a single block jostling once cannot postpone weather indefinitely.
    uint32_t cloudCheckIntervalTicks = 5000;
    // A raincloud that reaches the ceiling picks a target between rainWaitMinTicks and this, then
    // counts up to it before becoming water -- so a storm falls as scattered drops over a long
    // while rather than as one sheet. Both are capped at 2047 by the 11-bit counters in the cloud
    // word; sanitizeTuning enforces that.
    uint32_t rainWaitMaxTicks = 2048;
    // How many cloud blocks in a column count as a fully opaque cloud. The divisor that makes cloud
    // density independent of world size.
    // Lowered from 24: with density no longer thinning the fill pattern it drives opacity alone,
    // and 24 blocks deep is a lot of cloud to demand before the sky looks solid.
    float cloudColumnFullCount = 10.0f;
    // World units of cloud drawn per cloud block in the column, rising from the top of the pile.
    float cloudThicknessPerBlock = 1.5f;
    // Cloud neighbours (of 26) at which a block counts as clumped and stops trying to move. The
    // counterpart of sandClumpThreshold, and it does the same job: without it a pile slumps into a
    // flat even sheet, and with it the field holds lumpy, cloud-shaped mounds.
    uint32_t cloudClumpThreshold = 9;  // UNUSED: cloud spreads like sand, with no cohesion rule
    // The floor of a raincloud's wait at the ceiling. See rainWaitMaxTicks.
    uint32_t rainWaitMinTicks = 256;
    // Dispatches a steam voxel may go without moving before it condenses where it stands.
    //
    // A failsafe, and it earns its keep. Steam condenses on reaching the roof or on rising into
    // settled cloud, but a cloud block can rise INTO a steam voxel's cell -- the two fields do not
    // look at each other -- and steam in that position is touching cloud without being under it, so
    // neither rule fires and it hangs there. Rather than enumerate the ways that can happen, steam
    // that has gone nowhere for this long simply becomes cloud.
    uint32_t steamCondenseTicks = 10;
    // How fast the drawn cloud surface follows the block field, per dispatch, 0..1.
    //
    // The field is never still -- blocks rise, rainclouds fall -- so a surface drawn straight from
    // this dispatch's counts changes every dispatch, and the deck boils. Easing it means the shape
    // drifts smoothly instead. 1.0 disables the smoothing and restores the boiling.
    float cloudSmoothRate = 0.08f;
    // The shortest a tree is allowed to top out at, in trunk voxels. treeMaxHeight is the tallest,
    // and every tree draws its own limit from somewhere between the two.
    //
    // The draw is hashed from the column's x/z rather than rolled and stored, because there is
    // nowhere to store it: a trunk voxel's dir byte is its height and its age byte is its water,
    // and every voxel in the column has to agree on the answer -- the tip to know when to stop
    // growing, and the leaves to know which voxel is the crown they anchor to. A hash of the
    // ground position gives all of them the same number for free. Equal values here restore the
    // old behaviour, where every tree grew to exactly treeMaxHeight.
    uint32_t treeMinHeight = 3;
    // Chance a fire that burns out leaves a grain of ash rather than nothing. Rolled rather than
    // certain because fire spreads faster than it ends: one grain per flame buries a burnt forest.
    // Zero turns ash off entirely without removing the material.
    float fireAshChance = 0.25f;
    // Chance per dispatch that a grain of ash which cannot fall steps sideways instead. This is
    // what makes ash settle flatter than sand -- see the slump rule in updateAsh, which bounds it
    // against wakeSleepThreshold so a drift stops spreading instead of creeping for ever.
    float ashDriftChance = 0.35f;
    // How many dispatches a grain of ash rests on dirt before it works in and disappears. A
    // counter rather than a per-dispatch chance: absorption is meant to take a watchable amount of
    // time, and a roll gives a geometric distribution where the median grain goes early and no two
    // agree on how long "a while" is. Capped at 255 by the age byte it counts in -- but a drift is
    // many grains deep and absorbs from the bottom one at a time, so a heavy fall of ash stifles
    // the ground under it for a multiple of this.
    uint32_t ashAbsorbTicks = 200;
    // How much flora a worked-in grain of ash is worth. Capped at 99 inside the shader, one short
    // of full, so the last step is still taken by the normal grass roll and the tree bloom that
    // hangs off it can still fire.
    uint32_t ashEnrichAmount = 25;
    // How many dispatches a grain of ash goes on slumping for after it lands, before it sets.
    // Deliberately not wakeSleepThreshold, which is a knob for how grains wake each other and is 5
    // by default -- about two sideways steps, which is not visibly flatter than sand. Capped at 255
    // by the sleep byte it counts in.
    uint32_t ashSettleTicks = 24;
};

// Config: everything loaded from the config file. Currently just the shader tuning params;
// later batches will add C++-side sections (camera, UI defaults, etc.) alongside this.
struct Config {
    TuningParams tuning;
};

// Loads key=value pairs from the given path. Missing file or missing keys silently fall back
// to the defaults above -- never throws, so a missing/partial config file can't crash startup.
Config loadConfig(const std::string& path);