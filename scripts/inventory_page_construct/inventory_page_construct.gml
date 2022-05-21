//
//DESC:
//
//
//
function inventory_page_construct(page){

	var w = display_get_gui_width();
	var h = display_get_gui_height();

	switch page {
		
		case 0:
		
			//Reset
			inventory_create_item_list();
			cursorX = w div 2;
			cursorY = h div 2;
			
			break;
		case 1:
			break;
		case 2:
			break;
		case 3:

			//Reset Position
			flowerCollectedHighlightingSmooth = -1
			flowerCollectedHighlighting = -1;
			
			break;
			
	}

	return 0;

}