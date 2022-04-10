// @desc
//
//
//
function essence_token_have_alignment(_alignment) {

	var list = Player.essenceTokens;
		
	var l = ds_list_size(list);
	for (var i = 0; i < l; i++) {
		var tokenInfo = list[| i];
		
		var tokenAlignment = tokenInfo[0];
		var tokenPercent = tokenInfo[1];
				
		//Found a Suitable Token Slot
		if (tokenAlignment == _alignment) {
			if (tokenPercent == 100) {
				return true;
			}
		}	
	}
	
	return false;

}