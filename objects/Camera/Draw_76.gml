/// @description Reset Background Surf

if (!surface_exists(bkgSurf)) {
	bkgSurf = surface_create(view_width*zoom, view_height*zoom);
	createdBkgSurface = true;
	
	surface_set_target(bkgSurf);
			draw_clear_alpha(0, 0);
		surface_reset_target();
}

if (!surface_exists(frgSurf)) {
	frgSurf = surface_create(view_width*zoom, view_height*zoom);
	createdBkgSurface = true;
	
	surface_set_target(frgSurf);
			draw_clear_alpha(0, 0);
		surface_reset_target();
}

if (!surface_exists(fireSurf)) {
	fireSurf = surface_create(view_width*zoom, view_height*zoom);
	createdBkgSurface = true;
	
	surface_set_target(fireSurf);
			draw_clear_alpha(0, 0);
		surface_reset_target();
}

if (!surface_exists(gameLayerSurf)) {
	gameLayerSurf = surface_create(view_width, view_height);
	
	surface_set_target(gameLayerSurf);
			draw_clear_alpha(0, 0);
		surface_reset_target();
}

