// @desc
//
//
//

function string_wrap(str, max_width) {

	var str_len = string_length(str);
	var last_space = 1;

	var count = 1;
	var substr;

	repeat(str_len) {
		//get substring
		substr = string_copy(str, 1, count);
	
		//Find Last Space
		if (string_char_at(str, count) == " ") {
			last_space = count;	
		}
	
		//insert \n into the string if the line is too long
		if (string_width(substr) > max_width) {
			str = string_delete(str, last_space, 1);
			str = string_insert("\n", str, last_space);	
		}
	
		//Count the length of the str
		count++;
	}
	
	//Return Wrapped String
	return str;

}