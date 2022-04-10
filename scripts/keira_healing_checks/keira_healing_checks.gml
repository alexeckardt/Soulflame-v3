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
				
				//Has Enough Tokens
				if (essence_token_has_amount(1)) {
					
					//Set State
					STATE = state.heal;
				
					//Don't play loop animation just yet
					healPlayLoopAnimation = false;
					
				}
			}
		}
	}

}