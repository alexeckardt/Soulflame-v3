// @desc
//
//
//
function particle_type_obj_exists(idKey) {

	var get = Game.particleViewer.particleTypeObjs[? idKey];
	if (!is_undefined(get)) {
		return instance_exists(get);
	}

	return false;

}