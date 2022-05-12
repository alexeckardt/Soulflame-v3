// @desc
//
//
//
function instruction_create(key, timeBeforeShow, preformcheck = true) {

	if (preformcheck) {
		if (game_persistence_check("instruction." + key) != undefined) {
			return noone;
		}
	}
	
	

	var i = instance_create_depth(x, y, depth, Instruction);
	i.instructionKey = key;
	i.timeLeftbeforeshow = timeBeforeShow;

	return i;

}