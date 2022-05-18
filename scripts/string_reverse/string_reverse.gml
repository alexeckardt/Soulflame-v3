//
//DESC:
//
//
//
function string_reverse(str){

	var newstr = "";
	
	var len = string_length(str);
	for (var i = len; i > 0; i--) {
		newstr += string_copy(str, i, 1);	
	}
	
	return newstr;

}