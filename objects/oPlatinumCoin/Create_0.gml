/// @description 

value = 1;

image_speed = 0;
index_speed = random_range(0.1, 0.3);
image_index = irandom(image_number);
spinDir = choose(-1, 1);
yoffset = irandom_range(-2, 2);

bounceOffset = irandom(300);
bounceTime = irandom_range(500, 900)
bounceAmplitude = random_range(4/3, 2)

hSpeed = 0;
vSpeed = 0;

weight = random_range(1.75, 2);

collected = false;
lifeTick = 0;
collectionAfterTime = room_speed/2;
hasHitGroundOnce = false;

grav = 0.2;

//for generic_collide_solid()
timeSinceOnGround = 0;
knockbackHSpeed = 0;
knockbackVSpeed = 0;