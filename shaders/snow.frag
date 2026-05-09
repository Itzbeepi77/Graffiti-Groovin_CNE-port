// SnowScreen (superposition of blobs in displaced-grid voronoi-cells) by Jakob Thomsen
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

#define pi 3.1415926

float T;

// iq's hash function from https://www.shadertoy.com/view/MslGD8
vec2 hash( vec2 p ) { p=vec2(dot(p,vec2(127.1,311.7)),dot(p,vec2(269.5,183.3))); return fract(sin(p)*18.5453); }

float simplegridnoise(vec2 v)
{
    float s = 1. / 256.;
    vec2 fl = floor(v), fr = fract(v);
    float mindist = 1e9;
    for(int y = -1; y <= 1; y++)
        for(int x = -1; x <= 1; x++)
        {
            vec2 offset = vec2(x, y);
            vec2 pos = .5 + .5 * cos(2. * pi * (T*.1 + hash(fl+offset)) + vec2(0,1.6));
            mindist = min(mindist, length(pos+offset -fr));
        }
    
    return mindist;
}

float blobnoise(vec2 v, float s)
{
    return pow(.5 + .5 * cos(pi * clamp(simplegridnoise(v)*2., 0., 1.)), s);
}

float fractalblobnoise(vec2 v, float s)
{
    float val = 0.;
    const float n = 0.5;
    for(float i = 0.; i < n; i++)
        //val += 1.0 / (i + 1.0) * blobnoise((i + 1.0) * v + vec2(0.0, iTime * 1.0), s);
    	val += pow(0.2, i+1.) * blobnoise(exp2(i) * v + vec2(0, T), s);

    return val;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	T = iTime;

    vec2 r = vec2(1.0, (1.0 - iResolution.y) / iResolution.x);
	  vec2 uv = fragCoord.xy / iResolution.xy;
    float val = fractalblobnoise(r * uv * 30.0, 8.0);
    fragColor = mix(texture2D(iChannel0, uv), vec4(1.0), vec4(val));
}
