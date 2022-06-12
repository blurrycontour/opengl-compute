#version 430

// input/output
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;
layout(rgba32f, binding = 0) uniform image2D img_output;

void main() {

    ivec2 pixel_coords = ivec2(gl_GlobalInvocationID.xy);
    ivec2 screen_size = imageSize(img_output);

    vec2 uv = gl_GlobalInvocationID.xy/vec2(screen_size);
    vec3 pixel = vec3(uv,0);

    imageStore(img_output, pixel_coords, vec4(pixel,1.0));
}