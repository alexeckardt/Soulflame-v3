/// @description Reset Background Surf

if (!surface_exists(bkgSurf)) {
	bkgSurf = surface_create(view_width*zoom, view_height*zoom);
	createdBkgSurface = true;
}