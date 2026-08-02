#include "Window.hpp"
#include <stdexcept>
#include <cmath>
#include <algorithm>

// Static variable to store scroll wheel input between frames
static double scrollYOffset = 0.0;

// FUNCTION: scrollCallback
// Adds the scroll offset to the static variable so it can be processed in the main loop
void scrollCallback(GLFWwindow* window, double xoffset, double yoffset) {
    scrollYOffset += yoffset;
}

// FUNCTION: Window
// Constructor: Stores window configuration and calls the initialization routine
Window::Window(int w, int h, std::string name) : width{ w }, height{ h }, windowName{ name } {
    initWindow();
}

// FUNCTION: ~Window
// Destructor: Cleans up the GLFW window and terminates the GLFW library
Window::~Window() {
    glfwDestroyWindow(window);
    glfwTerminate();
}

// FUNCTION: initWindow
// Configures GLFW to skip creating an OpenGL context, then creates the window
void Window::initWindow() {
    glfwInit();
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

    window = glfwCreateWindow(width, height, windowName.c_str(), nullptr, nullptr);
    if (!window) {
        throw std::runtime_error("Failed to create GLFW window!");
    }

    // Register the scroll callback for zooming
    glfwSetScrollCallback(window, scrollCallback);
}

// FUNCTION: shouldClose
// Returns the state of the GLFW close flag
bool Window::shouldClose() const {
    return glfwWindowShouldClose(window);
}

// FUNCTION: pollEvents
// Instructs GLFW to process the OS event queue
void Window::pollEvents() const {
    glfwPollEvents();
}

// FUNCTION: getGLFWwindow
// Returns the raw window pointer
GLFWwindow* Window::getGLFWwindow() const {
    return window;
}

// FUNCTION: resetCamera
// Returns the camera to the default spawn location and angle
void Window::resetCamera() {
    camPitch = -0.4f;
    camYaw = 0.0f;
    // Framed against the world rather than a fixed 128 cube: centred on X, a little above the top,
    // and backed off by roughly a world-width so the whole thing fits whatever size it is.
    camX = worldW * 0.5f;
    camY = worldH * 1.1f;
    camZ = -worldW * 0.94f;
    scrollYOffset = 0.0;
}

// FUNCTION: processInput
// Polls the cursor position, calculates camera rotation, handles WASD/Zoom, and processes UI keystrokes.
// Ignores physics placement and movement if the mouse/keyboard are interacting with the ImGui overlay.
void Window::processInput(bool captureMouse, bool captureKeyboard) {
    glfwGetCursorPos(window, &currentMouseX, &currentMouseY);

    // Only allow placing blocks if ImGui isn't using the mouse
    leftClickActive = !captureMouse && (glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS);

    // Right-click drag for rotation
    if (!captureMouse && glfwGetMouseButton(window, GLFW_MOUSE_BUTTON_RIGHT) == GLFW_PRESS) {
        if (firstMouse) {
            lastMouseX = currentMouseX;
            lastMouseY = currentMouseY;
            firstMouse = false;
        }

        float xoffset = (float)(currentMouseX - lastMouseX);
        float yoffset = (float)(currentMouseY - lastMouseY);

        lastMouseX = currentMouseX;
        lastMouseY = currentMouseY;

        float sensitivity = 0.005f;
        camYaw -= xoffset * sensitivity;
        camPitch += yoffset * sensitivity;

        if (camPitch > 1.5f) camPitch = 1.5f;
        if (camPitch < -1.5f) camPitch = -1.5f;
    }
    else {
        firstMouse = true;
    }

    if (!captureKeyboard) {
        // WASD Flight Movement
        float speed = 0.5f;

        float forwardX = -sin(camYaw);
        float forwardZ = cos(camYaw);
        float rightX = cos(camYaw);
        float rightZ = sin(camYaw);

        if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS) {
            camX += forwardX * speed;
            camZ += forwardZ * speed;
        }
        if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS) {
            camX -= forwardX * speed;
            camZ -= forwardZ * speed;
        }
        if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS) {
            camX -= rightX * speed;
            camZ -= rightZ * speed;
        }
        if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS) {
            camX += rightX * speed;
            camZ += rightZ * speed;
        }
        if (glfwGetKey(window, GLFW_KEY_SPACE) == GLFW_PRESS) {
            camY += speed; // Fly Up
        }
        if (glfwGetKey(window, GLFW_KEY_LEFT_SHIFT) == GLFW_PRESS) {
            camY -= speed; // Fly Down
        }

        //// Material Selection Keystrokes
        //if (glfwGetKey(window, GLFW_KEY_0) == GLFW_PRESS) currentMaterial = 0; // Void / Erase
        //if (glfwGetKey(window, GLFW_KEY_1) == GLFW_PRESS) currentMaterial = 1; // Sand
        //if (glfwGetKey(window, GLFW_KEY_2) == GLFW_PRESS) currentMaterial = 2; // Water
        //if (glfwGetKey(window, GLFW_KEY_3) == GLFW_PRESS) currentMaterial = 3; // Stone
        //if (glfwGetKey(window, GLFW_KEY_4) == GLFW_PRESS) currentMaterial = 4; // Dirt
        //if (glfwGetKey(window, GLFW_KEY_5) == GLFW_PRESS) currentMaterial = 5; // Fire

        //// Brush size adjustments (Q to decrease, E to increase)
        //bool qIsPressed = (glfwGetKey(window, GLFW_KEY_Q) == GLFW_PRESS);
        //if (qIsPressed && !qWasPressed) {
        //    brushSize = std::max(1, brushSize - 1);
        //}
        //qWasPressed = qIsPressed;

        //bool eIsPressed = (glfwGetKey(window, GLFW_KEY_E) == GLFW_PRESS);
        //if (eIsPressed && !eWasPressed) {
        //    brushSize = std::min(32, brushSize + 1);
        //}
        //eWasPressed = eIsPressed;
    }

    // Zooming via scroll wheel (Dollying the camera along the true 3D view vector)
    if (!captureMouse && scrollYOffset != 0.0) {
        float zoomSpeed = 6.0f;

        float trueForwardX = -sin(camYaw) * cos(camPitch);
        float trueForwardY = -sin(camPitch);
        float trueForwardZ = cos(camYaw) * cos(camPitch);

        camX += trueForwardX * (float)scrollYOffset * zoomSpeed;
        camY += trueForwardY * (float)scrollYOffset * zoomSpeed;
        camZ += trueForwardZ * (float)scrollYOffset * zoomSpeed;

        scrollYOffset = 0.0; // Reset after processing
    }
    else {
        scrollYOffset = 0.0; // Consume the scroll event if ImGui captured it
    }
}

// FUNCTION: getMouseNdcX
// Normalized Device Coordinates (-1.0 to +1.0) for the raycaster
float Window::getMouseNdcX() const {
    return (float)((currentMouseX / width) * 2.0 - 1.0);
}

// FUNCTION: getMouseNdcY
// Normalized Device Coordinates (-1.0 to +1.0) for the raycaster
float Window::getMouseNdcY() const {
    return (float)((currentMouseY / height) * 2.0 - 1.0);
}