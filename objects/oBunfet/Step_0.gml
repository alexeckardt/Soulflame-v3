var time = Game.delta;

//Take Damage 
enemy_take_damage();

ramp_behaviour()

//Collision
generic_collide_solid();

//(Vertical Motion)
	if (knockbackVSpeed != 0) {
		vSpeed += knockbackVSpeed;
		knockbackVSpeed = 0;
	}
	//Gravity
	vSpeed += myGrav;


	//Reach Goal X
	if (abs(goToX - x) < 2 || sign(goToX - x) != directionFacing) {
		
		//Pause And Decide Next Goal.
		idleTicks -= time;
		
		if (idleTicks < 0) {
			
			idleTicks = room_speed*random_range(2, 4);
			jumpingTicks = -1; //jump right away
			
			//Decide a spot to go to on the other side of my territory range
			var goalDir = random_range(0.5, sign(orgX - x + choose(1, -1))/2 + 0.5);	
			goToX = lerp(territoryXMin, territoryXMax, goalDir);
			directionFacing = sign(goToX - x);
		}
			
		
	} else {
		
		//DO a little hop towards the goal i want to go to
		if (onGround) {
			jumpingTicks -= time;
			if (jumpingTicks < 0) {
			
				jumpingTicks = room_speed*2;
				vSpeed = -2;
			
				var cD = sign(goToX - x);
				controlHSpeed = cD * hopSpeed;
				directionFacing = (cD != 0) ? cD : directionFacing;
		
				jumped = true;
		
			}
		} else {
			jumped = false;	
		}
	}


//Horizontal Motion
	//Friction
	var hFriction = (groundBelow != noone) ? groundBelow.traction		: airFrictionValue;
	var kbFriction= (groundBelow != noone) ? groundBelow.traction/3		: airFrictionValue;
	
	//Goal
	controlHSpeed = lerp(controlHSpeed, hSpeedGoal, hFriction);

	//Amount
	knockbackHSpeed = lerp(knockbackHSpeed, 0, kbFriction);
	hSpeed = round((controlHSpeed + knockbackHSpeed) * 10) / 10;

	
//Visuals Call
event_user(0);

enemy_generic_death_timer();

//Create Damage
if (timeSinceDamaged > room_speed) {
		//Create Damage
	if (!instance_exists(myDamage)) {
		var w = 8;
		myDamage = enemy_damage_create(-1, x-w/2, y-w/2, w, w, 3, 1);
		myDamage.addToHSpeed = hSpeed/4;
		myDamage.addToVSpeed = -1;
	}	
}