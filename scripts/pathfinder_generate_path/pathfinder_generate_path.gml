// @desc
//
//Calls the pathfinder to generate the path.
//Activates the Pathfinder if not already.
//
function pathfinder_generate_path(pathFinder, goal = target) {

	pathFinder.createdPath = false;
	pathFinder.active = true;

	//Path Goal Position
	if (!is_undefined(goal)) {
		if (is_array(goal)) {
			pathFinder.goingToPosition = true;
			pathFinder.goToX = goal[0];
			pathFinder.goToY = goal[1];
		} else {
			pathFinder.goingToPosition = false;
			pathFinder.objectFollowing = goal;	
		}
	}

}