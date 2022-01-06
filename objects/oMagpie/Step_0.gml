var time = Game.delta;
var k = instance_nearest(x, y, oKeira);

//Take Damage 
enemy_take_damage();
if (justDamaged) {
	seesTarget = false;	
	spd = 0;}


//
//
//Begin Chase Target?
var visibleTarget = enemy_check_target_visible();
if (!seesTarget) {
	
	//Timer
	sinceSeenTarget += time;
	
	//See
	if (visibleTarget) {
		seesTarget = true;
		sinceSeenTarget = 0;
	}
}

//Decide Where To Go (Home, Player, Lemming)

	//Check Target Visible
	var playerIsTarget = target == k;

	//End Term Goal Position
	var EndGoalX = lastSawTargetX;
	var EndGoalY = lastSawTargetY;
	
	//Speed; Move by def
	var goalSpd = maxSpeed;
	
	//Check
	if (seesTarget) {
	
		//Don't Return Home

		//Infer Time Path
		inferPathTimeLeft -= time;
		if (enemy_check_target_visible(target, sightRange*1.5)) {
			inferPathTimeLeft = inferPathTime;}
	
		//Actually Update Goal Pos
		if (inferPathTimeLeft > 0) {
			
			//Clarify
			visibleTarget = true;
			
			//Update Taarget Position
			lastSawTargetX = target.x + targetFollowOffsetX;
			lastSawTargetY = target.y + targetFollowOffsetY;
			
			//Set
			EndGoalX	= lastSawTargetX;
			EndGoalY	= lastSawTargetY;
				
			//Lemming
			
			//Stop Moveing; I'm There.
			if (pathFinder.atEndOfPath) {
				goalSpd	= 0;
			}
		}
		
		
		//Don't Know Where Player Is.
		if (!visibleTarget) {
			if (pathFinder.atEndOfPath) {
				seesTarget = false;
				goalSpd	= 0;
			}
		}
		
		
	} else {
		
		//Reached End Of Path
		goalSpd	= 0;
		 
		//Timer until go Home
		if (sinceSeenTarget > room_speed * 5) {
			
			if (point_distance(x, y, orgX, orgY) > 5) {
				//Go Home
				EndGoalX	= orgX;
				EndGoalY	= orgY;
				goalSpd		= maxSpeed / 2;
				
				lastSawTargetX = orgX;
				lastSawTargetY = orgY;
			
				//Reset My Goal Pos Based on Player
				targetFollowOffsetX = irandom_range(10, 30)*choose(1, -1);
				targetFollowOffsetY = -30;
			}
			
		}

	}


//Create Path To Position
pathfinder_generate_path(pathFinder, [EndGoalX, EndGoalY]);

//Error! Go Directly Above player
if (pathFinder.pathFailed) {
	targetFollowOffsetX = 0;
	targetFollowOffsetY = -10;
}



//Get The Pointer Position which will lead me to the goal.
var p = pathfinder_get_positon(pathFinder, pathfinderRegenerateRange);
var pointerX = p[0];
var pointerY = p[1];



//Move
	var goalDi = point_direction(x, y, pointerX, pointerY);
	var angleDiff = angle_difference(dirMoving, goalDi);
	dirMoving -= angleDiff * turningSpeed * time;

	var turnPercent = abs(angleDiff / 180);
	var spdTo = (1-turnPercent) * goalSpd * (move);
	spd = lerp(spd, spdTo, 0.3*time);

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

//Collision
generic_collide_solid();
	
//Visuals Call
event_user(0);


//Speed
var index_speed_goal = (seesTarget) ? 0.5: 0.1;
index_speed = lerp(index_speed, index_speed_goal, 0.1*time);