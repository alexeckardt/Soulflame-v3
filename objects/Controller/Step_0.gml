/// @desc

usingController = gamepad_is_connected(0);

//Controller Controller (Preferred)
if (usingController) {
	//Set Deadzone
	gamepad_set_axis_deadzone(0, gamepadDeadzone);

	//Stick Input Values
	
		//Time In Horizontal
		hStickTimeInSameInput += Game.delta;
		var hStickLast = horizontalStick;
		horizontalStick = gamepad_axis_value(0, gp_axislh);
		if (hStickLast != horizontalStick) hStickTimeInSameInput = 0;
	
		//Time In Vertical
		vStickTimeInSameInput += Game.delta;
		var vStickLast = verticalStick;
		verticalStick = gamepad_axis_value(0, gp_axislv);
		if (vStickLast != verticalStick) vStickTimeInSameInput = 0;
	
		stickDirection = point_direction(0, 0, horizontalStick, verticalStick);
		stickHolding = abs(horizontalStick) > 0.05 || abs(verticalStick) > 0.05

		//Looking Stick Stuff
		rightStickHorizontal = (gamepad_axis_value(0, gp_axisrh) > 0)
							 - (gamepad_axis_value(0, gp_axisrh) < 0);
							 
		rightStickVertical	= (gamepad_axis_value(0, gp_axisrv) > 0)
							- (gamepad_axis_value(0, gp_axisrv) < 0);

		rightStickDirection = point_direction(0, 0, gamepad_axis_value(0, gp_axisrh), gamepad_axis_value(0, gp_axisrv));
		rightStickHolding = abs(rightStickHorizontal) > 0.05 || abs(rightStickVertical) > 0.05
		rightStickPressed = gamepad_button_check_pressed(0, gp_stickr);

	//Left and Right
	left = horizontalStick < 0;
	right = horizontalStick > 0;
	
	jump = gamepad_button_check_pressed(0, gp_face1);
	jumpHeld = gamepad_button_check(0, gp_face1);
	
	combatAttack = gamepad_button_check(0, gp_face3);
	combatAttackPressed = gamepad_button_check_pressed(0, gp_face3);
	
	magicAttack = gamepad_button_check(0, gp_face2);
	magicAttackPressed = gamepad_button_check_pressed(0, gp_face2);
	
	block = gamepad_button_check(0, gp_shoulderl);
	blockPressed = gamepad_button_check(0, gp_shoulderl);

	interact =  gamepad_button_check_pressed(0, gp_face4);

	uiSelectPressed = gamepad_button_check_pressed(0, gp_face1);
	uiBackPressed = gamepad_button_check_pressed(0, gp_face2);
}

//Keyboard Controller
if (!usingController) {
	
	left = keyboard_check(vk_left);
	right = keyboard_check(vk_right);
	var	up = keyboard_check(vk_up);
	var down = keyboard_check(vk_down);
	
	hStickTimeInSameInput += Game.delta;
	var hStickLast = horizontalStick;
	horizontalStick = right - left;
	if (hStickLast != horizontalStick) hStickTimeInSameInput = 0;
	
	//Time In Vertical
	vStickTimeInSameInput += Game.delta;
	var vStickLast = verticalStick;
	verticalStick = down - up;
	if (vStickLast != verticalStick) vStickTimeInSameInput = 0;
	
	jump = keyboard_check_pressed(ord("Z"));
	jumpHeld = keyboard_check(ord("Z"));
	
	combatAttack = keyboard_check(ord("X"));
	combatAttackPressed = keyboard_check_pressed(ord("X"));

	updateFullScreen = keyboard_check_released(vk_f11);

	interact =  keyboard_check_pressed(vk_down);
	
	uiSelectPressed = keyboard_check_pressed(ord("Z"));
	uiBackPressed = keyboard_check_pressed(ord("C"));

}