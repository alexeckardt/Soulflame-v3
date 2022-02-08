/// @desc

typingString = "/";
lastTypingString = typingString; //Checks

lastCommandInputed = "";

commandHint = "";
outputMessage = "";

//
typingCommand = true;
runCommand = false;
ranCommand = false;

//Reset for Input
keyboard_string = "";
depth = Player.depth - 5;

//
checkedForCommandName = false;
reccognizedCommand = false;


//Finish Command
idleTimeBeforeDestroy = room_speed*2;
stillDrawingTicks = idleTimeBeforeDestroy;

event_user(0);