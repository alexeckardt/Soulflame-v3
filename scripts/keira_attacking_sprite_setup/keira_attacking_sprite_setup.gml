//
//DESC:
//
// Sets the attacking sprites and speeds, as well as the damage properties
//Decided in a keira_decide_attack_vars_xxxx call.
//
function keira_attacking_sprite_setup(_spr, _weaponspr, _spd, _damage, _damageType, _damageArrayInfo) {

	//Set Keira Vars
	attackSprite	= _spr;
	weaponSprite	= _weaponspr;
	attackSpeed		= _spd;
	
	//Damage Vars Based off Info Given
	damageCreateBaseDamage = _damage;
	damageCreateDamageType = _damage;
	
	var i = 0;
	damageCreateXoffset	= _damageArrayInfo[i++];
	damageCreateYoffset	= _damageArrayInfo[i++];
	damageCreateWidth	= _damageArrayInfo[i++];
	damageCreateHeight	= _damageArrayInfo[i++];
	damageKnockbackMulti = _damageArrayInfo[i++];
	damageKnockbackAddHSpeed = _damageArrayInfo[i++];
	damageKnockbackAddVSpeed = _damageArrayInfo[i++];
	damageKnockbackAddHspeedRelative = _damageArrayInfo[i++];

}

//Temp
function keira_damage_info_array_create(xoff, yoff, width, height, knockbackMuti, hSpeedAdd, vSpeedAdd, relativeHAdd) {
	
	return [xoff, yoff, width, height, knockbackMuti, hSpeedAdd, vSpeedAdd,relativeHAdd];	
}