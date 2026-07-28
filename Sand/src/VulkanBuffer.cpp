#include "VulkanBuffer.hpp"
#include <stdexcept>
#include <iostream>

// Constructor: Allocates a Vulkan buffer and its associated device memory
VulkanBuffer::VulkanBuffer(VulkanContext* ctx, VkDeviceSize size, VkBufferUsageFlags usage, VkMemoryPropertyFlags properties)
    : context(ctx), bufferSize(size) {

    VkBufferCreateInfo bufferInfo{};
    bufferInfo.sType = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
    bufferInfo.size = size;
    bufferInfo.usage = usage;
    bufferInfo.sharingMode = VK_SHARING_MODE_EXCLUSIVE;

    if (vkCreateBuffer(context->getDevice(), &bufferInfo, nullptr, &buffer) != VK_SUCCESS) {
        throw std::runtime_error("Failed to create buffer!");
    }

    VkMemoryRequirements memRequirements;
    vkGetBufferMemoryRequirements(context->getDevice(), buffer, &memRequirements);

    VkMemoryAllocateInfo allocInfo{};
    allocInfo.sType = VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
    allocInfo.allocationSize = memRequirements.size;
    allocInfo.memoryTypeIndex = findMemoryType(memRequirements.memoryTypeBits, properties);

    if (vkAllocateMemory(context->getDevice(), &allocInfo, nullptr, &bufferMemory) != VK_SUCCESS) {
        throw std::runtime_error("Failed to allocate buffer memory!");
    }

    vkBindBufferMemory(context->getDevice(), buffer, bufferMemory, 0);
    std::cout << "Allocated " << size / 1024 / 1024 << " MB of VRAM for Buffer!\n";
}

// Destructor: Frees the device memory and destroys the buffer handle
VulkanBuffer::~VulkanBuffer() {
    vkDestroyBuffer(context->getDevice(), buffer, nullptr);
    vkFreeMemory(context->getDevice(), bufferMemory, nullptr);
}

// findMemoryType: Locates the correct memory pool on the physical GPU matching requested properties
uint32_t VulkanBuffer::findMemoryType(uint32_t typeFilter, VkMemoryPropertyFlags properties) {
    VkPhysicalDeviceMemoryProperties memProperties;
    vkGetPhysicalDeviceMemoryProperties(context->getPhysicalDevice(), &memProperties);

    for (uint32_t i = 0; i < memProperties.memoryTypeCount; i++) {
        if ((typeFilter & (1 << i)) && (memProperties.memoryTypes[i].propertyFlags & properties) == properties) {
            return i;
        }
    }
    throw std::runtime_error("Failed to find suitable memory type!");
}

// mapMemory: Maps the GPU memory to CPU-accessible space and returns the pointer
void* VulkanBuffer::mapMemory() {
    void* data;
    vkMapMemory(context->getDevice(), bufferMemory, 0, bufferSize, 0, &data);
    return data;
}

// unmapMemory: Unmaps the previously mapped GPU memory
void VulkanBuffer::unmapMemory() {
    vkUnmapMemory(context->getDevice(), bufferMemory);
}