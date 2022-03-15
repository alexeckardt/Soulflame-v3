//
//DESC:
//
//
//
function keira_decide_attack_state() {



	//Check
	var aerial = timeOffGround > 3;

	//Direction Checked
	var stickDeadzone = 0.25;
	var upAttack = (Controller.verticalStick) < -stickDeadzone;
	var downAttack = (Controller.verticalStick) > stickDeadzone;
	var horizontalAttack = abs(Controller.horizontalStick) > stickDeadzone;

	//Tilts
	var vTilt = Controller.vStickTimeInSameInput < tiltTime;
	var hTilt = Controller.hStickTimeInSameInput < tiltTime;

	if (hTilt) {
		var wow = true;	
	}

	//Base
	var testAttack = (!aerial) ? state.combat_neutral : state.combat_air_neutral;
	
	//Make Sure We are waiting for a change input
	//--Reset nextAttack 
	var waitingForChangeInput = (	nextAttack == state.combat_empty
								||  nextAttack == testAttack);
	
	//
	//Switch Statement
	function combat_state_set(baseState, tiltState, aerialState, aerialTiltState, aerial, doTilt) {
		
		if (aerial) {
			
			if (doTilt) {
				return aerialTiltState;
			} else {
				return aerialState;
			}
			
		} else {
			
			if (doTilt) {
				return tiltState;
			} else {
				return baseState;
			}
						
		}
		
		//
		return undefined;
	}
	
	
	//
	//
	//
	if (waitingForChangeInput) {
	
		//Check Horizontal
		if (horizontalAttack) {
			
			testAttack = combat_state_set(	state.combat_running, state.combat_htilt, 
								state.combat_air_horizontal, state.combat_air_htilt, 
								aerial, hTilt);
			
		}
		
		//Up
		if (upAttack) 
		{
			
			testAttack= combat_state_set(	state.combat_up, state.combat_up_tilt, 
								state.combat_air_up, state.combat_air_up_tilt, 
								aerial, vTilt);
			
		}
		else
		//Down
		if (downAttack) {
			
			testAttack = combat_state_set(	state.combat_down, state.combat_down_tilt, 
								state.combat_air_down, state.combat_air_down_tilt, 
								aerial, vTilt);
								
		}
		
		//
		//
		//Set
		nextAttack = testAttack;
		
	}

}
		/*
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
		
}