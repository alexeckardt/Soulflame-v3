// @desc
//
//
//
function particle_create_dust(x1, y1, x2, y2, amount) {

	if (Game.particleViewer.allowParticleSpawning) {

		//System
		var sys = Game.particleViewer.noblendSys;
	
		//Create Particle Type if DNE
		var key = "dust";
		particle_type_obj_setup(key, p_Dust);
		var type = particle_type_obj_get_type(key);
	
		//Update Emitter
		var emitter = Game.particleViewer.noblendEmitter;
		part_emitter_region(sys, emitter, x1, x2, y1, y2, 
								ps_shape_rectangle, ps_distr_linear);
		
		
		//Emit Particles
		part_emitter_burst(sys, emitter, type, amount);
		
	}
}