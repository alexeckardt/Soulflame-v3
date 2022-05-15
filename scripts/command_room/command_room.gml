//
//DESC:
//
//
//
function command_room(_roomName) {

	//Verify
	command_verify_exists(_roomName, 0);

	if (_roomName == "reset") {
		room_restart();	
		firstRoom = true;
	}

	//Get Room ID
	var roomID = asset_get_index(_roomName);
	
	//Move or say error
	if (roomID != -1) {
		
		room = (roomID);
		firstRoom = true;
		
		
	} else {
		outputMessage = "Room with that name was not found.";	
	}
		
}