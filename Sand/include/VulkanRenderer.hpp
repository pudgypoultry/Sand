#pragma once

#include "Window.hpp"
#include "VulkanContext.hpp"
#include "VulkanSwapchain.hpp"
#include "VulkanPipeline.hpp"
#include "VulkanBuffer.hpp"
#include "Particle.hpp"
#include "UIManager.hpp"
#include "Config.hpp"
#include <vector>
#include <memory>

class VulkanRenderer {
public:
    VulkanRenderer();
    void run();

private:
    void initVulkan();
    void mainLoop();
    void cleanup();

    void seedParticles();
    void beginPurge();
    void createFramebuffers();
    void createDescriptorSet();
    void createCommandPoolAndBuffer();
    void createSyncObjects();

    void drawFrame();

    std::unique_ptr<Window> window;
    std::unique_ptr<VulkanContext> context;
    std::unique_ptr<VulkanSwapchain> swapchain;
    std::unique_ptr<VulkanPipeline> pipeline;

    std::unique_ptr<VulkanBuffer> ssboBuffer;
    std::unique_ptr<VulkanBuffer> steamCounterBuffer;
    std::unique_ptr<VulkanBuffer> tuningBuffer;

    std::vector<VkFramebuffer> swapchainFramebuffers;

    VkDescriptorPool descriptorPool;
    VkDescriptorSet descriptorSet;
    VkCommandPool commandPool;
    VkCommandBuffer commandBuffer;

    VkDescriptorPool imguiDescriptorPool;

    VkSemaphore imageAvailableSemaphore;
    VkSemaphore renderFinishedSemaphore;
    VkFence inFlightFence;

    UIManager uiManager;

    Config config;
};