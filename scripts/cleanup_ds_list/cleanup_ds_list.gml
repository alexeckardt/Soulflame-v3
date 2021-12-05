//
//DESC:
//
//
//
function cleanup_ds_list(list_id){
	if (ds_exists(ds_type_list, list_id)) {
		ds_list_destroy(list_id);
	}
}