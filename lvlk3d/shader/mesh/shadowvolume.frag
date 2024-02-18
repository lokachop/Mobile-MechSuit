varying vec4 worldPosition;
varying vec4 viewPosition;
varying vec4 screenPosition;
varying vec3 vertexNormal;
varying vec4 vertexColor;

uniform bool doShading;
uniform bool normInvert;


vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    bool face = normInvert ? gl_FrontFacing : !gl_FrontFacing;
    if(face) {
        discard;
    }
    return color;

}