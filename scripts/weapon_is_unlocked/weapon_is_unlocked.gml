// @desc
//
//
//
function weapon_is_unlocked(weaponID) {

	var get = Player.weaponsUnlocked[? weaponID];

	if (is_undefined(get)) {
		return false;
	}
	
	return get;

}