// @desc
//
//Creates pathfinder.
//goal var is to be an array [x, y] or object to follow.
//
function pathfinder_create(airborne = true) {
	
	var obj = instance_create_depth(x, y, depth - 5, oPathFinderSegmentedPointer);	
	obj.creator = id;
	obj.airborne = airborne;
	
	return obj;
}