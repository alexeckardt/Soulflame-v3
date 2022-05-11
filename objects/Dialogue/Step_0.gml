/// @description 

//time
var time = Game.delta;

//Fade In / Out
DialogueBottomFadePercent = lerp(DialogueBottomFadePercent, display, 0.2*time);
if (toDie) {
	display = false;
	
	if (DialogueBottomFadePercent < 0.01) {
		Game.someUIopen = false;
		instance_destroy();
		exit;
	}
}

//Get Input
showTextboxTicksLeft-=time;
if (!watingForSetup) {
	
	//Hide If There's Nothing To Show
	showTextboxTicksLeft = 10;
	
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
			
			//Reset Stuff
			cutoff = 0;
			cutoffContinuous = 0;
			effectTimer = 0;
			timeWasTrue = 0;
			textEffect = 0;
			updateTexts = false;
			
			switchedSectionPart = true;

			//Lock In Answer
			if (showAnswers) {
				if (askingQuestion) {
					if (playerAnsweringHoveringOver != -1) {
				
						//Force Exit (Maybe Remove This Later)?
						sectionPart = array_length(DialogueTextInfo);
				
						//Set Selected
						lastPlayerResponse = playerAnsweringHoveringOver;
						creator.optionSelected = playerAnsweringHoveringOver;
						creator.optionSelectedText = answerOptions[playerAnsweringHoveringOver];
					
					}
				}
			}
			
			//Section Increase; Continue
			if (!askingQuestion || playerAnsweringHoveringOver != -1) {
				
				sectionPart++;				
				playerAnsweringHoveringOver = -1;
				
				
				if (sectionPart > array_length(DialogueTextInfo)-1) {
					switchedSectionPart = false;
					sectionComplete = true;
					characterTalking = -1;
				}
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
	
		//
		//Set character Info
		//
		if (!hasCharacters) {
			
			//Noone Talking
			characterTalking = -1;
			
		} else {
		
			var characterTalkingPosition = real(characterInfo[0]);
			if (characterTalkingPosition == -1) {
				
				//Noone Talking
				characterTalking = -1;
			
			} else {
				
				//Someone Talking
				var characterTalkingId = characterOrder[characterTalkingPosition]
				characterTalking = characters[? characterTalkingId];
			
				//Emotion
				if (array_length(characterInfo) > 1) {
					characterEmotion = characterInfo[1];
				} else {
					characterEmotion = 0;	
				}
		
				//Update Sprite
				characterTalking.sprite_index = character_get_sprite(characterTalkingId, characterEmotion);

			} 
		}
		
		//
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
				//	voiceSoundId = sound_effect_create(voiceSound, 10, basePitch + random_range(-pitchVariation, pitchVariation), 1);
				//}
			} 
		
			//Keep Going
			cutoffContinuous += time;
		
		} else {
	
			//Increment Speed
			var slowedDown = in_array(string_char_at(textToDisplay, cutoff), [".", ",", "!" ,"?", "\"", "'",]) && (cutoff < strLen+1);
			timer += (1 - 0.5*slowedDown)*time;
	
		}
	
		//
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
if (textToDisplay != "") {
	textboxCenterX = lerp(textboxCenterX, textboxGoalX, 0.2*time);
	textboxY = lerp(textboxY, textboxGoalY, 0.2*time);
}

//
//Increase Height
textboxOpenTicks -= time;
var textboxAllowedOpen = (textboxOpenTicks < 0) * (display) * (showTextboxTicksLeft > 0);
var textboxHeightGoal = (textboxWritingLines+1.5) * (lineHeight) * textboxAllowedOpen;
textboxHeight = lerp(textboxHeight, textboxHeightGoal, 0.15*time);
	
if (!textboxHeightExpanded) {
	if (abs(textboxHeightGoal - textboxHeight) < 0.05) && (textboxHeightGoal != 0) {
		textboxHeightExpanded = true;	
	}
}

//
//Asking Question
var answerCount =  array_length(answerOptions);

if (askingQuestion) {

	//If askingQuestion is true, then the object has been setup.
	if (showAnswers) {
	
		//Wait For Vertical Input
		var my = Controller.uiDown - Controller.uiUp;

		//Input
		if (my != 0) {
			
			//Switch Direction Time Skip
			if (my != lastMY) {
				inputHeldDoneFirstTick = false;
				lastMY = my;
			}
			
			//First Input Skip
			if (!inputHeldDoneFirstTick) {
				inputHeldDoneFirstTick = true;
				playerAnsweringHoveringOver += my;	
			}
			
			//Time
			inputTime-=time;
			
			//Wait For Time
			if (inputTime < 0) {
				
				//Next
				playerAnsweringHoveringOver += my
	
				//Fast Scroll
				inputTime = timebetweenInputsMin;
			}
			
			//Clamp
			playerAnsweringHoveringOver = clamp(playerAnsweringHoveringOver, 0, answerCount-1)
			
		} else {
			
			//Reset Time If Not Hold
			inputTime = timeBeforeFastScroll;
			inputHeldDoneFirstTick = false;
			
		}
		
	}
	
}

draw_set_font(fontKeira);
var lH = string_height("|") + answerSpacing;
var askingBoxHeightGoal =  (answerCount+1.5)*lH * askingQuestion;
askingBoxHeight = lerp(askingBoxHeight, askingBoxHeightGoal, 0.2*time);

showAnswers = (askingBoxHeightGoal > 0) && (abs(askingBoxHeight - askingBoxHeightGoal) < 0.05);