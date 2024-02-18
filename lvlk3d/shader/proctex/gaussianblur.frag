uniform vec2 screenRes;
uniform float dirs;
uniform float quality;
uniform float size;

// https://www.shadertoy.com/view/Xltfzj
vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    float Pi = 6.28318530718; // Pi*2
    
    // GAUSSIAN BLUR SETTINGS {{{
    float Directions = dirs; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
    float Quality = quality; // BLUR QUALITY (Default 4.0 - More is better but slower)
    float Size = size; // BLUR SIZE (Radius)
    // GAUSSIAN BLUR SETTINGS }}}
   
    vec2 Radius = Size / screenRes.xy;
    
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = texture_coords;
    // Pixel colour
    vec4 texcolor = Texel(tex, texture_coords);
    
    // Blur calculations
    for( float d=0.0; d<Pi; d+=Pi/Directions)
    {
		for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
        {
			texcolor += Texel(tex, uv+vec2(cos(d),sin(d))*Radius*i);		
        }
    }
    
    // Output to screen
    texcolor /= Quality * Directions - 15.0;

    return texcolor;
}