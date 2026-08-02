<#
.SYNOPSIS
    Builds Sand and assembles a zip a tester can unpack and run.

.DESCRIPTION
    The app loads shaders/*.spv and config.txt by paths relative to the working directory, so a
    package is not just the exe -- it is the exe with those sitting beside it. That is why running
    Sand.exe straight out of x64\Release does nothing useful: the assets are in the project folder,
    not the output folder.

    Release rather than Debug, and not only for speed. A Debug build links the debug CRT, and
    Microsoft does not license that for redistribution -- it also simply will not start on a machine
    without Visual Studio installed. Shipping the Debug exe is the most common way this goes wrong.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File tools\package.ps1
#>
[CmdletBinding()]
param(
    [string]$Configuration = "Release",
    [string]$Platform      = "x64",
    [string]$OutputDir     = "dist",
    [switch]$SkipBuild,
    [switch]$Incremental
)

$ErrorActionPreference = "Stop"

$repoRoot    = Split-Path -Parent $PSScriptRoot
$projectDir  = Join-Path $repoRoot "Sand"
$projectFile = Join-Path $projectDir "Sand.vcxproj"

if (-not (Test-Path $projectFile)) {
    throw "Could not find $projectFile. Run this from a clone of the repository."
}

# ---------------------------------------------------------------------------------------------
# Build
# ---------------------------------------------------------------------------------------------
if (-not $SkipBuild) {
    # vswhere ships with every VS 2017+ install and is the supported way to find MSBuild. Hardcoding
    # a path breaks on every edition and version bump.
    $vswhere = Join-Path ${env:ProgramFiles(x86)} "Microsoft Visual Studio\Installer\vswhere.exe"
    if (-not (Test-Path $vswhere)) {
        throw "vswhere.exe not found. Visual Studio 2017 or newer is required to build."
    }

    $msbuild = & $vswhere -latest -products * `
                          -requires Microsoft.Component.MSBuild `
                          -find "MSBuild\**\Bin\MSBuild.exe" | Select-Object -First 1
    if (-not $msbuild) {
        throw "MSBuild not found. Install the 'Desktop development with C++' workload."
    }

    # The shaders are compiled by the project's pre-build step, which shells out to glslc from the
    # Vulkan SDK. Without the SDK the build fails partway with a message about glslc rather than
    # about the SDK, so check for it here where the error can say what is actually wrong.
    if (-not $env:VULKAN_SDK) {
        throw "VULKAN_SDK is not set. Install the Vulkan SDK (vulkan.lunarg.com) and reopen the shell."
    }

    # Two guards against a failure mode that cost a build once already: MSBuild derives an object
    # file name from each ClCompile item's BASE name, dropping the directory, so two items sharing a
    # base name write the same .obj and silently overwrite each other. With /m they do it in
    # parallel, so which one survives is a race -- the build works, then the identical build fails to
    # link, and the error names missing symbols rather than the duplicate that caused it.
    #
    # The instance that happened was a header listed as ClCompile: include\Config.hpp compiled to
    # Config.obj, the same object src\Config.cpp produces, and the header's copy has no definitions
    # in it. Both shapes are checked here because both produce the same baffling link error.
    $proj = [xml](Get-Content $projectFile)
    $items = @($proj.Project.ItemGroup.ClCompile | Where-Object { $_.Include } | ForEach-Object { $_.Include })

    $notSource = $items | Where-Object { $_ -notmatch '\.(c|cc|cpp|cxx)$' }
    if ($notSource) {
        throw ("These are listed as ClCompile but are not source files, so each compiles to an " +
               "object that may collide with a real one: " + ($notSource -join ", "))
    }

    $collisions = $items |
        Group-Object { [System.IO.Path]::GetFileNameWithoutExtension($_).ToLower() } |
        Where-Object { $_.Count -gt 1 }
    if ($collisions) {
        throw ("Two or more sources share a base name and would compile to the same .obj: " +
               (($collisions | ForEach-Object { $_.Group -join " / " }) -join "; "))
    }

    # Rebuild, not Build, and that is not just belt and braces for a release artifact.
    #
    # MSBuild decides whether to recompile by comparing timestamps, so an object file that is newer
    # than its source is left alone no matter how wrong it is. That is a real state this project has
    # been in: a bad Config.obj, written by a header that was mistakenly listed as a source, survived
    # the fix to the project file and kept being linked, because fixing the project did not touch
    # Config.cpp and so did not make it newer than the object. The build failed identically after the
    # bug was fixed, which is about as misleading as a build gets.
    #
    # Pass -Incremental to skip this while iterating; it is only safe when nothing has changed
    # underneath the object files.
    $target = if ($Incremental) { "Build" } else { "Rebuild" }
    Write-Host "$target $Configuration|$Platform ..." -ForegroundColor Cyan
    & $msbuild $projectFile /t:$target /p:Configuration=$Configuration /p:Platform=$Platform /m /v:minimal
    if ($LASTEXITCODE -ne 0) { throw "Build failed." }
}

# ---------------------------------------------------------------------------------------------
# Assemble
# ---------------------------------------------------------------------------------------------
$exePath = Join-Path $projectDir "$Platform\$Configuration\Sand.exe"
if (-not (Test-Path $exePath)) {
    throw "Built no executable at $exePath. Check the build output above."
}

$stamp   = Get-Date -Format "yyyy-MM-dd"
$stageIn = Join-Path $repoRoot $OutputDir
$stage   = Join-Path $stageIn "Sand-$stamp"

if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory -Path (Join-Path $stage "shaders") -Force | Out-Null

Copy-Item $exePath $stage

# Only the compiled SPIR-V. The GLSL sources are of no use without the SDK, and shipping them
# invites someone to edit one and wonder why nothing changed.
$shaders = @("falling_sand.spv", "screen.vert.spv", "raymarch.frag.spv")
foreach ($shader in $shaders) {
    $src = Join-Path $projectDir "shaders\$shader"
    if (-not (Test-Path $src)) {
        throw "Missing $src. The pre-build step that compiles shaders did not run; build once in Visual Studio, or check VULKAN_SDK."
    }
    # A stale .spv is the nastiest failure mode here, because everything loads and runs and the
    # behaviour is simply last week's. Refuse rather than ship one.
    $glsl = Join-Path $projectDir ("shaders\" + ($shader -replace '\.spv$',''))
    if ((Test-Path $glsl) -and ((Get-Item $glsl).LastWriteTime -gt (Get-Item $src).LastWriteTime)) {
        throw "$shader is older than its GLSL source. Rebuild so the shaders are recompiled."
    }
    Copy-Item $src (Join-Path $stage "shaders")
}

Copy-Item (Join-Path $projectDir "config.txt") $stage

# imgui.ini is deliberately NOT copied. It stores window positions, and the UI has one-shot startup
# placement that only takes effect when the file is absent -- ship one and every tester inherits
# whatever layout this machine happened to have.

$readme = Join-Path $repoRoot "tools\TESTER_README.txt"
if (Test-Path $readme) { Copy-Item $readme (Join-Path $stage "README.txt") }

# Third-party notices, and this one is not optional. GLFW's zlib licence and Dear ImGui's MIT
# licence both require their notices to accompany a distribution of the software, and a
# binary-only zip is a distribution. Shipping the exe without this file is the one thing here that
# would actually breach either licence, so the package refuses to build rather than quietly omit it.
$credits = Join-Path $projectDir "Credits.txt"
if (-not (Test-Path $credits) -or (Get-Item $credits).Length -eq 0) {
    throw "Sand\Credits.txt is missing or empty. GLFW and Dear ImGui both require their licence notices to ship with the binary."
}
Copy-Item $credits (Join-Path $stage "Credits.txt")

# ---------------------------------------------------------------------------------------------
# Zip
# ---------------------------------------------------------------------------------------------
$zip = Join-Path $stageIn "Sand-$stamp-$Platform.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path (Join-Path $stage "*") -DestinationPath $zip

$sizeMb = [math]::Round((Get-Item $zip).Length / 1MB, 2)
$hash   = (Get-FileHash $zip -Algorithm SHA256).Hash
$exeHash = (Get-FileHash (Join-Path $stage "Sand.exe") -Algorithm SHA256).Hash

Write-Host ""
Write-Host "Packaged $zip ($sizeMb MB)" -ForegroundColor Green
Write-Host "  zip SHA-256 $hash"
Write-Host "  exe SHA-256 $exeHash"
Write-Host "Contents:" -ForegroundColor Green
Get-ChildItem $stage -Recurse -File | ForEach-Object {
    Write-Host ("  " + $_.FullName.Substring($stage.Length + 1))
}
Write-Host ""
Write-Host "The tester needs a Vulkan-capable GPU driver and the Microsoft Visual C++ 2015-2022" -ForegroundColor Yellow
Write-Host "x64 Redistributable. See README.txt in the package." -ForegroundColor Yellow
Write-Host ""
Write-Host "This executable is unsigned, so Defender and SmartScreen may flag it on a machine that" -ForegroundColor Yellow
Write-Host "has never seen it. See the false positives section of BUILDING.md; the exe hash above is" -ForegroundColor Yellow
Write-Host "what to give a tester, or submit to VirusTotal, so they can check they have the file you" -ForegroundColor Yellow
Write-Host "actually sent." -ForegroundColor Yellow
