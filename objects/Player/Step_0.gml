/// @desc

player_heal();

player_modify_hearts();

//Death
player_do_death();

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
//Essence

var baseEssence = essenceTokensCanHoldBase;
essenceTokensCanHold = baseEssence + effect_get_multiplier(flower.rose_sunflower);

player_update_essence_tokens();

//
//
//Interact Alpha

	//Check
	var sameString	= interactString == drawingInteractString;

	//Alpha (Fade out if Not same or not touching)
	interactAlpha	= lerp(interactAlpha, showInteractString*sameString, (0.18 + (0.2*(!sameString)))*Game.deltaRatio);
	
//
//
//Show and Hide UI parts
featherHideOffsetPercent = lerp(featherHideOffsetPercent, allowEssenceCollection, 0.1*Game.delta);
tokenHideOffsetPercent = lerp(tokenHideOffsetPercent, allowEssenceCollection, 0.1*Game.delta);
heartsShowOffsetPercent = lerp(heartsShowOffsetPercent, !showHearts, 0.1*Game.delta);
