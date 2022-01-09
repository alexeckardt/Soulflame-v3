/// @description 

particleSurf = -1;
glowParticleSurf = -1;

noblendSys =	part_system_create();
				part_system_automatic_draw(noblendSys, false);
			
noblendEmitter = part_emitter_create(noblendSys);

particleTypeObjs = ds_map_create();