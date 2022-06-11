/// @description 

var tt = (independentDelta) ? Game.independentDelta : Game.delta;
alpha += fadeSpeed * alphaDirection * tt;

//
if (alphaDirection == 1 && alpha > transitionAlphaReq) {

	//
	//Update
	if (switchRooms) {
			
		
		//Update Next Room
		if (loadInstead) {
	
			//
			//This is done to skip the load transition;
			//And so artifcats such as Player State
			//Updating or PLatinum count starts while the transtition
			//BEGINS (so it doesn't look so dumb)
			
			//
			//This is also an error case for when you die.
			//
		
			load_game(undefined, false);
			
			//Go
			room = asset_get_index(Player.savePointRoom);
			nextPX = Player.savePointX;
			nextPY = Player.savePointY;
			nextPD = Player.savePointD;

			draw_texture_flush();
			
			//Make Sure
			paused = false;
	
		} else {
		
			room = nextRoom;
			draw_texture_flush();
		
		}
		
		//Player Next Position
		Player.roomStartPlayerX = nextPX;
		Player.roomStartPlayerY = nextPY;
		Player.roomStartPlayerD = nextPD;
		Player.roomStartindependentDelta = independentDelta;
		
			
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
		var t = transition_create(object_index, undefined, 0, 0, 0, -1, otherinfo0, otherinfo1, otherinfo2, true);
		
		//F
		t.freezePlayer = true;
		
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