//
//DESC:
//
//Returns Boolean TF if we have the required FULL tokens.
//
function essence_token_has_amount(count) {

	var fullTokenCount = 0;

	//Check each token
	//(Because earlier tokens can have less than full; we need to check
	//all until we've found enough fulls)
	var list = Player.essenceTokens;
	var listc = ds_list_size(list);
	for (var i = 0; i < listc; i++) {
		
		var token = list[| i];
		var tokenPercent = token.percent;
		
		//If not 100, means we don't have full token
		if (tokenPercent >= 100) {
			fullTokenCount++;
			
			//has enough?
			if (fullTokenCount >= count) {
				return true;
			}
		}
	}

	//Not enough tokens
	return false;

}