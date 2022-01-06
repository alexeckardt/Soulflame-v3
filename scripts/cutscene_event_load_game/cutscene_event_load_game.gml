// @desc
//
//
//
function cutscene_event_load_game() {

	load_game();
	
	//Force Cutscene Here
	scene = array_length(scene_info) + 1;
	cutscene_event_end_action();

}