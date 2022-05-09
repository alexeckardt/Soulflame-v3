/// @description Camera Setup & Resets

var goalW = view_width+1;
var goalH = view_height+1;

//Create View Surf
if (!surface_exists(view_surf)) {
	view_surf = surface_create(goalW, goalH);	
}


if (!view_enabled) {
	camera_set_view_size(view_camera[0], goalW, goalH);
	view_set_visible(0, true);

	view_enabled = true;
}

view_surface_id[0] = view_surf;

//Match Screen Size
if (window_has_focus()) {
	if (window_get_width() != view_width*zoom
	&& window_get_height() != view_height*zoom) {
	
		window_set_size(view_width*zoom, view_height*zoom);
		view_enabled = false;
		
	}
}

//Culling
if (point_distance(x, y, lastDeactivateX, lastDeactivateY) > cullCameraBuffer/2) {
	
	//
	//Deactivate All
	instance_deactivate_all(true);
	
	//Reactivate All Near
	instance_activate_region(x-cullCameraBuffer, y-cullCameraBuffer, 
								view_width + cullCameraBuffer*2, view_height + cullCameraBuffer*2,
								true);
	
	//
	//Reactivate Necessary
	instance_activate_object(Important);
	instance_activate_object(Solid);


}