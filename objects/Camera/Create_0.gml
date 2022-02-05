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
followOffsetY = -2;

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
cullCameraBuffer = 16*2;