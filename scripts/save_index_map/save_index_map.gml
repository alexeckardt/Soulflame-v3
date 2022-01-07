// @desc
//
//
//
function save_index_map(keyConstant, objId, save_data) {

	var map = variable_instance_get(objId, keyConstant);
	save_data[? keyConstant] = ds_map_write(map);

	return undefined
	
}