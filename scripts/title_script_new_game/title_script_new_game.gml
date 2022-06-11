
//Select Whether Or Not To Use The Drawing or Not Script
function title_script_new_game(_drawing, _globAlpha){
	
	if (!_drawing) {
		title_script_new_game_step();
	} else {
		title_script_new_game_draw(_globAlpha);
	}	
	
}

function title_script_new_game_step() {
	
	//Hover
	var bboxStartY = newGameBoxStartY;
	var hBuffer = 32;
	if (!showKeyboard) {
		var subpages = 3;
		newGameBoxOver += Controller.uiVerticalMove;
		newGameBoxOver = clamp(newGameBoxOver, 0, subpages-1);
	} else {
		newGameBoxOver = 0;
	}
	
	
	//Click Events
	var userPressedGo = false;
	if (Controller.uiSelectPressed && !showKeyboard) {
		if (newGameBoxOver != -1) {
			switch (newGameBoxOver) {
				default: break;
				case 0:
					//Keyboard Show, Edit Name
					showKeyboard = !showKeyboard;
					fakeMouseX = room_width div 2;
					fakeMouseY = room_height div 2;
					
					break;
				case 1:
					//Open Settings
					//Nothing Currently Lol
					
					break;
				case 2:
					//Go
					userPressedGo = true;
					
					break;
			}
		} else {
			if (!showKeyboard) {
				//
				//Open The Page To Add!!! A Save File
				if (mouse_x > room_width - 11) {
					if (mouse_y < room_height - 11) {
						
						
						var fileToOpen = get_open_filename_ext(".sav", "", game_save_id, "Choose a Save file to open.");
						show_debug_message(fileToOpen);	

						try {
						
							var fileOpen = file_text_open_read(fileToOpen);
							show_debug_message(fileOpen);	
							
							var saveFileString = file_text_read_string(fileOpen);
						
							//Decode
							var global_save_data = json_decode(saveFileString);
						
							//Recognize Imported
							player.saveFileImported = true;
							global_save_data[? ".imported"] = player.saveFileImported;
							
							//Get Name
							var save_data = json_decode(global_save_data[? "save_data"])
							var name = save_data[? "Name"];

							//Repackage
							var newSaveString = json_encode(global_save_data);
							ds_map_destroy(global_save_data);
							ds_map_destroy(save_data);
						
							//Get The Resave
							var resavingFileName = string_lower(name) + "_" + string(ds_list_size(saveFilePaths)) + ".sav";
							var resavingfile = file_text_open_write(game_save_id + resavingFileName);
						
							//Resave To New File
							file_text_write_string(resavingfile, newSaveString);
						
							//Close
							file_text_close(resavingfile);
						
							//Add This File To save_files.txt
							var saveFileHolderFile = file_text_open_append(game_save_id + "save_files.txt");
							file_text_write_string(saveFileHolderFile, resavingFileName);
							file_text_writeln(saveFileHolderFile);
							file_text_close(saveFileHolderFile);

						
							//Load Game
							load_game(false, resavingFileName, true);
							player.saveFileName = resavingFileName;
							
							
						} catch ( _exception) {
							
							var warningRow = 3;
							var loadedText = load_text_specific_rows(999997.8, warningRow, warningRow);
							var title = loadedText[0][0];
							var body = loadedText[1][0] + "/n/n/n" + string(_exception.message);
							title_screen_popup_create(title, body);
							
						}
					}
				}
			}
		}
	}
	
	//Check Hovering
	title_check_keyboard_hovering();
	if (showKeyboard && keyboardAlpha > 0.6) {
		if (Controller.uiSelectPressed) {
			
			//Adding To Name
			var adding = keyboardHoveringWillAdd;
		
				//
				//Special Cases
				//
			//Delete Button
			if (adding == bottomButtonsWillAdd[0]) {
				adding = "";
			
				var strLeng = string_length(enteredName);
				enteredName = string_copy(enteredName, 1, strLeng - 1);
			}
		
			//Continue
			if (adding == bottomButtonsWillAdd[2]) 
			{
				adding = "";
			
				showKeyboard = false;
				if (enteredName == "") {
					enteredName = "Keira";
				}
			}
			
			
			//Add New Character to String
			enteredName += adding;
		}
	}
	
	

	if (!loadingGame) {
		if ((keyboard_check_pressed(vk_enter)) && !showKeyboard) || (userPressedGo) {
		
			//Add Save To Save File (Even if Nothing has been saved)
		
			//Open as Read (Find How Many Lines)
			directory = game_save_id;
			var savesFile = directory + "save_files.txt";
			var existingSaveFileCount = amountOfSaves;
		
			//
			//Write Save File Name To Save File Lists
			
			var newSaveFileName = string_lower(enteredName) + "_" + string(existingSaveFileCount);
			
			var appendFile = file_text_open_append(savesFile);
			var save_string = newSaveFileName + Game.saveExtension;
			file_text_write_string(appendFile, save_string);
			file_text_writeln(appendFile);

			//Close
			file_text_close(appendFile);
		
			//Prep File For Save Game Creation
			Player.Name = enteredName;
			Game.saveSlot = existingSaveFileCount;
			Game.saveSlotName = newSaveFileName;
		
			//Save
			save_game(false, true, newSaveFileName + Game.saveExtension);
			amountOfSaves++;
		
			//
			loadingGame = true;
			loadingNewGame = true;
			transitionAlphaGoal = 1;
		}
	} else {
		transitionAlphaGoal += 0.001;
	}

	//Keyboard ---------------------------------------------------------------------
	keyboardAlpha = lerp(keyboardAlpha, showKeyboard, 0.3);


	//Black Highlight Animation -----------------------------------------------------
	saveFileHighlightedPercent = lerp(saveFileHighlightedPercent, 1, 0.2);
	if (saveFileHighlighted != saveFileSelected) {
		saveFileHighlighted = saveFileSelected;	
		saveFileHighlightedPercent = 0;
	}

}

function title_script_new_game_draw(_globAlpha) {

	//Alpha
	gpu_set_blendmode(bm_add);
	var namec = c_ltgray;
	var mainAlpha = _globAlpha * (1-keyboardAlpha);
	var keyboardAlp = _globAlpha * keyboardAlpha;
	
	//Name
	var name = enteredName;
	name += (sin(current_time/200) > 0 && showKeyboard) ? "_" : "";
	
	//Draw Name Large Center Alligned Without Offset from the blinking _
	draw_set_font(fontExcelsiorLarge);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var xx = floor(centerX - string_width(enteredName) div 2);
	draw_text_colour(xx, floor(centerY div 2 + 16), name, namec,namec,namec,namec, _globAlpha);
	
	//Draw Each Box
	draw_set_font(fontExcelsior);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	for (var i = 0; i < newGameBoxCount; i++) {
		
		//Prelims
		var yy = floor(newGameBoxStartY + newGameBoxHeight*i);
		var selected = (newGameBoxOver == i)
		
		//Draw Text
		var c = (selected) ? c_white : c_dkgray;
		draw_text_colour(centerX, yy, new_game_boxes[i], c,c,c,c, mainAlpha);
	}

	//Draw Folder At Top
	draw_sprite_ext(sTitleOpenSaveFile, 0, room_width - 10, 4, 1, 1, 0, c_white, mainAlpha);

	//
	//Keyboard
	//

	//Draw Keyboard		Slots 0 - 25
	draw_set_font(fontAseprite);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	for (var j = 0; j < keyboardRows; j++) {
		for (var i = 0; i < keyboardCharsPerRow; i++) {
			
			var charPos = i + j*keyboardCharsPerRow;
			var char = string_char_at(alphabet, charPos + 1);
			var c = (keyboardKeyOver == charPos) ? c_white : c_dkgray;
			
			draw_text_colour(keyboardStartX + i*keyboardBoxDim, keyboardStartY + j*keyboardBoxDim, char, c, c, c, c, keyboardAlp);
			
		}
	}
	
	//Draw NumPad   Slots 26 - 42
	for (var j = 0; j < keyboardRows; j++) {
		for (var i = 0; i < numPadColumns; i++) {
			
			var charPos = i + j*numPadColumns;
			var char = string_char_at(nums, charPos + 1);
			var c = (keyboardKeyOver == charPos + 26) ? c_white : c_dkgray;
			
			draw_text_colour(numPadStartX + i*keyboardBoxDim, keyboardStartY + j*keyboardBoxDim, char, c, c, c, c, keyboardAlp);
			
		}
	}
	
	//Shift Slot 42
	var shiftc = (keyboardIsOnShift) ? c_ltgray : c_dkgray;
	shiftc = (keyboardKeyOver == 42) ? c_white : shiftc;
	draw_sprite_ext(sTitleKeyboardShiftKey, 0, floor(keyboardStartX - keyboardBoxDim*1.25),  floor(keyboardStartY + 2.5*keyboardBoxDim), 
																												1, 1, 0, shiftc, keyboardAlp);
	//Bottom Buffer Line
	var v = 1;
	var buff = (keyboardBoxDim) * (v / 2)
	var boardHeight = keyboardBoxDim * (keyboardRows + 0.5);
	var lineY = keyboardStartY + boardHeight;
	draw_sprite_ext(sPixel, 0, keyboardStartX - buff, lineY, totalKeyboardW - keyboardBoxDim + 2*buff, 1, 0, c_dkgray, keyboardAlp);
	
	//Draw Bottom Buttons Slots  44 - 46
	for (var i = 0; i < bottomButtonCount; i++) {
		var xx = keyboardStartX + (totalKeyboardW*(2*i + 1) div 6)
		var yy = lineY + keyboardBoxDim/3;
		
		var c = (keyboardKeyOver == i + 43) ? c_white : c_dkgray; 
		draw_text_colour(xx, yy, bottomButtons[i], c, c, c, c, keyboardAlp);
		
	}
	
	//Fake Mouse
	if (showKeyboard) {
	draw_sprite(sInventoryItemSelectionCursor, 0, fakeMouseX, fakeMouseY); }
	

	//Reset Blendmode
	gpu_set_blendmode(bm_normal);
}


//
//
//
function title_check_keyboard_hovering() {
	
	//---------------------------------------------------------
	//Prelim
	
	//Horizontal Moving
	var lastKMD = keyboardMovingDirection;
	var h = Controller.right - Controller.left;
	var v = Controller.uiUp - Controller.uiDown;
	keyboardMovingDirection = point_direction(0, 0, h, v);
	
	if (keyboardMovingDirection != lastKMD) {
		keyboardTimeUntilMove = -1;
	}
	
	
	//
	
	fakeMouseX += h;
	fakeMouseY -= v;
	
	//
	//
	//-----------MOVE KEYBOARD----------------------
	//
	//
	
	if (!keyboardMouseButKeyWasPressed) {
		
		keyboardKeyOver = -1;
		keyboardHoveringWillAdd = "";
		
		//Info From Draw
		var boardHeight = keyboardBoxDim * (keyboardRows + 0.5);
		var lineY = keyboardStartY + boardHeight;
		
		//Above!!! Line
		if (fakeMouseY < lineY && fakeMouseY >= keyboardStartY) {
			
			//
			//LETTER BOARD
			//Within Range, 0 - 26 although (26 does not count).
			var xoffset = keyboardBoxDim/4;
			if (fakeMouseX >= keyboardStartX && fakeMouseX < keyboardStartX + keyboardBoxDim*keyboardCharsPerRow - xoffset) {
				
					//Get The Pos Mouse Is Over
					var ii = (fakeMouseX - keyboardStartX + xoffset) div keyboardBoxDim;
					var jj = (fakeMouseY - keyboardStartY - keyboardBoxDim/2) div keyboardBoxDim; //yoffset required
					
					//Don't Set To Over The Range
					var keyId = ii + jj*keyboardCharsPerRow;
					keyId = (keyId >= 26) ? -1 : keyId;
					
					//Set
					keyboardKeyOver = keyId;
					keyboardHoveringWillAdd = string_char_at(alphabet, keyId + 1);
			}
			
			//
			//Number BOEARD
			//Within Range, 26 - 42
			if (fakeMouseX >= numPadStartX && fakeMouseX < numPadStartX + keyboardBoxDim*numPadColumns - xoffset) {
				
					//Get The Pos Mouse Is Over
					var ii = (fakeMouseX - numPadStartX + xoffset) div keyboardBoxDim;
					var jj = (fakeMouseY - keyboardStartY - keyboardBoxDim/2) div keyboardBoxDim; //yoffset required
					
					//Don't Set Over The Range
					var keyId = ii + jj*numPadColumns + 26;
					keyId = (keyId >= 42) ? -1 : keyId;
					
					//Set
					keyboardKeyOver = keyId;
					keyboardHoveringWillAdd = string_char_at(nums, keyId - 25);
			}
			
			//SHIFT!!
			//Num 42
			if (fakeMouseX > floor(keyboardStartX - keyboardBoxDim*1.25) && fakeMouseX < keyboardStartX) {
				if (fakeMouseY > floor(keyboardStartY + 2.5*keyboardBoxDim)) { //dont need a bottom check
					keyboardKeyOver = 42;
				}
			}
	
	
		//Special BUttons
		} else {
			
			if (fakeMouseY < lineY + keyboardBoxDim * 2.25 && fakeMouseY > lineY + keyboardBoxDim * 0.5) {
				if (fakeMouseX > keyboardStartX && fakeMouseX < keyboardStartX+totalKeyboardW) {
					
					//Get The Pos Mouse Is Over
					var ii = (fakeMouseX - keyboardStartX) div (totalKeyboardW / 3);
					
					//Set
					keyboardKeyOver = 43 + ii;
					keyboardHoveringWillAdd = bottomButtonsWillAdd[ii];
					
				}
			
			}
			
		}
		
	} else {
		
	
	
		
	}
	
	
	
	return -1;
}