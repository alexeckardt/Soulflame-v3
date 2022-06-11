// @desc
//
//
//
function draw_text_with_keybinds(_x, _y, _str, _infoList, _colour, _a) {

	//Draw String
	draw_text_colour(_x, _y, _str, _colour, _colour, _colour, _colour, _a);
	
	var strw = string_width(_str);
	var strh = string_height(_str);
	
	//
	var orghalign = draw_get_halign();
	var orgvalign = draw_get_valign();
	
	//Get the position
	var topLeftX, topLeftY;
	switch orghalign {
		case fa_left:	topLeftX = _x				;break;
		case fa_center: topLeftX = _x - strw div 2	;break;
		case fa_right:	topLeftX = _x - strw		;break;
	}
	switch orgvalign {
		case fa_top:	topLeftY = _y				;break;
		case fa_middle: topLeftY = _y - strh div 2	;break;
		case fa_bottom: topLeftY = _y - strh		;break;
	}
	
	//
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	//Draw The Controller
	var c = ds_list_size(_infoList);
	for (var i = 0; i < c; i++) {
	
		var keybind_info = _infoList[| i];
		var keybind_id = keybind_info.keybind;
		var str_position = keybind_info.pos;
		
		var preStr = string_copy(_str, 1, str_position);
		
		var xx = string_width(preStr) - string_width("X") div 2;
		var yy = string_height(preStr) - string_height("X");
	
		draw_keybind_from_string_id(topLeftX + xx, topLeftY + yy, keybind_id, false);
	
	}
	
	//
	draw_set_halign(orghalign);
	draw_set_valign(orgvalign);
	
}
