varying vec4 worldPosition;
varying vec4 viewPosition;
varying vec4 screenPosition;
varying vec3 vertexNormal;
varying vec3 rotatedNormal;
varying vec4 vertexColor;

uniform vec3 sunDir;
uniform bool doShading;
uniform bool normInvert;


vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec4 texturecolor = Texel(tex, texture_coords);
    //return texturecolor * color;




    vec4 final = texturecolor * color;

    if(doShading) {
        float dotMul = (dot(rotatedNormal, sunDir) + 1.5) * 0.33;
        final *= vec4(dotMul, dotMul, dotMul, 1.0);
    }

    bool face = normInvert ? gl_FrontFacing : !gl_FrontFacing;
    if(face) {
        discard;
    }

    return final;

   
    //return vec4((vertexNormal + vec3(1, 1, 1)) * 0.5, 1.0) * color;

    //float depth = screenPosition.w / 16;
    //return vec4(color.xyz * depth, 1.0);
}