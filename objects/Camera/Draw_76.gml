/// @description Reset Background Surf

if (!surface_exists(bkgSurf)) {
	bkgSurf = surface_create(view_width*zoom, view_height*zoom);
	createdBkgSurface = true;
}

if (!surface_exists(frgSurf)) {
	frgSurf = surface_create(view_width*zoom, view_height*zoom);
	createdBkgSurface = true;
}