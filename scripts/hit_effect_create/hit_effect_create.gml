//
//DESC:
//
//
//
function hit_effect_create(xx, yy, sc, col, rotate, type) {

	//Obj
	var obj = instance_create_depth(xx, yy, depth - 100, oHitEffect);

	obj.col = col;
	obj.angle = rotate;
	obj.sc = sc;
	
	obj.damageType = type;

	return obj;
	
}