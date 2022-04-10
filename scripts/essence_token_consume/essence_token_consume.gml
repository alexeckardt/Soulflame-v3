//
//DESC:
//
//
//
function essence_token_consume(count) {

	//Error Testing
	if (!essence_token_has_amount(count)) {
		throw "Tokens Lost between guarentee and consumption (Not enough tokens)";	
	}

	//
	//
	//
	
	//Create a list of ones to destroy;
	var toDeleteList = ds_list_create();
	var prefferedType = 0;
	var prefferedIndex = 0;
	
	var list = Player.essenceTokens;
	var tokenC = Player.essenceTokensHolding;
	
	var tokenCombinedAlignment = 0;
	
	for (var i = tokenC-1; i >= 0; i--) {
	
		var token = list[| i];
		
		//Make Sure Token Is Full
		if (token.percent >= 100) {
			
			//Save Type
			if (prefferedType == 0) {
				prefferedType = token.alignment;
			}
			
			//Save Token To List
			//
			
			//Save to end of preffered partition
			if (prefferedType == token.alignment) {
				ds_list_insert(toDeleteList, prefferedIndex, i);
				prefferedIndex++;
				
			//save to end of list (unpreffered partition)
			} else {
				ds_list_add(toDeleteList, i);		
			}
		}
	}
	
	
	
	
	//
	//Mark the tokens to be deleted
	for (var i = 0; i < count; i++) {
		var toRemoveID = toDeleteList[| i];
		list[| toRemoveID].markedToDelete = true;
		
		//Keep Track
		tokenCombinedAlignment += list[| toRemoveID].alignment;
	}
	
	//
	//Destroy List
	ds_list_destroy(toDeleteList);
	
	//Return
	return tokenCombinedAlignment;

}