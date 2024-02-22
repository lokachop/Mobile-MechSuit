uniform vec2 screenSize;

uniform float warp; // simulate curvature of CRT monitor
uniform float scan; // simulate darkness between scanlines

// https://www.shadertoy.com/view/WsVSzV
vec4 crt(vec4 colour, vec2 fragCoord) {
    // squared distance from center
    vec2 uv = (fragCoord / screenSize.xy);
    vec2 dc = abs(0.5-uv);
    dc *= dc;
    
    // warp the fragment coordinates
    uv.x -= 0.5; uv.x *= 1.0+(dc.y*(0.3*warp)); uv.x += 0.5;
    uv.y -= 0.5; uv.y *= 1.0+(dc.x*(0.4*warp)); uv.y += 0.5;

    // sample inside boundaries, otherwise set to black
    if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0) {
        return vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        // determine if we are drawing in a scanline
        float apply = abs(sin(fragCoord.y) * 0.5 * scan);
        // sample the texture
    	return vec4(mix(colour.rgb, vec3(0.0), apply), 1.0);
    }
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
	vec4 texturecolor = Texel(tex, texture_coords);

	return crt(texturecolor * color, screen_coords);
}