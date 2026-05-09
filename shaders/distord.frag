// GLSL Shader for Distortion, Chromatic Aberration, Screen Shake, and Glow Effect in Codename Engine

#pragma header

uniform float time;
uniform float intensity;

// Screen Shake Function
vec2 screenShake(vec2 uv, float strength) {
    float shakeX = (sin(time * 20.0) * 0.005) * strength;
    float shakeY = (cos(time * 20.0) * 0.005) * strength;
    return clamp(uv + vec2(shakeX, shakeY), 0.0, 1.0);
}

// Distortion Function
vec2 distortUV(vec2 uv, float strength) {
    float wave = sin(uv.y * 10.0 + time * 5.0) * 0.02;
    uv.x += wave * strength;
    return clamp(uv, 0.0, 1.0);
}

// Chromatic Aberration Function
vec3 chromaticAberration(vec2 uv, float amount) {
    vec3 col;
    col.r = flixel_texture2D(openfl_TextureCoordv*openfl_TextureSize, clamp(uv + vec2(amount, 0), 0.0, 1.0)).r;
    col.g = flixel_texture2D(openfl_TextureCoordv*openfl_TextureSize, clamp(uv, 0.0, 1.0)).g;
    col.b = flixel_texture2D(openfl_TextureCoordv*openfl_TextureSize, clamp(uv - vec2(amount, 0), 0.0, 1.0)).b;
    return col;
}

// Glow Effect Function
vec3 glowEffect(vec3 color, float strength) {
    vec3 glow = vec3(1.0, 0.2, 0.6) * strength;
    return clamp(color + glow, 0.0, 1.0);
}

void main() {
    vec2 uv = openfl_TextureCoordv*openfl_TextureSize;
    uv = screenShake(uv, intensity * 0.5);
    uv = distortUV(uv, intensity);
    vec3 color = chromaticAberration(uv, intensity * 0.01);
    color = glowEffect(color, intensity * 0.5);
    gl_FragColor = vec4(color, 1.0).a;
}
