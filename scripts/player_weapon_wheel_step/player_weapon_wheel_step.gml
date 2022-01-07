//
//DESC:
//
//
//
function player_weapon_wheel_step(){

	//Decide Wheel "STATS"
	var wheelSlots = (displayAllWeapons) ?  max(1, ds_list_size(Player.weaponsUnlocked)) : maxWeaponsCanHold;
	var cutsceneExists = instance_exists(Cutscene);

	//Open The Wheel
	player_weapon_wheel_open();
	

	//Select Weapon
	if (selectingWeapon) {
		
		//Create Surface for Use
		if (!surface_exists(weaponWheelSurf)) {
			var w = weaponWheelSurfaceWidth;
			weaponWheelSurf = surface_create(w, w);	
		}
		
		//Input Choice
		var stickIsActive = ((Controller.rightStickHolding || weaponWheelOpenedAsPermanant) && !resetingWeaponSelection) && !cutsceneExists;
		
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
			var weaponSlotSelecting = weaponSlotHighlighted;
			if (Controller.rightStickHolding) weaponSlotSelecting = cD div segSize;
			
			//Keep Track of Time Holding Weapon
			sameweaponSlotHighlightedFor += Game.delta;
			if (weaponSlotSelecting != weaponSlotHighlighted) {
				lastWeaponSlotHighlightedFor = sameweaponSlotHighlightedFor;
				sameweaponSlotHighlightedFor = 0;
			}
			
			//Reccognize Holding
			lastWeaponSlotHighlighted = weaponSlotHighlighted;
			weaponSlotHighlighted = weaponSlotSelecting;
		}
			
		if (!stickIsActive || Controller.uiSelectPressed) {
			
			//Combat Events for Selection
				
			if (!weaponForging) {
				//
				//Let go of stick, meaning weapon chosen
				//
			
				//If Resetting, No Need To Check, as none has been selected in that case
				var weaponHasBeenSelected = resetingWeaponSelection || cutsceneExists;
			
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
				//If actually selected
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
				
			//else
				
			//Weapon Selected To Forge
			if (weaponForging) {
					
				switch (weaponWheelPage) {
						
					case 0: //WAS ON COMBAT
					default:
						
						//Selected the slot I want to update
						var weaponSlot = -1;
						if (sameweaponSlotHighlightedFor > 4) {
							weaponSlot = weaponSlotHighlighted;
						} else 
						if (lastWeaponSlotHighlightedFor > 4) {
							weaponSlot = lastWeaponSlotHighlighted;	
						}
						
						//Set Slot
						forgingWeaponSlotReplacing = weaponSlot
						
						//Next Page; iF not, Close.
						if (weaponSlot != -1) {
							weaponWheelPage = 1; //for next pass	
							displayAllWeapons = true;
							
						} else {
							selectingWeapon = false;
							weaponWheelJustClosed = true;
						}
						
					break;
					case 1: //WAS ON ALL UNLOCKED
						
						//Selected the slot I want to update
						var weaponSlot = -1;
						if (sameweaponSlotHighlightedFor > 4) {
							weaponSlot = weaponSlotHighlighted;
						} else 
						if (lastWeaponSlotHighlightedFor > 4) {
							weaponSlot = lastWeaponSlotHighlighted;	
						}
						
						//Get Weapon
						forgingWeaponId = weapon_get_wheel_slot_id(weaponSlot);
						
						//Next Page; iF not, Close.
						if (weaponSlot != -1) {
							weaponWheelPage = 2; //for next pass	
							displayAllWeapons = false;
							
						} else {
							weaponWheelPage = 0;
							displayAllWeapons = false; 
						}
						
						
					break;
					case 2: //WAS ON COMBAT
						
						//Selected the imbue I wanted to do.
						var weaponSlot = -1;
						if (sameweaponSlotHighlightedFor > 4) {
							weaponSlot = weaponSlotHighlighted;
						} else 
						if (lastWeaponSlotHighlightedFor > 4) {
							weaponSlot = lastWeaponSlotHighlighted;	
						}
						
						
						if (weaponSlot != -1) {
							var forgingImbueingGoal = (weaponSlot + 1) % 3 - 1;
						
							if (essence_token_have(forgingImbueingGoal) || forgingImbueingGoal == 0) {
							
								forgingWeaponImbuedWith = forgingImbueingGoal;
							
								//Update Weapon List
								weaponsEquipted[# forgingWeaponSlotReplacing, 0] = forgingWeaponId;
								weaponsEquipted[# forgingWeaponSlotReplacing, 1] = forgingWeaponImbuedWith;
							
								//Consume Token
								if (!forgingImbueingGoal != 0) {
									
								}
							
								//Return to "Home" Page
								weaponWheelPage = 0;
								weaponSlotHighlighted = -1;
							}
							
						//Return To Weapon Selection
						} else {
							weaponWheelPage = 1;
							displayAllWeapons = true;
						}
						

					break;
				}
					
			}
				
		}
		
		//
		//Cancel Weapon Selection
		if (!weaponWheelJustOpened) {
			if (Controller.combatAttackPressed) {
				selectingWeapon = false;	
				weaponWheelJustClosed = true;
			}
		}
		
		
	//Close Weapon Wheel
	} else {
		
		//Lock In Weapon Selection
		
		//Clear Surface
		if (weaponWheelSurf != -1) {
			if (weaponWheelScale < weaponWheelScaleDispalyThreshold) {
				surface_free(weaponWheelSurf);
				weaponWheelSurf = -1;
			}
		}	
			
			
		//Just Closed Events
		if (weaponWheelJustClosed) {
				
			//Return Control
			Game.someUIopen = false;
			weaponWheelPage = 0;
			displayAllWeapons = false;
				
		}
			
			
	}
	
	//Show/Hide the Surface
	weaponWheelScale = lerp(weaponWheelScale, selectingWeapon && (displayingAllWeapons == displayAllWeapons), 0.3*Game.delta);
		
	//Switch On Off
	if (weaponWheelScale < weaponWheelScaleDispalyThreshold) {
		displayingAllWeapons = displayAllWeapons;
	}
}


/*
function player_weapon_wheel_step(){

	//Allow for Forging
	
		//Check If at Campfire
		var campfire = instance_nearest(oKeira.x, oKeira.y, oCampfire);
		var atCampfire = (instance_exists(campfire)) && (campfire.lit && oKeira.STATE = state.sit)

		allowForging = atCampfire; //|| atSomethingElse ...

		//Toggle Forging
		disableForgingSwitchFor -= Game.delta
		if (selectingWeapon) {
			if (allowForging && disableForgingSwitchFor < 0) {
				if (Controller.combatAttackPressed) {
					
						disableForgingSwitchFor = room_speed;
						weaponForging = !weaponForging;
					
						//Switch Offset (0 if not forging)
						weaponWheelAngleOffset = (weaponForging)*forgingWeaponWheelGoalAngleOffset;
					
				}
			}
		}
		



	//Decide Wheel "STATS" based on which wheel to display
	var wheelSlots = (displayAllWeapons) ?  ds_map_size(Player.weaponsUnlocked) : maxWeaponsCanHold;
	
	//Don't Do Anything if the Wheel is empty
	if (wheelSlots != 0) {
		
		
		player_weapon_wheel_input_interaction();
	
		//Select Weapon
		if (selectingWeapon) {
		
			//Create Surface for Use
			if (!surface_exists(weaponWheelSurf)) {
				var w = weaponWheelSurfaceWidth;
				weaponWheelSurf = surface_create(w, w);	
			}
		
			//Input Choice
			var stickIsActive = (Controller.rightStickHolding && !resetingWeaponSelection) || (allowForging && !resetingWeaponSelection);
		
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
				var cD = (actualDir + 360) - (90 - segSize/2) - weaponWheelAngleOffset;
				cD %= 360;
			
				//Get What Segment Stick is aiming IN
				var weaponSlotSelecting = cD div segSize;
				if (!Controller.rightStickHolding) {weaponSlotSelecting = -1;}
			
				//Keep Track of Time Holding Weapon
				sameweaponSlotHighlightedFor += Game.delta;
				if (weaponSlotSelecting != weaponSlotHighlighted) {
					lastWeaponSlotHighlightedFor = sameweaponSlotHighlightedFor;
					sameweaponSlotHighlightedFor = 0;
				}
			
				//Reccognize Holding
				lastWeaponSlotHighlighted = weaponSlotHighlighted;
				weaponSlotHighlighted = weaponSlotSelecting;
		
				
				//Select Which Weapon I want to use during forging
				if (weaponForging) {
					
					//If Holding On The weapon I want to choose
					if (weaponForgingHoveringOverSlot == weaponSlotSelecting) {
					
							//increase timer/animation radius
							weaponWheelSelectingRadiusMulti += 0.05*Game.delta;
							
							//Once Finished, select
							if (weaponWheelSelectingRadiusMulti > 1) {
								forgeSelectedWeaponSlot = weaponForgingHoveringOverSlot;
								
								
								
							}
					
					//Reset "Timer"
					} else {
						weaponWheelSelectingRadiusMulti = weaponWheelSelectingRadiusStartMulti;	
					}
					
					weaponForgingHoveringOverSlot = weaponSlotSelecting;
					
				}
		
		
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
					if (!weaponForging) {
						
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
					
					//Weapon Selected Weapon Forging
					} else {
						
						
						
					}
					
				}
			
				//Reset
				weaponWheelJustClosed = true;
				weaponSlotHighlighted = weapon.none;	
			}
		
			//
			//Cancel Weapon Selection If No Forging Allowed
			//Don't Close Weapon Wheel IF Allow Forging
			if (!allowForging) {
				if (Controller.combatAttack) {
					selectingWeapon = false;	
				}
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
		weaponWheelScale = lerp(weaponWheelScale, selectingWeapon && (displayingAllWeapons == displayAllWeapons), 0.3*Game.delta);
		
		//Forging Switch On Off
		if (weaponWheelScale < weaponWheelScaleDispalyThreshold) {
			displayingAllWeapons = displayAllWeapons;
		}
		
		
		
	} else {
		//Don't Show Weapons If Empty Wheel
		selectingWeapon = false;
	}
}