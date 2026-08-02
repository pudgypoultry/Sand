#pragma once

#include "VulkanContext.hpp"
#include "VulkanSwapchain.hpp"
#include <vector>
#include <string>

// Push constant layout shared across compute and fragment shaders
struct PushConstants {
    float time;
    float pitch;
    float yaw;
    float camX;
    float camY;
    float camZ;
    int spawnX;
    int spawnY;
    int spawnZ;
    int spawnActive;
    int spawnType;
    int spawnSize;
    float fovDistance;
    float perspectiveBlend;
    int spawnShape; // 0 = cube, 1 = sphere
};

class VulkanPipeline {
public:
    // Constructor: Orchestrates the creation of layouts, render passes, and both pipelines
    VulkanPipeline(VulkanContext* context, VulkanSwapchain* swapchain);

    // Destructor: Safely destroys all pipeline-related Vulkan handles
    ~VulkanPipeline();

    // Prevent copying to avoid double-freeing Vulkan resources
    VulkanPipeline(const VulkanPipeline&) = delete;
    VulkanPipeline& operator=(const VulkanPipeline&) = delete;

    // Accessors for rendering configurations and compiled pipelines
    VkRenderPass getRenderPass() const { return renderPass; }
    VkDescriptorSetLayout getDescriptorSetLayout() const { return descriptorSetLayout; }
    VkPipelineLayout getComputePipelineLayout() const { return computePipelineLayout; }
    VkPipeline getComputePipeline() const { return computePipeline; }
    VkPipelineLayout getGraphicsPipelineLayout() const { return graphicsPipelineLayout; }
    VkPipeline getGraphicsPipeline() const { return graphicsPipeline; }

private:
    VulkanContext* context;
    VulkanSwapchain* swapchain;

    VkRenderPass renderPass;
    VkDescriptorSetLayout descriptorSetLayout;
    VkPipelineLayout computePipelineLayout;
    VkPipeline computePipeline;
    VkPipelineLayout graphicsPipelineLayout;
    VkPipeline graphicsPipeline;

    // Configures clear colors and memory storage for the frame buffers
    void createRenderPass();
    // Bakes the falling sand physics shader logic
    void createComputePipeline();
    // Bakes the raymarching rendering logic
    void createGraphicsPipeline();

    // Helper to load SPIR-V binaries from disk
    static std::vector<char> readFile(const std::string& filename);
    // Wraps raw SPIR-V bytecode into a Vulkan object
    VkShaderModule createShaderModule(const std::vector<char>& code);
};