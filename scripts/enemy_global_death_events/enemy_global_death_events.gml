// @desc
//
//
//
function enemy_global_death_events(){
	
	//Dust
	var dustDensity = 1/5;
	var am = abs((bbox_right - bbox_left) * (bbox_bottom - bbox_top)) * dustDensity;
	particle_create_dust(bbox_left, bbox_bottom-5, bbox_right, bbox_bottom+5, am);

}