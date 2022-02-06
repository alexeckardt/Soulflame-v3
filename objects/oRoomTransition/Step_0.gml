/// @description 

alpha += fadeSpeed * alphaDirection * Game.delta;

//
if (alphaDirection == 1 && alpha > transitionAlphaReq) {

	//
	//Update
	if (switchRooms) {
			
		//Player Next Position
		Player.roomStartPlayerX = nextPX;
		Player.roomStartPlayerY = nextPY;
		Player.roomStartPlayerD = nextPD;
		
		
		//Update Next Room
		room = nextRoom;
		draw_texture_flush();
			
		//
		//Prep Transition Fade In
		Player.fadeInTransitionInfo = [object_index, otherinfo0, otherinfo1, otherinfo2];

		//Title Screen
		//if (roomTo == roomTitle) {	game_restart();	}
	
	//
	//
	//Move Player to Position
	} else {
		
		//Move Player
		var k = instance_nearest(x, y, oKeira);
		k.x = nextPX;
		k.y = nextPY;
		k.directionFacing = nextPD;
		
		//Reset State (Generic, maybe remove later?)
		k.STATE = state.base; 
		
		//Create Corresponding Fade in
		transition_create(object_index, undefined, 0, 0, 0, -1, otherinfo0, otherinfo1, otherinfo2, true);
		
	}

	//Destroy Me
	instance_destroy();
	
//
} else {
	
	//
	if (alphaDirection == -1 && alpha < 0) {	
		instance_destroy();
	}
}