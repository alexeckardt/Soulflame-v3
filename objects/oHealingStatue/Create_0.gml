/// @description 

event_inherited();

image_speed = 0;

glow = false;
glowbyProx = false;
glowAlpha = 0;
glowAlphaTo = 0;

glowProxActiveRange = 100;
glowProxMaxGlowRange = 30;

regIndex = 0;
darkIndex = 1;
glowOverlayIndex = 2;

persistenceId = "healing_statue_activated";


//Trigger
repeatable = true;
interactMessage = lang_get_text("ui.interact.interact");
interactable = true;

first_activate_scene = [

	//
	//inspect
	//
	[cutscene_event_change_variable, id, "interactable", false],
	
	[cutscene_event_wait_time, 0.25],
	[cutscene_event_keira_set_state, state.look_up],
	[cutscene_event_wait_time, 1],
	[cutscene_dialouge_base, "healstatue.inspect", [], 1, false, 1],
	[cutscene_event_wait_time, 0.25],
	[cutscene_dialouge_base, "healstatue.inspect.2", [], 1, false, 1],
	//
	//touch
	//
	[cutscene_event_keira_set_state, state.look_up],
	

];
