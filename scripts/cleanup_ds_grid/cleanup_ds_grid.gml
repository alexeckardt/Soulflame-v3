//
//DESC:
//
//
//
function cleanup_ds_grid(grid_id){
	if (ds_exists(grid_id, ds_type_grid)) {
		ds_grid_destroy(grid_id);
	}
}