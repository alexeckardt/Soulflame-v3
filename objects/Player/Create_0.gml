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
baseCorruptionIncrease = 1/100;
corruptionResistance = 1; //divisor of how much essence is added to corruptionMeter on hit

//Feather
featherSurf = -1;
featherSurfDim = 64;
featherSpr = sCorruptionFeather;
featherYoffset = 0;

featherSurfXFromBase = 10;
featherSurfYFromBase = -5;


//Attacks
weaponUsing = weapon.none;
basePunchDamage = 1;


//Weapon Wheel
selectingWeapon = false;
weaponWheelJustClosed = false;
weaponWheelSurf = -1;
weaponWheelScale = 0;
weaponHighlighted = weapon.none;
sameWeaponHighlightedFor = 0;
lastWeaponHighlighted = weapon.none;
lastWeaponHighlightedFor = 0;

weaponWheelSpr = sWeaponWheelBackground;
weaponWheelSize = sprite_get_width(weaponWheelSpr);
weaponSelectionBubbleSize = 32;
weaponWheelSurfaceWidth = weaponWheelSize + weaponSelectionBubbleSize*2;
weaponWheelScaleDispalyThreshold = 0.05;

weaponWheelLerpDisplayingDir = 0;
weaponWheelLerpDisplayingLen = 0;