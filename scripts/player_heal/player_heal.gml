//
//DESC:
//
//
//
function player_heal(){
	
	//Check if Alls Good
	if (instance_exists(oKeira)) { 
		
		if (oKeira.STATE == state.heal) {
		
			//Make Sure we are inside the heal animation loop
			if (oKeira.healPlayLoopAnimation) {
			
				//Start
				if (!healing) {
					healing = true;
				
					var heartAlblazdDelay = 7;
					lastHealingAlignment = 0;
				
					var hearts = ds_list_size(heartList);
					for (var i = 1; i < hearts; i++) {
						var heart = heartList[| i];
						heart.set_fire_col_alignment(0);
						heart.light_fire(i*heartAlblazdDelay);
					}
			
				}
			
			
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
					
						//Reccognize
						instruction_complete("heal");
					
					}
				
					//Move To Next Attempt
					//Animate
					var heartToMend = heartList[| healingHeartNumber];
					heartToMend.set_fire_col_alignment(lastHealingAlignment);
					heartToMend.extinguish_fire();
					healingHeartNumber++;
				}
				
			
			}
		
		} else {
	
			//Reset Counter
			healTicks = ticksToRestoreHeart;
		
			//Reccognize Fire should stop
			drawHealthFire = false;
			healthFireExtinguishTicks += Game.delta;
		
			//Stop Healing
			if (healing) {
				healing = false;	
				
				//Make Rest of Fire Go Away
				var hearts = ds_list_size(heartList);
				for (var i = 0; i < hearts; i++) {
					var heart = heartList[| i];
				
					if (heart.drawFireBehind) {
						heart.extinguish_fire();}
					heart.lightFireInTicks = -1;
				}
			
			}
	
		}
	}
}