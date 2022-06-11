function title_screen_draw_title(argument0, argument1, argument2, argument3) {

		var startY = argument3;
		var yy = argument0 + startY;
		var yybar = argument1;
		var val = argument2;

		var nX = x;
		var nY = y;
	
		draw_sprite_ext(sTitle, 0, nX, nY + yy,	 1, 1, 0, val, image_alpha);
		draw_sprite_ext(sTitle, 1, nX, nY + yybar + startY, 1, 1, 0, c_white, barAlpha);
		draw_sprite_ext(sTitle, 2, nX, nY - yybar + startY, 1, 1, 0, c_white, barAlpha);


}
