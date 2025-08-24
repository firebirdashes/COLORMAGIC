shader_type spatial;
// Prevent the quad from being affected by lighting and fog. This also improves performance.
render_mode unshaded, fog_disabled;

uniform sampler2D depth_texture : hint_depth_texture;
uniform float near_plane = 0.05; // set to your camera near plane
uniform float far_plane = 4000.0; // set to your camera far plane
uniform bool use_quadratic = false; // optional: quadratic scaling for better depth perception

void vertex() {
    POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
    float depth = texture(depth_texture, SCREEN_UV).x;
    vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, depth);
    vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
    view.xyz /= view.w;
    float linear_depth = -view.z;

    // Normalize to 0..1 based on near/far planes
    float depth_normalized = (linear_depth - near_plane) / (far_plane - near_plane);
    depth_normalized = clamp(depth_normalized, 0.0, 1.0);

    // Optional: apply quadratic scaling for better depth perception
    if (use_quadratic) {
        depth_normalized = depth_normalized * depth_normalized;
    }

    ALBEDO.rgb = vec3(depth_normalized);
}
