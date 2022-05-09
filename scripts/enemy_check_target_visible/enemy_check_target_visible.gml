// @desc
//
//Checks if a target is visible, through LOS and through distance
//
function enemy_check_target_visible(targetObj = target, range = sightRange) {

	var obstructed = collision_line(x, y, target.x, target.y, Solid, false, true);
	
	if (obstructed) {
		obstructed = collision_line(x, y-2, target.x, target.y-5, Solid, false, true); }	

	return (point_distance(x, y, target.x, target.y) < range) 
		&& (!obstructed);

}