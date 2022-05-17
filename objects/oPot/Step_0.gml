/// @description 
var damageMeeting = instance_place(x, y, oDamage);

//Check Persistance
if (!checkedAlreadyDestroyed) {
	
	//Save
	checkedAlreadyDestroyed = true;
	
	//Destroy Self If Already
	var get = game_persistence_check(storename);
	if (is_undefined(get)) {
		
		//Add my value to the ds_list
		game_persistence_set(storename, value);
		
	} else {
	
		//Get Back
		value = get;
		
		//Check If Should Be Destroyed
		//Zero pots should stay
		if (get < 0) {
			instance_destroy();	
		}
		
	
	}
}

//Update Game
valueChanged = (value != valueLast)
if (valueChanged) {
	
	//Set
	game_persistence_set(storename, value);
	valueLast = value
	
	//Finish
	if (value < 0) {
		event_user(0);
	}
}

//
//Destroy
if (damageMeeting != noone) {
	
	//Chjeck If Player Damage
	if (damageMeeting.creator.object_index = oKeira) {
		
		//Destroy
		event_user(0);
		
	}
	
} 
	
