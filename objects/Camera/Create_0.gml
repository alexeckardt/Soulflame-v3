/// @description 

updateCam = true;

//Sizes
zoom = 4;
resolution = 1;

//Get Ideal Resolution
idealWidth = 540;
idealHeight = 270;
aspectRatio = display_get_width() / display_get_height();
idealWidth = round(idealHeight * aspectRatio);
if (idealWidth & 1) idealWidth++; //Check Odd

view_width = idealWidth;
view_height = idealHeight;

//Camera
camera = view_camera[0];
view_surf = -1;
application_surface_enable(false);


hasSetup = false;

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
view_surf = -1;

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
//  LIGHTING
//
//

lightDepth = 25;
pointLightController = instance_create_depth(x, y, lightDepth, oPointLightController);

//Shader uniform variable setup
u_pos				= shader_get_uniform(shd_light, "u_pos");

//Light Mutators
u_zz				= shader_get_uniform(shd_light, "u_zz");
u_dir				= shader_get_uniform(shd_light, "u_dir");
u_fov				= shader_get_uniform(shd_light, "u_fov");
u_falloff			= shader_get_uniform(shd_light, "u_falloff");
u_str				= shader_get_uniform(shd_light, "u_str");

//
lightLayerSurf = -1;

maxDarknessOpacity = 1;
maxDarknessOpacityTo = maxDarknessOpacity;

shadowColour = 0;

cX = 0;
cY = 0;

renderedLights = 0;
MaxLights = 200; //Try To Keep Under

drawLighting = true;

fastLighting = false;
