// @desc
//
//
//
function weapon_get_wheel_slot_id(slotID, useUnlockedWheel = displayAllWeapons) {

	if (useUnlockedWheel) {
		
		return slotID;
		
	} else {
		
		return weaponsEquipted[# slotID, 0];
		
	}

}