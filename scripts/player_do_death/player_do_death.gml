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
				
				//Fade Transition To Save Point
				transition_create(
					oTransitionFade, 
					asset_get_index(Player.savePointRoom), Player.savePointX, Player.savePointY, Player.savePointD, 
					1, c_black, undefined, undefined);
					
				//Reset
				deadFadeOut = false;
				
			}
		}
	}

}