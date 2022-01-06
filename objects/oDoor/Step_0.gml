/// @description 

//Collide With Player
if (place_meeting(x, y, oKeira)) {
	
	//Transition
	transition_create(oTransitionFade, roomTo, xTo, yTo, dirFacing,
			1, c_black, undefined, undefined);
}