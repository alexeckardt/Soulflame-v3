//
//DESC:
//
//
//
function player_weapon_wheel_step(){

	//Decide Wheel "STATS"
	var cutsceneExists = instance_exists(Cutscene);

	//Open The Wheel
	weaponWheelJustClosed = false;
	weaponWheelJustOpened = false;
	player_weapon_wheel_open();
	

	
	//Weapon UI Pages
	if (weaponUiOpen) {

		//Controller Angle
		var actualDir = Controller.rightStickDirection;
		weaponWheelLerpDisplayingDir -= angle_difference(weaponWheelLerpDisplayingDir, actualDir) / 3;
		
		//
		//Selecting & Events
		switch (weaponUipage) {
			
			//
			
			default:
			case 0: // Combat Wheel Step Event

				//Select Slot on the Wheel
				displayAllWeapons = false;
				player_weapon_wheel_select_slot_wheel(actualDir, maxWeaponsCanHold);
				
				//Switch To Said Weapon
				if (!Controller.rightStickHolding) {
					
					//Transition Animation
					if (weaponSlotHighlighted != weaponSlotUsing) {	
					}
					
					//Set Weapon
					weaponUsing = weapon_slot_get_id(weaponSlotHighlighted);
					weaponAlignment = weapon_slot_get_alignment(weaponSlotHighlighted);
					weaponSlotUsing = weaponSlotHighlighted;
					
					//Close
					weaponUiOpen = false;
					
					//Reset
					weaponSlotHighlighted = weapon.none;
					lastWeaponSlotHighlighted = weapon.none;
					sameweaponSlotHighlightedFor = 0;
					lastWeaponSlotHighlightedFor = 0;
					
				}
				
			break;
				
				//
				//
				//
				
			case 1: // Forging Selection Wheel Step Event
				
				//Select Slot on the Wheel
				displayAllWeapons = false;
				player_weapon_wheel_select_slot_wheel(actualDir, maxWeaponsCanHold);
			
				//Slot
				if (Controller.uiSelectPressed) {
				
					//Save
					forgingWeaponSlotReplacing = weaponSlotHighlighted;
					
					//Next Page
					weaponUipage = 2;
				
					//Reset
					weaponSlotHighlighted = weapon.none;
					lastWeaponSlotHighlighted = weapon.none;
					sameweaponSlotHighlightedFor = 0;
					lastWeaponSlotHighlightedFor = 0;
				}
				
				//Go Back
				if (Controller.uiBackPressed) {
					weaponUiOpen = false;}
			
			break;
			
				//
				//
				//
			
			case 2: // Selecting From All Available Weapons
				
				//Select Slot on the Wheel
				displayAllWeapons = true;
				player_weapon_wheel_select_slot_wheel(actualDir, ds_list_size(weaponsUnlocked));
			
				//Slot
				if (Controller.uiSelectPressed) {
				
					//Save
					forgingWeaponId = Player.weaponsUnlocked[| weaponSlotHighlighted];
					
					//Next Page
					weaponUipage = 3;
				
					//Reset
					weaponSlotHighlighted = weapon.none;
					lastWeaponSlotHighlighted = weapon.none;
					sameweaponSlotHighlightedFor = 0;
					lastWeaponSlotHighlightedFor = 0;
				}
				
				//Go Back
				if (Controller.uiBackPressed) {weaponUipage--;}
			
			break;
			
				//
				//
				//
			
			case 3: // Selecting from the Alignments
			
				//Select Imbuement From the Arc
				displayAllWeapons = false;
				player_weapon_wheel_select_slot_partial_wheel(actualDir, 3, 90, 45);
			
				//Slot
				if (Controller.uiSelectPressed) {
				
					//Save
					var forgingImbueingGoal = (weaponSlotHighlighted - 1) % 3;
					
					//Check if can Imbue
					if (essence_token_have(forgingImbueingGoal) || forgingImbueingGoal == 0) {
						
						forgingWeaponImbuedWith = forgingImbueingGoal;
						
						//Set
						weaponsEquipted[# forgingWeaponSlotReplacing, 0] = forgingWeaponId;
						weaponsEquipted[# forgingWeaponSlotReplacing, 1] = forgingWeaponImbuedWith;
							
						//Consume Token
						if (!forgingImbueingGoal != 0) {		
						}
							
						//Return to "Home" Page
						weaponUipage = 1;
						weaponSlotHighlighted = -1;
					
					}
					
					//Reset
					weaponSlotHighlighted = weapon.none;
					lastWeaponSlotHighlighted = weapon.none;
					sameweaponSlotHighlightedFor = 0;
					lastWeaponSlotHighlightedFor = 0;
					
				}
				
				//Go Back
				if (Controller.uiBackPressed) {weaponUipage--;}
			
			break;
			
				//
				//
				//
				
				
		}
	
		//Exit Quickly
		if (!weaponWheelJustOpened) {
			if (Controller.combatAttackPressed) {
				weaponUiOpen = false;}
		}
		
		
		//Close The UI
		if (!weaponUiOpen) {
			weaponWheelJustClosed = true;
			Game.someUIopen = false;
		}
	}
	
	
	
	//
	//Scale Up/Down
	var goalScale = (weaponUiOpen) && (displayingAllWeapons==displayAllWeapons);
	weaponWheelScale = lerp(weaponWheelScale, goalScale, 0.3*Game.delta);
	
	//Update
	if (weaponWheelScale < weaponWheelScaleDispalyThreshold) {
		displayingAllWeapons = displayAllWeapons;}
	
}