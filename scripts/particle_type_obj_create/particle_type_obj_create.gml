// @desc
//
//
//
function particle_type_obj_create(pObjId, key) {
	
	//Create
	var obj = instance_create_depth(x, y, 10, pObjId);
	
	//Save
	ParticleViewer.particleTypeObjs[? key] = obj;
	
	//Return
	return obj;
}