// @desc
//
//
//
function weapon_is_unlocked(weaponID) {

	var get = ds_list_find_value(weaponsUnlocked, weaponID);

	if (is_undefined(get)) {
		return false;
	}
	
	return get;

}