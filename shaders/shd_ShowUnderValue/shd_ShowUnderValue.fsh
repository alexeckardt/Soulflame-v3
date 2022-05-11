//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float threshold;

void main()
{
	vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	float averageCol = (color.r + color.g + color.b) * 0.3333;

	//Change Alpha to one if the colour value is below the float 
	if (averageCol < threshold) {
		gl_FragColor = vec4(averageCol, averageCol, averageCol, 0);	
	} else {		
		gl_FragColor = vec4(averageCol, averageCol, averageCol, 1);		
	}

}
