/// @desc
draw_sprite_ext(sprite_index, image_index, floor(x), floor(y), directionFacing, 1, 0, c_white, image_alpha);

//Draw Holding
if (holdingDroppable) {
	
	var xx = floor(x + holdPickupXoffset*directionFacing);
	var yy = floor(y + holdPickupYoffset);
	
	//
	if (reloadIsABunfet) {
	
		//
		draw_sprite_ext(sBunfetIdle, 0, xx, yy, directionFacing, 1, 0, c_white, 1);
	
	} else {
		
		//Coin
		var ind = Game.timeInGame / 100;
		draw_sprite_ext(sPlatinumCoin, ind, xx, yy, 1, 1, 0, c_white, 1);
		
	}
	
}
