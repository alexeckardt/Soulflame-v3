//
//DESC:
//
//
//
function player_recheck_heart_count(_heartType) {
	
	var types = [0, 0,];
	
	var heartsInList = ds_list_size(heartList);
	for(var i = 0; i < heartsInList; i++) {
		
		//Check
		var heart = heartList[| i];
		types[heart.heartType] += 1;
		
	}

	return types;

}