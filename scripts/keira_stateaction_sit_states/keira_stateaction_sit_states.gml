// @desc
//
//
//
function keira_stateaction_sit_states(){

	sprite_switch_to(sKeiraSitDown);
	index_speed = 0;
	inControl = false;
		
	//SitDown Animation
	if (STATE == state.sitdown) {
		var tempIndSpeed = 0.1*Game.delta;	
		if (image_index + tempIndSpeed < image_number - tempIndSpeed) {
			image_index += tempIndSpeed;
		} else {
			//Static Sit
			STATE = state.sit;	
		}
	} else
	
	//Situp Animation
	if (STATE == state.situp) {
		var tempIndSpeed = 0.2*Game.delta;	
		if (image_index - tempIndSpeed > tempIndSpeed) {
			image_index -= tempIndSpeed;}
			
		//Exit State(s)
		if (image_index < 1) {
			STATE = state.base;	
			inControl = true;
		}
	}

	//Just Siting
	if (STATE = state.sit) {
		
		//Exit Condition
		if (!instance_exists(Cutscene)) {
			if (mx != 0 || Controller.interactPressed || jumpTicks > 0) && (!Game.someUIopen) {
			
				STATE = state.situp;
				inControl = false;
			
				if (jumpTicks > 0) {
					STATE = state.base;	
				}
			
			}
		}
	}

}