//
//DESC:
//
// Sets the attacking sprites and speeds, as well as the damage properties
//Decided in a keira_decide_attack_vars_xxxx call.
//
function keira_attacking_sprite_setup(_spr, _weaponspr, _spd, readyShow) {

	//Set Keira Vars
	attackSprite	= _spr;
	weaponSprite	= _weaponspr;
	attackSpeed		= _spd;
	
	//Visuals
	showReadyAfterAttackFor = readyShow;
	

	//
	//
	//
	
	//These should be per attack / per whole weapon state
	//As to simplify gameplay/intuition.
	//While there may be some exceptions, they are a lot more 'static'
	//than these PHYSICAL damage properties.
	
	
	//see keira_decide_attack_vars_no_weapon for more.
	
		//damageToCollectEssence = true;
		//damageToIncreaseCorruption = true;
}

//Temp
function keira_damage_update_struct(damageStruct, xoff, yoff, width, height, knockbackMuti, hSpeedAdd, vSpeedAdd, relativeHAdd) {
	
	damageStruct.xoff = xoff;
	damageStruct.yoff = yoff;
	damageStruct.w = width;
	damageStruct.h = height;
	
	damageStruct.knockback = knockbackMuti;
	damageStruct.knockbackAddH = hSpeedAdd;
	damageStruct.knockbackAddV = vSpeedAdd;
	
	damageStruct.knockbackHRelative = relativeHAdd;
}