// @desc
//
//
//
function player_weapon_wheel_select_slot_partial_wheel(actualDir, slots, arclength, arcoffset) {
	
	//Keep Consistant in Draw; No Guessing
	//
	weaponWheelArcLength = arclength;
	weaponWheelArcStartAngleOffset = arcoffset;
	weaponWheelSlots = slots;

	//
	//

	var segSize = arclength / slots;
	var cD = (actualDir + 360) - weaponWheelArcStartAngleOffset;
	cD %= 360;
				
	//Get What Segment Stick is aiming IN
	var weaponSlotSelecting = weaponSlotHighlighted;
	if (Controller.rightStickHolding) {
		
		
		var testSeg = cD div segSize;
		
		//If Controller Direction is WITHIN the arc confines
		if (testSeg >= 0 && testSeg < slots) {
			weaponSlotSelecting = testSeg;
			
		//
		//Not Inside Range; Clear
		} else {
			weaponSlotHighlighted = -1;
			weaponSlotSelecting = -1;	
		}
	}
		
	//
	//
	//Check If Holding The Same Slot
	sameweaponSlotHighlightedFor += Game.delta;
	if (weaponSlotSelecting != weaponSlotHighlighted) {
		lastWeaponSlotHighlightedFor = sameweaponSlotHighlightedFor;
		sameweaponSlotHighlightedFor = 0;
	}
			
	//Reccognize Selected Slot;
	lastWeaponSlotHighlighted = weaponSlotHighlighted;
	weaponSlotHighlighted = weaponSlotSelecting;

}