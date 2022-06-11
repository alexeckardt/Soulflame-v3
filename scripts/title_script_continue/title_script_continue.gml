
//Select Whether Or Not To Use The Drawing or Not Script
function title_script_continue(_drawing, _globAlpha){
	
	if (!_drawing) {
		title_script_continue_step();
	} else {
		title_script_continue_draw(_globAlpha);
	}	
	
}

function title_script_continue_step() {

	//Create Info
	if (!saveFileInfoCreated) {
		
		saveFileInfoCreated = true;
		
		//Clear List Of Info, Refill I
		ds_list_clear(saveFileInfo);
		
		//Clear Weapon Grid
		for (var i = 0; i < ds_list_size(saveFileWeaponGrids); i++) {	
			var gg = saveFileWeaponGrids[| i];
			if (ds_exists(gg, ds_type_grid)) {
				ds_grid_destroy(gg);
			}
		}
		ds_list_clear(saveFileWeaponGrids);
		
		//Loop THrough Save Files
		for (var i = 0; i < amountOfSaves; i++) {
			
			//Get
			var path = saveFilePaths[| i];
			var info;
			
			//Opejn File, Get Data
			var ff = path;
			var file = file_text_open_read(directory + ff);
			
				var save_string = file_text_read_string(file);
				file_text_close(file);

				//Decode From Json
				var globalGameInfo = json_decode(save_string);
				var lastSaved = globalGameInfo[? "date_saved"];
				var save_data_json = globalGameInfo[? "save_data"];
				var save_file_version = globalGameInfo[? "game_version"]; 
				var timePlayed =  globalGameInfo[? "timePlayed"];
				var name	= globalGameInfo[? "name"];
			
				//Grab From File Deeper File
				var save_data = json_decode(save_data_json);
				var maxHealth	= save_data[? "baseMaxHealth"];
				
				
				
			
				//Clean Before Garbage Collector
				ds_map_destroy(save_data);
			
				//Some Changes
				//var weaponGrid = ds_grid_create(weapon.height, 2);
				//				ds_grid_read(weaponGrid, weaponsHas);
			
			
				//Pass Onto Ds List
				info = new TitleSaveFileRep(maxHealth, timePlayed, name, save_file_version, lastSaved);
				ds_list_add(saveFileInfo, info);
				//ds_list_add(saveFileWeaponGrids, weaponGrid);	
		}
	}	

	//Priming
	lastSaveFilePrimed = (saveFilePrimed != -1) ? saveFilePrimed : lastSaveFilePrimed;
	saveFileBoxNotPrimedAlpha = lerp(saveFileBoxNotPrimedAlpha, (saveFilePrimed == -1), 0.3);
	
	if (!loadingGame) {

		//Hover Over Title Screens
		//if (saveFilePrimed == -1) {
			/*if (mouse_x > saveFileBoxX-16 && mouse_x < saveFileBoxX+saveFileBoxW+16) {
		
				//Loop, See If Mouse Is Inside Box
				var startY = centerY - (saveFileBoxH * 1.5 + saveFileBoxBuffer);
				
				//Loop Selected
				for (var i = 0; i < visibleSaveSlots; i++) {
					
					var yy = startY + (saveFileBoxH + saveFileBoxBuffer)*i;
					if (mouse_y > yy && mouse_y < yy + saveFileBoxH + saveFileBoxBuffer/2) {
				
						//Set
						saveFileSelected = i;
						break;
				
					}
				}
			}*/
			
		//}

		if (saveFilePrimed == -1) {
			saveFileSelected = clamp(saveFileSelected + Controller.uiVerticalMove, 0, visibleSaveSlots);
		} else {
			saveFileSelected = saveFilePrimed;	
		}
	
		//Press Action ----------------------------------------
		if (Controller.uiSelectPressed) {
		
			//Return To Main Page ----------------------------------------
			if (hoveringOverReturnToMain) {
				
				if (saveFilePrimed == -1) {
					pageOn = 5;
				}
				
				//Reset Primed
				saveFilePrimed = -1;
				saveFileSelected = -1;
			}
		
			//Prime Game Load OR Create New----------------------------------------
			if (saveFilePrimed == -1) {
				
				// Prime Game
				if (saveFileSelected < amountOfSaves) {
					if (saveFileSelected != -1) {
						saveFilePrimed = saveFileSelected;
						
						primed_save_file_warnings();
					}
					
				// Create New Game
				} else {
					
					pageOn = 2;
					
					
				}
		
			//Load Game ----------------------------------------
			} else {
				//Y Pos (For Second Click)
				var startY = centerY - (saveFileBoxH * 1.5 + saveFileBoxBuffer);
				var yy = startY + (saveFileBoxH + saveFileBoxBuffer)*saveFilePrimed;
			
					// Begin Loading Game
					Game.saveFileName = saveFilePaths[| saveFilePrimed];
					loadingGame = true;
					transitionAlphaGoal = 2;
					transitionTicks = room_speed*20;

					//Set Fade Colour
					var info = saveFileInfo[| saveFilePrimed];
					glowColour = essence_get_colour_bright(0);
					
			}
		}
	
		//Hover Over Return -----------------------------------------------------------
		hoveringOverReturnToMain = false;
		if (mouse_x > centerX - 16 && mouse_x < centerX + 16) {
			if (mouse_y > room_height - 16) {
				hoveringOverReturnToMain = true;	
			}
		}
	
		//Black Highlight Animation -----------------------------------------------------
		saveFileHighlightedPercent = lerp(saveFileHighlightedPercent, 1, 0.2);
		if (saveFileHighlighted != saveFileSelected) {
			saveFileHighlighted = saveFileSelected;	
			saveFileHighlightedPercent = 0;
		}
	}

	//Click Feedback
	if (loadingGame) {
		saveSlotSelectedHeightAddonto = lerp(saveSlotSelectedHeightAddonto, saveSlotSelectedHeightAddonSelectedGoal, 0.1);	
	}

}

function title_script_continue_draw(_globAlpha) {

	var buffer = saveFileBoxBuffer;
	var startY = centerY - (saveFileBoxH * 1.5 + buffer);
	var a = _globAlpha;
	//Draw Save Files
	if (saveFileInfoCreated) {
		
		
		for (var i = 0; i < visibleSaveSlots; i++) {
		
			//Selected
			var selected = (saveFileHighlighted == i);
			saveFileWidthAddOnMultiplier[i] = lerp(saveFileWidthAddOnMultiplier[i], selected*saveFileHighlightedPercent, 0.4);
			
			//Alpha Is Someone Else if Primed (Reduce), or full if primed
			var primedAlpha = (lastSaveFilePrimed != i) ? saveFileBoxNotPrimedAlpha : 1;
			var primedOffset = 48*(1-saveFileBoxNotPrimedAlpha)*(lastSaveFilePrimed == i);
			var alpha = a * primedAlpha;
			
			//Base Width
			var ww = saveFileBoxW + 16*saveFileWidthAddOnMultiplier[i];
			var xsc = ww / saveFileBorderSpriteW;
		
			//Positioning
			var xx = saveFileBoxX - 8*saveFileWidthAddOnMultiplier[i] + 10*(1-a) - primedOffset;
			var yy = startY + (buffer + saveFileBoxH) * i;

			//Highlighted Section (Behind)
			if (selected) {
				
				//Percent
				var highPer = clamp(saveFileHighlightedPercent + 0.2, 0, 1);
				var startAt = 0.6;
				var highVertPercent = max(highPer - startAt, 0) / (1 - startAt);
				
				//Stretch from Center
				var highxx = 0;
				var highww = room_width+3;
				
				//Stretch From Middle Of Save Slot
				var bb = 3;
				var heightBeforeExpand = 3
				var highMaxHH = saveFileBoxH + bb*2;
				var highyy = yy + (highMaxHH div 2) * (1 - highVertPercent) - bb - (saveSlotSelectedHeightAddonto div 2);
				var highhh = (highMaxHH - heightBeforeExpand) * highVertPercent + heightBeforeExpand + saveSlotSelectedHeightAddonto;
				
									//0.7 base, add 0.3 if im primed			//Fade Out When Pushed
				var backDropAlpha =  0.7*alpha + 0.3*(1-primedAlpha) - (saveSlotSelectedHeightAddonto / saveSlotSelectedHeightAddonSelectedGoal)
				
				//Draw Highlighted														
				draw_sprite_ext(sPixel, 0, highxx, highyy, highww, highhh, 0, c_black, backDropAlpha);
			}

			//SAVE FILE!!
			
			//Border
			draw_sprite_ext(sTitleSaveFileBorder, 1, xx, yy,				xsc, 1, 0, c_white, alpha);
			draw_sprite_ext(sTitleSaveFileBorder, 1, xx, yy + saveFileBoxH, xsc, 1, 0, c_white, alpha);
		
			//Top Spikes
			draw_sprite_ext(sTitleSaveFileBorder, 0, xx - 5,							yy, +1, 1, 0, c_white, alpha);
			draw_sprite_ext(sTitleSaveFileBorder, 0, xx + ww + 3,						yy, -1, 1, 0, c_white, alpha);
			draw_sprite_ext(sTitleSaveFileBorder, 0, xx + saveFileIconWeaponX + 3,		yy, 1, 1, 0, c_white, alpha);

			//Bottom Spikes
			draw_sprite_ext(sTitleSaveFileBorder, 0, xx - 5,					yy + saveFileBoxH + 1, +1, -1, 0, c_white, alpha);
			draw_sprite_ext(sTitleSaveFileBorder, 0, xx + ww + 3,				yy + saveFileBoxH + 1, -1, -1, 0, c_white, alpha);
		
			//
			//
			//Get Save File Information	
			if (i < ds_list_size(saveFileInfo) && saveFileInfoCreated) {
				var info = saveFileInfo[| i];
		
				//Unpack
				var maxHealth			= info.maxHealth;
				var timePlayed			= info.timePlayed;
				var save_file_version =	info.save_file_version;
				var lastSaved	=	lastSaved;
				var name		=	info.name;
				//var weaponsHas =	info.weaponsHas;		
		
				//Draw Hearts
				var heartY = yy + 8;
				for (var j = 0; j < maxHealth; j++) {
					var heartX = xx + 20*j;
					draw_sprite_ext(sHeartFull, 0, heartX, heartY, 1, 1, 0, c_white, alpha);	
				}
			
				var isSaveLoading = selected && loadingGame;
			
				//Text On Right Side
				draw_set_halign(fa_right);
				draw_set_valign(fa_top);
				draw_set_font(fontAseprite);
				
				//Location
				var c = merge_colour(c_gray, c_white, isSaveLoading);
				//var loc = lang_get_text(0);
				//draw_text_colour(xx + ww - 2, yy + 3, loc, c, c, c, c, alpha);
			
				//Time Played
				var mins = timePlayed / (60*60);
				var minutes = floor(mins) mod 60;
				var hours = mins div (60); 
				var text = string(hours) + "H " + string(minutes) + "m";
				draw_text_colour(xx + ww - 2, yy + 18, text, c, c, c, c, alpha);
			
				//Name
				draw_set_halign(fa_left);
				draw_set_valign(fa_bottom);
				draw_text_colour(xx + 4, yy - 2, name, c, c, c, c, alpha);
			
			
				//Weapons Has
				/*
				for (var k = 1; k < weapon.height; k++) {
					if (weaponsHas[# k, 0] == true) {
						
						//Draw Weapon If I own it
						draw_sprite_ext(
							sTitleWeaponIcons,
							k - 1,
							xx + saveFileIconWeaponX + saveFileIconWeaponWidth*k - 4, 
							yy-2,
							1, 1, 0, c_white, alpha
							);	
					}
					
				}*/
			
				//Go!
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
				draw_set_font(fontKeira);
				var aa = (1-saveFileBoxNotPrimedAlpha)*(lastSaveFilePrimed==i);
				draw_text_colour(xx + ww + 48 + 16*aa, yy + 21, "Go >", c, c, c, c, aa);
			} else {
				
				draw_set_halign(fa_center);
				draw_set_valign(fa_middle);
				draw_set_font(fontKeira);
				
				var c = c_ltgray;
				draw_text_colour(xx + ww/2, yy + 21, "Create New Save File", c, c, c, c, alpha);
				
				var aa = (1-saveFileBoxNotPrimedAlpha)*(lastSaveFilePrimed==i);
				var c = c_gray;
				draw_text_colour(xx + ww + 48 + 16*aa, yy + 21, "Go >", c, c, c, c, aa);	
				
			}
		}
	}
	
	//Draw "Back" at Bottom
	if (saveFileHighlighted == visibleSaveSlots) {
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		draw_set_font(fontAseprite);
		var c = (hoveringOverReturnToMain) ? c_white : c_gray;
	
		draw_text_colour(centerX, room_height - 18, "New Hidden Save File", c, c, c, c, a);
	}
}


function primed_save_file_warnings() {

		//Should Show Warning?
		//Based On Version
		var saveVersionNumber = saveFileInfo[| saveFilePrimed].save_file_version;
		var realGameVersion = Game.gameVersion;
		var showingWarning = -(saveVersionNumber < realGameVersion) + (saveVersionNumber > realGameVersion)
					
		//Get Row
		var warningRow = -1;
		if (showingWarning == -1) {
			//Outdated Save File (SaveVersionNumber is smaller)
			warningRow = 0;
		} else if (showingWarning == 1) {
			//Outdated Game (SaveVersionNumber is bigger)
			warningRow = 1;	
		}
					
		//Create Popup with Loaded Text
		if (warningRow != -1) {
			var loadedText = load_text_specific_rows(999997.8, warningRow, warningRow);
			var title = loadedText[0][0];
			var body = loadedText[1][0];
			
			title_screen_popup_create(title, body)
		}
	
						
}