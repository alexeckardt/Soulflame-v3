// @desc
//
//
//
function particle_type_obj_setup(key, objId){
	
	//Create & Return
	if (!particle_type_obj_exists(key)) {
		return particle_type_obj_create(objId, key);
	}
	
	//Return If Exists
	return particle_type_obj_get_obj(key);
}