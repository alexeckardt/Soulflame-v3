/// @desc

if (typingCommand || !ranCommand) {

	//Type
	typingString += string(keyboard_string);
	keyboard_string = "";
	
	//Delete a char
	if (keyboard_check_pressed(vk_backspace)) {
		var l = string_length(typingString);
		if (l > 1) {
			typingString = string_copy(typingString, 1, l-1);
		}
	}
	
	//Get No Slash
	var commandNoSlash = string_copy(typingString, 2, string_length(typingString)-1);
	
	
	//
	//Enter Command
	if (keyboard_check_pressed(vk_enter)) {
	
		keyboard_lastkey = -1;
		keyboard_string = "";
			
		//Set Command
		lastCommandInputed = commandNoSlash;
			
		//Run Command
		runCommand = true;
	
	}

	//
	//
	//Run Command
	if (runCommand) {
		runCommand = false;
		ranCommand = true;
		
		var successfulRun = false;
		
		//Hide Hint
		commandHint = "";
		typingCommand = false;
			
		//Get All Arguments
		var argumentsArray = string_split(lastCommandInputed);
		var scriptToRunName = "command_" + string(argumentsArray[0]);
		array_delete(argumentsArray, 0, 1);
		
		//Call The Script
		var commandCount = ds_list_size(commands);
		for (var i = 0; i < commandCount; i++) {
			
			//Is Same Command?
			var commandInfo = commands[| i];
			
			var commandsScript = commandInfo[1];
			if (script_get_name(commandInfo[1]) == scriptToRunName) {
					
				//
				try {
					successfulRun = true;
					script_execute_alt(commandsScript, argumentsArray);
						
				//Catch Any Errors, Display Them.
				} catch (_exception) {
					outputMessage = _exception;	
				}
				
				//Exit
				break;
			}
			
		}
		
		//No Command Reccognized
		if (!successfulRun) {
			outputMessage = "Command not reccognized.";
		}

	}


	//
	//COMMAND HINT
	//
	//Reccognize What Command They are writing, if they wrote out the first word already
	//if (lastCommandString != thisCommandString) {
		
	//Get The Word
	if (typingString != lastTypingString) {
		
		if (!checkedForCommandName) {
			
			//Don't Check Again and Again
			checkedForCommandName = true;
			
			//Reset Hint
			commandHint = "";
			
			//First Word Position
			var commandNameSpacePos = string_pos(" ", typingString)-1;
			if (commandNameSpacePos == -1) commandNameSpacePos = string_length(typingString);
			
			//Get The Command Word
			var theCommandWord = string_copy(commandNoSlash, 1, commandNameSpacePos-1);
	
			//Loop through, find matching name
			var commandCount = ds_list_size(commands);
			for (var i = 0; i < commandCount; i++) {
				var commandInfo = commands[| i];
				var commandsScript = commandInfo[1];
				var commandScriptName = string_replace(script_get_name(commandInfo[1]), "command_", "");
			
				//Set the Hint as the rest of the prefill
				if (commandScriptName == theCommandWord) {
					commandHint = "/" + string(commandScriptName) + " " + string(commandInfo[0]);
					reccognizedCommand = true;
					break;
				}
			}
		}
	
		//Could not find the command
		if (commandHint == "") {
			commandHint = "Command not reccognized";
			reccognizedCommand = false;}
			
	} else {
		
		//Wait until word is typed yet
		checkedForCommandName = false;
		
	}

	//Reset For Checks
	lastTypingString = typingString;

}

//
//DONE... display for time
//
else {
	
	//
	stillDrawingTicks -= Game.delta;
	if (stillDrawingTicks < 0) {
		instance_destroy();	
	}
	
	//Run Again
	if (keyboard_check_pressed(vk_enter)) {
	
		ranCommand = false;
		runCommand = true;
		
		typingString = lastCommandInputed;
		
		//Reset Timer
		stillDrawingTicks = idleTimeBeforeDestroy;
	}
	
}