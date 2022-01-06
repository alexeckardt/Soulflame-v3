// @desc
//
//Reads the map from the save_data DS, then saves it to a certian variable.
//
function load_index_map(keyConstant, objId, variableName, save_data) {

	var importedmap = ds_map_read(save_data[? keyConstant]);
	variable_instance_set(objId, variableName, importedmap);
	return undefined;
	
}