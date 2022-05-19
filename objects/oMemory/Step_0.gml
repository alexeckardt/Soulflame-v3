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
//Activation
//

var keiraDistance = distance_to_object(oKeira);

if (activateByProx && !active) {

	//Within Radius?
	if (keiraDistance <= activateRange) {
		
		//Percent to be shown based on distance
		var p = (keiraDistance - activateMaxAlphaRad) / (activateRange - activateMaxAlphaRad)
		alpTo = p;
		
		if (p >= 0.999) {
			active = true;	
		}
		
	} else {
		//Hide
		alpTo = 0;
	}
	
} 

//
//Activate
if (active) {
	alpTo = 1;
}

//
//Alpha
//
alp = lerp(alp, alpTo, 0.03*Game.delta);


//
//Collect
//
if (keiraDistance < 10 && active) {
	
	//Event
	event_user(0);
	
	//Die
	instance_destroy();
	
}
