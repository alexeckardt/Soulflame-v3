//
//DESC:
//
//
//
function command_room(_roomName) {

	//Verify
	command_verify_exists(_roomName, 0);
	
		
	if (_roomName == "reset") {
		firstRoom = true;
		room_restart();	
	}

	//Get Room ID
	var roomID = asset_get_index(_roomName);
	
	//Move or say error
	if (roomID != -1) {
		firstRoom = true;
		room = (roomID);
		
		
	} else {
		outputMessage = "Room with that name was not found.";	
	}
		
}