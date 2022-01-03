// @desc
//
//Sets Keiras State variable.
//Skip Event: No Difference
//
function cutscene_event_keira_set_state(newState) {

	var keira = instance_nearest(x, y, oKeira);
	keira.STATE = newState;
	cutscene_event_end_action();

}