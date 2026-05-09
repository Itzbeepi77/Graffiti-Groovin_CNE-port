

#define DISPLACE .01

float length2(vec2 p) { return dot(p, p); }

float noise(vec2 p){
	return fract(sin(fract(sin(p.x) * (4313.13311)) + p.y) * 3131.0011);
}

float worley(vec2 p) {
	float d = 1e30;
	for (int xo = -1; xo <= 1; ++xo)
	for (int yo = -1; yo <= 1; ++yo) {
		vec2 tp = floor(p) + vec2(xo, yo);
		d = min(d, length2(p - tp - vec2(noise(tp))));
	}
	return 3.*exp(-4.*abs(2.*d - 1.));
}

float fworley(vec2 p) {
	return sqrt(sqrt(sqrt(
		pow(worley(p + iTime), 2.) *
		worley(p*2. + 1.3 + iTime*.5) *
		worley(p*4. + 2.3 + iTime*.25) *
		worley(p*8. + 3.3 + iTime*.125) *
		worley(p*32. + 4.3 + iTime*.125) *
		sqrt(worley(p * 64. + 5.3 + iTime * .0625)) *
		sqrt(sqrt(worley(p * 128. + 7.3))))));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 uv = fragCoord.xy / iResolution.xy;
	float t = fworley(uv * iResolution.xy / 600.);
	t *= exp(-length2(abs(2.*uv - 1.)));
	float r = length(abs(2.*uv - 1.) * iResolution.xy);
    vec2 of1 = vec2(DISPLACE*t);
    vec2 of2 = vec2(DISPLACE)/iResolution.xy;
    uv += of1-of2;
    uv.y -=DISPLACE*.12;
	vec4 back = texture(iChannel0, uv);
    fragColor = back;
}