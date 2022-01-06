/// @description 

var time = Game.delta;

x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);

//
//
//Create Path
//
if (active) {
	
	if (!createdPath) {
	
		//Clear Path
		if (path_exists(myPath)) {
			path_delete(myPath);
		
			//Reset
			myPath = path_add();
			pathFailed = true;
			atEndOfPath = false;
		}
	
		//Position Self
		x = creator.x;
		y = creator.y;
	
		//Distance Req
		var d = point_distance(x, y, goToX, goToY);
		if (d > 8) {
		
			//Create Path
			var pathMaker = mp_grid_path(Paths.grid, myPath, x, y, goToX, goToY, true);
		
			//Optimize; Avoid Solids at the first dfew points to prevent getting stuck
			if (airborne && tryToUnstuckAirborne) {
				
				var dsgrid = Paths.dsGrid;
				
				//Access Path Info
				var firstPointX		= path_get_point_x(myPath, 0);
				var firstPointY		= path_get_point_y(myPath, 0);
				var firstPointSp	= path_get_point_speed(myPath, 0);
				
				var xInGrid = clamp(firstPointX div 16, 1, ds_grid_width(dsgrid));
				var yInGrid = clamp(firstPointY div 16, 1, ds_grid_height(dsgrid));
				
				var xsum = 0;
				var ysum = 0;
				var tot = 0;
				
				for (var j = 0; j < 3; j++) {
					for (var i = 0; i < 3; i++) {
					
						//Get Surrounding Grid
						var tileInGrid = dsgrid[# xInGrid + i - 1, yInGrid + j - 1];
					
						//If There is to be a collision there
						if (tileInGrid == -1) {
							xsum += (i-1);
							ysum += (j-1);
							tot += 1;
						}
					
					}	
				}
				
				//If There is collision directly around to get stuck on
				if (tot != 0) {
					
					//Update The Path To Avoid Neighboring Solids (If Airel)
					path_change_point(myPath, 0, firstPointX - xsum*16/tot, firstPointY - ysum*16/tot, firstPointSp);
					
				}
				
			}
			
			//Path Exists?
			if (pathMaker) {
				createdPath = true;
	
				//If Path is not empty
				if (path_get_length(myPath) > 0) {
	
					//Start
					path_set_kind(myPath, 1);
					path_set_precision(myPath, 8);

					//Make Me Go Alittle
					path_start(myPath, 0, path_action_stop,	false);
					path_position = rangeTravel / path_get_length(myPath);
				
					//No Fail
					pathFailed = false;
					atEndOfPath = false;
					
				}
			} 
		} else {
			atEndOfPath = true;	
		}
	}
}

drawX = lerp(drawX, x, 0.02*time);
drawY = lerp(drawY, y, 0.02*time);
