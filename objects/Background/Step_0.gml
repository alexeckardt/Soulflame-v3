/// @description 

//Update Layers
for (var i = 0; i < layerCount; i++) {
	
	var layerStruct = layerInfo[| i];
	layerStruct.update();
	
}

//Get Surface
if (instance_exists(Camera)) {
	surfToDrawOn = Camera.id.bkgSurf;	
}
