
//Check if Key Exists
var wisp = instance_nearest(x, y, oWisp);
var mem = instance_nearest(x, y, oMemory);
var k = instance_nearest(x, y, oKeira);
var key = mem.map_id;
if (game_persistence_check(key) != undefined) {
	instance_destroy();	
}


t_scene_info = [

	[cutscene_wait_time, 1],
	[cutscene_event_move_entity_to_position, k, wisp.x+10, false, 2],
	[cutscene_wait_time, 1],
	[cutscene_event_keira_set_cutscene_sprite, sKeiraLookUp, 0, true],
	[cutscene_wait_time, 0.5],
	[cutscene_event_keira_set_cutscene_sprite, sKeiraCutsceneTouchWisp, 0.1, false],
	[cutscene_wait_time, 2],
	
	//Make the Wisp Shoot Off
	[cutscene_event_change_variable, wisp, "shootOffRange", 500],
	[cutscene_wait_time, 0.2],
	[cutscene_event_keira_set_state, state.base],
	
	[cutscene_wait_instance_destroyed, wisp],
	[cutscene_wait_time, 1.2],
	[cutscene_event_move_entity_to_position, k, 64, true, 2],
	[cutscene_wait_time, 1.5],

	//Reveal the Memory
	[cutscene_event_change_variable, mem, "active", 1],
	[cutscene_wait_time, 0.5],
]


