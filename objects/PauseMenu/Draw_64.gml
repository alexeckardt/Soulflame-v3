/// @description 
//
//--------------------------------------------------------------------------
//

//TempVariable Setup
var backgroundColour = $030303;

//Size
display_set_gui_size(displayWidth, displayHeight);


//Surface
if (!surface_exists(menuSurface)){
	menuSurface = surface_create(Camera.view_width + 2, Camera.view_height + 2);}
surface_set_target(menuSurface);


//Background Frame, Grey Scale and Darker
draw_clear_alpha(0, 0.2);


//Particles (Smoke & Embers)



//Page Text Background (Dimmer)



//Elements


//Exit
surface_reset_target();

//Draw Surface
draw_surface(menuSurface, 0, 0);