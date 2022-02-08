//
//DESC:
//
//
//
function command_verify_exists(_value, argument_num) {
	if (_value == undefined) { throw ("Value not set, but is required. (argument " + string(argument_num) + ")"); exit; }
}