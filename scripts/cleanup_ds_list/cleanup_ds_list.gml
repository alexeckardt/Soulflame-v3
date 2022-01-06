//
//DESC:
//
//
//
function cleanup_ds_list(list_id){
	if (ds_exists(list_id, ds_type_list)) {
		ds_list_destroy(list_id);
	}
}