//
//DESC:
//
//
//
function LinkedSpriteNode(spr, ind, _x, _y, spd) constructor {

	sprite = spr;
	index = ind;
	xx = _x;
	yy = _y;
	
	xscale = 1;
	yscale = 1;
	
	angle = 0;
	blend = c_white;
	alpha = 1;
	
	index_speed = spd;
	index_num = sprite_get_number(spr);

	static animate = function(spd = index_speed) {
		var newInd = (index + spd) % index_num;
		index = newInd;
	}

	static draw = function() {
		draw_sprite_ext(sprite, index, xx, yy, xscale, yscale, angle, blend, alpha);		
	}

}