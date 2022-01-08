// @desc
//
//
//
function cleanup_particle_emitter(sys, emit) { 

	if (part_system_exists(sys)) {
		if (part_emitter_exists(sys, emit)) {
			part_emitter_destroy(sys, emit);	
		}
	}

}