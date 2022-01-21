// @desc
//
//
//
function lang_get_text_no_pointers(key) {

	//Grab
	var get = Lang.lang[? key];
	
	//Must Be Simple
	if (!is_array(get)) {
		if (get == undefined) {
			return "? " + string(key)
		}
		
		//Replace Any Pointers
		var text = get;
		for (var j = string_pos("{", text); j != 0; j = string_pos("{", text)) {
			
			//End Pointer Position
			var endPointerpos = string_pos("}", text);
			if (endPointerpos == 0) break; //no more pointers
			
			//Get Real Text
			var pointer = string_copy(text, j, endPointerpos-j+1); 

			//Replace
			text = string_replace(text, pointer, "");
		}
		
		//Return What I Got
		return text;
		
	}
	
	//Does not Work
	return undefined;

}