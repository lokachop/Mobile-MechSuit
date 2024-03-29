varying vec4 worldPosition;
varying vec4 viewPosition;
varying vec4 screenPosition;
varying vec3 vertexNormal;
varying vec3 rotatedNormal;
varying vec4 vertexColor;

uniform bool normInvert;
uniform vec3 ambientCol;


vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    bool face = normInvert ? gl_FrontFacing : !gl_FrontFacing;
    if(face) {
        discard;
    }

    vec4 texturecolor = Texel(tex, texture_coords);

    vec4 final = texturecolor * color;
    if (final.a == 0.0) {
        discard;
    }


    return final * vec4(ambientCol, 1.0);

   
    //return vec4((vertexNormal + vec3(1, 1, 1)) * 0.5, 1.0) * color;

    //float depth = screenPosition.w / 16;
    //return vec4(color.xyz * depth, 1.0);
}