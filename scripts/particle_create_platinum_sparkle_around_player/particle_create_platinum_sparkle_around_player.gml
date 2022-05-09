// @desc
//
//
//
function particle_create_platinum_sparkle_around_player(amount) {

	//Create Particle Type if DNE
	if (Game.particleController.allowParticleSpawning) {
		var key = "coin";
		var obj = particle_type_obj_setup(key, p_PlatinumSparkle);
	
		obj.sparklesToCreate += amount;
	}

}