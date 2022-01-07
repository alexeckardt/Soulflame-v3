// @desc
//
//Reads the map from the save_data DS, then saves it to a certian variable.
//
function load_index_map(keyConstant, objId, save_data) {

	var loadedString = ds_map_find_value(save_data, keyConstant);
	if (!is_undefined(loadedString)) {
		var myMap = variable_instance_get(objId, keyConstant);
		ds_list_read(myMap, loadedString);
	}
	
	return undefined;
	
}