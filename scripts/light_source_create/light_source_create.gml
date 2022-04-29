// @desc
//
//
//
function light_source_create(xx, yy, _active) {
	
	//Create
	var inst = instance_create_depth(xx, yy, 25, Light);
	inst.active = _active;
	
	return inst;
}