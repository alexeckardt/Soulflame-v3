//
//DESC:
//
//
//
function command_tp(_x, _y, _relative){
	
	//Error Messages Off The Bat
	if (_relative == undefined) { _relative = false; }
	
	//Teleport
	if (_relative) {
		
		oKeira.x += _x;
		oKeira.y += _y;
		
	} else {
		
		oKeira.x = _x;
		oKeira.y = _y;
	
		
	}
	
	//Out
	outputMessage = "Teleported to (" 
				+ string(floor(oKeira.x)) + ", " + string(floor(oKeira.y)) + ")";
	
}