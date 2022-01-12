// @desc
//
//
//
function cutscene_path_run_event(pathSelectedId, event_scene_info) {

	if (optionSelected == pathSelectedId) {
		
		//Get The Scene Script
		var s = event_scene_info[0];
		
		//Get The Scene Args
		var len = array_length(event_scene_info)-1;
		var sceneArgs = array_create(len, 0);
		array_copy(sceneArgs, 0, event_scene_info, 1, len);

		//Run The Events
		script_execute_alt(s, sceneArgs);
		
	} else {
		
		//Skip This
		cutscene_event_end_action();
	
	}
	
	
}