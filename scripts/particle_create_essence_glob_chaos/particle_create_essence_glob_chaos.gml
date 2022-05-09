// @desc
//
//
//
function particle_create_essence_glob_chaos(x1, y1, x2, y2, amount) {

	if (Game.particleController.allowParticleSpawning) {

		//System
		var sys = Game.particleController.noblendSys;
	
		//Create Particle Type if DNE
		var key = "essenceGlobC";
		particle_type_obj_setup(key, p_EssenceGlob_Chaos);
		var type = particle_type_obj_get_type(key);
	
		//Update Emitter
		var emitter = Game.particleController.noblendEmitter;
		part_emitter_region(sys, emitter, x1, x2, y1, y2, 
								ps_shape_rectangle, ps_distr_linear);
		
		//Emit Particles
		part_emitter_burst(sys, emitter, type, amount);
		
	}
}