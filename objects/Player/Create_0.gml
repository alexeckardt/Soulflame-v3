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
