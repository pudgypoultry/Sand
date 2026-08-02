// Config.cpp
#include "Config.hpp"
#include "ConfigSchema.hpp"
#include <fstream>
#include <unordered_map>
#include <iostream>
#include <algorithm>
#include <sstream>
#include <vector>
#include <cstdlib>

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

// FUNCTION: formatField
// One field as it should appear on the right of an '=' in config.txt.
//
// march_max_steps is written back as 0 whenever it matches the derived value, and that is not
// cosmetic. The loader turns 0 into W+H+D, so a naive round trip would replace "derive this" with
// whatever number the current world size happened to produce -- and the next time the grid size
// changed, that stale literal would silently crop the far half of the world. Writing 0 keeps the
// intent rather than the answer.
static std::string formatField(const TuningParams& t, const ConfigField& f) {
    std::ostringstream out;
    if (f.kind == FieldKind::UInt) {
        uint32_t v = fieldUInt(t, f);
        if (f.offset == offsetof(TuningParams, marchMaxSteps) && v == autoMarchSteps(t)) v = 0u;
        out << v;
    } else {
        // The SHORTEST representation that still reads back as the same float, found by widening the
        // precision until it round trips. Nine digits always round trips a float and was the obvious
        // first answer, but it spells 0.2 as "0.200000003" and 0.05 as "0.0500000007" -- and this
        // file is meant to be edited by hand, so turning every readable number into noise the first
        // time someone touched a slider would be a poor trade for exactness nothing needs.
        const float v = fieldFloat(t, f);
        for (int precision = 1; precision <= 9; precision++) {
            std::ostringstream candidate;
            candidate.precision(precision);
            candidate << v;
            const std::string text = candidate.str();
            // Skip scientific notation and keep widening. At one significant digit ostringstream
            // renders 20 as "2e+01" and 20000 as "2e+04", which round trip perfectly and are still
            // the wrong thing to put in a file a person reads.
            if (text.find('e') != std::string::npos || text.find('E') != std::string::npos) continue;
            if (std::strtof(text.c_str(), nullptr) == v) return text;
        }
        out.precision(9);
        out << v;
    }
    return out.str();
}

// FUNCTION: applyWorldShape / autoMarchSteps
void applyWorldShape(TuningParams& t, uint32_t gridSize) {
    t.gridWidth = t.gridHeight = t.gridDepth = std::clamp(gridSize, 8u, 512u);
}

uint32_t autoMarchSteps(const TuningParams& t) {
    return t.gridWidth + t.gridHeight + t.gridDepth;
}

// FUNCTION: sanitizeTuning
// Every constraint that is a property of the FORMAT rather than a matter of taste, applied in one
// place because there are now two ways in: the config file and the options screen.
//
// This used to live at the tail of loadConfig, which was fine while the file was the only source.
// It is not fine now -- a value typed into the UI has to clear exactly the same bars, and most of
// these are not preferences at all. They are the sizes of the voxel fields the values are packed
// into, and past them a number silently wraps and the material's behaviour goes strange rather than
// merely wrong.
void sanitizeTuning(TuningParams& t) {
    // The schema's own bounds first: they are what the sliders enforce, so a hand-edited file that
    // sits outside them should land in the same place a UI edit would.
    for (size_t i = 0; i < kConfigFieldCount; i++) {
        const ConfigField& f = kConfigFields[i];
        if (f.kind == FieldKind::UInt) {
            uint32_t& v = fieldUInt(t, f);
            v = std::clamp(v, static_cast<uint32_t>(f.lo), static_cast<uint32_t>(f.hi));
        } else {
            float& v = fieldFloat(t, f);
            v = std::clamp(v, static_cast<float>(f.lo), static_cast<float>(f.hi));
        }
    }

    // The world is a cube, so the three extents are one number wearing three hats.
    applyWorldShape(t, t.gridWidth);

    // 0 means "derive it" wherever it comes from, including a slider dragged to the bottom. Leaving
    // a literal 0 in place would give every ray a budget of no steps and blank the world.
    if (t.marchMaxSteps == 0u) t.marchMaxSteps = autoMarchSteps(t);

    // The trunk's height counter and the leaf's distance counter are each one byte, and a max height
    // of 0 would leave a sapling unable to ever be a crown -- so it would never put out a leaf.
    t.treeMaxHeight = std::clamp(t.treeMaxHeight, 1u, 255u);
    t.treeLeafReach = std::clamp(t.treeLeafReach, 1u, 200u);
    t.treeWaterMax = std::clamp(t.treeWaterMax, 1u, 255u);

    // Every locust field below shares a voxel's three spare bytes, so each has a hard ceiling that
    // is a property of the packing rather than a taste call -- past it the value silently wraps and
    // the swarm's behaviour goes strange rather than merely wrong.
    //
    // The tick phase lives in the sleep byte and is compared against this, so an interval it can
    // never reach freezes every swarm in the world; 0 does the same from the other end.
    t.locustTickDispatches = std::clamp(t.locustTickDispatches, 1u, 255u);
    // The eat timer lives in the dir byte and counts up to this.
    t.locustEatTicksMax = std::clamp(t.locustEatTicksMax, 1u, 255u);
    t.locustEatTicksMin = std::clamp(t.locustEatTicksMin, 1u, t.locustEatTicksMax);
    // Steps left in a run get 3 bits alongside the heading's 3.
    t.locustRunLength = std::clamp(t.locustRunLength, 1u, 7u);
    // The stage table is exactly 5 wide, so the cap has to be reachable within 5 bands or the top
    // stages would be unreachable and the head count could outrun its own type.
    if (t.locustStageSize == 0u) t.locustStageSize = 1u;
    t.locustMaxSize = std::min(t.locustMaxSize, t.locustStageSize * 5u);
    t.locustMaxSize = std::max(t.locustMaxSize, 1u);
    // The head count shares an 8-bit field with nothing, but it is still one byte.
    t.locustMaxSize = std::min(t.locustMaxSize, 255u);
}

// FUNCTION: loadConfig
Config loadConfig(const std::string& path) {
    Config config; // struct defaults apply unless overridden below
    auto values = parseKeyValueFile(path);

    // One pass over the schema replaces what used to be ninety-odd hand-written lines, each of which
    // had to name its field twice and its key once. Every one of those was a chance for a key to be
    // read into the wrong field, or for a field to quietly have no key at all.
    for (size_t i = 0; i < kConfigFieldCount; i++) {
        const ConfigField& f = kConfigFields[i];
        if (f.kind == FieldKind::UInt) {
            fieldUInt(config.tuning, f) = getUint(values, f.key, fieldUInt(config.tuning, f));
        } else {
            fieldFloat(config.tuning, f) = getFloat(values, f.key, fieldFloat(config.tuning, f));
        }
    }

    // sim.grid_size was read into gridWidth by the loop above; fan it out before anything derived
    // from the world's size is computed.
    applyWorldShape(config.tuning, config.tuning.gridWidth);

    // 0 means "derive it", and that is the default precisely so the whole world stays visible when
    // the grid size changes -- a literal here is what silently cropped the far half of a large world
    // before. A non-zero value overrides, to trade distant geometry for frame time.
    if (config.tuning.marchMaxSteps == 0u) config.tuning.marchMaxSteps = autoMarchSteps(config.tuning);

    sanitizeTuning(config.tuning);
    return config;
}

// FUNCTION: saveConfig
// Rewrites values in place, leaving every comment, blank line and section heading exactly where it
// was. That is the whole point: config.txt is mostly prose explaining WHY each number is what it is,
// and a writer that regenerated the file would throw all of it away the first time someone nudged a
// slider. Only lines that are already "key=value" for a key the schema knows are touched; anything
// the schema has no line for is appended at the end so it cannot be silently dropped.
bool saveConfig(const std::string& path, const Config& config) {
    std::vector<std::string> lines;
    {
        std::ifstream in(path);
        std::string line;
        while (std::getline(in, line)) lines.push_back(line);
    }

    std::vector<bool> written(kConfigFieldCount, false);

    for (std::string& line : lines) {
        std::string trimmed = trim(line);
        if (trimmed.empty() || trimmed[0] == '#') continue;

        size_t eq = trimmed.find('=');
        if (eq == std::string::npos) continue;

        std::string key = trim(trimmed.substr(0, eq));
        for (size_t i = 0; i < kConfigFieldCount; i++) {
            if (key != kConfigFields[i].key) continue;
            line = std::string(kConfigFields[i].key) + "=" + formatField(config.tuning, kConfigFields[i]);
            written[i] = true;
            break;
        }
    }

    std::vector<std::string> missing;
    for (size_t i = 0; i < kConfigFieldCount; i++) {
        if (!written[i]) {
            missing.push_back(std::string(kConfigFields[i].key) + "=" + formatField(config.tuning, kConfigFields[i]));
        }
    }

    std::ofstream out(path, std::ios::trunc);
    if (!out.is_open()) {
        std::cout << "Could not write '" << path << "'; the new options are live but will not survive a restart.\n";
        return false;
    }
    for (const std::string& line : lines) out << line << "\n";
    if (!missing.empty()) {
        out << "\n# Added automatically: these had no line in the file when it was last written.\n";
        for (const std::string& line : missing) out << line << "\n";
    }
    return true;
}
