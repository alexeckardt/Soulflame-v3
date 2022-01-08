/// @desc


//Health
baseMaxHealth = 5;
currentMaxHealth = 5;
hp = 5;
maxHpAtFullCorrupt = 3;
dead = false;

//Health Display
healthDisplayY = 8;
heartWidthOffset = 20;
heartBoxCol = c_black;
heartBoxAlpha = 0.5;

//Essence
essenceTokensCanHold = 3;
essenceTokens = ds_list_create();
essenceTokensHolding = 0; //Count of Above
essenceForToken = 25;
tokenEdgeBuffer = 18;
tokenColumnSep = 11;
tokenRowHeight = 15;
tokenListBufferY = tokenRowHeight div 2;
heartBorderBuffer = 12;

//Corruption
corruptionPercent = 0;
corruptionResistance = 1; //divisor of how much essence is added to corruptionMeter. Changed with talismans.

//Feather
featherSurf = -1;
featherSurfDim = 64;
featherSpr = sCorruptionFeather;
featherYoffset = 0;

featherSurfXFromBase = 10;
featherSurfYFromBase = -5;

//Attacks
weaponUsing = weapon.none;
weaponAlignment = 0;
weaponSlotUsing = -1;
basePunchDamage = 1;

//Weapon Wheel
weaponUiOpen = false;
weaponUipage = 0;	//0-combat wheel,	1=forge slot select wheel	2-all unlockable weapons,	3-to imbue with		4-all weapons?
weaponWheelJustClosed = false;
weaponWheelSurf = -1;
weaponWheelScale = 0;

weaponWheelInteriorDiameter		= 107;
weaponWheelSlots				= 0;
weaponWheelArcLength			= 0;
weaponWheelArcStartAngleOffset	= 0;
wheelSelectionArcIncrease = 5;


weaponSlotHighlighted = weapon.none;
sameweaponSlotHighlightedFor = 0;
lastWeaponSlotHighlighted = weapon.none;
lastWeaponSlotHighlightedFor = 0;

weaponWheelSpr = sWeaponWheelBackground;
weaponWheelSize = sprite_get_width(weaponWheelSpr);
weaponSelectionBubbleSize = 32;
weaponWheelSurfaceWidth = weaponWheelSize + weaponSelectionBubbleSize*2;
weaponWheelScaleDispalyThreshold = 0.05;

weaponWheelLerpDisplayingDir = 0;
weaponWheelLerpDisplayingLen = 0;

//Weapon Forging or Wheel Display
displayAllWeapons	= false;
displayingAllWeapons = false;
maxWeaponsCanHold	= 3;
weaponsEquipted		= ds_grid_create(maxWeaponsCanHold, 2);
					ds_grid_clear(weaponsEquipted, -1);
					ds_grid_set_region(weaponsEquipted, 0, 1, maxWeaponsCanHold-1, 1, 0);
					
weaponsUnlocked		= ds_list_create();
ds_list_add(weaponsUnlocked, 0, 5, 8);

allowForging		= false;
weaponForging		= false;

forgingWeaponSlotReplacing = -1;
forgingWeaponId				= 0;
forgingWeaponImbuedWith		= 0;

weaponWheelAngleOffset = 0;
weaponWheelOpenedAsPermanant = false; //if true, the wheel will not close by itself



//Interacting Display
interactSurface = -1;
interactAlpha = 0;

drawingInteractString = "";
interactString = "";
showInteractString = false;

//Room Transition
roomStartPlayerX = 0;
roomStartPlayerY = 0;
roomStartPlayerD = 1;
firstRoom = true;
fadeInTransitionInfo = [0,0,0,0,0,0]
 
//Collection
platinum = 0;

//Respawning
savePointRoom = "";
savePointX = 0;
savePointY = 0;
savePointD = 0;