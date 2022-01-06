// @desc
//
//Creates pathfinder.
//goal var is to be an array [x, y] or object to follow.
//
function pathfinder_floating_create(goal) {
	
	var obj = instance_create_depth(x, y, depth - 5, oPathfinderFloating);	
	
	//Get Position
	if (is_array(goal)) {
		obj.goingToPosition = true;
		obj.goToX = goal[0];
		obj.goToY = goal[1];
	} else {
		obj.objectFollowing = goal;	
	}
	
	obj.creator = id;
	
	return obj;
}