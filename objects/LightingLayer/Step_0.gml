/// @description 

//Darkness
maxDarknessOpacity = lerp(maxDarknessOpacity, maxDarknessOpacityTo, 0.2);

//Return To Room Default
//lightingIntensityTo = lerp(lightingIntensityTo, lightingIntensityRoomDefault, lightingIntensityToSpeed);
//lightingIntensityTo = clamp(lightingIntensityTo, 0, 1);

if (mouse_check_button_pressed(mb_left)) {
	instance_create_depth(mouse_x, mouse_y, depth, Light);	
}