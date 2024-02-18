uniform vec2 screenRes;
uniform vec3 colourMul;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec4 texcolor = Texel(tex, texture_coords);

    return texcolor * vec4(colourMul, 1.0);
}