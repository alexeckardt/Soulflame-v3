// @desc
//
//
//
function cutscene_dialouge_question(mainTextboxKey, playereOptionsLangKeyArray, orderedCharacterArray, allLeftBeforeIndex, hideOnFinish, completelyClearCharacters = false) {

	//Setup Dialouge for this section.
	if (myDialouge.watingForSetup) {
		
		myDialouge.dialougeType = dialouge_type.base;
	
		//Update
		myDialouge.dialougeTextInfo = dialouge_get_section(mainTextboxKey);
		myDialouge.characterCount = array_length(orderedCharacterArray);
		myDialouge.characterOrder = orderedCharacterArray;
		myDialouge.display = true;
		myDialouge.sectionComplete = false;
		myDialouge.hideOnFinish = hideOnFinish;
		myDialouge.leftGroupSize = allLeftBeforeIndex;
		
		//Variance
		myDialouge.playerAnswer = true;
		
		//Setup Answers
		var options = []
		var s = array_length(playereOptionsLangKeyArray);
		for (var i = 0; i < s; i++) {
		
			options[i] = lang_get_text(playereOptionsLangKeyArray[i]);
		
		}
		myDialouge.answerOptions = options;
		
		
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