/// @description 

//Check
if (!checkedCompleted) {
	checkedCompleted = true;
	if (game_persistence_check(creatingKey) != undefined) {
		instance_destroy();
	}
}

//Complete Time
if (place_meeting(x, y, oKeira)) {
	ticksUntilCreate--;	
}

//Once Done
if (ticksUntilCreate < 0) {
	
	//Create
	var instruction = instance_create_depth(x, y, 0, Instruction);
	instruction.instructionKey = creatingKey;
	
	//Kill
	instance_destroy();
	
}
