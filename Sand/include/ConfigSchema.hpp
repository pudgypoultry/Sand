// ConfigSchema.hpp
#pragma once

#include "Config.hpp"
#include <cstddef>

// One description of every tunable, used by everything that needs to know what the tunables ARE:
// the config file reader, the config file writer, and the options screen.
//
// This exists because those three had drifted apart by hand three times already. Adding a field used
// to mean editing Config.hpp, adding a matching getUint/getFloat line to Config.cpp, adding a line to
// config.txt, and mirroring it into both shaders' UBO blocks -- five places, four of which fail
// silently when you miss one. A key present in config.txt but absent from the reader is simply
// ignored; a field in the reader with no line in config.txt is invisible. Both were only ever caught
// by scripts run after the fact.
//
// Now the reader, the writer and the UI all walk this one array, so a key can no longer exist in one
// and not the others. The shaders are still separate and still have to be kept in step by hand --
// that is a genuinely different problem, since a UBO's layout is a binary contract rather than a list
// of names.
enum class FieldKind { UInt, Float };

struct ConfigField {
    const char* section;  // groups fields into tabs on the options screen
    const char* key;      // the config.txt key
    const char* label;    // shown in the UI
    FieldKind kind;
    size_t offset;        // byte offset into TuningParams
    double lo;            // slider bounds; also the clamp applied on load
    double hi;
    const char* help;     // tooltip, may be empty
};

extern const ConfigField kConfigFields[];
extern const size_t kConfigFieldCount;

// TuningParams is a standard-layout struct of uint32_t and float, which is exactly the case where
// offsetof is well defined and a byte offset can be turned back into a typed reference safely.
inline uint32_t& fieldUInt(TuningParams& t, const ConfigField& f) {
    return *reinterpret_cast<uint32_t*>(reinterpret_cast<char*>(&t) + f.offset);
}
inline float& fieldFloat(TuningParams& t, const ConfigField& f) {
    return *reinterpret_cast<float*>(reinterpret_cast<char*>(&t) + f.offset);
}
inline uint32_t fieldUInt(const TuningParams& t, const ConfigField& f) {
    return *reinterpret_cast<const uint32_t*>(reinterpret_cast<const char*>(&t) + f.offset);
}
inline float fieldFloat(const TuningParams& t, const ConfigField& f) {
    return *reinterpret_cast<const float*>(reinterpret_cast<const char*>(&t) + f.offset);
}

// Writes the config back out. Used by the options screen's apply button, so a change made in the UI
// survives a restart rather than lasting only as long as the process.
bool saveConfig(const std::string& path, const Config& config);

// Applies every constraint that is a property of the format rather than a matter of taste -- the
// sizes of the voxel fields these numbers get packed into. Called by the loader and by the options
// screen's apply, because a value typed into the UI has to clear exactly the same bars as one read
// from the file.
void sanitizeTuning(TuningParams& t);

// Everything the two derived quantities need, in one place so the loader and the options screen
// cannot disagree about them.
//
// The world is a cube driven by one number, and the raymarch budget is derived from it: a DDA
// crossing a WxHxD box visits at most W+H+D cells, so that sum is exactly what a ray needs to reach
// the far side. 0 in the file means "derive it", and that is the default for a reason -- a literal
// there is what silently cropped the far half of the world when the grid size changed.
void applyWorldShape(TuningParams& t, uint32_t gridSize);
uint32_t autoMarchSteps(const TuningParams& t);
