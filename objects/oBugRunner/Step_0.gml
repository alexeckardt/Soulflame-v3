
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
vSpeed += myGrav*time;


//Should Chase?
var createDamage = false;
		
//Base S
if (STATE == state.base) {
	hSpeedGoal = 0;
	controlHSpeed = 0;
	runSpeedReal = 0;
		
	var visibleTarget = enemy_check_target_visible();
	if (!seesTarget) {
	
		//See
		enemy_generic_update_see_target();
	
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
			
			goalRunDirection = sign(lastSawTargetX - x);
		}
	}
	
	//Running After Winding Up
	runWindUpTicksLeft--;
	if (runWindUpTicksLeft < 0) {
		
		//Now Running Actually
	
		//Run At 
		var wantsToTurnAround = runDirection != goalRunDirection;
		
		//Speed
		var speedGoal = runSpeedGoal;
		
		//Stop If I'm close to where I last saw them but they are not there
		if (point_distance(x, y, lastSawTargetX, lastSawTargetY) > 10 && wantsToTurnAround) {
			STATE = state.breaking;
		}
		
		//
		runSpeedReal = lerp(runSpeedReal, speedGoal, 0.3*time);
		hSpeedGoal = lerp(hSpeedGoal, runDirection * runSpeedReal,  0.1*time); 
	
		//D Facing
		directionFacing = sign(hSpeedGoal) != 0 ? sign(hSpeedGoal) : directionFacing;
	
		//Bounce
		if (abs(hSpeedGoal) > 1) {
			if (place_meeting(x+hSpeedGoal, y-10, Solid)) {
				
				bug_runner_bounce();
			
			}
		}
		
		//Damage Bounce Back
		if (justDamaged) {
			STATE = state.breaking;
			controlHSpeed = -hSpeed * 0.2; //0.2 energy coeff
			hSpeedGoal = controlHSpeed;
			
			hSpeed = controlHSpeed;
			vSpeed = -2;
		}
		
	} else {
	
		//Decide the direction I want to run in
		runDirection = goalRunDirection;
		directionFacing = runDirection;
	
	}
}
	
if (STATE == state.breaking) {
		
	//Slow Down (But not really)
	runSpeedReal = 0;
	createDamage = false;
	
	//Revert State
	if (onGround) {
		hSpeedGoal = lerp(hSpeedGoal, 0,  breakSpeed*time); 
		
		if (abs(hSpeedGoal) < 0.01) {
			STATE = state.base;
			seesTarget = false;	
		}	
	}
	
	//Bounce
	if (place_meeting(x+hSpeedGoal, y-10, Solid)) {	
		bug_runner_bounce();	
	}
}

if (STATE == state.bounce) {
		
	//Slow Down (But not really)
	runSpeedReal = 0;
	createDamage = 0;
	
	if (onGround) {
		hSpeedGoal = lerp(hSpeedGoal, 0,  0.05*time); 
	
		//Revert State
		if (abs(hSpeedGoal) < 0.01) {
			STATE = state.base;
			seesTarget = false;	
		}	
	}
	
	//Bounce
	if (place_meeting(x+hSpeedGoal, y-10, Solid)) {	
		bug_runner_bounce();	
	}
}

//Create Damage
if (createDamage) {
	
	//Create Damage
	if (noDamageAfterHurtTicksLeft <= 0) {
		if (!instance_exists(myDamage)) {
			
			var w = 12;
			myDamage = enemy_damage_create(-1, x-w/2, y-w/2, w, w, 2, 0);
			myDamage.addToHSpeed = hSpeed*1.5;
			myDamage.addToVSpeed = -4;
			
		}	
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
	knockbackHSpeed = lerp(knockbackHSpeed, 0, kbFriction*time);
	hSpeed = round((controlHSpeed + knockbackHSpeed) * 10) / 10;
	
//Visuals Call
event_user(0);

//Spikes
enemy_hit_spikes();

enemy_generic_death_timer();