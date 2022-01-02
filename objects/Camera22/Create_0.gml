 /// @desc

//Update Size Of Camera


displayHeight = display_get_height()
windowScale = (displayHeight div view_height) - 1;

//Disable Application Surface
application_surface_enable(false);

// game_width, game_height are your base resolution (ideally constants)
vc = view_camera[0];


//Set the Size of the Camera
cameraZoom = 1;
camera_set_view_size(view_camera[0], view_width/cameraZoom + 1, view_height/cameraZoom + 1);
display_set_gui_size(view_width, view_height);

view_surf = -1;

//
//

target = oKeira;
targetXoffset = 0;
targetYoffset = -16;
trackingSpeed = 0.2;

followSpeed = 0;

lockX = x;
lockY = y;

roomEdgeBuffer = 8;