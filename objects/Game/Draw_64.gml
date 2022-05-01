/// @desc

if (showDebugOverlay) {
	
	draw_set_colour(c_white);
	
	debugScale = Player.uiScale / 2
	
	var worldCamW = Camera.view_width;
	var worldCamH = Camera.view_height;
	
	var displayWidth =	worldCamW / debugScale;
	var displayHeight = worldCamH / debugScale;

	display_set_gui_size(displayWidth, displayHeight);
	
	draw_set_font(-1);
	
	debugVerticalIndex = 0;
	game_draw_debug_line_header("Preformance", true);
	game_draw_debug_line("DT", largestDelta, true);
	game_draw_debug_line("I", instance_count, true);
	game_draw_debug_line("L", Camera.renderedLights, true);
		debugVerticalIndex++;
	game_draw_debug_line_header("Positions", true);
	game_draw_debug_line("R", room_get_name(room), true);
	game_draw_debug_line("P", [oKeira.x, oKeira.y], true);
	game_draw_debug_line("C", [Camera.x, Camera.y], true);
	game_draw_debug_line("M", [mouse_x, mouse_y], true);
	game_draw_debug_line("Mr", [mouse_x-Camera.x, mouse_y-Camera.y], true);




	//
	//CAMERA
	//
	if ( viewCameraDebug ) {
		
		display_set_gui_size(worldCamW, worldCamH);
		
		//l
		var list = Camera.agressedEnemies;
		var s = ds_list_size(list);
		
		var camX = Camera.viewX;
		var camY = Camera.viewY;
		var cX = worldCamW / 2;
		var cY = worldCamH / 2;
		
		draw_circle(cX, cY, 5, true);
		
		//Draw Entities
		for (var i = 0; i < s; i++) {
		
			var ent = list[| i];
			if (instance_exists(ent)) {
				var entx = ent.x;
				var enty = ent.y;
			
				draw_line(entx-camX + cX, enty-camY + cY, cX, cY);
			}
		
		}
		
		//Draw Follow Goal
		var f = Camera.follow;
		if (instance_exists(f)) {
		
			draw_line(f.x-camX + cX, f.y-camY + cY, cX, cY);
		
		}
		
		
		
		
	}




}