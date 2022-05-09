// @desc
//
//
//
function enemy_generic_update_see_pos() {

	//Check Seen
	if (enemy_check_target_visible()) {
		
		//Update Vars
		seesTarget = true;
		lastSawTargetX = target.x;
		lastSawTargetY = target.y;
		
		sinceSeenTarget = 0;
		
		//Seen
		return 1;
		
	}

	//Not Seen
	return 0;

}