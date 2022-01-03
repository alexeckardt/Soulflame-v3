/// @desc
randomize();

//Save File info
saveFileName = "keira.sav";
gameVersion = 1
gameSeed = irandom(100);

//Save Tracking
persistance = ds_map_create();
date = -1;

//Debug Settings
showCreationErrors = true;
viewHitboxes = false;
viewDamageBoxes = true;

//Game Keep Track Of
delta = -1;
delta_scale = 60;
