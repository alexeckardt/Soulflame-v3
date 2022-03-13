//
//DESC:
//
//
//
function player_do_death(){

	//Detect Dead
	var k = instance_nearest(x, y, oKeira);
	if (hp <= 0 && !k.dead) {
		
		//Set Keira State
		k.dead = true;
			
		//Other
		deadFadeOut = true;
		deadFadeOutTicks = deadTimeBeforeFadeOut;
		
		//Drop Platinum
		player_drop_platinum_death(k);
		
		//Shake
		add_screen_shake(10);
		
		//Preform A Dead Reset
		loadRoomAsRespawn = true;
		
		
	}
	
	
	//Wait Before Fadeing Out
	if (deadFadeOut) {
	
		//Fadeout Pre Timer
		deadFadeOutTicks-=Game.delta;
		
		if (deadFadeOutTicks < 0) {
			
			if (!instance_exists(oRoomTransition)) {
				
				//Get Room
				var roomToId = asset_get_index(Player.savePointRoom);

				//Fade Transition To Save Point
				var roomTransition = transition_create(
					oTransitionFade, 
					roomToId, Player.savePointX, Player.savePointY, Player.savePointD, 
					1, c_black, undefined, undefined);
				
				//Error Handel
				if (roomToId == -1) {
					roomTransition.loadInstead = true;	
				}
				
				
					
				//Reset
				deadFadeOut = false;
				
			}
		}
	}

}