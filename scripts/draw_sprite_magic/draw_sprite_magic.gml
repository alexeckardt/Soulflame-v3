// @desc
//
//SHOULD EVENTUALLY BE REPLACED WITH SHADER
//
function draw_sprite_magic(spr, ind, xx, yy, xs, ys, rot, blend, alp, CorruptAlpha) {

	var z = Camera.zoom;
	var surfX = (Camera.x);
	var surfY = (Camera.y);
	var xxx = (xx-surfX)*z
	var yyy = (yy-surfY)*z;
	
	surface_set_target(Camera.fireSurf);
	
	draw_sprite_ext(spr, ind, xxx, yyy, xs*z, ys*z, rot, blend, alp);
	
	surface_reset_target();
	
	//Draw Soul
	/*
	gpu_set_blendmode(bm_normal);
	draw_sprite_ext(spr, ind, xxx, yyy, xs, ys, rot, blend, alp*0.4);
	

	gpu_set_blendmode(bm_add);
		draw_sprite_ext(spr, ind, xxx, yyy, xs, ys, rot, c_gray,	CorruptAlpha*0.4);
		gpu_set_colorwriteenable(1, 1, 1, 0);
		draw_sprite_ext(spr, ind, xxx, yyy, xs, ys, rot, blend,	alp);
		draw_sprite_ext(spr, ind, xxx, yyy, xs, ys, rot, blend,	alp);		
		gpu_set_colorwriteenable(1, 1, 1, 1);
	gpu_set_blendmode(bm_normal);

*/
}