/// @description 
cellSize = 16;

var hc = room_width div cellSize;
var vc = room_height div cellSize;

grid = mp_grid_create(0, 0, hc, vc, cellSize, cellSize);

//
mp_grid_add_instances(grid, Solid, false);

//Copy To DsGrid
dsGrid = ds_grid_create(hc, vc);
mp_grid_to_ds_grid(grid, dsGrid);


for (var j = 0; j < vc; j++) {
	
	var str = "";
	for (var i = 0; i < hc; i++) {
	
		str += " " + string(dsGrid[# i, j]) + " ";
	
	}	
	
	show_debug_message(str);
}