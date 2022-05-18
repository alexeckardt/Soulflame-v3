/// @description 
event_inherited();

target = instance_nearest(x, y, oWispTarget);

randomize();

//Movement
phase = 0; //0 = emitting, 1 = zoom to target

travelDirection = -1;
travelSpeed = -1;
zoomMaxSpeed = 6 + random_range(-1, 1);

directionLerpSpeed = 50; //decreases to 1 in phase 3

//Visuals
col = 0;
gobbleRadius = 0; //increases so no weird zooming goes on

storename = game_persistence_create_name_room_specific("wisp");
checkedAlreadyDestroyed = false;

goalX = x;
goalY = y;
orgX = x;
orgY = y;

image_speed = 0.5;

interactRange = 128;
shootOffRange = 32;
