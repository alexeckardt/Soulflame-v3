//
//DESC:
//
//
//
function inventory_page_flower_draw_effect_list(centreX, centreY){

	var list = Player.effectList;
	var c = ds_list_size(list);

	for (var i = 0; i < c; i++) {
		
		var off = i - ((c-1) / 2);
		
		var effect = list[| i];
		flower_effect_draw(effect, centreX + off*flowerCollectedListSpriteSep, centreY);
		
	}

		
}