// @desc
//
//
//
function weapon_get_wheel_slot_id(slotID, useUnlockedWheel = displayAllWeapons) {

	if (useUnlockedWheel) {
		
		return Player.weaponsUnlocked[| slotID];
		
	} else {
		
		return Player.weaponsEquipted[# slotID, 0];
		
	}

}