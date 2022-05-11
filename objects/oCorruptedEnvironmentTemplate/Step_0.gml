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
	}
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
