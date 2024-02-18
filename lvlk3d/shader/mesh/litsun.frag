varying vec4 worldPosition;
varying vec4 viewPosition;
varying vec4 screenPosition;
varying vec3 vertexNormal;
varying vec3 rotatedNormal;
varying vec4 vertexColor;

uniform vec3 sunDir;
uniform bool doShading;
uniform bool normInvert;

uniform vec3 lightDir;
uniform vec3 lightColour;


vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    bool face = normInvert ? gl_FrontFacing : !gl_FrontFacing;
    if(face) {
        discard;
    }
    
    vec4 texturecolor = Texel(tex, texture_coords);
    vec4 final = texturecolor * color;

    vec3 fragPos = vec3(worldPosition);

    vec3 diffuse = lightColour;
    if(doShading) {
        float diff = max(dot(rotatedNormal, lightDir), 0.0);
        diffuse *= diff;
    }

    return final * vec4(diffuse, 1);
}