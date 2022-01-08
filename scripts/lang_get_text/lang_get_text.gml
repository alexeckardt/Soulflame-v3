// @desc
//
//Gets Text from Lang File. Must only be text. (used for menus etc)
//
function lang_get_single_text(key) {

	//Grab
	var get = Lang.lang[? key];
	
	//Send Back Simple
	if (!is_array(get)) return get;
	
	return undefined;

}