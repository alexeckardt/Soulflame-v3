//
//DESC:
//
//
//
function command_summon(_entity, _x, _y, _relative) {
	
	//Error Messages Off The Bat
	if (_entity == undefined) { throw ("Entity Not Defined (argument 0)"); exit; }
	
	//Set The Object to Create;
	var entityObj = undefined;
	entityObj = asset_get_index(_entity);
	if (entityObj == -1) { throw ("Entity Type Does Not Exists (argument 0}"); exit; }
	
	
	//Get Position																	
	
	//Summon The Entity
	instance_create_depth(	command_verify_number(_x, 1), 
							command_verify_number(_y, 2), 
							oKeira.depth+100, 
							entityObj);
		
		
	//Output
	outputMessage = "Summoned " + string(_entity) + "at (" + string(_x) + ", " + string(_y) + ").";
	
}