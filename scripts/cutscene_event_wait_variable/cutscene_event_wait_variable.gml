// @desc
//
//Dangeroud! Waits unti a variable has the set value.
//
//Skip Functionality: Sets variable.
//
function cutscene_event_wait_variable(obj, variable, requiredValue) {

	if (variable_instance_get(obj, variable) == requiredValue || skipCutscene) {
		variable_instance_set(obj, variable, requiredValue);
		cutscene_event_end_action();	
	}

}