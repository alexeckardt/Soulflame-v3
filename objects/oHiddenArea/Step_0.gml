/// @description 

//Enter Thingy
if (place_meeting(x, y, oKeira)) {
	
	//Sound Effect
	if (!keiraHasEnteredBefore) {
		keiraHasEnteredBefore = true;
	}
	
	//Fade In
	goalAlpha = 0;
	timeSinceEnter = 0;
	
} else {

	//Timeing
	if (goalAlpha == 0) {
	
		timeSinceEnter += Game.delta;
		if (timeSinceEnter > room_speed) {
			goalAlpha = 1;
		}
	
	}
	
}

//Fade
alp = lerp(alp, goalAlpha, fadeSpeed*Game.delta);