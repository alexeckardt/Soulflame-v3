//
//DESC:
//
//
//
function generic_collide_solid() {

	var time = Game.delta;
	var lagDampen = power(0.95, time);

	//Horizontal Collide
	var moveX = (hSpeed)*time*lagDampen
	if (place_meeting(x + moveX, y, Solid)) {
	
		//Approach Wall until meeting
		while(!place_meeting(x+sign(moveX), y, Solid)) {
			x += sign(moveX);
		}
	
		//Reset Movement Vals
		moveX = 0;
		hSpeed = 0;
	}
	x += moveX;

	//Vertical Collide
	timeSinceOnGround += time;
	var moveY = (vSpeed)*time*lagDampen;
	if (place_meeting(x, y+moveY, Solid)) {

		//Back Onto Wall
		while(!place_meeting(x, y+sign(moveY), Solid)) {
			y += sign(moveY);
		}
	
		//Slide Around Corner
		/*
		var stopVspeed = true;
		if (vSpeed < -1) {
			if (!place_meeting(x+slideCornerRange+hSpeed, y-2+vSpeed, Solid)) {
				hSpeed = 2;
				stopVspeed = false;
			}
		
			if (!place_meeting(x-slideCornerRange+hSpeed, y-2+vSpeed, Solid)) {
				hSpeed = -2;
				stopVspeed = false;
			}
		}*/

		//Reset Speed
		moveY = 0;
	
		//if (stopVspeed) {
			moveY = 0;
			vSpeed = 0;
		//}
	}
	y+=moveY;

	//Update On Ground
	onGround = place_meeting(x, y+1, Solid);
	groundBelow = (onGround) ? instance_place(x, y+1, Solid) : noone

}