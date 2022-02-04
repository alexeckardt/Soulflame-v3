//
//DESC:
//
//
//
function keira_stateaction_attack_running() {

	//Set Sprite
		sprite_switch_to(attackSprite);
		index_speed = attackSpeed;
		displayReadyPosForTime = room_speed;
		
		//Update Direction Facing
		if (image_index < 1.5) {
			
			if (adjustDirectionFacingPreDamage) {
				var h = Controller.horizontalStick;
				directionFacing = (h != 0) ? sign(h) : directionFacing;	
			}
			

		} else {
		
			//Create Damage
			if (!createdDamage) {
				createdDamage = true;
				
				keira_geneirc_damage_create();
				
				//Add Vector
				damageObj.addToVSpeed = damageKnockbackAddVSpeed;
				if (damageKnockbackAddHspeedRelative) {
					damageObj.addToHSpeed = damageKnockbackAddHSpeed*directionFacing;} else {
					damageObj.addToHSpeed = damageKnockbackAddHSpeed;}
			}
		
		}
		
		
		//
		//Set Attributes
		inControl = image_index > allowControlOverIndex;
		resetStateOnAnimationFinish = true;
		
		//Continue to Move During Attack
		if (image_index <= 2) {
			noControlMx = directionFacing;
		} 
}