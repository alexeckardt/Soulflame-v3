// @desc
//
//
//
function camera_following(){
	
	var time = Game.delta;
	
	var ww = view_width div 2;
	var hh = view_height div 2;

	if (instance_exists(follow)) {
		
		if (follow != id) {
		
			var cX = clamp(follow.x + followOffsetX, ww+horizontalBuffer, room_width-horizontalBuffer-ww);
			var cY = clamp(follow.y + followOffsetY, hh, room_height-hh);

			viewX = lerp(viewX, cX, 0.25*time);
			viewY = lerp(viewY, cY, 0.25*time);
		
		} else {

			var bS = 0.1;
			var lerpP = bS + (1-bS)*(!panCameraToLock)
			viewX = lerp(viewX, lockX, lerpP*time);
			viewY = lerp(viewY, lockY, lerpP*time);
			
		}
	}

}