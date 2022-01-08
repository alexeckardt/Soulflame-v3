//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec4 base;
vec4 grayAddition;
vec4 color;
float grayScale;

void main()
{
	grayScale = (v_vColour.r + v_vColour.g + v_vColour.b) * 0.333;
	
	base = vec4(v_vColour.r*0.15, v_vColour.g*0.15, v_vColour.b*0.15, v_vColour.a);
	grayAddition = vec4(grayScale, grayScale, grayScale, 0);
	color = vec4(v_vColour.r, v_vColour.g, v_vColour.b, 0);
	
    gl_FragColor = (base + grayAddition + color*2.0) * texture2D( gm_BaseTexture, v_vTexcoord );
}
