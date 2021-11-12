//
//DESC:
//
//Create a hitbox, and adds it to an intended list.
//
function hitbox_create_for_list(_list, _Cx, _Cy, _width, _height, _isEllipse) {

	//Create the Hitbox
	var newHitbox = hitbox_create(_Cx, _Cy, _width, _height, _isEllipse);
	
	//Add To List
	ds_list_add(_list, newHitbox);
	
	//Return id if wants to be special
	return newHitbox;

}