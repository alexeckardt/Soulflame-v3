//
//DESC:
//
//
//
function player_update_essence_tokens(){

	//Loop over all tokens
	var count = ds_list_size(essenceTokens);
	for (var i = 0; i < count; i++) {
		
		//Get Token Info
		var token = essenceTokens[| i];

		//
		//
		if (!token.markedAsDeleted) {
		
			//
			//NORMAL BEHAVIOUR
			//
		
			//Generic Behaviour -- fuller percent = fuller index
			var spr = token.sprite;
			var indexes = sprite_get_number(spr);
		
			var p = token.percent / 100;
			token.index = floor((indexes-1) * p);
		
		} else {
			
			//
			//DELETE BEHAVIOUR
			//
			
			//Animate this until destroy
			var animateDestructionSpeed = 0.2;
			token.index += animateDestructionSpeed;
			
			if (token.index > sprite_get_number(token.sprite) - animateDestructionSpeed) {
				
				delete token;
				ds_list_delete(essenceTokens, i); //Delete said index as it's over
				i--;
				count--;
				Player.essenceTokensHolding--;
				
			}
			
		}
		
	}


}