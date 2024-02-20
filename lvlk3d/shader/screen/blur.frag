uniform float add;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
	vec4 texturecolor = Texel(tex, texture_coords);

	vec4 final_col = (
		((Texel(tex, texture_coords + vec2(-add, -add)) + Texel(tex, texture_coords) + Texel(tex, texture_coords + vec2(add, -add))) / 3.0) + 
		((Texel(tex, texture_coords + vec2(-add, 0)) + Texel(tex, texture_coords) + Texel(tex, texture_coords + vec2(add, 0))) / 3.0) + 
		((Texel(tex, texture_coords + vec2(-add, add)) + Texel(tex, texture_coords) + Texel(tex, texture_coords + vec2(add, add))) / 3.0)
	) / 3.0;

	return final_col * color;
}