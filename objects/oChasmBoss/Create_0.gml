/// @desc

event_inherited();

//Mutators
hp = 100;
platinumDrop = 100;
platinumDropRange = 0.1;
sightRange = 16*8;
weight = 3;

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
idleSprite = sBossSprite;
runSprite = sBossSprite;
breakSprite = sBossSprite;

runSpeedReal = 0;
runSpeedGoal = 3.5;

runDirection = 0;
goalRunDirection = 0;

runWindUpTicks = room_speed/4;
timeToNoticeTarget = room_speed/4;
runWindUpTicksLeft = runWindUpTicks;

breakSpeed = 0.07;

myDamage = noone;

mask_index = idleSprite;
