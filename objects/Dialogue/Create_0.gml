/// @description 

//
//When A Cutscene is created; it will create a companion Dialogue Object.
//When the Cutscene closes, so does the Dialogue.
//
//Using the cutscene_Dialogue_use function inside the scene_info,
//It will update the companion Dialogue object with the text from a section.
//
//
//

textSection = "not_set";
sectionPart = 0;
sectionComplete = false;

//Setup
DialogueType = Dialogue_type.base;
watingForSetup = true;
switchedSectionPart = true;

//Dialogue Text
DialogueTextInfo = [];


//Characters
characters = ds_map_create();
characterOrder = []
characterCount = 0;
leftGroupSize = 0;

//Answering
askingQuestion = false;
answerOptions = [];
lastPlayerResponse = -1;
playerOptionHoveringOver = -1;

//Return

//Visual
textToDisplay = "";
textDisplaying = "";
effectTimer = 0;
effectList = ds_list_create();
updateTexts = false;
displayFont = fontKeira;

//Textbox
textboxToBeOpen = false; //wil open close in and out based on this
textboxOpenTicks = 0;
textboxOpeningDelay = room_speed / 8;

textLines = [""]
maxLinesPossible = 4;
textBoxWidth = floor(Camera.view_width / 1.5);
textboxTextBuffer = 8;
maxLineLength = textBoxWidth - 2*textboxTextBuffer;
longestLineWidth = 0;
textboxHeight = 0;
textboxJustOpened = true;
textboxWritingLines = 0;
textboxHeightExpanded = false;
lineHeight = 0;

cameraScreenWidth = Camera.view_width;

centerX = cameraScreenWidth div 2;
textboxCenterX = centerX;
textboxGoalX = textboxCenterX;

textboxTalkingY		=  Camera.view_height * 0.9;
textboxQuestionY	=  Camera.view_height * 0.3;
textboxY			=  textboxTalkingY;
textboxGoalY		= textboxTalkingY;

speechBubbleColour = merge_colour(c_dkgray, 0, 0.9);
textColour = c_white;

//Timers
cutoff = 0;
cutoffContinuous = 0; //Even After
timer = 0;
textSpeed = 0.3;

characterTalking = noone;
characterEmotion = 0;
autoHideOnceSectionComplete = false;
display = false;
characterPixelGoalSize = 6;
textZoom = 4;
characterEdgeGoalPositions = 0.20; //this far away from edge of screen


//Pointer
pointerX = textboxCenterX;
pointerGoalX = 0;
pointerWidth = 8;
pointerYSc = 0;

//Name
nameX = textboxCenterX;
pointerNameBuffer = 16;

totalLeftSpriteWidth = 0;
totalRightSpriteWidth = 0;

//Background
DialogueBottomFadePercent = 0;
bottomFadeSections = 40;
bottomFadeColour = c_black;
bottomFadeHeight = 0.75;

//To Die
toDie = false;

//openn
if (Game.someUIopen) {
	show_debug_message("SOME OTHER UI IS OPEN!!");
}
Game.someUIopen = true;