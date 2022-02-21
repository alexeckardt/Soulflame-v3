/// @description Draw As Particle

var surf = ParticleViewer.particleSurf;

if (surface_exists(surf)) {

	surface_set_target(surf)
		draw_sprite_ext(sprite_index, image_index, x-Camera.x, y-Camera.y,
							image_xscale, image_yscale, image_angle, image_blend, 1);
	surface_reset_target();


}
