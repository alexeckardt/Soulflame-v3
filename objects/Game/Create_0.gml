/// @desc
randomize();

//Save File info
saveFileName = "keira_0.sav";
gameVersion = 1
gameSeed = irandom(100);

//Save File
persistance = ds_map_create();

//Game Settings


//Debug Settings
viewHitboxes = true;
viewDamageBoxes = true;


//Game Keep Track Of
delta = -1;
delta_scale = 60;

//View
ideal_camera_width = 320;
ideal_camera_height = 180;
ideal_aspect_ratio = 16/9;