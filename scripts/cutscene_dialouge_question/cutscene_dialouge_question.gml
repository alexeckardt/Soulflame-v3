// @desc
//
//
//
function cutscene_dialouge_question(mainTextboxKey, playereOptionsLangKeyArray, orderedCharacterArray, allLeftBeforeIndex, hideOnFinish, completelyClearCharacters = false) {

	//Setup Dialogue for this section.
	if (myDialogue.watingForSetup) {
		
		myDialogue.DialogueType = Dialogue_type.base;
	
		//Update
		myDialogue.DialogueTextInfo = Dialogue_get_section(mainTextboxKey);
		myDialogue.characterCount = array_length(orderedCharacterArray);
		myDialogue.characterOrder = orderedCharacterArray;
		myDialogue.display = true;
		myDialogue.sectionComplete = false;
		myDialogue.hideOnFinish = hideOnFinish;
		myDialogue.leftGroupSize = allLeftBeforeIndex;
		myDialogue.sectionPart = 0;
		myDialogue.switchedSectionPart = true;
		
		//Variance
		myDialogue.askingQuestion = true;
		
		//Setup Answers
		var options = []
		var s = array_length(playereOptionsLangKeyArray);
		for (var i = 0; i < s; i++) {
		
			options[i] = lang_get_text(playereOptionsLangKeyArray[i]);
		
		}
		myDialogue.answerOptions = options;
		
		
		//
		//Setup Characters
		//Reset Chars
		if (completelyClearCharacters) {ds_map_clear(myDialogue.characters);}
		
		dialogue_cutscene_setup_character_objs(orderedCharacterArray, allLeftBeforeIndex);
			
		//Stop Setup
		myDialogue.watingForSetup = false;
		
	}

	//Wait Until Complete
	else if (myDialogue.sectionComplete) {
	
		//Done, Wait For Next
		myDialogue.watingForSetup = true;
	
		//Hide If Needed
		if (hideOnFinish) {
			myDialogue.display = false;	
			myDialogue.textboxHeightExpanded = false;	
		}
	
		//Finish, Continue
		cutscene_event_end_action();
	
	}


}