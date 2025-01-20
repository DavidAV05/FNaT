shader_type canvas_item;

// Uniforms for customization
uniform vec4 darkest_color : source_color = vec4(1, 1, 1, 1);
uniform vec4 dark_color : source_color = vec4(1, 1, 1, 1);
uniform vec2 center = vec2(0.5, 0.5);
uniform float bright_radius : hint_range(0.0, 1.0, 0.05) = 0.05;
uniform float dim_radius : hint_range(0.0, 1.0, 0.05) = 0.0;
uniform float flicker_speed : hint_range(0.0, 2.0, 0.1) = 0.8;

float sin_interpolate(float max_value, float min_value, float speed) {
	float equilibrium = (max_value + min_value) / 2.0;
	float amplitude = abs(max_value - min_value) / 2.0;
	float flicker_radius = amplitude * sin(TIME * flicker_speed) + equilibrium;

	return flicker_radius;
}


void fragment() {
    // Get the current fragment's UV coordinates
	vec4 pixel_color = texture(TEXTURE, UV);
    vec2 uv = UV;

	vec2 aspect_ratio = vec2(1.0, 1.0);
	if (TEXTURE_PIXEL_SIZE.x > TEXTURE_PIXEL_SIZE.y) {
		aspect_ratio.x = TEXTURE_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.x;
	} else if (TEXTURE_PIXEL_SIZE.y > TEXTURE_PIXEL_SIZE.x) {
		aspect_ratio.y = TEXTURE_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.y;
	}

    // Calculate the distance from the center to the current fragment
    float dist = distance(uv * aspect_ratio, center * aspect_ratio);

	float flicker_radius = sin_interpolate(bright_radius, dim_radius, flicker_speed);
	// mask for the flashlight circle
	vec4 mask = vec4(vec3(smoothstep(bright_radius+0.1, flicker_radius, dist)), 1.0);

	vec4 bright_circle = mask * pixel_color;
	vec4 dark_surrounding = (vec4(1.0) - mask) * darkest_color;

	//if (dark_surrounding != darkest_color) {
		//dark_surrounding = darkest_color;
	//}

	COLOR = bright_circle + dark_surrounding;

}
