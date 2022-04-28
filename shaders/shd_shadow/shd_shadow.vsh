attribute vec3 in_Position;                  // (x,y,z)

const float len = 10000.;

varying float tdis;
varying float ldis;

uniform vec2 u_pos; //light source positon
void main(){
	
	vec2 pos = in_Position.xy;
	vec2 dis = pos - u_pos;
	float sdis = length(dis);

	if (in_Position.z > 1.){ //check if vertex requires repositioning
		pos += dis/sdis * len; //repositioning the vertex with respect to the light position
		tdis = in_Position.z-2.;
		ldis = 1.;
	} else {
		ldis = sdis/len;
		tdis = mix(0.5, in_Position.z, ldis);
	}
	
	
    vec4 object_space_pos = vec4( pos.x, pos.y, 0., 1.0); //shadow is drawn at a z-value closer to the screen than its corresponding light. 
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
}
