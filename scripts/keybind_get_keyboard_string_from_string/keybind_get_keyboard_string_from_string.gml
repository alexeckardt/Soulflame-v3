//
//DESC:
//
//
//
function keybind_get_keyboard_string_from_string(keybindStr) {

	//Replace any weirdness
	var k = string_replace(keybindStr, "^", "");

	//Get
	switch (k) {
		
		default:
			return "";
		case "heal":
			return Controller.healKey;
		case "jump":
			return Controller.jumpKey;
		case "attack":
			return Controller.combatKey;
		case "interact":
			return Controller.interactKey;
			
		case "uiLeftPage":
			return Controller.inventoryLeftPageKey;
		case "uiRightPage":
			return Controller.inventoryRightPageKey;
		case "uiUp":
			return Controller.upKey;
		case "uiDown":
			return Controller.downKey;
			
		case "continue":
			return Controller.uiSelectKey;
		case "back":
			return Controller.combatKey;
			
	}

	//Never hit
	return 0;

}