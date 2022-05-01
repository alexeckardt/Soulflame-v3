// @desc
//
//
//
function light_source_particle_light_create(xx, yy, spd, moveDir, moveDirVariance, life, startCol, endCol) {

	//Create
	var inst = instance_create_depth(xx, yy, 25, oSimpleParticleLight);
	inst.active = true;
	
	
	inst.spd = spd;
	inst.dir = moveDir + random_range(-moveDirVariance, moveDirVariance);
	
	inst.life = life;
	inst.startingLife = life;
	
	inst.startCol = startCol;
	inst.endCol = endCol;
	
	//Return
	return inst;

}