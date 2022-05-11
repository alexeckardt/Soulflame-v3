// @desc
//
//
//
function keybind_get_controller_icon_sheet_id(keybind) {

	var k = string_replace(keybind, "^", "");

	//Get
	switch (k) {
		
		default:
			return 15;
		case "heal":
			return 0;
		case "jump":
			return 13;
		case "attack":
			return 12;
		case "interact":
			return 11;		
	}

	//Never hit
	return 0;

}