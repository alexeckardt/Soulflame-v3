// @desc
//
//Returns the Sign position to a certian x position, based on the objects own x position.
//
function point_to_position(xpos) {
	return sign(floor(xpos - x));}