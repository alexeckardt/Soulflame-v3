//
//DESC:
//
//
//
function keira_healing_checks() {
	
	//Enter Heal State
	if (STATE == state.base && inControl) {
		if (onGround) {
			if (Controller.healHolding) {
				
				//Check Conditions
				if (player_allowed_to_heal()) {
					
					//Set State
					STATE = state.heal;
				
					//Don't play loop animation just yet
					healPlayLoopAnimation = false;
					
					//Attempt To Heal Heart Index 1 (Second Heart);
					//(You can never heal the first one)
					Player.healingHeartNumber = 1;
					
				}
			}
		}
	}

}