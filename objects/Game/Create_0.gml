/// @desc
randomize();

//Save File info
saveSlotName = "keira";
gameVersion = 1;
gameSeed = irandom(100);

//Save Tracking
persistence = ds_map_create();
timeInGame = 0;

//Game Keep Track Of
delta = -1; //For InGame
indepedentDelta = -1; //Global, Always Set
delta_scale = 60;
deltaRatio = 0;
idealDelta = 1/delta_scale * 1000000;

deltatracking = 0;
largestDelta = 0

minDelta = 1; //0.001
maxDelta = 1; //10

//UI
someUIopen = false;
paused = false;
pauseMenuObj = noone;
showCreationErrors = true;

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

//Some Settings
paralaxScale = 1;
fullscreen = true;
frameSkips = 0;
	frameSkipCounter = 0;
	
//Debug Overlay
debugDrawHOffset = 10;
debugStartDrawFrom = 40;
debugVerticalIndex = 0;
debugVSpacing = 14;

//Debug Settings
showDebugOverlay = false;

viewHitboxes = false;
viewDamageBoxes = false;
viewAudioEmitters = false;
viewCameraDebug = true;