// @desc
//
//
//
function keybind_draw_controller_icon(xx, yy, keybind) {

	//Get
	var controllerIconId = keybind_get_controller_icon_sheet_id(keybind);
	
	//Position
	var iconww = 18;
	var iconX = controllerIconId mod iconww;
	var iconY = controllerIconId div iconww;
	
	//Draw
	var correctionX = -9;
	var correctionY = -18;
	draw_sprite_part(sControllerIconSheets, Controller.iconPage, iconX*iconww, iconY*iconww, iconww, iconww, xx+correctionX, yy+correctionY);

}