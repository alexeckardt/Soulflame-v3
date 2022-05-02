// @desc
//
//
//
function keira_scarf_update_nodes() {

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