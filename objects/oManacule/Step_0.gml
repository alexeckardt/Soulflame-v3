/// @description 

var t = Game.delta;

//Emit Particles
if (partScript == -1) {
	var scrp = (sign(align) == -1) ? particle_create_essence_glob_chaos : particle_create_essence_glob_order;
	partScript = scrp;
}
partScript(x, y, x, y, 1); //body

//Movement
switch (phase) {
	
	case 0:
	
		//Move
		pauseBeforeEmitTime -= t;
		if (pauseBeforeEmitTime < 0) {
			
			//Moe
			x += lengthdir_x(travelSpeed, travelDirection)*t;
			y += lengthdir_y(travelSpeed, travelDirection)*t;

			//Slow Down
			travelSpeed -= 0.05*t
	
			if (travelSpeed < 0.001) {
				phase++;
				travelSpeed = 0;
			}
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
	
		//Exit
		if (!instance_exists(target) || target == noone) {
			phase++;
			break;
		}
	
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
	//-------------------------------------------------------------
	//
	//Fade Out State
	//
	default:
	
		//Continue Moving
		x += lengthdir_x(travelSpeed, travelDirection)*t;
		y += lengthdir_y(travelSpeed, travelDirection)*t;
	
		//Fade out + darken
		var lS = 0.1*t;
		size = lerp(size, 0, lS);
		colour = merge_colour(colour, 0, lS);
		
		//Die
		if (size < 0.05) {
			instance_destroy();	
		}
	
	break;
}

///
///
///
///
///

randomize();
var emitOne = random(100) < 5 + travelSpeed; //5 percent per frame
if (emitOne) {

	var newspd = random_range(0.25, 0.8);
	var life = irandom_range(0.5/newspd, 1.2/newspd)*room_speed;
	var c = essence_get_colour_emission(align);	
	
	var part = point_light_create(x, y, newspd, 180, 180, life, c, 0);
	part.doGravity = false;
			
	part.spdIncrease = -0.05;
	part.spdAbsolute = true;
	
	part.str = 0.3;
	
}

