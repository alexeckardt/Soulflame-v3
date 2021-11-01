/// @desc

//Speed
controlHSpeed = 0; //What I'm Controlling
controlVSpeed = 0; //What I'm Controlling
hSpeed = 0; //Real, Updates outside
vSpeed = 0;

runSpeed = 3;


//States
STATE = 0;
inControl = true
directionFacing = 1;
visualDirectionFacing = 0;

//Climbing
climbingGravMulti = 1/3
lastOnFloorAtY = y;

//Gravity & Jumping
jumpSpeed = -4.3;
myGrav = 0.2;
terminalVelocity = 10;
halfGravityThreshold = 0.7;
forceHalfGravity = false;
allowHalfGravity = true;
cutVspd = false;

//Jump
forceJump = false;
jumpTicks = 0;
jumpCooldownTicks = 0;		
coyoteeMaxTime = 8;				
bouncingOffEnemy = false;
preLandJumpsTime = 7			
bounceJumpCoefficient = 0.7;

//Climbing
wallClimbCoyoteeTime = 4	
canVerticalClimb = false;
timeNotClimbing = -1;
wallJumpSpeed = jumpSpeed * 0.9;
wallJumpAngle = 30;

//Friction
doAirFriction =true;
airFrictionValue = 0.05;
airFrictionMultiplierLerp = 0;

//knockback


//Collisions
onGround = false;
timeOffGround = 0;
groundBelow = noone;
mask = sprite_index;
wallInDirection = 0;
lastWallInDirection = 0;
slideCornerRange = 2;

//Squish Squash
squishX = 1;
squishY = 1;
squishOffset = 0.1;