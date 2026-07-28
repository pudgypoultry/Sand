#include "VulkanSwapchain.hpp"
#include <stdexcept>
#include <algorithm>
#include <iostream>

// Constructor: Triggers the creation of the swapchain and its image views
VulkanSwapchain::VulkanSwapchain(VulkanContext* ctx) : context(ctx) {
    createSwapChain();
    createImageViews();
}

// Destructor: Destroys image views and the swapchain in the correct order
VulkanSwapchain::~VulkanSwapchain() {
    for (auto imageView : swapchainImageViews) {
        vkDestroyImageView(context->getDevice(), imageView, nullptr);
    }
    vkDestroySwapchainKHR(context->getDevice(), swapchain, nullptr);
}

// createSwapChain: Allocates the image queue for presentation to the display
void VulkanSwapchain::createSwapChain() {
    VkSurfaceCapabilitiesKHR capabilities;
    vkGetPhysicalDeviceSurfaceCapabilitiesKHR(context->getPhysicalDevice(), context->getSurface(), &capabilities);

    VkExtent2D extent = {
        std::clamp((uint32_t)1600, capabilities.minImageExtent.width, capabilities.maxImageExtent.width),
        std::clamp((uint32_t)1200, capabilities.minImageExtent.height, capabilities.maxImageExtent.height)
    };

    uint32_t imageCount = capabilities.minImageCount + 1;
    if (capabilities.maxImageCount > 0 && imageCount > capabilities.maxImageCount) {
        imageCount = capabilities.maxImageCount;
    }

    VkSwapchainCreateInfoKHR createInfo{};
    createInfo.sType = VK_STRUCTURE_TYPE_SWAPCHAIN_CREATE_INFO_KHR;
    createInfo.surface = context->getSurface();
    createInfo.minImageCount = imageCount;
    createInfo.imageFormat = VK_FORMAT_B8G8R8A8_SRGB;
    createInfo.imageColorSpace = VK_COLOR_SPACE_SRGB_NONLINEAR_KHR;
    createInfo.imageExtent = extent;
    createInfo.imageArrayLayers = 1;
    createInfo.imageUsage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT;
    createInfo.imageSharingMode = VK_SHARING_MODE_EXCLUSIVE;
    createInfo.preTransform = capabilities.currentTransform;
    createInfo.compositeAlpha = VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR;
    createInfo.presentMode = VK_PRESENT_MODE_FIFO_KHR;
    createInfo.clipped = VK_TRUE;

    if (vkCreateSwapchainKHR(context->getDevice(), &createInfo, nullptr, &swapchain) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create swap chain!");
    }

    vkGetSwapchainImagesKHR(context->getDevice(), swapchain, &imageCount, nullptr);
    swapchainImages.resize(imageCount);
    vkGetSwapchainImagesKHR(context->getDevice(), swapchain, &imageCount, swapchainImages.data());

    swapchainImageFormat = VK_FORMAT_B8G8R8A8_SRGB;
    swapchainExtent = extent;
    std::cout << "Swapchain created with " << imageCount << " images!\n";
}

// createImageViews: Defines how Vulkan interprets the raw swapchain image memory
void VulkanSwapchain::createImageViews() {
    swapchainImageViews.resize(swapchainImages.size());

    for (size_t i = 0; i < swapchainImages.size(); i++) {
        VkImageViewCreateInfo createInfo{};
        createInfo.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
        createInfo.image = swapchainImages[i];
        createInfo.viewType = VK_IMAGE_VIEW_TYPE_2D;
        createInfo.format = swapchainImageFormat;
        createInfo.components.r = VK_COMPONENT_SWIZZLE_IDENTITY;
        createInfo.components.g = VK_COMPONENT_SWIZZLE_IDENTITY;
        createInfo.components.b = VK_COMPONENT_SWIZZLE_IDENTITY;
        createInfo.components.a = VK_COMPONENT_SWIZZLE_IDENTITY;
        createInfo.subresourceRange.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
        createInfo.subresourceRange.baseMipLevel = 0;
        createInfo.subresourceRange.levelCount = 1;
        createInfo.subresourceRange.baseArrayLayer = 0;
        createInfo.subresourceRange.layerCount = 1;

        if (vkCreateImageView(context->getDevice(), &createInfo, nullptr, &swapchainImageViews[i]) != VK_SUCCESS) {
            throw std::runtime_error("Failed to create image views!");
        }
    }
}