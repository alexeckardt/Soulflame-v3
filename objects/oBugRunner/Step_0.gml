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

		
	//Switch State
	if (justDamaged && !dead) {
		STATE = state.base;	
	}
	
	if (STATE == state.base) {
		hSpeedGoal = 0;
		runSpeedReal = 0;
		
		var visibleTarget = enemy_check_target_visible();
		if (!seesTarget) {
	
			//Timer
			sinceSeenTarget += time;
	
			//See
			if (visibleTarget) {
				seesTarget = true;
				sinceSeenTarget = 0;
				lastSawTargetX = target.x;	
				lastSawTargetY = target.y;	
			}
		}
		
		
		if (seesTarget) {
			if (abs(y - target.y) < 32) {
				STATE = state.chase;	
				runWindUpTicksLeft = runWindUpTicks;
			}
		}
	}	

	
//Chase
if (STATE == state.chase) {

	runWindUpTicksLeft--;
	if (runWindUpTicksLeft < 0) {

		var visibleTarget = enemy_check_target_visible();
		if (visibleTarget) {
			if (abs(y - target.y) < 32) {
				lastSawTargetX = target.x;	
				lastSawTargetY = target.y;	
			
				directionFacing = sign(lastSawTargetX - x);
			}
		}
	
	
		//Run At 
		runDirection = sign(lastSawTargetX - x);

		//Speed
		var speedGoal = runSpeedGoal;


		//Stop If I'm close to where I last saw them but they are not there
		if (point_distance(x, y, lastSawTargetX, lastSawTargetY) < 10 || runDirection != directionFacing) {
	
			if (point_distance(x, y, target.x, target.y) > 20) {
		
				//Fast Break
				runSpeedReal /= 1.5;
				speedGoal = 0;
		
			}
	
			//Revert
			if (abs(runSpeedReal) < 0.01) {
			
				STATE = state.base;
				seesTarget = false;
			
			}
	
		}
		
		//Run
		runSpeedReal = lerp(runSpeedReal, speedGoal, 0.3*time);
		hSpeedGoal = lerp(hSpeedGoal, runDirection * runSpeedReal,  0.1*time); 
	
		//Bounce
		if (place_meeting(x+hSpeedGoal, y-10, Solid)) {
			
			STATE = state.base;
			controlHSpeed = -hSpeedGoal*0.7;
			hSpeedGoal = 0;
			vSpeed = -3;
			
		}
	
	
	}
}
	

//Horizontal Motion
	//Friction
	var hFriction = (groundBelow != noone) ? groundBelow.traction		: airFrictionValue;
	var kbFriction= (groundBelow != noone) ? groundBelow.traction/3	: airFrictionValue;
	
	//Goal
	controlHSpeed = lerp(controlHSpeed, hSpeedGoal, hFriction*time);

	//Amount
	knockbackHSpeed = lerp(knockbackHSpeed, 0, kbFriction);
	hSpeed = round((controlHSpeed + knockbackHSpeed) * 10) / 10;

	
//Visuals Call
event_user(0);

enemy_generic_death_timer();