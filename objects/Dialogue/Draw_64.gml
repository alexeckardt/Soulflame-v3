/// @description 

var w = cameraScreenWidth;
var h = Camera.view_height;

var z = Camera.zoom;

//Draw Background
display_set_gui_size(w, h);

if (DialogueBottomFadePercent > 0.01) {

	//Draw Black Rectangles at Varying Alphas to "Fadeout" Text
	var fadeTotalHeight = bottomFadeHeight * h;
	var fadeSectionHeight = fadeTotalHeight div bottomFadeSections;
	var c = bottomFadeColour;
	for (var i = 0; i < bottomFadeSections; i++) {

		var p = (bottomFadeSections-i) / bottomFadeSections * DialogueBottomFadePercent;
		draw_sprite_ext(sPixel, 0, 0, h-fadeSectionHeight*(i+1), w, fadeSectionHeight, 0, c, p);

	}

	//
	//Draw Characters

	var characterZoom = characterPixelGoalSize / z;
	var dsplW = w / characterZoom;
	display_set_gui_size(dsplW, h / characterZoom);

	//Get Objs
	var characterObjs = ds_map_values_to_array(characters);
	var charachterObjCount = array_length(characterObjs);
	for (var i = 0; i < charachterObjCount; i++) {

		var obj = characterObjs[i];
		var spr = obj.sprite_index;
		
		//Draw Objs On GUI
		if (spr != -1) {
			draw_sprite_ext(spr, obj.image_index, obj.x * dsplW, h/characterZoom,
								obj.image_xscale, obj.image_yscale, 0, obj.image_blend, obj.image_alpha);
		}
	
	}

	//
	//
	//
	//

	//
	display_set_gui_size(w, h);

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(displayFont);

	var tbX = textboxCenterX - textBoxWidth div 2;
	var tbY = textboxY - textboxHeight div 2; //+ ;
	
	//Draw Size
	display_set_gui_size(w, h);

	//Draw Text Box Background
	if (textToDisplay != "") {
		
		//Drae BKG
		draw_sprite_ext(sPixel, 0, tbX, tbY, textBoxWidth, textboxHeight, 0, speechBubbleColour, 1);

		//Box Accessories
		if (instance_exists(characterTalking) && characterTalking != -1 && textboxToBeOpen) {
		
			//Speech Bubble Pointer	
			var pX = pointerX
			draw_sprite_ext(sDialogueBoxSpeechPointer, 0, pX, tbY, 1, pointerYSc, 0, speechBubbleColour, 1);
		
			//Draw Charachter Name
			var name = characterTalking.nameStr;
			var cc = charachter_get_name_colour(characterTalking.characterId);
			var textY =  tbY - lineHeight div 2;
			draw_text_colour(nameX, textY, name, cc, cc, cc, cc, 1);
		
		}
	}

	//
	//Draw Text in Main Box
	//

	//Setup
	var buffer = textboxTextBuffer;
	var originalPosX = tbX + buffer;
	var originalPosY = tbY + buffer;
	var textX  = -1; //Modify
	var textY  = originalPosY;

	var lines = maxLinesPossible;
	var stringCutoff = cutoff; //Independant Modifable

	var charDrawing = 1;
	var effectChecking = 0; //Effects are in order, so we only have to check one and increment this as we pass it in characters
	textEffect = 0;
	
	//
	//
	
	//Loop Through Lines
	for (var line = 0; line < lines; line++) {
		if (stringCutoff > 0) {
			
			//Get Line String
			var lineStr = textLines[line];
			
			//Get Line Substring
			var lineLen = string_length(lineStr);
			var substrLen = max(min(lineLen, stringCutoff), 0);
			var substr = string_copy(lineStr, 0, substrLen);
			
			//Reduce the overall cutoff for the next line
			stringCutoff -= substrLen;
			
			//Reset Position this text
			textY = originalPosY + lineHeight*line + 2;
			textX = textboxCenterX - string_width(lineStr) div 2;
			
			//Draw Each Character
			for (var i = 1; i < substrLen+1; i++) {
	
				//Character
				var cc = string_char_at(substr, i);
	
				//Change Effect If the Charachter Index of the string matches the one in the effect list
				var listsize = ds_list_size(effectList);
				if (effectChecking < listsize) { //0 !< 0, so no check needed
					var effectCheckingDetails = effectList[| effectChecking];
					if (charDrawing == effectCheckingDetails[1]) {
						textEffect = effectCheckingDetails[0];
						effectChecking++;
					}
				}
	
				//Line
				Dialogue_text_draw_character_with_effect(cc, textX, textY, textEffect % text_effect.height, charDrawing);
			
				charDrawing++;
			
				//Increment Position
				textX += string_width(cc);
			}
			
		//Only Draw Lines If they have been revealed
		} else {
			break;	
		}
	}

	//
	//
	//
	if (askingQuestion) {
		var answerCount = array_length(answerOptions) 
		if (answerCount > 0) {
		
			var abX = centerX - askingBoxWidth div 2;
			var abY = textboxTalkingY - askingBoxHeight div 2;
		
			//Draw BKG	
			draw_sprite_ext(sPixel, 0, abX, abY, askingBoxWidth, askingBoxHeight, 0, speechBubbleColour, 1);
			
			//Draw Answers
			if (showAnswers) {
				
				//Set Font
				draw_set_font(fontKeira);
				draw_set_valign(fa_top);
				draw_set_halign(fa_middle);
				var lH = string_height("|") + answerSpacing;

				//Loop Through
				for (var i = 0; i < answerCount; i++) {
				
					//Get Answer
					var answerStr = answerOptions[i];
				
					//Position
					var answerY = abY + lH*(i+1);
				
					//Draw Text
					var c = (playerAnsweringHoveringOver == i) ? c_white : Game.textDefCol;
					draw_text_colour(centerX, answerY, answerStr, c, c, c, c, 1)
				
				}
			}
		}
	}

}