/// @description Camera Setup & Resets

//Create View Surf
var goalW = view_width+1;
var goalH = view_height+1;
if (!surface_exists(view_surf)) {
	view_surf = surface_create(goalW, goalH);
	}

view_surface_id[0] = view_surf;

//Resize Window + Camera
if (window_has_focus() || !hasSetup) {
	if (window_get_width() != view_width*zoom
	&& window_get_height() != view_height*zoom) || !hasSetup {
	
		window_set_size(view_width*zoom, view_height*zoom);
		camera_set_view_size(view_camera[0], goalW, goalH);
		
		hasSetup = true;
		
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