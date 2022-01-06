// @desc
//
//
//
function pathfinder_regenerate_path(pathfinderId, newTarget) {

	if (instance_exists(pathfinderId)) {
		
		pathfinderId.createdPath = false;

		//Path Goal Position
		if (!is_undefined(newTarget)) {
			if (is_array(newTarget)) {
				pathfinderId.goingToPosition = true;
				pathfinderId.goToX = newTarget[0];
				pathfinderId.goToY = newTarget[1];
			} else {
				pathfinderId.goingToPosition = false;
				pathfinderId.objectFollowing = newTarget;	
			}
		}
		
	} else {
		
		//DNE
		pathfinderId = noone;
		
	}
}