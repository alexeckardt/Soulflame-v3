//
//DESC:
//
//
//
function inventory_page_flower_draw_collect_list(centreX, centreY){

	var list = Player.flowersHave;
	var c = ds_list_size(list);

	for (var i = 0; i < c; i++) {
		
		var flowerId = list[| i];
		
		var indFromCenter = i - flowerCollectedHighlightingSmooth;
		
		//Position
		var xx = centreX + flowerCollectedListSpriteSep*indFromCenter*1.2 + indFromCenter;
		var yy = centreY + sqr(indFromCenter);
		
		//Selected Popup
		if (i = flowerCollectedHighlighting) 
			yy += selectedFlowerYoffset;
		
		//Draw
		//(floor so no jitters)
		draw_sprite(flowerCollectedListSprite, flowerId, floor(xx), floor(yy));	
		
	}
	
	
	//
	//Draw the Selection Box
	if (!flowerHoveringOverEffects) {
		var w = flowerCollectedListSpriteSep;
		var xx = centreX - w div 2;
		var yy = centreY - w div 2;
		
		draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx,	yy,		1,	1,	0, highlightedColour, 1);
		draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx+w,	yy,		-1, 1,	0, highlightedColour, 1);
		draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx,	yy+w,	1,	-1,	0, highlightedColour, 1);
		draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx+w,	yy+w,	-1, -1, 0, highlightedColour, 1);
	}
	//
	//
		
}