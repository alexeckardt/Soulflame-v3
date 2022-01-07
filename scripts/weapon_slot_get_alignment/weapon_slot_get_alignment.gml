// @desc
//
//
//
function weapon_slot_get_alignment(slotID, useUnlockedWheel = displayAllWeapons) {

	//Return
	if (slotID != -1 && !useUnlockedWheel) {
		return Player.weaponsEquipted[# slotID, 1];
	}
	
	return 0;

}