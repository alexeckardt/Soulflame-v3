//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec4 base;
vec4 grayAddition;
float grayScale;

void main()
{
	grayScale = (v_vColour.r + v_vColour.g + v_vColour.b) * 0.333;
	
	base = vec4(v_vColour.r*0.15, v_vColour.g*0.15, v_vColour.b*0.15, v_vColour.a*0.15);
	grayAddition = vec4(grayScale, grayScale, grayScale, v_vColour.a);
	
    gl_FragColor = (base + grayAddition + v_vColour*2.0) * texture2D( gm_BaseTexture, v_vTexcoord );
}
