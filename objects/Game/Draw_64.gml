/// @desc

if (showDebugOverlay) {
	
	debugScale = Player.uiScale / 2
	
	var displayWidth =	Camera.view_width / debugScale;
	var displayHeight = Camera.view_height / debugScale;
	display_set_gui_size(displayWidth, displayHeight);
	
	draw_set_font(-1);
	
	debugVerticalIndex = 0;
	game_draw_debug_line("DT", largestDelta, true);
	game_draw_debug_line("I", instance_count, true);
		debugVerticalIndex++;
	game_draw_debug_line("R", room_get_name(room), true);
	game_draw_debug_line("P", [oKeira.x, oKeira.y], true);

}