// @desc
//
//Setup the Cutscene's Dialogue.
//
//textSection: language dictionary key to access from
//hideOnFinish: whether or not the Dialogue should appear to close after it is finished.
//
function cutscene_dialouge_base_no_chars(textSection, hideOnFinish) {

	//Setup Dialogue for this section.
	if (myDialogue.watingForSetup) {
		
		myDialogue.DialogueType = Dialogue_type.base;
	
		//Update
		myDialogue.DialogueTextInfo = dialogue_get_section(textSection);
		myDialogue.display = true;
		myDialogue.sectionComplete = false;
		myDialogue.hideOnFinish = hideOnFinish;
		myDialogue.sectionPart = 0;
		myDialogue.switchedSectionPart = true;
		
		myDialogue.askingQuestion = false;
		
		//
		//Setup Characters
		//Reset Chars
		ds_map_clear(myDialogue.characters);
		myDialogue.characterCount = 0;
		myDialogue.hasCharacters = false;
			
		//Stop Setup
		myDialogue.watingForSetup = false;
		
	}

	//Wait Until Complete
	else if (myDialogue.sectionComplete) {
	
		//Done, Wait For Next
		myDialogue.watingForSetup = true;
		myDialogue.showTextbox = false;
		
		//Hide If Needed
		if (hideOnFinish) {
			myDialogue.display = false;	
			myDialogue.textboxHeightExpanded = false;	
		}
	
		//Finish, Continue
		cutscene_event_end_action();
	
	}
}