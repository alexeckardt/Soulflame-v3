/// @description 

if (surface_exists(surfToDrawOn)) {
	
	//Set Surf
	surface_set_target(surfToDrawOn);
	
		//Loop
		for (var i = 0; i < layerCount; i++) {
			//Get
			var layerStruct = layerInfo[| i];
			layerStruct.draw(Camera.zoom);
		}
	
	surface_reset_target();
	
}
