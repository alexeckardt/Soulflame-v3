/// @desc
//Delta

indepedantDelta = delta_time*delta_scale*0.000001;

if (Controller.pausePressed) {
	
	//Toggle
	paused = !paused;
	someUIopen = paused;
	
	//Paused
	if (paused) {
	
		if (!instance_exists(pauseMenuObj)) {
			pauseMenuObj = instance_create_depth(x, y, 0, PauseMenu);	
		}

	
	} else {
	
		pauseMenuObj.close = true;
		pauseMenuObj = noone;
	
	}
		
}


if (!paused) {
	delta = indepedantDelta;
	if (delta > 10) {
		delta = 0.00001;
	}
} else {
	delta = 0;	
}

//Keep Track Of Time
timeInGame += indepedantDelta;