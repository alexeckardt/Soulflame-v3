/// @description 


//Update Lights
for (var i = 0; i < lightCount; i++) {

	//Get
	var pointLight = pointLights[| i];
	
	//Update
	pointLight.update();
	
	//Delete
	if (pointLight.toDelete) {
		ds_list_delete(pointLights, i);
		delete pointLight;
		i--;
		lightCount--;
	}
}