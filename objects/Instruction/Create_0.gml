/// @description

//CC
instructionKey = "";


//

surf = -1;

alpha = 0;
destroy = false;
freeze = false; //freeze player until completed

font = fontExcelsior;

createdInstructionText = false;

stringToDraw = "";
keybind_info_list = -1;

viewW = -1;

persistenceKey = -1; //is set

//Fadein
completed = false;
obstructionAlpha = 0;

u_threshold = shader_get_uniform(shd_ShowUnderValue, "threshold");

wipeSprite = sInstructionWipeMask;
tileWidth = 64;

