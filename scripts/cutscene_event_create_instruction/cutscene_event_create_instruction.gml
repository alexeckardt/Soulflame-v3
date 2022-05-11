// @desc
//
//
//
function cutscene_event_create_instruction(key) {

	var i = instance_create_depth(x, y, depth, Instruction);
	i.instructionKey = key;
	
	cutscene_event_end_action();

}