// @desc
//
//
//
function save_index_grid(keyConstant, objId, save_data) {

	var grid = variable_instance_get(objId, keyConstant);
	save_data[? keyConstant] = ds_grid_write(grid);

	return undefined
	
}