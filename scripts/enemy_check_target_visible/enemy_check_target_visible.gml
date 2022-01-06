// @desc
//
//Checks if a target is visible, through LOS and through distance
//
function enemy_check_target_visible(targetObj = target, range = sightRange) {

	return (point_distance(x, y, target.x, target.y) < range) 
		&& (!collision_line(x, y, target.x, target.y, Solid, false, true));

}