/// @desc
cleanup_surface(featherSurf);
cleanup_surface(weaponWheelSurf);
cleanup_surface(interactSurface);

cleanup_ds_list(flowersHave);
cleanup_ds_list(weaponsEquipted);
cleanup_ds_map(weaponsUnlocked);


//Complex Cleanups
essenceTokens = cleanup_ds_list_for_structs(essenceTokens);
heartList = cleanup_ds_list_for_structs(heartList);
effectList = cleanup_ds_list_for_structs(effectList);
