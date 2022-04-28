/// @description 

updateCam = true;

zoom = 4;
resolution = 1;
view_width = 1920 div zoom;
view_height = 1080 div zoom;

//Disable Application Surface
camera = camera_create();
vm = matrix_build_lookat(0, 0, -10, 0, 0, 0, 0, 1, 0);
pm = matrix_build_projection_ortho(view_width, view_height, 1, 3200);

follow = oKeira;
viewX = 0;
viewY = 0;
realX = 0;
realY = 0;
if (instance_exists(follow)) {
	viewX = follow.x;
	viewY = follow.y;
}


followOffsetX = 0;
followOffsetY = -8;

depth = -20;
application_surface_draw_enable(false);

//Turns on in Begin Step; Used to reset camera properties
view_enabled = false

photoMode = false;
dragging = false;
cameraDragX = 0;
cameraDragY = 0;

lockX = 0;
lockY = 0;
panCameraToLock = false;
panSpeed = 1;

//Background Surface
bkgSurf = -1;
frgSurf = -1;
fireSurf = -1;
createdBkgSurface = false;

//Camera Shake
screenXShake = 0
screenYShake = 0;

screenShakeDir = 0;
screenShakeLen = 0;

screenShakeMulti = 0;

horizontalBuffer = 16;

//Run Particles
lastDeactivateX = -100;
lastDeactivateY = -100

//Cull Region
cullCameraBuffer = 128;

//Combat Camera
updateCombatCameraTicks = -1;
updateCombatCameraEveryNTicks = 5;
combatCamera = false;
agressedEnemies = ds_list_create();

goalCx = x;
goalCx = y;

//
//
// LIGHTING
//
//

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
gameLayerSurf = -1;

ambientBrightnesssValue = 0.1; // 1 = no shadows, 0 max shadows
ambientLightingColour = c_black;

lightDepthLayer = depth + 10;
//instance_create_depth(0, 0, lightDepthLayer, oMovingLight);


enable = true;