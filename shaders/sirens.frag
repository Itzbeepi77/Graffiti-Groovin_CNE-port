void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 resolution = vec2(1280, 720);
    float time = iTime * 5.0;
    float redSiren = 2.5 * sin(time);
    float blueSiren = 2.5 * cos(time);

    redSiren *= smoothstep(0.0, 1.0, sin(time));
    blueSiren *= smoothstep(0.0, 1.0, sin(time + 1.0));

    float sirenIntensity = 0.05;

    sirenIntensity *= smoothstep(0.0, 0.05, abs(fragCoord.x - 1.5));
    vec3 sirenColor = vec3(redSiren, 0.0, blueSiren) * sirenIntensity;

    vec2 uv = fragCoord / iResolution.xy;
    vec3 textureColor = texture2D(iChannel0, uv).xyz;

    fragColor = vec4(sirenColor + 0.9 * textureColor, 1.0);
}
