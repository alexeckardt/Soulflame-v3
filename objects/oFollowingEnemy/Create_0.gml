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
pounceRad = 80;
maxJumpTiles = 6;

pounceJumpSpeed = -6.5;

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
toJumpToX = 0; // must land there before
jumpingDirection = 0;
inAirFromJump = true;

landingTicks = 10;
landingTicksLeft = -1;


targetingTarget = false;

closeEnoughPathXRange = 8;

timeUntilJump = 0;

function jump_to_position(checkX, checkY) {

	//Decide The Distances I need to jump for
	var xDist = abs(x - checkX) + 3; //put me in the middle of my bounding box
	var yDist = abs(checkY - y) + 16; //how high i have to jump (-5 for a little buffer)
				
	//Decide Speed
	var hspdd = max(1, abs(hSpeed));
	toJumpHspeed = hspdd;
				
	//Jump & Clamp (formula for how much jump force i need)
	toJumpVspeed = (-yDist*hspdd)/(xDist) - (myGrav*xDist)/(2*hspdd);
	toJumpVspeed = clamp(toJumpVspeed, -6.8, -0.5);
					
	jumped = true;
	STATE = state.jumping;
	
	jumpingDirection = point_to_position(checkX);
	toJumpToX = checkX + jumpingDirection*8;
				
	//Decide Time Jumping Takes
	timeUntilJump = abs(toJumpVspeed) * 2;
	inAirFromJump = false;

}
