/// @description 

var layerArray = layer_get_all();

var s = array_length(layerArray);
for (var i = 0; i < s; i++) {

	//Get Name
	var layerId = layerArray[i];
	var layername = layer_get_name(layerId);
	var mutliplier = (string_last_pos("Z", layername) == 0) ? -1 : 1; //if string ends with "Z", it is a negative mutliplier
	
	var d = layer_get_depth(layerId);
	
	//Enviromnet Layer
	var layerObj = instance_create_depth(0, 0, d, EnvironmentLayer);
	
	var doX = true//string_last_pos("X", layername) != 0;
	var doY = true//string_last_pos("Y", layername) != 0;
	
	//If Name has ParalaxLayer in it
	if (string_pos("Env", layername)) {
		
		//Get The Multiplier Integer From The Name; turn it into multiplier
		var paralaxMultiplier = real(string_digits(layername)) / 100 * mutliplier;
		
		//Get All Elements On The Layer
		var layerElements = layer_get_all_elements(layerId);
		var elementCount = array_length(layerElements);
		for (var j = 0; j < elementCount; j++) {
			
			//Get Info
			var elementID = layerElements[j];
				
			//Create Object
			var object_id = instance_create_depth(
									layer_sprite_get_x(elementID),
									layer_sprite_get_y(elementID),
									d,
									EnvironmentSprite);
				
			//Setup Object
			object_id.sprite_index = layer_sprite_get_sprite(elementID);
			object_id.image_index = layer_sprite_get_index(elementID);
			object_id.sprite_speed = layer_sprite_get_speed(elementID);
			object_id.image_blend = layer_sprite_get_blend(elementID)
			object_id.image_angle = layer_sprite_get_angle(elementID)
			object_id.image_alpha =layer_sprite_get_alpha(elementID)
			object_id.image_xscale =layer_sprite_get_xscale(elementID)
			object_id.image_yscale =layer_sprite_get_yscale(elementID)
			
				
			//Add Info to the List
			ds_list_add(
				layerObj.paralaxObjList, [object_id, paralaxMultiplier*doX, paralaxMultiplier*doY]);
			
			//Destroy Layer Sprite (No Need)
			layer_sprite_destroy(elementID)
	
			//Increase Count
			layerObj.paralaxSpriteCount++;
		}
	}
}