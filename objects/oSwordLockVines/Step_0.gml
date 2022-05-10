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
//Destroy
if (damageMeeting != noone) {
	
	//Chjeck If Player Damage
	if (damageMeeting.creator.object_index = oKeira) {
		
		var k = damageMeeting.creator;
		
		if (Player.weaponUsing == weapon.sword) {
			
			//Save To Game Map
			game_persistence_set(storename, true);
		
			//Create Particles
			particle_create_dust(bbox_left, bbox_bottom-5, bbox_right, bbox_bottom+5, 5);
			particle_create_pot_frag(bbox_left, bbox_top, bbox_right, bbox_bottom+5, 8, fragmentSpr, partTypeKey);
		
			//Light Particles
			create_platinum_light_particles(choose(1, 1, 2, 3), bbox_left, bbox_right, bbox_top, bbox_bottom);
		
			//Destroy
			instance_destroy();
			
		} else {
		
			if (abs(x - k.x) < 17) {
				k.hSpeed = point_to_position(k.x);
			
				if (k.onGround) {
					k.knockbackVSpeed = -1;
				}
			}
		
		}
	}
}
