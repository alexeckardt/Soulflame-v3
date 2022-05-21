// @desc
//
//
//
function keybind_draw_keyboard_icon(xx, yy, keybind, short = false) {

	var key = keybind_get_keyboard_string_from_string(keybind);

	//Get the Key
	var str = key;
	
	//If The Key is a special case; replace it with a different string
	switch (key) {
		case vk_lalt:	str = Lang.keyStringLALT;break;
		case vk_ralt:	str = Lang.keyStringRALT;break;
		case vk_space:	str = Lang.keyStringSPACE;break;
		case vk_lcontrol: str = Lang.keyStringLCTRL;break;
		case vk_rcontrol: str = Lang.keyStringRCTRL;break;
		case vk_tab:	str = Lang.keyStringTAB;break;
		case vk_lshift: str = Lang.keyStringLSHIFT;break;
		case vk_rshift: str = Lang.keyStringRSHIFT;break;
		
		case vk_down:	str = Lang.keyStringDownArrow;break;
		case vk_up:		str = Lang.keyStringUpArrow;break;
		case vk_left:	str = Lang.keyStringLeftArrow;break;
		case vk_right:	str = Lang.keyStringRightArrow;break;
	}
	
	//Draw
	draw_text(xx, yy, str);

}