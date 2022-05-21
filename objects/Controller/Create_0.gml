/// @desc

controllersConnected = [];
controllerUsing = -1;

usingController = gamepad_is_connected(0);
gamepadDeadzone = 0.3;

freezeInput = false;
wasFreezeInput = false;

commandInputObj = noone;

iconPage = 0;

function reset_keybind_vars() {

	horizontalStick = 0;
	hStickTimeInSameInput = 0;

	verticalStick = 0;
	vStickTimeInSameInput = 0;

	stickDirection = 0;
	stickHolding = false;

	left = false;
	right = false;

	jump = false;
	jumpHeld = false;

	combatAttack = false;
	combatAttackPressed = false;

	heavyAttack = false;
	heavyAttackPressed = false;

	block = false;
	blockPressed = false;

	updateFullScreen = true;

	interactPressed = false;

	uiSelectPressed = false;
	uiBackPressed = false;

	//Pause
	pausePressed = false

	//View Stick
	holdingRightStick = false;

	rightStickHorizontal = 0;
	rightStickVertical = 0;
	rightStickDirection = 0;
	rightStickHolding = false;
	rightStickPressed = false;
	
	healHolding = false;
	
	//
	mapPressed = false;
	inventoryPressed = false;

	inventoryPageLeft = false;
	inventoryPageRight = false;

}

reset_keybind_vars();


//
//Keys
//
leftKey = vk_left;
rightKey = vk_right;
upKey = vk_up;
downKey = vk_down;
jumpKey = "Z";
combatKey = "X";
interactKey = vk_down;
uiSelectKey = "Z";
uiBackKey = "C";
pauseKey = vk_escape;
healKey = "R";
mapKey = "M";
inventoryKey = "I";

inventoryLeftPageKey = "C";
inventoryRightPageKey = "V";
