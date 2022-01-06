/// @description 

myPath = path_add();
path_set_kind(myPath, 1);
path_set_precision(myPath, 8);

createdPath = false;

creator = noone;
rangeTravel = 20;

goingToPosition = false;
objectFollowing = oKeira;
goToX = objectFollowing.x;
goToY = objectFollowing.y;

posXoffset = 0;
posYoffset = 0;

pathFailed = false;

drawX = 0;
drawY = 0;

active = false;

atEndOfPath = false;

airborne = false;
tryToUnstuckAirborne = true;