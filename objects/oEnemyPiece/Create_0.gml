/// @description 

hSpeed = 0;
vSpeed = 0;

bounce = true;
resetBounceWhenInAir = true;
funnyBounceChance = 10;

weight = 0.5;			// for slidng and interaction with player
bounceEnergyRetain = 0.2; //keep half of all v energy

pushResistance = 0.06;

wasOnGround = 0;

angle = 0;
angleSpeed = irandom_range(-10, 10);
image_speed = 0;

timeSinceOnGround = 0;

//Requird for Generic_colision_solid
myGrav = 0.2;
knockbackHSpeed = 0;
knockbackVSpeed = 0;
onGround = false;

//Halt Collision and movement computation
freeze = false;
