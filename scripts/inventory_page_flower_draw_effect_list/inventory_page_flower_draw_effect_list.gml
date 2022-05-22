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
			flower_effect_draw(effect, centreX + off*flowerCollectedListSpriteSep, centreY);
		
		}
	
	} else {

		draw_set_font(fontKeira);
		draw_set_valign(fa_center);
		draw_set_halign(fa_center);
		
		var c = darkColour;
		
		draw_text_colour(centreX, centreY, flowerStringNoEffects, c, c, c, c, 1);
		
	}

		
}