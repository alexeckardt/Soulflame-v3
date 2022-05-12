/// @description

if (!createdInstructionText) {
	
	//Create Key
	persistenceKey = "instruction." + instructionKey;
	
	var text = lang_get_text(persistenceKey);	
	var struct = string_prep_string_for_keybinds_draw(text);
	
	//Save
	stringToDraw = struct.str;
	keybind_info_list = struct.list;
	
	//Clear Data;
	delete struct
	
	//Setup Format
	draw_set_font(font);
	viewW = Camera.view_width;
	
	//Format Properlly
	stringToDraw = string_wrap(stringToDraw, viewW/2);
	stringToDraw = string_replace(stringToDraw, "&!", "  ");
	
	//Don't Repeat
	createdInstructionText = true;

}


///
//Animate
timeLeftbeforeshow -= Game.delta;
obstructionAlpha = lerp(obstructionAlpha, !completed && timeLeftbeforeshow < 0, 0.1*Game.delta);

//Dead after Animation Finished
if (completed && obstructionAlpha < 0.01) {
	
	//Complete the Task
	game_persistence_set(persistenceKey, true);
	
	//Finish
	instance_destroy();
	
}
