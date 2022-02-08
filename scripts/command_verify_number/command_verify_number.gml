//
//DESC:
//
// Verifies the existance of a number. Extracts it.
//
function command_verify_number(_value, argument_num) {
	
	if (_value == undefined) { 
		throw ("Value not set, but is required. (argument " + string(argument_num) + ")"); exit; 
	}
	
	//Check If Value is a Number
	try {
		
		//Gooen Ending
		var inputtedNum = real(_value);	
		return inputtedNum;
		
		
	} catch (_e) {
		throw "Value is not a real number. (argument " + string(argument_num) + ")";	
	}

}