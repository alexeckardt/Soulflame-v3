// @desc
//
//Waits unti a certian amount of time has passed.
//
//Skip Functionality: Nothing.
//
function cutscene_event_wait_time(seconds) {

	//Increment Timer
	timer += Game.delta;
	
	//Increment
	if (timer > seconds*room_speed || skipCutscene) {
		timer = 0;
		cutscene_end_action();	
	}

}