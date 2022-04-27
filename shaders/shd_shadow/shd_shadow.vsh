attribute vec3 in_Position;                  // (x,y,z)

uniform vec2 u_pos; //light source positon
void main(){
	vec2 pos = in_Position.xy;

	if (in_Position.z > 0.){ //check if vertex requires repositioning
		vec2 dis = pos - u_pos;
		pos += dis/sqrt(dis.x*dis.x + dis.y*dis.y) * 100000.; //repositioning the vertex with respect to the light position
	}
    vec4 object_space_pos = vec4( pos.x, pos.y, 0., 1.0); //shadow is drawn at a z-value closer to the screen than its corresponding light. 
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
}
