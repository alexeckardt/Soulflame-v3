/// @description 

alpha += fadeSpeed * alphaDirection * Game.delta;

//
if (alphaDirection == 1 && alpha > transitionAlphaReq) {
	
	//Player Next Position
	Player.roomStartPlayerX = nextPX;
	Player.roomStartPlayerY = nextPY;
	Player.roomStartPlayerD = nextPD;
		
	//
	//Update
	if (switchRooms) {
		
		//Update Next Room
		room = nextRoom;
		draw_texture_flush();
			
		//Title Screen
		//if (roomTo == roomTitle) {	game_restart();	}
	}
		
	//
	//Prep Transition Fade In
	Player.fadeInTransitionInfo = [object_index, otherinfo0, otherinfo1, otherinfo2];

	//Destroy Me
	instance_destroy();
	
//
} else {
	
	//
	if (alphaDirection == -1 && alpha < 0) {	
		instance_destroy();
	}
}