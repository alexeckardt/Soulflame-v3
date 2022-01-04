/// @description 

event_inherited();

var keira = instance_nearest(x, y, oKeira);
depth = keira.depth + 5;

isSkipable = false;
returnControlToPlayer = false;
t_scene_info = [

	[cutscene_event_wait_time, 0.2],
	[cutscene_event_move_entity_to_position, keira, x - 18, false, 1],
	[cutscene_event_wait_time, 0.2],
	[cutscene_event_change_variable, keira, "directionFacing", 1],
	[cutscene_event_wait_time, 0.2],
	
	[cutscene_event_change_variable, keira, "STATE", state.sitdown],
		[cutscene_event_wait_variable, keira, "STATE", state.sit],
	
	[cutscene_event_change_variable, id, "playerSittingHere", true],
	[cutscene_event_wait_time, 0.2],
]

//Visuals
playerSittingHere = false;
displayFire = false;