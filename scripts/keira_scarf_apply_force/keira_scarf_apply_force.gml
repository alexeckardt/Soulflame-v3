// @desc
//
//
//
function keira_scarf_apply_force(str, dir) {

	var scarf = oKeira.scarfId;
	if (instance_exists(scarf)) {
		scarf.netForce.add(new Vector2(lengthdir_x(str, dir), lengthdir_y(str, dir)));
	}

}