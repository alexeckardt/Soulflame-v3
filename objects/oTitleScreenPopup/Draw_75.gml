/// @description 

if (setBoxDimensions) {
	//Box
	draw_box_from_sprite(sMenuBorders, 1, boxX, boxY, w, h);
	draw_sprite(sMenuSettingsExitButton, hoveringOverClose, closeX, closeY);

	//Title
	draw_set_font(fontExcelsior);
	draw_set_halign(fa_middle);
	draw_set_valign(fa_top);
	draw_text(boxX + w/2, boxY+buffer, titleString);

	draw_set_font(baseFont);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(boxX + buffer, boxY+titleHeight+buffer*1.5, bodyString);
}