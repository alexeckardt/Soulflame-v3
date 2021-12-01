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
	var upAttack = (Controller.verticalStick) < -stickDeadzone && Controller.vStickTimeInSameInput < tiltTime;
	var downAttack = (Controller.verticalStick) > stickDeadzone && Controller.vStickTimeInSameInput < tiltTime;

	if (timeOffGround < 3) {
		
		nextAttack = state.combat_neutral;
		
		if (doHTilt) {
			nextAttack = state.combat_htilt;
			
		} else
		if (runningForTime > tiltTime) {
			nextAttack = state.combat_running;
			
		}
		
		if (upAttack) {
			nextAttack = state.combat_up;	
		}
		
		
		if (downAttack) {
			
			if (running) {
				nextAttack = state.combat_slide;
			} else {
				nextAttack = state.combat_down;	
			}
		}
		
		//Others
		
		//
		//if (upAttack && STATE == state.combat_slide) 
		
	} else {
		
		//Air Attacks
		if (upAttack) {
			if (allowCombatAirUp) {
				nextAttack = state.combat_air_up;
				allowCombatAirUp = false;
			}
			
		} else
		if (downAttack) {
			
			if (running && place_meeting(x, y+vSpeed+16, Solid)) {
				nextAttack = state.combat_slide;
			} else {
				nextAttack = state.combat_air_down;
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