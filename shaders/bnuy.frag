

float rand(float x)
{
    return fract(sin(x) * 43758.5453);
}

float triangle(float x)
{
	return abs(0.0 - mod(abs(x), 2.0)) * .0 - 1.0;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float time = floor(iTime * 16.0) / 16.0;
    
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    
    // pixel position
	vec2 p = uv;	
	p += vec2(triangle(p.y * rand(time) * 4.0) * rand(time * 1.9) * 0.015,
			triangle(p.x * rand(time * 3.4) * 4.0) * rand(time * 2.1) * 0.015);
	p += vec2(rand(p.x * 3.1 + p.y * 8.7) * 0.01,
			  rand(p.x * 1.1 + p.y * 6.7) * 0.01);
    	    
    
    vec4 baseColor = vec4(texture(iChannel0, uv).rgb,1.);
	vec4 edges = 0.2 / (baseColor + vec4(texture(iChannel0,p).rgb, 1.));
    
    baseColor.rgb = vec3(baseColor.rgb);    
    fragColor = baseColor / vec4(length(edges));
}