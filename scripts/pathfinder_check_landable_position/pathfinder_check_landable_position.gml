// @desc
//
//
//
function pathfinder_check_landable_position(xradius, yradius) {

	var path = pathFinder.myPath;
	

	var points = path_get_number(path);
	for (var i = 1; i < points; i++) {
	
		var pointX		= path_get_point_x(path, i);
		var pointY		= path_get_point_y(path, i);
		
		if (abs(pointX - x) < xradius) {
						
			//Check If On Ground (Landable)
			if (position_meeting(pointX, pointY + 16, Solid)) {
					
				if (abs(pointY - y) < yradius) {
				
					//Point is Good!
					return [pointX, pointY];
				
				}
			}
		}
	}
	
	return false;
}