// @desc
//
//
//
function game_persistence_create_name_room_specific(subname) {

	var roomname = string(room_get_name(room));
	var instCreatedCount = 0;

	//Check how many names have been created
	with (object_index) {
		
		//Has it created a name for me? if not, it's not been initialized.
		if (variable_instance_exists(id, "storename")) {
			instCreatedCount++;
		}
		
	}

	//Create
	return roomname + subname + string(instCreatedCount);

}