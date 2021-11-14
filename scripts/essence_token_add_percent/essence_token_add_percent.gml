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
		
	
	//Index
	while (percentLeftToAdd > 0) {
		
		var c = ds_list_size(list);
	
		//Loop Through End Of List to find a token slot with correct assignmet
		//Otherwise Assume Last Slot		
		var indexToUpdate = c;
		var currentTokensPercent = 0;
		
		if (c > 0) {
			for (var i = 0; i < c; i++) {
				var tokenInfo = list[| i];
		
				var tokenAlignment = tokenInfo[0];
				var tokenPercent = tokenInfo[1];
				
				//Found a Suitable Token Slot
				if (tokenAlignment == _alignment) {
					if (tokenPercent < 100) {
						indexToUpdate = i;	
						currentTokensPercent = tokenPercent;
					}
				}	
			}
		}
		
		//Update
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
	}
}