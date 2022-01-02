/// @description Camera Movement

camera_following();

//camera_photo_mode();

//camera_screen_shake();

//Clamp Camera
var ww = view_width div 2;
var hh = view_height div 2;

//Clamp
var horizontalBuffer = 16;
viewX = clamp(viewX, ww + horizontalBuffer, room_width - horizontalBuffer - ww);
viewY = clamp(viewY, hh, room_height-hh);

//Set
x = (viewX - ww);
y = (viewY - hh);

//Reset Matrix
vm = matrix_build_lookat(viewX, viewY, -10, viewX, viewY, 0, 0, 1, 0);
camera_set_view_mat(camera, vm);
