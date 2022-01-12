// @desc
//
//
//
function character_get_name(charachterId) {

	switch (charachterId) {
		default:
			return "";
			
		case character.keira:
			return lang_get_text_no_pointers("player.name");
			
		case character.hugo:
			return lang_get_text_no_pointers("char.name.hugo");
			
		case character.adaline:
			return lang_get_text_no_pointers("char.name.adaline");
			
		//case character.keira:
			//return lang_get_text_no_pointers("player.name");
			
	}

}