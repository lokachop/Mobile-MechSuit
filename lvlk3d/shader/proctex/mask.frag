uniform vec2 screenRes;

uniform Image texA;
uniform vec2 texASize;

uniform Image mask;
uniform vec2 maskSize;


vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec4 texcolor = Texel(tex, texture_coords);

    vec2 maskSzRela = screenRes / maskSize;
    vec4 maskVal = Texel(mask, texture_coords * maskSzRela);

    vec2 texARela = screenRes / texASize;
    vec4 texAVal = Texel(texA, texture_coords * texARela);


    texcolor.x = mix(texcolor.x, texAVal.x, maskVal.x);
    texcolor.y = mix(texcolor.y, texAVal.y, maskVal.y);
    texcolor.z = mix(texcolor.z, texAVal.z, maskVal.z);
    return texcolor;
}