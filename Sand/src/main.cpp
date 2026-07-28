#include "VulkanRenderer.hpp"
#include <iostream>
#include <stdexcept>
#include <cstdlib>

int main() {
    VulkanRenderer app;

    try {
        app.run();
    }
    catch (const std::exception& e) {
        std::cerr << "Fatal Error: " << e.what() << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}