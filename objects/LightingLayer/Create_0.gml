/// @description 

//Shader uniform variable setup
u_pos = shader_get_uniform(shd_light,"u_pos");
u_pos2 = shader_get_uniform(shd_shadow,"u_pos");

//Light Mutators
u_zz = shader_get_uniform(shd_light,"zz");


vertex_format_begin();
vertex_format_add_position_3d();
vf = vertex_format_end();
vb = vertex_create_buffer();

//
lightLayerSurf = -1;

ambientLighting = 0.9;

cX = 0;
cY = 0;