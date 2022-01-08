// @desc
//
//
//
function player_weapon_wheel_open(){

	//Must Be Closed and Nothing Else is Open
	if (!Game.someUIopen && !weaponUiOpen) {

		//Allow for Forging
		var campfire = instance_nearest(oKeira.x, oKeira.y, oCampfire);
		var atCampfire = (instance_exists(campfire)) && (campfire.lit && oKeira.STATE = state.sit)
		var CutsceneExists = instance_exists(Cutscene);
		var hasAWeapon = ds_list_size(Player.weaponsUnlocked);

		//
		//Forge Check
		allowForging = hasAWeapon && (atCampfire); //|| atSomethingElse ...);
	
		//
		//Opened Check
		weaponWheelJustOpened = false;
	
		//
		//
		//Open/Close
		if (!allowForging) {
		
			//Open As Combat Wheel
			if (Controller.rightStickHolding) {
				weaponUiOpen = true;
				weaponUipage = 0;
			}
		
		} else {
		
			//Open as Forge Wheel
			if (Controller.combatAttackPressed) {
				weaponUiOpen = true;
				weaponUipage = 1;
			}
		
		}
	
		//
		//Setup Opening
		if (weaponUiOpen) {
			weaponSlotHighlighted = -1;
			Game.someUIopen = true;
			weaponWheelJustOpened = true;
		}
		
		
		//
		//Bypass; Reset and Close
		if (Controller.rightStickPressed) {
			weaponUsing = weapon.none;
			weaponAlignment = 0;
			weaponSlotUsing = -1;
			
			weaponUiOpen = false;
		}
	}
}