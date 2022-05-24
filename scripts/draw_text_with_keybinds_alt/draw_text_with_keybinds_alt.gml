// @desc
//
//
//
function draw_text_with_keybinds_alt(_x, _y, _str, _colour, _a){

	var prep = string_prep_string_for_keybinds_draw(_str);
	var emptStr = string_replace(prep.str, "&!", "  ");;
	
	//Draw
	draw_text_with_keybinds(_x, _y, emptStr, prep.list, _colour, _a);

	//Reset
	prep.list = cleanup_ds_list(prep.list);
	delete prep;

}