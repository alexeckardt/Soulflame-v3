/// @description 

if (!instance_exists(Cutscene)) {

	if (place_meeting(x, y, oKeira)) {
		
		if (oKeira.inControl || !playerMustBeInControl) {
		
			cutscene_create(t_scene_info);

		}
		
	}
	
}