#pragma once

#include "VulkanContext.hpp"
#include <vector>

class VulkanSwapchain {
public:
    // Constructor: Initializes the swapchain and its associated image views
    VulkanSwapchain(VulkanContext* context);

    // Destructor: Cleans up the image views and the swapchain object
    ~VulkanSwapchain();

    // Prevent copying to avoid double-freeing Vulkan resources
    VulkanSwapchain(const VulkanSwapchain&) = delete;
    VulkanSwapchain& operator=(const VulkanSwapchain&) = delete;

    // Accessor: Returns the Vulkan swapchain handle
    VkSwapchainKHR getSwapchain() const { return swapchain; }

    // Accessor: Returns the color format of the swapchain images
    VkFormat getImageFormat() const { return swapchainImageFormat; }

    // Accessor: Returns the resolution (width and height) of the swapchain images
    VkExtent2D getExtent() const { return swapchainExtent; }

    // Accessor: Returns the list of image views for rendering
    const std::vector<VkImageView>& getImageViews() const { return swapchainImageViews; }

private:
    // Allocates the image queue for presentation to the display
    void createSwapChain();

    // Defines how Vulkan interprets the raw swapchain image memory
    void createImageViews();

    VulkanContext* context;
    VkSwapchainKHR swapchain;
    std::vector<VkImage> swapchainImages;
    VkFormat swapchainImageFormat;
    VkExtent2D swapchainExtent;
    std::vector<VkImageView> swapchainImageViews;
};