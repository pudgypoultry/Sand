#pragma once

#include "Window.hpp"
#include <vector>

// VulkanContext: Manages the core Vulkan API state including instance, device, and queues.
class VulkanContext {
public:
    // Constructor: Initializes the Vulkan instance, surface, and devices.
    VulkanContext(Window* window);

    // Destructor: Safely cleans up the Vulkan handles.
    ~VulkanContext();

    // Delete copy constructors to prevent double-freeing Vulkan resources.
    VulkanContext(const VulkanContext&) = delete;
    VulkanContext& operator=(const VulkanContext&) = delete;

    // Accessor: Returns the core Vulkan instance handle
    VkInstance getInstance() const { return instance; }

    // Accessor: Returns the selected physical GPU handle
    VkPhysicalDevice getPhysicalDevice() const { return physicalDevice; }

    // Accessor: Returns the logical device handle used for API calls
    VkDevice getDevice() const { return device; }

    // Accessor: Returns the OS-specific window surface handle
    VkSurfaceKHR getSurface() const { return surface; }

    // Accessor: Returns the compute and presentation queue handle
    VkQueue getComputeQueue() const { return computeQueue; }

    // Accessor: Returns the index of the compute queue family
    uint32_t getComputeQueueFamily() const { return computeQueueFamily; }

private:
    // Initializes the Vulkan library connection
    void createInstance();
    // Links the Vulkan instance to the OS-specific window managed by GLFW
    void createSurface(Window* window);
    // Selects a GPU supporting compute operations and the window surface
    void pickPhysicalDevice();
    // Configures the software interface to the physical GPU
    void createLogicalDevice();

    VkInstance instance;
    VkPhysicalDevice physicalDevice = VK_NULL_HANDLE;
    VkDevice device;
    VkSurfaceKHR surface;
    VkQueue computeQueue;
    uint32_t computeQueueFamily;
};