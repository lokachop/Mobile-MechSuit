// this is a heavily edited version of G3Ds vertex shader, props to them for figuring it all out
// git repo for G3D; https://github.com/groverburger/g3d


uniform mat4 projectionMatrix;
uniform mat4 viewMatrix;
uniform mat4 mdlRotationMatrix;
uniform mat4 mdlTranslationMatrix;
uniform mat4 mdlScaleMatrix;

// the vertex normal attribute must be defined, as it is custom unlike the other attributes
attribute vec3 VertexNormal;

// define some varying vectors that are useful for writing custom fragment shaders
varying vec4 worldPosition;
varying vec4 viewPosition;
varying vec4 screenPosition;
varying vec3 vertexNormal;
varying vec3 rotatedNormal;
varying vec4 vertexColor;

uniform float aspect;


vec4 position(mat4 transformProjection, vec4 vertexPosition) {
    mat4 mdlMatrix = mdlTranslationMatrix * mdlScaleMatrix;
    mat4 modelViewMatrix = viewMatrix * mdlMatrix;


    vec2 scale = vec2(
        length(modelViewMatrix[0]) / aspect,
        length(modelViewMatrix[1])
    );
    
    vec4 billboard = (modelViewMatrix * vec4(vec3(0.0), 1.0));
    vec4 newPosition = projectionMatrix
        * billboard
        + vec4(scale * vertexPosition.xy, 0.0, 0.0);

    screenPosition = newPosition;



    // canvas is always on
    screenPosition.y *= -1.0;
    //screenPosition.x *= -1.0;


    return screenPosition;
}