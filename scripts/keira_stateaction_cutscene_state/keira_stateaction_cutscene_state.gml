// @desc
//
//
//
function keira_stateaction_cutscene_state() {

	//Switch
	sprite_switch_to(cutsceneStateSprite);
	index_speed = 0;
	inControl = false;

	//Animate Until End OR if Looping
	var tempIndSpeed = cutsceneStateIndexSpeed*Game.delta;	
	if (image_index + tempIndSpeed < image_number - tempIndSpeed
	|| STATE == state.cutscene_loop_animation) {
		
		image_index += tempIndSpeed;
		
	} 

}