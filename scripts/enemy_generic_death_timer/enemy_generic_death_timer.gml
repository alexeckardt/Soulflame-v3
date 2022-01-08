// @desc
//
//
//
function enemy_generic_death_timer(){

	//Dead States
	if (STATE == state.dead) {
	
		//Run Event 2 (Through End Step)
		if (deadTicks > deadStaggerForTime) {
			STATE = state.deadexplode;
		}
	}

}