// @desc
//
//
//
function keybind_get_controller_icon_sheet_id_from_string(keybind) {

	var k = string_replace(keybind, "^", "");
	var spriteReferencing = sControllerIconSheets;

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
			
		case "uiLeftPage":
			return 5;
		case "uiRightPage":
			return 7;
		case "uiUp":
			return 21;
		case "uiDown":
			return 43;
			
		case "continue":
			return 13;
		case "back":
			return 14;
			
	}

	//Never hit
	return 0;

}