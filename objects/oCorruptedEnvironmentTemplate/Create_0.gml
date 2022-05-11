 /// @description 

overlaySprite = sCorruptedRootChaosOverlay;

depth = oKeira.depth + 5

checkedAlreadyDestroyed = false;

//name
storename = game_persistence_create_name_room_specific("essence_obj");

//Essence to Give
essenceType = -1;
essenceToGive = 100; //one full token

hitsLeft = 10;
beingHit = false;

essenceGivePerHit = 0; //decreases total per hit.

//Position	
bbox_w = (bbox_right - bbox_left) div 2;
bbox_h = (bbox_right - bbox_left) div 2;

//Shake

onHitShakeSet = 2;
shakeIntensity = 0;
shakeReturnSpeed = 0.1;
shakeAngleToo = true;


function drop_essence(_am) {

	//Give
	essence_token_add_percent(essenceType, _am);
	
	//Pop Off Manacules
	var manaculesToRelease = clamp(_am div 12, 0, 4) + choose(0, 0, 1);
	var r = (bbox_w + bbox_h) div 2
	essence_create_homing_object(x-sprite_xoffset + bbox_w, y-sprite_yoffset + bbox_h, r, manaculesToRelease, essenceType, oKeira.id);
	
	//Light Particles
	var partsToDrop = min((_am div 10) + 1, 10);
	repeat (partsToDrop) {

		var xx = irandom_range(bbox_left-10, bbox_right+10);
		var yy = irandom_range(bbox_top, bbox_bottom);
		var spd = random_range(0, 0.2);
		var life = irandom_range(126, 2134);
			
		var c = essence_get_colour_emission(essenceType);
			
		var part = point_light_create(xx, yy, spd, 90, 0, life, c, 0);
		part.doGravity = false;
			
		part.spdIncrease = random_range(0, 0.03);
		part.spdAbsolute = true;

	}

}
