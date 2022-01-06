// @desc
//
//
//
function save_game(silent, new_save_file) {

	if (!instance_exists(Player)) {show_debug_message("No Player Obj");exit;}
	if (!instance_exists(Game)) {show_debug_message("No Game Obj");exit;}
	
	//Create File Name
	var fileName = Game.saveSlotName + ".sav";

	var file_contents = ds_map_create();

	//Create The Save DS (For Persistance)
	var save_data = generate_save_data();

	//Save Position
	var savePoint = save_get_player_position();
	
	//Save File Access Information
	file_contents[? "date_saved"]			= date_current_datetime();
	file_contents[? "game_version"]	= Game.gameVersion;
	
	file_contents[? "save_data"]			= json_encode(save_data);
	file_contents[? "settings_data"]		= 0;//ds_map_write(map);
	file_contents[? "save_position"]		= json_encode(savePoint);

	//Save As String
	var save_string = json_encode(file_contents);
	
	//Destroy Maps
	ds_map_destroy(file_contents);
	ds_map_destroy(save_data);
	ds_map_destroy(savePoint);
	
	//Open & Write To File
	var file = file_text_open_write(working_directory + fileName);
	file_text_write_string(file, save_string);
	
	//Close File
	file_text_close(file);
	
	//All Good
	return -1;
	
}