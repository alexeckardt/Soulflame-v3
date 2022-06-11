//Initialize
display_set_gui_size(room_width, room_height);

//Positions
centerX = room_width div 2;
centerY = room_height div 2;
titleBaseY = room_height div 4;

// :)
transitionAlpha = 0.4;
transitionAlphaGoal = transitionAlpha;
transitionTicks = 0;
transitionScale = 4;
transitionScalePositionX = 96;
transitionScalePositionY = 54;
transitionPositionChose = true;
transitionRotation = 0;
fromGameStart = current_time < room_speed*10;

shader = shd_BurnAway;
_u_fullAlphaBelowValue = shader_get_uniform(shader, "fullAlphaBelowValue");
_u_glowColour = shader_get_uniform(shader, "glowColour");
_u_leadingBlur = shader_get_uniform(shader, "leadingBlur");
transitionSurface = -1;

shaderBurnAwayColour = c_black;
glowColour = c_white;

//Save File Order
saveFilePaths = ds_list_create();
lastUsedSaveFile = saveFilePaths[| 0];

saveFileInfo = ds_list_create();
saveFileInfoCreated = false;
directory = game_save_id;

//Background
backgroundLocation = location.chasm;
backgroundSprite = sBackgroundChasm;
uniSize = shader_get_uniform(shd_Guassian, "size"); //
s = 5;
backgroundSurf = -1;
blurredSurf = -1;

//Title Screen
titleAlpha = 0;
titleAlphaTo = 1;
titleRevealDir = 1;

//Pages
pageOn = -1;
lastPage = -1;
pageHoveringOver = -1;
hoveringOverReturnToMain = false;
pageNames = ["Main", "Continue", "New Game", "Settings", "Quit", "Until Page Is Faded"];
pageDrawingAlphas[array_length(pageNames)] = 0;
pageScripts = [title_script_main, title_script_continue, title_script_new_game, title_script_settings, title_script_quit, -1];

	visiblePages = ds_list_create();
	ds_list_add(visiblePages, 2);
	ds_list_add(visiblePages, 3);
	ds_list_add(visiblePages, 4);
pageStartY = centerY;
pageSeperation = 24;

versionNumber = "a2.2.0";

//Continue Page Variables
saveFilesReccognized = 0;
saveFileSelected = -1;
saveFileBoxW = 248;
saveFileBoxH = 36;
saveFileBoxBuffer = 20;
saveFileBoxNotPrimedAlpha = 1;
saveFileBoxX = (room_width - saveFileBoxW) div 2
saveFileIconWeaponWidth = sprite_get_width(sTitleWeaponIcons);
saveFileIconWeaponX		= saveFileBoxW - ((saveFileIconWeaponWidth + 2) * 5);
saveFileBorderSpriteW  = sprite_get_width(sTitleSaveFileBorder);
saveSlotSelectedHeightAddonto = 0;
saveSlotSelectedHeightAddonSelectedGoal = 300;

saveFileHighlighted = -1;
saveFileHighlightedPercent = 0;

amountOfSaves = ds_list_size(saveFilePaths);
saveFileWidthAddOnMultiplier[3] = 0;
saveFilePrimed = -1;
lastSaveFilePrimed = -1; //Set to saveFilePrimed if NOT -1
visibleSaveSlots = 3;
saveFileWeaponGrids = ds_list_create(); //To Clean them up

loadingGame = false; //If true, no actions can be made in the continue page. The deed is done.
loadedGame = false; //Prevent Endless Loop of Loading Behavoiur

//New Game Page Variables
enteredName = "Keira";
newGamePageBoxHeight = 32; //Name is 2x this
showKeyboard = false;
new_game_boxes = ["Change Name", "Options", "Continue"];
newGameBoxCount = array_length(new_game_boxes);
newGameBoxOver = -1;
newGameBoxStartY = centerY;
newGameBoxHeight = pageSeperation;

fakeMouseX = room_width div 2;
fakeMouseY = room_width div 2;

alphabet = "abcdefghijklmnopqrstuvwxyz"
nums = "1234567890',.-+"

bottomButtonCount = 3;
bottomButtons = ["backspace", "space", "confirm"];
bottomButtonsWillAdd = ["=--", " ", "=++"]; //Not Actually Added To Name*, Just Used To Regognize To Do Something	
												//*Space does

keyboardKeyOver = -1;
keyboardAlpha = 0;
keyboardCharsPerRow = 9;
keyboardRows = ceil(string_length(alphabet) / keyboardCharsPerRow);
keyboardBoxDim = 10;
keyboardXdrawOffset = keyboardBoxDim;
keyboardStartY = centerY;
keyboardIsOnShift = false;


keyboardMouseButKeyWasPressed = false;
keyboardMovingDirection = 0; // 0, 45, 90 ...
keyboardTimeUntilMove = 0;
keyboardLastMouseX = 0;
keyboardLastMouseY = 0;

numPadColumns = 5;						
totalKeyboardW = keyboardCharsPerRow*keyboardBoxDim + 3*keyboardBoxDim + numPadColumns*keyboardBoxDim;
keyboardStartX = centerX - (totalKeyboardW div 2) + keyboardXdrawOffset;
numPadStartX = keyboardStartX + (3+keyboardCharsPerRow)*keyboardBoxDim;

//Menu Page
createdMenu = false;

//Last Page
loadingNewGame = false;

//
//
function surface_create_check(surf, w, h) {
	if (!surface_exists(surf)) {
		return surface_create(w, h);
	}
	return surf;
}
