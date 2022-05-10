/// @description 

if (Game.showDebugOverlay && Game.devMode) {

	if (path_exists(myPath)) {
	
		draw_path(myPath, x, y, true);
	
		//Points
		var points = path_get_number(myPath);;
		for (var i = 0; i < points; i++) {
	
			var xx = path_get_point_x(myPath, i);
			var yy = path_get_point_y(myPath, i);
		
			draw_circle_colour(xx, yy, 2, c_red, c_red, false);
		}
	
		draw_circle_colour(x, y, 2, c_green, c_green, false);
	}

	draw_set_font(fontKeira);
	if (active) {
		var str = (goingToPosition) ? "(" + string(goToX) + ", " +  string(goToY)+ ")" : object_get_name(objectFollowing);
		draw_text(x, y, "Going To: " + str);
	
	} else {
		draw_text(x, y, "Not Active");
	
	}
}

//draw_sprite(sWhite, 0, x, y);

