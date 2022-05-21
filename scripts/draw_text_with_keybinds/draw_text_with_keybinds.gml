// @desc
//
//
//
function draw_text_with_keybinds(_x, _y, _str, _infoList, _colour, _a) {

	//Draw String
	draw_text_colour(_x, _y, _str, _colour, _colour, _colour, _colour, _a);
	
	//Draw The Keybinds
	var c = ds_list_size(_infoList);
	for (var i = 0; i < c; i++) {
	
		var keybind_info = _infoList[| i];
		var keybind_id = keybind_info.keybind;
		var str_position = keybind_info.pos;
		
		var preStr = string_copy(_str, 1, str_position);
		
		var xx = string_width(preStr);
		var yy = string_height(preStr);
	
		draw_keybind_from_string_id(_x + xx, _y + yy, keybind_id);
	
	}

}
