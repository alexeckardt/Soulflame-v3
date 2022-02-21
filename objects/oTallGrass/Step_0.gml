/// @description 


if (instance_exists(Entity)) {
	
	var entityNearest = instance_place(x, y, Entity);
	if (entityNearest != noone) {
	
		//Squish Under Entity
		yscaleTo = imY*0.55;
		squiedHoldFor = room_speed/2;
	
		if (!wasColliding) {
			wasColliding = true;
		
			var maxInensity = 9;
			if (shakeIntensity < maxInensity * 0.7) {
				shakeIntensity = maxInensity;
				timeShook = current_time;
			
				shakeDir = -entityNearest.directionFacing;
			}
		}
	} else {
		wasColliding = false;	
	
		//Unsquish After Time
		squiedHoldFor--;
		if (squiedHoldFor > 0) {
			yscaleTo = imY;
		}
	}
}

//Shakes
var ambientMovment = ampli*sin((current_time - myOffsetTime) / (period*5));
var shake = 0;

//Update Shake On Touch
if (shakeIntensity > 0) {
	shakeIntensity = lerp(shakeIntensity, -0.01, 0.01*Game.delta);
	
	var time = (current_time - timeShook);
	var a = shakeIntensity*ampli;
	var periodd = period + (1/shakeIntensity); //this won't be zero because of the if
	periodd = min(period, 2000);
	
	shake = shakeDir*a*sin(time/periodd);
}

//Update Angle
image_angle = myAngle + shake + ambientMovment;

//Destroy If Nessesary
if (onStart < 1) {

	//Break on Campfire
	if (place_meeting(x, y, oCampfire)) {
		instance_destroy();	
	}

	//Break
	if (!place_meeting(x, y+3, Solid)) {
		instance_destroy();	
	}
	
	onStart += Game.delta;
}

yscale = lerp(yscale, yscaleTo, 0.1*Game.delta);
