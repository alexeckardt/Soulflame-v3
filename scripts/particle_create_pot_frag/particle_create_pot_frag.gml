// @desc
//
//
//
function particle_create_pot_frag(x1, y1, x2, y2, amount, spr, key) {

	//System
	var sys = Game.particleViewer.noblendSys;
	
	//Setup Obj
	var obj = particle_type_obj_get_obj(key);
		
		//Create & Save
		if (obj == undefined) {
			obj = particle_type_obj_create(p_PotFragments, key);
			
			//Modify The Type Based on Parameters
			part_type_sprite(obj.part_type, spr, false, false, true);
		}

	//Get Type
	var type = particle_type_obj_get_type(key);
	

	
	
	//
	//Update Emitter
	var emitter = Game.particleViewer.noblendEmitter;
	part_emitter_region(sys, emitter, x1, x2, y1, y2, 
							ps_shape_rectangle, ps_distr_linear);
		
	//
	//Emit Particles
	part_emitter_burst(sys, emitter, type, amount);
	
}