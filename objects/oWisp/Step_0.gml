/// @description 

var t = Game.delta;


//Check Persistance
if (!checkedAlreadyDestroyed) {
	
	//Save
	checkedAlreadyDestroyed = true;
	
	//Destroy Self If Already
	var get = game_persistence_check(storename);
	if (!is_undefined(get)) {
		instance_destroy();
		instance_destroy(target); //the target object
	}
}

//
//Emit Particles
particle_create_essence_glob_wisp(x, y, x, y, 1); //body

//Movement
switch (phase) {
	
	//-------------------------------------------------------------------
	case 0:
	
		var d = point_distance(orgX, orgY, oKeira.x, oKeira.y);
		//Zoom Off
		if (d < shootOffRange) {
			phase++;
			travelDirection = point_direction(target.x, target.y, x, y) + irandom_range(-30, 30);
			travelSpeed = 1;
		} else {
			
			//Push away slightly
			var disP = clamp(1 - d/interactRange, 0, 1);
			var dir = point_direction(x, y, target.x, target.y);
			x += lengthdir_x(disP, dir)*t;
			y += lengthdir_y(disP, dir)*t;
						
			//
			//
			//Random Vibration
			var r = 8*(1-disP);
			if (distance_to_point(goalX, goalY) < 0.1) {
				goalX = orgX + irandom_range(-r, r);	
				goalY = orgY + irandom_range(-r, r);	
			}
	
			//Move To Random Vibration
			x = lerp(x, goalX, 0.03*t);
			y = lerp(y, goalY, 0.03*t);
			
		}
		
		
	break;
	//-------------------------------------------------------------------	
	case 1:
	
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
			
	var part = point_light_create(x, y, newspd, 180, 180, life, colour, 0);
	part.doGravity = false;
			
	part.spdIncrease = -0.05;
	part.spdAbsolute = true;

	part.str = 0.3;
	
}

