/// @description 

var damageMeeting = instance_place(x, y, oDamage);

//Check Persistance
if (!checkedAlreadyDestroyed) {
	
	//Save
	checkedAlreadyDestroyed = true;
	
	//Destroy Self If Already
	var get = game_persistence_check(storename);
	if (!is_undefined(get)) {
		instance_destroy();
		exit;
	}
	
	//I have not been destroyed
	
	//Create Light
	myLight = instance_create_depth(x, y, Camera.lightDepth, oDecayableLight);
	myLight.colour = essence_get_colour_emission(essenceType);
	myLight.size = lightBaseSize;
	myLight.str = lightBaseStr;
}


//
//
//
if (damageMeeting != noone && Player.allowEssenceCollection) {
	
	//Chjeck If Player Damage
	if (damageMeeting.creator.object_index = oKeira) {
		
		if (!beingHit) {
		
			//Damage
			beingHit = true;
			hitsLeft--;
			
			//Shake
			shakeIntensity = onHitShakeSet;
		
			if (hitsLeft <= 0) {
		
				//Save To Game Map
				game_persistence_set(storename, true);
		
				//Give
				drop_essence(essenceToGive);
		
				//Create Particles
				particle_create_dust(bbox_left, bbox_bottom-5, bbox_right, bbox_bottom+5, 5);
				//if (potPartTypeSpr != undefined) {
				//	particle_create_frag(bbox_left, bbox_top, bbox_right, bbox_bottom+5, 8, potPartTypeSpr, partTypeKey);}
		
				//Destroy Light
				myLight.decay = true;
		
				//Destroy
				instance_destroy();
		
			} else {
			
				//Per Hit
				drop_essence(essenceGivePerHit);
				essenceToGive -= essenceGivePerHit;

			}
		
		}
		
	}
	
} else {
	beingHit = false;	
}

//Shake Dampen
shakeIntensity = lerp(shakeIntensity, 0, shakeReturnSpeed*Game.delta);

//Light
myLight.size = lerp(myLight.size, lightBaseSize, lightRetSpeed*Game.delta);
myLight.str = lerp(myLight.str, lightBaseStr, lightRetSpeed*Game.delta);

//
//Emit Randomly
if (random(100) < 3) {

	var sec = room_speed;

	var xx = irandom_range(bbox_left-10, bbox_right+10);
	var yy = irandom_range(bbox_top, bbox_bottom);
	var spd = random_range(0, 0.2);
	var life = irandom_range(0.2*sec, 1*sec);
			
	var c = essence_get_colour_emission(essenceType);
			
	var part = point_light_create(xx, yy, spd, 90, 20, life, c, 0);
	part.doGravity = false;
			
	part.spdIncrease = random_range(0, 0.03);
	part.spdAbsolute = true;

}
