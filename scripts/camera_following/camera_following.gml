// @desc
//
//
//
function camera_following(){
	
	if (instance_exists(follow)) {
		
		if (follow != id) {
		
			viewX = lerp(viewX, follow.x, 0.25);
			viewY = lerp(viewY, follow.y, 0.25);
		
		} else {

			var bS = 0.1;
			var lerpP = bS + (1-bS)*(!panCameraToLock)
			viewX = lerp(viewX, lockX, lerpP);
			viewY = lerp(viewY, lockY, lerpP);
			
		}
	}

}