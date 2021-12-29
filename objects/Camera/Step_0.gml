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



