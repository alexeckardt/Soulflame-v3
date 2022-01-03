/// @description 


if (scene_info == -1) {
	show_debug_message("Cutscene is Empty!");
	scene_info = [[cutscene_event_end_action, ]]
}

   
//Get Scene
current_scene = scene_info[scene];

//Clear Array
current_scene_args = -1;

//Create New Array, the tail of the first
var len = array_length(current_scene)-1;
current_scene_args = array_create(len, 0);
array_copy(current_scene_args, 0, current_scene, 1, len);
