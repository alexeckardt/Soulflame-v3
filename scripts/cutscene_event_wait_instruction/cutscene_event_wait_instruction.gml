// @desc
//
//
//
function cutscene_event_wait_instruction() {

	//Wait
	if (!instance_exists(Instruction)) {
		cutscene_event_end_action();	
	}

}