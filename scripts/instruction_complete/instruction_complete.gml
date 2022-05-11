// @desc
//
//
//
function instruction_complete(key) {

	if (instance_exists(Instruction)) {
		var i = Instruction.id;	
		if (!i.completed && i.instructionKey == key) {
			i.completed = true;
		}
		
	}

}