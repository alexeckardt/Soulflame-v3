/// @description 

//Shader uniform variable setup
u_pos				= shader_get_uniform(shd_light, "u_pos");

//Light Mutators
u_zz				= shader_get_uniform(shd_light, "u_zz");
u_dir				= shader_get_uniform(shd_light, "u_dir");
u_fov				= shader_get_uniform(shd_light, "u_fov");
u_falloff			= shader_get_uniform(shd_light, "u_falloff");
u_str				= shader_get_uniform(shd_light, "u_str");
u_range				= shader_get_uniform(shd_light, "u_range");


//
fakeAppSurf = -1;
lightLayerSurf = -1;


maxDarknessOpacity = 0.9;
maxDarknessOpacityTo = maxDarknessOpacity;

shadowColour = 0;

cX = 0;
cY = 0;