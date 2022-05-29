//
//DESC:
//
//
//
function command_tp(_x, _y){
	
	//Custom
	
	if (_y == undefined) {
		
		oKeira.y = 0;
		if (_x == "right") {	oKeira.x = room_width-32; oKeira.directionFacing = -1;	}
		if (_x == "left") {	oKeira.x = 32;oKeira.directionFacing = 1; } 
		
		for (var testY = 0; testY < room_height; testY+=16) {
		
			if (!position_meeting(oKeira.x, testY, Solid)) {
				if (position_meeting(oKeira.x, testY+16, Solid)) {
					oKeira.y = testY;
					break;
				}
			}
		}
		
		outputMessage = "Teleported to (" 
				+ string(floor(oKeira.x)) + ", " + string(floor(oKeira.y)) + ")";
		
		//Exit
		return;
	}
	
	//
	//Realtive Transfer
	if is_string(_x) && (string_pos("~", _x) == 1) { 
		_x = real(string_copy(_x, 2, string_length(_x)-1)); 
		_x = oKeira.x + _x;
	}
	if is_string(_y) && (string_pos("~", _y) == 1) { 
		_y = real(string_copy(_y, 2, string_length(_y)-1)); 
		_y = oKeira.y + _y;
	}
	
	//Teleport
	oKeira.x = _x;
	oKeira.y = _y;
	
	//Out
	outputMessage = "Teleported to (" 
				+ string(floor(oKeira.x)) + ", " + string(floor(oKeira.y)) + ")";
	
}