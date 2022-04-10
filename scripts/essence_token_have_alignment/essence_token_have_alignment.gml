// @desc
//
//
//
function essence_token_have_alignment(_alignment) {

	var list = Player.essenceTokens;
		
	var l = ds_list_size(list);
	for (var i = 0; i < l; i++) {
		var token = list[| i];
				
		//Found a Suitable Token Slot
		if (token.alignment == _alignment) {
			if (token.percent == 100) {
				return true;
			}
		}	
	}
	
	return false;

}