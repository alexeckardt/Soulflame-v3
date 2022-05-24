//
//DESC:
//
//
//
function inventory_page_flower_draw_effect_list(centreX, centreY){

	var list = Player.effectList;
	var c = ds_list_size(list);

	
	if (c != 0) {

		for (var i = 0; i < c; i++) {
		
			var off = i - ((c-1) / 2);
			var effect = list[| i];
			
			var xx = centreX + off*flowerCollectedListSpriteSep;
			
			flower_effect_draw(effect, xx, centreY);
		
		
			//
			//If Hovering Over
			if (i == flowerHoveringOverEffectNum) {
				if (flowerHoveringOverEffects) {
					
					//Position
					var w = flowerCollectedListSpriteSep;
						xx -= w div 2;
					var yy = centreY - w div 2;
	
					//Draw Border
					draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx,	yy,		1,	1,	0, highlightedColour, 1);
					draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx+w,	yy,		-1, 1,	0, highlightedColour, 1);
					draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx,	yy+w,	1,	-1,	0, highlightedColour, 1);
					draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx+w,	yy+w,	-1, -1, 0, highlightedColour, 1);
				}	
			}
		}
	
	} else {

		draw_set_font(fontKeira);
		draw_set_valign(fa_center);
		draw_set_halign(fa_center);
		
		var c = darkColour;
		
		draw_text_colour(centreX, centreY, flowerStringNoEffects, c, c, c, c, 1);
		
	}

}