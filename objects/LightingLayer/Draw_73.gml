/// @description 

gpu_set_colorwriteenable(1,1,1,0);
gpu_set_blendmode_ext(bm_dest_alpha, bm_inv_dest_alpha);
draw_surface_ext(LightingLayer.lightLayerSurf, cX, cY, 1,1, 0, c_white, 1);	
gpu_set_blendmode(bm_normal);
gpu_set_colorwriteenable(1,1,1,1);