//
//DESC:
//
//
//
function EnvironmentObj(_xx, _yy) constructor {

	sprite = -1;
	index = 0;
	
	xx = _xx;
	yy = _yy;
	
	xscale = 1;
	yscale = 1;
	rot = 0;
	blend = c_white;
	alpha = 1;


	//Other
	index_speed = 0;
	sprNum = 1;
	orgX = _xx;
	orgY = _yy;
	
	shader = -1;
	
	sprWidth = -1;
	sprHeight = -1;
	
	topbbox = 0;
	rightbbox = 0;
	leftbbox = 0;
	bottombbox = 0;
	
	xoffset = 0;
	yoffset = 0;
	
	//
	//Store all sprite properties for later use
	static set_sprite = function(spr) {
		
		sprite = spr;
		
		sprWidth = sprite_get_width(spr);
		sprHeight = sprite_get_width(spr);
		
		topbbox = sprite_get_bbox_top(spr);
		rightbbox = sprite_get_bbox_right(spr);
		leftbbox = sprite_get_bbox_left(spr);
		bottombbox = sprite_get_bbox_bottom(spr);
		
		sprNum = sprite_get_number(spr);
	
		xoffset = sprite_get_xoffset(spr);
		yoffset = sprite_get_yoffset(spr);
		
	}
	
	static update = function(d, paralaxAmount, cX, cY, cW, cH) {
	
		//Increment Loop
		index += index_speed*d;
		index %= sprNum;
		
	
		//
		//Move Paralax
		//Calculate
		var xdiff = (cX - orgX + cW)*paralaxAmount;
		var ydiff = (cY - orgY + cH)*paralaxAmount;
	
		//Move
		xx = orgX - xdiff;
		yy = orgY - ydiff;
	
	}
		
}