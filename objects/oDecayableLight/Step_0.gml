/// @description
if (decay) {
	colour = merge_colour(colour, c_black, decaySpeed*Game.delta); 	
	colPofOriginal = lerp(colPofOriginal, 0, decaySpeed*Game.delta);
	
	if (colPofOriginal < 0.001) {
		instance_destroy();
	}	
}
