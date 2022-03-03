/// @description Camera Other


//Switch To Full Screen
if (window_get_fullscreen() != Game.fullscreen) {
	window_set_fullscreen(Game.fullscreen);
	display_reset(0, false);
}

//photo Mode
if (keyboard_check_pressed(vk_f8)) {
	photoMode = !photoMode;
	x = viewX;
	y = viewY;
}
