/// @desc

event_inherited();

//Mutators
doKnockback = 0;
hp = 500;

//Movement Vars
hSpeedGoal = 0;
vSpeedGoal = 0;
controlHSpeed = 0;
controlVSpeed = 0;

airFrictionValue = 0;

//Hitbox
hitbox_create_for_list(hitboxes, x, y-9, 8, 20, false);

//Custom Variables
timeLayingOnGroundBeforePop = 0;
