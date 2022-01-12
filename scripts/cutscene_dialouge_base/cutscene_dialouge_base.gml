// @desc
//
//Setup the Cutscene's Dialouge.
//
//textSection: language dictionary key to access from
//orderedCharacterArray: array of characters in order from left to right they should be displayed
//allLeftBeforeIndex: which characters should stick on the left side. if 2, then the first two characters will stick to the left side
//hideOnFinish: whether or not the Dialouge should appear to close after it is finished.
//
function cutscene_dialouge_base(textSection, orderedCharacterArray, allLeftBeforeIndex, hideOnFinish, completelyClearCharacters = false) {

	//Setup Dialouge for this section.
	if (myDialouge.watingForSetup) {
		
		myDialouge.dialougeType = dialouge_type.base;
	
		//Update
		myDialouge.dialougeTextInfo = dialouge_get_section(textSection);
		myDialouge.characterCount = array_length(orderedCharacterArray);
		myDialouge.characterOrder = orderedCharacterArray;
		myDialouge.display = true;
		myDialouge.sectionComplete = false;
		myDialouge.hideOnFinish = hideOnFinish;
		myDialouge.leftGroupSize = allLeftBeforeIndex;
		
		myDialouge.playerAnswer = false;
		
		//
		//Setup Characters
		//Reset Chars
		if (completelyClearCharacters) {ds_map_clear(myDialouge.characters);}
		
		dialouge_cutscene_setup_character_objs(orderedCharacterArray, allLeftBeforeIndex);
			
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
			myDialouge.textboxHeightExpanded = false;	
		}
	
		//Finish, Continue
		cutscene_event_end_action();
	
	}
}