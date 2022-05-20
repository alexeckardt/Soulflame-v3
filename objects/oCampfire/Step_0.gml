/// @description 

event_inherited();

//Update
if (playerSittingHere) {
	
	//Sit Up; Exit Events
	if (oKeira.STATE == state.situp) {
		//Stop Sitting Here
		playerSittingHere = false;
			
		//Save Game
		save_game(true, false); //*Temporary*
	}
	
	//
	//Sitting Events
	else if (oKeira.STATE == state.sit) {
		
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
			
	} else {
		
		//Error; Typicall through load
		playerSittingHere = false;
			
	}
	
}

litPercent = lerp(litPercent, lit, 0.2*Game.delta);

var periodSize = 6;
var zz = sin((x)/134)
flameFrequencyStrength = (sin((current_time)/(100*periodSize))*cos( (current_time-zz) / (234*periodSize)) + 1)/2;

fireIndex += Game.delta * 0.4

//
if (lit) {

	myLight.active = true;
	myLight.colour = flameColour;
	myLight.str = (0.3 + 0.1*flameFrequencyStrength) * litPercent
	myLight.size = (300 + 30*flameFrequencyStrength) * litPercent
	myLight.falloff = 0.8; //fall off 
}