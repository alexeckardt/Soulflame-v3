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
	var hCollideSolid = instance_place(x + moveX, y, Solid);
	if (hCollideSolid != noone) {
	
		//Don't H Collide on one way solids
		if (!hCollideSolid.oneway) {
			
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
		
	}
	x += moveX;

	//Vertical Collide
	timeSinceOnGround += time;
	var moveY = (vSpeed)*time*lagDampen;
	
	var vCollideSolid = instance_place(x, y+moveY, Solid);
	if (vCollideSolid != noone) {

		//Collide in certian direction
		var goingUpOneway = vCollideSolid.oneway && sign(moveY) == -1;
		if (!goingUpOneway) {
			
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
			vSpeed = 0;
		} else {
		var hi = 0;	
		}
	}
	y+=moveY;

	//Update On Ground
	onGround = vCollideSolid != noone;
	groundBelow = (onGround) ? vCollideSolid : noone

}