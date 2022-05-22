//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );

	//If All Black; Then Removed Alpha
	if (color.r + color.g + color.b == 0.0) {
		gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
	} else {		
		gl_FragColor = color;
	}
}
