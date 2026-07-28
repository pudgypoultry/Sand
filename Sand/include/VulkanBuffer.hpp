#pragma once

#include "VulkanContext.hpp"
#include <vector>

class VulkanBuffer {
public:
    // Constructor: Allocates a Vulkan buffer and its associated device memory
    VulkanBuffer(VulkanContext* context, VkDeviceSize size, VkBufferUsageFlags usage, VkMemoryPropertyFlags properties);

    // Destructor: Frees the device memory and destroys the buffer handle
    ~VulkanBuffer();

    // Prevent copying to avoid double-freeing Vulkan resources
    VulkanBuffer(const VulkanBuffer&) = delete;
    VulkanBuffer& operator=(const VulkanBuffer&) = delete;

    // Accessor: Returns the raw Vulkan buffer handle for binding
    VkBuffer getBuffer() const { return buffer; }

    // Maps the GPU memory to CPU-accessible space and returns the pointer
    void* mapMemory();

    // Unmaps the previously mapped GPU memory
    void unmapMemory();

private:
    VulkanContext* context;
    VkBuffer buffer;
    VkDeviceMemory bufferMemory;
    VkDeviceSize bufferSize;

    // Locates the correct memory pool on the physical GPU matching requested properties
    uint32_t findMemoryType(uint32_t typeFilter, VkMemoryPropertyFlags properties);
};