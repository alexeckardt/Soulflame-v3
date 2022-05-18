//
//DESC:
//
// Replaces the last occurance of a string w a string
//
function string_replace_last(str, oldsubstr, newsubstr) {

	if (string_pos(oldsubstr, str) != 0) {

		str = string_reverse(str);
		str = string_replace(str, oldsubstr, newsubstr);
	
		return string_reverse(str);
	
	}
	
	return str;
	
}