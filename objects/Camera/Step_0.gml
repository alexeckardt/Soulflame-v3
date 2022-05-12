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


//
//
//  LIGHTING
//
//

//Darkness
maxDarknessOpacity = lerp(maxDarknessOpacity, maxDarknessOpacityTo, 0.2);

//Return To Room Default
//lightingIntensityTo = lerp(lightingIntensityTo, lightingIntensityRoomDefault, lightingIntensityToSpeed);
//lightingIntensityTo = clamp(lightingIntensityTo, 0, 1);
