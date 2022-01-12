/// @description 

//Kill The Instances
var arr = ds_map_values_to_array(characters);
for (var i = 0; i < array_length(arr); i++) {
	instance_destroy(arr[i]);	
}

//Destroy Map
cleanup_ds_map(characters);
cleanup_ds_list(effectList);