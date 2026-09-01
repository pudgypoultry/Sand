// WorldFile.cpp -- the save format's reader and writer. See WorldFile.hpp for the format itself.

#include "WorldFile.hpp"

#include <charconv>
#include <cstdio>
#include <cstring>
#include <algorithm>

namespace WorldFile {
namespace {

// Hex, lower case, no leading zeroes, no prefix -- the `x` is written by the caller. std::to_chars
// would do this too; a hand-rolled one avoids pulling <charconv>'s formatting side in on the hot
// path and keeps the digit order obvious.
void appendHex(std::string& out, uint32_t v) {
    if (v == 0u) { out.push_back('0'); return; }
    char buf[8];
    int n = 0;
    while (v != 0u) {
        const uint32_t digit = v & 0xFu;
        buf[n++] = static_cast<char>(digit < 10u ? ('0' + digit) : ('a' + (digit - 10u)));
        v >>= 4;
    }
    while (n > 0) out.push_back(buf[--n]);
}

void appendDec(std::string& out, uint32_t v) {
    char buf[12];
    const int n = std::snprintf(buf, sizeof(buf), "%u", v);
    out.append(buf, static_cast<size_t>(n));
}

// One layer as runs. Emitting a run only when the value changes is the whole compression, and it is
// exact rather than approximate -- decode reproduces the input array bit for bit.
void appendLayer(std::string& out, const char* name, const std::vector<uint32_t>& data) {
    out += "layer ";
    out += name;
    out += '\n';
    if (data.empty()) return;

    uint32_t runValue = data[0];
    uint32_t runLength = 1;
    for (size_t i = 1; i < data.size(); i++) {
        if (data[i] == runValue && runLength != 0xFFFFFFFFu) { runLength++; continue; }
        out += "  ";
        appendDec(out, runLength);
        out += " x";
        appendHex(out, runValue);
        out += '\n';
        runValue = data[i];
        runLength = 1;
    }
    out += "  ";
    appendDec(out, runLength);
    out += " x";
    appendHex(out, runValue);
    out += '\n';
}

// --- reading ------------------------------------------------------------------------------------

// A cursor over one line's whitespace-separated tokens. Deliberately not a stringstream: this runs
// once per run in the file, which is tens of thousands of times for a real save, and iostreams'
// per-extraction locale work shows up plainly at that count.
struct Tokens {
    const char* p;
    const char* end;

    explicit Tokens(const char* begin, const char* finish) : p(begin), end(finish) {}

    void skipSpace() { while (p < end && (*p == ' ' || *p == '\t' || *p == '\r')) p++; }

    // The next token, or an empty view at the end of the line.
    bool next(const char*& tokBegin, const char*& tokEnd) {
        skipSpace();
        if (p >= end) return false;
        tokBegin = p;
        while (p < end && *p != ' ' && *p != '\t' && *p != '\r') p++;
        tokEnd = p;
        return true;
    }

    bool nextIs(const char* literal) {
        const char *b = nullptr, *e = nullptr;
        if (!next(b, e)) return false;
        const size_t n = static_cast<size_t>(e - b);
        return n == std::strlen(literal) && std::memcmp(b, literal, n) == 0;
    }

    bool nextUint(uint32_t& value, int base = 10) {
        const char *b = nullptr, *e = nullptr;
        if (!next(b, e)) return false;
        if (base == 16 && b < e && (*b == 'x' || *b == 'X')) b++;  // the `x` prefix on values
        if (b >= e) return false;
        const auto res = std::from_chars(b, e, value, base);
        return res.ec == std::errc() && res.ptr == e;
    }

    bool atEnd() { skipSpace(); return p >= end; }
};

std::string lineError(size_t lineNo, const std::string& what) {
    return "line " + std::to_string(lineNo) + ": " + what;
}

// Reads the runs of one layer until they total `expected`. Overshooting is an error in its own
// right rather than something to clamp: a run list that runs past the end of the world means the
// file and its header disagree, and which of the two is wrong is not for this to guess.
bool readLayer(const std::string& text, size_t& pos, size_t& lineNo, size_t expected,
               std::vector<uint32_t>& out, std::string& error) {
    out.clear();
    out.reserve(expected);

    while (out.size() < expected) {
        if (pos >= text.size()) {
            error = lineError(lineNo, "file ends part way through a layer: " +
                                          std::to_string(out.size()) + " of " +
                                          std::to_string(expected) + " voxels");
            return false;
        }

        const size_t lineEnd = text.find('\n', pos);
        const size_t stop = (lineEnd == std::string::npos) ? text.size() : lineEnd;
        Tokens t(text.data() + pos, text.data() + stop);
        const size_t thisLine = lineNo;
        pos = (lineEnd == std::string::npos) ? text.size() : lineEnd + 1;
        lineNo++;

        // Blank lines and comments are free, so a hand-edited file can be annotated.
        const char *b = nullptr, *e = nullptr;
        {
            Tokens probe(t.p, t.end);
            if (!probe.next(b, e)) continue;
            if (*b == '#') continue;
        }

        uint32_t count = 0, value = 0;
        Tokens line(t.p, t.end);
        if (!line.nextUint(count, 10)) {
            error = lineError(thisLine, "expected a run count");
            return false;
        }
        if (!line.nextUint(value, 16)) {
            error = lineError(thisLine, "expected a hex value like x2 after the count");
            return false;
        }
        if (!line.atEnd()) {
            error = lineError(thisLine, "trailing text after the run");
            return false;
        }
        if (count == 0u) {
            error = lineError(thisLine, "a run of zero voxels says nothing");
            return false;
        }
        if (out.size() + count > expected) {
            error = lineError(thisLine, "runs overrun the world: " +
                                            std::to_string(out.size() + count) + " voxels for a " +
                                            std::to_string(expected) + " voxel grid");
            return false;
        }
        out.insert(out.end(), count, value);
    }
    return true;
}

} // namespace

std::string encode(const World& world) {
    std::string out;
    // A rough guess at the final size, purely to spare the reallocation churn. Runs are what the
    // format is made of, so scaling with the voxel count would over-reserve by orders of magnitude
    // on a typical world; this is a floor that grows if it is wrong.
    out.reserve(64 * 1024);

    out += "sand.world ";
    appendDec(out, kVersion);
    out += '\n';
    out += "grid ";
    appendDec(out, world.width);
    out += ' ';
    appendDec(out, world.height);
    out += ' ';
    appendDec(out, world.depth);
    out += '\n';

    appendLayer(out, "grid", world.grid);
    appendLayer(out, "cloud", world.cloud);

    // Only occupied slots are written, and the slot index goes with each so a sparse table restores
    // to the same slots it left. The indices are not interchangeable: the purge hole is slot 0 by
    // convention, and Clear Grid writes it there directly.
    uint32_t live = 0;
    for (uint32_t i = 0; i < SimStats::kBlackHoleMax; i++) {
        if (world.holeSlot[i] != 0u) live++;
    }
    out += "holes ";
    appendDec(out, live);
    out += '\n';
    for (uint32_t i = 0; i < SimStats::kBlackHoleMax; i++) {
        if (world.holeSlot[i] == 0u) continue;
        out += "  ";
        appendDec(out, i);
        out += ' ';
        appendHex(out, world.holeSlot[i]);
        out += ' ';
        appendDec(out, world.holeMass[i]);
        out += ' ';
        appendDec(out, world.holeStarve[i]);
        out += '\n';
    }

    out += "end\n";
    return out;
}

bool decode(const std::string& text, World& out, std::string& error) {
    out = World{};
    error.clear();

    size_t pos = 0;
    size_t lineNo = 1;
    bool haveHeader = false, haveDims = false, haveGridLayer = false, haveCloudLayer = false;

    auto nextLine = [&](Tokens& t, size_t& thisLine) -> bool {
        while (pos < text.size()) {
            const size_t lineEnd = text.find('\n', pos);
            const size_t stop = (lineEnd == std::string::npos) ? text.size() : lineEnd;
            Tokens candidate(text.data() + pos, text.data() + stop);
            thisLine = lineNo;
            pos = (lineEnd == std::string::npos) ? text.size() : lineEnd + 1;
            lineNo++;

            Tokens probe(candidate.p, candidate.end);
            const char *b = nullptr, *e = nullptr;
            if (!probe.next(b, e)) continue;  // blank
            if (*b == '#') continue;          // comment
            t = candidate;
            return true;
        }
        return false;
    };

    Tokens line(nullptr, nullptr);
    size_t thisLine = 0;

    while (nextLine(line, thisLine)) {
        // Initialised and the result checked, rather than trusting nextLine to have already
        // skipped the blanks. It has, so the continue below is unreachable today -- but the
        // alternative is a read of two uninitialised pointers if that ever stops being true,
        // and "unreachable" is not a property the next person to edit nextLine will check.
        const char *b = nullptr, *e = nullptr;
        Tokens t(line.p, line.end);
        if (!t.next(b, e)) continue;
        const size_t n = static_cast<size_t>(e - b);
        auto is = [&](const char* lit) {
            return n == std::strlen(lit) && std::memcmp(b, lit, n) == 0;
        };

        if (is("sand.world")) {
            uint32_t version = 0;
            if (!t.nextUint(version)) {
                error = lineError(thisLine, "the header needs a version number");
                return false;
            }
            if (version != kVersion) {
                error = lineError(thisLine, "this is a version " + std::to_string(version) +
                                                " file and this build reads version " +
                                                std::to_string(kVersion));
                return false;
            }
            haveHeader = true;
            continue;
        }

        if (!haveHeader) {
            error = lineError(thisLine, "the first line must be \"sand.world " +
                                            std::to_string(kVersion) + "\"");
            return false;
        }

        if (is("grid")) {
            if (!t.nextUint(out.width) || !t.nextUint(out.height) || !t.nextUint(out.depth)) {
                error = lineError(thisLine, "grid needs three dimensions");
                return false;
            }
            // Checked before the size is used for anything, because the next thing that happens to
            // it is an allocation and this is a file off disk.
            const uint32_t dims[3] = { out.width, out.height, out.depth };
            for (uint32_t d : dims) {
                if (d < kMinDim || d > kMaxDim) {
                    error = lineError(thisLine, "dimension " + std::to_string(d) +
                                                    " is outside the supported range " +
                                                    std::to_string(kMinDim) + ".." +
                                                    std::to_string(kMaxDim));
                    return false;
                }
            }
            haveDims = true;
            continue;
        }

        if (is("layer")) {
            if (!haveDims) {
                error = lineError(thisLine, "a layer before the grid line, so its length is unknown");
                return false;
            }
            const char *nb, *ne;
            if (!t.next(nb, ne)) {
                error = lineError(thisLine, "layer needs a name");
                return false;
            }
            const size_t nn = static_cast<size_t>(ne - nb);
            const bool isGrid  = (nn == 4 && std::memcmp(nb, "grid", 4) == 0);
            const bool isCloud = (nn == 5 && std::memcmp(nb, "cloud", 5) == 0);
            if (!isGrid && !isCloud) {
                error = lineError(thisLine, "unknown layer \"" + std::string(nb, nn) +
                                                "\"; expected grid or cloud");
                return false;
            }
            std::vector<uint32_t>& dest = isGrid ? out.grid : out.cloud;
            if (!readLayer(text, pos, lineNo, out.voxelCount(), dest, error)) return false;
            (isGrid ? haveGridLayer : haveCloudLayer) = true;
            continue;
        }

        if (is("holes")) {
            uint32_t count = 0;
            if (!t.nextUint(count)) {
                error = lineError(thisLine, "holes needs a count");
                return false;
            }
            if (count > SimStats::kBlackHoleMax) {
                error = lineError(thisLine, std::to_string(count) +
                                                " black holes, but the table holds at most " +
                                                std::to_string(SimStats::kBlackHoleMax));
                return false;
            }
            for (uint32_t i = 0; i < count; i++) {
                Tokens hole(nullptr, nullptr);
                size_t holeLine = 0;
                if (!nextLine(hole, holeLine)) {
                    error = lineError(thisLine, "file ends before all " + std::to_string(count) +
                                                    " black holes are listed");
                    return false;
                }
                uint32_t slot = 0, code = 0, mass = 0, starve = 0;
                if (!hole.nextUint(slot) || !hole.nextUint(code, 16) || !hole.nextUint(mass) ||
                    !hole.nextUint(starve)) {
                    error = lineError(holeLine, "a hole needs slot, code, mass and starve");
                    return false;
                }
                if (slot >= SimStats::kBlackHoleMax) {
                    error = lineError(holeLine, "slot " + std::to_string(slot) +
                                                    " is past the end of the table");
                    return false;
                }
                // The code carries the hole's voxel index in its low bits, and the simulation
                // dereferences it without checking. A file naming a voxel outside the world it also
                // declares would have the compute shader read past the grid.
                const uint32_t index = code & SimStats::kIndexMask;
                if ((code & SimStats::kActive) != 0u && index >= out.voxelCount()) {
                    error = lineError(holeLine, "black hole points at voxel " +
                                                    std::to_string(index) + ", outside this world");
                    return false;
                }
                out.holeSlot[slot] = code;
                out.holeMass[slot] = mass;
                out.holeStarve[slot] = starve;
            }
            out.holeCount = count;
            continue;
        }

        if (is("end")) break;

        error = lineError(thisLine, "unrecognised line starting \"" + std::string(b, n) + "\"");
        return false;
    }

    if (!haveHeader)     { error = "not a sand.world file: the header line is missing"; return false; }
    if (!haveDims)       { error = "no grid line, so the world has no dimensions"; return false; }
    if (!haveGridLayer)  { error = "no grid layer in the file"; return false; }
    if (!haveCloudLayer) { error = "no cloud layer in the file"; return false; }
    return true;
}

// worldFromText: any file into a cube. See the header for what the result is meant to look like.
//
// The file is the SEED, not the texture. An earlier version read one byte per voxel and mapped each
// to a material independently, which is the obvious reading of "the file is the world" and produced
// two things nobody wanted. Salt-and-pepper: every voxel decided on its own, so no two neighbours
// agreed and the world was noise at the finest scale the grid can express. And moire: a file is a
// 1-D stream being wrapped into a 3-D box, so its length beats against the row width and paints
// diagonal stripes -- TestLoad.txt is 1412 bytes against a 128-wide row, four over a multiple, so
// every row stepped four bytes and the whole thing banded on a 32-row period. Neither is a property
// of the text. Both are artefacts of the wrapping.
//
// So the bytes are hashed down to a seed and the world is generated from it: overlapping globs of
// one material each, at random sizes and positions. Same file, same world, every time -- but a
// world made of masses that hold together rather than of individual grains that do not.

namespace {

// How much of the cube's HEIGHT the globs are seeded into, measured from the floor up. The rest is
// sky.
//
// This is what makes the world visible at all. Filling the whole volume looks like the honest
// reading and is the one thing guaranteed to hide it: a ray stops at the first solid voxel, so
// material spread evenly through the cube is opaque from every angle and the only thing on screen
// is the skin. Opacity does not even need density -- across 128 cells a 1% chance of solid per cell
// still stops about seven rays in ten -- so thinning alone cannot fix it while the thinning is
// spread over the full height. Confining it turns the file into terrain with weather above it.
constexpr float kFillHeightFraction = 0.5f;

// Fraction of that region left as material once the globs stop. A falling-sand world needs somewhere
// to fall: packed solid, every grain is wedged against its neighbours and the world is a static
// block that happens to be made of sand. Around a third leaves each grain a plausible chance of an
// empty cell beneath it, so the mass slumps into a landscape instead of sitting there being a cube.
constexpr float kTargetFill = 0.32f;

// Cells left empty against each of the four vertical walls of the world.
//
// The cause is in the simulation rather than here. EVERY sideways move in falling_sand.comp -- the
// diagonal slide, the push, the water spread -- requires its DESTINATION to satisfy
// `x > 0 && x < WIDTH-1 && z > 0 && z < DEPTH-1`, and falling straight down cannot change x or z at
// all. Two things follow: nothing can ever move INTO the four boundary planes, and anything already
// on one can only fall, never slide, so it is never levelled by the slumping that flattens the
// interior. Material seeded onto those planes stands as un-levelled columns forever, which reads as
// a rigid shell around a world whose middle has settled.
//
// Leaving them empty is a complete fix rather than a mitigation, and the same rule is what
// guarantees it: since nothing can slide in, a boundary plane that starts empty stays empty.
constexpr uint32_t kEdgeMargin = 1;

// Glob size, in voxels of radius. The range is what stops the result reading as one texture: a
// single radius gives a field of same-sized lumps, which is its own kind of regularity. The maximum
// is clamped against the world's smallest horizontal dimension further down, so a 32-cube does not
// get globs a third of its width.
constexpr int kGlobRadiusMin = 2;
constexpr int kGlobRadiusMax = 10;

// `seedAge` is the value the high byte is born with. Lava stages, dark stone and locust swarms are
// all views of a number kept there, so a voxel written without one is not the material it claims to
// be: falling_sand.comp's brush path seeds it for exactly this reason, and a loader that writes a
// bare type is quietly skipping that step.
struct WeightedMaterial { uint8_t type; uint16_t weight; uint8_t seedAge; };

// Weights are per hundred, and the three that matter are the three that behave like ground. Water
// pools and finds its level, dirt clumps and grows things, sand piles and holds a slope -- between
// them they make a landscape that reads as a landscape. Everything else is seasoning at one percent
// each: enough to come across, not enough to take over.
//
// The five at the bottom earn their small share. Lava offers only its HOTTEST stage: the other three
// are cooling states rather than materials, and counting them separately is what once gave lava four
// times its share of the world. Locusts get one entry of the five densities for the same reason.
static const WeightedMaterial kMaterialWeights[] = {
    {  2, 35,  0 },   // water -- pools, finds its level
    {  4, 30,  0 },   // dirt  -- clumps once wet, grows grass, then trees
    {  1, 30,  0 },   // sand  -- piles, holds a slope. age is moisture; 0 is dry
    { 20,  1,  0 },   // ash   -- settles grey, enriches the soil
    {  6,  1,  0 },   // steam -- rises, condenses, becomes weather
    {  5,  1,  0 },   // fire  -- age counts up to fireLifetime, so 0 is a fresh flame
    {  8,  1,  0 },   // lava  -- hottest stage only; coolness zero is what that means
    // A swarm's age is its HEAD COUNT, and zero means a swarm of nobody: it dies on its first
    // update, so every locust seeded here used to vanish before being seen. 30 mirrors
    // locustSpawnCount(LOCUST_SWARM) at the default locust.stage_size of 10. Raise that tuning and
    // this seeds a thinner swarm than the dropdown would -- the sim retypes it to whatever stage the
    // count actually is, so it degrades to a smaller swarm rather than breaking.
    { 15,  1, 30 },
};
constexpr int kMaterialCount = sizeof(kMaterialWeights) / sizeof(kMaterialWeights[0]);

// splitmix64, hand-rolled rather than taken from <random>.
//
// The desktop and the browser have to generate the SAME world from the same file, and the standard
// library cannot promise that. std::mt19937 is specified bit for bit, but the distributions that
// consume it -- uniform_int_distribution and friends -- are not, so MSVC and libc++ are free to
// disagree about how they turn a stream of bits into a number in a range, and they do. Every draw
// here is therefore explicit: a fixed generator, and range reduction written out by hand.
struct Rng {
    uint64_t state;

    explicit Rng(uint64_t seed) : state(seed) {}

    uint64_t next() {
        state += 0x9e3779b97f4a7c15ull;
        uint64_t z = state;
        z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ull;
        z = (z ^ (z >> 27)) * 0x94d049bb133111ebull;
        return z ^ (z >> 31);
    }

    // Modulo rather than rejection sampling. The bias is one part in 2^64/range, which for the
    // ranges here is far below anything a pile of sand could show.
    uint32_t below(uint32_t bound) {
        return bound == 0u ? 0u : static_cast<uint32_t>(next() % bound);
    }

    uint64_t below64(uint64_t bound) {
        return bound == 0ull ? 0ull : next() % bound;
    }

    int between(int lo, int hi) {  // inclusive
        return lo + static_cast<int>(below(static_cast<uint32_t>(hi - lo + 1)));
    }
};

// FNV-1a over the WHOLE file, plus its length.
//
// The whole file, not a prefix: this is the only thing carrying the text into the result now, so
// every byte should be able to change the world. A prefix hash would give two documents sharing an
// opening paragraph the same landscape. Length is mixed in as well so that a file and a truncation
// of it differ even when the truncation point is past whatever the hash had already absorbed.
uint64_t seedFromFile(const std::string& text) {
    constexpr uint64_t kFnvOffset = 0xcbf29ce484222325ull;
    constexpr uint64_t kFnvPrime  = 0x100000001b3ull;

    uint64_t h = kFnvOffset;
    for (unsigned char c : text) {
        h ^= c;
        h *= kFnvPrime;
    }
    h ^= text.size();
    h *= kFnvPrime;
    return h;
}

// Material type back to its row in the table, for undoing a cell's old ownership when a later glob
// paints over it. Built once; a 256-entry array beats a linear scan run once per painted voxel.
struct TypeIndex {
    int8_t index[256];
    TypeIndex() {
        for (int i = 0; i < 256; i++) index[i] = -1;
        for (int m = 0; m < kMaterialCount; m++) {
            index[kMaterialWeights[m].type] = static_cast<int8_t>(m);
        }
    }
};

const TypeIndex& typeIndex() {
    static const TypeIndex instance;
    return instance;
}

// Picks a material for the next glob, by how far each one is BEHIND its quota rather than by its
// weight directly.
//
// Weight alone is what the obvious version does and it misses badly, because a glob is not one
// sample -- it is however many cells it happens to cover, and the last glob to reach a cell owns it.
// A single radius-10 glob is about four thousand cells, which on a 128-cube is more than the entire
// share of a one-percent material. So whether lava came out at 0.5% or 2.5% turned on whether it
// drew a big ellipsoid late, and the three bulk materials swung four or five points the same way.
//
// Scoring by deficit closes the loop: a material that has run ahead of its share drops to zero
// weight and stops being offered until the others catch up, so the error can never accumulate. It
// costs nothing in appearance -- positions and sizes are still drawn freely, and only WHICH material
// a glob carries is steered.
int pickMaterialIndex(Rng& rng, const uint64_t quota[], const uint64_t owned[]) {
    uint64_t deficit[kMaterialCount];
    uint64_t totalDeficit = 0;
    for (int m = 0; m < kMaterialCount; m++) {
        deficit[m] = (quota[m] > owned[m]) ? (quota[m] - owned[m]) : 0ull;
        totalDeficit += deficit[m];
    }

    // Everything at or past its share -- only reachable on the last glob or two, since the loop
    // stops once the region is covered. Fall back to the plain weights so the draw stays defined.
    if (totalDeficit == 0ull) {
        int totalWeight = 0;
        for (int m = 0; m < kMaterialCount; m++) totalWeight += kMaterialWeights[m].weight;
        int roll = static_cast<int>(rng.below(static_cast<uint32_t>(totalWeight)));
        for (int m = 0; m < kMaterialCount; m++) {
            roll -= kMaterialWeights[m].weight;
            if (roll < 0) return m;
        }
        return 0;
    }

    uint64_t roll = rng.below64(totalDeficit);
    for (int m = 0; m < kMaterialCount; m++) {
        if (roll < deficit[m]) return m;
        roll -= deficit[m];
    }
    return 0;  // unreachable; the roll is bounded by the sum
}

} // namespace

void worldFromText(const std::string& text,
                   uint32_t width, uint32_t height, uint32_t depth,
                   World& out) {
    out = World{};
    out.width = width;
    out.height = height;
    out.depth = depth;

    const size_t total = out.voxelCount();
    out.grid.assign(total, 0u);
    // The cloud field starts empty. A text file has no natural mapping to the cloud plane above the
    // world, and inventing one from the same bytes would either double-count them or read past what
    // the file has. Weather generates its own clouds within a few seconds of play.
    out.cloud.assign(total, 0u);

    if (text.empty()) return;

    // The margin collapses on a world too narrow to afford it, which cannot happen at the supported
    // sizes but keeps the arithmetic below from underflowing if kMinDim ever drops.
    const uint32_t margin =
        (width > 2u * kEdgeMargin && depth > 2u * kEdgeMargin) ? kEdgeMargin : 0u;
    const uint32_t loX = margin, hiX = width - margin;    // [lo, hi)
    const uint32_t loZ = margin, hiZ = depth - margin;
    const uint32_t fillHeight =
        std::max(1u, static_cast<uint32_t>(static_cast<float>(height) * kFillHeightFraction));

    const size_t regionCells =
        static_cast<size_t>(hiX - loX) * (hiZ - loZ) * fillHeight;
    const size_t wanted = static_cast<size_t>(static_cast<double>(regionCells) * kTargetFill);
    if (wanted == 0) return;

    // Globs no wider than an eighth of the narrowest horizontal dimension, so the shape of the
    // result is the same on a 32-cube as on a 256 one rather than being a handful of boulders.
    const uint32_t narrowest = std::min(hiX - loX, hiZ - loZ);
    const int radiusMax =
        std::max(kGlobRadiusMin, std::min<int>(kGlobRadiusMax, static_cast<int>(narrowest / 8u)));

    // How many cells each material should end up owning. Integer, so the arithmetic that steers the
    // draw is the same on every platform for the same reason the ellipsoid test is.
    int totalWeight = 0;
    for (int m = 0; m < kMaterialCount; m++) totalWeight += kMaterialWeights[m].weight;
    uint64_t quota[kMaterialCount] = {};
    uint64_t owned[kMaterialCount] = {};
    for (int m = 0; m < kMaterialCount; m++) {
        quota[m] = static_cast<uint64_t>(wanted) * kMaterialWeights[m].weight /
                   static_cast<uint64_t>(totalWeight);
    }

    Rng rng(seedFromFile(text));

    // Paint until enough of the region is covered.
    //
    // Coverage counts only cells that were air, so a glob landing on top of another buys nothing and
    // the loop keeps going -- which is what makes the target hold however much the globs overlap.
    // Overlapping is wanted, not tolerated: a union of spheres has none of the roundness of any one
    // of them, and the material of a cell is simply whichever glob reached it last.
    //
    // The iteration cap is a guard against a target that cannot be met, not a normal exit. At the
    // default third-of-the-region it is reached after a few thousand globs on a 128-cube.
    constexpr int kMaxGlobs = 2000000;
    size_t covered = 0;
    for (int i = 0; i < kMaxGlobs && covered < wanted; i++) {
        const int mi = pickMaterialIndex(rng, quota, owned);
        const WeightedMaterial& mat = kMaterialWeights[mi];
        const uint32_t voxel = static_cast<uint32_t>(mat.type) |
                               (static_cast<uint32_t>(mat.seedAge) << 24);

        // A radius per axis rather than one for the glob, so these are ellipsoids at random
        // stretches instead of spheres. Spheres alone read as bubbles; stretched and overlapped they
        // read as seams and lenses of material, which is what ground actually looks like.
        const int rx = rng.between(kGlobRadiusMin, radiusMax);
        const int ry = rng.between(kGlobRadiusMin, radiusMax);
        const int rz = rng.between(kGlobRadiusMin, radiusMax);

        const int cx = static_cast<int>(loX + rng.below(hiX - loX));
        const int cy = static_cast<int>(rng.below(fillHeight));
        const int cz = static_cast<int>(loZ + rng.below(hiZ - loZ));

        // Centres sit inside the fill region but the body may reach above it, clipped only by the
        // world. Clipping to the fill line instead would slice every glob that straddles it flat,
        // and a landscape with a machined top edge is worse than one that pokes into the sky.
        const int x0 = std::max<int>(static_cast<int>(loX), cx - rx);
        const int x1 = std::min<int>(static_cast<int>(hiX) - 1, cx + rx);
        const int y0 = std::max<int>(0, cy - ry);
        const int y1 = std::min<int>(static_cast<int>(height) - 1, cy + ry);
        const int z0 = std::max<int>(static_cast<int>(loZ), cz - rz);
        const int z1 = std::min<int>(static_cast<int>(hiZ) - 1, cz + rz);

        // The ellipsoid test in integers: dx^2/rx^2 + dy^2/ry^2 + dz^2/rz^2 <= 1, multiplied through
        // by (rx*ry*rz)^2 so there is no division and no float. Determinism again -- this has to
        // give the same cells on MSVC and on the browser's toolchain, and integers cannot disagree.
        const int64_t rx2 = static_cast<int64_t>(rx) * rx;
        const int64_t ry2 = static_cast<int64_t>(ry) * ry;
        const int64_t rz2 = static_cast<int64_t>(rz) * rz;
        const int64_t limit = rx2 * ry2 * rz2;

        for (int y = y0; y <= y1; y++) {
            const int64_t dy = y - cy;
            const int64_t dyTerm = dy * dy * rx2 * rz2;
            if (dyTerm > limit) continue;
            for (int z = z0; z <= z1; z++) {
                const int64_t dz = z - cz;
                const int64_t dzTerm = dz * dz * rx2 * ry2;
                if (dyTerm + dzTerm > limit) continue;
                const size_t rowBase = static_cast<size_t>(y) * width +
                                       static_cast<size_t>(z) * width * height;
                for (int x = x0; x <= x1; x++) {
                    const int64_t dx = x - cx;
                    if (dyTerm + dzTerm + dx * dx * ry2 * rz2 > limit) continue;
                    uint32_t& cell = out.grid[static_cast<size_t>(x) + rowBase];
                    if (cell == 0u) {
                        covered++;
                    } else {
                        // Changing hands: the previous owner gives the cell up, or the quotas would
                        // count every cell as many times as globs have passed over it.
                        const int prev = typeIndex().index[cell & 0xFFu];
                        if (prev >= 0 && owned[prev] > 0ull) owned[prev]--;
                    }
                    cell = voxel;
                    owned[mi]++;
                }
            }
        }
    }
}

} // namespace WorldFile
