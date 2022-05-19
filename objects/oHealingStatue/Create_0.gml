/// @description 

event_inherited();

image_speed = 0;

glow = false;
glowbyProx = 0;
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
interactMessage = lang_get_text("ui.interact.inspect");
interactable = true;

//Cutscene
var k = oKeira.id;
first_activate_scene = [

	//
	//inspect
	//
	
	//
	//Position keira
	//
	[cutscene_event_change_variable, id, "interactable", false],
	[cutscene_event_change_variable, Player.id, "showHearts", false],
	
	[cutscene_wait_time, 0.25],
	[cutscene_event_move_entity_to_position, k, x-24, false, 2],
	[cutscene_wait_time, 0.1],
	[cutscene_event_change_variable, k, "directionFacing", 1],
	[cutscene_wait_time, 0.1],
	[cutscene_event_keira_set_cutscene_sprite, sKeiraLookUp, 0, 0],
	
	
	//
	//Inspect
	//
	[cutscene_wait_time, 1],
	[cutscene_dialouge_base_no_chars, "healstatue.inspect", 1],
	[cutscene_wait_time, 1],
	[cutscene_dialouge_base_no_chars, "healstatue.inspect.2", 1],
	//
	//touch
	//
	[cutscene_event_keira_set_state, state.base],
	[cutscene_event_move_entity_to_position, k, x-16, false, 2],
	[cutscene_wait_time, 1],
	
	//Activate Stone
	[cutscene_event_change_variable, id, "glow", true],
	[cutscene_wait_time, 1],
	[cutscene_event_change_variable, Player.id, "hp", 4],
	
	//Cool Effects to show keira get's something in memory

	//Give Player Essence Collection Abilities
	[cutscene_wait_time, 1],
	[cutscene_event_change_variable, Player.id, "allowEssenceCollection", true],
	[cutscene_event_change_variable, Player.id, "allowHealing", true],
	[cutscene_event_save_game, true],
	
	[cutscene_event_change_variable, id, "glow", false],
	[cutscene_event_change_variable, id, "glowbyProx", true],
	[cutscene_event_change_variable, Player.id, "showHearts", true],
	
	[cutscene_wait_time, 3],
	[cutscene_event_create_instruction, "essence_gather"],
	[cutscene_event_set_persistence, persistenceId, true],
	
];

//Lights
activeCol = bgr($4af3eb);
lightminSize = 16;
lightmaxSize = 64;
stoneLight = light_source_create(x, y-65, true);
runeLight = light_source_create(x, y-5, true);

runeLight.str = 0.4;
stoneLight.str = 0.4;

function healStone_edit_light(newcol, sizee) {
	runeLight.colour = newcol;
	stoneLight.colour = newcol;
	
	runeLight.size = sizee;
	stoneLight.size = sizee;
}

healStone_edit_light(activeCol);
