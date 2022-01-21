/// @desc

event_inherited();

//Mutators

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
