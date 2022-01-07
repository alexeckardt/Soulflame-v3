// @desc
//
//Reads the GRID from the save_data DS, then saves it to a certian variable.
//
function load_index_grid(keyConstant, objId, save_data) {

	var loadedString = ds_map_find_value(save_data, keyConstant);
	if (!is_undefined(loadedString)) {
		var myGrid = variable_instance_get(objId, keyConstant);
		ds_grid_read(myGrid, loadedString);
	}
	
	return undefined;
	
}