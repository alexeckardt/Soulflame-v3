/// @description 

event_inherited();

var keira = instance_nearest(x, y, oKeira);
depth = keira.depth - 5;

campfireId = game_persistence_create_name_room_specific("campfire");
var imLastCampfire = (Player.lastCampfireSatAtId == campfireId);

isSkipable = false;
returnControlToPlayer = false;
t_scene_info = [

	[cutscene_wait_time, 0.2],
	[cutscene_event_move_entity_to_position, keira, x - 18, false, 1],
	[cutscene_wait_time, 0.2],
	[cutscene_event_change_variable, keira, "directionFacing", 1],
	[cutscene_wait_time, 0.2],
	
	[cutscene_event_change_variable, keira, "STATE", state.sitdown],
		[cutscene_wait_variable, keira, "STATE", state.sit],
	
	[cutscene_event_change_variable, id, "playerSittingHere", true],
	[cutscene_event_change_variable, id, "lit", true],
	[cutscene_wait_time, 0.2],
	
	[cutscene_event_save_game, false],
]

//Visuals
playerSittingHere = false;
displayFire = imLastCampfire;
lit = imLastCampfire;
playerWASSittingHere = false;

interactMessage = lang_get_text("ui.interact.rest");

litPercent = imLastCampfire;
fireIndex = 0;
flameFrequencyStrength = 0;

flameColour = c_gray;

healTicks = 0;
healTime = room_speed/6;

flameYoffset = -11;
myLight = light_source_create(x, y+flameYoffset, false);