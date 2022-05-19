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
maxSpeed = 2;
minSpeed = 1.25;

goalSpd = maxSpeed;
move = true;
turningSpeed = 0.1;

airFrictionValue = 0;

//Hitbox
hitbox_create_for_list(hitboxes, x, y, 15, 15, true);

//
//Custom Variables
timeLayingOnGroundBeforePop = 0;
knockbackSlide = 0.1;

//Path
pathFinder = pathfinder_create(true);

//Disable any path mutating stuff
pathFinder.asBackgroundPath = true;
pathFinder.pushFirstPointBasedOnCreatorFatness = false;
pathFinder.tryToUnstuckAirborne = false;

pathFinderRegenerationRate = 10;
pathFinderRegenerationTimeLeft = pathFinderRegenerationRate;
pathfinderRegenerateRange = 15;

//Follow
lastSawTargetX = x;
lastSawTargetY = y;
targetFollowOffsetX = 0;
targetFollowOffsetY = 0;
sightRange = 16*8;
inferPathTime = 2; // Time I can still see target after they vanish from view
inferPathTimeLeft = inferPathTime;
reachedEndOfPath = false;

//Looper
detectionTime = room_speed/4;
detectionTimeLeft = detectionTime; //must be detected throughout before seesTarget

headSprite = sEmeraldCrawlerHead;
bodySprite = sEmeraldCrawlerBody;

myDamage = noone;
damageResetTicksOnHit = room_speed/2;
damageResetTicksOnDamageTarget = room_speed*2;
damageResetTicksLeft = 0;

orbitX = x;
orbitY = y;
goingToOrbit = false;

//
//
//Create Body Nodes
nodes = ds_list_create();
createdNodes = false;

bodyNodeCount = 5;
bodyNodeSeperation = 7;

//
hp = 5;
platinumDrop = 7;
platinumDropRange = .5;
