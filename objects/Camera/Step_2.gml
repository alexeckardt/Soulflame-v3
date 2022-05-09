/// @description Camera Movement

if (Game.delta != 0) {

	camera_following();

	//camera_photo_mode();

	camera_screen_shake();

	//Clamp Camera
	var ww = view_width div 2;
	var hh = view_height div 2;

	//Clamp
	viewX = clamp(viewX, ww + horizontalBuffer, room_width - horizontalBuffer - ww);
	viewY = clamp(viewY, hh, room_height-hh);

	//Set
	realX = (viewX - ww);
	realY = (viewY - hh);
	x = floor(realX);
	y = floor(realY);

	//Move Camera
	var goalW = view_width+1;
	var goalH = view_height+1;
	if (!surface_exists(view_surf)) {
		view_surf = surface_create(goalW, goalH);
	}

	camera_set_view_pos(view_camera[0], x, y);
	view_surface_id[0] = view_surf;

}
