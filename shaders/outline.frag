#define PI 3.14159265359
#define SAMPLES 3
#define MAG 0.01

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
    //Animate the cat
    //----------------
    
    vec3 targetCol = vec3(1.0, 1.0, 1.0); //The color of the outline
    
    vec4 finalCol = vec4(0);
    
    float rads = ((360.0 / float(SAMPLES)) * PI) / 180.0;	//radians based on SAMPLES
    
    for(int i = 0; i < SAMPLES; i++)
    {
        if(finalCol.w < 0.1)
        {
        	float r = float(i + 1) * rads;
    		vec2 offset = vec2(cos(r) * 0.1, -sin(r)) * MAG; //calculate vector based on current radians and multiply by magnitude
    		finalCol = texture2D(iChannel0, uv + offset);	//render the texture to the pixel on an offset UV
            if(finalCol.w > 0.0)
            {
                finalCol.xyz = targetCol;
            }
        }
    }
    
    vec4 tex = texture2D(iChannel0, uv);
    if(tex.w > 0.0)
    {
     	finalCol = tex;   //if the centered texture's alpha is greater than 0, set finalcol to tex
    }
    
	fragColor = finalCol;
}