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

//Display Platinum
	//Reset Counters
	if (platinum != platinumDisplaying + platinumToAdd) {
		platinumToAdd = platinum - platinumDisplaying;
		platinumCatchUpConstant = max(1, abs(platinumToAdd) div room_speed)*sign(platinumToAdd); //Take Max 1 second
		
		platinumAdditionDisplayForLeft = platinumAdditionDisplayTime;
		platinumCountStaticShowForLeft = platinumCountStaticShowFor;
	}

	//
	platinumDisplayPercent = lerp(platinumDisplayPercent, (platinumCountStaticShowForLeft > 0), 0.2*Game.delta);
	if (platinumDisplayPercent > 0.01) {
		
		//Timer Until the Addition Timer Goes Away
		platinumAdditionDisplayForLeft -= Game.delta;
		if (platinumAdditionDisplayForLeft < 0) {
			
			//Slowly Catch Up To Real Count
			var add = min(abs(platinumToAdd), abs(platinumCatchUpConstant)) * sign(platinumCatchUpConstant);
			platinumDisplaying += add;
			platinumToAdd = floor(platinumToAdd-add);
			
			//Stop
			if (platinumToAdd == 0) {

				//Once this is under zero, counter will "close".
				//This will not reopen until the platinum count is changed again.
				platinumCountStaticShowForLeft -= Game.delta
				
			}
			
		} 
	
	}
	
//
//
//Interact Alpha

	//Check
	var sameString	= interactString == drawingInteractString;

	//Alpha (Fade out if Not same or not touching)
	interactAlpha	= lerp(interactAlpha, showInteractString*sameString, (0.18 + (0.2*(!sameString)))*Game.deltaRatio);
	