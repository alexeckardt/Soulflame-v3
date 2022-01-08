// @desc
//
//
//
function lang_get_section(key) {

	//Grab
	var get = Lang.lang[? key];
	
	//Send Back Simple
	if (!is_array(get)) return get;

	//Package Info
	var returnArray;
	var len = array_length(get);
	returnArray[len-1] = []

	//Loop Through Given Array of Arrays
	for (var i = 0; i < len; i++) {
		
		//Get Array from Array
		var textSectionPart = get[i]; 
		var infoBits = array_length(textSectionPart)-1;
		
		//Get Head
		var textSectionText = textSectionPart[0];
		
		//Create Tail
		var textSectionInfo;
		textSectionInfo[infoBits-1] = "";
		array_copy(textSectionInfo, 0, textSectionPart, 1, infoBits);
	
		returnArray[i] = [textSectionText, textSectionInfo]
	
	}

	return returnArray;

}