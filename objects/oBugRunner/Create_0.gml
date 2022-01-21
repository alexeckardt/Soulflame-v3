/// @desc

event_inherited();

//Mutators
hp = 4
platinumDrop = 5
platinumDropRange = 0.5;
sightRange = 16*8;
weight = 1;

//Movement Vars
hSpeedGoal = 0;
vSpeedGoal = 0;
controlHSpeed = 0;
controlVSpeed = 0;

airFrictionValue = 0;

//Hitbox
hitbox_create_for_list(hitboxes, x, y, 16, 16, false);

//Custom Variables
timeLayingOnGroundBeforePop = 0

STATE = state.base;
idleSprite = sBugRunnerIdle;
runSprite = sBugRunnerRun;
breakSprite = sBugRunnerBreak;

runSpeedReal = 0;
runSpeedGoal = 3.5;

runDirection = 0;
goalRunDirection = 0;

runWindUpTicks = room_speed/4;
timeToNoticeTarget = room_speed/4;
runWindUpTicksLeft = runWindUpTicks;

myDamage = noone;