shader_type canvas_item;


uniform sampler2D color_texture: filter_nearest;
uniform sampler2D color_depth: filter_nearest;
uniform sampler2D main_depth: filter_nearest;

uniform bool debug_draw;

void fragment() {
	vec4 output;
	
	vec4 colortexture = texture(color_texture, SCREEN_UV); //texture of the color pass
	float maindepth = texture(main_depth, SCREEN_UV).x; //depth of the main pass
	float colordepth = texture(color_depth, SCREEN_UV).x; //depth of the color pass
	
	output = colortexture;
	
	if (maindepth <= colordepth){
		output.a = 0.0;
	}
	
	
	//debug rendering code to draw all passes
	if(debug_draw){
		colortexture = texture(color_texture, SCREEN_UV*vec2(2.0)); //texture of the color pass at half scale
		maindepth = texture(main_depth, SCREEN_UV*vec2(2.0)-vec2(0.0, 1.0)).x; //depth of the main pass at half scale
		colordepth = texture(color_depth, SCREEN_UV*vec2(2.0)-vec2(1.0, 1.0)).x; //depth of the color pass at half scale
		output.a = 1.0;
		
		if(SCREEN_UV.x < 0.5 && SCREEN_UV.y > 0.5){ //bottom left
			output.rgb = vec3(maindepth);
		} else if(SCREEN_UV.x > 0.5 && SCREEN_UV.y > 0.5){ //bottom right
			output.rgb = vec3(colordepth); 
		} else if(SCREEN_UV.x <0.5 && SCREEN_UV.y <0.5) { //top left
			output.rgb = colortexture.rgb;
		} else { //top right
		maindepth = texture(main_depth, SCREEN_UV*vec2(2.0)-vec2(1.0, 0.0)).x; //depth of the main pass at half scale
		colordepth = texture(color_depth, SCREEN_UV*vec2(2.0)-vec2(1.0, 0.0)).x; //depth of the color pass at half scale
			if (maindepth <= colordepth){
				output.rgb = vec3(0.0);
			} else {
				output.rgb = vec3(1.0);
			}
		}
	}
	
	
	
	
	
	
	
	COLOR.rgba = output;
}