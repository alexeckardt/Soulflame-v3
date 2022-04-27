/// @description 



gpu_set_colorwriteenable(1,1,1,0);
gpu_set_blendmode_ext(bm_zero, bm_src_color);
shader_set(shd_shadsurf);
draw_surface_ext(LightingLayer.lightLayerSurf, cX, cY, 1,1, 0, c_white, ambientLighting);	
shader_reset();
gpu_set_blendmode(bm_normal);
gpu_set_colorwriteenable(1,1,1,1);