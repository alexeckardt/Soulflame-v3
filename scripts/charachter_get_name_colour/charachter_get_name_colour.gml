// @desc
//
//
//
function charachter_get_name_colour(charachterId) {

	switch (charachterId) {
		default:
			return c_white;
			
		case character.keira:
			return Game.textBalancedCol;	
		
		case character.hugo:
			return bgr($ffd295);
			
		case character.adaline:
			return bgr($f495ff);

	}

}