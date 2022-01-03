// @desc
//
//Sets an instance variable.
//Skip Event: No Difference
//
function cutscene_event_change_variable(instance, variableAsString, newValue) {

	variable_instance_set(instance, variableAsString, newValue);
	cutscene_event_end_action();

}