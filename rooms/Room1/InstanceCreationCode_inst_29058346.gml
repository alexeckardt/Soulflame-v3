
interactable = true;
repeatable = true;
interactMessage = "Shoot into Sky";
activate = false;

t_scene_info = [

	[cutscene_event_wait_time, 2],
	[cutscene_event_change_variable, instance_nearest(x, y, oKeira), "y", -50],

]