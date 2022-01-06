//
//DESC:
//
//
//
function cleanup_ds_grid(grid_id){
	if (ds_exists(grid_id, ds_type_grid)) {
		ds_list_destroy(grid_id);
	}
}