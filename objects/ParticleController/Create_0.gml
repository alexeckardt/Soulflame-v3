/// @description 
noblendSys =	part_system_create();
				part_system_automatic_update(noblendSys, false);
		
noblendEmitter = part_emitter_create(noblendSys);

particleTypeObjs = ds_map_create();

allowParticleSpawning = true;