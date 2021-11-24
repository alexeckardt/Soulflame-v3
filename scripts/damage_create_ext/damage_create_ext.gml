//
//DESC:
//
//
//
function damage_create_ext(_damageType, _damageValue, _xpos, _ypos, _xscale, _yscale){

	var dmg = damage_create(_damageType, _damageValue, _xpos, _ypos)
	dmg.image_xscale = _xscale;
	dmg.image_yscale = _yscale;
	
	return dmg;
}