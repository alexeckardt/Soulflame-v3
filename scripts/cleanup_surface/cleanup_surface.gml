//
//DESC:
//
//
//
function cleanup_surface(surface_id) {
	if (surface_exists(surface_id)) {
		surface_free(surface_id);	
	}
}