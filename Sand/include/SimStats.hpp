#pragma once

#include <cstdint>

// The layout of the SimStats storage buffer, as field indices into an array of uint32_t.
//
// This is a binary contract with the `SimStats` block declared in falling_sand.comp and
// raymarch.frag: change the order there and every constant here is silently wrong, with no compiler
// anywhere to notice. It lives in a shared header because both renderers need it and two copies of
// a contract nothing checks is one copy too many.
namespace SimStats {

inline constexpr uint32_t kBlackHoleMax = 8;

// The twenty scalars at the top: waterVoxelCount, waterHighMark, cloudWaterCount, rainPhase,
// rainPhaseTimeBits, rainTargetLevel, rainCandidateCount, rainCandidateEstimate, cloudChargeBits,
// cloudBlockCount, cloudMovedCount, cloudStillTicks, simTick, lastRainTick, cloudMinYAcc,
// cloudMaxYAcc, cloudMinY, cloudMaxY, cloudPeakColumnAcc, cloudPeakColumn.
//
// waterHighMark, cloudWaterCount and rainTargetLevel are dead -- weather is driven by the cloud
// field going still rather than by a water deficit -- but they are still declared, in the shaders
// too, so that removing them cannot shift the offset of anything after them.
//
// The peak pair was appended AFTER cloudMaxY and before blackHoleCount, so the three indices named
// individually below (all under 14, read back by the profiler) keep their values and everything
// past them moves by two together, which the derived constants handle on their own.
inline constexpr uint32_t kCloudScalarCount = 20;

// Individually named because the profiler reads these three back rather than the whole block.
inline constexpr uint32_t kRainPhase   = 3;
inline constexpr uint32_t kSimTick     = 12;
inline constexpr uint32_t kLastRain    = 13;

inline constexpr uint32_t kCount  = kCloudScalarCount;   // blackHoleCount
inline constexpr uint32_t kMaxY   = kCount + 1;          // maxOccupiedY
inline constexpr uint32_t kHoles  = kMaxY + 1;           // blackHoles[kBlackHoleMax]
inline constexpr uint32_t kMass   = kHoles + kBlackHoleMax;    // blackHoleMass[]
inline constexpr uint32_t kStarve = kMass + kBlackHoleMax;     // blackHoleStarve[]
inline constexpr uint32_t kStarveEnd = kStarve + kBlackHoleMax;

// The end of the fixed part of the buffer. The cloud placement cache that used to sit here is gone
// with the drifting-ellipsoid cloud field it served.
inline constexpr uint32_t kFieldCount = kStarveEnd;

// Past kFieldCount the buffer carries a per-column cloud census, four words per column, laid out
// at (x + z * gridWidth) * kColumnWords:
//   +0 accumulator count, +1 unused, +2 published count, +3 the publish window this column last
//   wrote in.
//
// Slots 1 and 3 both used to serve the column's top Y, accumulated and published. Nothing reads a
// column's height any more -- the drawn deck stands on the roof of the cube rather than on the
// blocks -- so the accumulation is gone and the published word was taken over by the republish
// clock, which needs one word of per-column state and has a single writer available for it.
//
// This makes the stats buffer VARIABLE LENGTH -- it is kFieldCount + gridWidth * gridDepth *
// kColumnWords words, and both renderers must size it that way and resize it when the world does.
// In the shaders it is a runtime-sized array, which std430 permits only as the block's last member,
// so nothing may be appended to SimStats after it.
inline constexpr uint32_t kColumnWords = 4;
inline constexpr uint32_t kColumnBase  = kFieldCount;

// FUNCTION: statsWordCount
// The whole buffer's length in uint32s for a given world shape.
inline constexpr uint32_t statsWordCount(uint32_t gridWidth, uint32_t gridDepth) {
    return kFieldCount + gridWidth * gridDepth * kColumnWords;
}

// Black hole table slot encoding. Must match the constants in falling_sand.comp.
inline constexpr uint32_t kActive    = 0x80000000u;
inline constexpr uint32_t kPurge     = 0x40000000u;
inline constexpr uint32_t kIndexMask = 0x3FFFFFFFu;

} // namespace SimStats
