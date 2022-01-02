/// @description Reset Background Surf

if (!surface_exists(bkgSurf)) {
	bkgSurf = surface_create(view_width*zoom, view_height*zoom);
}

surface_set_target(bkgSurf);
	draw_clear_alpha(0,0);
surface_reset_target();

createdBkgSurface = true;