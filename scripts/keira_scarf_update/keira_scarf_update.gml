// @desc
//
//
//
function keira_scarf_update(){

	var scarf = scarfId;
	
	//Replace Scarf
	if (!instance_exists(scarf)) {
		
		//Don't Create if out of bounds
		if (x >= 0 && x <= room_width) {
			if (y >= 0 && y <= room_height) {
				scarfId = instance_create_depth(x, y, depth - 2, oScarf); 
				scarfId.creator = id;
				scarf = scarfId;
			}
		}
		
	}

	//Save Position
	scarfAnchorPosX = x + scarfMainOffsetX * directionFacing;
	scarfAnchorPosY = y + scarfMainOffsetY;

	//Apply Movement Shaking
	var vel = point_distance(0, 0, hSpeed, vSpeed);
	if (vel >= 0.3) {
		
		var waveDir = point_direction(0, 0, -vSpeed, hSpeed);
		var shakeStr = (7 * power(vel, 0.7) - 3) / (vel*vel + 5); //h\ =\ \frac{7x^{0.7}-3}{x^{2}+5}\ \ \left\{x\ \ge\ 0.3\right\}
		var waveAmount = sin(current_time/110) * max(0, shakeStr) / 5; //div because the wave stacks
		
		//Apply The Shake Force
		keira_scarf_apply_force(waveAmount, waveDir);

	}
	
	//Running
	if (onGround) {
		if (abs(hSpeed) > 1) {
	
			var upForce = (abs(hSpeed) / runSpeed / 1.5) * scarf.gravStr; //need twice run speed to be perfectly horizontal
			keira_scarf_apply_force(upForce, 90);
	
		} else {
		//Idling
	
			var sideForce = (sin(current_time/400) - directionFacing) / 10; //Push and Sway
			keira_scarf_apply_force(sideForce, 0);
		
		}
	}

}