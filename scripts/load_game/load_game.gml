// @desc
//
//
//
function load_game(saveFileName = undefined, startTransition = true) {

	//Get Name (If Imported)
	var save_file_name = (saveFileName == undefined) ? (Game.saveSlotName + ".sav") : saveFileName
	Game.saveSlotName = string_replace(save_file_name, ".sav", "");
	
	//Read File
	var file = file_text_open_read(working_directory + save_file_name);
	var save_string = file_text_read_string(file);
		file_text_close(file);	

	//Read Data To Map
	var global_save_data = json_decode(save_string);
		//Exit If Faulty
		if (global_save_data == -1) {
			return 0;}
	
	//Unpack Data From Global Map
	var game_version	= global_save_data[? "game_version"];
	var date_saved		= global_save_data[? "date_saved"];
	var save_data		= json_decode(global_save_data[? "save_data"]);
	var save_position	= json_decode(global_save_data[? "save_position"]);
	
	//var settings_data	= json_decode(global_save_data[? "settings_data"]);
	
	//Load Data
	access_save_data(save_data, false);
	
	Player.hp = Player.baseMaxHealth;
	
	
	//Room Switch
	Player.savePointRoom	= save_position[? "room_name"];
	Player.savePointX		= save_position[? "player_x"];
	Player.savePointY		= save_position[? "player_y"];
	Player.savePointD		= save_position[? "player_d"];
	
	//Destroy Maps
	ds_map_destroy(save_data);
	ds_map_destroy(save_position);
	ds_map_destroy(global_save_data);
	
	//Transition To Room
	if (startTransition) { 
		transition_create(
			oTransitionFade, 
			asset_get_index(Player.savePointRoom), Player.savePointX, Player.savePointY, Player.savePointD, 
			1, c_black, undefined, undefined);
	}

	show_debug_message("Load");
		
	return undefined
}