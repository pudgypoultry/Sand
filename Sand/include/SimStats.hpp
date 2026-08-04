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
inline constexpr uint32_t kCloudMax = 64;

// The nine scalars at the top: waterVoxelCount, waterHighMark, cloudWaterCount, rainPhase,
// rainPhaseTimeBits, rainTargetLevel, rainCandidateCount, rainCandidateEstimate, cloudChargeBits.
inline constexpr uint32_t kCloudScalarCount = 9;

inline constexpr uint32_t kCount  = kCloudScalarCount;   // blackHoleCount
inline constexpr uint32_t kMaxY   = kCount + 1;          // maxOccupiedY
inline constexpr uint32_t kHoles  = kMaxY + 1;           // blackHoles[kBlackHoleMax]
inline constexpr uint32_t kMass   = kHoles + kBlackHoleMax;    // blackHoleMass[]
inline constexpr uint32_t kStarve = kMass + kBlackHoleMax;     // blackHoleStarve[]
inline constexpr uint32_t kStarveEnd = kStarve + kBlackHoleMax;

// Cloud placement, cached once per dispatch rather than re-derived by every voxel and every pixel.
// Seven floats per cloud: centre xyz, radius xyz, edge fade.
inline constexpr uint32_t kFieldCount = kStarveEnd + kCloudMax * 7;

// Black hole table slot encoding. Must match the constants in falling_sand.comp.
inline constexpr uint32_t kActive    = 0x80000000u;
inline constexpr uint32_t kPurge     = 0x40000000u;
inline constexpr uint32_t kIndexMask = 0x3FFFFFFFu;

} // namespace SimStats
