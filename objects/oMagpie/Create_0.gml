/// @desc

event_inherited();

//Mutators
index_speed = 0.3;

//Movement Vars
hSpeedGoal = 0;
vSpeedGoal = 0;
controlHSpeed = 0;
controlVSpeed = 0;
dirMoving = 0;
spd = 0;
maxSpeed = 1.5;
move = true;
turningSpeed = 0.1;

airFrictionValue = 0;

//Hitbox
hitbox_create_for_list(hitboxes, x, y, 20, 30, true);


//Custom Variables
timeLayingOnGroundBeforePop = 0;
knockbackSlide = 0.1;

pathFinder = noone;
pathfinderRegenerateRange = 8;

lastSawPlayerX = 0;
lastSawPlayerY = 0;

//Looper
recheckLOSTicks = irandom(10);
recheckLOSTicksLeft = recheckLOSTicks;
detectionTimeLeft = room_speed; //must be detected throughout before seesTarget