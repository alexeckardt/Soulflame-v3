/// @desc

// Inherit the parent event
event_inherited();



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
//Destroy to give flower
var damageMeeting = instance_place(x, y, oDamage);
if (damageMeeting != noone) {
	
	//Chjeck If Player Damage
	if (damageMeeting.creator.object_index = oKeira) {
		
		//Destroy
		event_user(0);
		
	}
	
} 
	
