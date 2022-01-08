// @desc
//
//
//
function part_dust_create(x1, y1, x2, y2, amount) {

	//System
	var sys = ParticleViewer.noblendSys;
	
	//Create Particle Type if DNE
	var type
	if (!instance_exists(p_Dust)) {
		ParticleViewer.dustType = instance_create_depth(x, y, 10, p_Dust);}
	type = ParticleViewer.dustType.part_type;
	
	//Update Emitter
	var emitter = ParticleViewer.noblendEmitter;
	part_emitter_region(sys, emitter, x1, x2, y1, y2, 
							ps_shape_rectangle, ps_distr_linear);
		
		
	//Emit Particles
	part_emitter_burst(sys, emitter, type, amount);
	
}