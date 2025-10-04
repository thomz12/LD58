shader_type canvas_item;

uniform bool black_out = false;

void fragment() {
	if (black_out) {
		vec4 input_color = texture(TEXTURE, UV);
		COLOR = vec4(0.0, 0.0, 0.0, input_color.a);
	}
}