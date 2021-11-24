//
//DESC:
//
//
//
function damage_create(_damageType, _damageValue, _x, _y) {

	//Create The Object
	var dmgObj = instance_create_depth(_x, _y, 100, oDamage);
	
	//Variables To Be Created With
	dmgObj.creator = id;
	
	dmgObj.damageType = _damageType;
	dmgObj.damage = _damageValue;
	dmgObj.xoffset = _x - x;
	dmgObj.yoffset = _y - y;
	
	//Return for More Object
	return dmgObj;

}