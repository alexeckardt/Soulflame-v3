//
//DESC:
//
//
//
function keira_decide_attack_state(){

		var stickDeadzone = 0.25;
		var horizontalAttackReq = abs(Controller.horizontalStick) > stickDeadzone;
		var running = runningForTime >= tiltTime;

						//Take H Momentum into account here
		var runAttack = running && horizontalAttackReq;
		var doHTilt = horizontalAttackReq && Controller.hStickTimeInSameInput <= tiltTime;
		
		var vTilt = Controller.vStickTimeInSameInput < tiltTime;
		
		var upAttack = (Controller.verticalStick) < -stickDeadzone;
		var downAttack = (Controller.verticalStick) > stickDeadzone;

		if (timeOffGround < 3) {
		
			nextAttack = state.combat_neutral;
		
			if (doHTilt) {
				nextAttack = state.combat_htilt;
			
			} else
			if (runningForTime > tiltTime) {
				nextAttack = state.combat_running;
			
			}
		
			if (upAttack) {
				
				if (!vTilt) {
					nextAttack = state.combat_up;	
				} else {
					nextAttack = state.combat_up_tilt;	
				}
			}
		
		
			if (downAttack) {
			
				if (running) {
					nextAttack = state.combat_slide;
				} else {
					
					if (!vTilt) {
						nextAttack = state.combat_down;	
					} else {
						nextAttack = state.combat_down_tilt;	
					}
				}
			}
		
			//Others
		
			//
			//if (upAttack && STATE == state.combat_slide) 
		
		} else {
		
			//Air Attacks
			if (upAttack) {
				if (allowCombatAirUp) {
					
					if (!vTilt) {
						nextAttack = state.combat_air_up;
					} else {
						nextAttack = state.combat_air_up_tilt;
					}
					
					allowCombatAirUp = false;
				}
			
			} else
			if (downAttack) {
			
				if (running && place_meeting(x, y+vSpeed+16, Solid)) {
					nextAttack = state.combat_slide;
				} else {
					if (!vTilt) {
						nextAttack = state.combat_air_down;
					} else {
						nextAttack = state.combat_air_down_tilt;
					}
					
				}
			
			} else 
			if (doHTilt) {
				nextAttack = state.combat_air_horizontal;
			
			} else {
				nextAttack = state.combat_air_neutral;
			
			}
	
		
		}
	
		//Allow input before current attack is finished.
		wantToChangeAttackTicks = timeForPreAttacks;
		
}