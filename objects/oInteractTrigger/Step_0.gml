 /// @description 

if (!instance_exists(Cutscene)) {

	if (place_meeting(x, y, oKeira)) {
		
		if (oKeira.inControl || !playerMustBeInControl) {
		
			//Wait for Input From Player
			//(This is done so only one trigger is activated)
			if (activate) {
		
				cutscene_create(t_scene_info);
				activate = false;

			}


		}
		
	}
	
}