// @desc
//
//
//
function cleanup_particle_sys(sys) { 

	if (part_system_exists(sys)) {
		part_system_destroy(sys);	
	}

}