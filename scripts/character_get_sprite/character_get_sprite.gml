// @desc
//
//
//
function character_get_sprite(char, emotion) {

	switch (char) {
		default:
			return sDialougeBaseShopVender;
		break;
		
		case character.keira:
			return sDialougeKeira;
		break;
			
		case character.base:
			return sDialougeBaseShopVender;
		break;
			
	}

}