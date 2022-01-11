/// @description 

//time
var time = Game.delta;

//Fade In / Out
dialougeBottomFadePercent = lerp(dialougeBottomFadePercent, display, 0.2*time);
if (toDie && dialougeBottomFadePercent < 0.01) {
	Game.someUIopen = false;
	instance_destroy();
	exit;}


//Get Input
if (!watingForSetup) {
	
	//Next "Page"
	var inputReceived = Controller.uiSelectPressed;
	if (inputReceived) {
		sectionPart++;
		switchedSectionPart = true;
	
		if (sectionPart > array_length(dialougeTextInfo)-1) {
			switchedSectionPart = false;
			sectionComplete = true;
			characterTalking = -1;
		}
	}

	//
	//Set Text On Update
	if (switchedSectionPart) {
	
		var info = dialougeTextInfo[sectionPart];
		var text = info[0];
		var characterInfo = info[1];
	
		//Set Text
		textToDisplay = text;
	
		//Set character
		characterTalking = characterInfo[0];
		//Emotion
		if (array_length(characterInfo) > 1) {
			characterEmotion = characterInfo[1];
		}
	
		//Don't Continue to Update
		switchedSectionPart = false;
	}
}