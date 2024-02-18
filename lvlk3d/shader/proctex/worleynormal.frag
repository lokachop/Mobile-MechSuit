// https://thebookofshaders.com/12/

uniform vec2 screenRes;
uniform float minDist;
uniform vec2 scale;

vec2 random2( vec2 p ) {
    return fract(sin(vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))))*43758.5453);
}


vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec4 texcolor = Texel(tex, texture_coords);
    //texcolor = vec4(1.0 - texcolor.x, 1.0 - texcolor.y, 1.0 - texcolor.z, texcolor.w);

    vec2 st = screen_coords.xy/screenRes.xy;
    st.x *= screenRes.x/screenRes.y;

    vec3 colorWorley = vec3(.0);

    // Scale
    st *= scale;

    // Tile the space
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);


    float finalDist = minDist;
    vec3 finalNormal = vec3(0, 0, 1);
    for (int y= -1; y <= 1; y++) {
        for (int x= -1; x <= 1; x++) {
            // Neighbor place in the grid
            vec2 neighbor = vec2(float(x),float(y));

            // Random position from current + neighbor place in the grid
            vec2 point = random2(i_st + neighbor);

			// Animate the point
            //point = 0.5 + 0.5*sin(u_time + 6.2831*point);

			// Vector between the pixel and the point
            vec2 diff = neighbor + point - f_st;

            // Distance to the point
            float dist = length(diff);

            // Keep the closer distance
            if(dist < finalDist) {
                finalDist = min(finalDist, dist);

                vec2 calc1 = (diff);
                finalNormal = normalize(vec3(calc1.x, calc1.y, 1 - dist));
            }
        }
    }
    
    finalNormal += vec3(1, 1, 1);
    finalNormal *= vec3(0.5, 0.5, 0.5);
    // Draw the min distance (distance field)
    //colorWorley += finalDist;

    // Draw cell center
    //colorWorley += 1.-step(.02, m_dist);

    // Draw grid
    //colorWorley.r += step(.98, f_st.x) + step(.98, f_st.y);

    // Show isolines
    // color -= step(.7,abs(sin(27.0*m_dist)))*.5;

    return vec4(finalNormal, 1.0);
}