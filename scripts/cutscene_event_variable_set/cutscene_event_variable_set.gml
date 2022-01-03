// @desc
//
//Sets an instance variable.
//Skip Event: No Difference
//
function cutscene_event_variable_set(instance, variableAsString, newValue) {

	variable_instance_set(instance, variableAsString, newValue);
	cutscene_end_action();

}