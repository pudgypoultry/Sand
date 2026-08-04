# Shader compilation, which is where the two targets diverge most.
#
# Vulkan consumes SPIR-V, so the desktop build is one glslc invocation per shader. A browser
# consumes only WGSL -- there is no path that hands SPIR-V to WebGPU, by design; the specification
# rejected binary shader input over the risk of driver bugs reachable from a web page. So the web
# build needs a translation step, and for one of the three shaders that step cannot be automatic.
#
# Why not automatic: WGSL forbids a storage buffer being both atomic and non-atomic. A binding is
# array<atomic<u32>> or array<u32>, never both, and there is no reinterpreting between them.
# falling_sand.comp reads the grid plainly in seventy-six places and atomically in seventy-two, so
# there is no legal WGSL that a translator can emit for it -- the resolution is a decision (route
# the plain reads through atomicLoad) rather than a transformation. The shader is already written
# through readCell/writeCell so that decision is two function bodies, but it is still a decision.
#
# Hence: a hand-maintained WGSL file wins if present, and translation is the fallback for the two
# shaders that have no atomics in them at all.

find_program(SAND_GLSLC NAMES glslc HINTS "$ENV{VULKAN_SDK}/Bin" "$ENV{VULKAN_SDK}/bin")
find_program(SAND_TINT  NAMES tint  HINTS "$ENV{DAWN_DIR}/bin" "$ENV{TINT_DIR}")

set(SAND_SHADER_STAGES
    "falling_sand.comp"
    "raymarch.frag"
    "screen.vert")

# FUNCTION: sand_add_shaders
# Attaches a shader build step to `target`, producing whatever that target's backend can load into
# ${CMAKE_CURRENT_BINARY_DIR}/shaders.
function(sand_add_shaders target)
    set(shader_src "${CMAKE_CURRENT_SOURCE_DIR}/Sand/shaders")
    set(shader_out "${CMAKE_BINARY_DIR}/shaders")
    file(MAKE_DIRECTORY "${shader_out}")

    if(NOT SAND_GLSLC)
        message(FATAL_ERROR
            "glslc not found. Install the Vulkan SDK (vulkan.lunarg.com) and set VULKAN_SDK.\n"
            "It is needed for the web build too: the GLSL is compiled to SPIR-V first and "
            "translated from there.")
    endif()

    set(outputs "")

    foreach(shader IN LISTS SAND_SHADER_STAGES)
        set(glsl "${shader_src}/${shader}")
        set(spv  "${shader_out}/${shader}.spv")

        # falling_sand.comp is the exception in naming as well as in translation: the Vulkan build
        # loads it as falling_sand.spv, without the stage suffix the other two carry.
        if(shader STREQUAL "falling_sand.comp")
            set(spv "${shader_out}/falling_sand.spv")
        endif()

        add_custom_command(
            OUTPUT "${spv}"
            COMMAND "${SAND_GLSLC}" "${glsl}" -o "${spv}"
            DEPENDS "${glsl}"
            COMMENT "glslc ${shader}"
            VERBATIM)

        if(NOT EMSCRIPTEN)
            list(APPEND outputs "${spv}")
            continue()
        endif()

        # --- web: SPIR-V is not loadable, so carry on to WGSL -------------------------------------
        string(REGEX REPLACE "\\.[a-z]+$" "" stem "${shader}")
        set(wgsl "${shader_out}/${stem}.wgsl")
        set(committed "${shader_src}/wgsl/${stem}.wgsl")

        if(EXISTS "${committed}")
            # A committed translation carries the SHA-256 of the GLSL it was made from, and it is
            # checked here rather than trusted. Timestamps cannot do this job: a fresh clone gives
            # every file the same mtime, so an mtime rule is both false-negative in a clone and
            # false-positive after a checkout. The hash is exact in either.
            #
            # Worth the twenty lines because the failure it catches is silent and specific -- edit
            # raymarch.frag, forget to regenerate, and the page renders last week's shader while
            # the desktop build renders this week's, with nothing anywhere saying they differ.
            file(READ "${committed}" _wgsl_head LIMIT 1024)
            file(SHA256 "${glsl}" _glsl_hash)
            if(NOT _wgsl_head MATCHES "source-sha256: ${_glsl_hash}")
                if(_wgsl_head MATCHES "source-sha256: ([0-9a-f]+)")
                    message(FATAL_ERROR
                        "${stem}.wgsl was generated from a different ${shader}.\n"
                        "  committed translation came from: ${CMAKE_MATCH_1}\n"
                        "  ${shader} is currently:           ${_glsl_hash}\n"
                        "Re-run tools/gen_wgsl.sh and commit the result. Building as-is would run "
                        "one shader on the web and a different one on the desktop.")
                else()
                    message(FATAL_ERROR
                        "${committed} has no source-sha256 line, so it cannot be checked against "
                        "${shader}. Re-run tools/gen_wgsl.sh to regenerate it properly.")
                endif()
            endif()

            add_custom_command(
                OUTPUT "${wgsl}"
                COMMAND ${CMAKE_COMMAND} -E copy_if_different "${committed}" "${wgsl}"
                DEPENDS "${committed}"
                COMMENT "wgsl ${stem} (committed translation)"
                VERBATIM)
        elseif(SAND_TINT)
            add_custom_command(
                OUTPUT "${wgsl}"
                COMMAND "${SAND_TINT}" --format wgsl -o "${wgsl}" "${spv}"
                DEPENDS "${spv}"
                COMMENT "tint ${stem} (translated from SPIR-V)"
                VERBATIM)
        else()
            # Skipped rather than fatal. The port is milestone by milestone: the first renderer
            # clears the canvas and draws the UI and loads no shaders at all, so demanding a WGSL
            # translation here would block the milestone whose entire purpose is to prove the
            # toolchain works. A renderer that does need one will fail to open it and say which,
            # which is a better error than a configure-time refusal to build anything.
            message(STATUS "No WGSL for ${stem} -- skipping. "
                           "Run tools/gen_wgsl.sh, or hand-write ${committed}.")
            continue()
        endif()

        list(APPEND outputs "${wgsl}")
    endforeach()

    add_custom_target(sand_shaders DEPENDS ${outputs})
    add_dependencies(${target} sand_shaders)

    # Whether anything was actually produced. On the web this can legitimately be nothing -- see the
    # skip above -- and the caller needs to know so it does not ask the file packager to preload an
    # empty directory.
    set(SAND_SHADER_OUTPUTS "${outputs}" PARENT_SCOPE)
endfunction()
