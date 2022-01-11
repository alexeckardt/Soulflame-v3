// @desc
//
//
//
function cutscene_dialouge_base(textSection, characterArray, hideOnFinish) {

	//Setup Dialouge for this section.
	if (myDialouge.watingForSetup) {
		
		myDialouge.dialougeType = dialouge_type.base;
	
		//Update
		myDialouge.dialougeTextInfo = dialouge_get_section(textSection);
		myDialouge.display = true;
		myDialouge.sectionComplete = false;
		myDialouge.hideOnFinish = hideOnFinish;
		
		//Stop Setup
		myDialouge.watingForSetup = false;
		
	}

	//Wait Until Complete
	else if (myDialouge.sectionComplete) {
	
		//Done, Wait For Next
		myDialouge.watingForSetup = true;
	
		//Hide If Needed
		if (hideOnFinish) {
			myDialouge.display = false;	
		}
	
		//Finish, Continue
		cutscene_event_end_action();
	
	}
}