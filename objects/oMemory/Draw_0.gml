/// @desc

//Blend Properlly
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);
draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, alp);
draw_sprite_magic(sprite_index, image_index, x, y, 1, 1, 0, c_white, alp, 0);
gpu_set_blendmode(bm_normal);

