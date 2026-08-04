#pragma once

#include "GfxBackend.hpp"

#ifdef SAND_BACKEND_VULKAN

#include <vulkan/vulkan.h>

struct GLFWwindow;

// Dear ImGui's Vulkan backend, and the only place in the project that includes imgui_impl_vulkan.h.
//
// The generic half of the interface -- newFrame and shutdown -- is declared in UiBackend.hpp and
// implemented in the same translation unit as these. UIManager calls that half and never sees this
// header; VulkanRenderer calls both.
namespace UiBackendVulkan {

// Everything ImGui_ImplVulkan_Init wants, gathered so the call site is one struct rather than ten
// positional arguments that were previously easy to transpose (queue family and image count are
// both uint32_t and sat next to each other).
struct InitInfo {
    GLFWwindow*      window           = nullptr;
    VkInstance       instance         = VK_NULL_HANDLE;
    VkPhysicalDevice physicalDevice   = VK_NULL_HANDLE;
    VkDevice         device           = VK_NULL_HANDLE;
    VkQueue          graphicsQueue    = VK_NULL_HANDLE;
    uint32_t         queueFamily      = 0;
    VkDescriptorPool descriptorPool   = VK_NULL_HANDLE;
    VkRenderPass     renderPass       = VK_NULL_HANDLE;
    uint32_t         minImageCount    = 2;
    uint32_t         imageCount       = 2;
};

void init(const InitInfo& info);

// Appends the UI's vertex data to a command buffer inside an active render pass.
void render(VkCommandBuffer commandBuffer);

} // namespace UiBackendVulkan

#endif // SAND_BACKEND_VULKAN
