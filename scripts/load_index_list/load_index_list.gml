// @desc
//
//Reads the LIST from the save_data DS, then saves it to a certian variable.
//
function load_index_list(keyConstant, objId, save_data) {


	var loadedString = ds_map_find_value(save_data, keyConstant);
	if (!is_undefined(loadedString)) {
		var myList = variable_instance_get(objId, keyConstant);
		ds_list_read(myList, loadedString);
	}
	
	
	return undefined;
	
}