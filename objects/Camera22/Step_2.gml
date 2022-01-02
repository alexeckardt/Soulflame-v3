/// @description 

//Update Camera Position
camera_set_view_pos(view_camera[0], floor(x), floor(y));

//Update Camera Dimensions
if (updateCam) {
	
	var z = 1/cameraZoom
	
	//Update Camera Dimensions
	camera_set_view_size(view_camera[0], view_width*z+1, view_height*z+1);	
	display_set_gui_size(view_width*z, view_height*z);
	
	//Set Scale
	window_set_size(view_width*windowScale, view_height*windowScale);
	window_center();
	
	display_reset(0, false)
	
	updateCam = false;
}

//Create The Surface
if (!surface_exists(view_surf)) {
    view_surf = surface_create(view_width + 1, view_height + 1);
}

//Update View Surface
view_surface_id[0] = view_surf;