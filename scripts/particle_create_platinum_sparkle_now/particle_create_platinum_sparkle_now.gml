// @desc
//
//
//
function particle_create_platinum_sparkle_now(x1, y1, x2, y2, amount) {

	//System
	if (Game.particleViewer.allowParticleSpawning) {
		
		var sys = Game.particleViewer.noblendSys;
	
		//Create Particle Type if DNE
		var key = "coin";
		particle_type_obj_setup(key, p_PlatinumSparkle);
		var type = particle_type_obj_get_type(key);
	
		//Update Emitter
		var emitter = Game.particleViewer.noblendEmitter;
		part_emitter_region(sys, emitter, x1, x2, y1, y2, 
								ps_shape_rectangle, ps_distr_linear);

		//Emit Particles
		part_emitter_burst(sys, emitter, type, amount);
		
		//Light Particles
			create_platinum_light_particles(1,x1,x2,y1,y2);
		
	}
	
}