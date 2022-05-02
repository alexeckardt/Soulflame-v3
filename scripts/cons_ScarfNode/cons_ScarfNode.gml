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
		
		//Save
		var hSpeed = lastx - xx;
		var vSpeed = lasty - yy;
	
		var hSway = 0;
		var vSway = 0;

		//Choose New Position
		var goalX = lastX + lengthdir_x(offsetDis, offsetDir) + hSawy;
		var goalY = lastY + lengthdir_y(offsetDis, offsetDir) + vSway;
	
		//Switch My Segment's Position
		var ls = 0.4*t;
		
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