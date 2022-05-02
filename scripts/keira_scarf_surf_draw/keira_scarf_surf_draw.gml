// @desc
//
//
//
function keira_scarf_surf_draw() {

	//Setup Scarf Surface
	var surfW = scarfSurfW;
	if (!surface_exists(scarfSurface)) {
		scarfSurface = surface_create(surfW*2, surfW*2);}

	//Anchor position
	var anchorX = x + scarfMainOffsetX;
	var anchorY = y + scarfMainOffsetY;
	
	//Const to position all nodes correctly onto the surface
	var surfOffsetX = anchorX - surfW;
	var surfOffsetY = anchorY - surfW;

	//-----------------------
	surface_set_target(scarfSurface);
	//-----------------------

	//Clear Surface
	draw_clear_alpha(0, 0);
	//draw_clear_alpha(c_red, 1);

	//Get Position
	var lastX = anchorX;
	var lastY = anchorY;

	//Draw Scarf Nodes
	for (var i = 1; i < ds_list_size(scarfNodes); i++) {
		
		var node = scarfNodes[| i];
		
		//Positions to draw
		var pos1X = node.xx-surfOffsetX;
		var pos1Y = node.yy-surfOffsetY;
		var pos2X = lastX-surfOffsetX;
		var pos2Y = lastY-surfOffsetY;

		//Draw Segment
		draw_sprite_ext(sPixel, 0, pos1X, pos1Y, 2, 2, 0, scarfCol, 1);
		draw_line_width_color(pos1X, pos1Y, pos2X, pos2Y, 3, scarfCol, scarfCol);
		
		//Pass Back
		lastX = node.xx;
		lastY = node.yy;
	}

	//-----------------------
	surface_reset_target();
	//-----------------------

}