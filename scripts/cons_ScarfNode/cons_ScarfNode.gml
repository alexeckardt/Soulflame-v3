// @desc
//
//
//
function cons_ScarfNode(_x, _y) constructor {

	xx = _x;
	yy = _y;
	
	lastx = _x;
	lasty = _y;
	
	offsetDis = 2;
	offsetDir = 270;

	//
	//Move
	//
	static update_pos = function(lastX, lastY) {
		
		var t = Game.delta;
		
		//Get Speed
		var hSpeed = lastx - xx;
		var vSpeed = lasty - yy;

		var currentdir = point_direction(0, 0, hSpeed, vSpeed);
		var currentvel = point_distance(0, 0, hSpeed, vSpeed);
	
		var hSway = lengthdir_y(currentvel/2, currentdir) * sin(current_time/100);
		var vSway = lengthdir_x(currentvel/2, currentdir) * cos(current_time/100);
	
		//Get Total Direction
		var netDir = point_direction(0, 0, hSpeed + lengthdir_x(offsetDis, offsetDir), vSpeed + lengthdir_y(offsetDis, offsetDir));
		var netDis = point_distance(0, 0, hSpeed + lengthdir_x(offsetDis, offsetDir), vSpeed + lengthdir_y(offsetDis, offsetDir));

		//Choose New Position
		var goalX = lastX + lengthdir_x(netDis, netDir) + hSway //+ hSpeed;
		var goalY = lastY + lengthdir_y(netDis, netDir) + vSway //+ vSpeed;
	
		//Switch My Segment's Position
		var ls = 0.5*t;
		
		lastx = xx;
		lasty = yy
		
		xx = lerp(xx, goalX, ls);
		yy = lerp(yy, goalY, ls);
		
	};
	
	//
	//Change Direction
	//
	static update_spread = function(newdis, newdir) {
		
		//Pass and Set
		offsetDis = newdis;
		offsetDir = newdir;
		
	};

}