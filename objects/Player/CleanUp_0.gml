/// @desc
cleanup_surface(featherSurf);
cleanup_surface(weaponWheelSurf);
cleanup_ds_list(interactSurface);
cleanup_ds_list(weaponsEquipted);
cleanup_ds_map(weaponsUnlocked);


//Complex Cleanups
essenceTokens = cleanup_ds_list_for_structs(essenceTokens);
heartList = cleanup_ds_list_for_structs(heartList);