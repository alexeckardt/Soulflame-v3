/// @desc


//Camera Follow

var halfCamW = view_width div 2;
var halfCamH = view_height div 2;
var goalX = x;
var goalY = y;

if (instance_exists(target)) {	
	if (target != noone) {
		
		goalX = lerp(goalX, target.x+targetXoffset-halfCamW, trackingSpeed);
		goalY = lerp(goalY, target.y+targetYoffset-halfCamH, trackingSpeed);
		
	} else {

		var bS = 0.1;
		var lerpP = bS + (1-bS)*(!panCameraToLock)
		goalX = lerp(goalX, lockX, lerpP);
		goalY = lerp(goalY, lockY, lerpP);
			
	}
}

goalX = clamp(goalX, roomEdgeBuffer, room_width-roomEdgeBuffer-view_width);
goalY = clamp(goalY, roomEdgeBuffer, room_height-roomEdgeBuffer-view_height);

x = (goalX);
y = (goalY);




//

// sloow pan
if (keyboard_check(vk_shift)) { x += 0.1; y += 0.05; }


//Update Camera Position
camera_set_view_pos(view_camera[0], (x), (y));


//Update Camera Dimensions
if (updateCam) {
	
	var z = 1/cameraZoom
	
	//Update Camera Dimensions
	camera_set_view_size(view_camera[0], view_width*z + 1, view_height*z + 1);	
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