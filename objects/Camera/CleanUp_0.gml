/// @description 
cleanup_surface(bkgSurf);
cleanup_surface(frgSurf);
cleanup_surface(fireSurf);

cleanup_surface(view_surf);
cleanup_surface(effective_view_surf);
view_surf = -1;
effective_view_surf = -1;

cleanup_surface(lightLayerSurf);
cleanup_surface(waterDistortSurf);

cleanup_ds_list(agressedEnemies);

instance_destroy();
