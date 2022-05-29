
//
//Delta
var time = Game.delta;
var k = instance_nearest(x, y, oKeira);
var visibleTarget = false;

//Take Damage 
enemy_take_damage();

if (justDamaged) {
	seesTarget = false;	
	damageResetTicksLeft = max(damageResetTicksLeft, damageResetTicksOnHit); //don't damage player
	spd = 0;}
	
//
//
//Begin Chase Target?
if (STATE == state.base) {
	
	//Infer Time Path
	inferPathTimeLeft -= time;
	
	//Check Target Visible
	visibleTarget = enemy_check_target_visible(target, sightRange, PathfindVisible);
	if (!seesTarget) {
		
		//Timer
		sinceSeenTarget += time;

		//See & Reccognize
		if (visibleTarget) {
			seesTarget = true;
			sinceSeenTarget = 0;
			inferPathTimeLeft = inferPathTime;	
			goingToOrbit = false;
			reachedEndOfPath = false
		}
	} else {
		//Chase Target
		inferPathTimeLeft = inferPathTime;	
	}
	
	//End Term Goal Position
	var EndGoalX = lastSawTargetX;
	var EndGoalY = lastSawTargetY;

	//
	//
	//
	goalSpd = 0;

	//Actually Update Goal Pos
	if (inferPathTimeLeft > 0) {
			
		//Update Taarget Position; If not force fail path
		if (!collision_line(x, y, target.x, target.y, PathfindVisible, 1, false) 
		&& !position_meeting(target.x, target.y, PathfindVisible)) {
			lastSawTargetX = target.x;
			lastSawTargetY = target.y;	
		}
			
		//Set
		EndGoalX	= lastSawTargetX;
		EndGoalY	= lastSawTargetY;
		
		//Speed Chasing Player
		goalSpd = maxSpeed;
		
		//
		//Stop Moveing; I'm There.
		if (pathFinder.atEndOfPath) {
			goalSpd	= 0;
		}
	}
		
	//
	//
	//
		
	//Player Unreachable
	if (!visibleTarget && !goingToOrbit) {

		//Continue towards Goal
		EndGoalX	= lastSawTargetX;
		EndGoalY	= lastSawTargetY;
		goalSpd		= minSpeed;
		
		//Check if At last saw player pos
		var d = point_distance(x, y, lastSawTargetX, lastSawTargetY);
		if ((d < maxSpeed*3 + sinceSeenTarget/5) || reachedEndOfPath) {
			
			//Pause + Slow down; Lost track of player (or player unnreachable)
			goalSpd	= 0;
			spd /= 2;
			reachedEndOfPath = true;
			
			//Timer until go Home
			if (sinceSeenTarget > room_speed * 3) {
					
					//Go Home
					EndGoalX	= orbitX;
					EndGoalY	= orbitY;
					goalSpd		= maxSpeed;
					
					goingToOrbit = true;
			
			}
			
		}

	}
	
	//
	if (goingToOrbit) {
		EndGoalX	= orbitX;
		EndGoalY	= orbitY;
		goalSpd		= maxSpeed;
	}
		
	//Create Path To Position
	pathfinder_generate_path(pathFinder, [EndGoalX, EndGoalY]);

	//Error! Go Directly Above player
	if (pathFinder.pathFailed) {
		targetFollowOffsetX = 0;
		targetFollowOffsetY = 0;
		
		seesTarget = false;
	}

	//End of Base State
}
	
//Dead States
if (STATE == state.dead) {
	knockbackVSpeed = lerp(knockbackVSpeed, 0, knockbackSlide/3*time);
	knockbackHSpeed = lerp(knockbackHSpeed, 0, knockbackSlide/3*time);
	vSpeed = round((knockbackVSpeed) * 10) / 10;
	hSpeed = round((knockbackHSpeed) * 10) / 10;	
}

enemy_generic_death_timer();

//Spikes
enemy_hit_spikes();
	
//Visuals Call
event_user(0);

//
//
//Move

//Get The Pointer Position which will lead me to the goal.
var p = pathfinder_get_positon(pathFinder, pathfinderRegenerateRange);
var pointerX = p[0];
var pointerY = p[1];
var pathSuccess = p[4];
var turnSpeed = turningSpeed;

//Correct Path If Failed
if (!pathSuccess) {
	turnSpeed /= 2;
	pointerX = lastSawTargetX;
	pointerY = lastSawTargetY;
	
	//Set
	seesTarget = false;
}


//Orbit
if (goingToOrbit) {
	if (point_distance(x, y, orbitX, orbitY) < 40 && !visibleTarget) { //eyeball;
		goalSpd = maxSpeed;
		turnSpeed /= 3;
	}
}


//Move

	//Check If Space ahead is free
	var xahead = x + lengthdir_x(spd*2, dirMoving);
	var yahead = y + lengthdir_y(spd*2, dirMoving);
	var shouldNotMoveForward = position_meeting(xahead, yahead, PathfindVisible);
	//If Not free, modify
	goalSpd /= 1 + shouldNotMoveForward;
	turnSpeed += turningSpeed * 0.75 * shouldNotMoveForward

	//Change Direction
	var swayDirOff = sin(Game.inGameTicks / 12) * 60;	
	var goalDi = point_direction(x, y, pointerX, pointerY) + swayDirOff;
	var angleDiff = angle_difference(dirMoving, goalDi);
	dirMoving -= angleDiff * turnSpeed * time;

	//Speed
	var turnPercent = abs(angleDiff / 180);
	var spdTo = (1-turnSpeed) * goalSpd;
	spd = lerp(spd, spdTo, 0.2*time);

	//Movement
	var hspd2 = lengthdir_x(spd, dirMoving);
	var vspd2 = lengthdir_y(spd, dirMoving);
	controlHSpeed = lerp(controlHSpeed, hspd2, 0.2*time);
	controlVSpeed = lerp(controlVSpeed, vspd2, 0.2*time);

	//Speed
	knockbackVSpeed = lerp(knockbackVSpeed, 0, knockbackSlide*time);
	knockbackHSpeed = lerp(knockbackHSpeed, 0, knockbackSlide*time);
	
	vSpeed = round((controlVSpeed + knockbackVSpeed) * 10) / 10;
	hSpeed = round((controlHSpeed + knockbackHSpeed) * 10) / 10;

	directionFacing = (controlHSpeed != 0) ? sign(controlHSpeed) : directionFacing;

//Speed
var index_speed_goal = 0.2*(spd / maxSpeed) + 0.1
index_speed = lerp(index_speed, index_speed_goal, 0.1*time);

//Create Damage
damageResetTicksLeft--;
if (damageResetTicksLeft < 0) {
	if (!instance_exists(myDamage)) {
			
		var w = 12;
		var h = 12;
		myDamage = enemy_damage_create(-1, x-w/2, y-h/2, w, h, 2, 1);
		myDamage.canDamageEnemies = false; //don't damage Bunfets

	}	
}
//Reset Timer
if (justDamagedTarget) {
	damageResetTicksLeft = damageResetTicksOnDamageTarget;	
}

//No Collide
generic_collide_solid();

//
//Nodes Update
event_user(1);

