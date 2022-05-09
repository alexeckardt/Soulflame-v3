/// @description 

var time = Game.delta;

x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);

//Clean Up Self
if (!instance_exists(creator)) {
	instance_destroy();	}

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
		if (instance_exists(creator)) {
			x = creator.x;
			y = creator.y;
			
		} else {
		
			instance_destroy();
		
		}
	
		//Distance Req
		var d = point_distance(x, y, goToX, goToY);
		if (d > 8) {
		
				//Create Path
				if (path_exists(myPath)) {
				var pathMaker = mp_grid_path(Paths.grid, myPath, x, y, goToX, goToY, true);
		
		
				//Optimize
				if (deleteUnneccesaryPoints) {
					
					//Access Path Info
					
					var points = path_get_number(myPath);;
					for (var i = 1; i < points-1; i++) { //-1 becayse 
	
						var lastPointX		= path_get_point_x(myPath, i-1);
						var lastPointY		= path_get_point_y(myPath, i-1);
						
						var nextPointX		= path_get_point_x(myPath, i+1);
						var nextPointY		= path_get_point_y(myPath, i+1);
		
						//Check If Colliding There
						if (!collision_line(lastPointX, lastPointY, nextPointX, nextPointY, Solid, 1, 1)) {
						
							//If too close
							var dis = point_distance(lastPointX, lastPointY, nextPointX, nextPointY);
							if (dis < pathPointsSignificantDistance) {
							
								//Marker Pointless
								path_delete_point(myPath, i);
								i--;
								points--;
								
							}
							
						}
					}

				}
		
				if (pushFirstPointBasedOnCreatorFatness) {
					
					var firstPointX		= path_get_point_x(myPath, 0);
					var firstPointY		= path_get_point_y(myPath, 0);
					var firstPointSp	= path_get_point_speed(myPath, 0);
					
					var bbox_w = abs(creator.bbox_right - creator.bbox_left)
					var offset = creator.directionFacing * bbox_w div 4; // small enough amount
					
					path_change_point(myPath, 0, firstPointX + offset, firstPointY, firstPointSp);
					
					
				}
		
		
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
			
			
				//
				//Attempt and Find Landable Platforms Near Any Airborne Points
				//
				if (!airborne) {
					
					var points = path_get_number(myPath);
					for (var i = 1; i < points-1; i++) {
	
						var pointX		= path_get_point_x(myPath, i);
						var pointY		= path_get_point_y(myPath, i);
						var pointSpd	= path_get_point_speed(myPath, i);
						
						var addedNewPoint = false;
						
						//Check If In Air
						if (!position_meeting(pointX, pointY + 16, Solid)) {
						
							for (var dir = -2; dir < 3; dir++) {
								
								if (!addedNewPoint && dir != 0) {
									
									//Check If There is a solid next to point (either side)
									if (position_meeting(pointX + 16*dir, pointY, Solid)) {
									
										//Loop
										for (var j = 1; j < platformDetectEmptyWithinTiles; j++) {
										
											//See if solid ends above me
											if (!position_meeting(pointX + 16*dir, pointY - j*16, Solid)) {
										
												//Add if does, landable position
												path_insert_point(myPath, i+1, pointX + 16*dir, pointY - j*16, pointSpd);
										
												//reccognize point!
												addedNewPoint = true;
												i++;
												break;
										
											}
										
										}
									
									}	
								}
	
							}
							
						}
					}

				
				
				
				}
				//
				//
				//
				//
				

			
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
}

drawX = lerp(drawX, x, 0.02*time);
drawY = lerp(drawY, y, 0.02*time);
