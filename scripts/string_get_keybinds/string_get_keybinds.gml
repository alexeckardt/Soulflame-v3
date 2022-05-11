// @desc
//
//Returns a list of all the keybinds. MUST be cleaned up afterwards.
//
function string_find_keybinds(extractedStr, strWithKeybinds) {

	var keybind_list = ds_list_create();

	var subStart; 
	var finished = false;

	
	do {
		
		//Find Keybind
		var findHatPos = string_pos("^", strWithKeybinds);
		
		//Check if keybinds exist
		if (findHatPos == 0 && string_char_at(strWithKeybinds, 0) != "^") {	
			
			//Exit
			finished = true;
			
		} else {
		
			//If Found A ^, get the Keybind.
			subStart = string_copy(strWithKeybinds, 1, findHatPos-1);
			var subAfterHat = string_copy(strWithKeybinds,findHatPos,string_length(strWithKeybinds)-findHatPos-1);
			var lengthOfKeybindId =  string_pos(" ", subAfterHat)-2;
			
			//Get the Keybind
			var theControl = string_copy(strWithKeybinds, findHatPos, lengthOfKeybindId+1);
			
			//Find Position in extracted string
			var posInExtractedString = string_pos("&!", extractedStr);
			extractedStr = string_replace(extractedStr, "&!", "  ");
			
			//Add Keybind
			var keybindInfo = { keybind : theControl, pos : posInExtractedString };
			ds_list_add(keybind_list, keybindInfo);
		
			//Redo with the the rest of the string
			strWithKeybinds = string_copy(strWithKeybinds, findHatPos+lengthOfKeybindId, string_length(strWithKeybinds)-findHatPos);
		
		}
		
	} until finished;
	
	return keybind_list;
	
}
