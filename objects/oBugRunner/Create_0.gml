/// @desc

event_inherited();

//Mutators
hp = 4
platinumDrop = 2
platinumDropRange = 2;
sightRange = 16*8;
weight = 1;

//Movement Vars
hSpeedGoal = 0;
vSpeedGoal = 0;
controlHSpeed = 0;
controlVSpeed = 0;

airFrictionValue = 0;

//Hitbox
hitbox_create_for_list(hitboxes, x, y-5, 8, 10, false);

//Custom Variables
timeLayingOnGroundBeforePop = 0

STATE = state.base;
idleSprite = sBugRunnerIdle;
runSprite = sBugRunnerIdle;

runSpeedReal = 0;
runSpeedGoal = 2.5;

runDirection = 0;

runWindUpTicks = room_speed/4;
runWindUpTicksLeft = runWindUpTicks;