/// @desc
randomize();

//Save File info
saveSlotName = "keira";
gameVersion = 1;
gameSeed = irandom(100);

//Save Tracking
persistance = ds_map_create();
timeInGame = 0;

//Debug Settings
showCreationErrors = true;
viewHitboxes = true;
viewDamageBoxes = true;

//Game Keep Track Of
delta = -1;
delta_scale = 60;
