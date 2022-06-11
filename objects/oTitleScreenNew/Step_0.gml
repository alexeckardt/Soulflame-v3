/// @description 

var currentPage = pageOn;
camera_set_view_pos(view_camera[0], 0, 0);

//
if (instance_exists(Camera)) {
	instance_destroy(Camera.id);
}

//
//Reload Game
//
if (pageOn == -1) {
	pageOn = 0;
	currentPage = 0;
	showKeyboard = false;
	saveFileHighlighted = 0;
	
	//Reload Save Files
	title_get_save_files();
	amountOfSaves = ds_list_size(saveFilePaths);
	saveFileInfoCreated = false;
	
	//Allow Continue If Save Files Exists
	if (amountOfSaves > 0) {
		
		//Add Continue To options, Remove New Game 
		ds_list_delete(visiblePages, 0);
		ds_list_insert(visiblePages, 0, 1);
	}
	
	
}

//Introduction Alpha (Fade Away)
var spd = 0.008;//0.006
if (abs(transitionAlphaGoal - transitionAlpha) > spd) {	

	transitionTicks++;
	if (transitionTicks > room_speed * (1 + 2*fromGameStart)) {
		transitionAlpha += sign(transitionAlphaGoal - transitionAlpha) * spd;
	}
	
	//Colour
	if (transitionAlphaGoal == 0) {
		shaderBurnAwayColour = essence_get_colour_emission(0);
	}
	
} else {
	
	transitionTicks = room_speed*10;
	//if keyboard_check_pressed(vk_space) {
		//transitionAlphaGoal = !transitionAlphaGoal;
		//transitionPositionChose = false;
	//
}

//Reveal
if (transitionAlpha < 0.9) {
	titleAlpha = lerp(titleAlpha, (pageOn == 0), 0.3 - 0.15*(titleRevealDir==1));
}

//Fade Away Going Up, instead of down.
if (titleAlpha > 0.95) {titleRevealDir = -1; }

//----------------------------------------

//Run Events From Page Currently On
if (pageScripts[pageOn] != -1) {
	script_execute(pageScripts[pageOn], false);
} else {
	
	//Go To Title if ALL PAGES have no more alpha
	var toTitle = false;
	for (var i = 0; i < array_length(pageDrawingAlphas); i++) {
		if (pageDrawingAlphas[i] > 0.05) {
			toTitle = true;
			break;
		}
	}
	
	//Reset
	if (toTitle) {
		pageOn = -1;
	}
}

//Temp
//pageOn = (pageOn + keyboard_check_released(vk_down)) % 5;

//--------------------------------------------------------------------------------

//Load Game

var saveFileName = Game.saveSlotName + Game.saveExtension;

if (loadingGame) {
		
	//Wait Until Faded Out A ton
	if (transitionAlpha > 1.3) {
		if (!loadingNewGame) {
			
			//Load Game
			if (file_exists(game_save_id + saveFileName)) {
				if (!loadedGame) {
					load_game( saveFileName, true);
					loadedGame = true;
				}
			} else {
				
				//Stop
				loadingGame = false;
				loadedGame = false;
				
				//File DNE
				var warningRow = 2;
				var loadedText = load_text_specific_rows(999997.8, warningRow, warningRow);
				var title = loadedText[0][0];
				var body = loadedText[1][0];
				title_screen_popup_create(title, body);
				
				//Return To Main
				transitionAlpha = 0;
				transitionAlphaGoal = 0;
				pageOn = -1;
				saveFilePrimed = -1;
				
			}
		} else {
			
			//Train Bridge Cutscene
			//
			//Transition
			var trans = transition_create(oTransitionFade, roomLab, -100, -100, 1,
				1, c_black, undefined, undefined);

			//Don't set on noone (if mutliple created attempt)
			if (trans != noone) {
				trans.independentDelta = true;
			}
			loadedGame = true;
			
			//
			var name = string_lower(enteredName);
			Game.saveSlotName = string_replace(name, ".sav", "");
		}
	}
}

//---------------------------------------------------------------------------------

//Return To Base
if (keyboard_check_pressed(vk_escape) || Controller.uiBackPressed) {
	pageOn = -1;
}

//Update Last Page
if (pageOn != currentPage) {
	lastPage = currentPage;
}