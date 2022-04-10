//
//DESC:
//
//Sorry for the ugly if statement code
//I don't like it but it's just a longer state machine
//
function keira_stateaction_heals() {
	
	var sprGoal;
	var healingTicks = 0;
	
	if (STATE == state.heal) {
		
		//Decide What to do With Animation
		if (healPlayLoopAnimation) {
			
			//Loop Animation
			sprGoal = sKeiraHealLoop;
			index_speed = 0.3;
			
		} else {
		
			//Initial Animation
			sprGoal = sKeiraHealInit;
			index_speed = 0.3;
			
			//Play The Loop
			if (sprite_index == sprGoal 
			&& image_index + index_speed > image_number - index_speed) {
				healPlayLoopAnimation = true;
			}
			
		}
		
		//
		//Control
		inControl = false;
		
		//
		//Switch to Exit State
		if (!Controller.healHolding)
		STATE = state.heal_exit;
		
	//
	//Exit State
	} else {
		
		//Exit on Finish
		resetStateOnAnimationFinish = true;
		
		//If Was playing loop; exit with the end animation
		//(If i slammed hands together; count that as in loop)
		
		var handSlamIndex = 4;
		if (healPlayLoopAnimation || image_index+index_speed > handSlamIndex-index_speed) {
			
			//Play Animation
			sprGoal = sKeiraHealEnd;
			index_speed = 0.4;
			inControl = false;
			
		} else {
	
			//Keep the Animation Going Until the Hand Slam
			sprGoal = sKeiraHealInit;
			index_speed = 0.3;
			inControl = true;
			
			//Exit once RIGHT before the hand slam index
			if (image_index+index_speed > handSlamIndex-1-index_speed) {
				sprGoal = keira_get_movement_sprite("Idle");
				STATE = state.base;
			}
			
		}
		
	}
	
	//
	//
	sprite_switch_to(sprGoal);
	
	//Hide Weapon
	weaponSprite = -1;
	
}