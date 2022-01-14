//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	//Replace Pure Green
	vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	if (color.r == 0.0 && color.b == 0.0 && color.g == 1.0) {	
		color = vec4(0.0, 0.0, 0.0, 0.0);
	}
	
	//Draw Pixel
    gl_FragColor = color;
}
