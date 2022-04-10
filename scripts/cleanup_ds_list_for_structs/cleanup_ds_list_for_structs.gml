//
//DESC:
//
//
//
function cleanup_ds_list_for_structs(list_id){
	if (ds_exists(list_id, ds_type_list)) {
		
		//Flag all points to be deleted
		var s = ds_list_size(list_id);
		for (var i = 0; i < s; i++) {
			//Delete Struct
			delete list_id[| i];
		}

		//destroy list
		ds_list_destroy(list_id);
	}
	
	//Return No List
	return -1;
}