/// @description Draw As Particle

gpu_set_colorwriteenable(1, 1, 1, 0);

	draw_sprite_ext(sprite_index, 1, x, y,
						image_xscale, image_yscale, 0, 0, alp);
					
gpu_set_colorwriteenable(1, 1, 1, 1);
