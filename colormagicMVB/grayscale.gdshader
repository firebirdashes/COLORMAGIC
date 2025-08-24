shader_type canvas_item;
uniform bool enabled = true;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;


void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);
	if(enabled){
		color.rgb = vec3(dot(color.rgb,vec3(0.299, 0.587, 0.144)));
		
	}
	COLOR = color;
}
