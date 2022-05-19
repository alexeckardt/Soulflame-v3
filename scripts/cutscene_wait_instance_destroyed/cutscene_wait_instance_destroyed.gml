// @desc
//
//
//
function cutscene_wait_instance_destroyed(instId) {

	//Wait
	if (!instance_exists(instId)) {
		cutscene_event_end_action();	
	}

}