#pragma header

uniform sampler2D maskTexture;

uniform vec4 fs;// frame size
uniform vec2 sc;// mask size
uniform vec4 ts;// xy translate info, zw camera size
uniform float zoom;
uniform vec2 scroll;

vec2 remap(vec2 uv){
    uv-=vec2(.5);
    uv.xy/=vec2(zoom);
    uv+=vec2(.5);
    
    uv+=scroll/ts.zw;
    
    uv.x/=sc.x/ts.z;
    uv.y/=sc.y/ts.w;
    
    uv.x+=(fs.x/sc.x)-(ts.x/sc.x);
    uv.y+=(fs.y/sc.y)-(ts.y/sc.y);
    
    // Comment these to disable drawing past the border
    if(uv.x>(((fs.x+fs.z))/sc.x)||uv.x<fs.x/sc.x)
    uv=vec2(-1.);
    if(uv.y>((fs.y+fs.w))/sc.y||uv.y<fs.y/sc.y)
    uv=vec2(-1.);
    
    return uv;
}

void main()
{
    vec2 uv=openfl_TextureCoordv.xy;
    vec2 fragCoord=uv*openfl_TextureSize.xy;
    
    vec4 col=texture2D(bitmap,uv);
    vec2 remapped=remap(uv);
    vec4 mask=vec4(0.);
    if(remapped.x>-1.){
        mask=texture2D(maskTexture,remapped);
    }
    
    float val=1.;
    if(mask.r>0.&&mask.g+mask.b<2./255.){// can be replaced with == 0.0
        val=1.-mask.r;
        mask.r=0.;// hacky fix
    }
    
    gl_FragColor=mix(vec4(0.),mix(col,mask,val),mask.a);
}