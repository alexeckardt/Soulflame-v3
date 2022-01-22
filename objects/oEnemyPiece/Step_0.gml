/// @description 

var time = Game.delta;

//Get Moved
//if (onGround) {
	var entityMeeting = instance_place(x, y, Entity);
	if (entityMeeting != noone) {
		
		var pushDirection = point_direction(0, 0, entityMeeting.hSpeed, entityMeeting.vSpeed);
		var pushForce = point_distance(0, 0, entityMeeting.hSpeed, entityMeeting.vSpeed) / weight * pushResistance;
		
		hSpeed += lengthdir_x(pushForce, pushDirection);
		vSpeed += lengthdir_y(pushForce, pushDirection);

		angleSpeed += lengthdir_x(pushForce, pushDirection)/2;
		
	}
//}


freeze = (onGround && abs(hSpeed) < 0.01 && abs(vSpeed) < 0.01 && abs(angleSpeed) < 0.1)

if (!freeze) {

	//Collision
	var lastVspeed = vSpeed;
	var lastHSpeed = hSpeed;
	
	
		var lagDampen = power(0.95, time);

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

		//
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

			//Reset Speed
			moveY = 0;
			vSpeed = 0;
		}
		y+=moveY;

		//Update On Ground
		onGround = place_meeting(x, y+1, Solid);
		groundBelow = (onGround) ? instance_place(x, y+1, Solid) : noone
	
	
	angle += angleSpeed*time;

	//Gravity
	vSpeed += myGrav*time;

	if (onGround) {
	
		if (bounce) {
	
			if (!wasOnGround) {
			
				//Bounce
				if (abs(lastVspeed) > 0.1) {
					vSpeed = -lastVspeed * bounceEnergyRetain;
					onGround = false;
				
					angleSpeed += hSpeed / 2;
					hSpeed += abs(hSpeed/10)*random_range(-1, 1);
				
					if (irandom(100) < funnyBounceChance) {
						angleSpeed += irandom_range(-20, 20);
						funnyBounceChance -= 1;
					}
				} else {
					bounce = false;	
				}
			
			}


		} else {
		
			//Slide, Slow Down
			hSpeed = lerp(hSpeed, 0, weight/10*time);
		
		}
	
			
		//Cut Angle Speed
		angleSpeed /= 2;
		
	
	} else {
		if resetBounceWhenInAir {
			bounce = true;	
		}
	}
	wasOnGround = onGround;

} else {
	onGround = true;	
}