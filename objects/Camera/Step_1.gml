/// @description Camera Setup & Resets

if (!view_enabled) {
	view_set_wport(0, view_width);
	view_set_hport(0, view_height);
	view_set_visible(0, true);
	camera_set_view_mat(camera, vm);
	camera_set_proj_mat(camera, pm);
	
	view_camera[0] = camera;
	view_enabled = true;
}

//Match Screen Size
if (window_get_width() != view_width*zoom
&& window_get_height() != view_height*zoom) {
	
	window_set_size(view_width * zoom, view_height * zoom);
	surface_resize(application_surface, view_width*zoom, view_height*zoom);
}

//Set
displayGoalWidth = view_width*zoom;
displayGoalHeight = view_height*zoom;
display_set_gui_size(displayGoalWidth, displayGoalHeight);


//Culling
if (point_distance(x, y, lastDeactivateX, lastDeactivateY) > cullCameraBuffer/2) {
	
	//Deactivate All
	instance_deactivate_all(true);
	
	//Reactivate
	instance_activate_object(Important)
	instance_activate_object(Solid);
	
	//Reactivate All
	instance_activate_region(x-cullCameraBuffer, y-cullCameraBuffer, 
								view_width + cullCameraBuffer*2, view_height + cullCameraBuffer*2,
								true);
								
}