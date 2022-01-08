// @desc
//
//
//
function weapon_slot_get_id(slotID) {

	if (slotID == -1) return -1;
	return Player.weaponsEquipted[# slotID, 0];

}