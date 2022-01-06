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

//Path
pathFinder = noone;
pathFinderRegenerationRate = 10;
pathFinderRegenerationTimeLeft = pathFinderRegenerationRate;
pathfinderRegenerateRange = 15;

//Follow
lastSawTargetX = 0;
lastSawTargetY = 0;
targetFollowOffsetX = irandom_range(10, 30)*choose(1, -1);
targetFollowOffsetY = -30;
sightRange = 16*8;
inferPathTime = 10; // Time I can still see target after they vanish from view
inferPathTimeLeft = inferPathTime;

//Looper
detectionTime = room_speed/4;
detectionTimeLeft = detectionTime; //must be detected throughout before seesTarget

stuckTime = 0;
notSeesTargetTime = 0;

goHome = false;