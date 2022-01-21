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


//Should Chase?
var createDamage = false;
		
	//Switch State
	if (justDamaged && !dead) {
		STATE = state.base;	
	}
	
	if (STATE == state.base) {
		hSpeedGoal = 0;
		controlHSpeed = 0;
		runSpeedReal = 0;
		
		var visibleTarget = enemy_check_target_visible();
		if (!seesTarget) {
	
			//See
			if (visibleTarget) {
				seesTarget = true;
				sinceSeenTarget = 0;
				lastSawTargetX = target.x;	
				lastSawTargetY = target.y;	
			}
		} else {
		
			//Timer
			sinceSeenTarget += time;
		
		}
		
		
		if (seesTarget && sinceSeenTarget > timeToNoticeTarget) {
			if (abs(y - target.y) < 32) {
				STATE = state.chase;	
				runWindUpTicksLeft = runWindUpTicks;
			}
		}
	}	

	
//Chase
if (STATE == state.chase) {

	//AA
	createDamage = true;
	
	var visibleTarget = enemy_check_target_visible();
	if (visibleTarget) {
		if (abs(y - target.y) < 32) {
			lastSawTargetX = target.x;	
			lastSawTargetY = target.y;	
			
			runDirection = sign(lastSawTargetX - x);
		}
	}
	

	runWindUpTicksLeft--;
	if (runWindUpTicksLeft < 0) {
		
		//Run At 
		var wantsToTurnAround = runDirection != goalRunDirection;
		goalRunDirection = sign(lastSawTargetX - x);

		//Speed
		var speedGoal = runSpeedGoal;
		
		//Stop If I'm close to where I last saw them but they are not there
		if (point_distance(x, y, lastSawTargetX, lastSawTargetY) < 10 || wantsToTurnAround) {
	
			STATE = state.breaking;

		}
		
		//
		runSpeedReal = lerp(runSpeedReal, speedGoal, 0.3*time);
		hSpeedGoal = lerp(hSpeedGoal, runDirection * runSpeedReal,  0.1*time); 
	
		//D Facing
		directionFacing = sign(hSpeedGoal) != 0 ? sign(hSpeedGoal) : directionFacing;
	
		//Bounce
		if (place_meeting(x+hSpeedGoal, y-10, Solid)) {
			
			STATE = state.base;
			controlHSpeed = -hSpeedGoal*0.7;
			hSpeedGoal = 0;
			vSpeed = -3;
			seesTarget = false;
			
		}
	}
}
	
if (STATE == state.breaking) {
		
	//Slow Down (But not really)
	runSpeedReal = 0;
	hSpeedGoal = lerp(hSpeedGoal, 0,  0.05*time); 
	
	createDamage = (abs(hSpeedGoal) > 1);
	
	//Revert State
	if (abs(hSpeedGoal) < 0.1) {
		STATE = state.base;
		seesTarget = false;	
	}	
	
	//Bounce
	if (place_meeting(x+hSpeedGoal, y-10, Solid)) {
			
		STATE = state.base;
		controlHSpeed = -hSpeedGoal*0.7;
		hSpeedGoal = 0;
		vSpeed = -3;
		seesTarget = false;
			
	}
}

//Create Damage
if (createDamage) {
	
	//Create Damage
	if (!instance_exists(myDamage)) {
		myDamage = enemy_damage_create(-1, x, y, 8, 8, 3, 2);
		myDamage.addToHSpeed = hSpeed;
		myDamage.addToVSpeed = -1;
	}	
}



//Horizontal Motion
	//Friction
	var hFriction = (groundBelow != noone) ? groundBelow.traction		: airFrictionValue;
	var kbFriction= (groundBelow != noone) ? groundBelow.traction/3	: airFrictionValue;
	
	//Goal
	if (dead) {
		controlHSpeed = 0;
		hSpeedGoal = 0;	}
	controlHSpeed = lerp(controlHSpeed, hSpeedGoal, hFriction*time);

	//Amount
	knockbackHSpeed = lerp(knockbackHSpeed, 0, kbFriction);
	hSpeed = round((controlHSpeed + knockbackHSpeed) * 10) / 10;
	
//Visuals Call
event_user(0);

enemy_generic_death_timer();