/// @desc
randomize();

//Save File info
saveSlotName = "keira";
gameVersion = 1;
gameSeed = irandom(100);

//Save Tracking
persistence = ds_map_create();
timeInGame = 0;

//Debug Settings
showCreationErrors = true;
viewHitboxes = false;
viewDamageBoxes = true;

//Game Keep Track Of
delta = -1; //For InGame
indepedantDelta = -1; //Global, Always Set
delta_scale = 60;

//UI
someUIopen = false;
uiScale = 1;
paused = false;
pauseMenuObj = noone;

//Corruption
corruption_CollectEssenceIncrease		= 1/200;
corruption_ImbuedWeaponSwingIncrease	= 1/100;
corruption_WeaponCreationIncrase		= 1/10;
corruption_HealingIncrease				= 1/5;

//Particle Viewer
particleViewer = noone;

//Colours
platinumCol = bgr($a0ceea);
textOrderCol = bgr($d7b851);
textBalancedCol = bgr($c1d8da);
textChaosCol = bgr($8a2db9);
textDefCol = $6b6b6b;