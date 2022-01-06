/// @description 
var cellSize = 16;

var hc = room_width div cellSize;
var vc = room_height div cellSize;

grid = mp_grid_create(0, 0, hc, vc, cellSize, cellSize);

//
mp_grid_add_instances(grid, Solid, false);