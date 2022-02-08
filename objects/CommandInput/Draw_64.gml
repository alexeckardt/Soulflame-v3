/// @desc

var guiH = Camera.view_height*4/Camera.zoom
display_set_gui_size(Camera.view_width*4/Camera.zoom, guiH);

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_font(fontKeira);

var tString = (!ranCommand) ? typingString : outputMessage;

//Poses and Such
var charHeight = string_height(tString);
var hintShowingHeightIncrease = (charHeight+3)*(commandHint != "");
var ww = max(string_width(tString)+2, string_width(commandHint)+2);

//Background
draw_sprite_ext(sPixel, 0, 5, guiH-5, ww, -charHeight-hintShowingHeightIncrease, 0, c_black, 0.7);

//Draw Text
var c = merge_colour(c_red, c_white, reccognizedCommand);
draw_text_colour(6, guiH-2, tString, c, c, c, c, 1);
draw_text_colour(6, guiH-2-charHeight-2, commandHint, c, c, c, c, 1);