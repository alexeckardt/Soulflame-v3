/// @description Draw As Particle

var surf = ParticleViewer.particleSurf;

if (surface_exists(surf)) {

	surface_set_target(surf)
		draw_sprite_ext(sprite_index, 1, x-Camera.x, y-Camera.y,
							image_xscale, image_yscale, 0, 0, alp);
	surface_reset_target();

}
