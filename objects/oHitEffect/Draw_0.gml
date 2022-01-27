/// @desc

if (surface_exists(surf)) {

	var surfX = x - sprite_xoffset;
	var surfY = y - sprite_yoffset;

	surface_set_target(surf);
		
		draw_clear_alpha(0, 0);
	
		if (sprite_index != -1) {
			draw_sprite_ext(sprite_index, image_index, x-surfX, y-surfY, 1, 1, angle, col, 1);
		}
	surface_reset_target();

	//Draw Surface
	draw_surface_ext(surf, surfX, surfY, 1, 1, 0, c_white, 1);

}