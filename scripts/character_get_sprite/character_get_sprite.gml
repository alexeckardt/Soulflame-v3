// @desc
//
//
//
function character_get_sprite(char, emotion) {

	switch (char) {
		default:
			return sDialogueBaseShopVender;
		break;
		
		case character.keira:
			return sDialogueKeira;
		break;
			
		case character.base:
			return sDialogueBaseShopVender;
		break;
			
	}

}