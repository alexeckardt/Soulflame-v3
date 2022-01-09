/// @description 

value = 1;

image_speed = 0;
index_speed = 0.3;

hSpeed = 0;
vSpeed = 0;

collected = false;
spinNow = false;

lifeTick = 0;
collectionAfterTime = room_speed/2;
hasHitGroundOnce = false;

grav = 0.2;

//for generic_collide_solid()
timeSinceOnGround = 0;
knockbackHSpeed = 0;
knockbackVSpeed = 0;