//
//DESC:
//
//
//
function game_draw_debug_line_header(identifier, onLeftSide) {

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
	
	//Draw
	draw_text(xx, yy, string(identifier));

	//Increment
	debugVerticalIndex++;

}