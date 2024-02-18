uniform vec2 screenRes;

uniform Image texA;
uniform vec2 texASize;

uniform vec3 sunDir;
uniform float specMul;
uniform float specConst;



vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec4 texcolor = Texel(tex, texture_coords);

    vec2 texARela = screenRes / texASize;
    vec4 texAVal = Texel(texA, texture_coords * texARela);
    

    vec3 texNormal = normalize((texAVal.xyz - vec3(0.5, 0.5, 0.5)) * 2);



    float dotVal = max(dot(texNormal, sunDir), 0.2);

    //vec2 screenDir = ((screen_coords / screenRes) - vec2(0.5, 0.5));

    vec3 viewDir = normalize(vec3(0, 0, 1));
    vec3 reflectDir = reflect(-sunDir, texNormal); 

    float spec = pow(max(dot(viewDir, reflectDir), 0.0), specConst);


    texcolor.xyz *= dotVal;
    texcolor.xyz += (specMul * spec);

    return texcolor;
}