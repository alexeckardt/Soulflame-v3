varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float waveFreqY;
uniform float waveAmplitude;

uniform vec4 myDims; //(x, y, w, h) == (x, y, z, a)
uniform vec4 camDims; //(x, y, w, h) == (x, y, z, a)


void main() {
	
	//Calculate My Position based on my pos on the camera
	vec2 onScreenCoord = vec2((myDims.x - camDims.x) / camDims.z, (myDims.y - camDims.y) / camDims.a);
	
	float xx = sin(-time + (v_vTexcoord.y-onScreenCoord.y)*waveFreqY);
	float displaceXOffset = xx*xx * waveAmplitude;
	
    vec2 offset = vec2(displaceXOffset, 0.0);
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord + offset);
}
