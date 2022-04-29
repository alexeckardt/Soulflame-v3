// @desc
//
//
//
function essence_create_homing_object(_x, _y, _emissionRad, _count, _align, _target) {

	//Create Mana Shards that Fly To The Player
	randomize();
	repeat(_count) {
				
		var randX = _x + irandom_range(-_emissionRad, _emissionRad);
		var randY = _y + irandom_range(-_emissionRad, _emissionRad),
				
		var xxx = instance_create_depth(randX, randY, Camera.lightDepth, oManacule);
		xxx.align = lerp(_align, 0, random(0.2)); //80% - 100% of the algin col
		xxx.target = _target;
		
		xxx.colour = essence_get_colour_emission(xxx.align);
	}

}