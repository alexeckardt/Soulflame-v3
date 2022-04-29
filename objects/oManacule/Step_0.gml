/// @description 

var t = Game.delta;

switch (phase) {
	
	default:
	case 0:
	
		//Move
		x += lengthdir_x(travelSpeed, travelDirection)*t;
		y += lengthdir_y(travelSpeed, travelDirection)*t;

		//Slow Down
		travelSpeed -= 0.05*t
	
		if (travelSpeed < 0.001) {
			phase++;
			travelSpeed = 0;
		}
		
	break;
	//-------------------------------------------------------------------
	case 1:
	
		holdTime -= t;
		
		if (holdTime < 0) {
			phase++;	
			travelDirection = (travelDirection + 180) mod 360; //Go Back In
		}
	
	break;
	//-------------------------------------------------------------------	
	case 2:
	
		//Direction
		var goalDir = point_direction(x, y, target.x, target.y);
		var angleDiff = angle_difference(goalDir, travelDirection);
		
		//Speed Up
		var turnPercent = abs(abs(angleDiff) - 90) / 90;
		var spdTo = turnPercent * zoomMaxSpeed;
		
		//Change Dir
		travelDirection += t * angleDiff / directionLerpSpeed;
		directionLerpSpeed = lerp(directionLerpSpeed, 1, 0.05);
		
		//Switch Speed
		travelSpeed = lerp(travelSpeed, spdTo, 0.1*t);
	
		x += lengthdir_x(travelSpeed, travelDirection)*t;
		y += lengthdir_y(travelSpeed, travelDirection)*t;
	
		//Collide
		gobbleRadius += 0.2*t;
		if (point_distance(x, y, target.x, target.y) < gobbleRadius + travelSpeed) {
		
			//End
			instance_destroy();
		
		}
	
	break;

}