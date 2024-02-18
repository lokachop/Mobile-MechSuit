uniform vec2 screenRes;
uniform float minVal;
uniform float maxVal;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec4 texcolor = Texel(tex, texture_coords);
    texcolor.x = max(min(texcolor.x, maxVal), minVal);
    texcolor.y = max(min(texcolor.y, maxVal), minVal);
    texcolor.z = max(min(texcolor.z, maxVal), minVal);
    
    return texcolor;
}