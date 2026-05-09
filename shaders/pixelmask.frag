
#define PER_CHANNEL

float T(float z) {
    return z >= 0.5 ? 2.-2.*z : 2.*z;
}

float intensity(ivec2 pixel) {
    const float a1 = 0.75487766624669276;
    const float a2 = 0.569840290998;
    return fract(a1 * float(pixel.x) + a2 * float(pixel.y));
}

float dither(float gray, int ng) {
    float noised = (2./float(ng)) * T(intensity(ivec2(gl_FragCoord.xy))) + gray - (1./float(ng));

    return clamp(floor(float(ng) * noised) / (float(ng)-1.), 0.f, 1.f);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    const int ng = 2; 
    vec2 uv = fragCoord/iResolution.xy;
    
    vec3 tsample = pow(texture(iChannel0, uv).rgb, vec3(2.2));
    
    #ifdef PER_CHANNEL
    	vec3 col = vec3(dither(tsample.r, ng),
			 		    dither(tsample.g, ng),
             			dither(tsample.b, ng));
    #else
        vec3 col = vec3(dither(dot(tsample, vec3(0.3, 0.59, 0.11)), ng));
    #endif

    fragColor = vec4(vec3(pow(col, vec3(1.0/2.2))),1.0);
}