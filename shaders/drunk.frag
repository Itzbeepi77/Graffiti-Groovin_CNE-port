void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float seperation = 0.005;
    float sinWave = sin(iTime) * seperation;
    float cosWave = cos(iTime * 0.5) * seperation;
    
    vec2 clockwise = vec2(sinWave, cosWave);
    vec2 anticlockwise = vec2(-sinWave, cosWave);
    float speed = 1.0;
    
    vec2 offsetRed = clockwise;
    vec2 offsetGreen = anticlockwise;
    vec2 offsetBlue = vec2(1,1) * cosWave;
    
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    vec4 red = texture2D(iChannel0, uv-offsetRed);
    vec4 green = texture2D(iChannel0, uv-offsetGreen);
    vec4 blue = texture2D(iChannel0, uv-offsetBlue);
    
    fragColor = vec4(red.r, green.g, blue.b, 1.0);
}