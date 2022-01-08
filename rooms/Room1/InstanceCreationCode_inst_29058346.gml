
interactable = true;
repeatable = true;
interactMessage = lang_get_text("ui.interact.silly");
activate = false;

t_scene_info = [

	[cutscene_event_wait_time, 2],
	[cutscene_event_change_variable, instance_nearest(x, y, oKeira), "controlVSpeed", -15],

]
