/// @description 
cellSize = 8;

var hc = room_width div cellSize;
var vc = room_height div cellSize;

//Grids
solid_grid = mp_grid_create(0, 0, hc, vc, cellSize, cellSize);
mp_grid_add_instances(solid_grid, PathfindVisible, true);


bkgGridCreated = true;
bkg_grid = mp_grid_create(0, 0, hc, vc, cellSize, cellSize);
mp_grid_add_instances(bkg_grid, AirBlocks, true);
