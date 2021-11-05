/// @desc

//Update Size Of Camera

updateCam = true;

var goalPixelSize = 4
view_width = 1920 div goalPixelSize;
view_height = 1080 div goalPixelSize;

displayHeight = display_get_height()

cameraZoom = 1;
windowScale = displayHeight div view_height;

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