//
//DESC:
//
//
//
function keira_geneirc_damage_create() {

	var dxx = x + damageCreateXoffset*directionFacing;
	var dyy = y + damageCreateYoffset;
				
	//Create The Damage Object
	damageObj = damage_create(damageCreateDamageType, damageCreateBaseDamage, dxx, dyy);
	damageObj.image_xscale = damageCreateWidth * sign(directionFacing+0.001);
	damageObj.image_yscale = damageCreateHeight;
				
	//Knockback Comes From Center Of Keira's Mass
	damageObj.knockbackAmount = damageKnockbackMulti;
	damageObj.knockbackFromX = x;
	damageObj.knockbackFromY = y - 4;
	
	//Add Vector
	damageObj.addToVSpeed = damageKnockbackAddVSpeed;
	if (damageKnockbackAddHspeedRelative) {
		damageObj.addToHSpeed = damageKnockbackAddHSpeed*directionFacing;} else {
		damageObj.addToHSpeed = damageKnockbackAddHSpeed;}
		
	damageObj.increasePlayerCorruption = damageToIncreaseCorruption;
	damageObj.collectEssence = damageToCollectEssence;

}