/// @desc

event_inherited();

//Mutators
hp = 6
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

STATE = state.base;
idleSprite = sMonpupIdle;
//runSprite = sBugRunnerRun;
//breakSprite = sBugRunnerBreak;

decidedPouncePosition = false;
pounceX = 0;
pounceRad = 32;
maxJumpTiles = 5;

runSpeed = 1.5;

//Path
pathFinder = pathfinder_create(false);
pathFinderRegenerationRate = 10;
pathFinderRegenerationTimeLeft = pathFinderRegenerationRate;
pathfinderRegenerateRange = 15;

lastSawTargetX = x;
lastSawTargetY = y;

inferPlayerPosTime = room_speed;
inferPlayerPosTimeLeft = -1;

//Jump
toJumpVspeed = 0;
toJumpHspeed = 0;
lastSTATE = state.base;

timeUntilJump = 0;
