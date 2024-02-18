// https://www.shadertoy.com/view/4ss3W7
uniform vec2 screenRes;
const float depth = 10.0;

float luminance(vec4 c) {
	return c.x;
}

vec3 normal(Image tex, vec2 fragCoord) {
    float px = 1 / screenRes.x;
    float py = 1 / screenRes.y;

	float R = abs(luminance(Texel(tex, vec2( px,0) + fragCoord)));
	float L = abs(luminance(Texel(tex, vec2(-px,0) + fragCoord)));
	float D = abs(luminance(Texel(tex, vec2(0, py) + fragCoord)));
	float U = abs(luminance(Texel(tex, vec2(0,-py) + fragCoord)));
				 
	float X = (L-R) * .5;
	float Y = (U-D) * .5;

	return normalize(vec3(X, Y, 1.0 / depth));
}


vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec3 normal = normal(tex, texture_coords);
    normal += vec3(1, 1, 1);
    normal *= vec3(0.5, 0.5, 0.5);

   	return vec4(normal, 1);
}
