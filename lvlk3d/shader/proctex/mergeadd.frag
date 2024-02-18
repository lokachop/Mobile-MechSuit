uniform vec2 screenRes;

uniform Image texA;
uniform vec2 texASize;


vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec4 texcolor = Texel(tex, texture_coords);

    vec2 texARela = screenRes / texASize;
    vec4 texAVal = Texel(texA, texture_coords * texARela);

    texcolor.x = (texcolor.x + texAVal.x);
    texcolor.y = (texcolor.y + texAVal.y);
    texcolor.z = (texcolor.z + texAVal.z);

    return min(texcolor, 1);
}