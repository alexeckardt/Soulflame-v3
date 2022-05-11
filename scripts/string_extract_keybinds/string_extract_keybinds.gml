// @desc
//
//Recursivley replace all "^grigjojgog" with a space.
// Should use in tandem with string_get_keybinds();
//

function string_extract_keybinds(str) {

	var subStart; 
	var subEnd;

	var findHatPos = string_pos("^", str);
		
	if (findHatPos == 0 && string_char_at(str, 0) != "^") {		

		return str;
			
	}
		
		
	//If Found A ^, get the Keybind.
	subStart = string_copy(str, 1, findHatPos-1);
	var subAfterHat = string_copy(str,findHatPos,string_length(str)-findHatPos-1);
	var lengthOfKeybindId =  string_pos(" ", subAfterHat)-1;
			
	//Get the Keybind
	var theControl = string_copy(str, findHatPos, lengthOfKeybindId);
			
	//Get Rest of String
	subEnd = string_copy(str, findHatPos+lengthOfKeybindId, string_length(str)-findHatPos);
			
	//Return the combined string
	return subStart + "&!" + string_extract_keybinds(subEnd);
					// ^ indicator for a keybind is here
}