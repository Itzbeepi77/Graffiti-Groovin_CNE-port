void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 v_vTexcoord = fragCoord / iResolution.xy;
    vec4 v_vColour = vec4(1.0); 

    vec2 coordinates;
    float pixelDistanceX;
    float pixelDistanceY;
    float offset;
    float dir;

    pixelDistanceX = abs(v_vTexcoord.x - 0.5);
    pixelDistanceY = abs(v_vTexcoord.y - 0.5);
    
    offset = pixelDistanceX * 0.03 * pixelDistanceY;

    if (v_vTexcoord.y <= 0.5)
        dir = 1.0;
    else
        dir = -1.0;

    coordinates = vec2(v_vTexcoord.x, v_vTexcoord.y + pixelDistanceX * (offset * 30.0 * dir));
    
    vec4 color = texture2D(iChannel0, coordinates);
    fragColor = v_vColour * color;
}
