// @desc
//
//
//
function instruction_create(key, timeBeforeShow) {

	var i = instance_create_depth(x, y, depth, Instruction);
	i.instructionKey = key;
	i.timeLeftbeforeshow = timeBeforeShow;

	return i;

}