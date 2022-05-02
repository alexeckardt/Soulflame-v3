// @desc
//
//
//
function keira_scarf_update_nodes() {

	//Decide Fall Direction
	var maxVel = 10;
	var velocity = min(maxVel, point_distance(hSpeed, vSpeed, 0, 0));
	var movingDir = point_direction(hSpeed, vSpeed, 0, 0);
	
	//Switch Dir
	scarfFallDirection += angle_difference(scarfFallRestDirection, scarfFallDirection) / 20;
	scarfFallDirection += angle_difference(movingDir, scarfFallDirection) * (velocity/maxVel)

	var list = scarfNodes;
	
	//ReConstruct List
	if (ds_list_size(list) != scarfLength) {}
	
	//Parse
	
	var lastX = x + scarfMainOffsetX;
	var lastY = y + scarfMainOffsetY;
	
	for (var i = 0; i < scarfLength; i++) {
		
		//Grab
		var node = list[| i];

		//Update
		node.update_spread(scarfNodeSep, scarfFallDirection);
		
		//Move
		node.update_pos(lastX, lastY);
	
		//Get for next Cycle
		lastX = node.xx;
		lastY = node.yy;
	}


}