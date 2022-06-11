/// @description 
if (surface_exists(backgroundSurf)) surface_free(backgroundSurf);
if (surface_exists(blurredSurf)) surface_free(blurredSurf);
if (surface_exists(transitionSurface)) surface_free(transitionSurface);

ds_list_destroy(visiblePages);
ds_list_destroy(saveFileInfo);
ds_list_destroy(saveFilePaths);

//Destroy Grids 
for (var i = 0; i < ds_list_size(saveFileWeaponGrids); i++) {
	
	var gg = saveFileWeaponGrids[| i];
	if (ds_exists(gg, ds_type_grid)) {
		ds_grid_destroy(gg);
	}
}
ds_list_destroy(saveFileWeaponGrids);