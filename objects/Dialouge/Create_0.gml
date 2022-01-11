/// @description 

//
//When A Cutscene is created; it will create a companion Dialouge Object.
//When the Cutscene closes, so does the dialouge.
//
//Using the cutscene_dialouge_use function inside the scene_info,
//It will update the companion dialouge object with the text from a section.
//
//
//

textSection = "not_set";
sectionPart = 0;
sectionComplete = false;

//Setup
dialougeType = dialouge_type.base;
watingForSetup = true;
switchedSectionPart = true;

//To Update
dialougeTextInfo = [];
characters = [-1]; //in lang, character will be character 0.
					//this refers to the index of this array.
characterSprites = [];

//Answering
playerAnswer = false;
answerOptions = [];
lastPlayerResponse = -1;

//Return

//Visual
textToDisplay = "";
textDisplaying = "";
characterTalking = 0;
characterEmotion = 0;
autoHideOnceSectionComplete = false;
display = false;
characterZoom = 3;
textZoom = 4;

//Background
dialougeBottomFadePercent = 0;
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