var time = Game.delta;

//Take Damage 
enemy_take_damage();

if (justDamaged) {
	seesTarget = false;	
	spd = 0;
}


var visibleTarget = enemy_check_target_visible();

//Detection
if (!seesTarget) {
	
	//Check If Clear Line Of Sight
	if (visibleTarget) {
				 
		//Detect Time
		detectionTimeLeft -= time;

		//Detected for long enough
		if (detectionTimeLeft <= 0) {
			seesTarget = true;
			detectionTimeLeft = detectionTime;	
			
			lastSawTargetX = target.x + targetFollowOffsetX;
			lastSawTargetY = target.y + targetFollowOffsetY;
		}
				
//Reset Detection Times
	} else {
		detectionTimeLeft = detectionTime	
	}
}


//Pathfinding
var pathX = lastSawTargetX;
var pathY = lastSawTargetY;
if (seesTarget) {
	
	//Reset Ticks
	goHome = false;
	notSeesTargetTime = 0;
	
	//Create Path Finder
	if (point_distance(x, y, target.x, target.y) > pathfinderRegenerateRange*1.5) {
		
		//
		if (abs(x - xprevious) < 0.1 && abs(y - yprevious) < 0.1) {
			stuckTime += time;
			
			//Return Home
			if (stuckTime > room_speed*4) {
				stuckTime = 0;
				seesTarget = false;
			}
		} else {
			stuckTime = 0;	
		}
		
		if (!instance_exists(pathFinder)) {
			pathFinder = pathfinder_floating_create([lastSawTargetX, lastSawTargetY]);
		}
		
	}
	
	//Get Path Pos
	var pos = get_pathfinder_positon(pathFinder, pathfinderRegenerateRange);
	pathX = pos[0];
	pathY = pos[1];
	
} else {
	
	notSeesTargetTime += time;
	
	//Fly Home
	if (notSeesTargetTime > room_speed*3) {
		if (point_distance(x, y, orgX, orgY) > 10) {
			
			goHome = true;
			lastSawTargetX = orgX;	
			lastSawTargetY = orgY;	
			
			if (!instance_exists(pathFinder)) {
				pathFinder = pathfinder_floating_create([lastSawTargetX, lastSawTargetY]);
			}
			
			var pos = get_pathfinder_positon(pathFinder, pathfinderRegenerateRange);
			pathX = pos[0];
			pathY = pos[1];
	
			
		} else {
			goHome = false;	
		}
	}
	
	
}
//Pathfinder Exists Under This

	
//Did path Fail?
var goalSpd = 0;
if (pathFinder != noone) {
	
	//Update Goal Pos
		//Give Extra Time
		inferPathTimeLeft -= time;
		if (enemy_check_target_visible(target, sightRange*1.5) || goHome) {
			inferPathTimeLeft = inferPathTime;	}
	
		//Actually Update Goal Pos
		if (inferPathTimeLeft > 0) {
			
			if (!goHome) {
				lastSawTargetX = target.x + targetFollowOffsetX;
				lastSawTargetY = target.y + targetFollowOffsetY;
			} else {
				lastSawTargetX = orgX;	
				lastSawTargetY = orgY;	
				pathX = orgX;
				pathY = orgY;
				goalSpd = maxSpeed/2;
			}
			
		}
	
	
	//Regenerate Path
	pathFinderRegenerationTimeLeft -= time;
	if (pathFinderRegenerationTimeLeft < 0) {
		pathFinderRegenerationTimeLeft = pathFinderRegenerationRate;
		pathfinder_regenerate_path(pathFinder, [lastSawTargetX, lastSawTargetY]);	
	}
	
	//Stop Path if I reached End
	if (instance_exists(pathFinder)) {
		if (pathFinder.pathFailed) {
			seesTarget = false;	
		} else {
			goalSpd = maxSpeed;	
		}
	}
}

//Move
	var goalDi = point_direction(x, y, pathX, pathY);
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