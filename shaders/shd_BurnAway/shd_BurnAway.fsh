//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec4 returnCol;
float averageCol;
float alpha;
uniform float fullAlphaBelowValue;
uniform vec4 glowColour; //doesn't matter, i think it's black though
uniform float leadingBlur; //0.1 for base, 0.007 for overlay (edge)

const float bandAlphaFallOff = 80.0; //80.0
const float bandMaxAlphaThickness = 0.4; //0.4


void main()
{
	
	//Get Colour
	vec4 glowCol = glowColour;
	
	//Colour at Texture Posotion
	vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	//Average Colour
	averageCol = (color.r + color.g + color.b) * 0.3333;

	//Distance of average colour to the cutoff value
	//float distanceToVal = averageCol - fullAlphaBelowValue;

	//Change Alpha to one if the colour value is below the float 
	if (averageCol <= fullAlphaBelowValue) {
		
		//Fade Off (No Hard Line) (NO ALPHA)
		float alpha = min(max(0.0, 1. - (bandAlphaFallOff*(fullAlphaBelowValue - averageCol) - bandMaxAlphaThickness)), 1.0);
		gl_FragColor = vec4(glowCol.r, glowCol.g, glowCol.b, alpha);	
		
	} else {	
		
		//Slow Glow To The Fade Off Point (FULL ALPHA)
		float glowAlpha = max(0.0, (leadingBlur - (averageCol - fullAlphaBelowValue)) / leadingBlur);
		gl_FragColor = vec4(glowCol.r * glowAlpha, glowCol.g * glowAlpha, glowCol.b * glowAlpha, 1.0);	
		//gl_FragColor = vec4(0., 0., 0., 1.);
	}

}
