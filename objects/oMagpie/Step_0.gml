var time = Game.delta;

//Take Damage 
enemy_take_damage();

//Detection
if (!seesTarget) {
	//clear los	
}


//Pathfinding
if (seesTarget) {
	if (!instance_exists(pathFinder)) {
		var k = instance_nearest(x, y, oKeira);
		pathFinder = pathfinder_floating_create([lastSawPlayerX, lastSawPlayerY]);
		pathFinder.posYoffset = -10;
	}
}
//Pathfinder Exists Under This

var pos = get_pathfinder_positon(pathFinder, pathfinderRegenerateRange);
var pathX = pos[0];
var pathY = pos[1];
	
//Did path Fail?
if (pathFinder != noone) {
	
	lastSawPlayerX = pathFinder.goToX;
	lastSawPlayerY = pathFinder.goToY;
	
	//Regenerate Path
	if (point_distance(x, y, pathX, pathY) <= pathfinderRegenerateRange*4) {
		pathfinder_regenerate_path(pathFinder);	
	}
	
	//Stop
	if (pathFinder.pathFailed) {
		seesTarget = false;	
	}
	
}

//Move
	var goalDi = point_direction(x, y, pathX, pathY);
	var angleDiff = angle_difference(dirMoving, goalDi);
	dirMoving -= angleDiff * turningSpeed;

	var turnPercent = abs(angleDiff / 180);
	var spdTo = (1-turnPercent) * maxSpeed * (move);
	spd = lerp(spd, spdTo, 0.1);

	//Movement
	var hspd2 = lengthdir_x(spd, dirMoving);
	var vspd2 = lengthdir_y(spd, dirMoving);
	controlHSpeed = lerp(controlHSpeed, hspd2, 0.1);
	controlVSpeed = lerp(controlVSpeed, vspd2, 0.1);

	//Speed
	knockbackVSpeed = lerp(knockbackVSpeed, 0, knockbackSlide*time);
	knockbackHSpeed = lerp(knockbackHSpeed, 0, knockbackSlide*time);
	
	vSpeed = round((controlVSpeed + knockbackVSpeed) * 10) / 10;
	hSpeed = round((controlHSpeed + knockbackHSpeed) * 10) / 10;

//Collision
generic_collide_solid();
	
//Visuals Call
event_user(0);