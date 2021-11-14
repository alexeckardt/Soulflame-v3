/// @desc


//Health
baseMaxHealth = 5;
currentMaxHealth = 5;
hp = 5;
maxHpAtCorrupt = 3;
dead = false;

//Health Display
healthDisplayY = 8;
heartWidthOffset = 20;
heartBoxCol = c_black;
heartBoxAlpha = 0.5;


//Corruption & Essence
corruptionPercent = 0
essenceTokensCanHold = 3;
essenceTokens = ds_list_create();
essenceTokensHolding = 0; //Count of Above
essenceForToken = 25;
tokenEdgeBuffer = 18;
tokenColumnSep = 11;
tokenRowHeight = 13;
tokenListBufferY = tokenRowHeight;
heartBorderBuffer = 12;