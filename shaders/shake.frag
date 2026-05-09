vec2 random2(float seed)
{
    float rand1 = fract(sin(seed) * 43758.5453123);
    float rand2 = fract(cos(seed) * 23421.631235);
    
    return vec2(rand1, rand2) * 2.0 - 1.0;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ){
  float time = iTime * 3.0 + sin(iTime * 15.0) * 0.25;
    vec2 pos_rnd_1 = random2(floor(time));
         pos_rnd_1 = pow(pos_rnd_1, vec2(3.0));
    vec2 pos_rnd_2 = random2(floor(time) + 1.0);
         pos_rnd_2 = pow(pos_rnd_2, vec2(3.0));
    vec2 pos_rnd = mix(pos_rnd_1, pos_rnd_2, fract(time));



    vec2 uv = fragCoord/iResolution.xy;
    uv = (uv - 0.5) * 0.96 + 0.5;
    
    vec2 uv1 = uv + pos_rnd * 0.01;
    vec2 uv2 = uv + pos_rnd * 0.02;
    vec2 uv3 = uv + pos_rnd * 0.04;

    float r = texture(iChannel0, uv1).r;
    float g = texture(iChannel0, uv2).g;
    float b = texture(iChannel0, uv3).b;

    vec3 col = vec3(r,g,b);

    fragColor = vec4(col ,1.0);
  
}