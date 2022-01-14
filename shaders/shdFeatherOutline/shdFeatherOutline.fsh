//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float pixelW;
uniform float pixelH;

void main()
{
	vec2 offsetx;
	offsetx.x = pixelW;
	vec2 offsety;
	offsety.y = pixelH;
	
	vec4 texture;
	texture = texture2D( gm_BaseTexture, v_vTexcoord );
	
	float alpha = texture.a;
	alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord + offsetx ).a );
	alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord - offsetx ).a );
	alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord + offsety ).a );
	alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord - offsety ).a );
	
    gl_FragColor = v_vColour * vec4(texture.r, texture.g, texture.b, min(1.0, alpha));
}
