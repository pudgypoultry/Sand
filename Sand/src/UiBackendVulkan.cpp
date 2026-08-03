// UiBackendVulkan.cpp -- Dear ImGui's Vulkan + GLFW backends.

#include "GfxBackend.hpp"

#ifdef SAND_BACKEND_VULKAN

#include "UiBackendVulkan.hpp"
#include "UiBackend.hpp"

#include <imgui.h>
#include <imgui_impl_glfw.h>
#include <imgui_impl_vulkan.h>

#include <stdexcept>
#include <string>

namespace {

void checkVulkanResult(VkResult err) {
    if (err == VK_SUCCESS) return;
    throw std::runtime_error("ImGui Vulkan Error: VkResult = " + std::to_string(err));
}

} // namespace

namespace UiBackendVulkan {

void init(const InitInfo& info) {
    // true = let the backend install its own GLFW callbacks and chain to any already there. Window
    // installs none, so there is nothing to chain, but the flag is also what feeds ImGui the
    // scroll and character events it cannot poll for.
    ImGui_ImplGlfw_InitForVulkan(info.window, true);

    ImGui_ImplVulkan_InitInfo init_info = {};
    init_info.Instance       = info.instance;
    init_info.PhysicalDevice = info.physicalDevice;
    init_info.Device         = info.device;
    init_info.QueueFamily    = info.queueFamily;
    init_info.Queue          = info.graphicsQueue;
    init_info.PipelineCache  = VK_NULL_HANDLE;
    init_info.DescriptorPool = info.descriptorPool;

    init_info.PipelineInfoMain.RenderPass = info.renderPass;
    init_info.PipelineInfoMain.Subpass    = 0;

    init_info.MinImageCount  = info.minImageCount;
    init_info.ImageCount     = info.imageCount;
    init_info.Allocator      = nullptr;
    init_info.CheckVkResultFn = checkVulkanResult;

    ImGui_ImplVulkan_Init(&init_info);
}

void render(VkCommandBuffer commandBuffer) {
    ImDrawData* drawData = ImGui::GetDrawData();
    if (drawData) {
        ImGui_ImplVulkan_RenderDrawData(drawData, commandBuffer);
    }
}

} // namespace UiBackendVulkan

namespace UiBackend {

void newFrame() {
    ImGui_ImplVulkan_NewFrame();
    ImGui_ImplGlfw_NewFrame();
}

void shutdown() {
    ImGui_ImplVulkan_Shutdown();
    ImGui_ImplGlfw_Shutdown();
}

} // namespace UiBackend

#endif // SAND_BACKEND_VULKAN
