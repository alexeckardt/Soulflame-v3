/// @desc

//Camera Follow
var halfCamW = view_width div 2;
var halfCamH = view_height div 2;
var goalX = (x);
var goalY = (y);

if (instance_exists(target)) {	
	if (target != noone) {
		
		var tX = (target.x+targetXoffset-halfCamW);
		var tY = (target.y+targetYoffset-halfCamH);
		
		//goalX = lerp(goalX, tX, trackingSpeed);
		//goalY = lerp(goalY, tY, trackingSpeed);
		
		var goalD = point_direction(x, y, tX, tY);
		var goalDist = point_distance(x, y, tX, tY);
		
		var smooth = 5;
		
		goalX += lengthdir_x(goalDist div smooth, goalD);
		goalY += lengthdir_y(goalDist div smooth, goalD);
		
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



