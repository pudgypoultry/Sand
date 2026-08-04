# Sand -- desktop (Vulkan) and web (WebGPU) builds.
#
# Sand.vcxproj remains the canonical Windows build and is not affected by anything here; this file
# exists because the web target cannot be expressed in it. Emscripten builds through emcmake, which
# is CMake, and MSBuild has no notion of a compiler that emits WebAssembly.
#
# Configure:
#   desktop   cmake -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build
#   web       emcmake cmake -B build-web -DCMAKE_BUILD_TYPE=Release && cmake --build build-web
#
# The backend follows the toolchain and does not normally need setting by hand -- see SAND_BACKEND
# below for why it is a choice at configure time rather than at runtime.

cmake_minimum_required(VERSION 3.20)
project(Sand LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "" FORCE)
endif()

# -------------------------------------------------------------------------------------------------
# Backend
# -------------------------------------------------------------------------------------------------
# One binary, one backend, decided here. There is nothing to choose between at runtime: a desktop
# build has no WebGPU implementation linked into it and a web build has no Vulkan. Making it a
# configure-time switch keeps the cost at zero -- no vtable, no indirection -- and means the Vulkan
# path compiles to exactly what it did before the web target existed.
if(EMSCRIPTEN)
    set(SAND_BACKEND_DEFAULT webgpu)
else()
    set(SAND_BACKEND_DEFAULT vulkan)
endif()

set(SAND_BACKEND "${SAND_BACKEND_DEFAULT}" CACHE STRING "Graphics backend: vulkan or webgpu")
set_property(CACHE SAND_BACKEND PROPERTY STRINGS vulkan webgpu)

if(NOT SAND_BACKEND MATCHES "^(vulkan|webgpu)$")
    message(FATAL_ERROR "SAND_BACKEND must be 'vulkan' or 'webgpu', not '${SAND_BACKEND}'.")
endif()
if(EMSCRIPTEN AND SAND_BACKEND STREQUAL "vulkan")
    message(FATAL_ERROR "A browser has no Vulkan. Configure the web build without -DSAND_BACKEND.")
endif()

message(STATUS "Sand backend: ${SAND_BACKEND}")

# -------------------------------------------------------------------------------------------------
# Vendored dependencies
# -------------------------------------------------------------------------------------------------
# vendor/ is not in the repository -- see BUILDING.md -- so the failure has to name what is missing
# rather than surfacing sixty lines later as an unfound header.
set(SAND_VENDOR_DIR "${CMAKE_CURRENT_SOURCE_DIR}/vendor" CACHE PATH "Directory holding glfw/ and imgui/")
set(IMGUI_DIR "${SAND_VENDOR_DIR}/imgui")

if(NOT EXISTS "${IMGUI_DIR}/imgui.cpp")
    message(FATAL_ERROR
        "Dear ImGui not found at ${IMGUI_DIR}.\n"
        "Clone it there (git clone https://github.com/ocornut/imgui) or point -DSAND_VENDOR_DIR at "
        "the directory that holds glfw/ and imgui/.")
endif()

set(IMGUI_SOURCES
    "${IMGUI_DIR}/imgui.cpp"
    "${IMGUI_DIR}/imgui_draw.cpp"
    "${IMGUI_DIR}/imgui_tables.cpp"
    "${IMGUI_DIR}/imgui_widgets.cpp"
    "${IMGUI_DIR}/backends/imgui_impl_glfw.cpp")

# -------------------------------------------------------------------------------------------------
# Sources
# -------------------------------------------------------------------------------------------------
set(SAND_DIR "${CMAKE_CURRENT_SOURCE_DIR}/Sand")

# Compiles identically for both targets and knows about neither graphics API. This is most of the
# project by line count, which is the whole argument for the split: the options screen, the config
# schema, the profiler and every panel are shared rather than ported.
set(SAND_CORE_SOURCES
    "${SAND_DIR}/src/Config.cpp"
    "${SAND_DIR}/src/ConfigSchema.cpp"
    "${SAND_DIR}/src/AssetPaths.cpp"
    "${SAND_DIR}/src/CursorRay.cpp"
    "${SAND_DIR}/src/Storage.cpp"
    "${SAND_DIR}/src/FrameLoop.cpp"
    "${SAND_DIR}/src/Window.cpp"
    "${SAND_DIR}/src/main.cpp")

set(SAND_VULKAN_SOURCES
    "${SAND_DIR}/src/VulkanRenderer.cpp"
    "${SAND_DIR}/src/VulkanContext.cpp"
    "${SAND_DIR}/src/VulkanPipeline.cpp"
    "${SAND_DIR}/src/VulkanSwapchain.cpp"
    "${SAND_DIR}/src/VulkanBuffer.cpp"
    "${SAND_DIR}/src/UiBackendVulkan.cpp")

set(SAND_WEBGPU_SOURCES
    "${SAND_DIR}/src/UiBackendWebGpu.cpp"
    "${SAND_DIR}/src/WebGpuRenderer.cpp")

# -------------------------------------------------------------------------------------------------
# Target
# -------------------------------------------------------------------------------------------------
if(SAND_BACKEND STREQUAL "vulkan")
    set(SAND_BACKEND_SOURCES ${SAND_VULKAN_SOURCES})
    list(APPEND IMGUI_SOURCES "${IMGUI_DIR}/backends/imgui_impl_vulkan.cpp")
else()
    set(SAND_BACKEND_SOURCES ${SAND_WEBGPU_SOURCES})
    list(APPEND IMGUI_SOURCES "${IMGUI_DIR}/backends/imgui_impl_wgpu.cpp")
endif()

# The one piece of the web port that is not written yet. Reported here, at configure time, with the
# list of what it has to do -- rather than as an undefined symbol at link time, which says only
# that a name is missing and nothing about why.
set(SAND_MISSING_SOURCES "")
foreach(src IN LISTS SAND_BACKEND_SOURCES)
    if(NOT EXISTS "${src}")
        list(APPEND SAND_MISSING_SOURCES "${src}")
    endif()
endforeach()

if(SAND_MISSING_SOURCES)
    message(STATUS "")
    message(STATUS "  The ${SAND_BACKEND} renderer is not implemented yet. Missing:")
    foreach(src IN LISTS SAND_MISSING_SOURCES)
        file(RELATIVE_PATH rel "${CMAKE_CURRENT_SOURCE_DIR}" "${src}")
        message(STATUS "    ${rel}")
    endforeach()
    message(STATUS "")
    message(STATUS "  Building the shared core only, as target 'sand_core'. See docs/WEB_BUILD.md")
    message(STATUS "  for what the renderer owes its callers.")
    message(STATUS "")

    add_library(sand_core STATIC ${SAND_CORE_SOURCES} ${IMGUI_SOURCES})
    set(SAND_TARGET sand_core)
    set(SAND_HAVE_EXECUTABLE OFF)
else()
    add_executable(Sand ${SAND_CORE_SOURCES} ${SAND_BACKEND_SOURCES} ${IMGUI_SOURCES})
    set(SAND_TARGET Sand)
    set(SAND_HAVE_EXECUTABLE ON)
endif()

target_include_directories(${SAND_TARGET} PRIVATE
    "${SAND_DIR}/include"
    "${IMGUI_DIR}"
    "${IMGUI_DIR}/backends")

if(SAND_BACKEND STREQUAL "vulkan")
    target_compile_definitions(${SAND_TARGET} PRIVATE SAND_BACKEND_VULKAN=1)
else()
    target_compile_definitions(${SAND_TARGET} PRIVATE
        SAND_BACKEND_WEBGPU=1
        # imgui_impl_wgpu.cpp #errors unless exactly one of DAWN/WGPU/WGVK is defined. Its header
        # does pick DAWN by default under __EMSCRIPTEN__, but relying on that means the build
        # depends on an include ordering rather than on something stated. emdawnwebgpu IS Dawn.
        IMGUI_IMPL_WEBGPU_BACKEND_DAWN=1)
endif()

# -------------------------------------------------------------------------------------------------
# Linking
# -------------------------------------------------------------------------------------------------
if(EMSCRIPTEN)
    # GLFW and WebGPU both come from Emscripten's own ports, so there is nothing to find or build.
    #
    # WebGPU is `--use-port=emdawnwebgpu` rather than `-sUSE_WEBGPU=1` as of Emscripten 4.x --
    # the old flag's webgpu.h shipped an early, incompatible draft of the spec and was retired
    # outright rather than kept as an alias, so there is no version range where the previous name
    # still worked. If this stops matching what your emsdk accepts, `em++ --help` lists the
    # current name; the port itself hasn't gone anywhere.
    #
    # Only the port is a compile option. It has to be, because it is what puts webgpu.h on the
    # include path. -sUSE_GLFW=3 is link-only -- Emscripten's GLFW headers are in the sysroot
    # unconditionally -- and passing it here earns a warning on every translation unit.
    # -fwasm-exceptions, on both sides, because Emscripten disables exception CATCHING by default:
    # try/catch compiles, and then `throw` calls abort() and the handler never runs. The symptom is
    # "Aborted(undefined)" with the real message -- the one the throw was carrying -- never printed.
    # Every error path in this renderer is a throw, so without this they are all silent aborts.
    #
    # The wasm form rather than the JS one: it is the modern mechanism, needs no JS glue, and costs
    # very little when nothing is thrown. Chrome and Edge have had it since 95.
    target_compile_options(${SAND_TARGET} PRIVATE "--use-port=emdawnwebgpu" "-fwasm-exceptions")

    # Everything below produces a page, so it belongs to the executable and not to a static library
    # that has nothing to link yet.
    if(SAND_HAVE_EXECUTABLE)
    target_link_options(${SAND_TARGET} PRIVATE
        "-sUSE_GLFW=3"
        "--use-port=emdawnwebgpu"
        "-fwasm-exceptions"
        # The grid is the dominant allocation and it scales with the cube of the world size, so a
        # fixed heap would have to be sized for the largest world anyone might configure. Growth
        # costs a bounds check per access in exchange for not reserving a gigabyte on a page that
        # may only ever run a 64-cube.
        "-sALLOW_MEMORY_GROWTH=1"
        # Storage.cpp's EM_ASM blocks call these from JS, and the linker strips anything not
        # reachable from C++. Without the list they vanish and the config silently stops
        # persisting -- which is exactly the failure the storage seam exists to prevent.
        "-sEXPORTED_RUNTIME_METHODS=['UTF8ToString','stringToUTF8','lengthBytesUTF8']"
        "-sEXPORTED_FUNCTIONS=['_main','_malloc','_free']"
        "-sSTACK_SIZE=1048576"
        # On while the port is being brought up. Without it an abort prints "Aborted(undefined)"
        # and the actual reason is discarded, which has already cost several rounds of guessing.
        # Worth the size until the web build stops surprising us.
        "-sASSERTIONS=1"
        # SHELL: keeps the flag and its argument together as one entry.
        #
        # Without it they are two list items, and target_link_options DE-DUPLICATES: a second
        # --preload-file is dropped as a repeat of the first, its path is left behind as a bare
        # argument, and the linker reports it as a missing input file. The error names the file
        # rather than the flag, so it reads as a path problem and is not one.
        "SHELL:--shell-file ${CMAKE_CURRENT_SOURCE_DIR}/web/shell.html")

    set_target_properties(${SAND_TARGET} PROPERTIES SUFFIX ".html")
    endif()
else()
    # Guarded on the backend rather than on the platform: -DSAND_BACKEND=webgpu on a desktop is a
    # legitimate configuration (native WebGPU through Dawn), and it must not drag Vulkan in.
    if(SAND_BACKEND STREQUAL "vulkan")
        find_package(Vulkan REQUIRED)
        target_link_libraries(${SAND_TARGET} PRIVATE Vulkan::Vulkan)
    endif()

    # Three shapes vendor/glfw can take, in the order they are preferred.
    #
    # The first is the one actually in this repository, and it is the one an earlier version of
    # this file got wrong: what is vendored is GLFW's PREBUILT WINDOWS DISTRIBUTION -- headers plus
    # lib-vc2022/glfw3.lib -- and not its source tree. Sand.vcxproj has always linked it that way.
    # Looking only for a CMakeLists.txt meant CMake fell through to find_package on the very
    # machine where the library was sitting right there, and failed.
    if(EXISTS "${SAND_VENDOR_DIR}/glfw/include/GLFW/glfw3.h" AND NOT EXISTS "${SAND_VENDOR_DIR}/glfw/CMakeLists.txt")
        # lib-vc2022 is the only variant the repository carries. The others are listed because a
        # GLFW download for a different toolset unpacks to a differently named folder, and finding
        # it is friendlier than failing over a directory name.
        find_library(SAND_GLFW_LIBRARY
            NAMES glfw3 glfw3_mt glfw
            PATHS "${SAND_VENDOR_DIR}/glfw/lib-vc2022"
                  "${SAND_VENDOR_DIR}/glfw/lib-vc2019"
                  "${SAND_VENDOR_DIR}/glfw/lib-mingw-w64"
            NO_DEFAULT_PATH)

        if(NOT SAND_GLFW_LIBRARY)
            message(FATAL_ERROR
                "Found GLFW's headers at ${SAND_VENDOR_DIR}/glfw/include but no import library "
                "beside them. The prebuilt distribution puts it in lib-vc2022/glfw3.lib -- if that "
                "file is a few hundred bytes of text beginning 'version https://git-lfs...', it is "
                "an LFS pointer and `git lfs pull` will fetch the real one.")
        endif()

        target_include_directories(${SAND_TARGET} PRIVATE "${SAND_VENDOR_DIR}/glfw/include")
        target_link_libraries(${SAND_TARGET} PRIVATE "${SAND_GLFW_LIBRARY}")

    elseif(EXISTS "${SAND_VENDOR_DIR}/glfw/CMakeLists.txt")
        set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
        set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
        set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
        add_subdirectory("${SAND_VENDOR_DIR}/glfw" glfw EXCLUDE_FROM_ALL)
        target_link_libraries(${SAND_TARGET} PRIVATE glfw)

    else()
        # Nothing vendored: an installed GLFW, which is how this builds on Linux.
        find_package(glfw3 3.3 REQUIRED)
        target_link_libraries(${SAND_TARGET} PRIVATE glfw)
    endif()
endif()

# -------------------------------------------------------------------------------------------------
# Shaders
# -------------------------------------------------------------------------------------------------
# sand_core has no renderer to load a shader into, so it has no business requiring a WGSL
# translation that only the (unwritten) renderer would consume. Skipping this is what lets the
# portable layer's compile check succeed on its own, before falling_sand.wgsl exists.
if(SAND_HAVE_EXECUTABLE)
    include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/Shaders.cmake")
    sand_add_shaders(${SAND_TARGET})
endif()

# -------------------------------------------------------------------------------------------------
# Assets
# -------------------------------------------------------------------------------------------------
if(EMSCRIPTEN AND SAND_HAVE_EXECUTABLE)
    # Packed into the virtual filesystem at the root, which is where AssetPaths looks under
    # Emscripten. SHELL: for the reason given on --shell-file above -- two bare --preload-file
    # entries de-duplicate down to one and the second file silently becomes a stray linker input.
    target_link_options(${SAND_TARGET} PRIVATE
        "SHELL:--preload-file ${SAND_DIR}/config.txt@/config.txt")

    # One --preload-file per shader, naming the real file, rather than one naming a directory. A
    # directory is opaque to the generator: it cannot tell that the contents changed, so the link
    # never re-ran and the package kept its old copy. Naming the files makes them dependencies that
    # actually work.
    foreach(preload IN LISTS SAND_SHADER_PRELOADS)
        target_link_options(${SAND_TARGET} PRIVATE "SHELL:--preload-file ${preload}")
    endforeach()

    # LINK_DEPENDS, and it is load-bearing rather than tidiness.
    #
    # Preloaded files are baked into Sand.data at LINK time, but they are arguments to a flag, not
    # inputs the generator knows about -- and add_dependencies(target sand_shaders) only creates an
    # ORDER-ONLY edge in Ninja. So the copy would run, put a new shader in the directory, and the
    # link would be considered up to date and not repackage it. Editing a shader then changed
    # nothing observable, and the page silently kept running the previous build's copy -- which is
    # exactly the failure the source-sha256 guard exists to prevent, arriving by a different route
    # and past that guard, since the file on disk was correct all along.
    #
    # LINK_DEPENDS makes them real inputs, so touching any of them relinks.
    set_property(TARGET ${SAND_TARGET} APPEND PROPERTY
                 LINK_DEPENDS "${SAND_SHADER_OUTPUTS};${SAND_DIR}/config.txt")
elseif(NOT EMSCRIPTEN AND SAND_HAVE_EXECUTABLE)
    add_custom_command(TARGET ${SAND_TARGET} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
                "${SAND_DIR}/config.txt" "$<TARGET_FILE_DIR:${SAND_TARGET}>/config.txt"
        COMMENT "Copying config.txt beside the executable")
endif()
