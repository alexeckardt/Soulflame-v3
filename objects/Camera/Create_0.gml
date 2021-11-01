/// @desc

//Update Size Of Camera

updateCam = true;
view_width = 320;
view_height = 180;

cameraZoom = 1;
windowScale = 8;

//Disable Application Surface
application_surface_enable(false);

// game_width, game_height are your base resolution (ideally constants)
vc = view_camera[0];


//Set the Size of the Camera
camera_set_view_size(view_camera[0], view_width/cameraZoom + 1, view_height/cameraZoom + 1);
display_set_gui_size(view_width, view_height);

view_surf = -1;

//
//

target = oKeira;
targetXoffset = 0;
targetYoffset = -16;
trackingSpeed = 0.2;

lockX = x;
lockY = y;

roomEdgeBuffer = 8;