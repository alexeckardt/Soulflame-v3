
//Select Whether Or Not To Use The Drawing or Not Script

function title_script_settings(_drawing, _globAlpha){
	
	if (_drawing) exit;
	
	if (!instance_exists(PauseMenu)) {
		
		if (!createdMenu) {
		
			//Don't Create Mutliple
			createdMenu = true;
			
			//Create
			Game.paused = true;
		
		} else {
			
			//Reset Page
			pageOn = -1;
			
		}
	}
}
