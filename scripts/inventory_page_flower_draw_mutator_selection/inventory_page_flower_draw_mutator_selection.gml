//
//DESC:
//
//
//
function inventory_page_flower_draw_mutator_selection(selectX, selectY) {

	var mutatorSpriteSep = sprite_get_width(mutatorSprite) + 2;
	
	for (var i = 0; i < mutatorCount; i++) {
		
		var indFromCenter = i - mutatorSelectedSmooth;
		
		if (indFromCenter < 3) {
		
			//Position
			var xx = selectX + mutatorSpriteSep*indFromCenter;
			var yy = selectY;
		
			var sc = 1 / (sqr(indFromCenter)+1);
		
			//Draw
			draw_sprite_ext(mutatorSprite, i, floor(xx), floor(yy),
				sc, sc, 0, c_white, 1);	
		
		}
		
	}
	
	
	
	//
	//Draw the Selection Box
	var w = flowerCollectedListSpriteSep;
	var xx = selectX - w div 2;
	var yy = selectY - w div 2;
	
	draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx,	yy,		1,	1,	0, highlightedColour, 1);
	draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx+w,	yy,		-1, 1,	0, highlightedColour, 1);
	draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx,	yy+w,	1,	-1,	0, highlightedColour, 1);
	draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx+w,	yy+w,	-1, -1, 0, highlightedColour, 1);
	//
	//

}