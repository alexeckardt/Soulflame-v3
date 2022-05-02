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
				
		//Time
		var t = Game.delta;
		
		//Get Speed
		var hSpeed = lastx - xx;
		var vSpeed = lasty - yy;
		var currentvel = point_distance(hSpeed, vSpeed, 0, 0);
		var currentdir = point_direction(hSpeed, vSpeed, 0, 0);

		//Base Position
		var disToGoal = point_distance(xx, yy, lastX, lastY);
		var realDis = offsetDis / (disToGoal+1);
		var fromLastOffsetX = lengthdir_x(realDis, offsetDir);
		var fromLastOffsetY = lengthdir_y(realDis, offsetDir);
	
		//Sway Amount
		var hSway = lengthdir_y(currentvel/2, currentdir) * sin(current_time/33);
		var vSway = lengthdir_x(currentvel/2, currentdir) * cos(current_time/100);

		//Choose New Position
		var goalX = lastX + fromLastOffsetX + hSway + hSpeed;
		var goalY = lastY + fromLastOffsetY + vSway + vSpeed;
	
		//Switch My Segment's Position
		var ls = 0.3*t;
		
		lastx = xx;
		lasty = yy

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