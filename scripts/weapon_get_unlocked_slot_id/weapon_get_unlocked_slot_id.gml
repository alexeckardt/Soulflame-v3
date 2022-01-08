// @desc
//
//
//
function weapon_get_unlocked_slot_id(slotId) {
	if (slotId == -1) return -1;
	return weaponsUnlocked[| slotId];
}