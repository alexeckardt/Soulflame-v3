/// @description 
if (path_exists(myPath)) {
	draw_path(myPath, x, y, true);
}

draw_set_font(fontKeira);
if (active) {
	var str = (goingToPosition) ? "(" + string(goToX) + ", " +  string(goToY)+ ")" : object_get_name(objectFollowing);
	draw_text(x, y, "Going To: " + str);
	
} else {
	draw_text(x, y, "Not Active");
	
}

//draw_sprite(sWhite, 0, x, y);