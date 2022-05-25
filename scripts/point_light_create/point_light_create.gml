// @desc
//
//
//
function point_light_create(xx, yy, spd, moveDir, moveDirVariance, life, startCol, endCol) {

	//Create
	var light = new PointLight(xx, yy);
	light.active = true;
	
	light.spd = spd;
	light.dir = moveDir + random_range(-moveDirVariance, moveDirVariance);
	
	light.life = life;
	light.startingLife = life;
	
	light.colour = startCol;
	light.startCol = startCol;
	light.endCol = endCol;
	
	//Add
	if (Game.delta > 0) {
		var controller = Camera.pointLightController;
		ds_list_add(controller.pointLights, light);
		controller.lightCount++;
	}
	
	//Return
	return light;

}