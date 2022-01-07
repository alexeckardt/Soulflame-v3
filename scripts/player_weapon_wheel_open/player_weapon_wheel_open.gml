// @desc
//
//
//
function player_weapon_wheel_open(){

	//Allow for Forging
	
	//Check If at Campfire
	var campfire = instance_nearest(oKeira.x, oKeira.y, oCampfire);
	var atCampfire = (instance_exists(campfire)) && (campfire.lit && oKeira.STATE = state.sit)
	var CutsceneExists = instance_exists(Cutscene);
	var hasAWeapon = ds_list_size(Player.weaponsUnlocked);

	allowForging = hasAWeapon && (atCampfire); //|| atSomethingElse ...);
	
	//Opened Check
	weaponWheelJustOpened = false;
	
	//Only Open If Something Else is Not Opened
	if (!Game.someUIopen || selectingWeapon) {
		
		//COMBAT!
		if (!atCampfire) {
			if (Controller.rightStickHolding) {
				if (!weaponWheelJustClosed) {
					if (!selectingWeapon) {
						selectingWeapon = true;
						weaponWheelOpenedAsPermanant = false;
						weaponSlotHighlighted = weapon.none;
						resetingWeaponSelection = false;
						weaponWheelJustOpened = true;
						Game.someUIopen = true;
						weaponWheelPage = 0;
						weaponForging = false;
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
		}
	
		//ALLOW FORGE
		if (allowForging) {
		
			//Open/Close
			if (Controller.combatAttackPressed) {
			
				selectingWeapon = !selectingWeapon;
				weaponWheelJustOpened = true;
				weaponWheelOpenedAsPermanant = true;
				weaponForging = true;
				oKeira.inControl = false;	
			
				//Open Events
				if (selectingWeapon) {
					weaponSlotHighlighted = weapon.none;
					resetingWeaponSelection = false;
					Game.someUIopen = true;
					weaponWheelPage = 0;
				} else {
					weaponWheelJustClosed = true;	
				}
			
			}
		}
	
	}
}