// @desc
//
//
//
function save_index_map(keyConstant, objId, variableName, save_data) {

	var map = variable_instance_get(objId, variableName);
	save_data[? keyConstant] = ds_map_write(map);

	return undefined
	
}