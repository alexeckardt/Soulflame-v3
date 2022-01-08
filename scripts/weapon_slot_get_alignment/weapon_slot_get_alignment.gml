// @desc
//
//
//
function weapon_slot_get_alignment(slotID) {
	//Return
	if (slotID == -1) return 0
	return Player.weaponsEquipted[# slotID, 1];

}