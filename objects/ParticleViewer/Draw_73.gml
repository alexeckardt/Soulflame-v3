/// @description 

var c = part_particles_count(noblendSys);
if (c > 0) {
	var h = 0;
}


//Draw Particles
gpu_set_blendmode(bm_normal);
surface_set_target(particleSurf);

	draw_clear_alpha(0,0);

	part_system_position(noblendSys, -Camera.x, -Camera.y);
	part_system_drawit(noblendSys);

surface_reset_target();
