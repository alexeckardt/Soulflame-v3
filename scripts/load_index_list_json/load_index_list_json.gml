// @desc
//
//Reads the LIST from the save_data DS, then saves it to a certian variable.
//
function load_index_list_json(keyConstant, objId, save_data) {

	var loadedString = ds_map_find_value(save_data, keyConstant);
	if (!is_undefined(loadedString)) {
		
		var myList= variable_instance_get(objId, keyConstant);
		
		var arrayFromJson = json_parse(loadedString);
		var count = array_length(arrayFromJson);
		
		ds_list_clear(myList);
		
		for (var i = 0; i < count; i++) {	
			ds_list_add(myList,arrayFromJson[i]);
		}
			
	}
	
	
	return undefined;
	
}