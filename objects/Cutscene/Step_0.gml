/// @description 

if (!dead) {

	if (scene_info == -1) {
		show_debug_message("Cutscene is Empty!");
		scene_info = [[cutscene_event_end_action, ]]
	}

	script_execute_alt(current_scene[0], current_scene_args);

}
