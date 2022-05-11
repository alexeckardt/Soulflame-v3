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



if (damageMeeting != noone) {
	
	//Chjeck If Player Damage
	if (damageMeeting.creator.object_index = oKeira) {
		
		//Save To Game Map
		game_persistence_set(storename, true);
		
		//Platinum Create
		randomize();
		var randPlat = irandom_range(minPlat, maxPlat);
		platinum_create(x, y-12, choose(minPlat, maxPlat, randPlat), 0.5, 1, 4, 90, 45, 2);
		
		//Create Particles
		particle_create_dust(bbox_left, bbox_bottom-5, bbox_right, bbox_bottom+5, 5);
		if (potPartTypeSpr != undefined) {
			particle_create_frag(bbox_left, bbox_top, bbox_right, bbox_bottom+5, 8, potPartTypeSpr, partTypeKey);}
		
		//Light Particles
		create_platinum_light_particles(choose(1, 1, 2, 3), bbox_left, bbox_right, bbox_top, bbox_bottom);
		
		
		//Destroy
		instance_destroy();
		
	}
	
}