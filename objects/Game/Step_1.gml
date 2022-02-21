/// @desc
//Delta

//deltaGet = delta_time*delta_scale*0.000001;
deltaRatio = delta_time / idealDelta;
indepedentDelta = clamp(delta_time / idealDelta, minDelta, maxDelta); 


if (indepedentDelta > deltatracking) {
	deltatracking = deltaRatio;
	largestDelta = deltaRatio;
} else {
	deltatracking = lerp(deltatracking, 0, 0.05);	
}

//
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
	delta = roundn(indepedentDelta, 4);
	
	if (delta > 10) {
		delta = 0;
	}
} else {
	delta = 0;	
}

if (keyboard_check_pressed(vk_f3)) {
	showDebugOverlay = !showDebugOverlay;	
}


//Keep Track Of Time
timeInGame += indepedentDelta;

//Settings
show_debug_overlay(showDebugOverlay);

//Frame Skips
frameSkipCounter++;
draw_enable_drawevent(frameSkipCounter % (frameSkips+1) == 0);