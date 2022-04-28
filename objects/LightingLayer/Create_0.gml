/// @description 

//Shader uniform variable setup
u_pos = shader_get_uniform(shd_light,"u_pos");
u_pos2 = shader_get_uniform(shd_shadow,"u_pos");

//Light Mutators
u_zz = shader_get_uniform(shd_light,"zz");
u_str = shader_get_uniform(shd_light,"u_str");
u_dir = shader_get_uniform(shd_light,"u_dir");
u_fov = shader_get_uniform(shd_light,"u_fov");


vertex_format_begin();
vertex_format_add_position_3d();
vf = vertex_format_end();
vb = vertex_create_buffer();

//
lightLayerSurf = -1;
fakeAppSurf = -1;

ambientBrightnesssValue = 2.0; // 1 = no shadows, 0 max shadows
ambientLightingColour = c_black;

cX = 0;
cY = 0;

lightDepthLayer = depth + 1;
instance_create_depth(0, 0, lightDepthLayer, oMovingLight);

enable = true;