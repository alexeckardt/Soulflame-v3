/// @description

if (!createdInstructionText) {
	
	var text = lang_get_text(instructionTextKey);
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
