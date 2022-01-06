//
//Simple To Save To or Load From Save File.
//Only need to update in one place.
//
function access_save_data(save_data, writing) {
	
	//Get Scripts To Run for different data structures
	var index, map, list, grid;
	if (writing) {
		index = save_index;
		map = save_index_map;
		//list = save_index;
		//grid = save_index;
	} else {
		index = load_index;
		map = load_index_map;
		//list = save_index;
		//list = save_index;
		//grid = save_index;
	}
	
	///
	///ACCESS THE DATA!!!
	///
	
	//If we are saving; then we write to the save_data map; which was empty upon calling this.
	//If we are loading; then we read from the filed in map and update the corresponding instance variable.
	
	///
	
	//Player	
	index("platinum",				Player, save_data);
	index("baseMaxHealth",			Player, save_data);
	index("corruptionPercent",		Player, save_data);
	
	//Game
	index("timeInGame",				Game, save_data);
	
}




//
//For Readability
//Save Variables To a Save File
//
function generate_save_data() {

	//Create Map
	var save_data = ds_map_create();
	
	//No Return Function Call
	access_save_data(save_data, true);
	
	//Return Map
	return save_data

}



