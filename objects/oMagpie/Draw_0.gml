/// @desc
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), directionFacing, 1, 0, c_white, image_alpha);

//Draw Holding
if (holdingDroppable) {
	
	var xx = floor(x + holdPickupXoffset*directionFacing);
	var yy = floor(y + holdPickupYoffset);
	
	//
	if (reloadIsABunfet) {
	
		//
		var ind = Game.inGameTicks / 10;
		draw_sprite_ext(sBunfetSquirm, ind, xx, yy, directionFacing, 1, 0, c_white, 1);
	
	} else {
		
		//Coin
		var ind = Game.inGameTicks / 10;
		draw_sprite_ext(coinHoldingSprite, ind, xx, yy, 1, 1, 0, c_white, 1);
		
	}
	
}
