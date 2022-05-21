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
		
			inventory_create_item_list();
			cursorX = w div 2;
			cursorY = h div 2;
			
			break;
		case 1:
			break;
		case 2:
			break;
		case 3:
			game_persistence_set("sword", 1);	
			break;
			
	}

	return 0;

}