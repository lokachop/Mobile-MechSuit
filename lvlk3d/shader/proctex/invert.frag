uniform vec2 screenRes;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec4 texcolor = Texel(tex, texture_coords);
    texcolor = vec4(1.0 - texcolor.x, 1.0 - texcolor.y, 1.0 - texcolor.z, texcolor.w);

    return texcolor;
}