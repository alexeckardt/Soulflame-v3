//
//DESC:
//
//
//
function keira_stateaction_attack_regular(){

	//Set Sprite
		sprite_switch_to(attackSprite);
		index_speed = attackSpeed;
		displayReadyPosForTime = showReadyAfterAttackFor;
		
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
				
			}
		
		}
		
		//
		//Set Attributes
		inControl = image_index > allowControlOverIndex;
		resetStateOnAnimationFinish = true;

}