#pragma once

#include "SimStats.hpp"

#include <array>
#include <cstdint>
#include <string>
#include <vector>

// The save file: everything needed to put the cube back exactly as it was, as plain text.
//
// Backend-agnostic on purpose. Neither renderer's buffers appear here -- the callers hand over
// plain vectors and take plain vectors back -- so the format is testable without a GPU and there is
// one implementation rather than one per backend. Getting the two out of step would be the obvious
// failure mode otherwise: a world saved on the desktop that a browser reads differently is worse
// than one it refuses outright.
//
// --- THE FORMAT -------------------------------------------------------------------------------
//
//   sand.world 1
//   grid 128 128 128
//   layer grid
//     418304 x0
//     128 x2
//     64 x1000002
//   layer cloud
//     2097152 x0
//   holes 1
//     0 80100000 4210 0
//   end
//
// Run-length encoded, because the alternative is not viable at this size. A 128-cube is 2,097,152
// voxels and one value per line runs to roughly 19 MB for a single save, scaling cubically from
// there. The worlds this stores are overwhelmingly runs -- large voids, flat bodies of water,
// layered ground -- so the same save lands in the tens of kilobytes. Still text, still greppable,
// and a run list is a good deal easier to hand-edit than two million lines would be.
//
// Values are hex with an `x` prefix and no leading zeroes; counts are decimal. The pairing reads
// unambiguously in both directions and makes the packed fields (type in the low byte, moisture and
// age in the high ones) legible at a glance, which decimal does not.
//
// Layers are written in full: every layer's runs must sum to exactly width*height*depth. A short
// layer is an error rather than a zero-fill, because the length is the one cheap check that catches
// a truncated file, and silently completing one would restore a world that is wrong in a way
// nothing would report.
//
// Black holes are stored because they are the one thing the grid alone cannot describe. A hole is
// TWO pieces of state -- a voxel of type 7 in the grid and a slot in the SimStats table carrying
// its mass and starvation clock -- and the simulation drives it from the table. Restoring the voxel
// without the slot gives an inert lump that eats nothing and never decays.
//
// Unknown lines are an error, not something to skip. This is a format a person may edit by hand,
// and a typo that silently does nothing is the worst way to find that out.
namespace WorldFile {

// The current format version, written into the header and required on read. Bump it only for a
// change that older files cannot survive; decode reports the mismatch by version rather than
// failing on whatever line first looks wrong.
inline constexpr uint32_t kVersion = 1;

// Guard rails on the dimensions a file may ask for. Matches sim.grid_size's own range in
// ConfigSchema.cpp -- a file is untrusted input, and w*h*d is about to be used to size an
// allocation, so it is checked before it is believed rather than after.
inline constexpr uint32_t kMinDim = 8;
inline constexpr uint32_t kMaxDim = 512;

struct World {
    uint32_t width = 0;
    uint32_t height = 0;
    uint32_t depth = 0;

    // Both exactly width*height*depth entries, indexed x + y*width + z*width*height, matching the
    // shaders' getIndex.
    std::vector<uint32_t> grid;
    std::vector<uint32_t> cloud;

    // The black hole table, slot for slot as SimStats holds it. holeSlot[i] is 0 for a free slot,
    // else kActive (and possibly kPurge) or'd with the hole's linear voxel index.
    std::array<uint32_t, SimStats::kBlackHoleMax> holeSlot{};
    std::array<uint32_t, SimStats::kBlackHoleMax> holeMass{};
    std::array<uint32_t, SimStats::kBlackHoleMax> holeStarve{};
    uint32_t holeCount = 0;

    size_t voxelCount() const {
        return static_cast<size_t>(width) * static_cast<size_t>(height) * static_cast<size_t>(depth);
    }
};

// Renders `world` as the text above. The caller is responsible for the two layers being the right
// length; a mis-sized one is a programming error here rather than bad input, and encode asserts
// nothing -- it writes what it is given, and decode is what refuses it.
std::string encode(const World& world);

// Parses text produced by encode. Returns false and fills `error` with a message naming the line
// number on any problem. `out` is left in an unspecified state on failure -- callers must not
// upload a world that failed to decode.
bool decode(const std::string& text, World& out, std::string& error);

// Builds a world from ANY file. Not the save format's inverse -- there is no format to read here.
//
// The file is the SEED, not the texture. Every byte is hashed into one 64-bit number and the world
// is generated from it, so the same file always gives the same world and any single byte anywhere
// changes it. What it does NOT do is map bytes to voxels one for one, which is the obvious reading
// and produces two artefacts of the wrapping rather than anything about the text: salt-and-pepper,
// because every voxel decides alone and no two neighbours agree; and diagonal moire, because a 1-D
// stream wrapped into a 3-D box beats its length against the row width.
//
// What comes out instead is overlapping ELLIPSOIDAL GLOBS, each one material, at random sizes and
// positions -- masses that hold together rather than grains that do not.
//
//   Composition is steered to roughly 35% water, 30% dirt, 30% sand and 5% everything else, and
//   steered by DEFICIT rather than by weight. A glob is not one sample but however many cells it
//   covers, and a big one late is worth more than a one-percent material's entire share, so drawing
//   on weight alone let those shares swing by several points.
//
//   Only the lower half is seeded, and globs may reach a little above it. Filling the whole volume
//   hides everything: a ray stops at the first solid voxel, so an evenly filled cube is opaque from
//   every angle and all you see is the skin.
//
//   Roughly a third of that region ends up material. A packed world cannot fall; a third leaves
//   each grain a plausible chance of an empty cell beneath it.
//
//   The four vertical boundary planes are left empty. Every sideways move in the simulation needs
//   an interior destination, so material against a wall can fall but never slide, and stands as
//   un-levelled columns no amount of settling will flatten.
//
// Three kinds of material are absent from the palette: black holes, because a hole is a voxel AND a
// SimStats slot and the slot cannot be derived from a file; stone, dark stone, trunk and leaf,
// because none of them settle; and the three cooler lava stages, because they are views of one
// coolness value rather than materials, and counting them separately gave lava four times its share.
//
// Deterministic ACROSS BACKENDS, not merely across runs -- the generator and every range reduction
// are written out by hand, and the glob test is integer, because the standard library's
// distributions are not specified to agree between MSVC and the browser's toolchain. Verified by
// checksum on both.
//
// Cannot fail. An empty file yields an empty cube, which is boring but valid.
void worldFromText(const std::string& text,
                   uint32_t width, uint32_t height, uint32_t depth,
                   World& out);

} // namespace WorldFile
