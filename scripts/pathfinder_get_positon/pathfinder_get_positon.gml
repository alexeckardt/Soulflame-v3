// @desc
//
//
//
function pathfinder_get_positon(pathFinder, lengthFromPathStart) {

	if (instance_exists(pathFinder) && pathFinder != noone) {
		var p = pathFinder.myPath;
		
		if (path_exists(p)) {
			var pathLen = path_get_length(p);
		
			if (pathLen > 0) {
				
				var pathObjX, pathObjY;
				
				//Using Path
				if (!pathFinder.pathFailed) {
					var l = max(lengthFromPathStart, pathLen);
	
					//Percentage I Want
					var point = (lengthFromPathStart / l);
						point = clamp(point, 0, lengthFromPathStart);

					var pathObjX = path_get_x(p, point);
					var pathObjY = path_get_y(p, point);
				
				//Using Path Object Position If Path Failed
				} else {
					
					pathObjX = pathFinder.x;
					pathObjY = pathFinder.y;
					
				}
				
				var pathEndX = path_get_x(p, 1);
				var pathEndY = path_get_y(p, 1);
				return [pathObjX, pathObjY, pathEndX, pathEndY, true];
			}
		}
		
		//Calculate If I Didn't Above
		pathObjX = pathFinder.x;
		pathObjY = pathFinder.y;
		var pathEndX = path_get_x(p, 1);
		var pathEndY = path_get_y(p, 1);
			
		//PassBack
		return [pathObjX, pathObjY, pathEndX, pathEndY, false];
	}
	
	//No Pathfinder, Return Default Vlaues
	return [x, y, -1, -1, false];

}