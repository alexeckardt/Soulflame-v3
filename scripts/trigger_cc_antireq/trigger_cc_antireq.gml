// @desc
//
//Checks to see if NO outlined cutscenes have been completed in save file.
//before constructing this trigger.
//

function trigger_cc_antireq(listOfPreReqCutscenes) {

	//Get Count
	var reqCount = array_length(listOfPreReqCutscenes);
	
	//Loop Through
	if (reqCount > 0) {
		for (var i = 0; i < reqCount; i++) {
	
			var prereqID = listOfPreReqCutscenes
			
			//Check Completed, in which case fail
			if (cutscene_check(prereqID)) {
				return false;	
			}
		}
	}

	return true;
}