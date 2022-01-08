/// @desc


usingController = gamepad_is_connected(0);
gamepadDeadzone = 0.3;

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

//View Stick
holdingRightStick = false;

rightStickHorizontal = 0;
rightStickVertical = 0;
rightStickDirection = 0;
rightStickHolding = false;
rightStickPressed = false;