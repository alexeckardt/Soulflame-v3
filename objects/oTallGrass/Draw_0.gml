/// @description Draw As Particle

draw_sprite_ext(sprite_index, image_index, x, y,
							image_xscale, image_yscale, image_angle, image_blend, 1);
							
/*
var surf = particleController.particleSurf;

if (surface_exists(surf)) {

	surface_set_target(surf)
		draw_sprite_ext(sprite_index, image_index, x-Camera.x, y-Camera.y,
							image_xscale, image_yscale, image_angle, image_blend, 1);
	surface_reset_target();


}
