//
//DESC:
//
//Adds a Percent of a Token
//
function essence_token_add_percent(_alignment, _integerPercent) {

	//Setup
	var percentLeftToAdd = _integerPercent;

	//List
	var list = Player.essenceTokens;
		
	//Mutate Current List
	for (var i = 0; i < Player.essenceTokensHolding; i++) {
				
		//Read Token
		var token = list[| i];
				
		//Found a Suitable Token Slot
		if (token.alignment == _alignment) {
			if (token.percent < 100) {
				
				//Calculate amount to Add to token
				var tokenAddingToPercent = clamp(percentLeftToAdd, 0, 100-currentTokensPercent);
				percentLeftToAdd -= tokenAddingToPercent;
				
				//Add To Token
				token.percent += tokenAddingToPercent;
			}
		}	
	}
	
	
	//Create New Tokens
	while (percentLeftToAdd > 0) {
			
		//If Space Available
		if (Player.essenceTokensHolding < Player.essenceTokensCanHold) {
			
			//Create a new token
			var newToken = new EssenceToken(_alignment);
			newToken.percent = min(100, percentLeftToAdd);
			percentLeftToAdd -= newToken.percent;
			
			//Add new token to list
			ds_list_add(list, newToken);
			
			//Counter Increase
			Player.essenceTokensHolding++;
			
		//No More Space;; Exit
		} else {
			break;	
		}
			
	}
	
	//Return Good
	return 0;
	
	
	
	/*
	//Index
	while (percentLeftToAdd > 0) {
		
		var tokensHolding = Player.essenceTokensHolding
	
		//Loop Through End Of List to find a token slot with correct assignmet
		//Otherwise Assume Last Slot		
		var indexToUpdate = tokensHolding;
		var currentTokensPercent = 0;
		
		if (tokensHolding > 0) {
			for (var i = 0; i < tokensHolding; i++) {
				
				//Read Token
				var token = list[| i];
				
				//Found a Suitable Token Slot
				if (token.alignment == _alignment) {
					if (token.percent < 100) {
						indexToUpdate = i;	
						currentTokensPercent = token.percent;
						break;
					}
				}	
			}
		}
		
		//Found a tokenID OR there is an empty spot available
		if (indexToUpdate < Player.essenceTokensCanHold) {
		
			//Decide Amount To Add (Keeps Inside Of 100 Percent)
			var tokenAddingToPercent = clamp(percentLeftToAdd, 0, 100-currentTokensPercent);
			percentLeftToAdd -= tokenAddingToPercent;
			
			//Create Token Array
			var tokenArray = [_alignment, currentTokensPercent + tokenAddingToPercent];
	
			//Set
			list[| indexToUpdate] = tokenArray;
			
			Player.essenceTokensHolding = ds_list_size(list);
		
		//Cannot Hold Anymore Essence, Exit Adding Loop
		} else {
			percentLeftToAdd = -1;
		}
	}*/
}