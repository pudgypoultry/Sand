#!/usr/bin/env bash
# Regenerates the committed WGSL from the GLSL sources.
#
# The web build needs WGSL, and a browser accepts nothing else -- no SPIR-V, by design. Rather than
# make every clone install a shader translator, the translated output is committed and this script
# is what refreshes it. Run it after changing raymarch.frag or screen.vert.
#
# falling_sand.comp is deliberately NOT here. WGSL forbids a storage buffer being both atomic and
# non-atomic, and that shader reads the grid both ways, so no translator can emit legal WGSL for it
# -- resolving that is a decision (route the plain reads through atomicLoad) rather than a
# transformation. Its WGSL is hand-maintained; see docs/WEB_BUILD.md section 4.1.
#
# Requires:
#   glslangValidator   from the Vulkan SDK
#   naga               cargo install naga-cli
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src="$repo/Sand/shaders"
out="$src/wgsl"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$out"

for pair in screen.vert:vert raymarch.frag:frag; do
    glsl="${pair%%:*}"
    stage="${pair##*:}"
    stem="${glsl%.*}"

    # -DSAND_WEB swaps the push-constant block for a uniform at binding 3. WebGPU has no push
    # constants, so the Vulkan declaration cannot be translated at all -- see the #ifdef in the
    # shader itself.
    glslangValidator -V -DSAND_WEB -S "$stage" "$src/$glsl" -o "$tmp/$stem.spv" >/dev/null
    naga "$tmp/$stem.spv" "$tmp/$stem.wgsl"

    # The hash of the GLSL this was made from. cmake/Shaders.cmake re-computes it and refuses to
    # build against a stale translation -- which matters because the failure is otherwise silent
    # and specific: the page renders last week's shader and nothing says so.
    hash="$(sha256sum "$src/$glsl" | cut -d' ' -f1)"
    {
        echo "// GENERATED FILE -- DO NOT EDIT."
        echo "//"
        echo "// Translated from $glsl by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga)."
        echo "// Edit $glsl and re-run that script instead; edits here are overwritten and, worse,"
        echo "// silently diverge from the shader the desktop build uses."
        echo "//"
        echo "// source-sha256: $hash"
        echo ""
        cat "$tmp/$stem.wgsl"
    } > "$out/$stem.wgsl"

    printf '  %-18s -> %s (%s lines)\n' "$glsl" "wgsl/$stem.wgsl" "$(wc -l < "$out/$stem.wgsl")"
done

echo "Done. Commit the results."
