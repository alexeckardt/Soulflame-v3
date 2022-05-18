/// @desc

event_inherited();

//Mutators
index_speed = 0.3;

STATE = state.base;
deadStaggerForTime = room_speed/4;

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
goalSpd = 0;

airFrictionValue = 0;

//Hitbox
hitbox_create_for_list(hitboxes, x, y, 20, 30, true);

//Custom Variables
timeLayingOnGroundBeforePop = 0;
knockbackSlide = 0.1;

//Path
pathFinder = pathfinder_create(true);
pathFinderRegenerationRate = 10;
pathFinderRegenerationTimeLeft = pathFinderRegenerationRate;
pathfinderRegenerateRange = 15;

//Follow
lastSawTargetX = x;
lastSawTargetY = y;
targetFollowOffsetX = irandom_range(10, 30)*choose(1, -1);
targetFollowOffsetY = -5;
sightRange = 16*12;
inferPathTime = 10; // Time I can still see target after they vanish from view
inferPathTimeLeft = inferPathTime;

//Looper
detectionTime = room_speed/1.5;
detectionTimeLeft = detectionTime; //must be detected throughout before seesTarget

stuckTime = 0;
sinceSeenTarget = 0;

goHome = false;

hp = 5; // 5
platinumDrop = 5;

//Coin
canFindPickup = false;
goingToPickup = false;
holdingDroppable = false;
holdingBunfet = false;
coinHoldingValue = 1;
maxCoinPickupValue = 2;
coinHoldingSprite = platinum_get_coin_sprite(0);

reloadAreaX = 0;
reloadAreaY = 0;
reloadIsABunfet = false;
reloadAreaDecided = false;
reloadInstance = false;

bunfetHp = 0;

reloadingTicksWait = room_speed*2;
attackingTicksWait = room_speed*1.5;
reloadingTicksTimeLeft = reloadingTicksWait;

holdPickupXoffset = 4;
holdPickupYoffset = -3;

//Dropping
droppingOff = false;
hoverOverDropPlayerY = -40;

droppableExists = true;

event_user(0);

myDamage = noone;
