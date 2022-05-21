/// @desc

if (!instance_exists(PauseMenu)) {
	var gp_num = gamepad_get_device_count();
	controllerUsing = -1;
	for (var i = 0; i < gp_num; i++;)
	{
		controllersConnected[i] = gamepad_is_connected(i);
		if (controllersConnected[i] && controllerUsing == -1) {
			controllerUsing = i;	
		}
	}
}

//Always Do
usingController = (controllerUsing != -1);

updateFullScreen = keyboard_check_released(vk_f11);
if (updateFullScreen) {
	Game.fullscreen = !Game.fullscreen;	
}

//Command Object Is Typing
freezeInput = !((!instance_exists(commandInputObj)) || (commandInputObj.ranCommand));


if (keyboard_check_pressed(191) && Game.allowCheats) {
	
	//
	//Check if I should Create
	if (!freezeInput) {
	
		//
		//Create
		if (instance_exists(commandInputObj)) {
			instance_destroy(commandInputObj);				
		}
			
		commandInputObj = instance_create_depth(x, y, 0, CommandInput);
		freezeInput = true;
	
	}
}

//End it with Escape
if (freezeInput) {
	if (keyboard_check_pressed(vk_escape)) {
		instance_destroy(commandInputObj);
		exit;
	}
}



//Freeze Input
if (freezeInput) {
	
	if (!wasFreezeInput) {
		reset_keybind_vars();
	}
	
	//Don't Continue
	exit;
}


//Input Is NOT frozen past this.


//Controller Controller (Preferred)
if (usingController) {
	//Set Deadzone
	gamepad_set_axis_deadzone(controllerUsing, gamepadDeadzone);

	//Stick Input Values
	
		//Time In Horizontal
		hStickTimeInSameInput += Game.delta;
		var hStickLast = horizontalStick;
		horizontalStick = gamepad_axis_value(controllerUsing, gp_axislh);
		if (hStickLast != horizontalStick) hStickTimeInSameInput = 0;
	
		//Time In Vertical
		vStickTimeInSameInput += Game.delta;
		var vStickLast = verticalStick;
		verticalStick = gamepad_axis_value(controllerUsing, gp_axislv);
		if (vStickLast != verticalStick) vStickTimeInSameInput = 0;
	
		stickDirection = point_direction(0, 0, horizontalStick, verticalStick);
		stickHolding = abs(horizontalStick) > 0.05 || abs(verticalStick) > 0.05

		//Looking Stick Stuff
		rightStickHorizontal = (gamepad_axis_value(controllerUsing, gp_axisrh) > 0)
							 - (gamepad_axis_value(controllerUsing, gp_axisrh) < 0);
							 
		rightStickVertical	= (gamepad_axis_value(controllerUsing, gp_axisrv) > 0)
							- (gamepad_axis_value(controllerUsing, gp_axisrv) < 0);

		rightStickDirection = point_direction(0, 0, gamepad_axis_value(controllerUsing, gp_axisrh), gamepad_axis_value(controllerUsing, gp_axisrv));
		rightStickHolding = abs(rightStickHorizontal) > 0.05 || abs(rightStickVertical) > 0.05
		rightStickPressed = gamepad_button_check_pressed(controllerUsing, gp_stickr);

	//Left and Right
	left = horizontalStick < 0;
	right = horizontalStick > 0;
	
	jump = gamepad_button_check_pressed(controllerUsing, gp_face1);
	jumpHeld = gamepad_button_check(controllerUsing, gp_face1);
	
	combatAttack = gamepad_button_check(controllerUsing, gp_face3);
	combatAttackPressed = gamepad_button_check_pressed(controllerUsing, gp_face3);
	
	magicAttack = gamepad_button_check(controllerUsing, gp_face2);
	magicAttackPressed = gamepad_button_check_pressed(controllerUsing, gp_face2);
	
	block = gamepad_button_check(controllerUsing, gp_shoulderl);
	blockPressed = gamepad_button_check(controllerUsing, gp_shoulderl);

	interact =  gamepad_button_check_pressed(controllerUsing, gp_face4);

	uiSelectPressed = gamepad_button_check_pressed(controllerUsing, gp_face1);
	uiBackPressed = gamepad_button_check_pressed(controllerUsing, gp_face2);
	
	pausePressed = gamepad_button_check_pressed(controllerUsing, gp_start);
	
	healHolding = gamepad_button_check(controllerUsing, gp_padd);
	
	uiUp = (verticalStick < 0);
	uiDown = (verticalStick > 0);
}

//Keyboard Controller
if (!usingController) {
	
	left = keyboard_check(leftKey);
	right = keyboard_check(rightKey);
	var	up = keyboard_check(upKey);
	var down = keyboard_check(downKey);
	
	hStickTimeInSameInput += Game.delta;
	var hStickLast = horizontalStick;
	horizontalStick = right - left;
	if (hStickLast != horizontalStick) hStickTimeInSameInput = 0;
	
	//Time In Vertical
	vStickTimeInSameInput += Game.delta;
	var vStickLast = verticalStick;
	verticalStick = down - up;
	if (vStickLast != verticalStick) vStickTimeInSameInput = 0;
	
	jump = keyboard_check_pressed(ord(jumpKey));
	jumpHeld = keyboard_check(ord(jumpKey));
	
	combatAttack = keyboard_check(ord(combatKey));
	combatAttackPressed = keyboard_check_pressed(ord(combatKey));

	interact =  keyboard_check_pressed(interactKey);
	
	uiSelectPressed = keyboard_check_pressed(ord(uiSelectKey));
	uiBackPressed = keyboard_check_pressed(ord(uiBackKey));
	
	pausePressed = keyboard_check_pressed(pauseKey);
	
	healHolding = keyboard_check(ord(healKey));
	uiUp = up;
	uiDown = down;
	
	mapPressed = keyboard_check_pressed(ord(mapKey));
	inventoryPressed = keyboard_check_pressed(ord(inventoryKey));

}