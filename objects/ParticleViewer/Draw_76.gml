/// @description 

//Create and Clear Surfaces

var w = Camera.view_width;
var h = Camera.view_height;

if (!surface_exists(particleSurf)) {
	particleSurf = surface_create(w, h);	
}
surface_set_target(particleSurf);
	draw_clear_alpha(0, 0);
surface_reset_target();


if (!surface_exists(glowParticleSurf)) {
	glowParticleSurf = surface_create(w, h);	
}
surface_set_target(glowParticleSurf);
	draw_clear_alpha(0, 0);
surface_reset_target();