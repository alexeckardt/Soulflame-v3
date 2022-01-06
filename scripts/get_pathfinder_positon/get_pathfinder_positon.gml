// @desc
//
//
//
function get_pathfinder_positon(argument0, argument1) {

	if (instance_exists(argument0) && argument0 != -1) {
		var p = argument0.myPath;
		
		if (path_exists(p)) {
			var pathLen = path_get_length(p);
		
			if (pathLen > 0) {
				
				var pathObjX, pathObjY;
				
				//Using Path
				if (!argument0.pathFailed) {
					var l = max(argument1, pathLen);
	
					//Percentage I Want
					var point = (argument1 / l);
						point = clamp(point, 0, argument1);

					var pathObjX = path_get_x(p, point);
					var pathObjY = path_get_y(p, point);
				
				//Using Path Object Position If Path Failed
				} else {
					
					pathObjX = argument0.x;
					pathObjY = argument0.y;
					
				}
				
				var pathEndX = path_get_x(p, 1);
				var pathEndY = path_get_y(p, 1);
				return [pathObjX, pathObjY, pathEndX, pathEndY];
			}
		}
		
		//Calculate If I Didn't Above
		pathObjX = argument0.x;
		pathObjY = argument0.y;
		var pathEndX = path_get_x(p, 1);
		var pathEndY = path_get_y(p, 1);
	
		//PassBack
		return [pathObjX, pathObjY, pathEndX, pathEndY];
	}
	
	//No Pathfinder, Return Default Vlaues
	return [x, y, -1, -1];

}