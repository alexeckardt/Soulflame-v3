/// @description 

//time
var time = Game.delta;

//Fade In / Out
DialogueBottomFadePercent = lerp(DialogueBottomFadePercent, display, 0.2*time);
if (toDie && DialogueBottomFadePercent < 0.01) {
	Game.someUIopen = false;
	instance_destroy();
	exit;
}

//Get Input
if (!watingForSetup) {
	
	//Next "Page"
	var inputReceived = Controller.uiSelectPressed;
	if (inputReceived) {
		
		//Finish Text Scrolling
		if ( cutoff < string_length(textToDisplay)) {
			
			cutoff = string_length(textToDisplay);
			cutoffContinuous = cutoff;
			
		}

		//Continue to next "Slide"
		else {
			
			sectionPart++;
			cutoff = 0;
			cutoffContinuous = 0;
			effectTimer = 0;
			timeWasTrue = 0;
			textEffect = 0;
			updateTexts = false;
			
			switchedSectionPart = true;
	
			if (sectionPart > array_length(DialogueTextInfo)-1) {
				
				switchedSectionPart = false;
				sectionComplete = true;
				characterTalking = -1;
				
			}
			
		}
	}

	//
	//Set Text On Update
	if (switchedSectionPart) {
	
		var info = DialogueTextInfo[sectionPart];
		var text = info[0];
		var characterInfo = info[1];
	
		//Set Text in Main Box
		textToDisplay = text;
	
		//Set character
		var characterTalkingPosition = real(characterInfo[0]);
		var characterTalkingId = characterOrder[characterTalkingPosition]
		characterTalking = characters[? characterTalkingId];
		
		//Emotion
		if (array_length(characterInfo) > 1) {
			characterEmotion = characterInfo[1];
		} else {
			characterEmotion = 0;	
		}
		
		//Update Sprite
		characterTalking.sprite_index = character_get_sprite(characterTalkingPosition, characterEmotion);

		//Set The Effects
		ds_list_clear(effectList);
		for (var effectPos = string_pos("#!", textToDisplay); effectPos != 0; effectPos = string_pos("#!", textToDisplay)) {
		
			//Get The Effect Number
			var effectNumber = real(string_char_at(textToDisplay, effectPos+2));
		
			//Remove the #!_
			textToDisplay = string_delete(textToDisplay, effectPos, 3);

			//Add To List
			ds_list_add(effectList, [effectNumber, effectPos]);
		}


		//Set Font
		draw_set_font(displayFont);
		
		//Set Lines
		lineHeight = string_height("|");
		var textW = maxLineLength;
		var wrapedString = string_wrap(textToDisplay, textW);
		var lines = string_count("\n", wrapedString);
		
		//Clear Lines
		for (var i = 0; i < maxLinesPossible; i++) { textLines[i] = "";	}
		textboxWritingLines = 0;
		
		//
		//Put Lines into Array of Lines
		for (var line = 0; line < lines+1; line++) {
					
			//Get Line Break
			var getNextLineBreak = string_pos("\n", wrapedString);
			if (getNextLineBreak==0) getNextLineBreak = string_length(wrapedString);
					
			//Write Line Break
			var newLineStr = string_copy(wrapedString, 1, getNextLineBreak);
			
			//Add to Array
			textLines[line] = newLineStr;
			textboxWritingLines++;
			
			//Remove This Line, Continue
			if (getNextLineBreak != 0) {
				var size = string_length(wrapedString) - getNextLineBreak;
				var restOfString = string_copy(wrapedString, getNextLineBreak+1, size);
				wrapedString = restOfString;
			}
		}
		
		//Wait For Characters to Slide In
		if (!textboxToBeOpen) {
			textboxToBeOpen = true;
			textboxOpenTicks = textboxOpeningDelay;
		}

		//
		//Don't Continue to Update
		switchedSectionPart = false;
		updateTexts = true;
		
		//Move Textbox Up If Asking Question
		textboxGoalY = (!askingQuestion) ? textboxTalkingY : textboxQuestionY

	}
	
	
	//
	//
	//Text Scolling
	//
	//
	if (textboxHeight > lineHeight) {
		
		if (timer >= textSpeed) {
		
			var strLen = string_length(textToDisplay);
		
			if (cutoff < strLen+1) {
				cutoff += time;	
				timer = 0;
		
				//Voice
				//if (!audio_is_playing(voiceSoundId)) {
					//voiceSoundId = sound_effect_create(voiceSound, 10, basePitch + random_range(-pitchVariation, pitchVariation), 1);
				//}
			} 
		
			//Keep Going
			cutoffContinuous += time;
		
		} else {
	
			//Increment Speed
			var slowedDown = in_array(string_char_at(textToDisplay, cutoff), [".", ",", "!" ,"?", "\"", "'",]) && (cutoff < strLen+1);
			timer += (1 - 0.5*slowedDown)*time;
	
		}
	
		//Effect Timer
		effectTimer += time;
	
	}
	
}


if (instance_exists(characterTalking) && characterTalking != -1) {
	
	//Pointer Position
		//Setup Def Behaviour
		var toX = characterTalking.x
		var gX = (toX)*Camera.view_width;
	
		//Instant Snap
		if (characterTalking.enteringFrame) { 
			toX = characterTalking.goalX 
			gX = (toX)*Camera.view_width;
		
			pointerX = toX*Camera.view_width;
		}
	
		//Move
		var pointerBuff = 8;
		var tbX = textboxCenterX - textBoxWidth div 2
		pointerGoalX = clamp(gX, tbX + pointerBuff, tbX + textBoxWidth - pointerBuff);
		pointerX = lerp(pointerX, pointerGoalX, 0.3*time);
	
		//Scale
		pointerYSc = lerp(pointerYSc, 2*(textboxOpenTicks < 0), 0.2*time);
	
	//Move Textbox To Keep Pointer Under/Over Character
	//(If nessesary)
		var pointerGoalDiscrepancy = gX - pointerGoalX;
		if (abs(pointerGoalDiscrepancy) > 0.01) {
		
			//Edge Shift
			var textboxEdgeScreenBuffer = 16;
			var tbGX = centerX + pointerBuff*2 + pointerGoalDiscrepancy;
			textboxGoalX = clamp(tbGX, textboxEdgeScreenBuffer, Camera.view_width - textboxEdgeScreenBuffer);
		
		} else {
			textboxGoalX = centerX;
		}

	
	//Name Position
		var tbX = textboxCenterX - textBoxWidth div 2;
		
		//Decide Goal
		var goalNameX = tbX + 16;
		if (pointerGoalX < tbX + textBoxWidth div 4) {
			goalNameX = pointerGoalX + pointerNameBuffer;
		}
	
		//Move
		nameX = lerp(nameX, goalNameX, 0.2*time);
		
}

//move Box
textboxCenterX = lerp(textboxCenterX, textboxGoalX, 0.2*time);
textboxY = lerp(textboxY, textboxGoalY, 0.2*time);

//
//Increase Height
textboxOpenTicks -= time;
var textboxHeightGoal = (textboxWritingLines+1.5) * (lineHeight) * (textboxOpenTicks < 0) * (display);
textboxHeight = lerp(textboxHeight, textboxHeightGoal, 0.15*time);
	
if (!textboxHeightExpanded) {
	if (abs(textboxHeightGoal - textboxHeight) < 0.05) && (textboxHeightGoal != 0) {
		textboxHeightExpanded = true;	
	}
}

