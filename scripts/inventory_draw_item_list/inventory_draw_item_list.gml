//
//DESC:
//
//
//
function inventory_draw_item_list(sectionXs, yoff) {

	var list = itemList;
	var c = ds_list_size(list);
	
	//Loop
	for (var i = 0; i < c; i++) {
	
		//Get
		var struct = list[| i];
		
		//Get X
		var xx = struct.xx + sectionXs[struct.section];
		var yy = yoff + struct.yy;
		
		//Draw
		draw_sprite(struct.sprite, struct.index, xx, yy);
		
		//
		if (hoveringItemId == i) {
		
			draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx,				yy,				1, 1,	0, highlightedColour, 1);
			draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx+struct.sprw,	yy,				-1, 1,	0, highlightedColour, 1);
			draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx,				yy+struct.sprh,	1, -1,	0, highlightedColour, 1);
			draw_sprite_ext(sInventoryItemSelectionBorder, 0, xx+struct.sprw,	yy+struct.sprh, -1, -1, 0, highlightedColour, 1);
		
		}
		
		
	}

}