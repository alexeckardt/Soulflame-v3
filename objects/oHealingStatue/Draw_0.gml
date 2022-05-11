/// @description 

//Draw
draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_white, 1);

//Draw Overlay
gpu_set_colorwriteenable(1,1,1,0);
draw_sprite_ext(sprite_index, 1, x, y, 1, 1, 0, c_white, 1*glowAlpha);

//Draw Overlay
var b = merge_colour(c_black, c_gray, (sin(current_time / 1200)*0.1 + 0.3));
gpu_set_blendmode(bm_add);
shader_set(shdEssenceMagic);
	draw_sprite_ext(sprite_index, 2, x, y, 1, 1, 0, b, glowAlpha);
shader_reset();
gpu_set_blendmode(bm_normal);
gpu_set_colorwriteenable(1,1,1,1);
