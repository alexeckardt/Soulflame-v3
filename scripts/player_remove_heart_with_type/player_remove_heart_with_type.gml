//
//DESC:
//
//
//
function player_remove_heart_with_type(_type) {

	var heartsInList = ds_list_size(heartList);
	for(var i = 0; i < heartsInList; i++) {
		
		//Check
		var heart = heartList[| i];
		if (heart.heartType == _type) {
			
			//Delete from Memory
			delete heart;
			ds_list_delete(heartList, i);
			
			return 0;
		}
	}

	//No hearts deleted
	return 1;

}