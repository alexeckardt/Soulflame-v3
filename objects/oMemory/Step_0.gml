/// @desc

if (!checkedAlreadyDestroyed) {
	
	//Save
	checkedAlreadyDestroyed = true;
	
	//Destroy Self If Already
	var get = game_persistence_check(map_id);
	if (!is_undefined(get)) {
		instance_destroy();
	}
}

//
//
//

if (shouldActivate) {
	alpTo = 1;
}

alp = lerp(alp, alpTo, 0.03*Game.delta);

if (distance_to_object(oKeira) < 10) {
	
	//Event
	event_user(0);
	
	//Die
	instance_destroy();
	
}
