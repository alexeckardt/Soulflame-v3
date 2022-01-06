/// @description 

var time = Game.delta;

x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);

//Exit
if (point_distance(x, y, goToX, goToY) < 2)
|| (position_meeting(x, y, Solid))
|| (!instance_exists(creator))
|| (!goingToPosition && !instance_exists(objectFollowing))
{
	instance_destroy();	
	exit;
}

//
//
//Create Path
//
if (!createdPath) {
	
	//Clear Path
	if (path_exists(myPath)) {
		path_delete(myPath);
		
		//Reset
		myPath = path_add();
		pathFailed = true;
	}
	
	//Position Self
	x = creator.x;
	y = creator.y;
	
	//Distance Req
	var d = point_distance(x, y, goToX, goToY);
	if (d > 8) {
		
		//Create Path
		var pathMaker = mp_grid_path(Paths.grid, myPath, x, y, goToX, goToY, true);
		
		//Optimize (Don't have weird angles)
		
		//Path Exists?
		if (pathMaker) {
			createdPath = true;
	
			//If Path is not empty
			if (path_get_length(myPath) > 0) {
	
				//Start
				path_set_kind(myPath, 1);
				path_set_precision(myPath, 8);

				//Make Me Go Alittle
				path_start(myPath, 0, path_action_stop,	false);
				path_position = rangeTravel / path_get_length(myPath);
				
				//No Fail
				pathFailed = false;
			}
		} 
	}
}

drawX = lerp(drawX, x, 0.02*time);
drawY = lerp(drawY, y, 0.02*time);
