
interactable = true;
repeatable = true;
interactMessage = "Shoot into Sky";
activate = false;

t_scene_info = [

	[cutscene_event_wait_time, 2],
	[cutscene_event_variable_set, instance_nearest(x, y, oKeira), "y", -50],

]