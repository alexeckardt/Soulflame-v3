/// @desc

//Setup
mask = sKeiraIdle;
hitbox = hitbox_create_alt(oKeiraHitbox, x, y-12, 15, 23, false);


//Sprites
idleSprite = sKeiraIdle;
readySprite = sKeiraIdleReadyNoWeapon;
attackSprite = sKeiraAttackNoWeaponPunch0;


//Display
index_speed = 0;
weapon_sprite = -1;
displayWeaponSprite = false;
displayWeaponParticles = false;
displayReadyPosForTime = -1


//Speed
controlHSpeed = 0; //What I'm Controlling
controlVSpeed = 0; //What I'm Controlling
hSpeed = 0; //Real, Updates outside
vSpeed = 0;

runSpeed = 2.5;

//States
STATE = state.base;
inControl = true
directionFacing = 1;
visualDirectionFacing = 0;
resetStateOnAnimationFinish = false;

//Climbing
climbingGravMulti = 1/3
lastOnFloorAtY = y;
lastOnFloorAtX = x;

//Gravity & Jumping
jumpSpeed = -4.8;
myGrav = 0.25;
terminalVelocity = 10;
halfGravityThreshold = 0.7;
forceHalfGravity = false;
allowHalfGravity = true;
cutVspd = false;

//Jump
forceJump = false;
jumpTicks = 0;
jumpCooldownTicks = 0;		
coyoteeMaxTime = 6;				
bouncingOffEnemy = false;
preLandJumpsTime = 7			
bounceJumpCoefficient = 0.7;

//Climbing
wallClimbCoyoteeTime = 6	
canVerticalClimb = false;  //current control variable ; replace later
timeNotClimbing = -1;
climbingTermVel = 0.5;
wallJumpSpeed = jumpSpeed * 0.95;
wallJumpAngle = 30;
hasJumpedOffWallSinceOnGround = false;
timeNotClimbingBeforeReconnect = room_speed/2;
wallClingVerticalJumpWallPushOffForce = 1.2

//Friction
doAirFriction =true;
airFrictionValue = 0.05;
airFrictionMultiplierLerp = 0;

//knockback
invulnerableTicks = 0

//Collisions
onGround = false;
timeOffGround = 0;
groundBelow = noone;
mask = sprite_index;
wallInDirection = 0;
lastWallInDirection = 0;
slideCornerRange = 5;

//Squish Squash
squishX = 1;
squishY = 1;
squishOffset = 0.1;

//Weapons & Attacking
allowControlOverIndex = -1;
nextAttack = 0;
wantToChangeAttackTicks = 0;
timeForPreAttacks = 8;

//Damage Vars
damageCreateBaseDamage = 0;
damageCreateDamageType = 0;
damageCreateXoffset	= 0;
damageCreateYoffset	= 0;
damageCreateWidth	= 0;
damageCreateHeight	= 0;
damageKnockbackMulti = 0;
damageKnockbackAddHSpeed = 0;
damageKnockbackAddVSpeed = 0;
damageKnockbackAddHspeedRelative = 0;

