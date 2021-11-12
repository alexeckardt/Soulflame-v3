//
//DESC:
//
//Creates a Signle Hitbox, but option to switch it out. Use for objects and Keira, 
//who will ever only need one (dynamic) hitbox
//
function hitbox_create_alt(_hitboxObject, _Cx, _Cy, _width, _height, _isEllipse) {

	//Create the Hitbox
	var newHitbox = instance_create_depth(_Cx,_Cy, depth - 5, _hitboxObject);
	
	//Update Object
	newHitbox.creator = id;
	
	newHitbox.xoffset = _Cx - x;
	newHitbox.yoffset = _Cy - y;
	newHitbox.hitboxWidth = _width;
	newHitbox.hitboxHeight = _height;
	newHitbox.isEllipse = _isEllipse;
	
	//Return id of the hitbox
	return newHitbox;

}