#pragma header

#define iResolution openfl_TextureSize
#define iChannel0 bitmap
#define iChannel1 bitmap
#define texture texture2D

float Threshold = 0.5;
float Intensity = 1.0;
float BlurSize = 2.0;

vec4 BlurColor (in vec2 Coord, in sampler2D Tex, in float MipBias)
{
	vec2 TexelSize = MipBias/vec2(1280.0, 720.0);

    vec4  Color = texture2D(Tex, camToOg(Coord), MipBias);
    Color += texture2D(Tex, camToOg(Coord + vec2(TexelSize.x,0.0)), MipBias);
    Color += texture2D(Tex, camToOg(Coord + vec2(-TexelSize.x,0.0)), MipBias);
    Color += texture2D(Tex, camToOg(Coord + vec2(0.0,TexelSize.y)), MipBias);
    Color += texture2D(Tex, camToOg(Coord + vec2(0.0,-TexelSize.y)), MipBias);
    Color += texture2D(Tex, camToOg(Coord + vec2(TexelSize.x,TexelSize.y)), MipBias);
    Color += texture2D(Tex, camToOg(Coord + vec2(-TexelSize.x,TexelSize.y)), MipBias);
    Color += texture2D(Tex, camToOg(Coord + vec2(TexelSize.x,-TexelSize.y)), MipBias);
    Color += texture2D(Tex, camToOg(Coord + vec2(-TexelSize.x,-TexelSize.y)), MipBias);

    return Color/9.0;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = getCamPos(fragCoord.xy/iResolution.xy);

    vec4 Color = texture2D(iChannel0, camToOg(uv));

    vec4 Highlight = clamp(BlurColor(uv, iChannel0, BlurSize)-Threshold,0.0,1.0)*1.0/(1.0-Threshold);

    fragColor = 1.0-(1.0-Color)*(1.0-Highlight*Intensity);
}
void main(){
    gl_FragColor=flixel_texture2D(bitmap,openfl_TextureCoordv);
    vec2 coord=openfl_TextureCoordv;
    vec2 fragCoord=(coord*openfl_TextureSize);
    mainImage(gl_FragColor,fragCoord);
}