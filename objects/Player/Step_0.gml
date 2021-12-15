/// @desc

//Decide Max HP based on Corruption Levels
var bhp = baseMaxHealth

var corruptionMaxReductionHP = (bhp - maxHpAtFullCorrupt);

//Loose at certian increments
//(if there is 2 hp to lose, then there is actually 3 stages of hp loss-- reduction by 0, 1 and 2.
//make it so stuff happens less than the increments of how much hp there is to lose;
//ie, i don't lose 2 hp when i'm at max corruption, but rather at 2/3 corruption.
var corruptionHpLossBase = floor(abs(corruptionPercent) * (corruptionMaxReductionHP+1))
var corruptionHpLoss = clamp(corruptionHpLossBase, 0, corruptionMaxReductionHP);

currentMaxHealth = baseMaxHealth - corruptionHpLoss;

//Weapon Wheel Select
player_weapon_wheel_step();