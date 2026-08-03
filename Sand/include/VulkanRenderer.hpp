#pragma once

#include "Window.hpp"
#include "VulkanContext.hpp"
#include "VulkanSwapchain.hpp"
#include "VulkanPipeline.hpp"
#include "VulkanBuffer.hpp"
#include "Particle.hpp"
#include "UIManager.hpp"
#include "UiBackendVulkan.hpp"
#include "Config.hpp"
#include <vector>
#include <memory>
#include <chrono>

class VulkanRenderer {
public:
    VulkanRenderer();
    void run();

private:
    void initVulkan();
    void mainLoop();
    void frame();
    void cleanup();

    void seedParticles();
    void beginPurge();
    size_t voxelCount() const;
    void createFramebuffers();
    void createDescriptorSet();
    void createWorldBuffers();
    void writeDescriptorSet();
    void applyOptions(const TuningParams& requested);
    void uploadTuning();
    void createCommandPoolAndBuffer();
    void createSyncObjects();
    void createTimestampPool();
    void readGpuTimestamps();

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

    // --- Frame breakdown timing -------------------------------------------------------------------
    // Three timestamps bracket the two GPU phases: start of the command buffer, end of the compute
    // dispatch loop, end of the raymarch draw. The UI's ImGui commands are recorded after the last
    // one, deliberately, so drawing the profiler does not show up as raymarch cost.
    static constexpr uint32_t kTimestampCount = 3;
    VkQueryPool timestampPool = VK_NULL_HANDLE;
    bool timestampsSupported = false;  // false if the queue family cannot write timestamps at all
    bool timestampsPending = false;    // a frame's queries are in flight and not yet read back
    float timestampPeriodNs = 1.0f;    // nanoseconds per tick, from VkPhysicalDeviceLimits

    // Wall time drawFrame spent parked on the GPU or the presenter rather than doing CPU work.
    // Subtracted from the frame's wall time so the CPU figure means "work" and not "waiting" --
    // without this, vsync would make the CPU line track the refresh rate and measure nothing.
    double gpuBlockedMs = 0.0;
    float lastComputeMs = 0.0f;
    float lastRaymarchMs = 0.0f;

    UIManager uiManager;

    Config config;
    // Where config.txt was actually found, so the options screen writes back to the same file.
    std::string configPath;
};