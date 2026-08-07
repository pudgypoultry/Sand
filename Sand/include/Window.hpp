#pragma once

#include "GfxBackend.hpp"

// Only the Vulkan build wants GLFW to pull vulkan.h in behind glfw3.h -- that is what declares
// glfwCreateWindowSurface and glfwGetRequiredInstanceExtensions, which VulkanContext uses. Under
// Emscripten there is no Vulkan header to find and the include would simply fail; the canvas is
// obtained from the WebGPU side instead, so nothing is lost by leaving it out.
#ifdef SAND_BACKEND_VULKAN
#define GLFW_INCLUDE_VULKAN
#endif
#include <GLFW/glfw3.h>
#include <string>
#include <algorithm>

class Window {
public:
    // FUNCTION: Window
    // Constructor: Initializes the GLFW window with the given dimensions and title
    Window(int width, int height, std::string name);

    // FUNCTION: ~Window
    // Destructor: Safely destroys the window and terminates GLFW
    ~Window();

    // Prevent copying of the window object to avoid double-freeing GLFW resources
    Window(const Window&) = delete;
    Window& operator=(const Window&) = delete;

    // FUNCTION: shouldClose
    // Checks if the window has been instructed to close by the OS or user
    bool shouldClose() const;

    // FUNCTION: pollEvents
    // Processes all pending OS window events (resizing, closing, input)
    void pollEvents() const;

    // FUNCTION: getGLFWwindow
    // Retrieves the underlying GLFW window pointer, required for Vulkan surface creation
    GLFWwindow* getGLFWwindow() const;

    // FUNCTION: processInput
    // Reads mouse and keyboard state, ignoring them if the UI overlay is capturing them
    void processInput(bool captureMouse, bool captureKeyboard);

    // FUNCTION: resetCamera
    // Restores the camera pitch, yaw, and coordinates to their default starting values
    void resetCamera();

    // The default camera pose is expressed in world units, so it has to know how big the world is --
    // the old constants framed a 128 cube and would have left a small grid a speck and a large one
    // off screen.
    void setWorldExtents(float w, float h, float d) { worldW = w; worldH = h; worldD = d; resetCamera(); }

    // Accessors for camera state
    float getPitch() const { return camPitch; }
    float getYaw() const { return camYaw; }
    float getCamX() const { return camX; }
    float getCamY() const { return camY; }
    float getCamZ() const { return camZ; }

    // Accessors for mouse state
    bool isLeftClicking() const { return leftClickActive; }
    float getMouseNdcX() const;
    float getMouseNdcY() const;

    // FUNCTION: setSize
    // Tells the window how large it actually is, which getMouseNdcX/Y divide by.
    //
    // The desktop never needs this: GLFW_RESIZABLE is false, so the window stays the size it was
    // constructed with and the constructor's values stay true. A canvas does not honour that hint
    // -- the page's stylesheet sizes it -- so on the web the constructor's 1600x1200 is wrong the
    // moment the browser window is any other shape, and the cursor raycast lands somewhere the
    // user did not click. WebGpuRenderer::syncCanvasSize keeps this current.
    //
    // In CSS pixels, deliberately. Mouse positions arrive in the element's coordinate system, so
    // this must match that and not the backing store, which render.resolution_scale detaches
    // from it.
    void setSize(int w, int h) { width = w; height = h; }

    // The size setSize last agreed on, which is what the aspect correction is derived from.
    int getWidth() const { return width; }
    int getHeight() const { return height; }

    // The raw cursor position as GLFW reports it, before any normalisation. Only the cursor
    // diagnostic uses these -- everything else should go through getMouseNdcX/Y, which is the
    // number that actually matters.
    double getMouseX() const { return currentMouseX; }
    double getMouseY() const { return currentMouseY; }

    //// FUNCTION: getCurrentMaterial
    //// Accessor for selected material
    //int getCurrentMaterial() const { return currentMaterial; }

    //// FUNCTION: setCurrentMaterial
    //// Mutator for selected material (Used by the UI Dropdown)
    //void setCurrentMaterial(int mat) { currentMaterial = mat; }

    //// FUNCTION: getBrushSize
    //// Accessor for brush size
    //int getBrushSize() const { return brushSize; }

    //// FUNCTION: setBrushSize
    //// Mutator for brush size (Used by the UI Slider)
    //void setBrushSize(int size) { brushSize = std::max(1, std::min(32, size)); }

    //// FUNCTION: getSimulationSpeed
    //// Accessor for the number of physics micro-steps per frame
    //int getSimulationSpeed() const { return simulationSpeed; }

    //// FUNCTION: setSimulationSpeed
    //// Mutator for the physics micro-steps (Used by the UI Slider)
    //void setSimulationSpeed(int speed) { simulationSpeed = std::max(1, std::min(10, speed)); }

    //// FUNCTION: requestGridClear
    //// Flags the engine to wipe the SSBO on the next frame
    //void requestGridClear() { pendingGridClear = true; }

    //// FUNCTION: consumeGridClear
    //// Reads and immediately resets the grid clear flag
    //bool consumeGridClear() {
    //    bool res = pendingGridClear;
    //    pendingGridClear = false;
    //    return res;
    //}

private:
    // FUNCTION: initWindow
    // Performs the actual GLFW library initialization and window creation
    void initWindow();

    int width;
    int height;
    std::string windowName;
    GLFWwindow* window;

    // Camera control tracking variables
    // Adjusted initial camera position to view the larger 128x128x128 grid
    float camPitch = -0.4f;
    float camYaw = 0.0f;
    float camX = 64.0f;
    float camY = 140.0f;
    float camZ = -120.0f;
    float worldW = 128.0f, worldH = 128.0f, worldD = 128.0f;

    double currentMouseX = 0.0;
    double currentMouseY = 0.0;
    bool leftClickActive = false;
    double lastMouseX = 0.0;
    double lastMouseY = 0.0;
    bool firstMouse = true;

    //// Tracks the active brush element
    //int currentMaterial = 1; // 1 = Sand, 2 = Water, 3 = Stone, 4 = Dirt

    //// Tracks brush scale and UI cooldowns
    //int brushSize = 3;
    //bool qWasPressed = false;
    //bool eWasPressed = false;

    //// Tracks how many times the compute shader runs per graphical frame
    //int simulationSpeed = 1;

    //// Tracks if the user has requested a total simulation wipe via the UI
    //bool pendingGridClear = false;
};