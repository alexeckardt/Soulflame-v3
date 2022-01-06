// @desc
//
//Returns a Map of the location of the player
//
function save_get_player_position(isNewSave) {


	//Get Positions
	if (!isNewSave) {
		savepointRoom	= room_get_name(room);
		savepointX		= oKeira.x;
		savepointY		= oKeira.y;
		savepointD		= oKeira.directionFacing;
	} else {
		savepointRoom	= 0//room_get_name(room);
		savepointX		= 0//oKeira.x;
		savepointY		= 0//oKeira.y;
		savepointD		= 0//oKeira.directionFacing;
	}
	
	//Create Map
	var savePoint = ds_map_create();
	var savepointRoom, savepointX, savepointY, savepointD
	
	//Put in Map
	savePoint[? "room_name"] = savepointRoom;
	savePoint[? "player_x"] = savepointX;
	savePoint[? "player_y"] = savepointY;
	savePoint[? "player_d"] = savepointD;
	
	//Save In Player
	Player.savePointRoom	= savepointRoom
	Player.savePointX		= savepointX;
	Player.savePointY		= savepointY;
	Player.savePointD		= savepointD;
	
	//Return
	return savePoint;

}