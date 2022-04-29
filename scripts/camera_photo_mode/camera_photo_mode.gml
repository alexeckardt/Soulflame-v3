// @desc
//
//
//
function camera_photo_mode(){

	//
	// PC Exclusive
	//
	if (photoMode) {
	
		x += (keyboard_check(vk_right) - keyboard_check(vk_left));
		y += (keyboard_check(vk_down) - keyboard_check(vk_up));
	
		viewX = x;
		viewY = y;
		
	}
}