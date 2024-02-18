uniform vec2 screenRes;

uniform Image texA;
uniform vec2 texASize;
uniform float texDistortMul;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec2 texARela = screenRes / texASize;
    vec4 texAVal = Texel(texA, texture_coords * texARela);

    vec2 texOffset = ((texAVal.xy - vec2(0.5, 0.5)) * 2) * texDistortMul;

    vec4 texcolor = Texel(tex, texture_coords + texOffset);
    return texcolor;
}