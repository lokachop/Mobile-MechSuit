// this is a heavily edited version of G3Ds vertex shader, props to them for figuring it all out
// git repo for G3D; https://github.com/groverburger/g3d


uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 mdlRotationMatrix;
uniform mat4 mdlTranslationMatrix;
uniform mat4 mdlScaleMatrix;
uniform bool normInvert;
uniform vec3 lightPos;


// the vertex normal attribute must be defined, as it is custom unlike the other attributes
attribute vec3 VertexNormal;

// define some varying vectors that are useful for writing custom fragment shaders
varying vec4 worldPosition;
varying vec4 viewPosition;
varying vec4 screenPosition;
varying vec3 vertexNormal;
varying vec4 vertexColor;

vec4 position(mat4 transformProjection, vec4 vertexPosition) {
    mat4 mdlMatrix = mdlTranslationMatrix * mdlRotationMatrix * mdlScaleMatrix;




    // calculate the positions of the transformed coordinates on the screen
    // save each step of the process, as these are often useful when writing custom fragment shaders
    worldPosition = mdlMatrix * vertexPosition;

    vertexNormal = VertexNormal;
    vec3 rotatedNormal = vec3(mdlRotationMatrix * vec4(VertexNormal, 1.0));
    //rotatedNormal *= normInvert ? -1 : 1;

    //shadow volume shit
    vec3 worldShadow = vec3(worldPosition) - lightPos;
    float incidentDot = dot(rotatedNormal, worldShadow);


    if(incidentDot < 0) {
        vec3 dir = (worldShadow) * 16;
        worldPosition += vec4(dir, 0);
    }


    viewPosition = viewMatrix * worldPosition;
    screenPosition = projectionMatrix * viewPosition;

    vertexColor = VertexColor;

    // canvas is always on
    screenPosition.y *= -1.0;
    //screenPosition.x *= -1.0;


    return screenPosition;
}