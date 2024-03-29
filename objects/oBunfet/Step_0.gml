
//Take Damage 
enemy_take_damage();

ramp_behaviour()

//Collision
lastVspeed = vSpeed;
generic_collide_solid();

//(Vertical Motion)
	if (knockbackVSpeed != 0) {
		vSpeed += knockbackVSpeed;
		knockbackVSpeed = 0;
	}
	//Gravity
	vSpeed += myGrav*time;


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
			
			if (!showHurt) {
			
				//Stop dealing damage if was (dropped from Magpie)
				if (!dropped) {
				
					shouldDealDamage = false;
				
					jumpingTicks -= time;
					if (jumpingTicks < 0) {
			
						jumpingTicks = room_speed*2;
						vSpeed = -2;
			
						var cD = sign(goToX - x);
						controlHSpeed = cD * hopSpeed;
						directionFacing = (cD != 0) ? cD : directionFacing;
		
						jumped = true;
		
					}
				
				//
				//Land after Drop
				} else {
			
					vSpeed = -4;
					dropped = false;
					showHurt = true;
				
				}
			
			} else {
			
				//Reset; Exit Dropped Loop
				showHurt = false;
				shouldDealDamage = false;
				dropped = false;
				jumpingTicks = room_speed*2;
				
				sprite_index = idleSprite;
				image_index = 0;
				index_speed = 0.05;
				
				vSpeed = -2;
				
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

//Spikes
enemy_hit_spikes();


//Fall
if (shouldDealDamage) {

	//Create Damage
	if (!instance_exists(myDamage) || myDamage == noone) {
		myDamage = damage_create_ext(damage_type.untyped, 1, x, y, 16, 16);
		myDamage.canDamageEnemies = false;
	}
		
	//Don't Take Damage
	invulnerableTicks = 2;
		
} else {
	
	//Destroy Damage
	if (instance_exists(myDamage)) {
		instance_destroy(myDamage);	
	}
	
}
