//
//DESC:
//
//Return Effect Multiplier of the effect. 0 if none.
//
function effect_has(_flower) {
	
	var list = Player.effectList;
	var c = ds_list_size(list);

	if (ds_exists(list, ds_type_list)) {

		for (var i = 0; i < c; i++) {
	
			//Get
			var struct = list[| i];
		
			//Check
			if (struct.effect = _flower) {
				
				//Found
				return struct.effectiveness;
				
			}
			
	
		}
	
	}

	//No Effect - Therefor 0 multiplier
	return 0;

}