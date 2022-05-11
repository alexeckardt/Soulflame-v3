// @desc
//
//
//
function string_prep_string_for_keybinds_draw(_str) {

	var newString = string_extract_keybinds(_str);
	var keybind_list = string_find_keybinds(newString, _str);

	var struct = { str : newString, list : keybind_list };
	return struct;

}