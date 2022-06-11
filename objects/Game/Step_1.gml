/// @desc
//Delta

//deltaGet = delta_time*delta_scale*0.000001;
deltaRatio = delta_time / idealDelta;
independentDelta = clamp(delta_time / idealDelta, minDelta, maxDelta); 


if (independentDelta > deltatracking) {
	deltatracking = deltaRatio;
	largestDelta = deltaRatio;
} else {
	deltatracking = lerp(deltatracking, 0, 0.05);	
}

//
//Instance Spawning (UI stuff)
//

event_user(1);


//
//Timing
//

if (!paused) {
	delta = roundn(independentDelta, 4);
	
	if (delta > 10) {
		delta = 0;
	}
} else {
	delta = 0;	
}

if (keyboard_check_pressed(vk_f3)) {
	showDebugOverlay = !showDebugOverlay;	
}

if (showDebugOverlay) {
	if (keyboard_check_pressed(ord("H")) && devMode) {
		var yy = clamp(round(oKeira.y), -32, room_height+32);
		var str = "roomTo = " + string(room_get_name(room)) 
				+ ";\nxTo = " + string(round(oKeira.x)) 
				+ ";\nyTo = " + string(yy) 
				+ ";\ndirFacing = " + string(sign(oKeira.directionFacing));
		clipboard_set_text(str);	
	}
}


//Keep Track Of Time
timeInGame += independentDelta;
inGameTicks += delta;

//Settings
show_debug_overlay(showDebugOverlay);

//Frame Skips
frameSkipCounter++;
draw_enable_drawevent(frameSkipCounter % (frameSkips+1) == 0);