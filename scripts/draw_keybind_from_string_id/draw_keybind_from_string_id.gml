// @desc
//
//
//
function draw_keybind_from_string_id(xx, yy, keybind, correctForStr = true) {

	//
	//
	if (Controller.usingController) {
	
		//Correct
		xx += -9*correctForStr;
		yy += -18*correctForStr;
	
		//Draw
		keybind_draw_controller_icon(xx, yy, keybind);
	
	} else {
		
		//Correct
		xx += -4*correctForStr;
		yy += -15*correctForStr;
		
		//Draw the Button
		keybind_draw_keyboard_icon(xx, yy, keybind);
		
		
	}

}