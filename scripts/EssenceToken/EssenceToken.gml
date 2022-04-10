//
//DESC:
//
//
//
function EssenceToken(_alignment) constructor {

	alignment = _alignment;
	percent = 0;
	
	sprite = essence_token_get_sprite(_alignment);
	animate = false;
	index = 0;
	
	markedAsDeleted = false;
	
	blendCol = essence_get_colour_bright(_alignment);
	blendPercent = 0;



	//Draw
	static draw = function(tokenxx, tokenyy) {
		
		//Colour
		var c = c_white;
		draw_sprite_ext(sprite, index, tokenxx, tokenyy, 1, 1, 0, c, 1);	
		
		//Draw Flash
		if (blendPercent >= 0.01) {
			blendPercent = lerp(blendPercent, 0, flashRecoverSpeed());
			
			gpu_set_blendmode(bm_add);
			gpu_set_fog(1, blendCol, 0, 0);
			draw_sprite_ext(sprite, index, tokenxx, tokenyy, 1, 1, 0, 0, blendPercent);
			gpu_set_fog(0,0,0,0);
			gpu_set_blendmode(bm_normal);
		}
	}
	
	//Decide A Recovery Speed
	static flashRecoverSpeed = function() {
		return (percent == 100) ? (0.05) : (0.3);};
	
	//Flash 50% at under 100; Full Flash at 100	
	static flash = function() {
		blendPercent = (percent == 100) ? 1 : 0.25;
	};

}