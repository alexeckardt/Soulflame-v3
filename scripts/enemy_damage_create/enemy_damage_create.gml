//
//DESC:
//
//
//
function enemy_damage_create(type, _x, _y, w, h, lifeTicks, kbAmount) {

	var obj = damage_create(type, 1, _x, _y);

	var sprW = sprite_get_width(sDamageHitbox);
	obj.image_xscale = w / sprW;
	obj.image_yscale = h / sprW;

	obj.life = lifeTicks;
	
	obj.addToHSpeed = 0;
	obj.addToVSpeed = -1;
	
	return obj;

}