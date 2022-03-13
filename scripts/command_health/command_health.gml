//
//DESC:
//
//
//
function command_health(_action, _value) {

	//Prelim
	if (_action == undefined) { _action = "heal" } 
	_value = real(_value);
	
	switch(_action) {
		
		case "set":
			
			Player.hp = command_verify_number(_value, 1, player.maxhp);
			outputMessage = "Health Set to " + string(floor(Player.hp));
			
			break;
		case "add":
		
			Player.hp += command_verify_number(_value, 1);
			outputMessage = "Health Set to " + string(floor(Player.hp));
		
			break;
		case "heal":
		
			Player.hp = Player.currentMaxHealth;
			outputMessage = "Health Restored.";
			
			break;
		case "hurt":
		case "subtract":
		case "lose":
		case "take":
		
			Player.hp -= (_value == undefined) ? 1 : command_verify_number(_value, 1);
			outputMessage = "Health Set to " + string(floor(Player.hp));
		
			break;
		case "maxSet":
		case "setmax":
		
			Player.baseMaxHealth = command_verify_number(_value, 1);
			outputMessage = "Base Max Health Set to " + string(floor(Player.baseMaxHealth));
		
			break;
			
		default:
		
			outputMessage = "Action Not Reccognized (argument 0)";
			break;
	}

}