//
//DESC:
//
//
//
function player_weapon_wheel_step(){

	//Decide Wheel "STATS"
	var wheelSlots = (displayAllWeapons) ?  ds_map_size(Player.weaponsUnlocked) : maxWeaponsCanHold;
	
	if (wheelSlots != 0) {
		
		//Selecting Weapon
		if (Controller.rightStickHolding) {
			if (!weaponWheelJustClosed) {
				if (!selectingWeapon) {
					selectingWeapon = true;
					weaponSlotHighlighted = weapon.none;
					resetingWeaponSelection = false;
				}
			}
		} else {
			weaponWheelJustClosed = false;
		}
	
		//Reset Weapon Selection
		if (Controller.rightStickPressed) {
			resetingWeaponSelection = true;
			selectingWeapon = true;
		}
	
		//Select Weapon
		if (selectingWeapon) {
		
			//Create Surface for Use
			if (!surface_exists(weaponWheelSurf)) {
				var w = weaponWheelSurfaceWidth;
				weaponWheelSurf = surface_create(w, w);	
			}
		
			//Input Choice
			var stickIsActive = Controller.rightStickHolding && !resetingWeaponSelection;
		
			//If Wanting To Set Weapon
			weaponWheelLerpDisplayingLen = lerp(weaponWheelLerpDisplayingLen, 
										point_distance(0, 0, Controller.rightStickHolding, Controller.rightStickVertical)*0.5,
										0.4);
		
			//Change Direction
			if (stickIsActive) {
			
				//Smooth Display
				var actualDir = Controller.rightStickDirection;
				weaponWheelLerpDisplayingDir -= angle_difference(weaponWheelLerpDisplayingDir, actualDir) / 3;
			
				//Find Segment Size
				var segSize = 360 / wheelSlots;
			
				//Based around the CENTER of a segment, not from an edge
				var cD = (actualDir + 360) - (90 - segSize/2);
				cD %= 360;
			
				//Get What Segment Stick is aiming IN
				var weaponSlotSelecting = cD div segSize
			
				//Keep Track of Time Holding Weapon
				sameweaponSlotHighlightedFor += Game.delta;
				if (weaponSlotSelecting != weaponSlotHighlighted) {
					lastWeaponSlotHighlightedFor = sameweaponSlotHighlightedFor;
					sameweaponSlotHighlightedFor = 0;
				}
			
				//Reccognize Holding
				lastWeaponSlotHighlighted = weaponSlotHighlighted;
				weaponSlotHighlighted = weaponSlotSelecting;
		
			} else {
			
				//
				//Let go of stick, meaning weapon chosen
				//
			
				//If Resetting, No Need To Check, as none has been selected in that case
				var weaponHasBeenSelected = resetingWeaponSelection;
			
				//Weapon To Switch To
				var weaponToSwitchTo = weapon.none;
			
				//Only Select
				if (!weaponHasBeenSelected) {
					if (sameweaponSlotHighlightedFor > 4) {
				
						//Choose this as the weapon
						weaponToSwitchTo = weapon_get_wheel_slot_id(weaponSlotHighlighted);
						weaponHasBeenSelected = true;
				
					//Check the Last Weapon (Incase weapon switched when releasing the stick)
					} else {
			
						if (lastWeaponSlotHighlightedFor > 4) {
							weaponToSwitchTo = weapon_get_wheel_slot_id(lastWeaponSlotHighlighted);
							weaponHasBeenSelected = true;
						}
					}
				}
			
				//
				//
				//Selection Events
				if (weaponHasBeenSelected) {
			
					//Close UI
					selectingWeapon = false;
			
					//Check If Different Weapon than Player Was Using
					if (weaponToSwitchTo != weaponUsing) {
				
						//Set As New Weapon
						weaponUsing = weaponToSwitchTo;
				
						//Transition Animation
					
						//Reset
						weaponSlotHighlighted = weapon.none;
						lastWeaponSlotHighlighted = weapon.none;
						sameweaponSlotHighlightedFor = 0;
						lastWeaponSlotHighlightedFor = 0;				
					}
				}
			
				//Reset
				weaponWheelJustClosed = true;
				weaponSlotHighlighted = weapon.none;	
			}
		
			//
			//Cancel Weapon Selection
			if (Controller.combatAttack) {
				selectingWeapon = false;	
			}
		
		} else {
		
			//Lock In Weapon Selection
		
			//Clear Surface
			if (weaponWheelSurf != -1) {
				if (weaponWheelScale < weaponWheelScaleDispalyThreshold) {
					surface_free(weaponWheelSurf);
					weaponWheelSurf = -1;
				}
			}	
		}
	
		//Show/Hide the Surface
		weaponWheelScale = lerp(weaponWheelScale, selectingWeapon, 0.3);
		
	} else {
		//Don't Show Weapons
		selectingWeapon = false;
	}
}