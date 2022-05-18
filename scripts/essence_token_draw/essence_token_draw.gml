//
//DESC:
//
//
//
function essence_token_draw(struct, tokenxx, tokenyy) {

	var flashAmount = essence_token_flashRecoverSpeed(struct);


	//Inside Struct
	with (struct) {

		//Colour
		var c = c_white;
		draw_sprite_ext(sprite, index, tokenxx, tokenyy, 1, 1, 0, c, 1);	
		
		//Draw Flash
		if (blendPercent >= 0.01) {
			blendPercent = lerp(blendPercent, 0, flashAmount);
			
			gpu_set_blendmode(bm_add);
			gpu_set_fog(1, blendCol, 0, 0);
			draw_sprite_ext(sprite, index, tokenxx, tokenyy, 1, 1, 0, 0, blendPercent);
			gpu_set_fog(0,0,0,0);
			gpu_set_blendmode(bm_normal);
		}
	
	}
	
	return 0;

}