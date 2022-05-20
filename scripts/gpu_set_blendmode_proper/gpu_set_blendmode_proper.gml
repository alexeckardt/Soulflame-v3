//
//DESC:
//
//Sets the blendmode for correct alpha blending
//
function gpu_set_blendmode_proper() {
	gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);
}