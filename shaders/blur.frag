void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
	vec2 coordinates = fragCoord.xy / iResolution.xy;
    float contrast = 2.0;
	vec4 originalColor = texture2D(iChannel0, coordinates);
	vec4 finalColor = vec4(((originalColor.rgb-vec3(0.5))*contrast)+vec3(0.5), 1.0);
	fragColor = clamp(finalColor, 0.0, 1.0);
}