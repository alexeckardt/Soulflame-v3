//
//DESC:
//
//Returns the IDD in the script
//
function inventory_check_item_hovering(){

	//Offsets
	var yoff = headerHeight + drawEdgeVBuffer;
	var list = itemList;
			
	//Check DS
	if (ds_exists(list, ds_type_list)) {
	
		//
		var c = ds_list_size(list);
	
		for (var i = 0; i < c; i++) {
	
			//Get
			var struct = list[| i];
		
			//See if insideY
			var yy = struct.yy + yoff;
			if (cursorY > yy-selectBuffer && cursorY < yy+struct.sprh+selectBuffer) {
			
				//Inside X as well?
				var xx = struct.xx + sectionPositions[struct.section];
				if (cursorX > xx-selectBuffer && cursorX < xx+struct.sprw+selectBuffer) {
					return i;
				}
			}
	
		}
	
		//Inside None
		return -1;
	
	}

}