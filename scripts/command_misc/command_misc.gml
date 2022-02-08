//
//DESC:
//
//
//
function command_misc(_command) {

	command_verify_exists(_command, 0);
	outputMessage = "Misc Command Not Found. Use /misc help to see a list of all misc commands.";

	//
	switch (_command) {
		case "help":
		
			outputMessage = "There are no commands.";
		
			break;
	}

}