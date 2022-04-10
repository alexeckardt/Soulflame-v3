//
//DESC:
//
//
//
function player_heal(){
	
	//Check if Alls Good
	if (oKeira.STATE == state.heal) {
		
		//Make Sure we are inside the heal animation loop
		if (oKeira.healPlayLoopAnimation) {
			
			//Draw Fire
			drawHealthFire = true;
			drawingHealthFire = true;
			healthFireExtinguishTicks = 0;
			
			//Time Increase
			healTicks -= Game.delta;

			//Once a tick is done
			if (healTicks < 0) {
				
				//Reset Counter
				healTicks = ticksToRestoreHeart;
				
				//Attempt To Heal The Current Heart
				if (healingHeartNumber >= hp) {
					
					//Increase Health
					hp++;
					
					//Remove Token
					var v = essence_token_consume(healTokenCost);
					lastHealingAlignment = v;
					
					//Check If Condition Is Met
					//Exit State is good here as it is a forced exit.
					if (!player_allowed_to_heal()) {
						oKeira.STATE = state.heal_exit;
					}
					
				}
				
				//Move To Next Attempt
				healingHeartNumber++;
			}
				
			
		}
		
	} else {
	
		//Reset Counter
		healTicks = ticksToRestoreHeart;
		
		//Reccognize Fire should stop
		drawHealthFire = false;
		healthFireExtinguishTicks += Game.delta;
	
	}
	
}