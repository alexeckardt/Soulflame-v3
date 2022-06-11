// @desc
//
//
//
function menu_return_to_title(){

	if (keyboard_check(vk_control)) {
		
		game_end();
		exit
		
	} else {
	
		//Title Transition
		var transition = transition_create(oTransitionFade, roomTitle, -1, -1, -1, 1, c_black, -1, -1, 1);
		transition.independentDelta = true;
	
	}
}