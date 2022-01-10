//
//DESC:
//
//
//
function cleanup_ds_map(map_id){
	if (ds_exists(map_id, ds_type_map)) {
		ds_map_destroy(map_id);
	}
}