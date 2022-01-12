// @desc
//
//
//
function dialouge_get_section(section) {

	var defText = lang_get_section(section);
	
	//Force To Array Confines  (Text, character)
	if (!is_array(defText)) {
		return [ [defText, [0]], ]
	} 
	
	return defText;
}