//
//DESC:
//
//
//
function keira_geneirc_damage_create() {

	//Grab Struct
	var damageStruct = damageToCreateStruct;

	var dxx = x + damageStruct.xoff*directionFacing;
	var dyy = y + damageStruct.yoff;
				
	//Create The Damage Object
	damageObj = damage_create(damageStruct.damageType, damageStruct.damage, dxx, dyy);
	damageObj.image_xscale = damageStruct.w * sign(directionFacing+0.001);
	damageObj.image_yscale = damageStruct.h;
				
	//Knockback Comes From Center Of Keira's Mass
	damageObj.knockbackAmount = damageStruct.knockback;
	damageObj.knockbackFromX = x;
	damageObj.knockbackFromY = y - 4;
	
	//Add Vector
	damageObj.addToVSpeed = damageStruct.knockbackAddV;
	if (damageStruct.knockbackHRelative) {
		damageObj.addToHSpeed = damageStruct.knockbackAddH*directionFacing;} else {
		damageObj.addToHSpeed = damageStruct.knockbackAddH;}
		
	damageObj.increasePlayerCorruption = damageStruct.increaseCorruption;
	damageObj.collectEssence = damageStruct.collectEssence;

	//Remove
	damageToCreateStruct = -1;
	delete damageStruct;

}