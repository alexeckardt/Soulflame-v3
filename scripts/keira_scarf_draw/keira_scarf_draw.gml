// @desc
//
//DRAW THE SURFACE (This is in a seperate sprite so any shader effects can be applied here too).
//
function keira_scarf_draw(_surfBlend, _surfAlpha) {

	//Draw Surface
	if (surface_exists(scarfSurface)) {
		if (drawScarf) {
			
			var w = surface_get_width(scarfSurface) / 2;
			var h = surface_get_height(scarfSurface) / 2;

			var anchorX = x + scarfMainOffsetX;
			var anchorY = y + scarfMainOffsetY;
			
			draw_surface_ext(scarfSurface, anchorX-w, anchorY-h, 1, 1, 0, _surfBlend, _surfAlpha);
		}	
	}

}