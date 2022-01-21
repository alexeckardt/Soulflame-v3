//
//DESC:
//
//
//
function game_draw_debug_line(identifier, value, onLeftSide) {

	//Position + Alignment
	var xx;
	if (onLeftSide) {
		xx = debugDrawHOffset
		draw_set_halign(fa_left);
	} else {
		xx = display_get_gui_width() - debugDrawHOffset;
		draw_set_halign(fa_right);	
	}
	var yy = debugStartDrawFrom + debugVerticalIndex*debugVSpacing
	
	
	//Create Tuple
	if (is_array(value)) {
		
		//Create Array
		var valueStr = "(";
		var len = array_length(value);
		for (var i = 0; i < len; i++) {
			valueStr += string(value[i]) + ", "	
		}
		
		//Trim
		var cut = string_length(valueStr) - 2;
		valueStr = string_copy(valueStr, 1, cut) + ")";
		
		
	} else {
		valueStr = value;	
	}
	
	
	//Draw
	draw_text(xx, yy, string(identifier) + ": " + string(valueStr));

	//Increment
	debugVerticalIndex++;

}