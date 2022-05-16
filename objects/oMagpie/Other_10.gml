/// @desc

function magpie_decide_reload_target() {
	
	reloadInstance = instance_nearest(x, y, oPlatinumBag);
	
	if (reloadInstance != noone) {
	
		reloadAreaX = reloadInstance.x;
		reloadAreaY = reloadInstance.y - 5; //go outside of the solid
		reloadIsABunfet = false;
		
	} else {
		
		//Check for a Bunfet
		reloadInstance = instance_nearest(x, y, oBunfet);
		
		if (reloadInstance != noone) {
			
			reloadIsABunfet = true;
			
		} 
	
	}

}
