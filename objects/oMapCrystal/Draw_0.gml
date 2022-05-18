/// @desc

if (fireOn) {
	
	
	
} else {
	
//Blend Properlly
gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);
draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, c_white, alp);
gpu_set_blendmode(bm_normal);
	
}
