/// @description Init

//
//Cutscene Based off FriendlyCosmonaut's Tutorial System
//https://www.youtube.com/watch?v=2CLm38HCP64
//


scene_info		= -1;
scene			= 0;
skipCutscene	= false;

timer			= 0;
cutscene_id		= "c_";

myTrigger		= noone;

returnControlToPlayer = true;
moveToX = undefined;

//Setup
myDialogue = instance_create_depth(x, y, depth, Dialogue);
myDialogue.creator = id;

//Diverging Paths
optionSelected = -1;
optionSelectedText = "";

dead = false;

show_debug_message("Created New Cutscene!");
