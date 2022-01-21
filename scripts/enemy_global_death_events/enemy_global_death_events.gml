// @desc
//
//
//
function enemy_global_death_events(){
	
	//Dust
	var bbox_w = abs(bbox_right - bbox_left);
	var bbox_h = abs(bbox_bottom - bbox_top);
	
	var centerbboxX = bbox_left + bbox_w/2;
	var centerbboxY = bbox_top + bbox_w/2;
	
	var dustDensity = 1/5;
	var am = bbox_w * bbox_h * dustDensity;
	particle_create_dust(bbox_left, bbox_bottom-5, bbox_right, bbox_bottom+5, am);

	//Drop Platinum
	var amount = floor(platinumDrop * (1 + random_range(-platinumDropRange, platinumDropRange)));
	amount = max(0, amount);
	var currentVel = point_distance(0, 0, hSpeed, vSpeed);
	var currentDir = point_direction(0, 0, hSpeed, vSpeed);
	
	var vel = max(2, currentVel);
	
	platinum_create(centerbboxX, centerbboxY, amount, 5, vel/2, vel, currentDir, 10, vel/3);

}