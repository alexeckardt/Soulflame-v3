// @desc
//
//
//
function cleanup_particle_type(type) { 

	if (part_type_exists(type)) {
		part_type_destroy(type);	
	}

}