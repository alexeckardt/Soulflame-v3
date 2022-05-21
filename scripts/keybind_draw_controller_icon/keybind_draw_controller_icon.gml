// @desc
//
//
//
function keybind_draw_controller_icon(xx, yy, keybind) {

	//Get
	var controllerIconId = keybind_get_controller_icon_sheet_id_from_string(keybind);
	
	//Position
	var iconww = 18;
	var iconX = controllerIconId mod iconww;
	var iconY = controllerIconId div iconww;
	
	//Draw
	draw_sprite_part(sControllerIconSheets, Controller.iconPage, iconX*iconww, iconY*iconww, iconww, iconww, xx, yy);

}