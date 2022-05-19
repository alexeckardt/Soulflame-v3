/// @description 

var layerArray = layer_get_all();

var s = array_length(layerArray);
for (var i = 0; i < s; i++) {

	//Get Name
	var layerId = layerArray[i];
	var layername = layer_get_name(layerId);
	var mutliplier = (string_last_pos("Z", layername) == 0) ? -1 : 1; //if string ends with "Z", it is a negative mutliplier
	
	var d = layer_get_depth(layerId);
	
	var doX = true;
	var doY = true;
	
	//If Name has ParalaxLayer in it
	if (string_pos("Env", layername)) {
		
		//Get The Multiplier Integer From The Name; turn it into multiplier
		var paralaxMultiplier = real(string_digits(layername)) / 100 * mutliplier;
		
		//Enviromnet Layer
		var layerObj = instance_create_depth(0, 0, d, EnvironmentLayer);
		layerObj.paralaxAmount = paralaxMultiplier;
		
		//Get All Elements On The Layer
		var layerElements = layer_get_all_elements(layerId);
		var elementCount = array_length(layerElements);
		for (var j = 0; j < elementCount; j++) {
			
			//Get Info
			var elementID = layerElements[j];
				
			//Create Element Object
			var struct_id = new EnvironmentObj(
									layer_sprite_get_x(elementID),
									layer_sprite_get_y(elementID));
			
			//Setup Object
			struct_id.set_sprite(layer_sprite_get_sprite(elementID));

			struct_id.index = layer_sprite_get_index(elementID);
			struct_id.index_speed = layer_sprite_get_speed(elementID);
			struct_id.blend = layer_sprite_get_blend(elementID)
			struct_id.rot = layer_sprite_get_angle(elementID)
			struct_id.alpha =layer_sprite_get_alpha(elementID)
			struct_id.xscale =layer_sprite_get_xscale(elementID)
			struct_id.yscale =layer_sprite_get_yscale(elementID)
			
			//Add Info to the List
			ds_list_add(
				layerObj.paralaxObjList, struct_id);
			
			//Destroy Layer Sprite (No Need; We delegated it to the struct)
			layer_sprite_destroy(elementID)
	
			//Increase Count
			layerObj.paralaxSpriteCount++;
		}
	}
}