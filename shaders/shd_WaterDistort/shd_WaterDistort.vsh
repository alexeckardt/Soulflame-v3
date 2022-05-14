//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec2 v_camPosition;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	mat4 viewMatrix = gm_Matrices[MATRIX_VIEW];
	vec2 cam_pos = vec2(viewMatrix[3][0], viewMatrix[3][1]);
	
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
	v_camPosition = cam_pos;
}
