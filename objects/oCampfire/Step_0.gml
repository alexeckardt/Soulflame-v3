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