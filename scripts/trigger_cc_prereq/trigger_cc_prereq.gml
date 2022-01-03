// @desc
//
//Checks to see if ALL outlined cutscenes have been completed in save file
//before constructing this trigger.

function trigger_cc_prereq_check(listOfPreReqCutscenes) {

	//Get Count
	var reqCount = array_length(listOfPreReqCutscenes);
	
	//Loop Through
	if (reqCount > 0) {
		for (var i = 0; i < reqCount; i++) {
	
			var prereqID = listOfPreReqCutscenes
			//Check, Not Completed, in which case fail
			if (!cutscene_check(prereqID)) {
				return false;	
			}
		}
	}

	return true;
}