//          MM.                          .MM
//         MM.  .MMMMMMMMMMMMMMMMMMMMMM.  .MM
//        MM.  .MMMMMMMMMMMMMMMMMMMMMMMM.  .MM
//       MM.  .MMMM        MMMMMMM    MMM.  .MM
//      MM.  .MMM           MMMMMM     MMM.  .MM
//     MM.  .MmM              MMMM      MMM.  .MM
//    MM.  .MMM                 MM       MMM.  .MM
//   MM.  .MMM                   M        MMM.  .MM
//  MM.  .MMM                              MMM.  .MM
//   MM.  .MMM                            MMM.  .MM
//    MM.  .MMM       M                  MMM.  .MM
//     MM.  .MMM      MM                MMM.  .MM
//      MM.  .MMM     MMM              MMM.  .MM
//       MM.  .MMM    MMMM            MMM.  .MM
//        MM.  .MMMMMMMMMMMMMMMMMMMMMMMM.  .MM
//         MM.  .MMMMMMMMMMMMMMMMMMMMMM.  .MM
//          MM.                          .MM
//            MMMMMMMMMMMMMMMMMMMMMMMMMMMM
//
//
//
//
// Adaptation pour Natron par F. Fernandez
// Code original : crok_lens_blur Matchbox pour Autodesk Flame

// Adapted to Natron by F.Fernandez
// Original code : crok_lens_blur Matchbox for Autodesk Flame


// setting inputs names and filtering options
// iChannel0: pass4_result , filter = linear , wrap = clamp
// BBox: iChannel0

// Shader adapted from: https://www.shadertoy.com/view/XssGz8

#define PI 3.1415926

float chromatic_abb = 1.0; // Chroma Offset : ,min=0.0, max=100.0

 float amount = 12.0; // Amount : ,min=0.0
 int num_iter = 32; // Iterations : ,min=2, max=1024

vec2 center = vec2(0.5);


vec2 barrelDistortion(vec2 coord, float amt, vec2 fragCoord) {

	vec2 cc = (((fragCoord.xy/iResolution.xy) - center ));
	float distortion = dot(cc * .3, cc);
	return coord + cc * amt * -.05;
}

float sat( float t )
{
	return clamp( t, 0.0, 1.0 );
}

float linterp( float t ) {
	return sat( 1.0 - abs( 2.0*t - 1.0 ) );
}

float remap( float t, float a, float b ) {
	return sat( (t - a) / (b - a) );
}

vec3 spectrum_offset( float t ) {
	vec3 ret;
	float lo = step(t,0.5);
	float hi = 1.0-lo;
	float w = linterp( remap( t, 1.0/6.0, 5.0/6.0 ) );
	ret = vec3(lo,1.0,hi) * vec3(1.0-w, w, 1.0-w);

	return pow( ret, vec3(1.0/2.2) );
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv=(fragCoord.xy/iResolution.xy);
	vec3 sumcol = vec3(0.0);
	vec3 sumw = vec3(0.0);
	for ( int i=0; i<num_iter;++i )
	{
		float t = float(i) * (1.0 / float(num_iter));
		vec3 w = spectrum_offset( t );
		sumw += w;
		sumcol += w * texture2D( iChannel0, barrelDistortion(uv, chromatic_abb * 0.1 * amount * t , fragCoord )).rgb;
	}
    
    fragCoord /= iResolution.xy;
    vec4 Color0 = texture2D(iChannel0, fragCoord);
    vec4 Color1 = texture2D(iChannel1, fragCoord);
    float t = 0.5 - 0.5 * cos(2.0 * PI * iTime / 8.0);
	fragColor = mix(vec4(sumcol.rgb / sumw, 1.0), Color1, t);
}
