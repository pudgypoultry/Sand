#version 430

// Output the UV coordinates to the fragment shader
layout(location = 0) out vec2 outUV;

// Hardcode 6 vertices to create a full-screen quad (two triangles)
vec2 positions[6] = vec2[](
    vec2(-1.0, -1.0), vec2(1.0, -1.0), vec2(-1.0, 1.0),
    vec2(1.0, -1.0), vec2(1.0, 1.0), vec2(-1.0, 1.0)
);

// Map the texture coordinates (0.0 to 1.0) for those vertices
vec2 uvs[6] = vec2[](
    vec2(0.0, 0.0), vec2(1.0, 0.0), vec2(0.0, 1.0),
    vec2(1.0, 0.0), vec2(1.0, 1.0), vec2(0.0, 1.0)
);

void main() {
    // gl_VertexIndex is a built-in Vulkan variable that counts from 0 to 5
    gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
    outUV = uvs[gl_VertexIndex];
}