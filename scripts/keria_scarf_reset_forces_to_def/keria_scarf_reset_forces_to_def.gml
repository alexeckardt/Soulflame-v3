// @desc
//
//
//
function keria_scarf_reset_forces_to_def() {
	//Reset
	netForce.set(lengthdir_x(gravStr, gravDir), lengthdir_y(gravStr, gravDir));
	
}