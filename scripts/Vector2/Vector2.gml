// @desc
//
//
//
function Vector2(_xx = 0, _yy = 0) constructor {

	//Stores
	xx = _xx;
	yy = _yy;

	//Methods
	static set = function(newx, newy) { xx = newx; yy = newy; };
	
	static dir = function() { return point_direction(0, 0, xx, yy); };
	
	static length = function() { return point_distance(0, 0, xx, yy); };
	
	static normalized = function() {
		var d = dir();
        return (new Vector2(lengthdir_x(1, d), lengthdir_y(1, d)));
    };
	
	static add = function(_vec2) {
        xx += _vec2.xx;
        yy += _vec2.yy;
    };


}