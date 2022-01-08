/// @description 

event_inherited();

//Update
if (playerSittingHere) {
	//
	if (oKeira.STATE == state.situp) {
		//Stop Sitting Here
		playerSittingHere = false;
			
		//Save Again
		save_game(true, false); //*Temporary*
	}
	
}

litPercent = lerp(litPercent, lit, 0.2*Game.delta);


var periodSize = 6;
var zz = sin((x)/134)
flameFrequencyStrength = (sin((current_time)/(100*periodSize))*cos( (current_time-zz) / (234*periodSize)) + 1)/2;

fireIndex += Game.delta * 0.4