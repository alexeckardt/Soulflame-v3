// @desc
//
//
//
function weapon_draw(weaponId, x, y, sc, r, blend, alp) {

	if (weaponId >= 0) {	
		draw_sprite_ext(sWeaponIcons, weaponId, x, y, sc, sc, r, blend, alp);			
	}
}