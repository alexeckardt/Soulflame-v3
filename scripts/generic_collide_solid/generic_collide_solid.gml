//
//DESC:
//
//
//
function generic_collide_solid() {

	var time = Game.delta;
	var lagDampen = 1//power(0.99, time);

	//Horizontal Collide
	var moveX = (hSpeed)*time*lagDampen
	if (place_meeting(x + moveX, y, Solid)) {
	
		//Approach Wall until meeting
		var sigMoveX = sign(moveX);
	
		//Back Onto Wall
		repeat (floor(abs(moveX))) {
			if (!place_meeting(x+sigMoveX, y, Solid)) {
				x += sigMoveX;
			}
		}
	
	
		//Reset Movement Vals
		moveX = 0;
		hSpeed = 0;
		
		//Bounce Off Wall From Knockback
		knockbackHSpeed /= -2;
		
		
	}
	x += moveX;

	//Vertical Collide
	timeSinceOnGround += time;
	var moveY = (vSpeed)*time*lagDampen;
	if (place_meeting(x, y+moveY, Solid)) {

		//Back Onto Wall
		repeat (floor(abs(moveY))) {
			if (!place_meeting(x, y+sign(moveY), Solid)) {
				y += sign(moveY);
			}
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