// @desc
//
//
//
function save_index_list_json(keyConstant, objId, save_data) {

	var list = variable_instance_get(objId, keyConstant);
	var data_str = "["
	
	var c= ds_list_size(list);
	for (var i = 0; i < c; i++) {
		data_str += json_stringify(list[| i]) + ",";	
	}
	
	//Close
	data_str = string_replace_last(data_str, ",", "");
	data_str += "]"	
	
	//Store Json
	save_data[? keyConstant] = data_str;//json_stringify

	return undefined
	
}