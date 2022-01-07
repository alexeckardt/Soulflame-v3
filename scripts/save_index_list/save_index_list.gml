// @desc
//
//
//
function save_index_list(keyConstant, objId, save_data) {

	var list = variable_instance_get(objId, keyConstant);
	save_data[? keyConstant] = ds_list_write(list);

	return undefined
	
}