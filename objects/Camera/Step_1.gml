/// @description Camera Setup & Resets

var goalW = view_width+1;
var goalH = view_height+1;

//
//Switch To Full Screen
if (window_get_fullscreen() != Game.fullscreen) {
	window_set_fullscreen(Game.fullscreen);
	calculateViewDimentions = true;
	
	//Reset Pos
	if (!Game.fullscreen) {
		display_reset(0, false);	
	}
}

//
//Recalc View Size
if (calculateViewDimentions) {
	if (Game.fullscreen) {
		screenWidth = display_get_width();
		screenHeight = display_get_height();
		
		screenWidth = 1920;
		screenHeight = 1080;
	} else {
		screenWidth = window_get_width();
		screenHeight = window_get_height();	
	}

	//Get Aspect
	aspectRatio = screenWidth / screenHeight;
	idealWidth = round(idealHeight * aspectRatio);
	if (idealWidth & 1) idealWidth++; //Check Odd	
	
	//Set Size
	view_width = idealWidth;
	view_height = idealHeight;
	
	//Reconstruct
	hasSetup = false;
	calculateViewDimentions = false;
	

}

//
//Resize Window + Camera
if (window_has_focus() || !hasSetup) {
	if (window_get_width() != view_width*zoom
	&& window_get_height() != view_height*zoom) || !hasSetup {
	
		window_set_size(view_width*zoom, view_height*zoom);
		
		camera_set_view_size(view_camera[0], view_width+1, view_height+1);
		if (surface_exists(view_surf)) 
			{surface_resize(view_surf, view_width+1, view_height+1);}
		if (surface_exists(effective_view_surf)) 
			{surface_resize(effective_view_surf, view_width+1, view_height+1);}
		if (surface_exists(lightLayerSurf)) 
			{surface_resize(lightLayerSurf, view_width+1, view_height+1);}
		
		hasSetup = true;
	}
}


//
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

	lastDeactivateX = x;
	lastDeactivateY = y;
	
}

//
//photo Mode
if (keyboard_check_pressed(vk_f8)) {
	photoMode = !photoMode;
	x = viewX;
	y = viewY;
}

