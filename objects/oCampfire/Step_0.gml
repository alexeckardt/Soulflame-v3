/// @description 

event_inherited();

//Update
if (playerSittingHere) {
	
	
	//Sit Up; Exit Events
	if (oKeira.STATE == state.situp) {
		//Stop Sitting Here
		playerSittingHere = false;
			
		//Save Again
		save_game(true, false); //*Temporary*
	}
	
	//
	//Sitting Events
	else {
		
		//Heal Player
		if (Player.hp < Player.currentMaxHealth) {
		
			//Timer
			healTicks -= Game.delta;
			
			//Heal After Time
			if (healTicks < 0) {
				healTicks = healTime;	
				Player.hp++;
			}
			
		}
			
	}
	
}

litPercent = lerp(litPercent, lit, 0.2*Game.delta);


var periodSize = 6;
var zz = sin((x)/134)
flameFrequencyStrength = (sin((current_time)/(100*periodSize))*cos( (current_time-zz) / (234*periodSize)) + 1)/2;

fireIndex += Game.delta * 0.4