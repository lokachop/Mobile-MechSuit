uniform vec2 screenRes;
uniform float target;
uniform float maxDist;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec4 texcolor = Texel(tex, texture_coords);
    
    //float maxInv = 1 - maxDist;
    
    //float distX = abs(target - texcolor.x);
    //float distNorm = distX / maxDist;
    //texcolor.x = min(distNorm, maxDist) / maxDist;
    //texcolor.yz = texcolor.xx;

    texcolor.x = min(abs(texcolor.x - target) / maxDist, maxDist) / maxDist;
    texcolor.y = min(abs(texcolor.y - target) / maxDist, maxDist) / maxDist;
    texcolor.z = min(abs(texcolor.z - target) / maxDist, maxDist) / maxDist;


    //texcolor.x = max(min(abs(texcolor.x - target) / maxDist, target + maxDist), maxDist) / target;
    //texcolor.y = max(min(abs(texcolor.y - target) / maxDist, target + maxDist), maxDist) / target;
    //texcolor.z = max(min(abs(texcolor.z - target) / maxDist, target + maxDist), maxDist) / target;
    
    return texcolor;
}