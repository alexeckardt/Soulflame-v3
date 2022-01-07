// @desc
//
//
//
function weapon_slot_get_id(slotID, useUnlockedWheel = displayAllWeapons) {

	if (useUnlockedWheel) {
		return Player.weaponsUnlocked[| slotID];
		
	} else {
		
		if (slotID == -1) {return -1;}
		return Player.weaponsEquipted[# slotID, 0];
		
	}

}