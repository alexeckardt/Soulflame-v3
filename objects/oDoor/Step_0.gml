/// @description 

//Collide With Player
if (place_meeting(x, y, oKeira) && oKeira.hasBeenInRoom) {
	
	//Transition
	transition_create(oTransitionFade, roomTo, xTo, yTo, dirFacing,
			1, c_black, undefined, undefined);
			
}

//
//
if (!moved) {
	
	if (x < 16) x-=16;
	if (x > room_width-16) x+=16;
	
	if (y < 16) y-=32;
	if (y > room_height-16) y+=16;
	
	moved = true;
}
