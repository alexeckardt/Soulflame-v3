var time = Game.delta;

//Take Damage 
enemy_take_damage();

ramp_behaviour();

//Collision
generic_collide_solid();

//(Vertical Motion)
	if (knockbackVSpeed != 0) {
		vSpeed += knockbackVSpeed;
		knockbackVSpeed = 0;
	}
	//Gravity
	vSpeed += myGrav;

//Horizontal Motion
	//Friction
	var hFriction = (groundBelow != noone) ? groundBelow.traction		: airFrictionValue;
	var kbFriction= (groundBelow != noone) ? groundBelow.traction/3	: airFrictionValue;
	
	//Goal
	controlHSpeed = lerp(controlHSpeed, hSpeedGoal, hFriction);

	//Amount
	knockbackHSpeed = lerp(knockbackHSpeed, 0, kbFriction);
	hSpeed = round((controlHSpeed + knockbackHSpeed) * 10) / 10;

	
//Visuals Call
event_user(0);

enemy_generic_death_timer();

