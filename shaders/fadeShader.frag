void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    float speed = 1.0;
    
    vec3 n1 = texture2D(iChannel0, uv).xyz;
    vec3 n2 = texture2D(iChannel1, uv).xyz;    
    
    vec3 color = mix(n1, n2, sin(iTime * speed) * 0.5 + 0.5);
    fragColor = vec4(color,1);
}