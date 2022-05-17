/// @desc

event_inherited();

//Mutators
hp = 2
platinumDrop = 2
platinumDropRange = 0.1;

weight = 0.9

//Movement Vars
hSpeedGoal = 0;
vSpeedGoal = 0;
controlHSpeed = 0;
controlVSpeed = 0;

airFrictionValue = 0;

//Hitbox
hitbox_create_for_list(hitboxes, x, y-5, 8, 10, false);
myDamage = noone;

//Custom Variables
timeLayingOnGroundBeforePop = 0

territoryXMin = x - 64;
territoryXMax = x + 64;
goToX = x;
idleTicks = 0;
jumpingTicks = 0;
jumped = false;

hopSpeed = 1;

idleSprite = sBunfetIdle;
jumpSprite = sBunfetLeap;

sightRange = 160;
cameraWeight = 0.5;

shouldDealDamage = false;
myDamage = noone;

dropped = false;
droppedSprite = sBunfetFall;

showHurt = false;
