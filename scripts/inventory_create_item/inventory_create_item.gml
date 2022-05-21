//
//DESC:
//
//
//
function inventory_create_item(key, sprite, index, section, xrel, yrel) {

	if (game_persistence_check(key) != undefined) {
	
		var struct = new InventoryDrawItem(key, sprite, index, section, xrel, yrel);
		ds_list_add(itemList, struct)
		return struct;
	}
	
	return 0;
}