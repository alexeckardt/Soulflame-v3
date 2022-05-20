/// @description 
event_inherited();

align = 0;
target = noone;

randomize();

//Movement
phase = 0; //0 = emitting, 1 = holding, 2 = zoom to target
emitDirection = irandom(359);

travelDirection = emitDirection;
travelSpeed = random_range(2.5, 3);
zoomMaxSpeed = 6 + random_range(-1, 1);
holdTime = random(10); //Time in the stasis part
pauseBeforeEmitTime = 0; //Time before shooting out

directionLerpSpeed = 50; //decreases to 1 in phase 3

//Visuals
col = 0;

gobbleRadius = 0; //increases so no weird zooming goes on

partScript = -1; //Set Script