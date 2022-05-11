// @desc
//
//
//
function draw_keybind(xx, yy, keybind) {

	//
	//
	if (Controller.usingController) {
	
		//Draw
		keybind_draw_controller_icon(xx, yy, keybind);
	
	} else {
		
		//Draw the Button
		keybind_draw_keyboard_icon(xx, yy, keybind);
		
		
	}

}