// @desc
//
//
//
function keira_stateaction_cutscene_state() {

	//Switch
	sprite_switch_to(cutsceneStateSprite);
	index_speed = 0;
	inControl = false;

	var tempIndSpeed = cutsceneStateIndexSpeed*Game.delta;	

	//Animate Loop
	if (STATE == state.cutscene_loop_animation) {
		image_index += tempIndSpeed;
	
	//Animate Until End
	} else {
		
		//Positive Animation
		if (tempIndSpeed > 0) {
			if (image_index + tempIndSpeed < sprite_get_number(cutsceneStateSprite) - tempIndSpeed) {
				image_index += tempIndSpeed;
			} 
			
		//Negative Anumation
		} else {
	
			if (image_index + tempIndSpeed > abs(tempIndSpeed)) {
				image_index += tempIndSpeed;
			}
			
		}
	}

}