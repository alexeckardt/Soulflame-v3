/// @desc Instance Spawning

var c = Controller.id;

if (c.pausePressed) {
	
	//Toggle
	paused = !paused;
	
	//
	//Paused
	if (paused) {
		
		//Create Pause
		if (!instance_exists(pauseMenuObj)) {
			pauseMenuObj = instance_create_depth(x, y, 0, PauseMenu);	
		}
			
	} else {
		
		//Close and Dereference
		pauseMenuObj.close = true;
		pauseMenuObj = noone;

	}	
}

//
//
//

if (c.inventoryPressed || c.mapPressed) {
	
	var pageTo = c.mapPressed
	
	//Spawn Inventory
	if (!inventoryOpen) {
		
		//
		//Delete any Inventories
		if (instance_exists(InventoryUI)) {
			with (InventoryUI) {
				instance_destroy();	
			}
		}
		
		//Summon New One
		inventoryObj = instance_create_depth(x, y, Player.depth - 10, InventoryUI);	
		inventoryObj.page = pageTo; //0 if inventory, 1 if map
		inventoryObj.pageLast = pageTo;
				
		//Reccognize
		inventoryOpen = true;
	
	//
	//Despawn OR Switch Page
	} else {
		
		//Check to Only Switch instead of close
		var closeinven = true;
		if (instance_exists(inventoryObj)) {
		
			//Switch Inventory Page
			if (inventoryObj.page != pageTo) {
			
				//0 if inventory, 1 if map
				inventoryObj.page = pageTo; 

				
				//Do not close Inventory
				closeinven = false;
				
			}
		}

		//
		//Close Inventory
		if (closeinven) {
			
			//Set to Close
			if (instance_exists(inventoryObj)) {
				inventoryObj.close = true;
			}
			
			//Dereference
			inventoryObj = noone;
			inventoryOpen = false;
			
		}
	
	}
	
}

//
//
someUIopen = paused || inventoryOpen;
