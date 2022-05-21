//
//DESC:
//
//Updates the effets to decrease the amount of campfires left before they are deleted
//
function effect_update_time_left() {

	var list = Player.effectList;
	var c = ds_list_size(list);

	//Check Exists
	if (ds_exists(list, ds_type_list)) {

		//Loop
		for (var i = 0; i < c; i++) {
	
			//Get Strut + Decrease Time
			var struct = list[| i];
			struct.campfiresLeft--;
			
			//No More Time
			if (struct.campfiresLeft <= 0) {
				
				//Delete
				delete struct;
				
				//Don't Mess Up the Iteration after delete
				i--;
				c--;
			}
			
		}
	
	}

	//End
	return 0;

}